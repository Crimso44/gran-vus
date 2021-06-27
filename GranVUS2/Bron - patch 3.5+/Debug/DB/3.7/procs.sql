ALTER FUNCTION [dbo].[GetSubjMask] (@kodterr varchar(25))
RETURNS varchar(25)
AS  
BEGIN 
DECLARE  @result varchar(25),  @n int

  SET @result = REVERSE(CAST(CAST(REVERSE(@kodterr) as numeric(25)) as varchar(25))) -- Trim zeros
  
  SET @result = @result + --add trailing zeros to last part of code
  CASE LEN(@result) 
    WHEN 0 THEN ''
    WHEN 1 THEN '0'
    WHEN 2 THEN ''
    ELSE CASE (LEN(@result)-2) % 3
      WHEN 1 THEN '00'
      WHEN 2 THEN '0'
      ELSE ''
    END
  END+'%'

  RETURN @result
END
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлена функция GetSubjMask'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFSClear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FFSClear]
GO

CREATE  PROCEDURE [dbo].[sp_FFSClear] 
	@SUBJ_ID	int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
	DELETE FROM FFS
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 50100 'Невозможно удалить форму по видам собственности.'
		ROLLBACK TRANSACTION
		return
	end
COMMIT TRANSACTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена хранимая процедура sp_FFSClear'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFSGenerate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FFSGenerate]
GO

CREATE   PROCEDURE [dbo].[sp_FFSGenerate] 
	@SUBJ_ID	int,
	@FilterType	int
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from v_ORG_CALC

    insert into [dbo].[#SubjSet] 
    select Subj_Id from v_Subj_Calc
  end

  if @FilterType=1 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org join KTerr on Org.Terr_Id=KTerr.Terr_Id
    where KTerr.KodTerr LIKE
    ( select  dbo.GetSubjMask(KTERR.KODTERR)
      from CURR_SUBJ
      join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID
      join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)
    and OrgId in (SELECT ORGID FROM v_ORG_CALC)

    insert into [dbo].[#SubjSet] 
    select Subj_Id from Subj join KTerr on Subj.Terr_Id=KTerr.Terr_Id
    where Subj_Id in (select * from v_Subj_Calc) and KTerr.KodTerr LIKE
    ( select  dbo.GetSubjMask(KTERR.KODTERR)
      from CURR_SUBJ
      join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID
      join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)
   end;

  if @FilterType=2
    insert into [dbo].[#OrgSet]
    select OrgId from OrgSet where OrgId in (SELECT ORGID FROM v_ORG_CALC)


  DELETE FROM FFS
  WHERE SUBJ_ID = @SUBJ_ID

  if @@ERROR != 0
  begin
    raiserror 50300 'Невозможно создать форму по видам собственности.'
    ROLLBACK TRANSACTION
    return
  end

  INSERT INTO FFS(
    SUBJ_ID
  , FS_ID  
  , FS_NAME
  , KOD
  , WHOLE  
  , WU     
  , BRON   
  , TOWN_WHOLE    
  , TOWN_WU       
  , TOWN_BRON     
  , VILLAGE_WHOLE 
  , VILLAGE_WU    
  , VILLAGE_BRON  
  )
  SELECT @SUBJ_ID, K.FS_ID, K.FS_NAME, K.KOD
  , NULLIF(COUNT(O.ORGID),0)   AS WHOLE
  , NULLIF(SUM(CAST(O.HAS_WU AS Int)),0)    AS WU
  , NULLIF(SUM(CAST(O.HAS_BRON AS Int)),0)  AS BRON
  , NULLIF(SUM(CASE O.PLACE WHEN 1 THEN 1 ELSE 0 END),0)    AS TOWN_WHOLE
  , NULLIF(SUM(CASE O.PLACE WHEN 1 THEN O.HAS_WU ELSE 0 END),0)    AS TOWN_WU
  , NULLIF(SUM(CASE O.PLACE WHEN 1 THEN O.HAS_BRON ELSE 0 END),0)  AS TOWN_BRON
  , NULLIF(SUM(CASE O.PLACE WHEN 2 THEN 1 ELSE 0 END),0) AS VILLAGE_WHOLE
  , NULLIF(SUM(CASE O.PLACE WHEN 2 THEN O.HAS_WU ELSE 0 END),0)    AS VILLAGE_WU
  , NULLIF(SUM(CASE O.PLACE WHEN 2 THEN O.HAS_BRON ELSE 0 END),0)  AS VILLAGE_BRON
  FROM KFS_ K LEFT OUTER JOIN
       (select 
          OO.ORGID
        , FS_ID = CASE WHEN OO.FS_ID IN (SELECT FS_ID FROM KFS_)
                  THEN OO.FS_ID ELSE 0 END
        , OO.HAS_BRON
        , HAS_WU = CASE WHEN EXISTS(SELECT * FROM FORM6HDR, FORM6
                                     WHERE FORM6HDR.OrgID=OO.ORGID
                                       AND FORM6.F6_ID=FORM6HDR.F6_ID 
                                       AND FORM6.COL_B=26
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0)
                   THEN 1 ELSE 0 END
        , PLACE = CASE SUBSTRING(ISNULL(OO.KODREG,0),6,1) 
                    WHEN '3' THEN 1
                    WHEN '5' THEN 1
                    WHEN '6' THEN 1
                    WHEN '8' THEN 2 
                    WHEN '9' THEN 2 
                    ELSE 0 END  
        from v_ORG OO 
        where OO.OUT_DATE IS NULL
          AND OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
       ) O ON (O.FS_ID = K.FS_ID)
  GROUP BY K.FS_ID, K.FS_NAME, K.KOD

  if @@ERROR != 0
  begin
	raiserror 50301 'Невозможно создать форму по видам собственности.'
	ROLLBACK TRANSACTION
	return
  end

  UPDATE FFS SET	
    WHOLE         = S.SUM_WHOLE         
  , WU            = S.SUM_WU            
  , BRON          = S.SUM_BRON          
  , TOWN_WHOLE    = S.SUM_TOWN_WHOLE    
  , TOWN_WU       = S.SUM_TOWN_WU       
  , TOWN_BRON     = S.SUM_TOWN_BRON     
  , VILLAGE_WHOLE = S.SUM_VILLAGE_WHOLE 
  , VILLAGE_WU    = S.SUM_VILLAGE_WU    
  , VILLAGE_BRON  = S.SUM_VILLAGE_BRON  
  FROM (
	SELECT
	FS_ID, 
        NULLIF(SUM(WHOLE),0) AS SUM_WHOLE,
        NULLIF(SUM(WU),0) AS SUM_WU,
        NULLIF(SUM(BRON),0) AS SUM_BRON,
        NULLIF(SUM(TOWN_WHOLE),0) AS SUM_TOWN_WHOLE,
        NULLIF(SUM(TOWN_WU),0) AS SUM_TOWN_WU,
        NULLIF(SUM(TOWN_BRON),0) AS SUM_TOWN_BRON,
        NULLIF(SUM(VILLAGE_WHOLE),0) AS SUM_VILLAGE_WHOLE,
        NULLIF(SUM(VILLAGE_WU),0) AS SUM_VILLAGE_WU,
        NULLIF(SUM(VILLAGE_BRON),0) AS SUM_VILLAGE_BRON
	FROM FFS
	WHERE (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
	GROUP BY FS_ID
	) S
  WHERE S.FS_ID = FFS.FS_ID AND FFS.SUBJ_ID=@SUBJ_ID

	if @@ERROR != 0
	begin
		raiserror 50302 'Невозможно создать форму по видам собственности.'
		ROLLBACK TRANSACTION
		return
	end
COMMIT TRANSACTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена хранимая процедура sp_FFSGenerate'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFSCreate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FFSCreate]
GO

CREATE    PROCEDURE [dbo].[sp_FFSCreate] 
	@SUBJ_ID	int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
	DELETE FROM FFS
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 50200 'Невозможно создать форму по видам собственности.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO FFS(SUBJ_ID, FS_ID, FS_NAME, KOD)
	SELECT @SUBJ_ID, FS_ID, FS_NAME, KOD FROM KFS_
	if @@ERROR != 0
	begin
		raiserror 50201 'Невозможно создать форму по видам собственности.'
		ROLLBACK TRANSACTION
		return
	end
COMMIT TRANSACTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена хранимая процедура sp_FFSCreate'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVEDClear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOKVEDClear]
GO

CREATE PROCEDURE [dbo].[sp_FOKVEDClear] 
	@SUBJ_ID	int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
	DELETE FROM FOKVED
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 50100 'Невозможно удалить форму по видам экономической деятельности.'
		ROLLBACK TRANSACTION
		return
	end
COMMIT TRANSACTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена хранимая процедура sp_FOKVEDClear'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVEDCreate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOKVEDCreate]
GO

CREATE  PROCEDURE [dbo].[sp_FOKVEDCreate] 
	@SUBJ_ID	int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
	DELETE FROM FOKVED
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 50200 'Невозможно создать форму по видам экономической деятельности.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO FOKVED(SUBJ_ID, OKVED_SECTION)
	SELECT @SUBJ_ID, OKVED_SECTION FROM KOKVED_
	if @@ERROR != 0
	begin
		raiserror 50201 'Невозможно создать форму по видам экономической деятельности.'
		ROLLBACK TRANSACTION
		return
	end
COMMIT TRANSACTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена хранимая процедура sp_FOKVEDCreate'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVEDGenerate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOKVEDGenerate]
GO

CREATE     PROCEDURE [dbo].[sp_FOKVEDGenerate] 
	@SUBJ_ID	int,
	@IS_FULL	bit,
	@FilterType	int
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from v_ORG_CALC

    insert into [dbo].[#SubjSet] 
    select Subj_Id from v_Subj_Calc
  end

  if @FilterType=1 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org join KTerr on Org.Terr_Id=KTerr.Terr_Id
    where KTerr.KodTerr LIKE
    ( select  dbo.GetSubjMask(KTERR.KODTERR)
      from CURR_SUBJ
      join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID
      join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)
    and OrgId in (SELECT ORGID FROM v_ORG_CALC)

    insert into [dbo].[#SubjSet] 
    select Subj_Id from Subj join KTerr on Subj.Terr_Id=KTerr.Terr_Id
    where Subj_Id in (select * from v_Subj_Calc) and KTerr.KodTerr LIKE
    ( select  dbo.GetSubjMask(KTERR.KODTERR)
      from CURR_SUBJ
      join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID
      join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)
   end;

if @FilterType=2
  insert into [dbo].[#OrgSet]
  select OrgId from OrgSet where OrgId in (SELECT ORGID FROM v_ORG_CALC)

	DELETE FROM FOKVED
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 50300 'Невозможно создать форму по видам экономической деятельности.'
		ROLLBACK TRANSACTION
		return
	end

	INSERT INTO FOKVED([SUBJ_ID], [OKVED_SECTION]
        , [ORG_COUNT]
        , [ORG_BRON_COUNT]
        , [ORG_WU_COUNT]
        , [RAB_COUNT]
        , [ZAP_COUNT]
        , [ZAB_COUNT])
	SELECT @SUBJ_ID, K.OKVED_SECTION,
          NULLIF(COUNT(O.ORGID),0) AS ORG_COUNT,
          NULLIF(SUM(CAST(O.HAS_BRON AS Int)),0) AS ORG_BRON_COUNT,
          NULLIF(SUM(O.HAS_WU),0)  AS ORG_WU_COUNT,
	  NULLIF(SUM(O.RAB_COUNT),0) AS RAB_COUNT,
	  NULLIF(SUM(O.ZAP_COUNT),0) AS ZAP_COUNT,
	  NULLIF(SUM(O.ZAB_COUNT),0) AS ZAB_COUNT
	  FROM KOKVED_ K LEFT OUTER JOIN
               (select 
                  OO.ORGID
                , OO.HAS_BRON
                , OO.RAB_COUNT
                , OO.ZAP_COUNT
                , OO.ZAB_COUNT 
                , HAS_WU = CASE WHEN EXISTS(SELECT * FROM FORM6HDR, FORM6
                                             WHERE FORM6HDR.OrgID=OO.ORGID
                                               AND FORM6.F6_ID=FORM6HDR.F6_ID 
                                               AND FORM6.COL_B=26
                                               AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0)
                           THEN 1 ELSE 0 END  
                , OKVED_FIRST = CASE WHEN (OO.MainOKONH LIKE '[0-9][0-9]' OR OO.MainOKONH LIKE '[0-9][0-9].%')
                                      AND EXISTS( SELECT * FROM KOKVED WHERE
                                                CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int) BETWEEN OKVED_BEGIN AND OKVED_END)
                                THEN CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int)
                                ELSE 0 END
                  from v_ORG OO 
                 where OO.OUT_DATE IS NULL
	           AND (@IS_FULL = 1 OR OO.F6CHECKED = 1)
                   AND OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	       ) O ON (O.OKVED_FIRST BETWEEN K.OKVED_BEGIN AND K.OKVED_END)
	GROUP BY K.OKVED_SECTION

	if @@ERROR != 0
	begin
		raiserror 50301 'Невозможно создать форму по видам экономической деятельности.'
		ROLLBACK TRANSACTION
		return
	end

	UPDATE FOKVED
	SET	
		ORG_COUNT      = S.SUM_ORG_COUNT,
		ORG_BRON_COUNT = S.SUM_ORG_BRON_COUNT,
		ORG_WU_COUNT   = S.SUM_ORG_WU_COUNT,
                RAB_COUNT      = S.SUM_RAB_COUNT,
		ZAB_COUNT      = S.SUM_ZAB_COUNT,
		ZAP_COUNT      = S.SUM_ZAP_COUNT
	FROM (
		SELECT
		OKVED_SECTION, 
                NULLIF(SUM(ORG_COUNT),0) AS SUM_ORG_COUNT,
                NULLIF(SUM(ORG_BRON_COUNT),0) AS SUM_ORG_BRON_COUNT,
                NULLIF(SUM(ORG_WU_COUNT),0) AS SUM_ORG_WU_COUNT,
		NULLIF(Sum(RAB_COUNT),0) AS SUM_RAB_COUNT,
		NULLIF(Sum(ZAP_COUNT),0) AS SUM_ZAP_COUNT,
		NULLIF(Sum(ZAB_COUNT),0) AS SUM_ZAB_COUNT
		FROM FOKVED
		WHERE (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
		GROUP BY OKVED_SECTION
	) S
	WHERE S.OKVED_SECTION = FOKVED.OKVED_SECTION AND FOKVED.SUBJ_ID=@SUBJ_ID

	if @@ERROR != 0
	begin
		raiserror 50302 'Невозможно создать форму по видам экономической деятельности.'
		ROLLBACK TRANSACTION
		return
	end
COMMIT TRANSACTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена хранимая процедура sp_FOKVEDGenerate'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHECK_F6]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CHECK_F6]
GO

CREATE PROCEDURE CHECK_F6 AS

UPDATE form6hdr
   SET CHECKED = CASE WHEN F6_ID in(
                    SELECT f6.F6_ID
                      FROM FORM6 f6
                     WHERE
                           ISNULL(COL_1,0) <  ISNULL(COL_2,0)+ISNULL(COL_15,0)
                        OR ISNULL(COL_2,0) <> ISNULL(COL_3,0)+ISNULL(COL_4,0)+ISNULL(COL_5,0)
                        OR ISNULL(COL_2,0) <  ISNULL(COL_7,0)
                        OR ISNULL(COL_2,0) <  ISNULL(COL_7,0)+ISNULL(COL_14,0)
                        OR ISNULL(COL_3,0) <  ISNULL(COL_8,0)
                        OR ISNULL(COL_4,0)+ISNULL(COL_5,0) <  ISNULL(COL_9,0)+ISNULL(COL_10,0)+ISNULL(COL_11,0)+ISNULL(COL_12,0)+ISNULL(COL_13,0)
                        OR ISNULL(COL_4,0)+ISNULL(COL_5,0) <  ISNULL(COL_6,0)
                        OR ISNULL(COL_7,0) <> ISNULL(COL_8,0)+ISNULL(COL_9,0)+ISNULL(COL_10,0)+ISNULL(COL_11,0)+ISNULL(COL_12,0)+ISNULL(COL_13,0)
                    UNION
                    SELECT F6_ID FROM (
                    SELECT
                           f6.F6_ID
                         , n_1  = SUM(ISNULL(sf6.COL_1,0)) - ISNULL(f6.COL_1,0)
                         , n_2  = SUM(ISNULL(sf6.COL_2,0)) - ISNULL(f6.COL_2,0)
                         , n_3  = SUM(ISNULL(sf6.COL_3,0)) - ISNULL(f6.COL_3,0)
                         , n_4  = SUM(ISNULL(sf6.COL_4,0)) - ISNULL(f6.COL_4,0)
                         , n_5  = SUM(ISNULL(sf6.COL_5,0)) - ISNULL(f6.COL_5,0)
                         , n_6  = SUM(ISNULL(sf6.COL_6,0)) - ISNULL(f6.COL_6,0)
                         , n_7  = SUM(ISNULL(sf6.COL_7,0)) - ISNULL(f6.COL_7,0)
                         , n_8  = SUM(ISNULL(sf6.COL_8,0)) - ISNULL(f6.COL_8,0)
                         , n_9  = SUM(ISNULL(sf6.COL_9,0)) - ISNULL(f6.COL_9,0)
                         , n_10 = SUM(ISNULL(sf6.COL_10,0))- ISNULL(f6.COL_10,0)
                         , n_11 = SUM(ISNULL(sf6.COL_11,0))- ISNULL(f6.COL_11,0)
                         , n_12 = SUM(ISNULL(sf6.COL_12,0))- ISNULL(f6.COL_12,0)
                         , n_13 = SUM(ISNULL(sf6.COL_13,0))- ISNULL(f6.COL_13,0)
                         , n_14 = SUM(ISNULL(sf6.COL_14,0))- ISNULL(f6.COL_14,0)
                         , n_15 = SUM(ISNULL(sf6.COL_15,0))- ISNULL(f6.COL_15,0)
                         , HasSelf = CASE WHEN CHARINDEX('+'+CAST(f6.CPROF_ID AS VarChar)+'+',f6.ExpPlus) > 0
                                          THEN 1 ELSE 0 END
                      FROM (SELECT *, ExpPlus = '+'+ISNULL(EXPRESSION,'')+'+' FROM FORM6) f6 LEFT OUTER JOIN
                           FORM6 sf6 ON sf6.F6_ID=f6.F6_ID
                                    AND sf6.CPROF_ID<>f6.CPROF_ID
                                    AND CHARINDEX('+'+CAST(sf6.CPROF_ID AS VarChar)+'+',f6.ExpPlus) > 0
                     WHERE f6.ExpPlus<>'++'
                     GROUP BY
                           f6.F6_ID
                         , f6.CPROF_ID
                         , f6.COL_1
                         , f6.COL_2
                         , f6.COL_3
                         , f6.COL_4
                         , f6.COL_5
                         , f6.COL_6
                         , f6.COL_7
                         , f6.COL_8
                         , f6.COL_9
                         , f6.COL_10
                         , f6.COL_11
                         , f6.COL_12
                         , f6.COL_13
                         , f6.COL_14
                         , f6.COL_15
                         , f6.ExpPlus
                    ) f6
                     WHERE 1= CASE WHEN (HasSelf = 1
                                     AND (n_1 > 0
                                       OR n_2 > 0
                                       OR n_3 > 0
                                       OR n_4 > 0
                                       OR n_5 > 0
                                       OR n_6 > 0
                                       OR n_7 > 0
                                       OR n_8 > 0
                                       OR n_9 > 0
                                       OR n_10> 0
                                       OR n_11> 0
                                       OR n_12> 0
                                       OR n_13> 0
                                       OR n_14> 0
                                       OR n_15> 0))
                                     OR (HasSelf = 0
                                     AND (n_1 <> 0
                                       OR n_2 <> 0
                                       OR n_3 <> 0
                                       OR n_4 <> 0
                                       OR n_5 <> 0
                                       OR n_6 <> 0
                                       OR n_7 <> 0
                                       OR n_8 <> 0
                                       OR n_9 <> 0
                                       OR n_10<> 0
                                       OR n_11<> 0
                                       OR n_12<> 0
                                       OR n_13<> 0
                                       OR n_14<> 0
                                       OR n_15<> 0))
                                   THEN 1 ELSE 0 END)
THEN 0 ELSE 1 END

GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена хранимая процедура CHECK_F6'
from VerInfo
where VerStr='3.7'
GO

ALTER  PROCEDURE [dbo].[sp_ImportSubj] 
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare	
	@SUBJ_ID	int,
	@AggData	bit,
	@BronOnly	bit,
	@CONFDATE	datetime

	SELECT @SUBJ_ID = SUBJ_ID, @AggData = AggData, @BronOnly = BronOnly, @CONFDATE = CONFDATE
	FROM [dbo].[#CURR_SUBJ]
	DELETE FROM SUBJ_INFO
	WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] SS ON S.TERR_ID = SS.TERR_ID)
	if @@ERROR != 0
	begin
		raiserror 51501 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	DELETE FROM SUBJ_PARAM
	WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] SS ON S.TERR_ID = SS.TERR_ID)
	if @@ERROR != 0
	begin
		raiserror 51502 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	UPDATE SUBJ SET
		TYPE_ID = S.TYPE_ID,
		SUBJ_NAME = S.SUBJ_NAME,
		SUBJ_FULLNAME = S.SUBJ_FULLNAME,
		SUBJ_ADDRESS = S.SUBJ_ADDRESS
	FROM [dbo].[#SUBJ] S
	WHERE SUBJ.TERR_ID = S.TERR_ID
	if @@ERROR != 0
	begin
		raiserror 51503 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO SUBJ (
		TYPE_ID,
		TERR_ID,
		ORGID,
		SUBJ_NAME,
		SUBJ_FULLNAME,
		SUBJ_ADDRESS,
		SUBJ_AGG_ID
		)
	SELECT 
		TYPE_ID,
		TERR_ID,
		NULL,
		SUBJ_NAME,
		SUBJ_FULLNAME,
		SUBJ_ADDRESS,
		SUBJ_AGG_ID
	FROM [dbo].[#SUBJ]
	WHERE TERR_ID NOT IN (SELECT TERR_ID FROM SUBJ)
	if @@ERROR != 0
	begin
		raiserror 51504 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO SUBJ_INFO (
		SUBJ_ID,
		SUBJ_INFO_ID,
		ORG_NAME,
		POSITION_NAME,
		FIO,
		PHONE
		)
	SELECT 
		SS.SUBJ_ID,
		I.SUBJ_INFO_ID,
		I.ORG_NAME,
		I.POSITION_NAME,
		I.FIO,
		I.PHONE
	FROM [dbo].[#SUBJ_INFO] I JOIN [dbo].[#SUBJ] S ON I.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
	if @@ERROR != 0
	begin
		raiserror 51505 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO SUBJ_PARAM (
		SUBJ_ID,
		SUBJ_PARAM_ID,
		PARAM_VALUE
		)
	SELECT 
		SS.SUBJ_ID,
		P.SUBJ_PARAM_ID,
		P.PARAM_VALUE
	FROM [dbo].[#SUBJ_PARAM] P JOIN [dbo].[#SUBJ] S ON P.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
	if @@ERROR != 0
	begin
		raiserror 51506 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	if @AggData = 1
	begin
		DELETE FROM FFS
		WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51507 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM FOKVED
		WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51507 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM FORM6
		WHERE F6_ID IN (SELECT F.F6_ID FROM FORM6HDR F JOIN SUBJ S ON F.SUBJ_ID = S.SUBJ_ID JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51508 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM FORM6HDR
		WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51509 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		INSERT INTO FOKVED (
			[SUBJ_ID],
			[OKVED_SECTION],
			[ORG_COUNT],
			[ORG_BRON_COUNT],
			[ORG_WU_COUNT],
			[RAB_COUNT],
			[ZAP_COUNT],
			[ZAB_COUNT] 
			)
		SELECT
			SS.SUBJ_ID,
			F.[OKVED_SECTION],
			F.[ORG_COUNT],
			F.[ORG_BRON_COUNT],
			F.[ORG_WU_COUNT],
			F.[RAB_COUNT],
			F.[ZAP_COUNT],
			F.[ZAB_COUNT] 
		FROM [dbo].[#FOKVED] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
		if @@ERROR != 0
		begin
			raiserror 51510 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		INSERT INTO FFS (
			[SUBJ_ID],
			[FS_ID],
			[FS_NAME],
			[KOD],
			[WHOLE],
			[WU],
			[BRON],
			[TOWN_WHOLE],
			[TOWN_WU],
			[TOWN_BRON],
			[VILLAGE_WHOLE],
			[VILLAGE_WU],
			[VILLAGE_BRON] 
			)
		SELECT
			SS.SUBJ_ID,
			F.[FS_ID],
			F.[FS_NAME],
			F.[KOD],
			F.[WHOLE],
			F.[WU],
			F.[BRON],
			F.[TOWN_WHOLE],
			F.[TOWN_WU],
			F.[TOWN_BRON],
			F.[VILLAGE_WHOLE],
			F.[VILLAGE_WU],
			F.[VILLAGE_BRON] 
		FROM [dbo].[#FFS] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
		if @@ERROR != 0
		begin
			raiserror 51510 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		INSERT INTO FORM6HDR (
			ORGID,
			ORGNAME,
			F6_SHIFR,
			ORG_SHIFR,
			F6_COUNT,
			KUO_COUNT,
			RAB_COUNT,
			ZAP_COUNT,
			ZAB_COUNT,
			CHECKED,
			CONFDATE,
			SUBJ_ID
		)
		SELECT
			NULL,
			F.ORGNAME,
			F.F6_SHIFR,
			F.ORG_SHIFR,
			F.F6_COUNT,
			F.KUO_COUNT,
			F.RAB_COUNT,
			F.ZAP_COUNT,
			F.ZAB_COUNT,
			F.CHECKED,
			F.CONFDATE,
			SS.SUBJ_ID
		FROM [dbo].[#FORM6HDR] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON SS.TERR_ID = S.TERR_ID
		if @@ERROR != 0
		begin
			raiserror 51511 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		INSERT INTO FORM6 (
			CPROF_ID,
			F6_ID,
			PRINT_NAME,
			EXPRESSION,
			CALCULATE,
			COL_B,
			COL_1,
			COL_2,
			COL_3,
			COL_4,
			COL_5,
			COL_6,
			COL_7,
			COL_8,
			COL_9,
			COL_10,
			COL_11,
			COL_12,
			COL_13,
			COL_14,
			COL_15,
			COL_16
		)
		SELECT
			FF.CPROF_ID,
			H.F6_ID,
			FF.PRINT_NAME,
			FF.EXPRESSION,
			FF.CALCULATE,
			FF.COL_B,
			FF.COL_1,
			FF.COL_2,
			FF.COL_3,
			FF.COL_4,
			FF.COL_5,
			FF.COL_6,
			FF.COL_7,
			FF.COL_8,
			FF.COL_9,
			FF.COL_10,
			FF.COL_11,
			FF.COL_12,
			FF.COL_13,
			FF.COL_14,
			FF.COL_15,
			FF.COL_16
		FROM [dbo].[#FORM6] FF JOIN [dbo].[#FORM6HDR] F ON FF.F6_ID = F.F6_ID JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID =S.SUBJ_ID JOIN SUBJ SS ON SS.TERR_ID = S.TERR_ID JOIN FORM6HDR H ON H.SUBJ_ID = SS.SUBJ_ID AND CAST(H.F6_SHIFR as int)=CAST(F.F6_SHIFR as int)
		if @@ERROR != 0
		begin
			raiserror 51512 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
	end
	if @CONFDATE IS NULL
	begin
		DELETE FROM FORM6
		WHERE F6_ID IN (SELECT F.F6_ID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN FORM6HDR F ON O.ORGID = F.ORGID)
		if @@ERROR != 0
		begin
			raiserror 51513 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM FORM6HDR
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51514 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM ORG_CONT
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51515 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM ORG_PAYM
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51516 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM OSN
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51517 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM PER
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51518 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM ORGSET
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
		if @@ERROR != 0
		begin
			raiserror 51519 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM ORG
		WHERE TERR_ID IN (SELECT TERR_ID FROM [dbo].[#SUBJ])
		if @@ERROR != 0
		begin
			raiserror 51520 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		INSERT INTO ORG (		
			PARENT,
			FS_ID,
			INN,
			OKPO,
			OKONH,
			SOOGU,
			KOPF_ID,
			KODREG,
			REGDATE,
			REGNUM,
			ORGNAME,
			ORGSNAME,
			COMMENT,
			FIZADDR,
			URADDR,
			POSTADDR,
			PHONE,
			FAX,
			EMAIL,
			WWW,
			MYORG,
			CONFDATE,
			MAINOKONH,
			OKBV,
			OCCUPATION,
			FIRST_DATE,
			LAST_DATE,
			OUT_REASON,
			OUT_DATE,
			SBM_ID,
			TERR_ID,
			EXT_ID, --xx
			HAS_BRON,
			CHK_DATE,
			F6_SHIFR,
			REGPL_ID,
			OKATO2,
			OKATO3
		)
		SELECT
			PARENT,
			FS_ID,
			INN,
			OKPO,
			OKONH,
			SOOGU,
			KOPF_ID,
			KODREG,
			REGDATE,
			REGNUM,
			ORGNAME,
			ORGSNAME,
			COMMENT,
			FIZADDR,
			URADDR,
			POSTADDR,
			PHONE,
			FAX,
			EMAIL,
			WWW,
			MYORG,
			CONFDATE,
			MAINOKONH,
			OKBV,
			OCCUPATION,
			FIRST_DATE,
			LAST_DATE,
			OUT_REASON,
			OUT_DATE,
			SBM_ID,
			TERR_ID,
			ORGID,
			HAS_BRON,
			CHK_DATE,
			F6_SHIFR,
			REGPL_ID,
			OKATO2,
			OKATO3
		FROM [dbo].[#ORG]
		WHERE TERR_ID IN (SELECT TERR_ID FROM [dbo].[#SUBJ])
		if @@ERROR != 0
		begin
			raiserror 51521 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
	end else begin
		DELETE FROM FORM6
		WHERE F6_ID IN (SELECT F.F6_ID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID JOIN FORM6HDR F ON O.ORGID = F.ORGID)
		if @@ERROR != 0
		begin
			raiserror 51522 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM FORM6HDR
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
		if @@ERROR != 0
		begin
			raiserror 51523 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM ORG_CONT
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
		if @@ERROR != 0
		begin
			raiserror 51524 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM ORG_PAYM
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
		if @@ERROR != 0
		begin
			raiserror 51525 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM OSN
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
		if @@ERROR != 0
		begin
			raiserror 51526 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM PER
		WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
		if @@ERROR != 0
		begin
			raiserror 51526 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end

		UPDATE ORG SET
			PARENT = O.PARENT,
			FS_ID = O.FS_ID,
			INN = O.INN,
			OKPO = O.OKPO,
			OKONH = O.OKONH,
			SOOGU = O.SOOGU,
			KOPF_ID = O.KOPF_ID,
			KODREG = O.KODREG,
			REGDATE = O.REGDATE,
			REGNUM = O.REGNUM,
			ORGNAME = O.ORGNAME,
			ORGSNAME = O.ORGSNAME,
			COMMENT = O.COMMENT,
			FIZADDR = O.FIZADDR,
			URADDR = O.URADDR,
			POSTADDR = O.POSTADDR,
			PHONE = O.PHONE,
			FAX = O.FAX,
			EMAIL = O.EMAIL,
			WWW = O.WWW,
			MYORG = O.MYORG,
			CONFDATE = O.CONFDATE,
			MAINOKONH = O.MAINOKONH,
			OKBV = O.OKBV,
			OCCUPATION = O.OCCUPATION,
			FIRST_DATE = O.FIRST_DATE,
			LAST_DATE = O.LAST_DATE,
			OUT_REASON = O.OUT_REASON,
			OUT_DATE = O.OUT_DATE,
			SBM_ID = O.SBM_ID,
			TERR_ID = O.TERR_ID,
			EXT_ID = O.EXT_ID,
			HAS_BRON = O.HAS_BRON,
			CHK_DATE = O.CHK_DATE,
			F6_SHIFR = O.F6_SHIFR,
			REGPL_ID = O.REGPL_ID,
			OKATO2 = O.OKATO2,
			OKATO3 = O.OKATO3
		FROM [dbo].[#ORG] O
		WHERE O.TERR_ID IN (SELECT TERR_ID FROM [dbo].[#SUBJ])
		AND ORG.TERR_ID = O.TERR_ID AND ORG.EXT_ID = O.ORGID 
		if @@ERROR != 0
		begin
			raiserror 51527 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
		INSERT INTO ORG (		
			PARENT,
			FS_ID,
			INN,
			OKPO,
			OKONH,
			SOOGU,
			KOPF_ID,
			KODREG,
			REGDATE,
			REGNUM,
			ORGNAME,
			ORGSNAME,
			COMMENT,
			FIZADDR,
			URADDR,
			POSTADDR,
			PHONE,
			FAX,
			EMAIL,
			WWW,
			MYORG,
			CONFDATE,
			MAINOKONH,
			OKBV,
			OCCUPATION,
			FIRST_DATE,
			LAST_DATE,
			OUT_REASON,
			OUT_DATE,
			SBM_ID,
			TERR_ID,
			EXT_ID,
			HAS_BRON,
			CHK_DATE,
			F6_SHIFR,
			REGPL_ID,
			OKATO2,
			OKATO3
		)
		SELECT
			PARENT,
			FS_ID,
			INN,
			OKPO,
			OKONH,
			SOOGU,
			KOPF_ID,
			KODREG,
			REGDATE,
			REGNUM,
			ORGNAME,
			ORGSNAME,
			COMMENT,
			FIZADDR,
			URADDR,
			POSTADDR,
			PHONE,
			FAX,
			EMAIL,
			WWW,
			MYORG,
			CONFDATE,
			MAINOKONH,
			OKBV,
			OCCUPATION,
			FIRST_DATE,
			LAST_DATE,
			OUT_REASON,
			OUT_DATE,
			SBM_ID,
			TERR_ID,
			ORGID,
			HAS_BRON,
			CHK_DATE,
			F6_SHIFR,
			REGPL_ID,
			OKATO2,
			OKATO3
		FROM [dbo].[#ORG] O
		WHERE ORGID NOT IN (
			SELECT O.ORGID FROM [dbo].[#ORG] O JOIN [dbo].[#SUBJ] S ON S.TERR_ID = O.TERR_ID 
                                       JOIN ORG OO ON OO.EXT_ID = O.ORGID AND OO.TERR_ID = O.TERR_ID)

		if @@ERROR != 0
		begin
			raiserror 51528 'Невозможно произвести импорт субъекта.'
			ROLLBACK TRANSACTION
			return
		end
	end
	INSERT INTO ORG_PAYM (
		ORGID,
		KS,
		RS,
		BIK,
		BANK
	)	
	SELECT
		OO.ORGID,
		P.KS,
		P.RS,
		P.BIK,
		P.BANK
	FROM [dbo].[#ORG_PAYM] P JOIN [dbo].[#ORG] O ON P.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
	if @@ERROR != 0
	begin
		raiserror 51529 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO ORG_CONT (
		ORGID,
		DEPART,
		POST,
		PHONE,
		FAX,
		EMAIL,
		IS_GEN,
		IS_VUS,
		FAM,
		IM,
		OTCH
		
	)
	SELECT
		OO.ORGID,
		C.DEPART,
		C.POST,
		C.PHONE,
		C.FAX,
		C.EMAIL,
		C.IS_GEN,
		C.IS_VUS,
		C.FAM,
		C.IM,
		C.OTCH
	FROM [dbo].[#ORG_CONT] C JOIN [dbo].[#ORG] O ON C.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
	if @@ERROR != 0
	begin
		raiserror 51530 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO OSN (
		ORGID,
		BASE_ID,
		DOC_ID,
		DOC_NO,
		DOC_DATE
	)
	SELECT
		OO.ORGID,
		S.BASE_ID,
		S.DOC_ID,
		S.DOC_NO,
		S.DOC_DATE
	FROM [dbo].[#OSN] S JOIN [dbo].[#ORG] O ON S.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
	if @@ERROR != 0
	begin
		raiserror 51531 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO PER (
		ORGID,
		DOC_ID,
		DOC_NO,
		START_DATE,
		END_DATE,
		PER_NO,
		RAZD_NO
	)
	SELECT
		OO.ORGID,
		P.DOC_ID,
		P.DOC_NO,
		P.START_DATE,
		P.END_DATE,
		P.PER_NO,
		P.RAZD_NO
	FROM [dbo].[#PER] P JOIN [dbo].[#ORG] O ON P.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
	if @@ERROR != 0
	begin
		raiserror 51532 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO FORM6HDR (
		ORGID,
		ORGNAME,
		F6_SHIFR,
		ORG_SHIFR,
		F6_COUNT,
		KUO_COUNT,
		RAB_COUNT,
		ZAP_COUNT,
		ZAB_COUNT,
		CHECKED,
		CONFDATE,
		SUBJ_ID
	)
	SELECT
		OO.ORGID,
		F.ORGNAME,
		F.F6_SHIFR,
		F.ORG_SHIFR,
		F.F6_COUNT,
		F.KUO_COUNT,
		F.RAB_COUNT,
		F.ZAP_COUNT,
		F.ZAB_COUNT,
		F.CHECKED,
		F.CONFDATE,
		Null
	FROM [dbo].[#FORM6HDR] F JOIN [dbo].[#ORG] O ON F.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
	if @@ERROR != 0
	begin
		raiserror 51533 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO FORM6 (
		CPROF_ID,
		F6_ID,
		PRINT_NAME,
		EXPRESSION,
		CALCULATE,
		COL_B,
		COL_1,
		COL_2,
		COL_3,
		COL_4,
		COL_5,
		COL_6,
		COL_7,
		COL_8,
		COL_9,
		COL_10,
		COL_11,
		COL_12,
		COL_13,
		COL_14,
		COL_15,
		COL_16
	)
	SELECT
		FF.CPROF_ID,
		H.F6_ID,
		FF.PRINT_NAME,
		FF.EXPRESSION,
		FF.CALCULATE,
		FF.COL_B,
		FF.COL_1,
		FF.COL_2,
		FF.COL_3,
		FF.COL_4,
		FF.COL_5,
		FF.COL_6,
		FF.COL_7,
		FF.COL_8,
		FF.COL_9,
		FF.COL_10,
		FF.COL_11,
		FF.COL_12,
		FF.COL_13,
		FF.COL_14,
		FF.COL_15,
		FF.COL_16
	FROM [dbo].[#FORM6] FF JOIN [dbo].[#FORM6HDR] F ON FF.F6_ID = F.F6_ID JOIN [dbo].[#ORG] O ON F.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID JOIN FORM6HDR H ON H.ORGID = OO.ORGID
	if @@ERROR != 0
	begin
		raiserror 51534 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
	UPDATE SUBJ SET REPORT_DATE = GETDATE() WHERE SUBJ_ID=@SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 51534 'Невозможно произвести импорт субъекта.'
		ROLLBACK TRANSACTION
		return
	end
COMMIT TRANSACTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлена процедура sp_ImportSubj'
from VerInfo
where VerStr='3.7'
GO

ALTER PROCEDURE [dbo].[sp_ImportOrg] 
	@EXT_ID	int	out
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare
	@ORG_ID	int,
	@MAINOKONH	varchar(5),
	@KODREG	varchar(11),
	@TERR_ID	int,
	@F6_ID	int,
	@F6_SHIFR	varchar(2)

	SELECT @ORG_ID = ORGID, @MAINOKONH = LEFT(OKONH, 5), @F6_SHIFR = F6_SHIFR
	FROM [dbo].[#ORG]

	SELECT @KODREG = T.KODTERR, @TERR_ID = S.TERR_ID
	FROM SUBJ S JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID JOIN KTERR T ON S.TERR_ID = T.TERR_ID
	if @EXT_ID IS NOT NULL
	begin
		DELETE FROM FORM6
		WHERE F6_ID in (select F6_ID from FORM6HDR where ORGID = @EXT_ID)
		if @@ERROR != 0
		begin
			raiserror 51400 'Невозможно произвести импорт организации.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM FORM6HDR
		WHERE ORGID = @EXT_ID
		if @@ERROR != 0
		begin
			raiserror 51401 'Невозможно произвести импорт организации.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM ORG_CONT
		WHERE ORGID = @EXT_ID
		if @@ERROR != 0
		begin
			raiserror 51402 'Невозможно произвести импорт организации.'
			ROLLBACK TRANSACTION
			return
		end
		DELETE FROM ORG_PAYM
		WHERE ORGID = @EXT_ID
		if @@ERROR != 0
		begin
			raiserror 51403 'Невозможно произвести импорт организации.'
			ROLLBACK TRANSACTION
			return
		end
		UPDATE ORG
		SET
			PARENT = T.PARENT,
			FS_ID = T.FS_ID,
			INN = T.INN,
			OKPO = T.OKPO,
			OKONH = T.OKONH,
			SOOGU = T.SOOGU,
			KOPF_ID = T.KOPF_ID,
			KODREG = T.KODREG,
			REGDATE = T.REGDATE,
			REGNUM = T.REGNUM,
			ORGNAME = T.ORGNAME,
			ORGSNAME = T.ORGSNAME,
			COMMENT = T.COMMENT,
			FIZADDR = T.FIZADDR,
			URADDR = T.URADDR,
			POSTADDR = T.POSTADDR,
			PHONE = T.PHONE,
			FAX = T.FAX,
			EMAIL = T.EMAIL,
			WWW = T.WWW,
			MYORG = T.MYORG,
			CONFDATE = T.CONFDATE,
			LAST_DATE = T.LAST_DATE,
			SBM_ID = T.SBM_ID,
			TERR_ID = T.TERR_ID,
			F6_SHIFR = T.F6_SHIFR,
			REGPL_ID=T.REGPL_ID,
			OKATO2=T.OKATO2,
			OKATO3=T.OKATO3,
                        FEATURE1=T.FEATURE1, 
                        FEATURE2=T.FEATURE2, 
                        FEATURE3=T.FEATURE3 
		FROM [dbo].[#ORG] T
		WHERE ORG.ORGID = @EXT_ID
		if @@ERROR != 0
		begin
			raiserror 51404 'Невозможно произвести импорт организации.'
			ROLLBACK TRANSACTION
			return
		end
	end else begin
		INSERT INTO ORG (
			PARENT,
			FS_ID,
			INN,
			OKPO,
			OKONH,
			SOOGU,
			KOPF_ID,
			KODREG,
			REGDATE,
			REGNUM,
			ORGNAME,
			ORGSNAME,
			COMMENT,
			FIZADDR,
			URADDR,
			POSTADDR,
			PHONE,
			FAX,
			EMAIL,
			WWW,
			MYORG,
			CONFDATE,
			MAINOKONH,
			OKBV,
			OCCUPATION,
			FIRST_DATE,
			LAST_DATE,
			OUT_REASON,
			OUT_DATE,
			SBM_ID,
			TERR_ID,
			EXT_ID,
			HAS_BRON,
			CHK_DATE,
			F6_SHIFR,
			REGPL_ID,
			OKATO2,
			OKATO3,
			FEATURE1,
			FEATURE2,
			FEATURE3
		)
		SELECT
			PARENT,
			FS_ID,
			INN,
			OKPO,
			OKONH,
			SOOGU,
			KOPF_ID,
			KODREG,
			REGDATE,
			REGNUM,
			ORGNAME,
			ORGSNAME,
			COMMENT,
			FIZADDR,
			URADDR,
			POSTADDR,
			PHONE,
			FAX,
			EMAIL,
			WWW,
			MYORG,
			CONFDATE,
			@MAINOKONH,
			OKBV,
			OCCUPATION,
			FIRST_DATE,
			LAST_DATE,
			OUT_REASON,
			OUT_DATE,
			SBM_ID,
			TERR_ID,
			EXT_ID,
			HAS_BRON,
			null,
			F6_SHIFR,
			REGPL_ID,
			OKATO2,
			OKATO3,
			FEATURE1,
			FEATURE2,
			FEATURE3
		FROM [dbo].[#ORG]
		if @@ERROR != 0
		begin
			raiserror 51405 'Невозможно произвести импорт организации.'
			ROLLBACK TRANSACTION
			return
		end
		
		SELECT @EXT_ID = @@IDENTITY
	end
	INSERT INTO ORG_PAYM (
		ORGID,
		KS,
		RS,
		BIK,
		BANK
	)
	SELECT
		@EXT_ID,
		KS,
		RS,
		BIK,
		BANK
	FROM [dbo].[#ORG_PAYM]
	WHERE ORGID = @ORG_ID
	if @@ERROR != 0
	begin
		raiserror 51406 'Невозможно произвести импорт организации.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO ORG_CONT (
		ORGID,
		DEPART,
		POST,
		PHONE,
		FAX,
		EMAIL,
		IS_GEN,
		IS_VUS,
		FAM,
		IM,
		OTCH
	)
	SELECT
		@EXT_ID,
		DEPART,
		POST,
		PHONE,
		FAX,
		EMAIL,
		IS_GEN,
		IS_VUS,
		FAM,
		IM,
		OTCH
	FROM [dbo].[#ORG_CONT]
	WHERE ORGID = @ORG_ID
	if @@ERROR != 0
	begin
		raiserror 51407 'Невозможно произвести импорт организации.'
		ROLLBACK TRANSACTION
		return
	end
	INSERT INTO FORM6HDR (
		ORGID,
		ORGNAME,
		F6_SHIFR,
		ORG_SHIFR,
		F6_COUNT,
		KUO_COUNT,
		RAB_COUNT,
		ZAP_COUNT,
		ZAB_COUNT,
		CHECKED,
		CONFDATE,
		SUBJ_ID
	)
	SELECT TOP 1
		@EXT_ID,
		ORGNAME,
		@F6_SHIFR,
		ORG_SHIFR,
		F6_COUNT,
		KUO_COUNT,
		RAB_COUNT,
		ZAP_COUNT,
		ZAB_COUNT,
		CHECKED,
		CONFDATE,
		SUBJ_ID
	FROM [dbo].[#FORM6HDR]
	WHERE ORGID = @ORG_ID
	if @@ERROR != 0
	begin
		raiserror 51408 'Невозможно произвести импорт организации.'
		ROLLBACK TRANSACTION
		return
	end
	SELECT @F6_ID = @@IDENTITY
	INSERT INTO FORM6 (
		CPROF_ID,
		F6_ID,
		PRINT_NAME,
		EXPRESSION,
		CALCULATE,
		COL_B,
		COL_1,
		COL_2,
		COL_3,
		COL_4,
		COL_5,
		COL_6,
		COL_7,
		COL_8,
		COL_9,
		COL_10,
		COL_11,
		COL_12,
		COL_13,
		COL_14,
		COL_15,
		COL_16
	)
	SELECT
		CPROF_ID,
		@F6_ID,
		PRINT_NAME,
		EXPRESSION,
		CALCULATE,
		COL_B,
		COL_1,
		COL_2,
		COL_3,
		COL_4,
		COL_5,
		COL_6,
		COL_7,
		COL_8,
		COL_9,
		COL_10,
		COL_11,
		COL_12,
		COL_13,
		COL_14,
		COL_15,
		COL_16
	FROM [dbo].[#FORM6]
	WHERE F6_ID = (SELECT TOP 1 F6_ID FROM [dbo].[#FORM6HDR])
	if @@ERROR != 0
	begin
		raiserror 51409 'Невозможно произвести импорт организации.'
		ROLLBACK TRANSACTION
		return
	end
             insert into [dbo].[#ORG_OSN] (base_id, doc_id, doc_no, doc_date)
             select base_id, doc_id, doc_no, doc_date
             from OSN
             where OrgId=@EXT_ID
             delete from OSN
             where OrgId=@EXT_ID
             insert into OSN(OrgId, base_id, doc_id, doc_no, doc_date)
             select DISTINCT @EXT_ID, base_id, doc_id, doc_no, doc_date
             from [dbo].[#ORG_OSN] 
             where  (base_id is null or base_id in (select [id] from VV3))
             and  (doc_id is null or doc_id in (select [id] from VV4))
	if @@ERROR != 0
	begin
		raiserror 51410 'Невозможно произвести импорт организации.'
		ROLLBACK TRANSACTION
		return
	end
              insert into [dbo].[#ORG_PER] (doc_id, doc_no, start_date, end_date, per_no, razd_no)
              select doc_id, doc_no, start_date, end_date, per_no, razd_no
              from PER
              where OrgId=@EXT_ID
              delete
              from PER
              where OrgId=@EXT_ID
              insert into PER (orgid, doc_id, doc_no, start_date, end_date, per_no, razd_no)
              select DISTINCT @EXT_ID, doc_id, doc_no, start_date, end_date, per_no, razd_no
              from [dbo].[#ORG_PER]
COMMIT TRANSACTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлена процедура sp_ImportOrg'
from VerInfo
where VerStr='3.7'
GO

ALTER   PROCEDURE [dbo].[sp_CalcSubjParams] -- changed in ver 3.70
	@ORG_COUNT	int	out,
	@PRIVORG_COUNT	int	out,
	@RAB_COUNT	float	out,
	@OKRUG_COUNT	int	out,
	@RAYON_COUNT	int	out,
        @POPULATION	float	out
AS

DECLARE @OKATO VarChar(11), @KODTERR VarChar(20), @KTERR VarChar(20)

SELECT @OKATO   = SUBJ.KodReg
     , @KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
     , @KTERR   = KTERR.KODTERR
  FROM SUBJ, CURR_SUBJ, KTERR 
 WHERE SUBJ.SUBJ_ID=CURR_SUBJ.SUBJ_ID
   AND SUBJ.TERR_ID=KTERR.TERR_ID

SELECT
       @OKRUG_COUNT	= NULL,
       @RAYON_COUNT	= NULL,
       @ORG_COUNT 	= ISNULL(SUM(1), 0), 
       @PRIVORG_COUNT 	= ISNULL(SUM(CASE WHEN o.KFP_ID = 3 THEN 1 ELSE 0 END), 0),
       @RAB_COUNT	= CAST(ISNULL(SUM(o.RAB_COUNT), 0) AS float) / 1000
  FROM v_ORG o
     , SUBJ s
     , KTERR t
 WHERE o.TERR_ID = s.TERR_ID
   AND o.TERR_ID = t.TERR_ID
   AND t.KODTERR LIKE @KODTERR --child or self
   AND s.SUBJ_AGG_ID = 1 -- cards

SELECT 
       @ORG_COUNT 	= @ORG_COUNT     + ISNULL(SUM(CASE WHEN SUBJ_PARAM_ID = 10 THEN PARAM_VALUE ELSE 0 END), 0),
       @PRIVORG_COUNT 	= @PRIVORG_COUNT + ISNULL(SUM(CASE WHEN SUBJ_PARAM_ID = 11 THEN PARAM_VALUE ELSE 0 END), 0),
       @RAB_COUNT 	= @RAB_COUNT     + ISNULL(SUM(CASE WHEN SUBJ_PARAM_ID = 2 THEN PARAM_VALUE ELSE 0 END), 0)
  FROM SUBJ_PARAM p
     , SUBJ s
     , KTERR t
 WHERE p.SUBJ_ID = s.SUBJ_ID
   AND s.TERR_ID = t.TERR_ID
   AND t.KODTERR LIKE @KODTERR --child or self
   AND s.SUBJ_AGG_ID = 2 --aggregate

IF SUBSTRING(@OKATO,1,2) = SUBSTRING(@KTERR,1,2) BEGIN
  IF SUBSTRING(@KTERR,3,3)='000' 
    SELECT @OKRUG_COUNT = COUNT(s.SUBJ_ID) 
         , @RAYON_COUNT = ISNULL(SUM(p.PARAM_VALUE), 0)
      FROM SUBJ s
         , KTerr t
         , SUBJ_PARAM p
     WHERE s.TERR_ID=t.TERR_ID 
       AND SUBSTRING(t.KodTerr,1,2)=SUBSTRING(@KTERR,1,2) 
       AND SUBSTRING(t.KodTerr,3,3)<>'000' 
       AND SUBSTRING(t.KodTerr,6,3)='000'
       AND p.SUBJ_ID=s.SUBJ_ID
       AND p.SUBJ_PARAM_ID=4
  IF SUBSTRING(@KTERR,3,3)<>'000' AND SUBSTRING(@KTERR,6,3)='000'
    SELECT @RAYON_COUNT = (SELECT COUNT(s.SUBJ_ID) FROM SUBJ s, KTerr t WHERE s.TERR_ID=t.TERR_ID AND SUBSTRING(@KTERR,1,5)=SUBSTRING(t.KodTerr,1,5) AND SUBSTRING(t.KodTerr,6,3)<>'000')
END

DECLARE @APOPULATION	float

SELECT @APOPULATION = ISNULL(SUM(CASE WHEN SUBJ_PARAM_ID = 1 THEN PARAM_VALUE ELSE 0 END), 0)
  FROM SUBJ_PARAM
 WHERE SUBJ_ID IN (SELECT s.SUBJ_ID
                     FROM (SELECT SUBJ_ID = SUBJ.SUBJ_ID
                                , KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
                             FROM SUBJ, KTERR 
                            WHERE SUBJ.TERR_ID=KTERR.TERR_ID) s
                    WHERE s.KODTERR LIKE @KODTERR
                     AND LEN(s.KODTERR)-LEN(@KODTERR) = 3)--direct child

IF @APOPULATION>0 SELECT @POPULATION = @APOPULATION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлена процедура sp_CalcSubjParams'
from VerInfo
where VerStr='3.7'
GO

ALTER PROCEDURE [dbo].[sp_SubjCardDelete] 
	@SUBJ_ID	int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
	if exists (select * from ORG WHERE TERR_ID IN (SELECT TERR_ID FROM SUBJ WHERE SUBJ_ID = @SUBJ_ID))	
	begin
		raiserror 51106 'Невозможно удалить карточку территориального органа. В списке есть организации, находящиеся на данной территории.'
		ROLLBACK TRANSACTION
		return
	end
	DELETE FROM FORM6
	WHERE F6_ID in (select F6_ID from FORM6HDR where SUBJ_ID = @SUBJ_ID)
	if @@ERROR != 0
	begin
		raiserror 51100 'Невозможно удалить карточку территориального органа.'
		ROLLBACK TRANSACTION
		return
	end
	DELETE FROM FORM6HDR
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 51101 'Невозможно удалить карточку территориального органа.'
		ROLLBACK TRANSACTION
		return
	end
	DELETE FROM FOKVED
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 51102 'Невозможно удалить карточку территориального органа.'
		ROLLBACK TRANSACTION
		return
	end
	DELETE FROM FFS
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 51102 'Невозможно удалить карточку территориального органа.'
		ROLLBACK TRANSACTION
		return
	end
	DELETE FROM SUBJ_INFO
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 51103 'Невозможно удалить карточку территориального органа.'
		ROLLBACK TRANSACTION
		return
	end
	DELETE FROM SUBJ_PARAM
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 51104 'Невозможно удалить карточку территориального органа.'
		ROLLBACK TRANSACTION
		return
	end
	DELETE FROM SUBJ
	WHERE SUBJ_ID = @SUBJ_ID
	if @@ERROR != 0
	begin
		raiserror 51105 'Невозможно удалить карточку территориального органа.'
		ROLLBACK TRANSACTION
		return
	end
COMMIT TRANSACTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлена процедура sp_SubjCardDelete'
from VerInfo
where VerStr='3.7'
GO

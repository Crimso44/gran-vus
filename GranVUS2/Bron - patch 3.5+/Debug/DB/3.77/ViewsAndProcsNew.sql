if not exists (select * from dbo.sysobjects where name = 'FSVT2012')
CREATE TABLE [dbo].[FSVT2012](
	[SUBJ_ID] [int] NOT NULL,
	[NUM] [int] NOT NULL,
	[N02] [int] NULL,
	[N03] [int] NULL,
	[N04] [int] NULL,
	[N05] [int] NULL,
	[N06] [int] NULL,
	[N07] [int] NULL,
	[N08] [int] NULL,
	[N09] [int] NULL,
	[N10] [int] NULL,
	[N11] [int] NULL
) ON [PRIMARY]

GO


if not exists (select * from dbo.sysobjects where name = 'FAnaliz')
CREATE TABLE [dbo].[FAnaliz](
	[SUBJ_ID] [int] NOT NULL,
	[NUM] [int] NOT NULL,
	[N01] [int] NULL,
	[N02] [int] NULL,
	[N10] [int] NULL,
	[N12] [int] NULL
) ON [PRIMARY]

GO


alter table org alter column Soogu varchar(7)

go

Alter     PROCEDURE [dbo].[sp_FFSGenerate] -- changed in ver 3.71
        @SUBJ_ID        int,
        @FilterType     int
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
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
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
        FS_ID = ISNULL(FS_ID,0),
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
        GROUP BY ISNULL(FS_ID,0)
        ) S
  WHERE S.FS_ID = FFS.FS_ID AND FFS.SUBJ_ID=@SUBJ_ID

        if @@ERROR != 0
        begin
                raiserror 50302 'Невозможно создать форму по видам собственности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION


go



Alter     PROCEDURE [dbo].[sp_FOKVEDGenerate]
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
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
                                               AND FORM6.COL_B=24
                                               --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                               )
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



Alter PROCEDURE [dbo].[sp_GenerateForm6_01]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int
  create table [dbo].[#OrgSet] (OrgId int)
  create table [dbo].[#SubjSet] (SubjId int)
  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet
        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50700 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 50701 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_01 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50702 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_01 O ON FH.ORGID = O.ORGID
                WHERE ((O.HAS_BRON!=1 AND F.CPROF_ID = 2000) OR (O.HAS_BRON=1 AND F.CPROF_ID = 1500))
                AND O.ORGID IN (select ORGID from [dbo].[#OrgSet])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 50703 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                WHERE F.F6_ID = @F6_ID
                AND (F.CPROF_ID = 1000
                OR F.CPROF_ID = 1500)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 50704 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50705 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_01 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50706 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_01 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50707 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50708 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 50709 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50710 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO


Alter PROCEDURE [dbo].[sp_GenerateForm6_02]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int
  create table [dbo].[#OrgSet] (OrgId int)
  create table [dbo].[#SubjSet] (SubjId int)
  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet
        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50800 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 50801 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_02 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50802 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_02 O ON FH.ORGID = O.ORGID
                WHERE ((O.HAS_BRON!=1
                AND F.CPROF_ID = 2000) OR (O.HAS_BRON=1
                AND F.CPROF_ID = 1500))
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 50803 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                WHERE F.F6_ID = @F6_ID
                AND (F.CPROF_ID = 1000
                OR F.CPROF_ID = 1500)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 50804 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50805 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_02 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50806 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_02 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50807 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50808 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 50809 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50810 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

Alter PROCEDURE [dbo].[sp_GenerateForm6_03]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int
  create table [dbo].[#OrgSet] (OrgId int)
  create table [dbo].[#SubjSet] (SubjId int)
  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet
        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50900 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 50901 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_03 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50902 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_03 O ON FH.ORGID = O.ORGID
                WHERE ((O.HAS_BRON!=1
                AND F.CPROF_ID = 2000) OR (O.HAS_BRON=1
                AND F.CPROF_ID = 1500))
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 50903 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                WHERE F.F6_ID = @F6_ID
                AND (F.CPROF_ID = 1000
                OR F.CPROF_ID = 1500)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 50904 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50905 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_03 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50906 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_03 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50907 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50908 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 50909 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50910 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

Alter PROCEDURE [dbo].[sp_GenerateForm6_04]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet


        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51700 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 51701 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_04 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 51702 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_04 O ON FH.ORGID = O.ORGID
                WHERE ((O.HAS_BRON!=1 AND F.CPROF_ID = 2000) OR (O.HAS_BRON=1 AND F.CPROF_ID = 1500))
                AND O.ORGID IN (select ORGID from [dbo].[#OrgSet])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 51703 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                WHERE F.F6_ID = @F6_ID
                AND (F.CPROF_ID = 1000
                OR F.CPROF_ID = 1500)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 51704 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID

        if @@ERROR != 0
        begin
                raiserror 51705 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_04 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51706 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_04 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51707 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51708 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 51709 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 51710 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

Alter PROCEDURE [dbo].[sp_GenerateForm6_05]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet


        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51800 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 51801 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_05 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 51802 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_05 O ON FH.ORGID = O.ORGID
                WHERE ((O.HAS_BRON!=1 AND F.CPROF_ID = 2000) OR (O.HAS_BRON=1 AND F.CPROF_ID = 1500))
                AND O.ORGID IN (select ORGID from [dbo].[#OrgSet])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 51803 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                WHERE F.F6_ID = @F6_ID
                AND (F.CPROF_ID = 1000
                OR F.CPROF_ID = 1500)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 51804 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID

        if @@ERROR != 0
        begin
                raiserror 51805 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_05 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51806 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_05 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51807 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51808 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 51809 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 51810 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

Alter PROCEDURE [dbo].[sp_GenerateForm6_06]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet


        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51900 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 51901 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_06 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 51902 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_06 O ON FH.ORGID = O.ORGID
                WHERE ((O.HAS_BRON!=1 AND F.CPROF_ID = 2000) OR (O.HAS_BRON=1 AND F.CPROF_ID = 1500))
                AND O.ORGID IN (select ORGID from [dbo].[#OrgSet])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 51903 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                WHERE F.F6_ID = @F6_ID
                AND (F.CPROF_ID = 1000
                OR F.CPROF_ID = 1500)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 51904 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID

        if @@ERROR != 0
        begin
                raiserror 51905 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_06 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51906 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_06 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51907 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51908 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 2000
        if @@ERROR != 0
        begin
                raiserror 51909 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 51910 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO



Alter PROCEDURE [dbo].[sp_FFS2010Generate]
        @SUBJ_ID        int,
        @FilterType     int
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



  DELETE FROM FFS2010
  WHERE SUBJ_ID = @SUBJ_ID

  if @@ERROR != 0
  begin
    raiserror 50300 'Невозможно создать форму по видам собственности.'
    ROLLBACK TRANSACTION
    return
  end

  INSERT INTO FFS2010(
    SUBJ_ID
  , FS_ID
  , FS_NAME
  , KOD
  , CITY
  , TOWN
  , VILLAGE
  , TOWNVILLAGE
  , INCITY
  )
  SELECT @SUBJ_ID, K.FS_ID, K.FS_NAME, K.KOD
  , NULLIF(SUM(CITY),0) AS CITY
  , NULLIF(SUM(TOWN),0) AS TOWN
  , NULLIF(SUM(VILLAGE),0) AS VILLAGE
  , NULLIF(SUM(TOWNVILLAGE),0) AS TOWNVILLAGE
  , NULLIF(SUM(INCITY),0) AS INCITY
  FROM KFS_ K LEFT OUTER JOIN
       (select
        FS_ID = CASE WHEN OO.FS_ID IN (SELECT FS_ID FROM KFS_)
                  THEN OO.FS_ID ELSE 0 END
                , CITY = case when 
                		(SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '40' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '45' and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '7' or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '850' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '898') or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '950' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '998'))) 
                        
                                	then 1 else 0 end
                , TOWN = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or 

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '1' then 1 else 0 end
                , VILLAGE = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 1 else 0 end
                , TOWNVILLAGE = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '7' then 1 else 0 end
                , INCITY = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '40' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '45') and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '3' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '9') then 1 else 0 end
        from v_ORG OO
        where OO.OUT_DATE IS NULL
          AND OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
                and EXISTS(SELECT * FROM FORM6HDR, FORM6
                                     WHERE FORM6HDR.OrgID=OO.ORGID
                                       AND FORM6.F6_ID=FORM6HDR.F6_ID
                                       AND FORM6.COL_B=24
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
       ) O ON (O.FS_ID = K.FS_ID)
  GROUP BY K.FS_ID, K.FS_NAME, K.KOD

  if @@ERROR != 0
  begin
        raiserror 50301 'Невозможно создать форму по видам собственности.'
        ROLLBACK TRANSACTION
        return
  end

  UPDATE FFS2010 SET
    CITY         = S.CITY
  , TOWN         = S.TOWN
  , VILLAGE      = S.VILLAGE
  , TOWNVILLAGE  = S.TOWNVILLAGE
  , INCITY       = S.INCITY
  FROM (
        SELECT
        FS_ID = ISNULL(FS_ID,0),
        NULLIF(SUM(CITY),0) AS CITY,
        NULLIF(SUM(TOWN),0) AS TOWN,
        NULLIF(SUM(VILLAGE),0) AS VILLAGE,
        NULLIF(SUM(TOWNVILLAGE),0) AS TOWNVILLAGE,
        NULLIF(SUM(INCITY),0) AS INCITY
        FROM FFS2010
        WHERE (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        GROUP BY ISNULL(FS_ID,0)
        ) S
  WHERE S.FS_ID = FFS2010.FS_ID AND FFS2010.SUBJ_ID=@SUBJ_ID

        if @@ERROR != 0
        begin
                raiserror 50302 'Невозможно создать форму по видам собственности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION


GO


ALTER    PROCEDURE [dbo].[sp_FOKVED2010Generate]
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  create table [dbo].[#temp] (SUBJ_ID int, OKVED_SECTION char(1),
        ORG_COUNT int, ORGB_COUNT int, RAB_COUNT int, ZAP_COUNT int, ZAB_COUNT int
  )

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

        DELETE FROM FOKVED2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO [dbo].[#temp]([SUBJ_ID], [OKVED_SECTION]
        , [ORG_COUNT]
        , [ORGB_COUNT]
        , [RAB_COUNT]
        , [ZAP_COUNT]
        , [ZAB_COUNT])
        SELECT @SUBJ_ID, K.OKVED_SECTION,
          NULLIF(COUNT(O.ORGID),0) AS ORG_COUNT,
          NULLIF(SUM(case when O.HAS_BRON = 1 then 1 else 0 end),0) AS ORGB_COUNT,
          NULLIF(SUM(O.RAB_COUNT),0) AS RAB_COUNT,
          NULLIF(SUM(O.ZAP_COUNT),0) AS ZAP_COUNT,
          NULLIF(SUM(O.ZAB_COUNT),0) AS ZAB_COUNT
          FROM KOKVED_ K LEFT OUTER JOIN
               (select
                  OO.ORGID
                , OO.RAB_COUNT as RAB_COUNT
                , OO.ZAP_COUNT as ZAP_COUNT
                , OO.ZAB_COUNT as ZAB_COUNT
                , OO.HAS_BRON
                , OKVED_FIRST = CASE WHEN (OO.MainOKONH LIKE '[0-9][0-9]' OR OO.MainOKONH LIKE '[0-9][0-9].%')
                                      AND EXISTS( SELECT * FROM KOKVED WHERE
                                                CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int) BETWEEN OKVED_BEGIN AND OKVED_END)
                                THEN CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int)
                                ELSE 0 END
                  from v_ORG OO
                 where OO.OUT_DATE IS NULL
                   AND (@IS_FULL = 1 OR OO.F6CHECKED = 1)
                   AND OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
                                        AND EXISTS(SELECT * FROM FORM6HDR, FORM6
                                             WHERE FORM6HDR.OrgID=OO.ORGID
                                               AND FORM6.F6_ID=FORM6HDR.F6_ID
                                               AND FORM6.COL_B=24
                                               --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                               )
               ) O ON (O.OKVED_FIRST BETWEEN K.OKVED_BEGIN AND K.OKVED_END)
        GROUP BY K.OKVED_SECTION

        if @@ERROR != 0
        begin
                raiserror 50301 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end

insert into FOKVED2010 (SUBJ_ID, NUM, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q)
select SUBJ_ID = @SUBJ_ID, NUM = 10,
  A = (select ORG_COUNT from #temp where OKVED_SECTION = 'A'),
  B = (select ORG_COUNT from #temp where OKVED_SECTION = 'B'),
  C = (select ORG_COUNT from #temp where OKVED_SECTION = 'C'),
  D = (select ORG_COUNT from #temp where OKVED_SECTION = 'D'),
  E = (select ORG_COUNT from #temp where OKVED_SECTION = 'E'),
  F = (select ORG_COUNT from #temp where OKVED_SECTION = 'F'),
  G = (select ORG_COUNT from #temp where OKVED_SECTION = 'G'),
  H = (select ORG_COUNT from #temp where OKVED_SECTION = 'H'),
  I = (select ORG_COUNT from #temp where OKVED_SECTION = 'I'),
  J = (select ORG_COUNT from #temp where OKVED_SECTION = 'J'),
  K = (select ORG_COUNT from #temp where OKVED_SECTION = 'K'),
  L = (select ORG_COUNT from #temp where OKVED_SECTION = 'L'),
  M = (select ORG_COUNT from #temp where OKVED_SECTION = 'M'),
  N = (select ORG_COUNT from #temp where OKVED_SECTION = 'N'),
  O = (select ORG_COUNT from #temp where OKVED_SECTION = 'O'),
  P = (select ORG_COUNT from #temp where OKVED_SECTION = 'P'),
  Q = (select ORG_COUNT from #temp where OKVED_SECTION = 'Q')
union all
select SUBJ_ID = @SUBJ_ID, NUM = 15,
  A = (select ORGB_COUNT from #temp where OKVED_SECTION = 'A'),
  B = (select ORGB_COUNT from #temp where OKVED_SECTION = 'B'),
  C = (select ORGB_COUNT from #temp where OKVED_SECTION = 'C'),
  D = (select ORGB_COUNT from #temp where OKVED_SECTION = 'D'),
  E = (select ORGB_COUNT from #temp where OKVED_SECTION = 'E'),
  F = (select ORGB_COUNT from #temp where OKVED_SECTION = 'F'),
  G = (select ORGB_COUNT from #temp where OKVED_SECTION = 'G'),
  H = (select ORGB_COUNT from #temp where OKVED_SECTION = 'H'),
  I = (select ORGB_COUNT from #temp where OKVED_SECTION = 'I'),
  J = (select ORGB_COUNT from #temp where OKVED_SECTION = 'J'),
  K = (select ORGB_COUNT from #temp where OKVED_SECTION = 'K'),
  L = (select ORGB_COUNT from #temp where OKVED_SECTION = 'L'),
  M = (select ORGB_COUNT from #temp where OKVED_SECTION = 'M'),
  N = (select ORGB_COUNT from #temp where OKVED_SECTION = 'N'),
  O = (select ORGB_COUNT from #temp where OKVED_SECTION = 'O'),
  P = (select ORGB_COUNT from #temp where OKVED_SECTION = 'P'),
  Q = (select ORGB_COUNT from #temp where OKVED_SECTION = 'Q')
union all
select @SUBJ_ID, 20,
  (select RAB_COUNT from #temp where OKVED_SECTION = 'A'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'B'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'C'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'D'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'E'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'F'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'G'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'H'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'I'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'J'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'K'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'L'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'M'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'N'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'O'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'P'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'Q')
union all
select @SUBJ_ID, 30,
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'A'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'B'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'C'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'D'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'E'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'F'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'G'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'H'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'I'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'J'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'K'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'L'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'M'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'N'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'O'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'P'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'Q')
union all
select @SUBJ_ID, 40,
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'A'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'B'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'C'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'D'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'E'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'F'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'G'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'H'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'I'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'J'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'K'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'L'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'M'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'N'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'O'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'P'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'Q')

        UPDATE FOKVED2010
        SET
                A = S.SUM_A,
        B = S.SUM_B,
                C = S.SUM_C,
                D = S.SUM_D,
                E = S.SUM_E,
                F = S.SUM_F,
                G = S.SUM_G,
                H = S.SUM_H,
                I = S.SUM_I,
                J = S.SUM_J,
                K = S.SUM_K,
                L = S.SUM_L,
                M = S.SUM_M,
                N = S.SUM_N,
                O = S.SUM_O,
                P = S.SUM_P,
                Q = S.SUM_Q
        FROM (
                SELECT
                NUM,
        NULLIF(SUM(A),0) AS SUM_A,
        NULLIF(SUM(B),0) AS SUM_B,
        NULLIF(SUM(C),0) AS SUM_C,
        NULLIF(SUM(D),0) AS SUM_D,
        NULLIF(SUM(E),0) AS SUM_E,
        NULLIF(SUM(F),0) AS SUM_F,
        NULLIF(SUM(G),0) AS SUM_G,
        NULLIF(SUM(H),0) AS SUM_H,
        NULLIF(SUM(I),0) AS SUM_I,
        NULLIF(SUM(J),0) AS SUM_J,
        NULLIF(SUM(K),0) AS SUM_K,
        NULLIF(SUM(L),0) AS SUM_L,
        NULLIF(SUM(M),0) AS SUM_M,
        NULLIF(SUM(N),0) AS SUM_N,
        NULLIF(SUM(O),0) AS SUM_O,
        NULLIF(SUM(p),0) AS SUM_P,
        NULLIF(SUM(Q),0) AS SUM_Q
                FROM FOKVED2010
                WHERE (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY NUM
        ) S
        WHERE S.NUM = FOKVED2010.NUM AND FOKVED2010.SUBJ_ID=@SUBJ_ID

        if @@ERROR != 0
        begin
                raiserror 50302 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

Alter PROCEDURE [dbo].[sp_FOKVED2010Create]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FOKVED2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50200 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FOKVED2010(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, 10 UNION ALL
        SELECT @SUBJ_ID, 15 UNION ALL
        SELECT @SUBJ_ID, 20 UNION ALL
        SELECT @SUBJ_ID, 30 UNION ALL
        SELECT @SUBJ_ID, 40
        if @@ERROR != 0
        begin
                raiserror 50201 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION


go

if not exists (select * from syscolumns where name = 'POSITION_NAME2' and object_name(id)='SUBJ_INFO')
ALTER TABLE dbo.SUBJ_INFO ADD
	POSITION_NAME2 varchar(60) NULL,
	FIO2 varchar(100) NULL,
	PHONE2 varchar(100) NULL

GO


if not exists (select * from syscolumns where name = 'KPISS' and object_name(id)='ORG')
ALTER TABLE dbo.ORG ADD
        [KPIS] int null,
        [COMPUTERSS] int null,
        [SOFTWARENUMS] int null,
        [KPISS] int null

go


delete from SUBJ_PARAM
delete from SUBJ_PARAM_TYPE

Insert into SUBJ_PARAM_TYPE (subj_param_id, subj_param_name)
values (1, '1. Муниципальных образований')
Insert into SUBJ_PARAM_TYPE (subj_param_id, subj_param_name)
values (2, '2. Работающее население (тыс. чел)')
Insert into SUBJ_PARAM_TYPE (subj_param_id, subj_param_name)
values (3, '3. Комиссий')
Insert into SUBJ_PARAM_TYPE (subj_param_id, subj_param_name)
values (4, '4. Сотрудников, отвечающих за первичный воинский учет в поселениях')
Insert into SUBJ_PARAM_TYPE (subj_param_id, subj_param_name)
values (5, '    из них по совместительству')


go

update SUBJ_INFO_TYPE Set Subj_Info_Name = 'Орган исполнительной власти'
where Subj_Info_Id = 1

go

if not exists (select * from syscolumns where name = 'value3' and object_name(id)='SUBJ_PARAM')
ALTER TABLE dbo.SUBJ_PARAM ADD
	value3 float NULL,
	value4 float NULL,
	value5 float NULL,
	value6 float NULL,
	value7 float NULL,
	value8 float NULL


go

if exists (select * from dbo.sysobjects where name = 'sp_CalcSubjParams377')
  drop procedure sp_CalcSubjParams377
go

Create PROCEDURE [dbo].[sp_CalcSubjParams377] -- changed in ver 3.71
AS

DECLARE @OKATO VarChar(11), @KODTERR VarChar(20), @KTERR VarChar(20), @Subj_Id int

SELECT @OKATO   = SUBJ.KodReg
     , @KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
     , @KTERR   = KTERR.KODTERR
     , @Subj_Id = SUBJ.SUBJ_ID
  FROM SUBJ, CURR_SUBJ, KTERR
 WHERE SUBJ.SUBJ_ID=CURR_SUBJ.SUBJ_ID
   AND SUBJ.TERR_ID=KTERR.TERR_ID

declare @CITY float, @TOWN float, @VILLAGE float, @TOWNVILLAGE float, @INCITY float


SELECT
                @CITY = Round(convert(float,Sum(case when 
                		(SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '40' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '45' and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '7' or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '850' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '898') or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '950' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '998'))) 
                                	then f6.col_1 else 0 end))/1000,1)
                , @TOWN = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or 

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '1' then f6.col_1 else 0 end))/1000,1)
                , @VILLAGE = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then f6.col_1 else 0 end))/1000,1)
                , @TOWNVILLAGE = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '7' then f6.col_1 else 0 end))/1000,1)
                , @INCITY = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '40' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '45') and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '3' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '9') then f6.col_1 else 0 end))/1000,1)
  FROM v_ORG oo
     join SUBJ s on oo.TERR_ID = s.TERR_ID
     join KTERR t on oo.TERR_ID = t.TERR_ID
     join FORM6HDR f6h on f6h.ORGID = oo.ORGID
     join FORM6 f6 on f6.F6_ID = f6h.F6_ID and f6.col_b = 24
 WHERE t.KODTERR LIKE @KODTERR --child or self
   AND s.SUBJ_AGG_ID = 1
   AND oo.OUT_DATE IS NULL


SELECT
  pt.SUBJ_PARAM_ID,
  case when pt.SUBJ_PARAM_ID in (1,4,5) then
	Sum(IsNull(value3,0)+IsNull(value4,0)+IsNull(value5,0)+IsNull(value6,0)+IsNull(value8,0))
       when pt.SUBJ_PARAM_ID = 2 then
	IsNull(@CITY,0)+IsNull(@TOWN,0)+IsNull(@VILLAGE,0)+IsNull(@TOWNVILLAGE,0)+IsNull(@INCITY,0)+
	Sum(case when p.SUBJ_AGG_ID = 2 then Param_Value else 0 end)
       when pt.SUBJ_PARAM_ID = 3 then
	Sum(IsNull(value3,0)+IsNull(value4,0)+IsNull(value8,0)) end PARAM_VALUE,
  case when pt.SUBJ_PARAM_ID = 2 then IsNull(@CITY,0) + 
		Sum(case when p.SUBJ_AGG_ID = 2 then value3 else 0 end)
	else Sum(value3) end value3,
  case when pt.SUBJ_PARAM_ID = 2 then 
	IsNull(@TOWN,0)+IsNull(@VILLAGE,0)+IsNull(@TOWNVILLAGE,0)+
	Sum(case when p.SUBJ_AGG_ID = 2 then value4 else 0 end)
	else Sum(value4) end value4,
  case pt.SUBJ_PARAM_ID when 2 then IsNull(@TOWN,0)+
  		Sum(case when p.SUBJ_AGG_ID = 2 then value5 else 0 end)
	when 3 then null else Sum(value5) end value5,
  case pt.SUBJ_PARAM_ID when 2 then IsNull(@VILLAGE,0)+
  		Sum(case when p.SUBJ_AGG_ID = 2 then value6 else 0 end)
	when 3 then null else Sum(value6) end value6,
  case when pt.SUBJ_PARAM_ID = 2 then IsNull(@TOWNVILLAGE,0)+ 
  		Sum(case when p.SUBJ_AGG_ID = 2 then value7 else 0 end)
	else null end value7,
  case when pt.SUBJ_PARAM_ID = 2 then IsNull(@INCITY,0)+
  		Sum(case when p.SUBJ_AGG_ID = 2 then value8 else 0 end)
	  else Sum(value8) end value8
 FROM SUBJ_PARAM_TYPE pt
	 left join (
		Select p.*, s.SUBJ_AGG_ID
		from SUBJ_PARAM p 
		join SUBJ s on p.SUBJ_ID = s.SUBJ_ID and s.Subj_Id <> @Subj_Id AND s.SUBJ_AGG_ID in (1,2)
		join KTERR t on s.TERR_ID = t.TERR_ID and t.KODTERR LIKE @KODTERR --child and not self
) p on p.SUBJ_PARAM_ID = pt.SUBJ_PARAM_ID     
 Group by pt.SUBJ_PARAM_ID
 Order BY pt.SUBJ_PARAM_ID





GO

Alter PROCEDURE [dbo].[sp_ImportSubj]
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare
        @SUBJ_ID        int,
        @AggData        bit,
        @BronOnly       bit,
        @CONFDATE       datetime

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
                PHONE,
                POSITION_NAME2,
                FIO2,
                PHONE2
                )
        SELECT
                SS.SUBJ_ID,
                I.SUBJ_INFO_ID,
                I.ORG_NAME,
                I.POSITION_NAME,
                I.FIO,
                I.PHONE,
                I.POSITION_NAME2,
                I.FIO2,
                I.PHONE2
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
                PARAM_VALUE,
				value3,
				value4,
				value5,
				value6,
				value7,
				value8
                )
        SELECT
                SS.SUBJ_ID,
                P.SUBJ_PARAM_ID,
                P.PARAM_VALUE,
				P.value3,
				P.value4,
				P.value5,
				P.value6,
				P.value7,
				P.value8
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
                DELETE FROM FFS2010
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51507 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FOKVED2010
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51507 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FSVT2012
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51507 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FAnaliz
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
                INSERT INTO FOKVED2010 (
                        [SUBJ_ID],
                        [NUM],
                        [A],
                        [B],
                        [C],
                        [D],
                        [E],
                        [F],
                        [G],
                        [H],
                        [I],
                        [J],
                        [K],
                        [L],
                        [M],
                        [N],
                        [O],
                        [P],
                        [Q]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
                        F.[A],
                        F.[B],
                        F.[C],
                        F.[D],
                        F.[E],
                        F.[F],
                        F.[G],
                        F.[H],
                        F.[I],
                        F.[J],
                        F.[K],
                        F.[L],
                        F.[M],
                        F.[N],
                        F.[O],
                        F.[P],
                        F.[Q]
                FROM [dbo].[#FOKVED2010] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror 51510 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FSVT2012 (
                        [SUBJ_ID],
                        [NUM],
						[N02],
						[N03],
						[N04],
						[N05],
						[N06],
						[N07],
						[N08],
						[N09],
						[N10],
						[N11]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
						F.[N02],
						F.[N03],
						F.[N04],
						F.[N05],
						F.[N06],
						F.[N07],
						F.[N08],
						F.[N09],
						F.[N10],
						F.[N11]
                FROM [dbo].[#FSVT2012] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror 51510 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FAnaliz (
                        [SUBJ_ID],
                        [NUM],
						[N01],
						[N02],
						[N10],
						[N12]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
						F.[N01],
						F.[N02],
						F.[N10],
						F.[N12]
                FROM [dbo].[#FAnaliz] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
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
                INSERT INTO FFS2010 (
                        [SUBJ_ID],
                        [FS_ID],
                        [FS_NAME],
                        [KOD],
                        [CITY],
                        [TOWN],
                        [VILLAGE],
                        [TOWNVILLAGE],
                        [INCITY]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[FS_ID],
                        F.[FS_NAME],
                        F.[KOD],
                        F.[CITY],
                        F.[TOWN],
                        F.[VILLAGE],
                        F.[TOWNVILLAGE],
                        F.[INCITY]
                FROM [dbo].[#FFS2010] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
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
                        COL_16,
		                COL_10T,
				        COL_12T
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
                        FF.COL_16,
		                FF.COL_10T,
				        FF.COL_12T
                FROM [dbo].[#FORM6] FF JOIN [dbo].[#FORM6HDR] F ON FF.F6_ID = F.F6_ID JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID =S.SUBJ_ID JOIN SUBJ SS ON SS.TERR_ID = S.TERR_ID JOIN FORM6HDR H ON H.SUBJ_ID = SS.SUBJ_ID AND CAST(H.F6_SHIFR as int)=CAST(F.F6_SHIFR as int)
                if @@ERROR != 0
                begin
                        raiserror 51512 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
        end


        INSERT INTO KOVK (OVK_NAME,OVK_ADDR,OVK_PHONE)
        SELECT OVK_NAME,OVK_ADDR,OVK_PHONE from #ORG where ISNULL(OVK_NAME,'')<>'' and OVK_NAME not in (select OVK_NAME from KOVK)

        UPDATE #ORG
           SET OVK_ID = NULL
         WHERE ISNULL(OVK_NAME,'')=''

        UPDATE #ORG
           SET OVK_ID = KOVK.OVK_ID
          FROM KOVK
         WHERE KOVK.OVK_NAME = #ORG.OVK_NAME

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
                        OKATO3,
                        Feature1,
                        Feature2,
                        Feature3,
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE
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
                        OKATO3,
                        Feature1,
                        Feature2,
                        Feature3,
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE
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
                        OKATO3 = O.OKATO3,
                        Feature1 = O.Feature1,
                        Feature2 = O.Feature2,
                        Feature3 = O.Feature3,
                        OVK_ID = O.OVK_ID,
                        KODOKTMO = O.KODOKTMO,
						KODOKTMO2 = O.KODOKTMO2,
						REGPLACE = O.REGPLACE,
						COMPUTERS = O.COMPUTERS,
						SOFTWARENUM = O.SOFTWARENUM,
						KPIS = O.KPIS,
						COMPUTERSS = O.COMPUTERSS,
						SOFTWARENUMS = O.SOFTWARENUMS,
						KPISS = O.KPISS,
						SOFTWARE = O.SOFTWARE
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
                        OKATO3,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE
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
                        OKATO3,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE
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
                COL_16,
                COL_10T,
		        COL_12T
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
                FF.COL_16,
                FF.COL_10T,
		        FF.COL_12T
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

Alter PROCEDURE [dbo].[sp_ImportOrg]
        @EXT_ID int     out
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare
        @ORG_ID int,
        @MAINOKONH      varchar(5),
        @KODREG varchar(11),
        @TERR_ID        int,
        @F6_ID  int,
        @F6_SHIFR       varchar(2)

        SELECT @ORG_ID = ORGID, @MAINOKONH = LEFT(OKONH, 5), @F6_SHIFR = F6_SHIFR
        FROM [dbo].[#ORG]

        SELECT @KODREG = T.KODTERR, @TERR_ID = S.TERR_ID
        FROM SUBJ S JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID JOIN KTERR T ON S.TERR_ID = T.TERR_ID


        INSERT INTO KOVK (OVK_NAME,OVK_ADDR,OVK_PHONE)
        SELECT OVK_NAME,OVK_ADDR,OVK_PHONE from #ORG where ISNULL(OVK_NAME,'')<>'' and OVK_NAME not in (select OVK_NAME from KOVK)

        UPDATE #ORG
           SET OVK_ID = NULL
         WHERE ISNULL(OVK_NAME,'')=''

        UPDATE #ORG
           SET OVK_ID = KOVK.OVK_ID
          FROM KOVK
         WHERE KOVK.OVK_NAME = #ORG.OVK_NAME

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
                        FEATURE3=T.FEATURE3,
                        OVK_ID = T.OVK_ID,
                        KODOKTMO = T.KODOKTMO,
						KODOKTMO2 = T.KODOKTMO2,
						REGPLACE = T.REGPLACE,
						COMPUTERS = T.COMPUTERS,
						SOFTWARENUM = T.SOFTWARENUM,
						KPIS = T.KPIS,
						COMPUTERSS = T.COMPUTERSS,
						SOFTWARENUMS = T.SOFTWARENUMS,
						KPISS = T.KPISS,
						SOFTWARE = T.SOFTWARE
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
                        FEATURE3,
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE
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
                        FEATURE3,
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE
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
                COL_16,
                COL_10T,
                COL_12T
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
                COL_16,
                COL_10T,
                COL_12T
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


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FSVT2012Clear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FSVT2012Clear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FSVT2012Create]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FSVT2012Create]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FSVT2012Generate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FSVT2012Generate]
GO



if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FAnalizClear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FAnalizClear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FAnalizCreate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FAnalizCreate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FAnalizGenerate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FAnalizGenerate]
GO




CREATE PROCEDURE [dbo].[sp_FSVT2012Clear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FSVT2012
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50100 'Невозможно удалить форму по сведениям об использовании СВТ.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO


CREATE PROCEDURE [dbo].[sp_FAnalizClear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FAnaliz
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50100 'Невозможно удалить форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO


CREATE PROCEDURE [dbo].[sp_FSVT2012Create]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FSVT2012
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50200 'Невозможно создать форму по сведениям об использовании СВТ.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FSVT2012(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, 10 UNION ALL
        SELECT @SUBJ_ID, 20 UNION ALL
        SELECT @SUBJ_ID, 30 UNION ALL
        SELECT @SUBJ_ID, 40
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по сведениям об использовании СВТ.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO


CREATE PROCEDURE [dbo].[sp_FAnalizCreate]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FAnaliz
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50200 'Невозможно создать форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FAnaliz(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, CProf_Id
        From KCProf
        WHERE CPROF_ID in (100,200,300,400,470,2000)
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO


Create PROCEDURE [dbo].[sp_FSVT2012Generate]
--declare
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
--set        @SUBJ_ID        = 2
--set        @IS_FULL        = 1
--set        @FilterType     = 1
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  create table [dbo].[#temp] (SUBJ_ID int, NUM int, CITY int, CITYS int, VILL int, VILLS int
  )

DECLARE @KODTERR VarChar(20)

SELECT @KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
  FROM SUBJ, KTERR
 WHERE SUBJ.TERR_ID=KTERR.TERR_ID and Subj.Subj_Id = @Subj_Id


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

        DELETE FROM FSVT2012
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по сведениям об использовании СВТ.'
                ROLLBACK TRANSACTION
                return
        end
        
        INSERT INTO FSVT2012(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, 10 UNION ALL
        SELECT @SUBJ_ID, 20 UNION ALL
        SELECT @SUBJ_ID, 30 UNION ALL
        SELECT @SUBJ_ID, 40

        
	INSERT INTO [dbo].[#temp]([SUBJ_ID], NUM, CITY, CITYS, VILL, VILLS)
	SELECT @SUBJ_ID, 10, 
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else computers end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else computerss end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then computers else 0 end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then computerss else 0 end)
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join KTERR t on oo.TERR_ID = t.TERR_ID
	     join FORM6HDR f6h on f6h.ORGID = oo.ORGID
	 WHERE 
	   OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	   and f6h.f6_shifr <> '01'
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL
union
	SELECT @SUBJ_ID, 20, 
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else softwarenum end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else softwarenums end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then softwarenum else 0 end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then softwarenums else 0 end)
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join KTERR t on oo.TERR_ID = t.TERR_ID
	     join FORM6HDR f6h on f6h.ORGID = oo.ORGID
	 WHERE 
	   OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	   and f6h.f6_shifr <> '01'
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL
union
	SELECT @SUBJ_ID, 30, 
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else kpis end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else kpiss end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then kpis else 0 end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then kpiss else 0 end)
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join KTERR t on oo.TERR_ID = t.TERR_ID
	     join FORM6HDR f6h on f6h.ORGID = oo.ORGID
	 WHERE 
	   OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	   and f6h.f6_shifr <> '01'
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL


Update FSVT2012 set
	N04 = x.N04, N05 = x.N05, N06 = x.N06, N07 = x.N07, 
	N08 = IsNull(x.N08,0) + IsNull(t.City, 0), 
	N09 = IsNull(x.N09,0) + IsNull(t.CityS, 0), 
	N10 = IsNull(x.N10,0) + IsNull(t.Vill, 0), 
	N11 = IsNull(x.N11,0) + IsNull(t.VillS, 0)
from FSVT2012 F
left join (
	select Num, Sum(N02) N02, Sum(N03) N03, Sum(N04) N04, Sum(N05) N05, Sum(N06) N06, Sum(N07) N07, Sum(N08) N08, Sum(N09) N09, Sum(N10) N10, Sum(N11) N11
	from FSVT2012 FF
    join SUBJ s on ff.SUBJ_ID = s.SUBJ_ID and s.Subj_Id <> @Subj_Id AND 
	   s.Subj_Id IN (SELECT ss.SubjId FROM [dbo].[#SubjSET] ss)
    --join KTERR t on s.TERR_ID = t.TERR_ID and t.KODTERR LIKE @KODTERR --child and not self
	where s.Subj_Agg_Id = 2
    group by Num
) x on x.Num = F.Num
left join [dbo].[#temp] t on t.Num = F.Num
Where F.Subj_Id = @Subj_Id


Update FSVT2012 set
	N04 = IsNull(ff.N04,0)-IsNull(fff.N04,0), 
	N05 = IsNull(ff.N05,0)-IsNull(fff.N05,0), 
	N06 = IsNull(ff.N06,0)-IsNull(fff.N06,0), 
	N07 = IsNull(ff.N07,0)-IsNull(fff.N07,0), 
	N08 = IsNull(ff.N08,0)-IsNull(fff.N08,0), 
	N09 = IsNull(ff.N09,0)-IsNull(fff.N09,0), 
	N10 = IsNull(ff.N10,0)-IsNull(fff.N10,0), 
	N11 = IsNull(ff.N11,0)-IsNull(fff.N11,0) 
from FSVT2012 F
left join (select * from FSVT2012) FF on FF.Subj_Id = @Subj_Id and FF.Num = 20
left join (select * from FSVT2012) FFF on FFF.Subj_Id = @Subj_Id and FFF.Num = 30
Where F.Subj_Id = @Subj_Id and F.Num = 40

                                         
Update FSVT2012 set
	N02 = IsNull(N04,0)+IsNull(N06,0)+IsNull(N08,0)+IsNull(N10,0), 
	N03 = IsNull(N05,0)+IsNull(N07,0)+IsNull(N09,0)+IsNull(N11,0)
from FSVT2012 F
Where Subj_Id = @Subj_Id 

                                         
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по сведениям об использовании СВТ.'
                ROLLBACK TRANSACTION
                return
        end

drop table [dbo].[#OrgSet] 

drop table [dbo].[#SubjSet]

drop table [dbo].[#temp]

COMMIT TRANSACTION

--select * from FSVT2012


go


Create PROCEDURE [dbo].[sp_FAnalizGenerate]
--declare
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
--set        @SUBJ_ID        = 2
--set        @IS_FULL        = 1
--set        @FilterType     = 1
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)


DECLARE @KODTERR VarChar(20)

SELECT @KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
  FROM SUBJ, KTERR
 WHERE SUBJ.TERR_ID=KTERR.TERR_ID and Subj.Subj_Id = @Subj_Id


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


        DELETE FROM FAnaliz
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end
        
        INSERT INTO FAnaliz(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, CProf_Id
        From KCProf
        WHERE CPROF_ID in (100,200,300,400,470,2000)

        

Update FAnaliz set
	N01 = IsNull(x.N01,0) + IsNull(y.Col_1, 0), 
	N02 = IsNull(x.N02,0) + IsNull(y.Col_2, 0), 
	N10 = IsNull(x.N10,0) + IsNull(y.Col_10, 0), 
	N12 = IsNull(x.N12,0) + IsNull(y.Col_12, 0)
from FAnaliz F
left join (
	select Num, Sum(N01) N01, Sum(N02) N02, Sum(N10) N10, Sum(N12) N12
	from FAnaliz FF
    join SUBJ s on ff.SUBJ_ID = s.SUBJ_ID and s.Subj_Id <> @Subj_Id AND 
	   s.Subj_Id IN (SELECT ss.SubjId FROM [dbo].[#SubjSET] ss)
    --join KTERR t on s.TERR_ID = t.TERR_ID and t.KODTERR LIKE @KODTERR --child and not self
	where s.Subj_Agg_Id = 2
    group by Num
) x on x.Num = F.Num
left join (
	select CProf_Id Num, Sum(Col_1) Col_1, Sum(Col_2) Col_2, Sum(Col_10) Col_10, Sum(Col_12) Col_12
	
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join FORM6HDR h on h.ORGID = oo.ORGID
	     join Form6 f on f.f6_id = h.f6_id

		WHERE f.CPROF_ID in (100,200,300,400,470,2000)
		and h.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL
	   AND oo.HAs_Bron = 1
    group by CProf_Id
) y on y.Num = F.Num
Where F.Subj_Id = @Subj_Id
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end


Update FAnaliz set
	N01 = SN01, 
	N02 = SN02, 
	N10 = SN10, 
	N12 = SN12
from FAnaliz F
left join (select Sum(ff.N01) SN01, Sum(ff.N02) SN02, Sum(ff.N10) SN10, Sum(ff.N12) SN12
 from FAnaliz ff where FF.Subj_Id = @Subj_Id and FF.Num in (100,200,300,400)) x on 1=1
Where F.Subj_Id = @Subj_Id and F.Num = 2000


drop table [dbo].[#OrgSet] 

drop table [dbo].[#SubjSet]

COMMIT TRANSACTION

--select * from FAnaliz


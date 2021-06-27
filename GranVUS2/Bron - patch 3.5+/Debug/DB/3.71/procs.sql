ALTER     PROCEDURE [dbo].[sp_CalcSubjParams] -- changed in ver 3.71
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
   AND o.OUT_DATE IS NULL

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
where VerStr='3.71'
GO

ALTER     PROCEDURE [dbo].[sp_FFSGenerate] -- changed in ver 3.71
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
    raiserror 50300 'Ќевозможно создать форму по видам собственности.'
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
	raiserror 50301 'Ќевозможно создать форму по видам собственности.'
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
		raiserror 50302 'Ќевозможно создать форму по видам собственности.'
		ROLLBACK TRANSACTION
		return
	end
COMMIT TRANSACTION

GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлена процедура sp_FFSGenerate'
from VerInfo
where VerStr='3.71'
GO

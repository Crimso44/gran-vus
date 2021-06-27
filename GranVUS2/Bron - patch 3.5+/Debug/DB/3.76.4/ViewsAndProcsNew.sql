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
    raiserror 50300 'Ќевозможно создать форму по видам собственности.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0)
       ) O ON (O.FS_ID = K.FS_ID)
  GROUP BY K.FS_ID, K.FS_NAME, K.KOD

  if @@ERROR != 0
  begin
        raiserror 50301 'Ќевозможно создать форму по видам собственности.'
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
                raiserror 50302 'Ќевозможно создать форму по видам собственности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION


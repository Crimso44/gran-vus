Update Org Set OKBV = REPLACE(OKBV, 'A', 'А')
Update Org Set OKBV = REPLACE(OKBV, 'B', 'Б')

go


Alter table Org Alter Column INN Varchar(50)
go

Alter table Org Alter Column OrgName Varchar(500)
go

Alter table Form6Hdr Alter Column OrgName Varchar(500)
go

update KL_DATA set Disp_Name = 'Военные комиссариаты (администрации районов)' where Kl_Name = 'KOVK'
go

ALTER   VIEW [dbo].[v_ORG]
AS
SELECT     O.ORGID, O.TERR_ID, KTERR.NAME AS TERR, O.ORGNAME AS ORGNAME, O.OrgSName, O.URADDR, O.FIZADDR, O.POSTADDR, O.PHONE, O.OKPO, O.INN, O.OKBV,
                      O.FIRST_DATE, O.LAST_DATE, CAST(CASE WHEN FORM6HDR.F6_ID IS NULL THEN 0 ELSE 1 END AS bit) AS HAS_F6, O.SOOGU, O.PARENT,
                      O.MAINOKONH, O.OKONH, O.OCCUPATION,
                      O.FS_ID, KFS.KOD AS KFS_KOD, KFS.FS_NAME, KFS.KOD + ' - ' + KFS.FS_NAME AS KFS,
                      O.KOPF_ID, KOPF.KOD + ' - ' + KOPF.KOPF_NAME AS KOPF, O.KODREG, O.OKATO2, O.OKATO3, O.KODOKTMO, O.REGDATE, O.REGNUM,
                      O.REGPLACE AS REG_PLACE, O.COMMENT, O.OUT_REASON, O.OUT_DATE,
                      O.SBM_ID, VV5.KOD AS SBM_KOD, VV5.KOD + ' - ' + VV5.NAME AS SUBMISSION,
                      FORM6HDR.F6_ID, O.HAS_BRON, O.F6_SHIFR,
                      O.CHK_DATE AS CHK_DATE, FORM6HDR.RAB_COUNT, FORM6HDR.ZAP_COUNT, FORM6HDR.ZAB_COUNT, FORM6HDR.CHECKED AS F6CHECKED,
                      CASE WHEN (KFS.KOD = '12' OR KFS.KOD = '41' OR (KFS.KOD = '43' AND VV5.KOD = '01')) THEN 1
                      WHEN (KFS.KOD = '13' OR KFS.KOD = '14' OR KFS.KOD = '42' OR (KFS.KOD = '43' AND (VV5.KOD = '02' OR VV5.KOD = '03'))) THEN 2
                      ELSE 3 END AS KFP_ID,
                      O.Feature1,O.Feature2,O.Feature3,
                      O.OVK_ID,
                      HEAD.FIO AS HEADFAM, HEAD.PHONE AS HEADPHONE, HEAD.POST AS HEADPOST,
                      VUR.FIO AS VURFAM, VUR.PHONE AS VURPHONE, VUR.POST AS VURPOST,
					  o.kopf_changed, o.Email, o.okved_changed, o.SBM
FROM         ORG O LEFT JOIN
                      KTERR ON O.TERR_ID = KTERR.TERR_ID LEFT JOIN
                      KFS ON O.FS_ID = KFS.FS_ID LEFT JOIN
                      KOPF ON O.KOPF_ID = KOPF.KOPF_ID LEFT JOIN
                      VV5 ON O.SBM_ID = VV5.ID LEFT JOIN
                      FORM6HDR ON O.ORGID = FORM6HDR.ORGID LEFT JOIN
                      ORG_CONT HEAD ON O.ORGID = HEAD.ORGID and HEAD.IS_GEN = 1 LEFT JOIN
                      ORG_CONT VUR ON O.ORGID = VUR.ORGID and VUR.IS_VUS = 1


GO


ALTER VIEW [dbo].[v_ORG_01]
AS
SELECT *
FROM v_ORG
WHERE OUT_DATE IS NULL
go

ALTER VIEW [dbo].[v_ORG_02]
AS
SELECT *
FROM v_ORG
WHERE ((F6_SHIFR = '02') OR (F6_SHIFR = '03')) AND (OUT_DATE IS NULL)
go

ALTER VIEW [dbo].[v_ORG_03]
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '03') AND (OUT_DATE IS NULL)
go

ALTER VIEW [dbo].[v_ORG_04]
AS
SELECT *
FROM v_ORG
WHERE ((F6_SHIFR = '04') OR (F6_SHIFR = '05') OR (F6_SHIFR = '06')) AND (OUT_DATE IS NULL)
go

ALTER VIEW [dbo].[v_ORG_05]
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '05') AND (OUT_DATE IS NULL)
go

ALTER VIEW [dbo].[v_ORG_06]
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '06') AND (OUT_DATE IS NULL)
go

ALTER VIEW [dbo].[v_ORG_CALC]
AS
SELECT     dbo.ORG.ORGID
FROM         dbo.ORG INNER JOIN
                      dbo.SUBJ ON dbo.ORG.TERR_ID = dbo.SUBJ.TERR_ID AND dbo.SUBJ.SUBJ_AGG_ID = 1
GO


Alter PROCEDURE [dbo].[sp_CalcSubjParams377] -- changed in ver 3.71
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
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '67' and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '7' or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '850' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '898') or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '950' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '998'))) 
                                	then f6.col_1 else 0 end))/1000,1)
                , @TOWN = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or 

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
                            SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '67' and
                            SUBSTRING(ISNULL(KODOKTMO,0),6,1) in ('1','4','7') and
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '810' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '910' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '1' then f6.col_1 else 0 end))/1000,1)
                , @VILLAGE = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
                            SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '67' and
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '810' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '910' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then f6.col_1 else 0 end))/1000,1)
                , @TOWNVILLAGE = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
                            SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '67' and
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '810' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '910' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '7' then f6.col_1 else 0 end))/1000,1)
                , @INCITY = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '40' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '45' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '67') and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '3' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '9') then f6.col_1 else 0 end))/1000,1)
  FROM v_ORG oo
     join SUBJ s on oo.TERR_ID = s.TERR_ID
     join KTERR t on oo.TERR_ID = t.TERR_ID
     join FORM6HDR f6h on f6h.ORGID = oo.ORGID
     join FORM6 f6 on f6.F6_ID = f6h.F6_ID and f6.col_b = 5
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


go


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
    raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
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
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '67' and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '7' or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '850' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '898') or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '950' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '998'))) 
                        
                                	then 1 else 0 end
                , TOWN = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or 

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
                            SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '67' and
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '810' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '910' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '1' then 1 else 0 end
                , VILLAGE = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
                            SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '67' and
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '810' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '910' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 1 else 0 end
                , TOWNVILLAGE = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
                            SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '67' and
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '810' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '910' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '7' then 1 else 0 end
                , INCITY = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '40' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '45' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '67') and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '3' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '9') then 1 else 0 end
        from v_ORG OO
        where OO.OUT_DATE IS NULL
          AND OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
                and EXISTS(SELECT * FROM FORM6HDR, FORM6
                                     WHERE FORM6HDR.OrgID=OO.ORGID
                                       AND FORM6.F6_ID=FORM6HDR.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
       ) O ON (O.FS_ID = K.FS_ID)
  GROUP BY K.FS_ID, K.FS_NAME, K.KOD

  if @@ERROR != 0
  begin
        raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
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
                raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION


GO

Alter Table KOVK Alter Column OVK_NAME Varchar(250)
go


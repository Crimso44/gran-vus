IF NOT EXISTS(SELECT 1 FROM syscolumns WHERE NAME = 'KODOKTMO' AND OBJECT_NAME(id) = 'ORG')
        ALTER TABLE ORG ADD KODOKTMO varchar(20)
GO

Alter Table FORM6 Add COL_10T Varchar(100)
Alter Table FORM6 Add COL_12T Varchar(100)

Alter Table ORG Add KODOKTMO2 Varchar(20)
Alter Table ORG Add REGPLACE Varchar(100)
Alter Table ORG Add COMPUTERS Integer
Alter Table ORG Add SOFTWARENUM Integer
Alter Table ORG Add SOFTWARE Varchar(255)

go

if not exists (select * from syscolumns where name = 'ISOVK' and object_name(id)='KOVK')
ALTER TABLE dbo.KOVK ADD
        ISOVK bit NULL
go

Alter Table Org Alter Column Out_Reason varchar(160)
go

Alter Table Org Alter Column OrgSName varchar(250)
go

alter table KOVK Alter Column OVK_Phone Varchar(250)
go
alter table KL_Data Alter Column Disp_Name Varchar(150)
go
alter table KL_Fld Alter Column Disp_Name Varchar(150)
go
update KL_Data set Disp_Name = 'Отделы военных комиссариатов (администрации районов)' where KL_Name = 'KOVK'
go
update KL_Fld set Disp_Name = 'Переменная часть наименования органа, ведущего первичный воинский учет "Отдел военного комиссариата ..." или "Администрация ..."' where Fld_Name = 'OVK_NAME' and KL_Id = (Select x.KL_Id from KL_Data x Where KL_Name = 'KOVK')
go
update KL_Fld set Disp_Size = 200, Disp_Name = 'Дополнительная информация' where Fld_Name = 'OVK_PHONE' and KL_Id = (Select x.KL_Id from KL_Data x Where KL_Name = 'KOVK')
go
Insert Into KL_Fld (KL_Id, Fld_Name, Disp_Name, Disp_Size, Is_Key, Is_Edit, Visible, Has_Null)
Select (Select KL_Id from KL_Data Where KL_Name = 'KOVK'),
    'ISOVK', 'Первичный воинский учет ведет ОВК (не отмечено - учет ведет Администрация)',
    200, 0, 1, 1, 1
go

Alter VIEW KFS_ AS
SELECT FS_ID, FS_NAME, KOD=ISNULL(KOD,'00') FROM KFS WHERE ForForm<>0
UNION
SELECT 0, 'Прочие', 'ZZ'

go


Alter VIEW KOKVED_ AS
      SELECT N = ASCII(OKVED_SECTION)-ASCII('A')+1, * FROM KOKVED
UNION SELECT (SELECT COUNT(*)+1 FROM KOKVED), '_','Прочее',0,0


go

Alter VIEW dbo.v_ORG_CALC
AS
SELECT     dbo.ORG.ORGID
FROM         dbo.ORG INNER JOIN
                      dbo.SUBJ ON dbo.ORG.TERR_ID = dbo.SUBJ.TERR_ID AND dbo.SUBJ.SUBJ_AGG_ID = 1

go

Alter VIEW dbo.v_PER77T
AS
SELECT DISTINCT ORGID
FROM         dbo.PER
WHERE (PER_NO LIKE '77-T%' OR PER_NO LIKE '77-Т%')
AND   (END_DATE IS NULL OR END_DATE>=getdate())

go

Alter VIEW dbo.v_SUBJ
AS
SELECT     dbo.SUBJ.SUBJ_ID, dbo.SUBJ.TYPE_ID, dbo.SUBJ.TERR_ID, dbo.SUBJ.ORGID, dbo.SUBJ.SUBJ_NAME, dbo.SUBJ.SUBJ_FULLNAME,
                      dbo.SUBJ.SUBJ_ADDRESS, dbo.SUBJ.REPORT_DATE,
        dbo.KTERR.KODTERR, dbo.KTERR.NAME AS TERRNAME, dbo.KTERR.KODTERR + ' - ' + dbo.KTERR.NAME AS TERR,
                      dbo.SUBJ_TYPE.TYPE_NAME, dbo.SUBJ.SUBJ_AGG_ID, dbo.SUBJ_AGG_TYPE.SUBJ_AGG_NAME
FROM         dbo.SUBJ INNER JOIN
                      dbo.KTERR ON dbo.SUBJ.TERR_ID = dbo.KTERR.TERR_ID INNER JOIN
                      dbo.SUBJ_TYPE ON dbo.SUBJ.TYPE_ID = dbo.SUBJ_TYPE.TYPE_ID INNER JOIN
                      dbo.SUBJ_AGG_TYPE ON dbo.SUBJ.SUBJ_AGG_ID = dbo.SUBJ_AGG_TYPE.SUBJ_AGG_ID


GO


Alter VIEW dbo.v_SUBJ_CALC
AS
SELECT     SUBJ_ID
FROM         dbo.SUBJ
WHERE     SUBJ_AGG_ID = 2

GO


ALTER   VIEW [dbo].[v_ORG]
AS
SELECT     O.ORGID, O.TERR_ID, KTERR.NAME AS TERR, O.ORGNAME AS ORGNAME, O.OrgSName, O.URADDR, O.FIZADDR, O.POSTADDR, O.PHONE, O.OKPO, O.INN, O.OKBV,
                      O.FIRST_DATE, O.LAST_DATE, CAST(CASE WHEN FORM6HDR.F6_ID IS NULL THEN 0 ELSE 1 END AS bit) AS HAS_F6, O.SOOGU, O.PARENT,
                      O.MAINOKONH, O.OKONH, O.OCCUPATION,
                      O.FS_ID, KFS.KOD AS KFS_KOD, KFS.FS_NAME, KFS.KOD + ' - ' + KFS.FS_NAME AS KFS,
                      O.KOPF_ID, KOPF.KOD + ' - ' + KOPF.KOPF_NAME AS KOPF, O.KODREG, O.KODOKTMO, O.REGDATE, O.REGNUM,
                      O.REGPLACE AS REG_PLACE, O.COMMENT, O.OUT_REASON, O.OUT_DATE,
                      O.SBM_ID, VV5.KOD AS SBM_KOD, VV5.KOD + ' - ' + VV5.NAME AS SUBMISSION,
                      FORM6HDR.F6_ID, O.HAS_BRON, O.F6_SHIFR,
                      O.CHK_DATE AS CHK_DATE, FORM6HDR.RAB_COUNT, FORM6HDR.ZAP_COUNT, FORM6HDR.ZAB_COUNT, FORM6HDR.CHECKED AS F6CHECKED,
                      CASE WHEN (KFS.KOD = '12' OR KFS.KOD = '41' OR (KFS.KOD = '43' AND VV5.KOD = '01')) THEN 1
                      WHEN (KFS.KOD = '13' OR KFS.KOD = '14' OR KFS.KOD = '42' OR (KFS.KOD = '43' AND (VV5.KOD = '02' OR VV5.KOD = '03'))) THEN 2
                      ELSE 3 END AS KFP_ID,
                      O.Feature1,O.Feature2,O.Feature3,
                      O.OVK_ID,
                      HEAD.FIO AS HEADFAM, HEAD.PHONE AS HEADPHONE,
                      VUR.FIO AS VURFAM, VUR.PHONE AS VURPHONE
FROM         ORG O LEFT JOIN
                      KTERR ON O.TERR_ID = KTERR.TERR_ID LEFT JOIN
                      KFS ON O.FS_ID = KFS.FS_ID LEFT JOIN
                      KOPF ON O.KOPF_ID = KOPF.KOPF_ID LEFT JOIN
                      VV5 ON O.SBM_ID = VV5.ID LEFT JOIN
                      FORM6HDR ON O.ORGID = FORM6HDR.ORGID LEFT JOIN
                      ORG_CONT HEAD ON O.ORGID = HEAD.ORGID and HEAD.IS_GEN = 1 LEFT JOIN
                      ORG_CONT VUR ON O.ORGID = VUR.ORGID and VUR.IS_VUS = 1

GO



GO




Alter VIEW dbo.v_ORG_01
AS
SELECT *
FROM v_ORG
WHERE OUT_DATE IS NULL


GO



Alter VIEW dbo.v_ORG_02
AS
SELECT *
FROM v_ORG
WHERE ((F6_SHIFR = '02') OR (F6_SHIFR = '03')) AND (OUT_DATE IS NULL)


GO



Alter VIEW dbo.v_ORG_03
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '03') AND (OUT_DATE IS NULL)


GO

Alter VIEW dbo.v_ORG_04
AS
SELECT *
FROM v_ORG
WHERE ((F6_SHIFR = '04') OR (F6_SHIFR = '05') OR (F6_SHIFR = '06')) AND (OUT_DATE IS NULL)
GO


Alter VIEW dbo.v_ORG_05
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '05') AND (OUT_DATE IS NULL)
GO


Alter VIEW dbo.v_ORG_06
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '06') AND (OUT_DATE IS NULL)

GO

ALTER PROCEDURE [dbo].[sp_GenerateForm6_01]
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
                raiserror 50700 'Невозможно сформировать агрегированную форму  6.01.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 50701 'Невозможно сформировать агрегированную форму  6.01.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50702 'Невозможно сформировать агрегированную форму  6.01.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 50703 'Невозможно сформировать агрегированную форму  6.01.'
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
                raiserror 50704 'Невозможно сформировать агрегированную форму  6.01.'
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
                raiserror 50705 'Невозможно сформировать агрегированную форму  6.01.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50706 'Невозможно сформировать агрегированную форму  6.01.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50707 'Невозможно сформировать агрегированную форму  6.01.'
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
                raiserror 50708 'Невозможно сформировать агрегированную форму  6.01.'
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
                raiserror 50709 'Невозможно сформировать агрегированную форму  6.01.'
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
                raiserror 50710 'Невозможно сформировать агрегированную форму  6.01.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

go

ALTER PROCEDURE [dbo].[sp_GenerateForm6_02]
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
                raiserror 50800 'Невозможно сформировать агрегированную форму  6.02.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 50801 'Невозможно сформировать агрегированную форму  6.01.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50802 'Невозможно сформировать агрегированную форму  6.02.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 50803 'Невозможно сформировать агрегированную форму  6.02.'
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
                raiserror 50804 'Невозможно сформировать агрегированную форму  6.02.'
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
                raiserror 50805 'Невозможно сформировать агрегированную форму  6.02.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50806 'Невозможно сформировать агрегированную форму  6.02.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50807 'Невозможно сформировать агрегированную форму  6.02.'
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
                raiserror 50808 'Невозможно сформировать агрегированную форму  6.02.'
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
                raiserror 50809 'Невозможно сформировать агрегированную форму  6.02.'
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
                raiserror 50810 'Невозможно сформировать агрегированную форму  6.02.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

go

ALTER PROCEDURE [dbo].[sp_GenerateForm6_03]
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
                raiserror 50900 'Невозможно сформировать агрегированную форму  6.03.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 50901 'Невозможно сформировать агрегированную форму  6.03.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50902 'Невозможно сформировать агрегированную форму  6.03.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 50903 'Невозможно сформировать агрегированную форму  6.03.'
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
                raiserror 50904 'Невозможно сформировать агрегированную форму  6.03.'
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
                raiserror 50905 'Невозможно сформировать агрегированную форму  6.03.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50906 'Невозможно сформировать агрегированную форму  6.03.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50907 'Невозможно сформировать агрегированную форму  6.03.'
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
                raiserror 50908 'Невозможно сформировать агрегированную форму  6.03.'
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
                raiserror 50909 'Невозможно сформировать агрегированную форму  6.03.'
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
                raiserror 50910 'Невозможно сформировать агрегированную форму  6.03.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

go

ALTER  PROCEDURE [dbo].[sp_GenerateForm6_04]
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
                raiserror 51700 'Невозможно сформировать агрегированную форму  6.04.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 51701 'Невозможно сформировать агрегированную форму  6.04.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 51702 'Невозможно сформировать агрегированную форму  6.04.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 51703 'Невозможно сформировать агрегированную форму  6.04.'
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
                raiserror 51704 'Невозможно сформировать агрегированную форму  6.04.'
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
                raiserror 51705 'Невозможно сформировать агрегированную форму  6.04.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51706 'Невозможно сформировать агрегированную форму  6.04.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51707 'Невозможно сформировать агрегированную форму  6.04.'
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
                raiserror 51708 'Невозможно сформировать агрегированную форму  6.04.'
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
                raiserror 51709 'Невозможно сформировать агрегированную форму  6.04.'
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
                raiserror 51710 'Невозможно сформировать агрегированную форму  6.04.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

go

ALTER  PROCEDURE [dbo].[sp_GenerateForm6_05]
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
                raiserror 51800 'Невозможно сформировать агрегированную форму  6.05.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 51801 'Невозможно сформировать агрегированную форму  6.05.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 51802 'Невозможно сформировать агрегированную форму  6.05.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 51803 'Невозможно сформировать агрегированную форму  6.05.'
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
                raiserror 51804 'Невозможно сформировать агрегированную форму  6.05.'
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
                raiserror 51805 'Невозможно сформировать агрегированную форму  6.05.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51806 'Невозможно сформировать агрегированную форму  6.05.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51807 'Невозможно сформировать агрегированную форму  6.05.'
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
                raiserror 51808 'Невозможно сформировать агрегированную форму  6.05.'
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
                raiserror 51809 'Невозможно сформировать агрегированную форму  6.05.'
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
                raiserror 51810 'Невозможно сформировать агрегированную форму  6.05.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

go

ALTER  PROCEDURE [dbo].[sp_GenerateForm6_06]
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
                raiserror 51900 'Невозможно сформировать агрегированную форму  6.06.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 51901 'Невозможно сформировать агрегированную форму  6.06.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 51902 'Невозможно сформировать агрегированную форму  6.06.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = 1500
        if @@ERROR != 0
        begin
                raiserror 51903 'Невозможно сформировать агрегированную форму  6.06.'
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
                raiserror 51904 'Невозможно сформировать агрегированную форму  6.06.'
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
                raiserror 51905 'Невозможно сформировать агрегированную форму  6.06.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51906 'Невозможно сформировать агрегированную форму  6.06.'
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
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_11,0)>0)
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51907 'Невозможно сформировать агрегированную форму  6.06.'
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
                raiserror 51908 'Невозможно сформировать агрегированную форму  6.06.'
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
                raiserror 51909 'Невозможно сформировать агрегированную форму  6.06.'
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
                raiserror 51910 'Невозможно сформировать агрегированную форму  6.06.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

go

alter table KCPROF Alter Column CPROF_NAME varchar(100)
alter table KCPROF Alter Column PRINT_NAME varchar(100)
alter table FORM6 Alter Column PRINT_NAME varchar(100)

go

Update KCPROF Set STATE = -1, PRINT_NAME = 'Специалисты - всего, из них по основным видам экономической деятельности',
        EXPRESSION = '210+221+231+241+251+271+281+291+295'
Where CPROF_ID = 200
Update FORM6 Set PRINT_NAME = 'Специалисты - всего, из них по основным видам экономической деятельности',
        EXPRESSION = '210+221+231+241+251+271+281+291+295'
Where CPROF_ID = 200

Update KCPROF Set PRINT_NAME = 'A. Сельское хозяйство'
Where CPROF_ID = 210

Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO)
Values (221, 'Специалисты по добыче полезных ископаемых', 'C. Добыча полезных ископаемых', ' ', 0, 4)
Insert Into FORM6 (F6_ID, CPROF_ID, PRINT_NAME, EXPRESSION, COL_B)
Select Distinct F6_ID, 221, 'C. Добыча полезных ископаемых', ' ', 4 From FORM6

Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO)
Values (231, 'Специалисты по обрабатывающему производству', 'D. Обрабатывающие производства', ' ', 0, 5)
Insert Into FORM6 (F6_ID, CPROF_ID, PRINT_NAME, EXPRESSION, COL_B)
Select Distinct F6_ID, 231, 'D. Обрабатывающие производства', ' ', 5 From FORM6

Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO)
Values (241, 'Специалисты по производству и распределению электроэнергии, газа и воды', 'E. Производство и распределение электроэнергии, газа и воды', ' ', 0, 6)
Insert Into FORM6 (F6_ID, CPROF_ID, PRINT_NAME, EXPRESSION, COL_B)
Select Distinct F6_ID, 241, 'E. Производство и распределение электроэнергии, газа и воды', ' ', 6 From FORM6

Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO)
Values (251, 'Специалисты по строительству', 'F. Строительство', ' ', 0, 7)
Insert Into FORM6 (F6_ID, CPROF_ID, PRINT_NAME, EXPRESSION, COL_B)
Select Distinct F6_ID, 251, 'F. Строительство', ' ', 7 From FORM6

Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO)
Values (271, 'Специалисты по транспорту и связи', 'I. Транспорт и связь', ' ', 0, 8)
Insert Into FORM6 (F6_ID, CPROF_ID, PRINT_NAME, EXPRESSION, COL_B)
Select Distinct F6_ID, 271, 'I. Транспорт и связь', ' ', 8 From FORM6

Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO)
Values (281, 'Специалисты образования', 'M. Образование', ' ', 0, 9)
Insert Into FORM6 (F6_ID, CPROF_ID, PRINT_NAME, EXPRESSION, COL_B)
Select Distinct F6_ID, 281, 'M. Образование', ' ', 9 From FORM6

Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO)
Values (291, 'Специалисты по здравоохранению и предоставлению социальных услуг', 'N. Здравоохранение и предоставление социальных услуг', ' ', 0, 10)
Insert Into FORM6 (F6_ID, CPROF_ID, PRINT_NAME, EXPRESSION, COL_B)
Select Distinct F6_ID, 291, 'N. Здравоохранение и предоставление социальных услуг', ' ', 10 From FORM6

Update KCPROF Set LINE_NO = LINE_NO + 1 Where LINE_NO Between 11 and 13
Update Form6 Set COL_B = COL_B + 1 Where COL_B Between 11 and 13

Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO)
Values (295, 'Специалисты прочих видов экономической деятельности', 'прочие виды экономической деятельности', ' ', 0, 11)
Insert Into FORM6 (F6_ID, CPROF_ID, PRINT_NAME, EXPRESSION, COL_B)
Select Distinct F6_ID, 295, 'прочие виды экономической деятельности', ' ', 11 From FORM6

Update KCPROF Set EXPRESSION = '410+440+450+460+470+480', PRINT_NAME = 'Рабочие - всего, в том числе:'
Where CPROF_ID = 400
Update FORM6 Set EXPRESSION = '410+440+450+460+470+480', PRINT_NAME = 'Рабочие - всего, в том числе:'
Where CPROF_ID = 400

Update KCPROF Set
        CPROF_NAME = 'Рабочие, имеющие тарифный разряд',
        PRINT_NAME = '- имеющие тарифный разряд'
Where CPROF_ID = 410
Update FORM6 Set
        PRINT_NAME = '- имеющие тарифный разряд'
Where CPROF_ID = 410

Update KCPROF Set
        PRINT_NAME = 'Из численности руководителей, специалистов и рабочих:'
Where CPROF_ID = 490
Update FORM6 Set
        PRINT_NAME = 'Из численности руководителей, специалистов и рабочих:'
Where CPROF_ID = 490

Update KCPROF Set LINE_NO = Null
Where CPROF_ID = 500

Update KCPROF Set PRINT_NAME = 'ИТОГО (сумма строк 1+2+12+13)',
       EXPRESSION = '100+200+300+400'
Where CPROF_ID = 1000
Update FORM6 Set PRINT_NAME = 'ИТОГО (сумма строк 1+2+12+13)',
       EXPRESSION = '100+200+300+400'
Where CPROF_ID = 1000

Update KCPROF Set PRINT_NAME = 'ВСЕГО (сумма строк 22+23)'
       Where CPROF_ID = 2000
Update FORM6 Set PRINT_NAME = 'ВСЕГО (сумма строк 22+23)'
       Where CPROF_ID = 2000

Update KCPROF Set LINE_NO = LINE_NO - 1 Where LINE_NO Between 16 and 22
Update KCPROF Set LINE_NO = LINE_NO - 2 Where LINE_NO > 23
Update Form6 Set COL_B = COL_B - 1 Where COL_B Between 16 and 22
Update Form6 Set COL_B = COL_B - 2 Where COL_B > 23


Update Form6 Set
        Col_4 = IsNull(Col_4, 0)+IsNull(Col_5,0),
        Col_5 = Col_6, Col_6 = Col_7, Col_7 = Col_8,
        Col_8 = IsNull(Col_9, 0)+IsNull(Col_10,0)+IsNull(Col_11,0)+IsNull(Col_12,0)+IsNull(Col_13,0),
        Col_9 = Col_14, Col_10 = Col_16, Col_11 = Col_15

Update FORM6 Set
        Col_1 = IsNull(SCol_1,0)+ISNULL(SXCol_1,0), Col_2 = IsNull(SCol_2,0)+ISNULL(SXCol_2,0),
        Col_3 = IsNull(SCol_3,0)+ISNULL(SXCol_3,0), Col_4 = IsNull(SCol_4,0)+ISNULL(SXCol_4,0),
        Col_5 = IsNull(SCol_5,0)+ISNULL(SXCol_5,0),     Col_6 = IsNull(SCol_6,0)+ISNULL(SXCol_6,0),
        Col_7 = IsNull(SCol_7,0)+ISNULL(SXCol_7,0), Col_8 = IsNull(SCol_8,0)+ISNULL(SXCol_8,0),
        Col_9 = IsNull(SCol_9,0)+ISNULL(SXCol_9,0), Col_10 = IsNull(SCol_10,0)+ISNULL(SXCol_10,0),
        Col_11 = IsNull(SCol_11,0)+ISNULL(SXCol_11,0)
From Form6 f
left Join (
        select F6_ID,
                SCol_1 = Sum(Col_1), SCol_2 = Sum(Col_2), SCol_3 = Sum(Col_3), SCol_4 = Sum(Col_4), SCol_5 = Sum(Col_5),
                SCol_6 = Sum(Col_6), SCol_7 = Sum(Col_7), SCol_8 = Sum(Col_8), SCol_9 = Sum(Col_9), SCol_10 = Sum(Col_10),
                SCol_11 = Sum(Col_11)
        from Form6 ff Where CPROF_ID in (250)
        Group by F6_ID
) x on x.F6_ID = f.F6_ID
left Join (
        select F6_ID,
                SXCol_1 = Sum(Col_1)/2, SXCol_2 = Sum(Col_2)/2, SXCol_3 = Sum(Col_3)/2, SXCol_4 = Sum(Col_4)/2, SXCol_5 = Sum(Col_5)/2,
                SXCol_6 = Sum(Col_6)/2, SXCol_7 = Sum(Col_7)/2, SXCol_8 = Sum(Col_8)/2, SXCol_9 = Sum(Col_9)/2, SXCol_10 = Sum(Col_10)/2,
                SXCol_11 = Sum(Col_11)/2
        from Form6 ff Where CPROF_ID in (500)
        Group by F6_ID
) y on y.F6_ID = f.F6_ID
Where f.CPROF_ID = 281

Update FORM6 Set
        Col_1 = SCol_1, Col_2 = SCol_2, Col_3 = SCol_3, Col_4 = SCol_4, Col_5 = SCol_5,
        Col_6 = SCol_6, Col_7 = SCol_7, Col_8 = SCol_8, Col_9 = SCol_9, Col_10 = SCol_10,
        Col_11 = SCol_11
From Form6 f
Join (
        select F6_ID,
                SCol_1 = Sum(Col_1), SCol_2 = Sum(Col_2), SCol_3 = Sum(Col_3), SCol_4 = Sum(Col_4), SCol_5 = Sum(Col_5),
                SCol_6 = Sum(Col_6), SCol_7 = Sum(Col_7), SCol_8 = Sum(Col_8), SCol_9 = Sum(Col_9), SCol_10 = Sum(Col_10),
                SCol_11 = Sum(Col_11)
        from Form6 ff Where CPROF_ID in (264, 265)
        Group by F6_ID
) x on x.F6_ID = f.F6_ID
Where f.CPROF_ID = 291


Update FORM6 Set
        Col_1 = IsNull(SCol_1,0)+ISNULL(SXCol_1,0), Col_2 = IsNull(SCol_2,0)+ISNULL(SXCol_2,0),
        Col_3 = IsNull(SCol_3,0)+ISNULL(SXCol_3,0), Col_4 = IsNull(SCol_4,0)+ISNULL(SXCol_4,0),
        Col_5 = IsNull(SCol_5,0)+ISNULL(SXCol_5,0), Col_6 = IsNull(SCol_6,0)+ISNULL(SXCol_6,0),
        Col_7 = IsNull(SCol_7,0)+ISNULL(SXCol_7,0), Col_8 = IsNull(SCol_8,0)+ISNULL(SXCol_8,0),
        Col_9 = IsNull(SCol_9,0)+ISNULL(SXCol_9,0), Col_10 = IsNull(SCol_10,0)+ISNULL(SXCol_10,0),
        Col_11 = IsNull(SCol_11,0)+ISNULL(SXCol_11,0)
From Form6 f
left Join (
        select F6_ID,
                SCol_1 = Sum(Col_1), SCol_2 = Sum(Col_2), SCol_3 = Sum(Col_3), SCol_4 = Sum(Col_4), SCol_5 = Sum(Col_5),
                SCol_6 = Sum(Col_6), SCol_7 = Sum(Col_7), SCol_8 = Sum(Col_8), SCol_9 = Sum(Col_9), SCol_10 = Sum(Col_10),
                SCol_11 = Sum(Col_11)
        from Form6 ff Where CPROF_ID in (200)
        Group by F6_ID
) x on x.F6_ID = f.F6_ID
left Join (
        select F6_ID,
                SXCol_1 = Sum(Col_1)/2, SXCol_2 = Sum(Col_2)/2, SXCol_3 = Sum(Col_3)/2, SXCol_4 = Sum(Col_4)/2, SXCol_5 = Sum(Col_5)/2,
                SXCol_6 = Sum(Col_6)/2, SXCol_7 = Sum(Col_7)/2, SXCol_8 = Sum(Col_8)/2, SXCol_9 = Sum(Col_9)/2, SXCol_10 = Sum(Col_10)/2,
                SXCol_11 = Sum(Col_11)/2
        from Form6 ff Where CPROF_ID in (500)
        Group by F6_ID
) y on y.F6_ID = f.F6_ID
Where f.CPROF_ID = 200


Update FORM6 Set
        Col_1 = IsNull(SCol_1,0)-ISNULL(SXCol_1,0)-ISNULL(SXXCol_1,0), Col_2 = IsNull(SCol_2,0)-ISNULL(SXCol_2,0)-ISNULL(SXXCol_2,0),
        Col_3 = IsNull(SCol_3,0)-ISNULL(SXCol_3,0)-ISNULL(SXXCol_3,0), Col_4 = IsNull(SCol_4,0)-ISNULL(SXCol_4,0)-ISNULL(SXXCol_4,0),
        Col_5 = IsNull(SCol_5,0)-ISNULL(SXCol_5,0)-ISNULL(SXXCol_5,0), Col_6 = IsNull(SCol_6,0)-ISNULL(SXCol_6,0)-ISNULL(SXXCol_6,0),
        Col_7 = IsNull(SCol_7,0)-ISNULL(SXCol_7,0)-ISNULL(SXXCol_7,0), Col_8 = IsNull(SCol_8,0)-ISNULL(SXCol_8,0)-ISNULL(SXXCol_8,0),
        Col_9 = IsNull(SCol_9,0)-ISNULL(SXCol_9,0)-ISNULL(SXXCol_9,0), Col_10 = IsNull(SCol_10,0)-ISNULL(SXCol_10,0)-ISNULL(SXXCol_10,0),
        Col_11 = IsNull(SCol_11,0)-ISNULL(SXCol_11,0)-ISNULL(SXXCol_11,0)
From Form6 f
left Join (
        select F6_ID,
                SCol_1 = Sum(Col_1), SCol_2 = Sum(Col_2), SCol_3 = Sum(Col_3), SCol_4 = Sum(Col_4), SCol_5 = Sum(Col_5),
                SCol_6 = Sum(Col_6), SCol_7 = Sum(Col_7), SCol_8 = Sum(Col_8), SCol_9 = Sum(Col_9), SCol_10 = Sum(Col_10),
                SCol_11 = Sum(Col_11)
        from Form6 ff Where CPROF_ID in (200)
        Group by F6_ID
) x on x.F6_ID = f.F6_ID
left Join (
        select F6_ID,
                SXXCol_1 = Sum(Col_1), SXXCol_2 = Sum(Col_2), SXXCol_3 = Sum(Col_3), SXXCol_4 = Sum(Col_4), SXXCol_5 = Sum(Col_5),
                SXXCol_6 = Sum(Col_6), SXXCol_7 = Sum(Col_7), SXXCol_8 = Sum(Col_8), SXXCol_9 = Sum(Col_9), SXXCol_10 = Sum(Col_10),
                SXXCol_11 = Sum(Col_11)
        from Form6 ff Where CPROF_ID in (210, 250, 264, 265)
        Group by F6_ID
) xx on xx.F6_ID = f.F6_ID
left Join (
        select F6_ID,
                SXCol_1 = Sum(Col_1)/2, SXCol_2 = Sum(Col_2)/2, SXCol_3 = Sum(Col_3)/2, SXCol_4 = Sum(Col_4)/2, SXCol_5 = Sum(Col_5)/2,
                SXCol_6 = Sum(Col_6)/2, SXCol_7 = Sum(Col_7)/2, SXCol_8 = Sum(Col_8)/2, SXCol_9 = Sum(Col_9)/2, SXCol_10 = Sum(Col_10)/2,
                SXCol_11 = Sum(Col_11)/2
        from Form6 ff Where CPROF_ID in (500)
        Group by F6_ID
) y on y.F6_ID = f.F6_ID
Where f.CPROF_ID = 295


Update FORM6 Set
        Col_1 = SCol_1, Col_2 = SCol_2, Col_3 = SCol_3, Col_4 = SCol_4, Col_5 = SCol_5,
        Col_6 = SCol_6, Col_7 = SCol_7, Col_8 = SCol_8, Col_9 = SCol_9, Col_10 = SCol_10,
        Col_11 = SCol_11
From Form6 f
Join (
        select F6_ID,
                SCol_1 = Sum(Col_1), SCol_2 = Sum(Col_2), SCol_3 = Sum(Col_3), SCol_4 = Sum(Col_4), SCol_5 = Sum(Col_5),
                SCol_6 = Sum(Col_6), SCol_7 = Sum(Col_7), SCol_8 = Sum(Col_8), SCol_9 = Sum(Col_9), SCol_10 = Sum(Col_10),
                SCol_11 = Sum(Col_11)
        from Form6 ff Where CPROF_ID in (410, 420, 430)
        Group by F6_ID
) x on x.F6_ID = f.F6_ID
Where f.CPROF_ID = 410


Update FORM6 Set
        Col_1 = SCol_1, Col_2 = SCol_2, Col_3 = SCol_3, Col_4 = SCol_4, Col_5 = SCol_5,
        Col_6 = SCol_6, Col_7 = SCol_7, Col_8 = SCol_8, Col_9 = SCol_9, Col_10 = SCol_10,
        Col_11 = SCol_11
From Form6 f
Join (
        select F6_ID,
                SCol_1 = Sum(Col_1), SCol_2 = Sum(Col_2), SCol_3 = Sum(Col_3), SCol_4 = Sum(Col_4), SCol_5 = Sum(Col_5),
                SCol_6 = Sum(Col_6), SCol_7 = Sum(Col_7), SCol_8 = Sum(Col_8), SCol_9 = Sum(Col_9), SCol_10 = Sum(Col_10),
                SCol_11 = Sum(Col_11)
        from Form6 ff Where CPROF_ID in (100, 200, 300, 400)
        Group by F6_ID
) x on x.F6_ID = f.F6_ID
Where f.CPROF_ID = 1000


Update FORM6 Set
        Col_1 = SCol_1, Col_2 = SCol_2, Col_3 = SCol_3, Col_4 = SCol_4, Col_5 = SCol_5,
        Col_6 = SCol_6, Col_7 = SCol_7, Col_8 = SCol_8, Col_9 = SCol_9, Col_10 = SCol_10,
        Col_11 = SCol_11
From Form6 f
Join (
        select F6_ID,
                SCol_1 = Sum(Col_1), SCol_2 = Sum(Col_2), SCol_3 = Sum(Col_3), SCol_4 = Sum(Col_4), SCol_5 = Sum(Col_5),
                SCol_6 = Sum(Col_6), SCol_7 = Sum(Col_7), SCol_8 = Sum(Col_8), SCol_9 = Sum(Col_9), SCol_10 = Sum(Col_10),
                SCol_11 = Sum(Col_11)
        from Form6 ff Where CPROF_ID in (1000, 1500)
        Group by F6_ID
) x on x.F6_ID = f.F6_ID
Where f.CPROF_ID = 2000



Delete From FORM6 Where CPROF_ID in (205, 220, 230, 240, 250, 260, 261, 264, 265, 401, 420, 430, 491)
Delete From KCPROF Where CPROF_ID in (205, 220, 230, 240, 250, 260, 261, 264, 265, 401, 420, 430, 491)

go

Update Form6 set col_10 = IsNull(col_2,0) - IsNull(col_6,0) - IsNull(col_9, 0)

go

UPDATE org SET regplace = regpl_name
From org
inner join kregpl on kregpl.regpl_id = org.regpl_id


go

alter table VV5 Alter Column NAME varchar(100)
UPDATE VV5 SET NAME = 'Федеральные органы исполнительной власти (ФОИВ)' WHERE KOD = '01'
UPDATE VV5 SET NAME = 'Субъекты РФ' WHERE KOD = '04'
UPDATE Org SET SBM_ID = 4 Where SBM_ID in (2,3)
Delete From VV5 Where ID in (2,3)


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



go



if not exists (select * from syscolumns where name = 'COL_10T' and object_name(id)='FORM6')
Alter Table FORM6 Add COL_10T Varchar(100)
go
if not exists (select * from syscolumns where name = 'COL_12T' and object_name(id)='FORM6')
Alter Table FORM6 Add COL_12T Varchar(100)
go

if not exists (select * from syscolumns where name = 'KODOKTMO2' and object_name(id)='ORG')
Alter Table ORG Add KODOKTMO2 Varchar(20)
go
if not exists (select * from syscolumns where name = 'REGPLACE' and object_name(id)='ORG')
Alter Table ORG Add REGPLACE Varchar(100)
go
if not exists (select * from syscolumns where name = 'COMPUTERS' and object_name(id)='ORG')
Alter Table ORG Add COMPUTERS Integer
go
if not exists (select * from syscolumns where name = 'SOFTWARENUM' and object_name(id)='ORG')
Alter Table ORG Add SOFTWARENUM Integer
go
if not exists (select * from syscolumns where name = 'SOFTWARE' and object_name(id)='ORG')
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

UPDATE org SET regplace = regpl_name
From org
inner join kregpl on kregpl.regpl_id = org.regpl_id
where regplace is null


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


Alter  PROCEDURE [dbo].[sp_FFS2010Generate]
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
                , CITY = case when SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '40' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '45' and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '7' or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '850' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '898') or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '950' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '998')) then 1 else 0 end
                , TOWN = case when SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '1' then 1 else 0 end
                , VILLAGE = case when SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 1 else 0 end
                , TOWNVILLAGE = case when SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' and
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


go


Alter    PROCEDURE [dbo].[sp_FOKVED2010Generate]
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  create table [dbo].[#temp] (SUBJ_ID int, OKVED_SECTION char(1),
        ORG_COUNT int, RAB_COUNT int, ZAP_COUNT int, ZAB_COUNT int
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
        , [RAB_COUNT]
        , [ZAP_COUNT]
        , [ZAB_COUNT])
        SELECT @SUBJ_ID, K.OKVED_SECTION,
          NULLIF(COUNT(O.ORGID),0) AS ORG_COUNT,
          NULLIF(SUM(O.RAB_COUNT),0) AS RAB_COUNT,
          NULLIF(SUM(O.ZAP_COUNT),0) AS ZAP_COUNT,
          NULLIF(SUM(O.ZAB_COUNT),0) AS ZAB_COUNT
          FROM KOKVED_ K LEFT OUTER JOIN
               (select
                  OO.ORGID
                , OO.RAB_COUNT as RAB_COUNT
                , OO.ZAP_COUNT as ZAP_COUNT
                , OO.ZAB_COUNT as ZAB_COUNT
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
                                               AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0)
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


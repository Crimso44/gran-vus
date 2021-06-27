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
					  o.kopf_changed, o.Email, o.okved_changed, o.SBM,
					  FORM6.COL_10, FORM6.COL_11, FORM6.COL_12
FROM         ORG O 
LEFT JOIN KTERR ON O.TERR_ID = KTERR.TERR_ID 
LEFT JOIN KFS ON O.FS_ID = KFS.FS_ID 
LEFT JOIN KOPF ON O.KOPF_ID = KOPF.KOPF_ID 
LEFT JOIN VV5 ON O.SBM_ID = VV5.ID 
LEFT JOIN FORM6HDR ON O.ORGID = FORM6HDR.ORGID 
LEFT JOIN ORG_CONT HEAD ON O.ORGID = HEAD.ORGID and HEAD.IS_GEN = 1 
LEFT JOIN ORG_CONT VUR ON O.ORGID = VUR.ORGID and VUR.IS_VUS = 1
LEFT JOIN FORM6 ON FORM6.F6_ID = FORM6HDR.F6_ID and FORM6.CPROF_ID = 1000

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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_01 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.02.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.01.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_02 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.02.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.02.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.02.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.02.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.02.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.02.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.02.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.03.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.03.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_03 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.03.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.03.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.03.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.03.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.03.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.03.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.03.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.04.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.04.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_04 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.04.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID

        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.04.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.04.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.04.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.04.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.04.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.04.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.05.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.05.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_05 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.05.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID

        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.05.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.05.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.05.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.05.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.05.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.05.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.06.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.06.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_06 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.06.', 16, 1)
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
                Sum(F.COL_1) As SUM_COL_1,
                Sum(F.COL_2) As SUM_COL_2,
                Sum(F.COL_3) As SUM_COL_3,
                Sum(F.COL_4) As SUM_COL_4,
                Sum(F.COL_5) As SUM_COL_5,
                Sum(F.COL_6) As SUM_COL_6,
                Sum(F.COL_7) As SUM_COL_7,
                Sum(F.COL_8) As SUM_COL_8,
                Sum(F.COL_9) As SUM_COL_9,
                Sum(F.COL_10) As SUM_COL_10,
                Sum(F.COL_11) As SUM_COL_11,
                Sum(F.COL_12) As SUM_COL_12,
                Sum(F.COL_13) As SUM_COL_13,
                Sum(F.COL_14) As SUM_COL_14,
                Sum(F.COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID

        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.06.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.06.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.06.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.06.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать агрегированную форму ј 6.06.', 16, 1)
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
                raiserror ('Невозможно сформировать агрегированную форму ј 6.06.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

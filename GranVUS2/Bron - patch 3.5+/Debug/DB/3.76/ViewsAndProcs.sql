if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6_04]'))
drop procedure [dbo].[sp_GenerateForm6_04]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6_05]'))
drop procedure [dbo].[sp_GenerateForm6_05]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6_06]'))
drop procedure [dbo].[sp_GenerateForm6_06]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_04]'))
drop view [dbo].[v_ORG_04]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_05]'))
drop view [dbo].[v_ORG_05]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_06]'))
drop view [dbo].[v_ORG_06]
GO

CREATE VIEW dbo.v_ORG_04
AS
SELECT *
FROM v_ORG
WHERE ((F6_SHIFR = '04') OR (F6_SHIFR = '05') OR (F6_SHIFR = '06')) AND (OUT_DATE IS NULL)
GO

CREATE VIEW dbo.v_ORG_05
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '05') AND (OUT_DATE IS NULL)
GO

CREATE VIEW dbo.v_ORG_06
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '06') AND (OUT_DATE IS NULL)
GO

ALTER PROCEDURE [dbo].[sp_Form6Create]
        @SUBJ_ID int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FORM6
        WHERE F6_ID in (SELECT F6_ID FROM FORM6HDR WHERE SUBJ_ID = @SUBJ_ID)
        if @@ERROR != 0
        begin
                raiserror 50500 'Невозможно создать формы  6.'
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FORM6HDR
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50501 'Невозможно создать формы  6.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FORM6HDR (ORGNAME, F6_SHIFR, SUBJ_ID)
        SELECT SUBJ_FULLNAME, '01', SUBJ_ID
        FROM SUBJ
        WHERE SUBJ_ID = @SUBJ_ID
        UNION
        SELECT SUBJ_FULLNAME, '02', SUBJ_ID
        FROM SUBJ
        WHERE SUBJ_ID = @SUBJ_ID
        UNION
        SELECT SUBJ_FULLNAME, '03', SUBJ_ID
        FROM SUBJ
        WHERE SUBJ_ID = @SUBJ_ID
        UNION
        SELECT SUBJ_FULLNAME, '04', SUBJ_ID
        FROM SUBJ
        WHERE SUBJ_ID = @SUBJ_ID
        UNION
        SELECT SUBJ_FULLNAME, '05', SUBJ_ID
        FROM SUBJ
        WHERE SUBJ_ID = @SUBJ_ID
        UNION
        SELECT SUBJ_FULLNAME, '06', SUBJ_ID
        FROM SUBJ
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50502 'Невозможно создать формы  6.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT KCPROF.CPROF_ID, FORM6HDR.F6_ID, KCPROF.PRINT_NAME, KCPROF.EXPRESSION, 0, KCPROF.LINE_NO
        FROM FORM6HDR JOIN KCPROF on FORM6HDR.SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50503 'Невозможно создать формы  6.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

CREATE  PROCEDURE [dbo].[sp_GenerateForm6_04]
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
GO

CREATE  PROCEDURE [dbo].[sp_GenerateForm6_05]
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
GO

CREATE  PROCEDURE [dbo].[sp_GenerateForm6_06]
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
GO
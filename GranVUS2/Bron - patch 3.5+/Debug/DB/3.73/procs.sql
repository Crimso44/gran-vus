ALTER  PROCEDURE CHECK_F6 AS

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
                         , f6.CPROF_ID
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
                      FROM (SELECT *
                                 , ExpPlus = '+'+ISNULL(
                                                CASE CPROF_ID
                                                  WHEN 200 THEN '210+220+230+240+250+260'
                                                  WHEN 495 THEN '1000'
                                                  WHEN 496 THEN '1000'
                                                  WHEN 500 THEN '1000'
                                                  ELSE EXPRESSION
                                                END
                                                       ,'')+'+' 
                              FROM FORM6) f6 
                           LEFT OUTER JOIN
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
                     WHERE 1= CASE WHEN (CPROF_ID <> 200
                                     AND (n_1 < 0
                                       OR n_2 < 0
                                       OR n_3 < 0
                                       OR n_4 < 0
                                       OR n_5 < 0
                                       OR n_6 < 0
                                       OR n_7 < 0
                                       OR n_8 < 0
                                       OR n_9 < 0
                                       OR n_10< 0
                                       OR n_11< 0
                                       OR n_12< 0
                                       OR n_13< 0
                                       OR n_14< 0
                                       OR n_15< 0))
                                     OR (CPROF_ID = 200
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
                                   THEN 1 ELSE 0 END)
THEN 0 ELSE 1 END


GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлена процедура CHECK_F6'
from VerInfo
where VerStr='3.73'
GO

CREATE TABLE [KOVK] (
	[OVK_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[OVK_NAME] [varchar] (100)  NULL ,
	[OVK_ADDR] [varchar] (250)  NULL ,
	[OVK_PHONE] [varchar] (50)  NULL ,
	CONSTRAINT [PK_KOVK] PRIMARY KEY  CLUSTERED 
	(
		[OVK_ID]
	)  ON [PRIMARY] 
) ON [PRIMARY]
GO

DECLARE @I int

if not exists (select * from [KL_DATA] where [KL_NAME]='KOVK')
INSERT INTO [KL_DATA]([KL_NAME], [DISP_NAME], [IS_EDIT])
VALUES('KOVK', 'Военкоматы', 1)

SELECT @I = (select [KL_ID] from [KL_DATA] where [KL_NAME]='KOVK')

if not exists (select * from [KL_FLD] where [FLD_NAME]='OVK_ID')
INSERT INTO [KL_FLD]([KL_ID], [FLD_NAME], [DISP_NAME], [DISP_SIZE], [IS_KEY], [IS_EDIT], [VISIBLE], [HAS_NULL])
VALUES(@I, 'OVK_ID', 'Код', 50, 1, 0, 0, 1)

if not exists (select * from [KL_FLD] where [FLD_NAME]='OVK_NAME')
INSERT INTO [KL_FLD]([KL_ID], [FLD_NAME], [DISP_NAME], [DISP_SIZE], [IS_KEY], [IS_EDIT], [VISIBLE], [HAS_NULL])
VALUES(@I, 'OVK_NAME', 'Наименование', 300, 0, 1, 1, 0)

if not exists (select * from [KL_FLD] where [FLD_NAME]='OVK_ADDR')
INSERT INTO [KL_FLD]([KL_ID], [FLD_NAME], [DISP_NAME], [DISP_SIZE], [IS_KEY], [IS_EDIT], [VISIBLE], [HAS_NULL])
VALUES(@I, 'OVK_ADDR', 'Адрес', 200, 0, 1, 1, 1)

if not exists (select * from [KL_FLD] where [FLD_NAME]='OVK_PHONE')
INSERT INTO [KL_FLD]([KL_ID], [FLD_NAME], [DISP_NAME], [DISP_SIZE], [IS_KEY], [IS_EDIT], [VISIBLE], [HAS_NULL])
VALUES(@I, 'OVK_PHONE', 'Телефон', 100, 0, 1, 1, 1)
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлен справочник военкоматов'
from VerInfo
where VerStr='3.73'
GO

update [KREGPL] set [REGPL_NAME] = 'ФНС' where [REGPL_NAME] = 'МНС'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в справочнике "Место регистрации" значение "МНС" заменено на "ФНС"'
from VerInfo
where VerStr='3.73'
GO


ALTER TABLE [dbo].[ORG] ADD [OVK_ID] [int] NULL
GO

ALTER TABLE [dbo].[ORG] ADD CONSTRAINT [FK_ORG_KOVK] FOREIGN KEY 
	(
		[OVK_ID]
	) REFERENCES [KOVK] (
		[OVK_ID]
	)
GO

ALTER  VIEW dbo.v_ORG
AS
SELECT     O.ORGID, O.TERR_ID, KTERR.NAME AS TERR, O.ORGNAME AS ORGNAME, O.URADDR, O.FIZADDR, O.POSTADDR, O.PHONE, O.OKPO, O.INN, O.OKBV,
                      O.FIRST_DATE, O.LAST_DATE, CAST(CASE WHEN FORM6HDR.F6_ID IS NULL THEN 0 ELSE 1 END AS bit) AS HAS_F6, O.SOOGU, O.PARENT,
                      O.MAINOKONH, O.OKONH, O.OCCUPATION,
                      O.FS_ID, KFS.KOD AS KFS_KOD, KFS.FS_NAME, KFS.KOD + ' - ' + KFS.FS_NAME AS KFS,
                      O.KOPF_ID, KOPF.KOD + ' - ' + KOPF.KOPF_NAME AS KOPF, O.KODREG, O.REGDATE, O.REGNUM,
                      KRP.REGPL_NAME AS REG_PLACE, O.COMMENT, O.OUT_REASON, O.OUT_DATE,
                      O.SBM_ID, VV5.KOD AS SBM_KOD, VV5.KOD + ' - ' + VV5.NAME AS SUBMISSION,
                      FORM6HDR.F6_ID, O.HAS_BRON, O.F6_SHIFR,
                      O.CHK_DATE AS CHK_DATE, FORM6HDR.RAB_COUNT, FORM6HDR.ZAP_COUNT, FORM6HDR.ZAB_COUNT, FORM6HDR.CHECKED AS F6CHECKED,
                      CASE WHEN (KFS.KOD = '12' OR KFS.KOD = '41' OR (KFS.KOD = '43' AND VV5.KOD = '01')) THEN 1
                      WHEN (KFS.KOD = '13' OR KFS.KOD = '14' OR KFS.KOD = '42' OR (KFS.KOD = '43' AND (VV5.KOD = '02' OR VV5.KOD = '03'))) THEN 2
                      ELSE 3 END AS KFP_ID,
                      KRP.REGPL_ID,
                      O.Feature1,O.Feature2,O.Feature3,
                      O.OVK_ID
FROM         ORG O LEFT JOIN
                      KTERR ON O.TERR_ID = KTERR.TERR_ID LEFT JOIN
                      KFS ON O.FS_ID = KFS.FS_ID LEFT JOIN
                      KOPF ON O.KOPF_ID = KOPF.KOPF_ID LEFT JOIN
                      VV5 ON O.SBM_ID = VV5.ID LEFT JOIN
                      FORM6HDR ON O.ORGID = FORM6HDR.ORGID LEFT JOIN
                      KREGPL KRP ON O.REGPL_ID=KRP.REGPL_ID
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблицу ORG добавлено поле OVK_ID'
from VerInfo
where VerStr='3.73'
GO

ALTER TABLE [dbo].[ORG] ALTER COLUMN [Feature1] [varchar] (100) NULL
GO
ALTER TABLE [dbo].[ORG] ALTER COLUMN [Feature2] [varchar] (100) NULL
GO
ALTER TABLE [dbo].[ORG] ALTER COLUMN [Feature3] [varchar] (100) NULL
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице ORG поля Feature увеличены до 100 символов'
from VerInfo
where VerStr='3.73'
GO

ALTER  PROCEDURE [dbo].[sp_ImportOrg] 
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
			OVK_ID = T.OVK_ID 
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
			OVK_ID
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
			OVK_ID
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
where VerStr='3.73'
GO


ALTER   PROCEDURE [dbo].[sp_ImportSubj] 
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
			OVK_ID
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
			OVK_ID
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
			OVK_ID = O.OVK_ID
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
where VerStr='3.73'
GO

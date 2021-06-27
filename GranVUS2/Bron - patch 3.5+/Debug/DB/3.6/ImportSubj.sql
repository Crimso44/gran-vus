if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ImportSubj]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ImportSubj]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[sp_ImportSubj] 
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
		DELETE FROM FONH
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
		INSERT INTO FONH (
			SUBJ_ID,
			KBONH_ID,
			RAB_COUNT,
			ZAP_COUNT,
			ZAB_COUNT
			)
		SELECT
			SS.SUBJ_ID,
			F.KBONH_ID,
			F.RAB_COUNT,
			F.ZAP_COUNT,
			F.ZAB_COUNT
		FROM [dbo].[#FONH] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
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
			KONH_ID,
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
			KONH_ID,
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
			KONH_ID = O.KONH_ID,
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
			KONH_ID,
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
			KONH_ID,
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
		WHERE ORGID NOT IN (
			SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN [dbo].[#ORG] O ON S.TERR_ID = O.TERR_ID JOIN ORG OO ON OO.EXT_ID = O.ORGID AND OO.TERR_ID = O.TERR_ID
		)
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
	
COMMIT TRANSACTION
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, 'Обновлена процедура иморта ВУО sp_ImportSubj'
from VerInfo
where VerStr='3.6'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

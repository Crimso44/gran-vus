if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ImportOrg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ImportOrg]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE PROCEDURE [dbo].[sp_ImportOrg] 
	@EXT_ID	int	out
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare
	@ORG_ID	int,
	@MAINOKONH	varchar(5),
	@KONH_ID	int,
	@KODREG	varchar(11),
	@TERR_ID	int,
	@F6_ID	int,
	@F6_SHIFR	varchar(2)
	SELECT @ORG_ID = ORGID, @MAINOKONH = LEFT(OKONH, 5), @F6_SHIFR = F6_SHIFR
	FROM [dbo].[#ORG]
	SELECT @KONH_ID = KONH_ID
	FROM KONH
	WHERE @MAINOKONH BETWEEN CAST(KONH_FROM As int) AND CAST(KONH_TO As int)
	SELECT @KODREG = T.KODTERR, @TERR_ID = S.TERR_ID
	FROM SUBJ S JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID JOIN KTERR T ON S.TERR_ID = T.TERR_ID
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
			OKATO3=T.OKATO3
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
			@MAINOKONH,
			@KONH_ID,
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
			OKATO3
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
select VerId, 'Обновлена процедура импорта организации sp_ImportOrg'
from VerInfo
where VerStr='3.6'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

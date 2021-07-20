if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_FORM6_KCPROF]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[FORM6] DROP CONSTRAINT FK_FORM6_KCPROF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ORG_KFS]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ORG] DROP CONSTRAINT FK_ORG_KFS
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_KL_FLD_KL_DATA]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[KL_FLD] DROP CONSTRAINT FK_KL_FLD_KL_DATA
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ORG_KOPF]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ORG] DROP CONSTRAINT FK_ORG_KOPF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ORG_KOVK]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ORG] DROP CONSTRAINT FK_ORG_KOVK
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ORG_CTY]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ORG] DROP CONSTRAINT FK_ORG_CTY
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SUBJ_KTERR]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[SUBJ] DROP CONSTRAINT FK_SUBJ_KTERR
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SUBJ_SUBJ_AGG_TYPE]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[SUBJ] DROP CONSTRAINT FK_SUBJ_SUBJ_AGG_TYPE
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SUBJ_INFO_SUBJ_INFO_TYPE]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[SUBJ_INFO] DROP CONSTRAINT FK_SUBJ_INFO_SUBJ_INFO_TYPE
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SUBJ_PARAM_SUBJ_PARAM_TYPE]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[SUBJ_PARAM] DROP CONSTRAINT FK_SUBJ_PARAM_SUBJ_PARAM_TYPE
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SUBJ_SUBJ_TYPE]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[SUBJ] DROP CONSTRAINT FK_SUBJ_SUBJ_TYPE
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_OSN_VV3]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[OSN] DROP CONSTRAINT FK_OSN_VV3
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_OSN_VV4]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[OSN] DROP CONSTRAINT FK_OSN_VV4
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_PER_VV4]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PER] DROP CONSTRAINT FK_PER_VV4
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ORG_VV5]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ORG] DROP CONSTRAINT FK_ORG_VV5
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_VerChanges_VerInfo]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[VerChanges] DROP CONSTRAINT FK_VerChanges_VerInfo
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_FORM6HDR_ORG]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[FORM6HDR] DROP CONSTRAINT FK_FORM6HDR_ORG
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ORG_CONT_ORG]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ORG_CONT] DROP CONSTRAINT FK_ORG_CONT_ORG
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ORG_PAYM_ORG]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ORG_PAYM] DROP CONSTRAINT FK_ORG_PAYM_ORG
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ORGSET_ORG]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ORGSET] DROP CONSTRAINT FK_ORGSET_ORG
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_OSN_ORG]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[OSN] DROP CONSTRAINT FK_OSN_ORG
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_PER_ORG]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[PER] DROP CONSTRAINT FK_PER_ORG
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SUBJ_ORG]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[SUBJ] DROP CONSTRAINT FK_SUBJ_ORG
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_CURR_SUBJ_SUBJ]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[CURR_SUBJ] DROP CONSTRAINT FK_CURR_SUBJ_SUBJ
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_FORM6HDR_SUBJ]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[FORM6HDR] DROP CONSTRAINT FK_FORM6HDR_SUBJ
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SUBJ_INFO_SUBJ]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[SUBJ_INFO] DROP CONSTRAINT FK_SUBJ_INFO_SUBJ
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_SUBJ_PARAM_SUBJ]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[SUBJ_PARAM] DROP CONSTRAINT FK_SUBJ_PARAM_SUBJ
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_FORM6_FORM6HDR]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[FORM6] DROP CONSTRAINT FK_FORM6_FORM6HDR
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ORG_INSERT]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[ORG_INSERT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ExtractNumber]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[ExtractNumber]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GetSubjMask]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[GetSubjMask]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHECK_F6]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CHECK_F6]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHECK_ALL]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[CHECK_ALL]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_DeleteForm6]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_DeleteForm6]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Form6Clear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Form6Clear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_Form6Create]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_Form6Create]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GenerateForm6]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GenerateForm6_01]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GenerateForm6_02]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GenerateForm6_03]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6_04]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GenerateForm6_04]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6_05]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GenerateForm6_05]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_GenerateForm6_06]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_GenerateForm6_06]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ImportOrg]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ImportOrg]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_OrgCardDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_OrgCardDelete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SubjCardDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SubjCardDelete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CalcSubjParams]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CalcSubjParams]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_CalcSubjParams377]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_CalcSubjParams377]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_SubjCurrSet]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_SubjCurrSet]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFSCreate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FFSCreate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFSGenerate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FFSGenerate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVEDClear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOKVEDClear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVEDCreate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOKVEDCreate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVEDGenerate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOKVEDGenerate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFSClear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FFSClear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFS2010Create]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FFS2010Create]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFS2010Generate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FFS2010Generate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVED2010Clear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOKVED2010Clear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVED2010Create]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOKVED2010Create]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVED2010Generate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOKVED2010Generate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FSVT2012Clear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FSVT2012Clear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FAnalizClear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FAnalizClear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FSVT2012Create]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FSVT2012Create]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FAnalizCreate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FAnalizCreate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FSVT2012Generate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FSVT2012Generate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FAnalizGenerate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FAnalizGenerate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOrgAnalizGenerate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FOrgAnalizGenerate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFS2010Clear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FFS2010Clear]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_ImportSubj]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_ImportSubj]
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_01]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_01]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_02]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_02]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_03]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_03]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_04]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_04]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_05]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_05]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_06]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_06]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_CALC]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_CALC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_PER77T]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_PER77T]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_SUBJ]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_SUBJ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_SUBJ_CALC]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_SUBJ_CALC]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KFS_]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[KFS_]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KOKVED_]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[KOKVED_]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FORM6]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FORM6]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CURR_SUBJ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CURR_SUBJ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FORM6HDR]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FORM6HDR]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SUBJ_INFO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SUBJ_INFO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SUBJ_PARAM]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SUBJ_PARAM]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ORGSET]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ORGSET]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ORG_CONT]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ORG_CONT]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ORG_PAYM]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ORG_PAYM]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[OSN]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[OSN]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PER]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PER]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SUBJ]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SUBJ]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KL_FLD]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KL_FLD]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ORG]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ORG]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VerChanges]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VerChanges]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Event]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Event]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EventDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[EventDetail]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FFS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FFS]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FFS2010]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FFS2010]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FOKVED]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FOKVED]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FOKVED2010]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FOKVED2010]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSVT2012]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSVT2012]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FAnaliz]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FAnaliz]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FORM6BRIEF]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FORM6BRIEF]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FORMOKBV]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FORMOKBV]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KCPROF]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KCPROF]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KFS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KFS]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KL_DATA]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KL_DATA]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KOKVED]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KOKVED]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KOPF]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KOPF]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KOVK]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KOVK]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KREGPL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KREGPL]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KTERR]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KTERR]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KOKTMO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KOKTMO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SUBJ_AGG_TYPE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SUBJ_AGG_TYPE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SUBJ_INFO_TYPE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SUBJ_INFO_TYPE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SUBJ_PARAM_TYPE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SUBJ_PARAM_TYPE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SUBJ_TYPE]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SUBJ_TYPE]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Users]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VER_INFO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VER_INFO]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VV3]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VV3]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VV4]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VV4]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VV5]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VV5]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[VerInfo]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[VerInfo]
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE FUNCTION [dbo].[ExtractNumber] (@value varchar(250))
RETURNS int
AS
BEGIN
DECLARE  @res varchar(250), @n int, @ch char(1)
  SET @n=1
  SET @res=''
  WHILE @n<=LEN(@value) BEGIN
    SET @ch=SUBSTRING(@value,@n,1)
    IF CHARINDEX(@ch,'0123456789')>0
     SET @res = @res + @ch
    ELSE
     IF @res<>'' BREAK
    SET @n=@n+1
  END
  IF @res='' RETURN null
  RETURN CAST(@res as int)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[GetSubjMask] (@kodterr varchar(25))
RETURNS varchar(25)
AS
BEGIN
DECLARE  @result varchar(25),  @n int

  SET @result = REVERSE(CAST(CAST(REVERSE(@kodterr) as numeric(25)) as varchar(25))) -- Trim zeros

  SET @result = @result + --add trailing zeros to last part of code
  CASE LEN(@result)
    WHEN 0 THEN ''
    WHEN 1 THEN '0'
    WHEN 2 THEN ''
    ELSE CASE (LEN(@result)-2) % 3
      WHEN 1 THEN '00'
      WHEN 2 THEN '0'
      ELSE ''
    END
  END+'%'

  RETURN @result
END







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

CREATE TABLE [dbo].[Event] (
        [Event_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [Type] [varchar] (255)  NULL ,
        [Object] [varchar] (50)  NULL ,
        [When] [datetime] NOT NULL ,
        [Who] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[EventDetail] (
        [EventDetail_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [Event_ID] [int] NOT NULL ,
        [Value] [text]  NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[FFS] (
        [SUBJ_ID] [int] NOT NULL ,
        [FS_ID] [int] NULL ,
        [FS_NAME] [varchar] (100)  NULL ,
        [KOD] [varchar] (2)  NULL ,
        [WHOLE] [int] NULL ,
        [WU] [int] NULL ,
        [BRON] [int] NULL ,
        [TOWN_WHOLE] [int] NULL ,
        [TOWN_WU] [int] NULL ,
        [TOWN_BRON] [int] NULL ,
        [VILLAGE_WHOLE] [int] NULL ,
        [VILLAGE_WU] [int] NULL ,
        [VILLAGE_BRON] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FOKVED] (
        [SUBJ_ID] [int] NOT NULL ,
        [OKVED_SECTION] [char] (1)  NOT NULL ,
        [ORG_COUNT] [int] NULL ,
        [ORG_BRON_COUNT] [int] NULL ,
        [ORG_WU_COUNT] [int] NULL ,
        [RAB_COUNT] [int] NULL ,
        [ZAP_COUNT] [int] NULL ,
        [ZAB_COUNT] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FFS2010](
        [SUBJ_ID] [int] NOT NULL,
        [FS_ID] [int] NULL,
        [FS_NAME] [varchar](100) NULL,
        [KOD] [varchar](2) NULL,
        [CITY] [int] NULL,
        [TOWN] [int] NULL,
        [VILLAGE] [int] NULL,
        [TOWNVILLAGE] [int] NULL,
        [INCITY] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FOKVED2010](
        [SUBJ_ID] [int] NOT NULL,
        [NUM] [int] NOT NULL,
        [A] [int] NULL,
        [B] [int] NULL,
        [C] [int] NULL,
        [D] [int] NULL,
        [E] [int] NULL,
        [F] [int] NULL,
        [G] [int] NULL,
        [H] [int] NULL,
        [I] [int] NULL,
        [J] [int] NULL,
        [K] [int] NULL,
        [L] [int] NULL,
        [M] [int] NULL,
        [N] [int] NULL,
        [O] [int] NULL,
        [P] [int] NULL,
        [Q] [int] NULL,
        [R] [int] NULL,
        [S] [int] NULL,
        [T] [int] NULL,
        [U] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FSVT2012](
	[SUBJ_ID] [int] NOT NULL,
	[NUM] [int] NOT NULL,
	[N02] [int] NULL,
	[N03] [int] NULL,
	[N04] [int] NULL,
	[N05] [int] NULL,
	[N06] [int] NULL,
	[N07] [int] NULL,
	[N08] [int] NULL,
	[N09] [int] NULL,
	[N10] [int] NULL,
	[N11] [int] NULL
) ON [PRIMARY]

GO


CREATE TABLE [dbo].[FAnaliz](
	[SUBJ_ID] [int] NOT NULL,
	[NUM] [int] NOT NULL,
	[N01] [int] NULL,
	[N02] [int] NULL,
	[N06] [int] NULL,
	[N10] [int] NULL,
	[N12] [int] NULL
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[FORM6BRIEF] (
        [ID] [int] IDENTITY (1, 1) NOT NULL ,
        [NAME] [varchar] (50)  NULL ,
        [F6_SHIFR] [varchar] (2)  NULL ,
        [CAPTION] [varchar] (500)  NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FORMOKBV] (
        [ID] [int] IDENTITY (1, 1) NOT NULL ,
        [NAME] [varchar] (50)  NULL ,
        [OKBV_SHIFR] [varchar] (2)  NULL ,
        [CAPTION] [varchar] (250)  NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KCPROF] (
        [CPROF_ID] [int] NOT NULL ,
        [CPROF_NAME] [varchar] (100)  NULL ,
        [PRINT_NAME] [varchar] (100)  NULL ,
        [EXPRESSION] [varchar] (100)  NULL ,
        [STATE] [int] NULL ,
        [LINE_NO] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KFS] (
        [FS_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [FS_NAME] [varchar] (100)  NULL ,
        [KOD] [varchar] (2)  NULL ,
        [ForForm] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KL_DATA] (
        [KL_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [KL_NAME] [varchar] (8)  NULL ,
        [DISP_NAME] [varchar] (150)  NULL ,
        [IS_EDIT] [smallint] NULL ,
        [CHK_DEL] [varchar] (500)  NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KOKVED] (
        [OKVED_SECTION] [char] (1)  NOT NULL ,
        [OKVED_SECTION_NAME] [varchar] (254)  NOT NULL ,
        [OKVED_BEGIN] [int] NOT NULL ,
        [OKVED_END] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KOPF] (
        [KOPF_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [KOPF_NAME] [varchar] (150)  NULL ,
        [KOD] [varchar] (5)  NULL,
        KOD_OLD Varchar(2),
        KOD_OLD2 Varchar(5)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KOVK] (
        [OVK_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [OVK_NAME] [varchar] (250)  NULL ,
        [OVK_ADDR] [varchar] (250)  NULL ,
        [OVK_PHONE] [varchar] (250)  NULL,
        [ISOVK] [bit]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KREGPL] (
        [REGPL_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [REGPL_NAME] [varchar] (50)  NOT NULL ,
        [REGPL_KOD] [varchar] (5)  NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KTERR] (
        [TERR_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [NAME] [varchar] (150)  NULL ,
        [KODTERR] [varchar] (20)  NULL ,
        [IS_OKATO] [int] NULL ,
        [SHORTNAME] [varchar] (150) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KOKTMO](
        [OKTMO_ID] [int] IDENTITY(1,1) NOT NULL,
        [NAME] [varchar](150) NULL,
        [KODOKTMO] [varchar](20) NULL,
        [SHORTNAME] [varchar](150) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SUBJ_AGG_TYPE] (
        [SUBJ_AGG_ID] [int] NOT NULL ,
        [SUBJ_AGG_NAME] [varchar] (50)  NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SUBJ_INFO_TYPE] (
        [SUBJ_INFO_ID] [int] NOT NULL ,
        [SUBJ_INFO_NAME] [varchar] (100)  NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SUBJ_PARAM_TYPE] (
        [SUBJ_PARAM_ID] [int] NOT NULL ,
        [SUBJ_PARAM_NAME] [varchar] (100)  NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SUBJ_TYPE] (
        [TYPE_ID] [int] NOT NULL ,
        [TYPE_NAME] [varchar] (50)  NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Users] (
        [ID] [int] IDENTITY (1, 1) NOT NULL ,
        [Login] [varchar] (50)  NULL ,
        [Fam] [varchar] (50)  NULL ,
        [Im] [varchar] (50)  NULL ,
        [Otch] [varchar] (50)  NULL ,
        [Hash] [varchar] (32)  NULL ,
        [rAdmin] [bit] NOT NULL ,
        [rImport] [bit] NOT NULL ,
        [rExport] [bit] NOT NULL ,
        [rPrint] [bit] NOT NULL ,
        [rEdit] [bit] NOT NULL ,
        [rlogin] [bit] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VER_INFO] (
        [ID] [int] NOT NULL ,
        [NAME] [varchar] (50)  NULL ,
        [VER_VALUE] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VV3] (
        [ID] [int] NOT NULL ,
        [KOD] [varchar] (2)  NOT NULL ,
        [NAME] [varchar] (50)  NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VV4] (
        [ID] [int] NOT NULL ,
        [KOD] [varchar] (2)  NOT NULL ,
        [NAME] [varchar] (25)  NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VV5] (
        [ID] [int] NOT NULL ,
        [KOD] [varchar] (2)  NOT NULL ,
        [NAME] [varchar] (100)  NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VerInfo] (
        [VerId] [int] IDENTITY (1, 1) NOT NULL ,
        [VerStr] [varchar] (50)  NOT NULL ,
        [VerDesc] [varchar] (500)  NULL ,
        [VerDate] [smalldatetime] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[KL_FLD] (
        [FLD_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [KL_ID] [int] NULL ,
        [FLD_NAME] [varchar] (30)  NULL ,
        [DISP_NAME] [varchar] (150)  NULL ,
        [DISP_SIZE] [smallint] NULL ,
        [IS_KEY] [smallint] NULL ,
        [IS_EDIT] [smallint] NULL ,
        [VISIBLE] [smallint] NULL ,
        [DEF_VALUE] [varchar] (100)  NULL ,
        [HAS_NULL] [smallint] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ORG] (
        [ORGID] [int] IDENTITY (1, 1) NOT NULL ,
        [PARENT] [varchar] (100)  NULL ,
        [FS_ID] [int] NULL ,
        [INN] [varchar] (50)  NULL ,
        [OKPO] [varchar] (8)  NULL ,
        [OKONH] [varchar] (500)  NULL ,
        [SOOGU] [varchar] (7)  NULL ,
        [KOPF_ID] [int] NULL ,
        [KODREG] [varchar] (11)  NULL ,
        [REGDATE] [datetime] NULL ,
        [REGNUM] [varchar] (20)  NULL ,
        [ORGNAME] [varchar] (500)  NOT NULL ,
        [ORGSNAME] [varchar] (250)  NULL ,
        [COMMENT] [varchar] (500)  NULL ,
        [FIZADDR] [varchar] (250)  NULL ,
        [URADDR] [varchar] (250)  NULL ,
        [POSTADDR] [varchar] (250)  NULL ,
        [PHONE] [varchar] (50)  NULL ,
        [FAX] [varchar] (50)  NULL ,
        [EMAIL] [varchar] (100)  NULL ,
        [WWW] [varchar] (100)  NULL ,
        [MYORG] [int] NULL ,
        [CONFDATE] [datetime] NULL ,
        [MAINOKONH] [varchar] (15)  NULL ,
        [OKBV] [varchar] (12)  NULL ,
        [OCCUPATION] [varchar] (150)  NULL ,
        [FIRST_DATE] [datetime] NULL ,
        [LAST_DATE] [datetime] NULL ,
        [OUT_REASON] [varchar] (160)  NULL ,
        [OUT_DATE] [datetime] NULL ,
        [SBM_ID] [int] NULL ,
        [TERR_ID] [int] NOT NULL ,
        [EXT_ID] [int] NULL ,
        [HAS_BRON] [bit] NOT NULL ,
        [F6_SHIFR] [varchar] (2)  NULL ,
        [REGPL_ID] [int] NULL ,
        [CHK_DATE] [datetime] NULL ,
        [OKATO2] [varchar] (50)  NULL ,
        [OKATO3] [varchar] (50)  NULL ,
        [Feature1] [varchar] (100)  NULL ,
        [Feature2] [varchar] (100)  NULL ,
        [Feature3] [varchar] (100)  NULL ,
        [OVK_ID] [int] NULL,
        [KODOKTMO] [varchar] (20) NULL,
        [KODOKTMO2] [varchar] (20) NULL,
        [REGPLACE] varchar (100) null,
        [COMPUTERS] int null,
        [SOFTWARENUM] int null,
        [KPIS] int null,
        [COMPUTERSS] int null,
        [SOFTWARENUMS] int null,
        [KPISS] int null,
        [SOFTWARE] varchar (255) null,
        Kopf_Changed bit,
        Okved_Changed bit,
        SBM varchar(50)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[VerChanges] (
        [VerChgId] [int] IDENTITY (1, 1) NOT NULL ,
        [VerId] [int] NOT NULL ,
        [VerChgDesc] [varchar] (500)  NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ORGSET] (
        [ORGID] [int] NOT NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ORG_CONT] (
        [CONTID] [int] IDENTITY (1, 1) NOT NULL ,
        [ORGID] [int] NOT NULL ,
        [DEPART] [varchar] (50)  NULL ,
        [POST] [varchar] (50)  NULL ,
        [PHONE] [varchar] (50)  NULL ,
        [FAX] [varchar] (50)  NULL ,
        [EMAIL] [varchar] (100)  NULL ,
        [IS_GEN] [smallint] NULL ,
        [IS_VUS] [smallint] NULL ,
        [Fam] [varchar] (50)  NULL ,
        [Im] [varchar] (50)  NULL ,
        [Otch] [varchar] (50)  NULL ,
        [FIO] AS (isnull([Fam],'') + ' ' + isnull([Im],'') + ' ' + isnull([Otch],''))
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ORG_PAYM] (
        [PAYMID] [int] IDENTITY (1, 1) NOT NULL ,
        [ORGID] [int] NOT NULL ,
        [KS] [varchar] (20)  NULL ,
        [RS] [varchar] (20)  NULL ,
        [BIK] [varchar] (9)  NULL ,
        [BANK] [varchar] (250)  NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OSN] (
        [ORGID] [int] NOT NULL ,
        [BASE_ID] [int] NULL ,
        [DOC_ID] [int] NULL ,
        [DOC_NO] [varchar] (15)  NULL ,
        [DOC_DATE] [datetime] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[PER] (
        [ORGID] [int] NOT NULL ,
        [DOC_ID] [int] NULL ,
        [DOC_NO] [varchar] (15)  NULL ,
        [START_DATE] [datetime] NULL ,
        [END_DATE] [datetime] NULL ,
        [PER_NO] [varchar] (10)  NULL ,
        [RAZD_NO] [varchar] (4000) NULL,
        Okved_Name varchar(255)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SUBJ] (
        [SUBJ_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [TYPE_ID] [int] NOT NULL ,
        [TERR_ID] [int] NOT NULL ,
        [ORGID] [int] NULL ,
        [SUBJ_NAME] [varchar] (250)  NOT NULL ,
        [SUBJ_FULLNAME] [varchar] (250)  NOT NULL ,
        [SUBJ_ADDRESS] [varchar] (250)  NULL ,
        [SUBJ_AGG_ID] [int] NOT NULL ,
        [KODREG] [varchar] (11)  NULL ,
        [REPORT_DATE] [datetime] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[CURR_SUBJ] (
        [SUBJ_ID] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FORM6HDR] (
        [F6_ID] [int] IDENTITY (1, 1) NOT NULL ,
        [ORGID] [int] NULL ,
        [ORGNAME] [varchar] (500)  NULL ,
        [F6_SHIFR] [varchar] (2)  NULL ,
        [ORG_SHIFR] [varchar] (10)  NULL ,
        [F6_COUNT] [int] NULL ,
        [KUO_COUNT] [int] NULL ,
        [RAB_COUNT] [int] NULL ,
        [ZAP_COUNT] [int] NULL ,
        [ZAB_COUNT] [int] NULL ,
        [CHECKED] [bit] NOT NULL ,
        [CONFDATE] [datetime] NULL ,
        [SUBJ_ID] [int] NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SUBJ_INFO] (
        [SUBJ_ID] [int] NOT NULL ,
        [SUBJ_INFO_ID] [int] NOT NULL ,
        [ORG_NAME] [varchar] (60)  NULL ,
        [POSITION_NAME] [varchar] (60)  NULL ,
        [FIO] [varchar] (100)  NULL ,
        [PHONE] [varchar] (100)  NULL,
		POSITION_NAME2 varchar(60) NULL,
		FIO2 varchar(100) NULL,
		PHONE2 varchar(100) NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[SUBJ_PARAM] (
        [SUBJ_ID] [int] NOT NULL ,
        [SUBJ_PARAM_ID] [int] NOT NULL ,
        [PARAM_VALUE] [float] NULL,
		value3 float NULL,
		value4 float NULL,
		value5 float NULL,
		value6 float NULL,
		value7 float NULL,
		value8 float NULL
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[FORM6] (
        [CPROF_ID] [int] NOT NULL ,
        [F6_ID] [int] NOT NULL ,
        [PRINT_NAME] [varchar] (100)  NULL ,
        [EXPRESSION] [varchar] (100)  NULL ,
        [CALCULATE] [int] NULL ,
        [COL_B] [int] NULL ,
        [COL_1] [int] NULL ,
        [COL_2] [int] NULL ,
        [COL_3] [int] NULL ,
        [COL_4] [int] NULL ,
        [COL_5] [int] NULL ,
        [COL_6] [int] NULL ,
        [COL_7] [int] NULL ,
        [COL_8] [int] NULL ,
        [COL_9] [int] NULL ,
        [COL_10] [int] NULL ,
        [COL_11] [int] NULL ,
        [COL_12] [int] NULL ,
        [COL_13] [int] NULL ,
        [COL_14] [int] NULL ,
        [COL_15] [int] NULL ,
        [COL_16] [varchar] (50)  NULL,
        [COL_10T] varchar (100) null,
        [COL_12T] varchar (100) null
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FORM6BRIEF] WITH NOCHECK ADD
        CONSTRAINT [PK_FORM6BRIEF] PRIMARY KEY  CLUSTERED
        (
                [ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[FORMOKBV] WITH NOCHECK ADD
        CONSTRAINT [PK_PER_LIST] PRIMARY KEY  CLUSTERED
        (
                [ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KCPROF] WITH NOCHECK ADD
        CONSTRAINT [PK_KCPROF] PRIMARY KEY  CLUSTERED
        (
                [CPROF_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KFS] WITH NOCHECK ADD
        CONSTRAINT [PK_KFS] PRIMARY KEY  CLUSTERED
        (
                [FS_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KL_DATA] WITH NOCHECK ADD
        CONSTRAINT [PK_KL_DATA] PRIMARY KEY  CLUSTERED
        (
                [KL_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KOPF] WITH NOCHECK ADD
        CONSTRAINT [PK_KOPF] PRIMARY KEY  CLUSTERED
        (
                [KOPF_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KOVK] WITH NOCHECK ADD
        CONSTRAINT [PK_KOVK] PRIMARY KEY  CLUSTERED
        (
                [OVK_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KTERR] WITH NOCHECK ADD
        CONSTRAINT [PK_CTY] PRIMARY KEY  CLUSTERED
        (
                [TERR_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KOKTMO] WITH NOCHECK ADD
        CONSTRAINT [PK_KOKTMO] PRIMARY KEY CLUSTERED
        (
                [OKTMO_ID] ASC
        ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SUBJ_AGG_TYPE] WITH NOCHECK ADD
        CONSTRAINT [PK_Table1] PRIMARY KEY  CLUSTERED
        (
                [SUBJ_AGG_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[SUBJ_INFO_TYPE] WITH NOCHECK ADD
        CONSTRAINT [PK_SUBJ_INFO_TYPE] PRIMARY KEY  CLUSTERED
        (
                [SUBJ_INFO_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[SUBJ_PARAM_TYPE] WITH NOCHECK ADD
        CONSTRAINT [PK_SUBJ_PARAM_TYPE] PRIMARY KEY  CLUSTERED
        (
                [SUBJ_PARAM_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[SUBJ_TYPE] WITH NOCHECK ADD
        CONSTRAINT [PK_SUBJ_TYPE] PRIMARY KEY  CLUSTERED
        (
                [TYPE_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[VER_INFO] WITH NOCHECK ADD
        CONSTRAINT [PK_VERINFO] PRIMARY KEY  CLUSTERED
        (
                [ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[VV3] WITH NOCHECK ADD
        CONSTRAINT [PK_VV3] PRIMARY KEY  CLUSTERED
        (
                [ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[VV4] WITH NOCHECK ADD
        CONSTRAINT [PK_VV4] PRIMARY KEY  CLUSTERED
        (
                [ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[VV5] WITH NOCHECK ADD
        CONSTRAINT [PK_VV5] PRIMARY KEY  CLUSTERED
        (
                [ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[VerInfo] WITH NOCHECK ADD
        CONSTRAINT [PK_VerInfo_1] PRIMARY KEY  CLUSTERED
        (
                [VerId]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KL_FLD] WITH NOCHECK ADD
        CONSTRAINT [PK_KL_FLD] PRIMARY KEY  CLUSTERED
        (
                [FLD_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[ORG] WITH NOCHECK ADD
        CONSTRAINT [PK_ORG] PRIMARY KEY  CLUSTERED
        (
                [ORGID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[VerChanges] WITH NOCHECK ADD
        CONSTRAINT [PK_VerChanges] PRIMARY KEY  CLUSTERED
        (
                [VerChgId]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[ORGSET] WITH NOCHECK ADD
        CONSTRAINT [PK_ORGSET] PRIMARY KEY  CLUSTERED
        (
                [ORGID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[ORG_CONT] WITH NOCHECK ADD
        CONSTRAINT [PK_ORG_CONT] PRIMARY KEY  CLUSTERED
        (
                [CONTID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[ORG_PAYM] WITH NOCHECK ADD
        CONSTRAINT [PK_ORG_PAYM] PRIMARY KEY  CLUSTERED
        (
                [PAYMID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[SUBJ] WITH NOCHECK ADD
        CONSTRAINT [PK_SUBJ] PRIMARY KEY  CLUSTERED
        (
                [SUBJ_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[FORM6HDR] WITH NOCHECK ADD
        CONSTRAINT [PK_FORM6HDR] PRIMARY KEY  CLUSTERED
        (
                [F6_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[SUBJ_INFO] WITH NOCHECK ADD
        CONSTRAINT [PK_SUBJ_INFO] PRIMARY KEY  CLUSTERED
        (
                [SUBJ_ID],
                [SUBJ_INFO_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[SUBJ_PARAM] WITH NOCHECK ADD
        CONSTRAINT [PK_SUBJ_PARAM] PRIMARY KEY  CLUSTERED
        (
                [SUBJ_ID],
                [SUBJ_PARAM_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[FORM6] WITH NOCHECK ADD
        CONSTRAINT [PK_FORM6] PRIMARY KEY  CLUSTERED
        (
                [CPROF_ID],
                [F6_ID]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Event] ADD
        CONSTRAINT [DF__Event__When__662B2B3B] DEFAULT (getdate()) FOR [When],
        CONSTRAINT [DF__Event__Who__671F4F74] DEFAULT (0) FOR [Who]
GO

ALTER TABLE [dbo].[KFS] ADD
        CONSTRAINT [DF__kfs__ForForm__0D44F85C] DEFAULT (0) FOR [ForForm],
        CONSTRAINT [IX_KFS] UNIQUE  NONCLUSTERED
        (
                [KOD]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KOKVED] ADD
        CONSTRAINT [KOKVED_SECTION] UNIQUE  NONCLUSTERED
        (
                [OKVED_SECTION]
        )  ON [PRIMARY] ,
        CONSTRAINT [OKVED_BEGIN] UNIQUE  NONCLUSTERED
        (
                [OKVED_BEGIN]
        )  ON [PRIMARY] ,
        CONSTRAINT [OKVED_END] UNIQUE  NONCLUSTERED
        (
                [OKVED_END]
        )  ON [PRIMARY] ,
        CONSTRAINT [OKVED_SECTION_NAME] UNIQUE  NONCLUSTERED
        (
                [OKVED_SECTION_NAME]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KOPF] ADD
        CONSTRAINT [IX_KOPF] UNIQUE  NONCLUSTERED
        (
                [KOD]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[KTERR] ADD
        CONSTRAINT [IX_KTERR] UNIQUE  NONCLUSTERED
        (
                [KODTERR]
        )  ON [PRIMARY]
GO

ALTER TABLE [dbo].[Users] ADD
        CONSTRAINT [DF__Users__rAdmin__5F7E2DAC] DEFAULT (0) FOR [rAdmin],
        CONSTRAINT [DF__Users__rImport__607251E5] DEFAULT (0) FOR [rImport],
        CONSTRAINT [DF__Users__rExport__6166761E] DEFAULT (0) FOR [rExport],
        CONSTRAINT [DF__Users__rPrint__625A9A57] DEFAULT (0) FOR [rPrint],
        CONSTRAINT [DF__Users__rEdit__634EBE90] DEFAULT (0) FOR [rEdit],
        CONSTRAINT [DF__Users__rlogin__6442E2C9] DEFAULT (0) FOR [rlogin]
GO

 CREATE  INDEX [IX_KL_FLD] ON [dbo].[KL_FLD]([KL_ID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_ORG] ON [dbo].[ORG]([SBM_ID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_ORG_2] ON [dbo].[ORG]([KOPF_ID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_ORG_3] ON [dbo].[ORG]([FS_ID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_ORG_4] ON [dbo].[ORG]([TERR_ID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_VerChanges] ON [dbo].[VerChanges]([VerId]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_ORG_CONT] ON [dbo].[ORG_CONT]([ORGID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_ORG_PAYM] ON [dbo].[ORG_PAYM]([ORGID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_OSN] ON [dbo].[OSN]([ORGID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_OSN_1] ON [dbo].[OSN]([BASE_ID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_OSN_2] ON [dbo].[OSN]([DOC_ID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_PER] ON [dbo].[PER]([ORGID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_PER_1] ON [dbo].[PER]([DOC_ID]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FORM6HDR] ADD
        CONSTRAINT [DF_FORM6HDR_CHECKED] DEFAULT (0) FOR [CHECKED]
GO

 CREATE  INDEX [IX_FORM6HDR] ON [dbo].[FORM6HDR]([ORGID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_FORM6] ON [dbo].[FORM6]([F6_ID]) ON [PRIMARY]
GO

 CREATE  INDEX [IX_FORM6_1] ON [dbo].[FORM6]([CPROF_ID]) ON [PRIMARY]
GO

ALTER TABLE [dbo].[KL_FLD] ADD
        CONSTRAINT [FK_KL_FLD_KL_DATA] FOREIGN KEY
        (
                [KL_ID]
        ) REFERENCES [dbo].[KL_DATA] (
                [KL_ID]
        )
GO

ALTER TABLE [dbo].[ORG] ADD
        CONSTRAINT [FK_ORG_CTY] FOREIGN KEY
        (
                [TERR_ID]
        ) REFERENCES [dbo].[KTERR] (
                [TERR_ID]
        ),
        CONSTRAINT [FK_ORG_KFS] FOREIGN KEY
        (
                [FS_ID]
        ) REFERENCES [dbo].[KFS] (
                [FS_ID]
        ),
        CONSTRAINT [FK_ORG_KOPF] FOREIGN KEY
        (
                [KOPF_ID]
        ) REFERENCES [dbo].[KOPF] (
                [KOPF_ID]
        ),
        CONSTRAINT [FK_ORG_KOVK] FOREIGN KEY
        (
                [OVK_ID]
        ) REFERENCES [dbo].[KOVK] (
                [OVK_ID]
        ),
        CONSTRAINT [FK_ORG_VV5] FOREIGN KEY
        (
                [SBM_ID]
        ) REFERENCES [dbo].[VV5] (
                [ID]
        )
GO

ALTER TABLE [dbo].[VerChanges] ADD
        CONSTRAINT [FK_VerChanges_VerInfo] FOREIGN KEY
        (
                [VerId]
        ) REFERENCES [dbo].[VerInfo] (
                [VerId]
        )
GO

ALTER TABLE [dbo].[ORGSET] ADD
        CONSTRAINT [FK_ORGSET_ORG] FOREIGN KEY
        (
                [ORGID]
        ) REFERENCES [dbo].[ORG] (
                [ORGID]
        )
GO

ALTER TABLE [dbo].[ORG_CONT] ADD
        CONSTRAINT [FK_ORG_CONT_ORG] FOREIGN KEY
        (
                [ORGID]
        ) REFERENCES [dbo].[ORG] (
                [ORGID]
        )
GO

ALTER TABLE [dbo].[ORG_PAYM] ADD
        CONSTRAINT [FK_ORG_PAYM_ORG] FOREIGN KEY
        (
                [ORGID]
        ) REFERENCES [dbo].[ORG] (
                [ORGID]
        )
GO

ALTER TABLE [dbo].[OSN] ADD
        CONSTRAINT [FK_OSN_ORG] FOREIGN KEY
        (
                [ORGID]
        ) REFERENCES [dbo].[ORG] (
                [ORGID]
        ),
        CONSTRAINT [FK_OSN_VV3] FOREIGN KEY
        (
                [BASE_ID]
        ) REFERENCES [dbo].[VV3] (
                [ID]
        ),
        CONSTRAINT [FK_OSN_VV4] FOREIGN KEY
        (
                [DOC_ID]
        ) REFERENCES [dbo].[VV4] (
                [ID]
        )
GO

ALTER TABLE [dbo].[PER] ADD
        CONSTRAINT [FK_PER_ORG] FOREIGN KEY
        (
                [ORGID]
        ) REFERENCES [dbo].[ORG] (
                [ORGID]
        ),
        CONSTRAINT [FK_PER_VV4] FOREIGN KEY
        (
                [DOC_ID]
        ) REFERENCES [dbo].[VV4] (
                [ID]
        )
GO

ALTER TABLE [dbo].[SUBJ] ADD
        CONSTRAINT [FK_SUBJ_KTERR] FOREIGN KEY
        (
                [TERR_ID]
        ) REFERENCES [dbo].[KTERR] (
                [TERR_ID]
        ),
        CONSTRAINT [FK_SUBJ_ORG] FOREIGN KEY
        (
                [ORGID]
        ) REFERENCES [dbo].[ORG] (
                [ORGID]
        ),
        CONSTRAINT [FK_SUBJ_SUBJ_AGG_TYPE] FOREIGN KEY
        (
                [SUBJ_AGG_ID]
        ) REFERENCES [dbo].[SUBJ_AGG_TYPE] (
                [SUBJ_AGG_ID]
        ),
        CONSTRAINT [FK_SUBJ_SUBJ_TYPE] FOREIGN KEY
        (
                [TYPE_ID]
        ) REFERENCES [dbo].[SUBJ_TYPE] (
                [TYPE_ID]
        )
GO

ALTER TABLE [dbo].[CURR_SUBJ] ADD
        CONSTRAINT [FK_CURR_SUBJ_SUBJ] FOREIGN KEY
        (
                [SUBJ_ID]
        ) REFERENCES [dbo].[SUBJ] (
                [SUBJ_ID]
        )
GO

ALTER TABLE [dbo].[FORM6HDR] ADD
        CONSTRAINT [FK_FORM6HDR_ORG] FOREIGN KEY
        (
                [ORGID]
        ) REFERENCES [dbo].[ORG] (
                [ORGID]
        ),
        CONSTRAINT [FK_FORM6HDR_SUBJ] FOREIGN KEY
        (
                [SUBJ_ID]
        ) REFERENCES [dbo].[SUBJ] (
                [SUBJ_ID]
        )
GO

ALTER TABLE [dbo].[SUBJ_INFO] ADD
        CONSTRAINT [FK_SUBJ_INFO_SUBJ] FOREIGN KEY
        (
                [SUBJ_ID]
        ) REFERENCES [dbo].[SUBJ] (
                [SUBJ_ID]
        ),
        CONSTRAINT [FK_SUBJ_INFO_SUBJ_INFO_TYPE] FOREIGN KEY
        (
                [SUBJ_INFO_ID]
        ) REFERENCES [dbo].[SUBJ_INFO_TYPE] (
                [SUBJ_INFO_ID]
        )
GO

ALTER TABLE [dbo].[SUBJ_PARAM] ADD
        CONSTRAINT [FK_SUBJ_PARAM_SUBJ] FOREIGN KEY
        (
                [SUBJ_ID]
        ) REFERENCES [dbo].[SUBJ] (
                [SUBJ_ID]
        ),
        CONSTRAINT [FK_SUBJ_PARAM_SUBJ_PARAM_TYPE] FOREIGN KEY
        (
                [SUBJ_PARAM_ID]
        ) REFERENCES [dbo].[SUBJ_PARAM_TYPE] (
                [SUBJ_PARAM_ID]
        )
GO

ALTER TABLE [dbo].[FORM6] ADD
        CONSTRAINT [FK_FORM6_FORM6HDR] FOREIGN KEY
        (
                [F6_ID]
        ) REFERENCES [dbo].[FORM6HDR] (
                [F6_ID]
        ),
        CONSTRAINT [FK_FORM6_KCPROF] FOREIGN KEY
        (
                [CPROF_ID]
        ) REFERENCES [dbo].[KCPROF] (
                [CPROF_ID]
        )
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW KFS_ AS
SELECT FS_ID, FS_NAME, KOD=ISNULL(KOD,'00') FROM KFS WHERE ForForm<>0
UNION
SELECT 0, 'Прочие', 'ZZ'


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW KOKVED_ AS
      SELECT N = ASCII(OKVED_SECTION)-ASCII('A')+1, * FROM KOKVED
UNION SELECT (SELECT COUNT(*)+1 FROM KOKVED), '_','Прочее',0,0


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW dbo.v_ORG_CALC
AS
SELECT     dbo.ORG.ORGID
FROM         dbo.ORG INNER JOIN
                      dbo.SUBJ ON dbo.ORG.TERR_ID = dbo.SUBJ.TERR_ID AND dbo.SUBJ.SUBJ_AGG_ID = 1

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW dbo.v_PER77T
AS
SELECT DISTINCT ORGID
FROM         dbo.PER
WHERE (PER_NO LIKE '77-T%' OR PER_NO LIKE '77-Т%')
AND   (END_DATE IS NULL OR END_DATE>=getdate())

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW dbo.v_SUBJ
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
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW dbo.v_SUBJ_CALC
AS
SELECT     SUBJ_ID
FROM         dbo.SUBJ
WHERE     SUBJ_AGG_ID = 2

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE   VIEW [dbo].[v_ORG]
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




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE  VIEW dbo.v_ORG_01
AS
SELECT *
FROM v_ORG
WHERE OUT_DATE IS NULL


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE  VIEW dbo.v_ORG_02
AS
SELECT *
FROM v_ORG
WHERE ((F6_SHIFR = '02') OR (F6_SHIFR = '03')) AND (OUT_DATE IS NULL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE  VIEW dbo.v_ORG_03
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '03') AND (OUT_DATE IS NULL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW dbo.v_ORG_04
AS
SELECT *
FROM v_ORG
WHERE ((F6_SHIFR = '04') OR (F6_SHIFR = '05') OR (F6_SHIFR = '06')) AND (OUT_DATE IS NULL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW dbo.v_ORG_05
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '05') AND (OUT_DATE IS NULL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW dbo.v_ORG_06
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '06') AND (OUT_DATE IS NULL)
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE  PROCEDURE [dbo].[sp_FFSClear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FFS
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить форму по видам собственности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


Create   PROCEDURE [dbo].[sp_ImportSubj]
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare
        @SUBJ_ID        int,
        @AggData        bit,
        @BronOnly       bit,
        @CONFDATE       datetime

        SELECT @SUBJ_ID = SUBJ_ID, @AggData = AggData, @BronOnly = BronOnly, @CONFDATE = CONFDATE
        FROM [dbo].[#CURR_SUBJ]
        DELETE FROM SUBJ_INFO
        WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] SS ON S.TERR_ID = SS.TERR_ID)
        if @@ERROR != 0
        begin
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM SUBJ_PARAM
        WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] SS ON S.TERR_ID = SS.TERR_ID)
        if @@ERROR != 0
        begin
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO SUBJ_INFO (
                SUBJ_ID,
                SUBJ_INFO_ID,
                ORG_NAME,
                POSITION_NAME,
                FIO,
                PHONE,
                POSITION_NAME2,
                FIO2,
                PHONE2
                )
        SELECT
                SS.SUBJ_ID,
                I.SUBJ_INFO_ID,
                I.ORG_NAME,
                I.POSITION_NAME,
                I.FIO,
                I.PHONE,
                I.POSITION_NAME2,
                I.FIO2,
                I.PHONE2
        FROM [dbo].[#SUBJ_INFO] I JOIN [dbo].[#SUBJ] S ON I.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO SUBJ_PARAM (
                SUBJ_ID,
                SUBJ_PARAM_ID,
                PARAM_VALUE,
				value3,
				value4,
				value5,
				value6,
				value7,
				value8
                )
        SELECT
                SS.SUBJ_ID,
                P.SUBJ_PARAM_ID,
                P.PARAM_VALUE,
				P.value3,
				P.value4,
				P.value5,
				P.value6,
				P.value7,
				P.value8
        FROM [dbo].[#SUBJ_PARAM] P JOIN [dbo].[#SUBJ] S ON P.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        if @AggData = 1
        begin
                DELETE FROM FFS
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FOKVED
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FFS2010
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FOKVED2010
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FSVT2012
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FAnaliz
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6
                WHERE F6_ID IN (SELECT F.F6_ID FROM FORM6HDR F JOIN SUBJ S ON F.SUBJ_ID = S.SUBJ_ID JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6HDR
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FOKVED2010 (
                        [SUBJ_ID],
                        [NUM],
                        [A],
                        [B],
                        [C],
                        [D],
                        [E],
                        [F],
                        [G],
                        [H],
                        [I],
                        [J],
                        [K],
                        [L],
                        [M],
                        [N],
                        [O],
                        [P],
                        [Q],
                        [R],
                        [S],
                        [T],
                        [U]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
                        F.[A],
                        F.[B],
                        F.[C],
                        F.[D],
                        F.[E],
                        F.[F],
                        F.[G],
                        F.[H],
                        F.[I],
                        F.[J],
                        F.[K],
                        F.[L],
                        F.[M],
                        F.[N],
                        F.[O],
                        F.[P],
                        F.[Q],
                        F.[R],
                        F.[S],
                        F.[T],
                        F.[U]
                FROM [dbo].[#FOKVED2010] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FSVT2012 (
                        [SUBJ_ID],
                        [NUM],
						[N02],
						[N03],
						[N04],
						[N05],
						[N06],
						[N07],
						[N08],
						[N09],
						[N10],
						[N11]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
						F.[N02],
						F.[N03],
						F.[N04],
						F.[N05],
						F.[N06],
						F.[N07],
						F.[N08],
						F.[N09],
						F.[N10],
						F.[N11]
                FROM [dbo].[#FSVT2012] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FAnaliz (
                        [SUBJ_ID],
                        [NUM],
						[N01],
						[N02],
						[N06],
						[N10],
						[N12]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
						F.[N01],
						F.[N02],
						F.[N06],
						F.[N10],
						F.[N12]
                FROM [dbo].[#FAnaliz] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FFS2010 (
                        [SUBJ_ID],
                        [FS_ID],
                        [FS_NAME],
                        [KOD],
                        [CITY],
                        [TOWN],
                        [VILLAGE],
                        [TOWNVILLAGE],
                        [INCITY]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[FS_ID],
                        F.[FS_NAME],
                        F.[KOD],
                        F.[CITY],
                        F.[TOWN],
                        F.[VILLAGE],
                        F.[TOWNVILLAGE],
                        F.[INCITY]
                FROM [dbo].[#FFS2010] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                        COL_16,
		                COL_10T,
				        COL_12T
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
                        FF.COL_16,
		                FF.COL_10T,
				        FF.COL_12T
                FROM [dbo].[#FORM6] FF JOIN [dbo].[#FORM6HDR] F ON FF.F6_ID = F.F6_ID JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID =S.SUBJ_ID JOIN SUBJ SS ON SS.TERR_ID = S.TERR_ID JOIN FORM6HDR H ON H.SUBJ_ID = SS.SUBJ_ID AND CAST(H.F6_SHIFR as int)=CAST(F.F6_SHIFR as int)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6HDR
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_CONT
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_PAYM
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM OSN
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM PER
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORGSET
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG
                WHERE TERR_ID IN (SELECT TERR_ID FROM [dbo].[#SUBJ])
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                        SBM,
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
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed,
                        Okved_Changed
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
                        SBM,
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
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed,
                        Okved_Changed
                FROM [dbo].[#ORG]
                WHERE TERR_ID IN (SELECT TERR_ID FROM [dbo].[#SUBJ])
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
        end else begin
                DELETE FROM FORM6
                WHERE F6_ID IN (SELECT F.F6_ID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID JOIN FORM6HDR F ON O.ORGID = F.ORGID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6HDR
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_CONT
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_PAYM
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM OSN
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM PER
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                        SBM = O.SBM,
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
                        OVK_ID = O.OVK_ID,
                        KODOKTMO = O.KODOKTMO,
						KODOKTMO2 = O.KODOKTMO2,
						REGPLACE = O.REGPLACE,
						COMPUTERS = O.COMPUTERS,
						SOFTWARENUM = O.SOFTWARENUM,
						KPIS = O.KPIS,
						COMPUTERSS = O.COMPUTERSS,
						SOFTWARENUMS = O.SOFTWARENUMS,
						KPISS = O.KPISS,
						SOFTWARE = O.SOFTWARE,
                        Kopf_Changed = O.Kopf_Changed,
                        Okved_Changed = O.Okved_Changed
                FROM [dbo].[#ORG] O
                WHERE O.TERR_ID IN (SELECT TERR_ID FROM [dbo].[#SUBJ])
                AND ORG.TERR_ID = O.TERR_ID AND ORG.EXT_ID = O.ORGID
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                        SBM,
                        TERR_ID,
                        EXT_ID,
                        HAS_BRON,
                        CHK_DATE,
                        F6_SHIFR,
                        REGPL_ID,
                        OKATO2,
                        OKATO3,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed,
                        Okved_Changed
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
                        SBM,
                        TERR_ID,
                        ORGID,
                        HAS_BRON,
                        CHK_DATE,
                        F6_SHIFR,
                        REGPL_ID,
                        OKATO2,
                        OKATO3,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed,
                        Okved_Changed
                FROM [dbo].[#ORG] O
                WHERE ORGID NOT IN (
                        SELECT O.ORGID FROM [dbo].[#ORG] O JOIN [dbo].[#SUBJ] S ON S.TERR_ID = O.TERR_ID
                                       JOIN ORG OO ON OO.EXT_ID = O.ORGID AND OO.TERR_ID = O.TERR_ID)

                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                RAZD_NO,
                Okved_Name
        )
        SELECT
                OO.ORGID,
                P.DOC_ID,
                P.DOC_NO,
                P.START_DATE,
                P.END_DATE,
                P.PER_NO,
                P.RAZD_NO,
                Okved_Name
        FROM [dbo].[#PER] P JOIN [dbo].[#ORG] O ON P.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
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
                COL_16,
                COL_10T,
		        COL_12T
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
                FF.COL_16,
                FF.COL_10T,
		        FF.COL_12T
        FROM [dbo].[#FORM6] FF JOIN [dbo].[#FORM6HDR] F ON FF.F6_ID = F.F6_ID JOIN [dbo].[#ORG] O ON F.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID JOIN FORM6HDR H ON H.ORGID = OO.ORGID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        UPDATE SUBJ SET REPORT_DATE = GETDATE() WHERE SUBJ_ID=@SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно произвести импорт субъекта.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


CREATE     PROCEDURE [dbo].[sp_FFSGenerate] -- changed in ver 3.71
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
    raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
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
        raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
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
                raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_FOKVEDClear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FOKVED
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE  PROCEDURE [dbo].[sp_FOKVEDCreate]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FOKVED
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FOKVED(SUBJ_ID, OKVED_SECTION)
        SELECT @SUBJ_ID, OKVED_SECTION FROM KOKVED_
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE     PROCEDURE [dbo].[sp_FOKVEDGenerate]
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
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
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
                                               AND FORM6.COL_B=5
                                               --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                               )
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
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
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
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION







GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE    PROCEDURE [dbo].[sp_FFSCreate]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FFS
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FFS(SUBJ_ID, FS_ID, FS_NAME, KOD)
        SELECT @SUBJ_ID, FS_ID, FS_NAME, KOD FROM KFS_
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


Create PROCEDURE [dbo].[sp_CalcSubjParams377] -- changed in ver 3.71
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




GO

CREATE     PROCEDURE [dbo].[sp_CalcSubjParams] -- changed in ver 3.71
        @ORG_COUNT      int     out,
        @PRIVORG_COUNT  int     out,
        @RAB_COUNT      float   out,
        @OKRUG_COUNT    int     out,
        @RAYON_COUNT    int     out,
        @POPULATION     float   out
AS

DECLARE @OKATO VarChar(11), @KODTERR VarChar(20), @KTERR VarChar(20)

SELECT @OKATO   = SUBJ.KodReg
     , @KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
     , @KTERR   = KTERR.KODTERR
  FROM SUBJ, CURR_SUBJ, KTERR
 WHERE SUBJ.SUBJ_ID=CURR_SUBJ.SUBJ_ID
   AND SUBJ.TERR_ID=KTERR.TERR_ID

SELECT
       @OKRUG_COUNT     = NULL,
       @RAYON_COUNT     = NULL,
       @ORG_COUNT       = ISNULL(SUM(1), 0),
       @PRIVORG_COUNT   = ISNULL(SUM(CASE WHEN o.KFP_ID = 3 THEN 1 ELSE 0 END), 0),
       @RAB_COUNT       = CAST(ISNULL(SUM(o.RAB_COUNT), 0) AS float) / 1000
  FROM v_ORG o
     , SUBJ s
     , KTERR t
 WHERE o.TERR_ID = s.TERR_ID
   AND o.TERR_ID = t.TERR_ID
   AND t.KODTERR LIKE @KODTERR --child or self
   AND s.SUBJ_AGG_ID = 1 -- cards
   AND o.OUT_DATE IS NULL

SELECT
       @ORG_COUNT       = @ORG_COUNT     + ISNULL(SUM(CASE WHEN SUBJ_PARAM_ID = 10 THEN PARAM_VALUE ELSE 0 END), 0),
       @PRIVORG_COUNT   = @PRIVORG_COUNT + ISNULL(SUM(CASE WHEN SUBJ_PARAM_ID = 11 THEN PARAM_VALUE ELSE 0 END), 0),
       @RAB_COUNT       = @RAB_COUNT     + ISNULL(SUM(CASE WHEN SUBJ_PARAM_ID = 2 THEN PARAM_VALUE ELSE 0 END), 0)
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

DECLARE @APOPULATION    float

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
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO




CREATE PROCEDURE [dbo].[sp_SubjCurrSet]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM CURR_SUBJ
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сделать территориальный орган текущим.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO CURR_SUBJ (SUBJ_ID)
        VALUES (@SUBJ_ID)
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сделать территориальный орган текущим.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        UPDATE SUBJ
        SET SUBJ_AGG_ID = 1
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сделать территориальный орган текущим.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

Create PROCEDURE CHECK_F6 AS

UPDATE form6hdr
   SET CHECKED = CASE WHEN F6_ID in(
                    SELECT f6.F6_ID
                      FROM FORM6 f6
                     WHERE
                           ISNULL(COL_1,0) <  ISNULL(COL_2,0)+ISNULL(COL_11,0)
                        OR ISNULL(COL_2,0) <> ISNULL(COL_3,0)+ISNULL(COL_4,0)
                        OR ISNULL(COL_2,0) <  ISNULL(COL_9,0)+ISNULL(COL_10,0)
                        OR ISNULL(COL_3,0) <  ISNULL(COL_7,0)
                        OR ISNULL(COL_4,0) <  ISNULL(COL_8,0)
                        OR ISNULL(COL_6,0) <> ISNULL(COL_7,0)+ISNULL(COL_8,0)
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
                         /*, n_12 = SUM(ISNULL(sf6.COL_12,0))- ISNULL(f6.COL_12,0)
                         , n_13 = SUM(ISNULL(sf6.COL_13,0))- ISNULL(f6.COL_13,0)
                         , n_14 = SUM(ISNULL(sf6.COL_14,0))- ISNULL(f6.COL_14,0)
                         , n_15 = SUM(ISNULL(sf6.COL_15,0))- ISNULL(f6.COL_15,0)*/
                      FROM (SELECT *
                                 , ExpPlus = '+'+ISNULL(
                                                CASE CPROF_ID
                                                  WHEN 400 THEN '410+420'
                                                  WHEN 1000 THEN '100+200+300+400'
                                                  WHEN 496 THEN '1000'
                                                  WHEN 500 THEN '1000'
                                                  ELSE LTrim(EXPRESSION)
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
                         /*, f6.COL_12
                         , f6.COL_13
                         , f6.COL_14
                         , f6.COL_15*/
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
                                       /*OR n_12< 0
                                       OR n_13< 0
                                       OR n_14< 0
                                       OR n_15< 0*/))
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
                                       /*OR n_12> 0
                                       OR n_13> 0
                                       OR n_14> 0
                                       OR n_15> 0*/))
                         OR (CPROF_ID in (400, 1000)
                         AND (n_1 <> 0
                                       OR n_2 <> 0
                                       OR n_3 <> 0
                                       OR n_4 <> 0
                                       OR n_5 <> 0
                                       OR n_6 <> 0
                                       OR n_7 <> 0
                                       OR n_8 <> 0
                                       OR n_9 <> 0
                                       OR n_10<> 0
                                       /*OR n_11<> 0
                                       OR n_12<> 0
                                       OR n_13<> 0
                                       OR n_14<> 0
                                       OR n_15<> 0*/))
                                   THEN 1 ELSE 0 END)
THEN 0 ELSE 1 END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO




CREATE PROCEDURE [dbo].[sp_DeleteForm6]
        @F6_ID int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить форму № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FORM6HDR
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить форму № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO




CREATE PROCEDURE [dbo].[sp_Form6Clear]
        @SUBJ_ID int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FORM6
        WHERE F6_ID in (SELECT F6_ID FROM FORM6HDR WHERE SUBJ_ID = @SUBJ_ID)
        if @@ERROR != 0
        begin
                raiserror ('Невозможно очистить формы № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FORM6HDR
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно очистить формы № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO




CREATE PROCEDURE [dbo].[sp_Form6Create]
        @SUBJ_ID int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FORM6
        WHERE F6_ID in (SELECT F6_ID FROM FORM6HDR WHERE SUBJ_ID = @SUBJ_ID)
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать формы № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FORM6HDR
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать формы № 6.', 16, 1)
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
                raiserror ('Невозможно создать формы № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT KCPROF.CPROF_ID, FORM6HDR.F6_ID, KCPROF.PRINT_NAME, KCPROF.EXPRESSION, 0, KCPROF.LINE_NO
        FROM FORM6HDR JOIN KCPROF on FORM6HDR.SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать формы № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO




CREATE PROCEDURE [dbo].[sp_GenerateForm6]
        @ORG_ID int,
        @F6_ID  int     out
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FORM6
        WHERE F6_ID IN (SELECT F6_ID FROM FORM6HDR WHERE ORGID=@ORG_ID)
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать форму № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FORM6HDR
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать форму № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FORM6HDR (ORGID, ORGNAME, F6_SHIFR)
        SELECT ORGID, ORGNAME, F6_SHIFR FROM ORG WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать форму № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        SELECT @F6_ID = @@IDENTITY
        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror ('Невозможно сформировать форму № 6.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


Create PROCEDURE [dbo].[sp_GenerateForm6_01]
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


Create PROCEDURE [dbo].[sp_GenerateForm6_02]
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

Create PROCEDURE [dbo].[sp_GenerateForm6_03]
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

Create PROCEDURE [dbo].[sp_GenerateForm6_04]
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

Create PROCEDURE [dbo].[sp_GenerateForm6_05]
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

Create PROCEDURE [dbo].[sp_GenerateForm6_06]
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



SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

Create PROCEDURE [dbo].[sp_ImportOrg]
        @EXT_ID int     out
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare
        @ORG_ID int,
        @MAINOKONH      varchar(5),
        @KODREG varchar(11),
        @TERR_ID        int,
        @F6_ID  int,
        @F6_SHIFR       varchar(2)

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
                        raiserror ('Невозможно произвести импорт организации.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6HDR
                WHERE ORGID = @EXT_ID
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт организации.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_CONT
                WHERE ORGID = @EXT_ID
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт организации.', 16, 1)
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_PAYM
                WHERE ORGID = @EXT_ID
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт организации.', 16, 1)
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
                        SBM = T.SBM,
                        TERR_ID = T.TERR_ID,
                        F6_SHIFR = T.F6_SHIFR,
                        REGPL_ID=T.REGPL_ID,
                        OKATO2=T.OKATO2,
                        OKATO3=T.OKATO3,
                        FEATURE1=T.FEATURE1,
                        FEATURE2=T.FEATURE2,
                        FEATURE3=T.FEATURE3,
                        OVK_ID = T.OVK_ID,
                        KODOKTMO = T.KODOKTMO,
						KODOKTMO2 = T.KODOKTMO2,
						REGPLACE = T.REGPLACE,
						COMPUTERS = T.COMPUTERS,
						SOFTWARENUM = T.SOFTWARENUM,
						KPIS = T.KPIS,
						COMPUTERSS = T.COMPUTERSS,
						SOFTWARENUMS = T.SOFTWARENUMS,
						KPISS = T.KPISS,
						SOFTWARE = T.SOFTWARE,
                        Kopf_Changed = T.Kopf_Changed,
                        Okved_Changed = T.Okved_Changed
                FROM [dbo].[#ORG] T
                WHERE ORG.ORGID = @EXT_ID
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт организации.', 16, 1)
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
                        SBM,
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
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed,
                        Okved_Changed
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
                        SBM,
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
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed,
                        Okved_Changed
                FROM [dbo].[#ORG]
                if @@ERROR != 0
                begin
                        raiserror ('Невозможно произвести импорт организации.', 16, 1)
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
                raiserror ('Невозможно произвести импорт организации.', 16, 1)
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
                raiserror ('Невозможно произвести импорт организации.', 16, 1)
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
                raiserror ('Невозможно произвести импорт организации.', 16, 1)
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
                COL_16,
                COL_10T,
                COL_12T
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
                COL_16,
                COL_10T,
                COL_12T
        FROM [dbo].[#FORM6]
        WHERE F6_ID = (SELECT TOP 1 F6_ID FROM [dbo].[#FORM6HDR])
        if @@ERROR != 0
        begin
                raiserror ('Невозможно произвести импорт организации.', 16, 1)
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
                raiserror ('Невозможно произвести импорт организации.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
              /*insert into [dbo].[#ORG_PER] (doc_id, doc_no, start_date, end_date, per_no, razd_no)
              select doc_id, doc_no, start_date, end_date, per_no, razd_no
              from PER
              where OrgId=@EXT_ID*/
              delete
              from PER
              where OrgId=@EXT_ID

              declare @per_no varchar(4000), @okved_name varchar(255), @razd_no varchar(4000), @r_no varchar(4000)
              declare xx cursor for 
              select per_no, max(Okved_Name)  
              from [dbo].[#ORG_PER]
			  group by per_no
              open xx
              fetch next from xx into @per_no, @okved_name
              while @@fetch_status = 0 begin

              	  set @razd_no = ''

	              declare yy cursor for 
				  select distinct razd_no  
				  from [dbo].[#ORG_PER] Where per_no = @per_no
				  open yy
			      fetch next from yy into @r_no
                  while @@fetch_status = 0 begin
              		  set @razd_no = @razd_no + @r_no + '; '
					  fetch next from yy into @r_no
				  end
				  close yy
				  deallocate yy

				  if len(@razd_no) > 0 set @razd_no = SUBSTRING(@razd_no, 1, len(@razd_no)-1)

	              insert into PER (orgid, per_no, razd_no, okved_name)
		          Values (@EXT_ID, @per_no, @razd_no, @okved_name)

	              fetch next from xx into @per_no, @okved_name
              end
			  close xx
			  deallocate xx


COMMIT TRANSACTION


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO




CREATE PROCEDURE [dbo].[sp_OrgCardDelete]
        @ORG_ID int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FORM6
        WHERE F6_ID in (select F6_ID from FORM6HDR where ORGID = @ORG_ID)
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку организации.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FORM6HDR
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку организации.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM ORG_CONT
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку организации.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM OSN
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку организации.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM PER
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку организации.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM ORG_PAYM
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку организации.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM ORGSET
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку организации.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM ORG
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку организации.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO




CREATE PROCEDURE [dbo].[sp_SubjCardDelete]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        if exists (select * from ORG WHERE TERR_ID IN (SELECT TERR_ID FROM SUBJ WHERE SUBJ_ID = @SUBJ_ID))
        begin
                raiserror ('Невозможно удалить карточку территориального органа. В списке есть организации, находящиеся на данной территории.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FORM6
        WHERE F6_ID in (select F6_ID from FORM6HDR where SUBJ_ID = @SUBJ_ID)
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку территориального органа.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FORM6HDR
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку территориального органа.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FOKVED
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку территориального органа.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM FFS
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку территориального органа.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM SUBJ_INFO
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку территориального органа.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM SUBJ_PARAM
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку территориального органа.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM SUBJ
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить карточку территориального органа.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE  PROCEDURE [dbo].[sp_FFS2010Clear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FFS2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить форму по видам собственности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

CREATE  PROCEDURE [dbo].[sp_FFS2010Create]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FFS2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FFS2010(SUBJ_ID, FS_ID, FS_NAME, KOD)
        SELECT @SUBJ_ID, FS_ID, FS_NAME, KOD FROM KFS_
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам собственности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

Create PROCEDURE [dbo].[sp_FFS2010Generate]
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

CREATE PROCEDURE [dbo].[sp_FOKVED2010Clear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FOKVED2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

CREATE PROCEDURE [dbo].[sp_FSVT2012Clear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FSVT2012
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить форму по сведениям об использовании СВТ.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

CREATE PROCEDURE [dbo].[sp_FOKVED2010Create]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FOKVED2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FOKVED2010(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, 10 UNION ALL
        SELECT @SUBJ_ID, 15 UNION ALL
        SELECT @SUBJ_ID, 20 UNION ALL
        SELECT @SUBJ_ID, 30 UNION ALL
        SELECT @SUBJ_ID, 40
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

CREATE PROCEDURE [dbo].[sp_FSVT2012Create]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FSVT2012
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по сведениям об использовании СВТ.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FSVT2012(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, 10 UNION ALL
        SELECT @SUBJ_ID, 20 UNION ALL
        SELECT @SUBJ_ID, 30 UNION ALL
        SELECT @SUBJ_ID, 40
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по сведениям об использовании СВТ.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO


Create  PROCEDURE [dbo].[sp_FOKVED2010Generate]
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  create table [dbo].[#temp] (SUBJ_ID int, OKVED_SECTION char(1),
        ORG_COUNT int, ORGB_COUNT int, RAB_COUNT int, ZAP_COUNT int, ZAB_COUNT int
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
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO [dbo].[#temp]([SUBJ_ID], [OKVED_SECTION]
        , [ORG_COUNT]
        , [ORGB_COUNT]
        , [RAB_COUNT]
        , [ZAP_COUNT]
        , [ZAB_COUNT])
        SELECT @SUBJ_ID, K.OKVED_SECTION,
          NULLIF(COUNT(O.ORGID),0) AS ORG_COUNT,
          NULLIF(SUM(case when O.HAS_BRON = 1 then 1 else 0 end),0) AS ORGB_COUNT,
          NULLIF(SUM(O.RAB_COUNT),0) AS RAB_COUNT,
          NULLIF(SUM(O.ZAP_COUNT),0) AS ZAP_COUNT,
          NULLIF(SUM(O.ZAB_COUNT),0) AS ZAB_COUNT
          FROM KOKVED_ K LEFT OUTER JOIN
               (select
                  OO.ORGID
                , OO.RAB_COUNT as RAB_COUNT
                , OO.ZAP_COUNT as ZAP_COUNT
                , OO.ZAB_COUNT as ZAB_COUNT
                , OO.HAS_BRON
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
                                               AND FORM6.COL_B=5
                                               --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                               )
               ) O ON (O.OKVED_FIRST BETWEEN K.OKVED_BEGIN AND K.OKVED_END)
        GROUP BY K.OKVED_SECTION

        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

insert into FOKVED2010 (SUBJ_ID, NUM, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U)
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
  Q = (select ORG_COUNT from #temp where OKVED_SECTION = 'Q'),
  R = (select ORG_COUNT from #temp where OKVED_SECTION = 'R'),
  S = (select ORG_COUNT from #temp where OKVED_SECTION = 'S'),
  T = (select ORG_COUNT from #temp where OKVED_SECTION = 'T'),
  U = (select ORG_COUNT from #temp where OKVED_SECTION = 'U')
union all
select SUBJ_ID = @SUBJ_ID, NUM = 15,
  A = (select ORGB_COUNT from #temp where OKVED_SECTION = 'A'),
  B = (select ORGB_COUNT from #temp where OKVED_SECTION = 'B'),
  C = (select ORGB_COUNT from #temp where OKVED_SECTION = 'C'),
  D = (select ORGB_COUNT from #temp where OKVED_SECTION = 'D'),
  E = (select ORGB_COUNT from #temp where OKVED_SECTION = 'E'),
  F = (select ORGB_COUNT from #temp where OKVED_SECTION = 'F'),
  G = (select ORGB_COUNT from #temp where OKVED_SECTION = 'G'),
  H = (select ORGB_COUNT from #temp where OKVED_SECTION = 'H'),
  I = (select ORGB_COUNT from #temp where OKVED_SECTION = 'I'),
  J = (select ORGB_COUNT from #temp where OKVED_SECTION = 'J'),
  K = (select ORGB_COUNT from #temp where OKVED_SECTION = 'K'),
  L = (select ORGB_COUNT from #temp where OKVED_SECTION = 'L'),
  M = (select ORGB_COUNT from #temp where OKVED_SECTION = 'M'),
  N = (select ORGB_COUNT from #temp where OKVED_SECTION = 'N'),
  O = (select ORGB_COUNT from #temp where OKVED_SECTION = 'O'),
  P = (select ORGB_COUNT from #temp where OKVED_SECTION = 'P'),
  Q = (select ORGB_COUNT from #temp where OKVED_SECTION = 'Q'),
  R = (select ORGB_COUNT from #temp where OKVED_SECTION = 'R'),
  S = (select ORGB_COUNT from #temp where OKVED_SECTION = 'S'),
  T = (select ORGB_COUNT from #temp where OKVED_SECTION = 'T'),
  U = (select ORGB_COUNT from #temp where OKVED_SECTION = 'U')
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
  (select RAB_COUNT from #temp where OKVED_SECTION = 'Q'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'R'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'S'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'T'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'U')
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
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'Q'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'R'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'S'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'T'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'U')
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
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'Q'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'R'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'S'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'T'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'U')

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
                Q = S.SUM_Q,
                R = S.SUM_R,
                S = S.SUM_S,
                T = S.SUM_T,
                U = S.SUM_U
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
        NULLIF(SUM(P),0) AS SUM_P,
        NULLIF(SUM(Q),0) AS SUM_Q,
        NULLIF(SUM(R),0) AS SUM_R,
        NULLIF(SUM(S),0) AS SUM_S,
        NULLIF(SUM(T),0) AS SUM_T,
        NULLIF(SUM(U),0) AS SUM_U
                FROM FOKVED2010
                WHERE (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY NUM
        ) S
        WHERE S.NUM = FOKVED2010.NUM AND FOKVED2010.SUBJ_ID=@SUBJ_ID

        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по видам экономической деятельности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO



Create PROCEDURE [dbo].[sp_FSVT2012Generate]
--declare
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
--set        @SUBJ_ID        = 2
--set        @IS_FULL        = 1
--set        @FilterType     = 1
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  create table [dbo].[#temp] (SUBJ_ID int, NUM int, CITY int, CITYS int, VILL int, VILLS int
  )

DECLARE @KODTERR VarChar(20)

SELECT @KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
  FROM SUBJ, KTERR
 WHERE SUBJ.TERR_ID=KTERR.TERR_ID and Subj.Subj_Id = @Subj_Id


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

        DELETE FROM FSVT2012
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по сведениям об использовании СВТ.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        
        INSERT INTO FSVT2012(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, 10 UNION ALL
        SELECT @SUBJ_ID, 20 UNION ALL
        SELECT @SUBJ_ID, 30 UNION ALL
        SELECT @SUBJ_ID, 40

        
	INSERT INTO [dbo].[#temp]([SUBJ_ID], NUM, CITY, CITYS, VILL, VILLS)
	SELECT @SUBJ_ID, 10, 
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else computers end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else computerss end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then computers else 0 end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then computerss else 0 end)
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join KTERR t on oo.TERR_ID = t.TERR_ID
	     join FORM6HDR f6h on f6h.ORGID = oo.ORGID
	 WHERE 
	   OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	   and f6h.f6_shifr <> '01'
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL
union
	SELECT @SUBJ_ID, 20, 
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else softwarenum end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else softwarenums end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then softwarenum else 0 end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then softwarenums else 0 end)
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join KTERR t on oo.TERR_ID = t.TERR_ID
	     join FORM6HDR f6h on f6h.ORGID = oo.ORGID
	 WHERE 
	   OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	   and f6h.f6_shifr <> '01'
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL
union
	SELECT @SUBJ_ID, 30, 
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else kpis end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 0 else kpiss end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then kpis else 0 end),
		sum(Case when SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then kpiss else 0 end)
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join KTERR t on oo.TERR_ID = t.TERR_ID
	     join FORM6HDR f6h on f6h.ORGID = oo.ORGID
	 WHERE 
	   OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	   and f6h.f6_shifr <> '01'
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL


Update FSVT2012 set
	N04 = x.N04, N05 = x.N05, N06 = x.N06, N07 = x.N07, 
	N08 = IsNull(x.N08,0) + IsNull(t.City, 0), 
	N09 = IsNull(x.N09,0) + IsNull(t.CityS, 0), 
	N10 = IsNull(x.N10,0) + IsNull(t.Vill, 0), 
	N11 = IsNull(x.N11,0) + IsNull(t.VillS, 0)
from FSVT2012 F
left join (
	select Num, Sum(N02) N02, Sum(N03) N03, Sum(N04) N04, Sum(N05) N05, Sum(N06) N06, Sum(N07) N07, Sum(N08) N08, Sum(N09) N09, Sum(N10) N10, Sum(N11) N11
	from FSVT2012 FF
    join SUBJ s on ff.SUBJ_ID = s.SUBJ_ID and s.Subj_Id <> @Subj_Id AND 
	   s.Subj_Id IN (SELECT ss.SubjId FROM [dbo].[#SubjSET] ss)
    --join KTERR t on s.TERR_ID = t.TERR_ID and t.KODTERR LIKE @KODTERR --child and not self
	where s.Subj_Agg_Id = 2
    group by Num
) x on x.Num = F.Num
left join [dbo].[#temp] t on t.Num = F.Num
Where F.Subj_Id = @Subj_Id


Update FSVT2012 set
	N04 = IsNull(ff.N04,0)-IsNull(fff.N04,0), 
	N05 = IsNull(ff.N05,0)-IsNull(fff.N05,0), 
	N06 = IsNull(ff.N06,0)-IsNull(fff.N06,0), 
	N07 = IsNull(ff.N07,0)-IsNull(fff.N07,0), 
	N08 = IsNull(ff.N08,0)-IsNull(fff.N08,0), 
	N09 = IsNull(ff.N09,0)-IsNull(fff.N09,0), 
	N10 = IsNull(ff.N10,0)-IsNull(fff.N10,0), 
	N11 = IsNull(ff.N11,0)-IsNull(fff.N11,0) 
from FSVT2012 F
left join (select * from FSVT2012) FF on FF.Subj_Id = @Subj_Id and FF.Num = 20
left join (select * from FSVT2012) FFF on FFF.Subj_Id = @Subj_Id and FFF.Num = 30
Where F.Subj_Id = @Subj_Id and F.Num = 40

                                         
Update FSVT2012 set
	N02 = IsNull(N04,0)+IsNull(N06,0)+IsNull(N08,0)+IsNull(N10,0), 
	N03 = IsNull(N05,0)+IsNull(N07,0)+IsNull(N09,0)+IsNull(N11,0)
from FSVT2012 F
Where Subj_Id = @Subj_Id 

                                         
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по сведениям об использовании СВТ.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

drop table [dbo].[#OrgSet] 

drop table [dbo].[#SubjSet]

drop table [dbo].[#temp]

COMMIT TRANSACTION

--select * from FSVT2012

GO



CREATE    PROCEDURE [dbo].[CHECK_ALL]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
declare @DIFF int, @SUBJ_NAME varchar(250), @error varchar(8000)
select @SUBJ_NAME = SUBJ_NAME from SUBJ where SUBJ_ID = @SUBJ_ID
set @error = ''

select
@DIFF = (IsNull((select IsNull(F6_COUNT, 0) + IsNull(KUO_COUNT, 0)
        from form6hdr where F6_SHIFR = '01' and SUBJ_ID = @SUBJ_ID), 0) +
IsNull((select IsNull(F6_COUNT, 0) + IsNull(KUO_COUNT, 0)
        from form6hdr where F6_SHIFR = '04' and SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0) + 
        IsNull(R, 0) + IsNull(S, 0) + IsNull(T, 0) + IsNull(U, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 10

  if @DIFF != 0
        set @error = @error + 'Количество подотчетных организаций в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select
@DIFF = (IsNull((select IsNull(F6_COUNT, 0) + IsNull(KUO_COUNT, 0)
        from form6hdr where F6_SHIFR = '01' and SUBJ_ID = @SUBJ_ID), 0) +
IsNull((select IsNull(F6_COUNT, 0) + IsNull(KUO_COUNT, 0)
        from form6hdr where F6_SHIFR = '04' and SUBJ_ID = @SUBJ_ID), 0)) -
(Sum(IsNull(CITY, 0)) + Sum(IsNull(TOWN, 0)) + Sum(IsNull(VILLAGE, 0)) + Sum(IsNull(TOWNVILLAGE, 0)) +
        Sum(IsNull(INCITY, 0)))
from FFS2010
where SUBJ_ID = @SUBJ_ID

  if @DIFF != 0
        set @error = @error + 'Количество подотчетных организаций в форме 6 и по видам собственности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select @DIFF =
(IsNull((select Sum(IsNull(f6.COL_1, 0))
from form6 f6
join form6hdr f6h on f6h.F6_ID = f6.F6_ID
where f6.CPROF_ID = 1000 and f6h.F6_SHIFR in ('01', '04') and f6h.SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0) + 
        IsNull(R, 0) + IsNull(S, 0) + IsNull(T, 0) + IsNull(U, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 20

  if @DIFF != 0
        set @error = @error + 'Количество "Всего работающих" в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select @DIFF =
(IsNull((select Sum(IsNull(f6.COL_2, 0))
from form6 f6
join form6hdr f6h on f6h.F6_ID = f6.F6_ID
where f6.CPROF_ID = 1000 and f6h.F6_SHIFR in ('01', '04') and f6h.SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0) + 
        IsNull(R, 0) + IsNull(S, 0) + IsNull(T, 0) + IsNull(U, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 30

  if @DIFF != 0
        set @error = @error + 'Количество "Всего ГПЗ" в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select @DIFF =
(IsNull((select Sum(IsNull(f6.COL_6, 0))
from form6 f6
join form6hdr f6h on f6h.F6_ID = f6.F6_ID
where f6.CPROF_ID = 1000 and f6h.F6_SHIFR in ('01', '04') and f6h.SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0) + 
        IsNull(R, 0) + IsNull(S, 0) + IsNull(T, 0) + IsNull(U, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 40

  if @DIFF != 0
        set @error = @error + 'Количество "Всего забронировано" в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)


if @error != ''
begin
    raiserror (@error, 16, 1)
    return
end

GO

CREATE TRIGGER [ORG_INSERT] ON dbo.ORG
FOR INSERT
AS
        update ORG
        set ext_id = orgid
        where ORGID in (SELECT ORGID FROM inserted)
        and ext_id is null



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [dbo].[sp_FAnalizClear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FAnaliz
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно удалить форму по анализу обеспеченности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO




CREATE PROCEDURE [dbo].[sp_FAnalizCreate]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FAnaliz
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по анализу обеспеченности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FAnaliz(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, CProf_Id
        From KCProf
        WHERE CPROF_ID in (100,200,300,400,410,1000)
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по анализу обеспеченности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO





Create PROCEDURE [dbo].[sp_FAnalizGenerate]
--declare
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
--set        @SUBJ_ID        = 2
--set        @IS_FULL        = 1
--set        @FilterType     = 1
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)


DECLARE @KODTERR VarChar(20)

SELECT @KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
  FROM SUBJ, KTERR
 WHERE SUBJ.TERR_ID=KTERR.TERR_ID and Subj.Subj_Id = @Subj_Id


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


        DELETE FROM FAnaliz
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по анализу обеспеченности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end
        
        INSERT INTO FAnaliz(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, CProf_Id
        From KCProf
        WHERE CPROF_ID in (100,200,300,400,410,1000)

        

Update FAnaliz set
	N01 = IsNull(x.N01,0) + IsNull(y.Col_1, 0), 
	N02 = IsNull(x.N02,0) + IsNull(y.Col_2, 0), 
	N06 = IsNull(x.N06,0) + IsNull(y.Col_6, 0), 
	N10 = IsNull(x.N10,0) + IsNull(y.Col_10, 0), 
	N12 = IsNull(x.N12,0) + IsNull(y.Col_12, 0)
from FAnaliz F
left join (
	select Num, Sum(N01) N01, Sum(N02) N02, Sum(N06) N06, Sum(N10) N10, Sum(N12) N12
	from FAnaliz FF
    join SUBJ s on ff.SUBJ_ID = s.SUBJ_ID and s.Subj_Id <> @Subj_Id AND 
	   s.Subj_Id IN (SELECT ss.SubjId FROM [dbo].[#SubjSET] ss)
    --join KTERR t on s.TERR_ID = t.TERR_ID and t.KODTERR LIKE @KODTERR --child and not self
	where s.Subj_Agg_Id = 2
    group by Num
) x on x.Num = F.Num
left join (
	select CProf_Id Num, Sum(Col_1) Col_1, Sum(Col_2) Col_2, Sum(Col_6) Col_6, Sum(Col_10) Col_10, Sum(Col_12) Col_12
	
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join FORM6HDR h on h.ORGID = oo.ORGID
	     join Form6 f on f.f6_id = h.f6_id

		WHERE f.CPROF_ID in (100,200,300,400,410,1000)
		and h.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL
	   AND oo.HAs_Bron = 1
    group by CProf_Id
) y on y.Num = F.Num
Where F.Subj_Id = @Subj_Id
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по анализу обеспеченности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end


Update FAnaliz set
	N01 = SN01, 
	N02 = SN02, 
	N06 = SN06, 
	N10 = SN10, 
	N12 = SN12
from FAnaliz F
left join (select Sum(ff.N01) SN01, Sum(ff.N02) SN02, Sum(ff.N06) SN06, Sum(ff.N10) SN10, Sum(ff.N12) SN12
 from FAnaliz ff where FF.Subj_Id = @Subj_Id and FF.Num in (100,200,300,400)) x on 1=1
Where F.Subj_Id = @Subj_Id and F.Num = 1000


drop table [dbo].[#OrgSet] 

drop table [dbo].[#SubjSet]

COMMIT TRANSACTION

--select * from FAnaliz


GO



Create PROCEDURE [dbo].[sp_FOrgAnalizGenerate]
--declare
        @ORG_ID        int
--set @Org_Id = 36
AS
SET NOCOUNT ON

CREATE TABLE #FAnaliz(
	[NUM] [int] NOT NULL,
	[N01] [int] NULL,
	[N02] [int] NULL,
	[N06] [int] NULL,
	[N10] [int] NULL,
	[N12] [int] NULL
)


        INSERT INTO #FAnaliz(NUM)
        SELECT CProf_Id
        From KCProf
        WHERE CPROF_ID in (100,200,300,400,410,1000)

        

Update #FAnaliz set
	N01 = IsNull(y.Col_1, 0), 
	N02 = IsNull(y.Col_2, 0), 
	N06 = IsNull(y.Col_6, 0), 
	N10 = IsNull(y.Col_10, 0), 
	N12 = IsNull(y.Col_12, 0)
from #FAnaliz F
left join (
	select CProf_Id Num, Sum(Col_1) Col_1, Sum(Col_2) Col_2, Sum(Col_6) Col_6, Sum(Col_10) Col_10, Sum(Col_12) Col_12
	
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join FORM6HDR h on h.ORGID = oo.ORGID
	     join Form6 f on f.f6_id = h.f6_id

		WHERE f.CPROF_ID in (100,200,300,400,410,1000)
		and h.ORGID = @Org_Id
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL
	   AND oo.HAs_Bron = 1
    group by CProf_Id
) y on y.Num = F.Num
        if @@ERROR != 0
        begin
                raiserror ('Невозможно создать форму по анализу обеспеченности.', 16, 1)
                ROLLBACK TRANSACTION
                return
        end

select 
	case when SubString(ff.PRINT_NAME,1,5)='ВСЕГО' then 'ВСЕГО' 
		else ff.PRINT_NAME end As PRINT_NAME,
  F.*
from #FAnaliz F
join KCProf ff on f.num = ff.cprof_id
order by f.NUM


Drop TABLE #FAnaliz

GO



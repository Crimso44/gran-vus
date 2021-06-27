if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Event]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Event]
GO

CREATE TABLE [dbo].[Event] (
	[Event_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Type] [varchar] (255)  NULL ,
	[Object] [varchar] (50)  NULL ,
	[When] [datetime] NOT NULL ,
	[Who] [int] NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Event] ADD 
	CONSTRAINT [DF__Event__When__662B2B3B] DEFAULT (getdate()) FOR [When],
	CONSTRAINT [DF__Event__Who__671F4F74] DEFAULT (0) FOR [Who]
GO


insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена таблица Event'
from VerInfo
where VerStr='3.7'
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[EventDetail]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[EventDetail]
GO

CREATE TABLE [dbo].[EventDetail] (
	[EventDetail_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[Event_ID] [int] NOT NULL ,
	[Value] [text]  NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена таблица EventDetail'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FFS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FFS]
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

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена таблица FFS'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FOKVED]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FOKVED]
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

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена таблица FOKVED'
from VerInfo
where VerStr='3.7'
GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [name]='ForForm' AND [ID]=object_id('KFS'))
  ALTER TABLE KFS ADD [ForForm] [int] NOT NULL DEFAULT (0)
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице KFS добавлено поле ForForm'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KOKVED]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KOKVED]
GO

CREATE TABLE [dbo].[KOKVED] (
	[OKVED_SECTION] [char] (1)  NOT NULL ,
	[OKVED_SECTION_NAME] [varchar] (254)  NOT NULL ,
	[OKVED_BEGIN] [int] NOT NULL ,
	[OKVED_END] [int] NOT NULL 
) ON [PRIMARY]
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

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена таблица KOKVED'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Users]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Users]
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

ALTER TABLE [dbo].[Users] ADD 
	CONSTRAINT [DF__Users__rAdmin__5F7E2DAC] DEFAULT (0) FOR [rAdmin],
	CONSTRAINT [DF__Users__rImport__607251E5] DEFAULT (0) FOR [rImport],
	CONSTRAINT [DF__Users__rExport__6166761E] DEFAULT (0) FOR [rExport],
	CONSTRAINT [DF__Users__rPrint__625A9A57] DEFAULT (0) FOR [rPrint],
	CONSTRAINT [DF__Users__rEdit__634EBE90] DEFAULT (0) FOR [rEdit],
	CONSTRAINT [DF__Users__rlogin__6442E2C9] DEFAULT (0) FOR [rlogin]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлена таблица Users'
from VerInfo
where VerStr='3.7'
GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [name]='Feature1' AND [ID]=object_id('ORG'))
  ALTER TABLE ORG ADD [Feature1] varchar(30) null
GO
IF NOT EXISTS(SELECT * FROM syscolumns WHERE [name]='Feature2' AND [ID]=object_id('ORG'))
  ALTER TABLE ORG ADD [Feature2] varchar(30) null
GO
IF NOT EXISTS(SELECT * FROM syscolumns WHERE [name]='Feature3' AND [ID]=object_id('ORG'))
  ALTER TABLE ORG ADD [Feature3] varchar(30) null
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице ORG добавлены поля Feature1, Feature2, Feature3'
from VerInfo
where VerStr='3.7'
GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [name]='KODREG' AND [ID]=object_id('SUBJ'))
  ALTER TABLE SUBJ ADD [KODREG] [varchar] (11) NULL
GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [name]='REPORT_DATE' AND [ID]=object_id('SUBJ'))
  ALTER TABLE SUBJ ADD [REPORT_DATE] datetime null
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице SUBJ добавлены поля KODREG, REPORT_DATE'
from VerInfo
where VerStr='3.7'
GO

ALTER TABLE [KTERR] ALTER COLUMN [KODTERR] [varchar] (20)  NULL
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице KTERR поле KODTERR увеличено до 20-ти символов'
from VerInfo
where VerStr='3.7'
GO

ALTER TABLE [KL_FLD] ALTER COLUMN [FLD_NAME] [varchar] (30)  NULL
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице KL_FLD поле FLD_NAME увеличено до 30-ти символов'
from VerInfo
where VerStr='3.7'
GO

ALTER TABLE [VV3] ALTER COLUMN [NAME] [varchar] (50)  NULL
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице VV3 поле NAME увеличено до 50-ти символов'
from VerInfo
where VerStr='3.7'
GO

ALTER TABLE [ORG] ALTER COLUMN [OKATO2] [varchar] (50)  NULL
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице ORG поле OKATO2 увеличено до 50-ти символов'
from VerInfo
where VerStr='3.7'
GO

ALTER TABLE [ORG] ALTER COLUMN [OKATO3] [varchar] (50)  NULL
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице ORG поле OKATO3 увеличено до 50-ти символов'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KOKVED_]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[KOKVED_]
GO

CREATE VIEW KOKVED_ AS 
      SELECT N = ASCII(OKVED_SECTION)-ASCII('A')+1, * FROM KOKVED 
UNION SELECT (SELECT COUNT(*)+1 FROM KOKVED), '_','Прочее',0,0  
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлен вид KOKVED_'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KFS_]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[KFS_]
GO

CREATE VIEW KFS_ AS
SELECT FS_ID, FS_NAME, KOD=ISNULL(KOD,'00') FROM KFS WHERE ForForm<>0
UNION
SELECT 0, 'Прочие', 'ZZ'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'добавлен вид KFS_'
from VerInfo
where VerStr='3.7'
GO

ALTER VIEW dbo.v_SUBJ
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

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлён вид v_SUBJ'
from VerInfo
where VerStr='3.7'
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
                      O.Feature1,O.Feature2,O.Feature3
FROM         ORG O LEFT JOIN
                      KTERR ON O.TERR_ID = KTERR.TERR_ID LEFT JOIN
                      KFS ON O.FS_ID = KFS.FS_ID LEFT JOIN
                      KOPF ON O.KOPF_ID = KOPF.KOPF_ID LEFT JOIN
                      VV5 ON O.SBM_ID = VV5.ID LEFT JOIN
                      FORM6HDR ON O.ORGID = FORM6HDR.ORGID LEFT JOIN
                      KREGPL KRP ON O.REGPL_ID=KRP.REGPL_ID
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлён вид v_ORG'
from VerInfo
where VerStr='3.7'
GO

ALTER  VIEW dbo.v_ORG_01
AS
SELECT *
FROM v_ORG
WHERE OUT_DATE IS NULL
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлён вид v_ORG_01'
from VerInfo
where VerStr='3.7'
GO

ALTER  VIEW dbo.v_ORG_02
AS
SELECT *
FROM v_ORG
WHERE ((F6_SHIFR = '02') OR (F6_SHIFR = '03')) AND (OUT_DATE IS NULL)
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлён вид v_ORG_02'
from VerInfo
where VerStr='3.7'
GO

ALTER  VIEW dbo.v_ORG_03
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '03') AND (OUT_DATE IS NULL)
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'обновлён вид v_ORG_03'
from VerInfo
where VerStr='3.7'
GO




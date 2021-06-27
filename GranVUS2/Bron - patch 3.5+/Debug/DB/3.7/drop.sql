if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_KONH_KBONH]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[KONH] DROP CONSTRAINT FK_KONH_KBONH
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалено ограничение FK_KONH_KBONH'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_USER_ACCESS_USER_FUNCTION]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[USER_ACCESS] DROP CONSTRAINT FK_USER_ACCESS_USER_FUNCTION
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалено ограничение FK_USER_ACCESS_USER_FUNCTION'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_USER_ACCESS_USER_INFO]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[USER_ACCESS] DROP CONSTRAINT FK_USER_ACCESS_USER_INFO
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалено ограничение FK_USER_ACCESS_USER_INFO'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_ORG_KONH]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[ORG] DROP CONSTRAINT FK_ORG_KONH
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалено ограничение FK_ORG_KONH'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FK_FONH_SUBJ]') and OBJECTPROPERTY(id, N'IsForeignKey') = 1)
ALTER TABLE [dbo].[FONH] DROP CONSTRAINT FK_FONH_SUBJ
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалено ограничение FK_FONH_SUBJ'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FONHClear]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FONHClear]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена процедура sp_FONHClear'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FONHCreate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FONHCreate]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена процедура sp_FONHCreate'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FONHGenerate]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_FONHGenerate]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена процедура sp_FONHGenerate'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_UserCardDelete]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_UserCardDelete]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена процедура sp_UserCardDelete'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FONH]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FONH]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена таблица FONH'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KONH]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KONH]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена таблица KONH'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[USER_ACCESS]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[USER_ACCESS]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена таблица USER_ACCESS'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KBONH]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[KBONH]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена таблица KBONH'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[USER_FUNCTION]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[USER_FUNCTION]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена таблица USER_FUNCTION'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[USER_INFO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[USER_INFO]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалена таблица USER_INFO'
from VerInfo
where VerStr='3.7'
GO

if exists (select * from dbo.sysindexes where name = N'IX_ORG_1' and id = object_id(N'[dbo].[ORG]'))
drop index [dbo].[ORG].[IX_ORG_1]
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалён индекс IX_ORG_1'
from VerInfo
where VerStr='3.7'
GO

IF EXISTS(SELECT * FROM syscolumns WHERE [name]='KONH_ID' AND [ID]=object_id('ORG'))
  ALTER TABLE ORG DROP COLUMN [KONH_ID] 
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'удалено поле KONH_ID'
from VerInfo
where VerStr='3.7'
GO

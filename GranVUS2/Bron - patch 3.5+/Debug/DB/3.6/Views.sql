if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_01]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_01]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_02]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_02]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ORG_03]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ORG_03]
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
                      dbo.SUBJ.SUBJ_ADDRESS, dbo.KTERR.KODTERR, dbo.KTERR.NAME AS TERRNAME, dbo.KTERR.KODTERR + ' - ' + dbo.KTERR.NAME AS TERR, 
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



CREATE VIEW dbo.v_ORG
AS
SELECT     O.ORGID, O.TERR_ID, KTERR.NAME AS TERR, O.ORGNAME AS ORGNAME, O.URADDR, O.FIZADDR, O.POSTADDR, O.PHONE, O.OKPO, O.INN, O.OKBV,
                      O.FIRST_DATE, O.LAST_DATE, CAST(CASE WHEN FORM6HDR.F6_ID IS NULL THEN 0 ELSE 1 END AS bit) AS HAS_F6, O.SOOGU, O.PARENT,
                      O.MAINOKONH, O.OKONH, O.OCCUPATION,
                      O.KONH_ID, KONH.KONH_KOD, KONH.KONH_NAME, KONH.KONH_KOD + ' - ' + KONH.KONH_NAME AS KONH,
                      O.FS_ID, KFS.KOD AS KFS_KOD, KFS.FS_NAME, KFS.KOD + ' - ' + KFS.FS_NAME AS KFS,
                      O.KOPF_ID, KOPF.KOD + ' - ' + KOPF.KOPF_NAME AS KOPF, O.KODREG, O.REGDATE, O.REGNUM,
                      KRP.REGPL_NAME AS REG_PLACE, O.COMMENT, O.OUT_REASON, O.OUT_DATE,
                      O.SBM_ID, VV5.KOD AS SBM_KOD, VV5.KOD + ' - ' + VV5.NAME AS SUBMISSION,
                      FORM6HDR.F6_ID, O.HAS_BRON, O.F6_SHIFR,
                      O.CHK_DATE AS CHK_DATE, FORM6HDR.RAB_COUNT, FORM6HDR.ZAP_COUNT, FORM6HDR.ZAB_COUNT, FORM6HDR.CHECKED AS F6CHECKED,
                      CASE WHEN (KFS.KOD = '12' OR KFS.KOD = '41' OR (KFS.KOD = '43' AND VV5.KOD = '01')) THEN 1
                      WHEN (KFS.KOD = '13' OR KFS.KOD = '14' OR KFS.KOD = '42' OR (KFS.KOD = '43' AND (VV5.KOD = '02' OR VV5.KOD = '03'))) THEN 2
                      ELSE 3 END AS KFP_ID,
                      KRP.REGPL_ID
FROM         ORG O LEFT JOIN
                      KTERR ON O.TERR_ID = KTERR.TERR_ID LEFT JOIN
                      KFS ON O.FS_ID = KFS.FS_ID LEFT JOIN
                      KOPF ON O.KOPF_ID = KOPF.KOPF_ID LEFT JOIN
                      VV5 ON O.SBM_ID = VV5.ID LEFT JOIN
                      KONH ON O.KONH_ID = KONH.KONH_ID LEFT JOIN
                      FORM6HDR ON O.ORGID = FORM6HDR.ORGID LEFT JOIN
                      KREGPL KRP ON O.REGPL_ID=KRP.REGPL_ID

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE VIEW dbo.v_ORG_01
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



CREATE VIEW dbo.v_ORG_02
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



CREATE VIEW dbo.v_ORG_03
AS
SELECT *
FROM v_ORG
WHERE (F6_SHIFR = '03') AND (OUT_DATE IS NULL)

GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'Обновлены все запросы'
from VerInfo
where VerStr='3.6'
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


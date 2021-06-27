ALTER   VIEW [dbo].[v_ORG]
AS
SELECT     O.ORGID, O.TERR_ID, KTERR.NAME AS TERR, O.ORGNAME AS ORGNAME, O.OrgSName, O.URADDR, O.FIZADDR, O.POSTADDR, O.PHONE, O.OKPO, O.INN, O.OKBV,
                      O.FIRST_DATE, O.LAST_DATE, CAST(CASE WHEN FORM6HDR.F6_ID IS NULL THEN 0 ELSE 1 END AS bit) AS HAS_F6, O.SOOGU, O.PARENT,
                      O.MAINOKONH, O.OKONH, O.OCCUPATION,
                      O.FS_ID, KFS.KOD AS KFS_KOD, KFS.FS_NAME, KFS.KOD + ' - ' + KFS.FS_NAME AS KFS,
                      O.KOPF_ID, KOPF.KOD + ' - ' + KOPF.KOPF_NAME AS KOPF, O.KODREG, O.KODOKTMO, O.REGDATE, O.REGNUM,
                      KRP.REGPL_NAME AS REG_PLACE, O.COMMENT, O.OUT_REASON, O.OUT_DATE,
                      O.SBM_ID, VV5.KOD AS SBM_KOD, VV5.KOD + ' - ' + VV5.NAME AS SUBMISSION,
                      FORM6HDR.F6_ID, O.HAS_BRON, O.F6_SHIFR,
                      O.CHK_DATE AS CHK_DATE, FORM6HDR.RAB_COUNT, FORM6HDR.ZAP_COUNT, FORM6HDR.ZAB_COUNT, FORM6HDR.CHECKED AS F6CHECKED,
                      CASE WHEN (KFS.KOD = '12' OR KFS.KOD = '41' OR (KFS.KOD = '43' AND VV5.KOD = '01')) THEN 1
                      WHEN (KFS.KOD = '13' OR KFS.KOD = '14' OR KFS.KOD = '42' OR (KFS.KOD = '43' AND (VV5.KOD = '02' OR VV5.KOD = '03'))) THEN 2
                      ELSE 3 END AS KFP_ID,
                      KRP.REGPL_ID,
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
                      KREGPL KRP ON O.REGPL_ID = KRP.REGPL_ID LEFT JOIN
                      ORG_CONT HEAD ON O.ORGID = HEAD.ORGID and HEAD.IS_GEN = 1 LEFT JOIN
                      ORG_CONT VUR ON O.ORGID = VUR.ORGID and VUR.IS_VUS = 1

GO

Alter Table Org Alter Column Out_Reason varchar(160)
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
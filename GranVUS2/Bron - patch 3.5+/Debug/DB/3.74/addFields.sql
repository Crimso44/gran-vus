ALTER   VIEW dbo.v_ORG
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
                      O.OVK_ID,
		      HEAD.FAM AS HEADFAM, HEAD.PHONE AS HEADPHONE,
		      VUR.FAM AS VURFAM, VUR.PHONE AS VURPHONE
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

ALTER PROCEDURE CHECK_F6 AS

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
		         OR (CPROF_ID = 1000
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
                                       OR n_11<> 0
                                       OR n_12<> 0
                                       OR n_13<> 0
                                       OR n_14<> 0
                                       OR n_15<> 0))
                                   THEN 1 ELSE 0 END)
THEN 0 ELSE 1 END
GO
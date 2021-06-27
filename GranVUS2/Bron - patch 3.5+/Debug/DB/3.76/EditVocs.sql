--KOPF
create table KOPFOld (
        KOPF_ID int,
        KOPF_NAME varchar(150),
        KOD varchar(2)
)

insert KOPFOld
select * from KOPF

alter table ORG
drop constraint FK_ORG_KOPF

delete KOPF

alter table KOPF
alter column KOPF_NAME varchar(150)

SET IDENTITY_INSERT KOPF ON
insert KOPF (KOPF_ID, KOPF_NAME, KOD)
select 1,'ЮРИДИЧЕСКИЕ ЛИЦА, ЯВЛЯЮЩИЕСЯ КОММЕРЧЕСКИМИ ОРГАНИ3АЦИЯМИ',39
union
select 2,'Унитарные предприятия',40
union
select 3,'Унитарные предприятия, основанные на праве оперативного управления',41
union
select 4,'Унитарные предприятия, основанные на праве хозяйственного ведения',42
union
select 5,'ПРЕДПРИЯТИЯ ОБЩЕСТВЕННЫХ И РЕЛИГИОЗНЫХ ОРГАНИЗАЦИЙ',44
union
select 6,'ПРЕДПРИЯТИЯ ПОТРЕБИТЕЛЬСКОЙ КООПЕРАЦИИ',45
union
select 7,'ИНДИВИДУАЛЬНЫЕ (СЕМЕЙНЫЕ) ЧАСТНЫЕ ПРЕДПРИЯТИЯ (С ПРИВЛЕЧЕНИЕМ НАЕМНОГО ТРУДА)',46
union
select 8,'Открытые акционерные общества',47
union
select 9,'Хозяйственные товарищества и общества',48
union
select 10,'ТОВАРИЩЕСТВА С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ',49
union
select 11,'СМЕШАННЫЕ ТОВАРИЩЕСТВА',50
union
select 12,'Полные товарищества',51
union
select 13,'Производственные кооперативы',52
union
select 14,'Крестьянские (фермерские) хозяйства',53
union
select 15,'КОЛХОЗЫ',54
union
select 16,'СОВХОЗЫ',55
union
select 17,'МЕЖХОЗЯИСТВЕННЫЕ ПРЕДПРИЯТИЯ (ОРГАНИЗАЦИИ)',56
union
select 18,'АРЕНДНЫЕ ПРЕДПРИЯТИЯ',57
union
select 19,'Акционерные общества',60
union
select 20,'АРЕНДНЫЕ ПРЕДПРИЯТИЯ В ФОРМЕ АКЦИОНЕРНОГО ОБЩЕСТВА ЗАКРЫТОГО ТИПА, ТОРИЩЕСТВА С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ',61
union
select 21,'АРЕНДНЫЕ ПРЕДПРИЯТИЯ В ФОРМЕ СМЕШАННОГО ТОВАРИЩЕСТВА',62
union
select 22,'Товарищества на вере',64
union
select 23,'Общества с ограниченной ответственностью',65
union
select 24,'Общества с дополнительной ответственностью',66
union
select 25,'Закрытые акционерные общества',67
union
select 26,'ДОЧЕРНИЕ УНИТАРНЫЕ ПРЕДПРИЯТИЯ',68
union
select 27,'ДРУГИЕ ПРЕДПРИЯТИЯ',69
union
select 28,'ЮРИДИЧЕСКИЕ ЛИЦА. ЯВЛЯЮЩИЕСЯ НЕКОММЕРЧЕСКИМИ ОРГАНИЗАЦИЯМИ',70
union
select 29,'Частные учреждения',71
union
select 30,'Бюджетные учреждения',72
union
select 31,'Автономные учреждения',73
union
select 32,'ОБЪЕДИНЕНИЯ ПРЕДПРИЯТИЙ В ФОРМЕ АКЦИОНЕРНОГО ОБЩЕСТВА ЗАКРЫТОГО ТИПА, ТОВАРИЩЕСТВА С ОГРАНИЧЕНИЙ ОТВЕТСТВЕННОСТЬЮ',74
union
select 33,'ОБЪЕДИНЕНИЯ ПРЕДПРИЯТИЙ В ФОРМЕ СМЕШАННОГО ТОВАРИЩЕСТВА',75
union
select 34,'Садоводческие, огороднические или дачные некоммерческие товарищества',76
union
select 35,'Объединения крестьянских (фермерских) хозяйств',77
union
select 36,'Органы общественной самодеятельности',78
union
select 37,'Финансово-промышленные группы',79
union
select 38,'Территориальные общественные самоуправления',80
union
select 39,'Учреждения',81
union
select 40,'Государственные корпорации',82
union
select 41,'Общественные и религиозные организации (объединения)',83
union
select 42,'Общественные движения',84
union
select 43,'Потребительские кооперативы',85
union
select 44,'Простые товарищества',87
union
select 45,'Фонды',88
union
select 46,'Прочие некоммерческие организации',89
union
select 47,'Представительства и филиалы',90
union
select 48,'ИНДИВИДУАЛЬНЫЕ ПРЕДПРИНИМАТЕЛИ',91
union
select 49,'Паевые инвестиционные фонды',92
union
select 50,'Объединения юридических лиц (ассоциации и союзы)',93
union
select 51,'Товарищества собственников жилья',94
union
select 52,'Крестьянские (фермерские) хозяйства',95
union
select 53,'Некоммерческие партнерства',96
union
select 54,'Автономные некоммерческие организации',97
union
select 55,'Иные неюридические лица',98
union
select 56,'ОРГАНИЗАЦИИ БЕЗ ПРАВ ЮРИДИЧЕСКОГО ЛИЦА',99
SET IDENTITY_INSERT KOPF OFF

update ORG
set KOPF_ID = opf.KOPF_ID
from ORG o
join KOPFOld opfo on opfo.KOPF_ID = o.KOPF_ID
join KOPF opf on opf.KOD = opfo.KOD

alter table ORG
add constraint FK_ORG_KOPF foreign key (KOPF_ID) references KOPF

drop table KOPFOld
GO

update VV4
set [NAME] = 'Протокол КБГПЗ субъекта'
where ID = 3
GO

--VV3
create table VV3Old (
        ID int,
        KOD varchar(2),
        NAME varchar(50)
)

insert VV3Old
select * from VV3

alter table OSN
drop constraint FK_OSN_VV3

delete VV3

insert VV3 (ID, KOD, [NAME])
select 1,'01','Мобзадание Федеральных Органов'
union
select 2,'02','Мобзадание Субъекта РФ'
union
select 3,'03','Мобзадание органа самоуправления (района)'
union
select 4,'04','Мобзадание по кооперации'
union
select 5,'05','Наличие задач на военное время'
union
select 6,'06','Обеспечение жизнедеятельности населения'

update OSN
set BASE_ID = 1
where BASE_ID = 8

update OSN
set BASE_ID = 2
where BASE_ID = 9

update OSN
set BASE_ID = 3
where BASE_ID = 10

update OSN
set BASE_ID = 4
where BASE_ID = 11

update OSN
set BASE_ID = 6
where BASE_ID = 7

alter table OSN
add constraint FK_OSN_VV3 foreign key (BASE_ID) references VV3 (ID)

drop table VV3Old
GO

ALTER PROCEDURE CHECK_F6 AS

UPDATE form6hdr
   SET CHECKED = CASE WHEN F6_ID in(
                    SELECT f6.F6_ID
                      FROM FORM6 f6
                     WHERE
                           ISNULL(COL_1,0) <  ISNULL(COL_2,0)+ISNULL(COL_11,0)
                        OR ISNULL(COL_2,0) <> ISNULL(COL_3,0)+ISNULL(COL_4,0)
                        OR ISNULL(COL_2,0) <> ISNULL(COL_6,0)+ISNULL(COL_9,0)+ISNULL(COL_10,0)
                        OR ISNULL(COL_2,0) <  ISNULL(COL_9,0)+ISNULL(COL_10,0)
                        OR ISNULL(COL_3,0) <  ISNULL(COL_7,0)
                        OR ISNULL(COL_4,0) <  ISNULL(COL_8,0)
                        OR ISNULL(COL_4,0) <  ISNULL(COL_5,0)
                        OR ISNULL(COL_6,0) <> ISNULL(COL_7,0)+ISNULL(COL_8,0)
                        OR ISNULL(COL_9,0)  > ISNULL(COL_2,0)+ISNULL(COL_6,0)
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
                                                  WHEN 200 THEN '210+221+231+241+251+271+281+291+295'
                                                  WHEN 495 THEN '1000'
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
                         OR (CPROF_ID in (400, 1000, 2000)
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

if not exists (select * from syscolumns where name = 'SHORTNAME' and object_name(id)='KTERR')
ALTER TABLE KTERR
ADD SHORTNAME VARCHAR(150) NULL
GO

UPDATE KTERR
SET SHORTNAME = NAME
GO

SET IDENTITY_INSERT KL_FLD ON

INSERT INTO KL_FLD (FLD_ID,KL_ID,FLD_NAME,DISP_NAME,DISP_SIZE,IS_KEY,IS_EDIT,VISIBLE,DEF_VALUE,HAS_NULL)
Select 32,3,'SHORTNAME','Краткое наименование',300,0,1,1,null,0
where not exists (select * from KL_FLD where KL_ID = 3 and FLD_NAME = 'SHORTNAME')

SET IDENTITY_INSERT KL_FLD OFF
GO




INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Государственная корпорация по содействию разработке, производству и экспорту высокотехнологичной промышленной продукции "Ростехнологии"',
        N'41165000000',
        0,
        N'ГК "Ростехнологии"' where not exists (select * from KTERR where kodterr =
        N'41165000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'ФГУП -Рособоронэкспортv',
        N'13161000000',
        0,
        N'ФГУП -Рособоронэкспортv' where not exists (select * from KTERR where kodterr =
        N'13161000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральная служба по финансовым рынкам',
        N'13374000000',
        0,
        N'ФСФР России' where not exists (select * from KTERR where kodterr =
        N'13374000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Следственный комитет при прокуратуре Российской Федерации',
        N'44444000000',
        0,
        N'Следственный комитет при прокуратуре Российской Федерации' where not exists (select * from KTERR where kodterr =
        N'44444000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Торгово-промышленная палата РФ',
        N'55555000000',
        0,
        N'Торгово-промышленная палата РФ' where not exists (select * from KTERR where kodterr =
        N'55555000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Администрация Президента Российской Федерации',
        N'11002000000',
        0,
        N'Администрация Президента РФ' where not exists (select * from KTERR where kodterr =
        N'11002000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Всероссийское общество слепых',
        N'11111000000',
        0,
        N'Всероссийское общество слепых' where not exists (select * from KTERR where kodterr =
        N'11111000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство внутренних дел Российской Федерации',
        N'13110000000',
        0,
        N'МВД России' where not exists (select * from KTERR where kodterr =
        N'13110000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство Российской Федерации по делам гражданской обороны, чрезвычайным ситуациям и ликвидации последствий стихийных бедствий',
        N'13130000000',
        0,
        N'МЧС России' where not exists (select * from KTERR where kodterr =
        N'13130000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство иностранных дел Российской Федерации',
        N'13140000000',
        0,
        N'МИД России' where not exists (select * from KTERR where kodterr =
        N'13140000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральная служба по техническому и экспортному контролю',
        N'13164000000',
        0,
        N'ФСТЭК России' where not exists (select * from KTERR where kodterr =
        N'13164000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральное агентство специального строительства',
        N'13165000000',
        0,
        N'Спецстрой России' where not exists (select * from KTERR where kodterr =
        N'13165000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство юстиции Российской Федерации',
        N'13170000000',
        0,
        N'Минюст России' where not exists (select * from KTERR where kodterr =
        N'13170000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Государственная фельдъегерская служба Российской Федерации (федеральная служба)',
        N'13191000000',
        0,
        N'ГФС России' where not exists (select * from KTERR where kodterr =
        N'13191000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральная служба безопасности Российской Федерации (федеральная служба)',
        N'13194000000',
        0,
        N'ФСБ России' where not exists (select * from KTERR where kodterr =
        N'13194000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральная служба Российской Федерации по контролю за оборотом наркотиков (федеральная служба)',
        N'13195000000',
        0,
        N'ФСКН России' where not exists (select * from KTERR where kodterr =
        N'13195000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральная служба охраны Российской Федерации (федеральная служба)',
        N'13196000000',
        0,
        N'ФСО России' where not exists (select * from KTERR where kodterr =
        N'13196000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Главное управление специальных программ Президента Российской Федерации (федеральное агентство)',
        N'13197000000',
        0,
        N'ГУСП' where not exists (select * from KTERR where kodterr =
        N'13197000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Управление делами Президента РФ',
        N'13198000000',
        0,
        N'Управление делами Президента РФ' where not exists (select * from KTERR where kodterr =
        N'13198000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство здравоохранения и социального развития Российской Федерации',
        N'13220000000',
        0,
        N'Минздравсоцразвития России' where not exists (select * from KTERR where kodterr =
        N'13220000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство культуры Российской Федерации',
        N'13230000000',
        0,
        N'Минкультуры России' where not exists (select * from KTERR where kodterr =
        N'13230000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство образования и науки Российской Федерации',
        N'13240000000',
        0,
        N'Минобрнауки России' where not exists (select * from KTERR where kodterr =
        N'13240000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство природных ресурсов и экологии Российской Федерации',
        N'13250000000',
        0,
        N'Минприроды России' where not exists (select * from KTERR where kodterr =
        N'13250000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство промышленности и торговли Российской Федерации',
        N'13260000000',
        0,
        N'Минпромторг России' where not exists (select * from KTERR where kodterr =
        N'13260000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство сельского хозяйства Российской Федерации',
        N'13270000000',
        0,
        N'Минсельхоз России' where not exists (select * from KTERR where kodterr =
        N'13270000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство транспорта Российской Федерации',
        N'13280000000',
        0,
        N'Минтранс России' where not exists (select * from KTERR where kodterr =
        N'13280000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство связи и массовых коммуникаций Российской Федерации',
        N'13290000000',
        0,
        N'Минкомсвязь России' where not exists (select * from KTERR where kodterr =
        N'13290000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство финансов Российской Федерации',
        N'13310000000',
        0,
        N'Минфин России' where not exists (select * from KTERR where kodterr =
        N'13310000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство экономического развития Российской Федерации',
        N'13320000000',
        0,
        N'Минэкономразвития России' where not exists (select * from KTERR where kodterr =
        N'13320000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство регионального развития Российской Федерации',
        N'13330000000',
        0,
        N'Минрегион России' where not exists (select * from KTERR where kodterr =
        N'13330000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство спорта, туризма и молодежной политики Российской Федерации',
        N'13340000000',
        0,
        N'Минспорттуризм России' where not exists (select * from KTERR where kodterr =
        N'13340000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Министерство энергетики Российской Федерации',
        N'13360000000',
        0,
        N'Минэнерго России' where not exists (select * from KTERR where kodterr =
        N'13360000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральная антимонопольная служба',
        N'13371000000',
        0,
        N'ФАС России' where not exists (select * from KTERR where kodterr =
        N'13371000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральная служба по тарифам',
        N'13372000000',
        0,
        N'ФСТ России' where not exists (select * from KTERR where kodterr =
        N'13372000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Государственная корпорация по атомной энергии -Росатомv',
        N'13377000000',
        0,
        N'Государственная корпорация по атомной энергии -Росатомv' where not exists (select * from KTERR where kodterr =
        N'13377000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральное космическое агентство',
        N'13378000000',
        0,
        N'Роскосмос' where not exists (select * from KTERR where kodterr =
        N'13378000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральное агентство поѓобустройству государственной границы Российской Федерации0',
        N'13382000000',
        0,
        N'Росграница' where not exists (select * from KTERR where kodterr =
        N'13382000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральное агентство по поставкам вооружения, военной, специальной техники и материальных средств',
        N'13383000000',
        0,
        N'Рособоронпоставка' where not exists (select * from KTERR where kodterr =
        N'13383000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральная таможенная служба',
        N'13386000000',
        0,
        N'ФТС России' where not exists (select * from KTERR where kodterr =
        N'13386000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральная служба по финансовому мониторингу',
        N'13388000000',
        0,
        N'Росфинмониторинг' where not exists (select * from KTERR where kodterr =
        N'13388000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральное агентство по рыболовству',
        N'13392000000',
        0,
        N'Росрыболовство' where not exists (select * from KTERR where kodterr =
        N'13392000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Федеральное государственное унитарное предприятие "Информационное телеграфное агентство России (ИТАР-ТАСС)"',
        N'13728000000',
        0,
        N'ИТАР ѓ ТАСС' where not exists (select * from KTERR where kodterr =
        N'13728000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Генеральная прокуратура РФ',
        N'14004000000',
        0,
        N'Генеральная прокуратура РФ' where not exists (select * from KTERR where kodterr =
        N'14004000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Верховный Суд Российской Федерации',
        N'14005000000',
        0,
        N'Судебный департамент при Верховном Суде Российской Федерации' where not exists (select * from KTERR where kodterr =
        N'14005000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Центральный банк России',
        N'15001000000',
        0,
        N'Центральный банк России' where not exists (select * from KTERR where kodterr =
        N'15001000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Банк ВТБ',
        N'15002000000',
        0,
        N'Банк ВТБ' where not exists (select * from KTERR where kodterr =
        N'15002000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Внешэкономбанк России',
        N'15003000000',
        0,
        N'Внешэкономбанк России' where not exists (select * from KTERR where kodterr =
        N'15003000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Сбербанк России',
        N'15007000000',
        0,
        N'Сбербанк России' where not exists (select * from KTERR where kodterr =
        N'15007000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Пенсионный фонд РФ',
        N'15013000000',
        0,
        N'Пенсионный фонд РФ' where not exists (select * from KTERR where kodterr =
        N'15013000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Российская академия наук',
        N'15065000000',
        0,
        N'Российская академия наук' where not exists (select * from KTERR where kodterr =
        N'15065000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Российская академия сельскохозяйственных наук',
        N'15070000000',
        0,
        N'Российская академия сельскохозяйственных наук' where not exists (select * from KTERR where kodterr =
        N'15070000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Российская академия медицинских наук',
        N'15075000000',
        0,
        N'Российская академия медицинских наук' where not exists (select * from KTERR where kodterr =
        N'15075000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'ГКО "Ассоциация "Росрыбхоз"',
        N'22222000000',
        0,
        N'ГКО "Ассоциация "Росрыбхоз"' where not exists (select * from KTERR where kodterr =
        N'22222000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Российская оборонная спортивно-техническая организация ',
        N'23410000000',
        0,
        N'РОСТО (ДОСААФ)' where not exists (select * from KTERR where kodterr =
        N'23410000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Росрыбколхозсоюз',
        N'33333000000',
        0,
        N'Росрыбколхозсоюз' where not exists (select * from KTERR where kodterr =
        N'33333000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'ОАО "Корпорация "Трансстрой"',
        N'41057000000',
        0,
        N'ОАО "Корпорация "Трансстрой"' where not exists (select * from KTERR where kodterr =
        N'41057000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Центральный союз потребительских обществ Российской Федерации',
        N'41058000000',
        0,
        N'Центросоюз России' where not exists (select * from KTERR where kodterr =
        N'41058000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'ОАО корпорация "Монтажспецстрой"',
        N'49013000000',
        0,
        N'ОАО корпорация "Монтажспецстрой"' where not exists (select * from KTERR where kodterr =
        N'49013000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Алтай',
        N'84000000000',
        1,
        N'Правительство Республики Алтай' where not exists (select * from KTERR where kodterr =
        N'84000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Алтайский край',
        N'01000000000',
        1,
        N'Администрация Алтайского края' where not exists (select * from KTERR where kodterr =
        N'01000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Краснодарский край',
        N'03000000000',
        1,
        N'Администрация Краснодарского края' where not exists (select * from KTERR where kodterr =
        N'03000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Красноярский край',
        N'04000000000',
        1,
        N'Совет администрация Красноярского края' where not exists (select * from KTERR where kodterr =
        N'04000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Приморский край',
        N'05000000000',
        1,
        N'Администрация Приморского края' where not exists (select * from KTERR where kodterr =
        N'05000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Ставропольский край',
        N'07000000000',
        1,
        N'Правительство Ставропольского края' where not exists (select * from KTERR where kodterr =
        N'07000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Хабаровский край',
        N'08000000000',
        1,
        N'Правительство Хабаровского края' where not exists (select * from KTERR where kodterr =
        N'08000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Амурская область',
        N'10000000000',
        1,
        N'Правительство Амурской обл.' where not exists (select * from KTERR where kodterr =
        N'10000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Архангельская область',
        N'11000000000',
        1,
        N'Администрация Архангельской обл.' where not exists (select * from KTERR where kodterr =
        N'11000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Ненецкий автономный округ',
        N'1300000000',
        1,
        N'Администрация Ненецкого автономного округа' where not exists (select * from KTERR where kodterr =
        N'1300000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Астраханская область',
        N'12000000000',
        1,
        N'Правительство Астраханской обл.' where not exists (select * from KTERR where kodterr =
        N'12000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Белгородская область',
        N'14000000000',
        1,
        N'Правительство Белгородской обл.' where not exists (select * from KTERR where kodterr =
        N'14000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Брянская область',
        N'15000000000',
        1,
        N'Администрация Брянской обл.' where not exists (select * from KTERR where kodterr =
        N'15000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Владимирская область',
        N'17000000000',
        1,
        N'Администрация Владимирской обл.' where not exists (select * from KTERR where kodterr =
        N'17000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Волгоградская область',
        N'18000000000',
        1,
        N'Администрация Волгоградской обл.' where not exists (select * from KTERR where kodterr =
        N'18000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Вологодская область',
        N'19000000000',
        1,
        N'Правительство Вологодской обл.' where not exists (select * from KTERR where kodterr =
        N'19000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Воронежская область',
        N'20000000000',
        1,
        N'Администрация Воронежской обл.' where not exists (select * from KTERR where kodterr =
        N'20000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Нижегородская область',
        N'22000000000',
        1,
        N'Правительство Нижегородской обл.' where not exists (select * from KTERR where kodterr =
        N'22000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Ивановская область',
        N'24000000000',
        1,
        N'Правительство Ивановской обл.' where not exists (select * from KTERR where kodterr =
        N'24000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Иркутская область',
        N'25000000000',
        1,
        N'Администрация Иркутской обл.' where not exists (select * from KTERR where kodterr =
        N'25000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Ингушетия',
        N'26000000000',
        1,
        N'Правительство Республики Ингушетия' where not exists (select * from KTERR where kodterr =
        N'26000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Калининградская область',
        N'27000000000',
        1,
        N'Правительство Калининградской обл.' where not exists (select * from KTERR where kodterr =
        N'27000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Тверская область',
        N'28000000000',
        1,
        N'Администрация Тверской обл.' where not exists (select * from KTERR where kodterr =
        N'28000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Калужская область',
        N'29000000000',
        1,
        N'Правительство Калужской обл.' where not exists (select * from KTERR where kodterr =
        N'29000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Камчатская область',
        N'30000000000',
        1,
        N'Правительство Камчатского края' where not exists (select * from KTERR where kodterr =
        N'30000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Кемеровская область',
        N'32000000000',
        1,
        N'Администрация Кемеровской обл.' where not exists (select * from KTERR where kodterr =
        N'32000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Кировская область',
        N'33000000000',
        1,
        N'Правительство Кировской обл.' where not exists (select * from KTERR where kodterr =
        N'33000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Костромская область',
        N'34000000000',
        1,
        N'Администрация Костромской обл.' where not exists (select * from KTERR where kodterr =
        N'34000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Самарская область',
        N'36000000000',
        1,
        N'Правительство Самарской обл.' where not exists (select * from KTERR where kodterr =
        N'36000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Курганская область',
        N'37000000000',
        1,
        N'Правительство Курганской обл.' where not exists (select * from KTERR where kodterr =
        N'37000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Курская область',
        N'38000000000',
        1,
        N'Администрация Курской обл.' where not exists (select * from KTERR where kodterr =
        N'38000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Город Санкт-Петербург город федерального значения',
        N'40000000000',
        1,
        N'Правительство Санкт-Петербурга' where not exists (select * from KTERR where kodterr =
        N'40000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Ленинградская область',
        N'41000000000',
        1,
        N'Правительство Ленинградской обл.' where not exists (select * from KTERR where kodterr =
        N'41000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Липецкая область',
        N'42000000000',
        1,
        N'Администрация Липецкой обл.' where not exists (select * from KTERR where kodterr =
        N'42000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Магаданская область',
        N'44000000000',
        1,
        N'Администрация Магаданской обл.' where not exists (select * from KTERR where kodterr =
        N'44000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Московская область',
        N'46000000000',
        1,
        N'Правительство Московской обл.' where not exists (select * from KTERR where kodterr =
        N'46000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Мурманская область',
        N'47000000000',
        1,
        N'Правительство Мурманской обл.' where not exists (select * from KTERR where kodterr =
        N'47000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Новгородская область',
        N'49000000000',
        1,
        N'Администрация Новгородской обл.' where not exists (select * from KTERR where kodterr =
        N'49000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Новосибирская область',
        N'50000000000',
        1,
        N'Администрация Новосибирской обл.' where not exists (select * from KTERR where kodterr =
        N'50000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Омская область',
        N'52000000000',
        1,
        N'Правительство Омской обл.' where not exists (select * from KTERR where kodterr =
        N'52000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Оренбургская область',
        N'53000000000',
        1,
        N'Правительство Оренбургской обл.' where not exists (select * from KTERR where kodterr =
        N'53000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Орловская область',
        N'54000000000',
        1,
        N'Администрация Орловской обл.' where not exists (select * from KTERR where kodterr =
        N'54000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Пензенская область',
        N'56000000000',
        1,
        N'Правительство Пензенской обл.' where not exists (select * from KTERR where kodterr =
        N'56000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Пермская область',
        N'57000000000',
        1,
        N'Правительство Пермского края' where not exists (select * from KTERR where kodterr =
        N'57000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Псковская область',
        N'58000000000',
        1,
        N'Администрация Псковской обл.' where not exists (select * from KTERR where kodterr =
        N'58000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Ростовская область',
        N'60000000000',
        1,
        N'Администрация Ростовской обл.' where not exists (select * from KTERR where kodterr =
        N'60000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Рязанская область',
        N'61000000000',
        1,
        N'Правительство Рязанской обл.' where not exists (select * from KTERR where kodterr =
        N'61000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Саратовская область',
        N'63000000000',
        1,
        N'Правительство Саратовской обл.' where not exists (select * from KTERR where kodterr =
        N'63000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Сахалинская область',
        N'64000000000',
        1,
        N'Администрация Сахалинской обл.' where not exists (select * from KTERR where kodterr =
        N'64000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Свердловская область',
        N'65000000000',
        1,
        N'Правительство Свердловской обл.' where not exists (select * from KTERR where kodterr =
        N'65000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Смоленская область',
        N'66000000000',
        1,
        N'Администрация Смоленской обл.' where not exists (select * from KTERR where kodterr =
        N'66000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Тамбовская область',
        N'68000000000',
        1,
        N'Администрация Тамбовской обл.' where not exists (select * from KTERR where kodterr =
        N'68000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Томская область',
        N'69000000000',
        1,
        N'Администрация Томской обл.' where not exists (select * from KTERR where kodterr =
        N'69000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Тульская область',
        N'70000000000',
        1,
        N'Администрация Тульской обл.' where not exists (select * from KTERR where kodterr =
        N'70000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Тюменская область',
        N'71000000000',
        1,
        N'Правительство Тюменской обл.' where not exists (select * from KTERR where kodterr =
        N'71000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Ханты ѓѓМансийский автономный округ -ѓЮгра',
        N'72000000000',
        1,
        N'Правительство Ханты-Мансийского автономного округа - Югры' where not exists (select * from KTERR where kodterr =
        N'72000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Ямало-Ненецкий автономный округ',
        N'74000000000',
        1,
        N'Администрация Ямало-Ненецкого автономного округа ' where not exists (select * from KTERR where kodterr =
        N'74000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Ульяновская область',
        N'73000000000',
        1,
        N'Правительство Ульяновской обл.' where not exists (select * from KTERR where kodterr =
        N'73000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Челябинская область',
        N'75000000000',
        1,
        N'Правительство Челябинской обл.' where not exists (select * from KTERR where kodterr =
        N'75000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Забайкальский край ',
        N'76000000000',
        1,
        N'Правительство Забайкальского края' where not exists (select * from KTERR where kodterr =
        N'76000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Чукотский автономный округ',
        N'77000000000',
        1,
        N'Правительство Чукотского автономного округа ' where not exists (select * from KTERR where kodterr =
        N'77000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Ярославская область',
        N'78000000000',
        1,
        N'Правительство Ярославской обл.' where not exists (select * from KTERR where kodterr =
        N'78000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Адыгея (Адыгея)',
        N'79000000000',
        1,
        N'Кабинет Министров Республики Адыгея' where not exists (select * from KTERR where kodterr =
        N'79000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Башкортостан',
        N'80000000000',
        1,
        N'Правительство Республики Башкортостан' where not exists (select * from KTERR where kodterr =
        N'80000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Бурятия',
        N'81000000000',
        1,
        N'Правительство Республики Бурятия' where not exists (select * from KTERR where kodterr =
        N'81000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Дагестан',
        N'82000000000',
        1,
        N'Правительство Республики Дагестан' where not exists (select * from KTERR where kodterr =
        N'82000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Кабардино-Балкарская Республика',
        N'83000000000',
        1,
        N'Правительство Кабардино-Балкарской Республики' where not exists (select * from KTERR where kodterr =
        N'83000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Калмыкия',
        N'85000000000',
        1,
        N'Правительство Республики Калмыкия' where not exists (select * from KTERR where kodterr =
        N'85000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Карелия',
        N'86000000000',
        1,
        N'Правительство Республики Карелия' where not exists (select * from KTERR where kodterr =
        N'86000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Коми',
        N'87000000000',
        1,
        N'Правительство Республики Коми' where not exists (select * from KTERR where kodterr =
        N'87000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Марий Эл',
        N'88000000000',
        1,
        N'Правительство Республики Марий Эл' where not exists (select * from KTERR where kodterr =
        N'88000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Мордовия',
        N'89000000000',
        1,
        N'Правительство Республики Мордовия' where not exists (select * from KTERR where kodterr =
        N'89000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Северная Осетия-Алания',
        N'90000000000',
        1,
        N'Правительство Республики Северная Осетия-Алания' where not exists (select * from KTERR where kodterr =
        N'90000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Карачаево-Черкесская Республика',
        N'91000000000',
        1,
        N'Правительство Карачаево-Черкесской Республики' where not exists (select * from KTERR where kodterr =
        N'91000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Татарстан (Татарстан)',
        N'92000000000',
        1,
        N'Кабинет Министров Республики Татарстан' where not exists (select * from KTERR where kodterr =
        N'92000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Тыва',
        N'93000000000',
        1,
        N'Правительство Республики Тыва' where not exists (select * from KTERR where kodterr =
        N'93000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Удмуртская Республика',
        N'94000000000',
        1,
        N'Правительство Удмуртской Республики' where not exists (select * from KTERR where kodterr =
        N'94000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Хакасия',
        N'95000000000',
        1,
        N'Правительство Республики Хакасия' where not exists (select * from KTERR where kodterr =
        N'95000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Чеченская республика',
        N'96000000000',
        1,
        N'Правительство Чеченской Республики' where not exists (select * from KTERR where kodterr =
        N'96000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Чувашская Республика - Чувашия',
        N'97000000000',
        1,
        N'Кабинет Министров Чувашской Республики-Чувашия' where not exists (select * from KTERR where kodterr =
        N'97000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Республика Саха (Якутия)',
        N'98000000000',
        1,
        N'Правительство Республики Саха (Якутия)' where not exists (select * from KTERR where kodterr =
        N'98000000000')
INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'Еврейская автономная область',
        N'99000000000',
        1,
        N'Правительство Еврейской авт. обл.' where not exists (select * from KTERR where kodterr =
        N'99000000000')


go

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'исправлен сквозной контроль ф.6 организаций'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'импорт из ВУРа поддерживает номера перечней и разделов из выписки из ПДП'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'из таблицы с перечнями убраны столбцы: документ, номер, дата для назначения перечня'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'исправлено содержимое словарей: ОКОПФ, основания для бронирования, документы'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице KOPF поле KOPF_NAME увеличено до 150-ти символов'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'изменена система лицензирования'
from VerInfo
where VerStr='3.75'
GO
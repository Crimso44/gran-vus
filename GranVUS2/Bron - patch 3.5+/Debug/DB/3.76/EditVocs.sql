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
select 1,'����������� ����, ���������� ������������� ������3������',39
union
select 2,'��������� �����������',40
union
select 3,'��������� �����������, ���������� �� ����� ������������ ����������',41
union
select 4,'��������� �����������, ���������� �� ����� �������������� �������',42
union
select 5,'����������� ������������ � ����������� �����������',44
union
select 6,'����������� ��������������� ����������',45
union
select 7,'�������������� (��������) ������� ����������� (� ������������ �������� �����)',46
union
select 8,'�������� ����������� ��������',47
union
select 9,'������������� ������������ � ��������',48
union
select 10,'������������ � ������������ ����������������',49
union
select 11,'��������� ������������',50
union
select 12,'������ ������������',51
union
select 13,'���������������� �����������',52
union
select 14,'������������ (����������) ���������',53
union
select 15,'�������',54
union
select 16,'�������',55
union
select 17,'���������������� ����������� (�����������)',56
union
select 18,'�������� �����������',57
union
select 19,'����������� ��������',60
union
select 20,'�������� ����������� � ����� ������������ �������� ��������� ����, ���������� � ������������ ����������������',61
union
select 21,'�������� ����������� � ����� ���������� ������������',62
union
select 22,'������������ �� ����',64
union
select 23,'�������� � ������������ ����������������',65
union
select 24,'�������� � �������������� ����������������',66
union
select 25,'�������� ����������� ��������',67
union
select 26,'�������� ��������� �����������',68
union
select 27,'������ �����������',69
union
select 28,'����������� ����. ���������� ��������������� �������������',70
union
select 29,'������� ����������',71
union
select 30,'��������� ����������',72
union
select 31,'���������� ����������',73
union
select 32,'����������� ����������� � ����� ������������ �������� ��������� ����, ������������ � ����������� ����������������',74
union
select 33,'����������� ����������� � ����� ���������� ������������',75
union
select 34,'�������������, �������������� ��� ������ �������������� ������������',76
union
select 35,'����������� ������������ (����������) ��������',77
union
select 36,'������ ������������ ����������������',78
union
select 37,'���������-������������ ������',79
union
select 38,'��������������� ������������ ��������������',80
union
select 39,'����������',81
union
select 40,'��������������� ����������',82
union
select 41,'������������ � ����������� ����������� (�����������)',83
union
select 42,'������������ ��������',84
union
select 43,'��������������� �����������',85
union
select 44,'������� ������������',87
union
select 45,'�����',88
union
select 46,'������ �������������� �����������',89
union
select 47,'����������������� � �������',90
union
select 48,'�������������� ���������������',91
union
select 49,'������ �������������� �����',92
union
select 50,'����������� ����������� ��� (���������� � �����)',93
union
select 51,'������������ ������������� �����',94
union
select 52,'������������ (����������) ���������',95
union
select 53,'�������������� �����������',96
union
select 54,'���������� �������������� �����������',97
union
select 55,'���� ������������� ����',98
union
select 56,'����������� ��� ���� ������������ ����',99
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
set [NAME] = '�������� ����� ��������'
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
select 1,'01','���������� ����������� �������'
union
select 2,'02','���������� �������� ��'
union
select 3,'03','���������� ������ �������������� (������)'
union
select 4,'04','���������� �� ����������'
union
select 5,'05','������� ����� �� ������� �����'
union
select 6,'06','����������� ����������������� ���������'

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
Select 32,3,'SHORTNAME','������� ������������',300,0,1,1,null,0
where not exists (select * from KL_FLD where KL_ID = 3 and FLD_NAME = 'SHORTNAME')

SET IDENTITY_INSERT KL_FLD OFF
GO




INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������������� ���������� �� ���������� ����������, ������������ � �������� ������������������� ������������ ��������� "�������������"',
        N'41165000000',
        0,
        N'�� "�������������"' where not exists (select * from KTERR where kodterr =
        N'41165000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���� -����������������v',
        N'13161000000',
        0,
        N'���� -����������������v' where not exists (select * from KTERR where kodterr =
        N'13161000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ������ �� ���������� ������',
        N'13374000000',
        0,
        N'���� ������' where not exists (select * from KTERR where kodterr =
        N'13374000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ������� ��� ����������� ���������� ���������',
        N'44444000000',
        0,
        N'������������ ������� ��� ����������� ���������� ���������' where not exists (select * from KTERR where kodterr =
        N'44444000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������-������������ ������ ��',
        N'55555000000',
        0,
        N'�������-������������ ������ ��' where not exists (select * from KTERR where kodterr =
        N'55555000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������� ���������� ���������� ���������',
        N'11002000000',
        0,
        N'������������� ���������� ��' where not exists (select * from KTERR where kodterr =
        N'11002000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������� �������� ������',
        N'11111000000',
        0,
        N'������������� �������� ������' where not exists (select * from KTERR where kodterr =
        N'11111000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ���������� ��� ���������� ���������',
        N'13110000000',
        0,
        N'��� ������' where not exists (select * from KTERR where kodterr =
        N'13110000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ���������� ��������� �� ����� ����������� �������, ������������ ��������� � ���������� ����������� ��������� ��������',
        N'13130000000',
        0,
        N'��� ������' where not exists (select * from KTERR where kodterr =
        N'13130000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ����������� ��� ���������� ���������',
        N'13140000000',
        0,
        N'��� ������' where not exists (select * from KTERR where kodterr =
        N'13140000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ������ �� ������������ � ����������� ��������',
        N'13164000000',
        0,
        N'����� ������' where not exists (select * from KTERR where kodterr =
        N'13164000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ��������� ������������ �������������',
        N'13165000000',
        0,
        N'��������� ������' where not exists (select * from KTERR where kodterr =
        N'13165000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ������� ���������� ���������',
        N'13170000000',
        0,
        N'������ ������' where not exists (select * from KTERR where kodterr =
        N'13170000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������������� �������������� ������ ���������� ��������� (����������� ������)',
        N'13191000000',
        0,
        N'��� ������' where not exists (select * from KTERR where kodterr =
        N'13191000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ������ ������������ ���������� ��������� (����������� ������)',
        N'13194000000',
        0,
        N'��� ������' where not exists (select * from KTERR where kodterr =
        N'13194000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ������ ���������� ��������� �� �������� �� �������� ���������� (����������� ������)',
        N'13195000000',
        0,
        N'���� ������' where not exists (select * from KTERR where kodterr =
        N'13195000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ������ ������ ���������� ��������� (����������� ������)',
        N'13196000000',
        0,
        N'��� ������' where not exists (select * from KTERR where kodterr =
        N'13196000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������� ���������� ����������� �������� ���������� ���������� ��������� (����������� ���������)',
        N'13197000000',
        0,
        N'����' where not exists (select * from KTERR where kodterr =
        N'13197000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ������ ���������� ��',
        N'13198000000',
        0,
        N'���������� ������ ���������� ��' where not exists (select * from KTERR where kodterr =
        N'13198000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ��������������� � ����������� �������� ���������� ���������',
        N'13220000000',
        0,
        N'������������������� ������' where not exists (select * from KTERR where kodterr =
        N'13220000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������� ���������� ���������',
        N'13230000000',
        0,
        N'����������� ������' where not exists (select * from KTERR where kodterr =
        N'13230000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ����������� � ����� ���������� ���������',
        N'13240000000',
        0,
        N'����������� ������' where not exists (select * from KTERR where kodterr =
        N'13240000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ��������� �������� � �������� ���������� ���������',
        N'13250000000',
        0,
        N'���������� ������' where not exists (select * from KTERR where kodterr =
        N'13250000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������������� � �������� ���������� ���������',
        N'13260000000',
        0,
        N'����������� ������' where not exists (select * from KTERR where kodterr =
        N'13260000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ��������� ��������� ���������� ���������',
        N'13270000000',
        0,
        N'���������� ������' where not exists (select * from KTERR where kodterr =
        N'13270000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ���������� ���������� ���������',
        N'13280000000',
        0,
        N'�������� ������' where not exists (select * from KTERR where kodterr =
        N'13280000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ����� � �������� ������������ ���������� ���������',
        N'13290000000',
        0,
        N'����������� ������' where not exists (select * from KTERR where kodterr =
        N'13290000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������� ���������� ���������',
        N'13310000000',
        0,
        N'������ ������' where not exists (select * from KTERR where kodterr =
        N'13310000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������������� �������� ���������� ���������',
        N'13320000000',
        0,
        N'����������������� ������' where not exists (select * from KTERR where kodterr =
        N'13320000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ������������� �������� ���������� ���������',
        N'13330000000',
        0,
        N'��������� ������' where not exists (select * from KTERR where kodterr =
        N'13330000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ������, ������� � ���������� �������� ���������� ���������',
        N'13340000000',
        0,
        N'�������������� ������' where not exists (select * from KTERR where kodterr =
        N'13340000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ���������� ���������� ���������',
        N'13360000000',
        0,
        N'��������� ������' where not exists (select * from KTERR where kodterr =
        N'13360000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ��������������� ������',
        N'13371000000',
        0,
        N'��� ������' where not exists (select * from KTERR where kodterr =
        N'13371000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ������ �� �������',
        N'13372000000',
        0,
        N'��� ������' where not exists (select * from KTERR where kodterr =
        N'13372000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������������� ���������� �� ������� ������� -�������v',
        N'13377000000',
        0,
        N'��������������� ���������� �� ������� ������� -�������v' where not exists (select * from KTERR where kodterr =
        N'13377000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ����������� ���������',
        N'13378000000',
        0,
        N'���������' where not exists (select * from KTERR where kodterr =
        N'13378000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ��������� �������������� ��������������� ������� ���������� ���������0',
        N'13382000000',
        0,
        N'����������' where not exists (select * from KTERR where kodterr =
        N'13382000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ��������� �� ��������� ����������, �������, ����������� ������� � ������������ �������',
        N'13383000000',
        0,
        N'�����������������' where not exists (select * from KTERR where kodterr =
        N'13383000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ���������� ������',
        N'13386000000',
        0,
        N'��� ������' where not exists (select * from KTERR where kodterr =
        N'13386000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ������ �� ����������� �����������',
        N'13388000000',
        0,
        N'����������������' where not exists (select * from KTERR where kodterr =
        N'13388000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ��������� �� �����������',
        N'13392000000',
        0,
        N'��������������' where not exists (select * from KTERR where kodterr =
        N'13392000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ��������������� ��������� ����������� "�������������� ����������� ��������� ������ (����-����)"',
        N'13728000000',
        0,
        N'���� � ����' where not exists (select * from KTERR where kodterr =
        N'13728000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ����������� ��',
        N'14004000000',
        0,
        N'����������� ����������� ��' where not exists (select * from KTERR where kodterr =
        N'14004000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� ��� ���������� ���������',
        N'14005000000',
        0,
        N'�������� ����������� ��� ��������� ���� ���������� ���������' where not exists (select * from KTERR where kodterr =
        N'14005000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ���� ������',
        N'15001000000',
        0,
        N'����������� ���� ������' where not exists (select * from KTERR where kodterr =
        N'15001000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���� ���',
        N'15002000000',
        0,
        N'���� ���' where not exists (select * from KTERR where kodterr =
        N'15002000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������������� ������',
        N'15003000000',
        0,
        N'�������������� ������' where not exists (select * from KTERR where kodterr =
        N'15003000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������� ������',
        N'15007000000',
        0,
        N'�������� ������' where not exists (select * from KTERR where kodterr =
        N'15007000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ���� ��',
        N'15013000000',
        0,
        N'���������� ���� ��' where not exists (select * from KTERR where kodterr =
        N'15013000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������� ����',
        N'15065000000',
        0,
        N'���������� �������� ����' where not exists (select * from KTERR where kodterr =
        N'15065000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������� �������������������� ����',
        N'15070000000',
        0,
        N'���������� �������� �������������������� ����' where not exists (select * from KTERR where kodterr =
        N'15070000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������� ����������� ����',
        N'15075000000',
        0,
        N'���������� �������� ����������� ����' where not exists (select * from KTERR where kodterr =
        N'15075000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��� "���������� "���������"',
        N'22222000000',
        0,
        N'��� "���������� "���������"' where not exists (select * from KTERR where kodterr =
        N'22222000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ��������� ���������-����������� ����������� ',
        N'23410000000',
        0,
        N'����� (������)' where not exists (select * from KTERR where kodterr =
        N'23410000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������������',
        N'33333000000',
        0,
        N'����������������' where not exists (select * from KTERR where kodterr =
        N'33333000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��� "���������� "����������"',
        N'41057000000',
        0,
        N'��� "���������� "����������"' where not exists (select * from KTERR where kodterr =
        N'41057000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ���� ��������������� ������� ���������� ���������',
        N'41058000000',
        0,
        N'���������� ������' where not exists (select * from KTERR where kodterr =
        N'41058000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��� ���������� "���������������"',
        N'49013000000',
        0,
        N'��� ���������� "���������������"' where not exists (select * from KTERR where kodterr =
        N'49013000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �����',
        N'84000000000',
        1,
        N'������������� ���������� �����' where not exists (select * from KTERR where kodterr =
        N'84000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� ����',
        N'01000000000',
        1,
        N'������������� ���������� ����' where not exists (select * from KTERR where kodterr =
        N'01000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������� ����',
        N'03000000000',
        1,
        N'������������� �������������� ����' where not exists (select * from KTERR where kodterr =
        N'03000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ ����',
        N'04000000000',
        1,
        N'����� ������������� ������������� ����' where not exists (select * from KTERR where kodterr =
        N'04000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ����',
        N'05000000000',
        1,
        N'������������� ����������� ����' where not exists (select * from KTERR where kodterr =
        N'05000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������������� ����',
        N'07000000000',
        1,
        N'������������� ��������������� ����' where not exists (select * from KTERR where kodterr =
        N'07000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� ����',
        N'08000000000',
        1,
        N'������������� ������������ ����' where not exists (select * from KTERR where kodterr =
        N'08000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������� �������',
        N'10000000000',
        1,
        N'������������� �������� ���.' where not exists (select * from KTERR where kodterr =
        N'10000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������� �������',
        N'11000000000',
        1,
        N'������������� ������������� ���.' where not exists (select * from KTERR where kodterr =
        N'11000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������� ���������� �����',
        N'1300000000',
        1,
        N'������������� ��������� ����������� ������' where not exists (select * from KTERR where kodterr =
        N'1300000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������',
        N'12000000000',
        1,
        N'������������� ������������ ���.' where not exists (select * from KTERR where kodterr =
        N'12000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������',
        N'14000000000',
        1,
        N'������������� ������������ ���.' where not exists (select * from KTERR where kodterr =
        N'14000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������� �������',
        N'15000000000',
        1,
        N'������������� �������� ���.' where not exists (select * from KTERR where kodterr =
        N'15000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������',
        N'17000000000',
        1,
        N'������������� ������������ ���.' where not exists (select * from KTERR where kodterr =
        N'17000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������� �������',
        N'18000000000',
        1,
        N'������������� ������������� ���.' where not exists (select * from KTERR where kodterr =
        N'18000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'19000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'19000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'20000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'20000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������� �������',
        N'22000000000',
        1,
        N'������������� ������������� ���.' where not exists (select * from KTERR where kodterr =
        N'22000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'24000000000',
        1,
        N'������������� ���������� ���.' where not exists (select * from KTERR where kodterr =
        N'24000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� �������',
        N'25000000000',
        1,
        N'������������� ��������� ���.' where not exists (select * from KTERR where kodterr =
        N'25000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ���������',
        N'26000000000',
        1,
        N'������������� ���������� ���������' where not exists (select * from KTERR where kodterr =
        N'26000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������������� �������',
        N'27000000000',
        1,
        N'������������� ��������������� ���.' where not exists (select * from KTERR where kodterr =
        N'27000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������� �������',
        N'28000000000',
        1,
        N'������������� �������� ���.' where not exists (select * from KTERR where kodterr =
        N'28000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� �������',
        N'29000000000',
        1,
        N'������������� ��������� ���.' where not exists (select * from KTERR where kodterr =
        N'29000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'30000000000',
        1,
        N'������������� ����������� ����' where not exists (select * from KTERR where kodterr =
        N'30000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'32000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'32000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� �������',
        N'33000000000',
        1,
        N'������������� ��������� ���.' where not exists (select * from KTERR where kodterr =
        N'33000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'34000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'34000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� �������',
        N'36000000000',
        1,
        N'������������� ��������� ���.' where not exists (select * from KTERR where kodterr =
        N'36000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'37000000000',
        1,
        N'������������� ���������� ���.' where not exists (select * from KTERR where kodterr =
        N'37000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������� �������',
        N'38000000000',
        1,
        N'������������� ������� ���.' where not exists (select * from KTERR where kodterr =
        N'38000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����� �����-��������� ����� ������������ ��������',
        N'40000000000',
        1,
        N'������������� �����-����������' where not exists (select * from KTERR where kodterr =
        N'40000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������� �������',
        N'41000000000',
        1,
        N'������������� ������������� ���.' where not exists (select * from KTERR where kodterr =
        N'41000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������� �������',
        N'42000000000',
        1,
        N'������������� �������� ���.' where not exists (select * from KTERR where kodterr =
        N'42000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'44000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'44000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'46000000000',
        1,
        N'������������� ���������� ���.' where not exists (select * from KTERR where kodterr =
        N'46000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'47000000000',
        1,
        N'������������� ���������� ���.' where not exists (select * from KTERR where kodterr =
        N'47000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������',
        N'49000000000',
        1,
        N'������������� ������������ ���.' where not exists (select * from KTERR where kodterr =
        N'49000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������� �������',
        N'50000000000',
        1,
        N'������������� ������������� ���.' where not exists (select * from KTERR where kodterr =
        N'50000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������ �������',
        N'52000000000',
        1,
        N'������������� ������ ���.' where not exists (select * from KTERR where kodterr =
        N'52000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������',
        N'53000000000',
        1,
        N'������������� ������������ ���.' where not exists (select * from KTERR where kodterr =
        N'53000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� �������',
        N'54000000000',
        1,
        N'������������� ��������� ���.' where not exists (select * from KTERR where kodterr =
        N'54000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'56000000000',
        1,
        N'������������� ���������� ���.' where not exists (select * from KTERR where kodterr =
        N'56000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������� �������',
        N'57000000000',
        1,
        N'������������� ��������� ����' where not exists (select * from KTERR where kodterr =
        N'57000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� �������',
        N'58000000000',
        1,
        N'������������� ��������� ���.' where not exists (select * from KTERR where kodterr =
        N'58000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'60000000000',
        1,
        N'������������� ���������� ���.' where not exists (select * from KTERR where kodterr =
        N'60000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� �������',
        N'61000000000',
        1,
        N'������������� ��������� ���.' where not exists (select * from KTERR where kodterr =
        N'61000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'63000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'63000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'64000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'64000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������ �������',
        N'65000000000',
        1,
        N'������������� ������������ ���.' where not exists (select * from KTERR where kodterr =
        N'65000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'66000000000',
        1,
        N'������������� ���������� ���.' where not exists (select * from KTERR where kodterr =
        N'66000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'68000000000',
        1,
        N'������������� ���������� ���.' where not exists (select * from KTERR where kodterr =
        N'68000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������� �������',
        N'69000000000',
        1,
        N'������������� ������� ���.' where not exists (select * from KTERR where kodterr =
        N'69000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�������� �������',
        N'70000000000',
        1,
        N'������������� �������� ���.' where not exists (select * from KTERR where kodterr =
        N'70000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� �������',
        N'71000000000',
        1,
        N'������������� ��������� ���.' where not exists (select * from KTERR where kodterr =
        N'71000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����� ������������ ���������� ����� -�����',
        N'72000000000',
        1,
        N'������������� �����-����������� ����������� ������ - ����' where not exists (select * from KTERR where kodterr =
        N'72000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'�����-�������� ���������� �����',
        N'74000000000',
        1,
        N'������������� �����-��������� ����������� ������ ' where not exists (select * from KTERR where kodterr =
        N'74000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'73000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'73000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'75000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'75000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'������������� ���� ',
        N'76000000000',
        1,
        N'������������� �������������� ����' where not exists (select * from KTERR where kodterr =
        N'76000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� ���������� �����',
        N'77000000000',
        1,
        N'������������� ���������� ����������� ������ ' where not exists (select * from KTERR where kodterr =
        N'77000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'����������� �������',
        N'78000000000',
        1,
        N'������������� ����������� ���.' where not exists (select * from KTERR where kodterr =
        N'78000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ������ (������)',
        N'79000000000',
        1,
        N'������� ��������� ���������� ������' where not exists (select * from KTERR where kodterr =
        N'79000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ������������',
        N'80000000000',
        1,
        N'������������� ���������� ������������' where not exists (select * from KTERR where kodterr =
        N'80000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'81000000000',
        1,
        N'������������� ���������� �������' where not exists (select * from KTERR where kodterr =
        N'81000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ��������',
        N'82000000000',
        1,
        N'������������� ���������� ��������' where not exists (select * from KTERR where kodterr =
        N'82000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������-���������� ����������',
        N'83000000000',
        1,
        N'������������� ���������-���������� ����������' where not exists (select * from KTERR where kodterr =
        N'83000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ��������',
        N'85000000000',
        1,
        N'������������� ���������� ��������' where not exists (select * from KTERR where kodterr =
        N'85000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'86000000000',
        1,
        N'������������� ���������� �������' where not exists (select * from KTERR where kodterr =
        N'86000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ����',
        N'87000000000',
        1,
        N'������������� ���������� ����' where not exists (select * from KTERR where kodterr =
        N'87000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ����� ��',
        N'88000000000',
        1,
        N'������������� ���������� ����� ��' where not exists (select * from KTERR where kodterr =
        N'88000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ��������',
        N'89000000000',
        1,
        N'������������� ���������� ��������' where not exists (select * from KTERR where kodterr =
        N'89000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������� ������-������',
        N'90000000000',
        1,
        N'������������� ���������� �������� ������-������' where not exists (select * from KTERR where kodterr =
        N'90000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������-���������� ����������',
        N'91000000000',
        1,
        N'������������� ���������-���������� ����������' where not exists (select * from KTERR where kodterr =
        N'91000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ��������� (���������)',
        N'92000000000',
        1,
        N'������� ��������� ���������� ���������' where not exists (select * from KTERR where kodterr =
        N'92000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ����',
        N'93000000000',
        1,
        N'������������� ���������� ����' where not exists (select * from KTERR where kodterr =
        N'93000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ����������',
        N'94000000000',
        1,
        N'������������� ���������� ����������' where not exists (select * from KTERR where kodterr =
        N'94000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� �������',
        N'95000000000',
        1,
        N'������������� ���������� �������' where not exists (select * from KTERR where kodterr =
        N'95000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� ����������',
        N'96000000000',
        1,
        N'������������� ��������� ����������' where not exists (select * from KTERR where kodterr =
        N'96000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� ���������� - �������',
        N'97000000000',
        1,
        N'������� ��������� ��������� ����������-�������' where not exists (select * from KTERR where kodterr =
        N'97000000000')

INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'���������� ���� (������)',
        N'98000000000',
        1,
        N'������������� ���������� ���� (������)' where not exists (select * from KTERR where kodterr =
        N'98000000000')
INSERT INTO KTERR (
        NAME,
        KODTERR,
        IS_OKATO,
        SHORTNAME)
select
        N'��������� ���������� �������',
        N'99000000000',
        1,
        N'������������� ��������� ���. ���.' where not exists (select * from KTERR where kodterr =
        N'99000000000')


go

insert into VerChanges(VerId,VerChgDesc)
select VerId, '��������� �������� �������� �.6 �����������'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '������ �� ���� ������������ ������ �������� � �������� �� ������� �� ���'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '�� ������� � ��������� ������ �������: ��������, �����, ���� ��� ���������� �������'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '���������� ���������� ��������: �����, ��������� ��� ������������, ���������'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '� ������� KOPF ���� KOPF_NAME ��������� �� 150-�� ��������'
from VerInfo
where VerStr='3.75'
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '�������� ������� ��������������'
from VerInfo
where VerStr='3.75'
GO
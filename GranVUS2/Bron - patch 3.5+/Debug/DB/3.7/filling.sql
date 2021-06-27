DELETE FROM KL_FLD
GO
DELETE FROM KL_DATA
GO
SET IDENTITY_INSERT KL_DATA ON
GO
INSERT INTO KL_DATA(KL_ID,KL_NAME,DISP_NAME,IS_EDIT,CHK_DEL)
      SELECT 1,'KCPROF','��������� ���������',0,NULL
UNION SELECT 2,'KOPF','��������������-�������� �����',1,NULL
UNION SELECT 3,'KTERR','������������� ��������� ���',1,NULL
UNION SELECT 4,'KFS','������������� ���� �������������',1,NULL
UNION SELECT 5,'VV5','������ ���������� � ������',0,NULL
UNION SELECT 6,'KREGPL','����� �����������',0,NULL
UNION SELECT 7,'KOKVED','��������� ������� ��� �����',0,NULL
GO
SET IDENTITY_INSERT KL_DATA OFF
GO
SET IDENTITY_INSERT KL_FLD ON
GO
INSERT INTO KL_FLD (FLD_ID,KL_ID,FLD_NAME,DISP_NAME,DISP_SIZE,IS_KEY,IS_EDIT,VISIBLE,DEF_VALUE,HAS_NULL)
      SELECT 1,1,'CPROF_ID','���',50,1,1,1,NULL,0
UNION SELECT 2,1,'CPROF_NAME','������������',200,0,1,1,NULL,0
UNION SELECT 3,1,'PRINT_NAME','������������ (��� ������)',200,0,1,1,NULL,0
UNION SELECT 4,1,'EXPRESSION','�������� ����������',200,0,1,1,NULL,1
UNION SELECT 5,2,'KOPF_ID','��� (�����.)',64,1,0,0,NULL,1
UNION SELECT 6,2,'KOPF_NAME','������������',397,0,1,1,NULL,0
UNION SELECT 7,2,'KOD','����',50,0,1,1,NULL,0
UNION SELECT 8,3,'TERR_ID','��� (�����.)',85,1,0,0,NULL,1
UNION SELECT 9,3,'NAME','������������',300,0,1,1,NULL,0
UNION SELECT 10,3,'KODTERR','���',376,0,1,1,'{KODTERR}',0
UNION SELECT 11,4,'FS_ID','��� (�����.)',59,1,0,0,NULL,1
UNION SELECT 12,4,'FS_NAME','������������',370,0,1,1,NULL,0
UNION SELECT 13,4,'KOD','����',100,0,1,1,NULL,0
UNION SELECT 14,5,'KOD','���',50,0,1,1,NULL,1
UNION SELECT 15,5,'NAME','������������',300,0,1,1,NULL,0
UNION SELECT 16,1,'STATE','��� ������',79,0,1,1,NULL,0
UNION SELECT 17,1,'LINE_NO','� ������ �/�',50,0,1,1,NULL,1
UNION SELECT 18,5,'ID','��� (�����.)',50,1,0,0,NULL,0
UNION SELECT 19,6,'REGPL_ID','��� (�����.)',50,1,0,0,NULL,1
UNION SELECT 20,6,'REGPL_NAME','������������',150,0,1,1,NULL,0
UNION SELECT 21,6,'REGPL_KOD','���',50,0,1,1,NULL,0
UNION SELECT 22,3,'IS_OKATO','����.',40,0,1,1,NULL,0
UNION SELECT 23,7,'OKVED_SECTION','������',30,1,0,1,NULL,0
UNION SELECT 24,7,'OKVED_SECTION_NAME','��������',250,0,0,1,NULL,0
UNION SELECT 25,7,'OKVED_BEGIN','������ ���������',50,0,0,1,NULL,0
UNION SELECT 26,7,'OKVED_END','����� ���������',50,0,0,1,NULL,0
UNION SELECT 27,4,'ForForm','��� �������� �� ���',136,0,1,1,NULL,0
GO
SET IDENTITY_INSERT KL_FLD OFF
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '���������� ���������� ������ KL_DATA � KL_FLD'
from VerInfo
where VerStr='3.7'
GO

DELETE FROM KOKVED
GO
INSERT INTO KOKVED (OKVED_SECTION,OKVED_SECTION_NAME,OKVED_BEGIN,OKVED_END)
      SELECT 'A','�������� ���������, ����� � ������ ���������.',1,2
UNION SELECT 'B','�����������, �����������.',5,5
UNION SELECT 'C','������ �������� ����������.',10,14
UNION SELECT 'D','�������������� ������������.',15,37
UNION SELECT 'E','������������ � ������������� ��������������, ���� � ����.',40,41
UNION SELECT 'F','�������������.',45,45
UNION SELECT 'G','�������� ����������������� ���������� � ����������� � �� ����������� ������������ � ������. ������� ��������. ��������� ��������. ������ ������� ������� � ��������� ������� �����������.',50,52
UNION SELECT 'H','��������� � ���������.',55,55
UNION SELECT 'I','��������� � �����.',60,64
UNION SELECT 'J','���������� ������������.',65,67
UNION SELECT 'K','�������� � ���������� ����������, ������ � �������������� �����.',70,74
UNION SELECT 'L','��������������� ���������� � ����������� ������� ������������; ������������ ���������� �����������.',75,75
UNION SELECT 'M','�����������.',80,80
UNION SELECT 'N','��������������� � �������������� ���������� �����.',85,85
UNION SELECT 'O','�������������� ������ ������������, ���������� � ������������ �����.',90,93
UNION SELECT 'P','�������������� ����� �� ������� ��������� ��������.',95,95
UNION SELECT 'Q','������������ ������������������ �����������.',99,99
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '��������� ������� KOKVED'
from VerInfo
where VerStr='3.7'
GO

DELETE FROM Users
GO
SET IDENTITY_INSERT Users ON
GO
INSERT INTO [Users]([ID], [Login], [Fam], [Im], [Otch], [Hash], [rAdmin], [rImport], [rExport], [rPrint], [rEdit], [rlogin])
VALUES(1,'ADMIN','�������������','�','�','0A6A266F990F4A29796AFFA2D105BBFD',1,1,1,1,1,1)
GO
SET IDENTITY_INSERT Users OFF
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '��������� ������� Users'
from VerInfo
where VerStr='3.7'
GO

UPDATE SUBJ_TYPE SET 
       TYPE_NAME=new.TYPE_NAME 
  FROM (SELECT TYPE_ID=1,TYPE_NAME='������/�������� ��������'
        UNION SELECT 2,'������/�������������� �����������'
        UNION SELECT 3,'�������� ���������/�������') new
 WHERE SUBJ_TYPE.TYPE_ID=new.TYPE_ID
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '���������� ���������� ������� SUBJ_TYPE'
from VerInfo
where VerStr='3.7'
GO

UPDATE VV5 SET 
       [NAME]=new.[NAME]
  FROM (SELECT ID=1,KOD='01',NAME='����������� ������ ���.������ (����)'
        UNION SELECT 2,'02','������ ���. ������ �������� (����)'
        UNION SELECT 3,'03','������ �������� �������������� (����)'
        UNION SELECT 4,'04','������ ������ (��������.)') new
 WHERE VV5.KOD=new.KOD
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, '���������� ���������� ������� VV5'
from VerInfo
where VerStr='3.7'
GO

UPDATE [KFS] SET [ForForm] = CASE WHEN KOD in ('12','13','14') THEN 1 ELSE 0 END
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, '� ������� KFS ����������� �������� ��� ���� ForForm'
from VerInfo
where VerStr='3.7'
GO

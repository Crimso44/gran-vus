alter table ORG alter column INN varchar(15) null
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, '� ������� ORG ��������� ���� INN �� 15-�� ��������'
from VerInfo
where VerStr='3.6'
GO
alter table ORG alter column MAINOKONH varchar(15) null
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, '� ������� ORG ��������� ���� MAINOKONH �� 15-�� ��������'
from VerInfo
where VerStr='3.6'
GO
alter table ORG add OKATO2 varchar(50) null
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, '� ������� ORG ��������� ���� OKATO2 varchar(50) NULL'
from VerInfo
where VerStr='3.6'
GO
alter table ORG add OKATO3 varchar(50) null
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, '� ������� ORG ��������� ���� OKATO3 varchar(50) NULL'
from VerInfo
where VerStr='3.6'
GO

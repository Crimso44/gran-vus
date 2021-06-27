alter table ORG alter column INN varchar(15) null
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, 'В таблице ORG расширено поле INN до 15-ти символов'
from VerInfo
where VerStr='3.6'
GO
alter table ORG alter column MAINOKONH varchar(15) null
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, 'В таблице ORG расширено поле MAINOKONH до 15-ти символов'
from VerInfo
where VerStr='3.6'
GO
alter table ORG add OKATO2 varchar(50) null
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, 'В таблице ORG добавлено поле OKATO2 varchar(50) NULL'
from VerInfo
where VerStr='3.6'
GO
alter table ORG add OKATO3 varchar(50) null
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, 'В таблице ORG добавлено поле OKATO3 varchar(50) NULL'
from VerInfo
where VerStr='3.6'
GO

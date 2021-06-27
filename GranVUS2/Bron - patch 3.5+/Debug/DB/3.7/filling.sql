DELETE FROM KL_FLD
GO
DELETE FROM KL_DATA
GO
SET IDENTITY_INSERT KL_DATA ON
GO
INSERT INTO KL_DATA(KL_ID,KL_NAME,DISP_NAME,IS_EDIT,CHK_DEL)
      SELECT 1,'KCPROF','Категории профессий',0,NULL
UNION SELECT 2,'KOPF','Организационно-правовые формы',1,NULL
UNION SELECT 3,'KTERR','Классификатор структуры ВУО',1,NULL
UNION SELECT 4,'KFS','Классификатор форм собственности',1,NULL
UNION SELECT 5,'VV5','Органы управления и власти',0,NULL
UNION SELECT 6,'KREGPL','Место регистрации',0,NULL
UNION SELECT 7,'KOKVED','Диапазоны классов для ОКВЭД',0,NULL
GO
SET IDENTITY_INSERT KL_DATA OFF
GO
SET IDENTITY_INSERT KL_FLD ON
GO
INSERT INTO KL_FLD (FLD_ID,KL_ID,FLD_NAME,DISP_NAME,DISP_SIZE,IS_KEY,IS_EDIT,VISIBLE,DEF_VALUE,HAS_NULL)
      SELECT 1,1,'CPROF_ID','Код',50,1,1,1,NULL,0
UNION SELECT 2,1,'CPROF_NAME','Наименование',200,0,1,1,NULL,0
UNION SELECT 3,1,'PRINT_NAME','Наименование (для печати)',200,0,1,1,NULL,0
UNION SELECT 4,1,'EXPRESSION','Формаула вычисления',200,0,1,1,NULL,1
UNION SELECT 5,2,'KOPF_ID','Код (внутр.)',64,1,0,0,NULL,1
UNION SELECT 6,2,'KOPF_NAME','Наименование',397,0,1,1,NULL,0
UNION SELECT 7,2,'KOD','КОПФ',50,0,1,1,NULL,0
UNION SELECT 8,3,'TERR_ID','Код (внутр.)',85,1,0,0,NULL,1
UNION SELECT 9,3,'NAME','Наименование',300,0,1,1,NULL,0
UNION SELECT 10,3,'KODTERR','Код',376,0,1,1,'{KODTERR}',0
UNION SELECT 11,4,'FS_ID','Код (внутр.)',59,1,0,0,NULL,1
UNION SELECT 12,4,'FS_NAME','Наименование',370,0,1,1,NULL,0
UNION SELECT 13,4,'KOD','ОКФС',100,0,1,1,NULL,0
UNION SELECT 14,5,'KOD','Код',50,0,1,1,NULL,1
UNION SELECT 15,5,'NAME','Наименование',300,0,1,1,NULL,0
UNION SELECT 16,1,'STATE','Тип строки',79,0,1,1,NULL,0
UNION SELECT 17,1,'LINE_NO','№ строки п/п',50,0,1,1,NULL,1
UNION SELECT 18,5,'ID','Код (внутр.)',50,1,0,0,NULL,0
UNION SELECT 19,6,'REGPL_ID','Код (внутр.)',50,1,0,0,NULL,1
UNION SELECT 20,6,'REGPL_NAME','Наименование',150,0,1,1,NULL,0
UNION SELECT 21,6,'REGPL_KOD','Код',50,0,1,1,NULL,0
UNION SELECT 22,3,'IS_OKATO','Терр.',40,0,1,1,NULL,0
UNION SELECT 23,7,'OKVED_SECTION','Раздел',30,1,0,1,NULL,0
UNION SELECT 24,7,'OKVED_SECTION_NAME','Описание',250,0,0,1,NULL,0
UNION SELECT 25,7,'OKVED_BEGIN','Начало диапазона',50,0,0,1,NULL,0
UNION SELECT 26,7,'OKVED_END','Конец диапазона',50,0,0,1,NULL,0
UNION SELECT 27,4,'ForForm','Для сведений по ВУО',136,0,1,1,NULL,0
GO
SET IDENTITY_INSERT KL_FLD OFF
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'изменилось содержимое таблиц KL_DATA и KL_FLD'
from VerInfo
where VerStr='3.7'
GO

DELETE FROM KOKVED
GO
INSERT INTO KOKVED (OKVED_SECTION,OKVED_SECTION_NAME,OKVED_BEGIN,OKVED_END)
      SELECT 'A','Сельское хозяйство, охота и лесное хозяйство.',1,2
UNION SELECT 'B','Рыболовство, рыбоводство.',5,5
UNION SELECT 'C','Добыча полезных ископаемых.',10,14
UNION SELECT 'D','Обрабатывающие производства.',15,37
UNION SELECT 'E','Производство и распределение электроэнергии, газа и воды.',40,41
UNION SELECT 'F','Строительство.',45,45
UNION SELECT 'G','Торговля автотранспортными средствами и мотоциклами и их техническое обслуживание и ремонт. Оптовая торговля. Розничная торговля. Ремонт бытовых изделий и предметов личного пользования.',50,52
UNION SELECT 'H','Гостиницы и рестораны.',55,55
UNION SELECT 'I','Транспорт и связь.',60,64
UNION SELECT 'J','Финансовая деятельность.',65,67
UNION SELECT 'K','Операции с недвижимым имуществом, аренда и предоставление услуг.',70,74
UNION SELECT 'L','Государственное управление и обеспечение военной безопасности; обязательное социальное обеспечение.',75,75
UNION SELECT 'M','Образование.',80,80
UNION SELECT 'N','Здравоохранение и предоставление социальных услуг.',85,85
UNION SELECT 'O','Предоставление прочих коммунальных, социальных и персональных услуг.',90,93
UNION SELECT 'P','Предоставление услуг по ведению домашнего хозяйтва.',95,95
UNION SELECT 'Q','Деятельность экстерриториальных организаций.',99,99
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'заполнена таблица KOKVED'
from VerInfo
where VerStr='3.7'
GO

DELETE FROM Users
GO
SET IDENTITY_INSERT Users ON
GO
INSERT INTO [Users]([ID], [Login], [Fam], [Im], [Otch], [Hash], [rAdmin], [rImport], [rExport], [rPrint], [rEdit], [rlogin])
VALUES(1,'ADMIN','Администратор','А','А','0A6A266F990F4A29796AFFA2D105BBFD',1,1,1,1,1,1)
GO
SET IDENTITY_INSERT Users OFF
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'заполнена таблица Users'
from VerInfo
where VerStr='3.7'
GO

UPDATE SUBJ_TYPE SET 
       TYPE_NAME=new.TYPE_NAME 
  FROM (SELECT TYPE_ID=1,TYPE_NAME='района/дочерней компании'
        UNION SELECT 2,'округа/хозяйственного объединения'
        UNION SELECT 3,'Субъекта Федерации/отрасли') new
 WHERE SUBJ_TYPE.TYPE_ID=new.TYPE_ID
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'изменилось содержимое таблицы SUBJ_TYPE'
from VerInfo
where VerStr='3.7'
GO

UPDATE VV5 SET 
       [NAME]=new.[NAME]
  FROM (SELECT ID=1,KOD='01',NAME='Федеральные органы гос.власти (ФОГВ)'
        UNION SELECT 2,'02','Органы исп. власти Субъекта (ОИВС)'
        UNION SELECT 3,'03','Органы местного самоуправления (ОМСУ)'
        UNION SELECT 4,'04','Другие органы (ведомств.)') new
 WHERE VV5.KOD=new.KOD
GO

insert into VerChanges(VerId,VerChgDesc)
select VerId, 'изменилось содержимое таблицы VV5'
from VerInfo
where VerStr='3.7'
GO

UPDATE [KFS] SET [ForForm] = CASE WHEN KOD in ('12','13','14') THEN 1 ELSE 0 END
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, 'в таблице KFS установлены значения для поля ForForm'
from VerInfo
where VerStr='3.7'
GO

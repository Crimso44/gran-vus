unit vur375;

interface

  function Patch375_GetInfo: string;
  function Patch375_GetStepCount: Integer;
  procedure Patch375_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs;

function Patch375_GetInfo: string;
begin
  Result :=
   'Версия 3.75:'#13+
   '  - Добавлен справочник "Отсрочки от призыва"'#13 +
   '  - В личную карточку работника:'#13 +
   '    на закладку "Воинский учет":'#13 +
   '      добавлены поля: "Отсрочка от призыва", "Дата предоставления отсрочки", "Дата окончания/переосвидетельствования"'#13 +
   '      добавлены поля: "Состояние здоровья", "Документ", "Дата документа"'#13 +
   '      закрыт выбор групп учета: "ФСБ", "МВД"'#13 +
   '    на закладку "Назначения":'#13 +
   '      добавлена таблица: "Присвоение квал. разряда, классного чина, дипломатического ранга, воинского звания"'#13 +
   '  - Обновлен справочник "Военкоматы и органы местного самоуправления"' + #13 +
   '  - Обновлен справочник "Воинские звания"' + #13 +
   '  - Обновлен справочник "ОКОПФ"' + #13 +
   '  - Добавлен справочник "ОКТМО"' + #13 +
   '  - В карточке организации:'#13 +
   '    в форме "Выписка из ПДП":'#13 +
   '      поле "Пункт" сделано буквенно-цифровым'#13 +
   '  - В табличные списки добавлено поле "№ п/п"'#13 +
   '  - В штатном расписании поле "Всего работающих" теперь не считает уволенных сотрудников'#13 +
   '  - В "Расчетные данные" добавлен пункт меню "Сведения об изменениях в учетных данных работников"'#13 +
   '  - Внесены изменения в печатные формы'#13 +
   '  - Добавлены параметры в фильтр списка личных карточек'#13 +
   '  - Обновлена система лицензирования'#13 +
   '  - Обновлен справочник "Военный состав (профиль)"';
end;

function Patch375_GetStepCount: Integer;
begin
  Result := 29;
end;

procedure Patch375_Process;
var Q: TADOQuery;
  procedure DoSQL(const ASQL: String; const NoCount: Boolean = False);
  begin
    with Q do
    try
      SQL.Text := ASQL;
      ExecSQL;
    except end;
    if not NoCount then fmMain.pbMain.StepIt;
  end;
  procedure AddField(const ATable, AField, AType: String);
  begin
    with Q do begin
      SQL.Text := 'select * from '+ATable+' where 1<>1';
      Open;
      if FindField(AField)=nil then begin
        Close;
        DoSQL('alter table '+ATable+' add column '+AField+' '+AType, True);
      end
      else
        Close;
    end;
    fmMain.pbMain.StepIt;
  end;
begin
  Q := TADOQuery.Create(fmMain);
  with Q do
  try
    Connection := fmMain.dbConn; ParamCheck := False;
    fmMain.lbProcState.Caption := 'создание таблиц...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//1
    DoSQL('Create table KDELAYTYPE (' +
          'ID INTEGER NOT NULL Primary Key,' +
          'DelayType varchar(255) NOT NULL' +
          ')');
//2
    DoSQL('Create table KDELAY (' +
          'ID INTEGER NOT NULL Primary Key,' +
          'DelayName varchar(255) NOT NULL,' +
          'DelayText text,' +
          'DelayType INTEGER NOT NULL,' +
          'Soldier bit,' +
          'Officer bit' +
          ')');
//3
    DoSQL('Create table Assign (' +
          'Assign_ID COUNTER NOT NULL Primary Key,' +
          'Pers_ID INTEGER NOT NULL,' +
          'Assign_Date datetime NOT NULL,' +
          'AssignText varchar(200),' +
          'AssignReason varchar(200)' +
          ')');
//4
    DoSQL('Create table KL_FLDGROUPS (' +
          'Group_ID INTEGER NOT NULL Primary Key,' +
          'Group_Name varchar(255) NOT NULL' +
          ')', True);
    DoSQL('INSERT INTO KL_FLDGROUPS (Group_ID, Group_Name)'#13 +
          'VALUES (1, ''Семейное положение'')', True);
    DoSQL('INSERT INTO KL_FLDGROUPS (Group_ID, Group_Name)'#13 +
          'VALUES (2, ''Первое образование'')', True);
    DoSQL('INSERT INTO KL_FLDGROUPS (Group_ID, Group_Name)'#13 +
          'VALUES (3, ''Второе образование'')', True);
    DoSQL('INSERT INTO KL_FLDGROUPS (Group_ID, Group_Name)'#13 +
          'VALUES (4, ''Послевузовское образование'')', True);
    DoSQL('INSERT INTO KL_FLDGROUPS (Group_ID, Group_Name)'#13 +
          'VALUES (5, ''Структурное подразделение'')', True);
    DoSQL('INSERT INTO KL_FLDGROUPS (Group_ID, Group_Name)'#13 +
          'VALUES (6, ''Должность'')', True);
    DoSQL('INSERT INTO KL_FLDGROUPS (Group_ID, Group_Name)'#13 +
          'VALUES (7, ''Место жительства'')', True);
    DoSQL('INSERT INTO KL_FLDGROUPS (Group_ID, Group_Name)'#13 +
          'VALUES (8, ''Место пребывания'')', True);
    DoSQL('INSERT INTO KL_FLDGROUPS (Group_ID, Group_Name)'#13 +
          'VALUES (9, ''Состояние здоровья'')');
//5
    DoSQL('Create table PersonChanges (' +
          'Change_ID COUNTER NOT NULL Primary Key,' +
          'Pers_ID INTEGER NOT NULL,' +
          'Group_ID INTEGER NOT NULL,' +
          'OldValue text,' +
          'NewValue text,' +
          'Change_Date datetime NOT NULL,' +
          'Begin_Date datetime,' +
          'NotBeginReason varchar(255),' +
          'End_Date datetime,' +
          'Send_Date datetime' +
          ')', True);

  DoSQL('Create table KOKTMO (' +
        'OKTMO_ID int not null primary key,' +
        'NAME varchar(150),' +
        'KODOKTMO varchar(20)' +
        ')', True);

  DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
        'VALUES (1, ''Муниципальные образования Архангельской области'', ''11'')', True);
  DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
        'VALUES (2, ''Муниципальные районы Архангельской области'', ''11600000'')', True);
  DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
        'VALUES (3, ''Вельский муниципальный район'', ''11605000'')', True);
  DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
        'VALUES (4, ''Городские поселения Вельского муниципального района'', ''11605100'')', True);
  DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
        'VALUES (5, ''- Вельское'', ''11605101'')', True);
  DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
        'VALUES (6, ''Сельские поселения Вельского муниципального района'', ''11605400'')', True);
  DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
        'VALUES (7, ''- Аргуновское'', ''11605402'')', True);
  DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
        'VALUES (8, ''- Благовещенское'', ''11605404'')');

    fmMain.lbProcState.Caption := 'обновление таблиц...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;

    AddField('ORG','KODOKTMO','VARCHAR(11) NULL');//28

    AddField('PERSON','Delay_ID','INTEGER NULL');//6
    AddField('PERSON','DelayStart_date','datetime NULL');//7
    AddField('PERSON','DelayEnd_date','datetime NULL');//8
    AddField('PERSON','Health','varchar(60) NULL');//9
    AddField('PERSON','HealthDocNo','varchar(60) NULL');//10
    AddField('PERSON','HealthDoc_date','datetime NULL');//11

    AddField('KOVK','ISOVK','bit');//12

    AddField('KWRANGE','ZAPSTATE','INTEGER NULL');//13
    AddField('KWRANGE','LIMIT1','INTEGER NULL');//14
    AddField('KWRANGE','LIMIT2','INTEGER NULL');//15
    AddField('KWRANGE','LIMIT3','INTEGER NULL');//16

    DoSQL('ALTER TABLE TPDP ALTER COLUMN PUNKT varchar(10) NULL');//17
    DoSQL('alter table ImportData alter column OuterID varchar(255) NOT NULL');//18
//19
    fmMain.lbProcState.Caption := 'Создание справочника "Отсрочки от призыва"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('INSERT INTO KDELAYTYPE (ID, DelayType)'#13 +
          'VALUES (1, ''по здоровью'')', True);
    DoSQL('INSERT INTO KDELAYTYPE (ID, DelayType)'#13 +
          'VALUES (2, ''по семейному положению'')', True);
    DoSQL('INSERT INTO KDELAYTYPE (ID, DelayType)'#13 +
          'VALUES (3, ''для получение образования'')', True);
    DoSQL('INSERT INTO KDELAYTYPE (ID, DelayType)'#13 +
          'VALUES (4, ''по специфике работы'')', True);

    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (1, ''По здоровью (временно)'', '#13 +
          '''временно не годным к военной службе по состоянию здоровья'', '#13 +
          '1, 1, 1)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (2, ''По уходу за родственниками'', '#13 +
          '''ухаживающим за родителями и близкими родственниками, если нуждаются в постоянном уходе, являются инвалидами первой или второй группы, достигли пенсионного возраста по старости'', '#13 +
          '2, 1, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (3, ''Наличие двух детей'', '#13 +
          '''мужчинам, имеющим 2 и более детей или одного ребенка-инвалида до 3 лет'', '#13 +
          '2, 0, 1)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (4, ''Опекунство н/л'', '#13 +
          '''являющихся опекунами или попечителями несовершеннолетнего родного брата или несовершеннолетней родной сестры при отсутствии других лиц, обязанных по закону содержать указанных граждан'', '#13 +
          '2, 0, 1)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (5, ''Воспитание ребенка без матери'', '#13 +
          '''воспитывающим ребенка без матери'', '#13 +
          '2, 1, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (6, ''Наличие ребенка и беременной жены'', '#13 +
          '''имеющим ребенка и жену, срок беременности которой составляет не менее 26 недель'', '#13 +
          '2, 0, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (7, ''Для получения общего образования'', '#13 +
          '''Обучающиеся по очной форме обучения в образовательных учреждениях основного общего и среднего (полного) общего образования'', '#13 +
          '3, 0, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (8, ''Для получения профессинального образования'', '#13 +
          '''в образовательных учреждениях начального профессионального, среднего профессионального и высшего профессионального образования'', '#13 +
          '3, 0, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (9, ''Для получения послевузовского образования'', '#13 +
          '''в государственных, муниципальных или имеющих государственную аккредитацию негосударственных образовательных учреждениях высшего ' +
          'профессионального образования и научных учреждениях, имеющих лицензии на ведение образовательной деятельности по образовательным программам послевузовского профессионального образования и получающие послевузовское профессиональное образование'', '#13 +
          '3, 0, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (10, ''По указу Президента'', '#13 +
          '''лицам, которым это право дано на основании указов Президента РФ (например, особо одаренным молодым ученым и наиболее талантливым представителям российского искусства - артистам балета, цирка, музыкантам-исполнителям и т.п.)'', '#13 +
          '4, 0, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (11, ''Как депутату или главе МО'', '#13 +
          '''депутатам Государственной Думы РФ, депутатам законодательных (представительных) органов государственной власти субъектов РФ, депутатам представительных органов муниципальных образований или главам муниципальных образований'', '#13 +
          '4, 0, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (12, ''Как кандидату на выборную должность'', '#13 +
          '''зарегистрированным в качестве кандидатов на замещаемые посредством прямых выборов должности или на членство в органах (палатах органов) государственной власти или органах местного самоуправления'', '#13 +
          '4, 0, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (13, ''Как работающему в организации из Перечня'', '#13 +
          '''выпускникам вузов, работающим по специальности в государственных организациях, перечень которых определяется Правительством РФ, на условиях полного рабочего дня'', '#13 +
          '4, 0, 0)', True);
    DoSQL('INSERT INTO KDELAY (ID, DelayName, DelayText, DelayType, Soldier, Officer)'#13 +
          'VALUES (14, ''Как проходящему службу в Органах'', '#13 +
          '''окончившим государственные, муниципальные или имеющие государственную аккредитацию негосударственные образовательные учреждения высшего профессионального образования и проходящим службу в органах внутренних дел, ' +
          'Государственной противопожарной службе, учреждениях и органах уголовно-исполнительной системы, органах по контролю за оборотом наркотических средств и психотропных веществ и таможенных органах РФ ' +
          'на должностях рядового (младшего) и начальствующего состава, а также обучающимся в образовательных учреждениях указанных органов или окончившим данные образовательные учреждения и получившим специальные звания'', '#13 +
          '4, 0, 0)', True);

    DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
          'VALUES (32, ''KDELAY'', ''Отсрочки от призыва'', 1, ' +
          '''SELECT COUNT(*) FROM PERSON WHERE DELAY_ID=:ID'')', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (114, 32, ''ID'', ''Код внутренний'', 99, 1, 0, 0, ' +
          '''{SQL:SELECT MAX(ID)+1 FROM KDELAY}{TXT:1}'', 0)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (115, 32, ''DelayName'', ''Отсрочка'', 200, 0, 1, 1, ' +
          'NULL, 0)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (116, 32, ''DelayType'', ''Вид отсрочки'', 150, 0, 1, 0, ' +
          '''{LU:SELECT ID, DelayType FROM KDELAYTYPE}'', 0)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (117, 32, ''Soldier'', ''Для младших чинов'', 100, 0, 1, 1, ' +
          'NULL, 0)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (118, 32, ''Officer'', ''Для офицеров'', 100, 0, 1, 1, ' +
          'NULL, 0)', True);
  DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
        'VALUES (33, ''KOKTMO'', ''Классификатор территорий муниципальных образований'', 1, ' +
        'null)', True);
  DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
        'DEF_VALUE, HAS_NULL) VALUES (124, 33, ''OKTMO_ID'', ''Код внутренний'', 99, 1, 0, 0, ' +
        '''{SQL:SELECT MAX(OKTMO_ID)+1 FROM KOKTMO}{TXT:1}'', 0)', True);
  DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
        'DEF_VALUE, HAS_NULL) VALUES (125, 33, ''NAME'', ''Наименование'', 300, 0, 1, 1, ' +
        'null, 0)', True);
  DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
        'DEF_VALUE, HAS_NULL) VALUES (126, 33, ''KODOKTMO'', ''Код'', 250, 0, 1, 1, ' +
        '''{KODOKTMO}'', 0)');
//20
    fmMain.lbProcState.Caption := 'обновление справочника "Военкоматы и органы местного самоуправления"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('UPDATE KL_DATA SET DISP_NAME = ''Военкоматы и органы местного самоуправления'' ' +
          'WHERE KL_ID = 1', True);
    DoSQL('UPDATE KOVK SET ISOVK = 1', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (119, 1, ''ISOVK'', ''ВК'', 50, 0, 1, 1, ' +
          'NULL, 0)');
//21
    fmMain.lbProcState.Caption := 'обновление справочника "Воинские звания"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('ALTER TABLE KL_FLD ALTER COLUMN DISP_NAME varchar(200)',True);
    DoSQL('UPDATE KWRANGE SET ZAPSTATE = 0 WHERE STATE = 0', True);
    DoSQL('UPDATE KWRANGE SET ZAPSTATE = 1, LIMIT1 = 35, LIMIT2 = 45, LIMIT3 = 50 WHERE STATE in (1,2)', True);
    DoSQL('UPDATE KWRANGE SET ZAPSTATE = 2, LIMIT1 = 45, LIMIT2 = 50, LIMIT3 = 55 WHERE M_LIMIT = 55', True);
    DoSQL('UPDATE KWRANGE SET ZAPSTATE = 3, LIMIT1 = 50, LIMIT2 = 55, LIMIT3 = 60 WHERE CHE in (13,14)', True);
    DoSQL('UPDATE KWRANGE SET ZAPSTATE = 3, LIMIT1 = 55, LIMIT2 = 60 WHERE CHE = 15', True);
    DoSQL('UPDATE KWRANGE SET ZAPSTATE = 4, LIMIT1 = 60, LIMIT2 = 65 WHERE CHE in (16,17,18,19)', True);
    DoSQL('UPDATE KL_FLD SET DISP_NAME = ''Наименование'' WHERE FLD_ID = 6', True);
    DoSQL('UPDATE KL_FLD SET DISP_NAME = ''Возраст снятия с воинского учета мужчин (определяется составом запаса)'' WHERE FLD_ID = 7', True);
    DoSQL('UPDATE KL_FLD SET DISP_NAME = ''Возраст снятия с воинского учета женщин (определяется составом запаса)'' WHERE FLD_ID = 8', True);
    DoSQL('UPDATE KL_FLD SET DISP_NAME = ''Категория звания: 0 - без звания, 1 - рядовые, 2 - унтерофицеры, 3 - офицеры'' WHERE FLD_ID = 27', True);
    DoSQL('UPDATE KL_FLD SET DISP_NAME = ''Категория запаса (только для  нижних чинов)'' WHERE FLD_ID = 45', True);
    DoSQL('UPDATE KL_FLD SET DISP_NAME = ''Допустимые значения годности к службе по здоровью'' WHERE FLD_ID = 46', True);
    DoSQL('UPDATE KL_FLD SET DISP_NAME = ''Уровень в иерархии воинских званий'' WHERE FLD_ID = 79', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (120, 3, ''ZAPSTATE'', ''Состав запаса: 1 - нижние чины; 2 - младшие офицеры; 3 - старшие офицеры; 4 - высшие офицеры'', 200, 0, 1, 1, ' +
          'NULL, 0)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (121, 3, ''LIMIT1'', ''предельный возраст для 1-го возрастного разряда (определяется составом запаса)'', 200, 0, 1, 1, ' +
          'NULL, 1)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (122, 3, ''LIMIT2'', ''предельный возраст для 2-го возрастного разряда (определяется составом запаса)'', 200, 0, 1, 1, ' +
          'NULL, 1)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (123, 3, ''LIMIT3'', ''предельный возраст для 3-го возрастного разряда (определяется составом запаса)'', 200, 0, 1, 1, ' +
          'NULL, 1)', True);
    DoSQL('UPDATE KWRANGE SET WRNG_NAME = ''подлежит призыву'' WHERE WRNG_ID = 1');
//22
    fmMain.lbProcState.Caption := 'обновление справочника "ОКОПФ"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('Create table KOPFOld (' +
      'KOPF_ID int,' +
      'KOPF_NAME varchar(100),' +
      'KOD varchar(2))', True);
    DoSQL('insert into KOPFOld select * from KOPF', True);
    DoSQL('delete from KOPF', True);
    DoSQL('alter table KOPF alter column KOPF_NAME varchar(150)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (1,''ЮРИДИЧЕСКИЕ ЛИЦА, ЯВЛЯЮЩИЕСЯ КОММЕРЧЕСКИМИ ОРГАНИ3АЦИЯМИ'',39)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (2,''Унитарные предприятия'',40)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (3,''Унитарные предприятия, основанные на праве оперативного управления'',41)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (4,''Унитарные предприятия, основанные на праве хозяйственного ведения'',42)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (5,''ПРЕДПРИЯТИЯ ОБЩЕСТВЕННЫХ И РЕЛИГИОЗНЫХ ОРГАНИЗАЦИЙ'',44)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (6,''ПРЕДПРИЯТИЯ ПОТРЕБИТЕЛЬСКОЙ КООПЕРАЦИИ'',45)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (7,''ИНДИВИДУАЛЬНЫЕ (СЕМЕЙНЫЕ) ЧАСТНЫЕ ПРЕДПРИЯТИЯ (С ПРИВЛЕЧЕНИЕМ НАЕМНОГО ТРУДА)'',46)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (8,''Открытые акционерные общества'',47)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (9,''Хозяйственные товарищества и общества'',48)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (10,''ТОВАРИЩЕСТВА С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ'',49)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (11,''СМЕШАННЫЕ ТОВАРИЩЕСТВА'',50)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (12,''Полные товарищества'',51)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (13,''Производственные кооперативы'',52)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (14,''Крестьянские (фермерские) хозяйства'',53)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (15,''КОЛХОЗЫ'',54)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (16,''СОВХОЗЫ'',55)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (17,''МЕЖХОЗЯИСТВЕННЫЕ ПРЕДПРИЯТИЯ (ОРГАНИЗАЦИИ)'',56)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (18,''АРЕНДНЫЕ ПРЕДПРИЯТИЯ'',57)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (19,''Акционерные общества'',60)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (20,''АРЕНДНЫЕ ПРЕДПРИЯТИЯ В ФОРМЕ АКЦИОНЕРНОГО ОБЩЕСТВА ЗАКРЫТОГО ТИПА, ТОРИЩЕСТВА С ОГРАНИЧЕННОЙ ОТВЕТСТВЕННОСТЬЮ'',61)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (21,''АРЕНДНЫЕ ПРЕДПРИЯТИЯ В ФОРМЕ СМЕШАННОГО ТОВАРИЩЕСТВА'',62)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (22,''Товарищества на вере'',64)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (23,''Общества с ограниченной ответственностью'',65)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (24,''Общества с дополнительной ответственностью'',66)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (25,''Закрытые акционерные общества'',67)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (26,''ДОЧЕРНИЕ УНИТАРНЫЕ ПРЕДПРИЯТИЯ'',68)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (27,''ДРУГИЕ ПРЕДПРИЯТИЯ'',69)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (28,''ЮРИДИЧЕСКИЕ ЛИЦА. ЯВЛЯЮЩИЕСЯ НЕКОММЕРЧЕСКИМИ ОРГАНИЗАЦИЯМИ'',70)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (29,''Частные учреждения'',71)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (30,''Бюджетные учреждения'',72)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (31,''Автономные учреждения'',73)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (32,''ОБЪЕДИНЕНИЯ ПРЕДПРИЯТИЙ В ФОРМЕ АКЦИОНЕРНОГО ОБЩЕСТВА ЗАКРЫТОГО ТИПА, ТОВАРИЩЕСТВА С ОГРАНИЧЕНИЙ ОТВЕТСТВЕННОСТЬЮ'',74)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (33,''ОБЪЕДИНЕНИЯ ПРЕДПРИЯТИЙ В ФОРМЕ СМЕШАННОГО ТОВАРИЩЕСТВА'',75)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (34,''Садоводческие, огороднические или дачные некоммерческие товарищества'',76)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (35,''Объединения крестьянских (фермерских) хозяйств'',77)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (36,''Органы общественной самодеятельности'',78)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (37,''Финансово-промышленные группы'',79)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (38,''Территориальные общественные самоуправления'',80)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (39,''Учреждения'',81)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (40,''Государственные корпорации'',82)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (41,''Общественные и религиозные организации (объединения)'',83)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (42,''Общественные движения'',84)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (43,''Потребительские кооперативы'',85)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (44,''Простые товарищества'',87)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (45,''Фонды'',88)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (46,''Прочие некоммерческие организации'',89)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (47,''Представительства и филиалы'',90)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (48,''ИНДИВИДУАЛЬНЫЕ ПРЕДПРИНИМАТЕЛИ'',91)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (49,''Паевые инвестиционные фонды'',92)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (50,''Объединения юридических лиц (ассоциации и союзы)'',93)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (51,''Товарищества собственников жилья'',94)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (52,''Крестьянские (фермерские) хозяйства'',95)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (53,''Некоммерческие партнерства'',96)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (54,''Автономные некоммерческие организации'',97)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (55,''Иные неюридические лица'',98)', True);
    DoSQL('insert into KOPF (KOPF_ID, KOPF_NAME, KOD)'#13 +
      'values (56,''ОРГАНИЗАЦИИ БЕЗ ПРАВ ЮРИДИЧЕСКОГО ЛИЦА'',99)', True);

    DoSQL('update (ORG o'#13 +
      'inner join KOPFOld opfo on opfo.KOPF_ID = o.KOPF_ID)'#13 +
      'inner join KOPF opf on opf.KOD = opfo.KOD'#13 +
      'set o.KOPF_ID = opf.KOPF_ID', True);

    DoSQL('drop table KOPFOld');
    fmMain.lbProcState.Caption := 'обновление запросов...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//23
    DoSQL('DROP view PersonreservChkInfoBase',True);
    DoSQL('CREATE VIEW PersonreservChkInfoBase AS '#13#10+
      'SELECT P.PERS_ID, P.IS_WAR, P.W_DEND, P.SpecialWUchet1, P.BIRTHDAY, P.Male, R.CHE, R.LIMIT1,'#13 +
      'IIf(ISNULL(P.WUCHET2),0,1) AS Reserved, IIf(AppointmentLast.WTP_ID=1,1,0) AS MainWork,'#13 +
      'IIf(AppointmentLast.WCH_ID=1,1,0) AS PermanentWork,'#13 +
      'IIf(IIf(ISNULL(StaffList.WartimePlan),0,StaffList.WartimePlan)>0,1,0) AS WARTIME,'#13 +
      'IIF(EXISTS(SELECT * FROM KDEFVUS WHERE NAME = left(P.VUS, IIF((select state from KWRANGE where WRNG_ID = P.WRNG_ID) = 3, 6, 3))), 1,0) AS DefVUS,'#13 +
      'IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300), 1,0) AS Command300, P.EOARMY_DATE AS EOARMY_YEAR,'#13 +
      'IIF(EXISTS(SELECT * FROM PDP   WHERE PDP.POST_ID = AppointmentLast.POST_ID AND (PDP.Limited = 0 OR P.WCAT="В")'#13+
      'AND PDP.WSOST LIKE "%."&P.WSOST_ID&".%" AND (PDP.WRange=0 OR PDP.CHE >= R.CHE)'#13 +
      'AND PDP.Age < Year(Date())-Year(P.BIRTHDAY)),1,0) AS DefPOST'#13 +
      'FROM ((Person AS P LEFT JOIN AppointmentLast ON P.PERS_ID=AppointmentLast.PERS_ID) LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) LEFT JOIN StaffList ON (AppointmentLast.DEP_ID=StaffList.DEP_ID) AND (AppointmentLast.POST_ID=StaffList.POST_ID);');

//24
    DoSQL('DROP view PersonreservChkInfo',True);
    DoSQL('CREATE VIEW PersonreservChkInfo AS '#13#10+
    'SELECT PERS_ID, Reserved, MainWork, PermanentWork, WARTIME, DefVUS, Command300, EOARMY_YEAR, DefPOST,'#13 +
    'IIF(IS_WAR<>1 or (not ISNULL(W_DEND) and W_DEND<=Date()), 0,'#13 +
    'IIF((Reserved=1)<>('#13 +
    '        (MainWork=1) and'#13 +
    '        (PermanentWork=1) and'#13 +
    '        (WARTIME=1) and'#13 +
    '        (DefVUS=0) and'#13 +
    '        (Command300=0) and'#13 +
    '        (SpecialWUchet1<>1) and'#13 +
    '        (ISNULL(EOARMY_YEAR) or (Male<>1) or'#13 +
    '         ((Len(EOARMY_YEAR)=4) and (((Year(Date())-Val(EOARMY_YEAR)) >=5) or  (R.LIMIT1 <= Year(Date())-Year(BIRTHDAY))) ) or'#13 +
    '         ((Len(EOARMY_YEAR)=10) and ((IIF(Month(Date())<Month(DateValue(EOARMY_YEAR)),'#13 +
    '              Year(Date())-Year(DateValue(EOARMY_YEAR))-1,'#13 +
    '              IIF(Month(Date())>Month(DateValue(EOARMY_YEAR)),'#13 +
    '                Year(Date())-Year(DateValue(EOARMY_YEAR)),'#13 +
    '                IIF(Day(Date())<Day(DateValue(EOARMY_YEAR)),'#13 +
    '                   Year(Date())-Year(DateValue(EOARMY_YEAR))-1,'#13 +
    '                   Year(Date())-Year(DateValue(EOARMY_YEAR)))))>=5) or (R.LIMIT1 <= Year(Date())-Year(BIRTHDAY)))) or not ('#13 +
    '         ((R.CHE<= 8)             and (Year(Date())-Year(BIRTHDAY)<=35)) or'#13 +
    '         ((R.CHE IN (9,10,11,12)) and (Year(Date())-Year(BIRTHDAY)<=45)) or'#13 +
    '         ((R.CHE IN (13,14))      and (Year(Date())-Year(BIRTHDAY)<=50)) or'#13 +
    '         ((R.CHE =15)             and (Year(Date())-Year(BIRTHDAY)<=55)) or'#13 +
    '         ((R.CHE >15)             and (Year(Date())-Year(BIRTHDAY)<=60)))'#13 +
    '        ) and'#13 +
    '        (DefPOST=1)),1,0)) AS IS_BAD'#13 +
//    'IIF((Reserved=1)<>('#13 +
//    '        (MainWork=1) and'#13 +
//    '        (PermanentWork=1) and'#13 +
//    '        (WARTIME=1) and'#13 +
//    '        (DefVUS=0) and'#13 +
//    '        (Command300=0) and'#13 +
//    '        (SpecialWUchet1<>1) and'#13 +
//    '        (ISNULL(EOARMY_YEAR) or (Male<>1) or'#13 +
//    '         ((Len(EOARMY_YEAR)=4) and (((Year(Date())-Val(EOARMY_YEAR)) >=5) or  (R.LIMIT1 <= Year(Date())-Year(BIRTHDAY))) ) or'#13 +
//    '         ((Len(EOARMY_YEAR)=10) and (IIF(Month(Date())<Month(DateValue(EOARMY_YEAR)),'#13 +
//    '              Year(Date())-Year(DateValue(EOARMY_YEAR))-1,'#13 +
//    '              IIF(Month(Date())>Month(DateValue(EOARMY_YEAR)),'#13 +
//    '                Year(Date())-Year(DateValue(EOARMY_YEAR)),'#13 +
//    '                IIF(Day(Date())<Day(DateValue(EOARMY_YEAR)),'#13 +
//    '                   Year(Date())-Year(DateValue(EOARMY_YEAR))-1,'#13 +
//    '                   Year(Date())-Year(DateValue(EOARMY_YEAR)))))>=5) or (R.LIMIT1 <= Year(Date())-Year(BIRTHDAY)))) or not ('#13 +
//    '         ((R.CHE<= 8)             and (Year(Date())-Year(BIRTHDAY)<=35)) or'#13 +
//    '         ((R.CHE IN (9,10,11,12)) and (Year(Date())-Year(BIRTHDAY)<=45)) or'#13 +
//    '         ((R.CHE IN (13,14))      and (Year(Date())-Year(BIRTHDAY)<=50)) or'#13 +
//    '         ((R.CHE =15)             and (Year(Date())-Year(BIRTHDAY)<=55)) or'#13 +
//    '         ((R.CHE >15)             and (Year(Date())-Year(BIRTHDAY)<=60)))'#13 +
//    '        ) and'#13 +
//    '        (DefPOST=1)),1,0)) AS IS_BAD'#13 +
    'FROM PersonReservChkInfoBase;');
//25
    DoSQL('DROP view StaffListAll',True);
    DoSQL('CREATE VIEW StaffListAll AS '#13#10+
    'SELECT StaffListFull.DEP_ID, StaffListFull.DEP_NAME, StaffListFull.POST_ID, ' +
    'StaffListFull.POST_NAME, ' +
    'IIF(ISNULL(StaffListFull.GeneralPlan),0,StaffListFull.GeneralPlan) AS GeneralPlan, ' +
    'IIF(ISNULL(StaffListFull.WartimePlan),0,StaffListFull.WartimePlan) AS WartimePlan, ' +
    'IIF(ISNULL(StaffListFull.GeneralQty),0,StaffListFull.GeneralQty) AS GeneralQty, ' +
    'IIF(ISNULL(StaffListFull.GeneralVacancy),0,StaffListFull.GeneralVacancy) AS GeneralVacancy, ' +
    'IIF(ISNULL(StaffListFull.WartimeVacancy),0,StaffListFull.WartimeVacancy) AS WartimeVacancy, ' +
    'Count(PersonMob.PERS_ID) AS QtyMOB, Count(PersonRecruit.PERS_ID) AS QtyRECRUIT, ' +
    'Count(PersonReserv.PERS_ID) AS QtyRESERV, Count(PersonWar.PERS_ID) AS QtyWAR, ' +
    'Count(IIF(PERSON.PERS_ID is not null and (PERSON.OUT_DATE is null or PERSON.OUT_DATE > Date()), 1, null)) AS QtyAll ' +
    'FROM StaffListFull LEFT JOIN (((((AppointmentLastAll ' +
    'LEFT JOIN PERSON ON AppointmentLastAll.PERS_ID=PERSON.PERS_ID) ' +
    'LEFT JOIN PersonMob ON AppointmentLastAll.PERS_ID=PersonMob.PERS_ID) ' +
    'LEFT JOIN PersonRecruit ON AppointmentLastAll.PERS_ID=PersonRecruit.PERS_ID) ' +
    'LEFT JOIN PersonReserv ON AppointmentLastAll.PERS_ID=PersonReserv.PERS_ID) ' +
    'LEFT JOIN PersonWar ON AppointmentLastAll.PERS_ID=PersonWar.PERS_ID) ON ' +
    '(StaffListFull.POST_ID=AppointmentLastAll.POST_ID) AND ' +
    '(StaffListFull.DEP_ID=AppointmentLastAll.DEP_ID) ' +
    'GROUP BY StaffListFull.DEP_ID, StaffListFull.DEP_NAME, StaffListFull.POST_ID, ' +
    'StaffListFull.POST_NAME, StaffListFull.GeneralPlan, StaffListFull.WartimePlan, ' +
    'StaffListFull.GeneralQty, StaffListFull.GeneralVacancy, StaffListFull.WartimeVacancy;');
//26
    DoSQL('UPDATE KREGPL SET REGPL_NAME = ''ФНС'' WHERE REGPL_ID = 2');
//27
    fmMain.lbProcState.Caption := 'обновление справочника "Военный состав (профиль)"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('UPDATE KWSOST SET WSOST_NAME = ''инженерный и технический'' WHERE WSOST_ID = 5', True);
    DoSQL('UPDATE KWSOST SET WSOST_NAME = ''гуманитарный'' WHERE WSOST_ID = 7', True);
    DoSQL('UPDATE PERSON SET WSOST_ID = 7 WHERE WSOST_ID = 9', True);
    DoSQL('UPDATE PERSON SET WSOST_ID = 10 WHERE WSOST_ID = 11', True);
    DoSQL('DELETE From KWSOST WHERE WSOST_ID = 9', True);
    DoSQL('DELETE From KWSOST WHERE WSOST_ID = 11');
//29
    DoSQL('Create table VerInfo (' +
          'VerId COUNTER NOT NULL Primary Key,' +
          'VerStr varchar(50) NOT NULL,' +
          'VerDesc varchar(255),' +
          'VerDate datetime NOT NULL' +
          ')', True);
    DoSQL('INSERT INTO VerInfo (VerStr, VerDesc, VerDate)'#13 +
          'VALUES (''3.75'', ''Версия релиза 3.75'', #17/07/2010#)');
  finally Free;
  end;
end;

end.

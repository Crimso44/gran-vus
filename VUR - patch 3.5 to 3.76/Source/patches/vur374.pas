unit vur374;

interface

  function Patch374_GetInfo: string;
  function Patch374_GetStepCount: Integer;
  procedure Patch374_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants;

function Patch374_GetInfo: string;
begin
  Result :=
   'Версия 3.74:'#13+
   '  - В картотеке работников:'#13+
   '    дополнена разметка цветом: темно-красный - с просроченным академическим отпуском;'#13+
   '  - В справочник воинских званий добавлено звание "допризывник"' + #13 +
   '  - Добавлен справочник "Специальности выпускников"' + #13 +
   '  - Добавлен справочник "Квалификации выпускников"' + #13 +
   '  - Обновлен справочник "Виды работы и формы обучения"' + #13 +
   '  - Обновлен справочник "Учёные степени и уровни образования"' + #13 +
   '  - В Администрирование/Параметры/Другие добавлен параметр "Форму сверки данных с ОВК подписывает"' + #13 +
   '  - В словарь структурных подразделений добавлено поле "Полное наименование"' + #13 +
   '  - В личную карточку работника:' + #13 +
   '    добавлена закладка "Сведения об учащемся"' + #13 +
   '    на закладку "Назначения" добавлено поле "Контракт истекает" - активно только если характер работы - "временная"' + #13 +
   '  - В карточку организации добавлена кнопка "Только для ВУЗов" и соответствующий раздел' + #13 +
   '  - Добавлена печатная форма "Форма № 26" для студентов и аспирантов' + #13 +
   '  - Добавлена печатная форма "Донесение ф-11 МУ"' + #13 +
   '  - В форму "Сообщение в ОВК об изменениях" добавлены три печатные формы с отрывным талоном и без:' + #13 +
   '    печатная форма "об уходе учащегося в академический отпуск"' + #13 +
   '    печатная форма "об окончании академического отпуска"' + #13 +
   '    печатная форма "об обучении на военной кафедре"' + #13 +
   '  - Добавлен модуль автоматического обновления';
end;

function Patch374_GetStepCount: Integer;
begin
  Result := 75;
end;

procedure Patch374_Process;
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
    DoSQL('Create table N26History (' +
          'N26_ID INTEGER NOT NULL Primary Key,' +
          'PERS_ID INTEGER NOT NULL,' +
          'FORM_NUM varchar(20) NULL,' +
          'CREATE_DATE datetime NULL,' +
          'GIVE_DATE datetime NULL' +
          ')');
//2
    DoSQL('Create table Params (' +
          'Param_ID INTEGER NOT NULL Primary Key,' +
          'Param_Name varchar(255),' +
          'Param_Value varchar(255)' +
          ')');
//3
    DoSQL('Create table KWTP_FOR (' +
          'FOR_ID INTEGER NOT NULL Primary Key,' +
          'FOR_Value varchar(255)' +
          ')');
//4
    DoSQL('Drop table KWKTYPE');
//5
    DoSQL('Create table KWKTYPE (' +
          'WTP_ID INTEGER NOT NULL Primary Key,' +
          'WTP_NAME varchar(255),' +
          'WTP_PREP_NAME varchar(255),' +
          'WTP_FLAG INTEGER' +
          ')');
//6
    DoSQL('Create table KSCIENCE_TYPE (' +
          'SCT_ID INTEGER NOT NULL Primary Key,' +
          'SCT_Value varchar(255)' +
          ')');
//7
    DoSQL('Drop table KSCIENCE');
//8
    DoSQL('Create table KSCIENCE (' +
          'SC_ID INTEGER NOT NULL Primary Key,' +
          'SC_NAME varchar(255),' +
          'SC_PREP_NAME varchar(255),' +
          'SC_OKIN varchar(20),' +
          'SC_FLAG INTEGER' +
          ')');
//9
    DoSQL('Create table KKVAL (' +
          'KVAL_ID INTEGER NOT NULL Primary Key,' +
          'KVAL_NAME varchar(255),' +
          'KVAL_SHORT_NAME varchar(255),' +
          'KVAL_KOD varchar(15),' +
          'KVAL_FLAG INTEGER' +
          ')');
//10
    DoSQL('Create table KNAPR (' +
          'NAPR_ID INTEGER NOT NULL Primary Key,' +
          'NAPR_NAME varchar(255),' +
          'NAPR_KOD varchar(15),' +
          'NAPR_FLAG INTEGER' +
          ')');

//11
    DoSQL('Create table DBVersionData (' +
          'ID COUNTER NOT NULL Primary Key,' +
          'DBVERSION INTEGER NOT NULL,' +
          'DBSCRIPT text' +
          ')');
//12
    DoSQL('Create table History (' +
          'HistoryId COUNTER NOT NULL Primary Key,' +
          'HistoryType char,' +
          'HistoryDate datetime NOT NULL,' +
          'HistoryText text,' +
          'OnlyMain smallint,' +
          'BuildNo INTEGER' +
          ')');
//13
    DoSQL('Create table ImportData (' +
          'Import_ID COUNTER NOT NULL Primary Key,' +
          'InnerID INTEGER,' +
          'OuterID varchar(255) NOT NULL,' +
          'TableName varchar(100),' +
          'IDField varchar(100)' +
          ')', True);

    DoSQL('alter table ImportData alter column OuterID varchar(255) NOT NULL');

    fmMain.lbProcState.Caption := 'обновление таблиц...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;

    AddField('PERSON','IsAspirant','INTEGER NULL');//14
    AddField('PERSON','StudyForm','INTEGER NULL');//15
    AddField('PERSON','StudyEnd_date','datetime NULL');//16
    AddField('PERSON','OrderAkadem','varchar(20) NULL');//17
    AddField('PERSON','OrderAkadem_date','datetime NULL');//18
    AddField('PERSON','ReasonAkadem','varchar(100) NULL');//19
    AddField('PERSON','BeginAkadem_date','datetime NULL');//20
    AddField('PERSON','EndAkadem_date','datetime NULL');//21
    AddField('PERSON','RealEndAkadem_date','datetime NULL');//22
    AddField('PERSON','MedResult_date','datetime NULL');//23
    AddField('PERSON','MedResult','INTEGER NULL');//24
    AddField('PERSON','VKStatus','INTEGER NULL');//25
    AddField('PERSON','BeginWar_date','datetime NULL');//26
    AddField('PERSON','EndWar_date','datetime NULL');//27
    AddField('PERSON','RealEndWar_date','datetime NULL');//28
    AddField('PERSON','ReasonEndWar','varchar(100) NULL');//29
    AddField('PERSON','Dismissal_date','datetime NULL');//30
    AddField('PERSON','OrderDismissal','varchar(20) NULL');//31
    AddField('PERSON','OrderDismissal_date','datetime NULL');//32
    AddField('PERSON','ReasonDismissal','varchar(100) NULL');//33
    AddField('PERSON','DisserName','varchar(100) NULL');//34
    AddField('PERSON','Degree_ID','INTEGER NULL');//35
    AddField('PERSON','GuideDegree_ID','INTEGER NULL');//36
    AddField('PERSON','FIOGuide','varchar(100) NULL');//37
    AddField('PERSON','Defend_date','datetime NULL');//38
    AddField('PERSON','RealDefend_date','datetime NULL');//39
    AddField('PERSON','ContractEnd','varchar(50) NULL');//40
    AddField('PERSON','Kval_Id','INTEGER NULL');//41

    AddField('ORG','License1','varchar(30) NULL');//42
    AddField('ORG','License1_date','datetime NULL');//43
    AddField('ORG','License1Who','varchar(255) NULL');//44
    AddField('ORG','License2','varchar(30) NULL');//45
    AddField('ORG','License2_date','datetime NULL');//46
    AddField('ORG','License2Who','varchar(255) NULL');//47
    AddField('ORG','Certificate','varchar(30) NULL');//48
    AddField('ORG','BeginCertificate_date','datetime NULL');//49
    AddField('ORG','EndCertificate_date','datetime NULL');//50
    AddField('ORG','CertificateWho','varchar(255) NULL');//51
    AddField('ORG','WhoPuts','varchar(255) NULL');//52
    AddField('ORG','HasVK','bit NULL');//53
    AddField('ORG','VKChief','varchar(100) NULL');//54
    AddField('ORG','VKChiefRange','INTEGER NULL');//55

    AddField('EDUC','KVAL_ID','INTEGER NULL');//56
    AddField('EDUC','NAPR_ID','INTEGER NULL');//57

    DoSQL('UPDATE PERSON SET DOCUMENT = 0 WHERE DOCUMENT IS NULL');//58
    DoSQL('UPDATE PERSON SET BRANCH = 0 WHERE BRANCH IS NULL');//59

//60
    fmMain.lbProcState.Caption := 'Создание справочника "Специальности выпускников"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
          'VALUES (31, ''KNAPR'', ''Специальности выпускников'', 1, ' +
          '''SELECT COUNT(*) FROM EDUC WHERE NAPR_ID=:ID'')', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (110, 31, ''NAPR_ID'', ''Код внутренний'', 0, 1, 0, 0, ' +
          '''{SQL:SELECT MAX(NAPR_ID)+1 FROM KNAPR}{TXT:1}'', 0)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (111, 31, ''NAPR_NAME'', ''Наименование'', 200, 0, 1, 1, ' +
          'NULL, 0)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (112, 31, ''NAPR_KOD'', ''Код специальности'', 50, 0, 1, 1, ' +
          'NULL, 1)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (113, 31, ''NAPR_FLAG'', ''Для...'', 105, 0, 1, 0, ' +
          '''{LU:SELECT FOR_ID, FOR_Value FROM KWTP_FOR WHERE FOR_ID IN (1,2)}'', 0)');
//61
    fmMain.lbProcState.Caption := 'Создание справочника "Квалификации выпускников"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
          'VALUES (30, ''KKVAL'', ''Квалификации выпускников'', 1, ' +
          '''SELECT COUNT(*) FROM EDUC WHERE KVAL_ID=:ID'')', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (105, 30, ''KVAL_ID'', ''Код внутренний'', 0, 1, 0, 0, ' +
          '''{SQL:SELECT MAX(KVAL_ID)+1 FROM KKVAL}{TXT:1}'', 0)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (106, 30, ''KVAL_NAME'', ''Наименование'', 200, 0, 1, 1, ' +
          'NULL, 0)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (107, 30, ''KVAL_SHORT_NAME'', ''Наименование сокращенное'', ' +
          '50, 0, 1, 1, NULL, 1)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (108, 30, ''KVAL_KOD'', ''Код квалификации'', 50, 0, 1, 1, ' +
          'NULL, 1)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (109, 30, ''KVAL_FLAG'', ''Для...'', 105, 0, 1, 0, ' +
          '''{LU:SELECT FOR_ID, FOR_Value FROM KWTP_FOR WHERE FOR_ID IN (1,2)}'', 0)');
//62
    fmMain.lbProcState.Caption := 'обновление справочника "Учёные степени и уровни образования"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('UPDATE KL_DATA SET DISP_NAME = ''Учёные степени и уровни образования'', IS_EDIT = 1 ' +
          'WHERE KL_ID = 15', True);
    DoSQL('INSERT INTO KSCIENCE_TYPE (SCT_ID, SCT_Value) Values (1, ''Вид высшего образования'')', True);
    DoSQL('INSERT INTO KSCIENCE_TYPE (SCT_ID, SCT_Value) Values (2, ''Ученая степень'')', True);
    DoSQL('INSERT INTO KSCIENCE (SC_ID, SC_NAME, SC_PREP_NAME, SC_OKIN, SC_FLAG) ' +
          'VALUES (1, ''Доктор наук'', ''Доктора наук'', ''350001'', 2)', True);
    DoSQL('INSERT INTO KSCIENCE (SC_ID, SC_NAME, SC_PREP_NAME, SC_OKIN, SC_FLAG) ' +
          'VALUES (2, ''Кандидат наук'', ''Кандидата наук'', ''350002'', 2)', True);
    DoSQL('INSERT INTO KSCIENCE (SC_ID, SC_NAME, SC_PREP_NAME, SC_OKIN, SC_FLAG) ' +
          'VALUES (3, ''бакалавр'', ''бакалавра'', '''', 1)', True);
    DoSQL('INSERT INTO KSCIENCE (SC_ID, SC_NAME, SC_PREP_NAME, SC_OKIN, SC_FLAG) ' +
          'VALUES (4, ''магистр'', ''магистра'', '''', 1)', True);
    DoSQL('INSERT INTO KSCIENCE (SC_ID, SC_NAME, SC_PREP_NAME, SC_OKIN, SC_FLAG) ' +
          'VALUES (5, ''специалист'', ''специалиста'', '''', 1)', True);
    DoSQL('UPDATE KL_FLD SET DISP_SIZE = 86 WHERE FLD_ID = 37 AND KL_ID = 15',True);
    DoSQL('UPDATE KL_FLD SET DISP_SIZE = 59, FLD_NAME = ''SC_OKIN'' WHERE FLD_ID = 53 AND KL_ID = 15',True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (103, 15, ''SC_PREP_NAME'', ''Предложный падеж'', 124, 0, 1, 1, ' +
          'NULL, 1)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (104, 15, ''SC_FLAG'', ''Признак'', 195, 0, 1, 0, ' +
          '''{LU:SELECT SCT_ID, SCT_Value FROM KSCIENCE_TYPE}'', 0)');
//63
    fmMain.lbProcState.Caption := 'обновление справочника "Виды работы и формы обучения"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('UPDATE KL_DATA SET DISP_NAME = ''Виды работы и формы обучения'', IS_EDIT = 1, ' +
          'CHK_DEL = ''SELECT COUNT(*) FROM APPOINTMENT WHERE WTP_ID=:ID'' ' +
          'WHERE KL_ID = 17', True);
    DoSQL('INSERT INTO KWTP_FOR (FOR_ID, FOR_Value) Values (1, ''Для студентов'')', True);
    DoSQL('INSERT INTO KWTP_FOR (FOR_ID, FOR_Value) Values (2, ''Для аспирантов'')', True);
    DoSQL('INSERT INTO KWTP_FOR (FOR_ID, FOR_Value) Values (3, ''Для работников'')', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) ' +
          'VALUES (1, ''основная'', ''основной'', 3)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) ' +
          'VALUES (2, ''по совместительству'', '''', 3)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) ' +
          'VALUES (3, ''очное отделение'', ''очном отделении'', 1)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) VALUES' +
          '(4, ''очно-заочное (вечернее) отделение'', ''очно-заочном (вечернем) отделении'', 1)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) ' +
          'VALUES (5, ''заочное отделение'', ''заочном отделении'', 1)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) ' +
          'VALUES (6, ''второе высшее'', '''', 1)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) ' +
          'VALUES (7, ''повышение квалификации'', '''', 1)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) ' +
          'VALUES (8, ''профессиональная переподготовка'', '''', 1)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) ' +
          'VALUES (9, ''очное отделение'', ''очном отделении'', 2)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) VALUES ' +
          '(10, ''очно-заочное (вечернее) отделение'', ''очно-заочном (вечернем) отделении'', 2)', True);
    DoSQL('INSERT INTO KWKTYPE (WTP_ID, WTP_NAME, WTP_PREP_NAME, WTP_FLAG) ' +
          'VALUES (11, ''заочное отделение'', ''заочном отделении'', 2)', True);
    DoSQL('UPDATE KL_FLD SET DISP_SIZE = 195 WHERE FLD_ID = 42 AND KL_ID = 17',True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (101, 17, ''WTP_PREP_NAME'', ''Предложный падеж'', 195, 0, 1, 1, ' +
          'NULL, 1)', True);
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (102, 17, ''WTP_FLAG'', ''Для...'', 105, 0, 1, 0, ' +
          '''{LU:SELECT FOR_ID, FOR_Value FROM KWTP_FOR}'', 0)');
//64
    fmMain.lbProcState.Caption := 'добавление звания "допризывник" в справочник воинских званий...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('insert into KWRANGE (WRNG_ID,WRNG_NAME,STATE,GODN,CHE) '+
    'values (37,''допризывник'',0,''А,Б,В,Г,Д'',0)');
//65
    fmMain.lbProcState.Caption := 'добавление параметров...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('insert into Params (Param_ID,Param_Name,Param_Value) '+
    'values (1,''Форму сверки данных с ОВК подписывает'',''0'')', True);
    DoSQL('insert into Params (Param_ID,Param_Name,Param_Value) '+
    'values (2,''Проверять обновления при каждом запуске'',''0'')');
//66
    fmMain.lbProcState.Caption := 'удаление из справочника должностей полей: "Код по ОКПДТР" и "Наименование по ОКПДТР"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('update KL_FLD set Visible = 0, Has_Null = 1 where FLD_ID in (77,78)');
//67
    fmMain.lbProcState.Caption := 'Добавление в словарь структурных подразделений поля "Полное наименование"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('update KL_FLD set DISP_NAME = ''Краткое наименование'' where FLD_ID = 29', True);
    DoSQL('insert into KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, ' +
    'IS_EDIT, VISIBLE, HAS_NULL) values (100, 11, ''DEP_FULL_NAME'', ''Полное наименование'', 933, ' +
    '0, 1, 1, 1)');

    fmMain.lbProcState.Caption := 'обновление запросов...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//68
    DoSQL('CREATE VIEW vw_VUR_Users AS '#13#10+
    'SELECT Users.ID, Users.Login, Users.FAM, Users.IM, Users.OTCH, Users.HASH, '+
    'Users.rAdmin, Users.rImport, Users.rExport, Users.rPrint, Users.rEdit, '+
    'Users.rLogin FROM Users;');
//69
    DoSQL('DROP view AppointmentMaxIn_Date',True);
    DoSQL('CREATE VIEW AppointmentMaxIn_Date AS '#13#10+
      'SELECT a.PERS_ID, max(a.ID) AS [Max-ID], a.IN_DATE AS [MAX-In_Date] ' +
      'FROM Appointment AS a ' +
      'WHERE IN_DATE = (SELECT Max(IN_DATE) ' +
      'FROM Appointment ' +
      'WHERE PERS_ID = a.PERS_ID AND Appointment.POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID <> 500)) ' +
      'GROUP BY a.PERS_ID, a.IN_DATE;');
//70
    DoSQL('DROP view AppointmentLast',True);
    DoSQL('CREATE VIEW AppointmentLast AS '#13#10+
      'SELECT Appointment.* ' +
      'FROM Appointment ' +
      'INNER JOIN AppointmentMaxIn_Date ON (Appointment.ID = AppointmentMaxIn_Date.[Max-ID]);');
//71
    DoSQL('DROP view AppointmentMaxIn_DateAll',True);
    DoSQL('CREATE VIEW AppointmentMaxIn_DateAll AS '#13#10 +
      'SELECT a.PERS_ID, max(a.ID) AS [Max-ID], a.IN_DATE AS [MAX-In_Date] ' +
      'FROM Appointment AS a ' +
      'WHERE IN_DATE = (SELECT Max(IN_DATE) ' +
      'FROM Appointment ' +
      'WHERE PERS_ID = a.PERS_ID) ' +
      'GROUP BY a.PERS_ID, a.IN_DATE;');
//72
    DoSQL('DROP view AppointmentLastAll',True);
    DoSQL('CREATE VIEW AppointmentLastAll AS '#13#10+
      'SELECT Appointment.* ' +
      'FROM Appointment ' +
      'INNER JOIN AppointmentMaxIn_DateAll ON (Appointment.ID=AppointmentMaxIn_DateAll.[Max-ID]);');
//73
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
    'Count(PERSON.PERS_ID) AS QtyAll FROM StaffListFull LEFT JOIN (((((AppointmentLastAll ' +
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
//74
    DoSQL('DROP view PersonreservChkInfoBase',True);
    DoSQL('CREATE VIEW PersonreservChkInfoBase AS '#13#10+
    'SELECT P.PERS_ID, P.IS_WAR, P.W_DEND, P.SpecialWUchet1, P.BIRTHDAY, P.Male, R.CHE, ' +
    'IIf(ISNULL(P.WUCHET2),0,1) AS Reserved, IIf([AppointmentLast].[WTP_ID]=1,1,0) AS MainWork, ' +
    'IIf([AppointmentLast].[WCH_ID]=1,1,0) AS PermanentWork, ' +
    'IIf(IIf(ISNULL([StaffList].[WartimePlan]),0,[StaffList].[WartimePlan])>0,1,0) AS WARTIME, ' +
    'IIF(EXISTS(SELECT * FROM KDEFVUS WHERE NAME = left(P.VUS, IIF((select state from KWRANGE ' +
    'where WRNG_ID = P.WRNG_ID) = 3, 6, 3))), 1,0) AS DefVUS, ' +
    'IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300), 1,0) AS Command300, ' +
    'P.EOARMY_DATE AS EOARMY_YEAR, IIF(EXISTS(SELECT * FROM PDP ' +
    'WHERE PDP.POST_ID = AppointmentLast.POST_ID AND (PDP.Limited = 0 OR P.WCAT="В") AND ' +
    'PDP.WSOST LIKE "%."&P.WSOST_ID&".%" AND (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND ' +
    'PDP.Age < Year(Date())-Year(P.BIRTHDAY))   ,1,0) AS DefPOST FROM ' +
    '((Person AS P LEFT JOIN AppointmentLast ON P.PERS_ID=[AppointmentLast].[PERS_ID]) ' +
    'LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) ' +
    'LEFT JOIN StaffList ON ([AppointmentLast].[DEP_ID]=[StaffList].[DEP_ID]) AND ' +
    '([AppointmentLast].[POST_ID]=[StaffList].[POST_ID]);');
//75
    DoSQL('create table VERSION374 (x integer not null)');
  finally Free;
  end;
end;

end.

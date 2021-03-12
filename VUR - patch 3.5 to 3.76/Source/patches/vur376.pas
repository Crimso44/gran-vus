unit vur376;

interface

  function Patch376_GetInfo: string;
  function Patch376_GetStepCount: Integer;
  procedure Patch376_Process;

type
  TOKTMOList = array[1..126*2] of String;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs;

var
  OKTMO: TOKTMOList = (
'Муниципальные образования города Москвы столицы Российской Федерации города Федерального значения','45',
'Богородское','45301000',
'Вешняки','45302000',
'Восточное Измайлово','45303000',
'Восточное','45304000',
'Гольяново','45305000',
'Ивановское','45306000',
'Измайлово','45307000',
'Косино-Ухтомское','45308000',
'Новогиреево','45309000',
'Новокосино','45310000',
'Метрогородок','45311000',
'Перово','45312000',
'Северное Измайлово','45313000',
'Соколиная Гора','45314000',
'Сокольники','45315000',
'Преображенское','45316000',
'Внуково','45317000',
'Дорогомилово','45318000',
'Крылатское','45319000',
'Кунцево','45320000',
'Можайское','45321000',
'Ново-Переделкино','45322000',
'Очаково-Матвеевское','45323000',
'Проспект Вернадского','45324000',
'Раменки','45325000',
'Солнцево','45326000',
'Тропарево-Никулино','45327000',
'Филевский Парк','45328000',
'Фили-Давыдково','45329000',
'Крюково','45330000',
'Матушкино','45331000',
'Силино','45332000',
'Аэропорт','45333000',
'Беговое','45334000',
'Бескудниковское','45335000',
'Войковское','45336000',
'Восточное Дегунино','45337000',
'Головинское','45338000',
'Дмитровское','45339000',
'Западное Дегунино','45340000',
'Коптево','45341000',
'Левобережное','45342000',
'Молжаниновское','45343000',
'Савеловское','45344000',
'Сокол','45345000',
'Тимирязевское','45346000',
'Ховрино','45347000',
'Хорошевское','45348000',
'Алексеевское','45349000',
'Алтуфьевское','45350000',
'Бабушкинское','45351000',
'Бибирево','45352000',
'Бутырское','45353000',
'Лианозово','45354000',
'Лосиноостровское','45355000',
'Марфино','45356000',
'Марьина Роща','45357000',
'Останкинское','45358000',
'Отрадное','45359000',
'Ростокино','45360000',
'Свиблово','45361000',
'Северное Медведково','45362000',
'Северное','45363000',
'Южное Медведково','45364000',
'Ярославское','45365000',
'Куркино','45366000',
'Митино','45367000',
'Покровское-Стрешнево','45368000',
'Северное Тушино','45369000',
'Строгино','45370000',
'Хорошево-Мневники','45371000',
'Щукино','45372000',
'Южное Тушино','45373000',
'Арбат','45374000',
'Басманное','45375000',
'Замоскворечье','45376000',
'Савелки','45377000',
'Красносельское','45378000',
'Мещанское','45379000',
'Пресненское','45380000',
'Таганское','45381000',
'Тверское','45382000',
'Хамовники','45383000',
'Якиманка','45384000',
'Выхино-Жулебино','45385000',
'Капотня','45386000',
'Кузьминки','45387000',
'Лефортово','45388000',
'Люблино','45389000',
'Марьино','45390000',
'Некрасовка','45391000',
'Нижегородское','45392000',
'Печатники','45393000',
'Рязанское','45394000',
'Текстильщики','45395000',
'Южнопортовое','45396000',
'Академическое','45397000',
'Гагаринское','45398000',
'Зюзино','45901000',
'Коньково','45902000',
'Котловка','45903000',
'Ломоносовское','45904000',
'Обручевское','45905000',
'Северное Бутово','45906000',
'Теплый Стан','45907000',
'Черемушки','45908000',
'Южное Бутово','45909000',
'Ясенево','45910000',
'Бирюлево Восточное','45911000',
'Бирюлево Западное','45912000',
'Братеево','45913000',
'Даниловское','45914000',
'Донское','45915000',
'Зябликово','45916000',
'Москворечье-Сабурово','45917000',
'Нагатино-Садовники','45918000',
'Нагатинский Затон','45919000',
'Нагорное','45920000',
'Орехово-Борисово Северное','45921000',
'Орехово-Борисово Южное','45922000',
'Царицыно','45923000',
'Чертаново Северное','45924000',
'Чертаново Центральное','45925000',
'Чертаново Южное','45926000',
'Старое Крюково','459272000');





function Patch376_GetInfo: string;
begin
  Result :=
   'Версия 3.76:'#13+
   '  - в закладке "Воинский учет" добавлено поле "Участник боевых действий"'#13+
   '  - в сведениях об изменениях в учетных данных работников записываются сведения о предоставлении учащемуся академического отпуска и о его возвращении из академического отпуска'#13+
   '  - в таблице "Сведениях об изменениях в учетных данных работников и учащихся" добавлены поля "исходящий №" и "дата"'#13+
   '  - при фиксации служебного перемещения работника автоматически корректируются сведения о фактически работающих в штатном расписании'#13+
   '  - добавлен фильр по должностям и подразделениям в пункте меню "Штатное расписание и учет Всего работающих"'#13+
   '  - добавлен отчет "Список граждан мужского пола 15- и 16-летнего возраста"'#13+
   '  - в базовых справочниках добавлена возможность сортировки и фильтрации'#13+
   '  - в справочниках "Должности" и "Подразделения предприятия" введена ручная сортировка'#13+
   '  - изменены отчеты "Сообщение о прохождении обучения" и "Письма в ОВК"'#13+
   '  - расширены некоторые поля в карточках'#13+
   '  - справочник "Военкоматы" заменен на "Отделы военных комиссариатов (администрации районов)"'#13+
   '  - обновлен справочник ОКТМО'#13+
   '  - изменен способ расчета формы № 6 организации';
end;

function Patch376_GetStepCount: Integer;
begin
  Result := 7;
end;

procedure Patch376_Process;
var
  Q: TADOQuery;
  i: Integer;

  procedure DoSQL(const ASQL: String; const NoCount: Boolean = False);
  begin
    with Q do
    try
      SQL.Text := ASQL;
      ExecSQL;
    except {} end;
    if not NoCount then
      fmMain.pbMain.StepIt;
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
    //fmMain.pbMain.StepIt;
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
    fmMain.lbProcState.Caption := 'изменения в картотеке работников...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('alter table PERSON Alter Comments Memo', True);
    DoSQL('alter table PERSON Add Warfare Text(255)', True);
    DoSQL('Insert Into KL_FLDGROUPS (Group_Id, Group_Name) Values (10, "Академический отпуск")');
//2
    fmMain.lbProcState.Caption := 'изменения в "Сведениях об изменениях в учетных данных"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('alter table PersonChanges Add OutNumber Text(255), OutDate Datetime');
//3
    fmMain.lbProcState.Caption := 'перевод на ручную сортировку справочников "Должности" и "Подразделения предприятия"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('alter table KPOST Alter POST_NAME Text(255)', True);
    DoSQL('alter table KPOST Add KPost_Num Integer', True);
    DoSQL('Update KPOST set KPOST_Num = Post_Id', True);
    DoSQL('alter table KL_DATA Add HandSort Text(50)', True);
    DoSQL('Update KL_DATA set HandSort = "KPOST_Num" Where KL_NAME = "KPOST"', True);
    DoSQL('alter table KDEPART Add KDEPART_Num Integer', True);
    DoSQL('Update KDEPART set KDEPART_Num = Dep_Id', True);
    DoSQL('Update KL_DATA set HandSort = "KDEPART_Num" Where KL_NAME = "KDEPART"');
//4
    fmMain.lbProcState.Caption := 'Изменение справочника "Военкоматы"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('alter table KOVK Alter OVK_Phone Text(250)', True);
    DoSQL('alter table KL_Data Alter Disp_Name Text(150)', True);
    DoSQL('update KL_Data set Disp_Name = "Отделы военных комиссариатов (администрации районов)" where KL_ID = 1', True);
    DoSQL('update KL_Fld set Disp_Name = "Переменная часть наименования органа, ведущего первичный воинский учет ''Отдел военного комиссариата ...'' или ''Администрация ...''" where KL_Id = 1 and Fld_Name = "OVK_NAME"', True);
    DoSQL('update KL_Fld set Disp_Size = 200, Disp_Name = "Дополнительная информация" where KL_Id = 1 and Fld_Name = "OVK_PHONE"', True);
    DoSQL('update KL_Fld set Disp_Size = 200, Disp_Name = "Первичный воинский учет ведет ОВК (не отмечено - учет ведет Администрация)" where KL_Id = 1 and Fld_Name = "ISOVK"');

//5
    fmMain.lbProcState.Caption := 'Обновление справочника ОКТМО...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;

    try
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
            'VALUES (8, ''- Благовещенское'', ''11605404'')', True);

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
            '''{KODOKTMO}'', 0)', True);

      AddField('ORG','KODOKTMO','VARCHAR(11) NULL');

    except {} end;

    for i := 1 to 126 do
      DoSQL('insert into KOKTMO (OKTMO_ID,NAME,KODOKTMO) '+
            'select ID, NM, KOD from '+
            '(select max(OKTMO_ID)+1 as ID,"'+OKTMO[(i-1)*2+1]+'" As NM,"'+OKTMO[(i-1)*2+2]+'" AS KOD '+
            'from KOKTMO where not exists (select * from KOKTMO where KODOKTMO = "'+OKTMO[(i-1)*2+2]+'")) '+
            'where ID is not null', True);
    DoSQL('Update KOKTMO set KODOKTMO = KODOKTMO');
//6
    fmMain.lbProcState.Caption := 'Обновление Формы 6...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;

    AddField('KPOST','IsIgnore','bit NULL');
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (127, 4, ''IsIgnore'', ''Игнорировать при расчете значений столбцов 1-12 ф.№ 6'', 200, 0, 1, 1, ' +
          '''false'', 1)', True);

    DoSQL('alter table KCPROF Alter CPROF_NAME Text(100)', True);
    DoSQL('alter table KCPROF Alter PRINT_NAME Text(100)', True);
    DoSQL('alter table FORM6 Alter PRINT_NAME Text(100)', True);
    DoSQL('Update KCPROF Set STATE = -1, PRINT_NAME = ''Специалисты – всего, из них по основным видам экономической деятельности'', '+
          'EXPRESSION = ''210+221+231+241+251+271+281+291+295'' '+
          'Where CPROF_ID = 200', True);
    DoSQL('Update KCPROF Set PRINT_NAME = ''A. Сельское хозяйство'' '+
          'Where CPROF_ID = 210', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (221, ''Специалисты по добыче полезных ископаемых'', ''C. Добыча полезных ископаемых'', '+
          ''' '', 0, 4)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (231, ''Специалисты по обрабатывающему производству'', ''D. Обрабатывающие производства'', '+
          ''' '', 0, 5)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (241, ''Специалисты по производству и распределению электроэнергии, газа и воды'', ''E. Производство и распределение электроэнергии, газа и воды'', '+
          ''' '', 0, 6)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (251, ''Специалисты по строительству'', ''F. Строительство'', '+
          ''' '', 0, 7)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (271, ''Специалисты по транспорту и связи'', ''I. Транспорт и связь'', '+
          ''' '', 0, 8)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (281, ''Специалисты образования'', ''M. Образование'', '+
          ''' '', 0, 9)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (291, ''Специалисты по здравоохранению и предоставлению социальных услуг'', ''N. Здравоохранение и предоставление социальных услуг'', '+
          ''' '', 0, 10)', True);
    DoSQL('Update KCPROF Set LINE_NO = LINE_NO + 1 Where LINE_NO Between 11 and 13', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (295, ''Специалисты прочих видов экономической деятельности'', ''прочие виды экономической деятельности'', '+
          ''' '', 0, 11)', True);
    DoSQL('Update KCPROF Set '+
          'EXPRESSION = ''410+440+450+460+470+480'' '+
          'Where CPROF_ID = 400', True);
    DoSQL('Update KCPROF Set '+
          'CPROF_NAME = ''Рабочие, имеющие тарифный разряд'', '+
          'PRINT_NAME = ''- имеющие тарифный разряд'' '+
          'Where CPROF_ID = 410', True);
    DoSQL('Update KCPROF Set '+
          'PRINT_NAME = ''Из численности руководителей, специалистов и рабочих:'' '+
          'Where CPROF_ID = 490', True);
    DoSQL('Update KCPROF Set LINE_NO = Null '+
          'Where CPROF_ID = 500', True);
    DoSQL('Update KCPROF Set PRINT_NAME = ''ИТОГО (сумма строк 1+2+12+13)'', '+
          'EXPRESSION = ''100+200+300+400'' '+
          'Where CPROF_ID = 1000', True);
    DoSQL('Update KCPROF Set PRINT_NAME = ''ВСЕГО (сумма строк 22+23)'' '+
          'Where CPROF_ID = 2000', True);
    DoSQL('Update KCPROF Set LINE_NO = LINE_NO - 1 Where LINE_NO Between 16 and 22', True);
    DoSQL('Update KCPROF Set LINE_NO = LINE_NO - 2 Where LINE_NO > 23', True);
    DoSQL('Update KPOST Set CPROF_ID = 281 Where CPROF_ID in (250)', True);
    DoSQL('Update KPOST Set CPROF_ID = 291 Where CPROF_ID in (264, 265)', True);
    DoSQL('Update KPOST Set CPROF_ID = 295 Where CPROF_ID in (200, 220, 230, 240)', True);
    DoSQL('Update KPOST Set CPROF_ID = 410 Where CPROF_ID in (420, 430)', True);
    DoSQL('Delete From KCPROF Where CPROF_ID in (205, 220, 230, 240, 250, 260, 261, 264, 265, 401, 420, 430, 491)', True);
    //DoSQL('Update Form6 set col_10 = col_2 - col_6 - col_9', True);

    AddField('FORM6', 'COL_10T', 'Text(100)');
    AddField('FORM6', 'COL_12T', 'Text(100)');

    AddField('ORG', 'KODOKTMO2', 'Text(11)');
    AddField('ORG', 'REGPLACE', 'Text(100)');
    AddField('ORG', 'COMPUTERS', 'Integer');
    AddField('ORG', 'SOFTWARENUM', 'Integer');
    AddField('ORG', 'SOFTWARE', 'Text(255)');
    AddField('TPDPCond', 'Sex', 'Byte');

    DoSQL('UPDATE (org inner join kregpl on kregpl.regpl_id = org.regpl_id) SET regplace = regpl_name', True);
    DoSQL('Insert Into KDelayType (ID, DelayType) Values (5, ''по другим причинам'')', True);

    DoSQL('Drop View PDP', True);
    DoSQL(
      'Create View PDP As '#13+
      'SELECT TPDPPost.Post_ID AS POST_ID, TPDPCond.Limited AS Limited, TPDPCond.Age AS Age, TPDPCond.WRange AS WRange, TPDPCond.WSost AS WSost, KWRange.ChE AS ChE, '#13+
      'TPDPCond.Sex As Sex '#13+
      'FROM (TPDPPost INNER JOIN (TPDP INNER JOIN TPDPCond ON TPDP.id=TPDPCond.TPDP_ID) ON TPDPPost.TPDP_ID=TPDP.id) LEFT JOIN KWRANGE ON TPDPCond.WRange=KWRANGE.WRNG_ID',
    True);

    DoSQL('Drop View PersonreservChkInfoBase', True);
    DoSQL(
      'Create View PersonreservChkInfoBase As '#13+
      'SELECT '#13+
      '  P.PERS_ID, P.IS_WAR, P.W_DEND, P.SpecialWUchet1, P.BIRTHDAY, P.Male, R.CHE, R.LIMIT1, '#13+
      '  IIf(ISNULL(P.WUCHET2),0,1) AS Reserved, IIf(AppointmentLast.WTP_ID=1,1,0) AS MainWork, '#13+
      '  IIf(AppointmentLast.WCH_ID=1,1,0) AS PermanentWork, '#13+
      '  IIf(IIf(ISNULL(StaffList.WartimePlan),0,StaffList.WartimePlan)>0,1,0) AS WARTIME, '#13+
      '  IIF(EXISTS(SELECT * FROM KDEFVUS WHERE NAME = left(P.VUS, IIF((select state from KWRANGE where WRNG_ID = P.WRNG_ID) = 3, 6, 3))), 1,0) AS DefVUS, '#13+
      '  IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300), 1,0) AS Command300, '#13+
      '  P.EOARMY_DATE AS EOARMY_YEAR, '#13+
      '  IIF(EXISTS( '#13+
      '    SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLast.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      PDP.WSOST LIKE "%."&P.WSOST_ID&".%" AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age < Year(Date())-Year(P.BIRTHDAY) And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ),1,0) AS DefPOST '#13+
      'FROM ((Person AS P LEFT JOIN AppointmentLast ON P.PERS_ID=AppointmentLast.PERS_ID) LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) LEFT JOIN StaffList ON (AppointmentLast.POST_ID=StaffList.POST_ID) AND (AppointmentLast.DEP_ID=StaffList.DEP_ID) '
    );

//7
    DoSQL('alter table VV5 Alter NAME Text(100)', True);
    DoSQL('UPDATE VV5 SET NAME = ''Федеральные органы исполнительной власти (ФОИВ)'' WHERE KOD = ''01''', True);
    DoSQL('UPDATE VV5 SET NAME = ''Субъекты РФ'' WHERE KOD = ''04''', True);
    DoSQL('UPDATE Org SET SBM_ID = 4 Where SBM_ID in (2,3)', True);
    DoSQL('Delete From VV5 Where ID in (2,3)', True);

    DoSQL('UPDATE KWSOST SET WSOST_NAME = ''инженерный и технический'' WHERE WSOST_ID = 5', True);
    DoSQL('UPDATE KWSOST SET WSOST_NAME = ''гуманитарный'' WHERE WSOST_ID = 7', True);
    DoSQL('UPDATE PERSON SET WSOST_ID = 7 WHERE WSOST_ID = 9', True);
    DoSQL('UPDATE PERSON SET WSOST_ID = 10 WHERE WSOST_ID = 11', True);
    DoSQL('DELETE From KWSOST WHERE WSOST_ID = 9', True);
    DoSQL('DELETE From KWSOST WHERE WSOST_ID = 11');
//8
    DoSQL('Update VerInfo Set '+
          'VerStr = ''3.76'', VerDesc = ''Версия релиза 3.76'', VerDate = #27/10/2010#');
  finally Free;
  end;
end;

end.

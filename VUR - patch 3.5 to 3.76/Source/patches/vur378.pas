unit vur378;

interface

type
  KOPF = record
    old: Integer;
    new: Integer;
    name: String;
  end;


  function Patch378_GetInfo: string;
  function Patch378_GetStepCount: Integer;
  procedure Patch378_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs;


const okopf: array [1..105] of KOPF = (
(old:39;new:10000;name:'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ КОММЕРЧЕСКИМИ ОРГАНИЗАЦИЯМИ'),
(old:48;new:11000;name:'Хозяйственные товарищества'),
(old:-1;new:12000;name:'Хозяйственные общества'),
(old:51;new:11051;name:'Полные товарищества'),
(old:64;new:11064;name:'Товарищества на вере (коммандитные товарищества)'),
(old:65;new:12165;name:'Общества с ограниченной ответственностью'),
(old:66;new:12166;name:'Общества с дополнительной ответственностью'),
(old:60;new:12200;name:'Акционерные общества'),
(old:47;new:12247;name:'Открытые акционерные общества'),
(old:67;new:12267;name:'Закрытые акционерные общества'),
(old:61;new:13000;name:'Хозяйственные партнерства'),
(old:52;new:14100;name:'Сельскохозяйственные производственные кооперативы'),
(old:-1;new:14153;name:'Сельскохозяйственные артели (колхозы)'),
(old:-1;new:14154;name:'Рыболовецкие артели (колхозы)'),
(old:-1;new:14155;name:'Кооперативные хозяйства (коопхозы)'),
(old:-1;new:14200;name:'Производственные кооперативы (кроме сельскохозяйственных производственных кооперативов)'),
(old:53;new:19000;name:'Прочие юридические лица, являющиеся коммерческими организациями'),
(old:40;new:15000;name:'Унитарные предприятия'),
(old:42;new:15200;name:'Унитарные предприятия, основанные на праве хозяйственного ведения'),
(old:-1;new:15241;name:'Федеральные государственные унитарные предприятия'),
(old:-1;new:15242;name:'Государственные унитарные предприятия субъектов Российской Федерации'),
(old:-1;new:15243;name:'Муниципальные унитарные предприятия'),
(old:41;new:15100;name:'Унитарные предприятия, основанные на праве оперативного управления (казенные предприятия)'),
(old:-1;new:15141;name:'Федеральные казенные предприятия'),
(old:-1;new:15142;name:'Казенные предприятия субъектов Российской Федерации'),
(old:-1;new:15143;name:'Муниципальные казенные предприятия'),
(old:70;new:20000;name:'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ НЕКОММЕРЧЕСКИМИ ОРГАНИЗАЦИЯМИ'),
(old:85;new:20100;name:'Потребительские кооперативы'),
(old:-1;new:20101;name:'Гаражные и гаражно-строительные кооперативы'),
(old:-1;new:20102;name:'Жилищные и жилищно-строительные кооперативы'),
(old:-1;new:20103;name:'Жилищные накопительные кооперативы'),
(old:-1;new:20104;name:'Кредитные потребительские кооперативы'),
(old:-1;new:20105;name:'Кредитные потребительские кооперативы граждан'),
(old:-1;new:20106;name:'Кредитные кооперативы второго уровня'),
(old:-1;new:20107;name:'Потребительские общества'),
(old:-1;new:20109;name:'Сельскохозяйственные потребительские перерабатывающие кооперативы'),
(old:-1;new:20110;name:'Сельскохозяйственные потребительские сбытовые (торговые) кооперативы'),
(old:-1;new:20111;name:'Сельскохозяйственные потребительские обслуживающие кооперативы'),
(old:-1;new:20112;name:'Сельскохозяйственные потребительские снабженческие кооперативы'),
(old:-1;new:20113;name:'Сельскохозяйственные потребительские садоводческие кооперативы'),
(old:-1;new:20114;name:'Сельскохозяйственные потребительские огороднические кооперативы'),
(old:-1;new:20115;name:'Сельскохозяйственные потребительские животноводческие кооперативы'),
(old:-1;new:21002;name:'Садоводческие, огороднические или дачные потребительские кооперативы'),
(old:83;new:20200;name:'Общественные организации (объединения)'),
(old:-1;new:20201;name:'Политические партии'),
(old:-1;new:20202;name:'Профсоюзные организации'),
(old:-1;new:20905;name:'Общественные учреждения'),
(old:-1;new:20300;name:'Религиозные организации'),
(old:84;new:20210;name:'Общественные движения'),
(old:88;new:20400;name:'Фонды'),
(old:-1;new:20401;name:'Благотворительные фонды'),
(old:-1;new:20402;name:'Негосударственные пенсионные фонды'),
(old:-1;new:20403;name:'Общественные фонды'),
(old:-1;new:20404;name:'Экологические фонды'),
(old:81;new:20900;name:'Учреждения'),
(old:71;new:20906;name:'Частные учреждения'),
(old:-1;new:20902;name:'Благотворительные учреждения'),
(old:-1;new:20908;name:'Учреждения религиозных организаций'),
(old:72;new:20903;name:'Бюджетные учреждения'),
(old:-1;new:20907;name:'Учреждения академий наук'),
(old:-1;new:28003;name:'Государственные академии наук'),
(old:73;new:20901;name:'Автономные учреждения'),
(old:74;new:20904;name:'Казенные учреждения'),
(old:82;new:28005;name:'Государственные корпорации'),
(old:-1;new:28004;name:'Государственные компании'),
(old:78;new:20211;name:'Органы общественной самодеятельности'),
(old:96;new:20500;name:'Некоммерческие партнерства'),
(old:-1;new:21003;name:'Садоводческие, огороднические или дачные некоммерческие партнерства'),
(old:-1;new:28002;name:'Адвокатские бюро'),
(old:97;new:28001;name:'Автономные некоммерческие организации'),
(old:93;new:20600;name:'Объединения юридических лиц'),
(old:-1;new:20601;name:'Ассоциации (союзы) экономического взаимодействия субъектов Российской Федерации'),
(old:-1;new:20603;name:'Советы муниципальных образований субъектов Российской Федерации'),
(old:-1;new:20604;name:'Союзы (ассоциации) кредитных кооперативов'),
(old:-1;new:20605;name:'Союзы (ассоциации) кооперативов'),
(old:-1;new:20606;name:'Союзы (ассоциации) общественных объединений'),
(old:-1;new:20607;name:'Союзы (ассоциации) общин малочисленных народов'),
(old:-1;new:20608;name:'Союзы потребительских обществ'),
(old:77;new:28013;name:'Объединения (союзы) крестьянских (фермерских) хозяйств'),
(old:80;new:28017;name:'Территориальные общественные самоуправления'),
(old:94;new:28016;name:'Товарищества собственников жилья'),
(old:76;new:21001;name:'Садоводческие, огороднические или дачные некоммерческие товарищества'),
(old:89;new:28006;name:'Казачьи общества'),
(old:-1;new:28007;name:'Коллегии адвокатов'),
(old:-1;new:28008;name:'Общества взаимного страхования'),
(old:-1;new:28010;name:'Общины коренных малочисленных народов'),
(old:-1;new:28012;name:'Объединения работодателей'),
(old:-1;new:28014;name:'Отделения иностранных некоммерческих неправительственных организаций'),
(old:-1;new:20801;name:'Адвокатские палаты'),
(old:-1;new:20802;name:'Нотариальные палаты'),
(old:-1;new:20803;name:'Торгово-промышленные палаты'),
(old:-1;new:29000;name:'Иные некоммерческие организации, не включенные в другие группировки'),
(old:99;new:30000;name:'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ОРГАНИЗАЦИЙ, СОЗДАННЫХ БЕЗ ПРАВ ЮРИДИЧЕСКОГО ЛИЦА'),
(old:92;new:30005;name:'Паевые инвестиционные фонды'),
(old:87;new:30006;name:'Простые товарищества'),
(old:90;new:30001;name:'Представительства юридических лиц'),
(old:-1;new:30002;name:'Филиалы юридических лиц'),
(old:-1;new:30003;name:'Обособленные подразделения юридических лиц'),
(old:-1;new:30004;name:'Структурные подразделения обособленных подразделений юридических лиц'),
(old:95;new:50101;name:'Главы крестьянских (фермерских) хозяйств'),
(old:98;new:40001;name:'Межправительственные международные организации'),
(old:-1;new:40002;name:'Неправительственные международные организации'),
(old:91;new:50102;name:'Индивидуальные предприниматели'),
(old:-1;new:50201;name:'Адвокаты, учредившие адвокатский кабинет'),
(old:-1;new:50202;name:'Нотариусы, занимающиеся частной практикой'));


function Patch378_GetInfo: string;
begin
  Result :=
   'Версия 3.78:'#13;
end;

function Patch378_GetStepCount: Integer;
begin
  Result := 3;
end;

procedure Patch378_Process;
var
  Q, QQ: TADOQuery;
  i, id, idid: Integer;
  pf: KOPF;
  s: String;

  procedure DoSQL(const ASQL: String; const NoCount: Boolean = False);
  begin
    with Q do
    try
      SQL.Text := ASQL;
      ExecSQL;
    except on e: Exception do showmessage(e.message); end;
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
  QQ := TADOQuery.Create(fmMain);
  QQ.Connection := fmMain.dbConn; QQ.ParamCheck := False;
  with Q do
  try
    Connection := fmMain.dbConn; ParamCheck := False;

    fmMain.lbProcState.Caption := 'добавление учета АСФ...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//
      AddField('PERSON','Med_Where','VARCHAR(40) NULL');
      AddField('PERSON','Med_Date','DateTime NULL');
      AddField('PERSON','Med_Result','Varchar(100) NULL');
      AddField('PERSON','Psy_Where','VARCHAR(40) NULL');
      AddField('PERSON','Psy_Date','DateTime NULL');
      AddField('PERSON','Psy_Result','Varchar(100) NULL');
      AddField('PERSON','Asf_Sport','Varchar(40) NULL');

      AddField('ASAppointment','Asf_Id','Int NULL');
      AddField('ASAppointment','Attested_Id','Int NULL');
      AddField('ASAppointment','Training_Date_Out','DateTime NULL');
      AddField('ASAppointment','Attested_Who','Varchar(100) NULL');
      AddField('ASAppointment','Attested_Date','DateTime NULL');

      AddField('ORG','ASFGround_Id','Int NULL');
      AddField('ORG','ASFType_Id','Int NULL');
      AddField('ORG','KOPF_CHANGED','Bit   NULL');

      AddField('ASF','ASFType_Id','Int NULL');
      AddField('ASF','[Zone]','Varchar(250) NULL');

      AddField('KDepart','IS_ASF','bit NULL');
      AddField('KL_DATA','IS_ASF','Int NULL');

      DoSQL('Alter Table KL_FLD Alter  DEF_VALUE Varchar(255)', True);

      DoSQL('Create table KASFQualif (' +
            'ID Int NOT NULL Primary Key,' +
            'Name Varchar(50) NULL' +
            ')', True);
      DoSQL('Insert Into KASFQualif (ID, Name) Values (1, "Не аттестован")', True);
      DoSQL('Insert Into KASFQualif (ID, Name) Values (2, "Спасатель")', True);
      DoSQL('Insert Into KASFQualif (ID, Name) Values (3, "Спасатель третьего класса")', True);
      DoSQL('Insert Into KASFQualif (ID, Name) Values (4, "Спасатель второго класса")', True);
      DoSQL('Insert Into KASFQualif (ID, Name) Values (5, "Спасатель первого класса")', True);
      DoSQL('Insert Into KASFQualif (ID, Name) Values (6, "Спасатель международного класса")', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (37, "KASFQualif", "Классы квалификации спасателей и дополнительных специальностей в АСФ", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (139, 37, "ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(ID)+1 FROM KASFQualif}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (140, 37, "Name", "Наименование", 200, 0, 1, 1, ' +
            'null, 0)', True);

      DoSQL('Create table KASDNR (' +
            'ID Int NOT NULL Primary Key,' +
            'Name Varchar(100) NULL' +
            ')', True);
      DoSQL('Insert Into KASDNR (ID, Name) Values (1, "Поисково-спасательные")', True);
      DoSQL('Insert Into KASDNR (ID, Name) Values (2, "Горноспасательные")', True);
      DoSQL('Insert Into KASDNR (ID, Name) Values (3, "Газоспасательные")', True);
      DoSQL('Insert Into KASDNR (ID, Name) Values (4, "Противофонтанные работы (на буровых и нефтяных скважинах)")', True);
      DoSQL('Insert Into KASDNR (ID, Name) Values (5, "Аварийно-спасательные работы, связанные с тушением пожаров")', True);
      DoSQL('Insert Into KASDNR (ID, Name) Values (6, "Работы по ликвидации медико-санитарных последствий чрезвычайных ситуаций")', True);
      DoSQL('Insert Into KASDNR (ID, Name) Values (7, "Другие")', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (38, "KASDNR", "Виды аварийно-спасательных и других неотложных работ в зоне ЧС (АСДНР)", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (141, 38, "ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(ID)+1 FROM KASDNR}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (142, 38, "Name", "Наименование", 200, 0, 1, 1, ' +
            'null, 0)', True);

      DoSQL('Create table KASFGround (' +
            'ID Int NOT NULL Primary Key,' +
            'Name Varchar(200) NULL' +
            ')', True);
      DoSQL('Insert Into KASFGround (ID, Name) Values (1, "<значение не определено (нет оснований)>")', True);
      DoSQL('Insert Into KASFGround (ID, Name) Values (2, "Наличие в организации объектов, отнесенных к категории опасных")', True);
      DoSQL('Insert Into KASFGround (ID, Name) Values (3, "Организация отнесена к категории по гражданской обороне")', True);
      DoSQL('Insert Into KASFGround (ID, Name) Values (4, "Организация переводится на работу в условиях военного времени")', True);
      DoSQL('Insert Into KASFGround (ID, Name) Values (5, "Организация расположена в опасной зоне")', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (39, "KASFGround", "Виды оснований для создания АСФ в организации", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (143, 39, "ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(ID)+1 FROM KASFGround}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (144, 39, "Name", "Наименование", 200, 0, 1, 1, ' +
            'null, 0)', True);

      DoSQL('Create table KASFMtr (' +
            'ID Int NOT NULL Primary Key,' +
            'ShortName Varchar(50) NULL,' +
            'Name Varchar(100) NULL,' +
            'Tech bit NULL '+
            ')', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (1, "Средства индивидуальной защиты")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (2, "Медицинское имущество")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (3, "Средства радиационной, химической и биологической разведки и контроля")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (4, "Средства спецобработки")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (5, "Инженерное имущество")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (6, "Средства связи")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (7, "Пожарное имущество")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (8, "Культпросветимущество")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (9, "Тыловое имущество продовольственного снабжения")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (10, "Тыловое имущество вещевого снабжения")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (11, "Автотранспорт")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (12, "Дорожно-строительная и подъемно-транспортная техника")', True);
      DoSQL('Insert Into KASFMtr (ID, Name) Values (13, "Специальная техника")', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (40, "KASFMtr", "Виды МТР, используемых для оснащения АСФ", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (145, 40, "ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(ID)+1 FROM KASFMtr}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (146, 40, "Name", "Наименование", 200, 0, 1, 1, ' +
            'null, 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (147, 40, "ShortName", "Краткое наименование", 100, 0, 1, 1, ' +
            'null, 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (159, 40, "Tech", "Технический", 50, 0, 1, 1, ' +
            'null, 1)', True);

      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (148, 34, "ASFType_Id", "Вид назначения АСФ", 200, 0, 1, 0, ' +
            '"{LU:SELECT 1 As ID, ''Общего назначения'' As Name From Org Union SELECT 2 As ID, ''Специального назначения'' As Name From Org}", 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (149, 34, "Zone", "Зона ответственности", 250, 0, 1, 1, ' +
            'null, 1)', True);

      DoSQL('Create table KASFMtrSub (' +
            'ID Int NOT NULL Primary Key,' +
            'KAsfMtr_Id int NOT NULL,' +
            'Name Varchar(60) NULL' +
            ')', True);
      DoSQL('Insert Into KASFMtrSub (ID, KAsfMtr_Id, Name) Values (1, 11, "Легковые автомобили")', True);
      DoSQL('Insert Into KASFMtrSub (ID, KAsfMtr_Id, Name) Values (2, 11, "Грузовые автомобили")', True);
      DoSQL('Insert Into KASFMtrSub (ID, KAsfMtr_Id, Name) Values (3, 12, "Бульдозеры")', True);
      DoSQL('Insert Into KASFMtrSub (ID, KAsfMtr_Id, Name) Values (4, 12, "Экскаваторы")', True);
      DoSQL('Insert Into KASFMtrSub (ID, KAsfMtr_Id, Name) Values (5, 12, "Автокраны")', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (41, "KASFMtrSub", "Подвиды МТР", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (150, 41, "ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(ID)+1 FROM KASFMtrSub}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (151, 41, "KAsfMtr_Id", "Вид МТР", 200, 0, 1, 0, ' +
            '"{LU:SELECT ID, Name From KASFMtr}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (152, 41, "Name", "Наименование", 200, 0, 1, 1, ' +
            'null, 0)', True);

      DoSQL('Create table ASFMtr (' +
            'ID Int NOT NULL Primary Key,' +
            'KAsfMtr_Id int NOT NULL,' +
            'KAsfMtrSub_Id int NULL,' +
            'EdIzm Varchar(20) NULL,' +
            'ShortName Varchar(30) NULL,' +
            'FullName Varchar(60) NULL' +
            ')', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (42, "ASFMtr", "МТР, используемые для оснащения АСФ", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (153, 42, "ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(ID)+1 FROM ASFMtr}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (154, 42, "KAsfMtr_Id", "Вид МТР", 200, 0, 1, 0, ' +
            '"{LU:SELECT ID, Name From KASFMtr}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (155, 42, "KAsfMtrSub_Id", "Подвид МТР", 200, 0, 1, 0, ' +
            '"{LU:SELECT ID, Name, KAsfMtr_Id From KASFMtrSub}{FLT:KAsfMtr_Id,KAsfMtr_Id}", 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (156, 42, "EdIzm", "Единица измерения", 100, 0, 1, 1, ' +
            'null, 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (157, 42, "ShortName", "Краткое наименование", 150, 0, 1, 1, ' +
            'null, 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (158, 42, "FullName", "Полное наименование", 200, 0, 1, 1, ' +
            'null, 1)', True);
      // FLD_ID 159 - см. KAsfMtr
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (160, 11, "IS_ASF", "Относится к АСФ", 50, 0, 1, 1, ' +
            'null, 1)', True);


      DoSQL('Create table ORG_AHOV (' +
            'ID Counter NOT NULL Primary Key,' +
            'AHOV_Naim Varchar(100) NOT NULL,' +
            'AHOV_Amount Varchar(100) NULL' +
            ')', True);

      DoSQL('Create table ORG_Asdnr_Attest (' +
            'ID Counter NOT NULL Primary Key,' +
            'Asdnr_Id int NULL,' +
            'Asf_Id Int NULL,' +
            'Who_Attest Varchar(100) NULL,' +
            'When_Attest DateTime NULL' +
            ')', True);

      DoSQL('Create table ORG_Asdnr_Made (' +
            'ID Counter NOT NULL Primary Key,' +
            'Asdnr_Id int NULL,' +
            'Content Varchar(100) NULL,' +
            'Date_Begin DateTime NULL,' +
            'Date_End DateTime NULL' +
            ')', True);

      DoSQL('Create table ORG_Buildings (' +
            'ID Counter NOT NULL Primary Key,' +
            'Naim Varchar(100) NULL,' +
            'Purpose Varchar(100) NULL,' +
            'Area Varchar(100) NULL,' +
            'Comment Varchar(100) NULL' +
            ')', True);

      DoSQL('Create table ORG_MTR (' +
            'ID Counter NOT NULL Primary Key,' +
            'KAsfMtr_Id int NOT NULL,' +
            'AsfMtr_Id int NOT NULL,' +
            'Dep_Id int NULL,' +
            'Amount Number NULL,' +
            'AmountAsf Number NULL,' +
            'AmountVs Number NULL' +
            ')', True);

      DoSQL('Create table ASMtrList (' +
            'ASP_ID INTEGER NOT NULL,' +
            'AsfMtr_ID INTEGER NOT NULL,' +
            'GeneralPlan INTEGER NULL,' +
            'GeneralQty INTEGER NULL,' +
            'GeneralVacancy INTEGER NULL' +
            ')', True);

      DoSQL('Create Procedure AsfDepAndMtr As '+
            'SELECT ASP.ASP_ID, ASF.OrgSName+" "+ASP.Dep_NAME AS DEP_NAME, '+
              'AsfMtr.ID As AsfMtr_Id, Iif(IsNull(AsfMtr.ShortName), AsfMtr.FullName, AsfMtr.ShortName) As MtrName '+
            'FROM AsfMtr, ASP INNER JOIN ASF ON ASP.ASF_ID=ASF.ASF_ID '+
            'union '+
            'SELECT -ASF.ASF_ID as ASP_ID, ASF.OrgSName AS DEP_NAME, AsfMtr.ID AS AsfMtr_Id, IIf(IsNull(AsfMtr.ShortName),AsfMtr.FullName,AsfMtr.ShortName) AS MtrName '+
            'FROM AsfMtr, ASF ', True);

      DoSQL('Create View AsfMtrListFull As '+
            'SELECT AsfDepAndMtr.ASP_ID, AsfDepAndMtr.DEP_NAME, AsfDepAndMtr.AsfMtr_Id, AsfDepAndMtr.MtrName, '+
              'ASMtrList.GeneralPlan, ASMtrList.GeneralQty, ASMtrList.GeneralVacancy '+
            'FROM AsfDepAndMtr LEFT JOIN ASMtrList ON (AsfDepAndMtr.[ASP_ID] = ASMtrList.[ASP_ID]) AND (AsfDepAndMtr.[AsfMtr_Id] = ASMtrList.[AsfMtr_Id])',
            True);

      DoSQL('Create View AsfMtrListAll As '+
            'SELECT AsfMtrListFull.ASP_ID, AsfMtrListFull.DEP_NAME, AsfMtrListFull.AsfMtr_Id, AsfMtrListFull.MtrName, '+
              'IIf(IsNull(AsfMtrListFull.GeneralPlan),0,AsfMtrListFull.GeneralPlan) AS GeneralPlan, '+
              'IIf(IsNull(AsfMtrListFull.GeneralQty),0,AsfMtrListFull.GeneralQty) AS GeneralQty, '+
              'IIf(IsNull(AsfMtrListFull.GeneralVacancy),0,AsfMtrListFull.GeneralVacancy) AS GeneralVacancy, '+
              'Sum(AmountAsf) AS QtyAll '+
              'FROM AsfMtrListFull '+
              'LEFT JOIN Org_Mtr '+
                'ON (AsfMtrListFull.AsfMtr_Id = Org_Mtr.AsfMtr_Id) '+
              'GROUP BY AsfMtrListFull.ASP_ID, AsfMtrListFull.DEP_NAME, AsfMtrListFull.AsfMtr_Id, AsfMtrListFull.MtrName, AsfMtrListFull.GeneralPlan, AsfMtrListFull.GeneralQty, AsfMtrListFull.GeneralVacancy',
              True);

      DoSQL('Drop Table ASDepAndPost', True);
      DoSQL('Create View ASDepAndPost As '+
            'Select * from ( '+
            'SELECT ASP.ASP_ID, ASF.OrgSName+" "+ASP.Dep_NAME AS DEP_NAME, ASPOST.ASPOST_ID, ASPOST.POST_NAME, ASF.ASF_ID '+
            'FROM ASPOST, ASP INNER JOIN ASF ON ASP.ASF_ID=ASF.ASF_ID '+
            'union '+
            'SELECT -ASF.ASF_ID as ASP_ID, ASF.OrgSName+" (штаб)", ASPOST.ASPOST_ID, ASPOST.POST_NAME, ASF.ASF_ID '+
            'FROM ASPOST, ASF '+
            ') as x', True);

      DoSQL('Drop Table ASStaffListFull', True);
      DoSQL('Create View ASStaffListFull As '+
            'SELECT ASDepAndPost.ASP_ID, ASDepAndPost.ASF_ID, ASDepAndPost.DEP_NAME, ASDepAndPost.ASPOST_ID, ASDepAndPost.POST_NAME, '+
            '  ASStaffList.GeneralPlan, ASStaffList.GeneralQty, ASStaffList.GeneralVacancy '+
            'FROM ASDepAndPost LEFT JOIN ASStaffList ON (ASDepAndPost.[ASPOST_ID] = ASStaffList.[ASPOST_ID]) AND (ASDepAndPost.[ASP_ID] = ASStaffList.[ASP_ID])', True);

      DoSQL('Drop Table ASStaffListAll', True);
      DoSQL('Create View ASStaffListAll As '+
            'SELECT ASStaffListFull.ASP_ID, ASStaffListFull.ASF_ID, ASStaffListFull.DEP_NAME, ASStaffListFull.ASPOST_ID, ASStaffListFull.POST_NAME, '+
            '  IIf(IsNull(ASStaffListFull.GeneralPlan),0,ASStaffListFull.GeneralPlan) AS GeneralPlan, '+
            '  IIf(IsNull(ASStaffListFull.GeneralQty),0,ASStaffListFull.GeneralQty) AS GeneralQty, '+
            '  IIf(IsNull(ASStaffListFull.GeneralVacancy),0,ASStaffListFull.GeneralVacancy) AS GeneralVacancy, '+
            '  Count(IIf(PERSON.PERS_ID Is Not Null And (PERSON.ASOUT_DATE Is Null Or PERSON.ASOUT_DATE>Date()),1,Null)) AS QtyAll '+
            'FROM ASStaffListFull LEFT JOIN (ASAppointmentLastAll LEFT JOIN PERSON ON ASAppointmentLastAll.PERS_ID = PERSON.PERS_ID) ON (ASStaffListFull.ASPOST_ID = ASAppointmentLastAll.ASPOST_ID) AND (ASStaffListFull.ASP_ID = ASAppointmentLastAll.ASP_ID) '+
            'GROUP BY ASStaffListFull.ASP_ID, ASStaffListFull.ASF_ID, ASStaffListFull.DEP_NAME, ASStaffListFull.ASPOST_ID, ASStaffListFull.POST_NAME, ASStaffListFull.GeneralPlan, ASStaffListFull.GeneralQty, ASStaffListFull.GeneralVacancy', True);

      DoSQL('Drop Table ASAppointmentLastAll', True);
      DoSQL('Create View ASAppointmentLastAll As '+
            'SELECT ASAppointment.*, ASPX.ASF_Id As ASFX_Id '+
            'FROM (ASAppointment INNER JOIN ASAppointmentMaxIn_DateAll ON ASAppointment.ID = ASAppointmentMaxIn_DateAll.[Max-ID]) '+
            'left outer join (select ASP_ID, ASF_ID, DEP_NAME from ASP union select -ASF_ID, ASF_ID, iif(ASF.ORGSName="",ASF.ORGName, ASF.ORGSName) from ASF) as ASPX on ASAppointment.ASP_Id=[ASPX].ASP_Id');

      DoSQL('Update KL_DATA Set Disp_Name = "Виды оснований для бронирования" Where KL_NAME = "VV3"', True);
      DoSQL('Update KL_DATA Set Disp_Name = "Виды подчиненности организации" Where KL_NAME = "VV5"', True);
      DoSQL('Update KL_DATA Set IS_ASF = 1 Where KL_ID in (34, 35, 36, 37, 38, 39, 40, 41, 42)');

    fmMain.lbProcState.Caption := 'изменение данных...';
    Application.ProcessMessages;

    AddField('PERSON','Mob_Days','Int NULL');
    AddField('PERSON','Mob_Hours','Int NULL');
    AddField('PERSON','Mob_Mins','Int NULL');
    AddField('PERSON','Mob_CardDate','DateTime NULL');
    AddField('PERSON','Mob_MissReason','Varchar(255) NULL');
    AddField('PERSON','WUCHET2_Ser','Varchar(50) NULL');
    AddField('PERSON','WUCHET2_IsWork','Int NULL');
    AddField('PERSON','PDPCode','Varchar(50) NULL');
    AddField('PersonChanges','Appointment_Id','Int NULL');

    DoSQL('Alter Table TPDPCond Alter WSOST Varchar(100)', True);

    DoSQL('Update KWSOST Set WSOST_NAME = ''военно-гуманитарный'' Where WSOST_ID = 7', True);
    DoSQL('Insert Into KWSOST (WSOST_ID, WSOST_NAME, STATE) Values ( 8, ''педагогический'', 3)', True);
    DoSQL('Insert Into KWSOST (WSOST_ID, WSOST_NAME, STATE) Values ( 9, ''юридический'', 3)', True);
    DoSQL('Insert Into KWSOST (WSOST_ID, WSOST_NAME, STATE) Values (11, ''ветеринарный'', 3)', True);
    DoSQL('Insert Into KWSOST (WSOST_ID, WSOST_NAME, STATE) Values (17, ''-гуманитарный'', 3)', True);
    DoSQL('UPDATE PERSON SET WSOST_ID = 17 WHERE WSOST_ID = 7', True);
    DoSQL('UPDATE TPDPCond SET WSOST = WSost+''17.'' WHERE Instr(wsost, ''.7.'') > 0', True);


    DoSQL('Drop View PersonreservChkInfoBase', True);
    DoSQL(
      'Create View PersonreservChkInfoBase As '#13+
      'SELECT '#13+
      '  P.PERS_ID, P.IS_WAR, P.W_DEND, P.SpecialWUchet1, P.BIRTHDAY, P.Male, R.CHE, R.LIMIT1, '#13+
      '  iif(IsNull(P.WUCHET2_IsWork),0,P.WUCHET2_IsWork) AS Reserved, '#13+
      '  IIf(AppointmentLastAll.WTP_ID in (1,3,9),1,0) AS MainWork, '#13+
      '  IIf(AppointmentLastAll.WCH_ID=1,1,0) AS PermanentWork, '#13+
      '  IIf(IIf(ISNULL(StaffList.WartimePlan),0,StaffList.WartimePlan)>0,1,0) AS WARTIME, '#13+
      '  IIF(EXISTS(SELECT * FROM KDEFVUS WHERE NAME = left(P.VUS, IIF((select state from KWRANGE where WRNG_ID = P.WRNG_ID) = 3, 6, 3))), 1,0) AS DefVUS, '#13+
      '  IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300), 1,0) AS Command300, '#13+
      '  P.EOARMY_DATE AS EOARMY_YEAR, '#13+
      '  IIF(EXISTS( '#13+
      '    SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age < Year(Date()-P.BirthDay)-1899 And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ),1,0) AS DefPOST, '#13+


      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age < Year(Date()-P.BirthDay)-1899 And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE (PDP.POST_ID = AppointmentLastAll.POST_ID)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age < Year(Date()-P.BirthDay)-1899 And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_Post, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age < Year(Date()-P.BirthDay)-1899 And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE  (PDP.WRange=0 OR PDP.CHE >= R.CHE)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      PDP.Age < Year(Date()-P.BirthDay)-1899 And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_WRange, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age < Year(Date()-P.BirthDay)-1899 And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE (InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age < Year(Date()-P.BirthDay)-1899 And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_WSost '#13+


      'FROM ((Person AS P LEFT JOIN AppointmentLastAll ON P.PERS_ID=AppointmentLastAll.PERS_ID) '#13+
      'LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) '#13+
      'LEFT JOIN StaffList ON (AppointmentLastAll.POST_ID=StaffList.POST_ID) AND (AppointmentLastAll.DEP_ID=StaffList.DEP_ID) '
    , True);

    DoSQL('DROP view PersonreservChkInfo',True);
    DoSQL('CREATE VIEW PersonreservChkInfo AS '#13#10+
    'SELECT PERS_ID, Reserved, MainWork, PermanentWork, WARTIME, DefVUS, Command300, EOARMY_YEAR, DefPOST,'#13 +
    ' DefPOST_WRange, DefPOST_Post, DefPOST_WSost, '#13 +
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
    'FROM PersonReservChkInfoBase;', True);

    DoSQL('Drop View PDP', True);
    DoSQL(
      'Create View PDP As '#13+
      'SELECT '#13+
        'TPDPPost.Post_ID AS POST_ID, TPDPCond.Limited AS Limited, TPDPCond.Age AS Age, TPDPCond.WRange AS WRange, TPDPCond.WSost AS WSost, KWRANGE.ChE AS ChE, TPDPCond.Sex AS Sex, '#13+
        'TPDP.Per_No, TPDP.Razd_No, TPDP.Podrazd_No, TPDP.PUNKT '#13+
      'FROM (TPDPPost '#13+
      'INNER JOIN (TPDP INNER JOIN TPDPCond ON TPDP.id = TPDPCond.TPDP_ID) '#13+
        'ON TPDPPost.TPDP_ID = TPDP.id) '#13+
      'LEFT JOIN KWRANGE ON TPDPCond.WRange = KWRANGE.WRNG_ID'
    , True);

    DoSQL('DROP VIEW PersonReserv', True);
    DoSQL('CREATE VIEW PersonReserv AS SELECT PERSON.PERS_ID '+
          'FROM PersonToCount AS PERSON '+
          'WHERE (((PERSON.WUCHET2_IsWork)=1))',True);

    DoSQL('Update Person Set WUchet2_IsWork = 1 Where iif(IsNull(WUchet2), '''', WUchet2) <> ''''', True);

    id := -1;
    Q.SQL.Text :=
      'Select  P.Pers_Id, '+
      '          Per_No+''.''+Razd_No+''.''+Podrazd_No+''.''+PUNKT as PDPCode '+
      'From (((Person P inner join AppointmentLastAll on AppointmentLastAll.pers_id = P.Pers_id) '+
      '            LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) '+
      '            Left Join PDP on PDP.POST_ID = AppointmentLastAll.POST_ID) '+
      '         WHERE '+
      '            (PDP.Limited = 0 OR P.WCAT="В") AND '+
      '            InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '+
      '            (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '+
      '            PDP.Age < Year(Date()-P.BirthDay)-1899 And '+
      '            ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '+
      ' Order By 1,2';
    Q.Open;
    while not Q.Eof do begin
      if id <> Q.Fields[0].AsInteger then begin
        QQ.SQL.Text := 'Update Person Set PDPCode = '''+Q.Fields[1].AsString+''' Where Pers_Id = '+Q.Fields[0].AsString;
        QQ.ExecSQL;
        id := Q.Fields[0].AsInteger;
      end;
      Q.Next;
    end;
    Q.Close;

    DoSQL('Alter Table KUZ Alter UZ_NAME Varchar(255)', True);
    DoSQL('Alter Table KOPF Alter KOD Varchar(5)', True);
    AddField('KOPF','KOD_OLD','Varchar(2)');
    DoSQL('Update KOPF Set KOD_OLD = KOD', True);
    DoSQL('Alter Table KEDUC Alter ED_NAME Varchar(255)', True);
    DoSQL('Alter Table KEDUC Alter OKIN_NAME Varchar(255)', True);

    q.SQL.Text := 'Select max(kopf_id) from KOPF';
    q.Open;
    id := q.Fields[0].AsInteger + 1;
    q.Close;
    q.SQL.Text := 'Select * from KOPF';
    q.Open;
    for i := 1 to 105 do begin
      pf := okopf[i];
      if (pf.old < 0) or not q.Locate('kod', IntToStr(pf.old), []) then begin
        q.Append;
        q.FieldByName('KOPF_ID').AsInteger := id;
        Inc(id);
      end else
        q.Edit;
      q.FieldByName('KOPF_NAME').AsString := pf.name;
      q.FieldByName('KOD').AsString := IntToStr(pf.new);
      if pf.new = 10000 then idid := q.FieldByName('KOPF_ID').AsInteger;
      q.Post;
    end;
    q.Close;

    q.SQL.Text := 'Select kod from KOPF inner join Org on kopf.KOPF_ID = org.kopf_id';
    q.Open;
    s := q.Fields[0].AsString;
    q.Close;
    if Length(Trim(s)) < 5 then
      DoSQL('Update ORG Set KOPF_ID = '+IntToStr(idid), True);
    DoSQL('Delete from KOPF Where Len(Kod) < 5', True);

    DoSQL('select * into Form6Tmp from Form6', True);
    DoSQL('Delete from Form6Tmp', True);

    DoSQL('Create Table ReplacePlan ( '+
      'Id counter primary key,'+
      'Pers_Id int,'+
      'Depart varchar(255),'+
      'Post Varchar(255),'+
      'FIO varchar(255),'+
      'war varchar(255),'+
      'Repl_Pers_Id int) '
      , True);


    DoSQL('Update KFState Set OKIN = null, OKIN_NAME = null Where FST_ID = 1', True);
    DoSQL('Insert Into KFState (FST_ID, FST_Name, OKIN, OKIN_NAME) Values ('+
      '4, ''Вдовец (вдова)'', 100004, ''Вдовец (вдова)'')', True);
    DoSQL('Insert Into KFState (FST_ID, FST_Name, OKIN, OKIN_NAME) Values ('+
      '5, ''Разведен (разведена)'', 100005, ''Разведен (разведена)'')', True);
    DoSQL('Insert Into KFState (FST_ID, FST_Name, OKIN, OKIN_NAME) Values ('+
      '6, ''Разошелся (разошлась)'', 100006, ''Разошелся (разошлась)'')', True);
    DoSQL('Insert Into KFState (FST_ID, FST_Name, OKIN, OKIN_NAME) Values ('+
      '7, ''Никогда не состоял (состояла) в браке'', 100001, ''Никогда не состоял (состояла) в браке'')', True);

    DoSQL('Update KL_Data set Disp_Name = ''Образовательные уровни'' where KL_Name = ''KEDUC''', True);
    DoSQL('Update KEduc set Ed_Name = ''Начальное общее образование'', OKIN_Name = ''Начальное общее образование'' '+
          'where OKIN = ''300002''', True);
    DoSQL('Update KEduc set Ed_Name = ''Среднее общее образование'', OKIN_Name = ''Среднее общее образование'' '+
          'where OKIN = ''300007''', True);
    DoSQL('Update KEduc set Ed_Name = ''Среднее профессиональное образование рабочих (служащих)'', OKIN_Name = ''Среднее профессиональное образование по программам подготовки квалифицированных рабочих (служащих)'' '+
          'where OKIN = ''300010''', True);
    DoSQL('Update KEduc set Ed_Name = ''Среднее профессиональное образование специалистов'', OKIN_Name = ''Среднее профессиональное образование по программам подготовки специалистов среднего звена'' '+
          'where OKIN = ''300011''', True);
    DoSQL('Update KEduc set Ed_Name = ''Высшее образование - подготовка кадров высшей квалификации'', '+
                           'OKIN_Name = ''Высшее образование - подготовка кадров высшей квалификации по программам подготовки научно-педагогических кадров в аспирантуре (адъюнктуре), ординатуре, ассистентуре-стажировке'' '+
          'where OKIN = ''300019''', True);
    DoSQL('Update KEduc set OKIN = null where OKIN in (''300015'',''300018'')', True);
    DoSQL('Insert Into KEduc (Ed_Id, Ed_Name, OKIN, Okin_Name) Values ('+
          '11, ''Высшее образование - бакалавриат'',''300018'',''Высшее образование - бакалавриат'')', True);
    DoSQL('Insert Into KEduc (Ed_Id, Ed_Name, OKIN, Okin_Name) Values ('+
          '12, ''Высшее образование - специалитет или магистратура'',''300018'',''Высшее образование - специалитет или магистратура'')', True);

    DoSQL('Update KWRange set M_Limit = 60, Limit1 = 50, Limit2 = 55, Limit3 = 60 Where Wrng_Id in (10,11,12,13,29)', True);
    DoSQL('Update KWRange set M_Limit = 65, Limit1 = 55, Limit2 = 60, Limit3 = 65 Where Wrng_Id in (14,15,30,31)', True);
    DoSQL('Update KWRange set M_Limit = 65, ZapState = 4, Limit1 = 60, Limit2 = 65 Where Wrng_Id in (16,32)', True);
    DoSQL('Update KWRange set M_Limit = 70, ZapState = 5, Limit1 = 65, Limit2 = 70 Where Wrng_Id in (17,18,19,20,33,34,35,36)', True);

    DoSQL('Insert Into Params (Param_Id, Param_Name, Param_Value) Values (6, ''Сортировка по алфавиту'', ''1'')', True);


      DoSQL('Update VerInfo Set '+
          'VerStr = ''3.78'', VerDesc = ''Версия релиза 3.78'', VerDate = #1/4/2013#');


  finally Free;
  end;
end;

end.

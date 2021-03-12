unit vur379;

interface

  function Patch379_GetInfo: string;
  function Patch379_GetStepCount: Integer;
  procedure Patch379_Process;

type
  KOPF = record
    old: Integer;
    new: Integer;
    name: String;
  end;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;

const okopf: array [1..76] of KOPF = (
(old:12165;new:12300;name:'Общества с ограниченной ответственностью'),
(old:15000;new:65000;name:'Унитарные предприятия'),
(old:15100;new:65100;name:'Унитарные предприятия, основанные на праве оперативного управления (казенные предприятия)'),
(old:15141;new:65141;name:'Федеральные казенные предприятия'),
(old:15142;new:65142;name:'Казенные предприятия субъектов Российской Федерации'),
(old:15143;new:65143;name:'Муниципальные казенные предприятия'),
(old:15200;new:65200;name:'Унитарные предприятия, основанные на праве хозяйственного ведения'),
(old:15241;new:65241;name:'Федеральные государственные унитарные предприятия'),
(old:15242;new:65242;name:'Государственные унитарные предприятия субъектов Российской Федерации'),
(old:15243;new:65243;name:'Муниципальные унитарные предприятия'),
(old:20300;new:71500;name:'Религиозные организации'),
(old:20400;new:70400;name:'Фонды'),
(old:20401;new:70401;name:'Благотворительные фонды'),
(old:20402;new:70402;name:'Негосударственные пенсионные фонды'),
(old:20403;new:70403;name:'Общественные фонды'),
(old:20404;new:70404;name:'Экологические фонды'),
(old:20500;new:20614;name:'Некоммерческие партнерства'),
(old:20801;new:20609;name:'Адвокатские палаты'),
(old:20802;new:20610;name:'Нотариальные палаты'),
(old:20803;new:20611;name:'Торгово-промышленные палаты'),
(old:20900;new:75000;name:'Учреждения'),
(old:21001;new:20701;name:'Садоводческие, огороднические или дачные некоммерческие товарищества'),
(old:21002;new:20120;name:'Садоводческие, огороднические или дачные потребительские кооперативы'),
(old:21003;new:20617;name:'Садоводческие, огороднические или дачные некоммерческие партнерства'),
(old:28001;new:71400;name:'Автономные некоммерческие организации'),
(old:28002;new:20615;name:'Адвокатские бюро'),
(old:28003;new:75300;name:'Государственные академии наук'),
(old:28004;new:71602;name:'Государственные компании'),
(old:28005;new:71601;name:'Государственные корпорации'),
(old:28007;new:20616;name:'Коллегии адвокатов'),
(old:28008;new:20108;name:'Общества взаимного страхования'),
(old:28010;new:21200;name:'Общины коренных малочисленных народов Российской Федерации'),
(old:28012;new:20612;name:'Объединения работодателей'),
(old:28014;new:71610;name:'Отделения иностранных некоммерческих неправительственных организаций'),
(old:28016;new:20716;name:'Товарищества собственников жилья'),
(old:28017;new:20217;name:'Территориальные общественные самоуправления'),
(old:10000;new:10000;name:'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ КОММЕРЧЕСКИМИ КОРПОРАТИВНЫМИ ОРГАНИЗАЦИЯМИ'),
(old:12247;new:12247;name:'Публичные акционерные общества'),
(old:12267;new:12267;name:'Непубличные акционерные общества'),
(old:20000;new:20000;name:'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ НЕКОММЕРЧЕСКИМИ КОРПОРАТИВНЫМИ ОРГАНИЗАЦИЯМИ'),
(old:20102;new:20102;name:'Жилищные или жилищно-строительные кооперативы'),
(old:20200;new:20200;name:'Общественные организации'),
(old:20600;new:20600;name:'Ассоциации (союзы)'),
(old:-1;new:20121;name:'Фонды проката'),
(old:-1;new:20613;name:'Объединения фермерских хозяйств'),
(old:-1;new:20618;name:'Ассоциации (союзы) садоводческих, огороднических и дачных некоммерческих объединений'),
(old:-1;new:20619;name:'Саморегулируемые организации'),
(old:-1;new:20620;name:'Объединения (ассоциации и союзы) благотворительных организаций'),
(old:-1;new:20700;name:'Товарищества собственников недвижимости'),
(old:-1;new:21100;name:'Казачьи общества, внесенные в государственный реестр казачьих обществ в Российской Федерации'),
(old:-1;new:30008;name:'Районные суды, городские суды, межрайонные суды (районные суды)'),
(old:-1;new:60000;name:'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ КОММЕРЧЕСКИМИ УНИТАРНЫМИ ОРГАНИЗАЦИЯМИ'),
(old:-1;new:70000;name:'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ НЕКОММЕРЧЕСКИМИ УНИТАРНЫМИ ОРГАНИЗАЦИЯМИ'),
(old:-1;new:71600;name:'Публично-правовые компании'),
(old:-1;new:75100;name:'Учреждения, созданные Российской Федерацией'),
(old:-1;new:75101;name:'Федеральные государственные автономные учреждения'),
(old:-1;new:75103;name:'Федеральные государственные бюджетные учреждения'),
(old:-1;new:75104;name:'Федеральные государственные казенные учреждения'),
(old:-1;new:75200;name:'Учреждения, созданные субъектом Российской Федерации'),
(old:-1;new:75201;name:'Государственные автономные учреждения субъектов Российской Федерации'),
(old:-1;new:75203;name:'Государственные бюджетные учреждения субъектов Российской Федерации'),
(old:-1;new:75204;name:'Государственные казенные учреждения субъектов Российской Федерации'),
(old:-1;new:75400;name:'Учреждения, созданные муниципальным образованием (муниципальные учреждения)'),
(old:-1;new:75401;name:'Муниципальные автономные учреждения'),
(old:-1;new:15300;name:'Крестьянские (фермерские) хозяйства'),
(old:29000;new:-1;name:'Иные некоммерческие организации, не включенные в другие группировки'),
(old:28013;new:-1;name:'Объединения (союзы) крестьянских (фермерских) хозяйств'),
(old:28006;new:-1;name:'Казачьи общества'),
(old:20901;new:-1;name:'Автономные учреждения'),
(old:20902;new:-1;name:'Благотворительные учреждения'),
(old:20903;new:-1;name:'Бюджетные учреждения'),
(old:20904;new:-1;name:'Казенные учреждения'),
(old:20905;new:-1;name:'Общественные учреждения'),
(old:20906;new:-1;name:'Частные учреждения'),
(old:20907;new:-1;name:'Учреждения академий наук'),
(old:20908;new:-1;name:'Учреждения религиозных организаций')
);

const okopf_old: array [1..105] of KOPF = (
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


function Patch379_GetInfo: string;
begin
  Result :=
   'Версия 3.79'#13;
end;

function Patch379_GetStepCount: Integer;
begin
  Result := 3;
end;

procedure Patch379_Process;
var
  Q, QQ: TADOQuery;
  i, id, idid: Integer;
  pf: KOPF;
  s: String;
  is_need: Boolean;

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

    fmMain.lbProcState.Caption := '...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//
      DoSQL('Create table KOKPDTR (' +
            'KOKPDTR_ID Int NOT NULL Primary Key,' +
            'KOKPDTR_Code Varchar(10) NOT NULL ,' +
            'KOKPDTR_NAME Varchar(100) Not NULL' +
            ')', True);
      DoSQL('Create table Form6_2015 (' +
            'CPROF_ID Int NOT NULL Primary Key,' +
            'F6_ID Int, '+
            'Print_NAME Varchar(100), ' +
            'Expression Varchar(100), ' +
            'Calculate Int, '+
            'Col_B Int, '+
            'Col_1 Int, '+
            'Col_2 Int, '+
            'Col_3 Int, '+
            'Col_4 Int, '+
            'Col_5 Int, '+
            'Col_6 Int, '+
            'Col_7 Int, '+
            'Col_8 Int, '+
            'Col_9 Int, '+
            'Col_10 Int, '+
            'Col_11 Int, '+
            'Col_12 Int, '+
            'Col_13 Int, '+
            'Col_14 Int, '+
            'Col_15 Int, '+
            'Col_16 Varchar(50), '+
            'Col_10T Varchar(100), '+
            'Col_12T Varchar(100) '+
            ')', True);
      DoSQL('Create table Form6Hdr_2015 (' +
            'F6_ID Int NOT NULL Primary Key,' +
            'OrgId Int, '+
            'OrgName Varchar(250), ' +
            'F6_SHIFR Varchar(2), ' +
            'Org_SHIFR Varchar(10), ' +
            'F6_COUNT Int, '+
            'KUO_COUNT Int, '+
            'RAB_COUNT Int, '+
            'ZAP_COUNT Int, '+
            'ZAB_COUNT Int, '+
            'ConfDate DateTime, '+
            'Checked Int '+
            ')', True);
      DoSQL('Insert Into Form6Hdr_2015 '+
        '(F6_ID, OrgId, OrgName, F6_SHIFR, Org_SHIFR, F6_COUNT, KUO_COUNT, RAB_COUNT, ZAP_COUNT, ZAB_COUNT, ConfDate, Checked) '+
        'Select '+
        ' F6_ID, OrgId, OrgName, F6_SHIFR, Org_SHIFR, F6_COUNT, KUO_COUNT, RAB_COUNT, ZAP_COUNT, ZAB_COUNT, ConfDate, Checked  '+
        'From Form6Hdr', True);

      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (43, "KOKPDTR", "Выписка из ОКПДТР", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (161, 43, "KOKPDTR_ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(KOKPDTR_ID)+1 FROM KOKPDTR}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (162, 43, "KOKPDTR_Code", "Код по ОКПДТР", 200, 0, 1, 1, ' +
            'null, 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (163, 43, "KOKPDTR_NAME", "Наименование по ОКПДТР", 200, 0, 1, 1, ' +
            'null, 0)', True);

      AddField('KPOST','KOKPDTR','Int NULL');
      AddField('KPOST','CPROF2015_ID','Int NULL');
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (164, 4, "KOKPDTR", "ОКПДТР", 200, 0, 1, 0, ' +
            '"{LU:SELECT KOKPDTR_ID, KOKPDTR_Code+"" ""+KOKPDTR_NAME From KOKPDTR Order by KOKPDTR_Code}", 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (165, 4, "CPROF2015_ID", "Категория должности", 200, 0, 1, 0, ' +
            '"{LU:SELECT CPROF_ID, CPROF_NAME From KCPROF2015 WHERE STATE=0}", 1)', True);
      DoSQL('Update KL_FLD Set DISP_NAME = "Категория должности 2014 г" Where KL_ID = 4 and FLD_NAME = "CPROF_ID"', True);

      DoSQL('Create table KFormPrep (' +
            'KFormPrep_ID Int NOT NULL Primary Key,' +
            'KFormPrep_NAME Varchar(100) Not NULL' +
            ')', True);
      DoSQL('Insert Into KFormPrep (KFormPrep_ID, KFormPrep_NAME) Values (1,"аспирантура")');
      DoSQL('Insert Into KFormPrep (KFormPrep_ID, KFormPrep_NAME) Values (2,"адъюнктура")');
      DoSQL('Insert Into KFormPrep (KFormPrep_ID, KFormPrep_NAME) Values (3,"ординатура")');
      DoSQL('Insert Into KFormPrep (KFormPrep_ID, KFormPrep_NAME) Values (4,"докторантура")');

      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (44, "KFormPrep", "Формы подготовки кадров высшей квалификации", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (166, 44, "KFormPrep_ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(KFormPrep_ID)+1 FROM KFormPrep}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (167, 44, "KFormPrep_NAME", "Наименование", 200, 0, 1, 1, ' +
            'null, 0)', True);


      DoSQL('Create table KObrDoc (' +
            'KObrDoc_ID Int NOT NULL Primary Key,' +
            'KObrDoc_NAME Varchar(100) Not NULL' +
            ')', True);
      DoSQL('Insert Into KObrDoc (KObrDoc_ID, KObrDoc_NAME) Values (1,"диплом")');
      DoSQL('Insert Into KObrDoc (KObrDoc_ID, KObrDoc_NAME) Values (2,"свидетельство")');
      DoSQL('Insert Into KObrDoc (KObrDoc_ID, KObrDoc_NAME) Values (3,"аттестат")');
      DoSQL('Insert Into KObrDoc (KObrDoc_ID, KObrDoc_NAME) Values (4,"удостоверение")');
      DoSQL('Insert Into KObrDoc (KObrDoc_ID, KObrDoc_NAME) Values (5,"справка")');

      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (45, "KObrDoc", "Документы об образовании", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (168, 45, "KObrDoc_ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(KObrDoc_ID)+1 FROM KObrDoc}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (169, 45, "KObrDoc_NAME", "Наименование", 200, 0, 1, 1, ' +
            'null, 0)', True);


      AddField('TPDP','OKVED','varchar(8) NULL');
      AddField('TPDP','KOKPDTR','Int NULL');

      DoSQL('Drop View PDP', True);
      DoSQL(
        'Create View PDP As '#13+
        'SELECT  '#13+
          'KPost.Post_ID AS POST_ID, TPDPCond.Limited AS Limited, TPDPCond.Age AS Age, TPDPCond.WRange AS WRange, TPDPCond.WSost AS WSost, KWRANGE.ChE AS ChE, TPDPCond.Sex AS Sex, '#13+
          'TPDP.OKVED, TPDP.KOKPDTR, KOKPDTR.KOKPDTR_Code, KOKPDTR.KOKPDTR_Name '#13+
        'FROM ((KPost '#13+
        'INNER JOIN (TPDP '#13+
        'INNER JOIN TPDPCond ON TPDP.id = TPDPCond.TPDP_ID) '#13+
          'ON KPost.KOKPDTR = TPDP.KOKPDTR) '#13+
        'Inner Join KOKPDTR on KOKPDTR.KOKPDTR_Id = KPost.KOKPDTR) '#13+
        'LEFT JOIN KWRANGE ON TPDPCond.WRange = KWRANGE.WRNG_ID',
      True);

      DoSQL('Create table KCPROF2015 (' +
            'CPROF_ID Int NOT NULL Primary Key,' +
            'CPROF_NAME Varchar(100) Not NULL,' +
            'PRINT_NAME Varchar(100) Not NULL,' +
            'EXPRESSION Varchar(100) NULL,' +
            'STATE Int Not NULL,' +
            'LINE_NO Int NULL' +
            ')', True);
      DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '100 ,"Руководители", "Руководители", Null, 0, 1)', True);
      DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '200 ,"Специалисты", "Специалисты", Null, 0, 2)', True);
      DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '300 ,"Служащие", "Служащие", Null, 0, 3)', True);
      DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '400 ,"Рабочие", "Рабочие", "410+420", -1, 4)', True);
      DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '410 ,"Рабочие - водители", "из них водители", Null, 0, Null)', True);
      DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '420 ,"Прочие рабочие", "Прочие рабочие", Null, 0, Null)', True);
      DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '500 ,"Учащиеся", "Учащиеся", Null, 0, Null)', True);
      DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '1000 ,"Всего (сумма строк 1+2+3+4)", "Всего", "100+200+300+400", 1, 5)', True);
      {DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '1500 ,"По небронируемым организациям", "По небронируемым организациям", Null, 1, 6)', True);
      DoSQL('Insert Into KCPROF2015 (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) Values ('+
            '2000 ,"Всего (сумма строк 5+6)", "Всего", "1000+1500", 1, 7)', True);}

      SQL.Text :=
        'Update KPost Set CPROF2015_ID = '+
        'iif(CPROF_ID >= 200 and CPROF_ID < 300, 200, '+
        'iif(CPROF_ID = 470, 410, '+
        'iif(CPROF_ID >= 400 and CPROF_ID < 500, '+
        '420,CPROF_ID)))';
      ExecSQL;


    q.SQL.Text := 'Select * from KOPF';
    q.Open;
    if q.FindField('KOD_OLD') = nil then begin
        q.Close;

        DoSQL('Alter Table KOPF Alter KOD Varchar(5)', True);
        AddField('KOPF','KOD_OLD','Varchar(2)');
        DoSQL('Update KOPF Set KOD_OLD = KOD', True);

        q.SQL.Text := 'Select max(kopf_id) from KOPF';
        q.Open;
        id := q.Fields[0].AsInteger + 1;
        q.Close;
        q.SQL.Text := 'Select * from KOPF';
        q.Open;
        for i := 1 to 105 do begin
          pf := okopf_old[i];
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

    end;
    q.Close;


    AddField('KOPF','KOD_OLD2','Varchar(5)');
    DoSQL('Update KOPF Set KOD_OLD2 = KOD', True);

    q.SQL.Text := 'Select kod from KOPF inner join Org on kopf.KOPF_ID = org.kopf_id';
    q.Open;
    s := q.Fields[0].AsString;
    q.Close;
    is_need := False;
    q.SQL.Text := 'Select max(kopf_id) from KOPF';
    q.Open;
    id := q.Fields[0].AsInteger + 1;
    q.Close;
    q.SQL.Text := 'Select * from KOPF';
    q.Open;
    for i := 1 to Length(okopf) do begin
      pf := okopf[i];
      if pf.new < 0 then begin
        if s = IntTostr(pf.old) then
          is_need := True;
      end else begin
        if (pf.old < 0) or not q.Locate('KOD_OLD2', IntToStr(pf.old), []) then begin
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
    end;
    q.Close;

    if is_need then
      DoSQL('Update ORG Set KOPF_ID = '+IntToStr(idid), True);

    q.SQL.Text := 'Select * from KOPF';
    q.Open;
    for i := 1 to Length(okopf) do begin
      pf := okopf[i];
      if pf.new < 0 then begin
        if q.Locate('KOD_OLD2', IntToStr(pf.old), []) then begin
          q.Delete;
        end;
      end;
    end;
    q.Close;

    DoSQL('Update Params Set Param_Value = ''0'' Where Param_Id = 5', True);

      AddField('ORG','SBM','varchar(50) NULL');


    DoSQL('Update KEduc set OKIN = null where Ed_Id = 12', True);
    DoSQL('Insert Into KEduc (Ed_Id, Ed_Name, OKIN, Okin_Name) Values ('+
          '13, ''Высшее образование - специалитет'',''300018'',''Высшее образование - специалитет'')', True);
    DoSQL('Insert Into KEduc (Ed_Id, Ed_Name, OKIN, Okin_Name) Values ('+
          '14, ''Высшее образование - магистратура'',''300018'',''Высшее образование - магистратура'')', True);


    DoSQL('Insert Into Params (Param_Id, Param_Name, Param_Value) Values ('+
          '8, ''Подставлять к званию приставку «медицинской службы» или «юстиции»'',''1'')', True);

    DoSQL('Insert Into Params (Param_Id, Param_Name, Param_Value) Values ('+
          '9, ''Помещать числовые данные в п.15 формы № 18'',''1'')', True);

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
      '      PDP.Age <= '+FullAges('P.BirthDay', true)+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ),1,0) AS DefPOST, '#13+


      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay', true)+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE (PDP.POST_ID = AppointmentLastAll.POST_ID)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay', true)+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_Post, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay', true)+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE  (PDP.WRange=0 OR PDP.CHE >= R.CHE)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay', true)+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_WRange, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay', true)+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE (InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay', true)+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_WSost, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay', true)+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ('#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age > '+FullAges('P.BirthDay', true)+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      ')),0,1) AS DefPOST_Age '#13+


      'FROM ((Person AS P LEFT JOIN AppointmentLastAll ON P.PERS_ID=AppointmentLastAll.PERS_ID) '#13+
      'LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) '#13+
      'LEFT JOIN StaffList ON (AppointmentLastAll.POST_ID=StaffList.POST_ID) AND (AppointmentLastAll.DEP_ID=StaffList.DEP_ID) '
    , True);

    DoSQL('DROP view PersonreservChkInfo',True);
    DoSQL('CREATE VIEW PersonreservChkInfo AS '#13#10+
    'SELECT PERS_ID, Reserved, MainWork, PermanentWork, WARTIME, DefVUS, Command300, EOARMY_YEAR, DefPOST,'#13 +
    ' DefPOST_WRange, DefPOST_Post, DefPOST_WSost, DefPOST_Age, '#13 +
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


      DoSQL('Update VerInfo Set '+
          'VerStr = ''3.79'', VerDesc = ''Версия релиза 3.79'', VerDate = #8/7/2015#');

      AddField('Person','WRNG_Date','DateTime NULL');

      AddField('EDUC','ObrDoc_ID','int NULL');
      AddField('EDUC','DIPLOM_SER','varchar(50) NULL');
      AddField('EDUC','FormPrep_ID','int NULL');
      AddField('EDUC','END_DATE_GIVE','varchar(10) NULL');

  finally Free;
  end;
end;

end.

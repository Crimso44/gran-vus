unit vur372;

interface

  function Patch372_GetInfo: string;
  function Patch372_GetStepCount: Integer;
  procedure Patch372_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants;

function Patch372_GetInfo: string;
begin
  Result :=
   'Версия 3.72:'#13+
   '  - проведена оптимизация открытия окна штатного расписания'#13+
   '  - из окна лицензирования удалена кнопка "Удалить"'#13+
   '  - в справочнике ОКФС исправлены орфографические ошибки:'#13+
   '    "Собственность субъектов Росс_йи_ской Федерации"->"Собственность субъектов Российской Федерации"'#13+
   '    "Собственность росс_йи_ских граждан,..."->"Собственность российских граждан,..."'#13+
   '    "Совместная федеральная и иностранная собств_ы_енность"->"Совместная федеральная и иностранная собственность"'#13+
   '  - исправлены ошибки при расчёте данных по подразделениям и должностям'#13+
   '  - исправлена ошибка в подсчёте строки 2 "Специалисты всего" формы №6'#13+
   '  - исправления в отчёте "Форма сверки с военкоматам":'#13+
   '    теперь вместо рабочего телефона указывается домашний'#13+
   '    значение атрибута "Профессия по образованию" перенесено из столбца 13 "Должность" в столбец 10 "Образование"'#13+
   '  - исправлены неточности в определении обоснованности бронирования сотрудников категории годности "В"'#13+
   '  - обновлён справочник "Дефицитные ВУС"';
end;

function Patch372_GetStepCount: Integer;
begin
  Result := 12;
end;

procedure Patch372_Process;
//
  procedure UpdateKDefVus;
  const
    KDefVus: array [1..257] of String =
  ('060100','060102','060103','060105','060106','060300','060400','060600','060700','060800',
  '060900','060901','060902','061000','061001','061002','061003','061100','061200','061201',
  '061202','061203','061204','061600','061601','061602','061604','061606','061607','061608',
  '061609','061610','061900','061901','061902','061903','061904','061905','061906','061907',
  '062000','062001','062002','062003','062004','062005','062006','062200','062400','062600',
  '071500','072600','072700','090300','091500','091600','092000','092500','093000','093100',
  '093200','093300','093400','094100','094200','094300','094400','094500','094600','094700',
  '094800','094900','095000','095100','096000','096100','096200','121500','121502','121600',
  '121601','121602','121800','130100','130400','130401','130500','130600','130604','130605',
  '130607','131000','131100','131200','131300','132000','132001','132002','141000','141001',
  '141100','150100','151000','151001','151002','151003','151004','151005','151006','151007',
  '151008','300100','300102','390404','390405','390406','390413','390424','390425','390426',
  '390436','390437','390449','390460','445000','445001','445002','445003','461002','481701',
  '481801','490100','490101','490102','491000','491100','491201','491500','491600','491800',
  '495000','521300','521305','521306','521500','521602','521603','521900','530100','530200',
  '530201','530202','530300','530400','531000','531003','531100','531101','531102','531103',
  '541000','541001','901300','901301','901303','901304','901305','901306','901309','901310',
  '901311','901314','901500','902300','902302','904500','904502','904700','904702','905000',
  '905002','905200','905300','905400','057','105','107','131','132','133',
  '134','188','234','239','244','245','248','254','255','267',
  '268','342','353','379','381','382','383','384','385','406',
  '417','441','443','444','446','478','538','539','540','543',
  '544','549','550','551','552','553','554','570','583','585',
  '628','630','633','638','641','643','644','651','652','721',
  '763','764','783','786','804','805','903','905','925','930',
  '931','934','300101','531001','531002','252','253');
  var
    I, MaxI: Integer;
  begin
    with TADOQuery.Create(fmMain) do
    try
      Connection := fmMain.dbConn; ParamCheck := False;
      SQL.Text := 'select Max(ID) from KDefVUS';
      Open;
      MaxI := Fields[0].AsInteger;
      Close;
      SQL.Text := 'select ID,NAME,COMMENT from KDefVUS';
      Open;
      for I := Low(KDefVUS) to High(KDefVUS) do
        if VarIsNull(Lookup('NAME',KDefVus[I],'ID')) then
          AppendRecord([MaxI+I, KDefVus[I], 'обновление до версии 3.72']);
      Close;
    finally Free;
    end;
  end; //UpdateKDefVus
//
begin
  with TADOQuery.Create(fmMain) do
  try
    Connection := fmMain.dbConn; ParamCheck := False;
    fmMain.lbProcState.Caption := 'замена в справочнике ОКФС...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'update (select * from KFS where FS_NAME = ''Собственность субъектов Россйиской Федерации'') set FS_NAME = ''Собственность субъектов Российской Федерации''';
    ExecSQL;
    fmMain.pbMain.StepIt;//1
    SQL.Text := 'update (select * from KFS where FS_NAME = ''Собственность россйиских граждан, постоянно проживающих за границей'') set FS_NAME = ''Собственность российских граждан, постоянно проживающих за границей''';
    ExecSQL;
    fmMain.pbMain.StepIt;//2
    SQL.Text := 'update (select * from KFS where FS_NAME = ''Совместная федеральная и иностранная собствыенность'') set FS_NAME = ''Совместная федеральная и иностранная собственность''';
    ExecSQL;
    fmMain.pbMain.StepIt;//3
    fmMain.lbProcState.Caption := 'исправление подсчёта призывников в расчётных данных ...';
    SQL.Text := 'DROP VIEW PersonRecruit';
    ExecSQL;
    fmMain.pbMain.StepIt;//4
    SQL.Text := 'CREATE VIEW PersonRecruit AS SELECT [PERSON].[PERS_ID] FROM PERSON WHERE ([PERSON].[WRNG_ID]=1) And ([PERSON].[WCAT] In (''А'',''Б'',''В'')) And ([PERSON].[IS_WAR]=1)';
    ExecSQL;
    fmMain.pbMain.StepIt;//5
    fmMain.lbProcState.Caption := 'исправление подсчёта имеющих моб.предписание в расчётных данных ...';
    SQL.Text := 'DROP VIEW PersonMob';
    ExecSQL;
    fmMain.pbMain.StepIt;//6
    SQL.Text := 'CREATE VIEW PersonMob AS SELECT [PERSON].[PERS_ID] FROM PERSON WHERE ([PERSON].[WUCHET1]<>'''') And ([PERSON].[IS_WAR]=1)';
    ExecSQL;
    fmMain.pbMain.StepIt;//7
    fmMain.lbProcState.Caption := 'исправление подсчёта забронированных в расчётных данных ...';
    SQL.Text := 'DROP VIEW PersonReserv';
    ExecSQL;
    fmMain.pbMain.StepIt;//8
    SQL.Text := 'CREATE VIEW PersonReserv AS SELECT [PERSON].[PERS_ID] FROM PERSON WHERE ([PERSON].[WUCHET2]<>'''') And ([PERSON].[IS_WAR]=1)';
    ExecSQL;
    fmMain.pbMain.StepIt;//9
    fmMain.lbProcState.Caption := 'исправление в определении бронирования категории "В" ...';
    SQL.Text := 'DROP VIEW PersonReservChkInfo';
    ExecSQL;
    fmMain.pbMain.StepIt;//10
    SQL.Text := 'CREATE VIEW PersonReservChkInfo AS'#13+
                'SELECT P.PERS_ID,'#13+
                '       IIF(ISNULL(P.WUCHET2), 0,1) AS Reserved,'#13+
                '       IIF(AppointmentLast.WTP_ID=1, 1,0) AS MainWork,'#13+
                '       IIF(AppointmentLast.WCH_ID=1, 1,0) AS PermanentWork,'#13+
                '       IIF(IIF(ISNULL([StaffList].WartimePlan),0,[StaffList].WartimePlan)>0,1,0) AS WARTIME,'#13+
                '       IIF(P.VUS IN (SELECT NAME FROM KDEFVUS), 1,0) AS DefVUS,'#13+
                '       IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300), 1,0) AS Command300, P.EOARMY_DATE AS EOARMY_YEAR,'#13+
                '       IIF(EXISTS(SELECT * FROM PDP'#13+
                '                   WHERE PDP.POST_ID = AppointmentLast.POST_ID'#13+
                '                     AND (PDP.Limited = 0 OR P.WCAT=''В'')'#13+
                '                     AND PDP.WSOST LIKE ''%.''&P.WSOST_ID&''.%'''#13+
                '                     AND (PDP.WRange=0 OR PDP.CHE >= R.CHE)'#13+
                '                     AND PDP.Age < Year(Date())-Year(P.BIRTHDAY))'#13+
                '            ,1,0) AS DefPOST, IIF(P.IS_WAR<>1 OR not  ISNULL(P.W_DEND), 0,   IIF((not ISNULL(P.WUCHET2))<>('#13+
                '          (AppointmentLast.WTP_ID=1) and'#13+
                '          (AppointmentLast.WCH_ID=1) and'#13+
                '          (IIF(ISNULL([StaffList].WartimePlan),0,[StaffList].WartimePlan)>0) and'#13+
                '          (IIF(P.VUS IN (SELECT NAME FROM KDEFVUS),1,0)=0) and'#13+
                '          (IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300),1,0)=0) and'#13+
                '          (P.SpecialWUchet1<>1) and'#13+
                '          (ISNULL(P.EOARMY_DATE) or (P.Male<>1) or'#13+
                '           ((Len(P.EOARMY_DATE)=4) and ((Year(Date())-Val(P.EOARMY_DATE)) >=5) ) or'#13+
                '           ((Len(P.EOARMY_DATE)=10) and (IIF(Month(Date())<Month(DateValue(P.EOARMY_DATE)),'#13+
                '                Year(Date())-Year(DateValue(P.EOARMY_DATE))-1,'#13+
                '                IIF(Month(Date())>Month(DateValue(P.EOARMY_DATE)),'#13+
                '                  Year(Date())-Year(DateValue(P.EOARMY_DATE)),'#13+
                '                  IIF(Day(Date())<Day(DateValue(P.EOARMY_DATE)),'#13+
                '                     Year(Date())-Year(DateValue(P.EOARMY_DATE))-1,'#13+
                '                     Year(Date())-Year(DateValue(P.EOARMY_DATE)))))>=5)) or not ('#13+
                '           ((R.CHE<= 8)             and (Year(Date())-Year(P.BIRTHDAY)<=35)) or'#13+
                '           ((R.CHE IN (9,10,11,12)) and (Year(Date())-Year(P.BIRTHDAY)<=45)) or'#13+
                '           ((R.CHE IN (13,14))      and (Year(Date())-Year(P.BIRTHDAY)<=50)) or'#13+
                '           ((R.CHE =15)             and (Year(Date())-Year(P.BIRTHDAY)<=55)) or'#13+
                '           ((R.CHE >15)             and (Year(Date())-Year(P.BIRTHDAY)<=60)))'#13+
                '          ) and'#13+
                '          EXISTS(SELECT * FROM PDP'#13+
                '                   WHERE PDP.POST_ID = AppointmentLast.POST_ID'#13+
                '                     AND (PDP.Limited = 0 OR P.WCAT=''В'')'#13+
                '                     AND PDP.WSOST LIKE ''%.''&P.WSOST_ID&''.%'''#13+
                '                     AND (PDP.WRange=0 OR PDP.CHE >= R.CHE)'#13+
                '                     AND PDP.Age < Year(Date())-Year(P.BIRTHDAY))),1,0)) AS IS_BAD'#13+
                'FROM ((Person AS P LEFT JOIN AppointmentLast ON P.PERS_ID = AppointmentLast.PERS_ID)'#13+
                '       LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id)'#13+
                '       LEFT JOIN StaffList ON (AppointmentLast.POST_ID=[StaffList].POST_ID)'#13+
                '                          AND (AppointmentLast.DEP_ID=[StaffList].DEP_ID)'#13+
                '';
    ExecSQL;
    fmMain.pbMain.StepIt;//11
    fmMain.lbProcState.Caption := 'обновление справочника "Дефицитные ВУС" ...';
    UpdateKDefVus;
    fmMain.pbMain.StepIt;//12
  finally Free;
  end;
end;

end.

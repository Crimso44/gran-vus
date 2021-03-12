unit vur373;

interface

  function Patch373_GetInfo: string;
  function Patch373_GetStepCount: Integer;
  procedure Patch373_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants;

function Patch373_GetInfo: string;
begin
  Result :=
   'Версия 3.73:'#13+
   '  - В картотеке работников:'#13+
   '    дополнена разметка цветом: желтый - уволенные, серый - невоеннообязанные;'#13+
   '    в столбец "В разделе общего учета" или "В разделе спец. учета" помещается единица только если работник не уволен или не снят с учета;'#13+
   '    включены текущие должность и подразделение работника.'#13+
   '  - В карточке работника:'#13+
   '    на закладке "Общие сведения" добавлено поле "Дополнительные сведения";'#13+
   '    на закладке "Общие сведения" добавлено поле "зарегистр. с";'#13+
   '    на закладке "Образование" увеличена длина поля "Специальность";'#13+
   '    на закладке "Воинский учет":'#13+
   '        добавлено поле "Дата изменения";'#13+
   '        поле "Кат. запаса" может принимать значение 3 и у рядового и унтер-офицерского состава стало обязательным;'#13+
   '        "Кодовое обозн.ВУС" стало необязательным;'#13+
   '        добавлено поле выбора документа: военный билет, временное удостоверение, приписное свидетельство;'#13+
   '        добавлено поле "Группа учета", принимающее значения: РА, ВМФ, ФСБ, МВД.'#13+
   '  - В карточке организации:'#13+
   '    добавлено поле "ОВК";'#13+
   '    исправлено открытие окна по кнопке "Выписка из ПДП".'#13+
   '  - Проверке обоснованности бронирования при сверке со справочником дефицитных ВУС использует не строгое '+
   'совпадение ВУС в справочнике и карточке работника, а совпадение ВУС в справочнике с первыми символами в карточке.'#13+
   '  - В окне "Штатное расписание. Всего работающих" строке состояния отображаются наименования текущих строки '+
   'и столбца.'#13+
   '  - В окне "Расчетные данные по подразделениям и должностям" при расчёте не учитываются уволенные или '+
   'снятых с воинского учета работники.'#13+
   '  - В окне "Выписка из ПДП", в карточке "Пункт из ПДП":'#13+
   '    кнопка "Добавить новый пункт перечня" переименована в "Добавить новую группу условий в пункте";'#13+
   '    при сохранении, если пользователь не задал перечнь, раздел, подраздел, то '+
   'вместо "Поле .... не допускает ввод пустых строк" выдаётся сообщение "Задайте ...!" соответственно.'#13+
   '  - Во всех формах "Листок-сообщение в ОВК":'#13+
   '   	поле "Место жительства" разбито на "Зарегистрирован по адресу" и "Фактическое место жительства";'#13+
   '    поле "Адрес организации" разбито на "фактический"  и "юридический"'#13+
   '    в поле "Образование" к виду образования, через запятую добавлены вид, что и когда закончил, квалификация, '+
   'специальность, профессия'#13+
   '    в поле "Должность" добавлено "<дата вступления в должность> (№<номер приказа> от <дата приказа>)".'#13+
   '  - В печатной форме сверки данных с военкоматами в поле "Образование" к виду образования, через запятую '+
   'добавлены вид, что и когда закончил, квалификация, специальность, профессия.'#13+
   '  - В справочнике "Подразделения предприятия" добавлено поле "Полное наименование", а ранее существовавшее поле '+
   '"Наименование" названо "Краткое наименование".'#13+
   '  - В печатной форме Т-2:'#13+
   '    в поле "Дата регистрации по указанному месту жительства" добавлено значение <зарегистр. с>;'#13+
   '    добавлен код организации по ОКПО;'#13+
   '    добавлено поле "Дополнительные сведения";'#13+
   '    в поле "Дата составления" помещается значение поля "Дата постановки на учет" карточки работника;'#13+
   '    исправлена ошибка, возникавшая при незаполненном военно-учетном работнике в карточке организации;'#13+
   '    в поле "Структурное подразделение" раздела III "Прием на работу..." помещается '+
   'из справочника организаций, если не пусто, "Полное наименование", иначе - "Краткое наименование".'#13+
   '  - Печатная форма "Журнал учета форм Т-2" измененеа, сделаны сортировки: по номеру карточки, по фамилиям, '+
   'по подразделениям.'#13+
   '  - В печатной форме "Форма № 6 организации":'#13+
   '    слово "Секретно" заменено на "Гриф по заполнении";'#13+
   '    в числовой части таблицы размер шрифта изменён с 6 на 8.'#13+
   '  - Открыт доступ к пополнению словарей "ОКФС" и "Иностранные языки".'#13+
   '  - Исправлена ошибка вывода журнала событий в MS Word.'#13+
   '  - другие изменения и дополнения...';
end;

function Patch373_GetStepCount: Integer;
begin
  Result := 25;
end;

procedure Patch373_Process;
var Q: TADOQuery;
  procedure DoSQL(const ASQL: String; const NoCount: Boolean = False);
  begin
    with Q do begin
      SQL.Text := ASQL;
      ExecSQL;
    end;
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
    fmMain.pbMain.StepIt;//1
  end;
begin
  Q := TADOQuery.Create(fmMain);
  with Q do
  try
    Connection := fmMain.dbConn; ParamCheck := False;
    fmMain.lbProcState.Caption := 'обновление таблиц...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;

    DoSQL('alter table EDUC alter column NAPR varchar(100) NULL');//1
    AddField('ADDR','ADDR_DATE','datetime NULL');//2
    AddField('KDEPART','DEP_FULL_NAME','varchar(255) NULL');//3
    AddField('ORG','OVK_ID','INTEGER NULL');//4
    AddField('PERSON','Comments','varchar(255) NULL');//5
    AddField('PERSON','WUCHET2_date','datetime NULL');//6
    AddField('PERSON','Document','INTEGER NULL');//7
    AddField('PERSON','Branch','INTEGER NULL');//8

    DoSQL('update PERSON set Document = 2 where WRNG_ID = 1');//9

    fmMain.lbProcState.Caption := 'обновление запросов...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('CREATE VIEW PersonreservChkInfoBase AS '#13#10+//10
      'SELECT P.PERS_ID, P.IS_WAR, P.W_DEND, P.SpecialWUchet1, P.BIRTHDAY, P.Male, R.CHE, '+
      'IIf(ISNULL(P.WUCHET2),0,1) AS Reserved, IIf([AppointmentLast].[WTP_ID]=1,1,0) AS MainWork, '+
      'IIf([AppointmentLast].[WCH_ID]=1,1,0) AS PermanentWork, '+
      'IIf(IIf(ISNULL([StaffList].[WartimePlan]),0,[StaffList].[WartimePlan])>0,1,0) AS WARTIME, '+
      'IIF(EXISTS(SELECT * FROM KDEFVUS WHERE P.VUS LIKE NAME&"%"), 1,0) AS DefVUS, '+
      'IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300), 1,0) AS Command300, '+
      'P.EOARMY_DATE AS EOARMY_YEAR, '+
      'IIF(EXISTS(SELECT * FROM PDP '+
      '  WHERE PDP.POST_ID = AppointmentLast.POST_ID '+
      '    AND (PDP.Limited = 0 OR P.WCAT="В") '+
      '    AND PDP.WSOST LIKE "%."&P.WSOST_ID&".%" '+
      '    AND (PDP.WRange=0 OR PDP.CHE >= R.CHE) '+
      '    AND PDP.Age < Year(Date())-Year(P.BIRTHDAY)) '+
      '  ,1,0) AS DefPOST '+
      'FROM ((Person AS P LEFT JOIN AppointmentLast ON P.PERS_ID=[AppointmentLast].[PERS_ID]) '+
      'LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) '+
      'LEFT JOIN StaffList ON ([AppointmentLast].[DEP_ID]=[StaffList].[DEP_ID]) '+
      'AND ([AppointmentLast].[POST_ID]=[StaffList].[POST_ID]);');
    DoSQL('DROP view PersonReservChkInfo');//11
    DoSQL('CREATE view PersonReservChkInfo AS '#13#10+//12
      'SELECT PERS_ID, Reserved, MainWork, PermanentWork, WARTIME, DefVUS, Command300, EOARMY_YEAR, DefPOST, '+
      'IIF(IS_WAR<>1 or (not ISNULL(W_DEND) and W_DEND<=Date()), 0,'#13#10+
      '  IIF((Reserved=1)<>('#13#10+
      '          (MainWork=1) and'#13#10+
      '          (PermanentWork=1) and'#13#10+
      '          (WARTIME=1) and'#13#10+
      '          (DefVUS=0) and'#13#10+
      '          (Command300=0) and'#13#10+
      '          (SpecialWUchet1<>1) and'#13#10+
      '          (ISNULL(EOARMY_YEAR) or (Male<>1) or'#13#10+
      '           ((Len(EOARMY_YEAR)=4) and ((Year(Date())-Val(EOARMY_YEAR)) >=5) ) or'#13#10+
      '           ((Len(EOARMY_YEAR)=10) and (IIF(Month(Date())<Month(DateValue(EOARMY_YEAR)),'#13#10+
      '                Year(Date())-Year(DateValue(EOARMY_YEAR))-1,'#13#10+
      '                IIF(Month(Date())>Month(DateValue(EOARMY_YEAR)),'#13#10+
      '                  Year(Date())-Year(DateValue(EOARMY_YEAR)),'#13#10+
      '                  IIF(Day(Date())<Day(DateValue(EOARMY_YEAR)),'#13#10+
      '                     Year(Date())-Year(DateValue(EOARMY_YEAR))-1,'#13#10+
      '                     Year(Date())-Year(DateValue(EOARMY_YEAR)))))>=5)) or not ('#13#10+
      '           ((R.CHE<= 8)             and (Year(Date())-Year(BIRTHDAY)<=35)) or'#13#10+
      '           ((R.CHE IN (9,10,11,12)) and (Year(Date())-Year(BIRTHDAY)<=45)) or'#13#10+
      '           ((R.CHE IN (13,14))      and (Year(Date())-Year(BIRTHDAY)<=50)) or'#13#10+
      '           ((R.CHE =15)             and (Year(Date())-Year(BIRTHDAY)<=55)) or'#13#10+
      '           ((R.CHE >15)             and (Year(Date())-Year(BIRTHDAY)<=60)))'#13#10+
      '          ) and'#13#10+
      '          (DefPOST=1)),1,0)) AS IS_BAD'#13#10+
      'FROM PersonReservChkInfoBase;');
    DoSQL('DROP view AppointmentLast');//13
    DoSQL('CREATE view AppointmentLast AS '#13#10+//14
      'SELECT Appointment.* '+
      'FROM Appointment INNER JOIN AppointmentMaxIn_Date ON '+
      '(Appointment.PERS_ID = AppointmentMaxIn_Date.PERS_ID) AND '+
      '(Appointment.IN_DATE = AppointmentMaxIn_Date.[Max-IN_DATE]);');
    DoSQL('CREATE view PersonToCount AS '#13#10+//15
      'SELECT * '+
      'FROM PERSON '+
      'WHERE ([PERSON].[IS_WAR]=1) And '+
      '(ISNULL([PERSON].[W_DEND]) Or [PERSON].[W_DEND]>Date()) And '+
      '(ISNULL([PERSON].[OUT_DATE]) Or [PERSON].[OUT_DATE]>Date());');
    DoSQL('DROP view PersonMob');//16
    DoSQL('CREATE view PersonMob AS '#13#10+
      'SELECT [PERSON].[PERS_ID] FROM  PersonToCount as PERSON '+
      'WHERE [PERSON].[WUCHET1]<>"";');
    DoSQL('DROP view PersonRecruit');//17
    DoSQL('CREATE view PersonRecruit AS '#13#10+//18
      'SELECT [PERSON].[PERS_ID] FROM  PersonToCount as PERSON '+
      'WHERE ([PERSON].[WRNG_ID]=1) And '+
      '([PERSON].[WCAT] In ("А","Б","В"));');
    DoSQL('DROP view PersonReserv');//19
    DoSQL('CREATE view PersonReserv AS '#13#10+//20
      'SELECT [PERSON].[PERS_ID] FROM  PersonToCount as PERSON '+
      'WHERE [PERSON].[WUCHET2]<>"";');
    DoSQL('DROP view PersonWar');//21
    DoSQL('CREATE view PersonWar AS '#13#10+//22
      'SELECT [PERSON].[PERS_ID] FROM  PersonToCount as PERSON;');
    DoSQL('update (select * from KL_DATA where KL_NAME = ''KFS'') set IS_EDIT = 1');//23
    DoSQL('update (select * from KL_DATA where KL_NAME = ''KLANG'') set IS_EDIT = 1');//24
    DoSQL('create table VERSION373 (x integer not null)');//25
  finally Free;
  end;
end;

end.

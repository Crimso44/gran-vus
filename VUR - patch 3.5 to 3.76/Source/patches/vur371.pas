unit vur371;

interface

  function Patch371_GetInfo: string;
  function Patch371_GetStepCount: Integer;
  procedure Patch371_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry;

function Patch371_GetInfo: string;
begin
  Result :=
   'Версия 3.71:'#13+
   '  - из карточки организаций и из справочников убраны ОКОНХ'#13+
   '  - в мастере выборки теперь для строковых значений можно задавать условия'#13+
   '    "НАЧИНАЕТСЯ С" и "ЗАКАНЧИВАЕТСЯ НА"'#13+
   '  - появилясь возможность открывать выборку в новом окне'#13+
   '  - параметр выборки "Подлежит сниятию с учёта в этом году" переименован в'#13+
   '    "Состоит на учёте последний год"'#13+
   '  - при снятии с организации флага "ведёт бронирование" 6-я форма пересчитывается'#13+
   '  - пункт меню "\Расчётные данные\по категориям персонала и отношению к воинской повинности"'#13+
   '    переименован в "\Расчётные данные\по категориям персонала и отношению к воинской обязанности"'#13+
   '  - при заполнении формы №6 строка №2 теперь не пересчитывается автоматически'#13+
   '    при изменении строк 3-10'#13+
   '  - при проверке формы №6 теперь рассматривается значение строк 21-23 по'#13+
   '    отношению к строке 24'#13+
   '  - в справочнике воинских званий для генералов и адмиралов установлен врзраст 65'#13+
   '  - в персональной карточке добавлены поля "№ военного билета" и "Личный №"'#13+
   '  - в словаре должностей поле "Наименование по ОКПДТР" теперь не обязательное'#13+
   '  - словари "Виды работ", "Военный состав(профиль)", "Степень владения иностранным'#13+
   '    языком" и "Характер работы" теперь заполнены строчными буквами'#13+
   '  - в словаре иностранных языков оставлены только следующие языки: английский,'#13+
   '    испанский, итальянский, китайский, немецкий, персидский, финский, французский,'#13+
   '    шведский, японский'#13+
   '  - прочее...';
end;

function Patch371_GetStepCount: Integer;
begin
  Result := 7;
end;

procedure Patch371_Process;
begin
  with TADOQuery.Create(fmMain) do
  try
    Connection := fmMain.dbConn; ParamCheck := False;
//1
    fmMain.lbProcState.Caption := 'Удаление справочника ОКОНХ...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'delete from KL_FLD where KL_ID in (select KL_ID from KL_DATA where KL_NAME=''KONH'')';
    ExecSQL;
    SQL.Text := 'delete from KL_DATA where KL_NAME=''KONH''';
    ExecSQL;
    SQL.Text := 'drop table KONH';
    ExecSQL;
    fmMain.pbMain.StepIt;
//2
    fmMain.lbProcState.Caption := 'Изменение формул формы №6...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'update FORM6 set EXPRESSION=NULL where CPROF_ID=200';
    ExecSQL;
    SQL.Text := 'update KCPROF set EXPRESSION=NULL where CPROF_ID=200';
    ExecSQL;
    fmMain.pbMain.StepIt;
//3
    fmMain.lbProcState.Caption := 'Установка возраста для генералов и адмиралов...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'update KWRANGE set M_LIMIT=65, FEM_LIMIT=65 where STATE=3 and M_LIMIT is NULL';
    ExecSQL;
    fmMain.pbMain.StepIt;
//4
    fmMain.lbProcState.Caption := 'Добавление полей в персональную карточку...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'alter table PERSON add column WID VarChar(10)';
    ExecSQL;
    SQL.Text := 'alter table PERSON add column WBser VarChar(2)';
    ExecSQL;
    SQL.Text := 'alter table PERSON add column WBnum VarChar(8)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//5
    fmMain.lbProcState.Caption := 'Изменение аттрибутов словаря должностей...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'update  (select * from KL_FLD where KL_ID in '+
    '(select KL_ID from KL_DATA where KL_NAME = ''KPOST'') and FLD_NAME=''OKPDTR_NAME'')'+
    ' set HAS_NULL=1';
    ExecSQL;
    fmMain.pbMain.StepIt;
//6
    fmMain.lbProcState.Caption := 'Замена в словарях прописных букв строчными...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'update KWKTYPE set WTP_NAME=LCase(WTP_NAME)';
    ExecSQL;
    SQL.Text := 'update KWSOST  set WSOST_NAME=LCase(WSOST_NAME)';
    ExecSQL;
    SQL.Text := 'update KLANGSK set LSK_NAME=LCase(LSK_NAME)';
    ExecSQL;
    SQL.Text := 'update KWKCHAR set WCH_NAME=LCase(WCH_NAME)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//7
    fmMain.lbProcState.Caption := 'Сокращение словаря иностранных языков...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'delete from LANGS where LANG_ID in (select LANG_ID from'+
    ' KLANG where LANG_NAME not in ('+
    '''английский'',''испанский'',''итальянский'',''китайский'',''немецкий'','+
    '''персидский'',''финский'',''французский'',''шведский'',''японский''))';
    ExecSQL;
    SQL.Text := 'delete from KLANG where LANG_NAME not in ('+
    '''английский'',''испанский'',''итальянский'',''китайский'',''немецкий'','+
    '''персидский'',''финский'',''французский'',''шведский'',''японский'')';
    ExecSQL;
    fmMain.pbMain.StepIt;
  finally Free;
  end;
end;

end.

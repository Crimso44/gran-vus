library PersChanges;
{%File '..\SZ.INC'}

uses
  Forms,
  Controls,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  fParamDlg in 'fParamDlg.pas' {fmParamDlg},
  msg,
  SaveEvents,
  IniSupport;

{$R ResData.res}

function PlugInInfo(
  szName: PChar;
  szAuthor: PChar): Integer; stdcall;
// szName - заполняется наименованием плагина
// szAuthor - копирайт плагина
// ReturnValue - тип плагина
//    0 - общее назначение
//        function PlugInExec(AppHandle: THandle; szConn: _Connection): Integer; stdcall;
//    1 - для работы с карточкой организации
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nOrgID: Integer): Integer; stdcall;
//    2 - для работы с карточкой сотрудника
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nManID: Integer): Integer; stdcall;

begin
  {$I ..\SZ.INC}
  Result := 1;
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nOrgID: Integer): Integer; stdcall;
//  szConn - строка подключения к БД
//  nOrgID - код организации
var old_conn: _Connection;
begin
  Result := 0;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  old_conn := dmMain.dbMain.ConnectionObject;
    try
      dmMain.dbMain.ConnectionObject := Conn;
      dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);
      dmMain.IsJet := false;
      if Pos(WideString('Provider=Microsoft.Jet'), dmMain.dbMain.ConnectionString) > 0 then
        dmMain.IsJet := true;

//      with TADOQuery.Create(nil) do
//      try
//        Connection := dmMain.dbMain;
//        ParamCheck := False;
//        SQL.Text := 'SELECT Count(*) FROM PERS_SET';
//        Open;
//        if (Fields[0].AsInteger>0) and not Confirm(
//            '   ВНИМАНИЕ! Отчёт будет строится на подмножестве '+
//            'работников, ранее отобранном и сохранённом Вами для построения отчётов.'#13#13+
//            '   Для перехода к построению отчётов на всех имеющихся в ПЭВМ данных '+
//            'в картотеке работников выберите команду "Очистить набор".'#13#13+
//            '   Продолжить работу с отобранным набором работников?')
//        then
//          Exit;
//      finally Free;
//      end;

      with    TfmParamDlg.Create(Application) do
      try     if ShowModal<>mrOk then Exit;
      finally Free;
      end;

      if not dmMain.OpenData(nOrgID) then begin
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['Ошибка при обращении к базе данных.']);
        MessageBox(Application.Handle,
          'Ошибка при обращении к базе данных!',
          'Сведения об изменениях',MB_OK or MB_ICONERROR);
        Result := -1;
      end else
      if not dmMain.PrintData then begin
        Result := -2;
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['Ошибка при создании отчета.']);
        MessageBox(Application.Handle,
          'Ошибка при создании отчета!'+#13+
          'Возможно неверно указаны рабочие папки, '+#13+
          'шаблон отчета используется другой программой '+#13+
          'или файл-отчет уже открыт другой программой...',
          'Сведения об изменениях',MB_OK or MB_ICONERROR);
      end;
    finally
      if Assigned(dmMain) then dmMain.dbMain.ConnectionObject := old_conn;
      dmMain.Free;
    end;
  finally Application.Handle := 0;
  end;
end;

exports
  PlugInInfo, PlugInExec;

begin
end.

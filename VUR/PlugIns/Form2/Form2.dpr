library Form2;


uses
  Forms,
  Controls,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  msg,
  SaveEvents,
  IniSupport,
  BirthDay in '..\..\Common\BirthDay.pas';

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
  {$I SZ.INC}
  Result := 0;
end;

procedure PlugInSortInfo(szSortName: PChar); stdcall;
begin
  StrCopy(szSortName, 'Form02');
end;



function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection): Integer; stdcall;
//  szConn - строка подключения к БД
var old_conn: _Connection;
begin
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  old_conn := dmMain.dbMain.ConnectionObject;
    try
      dmMain.dbMain.ConnectionObject := Conn;
      dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);

      if not dmMain.PrintData then begin
        Result := -2;
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['Ошибка при создании отчета.']);
        MessageBox(Application.Handle,
          'Ошибка при создании отчета!'+#13+
          'Возможно неверно указаны рабочие папки, '+#13+
          'шаблон отчета используется другой программой '+#13+
          'или файл-отчет уже открыт другой программой...',
          sEventObject,MB_OK or MB_ICONERROR);
      end;
      Result := 0;
    finally
      if Assigned(dmMain) then dmMain.dbMain.ConnectionObject := old_conn;
      dmMain.Free;
    end;
  finally Application.Handle := 0;
  end;
end;

exports
  PlugInInfo, PlugInExec, PlugInSortInfo;

begin
end.

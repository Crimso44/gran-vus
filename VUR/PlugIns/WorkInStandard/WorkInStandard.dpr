library WorkInStandard;




uses
  Forms,
  Controls,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  fReportType in 'fReportType.pas' {fmReportType},
  SaveEvents,
  IniSupport;

{$R ResData.res}

function PlugInInfo(
  szName: PChar;
  szAuthor: PChar): Integer; stdcall;
begin
  Result := 2;
  {$I '..\SZ.INC'}
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nPersID: Integer): Integer; stdcall;
var old_conn: _Connection;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfmReportType, fmReportType);
  old_conn := dmMain.dbMain.ConnectionObject;
  dmMain.dbMain.ConnectionObject := Conn;
  dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);
  with TfmReportType.Create(Application) do
  try
    if ShowModal<>mrOk then Result := -3
    else
      if not dmMain.OpenData(nPersID) then begin
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['Ошибка при обращении к базе данных.']);
        MessageBox(Application.Handle,
          'Ошибка при обращении к базе данных!',
          'Печать сообщения о приеме\увольнении (стандартное)',MB_OK or MB_ICONERROR);
        Result := -1;
      end
      else
        if not dmMain.PrintData(Checked) then begin
          Result := -2;
          SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
            ['Ошибка при создании отчета.']);
          MessageBox(Application.Handle,
            'Ошибка при создании отчета!'+#13+
            'Возможно неверно указаны рабочие папки '+#13+
            'или шаблон отчета используется другой программой...',
            'Печать сообщения о приеме\увольнении (стандартное)',MB_OK or MB_ICONERROR);
        end
        else Result := 0;
  finally
    Free;
  end;
  dmMain.dbMain.ConnectionObject := old_conn;
  dmMain.Free;
  Application.Handle := 0;
end;

exports
  PlugInInfo, PlugInExec;

begin
end.


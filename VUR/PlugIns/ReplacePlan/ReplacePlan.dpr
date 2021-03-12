library ReplacePlan;



uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  Controls,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  rdialogs in '..\..\Common\rdialogs.pas',
  msg in '..\..\Common\msg.pas',
  SaveEvents in '..\..\Common\SaveEvents.pas',
  IniSupport in '..\..\Common\IniSupport.pas',
  fReplacePlan in 'fReplacePlan.pas' {frmReplacePlan},
  fSelectPerson in 'fSelectPerson.pas' {frmSelectPerson};

{$R resdata.res}

function PlugInInfo(
  szName: PChar;
  szAuthor: PChar): Integer; stdcall;
begin
  Result := 5;
  StrCopy(szName,'План замены призываемых специалистов');
  StrCopy(szAuthor,'(с) 2007, ГУП г.Москвы "ГНПП "Гранит-Центр"');
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nOrgID: Integer;
  isConfirm: Boolean): Integer; stdcall;
var old_conn: _Connection;
begin
  Result := -1;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfrmReplacePlan, frmReplacePlan);
  Application.CreateForm(TfrmSelectPerson, frmSelectPerson);
  old_conn := dmMain.dbMain.ConnectionObject;
    try
      dmMain.dbMain.ConnectionObject := Conn;
      dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);

      Application.CreateForm(TfrmReplacePlan, frmReplacePlan);
      Result := 0;
      if not dmMain.OpenData then begin
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['Ошибка при обращении к базе данных.']);
        MessageBox(Application.Handle,
          'Ошибка при обращении к базе данных!',
          'Печать плана замены призываемых специалистов',MB_OK or MB_ICONERROR);
        Result := -1;
      end
      else
        frmReplacePlan.ShowModal;
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


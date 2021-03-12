library Form4;

{$R 'IDB_LOGO.res' '..\IDB_LOGO.RC'}

uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  SaveEvents,
  IniSupport,
  fParamDlg in 'fParamDlg.pas' {fmParamDlg},
  Num2Str in '..\..\Common\Num2Str.pas';

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
//    3 - для работы с формой 6
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nF6ID: Integer): Integer; stdcall;
//    4 - для работы со списком
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; szRecords _Recordset): Integer; stdcall;
//    5 - для работы с карточкой организации
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nOrgID: Integer; isConfirm: Boolean): Integer; stdcall;
//    6 - для работы с с формой 26
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nManID: Integer; nFormID: Integer = -1): Integer; stdcall;

begin
  {$I '..\SZ.INC'}
  Result := 2;
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nPersID: Integer): Integer; stdcall;
//  szConn - строка подключения к БД
//  nOrgID - код организации
var old_conn: _Connection; res: Integer;
begin
  Result := 0;
  Application.Handle := AppHandle;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfmParamDlg, fmParamDlg);
  old_conn := dmMain.dbMain.ConnectionObject;
  dmMain.dbMain.ConnectionObject := Conn;
  dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);
  with TfmParamDlg.Create(nil) do begin
    edFioDat.Text := dmMain.GetFio(nPersId);
    edPostRod.Text := dmMain.GetPost(nPersId);
  try
  res := ShowModal;
  if (res = 1{mrOK}) or (res = 6{mrYes}) then begin
    if not dmMain.OpenData(nPersID, res = 6) then begin
      SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
        ['Ошибка при обращении к базе данных.']);
      MessageBox(Application.Handle,
        'Ошибка при обращении к базе данных!',
        'Печать справки для отсрочки призыва учащегося',MB_OK or MB_ICONERROR);
      Result := -1;
    end else begin
      if not dmMain.PrintData(convert(edMonthCount.Value), cbPrintVK.Checked, cbPrintAddr.Checked, edFioDat.Text, edPostRod.Text) then begin
        Result := -2;
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['Ошибка при создании отчета.']);
        MessageBox(Application.Handle,
          'Ошибка при создании отчета!'+#13+
          'Возможно неверно указаны рабочие папки '+#13+
          'или шаблон отчета используется другой программой...',
          'Печать справки для отсрочки призыва учащегося',MB_OK or MB_ICONERROR);
      end
      else Result := 0;
    end;
  end;
  finally
    Free;
  end;
  end;
  dmMain.dbMain.ConnectionObject := old_conn;
  dmMain.Free;
  Application.Handle := 0;
end;

exports
  PlugInInfo, PlugInExec;

begin
end.

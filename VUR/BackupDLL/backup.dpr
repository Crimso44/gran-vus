library backup;

uses
  Forms,
  ADOdb,
  fBackUp in 'fBackUp.pas',
  lzss in 'lzss.pas',
  Dates in 'Dates.pas',
  ArcData in 'ArcData.pas',
  fBackUpInfo in 'fBackUpInfo.pas' {fmBackUpInfo},
  msg in '..\Common\msg.pas',
  SaveEvents in '..\Common\SaveEvents.pas',
  IniSupport in '..\Common\IniSupport.pas',
  rdialogs in '..\Common\rdialogs.pas';

function StoreData(AppHandle: Cardinal; Conn: _Connection): Integer; stdcall;
var old_conn: _Connection;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TfmBackUp, fmBackUp);
  old_Conn := fmBackUp.dbMain.ConnectionObject;
  fmBackUp.dbMain.ConnectionObject := Conn;
  fmBackUp.rbBackUp.Checked := true;
  fmBackUp.laOperation.Caption := '¬ыбрана операци€ резервировани€ данных.';
  fmBackUp.ShowModal;
  fmBackUp.dbMain.ConnectionObject := old_conn;
  fmBackUp.Free;
  Application.Handle := 0;
  Result := 0;
end;

function RestoreData(AppHandle: Cardinal; Conn: _Connection): Integer; stdcall;
var old_conn: _Connection;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TfmBackUp,fmBackUp);
  old_Conn := fmBackUp.dbMain.ConnectionObject;
  fmBackUp.dbMain.ConnectionObject := Conn;
  fmBackUp.PC.ActivePageIndex := 0;
  fmBackUp.rbRestore.Checked := true;
  fmBackUp.laOperation.Caption := '¬ыбрана операци€ восстановлени€ данных.';
  fmBackUp.ShowModal;
  fmBackUp.dbMain.ConnectionObject := old_conn;
  fmBackUp.Free;
  Application.Handle := 0;
  Result := 0;
end;

exports StoreData,RestoreData;

begin
end.

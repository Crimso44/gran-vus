library expdata;

uses
  Forms,
  ADOdb,
  fExport in 'fExport.pas' {fmExport},
  fImport in 'fImport.pas' {fmImport},
  Dates in 'Dates.pas',
  msg in '..\Common\msg.pas',
  rdialogs in '..\Common\rdialogs.pas',
  SaveEvents in '..\Common\SaveEvents.pas';

function ExportOrgData(AppHandle: Cardinal; Conn: _Connection; nOrgID: Integer): Integer; stdcall;
var old_conn: _Connection;
    fmExport: TfmExport;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TfmExport, fmExport);
  old_conn := fmExport.dbMain.ConnectionObject;
  fmExport.dbMain.ConnectionObject := Conn;
  fmExport.OrgID := nOrgID;
  fmExport.ShowModal;
  fmExport.dbMain.ConnectionObject := old_conn;
  fmExport.Free;
  Application.Handle := 0;
  Result := 0;
end;

function ImportOrgData(AppHandle: Cardinal; Conn: _Connection; nOrgID: Integer): Integer; stdcall;
var old_conn: _Connection;
    fmImport: TfmImport;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TfmImport, fmImport);
  old_conn := fmImport.dbMain.ConnectionObject;
  fmImport.dbMain.ConnectionObject := Conn;
  fmImport.OrgID := nOrgID;
  fmImport.ShowModal;
  fmImport.dbMain.ConnectionObject := old_conn;
  fmImport.Free;
  Application.Handle := 0;
  Result := 0;
end;

exports ExportOrgData,ImportOrgData;

begin
end.

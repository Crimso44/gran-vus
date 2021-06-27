library expdata;

uses
  Forms,
  ADOdb,
  fExport in 'fExport.pas' {fmExport},
  msg in '..\Common\msg.pas',
  IniSupport in '..\Common\IniSupport.pas',
  fImportOrg in 'fImportOrg.pas' {fmImportOrg},
  fImportSubj in 'fImportSubj.pas' {fmImportSubj},
  Dates in 'Dates.pas',
  fExportOrg in 'fExportOrg.pas' {fmExportOrg};

function ExportSubjData(AppHandle: Cardinal; Conn: _Connection): Integer; stdcall;
var old_conn: _Connection;
    fmExport: TfmExport;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TfmExport, fmExport);
  Application.CreateForm(TfmExportOrg, fmExportOrg);
  old_conn := fmExport.dbMain.ConnectionObject;
  fmExport.dbMain.ConnectionObject := Conn;
  fmExport.ShowModal;
  fmExport.dbMain.ConnectionObject := old_conn;
  fmExport.Free;
  Application.Handle := 0;
  Result := 0;
end;

function ImportSubjData(AppHandle: Cardinal; Conn: _Connection): Integer; stdcall;
var old_conn: _Connection;
    fmImportSubj: TfmImportSubj;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TfmImportSubj, fmImportSubj);
  old_conn := fmImportSubj.dbMain.ConnectionObject;
  fmImportSubj.dbMain.ConnectionObject := Conn;
  fmImportSubj.ShowModal;
  fmImportSubj.dbMain.ConnectionObject := old_conn;
  fmImportSubj.Free;
  Application.Handle := 0;
  Result := 0;
end;

function ImportOrgData(AppHandle: Cardinal; Conn: _Connection): Integer; stdcall;
var old_conn: _Connection;
    fmImportOrg: TfmImportOrg;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TfmImportOrg, fmImportOrg);
  old_conn := fmImportOrg.dbMain.ConnectionObject;
  fmImportOrg.dbMain.ConnectionObject := Conn;
  fmImportOrg.ShowModal;
  fmImportOrg.dbMain.ConnectionObject := old_conn;
  fmImportOrg.Free;
  Application.Handle := 0;
  if fOpenOrgCard then
    Result := OrgId
  else
    Result := 0;
end;

function ExportOrgData(AppHandle: Cardinal; Conn: _Connection; nOrgId: Integer): Integer; stdcall;
var old_conn: _Connection;
    fmExportOrg: TfmExportOrg;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TfmExportOrg, fmExportOrg);
  old_conn := fmExportOrg.dbMain.ConnectionObject;
  fmExportOrg.dbMain.ConnectionObject := Conn;
  fmExportOrg.OrgId := nOrgId;
  fmExportOrg.ShowModal;
  fmExportOrg.dbMain.ConnectionObject := old_conn;
  fmExportOrg.Free;
  Application.Handle := 0;
  Result := 0;
end;

exports ExportSubjData,ImportSubjData,ImportOrgData,ExportOrgData;

begin
end.

library ImpData;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  Forms,
  ADODB,
  Registry,
  StrUtils,
  fImport in 'fImport.pas' {fmImport},
  MSXML2_TLB in 'MSXML2_TLB.pas',
  fError in 'fError.pas' {frmError},
  DisplayDSs in 'DisplayDSs.pas' {Form1};

{$R *.res}

const _IniName = 'Software\Granit\GranVus\Settings';

function ImportData(AppHandle: Cardinal; Conn: _Connection; schemaPath: PChar): Integer; stdcall;
var old_conn: _Connection;
    fmImport: TfmImport;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TfmImport, fmImport);
//  old_conn := fmImport.dbMain.ConnectionObject;
//  fmImport.dbMain.ConnectionObject := Conn;

  with TRegistryIniFile.Create(_IniName) do
  begin
    fmImport.dbMain.ConnectionString := ReadString('CONNECTION','CONNECTION_STRING','');
    fmImport.dbMain.LoginPrompt := ReadBool('CONNECTION','CONNECTION_PROMPT',false);
    fmImport.dbMain.ConnectionTimeout := ReadInteger('CONNECTION','CONNECTION_TIMEOUT',150);
    fmImport.dbMain.CommandTimeout := ReadInteger('CONNECTION','COMMAND_TIMEOUT',300);
    fmImport.dbMain.Properties['Jet OLEDB:Database Password'].Value := ReverseString('9011ets18q54');
    Free;
  end;
  fmImport.dbMain.Connected := True;

  fmImport.schemaPath :=  schemaPath;
  fmImport.ShowModal;
//  fmImport.dbMain.ConnectionObject := old_conn;
  fmImport.Free;
  Application.Handle := 0;
  Result := 0;
end;

exports ImportData;

begin
end.

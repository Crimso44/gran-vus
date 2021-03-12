program ImportData;

uses
  SysUtils,
  Forms,
  Registry,
  StrUtils,
  MSXML2_TLB in 'MSXML2_TLB.pas',
  fError in 'fError.pas' {frmError},
  fImport in 'fImport.pas' {fmImport};

{$R *.res}

const _IniName = 'Software\Granit\GranVus\Settings';

var
  fmImport: TfmImport;
  
begin
  Application.Initialize;
  Application.Title := 'Импорт данных';
  Application.CreateForm(TfmImport, fmImport);

  try
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
  except
    on E: Exception do
    begin
      ShowErr('Подключение к базе данных ГранВУР...', E.Message);
      Application.Terminate;
    end;
  end;

  fmImport.schemaPath := ExtractFilePath(Application.ExeName) + 'VURSchema.xsd';
  Application.Run;
end.

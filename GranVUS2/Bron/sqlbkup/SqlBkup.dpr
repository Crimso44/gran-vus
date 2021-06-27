program SqlBkup;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  AddDev in 'AddDev.pas' {fAddDev},
  DelDev in 'DelDev.pas' {fDelDev},
  DoBackup in 'DoBackup.pas' {fDoBackup},
  DoRestore in 'DoRestore.pas' {fDoRestore};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

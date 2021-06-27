program DBMaster;

uses
  Forms,
  msg in '..\Common\msg.pas',
  IniSupport in '..\Common\IniSupport.pas',
  Main in 'Main.pas' {MainForm},
  rdialogs in '..\Common\rdialogs.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title:= 'Мастер преобразования данных';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

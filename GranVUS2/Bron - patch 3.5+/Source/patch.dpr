program patch;

uses
  Forms,
  MainForm in 'MainForm.pas' {fmMain},
  Rdialogs in '..\..\bron\Common\rdialogs.pas',
  msg in '..\..\bron\Common\msg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Гран-Бронирование 3.х: Пакет обновления';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.

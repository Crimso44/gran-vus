program patch;

uses
  Forms,
  MainForm in 'MainForm.pas' {fmMain},
  Rdialogs in '..\..\bron\Common\rdialogs.pas',
  msg in '..\..\bron\Common\msg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����-������������ 3.�: ����� ����������';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.

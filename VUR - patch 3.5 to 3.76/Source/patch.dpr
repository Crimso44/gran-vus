program patch;

uses
  Forms,
  MainForm in 'MainForm.pas' {fmMain},
  rdialogs in '..\..\VUR\Common\rdialogs.pas',
  msg in '..\..\VUR\Common\msg.pas',
  vur36 in 'patches\vur36.pas',
  vur361 in 'patches\vur361.pas',
  vur362 in 'patches\vur362.pas',
  vur365 in 'patches\vur365.pas',
  vur370 in 'patches\vur370.pas',
  vur370Users in 'patches\vur370Users.pas' {frmVur370Users},
  MD5 in '..\..\VUR\Common\MD5.PAS',
  vur370Post in 'patches\vur370Post.pas' {frmVur370Post},
  vur371 in 'patches\vur371.pas',
  vur372 in 'patches\vur372.pas',
  vur373 in 'patches\vur373.pas',
  vur374 in 'patches\vur374.pas',
  vur375 in 'patches\vur375.pas',
  vur376 in 'patches\vur376.pas',
  vur377 in 'patches\vur377.pas',
  vur378 in 'patches\vur378.pas',
  vur379 in 'patches\vur379.pas',
  BirthDay in '..\..\VUR\Common\BirthDay.pas',
  vur380 in 'patches\vur380.pas',
  vur381 in 'patches\vur381.pas',
  vur384 in 'patches\vur384.pas',
  vur385 in 'patches\vur385.pas',
  vur386 in 'patches\vur386.pas',
  vur387 in 'patches\vur387.pas',
  vur388 in 'patches\vur388.pas',
  vur390 in 'patches\vur390.pas',
  vur389 in 'patches\vur389.pas',
  vur391 in 'patches\vur391.pas',
  vur392 in 'patches\vur392.pas',
  vur393 in 'patches\vur393.pas',
  vur394 in 'patches\vur394.pas',
  vur395 in 'patches\vur395.pas',
  vur396 in 'patches\vur396.pas',
  vur397 in 'patches\vur397.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Гран-ВУР 3.х: Пакет обновления';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.

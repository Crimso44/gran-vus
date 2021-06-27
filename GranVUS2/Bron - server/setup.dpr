program setup;

uses
  Forms,
  fBG in 'fBG.pas' {fmBG},
  fMain in 'fMain.pas' {fmMain},
  Rdialogs in 'rdialogs.pas',
  misc_fn in 'misc_fn.pas',
  fMakeBD in 'fMakeBD.pas' {fmMakeBD};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Программа установки';
  Application.CreateForm(TfmBG, fmBG);
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.

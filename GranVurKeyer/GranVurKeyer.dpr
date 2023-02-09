program GranVurKeyer;



{$R 'music.res' 'music.rc'}

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  fRegister in 'fRegister.pas' {fmRegister},
  uCrypt in 'uCrypt.pas',
  utils_misc in 'utils_misc.pas',
  msg in 'msg.pas',
  memCert in 'memCert.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

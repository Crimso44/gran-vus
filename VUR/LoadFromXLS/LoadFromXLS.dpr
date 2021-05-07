program LoadFromXLS;

uses
  Forms,
  Main in 'Main.pas' {fmMain},
  msg in '..\Common\msg.pas',
  Rdialogs in '..\Common\rdialogs.pas',
  SaveEvents in '..\Common\SaveEvents.pas',
  uCrypt in '..\Common\uCrypt.pas',
  IniSupport in '..\Common\IniSupport.pas',
  MD5 in '..\Common\MD5.PAS',
  misc in '..\Common\misc.pas',
  dMain in 'dMain.pas' {dmMain: TDataModule},
  fRegister in '..\fRegister.pas' {fmRegister};

{$R *.res}

begin
  Application.Initialize;
  {$IFNDEF BackDoor}
  if IsDemoVersion then begin
    ShowErr('Лицензия не найдена!');
    Application.Terminate;
  end
  else begin
  {$ENDIF}
    Application.CreateForm(TfmMain, fmMain);
    Application.CreateForm(TdmMain, dmMain);
    Application.Run;
  {$IFNDEF BackDoor}
  end;
  {$ENDIF}
end.

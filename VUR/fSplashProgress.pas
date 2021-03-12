unit fSplashProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TfrmSplashProgress = class(TForm)
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    Bevel1: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplashProgress: TfrmSplashProgress;

procedure ProgressShow(const MaxValue: Integer; const ACaption: String);
procedure ProgressClose;
procedure ProgressInc;

implementation

{$R *.dfm}

procedure ProgressShow(const MaxValue: Integer; const ACaption: String);
begin
  frmSplashProgress := TfrmSplashProgress.Create(Application);
  frmSplashProgress.ProgressBar1.Max := MaxValue;
  frmSplashProgress.Label1.Caption := ACaption;
  frmSplashProgress.Show;
  Application.ProcessMessages;
end;

procedure ProgressClose;
begin
  FreeAndnil(frmSplashProgress);
end;

procedure ProgressInc;
begin
  frmSplashProgress.ProgressBar1.StepIt;
end;

end.


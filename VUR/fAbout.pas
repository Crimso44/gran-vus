unit fAbout;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfmAbout = class(TForm)
    laVersion: TLabel;
    Shape2: TShape;
    Shape3: TShape;
    Label3: TLabel;
    Label4: TLabel;
    lbMsg: TLabel;
    Shape1: TShape;
    igLogo: TImage;
    Label1: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Label5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure SplashPrepare;
procedure SplashMsg(msg: string);
procedure SplashClose;

procedure ShowAbout;

implementation

uses ShellAPI, uVERSION;
{$R *.DFM}

var
  fmAbout: TfmAbout;

procedure SplashPrepare;
begin
  Application.CreateForm(TfmAbout,fmAbout);
  fmAbout.lbMsg.Caption := EmptyStr;
  fmAbout.Show;
  fmAbout.Update;
end;

procedure SplashMsg(msg: string);
begin
  fmAbout.lbMsg.Caption := msg;
  fmAbout.lbMsg.Update;
  Sleep(200);
end;

procedure SplashClose;
begin
  fmAbout.Free;
end;

procedure ShowAbout;
begin
  Application.CreateForm(TfmAbout,fmAbout);
  fmAbout.lbMsg.Caption := EmptyStr;
  fmAbout.ShowModal;
  fmAbout.Free;
end;

procedure TfmAbout.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Close;
end;

procedure TfmAbout.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Close;
end;

procedure TfmAbout.Label5Click(Sender: TObject);
var s: string;
begin
  if Sender is TLabel then begin
    s := (Sender as TLabel).Caption;
    if (Pos('http',s)<>1) and (Pos('mailto',s)<>1) then s:='http://'+s;
    ShellExecute(0,nil,PChar(s),nil,nil,SW_SHOWMAXIMIZED)
  end;
end;

procedure TfmAbout.FormCreate(Sender: TObject);
begin
  laVersion.Caption := laVersion.Caption+sVersion;
end;

end.

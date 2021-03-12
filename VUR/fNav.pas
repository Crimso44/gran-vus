unit fNav;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons;

const
  WM_NAV_NOTIFY = WM_USER + 10321;
  NAV_PREV = 1;
  NAV_NEXT = 2;
  NAV_FIRST = 3;
  NAV_LAST = 4;
  NAV_POS = 5;
  NAV_CLOSE = 6;

type
  TfmNav = class(TForm)
    Panel1: TPanel;
    sbPrev: TSpeedButton;
    sbNext: TSpeedButton;
    sbFirst: TSpeedButton;
    sbLast: TSpeedButton;
    procedure sbPrevClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
    procedure sbFirstClick(Sender: TObject);
    procedure sbLastClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    procedure WM_NavNotify(var msg: TMEssage); message WM_NAV_NOTIFY;
  public
    { Public declarations }
    hParent: HWND;
  end;


implementation

{$R *.DFM}

procedure TfmNav.sbPrevClick(Sender: TObject);
begin
  SendMessage(hParent,WM_NAV_NOTIFY,NAV_PREV,0);
end;

procedure TfmNav.sbNextClick(Sender: TObject);
begin
  SendMessage(hParent,WM_NAV_NOTIFY,NAV_NEXT,0);
end;

procedure TfmNav.sbFirstClick(Sender: TObject);
begin
  SendMessage(hParent,WM_NAV_NOTIFY,NAV_FIRST,0);
end;

procedure TfmNav.sbLastClick(Sender: TObject);
begin
  SendMessage(hParent,WM_NAV_NOTIFY,NAV_LAST,0);
end;

procedure TfmNav.FormCreate(Sender: TObject);
begin
  hParent := 0;
  Panel1.Left := 0;
  Panel1.Top := 0;
  Width := Panel1.Width;
  Height := Panel1.Height;
end;

procedure TfmNav.WM_NavNotify(var msg: TMEssage);// message WM_NAV_NOTIFY;
begin
  case msg.WParam of
    NAV_POS:
        SetWindowPos(Handle,HWND_TOPMOST,msg.LParamLo,msg.LParamHi,0,0,
          SWP_NOACTIVATE or SWP_NOSIZE or SWP_SHOWWINDOW);
    NAV_CLOSE:
        Release;
  end;
end;

procedure TfmNav.FormDeactivate(Sender: TObject);
begin
  ShowWindow(Handle,SW_HIDE);
end;

end.

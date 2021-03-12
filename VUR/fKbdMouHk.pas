unit fKbdMouHk;

interface

uses
  Forms, Windows, Messages, SysUtils, Classes, ExtCtrls;

const
    WM_MYHOOK = WM_USER + 10123;

type
  TfmKbdMouHk = class(TForm)
    tmCheck: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmCheckTimer(Sender: TObject);
  private
    { Private declarations }
    hDll: Cardinal;
    time_val,time_out: Cardinal;
    procedure OnHook(var msg: TMessage); message WM_MYHOOK;
  public
    { Public declarations }
  end;

  fnDLL = procedure; stdcall;

  procedure EnableHook(time_out: Integer);
  procedure DisableHook;

implementation

uses msg, fGetPsw;

{$R *.DFM}

var  fmKbdMouHk: TfmKbdMouHk;

procedure EnableHook(time_out: Integer);
begin 
  if time_out<=0 then DisableHook
  else begin
    if fmKbdMouHk=nil then
      Application.CreateForm(TfmKbdMouHk,fmKbdMouHk);
    fmKbdMouHk.time_out := time_out;
  end;
end;

procedure DisableHook;
begin
  if fmKbdMouHk<>nil then fmKbdMouHk.Free;
end;

procedure TfmKbdMouHk.FormCreate(Sender: TObject);
begin
  time_out := 600;
  time_val := 0;
  hDll := LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+'kbdmouhk.dll'));
  if hDLL=0 then ShowErr('Не найдена требуемая библиотека "kbdmouhk.dll"!')
  else
    fnDLL(GetProcAddress(hDLL,'SetHook'));
end;

procedure TfmKbdMouHk.FormDestroy(Sender: TObject);
begin
  if hDLL<>0 then begin
    fnDLL(GetProcAddress(hDLL,'UnSetHook'));
    FreeLibrary(hDLL);
    fmKbdMouHk := nil;
  end;
end;

procedure TfmKbdMouHk.tmCheckTimer(Sender: TObject);
begin
  Inc(time_val);
  if time_val>=time_out then begin
    tmCheck.Enabled := false;
    Application.MainForm.Visible := false;
    while not CheckPassword do;
    Application.MainForm.Visible := true;
    tmCheck.Enabled := true;
  end;
end;

procedure TfmKbdMouHk.OnHook(var msg: TMessage);
begin
  time_val := 0;
end;

initialization
  fmKbdMouHk := nil;

end.

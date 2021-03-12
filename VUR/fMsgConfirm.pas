unit fMsgConfirm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfMessageConfirm = class(TForm)
    Label1: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    CheckBox1: TCheckBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMessageConfirm: TfMessageConfirm;

function ShowMessage(SMsg: string): Boolean;


implementation

{$R *.dfm}

function ShowMessage(sMsg: string): Boolean;
begin
  Result := False;
  fMessageConfirm := TfMessageConfirm.Create(Application);
  try
    fMessageConfirm.Label1.Caption := sMsg;
    fMessageConfirm.ShowModal;
    Result := fMessageConfirm.CheckBox1.Checked;
  finally
    fMessageConfirm.Free;
  end;
end;

end.

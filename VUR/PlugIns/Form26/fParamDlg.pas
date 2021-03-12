unit fParamDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  dxDBTLCl, dxGrClms, ActnList;

type
  TfmParamDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    ActionList1: TActionList;
    Action1: TAction;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmParamDlg: TfmParamDlg;

implementation

{$R *.dfm}

uses ADOdb, dMain, msg;

procedure TfmParamDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'granvus.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.

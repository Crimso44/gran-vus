unit fParamDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, CheckLst, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  dxDBTLCl, dxGrClms, ActnList, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxSpinEdit;

type
  TfmParamDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    cbPrintVK: TCheckBox;
    cbPrintAddr: TCheckBox;
    ActionList1: TActionList;
    Action1: TAction;
    edMonthCount: TcxSpinEdit;
    Label1: TLabel;
    Button3: TButton;
    lNumStr: TLabel;
    Label2: TLabel;
    edFioDat: TEdit;
    Label3: TLabel;
    edPostRod: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure edMonthCountPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmParamDlg: TfmParamDlg;

implementation

{$R *.dfm}

uses ADOdb, dMain, msg, IniSupport, Num2Str;

procedure TfmParamDlg.Button3Click(Sender: TObject);
var
  fileName: String;
begin
  fileName := GetTemplatesDir + 'form4blank.pdf';
  ShellExecute(0,'open',PChar(fileName),nil,nil,SW_NORMAL);
end;

procedure TfmParamDlg.edMonthCountPropertiesChange(Sender: TObject);
begin
  lNumStr.Caption := convert(edMonthCount.Value);
end;

procedure TfmParamDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'granvus.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.

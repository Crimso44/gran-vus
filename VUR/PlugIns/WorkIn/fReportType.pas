unit fReportType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, ActnList,
  System.Actions;

type
  TfmReportType = class(TForm)
    chkLabel: TCheckBox;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    cbSend_Date: TCheckBox;
    deSend_Date: TdxDateEdit;
    cbReason: TCheckBox;
    edReason: TEdit;
    ActionList1: TActionList;
    aChange: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure aChangeUpdate(Sender: TObject);
    procedure cbReasonClick(Sender: TObject);
  private
    { Private declarations }
  public
    Checked: Integer;
    UseSend_Date, UseReason: Boolean;
    Send_Date: TDateTime;
    Reason: string;
    { Public declarations }
  end;

var
  fmReportType: TfmReportType;

implementation

{$R *.dfm}

uses WinHelpViewer;

procedure TfmReportType.aChangeUpdate(Sender: TObject);
begin
  cbSend_Date.Enabled := RadioButton2.Checked;
  cbReason.Enabled := RadioButton2.Checked;
  if cbSend_Date.Checked then cbReason.Checked := False;
  if cbReason.Checked then cbSend_Date.Checked := False;

  deSend_Date.Enabled := cbSend_Date.Enabled and cbSend_Date.Checked;
  edReason.Enabled := cbReason.Enabled and cbReason.Checked;
  if edReason.Enabled then edReason.Color := clWindow
  else edReason.Color := clBtnFace;
end;

procedure TfmReportType.Button1Click(Sender: TObject);
begin
  if deSend_Date.Text = '' then cbSend_Date.Checked := False;
  if RadioButton1.Checked then Checked := 0
  else if RadioButton2.Checked then Checked := 1
  else if RadioButton3.Checked then Checked := 2
  else if RadioButton4.Checked then Checked := 3
  else if RadioButton5.Checked then Checked := 4
  else if RadioButton6.Checked then Checked := 5;
  UseSend_Date := cbSend_Date.Enabled and cbSend_Date.Checked;
  Send_Date := deSend_Date.Date;
  UseReason := cbReason.Enabled and cbReason.Checked;
  Reason := edReason.Text;
end;

procedure TfmReportType.cbReasonClick(Sender: TObject);
begin
  if cbReason.Checked then cbSend_Date.Checked := False;
end;

procedure TfmReportType.FormCreate(Sender: TObject);
begin
  HelpFile := ExtractFileDir(Application.ExeName) + '/granvus.hlp';
  deSend_Date.Date := Date;
end;

end.

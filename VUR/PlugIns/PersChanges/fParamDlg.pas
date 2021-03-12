unit fParamDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, dxCntner, dxEditor, dxExEdtr, dxEdLib;

type
  TfmParamDlg = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    rbAll: TRadioButton;
    rbSel: TRadioButton;
    cbxOVK: TCheckListBox;
    Label1: TLabel;
    Date_From: TdxDateEdit;
    Date_To: TdxDateEdit;
    Label2: TLabel;
    Label3: TLabel;
    cbAll: TCheckBox;
    cbSend_Date: TCheckBox;
    deSend_Date: TdxDateEdit;
    procedure FormCreate(Sender: TObject);
    procedure rbAllClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxOVKDblClick(Sender: TObject);
    procedure cbSend_DateClick(Sender: TObject);
    procedure Date_FromDateValidateInput(Sender: TObject; const AText: string;
      var ADate: TDateTime; var AMessage: string; var AError: Boolean);
    procedure Date_ToDateValidateInput(Sender: TObject; const AText: string;
      var ADate: TDateTime; var AMessage: string; var AError: Boolean);
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

uses ADOdb, dMain, msg, WinHelpViewer, DateUtils;

procedure TfmParamDlg.FormCreate(Sender: TObject);
var
  sDate: String;
begin
  sDate := 'Date()';
  if not dmMain.IsJet then
    sDate := 'GetDate()';

  HelpFile := ExtractFileDir(Application.ExeName) + '/granvus.hlp';
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text :=
      'SELECT * FROM KOVK'#13+
      'WHERE EXISTS('#13+
      'SELECT 1 FROM PERSON'#13 +
      'INNER JOIN PersonChanges pc on pc.PERS_ID = PERSON.PERS_ID'#13 +
      'WHERE OVK_ID=KOVK.OVK_ID AND IS_WAR<>0 AND (W_DEND is null or Year(W_DEND) >= Year('+sDate+'))'#13+
      //'AND WRNG_ID<>1'#13+
      'AND'#13+
      '(((select max(In_Date) from Appointment where pers_id = PERSON.pers_id and ' +
      'post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND'#13+
      'PERSON.OUT_ORD_DATE IS NULL) OR'#13+
      '((select max(In_Date) from Appointment where pers_id = PERSON.pers_id and ' +
      'post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND'#13+
      'PERSON.ORDERDISMISSAL_DATE IS NULL))'#13+
      ') ORDER BY OVK_NAME';
    Open;
    cbxOVK.Items.Clear;
    while not EOF do begin
      cbxOVK.Items.AddObject(FieldByName('OVK_NAME').AsString,Pointer(FieldByName('OVK_ID').AsInteger));
      Next;
    end;

    Date_From.Date := IncYear(Date, -1);
    Date_To.Date := Date;
    deSend_Date.Date := Date;
  finally
    Free;
  end;
end;

procedure TfmParamDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'granvus.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

procedure TfmParamDlg.rbAllClick(Sender: TObject);
begin
  cbxOVK.Enabled := rbSel.Checked;
  if cbxOVK.Enabled then
    cbxOVK.Color := clWindow
  else
    cbxOVK.Color := clBtnFace;
end;

procedure TfmParamDlg.Button1Click(Sender: TObject);
var i: Integer;
begin
  dmMain.ListOVK.Clear;
  if (Date_From.Text = '') or (Date_To.Text = '') then begin
    ShowInfo('Необходимо указать период!');
    Exit;
  end;
  if (cbSend_Date.Checked) and (deSend_Date.Text = '') then begin
    ShowInfo('Необходимо указать дату отправки сведений в ОВК!');
    Exit;
  end;
  if rbAll.Checked then ModalResult := mrOk
  else begin
    for i:=0 to cbxOVK.Items.Count-1 do
      if cbxOVK.Checked[i] then
        dmMain.ListOVK.Add(IntToStr(Integer(cbxOVK.Items.Objects[i])));
    if dmMain.ListOVK.Count=0 then ShowInfo('Необходимо выбрать нужные ОВК!')
    else ModalResult := mrOk;
  end;
  if ModalResult = mrOk then begin
    dmMain.Date_From := Date_From.Date;
    dmMain.Date_To := Date_To.Date;
    dmMain.All := cbAll.Checked;
    dmMain.UseSend_Date := cbSend_Date.Checked;
    dmMain.Send_Date := deSend_Date.Date;
  end;
end;

procedure TfmParamDlg.cbSend_DateClick(Sender: TObject);
begin
  deSend_Date.Enabled := cbSend_Date.Checked; 
end;

procedure TfmParamDlg.cbxOVKDblClick(Sender: TObject);
var n: Integer;
begin
//select all
  for n:=0 to cbxOVK.Count-1 do
    cbxOVK.Checked[n] := not cbxOVK.Checked[n];
end;

procedure TfmParamDlg.Date_FromDateValidateInput(Sender: TObject;
  const AText: string; var ADate: TDateTime; var AMessage: string;
  var AError: Boolean);
begin
  if ADate >= Date_To.Date then ADate := IncYear(Date_To.Date, -1);
end;

procedure TfmParamDlg.Date_ToDateValidateInput(Sender: TObject;
  const AText: string; var ADate: TDateTime; var AMessage: string;
  var AError: Boolean);
begin
  if ADate <= Date_From.Date then ADate := IncYear(Date_From.Date, 1);
end;

end.

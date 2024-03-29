unit fParamDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, DateUtils;

type
  TfmParamDlg = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    rbAll: TRadioButton;
    rbSel: TRadioButton;
    cbxOVK: TCheckListBox;
    chkPrintLetters: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure rbAllClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxOVKDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmParamDlg: TfmParamDlg;

implementation

{$R *.dfm}

uses ADOdb, dMain, msg, WinHelpViewer;

procedure TfmParamDlg.FormCreate(Sender: TObject);
begin
  HelpFile := ExtractFileDir(Application.ExeName) + '/granvus.hlp';
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text :=
      'SELECT * FROM KOVK'#13+
      'WHERE EXISTS('#13+
      'SELECT * FROM PERSON WHERE OVK_ID=KOVK.OVK_ID AND IS_WAR<>0 AND '+
      '(W_DEND is null or Year(W_DEND) >= '+IntToStr(YearOf(Date))+')'#13+
      //'AND WRNG_ID<>1'#13+
      'AND ((select COUNT(*) from PERS_SET)=0 or PERS_ID in (select PERS_ID from PERS_SET)) AND'#13+
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
  finally
    Free;
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
  dmMain.printLetters := chkPrintLetters.Checked;
  dmMain.ListOVK.Clear;
  if rbAll.Checked then ModalResult := mrOk
  else begin
    for i:=0 to cbxOVK.Items.Count-1 do
      if cbxOVK.Checked[i] then
        dmMain.ListOVK.Add(IntToStr(Integer(cbxOVK.Items.Objects[i])));
    if dmMain.ListOVK.Count=0 then ShowInfo('���������� ������� ������ ���!')
    else ModalResult := mrOk;
  end;
end;

procedure TfmParamDlg.cbxOVKDblClick(Sender: TObject);
var n: Integer;
begin
//select all
  for n:=0 to cbxOVK.Count-1 do
    cbxOVK.Checked[n] := not cbxOVK.Checked[n];
end;

end.

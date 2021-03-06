unit fParamDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst;

type
  TfmParamDlg = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    rbAll: TRadioButton;
    rbSel: TRadioButton;
    cbxOVK: TCheckListBox;
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
var
  sDate, sYyyy: String;
begin
  sDate := 'Date()';
  sYyyy := '"yyyy"';
  if not dmMain.IsJet then begin
    sDate := 'GetDate()';
    sYyyy := 'yy';
  end;

  HelpFile := ExtractFileDir(Application.ExeName) + '/granvus.hlp';
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text :=
      'SELECT * FROM KOVK'#13+
      'WHERE EXISTS('#13+
        'SELECT * FROM PERSON P '+
        'WHERE P.OVK_ID=KOVK.OVK_ID '+
        '  and ((select COUNT(*) from PERS_SET)=0 or P.PERS_ID in (select PERS_ID from PERS_SET)) '+
        'and dateadd('+sYyyy+',15,p.Birthday) <= '+sDate+' '+
        'and dateadd('+sYyyy+',17,p.Birthday) > '+sDate+' '+
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
  dmMain.ListOVK.Clear;
  if rbAll.Checked then ModalResult := mrOk
  else begin
    for i:=0 to cbxOVK.Items.Count-1 do
      if cbxOVK.Checked[i] then
        dmMain.ListOVK.Add(IntToStr(Integer(cbxOVK.Items.Objects[i])));
    if dmMain.ListOVK.Count=0 then ShowInfo('?????????? ??????? ?????? ???!')
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

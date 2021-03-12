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
    cbxMTR: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure rbAllClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxMTRDblClick(Sender: TObject);
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
      'SELECT ID, IIF((ShortName is null), Name, ShortName) As Name FROM KASFMTR'#13+
      'ORDER BY IIF((ShortName is null), Name, ShortName)';
    Open;
    cbxMTR.Items.Clear;
    while not EOF do begin
      cbxMTR.Items.AddObject(FieldByName('NAME').AsString,Pointer(FieldByName('ID').AsInteger));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfmParamDlg.rbAllClick(Sender: TObject);
begin
  cbxMTR.Enabled := rbSel.Checked;
  if cbxMTR.Enabled then
    cbxMTR.Color := clWindow
  else
    cbxMTR.Color := clBtnFace;
end;

procedure TfmParamDlg.Button1Click(Sender: TObject);
var i: Integer;
begin
  dmMain.ListMTR.Clear;
  if rbAll.Checked then ModalResult := mrOk
  else begin
    for i:=0 to cbxMTR.Items.Count-1 do
      if cbxMTR.Checked[i] then
        dmMain.ListMTR.Add(IntToStr(Integer(cbxMTR.Items.Objects[i])));
    if dmMain.ListMTR.Count=0 then ShowInfo('Необходимо выбрать нужные виды МТР!')
    else ModalResult := mrOk;
  end;
end;

procedure TfmParamDlg.cbxMTRDblClick(Sender: TObject);
var n: Integer;
begin
//select all
  for n:=0 to cbxMTR.Count-1 do
    cbxMTR.Checked[n] := not cbxMTR.Checked[n];
end;

end.

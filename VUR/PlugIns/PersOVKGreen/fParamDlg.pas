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

uses ADOdb, dMain, msg, WinHelpViewer, BirthDay;

procedure TfmParamDlg.FormCreate(Sender: TObject);
begin
  HelpFile := ExtractFileDir(Application.ExeName) + '/granvus.hlp';
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text :=
      'select Distinct KOVK.* from ((KOVK ' +
      'inner join Person p on p.OVK_ID = KOVK.OVK_ID) ' +
      'left outer join PersonReservChkInfo pr on pr.Pers_Id = P.pers_Id) ' +
      'left outer join KWRange wr on p.WRng_Id = wr.WRng_Id ' +
      'where P.IS_WAR<>0 and pr.Is_Bad = 1 and pr.Reserved = 0 and ' +
      '(not ((p.MALE=1 and (wr.M_LIMIT is not NULL) and  ('+FullAges('p.BIRTHDAY')+')>wr.M_LIMIT  ) or ' +
      '(p.MALE=0 and (wr.FEM_LIMIT is not NULL) and  ('+FullAges('p.BIRTHDAY')+')>wr.FEM_LIMIT))) and ' +
      '(p.Wuchet2_IsWork is null or p.Wuchet2_IsWork = 0)' +
      'and ((select COUNT(*) from PERS_SET)=0 or P.PERS_ID in (select PERS_ID from PERS_SET)) ' +
      'AND ' +
      '(((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL) ' +
      'OR ((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL)) ' +
      'ORDER BY OVK_NAME';
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
  for i:=0 to cbxOVK.Items.Count-1 do
    if (cbxOVK.Checked[i] or rbAll.Checked) then
      dmMain.ListOVK.Add(IntToStr(Integer(cbxOVK.Items.Objects[i])));
  if dmMain.ListOVK.Count=0 then ShowInfo('Ни одного ОВК не выбрано!')
  else ModalResult := mrOk;
end;

procedure TfmParamDlg.cbxOVKDblClick(Sender: TObject);
var n: Integer;
begin
//select all
  for n:=0 to cbxOVK.Count-1 do
    cbxOVK.Checked[n] := not cbxOVK.Checked[n];
end;

end.

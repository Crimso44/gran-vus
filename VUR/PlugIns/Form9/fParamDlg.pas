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
      'SELECT * FROM KDepart'#13+
      'WHERE EXISTS('#13+
      'SELECT * FROM ((((PERSON p'#13+
      ' left outer join [KWRange] on p.WRng_Id=[KWRange].WRng_Id)'#13+
      ' left outer join Appointment As AppointmentFirst on p.AppLast=AppointmentFirst.Id)'#13+
      ' left outer join Appointment As AppointmentFirstStudy on p.AppFirstStudy=AppointmentFirstStudy.Id)'#13+
      ' left outer join Appointment As AppointmentLastAll on p.AppLastAll=AppointmentLastAll.Id)'#13+
      'where AppointmentLastAll.Dep_Id = KDepart.Dep_Id'#13+
      'and p.WUchet2_IsWork = 1'#13+
      'and (p.Out_Date is null or p.Out_Date > Date() or ((p.Dismissal_Date is null or p.Dismissal_Date > Date() or AppointmentFirstStudy.In_Date is null) and AppointmentFirstStudy.In_Date is not null))'#13+
      'and (p.Out_Date is null or p.Out_Date > Date() or ((p.Dismissal_Date is null or p.Dismissal_Date > Date() or AppointmentFirst.In_Date is null) and AppointmentFirst.In_Date is not null))'#13+
      'and (p.W_DEnd is null or p.W_DEnd > Date())'#13+
      'and p.is_war = 1'#13+
      'and  IIF(p.W_DEND is NULL and ('#13+
      '         (p.MALE=1 and ([KWRANGE].M_LIMIT is not NULL) and  ('+FullAges('p.BIRTHDAY')+')>[KWRANGE].M_LIMIT  ) or'#13+
      '         (p.MALE=0 and ([KWRANGE].FEM_LIMIT is not NULL) and  ('+FullAges('p.BIRTHDAY')+')>[KWRANGE].FEM_LIMIT  ))'#13+
      '        ,1,0) = 0'#13+
      ') ORDER BY Dep_NAME';
    Open;
    cbxOVK.Items.Clear;
    while not EOF do begin
      cbxOVK.Items.AddObject(FieldByName('Dep_NAME').AsString,Pointer(FieldByName('Dep_ID').AsInteger));
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
    if dmMain.ListOVK.Count=0 then ShowInfo('Необходимо выбрать нужные подразделения!')
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

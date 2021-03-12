unit fASAppointments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, DB, ADODB, dxDBTLCl, dxGrClms, dxTL, dxDBCtrl,
  dxDBGrid, dxCntner, dxBar, dxBarDBNav, FrmKeep, ComCtrls, cxClasses,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter;

type
  TfmASAppointments = class(TForm)
    FrmKeep1: TFrmKeep;
    dxBarManager1: TdxBarManager;
    dxBarDBNavigator: TdxBarDBNavigator;
    dxBarDBNavFirst1: TdxBarDBNavButton;
    dxBarDBNavPrev1: TdxBarDBNavButton;
    dxBarDBNavNext1: TdxBarDBNavButton;
    dxBarDBNavLast1: TdxBarDBNavButton;
    dxBarDBNavInsert1: TdxBarDBNavButton;
    dxBarDBNavDelete1: TdxBarDBNavButton;
    dxBarDBNavEdit1: TdxBarDBNavButton;
    dxBarDBNavPost1: TdxBarDBNavButton;
    dxBarDBNavCancel1: TdxBarDBNavButton;
    qridAppointment: TdxDBGrid;
    qridAppointmentID: TdxDBGridColumn;
    qridAppointmentPERS_ID: TdxDBGridColumn;
    qridAppointmentPOST: TdxDBGridLookupColumn;
    qridAppointmentDEP: TdxDBGridLookupColumn;
    qridAppointmentIN_ORD_NUMB: TdxDBGridColumn;
    qridAppointmentIN_ORD_DATE: TdxDBGridDateColumn;
    dsAppointment: TDataSource;
    qrAppointment: TADOQuery;
    qrKPOST: TADOQuery;
    qrASP: TADOQuery;
    qridAppointmentIN_DATE: TdxDBGridDateColumn;
    StatusBar1: TStatusBar;
    qridAppointmentNum: TdxDBGridColumn;
    qrAppointmentID: TAutoIncField;
    qrAppointmentPERS_ID: TIntegerField;
    qrAppointmentASPost_ID: TIntegerField;
    qrAppointmentASP_ID: TIntegerField;
    qrAppointmentIN_ORD_NUMB: TWideStringField;
    qrAppointmentIN_ORD_Date: TDateTimeField;
    qrAppointmentIN_Date: TDateTimeField;
    qrKPOSTASPOST_ID: TIntegerField;
    qrKPOSTPOST_NAME: TWideStringField;
    qrKPOSTASPOST_Num: TIntegerField;
    qrAppointmentPOST_Name: TStringField;
    qrAppointmentDep_Name: TStringField;
    qrAppointmentTRAINING: TWideStringField;
    qrAppointmentTRAINING_Date: TDateTimeField;
    qrAppointmentATTESTED: TWideStringField;
    qridAppointmentTRAINING: TdxDBGridColumn;
    qridAppointmentTRAINING_Date: TdxDBGridDateColumn;
    qridAppointmentASF: TdxDBGridLookupColumn;
    qrAppointmentDep_Name_ASF: TStringField;
    qrAppointmentAttested_Id: TIntegerField;
    qrAppointmentTraining_Date_Out: TDateTimeField;
    qrAppointmentAttested_Who: TWideStringField;
    qrAppointmentAttested_Date: TDateTimeField;
    qrKAsfQualif: TADOQuery;
    qrKAsfQualifID: TIntegerField;
    qrKAsfQualifNAME: TWideStringField;
    qrAppointmentAttested_Name: TWideStringField;
    qridAppointmentAttested_Id: TdxDBGridMaskColumn;
    qridAppointmentTraining_Date_Out: TdxDBGridDateColumn;
    qridAppointmentAttested_Who: TdxDBGridColumn;
    qridAppointmentAttested_Date: TdxDBGridDateColumn;
    qridAppointmentAttested_Name: TdxDBGridLookupColumn;
    qrASF: TADOQuery;
    qrAppointmentASF_ID: TIntegerField;
    qrASFASF_ID: TIntegerField;
    qrASFASFName: TWideStringField;
    qrASFOrderName: TWideStringField;
    qrASPASP_ID: TIntegerField;
    qrASPDEP_NAME: TWideStringField;
    qrASPASP_Num: TIntegerField;
    qrASPASF_ID: TIntegerField;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qrAppointmentNewRecord(DataSet: TDataSet);
    procedure qrAppointmentBeforePost(DataSet: TDataSet);
    procedure qrAppointmentBeforeDelete(DataSet: TDataSet);
    procedure qridAppointmentNumGetText(Sender: TObject; ANode: TdxTreeListNode;
      var AText: string);
    procedure qridAppointmentColumnSorting(Sender: TObject;
      Column: TdxDBTreeListColumn; var Allow: Boolean);
    procedure qrAppointmentAfterPost(DataSet: TDataSet);
    procedure qrAppointmentAfterDelete(DataSet: TDataSet);
    procedure qridAppointmentDEPEditButtonClick(Sender: TObject);
    procedure qrASPBeforeOpen(DataSet: TDataSet);
    procedure qrKPOSTBeforeOpen(DataSet: TDataSet);
    procedure qridAppointmentChangedColumnsWidth(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PERS_ID: Integer;
    procedure SetPostAndDep;
  end;

var
  fmASAppointments: TfmASAppointments;

procedure ShowASAppointments(pPERS_ID: Integer);

implementation

uses dMain, Rdialogs, msg;

{$R *.dfm}

procedure ShowASAppointments(pPERS_ID: Integer);
var I: Integer;
begin
  with TfmASAppointments.Create(Application) do
  try
    for I := 0 to ComponentCount-1 do
    if (Components[I] is TADOQuery) and
       (Components[I] <> qrAppointment)
    then
      (Components[I] as TADOQuery).Open;
    PERS_ID := pPERS_ID;
    qrAppointment.Parameters[0].Value := PERS_ID;
    if not dmMain.rEdit then qrAppointment.LockType := ltReadOnly;
    qrAppointment.Open;
    ShowModal;
  finally Free;
  end;
end;

procedure TfmASAppointments.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := True;
  if qrAppointment.State in [dsInsert, dsEdit] then
  case RMessageDlg('“екуща€ запись не сохранена. —охранить еЄ перед выходом?',
          mtConfirmation, [mbYes, mbNo, mbCancel], 0)
  of
    mrYes: qrAppointment.Post;
    mrCancel: CanClose := False;
  end;

  if not qrAppointment.IsEmpty then
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := Format('SELECT IN_DATE FROM Appointment '+
      'WHERE PERS_ID = %d AND IN_DATE IS NOT NULL AND '+
      'POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID <> 500 and CPROF2015_ID <> 500)'+
      'GROUP BY IN_DATE HAVING COUNT(*)>1', [PERS_ID]);
    Open;
    if not IsEmpty then begin
      CanClose := not Confirm(
        '—уществуют одинаковые даты назначени€.'#13+
        'Ёто может повлечь за собой неверное определение даты приЄма на работу и сведений о последнем назначении.'#13+
        'ќставить окно открытым дл€ исправлени€?');
      if not CanClose then Exit;
    end;
(*    Close;
    SQL.Text := Format('SELECT IN_DATE FROM Appointment WHERE PERS_ID = %d AND IN_DATE IS NULL',
     [PERS_ID]);
    Open;
    if not IsEmpty then begin
      CanClose := not Confirm(
        '—уществуют незаполненные даты назначени€.'#13+
        'Ёто может повлечь за собой неверное определение даты приЄма на работу и сведений о последнем назначении.'#13+
        'ќставить окно открытым дл€ исправлени€?');
      if not CanClose then Exit;
    end;*)
  finally Free;
  end;
end;

procedure TfmASAppointments.qrAppointmentNewRecord(DataSet: TDataSet);
begin
  with qrAppointment do FieldByName('PERS_ID').Value := PERS_ID;
end;

procedure TfmASAppointments.qrASPBeforeOpen(DataSet: TDataSet);
begin
  qrASP.SQL[qrASP.SQL.Count-1] :=
      'ORDER BY '+iifStr(dmMain.isAbcSort, 'ASP_Name', 'ASP_Num');
end;

procedure TfmASAppointments.qridAppointmentChangedColumnsWidth(Sender: TObject);
begin
  qridAppointmentPost.DropDownWidth := qridAppointmentPost.Width * 2;
  qridAppointmentDep.DropDownWidth := qridAppointmentDep.Width * 2;
  qridAppointmentAsf.DropDownWidth := qridAppointmentAsf.Width * 2;
  qridAppointmentAttested_Name.DropDownWidth := qridAppointmentAttested_Name.Width * 2;
end;

procedure TfmASAppointments.qridAppointmentColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := Column <> qridAppointmentNum;
end;

procedure TfmASAppointments.qridAppointmentDEPEditButtonClick(Sender: TObject);
begin
  qrASP.Filtered := False;
  if qrAppointmentAsf_Id.IsNull then
    qrASP.Filter := 'ASF_ID=-1'
  else
    qrASP.Filter := 'ASF_ID='+qrAppointmentAsf_Id.AsString+' or ASF_ID=-1';
  qrASP.Filtered := True;
end;

procedure TfmASAppointments.qridAppointmentNumGetText(Sender: TObject;
  ANode: TdxTreeListNode; var AText: string);
begin
  AText := IntToStr(ANode.Index + 1);
end;

procedure TfmASAppointments.qrKPOSTBeforeOpen(DataSet: TDataSet);
begin
  qrKPOST.SQL[qrKPOST.SQL.Count-1] :=
      'ORDER BY '+iifStr(dmMain.isAbcSort, 'Post_Name', 'ASPost_Num');
end;

procedure TfmASAppointments.SetPostAndDep;
var
  q: TADOQuery;
  AFirst, ALast: Integer;

  function iNull(i: Integer): String;
  begin
    if i = -1 then
      Result := 'Null'
    else
      Result := IntToStr(i);
  end;

begin
  q := TADOQuery.Create(nil);
  with q do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;

    AFirst := -1; ALast := -1;
    SQL.Text := Format(
      'Select ID '+
      'From ASAppointment WHERE In_Date is not null and PERS_ID = %d '+
      'Order By In_Date Desc, ID Desc', [PERS_ID]);
    Open;
    if not Eof then begin
      ALast := Fields[0].AsInteger;
      Last;
      AFirst := Fields[0].AsInteger;
    end;
    Close;
    SQL.Text :=
      'Update Person Set '+
        'ASAppFirst = '+iNull(AFirst)+', '+
        'ASAppLast = '+iNull(ALast)+' '+
      'Where Pers_Id = '+IntToStr(Pers_Id);
    ExecSQL;
  finally Free;
  end;
end;

procedure TfmASAppointments.qrAppointmentBeforePost(DataSet: TDataSet);
begin
  with qrAppointment do begin
    if FieldByName('IN_DATE').IsNull
      then
        if FieldByName('IN_ORD_DATE').IsNull
          then begin
            msg.ShowErr('Ќе заполнено поле даты назначени€');
            qrAppointmentIN_DATE.FocusControl;
            Abort;
          end
          else FieldByName('IN_DATE').Value := FieldByName('IN_ORD_DATE').Value
      else
    if FieldByName('IN_ORD_DATE').IsNull
      then FieldByName('IN_ORD_DATE').Value := FieldByName('IN_DATE').Value;

    if (FieldByName('ASP_ID').AsInteger <= 0) and
       (FieldByName('ASF_ID').AsInteger > 0) then
      FieldByName('ASP_ID').AsInteger := -FieldByName('ASF_ID').AsInteger;
    if FieldByName('ASP_ID').AsInteger > 0 then begin
      if qrASP.Locate('ASP_ID', FieldByName('ASP_ID').AsInteger, []) then
        FieldByName('ASF_ID').AsInteger := qrASPAsf_Id.AsInteger;
    end;
  end;
end;


procedure TfmASAppointments.FormCreate(Sender: TObject);
begin
  qridAppointmentChangedColumnsWidth(Sender);
end;

procedure TfmASAppointments.qrAppointmentAfterDelete(DataSet: TDataSet);
begin
  SetPostAndDep;
end;

procedure TfmASAppointments.qrAppointmentAfterPost(DataSet: TDataSet);
begin
  SetPostAndDep;
end;

procedure TfmASAppointments.qrAppointmentBeforeDelete(DataSet: TDataSet);
begin
  if not Confirm('ƒействительно удалить?') then Abort;
end;

end.

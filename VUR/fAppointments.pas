unit fAppointments;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, DB, ADODB, dxDBTLCl, dxGrClms, dxTL, dxDBCtrl,
  dxDBGrid, dxCntner, dxBar, dxBarDBNav, FrmKeep, ComCtrls, cxClasses,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter;

type
  TfmAppointments = class(TForm)
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
    qridAppointmentWTP: TdxDBGridLookupColumn;
    qridAppointmentWCH: TdxDBGridLookupColumn;
    qridAppointmentPOST: TdxDBGridLookupColumn;
    qridAppointmentDEP: TdxDBGridLookupColumn;
    qridAppointmentIN_ORD_NUMB: TdxDBGridColumn;
    qridAppointmentIN_ORD_DATE: TdxDBGridDateColumn;
    dsAppointment: TDataSource;
    qrAppointment: TADOQuery;
    qrAppointmentID: TIntegerField;
    qrAppointmentPERS_ID: TIntegerField;
    qrKWKTYPE: TADOQuery;
    qrKWKCHAR: TADOQuery;
    qrKPOST: TADOQuery;
    qrKDEPART: TADOQuery;
    qrAppointmentWTP_ID: TIntegerField;
    qrKWKTYPEWTP_ID: TIntegerField;
    qrKWKTYPEWTP_NAME: TStringField;
    qrKWKCHARWCH_ID: TIntegerField;
    qrKWKCHARWCH_NAME: TStringField;
    qrKPOSTPOST_ID: TIntegerField;
    qrKPOSTPOST_NAME: TStringField;
    qrKDEPARTDEP_ID: TIntegerField;
    qrKDEPARTDEP_NAME: TStringField;
    qrAppointmentWCH_ID: TIntegerField;
    qrAppointmentPOST_ID: TIntegerField;
    qrAppointmentDEP_ID: TIntegerField;
    qrAppointmentWTP_NAME: TStringField;
    qrAppointmentWCH_NAME: TStringField;
    qrAppointmentPOST_NAME: TStringField;
    qrAppointmentDEP_NAME: TStringField;
    qrAppointmentIN_ORD_DATE: TDateField;
    qridAppointmentIN_DATE: TdxDBGridDateColumn;
    qrAppointmentIN_DATE: TDateField;
    StatusBar1: TStatusBar;
    qridAppointmentNum: TdxDBGridColumn;
    qrKPOSTXPost_Name: TWideStringField;
    qrKPOSTKPOST_Num: TIntegerField;
    qrKDEPARTXDep_Name: TWideStringField;
    qrKDEPARTKDEPART_Num: TIntegerField;
    qrAppointmentIN_ORD_NUMB: TStringField;
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
    procedure qridAppointmentChangedColumnsWidth(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PERS_ID, Post_Id, Dep_Id: Integer;
    procedure GetPostAndDep;
    procedure SetPostAndDep;
  end;

var
  fmAppointments: TfmAppointments;

procedure ShowAppointments(pPERS_ID: Integer);

implementation

uses dMain, Rdialogs, msg;

{$R *.dfm}

procedure ShowAppointments(pPERS_ID: Integer);
var
  I: Integer;
  f: TfmAppointments;
begin
  f := TfmAppointments.Create(Application);
  with f do try
    qrKPost.SQL[qrKPost.SQL.Count-1] :=
      'ORDER BY '+iifStr(dmMain.isAbcSort, 'Post_Name', 'KPOST_Num');
    qrKDepart.SQL[qrKDepart.SQL.Count-1] :=
      'ORDER BY '+iifStr(dmMain.isAbcSort, 'Dep_Name', 'KDEPART_Num');

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

procedure TfmAppointments.FormCloseQuery(Sender: TObject;
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

procedure TfmAppointments.qrAppointmentNewRecord(DataSet: TDataSet);
begin
  with qrAppointment do FieldByName('PERS_ID').Value := PERS_ID;
end;

procedure TfmAppointments.qridAppointmentChangedColumnsWidth(Sender: TObject);
begin
  qridAppointmentPOST.DropDownWidth := qridAppointmentPOST.Width * 2;
  qridAppointmentDep.DropDownWidth := qridAppointmentDep.Width * 2;
  qridAppointmentWTP.DropDownWidth := qridAppointmentWTP.Width * 2;
  qridAppointmentWCH.DropDownWidth := qridAppointmentWCH.Width * 2;
end;

procedure TfmAppointments.qridAppointmentColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := Column <> qridAppointmentNum;
end;

procedure TfmAppointments.qridAppointmentNumGetText(Sender: TObject;
  ANode: TdxTreeListNode; var AText: string);
begin
  AText := IntToStr(ANode.Index + 1);
end;

procedure TfmAppointments.SetPostAndDep;
var
  new_Post_Id, new_Dep_Id: Integer;
  q: TADOQuery;
  Study, NoStudy: TList;
  ALast, ALastAll, ALastStudy, AFirst, AFirstStudy: Integer;

  function iNull(i: Integer): String;
  begin
    if i = -1 then
      Result := 'Null'
    else
      Result := IntToStr(i);
  end;

begin
  new_Post_Id := -1; new_Dep_Id := -1;
  q := TADOQuery.Create(nil);
  with q do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := Format('SELECT Dismissal_Date, Out_Date From Person '+
      'WHERE PERS_ID = %d ', [PERS_ID]);
    Open;
    if Fields[0].IsNull and Fields[0].IsNull then begin
      Close;
      SQL.Text := Format('SELECT Post_Id, Dep_Id FROM Appointment '+
        'WHERE PERS_ID = %d AND IN_DATE IS NOT NULL AND '+
        'POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID <> 500 and CPROF2015_ID <> 500)'+
        'Order By In_Date Desc', [PERS_ID]);
      Open;
      if not IsEmpty then begin
        new_Post_Id := Fields[0].AsInteger;
        new_Dep_Id := Fields[1].AsInteger;
      end;
    end;
    Close;

    if (Dep_Id <> new_Dep_Id) or (Post_Id <> new_Post_Id) then begin
      SQL.Text :=
        'Update StaffList Set GeneralQty = GeneralQty - 1 '+
        'Where Dep_Id = '+IntToStr(Dep_Id)+' and Post_Id = '+IntToStr(Post_Id)+' and '+
          'GeneralQty > 0';
      ExecSQL;
      SQL.Text :=
        'Insert Into StaffList (Dep_Id, Post_Id, GeneralQty) '+
        'Select Top 1 '+IntToStr(new_Dep_Id)+', '+IntToStr(new_Post_Id)+', 0 '+
        'From VerInfo '+
        'Where not exists (select * from StaffList '+
          'Where Dep_Id = '+IntToStr(new_Dep_Id)+' and Post_Id = '+IntToStr(new_Post_Id)+')';
      ExecSQL;
      SQL.Text :=
        'Update StaffList Set GeneralQty = GeneralQty + 1 '+
        'Where Dep_Id = '+IntToStr(new_Dep_Id)+' and Post_Id = '+IntToStr(new_Post_Id);
      ExecSQL;
    end;
    Close;

    Study := TList.Create; NoStudy := TList.Create;
    SQL.Text := 'SELECT POST_ID FROM KPOST WHERE CPROF_ID = 500 or CPROF2015_ID = 500';
    Open;
    while not Eof do begin
      Study.Add(Pointer(Fields[0].AsInteger));
      Next;
    end;
    Close;
    SQL.Text := 'SELECT POST_ID FROM KPOST WHERE CPROF_ID <> 500 and CPROF2015_ID <> 500';
    Open;
    while not Eof do begin
      NoStudy.Add(Pointer(Fields[0].AsInteger));
      Next;
    end;
    Close;

    ALast  := -1; ALastAll  := -1; ALastStudy  := -1;
    AFirst := -1; AFirstStudy := -1;
    SQL.Text := Format(
      'Select ID, Post_Id '+
      'From Appointment WHERE In_Date is not null and PERS_ID = %d '+
      'Order By In_Date Desc, ID Desc', [PERS_ID]);
    Open;
    while not Eof do begin
      if ALastAll = -1 then ALastAll := Fields[0].AsInteger;
      if Study.IndexOf(Pointer(Fields[1].AsInteger)) >= 0 then begin
        AFirstStudy := Fields[0].AsInteger;
        if ALastStudy = -1 then ALastStudy := Fields[0].AsInteger;
      end;
      if NoStudy.IndexOf(Pointer(Fields[1].AsInteger)) >= 0 then begin
        AFirst := Fields[0].AsInteger;
        if ALast = -1 then ALast := Fields[0].AsInteger;
      end;
      //if (ALast <> -1) and (ALastStudy <> -1) then break;
      Next;
    end;
    Close;
    SQL.Text :=
      'Update Person Set '+
        'AppLast = '+iNull(ALast)+', '+
        'AppLastAll = '+iNull(ALastAll)+', '+
        'AppLastStudy = '+iNull(ALastStudy)+', '+
        'AppFirst = '+iNull(AFirst)+', '+
        'AppFirstStudy = '+iNull(AFirstStudy)+' '+
      'Where Pers_Id = '+IntToStr(Pers_Id);
    ExecSQL;

    Study.Free; NoStudy.Free;
  finally Free;
  end;
end;

procedure TfmAppointments.qrAppointmentBeforePost(DataSet: TDataSet);
begin
  with qrAppointment do begin
    if Pos('(упразднено)',qrAppointmentDep_Name.Value) > 0 then begin
      msg.ShowErr('ѕодразделение упразднено!');
      qrAppointmentDep_Name.FocusControl;
      Abort;
    end;
    if Pos('(упразднено)',qrAppointmentPost_Name.Value) > 0 then begin
      msg.ShowErr('ƒолжность упразднена!');
      qrAppointmentPost_Name.FocusControl;
      Abort;
    end;
    if FieldByName('IN_DATE').IsNull then
        if FieldByName('IN_ORD_DATE').IsNull then begin
            msg.ShowErr('Ќе заполнено поле даты назначени€');
            qrAppointmentIN_DATE.FocusControl;
            Abort;
          end else
            FieldByName('IN_DATE').Value := FieldByName('IN_ORD_DATE').Value
    else if FieldByName('IN_ORD_DATE').IsNull then
      FieldByName('IN_ORD_DATE').Value := FieldByName('IN_DATE').Value;
    GetPostAndDep;
  end;
end;

procedure TfmAppointments.FormCreate(Sender: TObject);
begin
  qridAppointmentChangedColumnsWidth(Sender);
end;

procedure TfmAppointments.GetPostAndDep;
begin
  Post_Id := -1; Dep_Id := -1;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := Format('SELECT Dismissal_Date, Out_Date From Person '+
      'WHERE PERS_ID = %d ', [PERS_ID]);
    Open;
    if Fields[0].IsNull and Fields[1].IsNull then begin
      Close;
      SQL.Text := Format('SELECT Post_Id, Dep_Id FROM Appointment '+
        'WHERE PERS_ID = %d AND IN_DATE IS NOT NULL AND '+
        'POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID <> 500 and CPROF2015_ID <> 500)'+
        'Order By In_Date Desc', [PERS_ID]);
      Open;
      if not IsEmpty then begin
        Post_Id := Fields[0].AsInteger;
        Dep_Id := Fields[1].AsInteger;
      end;
    end;
  finally Free;
  end;
end;

procedure TfmAppointments.qrAppointmentAfterDelete(DataSet: TDataSet);
begin
  SetPostAndDep;
end;

procedure TfmAppointments.qrAppointmentAfterPost(DataSet: TDataSet);
begin
  SetPostAndDep;
end;

procedure TfmAppointments.qrAppointmentBeforeDelete(DataSet: TDataSet);
begin
  if not Confirm('ƒействительно удалить?') then Abort;
  GetPostAndDep;
end;

end.

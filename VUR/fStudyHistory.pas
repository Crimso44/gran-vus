unit fStudyHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, DB, ADODB, dxDBTLCl, dxGrClms, dxTL, dxDBCtrl,
  dxDBGrid, dxCntner, dxBar, dxBarDBNav, ComCtrls, cxClasses,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter;

type
  TfmStudyHistory = class(TForm)
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
    qridStudyHistory: TdxDBGrid;
    qridStudyHistoryID: TdxDBGridColumn;
    qridStudyHistoryPERS_ID: TdxDBGridColumn;
    qridStudyHistoryPOST: TdxDBGridLookupColumn;
    qridStudyHistoryDEP: TdxDBGridLookupColumn;
    qridStudyHistoryIN_ORD_NUMB: TdxDBGridColumn;
    qridStudyHistoryIN_ORD_DATE: TdxDBGridDateColumn;
    dsAppointment: TDataSource;
    qrAppointment: TADOQuery;
    qrAppointmentID: TIntegerField;
    qrAppointmentPERS_ID: TIntegerField;
    qrKPOST: TADOQuery;
    qrKDEPART: TADOQuery;
    qrKPOSTPOST_ID: TIntegerField;
    qrKPOSTPOST_NAME: TStringField;
    qrKDEPARTDEP_ID: TIntegerField;
    qrKDEPARTDEP_NAME: TStringField;
    qrAppointmentPOST_ID: TIntegerField;
    qrAppointmentDEP_ID: TIntegerField;
    qrAppointmentPOST_NAME: TStringField;
    qrAppointmentDEP_NAME: TStringField;
    qrAppointmentIN_ORD_DATE: TDateField;
    qridStudyHistoryIN_DATE: TdxDBGridDateColumn;
    qrAppointmentIN_DATE: TDateField;
    StatusBar1: TStatusBar;
    qridStudyHistoryNum: TdxDBGridColumn;
    qrKPOSTXPost_Name: TWideStringField;
    qrKPOSTKPOST_Num: TIntegerField;
    qrKDEPARTXDep_Name: TWideStringField;
    qrKDEPARTKDEPART_Num: TIntegerField;
    qrAppointmentIN_ORD_NUMB: TStringField;
    qrKOVK: TADOQuery;
    qrKOVKOVK_ID: TIntegerField;
    qrKOVKOVK_NAME: TWideStringField;
    qrAppointmentOVK_ID: TIntegerField;
    qrAppointmentOVK_NAME: TStringField;
    qrAppointmentOVK_DATE: TDateField;
    qrAppointmentOVK_NUM: TStringField;
    qridStudyHistoryOVK_NAME: TdxDBGridLookupColumn;
    qridStudyHistoryOVK_DATE: TdxDBGridDateColumn;
    qridStudyHistoryOVK_NUM: TdxDBGridMaskColumn;
    qrAppointmentNAPR_ID: TIntegerField;
    qrNapr: TADOQuery;
    qrNaprNAPR_ID: TIntegerField;
    qrNaprNAPR_NAME: TWideStringField;
    qrAppointmentNAPR_NAME: TStringField;
    qridStudyHistoryNAPR_NAME: TdxDBGridLookupColumn;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure qrAppointmentNewRecord(DataSet: TDataSet);
    procedure qrAppointmentBeforePost(DataSet: TDataSet);
    procedure qrAppointmentBeforeDelete(DataSet: TDataSet);
    procedure qridStudyHistoryNumGetText(Sender: TObject; ANode: TdxTreeListNode;
      var AText: string);
    procedure qridStudyHistoryColumnSorting(Sender: TObject;
      Column: TdxDBTreeListColumn; var Allow: Boolean);
    procedure qrAppointmentAfterPost(DataSet: TDataSet);
    procedure qrAppointmentAfterDelete(DataSet: TDataSet);
    procedure qridStudyHistoryChangedColumnsWidth(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    PERS_ID, OVK_Id: Integer;
    procedure SetPostAndDep;
  end;

var
  fmStudyHistory: TfmStudyHistory;

procedure ShowStudyHistory(pPERS_ID, pOVK_ID: Integer);

implementation

uses dMain, Rdialogs, msg;

{$R *.dfm}

procedure ShowStudyHistory(pPERS_ID, pOVK_ID: Integer);
var
  I: Integer;
  f: TfmStudyHistory;
begin
  f := TfmStudyHistory.Create(Application);
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
    OVK_ID := pOVK_ID;
    qrAppointment.Parameters[0].Value := PERS_ID;
    if not dmMain.rEdit then qrAppointment.LockType := ltReadOnly;
    qrAppointment.Open;
    ShowModal;
  finally Free;
  end;
end;

procedure TfmStudyHistory.FormActivate(Sender: TObject);
begin
  qridStudyHistoryId.Visible := false;
end;

procedure TfmStudyHistory.FormCloseQuery(Sender: TObject;
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
      'POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID = 500 or CPROF2015_ID = 500)'+
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

procedure TfmStudyHistory.qrAppointmentNewRecord(DataSet: TDataSet);
begin
  with qrAppointment do begin
    FieldByName('PERS_ID').Value := PERS_ID;
    FieldByName('XOVK_ID').Value := OVK_ID;
  end;
end;

procedure TfmStudyHistory.qridStudyHistoryChangedColumnsWidth(Sender: TObject);
begin
  qridStudyHistoryPOST.DropDownWidth := qridStudyHistoryPOST.Width * 2;
  qridStudyHistoryDep.DropDownWidth := qridStudyHistoryDep.Width * 2;
end;

procedure TfmStudyHistory.qridStudyHistoryColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := Column <> qridStudyHistoryNum;
end;

procedure TfmStudyHistory.qridStudyHistoryNumGetText(Sender: TObject;
  ANode: TdxTreeListNode; var AText: string);
begin
  AText := IntToStr(ANode.Index + 1);
end;

procedure TfmStudyHistory.SetPostAndDep;
var
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
  q := TADOQuery.Create(nil);
  with q do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;

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

procedure TfmStudyHistory.qrAppointmentBeforePost(DataSet: TDataSet);
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
  end;
end;

procedure TfmStudyHistory.FormCreate(Sender: TObject);
begin
  qridStudyHistoryChangedColumnsWidth(Sender);
end;

procedure TfmStudyHistory.qrAppointmentAfterDelete(DataSet: TDataSet);
begin
  SetPostAndDep;
end;

procedure TfmStudyHistory.qrAppointmentAfterPost(DataSet: TDataSet);
begin
  SetPostAndDep;
end;

procedure TfmStudyHistory.qrAppointmentBeforeDelete(DataSet: TDataSet);
begin
  if not Confirm('ƒействительно удалить?') then Abort;
end;

end.

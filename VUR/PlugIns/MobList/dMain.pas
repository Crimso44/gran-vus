unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EkRtf, Db, ADODB, ekbasereport, ekfunc;

type
  TdmMain = class(TDataModule)
    EkRTF1: TEkRTF;
    dbMain: TADOConnection;
    qrPers: TADOQuery;
    qrWRng: TADOQuery;
    qrDep: TADOQuery;
    qrPersWRNG_NAME: TStringField;
    qrPersDEP_NAME: TStringField;
    qrPersRecNo: TIntegerField;
    qrOVK: TADOQuery;
    qrPersOVK_NAME: TStringField;
    qrPersDEP_ID: TIntegerField;
    qrDepSQL: TADOQuery;
    qrPersPost_Id: TIntegerField;
    qrPost: TADOQuery;
    qrPersPOST_NAME: TStringField;
    qrPersWRNG_Name1: TStringField;
    qrPersWRNG_ID: TIntegerField;
    qrPersOVK_ID: TIntegerField;
    qrPersPERS_ID: TIntegerField;
    qrPersORG_ID: TIntegerField;
    qrPersFAM: TWideStringField;
    qrPersIM: TWideStringField;
    qrPersOTCH: TWideStringField;
    qrPersMALE: TSmallintField;
    qrPersBIRTHDAY: TDateTimeField;
    qrPersBIRTHPLACE: TWideStringField;
    qrPersOKATO: TWideStringField;
    qrPersNAT_ID: TIntegerField;
    qrPersPSP_SER: TWideStringField;
    qrPersPSP_NUM: TWideStringField;
    qrPersPSP_PLACE: TWideStringField;
    qrPersPSP_DATE: TDateTimeField;
    qrPersINN: TWideStringField;
    qrPersSTRAH: TWideStringField;
    qrPersFST_ID: TIntegerField;
    qrPersED_ID: TIntegerField;
    qrPersSC_ID: TIntegerField;
    qrPersIS_WAR: TSmallintField;
    qrPersEOARMY_DATE: TWideStringField;
    qrPersCSOST: TSmallintField;
    qrPersWSOST_ID: TIntegerField;
    qrPersCAT_ZAP: TSmallintField;
    qrPersVUS: TWideStringField;
    qrPersWCAT: TWideStringField;
    qrPersWUCHET1: TWideStringField;
    qrPersSpecialWUchet1: TIntegerField;
    qrPersWUCHET2: TWideStringField;
    qrPersWDISCL: TWideStringField;
    qrPersTAB_NUMB: TWideStringField;
    qrPersDOG_NUMB: TWideStringField;
    qrPersDOG_DATE: TDateTimeField;
    qrPersIS_RAB: TSmallintField;
    qrPersPROF1: TWideStringField;
    qrPersOKPDTR1: TWideStringField;
    qrPersPROF2: TWideStringField;
    qrPersOKPDTR2: TWideStringField;
    qrPersCONFDATE: TDateTimeField;
    qrPersNUMB_T2: TIntegerField;
    qrPersW_DBEG: TDateTimeField;
    qrPersW_DEND: TDateTimeField;
    qrPersD_OVK: TDateTimeField;
    qrPersD_WBIL: TDateTimeField;
    qrPersOUT_ORD_NUMB: TWideStringField;
    qrPersOUT_ORD_DATE: TDateTimeField;
    qrPersOUT_DATE: TDateTimeField;
    qrPersWID: TWideStringField;
    qrPersWBser: TWideStringField;
    qrPersWBnum: TWideStringField;
    qrPersComments: TWideMemoField;
    qrPersWUCHET2_date: TDateTimeField;
    qrPersDocument: TIntegerField;
    qrPersBranch: TIntegerField;
    qrPersIsAspirant: TIntegerField;
    qrPersStudyEnd_date: TDateTimeField;
    qrPersOrderAkadem: TWideStringField;
    qrPersOrderAkadem_date: TDateTimeField;
    qrPersReasonAkadem: TWideStringField;
    qrPersBeginAkadem_date: TDateTimeField;
    qrPersEndAkadem_date: TDateTimeField;
    qrPersRealEndAkadem_date: TDateTimeField;
    qrPersMedResult_date: TDateTimeField;
    qrPersMedResult: TIntegerField;
    qrPersVKStatus: TIntegerField;
    qrPersBeginWar_date: TDateTimeField;
    qrPersEndWar_date: TDateTimeField;
    qrPersRealEndWar_date: TDateTimeField;
    qrPersReasonEndWar: TWideStringField;
    qrPersDismissal_date: TDateTimeField;
    qrPersOrderDismissal: TWideStringField;
    qrPersOrderDismissal_date: TDateTimeField;
    qrPersReasonDismissal: TWideStringField;
    qrPersDisserName: TWideStringField;
    qrPersDegree_ID: TIntegerField;
    qrPersGuideDegree_ID: TIntegerField;
    qrPersFIOGuide: TWideStringField;
    qrPersDefend_date: TDateTimeField;
    qrPersRealDefend_date: TDateTimeField;
    qrPersContractEnd: TWideStringField;
    qrPersStudyForm: TIntegerField;
    qrPersKval_Id: TIntegerField;
    qrPersDelay_ID: TIntegerField;
    qrPersDelayStart_date: TDateTimeField;
    qrPersDelayEnd_date: TDateTimeField;
    qrPersHealth: TWideStringField;
    qrPersHealthDocNo: TWideStringField;
    qrPersHealthDoc_date: TDateTimeField;
    qrPersWarfare: TWideStringField;
    qrPersASOrder_In: TWideStringField;
    qrPersASDate_In: TDateTimeField;
    qrPersASOut_ORD_NUMB: TWideStringField;
    qrPersASOut_ORD_Date: TDateTimeField;
    qrPersASOut_Date: TDateTimeField;
    qrPersAppLast: TIntegerField;
    qrPersAppLastAll: TIntegerField;
    qrPersAppLastStudy: TIntegerField;
    qrPersASAppLast: TIntegerField;
    qrPersASAppFirst: TIntegerField;
    qrPersAppFirst: TIntegerField;
    qrPersAppFirstStudy: TIntegerField;
    qrPersMed_Where: TWideStringField;
    qrPersMed_Date: TDateTimeField;
    qrPersMed_Result: TWideStringField;
    qrPersPsy_Where: TWideStringField;
    qrPersPsy_Date: TDateTimeField;
    qrPersPsy_Result: TWideStringField;
    qrPersAsf_Sport: TWideStringField;
    qrPersMob_Days: TIntegerField;
    qrPersMob_Hours: TIntegerField;
    qrPersMob_Mins: TIntegerField;
    qrPersMob_CardDate: TDateTimeField;
    qrPersMob_MissReason: TWideStringField;
    qrPersWUCHET2_Ser: TWideStringField;
    qrPersWUCHET2_IsWork: TIntegerField;
    qrPersPDPCode: TWideStringField;
    qrPersWRNG_Date: TDateTimeField;
    qrPersdeadline: TStringField;
    qrPersMob_Place: TStringField;
    EkUDFList1: TEkUDFList;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrPersBeforeOpen(DataSet: TDataSet);
    procedure qrPersAfterClose(DataSet: TDataSet);
    procedure qrPersCalcFields(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure EkUDFList1Functions0Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions1Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions2Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    { Private declarations }
    FOrgID: Integer;
    procedure FillExecutor;
  public
    { Public declarations }
    ListOVK: TStringList;
    WSost: array[0..3] of boolean;
    sWhere: String;
    IsJet: Boolean;
    function OpenData(ID: Integer): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Список лиц, имеющих мобпредписание';

implementation

{$R *.DFM}

uses SaveEvents, IniSupport;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  ListOVK := TStringList.Create;
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'moblist.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Список лиц, имеющих мобпредписание.rtf';
end;

procedure TdmMain.qrPersBeforeOpen(DataSet: TDataSet);
var  i: Integer;
    tbl: TADOTable;
    sDate: String;
begin
  sDate := 'Date()';
  if not IsJet then
    sDate := 'GetDate()';

  qrWrng.Open;
  qrPost.Open;
  try
    qrDep.Open;
  except
    qrDepSQL.Open;
    qrDep := qrDepSQL;
    qrPers.SQL.Text := 'SELECT PERSON.*, app.DEP_ID, app.Post_Id'#13 +
      'FROM (PERSON'#13 +
      '     LEFT OUTER JOIN AppointmentLast app on PERSON.Pers_Id = app.Pers_Id)'#13 +
      'left outer join KDepart on KDepart.dep_id = app.dep_id'#13 +
    'WHERE (WUCHET1 IS NOT NULL)'#13+
    'AND (WUCHET1<>'''') AND (W_DEND is NULL or Year(W_DEND) >= Year('+sDate+'())) AND IS_WAR<>0'+
    sWhere;
//    qrPers.SQL.Text := StringReplace(qrPers.SQL.Text, 'Date()', 'getdate()', [rfReplaceAll, rfIgnoreCase]);
  end;
  qrOVK.Open;
  if qrPers.Fields.Count>7 then Exit;
  tbl := TADOTable.Create(Self);
  tbl.Connection := dbMain;
  tbl.TableName := 'PERSON';
  tbl.Open;
  qrPers.FieldDefs.Clear;
  for i:=0 to tbl.Fields.Count-1 do
    if qrPers.FindField(tbl.Fields[i].FieldName)=nil then
      with qrPers.FieldDefs.AddFieldDef do begin
        Name := tbl.Fields[i].FieldName;
        DataType := tbl.Fields[i].DataType;
        Size := tbl.Fields[i].Size;
        CreateField(Self);
      end;
  tbl.Free;
end;

procedure TdmMain.qrPersAfterClose(DataSet: TDataSet);
begin
  qrWRng.Close;
  qrDep.Close;
  qrPost.Close;
  qrOVK.Close;
end;

procedure TdmMain.qrPersCalcFields(DataSet: TDataSet);
var
  deadline: string;
  comma: boolean;
begin
  if qrPers.RecNo<0 then qrPersRecNo.Value := 1
  else qrPersRecNo.Value := qrPers.RecNo;
  if qrWrng.Locate('WRNG_ID',qrPers.FieldByName('WRNG_ID').Value,[]) then
    qrPersWRNG_NAME.Value := qrWrng.FieldByName('WRNG_NAME').AsString
  else
    qrPersWRNG_NAME.Value := EmptyStr;
  if qrDep.Locate('DEP_ID',qrPers.FieldByName('DEP_ID').Value,[]) then
    qrPersDEP_NAME.Value := qrDep.FieldByName('DEP_NAME').AsString
  else
    qrPersDEP_NAME.Value := EmptyStr;
  if qrPost.Locate('POST_ID',qrPers.FieldByName('POST_ID').Value,[]) then
    qrPersPOST_NAME.Value := qrPost.FieldByName('POST_NAME').AsString
  else
    qrPersPOST_NAME.Value := EmptyStr;
  if qrOVK.Locate('OVK_ID',qrPers.FieldByName('OVK_ID').Value,[]) then
    qrPersOVK_NAME.Value := qrOVK.FieldByName('OVK_NAME').AsString
  else
    qrPersOVK_NAME.Value := EmptyStr;
  deadline := EmptyStr;
  comma := false;
  if qrPersMob_Days.AsInteger <> 0 then begin
    deadline := qrPersMob_Days.AsString + ' суток';
    comma := true;
  end;
  if qrPersMob_Hours.AsInteger <> 0 then begin
    if comma then
      deadline := deadline + ', ';
    deadline := deadline + qrPersMob_Hours.AsString + ' часов';
    comma := true;
  end;
  if qrPersMob_Mins.AsInteger <> 0 then begin
    if comma then
      deadline := deadline + ', ';
    deadline := deadline + qrPersMob_Mins.AsString + ' минут';
  end;
  qrPersDeadline.AsString := deadline;
end;

function TdmMain.OpenData(ID: Integer): boolean;
var s,ss: string;
    i: Integer;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  sWhere := '';
  if dmMain.WSost[0] then sWhere := sWhere + 'WSost_Id > 3 or ';
  if dmMain.WSost[1] then sWhere := sWhere + 'WSost_Id = 3 or ';
  if dmMain.WSost[2] then sWhere := sWhere + 'WSost_Id = 2 or ';
  if dmMain.WSost[3] then sWhere := sWhere + 'WSost_Id = 1 or ';
  sWhere := ' and ('+Copy(sWhere, 1, Length(sWhere)-4)+') ';
  qrPers.SQL.Add(sWhere);

  if ListOVK.Count>0 then begin
    s := EmptyStr;
    ss := 'по ';
    for i:=0 to ListOVK.Count-1 do begin
      s := s + IntToStr(Integer(ListOVK.Objects[i]))+',';
      ss := ss + ListOVK[i]+', ';
    end;
    SetLength(s,Length(s)-1);
    qrPers.SQL.Add('AND OVK_ID IN ('+s+')');
    SetLength(ss,Length(ss)-2);
    EkRTF1.CreateVar('OVK_STR',ss);
  end;
  qrPers.SQL.Add('Order by dep_name, iif(wsost_id>3,4,wsost_id) desc, fam, im, otch');

  if not IsJet then
    qrPers.SQL.Text := StringReplace(qrPers.SQL.Text, 'Date()', 'GetDate()', [rfReplaceAll]);

  try
    qrPers.Open;
    with TADOQuery.Create(Self) do
    try
      Connection := dbMain;
      SQL.Text := 'select * from ORG_CONT where IS_GEN<>0';
      Open;
      if IsEmpty then begin
        FOrgID := -1;
        EkRTF1.CreateVar('GenPOST','Руководитель');
        EkRTF1.CreateVar('GenIOFam','И.О. Фамилия');
      end
      else begin
        FOrgID := FieldByName('ORGID').AsInteger;
        EkRTF1.CreateVar('GenPOST',FieldByName('POST').AsString);
        EkRTF1.CreateVar('GenIOFam',
          (FieldByName('IM').AsString+' ')[1]+'.'+
          (FieldByName('OTCH').AsString+' ')[1]+'. '+
          FieldByName('FAM').AsString);
      end;
      Close;
      SQL.Text := 'select * from ORG';
      Open;
      s := FieldByName('OrgName').AsString;
      if s = '' then
        s := FieldByName('OrgSName').AsString;
      EkRTF1.CreateVar('OrgName',s);
    finally
      Free;
    end;
    Result := true;
  except
    Result := false;
  end;
end;

function TdmMain.PrintData: boolean;
begin
  try
    FillExecutor;
    EkRTF1.ExecuteOpen([qrPers],SW_SHOWDEFAULT);
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['ОВК: '+ListOVK.CommaText,
       'Номер организации: '+IntToStr(FOrgID)]);
    Result := true;
  except
    Result := false;
  end;
end;


procedure TdmMain.FillExecutor;
var
  qrExecutor: TADOQuery;
begin
  qrExecutor := TADOQuery.Create(Self);
  qrExecutor.Connection := dmMain.dbMain;
  qrExecutor.SQL.Text := 'Select * from ORG_Cont where Is_Gen = 3';
  qrExecutor.Open;
  if qrExecutor.Eof then begin
    EkRtf1.CreateVar('ExecutorFam', '');
    EkRtf1.CreateVar('ExecutorIm', '');
    EkRtf1.CreateVar('ExecutorOtch', '');
    EkRtf1.CreateVar('ExecutorPhone', '');
    EkRtf1.CreateVar('ExecutorPost', '');
    EkRtf1.CreateVar('Executor', false);
  end else begin
    EkRtf1.CreateVar('Executor',
      Trim(
        qrExecutor.FieldByName('Fam').AsString + qrExecutor.FieldByName('Im').AsString + qrExecutor.FieldByName('Otch').AsString
      ) <> '');
    EkRtf1.CreateVar('ExecutorFam', qrExecutor.FieldByName('Fam').AsString);
    EkRtf1.CreateVar('ExecutorIm', qrExecutor.FieldByName('Im').AsString);
    EkRtf1.CreateVar('ExecutorOtch', qrExecutor.FieldByName('Otch').AsString);
    EkRtf1.CreateVar('ExecutorPhone', qrExecutor.FieldByName('Phone').AsString);
    EkRtf1.CreateVar('ExecutorPost', qrExecutor.FieldByName('Post').AsString);
  end;
  qrExecutor.Close;
end;


procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  ListOVK.Free;
end;

procedure TdmMain.EkUDFList1Functions0Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  (UDFResult as TEkReportVariable).AsString := FormatDateTime('dd.mm.yyyy',Date);
end;

procedure TdmMain.EkUDFList1Functions1Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
function CheckNull(O: TObject): Boolean;
begin
  if O is TField then Result := TField(O).IsNull or (TField(O).AsString='')
  else Result := Trim(TEkReportVariable(O).AsString) <> '';
end;
var
  I: integer;
  B: boolean;
begin
  B := True;
  for I := 0 to Length(Args)-1 do B := B and not CheckNull(Args[I]);
  (UDFResult as TEkReportVariable).AsBoolean := B;
end;

procedure TdmMain.EkUDFList1Functions2Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
  function ToString(O: TObject): string;
  begin
    if O is TField then Result := TField(O).AsString
    else Result := TEkReportVariable(O).AsString;
  end;
var res: string;
begin
  res :=
    (ToString(Args[0])+' ')[1] + '. ' +
    (ToString(Args[1])+' ')[1] + '. ' +
    ToString(Args[2]);
  (UDFResult as TEkReportVariable).AsString := res;
end;

end.

unit dMain;

interface

uses
  SysUtils, Classes, DB, ADODB, ekbasereport, ekrtf, Dialogs, Forms, Windows,
  ekfunc;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    qrOVK: TADOQuery;
    EkRTF1: TEkRTF;
    qrOrg: TADOQuery;
    qrVUR: TADOQuery;
    qrGen: TADOQuery;
    qrPerson: TADOQuery;
    qrVURCONTID: TIntegerField;
    qrVURORGID: TIntegerField;
    qrVURDEPART: TWideStringField;
    qrVURPOST: TWideStringField;
    qrVURFIO: TWideStringField;
    qrVURPHONE: TWideStringField;
    qrVURFAX: TWideStringField;
    qrVUREMAIL: TWideStringField;
    qrVURIS_GEN: TSmallintField;
    qrVURIS_VUS: TSmallintField;
    qrVURFAM: TWideStringField;
    qrVURIM: TWideStringField;
    qrVUROTCH: TWideStringField;
    qrVURIOFam: TStringField;
    qrVURFamIO: TStringField;
    qrGenCONTID: TIntegerField;
    qrGenORGID: TIntegerField;
    qrGenDEPART: TWideStringField;
    qrGenPOST: TWideStringField;
    qrGenFIO: TWideStringField;
    qrGenPHONE: TWideStringField;
    qrGenFAX: TWideStringField;
    qrGenEMAIL: TWideStringField;
    qrGenIS_GEN: TSmallintField;
    qrGenIS_VUS: TSmallintField;
    qrGenFAM: TWideStringField;
    qrGenIM: TWideStringField;
    qrGenOTCH: TWideStringField;
    qrGenIOFam: TStringField;
    qrGenFamIO: TStringField;
    qrUpdate: TADOQuery;
    EkUDFList1: TEkUDFList;
    qrPersonPERS_ID: TIntegerField;
    qrPersonORG_ID: TIntegerField;
    qrPersonFAM: TWideStringField;
    qrPersonIM: TWideStringField;
    qrPersonOTCH: TWideStringField;
    qrPersonMALE: TSmallintField;
    qrPersonBIRTHDAY: TDateTimeField;
    qrPersonBIRTHPLACE: TWideStringField;
    qrPersonOKATO: TWideStringField;
    qrPersonNAT_ID: TIntegerField;
    qrPersonPSP_SER: TWideStringField;
    qrPersonPSP_NUM: TWideStringField;
    qrPersonPSP_PLACE: TWideStringField;
    qrPersonPSP_DATE: TDateTimeField;
    qrPersonINN: TWideStringField;
    qrPersonSTRAH: TWideStringField;
    qrPersonFST_ID: TIntegerField;
    qrPersonED_ID: TIntegerField;
    qrPersonSC_ID: TIntegerField;
    qrPersonIS_WAR: TSmallintField;
    qrPersonEOARMY_DATE: TWideStringField;
    qrPersonCSOST: TSmallintField;
    qrPersonWSOST_ID: TIntegerField;
    qrPersonCAT_ZAP: TSmallintField;
    qrPersonVUS: TWideStringField;
    qrPersonWCAT: TWideStringField;
    qrPersonOVK_ID: TIntegerField;
    qrPersonWUCHET1: TWideStringField;
    qrPersonSpecialWUchet1: TIntegerField;
    qrPersonWUCHET2: TWideStringField;
    qrPersonWDISCL: TWideStringField;
    qrPersonTAB_NUMB: TWideStringField;
    qrPersonDOG_NUMB: TWideStringField;
    qrPersonDOG_DATE: TDateTimeField;
    qrPersonIS_RAB: TSmallintField;
    qrPersonPROF1: TWideStringField;
    qrPersonOKPDTR1: TWideStringField;
    qrPersonPROF2: TWideStringField;
    qrPersonOKPDTR2: TWideStringField;
    qrPersonCONFDATE: TDateTimeField;
    qrPersonNUMB_T2: TIntegerField;
    qrPersonW_DBEG: TDateTimeField;
    qrPersonW_DEND: TDateTimeField;
    qrPersonD_OVK: TDateTimeField;
    qrPersonD_WBIL: TDateTimeField;
    qrPersonOUT_ORD_NUMB: TWideStringField;
    qrPersonOUT_ORD_DATE: TDateTimeField;
    qrPersonOUT_DATE: TDateTimeField;
    qrPersonWID: TWideStringField;
    qrPersonWBser: TWideStringField;
    qrPersonWBnum: TWideStringField;
    qrPersonWUCHET2_date: TDateTimeField;
    qrPersonDocument: TIntegerField;
    qrPersonBranch: TIntegerField;
    qrPersonIsAspirant: TIntegerField;
    qrPersonStudyEnd_date: TDateTimeField;
    qrPersonOrderAkadem: TWideStringField;
    qrPersonOrderAkadem_date: TDateTimeField;
    qrPersonReasonAkadem: TWideStringField;
    qrPersonBeginAkadem_date: TDateTimeField;
    qrPersonEndAkadem_date: TDateTimeField;
    qrPersonRealEndAkadem_date: TDateTimeField;
    qrPersonMedResult_date: TDateTimeField;
    qrPersonMedResult: TIntegerField;
    qrPersonVKStatus: TIntegerField;
    qrPersonBeginWar_date: TDateTimeField;
    qrPersonEndWar_date: TDateTimeField;
    qrPersonRealEndWar_date: TDateTimeField;
    qrPersonReasonEndWar: TWideStringField;
    qrPersonDismissal_date: TDateTimeField;
    qrPersonOrderDismissal: TWideStringField;
    qrPersonOrderDismissal_date: TDateTimeField;
    qrPersonReasonDismissal: TWideStringField;
    qrPersonDisserName: TWideStringField;
    qrPersonDegree_ID: TIntegerField;
    qrPersonGuideDegree_ID: TIntegerField;
    qrPersonFIOGuide: TWideStringField;
    qrPersonDefend_date: TDateTimeField;
    qrPersonRealDefend_date: TDateTimeField;
    qrPersonContractEnd: TWideStringField;
    qrPersonStudyForm: TIntegerField;
    qrPersonKval_Id: TIntegerField;
    qrPersonDelay_ID: TIntegerField;
    qrPersonDelayStart_date: TDateTimeField;
    qrPersonDelayEnd_date: TDateTimeField;
    qrPersonHealth: TWideStringField;
    qrPersonHealthDocNo: TWideStringField;
    qrPersonHealthDoc_date: TDateTimeField;
    qrPersonWRNG_NAME: TWideStringField;
    qrPersonM_LIMIT: TSmallintField;
    qrPersonFEM_LIMIT: TSmallintField;
    qrPersonSTATE: TSmallintField;
    qrPersonZAP: TWideStringField;
    qrPersonGODN: TWideStringField;
    qrPersonCHE: TIntegerField;
    qrPersonZAPSTATE: TIntegerField;
    qrPersonLIMIT1: TIntegerField;
    qrPersonLIMIT2: TIntegerField;
    qrPersonLIMIT3: TIntegerField;
    qrPersonGROUP_NAME: TWideStringField;
    qrPersonOLDVALUE: TWideMemoField;
    qrPersonNEWVALUE: TWideMemoField;
    qrPersonSEND_DATE: TDateTimeField;
    qrPersonWuchet: TStringField;
    qrPersonRecNo: TIntegerField;
    qrPersonBEG: TStringField;
    qrPersonComments: TWideMemoField;
    qrPersonWarfare: TWideStringField;
    qrPersonWUchet2_IsWork: TIntegerField;
    qrPersonAddInfo: TStringField;
    qrPersonGroup_Id: TIntegerField;
    qrPersonASOrder_In: TWideStringField;
    qrPersonASDate_In: TDateTimeField;
    qrPersonASOut_ORD_NUMB: TWideStringField;
    qrPersonASOut_ORD_Date: TDateTimeField;
    qrPersonASOut_Date: TDateTimeField;
    qrPersonAppLast: TIntegerField;
    qrPersonAppLastAll: TIntegerField;
    qrPersonAppLastStudy: TIntegerField;
    qrPersonAppFirst: TIntegerField;
    qrPersonAppFirstStudy: TIntegerField;
    qrPersonASAppLast: TIntegerField;
    qrPersonASAppFirst: TIntegerField;
    qrPersonMed_Where: TWideStringField;
    qrPersonMed_Date: TDateTimeField;
    qrPersonMed_Result: TWideStringField;
    qrPersonPsy_Where: TWideStringField;
    qrPersonPsy_Date: TDateTimeField;
    qrPersonPsy_Result: TWideStringField;
    qrPersonAsf_Sport: TWideStringField;
    qrPersonMob_Days: TIntegerField;
    qrPersonMob_Hours: TIntegerField;
    qrPersonMob_Mins: TIntegerField;
    qrPersonMob_CardDate: TDateTimeField;
    qrPersonMob_MissReason: TWideStringField;
    qrPersonWUCHET2_Ser: TWideStringField;
    qrPersonPDPCode: TWideStringField;
    qrPersonin_date: TDateTimeField;
    qrPersonin_ord_numb: TWideStringField;
    qrPersonin_ord_date: TDateTimeField;
    qrPersonWRNG_Name1: TStringField;
    qrPersonOKVED_OKPDTR: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
    procedure qrPersonCalcFields(DataSet: TDataSet);
    procedure qrVURCalcFields(DataSet: TDataSet);
    procedure EkUDFList1Functions0Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions1Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions2Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    FOrgID: Integer;
  public
    ListOVK: TStringList;
    Date_From, Date_To: TDateTime;
    All: Boolean;
    UseSend_Date: Boolean;
    Send_Date: TDateTime;
    IsJet: Boolean;
    function OpenData(OrgId: Integer): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Сведения об изменениях';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils, Variants;

function TdmMain.OpenData(OrgId: Integer): boolean;
var
  sDate: String;
begin
  sDate := 'Date()';
  if not IsJet then begin
    sDate := 'GetDate()';
    qrOVK.SQL.Text := StringReplace(qrOVK.SQL.Text, '(IsOVK', '(IsOVK=1', [rfReplaceAll]);
    qrPerson.SQL.Text := StringReplace(qrPerson.SQL.Text, 'Date()', 'GetDate()', [rfReplaceAll]);
    qrPerson.SQL.Text := StringReplace(qrPerson.SQL.Text, 'CStr(pc1.BEGIN_DATE)', 'convert(varchar,pc1.BEGIN_DATE,104)', [rfReplaceAll]);
    qrUpdate.SQL.Text := StringReplace(qrUpdate.SQL.Text, 'Date()', 'GetDate()', [rfReplaceAll]);
    qrUpdate.SQL[0] :=
      'update PersonChanges set SEND_DATE = :SEND_DATE from PersonChanges pc inner join PERSON P on pc.PERS_ID = P.PERS_ID';
  end;

  FOrgID := OrgID;
  try
    qrOVK.SQL.Add('WHERE ');
    if ListOVK.Count>0 then
      qrOVK.SQL.Add('OVK_ID in ('+ListOVK.CommaText+') AND ');

    qrOVK.SQL.Add('EXISTS(SELECT 1 FROM PERSON '+
                  'INNER JOIN PersonChanges pc on pc.PERS_ID = PERSON.PERS_ID ' +
                                'WHERE OVK_ID=KOVK.OVK_ID '+
                                  'AND IS_WAR<>0 '+
                                  'AND (W_DEND is null or Year(W_DEND) >= Year('+sDate+'))'+
//                                    'AND WRNG_ID<>1 '+
                                  'AND '+
    '(((select max(In_Date) from Appointment where pers_id = PERSON.pers_id and ' +
    'post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND ' +
    'PERSON.OUT_ORD_DATE IS NULL) OR '+
    '((select max(In_Date) from Appointment where pers_id = PERSON.pers_id and ' +
    'post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND ' +
    'PERSON.ORDERDISMISSAL_DATE IS NULL))');
    qrOVK.SQL.Add(' AND pc.CHANGE_DATE >= :Date_From AND pc.CHANGE_DATE <= :Date_To');
    if All then qrOVK.SQL.Add(' AND pc.SEND_DATE is null');
    qrOVK.SQL.Add(')');
    qrOVK.SQL.Add('ORDER BY OVK_NAME');
    qrOVK.Parameters.ParseSQL(qrOVK.SQL.Text, True);
    qrOVK.Parameters.ParamByName('Date_From').Value := Date_From;
    qrOVK.Parameters.ParamByName('Date_To').Value := Date_To;
    qrOVK.Open;
    qrOrg.SQL.Add('WHERE ORGID='+IntToStr(OrgId));
    qrOrg.Open;
    qrVUR.SQL.Add('WHERE IS_VUS=1 AND ORGID='+IntToStr(OrgId));
    qrVUR.Open;

    ListOVK.Clear;
    qrOVK.First;
    while not qrOVK.Eof do begin
      ListOVK.Add(qrOVK.FieldByName('OVK_ID').AsString);
      qrOVK.Next;
    end;
    qrOVK.First;
    with TADOQuery.Create(nil) do
    try
      Connection := dbMain;
      SQL.Text := 'SELECT Param_Value FROM Params where Param_ID = 1';
      Open;
      qrGen.SQL.Add('WHERE ' + IfThen(Fields[0].AsString = '1', 'IS_VUS', 'IS_GEN') +
                    '=1 AND ORGID='+IntToStr(OrgId));
    finally Free;
    end;

    qrGen.Open;
    Result := true;
  except
    Result := false;
  end;
end;

function TdmMain.PrintData: boolean;
var
  i: Integer;
begin
  //try
    if IsJet then begin
      qrPerson.SQL.Add(' and not exists (select 1 from PersonChanges where PERS_ID = pc1.PERS_ID and GROUP_ID = pc1.GROUP_ID and (CHANGE_DATE < pc1.CHANGE_DATE or (CHANGE_DATE = pc1.CHANGE_DATE and CHANGE_ID < pc1.CHANGE_ID)) and CHANGE_DATE >= ' + StringReplace(FormatDateTime('#yyyy.mm.dd#', Date_From), '.', '/', [rfReplaceAll]) + ')');
      qrPerson.SQL.Add(' and not exists (select 1 from PersonChanges where PERS_ID = pc2.PERS_ID and GROUP_ID = pc2.GROUP_ID and (CHANGE_DATE > pc2.CHANGE_DATE or (CHANGE_DATE = pc2.CHANGE_DATE and CHANGE_ID > pc2.CHANGE_ID)) and CHANGE_DATE <= ' + StringReplace(FormatDateTime('#yyyy.mm.dd#', Date_To), '.', '/', [rfReplaceAll]) + ')');
      qrPerson.SQL.Add(' AND pc1.CHANGE_DATE >= ' + StringReplace(FormatDateTime('#yyyy.mm.dd#', Date_From), '.', '/', [rfReplaceAll]) + ' AND pc1.CHANGE_DATE <= ' + StringReplace(FormatDateTime('#yyyy.mm.dd#', Date_To), '.', '/', [rfReplaceAll]));
      qrPerson.SQL.Add(' AND pc2.CHANGE_DATE >= ' + StringReplace(FormatDateTime('#yyyy.mm.dd#', Date_From), '.', '/', [rfReplaceAll]) + ' AND pc2.CHANGE_DATE <= ' + StringReplace(FormatDateTime('#yyyy.mm.dd#', Date_To), '.', '/', [rfReplaceAll]));
    end else begin
      qrPerson.SQL.Add(' and not exists (select 1 from PersonChanges where PERS_ID = pc1.PERS_ID and GROUP_ID = pc1.GROUP_ID and (CHANGE_DATE < pc1.CHANGE_DATE or (CHANGE_DATE = pc1.CHANGE_DATE and CHANGE_ID < pc1.CHANGE_ID)) and CHANGE_DATE >= convert(datetime,''' + FormatDateTime('dd.mm.yyyy', Date_From) + ''',104))');
      qrPerson.SQL.Add(' and not exists (select 1 from PersonChanges where PERS_ID = pc2.PERS_ID and GROUP_ID = pc2.GROUP_ID and (CHANGE_DATE > pc2.CHANGE_DATE or (CHANGE_DATE = pc2.CHANGE_DATE and CHANGE_ID > pc2.CHANGE_ID)) and CHANGE_DATE <= convert(datetime,''' + FormatDateTime('dd.mm.yyyy', Date_To) + ''',104))');
      qrPerson.SQL.Add(' AND pc1.CHANGE_DATE >= convert(datetime,''' + FormatDateTime('dd.mm.yyyy', Date_From) + ''',104) AND pc1.CHANGE_DATE <= convert(datetime,''' + FormatDateTime('dd.mm.yyyy', Date_To) + ''',104)');
      qrPerson.SQL.Add(' AND pc2.CHANGE_DATE >= convert(datetime,''' + FormatDateTime('dd.mm.yyyy', Date_From) + ''',104) AND pc2.CHANGE_DATE <= convert(datetime,''' + FormatDateTime('dd.mm.yyyy', Date_To) + ''',104)');
    end;
    if All then qrPerson.SQL.Add(' AND pc1.SEND_DATE is null AND pc2.SEND_DATE is null');
    qrPerson.SQL.Add('ORDER BY P.FAM, P.IM, P.OTCH');
    qrPerson.Parameters.Clear;
    qrPerson.Parameters.ParseSQL(qrPerson.SQL.Text, True);
    qrPerson.Parameters.ParamByName('OVK_ID').Value := 0;
    //qrPerson.Open;
    EkRTF1.ExecuteOpen([qrOrg,qrVUR,qrGen,qrOVK,qrPerson],SW_SHOWDEFAULT);
    Result := true;
    if UseSend_Date then begin
      if All then qrUpdate.SQL.Add(' AND pc.SEND_DATE is null');
      for i := 0 to ListOVK.Count - 1 do begin
        qrUpdate.Parameters.ParamByName('OVK_ID').Value := ListOVK[i];
        qrUpdate.Parameters.ParamByName('Date_From').Value := Date_From;
        qrUpdate.Parameters.ParamByName('Date_To').Value := Date_To;
        qrUpdate.Parameters.ParamByName('SEND_DATE').Value := Send_Date;
        qrUpdate.ExecSQL;
      end;
    end;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(FOrgID),
       'ОВК: '+ListOVK.CommaText]);
  (*except
    on e: exception do begin
      ShowMessage(e.Message);
      Result := false;
    end;
  end;*)
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  ListOVK := TStringList.Create;
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'PersChanges.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Сведения об изменениях.rtf';
end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  ListOVK.Free;
end;

procedure TdmMain.EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
begin
  if ScanInfo.DataSet=qrOVK then begin
    qrPerson.Close;
    qrPerson.Parameters.ParamByName('OVK_ID').Value :=
      qrOVK.FieldByName('OVK_ID').AsInteger;
    qrPerson.Open;
  end;
end;

procedure TdmMain.EkUDFList1Functions0Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
var
  I: integer;
  B: boolean;
begin
  B := True;
  for I := 0 to Length(Args)-1 do B := B and not (TField(Args[I]).IsNull or (TField(Args[I]).AsString=''));
  (UDFResult as TEkReportVariable).AsBoolean := B;
end;

procedure TdmMain.EkUDFList1Functions1Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
  function GetInt(O: TObject): Integer;
  begin
    if O is TField then Result := TField(O).AsInteger else Result := TEkReportVariable(O).AsInteger;
  end;
var
  i: Integer;
begin
  (UDFResult as TEkReportVariable).AsBoolean := False;
  for i:=1 to ArgCount-1 do
    if GetInt(Args[0])=GetInt(Args[i]) then
    begin
      (UDFResult as TEkReportVariable).AsBoolean := True;
      Exit;
    end;
end;

procedure TdmMain.EkUDFList1Functions2Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  (UDFResult as TEkReportVariable).AsString := FormatDateTime('dd.mm.yyyy',Date)
end;

procedure TdmMain.qrPersonCalcFields(DataSet: TDataSet);
var s: string;
begin
  if qrPerson.RecNo<=1 then
    qrPersonRecNo.Value := 1
  else
    qrPersonRecNo.Value := qrPerson.RecNo;
  if qrPersonWUchet2_IsWork.AsInteger = 1 then begin
    s := 'спецучет ';
    if qrPersonWUchet2_Ser.AsString <> '' then
      s := s + 'Сер. '+qrPersonWUchet2_Ser.AsString+' № ';
    s := s + qrPersonWUchet2.AsString;
  end else begin
    s := 'общий';
    if qrPersonWUchet1.AsString<>EmptyStr then
      s := s+' № команды '+qrPersonWUchet1.AsString;
  end;
  qrPersonWUchet.Value := s;
  s := '';
  if qrPersonGroup_Id.AsInteger in [5,6] then begin

  end;
  qrPersonAddInfo.Value := s;

  if qrPersonPDPCode.AsString <> '' then
    qrPersonOKVED_OKPDTR.AsString :=
      StringReplace(qrPersonPDPCode.AsString, '/', ', ', [rfReplaceAll]);
end;

procedure TdmMain.qrVURCalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('IOFam').Value :=
      (FieldByName('Im').AsString+' ')[1]+'.'+
      (FieldByName('Otch').AsString+' ')[1]+'. '+
      FieldByName('Fam').AsString;
    FieldByName('FamIO').Value :=
      FieldByName('Fam').AsString+' '+
      (FieldByName('Im').AsString+' ')[1]+'.'+
      (FieldByName('Otch').AsString+' ')[1]+'.';
  end;
end;

end.

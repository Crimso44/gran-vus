unit dMain;

interface

uses
  fGetType,
  SysUtils, Classes, DB, ADODB, ekbasereport, ekrtf, Dialogs, Forms, Windows,
  ekfunc, Controls;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrPerson: TADOQuery;
    EkUDFList1: TEkUDFList;
    qrOrg: TADOQuery;
    qrOrgIOFam: TStringField;
    qrOrgFamIO: TStringField;
    qrOrgorgname: TWideMemoField;
    qrOrgfam: TStringField;
    qrOrgIm: TStringField;
    qrOrgOtch: TStringField;
    qrOrgPOST: TStringField;
    qrPersonRecNo: TIntegerField;
    qrPDP: TADOQuery;
    qrOrgMAINOKONH: TWideStringField;
    qrOrgORGID: TIntegerField;
    qrOrgPARENT: TWideStringField;
    qrOrgFS_ID: TIntegerField;
    qrOrgINN: TWideStringField;
    qrOrgOKPO: TWideStringField;
    qrOrgOKONH: TWideMemoField;
    qrOrgSOOGU: TWideStringField;
    qrOrgKOPF_ID: TIntegerField;
    qrOrgKODREG: TWideStringField;
    qrOrgREGDATE: TDateTimeField;
    qrOrgREGNUM: TWideStringField;
    qrOrgORGSNAME: TWideStringField;
    qrOrgCOMMENT: TWideMemoField;
    qrOrgFIZADDR: TWideStringField;
    qrOrgURADDR: TWideStringField;
    qrOrgPOSTADDR: TWideStringField;
    qrOrgPHONE: TWideStringField;
    qrOrgFAX: TWideStringField;
    qrOrgEMAIL: TWideStringField;
    qrOrgWWW: TWideStringField;
    qrOrgMYORG: TSmallintField;
    qrOrgCONFDATE: TDateTimeField;
    qrOrgOKBV: TWideStringField;
    qrOrgFIRST_DATE: TDateTimeField;
    qrOrgLAST_DATE: TDateTimeField;
    qrOrgEXT_ID: TIntegerField;
    qrOrgF6_SHIFR: TWideStringField;
    qrOrgOCCUPATION: TWideStringField;
    qrOrgSBM_ID: TIntegerField;
    qrOrgTERR_ID: TIntegerField;
    qrOrgHAS_BRON: TBooleanField;
    qrOrgREGPL_ID: TIntegerField;
    qrOrgOKATO2: TWideStringField;
    qrOrgOKATO3: TWideStringField;
    qrOrgFeature1: TWideStringField;
    qrOrgFeature2: TWideStringField;
    qrOrgFeature3: TWideStringField;
    qrOrgOVK_ID: TIntegerField;
    qrOrgLicense1: TWideStringField;
    qrOrgLicense1_date: TDateTimeField;
    qrOrgLicense1Who: TWideStringField;
    qrOrgLicense2: TWideStringField;
    qrOrgLicense2_date: TDateTimeField;
    qrOrgLicense2Who: TWideStringField;
    qrOrgCertificate: TWideStringField;
    qrOrgBeginCertificate_date: TDateTimeField;
    qrOrgEndCertificate_date: TDateTimeField;
    qrOrgCertificateWho: TWideStringField;
    qrOrgWhoPuts: TWideStringField;
    qrOrgHasVK: TBooleanField;
    qrOrgVKChief: TWideStringField;
    qrOrgVKChiefRange: TIntegerField;
    qrOrgKODOKTMO: TWideStringField;
    qrOrgKODOKTMO2: TWideStringField;
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
    qrPersonSC_ID: TIntegerField;
    qrPersonIS_WAR: TSmallintField;
    qrPersonEOARMY_DATE: TWideStringField;
    qrPersonCSOST: TSmallintField;
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
    qrPersonComments: TWideMemoField;
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
    qrPersonWarfare: TWideStringField;
    qrPersonWRNG_NAME: TWideStringField;
    qrPersonM_LIMIT: TSmallintField;
    qrPersonFEM_LIMIT: TSmallintField;
    qrPersonZAP: TWideStringField;
    qrPersonGODN: TWideStringField;
    qrPersonCHE: TIntegerField;
    qrPersonZAPSTATE: TIntegerField;
    qrPersonLIMIT1: TIntegerField;
    qrPersonLIMIT2: TIntegerField;
    qrPersonLIMIT3: TIntegerField;
    qrPersonWSOST_NAME: TWideStringField;
    qrPersonED_NAME: TWideStringField;
    qrPersonADDR_ID: TIntegerField;
    qrPersonADDR_TYPE: TSmallintField;
    qrPersonPOST_CODE: TIntegerField;
    qrPersonADDR_STR: TWideStringField;
    qrPersonADDR_DATE: TDateTimeField;
    qrPersonPOST_CODE1: TIntegerField;
    qrPersonADDR_STR1: TWideStringField;
    qrPersonPH_ID: TIntegerField;
    qrPersonPH_TYPE: TSmallintField;
    qrPersonPH_NUMBER: TWideStringField;
    qrPersonFST_NAME: TWideStringField;
    qrPersonWTP_ID: TIntegerField;
    qrPersonWCH_ID: TIntegerField;
    qrPersonDEP_ID: TIntegerField;
    qrPersonIN_ORD_NUMB: TWideStringField;
    qrPersonIN_ORD_DATE: TDateTimeField;
    qrPersonIN_DATE: TDateTimeField;
    qrPersonPOST_NAME: TWideStringField;
    qrPersonOKPDTR: TWideStringField;
    qrPersonOKPDTR_NAME: TWideStringField;
    qrPersonCPROF_ID: TIntegerField;
    qrPersonKPost_Num: TIntegerField;
    qrPersonIsIgnore: TBooleanField;
    qrPersonEducation: TWideStringField;
    qrPersonPer_No: TWideStringField;
    qrPersonRazd_No: TWideStringField;
    qrPersonPodrazd_No: TWideStringField;
    qrPersonPunkt: TWideStringField;
    qrPersonBirthYear: TSmallintField;
    qrOVK: TADOQuery;
    qrPDPid: TAutoIncField;
    qrPDPPer_No: TWideStringField;
    qrPDPRazd_No: TWideStringField;
    qrPDPPodrazd_No: TWideStringField;
    qrPDPPUNKT: TWideStringField;
    qrPDPPosts: TWideStringField;
    qrPersonPosts: TWideStringField;
    qrPDPOKVED: TStringField;
    qrPDPKOKPDTR_Code: TStringField;
    qrPersonWRNG_Name1: TStringField;
    qrEduc: TADOQuery;
    qrPersonPPers_Id: TIntegerField;
    qrPDPDocNumber: TStringField;
    qrPDPDocDate: TDateTimeField;
    qrPersonLearn: TADOQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    SmallintField1: TSmallintField;
    DateTimeField1: TDateTimeField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    IntegerField4: TIntegerField;
    WideStringField6: TWideStringField;
    WideStringField7: TWideStringField;
    WideStringField8: TWideStringField;
    DateTimeField2: TDateTimeField;
    WideStringField9: TWideStringField;
    WideStringField10: TWideStringField;
    IntegerField5: TIntegerField;
    SmallintField2: TSmallintField;
    WideStringField11: TWideStringField;
    SmallintField3: TSmallintField;
    SmallintField4: TSmallintField;
    WideStringField12: TWideStringField;
    WideStringField13: TWideStringField;
    IntegerField6: TIntegerField;
    WideStringField14: TWideStringField;
    IntegerField7: TIntegerField;
    WideStringField15: TWideStringField;
    WideStringField16: TWideStringField;
    WideStringField17: TWideStringField;
    WideStringField18: TWideStringField;
    DateTimeField3: TDateTimeField;
    SmallintField5: TSmallintField;
    WideStringField19: TWideStringField;
    WideStringField20: TWideStringField;
    WideStringField21: TWideStringField;
    WideStringField22: TWideStringField;
    DateTimeField4: TDateTimeField;
    IntegerField8: TIntegerField;
    DateTimeField5: TDateTimeField;
    DateTimeField6: TDateTimeField;
    DateTimeField7: TDateTimeField;
    DateTimeField8: TDateTimeField;
    WideStringField23: TWideStringField;
    DateTimeField9: TDateTimeField;
    DateTimeField10: TDateTimeField;
    WideStringField24: TWideStringField;
    WideStringField25: TWideStringField;
    WideStringField26: TWideStringField;
    WideMemoField1: TWideMemoField;
    DateTimeField11: TDateTimeField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    DateTimeField12: TDateTimeField;
    WideStringField27: TWideStringField;
    DateTimeField13: TDateTimeField;
    WideStringField28: TWideStringField;
    DateTimeField14: TDateTimeField;
    DateTimeField15: TDateTimeField;
    DateTimeField16: TDateTimeField;
    DateTimeField17: TDateTimeField;
    IntegerField12: TIntegerField;
    IntegerField13: TIntegerField;
    DateTimeField18: TDateTimeField;
    DateTimeField19: TDateTimeField;
    DateTimeField20: TDateTimeField;
    WideStringField29: TWideStringField;
    DateTimeField21: TDateTimeField;
    WideStringField30: TWideStringField;
    DateTimeField22: TDateTimeField;
    WideStringField31: TWideStringField;
    WideStringField32: TWideStringField;
    IntegerField14: TIntegerField;
    IntegerField15: TIntegerField;
    WideStringField33: TWideStringField;
    DateTimeField23: TDateTimeField;
    DateTimeField24: TDateTimeField;
    WideStringField34: TWideStringField;
    IntegerField16: TIntegerField;
    IntegerField17: TIntegerField;
    IntegerField18: TIntegerField;
    DateTimeField25: TDateTimeField;
    DateTimeField26: TDateTimeField;
    WideStringField35: TWideStringField;
    WideStringField36: TWideStringField;
    DateTimeField27: TDateTimeField;
    WideStringField37: TWideStringField;
    WideStringField38: TWideStringField;
    SmallintField6: TSmallintField;
    SmallintField7: TSmallintField;
    WideStringField39: TWideStringField;
    WideStringField40: TWideStringField;
    IntegerField19: TIntegerField;
    IntegerField20: TIntegerField;
    IntegerField21: TIntegerField;
    IntegerField22: TIntegerField;
    IntegerField23: TIntegerField;
    WideStringField41: TWideStringField;
    WideStringField42: TWideStringField;
    IntegerField24: TIntegerField;
    SmallintField8: TSmallintField;
    IntegerField25: TIntegerField;
    WideStringField43: TWideStringField;
    DateTimeField28: TDateTimeField;
    IntegerField26: TIntegerField;
    WideStringField44: TWideStringField;
    IntegerField27: TIntegerField;
    SmallintField9: TSmallintField;
    WideStringField45: TWideStringField;
    WideStringField46: TWideStringField;
    IntegerField28: TIntegerField;
    IntegerField29: TIntegerField;
    IntegerField30: TIntegerField;
    WideStringField47: TWideStringField;
    DateTimeField29: TDateTimeField;
    DateTimeField30: TDateTimeField;
    WideStringField48: TWideStringField;
    WideStringField49: TWideStringField;
    WideStringField50: TWideStringField;
    IntegerField31: TIntegerField;
    IntegerField32: TIntegerField;
    BooleanField1: TBooleanField;
    WideStringField51: TWideStringField;
    WideStringField52: TWideStringField;
    WideStringField53: TWideStringField;
    WideStringField54: TWideStringField;
    WideStringField55: TWideStringField;
    SmallintField10: TSmallintField;
    WideStringField56: TWideStringField;
    StringField1: TStringField;
    qrPDPLearn: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1dateCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1NotIsNullCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure qrOrgCalcFields(DataSet: TDataSet);
    procedure qrPersonCalcFields(DataSet: TDataSet);
    procedure EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
    procedure qrOrgAfterScroll(DataSet: TDataSet);
    procedure EkUDFList1Functions2Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    FOrgID: Integer;
    qrPersonX, qrPDPX: TADOQuery;
    procedure FillExecutor;
  public
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Форма № 14';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils, BirthDay;

function TdmMain.PrintData: boolean;
var
  learn: Boolean;
  f: TfrmGetType;
  res: Word;
begin
  try
    learn := False;

    qrOVK.Open;
    qrOrg.Open;

    qrPersonX := qrPerson;
    qrPDPX := qrPDP;

    f := TfrmGetType.Create(Self);
    res := f.ShowModal;
    f.Free;

    if res = mrYes then begin
      learn := True;
      qrPersonX := qrPersonLearn;
      qrPDPX := qrPDPLearn;
    end else if res <> mrNo then
      Exit;

    with TADOQuery.Create(nil) do
    try
      Connection := dbMain;
      SQL.Text := 'select COUNT(*) from PERS_SET';
      Open;
      if Fields[0].AsInteger > 0 then
        qrPersonX.SQL.Text := StringReplace(qrPersonX.SQL.Text,'/*PERS_SET*/',
          'and (P.PERS_ID in (select PERS_ID from PERS_SET))', [])
      else
        qrPersonX.SQL.Text := StringReplace(qrPersonX.SQL.Text,'/*PERS_SET*/',
          '', []);
      Close;
      SQL.Text := 'select Param_Value from Params Where Params.Param_Id = 8';
      Open;
      if not Eof then
        if Fields[0].AsString = '1' then
          qrPersonX.SQL.Text := StringReplace(qrPersonX.SQL.Text,'KWR.WRNG_NAME',
            'KWR.WRNG_NAME + iif(P.WSOST_ID=9,'' юстиции'',iif(P.WSOST_ID=10,'' медицинской службы'',''''))', []);

    finally Free;
    end;

    qrPersonX.SQL.Text := ReplaceFullAges(qrPersonX.SQL.Text);
    if learn then
      qrPersonX.Open
    else
      qrPersonX.Parameters.ParamByName('TPDP_Id').Value := -1;
    qrPDPX.Open;

    if learn then begin
      EkRtf1.CreateVar('Learning', 'обучающихся');
      EkRtf1.CreateVar('learn', true);
    end else begin
      EkRtf1.CreateVar('Learning', 'работающих');
      EkRtf1.CreateVar('learn', false);
    end;

    FillExecutor;

    EkRTF1.ExecuteOpen([qrPersonX, qrOrg, qrPDPX, qrOVK],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(FOrgID)]);
  except
    on E: Exception do
      ShowMessage(e.Message);
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


procedure TdmMain.qrOrgAfterScroll(DataSet: TDataSet);
begin
  qrOVK.Locate('OVK_ID', qrOrgOvk_Id.AsInteger, []);
end;

procedure TdmMain.qrOrgCalcFields(DataSet: TDataSet);
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

procedure TdmMain.qrPersonCalcFields(DataSet: TDataSet);
var
  s: String;
begin
  with DataSet do begin
    FieldByName('RecNo').Value := abs(RecNo);
  end;
  s := qrPersonX.FieldByName('ED_NAME').AsString;
  qrEduc.Close;
  qrEduc.Parameters.ParamByName('pers_id').Value :=
    qrPersonX.FieldByName('PPERS_ID').Value;
  qrEduc.Open;
  while not qrEduc.Eof do begin
    s := s + qrEduc.Fields[0].AsString;

    qrEduc.Next;
  end;
  qrEduc.Close;
  if qrPersonX.FieldByName('PROF1').AsString <> '' then
    s := s + ' ' + qrPersonX.FieldByName('PROF1').AsString;
  qrPersonX.FieldByName('Education').Value := s;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'Form14.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Форма № 14.rtf';
end;

procedure TdmMain.EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
begin
  if ScanInfo.DataSet=qrPDP then begin
    qrPerson.Close;
    qrPerson.Parameters.ParamByName('MvkOrderNumber').Value := qrPDP.FieldByName('DocNumber').Value;
    qrPerson.Parameters.ParamByName('MvkOrderDate').Value := qrPDP.FieldByName('DocDate').Value;
    qrPerson.Parameters.ParamByName('TPDP_Id').Value := qrPDP.FieldByName('ID').AsInteger;
    qrPerson.SQL.Text := ReplaceFullAges(qrPerson.SQL.Text);
    qrPerson.Open;
  end;
end;

procedure TdmMain.EkUDFList1dateCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  (UDFResult as TEkReportVariable).AsString := FormatDateTime('dd.mm.yyyy',Date);
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

procedure TdmMain.EkUDFList1NotIsNullCalculate(Sender: TObject;
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

end.

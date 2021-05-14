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
    qrEduc: TADOQuery;
    qrFam: TADOQuery;
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
    qrPersonSQL: TADOQuery;
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
    qrPersonCPROF_ID: TIntegerField;
    qrPersonCSOST: TSmallintField;
    qrPersonCAT_ZAP: TSmallintField;
    qrPersonVUS: TWideStringField;
    qrPersonWCAT: TWideStringField;
    qrPersonOVK_ID: TIntegerField;
    qrPersonWUCHET1: TWideStringField;
    qrPersonWUCHET2: TWideStringField;
    qrPersonWDISCL: TWideStringField;
    qrPersonTAB_NUMB: TWideStringField;
    qrPersonDOG_NUMB: TWideStringField;
    qrPersonDOG_DATE: TDateTimeField;
    qrPersonIS_RAB: TSmallintField;
    qrPersonWTP_ID: TIntegerField;
    qrPersonWCH_ID: TIntegerField;
    qrPersonDEP_ID: TIntegerField;
    qrPersonPROF1: TWideStringField;
    qrPersonOKPDTR1: TWideStringField;
    qrPersonPROF2: TWideStringField;
    qrPersonOKPDTR2: TWideStringField;
    qrPersonCONFDATE: TDateTimeField;
    qrPersonW_DBEG: TDateTimeField;
    qrPersonW_DEND: TDateTimeField;
    qrPersonD_OVK: TDateTimeField;
    qrPersonD_WBIL: TDateTimeField;
    qrPersonWRNG_NAME: TWideStringField;
    qrPersonM_LIMIT: TSmallintField;
    qrPersonFEM_LIMIT: TSmallintField;
    qrPersonZAP: TWideStringField;
    qrPersonGODN: TWideStringField;
    qrPersonWSOST_NAME: TWideStringField;
    qrPersonED_NAME: TWideStringField;
    qrPersonADDR_ID: TIntegerField;
    qrPersonADDR_TYPE: TSmallintField;
    qrPersonPOST_CODE: TIntegerField;
    qrPersonADDR_STR: TWideStringField;
    qrPersonFST_NAME: TWideStringField;
    qrPersonPOST_NAME: TWideStringField;
    qrPersonRecNo: TIntegerField;
    qrPersonWUCHET: TStringField;
    qrPersonNUMB_T2: TIntegerField;
    qrPersonEOARMY_DATE: TWideStringField;
    qrPersonSpecialWUchet1: TIntegerField;
    qrPersonOUT_ORD_NUMB: TWideStringField;
    qrPersonOUT_ORD_DATE: TDateTimeField;
    qrPersonOUT_DATE: TDateTimeField;
    qrPersonWID: TWideStringField;
    qrPersonWBser: TWideStringField;
    qrPersonWBnum: TWideStringField;
    qrPersonCHE: TIntegerField;
    qrPersonID: TAutoIncField;
    qrPersonIN_ORD_NUMB: TWideStringField;
    qrPersonIN_ORD_DATE: TDateTimeField;
    qrPersonIN_DATE: TDateTimeField;
    qrPersonOKPDTR: TWideStringField;
    qrPersonOKPDTR_NAME: TWideStringField;
    qrPersonPH_ID: TIntegerField;
    qrPersonPH_TYPE: TSmallintField;
    qrPersonPH_NUMBER: TWideStringField;
    qrPersonADDR_STR1: TStringField;
    qrPersonDEP_FULL_NAME: TStringField;
    qrPersonComments: TWideMemoField;
    qrPersonWUCHET2_date: TDateTimeField;
    qrPersonDocument: TIntegerField;
    qrPersonBranch: TIntegerField;
    qrPersonIsAspirant: TIntegerField;
    qrPersonStudyForm: TIntegerField;
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
    qrPersonKval_Id: TIntegerField;
    qrPersonDelay_ID: TIntegerField;
    qrPersonDelayStart_date: TDateTimeField;
    qrPersonDelayEnd_date: TDateTimeField;
    qrPersonHealth: TWideStringField;
    qrPersonHealthDocNo: TWideStringField;
    qrPersonHealthDoc_date: TDateTimeField;
    qrPersonWarfare: TWideStringField;
    qrPersonZAPSTATE: TIntegerField;
    qrPersonLIMIT1: TIntegerField;
    qrPersonLIMIT2: TIntegerField;
    qrPersonLIMIT3: TIntegerField;
    qrPersonADDR_DATE: TDateTimeField;
    qrPersonPOST_CODE1: TIntegerField;
    qrPersonKPost_Num: TIntegerField;
    qrPersonIsIgnore: TBooleanField;
    qrPersonEduc1: TWideStringField;
    qrPersonEduc2: TWideStringField;
    qrPersonEduc3: TWideStringField;
    qrPersonWUchet2_IsWork: TIntegerField;
    qrPersonWUchet2_Ser: TStringField;
    qrPersonWRNG_Name1: TStringField;
    qrPersonOKVED_OKPDTR: TStringField;
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
    qrPersonPDPCode: TWideStringField;
    qrPersonWRNG_Date: TDateTimeField;
    qrPersonKOKPDTR: TIntegerField;
    qrPersonCPROF2015_ID: TIntegerField;
    qrPersonFAM_LIST: TStringField;
    qrPersonPPers_Id: TIntegerField;
    EkUDFList1: TEkUDFList;
    procedure qrPersonPROF1GetText(Sender: TField; var Text: string; DisplayText: Boolean);
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
    procedure FillExecutor;
  public
    ListOVK: TStringList;
    printLetters: Boolean;
    function OpenData(OrgId: Integer): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Форма сверки данных с военкоматами';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils;

function TdmMain.OpenData(OrgId: Integer): boolean;
var
  IsJet: Boolean;
  sDate: String;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  sDate := 'Date()';
  if not IsJet then begin
    qrOvk.SQL.Text := StringReplace(qrOvk.SQL.Text, 'IIF(IsOVK', 'IIF(IsOVK=1', [rfReplaceAll]);
    qrPerson.SQL.Text := qrPersonSQL.SQL.Text;
    sDate := 'GetDate()';
  end;

  FOrgID := OrgID;
  try
    if ListOVK.Count>0 then
      qrOVK.SQL.Add('WHERE OVK_ID in ('+ListOVK.CommaText+')')
    else
      qrOVK.SQL.Add('WHERE EXISTS(SELECT * FROM PERSON '+
                                  'WHERE OVK_ID=KOVK.OVK_ID '+
                                    'AND IS_WAR<>0 '+
                                    'AND (W_DEND is null or Year(W_DEND) >= Year('+sDate+'))'+
//                                    'AND WRNG_ID<>1 '+
                                    'AND ((select COUNT(*) '+
                                           'from PERS_SET)=0 '+
                                             'or PERS_ID in (select PERS_ID '+
                                                              'from PERS_SET)) AND '+
      '(((select max(In_Date) from Appointment where pers_id = PERSON.pers_id and ' +
      'post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND ' +
      'PERSON.OUT_ORD_DATE IS NULL) OR '+
      '((select max(In_Date) from Appointment where pers_id = PERSON.pers_id and ' +
      'post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND ' +
      'PERSON.ORDERDISMISSAL_DATE IS NULL)))');
    qrOVK.SQL.Add('ORDER BY OVK_NAME');
    qrOVK.Open;
    qrOrg.SQL.Add('WHERE ORGID='+IntToStr(OrgId));
    qrOrg.Open;
    qrVUR.SQL.Add('WHERE IS_VUS=1 AND ORGID='+IntToStr(OrgId));
    qrVUR.Open;

    with TADOQuery.Create(nil) do
    try
      Connection := dbMain;
      SQL.Text := 'SELECT Param_Value FROM Params where Param_ID = 1';
      Open;
      qrGen.SQL.Add('WHERE ' + IfThen(Fields[0].AsString = '1', 'IS_VUS', 'IS_GEN') +
                    '=1 AND ORGID='+IntToStr(OrgId));
      Close;
      SQL.Text := 'select COUNT(*) from PERS_SET';
      Open;
      if Fields[0].AsInteger > 0 then
        qrPerson.SQL.Text := StringReplace(qrPerson.SQL.Text,'/*PERS_SET*/',
          'and (P.PERS_ID in (select PERS_ID from PERS_SET))', [])
      else
        qrPerson.SQL.Text := StringReplace(qrPerson.SQL.Text,'/*PERS_SET*/',
          '', []);
      Close;
      SQL.Text := 'select Param_Value from Params Where Params.Param_Id = 8';
      Open;
      if not Eof then
        if Fields[0].AsString = '1' then
          qrPerson.SQL.Text := StringReplace(qrPerson.SQL.Text,'KWR.WRNG_NAME',
            'KWR.WRNG_NAME + iif(P.WSOST_ID=9,'' юстиции'',iif(P.WSOST_ID=10,'' медицинской службы'',''''))', []);

    finally Free;
    end;

    qrGen.Open;
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

function TdmMain.PrintData: boolean;
begin
//  try
    EkRTF1.Infile := GetTemplatesDir + 'PersOVK.rtf';
    EkRTF1.Outfile := GetReportsDir + 'Форма сверки с военкоматами.rtf';

    qrPerson.Parameters.ParamByName('OVK_ID').Value := -1;
    qrPerson.Open;

    if Copy(qrOrg.FieldByName('MAINOKONH').AsString, 1, 4) = '80.3' then
      EkRtf1.CreateVar('Learning', 'обучающихся и ')
    else
      EkRtf1.CreateVar('Learning', '');

    FillExecutor;

    EkRTF1.ExecuteOpen([qrOrg,qrVUR,qrGen,qrOVK,qrPerson],SW_SHOWDEFAULT);

    if printLetters then begin
      EkRTF1.Infile := GetTemplatesDir + 'PersOVKAdd.rtf';
      EkRTF1.Outfile := GetReportsDir + 'Сопроводительные письма.rtf';
      EkRTF1.ExecuteOpen([qrOrg,qrVUR,qrGen,qrOVK,qrPerson],SW_SHOWDEFAULT);
    end;

    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(FOrgID),
       'ОВК: '+ListOVK.CommaText]);
//  except
//    Result := false;
//  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  ListOVK := TStringList.Create;
  if dbMain.Connected then ShowMessage('Close default connection!');
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
      s := s+' сер. '+qrPersonWUchet2_Ser.AsString + ' № ';
    s := s+qrPersonWUchet2.AsString;
    if qrPersonWUchet2_date.AsString <> '' then
      s := s+' от '+qrPersonWUchet2_date.AsString;
  end else begin
    s := 'общий';
    if qrPersonWUchet1.AsString<>EmptyStr then
      s := s+' № команды '+qrPersonWUchet1.AsString;
  end;
  qrPersonWUchet.Value := s;

  qrEduc.Close;
  qrEduc.Parameters.ParamByName('pers_id').Value :=
    qrPersonPPERS_ID.Value;
  qrEduc.Open;
  while not qrEduc.Eof do begin
    qrPerson.FieldByName('Educ' + qrEduc.Fields[1].AsString).Value :=
      qrEduc.Fields[0].AsString;

    qrEduc.Next;
  end;
  qrEduc.Close;

  s := EmptyStr;
  qrFam.Close;
  qrFam.Parameters.ParamByName('pers_id').Value :=
    qrPersonPPERS_ID.Value;
  qrFam.Open;
  qrFam.First;
  while not qrFam.EOF do begin
    s := s +
      qrFam.FieldByName('FT_NAME').AsString + ' - '+
      qrFam.FieldByName('FAM_NAME').AsString + ', '+
      qrFam.FieldByName('FAM_BIRTH').AsString + #13;
    qrFam.Next;
  end;
  qrFam.Close;
  if s<>EmptyStr then SetLength(s,Length(s)-1);
  qrPersonFAM_LIST.Value := s;

  if (qrPersonWUchet2_IsWork.AsInteger = 1) and (qrPersonPDPCode.AsString <> '') then
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

procedure TdmMain.qrPersonPROF1GetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := Sender.AsString;
  if Text<>'' then Text := '('+Text+')';
end;

end.

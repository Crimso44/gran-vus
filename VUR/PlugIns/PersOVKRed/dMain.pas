unit dMain;

interface

uses
  SysUtils, Classes, DB, ADODB, ekbasereport, ekrtf, Dialogs, Forms, Windows;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    qrOVK: TADOQuery;
    EkRTF1: TEkRTF;
    qrOrg: TADOQuery;
    qrVUR: TADOQuery;
    qrGen: TADOQuery;
    qrPerson: TADOQuery;
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
    qrEduc: TADOQuery;
    qrFam: TADOQuery;
    qrPersonFAM_LIST: TStringField;
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
    qrPersonEducation: TStringField;
    qrPersonWUCHET2_IsWork: TIntegerField;
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
    qrPersonZAPSTATE: TIntegerField;
    qrPersonLIMIT1: TIntegerField;
    qrPersonLIMIT2: TIntegerField;
    qrPersonLIMIT3: TIntegerField;
    qrPersonADDR_DATE: TDateTimeField;
    qrPersonPOST_CODE1: TIntegerField;
    qrPersonKPost_Num: TIntegerField;
    qrPersonIsIgnore: TBooleanField;
    qrPersonYellow_Data: TStringField;
    qrPersonWRNG_Name1: TStringField;
    qrPersonOKVED_OKPDTR: TStringField;
    qrPersonWUchet22: TStringField;
    qrPersonSQL: TADOQuery;
    qrPersonPPers_Id: TIntegerField;
    qrPersonDocNumber: TStringField;
    qrPersonDocDate: TDateTimeField;
    procedure qrPersonPROF1GetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
    procedure qrPersonCalcFields(DataSet: TDataSet);
    procedure qrVURCalcFields(DataSet: TDataSet);
  private
    FOrgID: Integer;
    procedure FillExecutor;
  public
    ListOVK: TStringList;
    IsJet: Boolean;
    function OpenData(OrgId: Integer): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'ѕисьма в ќ¬  о сн€тии со спецучета по изменении статуса работника';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils;

function TdmMain.OpenData(OrgId: Integer): boolean;
begin

  if not IsJet then begin
    qrOvk.SQL.Text := StringReplace(qrOvk.SQL.Text, 'IIF(IsOVK', 'IIF(IsOVK=1', [rfReplaceAll]);
    qrPerson.SQL.Text := qrPersonSQL.SQL.Text;
  end;

    with TADOQuery.Create(nil) do
    try
      Connection := dbMain;
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

  FOrgID := OrgID;
  try
    qrOVK.SQL.Add('WHERE OVK_ID in ('+ListOVK.CommaText+')');
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
    finally Free;
    end;

    qrGen.Open;
    Result := true;
  except
    on E: Exception do begin
      //ShowMessage(E.Message);
      Result := false;
    end;
  end;
end;

function TdmMain.PrintData: boolean;
begin
  //try
    qrPerson.Parameters.ParamByName('OVK_ID').Value := -1;
    qrPerson.Open;
    EkRTF1.ClearVars;
    EkRTF1.CreateVar('TITLE', 'ѕрошу сн€ть со специального учета граждан, перечисленных в прилагаемой ниже таблице, в св€зи с изменением занимаемых ими должностей или других изменений, делающих постановку работников на специальный учет неправомерной.');
    EkRTF1.CreateVar('TITLE1', '—ѕ»—ќ  √–ј∆ƒјЌ, –јЅќ“јёў»’ ¬');
    EkRTF1.CreateVar('TITLE2', ', ѕ–≈ƒ—“ј¬Ћя≈ћџ… ƒЋя —Ќя“»я —ќ —ѕ≈÷»јЋ№Ќќ√ќ ”„≈“ј –јЅќ“Ќ» ќ¬, ѕ≈–≈—“ј¬Ў»’ ”ƒќ¬Ћ≈“¬ќ–я“№ ”—Ћќ¬»яћ ѕќ—“јЌќ¬ » Ќј —ѕ≈÷”„≈“');
    EkRTF1.CreateVar('YELLOW_HEAD', '');
    FillExecutor;
    EkRTF1.ExecuteOpen([qrOrg,qrVUR,qrGen,qrOVK,qrPerson],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Ќомер организации: '+IntToStr(FOrgID),
       'ќ¬ : '+ListOVK.CommaText]);
  {except
    on E: Exception do begin
      ShowMessage(E.Message);
      raise E;
    end;
  end;}
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
  end else begin
    EkRtf1.CreateVar('ExecutorFam', qrExecutor.FieldByName('Fam').AsString);
    EkRtf1.CreateVar('ExecutorIm', qrExecutor.FieldByName('Im').AsString);
    EkRtf1.CreateVar('ExecutorOtch', qrExecutor.FieldByName('Otch').AsString);
    EkRtf1.CreateVar('ExecutorPhone', qrExecutor.FieldByName('Phone').AsString);
    EkRtf1.CreateVar('ExecutorPost', qrExecutor.FieldByName('Post').AsString);
  end;
  qrExecutor.Close;
end;


procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  ListOVK := TStringList.Create;
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'PersOVKAll.rtf';
  EkRTF1.Outfile := GetReportsDir + 'ѕисьма в ќ¬  о сн€тии со спецучета по изменении статуса работника.rtf';
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

procedure TdmMain.qrPersonCalcFields(DataSet: TDataSet);
var s: string;
begin
  if qrPerson.RecNo<=1 then
    qrPersonRecNo.Value := 1
  else
    qrPersonRecNo.Value := qrPerson.RecNo;
  if qrPersonWUCHET2_IsWork.AsInteger = 1 then
    s := 'спецучет '+qrPersonWUchet2.AsString
  else begin
    s := 'общий';
    if qrPersonWUchet1.AsString<>EmptyStr then
      s := s+' є команды '+qrPersonWUchet1.AsString;
  end;
  qrPersonWUchet.Value := s;
  s := qrPerson.FieldByName('ED_NAME').AsString;
  qrEduc.Close;
  qrEduc.Parameters.ParamByName('pers_id').Value :=
    qrPersonPPERS_ID.Value;
  qrEduc.Open;
  while not qrEduc.Eof do begin
    s := s + qrEduc.Fields[0].AsString;

    qrEduc.Next;
  end;
  qrEduc.Close;
  if qrPerson.FieldByName('PROF1').AsString <> '' then
    s := s + ' ' + qrPerson.FieldByName('PROF1').AsString;
  qrPerson.FieldByName('Education').Value := s;
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
  if qrPersonPDPCode.AsString <> '' then
    qrPersonOKVED_OKPDTR.AsString :=
      StringReplace(qrPersonPDPCode.AsString, '/', ', ', [rfReplaceAll]);
  if qrPersonDocNumber.AsString <> '' then
    qrPersonOKVED_OKPDTR.AsString :=
      'є ' + qrPersonDocNumber.AsString + ' от ' + FormatDateTime('dd.mm.yyyy',qrPersonDocDate.AsDateTime);
  if qrPersonWUchet2.AsString <> '' then
    qrPersonWUchet22.AsString :=
      'є ' + qrPersonWUchet2.AsString;
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

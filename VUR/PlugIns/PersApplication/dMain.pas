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
    qrPersonFAM_LIST: TStringField;
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
    qrPersonWUchet2_IsWork: TIntegerField;
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
    qrPersonPPers_Id: TIntegerField;
    qrPersonDocNumber: TStringField;
    qrPersonDocDate: TDateTimeField;
    EkUDFList1: TEkUDFList;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1Functions0Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions1Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions2Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    FPersID: Integer;
    FReason: string;
    procedure FillExecutor;
  public
    function OpenData(PersId: Integer; reason: string): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Письма в ОВК о снятии со спецучета по возрасту';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils, BirthDay;

function TdmMain.OpenData(PersId: Integer; reason: string): boolean;
begin

  FPersID := PersId;
  FReason := reason;
  try
    qrOrg.Open;
    qrPerson.Parameters.ParamByName('PERS_ID').Value := PersId;
    qrPerson.SQL.Text := ReplaceFullAges(qrPerson.SQL.Text);
    qrPerson.Open;
    qrOVK.Open;

    Result := true;
  except on e: Exception do begin
    showmessage(e.Message);
    Result := false;
  end;
  end;
end;

function TdmMain.PrintData: boolean;
begin
//  try
    EkRTF1.ClearVars;
    EkRTF1.CreateVar('reason', FReason);
    FillExecutor;
    EkRTF1.ExecuteOpen([qrPerson,qrOVK,qrOrg],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер сотрудника: '+IntToStr(qrPerson.Parameters.ParamByName('PERS_ID').Value)]);
//  except
//    Result := false;
//  end;
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
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'PersApplication.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Заявление о постановке на воинский учет.rtf';
end;

end.

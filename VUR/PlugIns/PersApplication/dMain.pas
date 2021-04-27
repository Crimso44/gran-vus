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
    procedure DataModuleCreate(Sender: TObject);
  private
    FPersID: Integer;
    FReason: string;
  public
    function OpenData(PersId: Integer; reason: string): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = '������ � ��� � ������ �� ��������� �� ��������';

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
    EkRTF1.ExecuteOpen([qrPerson,qrOVK,qrOrg],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['����� ����������: '+IntToStr(qrPerson.Parameters.ParamByName('PERS_ID').Value)]);
//  except
//    Result := false;
//  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'PersApplication.rtf';
  EkRTF1.Outfile := GetReportsDir + '��������� � ���������� �� �������� ����.rtf';
end;

end.

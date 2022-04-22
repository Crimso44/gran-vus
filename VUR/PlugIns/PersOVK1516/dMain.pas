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
    qrPersonUZ_NAME: TStringField;
    qrPersonDIPLOM: TStringField;
    qrPersonEND_DATE: TStringField;
    qrPersonKVAL: TStringField;
    qrPersonNAPR: TStringField;
    qrPersonOKSO: TStringField;
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
    qrPersonNAT_NAME: TWideStringField;
    qrPersonWUchet2_IsWork: TIntegerField;
    qrPersonPPers_Id: TIntegerField;
    EkUDFList1: TEkUDFList;
    qEduc: TADOQuery;
    qrPersonEducationFull: TStringField;
    qEducPers_Id: TIntegerField;
    qEducEducation: TStringField;
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
    ReportType: Integer;
    function OpenData(OrgId: Integer): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = '������ ������� �������� ���� 15- � 16-������� ��������';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils, misc;

function TdmMain.OpenData(OrgId: Integer): boolean;
var
  year15: string;
begin
  if ReportType = 0 then begin
    year15 :=
        'and ((year(p.Birthday) + 16) = Year(Date()) ' +
        '  or (year(p.Birthday) + 15) = Year(Date())) ';
    EkRTF1.Outfile := GetReportsDir + '������ ������� �������� ���� 15- � 16-������� ��������.rtf';
    EkRTF1.CreateVar('ReportName', '������� �������� ���� 15- � 16-������� ��������');
    qrPerson.Parameters.ParamByName('small').Value := 1;
  end else begin
    year15 :=
        'and (year(p.Birthday) + 16) = Year(Date()) ';
    EkRTF1.Outfile := GetReportsDir + '������ ������� �������� ����, ���������� �������������� ���������� �� �������� ���� � ��������� ����.rtf';
    EkRTF1.CreateVar('ReportName', '������� �������� ����, ���������� �������������� ���������� �� �������� ���� � ��������� ����');
    qrPerson.Parameters.ParamByName('small').Value := 0;
  end;
  //qrPerson.SQL.Text := StringReplace(qrPerson.SQL.Text, '.15.', year15, [rfReplaceAll]);

  FOrgID := OrgID;
  try
    if ListOVK.Count>0 then
      qrOVK.SQL.Add('WHERE OVK_ID in ('+ListOVK.CommaText+')')
    else
      qrOVK.SQL.Add('WHERE EXISTS(SELECT * FROM PERSON P '+
                                  'WHERE P.OVK_ID=KOVK.OVK_ID '+
                                  '  and ((select COUNT(*) from PERS_SET)=0 or P.PERS_ID in (select PERS_ID from PERS_SET)) '+
                                  year15 +
      ')');
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
    Result := false;
  end;
end;

function TdmMain.PrintData: boolean;
begin
  try
    EkRTF1.CreateVar('CurDate', FormatDateTime('DD.MM.YYYY', Now));
    qrPerson.Parameters.ParamByName('OVK_ID').Value := -1;
    qrPerson.Open;
    FillExecutor;
    EkRTF1.ExecuteOpen([qrOrg,qrVUR,qrGen,qrOVK,qrPerson],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['����� �����������: '+IntToStr(FOrgID),
       '���: '+ListOVK.CommaText]);
  except on e: Exception do begin
    ShowMessage(e.Message);
    Result := false;
  end; end;
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


procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  ListOVK := TStringList.Create;
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'PersOVK1516.rtf';
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
  if qrPersonWUchet2_IsWork.AsInteger = 1 then
    s := '�������� '+qrPersonWUchet2.AsString
  else begin
    s := '�����';
    if qrPersonWUchet1.AsString<>EmptyStr then
      s := s+' � ������� '+qrPersonWUchet1.AsString;
  end;
  qrPersonWUchet.Value := s;
  qrEduc.Close;
  qrEduc.Parameters.ParamByName('pers_id').Value :=
    qrPersonPPERS_ID.Value;
  qrEduc.Open;
  if not qrEduc.IsEmpty then begin
    qrPerson.FieldByName('UZ_Name').Value :=
      qrEduc.FieldByName('UZ_Name').Value;
    qrPerson.FieldByName('DIPLOM').Value :=
      qrEduc.FieldByName('DIPLOM').Value;
    qrPerson.FieldByName('END_DATE').Value :=
      qrEduc.FieldByName('END_DATE').Value;
    qrPerson.FieldByName('KVAL').Value :=
      qrEduc.FieldByName('KVAL').Value;
    qrPerson.FieldByName('NAPR').Value :=
      qrEduc.FieldByName('NAPR').Value;
    qrPerson.FieldByName('OKSO').Value :=
      FormatOkso(qrEduc.FieldByName('OKSO').Value);
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
  qEduc.Parameters.ParamByName('Pers_Id').Value := qrPersonPPERS_ID.Value;
  qEduc.Open;
  qrPerson.FieldByName('EducationFull').AsString :=
    qrPerson.FieldByName('Education').AsString + qEduc.FieldByName('Education').AsString;
  qEduc.Close;
  if s<>EmptyStr then SetLength(s,Length(s)-1);
  qrPersonFAM_LIST.Value := s;
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

unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EkRtf, ekfunc, Db, ADODB, ekbasereport;

type
  TdmMain = class(TDataModule)
    EkRTF1: TEkRTF;
    EkUDFList1: TEkUDFList;
    dbMain: TADOConnection;
    qrOrg: TADOQuery;
    qrData: TADOQuery;
    qrDataPERS_ID: TIntegerField;
    qrDataORG_ID: TIntegerField;
    qrDataFAM: TWideStringField;
    qrDataIM: TWideStringField;
    qrDataOTCH: TWideStringField;
    qrDataMALE: TSmallintField;
    qrDataBIRTHDAY: TDateTimeField;
    qrDataBIRTHPLACE: TWideStringField;
    qrDataOKATO: TWideStringField;
    qrDataNAT_ID: TIntegerField;
    qrDataPSP_SER: TWideStringField;
    qrDataPSP_NUM: TWideStringField;
    qrDataPSP_PLACE: TWideStringField;
    qrDataPSP_DATE: TDateTimeField;
    qrDataINN: TWideStringField;
    qrDataSTRAH: TWideStringField;
    qrDataFST_ID: TIntegerField;
    qrDataED_ID: TIntegerField;
    qrDataSC_ID: TIntegerField;
    qrDataIS_WAR: TSmallintField;
    qrDataEOARMY_DATE: TWideStringField;
    qrDataCSOST: TSmallintField;
    qrDataWRNG_ID: TIntegerField;
    qrDataWSOST_ID: TIntegerField;
    qrDataCAT_ZAP: TSmallintField;
    qrDataVUS: TWideStringField;
    qrDataWCAT: TWideStringField;
    qrDataOVK_ID: TIntegerField;
    qrDataWUCHET1: TWideStringField;
    qrDataSpecialWUchet1: TIntegerField;
    qrDataWUCHET2: TWideStringField;
    qrDataWDISCL: TWideStringField;
    qrDataTAB_NUMB: TWideStringField;
    qrDataDOG_NUMB: TWideStringField;
    qrDataDOG_DATE: TDateTimeField;
    qrDataIS_RAB: TSmallintField;
    qrDataPROF1: TWideStringField;
    qrDataOKPDTR1: TWideStringField;
    qrDataPROF2: TWideStringField;
    qrDataOKPDTR2: TWideStringField;
    qrDataCONFDATE: TDateTimeField;
    qrDataNUMB_T2: TIntegerField;
    qrDataW_DBEG: TDateTimeField;
    qrDataW_DEND: TDateTimeField;
    qrDataD_OVK: TDateTimeField;
    qrDataD_WBIL: TDateTimeField;
    qrDataOUT_ORD_NUMB: TWideStringField;
    qrDataOUT_ORD_DATE: TDateTimeField;
    qrDataOUT_DATE: TDateTimeField;
    qrDataWID: TWideStringField;
    qrDataWBser: TWideStringField;
    qrDataWBnum: TWideStringField;
    qrDataComments: TWideMemoField;
    qrDataWUCHET2_date: TDateTimeField;
    qrDataDocument: TIntegerField;
    qrDataBranch: TIntegerField;
    qrDataIsAspirant: TIntegerField;
    qrDataStudyForm: TIntegerField;
    qrDataStudyEnd_date: TDateTimeField;
    qrDataOrderAkadem: TWideStringField;
    qrDataOrderAkadem_date: TDateTimeField;
    qrDataReasonAkadem: TWideStringField;
    qrDataBeginAkadem_date: TDateTimeField;
    qrDataEndAkadem_date: TDateTimeField;
    qrDataRealEndAkadem_date: TDateTimeField;
    qrDataMedResult_date: TDateTimeField;
    qrDataMedResult: TIntegerField;
    qrDataVKStatus: TIntegerField;
    qrDataBeginWar_date: TDateTimeField;
    qrDataEndWar_date: TDateTimeField;
    qrDataRealEndWar_date: TDateTimeField;
    qrDataReasonEndWar: TWideStringField;
    qrDataDismissal_date: TDateTimeField;
    qrDataOrderDismissal: TWideStringField;
    qrDataOrderDismissal_date: TDateTimeField;
    qrDataReasonDismissal: TWideStringField;
    qrDataDisserName: TWideStringField;
    qrDataDegree_ID: TIntegerField;
    qrDataGuideDegree_ID: TIntegerField;
    qrDataFIOGuide: TWideStringField;
    qrDataDefend_date: TDateTimeField;
    qrDataRealDefend_date: TDateTimeField;
    qrDataContractEnd: TWideStringField;
    qrDataKval_Id: TIntegerField;
    qrDataDelay_ID: TIntegerField;
    qrDataDelayStart_date: TDateTimeField;
    qrDataDelayEnd_date: TDateTimeField;
    qrDataHealth: TWideStringField;
    qrDataHealthDocNo: TWideStringField;
    qrDataHealthDoc_date: TDateTimeField;
    qrDataWarfare: TWideStringField;
    qrDataASOrder_In: TWideStringField;
    qrDataASDate_In: TDateTimeField;
    qrDataASOut_ORD_NUMB: TWideStringField;
    qrDataASOut_ORD_Date: TDateTimeField;
    qrDataASOut_Date: TDateTimeField;
    qrDataAppLast: TIntegerField;
    qrDataAppLastAll: TIntegerField;
    qrDataAppLastStudy: TIntegerField;
    qrDataAppFirst: TIntegerField;
    qrDataAppFirstStudy: TIntegerField;
    qrDataASAppLast: TIntegerField;
    qrDataASAppFirst: TIntegerField;
    qrDataMed_Where: TWideStringField;
    qrDataMed_Date: TDateTimeField;
    qrDataMed_Result: TWideStringField;
    qrDataPsy_Where: TWideStringField;
    qrDataPsy_Date: TDateTimeField;
    qrDataPsy_Result: TWideStringField;
    qrDataAsf_Sport: TWideStringField;
    qrDataMob_Days: TIntegerField;
    qrDataMob_Hours: TIntegerField;
    qrDataMob_Mins: TIntegerField;
    qrDataMob_CardDate: TDateTimeField;
    qrDataMob_MissReason: TWideStringField;
    qrDataWUCHET2_Ser: TWideStringField;
    qrDataWUCHET2_IsWork: TIntegerField;
    qrDataPDPCode: TWideStringField;
    qrDataWRNG_Date: TDateTimeField;
    qrDataDEP_NAME: TWideStringField;
    qrDataPOST_NAME: TWideStringField;
    qrDataBirthYear: TSmallintField;
    qrDataWRNG_Name: TWideStringField;
    qrDataWUCHET: TWideStringField;
    qrDataOVK_NAME: TWideStringField;
    qrDataADDR1: TWideStringField;
    qrDataADDR2: TWideStringField;
    qrDataED_NAME: TWideStringField;
    qrDataOKVED_OKPDTR: TStringField;
    procedure EkUDFList1Functions2Calculate(Sender: TObject;
      Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataCalcFields(DataSet: TDataSet);
    procedure EkUDFList1Functions1Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions0Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    procedure FillExecutor;
    { Private declarations }
  public
    { Public declarations }
    procedure PrintData(nOrgId, Date_From, Date_To: TDateTime; AFilter, ASort: Integer);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Журнал форм Т-2';

implementation

{$R *.DFM}
uses SaveEvents, IniSupport;

procedure TdmMain.EkUDFList1Functions0Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
//FIO
  (UDFResult as TEkReportVariable).AsString :=
    TField(Args[0]).AsString+' '+
    Copy(TField(Args[1]).AsString,1,1)+'. '+
    Copy(TField(Args[2]).AsString,1,1)+'.';
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

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'listT2.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Журнал учета форм Т-2.rtf';
end;

procedure TdmMain.PrintData(nOrgId, Date_From, Date_To: TDateTime; AFilter, ASort: Integer);
const
  sSorting: array [0..2] of String = (
    'NUMB_T2',
    'FAM, IM, OTCH',
    'DEP_NAME, POST_NAME, FAM, IM, OTCH');
var
  IsJet: Boolean;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  try
    case AFilter of
      0: EkRTF1.CreateVar('TITLE2', 'пребывающих в запасе');
      1: begin
        qrData.SQL.Add(' AND ((W_DBEG >= :Date_From AND W_DBEG <= :Date_To) OR (W_DEND >= :Date_From1 AND W_DEND <= :Date_To1))');
        qrData.Parameters.ParseSQL(qrData.SQL.Text, True);
        qrData.Parameters.ParamByName('Date_From').Value := Date_From;
        qrData.Parameters.ParamByName('Date_To').Value := Date_To;
        qrData.Parameters.ParamByName('Date_From1').Value := Date_From;
        qrData.Parameters.ParamByName('Date_To1').Value := Date_To;

        qrOrg.SQL.Add(' AND ((W_DBEG >= :Date_From AND W_DBEG <= :Date_To) OR (W_DEND >= :Date_From1 AND W_DEND <= :Date_To1))');
        qrOrg.Parameters.ParseSQL(qrOrg.SQL.Text, True);
        qrOrg.Parameters.ParamByName('Date_From').Value := Date_From;
        qrOrg.Parameters.ParamByName('Date_To').Value := Date_To;
        qrOrg.Parameters.ParamByName('Date_From1').Value := Date_From;
        qrOrg.Parameters.ParamByName('Date_To1').Value := Date_To;

        EkRTF1.CreateVar('TITLE2', 'прибывших или убывших с ' + FormatDateTime('dd.mm.yyyy', Date_From) + ' по ' + FormatDateTime('dd.mm.yyyy', Date_To));
      end;
      2: begin
        qrData.SQL.Add(' AND W_DBEG >= :Date_From AND W_DBEG <= :Date_To');
        qrData.Parameters.ParseSQL(qrData.SQL.Text, True);
        qrData.Parameters.ParamByName('Date_From').Value := Date_From;
        qrData.Parameters.ParamByName('Date_To').Value := Date_To;

        qrOrg.SQL.Add(' AND W_DBEG >= :Date_From AND W_DBEG <= :Date_To');
        qrOrg.Parameters.ParseSQL(qrOrg.SQL.Text, True);
        qrOrg.Parameters.ParamByName('Date_From').Value := Date_From;
        qrOrg.Parameters.ParamByName('Date_To').Value := Date_To;

        EkRTF1.CreateVar('TITLE2', 'вновь прибывших с ' + FormatDateTime('dd.mm.yyyy', Date_From) + ' по ' + FormatDateTime('dd.mm.yyyy', Date_To));
      end;
      3: begin
        qrData.SQL.Add(' AND W_DEND >= :Date_From AND W_DEND <= :Date_To');
        qrData.Parameters.ParseSQL(qrData.SQL.Text, True);
        qrData.Parameters.ParamByName('Date_From').Value := Date_From;
        qrData.Parameters.ParamByName('Date_To').Value := Date_To;

        qrOrg.SQL.Add(' AND W_DEND >= :Date_From AND W_DEND <= :Date_To');
        qrOrg.Parameters.ParseSQL(qrOrg.SQL.Text, True);
        qrOrg.Parameters.ParamByName('Date_From').Value := Date_From;
        qrOrg.Parameters.ParamByName('Date_To').Value := Date_To;

        EkRTF1.CreateVar('TITLE2', 'убывших с ' + FormatDateTime('dd.mm.yyyy', Date_From) + ' по ' + FormatDateTime('dd.mm.yyyy', Date_To));
      end;
    end;

    qrData.SQL.Add(' ORDER BY ');
    qrData.SQL.Add(sSorting[ASort]);
    qrOrg.SQL.Add(' GROUP BY o.OrgName, oc.FIO, oc.POST');

    if not IsJet then
      qrData.SQL.Text := StringReplace(qrData.SQL.Text, 'CStr(', 'convert(varchar,', [rfReplaceAll]);

    qrData.Parameters.ParamByName('ORG_ID').Value := 1;//nOrgId;
    qrData.Open;
    qrOrg.Open;
  except
    on E: Exception do begin
    SaveEvent(dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при обращении к базе данных.'+#13+E.Message]);
    Application.MessageBox(
      'Ошибка при обращении к базе данных!',
      sEventObject,MB_OK or MB_ICONERROR);
    Exit;
  end; end;

  try
    if AFilter = 0 then EkRTF1.CreateVar('TITLE1', 'Ж У Р Н А Л')
    else EkRTF1.CreateVar('TITLE1', 'В Ы П И С К А   И З   Ж У Р Н А Л А');
    EkRTF1.CreateVar('Date_From', FormatDateTime('dd.mm.yyyy', Date_From));
    EkRTF1.CreateVar('Date_To', FormatDateTime('dd.mm.yyyy', Date_To));

    FillExecutor;

    EkRTF1.ExecuteOpen([qrData, qrOrg],SW_SHOW);
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(qrData.Parameters.ParamByName('ORG_ID').Value)]);
  except
  on E: Exception do begin
    SaveEvent(dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.'+#13+E.Message]);
    Application.MessageBox(
        'Ошибка при создании отчета!'+#13+
        'Возможно неверно указаны рабочие папки, '+#13+
        'шаблон отчета используется другой программой '+#13+
        'или файл-отчет уже открыт другой программой...',
        sEventObject,MB_OK or MB_ICONERROR);
    Exit;
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


procedure TdmMain.qrDataCalcFields(DataSet: TDataSet);
begin
  if qrDataPDPCode.AsString <> '' then
    qrDataOKVED_OKPDTR.AsString :=
      StringReplace(qrDataPDPCode.AsString, '/', ', ', [rfReplaceAll]);
end;

end.

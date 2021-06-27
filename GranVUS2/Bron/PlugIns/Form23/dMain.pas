unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrDataFull: TADOQuery;
    qrDataFullROW_NO: TIntegerField;
    ImageList: TImageList;
    qrPER: TADOQuery;
    qrOSN: TADOQuery;
    qrOKATO: TADOQuery;
    qrOKATOKodTerr: TStringField;
    qrOKATONameTerr: TStringField;
    qrOKATOPosition_Name: TStringField;
    qrOKATOfio: TStringField;
    qrOKATOsubj_name: TStringField;
    qrDataFullORGID: TAutoIncField;
    qrDataFullPARENT: TStringField;
    qrDataFullFS_ID: TIntegerField;
    qrDataFullINN: TStringField;
    qrDataFullOKPO: TStringField;
    qrDataFullOKONH: TStringField;
    qrDataFullSOOGU: TStringField;
    qrDataFullKOPF_ID: TIntegerField;
    qrDataFullKODREG: TStringField;
    qrDataFullREGDATE: TDateTimeField;
    qrDataFullREGNUM: TStringField;
    qrDataFullORGNAME: TStringField;
    qrDataFullORGSNAME: TStringField;
    qrDataFullCOMMENT: TStringField;
    qrDataFullFIZADDR: TStringField;
    qrDataFullURADDR: TStringField;
    qrDataFullPOSTADDR: TStringField;
    qrDataFullPHONE: TStringField;
    qrDataFullFAX: TStringField;
    qrDataFullEMAIL: TStringField;
    qrDataFullWWW: TStringField;
    qrDataFullMYORG: TIntegerField;
    qrDataFullCONFDATE: TDateTimeField;
    qrDataFullMAINOKONH: TStringField;
    qrDataFullOKBV: TStringField;
    qrDataFullOCCUPATION: TStringField;
    qrDataFullFIRST_DATE: TDateTimeField;
    qrDataFullLAST_DATE: TDateTimeField;
    qrDataFullOUT_REASON: TStringField;
    qrDataFullOUT_DATE: TDateTimeField;
    qrDataFullSBM_ID: TIntegerField;
    qrDataFullTERR_ID: TIntegerField;
    qrDataFullEXT_ID: TIntegerField;
    qrDataFullHAS_BRON: TBooleanField;
    qrDataFullF6_SHIFR: TStringField;
    qrDataFullREGPL_ID: TIntegerField;
    qrDataFullCHK_DATE: TDateTimeField;
    qrDataFullOKATO2: TStringField;
    qrDataFullOKATO3: TStringField;
    qrDataFullFeature1: TStringField;
    qrDataFullFeature2: TStringField;
    qrDataFullFeature3: TStringField;
    qrDataFullOVK_ID: TIntegerField;
    qrDataFullKODOKTMO: TStringField;
    qrDataFullKODOKTMO2: TStringField;
    qrDataFullTERR_ID_1: TAutoIncField;
    qrDataFullNAME: TStringField;
    qrDataFullKODTERR: TStringField;
    qrDataFullIS_OKATO: TIntegerField;
    qrDataFullDIRECTOR: TStringField;
    qrDataFullCONTID: TAutoIncField;
    qrDataFullORGID_1: TIntegerField;
    qrDataFullDEPART: TStringField;
    qrDataFullPOST: TStringField;
    qrDataFullFIO: TStringField;
    qrDataFullPHONE_1: TStringField;
    qrDataFullFAX_1: TStringField;
    qrDataFullEMAIL_1: TStringField;
    qrDataFullIS_GEN: TSmallintField;
    qrDataFullIS_VUS: TSmallintField;
    qrDataFullFAM: TStringField;
    qrDataFullIM: TStringField;
    qrDataFullOTCH: TStringField;
    qrPERORGID: TIntegerField;
    qrPERDOC_ID: TIntegerField;
    qrPERDOC_NO: TStringField;
    qrPERSTART_DATE: TDateTimeField;
    qrPEREND_DATE: TDateTimeField;
    qrPERPER_NO: TStringField;
    qrPERRAZD_NO: TStringField;
    qrPERDOC_NAME: TStringField;
    qrOSNORGID: TIntegerField;
    qrOSNBASE_ID: TIntegerField;
    qrOSNDOC_ID: TIntegerField;
    qrOSNDOC_NO: TStringField;
    qrOSNDOC_DATE: TDateTimeField;
    qrOSNBASE_KOD: TStringField;
    qrOSNDOC_NAME: TStringField;
    qrPERot: TStringField;
    qrOSNot: TStringField;
    qrPERrazd: TStringField;
    qrPERno: TStringField;
    qrDataFullREGPLACE: TStringField;
    qrDataFullCOMPUTERS: TIntegerField;
    qrDataFullSOFTWARENUM: TIntegerField;
    qrDataFullSOFTWARE: TStringField;
    qrDataFullSHORTNAME: TStringField;
    qrDataFullsec_addr: TStringField;
    qrDataFullphoneX: TStringField;
    qrDataFullfaxX: TStringField;
    qrDataFullorgsnameX: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataFullCalcFields(DataSet: TDataSet);
    procedure qrOKATOAfterScroll(DataSet: TDataSet);
    procedure qrDataFullAfterScroll(DataSet: TDataSet);
    procedure qrPERCalcFields(DataSet: TDataSet);
  private
    FPrinting: Boolean;
  public
    tlPath: string;
    repPath: string;
    procedure PrintData(FilterType: SmallInt);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Форма № 23';

implementation

{$R *.DFM}

uses IniSupport, SaveEvents, msg, StrUtils, Math;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  tlPath := GetTemplatesDir;
  repPath := GetReportsDir;
end;

procedure TdmMain.PrintData(FilterType: SmallInt);
begin
  try
    EkRTF1.ClearVars;
    with TADOQuery.Create(Self) do try
      Connection := dbMain;
      SQL.Text := 'SELECT SUBJ_FULLNAME FROM SUBJ JOIN CURR_SUBJ ON SUBJ.SUBJ_ID = CURR_SUBJ.SUBJ_ID';
      Open;
      EkRTF1.CreateVar('SUBJ_FULLNAME', FieldByName('SUBJ_FULLNAME').AsString);
    finally
      Free;
    end;

    try 
      FPrinting:= False;
      EkRTF1.Infile := tlPath + 'form23.rtf';
      EkRTF1.Outfile := repPath + 'Форма 23.rtf';
      qrDataFull.Close;
      case FilterType of
      1: begin
           qrDataFull.SQL.Add('AND (SELECT KODTERR FROM KTERR WHERE TERR_ID=O.TERR_ID) LIKE ');
           qrDataFull.SQL.Add(
              '(select dbo.GetSubjMask(KTERR.KODTERR)'#13+
              'from CURR_SUBJ'#13+
              'join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID'#13+
              'join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)');
         end;
      2: qrDataFull.SQL.Add('AND O.ORGID IN (SELECT ORGID FROM ORGSET)');
      end;
      qrDataFull.SQL.Add('ORDER BY ORGNAME');
      //qrDataFull.Open;
      qrOKATO.Open;
      FPrinting:= True;
      EkRTF1.ExecuteOpen([qrDataFull, qrOKATO, qrPer, qrOsn],SW_SHOWDEFAULT);
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,[]);
    finally
      FPrinting:= False;
      qrDataFull.Close;
      qrOKATO.Close;
      qrOSN.Close;
      qrPER.Close;
    end
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...');
  end;
end;

procedure TdmMain.qrDataFullAfterScroll(DataSet: TDataSet);
begin
  qrPer.Close;
  qrOsn.Close;
  qrPer.Parameters[0].Value := qrDataFullOrgId.AsInteger;
  qrOsn.Parameters[0].Value := qrDataFullOrgId.AsInteger;
  qrPer.Open;
  qrOsn.Open;
end;

procedure TdmMain.qrDataFullCalcFields(DataSet: TDataSet);
begin
  if not FPrinting then Exit;

  if DataSet.RecNo <= 0 then
    DataSet.FieldByName('ROW_NO').AsInteger:= 1
  else
    DataSet.FieldByName('ROW_NO').AsInteger:= DataSet.RecNo;
end;


procedure TdmMain.qrOKATOAfterScroll(DataSet: TDataSet);
begin
  qrDataFull.Close;
  qrDataFull.Parameters[0].Value := qrOKATOKodTerr.AsString;
  qrDataFull.Open;
end;

procedure TdmMain.qrPERCalcFields(DataSet: TDataSet);
var
  fld: TField;
begin
  DataSet.FieldByName('ot').AsString := ' от ';
  {fld := DataSet.FindField('no');
  if Assigned(fld) then fld.AsString := '№';}
  fld := DataSet.FindField('razd');
  if Assigned(fld) then fld.AsString := ', ';
end;

end.


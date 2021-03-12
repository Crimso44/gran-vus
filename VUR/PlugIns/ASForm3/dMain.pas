unit dMain;

interface

uses
  SysUtils, Classes, DB, ADODB, ekbasereport, ekrtf, Dialogs, Forms, Windows,
  ekfunc, Controls, dxmdaset;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrDetail: TADOQuery;
    EkUDFList1: TEkUDFList;
    qrOrg: TADOQuery;
    qrOrgIOFam: TStringField;
    qrOrgFamIO: TStringField;
    qrOrgorgname: TStringField;
    qrOrgfam: TStringField;
    qrOrgIm: TStringField;
    qrOrgOtch: TStringField;
    qrOrgPOST: TStringField;
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
    qrOrgREGPLACE: TWideStringField;
    qrOrgCOMPUTERS: TIntegerField;
    qrOrgSOFTWARENUM: TIntegerField;
    qrOrgSOFTWARE: TWideStringField;
    qrOrgfam1: TWideStringField;
    qrOrgim1: TWideStringField;
    qrOrgotch1: TWideStringField;
    qrOrgpost1: TWideStringField;
    qrOrgIOFam1: TStringField;
    qrOrgFamIO1: TStringField;
    qrMaster: TADOQuery;
    mData: TdxMemData;
    mDataRecNo: TIntegerField;
    mDataDep_NameX: TStringField;
    mDataGenQty: TIntegerField;
    mDataAssGenQty: TIntegerField;
    mDataWarQty: TIntegerField;
    mDatahead: TBooleanField;
    mDatahead2: TBooleanField;
    mDatamid: TBooleanField;
    mDatamain: TBooleanField;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1dateCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1NotIsNullCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure qrOrgCalcFields(DataSet: TDataSet);
    procedure qrDetailCalcFields(DataSet: TDataSet);
  public
    function PrintData: boolean;
    function GetMonthName(m: Integer): String;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'НАСФ: Расчет техники, предназначенной для оснащения НАСФ';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils;

function TdmMain.PrintData: boolean;
var
  res, dd, mm, yy: Word;
  sKMtrAsf: String;
  recNo: Integer;
  IsJet: Boolean;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

//  try
    qrOrg.Open;

    if not IsJet then
      qrMaster.SQL.Text :=
        StringReplace(qrMaster.SQL.Text, 'KASFMtr.Tech', 'KASFMtr.Tech=1', [rfReplaceAll]);
    qrMaster.Open;
    qrDetail.Open;
    mData.Open;

    sKMtrAsf := ''; recNo := 0;
    while not qrMaster.Eof do begin
      if sKMtrAsf <> qrMaster.FieldByName('KAsfMtrName').AsString then begin
        Inc(recNo);
        mData.Append;
        mDataHead.AsBoolean := True;
        mDataRecNo.AsInteger := recNo;
        mDataDep_NameX.AsString := qrMaster.FieldByName('KAsfMtrName').AsString;
        if qrMaster.FieldByName('Name').AsString = '' then begin
          mDataGenQty.AsInteger := qrMaster.FieldByName('GenQty').AsInteger;
          mDataAssGenQty.AsInteger := qrMaster.FieldByName('AssGenQty').AsInteger;
          mDataWarQty.AsInteger := qrMaster.FieldByName('WarQty').AsInteger;
        end;
        mData.Post;
      end;
      if qrMaster.FieldByName('Name').AsString <> '' then begin
        mData.Append;
        mDataHead2.AsBoolean := True;
        mDataDep_NameX.AsString := qrMaster.FieldByName('Name').AsString;
        mDataGenQty.AsInteger := qrMaster.FieldByName('GenQty').AsInteger;
        mDataAssGenQty.AsInteger := qrMaster.FieldByName('AssGenQty').AsInteger;
        mDataWarQty.AsInteger := qrMaster.FieldByName('WarQty').AsInteger;
        mData.Post;
      end;

      sKMtrAsf := qrMaster.FieldByName('KAsfMtrName').AsString;

      if (sKMtrAsf = qrDetail.FieldByName('KAsfMtrName').AsString) and
       (qrMaster.FieldByName('Name').AsString = qrDetail.FieldByName('Name').AsString) then begin

        mData.Append;
        mDataMid.AsBoolean := True;
        mData.Post;

        while (sKMtrAsf = qrDetail.FieldByName('KAsfMtrName').AsString) and
         (qrMaster.FieldByName('Name').AsString = qrDetail.FieldByName('Name').AsString) and
         not qrDetail.Eof do begin

            mData.Append;
            mDataMain.AsBoolean := True;
            mDataDep_NameX.AsString := qrDetail.FieldByName('Dep_Name').AsString;
            mDataGenQty.AsInteger := qrDetail.FieldByName('GenQty').AsInteger;
            mDataAssGenQty.AsInteger := qrDetail.FieldByName('AssGenQty').AsInteger;
            mDataWarQty.AsInteger := qrDetail.FieldByName('WarQty').AsInteger;
            mData.Post;

          qrDetail.Next;
        end;

      end;

      qrMaster.Next;
    end;

    DecodeDate(Date, yy, mm, dd);
    EkRTF1.CreateVar('CurDate', '"'+IntToStr(dd)+'" '+GetMonthName(mm)+' '+IntToStr(yy)+' г.');
    EkRTF1.ExecuteOpen([mData, qrOrg],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, Copy(sEventObject, 1, 50), []);
//  except
//    on E: Exception do ShowMessage(e.Message);
//  end;
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
    FieldByName('IOFam1').Value :=
      (FieldByName('Im1').AsString+' ')[1]+'.'+
      (FieldByName('Otch1').AsString+' ')[1]+'. '+
      FieldByName('Fam1').AsString;
    FieldByName('FamIO1').Value :=
      FieldByName('Fam1').AsString+' '+
      (FieldByName('Im1').AsString+' ')[1]+'.'+
      (FieldByName('Otch1').AsString+' ')[1]+'.';
  end;
end;

procedure TdmMain.qrDetailCalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('RecNo').Value := abs(RecNo);
  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'ASForm3.rtf';
  EkRTF1.Outfile := GetReportsDir + 'НАСФ Форма № 3.rtf';
end;

procedure TdmMain.EkUDFList1dateCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  (UDFResult as TEkReportVariable).AsString := FormatDateTime('dd.mm.yyyy',Date);
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

function TdmMain.GetMonthName(m: Integer): String;
begin
  Result := '';
  case m of
    1: Result := 'января';
    2: Result := 'февраля';
    3: Result := 'марта';
    4: Result := 'апреля';
    5: Result := 'мая';
    6: Result := 'июня';
    7: Result := 'июля';
    8: Result := 'августа';
    9: Result := 'сентября';
    10: Result := 'октября';
    11: Result := 'ноября';
    12: Result := 'декабря';
  end;
end;

end.

unit dMain;

interface

uses
  SysUtils, Classes, DB, ADODB, ekbasereport, ekrtf, Dialogs, Forms, Windows,
  ekfunc;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrOrg: TADOQuery;
    qrOrgIOFam: TStringField;
    qrOrgFamIO: TStringField;
    qrOrgfam: TStringField;
    qrOrgIm: TStringField;
    qrOrgOtch: TStringField;
    qrOrgPOST: TStringField;
    qrOrgorgname: TWideMemoField;
    ReportQuery: TADOQuery;
    EkUDFList1: TEkUDFList;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1dateCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1NotIsNullCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure qrOrgCalcFields(DataSet: TDataSet);
    procedure qrPersonCalcFields(DataSet: TDataSet);
    procedure EkUDFList1Functions0Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    FOrgID: Integer;
  public
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Форма № 10';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils, BirthDay;

function TdmMain.PrintData: boolean;
var
  IsJet: Boolean;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;
//  try
    if not IsJet then
      ReportQuery.SQL.Text := StringReplace(ReportQuery.SQL.Text, 'Date()', 'GetDate()', [rfReplaceAll]);
    ReportQuery.SQL.Text := ReplaceFullAges(ReportQuery.SQL.Text, IsJet);

    with TADOQuery.Create(nil) do
    try
      Connection := dbMain;

      SQL.Text := 'select COUNT(*) from PERS_SET';
      Open;
      if Fields[0].AsInteger > 0 then
        ReportQuery.SQL.Text := StringReplace(ReportQuery.SQL.Text,'/*PERS_SET*/',
          'and (P.PERS_ID in (select PERS_ID from PERS_SET))', [])
      else
        ReportQuery.SQL.Text := StringReplace(ReportQuery.SQL.Text,'/*PERS_SET*/',
          '', []);
      Close;
    finally Free;
    end;

    ReportQuery.Open;
    qrOrg.Open;
    EkRTF1.ExecuteOpen([ReportQuery, qrOrg],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(FOrgID)]);
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
  end;
end;

procedure TdmMain.qrPersonCalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('RecNo').Value := abs(RecNo);
  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'Form10.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Ведомость на выдачу удостоверений уполномоченным № 10.rtf';
end;

procedure TdmMain.EkUDFList1dateCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  (UDFResult as TEkReportVariable).AsString := FormatDateTime('dd.mm.yyyy',Date);  
end;

procedure TdmMain.EkUDFList1Functions0Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  With UDFResult as TEkReportVariable do AsInteger := ReportQuery.RecNo;
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

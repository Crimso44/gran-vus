unit dMain;

interface

uses
  SysUtils, Classes, DB, ADODB, ekbasereport, ekrtf, Dialogs, Forms, Windows,
  ekfunc;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrPerson: TADOQuery;
    EkUDFList1: TEkUDFList;
    qrOrg: TADOQuery;
    qrOrgIOFam: TStringField;
    qrOrgFamIO: TStringField;
    qrOrgfam: TStringField;
    qrOrgIm: TStringField;
    qrOrgOtch: TStringField;
    qrOrgPOST: TStringField;
    qrPersonfam: TStringField;
    qrPersonim: TStringField;
    qrPersonotch: TStringField;
    qrPersonBirthYear: TIntegerField;
    qrPersonWSost_Name: TStringField;
    qrPersonVUS: TStringField;
    qrPersonWRNG_NAME: TStringField;
    qrPersonWCAT: TStringField;
    qrPersonPOST_NAME: TStringField;
    qrPersonRecNo: TIntegerField;
    qrPersonOkved: TStringField;
    qrPersonKOKPDTR_Code: TStringField;
    qrPersonWRNG_Name1: TStringField;
    qrOrgorgname: TWideMemoField;
    qrPersonMvkData: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1dateCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1NotIsNullCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure qrOrgCalcFields(DataSet: TDataSet);
    procedure qrPersonCalcFields(DataSet: TDataSet);
  private
    FOrgID: Integer;
  public
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = '����� � 8';

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
  try
    if not IsJet then
      qrPerson.SQL.Text := StringReplace(qrPerson.SQL.Text, 'Date()', 'GetDate()', [rfReplaceAll]);
    qrPerson.SQL.Text := ReplaceFullAges(qrPerson.SQL.Text, IsJet);

    with TADOQuery.Create(nil) do
    try
      Connection := dbMain;
      SQL.Text := 'select Param_Value from Params Where Params.Param_Id = 8';
      Open;
      if not Eof then
        if Fields[0].AsString = '1' then
          qrPerson.SQL.Text := StringReplace(qrPerson.SQL.Text,'KWR.WRNG_NAME',
            'KWR.WRNG_NAME + iif(P.WSOST_ID=9,'' �������'',iif(P.WSOST_ID=10,'' ����������� ������'',''''))', []);
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
    finally Free;
    end;


    qrPerson.Open;
    qrOrg.Open;
    EkRTF1.ExecuteOpen([qrPerson, qrOrg],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['����� �����������: '+IntToStr(FOrgID)]);
  except
    on E: Exception do ShowMessage(e.Message);
  end;
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
  EkRTF1.Infile := GetTemplatesDir + 'Form8.rtf';
  EkRTF1.Outfile := GetReportsDir + '����� � 8.rtf';
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

end.

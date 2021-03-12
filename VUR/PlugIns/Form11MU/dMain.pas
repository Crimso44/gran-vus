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
    EkUDFList1: TEkUDFList;
    qrGen: TADOQuery;
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
    qrOrgNoJet: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1dateCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1NotIsNullCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure qrGenCalcFields(DataSet: TDataSet);
  private
    FOrgID: Integer;
  public
    IsJet: Boolean;
    function OpenData(OrgId: Integer): Integer;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Донесение ф-11 МУ';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils, BirthDay;

function TdmMain.OpenData(OrgId: Integer): Integer;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  if not IsJet then
    qrOrg.SQL.Text := qrOrgNoJet.SQL.Text;

  FOrgID := OrgID;
  try
    qrOrg.SQL.Add('WHERE ORGID='+IntToStr(OrgId));
    qrOrg.SQL.Text := ReplaceFullAges(qrOrg.SQL.Text, IsJet);
    qrOrg.Open;
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
    if qrOrg.IsEmpty then Result := 0 else Result := 1;
  except
    Result := -1;
  end;
end;

function TdmMain.PrintData: boolean;
begin
//  try
    qrOrg.SQL.Text := ReplaceFullAges(qrOrg.SQL.Text, IsJet);
    qrOrg.Open;
    EkRTF1.ExecuteOpen([qrOrg, qrGen],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(FOrgID)]);
//  except
//    Result := false;
//  end;
end;

procedure TdmMain.qrGenCalcFields(DataSet: TDataSet);
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

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'Form11MU.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Донесение ф-11 МУ.rtf';
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

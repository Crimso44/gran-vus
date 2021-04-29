unit dMain;

interface

uses
  DateUtils, StrUtils,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EkRtf, Db, ADODB, ekbasereport, ekfunc;

type
  TdmMain = class(TDataModule)
    EkRTF1: TEkRTF;
    dbMain: TADOConnection;
    qrPers: TADOQuery;
    dsPers: TDataSource;
    qrWRng: TADOQuery;
    qrOVK: TADOQuery;
    qrDep: TADOQuery;
    qrOrg: TADOQuery;
    qrOrgCont: TADOQuery;
    EkUDFList1: TEkUDFList;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1Functions0Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions1Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions2Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    procedure FillExecutor;
    { Private declarations }
  public
    { Public declarations }
    function OpenData(ID: Integer): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Сведения в ОВК о зачислении работника на спецучет';

implementation

{$R *.DFM}

uses SaveEvents, IniSupport;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'LetterSpec.rtf';
  EkRTF1.Outfile := GetReportsDir + 'LetterSpec.rtf';
end;

function TdmMain.OpenData(ID: Integer): boolean;
var i: Integer;
  IsJet: Boolean;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  try
    qrPers.Close;
    qrPers.Parameters.ParamByName('ID').Value := ID;
    qrPers.Open;
    for i:=0 to ComponentCount-1 do
      if Components[i] is TADOQuery then
        if not (Components[i] as TADOQuery).Active then begin
          if not IsJet then
            (Components[i] as TADOQuery).SQL.Text :=
              StringReplace((Components[i] as TADOQuery).SQL.Text,
                '(kovk.IsOVK', '(kovk.IsOVK = 1', [rfReplaceAll]);
          (Components[i] as TADOQuery).Open;
        end;
    Result := true;
  except
    Result := false;
  end;
end;

function TdmMain.PrintData: boolean;
var
  d: TDateTime;
  s: String;
begin
  try
    EkRTF1.OutFile := ExtractFilePath(EkRTF1.OutFile)+'\Сведения в ОВК о зачислении работника на спецучет для '+
      qrPers.FieldByName('Fam').AsString+' '+
      qrPers.FieldByName('Im').AsString+' '+
      qrPers.FieldByName('Otch').AsString+'.rtf';
    d := Date;
    EkRTF1.CreateVar('CurDate', IntToStr(DayOfTheMonth(d))+'.'+IntToStr(MonthOfTheYear(d))+'.'+IntToStr(YearOf(d)));
    qrOrgCont.Open;
    if qrOrgCont.Locate('IS_VUS',1,[]) then begin
      EkRTF1.CreateVar('VUR_PHONE',qrOrgCont.FieldByName('PHONE').AsString);
      EkRTF1.CreateVar('VUR_POST',qrOrgCont.FieldByName('POST').AsString);
      s := IfThen(qrOrgCont.FieldByName('IM').AsString<>'',
             LeftStr(qrOrgCont.FieldByName('IM').AsString,1)+'.','')+
           IfThen(qrOrgCont.FieldByName('OTCH').AsString<>'',
             LeftStr(qrOrgCont.FieldByName('OTCH').AsString,1)+'.','')+
           ' '+qrOrgCont.FieldByName('FAM').AsString;
      EkRTF1.CreateVar('VUR_NAME',s);
    end;
    if qrOrgCont.Locate('IS_GEN',1,[]) then begin
      EkRTF1.CreateVar('GEN_POST',qrOrgCont.FieldByName('POST').AsString);
      s := IfThen(qrOrgCont.FieldByName('IM').AsString<>'',
             LeftStr(qrOrgCont.FieldByName('IM').AsString,1)+'.','')+
           IfThen(qrOrgCont.FieldByName('OTCH').AsString<>'',
             LeftStr(qrOrgCont.FieldByName('OTCH').AsString,1)+'.','')+
           ' '+qrOrgCont.FieldByName('FAM').AsString;
      EkRTF1.CreateVar('GEN_NAME',s);
    end;
    FillExecutor;
    EkRTF1.ExecuteOpen([qrPers,qrOVK,qrDep,qrWRng,qrOrg],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер сотрудника: '+IntToStr(qrPers.Parameters.ParamByName('ID').Value)]);
  except
    Result := false;
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


end.

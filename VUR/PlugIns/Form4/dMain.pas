unit dMain;

interface

uses
  Windows, Messages, SysUtils, DateUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EkRtf, Db, ADODB, ekbasereport, dxmdaset, ekfunc;

type
  TdmMain = class(TDataModule)
    EkRTF1: TEkRTF;
    dbMain: TADOConnection;
    qrPers: TADOQuery;
    dsPers: TDataSource;
    qrOrg: TADOQuery;
    qrOVK: TADOQuery;
    qrVUR: TADOQuery;
    EkUDFList1: TEkUDFList;
    qrExecutor: TADOQuery;
    qrExecutorCONTID: TIntegerField;
    qrExecutorORGID: TIntegerField;
    qrExecutorDEPART: TWideStringField;
    qrExecutorPOST: TWideStringField;
    qrExecutorFIO: TWideStringField;
    qrExecutorPHONE: TWideStringField;
    qrExecutorFAX: TWideStringField;
    qrExecutorEMAIL: TWideStringField;
    qrExecutorIS_GEN: TSmallintField;
    qrExecutorIS_VUS: TSmallintField;
    qrExecutorFAM: TWideStringField;
    qrExecutorIM: TWideStringField;
    qrExecutorOTCH: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1NotIsNullCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1EqualCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions2Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions3Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    procedure FillExecutor;
    { Private declarations }
  public
    { Public declarations }
    function OpenData(ID: Integer; isDummy: Boolean): boolean;
    function PrintData(MonthCount: String; PrintVK, PrintAddr: boolean; FioDat, PostRod: string): boolean;
    function GetFio(ID: Integer): string;
    function GetPost(ID: Integer): string;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Форма № 4';

implementation

{$R *.DFM}

uses SaveEvents, StrUtils, IniSupport;

procedure TdmMain.EkUDFList1EqualCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
  function GetInt(O: TObject): Integer;
  begin
    if O is TField then
    try
      Result := TField(O).AsInteger
    except
      if TField(O).AsBoolean then Result := 1
      else Result := 0;
    end
    else Result := TEkReportVariable(O).AsInteger;
  end;
var
  i: Integer;
begin
  (UDFResult as TEkReportVariable).AsBoolean := False;
  for i:=1 to ArgCount-1 do
    if GetInt(Args[0])=GetInt(Args[i]) then
    begin
      (UDFResult as TEkReportVariable).AsBoolean := True;
      Exit;
    end;
end;

procedure TdmMain.EkUDFList1Functions2Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  (UDFResult as TEkReportVariable).AsString := '';
  if TField(Args[0]).IsNull then Exit;
  if Length(Args) = 1 then
    (UDFResult as TEkReportVariable).AsString :=
      FormatDateTime('dd/mm/yyyy', TField(Args[0]).AsDateTime)
  else
    (UDFResult as TEkReportVariable).AsString :=
      FormatDateTime(TEkReportVariable(Args[1]).AsString, TField(Args[0]).AsDateTime);
end;

procedure TdmMain.EkUDFList1Functions3Calculate(Sender: TObject;
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

procedure TdmMain.EkUDFList1NotIsNullCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
function CheckNull(O: TObject): Boolean;
begin
  if O is TField then Result := TField(O).IsNull or (TField(O).AsString='')
  else Result := Trim(TEkReportVariable(O).AsString) = '';
end;
var
  I: integer;
  B: boolean;
begin
  B := True;
  for I := 0 to Length(Args)-1 do B := B and not CheckNull(Args[I]);
  (UDFResult as TEkReportVariable).AsBoolean := B;
end;

function TdmMain.GetFio(ID: Integer): string;
begin
  try
    qrPers.Close;
    qrPers.Parameters.ParamByName('ID').Value := ID;
    qrPers.Open;
    Result := qrPers.FieldByName('Fam').AsString + ' ' + qrPers.FieldByName('Im').AsString + ' ' + qrPers.FieldByName('Otch').AsString;
    qrPers.Close;
  except on e: Exception do begin
    ShowMessage(e.Message);
    Result := '';
  end end;
end;

function TdmMain.GetPost(ID: Integer): string;
begin
  try
    qrPers.Close;
    qrPers.Parameters.ParamByName('ID').Value := ID;
    qrPers.Open;
    Result := qrPers.FieldByName('Post_Name').AsString;
    qrPers.Close;
  except on e: Exception do begin
    ShowMessage(e.Message);
    Result := '';
  end end;
end;

const
  MonthName: Array [1..12] of string =
  ('января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря');

function Date2Doc(ADate: TDateTime): string;
var year,month,day: Word;
begin
  if ADate=0 then Result := '"     "              20     года' else begin
    DecodeDate(ADate,year,month,day);
    Result := '"'+IntToStr(day)+'"   '+MonthName[month]+'   '+IntToStr(year)+' года';
  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'form4.rtf';
  EkRTF1.Outfile := GetReportsDir + 'form4.rtf';
end;

function TdmMain.OpenData(ID: Integer; isDummy: Boolean): boolean;
var i: Integer;
begin
  try
    qrPers.Close;
    qrPers.Parameters.ParamByName('ID').Value := ID;
    qrPers.Open;
    for i:=0 to ComponentCount-1 do
      if Components[i] is TADOQuery then
        if not (Components[i] as TADOQuery).Active then
          (Components[i] as TADOQuery).Open;

    Result := true;
  except on e: Exception do begin
    ShowMessage(e.Message);
    Result := false;
  end end;
end;

function TdmMain.PrintData(MonthCount: String; PrintVK, PrintAddr: boolean; FioDat, PostRod: string): boolean;
//
var depType: String;
begin
  try
    EkRTF1.ClearVars;



    EkRTF1.CreateVar('Month_Count',MonthCount);
    EkRTF1.CreateVar('FioDat',FioDat);
    EkRTF1.CreateVar('PostRod',PostRod);

    if qrPers.FieldByName('MvkMonth').IsNull then
      EkRTF1.CreateVar('MvkMonth','')
    else
      EkRTF1.CreateVar('MvkMonth', MonthName[qrPers.FieldByName('MvkMonth').AsInteger]);
    if qrPers.FieldByName('MvkYear').IsNull then
      EkRTF1.CreateVar('MvkYear','')
    else
      EkRTF1.CreateVar('MvkYear', Copy(qrPers.FieldByName('MvkYear').AsString, 3, MaxInt));

    if PrintVK then
      EkRTF1.CreateVar('OVK_Name',qrPers.FieldByName('OVK_Name').AsString)
    else
      EkRTF1.CreateVar('OVK_Name','');

    if PrintAddr then
      EkRTF1.CreateVar('Addr_Str',qrPers.FieldByName('Addr_Str').AsString)
    else
      EkRTF1.CreateVar('Addr_Str','');

    qrOrg.Open;
    if qrOrg.FieldByName('OrgSName').AsString <> '' then begin
      depType :=
        'в ' + qrOrg.FieldByName('OrgSName').AsString + ' ' + depType;
    end;


    EkRTF1.Infile := ExtractFilePath(EkRTF1.Infile)+'form4.rtf';
    EkRTF1.Outfile := ExtractFilePath(EkRTF1.Outfile)+
      'Извещение о зачислении на спецучет '+
      qrPers.FieldByName('Fam').AsString+' '+
      qrPers.FieldByName('Im').AsString+' '+
      qrPers.FieldByName('Otch').AsString+' таб.№ '+
      qrPers.FieldByName('Tab_Numb').AsString+'.rtf';

    FillExecutor;

    EkRTF1.ExecuteOpen([qrPers,qrOrg,qrVUR,qrOVK],SW_SHOWDEFAULT);
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер сотрудника: '+IntToStr(qrPers.Parameters.ParamByName('ID').Value)]);
    Result := true;
  except on e: Exception do begin
    Result := false;
    ShowMessage(E.Message);
  end end;
end;

procedure TdmMain.FillExecutor;
begin
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
    EkRtf1.CreateVar('ExecutorFam', qrExecutorFam.AsString);
    EkRtf1.CreateVar('ExecutorIm', qrExecutorIm.AsString);
    EkRtf1.CreateVar('ExecutorOtch', qrExecutorOtch.AsString);
    EkRtf1.CreateVar('ExecutorPhone', qrExecutorPhone.AsString);
    EkRtf1.CreateVar('ExecutorPost', qrExecutorPost.AsString);
  end;
  qrExecutor.Close;
end;

end.

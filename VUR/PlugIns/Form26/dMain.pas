unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
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
    qrStudyHistory: TADOQuery;
    qrN26History: TADOQuery;
    dsN26History: TDataSource;
    qrN26HistoryN26_ID: TIntegerField;
    qrN26HistoryCreate_Date: TDateField;
    qrN26HistoryGive_Date: TDateField;
    qrN26: TADOQuery;
    qrN26HistoryForm_Num: TStringField;
    qrDegree: TADOQuery;
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
    function OpenData(ID: Integer): boolean;
    function PrintData(PrintChief, PrintVKChief: boolean): boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Справка для отсрочки призыва учащегося';

implementation

{$R *.DFM}

uses SaveEvents, StrUtils, dateUtils, IniSupport;

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

function Date2Doc(ADate: TDateTime): string;
const
  MonthName: Array [1..12] of string =
  ('января','февраля','марта','апреля','мая','июня','июля','августа','сентября','октября','ноября','декабря');
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
  EkRTF1.Infile := GetTemplatesDir + 'form26.rtf';
  EkRTF1.Outfile := GetReportsDir + 'form26.rtf';
end;

function TdmMain.OpenData(ID: Integer): boolean;
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
  except
    Result := false;
  end;
end;

function TdmMain.PrintData(PrintChief, PrintVKChief: boolean): boolean;
type
  TFIO = record F, I, O: String end;
//
  function ParseFIO(AFIO: String): TFIO;
    function ExtractWord(var S: String): String;
    var I: Integer;
    begin
      I := Pos(' ',S);
      if I>0 then Result := Copy(S,1,I-1) else Result := S;
      S := Trim(Copy(S,I+1, Length(S)));
    end;
  begin
    AFIO := Trim(AFIO);
    with Result do begin
      F := ExtractWord(AFIO);
      I := ExtractWord(AFIO);
      O := ExtractWord(AFIO);
    end;
  end;

  function FIO2IOFam(AFIO: String): String;
  begin
    with ParseFIO(AFIO) do Result := LeftStr(I,1)+'.'+LeftStr(O,1)+'. '+F;
  end;

  function FIO2FamIO(AFIO: String): String;
  begin
    with ParseFIO(AFIO) do Result := F+' '+LeftStr(I,1)+'.'+LeftStr(O,1)+'.';
  end;
//
var depType: String;
begin
  try
    EkRTF1.ClearVars;

    EkRTF1.CreateVar('in_date','');
    EkRTF1.CreateVar('in_ord_numb','');
    EkRTF1.CreateVar('in_ord_date','');

    qrStudyHistory.First;
    while not qrStudyHistory.Eof do begin
      if qrPers.FieldByName('IsAspirant').AsInteger = 1 then begin
        if AnsiUpperCase(LeftStr(qrStudyHistory.FieldByName('POST_NAME').AsString,8)) = 'АСПИРАНТ' then begin
          EkRTF1.VarByName('in_date').AsString :=
                            IntToStr(YearOf(qrStudyHistory.FieldByName('IN_DATE').AsDateTime));
          EkRTF1.VarByName('in_ord_numb').AsString := qrStudyHistory.FieldByName('IN_ORD_NUMB').AsString;
          EkRTF1.VarByName('in_ord_date').AsString :=
                 FormatDateTime('dd.mm.yyyy',qrStudyHistory.FieldByName('IN_ORD_DATE').AsDateTime);
          Break;
        end;
      end
      else begin
        if AnsiUpperCase(LeftStr(qrStudyHistory.FieldByName('POST_NAME').AsString,7)) = 'СТУДЕНТ' then begin
          EkRTF1.VarByName('in_date').AsString :=
                            IntToStr(YearOf(qrStudyHistory.FieldByName('IN_DATE').AsDateTime));
          EkRTF1.VarByName('in_ord_numb').AsString := qrStudyHistory.FieldByName('IN_ORD_NUMB').AsString;
          EkRTF1.VarByName('in_ord_date').AsString :=
                 FormatDateTime('dd.mm.yyyy',qrStudyHistory.FieldByName('IN_ORD_DATE').AsDateTime);
          Break;
        end;
      end;
      qrStudyHistory.Next;
    end;

    EkRTF1.CreateVar('post_name','');
    EkRTF1.CreateVar('dep_name','');
    depType := 'по направлению подготовки (специальности)';

    qrStudyHistory.Last;
    while not qrStudyHistory.Bof do begin
      if qrPers.FieldByName('IsAspirant').AsInteger = 1 then begin
        if AnsiUpperCase(LeftStr(qrStudyHistory.FieldByName('POST_NAME').AsString,8)) = 'АСПИРАНТ' then begin
          if (Pos('1', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
             (Pos('ПЕРВО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
              EkRTF1.VarByName('post_name').AsString := 'первом году аспирантуры'
          else if (Pos('2', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
             (Pos('ВТОРО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
              EkRTF1.VarByName('post_name').AsString := 'втором году аспирантуры'
          else if (Pos('3', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
             (Pos('ТРЕТЬ', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
              EkRTF1.VarByName('post_name').AsString := 'третьем году аспирантуры'
          else EkRTF1.VarByName('post_name').AsString := qrStudyHistory.FieldByName('POST_NAME').AsString;

          if (qrPers.FieldByName('NAPR_NAME').IsNull) then begin
            depType := 'по направлению подготовки';
            EkRTF1.VarByName('dep_name').AsString :=
              ifThen(qrStudyHistory.FieldByName('DEP_FULL_NAME').IsNull,
                      qrStudyHistory.FieldByName('DEP_NAME').AsString,
                        qrStudyHistory.FieldByName('DEP_FULL_NAME').AsString);
          end else begin
            depType := 'по специальности';
            EkRTF1.VarByName('dep_name').AsString :=
              IfThen(Trim(qrPers.FieldByName('NAPR_KOD').AsString) = '', '',
                qrPers.FieldByName('NAPR_KOD').AsString + ' / ') +
                  qrPers.FieldByName('NAPR_NAME').AsString;
          end;
          Break;
        end;
      end
      else begin
        if AnsiUpperCase(LeftStr(qrStudyHistory.FieldByName('POST_NAME').AsString,7)) = 'СТУДЕНТ' then begin
          if (Pos('1', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
             (Pos('ПЕРВО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
              EkRTF1.VarByName('post_name').AsString := 'первом курсе'
          else if (Pos('2', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
             (Pos('ВТОРО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
              EkRTF1.VarByName('post_name').AsString := 'втором курсе'
          else if (Pos('3', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
             (Pos('ТРЕТЬ', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
              EkRTF1.VarByName('post_name').AsString := 'третьем курсе'
          else if (Pos('3', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
             (Pos('ЧЕТВЕР', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
              EkRTF1.VarByName('post_name').AsString := 'четвертом курсе'
          else if (Pos('3', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
             (Pos('ПЯТО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
              EkRTF1.VarByName('post_name').AsString := 'пятом курсе'
          else if (Pos('3', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
             (Pos('ШЕСТО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
              EkRTF1.VarByName('post_name').AsString := 'шестом курсе'
          else EkRTF1.VarByName('post_name').AsString := qrStudyHistory.FieldByName('POST_NAME').AsString;

          if (qrPers.FieldByName('NAPR_NAME').IsNull) then
            EkRTF1.VarByName('dep_name').AsString :=
              ifThen(qrStudyHistory.FieldByName('DEP_FULL_NAME').IsNull,
                      qrStudyHistory.FieldByName('DEP_NAME').AsString,
                        qrStudyHistory.FieldByName('DEP_FULL_NAME').AsString)
          else EkRTF1.VarByName('dep_name').AsString :=
            IfThen(Trim(qrPers.FieldByName('NAPR_KOD').AsString) = '', '',
              qrPers.FieldByName('NAPR_KOD').AsString + ' / ') +
                qrPers.FieldByName('NAPR_NAME').AsString;
          Break;
        end;
      end;
      qrStudyHistory.Prior;
    end;
    if not qrPers.FieldByName('Degree_Id').IsNull then begin
      qrDegree.Open;
      qrDegree.Locate('Sc_Id', qrPers.FieldByName('Degree_Id').AsInteger, []);
      depType :=
        'по программе подготовки ' + qrDegree.FieldByName('Sc_Name').AsString + ' ' + depType;
    end;

    qrOrg.Open;
    if qrOrg.FieldByName('OrgSName').AsString <> '' then begin
      depType :=
        'в ' + qrOrg.FieldByName('OrgSName').AsString + ' ' + depType;
    end;

    EkRTF1.CreateVar('dep_type', depType);

    EkRTF1.CreateVar('form_num',qrN26.FieldByName('FORM_NUM').AsString);
    EkRTF1.CreateVar('create_date',FormatDateTime('dd.mm.yyyy', qrN26.FieldByName('CREATE_DATE').AsDateTime));

    if PrintChief then begin
      EkRTF1.CreateVar('vurpost', qrVUR.FieldByName('POST').AsString);
      EkRTF1.CreateVar('vurname', FIO2IOFam(qrVUR.FieldByName('Fam').AsString+' '+
                                         qrVUR.FieldByName('Im').AsString+' '+
                                         qrVUR.FieldByName('Otch').AsString));
    end
    else begin
      EkRTF1.CreateVar('vurpost', '');
      EkRTF1.CreateVar('vurname', '');
    end;

    if PrintVKChief then begin
      EkRTF1.CreateVar('vkpost', qrOrg.FieldByName('VKChiefRangeName').AsString);
      EkRTF1.CreateVar('vkname', qrOrg.FieldByName('VKChief').AsString);
    end
    else begin
      EkRTF1.CreateVar('vkpost', '');
      EkRTF1.CreateVar('vkname', '');
    end;


    EkRTF1.Infile := ExtractFilePath(EkRTF1.Infile)+'form26.rtf';
    EkRTF1.Outfile := ExtractFilePath(EkRTF1.Outfile)+
      'Справка для отсрочки призыва учащегося '+
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
    //ShowMessage(E.Message);
  end end;
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


end.

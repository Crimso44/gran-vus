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
  sEventObject = 'Справка об обучении аспиранта, адъюнкта, ординатора, ассистента-стажера';

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
  EkRTF1.Infile := GetTemplatesDir + 'form26x.rtf';
  EkRTF1.Outfile := GetReportsDir + 'form26x.rtf';
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
var
  depType, s, ss: String;
  napr_missing: TStringList;
  i, ii: Integer;
  inDate: TDateTime;
begin
  try
    EkRTF1.ClearVars;

    EkRTF1.CreateVar('in_date','');
    EkRTF1.CreateVar('in_ord_numb','');
    EkRTF1.CreateVar('in_ord_date','');

    qrStudyHistory.First;
    inDate := qrStudyHistory.FieldByName('IN_DATE').AsDateTime;
    EkRTF1.VarByName('in_date').AsString := IntToStr(YearOf(inDate));
    EkRTF1.VarByName('in_ord_numb').AsString := qrStudyHistory.FieldByName('IN_ORD_NUMB').AsString;
    EkRTF1.VarByName('in_ord_date').AsString :=
           FormatDateTime('dd.mm.yyyy',qrStudyHistory.FieldByName('IN_ORD_DATE').AsDateTime);

    EkRTF1.CreateVar('post_name','');
    EkRTF1.CreateVar('dep_name','');
    depType := 'по направлению подготовки (специальности)';

    napr_missing := TStringList.Create;

    if qrStudyHistory.FieldByName('NAPR_KOD').AsString.StartsWith('02') then
      EkRTF1.CreateVar('vid_obr', 'среднего профессионального')
    else (*if
      qrStudyHistory.FieldByName('NAPR_KOD').AsString.StartsWith('03') or
      qrStudyHistory.FieldByName('NAPR_KOD').AsString.StartsWith('04') or
      qrStudyHistory.FieldByName('NAPR_KOD').AsString.StartsWith('05') then*)
      EkRTF1.CreateVar('vid_obr', 'высшего');
    if qrStudyHistory.FieldByName('NNAPR_KOD').IsNull then begin
      s := Copy(qrStudyHistory.FieldByName('NAPR_KOD').AsString, 1, 2) + '0000';
      napr_missing.Add(s);
      EkRTF1.CreateVar('okso_main', ' ???');
    end else
      EkRTF1.CreateVar('okso_main',
        qrStudyHistory.FieldByName('NNAPR_KOD').AsString + ' ' +
        qrStudyHistory.FieldByName('NNAPR_NAME').AsString);
    EkRTF1.CreateVar('okso_detail',
        qrStudyHistory.FieldByName('NAPR_KOD').AsString + ' ' +
        qrStudyHistory.FieldByName('NAPR_NAME').AsString);

    qrStudyHistory.Last;
    if qrStudyHistory.FieldByName('NAPR_KOD').AsString.StartsWith('06') then begin
      EkRTF1.CreateVar('vid_obr2', 'аспирантуры');
      EkRTF1.CreateVar('vid_obr3', 'Аспирантура');
    end else if qrStudyHistory.FieldByName('NAPR_KOD').AsString.StartsWith('07') then begin
      EkRTF1.CreateVar('vid_obr2', 'адьюнктуры');
      EkRTF1.CreateVar('vid_obr3', 'Адьюнктура');
    end else if qrStudyHistory.FieldByName('NAPR_KOD').AsString.StartsWith('08') then begin
      EkRTF1.CreateVar('vid_obr2', 'ординатуры');
      EkRTF1.CreateVar('vid_obr3', 'Ординатура');
    end else if qrStudyHistory.FieldByName('NAPR_KOD').AsString.StartsWith('09') then begin
      EkRTF1.CreateVar('vid_obr2', 'ассистентуры-стажировки');
      EkRTF1.CreateVar('vid_obr3', 'Ассистентура-стажировка');
    end else begin
      EkRTF1.CreateVar('vid_obr2', '');
      EkRTF1.CreateVar('vid_obr3', '');
    end;
    if qrStudyHistory.FieldByName('NNAPR_KOD').IsNull then begin
      s := Copy(qrStudyHistory.FieldByName('NAPR_KOD').AsString, 1, 2) + '0000';
      if napr_missing.IndexOf(s) < 0 then
        napr_missing.Add(s);
      EkRTF1.CreateVar('okso_main2', s + ' ???');
    end else
      EkRTF1.CreateVar('okso_main2',
        qrStudyHistory.FieldByName('NNAPR_KOD').AsString + ' ' +
        qrStudyHistory.FieldByName('NNAPR_NAME').AsString);
    EkRTF1.CreateVar('okso_detail2',
        qrStudyHistory.FieldByName('NAPR_KOD').AsString + ' ' +
        qrStudyHistory.FieldByName('NAPR_NAME').AsString);

    if napr_missing.Count > 0 then begin
      s := 'Для подготовки системой справки об обучении в классификатор специальностей необходимо внести позицию с кодом ';
      for i := 0 to napr_missing.Count - 1 do begin
        if i>0 then s := s + ', ';
        s := s + napr_missing[i];
      end;
      Dialogs.ShowMessage(s);
      Result := false;
      Exit;
    end;


    ss := '';
    s := Copy(qrStudyHistory.FieldByName('NAPR_KOD').AsString, 3, 2);
    if s = '02' then
      ss := ' колледжа'
    else if s = '03' then
      ss := ' бакалавриата'
    else if s = '04' then
      ss := ' магистратуры'
    else if s = '05' then
      ss := ' специалитета';
    if (Pos('1', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
       (Pos('ПЕРВО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
        EkRTF1.VarByName('post_name').AsString := 'первом курсе' + ss
    else if (Pos('2', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
       (Pos('ВТОРО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
        EkRTF1.VarByName('post_name').AsString := 'втором курсе' + ss
    else if (Pos('3', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
       (Pos('ТРЕТЬ', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
        EkRTF1.VarByName('post_name').AsString := 'третьем курсе' + ss
    else if (Pos('3', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
       (Pos('ЧЕТВЕР', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
        EkRTF1.VarByName('post_name').AsString := 'четвертом курсе' + ss
    else if (Pos('3', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
       (Pos('ПЯТО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
        EkRTF1.VarByName('post_name').AsString := 'пятом курсе' + ss
    else if (Pos('3', qrStudyHistory.FieldByName('POST_NAME').AsString) > 0) or
       (Pos('ШЕСТО', AnsiUpperCase(qrStudyHistory.FieldByName('POST_NAME').AsString)) > 0) then
        EkRTF1.VarByName('post_name').AsString := 'шестом курсе' + ss
    else EkRTF1.VarByName('post_name').AsString := qrStudyHistory.FieldByName('POST_NAME').AsString;

    s := '';
    if qrStudyHistory.FieldByName('time_y').AsInteger > 0 then begin
      i := qrStudyHistory.FieldByName('time_y').AsInteger;
      inDate := IncYear(inDate, i);
      ii := i mod 10;
      if i = 1 then
        s := s + '1 год'
      else if (ii = 2) or (ii = 3) or (ii = 4) then
        s := s + IntToStr(i) + ' года'
      else
        s := s + IntToStr(i) + ' лет';
    end;
    if qrStudyHistory.FieldByName('time_m').AsInteger > 0 then begin
      if s <> '' then s := s + ', ';
      i := qrStudyHistory.FieldByName('time_m').AsInteger;
      inDate := IncMonth(inDate, i);
      ii := i mod 10;
      if i = 1 then
        s := s + '1 месяц'
      else if (ii = 2) or (ii = 3) or (ii = 4) then
        s := s + IntToStr(i) + ' месяца'
      else
        s := s + IntToStr(i) + ' месяцев';
    end;
    if qrStudyHistory.FieldByName('time_d').AsInteger > 0 then begin
      if s <> '' then s := s + ', ';
      i := qrStudyHistory.FieldByName('time_d').AsInteger;
      inDate := IncDay(inDate, i);
      ii := i mod 10;
      if i = 1 then
        s := s + '1 день'
      else if (ii = 2) or (ii = 3) or (ii = 4) then
        s := s + IntToStr(i) + ' дня'
      else
        s := s + IntToStr(i) + ' дней';
    end;

    EkRTF1.CreateVar('srok', s);
    EkRTF1.CreateVar('srok_end', Date2Doc(inDate));

    EkRTF1.CreateVar('ed_name', qrPers.FieldByName('Ed_Name').AsString);

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

    EkRTF1.CreateVar('Certificate', qrOrg.FieldByName('Certificate').AsString);
    EkRTF1.CreateVar('CertificateWho', qrOrg.FieldByName('CertificateWho').AsString);
    EkRTF1.CreateVar('BeginCertificate', Date2Doc(qrOrg.FieldByName('BeginCertificate_date').AsDateTime));
    EkRTF1.CreateVar('EndCertificate', Date2Doc(qrOrg.FieldByName('EndCertificate_date').AsDateTime));

    EkRTF1.CreateVar('DefendOK', not qrPers.FieldByName('RealDefend_date').IsNull);
    EkRTF1.CreateVar('Defend_Date', Date2Doc(qrPers.FieldByName('RealDefend_date').AsDateTime));
    EkRTF1.CreateVar('Sovet_Shifr', qrPers.FieldByName('Sovet_Shifr').AsString);
    EkRTF1.CreateVar('Sovet_Org', qrPers.FieldByName('Sovet_Org').AsString);
    EkRTF1.CreateVar('Sovet_Date', Date2Doc(qrPers.FieldByName('Sovet_Date').AsDateTime));
    EkRTF1.CreateVar('Sovet_Num', qrPers.FieldByName('Sovet_Num').AsString);
    EkRTF1.CreateVar('Sovet_Org_Order', qrPers.FieldByName('Sovet_Org_Order').AsString);

    s := '';
    case qrPers.FieldByName('war_program').AsInteger of
      0: s := 'офицера';
      1: s := 'солдата (матроса)';
      2: s := 'сержанта (старшины)';
    end;
    EkRTF1.CreateVar('war_program', s);

    EkRTF1.CreateVar('BeginWar_Date', Date2Doc(qrPers.FieldByName('BeginWar_Date').AsDateTime));
    if qrPers.FieldByName('RealEndWar_Date').IsNull then
      EkRTF1.CreateVar('EndWar_Date', Date2Doc(qrPers.FieldByName('EndWar_Date').AsDateTime))
    else
      EkRTF1.CreateVar('EndWar_Date', Date2Doc(qrPers.FieldByName('RealEndWar_Date').AsDateTime));

    EkRTF1.Infile := ExtractFilePath(EkRTF1.Infile)+'form26x.rtf';
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

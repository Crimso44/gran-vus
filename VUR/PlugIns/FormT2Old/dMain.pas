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
    qrWkType: TADOQuery;
    qrWkChar: TADOQuery;
    qrNat: TADOQuery;
    qrLangs: TADOQuery;
    qrEduc: TADOQuery;
    qrEdData: TADOQuery;
    qrFamState: TADOQuery;
    qrFamily: TADOQuery;
    qrAddr: TADOQuery;
    qrPhones: TADOQuery;
    qrWRng: TADOQuery;
    qrWSost: TADOQuery;
    qrOVK: TADOQuery;
    qrSc: TADOQuery;
    qrVUR: TADOQuery;
    taAppointment: TdxMemData;
    qrAppointment: TADOQuery;
    qrAssign: TADOQuery;
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
    function iif(bCond: Boolean; sTrue, sFalse: String): String;
    function GetParamValue(Id: Integer): String;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Форма Т-2(ВУС) шапка старая';

implementation

{$R *.DFM}

uses SaveEvents, StrUtils, dateUtils, IniSupport;

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

function CONFDATE(ADate: TDateTime): String;
var year,month,day: Word;
begin
  if ADate=0 then Result := '' else begin
    DecodeDate(ADate,year,month,day);
    Result := IntToStr(day)+'.'+IntToStr(month)+'.'#13+IntToStr(year);
  end;
end;


procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'form2.rtf';
  EkRTF1.Outfile := GetReportsDir + 'form2.rtf';
end;

function TdmMain.iif(bCond: Boolean; sTrue, sFalse: String): String;
begin
  if bCond then
    Result := sTrue
  else
    Result := sFalse;
end;

function TdmMain.OpenData(ID: Integer): boolean;
var i, AppointmentRowCount: Integer;
  IsJet: Boolean;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;
  try
    qrPers.Close;
    qrPers.Parameters.ParamByName('ID').Value := ID;
    qrPers.Open;
    if not IsJet then
      qrAppointment.SQL.Text :=
        StringReplace(qrAppointment.SQL.Text,
          '&IN_ORD_DATE', '+convert(varchar,in_ord_Date,104)', [rfReplaceAll]);
    qrAppointment.Open;
    for i:=0 to ComponentCount-1 do
      if Components[i] is TADOQuery then
        if not (Components[i] as TADOQuery).Active then
          (Components[i] as TADOQuery).Open;
//    if qrPers.FieldByName('IS_RAB').AsInteger=0
//      then AppointmentRowCount := 5
//      else AppointmentRowCount := 8;
    AppointmentRowCount := 1;

    with taAppointment do begin
      LoadFromDataSet(qrAppointment);
      while RecordCount<AppointmentRowCount do begin
        Append; Post;
      end;
    end;
    Result := true;
  except
    Result := false;
  end;
end;

function TdmMain.PrintData: boolean;
type
  TFIO = record F, I, O: String; end;
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
const
  Gender: array [Boolean] of String = ('мужской','женский');
var
  Worker, Student: Boolean;
  i: Double;
  ii: Integer;
  s: String;
begin
  try
    EkRTF1.ClearVars;

    taAppointment.Last;
    Worker := taAppointment.FieldByName('CPROF_ID').AsInteger <> 500;
    Student := qrPers.FieldByName('IsAspirant').AsInteger < 1;
    while not taAppointment.Bof do begin
      if (taAppointment.FieldByName('CPROF_ID').AsInteger = 500) and Worker then
        taAppointment.Delete
      else if (taAppointment.FieldByName('CPROF_ID').AsInteger <> 500) and not Worker then
        taAppointment.Delete
      else if (taAppointment.FieldByName('CPROF_ID').AsInteger = 500) and not Worker then begin
        if (AnsiUpperCase(LeftStr(taAppointment.FieldByName('POST_NAME').AsString, 7)) = 'СТУДЕНТ')
            and (not Student) then taAppointment.Delete
        else if (AnsiUpperCase(LeftStr(taAppointment.FieldByName('POST_NAME').AsString, 8)) = 'АСПИРАНТ')
            and Student then taAppointment.Delete
        else taAppointment.Prior;
      end
      else taAppointment.Prior;
    end;

    EkRTF1.CreateVar('Worker', Worker);
    EkRTF1.CreateVar('Student', Student);
    EkRTF1.CreateVar('OrgName',qrOrg.FieldByName('ORGNAME').AsString);
    EkRTF1.CreateVar('OKPO',qrOrg.FieldByName('OKPO').AsString);
    EkRTF1.CreateVar('NumbT2',qrPers.FieldByName('NUMB_T2').AsString);
    EkRTF1.CreateVar('D_OVK',qrPers.FieldByName('D_OVK').AsString);
    EkRTF1.CreateVar('D_WBIL',qrPers.FieldByName('D_WBIL').AsString);
    EkRTF1.CreateVar('Date',CONFDATE(qrPers.FieldByName('W_DBEG').AsDateTime));
    EkRTF1.CreateVar('TabNumb',qrPers.FieldByName('TAB_NUMB').AsString);
    EkRTF1.CreateVar('INN',qrPers.FieldByName('INN').AsString);
    EkRTF1.CreateVar('Strah',qrPers.FieldByName('STRAH').AsString);

    if Worker then
      EkRTF1.CreateVar('WkChar',qrWkChar.FieldByName('WCH_NAME').AsString)
    else begin
      i := 0;
      if taAppointment.FieldByName('IN_DATE').AsDateTime > 0 then
        i := (qrPers.FieldByName('StudyEnd_date').AsDateTime -
          taAppointment.FieldByName('IN_DATE').AsDateTime) / 365;
      if i < 0 then i := 0;
      EkRTF1.CreateVar('WkChar', i);
    end;
    if Worker then
      EkRTF1.CreateVar('WkType',qrWkType.FieldByName('WTP_NAME').AsString)
    else begin
      taAppointment.Last;
      EkRTF1.CreateVar('WkType',taAppointment.FieldByName('WTP_NAME').AsString);
      taAppointment.First;
    end;
    EkRTF1.CreateVar('Male',Gender[qrPers.FieldByName('MALE').AsInteger=0]);

    EkRTF1.CreateVar('DogNumb',qrPers.FieldByName('DOG_NUMB').AsString);
    EkRTF1.CreateVar('DogDate',qrPers.FieldByName('DOG_DATE').AsString);

    case qrPers.FieldByName('Document').AsInteger of
      0: EkRTF1.CreateVar('Document', 'Военный билет');
      1: EkRTF1.CreateVar('Document', 'Временное удостоверение');
      2: EkRTF1.CreateVar('Document', 'Приписное свидетельство');
      3: EkRTF1.CreateVar('Document', 'Справка взамен военного билета');
    end;
    EkRTF1.CreateVar('WBSer', qrPers.FieldByName('WBSer').AsString);
    EkRTF1.CreateVar('WBnum', qrPers.FieldByName('WBnum').AsString);

    EkRTF1.CreateVar('Fam',qrPers.FieldByName('FAM').AsString);
    EkRTF1.CreateVar('Im',qrPers.FieldByName('IM').AsString);
    EkRTF1.CreateVar('Otch',qrPers.FieldByName('OTCH').AsString);
    EkRTF1.CreateVar('Alpha',Copy(qrPers.FieldByName('FAM').AsString, 1, 1));
    EkRTF1.CreateVar('BirthDay',qrPers.FieldByName('BIRTHDAY').AsString);
    EkRTF1.CreateVar('BirthPlace',qrPers.FieldByName('BIRTHPLACE').AsString);
    EkRTF1.CreateVar('OKATO',qrPers.FieldByName('OKATO').AsString);
    EkRTF1.CreateVar('Comments',qrPers.FieldByName('Comments').AsString);
    EkRTF1.CreateVar('DisserName',qrPers.FieldByName('DisserName').AsString);
    EkRTF1.CreateVar('Degree',qrPers.FieldByName('SC_NAME').AsString);
    EkRTF1.CreateVar('FIOGuide',qrPers.FieldByName('FIOGuide').AsString);
    EkRTF1.CreateVar('Grazhd',qrNat.FieldByName('NAT_NAME').AsString);
    EkRTF1.CreateVar('GrOKIN',qrNat.FieldByName('OKIN').AsString);
    qrLangs.First;
    while not qrLangs.EOF do begin
      EkRTF1.CreateVar('LangName'+IntToStr(qrLangs.RecNo),
        qrLangs.FieldByName('LANG_NAME').AsString);
      EkRTF1.CreateVar('LangSkill'+IntToStr(qrLangs.RecNo),
        qrLangs.FieldByName('LSK_NAME').AsString);
      EkRTF1.CreateVar('Lng'+IntToStr(qrLangs.RecNo)+'okin',
        qrLangs.FieldByName('OKIN').AsString);
      qrLangs.Next;
    end;
    EkRTF1.CreateVar('Education',qrEduc.FieldByName('ED_NAME').AsString);
    EkRTF1.CreateVar('EdOKIN',qrEduc.FieldByName('OKIN').AsString);
    qrEdData.First;
    while not qrEdData.EOF do begin
      if qrEdData.FieldByName('Type').AsInteger<=3 then begin
        EkRTF1.CreateVar(
          'UchZav'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('UZ_NAME').AsString);
        EkRTF1.CreateVar(
          'ObrDoc'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('ObrDoc').AsString);
        EkRTF1.CreateVar(
          'FormPrep'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('FormPrep').AsString);
        EkRTF1.CreateVar(
          'Diplom'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('DIPLOM').AsString);
        EkRTF1.CreateVar(
          'DiplomSer'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('DIPLOM_SER').AsString);
        EkRTF1.CreateVar(
          'EndDate'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('END_DATE').AsString);
        EkRTF1.CreateVar(
          'EndDateGive'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('END_DATE_GIVE').AsString);
        EkRTF1.CreateVar(
          'Kval'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('KVAL').AsString);
        EkRTF1.CreateVar(
          'Napr'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('NAPR').AsString);
        EkRTF1.CreateVar(
          'OKSO'+qrEdData.FieldByName('Type').AsString,
          qrEdData.FieldByName('OKSO').AsString);
      end;
      qrEdData.Next;
    end;
    EkRTF1.CreateVar('Science',qrSc.FieldByName('SC_NAME').AsString);
    EkRTF1.CreateVar('ScOKIN',qrSc.FieldByName('SC_OKIN').AsString);

    EkRTF1.CreateVar('Prof1',qrPers.FieldByName('PROF1').AsString);
    EkRTF1.CreateVar('OKPDTR1',qrPers.FieldByName('OKPDTR1').AsString);
    EkRTF1.CreateVar('Prof2',qrPers.FieldByName('PROF2').AsString);
    EkRTF1.CreateVar('OKPDTR2',qrPers.FieldByName('OKPDTR2').AsString);
    EkRTF1.CreateVar('FamState',qrFamState.FieldByName('FST_NAME').AsString);
    EkRTF1.CreateVar('FSOKIN',qrFamState.FieldByName('OKIN').AsString);
    qrFamily.First;
    while not qrFamily.EOF do begin
      EkRTF1.CreateVar(
        'FamType'+IntToStr(qrFamily.RecNo),
        qrFamily.FieldByName('FT_NAME').AsString);
      EkRTF1.CreateVar(
        'FamName'+IntToStr(qrFamily.RecNo),
        qrFamily.FieldByName('FAM_NAME').AsString);
      EkRTF1.CreateVar(
        'FamYear'+IntToStr(qrFamily.RecNo),
        qrFamily.FieldByName('FAM_BIRTH').AsString);
      qrFamily.Next;
    end;
    EkRTF1.CreateVar('PspSer',qrPErs.FieldByName('PSP_SER').AsString);
    EkRTF1.CreateVar('PspNumb',qrPErs.FieldByName('PSP_NUM').AsString);
    EkRTF1.CreateVar('PspDate',qrPErs.FieldByName('PSP_DATE').AsString);
    EkRTF1.CreateVar('PspPlace',qrPErs.FieldByName('PSP_PLACE').AsString);
    qrAddr.First;
    EkRTF1.CreateVar('ADDR_DATE','        ');
    while not qrAddr.EOF do begin
      EkRTF1.CreateVar(
        'Index'+qrAddr.FieldByName('ADDR_TYPE').AsString,
        qrAddr.FieldByName('POST_CODE').AsString);
      EkRTF1.CreateVar(
        'Address'+qrAddr.FieldByName('ADDR_TYPE').AsString,
        qrAddr.FieldByName('ADDR_STR').AsString);
      if (qrAddr.FieldByName('ADDR_TYPE').AsInteger=0) then
        EkRTF1.VarByName('ADDR_DATE').AsString := Date2Doc(qrAddr.FieldByName('ADDR_DATE').AsDateTime);
      qrAddr.Next;
    end;
    qrPhones.First;
    while not qrPhones.EOF do begin
      EkRTF1.CreateVar(
        'Phone'+qrPhones.FieldByName('PH_TYPE').AsString,
        qrPhones.FieldByName('PH_NUMBER').AsString);
      qrPhones.Next;
    end;
    if qrPers.FieldByName('IS_WAR').AsInteger<>0 then begin
      EkRTF1.CreateVar('CategZap',qrPers.FieldByName('CAT_ZAP').AsString);
      EkRTF1.CreateVar('WRNG_Name1',qrPers.FieldByName('WRNG_NAME1').AsString);
      EkRTF1.CreateVar('WProfile',qrWSost.FieldByName('WSOST_NAME').AsString);
      EkRTF1.CreateVar('VUS',qrPers.FieldByName('VUS').AsString);
      EkRTF1.CreateVar('CategGodn',qrPers.FieldByName('WCAT').AsString);
      EkRTF1.CreateVar('OVK',qrOVK.FieldByName('OVK').AsString);
      EkRTF1.CreateVar('OVK_NAME',qrOVK.FieldByName('OVK_NAME').AsString);
      if GetParamValue(11) = '1' then begin
        EkRTF1.CreateVar('WUch1',qrPers.FieldByName('WUCHET1').AsString);
        if qrPers.FieldByName('WUCHET2_IsWork').AsInteger <> 0 then begin
          s := qrPers.FieldByName('WUCHET2').AsString;
          if qrPers.FieldByName('WUCHET2_Ser').AsString <> '' then
            s := 'Сер. ' + qrPers.FieldByName('WUCHET2_Ser').AsString + ' № ' + s +
              ' от ' + Date2Doc(qrPers.FieldByName('WUCHET2_date').AsDateTime);
          EkRTF1.CreateVar('WUch2',s);
          s := qrPers.FieldByName('PDPCode').AsString;
          ii := Pos('/', s);
          if ii > 0 then begin
            EkRTF1.CreateVar('WOKVED', '  ОКВЭД:'+Copy(s, 1, ii-1));
            EkRTF1.CreateVar('WOKPDTR', '  ОКПДТР:'+Copy(s, ii+1, MaxInt));
          end;
        end;
      end;
      EkRTF1.CreateVar('WDiscl',qrPers.FieldByName('WDISCL').AsString);
      if GetParamValue(14) = '1' then begin
        EkRTF1.CreateVar('show9', true);
        EkRTF1.CreateVar('Delay',qrPers.FieldByName('DelayName').AsString);
        EkRTF1.CreateVar('DelayStart',Date2Doc(qrPers.FieldByName('DelayStart_date').AsDateTime));
        EkRTF1.CreateVar('DelayEnd',Date2Doc(qrPers.FieldByName('DelayEnd_date').AsDateTime));
      end else begin
        EkRTF1.CreateVar('show9', false);
        EkRTF1.CreateVar('Delay','');
        EkRTF1.CreateVar('DelayStart','');
        EkRTF1.CreateVar('DelayEnd','');
      end;
    end;

    if Worker then begin
      if qrPers.FieldByName('OUT_ORD_NUMB').IsNull then
        EkRTF1.CreateVar('OUT_ORD_NUMB','    ')
      else
        EkRTF1.CreateVar('OUT_ORD_NUMB',qrPers.FieldByName('OUT_ORD_NUMB').AsString);
      EkRTF1.CreateVar('OUT_ORD_DATE',Date2Doc(qrPers.FieldByName('OUT_ORD_DATE').AsDateTime));
      if qrPers.FieldByName('OUT_DATE').IsNull then
        EkRTF1.CreateVar('OUT_DATE','«_____»___________________  20___ года')
      else
        EkRTF1.CreateVar('OUT_DATE',Date2Doc(qrPers.FieldByName('OUT_DATE').AsDateTime));
      EkRTF1.CreateVar('REASON','                     ');
    end
    else begin
      if qrPers.FieldByName('OrderDismissal').IsNull then
        EkRTF1.CreateVar('OUT_ORD_NUMB','    ')
      else
        EkRTF1.CreateVar('OUT_ORD_NUMB',qrPers.FieldByName('OrderDismissal').AsString);
      EkRTF1.CreateVar('OUT_ORD_DATE',Date2Doc(qrPers.FieldByName('OrderDismissal_date').AsDateTime));
      EkRTF1.CreateVar('OUT_DATE',Date2Doc(qrPers.FieldByName('Dismissal_date').AsDateTime));
      if qrPers.FieldByName('ReasonDismissal').AsString <> '' then
        EkRTF1.CreateVar('REASON',qrPers.FieldByName('ReasonDismissal').AsString)
      else EkRTF1.CreateVar('REASON','                     ');
    end;

    if not qrVUR.IsEmpty then begin
      EkRTF1.CreateVar('VURName',FIO2IOFam(qrVUR.FieldByName('FIO').AsString));
      EkRTF1.CreateVar('VURName2',FIO2FamIO(qrVUR.FieldByName('FIO').AsString)); //just in case
      EkRTF1.CreateVar('VURPOST',qrVUR.FieldByName('POST').AsString);
    end;
    if (qrPers.FieldByName('IS_RAB').AsInteger=0) and Worker then
      EkRTF1.Infile := ExtractFilePath(EkRTF1.Infile)+'form2vus2.rtf'
    else
      EkRTF1.Infile := ExtractFilePath(EkRTF1.Infile)+'form2vus1.rtf';
    EkRTF1.Outfile := ExtractFilePath(EkRTF1.Outfile)+
      'Форма Т-2(ВУС) '+
      StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(
        qrPers.FieldByName('Fam').AsString+' '+
        qrPers.FieldByName('Im').AsString+' '+
        qrPers.FieldByName('Otch').AsString+' таб.№ '+
        qrPers.FieldByName('Tab_Numb').AsString
      ,'/','_',[rfReplaceAll]),'\','_',[rfReplaceAll]),':','_',[rfReplaceAll]),'''','_',[rfReplaceAll]),'"','_',[rfReplaceAll]) +
      '.rtf';

    qrAssign.Open;

    FillExecutor;

    EkRTF1.ExecuteOpen([taAppointment, qrAssign],SW_SHOWDEFAULT);
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер сотрудника: '+IntToStr(qrPers.Parameters.ParamByName('ID').Value)]);
    Result := true;
  except
    Result := false;
  end;
end;

function TdmMain.GetParamValue(Id: Integer): String;
begin
  with TADOQuery.Create(Self) do begin
    Connection := dbMain;
    SQL.Text := 'SELECT Param_Value FROM Params where Param_ID = :Id';
    Parameters.ParseSQL(SQL.Text, True);
    Parameters.ParamByName('Id').Value := Id;
    try
      Open;
      if IsEmpty then Result := ''
      else Result := Fields[0].AsString;
    except
      Result := '';
    end;
    Free;
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

unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, Variants;

const
  row_Itogo = 5;
  row_NoBron = 6;
  row_Vsego = 7;

type
  ColumnValues = array[1..15] of Integer;

  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    Form6HdrQuery: TADOQuery;
    ImageList: TImageList;
    ReportQuery: TADOQuery;
    ReportQueryCPROF_ID: TIntegerField;
    ReportQueryF6_ID: TIntegerField;
    ReportQueryPRINT_NAME: TWideStringField;
    ReportQueryEXPRESSION: TWideStringField;
    ReportQueryCALCULATE: TIntegerField;
    ReportQueryCOL_B: TIntegerField;
    ReportQueryCOL_1: TIntegerField;
    ReportQueryCOL_2: TIntegerField;
    ReportQueryCOL_3: TIntegerField;
    ReportQueryCOL_4: TIntegerField;
    ReportQueryCOL_5: TIntegerField;
    ReportQueryCOL_6: TIntegerField;
    ReportQueryCOL_7: TIntegerField;
    ReportQueryCOL_8: TIntegerField;
    ReportQueryCOL_9: TIntegerField;
    ReportQueryCOL_10: TIntegerField;
    ReportQueryCOL_11: TIntegerField;
    ReportQueryCOL_12: TIntegerField;
    ReportQueryCOL_13: TIntegerField;
    ReportQueryCOL_14: TIntegerField;
    ReportQueryCOL_15: TIntegerField;
    ReportQueryCOL_16: TWideStringField;
    ReportQueryCOL_17: TIntegerField;
    ReportQueryCOL_10T: TWideStringField;
    ReportQueryCOL_12T: TWideStringField;
    ReportQueryCOL_1_10: TIntegerField;
    ReportQueryCOL_1_10_12: TIntegerField;
    OrgQuery: TADOQuery;
    ReportQueryPrint_NameX: TWideStringField;
    QDeps: TADOQuery;
    Form6HdrQueryF6_ID: TIntegerField;
    Form6HdrQueryORGID: TIntegerField;
    Form6HdrQueryF6_SHIFR: TWideStringField;
    Form6HdrQueryORG_SHIFR: TWideStringField;
    Form6HdrQueryF6_COUNT: TIntegerField;
    Form6HdrQueryKUO_COUNT: TIntegerField;
    Form6HdrQueryRAB_COUNT: TIntegerField;
    Form6HdrQueryZAP_COUNT: TIntegerField;
    Form6HdrQueryZAB_COUNT: TIntegerField;
    Form6HdrQueryCONFDATE: TDateTimeField;
    Form6HdrQueryCHECKED: TSmallintField;
    Form6HdrQueryPerc: TStringField;
    QDepsDEP_ID: TIntegerField;
    QDepsDEP_NAME: TWideStringField;
    QDepsDEP_FULL_NAME: TWideStringField;
    QDepsKDEPART_Num: TIntegerField;
    QDepsIs_Asf: TBooleanField;
    QDepsOrgName: TStringField;
    QForm6: TADOQuery;
    QForm6COL_1_10: TIntegerField;
    QForm6COL_1_10_12: TIntegerField;
    QForm6COL_17: TIntegerField;
    QForm6Print_NameX: TWideStringField;
    QForm6CPROF_ID: TIntegerField;
    QForm6F6_ID: TIntegerField;
    QForm6PRINT_NAME: TWideStringField;
    QForm6EXPRESSION: TWideStringField;
    QForm6CALCULATE: TIntegerField;
    QForm6COL_B: TIntegerField;
    QForm6COL_1: TIntegerField;
    QForm6COL_2: TIntegerField;
    QForm6COL_3: TIntegerField;
    QForm6COL_4: TIntegerField;
    QForm6COL_5: TIntegerField;
    QForm6COL_6: TIntegerField;
    QForm6COL_7: TIntegerField;
    QForm6COL_8: TIntegerField;
    QForm6COL_9: TIntegerField;
    QForm6COL_10: TIntegerField;
    QForm6COL_11: TIntegerField;
    QForm6COL_12: TIntegerField;
    QForm6COL_13: TIntegerField;
    QForm6COL_14: TIntegerField;
    QForm6COL_15: TIntegerField;
    QForm6COL_16: TWideStringField;
    QForm6COL_10T: TWideStringField;
    QForm6COL_12T: TWideStringField;
    ClearQuery: TADOQuery;
    Form6Query: TADOQuery;
    Form6QueryCPROF_ID: TIntegerField;
    Form6QueryF6_ID: TIntegerField;
    Form6QueryPRINT_NAME: TWideStringField;
    Form6QueryEXPRESSION: TWideStringField;
    Form6QueryCALCULATE: TIntegerField;
    Form6QueryCOL_B: TIntegerField;
    Form6QueryCOL_1: TIntegerField;
    Form6QueryCOL_2: TIntegerField;
    Form6QueryCOL_3: TIntegerField;
    Form6QueryCOL_4: TIntegerField;
    Form6QueryCOL_5: TIntegerField;
    Form6QueryCOL_6: TIntegerField;
    Form6QueryCOL_7: TIntegerField;
    Form6QueryCOL_8: TIntegerField;
    Form6QueryCOL_9: TIntegerField;
    Form6QueryCOL_10: TIntegerField;
    Form6QueryCOL_11: TIntegerField;
    Form6QueryCOL_12: TIntegerField;
    Form6QueryCOL_13: TIntegerField;
    Form6QueryCOL_14: TIntegerField;
    Form6QueryCOL_15: TIntegerField;
    Form6QueryCOL_16: TWideStringField;
    Form6QueryCOL_17: TIntegerField;
    Form6QueryCOL_10T: TWideStringField;
    Form6QueryCOL_12T: TWideStringField;
    KCProfQuery: TADOQuery;
    PersonQuery: TADOQuery;
    KWRangeQuery: TADOQuery;
    StaffListQuery: TADOQuery;
    ReportQueryPerc: TStringField;
    QForm6Perc: TStringField;
    Form6HdrQueryOrgName: TWideMemoField;
    QForm6Perc5: TStringField;
    ReportQueryPerc5: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure ReportQueryCalcFields(DataSet: TDataSet);
    procedure Form6HdrQueryCalcFields(DataSet: TDataSet);
    procedure QDepsCalcFields(DataSet: TDataSet);
    procedure EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
    procedure QForm6CalcFields(DataSet: TDataSet);
    procedure QDepsBeforeOpen(DataSet: TDataSet);
  private
  public
    F6_ID: Integer;
    NoBronMode: Boolean;
    qry, qry2: TADOQuery;
    procedure Init;
    procedure PrintActionExecute(Sender: TObject);
    procedure GenerateForm6;
    procedure SetColumnValue(AColumnName: string; Value: Integer);
    procedure SetColumnValues(cv: ColumnValues);
    function GetColumnValue(AColumnName: string): Integer;
    procedure GetColumnValues(out cv: ColumnValues);
    procedure ClearForm6;
    function GetParamValue(Id: Integer): String;
  end;

  function ISNULL(v: variant; rv: variant) : variant;
  function ParseExpression(AExpression: string): variant;
  procedure ClearValues(var cv: ColumnValues);

var
  dmMain: TdmMain;

const
  sEventObject = 'Форма № 19';

implementation

uses IniSupport, SaveEvents, msg;

{$R *.DFM}

{ TdmMain }

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'Analiz.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Форма № 19.rtf';
end;

function ISNULL(v: variant; rv: variant) : variant;
begin
  if VarIsNull(v) then Result:=rv else Result:=v;
end;

function NULLIF(Value1,Value2: Variant): Variant;
begin
  if Value1=Value2 then Result := NULL else Result := Value1;
end;

procedure ClearValues(var cv: ColumnValues);
var i: Integer;
begin
  for i:= Low(cv) to High(cv) do cv[i]:= 0;
end;

procedure IncValues(var cv: ColumnValues; const Increment: ColumnValues);
var i: Integer;
begin
  for i:= Low(cv) to High(cv) do Inc(cv[i],Increment[i]);
end;


function ParseExpression(AExpression: string): variant;
var i,c: Integer;
begin
  AExpression:= Trim(AExpression);
  Result:= Null;
  if AExpression = '' then Exit;
  c:= 0;
  for i:= 1 to Length(AExpression) do if AExpression[i] = '+' then Inc(c);
  Result:= VarArrayCreate([0, c], varInteger);
  i:= 0;
  while AExpression <> '' do begin
    c:= Pos('+', AExpression);
    if c = 0 then begin
      Result[i]:= StrToInt(AExpression);
      AExpression:= '';
    end else begin
      Result[i]:= StrToInt(Copy(AExpression, 1, c - 1));
      AExpression:= Copy(AExpression, c + 1, Length(AExpression) - c);
    end;
    Inc(i)
  end;
end;

procedure TdmMain.EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
begin
  if ScanInfo.DataSet = QDeps then begin
    QForm6.Close;
    GenerateForm6;
    qry2.Close;
    qry2.SQL.Text := 'SELECT * '+
      'FROM FORM6Tmp '+
      'WHERE CPROF_ID = 1000';
    qry2.Open;
    QForm6.Open;
  end;
end;

procedure TdmMain.Form6HdrQueryCalcFields(DataSet: TDataSet);
begin
  if qry2.FieldByName('COL_12').AsInteger = 0 then
    Form6HdrQueryPerc.Value := '0'
  else
    Form6HdrQueryPerc.Value := FloatToStr(Round(100*
      (1.0*(qry2.FieldByName('COL_1').AsInteger - qry2.FieldByName('COL_10').AsInteger)) /
        qry2.FieldByName('COL_12').AsInteger));
end;

procedure TdmMain.GenerateForm6;
var
  AIR_COL  : ColumnValues;
  NAVY_COL : ColumnValues;
  PROF_COL : ColumnValues;
  LRN_COL  : ColumnValues;

  procedure IncVal(ColumnNo: Integer);
  begin
    Inc(PROF_COL[ColumnNo]);
    if PersonQuery.FieldByName('CSOST').AsInteger = 1 then
      Inc(AIR_COL[ColumnNo]);
    if PersonQuery.FieldByName('CSOST').AsInteger = 2 then
      Inc(NAVY_COL[ColumnNo]);
  end;

  procedure ProcessCPRof;
  var CPROF_ID: Integer;
    State: Integer;
    CurYear, BirthYear, Month, Day: Word;
    Age: Integer;
  begin
    CurYear := GetForm6Year;
    CPROF_ID:= PersonQuery.FieldByName('CPROF_ID').AsInteger;
    ClearValues(PROF_COL);
    while (not PersonQuery.EOF) and (CPROF_ID = PersonQuery.FieldByName('CPROF_ID').AsInteger) do begin
//      IncVal(1);
      if (PersonQuery.FieldByName('IS_WAR').AsInteger = 1) and
          not ((CPROF_ID = 500) and PersonQuery.FieldByName('IsIgnore').AsBoolean) then begin
        if KWRangeQuery.Locate('WRNG_ID', PersonQuery.FieldByName('WRNG_ID').AsInteger, []) then begin
          DecodeDate(PersonQuery.FieldByName('BIRTHDAY').AsDateTime, BirthYear, Month, Day);
          Age:= CurYear - BirthYear;
          State:= KWRangeQuery.FieldByName('STATE').AsInteger;
          if State = 0 then
            IncVal(11)
          else if ((PersonQuery.FieldByName('W_DEND').IsNull) or (PersonQuery.FieldByName('W_DEND').AsDateTime > Now)) and
             (((PersonQuery.FieldByName('MALE').AsInteger = 1) and
             ((KWRangeQuery.FieldByName('M_LIMIT').IsNull) or (Age <= KWRangeQuery.FieldByName('M_LIMIT').AsInteger)))
             or ((PersonQuery.FieldByName('MALE').AsInteger = 0) and
             ((KWRangeQuery.FieldByName('FEM_LIMIT').IsNull) or (Age <= KWRangeQuery.FieldByName('FEM_LIMIT').AsInteger)))) then begin
            IncVal(2);
            case State of
              3: IncVal(3);
              1,2: IncVal(4);
            end;
            if (State in [1,2]) and (PersonQuery.FieldByName('WCAT').AsString = 'В') then
              IncVal(5);
            if PersonQuery.FieldByName('WUCHET2_IsWork').AsInteger = 1 then begin
              IncVal(6);
              if State = 3 then IncVal(7);
              if State in [1,2] then begin
                IncVal(8);
              end;
            end else if PersonQuery.FieldByName('WUCHET1').AsString = '' then
              IncVal(9);
          end;
        end;
      end;
      PersonQuery.Next;
    end;
    PROF_COL[10] := PROF_COL[2] - PROF_COL[6] - PROF_COL[9];
    AIR_COL[10] := AIR_COL[2] - AIR_COL[6] - AIR_COL[9];
    NAVY_COL[10] := NAVY_COL[2] - NAVY_COL[6] - NAVY_COL[9];
    if CPROF_ID = 500 then begin
      if Form6Query.Locate('CPROF_ID', 281{Специалисты образования}, []) then begin
        GetColumnValues(LRN_COL);
        IncValues(LRN_COL, PROF_COL);
        SetColumnValues(LRN_COL);
      end;
    end else if Form6Query.Locate('CPROF_ID', CPROF_ID, []) then
      SetColumnValues(PROF_COL);
  end;

  procedure CalculateFormula(CPROF_ID: Integer);
  var
    bm: TBookmark;
    PROF_COL: ColumnValues;
    Expression: string;
    ParsedExpr: variant;
    p,c,i: Integer;
  begin
    ClearValues(PROF_COL);
    with Form6Query do begin
      bm:= GetBookmark;
      try
        Expression:= Trim(FieldByName('EXPRESSION').AsString);
        // set processing flag
        Edit;
        FieldByName('CALCULATE').AsInteger:= -1;
        Post;
        // calculate
        ParsedExpr:= ParseExpression(Expression);
        p:= 0;
        while not VarIsNull(ParsedExpr) and (p <= VarArrayHighBound(ParsedExpr, 1)) do begin
          c:= ParsedExpr[p];
          if Locate('CPROF_ID', c, []) then begin
            if (FieldByName('CALCULATE').AsInteger = -1) and (FieldByName('CPROF_ID').AsInteger <> CPROF_ID) then
              raise Exception.Create('Ошибка: циклические формулы!');
            if (Trim(FieldByName('EXPRESSION').AsString) <> '') and (FieldByName('CALCULATE').AsInteger = 0) then
              CalculateFormula(FieldByName('CPROF_ID').AsInteger);
            for i:= Low(PROF_COL) to High(PROF_COL) do
              Inc(PROF_COL[i], FieldByName('COL_' + IntToStr(i)).AsInteger);
          end;
          Inc(p);
        end;
        // store
        GotoBookmark(bm);
        SetColumnValues(PROF_COL);
        Edit;
        FieldByName('CALCULATE').AsInteger:= 1;
        Post;
      finally
        GotoBookmark(bm);
      end;
    end;
  end;

  procedure MoveNoBron;
  var  CV: ColumnValues;
  begin
    with Form6Query do begin
      if not Locate('COL_B',row_Itogo,[]) then Exit;
      GetColumnValues(CV);
      ClearForm6;
      if Locate('COL_B',row_NoBron,[]) then SetColumnValues(CV);
      if Locate('COL_B',row_Vsego,[]) then SetColumnValues(CV);
    end;
  end;

  procedure  Calc400;
  const
    Rows: array [1..3] of Integer = (400,410,420);
  var
    Row: Integer;
    CV400,CVTEMP: ColumnValues;
  begin
    ClearValues(CV400);
    with Form6Query do begin
      for Row := Low(Rows) to High(Rows) do begin
        Locate('CPROF_ID',  Rows[Row], []);
        GetColumnValues(CVTEMP); IncValues(CV400, CVTEMP);
      end;
      Locate('CPROF_ID',  400, []);
      SetColumnValues(CV400);
    end;
  end;
///////////////
begin
  Screen.Cursor:= crHourGlass;
  try
    Form6Query.Close;
    ClearQuery.ExecSQL;
    Form6Query.Open;
    // initialize
    KCProfQuery.Open;
    while not KCProfQuery.EOF do begin
      if KCProfQuery.FieldByName('CPROF_ID').AsInteger <> 500 then begin
        Form6Query.AppendRecord([
          KCProfQuery.FieldValues['CPROF_ID'],
          F6_ID,
          KCProfQuery.FieldValues['PRINT_NAME'],
          KCProfQuery.FieldValues['EXPRESSION'],
          0,
          KCProfQuery.FieldValues['LINE_NO']
          ]);
      end;
      KCProfQuery.Next;
    end;

    KCProfQuery.Close;
    // calculate profs
    PersonQuery.Close;
    PersonQuery.Parameters[0].Value := QDepsDep_Id.Value;
    PersonQuery.Open;
    KWRangeQuery.Open;
    ClearValues(AIR_COL);
    ClearValues(NAVY_COL);
    while not PersonQuery.EOF do begin
      ProcessCPRof;
    end;

    with Form6Query do begin
      First;
      while not EOF do begin
        StaffListQuery.Close;
        StaffListQuery.Parameters[0].Value := FieldByName('CPROF_ID').Value;
        StaffListQuery.Parameters[1].Value := QDepsDep_Id.Value;
        StaffListQuery.Open;
        Edit;
        FieldByName('COL_1').Value := NULLIF(StaffListQuery.Fields[0].Value,0);
        FieldByName('COL_12').Value := NULLIF(StaffListQuery.Fields[1].Value,0);
        Post;
        Next;
      end;
    end;
    StaffListQuery.Close;

    AIR_COL[1] := AIR_COL[2];
    if Form6Query.Locate('CPROF_ID', 495, []) then SetColumnValues(AIR_COL);
    NAVY_COL[1] := NAVY_COL[2];
    if Form6Query.Locate('CPROF_ID', 496, []) then SetColumnValues(NAVY_COL);

    KWRangeQuery.Close;
    PersonQuery.Close;
    // calculate formulas
    Calc400;
     with Form6Query do begin
      First;
      while not EOF do begin
        if (Trim(FieldByName('EXPRESSION').AsString) <> '') and (FieldByName('CALCULATE').AsInteger = 0) then
          CalculateFormula(FieldByName('CPROF_ID').AsInteger);
        Next;
      end;
    end;

    ORGQuery.Open;
    if NoBronMode then MoveNoBron;
    ORGQuery.Close;

    Form6Query.First;
  finally
    Screen.Cursor:= crDefault;
  end;
end;

procedure TdmMain.Init;
begin
  qry2 := TADOQuery.Create(Self);
  qry2.Connection := dmMain.dbMain;
  qry2.SQL.Text := 'SELECT * '+
    'FROM FORM6 '+
    'WHERE F6_ID = '+IntToStr(F6_ID)+' and CPROF_ID = 1000';
  qry2.Open;

  Form6HdrQuery.Parameters.ParamValues['F6_ID']:= F6_ID;
  ReportQuery.Parameters.ParamValues['F6_ID']:= F6_ID;
  Form6HdrQuery.Open;
end;




procedure TdmMain.PrintActionExecute(Sender: TObject);
var OrgID: String; //for SaveEvent
begin
  {if not Boolean(dmMain.Form6HdrQuery.FieldByName('CHECKED').Value) and
     not Confirm('Форма не проверена! Игнорировать?')
  then
    Exit;}
  ORGQuery.Open;
  NoBronMode := not ORGQuery.FieldByName('HAS_BRON').AsBoolean;
  ORGQuery.Close;
  if NoBronMode then begin
    ShowErr('Ваша организация не ведет бронирование. Обращение к данной форме не правомерно.');
    Exit;
  end;
  try
    try
      dmMain.ReportQuery.Open;
      dmMain.QDeps.Open;
      dmMain.EkRTF1.ClearVars;
      qry := TADOQuery.Create(Self);
      with qry do
      try
        Connection := dmMain.dbMain;
        SQL.Text := 'select * from ORG_CONT where IS_GEN<>0';
        Open;
        if IsEmpty then begin
          OrgID := '-1';
          dmMain.EkRTF1.CreateVar('GenPOST','Руководитель');
          dmMain.EkRTF1.CreateVar('GenIOFam','И.О. Фамилия');
        end
        else begin
          OrgID := FieldByName('ORGID').AsString;
          dmMain.EkRTF1.CreateVar('GenPOST',FieldByName('POST').AsString);
          dmMain.EkRTF1.CreateVar('GenIOFam',
              (FieldByName('IM').AsString+' ')[1]+'.'+
              (FieldByName('OTCH').AsString+' ')[1]+'. '+
              FieldByName('FAM').AsString);
        end;
        Close;

        dmMain.EkRTF1.CreateVar('Year',GetForm6Year);
        dmMain.EkRTF1.CreateVar('CurDate',SysUtils.FormatDateTime('dd.mm.yyyy', Date));
      finally
        Free;
      end;
      dmMain.EkRTF1.ExecuteOpen(
        [dmMain.ReportQuery, dmMain.Form6HdrQuery, dmMain.QDeps, dmMain.QForm6], SW_SHOWDEFAULT);
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,
        ['Номер организации: '+OrgID]);
    finally
      dmMain.ReportQuery.Close;
      dmMain.QDeps.Close;
    end;
  except on e:Exception do begin
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...'#13+e.Message);
  end;
  end;
end;

procedure TdmMain.QDepsBeforeOpen(DataSet: TDataSet);
begin
  if GetParamValue(6) = '1' then
    QDeps.SQL[QDeps.SQL.Count-1] := 'Order By Dep_Name'
  else
    QDeps.SQL[QDeps.SQL.Count-1] := 'Order By KDepart_Num';
end;

procedure TdmMain.QDepsCalcFields(DataSet: TDataSet);
begin
  if QDepsDep_Full_Name.AsString = '' then
    QDepsOrgName.AsString := QDepsDep_Name.AsString
  else
    QDepsOrgName.AsString := QDepsDep_Full_Name.AsString;
end;

procedure TdmMain.QForm6CalcFields(DataSet: TDataSet);
var perc: double;
begin
  QForm6Col_1_10.AsInteger := QForm6Col_1.AsInteger - QForm6Col_10.AsInteger;
  QForm6Col_1_10_12.AsInteger := QForm6Col_1_10.AsInteger - QForm6Col_12.AsInteger;

    if QForm6COL_12.AsInteger = 0 then
      QForm6Perc.AsString := '0'
    else begin
      perc := 100*
        (1.0*(QForm6COL_1.AsInteger - QForm6COL_10.AsInteger)) /
          QForm6COL_12.AsInteger;
      if perc > 100 then perc := 100.0;
      QForm6Perc.AsString := FloatToStr(Round(perc));
    end;
    if QForm6COL_2.AsInteger = 0 then
      QForm6Perc5.AsString := '0'
    else
      QForm6Perc5.AsString := FloatToStr(Round(100*
        (1.0*QForm6COL_6.AsInteger) /
          QForm6COL_2.AsInteger));
end;

procedure TdmMain.ReportQueryCalcFields(DataSet: TDataSet);
var perc: double;
begin
  ReportQueryCol_1_10.AsInteger := ReportQueryCol_1.AsInteger - ReportQueryCol_10.AsInteger;
  ReportQueryCol_1_10_12.AsInteger := ReportQueryCol_1_10.AsInteger - ReportQueryCol_12.AsInteger;

    if ReportQueryCOL_12.AsInteger = 0 then
      ReportQueryPerc.AsString := '0'
    else
      ReportQueryPerc.AsString := FloatToStr(Round(100*
        (1.0*(ReportQueryCOL_1.AsInteger - ReportQueryCOL_10.AsInteger)) /
          ReportQueryCOL_12.AsInteger));
    if ReportQueryCOL_2.AsInteger = 0 then
      ReportQueryPerc5.AsString := '0'
    else begin
      perc := 100*
        (1.0*ReportQueryCOL_6.AsInteger) /
          ReportQueryCOL_2.AsInteger;
      if perc > 100 then perc := 100.0;
      ReportQueryPerc5.AsString := FloatToStr(Round(perc));
    end;

end;

procedure TdmMain.SetColumnValues(cv: ColumnValues);
var i: Integer;
begin
  Form6Query.Edit;
  for i:= Low(cv) to High(cv) do  SetColumnValue('COL_' + IntToStr(i), cv[i]);
  Form6Query.Post;
end;


procedure TdmMain.SetColumnValue(AColumnName: string; Value: Integer);
begin
  if Value <> 0 then Form6Query.FieldByName(AColumnName).AsInteger:= Value
  else Form6Query.FieldByName(AColumnName).Clear;
end;

procedure TdmMain.GetColumnValues(out cv: ColumnValues);
var i: Integer;
begin
  for i:= Low(cv) to High(cv) do
    cv[i] := GetColumnValue('COL_' + IntToStr(i));
end;

function TdmMain.GetColumnValue(AColumnName: string): Integer;
begin
  Result := Form6Query.FieldByName(AColumnName).AsInteger;
end;

procedure TdmMain.ClearForm6;
begin
  with TADOQuery.Create(nil) do
  try
    Connection := dbMain; ParamCheck := False;
    SQL.Text := 'UPDATE FORM6Tmp SET '+
                'COL_1=NULL,'+
                'COL_2=NULL,'+
                'COL_3=NULL,'+
                'COL_4=NULL,'+
                'COL_5=NULL,'+
                'COL_6=NULL,'+
                'COL_7=NULL,'+
                'COL_8=NULL,'+
                'COL_9=NULL,'+
                'COL_10=NULL,'+
                'COL_11=NULL,'+
                'COL_12=NULL,'+
                'COL_13=NULL,'+
                'COL_14=NULL,'+
                'COL_15=NULL,'+
                'COL_16=NULL,'+
                'COL_12T=NULL';
    ExecSQL;
  finally Free;
  end;
  Form6Query.Requery;
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

end.


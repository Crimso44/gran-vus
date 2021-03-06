unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, Variants;

type
  ColumnValues = array[1..15] of Integer;

  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    PersonQuery: TADOQuery;
    KWRangeQuery: TADOQuery;
    KCProfQuery: TADOQuery;
    ClearQuery: TADOQuery;
    EkRTF1: TEkRTF;
    Form6HdrQuery: TADOQuery;
    ImageList: TImageList;
    Form6Query: TADOQuery;
    ReportQuery: TADOQuery;
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
    StaffListQuery: TADOQuery;
    OrgQuery: TADOQuery;
    Form6QueryCOL_10T: TWideStringField;
    Form6QueryCOL_12T: TWideStringField;
    ReportQueryCOL_10T: TWideStringField;
    ReportQueryCOL_12T: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure Form6QueryCalcFields(DataSet: TDataSet);
    procedure ReportQueryCalcFields(DataSet: TDataSet);
  private
  public
    F6_ID: Integer;
    NoBronMode: Boolean;
    procedure Init;
    procedure ClearForm6;
    procedure GenerateForm6;
    procedure RecalcUp;
    function GetColumnValue(AColumnName: string): Integer;
    procedure SetColumnValue(AColumnName: string; Value: Integer);
    procedure GetColumnValues(out cv: ColumnValues);
    procedure SetColumnValues(cv: ColumnValues);
  end;

  function ISNULL(v: variant; rv: variant) : variant;
  function ParseExpression(AExpression: string): variant;
  procedure ClearValues(var cv: ColumnValues);

var
  dmMain: TdmMain;
  FPrintOnly: Boolean;

const
  sEventObject = '????? ?6 (2014?.)';

implementation

uses IniSupport;

{$R *.DFM}

{ TdmMain }

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'form6.rtf';
  EkRTF1.Outfile := GetReportsDir + '????? 6 (2014?).rtf';
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

function TdmMain.GetColumnValue(AColumnName: string): Integer;
begin
  Result := Form6Query.FieldByName(AColumnName).AsInteger;
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

procedure TdmMain.SetColumnValues(cv: ColumnValues);
var i: Integer;
begin
  Form6Query.Edit;
  for i:= Low(cv) to High(cv) do  SetColumnValue('COL_' + IntToStr(i), cv[i]);
  Form6Query.Post;
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
            if (State in [1,2]) and (PersonQuery.FieldByName('WCAT').AsString = '?') then
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
      if Form6Query.Locate('CPROF_ID', 281{??????????? ???????????}, []) then begin
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
              raise Exception.Create('??????: ??????????? ???????!');
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
      if not Locate('COL_B',22,[]) then Exit;
      GetColumnValues(CV);
      ClearForm6;
      if Locate('COL_B',23,[]) then SetColumnValues(CV);
      if Locate('COL_B',24,[]) then SetColumnValues(CV);
    end;
  end;

  procedure  Calc200;
  const
    Rows: array [1..10] of Integer = (200,210,221,231,241,251,271,281,291,295);
  var
    Row: Integer;
    CV200,CVTEMP: ColumnValues;
  begin
    ClearValues(CV200);
    with Form6Query do begin
      for Row := Low(Rows) to High(Rows) do begin
        Locate('CPROF_ID',  Rows[Row], []);
        GetColumnValues(CVTEMP); IncValues(CV200, CVTEMP);
      end;
      Locate('CPROF_ID',  200, []);
      SetColumnValues(CV200);
    end;
  end;
///////////////
begin
  Screen.Cursor:= crHourGlass;
  try
    Form6Query.Close;
    ClearQuery.ExecSQL;
    with TADOQuery.Create(nil) do
    try
      Connection := dbMain; ParamCheck := False;
      SQL.Text := 'UPDATE FORM6HDR SET Checked = 0';
      ExecSQL;
    finally Free;
    end;
    Form6HdrQuery.Requery;
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
    Calc200;
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
  ORGQuery.Open;
  NoBronMode := not ORGQuery.FieldByName('HAS_BRON').AsBoolean;
  ORGQuery.Close;

  Form6HdrQuery.Parameters.ParamValues['F6_ID']:= F6_ID;
  ClearQuery.Parameters.ParamValues['F6_ID']:= F6_ID;
  Form6Query.Parameters.ParamValues['F6_ID']:= F6_ID;
  ReportQuery.Parameters.ParamValues['F6_ID']:= F6_ID;
  Form6HdrQuery.Open;
  PersonQuery.Parameters.ParamValues['ORG_ID']:= Form6HdrQuery.FieldByName('ORGID').AsInteger;
  Form6HdrQuery.Close;
end;

procedure TdmMain.RecalcUp;
var lst_lock: TStringList;
  procedure CalcRow(CPROF_ID: Integer);
  var rows: TStringList;
      n,i: Integer;
      fCalcCols: boolean;
      cols: ColumnValues;
  begin
    if not Form6Query.Locate('CPROF_ID',CPROF_ID,[]) then
      raise Exception.Create('?? ??????? ?????? ? CPROF_ID='+IntToStr(CPROF_ID)+'.'#13+
                             '?????? ????? 6 ???????????...');
//check lock-flag
    if lst_lock.IndexOf(IntToStr(CPROF_ID))>=0 then
      raise Exception.Create('??????????? ?????? ?? ?????? ? CPROF_ID='+IntToStr(CPROF_ID)+'.'#13+
                             '????????????? ????????? ????????? ???????????...');
    lst_lock.Add(IntToStr(CPROF_ID));
    try
      if not KCProfQuery.Locate('CPROF_ID',CPROF_ID,[]) then
        raise Exception.Create('?? ??????? ?????? ? CPROF_ID='+IntToStr(CPROF_ID)+'.'#13+
                               '????????????? ????????? ????????? ???????????...');
      rows := TStringList.Create;
      try
        for i:=Low(cols) to High(cols) do cols[i] := 0;
        fCalcCols := true;
        rows.CommaText := StringReplace(KCProfQuery.FieldByName('EXPRESSION').AsString,'+',',',[rfReplaceAll]);
        for n:=0 to rows.Count-1 do begin
          if StrToInt(rows[n])<>CPROF_ID then begin
            CalcRow(StrToInt(rows[n]));
            Form6Query.Locate('CPROF_ID',StrToInt(rows[n]),[]);
            for i:=Low(cols) to High(cols) do
              cols[i] := cols[i] + Form6Query.FieldByName('COL_'+IntToStr(i)).AsInteger;
            fCalcCols := false;
          end;
        end;
//???? ???? ????????? ? ??????, ?? ????? ?? ?????
        if rows.IndexOf(IntToStr(CPROF_ID))>=0 then fCalcCols := true;
        Form6Query.Locate('CPROF_ID',CPROF_ID,[]);
        if fCalcCols then begin
          for i:=Low(cols) to High(cols) do
            cols[i] := Form6Query.FieldByName('COL_'+IntToStr(i)).AsInteger;
          cols[2] := cols[3]+cols[4];
          cols[6] := cols[7]+cols[8];
          cols[9] := cols[2]-cols[6]-cols[10];
//          cols[1] := cols[2]+cols[11]; - ?? ?????
        end;
        SetColumnValues(cols);
      finally
        rows.Free;
      end;
    finally
      n := lst_lock.IndexOf(IntToStr(CPROF_ID));
      if n>=0 then lst_lock.Delete(n);
    end;
  end;
begin
  lst_lock := TStringList.Create;
  lst_lock.Clear;
  if not KCProfQuery.Active then KCProfQuery.Open;
  try
    Form6Query.CheckBrowseMode;
    CalcRow(200);
    CalcRow(495);
    CalcRow(496);
    CalcRow(2000);
    Form6Query.First;
  finally
    KCProfQuery.Close;
    lst_lock.Free;
  end;
end;

procedure TdmMain.Form6QueryCalcFields(DataSet: TDataSet);
begin
  {Form6Query.FieldByName('COL_10').Value :=
     NULLIF(Form6QueryCOL_2.AsInteger
            - Form6QueryCOL_6.AsInteger
            - Form6QueryCOL_9.AsInteger,0);}
end;

procedure TdmMain.ReportQueryCalcFields(DataSet: TDataSet);
begin
  {ReportQuery.FieldByName('COL_10').Value :=
     NULLIF(ReportQueryCOL_2.AsInteger
            - ReportQueryCOL_6.AsInteger
            - ReportQueryCOL_9.AsInteger,0);}
end;

procedure TdmMain.ClearForm6;
begin
  with TADOQuery.Create(nil) do
  try
    Connection := dbMain; ParamCheck := False;
    SQL.Text := 'UPDATE FORM6HDR SET Checked = 0';
    ExecSQL;
    SQL.Text := 'UPDATE FORM6 SET '+
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
  Form6HdrQuery.Requery;
  Form6Query.Requery;
end;

end.


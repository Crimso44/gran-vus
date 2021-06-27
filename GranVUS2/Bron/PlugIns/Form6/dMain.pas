unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, Variants;

const
  row_Itogo = 5;
  {row_NoBron = 6;
  row_Vsego = 7;}

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    Form6HdrQuery: TADOQuery;
    ImageList: TImageList;
    ReportQuery: TADOQuery;
    ReportQueryCPROF_ID: TIntegerField;
    ReportQueryF6_ID: TIntegerField;
    ReportQueryPRINT_NAME: TStringField;
    ReportQueryEXPRESSION: TStringField;
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
    ReportQueryCOL_16: TStringField;
    ReportQueryCOL_17: TIntegerField;
    ReportQueryCOL_10T: TStringField;
    ReportQueryCOL_12T: TStringField;
    Form6Query: TADOQuery;
    Form6QueryCPROF_ID: TIntegerField;
    Form6QueryF6_ID: TIntegerField;
    Form6QueryPRINT_NAME: TStringField;
    Form6QueryEXPRESSION: TStringField;
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
    Form6QueryCOL_16: TStringField;
    Form6QueryCOL_17: TIntegerField;
    Form6QueryCOL_10T: TStringField;
    Form6QueryCOL_12T: TStringField;
    KCProfQuery: TADOQuery;
    KWRangeQuery: TADOQuery;
    ClearQuery: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure Form6QueryCalcFields(DataSet: TDataSet);
    procedure ReportQueryCalcFields(DataSet: TDataSet);
    procedure Form6QueryFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure Form6QueryBeforePost(DataSet: TDataSet);
  private
  public
    F6_ID: Integer;
    ORG_ID: Integer;
    SUBJ_ID: Integer;
    Svod, isF5: Boolean;
    procedure Init;
    procedure RecalcUp;
    procedure SetColumnValue(AColumnName: string; Value: Integer);
  end;

  ColumnValues = array[1..11{15}] of Integer;

  function ISNULL(v: variant; rv: variant) : variant;
  function ParseExpression(AExpression: string): variant;
  procedure ClearValues(var cv: ColumnValues);

var
  dmMain: TdmMain;
  FPrintOnly: Boolean;
  FKADRY: Boolean;

const
  sEventObject = 'Форма №6';

implementation

uses IniSupport;

{$R *.DFM}

{ TdmMain }

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
end;

function ISNULL(v: variant; rv: variant) : variant;
begin
  if VarIsNull(v) then Result:=rv else Result:=v;
end;

procedure ClearValues(var cv: ColumnValues);
var i: Integer;
begin
  for i:= Low(cv) to High(cv) do cv[i]:= 0;
end;

procedure TdmMain.SetColumnValue(AColumnName: string; Value: Integer);
begin
  if Value <> 0 then Form6Query.FieldByName(AColumnName).AsInteger:= Value
  else Form6Query.FieldByName(AColumnName).Clear;
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

procedure TdmMain.Init;
begin
  Form6HdrQuery.Parameters.ParamValues['F6_ID']:= F6_ID;
  ClearQuery.Parameters.ParamValues['F6_ID']:= F6_ID;
  Form6Query.Parameters.ParamValues['F6_ID']:= F6_ID;
  ReportQuery.Parameters.ParamValues['F6_ID']:= F6_ID;
end;

procedure TdmMain.RecalcUp;
var lst_lock: TStringList;
  procedure CalcRow(CPROF_ID: Integer);
  var rows: TStringList;
      n,i: Integer;
      fCalcCols: boolean;
      cols: Array[1..15] of Integer;
  begin
    if not Form6Query.Locate('CPROF_ID',CPROF_ID,[]) then
      raise Exception.Create('Не найдена строка с CPROF_ID='+IntToStr(CPROF_ID)+'.'#13+
                             'Строки формы 6 некорректны...');
//check lock-flag
    if lst_lock.IndexOf(IntToStr(CPROF_ID))>=0 then
      raise Exception.Create('Циклическая ссылка на строку с CPROF_ID='+IntToStr(CPROF_ID)+'.'#13+
                             'Классификатор категорий профессий некорректен...');
    lst_lock.Add(IntToStr(CPROF_ID));
    try
      if not KCProfQuery.Locate('CPROF_ID',CPROF_ID,[]) then
        raise Exception.Create('Не найдена строка с CPROF_ID='+IntToStr(CPROF_ID)+'.'#13+
                               'Классификатор категорий профессий некорректен...');
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
//если сами находимся в списке, то сумму не берем
        if rows.IndexOf(IntToStr(CPROF_ID))>=0 then fCalcCols := true;
        Form6Query.Locate('CPROF_ID',CPROF_ID,[]);
        if fCalcCols then begin
          for i:=Low(cols) to High(cols) do
            cols[i] := Form6Query.FieldByName('COL_'+IntToStr(i)).AsInteger;
          cols[2] := cols[3]+cols[4];
          cols[6] := cols[7]+cols[8];
          cols[9] := cols[2]-cols[6]-cols[10];
//          cols[1] := cols[2]+cols[15]; - не трэба
        end;
        Form6Query.Edit;
        for i:=Low(cols) to High(cols) do
          if cols[i]=0 then
            Form6Query.FieldByName('COL_'+IntToStr(i)).Value := NULL
          else
            Form6Query.FieldByName('COL_'+IntToStr(i)).Value := cols[i];
        Form6Query.Post;
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
    CalcRow(400);
    CalcRow(1000);
    Form6Query.First;
  finally
    KCProfQuery.Close;
    lst_lock.Free;
  end;
end;

function NULLIF(Value1,Value2: Variant): Variant;
begin
  if Value1=Value2 then Result := NULL else Result := Value1;
end;

procedure TdmMain.Form6QueryBeforePost(DataSet: TDataSet);
var
  i: Integer;
begin
  for i := 0 to Form6Query.Fields.Count - 1 do begin
    if Form6Query.Fields[i].DataType = ftInteger then
      if Form6Query.Fields[i].AsInteger < 0 then Form6Query.Fields[i].AsInteger := 0;
  end;
end;

procedure TdmMain.Form6QueryCalcFields(DataSet: TDataSet);
begin
  Form6Query.FieldByName('COL_17').Value :=
     NULLIF(Form6QueryCOL_2.AsInteger
            - Form6QueryCOL_7.AsInteger
            - Form6QueryCOL_14.AsInteger,0);
end;

procedure TdmMain.ReportQueryCalcFields(DataSet: TDataSet);
begin
  ReportQuery.FieldByName('COL_17').Value :=
     NULLIF(ReportQueryCOL_2.AsInteger
            - ReportQueryCOL_7.AsInteger
            - ReportQueryCOL_14.AsInteger,0);
end;

procedure TdmMain.Form6QueryFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := not Form6QueryCOL_B.IsNull;
end;

end.


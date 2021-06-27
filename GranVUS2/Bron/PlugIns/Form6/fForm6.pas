unit fForm6;

interface

uses
  fGetType,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxTL, dxDBCtrl, dxDBGrid, Db, ADODB, dMain, ActnList,  Menus, rdialogs, ComCtrls, ToolWin,
  StdCtrls, dxExEdtr, Variants;

type
  TForm6List = class(TForm)
    dxDBGrid: TdxDBGrid;
    Form6DataSource: TDataSource;
    PRINT_NAMEColumn: TdxDBGridColumn;
    COL_BColumn: TdxDBGridColumn;
    COL_1Column: TdxDBGridColumn;
    COL_2Column: TdxDBGridColumn;
    COL_3Column: TdxDBGridColumn;
    COL_4Column: TdxDBGridColumn;
    COL_5Column: TdxDBGridColumn;
    COL_6Column: TdxDBGridColumn;
    COL_7Column: TdxDBGridColumn;
    COL_8Column: TdxDBGridColumn;
    COL_9Column: TdxDBGridColumn;
    COL_10Column: TdxDBGridColumn;
    COL_11Column: TdxDBGridColumn;
    COL_12Column: TdxDBGridColumn;
    COL_13Column: TdxDBGridColumn;
    COL_14Column: TdxDBGridColumn;
    COL_15Column: TdxDBGridColumn;
    COL_16Column: TdxDBGridColumn;
    ActionList: TActionList;
    PrintAction: TAction;
    PopupMenu1: TPopupMenu;
    N2: TMenuItem;
    CheckAction: TAction;
    N3: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    StatusBar1: TStatusBar;
    tbCalcMode: TToolButton;
    PopupMenu2: TPopupMenu;
    miRecalcCols: TMenuItem;
    miRecalcRows: TMenuItem;
    COL_EXPRColumn: TdxDBGridColumn;
    COL_CPROF_ID: TdxDBGridColumn;
    CalcUpAction: TAction;
    ToolButton6: TToolButton;
    COL_17Column: TdxDBGridColumn;
    FastModeAction: TAction;
    ToolButton1: TToolButton;
    N1: TMenuItem;
    ToolButton5: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    COL_10T: TdxDBGridColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PrintActionExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dxDBGridEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure CheckActionExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure miRecalcRowsClick(Sender: TObject);
    procedure dxDBGridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure dxDBGridEditing(Sender: TObject; Node: TdxTreeListNode;
      var Allow: Boolean);
    procedure CalcUpActionExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FastModeActionExecute(Sender: TObject);
  private
    ColCaps: TStringList;
    function CheckRow: Integer;
    function CheckColumns: Integer;
    function CheckColumn: Integer;
    procedure UpdateStatusBar;
    procedure UpdateTotals;
    procedure SetFastMode;
    function CanEditCell(ANode: TdxTreeListNode; AColumn: TdxDBGridColumn): boolean;
  public
    HasBron: Boolean;
  end;

var
  Form6List: TForm6List;

implementation

{$R *.DFM}

uses SaveEvents, IniSupport, Msg, DateUtils, StrUtils, WinHelpViewer;

const
  sOnOff: array [Boolean] of String = ('выкл.','вкл.');

function IntToStrSign(n: Integer): string;
begin
  Result := IntToStr(n);
  if n>0 then Result := '+'+Result;
end;

procedure TForm6List.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetForm6Recalc(miRecalcCols.Checked,miRecalcRows.Checked);
  SetForm6FastMode(FastModeAction.Checked);
  FreeAndNil(ColCaps);
  FreeAndNil(dxDBGrid);
  Action:= caFree;
end;

procedure TForm6List.PrintActionExecute(Sender: TObject);
var OrgID, SubjID: String; //for SaveEvent and GetReportDate
//
  function GetReportDate: String;
  var
    y: Integer;
    AfterNY: Boolean;
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;
      if dmMain.ORG_ID=0  then begin
        SQL.Text := 'select * from curr_subj';
        Open;
        if Fields[0].AsString = SubjID
          then AfterNY := GetMainVUOAfterNY
          else AfterNY := GetVUOAfterNY;
        Close;
        SQL.Text := 'SELECT REPORT_DATE FROM SUBJ WHERE SUBJ_ID='+SubjID
      end
      else begin
        AfterNY := GetAfterNY;
        SQL.Text := 'SELECT LAST_DATE FROM V_ORG WHERE ORGID='+OrgID;
      end;
      Open;
      Y := YearOf(Fields[0].AsDateTime);
      if Fields[0].IsNull
        then Result := ''
        else Result := IntToStr(Y-Byte(AfterNY));
    finally Free;
    end;
  end;
//
  type TPerson = record Post, FIO: String end;
  function GetPerson: TPerson;
  var I,O: Integer;
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;
      if dmMain.ORG_ID=0
        then SQL.Text := 'SELECT POSITION_NAME, FIO FROM SUBJ_INFO WHERE SUBJ_INFO_ID = 1 and SUBJ_ID='+SubjID
        else SQL.Text := 'SELECT POST, FIO FROM ORG_CONT WHERE IS_GEN = 1 and ORGID='+OrgID;
      Open;
      with Result do begin
        POST := Fields[0].AsString;
        FIO := Fields[1].AsString;
        I := Pos(' ',FIO);
        if I>0 then O := PosEx(' ',FIO,I+1) else O := 0;
        if (O>0) and (O<Length(FIO)) then
          FIO := LeftStr(FIO, I+1)+'.'+FIO[O+1]+'.';
      end;
    finally Free;
    end;
  end;
//
const
  AnInFile: array[1..3] of String = ('form6.rtf','form6VUO.rtf','form5.rtf');
  AnOutFile: array[1..3] of String = ('Форма 6.rtf','Форма 6 ВУО.rtf','Форма 5 ВУО.rtf');
var
  s: String;
  f: TfrmGetType;
  res: Integer;
  all: Boolean;
  i: Integer;
begin
  OrgID  := IntToStr(dmMain.ORG_ID);
  SubjID := IntToStr(dmMain.SUBJ_ID);
  if not Boolean(dmMain.Form6HdrQuery.FieldByName('CHECKED').Value) and
     not Confirm('Форма не проверена! Игнорировать?')
  then
    Exit;

  all := True;
  s := dmMain.Form6HdrQuery.FieldByName('F6_SHIFR').AsString;
  if (s = '03') or (s = '05') then begin
    f := TfrmGetType.Create(Self);
    res := f.ShowModal;
    f.Free;

    if res = mrYes then
      all := False
    else if res <> mrNo then
      Exit;
  end;

  dmMain.ReportQuery.Parameters[1].Value := all;

  try
    try
      dmMain.EkRTF1.CreateVar('REPORT_DATE', GetReportDate);
      dmMain.EkRTF1.CreateVar('Year', GetReportDate);
      with GetPerson do begin
        dmMain.EkRTF1.CreateVar('GenPOST', POST);
        dmMain.EkRTF1.CreateVar('GenIOFam', FIO);
      end;
      dmMain.ReportQuery.Parameters[2].Value := 1;
      if dmMain.Svod then
        dmMain.ReportQuery.Parameters[3].Value := 1
      else
        dmMain.ReportQuery.Parameters[3].Value := 0;
      dmMain.ReportQuery.Open;
      i := 1;
      if dmMain.ORG_ID=0 then i := 2;
      if dmMain.isF5 then i := 3;
      dmMain.EkRTF1.Infile := GetTemplatesDir + AnInFile[i];
      dmMain.EkRTF1.Outfile := GetReportsDir + AnOutFile[i];
      dmMain.EkRTF1.ExecuteOpen(
        [dmMain.ReportQuery, dmMain.Form6HdrQuery], SW_SHOWDEFAULT);
      if not not FKadry then
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,
        ['Номер организации: '+OrgID]);
    finally
      dmMain.ReportQuery.Close;
    end;
  except
    if not not FKadry then
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    RMessageDlg('Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...',
      mtError, [mbOk], 0);
  end;
end;

procedure TForm6List.FormCreate(Sender: TObject);
var I: Integer;
begin
  ColCaps := TStringList.Create;
  for I := 0 to dxDBGrid.ColumnCount-1 do with dxDBGrid.Columns[I] do
    ColCaps.AddObject(Caption, TObject(Width));
  FastModeAction.Checked := GetForm6fastMode;
  SetFastMode;
  with GetForm6Recalc do begin
    miRecalcCols.Checked := f6rCols;
    miRecalcRows.Checked := f6rRows;
  end;
  dmMain.Form6Query.Open;
  dmMain.Form6HdrQuery.Open;
  UpdateStatusBar;
end;

procedure ApplyRowDelta(Delta: Integer; ColumnName: string);
var ResultColumn: string;
begin
  if not Form6List.miRecalcCols.Checked then Exit;
  ResultColumn:= '';
  if (ColumnName = 'COL_3') or (ColumnName = 'COL_4') then
    ResultColumn:= 'COL_2'
  else if (ColumnName = 'COL_7') or (ColumnName = 'COL_8') then
    ResultColumn:= 'COL_6'
  {else if (ColumnName = 'COL_2') or (ColumnName = 'COL_11') then
    ResultColumn:= 'COL_1'};
  if ResultColumn <> '' then begin
    dmMain.SetColumnValue(ResultColumn, dmMain.Form6Query.FieldByName(ResultColumn).AsInteger + Delta);
    ApplyRowDelta(Delta, ResultColumn);
  end;
  {if (ColumnName = 'COL_6') or (ColumnName = 'COL_10') then begin
    dmMain.SetColumnValue('COL_9', dmMain.Form6Query.FieldByName('COL_9').AsInteger - Delta);
    ApplyRowDelta(-Delta, 'COL_9');
  end else if (ColumnName = 'COL_2') then begin
    dmMain.SetColumnValue('COL_9', dmMain.Form6Query.FieldByName('COL_9').AsInteger + Delta);
    ApplyRowDelta(Delta, 'COL_9');
  end;}
end;

procedure ApplyColumnDelta(Delta: Integer; ColumnName: string);
var
  bm: TBookMark;
  ParsedExpr: variant;
  CPROF_ID: Integer;
  i: Integer;
  AFound: Boolean;
begin
  if not Form6List.miRecalcRows.Checked then Exit;
  with dmMain.Form6Query do begin
    CPROF_ID:= FieldByName('CPROF_ID').AsInteger;
    DisableControls;
    bm:= GetBookmark;
    try
      First;
      while not EOF do begin
        if CPROF_ID <> FieldByName('CPROF_ID').AsInteger then begin
          ParsedExpr:= ParseExpression(FieldByName('EXPRESSION').AsString);
          if not VarIsNull(ParsedExpr) then begin
            AFound:= False;
            for i:= 0 to VarArrayHighBound(ParsedExpr, 1) do
              if ParsedExpr[i] = CPROF_ID then AFound:= True;
            if AFound then begin
              Edit;
              dmMain.SetColumnValue(ColumnName, dmMain.Form6Query.FieldByName(ColumnName).AsInteger + Delta);
              ApplyRowDelta(Delta, ColumnName);
              Post;
              ApplyColumnDelta(Delta, ColumnName);
            end;
          end;
        end;
        Next;
      end;
    finally
      GotoBookmark(bm);
      EnableControls;
    end;
  end;
end;

procedure TForm6List.dxDBGridEdited(Sender: TObject;
  Node: TdxTreeListNode);
var Delta: Integer;
    ColumnName: string;
    TopIndex: Integer;
begin
  with dmMain.Form6Query do begin
    if not Active then Exit;
    ColumnName:= dxDBGrid.Columns[dxDBGrid.FocusedAbsoluteIndex].FieldName;
    if FieldByName(ColumnName).DataType = ftString then Exit;
    Delta:= ISNULL(FieldByName(ColumnName).Value, 0) - ISNULL(FieldByName(ColumnName).CurValue, 0);
    if Delta <> 0 then begin
      TopIndex:= dxDBGrid.TopIndex;
      Edit;
      ApplyRowDelta(Delta, ColumnName);
      Post;
      ApplyColumnDelta(Delta, ColumnName);
      UpdateTotals;
      dmMain.Form6HdrQuery.Edit;
      dmMain.Form6HdrQuery.FieldByName('CHECKED').Value:= 0;
      dmMain.Form6HdrQuery.Post;
      UpdateStatusBar;
      dxDBGrid.TopIndex:= TopIndex;
    end;
  end;
end;

procedure TForm6List.CheckActionExecute(Sender: TObject);
var Checked: Boolean;
begin

  Checked := (CheckColumns=mrNone);
  if Checked then begin
    if not not FKadry then
    SaveEvent(dmMain.dbMain, evs_Form6_Check_Ok, '', []);
    RMessageDlg('Проверка закончена!', mtInformation, [mbOk], 0);
  end
  else
    if not not FKadry then
    SaveEvent(dmMain.dbMain, evs_Form6_Check_Failed, '', []);

  dmMain.Form6HdrQuery.Edit;
  dmMain.Form6HdrQuery.FieldByName('CHECKED').Value:= Byte(Checked);
  dmMain.Form6HdrQuery.Post;
  UpdateStatusBar;
end;

function TForm6List.CheckRow: Integer;
var n: Integer;
begin
  Result:= mrNone;
  with dmMain.Form6Query do begin
    // 2 = 3+4
    n := FieldByName('COL_2').AsInteger -
         (FieldByName('COL_3').AsInteger +
         FieldByName('COL_4').AsInteger);
    if n<>0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_2');
      if RMessageDlg(
                  'Сумма значений колонок 4 и 5 не равна значению колонки 3!'#13'Отклонение '+IntToStrSign(-n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;
    // 9 <= 2-6
    {n := FieldByName('COL_9').AsInteger -
         (FieldByName('COL_2').AsInteger - FieldByName('COL_6').AsInteger);
    if n>0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_2');
      if RMessageDlg(
                  'Значение колонки 9 больше разности значений колонок 2 и 6!'#13'Отклонение '+IntToStrSign(n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;}
    // 6 = 7+8
    n :=  FieldByName('COL_6').AsInteger -
         (FieldByName('COL_7').AsInteger +
         FieldByName('COL_8').AsInteger);
    if n<>0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_6');
      if RMessageDlg(
                  'Сумма значений колонок 7 и 8 не равна значению колонки 6!'#13'Отклонение '+IntToStrSign(-n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;
    // 4 >= 5
    n := FieldByName('COL_5').AsInteger -
         (FieldByName('COL_4').AsInteger);
    if n>0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_5');
      if RMessageDlg(
                  'Значение колонки 13 больше значения колонки 5!'#13'Отклонение '+IntToStrSign(n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;
    //1 >= 2+11
    n := FieldByName('COL_1').AsInteger -
         (FieldByName('COL_2').AsInteger +
         FieldByName('COL_11').AsInteger);
    if n<0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_1');
      if RMessageDlg(
                  'Сумма значений колонок 3 и 11 больше значения колонки 2!'#13'Отклонение '+IntToStrSign(-n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;
    // 2 = 6+9+10
    n := FieldByName('COL_2').AsInteger -
         (FieldByName('COL_6').AsInteger +
         //FieldByName('COL_9').AsInteger +
         FieldByName('COL_10').AsInteger);
    if n<0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_2');
      if RMessageDlg(
                  'Сумма значений колонок 6 и 10 больше значения колонки 3!'#13'Отклонение '+IntToStrSign(-n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;
    // 3 >= 7
    n := FieldByName('COL_3').AsInteger -
         (FieldByName('COL_7').AsInteger);
    if n<0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_3');
      if RMessageDlg(
                  'Значение колонки 4 меньше значения колонки 7!'#13'Отклонение '+IntToStrSign(n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;
    // 4 >= 8
    n := FieldByName('COL_4').AsInteger -
         FieldByName('COL_8').AsInteger;
    if n<0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_4');
      if RMessageDlg(
                  'Значение колонки 5 меньше значения колонки 8!'#13'Отклонение '+IntToStrSign(n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;
  end;
end;

function TForm6List.CheckColumn: Integer;
var
  ParsedExpr: variant;
  bm: TBookmark;
  PROF_COL: ColumnValues;
  CPROF_ID: Integer;
//  HasSelf: Boolean;
  i,j,n: Integer;
  Expr: String;
  Oper: (oEq,oGrEq,oLeEq);
begin
  Result:= mrNone;
  with dmMain.Form6Query do begin
    CPROF_ID := FieldByName('CPROF_ID').AsInteger;
    case CPROF_ID of
        400         : begin Expr := '410+420';             Oper := oEq; end;
        1000        : begin Expr := '100+200+300+400';     Oper := oEq; end;
        else begin
          Expr := FieldByName('EXPRESSION').AsString;
          Oper := oLeEq;
          if (CPROF_ID = 400) or (CPROF_ID = 1000) then Oper := oEq;
        end
    end;
    ClearValues(PROF_COL);
    if Expr <> '0' then begin
      ParsedExpr:= ParseExpression(Expr);  if VarIsNull(ParsedExpr) then Exit;
      DisableControls;
      try
        bm:= GetBookmark;
  //      HasSelf:= False;
        for i:= 0 to VarArrayHighBound(ParsedExpr, 1) do
          if CPROF_ID = ParsedExpr[i] then
  //          HasSelf:= True
          else begin
            if Locate('CPROF_ID', ParsedExpr[i], []) then
              for j:= Low(PROF_COL) to High(PROF_COL) do
                Inc(PROF_COL[j], FieldByName('COL_' + IntToStr(j)).AsInteger);
          end;
      finally
        GotoBookmark(bm);
        EnableControls;
      end;
    end;
    if (Expr <> '0') or not dmMain.Svod then begin
      for j:= Low(PROF_COL) to High(PROF_COL) do begin
        n := PROF_COL[j]-FieldByName('COL_' + IntToStr(j)).AsInteger;
        if ((Oper=oEq) and (n<>0)) or
           ((Oper=oGrEq) and (n>0)) or
           ((Oper=oLeEq) and (n<0))
        then begin
  //      if (HasSelf and (n>0)) or (not HasSelf and (n<>0)) then begin
  //      if (HasSelf and (PROF_COL[j] > FieldByName('COL_' + IntToStr(j)).AsInteger))
  //      or (not HasSelf and (PROF_COL[j] <> FieldByName('COL_' + IntToStr(j)).AsInteger)) then begin
          dxDBGrid.FocusedField:= FieldByName('COL_' + IntToStr(j));
          Result:= RMessageDlg('Значения в строке противоречат формуле!'#13'Отклонение '+IntToStrSign(-n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0);
          if Result = mrNo then Exit;
        end;
      end;
    end;
  end;
end;

function TForm6List.CheckColumns: Integer;
var Err: Boolean;
begin
  Result:= mrNone; Err := False;
  with dmMain.Form6Query do begin
    First;
    while not EOF do begin
      Result:= CheckRow;
      Err := Err or (Result<>mrNone);
      if Result = mrNo then Exit;
      Result:= CheckColumn;
      Err := Err or (Result<>mrNone);
      if Result = mrNo then Exit;
      Next;
    end;
    First;
  end;
  if Err then Result := mrIgnore;
end;

procedure TForm6List.UpdateStatusBar;
begin
  if not Boolean(dmMain.Form6HdrQuery.FieldByName('CHECKED').Value) then
    StatusBar1.SimpleText:= 'Форма не проверена'
  else StatusBar1.SimpleText:= 'Форма проверена';
end;

procedure TForm6List.UpdateTotals;
var bm: TBookmark;
begin
  with dmMain.Form6Query do begin
    DisableControls;
    try
      bm:= GetBookmark;
      dmMain.Form6HdrQuery.Edit;
      if Locate('CPROF_ID', 1000, []) then begin
        dmMain.Form6HdrQuery.FieldByName('RAB_COUNT').AsInteger:= FieldByName('COL_1').AsInteger;
        dmMain.Form6HdrQuery.FieldByName('ZAP_COUNT').AsInteger:= FieldByName('COL_2').AsInteger;
        dmMain.Form6HdrQuery.FieldByName('ZAB_COUNT').AsInteger:= FieldByName('COL_6').AsInteger;
      end else begin
        dmMain.Form6HdrQuery.FieldByName('RAB_COUNT').Clear;
        dmMain.Form6HdrQuery.FieldByName('ZAP_COUNT').Clear;
        dmMain.Form6HdrQuery.FieldByName('ZAB_COUNT').Clear;
      end;
      dmMain.Form6HdrQuery.FieldByName('CONFDATE').AsDateTime:= Date;
      dmMain.Form6HdrQuery.Post;
    finally
      GotoBookmark(bm);
      EnableControls;
    end;
  end;
end;

procedure TForm6List.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := Boolean(dmMain.Form6HdrQuery.FieldByName('CHECKED').Value) or
              Confirm('Форма не проверена! Игнорировать?');
end;

procedure TForm6List.miRecalcRowsClick(Sender: TObject);
begin
  if (Sender is TMenuItem) then
    (Sender as TMenuItem).Checked := not (Sender as TMenuItem).Checked;
  dxDBGrid.Repaint;
end;

function TForm6List.CanEditCell(ANode: TdxTreeListNode; AColumn: TdxDBGridColumn): boolean;
begin
  Result := //(ANode.Strings[COL_BColumn.Index]<>EmptyStr) and
    (not miRecalcCols.Checked or
     ((AColumn.FieldName<>'COL_2') and (AColumn.FieldName<>'COL_6') and (AColumn.FieldName<>'COL_9'))
    );
  if Result then
    {if (miRecalcRows.Checked and (ANode.Strings[col_BColumn.Index] = IntToStr(row_NoBron)) and not dmMain.Svod) then
      Result := False
    else begin}
      if miRecalcRows.Checked then begin
        Result := Trim(ANode.Strings[COL_EXPRColumn.Index])=EmptyStr;
      if not Result then
        Result := Pos(ANode.Strings[dxDBGrid.ColumnCount-1]+'+',ANode.Strings[dxDBGrid.ColumnCount-2])>0;
      end;
  //end;
  if Result and not HasBron then
    Result :=
     (AColumn.FieldName<>'COL_6') and (AColumn.FieldName<>'COL_7') and
     (AColumn.FieldName<>'COL_8') and (AColumn.FieldName<>'COL_12');
end;

procedure TForm6List.dxDBGridCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  ADone := false;
  if not ASelected then
     if not CanEditCell(ANode,AColumn as TdxDBGridColumn) then AColor := clBtnFace;
end;

procedure TForm6List.dxDBGridEditing(Sender: TObject;
  Node: TdxTreeListNode; var Allow: Boolean);
begin
  Allow := True; //Node.Strings[COL_BColumn.Index]<>EmptyStr;
  if Allow then
    Allow := CanEditCell(Node,dxDBGrid.Columns[dxDBGrid.FocusedColumn] as TdxDBGridColumn);
end;

procedure TForm6List.CalcUpActionExecute(Sender: TObject);
begin
  try
    dmMain.Form6Query.DisableControls;
    dmMain.RecalcUp;
  finally
    dmMain.Form6Query.EnableControls;
  end;
  UpdateTotals;
end;

procedure TForm6List.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

procedure TForm6List.FastModeActionExecute(Sender: TObject);
begin
  FastModeAction.Checked   := not FastModeAction.Checked;
  SetFastMode;
end;

procedure TForm6List.SetFastMode;
var I, j : Integer;
begin
  dmMain.Form6Query.Filtered := FastModeAction.Checked;
  dxDBGrid.ShowBands := not FastModeAction.Checked;
  if FastModeAction.Checked then begin
    PRINT_NAMEColumn.MinWidth := 0;
    PRINT_NAMEColumn.Width    := 0;
    dxDBGrid.OptionsBehavior  := dxDBGrid.OptionsBehavior
      + [edgoImmediateEditor,edgoEnterThrough];

    dxDBGrid.HeaderMinRowCount := 1;
    //Col_BColumn.Caption := '(Б)';
    for I := 0 to dxDBGrid.ColumnCount-1 do begin
      j := Pos('(', dxDBGrid.Columns[I].Caption);
      if j > 0 then begin
        dxDBGrid.Columns[I].Caption := Copy(dxDBGrid.Columns[I].Caption, j, MaxInt);
        dxDBGrid.Columns[I].Width := 40;
      end;
    end;
  end
  else begin
    dxDBGrid.OptionsBehavior :=   dxDBGrid.OptionsBehavior
      - [edgoImmediateEditor,edgoEnterThrough];
    dxDBGrid.HeaderMinRowCount := 9;
    for I := 0 to dxDBGrid.ColumnCount-1 do begin
      dxDBGrid.Columns[I].Caption := ColCaps[I];
      dxDBGrid.Columns[I].Width := Integer(ColCaps.Objects[I]);
    end;
  end;
end;

end.


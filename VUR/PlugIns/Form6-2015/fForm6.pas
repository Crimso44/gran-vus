unit fForm6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxTL, dxDBCtrl, dxDBGrid, Db, ADODB, dMain, ActnList,  Menus, rdialogs, ComCtrls, ToolWin,
  StdCtrls, dxExEdtr, Variants, ExtCtrls;

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
    COL_14Column: TdxDBGridColumn;
    COL_10Column: TdxDBGridColumn;
    ActionList: TActionList;
    GenerateAction: TAction;
    PrintAction: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    CheckAction: TAction;
    N3: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    StatusBar1: TStatusBar;
    ToolButton4: TToolButton;
    tbCalcMode: TToolButton;
    PopupMenu2: TPopupMenu;
    miRecalcCols: TMenuItem;
    miRecalcRows: TMenuItem;
    COL_EXPRColumn: TdxDBGridColumn;
    COL_CPROF_ID: TdxDBGridColumn;
    CalcUpAction: TAction;
    ToolButton6: TToolButton;
    COL_12Column: TdxDBGridColumn;
    ClearAction: TAction;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    edYear: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    COL_13Column: TdxDBGridColumn;
    procedure GenerateActionExecute(Sender: TObject);
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
    procedure ClearActionExecute(Sender: TObject);
  private
    function CheckRow: Integer;
    function CheckColumns: Integer;
    function CheckColumn: Integer;
    procedure UpdateStatusBar;
    procedure UpdateTotals;

    function CanEditCell(ANode: TdxTreeListNode; AColumn: TdxDBGridColumn): boolean;
  public
  end;

var
  Form6List: TForm6List;

implementation

{$R *.DFM}

uses SaveEvents, IniSupport, Msg, WinHelpViewer;

const
  sOnOff: array [Boolean] of String = ('выкл.','вкл.');

function IntToStrSign(n: Integer): string;
begin
  Result := IntToStr(n);
  if n>0 then Result := '+'+Result;
end;

procedure TForm6List.GenerateActionExecute(Sender: TObject);
var AYear: Integer;
  q: TAdoQuery;
begin
  q :=TADOQuery.Create(nil);
  try
    with q do begin
      Connection := dmMain.dbMain;
      ParamCheck := False;
      SQL.Text := 'SELECT Count(*) FROM PERS_SET';
      Open;
      if (Fields[0].AsInteger>0) and not Confirm(
          '   ВНИМАНИЕ! Расчёты будут строится на подмножестве '+
          'работников, ранее отобранном и сохранённом Вами для построения отчётов.'#13#13+
          '   Для перехода к построению отчётов на всех имеющихся в ПЭВМ данных '+
          'в картотеке работников выберите команду "Очистить набор".'#13#13+
          '   Продолжить работу с отобранным набором работников?')
      then
        Exit;
      Close;
    end;

    try
      AYear := GetForm6Year;
      if not InputQuery_Int('Расчёт формы №6','Расчётный год:', AYear, 2000, 2999) then Exit;
      SetForm6Year(AYear);
      edYear.Text := IntToStr(AYear);

      dmMain.Form6Query.Close;
      dmMain.Form6Query.DisableControls;
      dmMain.GenerateForm6;
      SaveEvent(dmMain.dbMain, evs_Form6_2015_Generate, '',
        ['Пересчет по столбцам: '+sOnOff[miRecalcCols.Checked],
         'Пересчет по строкам: '+sOnOff[miRecalcRows.Checked],
         'Расчётный год: '+IntToStr(AYear)]);
    finally
      dmMain.Form6Query.EnableControls;
      dmMain.Form6Query.Open;
    end;
    UpdateTotals;

    if dmMain.NoBronMode then begin
      q.SQL.Text := 'Select Col_6, Col_12 From Form6_2015 Where Cprof_Id = 1000';
      q.Open;
      if (q.Fields[0].AsInteger <> 0) or (q.Fields[1].AsInteger <> 0) then begin
        dmMain.ClearForm6;
        ShowInfo('ВНИМАНИЕ: База данных содержит противоречивые данные!'#13+
          'Согласно картотеке в организации имеются забронированные работники '+
          'и/или составлено штатное расписание на расчетный год. '+
          'Перед расчетом формы № 6  следует с помощью фильтра отобрать всех забронированных '+
          'работников, отменить в картотеке факт их бронирования и обнулить штатное расписание '+
          'на расчетный год.');
      end;
      q.Close;
    end;

  finally q.Free;
  end;
end;

procedure TForm6List.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetForm6Recalc(miRecalcCols.Checked,miRecalcRows.Checked);
  FreeAndNil(dxDBGrid);
  Action:= caFree;
end;

procedure TForm6List.PrintActionExecute(Sender: TObject);
var OrgID: String; //for SaveEvent
begin
  if not Boolean(dmMain.Form6HdrQuery.FieldByName('CHECKED').Value) and
     not Confirm('Форма не проверена! Игнорировать?')
  then
    Exit;
  dmMain.Form6Query.Locate('COL_B','7',[]);
  if (dmMain.Form6Query.FieldByName('COL_6').AsInteger > 300) and
     not Confirm(
       'При наличии в организации более 300 забронированых сотрудников '+
       'информация в Форме №6 носит закрытый характер!'#13#13+
       'Вы действительно хотите продолжить отправку Формы №6 в текстовый редактор?')
  then
    Exit;
  try
    try
      dmMain.ReportQuery.Parameters.ParamValues['HideDrivers']:= 1;
      dmMain.ReportQuery.Open;
      dmMain.EkRTF1.ClearVars;
      with TADOQuery.Create(Self) do
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
        dmMain.EkRTF1.CreateVar('Year',GetForm6Year);
      finally
        Free;
      end;
      dmMain.EkRTF1.ExecuteOpen(
        [dmMain.ReportQuery, dmMain.Form6HdrQuery], SW_SHOWDEFAULT);
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,
        ['Номер организации: '+OrgID]);
    finally
      dmMain.ReportQuery.Close;
    end;
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...');
  end;
end;

procedure TForm6List.FormCreate(Sender: TObject);
begin
  with GetForm6Recalc do begin
    miRecalcCols.Checked := f6rCols;
    miRecalcRows.Checked := f6rRows;
  end;
  edYear.Text := IntToStr(GetForm6Year);
  dmMain.Form6Query.Open;
  dmMain.Form6HdrQuery.Open;
  UpdateStatusBar;
  if not dmMain.Form6HdrQuery.FieldByName('ORGID').ISNULL then
    try
      dmMain.PersonQuery.Open;
      dmMain.PersonQuery.Close;
      GenerateAction.Visible:= True;
    except
      GenerateAction.Visible:= False;
    end
  else
    GenerateAction.Visible:= False;
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
  else if (ColumnName = 'COL_2') or (ColumnName = 'COL_11') then
    ResultColumn:= 'COL_1';
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
    if FieldByName(ColumnName).DataType in [ftString, ftWideString] then Exit;
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
var mr: Integer;
begin
  mr:= CheckColumns;
  if mr <> mrOk then begin
    SaveEvent(dmMain.dbMain, evs_Form6_2015_Check_Ok, '', []);
    ShowInfo('Проверка закончена!');
  end
  else
    SaveEvent(dmMain.dbMain, evs_Form6_2015_Check_Failed, '', []);

  dmMain.Form6HdrQuery.Edit;
  if mr <> mrOk then
    dmMain.Form6HdrQuery.FieldByName('CHECKED').Value:= 1
  else dmMain.Form6HdrQuery.FieldByName('CHECKED').Value:= 0;
  dmMain.Form6HdrQuery.Post;
  UpdateStatusBar;
end;

function TForm6List.CheckRow: Integer;
var n: Integer;
begin
  Result:= mrNone;
  with dmMain.Form6Query do begin
    //!2 = 3+4
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
    //!6 = 7+8
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
    //!1 >= 2+11
    n := FieldByName('COL_1').AsInteger -
         (FieldByName('COL_2').AsInteger +
         FieldByName('COL_11').AsInteger);
    if n<0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_1');
      if RMessageDlg(
                  'Сумма значений колонок 3 и 11 больше значения колонки 2!'#13'Отклонение '+IntToStrSign(-n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;
    //!2 = 6+9+10
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
    //!3 >= 7
    n := FieldByName('COL_3').AsInteger -
         (FieldByName('COL_7').AsInteger);
    if n<0 then begin
      dxDBGrid.FocusedField:= FieldByName('COL_3');
      if RMessageDlg(
                  'Значение колонки 4 меньше значения колонки 7!'#13'Отклонение '+IntToStrSign(n)+'.'#13'Продолжить проверку?', mtWarning, [mbYes, mbNo], 0) = mrNo
                    then begin Result := mrNo; Exit; end;
    end;
    //!4 >= 8
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
//  ParsedExpr:= ParseExpression(dmMain.Form6Query.FieldByName('EXPRESSION').AsString);
//  CPROF_ID:= dmMain.Form6Query.FieldByName('CPROF_ID').AsInteger;
//  if not VarIsNull(ParsedExpr) then with dmMain.Form6Query do begin
  with dmMain.Form6Query do begin
    CPROF_ID := FieldByName('CPROF_ID').AsInteger;

    {if dmMain.NoBronMode then begin
      Oper := oEq;
      if CPROF_ID <= 1000 then
        Expr := '0'
      else
        Expr := FieldByName('EXPRESSION').AsString;
    end else begin}
      case CPROF_ID of
        400         : begin Expr := '410+420';         Oper := oEq; end;
        1000        : begin Expr := '100+200+300+400'; Oper := oEq; end;
        else begin
          Expr := FieldByName('EXPRESSION').AsString;
          Oper := oLeEq;
          if (CPROF_ID = 400) or (CPROF_ID = 1000) then Oper := oEq;
        end
      end;
    //end;

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

function TForm6List.CheckColumns: Integer;
var Err: Boolean;
begin
  Err := False;
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
    Result:= mrNone;
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
        if GenerateAction.Visible then
          if FieldByName('COL_6').AsInteger>0 then begin
            dmMain.Form6HdrQuery.FieldByName('F6_COUNT').AsInteger := 1;
            dmMain.Form6HdrQuery.FieldByName('KUO_COUNT').Clear;
          end
          else begin
            dmMain.Form6HdrQuery.FieldByName('F6_COUNT').Clear;
            dmMain.Form6HdrQuery.FieldByName('KUO_COUNT').AsInteger := 1;
          end;
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
  Result := True; //ANode.Strings[COL_BColumn.Index]<>EmptyStr;
  if Result then
    if miRecalcCols.Checked then
      Result := (AColumn.FieldName<>'COL_2') and
                (AColumn.FieldName<>'COL_6');
  if Result then
    if miRecalcRows.Checked then begin
      Result := Trim(ANode.Strings[COL_EXPRColumn.Index{dxDBGrid.ColumnCount-2}])=EmptyStr;
    if not Result then
      Result := Pos(
        ANode.Strings[COL_CPROF_ID.Index{dxDBGrid.ColumnCount-1}]+'+',
        ANode.Strings[COL_EXPRColumn.Index{dxDBGrid.ColumnCount-2}])>0;
    end;
  {if Result then begin
    if dmMain.NoBronMode then
      Result := ANode.Strings[COL_BColumn.Index] = IntToStr(row_NoBron)
    else
      Result := ANode.Strings[COL_BColumn.Index] <> IntToStr(row_NoBron);
  end;}
  if Result and dmMain.NoBronMode then
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
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'granvus.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

procedure TForm6List.ClearActionExecute(Sender: TObject);
begin
  dmMain.ClearForm6;
end;

end.


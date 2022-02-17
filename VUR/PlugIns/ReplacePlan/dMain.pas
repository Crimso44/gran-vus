unit dMain;

interface

uses
  StrUtils, Variants,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EkRtf, Db, ADODB, ekbasereport, dxmdaset, ImgList, dxTL, OleServer, ExcelXP,
  ekfunc, Excel2000, System.ImageList;

type
  TdmMain = class(TDataModule)
    EkRTF1: TEkRTF;
    dbMain: TADOConnection;
    qrPers: TADOQuery;
    mReplacePlan: TdxMemData;
    mReplacePlanPers_id: TIntegerField;
    mReplacePlanPers_Fio: TStringField;
    mReplacePlanPers_Dep: TStringField;
    mReplacePlanPers_Post: TStringField;
    mReplacePlanRepl_Id: TIntegerField;
    mReplacePlanRepl_Fio: TStringField;
    mReplacePlanRepl_Dep: TStringField;
    mReplacePlanRepl_Post: TStringField;
    mReplacePlanRepl_War: TStringField;
    ImageList1: TImageList;
    Query1: TADOQuery;
    qrSelectPerson: TADOQuery;
    qrSelectPersonPers_Id: TIntegerField;
    qrSelectPersonPers_FIO: TWideStringField;
    qrSelectPersonPers_Dep: TWideStringField;
    qrSelectPersonPers_Post: TWideStringField;
    qrSelectPersonwar: TWideStringField;
    ExcelApplication: TExcelApplication;
    mReplacePlannn: TIntegerField;
    EkUDFList1: TEkUDFList;
    procedure DataModuleCreate(Sender: TObject);
    procedure mReplacePlanAfterPost(DataSet: TDataSet);
    procedure mReplacePlanCalcFields(DataSet: TDataSet);
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
    is_changed: Boolean;
    function OpenData: boolean;
    function PrintData: boolean;
    procedure SaveData;
    procedure GridToExcel(Grid: TCustomdxTreeListControl; ACaption: string =''; PrintBands: boolean=false; PrintHeaders: boolean=true);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'План замены призываемых специалистов';

implementation

{$R *.DFM}

uses SaveEvents, IniSupport, msg;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  System.Variants.DispatchUnsignedAsSigned := True;

  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'ReplacePlan.rtf';
  EkRTF1.Outfile := GetReportsDir + 'План замены призываемых специалистов.rtf';
end;

function TdmMain.OpenData: boolean;
begin
  try
    qrPers.Open;
    mReplacePlan.Open;
    while not qrPers.Eof do begin
      mReplacePlan.Append;
      mReplacePlanPers_Id.Value := qrPers.FieldByName('Pers_Id').Value;
      mReplacePlanPers_FIO.Value := qrPers.FieldByName('Pers_FIO').Value;
      mReplacePlanPers_Dep.Value := qrPers.FieldByName('Pers_Dep').Value;
      mReplacePlanPers_Post.Value := qrPers.FieldByName('Pers_Post').Value;

      mReplacePlanRepl_FIO.Value := qrPers.FieldByName('FIO').AsString;
      mReplacePlanRepl_Dep.Value := qrPers.FieldByName('Depart').AsString;
      mReplacePlanRepl_Post.Value := qrPers.FieldByName('Post').AsString;
      mReplacePlanRepl_War.Value := qrPers.FieldByName('war').AsString;
      mReplacePlanRepl_Id.Value := qrPers.FieldByName('Repl_Pers_Id').AsInteger;
      mReplacePlan.Post;

      qrPers.Next;
    end;
    mReplacePlan.First;
    qrPers.Close;
    qrSelectPerson.Open;

    is_changed := False;
    Result := true;
  except on e: Exception do begin
    ShowMessage(e.Message);
    Result := false;
  end;
  end;
end;

function TdmMain.PrintData: boolean;
var
  s: String;
begin
  try
    EkRTF1.ClearVars;
    Query1.SQL.Text := 'Select OrgName, OrgSName from Org';
    Query1.Open;
    s := Query1.Fields[1].AsString;
    if s = '' then
      s := Query1.Fields[0].AsString;
    EkRTF1.CreateVar('OrgName', s);
    Query1.Close;
    EkRTF1.CreateVar('CurDate', FormatDateTime('dd.mm.yy',Date));
    FillExecutor;
    EkRTF1.ExecuteOpen([mReplacePlan],SW_SHOWDEFAULT);
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      []);
    Result := true;
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


procedure TdmMain.SaveData;
var
  bmk: TBookmark;
begin
  Query1.SQL.Text := 'Delete * From ReplacePlan';
  Query1.ExecSQL;
  Query1.SQL.Text := 'Select * from ReplacePlan';
  Query1.Open;
  mReplacePlan.DisableControls;
  bmk := mReplacePlan.GetBookmark;
  mReplacePlan.First;
  while not mReplacePlan.Eof do begin
    Query1.Append;
    Query1.FieldByName('Pers_Id').Value := mReplacePlanPers_Id.Value;
    Query1.FieldByName('FIO').AsString := mReplacePlanRepl_FIO.AsString;
    Query1.FieldByName('Depart').AsString :=  mReplacePlanRepl_Dep.AsString;
    Query1.FieldByName('Post').AsString := mReplacePlanRepl_Post.AsString;
    Query1.FieldByName('war').AsString := mReplacePlanRepl_War.AsString;
    Query1.FieldByName('Repl_Pers_Id').AsInteger := mReplacePlanRepl_Id.AsInteger;
    Query1.Post;
    mReplacePlan.Next;
  end;
  mReplacePlan.GotoBookmark(bmk);
  mReplacePlan.EnableControls;
  Query1.Close;
  is_changed := False;
  ShowInfo('Данные сохранены.');
end;

procedure TdmMain.GridToExcel(Grid: TCustomdxTreeListControl; ACaption: string;
  PrintBands, PrintHeaders: boolean);
var CurRow,CurCol: Integer;
    BandMarg: Array[0..255] of Integer;
  procedure StoreNode(node: TdxTreeListNode);
  var i: Integer;
  begin
    if node.HasChildren then begin
      for i:=0 to Grid.ColumnCount-1 do
        if Grid.Columns[i].Visible then begin
          CurCol := BandMarg[Grid.Columns[i].BandIndex]+Grid.Columns[i].ColIndex;
          with ExcelApplication do begin
            Cells.Item[CurRow,CurCol].VerticalAlignment := xlTop;
            Cells.Item[CurRow,CurCol].WrapText := False;
            Cells.Item[CurRow,CurCol] := AnsiReplaceText(AnsiReplaceText(node.Strings[i],'true','X'),'false','');
          end;
          Break;
        end;
    end else begin
      for i:=0 to Grid.ColumnCount-1 do
        if Grid.Columns[i].Visible then begin
          CurCol := BandMarg[Grid.Columns[i].BandIndex]+Grid.Columns[i].ColIndex;
          with ExcelApplication do begin
            Cells.Item[CurRow,CurCol].VerticalAlignment := xlJustify;
            Cells.Item[CurRow,CurCol].WrapText := True;
            Cells.Item[CurRow,CurCol] := AnsiReplaceText(AnsiReplaceText(node.Strings[i],'true','X'),'false','');
          end;
        end;
    end;
    Inc(CurRow);
    for i:=0 to node.Count-1 do StoreNode(node.Items[i]);
  end;
var i,j,k,n: Integer;
    Save_Cursor:TCursor;
    XLsht: OleVariant;
begin
  {if not dmMain.rPrint then begin
    ShowErr('Вы не обладаете правом на печать документов. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;}
  try
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourglass;    { Show hourglass cursor }

    with ExcelApplication do begin
      try
       Connect;
       Visible[0]:=True;
       Workbooks.Add(NULL, 0);

       CurRow := 1;
  //Store caption
       if ACaption <> '' then begin
         Range[Cells.Item[CurRow, 1], Cells.Item[CurRow, 1]].Font.Bold:= True;
         Range[Cells.Item[CurRow, 1], Cells.Item[CurRow, 1]].Font.Size:= 12;
         Range[Cells.Item[CurRow, 1], Cells.Item[CurRow, Grid.VisibleColumnCount]].HorizontalAlignment := xlHAlignCenterAcrossSelection;
         Cells.Item[CurRow, 1]:= ACaption;
         Inc(CurRow);
       end;
  //Store bands
        CurCol := 1;
        for i:=0 to  Grid.Bands.Count-1 do
          for j:=0 to Grid.Bands.Count-1 do
            if Grid.Bands[j].Visible and (Grid.Bands[j].VisibleIndex=i) then begin
              BandMarg[j] := CurCol;
              n := 0;
              for k:=0 to Grid.ColumnCount-1 do
                if (Grid.Columns[k].BandIndex=Grid.Bands[j].Index) and Grid.Columns[k].Visible then Inc(n);
              if PrintBands and (n>0) then begin
                Cells.Item[CurRow,CurCol] := Grid.Bands[j].Caption;
                with Range[Cells.Item[CurRow,CurCol],Cells.Item[CurRow,CurCol+n-1]] do begin
                  Font.Bold := true;
                  Font.Size := 10;
                  VerticalAlignment := Integer(xlVAlignCenter);
                  HorizontalAlignment := Integer(xlHAlignCenter);
                  Merge(false);
                  with Borders.Item[xlEdgeLeft] do begin
                    LineStyle := xlContinuous;
                    Weight := xlThin;
                    ColorIndex := Integer(xlAutomatic);
                  end;
                  with Borders.Item[xlEdgeTop] do begin
                    LineStyle := xlContinuous;
                    Weight := xlThin;
                    ColorIndex := Integer(xlAutomatic);
                  end;
                  with Borders.Item[xlEdgeBottom] do begin
                    LineStyle := xlContinuous;
                    Weight := xlThin;
                    ColorIndex := Integer(xlAutomatic);
                  end;
                  with Borders.Item[xlEdgeRight] do begin
                    LineStyle := xlContinuous;
                    Weight := xlThin;
                    ColorIndex := Integer(xlAutomatic);
                  end;
                end;
              end;
              Inc(CurCol,n);
              break;
            end;
        if PrintBands then Inc(CurRow);
  //Store column headers
       if PrintHeaders then begin
         for i:=0 to  Grid.ColumnCount-1 do
           if Grid.Columns[i].Visible then begin
             CurCol := BandMarg[Grid.Columns[i].BandIndex]+Grid.Columns[i].ColIndex;
             Cells.Item[CurRow,CurCol].ColumnWidth := Grid.Columns[i].Width/8;
             Cells.Item[CurRow,CurCol] := Trim(Grid.Columns[i].Caption);
             Cells.Item[CurRow,CurCol].HorizontalAlignment := xlCenter;
             Cells.Item[CurRow,CurCol].VerticalAlignment := xlCenter;
             Cells.Item[CurRow,CurCol].WrapText := True;
             with Range[Cells.Item[CurRow,CurCol], Cells.Item[CurRow,CurCol] ] do begin
               Font.Size := 10;
               HorizontalAlignment := Integer(xlHAlignCenter);
               VerticalAlignment := Integer(xlVAlignCenter);
               with Borders.Item[xlEdgeLeft] do begin
                  LineStyle := xlContinuous;
                  Weight := xlThin;
                  ColorIndex := Integer(xlAutomatic);
               end;
               with Borders.Item[xlEdgeTop] do begin
                 LineStyle := xlContinuous;
                 Weight := xlThin;
                 ColorIndex := Integer(xlAutomatic);
               end;
               with Borders.Item[xlEdgeRight] do begin
                 LineStyle := xlContinuous;
                 Weight := xlThin;
                 ColorIndex := Integer(xlAutomatic);
               end;
               with Borders.Item[xlEdgeBottom] do begin
                 LineStyle := xlContinuous;
                 Weight := xlThin;
                 ColorIndex := Integer(xlAutomatic);
               end;
             end;
             with Range[Cells.Item[CurRow+1,CurCol], Cells.Item[65536,CurCol] ] do begin
               NumberFormat := '@';
               Font.Size := 8;
               VerticalAlignment := Integer(xlVAlignCenter);
               case Grid.Columns[i].Alignment of
                 taLeftJustify:  HorizontalAlignment := Integer(xlHAlignLeft);
                 taRightJustify: HorizontalAlignment := Integer(xlHAlignRight);
                 taCenter:       HorizontalAlignment := Integer(xlHAlignCenter);
               end;
             end;
           end;
         Inc(CurRow);
       end;

  //Store data lines
      for i:=0 to Grid.Count-1 do StoreNode(Grid.Items[i]);

  //Prepare print sets
       try
         XLsht := ActiveSheet;
         XLsht.PageSetup.PaperSize := xlPaperA4;
         XLsht.PageSetup.Zoom := 95;
         XLsht.PageSetup.Orientation := xlLandscape;
       except
       end;

      finally
        Disconnect;
        Screen.Cursor := Save_Cursor;  { Always restore to normal }
      end;
    end;
    SaveEvent(dbMain, evs_Report_Print, ACaption,[]);
  except
    SaveEvent(dbMain, evs_Report_Error, ACaption,[]);
    raise;
  end;
end;

procedure TdmMain.mReplacePlanAfterPost(DataSet: TDataSet);
begin
  is_changed := True;
end;

procedure TdmMain.mReplacePlanCalcFields(DataSet: TDataSet);
begin
  mReplacePlannn.AsInteger := mReplacePlan.CurRec + 1;
end;

end.

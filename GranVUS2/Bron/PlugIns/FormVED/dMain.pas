unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, OleServer, dxTL, Variants, Excel2000, dxDBGrid, dxGrClms,
  ExcelXP;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    ilSmall: TImageList;
    ExcelApplication: TExcelApplication;
    qrData: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FPrinting: Boolean;
    procedure FieldGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  public
    rPrint: Boolean;//User's rights
    tlPath: string;
    repPath: string;
    procedure PrintData(ID:Integer);
    procedure GridToExcel(Grid: TdxDBGrid; ACaption: string ='';
      PrintBands: boolean=false; PrintHeaders: boolean=true);
  end;

var
  dmMain: TdmMain;
  FPrintOnly: Boolean;

const
  sEventObject = '����������� �� ����� ������������� ������������';

implementation

{$R *.DFM}

uses IniSupport, msg, SaveEvents, StrUtils, ShellAPI;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  tlPath := GetTemplatesDir;
  repPath := GetReportsDir;
end;

procedure TdmMain.PrintData(ID: Integer);
begin
  EkRTF1.Infile := tlPath + 'FormVED.rtf';
  EkRTF1.Outfile := repPath + '����� �� ���.rtf';

  try
    try
      EkRTF1.ClearVars;

      with TADOQuery.Create(Self) do try
        Connection := dbMain;
        SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ'#10 +
                    'WHERE SUBJ_ID = ' + IntToStr(ID);
        Open;
        EkRTF1.CreateVar('SUBJ_NAME', FieldByName('SUBJ_NAME').AsString);
      finally
        Free;
      end;
      qrData.Parameters.ParamByName('SUBJ_ID').Value := ID;
      qrData.Open;
      EkRTF1.ExecuteOpen([qrData],SW_SHOWDEFAULT);
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,
        ['����� �����������: '+IntToStr(ID)]);
    finally
      FPrinting:= False;
      qrData.Close;
    end
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['������ ��� �������� ������.']);
    ShowErr('������ ��� �������� ������!'#13+
      '�������� ������� ������� ������� ����� '#13+
      '��� ������ ������ ������������ ������ ����������...');
  end;
end;

procedure TdmMain.FieldGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
const True2X : array [Boolean] of String = (' ','X');
begin
  Text := Sender.AsString;
  Text := True2X[SameText(Text,'true')];
end;

procedure TdmMain.GridToExcel(Grid: TdxDBGrid; ACaption: string =''; PrintBands: boolean=false; PrintHeaders: boolean=true);
var
  FName : String;
  I     : Integer;
begin
  if not dmMain.rPrint then begin
    ShowErr('�� �� ��������� ������ �� ������ ����������. '+
            '�� ������������� �� ������ ���������� � �������������� �������.');
    Exit;
  end;
  if ACaption=''
    then FName := '����� � Excel.XLS'
    else FName := ACaption+'.XLS';
  for I := 1 to Length(FName) do if FName[I] in ['\','/',':','*','?','"','<','>','|']
  then FName[I] := '_';
  FName := GetReportsDir+FName;
  try
    for I := 0 to Grid.ColumnCount-1 do
    if Grid.Columns[I] is TdxDBGridCheckColumn then
    with Grid.Columns[I] do begin
      Field.OnGetText := FieldGetText;
      Alignment := taCenter;
    end;

    Grid.OptionsDB := Grid.OptionsDB+[edgoLoadAllRecords]; 
    Grid.SaveToXLS(FName, True);

    for I := 0 to Grid.ColumnCount-1 do
    if Grid.Columns[I] is TdxDBGridCheckColumn then
      Grid.Columns[I].Field.OnGetText := nil;

    ShellExecute(0,'open',PChar(FName),nil,nil,SW_SHOWMAXIMIZED);
    SaveEvent(dbMain, evs_Report_Print, ACaption,[]);
  except
    SaveEvent(dbMain, evs_Report_Error, ACaption,[]);
    raise;
  end;
end;
(*var CurRow,CurCol: Integer;
    BandMarg: Array[0..255] of Integer;
  procedure StoreNode(node: TdxTreeListNode);
  var i: Integer;
  begin
    for i:=0 to Grid.ColumnCount-1 do
      if Grid.Columns[i].Visible then begin
        CurCol := BandMarg[Grid.Columns[i].BandIndex]+Grid.Columns[i].ColIndex;
        with ExcelApplication do begin
          Cells.Item[CurRow,CurCol].VerticalAlignment := xlJustify;
          Cells.Item[CurRow,CurCol].WrapText := True;
          Cells.Item[CurRow,CurCol] := AnsiReplaceText(AnsiReplaceText(node.Strings[i],'true','X'),'false','');
        end;
      end;
    Inc(CurRow);
    for i:=0 to node.Count-1 do StoreNode(node.Items[i]);
  end;
var i,j,k,n: Integer;
    Save_Cursor:TCursor;
    XLsht: OleVariant;
begin
  if not dmMain.rPrint then begin
    ShowErr('�� �� ��������� ������ �� ������ ����������. '+
            '�� ������������� �� ������ ���������� � �������������� �������.');
    Exit;
  end;
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
end;*)

end.

unit fStaffList;

interface

uses
  uMemoTable, Contnrs,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FrmKeep, dxCntner, dxTL, dxBar, ComCtrls, Db, ADODB, dxTLClms, ActnList,dxExEdtr,
  StdCtrls, Variants, dxDBCtrl, dxDBGrid, dxmdaset, Menus, cxClasses,
  ExtCtrls, Buttons, CheckLst, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxBarPainter, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGridBandedTableView, cxGridExportLink;

type
  TfmStaffList = class(TForm)
    StatusBar: TStatusBar;
    dxBarManager1: TdxBarManager;
    FrmKeep1: TFrmKeep;
    qrData: TADOQuery;
    ActionList1: TActionList;
    actStore: TAction;
    actClose: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    actCalculate: TAction;
    actRevert: TAction;
    TabControl: TTabControl;
    actRefresh: TAction;
    dxBarButton5: TdxBarButton;
    dxBarSubItem1: TdxBarSubItem;
    dxBarButton4: TdxBarButton;
    dxBarButton6: TdxBarButton;
    actRevertCell: TAction;
    actRevertColumn: TAction;
    actRevertRow: TAction;
    actRevertAll: TAction;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarSubItem2: TdxBarSubItem;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    actCalculateCell: TAction;
    actCalculateColumn: TAction;
    actCalculateRow: TAction;
    actCalculateAll: TAction;
    mnuGrid: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    actExcel: TAction;
    Excel1: TMenuItem;
    dxBarButton3: TdxBarButton;
    StatusBar1: TStatusBar;
    bFilter: TdxBarButton;
    Panel1: TPanel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    bPostsNone: TBitBtn;
    bPostsAll: TBitBtn;
    bDepsNone: TBitBtn;
    bDepsAll: TBitBtn;
    cbPosts: TCheckListBox;
    cbDeps: TCheckListBox;
    GridXDBTableView1: TcxGridDBTableView;
    GridX: TcxGrid;
    ColGridNum: TcxGridDBColumn;
    ColGridPost_Name: TcxGridDBColumn;
    ColGridPost_Total: TcxGridDBColumn;
    GridXLevel2: TcxGridLevel;
    GridXView: TcxGridBandedTableView;
    GridNumX: TcxGridBandedColumn;
    GridPost_NameX: TcxGridBandedColumn;
    GridPost_TotalX: TcxGridBandedColumn;
    GridPost_IdX: TcxGridBandedColumn;
    SaveDialog1: TSaveDialog;
    dxBBHideOld: TdxBarButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actCloseExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabControlChange(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actRevertExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure actCalculateExecute(Sender: TObject);
    procedure actCalculateCellExecute(Sender: TObject);
    procedure actCalculateColumnExecute(Sender: TObject);
    procedure actCalculateRowExecute(Sender: TObject);
    procedure actCalculateAllExecute(Sender: TObject);
    procedure actRevertCellExecute(Sender: TObject);
    procedure actRevertColumnExecute(Sender: TObject);
    procedure actRevertRowExecute(Sender: TObject);
    procedure actRevertAllExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qrDataFieldSetText(Sender: TField; const Text: String);
    procedure actStoreExecute(Sender: TObject);
    procedure actExcelExecute(Sender: TObject);
    procedure bFilterClick(Sender: TObject);
    procedure bPostsAllClick(Sender: TObject);
    procedure bPostsNoneClick(Sender: TObject);
    procedure bDepsAllClick(Sender: TObject);
    procedure bDepsNoneClick(Sender: TObject);
    procedure GridNumXGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure GridXViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure GridXViewEditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
    procedure dxBBHideOldClick(Sender: TObject);
  protected
    IAmStored: Boolean;
  private
    { Private declarations }
    FChanged   : TStringList;
    FCalculate : TStringList;
    FFormulas  : TStringList;
    procedure CreateTabs;
    procedure LoadData;
    procedure GetCalcDatasX(Data: TMemoTable; out CalcData1, CalcData2:TMemoTable);
    function GetTabIndex: Integer;
    procedure FillGrid(sTable: String);
    procedure FillRow(DataX: TMemoTable; Row: Integer);
    procedure UpdateRow(r: Integer = -1);
    procedure DataXCalcFields(memo: TMemoTable; row: Integer);
    procedure DoValidate(Sender: TObject; var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);

  public
    { Public declarations }
    ActiveTable: TMemoTable;
    tables: TMemoTables;
  end;

  type
    TDT = class
      d: TDateTime;
    end;

  procedure ShowStaffListStored;
  procedure ShowStaffListRO;

implementation

uses dMain, msg, StrUtils, fMain;

{$R *.DFM}

const
  PagesCount = 10;
  PagesTabs: array [0..PagesCount-2] of String =
   ('Штатная численность',
    'Штатная численность на РГ',
    'Работает в мирное время',
    'Имеют моб.предписание',
    'Призывников годности А,Б,В',
    'Забронированно',
    'Всего ГПЗ, ГПП',
    'Вакансий по ШР',
    'Недостаёт по ШЧ на РГ');
  PagesMap: array [0..PagesCount-1] of String =
   ('GeneralPlan',
    'WartimePlan',
    'GeneralQty',
    'QtyMob',
    'QtyRecruit',
    'QtyReserv',
    'QtyWar',
    'GeneralVacancy',
    'WartimeVacancy',
    'QtyAll');
  PagesRO:  array [0..PagesCount-1] of Boolean =
   (False, //   ('GeneralPlan',
    False, //    'WartimePlan',
    False, //    'GeneralQty',
    True , //    'QtyMob',
    True , //    'QtyRecruit',
    True , //    'QtyReserv',
    True , //    'QtyWar',
    False, //    'GeneralVacancy',
    False, //    'WartimeVacancy',
    True );//    'QtyAll');
  PagesFormulas:{FFormulas} array [1..4] of String = //result=d1{-d2}
   ('GeneralVacancy=GeneralPlan-GeneralQty',
    'GeneralQty=QtyAll',
    'WartimeVacancy=WartimePlan-GeneralQty',
    'WartimePlan=GeneralPlan');
var
  fmStaffList: array [Boolean] of TfmStaffList;

procedure Go(AStored: Boolean);
const MyCaption: array [Boolean] of String = (
  'Расчётные данные по подразделениям и должностям',
  'Штатное расписание. Учёт "Всего работающих"');
begin
  if fmStaffList[AStored]=nil then begin
    Application.CreateForm(TfmStaffList,fmStaffList[AStored]);
    if fmMain.MainScale <> 100 then
      fmStaffList[AStored].ScaleBy(fmMain.MainScale, 100);
    with fmStaffList[AStored] do begin
      IAmStored := AStored; // See OnClose
      Caption := MyCaption[AStored];
      actStore     .Visible := AStored;
      actCalculate .Visible := AStored;
      actRevert    .Visible := AStored;
      CreateTabs;
      LoadData;
      TabControlChange(nil);
    end;
  end;
  if IsIconic(fmStaffList[AStored].Handle) then
    ShowWindow(fmStaffList[AStored].Handle,SW_RESTORE);
  fmStaffList[AStored].BringToFront;
  if AStored then fmStaffList[AStored].HelpContext := 13
  else fmStaffList[AStored].HelpContext := 15;
end;

procedure ShowStaffListStored; begin Go(True) end;
procedure ShowStaffListRO;     begin Go(False) end;

procedure TfmStaffList.LoadData;
var
  RecCnt, RecCntHidden: Integer;

//
  procedure ClearGridColumns;
  var I: integer;
  begin
    for I := GridXView.ColumnCount-1 downto 0 do
    if GridXView.Columns[I].Position.BandIndex=1 then GridXView.Columns[I].Free;
  end;
//
  procedure CopyHiddenToOld;
  var
    I, J, R    : Integer;
    HiddenDataX, OldDataX : TMemoTable;
  begin
    for I := 0 to PagesCount-1 do begin
      HiddenDataX := tables.GetByName('Data'+PagesMap[I]+'_hidden');
      OldDataX := tables.GetByName('Data'+PagesMap[I]+'_Old');
      if Assigned(OldDataX) and Assigned(HiddenDataX) then begin
        OldDataX.RowCount := HiddenDataX.RowCount;
        for r := 0 to OldDataX.RowCount-1 do begin
          for J := 0 to HiddenDataX.ColumnNames.Count-1 do begin
            OldDataX.Data[J, r] := HiddenDataX.Data[J, r];
          end;
        end;
      end;
    end;
  end;
//
  procedure CreateData;
  var
    I    : Integer;
    DataX : TMemoTable;
  begin
    for I := 0 to PagesCount-1 do begin
      DataX := tables.GetByName('Data'+PagesMap[I]);
      if Assigned(DataX) then begin
        if PagesRO[I]
          then
            tables.tables.Remove(DataX)
          else
            DataX.Name := 'Data'+PagesMap[I]+'_Old';
      end;
      DataX := TMemoTable.Create();
      DataX.Name := 'Data'+PagesMap[I];
      DataX.OnCalcFields := DataXCalcFields;
      DataX.Tag := I;
      tables.tables.Add(DataX);
    end;

    CopyHiddenToOld;

    for I := 0 to PagesCount-1 do begin
      DataX := tables.GetByName('Data'+PagesMap[I]+'_hidden');
      if Assigned(DataX) then
        tables.tables.Remove(DataX);
      DataX := TMemoTable.Create();
      DataX.Name := 'Data'+PagesMap[I]+'_hidden';
      DataX.OnCalcFields := DataXCalcFields;
      DataX.Tag := I;
      tables.tables.Add(DataX);
    end;
  end;
//
  procedure AddDataField(FName: String; hidden: Boolean);
  var
    I      : Integer;
    s: String;
    DataX: TMemoTable;
  begin
    s := '';
    if hidden then s := '_hidden';

    for I := 0 to PagesCount-1 do begin
      if not SameText(FName,'POST_NAME')
        then begin
          DataX := tables.GetByName('Data'+PagesMap[I]+s);
          DataX.AddColumn(FName);
        end;
    end;
  end;
//
  procedure AddDataRecord(Post_ID: Integer; Post_Name: String; hidden: Boolean);
  var
    I, r : Integer;
    DataX: TMemoTable;
    s: String;
  begin
    s := '';
    if hidden then s := '_hidden';

    for I := 0 to PagesCount-1 do begin
      DataX := tables.GetByName('Data'+PagesMap[I]+s);
      r := RecCnt;
      if hidden then r := RecCntHidden;
      DataX.Data[0, r] := Post_ID;
      DataX.StringField[r] := Post_Name;
    end;
  end;
//

  var
    t: TDateTime;
    tt: TStringList;

  procedure StartTimer;
  begin
    tt := TStringList.Create;
    t := Date + Time;
  end;

  procedure Ping(s: String);
  var
    dt: TDateTime;
    i: Integer;
    x: TDT;
  begin
    dt := (Date + Time) - t;
    i := tt.IndexOf(s);
    if i < 0 then begin
      x := TDT.Create;
      x.d := dt;
      tt.AddObject(s, x);
    end else
      TDT(tt.Objects[i]).d := TDT(tt.Objects[i]).d + dt;
    t := Date + Time;
  end;

  procedure StopTimer;
  var
    ls: TStringList;
    i: Integer;
  begin
    ls := TStringList.Create;
    for i := 0 to tt.Count - 1 do
      ls.Add(tt[i]+': '+FormatDateTime('mm:ss.zzz', TDT(tt.Objects[i]).d));
    ls.SaveToFile('c:\timer.txt');
    ls.Free;
    for i := tt.Count - 1 downto 0 do
      tt.Objects[i].Free;
    tt.Free;
  end;

  procedure FillData;
  var
    I, r, rh, val: Integer;
    DataAX, DataAHX: array of TMemoTable;
    POST_ID: Integer;
    sDEP_ID : String;
    colId: Integer;
  begin
    SetLength(DataAX, PagesCount);
    SetLength(DataAHX, PagesCount);
    for I := 0 to PagesCount-1 do begin
      DataAX[I] := tables.GetByName('Data'+PagesMap[I]);
      DataAHX[I] := tables.GetByName('Data'+PagesMap[I]+'_hidden');
    end;

//StartTimer;

  qrData.Close;//on refresh
//Ping('00');
  qrData.Open;
//Ping('01');
    while not qrData.Eof do begin
//Ping('02');
      POST_ID := qrData.FieldByName('POST_ID').AsInteger;
//Ping('03');
      r := DataAX[0].FindRec(Post_Id);
//Ping('04');
      rh := DataAHX[0].FindRec(Post_Id);
//Ping('05');
      while not qrData.Eof  and (POST_ID = qrData.FieldByName('POST_ID').AsInteger) do begin
//Ping('06');
        sDEP_ID := 'DEP_'+qrData.FieldByName('DEP_ID').AsString;
//Ping('07');
        colId := DataAX[0].FindField(sDEP_ID);
//Ping('08');
        if r >= 0 then begin
//Ping('09');
          for I := 0 to PagesCount-1 do begin
//Ping('10');
            val := qrData.FieldByName(PagesMap[I]).AsInteger;
//Ping('11');
            if val <> 0 then begin
//Ping('12');
              DataAX[I].Data[colId, r] := val;
//Ping('13');
            end;
//Ping('14');
          end;
//Ping('15');
        end;
//Ping('16');
        if rh >= 0 then begin
//Ping('17');
          for I := 0 to PagesCount-1 do begin
//Ping('18');
            val := qrData.FieldByName(PagesMap[I]).AsInteger;
//Ping('19');
            if val <> 0 then begin
//Ping('20');
              DataAHX[I].Data[colId, r] := val;
//Ping('21');
            end;
//Ping('22');
          end;
//Ping('23');
        end;
//Ping('24');
        qrData.Next;
//Ping('25');
      end;
//Ping('26');
    end;
//StopTimer;
  end;
//
  procedure UtilizeOldData;
  var
    I, J, K, DataR : Integer;
    DataX, OldDataX : TMemoTable;
    AFieldX: Integer;
  begin
    with TStringList.Create do   //Old FChanged
    try
      Assign(FChanged); //FChanged.Clear;

      for I := 0 to PagesCount-1 do
      if not PagesRO [I] then begin
        OldDataX := tables.GetByName('Data'+PagesMap[I]+'_Old');
        if Assigned(OldDataX) then begin
          DataX := tables.GetByName('Data'+PagesMap[I]);
          DataR := 0;
          while DataR <= High(DataX.Data[0]) do begin
            if OldDataX.FindRec(DataX.Data[0, DataR]) >= 0 then begin
              for J := 2 to High(DataX.Data[0]) do begin
                if J < DataX.ColumnNames.Count then begin
                  K := IndexOfName(Format('D:%s;P:%d;F:%d;',[
                    Copy(DataX.ColumnNames[J],5,10),//Strip 'DEP_'
                    DataX.Data[0, DataR],
                    DataX.Tag]));
                  if K>=0 then begin
                    //FChanged.Add(Strings[K]);
                    AFieldX := OldDataX.ColumnNames.IndexOf(DataX.ColumnNames[J]);
                    if AFieldX >= 0 then DataX.Data[J, DataR] := OldDataX.Data[AFieldX, DataR];
                  end;
                end;
              end;
            end;
            Inc(DataR);
          end;

          DataX := tables.GetByName('Data'+PagesMap[I]+'_hidden');
          DataR := 0;
          while DataR <= High(DataX.Data[0]) do begin
            if OldDataX.FindRec(DataX.Data[0, DataR]) >= 0 then begin
              for J := 2 to High(DataX.Data[0]) do begin
                if J < DataX.ColumnNames.Count then begin
                  K := IndexOfName(Format('D:%s;P:%d;F:%d;',[
                    Copy(DataX.ColumnNames[J],5,10),//Strip 'DEP_'
                    DataX.Data[0, DataR],
                    DataX.Tag]));
                  if K>=0 then begin
                    //FChanged.Add(Strings[K]);
                    AFieldX := OldDataX.ColumnNames.IndexOf(DataX.ColumnNames[J]);
                    if AFieldX >= 0 then DataX.Data[J, DataR] := OldDataX.Data[AFieldX, DataR];
                  end;
                end;
              end;
            end;
            Inc(DataR);
          end;
          tables.tables.Remove(OldDataX);
        end;
      end;
    finally Free;
    end;
  end;
//
var
  I, DepId, PostId: Integer;
  DataX: TMemoTable;
  prop: TcxCustomEditProperties;
  col: TcxGridBandedColumn;
begin
  ActiveTable := nil;

  GridXView.BeginUpdate;
  ClearGridColumns;
  CreateData;
  AddDataField('POST_ID', True);
  AddDataField('POST_NAME', True);
  AddDataField('POST_Total', True);
  AddDataField('POST_ID', False);
  AddDataField('POST_NAME', False);
  AddDataField('POST_Total', False);

  with TADOQuery.Create(Self) do
  try

    Connection := dmMain.dbMain; ParamCheck := False;
//    SQL.Text := 'DELETE * FROM STAFFLIST WHERE NOT DEP_ID IN (SELECT DEP_ID FROM KDEPART) OR NOT POST_ID IN (SELECT POST_ID FROM KPOST)';
//    ExecSQL;
    SQL.Text := 'DELETE '+IsJet('* ','From StaffList ')+'FROM STAFFLIST sl WHERE NOT EXISTS (SELECT DEP_ID FROM KDEPART WHERE DEP_ID = sl.DEP_ID)';
    ExecSQL;
    SQL.Text := 'SELECT * FROM KDEPART ' +
      'ORDER BY '+iifStr(dmMain.isAbcSort, 'Dep_Name', 'KDEPART_Num');
    Open;
    while not EOF do begin
      DepId := FieldByName('DEP_ID').AsInteger;
      AddDataField('DEP_'+FieldByName('DEP_ID').AsString, False);
      AddDataField('DEP_'+FieldByName('DEP_ID').AsString, True);
      col := GridXView.CreateColumn;
      with col do begin
        Visible :=
          ((not bFilter.Down) or cbDeps.Checked[cbDeps.Items.IndexOfObject(Pointer(DepId))]) and
          ((not dxBBHideOld.Down) or (not FieldByName('IS_OLD').AsBoolean));
        Position.BandIndex := 1;
        Summary.FooterFormat := '0';
        Summary.FooterKind := skSum;
        Width := 85;
        Caption := FieldByName('DEP_NAME').AsString;
        Tag := FieldByName('DEP_ID').AsInteger;
        DataBinding.ValueType := 'Integer';
        prop := TcxCustomEditProperties.Create(Self);
        prop.OnValidate := DoValidate;
        Properties := prop;
      end;
      Next;
    end;
    Close;
    GridXView.EndUpdate;


    RecCnt := 0; RecCntHidden := 0;
    SQL.Text := 'SELECT * FROM KPOST ' {+ IfThen(IAmStored, 'WHERE CPROF_ID <> 500', '')} +
      ' ORDER BY '+iifStr(dmMain.isAbcSort, 'Post_Name', 'KPOST_Num');
    Open;
    Last;
    First;

    for I := 0 to PagesCount-1 do begin
      DataX := tables.GetByName('Data'+PagesMap[I]);
      DataX.RowCount := RecordCount;
      DataX := tables.GetByName('Data'+PagesMap[I]+'_hidden');
      DataX.RowCount := RecordCount;
    end;

    while not EOF do begin
      PostId := FieldByName('POST_ID').AsInteger;
      if ((not bFilter.Down) or cbPosts.Checked[cbPosts.Items.IndexOfObject(Pointer(PostId))])
        and ((not dxBBHideOld.Down) or (not FieldByName('IS_OLD').AsBoolean)) then begin
        AddDataRecord(FieldByName('POST_ID').AsInteger, FieldByName('POST_NAME').AsString, False);
        Inc(RecCnt);
      end else begin
        AddDataRecord(FieldByName('POST_ID').AsInteger, FieldByName('POST_NAME').AsString, True);
        Inc(RecCntHidden);
      end;
      Next;
    end;

    for I := 0 to PagesCount-1 do begin
      DataX := tables.GetByName('Data'+PagesMap[I]);
      DataX.RowCount := RecCnt;
      DataX := tables.GetByName('Data'+PagesMap[I]+'_hidden');
      DataX.RowCount := RecCntHidden;
    end;


  finally Free;
  end;
  FillData;
  UtilizeOldData;

  FillGrid('Data'+PagesMap[GetTabIndex]);

end;


procedure TfmStaffList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := (FChanged.Count=0) or Confirm('Закрыть окно без сохранения данных?');
end;

procedure TfmStaffList.FillGrid(sTable: String);
var
  DataX: TMemoTable;
  r: Integer;
begin
  DataX := tables.GetByName(sTable);
  ActiveTable := DataX;
  GridXView.DataController.RecordCount := High(DataX.Data[0]) + 1;
  with GridXView.DataController do begin
    BeginUpdate;
    for r := 0 to High(DataX.Data[0]) do begin
      FillRow(DataX, r);
    end;
    EndUpdate;
  end;
end;

procedure TfmStaffList.FillRow(DataX: TMemoTable; Row: Integer);
var
  c, dep, i, r: Integer;
begin
  r := Row;
  if r < 0 then r := DataX.CurrentRow;
  DataX.CalcFields(Row);
  with GridXView.DataController do begin
      Values[r, 1] := DataX.StringField[r];
      Values[r, 2] := DataX.Data[1, r];
      Values[r, 3] := DataX.Data[0, r];
      for c := 2 to High(DataX.Data) do begin
        dep := StrToInt(Copy(DataX.ColumnNames[c], 5, MaxInt));
        for i := 4 to GridXView.ColumnCount-1 do begin
          if GridXView.Columns[i].Tag = dep then begin
            Values[r, GridXView.Columns[i].Index] := DataX.Data[c, r];
            Break;
          end;
        end;
      end;
  end;
end;

procedure TfmStaffList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  fmStaffList[IAmStored] := nil;
end;

procedure TfmStaffList.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmStaffList.TabControlChange(Sender: TObject);
//
  function RusDataName(Tag: Integer):String;
  begin
    if Tag<TabControl.Tabs.Count
      then Result := TabControl.Tabs[Tag]
      else Result := 'Записей в картотеке';
  end;
//
const
  ColCol: array [Boolean] of TColor = (clWindow, clBtnFace);
var
  NewDataX, CalcData1X, CalcData2X : TMemoTable;
  NewDataR: Integer;
  CalcValue  : Integer;
  I          : Integer;
  OldRow : Integer;
  CalcTip    : String;
begin
  if GridXView.Controller.EditingController.IsEditing then
    GridXView.Controller.EditingController.HideEdit(True);
  NewDataX := tables.GetByName('Data'+PagesMap[GetTabIndex]);
  //Calculate
  FCalculate.Clear;
  OldRow := GridXView.Controller.FocusedRowIndex;
  CalcTip := '';
  GetCalcDatasX(NewDataX, CalcData1X, CalcData2X);

  if Assigned(CalcData1X) then begin
    CalcTip := 'Вычислить:='+RusDataName(CalcData1X.Tag);
    if Assigned(CalcData2X) then CalcTip := CalcTip + ' - '+RusDataName(CalcData2X.Tag);

    NewDataR := 0;
    while NewDataR <= High(NewDataX.Data[0]) do begin
      for I := 2 to High(NewDataX.Data) do begin//0-POST_ID, 1-POST_TOTAL
        if Assigned(CalcData2X)
          then CalcValue := CalcData1X.Data[I, NewDataR]-CalcData2X.Data[I, NewDataR]
          else CalcValue := CalcData1X.Data[I, NewDataR];
        if CalcValue<>NewDataX.Data[I, NewDataR] then
          FCalculate.Add(Format('D:%s;P:%d;=%d',[
            Copy(NewDataX.ColumnNames[I],{DEP_}5,10),
            NewDataX.Data[0, NewDataR],
            CalcValue]));
      end;
      Inc(NewDataR);
    end;

  end;

  StatusBar.Panels[2].Text := CalcTip;
  //EOCalculate

  FillGrid('Data'+PagesMap[GetTabIndex]);
  GridXView.Controller.FocusedRowIndex := OldRow;

  for I := 0 to GridXView.ColumnCount-1 do with GridXView.Columns[I] do
  if Position.BandIndex=1 then begin
    GridXView.Columns[I].Options.Editing :=
      not (PagesRO[GetTabIndex] or not dmMain.rEdit);
    Color := ColCol[PagesRO[GetTabIndex] or not dmMain.rEdit];
  end;
end;

procedure TfmStaffList.UpdateRow(r: Integer = -1);
begin
  with GridXView.DataController do begin
    BeginUpdate;
    FillRow(ActiveTable, r);
    EndUpdate;
  end;
end;

procedure TfmStaffList.actRefreshExecute(Sender: TObject);
var
  OldRow: Integer;
begin
  if GridXView.Controller.EditingController.IsEditing then
    GridXView.Controller.EditingController.HideEdit(True);
  OldRow := GridXView.Controller.FocusedRowIndex;

  LoadData;

  GridXView.Controller.FocusedRowIndex := OldRow;

  TabControlChange(nil); //Recalculate;
end;

procedure TfmStaffList.DataXCalcFields(memo: TMemoTable; row: Integer);
var I, Total: Integer;
begin  //0-KeyID,1-Post_ID,2-Post_Name,3-Post_Total
  Total := 0;
  for I := 2 to High(memo.Data) do Inc(Total, memo.Data[I,row]);
  memo.Data[1, row] := Total;
end;

procedure TfmStaffList.DoValidate(Sender: TObject;
  var DisplayValue: TcxEditValue; var ErrorText: TCaption; var Error: Boolean);
begin
  try
    StrToInt(DisplayValue);
  except
    Error := True;
  end;
end;

procedure TfmStaffList.dxBBHideOldClick(Sender: TObject);
begin
  actRefreshExecute(Sender);
end;

procedure TfmStaffList.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
var
  NotRO: Boolean;
  FN: TcxCustomGridRow;
  FC: TcxGridBandedColumn;
  D,P,F: String; //D-Dep, P-Post,F-Field
//
  function CellIsChanged: Boolean;
  begin
    Result := (FC.Position.BandIndex=1) and (FChanged.IndexOfName(D+P+F)>=0);
  end;
//
  function ColumnIsChanged: Boolean;
  var I: Integer;
  begin
    Result := True;
    if FC.Position.BandIndex=1 then
    for I := 0 to FChanged.Count-1 do
      if (Pos(D,FChanged[I])>0) and (Pos(F,FChanged[I])>0) then Exit;
    Result := False;
  end;
//
  function RowIsChanged: Boolean;
  var I: Integer;
  begin
    Result := True;
    for I := 0 to FChanged.Count-1 do
      if (Pos(P,FChanged[I])>0) and (Pos(F,FChanged[I])>0) then Exit;
    Result := False;
  end;
//
  function PageIsChanged: Boolean;
  var I: Integer;
  begin
    Result := True;
    for I := 0 to FChanged.Count-1 do
      if Pos(F,FChanged[I])>0 then Exit;
    Result := False;
  end;
//
  function CanCalcCollumn: Boolean;
  var I: Integer;
  begin
    Result := True;
    for I := 0 to FCalculate.Count-1 do
    if Pos(D,FCalculate[I])>0 then Exit;
    Result := False;
  end;
//
  function CanCalcRow: Boolean;
  var I: Integer;
  begin
    Result := True;
    for I := 0 to FCalculate.Count-1 do
    if Pos(P,FCalculate[I])>0 then Exit;
    Result := False;
  end;
//
begin
  actStore.Enabled := FChanged.Count>0;

  NotRO := not PagesRO[GetTabIndex];
  FC := TcxGridBandedColumn(GridXView.Controller.FocusedColumn);
  FN := GridXView.Controller.FocusedRow;
  if Assigned(FN) then begin
    D := 'D:'+IntToStr(FC.Tag)+';';
    P := 'P:'+IntToStr(FN.Values[3])+';';
    F := 'F:'+IntToStr(GetTabIndex)+';';
  end;
  actRevertCell   .Enabled := Assigned(FN) and NotRO and CellIsChanged;
  actRevertColumn .Enabled := Assigned(FN) and NotRO and ColumnIsChanged;
  actRevertRow    .Enabled := Assigned(FN) and NotRO and RowIsChanged;
  actRevertAll    .Enabled := Assigned(FN) and NotRO and PageIsChanged;
  actRevert       .Enabled := actRevertAll.Enabled;

  actCalculate       .Enabled := Assigned(FN) and (FCalculate.Count>0);
  actCalculateCell   .Enabled := actCalculate.Enabled and (FCalculate.IndexOfName(D+P)>=0);
  actCalculateColumn .Enabled := actCalculate.Enabled and CanCalcCollumn;
  actCalculateRow    .Enabled := actCalculate.Enabled and CanCalcRow;
  actCalculateAll    .Enabled := actCalculate.Enabled;

  if actRevertCell.Enabled
    then StatusBar.Panels[0].Text := 'Старое значение: '+FChanged.Values[D+P+F]
    else StatusBar.Panels[0].Text := '';
  if actCalculateCell.Enabled
    then StatusBar.Panels[1].Text := 'Вычисляемое значение: '+FCalculate.Values[D+P]
    else StatusBar.Panels[1].Text := '';
  if not dmMain.rEdit then begin
    actCalculate       .Enabled := False;
    actCalculateCell   .Enabled := False;
    actCalculateColumn .Enabled := False;
    actCalculateRow    .Enabled := False;
    actCalculateAll    .Enabled := False;
  end;

  StatusBar1.SimpleText := 'Ячейка: ';
  if (Assigned(FN) and Assigned(FC)) then
    StatusBar1.SimpleText := StatusBar1.SimpleText + IntToStr(FN.RecordIndex+1)+' - '+FC.Caption;
end;

procedure TfmStaffList.actRevertExecute(Sender: TObject);
begin
//  Dummy
end;

procedure TfmStaffList.actCalculateExecute(Sender: TObject);
begin
//  Dummy
end;

procedure TfmStaffList.actRevertCellExecute(Sender: TObject);
var DEP_ID, POST_ID, I : Integer;
begin
  with ActiveTable do begin
    DEP_ID := GridXView.Controller.FocusedColumn.Tag;
    POST_ID := GridXView.Controller.FocusedRow.Values[3];
    I := FChanged.IndexOfName(Format('D:%d;P:%d;F:%d;',[DEP_ID, POST_ID, Tag]));
    FindRec(Post_Id);
    SetField('DEP_'+IntToStr(DEP_ID), StrToInt(FChanged.ValueFromIndex[I]));
    UpdateRow;
    FChanged.Delete(I);
  end;
  TabControlChange(nil); //Recalculate;
end;

procedure TfmStaffList.actRevertColumnExecute(Sender: TObject);
var
  DEP_ID    : String;
  D,F       : String;
  I         : Integer;
  ParseName : TStringList; //0-D:x, 1-P:x, 2-F:x, 3-=x
  OldRow : Integer;
begin
  if GridXView.Controller.EditingController.IsEditing then
    GridXView.Controller.EditingController.HideEdit(True);
  ParseName := TStringList.Create;
  try
    ParseName.Delimiter := ';';
    DEP_ID := IntToStr(GridXView.Controller.FocusedColumn.Tag);
    D      := 'D:'+DEP_ID+';';
    F      := 'F:'+IntToStr(GetTabIndex)+';';
    with ActiveTable do begin
      OldRow := GridXView.Controller.FocusedRowIndex;
      for I := FChanged.Count-1 downto 0 do
      if (Pos(D,FChanged[I])>0) and (Pos(F,FChanged[I])>0) then begin
        ParseName.DelimitedText := FChanged.Names[I];
        FindRec(StrToInt(Copy(ParseName[1],3,10)));
        SetField('DEP_'+DEP_ID, StrToInt(FChanged.ValueFromIndex[I]));
        UpdateRow;
        FChanged.Delete(I);
      end;
      GridXView.Controller.FocusedRowIndex := OldRow;
    end;
  finally ParseName.Free;
  end;
  TabControlChange(nil); //Recalculate;
end;

procedure TfmStaffList.actRevertRowExecute(Sender: TObject);
var
  PF  : String;
  I,J,R : Integer;
  POST_ID: Integer;
begin
  POST_ID := GridXView.Controller.FocusedRow.Values[3];
  PF := ';'+
        'P:'+IntToStr(POST_ID)+';'+
        'F:'+IntToStr(GetTabIndex)+';';
  with ActiveTable do begin
    r := FindRec(Post_ID);
    for I := 2 to High(Data) do begin //0-Post_ID,1-Post_Total
      J := FChanged.IndexOfName('D:'+Copy(ColumnNames[I], {DEP_x}5, 10)+PF);
      if J>=0 then begin
        Data[I, R] := StrToInt(FChanged.ValueFromIndex[J]);
        FChanged.Delete(J);
      end;
    end;
    UpdateRow(r);
  end;
  TabControlChange(nil); //Recalculate;
end;

procedure TfmStaffList.actRevertAllExecute(Sender: TObject);
var
  I, J    : Integer;
  OldRow, Row :Integer;
begin
  with ActiveTable do begin
    OldRow := GridXView.Controller.FocusedRowIndex;
    Row := 0;
    while Row <= High(Data[0]) do begin
      for I := 2 to High(Data) do begin
        J := FChanged.IndexOfName(Format('D:%s;P:%d;F:%d;',[
          Copy(ColumnNames[I], {DEP_x}5, 10),
          Data[0, Row],
          Tag]));
        if J>=0 then begin
          Data[I, Row] := StrToInt(FChanged.ValueFromIndex[J]);
          FChanged.Delete(J);
        end;
      end;
      UpdateRow(Row);
      Inc(Row);
    end;
    GridXView.Controller.FocusedRowIndex := OldRow;
  end;
  TabControlChange(nil); //Recalculate;
end;

procedure TfmStaffList.actCalculateCellExecute(Sender: TObject);
var
  I,  Val : Integer;
  D,P,F   : String;
  DEP_ID  : Integer;
  POST_ID : Integer;
begin
  DEP_ID := GridXView.Controller.FocusedColumn.Tag;
  POST_ID := GridXView.Controller.FocusedRow.Values[3];
  D := 'D:'+IntToStr(DEP_ID)+';';
  P := 'P:'+IntToStr(POST_ID)+';';
  F := 'F:'+IntToStr(ActiveTable.Tag)+';';

  I := FCalculate.IndexOfName(D+P);
  Val := StrToInt(FCalculate.ValueFromIndex[I]);
  ActiveTable.FindRec(Post_Id);
  ActiveTable.SetField('DEP_'+IntToStr(Dep_Id), Val);
  UpdateRow;

  FCalculate.Delete(I);

  if qrData.Locate('DEP_ID;POST_ID',VarArrayOf([DEP_ID, POST_ID]),[]) and
     (Val<>qrData.FieldByName(PagesMap[ActiveTable.Tag]).Value)
  then
    FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[ActiveTable.Tag]).AsString
  else begin
    I := FChanged.IndexOfName(D+P+F);
    if I>=0 then FChanged.Delete(I);
  end;

end;

procedure TfmStaffList.actCalculateColumnExecute(Sender: TObject);
var
  OldRow : Integer;
  POST_ID    : String;
  DEP_ID     : Integer;
  P,D,F      : String;
  I,J        : Integer;
  ParseName  : TStringList; //0-D:x, 1-P:x, 2-F:x, 3-=x
begin
  if GridXView.Controller.EditingController.IsEditing then
    GridXView.Controller.EditingController.HideEdit(True);
  ParseName := TStringList.Create;
  try
    ParseName.Delimiter := ';';
    DEP_ID := GridXView.Controller.FocusedColumn.Tag;
    D      := 'D:'+IntToStr(DEP_ID)+';';
    F      := 'F:'+IntToStr(GetTabIndex)+';';
    with ActiveTable do begin
      OldRow := GridXView.Controller.FocusedRowIndex;
      for I := FCalculate.Count-1 downto 0 do
      if Pos(D,FCalculate[I])>0 then begin
        ParseName.DelimitedText := FCalculate.Names[I];
        POST_ID := Copy(ParseName[1],3,10);
        P       := 'P:'+POST_ID+';';
        FindRec(StrToInt(POST_ID));
        SetField('DEP_'+IntToStr(DEP_ID), StrToInt(FCalculate.ValueFromIndex[I]));
        UpdateRow;

        if qrData.Locate('DEP_ID;POST_ID',VarArrayOf([DEP_ID, StrToInt(POST_ID)]),[]) and
           (FCalculate.ValueFromIndex[I]<>qrData.FieldByName(PagesMap[ActiveTable.Tag]).AsString)
        then
          FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[ActiveTable.Tag]).AsString
        else begin
          J := FChanged.IndexOfName(D+P+F);
          if J>=0 then FChanged.Delete(J);
        end;

        FCalculate.Delete(I);
      end;
      GridXView.Controller.FocusedRowIndex := OldRow;
    end;
  finally ParseName.Free;
  end;
end;

procedure TfmStaffList.actCalculateRowExecute(Sender: TObject);
var
  D,P,F   : String;
  DEP_ID  : String;
  POST_ID : Integer;
  I,J,K,R : Integer;
begin
  if GridXView.Controller.EditingController.IsEditing then
    GridXView.Controller.EditingController.HideEdit(True);
  POST_ID := GridXView.Controller.FocusedRow.Values[3];
  P := 'P:'+IntToStr(POST_ID)+';';
  F := 'F:'+IntToStr(GetTabIndex)+';';
  with ActiveTable do begin
    r := FindRec(POST_ID);
    for I := 2 to High(Data) do begin //0-Post_ID,1-Post_Total
      DEP_ID := Copy(ColumnNames[I], {DEP_x}5, 10);
      D := 'D:'+DEP_ID+';';
      J := FCalculate.IndexOfName(D+P);
      if J>=0 then begin
        Data[I, r] := StrToInt(FCalculate.ValueFromIndex[J]);

        if qrData.Locate('DEP_ID;POST_ID',VarArrayOf([StrToInt(DEP_ID), POST_ID]),[]) and
           (FCalculate.ValueFromIndex[J]<>qrData.FieldByName(PagesMap[ActiveTable.Tag]).AsString)
        then
          FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[ActiveTable.Tag]).AsString
        else begin
          K := FChanged.IndexOfName(D+P+F);
          if K>=0 then FChanged.Delete(K);
        end;

        FCalculate.Delete(J);
      end;
    end;
    SetField('Post_Id', GetField('Post_Id')); //чтобы сработал OnCalcFields
    UpdateRow(r);
  end;
end;

procedure TfmStaffList.actCalculateAllExecute(Sender: TObject);
var
  OldRow, Row : Integer;
  D,P,F      : String;
  DEP_ID     : String;
  POST_ID    : Integer;
  I,J,K      : Integer;
begin
  if GridXView.Controller.EditingController.IsEditing then
    GridXView.Controller.EditingController.HideEdit(True);
  OldRow := GridXView.Controller.FocusedRowIndex;
  F := 'F:'+IntToStr(GetTabIndex)+';';
  with ActiveTable do begin
    Row := 0;
    while Row <= High(Data[0]) do begin
      POST_ID := GetField('POST_ID', Row);
      P := 'P:'+IntToStr(POST_ID)+';';
      for I := 2 to High(Data) do begin //0-Post_ID,1-Post_Total
        DEP_ID := Copy(ColumnNames[I], {DEP_x}5, 10);
        D := 'D:'+DEP_ID+';';
        J := FCalculate.IndexOfName(D+P);
        if J>=0 then begin
          Data[I, Row] := StrToInt(FCalculate.ValueFromIndex[J]);

          if qrData.Locate('DEP_ID;POST_ID',VarArrayOf([StrToInt(DEP_ID), POST_ID]),[]) and
             (FCalculate.ValueFromIndex[J]<>qrData.FieldByName(PagesMap[ActiveTable.Tag]).AsString)
          then
            FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[ActiveTable.Tag]).AsString
          else begin
            K := FChanged.IndexOfName(D+P+F);
            if K>=0 then FChanged.Delete(K);
          end;

          FCalculate.Delete(J);
        end;
      end;
      UpdateRow(Row);
      Inc(Row);
    end;
    GridXView.Controller.FocusedRowIndex := OldRow;
  end;
end;

procedure TfmStaffList.FormCreate(Sender: TObject);
var I: Integer;
begin
  tables := TMemoTables.Create;

  FChanged   := TStringList.Create;
  FCalculate := TStringList.Create;
  FFormulas  := TStringList.Create;  for I := Low(PagesFormulas) to High(PagesFormulas) do FFormulas.Add(PagesFormulas[I]);
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain; ParamCheck := False;
    SQL.Text := 'SELECT * FROM KDEPART ORDER BY '+iifStr(dmMain.isAbcSort, 'Dep_Name', 'KDEPART_Num');
    Open;
    while not EOF do begin
      cbDeps.Items.AddObject(FieldByName('DEP_NAME').AsString,Pointer(FieldByName('DEP_ID').AsInteger));
      cbDeps.Checked[cbDeps.Items.Count-1] := True;
      Next;
    end;
    Close;
    SQL.Text := 'SELECT * FROM KPOST ' {+ IfThen(IAmStored, 'WHERE CPROF_ID <> 500', '')} +
                ' ORDER BY '+iifStr(dmMain.isAbcSort, 'Post_Name', 'KPOST_Num');
    Open;
    while not EOF do begin
      cbPosts.Items.AddObject(FieldByName('POST_NAME').AsString,Pointer(FieldByName('POST_ID').AsInteger));
      cbPosts.Checked[cbPosts.Items.Count-1] := True;
      Next;
    end;
  finally Free;
  end;
end;

procedure TfmStaffList.FormDestroy(Sender: TObject);
begin
  FChanged  .Free;
  FCalculate.Free;
  FFormulas .Free;
  tables.Free;
end;

procedure TfmStaffList.GridNumXGetDisplayText(Sender: TcxCustomGridTableItem;
  ARecord: TcxCustomGridRecord; var AText: string);
begin
  AText := IntToStr(ARecord.Index + 1);
end;

procedure TfmStaffList.GridXViewCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin

  if (AViewInfo.Item.Index <= 2)
  then
    ACanvas.Brush.Color := clBtnFace;

  if FChanged.IndexOfName(Format('D:%d;P:%d;F:%d;',[AViewInfo.Item.Tag, Integer(AViewInfo.GridRecord.Values[3]), GetTabIndex]))>=0
  then
    ACanvas.Font.Style := [fsBold];

  if (AViewInfo.Item.Index = 2) and (AViewInfo.Value <> 0)
  then
    ACanvas.Brush.Color := $88AA88;
  if (AViewInfo.Item.Index > 2) and (AViewInfo.Value <> 0)
  then
    ACanvas.Brush.Color := $DDFFDD;

  if FCalculate.IndexOfName(Format('D:%d;P:%d;',[AViewInfo.Item.Tag, Integer(AViewInfo.GridRecord.Values[3])]))>=0
  then
    ACanvas.Brush.Color := $DDDDFF;
end;

procedure TfmStaffList.GridXViewEditValueChanged(Sender: TcxCustomGridTableView;
  AItem: TcxCustomGridTableItem);
var
  DEP_ID, POST_ID      : Integer;
  D,P,F                : String;
  I,R                  : Integer;
  CalcValue            : Integer;
  CalcData1, CalcData2 : TMemoTable;
  Val: Integer;
begin
  Val := 0;
  try
    Val := StrToInt(GridXView.Controller.EditingController.Edit.EditingValue);
  except
    GridXView.Controller.EditingController.Edit.EditValue := '0';
  end;
  DEP_ID := GridXView.Controller.FocusedColumn.Tag;
  POST_ID := GridXView.Controller.FocusedRow.Values[3];
  D := 'D:'+IntToStr(DEP_ID)+';';
  P := 'P:'+IntToStr(POST_ID)+';';
  F := 'F:'+IntToStr(ActiveTable.Tag)+';';

  if (not qrData.Locate('DEP_ID;POST_ID',VarArrayOf([DEP_ID, POST_Id]),[])) or
     (Val<>qrData.FieldByName(PagesMap[ActiveTable.Tag]).Value)
  then begin
    FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[ActiveTable.Tag]).AsString
  end else begin
    I := FChanged.IndexOfName(D+P+F);
    if I>=0 then FChanged.Delete(I);
  end;
  GetCalcDatasX(ActiveTable, CalcData1,CalcData2);
  if Assigned(CalcData1) then begin
    CalcData1.FindRec(Post_Id);
    if Assigned(CalcData2) then begin
       CalcData2.FindRec(POST_ID);
       CalcValue := CalcData1.GetField('DEP_'+IntToStr(DEP_ID))
                   -CalcData2.GetField('DEP_'+IntToStr(DEP_ID));
    end
    else
      CalcValue := CalcData1.GetField('DEP_'+IntToStr(DEP_ID));
    if CalcValue<>Val then
      FCalculate.Values[D+P] := IntToStr(CalcValue)
    else begin
      I := FCalculate.IndexOfName(D+P);
      if I>=0 then FCalculate.Delete(I);
    end;
  end;

  r := ActiveTable.FindRec(Post_Id);
  ActiveTable.SetField('DEP_'+IntToStr(Dep_Id), Val);
  with GridXView.DataController do begin
    BeginUpdate;
    FillRow(ActiveTable, r);
    EndUpdate;
  end;

end;

procedure TfmStaffList.qrDataFieldSetText(Sender: TField;
  const Text: String);
begin
  Sender.Value := StrToIntDef(Text, 0); // Avoid nulls
end;

procedure TfmStaffList.actStoreExecute(Sender: TObject);
var
  OldRow : Integer;
  I,J, DataR        : Integer;
  Dep_Id: Integer;
  DataX, DataH: TMemoTable;
  HasData: Boolean;
begin
  OldRow := GridXView.Controller.FocusedRowIndex;

  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := 'DELETE FROM StaffList';
    ExecSQL;
    SQL.Text := ' SELECT DEP_ID, POST_ID';
    for I := 0 to PagesCount-1 do if not PagesRO[I] then
      SQL.Text := SQL.Text + ', '+PagesMap[I];
    SQL.Text := SQL.Text + ' FROM StaffList';
    Open;

    DataR := 0;
    while DataR <= High(ActiveTable.Data[0]) do begin
      for I := 2 to High(ActiveTable.Data) do begin //0-Post_ID,1-Post_Total
        Dep_Id := StrToInt(Copy(ActiveTable.ColumnNames[I], {DEP_x}5, 10));

        HasData := False;
        for J := 0 to PagesCount-1 do
          if not PagesRO[J] then begin
            DataX := tables.GetByName('Data'+PagesMap[J]);
            if Assigned(DataX) then
              if DataX.Data[I, DataR] <> 0 then begin
                HasData := True;
                Break;
              end;
          end;

        if HasData then begin
          Insert;
          FieldByName('DEP_ID' ).Value := Dep_Id;
          FieldByName('POST_ID').Value := ActiveTable.Data[0, DataR];
          for J := 0 to PagesCount-1 do
            if not PagesRO[J] then begin
              DataX := tables.GetByName('Data'+PagesMap[J]);
              if Assigned(DataX) then
                FieldByName(PagesMap[J]).Value := DataX.Data[I, DataR];
            end;
          Post;
        end;
      end;
      Inc(DataR);
    end;

    DataH := nil;
    for J := 0 to PagesCount-1 do
      if not PagesRO[J] then begin
        DataH := tables.GetByName('Data'+PagesMap[J]+'_hidden');
        if Assigned(DataH) then Break;
      end;

    if Assigned(DataH) then begin
      DataR := 0;
      while DataR <= High(DataH.Data[0]) do begin
        for I := 2 to High(DataH.Data) do begin //0-Post_ID,1-Post_Total
          HasData := False;
          for J := 0 to PagesCount-1 do
            if not PagesRO[J] then begin
              DataX := tables.GetByName('Data'+PagesMap[J]+'_hidden');
              if Assigned(DataX) then
                if DataX.Data[I, DataR] <> 0 then begin
                  HasData := True;
                  Break;
                end;
            end;

          if HasData then begin
            Insert;
            FieldByName('DEP_ID' ).Value := StrToInt(Copy(DataH.ColumnNames[I], {DEP_x}5, 10));
            FieldByName('POST_ID').Value := DataH.Data[0, DataR];
            for J := 0 to PagesCount-1 do
              if not PagesRO[J] then begin
                DataX := tables.GetByName('Data'+PagesMap[J]+'_hidden');
                if Assigned(DataX) then
                  FieldByName(PagesMap[J]).Value := DataX.Data[I, DataR];
              end;
            Post;
          end;
        end;
        Inc(DataR);
      end;
    end;

  finally Free;
  end;

  GridXView.Controller.FocusedRowIndex := OldRow;

  FChanged.Clear;
  actRefresh.Execute;
end;


procedure TfmStaffList.bDepsAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbDeps.Items.Count - 1 do
    cbDeps.Checked[i] := True;
end;

procedure TfmStaffList.bDepsNoneClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbDeps.Items.Count - 1 do
    cbDeps.Checked[i] := False;
end;

procedure TfmStaffList.bFilterClick(Sender: TObject);
begin
  Splitter1.Visible := bFilter.Down;
  Panel1.Visible := bFilter.Down;
end;

procedure TfmStaffList.bPostsAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbPosts.Items.Count - 1 do
    cbPosts.Checked[i] := True;
end;

procedure TfmStaffList.bPostsNoneClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbPosts.Items.Count - 1 do
    cbPosts.Checked[i] := False;
end;

procedure TfmStaffList.GetCalcDatasX(Data: TMemoTable; out CalcData1,
  CalcData2: TMemoTable);
var
  I: Integer;
  S: String;
begin
  CalcData1 := nil;  CalcData2 := nil;
  S := FFormulas.Values[Copy(Data.Name,5{Strip "Data" word},255)];
  if S='' then Exit;
  I := Pos('-',S);
  if I > 0 then begin
    CalcData1 := tables.GetByName('Data'+LeftStr(S, I-1));
    CalcData2 := tables.GetByName('Data'+Copy(S, I+1, 255));
  end
  else
    CalcData1 := tables.GetByName('Data'+S);
end;

function TfmStaffList.GetTabIndex: Integer;
begin
  with TabControl do Result := Integer(Tabs.Objects[Tabindex]);
end;

procedure TfmStaffList.CreateTabs;
var I: Integer;
begin
  TabControl.Tabs.Clear;
  for I := 0 to PagesCount-2 {last page is QtyAll - unvisible} do
  if PagesRO[I]<>IAmStored then TabControl.Tabs.AddObject(PagesTabs[I],TObject(I));
end;

procedure TfmStaffList.actExcelExecute(Sender: TObject);
begin
  //dmMain.GridToExcel(Grid,PagesTabs[GetTabIndex],False,True);
  if SaveDialog1.Execute then
    ExportGridToExcel(SaveDialog1.FileName, GridX, True, True, True, 'xls');

end;

initialization
  fmStaffList[False] := nil;
  fmStaffList[True]  := nil;
end.


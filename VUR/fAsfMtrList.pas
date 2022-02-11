unit fAsfMtrList;

interface

uses
  fSetFilter,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxCntner, dxTL, dxBar, ComCtrls, Db, ADODB, dxTLClms, ActnList, dxExEdtr,
  StdCtrls, Variants, dxDBCtrl, dxDBGrid, dxmdaset, Menus, cxClasses,
  ExtCtrls, Buttons, CheckLst, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxBarPainter, System.Actions;

type
  TfmAsfMtrList = class(TForm)
    StatusBar: TStatusBar;
    dxBarManager1: TdxBarManager;
    qrData: TADOQuery;
    ActionList1: TActionList;
    actStore: TAction;
    actClose: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    actCalculate: TAction;
    actRevert: TAction;
    TabControl: TTabControl;
    Grid: TdxDBGrid;
    GridPost_Name: TdxDBGridColumn;
    GridPost_Total: TdxDBGridColumn;
    dsData: TDataSource;
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
    GridNum: TdxDBGridColumn;
    bFilter: TdxBarButton;
    GridMtrType: TdxDBGridColumn;
    GridDeficit: TdxDBGridColumn;
    GridMtrTypeSub: TdxDBGridColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actCloseExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabControlChange(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure GridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure DataCalcFields(DataSet: TDataSet);
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
    procedure GridEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure qrDataFieldSetText(Sender: TField; const Text: String);
    procedure actStoreExecute(Sender: TObject);
    procedure actExcelExecute(Sender: TObject);
    procedure GridNumGetText(Sender: TObject; ANode: TdxTreeListNode;
      var AText: string);
    procedure GridColumnSorting(Sender: TObject; Column: TdxDBTreeListColumn;
      var Allow: Boolean);
    procedure GridCustomDrawColumnHeader(Sender: TObject;
      AColumn: TdxTreeListColumn; ACanvas: TCanvas; ARect: TRect;
      var AText: string; var AColor: TColor; AFont: TFont;
      var AAlignment: TAlignment; var ASorted: TdxTreeListColumnSort;
      var ADone: Boolean);
    procedure bFilterClick(Sender: TObject);
  protected
  private
    { Private declarations }
    FChanged   : TStringList;
    FCalculate : TStringList;
    FFormulas  : TStringList;
    procedure CreateTabs;
    procedure LoadData;
    procedure GetCalcDatas(Data: TDataSet; out CalcData1, CalcData2:TdxMemData);
    function GetTabIndex: Integer;
  public
    { Public declarations }
    FFiltered: Boolean;
    flt: TfxSetFilter;
  end;


  procedure ShowAsfMtrList;

implementation

uses dMain, msg, StrUtils, fMain;

{$R *.DFM}

const
  PagesCount = 3;
  PagesTabs: array [0..PagesCount-2] of String =
   ('Потребность (заявка)',
    'Распределение');
  PagesMap: array [0..PagesCount-1] of String =
   ('GeneralPlan',
    'GeneralQty',
    'QtyAll');
  PagesRO:  array [0..PagesCount-1] of Boolean =
   (False, //   ('GeneralPlan',
    False, //    'GeneralQty',
    True );//    'QtyAll');
  PagesFormulas:{FFormulas} array [1..1] of String = //result=d1{-d2}
   ('GeneralQty=GeneralPlan');
  PagesColHeaders: array [0..PagesCount-2] of String =
   ('Общая потребность',
    'Нераспределенный остаток');
var
  fmAsfMtrList: TfmAsfMtrList;

procedure ShowAsfMtrList;
const MyCaption: String =
  'Потребность (заявка) и распределение МТР для оснащения АСФ/подразделений АСФ';
begin
  if fmAsfMtrList=nil then begin
    Application.CreateForm(TfmAsfMtrList,fmAsfMtrList);
    if fmMain.MainScale <> 100 then
      fmAsfMtrList.ScaleBy(fmMain.MainScale, 100);
    with fmAsfMtrList do begin
      Caption := MyCaption;
      actStore     .Visible := True;
      actCalculate .Visible := True;
      actRevert    .Visible := True;
      CreateTabs;
      LoadData;
      TabControlChange(nil);
    end;
  end;
  if IsIconic(fmAsfMtrList.Handle) then
    ShowWindow(fmAsfMtrList.Handle,SW_RESTORE);
  fmAsfMtrList.BringToFront;
  fmAsfMtrList.HelpContext := 13;
end;


procedure TfmAsfMtrList.LoadData;
//
  procedure ClearGridColumns;
  var I: integer;
  begin
    for I := Grid.ColumnCount-1 downto 0 do
    if Grid.Columns[I].BandIndex=1 then Grid.Columns[I].Free;
  end;
//
  procedure CopyHiddenToOld;
  var
    I, J       : Integer;
    HiddenData, OldData : TdxMemData;
  begin
    for I := 0 to PagesCount-1 do begin
      HiddenData := FindComponent('Data'+PagesMap[I]+'_hidden') As TdxMemData;
      OldData := FindComponent('Data'+PagesMap[I]+'_Old') As TdxMemData;
      if Assigned(OldData) and Assigned(HiddenData) then begin
        HiddenData.First;
        while not HiddenData.Eof do begin
          OldData.Append;
          for J := 1 to HiddenData.FieldCount-1 do begin
            OldData.Fields[J].Value := HiddenData.Fields[J].Value;
          end;
          OldData.Post;
          HiddenData.Next;
        end;
      end;
    end;
  end;
//
  procedure CreateData;
  var
    I    : Integer;
    Data : TdxMemData;
  begin
    for I := 0 to PagesCount-1 do begin
      Data := FindComponent('Data'+PagesMap[I]) As TdxMemData;
      if Assigned(Data) then begin
        if PagesRO[I]
          then Data.Free
          else
            Data.Name := 'Data'+PagesMap[I]+'_Old';
      end;
      Data := TdxMemData.Create(Self);
      Data.Name := 'Data'+PagesMap[I];
      Data.OnCalcFields := DataCalcFields;
      Data.Tag := I;
    end;

    CopyHiddenToOld;

    for I := 0 to PagesCount-1 do begin
      Data := FindComponent('Data'+PagesMap[I]+'_hidden') As TdxMemData;
      if Assigned(Data) then
        Data.Free;
      Data := TdxMemData.Create(Self);
      Data.Name := 'Data'+PagesMap[I]+'_hidden';
      Data.OnCalcFields := DataCalcFields;
      Data.Tag := I;
    end;
  end;
//
  procedure AddDataField(FName: String; hidden: Boolean);
  var
    I      : Integer;
    AField : TField;
    s: String;
    IsAsf: Boolean;
  begin
    s := '';
    if hidden then s := '_hidden';

    IsAsf := StartsText('ASF_', FName);

    for I := 0 to PagesCount-1 do begin
      if not (SameText(FName,'MtrName') or SameText(FName,'KMtrName') or
              SameText(FName,'KMtrNameSub') or StartsText('ASPX_', FName))
        then begin
          AField := TIntegerField.Create(Self);
          if IsAsf or SameText(FName,'AsfMtr_Deficit') then
            AField.FieldKind := fkCalculated;
          if (not IsAsf) and (AnsiIndexText(FName,['AsfMtr_Id','MtrName','AsfMtr_Total','AsfMtr_Deficit'])<0) then
            AField.OnSetText := qrDataFieldSetText;
        end
        else begin
          AField := TStringField.Create(Self);
          AField.Size := 150;
          if StartsText('ASPX_', FName) then
            AField.FieldKind := fkCalculated;
        end;
      AField.FieldName := FName;
      AField.DataSet := FindComponent('Data'+PagesMap[I]+s) As TdxMemData;
    end;
  end;
//
  procedure OpenData;
  var
    I    : Integer;
    Data : TdxMemData;
  begin
    for I := 0 to PagesCount-1 do begin
      Data := FindComponent('Data'+PagesMap[I])  As TdxMemData;
      Data.Close;
      Data.Open;

      Data := FindComponent('Data'+PagesMap[I]+'_hidden')  As TdxMemData;
      Data.Close;
      Data.Open;
    end;
  end;
//
  procedure AddDataRecord(Post_ID: Integer; Post_Name, Post_Type, Post_TypeSub: String; total: Double; hidden: Boolean);
  var
    I    : Integer;
    Data : TdxMemData;
    s: String;
  begin
    s := '';
    if hidden then s := '_hidden';

    for I := 0 to PagesCount-1 do begin
      Data := FindComponent('Data'+PagesMap[I]+s)  As TdxMemData;
      Data.Append;
      Data.FieldByName('AsfMtr_Id').AsInteger := Post_ID;
      Data.FieldByName('MtrName').AsString := Post_Name;
      Data.FieldByName('KMtrName').AsString := Post_Type;
      Data.FieldByName('KMtrNameSub').AsString := Post_TypeSub;
      Data.FieldByName('AsfMtr_Total').AsFloat := total;
      Data.Post;
    end;
  end;
//
  procedure FillData;
  var
    I       : Integer;
    DataA, DataH : array of TdxMemData;
    POST_ID : Integer;
    sDEP_ID : String;
  begin
    SetLength(DataA, PagesCount);
    SetLength(DataH, PagesCount);
    for I := 0 to PagesCount-1 do begin
      DataA[I] := FindComponent('Data'+PagesMap[I]) As TdxMemData;
      DataH[I] := FindComponent('Data'+PagesMap[I]+'_hidden') As TdxMemData;
    end;
    qrData.First;
    while not qrData.Eof do begin
      POST_ID := qrData.FieldByName('AsfMtr_Id').AsInteger;
      if DataA[0].Locate('AsfMtr_Id', Post_ID, []) then begin
        DataA[0].Edit;
        for I := 1 to PagesCount-1 do begin
          DataA[I].RecNo := DataA[0].RecNo;
          DataA[I].Edit;
        end;
        while not qrData.Eof  and (POST_ID = qrData.FieldByName('AsfMtr_Id').AsInteger) do begin
          sDEP_ID := 'ASP_'+qrData.FieldByName('ASP_ID').AsString;
          for I := 0 to PagesCount-1 do
            DataA[I].FieldByName(sDEP_ID).AsInteger := qrData.FieldByName(PagesMap[I]).AsInteger;
          qrData.Next;
        end;
        for I := 0 to PagesCount-1 do DataA[I].Post;
      end else if DataH[0].Locate('AsfMtr_Id', Post_ID, []) then begin
        DataH[0].Edit;
        for I := 1 to PagesCount-1 do begin
          DataH[I].RecNo := DataH[0].RecNo;
          DataH[I].Edit;
        end;
        while not qrData.Eof  and (POST_ID = qrData.FieldByName('AsfMtr_Id').AsInteger) do begin
          sDEP_ID := 'ASP_'+qrData.FieldByName('ASP_ID').AsString;
          for I := 0 to PagesCount-1 do
            DataH[I].FieldByName(sDEP_ID).AsInteger := qrData.FieldByName(PagesMap[I]).AsInteger;
          qrData.Next;
        end;
        for I := 0 to PagesCount-1 do DataH[I].Post;
      end else
        qrData.Next;
    end;
  end;
//
  procedure UtilizeOldData;
  var
    I, J, K       : Integer;
    Data, OldData : TdxMemData;
    AField        : TField;
  begin
    with TStringList.Create do   //Old FChanged
    try
      Assign(FChanged); //FChanged.Clear;
      for I := 0 to PagesCount-1 do
      if not PagesRO [I] then begin
        OldData := FindComponent('Data'+PagesMap[I]+'_Old') As TdxMemData;
        if Assigned(OldData) then begin
          Data := FindComponent('Data'+PagesMap[I]) As TdxMemData;
          Data.First;
          while not Data.Eof do begin
            if OldData.Locate('AsfMtr_Id',Data.FieldByName('AsfMtr_Id').Value,[]) then begin
              Data.Edit;
              for J := 3 to Data.FieldCount-1 do begin
                K := IndexOfName(Format('D:%s;P:%d;F:%d;',[
                  Copy(Data.Fields[J].FieldName,5,10),//Strip 'DEP_'
                  Data.FieldByName('AsfMtr_Id').AsInteger,
                  Data.Tag]));
                if K>=0 then begin
                  //FChanged.Add(Strings[K]);
                  AField := OldData.FindField(Data.Fields[J].FieldName);
                  if Assigned(AField) then Data.Fields[J].Value := AField.Value;
                end;
              end;
              Data.Post;
            end;
            Data.Next;
          end;

          Data := FindComponent('Data'+PagesMap[I]+'_hidden') As TdxMemData;
          Data.First;
          while not Data.Eof do begin
            if OldData.Locate('AsfMtr_Id',Data.FieldByName('AsfMtr_Id').Value,[]) then begin
              Data.Edit;
              for J := 3 to Data.FieldCount-1 do begin
                K := IndexOfName(Format('D:%s;P:%d;F:%d;',[
                  Copy(Data.Fields[J].FieldName,5,10),//Strip 'DEP_'
                  Data.FieldByName('AsfMtr_Id').AsInteger,
                  Data.Tag]));
                if K>=0 then begin
                  //FChanged.Add(Strings[K]);
                  AField := OldData.FindField(Data.Fields[J].FieldName);
                  if Assigned(AField) then Data.Fields[J].Value := AField.Value;
                end;
              end;
              Data.Post;
            end;
            Data.Next;
          end;
          OldData.Free;
        end;
      end;
    finally Free;
    end;
  end;
//
var
  DepId, DepSubId, DepIdNew, DepSubIdNew, PostId, KPostId, ind: Integer;
  GenPlan, GenQty, GenPlan0, GenQty0: Integer;
  bmk: TBookmark;
  NoSubs: Boolean;
  q: TADOQuery;
begin
  dsData.DataSet := nil;

  ClearGridColumns;
  CreateData;
  AddDataField('AsfMtr_Id', True);
  AddDataField('MtrName', True);
  AddDataField('KMtrName', True);
  AddDataField('KMtrNameSub', True);
  AddDataField('AsfMtr_Total', True);
  AddDataField('AsfMtr_Deficit', True);
  AddDataField('AsfMtr_Id', False);
  AddDataField('MtrName', False);
  AddDataField('KMtrName', False);
  AddDataField('KMtrNameSub', False);
  AddDataField('AsfMtr_Total', False);
  AddDataField('AsfMtr_Deficit', False);

  q := TADOQuery.Create(Self);
  with q do
  try
    Connection := dmMain.dbMain; ParamCheck := False;
//    SQL.Text := 'DELETE * FROM STAFFLIST WHERE NOT DEP_ID IN (SELECT DEP_ID FROM KDEPART) OR NOT POST_ID IN (SELECT POST_ID FROM KPOST)';
//    ExecSQL;
    SQL.Text := 'DELETE * FROM ASMtrList sl WHERE '+
      'NOT EXISTS (SELECT ASP_ID FROM ASP WHERE ASP_ID = sl.ASP_ID) and '+
      'NOT EXISTS (SELECT ASF_ID FROM ASF WHERE ASF_ID = -sl.ASP_ID)';
    ExecSQL;
    SQL.Text := 'select * from ( '+
      'SELECT ASP.ASP_ID, ASP.ASF_Id, ASP.DEP_NAME, '+
        'Iif(IsNull(OrgSName), OrgName, OrgSName)+''1'' As SortName, '+
      '  ASP.ASP_Num, ASP.Name as ASP_Name, '+
      '  Sum(GeneralPlan) As GenPlan, Sum(QtyAll) As GenQty '+
      'FROM ((ASP Inner Join ASF on ASF.ASF_ID = ASP.ASF_ID) Left Join ASStaffListAll As list on list.ASP_ID = ASP.ASP_ID) '+
      'Group By ASP.ASP_ID, ASP.ASF_Id, ASP.DEP_NAME, '+
        'Iif(IsNull(OrgSName), OrgName, OrgSName), '+
        'ASP.ASP_Num, ASP.Name '+
      'union '+
      'SELECT -ASF.ASF_ID As ASP_ID, null As ASF_Id, '+
        'Iif(IsNull(OrgSName), OrgName, OrgSName) As Dep_Name, '+
        'Iif(IsNull(OrgSName), OrgName, OrgSName) As SortName, '+
      '  -1 As ASP_Num, '''' as ASP_Name, '+
      '  Sum(GeneralPlan) As GenPlan, Sum(QtyAll) As GenQty '+
      'FROM ASF Left Join ASStaffListAll As list on list.ASP_ID = -ASF.ASF_ID '+
      'Group By -ASF.ASF_ID, '+
        'Iif(IsNull(OrgSName), OrgName, OrgSName)) as x '+
      'ORDER BY SortName, '+iifStr(dmMain.isAbcSort, 'ASP_Name', 'ASP_Num');
    Open;
    while not EOF do begin
      DepId := FieldByName('ASF_ID').AsInteger;
      DepSubId := FieldByName('ASP_ID').AsInteger;
      ind := flt.cbDeps.Items.IndexOfObject(Pointer(DepId));
      if ind < 0 then
        ind := flt.cbDeps.Items.IndexOfObject(Pointer(-DepSubId));
      NoSubs := True;
      if DepSubId < 0 then begin
        DepIdNew := 0;
        bmk := GetBookmark;
        DepSubIdNew := -DepSubId;
        GenPlan0 := FieldByName('GenPlan').AsInteger;
        GenQty0 := FieldByName('GenQty').AsInteger;
        Next;
        if not Eof then begin
          DepIdNew := FieldByName('ASF_ID').AsInteger;
          if DepIdNew = -DepSubId then begin
            GenPlan := GenPlan0; GenQty := GenQty0;
            while (DepSubIdNew = FieldByName('ASF_ID').AsInteger) and not Eof do begin
              Inc(GenPlan, FieldByName('GenPlan').AsInteger);
              Inc(GenQty, FieldByName('GenQty').AsInteger);
              Next;
            end;
          end;
        end;
        GotoBookmark(bmk);
        if DepIdNew = -DepSubId then begin
          NoSubs := False;

          AddDataField('ASF_'+IntToStr(-DepSubId), False);
          AddDataField('ASF_'+IntToStr(-DepSubId), True);
          if (not FFiltered) or flt.cbDeps.Checked[ind] then begin
            with Grid.CreateColumn(TdxDBGridColumn) as  TdxDBGridColumn do begin
              BandIndex := 1;
              SummaryFooterFormat := '0';
              SummaryFooterType := cstSum;
              Width := 120;
              Caption := FieldByName('DEP_NAME').AsString+#13+
                '(ш '+IntToStr(GenPlan)+' / ф '+IntToStr(GenQty)+')';
              Tag := DepSubId;
              FieldName := 'ASF_'+IntToStr(-DepSubId);
              DisableEditor := True;
              ReadOnly := True;
            end;
          end;
        end;
      end;
      AddDataField('ASP_'+FieldByName('ASP_ID').AsString, False);
      AddDataField('ASP_'+FieldByName('ASP_ID').AsString, True);
      AddDataField('ASPX_'+FieldByName('ASP_ID').AsString, False);
      AddDataField('ASPX_'+FieldByName('ASP_ID').AsString, True);
      if (not FFiltered) or flt.cbDeps.Checked[ind] then begin
        with Grid.CreateColumn(TdxDBGridColumn) as  TdxDBGridColumn do begin
          BandIndex := 1;
          SummaryFooterFormat := '0';
          SummaryFooterType := cstSum;
          Width := 120;
          if (DepSubId < 0) and not NoSubs then begin
            Caption := '(штаб)'#13+
              '(ш '+FieldByName('GenPlan').AsString+' / ф '+FieldByName('GenQty').AsString+')';
          end else begin
            Caption := FieldByName('DEP_NAME').AsString+#13+
              '(ш '+FieldByName('GenPlan').AsString+' / ф '+FieldByName('GenQty').AsString+')';
          end;
          Tag := FieldByName('ASP_ID').AsInteger;
          FieldName := 'ASP_'+IntToStr(Tag);
        end;
        with Grid.CreateColumn(TdxDBGridColumn) as  TdxDBGridColumn do begin
          BandIndex := 1;
          Width := 50;
          Caption := 'потребность (%удовл.)'#13;
          Tag := FieldByName('ASP_ID').AsInteger;
          FieldName := 'ASPX_'+IntToStr(Tag);
          Visible := False;
        end;
      end;
      Next;
    end;
    Close;
    OpenData;
    SQL.Text :=
      'SELECT AsfMtr.Id as AsfMtr_Id, KAsfMtr.Id as KAsfMtr_Id, KAsfMtrSub.Id as KAsfMtrSub_Id, '+
      ' Iif((AsfMtr.ShortName is null), AsfMtr.FullName, AsfMtr.ShortName) As NameX, '+
      ' Iif((KAsfMtr.ShortName is null), KAsfMtr.Name, KAsfMtr.ShortName) As NameType, '+
      ' KAsfMtrSub.Name As NameTypeSub, '+
      ' Sum(Org_Mtr.AmountAsf) As Total '+
      'FROM ((AsfMtr '+
      ' Inner Join KAsfMtr on KAsfMtr.Id = AsfMtr.KAsfMtr_Id) '+
      ' left Join KAsfMtrSub on KAsfMtrSub.Id = AsfMtr.KAsfMtrSub_Id) '+
      ' Left Join Org_Mtr on AsfMtr.Id = Org_Mtr.AsfMtr_Id '+
      'Group BY '+
      ' AsfMtr.Id, KAsfMtr.Id, KAsfMtrSub.Id, '+
      ' Iif((KAsfMtr.ShortName is null), KAsfMtr.Name, KAsfMtr.ShortName), KAsfMtrSub.Name, '+
      ' Iif((AsfMtr.ShortName is null), AsfMtr.FullName, AsfMtr.ShortName) '+
      'ORDER BY '+
      ' Iif((KAsfMtr.ShortName is null), KAsfMtr.Name, KAsfMtr.ShortName), KAsfMtrSub.Name, '+
      ' Iif((AsfMtr.ShortName is null), AsfMtr.FullName, AsfMtr.ShortName) ';
    Open;
    while not EOF do begin
      PostId := FieldByName('AsfMtr_ID').AsInteger;
      KPostId := FieldByName('KAsfMtr_ID').AsInteger;
      if (not FFiltered) or flt.cbPosts.Checked[flt.cbPosts.Items.IndexOfObject(Pointer(KPostId))] then begin
        AddDataRecord(
          FieldByName('AsfMtr_ID').AsInteger, FieldByName('NameX').AsString,
          FieldByName('NameType').AsString, FieldByName('NameTypeSub').AsString,
          FieldByName('Total').AsFloat, False);
      end else begin
        AddDataRecord(
          FieldByName('AsfMtr_ID').AsInteger, FieldByName('NameX').AsString,
          FieldByName('NameType').AsString, FieldByName('NameTypeSub').AsString,
          FieldByName('Total').AsFloat, True);
      end;
      Next;
    end;
  finally Free;
  end;
  qrData.Close;//on refresh
  qrData.Open;
  FillData;
  UtilizeOldData;
  dsData.DataSet := FindComponent('Data'+PagesMap[GetTabIndex])  As TdxMemData;
end;


procedure TfmAsfMtrList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := (FChanged.Count=0) or Confirm('Закрыть окно без сохранения данных?');
end;

procedure TfmAsfMtrList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  fmAsfMtrList := nil;
end;

procedure TfmAsfMtrList.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmAsfMtrList.TabControlChange(Sender: TObject);
//
  function RusDataName(Data: TDataSet):String;
  begin
    if Data.Tag<TabControl.Tabs.Count
      then Result := TabControl.Tabs[Data.Tag]
      else Result := 'Записей в картотеке';
  end;
//
const
  ColCol: array [Boolean] of TColor = (clWindow, clBtnFace);
var
  NewData, CalcData1, CalcData2 : TdxMemData;
  CalcValue  : Integer;
  I          : Integer;
  OldPOST_ID : Integer;
  CalcTip    : String;
begin
  if Assigned(Grid.InplaceEditor) and Grid.InplaceEditor.IsVisible then
    Grid.CloseEditor;
  NewData := FindComponent('Data'+PagesMap[GetTabIndex]) As TdxMemData;
  //Calculate
  FCalculate.Clear;
  OldPOST_ID := dsData.DataSet.FieldByName('AsfMtr_Id').AsInteger; //NOTE: On recalculate NewData is oldData
  CalcTip := '';
  GetCalcDatas(NewData, CalcData1, CalcData2);
  if Assigned(CalcData1) then begin
    CalcTip := 'Вычислить:='+RusDataName(CalcData1);
    if Assigned(CalcData2) then CalcTip := CalcTip + ' - '+RusDataName(CalcData2);
    NewData.First; CalcData1.First; if Assigned(CalcData2) then CalcData2.First;
    while not NewData.Eof do begin
      for I := 7 to NewData.FieldCount-1 do begin//0-KeyID, 1-POST_ID, 2-POST_NAME, 3-POST_TOTAL
        if CalcData1.Fields[I].FieldKind <> fkCalculated then begin
          if Assigned(CalcData2)
            then CalcValue := CalcData1.Fields[I].AsInteger-CalcData2.Fields[I].AsInteger
            else CalcValue := CalcData1.Fields[I].AsInteger;
          if CalcValue<>NewData.Fields[I].AsInteger then
            FCalculate.Add(Format('D:%s;P:%d;=%d',[
              Copy(NewData.Fields[I].FieldName,{DEP_}5,10),
              NewData.FieldByName('AsfMtr_Id').AsInteger,
              CalcValue]));
        end;
      end;
      NewData.Next; CalcData1.Next; if Assigned(CalcData2) then CalcData2.Next;
    end;
  end;
  StatusBar.Panels[2].Text := CalcTip;
  //EOCalculate
  NewData.Locate('AsfMtr_Id', OldPOST_ID, []);
  dsData.DataSet := NewData;
  for I := 0 to Grid.ColumnCount-1 do with Grid.Columns[I] do
  if BandIndex=1 then begin
    DisableEditor :=
      PagesRO[GetTabIndex] or (not dmMain.rEdit) or
      StartsText('ASF_', FieldName) or StartsText('ASPX_', FieldName);
    Color := ColCol[PagesRO[GetTabIndex] or not dmMain.rEdit];
    if StartsText('ASPX_', FieldName) then
      Visible := (GetTabIndex > 0);
  end;

  GridDeficit.Caption := PagesColHeaders[GetTabIndex];

  Grid.Refresh;
  Grid.FullExpand;
end;

procedure TfmAsfMtrList.actRefreshExecute(Sender: TObject);
var POST_ID: Integer;
begin
  if Assigned(Grid.InplaceEditor) and Grid.InplaceEditor.IsVisible then
    Grid.CloseEditor;
  POST_ID := dsData.DataSet.FieldByName('AsfMtr_Id').AsInteger;
  LoadData;
  dsData.DataSet.Locate('AsfMtr_Id',POST_ID,[]);
  TabControlChange(nil); //Recalculate;
end;

procedure TfmAsfMtrList.GridColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := Column <> GridNum;
end;

procedure TfmAsfMtrList.GridCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
var
  MyNode: TdxDBGridNode absolute ANode;
  MyColumn: TdxDBGridColumn absolute AColumn;
begin
  if not Assigned(ANode.Parent) then begin
    AFont.Style := [fsBold];
    Exit;
  end;
  if not Assigned(ANode.Parent.Parent) then begin
    AFont.Style := [fsItalic];
    if Trim(AText) = 'Подвид МТР :' then
      AText := '';
    Exit;
  end;
  AFont.Style := [];

  if StartsText('ASPX_', MyColumn.FieldName) then begin
    AColor := $DDDDDD;
    Exit;
  end;

  if FChanged.IndexOfName(Format('D:%d;P:%d;F:%d;',[MyColumn.Tag, Integer(MyNode.Id), GetTabIndex]))>=0
  then
    AFont.Style := [fsBold];

  if (MyColumn.Index = 4) and (MyNode.Values[MyColumn.Index] <> 0)
  then
    AColor := $88AA88;
  if (MyColumn.Index = 5) and (MyNode.Values[MyColumn.Index] <> 0)
  then begin
    if ((Grid.DataSource.DataSet.Tag = 0) and (MyNode.Values[5] <= MyNode.Values[4])) or
       ((Grid.DataSource.DataSet.Tag > 0) and (MyNode.Values[MyColumn.Index] > 0)) then
      AColor := $88AA88
    else
      AColor := $8888AA;
  end;
  if (MyColumn.Index > 5) and (MyNode.Values[MyColumn.Index] <> 0)
  then
    AColor := $DDFFDD;

  if FCalculate.IndexOfName(Format('D:%d;P:%d;',[MyColumn.Tag, Integer(MyNode.Id)]))>=0
  then
    AColor := $DDDDFF;

  if (MyColumn.Index > 5) and AColumn.DisableEditor
  then
    AColor := clLtGray;
end;

procedure TfmAsfMtrList.GridCustomDrawColumnHeader(Sender: TObject;
  AColumn: TdxTreeListColumn; ACanvas: TCanvas; ARect: TRect; var AText: string;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
  var ASorted: TdxTreeListColumnSort; var ADone: Boolean);
begin
  AFont.Size := 8;
  if AColumn.Tag > 0 then
    AFont.Style := []
  else if StartsText('ASPX_', TdxDBGridColumn(AColumn).FieldName) then begin
    AFont.Size := 6;
    AFont.Style := []
  end else if StartsText('(штаб)',AColumn.Caption) then
    AFont.Style := [fsItalic]
  else
    AFont.Style := [fsBold];
end;

procedure TfmAsfMtrList.DataCalcFields(DataSet: TDataSet);
var
  I, Total, iSub, TotalSub: Integer;
  was, moved: Boolean;
  ds: TDataSet;
  s: String;
  bmk: TBookmark;
begin  //0-KeyID,1-Post_ID,2-Post_Name,3-Post_Total
  Total := 0; iSub := -1; TotalSub := 0; was := False;
  for I := 7 to DataSet.FieldCount-1 do begin
    if DataSet.Fields[I].FieldKind = fkCalculated then begin
      if StartsText('ASPX_', DataSet.Fields[I].FieldName) then begin
        if (DataSet.Tag = 1) and (not EndsText('_Old', DataSet.Name)) then begin
          ds := FindComponent(StringReplace(DataSet.Name, 'GeneralQty', 'GeneralPlan', [rfReplaceAll])) as TDataSet;
          moved := False;
          if ds.RecNo <> DataSet.RecNo then begin
            bmk := ds.Bookmark;
            ds.RecNo := DataSet.RecNo;
            moved := True;
          end;
          s := ds.Fields[I-1].AsString;
          if (not ds.Fields[I-1].IsNull) and (ds.Fields[I-1].AsInteger <> 0) and (not DataSet.Fields[I-1].IsNull) then
            s := s + ' ('+
              IntToStr(Round(100*DataSet.Fields[I-1].AsFloat/ds.Fields[I-1].AsFloat))+
              '%)';
          DataSet.Fields[I].AsString := s;
          if moved then ds.GotoBookmark(bmk);
        end;
      end else begin
        if iSub > 0 then
          DataSet.Fields[iSub].AsInteger := TotalSub;
        iSub := i; TotalSub := 0; was := False;
      end;
    end else begin
      Inc(Total, DataSet.Fields[I].AsInteger);
      if StartsText('ASP_-', DataSet.Fields[I].FieldName) then begin
        if was then begin
          if iSub > 0 then
            DataSet.Fields[iSub].AsInteger := TotalSub;
            iSub := -1;
        end else begin
          was := True;
          Inc(TotalSub, DataSet.Fields[I].AsInteger);
        end;
      end else
        Inc(TotalSub, DataSet.Fields[I].AsInteger);
    end;
  end;
  if DataSet.Tag = 0 then
    DataSet.FieldByName('AsfMtr_Deficit').AsInteger := Total
  else
    DataSet.FieldByName('AsfMtr_Deficit').AsInteger :=
      DataSet.FieldByName('AsfMtr_Total').AsInteger - Total;
  if iSub > 0 then
    DataSet.Fields[iSub].AsInteger := TotalSub;
end;

procedure TfmAsfMtrList.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
var
  NotRO: Boolean;
  FN: TdxDBGridNode;
  FC: TdxDBGridColumn;
  D,P,F: String; //D-Dep, P-Post,F-Field
//
  function CellIsChanged: Boolean;
  begin
    Result := (FC.BandIndex=1) and (FChanged.IndexOfName(D+P+F)>=0);
  end;
//
  function ColumnIsChanged: Boolean;
  var I: Integer;
  begin
    Result := True;
    if FC.BandIndex=1 then
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
  FN    := Grid.FocusedNode as TdxDBGridNode;
  FC    := Grid.Columns[Grid.FocusedAbsoluteIndex] as TdxDBGridColumn;
  if Assigned(FN) then begin
    D := 'D:'+IntToStr(FC.Tag)+';';
    P := 'P:'+IntToStr(FN.Id)+';';
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
    StatusBar1.SimpleText := StatusBar1.SimpleText + FN.Strings[0]+' - '+FC.Caption;
end;

procedure TfmAsfMtrList.actRevertExecute(Sender: TObject);
begin
//  Dummy
end;

procedure TfmAsfMtrList.actCalculateExecute(Sender: TObject);
begin
//  Dummy
end;

procedure TfmAsfMtrList.actRevertCellExecute(Sender: TObject);
var DEP_ID, POST_ID, I : Integer;
begin
  with Grid.DataSource.DataSet do begin
    DEP_ID  := Grid.Columns[Grid.FocusedAbsoluteIndex].Tag;
    POST_ID := (Grid.FocusedNode as TdxDBGridNode).Id;
    I := FChanged.IndexOfName(Format('D:%d;P:%d;F:%d;',[DEP_ID, POST_ID, Tag]));
    Edit;
    FieldByName('ASP_'+IntToStr(DEP_ID)).Value := StrToInt(FChanged.ValueFromIndex[I]);
    Post;
    FChanged.Delete(I);
  end;
  TabControlChange(nil); //Recalculate;
end;

procedure TfmAsfMtrList.actRevertColumnExecute(Sender: TObject);
var
  POST_ID   : Integer;
  DEP_ID    : String;
  D,F       : String;
  I         : Integer;
  ParseName : TStringList; //0-D:x, 1-P:x, 2-F:x, 3-=x
begin
  if Assigned(Grid.InplaceEditor) and Grid.InplaceEditor.IsVisible then
    Grid.CloseEditor;
  ParseName := TStringList.Create;
  try
    ParseName.Delimiter := ';';
    DEP_ID := IntToStr((Grid.Columns[Grid.FocusedAbsoluteIndex] as TdxDBGridColumn).Tag);
    D      := 'D:'+DEP_ID+';';
    F      := 'F:'+IntToStr(GetTabIndex)+';';
    with Grid.DataSource.DataSet do begin
      POST_ID := FieldByName('AsfMtr_Id').AsInteger;
      for I := FChanged.Count-1 downto 0 do
      if (Pos(D,FChanged[I])>0) and (Pos(F,FChanged[I])>0) then begin
        ParseName.DelimitedText := FChanged.Names[I];
        Locate('AsfMtr_Id',StrToInt(Copy(ParseName[1],3,10)),[]);
        Edit;
        FieldByName('ASP_'+DEP_ID).Value := StrToInt(FChanged.ValueFromIndex[I]);
        Post;
        FChanged.Delete(I);
      end;
      Locate('AsfMtr_Id',POST_ID,[]);
    end;
  finally ParseName.Free;
  end;
  TabControlChange(nil); //Recalculate;
end;

procedure TfmAsfMtrList.actRevertRowExecute(Sender: TObject);
var
  PF  : String;
  I,J : Integer;
begin
  PF := ';'+
        'P:'+IntToStr((Grid.FocusedNode as TdxDBGridNode).Id)+';'+
        'F:'+IntToStr(GetTabIndex)+';';
  with Grid.DataSource.DataSet do begin
    Edit;
    for I := 7 to FieldCount-1 do begin //0-KeyID,1-Post_ID,2-Post_Name,3-Post_Total
      J := FChanged.IndexOfName('D:'+Copy(Fields[I].FieldName, {DEP_x}5, 10)+PF);
      if J>=0 then begin
        Fields[I].Value := StrToInt(FChanged.ValueFromIndex[J]);
        FChanged.Delete(J);
      end;
    end;
    Post;
  end;
  TabControlChange(nil); //Recalculate;
end;

procedure TfmAsfMtrList.actRevertAllExecute(Sender: TObject);
var
  I, J    : Integer;
  POST_ID : Integer;
begin
  with Grid.DataSource.DataSet do begin
    POST_ID := FieldbyName('AsfMtr_Id').AsInteger;
    First;
    while not Eof do begin
      Edit;
      for I := 7 to FieldCount-1 do begin
        J := FChanged.IndexOfName(Format('D:%s;P:%d;F:%d;',[
          Copy(Fields[I].FieldName, {DEP_x}5, 10),
          FieldByName('AsfMtr_Id').AsInteger,
          Tag]));
        if J>=0 then begin
          Fields[I].Value := StrToInt(FChanged.ValueFromIndex[J]);
          FChanged.Delete(J);
        end;
      end;
      Post;
      Next;
    end;
    Locate('AsfMtr_Id', POST_ID, []);
  end;
  TabControlChange(nil); //Recalculate;
end;

procedure TfmAsfMtrList.actCalculateCellExecute(Sender: TObject);
var
  I       : Integer;
  D,P,F   : String;
  DEP_ID  : Integer;
  POST_ID : Integer;
begin
  DEP_ID  := Grid.Columns[Grid.FocusedAbsoluteIndex].Tag;
  POST_ID := (Grid.FocusedNode as TdxDBGridNode).Id;
  D := 'D:'+IntToStr(DEP_ID)+';';
  P := 'P:'+IntToStr(POST_ID)+';';
  F := 'F:'+IntToStr(dsData.DataSet.Tag)+';';

  I := FCalculate.IndexOfName(D+P);
  with dsData.DataSet do begin
    Edit;
    FieldByName((Grid.Columns[Grid.FocusedAbsoluteIndex] as TdxDBGridColumn).FieldName).
      AsInteger := StrToInt(FCalculate.ValueFromIndex[I]);
    Post;
  end;
  FCalculate.Delete(I);

  if qrData.Locate('ASP_ID;AsfMtr_Id',VarArrayOf([DEP_ID, POST_ID]),[]) and
     (StrToInt(Grid.FocusedNode.Strings[Grid.FocusedAbsoluteIndex])<>qrData.FieldByName(PagesMap[dsData.DataSet.Tag]).Value)
  then
    FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[dsData.DataSet.Tag]).AsString
  else begin
    I := FChanged.IndexOfName(D+P+F);
    if I>=0 then FChanged.Delete(I);
  end;
end;

procedure TfmAsfMtrList.actCalculateColumnExecute(Sender: TObject);
var
  OldPOST_ID : Integer;
  POST_ID    : String;
  DEP_ID     : Integer;
  P,D,F      : String;
  I,J        : Integer;
  ParseName  : TStringList; //0-D:x, 1-P:x, 2-F:x, 3-=x
begin
  if Assigned(Grid.InplaceEditor) and Grid.InplaceEditor.IsVisible then
    Grid.CloseEditor;
  ParseName := TStringList.Create;
  try
    ParseName.Delimiter := ';';
    DEP_ID := (Grid.Columns[Grid.FocusedAbsoluteIndex] as TdxDBGridColumn).Tag;
    D      := 'D:'+IntToStr(DEP_ID)+';';
    F      := 'F:'+IntToStr(GetTabIndex)+';';
    with dsData.DataSet do begin
      OldPOST_ID := FieldByName('AsfMtr_Id').AsInteger; //Save position in grid
      for I := FCalculate.Count-1 downto 0 do
      if Pos(D,FCalculate[I])>0 then begin
        ParseName.DelimitedText := FCalculate.Names[I];
        POST_ID := Copy(ParseName[1],3,10);
        P       := 'P:'+POST_ID+';';
        Locate('AsfMtr_Id',POST_ID,[]);
        Edit;
        FieldByName('ASP_'+IntToStr(DEP_ID)).Value := StrToInt(FCalculate.ValueFromIndex[I]);
        Post;

        if qrData.Locate('ASP_ID;AsfMtr_Id',VarArrayOf([DEP_ID, StrToInt(POST_ID)]),[]) and
           (FCalculate.ValueFromIndex[I]<>qrData.FieldByName(PagesMap[dsData.DataSet.Tag]).AsString)
        then
          FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[dsData.DataSet.Tag]).AsString
        else begin
          J := FChanged.IndexOfName(D+P+F);
          if J>=0 then FChanged.Delete(J);
        end;

        FCalculate.Delete(I);
      end;
      Locate('AsfMtr_Id',OldPOST_ID,[]);
    end;
  finally ParseName.Free;
  end;
end;

procedure TfmAsfMtrList.actCalculateRowExecute(Sender: TObject);
var
  D,P,F   : String;
  DEP_ID  : String;
  POST_ID : Integer;
  I,J,K   : Integer;
begin
  if Assigned(Grid.InplaceEditor) and Grid.InplaceEditor.IsVisible then
    Grid.CloseEditor;
  POST_ID := (Grid.FocusedNode as TdxDBGridNode).Id;
  P := 'P:'+IntToStr(POST_ID)+';';
  F := 'F:'+IntToStr(GetTabIndex)+';';
  with dsData.DataSet do begin
    Edit;
    for I := 7 to FieldCount-1 do begin //0-KeyID,1-Post_ID,2-Post_Name,3-Post_Total
      if Fields[I].FieldKind <> fkCalculated then begin
        DEP_ID := Copy(Fields[I].FieldName, {DEP_x}5, 10);
        D := 'D:'+DEP_ID+';';
        J := FCalculate.IndexOfName(D+P);
        if J>=0 then begin
          Fields[I].Value := StrToInt(FCalculate.ValueFromIndex[J]);

          if qrData.Locate('ASP_ID;AsfMtr_Id',VarArrayOf([StrToInt(DEP_ID), POST_ID]),[]) and
             (FCalculate.ValueFromIndex[J]<>qrData.FieldByName(PagesMap[dsData.DataSet.Tag]).AsString)
          then
            FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[dsData.DataSet.Tag]).AsString
          else begin
            K := FChanged.IndexOfName(D+P+F);
            if K>=0 then FChanged.Delete(K);
          end;

          FCalculate.Delete(J);
        end else
          Fields[I].Clear;
      end;
    end;
    Post;
  end;
end;

procedure TfmAsfMtrList.actCalculateAllExecute(Sender: TObject);
var
  OldPOST_ID : Integer;
  D,P,F      : String;
  DEP_ID     : String;
  POST_ID    : Integer;
  I,J,K      : Integer;
begin
  if Assigned(Grid.InplaceEditor) and Grid.InplaceEditor.IsVisible then
    Grid.CloseEditor;
  OldPOST_ID := (Grid.FocusedNode as TdxDBGridNode).Id;
  F := 'F:'+IntToStr(GetTabIndex)+';';
  with dsData.DataSet do begin
    First;
    while not Eof do begin
      POST_ID := FieldByName('AsfMtr_Id').AsInteger;
      P := 'P:'+IntToStr(POST_ID)+';';
      Edit;
      for I := 7 to FieldCount-1 do begin //0-KeyID,1-Post_ID,2-Post_Name,3-Post_Total
        if Fields[I].FieldKind <> fkCalculated then begin
          DEP_ID := Copy(Fields[I].FieldName, {DEP_x}5, 10);
          D := 'D:'+DEP_ID+';';
          J := FCalculate.IndexOfName(D+P);
          if J>=0 then begin
            Fields[I].Value := StrToInt(FCalculate.ValueFromIndex[J]);

            if qrData.Locate('ASP_ID;AsfMtr_Id',VarArrayOf([StrToInt(DEP_ID), POST_ID]),[]) and
               (FCalculate.ValueFromIndex[J]<>qrData.FieldByName(PagesMap[dsData.DataSet.Tag]).AsString)
            then
              FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[dsData.DataSet.Tag]).AsString
            else begin
              K := FChanged.IndexOfName(D+P+F);
              if K>=0 then FChanged.Delete(K);
            end;

            FCalculate.Delete(J);
          end else
            Fields[I].Clear;
        end;
      end;
      Post;
      Next;
    end;
    Locate('AsfMtr_Id',OldPOST_ID,[]);
  end;
end;

procedure TfmAsfMtrList.FormCreate(Sender: TObject);
var
  I: Integer;
  s: String;
begin
  FFiltered := False;
  flt := TfxSetFilter.Create(Self);
  FChanged   := TStringList.Create;
  FCalculate := TStringList.Create;
  FFormulas  := TStringList.Create;  for I := Low(PagesFormulas) to High(PagesFormulas) do FFormulas.Add(PagesFormulas[I]);
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain; ParamCheck := False;
    SQL.Text := 'SELECT * FROM ASF ORDER BY Iif((OrgSName is null), OrgName, OrgSName)';
    Open;
    while not EOF do begin
      s := FieldByName('OrgSName').AsString;
      if s = '' then s := FieldByName('OrgName').AsString;
      flt.cbDeps.Items.AddObject(s,Pointer(FieldByName('ASF_ID').AsInteger));
      flt.cbDeps.Checked[flt.cbDeps.Items.Count-1] := True;
      Next;
    end;
    Close;
    SQL.Text := 'SELECT '+
      'Id as KAsfMtr_Id, Iif((ShortName is null), Name, ShortName) As NameX '+
      ' FROM KAsfMtr ' +
      ' ORDER BY Iif((ShortName is null), Name, ShortName)';
    Open;
    while not EOF do begin
      flt.cbPosts.Items.AddObject(FieldByName('NameX').AsString,Pointer(FieldByName('KAsfMtr_Id').AsInteger));
      flt.cbPosts.Checked[flt.cbPosts.Items.Count-1] := True;
      Next;
    end;
  finally Free;
  end;
end;

procedure TfmAsfMtrList.FormDestroy(Sender: TObject);
begin
  FChanged  .Free;
  FCalculate.Free;
  FFormulas .Free;
  flt.Free;
end;

procedure TfmAsfMtrList.GridEdited(Sender: TObject; Node: TdxTreeListNode);
var
  MyNode               : TdxDBGridNode absolute Node;
  DEP_ID               : Integer;
  D,P,F                : String;
  I                    : Integer;
  CalcValue            : Integer;
  CalcData1, CalcData2 : TdxMemdata;
begin
  DEP_ID := Grid.Columns[Grid.FocusedAbsoluteIndex].Tag;
  D := 'D:'+IntToStr(DEP_ID)+';';
  P := 'P:'+IntToStr(Integer(MyNode.Id))+';';
  F := 'F:'+IntToStr(dsData.DataSet.Tag)+';';

  if qrData.Locate('ASP_ID;AsfMtr_Id',VarArrayOf([DEP_ID, Integer(MyNode.Id)]),[]) and
     (StrToInt(MyNode.Strings[Grid.FocusedAbsoluteIndex])<>qrData.FieldByName(PagesMap[Grid.DataSource.DataSet.Tag]).Value)
  then
    FChanged.Values[D+P+F] := qrData.FieldByName(PagesMap[Grid.DataSource.DataSet.Tag]).AsString
  else begin
    I := FChanged.IndexOfName(D+P+F);
    if I>=0 then FChanged.Delete(I);
  end;
  GetCalcDatas(dsData.DataSet, CalcData1,CalcData2);
  if Assigned(CalcData1) then begin
    CalcData1.Locate('AsfMtr_Id',dsData.DataSet.FieldByName('AsfMtr_Id').Value,[]);
    if Assigned(CalcData2) then begin
       CalcData2.Locate('AsfMtr_Id',dsData.DataSet.FieldByName('AsfMtr_Id').Value,[]);
       CalcValue := CalcData1.FieldByName('ASP_'+IntToStr(DEP_ID)).AsInteger
                   -CalcData2.FieldByName('ASP_'+IntToStr(DEP_ID)).AsInteger;
    end
    else
      CalcValue := CalcData1.FieldByName('ASP_'+IntToStr(DEP_ID)).AsInteger;
    if CalcValue<>StrToInt(MyNode.Strings[Grid.FocusedAbsoluteIndex]) then
      FCalculate.Values[D+P] := IntToStr(CalcValue)
    else begin
      I := FCalculate.IndexOfName(D+P);
      if I>=0 then FCalculate.Delete(I);
    end;
  end;
end;

procedure TfmAsfMtrList.GridNumGetText(Sender: TObject; ANode: TdxTreeListNode;
  var AText: string);
begin
  AText := IntToStr(ANode.Index + 1);
end;

procedure TfmAsfMtrList.qrDataFieldSetText(Sender: TField;
  const Text: String);
begin
  Sender.Value := StrToIntDef(Text, 0); // Avoid nulls
end;

procedure TfmAsfMtrList.actStoreExecute(Sender: TObject);
var
  OldPOST_ID : Integer;
  I,J        : Integer;
  q: TADOQuery;
  md, ds: TdxMemData;
begin
  for I := 0 to PagesCount-1 do
    if not PagesRO[I] then begin
      ds := Self.FindComponent('Data'+PagesMap[I]) as TdxMemData;
      ds.First;
      while not ds.Eof do begin
        if (I = 0) and
           ((ds.FieldByName('AsfMtr_Total').AsInteger - ds.FieldByName('AsfMtr_Deficit').AsInteger) < 0) then begin

          {MessageBox(flt.Handle, 'Затребовано больше МТР, чем имеется в наличии', 'Ошибка', Mb_Ok+Mb_IconError);
          Exit;}
        end else if (I > 0) and
           (ds.FieldByName('AsfMtr_Deficit').AsInteger < 0) then begin
          MessageBox(flt.Handle, 'Выделено больше МТР, чем имеется в наличии', 'Ошибка', Mb_Ok+Mb_IconError);
          Exit;
        end;

        ds.Next;
      end;
    end;


  OldPOST_ID := dsData.DataSet.FieldByName('AsfMtr_Id').AsInteger;
  q := TADOQuery.Create(nil);
  with q do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := 'DELETE FROM ASMtrList';
    ExecSQL;
    SQL.Text := ' SELECT ASP_ID, AsfMtr_Id';
    for I := 0 to PagesCount-1 do if not PagesRO[I] then
      SQL.Text := SQL.Text + ', '+PagesMap[I];
    SQL.Text := SQL.Text + ' FROM ASMtrList';
    Open;
    dsData.DataSet.First;
    for I := 0 to PagesCount-1 do if not PagesRO[I] and (I<>dsData.DataSet.Tag) then
     (Self.FindComponent('Data'+PagesMap[I]) as TdxMemData).First;
    while not dsData.DataSet.Eof do begin
      for I := 7 to dsData.DataSet.FieldCount-1 do begin //0-KeyID,1-Post_ID,2-Post_Name,3-Post_Total
        if dsData.DataSet.Fields[I].FieldKind <> fkCalculated then begin
          Insert;
          FieldByName('ASP_ID' ).Value := StrToInt(Copy(dsData.DataSet.Fields[I].FieldName, {DEP_x}5, 10));
          FieldByName('AsfMtr_Id').Value := dsData.DataSet.FieldByName('AsfMtr_ID').Value;
          for J := 0 to PagesCount-1 do begin
            if not PagesRO[J] then begin
              md := Self.FindComponent('Data'+PagesMap[J]) as TdxMemData;
              FieldByName(PagesMap[J]).Value := md.Fields[I].Value;
            end;
          end;
          Post;
        end;
      end;
      dsData.DataSet.Next;
      for I := 0 to PagesCount-1 do if not PagesRO[I] and (I<>dsData.DataSet.Tag) then
       (Self.FindComponent('Data'+PagesMap[I]) as TdxMemData).Next;
    end;
    ds := TdxMemData(self.FindComponent(dsData.DataSet.Name+'_hidden'));
    ds.First;
    for I := 0 to PagesCount-1 do if not PagesRO[I] and (I<>dsData.DataSet.Tag) then
     (Self.FindComponent('Data'+PagesMap[I]+'_hidden') as TdxMemData).First;
    while not ds.Eof do begin
      for I := 7 to ds.FieldCount-1 do begin //0-KeyID,1-Post_ID,2-Post_Name,3-Post_Total
        if ds.Fields[I].FieldKind <> fkCalculated then begin
          Insert;
          FieldByName('ASP_ID' ).Value := StrToInt(Copy(ds.Fields[I].FieldName, {DEP_x}5, 10));
          FieldByName('AsfMtr_Id').Value := ds.FieldByName('AsfMtr_ID').Value;
          for J := 0 to PagesCount-1 do begin
            if not PagesRO[J] then begin
              md := Self.FindComponent('Data'+PagesMap[J]+'_hidden') as TdxMemData;
              FieldByName(PagesMap[J]).Value := md.Fields[I].Value;
            end;
          end;
          Post;
        end;
      end;
      ds.Next;
      for I := 0 to PagesCount-1 do if not PagesRO[I] and (I<>dsData.DataSet.Tag) then
       (Self.FindComponent('Data'+PagesMap[I]+'_hidden') as TdxMemData).Next;
    end;
  finally Free;
  end;
  dsData.DataSet.Locate('AsfMtr_Id',OldPOST_ID,[]);
  FChanged.Clear;
  actRefresh.Execute;
end;


procedure TfmAsfMtrList.bFilterClick(Sender: TObject);
var
  res: Integer;
begin
  res := flt.ShowModal;
  case res of
    mrOK: begin
      FFiltered := True;
      actRefreshExecute(Self);
    end;
    mrAbort: begin
      FFiltered := False;
      actRefreshExecute(Self);
    end;
  end;
end;

procedure TfmAsfMtrList.GetCalcDatas(Data: TDataSet; out CalcData1, CalcData2: TdxMemData);
var
  I: Integer;
  S: String;
begin
  CalcData1 := nil;  CalcData2 := nil;
  S := FFormulas.Values[Copy(Data.Name,5{Strip "Data" word},255)];
  if S='' then Exit;
  I := Pos('-',S);
  if I > 0 then begin
    CalcData1 := FindComponent('Data'+LeftStr(S, I-1)) as TdxMemData;
    CalcData2 := FindComponent('Data'+Copy(S, I+1, 255)) as TdxMemData;
  end
  else
    CalcData1 := FindComponent('Data'+S) as TdxMemData;
end;

function TfmAsfMtrList.GetTabIndex: Integer;
begin
  with TabControl do Result := Integer(Tabs.Objects[Tabindex]);
end;

procedure TfmAsfMtrList.CreateTabs;
var I: Integer;
begin
  TabControl.Tabs.Clear;
  for I := 0 to PagesCount-2 {last page is QtyAll - unvisible} do
  if PagesRO[I]<>True then TabControl.Tabs.AddObject(PagesTabs[I],TObject(I));
end;

procedure TfmAsfMtrList.actExcelExecute(Sender: TObject);
begin
  dmMain.GridToExcel(Grid,PagesTabs[GetTabIndex],False,True);
end;

initialization
  fmAsfMtrList := nil;
end.


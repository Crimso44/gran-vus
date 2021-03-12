unit fPersChangesLst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  dxBar, Db, ADODB, Menus, dxDBTLCl, dxGrClms, dxExEdtr, Variants, dMain,
  StdCtrls, cxClasses, dxBarDBNav, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxBarPainter;

type
  TfmPersonChangesList = class(TForm)
    dbgData: TdxDBGrid;
    ActionList1: TActionList;
    actEdit: TAction;
    actDel: TAction;
    actFiltr: TAction;
    FrmKeep1: TFrmKeep;
    dxBarManager1: TdxBarManager;
    dxBarButton1: TdxBarButton;
    dxBarDBNavEdit1: TdxBarDBNavButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    qrData: TADOQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    qrDataFIO: TStringField;
    dbgDataColumn3: TdxDBGridColumn;
    dbgDataColumnFIO: TdxDBGridColumn;
    dbgDataColumn7: TdxDBGridColumn;
    dbgDataColumn5: TdxDBGridDateColumn;
    actRefresh: TAction;
    actExcel: TAction;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    actStoreSet: TAction;
    actClearSet: TAction;
    dxBarButton7: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    DataSQL: TMemo;
    dbgDataNum: TdxDBGridColumn;
    qrDataFAM: TWideStringField;
    qrDataIM: TWideStringField;
    qrDataOTCH: TWideStringField;
    qrDataWRNG_ID: TIntegerField;
    qrDataBIRTHDAY: TDateTimeField;
    qrDataWRange: TWideStringField;
    qrDataPOST_NAME: TWideStringField;
    qrDataDEP_NAME: TWideStringField;
    qrDataGROUP_ID: TIntegerField;
    qrDataGROUP_NAME: TWideStringField;
    qrDataOLDVALUE: TWideMemoField;
    qrDataNEWVALUE: TWideMemoField;
    qrDataCHANGE_DATE: TDateTimeField;
    qrDataBEGIN_DATE: TDateTimeField;
    qrDataNOTBEGINREASON: TWideStringField;
    qrDataEND_DATE: TDateTimeField;
    qrDataSEND_DATE: TDateTimeField;
    qrDataDEPPOST: TStringField;
    dbgDataGROUP_NAME: TdxDBGridColumn;
    dbgDataChange_Date: TdxDBGridDateColumn;
    dbgDataBegin_Date: TdxDBGridDateColumn;
    dbgDataNotBeginReason: TdxDBGridColumn;
    dbgDataSend_Date: TdxDBGridDateColumn;
    qrDataCHANGE_ID: TAutoIncField;
    dbgDataOldValue: TdxDBGridMemoColumn;
    dbgDataNewValue: TdxDBGridMemoColumn;
    qrDataPERS_ID: TIntegerField;
    dbgDataEnd_Date: TdxDBGridDateColumn;
    dxBarDBNavPost1: TdxBarDBNavButton;
    actSave: TAction;
    dxBarButton2: TdxBarButton;
    qrDataOutNumber: TWideStringField;
    qrDataOutDate: TDateTimeField;
    dbgDataOutNumber: TdxDBGridColumn;
    dbgDataOutDate: TdxDBGridDateColumn;
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actFiltrExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrDataCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actExcelExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actStoreSetExecute(Sender: TObject);
    procedure actClearSetExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure dbgDataNumGetText(Sender: TObject; ANode: TdxTreeListNode;
      var AText: string);
    procedure dbgDataColumnSorting(Sender: TObject; Column: TdxDBTreeListColumn;
      var Allow: Boolean);
    procedure dbgDataDblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actSaveUpdate(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
  private
    { Private declarations }
    FMaximized: Boolean;
    procedure ReOpenList;
    function GeneralSQLSelect: String;
  public
    { Public declarations }
    FTempFile: string;
    procedure SetFiltr(SQL: String);
  end;


  procedure ShowPersonChangesList;

implementation

uses fPersonCard, msg, misc, MD5, fFltMgr, fRegister, DateUtils, fMain;

{$R *.DFM}

function TfmPersonChangesList.GeneralSQLSelect: String;
begin
  Result := DataSQL.Lines.Text;
end;

function GeneralSQLOrderBy: String;
begin
  Result := 'ORDER BY FLAG.VAL, [PERSON].FAM, [PERSON].IM, [PERSON].OTCH, [PersonChanges].CHANGE_DATE desc';
end;

procedure ShowPersonChangesList;
var fmPersonChangesList: TfmPersonChangesList;
begin
  Application.CreateForm(TfmPersonChangesList,fmPersonChangesList);
  if fmMain.MainScale <> 100 then
    fmPersonChangesList.ScaleBy(fmMain.MainScale, 100);
  if IsIconic(fmPersonChangesList.Handle) then ShowWindow(fmPersonChangesList.Handle,SW_RESTORE);
  fmPersonChangesList.BringToFront;
end;

procedure TfmPersonChangesList.actEditExecute(Sender: TObject);
begin
  if qrData.IsEmpty then Beep
  else
    qrData.Edit;
end;

procedure TfmPersonChangesList.actDelExecute(Sender: TObject);
  procedure DelFromTable(tbl_name: string);
  begin
    with TADOQuery.Create(Self) do begin
      Connection := dmMain.dbMain;
      SQL.Text := 'DELETE FROM '+tbl_name+' WHERE CHANGE_ID='+
        qrData.FieldByName('CHANGE_ID').AsString;
      ExecSQL;
      Free;
    end;
  end;
begin
  if qrData.IsEmpty then Beep
  else
    if Confirm('Удалить текущую строку?') then begin
    try
      dmMain.dbMain.BeginTrans;
    except
    end;
    try
      DelFromTable('PersonChanges');
      with qrData do begin Close; Open; end;
      if dmMain.dbMain.InTransaction then dmMain.dbMain.CommitTrans;
    except
      if dmMain.dbMain.InTransaction then dmMain.dbMain.RollbackTrans;
      ShowErr('Ошибка при удалении!!');
    end;
  end;
end;

procedure TfmPersonChangesList.actFiltrExecute(Sender: TObject);
var SQL: string; NewForm: TForm; AMax: Boolean;
begin
  AMax := FMaximized;//if new window 
  SQL := GeneralSQLSelect;
  if GetSQLText(NewForm, ffPersChanges, SQL, FTempFile) then SetFiltr(SQL);
  if Assigned(NewForm) then begin
    BringToFront;
    NewForm.BringToFront;
    FMaximized := AMax;
  end;
end;

procedure TfmPersonChangesList.SetFiltr(SQL: String);
begin
  qrData.Close;
  qrData.SQL.Text := SQL+#13+GeneralSQLOrderBy;
  qrData.Open;
end;


procedure TfmPersonChangesList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmPersonChangesList.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if qrData.State in [dsEdit, dsInsert] then CanClose := Confirm(
    'Текущая запись не сохранена. Выйти без сохранения?');
end;

procedure TfmPersonChangesList.qrDataCalcFields(DataSet: TDataSet);
begin
  with qrData do begin
    qrDataFIO.AsString :=
      qrDataFAM.AsString + ' ' +
      Copy(qrDataIM.AsString,1,1) + '. ' +
      Copy(qrDataOTCH.AsString,1,1) + '. ';
    qrDataDEPPOST.Value := qrDataDEP_NAME.Value + ', ' + qrDataPOST_NAME.Value;
  end;
end;

procedure TfmPersonChangesList.FormCreate(Sender: TObject);
begin
  FMaximized := True;
  FTempFile := ExtractFilePath(Application.ExeName)+'~'+IntToStr(GetTickCount)+'.flt';
  qrData.SQL.Text :=  GeneralSQLSelect+#13+GeneralSQLOrderBy;
  ReOpenList;
end;

procedure TfmPersonChangesList.ReOpenList;
begin
  qrData.Open;
end;

procedure TfmPersonChangesList.dbgDataColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := Column <> dbgDataNum;
end;

procedure TfmPersonChangesList.dbgDataDblClick(Sender: TObject);
begin
  with qrData do begin
    ShowPersonCard(FieldByName('PERS_ID').AsInteger, nil);
  end;
end;

procedure TfmPersonChangesList.dbgDataNumGetText(Sender: TObject;
  ANode: TdxTreeListNode; var AText: string);
begin
  AText := IntToStr(ANode.Index + 1);
end;

procedure TfmPersonChangesList.actRefreshExecute(Sender: TObject);
var CHANGE_ID: Integer;
begin
  with qrData do begin
    if Active then CHANGE_ID := FieldByName('CHANGE_ID').AsInteger else CHANGE_ID := -1;
    Close; Open;
    if CHANGE_ID>-1 then Locate('CHANGE_ID', CHANGE_ID, []);
    Edit;
  end;
end;

procedure TfmPersonChangesList.actExcelExecute(Sender: TObject);
begin
  dmMain.GridToExcel(dbgData,Caption,true,true);
end;

procedure TfmPersonChangesList.FormDestroy(Sender: TObject);
begin
  DeleteFile(FTempFile);
end;

procedure TfmPersonChangesList.actSaveExecute(Sender: TObject);
begin
  qrData.Post;
end;

procedure TfmPersonChangesList.actSaveUpdate(Sender: TObject);
begin
  actSave.Enabled := DataSource1.State in dsEditModes;
end;

procedure TfmPersonChangesList.actStoreSetExecute(Sender: TObject);
var k: Integer;
begin
  if Confirm('Сохранить текущий список(набор) для построения отчетности?') then
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'delete from [PERS_SET]';
      ExecSQL;
      k := qrData.RecNo;
      try
        qrData.First;
        SQL.Text := 'select * from [PERS_SET]';
        Open;
        while not qrData.EOF do begin
          Append;
          Fields[0].Value := qrData.FieldbyName('PERS_ID').Value;
          Post;
          qrData.Next;
        end;
      finally
        if not qrData.IsEmpty then
           qrData.RecNo := k;
      end;
    finally
      Free;
    end;
end;

procedure TfmPersonChangesList.actClearSetExecute(Sender: TObject);
begin
  if Confirm('Очистить ранее заданный список(набор) для построения отчетности?') then
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'delete from [PERS_SET]';
      ExecSQL;
    finally
      Free;
    end;
end;

procedure TfmPersonChangesList.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  actDel.Enabled := dmMain.rEdit;
end;

procedure TfmPersonChangesList.FormActivate(Sender: TObject);
begin
  if FMaximized then ShowWindow(handle, sw_ShowMaximized);
end;

procedure TfmPersonChangesList.FormDeactivate(Sender: TObject);
begin
  FMaximized := IsZoomed(Handle);
end;

end.


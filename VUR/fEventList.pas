unit fEventList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FrmKeep, dxBar, dxBarDBNav, StdCtrls, ExtCtrls, dxExEdtr,
  ImgList, ToolWin, ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  DB, ADODB, Menus, dxDBTLCl, dxGrClms;

type
  TfmEventList = class(TForm)
    FrmKeep: TFrmKeep;
    paTop: TPanel;
    paBottom: TPanel;
    Splitter1: TSplitter;
    laLeft: TLabel;
    laDetail: TLabel;
    qryMaster: TADOQuery;
    qryDetail: TADOQuery;
    dsMaster: TDataSource;
    dsDetail: TDataSource;
    gridMaster: TdxDBGrid;
    gridDetail: TdxDBGrid;
    ActionList: TActionList;
    ToolBar1: TToolBar;
    aClear: TAction;
    aWord: TAction;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    gridMasterWhen: TdxDBGridColumn;
    gridMasterType: TdxDBGridColumn;
    gridMasterObject: TdxDBGridColumn;
    gridMasterEvent_id: TdxDBGridColumn;
    gridDetailValue: TdxDBGridMemoColumn;
    aClose: TAction;
    ToolButton7: TToolButton;
    aFilter: TAction;
    qryUsers: TADOQuery;
    qryMasterEvent_ID: TIntegerField;
    qryMasterType: TStringField;
    qryMasterObject: TStringField;
    qryMasterWhen: TDateTimeField;
    qryMasterWho: TIntegerField;
    qryUsersID: TIntegerField;
    qryUsersLogin: TStringField;
    qryMasterWhoLogin: TStringField;
    gridMasterWhoLogin: TdxDBGridColumn;
    StatusBar: TStatusBar;
    N4: TMenuItem;
    N5: TMenuItem;
    aGroups: TAction;
    aExcel: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    aRefresh: TAction;
    ToolButton8: TToolButton;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Panel1: TPanel;
    qryUsersFam: TStringField;
    qryUsersIm: TStringField;
    qryUsersOtch: TStringField;
    qryUsersName: TStringField;
    gridMasterNum: TdxDBGridColumn;
    procedure aClearExecute(Sender: TObject);
    procedure aWordExecute(Sender: TObject);
    procedure qryDetailBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure gridMasterChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure FormDestroy(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aFilterExecute(Sender: TObject);
    procedure qryMasterBeforeOpen(DataSet: TDataSet);
    procedure dsMasterDataChange(Sender: TObject; Field: TField);
    procedure qryMasterAfterOpen(DataSet: TDataSet);
    procedure aGroupsExecute(Sender: TObject);
    procedure aExcelExecute(Sender: TObject);
    procedure aRefreshExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryUsersCalcFields(DataSet: TDataSet);
    procedure gridMasterNumGetText(Sender: TObject; ANode: TdxTreeListNode;
      var AText: string);
    procedure gridMasterColumnSorting(Sender: TObject;
      Column: TdxDBTreeListColumn; var Allow: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowEventList;

implementation

uses dMain, Rdialogs, IniFiles, Clipbrd, fEventFilter, IniSupport,
  dEventListPrint, msg, SaveEvents, StrUtils, fMain;

{$R *.dfm}

var
  fmEventList: TfmEventList;

procedure ShowEventList;
begin
  if not Assigned(fmEventList) then begin
    Application.CreateForm(TfmEventList, fmEventList);
    if fmMain.MainScale <> 100 then
      fmEventList.ScaleBy(fmMain.MainScale, 100);
  end;
  if IsIconic(fmEventList.Handle) then ShowWindow(fmEventList.Handle, SW_RESTORE);
  fmEventList.BringToFront;
end;

procedure TfmEventList.aClearExecute(Sender: TObject);
begin
  if not Confirm('ВНИМАНИЕ! После вывода содержимого журнала событий в Word '+
    'все записи в журнале будут удалены! Вы уверены в своих действиях?')
  then Exit;
  dEventListPrint.Execute(True);
  with qryMaster do begin Close; Open; Last; end;
  with qryDetail do begin Close; Open; end;
  if qryMasterType.AsString = evs_Report_Error then begin
    SaveEvent(dmMain.dbMain, evs_EventLog_Clear_Failed, '', [
      'Ошибка вывода журнала в Word.']);
    with qryMaster do begin Close; Open; Last; end;
    with qryDetail do begin Close; Open; end;
    ShowErr('Очистка журнала событий отменена из-за ошибки вывода журнала в Word!');
    Exit;
  end;
  try
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;  ParamCheck := False;
      SQL.Text   := 'DELETE FROM EventDetail';
      ExecSQL;
      SQL.Text   := 'DELETE FROM Event';
      ExecSQL;
    finally Free;
    end;
  except
    on E: Exception do begin
      SaveEvent(dmMain.dbMain, evs_EventLog_Clear_Failed, '', [
        E.ClassName+':'+E.Message]);
      with qryMaster do begin Close; Open; Last; end;
      with qryDetail do begin Close; Open; end;
      ShowErr('Ошибка очистки журнала событий! '#13+E.ClassName+':'+E.Message);
      Exit;
    end;
  end;
  SaveEvent(dmMain.dbMain, evs_EventLog_Clear, '', []);
  with qryMaster do begin Close; Open; end;
  with qryDetail do begin Close; Open; end;
end;

procedure TfmEventList.aWordExecute(Sender: TObject);
begin
  dEventListPrint.Execute; with qryMaster do begin Close; Open; end;
end;

procedure TfmEventList.qryDetailBeforeOpen(DataSet: TDataSet);
begin
  if Assigned(gridMaster.FocusedNode) then 
  qryDetail.Parameters[0].Value := TdxDBGridNode(gridMaster.FocusedNode).Id
end;

procedure TfmEventList.gridMasterChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  with qryDetail do begin Close; Open; end;
end;

procedure TfmEventList.gridMasterColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := Column <> gridMasterNum;
end;

procedure TfmEventList.gridMasterNumGetText(Sender: TObject;
  ANode: TdxTreeListNode; var AText: string);
begin
  AText := IntToStr(ANode.Index + 1);
end;

procedure TfmEventList.FormCreate(Sender: TObject);
begin
  aClear.Enabled := dmMain.dbMain.Tag=1;
  aWord.Enabled  := dmMain.rPrint;
  aExcel.Enabled := dmMain.rPrint;
  qryMaster.Open;
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'frmdata.ini') do
  try
    paBottom.Height := ReadInteger('Forms', 'fEventList.BottomHeight', paBottom.Height);
  finally Free;
  end;
  aGroups.Checked := gridMaster.ShowGroupPanel;
end;

procedure TfmEventList.FormDestroy(Sender: TObject);
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'frmdata.ini') do
  try
    WriteInteger('Forms', 'fEventList.BottomHeight', paBottom.Height);
  finally Free;
  end;
end;

procedure TfmEventList.aCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmEventList.aFilterExecute(Sender: TObject);
begin
 if fEventFilter.Execute then with qryMaster do begin Close; Open; end;
end;

procedure TfmEventList.qryMasterBeforeOpen(DataSet: TDataSet);
var S: String;
begin
  S := GetEventFilterSQL; 
  if S<>''
    then StatusBar.Panels[1].Text := 'Включена фильтрация'
    else StatusBar.Panels[1].Text := '';
  qryMaster.SQL.Text := 'SELECT * FROM Event WHERE 1=1 '+S+' ORDER BY Event_ID';
end;

procedure TfmEventList.dsMasterDataChange(Sender: TObject; Field: TField);
begin
  StatusBar.Panels[0].Text := 'Событий: '+IntToStr(qryMaster.RecordCount);
end;

procedure TfmEventList.qryMasterAfterOpen(DataSet: TDataSet);
begin
  qryMaster.Last;
  if Assigned(gridMaster.FocusedNode) then gridMaster.FocusedNode.MakeVisible;
end;

procedure TfmEventList.aGroupsExecute(Sender: TObject);
begin
  aGroups.Checked := not aGroups.Checked;
  gridMaster.ShowGroupPanel := aGroups.Checked
end;

procedure TfmEventList.aExcelExecute(Sender: TObject);
begin
  dmMain.GridToExcel(gridMaster,'Список событий',False,True);
end;

procedure TfmEventList.aRefreshExecute(Sender: TObject);
begin
  with qryMaster do begin Close; Open; Last; end;
end;

procedure TfmEventList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  fmEventList := nil;
end;

procedure TfmEventList.qryUsersCalcFields(DataSet: TDataSet);
begin
 qryUsersName.AsString := Format('%s %s.%s (%s)',[
   qryUsersFam.AsString,
   LeftStr(qryUsersIm.AsString,1),
   LeftStr(qryUsersOtch.AsString,1),
   qryUsersLogin.AsString]);
end;

end.

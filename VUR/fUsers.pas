unit fUsers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, DB, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  ADODB, StdCtrls, Buttons, ComCtrls, ExtCtrls, dxDBTLCl, dxGrClms,
  dxBar, Menus, cxClasses, System.Actions;

type
  TfmUsers = class(TForm)
    StatusBar: TStatusBar;
    dsData: TDataSource;
    qrData: TADOQuery;
    dbgData: TdxDBGrid;
    ActionList: TActionList;
    actEdit: TAction;
    actDelete: TAction;
    actAdd: TAction;
    qrDataFIO: TStringField;
    qrDataID: TIntegerField;
    qrDataLogin: TStringField;
    qrDataFAM: TStringField;
    qrDataIM: TStringField;
    qrDataOTCH: TStringField;
    qrDatarAdmin: TBooleanField;
    qrDatarImport: TBooleanField;
    qrDatarExport: TBooleanField;
    qrDatarPrint: TBooleanField;
    qrDatarEdit: TBooleanField;
    qrDatarLogin: TBooleanField;
    dbgDataFIO: TdxDBGridColumn;
    dbgDataLOGIN: TdxDBGridColumn;
    dbgDatarLogin: TdxDBGridCheckColumn;
    dbgDatarAdmin: TdxDBGridCheckColumn;
    dbgDatarImport: TdxDBGridCheckColumn;
    dbgDatarExport: TdxDBGridCheckColumn;
    dbgDatarPrint: TdxDBGridCheckColumn;
    dbgDatarEdit: TdxDBGridCheckColumn;
    dxBarManager1: TdxBarManager;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    aRefresh: TAction;
    dxBarButton4: TdxBarButton;
    dbgDataNum: TdxDBGridColumn;
    procedure qrDataCalcFields(DataSet: TDataSet);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actEditExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgDataKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure aRefreshExecute(Sender: TObject);
    procedure dbgDataNumGetText(Sender: TObject; ANode: TdxTreeListNode;
      var AText: string);
    procedure dbgDataColumnSorting(Sender: TObject; Column: TdxDBTreeListColumn;
      var Allow: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure Execute;

implementation

uses dMain, fUserCard, msg, fMain;

{$R *.dfm}

var
  fmUsers: TfmUsers;

procedure Execute;
begin
  if not Assigned(fmUsers) then begin
    Application.CreateForm(TfmUsers, fmUsers);
    if fmMain.MainScale <> 100 then
      fmUsers.ScaleBy(fmMain.MainScale, 100);
  end;
  if IsIconic(fmUsers.Handle) then ShowWindow(fmUsers.Handle, SW_RESTORE);
  fmUsers.BringToFront;
end;


procedure TfmUsers.qrDataCalcFields(DataSet: TDataSet);
begin
  qrDataFIO.AsString := Format('%s %s.%s.',
    [qrDataFAM.AsString, Copy(qrDataIm.AsString,1,1),Copy(qrDataOTCH.AsString,1,1)]); 
end;

procedure TfmUsers.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  actDelete.Enabled := Assigned(dbgData.FocusedNode) and
                       (TdxDBGridNode(dbgData.FocusedNode).Id<>1);
end;

procedure TfmUsers.actEditExecute(Sender: TObject);
var ID: Integer;
begin
  ID := qrDataID.AsInteger;
  fUserCard.Edit(ID);
  with qrData do begin
    Close; Open; Locate('ID',ID,[]);
  end;
end;

procedure TfmUsers.actAddExecute(Sender: TObject);
var ID: Integer;
begin
  ID := fUserCard.Add;
  if ID > 0 then with qrData do begin
    Close; Open; Locate('ID',ID,[]);
  end;
end;

procedure TfmUsers.actDeleteExecute(Sender: TObject);
begin
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := 'SELECT * FROM Event WHERE Who = '+qrDataID.AsString;
    Open;
    if IsEmpty then begin
      if Confirm('Вы действительно хотите удалить этого пользователя?') then qrData.Delete;
    end
    else
    if qrDatarLogin.AsBoolean then begin
      if Confirm('Данный пользователь не может быть удалён, т.к. '+
                 'на него имеются ссылки в журнале событий. '+
                 'Вы хотите запретить этому пользователю вход в систему?')
      then begin
        qrData.Edit; qrDatarLogin.AsBoolean := False; qrData.Post;
      end;
    end
    else begin
      ShowErr('Данный пользователь не может быть удалён, т.к. '+
              'на него имеются ссылки в журнале событий.');
    end;
  finally Free;
  end;
end;

procedure TfmUsers.FormCreate(Sender: TObject);
begin
  qrData.Open;
  dbgDatarImport.Visible := False;
end;

procedure TfmUsers.dbgDataColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := Column <> dbgDataNum;
end;

procedure TfmUsers.dbgDataKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    vk_RETURN: actEdit.Execute;
    vk_DELETE: actDelete.Execute;
    vk_INSERT: actAdd.Execute;
  end;
end;

procedure TfmUsers.dbgDataNumGetText(Sender: TObject; ANode: TdxTreeListNode;
  var AText: string);
begin
  AText := IntToStr(ANode.Index + 1);
end;

procedure TfmUsers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fmUsers := nil;
end;

procedure TfmUsers.aRefreshExecute(Sender: TObject);
begin
  qrData.Requery;
end;

end.

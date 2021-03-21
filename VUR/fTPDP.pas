unit fTPDP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, dxBar, DB, ComCtrls, ADODB, dxExEdtr, dxCntner, dxTL,
  dxDBCtrl, dxDBGrid, Menus, dxDBTLCl, dxGrClms, FrmKeep, Grids, DBGrids,
  cxClasses;

type
  TfmTPDP = class(TForm)
    dsData: TDataSource;
    qrData: TADOQuery;
    StatusBar1: TStatusBar;
    dxBarManager1: TdxBarManager;
    ActionList: TActionList;
    actNew: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefresh: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    dbgData: TdxDBGrid;
    qrDataCOND_ID: TIntegerField;
    qrDataLimited: TIntegerField;
    qrDataAge: TStringField;
    qrDataWRange: TStringField;
    qrDataWSosts: TStringField;
    dbgDataTPDP_ID: TdxDBGridMaskColumn;
    dbgDataCOND_ID: TdxDBGridMaskColumn;
    dbgDataLimited: TdxDBGridCheckColumn;
    dbgDataAge: TdxDBGridMaskColumn;
    dbgDataWRange: TdxDBGridMaskColumn;
    dbgDataWSosts: TdxDBGridMaskColumn;
    FrmKeep1: TFrmKeep;
    qrDataID2: TStringField;
    qrDataTPDP_ID: TIntegerField;
    qrDataSexName: TWideStringField;
    dbgDataSexName: TdxDBGridColumn;
    qrDataKOKPDTR: TIntegerField;
    qrDataKOKPDTR_NAME: TStringField;
    qrDataOKVED: TStringField;
    dbgDataKOKPDTR: TdxDBGridMaskColumn;
    dbgDataKOKPDTR_NAME: TdxDBGridMaskColumn;
    dbgDataOKVED: TdxDBGridMaskColumn;
    qrDataKOKPDTR_CODE: TStringField;
    qrDataKOKPDTR_Name_Full: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actNewExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure qrDataAfterOpen(DataSet: TDataSet);
    procedure dbgDataDblClick(Sender: TObject);
    procedure dbgDataCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
  public
    { Public declarations }
  end;

procedure ShowTPDP;
procedure ShowTPDPModal;

implementation

uses msg, dMain, fTPDPPunkt, fMain;

{$R *.dfm}

var
  fmTPDP: TfmTPDP;

procedure ShowTPDP;
begin
  if fmTPDP=nil              then begin
    Application.CreateForm(TfmTPDP,fmTPDP);
    if fmMain.MainScale <> 100 then
      fmTPDP.ScaleBy(fmMain.MainScale, 100);
    fmTPDP.FormStyle := fsMDIChild
  end;
  if IsIconic(fmTPDP.Handle) then ShowWindow(fmTPDP.Handle,SW_RESTORE);
  fmTPDP.BringToFront;
end;

procedure ShowTPDPModal;
begin
  if Assigned(fmTPDP) then fmTPDP.Close;

  with TfmTPDP.Create(Application) do
  try     ShowModal;
  finally Free;
  end;
end;
{ TfmTPDP }


procedure TfmTPDP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fmTPDP := nil;
end;

procedure TfmTPDP.actNewExecute(Sender: TObject);
begin
  fTPDPPunkt.Add(qrData);
end;

procedure TfmTPDP.actEditExecute(Sender: TObject);
begin
  fTPDPPunkt.Edit(qrData);
end;

procedure TfmTPDP.actDeleteExecute(Sender: TObject);
begin
  fTPDPPunkt.Delete(qrData);
end;

procedure TfmTPDP.actRefreshExecute(Sender: TObject);
begin
  qrData.Requery;
end;

procedure TfmTPDP.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  actNew    .Enabled := dmMain.rEdit;
  actEdit   .Enabled := dmMain.rEdit and not qrData.IsEmpty and (dbgData.FocusedNode.Count=0);
  actDelete .Enabled := dmMain.rEdit and not qrData.IsEmpty and (dbgData.FocusedNode.Count=0);
end;

procedure TfmTPDP.qrDataAfterOpen(DataSet: TDataSet);
begin
  dbgData.FullExpand;
end;

procedure TfmTPDP.dbgDataDblClick(Sender: TObject);
begin
  actEdit.Execute;
end;

procedure TfmTPDP.dbgDataCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
  ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
  var ADone: Boolean);
begin
  if (AColumn = dbgDataWRange) and
     SameText(ANode.Strings[AColumn.Index], 'Независимо от звания')
  then AFont.Color := clGrayText;
  if (AColumn = dbgDataAge) and
     SameText(ANode.Strings[AColumn.Index], 'Без ограничения')
  then AFont.Color := clGrayText;
end;

end.

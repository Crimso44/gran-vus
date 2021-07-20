unit fSubjLst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  dxBar, Db, ADODB, Menus, dxDBTLCl, dxGrClms, dxExEdtr, Variants, Grids,
  DBGrids, cxClasses;

type
  TfmSubjList = class(TForm)
    StatusBar1: TStatusBar;
    dbgData: TdxDBGrid;
    ActionList1: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDel: TAction;
    FrmKeep1: TFrmKeep;
    dxBarManager1: TdxBarManager;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    qrData: TADOQuery;
    DataSource1: TDataSource;
    dbgDataColumn1: TdxDBGridColumn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    sp_SubjCardDelete: TADOStoredProc;
    dbgDataColumn3: TdxDBGridColumn;
    dbgDataColumn10: TdxDBGridColumn;
    N10: TMenuItem;
    actRefresh: TAction;
    N14: TMenuItem;
    dxBarButton10: TdxBarButton;
    dbgDataColumn5: TdxDBGridCheckColumn;
    actCurrent: TAction;
    dxBarButton4: TdxBarButton;
    N4: TMenuItem;
    N5: TMenuItem;
    sp_SubjCurrSet: TADOStoredProc;
    dbgDataColumn4: TdxDBGridColumn;
    actView: TAction;
    dxBarButton5: TdxBarButton;
    N6: TMenuItem;
    dbgDataIsReported: TdxDBGridCheckColumn;
    dbgDataChecked: TdxDBGridCheckColumn;
    dxBarButton6: TdxBarButton;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actCurrentUpdate(Sender: TObject);
    procedure actCurrentExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure dbgDataCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure actExcelExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    FMaximized: Boolean;
  public
    procedure ReOpenList(RequeryOnly: Boolean = False; StorePos: Boolean = True);
  end;

  procedure ShowSubjList;

implementation

uses dMain, fSubjCard, msg, ColumnCustomize, IniSupport, fMain, uVersion;

{$R *.DFM}

procedure ShowSubjList;
var fmSubjList: TfmSubjList;
begin
  Application.CreateForm(TfmSubjList,fmSubjList);
  if fmMain.MainScale <> 100 then
    fmSubjList.ScaleBy(fmMain.MainScale, 100);
  if IsIconic(fmSubjList.Handle) then ShowWindow(fmSubjList.Handle,SW_RESTORE);
  fmSubjList.BringToFront;
end;

procedure TfmSubjList.actAddExecute(Sender: TObject);
  function GetLicenceCount: Integer;
  var d: TDate;
  begin
    Result := 0;
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select getdate()';
      Open;
      d := Fields[0].Value;
      Close;
      SQL.Text := 'exec master..xp_crypt_list 1547';
      try
        Open;
        while not EOF do begin
          if d<FieldByName('ValidityDate').Value then
            Result := Result + FieldByName('LicenceCount').Value;
          Next;
        end;
        Close;
  //substract from result (connection count-1)
        SQL.Text :=
          'select count(spid)'#13+
          'from master.dbo.sysprocesses where dbid=db_id() and spid<>@@spid';
        Open;
        Result := Result - Fields[0].AsInteger;
      except
      end;
      if Result<=0
        then fmMain.Caption := sAppTitle+'(демонстрационный режим)'
        else fmMain.Caption := sAppTitle;
    finally
      Free;
    end;
  end;
begin
  try
    if GetLicenceCount<=0 then
      with TADOQuery.Create(Self) do
      try
        Connection := dmMain.dbMain;
        SQL.Text := 'select count(*) from Subj';
        Open;
        if Fields[0].AsInteger>=5 then
          raise Exception.Create(EmptyStr);
      finally
        Free;
      end;
      ShowSubjCard(0);
  except
    ShowInfo(
      'Система работает в демо-режиме с ограниченным функционированием!'#13+
      'Для активации продукта вызовите команду "Активация продукта..." и пункта "?" главного меню...'
      );
  end;
end;

procedure TfmSubjList.actEditExecute(Sender: TObject);
var AMax: Boolean;
begin
  AMax := IsZoomed(Handle);
  if qrData.IsEmpty then Beep
  else
    ShowSubjCard(qrData.FieldByName('SUBJ_ID').AsInteger);
  FMaximized := AMax;
end;

procedure TfmSubjList.actDelExecute(Sender: TObject);
begin
  if qrData.IsEmpty then Beep
  else
    if Confirm('Удалить карточку выбранного ВУО?') then begin
    sp_SubjCardDelete.Parameters.ParamValues['@SUBJ_ID']:= qrData.FieldValues['SUBJ_ID'];
    sp_SubjCardDelete.ExecProc;
    ReOpenList(True);
  end;
end;

procedure TfmSubjList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmSubjList.FormCreate(Sender: TObject);
begin
  FMaximized := True;
  ReOpenList;
end;

procedure TfmSubjList.ReOpenList(RequeryOnly: Boolean = False; StorePos: Boolean = True);
var Pos: variant;
begin
  Pos:= Null;
  dbgDataIsReported.Visible := true;
  with qrData do begin
    DisableControls;
    try
      if Active then
        Pos:= FieldValues['SUBJ_ID'];
      if RequeryOnly then
        Requery([])
      else begin
        Close;
        SQL.Text := Format(
        'SELECT S.*'#10+
        ', IsCurrent  = CAST(CASE WHEN C.SUBJ_ID IS NULL THEN 0 ELSE 1 END AS bit)'#10+
        ', IsReported = CAST(CASE WHEN S.REPORT_DATE IS NULL OR S.REPORT_DATE < CONVERT(DateTime,''%s'',112) THEN 0 ELSE 1 END AS bit)'#10+
        ', Checked    = CAST(CASE WHEN EXISTS(SELECT * FROM FORM6HDR WHERE CHECKED=0 AND SUBJ_ID=S.SUBJ_ID) THEN 0 ELSE 1 END AS bit)'#10+
        'FROM v_SUBJ S LEFT JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID',
        [FormatDateTime('YYYYMMDD',IniSupport.GetReportDate)]);
        Open;
      end;
      StatusBar1.SimpleText:= 'Всего строк - ' + IntToStr(RecordCount);
    finally
      EnableControls;
    end;
    if StorePos and not VarIsNull(Pos) then
      Locate('SUBJ_ID', Pos, []);
  end;
end;

procedure TfmSubjList.actRefreshExecute(Sender: TObject);
begin
  ReOpenList(True);
end;

procedure TfmSubjList.actCurrentUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:= qrData.Active and not qrData.IsEmpty
    and not qrData.FieldByName('IsCurrent').AsBoolean;
end;

procedure TfmSubjList.actCurrentExecute(Sender: TObject);
begin
  if Confirm('Сделать выбранный ВУО главным?') then begin
    sp_SubjCurrSet.Parameters.ParamValues['@SUBJ_ID']:= qrData.FieldValues['SUBJ_ID'];
    sp_SubjCurrSet.ExecProc;
    ReOpenList(True);
  end;
end;

procedure TfmSubjList.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
var B: Boolean;
begin
  B := qrData.Active and not qrData.IsEmpty;
  actAdd .Enabled := dmMain.rEdit;
  actEdit.Enabled := B and dmMain.rEdit;
  actView.Enabled := B and not dmMain.rEdit;
  actDel .Enabled := B and dmMain.rEdit and not qrData.FieldByName('IsCurrent').AsBoolean;
  actCurrent.Enabled := actDel.Enabled;

  actEdit.Visible := dmMain.rEdit;
  actView.Visible := not dmMain.rEdit;
end;

procedure TfmSubjList.dbgDataCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if ANode.Strings[dbgDataIsReported.Index]='0' then begin
    AColor := $DDDDFF;
    if AFocused  then AColor := AColor-$222222;
  end;  
end;

procedure TfmSubjList.actExcelExecute(Sender: TObject);
begin
  dmMain.GridToExcel(dbgData,Caption,false,true);
end;

procedure TfmSubjList.FormActivate(Sender: TObject);
begin
  if FMaximized then ShowWindow(handle, sw_ShowMaximized);
end;

procedure TfmSubjList.FormDeactivate(Sender: TObject);
begin
  FMaximized := IsZoomed(Handle);
end;

end.


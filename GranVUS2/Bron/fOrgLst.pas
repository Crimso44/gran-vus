unit fOrgLst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin,
  dxBar, Db, ADODB, Menus, dxDBTLCl, dxGrClms, DBCtrls,
  dxEditor, dxExEdtr, dxDBEdtr, dxDBELib, Variants, cxClasses, System.Actions;

type
  TfmOrgList = class(TForm)
    StatusBar1: TStatusBar;
    dbgData: TdxDBGrid;
    ActionList1: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDel: TAction;
    actFiltr: TAction;
    dxBarManager1: TdxBarManager;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    qrData: TADOQuery;
    DataSource1: TDataSource;
    gridORGNAME: TdxDBGridColumn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    sp_OrgCardDelete: TADOStoredProc;
    gridTERR: TdxDBGridColumn;
    gridOKPO: TdxDBGridColumn;
    gridINN: TdxDBGridColumn;
    gridOKBV: TdxDBGridColumn;
    gridLAST_DATE: TdxDBGridColumn;
    gridHAS_F6: TdxDBGridCheckColumn;
    gridPARENT: TdxDBGridColumn;
    gridMAINOKONH: TdxDBGridColumn;
    gridKFS: TdxDBGridColumn;
    gridKOPF: TdxDBGridColumn;
    gridCOMMENT: TdxDBGridColumn;
    gridOUT_DATE: TdxDBGridColumn;
    gridSUBMISSION: TdxDBGridColumn;
    actGenerate: TAction;
    actDeleteF6: TAction;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    sp_GenerateForm6: TADOStoredProc;
    sp_DeleteForm6: TADOStoredProc;
    N6: TMenuItem;
    N61: TMenuItem;
    N7: TMenuItem;
    gridRAB_COUNT: TdxDBGridColumn;
    gridZAP_COUNT: TdxDBGridColumn;
    gridZAB_COUNT: TdxDBGridColumn;
    gridF6CHECKED: TdxDBGridCheckColumn;
    gridHAS_BRON: TdxDBGridCheckColumn;
    qrFS: TADOQuery;
    qrKOPF: TADOQuery;
    qrKONH: TADOQuery;
    qrKTERR: TADOQuery;
    qrVV5: TADOQuery;
    dsFS: TDataSource;
    dsKOPF: TDataSource;
    dsKONH: TDataSource;
    dsKTERR: TDataSource;
    dsVV5: TDataSource;
    actSave: TAction;
    dxBarButton7: TdxBarButton;
    N8: TMenuItem;
    N9: TMenuItem;
    SaveDialog: TSaveDialog;
    actSet: TAction;
    dxBarButton8: TdxBarButton;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    qrSet: TADOQuery;
    actColumns: TAction;
    dxBarButton9: TdxBarButton;
    N13: TMenuItem;
    actRefresh: TAction;
    N14: TMenuItem;
    dxBarButton10: TdxBarButton;
    qrKTERRTERR_ID: TIntegerField;
    qrKTERRKODTERR: TStringField;
    qrKTERRNAME: TStringField;
    gridURADDR: TdxDBGridColumn;
    gridFIZADDR: TdxDBGridColumn;
    gridPOSTADDR: TdxDBGridColumn;
    gridPHONE: TdxDBGridColumn;
    gridFIRST_DATE: TdxDBGridColumn;
    gridREG_PLACE: TdxDBGridColumn;
    gridCHK_DATE: TdxDBGridDateColumn;
    actView: TAction;
    N15: TMenuItem;
    dxBarButton11: TdxBarButton;
    actClearSet: TAction;
    dxBarButton12: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    actExcel: TAction;
    dxBarButton13: TdxBarButton;
    gridKodReg: TdxDBGridColumn;
    gridHEADFAM: TdxDBGridColumn;
    gridVURFAM: TdxDBGridColumn;
    gridHEADPHONE: TdxDBGridColumn;
    gridVURPHONE: TdxDBGridColumn;
    gridKOPF_Changed: TdxDBGridColumn;
    dxbKopf_Changed: TdxBarButton;
    gridEmail: TdxDBGridColumn;
    gridOKVED_Changed: TdxDBGridColumn;
    dxbOkved_Changed: TdxBarButton;
    gridORGSNAME: TdxDBGridColumn;
    gridOKTMO: TdxDBGridColumn;
    dbgDataOrg_Id: TdxDBGridColumn;
    dbgDataCol_10: TdxDBGridColumn;
    dbgDataCol_11: TdxDBGridColumn;
    dbgDataCol_12: TdxDBGridColumn;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actFiltrExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dbgDataColumnClick(Sender: TObject;
      Column: TdxDBTreeListColumn);
    procedure actGenerateExecute(Sender: TObject);
    procedure actDeleteF6Execute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actSetExecute(Sender: TObject);
    procedure actColumnsExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure dbgDataCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure actClearSetExecute(Sender: TObject);
    procedure actExcelExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure dxbKopf_ChangedClick(Sender: TObject);
    procedure dxbOkved_ChangedClick(Sender: TObject);
  private
    FMaximized: Boolean;
    FSQL: string;
    FReportDate: TDateTime;
  public
    FTempFile: string;
    procedure SetFiltr(SQL: String);
    procedure SetKopfFltr;
    procedure SetOkvedFltr;
    procedure ReOpenList(RequeryOnly: Boolean = False; StorePos: Boolean = True);
  end;

  procedure ShowOrgList(isOkopf, isOkved: Boolean);

  var F_isOkopf, F_isOkved: Boolean;

implementation

uses dMain, msg, ColumnCustomize, IniSupport, fFltMgr, fMain,
  fOrgProp, uVERSION;

{$R *.DFM}

procedure ShowOrgList(isOkopf, isOkved: Boolean);
var
  fmOrgList: TfmOrgList;
begin
  F_isOkopf := isOkopf;
  F_isOkved := isOkved;
  Application.CreateForm(TfmOrgList,fmOrgList);
  if fmMain.MainScale <> 100 then
    fmOrgList.ScaleBy(fmMain.MainScale, 100);
  if IsIconic(fmOrgList.Handle) then ShowWindow(fmOrgList.Handle,SW_RESTORE);
  fmOrgList.BringToFront;
end;

procedure TfmOrgList.actAddExecute(Sender: TObject);
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
//check demo-mode
  try
    if GetLicenceCount<=0 then
      with TADOQuery.Create(Self) do
      try
        Connection := dmMain.dbMain;
        SQL.Text := 'select count(*) from Org';
        Open;
        if Fields[0].AsInteger>=10 then
          raise Exception.Create(EmptyStr);
      finally
        Free;
      end;
    fOrgProp.ShowOrgCard(0,Self);
  except
    ShowInfo(
      'Система работает в демо-режиме с ограниченным функционированием!'#13+
      'Для активации продукта вызовите команду "Активация продукта..." и пункта "?" главного меню...'
      );
  end;
end;

procedure TfmOrgList.actEditExecute(Sender: TObject);
var AMax: Boolean;
begin
  AMax :=  IsZoomed(Handle);
  if qrData.IsEmpty then Beep
  else
    fOrgProp.ShowOrgCard(qrData.FieldByName('ORGID').AsInteger,Self);
  FMaximized := AMax;
end;

procedure TfmOrgList.actDelExecute(Sender: TObject);
var
  i: Integer;
begin
  if qrData.IsEmpty then Beep
  else
    if dbgData.SelectedCount = 0 then Beep
    else if dbgData.SelectedCount = 1 then begin
      if Confirm('Удалить карточку выбранной организации?') then begin
        sp_OrgCardDelete.Parameters.ParamValues['@ORG_ID']:= qrData.FieldValues['ORGID'];
        sp_OrgCardDelete.ExecProc;
      end;
    end else begin
      if Confirm('Удалить карточки '+IntToStr(dbgData.SelectedCount)+' выбранных организаций?') then begin
          for i := 0 to dbgData.SelectedCount - 1 do begin
            sp_OrgCardDelete.Parameters.ParamValues['@ORG_ID']:= dbgData.SelectedNodes[i].Strings[dbgDataOrg_ID.Index];
            sp_OrgCardDelete.ExecProc;
          end;
      end;
    end;
  ReOpenList(True);
end;

procedure TfmOrgList.actFiltrExecute(Sender: TObject);
var SQL: string; NewForm: TForm; AMax: Boolean;
begin
  AMax := FMaximized;//if new window
  if GetSQLText(NewForm, True, True, SQL, FTempFile) then SetFiltr(SQL);
  if Assigned(NewForm) then begin
    BringToFront;
    NewForm.BringToFront;
    FMaximized := AMax;
  end;
end;

procedure TfmOrgList.SetFiltr(SQL: String);
begin
  FSQL := SQL;
  ReOpenList;
end;

procedure TfmOrgList.SetKopfFltr;
var
  s: string; NewForm: TForm;
  F: TStringList;
begin
    F := TStringList.Create;
    F.Add('case when IsNull(kopf_changed,0)=0 then 1 else 0 end=(value) = 0');
    F.SaveToFile(FTempFile);
    F.Free;
    if GetSQLText(NewForm, False, False, s, FTempFile) then
      FSQL := s
    else begin
      Close;
      Exit;
    end;
end;

procedure TfmOrgList.SetOkvedFltr;
var
  s: string; NewForm: TForm;
  F: TStringList;
begin
    F := TStringList.Create;
    F.Add('case when IsNull(okved_changed,0)=0 then 1 else 0 end=(value) = 0');
    F.SaveToFile(FTempFile);
    F.Free;
    if GetSQLText(NewForm, False, False, s, FTempFile) then
      FSQL := s
    else begin
      Close;
      Exit;
    end;
end;

procedure TfmOrgList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  DeleteFile(FTempFile);
end;

procedure TfmOrgList.FormCreate(Sender: TObject);
var
  s: string; NewForm: TForm;
  F: TStringList;
begin
  FMaximized := True;
  FTempFile := ExtractFilePath(Application.ExeName)+'~'+IntToStr(GetTickCount)+'.tmp';
  FSQL := 'SELECT * FROM v_ORG';
  if F_isOkopf then begin
    SetKopfFltr;
  end else if F_isOkved then begin
    SetOkvedFltr;
  end else if GetOrgFilter then
    if GetSQLText(NewForm, False, True, s, FTempFile) then
      FSQL := s
    else begin
      Close;
      Exit;
    end;
  ReOpenList;
  if fmMain.IsKopf_Changed_Exists then
    dxbKOPF_Changed.Visible := ivAlways;
  if fmMain.IsOkved_Changed_Exists then
    dxbOkved_Changed.Visible := ivAlways;
end;

procedure TfmOrgList.ReOpenList(RequeryOnly: Boolean = False; StorePos: Boolean = True);
var Pos: variant;
begin
  FReportDate := IniSupport.GetReportDate;
  Pos:= Null;
  with qrData do begin
//    DisableControls;
    try
      if Active then
        Pos:= FieldValues['ORGID'];
      if RequeryOnly then
        Requery([])
      else begin
        Close;
        SQL.Text := FSQL;
        if dbgData.SortedColumnCount > 0 then
          SQL.Add(EasySortClause(dbgData.SortedColumns[0].FieldName, dbgData.SortedColumns[0].Sorted = csUp, 'ORGNAME'));
        Open;
      end;
      if StorePos and not VarIsNull(Pos) then
        Locate('ORGID', Pos, []);
      StatusBar1.SimpleText:= 'Всего строк - ' + IntToStr(RecordCount);
    finally
//      EnableControls;
    end;
  end;
end;

procedure TfmOrgList.dbgDataColumnClick(Sender: TObject;
  Column: TdxDBTreeListColumn);
var
  OldSorted: TdxTreeListColumnSort;
begin
  {with TdxDBGrid(Sender) do
  begin
    OldSorted := Column.Sorted;
    ClearColumnsSorted;
    if OldSorted = csUp then
      Column.Sorted := csDown
    else
      Column.Sorted := csUp;
  end;}
  Application.ProcessMessages;
  ReOpenList;
end;

procedure TfmOrgList.actGenerateExecute(Sender: TObject);
begin
  if not Confirm('Сформировать Форму № 6 выбранной организации?') then Exit;
  with sp_GenerateForm6 do begin
    Parameters.ParamValues['@ORG_ID']:= qrData.FieldByName('ORGID').AsInteger;
    ExecProc;
  end;
  ReOpenList(True);
  ShowInfo('Форма № 6 сформирована. Вы можете вызвать ее из меню "Формы и отчеты".');
end;

procedure TfmOrgList.actDeleteF6Execute(Sender: TObject);
begin
  if not Confirm('Удалить Форму № 6 выбранной организации?') then Exit;
  with sp_DeleteForm6 do begin
    Parameters.ParamValues['@F6_ID']:= qrData.FieldByName('F6_ID').AsInteger;
    ExecProc;
  end;
  ReOpenList(True);
  ShowInfo('Форма № 6 удалена.');
end;

procedure TfmOrgList.actSaveExecute(Sender: TObject);
var Ext: string;
begin
  SaveDialog.FileName:= '';
  if SaveDialog.Execute then begin
    Ext:= AnsiUpperCase(ExtractFileExt(SaveDialog.FileName));
    if Ext = '.XLS' then dbgData.SaveToXLS(SaveDialog.FileName, True)
    else if (Ext = '.HTM') or (Ext = '.HTML') then dbgData.SaveToHTML(SaveDialog.FileName, True)
    else if Ext = '.TXT' then dbgData.SaveToTEXT(SaveDialog.FileName, True, #9, '', '');
  end;
end;

procedure TfmOrgList.actSetExecute(Sender: TObject);
begin
  if not Confirm('Сохранить текущий список (набор) для построения отчетности?') then Exit;
  qrSet.SQL.Text:= 'DELETE FROM ORGSET'#10+
    'INSERT INTO ORGSET (ORGID)'#10+
    'SELECT ORGID '+#10+
    Copy(qrData.SQL.Text,Pos('FROM',qrData.SQL.Text),10000);
  qrSet.ExecSQL;
  ShowInfo('Набор сохранен.');
end;

procedure TfmOrgList.actClearSetExecute(Sender: TObject);
begin
  if not Confirm('Очистить текущий список (набор) для построения отчетности?') then Exit;
  qrSet.SQL.Text:= 'DELETE FROM ORGSET';
  qrSet.ExecSQL;
  ShowInfo('Набор очищен.');
end;

procedure TfmOrgList.actColumnsExecute(Sender: TObject);
begin
  ShowColumnCustomize(dbgData);
end;

procedure TfmOrgList.actRefreshExecute(Sender: TObject);
begin
  ReOpenList(True);
end;

procedure TfmOrgList.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
var
  B: Boolean;
begin
  B := qrData.Active and not qrData.IsEmpty;
  actGenerate.Visible :=
    dmMain.rEdit and B and not qrData.FieldByName('HAS_F6').AsBoolean;
  actDeleteF6.Visible :=
    dmMain.rEdit and B and qrData.FieldByName('HAS_F6').AsBoolean;
  actAdd .Enabled := dmMain.rEdit;
  actDel .Enabled := dmMain.rEdit and B;
  actEdit.Visible := actDel.Enabled;
  actView.Visible := not dmMain.rEdit and B;
  actSave.Enabled := dmMain.rExport;
end;

procedure TfmOrgList.dbgDataCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
const
  scLastDate = $DDDDFF; //Red
  scOutDate  = $DDDDDD; //Gray
  procedure SetColor(const C: TColor);
  begin
    AColor := C;
  end;
begin
  if VarIsNull(ANode.Values[gridLast_Date.Index]) or
     (TDateTime(ANode.Values[gridLast_Date.Index]) < FReportDate)
  then begin
    SetColor(scLastDate);
  end;
  if not VarIsNull(ANode.Values[gridOut_Date.Index]) then begin
    SetColor(scOutDate);
  end;

  if AFocused or ASelected then begin
    AFont.Style := AFont.Style + [fsBold];
    AFont.Color := clBlack;
    if AColor = clHighlight then
      AColor := clWhite - $222222
    else
      AColor := AColor - $222222;
  end;


  if ANode.Strings[gridKOPF_Changed.Index] = '1' then begin
    AFont.Color := clRed;
  end;
  if ANode.Strings[gridOkved_Changed.Index] = '1' then begin
    AFont.Color := clRed;
  end;
end;

procedure TfmOrgList.dxbKopf_ChangedClick(Sender: TObject);
begin
  SetKopfFltr;
  ReOpenList;
end;

procedure TfmOrgList.dxbOkved_ChangedClick(Sender: TObject);
begin
  SetOkvedFltr;
  ReOpenList;
end;

procedure TfmOrgList.actExcelExecute(Sender: TObject);
begin
  dmMain.GridToExcel(dbgData,Caption,true,true);
end;

procedure TfmOrgList.FormActivate(Sender: TObject);
begin
  //while dbgData.GroupColumnCount > 0 do
  //  dbgData.DeleteGroupColumn(0);
  if FMaximized then ShowWindow(handle, sw_ShowMaximized);
end;

procedure TfmOrgList.FormDeactivate(Sender: TObject);
begin
  FMaximized := IsZoomed(Handle);
end;

end.


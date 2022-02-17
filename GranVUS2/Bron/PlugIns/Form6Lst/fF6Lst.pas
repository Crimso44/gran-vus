unit fF6Lst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  dxBar, Db, ADODB, Menus, dxDBTLCl, dxGrClms, dxExEdtr, Variants;

type
  TfmF6List = class(TForm)
    StatusBar1: TStatusBar;
    dbgData: TdxDBGrid;
    ActionList1: TActionList;
    actClear: TAction;
    qrData: TADOQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    N3: TMenuItem;
    sp_Form6Clear: TADOStoredProc;
    dbgDataColumn3: TdxDBGridColumn;
    dbgDataColumn10: TdxDBGridColumn;
    dbgDataColumn11: TdxDBGridColumn;
    dbgDataColumn12: TdxDBGridColumn;
    actGenerate: TAction;
    sp_GenerateResultForm6: TADOStoredProc;
    N61: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    actCreate: TAction;
    ToolButton3: TToolButton;
    N1: TMenuItem;
    actEdit: TAction;
    ToolButton4: TToolButton;
    sp_Form6Create: TADOStoredProc;
    N2: TMenuItem;
    actPrint: TAction;
    ToolButton5: TToolButton;
    N4: TMenuItem;
    actView: TAction;
    ToolButton6: TToolButton;
    N5: TMenuItem;
    dbgDataColumn6: TdxDBGridCheckColumn;
    qrDataF6_ID: TAutoIncField;
    qrDataORGID: TIntegerField;
    qrDataORGNAME: TStringField;
    qrDataF6_SHIFR: TStringField;
    qrDataORG_SHIFR: TStringField;
    qrDataF6_COUNT: TIntegerField;
    qrDataKUO_COUNT: TIntegerField;
    qrDataRAB_COUNT: TIntegerField;
    qrDataZAP_COUNT: TIntegerField;
    qrDataZAB_COUNT: TIntegerField;
    qrDataCHECKED: TBooleanField;
    qrDataCONFDATE: TDateTimeField;
    qrDataSUBJ_ID: TIntegerField;
    qrDataComment: TStringField;
    dbgDataColumn7: TdxDBGridMaskColumn;
    actPrintF5: TAction;
    ToolButton7: TToolButton;
    procedure actClearExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure actGenerateExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actEditUpdate(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure actGenerateUpdate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actViewExecute(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure qrDataCalcFields(DataSet: TDataSet);
    procedure actPrintF5Execute(Sender: TObject);
  private
    rEdit: Boolean;
  public
    ID: Integer;
    procedure ReOpenList(RequeryOnly: Boolean = False; StorePos: Boolean = True);
    function GetCurrSubjID: Integer;
  end;

  TPlugInExecF6 =
    function (AppHandle: THandle; Conn: _Connection; nF6ID: Integer): Integer; stdcall;

var
  fmF6List    : TfmF6List;
  fmF6List_ID : Integer;

implementation

uses dMain, msg, fFilDlg, IniSupport, SaveEvents;

{$R *.DFM}

procedure TfmF6List.actClearExecute(Sender: TObject);
begin
  if not Confirm('Удалить формы № 6 субъекта?') then Exit;
  sp_Form6Clear.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_Form6Clear.ExecProc;
  ReOpenList(True);
end;

procedure TfmF6List.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmF6List.FormCreate(Sender: TObject);
begin
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;  ParamCheck := False;
    SQL.Text := 'SELECT * FROM Users WHERE ID = '+IntToStr(GetLastUserID);
    Open;
    rEdit := FieldByName('rEdit').AsBoolean;
  finally Free;
  end;
  ID := fmF6List_ID;
  ReOpenList;
  actClear    .Visible := not FPrintOnly;
  actGenerate .Visible := not FPrintOnly and (ID > 0) and (ID = GetCurrSubjID);
  actCreate   .Visible := not FPrintOnly;
  actEdit     .Visible := not FPrintOnly and rEdit;
  actView     .Visible := not FPrintOnly and not rEdit;
  actPrint    .Visible := FPrintOnly;
  actPrintF5  .Visible := FPrintOnly;
  actClear    .Enabled := rEdit;
  actGenerate .Enabled := rEdit;
  actCreate   .Enabled := rEdit;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; ParamCheck := false;
    SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ WHERE SUBJ_ID = '+IntToStr(ID);
    Open;
    Caption := Caption+' - '+Fields[0].AsString;
  finally Free;
  end;
end;

procedure TfmF6List.actGenerateUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:= rEdit and qrData.Active and not qrData.IsEmpty;
end;

procedure TfmF6List.ReOpenList(RequeryOnly: Boolean = False; StorePos: Boolean = True);
var Pos: variant;
begin
  Pos:= Null;
  with qrData do begin
    try
      if Active then
        Pos:= FieldValues['F6_ID'];
      if RequeryOnly then
        Requery([])
      else begin
        Close;
        SQL.Text :=
        'SELECT *'#10+
        'FROM FORM6HDR'#10+
        'WHERE SUBJ_ID = ' + IntToStr(ID) + #10 +
        'ORDER BY F6_SHIFR'#10;
        Open;
      end;
    finally
    end;
    if StorePos and not VarIsNull(Pos) then
      Locate('F6_ID', Pos, []);
  end;
end;

procedure TfmF6List.actGenerateExecute(Sender: TObject);
var FilterType: SmallInt;
begin
  FilterType:= 1;
  if ShowFltDlg(FilterType) <> mrOk then Exit;
  with sp_GenerateResultForm6 do begin
    ProcedureName:= 'sp_GenerateForm6_' + qrData.FieldByName('F6_SHIFR').AsString;
    Parameters.Clear;
    Parameters.CreateParameter('@F6_ID', ftInteger, pdInput, 0, qrData.FieldByName('F6_ID').AsInteger);
    Parameters.CreateParameter('@FilterType', ftInteger, pdInput, 0, FilterType);
    ExecProc;
  end;
  ReOpenList(True);
  ShowMessage('Форма № 6 сформирована.');
end;

procedure TfmF6List.actEditExecute(Sender: TObject);
const
  Method: array [Boolean] of String = ('PlugInExecForm','PlugInExec');
var
  hDll: THandle;
  fnExec: Pointer;
begin
  hDll := LoadLibrary(PChar(IniSupport.GetPluginsDir + '\form6.dll'));
  if hDll=0 then ShowErr('Ошибка при загрузке плагина: form6.dll')
  else begin
    fnExec := GetProcAddress(hDll,PChar(Method[FPrintOnly]));
    TPlugInExecF6(fnExec)(Application.Handle, dmMain.dbMain.ConnectionObject, qrData.FieldByName('F6_ID').AsInteger);
    FreeLibrary(hDll);
  end;
  ReOpenList(True);
end;

procedure TfmF6List.actViewExecute(Sender: TObject);
begin
  actEditExecute(Sender);
end;


procedure TfmF6List.actPrintExecute(Sender: TObject);
begin
  actEditExecute(Sender);
end;

procedure TfmF6List.actPrintF5Execute(Sender: TObject);
const
  Method: array [Boolean] of String = ('PlugInExecForm','PlugInExec');
var
  hDll: THandle;
  fnExec: Pointer;
begin
  hDll := LoadLibrary(PChar(IniSupport.GetPluginsDir + '\form6.dll'));
  if hDll=0 then ShowErr('Ошибка при загрузке плагина: form6.dll')
  else begin
    fnExec := GetProcAddress(hDll,PChar(Method[FPrintOnly]));
    TPlugInExecF6(fnExec)(Application.Handle, dmMain.dbMain.ConnectionObject, -qrData.FieldByName('F6_ID').AsInteger);
    FreeLibrary(hDll);
  end;
  ReOpenList(True);
end;

procedure TfmF6List.actEditUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:= qrData.Active and not qrData.IsEmpty;
end;

function TfmF6List.GetCurrSubjID: Integer;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT SUBJ_ID FROM CURR_SUBJ';
    try
      Open;
      if IsEmpty
        then Result := 0
        else Result := Fields[0].AsInteger;
    except
      Result := -1;
    end;
  finally Free;
  end;
end;

procedure TfmF6List.qrDataCalcFields(DataSet: TDataSet);
begin
  if qrDataF6_SHIFR.Value = '01' then
    qrDataComment.Value := 'По всем организациям, расположенным на территории ВУО (только для территориальных ВУО)'
  else if qrDataF6_SHIFR.Value = '02' then
    qrDataComment.Value := 'По организациям, не относящимся к сфере ведения ФОГВ'
  else if qrDataF6_SHIFR.Value = '03' then
    qrDataComment.Value := 'По организациям, относящимся к территориальным органам управления'
  else if qrDataF6_SHIFR.Value = '04' then
    qrDataComment.Value := 'По всем организациям, подведомственным федеральному органу исполнительной власти (ФОГВ) (только для отраслевых ВУО)'
  else if qrDataF6_SHIFR.Value = '05' then
    qrDataComment.Value := 'По организациям, относящимся к аппарату ФОГВ (только для отраслевых ВУО)'
  else if qrDataF6_SHIFR.Value = '06' then
    qrDataComment.Value := 'По организациям ФОГВ, расположенным на территории Дальнего Востока или Забайкалья (только для отраслевых ВУО)';
end;

procedure TfmF6List.actCreateExecute(Sender: TObject);
begin
  if not Confirm('Удалить формы № 6 субъекта и сформировать пустые?') then Exit;
  sp_Form6Create.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_Form6Create.ExecProc;
  ReOpenList(True);
end;

procedure TfmF6List.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;


end.


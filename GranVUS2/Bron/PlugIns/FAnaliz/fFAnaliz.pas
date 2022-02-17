unit fFAnaliz;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, Menus, ActnList, dxTL, dxDBCtrl, dxDBGrid, dxCntner, ComCtrls,
  ToolWin, dxExEdtr, FrmKeep, Variants;

type
  TfmFSVT = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    dxDBGrid: TdxDBGrid;
    NAMEColumn: TdxDBGridColumn;
    dsData: TDataSource;
    ActionList: TActionList;
    actGenerate: TAction;
    actPrint: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    qrData: TADOQuery;
    actClear: TAction;
    actCreate: TAction;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    sp_FAnalizCreate: TADOStoredProc;
    sp_FAnalizClear: TADOStoredProc;
    sp_FAnalizGenerate: TADOStoredProc;
    actExcel: TAction;
    ToolButton5: TToolButton;
    qrKAnaliz: TADOQuery;
    qrKAnalizNUM: TIntegerField;
    qrKAnalizNAME: TStringField;
    qrDataSUBJ_ID: TIntegerField;
    qrDataNUM: TIntegerField;
    qrDataNAME: TStringField;
    dxDBGridNUM: TdxDBGridColumn;
    ToolButton6: TToolButton;
    actCheck: TAction;
    qrDataN01: TIntegerField;
    qrDataN02: TIntegerField;
    qrDataN10: TIntegerField;
    qrDataN12: TIntegerField;
    qrDataN01_10: TIntegerField;
    qrDataN01_10_12: TIntegerField;
    dxDBGridN01: TdxDBGridMaskColumn;
    dxDBGridN02: TdxDBGridMaskColumn;
    dxDBGridN10: TdxDBGridMaskColumn;
    dxDBGridN12: TdxDBGridMaskColumn;
    dxDBGridN01_10: TdxDBGridColumn;
    dxDBGridN01_10_12: TdxDBGridColumn;
    dxDBGridN06: TdxDBGridColumn;
    qrDataN06: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actGenerateExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actExcelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dxDBGridColumnSorting(Sender: TObject;
      Column: TdxDBTreeListColumn; var Allow: Boolean);
    procedure qrDataCalcFields(DataSet: TDataSet);
    procedure qrDataBeforePost(DataSet: TDataSet);
    procedure dxDBGridEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure dxDBGridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure dxDBGridEditing(Sender: TObject; Node: TdxTreeListNode;
      var Allow: Boolean);
  private
  public
    ID: Integer;
    function GetCurrSubjID: Integer;
  end;

var
  fmFSVT    : TfmFSVT;

implementation

{$R *.DFM}

uses dMain, fOtrDlg, msg, rdialogs;

procedure TfmFSVT.FormShow(Sender: TObject);
begin
  actGenerate.Visible:= (ID > 0) and (ID = GetCurrSubjID);
  qrData.Parameters.ParamByName('SUBJ_ID').Value := ID;
  qrData.Open;
  if qrData.RecordCount < 6 then begin
    actCreateExecute(nil);
    qrData.Close;
    qrData.Open;
  end;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; ParamCheck := false;
    SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ WHERE SUBJ_ID = '+IntToStr(ID);
    Open;
    Caption := Caption+' - '+Fields[0].AsString;
  finally Free;
  end;
end;

procedure TfmFSVT.actPrintExecute(Sender: TObject);
begin
  dxDBGrid.CancelEditor;
  dmMain.PrintData(ID);
end;

procedure TfmFSVT.dxDBGridColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := False;
end;

procedure TfmFSVT.dxDBGridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; ASelected,
  AFocused, ANewItemRow: Boolean; var AText: string; var AColor: TColor;
  AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
begin
  if ANode.Strings[dxDBGridNum.Index] = '1000' then
    AColor := clSilver;
end;

procedure TfmFSVT.dxDBGridEdited(Sender: TObject; Node: TdxTreeListNode);
var
  i: Integer;
  s: String;
begin
  i := qrData.RecNo;
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    s := VarToStr(dxDBGrid.FocusedField.Value);
    if s = '' then s := 'NULL';
    SQL.Text := Format('update FAnaliz set %s = %s where NUM = %s AND SUBJ_ID = %s',
      [dxDBGrid.FocusedField.FieldName,  s, IntToStr(qrDataNUM.Value),
        IntToStr(qrDataSUBJ_ID.Value)]);
    ExecSQL;
    s := Format('update FAnaliz set %s = '+
      '(select sum(%s) from FAnaliz ff where ff.Num in (100,200,300,400) AND SUBJ_ID = %s) '+
      'where NUM = 1000 AND SUBJ_ID = %s',
      [dxDBGrid.FocusedField.FieldName,  dxDBGrid.FocusedField.FieldName,
       IntToStr(qrDataSUBJ_ID.Value), IntToStr(qrDataSUBJ_ID.Value)]);
    SQL.Text := s;
    ExecSQL;
  finally
    Free;
  end;
  qrData.Close;
  qrData.Open;
  qrData.RecNo := i;
end;

procedure TfmFSVT.dxDBGridEditing(Sender: TObject; Node: TdxTreeListNode;
  var Allow: Boolean);
begin
  if Node.Strings[dxDBGridNum.Index] = '1000' then
    Allow := False;
end;

function TfmFSVT.GetCurrSubjID: Integer;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT SUBJ_ID FROM CURR_SUBJ';
    try
      Open;
      if IsEmpty then Result := 0
      else Result := Fields[0].AsInteger;
    except
      Result := -1;
    end;
  finally Free;
  end;
end;

procedure TfmFSVT.qrDataBeforePost(DataSet: TDataSet);
begin
  Abort;
end;

procedure TfmFSVT.qrDataCalcFields(DataSet: TDataSet);
begin
  qrDataN01_10.AsInteger := qrDataN01.AsInteger - qrDataN10.AsInteger;
  qrDataN01_10_12.AsInteger := qrDataN01.AsInteger - qrDataN10.AsInteger - qrDataN12.AsInteger;
end;

procedure TfmFSVT.actGenerateExecute(Sender: TObject);
var IsFull: Boolean; FilterType: SmallInt;
begin
  dxDBGrid.CancelEditor;
  IsFull:= True;
  FilterType := 1;
  if ShowOtrDlg(IsFull, FilterType) = mrOk then begin
    sp_FAnalizGenerate.Parameters.ParamByName('@SUBJ_ID').Value := ID;
    sp_FAnalizGenerate.Parameters.ParamByName('@IS_FULL').Value := IsFull;
    sp_FAnalizGenerate.Parameters.ParamByName('@FilterType').Value := FilterType;
    sp_FAnalizGenerate.ExecProc;
    qrData.Close;
    qrData.Open;
  end;
end;

procedure TfmFSVT.actClearExecute(Sender: TObject);
begin
  if not Confirm('Очистить форму?') then Exit;
  qrData.Close;
  sp_FAnalizClear.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FAnalizClear.ExecProc;
  qrData.Open;
end;

procedure TfmFSVT.actCreateExecute(Sender: TObject);
begin
  if Sender <> nil then if not Confirm('Очистить форму и сформировать пустую?') then Exit;
  dxDBGrid.CancelEditor;
  qrData.Close;
  sp_FAnalizCreate.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FAnalizCreate.ExecProc;
  qrData.Open;
end;

procedure TfmFSVT.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

procedure TfmFSVT.actExcelExecute(Sender: TObject);
begin
  dxDBGrid.CancelEditor;
  dmMain.GridToExcel(dxDBGrid,Caption,false,true);
end;

procedure TfmFSVT.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  dxDBGrid.CancelEditor;
  CanClose := True;
  try if qrData.State = dsEdit then qrData.Post
  except   CanClose := False;
  end;
end;

end.

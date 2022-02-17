unit fFSVT;

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
    sp_FSVTCreate: TADOStoredProc;
    sp_FSVTClear: TADOStoredProc;
    sp_FSVTGenerate: TADOStoredProc;
    actExcel: TAction;
    ToolButton5: TToolButton;
    qrKSVT: TADOQuery;
    qrKSVTNUM: TIntegerField;
    qrKSVTNAME: TStringField;
    qrDataSUBJ_ID: TIntegerField;
    qrDataNUM: TIntegerField;
    qrDataNAME: TStringField;
    dxDBGridNUM: TdxDBGridColumn;
    ToolButton6: TToolButton;
    actCheck: TAction;
    qrDataN02: TIntegerField;
    qrDataN03: TIntegerField;
    qrDataN04: TIntegerField;
    qrDataN05: TIntegerField;
    qrDataN06: TIntegerField;
    qrDataN07: TIntegerField;
    qrDataN08: TIntegerField;
    qrDataN09: TIntegerField;
    qrDataN10: TIntegerField;
    qrDataN11: TIntegerField;
    dxDBGridN02: TdxDBGridMaskColumn;
    dxDBGridN03: TdxDBGridMaskColumn;
    dxDBGridN04: TdxDBGridMaskColumn;
    dxDBGridN05: TdxDBGridMaskColumn;
    dxDBGridN06: TdxDBGridMaskColumn;
    dxDBGridN07: TdxDBGridMaskColumn;
    dxDBGridN08: TdxDBGridMaskColumn;
    dxDBGridN09: TdxDBGridMaskColumn;
    dxDBGridN10: TdxDBGridMaskColumn;
    dxDBGridN11: TdxDBGridMaskColumn;
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
  if qrData.RecordCount < 4 then begin
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
    SQL.Text := Format('update FSVT2012 set %s = %s where NUM = %s AND SUBJ_ID = %s',
      [dxDBGrid.FocusedField.FieldName,  s, IntToStr(qrDataNUM.Value),
        IntToStr(qrDataSUBJ_ID.Value)]);
    ExecSQL;
  finally
    Free;
  end;
  qrData.Close;
  qrData.Open;
  qrData.RecNo := i;
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
var
  v: Variant;
  f: Double;
begin
end;

procedure TfmFSVT.actGenerateExecute(Sender: TObject);
var IsFull: Boolean; FilterType: SmallInt;
begin
  dxDBGrid.CancelEditor;
  IsFull:= True;
  FilterType := 1;
  if ShowOtrDlg(IsFull, FilterType) = mrOk then begin
    sp_FSVTGenerate.Parameters.ParamByName('@SUBJ_ID').Value := ID;
    sp_FSVTGenerate.Parameters.ParamByName('@IS_FULL').Value := IsFull;
    sp_FSVTGenerate.Parameters.ParamByName('@FilterType').Value := FilterType;
    sp_FSVTGenerate.ExecProc;
    qrData.Close;
    qrData.Open;
  end;
end;

procedure TfmFSVT.actClearExecute(Sender: TObject);
begin
  if not Confirm('Очистить форму?') then Exit;
  qrData.Close;
  sp_FSVTClear.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FSVTClear.ExecProc;
  qrData.Open;
end;

procedure TfmFSVT.actCreateExecute(Sender: TObject);
begin
  if Sender <> nil then if not Confirm('Очистить форму и сформировать пустую?') then Exit;
  dxDBGrid.CancelEditor;
  qrData.Close;
  sp_FSVTCreate.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FSVTCreate.ExecProc;
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

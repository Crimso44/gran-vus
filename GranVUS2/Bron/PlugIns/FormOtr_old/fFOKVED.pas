unit fFOKVED;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, Menus, ActnList, dxTL, dxDBCtrl, dxDBGrid, dxCntner, ComCtrls,
  ToolWin, dxExEdtr, FrmKeep;

type
  TfmFOKVED = class(TForm)
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    dxDBGrid: TdxDBGrid;
    KBONH_IDColumn: TdxDBGridColumn;
    KBONH_NAMEColumn: TdxDBGridColumn;
    RAB_COUNTColumn: TdxDBGridColumn;
    ZAP_COUNTColumn: TdxDBGridColumn;
    ZAB_COUNTColumn: TdxDBGridColumn;
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
    sp_FOKVEDCreate: TADOStoredProc;
    sp_FOKVEDClear: TADOStoredProc;
    sp_FOKVEDGenerate: TADOStoredProc;
    ORG_COUNTColumn: TdxDBGridColumn;
    ORG_BRON_COUNTColumn: TdxDBGridColumn;
    FrmKeep1: TFrmKeep;
    actExcel: TAction;
    ToolButton5: TToolButton;
    ORG_WU_COUNTColumn: TdxDBGridColumn;
    qrKOKVED: TADOQuery;
    qrDataOKVED_SECTION: TStringField;
    qrKOKVEDOKVED_SECTION: TStringField;
    qrKOKVEDN: TIntegerField;
    qrKOKVEDSECTION: TStringField;
    qrDataN: TIntegerField;
    qrDataSECTION: TStringField;
    qrDataORG_COUNT: TIntegerField;
    qrDataORG_BRON_COUNT: TIntegerField;
    qrDataORG_WU_COUNT: TIntegerField;
    qrDataRAB_COUNT: TIntegerField;
    qrDataZAP_COUNT: TIntegerField;
    qrDataZAB_COUNT: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actGenerateExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actExcelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
  public
    ID: Integer;
    function GetCurrSubjID: Integer;
  end;

var
  fmFOKVED    : TfmFOKVED;

implementation

{$R *.DFM}

uses dMain, fOtrDlg, msg;

procedure TfmFOKVED.FormShow(Sender: TObject);
begin
  actGenerate.Visible:= (ID > 0) and (ID = GetCurrSubjID);
  qrData.Parameters.ParamByName('SUBJ_ID').Value := ID;
  qrData.Open;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; ParamCheck := false;
    SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ WHERE SUBJ_ID = '+IntToStr(ID);
    Open;
    Caption := Caption+' - '+Fields[0].AsString;
  finally Free;
  end;
end;

procedure TfmFOKVED.actPrintExecute(Sender: TObject);
begin
  dmMain.PrintData(ID);
end;

function TfmFOKVED.GetCurrSubjID: Integer;
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

procedure TfmFOKVED.actGenerateExecute(Sender: TObject);
var IsFull: Boolean; FilterType: SmallInt;
begin
  IsFull:= True;
  FilterType := 1;
  if ShowOtrDlg(IsFull, FilterType) = mrOk then begin
    sp_FOKVEDGenerate.Parameters.ParamByName('@SUBJ_ID').Value := ID;
    sp_FOKVEDGenerate.Parameters.ParamByName('@IS_FULL').Value := IsFull;
    sp_FOKVEDGenerate.Parameters.ParamByName('@FilterType').Value := FilterType;
    sp_FOKVEDGenerate.ExecProc;
    qrData.Close;
    qrData.Open;
  end;
end;

procedure TfmFOKVED.actClearExecute(Sender: TObject);
begin
  if not Confirm('Очистить форму?') then Exit;
  qrData.Close;
  sp_FOKVEDClear.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FOKVEDClear.ExecProc;
  qrData.Open;
end;

procedure TfmFOKVED.actCreateExecute(Sender: TObject);
begin
  if not Confirm('Очистить форму и сформировать пустую?') then Exit;
  qrData.Close;
  sp_FOKVEDCreate.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FOKVEDCreate.ExecProc;
  qrData.Open;
end;

procedure TfmFOKVED.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

procedure TfmFOKVED.actExcelExecute(Sender: TObject);
begin
  dmMain.GridToExcel(dxDBGrid,Caption,false,true);
end;

procedure TfmFOKVED.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  try if qrData.State = dsEdit then qrData.Post
  except   CanClose := False;
  end;
end;

end.

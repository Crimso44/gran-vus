unit fF6BriefLst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  Db, ADODB, Menus, dxDBTLCl, dxGrClms, Variants, dxExEdtr, StdCtrls;

type
  TfmF6BriefList = class(TForm)
    StatusBar1: TStatusBar;
    dbgData: TdxDBGrid;
    ActionList1: TActionList;
    FrmKeep1: TFrmKeep;
    qrData: TADOQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    dbgDataColumn10: TdxDBGridColumn;
    dbgDataColumn11: TdxDBGridColumn;
    dbgDataColumn3: TdxDBGridColumn;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    PrintAction: TAction;
    N1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PrintActionExecute(Sender: TObject);
    procedure PrintActionUpdate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FFilterType: Byte;
  public
    procedure ReOpenList(RequeryOnly: Boolean = False; StorePos: Boolean = True);
  end;

var
  fmF6BriefList: TfmF6BriefList;

implementation

uses dMain, fFilDlg;

{$R *.DFM}

procedure TfmF6BriefList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmF6BriefList.FormCreate(Sender: TObject);
begin
  FFilterType := $01;
  ReOpenList;
end;

procedure TfmF6BriefList.ReOpenList(RequeryOnly: Boolean = False; StorePos: Boolean = True);
var Pos: variant;
begin
  Pos:= Null;
  with qrData do begin
    DisableControls;
    try
      if Active then
        Pos:= FieldValues['ID'];
      if RequeryOnly then
        Requery([])
      else begin
        Close;
        SQL.Text :=
        'SELECT *'#10+
        'FROM FORM6BRIEF'#10+
        'ORDER BY F6_SHIFR'#10;
        Open;
      end;
    finally
      EnableControls;
    end;
    if StorePos and not VarIsNull(Pos) then
      Locate('ID', Pos, []);
  end;
end;

procedure TfmF6BriefList.PrintActionExecute(Sender: TObject);
begin
  if ShowFltDlg(FFilterType) <> mrOk then Exit;
  dmMain.PrintData(qrData.FieldByName('ID').AsInteger, FFilterType);
end;

procedure TfmF6BriefList.PrintActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:= qrData.Active and not qrData.IsEmpty;
end;

procedure TfmF6BriefList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.


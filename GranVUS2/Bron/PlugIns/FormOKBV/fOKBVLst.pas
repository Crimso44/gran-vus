unit fOKBVLst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  Db, ADODB, Menus, dxDBTLCl, dxGrClms, dxExEdtr;

type
  TfmOKBVList = class(TForm)
    StatusBar1: TStatusBar;
    dbgData: TdxDBGrid;
    ActionList1: TActionList;
    qrData: TADOQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    dbgDataColumn10: TdxDBGridColumn;
    dbgDataColumn11: TdxDBGridColumn;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    PrintAction: TAction;
    N1: TMenuItem;
    dbgDataColumn4: TdxDBGridColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure PrintActionExecute(Sender: TObject);
    procedure PrintActionUpdate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
  end;

var
  fmOKBVList: TfmOKBVList;

implementation

uses dMain;

{$R *.DFM}

procedure TfmOKBVList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmOKBVList.FormCreate(Sender: TObject);
begin
  qrData.Open;
end;

procedure TfmOKBVList.PrintActionExecute(Sender: TObject);
begin
  dmMain.PrintData(qrData.FieldByName('ID').AsInteger);
end;

procedure TfmOKBVList.PrintActionUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled:= qrData.Active and not qrData.IsEmpty;
end;

procedure TfmOKBVList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.


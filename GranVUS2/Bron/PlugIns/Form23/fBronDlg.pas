unit fBronDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  Db, ADODB, Menus, dxDBTLCl, dxGrClms, StdCtrls, ExtCtrls;

type
  TfmBronDlg = class(TForm)
    FrmKeep1: TFrmKeep;
    bPrint: TButton;
    bCancel: TButton;
    rgFilter: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bPrintClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
  end;

var
  fmBronDlg: TfmBronDlg;

implementation

uses dMain;

{$R *.DFM}

procedure TfmBronDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmBronDlg.bPrintClick(Sender: TObject);
begin
  dmMain.PrintData(rgFilter.ItemIndex);
  Close;
end;

procedure TfmBronDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.


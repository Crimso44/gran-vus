unit fFilDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  Db, ADODB, Menus, dxDBTLCl, dxGrClms, StdCtrls, ExtCtrls, dMain;

type
  TfmFilDlg = class(TForm)
    bPrint: TButton;
    bCancel: TButton;
    Label1: TLabel;
    cbSort: TComboBox;
    rgFilter: TRadioGroup;
    chDesc: TCheckBox;
    rgShifr: TRadioGroup;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
  end;

  function ShowFltDlg(var AFilter: TFilter): Boolean;

implementation

{$R *.DFM}

function ShowFltDlg(var AFilter: TFilter): Boolean;
begin
  with TfmFilDlg.Create(Application), AFilter do
  try
//    rgShifr.ItemIndex  := fShifr;
//    rgFilter.ItemIndex := fFilter;
//    cbSort.ItemIndex   := fSort;
//    chDesc.Checked     := Boolean(fDesc);
    Result:= ShowModal=mrOk;
    fShifr  := rgShifr.ItemIndex;
    fFilter := rgFilter.ItemIndex;
    fSort   := cbSort.ItemIndex;
    fDesc   := Byte(chDesc.Checked);
  finally
    Free;
  end;
end;


procedure TfmFilDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.


unit fFilDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  Db, ADODB, Menus, dxDBTLCl, dxGrClms, StdCtrls, ExtCtrls;

type
  TfmFilDlg = class(TForm)
    FrmKeep1: TFrmKeep;
    bPrint: TButton;
    bCancel: TButton;
    rgFilter: TRadioGroup;
    procedure bPrintClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
  end;

  function ShowFltDlg(var FilterType: SmallInt): Integer;

var fmFilDlg: TfmFilDlg;
  
implementation

uses dMain;

{$R *.DFM}

function ShowFltDlg(var FilterType: SmallInt): Integer;
begin
  with TfmFilDlg.Create(Application) do try
    rgFilter.ItemIndex := FilterType;
    Result:= ShowModal;
    FilterType := rgFilter.ItemIndex;
  finally
    Free;
  end;
end;


procedure TfmFilDlg.bPrintClick(Sender: TObject);
var FilterType: SmallInt;
begin
  FilterType := rgFilter.ItemIndex;
  dmMain.PrintData(FilterType);
  Close;
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


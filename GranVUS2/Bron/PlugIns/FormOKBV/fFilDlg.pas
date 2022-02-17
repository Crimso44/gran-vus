unit fFilDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  Db, ADODB, Menus, dxDBTLCl, dxGrClms, StdCtrls, ExtCtrls;

type
  TfmFilDlg = class(TForm)
    bOK: TButton;
    bCancel: TButton;
    rgShifr: TRadioGroup;
    rgFilter: TRadioGroup;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
  end;

  function ShowFltDlg(var Shifr, Filter: Byte): Boolean;

implementation

uses dMain;

{$R *.DFM}

function ShowFltDlg(var Shifr, Filter: Byte): Boolean;
begin
  with TfmFilDlg.Create(Application) do try
    rgShifr.ItemIndex := Shifr;
    rgFilter.ItemIndex := Filter;
    Result := ShowModal=mrOk;
    Shifr := rgShifr.ItemIndex;
    Filter := rgFilter.ItemIndex;
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


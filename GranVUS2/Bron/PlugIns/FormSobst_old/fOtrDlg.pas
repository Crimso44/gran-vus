unit fOtrDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  Db, ADODB, Menus, dxDBTLCl, dxGrClms, StdCtrls;

type
  TfmOtrDlg = class(TForm)
    rbAll: TRadioButton;
    rbFiltered: TRadioButton;
    bOK: TButton;
    bCancel: TButton;
    rbNative: TRadioButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
  end;

  function ShowOtrDlg(var FilterType: SmallInt): Integer;

implementation

uses dMain;

{$R *.DFM}

function ShowOtrDlg(var FilterType: SmallInt): Integer;
begin
  with TfmOtrDlg.Create(Application) do try
    case FilterType of
      0: rbAll.Checked := true;
      1: rbNative.Checked := true;
      2: rbFiltered.Checked := true;
    end;
    Result:= ShowModal;
    if rbAll.Checked then FilterType := 0
    else
      if rbNative.Checked then FilterType := 1
      else FilterType := 2;
  finally
    Free;
  end;
end;

procedure TfmOtrDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.


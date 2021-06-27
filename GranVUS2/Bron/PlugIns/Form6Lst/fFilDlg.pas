unit fFilDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  Db, ADODB, Menus, dxDBTLCl, dxGrClms, StdCtrls;

type
  TfmFilDlg = class(TForm)
    FrmKeep1: TFrmKeep;
    GroupBox2: TGroupBox;
    rbAll: TRadioButton;
    rbFiltered: TRadioButton;
    bPrint: TButton;
    bCancel: TButton;
    rbSelf: TRadioButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
  end;

  function ShowFltDlg(var FilterType: SmallInt): Integer;

implementation

uses dMain;

{$R *.DFM}

function ShowFltDlg(var FilterType: SmallInt): Integer;
begin
  with TfmFilDlg.Create(Application) do try
    case FilterType of
    0: rbAll.Checked := true;
    1: rbSelf.Checked := true;
    else
      rbFiltered.Checked := true;
    end;
    Result:= ShowModal;
    if rbAll.Checked then FilterType :=0
    else
      if rbSelf.Checked then FilterType := 1
      else FilterType := 2;
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


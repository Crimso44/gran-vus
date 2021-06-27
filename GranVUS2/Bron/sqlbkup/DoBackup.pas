unit DoBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfDoBackup = class(TForm)
    Label1: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    eName: TEdit;
    cRewrite: TCheckBox;
    ePlace: TEdit;
    SaveDialog1: TSaveDialog;
    bOpenFile: TSpeedButton;
    procedure bOpenFileClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDoBackup: TfDoBackup;

implementation

{$R *.dfm}

procedure TfDoBackup.bOpenFileClick(Sender: TObject);
begin
  if SaveDialog1.Execute(Handle) then
    ePlace.Text := SaveDialog1.Files[0];
end;

procedure TfDoBackup.btnOkClick(Sender: TObject);
begin
  if ePlace.Enabled and (ePlace.Text = '') then begin
    ePlace.SetFocus;
    ShowMessage('Пожалуйста, введите имя файла!');
    ModalResult := mrNone;
  end;
end;

end.

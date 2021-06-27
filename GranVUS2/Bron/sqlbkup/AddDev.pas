unit AddDev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfAddDev = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    eName: TEdit;
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    eFilePath: TEdit;
    SpeedButton1: TSpeedButton;
    SaveDialog1: TSaveDialog;
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAddDev: TfAddDev;

implementation

{$R *.dfm}

procedure TfAddDev.btnOkClick(Sender: TObject);
begin
  if eName.Text = '' then begin
    eName.SetFocus;
    ShowMessage('Пожалуйста, введите имя устройства!');
    ModalResult := mrNone;
  end;
  if eFilePath.Text = '' then begin
    eFilePath.SetFocus;
    ShowMessage('Пожалуйста, введите путь к файлу!');
    ModalResult := mrNone;
  end;
end;

procedure TfAddDev.SpeedButton1Click(Sender: TObject);
begin
  if SaveDialog1.Execute(Handle) then
    eFilePath.Text := SaveDialog1.Files[0];
end;

end.

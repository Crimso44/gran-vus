unit fError;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxGDIPlusClasses, ExtCtrls, StdCtrls;

type
  TfrmError = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    btnOK: TButton;
    btnDetails: TButton;
    mErrors: TMemo;
    procedure btnDetailsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ShowErr(ACaption, AText: String);

implementation

{$R *.dfm}

uses StrUtils;

procedure ShowErr(ACaption, AText: String);
begin
  with TfrmError.Create(Application) do
  try
    Label1.Caption := Trim(ACaption) + 'не выполнено!';
    mErrors.Lines.Text := Trim(AText);
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfrmError.btnDetailsClick(Sender: TObject);
begin
  if RightStr(btnDetails.Caption, 2) = '>>' then
  begin
    Constraints.MinHeight := 250;
    Constraints.MaxHeight := 0;
    Height := 250;
    btnDetails.Caption := 'Подробности <<';
  end
  else
  begin
    Constraints.MinHeight := 120;
    Constraints.MaxHeight := 120;
    Height := 120;
    btnDetails.Caption := 'Подробности >>';
  end;
end;

procedure TfrmError.FormCreate(Sender: TObject);
begin
  Constraints.MinWidth := 450;
  Constraints.MinHeight := 120;
  Constraints.MaxHeight := 120;
end;

end.

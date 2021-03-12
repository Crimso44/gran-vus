unit vur370Users;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmVur370Users = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edFam: TEdit;
    edIm: TEdit;
    edOtch: TEdit;
    edPsw: TEdit;
    Label6: TLabel;
    Button1: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVur370Users: TfrmVur370Users;

implementation

{$R *.dfm}



procedure TfrmVur370Users.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
  if Trim(edFam.Text) = '' then begin
    ShowMessage('Заполните поле "Фамилия"!');
    edFam.SetFocus; Exit;
  end;
  if Trim(edIm.Text) = '' then begin
    ShowMessage('Заполните поле "Имя"!');
    edIm.SetFocus; Exit;
  end;
  if Trim(edOtch.Text) = '' then begin
    ShowMessage('Заполните поле "Отчество"!');
    edOtch.SetFocus; Exit;
  end;
  edPsw.Text := Trim(edPsw.Text);
  if Length(edPsw.Text) < 6 then begin
    ShowMessage('Длина пароля не может быть менее 6-ти символов!');
    edPsw.SetFocus; Exit;
  end;

  if edPsw.Text<>'master' then
    ShowMessage('Вы изменили пароль, данный по умолчанию. '+
    'Запомните новый пароль или запишите его и сохраните в надёжном месте:'+
    #13#13+edPsw.Text);
  CanClose := True;
end;

end.

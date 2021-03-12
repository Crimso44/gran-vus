unit fUserCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, FrmKeep;

type
  TfmUserCard = class(TForm)
    laFam: TLabel;
    edFAM: TEdit;
    laIM: TLabel;
    edIM: TEdit;
    laOTCH: TLabel;
    edOTCH: TEdit;
    laLogin: TLabel;
    edLOGIN: TEdit;
    laPSW1: TLabel;
    edPSW1: TEdit;
    laPSW2: TLabel;
    edPSW2: TEdit;
    cbrLogin: TCheckBox;
    cbrAdmin: TCheckBox;
    cbrEdit: TCheckBox;
    cbrImport: TCheckBox;
    cbrExport: TCheckBox;
    cbrPrint: TCheckBox;
    pbOk: TBitBtn;
    pbCancel: TBitBtn;
    Bevel1: TBevel;
    laRights: TLabel;
    FrmKeep1: TFrmKeep;
    Bevel2: TBevel;
    Bevel3: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure pbOkClick(Sender: TObject);
    procedure edPSW1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmUserCard: TfmUserCard;

procedure Edit(AID: Integer);
function Add: Integer;

implementation

uses ADODB, dMain, MD5, msg;

{$R *.dfm}

type
  TMode = (mAdd, mEdit);
var
  FMode : TMode;
  FID   : Integer;
  FPWD  : Boolean;

procedure Go(AID: Integer; AMode: TMode);
begin
  FID   := AID;
  FMode := AMode;
  with TfmUserCard.Create(Application) do
  try
    ShowModal;
  finally Free;
  end;
end;

procedure Edit(AID: Integer);
begin
  Go(AID, mEdit);
end;

function Add: Integer;
begin
  Go(0, mAdd);
  Result := FID;
end;

procedure TfmUserCard.FormCreate(Sender: TObject);
const
  strMode: array[TMode] of String = (' - добавление',' - исправление');
begin
  Caption := Caption+strMode[FMode];
  if FMode=mEdit then begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;
      ParamCheck := False;
      SQL.Text := 'SELECT * FROM USERS WHERE ID='+IntToStr(FID);
      Open;
      edFAM   .Text := FieldByName('FAM'  ).AsString;
      edIM    .Text := FieldByName('IM'   ).AsString;
      edOTCH  .Text := FieldByName('OTCH' ).AsString;
      edLOGIN .Text := FieldByName('LOGIN').AsString;
      cbrAdmin  .Checked := FieldByName('rAdmin' ).AsBoolean;
      cbrImport .Checked := FieldByName('rImport').AsBoolean;
      cbrExport .Checked := FieldByName('rExport').AsBoolean;
      cbrPrint  .Checked := FieldByName('rPrint' ).AsBoolean;
      cbrEdit   .Checked := FieldByName('rEdit'  ).AsBoolean;
      cbrLogin  .Checked := FieldByName('rLogin' ).AsBoolean;
      edPSW1.Text := '******'; edPSW2.Text := '******';
    finally Free;
    end;
    if FID=1 then begin //ADMIN
      edLogin.Enabled := False;
      cbrAdmin  .Enabled := False;
      cbrImport .Enabled := False;
      cbrExport .Enabled := False;
      cbrPrint  .Enabled := False;
      cbrEdit   .Enabled := False;
      cbrLogin  .Enabled := False;
    end;
  end;
  FPWD := False;
end;

procedure TfmUserCard.pbOkClick(Sender: TObject);
//
  procedure Error(c: TWinControl; AMsg: String);
  begin c.SetFocus; ShowErr(AMsg); Abort; end;
//
  procedure CheckEmpty(ed: TEdit; AName: String);
  begin
    ed.Text := Trim(ed.Text);
    if ed.Text = '' then Error(ed, Format('Поле "%s" не должно быть пустым!', [AName]));
  end;
//
  procedure CheckUnique(ed: TEdit; AName, AField: String);
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;
      ParamCheck := False;
      SQL.Text := Format('SELECT * FROM USERS WHERE ID<>%d AND %s=%s',
                         [FID, AField, QuotedStr(ed.Text)]);
      Open;
      if not IsEmpty then Error(ed, Format(
        'Значение "%s" для поля "%s" уже используется другим пользователем!',
        [ed.Text, AName]));
    finally Free;
    end;
  end;
//
begin
  try
    CheckEmpty(edFAM  , 'Фамилия');
    CheckEmpty(edIM   , 'Имя');
    CheckEmpty(edOTCH , 'Отчество');
    CheckEmpty(edLogin, 'Системное имя');
    if edPSW1.Text<>edPSW2.Text then Error(edPSW1, 'Значения полей "Пароль" и "Подтверждение пароля" должны совпадать!');
    if Length(edPSW1.Text)<6    then Error(edPSW1, 'Длина пароля не может быть меньше 6-ти символов!');
    CheckUnique(edLogin, 'Системное имя', 'LOGIN');
  except
    ModalResult := mrNone;
    Exit;
  end;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := 'SELECT * FROM USERS';
    Open;
    if FMode = mEdit then begin
      Locate('ID', FID, []); Edit;
    end
    else
      Append;

    FieldByName('FAM')   .AsString := edFAM.Text;
    FieldByName('IM')    .AsString := edIM.Text;
    FieldByName('OTCH')  .AsString := edOTCH.Text;
    FieldByName('LOGIN') .AsString := edLOGIN.Text;
    if (FMode<>mEdit) or FPWD then
    FieldByName('HASH')  .AsString := StrMD5(edLogin.Text+edPsw1.Text);
    FieldByName('rAdmin')  .AsBoolean := cbrAdmin.Checked;
    FieldByName('rImport') .AsBoolean := cbrImport.Checked;
    FieldByName('rExport') .AsBoolean := cbrExport.Checked;
    FieldByName('rPrint')  .AsBoolean := cbrPrint.Checked;
    FieldByName('rEdit')   .AsBoolean := cbrEdit.Checked;
    FieldByName('rLogin')  .AsBoolean := cbrLogin.Checked;

    Post;
    FID := FieldbyName('ID').AsInteger;
  finally Free;
  end;
end;

procedure TfmUserCard.edPSW1Change(Sender: TObject);
begin
  FPWD := True;
end;

end.

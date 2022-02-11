unit fOrgVUZOnly;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxEdLib, dxCntner, dxEditor, StdCtrls, ExtCtrls,
  Buttons;

type
  TfmOrgVUZOnly = class(TForm)
    Label4: TLabel;
    cbHasVK: TdxPickEdit;
    Bevel1: TBevel;
    Button1: TButton;
    Label1: TLabel;
    edLicense1: TEdit;
    Label18: TLabel;
    dtLicense1: TdxDateEdit;
    Label2: TLabel;
    edLicense2: TEdit;
    Label3: TLabel;
    dtLicense2: TdxDateEdit;
    Label5: TLabel;
    edCertificate: TEdit;
    Label6: TLabel;
    dtBeginCertificate: TdxDateEdit;
    Label7: TLabel;
    dtEndCertificate: TdxDateEdit;
    Label8: TLabel;
    edWhoPuts: TEdit;
    Label9: TLabel;
    edVKChief: TEdit;
    Label10: TLabel;
    peVKChiefRange: TdxPickEdit;
    edLicense1Who: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    edLicense2Who: TEdit;
    Label13: TLabel;
    edCertificateWho: TEdit;
    procedure mmNameChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cbHasVKChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  public
    FOrgProp: TForm;
  end;

implementation

{$R *.dfm}
uses fOrgProp, dMain, ADODB;

procedure TfmOrgVUZOnly.mmNameChange(Sender: TObject);
begin
  TfmOrgProp(FOrgProp).mmName.OnChange(Self);
end;

procedure TfmOrgVUZOnly.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_F1) and (Shift=[]) then Application.HelpContext(HelpContext);
end;

procedure TfmOrgVUZOnly.Button1Click(Sender: TObject);
begin
  if (cbHasVK.ItemIndex = 1) and (Trim(edVKChief.Text) = '') then begin
    ShowMessage('Вы не указали начальника военной кафедры!');
    if edVKChief.CanFocus then edVKChief.SetFocus;
    ModalResult := mrNone;
  end;
end;

procedure TfmOrgVUZOnly.cbHasVKChange(Sender: TObject);
begin
  edVKChief.Enabled := cbHasVK.ItemIndex = 1;
  peVKChiefRange.Enabled := cbHasVK.ItemIndex = 1;
  Application.ProcessMessages;
  mmNameChange(nil);
end;

procedure TfmOrgVUZOnly.FormCreate(Sender: TObject);
begin
  edLicense1.Enabled         := dmMain.rEdit;
  dtLicense1.Enabled         := dmMain.rEdit;
  edLicense1Who.Enabled      := dmMain.rEdit;
  edLicense2.Enabled         := dmMain.rEdit;
  dtLicense2.Enabled         := dmMain.rEdit;
  edLicense2Who.Enabled      := dmMain.rEdit;
  edCertificate.Enabled      := dmMain.rEdit;
  dtBeginCertificate.Enabled := dmMain.rEdit;
  dtEndCertificate.Enabled   := dmMain.rEdit;
  edCertificateWho.Enabled   := dmMain.rEdit;
  edWhoPuts.Enabled          := dmMain.rEdit;
  cbHasVK.Enabled            := dmMain.rEdit;
  edVKChief.Enabled          := dmMain.rEdit;
  peVKChiefRange.Enabled     := dmMain.rEdit;

  peVKChiefRange.Clear;
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select WRNG_ID, WRNG_NAME from KWRANGE where STATE > 0';
    Open;
    peVKChiefRange.Items.AddObject('<Не указано>', TObject(0));
    while not EOF do
    begin
      peVKChiefRange.Items.AddObject(FieldByName('WRNG_NAME').AsString,
                                     TObject(FieldByName('WRNG_ID').AsInteger));
      Next;
    end;
  finally
    Free;
  end;
end;

end.

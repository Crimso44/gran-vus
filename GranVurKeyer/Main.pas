unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, fRegister, Vcl.ComCtrls, MMSystem,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TForm1 = class(TForm)
    Button1: TButton;
    eProductCode: TEdit;
    Label1: TLabel;
    eLicenceNumber: TEdit;
    Label2: TLabel;
    eLicenseCount: TEdit;
    Label3: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label4: TLabel;
    eHardwareCode: TEdit;
    Label5: TLabel;
    Button2: TButton;
    eKey: TEdit;
    bSaveFile: TButton;
    Panel1: TPanel;
    bPlay: TBitBtn;
    bPause: TBitBtn;
    pInfo: TPanel;
    lInfo: TLabel;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure bSaveFileClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure bPauseClick(Sender: TObject);
    procedure bPlayClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    CertificateStr, ValidateStr: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  song: Pointer;

implementation

{$R *.dfm}

uses StrUtils, uCrypt, utils_misc;

procedure TForm1.Button1Click(Sender: TObject);
begin
  IsDemoVersion(true);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  CertificateBits: TBits;
  Certificate: TCertificate;
  ValidateCalc: Array[0..50] of char;
begin
  CertificateBits := TBits.Create;
  Certificate.ProductCode := StrToInt('$' + StringReplace(CodeTableConvert(eProductCode.Text, 1),'-',EmptyStr,[rfReplaceAll]));
  Certificate.LicenceNumber := StrToInt(eLicenceNumber.Text);
  Certificate.LicenceCount := StrToInt(eLicenseCount.Text);
  Certificate.ValidityDate := DateTimePicker1.Date;
  Certificate.HardwareKey := Cardinal(StrToInt('$'+LeftStr(StringReplace(CodeTableConvert(eHardwareCode.Text, 1),'-','',[rfReplaceAll]),8)));;
  Certificate.ControlKey := Cardinal(StrToInt('$'+RightStr(StringReplace(CodeTableConvert(eHardwareCode.Text, 1),'-','',[rfReplaceAll]),8)));

  CertificateToBits(Certificate, CertificateBits);
  MixBits(CertificateBits,Certificate.HardwareKey,false);
  CertificateStr := '123456789012345678901234567890'; // space(25)
  UniqueString(CertificateStr);
  EncodeBits(CertificateBits, PChar(CertificateStr));
  CalcValidateKey(CertificateBits,ValidateCalc);
  ValidateStr := string(ValidateCalc);

  eKey.Text := CodeTableConvert(
    Copy(CertificateStr, 1, 5) + '-' + Copy(CertificateStr, 6, 5) + '-' +
    Copy(CertificateStr, 11, 5) + '-' + Copy(CertificateStr, 16, 5) + '-' +
    Copy(CertificateStr, 21, 5) + '-' + ValidateStr, 2);

  bSaveFile.Enabled := true;
end;

procedure TForm1.FormActivate(Sender: TObject);
var
  i: Integer;
  resName: String;
begin
  i := 1 + Random(7);
  resName := 'SONG'+IntToStr(i);
  PlaySound(PWideChar(resName), hInstance, SND_RESOURCE or SND_ASYNC);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  lInfo.Left := lInfo.Left - 1;
  if lInfo.Left < -lInfo.Width then
    lInfo.Left := pInfo.Width;
end;

procedure TForm1.bPauseClick(Sender: TObject);
begin
  PlaySound(nil, hInstance, 0);
  bPlay.Show;
  bPause.Hide;
end;

procedure TForm1.bPlayClick(Sender: TObject);
var
  i: Integer;
  resName: String;
begin
  i := 1 + Random(7);
  resName := 'SONG'+IntToStr(i);
  PlaySound(PWideChar(resName), hInstance, SND_RESOURCE or SND_ASYNC);
  bPlay.Hide;
  bPause.Show;
end;

procedure TForm1.bSaveFileClick(Sender: TObject);
var
  FK: TextFile;
  fileName: string;
begin
  fileName := ExtractFilePath(Application.ExeName)+'\'+Copy(CertificateStr, 1, 25)+'.key';
  AssignFile(FK, fileName);
  Rewrite(FK);
  WriteLn(FK, ValidateStr);
  CloseFile(FK);
  ShowMessage('װאיכ סמחהאם: ' + fileName);
end;

end.

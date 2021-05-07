unit fRegister;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DB, dxmdaset, dxExEdtr, dxDBTLCl, dxGrClms, dxDBCtrl,
  dxDBGrid, dxTL, dxCntner, Buttons;

type
  TfmRegister = class(TForm)
    Label1: TLabel;
    lbProductCode: TLabel;
    lbProductName: TLabel;
    lbProductVersion: TLabel;
    lbDemoVersion: TLabel;
    Label2: TLabel;
    lbCompanyName: TLabel;
    lbCompanyAddress: TLabel;
    lbCompanyPhone: TLabel;
    lbCompanyUrl: TLabel;
    lbCompanyMail: TLabel;
    Bevel1: TBevel;
    btnLicenceDel: TButton;
    Label3: TLabel;
    memKeys: TdxMemData;
    memKeyslicence_number: TIntegerField;
    memKeyslicence_count: TIntegerField;
    memKeysvalidity_date: TDateTimeField;
    memKeyscertificate_key: TStringField;
    dxDBGrid1: TdxDBGrid;
    dsKeys: TDataSource;
    dxDBGrid1RecId: TdxDBGridColumn;
    dxDBGrid1licence_number: TdxDBGridMaskColumn;
    dxDBGrid1licence_count: TdxDBGridMaskColumn;
    dxDBGrid1validity_date: TdxDBGridDateColumn;
    dxDBGrid1certificate_key: TdxDBGridMaskColumn;
    Label4: TLabel;
    Bevel2: TBevel;
    Label5: TLabel;
    edRequestCode: TEdit;
    Label6: TLabel;
    edKey1: TEdit;
    edKey2: TEdit;
    edKey3: TEdit;
    edKey4: TEdit;
    edKey5: TEdit;
    edKey6: TEdit;
    Shape1: TShape;
    sbPasteKey: TSpeedButton;
    btnLicenceAdd: TButton;
    Bevel3: TBevel;
    btnRunInDemo: TButton;
    btnClose: TButton;
    procedure lbCompanyUrlMouseEnter(Sender: TObject);
    procedure lbCompanyUrlMouseLeave(Sender: TObject);
    procedure lbCompanyUrlClick(Sender: TObject);
    procedure lbCompanyMailClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure memKeysAfterPost(DataSet: TDataSet);
    procedure edKey1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRunInDemoClick(Sender: TObject);
    procedure btnLicenceAddClick(Sender: TObject);
    procedure btnLicenceDelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memKeyscertificate_keyGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    { Private declarations }
    procedure FLoadKeys;
  public
    { Public declarations }
  end;


  function IsDemoVersion(FShowCard: boolean = false; FForceShowCard: boolean = false): boolean;

implementation

uses msg, ShellAPI, IniFiles, StrUtils, uCrypt, utils_misc;

{$R *.DFM}

function IsDemoVersion(FShowCard: boolean = false; FForceShowCard: boolean = false): boolean;
begin
  Result := False;
  //!!! для отключения проверки лицензий комментить тут
  (*with TfmRegister.Create(nil) do
  try
    if (lbDemoVersion.Visible and FShowCard) or (FForceShowCard) then ShowModal;
    Result := lbDemoVersion.Visible;
  finally
    Free;
  end;*)
end;

procedure TfmRegister.lbCompanyUrlMouseEnter(Sender: TObject);
begin
  (Sender as TLabel).Font.Style := [fsUnderLine];
end;

procedure TfmRegister.lbCompanyUrlMouseLeave(Sender: TObject);
begin
  (Sender as TLabel).Font.Style := [];
end;

procedure TfmRegister.lbCompanyUrlClick(Sender: TObject);
begin
  ShellExecute(0,nil,PChar('http://'+lbCompanyUrl.Caption),nil,nil,SW_SHOWDEFAULT);
end;

procedure TfmRegister.lbCompanyMailClick(Sender: TObject);
begin
  ShellExecute(0,nil,PChar('mailto://'+lbCompanyUrl.Caption),nil,nil,SW_SHOWDEFAULT);
end;

procedure TfmRegister.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmRegister.memKeysAfterPost(DataSet: TDataSet);
var
  fDemo: boolean;
  k: Integer;
begin
  btnLicenceDel.Enabled := not memKeys.IsEmpty;
  fDemo := true;
  if not memKeys.IsEmpty then begin
//check demo version
    k := memKeys.RecNo;
    memKeys.DisableControls;
    try
      memKeys.First;
      while not memKeys.EOF do begin
        if (memKeys.FieldByName('validity_date').AsDateTime>Now) and
           (memKeys.FieldByName('licence_count').AsInteger>0) then
        begin
          fDemo := false;
          break;
        end;
        memKeys.Next;
      end;
    finally
      memKeys.RecNo := k;
      memKeys.EnableControls;
    end;
  end;
  lbDemoVersion.Visible := fDemo;
  btnRunInDemo.Visible := fDemo;
end;

procedure TfmRegister.memKeyscertificate_keyGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := CodeTableConvert(Sender.AsString, 2);
end;

procedure TfmRegister.edKey1Change(Sender: TObject);
begin
  btnLicenceAdd.Enabled :=
    (Length(edKey1.Text)=5) and
    (Length(edKey2.Text)=5) and
    (Length(edKey3.Text)=5) and
    (Length(edKey4.Text)=5) and
    (Length(edKey5.Text)=5) and
    (Length(edKey6.Text)=4);
  with (Sender as TEdit) do
    if Length(Text)=Tag then Self.SelectNext(Sender as TEdit,true,true);
end;

procedure TfmRegister.FLoadKeys;
var F: TSearchRec;
    FK: TextFile;
    CertificateStr,
    ValidateStr: string;
    CertificateBits: TBits;
    ValidateCalc: Array[0..50] of char;
    Certificate: TCertificate;
    dt: TDateTime;
begin
  dt := MinDateTime;
  memKeys.Active := true;
  while not memKeys.EOF do memKeys.Delete;
  if FindFirst(ExtractFilePath(Application.ExeName)+'\RegInfo\*.key',faAnyFile,F)=0 then begin
    repeat
      if F.Attr and faDirectory=0 then begin
        AssignFile(FK,ExtractFilePath(Application.ExeName)+'\RegInfo\'+F.Name);
        Reset(FK);
        ReadLn(FK,ValidateStr);
        CertificateStr := LeftStr(F.Name,25);
        CertificateBits := TBits.Create;
        DecodeBits(CertificateBits,PChar(CertificateStr));
        CalcValidateKey(CertificateBits,ValidateCalc);
        if ValidateStr=string(ValidateCalc) then begin
          MixBits(CertificateBits,GetHardwareKey,true);
          BitsToCertificate(CertificateBits,Certificate);
          if Certificate.ValidityDate > dt then
            LicenseKey := Copy(CertificateStr,1,5)+'-'+
              Copy(CertificateStr,6,5)+'-'+
              Copy(CertificateStr,11,5)+'-'+
              Copy(CertificateStr,16,5)+'-'+
              Copy(CertificateStr,21,5);
          if (Certificate.HardwareKey=GetHardwareKey) and
             (Certificate.ProductCode=StrToInt('$'+StringReplace(lbProductCode.Caption,'-',EmptyStr,[rfReplaceAll]))) and
             (Certificate.ProductCode>0) 
          then begin
            memKeys.Append;
            memKeys.FieldByName('licence_number').Value := Certificate.LicenceNumber;
            memKeys.FieldByName('licence_count').Value := Certificate.LicenceCount;
            memKeys.FieldByName('validity_date').Value := Certificate.ValidityDate;
            memKeys.FieldByName('certificate_key').Value :=
              Copy(CertificateStr,1,5)+'-'+
              Copy(CertificateStr,6,5)+'-'+
              Copy(CertificateStr,11,5)+'-'+
              Copy(CertificateStr,16,5)+'-'+
              Copy(CertificateStr,21,5);
            memKeys.Post;
          end;
        end;
        CertificateBits.Free;
        CloseFile(FK);
      end;
    until FindNext(F)<>0;
    FindClose(F);
  end;

end;

procedure TfmRegister.FormCreate(Sender: TObject);
const section: string = 'REGISTER';
var k: Integer;
    n: dword;
    s: string;
begin
//load info
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'\RegInfo\reg_info.ini') do
  try
    ProductCode := ReadString(section,'ProductCode','');
    lbProductCode.Caption := IntToHex(ReadInteger(section,'ProductCode',StrToInt('$'+StringReplace(lbProductCode.Caption,'-',EmptyStr,[rfReplaceAll]))),8);
    lbProductCode.Caption := LeftStr(lbProductCode.Caption,4)+'-'+RightStr(lbProductCode.Caption,4);
    if lbProductCode.Caption='0000-0000' then lbProductCode.Font.Color := clRed;
    lbProductName.Caption := ReadString(section,'ProductName',lbProductName.Caption);
    lbProductVersion.Caption := ReadString(section,'ProductVersion',lbProductVersion.Caption);
    lbCompanyName.Caption := ReadString(section,'CompanyName',lbCompanyName.Caption);
    lbCompanyAddress.Caption := ReadString(section,'CompanyAddress',lbCompanyAddress.Caption);
    lbCompanyPhone.Caption := ReadString(section,'CompanyPhone',lbCompanyPhone.Caption);
    lbCompanyUrl.Caption := ReadString(section,'CompanyUrl',lbCompanyUrl.Caption);
    lbCompanyMail.Caption := ReadString(section,'CompanyMail',lbCompanyMail.Caption);
  finally
    Free;
  end;
  s := IntToHex(GetHardwareKey,8);
  n := StrToInt('$' + Copy(s, 0, 4)) xor StrToInt('$' + ReverseString(Copy(s, 4, 4)));
  Randomize;
  k := Random(65535);

//  edRequestCode.Text := Copy(s,1,4)+'-'+Copy(s,5,4)+'-'+Copy(s,9,4)+'-'+Copy(s,13,4);
  edRequestCode.Text := CodeTableConvert(Copy(s, 1, 4) + '-' + Copy(s, 5, 4) + '-' + IntToHex(n, 4) + '-' +
    IntToHex(k, 4), 2);
//load keys
  FLoadKeys;
end;

procedure TfmRegister.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if lbDemoVersion.Visible then
    if ModalResult<>mrOk then ExitProcess(0);
end;

procedure TfmRegister.btnRunInDemoClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfmRegister.btnLicenceAddClick(Sender: TObject);
var
  CertificateStr,
  ValidateStr: string;
  ValidateCalc: Array[0..50] of char;
  CertificateBits: TBits;
  Certificate: TCertificate;
  F: TextFile;
begin
  CertificateStr := CodeTableConvert(edKey1.Text+edKey2.Text+edKey3.Text+edKey4.Text+edKey5.Text, 1);
  ValidateStr := CodeTableConvert(edKey6.Text, 1);
  CertificateBits := TBits.Create;
  try
    DecodeBits(CertificateBits,PChar(CertificateStr));
    CalcValidateKey(CertificateBits,ValidateCalc);
    if ValidateStr<>string(ValidateCalc) then
      ShowErr('Введенный ключ неверен!'#13'Не пройдена проверка на целостность...')
    else begin
      MixBits(CertificateBits,GetHardwareKey,true);
      BitsToCertificate(CertificateBits,Certificate);
      if Certificate.HardwareKey<>GetHardwareKey then
        ShowErr('Введенный ключ неверен!'#13'Не пройдена проверка на аппаратную привязку...')
      else begin
        if Certificate.ControlKey<>Cardinal(StrToInt('$'+StringReplace(RightStr(CodeTableConvert(edRequestCode.Text, 1),9),'-','',[rfReplaceAll]))) then
          ShowErr('Введенный ключ неверен!'#13'Не пройдена проверка на контрольную привязку...')
        else begin
          if Certificate.ProductCode<>StrToInt('$'+StringReplace(lbProductCode.Caption,'-',EmptyStr,[rfReplaceAll])) then
            ShowErr('Введенный ключ неверен!'#13'Данный ключ не предназначен для этого продукта...')
          else begin
            AssignFile(F,ExtractFilePath(Application.ExeName)+'\RegInfo\'+CertificateStr+'.key');
            ReWrite(F);
            Write(F,ValidateStr);
            CloseFile(F);
            memKeys.Append;
            memKeys.FieldByName('licence_number').Value := Certificate.LicenceNumber;
            memKeys.FieldByName('licence_count').Value := Certificate.LicenceCount;
            memKeys.FieldByName('validity_date').Value := Certificate.ValidityDate;
            memKeys.FieldByName('certificate_key').Value :=
              Copy(CertificateStr,1,5)+'-'+
              Copy(CertificateStr,6,5)+'-'+
              Copy(CertificateStr,11,5)+'-'+
              Copy(CertificateStr,16,5)+'-'+
              Copy(CertificateStr,21,5);
            memKeys.Post;
          end;
        end;
      end;
    end;
  finally
    CertificateBits.Free;
  end;
end;

procedure TfmRegister.btnLicenceDelClick(Sender: TObject);
begin
  if Confirm('Удалить выбранный ключ активации?') then
    if DeleteFile(
      ExtractFilePath(Application.ExeName)+'\RegInfo\'+
      StringReplace(memKeysCertificate_Key.AsString,'-','',[rfReplaceAll])+'.key')
    then memKeys.Delete
    else ShowErr('Ошибка при удалении ключа!')
end;

procedure TfmRegister.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then
    Application.HelpContext(HelpContext);
end;

end.

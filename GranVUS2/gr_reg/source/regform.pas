unit regform;

interface

uses
  Windows, dxExEdtr, DB, ADODB, StdCtrls, dxDBTLCl, dxGrClms, dxTL, forms,
  dxDBCtrl, dxDBGrid, Controls, dxCntner, Buttons, ExtCtrls, Classes, graphics;

type
  TfmReg = class(TForm)
    Label1: TLabel;
    lbCode: TLabel;
    lbAddr: TLabel;
    lbPhone: TLabel;
    lbUrl: TLabel;
    Bevel1: TBevel;
    MainConn: TADOConnection;
    lbProduct: TLabel;
    lbDemo: TLabel;
    Label3: TLabel;
    lbCompany: TLabel;
    lbMail: TLabel;
    spList: TADOQuery;
    spListLicenseNumber: TIntegerField;
    spListLicenceCount: TIntegerField;
    spListValidityDate: TDateTimeField;
    spListCertificateKey: TStringField;
    dxDBGrid1: TdxDBGrid;
    Label2: TLabel;
    dsList: TDataSource;
    dxDBGrid1LicenseNumber: TdxDBGridMaskColumn;
    dxDBGrid1LicenseCount: TdxDBGridMaskColumn;
    dxDBGrid1ValidityDate: TdxDBGridDateColumn;
    dxDBGrid1CertificateKey: TdxDBGridMaskColumn;
    Button1: TButton;
    Label4: TLabel;
    Bevel2: TBevel;
    Label5: TLabel;
    spPrep: TADOQuery;
    spPrepHardwareKey: TIntegerField;
    spPrepControlKey: TIntegerField;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Edit6: TEdit;
    Button2: TButton;
    spAdd: TADOQuery;
    Button3: TButton;
    Button4: TButton;
    spRem: TADOQuery;
    lbControl: TEdit;
    BtnPaste: TSpeedButton;
    Button5: TButton;
    Bevel3: TBevel;
    spListProductCode: TIntegerField;
    dxDBGrid1ProductCode: TdxDBGridMaskColumn;
    procedure FormCreate(Sender: TObject);
    procedure lbUrlMouseLeave(Sender: TObject);
    procedure lbUrlMouseEnter(Sender: TObject);
    procedure lbUrlClick(Sender: TObject);
    procedure spListBeforeOpen(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure spListAfterScroll(DataSet: TDataSet);
    procedure Button4Click(Sender: TObject);
    procedure spListAfterOpen(DataSet: TDataSet);
    procedure BtnPasteClick(Sender: TObject);
    procedure spListProductCodeGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dxDBGrid1CustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure spListCertificateKeyGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
  private
    Sect, Ini: string;
    prCode: integer;
    KeyCtrl: integer;
    procedure RefreshList;
    procedure GetCtrlKod;
    procedure LoadSetting(IniFile, IniSect: string);
  end;

  function ShowRegisterDialogADO(ParentWindow: HWND; ConnObject: _Connection; IniFile: PChar; IniSection: PChar): integer; stdcall;
  function ShowRegisterDialogODBC(ParentWindow: HWND; Server: PChar; Database: PChar; User: PChar; Pass: PChar; UseNt: integer; IniFile: PChar; IniSection: PChar): integer; stdcall;

implementation

{$R *.dfm}

uses
  ShellApi, inifiles, clipbrd, adoutils, aemmsg, adoconst, sysutils, variants,
  utils_misc, dialogs;

{.DEFINE USELOG}

{$IFDEF USELOG}
procedure SaveLog(Msg: string);
var
  f: string;
begin
   with TStringList.Create do
   try
     f := ExtractFilePath(ParamStr(0))+'\gr_reg.log';
     if FileExists(f) then LoadFromFile(f);
     Add(Msg);
     SaveToFile(f);
   finally
     Free;
   end;
end;
{$ENDIF}

function ShowRegisterDialogODBC;
begin
{$IFDEF USELOG} SaveLog('Enter ShowRegisterODBC function'); {$ENDIF}
   with TADOConnection.Create(nil) do
   try
{$IFDEF USELOG} SaveLog('try to build connection string'); {$ENDIF}
     ConnectionString := BuildConnStr(Server, Database, User, Pass, UseNT = 1);
{$IFDEF USELOG} SaveLog('connection string complete: '+ConnectionString); {$ENDIF}
     LoginPrompt := false;
     try
{$IFDEF USELOG} SaveLog('try to open database'); {$ENDIF}
       Open;
{$IFDEF USELOG} SaveLog('database opened'); {$ENDIF}
     except
       on E: Exception do begin

{$IFDEF USELOG} SaveLog('error connect to database: '+E.Message); {$ENDIF}
         Result := -1;
         MsgError('Ошибка подключения к базе данных: '+E.Message);
       end;
     end;
     Result := ShowRegisterDialogADO(ParentWindow, ConnectionObject, IniFile, IniSection);
   finally
     Free;
   end;
end;

function ShowRegisterDialogADO;
var
  c: _connection;
  h: HWND;
begin
//   Result := -1;
{$IFDEF USELOG} SaveLog('Enter ShowRegisterDialogADO function'); {$ENDIF}
   h := Application.Handle;
   Application.Handle := ParentWindow;
{$IFDEF USELOG} SaveLog('try to create form'); {$ENDIF}
   with TfmReg.Create(Application) do
   try
{$IFDEF USELOG} SaveLog('form created'); {$ENDIF}
      c := MainConn.ConnectionObject;
      try
{$IFDEF USELOG} SaveLog('setting connection'); {$ENDIF}
        MainConn.ConnectionObject := ConnObject;
{$IFDEF USELOG} SaveLog('reading INI'); {$ENDIF}
        LoadSetting(IniFile, IniSection);
{$IFDEF USELOG} SaveLog('Show form'); {$ENDIF}
        if ShowModal = mrIgnore then
           Result := 2
        else
           Result := 1;
      finally
        MainConn.ConnectionObject := c;
      end;
   finally
      Free;
      Application.Handle := h;
   end;
end;

procedure TfmReg.FormCreate(Sender: TObject);
begin
   MainConn.ConnectionString := EmptyStr;
   Sect := EmptyStr;
   Ini := EmptyStr;
   prCode := 0;
   KeyCtrl := 0;
{   lbCode.Caption := IntToHex(ProductCode, 4);
   if IsDemo then Label3.Caption := '- Демонстрационная версия -' else Label3.Caption := EmptyStr;}
end;

procedure TfmReg.lbUrlMouseLeave(Sender: TObject);
begin
   TLabel(Sender).Font.Color := clHighlight;
   TLabel(Sender).Font.Style := [];
end;

procedure TfmReg.lbUrlMouseEnter(Sender: TObject);
begin
   TLabel(Sender).Font.Color := clHotlight;
   TLabel(Sender).Font.Style := [fsUnderline];
end;

procedure TfmReg.lbUrlClick(Sender: TObject);
begin
   if TLabel(Sender).Tag = 0 then
      ShellExecute(0, 'OPEN', PChar(TLabel(Sender).Caption), nil, nil, SW_SHOW)
   else
      ShellExecute(0, 'OPEN', PChar('mailto:'+TLabel(Sender).Caption), nil, nil, SW_SHOW);
end;

function IntToCode(val: integer): string;
begin
   Result := IntToHex(Val, 8);
   insert('-', Result, 5);
end;

procedure TfmReg.LoadSetting(IniFile, IniSect: string);
begin
   Sect := IniSect;
   Ini := IniFile;
   with TiniFile.Create(IniFIle) do
   try
{$IFDEF USELOG} SaveLog('Reading INI params'); {$ENDIF}
      prCode := ReadInteger(IniSect, 'ProductCode', 0);
      lbCode.Caption := '0x'+IntToHex(prCode, 4);
      lbProduct.Caption := ReadString(IniSect, 'ProductName', EmptyStr)+#13#10+ReadString(IniSect, 'ProductVersion', EmptyStr);
//      lbVersion.Caption := ReadString(IniSect, 'ProductVersion', EmptyStr);
      lbCompany.Caption := ReadString(IniSect, 'CompanyName', lbCompany.Caption);
      lbAddr.Caption := ReadString(IniSect, 'CompanyAddress', lbAddr.Caption);
      lbPhone.Caption := ReadString(IniSect, 'CompanyPhone', lbPhone.Caption);
      lbUrl.Caption := ReadString(IniSect, 'CompanyUrl', lbUrl.Caption);
      lbMail.Caption := ReadString(IniSect, 'CompanyMail', lbMail.Caption);
      KeyCtrl := ReadInteger(IniSect, 'ControlKey', 0);
      if KeyCtrl > 0 then
        lbControl.Text := CodeTableConvert(IntToCode(ReadInteger(IniSect, 'HardwareKey', 0))+'-'+IntToCode(KeyCtrl), 2)
      else
        lbControl.Text := EmptyStr;
{$IFDEF USELOG} SaveLog('try to open list'); {$ENDIF}
      RefreshList;
      try
        GetCtrlKod;
      except
        on E: Exception do
          MsgWarning('Ошибка при получении кода запроса:'+#13#10+E.Message);
      end;
   finally
     Free;
   end;
{$IFDEF USELOG} SaveLog('All settings loaded'); {$ENDIF}
end;

procedure TfmReg.spListBeforeOpen(DataSet: TDataSet);
begin
   spList.Parameters.ParamByName('code').Value := prCode;
end;

procedure TfmReg.spListCertificateKeyGetText(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  Text := CodeTableConvert(Sender.AsString, 2);
end;

procedure TfmReg.Button1Click(Sender: TObject);
begin
  GetCtrlKod;
end;

procedure TfmReg.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then SelectNext(TWinControl(Sender), true, true);
end;

procedure TfmReg.Edit1Change(Sender: TObject);
begin
   Button2.Enabled := (Length(Edit1.Text) = 5) and (Length(Edit2.Text) = 5) and (Length(Edit3.Text) = 5) and (Length(Edit4.Text) = 5) and (Length(Edit5.Text) = 5) and (Length(Edit6.Text) = 4);
   with Sender as TEdit do
     if (Length(Text) = MaxLength) then Self.SelectNext(Sender as TEdit, true, true);
end;

procedure TfmReg.Button2Click(Sender: TObject);
begin
   if KeyCtrl = 0 then raise Exception.Create('Отсутствует код запроса');
   spAdd.Parameters.ParamByName('control').Value := KeyCtrl;
   spAdd.Parameters.ParamByName('cert').Value :=
     CodeTableConvert(Edit1.Text+'-'+Edit2.Text+'-'+Edit3.Text+'-'+Edit4.Text+'-'+Edit5.Text, 1);
   spAdd.Parameters.ParamByName('val').Value := CodeTableConvert(Edit6.Text, 1);
   spAdd.ExecSQL;
   RefreshList;
end;

procedure TfmReg.Button3Click(Sender: TObject);
begin
   Close;
end;

procedure TfmReg.spListAfterScroll(DataSet: TDataSet);
begin
   Button4.Enabled := spListCertificateKey.Value <> '';
end;

procedure TfmReg.Button4Click(Sender: TObject);
begin
   if not MsgConfirm('Удалить выбранный ключ активации?') then exit;
   spRem.Parameters.ParamByName('cert').Value := spListCertificateKey.Value;
   spRem.ExecSQL;
   RefreshList;
end;

procedure TfmReg.spListAfterOpen(DataSet: TDataSet);
var
  cnt: integer;
begin
    cnt := 0;
    spList.DisableControls;
    spList.AfterScroll := nil;
    try
        spList.First;
        while not spList.Eof do begin
           if (spListProductCode.Value = prCode) and (spListValidityDate.Value >= Date) then
              cnt := cnt + spListLicenceCount.Value;
           spList.Next;
        end;
        spList.First;
        if cnt = 0 then lbDemo.Caption := '- Демонстрационная версия -' else lbDemo.Caption := EmptyStr;
        Button5.Visible := cnt = 0;
    finally
        spList.EnableControls;
        spList.AfterScroll := spListAfterScroll;
        spListAfterScroll(spList);
    end;
end;

procedure TfmReg.BtnPasteClick(Sender: TObject);
var
  s: string;
begin
   if not Clipboard.HasFormat(cf_text) then exit; 
   s := Clipboard.AsText;
   s := StringReplace(s, '-', EmptyStr, [rfReplaceAll]);
   if Length(s) > 0 then Edit1.Text := copy(s, 1, 5);
   if Length(s) > 5 then Edit2.Text := copy(s, 6, 5);
   if Length(s) > 10 then Edit3.Text := copy(s, 11, 5);
   if Length(s) > 15 then Edit4.Text := copy(s, 16, 5);
   if Length(s) > 20 then Edit5.Text := copy(s, 21, 5);
   if Length(s) > 25 then Edit6.Text := copy(s, 26, 4);
end;

procedure TfmReg.GetCtrlKod;
begin
{$IFDEF USELOG} SaveLog('load control key'); {$ENDIF}
   spPrep.Open;
   try
     KeyCtrl := spPrepControlKey.Value;
{     if (Ini <> EmptyStr) and (Sect <> EmptyStr) then
     with TIniFile.Create(ini) do
     try
        WriteInteger(Sect, 'ControlKey', KeyCtrl);
        WriteInteger(Sect, 'HardwareKey', spPrepHardwareKey.Value);
     finally
        Free;
     end;}
     lbControl.Text := CodeTableConvert(IntToCode(spPrepHardwareKey.Value)+'-'+IntToCode(KeyCtrl), 2);
   finally
     spPrep.Close;
   end;
end;

procedure TfmReg.spListProductCodeGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
   if Sender.IsNull then exit;
   Text := '0x'+IntToHex(Sender.AsInteger, 4);
end;

procedure TfmReg.dxDBGrid1CustomDrawCell(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
  ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
  var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
  var ADone: Boolean);
begin
   if (ANode.Values[dxDBGrid1ProductCode.Index] <> prCode) or VarIsNull(ANode.Values[dxDBGrid1ValidityDate.Index]) or (ANode.Values[dxDBGrid1ValidityDate.Index] < Date) then begin
      if ASelected then AFont.Color := clAqua else AFont.Color := clRed;
   end;
end;

procedure TfmReg.RefreshList;
begin
  spList.DisableControls;
  try
    if spList.Active then spList.Close;
    try
      spList.Open;
    except
      on E: Exception do begin
           if pos(SNoResultSet, E.Message) > 0 then
             exit;
//         if (E is EDatabaseError) and (E.Message = Format('%s: %s', [spList.Name, SNoResultSet])) then exit;
         MsgWarning('Ошибка при получении списка лицензий:'+#13#10+E.Message);
      end;
    end;
  finally
    spList.EnableControls;
  end;
end;

end.

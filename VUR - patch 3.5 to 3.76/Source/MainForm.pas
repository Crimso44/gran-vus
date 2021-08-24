unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, DB, ADODB, AppEvnts,
  ActnList, XPMan, ComObj, ShlObj, ActiveX;
const
  WM_MY_CHKINFO = WM_USER + 100;
  WM_MY_START = WM_USER + 101;

type
  _OSVERSIONINFOEX = record
    dwOSVersionInfoSize : DWORD;
    dwMajorVersion      : DWORD;
    dwMinorVersion      : DWORD;
    dwBuildNumber       : DWORD;
    dwPlatformId        : DWORD;
    szCSDVersion        : array[0..127] of AnsiChar;
    wServicePackMajor   : WORD;
    wServicePackMinor   : WORD;
    wSuiteMask          : WORD;
    wProductType        : BYTE;
    wReserved           : BYTE;
  end;
  TOSVERSIONINFOEX = _OSVERSIONINFOEX;

  TfmMain = class(TForm)
    PC: TPageControl;
    tshCommon: TTabSheet;
    tshInfo: TTabSheet;
    tshProcess: TTabSheet;
    btnPrev: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    edPath: TEdit;
    sbPath: TSpeedButton;
    Label3: TLabel;
    lbExeVer: TLabel;
    Label4: TLabel;
    lbExeVerPatch: TLabel;
    Label5: TLabel;
    lbExeVerState: TLabel;
    Bevel2: TBevel;
    Image2: TImage;
    pnlLogo: TPanel;
    Image1: TImage;
    Label7: TLabel;
    pbMain: TProgressBar;
    lbProcState: TLabel;
    ApplicationEvents1: TApplicationEvents;
    Label9: TLabel;
    ActionList1: TActionList;
    actDummy: TAction;
    actShiftDummy: TAction;
    btnInfo: TButton;
    XPManifest1: TXPManifest;
    dbConn: TADOConnection;
    procedure FormActivate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sbPathClick(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure tshCommonShow(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure actDummyExecute(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
  private
    nExe: Integer;
    procedure FChkInfo(var msg: TMessage); message WM_MY_CHKINFO;
    procedure FStart(var msg: TMessage); message WM_MY_START;
    procedure FProcessBin;
    procedure FSetLinks;
    procedure ChkDateFormat;
    function IsVista: Boolean;
//    function WinHlp32Installed: Boolean;
    procedure AllowProgrammaticMacros;
    procedure CheckVirtualStore;
  public
    FExeVer: Integer;
    fInProcess,fBreak: boolean;
  end;

  function GetVersionExA(var lpVersionInformation: TOSVersionInfoEX): BOOL; stdcall;
    external kernel32;

var
  fmMain: TfmMain;
  sV0, sVs: String;
  windows7: Boolean;

implementation

uses msg, FileCtrl, registry, inifiles, Rdialogs, ShellAPI, vur36, vur361,
  vur362, vur365, vur370, StrUtils, vur371, vur372, vur373, vur374, vur375,
  vur376, vur377, vur378, vur379, vur380, vur381, vur384, vur385, vur386, vur387,
  vur388, vur389, vur390, vur391, vur392, vur393;

{$R *.dfm}

type
  TAppPatch=record
    VerValue: Integer;
    fn_GetInfo: function: string;
    fn_GetStepCount: function: Integer;
    fn_ProcessPatch: procedure;
  end;
var
  AAppPatch: Array[0..25] of TAppPatch = (
    (VerValue: 360;
     fn_GetInfo: Patch36_GetInfo;
     fn_GetStepCount: Patch36_GetStepCount;
     fn_ProcessPatch: Patch36_Process),
    (VerValue: 361;
     fn_GetInfo: Patch361_GetInfo;
     fn_GetStepCount: Patch361_GetStepCount;
     fn_ProcessPatch: Patch361_Process),
    (VerValue: 362;
     fn_GetInfo: Patch362_GetInfo;
     fn_GetStepCount: Patch362_GetStepCount;
     fn_ProcessPatch: Patch362_Process),
    (VerValue: 365;
     fn_GetInfo: Patch365_GetInfo;
     fn_GetStepCount: Patch365_GetStepCount;
     fn_ProcessPatch: Patch365_Process),
    (VerValue: 370;
     fn_GetInfo: Patch370_GetInfo;
     fn_GetStepCount: Patch370_GetStepCount;
     fn_ProcessPatch: Patch370_Process),
    (VerValue: 371;
     fn_GetInfo: Patch371_GetInfo;
     fn_GetStepCount: Patch371_GetStepCount;
     fn_ProcessPatch: Patch371_Process),
    (VerValue: 372;
     fn_GetInfo: Patch372_GetInfo;
     fn_GetStepCount: Patch372_GetStepCount;
     fn_ProcessPatch: Patch372_Process),
    (VerValue: 373;
     fn_GetInfo: Patch373_GetInfo;
     fn_GetStepCount: Patch373_GetStepCount;
     fn_ProcessPatch: Patch373_Process),
    (VerValue: 374;
     fn_GetInfo: Patch374_GetInfo;
     fn_GetStepCount: Patch374_GetStepCount;
     fn_ProcessPatch: Patch374_Process),
    (VerValue: 375;
     fn_GetInfo: Patch375_GetInfo;
     fn_GetStepCount: Patch375_GetStepCount;
     fn_ProcessPatch: Patch375_Process),
    (VerValue: 376;
     fn_GetInfo: Patch376_GetInfo;
     fn_GetStepCount: Patch376_GetStepCount;
     fn_ProcessPatch: Patch376_Process),
    (VerValue: 377;
     fn_GetInfo: Patch377_GetInfo;
     fn_GetStepCount: Patch377_GetStepCount;
     fn_ProcessPatch: Patch377_Process),
    (VerValue: 378;
     fn_GetInfo: Patch378_GetInfo;
     fn_GetStepCount: Patch378_GetStepCount;
     fn_ProcessPatch: Patch378_Process),
    (VerValue: 379;
     fn_GetInfo: Patch379_GetInfo;
     fn_GetStepCount: Patch379_GetStepCount;
     fn_ProcessPatch: Patch379_Process),
    (VerValue: 379;
     fn_GetInfo: Patch380_GetInfo;
     fn_GetStepCount: Patch380_GetStepCount;
     fn_ProcessPatch: Patch380_Process),
    (VerValue: 379;
     fn_GetInfo: Patch381_GetInfo;
     fn_GetStepCount: Patch381_GetStepCount;
     fn_ProcessPatch: Patch381_Process),
    (VerValue: 380;
     fn_GetInfo: Patch384_GetInfo;
     fn_GetStepCount: Patch384_GetStepCount;
     fn_ProcessPatch: Patch384_Process),
    (VerValue: 381;
     fn_GetInfo: Patch385_GetInfo;
     fn_GetStepCount: Patch385_GetStepCount;
     fn_ProcessPatch: Patch385_Process),
    (VerValue: 382;
     fn_GetInfo: Patch386_GetInfo;
     fn_GetStepCount: Patch386_GetStepCount;
     fn_ProcessPatch: Patch386_Process),
    (VerValue: 383;
     fn_GetInfo: Patch387_GetInfo;
     fn_GetStepCount: Patch387_GetStepCount;
     fn_ProcessPatch: Patch387_Process),
    (VerValue: 384;
     fn_GetInfo: Patch388_GetInfo;
     fn_GetStepCount: Patch388_GetStepCount;
     fn_ProcessPatch: Patch388_Process),
    (VerValue: 385;
     fn_GetInfo: Patch389_GetInfo;
     fn_GetStepCount: Patch389_GetStepCount;
     fn_ProcessPatch: Patch389_Process),
    (VerValue: 386;
     fn_GetInfo: Patch390_GetInfo;
     fn_GetStepCount: Patch390_GetStepCount;
     fn_ProcessPatch: Patch390_Process),
    (VerValue: 387;
     fn_GetInfo: Patch391_GetInfo;
     fn_GetStepCount: Patch391_GetStepCount;
     fn_ProcessPatch: Patch391_Process),
    (VerValue: 388;
     fn_GetInfo: Patch392_GetInfo;
     fn_GetStepCount: Patch392_GetStepCount;
     fn_ProcessPatch: Patch392_Process),
    (VerValue: 389;
     fn_GetInfo: Patch393_GetInfo;
     fn_GetStepCount: Patch393_GetStepCount;
     fn_ProcessPatch: Patch393_Process)
  );


function GetSpecialPath(CSIDL: word): string;
var s:  string;
begin
  SetLength(s, MAX_PATH);
  if not SHGetSpecialFolderPath(0, PChar(s), CSIDL, true)
  then s := '';
  result := PChar(s);
end;


function UnCloseString(s: string): string;
begin
  Result := s;
  if Result<>EmptyStr then
    if Result[1]='"' then Result := Copy(Result,2,Length(Result)-2);
end;

function Str2Date(s: string): TDate;
begin
  Result := EncodeDate(
    StrToInt(Copy(s,7,4)),
    StrToInt(Copy(s,4,2)),
    StrToInt(Copy(s,1,2)));
end;

procedure TfmMain.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  fInProcess := false;
  fBreak := false;
//getting install path
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    if OpenKey('SOFTWARE\GranitCentre\GranVUS',false) then
      if ValueExists('InstallPath') then
        edPath.Text := ReadString('InstallPath');
  finally
    Free;
  end;
  if edPath.Text=EmptyStr then
    edPath.Text := 'c:\Program Files\GranVUS';
  PC.ActivePage := tshCommon;
  tshCommon.OnShow(tshCommon);
  windows7 := False;
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not fInProcess then
    CanClose := Confirm('Выйти из программы обновления?')
  else begin
    CanClose := false;
    if not fBreak then
      fBreak := Confirm('Прервать обновление системы?');
  end;
end;

procedure TfmMain.sbPathClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выберите папку установки "Гран-ВУР"...',EmptyStr,s) then
    edPath.Text := s;
end;


procedure TfmMain.AllowProgrammaticMacros;
begin
  with TRegistry.Create do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    Access := KEY_ALL_ACCESS;
    if OpenKey('SOFTWARE\Microsoft\WinHelp',true) then
      WriteInteger('AllowProgrammaticMacros', 1);
  finally
    Free;
  end; 
end;

procedure TfmMain.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
  ShowErr(E.Message);
  Application.Terminate;
end;

procedure TfmMain.btnPrevClick(Sender: TObject);
begin
  PC.ActivePageIndex := PC.ActivePageIndex-1;
  btnPrev.Enabled := PC.ActivePageIndex>0;
  btnNext.Enabled := True;
end;

procedure TfmMain.btnNextClick(Sender: TObject);
begin
  case PC.ActivePageIndex of
    0: begin
    //check install path
      while (edPath.Text <> '') and (edPath.Text[Length(edPath.Text)] = '\') do
        edPath.Text := copy(edPath.Text, 1, Length(edPath.Text)-1);
      ChkDateFormat;
      if not FileExists(edPath.Text+'\granvus.exe') then begin
        edPath.SetFocus;
        ShowErr('Неверно указан путь установки.');
        Exit;
      end;
    //save path value to registry
      with TRegistry.Create do
      try
       RootKey := HKEY_LOCAL_MACHINE;
        OpenKey('SOFTWARE\GranitCentre\GranVUS',true);
        WriteString('InstallPath',edPath.Text);
      finally
        Free;
      end;
      PostMessage(Handle,WM_MY_CHKINFO,0,0);
    end;
    1: begin
      if lbExeVerState.Font.Color<>clBlue then
      begin
        ShowInfo('Для выбранной копии ПО "Гран-ВУР" обновление не требуется или недоступно!');
        Exit;
      end;
      PostMessage(Handle,WM_MY_START,0,0);
    end;
  end;
  PC.ActivePageIndex := PC.ActivePageIndex+1; 
  btnPrev.Enabled := PC.ActivePageIndex>0;
end;

procedure TfmMain.tshCommonShow(Sender: TObject);
begin
  pnlLogo.Parent := (Sender as TWinControl);
end;

{function TfmMain.WinHlp32Installed: Boolean;
var i,j:integer;
    s: string;
    reg,reg_2:TRegistry;
    Sub,Sub_2:TStringList;
begin
  Result := False;
  Sub:=TStringList.Create;
  reg:=TRegistry.Create;
  reg_2:=TRegistry.Create;
  reg.RootKey:=HKEY_LOCAL_MACHINE;
  s:='SoftwareMicrosoftWindowsCurrentVersionUninstall';
  reg.OpenKey(s,false);
  reg.GetKeyNames(Sub);
  Sub.Sorted:=true;
  for i:=0 to Sub.Count-1 do
  begin
    Sub_2:=TStringList.Create;
    reg_2.RootKey:=HKEY_LOCAL_MACHINE;
    reg_2.OpenKey(s+Sub[i], false);
    reg_2.GetValueNames(Sub_2);
    if Sub_2.Count > 0 then
    begin
       for j:=0 to Sub_2.Count-1 do
         if pos('DisplayName', Sub_2[j]) <> 0 then
           begin
             if pos('KB917607', reg_2.ReadString(Sub_2[j])) <> 0 then begin
               Result := True;
               Break;
             end;
           end;
       Sub_2.Free;
    end;
    reg_2.CloseKey;
    if Result then Break;
  end;
  Sub.Free;
  Reg.Free;
end;}


procedure TfmMain.FChkInfo(var msg: TMessage);
var
  Info: Pointer;
  InfoSize: DWORD;
  FileInfo: PVSFixedFileInfo;
  FileInfoSize: DWORD;
  Tmp: DWORD;
begin
  nExe := -1; FExeVer := -1;
  lbExeVer.Caption := 'n/a';
//получение параметров обновления
  InfoSize := GetFileVersionInfoSize(PChar(ExtractFilePath(Application.ExeName)+'bin\granvus.exe'),Tmp);
  if InfoSize<>0 then begin
    GetMem(Info,InfoSize);
    try
      GetFileVersionInfo(PChar(ExtractFilePath(Application.ExeName)+'bin\granvus.exe'),0,InfoSize,Info);
      VerQueryValue(Info,'\',Pointer(FileInfo),FileInfoSize);
      lbExeVerPatch.Caption :=
        Format('%d.%d.%d.%d',
               [FileInfo.dwFileVersionMS shr 16,
                FileInfo.dwFileVersionMS and $FFFF,
                FileInfo.dwFileVersionLS shr 16,
                FileInfo.dwFileVersionLS and $FFFF]);
    finally
      FreeMem(Info);
    end;
  end;
//получение версии исполняемого файла
  InfoSize := GetFileVersionInfoSize(PChar(edPath.Text+'\granvus.exe'),Tmp);
  if InfoSize<>0 then begin
    GetMem(Info,InfoSize);
    try
      GetFileVersionInfo(PChar(edPath.Text+'\granvus.exe'),0,InfoSize,Info);
      VerQueryValue(Info,'\',Pointer(FileInfo),FileInfoSize);
      lbExeVer.Caption :=
        Format('%d.%d.%d.%d',
               [FileInfo.dwFileVersionMS shr 16,
                FileInfo.dwFileVersionMS and $FFFF,
                FileInfo.dwFileVersionLS shr 16,
                FileInfo.dwFileVersionLS and $FFFF]);

      FExeVer := StrToInt(StringReplace(lbExeVer.Caption,'.',EmptyStr,[rfReplaceAll]));
    finally
      FreeMem(Info);
    end;
  end;
//сравнение версий исполняемых файлов
  btnNext.Enabled := False;
  if lbExeVer.Caption='n/a' then begin
    lbExeVerState.Caption := 'обновление невозможно';
    lbExeVerState.Font.Color := clRed;
  end
  else begin
    nExe :=
      StrToInt(StringReplace(lbExeVerPatch.Caption,'.',EmptyStr,[rfReplaceAll]))-
      FExeVer;
    if nExe>0 then begin
      lbExeVerState.Caption := 'обновление требуется';
      lbExeVerState.Font.Color := clBlue;
      btnNext.Enabled := True;
    end
    else begin
      lbExeVerState.Caption := 'обновление не требуется';
      lbExeVerState.Font.Color := clWindowText;
    end;
  end;
  Update;
end;

procedure TfmMain.FSetLinks;
//
  function GetDesktopFolder: String;
  begin
    with TRegistry.Create do
    try
      RootKey := HKey_Current_User;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', False);
      Result := IncludeTrailingPathDelimiter(ReadString('Desktop'));
      {StartUp, Cache, Cookies, Desktop, Favorites,
       Fonts, Personal, Programs, SendTo, Start Menu, Startp}
    finally Free;
    end;
  end;
//
var
  DesktopFolder : String;
  LinkExists    : Boolean;
  VerName       : String;
  RelativePath  : String;
//
  procedure LinkProcess;
  //
    function RelativePathInFile(const AFileName: String): Boolean;
    //
      function RemoveZeros(const S: AnsiString): AnsiString;
      var I: Integer; P: PAnsiChar;
      begin
        SetLength(Result, Length(S)); P := @Result[1]; //S>''!
        for I := 1 to Length(S) do  if S[I]>=#32 then begin
          P^:=S[I]; Inc(P);
        end;
        SetLength(Result, P - @Result[1]);
      end;
    //
    var
      FS : TFileStream;
      S  : AnsiString;
    begin
      FS := TFileStream.Create(AFileName, fmOpenRead);
      SetLength(S, FS.Size);
      FS.Read(S[1], FS.Size);
      FS.Free;
      Result := AnsiContainsText(RemoveZeros(S),RelativePath);
    end;
  //
    procedure RenameLink(const AFile: String);
    var
      NewName: String;
      I: Integer;
    begin
      LinkExists := True;
      NewName := DesktopFolder+'Гран-ВУР '+VerName;
      if AnsiSameText(AFile, NewName+'.LNK') then Exit;
      if FileExists(NewName+'.LNK') then begin
        I:=2;
        while FileExists(NewName+'('+IntToStr(I)+').LNK') do Inc(I);
        NewName := NewName+'('+IntToStr(I)+')';
      end;
      RenameFile(AFile, NewName+'.LNK');
    end;
  //
  var
    ffh      : THandle;
    ffd      : _WIN32_FIND_DATAW;
    IObject  : IUnknown;
    SLink    : IShellLink;
    PFile    : IPersistFile;
    FullName : String;
//    ObjPath  : array [0..MAX_PATH] of Char;
  begin
    try
      LinkExists := False;
      IObject := CreateComObject(CLSID_ShellLink);
      SLink   := IObject as IShellLink;
      PFile   := IObject as IPersistFile;
      ffh     := FindFirstFile(PChar(DesktopFolder+'*.lnk'), ffd);
      if ffh <> INVALID_HANDLE_VALUE then
      try
        repeat
          FullName  := DesktopFolder+ffd.cFileName;
  //        PFile.Load(PWChar(WideString(FullName)),0);
  //        SLink.GetPath(ObjPath, MAX_PATH, ffd, SLGP_UNCPRIORITY);
  //        if AnsiSameText(edPath.Text+'\granvus2.exe',ObjPath)
          if RelativePathInFile(FullName) then RenameLink(FullName);//LinkExists := True;
        until  FindNextFile(ffh, ffd)=LONGBOOL(0);
      finally  Windows.FindClose(ffh);
      end;
//      if not LinkExists then begin
//        SLink.SetPath(PChar(edPath.Text+'\granvus2.exe'));
//        FullName := DesktopFolder+'Гран-Бронирование '+VerName+'.LNK';
//        PFile.Save(PWChar(WideString(FullName)), FALSE);
//      end;
    except on E: Exception do ShowMessage(E.Message);
    end;
  end;
//
  function GetVerName: String;
  var
    s: String;
    i: Integer;
  begin
    s := AAppPatch[High(AAppPatch)].fn_GetInfo;
    i := Pos(':', s);
    Result := Copy(s, 8, i-8);
  end;
//
begin
  if lbExeVerState.Font.Color <> clBlue then Exit;

  lbProcState.Caption := 'Обновление ярлыков на рабочем столе...';
  Application.ProcessMessages;
  DesktopFolder := GetDesktopFolder;
  RelativePath  := ExtractRelativePath(DesktopFolder,edPath.Text+'\granvus.exe');
  VerName := GetVerName;
  LinkProcess;
end;

procedure TfmMain.FStart(var msg: TMessage);
var i,n,d: Integer;
begin
  btnPrev.Visible := false;
  btnNext.Visible := false;
  fInProcess := true;
//connect to db
  if FExeVer < 370 then
  with TIniFile.Create(edPath.Text+'\settings.ini') do
  try
    dbConn.ConnectionString := ReadString('CONNECTION','CONNECTION_STRING',EmptyStr);
    dbConn.LoginPrompt := ReadBool('CONNECTION','CONNECTION_PROMPT',false);
    dbConn.ConnectionTimeout := ReadInteger('CONNECTION','CONNECTION_TIMEOUT',150);
    dbConn.CommandTimeout := ReadInteger('CONNECTION','COMMAND_TIMEOUT',300);
    dbConn.Open;
  finally Free;
  end
  else
  with TRegistryIniFile.Create('Software\Granit\GranVus\Settings') do
  try
    if AnsiUpperCase(ReadString('Paths','REPORTS',EmptyStr)) =
       AnsiUpperCase(edPath.Text + '\Reports') then DeleteKey('Paths','REPORTS');
    dbConn.ConnectionString := ReadString('CONNECTION','CONNECTION_STRING',EmptyStr);
    CheckVirtualStore;
    dbConn.LoginPrompt := ReadBool('CONNECTION','CONNECTION_PROMPT',false);
    dbConn.ConnectionTimeout := ReadInteger('CONNECTION','CONNECTION_TIMEOUT',150);
    dbConn.CommandTimeout := ReadInteger('CONNECTION','COMMAND_TIMEOUT',300);
    dbConn.Properties['Jet OLEDB:Database Password'].Value := ReverseString('9011ets18q54');
    dbConn.Open;
  finally Free;
  end;

  pbMain.Max := 1;//?
  i := Pos('.', lbExeVer.Caption);
  i := PosEx('.', lbExeVer.Caption, i+1);
  i := PosEx('.', lbExeVer.Caption, i+1);
  d := StrToInt(StringReplace(Copy(lbExeVer.Caption, 1, i-1),'.','',[rfReplaceAll]));
  for n:=Low(AAppPatch) to High(AAppPatch) do
    if d<AAppPatch[n].VerValue then
      pbMain.Max := pbMain.Max + AAppPatch[n].fn_GetStepCount;
//copy bin
  Application.ProcessMessages;
  if not FBreak then
    FProcessBin;
//apply db-patch
  Application.ProcessMessages;
  if not FBreak then
  for n:=Low(AAppPatch) to High(AAppPatch) do
    if FBreak then break
    else
      if d<AAppPatch[n].VerValue then begin
        AAppPatch[n].fn_ProcessPatch;
      end;
//apply Windows Vista updates
  Application.ProcessMessages;
  if IsVista {and not WinHlp32Installed} then begin
    //ShellExecute(0,nil,PChar(edPath.Text + '\Windows6.0-KB917607-x86.msu'),nil,PChar(edPath.Text),SW_SHOWDEFAULT);
    AllowProgrammaticMacros;
  end;
  dbConn.Close;
  Application.ProcessMessages;
  if windows7 then
    CopyFile(PChar(sV0), PChar(sVs), False);

  if FBreak
    then ShowInfo('Операция прервана пользователем!')
    else begin
      ShowInfo('Операция успешно завершена!');
      if IsVista then
        if Confirm('Для корректной работы программы требуется установить обновление Windows. Установить?') then
          ShellExecute(0,nil,PChar(edPath.Text + '\Windows6.0-KB917607-x86.msu'),nil,PChar(edPath.Text),SW_SHOWDEFAULT);
    end;
  Application.Terminate;
end;

function TfmMain.IsVista: Boolean;
var
  NTBres, BRes: Boolean;
  OSVI: TOSVERSIONINFO;
  OSVI_NT: TOSVERSIONINFOEX;
begin
  Result := False;
  NTBRes := False;
  try
    OSVI_NT.dwOSVersionInfoSize := SizeOf(TOSVERSIONINFOEX);
    NTBRes := GetVersionExA(OSVI_NT);
    OSVI.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    BRes := GetVersionEx(OSVI);
  except
    OSVI.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    BRes := GetVersionEx(OSVI);
  end;
  if (not BRes) and (not NTBres) then Exit;
  Move(OSVI, OSVI_NT, SizeOf(TOSVersionInfo));

  if (OSVI_NT.dwPlatformId = VER_PLATFORM_WIN32_NT) and
     (OSVI_NT.dwMajorVersion = 6) and (OSVI_NT.dwMinorVersion = 0) then Result := True;
end;

procedure TfmMain.FProcessBin;
var
  FL        : TStringList;//file list
  SourceDir : String;
  //
  procedure CheckReadOnly(sFile: String);
  var
   attr: Integer;
  begin
    if FileExists(sFile) then begin
      attr := GetFileAttributes(PChar(sFile));
      if (Attr and FILE_ATTRIBUTE_READONLY) <> 0 then
        SetFileAttributes(PChar(sFile), Attr and not FILE_ATTRIBUTE_READONLY);
    end;
  end;
  //
  procedure GetFileList(Dir: String);
  var F: TSearchRec;
  begin
    if FindFirst(SourceDir+Dir+'\*.*',faAnyFile,F)=0 then begin
      repeat
        if (F.Attr and faDirectory)=0 then
          FL.Add(Dir+'\'+F.Name)
        else
          if F.Name[1]<>'.' then begin
            if not ForceDirectories(edPath.Text+'\'+Dir+'\'+F.Name) then
                ShowErr('Ошибка при создании папки:'#13+edPath.Text+'\'+Dir+'\'+F.Name);
            GetFileList(Dir+'\'+F.Name);
          end;
      until FindNext(F)<>0;
      FindClose(F);
    end;
  end;
  //
  procedure DoCopy;
    procedure CopyIni(const FN, PathSource, PathTarget: String);
    var
      I: Integer;
      SL: TStringList;
    begin
      SL := TStringList.Create;
      try
        with TIniFile.Create(PathSource+'\'+FN) do
        try ReadSection('REGISTER', SL);
        finally Free;
        end;
        with TiniFile.Create(PathTarget+'\'+FN) do
        try
          for I := 0 to SL.Count-1 do if (SL.ValueFromIndex[I]<>'') then WriteString('REGISTER',SL.Names[I], SL.ValueFromIndex[I]);
        finally Free;
        end;
      finally SL.Free;
      end;
    end;
  const reg_info_ini='reg_info.ini';
  var I : Integer; SkipMDB370: Boolean;
  begin
    SkipMDB370 := FExeVer>=370;
    for I := 0 to FL.Count-1 do
    if not (SkipMDB370 and AnsiContainsText(FL[I], 'granvus370.mdb'))
    then begin
      lbProcState.Caption := 'Установка файла '+FL[I]+'...';
      try
        if SameText(FL[I],reg_info_ini) then CopyIni(reg_info_ini, SourceDir, edPath.Text) else begin
          CheckReadOnly(edPath.Text{+'\'}+FL[I]);
          if not CopyFile(PChar(SourceDir{+'\'}+FL[I]), PChar(edPath.Text{+'\'}+FL[I]), false) then Abort;
        end;
      except
        ShowErr('Ошибка при установке файла:'#13+edPath.Text{+'\'}+FL[I]);
      end;
      pbMain.StepIt;
      Application.ProcessMessages;
      if FBreak then Exit;
    end;
  end;
  //
begin
  SourceDir := ExtractFilePath(Application.ExeName)+'Bin';
  FL := TStringList.Create;
  FL.Sorted := True;
  try
    lbProcState.Caption := 'Проверка структуры каталогов...';
    GetFileList('');
    Application.ProcessMessages;
    if FBreak then Exit;
    CheckReadOnly(edPath.Text+'\PlugIns\PrnOrg.dll');
    DeleteFile(edPath.Text+'\PlugIns\PrnOrg.dll');
    CheckReadOnly(edPath.Text+'\Templates\org_card.rtf');
    DeleteFile(edPath.Text+'\Templates\org_card.rtf');
    Application.ProcessMessages;
    if FBreak then Exit;
    pbMain.Max := pbMain.Max + FL.Count;
    DoCopy;
    FSetLinks;
  finally FL.Free;
  end;
end;

procedure TfmMain.actDummyExecute(Sender: TObject);
begin
  asm nop end;
end;

procedure TfmMain.btnInfoClick(Sender: TObject);
var n: Integer;
    s: string;
    Tmp: Array[0..MAX_PATH-1] of char;
begin
  s := EmptyStr;
  for n:=Low(AAppPatch) to High(AAppPatch) do
    s := AAppPatch[n].fn_GetInfo+#13#13+s;
  s :=
    'ОБНОВЛЕНИЕ КОМПЛЕКСА ПО "ГРАН_ВУР" ОТ ВЕРСИИ 3.5'#13+
    '___________________________________________________________________________'#13#13+
    'ИСТОРИЯ ВЕРСИЙ:'#13#13+
    s +
    '___________________________________________________________________________'#13+
    '(С) 2010, ОАО "НПП "Гранит-Центр"'#13+
    '109147, г. Москва, ул. Воронцовская, д. 23'#13+
    'тел. 911-0106'#13+
    'факс 911-0258';
  GetTempPath(MAX_PATH,Tmp);
  with TStringList.Create do
  try
    Text := s;
    SaveToFile(String(Tmp)+'\vur_update.txt');
  finally
    Free;
  end;
  ShellExecute(0,nil,PChar(String(Tmp)+'\vur_update.txt'),nil,nil,SW_SHOWDEFAULT);
end;


function GetFileDate(TheFileName: string): TDateTime;
var
  FHandle: integer;
begin
  FHandle := FileOpen(TheFileName, 0);
  try
    Result := FileDateToDateTime(FileGetDate(FHandle));
  finally
    FileClose(FHandle);
  end;
end;


procedure TfmMain.CheckVirtualStore;
var
  i: Integer;
  d0, dVs: TDateTime;
begin
  sVs := GetSpecialPath(CSIDL_LOCAL_APPDATA);
  if sVs <> '' then begin
    sV0 := dbConn.ConnectionString;
    i := Pos('DATA SOURCE=', AnsiUpperCase(sV0));
    if i > 0 then begin
      sV0 := Copy(sV0, i+Length('DATA SOURCE='), MaxInt);
      i := Pos(';', sV0);
      if i > 0 then
        sV0 := Copy(sV0, 1, i-1);
      i := Pos('\PROGRAM FILES', AnsiUpperCase(sV0));
      if i > 0 then begin
        if sVs[Length(sVs)] <> '\' then
          sVs := sVs + '\';
        sVs := sVs + 'VirtualStore' + Copy(sV0, i, MaxInt);
        if FileExists(sVs) then begin
          if FileExists(sV0) then begin
            d0 := GetFileDate(sV0);
            dVs := GetFileDate(sVs);
            if d0 >= dVs then Exit;
          end;
          CopyFile(PChar(sVs), PChar(sV0), False);
          windows7 := True;
        end;
      end;
    end;
  end;
end;

procedure TfmMain.ChkDateFormat;
var buf: Array[0..1024] of char;
begin
  GetLocaleInfo(0,LOCALE_SSHORTDATE,buf,1024);
  if AnsiUpperCase(buf)<>'DD.MM.YYYY' then
    if not Confirm(
      'Заданный системный формат даты не совместим с приложением!'#13+
      'Требуемый формат "dd.MM.yyyy". Установить его?') then Application.Terminate
    else
      SetLocaleInfo(0,LOCALE_SSHORTDATE,'dd.MM.yyyy');
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
  SetForegroundWindow(Handle);
end;

end.


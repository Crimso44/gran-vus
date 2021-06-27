unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Buttons, DB, ADODB, AppEvnts,
  ActnList, XPMan;
const
  WM_MY_CHKINFO = WM_USER + 100;
  WM_MY_START = WM_USER + 101;

type
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
    Label6: TLabel;
    lbDbVer: TLabel;
    Label8: TLabel;
    lbDbVerPatch: TLabel;
    Label10: TLabel;
    lbDbVerState: TLabel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Image2: TImage;
    Image3: TImage;
    dbConn: TADOConnection;
    pnlLogo: TPanel;
    Image1: TImage;
    Label7: TLabel;
    pbMain: TProgressBar;
    lbProcState: TLabel;
    Label9: TLabel;
    ActionList1: TActionList;
    actDummy: TAction;
    actShiftDummy: TAction;
    btnInfo: TButton;
    XPManifest1: TXPManifest;
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
    { Private declarations }
    fInProcess,fBreak: boolean;
    nExe,nDb: Integer;
    procedure FChkInfo(var msg: TMessage); message WM_MY_CHKINFO;
    procedure FStart(var msg: TMessage); message WM_MY_START;
    procedure FFillDbList(List: TStringList);
    procedure FProcessDbPatch(Folder: string);
    procedure FProcessScript(FileName: string);
    procedure FProcessExe;
    procedure FInstallCrypt;
    procedure FSetLinks;
    procedure FSetINI;
    function GetVerNum(s: String): Double;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses msg, registry, filectrl, inifiles, Rdialogs, StrUtils,
     ShellAPI, ShlObj, ComObj, ActiveX;

{$R *.dfm}

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
    if OpenKey('SOFTWARE\GranitCentre\GranVUS2',false) then
      if ValueExists('InstallPath') then
        edPath.Text := ReadString('InstallPath');
  finally
    Free;
  end;
  if edPath.Text=EmptyStr then
    edPath.Text := 'c:\Program Files\GranVus2';
  PC.ActivePage := tshCommon;
  tshCommon.OnShow(tshCommon);
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
  if SelectDirectory('Выберите папку установки "Гран-Бронирование"...',EmptyStr,s) then
    edPath.Text := s;
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
end;

procedure TfmMain.btnNextClick(Sender: TObject);
begin
  case PC.ActivePageIndex of
    0: begin
    //check install path
      if not FileExists(edPath.Text+'\granvus2.exe') then begin
        edPath.SetFocus;
        ShowErr('Неверно указан путь установки.');
        Exit;
      end;
    //save path value to registry
      with TRegistry.Create do
      try
       RootKey := HKEY_LOCAL_MACHINE;
        OpenKey('SOFTWARE\GranitCentre\GranVUS2',true);
        WriteString('InstallPath',edPath.Text);
      finally
        Free;
      end;
      PostMessage(Handle,WM_MY_CHKINFO,0,0);
    end;
    1: begin
      if not ((lbExeVerState.Font.Color=clBlue) or
              (lbDbVerState.Font.Color=clBlue)) then
      begin
        ShowInfo('Для выбранной копии ПО "Гран-Бронирование" обновление не требуется или недоступно!');
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

procedure TfmMain.FChkInfo(var msg: TMessage);
var
  Info: Pointer;
  InfoSize: DWORD;
  FileInfo: PVSFixedFileInfo;
  FileInfoSize: DWORD;
  Tmp: DWORD;
begin
  nExe := -1;
  nDb := -1;
  lbDbVer.Caption := 'n/a';
  lbExeVer.Caption := 'n/a';
//получение параметров обновления
  with TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) do
  try
    lbExeVerPatch.Caption := ReadString('INFO','ExeVer','0.0.0');
    lbDbVerPatch.Caption := ReadString('INFO','DbVer','0.0');
  finally
    Free;
  end;
//получение версии исполняемого файла
  InfoSize := GetFileVersionInfoSize(PChar(edPath.Text+'\granvus2.exe'),Tmp);
  if InfoSize<>0 then begin
    GetMem(Info,InfoSize);
    try
      GetFileVersionInfo(PChar(edPath.Text+'\granvus2.exe'),0,InfoSize,Info);
      VerQueryValue(Info,'\',Pointer(FileInfo),FileInfoSize);
      lbExeVer.Caption :=
        Format('%d.%d.%d',
               [FileInfo.dwFileVersionMS shr 16,
                FileInfo.dwFileVersionMS and $FFFF,
                FileInfo.dwFileVersionLS shr 16,
                FileInfo.dwFileVersionLS and $FFFF]);

    finally
      FreeMem(Info);
    end;
  end;
//сравнение версий исполняемых файлов
  if lbExeVer.Caption='n/a' then begin
    lbExeVerState.Caption := 'обновление невозможно';
    lbExeVerState.Font.Color := clRed;
  end
  else begin
    nExe :=  CompareStr(
      StringReplace(lbExeVerPatch.Caption,'.',EmptyStr,[rfReplaceAll]),
      StringReplace(lbExeVer.Caption,'.',EmptyStr,[rfReplaceAll]));
    if nExe>0 then begin
      lbExeVerState.Caption := 'обновление требуется';
      lbExeVerState.Font.Color := clBlue;
    end
    else begin
      lbExeVerState.Caption := 'обновление не требуется';
      lbExeVerState.Font.Color := clWindowText;
    end;
  end;
  Update;
//получение строки подключения
  with TIniFile.Create(edPath.Text+'\settings.ini') do
  try
    dbConn.Connected := false;
    dbConn.ConnectionString := ReadString('CONNECTION','CONNECTION_STRING',EmptyStr);
  finally
    Free;
  end;
  Screen.Cursor := crHourGlass;
  try
    dbConn.Connected := true;
    with TADOQuery.Create(Self) do
    try
      Connection := dbConn;
      SQL.Text := 'select top 1 * from VerInfo order by VerId desc';
      try
        Open;
        if not IsEmpty then
          lbDbVer.Caption := FieldByName('VerStr').AsString;
      except
      //версия до 3.5 - не обновляем
      end;
    finally
      Free;
    end;
  except
    on E: Exception do
      ShowErr('Ошибка при подключении к базе данных!'#13#13+E.Message);
  end;
  Screen.Cursor := crDefault;
//сравнение версий БД
  if lbDbVer.Caption='n/a' then begin
    lbDbVerState.Caption := 'обновление невозможно';
    lbDbVerState.Font.Color := clRed;
  end
  else begin
    nDb := CompareStr(
      StringReplace(lbDbVerPatch.Caption,'.',EmptyStr,[rfReplaceAll]),
      StringReplace(lbDbVer.Caption,'.',EmptyStr,[rfReplaceAll]));
    if nDb>0 then begin
      lbDbVerState.Caption := 'обновление требуется';
      lbDbVerState.Font.Color := clBlue;
    end
    else begin
      lbDbVerState.Caption := 'обновление не требуется';
      lbDbVerState.Font.Color := clWindowText;
    end;
  end;
  if dbConn.Connected then FInstallCrypt;
end;

procedure TfmMain.FStart(var msg: TMessage);
  function LockDB(ALock: Boolean): Boolean;
  begin
    Result := False;
    with TADOQuery.Create(Self) do
    try
    try
      Connection := dbConn;
      SQL.Text := 'alter database '+Connection.DefaultDatabase+' set '+
                  IfThen(ALock,'single','multi')+'_user with no_wait';
      ExecSQL;
      Result := True;
    except
    end;
    finally
      Free;
    end;
  end;
var DbList: TStringList;
    n: Integer;
    d: DWord;
begin
  if not LockDB(True) then begin
    ShowErr('Невозможно обновить базу данных! Имеются активные подключения!');
    Application.Terminate;
    Exit;
  end;
  btnPrev.Visible := false;
  btnNext.Visible := false;
  fInProcess := true;
//получение списка обновлений для БД
  DbList := TStringList.Create;
  try
    if lbDbVerState.Font.Color=clBlue then
      FFillDbList(DbList);
    pbMain.Max := DbList.Count;
    if lbExeVerState.Font.Color=clBlue then
      pbMain.Max := pbMain.Max+1;
    d := GetTickCount;
    while GetTickCount-d<500 do begin
      Application.ProcessMessages;
      if FBreak then break;
    end;
//обновление БД
    for n:=0 to DbList.Count-1 do
      if FBreak then break
      else begin
        FProcessDbPatch(ExtractFilePath(Application.ExeName)+'DB\'+DbList[n]);
        pbMain.StepIt;
      end;
//копирование файлов
    if not FBreak then
      if lbExeVerState.Font.Color=clBlue then begin
        FProcessExe;
        pbMain.StepIt;
      end;
//Обновление ярлыков на рабочем столе
    FSetLinks;
//Обновление файла конфигурации
    FSetINI;
  finally
    DbList.Free;
    LockDB(False);
  end;
  if FBreak then
    ShowInfo('Операция прервана пользователем!')
  else
    ShowInfo('Операция успешно завершена!');
  Application.Terminate;
end;

function TfmMain.GetVerNum(s: String): Double;
var
  i: Integer;
begin
  i := Pos('.', s);
  i := PosEx('.', s, i+1);
  if i > 0 then
    s := Copy(s, 1, i-1) + Copy(s, i+1, MaxInt);
  Result := StrToFloat(StringReplace(s,'.',DecimalSeparator,[]));
end;


procedure TfmMain.FFillDbList(List: TStringList);
var F: TSearchRec;
    fDone: boolean;
    i,n: Integer;
    s: string;
begin
  if FindFirst(ExtractFilePath(Application.ExeName)+'\Db\*.*',faDirectory,F)=0 then
  begin
    repeat
      if F.Name[1]<>'.' then
        if (F.Attr and faDirectory)<>0 then begin
          s := F.Name;
          if GetVerNum(F.Name) > GetVerNum(lbDbVer.Caption)
          then List.Add(F.Name);
        end;
    until FindNext(F)<>0;
    FindClose(F);
  end;
  repeat
    fDone := true;
    for n:=0 to List.Count-2 do
      if GetVerNum(List[n]) > GetVerNum(List[n+1]) then
      begin
        s := List[n];
        List[n] := List[n+1];
        List[n+1] := s;
        fDone := false;
      end;
  until fDone;
end;

procedure TfmMain.FProcessDbPatch(Folder: string);
var n: Integer;
    s: string;
begin
  with TIniFile.Create(Folder+'\patch.ini') do
  try
//добавляем информацию о версии
    with TADOQuery.Create(Self) do
    try
      Connection := dbConn;
      SQL.Text :=
        'insert into VerInfo(VerStr,VerDate,VerDesc)'#13+
        'values(:VerStr,:VerDate,:VerDesc)';
      Parameters.ParseSQL(SQL.Text,true);
      Parameters.ParamByName('VerStr').Value := ReadString('MAIN','VerStr','0.0');
      Parameters.ParamByName('VerDate').Value := Str2Date(ReadString('MAIN','VerDate','01.01.1900'));
      Parameters.ParamByName('VerDesc').Value := UncloseString(ReadString('MAIN','VerDesc',EmptyStr));
      ExecSQL;
    finally
      Free;
    end;
//список файлов-обновлений
    n:=1;
    while ValueExists('ACTIONS','Action'+IntToStr(n)) do begin
      s := ReadString('ACTIONS','Action'+IntToStr(n),EmptyStr);
      if s<>EmptyStr then begin
        lbProcState.Caption := 'Обновление '+ReadString('MAIN','VerStr','0.0')+' - '+UncloseString(ReadString(s,'Title',EmptyStr));
        Application.ProcessMessages;
        FProcessScript(Folder+'\'+ReadString(s,'Script',EmptyStr));
      end;
      Inc(n);
    end;
  finally
    Free;
  end;
end;

procedure TfmMain.FProcessScript(FileName: string);
var F: TextFile;
    s_sql,s: string;
begin
  try
    AssignFile(F,FileName);
    Reset(F);
  except
    raise Exception.CreateFmt('Файл не найден "%s"!',[FileName]);
  end;
  try
    while not eof(F) do begin
      Application.ProcessMessages;
      s_sql := EmptyStr;
      while not eof(F) do begin
        ReadLn(F,s);
        if Trim(UpperCase(s))='GO' then break;
        s_sql := s_sql +#13+ s;
        if Trim(UpperCase(s))='COMMIT' then break;
      end;
      if Trim(StringReplace(s_sql,#13,'',[rfReplaceAll]))<>EmptyStr then
        with TADOQuery.Create(Self) do
        try try
          Connection := dbConn;
          SQL.Text := s_sql;
          ExecSQL;
        except on E: Exception do begin
          ShowMessage(E.Message+#13#13+s_sql);
        end end;
        finally
          Free;
        end;
    end;
  finally
    CloseFile(F);
  end;
end;

procedure TfmMain.FProcessExe;
  procedure CopyFiles(sFolderFrom,sFolderTo: string);
  var
    F: TSearchRec;
    sFileTo, sFileFrom: String;
    //
    procedure CopyRegInfo;
    var
      SL              : TStringList;
      I               : Integer;
      sRegInfoSection : String;
    begin
      SL := TStringList.Create;
      try
        SL.LoadFromFile(sFileFrom);
        for I := SL.Count-1 downto 0 do
          if (SL[I]='') or ((SL[I][1]<>'[') and (SL.ValueFromIndex[I]='')) then SL.Delete(I);
        with TInifIle.Create(sFileTo) do
        try
          for I := 0  to SL.Count-1 do
            if SL[I][1]='['
              then begin sRegInfoSection := SL[I]; sRegInfoSection := Copy(sRegInfoSection, 2, Length(sRegInfoSection)-2) end
              else WriteString(sRegInfoSection, SL.Names[I], SL.ValueFromIndex[I]);
        finally Free;
        end;
      finally SL.Free;
      end;
    end;
    //
  var FileAttributes: Cardinal;
  begin
    if FindFirst(sFolderFrom+'\*.*',faAnyFile,F)=0 then begin
      repeat
        if F.Name[1]<>'.' then begin
          sFileTo   := sFolderTo+'\'+F.Name;
          sFileFrom := sFolderFrom+'\'+F.Name;
          if (F.Attr and faDirectory)<>0 then begin
//check if folder exists
            if not DirectoryExists(sFileTo) then
              if not CreateDirectory(PChar(sFileTo),nil) then
                raise Exception.CreateFmt('Ошибка при создании папки "%s"!',[sFileTo]);
            CopyFiles(sFileFrom, sFileTo);
          end
          else
            try
              if FileExists(sFileTo) then begin
                FileAttributes := FileGetAttr(sFileTo);
                if (FileAttributes and FILE_ATTRIBUTE_READONLY)>0 then begin
                  FileAttributes := FileAttributes and not FILE_ATTRIBUTE_READONLY;
                  FileSetAttr(sFileTo, FileAttributes);
                end;
              end;
              if SameText(F.Name, 'reg_info.ini') then CopyRegInfo else
              if not CopyFile(PChar(sFileFrom), PChar(sFileTo), false) then Abort;
            except
              raise Exception.CreateFmt('Ошибка при копировании файла "%s"!',[sFileTo]);
            end;
        end;
      until FindNext(F)<>0;
      FindClose(F);
    end;
  end;
var n: Integer;
    s: string;
begin
  lbProcState.Caption := 'Обновление программных модулей...';
  Application.ProcessMessages;
  CopyFiles(ExtractFilePath(Application.ExeName)+'\Exe',edPath.Text);
//delete needless files
  with TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini')) do
  try
    n := 1;
    while ValueExists('EXE','Remove'+IntToStr(n)) do begin
      s := UncloseString(ReadString('EXE','Remove'+IntToStr(n),EmptyStr));
      if s<>EmptyStr then
        if FileExists(edPath.Text+'\'+s) then
          DeleteFile(edPath.Text+'\'+s);
        if DirectoryExists(edPath.Text+'\'+s) then
          RemoveDir(edPath.Text+'\'+s);
      Inc(n);
    end;
  finally
    Free;
  end;

end;

procedure TfmMain.actDummyExecute(Sender: TObject);
begin
  asm nop end;
end;

procedure TfmMain.FInstallCrypt;
var
  query: TADOQuery;
  path: string;
procedure InstallCrypt(mes: string);
begin
  with query do begin
    Close;
    SQL.Text :=
      'exec master..sp_dropextendedproc ''xp_crypt_ver'''#13 +
      'exec master..sp_dropextendedproc ''xp_crypt_prepare'''#13 +
      'exec master..sp_dropextendedproc ''xp_crypt_add'''#13 +
      'exec master..sp_dropextendedproc ''xp_crypt_remove'''#13 +
      'exec master..sp_dropextendedproc ''xp_crypt_list'''#13 +
      'dbcc grcrypt(free)';
    try
      ExecSQL;
    except end;

    SQL.Text :=
      'DECLARE @sql_path VARCHAR(260), @data_path VARCHAR(260)'#13+
      'exec master..sp_MSget_setup_paths @sql_path OUTPUT, @data_path OUTPUT'#13+
      'select @sql_path + ''\Binn'' as bin_path';
    Open;
    path := Fields[0].AsString;
    if not CopyFile(
        PChar(ExtractFilePath(Application.ExeName)+'\Crypt\grcrypt.dll'),
        PChar(path+'\grcrypt.dll'),false) then
      raise Exception.Create('Файл библиотеки лицензирования не был скопирован.');
    Close;
    SQL.Text :=
      'exec master..sp_addextendedproc ''xp_crypt_ver'',''grcrypt.dll'''#13+
      'exec master..sp_addextendedproc ''xp_crypt_prepare'',''grcrypt.dll'''#13+
      'exec master..sp_addextendedproc ''xp_crypt_add'',''grcrypt.dll'''#13+
      'exec master..sp_addextendedproc ''xp_crypt_remove'',''grcrypt.dll'''#13+
      'exec master..sp_addextendedproc ''xp_crypt_list'',''grcrypt.dll''';
    ExecSQL;
    ShowInfo('Система лицензирования успешно ' + mes + '.');
  end;
end;
begin
    query := TADOQuery.Create(Self);
    with query do
    try
      Connection := dbConn;
      try
        SQL.Text :=
          'select * from master..sysobjects where name like ''xp_crypt_%'' ';
        Open;
        if Pos('(LOCAL)',UpperCase(dbConn.ConnectionString))=0 then begin
            ShowInfo('Система контроля лицензий не будет установлена!'#13+
                     'Установка возможна только на локальном сервере...')
        end
        else begin
          if IsEmpty then begin
            if Confirm('Установить систему лицензирования?') then
            begin
              InstallCrypt('установлена');
            end;
          end
          else InstallCrypt('обновлена');
        end;
      except
        on E: Exception do
          ShowErr('Ошибка при установки системы контроля лицензий!'#13+
                       E.Message);
      end;
    finally
      Free;
    end;
end;

procedure TfmMain.btnInfoClick(Sender: TObject);
begin
  ShellExecute(0,nil,PChar(ExtractFilePath(Application.ExeName)+'\readme.txt'),nil,nil,SW_SHOWDEFAULT);
end;


function GetShortcutInfo (LinkFile: widestring; var ShortPath, ShortDescription: widestring): boolean;
var
  SL: IShellLinkW;
  PF: IPersistFile;
  FindData: _WIN32_FIND_DATAW;
  AStr: array[0..MAX_PATH] of WideChar;
  IconIndex,ShowCmd:integer;
  HotKey:Word;
begin
  try
    result:=false;
    OleCheck(CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER, IShellLink, SL));
    PF := SL as IPersistFile;
    OleCheck(PF.Load(PWideChar(LinkFile), STGM_READ));
    OleCheck(SL.GetPath(AStr, MAX_PATH, FindData, SLGP_SHORTPATH));
    ShortPath := AStr; // file name
    OleCheck(SL.GetDescription(AStr, MAX_PATH));
    ShortDescription := AStr; // Description
    Result:=true;
  except
    Result := false;
  end;
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
      sPath, sDescr: WideString;
    begin

      GetShortcutInfo(AFileName, sPath, sDescr);

      {FS := TFileStream.Create(AFileName, fmOpenRead);
      SetLength(S, FS.Size);
      FS.Read(S[1], FS.Size);
      FS.Free;
      Result := AnsiContainsText(RemoveZeros(S),RelativePath);}
      Result := AnsiContainsText(sPath,RelativePath);
    end;
  //
    procedure RenameLink(const AFile: String);
    var
      NewName: String;
      I: Integer;
    begin
      LinkExists := True;
      NewName := DesktopFolder+'Гран-Бронирование '+VerName;
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
          if RelativePathInFile(FullName) then
            RenameLink(FullName);//LinkExists := True;
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
  begin
    Result := lbExeVerPatch.Caption;
    while RightStr(Result,2)='.0' do SetLength(Result, Length(Result)-2);
  end;
//
begin
  if lbExeVerState.Font.Color <> clBlue then Exit;

  lbProcState.Caption := 'Обновление ярлыков на рабочем столе...';
  Application.ProcessMessages;
  DesktopFolder := GetDesktopFolder;
  RelativePath  := ExtractRelativePath(DesktopFolder,edPath.Text+'\granvus2.exe');
  VerName := GetVerName;
  LinkProcess;
end;

procedure TfmMain.FSetINI;
begin
  lbProcState.Caption := 'Обновление файла конфигурации...';
  Application.ProcessMessages;
  with TIniFile.Create(edPath.Text+'\SETTINGS.INI') do
  try      WriteString('COMMON','LAST_LOGIN','ADMIN');
  finally  Free;
  end;
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
  SetForegroundWindow(Handle);
end;

end.

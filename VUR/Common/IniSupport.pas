unit IniSupport;

interface

uses ADOdb;

var   _IniName: string;

function LoadConnAttr(adoConn: TADOConnection): boolean;
procedure StoreConnAttr(adoConn: TADOConnection);

function GetPlugInsDir: string;
procedure SetPlugInsDir(value: string);
function GetTemplatesDir: string;
procedure SetTemplatesDir(value: string);
function GetReportsDir: string;
procedure SetReportsDir(value: string);
function GetBackUpDir: string;
procedure SetBackUpDir(value: string);

function GetTimeOut: Integer;
procedure SetTimeOut(value: Integer);

function GetExtMenu: Boolean;
procedure SetExtMenu(value: Boolean);

function GetLastLogin: String;
procedure SetLastLogin(value: String);

type
  TEventFilter = record
    efWho           : Integer;
    efNotEvents     : String;
    efNotObjects    : String;
    efFromDateCheck : Boolean;
    efFromDateValue : TDateTime;
    efFromTimeCheck : Boolean;
    efFromTimeValue : TDateTime;
    efToDateCheck   : Boolean;
    efToDateValue   : TDateTime;
    efToTimeCheck   : Boolean;
    efToTimeValue   : TDateTime;
  end;
function GetEventFilter: TEventFilter;
procedure SetEventFilter(value: TEventFilter);
function GetEventFilterSQL: String;

type
  TForm6Recalc = record
    f6rCols, f6rRows: Boolean;
  end;
function GetForm6Recalc: TForm6Recalc;
procedure SetForm6Recalc(ACols, ARows: Boolean);
function GetForm6Year: Integer;
procedure SetForm6Year(Value: Integer);

function GetFltrNeWnd: Boolean;
procedure SetFltrNeWnd(Value: Boolean);


implementation

uses Forms, SysUtils, Registry, Windows, Classes, StrUtils, IniFiles, SHFolder;

const __IniName: string = 'settings.ini';

function GetAppDataFolder: string;
var
  P: PChar;
begin
  P := nil;
  try
    P := AllocMem(MAX_PATH);
    if SHGetFolderPath(0, CSIDL_APPDATA {CSIDL_LOCAL_APPDATA}, 0, 0, P) = S_OK then
      Result := P + '\GranVUS\Reports'
    else
      Result := ExtractFilePath(Application.ExeName)+'Reports';
  finally
    FreeMem(P);
  end;
  ForceDirectories(Result);
end;

function LoadConnAttr(adoConn: TADOConnection): boolean;
begin
  Result := false;
  if adoConn.Connected then adoConn.Connected := False;

  with TRegistryIniFile.Create(_IniName) do begin
    adoConn.ConnectionString := ReadString('CONNECTION','CONNECTION_STRING',EmptyStr);
    //if Pos(WideString('Provider=Microsoft.Jet'), adoConn.ConnectionString) > 0 then
      Result := true;
    adoConn.LoginPrompt := ReadBool('CONNECTION','CONNECTION_PROMPT',false);
    adoConn.ConnectionTimeout := ReadInteger('CONNECTION','CONNECTION_TIMEOUT',150);
    adoConn.CommandTimeout := ReadInteger('CONNECTION','COMMAND_TIMEOUT',300);
    try
      adoConn.Properties['Jet OLEDB:Database Password'].Value := ReverseString('9011ets18q54');
    except
      {}
    end;
    Free;
  end;
end;

procedure StoreConnAttr(adoConn: TADOConnection);
begin
  if adoConn.Connected then adoConn.Connected := false;

  with TRegistryIniFile.Create(_IniName) do begin
    try
      adoConn.Properties['Jet OLEDB:Database Password'].Value := '';
    except
      {}
    end;
    WriteString('CONNECTION','CONNECTION_STRING',adoConn.ConnectionString);
    WriteBool('CONNECTION','CONNECTION_PROMPT',adoConn.LoginPrompt);
    WriteInteger('CONNECTION','CONNECTION_TIMEOUT',adoConn.ConnectionTimeout);
    WriteInteger('CONNECTION','COMMAND_TIMEOUT',adoConn.CommandTimeout);
    Free;
  end;
end;

function GetPlugInsDir: string;
begin
  with TRegistryIniFile.Create(_IniName) do begin
    Result :=
      ReadString('PATHS','PLUGINS','');
    Free;
  end;
  if Result = '' then
    with TIniFile.Create(ExtractFilePath(Application.ExeName)+__IniName) do begin
      Result :=
        ReadString('PATHS','PLUGINS',ExtractFilePath(Application.ExeName)+'PlugIns');
      Free;
    end;
  Result := IncludeTrailingPathDelimiter(Result);
end;

procedure SetPlugInsDir(value: string);
begin
  with TRegistryIniFile.Create(_IniName) do begin
    WriteString('PATHS','PLUGINS',value);
    Free;
  end;
end;

function GetTemplatesDir: string;
begin
  with TRegistryIniFile.Create(_IniName) do begin
    Result := 
      ReadString('PATHS','TEMPLATES','');
    Free;
  end;
  if Result = '' then
    with TIniFile.Create(ExtractFilePath(Application.ExeName)+__IniName) do begin
      Result :=
        ReadString('PATHS','TEMPLATES',ExtractFilePath(Application.ExeName)+'Templates');
      Free;
    end;
  Result := IncludeTrailingPathDelimiter(Result);
end;

procedure SetTemplatesDir(value: string);
begin
  with TRegistryIniFile.Create(_IniName) do begin
    WriteString('PATHS','TEMPLATES',value);
    Free;
  end;
end;

function GetReportsDir: string;
begin
  with TRegistryIniFile.Create(_IniName) do begin
    Result :=
      ReadString('PATHS','REPORTS','');
    Free;
  end;
  if Result = '' then
    with TIniFile.Create(ExtractFilePath(Application.ExeName)+__IniName) do begin
      Result :=
        ReadString('PATHS','REPORTS',GetAppDataFolder);
      Free;
    end;
  Result := IncludeTrailingPathDelimiter(Result);
end;

procedure SetReportsDir(value: string);
begin
  with TRegistryIniFile.Create(_IniName) do begin
    WriteString('PATHS','REPORTS',value);
    Free;
  end;
end;

function GetTimeOut: Integer;
begin
  with TRegistryIniFile.Create(_IniName) do begin
    Result := ReadInteger('COMMON','TIME_OUT',0);
    Free;
  end;
end;

procedure SetTimeOut(value: Integer);
begin
  with TRegistryIniFile.Create(_IniName) do begin
    WriteInteger('COMMON','TIME_OUT',value);
    Free;
  end;
end;

function GetBackUpDir: string;
begin
  with TRegistryIniFile.Create(_IniName) do begin
    Result := 
      ReadString('PATHS','BACKUPS','');
    Free;
  end;
  if Result = '' then
    with TIniFile.Create(ExtractFilePath(Application.ExeName)+__IniName) do begin
      Result :=
        ReadString('PATHS','BACKUPS',ExtractFilePath(Application.ExeName)+'BackUp');
      Free;
    end;
  Result := IncludeTrailingPathDelimiter(Result);
end;

procedure SetBackUpDir(value: string);
begin
  with TRegistryIniFile.Create(_IniName) do begin
    WriteString('PATHS','BACKUPS',value);
    Free;
  end;
end;

function GetExtMenu: Boolean;
begin
  with TRegistryIniFile.Create(_IniName) do begin
    Result := ReadBool('COMMON','EXT_MENU',true);
    Free;
  end;
end;

procedure SetExtMenu(value: Boolean);
begin
  with TRegistryIniFile.Create(_IniName) do begin
    WriteBool('COMMON','EXT_MENU',value);
    Free;
  end;
end;

function GetLastLogin: String;
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    Result := ReadString('COMMON','LAST_LOGIN','ADMIN');
  finally  Free;
  end;
end;

procedure SetLastLogin(value: String);
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    WriteString('COMMON','LAST_LOGIN',value);
  finally  Free;
  end;
end;

function GetEventFilter: TEventFilter;
begin
  with TRegistryIniFile.Create(_IniName), Result do
  try
    efWho           := ReadInteger('EventFilter','Who'          , 0);
    efNotEvents     := ReadString ('EventFilter','NotEvents'    , '');
    efNotObjects    := ReadString ('EventFilter','NotObjects'   , '');
    efFromDateCheck := ReadBool   ('EventFilter','FromDateCheck', False);
    efFromDateValue := ReadDate   ('EventFilter','FromDateValue', Date);
    efFromTimeCheck := ReadBool   ('EventFilter','FromTimeCheck', False);
    efFromTimeValue := ReadTime   ('EventFilter','FromTimeValue', Time);
    efToDateCheck   := ReadBool   ('EventFilter','ToDateCheck'  , False);
    efToDateValue   := ReadDate   ('EventFilter','ToDateValue'  , Date);
    efToTimeCheck   := ReadBool   ('EventFilter','ToTimeCheck'  , False);
    efToTimeValue   := ReadTime   ('EventFilter','ToTimeValue'  , Time);
  finally  Free;
  end;
end;

procedure SetEventFilter(value: TEventFilter);
begin
  with TRegistryIniFile.Create(_IniName), value do
  try
    WriteInteger('EventFilter','Who'          ,efWho);
    WriteString ('EventFilter','NotEvents'    ,efNotEvents);
    WriteString ('EventFilter','NotObjects'   ,efNotObjects);
    WriteBool   ('EventFilter','FromDateCheck',efFromDateCheck);
    WriteDate   ('EventFilter','FromDateValue',efFromDateValue);
    WriteBool   ('EventFilter','FromTimeCheck',efFromTimeCheck);
    WriteTime   ('EventFilter','FromTimeValue',efFromTimeValue);
    WriteBool   ('EventFilter','ToDateCheck'  ,efToDateCheck);
    WriteDate   ('EventFilter','ToDateValue'  ,efToDateValue);
    WriteBool   ('EventFilter','ToTimeCheck'  ,efToTimeCheck);
    WriteTime   ('EventFilter','ToTimeValue'  ,efToTimeValue);
  finally  Free;
  end;
end;

function GetEventFilterSQL: String;
//
  function DateTime2SQL(dt: TDateTime): string;
  begin
    Result := '#'+FormatDateTime('mm"/"dd"/"yyyy hh:nn',dt)+'#';
  end;
//
var
  dt : TDateTime;
  I  : Integer;
begin
  Result := '';
  with GetEventFilter do begin
    if efWho>0 then Result := Result + ' AND [Who]='+IntToStr(efWho);
    if efFromDateCheck then begin
      dt := efFromDateValue;
      if efFromTimeCheck then dt := dt+efFromTimeValue;
      Result := Result + ' AND [When]>='+DateTime2SQL(dt);
    end;
    if efToDateCheck then begin
      dt := efToDateValue;
      if efToTimeCheck then dt := dt+efToTimeValue;
      Result := Result + ' AND [When]<='+DateTime2SQL(dt);
    end;
    with TStringList.Create do
    try
      Text := efNotEvents;
      for I := 0 to Count-1 do Result := Result +
        ' AND [Type]<>'+QuotedStr(Strings[I]);
      Text := efNotObjects;
      for I := 0 to Count-1 do Result := Result +
        ' AND [Object]<>'+QuotedStr(Strings[I]);
    finally Free;
    end;
  end;
end;

function GetForm6Recalc: TForm6Recalc;
begin
  with TRegistryIniFile.Create(_IniName), Result do
  try
    f6rCols := ReadBool('FORM6','RECALC_COLS',false);
    f6rRows := ReadBool('FORM6','RECALC_ROWS',true);
  finally Free;
  end;
end;

procedure SetForm6Recalc(ACols, ARows: Boolean);
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    WriteBool('FORM6','RECALC_COLS',ACols);
    WriteBool('FORM6','RECALC_ROWS',ARows);
  finally Free;
  end;
end;

function GetForm6Year: Integer;
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    Result := ReadInteger('FORM6','Year',CurrentYear);
  finally Free;
  end;
end;

procedure SetForm6Year(Value: Integer);
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    WriteInteger('FORM6','Year', Value);
  finally Free;
  end;
end;

function GetFltrNeWnd: Boolean;
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    Result := ReadBool('Filter','NewWindow',false);
  finally Free;
  end;
end;

procedure SetFltrNeWnd(Value: Boolean);
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    WriteBool('Filter','NewWindow', Value);
  finally Free;
  end;
end;


initialization
//  _IniName := ExtractFilePath(Application.ExeName)+__IniName;
  _IniName := 'Software\Granit\GranVus\Settings';
end.



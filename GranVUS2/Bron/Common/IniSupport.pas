unit IniSupport;

interface

uses ADOdb;

var   _IniName: string;

procedure LoadConnAttr(adoConn: TADOConnection);
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

function GetOrgFilter: Boolean;
procedure SetOrgFilter(value: Boolean);

function GetLastExport: TDateTime;
procedure SetLastExport(value: TDateTime);
function GetExpAgg: Boolean;
procedure SetExpAgg(value: Boolean);
function GetExpBron: Boolean;
procedure SetExpBron(value: Boolean);

function GetLastLogin: string;
procedure SetLastLogin(value: string);

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

function GetSubjCode: string;
procedure SetSubjCode(value: string);

function GetBackUpPeriod: Integer;

type
  TForm6Recalc = record
    f6rCols, f6rRows: Boolean;
  end;
function GetForm6Recalc: TForm6Recalc;
procedure SetForm6Recalc(ACols, ARows: Boolean);

function GetForm6FastMode: Boolean;
procedure SetForm6FastMode(Value: Boolean);

function GetReportDate: TDateTime;
procedure SetReportDate(Value: TDateTime);

function GetFltrNeWnd: Boolean;
procedure SetFltrNeWnd(Value: Boolean);

function GetAfterNY: Boolean;
procedure SetAfterNY(Value: Boolean);
function GetVUOAfterNY: Boolean;
procedure SetVUOAfterNY(Value: Boolean);
function GetMainVUOAfterNY: Boolean;
procedure SetMainVUOAfterNY(Value: Boolean);
function Get6in18: Boolean;
procedure Set6in18(Value: Boolean);

implementation

uses Forms, SysUtils, IniFiles, Windows, Registry, Classes, SHFolder;

const __IniName: string = 'settings.ini';

function GetAppDataFolder: string;
var
  P: PChar;
begin
  P := nil;
  try
    P := AllocMem(MAX_PATH);
    if SHGetFolderPath(0, CSIDL_APPDATA {CSIDL_LOCAL_APPDATA}, 0, 0, P) = S_OK then
      Result := P + '\GranVUS2\Reports'
    else
      Result := ExtractFilePath(Application.ExeName)+'Reports';
  finally
    FreeMem(P);
  end;
  ForceDirectories(Result);
end;

procedure LoadConnAttr(adoConn: TADOConnection);
begin
  if adoConn.Connected then adoConn.Connected := false;
  with TIniFile.Create(_IniName) do begin
    adoConn.ConnectionString := ReadString('CONNECTION','CONNECTION_STRING',EmptyStr);
    adoConn.LoginPrompt := ReadBool('CONNECTION','CONNECTION_PROMPT',false);
    adoConn.ConnectionTimeout := ReadInteger('CONNECTION','CONNECTION_TIMEOUT',150);
    adoConn.CommandTimeout := ReadInteger('CONNECTION','COMMAND_TIMEOUT',300);
    Free;
  end;
end;

procedure StoreConnAttr(adoConn: TADOConnection);
begin
  if adoConn.Connected then adoConn.Connected := false;
  with TIniFile.Create(_IniName) do begin
    WriteString('CONNECTION','CONNECTION_STRING',adoConn.ConnectionString);
    WriteBool('CONNECTION','CONNECTION_PROMPT',adoConn.LoginPrompt);
    WriteInteger('CONNECTION','CONNECTION_TIMEOUT',adoConn.ConnectionTimeout);
    WriteInteger('CONNECTION','COMMAND_TIMEOUT',adoConn.CommandTimeout);
    Free;
  end;
end;

function GetPlugInsDir: string;
begin
  with TIniFile.Create(_IniName) do begin
    Result := IncludeTrailingPathDelimiter(
      ReadString('PATHS','PLUGINS',ExtractFilePath(Application.ExeName)+'PlugIns'));
    Free;
  end;
end;

procedure SetPlugInsDir(value: string);
begin
  with TIniFile.Create(_IniName) do begin
    WriteString('PATHS','PLUGINS',value);
    Free;
  end;
end;

function GetTemplatesDir: string;
begin
  with TIniFile.Create(_IniName) do begin
    Result := IncludeTrailingPathDelimiter(
      ReadString('PATHS','TEMPLATES',ExtractFilePath(Application.ExeName)+'Templates'));
    Free;
  end;
end;

procedure SetTemplatesDir(value: string);
begin
  with TIniFile.Create(_IniName) do begin
    WriteString('PATHS','TEMPLATES',value);
    Free;
  end;
end;

function GetReportsDir: string;
begin
  with TIniFile.Create(_IniName) do begin
    Result := IncludeTrailingPathDelimiter(
      ReadString('PATHS','REPORTS',GetAppDataFolder));
    Free;
  end;
end;

procedure SetReportsDir(value: string);
begin
  with TIniFile.Create(_IniName) do begin
    WriteString('PATHS','REPORTS',value);
    Free;
  end;
end;

function GetTimeOut: Integer;
begin
  with TIniFile.Create(_IniName) do begin
    Result := ReadInteger('COMMON','TIME_OUT',0);
    Free;
  end;
end;

procedure SetTimeOut(value: Integer);
begin
  with TIniFile.Create(_IniName) do begin
    WriteInteger('COMMON','TIME_OUT',value);
    Free;
  end;
end;

function GetOrgFilter: Boolean;
begin
  with TIniFile.Create(_IniName) do begin
    Result := ReadBool('COMMON','ORG_FILTER',False);
    Free;
  end;
end;

procedure SetOrgFilter(value: Boolean);
begin
  with TIniFile.Create(_IniName) do begin
    WriteBool('COMMON','ORG_FILTER',value);
    Free;
  end;
end;

function GetLastExport: TDateTime;
begin
  with TIniFile.Create(_IniName) do begin
    Result := ReadDate('EXPORT','LAST_DATE',0);
    Free;
  end;
end;

procedure SetLastExport(value: TDateTime);
begin
  with TIniFile.Create(_IniName) do begin
    WriteDate('EXPORT','LAST_DATE',value);
    Free;
  end;
end;

function GetExpAgg: Boolean;
begin
  with TIniFile.Create(_IniName) do begin
    Result := ReadBool('EXPORT','EXP_AGG',True);
    Free;
  end;
end;

procedure SetExpAgg(value: Boolean);
begin
  with TIniFile.Create(_IniName) do begin
    WriteBool('EXPORT','EXP_AGG',value);
    Free;
  end;
end;

function GetExpBron: Boolean;
begin
  with TIniFile.Create(_IniName) do begin
    Result := ReadBool('EXPORT','EXP_BRON',False);
    Free;
  end;
end;

procedure SetExpBron(value: Boolean);
begin
  with TIniFile.Create(_IniName) do begin
    WriteBool('EXPORT','EXP_BRON',value);
    Free;
  end;
end;

function GetLastLogin: string;
begin
  with TIniFile.Create(_IniName) do begin
    Result := ReadString('COMMON','LAST_LOGIN','Админ');
    Free;
  end;
end;

procedure SetLastLogin(value: string);
begin
  with TIniFile.Create(_IniName) do begin
    WriteString('COMMON','LAST_LOGIN',value);
    Free;
  end;
end;

function GetBackUpDir: string;
begin
  with TIniFile.Create(_IniName) do begin
    Result := IncludeTrailingPathDelimiter(
      ReadString('PATHS','BACKUPS',ExtractFilePath(Application.ExeName)+'BackUp'));
    Free;
  end;
end;

procedure SetBackUpDir(value: string);
begin
  with TIniFile.Create(_IniName) do begin
    WriteString('PATHS','BACKUPS',value);
    Free;
  end;
end;

function GetBackUpPeriod: Integer;
begin
  with TIniFile.Create(_IniName) do begin
    Result := ReadInteger('BACKUP','PERIOD',7);
    Free;
  end;
end;

function GetEventFilter: TEventFilter;
begin
  with TRegistryIniFile.Create('Software\Granit\GranVus2'), Result do
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
  with TRegistryIniFile.Create('Software\Granit\GranVus2'), value do
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
    Result := 'CONVERT(DateTime,'''+FormatDateTime('dd.mm.yyyy hh:nn',dt)+''',104)';
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

function GetSubjCode: string;
begin
  with TIniFile.Create(_IniName) do begin
    Result := Copy(ReadString('COMMON','SUBJ_CODE',EmptyStr),1,9);
    Free;
  end;
end;

procedure SetSubjCode(value: string);
begin
  with TIniFile.Create(_IniName) do begin
    WriteString('COMMON','SUBJ_CODE',value);
    Free;
  end;
end;

function GetForm6Recalc: TForm6Recalc;
begin
  with TIniFile.Create(_IniName), Result do
  try
    f6rCols := ReadBool('FORM6','RECALC_COLS',false);
    f6rRows := ReadBool('FORM6','RECALC_ROWS',true);
  finally Free;
  end;
end;

procedure SetForm6Recalc(ACols, ARows: Boolean);
begin
  with TIniFile.Create(_IniName) do
  try
    WriteBool('FORM6','RECALC_COLS',ACols);
    WriteBool('FORM6','RECALC_ROWS',ARows);
  finally Free;
  end;
end;

function GetForm6FastMode: Boolean;
begin
  with TIniFile.Create(_IniName) do
  try     Result := ReadBool('FORM6', 'FastMode', False);
  finally Free;
  end;
end;

procedure SetForm6FastMode(Value: Boolean);
begin
  with TIniFile.Create(_IniName) do
  try     WriteBool('FORM6', 'FastMode', Value);
  finally Free;
  end;
end;


function GetReportDate: TDateTime;
begin
  with TIniFile.Create(_IniName) do
  try     Result := ReadDate('COMMON', 'ReportDate', Date);
  finally Free;
  end;
end;

procedure SetReportDate(Value: TDateTime);
begin
  with TIniFile.Create(_IniName) do
  try     WriteDate('COMMON', 'ReportDate', Value);
  finally Free;
  end;
end;

function GetFltrNeWnd: Boolean;
begin
  with TIniFile.Create(_IniName) do
  try
    Result := ReadBool('Filter','NewWindow',false);
  finally Free;
  end;
end;

procedure SetFltrNeWnd(Value: Boolean);
begin
  with TIniFile.Create(_IniName) do
  try
    WriteBool('Filter','NewWindow', Value);
  finally Free;
  end;
end;


function GetAfterNY: Boolean;
begin
  with TIniFile.Create(_IniName) do
  try
    Result := ReadBool('COMMON','AfterNY',false);
  finally Free;
  end;
end;

procedure SetAfterNY(Value: Boolean);
begin
  with TIniFile.Create(_IniName) do
  try
    WriteBool('COMMON','AfterNY', Value);
  finally Free;
  end;
end;

function GetVUOAfterNY: Boolean;
begin
  with TIniFile.Create(_IniName) do
  try
    Result := ReadBool('COMMON','VUOAfterNY',false);
  finally Free;
  end;
end;

procedure SetVUOAfterNY(Value: Boolean);
begin
  with TIniFile.Create(_IniName) do
  try
    WriteBool('COMMON','VUOAfterNY', Value);
  finally Free;
  end;
end;

function GetMainVUOAfterNY: Boolean;
begin
  with TIniFile.Create(_IniName) do
  try
    Result := ReadBool('COMMON','MainVUOAfterNY',false);
  finally Free;
  end;
end;

function Get6in18: Boolean;
begin
  with TIniFile.Create(_IniName) do
  try
    Result := ReadBool('COMMON','F6in18',false);
  finally Free;
  end;
end;

procedure Set6in18(Value: Boolean);
begin
  with TIniFile.Create(_IniName) do
  try
    WriteBool('COMMON','F6in18', Value);
  finally Free;
  end;
end;

procedure SetMainVUOAfterNY(Value: Boolean);
begin
  with TIniFile.Create(_IniName) do
  try
    WriteBool('COMMON','MainVUOAfterNY', Value);
  finally Free;
  end;
end;

initialization
  _IniName := ExtractFilePath(Application.ExeName)+__IniName;
end.



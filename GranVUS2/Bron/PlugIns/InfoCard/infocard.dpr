library infocard;



uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  msg in '..\..\Common\msg.pas',
  IniSupport in '..\..\Common\IniSupport.pas',
  SaveEvents in '..\..\Common\SaveEvents.pas',
  rdialogs in '..\..\Common\rdialogs.pas';

{$R ResData.RES}
  
function PlugInInfo(
  szName: PChar;
  szAuthor: PChar): Integer; stdcall;
// szName - заполняется наименованием плагина
// szAuthor - копирайт плагина
// ReturnValue - тип плагина
//    0 - общее назначение
//        function PlugInExec(AppHandle: THandle; szConn: _Connection): Integer; stdcall;
//    1 - для работы с карточкой организации
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nOrgID: Integer): Integer; stdcall;
//    2 - для работы с карточкой сотрудника
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nManID: Integer): Integer; stdcall;

begin
  Result := 5;
  StrCopy(szName, sEventObject);
  StrCopy(szAuthor,'(с) 2004, ГУП г.Москвы "ГНПП "Гранит-Центр"');
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection; nSubjID: Integer): Integer; stdcall;
//  szConn - строка подключения к БД
var old_conn: _Connection;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TdmMain, dmMain);
  old_conn := dmMain.dbMain.ConnectionObject;
  dmMain.dbMain.ConnectionObject := Conn;
  dmMain.InitData(nSubjID);
  if not dmMain.PrintData
    then Result := -2
    else Result := 0;
  dmMain.dbMain.ConnectionObject := old_conn;
  dmMain.Free;
  Application.Handle := 0;
end;

procedure PlugInUnicode;
begin
  // Просто заглушка - если эта процедура есть, то ДЛЛ-ка хорошая
end;

exports
  PlugInInfo, PlugInExec, PlugInUnicode;

begin
end.

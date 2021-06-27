library Analiz;



uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  Dialogs,
  dxDBGrid,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  Msg,
  SaveEvents,
  IniSupport;

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
//    3 - для работы с формой 6
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nF6ID: Integer): Integer; stdcall;

begin
  Result := 5;
  StrCopy(szName,'Анализ обеспеченности трудовыми ресурсами');
  StrCopy(szAuthor,'(с) 2012 ОАО "НПП "Гранит-Центр"');
end;

function Execute(
  AppHandle: THandle;
  Conn: _Connection;
  nSubjID: Integer): Integer;
//  szConn - строка подключения к БД
//  nOrgID - код организации
var
  OldConn : _Connection;
  rEdit   : Boolean;
  HasBron : Boolean;
begin
  Result := 0;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  try
      OldConn:= dmMain.dbMain.ConnectionObject;
      dmMain.dbMain.ConnectionObject := Conn;
      try
        dmMain.dbMain.Connected := true;
        dmMain.SUBJ_ID := nSubjID;
        dmMain.Init;
      except
        MessageBox(Application.Handle,
          'Ошибка при обращении к базе данных!',
          'Анализ обеспеченности трудовыми ресурсами',MB_OK or MB_ICONERROR);
        Result := -1;
      end;
      if Result=0 then
      try
        dmMain.SUBJ_ID := nSubjID;
        dmMain.PrintActionExecute(dmMain);
      except
        MessageBox(Application.Handle,
          'Ошибка при создании формы!', sEventObject,
          MB_OK or MB_ICONERROR);
        Result := -2;
      end;
    finally
      dmMain.dbMain.ConnectionObject:= OldConn;
      dmMain.Free;
    end;
  finally Application.Handle := 0;
  end;
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nSubjID: Integer): Integer; stdcall;
begin
  Result := Execute(AppHandle, Conn, nSubjID);
end;


procedure PlugInUnicode;
begin
  // Просто заглушка - если эта процедура есть, то ДЛЛ-ка хорошая
end;

exports
  PlugInInfo, PlugInExec, PlugInUnicode;

begin
end.




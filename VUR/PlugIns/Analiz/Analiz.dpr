library Analiz;



uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  Dialogs,
  dxDBGrid,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  Msg in '..\..\Common\Msg.pas',
  SaveEvents,
  IniSupport in '..\..\Common\IniSupport.pas',
  BirthDay in '..\..\Common\BirthDay.pas';

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
  Result := 3;
  StrCopy(szName,'Форма № 19');
  StrCopy(szAuthor,'(с) 2012, ГУП г.Москвы "ГНПП "Гранит-Центр"');
end;

function Execute(
  AppHandle: THandle;
  Conn: _Connection;
  nF6ID: Integer): Integer;
//  szConn - строка подключения к БД
//  nOrgID - код организации
var
  OldConn : _Connection;
  rEdit   : Boolean;
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
        dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);
        dmMain.F6_ID:= nF6ID;
        dmMain.Init;
      except
        SaveEvent(dmMain.dbMain,
          evs_Report_Error,
          sEventObject,
          ['Ошибка при обращении к базе данных.']);
        MessageBox(Application.Handle,
          'Ошибка при обращении к базе данных!',
          'Анализ обеспеченности трудовыми ресурсами',MB_OK or MB_ICONERROR);
        Result := -1;
      end;
      if Result=0 then
      try
        dmMain.PrintActionExecute(dmMain);
      except
        SaveEvent(dmMain.dbMain,
          evs_Report_Error,
          sEventObject,
          ['Ошибка при создании.']);
        MessageBox(Application.Handle,
          'Ошибка при создании формы!',
          'Форма № 19',MB_OK or MB_ICONERROR);
        Result := -2;
      end;
    finally
      if Assigned(dmMain) then dmMain.dbMain.ConnectionObject:= OldConn;
      dmMain.Free;
    end;
  finally Application.Handle := 0;
  end;
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nF6ID: Integer): Integer; stdcall;
begin
  Result := Execute(AppHandle, Conn, nF6ID);
end;

exports
  PlugInInfo, PlugInExec;

begin
end.


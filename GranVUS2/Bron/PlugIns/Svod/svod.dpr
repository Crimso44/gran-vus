library svod;




uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  SaveEvents,
  IniSupport;

{$R ResData.res}

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
  Result := 0;
  StrCopy(szName, sEventObject);
  StrCopy(szAuthor,'(с) 2004, ГУП г.Москвы "ГНПП "Гранит-Центр"');
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nOrgID: Integer): Integer; stdcall;
//  szConn - строка подключения к БД
//  nOrgID - код организации
var old_conn: _Connection;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TdmMain, dmMain);
  old_conn := dmMain.dbMain.ConnectionObject;
  dmMain.dbMain.ConnectionObject := Conn;
  if not dmMain.OpenData(nOrgID) then begin
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при обращении к базе данных.']);
    MessageBox(Application.Handle,
      'Ошибка при обращении к базе данных!',
      'Сводные показатели ВУО',MB_OK or MB_ICONERROR);
    Result := -1;
  end
  else
    if not dmMain.PrintData then begin
      Result := -2;
      SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
        ['Ошибка при создании отчета.']);
      MessageBox(Application.Handle,
        'Ошибка при создании отчета!'+#13+
        'Возможно неверно указаны рабочие папки, '+#13+
        'шаблон отчета используется другой программой '+#13+
        'или файл-отчет уже открыт другой программой...',
        'Печать сводных показателей ВУО',MB_OK or MB_ICONERROR);
    end
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

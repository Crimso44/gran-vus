library PrnOrg;



uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  Dialogs,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  SaveEvents in '..\..\Common\SaveEvents.pas';

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
  Result := 1;
  StrCopy(szName,'Печать карточки организации');
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
  Result := 0;
  try
    old_conn := dmMain.dbMain.ConnectionObject;
    dmMain.dbMain.ConnectionObject := Conn;
    dmMain.dbMain.Connected := true;
    dmMain.qrOrgData.Parameters.ParamByName('ID').Value := nOrgID;
    dmMain.qrOrgData.Open;
    dmMain.qrOrgPaym.Parameters.ParamByName('ID').Value := nOrgID;
    dmMain.qrOrgPaym.Open;
    dmMain.qrOrgCont.Parameters.ParamByName('ID').Value := nOrgID;
    dmMain.qrOrgCont.Open;
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при обращении к базе данных.']);
    MessageBox(Application.Handle,
      'Ошибка при обращении к базе данных!',
      'Печать карточки организации',MB_OK or MB_ICONERROR);
    Result := -1;
  end;
  if Result=0 then
  try
    dmMain.EkRTF1.ExecuteOpen(
      [dmMain.qrOrgData,dmMain.qrOrgPaym,dmMain.qrOrgCont],SW_SHOWDEFAULT);
    SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(nOrgID)]);
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    MessageBox(Application.Handle,
      'Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...',
      'Печать карточки организации',MB_OK or MB_ICONERROR);
    Result := -2;
  end;
  dmMain.dbMain.ConnectionObject := old_conn;
  dmMain.Free;
  Application.Handle := 0;
end;

exports
  PlugInInfo, PlugInExec;

begin
end.

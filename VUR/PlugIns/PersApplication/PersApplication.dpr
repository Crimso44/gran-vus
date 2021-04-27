library PersApplication;


uses
  Forms,
  Controls,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  fParamDlg in 'fParamDlg.pas' {fmParamDlg},
  msg,
  SaveEvents,
  IniSupport,
  BirthDay in '..\..\Common\BirthDay.pas';

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
  {$I ..\SZ.INC}
  Result := 2;
  StrCopy(szName,'Заявление о постановке на воинский учет');
  StrCopy(szAuthor,'(с) 2021, ГУП г.Москвы "ГНПП "Гранит-Центр"');
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nPersID: Integer): Integer; stdcall;
//  szConn - строка подключения к БД
//  nOrgID - код организации
var old_conn: _Connection;
Reason: string;
begin
  Result := 0;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
    old_conn := dmMain.dbMain.ConnectionObject;
    try
      dmMain.dbMain.ConnectionObject := Conn;
      dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);

      with    TfmParamDlg.Create(Application) do
      try
         if ShowModal<>mrOk then Exit;
         Reason := eReason.Text;
      finally Free;
      end;

      if not dmMain.OpenData(nPersID, Reason) then begin
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['Ошибка при обращении к базе данных.']);
        MessageBox(Application.Handle,
          'Ошибка при обращении к базе данных!',
          'Заявление о постановке на воинский учет',MB_OK or MB_ICONERROR);
        Result := -1;
      end else
      if not dmMain.PrintData then begin
        Result := -2;
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['Ошибка при создании отчета.']);
        MessageBox(Application.Handle,
          'Ошибка при создании отчета!'+#13+
          'Возможно неверно указаны рабочие папки, '+#13+
          'шаблон отчета используется другой программой '+#13+
          'или файл-отчет уже открыт другой программой...',
          'Заявление о постановке на воинский учет',MB_OK or MB_ICONERROR);
      end;
    finally
      if Assigned(dmMain) then dmMain.dbMain.ConnectionObject := old_conn;
      dmMain.Free;
    end;
  finally Application.Handle := 0;
  end;
end;

exports
  PlugInInfo, PlugInExec;

begin
end.

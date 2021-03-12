unit SaveEvents;
// The saving of event into EVENT and EVENTDETAIL tables.
// Pavel Alhymov
interface
uses SysUtils, ADODB;

const
  evs_Login_Ok               = 'Вход в систему.';
  evs_Login_Failed           = 'Неудачная попытка входа в систему.';
  evs_Logout                 = 'Выход из системы.';

  evs_Report_Print           = 'Печать отчёта.';
  evs_Report_Error           = 'Ошибка отчёта.';

  evs_Form6_Error            = 'Ошибка расчётной численности (2014г).';
  evs_Form6_Generate         = 'Генерация расчётной численности (2014г).';
  evs_Form6_Check_Ok         = 'Проверка расчётной численности - успешно (2014г).';
  evs_Form6_Check_Failed     = 'Проверка расчётной численности - ошибка (2014г).';

  evs_Form6_2015_Error       = 'Ошибка расчётной численности.';
  evs_Form6_2015_Generate    = 'Генерация расчётной численности.';
  evs_Form6_2015_Check_Ok    = 'Проверка расчётной численности - успешно.';
  evs_Form6_2015_Check_Failed= 'Проверка расчётной численности - ошибка.';

  evs_Backup                 = 'Резервирование базы данных.';
  evs_Backup_Failed          = 'Ошибка резервирования базы данных.';
  evs_Restore                = 'Восстановление базы данных.';
  evs_Restore_Failed         = 'Ошибка восстановления базы данных.';

  evs_Export                 = 'Экспорт данных.';
  evs_Export_Failed          = 'Ошибка экспорта данных.';
  evs_Import                 = 'Импорт данных.';
  evs_Import_Failed          = 'Ошибка импорта данных.';

  evs_EventLog_Clear         = 'Очистка журнала событий.';
  evs_EventLog_Clear_Failed  = 'Ошибка очистки журнала событий.';

//  evs_Table_Update           = 'Редактирование записи в таблице.';
//  evs_Table_Append           = 'Добавление записи в таблице.';
//  evs_Table_Delete           = 'Удаление записи из таблицы.';

procedure SaveEvent(AConn: TADOConnection;
  AType, AObject: String;
  ADetail: array of String);

function GetLastUserID(AConn: TADOConnection): Integer;

implementation
uses Windows;

procedure SaveEvent;
var
  I, Event_ID: Integer;
begin
  if AObject='' then AObject := 'Система';
  try
    with TADOQuery.Create(nil) do
    try
      ParamCheck := False;
      Connection := AConn;
      SQL.Text := 'SELECT * FROM Event where Event_Id = 0';
      Open;
      Append;
      FieldByName('Type')   .AsString  := AType;
      FieldByName('Object') .AsString  := Copy(AObject, 1, 50);
      FieldByName('Who')    .AsInteger := Connection.Tag;
      Post;
      Event_ID := FieldByName('Event_id').AsInteger;
      Close;
      if Length(ADetail)>0 then begin
        SQL.Text := 'SELECT * FROM EventDetail where EventDetail_Id = 0';
        Open;
        for I := Low(ADetail) to high(ADetail) do begin
          Append;
          FieldByName('Event_id').AsInteger := Event_ID;
          FieldByName('Value')   .AsString  := ADetail[I];
          Post;
        end;
        Close;
      end;
    finally Free;
    end;
  except on e: Exception do begin
    {!!!}MessageBox(0,PChar('Невозможно записать событие: '+AType+#13+e.Message),'Журнал событий',mb_IconStop);
  end;
  end;
end;

function GetLastUserID;
begin
  try
    with TADOQuery.Create(nil) do
    try
      ParamCheck := False;
      Connection := AConn;
      SQL.Text := 'SELECT WHO FROM Event WHERE Event_ID=(SELECT MAX(Event_ID) FROM Event)';
      Open;
      Result := Fields[0].AsInteger;
    finally Free;
    end;
  except Result := 0;
  end;
end;

end.

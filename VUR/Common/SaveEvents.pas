unit SaveEvents;
// The saving of event into EVENT and EVENTDETAIL tables.
// Pavel Alhymov
interface
uses SysUtils, ADODB;

const
  evs_Login_Ok               = '���� � �������.';
  evs_Login_Failed           = '��������� ������� ����� � �������.';
  evs_Logout                 = '����� �� �������.';

  evs_Report_Print           = '������ ������.';
  evs_Report_Error           = '������ ������.';

  evs_Form6_Error            = '������ ��������� ����������� (2014�).';
  evs_Form6_Generate         = '��������� ��������� ����������� (2014�).';
  evs_Form6_Check_Ok         = '�������� ��������� ����������� - ������� (2014�).';
  evs_Form6_Check_Failed     = '�������� ��������� ����������� - ������ (2014�).';

  evs_Form6_2015_Error       = '������ ��������� �����������.';
  evs_Form6_2015_Generate    = '��������� ��������� �����������.';
  evs_Form6_2015_Check_Ok    = '�������� ��������� ����������� - �������.';
  evs_Form6_2015_Check_Failed= '�������� ��������� ����������� - ������.';

  evs_Backup                 = '�������������� ���� ������.';
  evs_Backup_Failed          = '������ �������������� ���� ������.';
  evs_Restore                = '�������������� ���� ������.';
  evs_Restore_Failed         = '������ �������������� ���� ������.';

  evs_Export                 = '������� ������.';
  evs_Export_Failed          = '������ �������� ������.';
  evs_Import                 = '������ ������.';
  evs_Import_Failed          = '������ ������� ������.';

  evs_EventLog_Clear         = '������� ������� �������.';
  evs_EventLog_Clear_Failed  = '������ ������� ������� �������.';

//  evs_Table_Update           = '�������������� ������ � �������.';
//  evs_Table_Append           = '���������� ������ � �������.';
//  evs_Table_Delete           = '�������� ������ �� �������.';

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
  if AObject='' then AObject := '�������';
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
    {!!!}MessageBox(0,PChar('���������� �������� �������: '+AType+#13+e.Message),'������ �������',mb_IconStop);
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

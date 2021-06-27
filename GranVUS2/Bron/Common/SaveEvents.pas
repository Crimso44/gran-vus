unit SaveEvents;
// The saving of event into EVENT and EVENTDETAIL tables.
// Pavel Alhymov
interface
uses ADODB;

const
  evs_Login_Ok               = '���� � �������.';
  evs_Login_Failed           = '��������� ������� ����� � �������.';
  evs_Logout                 = '����� �� �������.';

  evs_Report_Print           = '������ ������.';
  evs_Report_Error           = '������ ������.';

  evs_Form6_Error            = '������ ��������� �����������.';
  evs_Form6_Generate         = '��������� ��������� �����������.';
  evs_Form6_Check_Ok         = '�������� ��������� ����������� - �������.';
  evs_Form6_Check_Failed     = '�������� ��������� ����������� - ������.';

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

function GetLastUserID: Integer;

implementation
uses Windows, Registry;

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
      SQL.Text := 'SELECT * FROM Event';
      Open;
      Append;
      FieldByName('Type')   .AsString  := AType;
      FieldByName('Object') .AsString  := AObject;
      FieldByName('Who')    .AsInteger := GetLastUserID;
      Post;
      Event_ID := FieldByName('Event_id').AsInteger;
      Close;
      if Length(ADetail)>0 then begin
        SQL.Text := 'SELECT * FROM EventDetail';
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
  except
    MessageBox(0,PChar('���������� �������� �������: '+AType),'������ �������',mb_IconStop);
  end;
end;

function GetLastUserID;
begin
   with TRegistryIniFile.Create('Software\Granit\GranVus2') do
   try
     Result := ReadInteger('Login','UID',0);
   finally Free;
   end;
end;

end.

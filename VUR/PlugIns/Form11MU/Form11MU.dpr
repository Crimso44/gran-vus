library Form11MU;


uses
  Forms,
  Controls,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  msg,
  SaveEvents,
  IniSupport,
  BirthDay in '..\..\Common\BirthDay.pas';

{$R ResData.res}

function PlugInInfo(
  szName: PChar;
  szAuthor: PChar): Integer; stdcall;
// szName - ����������� ������������� �������
// szAuthor - �������� �������
// ReturnValue - ��� �������
//    0 - ����� ����������
//        function PlugInExec(AppHandle: THandle; szConn: _Connection): Integer; stdcall;
//    1 - ��� ������ � ��������� �����������
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nOrgID: Integer): Integer; stdcall;
//    2 - ��� ������ � ��������� ����������
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nManID: Integer): Integer; stdcall;

begin
  {$I SZ.INC}
  Result := 1;
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nOrgID: Integer): Integer; stdcall;
//  szConn - ������ ����������� � ��
//  nOrgID - ��� �����������
var old_conn: _Connection;
begin
  Result := 0;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  old_conn := dmMain.dbMain.ConnectionObject;
    try
      dmMain.dbMain.ConnectionObject := Conn;
      dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);

      Result := dmMain.OpenData(nOrgID);
      if Result = -1 then begin
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['������ ��� ��������� � ���� ������.']);
        MessageBox(Application.Handle,
          '������ ��� ��������� � ���� ������!',
          sEventObject,MB_OK or MB_ICONERROR);
        Result := -1;
      end else if Result = 0 then begin
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['� ����������� �� ������ ���!']);
        MessageBox(Application.Handle,
          '� ����������� �� ������ ���!',
          sEventObject,MB_OK or MB_ICONERROR);
        Result := -1;
      end else
      if not dmMain.PrintData then begin
        Result := -2;
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['������ ��� �������� ������.']);
        MessageBox(Application.Handle,
          '������ ��� �������� ������!'+#13+
          '�������� ������� ������� ������� �����, '+#13+
          '������ ������ ������������ ������ ���������� '+#13+
          '��� ����-����� ��� ������ ������ ����������...',
          sEventObject,MB_OK or MB_ICONERROR);
      end;
      Result := 0;
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

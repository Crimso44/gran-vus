library form18;




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
  Result := 1;
  StrCopy(szName,'����� � 18');
  StrCopy(szAuthor,'(�) 2004, ��� �.������ "���� "������-�����"');
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nOrgID: Integer): Integer; stdcall;
//  szConn - ������ ����������� � ��
//  nOrgID - ��� �����������
var old_conn: _Connection;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TdmMain, dmMain);
  old_conn := dmMain.dbMain.ConnectionObject;
  dmMain.dbMain.ConnectionObject := Conn;
  dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);
  if not dmMain.OpenData(nOrgID) then begin
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['������ ��� ��������� � ���� ������.']);
    MessageBox(Application.Handle,
      '������ ��� ��������� � ���� ������!',
      '������ ����� � 18',MB_OK or MB_ICONERROR);
    Result := -1;
  end
  else
    if not dmMain.PrintData then begin
      Result := -2;
      SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
        ['������ ��� �������� ������.']);
      MessageBox(Application.Handle,
        '������ ��� �������� ������!'+#13+
        '�������� ������� ������� ������� �����, '+#13+
        '������ ������ ������������ ������ ���������� '+#13+
        '��� ����-����� ��� ������ ������ ����������...',
        '������ ����� � 18',MB_OK or MB_ICONERROR);
    end
    else Result := 0;
  dmMain.dbMain.ConnectionObject := old_conn;
  dmMain.Free;
  Application.Handle := 0;
end;

exports
  PlugInInfo, PlugInExec;

begin
end.

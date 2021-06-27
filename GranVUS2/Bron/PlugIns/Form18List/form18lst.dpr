library form18lst;

uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  fFilDlg in 'fFilDlg.pas' {fmFilDlg},
  msg in '..\..\Common\msg.pas',
  Rdialogs in '..\..\Common\rdialogs.pas',
  SaveEvents in '..\..\Common\SaveEvents.pas',
  IniSupport in '..\..\Common\IniSupport.pas';

{$R ResData.RES}

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
  Result := 0;
  StrCopy(szName, sEventObject);
  StrCopy(szAuthor,'(�) 2004, ��� �.������ "���� "������-�����"');
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection): Integer; stdcall;
//  szConn - ������ ����������� � ��
var old_conn: _Connection;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TdmMain, dmMain);
  old_conn := dmMain.dbMain.ConnectionObject;
  dmMain.dbMain.ConnectionObject := Conn;
  Result:= 0;
  try
    Application.CreateForm(TfmFilDlg, fmFilDlg);
    fmFilDlg.ShowModal;
  except
    SaveEvent(dmMain.dbMain,
              evs_Report_Error,
              sEventObject,
              ['������ ��� �������� ����.']);
    MessageBox(Application.Handle,
               '������ ��� �������� ����!',
               sEventObject,
               MB_OK or MB_ICONERROR);
    Result := -2;
  end;
  dmMain.dbMain.ConnectionObject := old_conn;
  dmMain.Free;
  Application.Handle := 0;
end;

procedure PlugInUnicode;
begin
  // ������ �������� - ���� ��� ��������� ����, �� ���-�� �������
end;


exports
  PlugInInfo, PlugInExec, PlugInUnicode;

begin
end.

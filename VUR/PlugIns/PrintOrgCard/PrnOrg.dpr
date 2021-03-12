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
  StrCopy(szName,'������ �������� �����������');
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
      ['������ ��� ��������� � ���� ������.']);
    MessageBox(Application.Handle,
      '������ ��� ��������� � ���� ������!',
      '������ �������� �����������',MB_OK or MB_ICONERROR);
    Result := -1;
  end;
  if Result=0 then
  try
    dmMain.EkRTF1.ExecuteOpen(
      [dmMain.qrOrgData,dmMain.qrOrgPaym,dmMain.qrOrgCont],SW_SHOWDEFAULT);
    SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,
      ['����� �����������: '+IntToStr(nOrgID)]);
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['������ ��� �������� ������.']);
    MessageBox(Application.Handle,
      '������ ��� �������� ������!'+#13+
      '�������� ������� ������� ������� ����� '+#13+
      '��� ������ ������ ������������ ������ ����������...',
      '������ �������� �����������',MB_OK or MB_ICONERROR);
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

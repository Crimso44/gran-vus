library NotCard;

{$R ResData.res}

uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  SaveEvents,
  IniSupport;

function PlugInInfo(
  szName: PChar;
  szAuthor: PChar): Integer; stdcall;
begin
  Result := 2;
  StrCopy(szName,'�������� ����������');
  StrCopy(szAuthor,'(�) 2007, ��� �.������ "���� "������-�����"');
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nPersID: Integer): Integer; stdcall;
var old_conn: _Connection;
begin
  Application.Handle := AppHandle;
  Application.CreateForm(TdmMain, dmMain);
  old_conn := dmMain.dbMain.ConnectionObject;
  dmMain.dbMain.ConnectionObject := Conn;
  dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);
  if not dmMain.OpenData(nPersID) then begin
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['������ ��� ��������� � ���� ������.']);
    MessageBox(Application.Handle,
      '������ ��� ��������� � ���� ������!',
      '������ �������� ����������',MB_OK or MB_ICONERROR);
    Result := -1;
  end
  else
    if not dmMain.PrintData then begin
      Result := -2;
      SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
        ['������ ��� �������� ������.']);
      MessageBox(Application.Handle,
        '������ ��� �������� ������!'+#13+
        '�������� ������� ������� ������� ����� '+#13+
        '��� ������ ������ ������������ ������ ����������...',
        '������ �������� ����������',MB_OK or MB_ICONERROR);
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


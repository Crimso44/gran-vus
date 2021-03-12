library MobList;



uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  Controls,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  fParamDlg in 'fParamDlg.pas' {fmParamDlg},
  Rdialogs in '..\..\Common\rdialogs.pas',
  msg in '..\..\Common\msg.pas',
  SaveEvents in '..\..\Common\SaveEvents.pas',
  IniSupport in '..\..\Common\IniSupport.pas';

{$R resdata.res}

function PlugInInfo(
  szName: PChar;
  szAuthor: PChar): Integer; stdcall;
begin
  Result := 5;
  StrCopy(szName,'������ ���, ������� ��������������');
  StrCopy(szAuthor,'(�) 2007, ��� �.������ "���� "������-�����"');
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nOrgID: Integer;
  isConfirm: Boolean): Integer; stdcall;
var old_conn: _Connection;
    f: boolean;
begin
  Result := -1;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
    old_conn := dmMain.dbMain.ConnectionObject;
    try
      dmMain.dbMain.ConnectionObject := Conn;
      dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);

      with TADOQuery.Create(nil) do
      try
        Connection := dmMain.dbMain;
        ParamCheck := False;
        SQL.Text := 'SELECT Count(*) FROM PERS_SET';
        Open;
        if (Fields[0].AsInteger>0) then
          if isConfirm then
            if not Confirm(
              '   ��������! ����� ����� �������� �� ������������ '+
              '����������, ����� ���������� � ���������� ���� ��� ���������� �������.'#13#13+
              '   ��� �������� � ���������� ������� �� ���� ��������� � ���� ������ '+
              '� ��������� ���������� �������� ������� "�������� �����".'#13#13+
              '   ���������� ������ � ���������� ������� ����������?')
            then
              Exit;
      finally Free;
      end;

      with TfmParamDlg.Create(Application) do
      try
        f := ShowModal=mrOk;
      finally
        Free;
      end;
      Result := 0;
      if f then
        if not dmMain.OpenData(nOrgID) then begin
          SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
            ['������ ��� ��������� � ���� ������.']);
          MessageBox(Application.Handle,
            '������ ��� ��������� � ���� ������!',
            '������ ������ ���, ������� ��������������',MB_OK or MB_ICONERROR);
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
              '������ ������ ���, ������� ��������������',MB_OK or MB_ICONERROR);
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


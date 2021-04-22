library Form9;



uses
  Forms,
  Controls,
  SysUtils,
  Windows,
  ADOdb,
  Dialogs,
  dxDBGrid,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  Msg in '..\..\Common\Msg.pas',
  SaveEvents,
  IniSupport in '..\..\Common\IniSupport.pas',
  BirthDay in '..\..\Common\BirthDay.pas',
  fParamDlg in 'fParamDlg.pas' {fmParamDlg};

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
//    3 - ��� ������ � ������ 6
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nF6ID: Integer): Integer; stdcall;

begin
  Result := 0;
  StrCopy(szName,'��������� �� ������ ������������� (����� � 9)');
  StrCopy(szAuthor,'(�) 2012, ��� �.������ "���� "������-�����"');
end;


procedure PlugInSortInfo(szSortName: PChar); stdcall;
begin
  StrCopy(szSortName, 'Form09');
end;


function Execute(
  AppHandle: THandle;
  Conn: _Connection;
  nF6ID: Integer): Integer;
//  szConn - ������ ����������� � ��
//  nOrgID - ��� �����������
var
  OldConn : _Connection;
  rEdit   : Boolean;
begin
  Result := 0;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  try
      OldConn:= dmMain.dbMain.ConnectionObject;
      dmMain.dbMain.ConnectionObject := Conn;
      try
        dmMain.dbMain.Connected := true;
        dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);

      with    TfmParamDlg.Create(Application) do
      try     if ShowModal<>mrOk then Exit;
      finally Free;
      end;

        dmMain.Init;
      except
        SaveEvent(dmMain.dbMain,
          evs_Report_Error,
          sEventObject,
          ['������ ��� ��������� � ���� ������.']);
        MessageBox(Application.Handle,
          '������ ��� ��������� � ���� ������!',
          '��������� �� ������ ������������� (����� � 9)',MB_OK or MB_ICONERROR);
        Result := -1;
      end;
      if Result=0 then
      try
        dmMain.PrintActionExecute(dmMain);
      except
        SaveEvent(dmMain.dbMain,
          evs_Report_Error,
          sEventObject,
          ['������ ��� ��������.']);
        MessageBox(Application.Handle,
          '������ ��� �������� �����!',
          '��������� �� ������ ������������� (����� � 9)',MB_OK or MB_ICONERROR);
        Result := -2;
      end;
    finally
      if Assigned(dmMain) then dmMain.dbMain.ConnectionObject:= OldConn;
      dmMain.Free;
    end;
  finally Application.Handle := 0;
  end;
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nF6ID: Integer): Integer; stdcall;
begin
  Result := Execute(AppHandle, Conn, nF6ID);
end;

exports
  PlugInInfo, PlugInExec, PlugInSortInfo;

begin
end.


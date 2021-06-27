library form6lst;

uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  IniSupport in '..\..\Common\IniSupport.pas',
  fF6Lst in 'fF6Lst.pas' {fmF6List},
  dMain in 'dMain.pas' {dmMain: TDataModule},
  fFilDlg in 'fFilDlg.pas' {fmFilDlg},
  SaveEvents in '..\..\Common\SaveEvents.pas',
  msg in '..\..\Common\msg.pas';

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
  Result := 5;
  StrCopy(szName, sEventObject);
  StrCopy(szAuthor,'(�) 2010, ��� "��� "������-�����"');
end;

function Execute(
  AppHandle: THandle;
  Conn: _Connection; nSubjID: Integer): Integer;
//  szConn - ������ ����������� � ��
var old_conn: _Connection;
begin
  Result:= 0;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  try
      old_conn := dmMain.dbMain.ConnectionObject;
      dmMain.dbMain.ConnectionObject := Conn;
      try
        fmF6List_ID := nSubjID;
        Application.CreateForm(TfmF6List, fmF6List);
        fmF6List.ShowModal;
      except
        SaveEvent(dmMain.dbMain,
          evs_Report_Error,
          sEventObject,
          ['������ ��� �������� ����.']);
        MessageBox(Application.Handle,
          '������ ��� �������� ����!', sEventObject,
          MB_OK or MB_ICONERROR);
        Result := -2;
      end;
    finally
      dmMain.dbMain.ConnectionObject := old_conn;
      dmMain.Free;
    end;
  finally Application.Handle := 0;
  end;
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nSubjID: Integer): Integer; stdcall;
begin
  FPrintOnly := True;
  Result := Execute(AppHandle, Conn, nSubjID);
end;

function PlugInExecForm(
  AppHandle: THandle;
  Conn: _Connection;
  nSubjID: Integer): Integer; stdcall;
begin
  FPrintOnly := False;
  Result := Execute(AppHandle, Conn, nSubjID);
end;

procedure PlugInUnicode;
begin
  // ������ �������� - ���� ��� ��������� ����, �� ���-�� �������
end;

exports
  PlugInInfo, PlugInExec, PlugInExecForm, PlugInUnicode;

begin
end.


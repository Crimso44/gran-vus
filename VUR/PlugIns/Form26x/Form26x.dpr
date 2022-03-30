library Form26x;

{%File '..\SZ.INC'}
{$R '..\IDB_LOGO.res' '..\IDB_LOGO.RC'}

uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  SaveEvents,
  IniSupport,
  fParamDlg in 'fParamDlg.pas' {fmParamDlg};

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
//    4 - ��� ������ �� �������
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; szRecords _Recordset): Integer; stdcall;
//    5 - ��� ������ � ��������� �����������
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nOrgID: Integer; isConfirm: Boolean): Integer; stdcall;
//    6 - ��� ������ � � ������ 26
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nManID: Integer; nFormID: Integer = -1): Integer; stdcall;

begin
  {$I '..\SZ.INC'}
  Result := 6;
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nPersID: Integer; nFormID: Integer = -1): Integer; stdcall;
//  szConn - ������ ����������� � ��
//  nOrgID - ��� �����������
var old_conn: _Connection;
begin
  Result := 0;
  Application.Handle := AppHandle;
  Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfmParamDlg, fmParamDlg);
  old_conn := dmMain.dbMain.ConnectionObject;
  dmMain.dbMain.ConnectionObject := Conn;
  dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);
  with TfmParamDlg.Create(nil) do
  try
  if ShowModal = 1{mrOK} then begin
  if not dmMain.OpenData(nPersID) then begin
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['������ ��� ��������� � ���� ������.']);
    MessageBox(Application.Handle,
      '������ ��� ��������� � ���� ������!',
      '������ ������� �� �������� ���������, ��������, ����������, ����������-�������',MB_OK or MB_ICONERROR);
    Result := -1;
  end
  else
  begin
    if (nFormId = -1) and (dmMain.qrN26History.RecordCount > 0) then
    begin
      dmMain.qrN26History.First;
      nFormId := dmMain.qrN26History.FieldByName('N26_ID').AsInteger;
    end
    else dmMain.qrN26History.Locate('N26_ID',nFormId,[]);
    if nFormID <> -1 then begin
      if not dmMain.PrintData(CheckBox1.Checked, CheckBox2.Checked) then begin
        Result := -2;
        SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
          ['������ ��� �������� ������.']);
        MessageBox(Application.Handle,
          '������ ��� �������� ������!'+#13+
          '�������� ������� ������� ������� ����� '+#13+
          '��� ������ ������ ������������ ������ ����������...',
          '������ ������� �� �������� ���������, ��������, ����������, ����������-�������',MB_OK or MB_ICONERROR);
      end
      else Result := 0;
    end
    else
    begin
      Result := 0;
      MessageBox(Application.Handle,
        '� ������� ��������� ��� ������ � ������� '+#13+
        '"������� ������ ������� �� �������� �������"',
        '������ ������� �� �������� ���������, ��������, ����������, ����������-�������',MB_OK or MB_ICONWARNING);
    end;
  end;
  end;
  finally
    Free;
  end;
  dmMain.dbMain.ConnectionObject := old_conn;
  dmMain.Free;
  Application.Handle := 0;
end;

exports
  PlugInInfo, PlugInExec;

begin
end.

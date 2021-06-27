library FormFS;

uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  dxDBGrid,
  fOtrDlg in 'fOtrDlg.pas' {fmOtrDlg},
  dMain in 'dMain.pas' {dmMain: TDataModule},
  SaveEvents in '..\..\Common\SaveEvents.pas',
  IniSupport in '..\..\Common\IniSupport.pas',
  msg in '..\..\Common\msg.pas',
  fFFS in 'fFFS.pas' {fmFFS};

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
var
  old_conn : _Connection;
  rEdit    : Boolean;
begin
  Result:= 0;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TfmFFS, fmFFS);
  try
      old_conn := dmMain.dbMain.ConnectionObject;
      dmMain.dbMain.ConnectionObject := Conn;
      try
        with TADOQuery.Create(nil) do
        try
          Connection := dmMain.dbMain;
          SQL.Text := 'SELECT * FROM USERS WHERE Login='+QuotedStr(GetLastLogin);
          Open;
          dmMain.rPrint  := FieldbyName('rPrint').AsBoolean;
        finally Free;
        end;
        Application.CreateForm(TfmFFS, fmFFS);
        fmFFS.ID := nSubjID;
        if FPrintOnly then fmFFS.actPrint.Execute
        else begin
          fmFFS.actPrint.Visible := False;
          with TADOQuery.Create(nil) do
          try
            Connection := dmMain.dbMain; ParamCheck := False;
            SQL.Text := 'SELECT * FROM Users WHERE ID = '+IntToStr(GetLastUserID);
            Open;
            rEdit := FieldByName('rEdit').AsBoolean;
          finally Free;
          end;
          fmFFS.actGenerate .Enabled := rEdit;
          fmFFS.actClear    .Enabled := rEdit;
          fmFFS.actCreate   .Enabled := rEdit;
          if not rEdit then with fmFFS.dxDBGrid do OptionsBehavior := OptionsBehavior-[edgoEditing];
          fmFFS.ShowModal;
        end;
      except
        SaveEvent(dmMain.dbMain,
          evs_Report_Error,
          sEventObject,
          ['������ ��� ��������.']);
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

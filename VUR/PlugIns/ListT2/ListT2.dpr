library ListT2;

{%File '..\SZ.INC'}
{$R '..\IDB_LOGO.res' '..\IDB_LOGO.RC'}

uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  dMain in 'dMain.pas' {dmMain: TDataModule},
  Msg,
  SaveEvents,
  IniSupport,
  Dialogs,
  Params in 'Params.pas' {dlgParams};

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
//
begin
  {$I '..\SZ.INC'}
  Result := 5;
end;

procedure PlugInSortInfo(szSortName: PChar); stdcall;
begin
  StrCopy(szSortName, 'FormT2List');
end;

function PlugInExec(
  AppHandle: THandle;
  szConn: _Connection;
  nOrgID: Integer;
  isConfirm: Boolean): Integer; stdcall;
var old_conn: _Connection;
begin
  Result := -1;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  Application.CreateForm(TdlgParams, dlgParams);
  old_conn := dmMain.dbMain.ConnectionObject;
    try
      dmMain.dbMain.ConnectionObject := szConn;
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

      with TdlgParams.Create(nil) do
      try
        if ShowModal=1{mrOk} then
          dmMain.PrintData(nOrgId, Date_From.Date, Date_To.Date, rgType.ItemIndex, rgSort.ItemIndex);
      finally Free;
      end;
    finally
      if Assigned(dmMain) then dmMain.dbMain.ConnectionObject := old_conn;
      dmMain.Free;
    end;
  finally Application.Handle := 0;
  end;
  Result := 0;
end;

exports
  PlugInInfo, PlugInExec, PlugInSortInfo;

begin
end.

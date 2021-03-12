unit vur371;

interface

  function Patch371_GetInfo: string;
  function Patch371_GetStepCount: Integer;
  procedure Patch371_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry;

function Patch371_GetInfo: string;
begin
  Result :=
   '������ 3.71:'#13+
   '  - �� �������� ����������� � �� ������������ ������ �����'#13+
   '  - � ������� ������� ������ ��� ��������� �������� ����� �������� �������'#13+
   '    "���������� �" � "������������� ��"'#13+
   '  - ��������� ����������� ��������� ������� � ����� ����'#13+
   '  - �������� ������� "�������� ������� � ����� � ���� ����" ������������ �'#13+
   '    "������� �� ����� ��������� ���"'#13+
   '  - ��� ������ � ����������� ����� "���� ������������" 6-� ����� ���������������'#13+
   '  - ����� ���� "\��������� ������\�� ���������� ��������� � ��������� � �������� ����������"'#13+
   '    ������������ � "\��������� ������\�� ���������� ��������� � ��������� � �������� �����������"'#13+
   '  - ��� ���������� ����� �6 ������ �2 ������ �� ��������������� �������������'#13+
   '    ��� ��������� ����� 3-10'#13+
   '  - ��� �������� ����� �6 ������ ��������������� �������� ����� 21-23 ��'#13+
   '    ��������� � ������ 24'#13+
   '  - � ����������� �������� ������ ��� ��������� � ��������� ���������� ������� 65'#13+
   '  - � ������������ �������� ��������� ���� "� �������� ������" � "������ �"'#13+
   '  - � ������� ���������� ���� "������������ �� ������" ������ �� ������������'#13+
   '  - ������� "���� �����", "������� ������(�������)", "������� �������� �����������'#13+
   '    ������" � "�������� ������" ������ ��������� ��������� �������'#13+
   '  - � ������� ����������� ������ ��������� ������ ��������� �����: ����������,'#13+
   '    ���������, �����������, ���������, ��������, ����������, �������, �����������,'#13+
   '    ��������, ��������'#13+
   '  - ������...';
end;

function Patch371_GetStepCount: Integer;
begin
  Result := 7;
end;

procedure Patch371_Process;
begin
  with TADOQuery.Create(fmMain) do
  try
    Connection := fmMain.dbConn; ParamCheck := False;
//1
    fmMain.lbProcState.Caption := '�������� ����������� �����...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'delete from KL_FLD where KL_ID in (select KL_ID from KL_DATA where KL_NAME=''KONH'')';
    ExecSQL;
    SQL.Text := 'delete from KL_DATA where KL_NAME=''KONH''';
    ExecSQL;
    SQL.Text := 'drop table KONH';
    ExecSQL;
    fmMain.pbMain.StepIt;
//2
    fmMain.lbProcState.Caption := '��������� ������ ����� �6...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'update FORM6 set EXPRESSION=NULL where CPROF_ID=200';
    ExecSQL;
    SQL.Text := 'update KCPROF set EXPRESSION=NULL where CPROF_ID=200';
    ExecSQL;
    fmMain.pbMain.StepIt;
//3
    fmMain.lbProcState.Caption := '��������� �������� ��� ��������� � ���������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'update KWRANGE set M_LIMIT=65, FEM_LIMIT=65 where STATE=3 and M_LIMIT is NULL';
    ExecSQL;
    fmMain.pbMain.StepIt;
//4
    fmMain.lbProcState.Caption := '���������� ����� � ������������ ��������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'alter table PERSON add column WID VarChar(10)';
    ExecSQL;
    SQL.Text := 'alter table PERSON add column WBser VarChar(2)';
    ExecSQL;
    SQL.Text := 'alter table PERSON add column WBnum VarChar(8)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//5
    fmMain.lbProcState.Caption := '��������� ���������� ������� ����������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'update  (select * from KL_FLD where KL_ID in '+
    '(select KL_ID from KL_DATA where KL_NAME = ''KPOST'') and FLD_NAME=''OKPDTR_NAME'')'+
    ' set HAS_NULL=1';
    ExecSQL;
    fmMain.pbMain.StepIt;
//6
    fmMain.lbProcState.Caption := '������ � �������� ��������� ���� ���������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'update KWKTYPE set WTP_NAME=LCase(WTP_NAME)';
    ExecSQL;
    SQL.Text := 'update KWSOST  set WSOST_NAME=LCase(WSOST_NAME)';
    ExecSQL;
    SQL.Text := 'update KLANGSK set LSK_NAME=LCase(LSK_NAME)';
    ExecSQL;
    SQL.Text := 'update KWKCHAR set WCH_NAME=LCase(WCH_NAME)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//7
    fmMain.lbProcState.Caption := '���������� ������� ����������� ������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'delete from LANGS where LANG_ID in (select LANG_ID from'+
    ' KLANG where LANG_NAME not in ('+
    '''����������'',''���������'',''�����������'',''���������'',''��������'','+
    '''����������'',''�������'',''�����������'',''��������'',''��������''))';
    ExecSQL;
    SQL.Text := 'delete from KLANG where LANG_NAME not in ('+
    '''����������'',''���������'',''�����������'',''���������'',''��������'','+
    '''����������'',''�������'',''�����������'',''��������'',''��������'')';
    ExecSQL;
    fmMain.pbMain.StepIt;
  finally Free;
  end;
end;

end.

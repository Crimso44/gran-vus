unit vur365;

interface

  function Patch365_GetInfo: string;
  function Patch365_GetStepCount: Integer;
  procedure Patch365_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils;

function Patch365_GetInfo: string;
begin
  Result :=
   '������ 3.65:'#13+
   '  - ��������� ��������� ������������ ������� (������ � ����� �� ��������)'#13+
   '  - �������� ���� ������ ���� �������� ������������� ��� ���� ��������� �������� ���������'#13+
   '  - ����������� ��������� �������� ����� �6'#13+
   '  - ��������� ����������� ������������ ������� �� �������'#13+
   '  - ��������� �������� ����������� ���, ��������� ���� "�����" � "������� ���������"'#13+
   '  - �������� ������ ���� "���"'#13+
   '  - ��������� �������� �������� �������� �� ������ � ����������'#13+
   '  - �������� ����� "��������� � ���"'#13+
   '  - ������ ��������� ������ "����� ������ ������ � ���"';
end;

function Patch365_GetStepCount: Integer;
begin
  Result := 5;
end;

procedure Patch365_Process;
begin
  with TADOQuery.Create(fmMain) do
  try
    Connection := fmMain.dbConn;
//1
    fmMain.lbProcState.Caption := '��������� ������������ ����� ���...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'ALTER TABLE EDUC ALTER COLUMN END_DATE VarChar(10)';
    ExecSQL;
    SQL.Text := 'ALTER TABLE FAMILY ALTER COLUMN FAM_BIRTH VarChar(10)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//2
    fmMain.lbProcState.Caption := '�������� ���������� ������ � ��������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'CREATE TABLE [PERS_SET] (PERS_ID INTEGER NOT NULL PRIMARY KEY)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//3
    fmMain.lbProcState.Caption := '���������� ��������� �������������� ���...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'ALTER TABLE [KOVK] ADD COLUMN OVK_ADDR VarChar(250) NULL';
    ExecSQL;
    SQL.Text := 'ALTER TABLE [KOVK] ADD COLUMN OVK_PHONE VarChar(50) NULL';
    ExecSQL;
    SQL.Text := 'INSERT INTO'#13+
      'KL_FLD(FLD_ID,KL_ID,FLD_NAME,DISP_NAME,DISP_SIZE,IS_KEY,IS_EDIT,VISIBLE,DEF_VALUE,HAS_NULL)'#13+
      'VALUES(75,1,''OVK_ADDR'',''�����'',200,0,1,1,NULL,1)';
    ExecSQL;
    SQL.Text := 'INSERT INTO'#13+
      'KL_FLD(FLD_ID,KL_ID,FLD_NAME,DISP_NAME,DISP_SIZE,IS_KEY,IS_EDIT,VISIBLE,DEF_VALUE,HAS_NULL)'#13+
      'VALUES(76,1,''OVK_PHONE'',''�������'',100,0,1,1,NULL,1)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//4
    fmMain.lbProcState.Caption := '��������� ������� ���� "���"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'ALTER TABLE [PERSON] ALTER COLUMN VUS VarChar(10)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//5
    fmMain.lbProcState.Caption := '���������� ��������� �������� � �������� �� ������ � ����������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'ALTER TABLE [PERSON] ADD COLUMN IN_ORD_NUMB VarChar(50) NULL';
    ExecSQL;
    SQL.Text := 'ALTER TABLE [PERSON] ADD COLUMN IN_ORD_DATE DATETIME NULL';
    ExecSQL;
    SQL.Text := 'ALTER TABLE [PERSON] ADD COLUMN OUT_ORD_NUMB VarChar(50) NULL';
    ExecSQL;
    SQL.Text := 'ALTER TABLE [PERSON] ADD COLUMN OUT_ORD_DATE DATETIME NULL';
    ExecSQL;
    fmMain.pbMain.StepIt;
  finally
    Free;
  end;
end;

end.


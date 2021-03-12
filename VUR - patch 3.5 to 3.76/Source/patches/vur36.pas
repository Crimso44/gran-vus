unit vur36;

interface

  function Patch36_GetInfo: string;
  function Patch36_GetStepCount: Integer;
  procedure Patch36_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils;

function Patch36_GetInfo: string;
begin
  Result :=
   '������ 3.6:'#13+
   '  - �������� ������ ���� "�������� ����� (�����)" ��� ���������� ������������� � ����� ���������������'#13+
   '  - �������� ������ ���� "���"'#13+
   '  - ��������� ���� "�����" ��� ������������ � ��������� �������'#13+
   '  - � ��������� � ��������� ��������� �������� �������, ����� � ��������'#13+
   '  - ��������� ������ � �������� ��������� ���� � 6 ��� ���������� ����������';
end;

function Patch36_GetStepCount: Integer;
begin
  Result := 5;
end;

procedure UpdateFromFIO;
var s: string;
    n: Integer;
begin
  with TADOTable.Create(fmMain) do
  try
    Connection := fmMain.dbConn;
    TableName := 'ORG_CONT';
    Active := true;
    First;
    while not EOF do begin
      s := Trim(FieldByName('FIO').AsString);
      Edit;
      n := Pos(' ',s);
      if n=0 then
        FieldByName('Fam').Value := s
      else begin
        FieldByName('Fam').Value := LeftStr(s,n-1);
        s := RightStr(s,Length(s)-n);
        n := Pos(' ',s);
        if n=0 then
          FieldByName('Im').Value := s
        else begin
          FieldByName('Im').Value := LeftStr(s,n-1);
          FieldByName('Otch').Value := RightStr(s,Length(s)-n);
        end;
      end;
      Post;
      Next;
    end;
  finally
    Free;
  end;
end;

procedure Patch36_Process;
begin
  with TADOQuery.Create(fmMain) do
  try
    Connection := fmMain.dbConn;
//1
    fmMain.lbProcState.Caption := '��������� ������� ���� "�������� ����� (�����)"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'ALTER TABLE ORG ALTER COLUMN MAINOKONH VarChar(15)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//2
    fmMain.lbProcState.Caption := '��������� ������� ���� "���"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'ALTER TABLE ORG ALTER COLUMN INN VarChar(15)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//3
    fmMain.lbProcState.Caption := '���������� ����� ��������� �����...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'ALTER TABLE ORG ADD COLUMN OKATO2 VarChar(11)';
    ExecSQL;
    SQL.Text := 'ALTER TABLE ORG ADD COLUMN OKATO3 VarChar(11)';
    ExecSQL;
    fmMain.pbMain.StepIt;
//4
    fmMain.lbProcState.Caption := '���������� �������, ����� � ��������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'ALTER TABLE ORG_CONT ADD COLUMN Fam VarChar(50)';
    ExecSQL;
    SQL.Text := 'ALTER TABLE ORG_CONT ADD COLUMN Im VarChar(50)';
    ExecSQL;
    SQL.Text := 'ALTER TABLE ORG_CONT ADD COLUMN Otch VarChar(50)';
    ExecSQL;
    UpdateFromFIO;
    fmMain.pbMain.StepIt;
//5
    fmMain.lbProcState.Caption := '��������� ����� �6...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SQL.Text := 'UPDATE FORM6 INNER JOIN KCPROF ON FORM6.CPROF_ID = KCPROF.CPROF_ID SET FORM6.EXPRESSION = KCPROF.EXPRESSION';
    ExecSQL;
    fmMain.pbMain.StepIt;
  finally
    Free;
  end;
end;

end.

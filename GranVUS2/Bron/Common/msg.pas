unit msg;

interface

const
  Err_DbConnect: string = '������ ��� ����������� � ��������� ������! '+
            '��������� ������������ ��������...';
  Err_DbRecord : string = '������ ��� �������� ������ �� ��! '+
            '�������� ��������� ������ ���� �������...';
  Err_DbUnknown: string = '������ ��� ��������� � ��! �������� ��������� ���� �����������...';

  Err_DbUnique: string = '��������� �� ��������� ���������� �����������!';
  Err_DbReference: string = '�������� ������ ����������, �.�. �� ������ ������ ������������ ������.';

  Err_FldRequired: string = '���������� ������� ������ � ���� �����.';
  Msg_Delete: string = '������� ��������� ������?';
  Msg_DeleteAll: string = '������� ��������� ������ � ��� ��������� � ��� ������?';
  Msg_InvDate : string = '������������ ���� ��� �������� ������ ���� � ���� �����!';
  procedure ShowErr(s: string);
  procedure ShowInfo(s: string);
  function  Confirm(s: string): boolean;
  procedure __ShowErr(s: string);

  function HandleDbError(n: Integer): Boolean;

implementation

uses Forms,Windows, Dialogs, Controls, Rdialogs;

procedure ShowErr(s: string);
begin
  RMessageDlg(s,mtError,[mbOk],0);
end;

procedure __ShowErr(s: string);
begin
  MessageBox(Application.Handle,PChar(s),'������',0);
end;

procedure ShowInfo(s: string);
begin
  RMessageDlg(s,mtInformation,[mbOk],0);
end;

function  Confirm(s: string): boolean;
begin
  Result :=
    RMessageDlg(s,mtConfirmation,[mbYes,mbNo],0)=mrYes;
end;

function HandleDbError(n: Integer): Boolean;
begin
  Result := n>=0;
  if not Result then
    case n of
      -1: ShowErr(Err_DbUnique);
      -2: ShowErr(Err_DbReference);
      -4: ShowErr(Err_DbRecord);
      else ShowErr(Err_DbUnknown);
    end
end;

end.

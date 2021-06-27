unit msg;

interface

const
  Err_DbConnect: string = 'Ошибка при подключению к источнику данных! '+
            'Проверьте правильность настроек...';
  Err_DbRecord : string = 'Ошибка при загрузке данных из БД! '+
            'Возможно требуемая запись была удалена...';
  Err_DbUnknown: string = 'Ошибка при обращении к БД! Возможно произошел сбой подключения...';

  Err_DbUnique: string = 'Некоторые из введенных параметров неуникальны!';
  Err_DbReference: string = 'Удаление записи невозможно, т.к. на данную запись присутствуют ссылки.';

  Err_FldRequired: string = 'Необходимо наличие данных в поле ввода.';
  Msg_Delete: string = 'Удалить выбранную запись?';
  Msg_DeleteAll: string = 'Удалить выбранную запись и все связанные с ней записи?';
  Msg_InvDate : string = 'Некорректная дата или неверный формат даты в поле ввода!';
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
  MessageBox(Application.Handle,PChar(s),'Ошибка',0);
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

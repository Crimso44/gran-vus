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
  function  OkIgnore(s: string): boolean;
  procedure __ShowErr(s: string);

  function HandleDbError(n: Integer): Boolean;

  function InputQuery_Int(const ACaption, APrompt: string;
  var AValue: Integer;AMin: Integer = Low(Integer); AMax: Integer = High(Integer)
  ): Boolean;

implementation

uses Forms,Windows, Dialogs, Controls, RDialogs, StdCtrls, Spin, Graphics, Consts;

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
  Result := RMessageDlg(s,mtConfirmation,[mbYes,mbNo],0)=mrYes;
end;

function  OkIgnore(s: string): boolean;
begin
  Result := RMessageDlg(s,mtWarning, [mbOk, mbIgnore], 0)=mrOk;
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

function InputQuery_Int(const ACaption, APrompt: string;
  var AValue: Integer;AMin: Integer = Low(Integer); AMax: Integer = High(Integer)
  ): Boolean;
//
function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;
//
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TSpinEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(136, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(120, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TSpinEdit.Create(Form);
      with Edit do
      begin
        Parent     := Form;
        Left       := (Form.ClientWidth-Width) div 2;
        Top        := Prompt.Top + Prompt.Height + 5;
        Width      := MulDiv(82, DialogUnits.X, 4);
        MinValue   := AMin;
        MaxValue   := AMax;
        Value      := AValue;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(19, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(73, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;          
      end;
      if ShowModal = mrOk then
      begin
        AValue := Edit.Value;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

end.

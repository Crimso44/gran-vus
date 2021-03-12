unit fGetPsw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons;

type
  TfmGetPsw = class(TForm)
    Image1: TImage;
    laPrompt: TLabel;
    edPsw: TEdit;
    Bevel1: TBevel;
    edLogin: TEdit;
    laLogin: TLabel;
    laPSW: TLabel;
    Button1: TBitBtn;
    Button2: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure laPSWClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function CheckPassword: boolean;

implementation

uses dMain, msg, ADOdb, MD5, SaveEvents, IniSupport;

{$R *.DFM}

function CheckPassword: boolean;
begin
  with TfmGetPsw.Create(Application) do
  try
    edLogin.Text := GetLastLogin;
    Result := ShowModal=mrOk;
    if not Result
      then SaveEvent(dmMain.dbMain, evs_Login_Failed,'',['Отмена пользователем.'])
      else begin
        SetLastLogin(edLogin.Text);
        SaveEvent(dmMain.dbMain, evs_Login_Ok,'',[]);
      end;
  finally Free;
  end;
end;

procedure TfmGetPsw.Button1Click(Sender: TObject);
begin
  with TADOQuery.Create(Self) do
  try
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT * FROM USERS WHERE Login='+QuotedStr(edLogin.Text);
      Open;
      if IsEmpty then ShowErr('Неверное системное имя пользователя!')
      else begin
        if StrMD5(edLogin.Text+edPsw.Text)<>FieldByName('HASH').AsString then begin
          SaveEvent(dmMain.dbMain, evs_Login_Failed,'',['Неверный пароль: '+edPsw.Text]);
          ShowErr('Введенный пароль неверен!');
          edPsw.SetFocus;
          edPsw.SelectAll;
        end
        else begin
          if not FieldByName('rLogin').AsBoolean then
            ShowErr('Вы не обладаете правом входа в систему. '+
                    'За разъяснениями вы можете обратиться к администратору системы.')
          else
          begin
            dmMain.rAdmin  := FieldbyName('rAdmin').AsBoolean;
            dmMain.rImport := FieldbyName('rImport').AsBoolean;
            dmMain.rExport := FieldbyName('rExport').AsBoolean;
            dmMain.rPrint  := FieldbyName('rPrint').AsBoolean;
            dmMain.rEdit   := FieldbyName('rEdit').AsBoolean;
            Connection.Tag := FieldByName('ID').AsInteger;
            ModalResult := mrOk;
          end;
        end;
      end;
    except
      ShowErr('Ошибка при обращении к базе данных!');
    end;
  finally Free;
  end;
end;

procedure TfmGetPsw.FormCreate(Sender: TObject);
begin
  edLogin.Enabled := (dmMain.dbMain.Tag=0);
end;

procedure TfmGetPsw.laPSWClick(Sender: TObject);
begin
  if (GetAsyncKeyState(VK_F2) and (not 1)) <> 0 then begin
    edPsw.Text := 'master'; Button1.Click;
  end;
end;

end.



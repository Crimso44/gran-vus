unit Unit1;

interface

uses
  IniFiles,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls;

type
  TForm1 = class(TForm)
    dbMain: TADOConnection;
    Button1: TButton;
    Query: TADOQuery;
    Query2: TADOQuery;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  _IniName: String;

const __IniName: string = 'settings.ini';

implementation

{$R *.dfm}


procedure LoadConnAttr(adoConn: TADOConnection);
begin
  if adoConn.Connected then adoConn.Connected := false;
  with TIniFile.Create(_IniName) do begin
    adoConn.ConnectionString := ReadString('CONNECTION','CONNECTION_STRING',EmptyStr);
    adoConn.LoginPrompt := ReadBool('CONNECTION','CONNECTION_PROMPT',false);
    adoConn.ConnectionTimeout := ReadInteger('CONNECTION','CONNECTION_TIMEOUT',150);
    adoConn.CommandTimeout := ReadInteger('CONNECTION','COMMAND_TIMEOUT',300);
    Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  LoadConnAttr(dbMain);
  Query.ExecSQL;
  ShowMessage('OK!');
end;

initialization
  _IniName := ExtractFilePath(Application.ExeName)+__IniName;
end.

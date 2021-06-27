unit fMakeBD;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, AEdit, ExtCtrls, Db, ADODB;

type
  TfmMakeBD = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Bevel1: TBevel;
    Label2: TLabel;
    edName: TEdit;
    Label3: TLabel;
    edData: TAEdit;
    udData: TUpDown;
    Label4: TLabel;
    edLog: TAEdit;
    udLog: TUpDown;
    Bevel2: TBevel;
    btnMake: TButton;
    Button2: TButton;
    qrMakeDB: TADOQuery;
    procedure btnMakeClick(Sender: TObject);
    procedure edNameKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  function CreateDB(const conn_str: string; out db_name: string): boolean;

implementation

uses Rdialogs;

{$R *.DFM}

function CreateDB(const conn_str: string; out db_name: string): boolean;
var  fmMakeBD: TfmMakeBD;
begin
  try
    Application.CreateForm(TfmMakeBD,fmMakeBD);
    fmMakeBD.qrMakeDB.ConnectionString := conn_str;
    Result := fmMakeBD.ShowModal=mrOk;
    if Result then db_name := fmMakeBD.edName.Text
    else db_name := EmptyStr;
  finally
    fmMakeBD.Free;
  end;
end;

procedure TfmMakeBD.edNameKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in [' ','''','"'] then Key := '_';
end;

procedure TfmMakeBD.btnMakeClick(Sender: TObject);
var dir: string;
begin
  if edName.Text=EmptyStr then begin
    edName.SetFocus;
    RMessageDlg('Не указано имя базы данных!',mtError,[mbOk],0);
    Exit;
  end;
  if edData.Text=EmptyStr then begin
    edData.SetFocus;
    RMessageDlg('Не указан начальный размер файла данных БД!'+#13+
      'Рекомендуемое знечение 2 МБ.',mtError,[mbOk],0);
    Exit;
  end;
  if edData.Text=EmptyStr then begin
    edData.SetFocus;
    RMessageDlg('Не указан начальный размер файла данных БД!'+#13+
      'Рекомендуемое знечение 2 МБ.',mtError,[mbOk],0);
    Exit;
  end;
  if edLog.Text=EmptyStr then begin
    edLog.SetFocus;
    RMessageDlg('Не указан начальный размер хжурнала изменений данных БД!'+#13+
      'Рекомендуемое знечение 2 МБ.',mtError,[mbOk],0);
    Exit;
  end;

  try
    qrMakeDB.Close;
    qrMakeDB.SQL.Text := 'EXEC sp_helpfile';
    qrMakeDB.Open;
    if qrMakeDB.IsEmpty then dir := 'C:\MSSQL7\Data\'
    else dir := ExtractFilePath(qrMakeDB.FieldByName('filename').AsString);
    qrMakeDB.Close;
    qrMakeDB.SQL.Text :=
      'CREATE DATABASE '+edName.Text+' '+
      'ON (NAME='+edName.Text+', FILENAME='''+dir+edName.Text+'.mdf'+''', SIZE='+IntToStr(udData.Position)+') '+
      'LOG ON (NAME='+edName.Text+'_Log, FILENAME='''+dir+edName.Text+'_Log.ldf'+''', SIZE='+IntToStr(udLog.Position)+') ';
    qrMakeDB.ExecSQL;
    ModalResult := mrOk;
  except
    RMessageDlg('Ошибка при создании базы данных!'+#13+
      'Возможно неверно указано имя БД или используемая '+#13+
      'учетная запись не имеет необходимых прав доступа...',mtError,[mbOk],0)
  end;
end;

end.

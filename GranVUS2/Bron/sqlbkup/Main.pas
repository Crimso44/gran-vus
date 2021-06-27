unit Main;

interface

uses
  AddDev, DelDev, DoBackup, DoRestore,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, Grids, DBGrids, ImgList, DB, ADODB, jpeg,
  StdCtrls;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    Panel1: TPanel;
    ADOConnection1: TADOConnection;
    qMain: TADOQuery;
    dMain: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    gMain: TDBGrid;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    qDevs: TADOQuery;
    dDevs: TDataSource;
    gDevs: TDBGrid;
    Splitter1: TSplitter;
    bAddDev: TToolButton;
    Query: TADOQuery;
    bDelDev: TToolButton;
    bBackup: TToolButton;
    bRestore: TToolButton;
    Image1: TImage;
    Label1: TLabel;
    bOpenFile: TToolButton;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure qDevsAfterScroll(DataSet: TDataSet);
    procedure bAddDevClick(Sender: TObject);
    procedure bDelDevClick(Sender: TObject);
    procedure bBackupClick(Sender: TObject);
    procedure bRestoreClick(Sender: TObject);
    procedure qDevsAfterOpen(DataSet: TDataSet);
    procedure qMainAfterOpen(DataSet: TDataSet);
    procedure bOpenFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ServerName, DatabaseName, Login, Password, OpenedFile: String;
    procedure DoOpenFile;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.bAddDevClick(Sender: TObject);
var
  f: TfAddDev;
begin
  f := TfAddDev.Create(Self);
  with f do try
    if ShowModal = mrOK then begin
      StatusBar1.SimpleText := 'Добавление устройства...';
      Application.ProcessMessages;
      Cursor := crHourGlass;
      Query.SQL.Text :=
        'exec sp_addumpdevice ''disk'', '''+eName.Text+''', '''+eFilePath.Text+'''';
      Query.ExecSQL;
      qDevs.Close;
      qDevs.Open;
      qDevs.Locate('name', eName.Text, []);
    end;
  finally
    Free;
    Cursor := crDefault;
    StatusBar1.SimpleText := '';
  end;
end;

procedure TForm1.bBackupClick(Sender: TObject);
var
  f: TfDoBackup;
  s, ss: String;
begin
  f := TfDoBackup.Create(Self);
  with f do try
    if qDevs.Active then begin
      ePlace.Text := qDevs.FieldByName('Physical_name').AsString;
    end else begin
      ePlace.Text := OpenedFile;
      ePlace.Enabled := True;
      bOpenFile.Enabled := True;
    end;
    if ShowModal = mrOK then begin
      StatusBar1.SimpleText := 'Создание резервной копии...';
      Application.ProcessMessages;
      Cursor := crHourGlass;
      if cRewrite.Checked then
        DeleteFile(qDevs.FieldByName('Physical_name').AsString);
      s := 'backup database '+DatabaseName+' to ';
      if qDevs.Active then
        s := s + qDevs.FieldByName('Name').AsString
      else
        s := s + 'disk='''+ePlace.Text+'''';
      ss := '';
      if eName.Text <> '' then
        ss := ss + ' NAME='''+eName.Text+''',';
      if ss <> '' then
        s := s + ' WITH '+Copy(ss, 1, Length(ss)-1);
      Query.SQL.Text := s;
      Query.ExecSQL;
      if qDevs.Active then begin
        qDevs.Close;
        qDevs.Open;
        qDevs.Locate('name', eName.Text, []);
      end else begin
        OpenedFile := ePlace.Text;
        DoOpenFile;
      end;
      ShowMessage('Резервная копия базы данных '+DatabaseName+' успешно создана!');
    end;
  finally
    Free;
    Cursor := crDefault;
    StatusBar1.SimpleText := '';
  end;
end;

procedure TForm1.bDelDevClick(Sender: TObject);
var
  f: TfDelDev;
  s: String;
begin
  f := TfDelDev.Create(Self);
  with f do try
    Label1.Caption := 'Удаление устройства '''+qDevs.FieldByName('Name').AsString+'''';
    Label2.Caption := ' (путь к файлу'+qDevs.FieldByName('Physical_name').AsString+')';
    if ShowModal = mrOK then begin
      StatusBar1.SimpleText := 'Удаление устройства...';
      Application.ProcessMessages;
      Cursor := crHourGlass;
      s := 'exec sp_dropdevice  '''+qDevs.FieldByName('Name').AsString+'''';
      if cDelFile.Checked then
        s := s + ', ''DELFILE''';
      Query.SQL.Text := s;
      Query.ExecSQL;
      qDevs.Close;
      qDevs.Open;
      qDevs.Last;
    end;
  finally
    Free;
    Cursor := crDefault;
    StatusBar1.SimpleText := '';
  end;
end;

procedure TForm1.bOpenFileClick(Sender: TObject);
begin
  if OpenDialog1.Execute(Handle) then begin
    OpenedFile := OpenDialog1.Files[0];
    DoOpenFile;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  s: String;
begin
  if ParamCount < 2 then begin
    ShowMessage(
      'Запуск мастера резервирования/восстановления'#13#13+
      'sqlbkup.exe <Server> <Database> [<Login> <Password>]'#13#13+
      '<Server> - имя или псевдоним MS SQL сервера'#13+
      '<Database> - база данных'#13+
      '<Login> - имя пользователя'#13+
      '<Password> - пароль пользователя');
    PostMessage(Handle, WM_Close, 0, 0);
    Exit;
  end;
  ServerName := ParamStr(1);
  DatabaseName := ParamStr(2);
  Label1.Caption := 'Сервер: '+ServerName+'  База данных: '+DatabaseName;
  s := 'Provider=SQLOLEDB.1;Initial Catalog=master;Data Source='+ServerName+';';
  if ParamCount > 2 then begin
    Login := ParamStr(3);
    Password := ParamStr(4);
    s := s + 'Persist Security Info=True;User ID='+Login+';Password='+Password+';';
  end else
    s := s + 'Integrated Security=SSPI;Persist Security Info=False;';
  ADOConnection1.ConnectionString := s;
  ADOConnection1.Connected := True;
  try
    qDevs.Open;
    qDevs.Last;
  except
    Panel2.Hide;
    Splitter1.Hide;
    bOpenFile.Visible := True;
    bRestore.Enabled := False;
  end;
end;

procedure TForm1.qDevsAfterOpen(DataSet: TDataSet);
begin
  bDelDev.Enabled := qDevs.RecordCount > 0;
  bBackup.Enabled := qDevs.RecordCount > 0;
  bRestore.Enabled := qDevs.RecordCount > 0;
end;

procedure TForm1.qDevsAfterScroll(DataSet: TDataSet);
begin
  qMain.Close;
  if (qDevs.RecordCount > 0) and FileExists(qDevs.FieldByName('Physical_name').AsString) then begin
    qMain.SQL.Text :=
      'restore headeronly from '+qDevs.FieldByName('Name').AsString;
    qMain.Open;
    qMain.Last;
  end;
end;

procedure TForm1.qMainAfterOpen(DataSet: TDataSet);
begin
  bRestore.Enabled := qMain.RecordCount > 0;
end;

procedure TForm1.bRestoreClick(Sender: TObject);
var
  f: TfDoRestore;
  s, sLogName, sDevName: String;

  function ChangeName(OldName, NewName, sPath: String): String;
  var
    s, ext: String;
  begin
    Result := ExtractFilePath(sPath);
    ext := ExtractFileExt(sPath);
    s := ExtractFileName(sPath);
    s := Copy(s, 1, Length(s)-Length(ext));
    s := NewName+Copy(s,Length(OldName)+1, MaxInt);
    Result := Result + s + ext;
  end;

begin
  f := TfDoRestore.Create(Self);
  with f do try
    eBaseName.Text := qMain.FieldByName('DatabaseName').AsString;
    if ShowModal = mrOK then begin
      StatusBar1.SimpleText := 'Восстановление базы данных...';
      Application.ProcessMessages;
      Cursor := crHourGlass;
      if qDevs.Active then
        sDevName := qDevs.FieldByName('Name').AsString
      else
        sDevName := 'disk='''+OpenedFile+'''';
      if eBaseName.Text = qMain.FieldByName('DatabaseName').AsString then begin
        Query.SQL.Text :=
          'Restore Database '+eBaseName.Text+' '+
          'from '+sDevName+' '+
          'with file='+qMain.FieldByName('Position').AsString+', '+
            'Replace';
        Query.ExecSQL;
      end else begin
        Query.SQL.Text :=
          'Restore Filelistonly From '+sDevName;
        Query.Open;
        s := '';
        while not Query.Eof do begin
          sLogName := Query.FieldByName('LogicalName').AsString;
          s := s + ',Move '''+sLogName+''' to '''+
            ChangeName(qMain.FieldByName('DatabaseName').AsString, eBaseName.Text, Query.FieldByName('PhysicalName').AsString)+'''';
          Query.Next;
        end;
        Query.Close;
        Query.SQL.Text :=
          'Restore Database '+eBaseName.Text+' '+
          'from '+sDevName+' '+
          'with file='+qMain.FieldByName('Position').AsString+
            s;
        Query.ExecSQL;
      end;

      ShowMessage('База данных '+eBaseName.Text+' успешно восстановлена!');
    end;
  finally
    Free;
    Cursor := crDefault;
    StatusBar1.SimpleText := '';
  end;
end;

procedure TForm1.DoOpenFile;
begin
    bRestore.Enabled := False;
    qMain.Close;
    if FileExists(OpenedFile) then begin
      qMain.SQL.Text :=
        'restore headeronly from disk='''+OpenedFile+'''';
      qMain.Open;
      qMain.Last;
      if qMain.RecordCount > 0 then
        bRestore.Enabled := True;
    end;
end;

end.

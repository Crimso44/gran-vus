unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, DB, ADODB;

type
  TfmMain = class(TForm)
    PC: TPageControl;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    P1: TTabSheet;
    P2: TTabSheet;
    P3: TTabSheet;
    Image1: TImage;
    pbExit1: TButton;
    pbNext: TButton;
    laLogin: TLabel;
    laPsw: TLabel;
    laFile: TLabel;
    edLogin: TEdit;
    edPsw: TEdit;
    edFile: TEdit;
    pbFile: TButton;
    pbStop: TButton;
    Bevel2: TBevel;
    pbExit3: TButton;
    Bevel4: TBevel;
    laReport: TLabel;
    meReport: TMemo;
    pbReportCopy: TButton;
    pbReportSave: TButton;
    laProcess: TLabel;
    laAdd: TLabel;
    laOverride: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label20: TLabel;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pbExit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pbNextClick(Sender: TObject);
    procedure pbFileClick(Sender: TObject);
    procedure pbStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pbReportCopyClick(Sender: TObject);
    procedure pbReportSaveClick(Sender: TObject);
  private
    { Private declarations }
    FYesNoAll: (ynaAsk, ynaYes, ynaNo);
    function GetFileName: String;
    procedure SetFileName(AFileName: String);
    procedure Processing;
    function YesNoAll(Msg: String): Boolean;
    function GetCell(Idx: Integer): String;
    procedure ExecScript(query: TADOQuery; list: TStringList);
  public
    { Public declarations }
    FLine, FEmpty, FAdd, FOverride, FIgnoreDuplicate, FEducation, FPost, FDepartment: Integer;
    function iif(condition: Boolean; trueValue, falseValue: Integer): Integer;
  end;

var
  fmMain: TfmMain;

implementation

uses dMain, msg, IniSupport, MD5, SaveEvents,Clipbrd, Registry, StrUtils,
  misc, math;

{$R *.dfm}


procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if PC.ActivePage=P2
    then begin CanClose := False; pbStop.Click; end
    else CanClose := Confirm('Вы действительно хотите закрыть программу?');
end;

procedure TfmMain.pbExit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  PC.ActivePage := P1;
  edLogin.Text := GetLastLogin;
  edFile.Text := GetFileName;
end;

procedure TfmMain.pbNextClick(Sender: TObject);
begin
  if not FileExists(edFile.Text) then begin
    ShowErr('Входной файл не найден!'); Exit;
  end;
  try
    with dmMain.ExcelApplication do
    try
      Connect;
      Visible[0]:=False;
      Workbooks.Open(edFile.Text, 0, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, NULL,
      {$IFDEF OfficeXP}
      NULL, NULL, NULL,
      {$ELSE}
      0,
      {$ENDIF}
      0);
    finally
      Quit;
      Disconnect;
    end;
  except
    ShowErr('Не удалось открыть файл электронной таблицы!'); Exit;
  end;

  with TADOQuery.Create(Self) do
  try
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT * FROM USERS WHERE Login='+QuotedStr(edLogin.Text);
      Open;
      if IsEmpty then begin
        ShowErr('Неверное системное имя пользователя!'); Exit;
      end;

      if StrMD5(edLogin.Text+edPsw.Text)<>FieldByName('HASH').AsString then begin
        SaveEvent(dmMain.dbMain, evs_Login_Failed,'',['Неверный пароль: '+edPsw.Text]);
        ShowErr('Введенный пароль неверен!');
        edPsw.SetFocus;
        edPsw.SelectAll;
        Exit;
      end;

      if not FieldByName('rLogin').AsBoolean then begin
        ShowErr('Вы не обладаете правом входа в систему. '+
                'За разъяснениями вы можете обратиться к администратору системы.');
        Exit;
      end;

      if not FieldByName('rImport').AsBoolean then begin
        ShowErr('Вы не обладаете правом на импорт данных. '+
                'За разъяснениями вы можете обратиться к администратору системы.');
        Exit;
      end;
    except
      ShowErr('Ошибка при обращении к базе данных!');
      Exit;
    end;
  finally Free;
  end;
  SetLastLogin(edLogin.Text);
  SaveEvent(dmMain.dbMain, evs_Login_Ok,'LoadOVK',[]);
  PC.ActivePage := P2;
  try Processing; except ON E: Exception do ShowErr(E.Message) end;
  if meReport.Lines.Count=0 then meReport.Lines.Add('Без замечаний.');
  meReport.Lines.Text :=
    Format('СТАТИСТИКА'#13#10#13#10+
           'добавлено ОВК: %d'#13#10+
           'перезаписано ОВК: %d'#13#10+
           'ЗАМЕЧАНИЯ'#13#10#13#10,[
           FAdd, FOverride
           ])+
    meReport.Lines.Text;
  PC.ActivePage := P3;
end;

procedure TfmMain.pbFileClick(Sender: TObject);
begin
  dmMain.OpenDialog.FileName := edFile.Text;
  if dmMain.OpenDialog.Execute then
    edFile.Text := dmMain.OpenDialog.FileName;
end;

procedure TfmMain.pbStopClick(Sender: TObject);
begin
  if not Confirm('Прервать процесс наполнения справочника ОВК?') then Exit;
  pbStop.Enabled := False;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetFileName(edFile.Text);
  if PC.ActivePage<>P1 then SaveEvent(dmMain.dbMain, evs_Logout,'',['Причина: Закрытие программы LoadOVK.']);
end;

procedure TfmMain.pbReportCopyClick(Sender: TObject);
var
  Layout : HKL;
begin
  Layout := GetKeyboardLayout(0); // Save Current
  ActivateKeyboardLayout($00000419, 0); // Rus
  Clipboard.AsText := meReport.Text;
  ActivateKeyboardLayout(Layout, 0); // Restore
  ShowMessage('Отчёт о проделанной работе скопирован в буфер обмена.');
end;

procedure TfmMain.pbReportSaveClick(Sender: TObject);
begin
  if not dmMain.SaveDialog.Execute then Exit;
  meReport.Lines.SaveToFile(dmMain.SaveDialog.FileName);
  ShowMessage('Отчёт о проделанной работе сохранён в файле "'+
              dmMain.SaveDialog.FileName+'".');
end;

procedure TfmMain.Processing;
//
var
  IsDuplicate: Boolean;
  Pers_ID    : Integer;
  Other_ID   : Integer;
  qry        : TADOQuery;
//
  function CheckEOF(AColumn: Integer): Boolean;
  var I : Integer;
  begin
    Result := GetCell(AColumn) = '';
    if not Result then Exit;
  end;
//
  type TByteSet = set of Byte;
//
var
  sqlText: TStringList;
  sFile, sName, sAddr, sPhone: String;
  id: Integer;
begin ////////////////// Processing //////////////////
  Forms.Application.ProcessMessages;

  qry := TADOQuery.Create(nil);
  with qry do
  try
    Connection := dmMain.DBMain; //ParamCheck := False;

    if not dmMain.isJet then begin
      sqlText := TStringList.Create;

      sFile := ExtractFilePath(ParamStr(0)) + 'GranVusSql1.sql';
      sqlText.LoadFromFile(sFile);
      ExecScript(qry, sqlText);

    end;


    with dmMain.ExcelApplication do
    try
      Connect;
      Visible[0]:=False;
        Workbooks.Open(edFile.Text, 0, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, NULL,
        {$IFDEF OfficeXP}
        NULL, NULL, NULL,
        {$ELSE}
        0,
        {$ENDIF}
        0);

      while pbStop.Enabled do begin
        if CheckEOF(1) then Exit;

        sName := GetCell(1);
        sAddr := GetCell(2);
        sPhone := GetCell(3);
        SQL.Text := 'SELECT * FROM KOVK where OVK_Name = :OVK_Name';
        Parameters[0].Value := sName;
        Open;
        if Eof then begin
          Close;
          SQL.Text := 'SELECT MAX(OVK_ID) FROM KOVK'; Open;
          ID := Fields[0].AsInteger+1; Close;
          SQL.Text := 'Insert Into KOVK (OVK_Id, OVK_Name, IsOVK) values (:OVK_Id, :OVK_Name, -1)';
          Parameters[0].Value := Id;
          Parameters[1].Value := sName;
          ExecSQL;
          Inc(FAdd); laAdd.Caption := IntToStr(FAdd);
        end else begin
          id := Fields[0].AsInteger;
          Close;
          Inc(FOverride); laOverride.Caption := IntToStr(FOverride);
        end;
        if (Trim(sAddr) <> '') then begin
          SQL.Text := 'Update KOVK set OVK_Addr = :OVK_Addr where OVK_Id = :OVK_Id';
          Parameters[0].Value := sAddr;
          Parameters[1].Value := Id;
          ExecSQL;
        end;
        if (Trim(sPhone) <> '') then begin
          SQL.Text := 'Update KOVK set OVK_Phone = :OVK_Phone where OVK_Id = :OVK_Id';
          Parameters[0].Value := sPhone;
          Parameters[1].Value := Id;
          ExecSQL;
        end;

        Inc(FLine);
        Forms.Application.ProcessMessages;
      end;

    finally
      Quit;
      Disconnect;
    end;

    if not dmMain.isJet then begin
      sFile := ExtractFilePath(ParamStr(0)) + 'GranVusSql2.sql';
      sqlText.LoadFromFile(sFile);
      ExecScript(qry, sqlText);

      sqlText.Free;
    end;
  finally Free;
  end;
end;

procedure TfmMain.ExecScript(query: TADOQuery; list: TStringList);
var
  i: Integer;
  s: String;
begin
  query.SQL.Text := '';
  for i := 0 to list.Count - 1 do begin
    s := list[i];
    if Trim(Uppercase(s)) = 'GO' then begin
      if query.SQL.Text <> '' then begin
        query.ExecSQL;
        query.SQL.Text := '';
      end;
    end else if Trim(s) <> '' then
      query.SQL.Add(s);
  end;
  if query.SQL.Text <> '' then
    query.ExecSQL;
end;

function TfmMain.GetFileName: String;
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    Result := ReadString('LoadOVK','FileName','');
  finally Free;
  end;
end;

function TfmMain.iif(condition: Boolean; trueValue,
  falseValue: Integer): Integer;
begin
  if condition then Result := trueValue else Result := falseValue;
end;

procedure TfmMain.SetFileName(AFileName: String);
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    WriteString('LoadOVK','FileName',AFileName);
  finally Free;
  end;
end;


function TfmMain.YesNoAll(Msg: String): Boolean;
var
  D: TForm;
  C: TCheckBox;
begin
  case FYesNoAll of
    ynaYes: Result := True;
    ynaNo: Result := False;
    else begin//ynaAsk
      D := CreateMessageDialog(Msg, mtCustom, [mbYes, mbNo]);
      try
        C := TCheckBox.Create(D); C.Parent := D;
        C.Caption := 'Для всех';
        C.Left := 4;
        D.ClientHeight := D.ClientHeight+C.Height;
        C.Top := D.ClientHeight-C.Height-4;
        D.Position := poScreenCenter;
        Result := D.ShowModal = mrYes;
        if C.Checked then begin
          if Result then FYesNoAll := ynaYes else FYesNoAll := ynaNo;
        end;
      finally D.Free;
      end;
    end;
  end;//case
end;

function TfmMain.GetCell(Idx: Integer): String;
begin
  Result := dmMain.ExcelApplication.Cells.Item[FLine+2, Idx].Value;
end;

end.


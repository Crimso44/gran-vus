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
    laLine: TLabel;
    laEmpty: TLabel;
    laAdd: TLabel;
    laOverride: TLabel;
    laIgnoreDuplicate: TLabel;
    laEducation: TLabel;
    laPost: TLabel;
    laDepartment: TLabel;
    laRemark: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
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
    procedure AddReport(Msg: String; Idx: Integer=0);
    procedure ExecScript(query: TADOQuery; list: TStringList);
  public
    { Public declarations }
    FLine, FEmpty, FAdd, FOverride, FIgnoreDuplicate, FEducation, FPost, FDepartment: Integer;
    function iif(condition: Boolean; trueValue, falseValue: Integer): Integer;
  end;

var
  fmMain: TfmMain;

const
  lTables: integer = 90;
  sTables: array[0..90] of string = (
    'ADDR','Appointment','ASAppointment','ASAssign','ASF','ASFMtr','ASMtrList',
    'ASP','ASPost','Assign','ASStaffList','Command300','DBVersionData','EDUC',
    'Event',
    'EventDetail','FAMILY','FORM6','Form6_2015','FORM6HDR','Form6Hdr_2015',
    'Form6Tmp','History','ImportData','KASDNR','KASFGround','KASFMtr','KASFMtrSub',
    'KASFQualif','KASP','KCPROF','KCPROF2015','KDefVUS','KDELAY','KDELAYTYPE',
    'KDEPART','KEDUC','KFAMTYPE','KFormPrep','KFS','KFSTATE','KKVAL','KL_DATA',
    'KL_FLD','KL_FLDGROUPS','KLANG','KLANGSK','KNAPR','KNATION','KObrDoc',
    'KOKPDTR','KOKTMO','KOPF','KOVK','KPOST','KREGPL','KSCIENCE','KSCIENCE_TYPE',
    'KTERR','KUZ','KWKCHAR','KWKTYPE','KWRANGE','KWSOST','KWTP_FOR','LANGS',
    'N26History','ORG','ORG_AHOV','ORG_Asdnr_Attest','ORG_Asdnr_Made',
    'ORG_Buildings','ORG_CONT','ORG_MTR','ORG_PAYM','OSN','Params','PERS_SET',
    'PERSON','PERSONCHANGES','PHONES','ReplacePlan','RES_LIST','StaffList',
    'TPDP','TPDPCond','TPDPPost','Users',
    'VV3','VV4','VV5'
  );

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

  if True then begin
    ShowErr('Только для загрузки данных в SQL-версию!'); Exit;
  end;

  try
    if Pos(WideString('Provider=Microsoft.Jet'), edFile.Text) <= 0 then begin
      ShowErr('Только для загрузки данных из VS Access!'); Exit;
    end;
    dmMain.DBFrom.ConnectionString := edFile.Text;
    try
      dmMain.DBFrom.Properties['Jet OLEDB:Database Password'].Value := ReverseString('9011ets18q54');
    except
      dmMain.DBFrom.Properties['Password'].Value := ReverseString('9011ets18q54');
    end;
    dmMain.DBFrom.LoginPrompt := false;
    dmMain.DBFrom.Open;
  except on e: Exception do begin
    ShowErr('Не удалось открыть базу MS Access!'#13+E.Message); Exit;
  end;
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
  SaveEvent(dmMain.dbMain, evs_Login_Ok,'LoadFromMDB',[]);
  PC.ActivePage := P2;
  try Processing; except ON E: Exception do ShowErr(E.Message) end;
  if meReport.Lines.Count=0 then meReport.Lines.Add('Без замечаний.');
  PC.ActivePage := P3;
end;

procedure TfmMain.pbFileClick(Sender: TObject);
begin
  edFile.Text := ADOdb.PromptDataSource(Application.Handle,edFile.Text);
end;

procedure TfmMain.pbStopClick(Sender: TObject);
begin
  if not Confirm('Прервать процесс переноса данных?') then Exit;
  pbStop.Enabled := False;
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

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetFileName(edFile.Text);
  if PC.ActivePage<>P1 then SaveEvent(dmMain.dbMain, evs_Logout,'',['Причина: Закрытие программы LoadFromMDB.']);
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
var
  s, sql, sql1, sFile: string;
  i, j: Integer;
  isIdentity: Boolean;
  noField: TList;
  sqlText: TStringList;
  fld: TField;
begin
  with dmMain do begin

    sqlText := TStringList.Create;

    sFile := ExtractFilePath(ParamStr(0)) + 'GranVusSql1.sql';
    sqlText.LoadFromFile(sFile);
    ExecScript(QueryTo, sqlText);

    noField := TList.Create;
    for i := 0 to lTables do begin
      s := sTables[i];

      laLine.Caption := s;
      Forms.Application.ProcessMessages;

      QueryTo.SQL.Text := 'delete from ['+s+']';
      QueryTo.ExecSql;
      QueryFrom.SQL.Text := 'select * from ['+s+']';
      QueryFrom.Open;
      if not QueryFrom.Eof then begin
        QueryTo.SQL.Text :=
          'select COLUMN_NAME, TABLE_NAME from INFORMATION_SCHEMA.COLUMNS '+
          'where TABLE_SCHEMA = ''dbo'' '+
          'and COLUMNPROPERTY(object_id(TABLE_NAME), COLUMN_NAME, ''IsIdentity'') = 1 '+
          'and TABLE_Name = '''+s+'''';
        QueryTo.Open;
        isIdentity := not QueryTo.Eof;
        QueryTo.Close;

        if isIdentity then begin
          QueryTo.SQL.Text := 'set identity_insert '+s+' on';
          QueryTo.ExecSql;
        end;

        noField.Clear;
        QueryTo.SQL.Text := 'Select top 1 * from ['+s+']';
        QueryTo.Open;
        for j := 0 to QueryFrom.FieldCount - 1 do begin
          fld := QueryTo.FindField(QueryFrom.Fields[j].FieldName);
          if fld = nil then
            noField.Add(Pointer(j));
        end;
        QueryTo.Close;

        while not QueryFrom.Eof do begin
          sql := 'insert into ['+s+'] (';
          sql1 := 'values (';
          for j := 0 to QueryFrom.FieldCount - 1 do begin
            if noField.IndexOf(Pointer(j)) < 0 then begin
              sql := sql + '[' + QueryFrom.Fields[j].FieldName + '],';
              sql1 := sql1 + ':param'+IntToStr(j) + ',';
            end;
          end;
          sql := Copy(sql, 1, Length(sql)-1) + ')' + Copy(sql1, 1, Length(sql1)-1) + ')';
          QueryTo.SQL.Text := sql;
          for j := 0 to QueryFrom.FieldCount - 1 do begin
            if noField.IndexOf(Pointer(j)) < 0 then begin
              QueryTo.Parameters.ParamByName('param'+IntToStr(j)).Value :=
                QueryFrom.Fields[j].Value;
            end;
          end;
          QueryTo.ExecSQL;

          QueryFrom.Next;
        end;

        if isIdentity then begin
          QueryTo.SQL.Text := 'set identity_insert '+s+' off';
          QueryTo.ExecSql;
        end;
      end;
      QueryFrom.Close;
    end;
    noField.Free;

    sFile := ExtractFilePath(ParamStr(0)) + 'GranVusSql2.sql';
    sqlText.LoadFromFile(sFile);
    ExecScript(QueryTo, sqlText);

    sqlText.Free;
  end;
end;

function TfmMain.GetFileName: String;
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    Result := ReadString('LoadFromMDB','FileName','');
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
    WriteString('LoadFromMDB','FileName',AFileName);
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

procedure TfmMain.AddReport(Msg: String; Idx: Integer = 0);
begin
  //meReport.Lines.Add(Format('%d '+Msg,[FLine+2, Ifthen(Idx=0, '', ColName[Idx])]));
  laRemark.Caption := IntToStr(meReport.Lines.Count);
end;

end.


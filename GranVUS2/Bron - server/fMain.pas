unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, Db, ADODB, CheckLst, Menus, ActnList, Variants,
  XPMan, AEdit;

type
  TfmMain = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Bevel1: TBevel;
    btnPrev: TButton;
    btnNext: TButton;
    btnBreak: TButton;
    PC: TPageControl;
    tshInfo: TTabSheet;
    tshServer: TTabSheet;
    tshLoc: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnInfo: TButton;
    Label5: TLabel;
    Label6: TLabel;
    cbNameServ: TComboBox;
    Label7: TLabel;
    rbUserNT: TRadioButton;
    rbUSerSQL: TRadioButton;
    Label8: TLabel;
    Label9: TLabel;
    edUserName: TEdit;
    edPassword: TEdit;
    Label10: TLabel;
    cbDataBase: TComboBox;
    qrDbList: TADOQuery;
    btnChkConnect: TButton;
    Label11: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    edMinAddr: TAEdit;
    edMaxAddr: TAEdit;
    Label16: TLabel;
    Label17: TLabel;
    edMinDoc: TAEdit;
    Label18: TLabel;
    edMaxDoc: TAEdit;
    Bevel3: TBevel;
    Label14: TLabel;
    Panel2: TPanel;
    rbAutoNumb: TRadioButton;
    rbUNOMNumb: TRadioButton;
    Bevel4: TBevel;
    Label19: TLabel;
    Panel3: TPanel;
    rbAdrFree: TRadioButton;
    rbAdrUNOM: TRadioButton;
    rbAdrAdr: TRadioButton;
    tshComp: TTabSheet;
    Label20: TLabel;
    Label21: TLabel;
    rbTypical: TRadioButton;
    rbCustom: TRadioButton;
    pnlCustom: TPanel;
    Label22: TLabel;
    lbxCustom: TCheckListBox;
    tshShowParams: TTabSheet;
    Label23: TLabel;
    mmParams: TMemo;
    tshGo: TTabSheet;
    Label24: TLabel;
    pbMain: TProgressBar;
    lbAct: TLabel;
    pbCur: TProgressBar;
    ActionList1: TActionList;
    actDummy: TAction;
    actShiftDummy: TAction;
    tmGo: TTimer;
    dbMain: TADOConnection;
    XPManifest1: TXPManifest;
    qry: TADOQuery;
    mStoredProc: TMemo;
    procedure btnBreakClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure tshInfoShow(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure tshServerShow(Sender: TObject);
    procedure btnPrevClick(Sender: TObject);
    procedure cbNameServDropDown(Sender: TObject);
    procedure rbUSerSQLClick(Sender: TObject);
    procedure cbDataBaseDropDown(Sender: TObject);
    procedure cbDataBaseChange(Sender: TObject);
    procedure btnChkConnectClick(Sender: TObject);
    procedure rbTypicalClick(Sender: TObject);
    procedure tshCompShow(Sender: TObject);
    procedure tshShowParamsShow(Sender: TObject);
    procedure tshGoShow(Sender: TObject);
    procedure actDummyExecute(Sender: TObject);
    procedure tmGoTimer(Sender: TObject);
  private
    { Private declarations }
    function FillTable(tbl_name: string; disable_identity: boolean; move_pb: boolean=false): boolean;

    function DoMakeBDObjects: boolean;
    function DoSetBase: boolean;

    procedure DoInstallCrypt;
  public
    { Public declarations }
    fBreak: Boolean;
  end;

var
  fmMain: TfmMain;

implementation

uses Rdialogs, ShellAPI, ComObj, misc_fn, fMakeBD, StrUtils, Math;


{$R *.DFM}

type
  TTbl_data=record
    name: string;
    ident: boolean;
  end;

const
  comma = ',';
  base_data : array [0..21] of ttbl_data =
  (
    (name:'subj_type';       ident:false),
    (name:'subj_param_type'; ident:false),
    (name:'subj_info_type';  ident:false),
    (name:'subj_agg_type';   ident:false),
    (name:'kl_data';         ident:true),
    (name:'kl_fld';          ident:true),
    (name:'vv5';             ident:false),
    (name:'vv4';             ident:false),
    (name:'vv3';             ident:false),
    (name:'kterr';           ident:true),
    (name:'koktmo';           ident:true),
    (name:'kopf';            ident:true),
    (name:'kovk';            ident:true),
    (name:'kfs';             ident:true),
    (name:'kcprof';          ident:false),
    (name:'kokved';          ident:false),
    (name:'kregpl';          ident:true),
    (name:'form6brief';      ident:true),
    (name:'formokbv';        ident:true),
    (name:'verinfo';         ident:true),
    (name:'verchanges';      ident:true),
    (name:'users';           ident:true)
  );

function LinesInFile(fname: string): Integer;
var F: TextFile; s: string;
begin
  Result := 0;
  try
    AssignFile(F,fname);
    Reset(F);
    while not eof(F) do begin
      ReadLn(F,s);
      Result := Result + 1;
    end;
  except
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  fBreak := false;
  PC.ActivePageIndex := 0;
end;

procedure TfmMain.actDummyExecute(Sender: TObject);
begin
  asm nop end;
end;

procedure TfmMain.btnNextClick(Sender: TObject);
begin
// check of setted params
  case PC.ActivePageIndex of
    1: begin
    // check db options
         if Trim(cbNameServ.Text)=EmptyStr then begin
           cbNameServ.SetFocus;
           RMessageDlg('Не указано имя MS-SQL сервера!',mtError,[mbOk],0);
           Exit;
         end;
         if rbUserSQL.Checked and (edUserName.Text=EmptyStr) then begin
           edUserName.SetFocus;
           RMessageDlg('Не указан логин учетной записи MS-SQL сервера!',mtError,[mbOk],0);
           Exit;
         end;
         if cbDatabase.ItemIndex<2 then begin
           cbDatabase.SetFocus;
           RMessageDlg('Не указана база данных на MS-SQL сервера!',mtError,[mbOk],0);
           Exit;
         end;
       end;
    2: begin
    // check local settings
        if edMinAddr.Text=EmptyStr then begin
          edMinAddr.SetFocus;
          RMessageDlg('Не задано начало диапазона кодов адреса!',mtError,[mbOk],0);
          Exit;
        end;
        if edMaxAddr.Text=EmptyStr then begin
          edMaxAddr.SetFocus;
          RMessageDlg('Не задано конец диапазона кодов адреса!',mtError,[mbOk],0);
          Exit;
        end;
        if StrToInt(edMinAddr.Text)>StrToInt(edMaxAddr.Text) then begin
          edMaxAddr.SetFocus;
          RMessageDlg('Неверно задан диапазон кодов адреса!',mtError,[mbOk],0);
          Exit;
        end;
        if edMinDoc.Text=EmptyStr then begin
          edMinDoc.SetFocus;
          RMessageDlg('Не задано начало диапазона кодов документа!',mtError,[mbOk],0);
          Exit;
        end;
        if edMaxDoc.Text=EmptyStr then begin
          edMaxDoc.SetFocus;
          RMessageDlg('Не задано конец диапазона кодов документа!',mtError,[mbOk],0);
          Exit;
        end;
        if StrToInt(edMinDoc.Text)>StrToInt(edMaxDoc.Text) then begin
          edMaxDoc.SetFocus;
          RMessageDlg('Неверно задан диапазон кодов документа!',mtError,[mbOk],0);
          Exit;
        end;
       end;
  end;
  if PC.ActivePageIndex=1 then PC.ActivePageIndex := 4
  else
    PC.ActivePageIndex := PC.ActivePageIndex + 1;
end;

procedure TfmMain.btnPrevClick(Sender: TObject);
begin
  PC.ActivePageIndex := IfThen(PC.ActivePage=tshGo, 1, PC.ActivePageIndex - 1);
  btnNext.Caption    := 'Далее >>';
end;

procedure TfmMain.btnBreakClick(Sender: TObject);
begin
  if btnNext.Enabled then begin
    fBreak := RMessageDlg('Выйти из программы установки?',mtConfirmation,[mbYes,mbNo],0)=mrYes;
    if fBreak and btnNext.Enabled then Close;
  end
  else
    if not fBreak then
      fBreak := RMessageDlg('Прервать процесс установки?',mtConfirmation,[mbYes,mbNo],0)=mrYes;
end;

procedure TfmMain.tshInfoShow(Sender: TObject);
begin
  btnPrev.Enabled := false;
  btnNext.Enabled := true;
  btnBreak.Enabled := true;
end;

procedure TfmMain.btnInfoClick(Sender: TObject);
begin
  ShellExecute(0,nil,PChar(ExtractFilePath(Application.ExeName)+'setup.rtf'),nil,nil,SW_SHOWDEFAULT);
end;

procedure TfmMain.tshServerShow(Sender: TObject);
begin
  btnPrev.Enabled := true;
  btnNext.Enabled := true;
  btnBreak.Enabled := true;
end;

procedure TfmMain.cbNameServDropDown(Sender: TObject);
var oApp:OleVariant;i,j:Integer;
begin
 if cbNameServ.Items.Count>0 then Exit;
 try
   oApp:=CreateOleObject('SQLDMO.Application');
   for i:=1 to oApp.ServerGroups.Count do
   begin
     for j:=1 to oApp.ServerGroups.item(i).RegisteredServers.Count do
     begin
       cbNameServ.Items.Add
        (oApp.ServerGroups.item(i).RegisteredServers.Item(j).Name);
     end;
   end;
   oApp:=Unassigned;
 except
 end;
end;

procedure TfmMain.rbUSerSQLClick(Sender: TObject);
begin
  edUserName.Enabled := rbUserSQL.Checked;
  if rbUserSQL.Checked then
    edUserName.Color := clWindow
  else
    edUserName.Color := clBtnFace;
  edPassword.Enabled := edUserName.Enabled;
  edPassword.Color := edUserName.Color;
end;

procedure TfmMain.cbDataBaseDropDown(Sender: TObject);
begin
  if cbDatabase.Items.Count>0 then Exit;
  try
    qrDbList.ConnectionString :=
      MakeConnStr(cbNameServ.Text,'master',rbUserNT.Checked,edUserName.Text,edPassword.Text,true);
    Screen.Cursor := crHourGlass;
    try    qrDBList.Open;
    finally Screen.Cursor := crDefault;
    end;
    cbDatabase.Items.Add('<обновить список>');
    cbDatabase.Items.Add('<новая база данных>');
    while not qrDBList.EOF do begin
      cbDataBase.Items.Add(qrDBList.Fields[0].AsString);
      qrDBList.Next;
    end;
  except
    RMessageDlg('Ошибка при подключении к указанному серверу!'+#13+
      'Проверьте правилность указания имени сервера и способа аутентификации...',
      mtError,[mbOk],0);
  end;
  if qrDBList.Active then qrDBList.Close;
end;

procedure TfmMain.cbDataBaseChange(Sender: TObject);
var new_db:  string;
begin
  case cbDatabase.ItemIndex of
    0: begin
    //refresh db-list
        cbDatabase.Items.Clear;
        cbDatabase.OnDropDown(cbDatabase);
       end;
    1: begin
    //creating new database
         if CreateDB(
            MakeConnStr(cbNameServ.Text,'master',rbUserNT.Checked,edUserName.Text,edPassword.Text,true),
            new_db) then
         begin
           cbDatabase.Items.Clear;
           cbDatabase.OnDropDown(cbDatabase);
           cbDatabase.ItemIndex := cbDatabase.Items.IndexOf(new_db);

         end;
       end;
  end;
end;

procedure TfmMain.btnChkConnectClick(Sender: TObject);
begin
  with TADOConnection.Create(Self) do begin
    ConnectionString :=
      MakeConnStr(cbNameServ.Text,cbDataBase.Text,rbUserNT.Checked,edUserName.Text,edPassword.Text,true);
    LoginPrompt := false;
    try
      Connected := true;
      RMessageDlg('Проверка подключения успешно завершена!',mtInformation,[mbOk],0);
    except
      RMessageDlg('Ошибка при подключении к указанной базе данных!',mtError,[mbOk],0);
    end;
    Free;
  end;
end;

procedure TfmMain.tshCompShow(Sender: TObject);
begin
  btnNext.Caption := 'Далее >>';
  rbTypical.OnClick(rbTypical);
end;

procedure TfmMain.rbTypicalClick(Sender: TObject);
var i: Integer;
begin
  pnlCustom.Visible := rbCustom.Checked;
  lbxCustom.Checked[0] := true;
  lbxCustom.ItemEnabled[0] := false;
  lbxCustom.Checked[1] := true;
  lbxCustom.ItemEnabled[1] := false;
  if rbTypical.Checked then
    for i:=1 to lbxCustom.Items.Count-1 do
      lbxCustom.Checked[i] := true;
end;


procedure TfmMain.tshShowParamsShow(Sender: TObject);
//var i: Integer;
begin
  btnNext.Caption := 'Готово';
  mmParams.Lines.Clear;
//db options
  mmParams.Lines.Add('Параметры подключения:');
  mmParams.Lines.Add('    SQL-сервер: '+cbNameServ.Text);
  if rbUserNT.Checked then
    mmParams.Lines.Add('    Аутентификация: Пользователь Windows NT')
  else
    mmParams.Lines.Add('    Аутентификация: Пользователь "'+edUserName.Text+'"');
  mmParams.Lines.Add('    База данных: '+cbDataBase.Text);
//local settings
{  mmParams.Lines.Add('Параметры локализации БД:');
  mmParams.Lines.Add('    Диапазон кода адреса: '+edMinAddr.Text+' - '+edMaxAddr.Text);
  mmParams.Lines.Add('    Диапазон кода документа: '+edMinDoc.Text+' - '+edMaxDoc.Text);
  if rbAutoNumb.Checked then
    mmParams.Lines.Add('    № объекта на кадастровом участке: использовать автонумерацию')
  else
    mmParams.Lines.Add('    № объекта на кадастровом участке: использовать УНОМ');
  if rbAdrFree.Checked then
    mmParams.Lines.Add('    Взаимодействие с буфером БД ЖНФ: не использовать')
  else
  if rbAdrUNOM.Checked then
    mmParams.Lines.Add('    Взаимодействие с буфером БД ЖНФ: искать по УНОМ')
  else
  if rbAdrUNOM.Checked then
    mmParams.Lines.Add('    Взаимодействие с буфером БД ЖНФ: искать по адресу');
//install type
  if rbTypical.Checked then
    mmParams.Lines.Add('Тип установки: обычная')
  else
    mmParams.Lines.Add('Тип установки: выборочная');
  mmParams.Lines.Add('Состав установки:');
  for i:=0 to lbxCustom.Items.Count-1 do
    if lbxCustom.Checked[i] then
      mmParams.Lines.Add('    '+lbxCustom.Items[i]);}
end;

procedure TfmMain.tshGoShow(Sender: TObject);
begin
  btnPrev.Visible := false;
  btnNext.Visible := false;
  tmGo.Enabled := true;
end;

procedure TfmMain.tmGoTimer(Sender: TObject);
begin
  tmGo.Enabled := false;
  lbAct.Caption := 'Подключение к БД...';
  Update;
  dbMain.Connected := false;
  dbMain.ConnectionString :=
      MakeConnStr(cbNameServ.Text,cbDataBase.Text,rbUserNT.Checked,edUserName.Text,edPassword.Text,true);
  try
    dbMain.Connected := true;
  except
    RMessageDlg('Ошибка при подключении к БД!'+#13+
      'Возможно неверно указаны параметры БД или аутентификации...',
       mtError,[mbOk],0);
    fBreak := true;
    Close;
    Exit;
  end;
//install crypt engine
  DoInstallCrypt;
  if DoMakeBDObjects then
//    if DoSetLocals then //???
      if DoSetBase then
//        if DoSetOMK then
//          if DoSetFKUN then
//            if DoSetGIS then
              RMessageDlg('Установка успешно завершена!',mtInformation,[mbOk],0);
  Close;
end;

function TfmMain.DoMakeBDObjects: boolean;
var ss: TStringStream;
    fs: TFileStream;
    s : string;
    n : Integer;
begin
  pbCur.Position := 0;
  lbAct.Caption := 'Создание объектов БД...';
  Result := false;
  fs := nil;
  try
    fs := TFileStream.Create(ExtractFilePath(Application.ExeName)+'base.sql',fmOpenRead);
  except
    if fs<>nil then fs.Free;
    RMessageDlg('Ошибка в дистрибутиве программы установки: не найден файл "base.sql".',
      mtError,[mbOk],0);
    Exit;
  end;
  ss := TStringStream.Create(EmptyStr);
  fs.Position := 0;
  ss.CopyFrom(fs,fs.Size);
  fs.Free;
  s := ss.DataString;
  pbCur.Max := 0;
  while true do begin
    n := Pos('GO'#13#10,s);
    if n=0 then break;
    pbCur.Max := pbCur.Max + 1;
    s := Copy(s,n+4,Length(s));
  end;
  s := StringReplace(ss.DataString,'GranVUS2',cbDatabase.Text,[rfReplaceAll,rfIgnoreCase]);
  ss.Free;
  while s<>EmptyStr do begin
    n := PosEx('GO'#13#10,s);
    if n=0 then break;
    qry.SQL.Text := Copy(s,1,n-1);
    s := Copy(s,n+4,Length(s));
    try   qry.ExecSQL;
    except
      on E: Exception do begin
        RMessageDlg('Ошибка при выполнении команды SQL!',mtError,[mbOk],0);
        if SameText(ParamStr(1),'/ShowExceptionInfo') then
          ShowMessage(E.Message +#13#10+ qry.SQL.Text);
        Exit;
      end;
    end;
    pbCur.StepIt;
    Application.ProcessMessages;
    if fBreak then Exit;
  end;
  pbMain.StepIt;
  Result := true;
end;

function TfmMain.FillTable(tbl_name: string; disable_identity: boolean; move_pb: boolean=false): boolean;
  procedure SetIdentityInsertTo(val: string);
  begin
    qry.SQL.Text := 'SET IDENTITY_INSERT '+tbl_name+' '+val;
    try  qry.ExecSQL;
    except
    end;
  end;
var
  i,j: Integer;
  F, header,data: TStringList;
begin
  Result := false;
  lbAct.Caption :=
    Copy(lbAct.Caption,1,Pos(':',lbAct.Caption)-1)+': '+AnsiUpperCase(tbl_name);
  Update;
  F      := TStringList.Create;
  header := TStringList.Create;
  data   := TStringList.Create;
  try //finally free
    try //except
      F.Clear;
      F.LoadFromFile(ExtractFilePath(Application.ExeName)+tbl_name+'.csv');
      header.CommaText := F.Strings[0];
      with TADOQuery.Create(Self) do
      try
        if disable_identity then SetIdentityInsertTo('ON');

        Connection := dbMain;
        SQL.Text := Format('SELECT %s FROM %s WHERE 1=0',[F[0], tbl_name]);
        Open;
        for I := 0 to Fields.Count-1 do header.Objects[I] := TObject(Fields[I].DataType);
        Close;
        SQL.Text := Format('INSERT INTO %s (%s) SELECT %s',
          [tbl_name, F[0], ':'+StringReplace(F[0],',',',:',[rfReplaceAll])]);
        Parameters.ParseSQL(SQL.Text,true);
        for I := 0 to Parameters.Count-1 do
          Parameters[I].DataType := TFieldtype(header.Objects[I]);
        if move_pb then pbCur.StepIt;

        for I := 1 to F.Count-1 do begin
          Application.ProcessMessages;
          if fBreak then begin
            Free;
            Exit;
          end;

          data.CommaText := F[I];
          for J:=0 to data.Count-1 do
          if data[J]=EmptyStr
            then Parameters[J].Value := NULL
            else Parameters[J].Value := data[j];
          ExecSQL;
          if move_pb then pbCur.StepIt;
        end;//for
      finally
        Free; //quiery
        if disable_identity then SetIdentityInsertTo('OFF');
      end;
      if not move_pb then pbCur.StepIt;
      Result := true;
    except
      on E: Exception do begin
        if SameText(ParamStr(1),'/ShowExceptionInfo') then
          ShowMessage(tbl_name+#13#10+E.Message+#13#10+data.Text);
        RMessageDlg('Ошибка при загрузке данных!',mtError,[mbOk],0);
      end;
    end;
  finally
    F.Free;
    header.Free;
    data.Free;
  end;
end;

function TfmMain.DoSetBase: boolean;
var i: Integer;
begin
  Result := false;
  lbAct.Caption := 'Наполнение базовых справочников:';
  pbCur.Position := 0;
  pbCur.Max := High(base_data)+1;
  Update;
  for i:=0 to High(base_data) do
    if not FillTable(base_data[i].name,base_data[i].ident) then Exit;
  pbMain.StepIt;
  Result := true;
end;

procedure TfmMain.DoInstallCrypt;
var
  path, src, edition, master: string;
begin
  if UpperCase(cbNameServ.Text)='(LOCAL)' then
    with TADOQuery.Create(Self) do
    try
      Connection := dbMain;
      try
        SQL.Text :=
          'select * from master..sysobjects where name like ''xp_crypt_%'' ';
        Open;
        if IsEmpty then begin
          Close;
          SQL.Text := 'select SERVERPROPERTY(''Edition'')';
          Open;
          edition := Fields[0].AsString;
          Close;
          master := 'master..';
          SQL.Text :=
            'select * from master..sysobjects where name = ''sp_MSget_setup_paths'' ';
          Open;
          if IsEmpty then begin
            Close;
            master := '';
            SQL.Text :=
              'select * from sysobjects where name = ''sp_MSget_setup_paths'' ';
            Open;
            if IsEmpty then begin
              Close;
              SQL.Text := mStoredProc.Lines.Text;
              ExecSQL;
            end else
              Close;
          end;
          SQL.Text :=
            'DECLARE @sql_path VARCHAR(260), @data_path VARCHAR(260)'#13+
            'exec '+master+'sp_MSget_setup_paths @sql_path OUTPUT, @data_path OUTPUT'#13+
            'select @sql_path + ''\Binn'' as bin_path';
          Open;
          path := Fields[0].AsString;
          src := ExtractFilePath(Application.ExeName)+'\';
          if Pos('64', edition) > 0 then
            src := src + 'grcrypt64.dll'
          else
            src := src + 'grcrypt.dll';
          if not CopyFile(
              PChar(src),
              PChar(path+'\grcrypt.dll'),false) then
            raise Exception.Create('Файл библиотеки не был скопирован.');
          Close;
          SQL.Text :=
            'exec master..sp_addextendedproc ''xp_crypt_ver'',''grcrypt.dll'''#13+
            'exec master..sp_addextendedproc ''xp_crypt_prepare'',''grcrypt.dll'''#13+
            'exec master..sp_addextendedproc ''xp_crypt_add'',''grcrypt.dll'''#13+
            'exec master..sp_addextendedproc ''xp_crypt_remove'',''grcrypt.dll'''#13+
            'exec master..sp_addextendedproc ''xp_crypt_list'',''grcrypt.dll''';
          ExecSQL;
        end;
      except
        on E: Exception do
          RMessageDlg('Ошибка при установки системы контроля лицензий!'#13+
                       E.ClassName+': '+E.Message,mtError,[mbOk],0);
      end;
    finally
      Free;
    end
  else
    MessageDlg('Система контроля лицензий не будет установлена!'#13+
               'Установка возможна только на локально...',mtWarning,[mbOk],0); 
end;

end.

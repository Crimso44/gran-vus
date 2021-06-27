unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, dxBar, ActnList, ADOdb, ExtCtrls, StdCtrls, cxClasses, Spin,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter;

type
  TfmMain = class(TForm)
    StatBar: TStatusBar;
    alsMain: TActionList;
    actExportSubj: TAction;
    actImportOrg: TAction;
    actClose: TAction;
    dxBarManager1: TdxBarManager;
    dxBarSubItem1: TdxBarSubItem;
    dxBarSubItem2: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    dxBarButton4: TdxBarButton;
    dxBarButton6: TdxBarButton;
    actBaseLst: TAction;
    actSets: TAction;
    actConnect: TAction;
    actHelp: TAction;
    actAbout: TAction;
    dxsiBaseLst: TdxBarSubItem;
    dxBarButton7: TdxBarButton;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    actBaseLstExec: TAction;
    dxsiPlugIns: TdxBarSubItem;
    dxbReScan: TdxBarButton;
    actReScanPlugIns: TAction;
    actExecPlugIn: TAction;
    actConfigPlugIns: TAction;
    dxbCfgPlugIns: TdxBarButton;
    actOrgLst: TAction;
    dxBarButton11: TdxBarButton;
    actSubjList: TAction;
    dxBarButton2: TdxBarButton;
    actUserList: TAction;
    dxBarButton1: TdxBarButton;
    actImportSubj: TAction;
    actBackup: TAction;
    dxBarButton12: TdxBarButton;
    actExportOrg: TAction;
    dxBarButton13: TdxBarButton;
    actActivate: TAction;
    dxBarButton14: TdxBarButton;
    dxBarSubItem4: TdxBarSubItem;
    dxBarSubItem5: TdxBarSubItem;
    actEvents: TAction;
    dxBarButton15: TdxBarButton;
    actForm6Lst: TAction;
    dxBarButton16: TdxBarButton;
    actFormOtr: TAction;
    dxBarButton17: TdxBarButton;
    actGeneralQty: TAction;
    dxBarButton18: TdxBarButton;
    actCHECK_F6: TAction;
    dxBarButton19: TdxBarButton;
    actExportSPO: TAction;
    actImportSPO: TAction;
    dxBarButton20: TdxBarButton;
    actImport: TAction;
    actExport: TAction;
    dxBarSubItem6: TdxBarSubItem;
    dxBarSubItem7: TdxBarSubItem;
    dxBarButton3: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton21: TdxBarButton;
    actImportSPOOrg: TAction;
    dxBarButton22: TdxBarButton;
    actFormSobstv: TAction;
    dxBarButton23: TdxBarButton;
    aSecret: TAction;
    actFormVED: TAction;
    actFormFS: TAction;
    dxBarButton24: TdxBarButton;
    dxBarButton25: TdxBarButton;
    actCheckAll: TAction;
    dxBarButton26: TdxBarButton;
    actFormSVT: TAction;
    dxBarButton27: TdxBarButton;
    actFAnaliz: TAction;
    dxBarButton28: TdxBarButton;
    dxBBMore: TdxBarButton;
    dxBBLess: TdxBarButton;
    procedure FormShow(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actBaseLstExecute(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actBaseLstExecExecute(Sender: TObject);
    procedure actReScanPlugInsExecute(Sender: TObject);
    procedure actExecPlugInExecute(Sender: TObject);
    procedure actConfigPlugInsExecute(Sender: TObject);
    procedure actExportSubjExecute(Sender: TObject);
    procedure actImportOrgExecute(Sender: TObject);
    procedure actSetsExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actOrgLstExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actSubjListExecute(Sender: TObject);
    procedure actUserListExecute(Sender: TObject);
    procedure actImportSubjExecute(Sender: TObject);
    procedure ApplicationOnException(Sender: TObject; E: Exception);
    procedure actBackupExecute(Sender: TObject);
    procedure actExportOrgExecute(Sender: TObject);
    procedure actActivateExecute(Sender: TObject);
    procedure actEventsExecute(Sender: TObject);
    procedure actForm6LstExecute(Sender: TObject);
    procedure actFormOtrExecute(Sender: TObject);
    procedure actGeneralQtyExecute(Sender: TObject);
    procedure actCHECK_F6Execute(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actExportSPOExecute(Sender: TObject);
    procedure actImportSPOExecute(Sender: TObject);
    procedure actImportSPOOrgExecute(Sender: TObject);
    procedure actFormSobstvExecute(Sender: TObject);
    procedure aSecretExecute(Sender: TObject);
    procedure dxBarButton26Click(Sender: TObject);
    procedure actFormSVTExecute(Sender: TObject);
    procedure actFAnalizExecute(Sender: TObject);
    procedure dxBBMoreClick(Sender: TObject);
    procedure dxBBLessClick(Sender: TObject);
  private
    { Private declarations }
    fStarted: boolean;
    procedure ChkDateFormat;
  public
    { Public declarations }
    IsKopf_Changed_Exists: Boolean;
    IsOkved_Changed_Exists: Boolean;
    MainScale: Integer;
    procedure SetActions(HasConn: Boolean);
    procedure RefreshOrgs;
    procedure RefreshSubjs;
    procedure RescaleForms(scale: Integer);
  end;

var
  fmMain: TfmMain;

implementation

uses fAbout, msg, dMain, IniSupport, fBaseLst, fCfgPlugIns,
  fOrgLst, fKbdMouHk, fConfig, fSubjLst, fUsers, dberror, comobj, db, ShellAPI,
  exec, fOrgProp, SaveEvents, fEventList, Registry, fGeneralQty,
  fExportSPO, fImportSPO, fImportSPOOrg
  {SQLEDIT},InpDlg, AEMSQLEDIT{SQLEDIT}, uVERSION, WinHelpViewer;

{$R *.DFM}

procedure TfmMain.ChkDateFormat;
var buf: Array[0..1024] of char;
begin
  GetLocaleInfo(0,LOCALE_SSHORTDATE,buf,1024);
  if AnsiUpperCase(buf)<>'DD.MM.YYYY' then
    if not Confirm(
      'Заданный системный формат даты не совместим с приложением!'#13+
      'Требуемый формат "dd.MM.yyyy". Установить его?') then Application.Terminate
    else
      SetLocaleInfo(0,LOCALE_SSHORTDATE,'dd.MM.yyyy');
end;

procedure TfmMain.dxBarButton26Click(Sender: TObject);
var
  i: Integer;
begin
  if not dmMain.rEdit then begin
    ShowErr('Вы не обладаете правом на изменение статуса численных данных. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  with TADOQuery.Create(Self) do
  try
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'EXEC CHECK_ALL :SUBJ_ID';
    Parameters.ParseSQL(SQL.Text, True);
    i := dmMain.GetSubjID;
    Parameters[0].Value := i;
    ExecSQL;
    ShowMessage('Данные для ' + dmMain.GetSubjNameByID(i) + ' согласованы между собой. Расхождений не выявлено.');
  except
    on E: Exception do ShowMessage(E.Message);
  end;
  finally Free;
  end;
end;

procedure TfmMain.dxBBLessClick(Sender: TObject);
begin
  MainScale := Trunc(MainScale / 1.2);
  RescaleForms(83);
end;

procedure TfmMain.dxBBMoreClick(Sender: TObject);
begin
  MainScale := Trunc(MainScale * 1.2);
  RescaleForms(120);
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  if fStarted then Exit;
  fStarted := true;
  SplashPrepare;
  SplashMsg('Инициализация...');
  SplashMsg('Загрузка параметров...');
  SplashMsg('Загрузка внешних модулей...');
  actRescanPlugIns.Execute;
  SplashMsg('Подключение к источнику данных...');
  SetActions(dmMain.DoConnect);
  if dmMain.dbMain.Connected then EnableHook(dmMain.time_out);
  SplashMsg('Регистрация в системе...');
  SplashClose;
  ChkDateFormat;

  IsKopf_Changed_Exists := False;
  IsOkved_Changed_Exists := False;
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'Select 1 From Org Where KOPF_Changed = 1';
    Open;
    if not Eof then begin
      IsKopf_Changed_Exists := True;
      if Confirm(
        'Коды ОКОПФ некоторых организаций в картотеке был автоматически заменены '#13+
        'при переходе на новый классификатор и не прошли визуальной проверки на правильность. '#13+
        'Вам предлагается проделать эту проверку и при необходимости '#13+
        'выбрать правильные значения и произвести замену. '#13+
        'Приступить к просмотру карточек таких организаций?') then begin
          ShowOrgList(True, False);
      end;
    end;
    Close;

    if not IsKopf_Changed_Exists then begin
      SQL.Text := 'Select 1 From Org Where Okved_Changed = 1';
      Open;
      if not Eof then begin
        IsOkved_Changed_Exists := True;
        if Confirm(
          'Не все организации в картотеке прошли сверку кодов ОКВЭД. '#13+
          'Вам предлагается проделать эту проверку и при необходимости '#13+
          'выбрать правильные значения и произвести замену. '#13+
          'Приступить к просмотру карточек таких организаций?') then begin
            ShowOrgList(False, True);
        end;
      end;
    end;
  finally
    Free;
  end;


end;

procedure TfmMain.SetActions(HasConn: Boolean);
var i: Integer;
    dxb: TdxBarButton;
begin
  for i:=0 to ComponentCount-1 do
    if Components[i] is TAction then
      (Components[i] as TAction).Enabled :=
        (@(Components[i] as TAction).OnExecute<>nil) and
        (HasConn or (Components[i]=actClose) or (Components[i]=actConnect)
         or (Components[i]=actAbout) or (Components[i]=actHelp));

  for i:=0 to dxsiPlugIns.ItemLinks.Count-1 do
    dxsiPlugIns.ItemLinks[i].Item.Enabled := HasConn;
  dxsiBaseLst.ItemLinks.Clear;

  if HasConn then begin
    actUserList .Enabled:= GetLastUserID=1;
    actImport   .Enabled:= dmMain.rImport;
    actExport   .Enabled:= dmMain.rExport;
    actBackup   .Enabled:= dmMain.rAdmin;
    actEvents   .Enabled:= dmMain.rAdmin;

    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT * FROM KL_DATA';
      try
        Open;
        while not EOF do begin
          dxb := TdxBarButton.Create(Self);
          with dxb do begin
            Action := actBaseLstExec;
            Action := nil;
            Caption := FieldByName('DISP_NAME').AsString;
            Tag := FieldByName('KL_ID').AsInteger;
            if FieldByName('IS_EDIT').AsInteger=0 then ImageIndex := ImageIndex-1;
          end;
          dxsiBaseLst.ItemLinks.Add.Item := dxb;
          Next;
        end;
      except
        ShowErr('Ошибка при загрузке списка справочников!');
      end;
    finally Free;
    end;
  end;
end;

procedure TfmMain.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.actAboutExecute(Sender: TObject);
begin
  ShowAbout;
end;

procedure TfmMain.actBaseLstExecute(Sender: TObject);
begin
// dummy
end;

procedure TfmMain.actConnectExecute(Sender: TObject);
var s: string;
    i,n: Integer;
begin
  DisableHook;
  s := ADOdb.PromptDataSource(Application.Handle,dmMain.dbMain.ConnectionString);
  if (s<>dmMain.dbMain.ConnectionString) or not dmMain.dbMain.Connected then begin
    n := 0;
    for i:=0 to Application.ComponentCount-1 do
      if Application.Components[i] is TForm then Inc(n);
    if n>1 then
      ShowInfo('Перез изменением настроек подключения все открытые формы будут закрыты!');
    for i:=Application.ComponentCount-1 downto 0 do
      if Application.Components[i] is TForm then
        if Application.Components[i]<>Self then
          (Application.Components[i] as TForm).Close;
    Application.ProcessMessages;
    if dmMain.dbMain.Connected then
      SaveEvent(dmMain.dbMain, evs_Logout,'',['Причина: изменение настроек соединения.']);
    dmMain.dbMain.Connected :=false;
    dmMain.dbMain.ConnectionString := s;
    dmMain.rImport := False;
    dmMain.rExport := False;
    dmMain.rPrint  := False;
    dmMain.rEdit   := False;
    with TRegistryIniFile.Create('Software\Granit\GranVus2') do
    try
      WriteInteger('Login','UID',0);
    finally Free;
    end;
    IniSupport.StoreConnAttr(dmMain.dbMain);
    SetActions(dmMain.DoConnect);
    if dmMain.dbMain.Connected then EnableHook(dmMain.time_out);
  end;
end;

procedure TfmMain.actBaseLstExecExecute(Sender: TObject);
begin
  EditBaseLst((Sender as TComponent).Tag);
end;

procedure TfmMain.actReScanPlugInsExecute(Sender: TObject);
var i: Integer;
    dxb: TdxBarButton;
    sl: TStringList;
begin
  dxsiPlugIns.ItemLinks.Clear;
  dmMain.ScanPlugIns;
  sl := TStringList.Create;
  for i:=0 to dmMain.slPlugIns.Count-1 do begin
  // имя_dll,имя_плагина,копирайт,тип,image_index
    dxb := TdxBarButton.Create(Self);
    dxb.Action := actExecPlugIn;
    dxb.Action := nil;
    dxb.Tag := i;
    sl.CommaText := dmMain.slPlugIns[i];
    dxb.Caption := sl[1];
    dxb.ImageIndex := StrToInt(sl[4]);
    dxsiPlugIns.ItemLinks.Add.Item := dxb;
  end;
  sl.Free;
  dxb := TdxBarButton.Create(Self);
  dxb.Action := actReScanPlugIns;
  dxsiPlugIns.ItemLinks.Add.Item := dxb;
  dxsiPlugIns.ItemLinks[dxsiPlugIns.ItemLinks.Count-1].BeginGroup := true;
//  dxb := TdxBarButton.Create(Self);
//  dxb.Action := actConfigPlugIns;
//  dxsiPlugIns.ItemLinks.Add.Item := dxb;
//  dxsiPlugIns.ItemLinks[dxsiPlugIns.ItemLinks.Count-1].BeginGroup := false;
end;

procedure TfmMain.actExecPlugInExecute(Sender: TObject);
var sl: TStringList;
    fnExec: Pointer;
    hDll: THandle;
begin
  if not dmMain.rPrint then begin
    ShowErr('Вы не обладаете правом на печать документов. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  sl := TStringList.Create;
  sl.CommaText := dmMain.slPlugIns[(Sender as TdxBarButton).Tag];
  // имя_dll,имя_плагина,копирайт,тип,image_index
  hDll := LoadLibrary(PChar(sl[0]));
  if hDll=0 then ShowErr('Ошибка при загрузке плагина: '+#13+sl[0])
  else begin
    fnExec := GetProcAddress(hDll,'PlugInExec');
    if fnExec=nil then ShowErr('Неверный формат плагина: '+#13+sl[0])
    else begin
      case StrToInt(sl[3]) of
      0: begin
        TPlugInExecMain(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject);
      end;
      1: begin
        if dmMain.GetOrgID > 0 then begin
          TPlugInExecOrg(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetOrgID);
          RefreshOrgs;
        end;
      end;
      3: begin
        if dmMain.GetF6ID > 0 then begin
          TPlugInExecF6(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetF6ID);
          dmMain.UpdateCurrentOKBV;
          RefreshOrgs;
        end;
      end;
      5: begin
        if dmMain.GetSubjID > 0 then begin
          TPlugInExecSubj(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetSubjID);
          RefreshSubjs;
        end;
      end;
      end;
    end;
    FreeLibrary(hDll);
  end;
  sl.Free;
end;

procedure TfmMain.actConfigPlugInsExecute(Sender: TObject);
begin
  ConfigPlugIns;
end;

procedure TfmMain.actExportSubjExecute(Sender: TObject);
var hDLL: Cardinal;
    fn  : TPlugInExecMain;
begin
  if not dmMain.rExport then begin
    ShowErr('Вы не обладаете правом на операцию экспорта данных. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  hDLL := LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+'expdata.dll'));
  if hDLL=0 then begin
    SaveEvent(dmMain.dbMain, evs_Export_Failed, '', [
      'Не найден требуемый модуль "expdata.dll".',
      ExtractFilePath(Application.ExeName)+'expdata.dll']);
    ShowErr('Не найден требуемый модуль "expdata.dll"!')
  end
  else begin
    @fn := GetProcAddress(hDLL,'ExportSubjData');
    if @fn=nil then begin
      SaveEvent(dmMain.dbMain, evs_Export_Failed, '', [
        'Найденный модуль "expdata.dll" имеет неверный формат.',
        ExtractFilePath(Application.ExeName)+'expdata.dll']);
      ShowErr('Найденный модуль "expdata.dll" имеет неверный формат!')
    end
    else
      fn(Application.Handle,dmMain.dbMain.ConnectionObject);
    FreeLibrary(hDLL);
  end;
end;

procedure TfmMain.actImportOrgExecute(Sender: TObject);
var hDLL: Cardinal;
    fn  : TPlugInExecMain;
    res: Integer;
begin
  if (not dmMain.rImport) or (dmMain.IsDemoMode) then begin
    ShowErr('Вы не обладаете правом на операцию импорта данных. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  res := 0;
  hDLL := LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+'expdata.dll'));
  if hDLL=0 then begin
    SaveEvent(dmMain.dbMain, evs_Import_Failed, '', [
      'Не найден требуемый модуль "expdata.dll".',
      ExtractFilePath(Application.ExeName)+'expdata.dll']);
    ShowErr('Не найден требуемый модуль "expdata.dll"!')
  end
  else begin
    @fn := GetProcAddress(hDLL,'ImportOrgData');
    if @fn=nil then begin
      SaveEvent(dmMain.dbMain, evs_Import_Failed, '', [
        'Найденный модуль "expdata.dll" имеет неверный формат.',
        ExtractFilePath(Application.ExeName)+'expdata.dll']);
      ShowErr('Найденный модуль "expdata.dll" имеет неверный формат!')
    end
    else
      res := fn(Application.Handle,dmMain.dbMain.ConnectionObject);
    FreeLibrary(hDLL);
  end;
  if res>0 then
    ShowOrgCard(res);
end;

procedure TfmMain.actSetsExecute(Sender: TObject);
begin
  ConfigDlg;
end;

procedure TfmMain.actHelpExecute(Sender: TObject);
begin
  //Application.HelpContext(HelpContext);
  ShellExecute(0,'open',PChar(ExtractFilePath(Application.ExeName)+'Руководство пользователя Гран-Бронирование.doc'),nil,nil,SW_NORMAL);
end;

procedure TfmMain.actOrgLstExecute(Sender: TObject);
begin
  ShowOrgList(False, False);
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  MainScale := 100;
  Caption := Caption + sVersion;
  fStarted := false;
  Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
  Application.OnException:= ApplicationOnException;
end;

procedure TfmMain.RescaleForms(scale: Integer);
var
  i: Integer;
begin
  for i := 0 to Application.ComponentCount-1 do
    if (Application.Components[i] is TForm) and (Application.Components[i] <> fmMain) then begin
      TForm(Application.Components[i]).ScaleBy(scale, 100);
    end;
end;


procedure TfmMain.FormDestroy(Sender: TObject);
begin
//  Application.HelpCommand(HELP_QUIT,0);
  DisableHook;
//delete temp data
  ShellExecute(0,nil,'command.com',PChar('/c del '+ExtractFilePath(Application.ExeName)+'~*.tmp'),nil,SW_HIDE);
end;

procedure TfmMain.actSubjListExecute(Sender: TObject);
begin
  ShowSubjList;
end;

procedure TfmMain.actUserListExecute(Sender: TObject);
begin
  fUsers.Execute;
end;

procedure TfmMain.actImportSubjExecute(Sender: TObject);
var hDLL: Cardinal;
    fn  : TPlugInExecMain;
begin
  if (not dmMain.rImport) or (dmMain.IsDemoMode) then begin
    ShowErr('Вы не обладаете правом на операцию импорта данных. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  hDLL := LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+'expdata.dll'));
  if hDLL=0 then begin
    SaveEvent(dmMain.dbMain, evs_Import_Failed, '', [
      'Не найден требуемый модуль "expdata.dll".',
      ExtractFilePath(Application.ExeName)+'expdata.dll']);
    ShowErr('Не найден требуемый модуль "expdata.dll"!')
  end
  else begin
    @fn := GetProcAddress(hDLL,'ImportSubjData');
    if @fn=nil then begin
      SaveEvent(dmMain.dbMain, evs_Import_Failed, '', [
        'Найденный модуль "expdata.dll" имеет неверный формат.',
        ExtractFilePath(Application.ExeName)+'expdata.dll']);
      ShowErr('Найденный модуль "expdata.dll" имеет неверный формат!')
    end
    else
      fn(Application.Handle,dmMain.dbMain.ConnectionObject);
    FreeLibrary(hDLL);
  end;
end;

procedure TfmMain.ApplicationOnException(Sender: TObject; E: Exception);
begin
  if ((E is EOleException) or
     (E is EDatabaseError)) and (dmMain.dbMain.Errors.Count > 0) then
    ShowDBErrorDlg(dmMain.dbMain.Errors, E.Message)
  else
    Application.ShowException(E);
end;

procedure TfmMain.RefreshOrgs;
var i: Integer;
begin
  for i:=0 to Application.ComponentCount-1 do
    if Application.Components[i] is TfmOrgList then
      (Application.Components[i] as TfmOrgList).actRefresh.Execute;
end;

procedure TfmMain.RefreshSubjs;
var i: Integer;
begin
  for i:=0 to Application.ComponentCount-1 do
    if Application.Components[i] is TfmSubjList then
      (Application.Components[i] as TfmSubjList).actRefresh.Execute;
end;

procedure TfmMain.actBackupExecute(Sender: TObject);
  function GetParam(par_name: string): string;
  var n: Integer;
  begin
    n := Pos(UpperCase(par_name)+'=',UpperCase(dmMain.dbMain.ConnectionString));
    if n=0 then Result := EmptyStr
    else begin
      Result := Copy(dmMain.dbMain.ConnectionString,n+Length(par_name)+1,1000);
      n := Pos(';',Result);
      if n>0 then Result := Copy(Result,1,n-1);
    end;
  end;
var server,database,user,psw,s: string;
begin
  if not Confirm(
    'Внимание! Перед запуском мастера резирвирования'#13+
    'будет завершена работа с приложением.'#13+
    'Продолжить выполнение?') then Exit;
//getting parameters
  server := GetParam('Data Source');
  database := GetParam('Initial Catalog');
  user := GetParam('User ID');
  psw := GetParam('Password');
  s := UpperCase(GetParam('Persist Security Info'));
  if s='FALSE' then
    s := '"'+server+'" "'+database+'"'
  else
    s := '"'+server+'" "'+database+'" "'+user+'" "'+psw+'"';
  if ShellExecute(0,nil,
      PChar(ExtractFilePath(Application.ExeName)+'sqlbkup.exe'),
      PChar(s),
      nil,SW_SHOWDEFAULT)<=32 then
  begin
    ShowErr('Ошибка при запуске внешнего модуля "sqlbkup.exe"!'#13+
            'Возможно модуль отсутствует в системе...');
    Exit;
  end;
  dmMain.dbMain.Connected := false;
  Application.Terminate;
end;

procedure TfmMain.actExportOrgExecute(Sender: TObject);
var hDLL: Cardinal;
    fn  : TPlugInExecOrg;
    org_id: Integer;
begin
  if not dmMain.rExport then begin
    ShowErr('Вы не обладаете правом на операцию экспорта данных. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  org_id := dmMain.GetOrgID;
  if org_id<=0 then Exit;
  hDLL := LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+'expdata.dll'));
  if hDLL=0 then begin
    SaveEvent(dmMain.dbMain, evs_Export_Failed, '', [
      'Не найден требуемый модуль "expdata.dll".',
      ExtractFilePath(Application.ExeName)+'expdata.dll']);
    ShowErr('Не найден требуемый модуль "expdata.dll"!')
  end
  else begin
    @fn := GetProcAddress(hDLL,'ExportOrgData');
    if @fn=nil then begin
      SaveEvent(dmMain.dbMain, evs_Export_Failed, '', [
        'Найденный модуль "expdata.dll" имеет неверный формат.',
        ExtractFilePath(Application.ExeName)+'expdata.dll']);
      ShowErr('Найденный модуль "expdata.dll" имеет неверный формат!')
    end
    else
      fn(Application.Handle,dmMain.dbMain.ConnectionObject,org_id);
    FreeLibrary(hDLL);
  end;
end;

procedure TfmMain.actActivateExecute(Sender: TObject);
begin
  dmMain.ChkDemoMode(true);
  SetActions(dmMain.dbMain.Connected);
end;

procedure TfmMain.actEventsExecute(Sender: TObject);
begin
  fEventList.ShowEventList;
end;

procedure TfmMain.actFAnalizExecute(Sender: TObject);
var
  fnExec : Pointer;
  hDll   : THandle;
  lib    : string;
begin
//Анализ обеспеченности трудовыми ресурсами
  lib := 'FAnaliz.dll';
  hDll := LoadLibrary(PChar(IniSupport.GetPlugInsDir+lib));
  if hDll=0 then ShowErr('Ошибка при загрузке модуля "Анализ обеспеченности трудовыми ресурсами".')
  else begin
    fnExec := GetProcAddress(hDll,'PlugInExecForm');
    if fnExec=nil then ShowErr('Модуль "Анализ обеспеченности трудовыми ресурсами" имеет неверный формат.')
    else begin
      if dmMain.GetSubjID > 0 then begin
        TPlugInExecSubj(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetSubjID);
        RefreshSubjs;
      end;
    end;
    FreeLibrary(hDll);
  end;
end;

procedure TfmMain.actForm6LstExecute(Sender: TObject);
var
  fnExec : Pointer;
  hDll   : THandle;
begin
//Формы № 6 ВУО
  hDll := LoadLibrary(PChar(IniSupport.GetPlugInsDir+'form6lst.dll'));
  if hDll=0 then ShowErr('Ошибка при загрузке модуля "Формы № 6 ВУО".')
  else begin
    fnExec := GetProcAddress(hDll,'PlugInExecForm');
    if fnExec=nil then ShowErr('Модуль "Формы № 6 ВУО" имеет неверный формат.')
    else begin
      if dmMain.GetSubjID > 0 then begin
        TPlugInExecSubj(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetSubjID);
        RefreshSubjs;
      end;
    end;
    FreeLibrary(hDll);
  end;
end;

procedure TfmMain.actFormOtrExecute(Sender: TObject);
var
  fnExec : Pointer;
  hDll   : THandle;
  lib    : string;
begin
//была Форма по отраслям, стала - по видам экономической деятельности
  if Sender = actFormVED then lib := 'FormVED.dll' else lib := 'formotr.dll';
  hDll := LoadLibrary(PChar(IniSupport.GetPlugInsDir+lib));
  if hDll=0 then ShowErr('Ошибка при загрузке модуля "Форма по ВЭД".')
  else begin
    fnExec := GetProcAddress(hDll,'PlugInExecForm');
    if fnExec=nil then ShowErr('Модуль "Форма по ВЭД" имеет неверный формат.')
    else begin
      if dmMain.GetSubjID > 0 then begin
        TPlugInExecSubj(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetSubjID);
        RefreshSubjs;
      end;
    end;
    FreeLibrary(hDll);
  end;
end;

procedure TfmMain.actGeneralQtyExecute(Sender: TObject);
begin
  fGeneralQty.Execute;
end;

procedure TfmMain.actCHECK_F6Execute(Sender: TObject);
begin
  if not dmMain.rEdit then begin
    ShowErr('Вы не обладаете правом на изменение статуса численных данных. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'EXEC CHECK_F6';
    ExecSQL;
  finally Free;
  end;
  ShowMessage('Проверка выполнена.');
end;

procedure TfmMain.actImportExecute(Sender: TObject);
begin
//
end;

procedure TfmMain.actExportExecute(Sender: TObject);
begin
//
end;

procedure TfmMain.actExportSPOExecute(Sender: TObject);
var SubjID: Integer;
begin
  if not dmMain.rExport then begin
    ShowErr('Вы не обладаете правом на операцию экспорта данных. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  SubjID := dmMain.GetSubjID;  if SubjID <= 0 then Exit;
  fExportSPO.ExportSPO(SubjID);
end;

procedure TfmMain.actImportSPOExecute(Sender: TObject);
var SubjID: Integer;
begin
  if (not dmMain.rImport) or (dmMain.IsDemoMode) then begin
    ShowErr('Вы не обладаете правом на операцию импорта данных. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  SubjID := dmMain.GetSubjID;  if SubjID <= 0 then Exit;
  fImportSPO.ImportSPO(SubjID);
end;

procedure TfmMain.actImportSPOOrgExecute(Sender: TObject);
begin
  fImportSPOOrg.ImportSPOBron;
end;

procedure TfmMain.actFormSobstvExecute(Sender: TObject);
var
  fnExec : Pointer;
  hDll   : THandle;
  lib    : string;
begin
//Форма по видам собственности
  if Sender = actFormFS then lib := 'FormFS.dll' else lib := 'formsobst.dll';
  hDll := LoadLibrary(PChar(IniSupport.GetPlugInsDir+lib));
  if hDll=0 then ShowErr('Ошибка при загрузке модуля "Форма по видам собственности".')
  else begin
    fnExec := GetProcAddress(hDll,'PlugInExecForm');
    if fnExec=nil then ShowErr('Модуль "Форма по видам собственности" имеет неверный формат.')
    else begin
      if dmMain.GetSubjID > 0 then begin
        TPlugInExecSubj(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetSubjID);
        RefreshSubjs;
      end;
    end;
    FreeLibrary(hDll);
  end;
end;

procedure TfmMain.actFormSVTExecute(Sender: TObject);
var
  fnExec : Pointer;
  hDll   : THandle;
  lib    : string;
begin
//Форма по видам собственности
  lib := 'FormSVT.dll';
  hDll := LoadLibrary(PChar(IniSupport.GetPlugInsDir+lib));
  if hDll=0 then ShowErr('Ошибка при загрузке модуля "Сведения об использовании СВТ и СПО".')
  else begin
    fnExec := GetProcAddress(hDll,'PlugInExecForm');
    if fnExec=nil then ShowErr('Модуль "Сведения об использовании СВТ и СПО" имеет неверный формат.')
    else begin
      if dmMain.GetSubjID > 0 then begin
        TPlugInExecSubj(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetSubjID);
        RefreshSubjs;
      end;
    end;
    FreeLibrary(hDll);
  end;
end;

procedure TfmMain.aSecretExecute(Sender: TObject);
var
  pwd: string;
begin
  pwd := InputPassword('','');
  if pwd = 'ENTERSQL' then
     EditSQL(dmMain.dbMain, '', True, True, False);
end;

end.


unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, dxBar, ActnList, ADOdb, ExtCtrls, StdCtrls, dMain, Menus, cxClasses,
  ShellAPI,
  dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter,
  fParamDlg, fAsfMtr;

const
  WM_ShowInfo = WM_User+1;

type
  TfmMain = class(TForm)
    StatBar: TStatusBar;
    alsMain: TActionList;
    actOrgCard: TAction;
    actExport: TAction;
    actImport: TAction;
    actClose: TAction;
    dxBarManager1: TdxBarManager;
    dxbs0: TdxBarSubItem;
    dxBarSubItemAdmin: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    dxBarButton1: TdxBarButton;
    dxBarButton4: TdxBarButton;
    dxBarButton5: TdxBarButton;
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
    actPersonLst: TAction;
    dxBarButton11: TdxBarButton;
    actStoreData: TAction;
    dxBarButton2: TdxBarButton;
    actRestoreData: TAction;
    dxBarButton3: TdxBarButton;
    dxBarSubItemModules: TdxBarSubItem;
    actStaffListStored: TAction;
    dxBarButton12: TdxBarButton;
    actActivate: TAction;
    dxBarButton13: TdxBarButton;
    dxBarButton14: TdxBarButton;
    actEvents: TAction;
    actBronDol: TAction;
    dxBarButton15: TdxBarButton;
    dxBarInfoExchange: TdxBarSubItem;
    actUsers: TAction;
    dxBarButton16: TdxBarButton;
    actForm6: TAction;
    dxBarButton17: TdxBarButton;
    dxbs1: TdxBarSubItem;
    actStaffListRO: TAction;
    dxBarButton18: TdxBarButton;
    actSPOBronExport: TAction;
    dxBarButton19: TdxBarButton;
    aSecret: TAction;
    aBadDatesCheck: TAction;
    dxBarButton20: TdxBarButton;
    Button1: TButton;
    bbUpdate: TdxBarButton;
    bbHistory: TdxBarButton;
    aPersonChanges: TAction;
    dxBarButton21: TdxBarButton;
    actASStaffListStored: TAction;
    dxBarButton22: TdxBarButton;
    dxBarButton23: TdxBarButton;
    dxBarSubItem4: TdxBarSubItem;
    bbAsfMtr: TdxBarButton;
    actAsfMtrStaffList: TAction;
    bbAsfMtrList: TdxBarButton;
    dxsiASFLst: TdxBarSubItem;
    dxBarSubItem5: TdxBarSubItem;
    dxbs3: TdxBarSubItem;
    dxsiPlugInsASF: TdxBarSubItem;
    bForm6_2014: TdxBarButton;
    actForm6_2015: TAction;
    dxBarButton24: TdxBarButton;
    dxScalePlus: TdxBarButton;
    dxScaleMinus: TdxBarButton;
    dxBarSeparator1: TdxBarSeparator;
    dxBBMvkOrder: TdxBarButton;
    procedure aBadDatesCheckExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actAboutExecute(Sender: TObject);
    procedure actBaseLstExecute(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actBaseLstExecExecute(Sender: TObject);
    procedure actOrgCardExecute(Sender: TObject);
    procedure actReScanPlugInsExecute(Sender: TObject);
    procedure actExecPlugInExecute(Sender: TObject);
    procedure actConfigPlugInsExecute(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
    procedure actSetsExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actPersonLstExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actStoreDataExecute(Sender: TObject);
    procedure actRestoreDataExecute(Sender: TObject);
    procedure actStaffListStoredExecute(Sender: TObject);
    procedure actActivateExecute(Sender: TObject);
    procedure actEventsExecute(Sender: TObject);
    procedure actBronDolExecute(Sender: TObject);
    procedure actUsersExecute(Sender: TObject);
    procedure actForm6Execute(Sender: TObject);
    procedure actStaffListROExecute(Sender: TObject);
    procedure actSPOBronExportExecute(Sender: TObject);
    procedure aSecretExecute(Sender: TObject);
    procedure bbUpdateClick(Sender: TObject);
    procedure aPersonChangesExecute(Sender: TObject);
    procedure actASStaffListStoredExecute(Sender: TObject);
    procedure bbAsfMtrClick(Sender: TObject);
    procedure actAsfMtrStaffListExecute(Sender: TObject);
    procedure actForm6_2015Execute(Sender: TObject);
    procedure dxScalePlusClick(Sender: TObject);
    procedure dxScaleMinusClick(Sender: TObject);
  private
    { Private declarations }
    fStarted: boolean;
    procedure ChkDateFormat;
    procedure UpdateExtMenu;
    procedure CreateRepDir;
    procedure RescaleForms(scale: Integer);
  public
    { Public declarations }
    HideMenu: String;
    MainScale: Integer;
    procedure SetActions(HasConn: Boolean);
    procedure ShowReport(PlugInNum: Integer; Form26ID: Integer = -1);
    procedure OnShowInfo(var msg: TMessage); message WM_ShowInfo;
  end;

var
  fmMain: TfmMain;

implementation

uses fAbout, msg, IniSupport, fBaseLst, fOrgProp, fCfgPlugIns,
  fPersLst, fKbdMouHk, fConfig, fStaffList, fASStaffList, fAsfMtrList, fRegister, SaveEvents,
  fEventList, fUsers, fTPDP, dSPOBron, fMsgConfirm
  {SQLEDIT},InpDlg, AEMSQLEDIT{SQLEDIT}
  ,StrUtils, fSplashProgress, uVERSION, WinHelpViewer, SHFolder, uCrypt, fPersChangesLst;

procedure Go; stdcall; external 'backup.dll';

{$R *.DFM}

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
  if dmMain.GetParamValue(2) = '1' then begin
    SplashMsg('Проверка доступных обновлений...');
    bbUpdateClick(Self);
  end;
  SplashMsg('Регистрация в системе...');
  SplashClose;
  ChkDateFormat;
  CreateRepDir;
  PostMessage(Handle, WM_ShowInfo, 0, 0);
end;

procedure TfmMain.OnShowInfo(var msg: TMessage);
var
  q: TADOQuery;
begin
  q := TADOQuery.Create(Self);
  with q do try
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT * FROM Params Where Param_ID = 5';
    Open;
    if Eof or (FieldByName('Param_Value').AsString <> '1') then begin
      if ShowMessage('Код ОКОПФ Вашей организации был автоматически заменен при переходе на новый классификатор.'#13'Проверьте его правильность и при необходимости замените на правильное значение') then begin
        if Eof then begin
          Append;
          FieldByName('Param_Id').AsInteger := 5;
          FieldByName('Param_Name').AsString := 'Предупреждение ОКОПФ';
        end else
          Edit;
        FieldByName('Param_Value').AsString := '1';
        Post;
      end;
    end;
    Close;
    SQL.Text := 'SELECT HAS_BRON FROM ORG WHERE MyOrg = 1';
    Open;
    if Fields[0].AsBoolean then begin
      Close;
      SQL.Text := 'SELECT * FROM KPost WHERE KOKPDTR Is Null';
      Open;
      if not Eof then begin
        SQL.Text := 'SELECT * FROM Params Where Param_ID = 7';
        Open;
        if Eof or (FieldByName('Param_Value').AsString <> '1') then begin
          if ShowMessage('В справочнике должностей и профессии необходимо заполнить новые поля «Код по ОКПДТР»') then begin
            if Eof then begin
              Append;
              FieldByName('Param_Id').AsInteger := 7;
              FieldByName('Param_Name').AsString := 'Предупреждение ОКПДТР';
            end else
              Edit;
            FieldByName('Param_Value').AsString := '1';
            Post;
          end;
        end;
      end;
      Close;
    end;
    Close;
  finally
    Free;
  end;
end;

procedure TfmMain.RescaleForms(scale: Integer);
var
  i: Integer;
  frm: TForm;
begin
  for i := 0 to Application.ComponentCount-1 do
    if (Application.Components[i] is TForm) and (Application.Components[i] <> fmMain) then begin
      frm := TForm(Application.Components[i]);
      frm.ScaleBy(scale, 100);
      SendMessage(frm.Handle, WM_MOVE, 0, 0);
    end;
end;

procedure TfmMain.UpdateExtMenu;
var
  b: Boolean;
begin
  b := IniSupport.GetExtMenu;
  if b and dmMain.rAdmin
    then  dxBarSubItemModules.Visible := ivAlways
    else  dxBarSubItemModules.Visible := ivNever;
  actBronDol.Visible := b;
  actUsers.Visible := b and (dmMain.dbMain.Tag=1); // for ADMIN only
//  if dmMain.rAdmin
//    then  dxsiBaseLst.Visible := ivAlways
//    else  dxsiBaseLst.Visible := ivNever;
  actSets        .Visible := dmMain.rAdmin;
  actEvents      .Visible := dmMain.rAdmin;
  actStoreData   .Visible := dmMain.rAdmin;
  actRestoreData .Visible := dmMain.rAdmin;

  if dmMain.rPrint
    then begin
      if Pos('.2.', HideMenu) > 0 then
        dxsiPlugIns.Visible := ivNever
      else
        dxsiPlugIns.Visible := ivAlways;
      if Pos('.4.', HideMenu) > 0 then
        dxsiPlugInsASF.Visible := ivNever
      else
        dxsiPlugInsASF.Visible := ivAlways;
    end else begin
      dxsiPlugIns.Visible := ivNever;
      dxsiPlugInsASF.Visible := ivNever;
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
  for i:=0 to dxsiPlugInsASF.ItemLinks.Count-1 do
    dxsiPlugInsASF.ItemLinks[i].Item.Enabled := HasConn;
  dxsiBaseLst.ItemLinks.Clear;
  if HasConn then
    with TADOQuery.Create(Self) do begin
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT * FROM KL_DATA Where KL_ID <> 47 ORDER BY IS_ASF, DISP_NAME'; // Кроме Постановления МВК
      try
        Open;
        while not EOF do begin
          dxb := TdxBarButton.Create(Self);
          with dxb do begin
            Action := actBaseLstExec;
            Action := nil;
            Caption := FieldByName('DISP_NAME').AsString;
            Tag := FieldByName('KL_ID').AsInteger;
            if FieldByName('IS_EDIT').AsInteger < 0 then ImageIndex := 42 else
            if FieldByName('IS_EDIT').AsInteger > 0 then ImageIndex := 2 else
                                                         ImageIndex := 1;
          end;
          if FieldByName('IS_ASF').AsInteger = 0 then
            dxsiBaseLst.ItemLinks.Add.Item := dxb
          else
            dxsiASFLst.ItemLinks.Add.Item := dxb;
          Next;
        end;
        Close;
        SQL.Text := 'SELECT * FROM Params Where Param_Id = 4';
        Open;
        HideMenu := FieldByName('Param_Value').AsString;
        if Pos('.0.', HideMenu) > 0 then dxbs0.Visible := ivNever;
        if Pos('.1.', HideMenu) > 0 then dxbs1.Visible := ivNever;
        if Pos('.2.', HideMenu) > 0 then dxsiPlugIns.Visible := ivNever;
        if Pos('.3.', HideMenu) > 0 then dxbs3.Visible := ivNever;
        if Pos('.4.', HideMenu) > 0 then dxsiPlugInsASF.Visible := ivNever;
        Close;

      except
        ShowErr('Ошибка при загрузке списка справочников!');
      end;
      Free;
    end;
  UpdateExtMenu;
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
      ShowInfo('Перед изменением настроек подключения все открытые формы будут закрыты!');
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
    dmMain.dbMain.Tag := 0;
    IniSupport.StoreConnAttr(dmMain.dbMain);
    SetActions(dmMain.DoConnect);
    if dmMain.dbMain.Connected then EnableHook(dmMain.time_out);
  end;

end;

procedure TfmMain.actBaseLstExecExecute(Sender: TObject);
begin
  EditBaseLst((Sender as TComponent).Tag);
end;

procedure TfmMain.actOrgCardExecute(Sender: TObject);
begin
  ShowOrgCard;
end;

procedure TfmMain.actReScanPlugInsExecute(Sender: TObject);
var i: Integer;
    dxb: TdxBarButton;
    sl: TStringList;
begin
  dxsiPlugIns.ItemLinks.Clear;
  dxsiPlugInsASF.ItemLinks.Clear;
  dmMain.ScanPlugIns;
  sl := TStringList.Create;
  for i:=0 to dmMain.slPlugIns.Count-1 do begin
  // имя_dll,имя_плагина,копирайт,тип,image_index
    dxb := TdxBarButton.Create(Self);
    dxb.Action := actExecPlugIn;
    dxb.Action := nil;
    dxb.Tag := i;
    sl.CommaText := dmMain.slPlugIns[i];
    dxb.ImageIndex := StrToInt(sl[4]);
    if Copy(sl[1], 1, 6) = 'НАСФ: ' then begin
      dxb.Caption := Copy(sl[1], 7, MaxInt);
      dxsiPlugInsASF.ItemLinks.Add.Item := dxb;
    end else begin
      dxb.Caption := sl[1];
      dxsiPlugIns.ItemLinks.Add.Item := dxb;
    end;
  end;
  sl.Free;
end;

procedure TfmMain.ShowReport(PlugInNum: Integer; Form26ID: Integer = -1);
var sl: TStringList;
    fnExec: Pointer;
    hDll: THandle;
    i: Integer;
    frm: TForm;
begin
  if not dmMain.rPrint then begin
    ShowErr('Вы не обладаете правом на печать документов. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  sl := TStringList.Create;
  try
    if PlugInNum = -1 then
      for i := 0 to dmMain.slPlugIns.Count - 1 do
        if Pos('FORM26.DLL',AnsiUpperCase(dmMain.slPlugIns[i])) <> 0 then  begin
          PlugInNum := i;
          Break;
        end;
    if PlugInNum = -1 then Exit;
    sl.CommaText := dmMain.slPlugIns[PlugInNum];
    // имя_dll,имя_плагина,копирайт,тип,image_index
    hDll := LoadLibrary(PChar(sl[0]));
    if hDll=0 then ShowErr('Ошибка при загрузке модуля: '+#13+sl[0]) else
    try
      fnExec := GetProcAddress(hDll,'PlugInExec');
      if fnExec=nil then ShowErr('Неверный формат модуля: '+#13+sl[0]) else
      case StrToInt(sl[3]) of
        0: TPlugInExecMain(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject);
        1: TPlugInExecOrg(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetOrgID);
        2: if dmMain.GetPersonID>0 then
           TPlugInExecOrg(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetPersonID)
           else ShowMessage('Для вывода данной справки нужно открыть картотеку сотрудников!');
        3: if (dmMain.GetF6ID>0) then
           TPlugInExecF6(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetF6ID);
        4: begin
          frm := nil;
          for i := 0 to Application.ComponentCount-1 do
            if Application.Components[i] is TfmPersonList then begin
              frm := Application.Components[i] as TForm;
              if frm.Active then break;
            end;
          if frm<>nil then begin
            TPlugInExecList(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,(frm as TfmPersonList).qrData.Recordset);
          end
          else
          with TADOQuery.Create(Self) do
          try
            Connection := dmMain.dbMain;
            SQL.Text := 'SELECT * FROM PERSON WHERE IS_WAR<>0 ORDER BY NUMB_T2';
            Open;
            TPlugInExecList(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,Recordset);
          finally Free;
          end;
        end;
        5: TPlugInExecOrgWithConfirm(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetOrgID,True);
        6: if dmMain.GetPersonID>0 then
           TPlugInExecForm26(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetPersonID,Form26ID)
           else ShowMessage('Для вывода данной справки нужно открыть картотеку сотрудников!');
      end;
    finally FreeLibrary(hDll);
    end;
  finally sl.Free;
  end;
end;

procedure TfmMain.actExecPlugInExecute(Sender: TObject);
begin
  ShowReport((Sender as TdxBarButton).Tag);
end;

procedure TfmMain.actConfigPlugInsExecute(Sender: TObject);
begin
  ConfigPlugIns;
end;

procedure TfmMain.actExportExecute(Sender: TObject);
var hDLL: Cardinal;
    fn  : TPlugInExecOrg;
begin
  {$IFNDEF BackDoors}
  if IsDemoVersion then begin
    ShowInfo(
      'Система работает в демо-режиме с ограниченным функционированием!'#13+
      'Для активации продукта вызовите команду "Активация продукта..." из пункта "?" главного меню...'
      );
    Exit;
  end;
  {$ENDIF}
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
    @fn := GetProcAddress(hDLL,'ExportOrgData');
    if @fn=nil then begin
      SaveEvent(dmMain.dbMain, evs_Export_Failed, '', [
        'Найденный модуль "expdata.dll" имеет неверный формат.',
        ExtractFilePath(Application.ExeName)+'expdata.dll']);
      ShowErr('Найденный модуль "expdata.dll" имеет неверный формат!')
    end
    else
      fn(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetOrgID);
    FreeLibrary(hDLL);
  end;
end;

procedure TfmMain.actImportExecute(Sender: TObject);
var hDLL: Cardinal;
    fn  : TPlugInExecOrg;
begin
  if not dmMain.rImport then begin
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
    @fn := GetProcAddress(hDLL,'ImportOrgData');
    if @fn=nil then begin
      SaveEvent(dmMain.dbMain, evs_Import_Failed, '', [
        'Найденный модуль "expdata.dll" имеет неверный формат.',
        ExtractFilePath(Application.ExeName)+'expdata.dll']);
      ShowErr('Найденный модуль "expdata.dll" имеет неверный формат!')
    end
    else
      fn(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetOrgID);
    FreeLibrary(hDLL);
  end;
end;

procedure TfmMain.actSetsExecute(Sender: TObject);
begin
  if ConfigDlg then UpdateExtMenu;
end;

procedure TfmMain.actHelpExecute(Sender: TObject);
begin
  {if Screen.ActiveForm = fmMain then
    Application.HelpCommand(HELP_CONTEXT, HelpContext)
  else if Assigned(Screen.ActiveForm) then
    Application.HelpCommand(HELP_CONTEXT, Screen.ActiveForm.HelpContext);}
  ShellExecute(0,'open',PChar(ExtractFilePath(Application.ExeName)+'Руководство пользователя ВУР.doc'),nil,nil,SW_NORMAL);
end;

procedure TfmMain.actPersonLstExecute(Sender: TObject);
begin
  ShowPersonList;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  MainScale := 100;
  fStarted := false;
  Application.HelpFile := ExtractFilePath(Application.ExeName)+'granvus.hlp';
  if IsDemoVersion
    then Caption := sAppTitle + ' (демонстрационный режим)'
    else Caption := sAppTitle;
end;

procedure TfmMain.actStoreDataExecute(Sender: TObject);
var hDLL: Cardinal;
    fn  : TPlugInExecMain;
begin
  hDLL := LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+'backup.dll'));
  if hDLL=0 then begin
    SaveEvent(dmMain.dbMain, evs_Backup_Failed, '', [
      'Не найден требуемый модуль "backup.dll".',
      ExtractFilePath(Application.ExeName)+'backup.dll']);
    ShowErr('Не найден требуемый модуль "backup.dll"!')
  end
  else begin
    @fn := GetProcAddress(hDLL,'StoreData');
    if @fn=nil then begin
      SaveEvent(dmMain.dbMain, evs_Backup_Failed, '', [
        'Найденный модуль "backup.dll" имеет неверный формат.',
        ExtractFilePath(Application.ExeName)+'backup.dll']);
      ShowErr('Найденный модуль "backup.dll" имеет неверный формат!')
    end
    else
      fn(Application.Handle,dmMain.dbMain.ConnectionObject);
    FreeLibrary(hDLL);
  end;
end;

procedure TfmMain.actRestoreDataExecute(Sender: TObject);
var hDLL: Cardinal;
    fn  : TPlugInExecMain;
begin
  hDLL := LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+'backup.dll'));
  if hDLL=0 then begin
    SaveEvent(dmMain.dbMain, evs_Restore_Failed, '', [
      'Не найден требуемый модуль "backup.dll".',
      ExtractFilePath(Application.ExeName)+'backup.dll']);
    ShowErr('Не найден требуемый модуль "backup.dll"!')
  end
  else begin
    @fn := GetProcAddress(hDLL,'RestoreData');
    if @fn=nil then begin
      SaveEvent(dmMain.dbMain, evs_Restore_Failed, '', [
        'Найденный модуль "backup.dll" имеет неверный формат.',
        ExtractFilePath(Application.ExeName)+'backup.dll']);
      ShowErr('Найденный модуль "backup.dll" имеет неверный формат!')
    end
    else
      fn(Application.Handle,dmMain.dbMain.ConnectionObject);
    FreeLibrary(hDLL);
  end;
end;

procedure TfmMain.actStaffListStoredExecute(Sender: TObject);
begin
  ShowStaffListStored;
end;

procedure TfmMain.actActivateExecute(Sender: TObject);
begin
  if IsDemoVersion(true,true)
    then Caption := sAppTitle+' (демострационный режим)'
    else Caption := sAppTitle;
end;

procedure TfmMain.actAsfMtrStaffListExecute(Sender: TObject);
begin
  ShowAsfMtrList;
end;

procedure TfmMain.actASStaffListStoredExecute(Sender: TObject);
begin
  ShowASStaffListStored;
end;

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

procedure TfmMain.CreateRepDir;
var
  P: PChar;
begin
  P := nil;
  try
    P := AllocMem(MAX_PATH);
    if SHGetFolderPath(0, CSIDL_APPDATA {CSIDL_LOCAL_APPDATA}, 0, 0, P) = S_OK then
       ForceDirectories(P + '\GranVUS\Reports');
  finally
    FreeMem(P);
  end;
end;

procedure TfmMain.dxScaleMinusClick(Sender: TObject);
begin
  MainScale := Trunc(MainScale / 1.2);
  RescaleForms(83);
end;

procedure TfmMain.dxScalePlusClick(Sender: TObject);
begin
  MainScale := Trunc(MainScale * 1.2);
  RescaleForms(120);
end;

procedure TfmMain.bbAsfMtrClick(Sender: TObject);
var
  f: TfmParamDlg;
  ff: TTfmAsfMtr;
begin
  f := TfmParamDlg.Create(Self);
  if f.ShowModal = mrOK then begin
    ff := TTfmAsfMtr.Create(Self);
  end;
end;

procedure TfmMain.bbUpdateClick(Sender: TObject);
type
  ShowHistoryAuth = function(bFTP, bHTTP, bHDD, bDB, bDBVersion: Boolean; AConn: _Connection;
                         bIsHistory: Boolean; sProductCode, sLicenseKey: WideString): Boolean; stdcall;
var
  button: TComponent absolute Sender;
  proc: FarProc;
  Lib: HINST;
  b: Boolean;
begin
  if CheckUpdateLibrary then begin
    Lib:=LoadLibrary(uFile);
    try
      Proc:=GetProcAddress(Lib, 'ShowHistoryAuth');
      if Assigned(Proc) then begin
        b := ShowHistoryAuth(Proc)(True, True, True, False, True, dmMain.dbMain.ConnectionObject,
                               button.Name = 'bbHistory', ProductCode, LicenseKey);
        if button.Name = 'bbHistory' then begin
          if not b then ShowMessage('Историю изменений получить не удалось!');
        end
        else begin
          if not b and (button.Name = 'bbUpdate') then ShowMessage('Новых обновлений нет!');
        end;
      end;
    finally
      FreeLibrary(Lib);
    end;
  end
  else ShowMessage('Библиотека ' + uFile + ' не найдена!');
end;

procedure TfmMain.actEventsExecute(Sender: TObject);
begin
  fEventList.ShowEventList;
end;

procedure TfmMain.actBronDolExecute(Sender: TObject);
begin
  ShowTPDP;
end;

procedure TfmMain.actUsersExecute(Sender: TObject);
begin
  fUsers.Execute;
end;

procedure TfmMain.aPersonChangesExecute(Sender: TObject);
begin
  ShowPersonChangesList;
end;

procedure TfmMain.actForm6Execute(Sender: TObject);
var
  fnExec : Pointer;
  hDll   : THandle;
begin
//вызов формы 6
  hDll := LoadLibrary(PChar(IniSupport.GetPlugInsDir+'form6.dll'));
  if hDll=0 then ShowErr('Ошибка при загрузке модуля расчётной численности (Форма №6 или №18).')
  else begin
    fnExec := GetProcAddress(hDll,'PlugInExecForm');
    if fnExec=nil then ShowErr('Модуль расчётной численности (Форма №6 или №18) имеет неверный формат.')
    else begin
      if dmMain.GetF6ID > 0 then begin
        TPlugInExecF6(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetF6ID);
      end;
    end;
    FreeLibrary(hDll);
  end;
end;

procedure TfmMain.actForm6_2015Execute(Sender: TObject);
var
  fnExec : Pointer;
  hDll   : THandle;
begin
//вызов формы 6
  hDll := LoadLibrary(PChar(IniSupport.GetPlugInsDir+'form6_2015.dll'));
  if hDll=0 then ShowErr('Ошибка при загрузке модуля расчётной численности (Форма №6 или №18).')
  else begin
    fnExec := GetProcAddress(hDll,'PlugInExecForm');
    if fnExec=nil then ShowErr('Модуль расчётной численности (Форма №6 или №18) имеет неверный формат.')
    else begin
      if dmMain.GetF6ID > 0 then begin
        TPlugInExecF6(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetF6ID);
      end;
    end;
    FreeLibrary(hDll);
  end;
end;

procedure TfmMain.actStaffListROExecute(Sender: TObject);
begin
  fStaffList.ShowStaffListRO;
end;

procedure TfmMain.actSPOBronExportExecute(Sender: TObject);
begin
  {$IFNDEF BackDoors}
  if IsDemoVersion then begin
    ShowInfo(
      'Система работает в демо-режиме с ограниченным функционированием!'#13+
      'Для активации продукта вызовите команду "Активация продукта..." из пункта "?" главного меню...'
      );
    Exit;
  end;
  {$ENDIF}
  if not dmMain.rExport then begin
    ShowErr('Вы не обладаете правом на операцию экспорта данных. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  dSPOBron.DoExport;
end;

procedure TfmMain.aSecretExecute(Sender: TObject);
var
  pwd: string;
begin
  pwd := InputPassword('','');
  if pwd = 'ENTERSQL' then
     EditSQL(dmMain.dbMain, '', True, True, False);
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  SetFocusedControl(Self);
//  Application.HelpCommand(HELP_QUIT,0);
  DisableHook;
end;

procedure TfmMain.aBadDatesCheckExecute(Sender: TObject);
const
  SQL_TEXT : array [1..29,0..2] of String =
  (('PERS_ID', 'PERSON'      ,'BIRTHDAY')
  ,('PERS_ID', 'PERSON'      ,'PSP_DATE')
  ,('PERS_ID', 'PERSON'      ,'DOG_DATE')
  ,('PERS_ID', 'PERSON'      ,'CONFDATE')
  ,('PERS_ID', 'PERSON'      ,'W_DBEG')
  ,('PERS_ID', 'PERSON'      ,'W_DEND')
  ,('PERS_ID', 'PERSON'      ,'D_OVK')
  ,('PERS_ID', 'PERSON'      ,'D_WBIL')
  ,('PERS_ID', 'PERSON'      ,'OUT_ORD_DATE')
  ,('PERS_ID', 'PERSON'      ,'OUT_DATE')
  ,('PERS_ID', 'PERSON'      ,'WUCHET2_date')
  ,('PERS_ID', 'PERSON'      ,'STUDYEND_DATE')
  ,('PERS_ID', 'PERSON'      ,'ORDERAKADEM_DATE')
  ,('PERS_ID', 'PERSON'      ,'BEGINAKADEM_DATE')
  ,('PERS_ID', 'PERSON'      ,'ENDAKADEM_DATE')
  ,('PERS_ID', 'PERSON'      ,'REALENDAKADEM_DATE')
  ,('PERS_ID', 'PERSON'      ,'MEDRESULT_DATE')
  ,('PERS_ID', 'PERSON'      ,'BEGINWAR_DATE')
  ,('PERS_ID', 'PERSON'      ,'ENDWAR_DATE')
  ,('PERS_ID', 'PERSON'      ,'REALENDWAR_DATE')
  ,('PERS_ID', 'PERSON'      ,'ORDERDISMISSAL_DATE')
  ,('PERS_ID', 'PERSON'      ,'DISMISSAL_DATE')
  ,('PERS_ID', 'PERSON'      ,'DEFEND_DATE')
  ,('PERS_ID', 'PERSON'      ,'REALDEFEND_DATE')
  ,('ID', 'APPOINTMENT' ,'IN_ORD_DATE')
  ,('ID', 'APPOINTMENT' ,'IN_DATE')
  ,('N26_ID', 'N26HISTORY'  ,'CREATE_DATE')
  ,('N26_ID', 'N26HISTORY'  ,'GIVE_DATE')
  ,('ADDR_ID', 'ADDR'        ,'ADDR_DATE'));
  DESCRIPT: array [1..High(SQL_TEXT)] of String =
  ('Дата рождения'
  ,'Дата выдачи паспорта'
  ,'Дата трудового договора'
  ,'Дата внесения изменений в карточку'
  ,'Дата постановки на учёт'
  ,'Дата снятия с воинского учета/помещения в архив'
  ,'Дата сверки с ОВК'
  ,'Дата сверки с военным билетом'
  ,'Дата приказа об увольнении'
  ,'Дата увольнения'
  ,'Дата изменения сведений о бронировании'
  ,'Плановая дата окончания обучения'
  ,'Дата приказа об уходе в академ. отпуск'
  ,'Дата начала академ. отпуска'
  ,'Дата ожидаемого выхода из академ. отпуска'
  ,'Дата фактического выхода из академ. отпуска'
  ,'Дата прохождения медкомиссии после АО'
  ,'Дата начала обучения на ВК'
  ,'Дата планового окончания обучения на ВК'
  ,'Дата фактического окончания обучения на ВК'
  ,'Дата приказа об отчислении'
  ,'Дата отчисления'
  ,'Дата плановой защиты диссер. работы'
  ,'Дата фактической защиты диссер. работы'
  ,'Дата приказа о назначении'
  ,'Дата назначения'
  ,'Дата выписки'
  ,'Дата выдачи'
  ,'Дата прописки');
  function I2DXX(const I: Integer): String;
  begin
    Result := IntToStr(I);  Result := IfThen(I<10,'d0'+Result, 'd'+Result);
  end;
var
  I                : Integer;
  QMASTER, QDETAIL : TADOQuery;
  Qty              : array [0..High(SQL_TEXT)] of Integer;
  IsBad            : Boolean;
  D01011900        : TDateTime;
  S                : String;
begin
  D01011900 := 2;//StrToDateTime('01'+DateSeparator+'01'+DateSeparator+'1900');
  FillChar(Qty,SizeOf(Qty),0);//Qty := 0;
  Screen.Cursor := crhourGlass;
  try
    QMASTER := TADOQuery.Create(nil);
    try
      QMASTER.Connection := dmMain.dbMain;
      QMASTER.SQL.Text := 'select PERS_ID, FAM from PERSON';
      QMASTER.Open;
      ProgressShow(QMASTER.RecordCount, 'Выявление и исправление некорректных календарных дат');
      QDETAIL := TADOQuery.Create(nil);
      try
        QDETAIL.Connection := dmMain.dbMain;

        QMASTER.First;
        while not QMASTER.Eof do begin
          IsBad := False;
          for I := High(SQL_TEXT) downto 1 do begin
            QDETAIL.SQL.Text :=
              'select '+SQL_TEXT[I,0]+', '+SQL_TEXT[I,2]+' as BADDATE '+
              'from '+SQL_TEXT[I,1]+' '+
              'where ('+SQL_TEXT[I,2]+'<#1/1/1900# or '+SQL_TEXT[I,2]+'>#31/12/2049#) '+
                'and PERS_ID='+QMASTER.FieldByName('PERS_ID').AsString;
            QDETAIL.Open;
            if not QDETAIL.IsEmpty then begin
              IsBad := True;
              Inc(Qty[I]);
              with QMASTER do begin
                Edit; FieldByName('FAM').AsString := I2DXX(I)+QMASTER.FieldByName('FAM').AsString; Post;
              end;
              with QDETAIL do begin
                First;
                while not Eof do begin
                  Edit;  FieldByName('BADDATE').AsDateTime := D01011900;  Post;
                  Next;
                end;
              end;//with
            end; //if is bad
            QDETAIL.Close;
          end;//for
          if IsBad then Inc(Qty[0]);
          QMASTER.Next;
          ProgressInc;
        end;
      finally QDETAIL.Free;
      end;
    finally QMASTER.Free; ProgressClose;
    end;
  finally Screen.Cursor := crDefault;
  end;
  if Qty[0]=0 then ShowMessage('Даты меньше 1.1.1900 или больше 31.12.2050 не обнаружены.')
  else begin
    S := Format('Кол-во человек, для которых обнаружены даты меньше 1.1.1900 или больше 31.12.2050 = %d'#13'Поставлены метки:',[Qty[0]]);
    for I := 1 to High(DESCRIPT) do S := S+Format(#13'%s (%s) = %d',[I2DXX(I),DESCRIPT[I],Qty[I]]);
    S := S+#13#13'Для открытых списков сотрудников чтобы увидеть изменения выполните команду "Обновить список".';
    ShowMessage(S);
  end;
end;

end.

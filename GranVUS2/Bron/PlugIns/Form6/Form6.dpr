library Form6;



uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  Dialogs,
  dxDBGrid,
  fForm6 in 'fForm6.pas' {Form6List},
  dMain in 'dMain.pas' {dmMain: TDataModule},
  Msg,
  SaveEvents,
  IniSupport,
  fForm6NoBron in 'fForm6NoBron.pas' {Form6NoBron},
  fGetType in 'fGetType.pas' {frmGetType};

{$R ResData.RES}

function PlugInInfo(
  szName: PChar;
  szAuthor: PChar): Integer; stdcall;
// szName - заполняется наименованием плагина
// szAuthor - копирайт плагина
// ReturnValue - тип плагина
//    0 - общее назначение
//        function PlugInExec(AppHandle: THandle; szConn: _Connection): Integer; stdcall;
//    1 - для работы с карточкой организации
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nOrgID: Integer): Integer; stdcall;
//    2 - для работы с карточкой сотрудника
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nManID: Integer): Integer; stdcall;
//    3 - для работы с формой 6
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nF6ID: Integer): Integer; stdcall;

begin
  Result := 3;
  StrCopy(szName,'Форма № 6 организации');
  StrCopy(szAuthor,'(с) 2010, ОАО "НПП "Гранит-Центр"');
end;

function Execute(
  AppHandle: THandle;
  Conn: _Connection;
  nF6ID: Integer): Integer;
//  szConn - строка подключения к БД
//  nOrgID - код организации
var
  OldConn : _Connection;
  rEdit   : Boolean;
  HasBron : Boolean;
  isF5: Boolean;
begin
  Result := 0;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  try
      isF5 := False;
      if nF6ID < 0 then begin
        isF5 := True;
        nF6ID := -nF6ID;
      end;

      OldConn:= dmMain.dbMain.ConnectionObject;
      dmMain.dbMain.ConnectionObject := Conn;
      try
        dmMain.dbMain.Connected := true;
        dmMain.F6_ID:= nF6ID;
        dmMain.Init;
      except
        if not not FKadry then
        if FPrintOnly
          then SaveEvent(dmMain.dbMain,
            evs_Report_Error,
            sEventObject,
            ['Ошибка при обращении к базе данных.'])
          else SaveEvent(dmMain.dbMain,
            evs_Form6_Error,
            '',
            ['Ошибка при обращении к базе данных.']);
        MessageBox(Application.Handle,
          'Ошибка при обращении к базе данных!',
          'Форма № 6',MB_OK or MB_ICONERROR);
        Result := -1;
      end;
      if Result=0 then
      try
        Application.CreateForm(TForm6List, Form6List);

        with TADOQuery.Create(nil) do
        try
          Connection := dmMain.dbMain;
          ParamCheck := False;
          SQL.Text := 'SELECT O.OrgID, O.HAS_BRON FROM FORM6HDR F, ORG O '+
          'WHERE F.ORGID = O.ORGID AND F.F6_ID = '+IntToStr(nF6ID);
          Open;
          dmMain.Svod := False;
          dmMain.ORG_ID   := Fields[0].AsInteger;
          HasBron         := Fields[1].AsBoolean;
          if dmMain.ORG_ID = 0 then begin
            Close;
            SQL.Text := 'SELECT SUBJ_ID FROM FORM6HDR F WHERE F.F6_ID = '+IntToStr(nF6ID);
            Open;
            dmMain.Svod := True;
            dmMain.SUBJ_ID := Fields[0].AsInteger;
            HasBron := True;
          end;
          dmMain.isF5 := isF5;
        finally Free;
        end;
        if FPrintOnly then Form6List.PrintAction.Execute
        else begin
          with TADOQuery.Create(nil) do
          try
            Connection := dmMain.dbMain;
            ParamCheck := False;
            SQL.Text := 'SELECT * FROM Users WHERE ID = '+IntToStr(GetLastUserID);
            Open;
            rEdit := FieldByName('rEdit').AsBoolean;
          finally Free;
          end;
          Form6List.PrintAction.Visible := FKadry;
          Form6List.HasBron := HasBron;
          //if HasBron then begin
            Form6List.CheckAction.Enabled := rEdit;
            Form6List.CalcUpAction.Enabled := rEdit;
            Form6List.tbCalcMode.Enabled := rEdit;
            if not rEdit then with Form6List.dxDBGrid do OptionsBehavior := OptionsBehavior-[edgoEditing];
            Form6List.ShowModal;
          {end
          else
            with TForm6NoBron.Create(Application) do
            try     ID := nF6ID; Grid.Enabled := rEdit; pbCancel.Enabled := rEdit;
                    LoadData;
                    ShowModal;
            finally Free;
            end;}
        end;
      except
        if not not FKadry then
        if FPrintOnly
          then SaveEvent(dmMain.dbMain,
            evs_Report_Error,
            sEventObject,
            ['Ошибка при создании.'])
          else SaveEvent(dmMain.dbMain,
            evs_Form6_Error,
            '',
            ['Ошибка при создании.']);
        MessageBox(Application.Handle,
          'Ошибка при создании формы!', sEventObject,
          MB_OK or MB_ICONERROR);
        Result := -2;
      end;
    finally
      dmMain.dbMain.ConnectionObject:= OldConn;
      dmMain.Free;
    end;
  finally Application.Handle := 0;
  end;
end;

function PlugInExec(
  AppHandle: THandle;
  Conn: _Connection;
  nF6ID: Integer): Integer; stdcall;
begin
  FPrintOnly := True;
  Result := Execute(AppHandle, Conn, nF6ID);
end;

function PlugInExecForm(
  AppHandle: THandle;
  Conn: _Connection;
  nF6ID: Integer): Integer; stdcall;
begin
  FPrintOnly := False;
  Result := Execute(AppHandle, Conn, nF6ID);
end;

function PlugInExecKadry(
  AppHandle: THandle;
  Conn: _Connection;
  nF6ID: Integer): Integer; stdcall;
begin
  FKadry := true;
  Result := Execute(AppHandle, Conn, nF6ID);
end;

procedure PlugInUnicode;
begin
  // Просто заглушка - если эта процедура есть, то ДЛЛ-ка хорошая
end;

exports
  PlugInInfo, PlugInExec, PlugInExecForm, PlugInUnicode;

begin
end.




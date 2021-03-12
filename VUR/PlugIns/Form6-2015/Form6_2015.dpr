library Form6_2015;



uses
  Forms,
  SysUtils,
  Windows,
  ADOdb,
  Dialogs,
  dxDBGrid,
  fForm6 in 'fForm6.pas' {Form6List},
  dMain in 'dMain.pas' {dmMain: TDataModule},
  Msg in '..\..\Common\Msg.pas',
  SaveEvents in '..\..\Common\SaveEvents.pas',
  IniSupport in '..\..\Common\IniSupport.pas';

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
  StrCopy(szAuthor,'(с) 2008, ГУП г.Москвы "ГНПП "Гранит-Центр"');
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
begin
  Result := 0;
  Application.Handle := AppHandle;
  try
    Application.CreateForm(TdmMain, dmMain);
  try
      OldConn:= dmMain.dbMain.ConnectionObject;
      dmMain.dbMain.ConnectionObject := Conn;
      try
        dmMain.dbMain.Connected := true;
        dmMain.dbMain.Tag := SaveEvents.GetLastUserID(dmMain.dbMain);
        dmMain.F6_ID:= nF6ID;
        dmMain.Init;
      except
        if FPrintOnly
          then SaveEvent(dmMain.dbMain,
            evs_Report_Error,
            sEventObject,
            ['Ошибка при обращении к базе данных.'])
          else SaveEvent(dmMain.dbMain,
            evs_Form6_2015_Error,
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
        if FPrintOnly then Form6List.PrintAction.Execute
        else begin
          Form6List.PrintAction.Visible := False;
          with TADOQuery.Create(nil) do
          try
            Connection := dmMain.dbMain;
            ParamCheck := False;
            SQL.Text := 'SELECT * FROM vw_VUR_Users WHERE ID = (SELECT WHO FROM Event WHERE Event_ID = (SELECT MAX(Event_ID) FROM Event))';
            Open;
            rEdit := FieldByName('rEdit').AsBoolean;
          finally Free;
          end;
          Form6List.GenerateAction.Enabled := rEdit;
          Form6List.CheckAction.Enabled := rEdit;
          Form6List.CalcUpAction.Enabled := rEdit;
          Form6List.ClearAction.Enabled := rEdit;
          Form6List.tbCalcMode.Enabled := rEdit;
          if not rEdit then with Form6List.dxDBGrid do OptionsBehavior := OptionsBehavior-[edgoEditing];
          Form6List.ShowModal;
        end;
      except
        if FPrintOnly
          then SaveEvent(dmMain.dbMain,
            evs_Report_Error,
            sEventObject,
            ['Ошибка при создании.'])
          else SaveEvent(dmMain.dbMain,
            evs_Form6_2015_Error,
            '',
            ['Ошибка при создании.']);
        MessageBox(Application.Handle,
          'Ошибка при создании формы!',
          'Форма № 6',MB_OK or MB_ICONERROR);
        Result := -2;
      end;
    finally
      if Assigned(dmMain) then dmMain.dbMain.ConnectionObject:= OldConn;
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

exports
  PlugInInfo, PlugInExec, PlugInExecForm;

begin
end.


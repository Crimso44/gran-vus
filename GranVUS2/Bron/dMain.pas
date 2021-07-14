unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, ImgList, OleServer, Excel2000, dxTL, Variants, dxDBGrid, dxGrClms,
  ExcelXP;

type
  TPlugInInfo =
    function (szName: PChar;
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
//    3 - для работы с формой № 6
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nF6ID: Integer): Integer; stdcall;

  TPlugInExecMain =
    function (AppHandle: THandle; Conn: _Connection): Integer; stdcall;
  TPlugInExecOrg =
    function (AppHandle: THandle; Conn: _Connection; nOrgID: Integer): Integer; stdcall;
  TPlugInExecMan =
    function (AppHandle: THandle; Conn: _Connection; nManID: Integer): Integer; stdcall;
  TPlugInExecF6 =
    function (AppHandle: THandle; Conn: _Connection; nF6ID: Integer): Integer; stdcall;
  TPlugInExecSubj =
    function (AppHandle: THandle; Conn: _Connection; nSubjID: Integer): Integer; stdcall;
  TPlugInConfig =
    function (AppHandle: THandle; Conn: _Connection): Integer; stdcall;

  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    ilSmall: TImageList;
    sp_GenerateForm6: TADOStoredProc;
    ExcelApplication: TExcelApplication;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure dbMainWillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
    procedure dbMainExecuteComplete(Connection: TADOConnection;
      RecordsAffected: Integer; const Error: Error;
      var EventStatus: TEventStatus; const Command: _Command;
      const Recordset: _Recordset);
  private
     procedure FieldGetText(Sender: TField; var Text: String;
       DisplayText: Boolean);
     function GetLicenceCount: Integer;
    { Private declarations }
  public
    { Public declarations }
    time_out: Cardinal;
    slPlugIns: TStringList;
    rAdmin, rImport, rExport, rPrint, rEdit: Boolean;//User's rights
// имя_dll,имя_плагина,копирайт,тип,image_index
    procedure ScanPlugIns;

    function DoConnect: boolean;

    function GetOrgID: Integer;
    function GetF6ID: Integer;
    function GetSubjID: Integer;
    function GetSubjNameByID(ID: Integer): String;
    function GetCurrSubjID: Integer;

    function GenerateOrgF6(ORGID: Integer): Integer;

    function GetOKBVSuffix(OrgId: Integer; IsCard: boolean=false; HasBron: boolean=false): string;

    procedure ChkDemoMode(FAlwaysShowCard: boolean = false);
    function IsDemoMode: Boolean;

    function IsCryptInstalled: boolean;

    function ShowActivationCard: Integer;

    procedure UpdateCurrentOKBV;

    procedure GridToExcel(Grid: TdxDBGrid{TCustomdxTreeListControl}; ACaption: string =''; PrintBands: boolean=false; PrintHeaders: boolean=true);
  end;

  function SortClause(Fields: array of string; Orders: array of Boolean): string;
  function EasySortClause(Field: string; Order: Boolean; Secondary: string = ''): string;
  function MakeRTFTemplate(Name: PChar; var Size: Integer): Pointer;


var
  dmMain: TdmMain;

implementation

uses IniSupport, msg, fMain, fOrgLst, fSubjLst, fSubjCard, fGetPsw, MD5, 
  fOrgProp, SaveEvents, StrUtils, ShellAPI, uVERSION;

{$R *.DFM}

function TdmMain.DoConnect: boolean;
begin
  if dbMain.Connected then begin
    ShowMessage('Close default connection in OBJECT INSPECTOR!');
    SaveEvent(dbMain, evs_Logout,'',['Причина: попытка нового соединения.']);
    dbMain.Connected := false;
  end;
  Result := true;
  try
    LoadConnAttr(dbMain);
    dbMain.Connected := true;
    ChkDemoMode; // ToDo: SaveEvent
    if not dbMain.Connected then begin
      Result := false;
      Exit;
    end;
    if not CheckPassword then begin //dmMain.SaveEvent(evs_Login... - in CheckPassword
      dbMain.Connected := false;
      Result := false;
    end;
    with TADOQuery.Create(nil) do
    try
      Connection := dbMain;
      ParamCheck := False;
      SQL.Text := 'SELECT MAX(backup_finish_date) FROM msdb..backupset WHERE database_name = DB_NAME()';
      Open;
      if Date - Fields[0].AsDateTime > GetBackUpPeriod then
         ShowMessage(
          'Дата последнего резервного копирования - '+Fields[0].AsString+'.'#13#13+
          'В целях сохранения целостности базы данных Вам необходимо сделать '+
          'резервное копирование последней введённой информации. В случае сбойной '+
          'ситуации Вы всегда сможете восстановить базу данных.');
    finally
      Free;
    end;
  except
    ShowErr(Err_DbConnect);
    Result := false;
  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close DEFUALT connection!');
  slPlugIns := TStringList.Create;
  time_out := IniSupport.GetTimeOut;
end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  slPlugIns.Free;
end;

procedure TdmMain.ScanPlugIns;
var sl: TStringList;
    PlugInInfo: TPlugInInfo;
    PlugType: Integer;
    PlugName,PlugAuthor: Array[0..1000] of char;

    procedure ScanDir(path: string);
    var F: TSearchRec;
        fDone: boolean;
        bmp: TBitmap;
        hDll: THandle;
    begin
      fDone := FindFirst(path+'\*.*',faAnyFile,F)=0;
      while fDone do begin
        if F.Name[1]<>'.' then begin
          if (F.Attr and faDirectory)<>0 then ScanDir(path+'\'+F.Name)
          else
            if UpperCase(ExtractFileExt(F.Name))='.DLL' then begin
              hDll := LoadLibrary(PChar(path+'\'+F.Name));
              if hDll=0 then ShowErr('Ошибка при загрузке плагина: '+#13+F.Name)
              else begin
                @PlugInInfo := GetProcAddress(hDll,'PlugInUnicode');
                if @PlugInInfo<>nil then begin
                  @PlugInInfo := GetProcAddress(hDll,'PlugInInfo');
                  if @PlugInInfo<>nil then begin
                    PlugType := PlugInInfo(PlugName,PlugAuthor);
                    if not (PlugType in [0,1,2,3,5]) then ShowErr('Неверный формат плагина: '+#13+F.Name)
                    else begin
  // имя_dll,имя_плагина,копирайт,тип,image_index
                      sl.Clear;
                      sl.Add(path+'\'+F.Name);
                      sl.Add(PlugName);
                      sl.Add(PlugAuthor);
                      sl.Add(IntToStr(PlugType));
                      bmp := TBitmap.Create;
                      try
                        bmp.LoadFromResourceName(hDll,'IDB_LOGO');
                        sl.Add(IntToStr(ilSmall.Add(bmp,nil)));
                      except
                        sl.Add('-1');
                      end;
                      bmp.Free;
                      slPlugIns.Add(sl.CommaText);
                    end;
                  end;
                  FreeLibrary(hDll);
                end;
              end;
            end;
        end;
        fDone := FindNext(F)=0;
      end;
      FindClose(F);
    end;
begin
// имя_dll,имя_плагина,копирайт,тип,image_index
  sl := TStringList.Create;
// remove old plug-ins
  slPlugIns.Clear;
// add new plug_ins
  ScanDir(IniSupport.GetPlugInsDir);
  sl.Free;
end;

function TdmMain.GetOrgID: Integer;
begin
  Result := 0;
  if fmMain.ActiveMDIChild<>nil then
    if fmMain.ActiveMDIChild is TfmOrgList then begin
      if not (fmMain.ActiveMDIChild as TfmOrgList).qrData.IsEmpty then
        Result := (fmMain.ActiveMDIChild as TfmOrgList).qrData.FieldByName('ORGID').AsInteger;
    end
    else
      if fmMain.ActiveMDIChild is TfmOrgProp then
        if (fmMain.ActiveMDIChild as TfmOrgProp).btnApply.Enabled then
          ShowInfo('Перед вызовом внешних функций необходимо сохранить введенные данные!')
        else
          Result := (fmMain.ActiveMDIChild as TfmOrgProp).FId;
end;

function EasySortClause(Field: string; Order: Boolean;
  Secondary: string): string;
begin
  if (Secondary <> Field) and (Secondary <> '') then
    Result:=SortClause([Field, Secondary],[Order, False])
  else Result:=SortClause([Field],[Order]);
end;

function SortClause(Fields: array of string;
  Orders: array of Boolean): string;
var i: Integer;
begin
  if High(Fields) <> High(Orders) then
    raise Exception.Create('Invalid parameters. Function SortClause.');
  if High(Fields) >= 0 then begin
    Result:='order by ';
    for i:=0 to High(Fields) do begin
      if i > 0 then Result:=Result+', ';
      Result:=Result+Fields[i];
      if not Orders[i] then Result:=Result+' DESC';
    end;
  end else Result:='';
end;

function TdmMain.GetF6ID: Integer;
begin
  Result := 0;
  if fmMain.ActiveMDIChild<>nil then
    if fmMain.ActiveMDIChild is TfmOrgList then begin
      if not (fmMain.ActiveMDIChild as TfmOrgList).qrData.IsEmpty then begin
        if not (fmMain.ActiveMDIChild as TfmOrgList).qrData.FieldByName('F6_ID').IsNull then begin
          Result := (fmMain.ActiveMDIChild as TfmOrgList).qrData.FieldByName('F6_ID').AsInteger;
        end else begin
          if Confirm('У выбранной организации нет Формы № 6. Сформировать?') then
            Result:= GenerateOrgF6((fmMain.ActiveMDIChild as TfmOrgList).qrData.FieldByName('ORGID').AsInteger);
        end;
      end;
    end
    else
      if fmMain.ActiveMDIChild is TfmOrgProp then begin
        if (fmMain.ActiveMDIChild as TfmOrgProp).btnApply.Enabled then
          ShowInfo('Перед вызовом внешних функций необходимо сохранить введенные данные!')
        else begin
          with TADOQuery.Create(Self) do begin
            Connection := dbMain;
            SQL.Text := 'SELECT F6_ID FROM FORM6HDR'#10+
                        'WHERE ORGID = '+IntToStr((fmMain.ActiveMDIChild as TfmOrgProp).FId);
            try
              Open;
              if IsEmpty then Result := 0
              else Result := Fields[0].AsInteger;
            finally
              Free;
            end;
          end;
          if Result = 0 then
            if Confirm('У выбранной организации нет Формы № 6. Сформировать?') then
              Result:= GenerateOrgF6((fmMain.ActiveMDIChild as TfmOrgProp).FId);
        end;
    end;
end;

procedure TdmMain.dbMainWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
begin
  Screen.Cursor:=crSQLWait;
  Command.CommandTimeout:= Connection.CommandTimeout;
end;

procedure TdmMain.dbMainExecuteComplete(Connection: TADOConnection;
  RecordsAffected: Integer; const Error: Error;
  var EventStatus: TEventStatus; const Command: _Command;
  const Recordset: _Recordset);
begin
  Screen.Cursor:=crDefault;
end;

function TdmMain.GetSubjID: Integer;
begin
  Result := 0;
  if fmMain.ActiveMDIChild<>nil then begin
    if fmMain.ActiveMDIChild is TfmSubjList then begin
      if not (fmMain.ActiveMDIChild as TfmSubjList).qrData.IsEmpty then
        if not (fmMain.ActiveMDIChild as TfmSubjList).qrData.FieldByName('SUBJ_ID').IsNull then
          Result := (fmMain.ActiveMDIChild as TfmSubjList).qrData.FieldByName('SUBJ_ID').AsInteger;
    end else if fmMain.ActiveMDIChild is TfmSubjCard then begin
      if (fmMain.ActiveMDIChild as TfmSubjCard).btnApply.Enabled then
        ShowInfo('Перед вызовом внешних функций необходимо сохранить введенные данные!')
      else begin
        Result:= (fmMain.ActiveMDIChild as TfmSubjCard).Id;
      end;
    end
  end;
  if Result = 0 then
    Result:= GetCurrSubjID;
end;

function TdmMain.GetSubjNameByID(ID: Integer): String;
begin
    with TADOQuery.Create(Self) do begin
    Connection := dbMain;
    SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ WHERE SUBJ_ID = :SUBJ_ID';
    Parameters.ParseSQL(SQL.Text, True);
    Parameters[0].Value := ID;
    try
      Open;
      if IsEmpty then Result := ''
      else Result := Fields[0].AsString;
    except
      Result := '';
    end;
      Free;
  end;
end;

function TdmMain.GetCurrSubjID: Integer;
begin
  with TADOQuery.Create(Self) do begin
    Connection := dbMain;
    SQL.Text := 'SELECT SUBJ_ID FROM CURR_SUBJ';
    try
      Open;
      if IsEmpty then Result := 0
      else Result := Fields[0].AsInteger;
    except
      Result := -1;
    end;
      Free;
  end;
end;

function TdmMain.GenerateOrgF6(ORGID: Integer): Integer;
var i: Integer;
begin
  with sp_GenerateForm6 do begin
    Parameters.ParamValues['@ORG_ID']:= ORGID;
    ExecProc;
    Result:= Parameters.ParamValues['@F6_ID'];
    for i:= 0 to Application.ComponentCount - 1 do
      if Application.Components[i] is TfmOrgList then
        (Application.Components[i] as TfmOrgList).ReOpenList(True);
  end;
end;

function TdmMain.GetOKBVSuffix(OrgId: Integer; IsCard: boolean=false; HasBron: boolean=false): string;
var s: string;
begin
  if HasBron then Result := '-Б'
  else
    with TADOQuery.Create(Self) do
      try
     //look at Form6
       Result := EmptyStr;
        Connection := dbMain;
        if not IsCard then begin
          SQL.Text := 'SELECT HAS_BRON FROM Org WHERE OrgId='+IntToStr(OrgId);
          Open;
          if Fields[0].AsBoolean then Result := '-Б';
          Close;
        end;
        if Result=EmptyStr then begin
          SQL.Text :=
            'SELECT COL_2 FROM Form6'#13+
            'WHERE CPROF_ID=1000'#13+
            'AND F6_ID IN (SELECT F6_ID FROM Form6Hdr WHERE OrgId='+IntToStr(OrgId)+')';
          Open;
          if IsEmpty then Result := '-А2'
          else
            if Fields[0].AsInteger>0 then Result := '-А1' else Result := '-А2';
        end;
      finally
        Free;
      end;
  s := IniSupport.GetSubjCode;
  if s<>EmptyStr then
    Result := Result + '-' + s;
end;

procedure TdmMain.UpdateCurrentOKBV;
  function GetOKBVNumber: string;
  var n: Integer;
      s: string;
  begin
    with TADOQuery.Create(Self) do begin
      Connection := dbMain;
      SQL.Text :=
      'SELECT O.OKBV'#13+
      'FROM Org O'#13+
      'JOIN SUBJ S ON O.TERR_ID=S.TERR_ID'#13+
      'JOIN CURR_SUBJ ON S.SUBJ_ID=CURR_SUBJ.SUBJ_ID'#13+
      'WHERE O.OrgId='+IntToStr(GetOrgId);
      Open;
      if IsEmpty then s := EmptyStr
      else s := Fields[0].AsString;
      Free;
    end;
    n := 0;
    repeat
      Inc(n);
      if n>Length(s) then break;
      if s[n] in ['0'..'9'] then begin
        Result := EmptyStr;
        while n<=Length(s) do begin
          if not (s[n] in ['0'..'9']) then break;
          Result := Result + s[n];
          Inc(n);
        end;
        break;
      end;
      s := Copy(s,n,10000);
      n := Pos('-',s);
    until n=0;
  end;
var s: string;
begin
  s := GetOKBVNumber;
  if s<>EmptyStr then
    s := LeftStr(s+GetOKBVSuffix(GetOrgId),12);
    with TADOQuery.Create(Self) do
      try
        Connection := dbMain;
        SQL.Text :=
          'UPDATE Org SET OKBV='''+s+''' WHERE OrgId='+IntToStr(GetOrgId);
        ExecSQL;
      finally
        Free;
      end;
end;

function TdmMain.GetLicenceCount: Integer;
var d: TDate;
begin
  Result := 0;
  with TADOQuery.Create(Self) do
  try
    Connection := dbMain;
    SQL.Text := 'select getdate()';
    Open;
    d := Fields[0].Value;
    Close;
    SQL.Text := 'exec master..xp_crypt_list 1546';
    try
      Open;
      while not EOF do begin
        if d<FieldByName('ValidityDate').Value then
          Result := Result + FieldByName('LicenceCount').Value;
        Next;
      end;
      Close;
//substract from result (connection count-1)
      SQL.Text :=
        'select count(spid)'#13+
        'from master.dbo.sysprocesses where dbid=db_id() and spid<>@@spid';
      Open;
      Result := Result - Fields[0].AsInteger;
    except
    end;
    if Result<=0
      then fmMain.Caption := sAppTitle+'(демонстрационный режим)'
      else fmMain.Caption := sAppTitle;
  finally
    Free;
  end;
end;

procedure TdmMain.ChkDemoMode(FAlwaysShowCard: boolean = false);
var
  n, res: Integer;
begin
  if not IsCryptInstalled then begin
    ShowErr('На сервере БД не установлена система лицензирования!'#13+
            'Работа с системой запрещена.'{#13#13+E.Message});
    dbMain.Connected := false;
    Exit;
  end;
  n := GetLicenceCount;
  if FAlwaysShowCard or (n<=0) then begin
    res := ShowActivationCard;
    if res <> 2 then
      if GetLicenceCount<=0 then begin
        dbMain.Connected := false;
        fmMain.Caption := sAppTitle+'(подключение отклонено)';
      end;
  end;
end;

function TdmMain.IsDemoMode: Boolean;
begin
  Result := False;
  //!!! Комментить тут для отключения лицензии
  (*if not IsCryptInstalled then begin
    ShowErr('На сервере БД не установлена система лицензирования!'#13+
            'Работа с системой запрещена.');
    dbMain.Connected := false;
    Exit;
  end;
  Result := GetLicenceCount <= 0;*)
end;

function TdmMain.ShowActivationCard: Integer;
var
    hLib: THandle;
    P: function (ParentWindow: HWND; ConnObject: _Connection; IniFile: PChar; IniSection: PChar): integer; stdcall;
    sIniFile: String;
    sIniSection: String;
begin
  Result := -1;
  try
    hLib := LoadLibrary(PChar(ExtractFilePath(Application.ExeName)+'\RegInfo\gr_reg.dll'));
    if hLib=0 then
      raise Exception.Create('Не найден модуль регистрации!'#13'Продолжение работы невозможно...');
    try
      P := GetProcAddress(hLib,'ShowRegisterDialogADO');
      if @P=nil then
        raise Exception.Create('Модуль регистрации имеет неверный формат!'#13'Продолжение работы невозможно...');
      sIniFile := ExtractFilePath(Application.ExeName)+'\RegInfo\reg_info.ini';
      sIniSection := 'REGISTER';
      Result := P(Application.Handle,dbMain.ConnectionObject,PChar(sIniFile),PChar(sIniSection));
    finally
      FreeLibrary(hLib);
    end;
  except
    on E: Exception do
      ShowErr(E.Message);
  end;
end;

function TdmMain.IsCryptInstalled: boolean;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dbMain;
    SQL.Text := 'select * from master..sysobjects where name like ''xp_crypt_%''';
    Open;
    Result := not IsEmpty;
  finally
    Free;
  end;
end;

function MakeRTFTemplate(Name: PChar; var Size: Integer): Pointer;
var
  ResInfo : HGlobal;
  P       : Pointer;
begin
  ResInfo := FindResource(HInstance, Name, 'RTF');
  Size    := SizeOfResource(HInstance, ResInfo);
  P       := LockResource(LoadResource(HInstance, ResInfo));
  GetMem(Result, Size);
  System.Move(P^, Result^, Size);
end;

procedure TdmMain.FieldGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
const True2X : array [Boolean] of String = (' ','X');
begin
  Text := Sender.AsString;
  Text := True2X[SameText(Text,'true')];
end;

procedure TdmMain.GridToExcel(Grid: TdxDBGrid{TCustomdxTreeListControl}; ACaption: string =''; PrintBands: boolean=false; PrintHeaders: boolean=true);
(*
var CurRow,CurCol: Integer;
    BandMarg: Array[0..255] of Integer;
  procedure StoreNode(node: TdxTreeListNode);
  var i: Integer;
  begin
    for i:=0 to Grid.ColumnCount-1 do
      if Grid.Columns[i].Visible then begin
        CurCol := BandMarg[Grid.Columns[i].BandIndex]+Grid.Columns[i].ColIndex;
        with ExcelApplication do begin
          Cells.Item[CurRow,CurCol].VerticalAlignment := xlJustify;
          Cells.Item[CurRow,CurCol].WrapText := True;
          Cells.Item[CurRow,CurCol] := AnsiReplaceText(AnsiReplaceText(node.Strings[i],'true','X'),'false','');
        end;
      end;
    Inc(CurRow);
    for i:=0 to node.Count-1 do StoreNode(node.Items[i]);
  end;
var i,j,k,n      : Integer;
    Save_Cursor  : TCursor;
    XLsht        : OleVariant;
    lar          : Boolean;*)
var
  FName : String;
  I     : Integer;

begin
  if not dmMain.rPrint then begin
    ShowErr('Вы не обладаете правом на печать документов. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  if ACaption=''
    then FName := 'Отчёт в Excel.XLS'
    else FName := ACaption+'.XLS';
  for I := 1 to Length(FName) do if FName[I] in ['\','/',':','*','?','"','<','>','|']
  then FName[I] := '_';
  FName := GetReportsDir+FName;
  try
    for I := 0 to Grid.ColumnCount-1 do
    if Grid.Columns[I] is TdxDBGridCheckColumn then
    with Grid.Columns[I] do begin
      Field.OnGetText := FieldGetText;
      Alignment := taCenter;
    end;

    Grid.SaveToXLS(FName, True);

    for I := 0 to Grid.ColumnCount-1 do
    if Grid.Columns[I] is TdxDBGridCheckColumn then
      Grid.Columns[I].Field.OnGetText := nil;

    ShellExecute(0,'open',PChar(FName),nil,nil,SW_SHOWMAXIMIZED);
    SaveEvent(dbMain, evs_Report_Print, ACaption,[]);
  except
    SaveEvent(dbMain, evs_Report_Error, ACaption,[]);
    raise;
  end;
(*
  if Grid is TdxDBGrid then with Grid as TdxDBGrid do begin
    lar := edgoLoadAllRecords in OptionsDB;
    if not lar then OptionsDB := OptionsDB+[edgoLoadAllRecords];
  end;
  try
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourglass;    { Show hourglass cursor }

    with ExcelApplication do begin
      try
       Connect;
       Visible[0]:=False;
       Workbooks.Add(NULL, 0);

       CurRow := 1;
  //Store caption
       if ACaption <> '' then begin
         Range[Cells.Item[CurRow, 1], Cells.Item[CurRow, 1]].Font.Bold:= True;
         Range[Cells.Item[CurRow, 1], Cells.Item[CurRow, 1]].Font.Size:= 12;
         Range[Cells.Item[CurRow, 1], Cells.Item[CurRow, Grid.VisibleColumnCount]].HorizontalAlignment := xlHAlignCenterAcrossSelection;
         Cells.Item[CurRow, 1]:= ACaption;
         Inc(CurRow);
       end;
  //Store bands
        CurCol := 1;
        for i:=0 to  Grid.Bands.Count-1 do
          for j:=0 to Grid.Bands.Count-1 do
            if Grid.Bands[j].Visible and (Grid.Bands[j].VisibleIndex=i) then begin
              BandMarg[j] := CurCol;
              n := 0;
              for k:=0 to Grid.ColumnCount-1 do
                if (Grid.Columns[k].BandIndex=Grid.Bands[j].Index) and Grid.Columns[k].Visible then Inc(n);
              if PrintBands and (n>0) then begin
                Cells.Item[CurRow,CurCol] := Grid.Bands[j].Caption;
                with Range[Cells.Item[CurRow,CurCol],Cells.Item[CurRow,CurCol+n-1]] do begin
                  Font.Bold := true;
                  Font.Size := 10;
                  VerticalAlignment := Integer(xlVAlignCenter);
                  HorizontalAlignment := Integer(xlHAlignCenter);
                  Merge(false);
                  with Borders.Item[xlEdgeLeft] do begin
                    LineStyle := xlContinuous;
                    Weight := xlThin;
                    ColorIndex := Integer(xlAutomatic);
                  end;
                  with Borders.Item[xlEdgeTop] do begin
                    LineStyle := xlContinuous;
                    Weight := xlThin;
                    ColorIndex := Integer(xlAutomatic);
                  end;
                  with Borders.Item[xlEdgeBottom] do begin
                    LineStyle := xlContinuous;
                    Weight := xlThin;
                    ColorIndex := Integer(xlAutomatic);
                  end;
                  with Borders.Item[xlEdgeRight] do begin
                    LineStyle := xlContinuous;
                    Weight := xlThin;
                    ColorIndex := Integer(xlAutomatic);
                  end;
                end;
              end;
              Inc(CurCol,n);
              break;
            end;
        if PrintBands then Inc(CurRow);
  //Store column headers
       if PrintHeaders then begin
         for i:=0 to  Grid.ColumnCount-1 do
           if Grid.Columns[i].Visible then begin
             CurCol := BandMarg[Grid.Columns[i].BandIndex]+Grid.Columns[i].ColIndex;
             Cells.Item[CurRow,CurCol].ColumnWidth := Grid.Columns[i].Width/8;
             Cells.Item[CurRow,CurCol] := Trim(Grid.Columns[i].Caption);
             Cells.Item[CurRow,CurCol].HorizontalAlignment := xlCenter;
             Cells.Item[CurRow,CurCol].VerticalAlignment := xlCenter;
             Cells.Item[CurRow,CurCol].WrapText := True;
             with Range[Cells.Item[CurRow,CurCol], Cells.Item[CurRow,CurCol] ] do begin
               Font.Size := 10;
               HorizontalAlignment := Integer(xlHAlignCenter);
               VerticalAlignment := Integer(xlVAlignCenter);
               with Borders.Item[xlEdgeLeft] do begin
                  LineStyle := xlContinuous;
                  Weight := xlThin;
                  ColorIndex := Integer(xlAutomatic);
               end;
               with Borders.Item[xlEdgeTop] do begin
                 LineStyle := xlContinuous;
                 Weight := xlThin;
                 ColorIndex := Integer(xlAutomatic);
               end;
               with Borders.Item[xlEdgeRight] do begin
                 LineStyle := xlContinuous;
                 Weight := xlThin;
                 ColorIndex := Integer(xlAutomatic);
               end;
               with Borders.Item[xlEdgeBottom] do begin
                 LineStyle := xlContinuous;
                 Weight := xlThin;
                 ColorIndex := Integer(xlAutomatic);
               end;
             end;
             with Range[Cells.Item[CurRow+1,CurCol], Cells.Item[65536,CurCol] ] do begin
               NumberFormat := '@';
               Font.Size := 8;
               VerticalAlignment := Integer(xlVAlignCenter);
               case Grid.Columns[i].Alignment of
                 taLeftJustify:  HorizontalAlignment := Integer(xlHAlignLeft);
                 taRightJustify: HorizontalAlignment := Integer(xlHAlignRight);
                 taCenter:       HorizontalAlignment := Integer(xlHAlignCenter);
               end;
             end;
           end;
         Inc(CurRow);
       end;

  //Store data lines
      for i:=0 to Grid.Count-1 do StoreNode(Grid.Items[i]);

  //Prepare print sets
       try
         XLsht := ActiveSheet;
         XLsht.PageSetup.PaperSize := xlPaperA4;
         XLsht.PageSetup.Zoom := 95;
         XLsht.PageSetup.Orientation := xlLandscape;
       except
       end;

      finally
        Visible[0]:=True;
        Disconnect;
        Screen.Cursor := Save_Cursor;  { Always restore to normal }
      end;
    end;
    SaveEvent(dbMain, evs_Report_Print, ACaption,[]);
  except
    SaveEvent(dbMain, evs_Report_Error, ACaption,[]);
    raise;
  end;
  if Grid is TdxDBGrid then with Grid as TdxDBGrid do begin
    if not lar then OptionsDB := OptionsDB-[edgoLoadAllRecords];
  end;
*)
end;

end.

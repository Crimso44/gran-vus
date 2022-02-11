unit dMain;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, ImgList, OleServer, dxTL, Variants, Excel2000, ExcelXP,
  System.ImageList;

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
//    3 - для работы с формой 6
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nF6ID: Integer): Integer; stdcall;
//    4 - для работы со списком
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; szRecords _Recordset): Integer; stdcall;
//    5 - для работы с карточкой организации
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nOrgID: Integer; isConfirm: Boolean): Integer; stdcall;
//    6 - для работы с с формой 26
//        function PlugInExec(AppHandle: THandle; szConn: _Connection; nManID: Integer; nFormID: Integer = -1): Integer; stdcall;
//

  TPlugInSortInfo =
    procedure (szSortName: PChar); stdcall;
  TPlugInExecMain =
    function (AppHandle: THandle; Conn: _Connection): Integer; stdcall;
  TPlugInExecOrg =
    function (AppHandle: THandle; Conn: _Connection; nOrgID: Integer): Integer; stdcall;
  TPlugInExecMan =
    function (AppHandle: THandle; Conn: _Connection; nManID: Integer): Integer; stdcall;
  TPlugInExecF6 =
    function (AppHandle: THandle; Conn: _Connection; nF6ID: Integer): Integer; stdcall;
  TPlugInExecList =
    function (AppHandle: THandle; szConn: _Connection; szRecords: _Recordset): Integer; stdcall;
  TPlugInConfig =
    function (AppHandle: THandle; Conn: _Connection): Integer; stdcall;
  TPlugInExecOrgWithConfirm =
    function (AppHandle: THandle; Conn: _Connection; nOrgID: Integer; isConfirm: Boolean): Integer; stdcall;
  TPlugInExecForm26 =
    function (AppHandle: THandle; Conn: _Connection; nManID: Integer; nFormID: Integer = -1): Integer; stdcall;

  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    ilSmall: TImageList;
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
    { Private declarations }
  public
    { Public declarations }
    ListMTR: TStringList;
    time_out: Cardinal;
    slPlugIns: TStringList;
    rAdmin, rImport, rExport, rPrint, rEdit: Boolean;//User's rights
    isAbcSort: Boolean;
    procedure ScanPlugIns;// имя_dll,имя_плагина,копирайт,тип,image_index

    function DoConnect: boolean;

    function GetOrgID: Integer;
    function GetPersonID: Integer;
    function GetF6ID: Integer;
    procedure GridToExcel(Grid: TCustomdxTreeListControl; ACaption: string =''; PrintBands: boolean=false; PrintHeaders: boolean=true);
    function GetParamValue(Id: Integer): String;
  end;

const
  uFile = 'GranUpdate.dll';
  pFile = 'patch.ini';
var
  dmMain: TdmMain;

function iifStr(condition: Boolean; resTrue, resFalse: String): String;
function Date2SQL(ADate: TDate): string;
function SQL2Date(ASQL: string): TDate;
function MakeRTFTemplate(Name: PChar; var Size: Integer): Pointer;
function CheckUpdateLibrary: Boolean;

implementation

uses IniSupport, msg, fMain, fPersLst, fPersonCard, fGetPsw, SaveEvents, StrUtils,
  uVERSION, IniFiles;

{$R *.DFM}


function iifStr(condition: Boolean; resTrue, resFalse: String): String;
begin
  if condition then
    Result := resTrue
  else
    Result := resFalse;
end;

function TdmMain.DoConnect: boolean;
begin
  Result := false;
  if dbMain.Connected then begin
    //ShowMessage('Close default connection in OBJECT INSPECTOR!');
    SaveEvent(dbMain, evs_Logout,'',['Причина: попытка нового соединения.']);
    dbMain.Connected := false;
  end;
  try
    LoadConnAttr(dbMain);
    dbMain.Connected := true;
  except
    ShowErr(Err_DbConnect + #13 + dbMain.ConnectionString);
    Exit;
  end;
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT top 1 * FROM VerInfo order by VerDate desc';
    try
      Open;
      if FieldByName('VerStr').AsString <> sVersion then begin
        ShowErr('Неверная версия базы данных!'#13'Требуемая версия: ' + sVersion + #13'Версия открываемой базы данных: ' + FieldByName('VerStr').AsString);
        dbMain.Connected := false;
        Exit;
      end;
    except
      SQL.Text := 'select * from VERSION374';
      try
        Open;
        ShowErr('Неверная версия базы данных!'#13'Требуемая версия: ' + sVersion + #13'Версия открываемой базы данных: 3.74');
      except
        SQL.Text := 'select * from VERSION373';
        try
          Open;
          ShowErr('Неверная версия базы данных!'#13'Требуемая версия: ' + sVersion + #13'Версия открываемой базы данных: 3.73');
        except
          ShowErr('Неверная версия базы данных!'#13'Требуемая версия: ' + sVersion + #13'Версия открываемой базы данных: ниже 3.73');
        end;
      end;
      dbMain.Connected := false;
      Exit;
    end;
  finally Free;
  end;
  //dmMain.SaveEvent(evs_Login... - in CheckPassword
  if not CheckPassword then begin
    dbMain.Connected := false;
    Exit;
  end;
  isAbcSort := GetParamValue(6) = '1';
  Result := True;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  slPlugIns := TStringList.Create;
  time_out := IniSupport.GetTimeOut;
  ListMTR := TStringList.Create;
end;

procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  slPlugIns.Free;
  SaveEvent(dbMain, evs_Logout,'',['Причина: Закрытие программы.']);
  ListMTR.Free;
end;

procedure TdmMain.ScanPlugIns;
var sl: TStringList;
    PlugInInfo: TPlugInInfo;
    PlugInSortInfo: TPlugInSortInfo;
    PlugType: Integer;
    PlugName,PlugAuthor, PlugSort: Array[0..1000] of char;
    i, n: Integer;

    procedure ScanDir(path: string);
    var F: TSearchRec;
        fDone: boolean;
        bmp: TBitmap;
        hDll: THandle;
    begin
      fDone := FindFirst(path+'*.*',faAnyFile,F)=0;
      while fDone do begin
        if F.Name[1]<>'.' then begin
          if (F.Attr and faDirectory)<>0 then ScanDir(path+F.Name)
          else
            if UpperCase(ExtractFileExt(F.Name))='.DLL' then begin
              hDll := LoadLibrary(PChar(path+F.Name));
              if hDll=0 then ShowErr('Ошибка при загрузке модуля: '+#13+F.Name)
              else begin
                @PlugInInfo := GetProcAddress(hDll,'PlugInInfo');
                if @PlugInInfo<>nil then begin
                  PlugType := PlugInInfo(PlugName,PlugAuthor);
                  if not (PlugType in [0,1,2,3,4,5,6]) then ShowErr('Неверный формат модуля: '+#13+F.Name)
                  else begin
// имя_dll,имя_плагина,копирайт,тип,image_index
                    sl.Clear;
                    @PlugInSortInfo := GetProcAddress(hDll,'PlugInSortInfo');
                    if @PlugInSortInfo<>nil then begin
                      PlugInSortInfo(PlugSort);
                      sl.Add(path+PlugSort);
                    end else
                      sl.Add(path+F.Name);
                    sl.Add(path+F.Name);
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
  slPlugIns.Sort();
  for i := 0 to slPlugIns.Count - 1 do begin
    sl.CommaText := slPlugIns[i];
    sl.Delete(0);
    slPlugIns[i] := sl.CommaText;
  end;
  sl.Free;
end;

function TdmMain.GetOrgID: Integer;
begin
  with TADOQuery.Create(Self) do begin
    Connection := dbMain;
    SQL.Text := 'SELECT ORGID FROM ORG';
    try
      Open;
      if IsEmpty then Result := 1
      else Result := Fields[0].AsInteger;
    except
      Result := -1;
    end;
    Free;
  end;
end;

function TdmMain.GetF6ID: Integer;
begin
  with TADOQuery.Create(Self) do begin
    Connection := dbMain;
    SQL.Text := 'SELECT F6_ID FROM FORM6HDR';
    try
      Open;
      if IsEmpty then Result := 1
      else Result := Fields[0].AsInteger;
    except
      Result := -1;
    end;
    Free;
  end;
end;

function TdmMain.GetParamValue(Id: Integer): String;
begin
  with TADOQuery.Create(Self) do begin
    Connection := dbMain;
    SQL.Text := 'SELECT Param_Value FROM Params where Param_ID = :Id';
    Parameters.ParseSQL(SQL.Text, True);
    Parameters.ParamByName('Id').Value := Id;
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

function TdmMain.GetPersonID: Integer;
begin
  Result := 0;
  if fmMain.ActiveMDIChild<>nil then
    if fmMain.ActiveMDIChild is TfmPersonList then begin
      if not (fmMain.ActiveMDIChild as TfmPersonList).qrData.IsEmpty then
        Result := (fmMain.ActiveMDIChild as TfmPersonList).qrData.FieldByName('PERS_ID').AsInteger;
    end
    else
      if fmMain.ActiveMDIChild is TfmPersonForm then
        if (fmMain.ActiveMDIChild as TfmPersonForm).btnApply.Enabled then
          ShowInfo('Перед вызовом внешних функций необходимо сохранить введенные данные!')
        else
          Result := (fmMain.ActiveMDIChild as TfmPersonForm).ID;
end;

procedure TdmMain.dbMainWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
begin
  if Command <> nil then begin
    Screen.Cursor := crSQLWait;
    Command.CommandTimeout := Connection.CommandTimeout;
  end;
end;

procedure TdmMain.dbMainExecuteComplete(Connection: TADOConnection;
  RecordsAffected: Integer; const Error: Error;
  var EventStatus: TEventStatus; const Command: _Command;
  const Recordset: _Recordset);
begin
  Screen.Cursor := crDefault;
end;

procedure TdmMain.GridToExcel(Grid: TCustomdxTreeListControl; ACaption: string =''; PrintBands: boolean=false; PrintHeaders: boolean=true);
var CurRow,CurCol: Integer;
    BandMarg: Array[0..255] of Integer;
  procedure StoreNode(node: TdxTreeListNode);
  var i: Integer;
  begin
    if node.HasChildren then begin
      for i:=0 to Grid.ColumnCount-1 do
        if Grid.Columns[i].Visible then begin
          CurCol := BandMarg[Grid.Columns[i].BandIndex]+Grid.Columns[i].ColIndex;
          with ExcelApplication do begin
            Cells.Item[CurRow,CurCol].VerticalAlignment := xlTop;
            Cells.Item[CurRow,CurCol].WrapText := False;
            Cells.Item[CurRow,CurCol] := AnsiReplaceText(AnsiReplaceText(node.Strings[i],'true','X'),'false','');
          end;
          Break;
        end;
    end else begin
      for i:=0 to Grid.ColumnCount-1 do
        if Grid.Columns[i].Visible then begin
          CurCol := BandMarg[Grid.Columns[i].BandIndex]+Grid.Columns[i].ColIndex;
          with ExcelApplication do begin
            Cells.Item[CurRow,CurCol].VerticalAlignment := xlJustify;
            Cells.Item[CurRow,CurCol].WrapText := True;
            Cells.Item[CurRow,CurCol] := AnsiReplaceText(AnsiReplaceText(node.Strings[i],'true','X'),'false','');
          end;
        end;
    end;
    Inc(CurRow);
    for i:=0 to node.Count-1 do StoreNode(node.Items[i]);
  end;
var i,j,k,n: Integer;
    Save_Cursor:TCursor;
    XLsht: OleVariant;
begin
  if not dmMain.rPrint then begin
    ShowErr('Вы не обладаете правом на печать документов. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  try
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourglass;    { Show hourglass cursor }

    with ExcelApplication do begin
      try
       Connect;
       Visible[0]:=True;
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
        Disconnect;
        Screen.Cursor := Save_Cursor;  { Always restore to normal }
      end;
    end;
    SaveEvent(dbMain, evs_Report_Print, ACaption,[]);
  except
    SaveEvent(dbMain, evs_Report_Error, ACaption,[]);
    raise;
  end;
end;

function Date2SQL(ADate: TDate): string;
begin
  Result := '#'+FormatDateTime('mm"/"dd"/"yyyy',ADate)+'#';
end;

function SQL2Date(ASQL: string): TDate;
begin
  Result := EncodeDate(
    StrToInt(Copy(ASQL,8,4)),
    StrToInt(Copy(ASQL,2,2)),
    StrToInt(Copy(ASQL,5,2)) );
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

function CheckUpdateLibrary: Boolean;
begin
  Result := False;
  if FileExists(ExtractFilePath(Application.ExeName) + uFile) then begin
    if not FileExists(ExtractFilePath(Application.ExeName) + pFile) then
      with TIniFile.Create(ExtractFilePath(Application.ExeName) + pFile) do
      try
        WriteBool('HTTP', 'UseHTTP', True);
        WriteString('HTTP', 'URL', 'http://updates.granit.ru/');
        WriteBool('HTTP', 'UseLicense', True);

        WriteBool('DBVersion', 'UseDBVersion', True);
        WriteInteger('DBVersion', 'From', 2);
      finally
        Free;
      end;
    Result := True;
  end;
end;

end.

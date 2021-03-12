unit fBackUp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, dxTLClms, dxTL, dxCntner, dxExEdtr, Db,
  ADODB, ActnList, Variants;

type
  TfmBackUp = class(TForm)
    PC: TPageControl;
    tshMain: TTabSheet;
    tshRestore: TTabSheet;
    tshStore: TTabSheet;
    Image1: TImage;
    Bevel2: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnBack: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    laOperation: TLabel;
    rbBackUp: TRadioButton;
    rbRestore: TRadioButton;
    dxtBackUp: TdxTreeList;
    Label5: TLabel;
    dxTreeList1Column1: TdxTreeListCheckColumn;
    dxTreeList1Column2: TdxTreeListColumn;
    dxTreeList1Column3: TdxTreeListButtonColumn;
    dbMain: TADOConnection;
    ActionList1: TActionList;
    actDummy: TAction;
    actShiftDummy: TAction;
    Label6: TLabel;
    rbFullBase: TRadioButton;
    rbPartBase: TRadioButton;
    Label7: TLabel;
    tshProcess: TTabSheet;
    tmStartStore: TTimer;
    tshDone: TTabSheet;
    lbTotal: TLabel;
    pbTotal: TProgressBar;
    lbCurrent: TLabel;
    pbCurrent: TProgressBar;
    lbFinally: TLabel;
    bvTop: TBevel;
    pnlTop: TPanel;
    Image2: TImage;
    tmStartRestore: TTimer;
    actHelp: TAction;
    Shape1: TShape;
    Shape2: TShape;
    laTop: TLabel;
    procedure tshMainShow(Sender: TObject);
    procedure tshRestoreShow(Sender: TObject);
    procedure tshStoreShow(Sender: TObject);
    procedure dxTreeList1Column3ButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure actDummyExecute(Sender: TObject);
    procedure actShiftDummyExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tshProcessShow(Sender: TObject);
    procedure tmStartStoreTimer(Sender: TObject);
    procedure tshDoneShow(Sender: TObject);
    procedure tmStartRestoreTimer(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure dxtBackUpChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
  private
    { Private declarations }
    path: string;
    rest_name: string;
  public
    { Public declarations }
  end;
var
    fmBackUp: TfmBackUp;

implementation

uses msg, IniSupport, lzss, Dates, ArcData, fBackUpInfo, SaveEvents, WinHelpViewer;

{$R *.DFM}

type
  AMemStream=Array[0..0] of TMemoryStream;
  PMemStream=^AMemStream;

var
  stmSrc,stmDest: TStream;
  AddPart: Single;

function get_char: Integer;
var ch: AnsiChar;
begin
  if stmSrc.Position<stmSrc.Size then begin
     stmSrc.Read(ch,1);
     Result := ord(ch);
     fmBackUp.pbCurrent.Position :=
       Round((fmBackUp.pbCurrent.Max)*(AddPart+stmSrc.Position/stmSrc.Size)/2);
  end
  else begin
    Result := lzss._EOF;
    fmBackUp.pbCurrent.Position := fmBackUp.pbCurrent.Max;
  end;
end;

procedure put_char(c: Integer);
var ch: AnsiChar;
begin
  ch := AnsiChar(c);
  stmDest.Write(ch,1);
end;

function MakeFName(dt: TDateTime): string;
var year,month,day,hour,min,sec,msec: Word;
begin
  DecodeDate(dt,year,month,day);
  DecodeTime(dt,hour,min,sec,msec);
  Result := Format('%.4d%.2d%.2d%.2d%.2d.dat',[year,month,day,hour,min]);
end;

procedure TfmBackUp.FormCreate(Sender: TObject);
begin
//  paMain.Color := clInfoBk;
  Application.HelpFile := ExtractFilePath(Application.ExeName)+'granvus.hlp';
  PC.ActivePageIndex := 0;
  if dbMain.Connected then ShowErr('Close default connection!');
end;

procedure TfmBackUp.actDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmBackUp.actShiftDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmBackUp.btnBackClick(Sender: TObject);
begin
  if (PC.ActivePage=tshStore) or (PC.ActivePage=tshReStore) then
    PC.ActivePage := tshMain;
end;

procedure TfmBackUp.btnNextClick(Sender: TObject);
var i: Integer;
begin
  if PC.ActivePage=tshMain then begin
    if rbBackUp.Checked then begin
      laTop.Caption := 'Резервирование данных  ';
      PC.ActivePage := tshStore
    end
    else PC.ActivePage := tshRestore;
  end
  else
    if PC.ActivePage=tshStore then begin
      laTop.Caption := 'Процесс резервирования данных  ';
      PC.ActivePage := tshProcess;
      tmStartStore.Enabled := true;
    end
    else
      if PC.ActivePage=tshRestore then begin
        rest_name := EmptyStr;
        for i:=0 to dxtBackUp.Count-1 do
          if dxtBackUp.Items[i].Strings[0]='1' then begin
            rest_name := dxtBackUp.Items[i].Strings[3];
            break;
          end;
        if rest_name=EmptyStr then begin
          ShowInfo('Для начала процесса востановления выберите один из '#13+
            'перечисленных в списке снимков базы данных!');
          Exit;
        end;
        if Confirm('Внимание! Процесс восстановления информации из архива'#13+
          'приведет к необратимой потере существующих данных.'#13+
          'Существующие данные можно сохранить, воспользовавшись'#13+
          'командой "Резервирование данных" из раздела меню "Администрирование".'#13#13+
          'Продолжить выполнение операции?') then
        begin
          laTop.Caption := 'Процесс восстановления данных  ';
          PC.ActivePage := tshProcess;
          tmStartRestore.Enabled := true;
        end;
      end;
end;

procedure TfmBackUp.btnCancelClick(Sender: TObject);
begin
  if btnCancel.Caption='Закрыть' then ModalResult := mrOk
  else
    if Confirm('Выйти из мастера резервирования/восстановления данных?') then
      ModalResult := mrCancel;
end;

procedure TfmBackUp.btnHelpClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,HelpContext);
end;

procedure TfmBackUp.tshMainShow(Sender: TObject);
begin
  btnBack.Enabled := false;
  HelpContext := 36;
end;

procedure TfmBackUp.tshStoreShow(Sender: TObject);
begin
  btnBack.Enabled := true;
  bvTop.Parent := tshStore;
  pnlTop.Parent := tshStore;
  pnlTop.Caption := 'Резервирование данных  ';
  HelpContext := 36;
end;

procedure TfmBackUp.tshRestoreShow(Sender: TObject);
var F: TSearchRec;
    fDone: Boolean;
    lst: TStringList;
    i: Integer;
begin
  btnBack.Enabled := true;
  bvTop.Parent := tshRestore;
  pnlTop.Parent := tshRestore;
  pnlTop.Caption := 'Восстановление данных  ';
  path := GetBackUpDir;
  lst := TStringList.Create;
  fDone := FindFirst(path+'*.dat',faAnyFile,F)<>0;
  while not fDone do begin
    lst.Add(F.Name);
    fDone := FindNext(F)<>0;
  end;
  FindClose(F);
  lst.Sort;
  dxtBackUp.ClearNodes;
  for i:=lst.Count-1 downto 0 do begin
    with dxtBackUp.Add do begin
      if i=lst.Count-1 then Strings[0] := '1' else Strings[0] := '0';
      Strings[1] := 'Снимок БД от '+
        Copy(lst[i],7,2)+'.'+Copy(lst[i],5,2)+'.'+Copy(lst[i],1,4)+' '+
        Copy(lst[i],9,2)+':'+Copy(lst[i],11,2);
      Strings[3] := path+lst[i];
    end;
  end;
  lst.Free;
  HelpContext := 36;
end;

procedure TfmBackUp.dxTreeList1Column3ButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
begin
  ShowBackUpInfo(dxtBackUp.FocusedNode.Strings[3]);
end;

procedure TfmBackUp.tshProcessShow(Sender: TObject);
begin
  btnBack.Visible := false;
  btnNext.Visible := false;
  bvTop.Parent := tshProcess;
  pnlTop.Parent := tshProcess;
end;


procedure TfmBackUp.tmStartStoreTimer(Sender: TObject);
  function SortTables(List: TStringList; Index1, Index2: Integer): Integer;
  begin
    Result := StrToInt(List.Values[List.Names[Index1]])-StrToInt(List.Values[List.Names[Index2]]);
  end;

var
  ArcHead: TArcHeader;
  TableData: PTableHeader;
  TblStreams: PMemStream;
  lstTables: TStringList;

  procedure BackUpTable(index: Integer);
  var st: TMemoryStream;
  var lst: TStringList;
      i:   Integer;
      s:   AnsiString;
  begin
    FillChar(TableData[index].TblName,sizeof(TableData[index].TblName),0);
    for i:=1 to Length(lstTables.Names[index]) do
      TableData[index].TblName[i-1] := AnsiChar(lstTables.Names[index][i]);
    lbTotal.Caption := 'Создание копии данных...';
    lbCurrent.Caption := 'Таблица '+lstTables.Names[index];
    pbCurrent.Position := 0;
    Update;
    lst := TStringList.Create;
    st := TMemoryStream.Create;
    with TADOTable.Create(fmBackUp) do begin
      Connection := dbMain;
      TableName := lstTables.Names[index];
      Open;
      pbCurrent.Max := RecordCount*2+1;
      TableData[index].FldCount := Fields.Count;
      TableData[index].RecCount := RecordCount;
      lst.Clear;
      for i:=0 to Fields.Count-1 do begin
        lst.Add(Fields[i].FieldName);
        if Fields[i].DataType = ftAutoInc then Sort := Fields[i].FieldName;
      end;
      s := AnsiString(lst.CommaText)+#127;
      st.Write(s[1],Length(s));
      pbCurrent.StepIt;
      while not EOF do begin
        lst.Clear;
        for i:=0 to Fields.Count-1 do
          if not (Fields[i].DataType in [ftDate,ftDateTime]) then
           lst.Add(Fields[i].AsString)
          else
            if Fields[i].IsNull then lst.Add(EmptyStr)
            else lst.Add(Date2Str(Fields[i].AsDateTime));
        s := AnsiString(lst.CommaText)+#127;
        st.Write(s[1],Length(s));
        pbCurrent.StepIt;
        Next;
      end;
      Free;
    end;
    lst.Free;
    st.Position := 0;
    stmSrc := st;
    TblStreams[index].Clear;
    stmDest := TblStreams[index];
    @lzss.getc := @get_char;
    @lzss.putc := @put_char;
    AddPart := 1;
    lzss.Encode;
    @lzss.getc := nil;
    @lzss.putc := nil;
    st.Free;
    TableData[index].DataSize := TblStreams[index].Size;
    pbTotal.StepIt;
  end;
var
  i: Integer;
begin
  tmStartStore.Enabled := false;
  lbTotal.Caption := 'Определение списка таблиц с данными...';
  Update;
  path := GetBackUpDir;
  lstTables := TStringList.Create;
  try
    lstTables.LoadFromFile(ExtractFilePath(Application.ExeName)+'BACKUP.CFG');
    //remove non used tables
    if rbPartBase.Checked then
      for i:=lstTables.Count-1 downto 0 do
        if Pos(',0',lstTables.Values[lstTables.Names[i]])>0 then lstTables.Delete(i);
    //remove table state
    for i:=0 to lstTables.Count-1 do
      lstTables[i] := Copy(lstTables[i],1,Length(lstTables[i])-2);
    //sort items
    lstTables.CustomSort(@SortTables);
    //
    if lstTables.Count=0 then raise EIntError.Create('Error!');
  except
    SaveEvent(dbMain, evs_Backup_Failed, '', [
      'Ошибка при загрузке списка таблиц для резервирования.']);
    ShowErr('Ошибка при загрузке списка таблиц для резервирования!'#13+
      'Возможно конфигурационный файл имеет некорректный формат.');
    lstTables.Free;
    ModalResult := mrCancel;
    Exit;
  end;
  try
    ArcHead.ArcID := _ArcID;
    ArcHead.ArcDate := DateTimeToTimeStamp(Now);
    ArcHead.TableCount := lstTables.Count;
    GetMem(TableData,sizeof(TTableHeader)*ArcHead.TableCount);
    GetMem(TblStreams,sizeof(TblStreams)*ArcHead.TableCount);
    for i:=0 to ArcHead.TableCount-1 do TblStreams[i] := TMemoryStream.Create;
    pbTotal.Max := ArcHead.TableCount+2;
    pbTotal.StepIt;
    try
      for i:=0 to ArcHead.TableCount-1 do BackUpTable(i);
    except
      on E: Exception do begin
        SaveEvent(dbMain, evs_Backup_Failed, '', [E.ClassName+': '+E.Message]);
        ShowErr('Ошибка при создании копии данных!'#13#13+
          E.ClassName+': '+E.Message);
        ModalResult := mrCancel;
        Exit;
      end;
    end;
    try
      with TMemoryStream.Create do begin
        Write(ArcHead,sizeof(ArcHead));
        for i:=0 to ArcHead.TableCount-1 do begin
          if i=0 then
            TableData[i].DataOffset := sizeof(ArcHead) + sizeof(TableData[0])*ArcHead.TableCount
          else
            TableData[i].DataOffset := TableData[i-1].DataOffset + TblStreams[i-1].Size;
          Write(TableData[i],sizeof(TableData[i]));
        end;
        for i:=0 to ArcHead.TableCount-1 do begin
          TblStreams[i].Position := 0;
          CopyFrom(TblStreams[i],TblStreams[i].Size);
        end;
        SaveToFile(path+MakeFName(TimeStampToDateTime(ArcHead.ArcDate)));
        Free;
      end;
      pbTotal.StepIt;
    except
      SaveEvent(dbMain, evs_Backup_Failed, '', [
        'Ошибка при сохранении копии данных в файл.',
        path+MakeFName(TimeStampToDateTime(ArcHead.ArcDate))]);
      ShowErr('Ошибка при сохранении копии данных!');
      ModalResult := mrCancel;
      Exit;
    end;
  finally
    for i:=0 to ArcHead.TableCount-1 do TblStreams[i].Free;
    FreeMem(TblStreams);
    FreeMem(TableData);
    lstTables.Free;
  end;
  SaveEvent(dbMain, evs_Backup, '', [path+MakeFName(TimeStampToDateTime(ArcHead.ArcDate))]);
  PC.ActivePage := tshDone;
end;

procedure TfmBackUp.tmStartRestoreTimer(Sender: TObject);
    function GetLine(st: TStream): string;
    var
      ch: AnsiChar;
      res: AnsiString;
      b: Byte;
    begin
      res := EmptyStr;
      while st.Position<st.Size do begin
        st.Read(b,1);
        ch := AnsiChar(b);
        if ch=#127 then break
        else res := res + ch;
      end;
      Result := String(res);
    end;
var ArcHead: TArcHeader;
    TblData: PTableHeader;
    F: TFileStream;
    i,j,n,k: Integer;
    lstFields,lstData: TStringList;
    s: string;
    KeyName  : String; //name of counter field
    KeyValue : String; //backuped value of counter
begin
  tmStartRestore.Enabled := false;
  lbTotal.Caption := 'Чтение заголовка архива...';
  Update;
  try
    F := TFileStream.Create(rest_name,fmOpenRead);
    F.Read(ArcHead,sizeof(TArcHeader));
    if ArcHead.ArcID<>_ArcID then begin
      SaveEvent(dbMain, evs_Restore_Failed, '', [
        'Указанный файл не является снимком базы данных'+
        'или имеет поврежденную структуру.',
        rest_name]);
      ShowErr('Указанный файл не является снимком базы данных'#13+
        'или имеет поврежденную структуру!');
      ModalResult := mrCancel;
      F.Free;
      Exit;
    end;
    GetMem(TblData,sizeof(TTableHeader)*ArcHead.TableCount);
    try
      for i:=0 to ArcHead.TableCount-1 do
        F.Read(TblData[i],sizeof(TTableHeader));
      pbTotal.Max := ArcHead.TableCount+2;
      pbTotal.Position := 1;
//deleting existing data
      lbTotal.Caption := 'Удаление существующей информации...';
      Update;
      pbCurrent.Max := ArcHead.TableCount;
      pbCurrent.Position := 0;
      for i:=ArcHead.TableCount-1 downto 0 do
        try
          lbCurrent.Caption := 'Таблица '+TblData[i].TblName;
          Update;
          with TADOTable.Create(Self) do begin
            Connection := dbMain;
            TableName := TblData[i].TblName;
            Open;
            while not IsEmpty do Delete;
            Free;
          end;
          pbCurrent.StepIt;
        except on e:Exception do begin
          SaveEvent(dbMain, evs_Restore_Failed, '', ['Ошибка при обращении к базе данных.']);
          ShowErr('Ошибка при обращении к базе данных!'#13+e.Message);
          ModalResult := mrCancel;
          Exit;
        end; end;
      pbTotal.StepIt;
//restoring data
      lbTotal.Caption := 'Востановление данных...';
      for i:=0 to ArcHead.TableCount-1 do begin
        AddPart := 0;
        lbCurrent.Caption := 'Таблица '+TblData[i].TblName;
        pbCurrent.Position := 0;
        pbCurrent.Max := TblData[i].RecCount*2;
        Update;
        stmSrc := TMemoryStream.Create;
        F.Position := TblData[i].DataOffset;
        stmSrc.CopyFrom(F,TblData[i].DataSize);
        stmSrc.Position := 0;
        stmDest := TMemoryStream.Create;
        @lzss.getc := @get_char;
        @lzss.putc := @put_char;
        lstFields := TStringList.Create;
        lstData := TStringList.Create;
        try
          lzss.Decode;
          @lzss.getc := nil;
          @lzss.putc := nil;
          stmDest.Position := 0;
          lstFields.CommaText := AnsiUpperCase(GetLine(stmDest));
          try
            with TADOTable.Create(Self) do begin
              Connection := dbMain;
              TableName := TblData[i].TblName;
              Open;
              KeyName := '';
              for n:=0 to Fields.Count-1 do if Fields[n].DataType = ftAutoInc
              then begin
                KeyName := Fields[n].FieldName;
                Close;
                with TADOQuery.Create(nil) do
                try
                  Connection := dbMain;
                  ParamCheck := False;
                  SQL.Text   := Format('ALTER TABLE [%s] ALTER COLUMN [%s] Counter(1,1)',
                    [TableName,KeyName]);
                  ExecSQL;
                finally Free;
                end;
                Open;
                Break;
              end;
              for n:=0 to TblData[i].RecCount-1 do begin
                lstData.CommaText :=  GetLine(stmDest);
                while lstData.Count<TblData[i].FldCount do lstData.Add(EmptyStr);
                repeat // we have to grow counter if buckup has hole in counter sequence
                  Append;
                  KeyValue := '';
                  for j:=0 to Fields.Count-1 do begin
                    k := lstFields.IndexOf(AnsiUpperCase(Fields[j].FieldName));
                    if k>=0 then begin
                      s := lstData[k];
                      if Fields[j].DataType <> ftAutoInc then begin
                        if (s=EmptyStr) or (s='0000-00-00') then Fields[j].Value := NULL
                        else
                          if Fields[j].DataType in [ftDate,ftDateTime] then
                            Fields[j].Value := Str2Date(s)
                          else
                            Fields[j].Value := s;
                      end
                      else KeyValue := s;
                    end;
                  end;
                  Post;
                  if (KeyName = '') or (FieldByName(KeyName).AsString=KeyValue) then Break;
                  Delete;
                until False;
                pbCurrent.StepIt;
              end;
              Free;
            end;
          except
            on e: Exception do begin
              SaveEvent(dbMain, evs_Restore_Failed, '', [
                'Ошибка при восстановлении таблицы.',
                TblData[i].TblName]);
              ShowErr('Ошибка при восстановлении!'#13+e.Message);
            end;
          end;
        finally
          stmSrc.Free;
          stmDest.Free;
          lstFields.Free;
          lstData.Free;
        end;
        pbTotal.StepIt;
      end;
    finally
      F.Free;
      FreeMem(TblData);
    end;
  except
    SaveEvent(dbMain, evs_Restore_Failed, '', ['Ошибка при обращении к снимку БД.']);
    ShowErr('Ошибка при обращении к снимку БД!');
    ModalResult := mrCancel;
    Exit;
  end;
  SaveEvent(dbMain, evs_Restore, '', [rest_name]);
  PC.ActivePage := tshDone;
end;

procedure TfmBackUp.tshDoneShow(Sender: TObject);
begin
  bvTop.Parent := tshDone;
  pnlTop.Parent := tshDone;
  pnlTop.Caption := 'Операция завершена  ';
  if rbBackUp.Checked then
    lbFinally.Caption :=
      'Операция резервного копирования успешно завершена.'#13#13+
      'Нажмите кнопку "Закрыть" для возврата в приложение...'
  else
    lbFinally.Caption :=
      'Операция восстановления базы данных успешно завершена.'#13#13+
      'Нажмите кнопку "Закрыть" для возврата в приложение...';
  btnCancel.Caption := 'Закрыть';
  btnCancel.Default := true;
end;

procedure TfmBackUp.actHelpExecute(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;


procedure TfmBackUp.dxtBackUpChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  if Assigned(OldNode) then OldNode.Values[0] := 0;
  Node.Values[0] := 1;
end;

end.

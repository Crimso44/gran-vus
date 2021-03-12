unit fImport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, ExtCtrls, StdCtrls, ComCtrls, Buttons, ActnList, Db, Variants;

type
  TfmImport = class(TForm)
    btnBack: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    PC: TPageControl;
    tshInfo: TTabSheet;
    tshParams: TTabSheet;
    Bevel1: TBevel;
    pnlTop: TPanel;
    Image2: TImage;
    lbTop: TLabel;
    bvTop: TBevel;
    Label5: TLabel;
    rbFloppy: TRadioButton;
    rbPath: TRadioButton;
    rbEMail: TRadioButton;
    edPath: TEdit;
    edEMail: TEdit;
    sbPath: TSpeedButton;
    tshProcess: TTabSheet;
    tshDone: TTabSheet;
    Label6: TLabel;
    Label7: TLabel;
    tmGo: TTimer;
    pbProc: TProgressBar;
    dbMain: TADOConnection;
    ActionList1: TActionList;
    actDummy: TAction;
    actShiftDummy: TAction;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    sbEMail: TSpeedButton;
    Shape1: TShape;
    Shape2: TShape;
    procedure btnCancelClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure rbFloppyClick(Sender: TObject);
    procedure tshInfoShow(Sender: TObject);
    procedure tshParamsShow(Sender: TObject);
    procedure tshProcessShow(Sender: TObject);
    procedure tshDoneShow(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure sbPathClick(Sender: TObject);
    procedure tmGoTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actDummyExecute(Sender: TObject);
    procedure actShiftDummyExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OrgID: Integer;
  end;


implementation

uses msg, FileCtrl, Dates, SaveEvents, WinHelpViewer;

{$R *.DFM}

procedure TfmImport.btnCancelClick(Sender: TObject);
begin
  if btnCancel.Caption='Закрыть' then ModalResult := mrOk
  else
    if Confirm('Прервать процесс обмена данными?') then ModalResult := mrCancel;
end;

procedure TfmImport.btnHelpClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,HelpContext);
end;

procedure TfmImport.rbFloppyClick(Sender: TObject);
begin
  edPath.Enabled := rbPath.Checked;
  sbPath.Enabled := rbPath.Checked;
  if edPath.Enabled then edPath.Color := clWindow
  else edPath.Color := clBtnFace;
  edEMail.Enabled := rbEMail.Checked;
  if edEmail.Enabled then edEmail.Color := clWindow
  else edEmail.Color := clBtnFace;
end;

procedure TfmImport.tshInfoShow(Sender: TObject);
begin
  btnBack.Enabled := false;
end;

procedure TfmImport.tshParamsShow(Sender: TObject);
begin
  lbTop.Caption := 'Выбор параметров импорта данных';
  btnBack.Enabled := true;
  pnlTop.Parent := tshParams;
  bvTop.Parent := tshParams;
end;

procedure TfmImport.tshProcessShow(Sender: TObject);
begin
  lbTop.Caption := 'Процесс импорта данных';
  btnBack.Visible:= false;
  btnNext.Visible := false;
  pnlTop.Parent := tshProcess;
  bvTop.Parent := tshProcess;
  tmGo.Enabled := true;
end;

procedure TfmImport.tshDoneShow(Sender: TObject);
begin
  lbTop.Caption := 'Импорт данных завершен';
  btnCancel.Caption := 'Закрыть';
  btnCancel.Default := true;
  pnlTop.Parent := tshDone;
  bvTop.Parent := tshDone;
end;

procedure TfmImport.btnBackClick(Sender: TObject);
begin
  PC.ActivePageIndex := PC.ActivePageIndex-1;
end;

procedure TfmImport.btnNextClick(Sender: TObject);
begin
  if PC.ActivePage=tshParams then begin
  //check params
    if rbPath.Checked and (Trim(edPath.Text)=EmptyStr) then begin
      edPath.SetFocus;
      ShowErr('Укажите размещение файлов на диске...');
      Exit;
    end;
    if rbEMail.Checked and (Trim(edEMail.Text)=EmptyStr) then begin
      edEMail.SetFocus;
      ShowErr('Укажите файл сообщения электронной почты...');
      Exit;
    end;
  end;
  PC.ActivePageIndex := PC.ActivePageIndex+1;
end;

procedure TfmImport.sbPathClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Укажите размещение файлов на диске...',EmptyStr,s) then
    edPath.Text := s;
end;

procedure TfmImport.tmGoTimer(Sender: TObject);
  function GetTerrId(s: string): Integer;
  begin
    with TADOTable.Create(Self) do
    try
      Connection := dbMain;
      TableName := 'KTERR';
      Active := true;
      if not Locate('KODTERR',s,[]) then begin
        Append;
        FieldbyName('KODTERR').Value := s;
        FieldbyName('NAME').Value := 'ВУО с кодом '+s;
        Post;
      end;
      Result := FieldbyName('TERR_ID').AsInteger;
    finally
      Free;
    end;
  end;
  procedure SetF6Shifr(s: string);
  begin
    with TADOQuery.Create(Self) do
    try
      Connection := dbMain;
      SQL.Text := 'UPDATE Form6Hdr Set F6_Shifr='''+s+'''';
      ExecSQL;
    finally
      Free;
    end;
  end;
  function Str2DateNull(S: String): Variant;
  begin
    if S='' then Result := NULL else Result := Str2Date(S);
  end;
var path: string;
    buf: Array[0..MAX_PATH-1] of char;
    F: TextFile;
    lst: TStringList;
    lst_head: TStringList;
    n: Integer;
    s: string;
//
  function LstValue(AFile, AField: String):String;
  var n: Integer;
  begin
    n := lst_head.IndexOf(AField);
    if (n<0) or (n>lst.Count-1) then raise Exception.Create(
      'формат файла импорта поврежден: "'+AFile+'"');
    Result := lst[n];  
  end;
//
  function GetOVK_ID(OVK_NAME: string): variant;
  begin
    OVK_NAME := Trim(OVK_NAME);
    with TADOTable.Create(Self) do
    try
      Connection := dbMain;
      TableName := 'KOVK';
      Open;
      Result:= Lookup('OVK_NAME', OVK_NAME,'OVK_ID');
      if VarIsNull(Result) and (OVK_NAME <> '') then
//        if Confirm('В справочнике отсутствует военкомат: ' + OVK_NAME + '. Добавить?') then begin
          Append;
          FieldByName('OVK_NAME').AsString := OVK_NAME;
          Post;
          Result:= Lookup('OVK_NAME', OVK_NAME,'OVK_ID');
//        end;
    finally Free;
    end;
  end;
//
begin
  tmGo.Enabled := false;
  Application.ProcessMessages;
  lst := TStringList.Create;
  lst_head := TStringList.Create;
  try
    if rbFloppy.Checked then path := 'A:\'
    else
      if rbPath.Checked then path := Trim(edPath.Text)
      else begin
        GetTempPath(MAX_PATH,buf);
        path := string(buf)+'\'+'GranVUS';
      end;
    if Length(path)>0 then
     if path[Length(path)]<>'\' then path := path + '\';
    pbProc.Max := 6;
    AssignFile(F,path+'org.csv');
    ReSet(F);
    pbProc.StepIt;
    ReadLn(F,s);
    lst_head.CommaText := AnsiUpperCase(s);
    ReadLn(F,s);
    lst.CommaText := s;
    with TADOTable.Create(Self) do
    try
      Connection := dbMain;
      TableName := 'ORG';
      Open;
      Edit;
      FieldByName('HAS_BRON')   .Value := Boolean(StrToInt(LstValue('org.csv','HAS_BRON')));
      FieldByName('OKBV')       .Value := LstValue('org.csv','OKBV');
      FieldByName('F6_SHIFR')   .Value := LstValue('org.csv','F6_SHIFR');
      SetF6Shifr(FieldByName('F6_SHIFR').AsString);
      FieldByName('FIRST_DATE') .Value := Str2DateNull(LstValue('org.csv','FIRST_DATE'));
      FieldByName('LAST_DATE')  .Value := Str2DateNull(LstValue('org.csv','LAST_DATE'));
      FieldByName('TERR_ID')    .Value := GetTerrId(LstValue('org.csv','KODTERR'));
      FieldByName('SBM_ID')     .Value := StrToIntDef(LstValue('org.csv','SBM_ID'),0);
      FieldByName('EXT_ID')     .Value := StrToIntDef(LstValue('org.csv','EXT_ID'),0);
      FieldByName('Feature1')   .Value := LstValue('org.csv','Feature1');
      FieldByName('Feature2')   .Value := LstValue('org.csv','Feature2');
      FieldByName('Feature3')   .Value := LstValue('org.csv','Feature3');
      FieldByName('OVK_ID')     .Value := GetOVK_ID(LstValue('org.csv','OVK_NAME'));
      Post;
    finally
      if State = dsEdit then Cancel;
      Free;
      CloseFile(F);
    end;
    pbProc.StepIt;
    AssignFile(F,path+'orgosn.csv');
    ReSet(F);
    pbProc.StepIt;
    ReadLn(F,s);
    lst_head.CommaText := AnsiUpperCase(s);
    with TADOTable.Create(Self) do
    try
      Connection := dbMain;
      TableName := 'OSN';
      Open;
      while not IsEmpty do Delete;
      while not System.EOF(F) do begin
        ReadLn(F,s);
        lst.CommaText := s;
        Insert;
        for n:=0 to lst.Count-1 do
          if FindField(lst_head[n])=nil then
            raise Exception.Create('формат файла импорта поврежден: "orgosn.csv"')
          else
            case FieldByName(lst_head[n]).DataType of
              ftDate,ftDateTime:
                if lst[n]=EmptyStr then
                  FieldByName(lst_head[n]).Value := NULL
                else
                  FieldByName(lst_head[n]).Value := Str2Date(lst[n]);
              else
                if lst[n]=EmptyStr then
                  FieldByName(lst_head[n]).Value := NULL
                else
                  FieldByName(lst_head[n]).AsString := lst[n];
            end;
        Post;
      end;
    finally
      if State = dsInsert then Cancel;
      Free;
      CloseFile(F);
    end;
    pbProc.StepIt;
//    AssignFile(F,path+'orgper.csv');
//    ReSet(F);
    pbProc.StepIt;
//    ReadLn(F,s);
//    lst_head.CommaText := AnsiUpperCase(s);
//    with TADOTable.Create(Self) do
//    try
//      Connection := dbMain;
//      TableName := 'PER';
//      Open;
//      while not IsEmpty do Delete;
//      while not System.EOF(F) do begin
//        ReadLn(F,s);
//        lst.CommaText := s;
//        Insert;
//        for n:=0 to lst.Count-1 do
//          if FindField(lst_head[n])=nil then
//            raise Exception.Create('формат файла импорта поврежден: "orgper.csv"')
//          else
//            case FieldByName(lst_head[n]).DataType of
//              ftDate,ftDateTime:
//                if lst[n]=EmptyStr then
//                  FieldByName(lst_head[n]).Value := NULL
//                else
//                  FieldByName(lst_head[n]).Value := Str2Date(lst[n]);
//              else
//                if lst[n]=EmptyStr then
//                  FieldByName(lst_head[n]).Value := NULL
//                else
//                  FieldByName(lst_head[n]).AsString := lst[n];
//            end;
//        Post;
//      end;
//    finally
//      if State = dsInsert then Cancel;
//      Free;
//      CloseFile(F);
//    end;
    pbProc.StepIt;
    PC.ActivePage := tshDone;
  except
    on E:Exception do begin
      SaveEvent(dbMain, evs_Import_Failed, '', [E.ClassName+': '+E.Message]);
      ShowErr('Ошибка при импорте данных!'#13#13+
        E.ClassName+': '+E.Message);
      ModalResult := mrCancel;
      lst_head.Free;
      lst.Free;
    end;
  end;
  SaveEvent(dbMain, evs_Import, '', [path]);
end;

procedure TfmImport.FormCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMEssage('Close default connection!');
  PC.ActivePageIndex := 0;
  Application.HelpFile := ExtractFilePath(Application.ExeName)+'granvus.hlp';
end;

procedure TfmImport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key=VK_TAB) then Key := 0; 
end;

procedure TfmImport.actDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmImport.actShiftDummyExecute(Sender: TObject);
begin
//
end;

end.

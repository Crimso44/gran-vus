unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, ExtCtrls, StdCtrls, ComCtrls, Buttons, ActnList, Db;

type
  TMainForm = class(TForm)
    btnBack: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    PC: TPageControl;
    tshInfo: TTabSheet;
    tshSource: TTabSheet;
    Bevel1: TBevel;
    pnlTop: TPanel;
    Image2: TImage;
    lbTop: TLabel;
    bvTop: TBevel;
    Label5: TLabel;
    edPath: TEdit;
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
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    tshConfirm: TTabSheet;
    Label8: TLabel;
    dbSrc1: TADOConnection;
    dbSrc2: TADOConnection;
    StateLabel: TLabel;
    qrCreate: TADOQuery;
    tSrc1: TADOTable;
    tSrc2: TADOTable;
    tDest: TADOTable;
    qrTransform: TADOQuery;
    TableLabel: TLabel;
    qrSubj: TADOQuery;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    edSubjName: TEdit;
    edOKATO: TEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure tshInfoShow(Sender: TObject);
    procedure tshSourceShow(Sender: TObject);
    procedure tshProcessShow(Sender: TObject);
    procedure tshDoneShow(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure sbPathClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actDummyExecute(Sender: TObject);
    procedure actShiftDummyExecute(Sender: TObject);
    procedure tshConfirmShow(Sender: TObject);
    procedure tmGoTimer(Sender: TObject);
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
  public
  end;

var
  MainForm: TMainForm;
  fBreak: boolean;

implementation

uses msg, FileCtrl, IniSupport, IniFiles;

{$R *.DFM}

procedure TMainForm.btnCancelClick(Sender: TObject);
begin
  if btnCancel.Caption='Закрыть' then Close
  else
    if not fBreak then
     fBreak := Confirm('Прервать процесс преобразования данных?');
end;

procedure TMainForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,HelpContext);
end;

procedure TMainForm.tshInfoShow(Sender: TObject);
begin
  btnBack.Enabled := false;
end;

procedure TMainForm.tshSourceShow(Sender: TObject);
begin
  lbTop.Caption := 'Выбор источника данных';
  btnBack.Enabled := true;
  pnlTop.Parent := tshSource;
  bvTop.Parent := tshSource;
end;

procedure TMainForm.tshConfirmShow(Sender: TObject);
begin
  lbTop.Caption := 'Начало преобразования';
  pnlTop.Parent := tshConfirm;
  bvTop.Parent := tshConfirm;
end;

procedure TMainForm.tshProcessShow(Sender: TObject);
begin
  lbTop.Caption := 'Процесс преобразования данных';
  btnBack.Visible:= false;
  btnNext.Visible := false;
  pnlTop.Parent := tshProcess;
  bvTop.Parent := tshProcess;
  tmGo.Enabled := true;
end;

procedure TMainForm.tshDoneShow(Sender: TObject);
begin
  lbTop.Caption := 'Преобразование данных завершено';
  btnCancel.Caption := 'Закрыть';
  btnCancel.Default := true;
  pnlTop.Parent := tshDone;
  bvTop.Parent := tshDone;
end;

procedure TMainForm.btnBackClick(Sender: TObject);
begin
  PC.ActivePageIndex := PC.ActivePageIndex-1;
end;

procedure TMainForm.btnNextClick(Sender: TObject);
var
  r: Boolean;
begin
  if PC.ActivePage = tshSource then
  try
    if edPath.Text = '' then begin
      ShowErr('Необходимо указать путь');
      Exit;
    end else
      if edPath.Text[Length(edPath.Text)] <> '\' then
        edPath.Text:= edPath.Text + '\';

    dbMain.Connected := false;
    LoadConnAttr(dbMain);
    dbMain.Connected := true;

    with qrSubj do begin
      Open;
      r:= RecordCount = 1;
      if r then begin
        edSubjName.Text:= FieldValues['SUBJ_NAME'];
        edOKATO.Text:= FieldValues['KODTERR'];
      end;
      Close;
    end;

    if not r then begin
      ShowErr('Необходимо создать текущий территориальный орган в списке территориальных органов комплекса ПО "Гран-Бронирование 3.01".');
      dbMain.Connected := false;
      Exit;
    end;

    dbSrc1.Connected := false;
    dbSrc1.ConnectionString :=
        'Provider=Microsoft.Jet.OLEDB.4.0;'+
        'Extended Properties=dBase 5.0;'+
        'Persist Security Info=False;'+
        'Data Source='+edPath.Text+';';
    dbSrc1.Connected := true;

    dbSrc2.Connected := false;
    dbSrc2.ConnectionString :=
        'Provider=Microsoft.Jet.OLEDB.4.0;'+
        'Extended Properties=dBase 5.0;'+
        'Persist Security Info=False;'+
        'Data Source='+edPath.Text+'\POLIGON\;';
    dbSrc2.Connected := true;

    PC.ActivePageIndex := PC.ActivePageIndex+1;
  except
    ShowErr(Err_DbConnect);
    dbMain.Connected := false;
    dbSrc1.Connected := false;
    dbSrc2.Connected := false;
  end else
    PC.ActivePageIndex := PC.ActivePageIndex+1;
end;

procedure TMainForm.sbPathClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выберите путь к данным...',EmptyStr,s) then
    edPath.Text := s;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  if dbMain.Connected or dbSrc1.Connected or dbSrc2.Connected then ShowMEssage('Close default connection!');
  PC.ActivePageIndex := 0;
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key=VK_TAB) then Key := 0;
end;

procedure TMainForm.actDummyExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.actShiftDummyExecute(Sender: TObject);
begin
//
end;

procedure TMainForm.tmGoTimer(Sender: TObject);
var
  Src1Tables: TStringList;
  Src2Tables: TStringList;

  procedure CopyTable(var SrcDS: TADOTable; var DestDS: TADOTable; AName: string);
  var
    n: Integer;
  begin
    try
      TableLabel.Caption:= AName;
      Application.ProcessMessages;
      SrcDS.Close;
      DestDS.Close;
      SrcDS.TableName:= '['+AName + '.dbf]';
      DestDS.TableName:= '[dbo].[#' + AName + ']';
      SrcDS.Open;
      DestDS.Open;
      while not SrcDS.EOF do begin
        TableLabel.Caption:= AName + ', ' + IntToStr(SrcDS.RecNo);
        TableLabel.Update;
        DestDS.Append;
        for n:= 0 to SrcDS.FieldCount - 1 do
          try
            DestDS.FieldByName(SrcDS.Fields[n].FieldName).Value:= SrcDS.Fields[n].Value;
          except
          end;
        try
          DestDS.Post;
        except
          ShowErr('Ошибка при добавлении записи: '+IntToStr(SrcDS.RecNo)+'.'#13'Запись будет пропущена...');
          if DestDS.State in [dsEdit,dsInsert] then DestDS.Cancel;
        end;
        SrcDS.Next;
        Application.ProcessMessages;
        if fBreak then break;
      end;
    finally
      SrcDS.Close;
      DestDS.Close;
    end;
  end;

var
  i: integer;
  cnt: Cardinal;
begin
  tmGo.Enabled := false;
  TableLabel.Caption:= '';
  btnCancel.Caption := 'Превать';
// delay in 3 second
  cnt := GetTickCount;
  while (GetTickCount<cnt+3000) and not fBreak do Application.ProcessMessages;
  if fBreak then begin
    Close;
    Exit;
  end;
  try
    Src1Tables:= TStringList.Create;
    Src2Tables:= TStringList.Create;
    try
      with TIniFile.Create(ExtractFilePath(Application.ExeName)+'dbmaster.ini') do try
        ReadSection('BASE', Src1Tables);
        ReadSection('POLIGON', Src2Tables);
      finally
        Free;
      end;
      pbProc.Max:= Src1Tables.Count + Src2Tables.Count + 3;

      StateLabel.Caption:= 'Создание временных таблиц...';
      Application.ProcessMessages;
      qrCreate.SQL.LoadFromFile(ExtractFilePath(Application.ExeName) + 'dbm_create.sql');
      qrCreate.ExecSQL;
      pbProc.StepIt;

      StateLabel.Caption:= 'Загрузка данных...';
      Application.ProcessMessages;

      for i:= 0 to Src1Tables.Count - 1 do begin
        CopyTable(tSrc1, tDest, Src1Tables[i]);
        if fBreak then begin
          Close;
          Exit;
        end;
        pbProc.StepIt;
      end;
      for i:= 0 to Src2Tables.Count - 1 do begin
        CopyTable(tSrc2, tDest, Src2Tables[i]);
        if fBreak then begin
          Close;
          Exit;
        end;
        pbProc.StepIt;
      end;
      TableLabel.Caption:= '';

      StateLabel.Caption:= 'Преобразование данных...';
      Application.ProcessMessages;
      qrTransform.SQL.LoadFromFile(ExtractFilePath(Application.ExeName) + 'dbm_transform.sql');
      qrTransform.ExecSQL;
      pbProc.StepIt;
      StateLabel.Caption:= 'Очистка дублей...';
      Application.ProcessMessages;
      qrTransform.SQL.LoadFromFile(ExtractFilePath(Application.ExeName) + 'dbm_clear.sql');
      qrTransform.ExecSQL;
      pbProc.StepIt;

    finally
      Src2Tables.Free;
      Src1Tables.Free;
    end;
    PC.ActivePage := tshDone;
  except
    on E:Exception do begin
      ShowErr('Ошибка при экспорте данных!'#13#13+
        E.ClassName+': '+E.Message);
      Close;
    end;
  end;
end;

procedure TMainForm.dbMainWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
begin
  Screen.Cursor:=crSQLWait;
  Command.CommandTimeout:= 10000;
end;

procedure TMainForm.dbMainExecuteComplete(Connection: TADOConnection;
  RecordsAffected: Integer; const Error: Error;
  var EventStatus: TEventStatus; const Command: _Command;
  const Recordset: _Recordset);
begin
  Screen.Cursor:=crDefault;
end;

initialization
  fBreak := false;
end.

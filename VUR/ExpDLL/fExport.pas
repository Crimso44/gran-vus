unit fExport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, ExtCtrls, StdCtrls, ComCtrls, Buttons, ActnList, Db;

type
  TfmExport = class(TForm)
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
    qrOrg: TADOQuery;
    dsOrg: TDataSource;
    qrCont: TADOQuery;
    qrPaym: TADOQuery;
    qrFS: TADOQuery;
    qrKOPF: TADOQuery;
    ActionList1: TActionList;
    actDummy: TAction;
    actShiftDummy: TAction;
    qrForm6Hdr: TADOQuery;
    dsF6Hdr: TDataSource;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qrForm6: TADOQuery;
    qrOsn: TADOQuery;
    qrKTerr: TADOQuery;
    Shape1: TShape;
    Shape2: TShape;
    qrPer: TADOQuery;
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

uses msg, FileCtrl, Dates, SaveEvents;

{$R *.DFM}

procedure TfmExport.btnCancelClick(Sender: TObject);
begin
  if btnCancel.Caption='Закрыть' then ModalResult := mrOk
  else
    if Confirm('Прервать процесс обмена данными?') then ModalResult := mrCancel;
end;

procedure TfmExport.btnHelpClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,HelpContext);
end;

procedure TfmExport.rbFloppyClick(Sender: TObject);
begin
  edPath.Enabled := rbPath.Checked;
  sbPath.Enabled := rbPath.Checked;
  if edPath.Enabled then edPath.Color := clWindow
  else edPath.Color := clBtnFace;
  edEMail.Enabled := rbEMail.Checked;
  if edEmail.Enabled then edEmail.Color := clWindow
  else edEmail.Color := clBtnFace;
end;

procedure TfmExport.tshInfoShow(Sender: TObject);
begin
  btnBack.Enabled := false;
end;

procedure TfmExport.tshParamsShow(Sender: TObject);
begin
  lbTop.Caption := 'Выбор параметров экспорта данных';
  btnBack.Enabled := true;
  pnlTop.Parent := tshParams;
  bvTop.Parent := tshParams;
end;

procedure TfmExport.tshProcessShow(Sender: TObject);
begin
  lbTop.Caption := 'Процесс экспорта данных';
  btnBack.Visible:= false;
  btnNext.Visible := false;
  pnlTop.Parent := tshProcess;
  bvTop.Parent := tshProcess;
  tmGo.Enabled := true;
end;

procedure TfmExport.tshDoneShow(Sender: TObject);
begin
  lbTop.Caption := 'Экспорт данных завершен';
  btnCancel.Caption := 'Закрыть';
  btnCancel.Default := true;
  pnlTop.Parent := tshDone;
  bvTop.Parent := tshDone;
end;

procedure TfmExport.btnBackClick(Sender: TObject);
begin
  PC.ActivePageIndex := PC.ActivePageIndex-1;
end;

procedure TfmExport.btnNextClick(Sender: TObject);
begin
  if PC.ActivePage=tshParams then begin
  //check params
    if rbPath.Checked and (Trim(edPath.Text)=EmptyStr) then begin
      edPath.SetFocus;
      ShowErr('Укажите место на диске для помещения файлов...');
      Exit;
    end;
    if rbEMail.Checked and (Trim(edEMail.Text)=EmptyStr) then begin
      edEMail.SetFocus;
      ShowErr('Укажите адрес электронной почты, для создания сообщения e-mail...');
      Exit;
    end;
  end;
  PC.ActivePageIndex := PC.ActivePageIndex+1;
end;

procedure TfmExport.sbPathClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выберите место на диске для помещения файлов...',EmptyStr,s) then
    edPath.Text := s;
end;

procedure TfmExport.tmGoTimer(Sender: TObject);
  procedure ToCSV(qr: TADOQuery; path: string; fname: string);
  var F: TextFile;
      n: Integer;
      lst : TStringList;
  begin
    if Length(path)>0 then
      if path[Length(path)]<>'\' then path := path + '\';
    n := 1;
    while n<=Length(path) do begin
      if path[n]='\' then
        if not DirectoryExists(Copy(path,1,n-1)) then
          CreateDir(Copy(path,1,n-1));
      Inc(n);
    end;
    AssignFile(F,path+fname);
    ReWrite(F);
    lst := TStringList.Create;
    try
      lst.Clear;
      for n:=0 to qr.Fields.Count-1 do
        if qr.Fields[n].FieldName='FS_ID' then lst.Add('OKFS')
        else
          if qr.Fields[n].FieldName='KOPF_ID' then lst.Add('OKOPF')
          else
            if qr.Fields[n].FieldName='TERR_ID' then lst.Add('KODTERR')
            else lst.Add(qr.Fields[n].FieldName);
      WriteLn(F,StringReplace(StringReplace(lst.CommaText,#13,' ',[rfReplaceAll]),#10,' ',[rfReplaceAll]));
      pbProc.StepIt;
      qr.First;
      while not qr.EOF do begin
        lst.Clear;
        for n:=0 to qr.Fields.Count-1 do
          if qr.Fields[n].FieldName='FS_ID' then begin
            if qrFS.IsEmpty then lst.Add(EmptyStr)
            else lst.Add(qrFS.FieldByName('KOD').AsString);
          end
          else
            if qr.Fields[n].FieldName='KOPF_ID' then begin
              if qrKOPF.IsEmpty then lst.Add(EmptyStr)
              else lst.Add(qrKOPF.FieldByName('KOD').AsString);
            end
            else
              if qr.Fields[n].FieldName='TERR_ID' then begin
                if qrKTerr.IsEmpty then lst.Add(EmptyStr)
                else lst.Add(qrKTerr.FieldByName('KODTERR').AsString);
              end
              else
                if qr.Fields[n].DataType in [ftDate,ftDateTime] then begin
                  if qr.Fields[n].IsNull then lst.Add(EmptyStr)
                  else lst.Add(Date2Str(qr.Fields[n].AsDateTime));
                end
                else
                  if qr.Fields[n].DataType=ftBoolean then begin
                    if qr.Fields[n].AsBoolean then
                      lst.Add('1')
                    else
                      lst.Add('0');
                  end
                  else lst.Add(qr.Fields[n].AsString);
        WriteLn(F,StringReplace(StringReplace(lst.CommaText,#13,' ',[rfReplaceAll]),#10,' ',[rfReplaceAll]));
        pbProc.StepIt;
        qr.Next;
      end;
    finally
      lst.Free;
      CloseFile(F);
    end;
  end;
var i: Integer;
    path: string;
    buf: Array[0..MAX_PATH-1] of char;
begin
  tmGo.Enabled := false;
  Application.ProcessMessages;
  try
    qrOrg.Close;
    qrOrg.Parameters.ParamByName('ID').Value := OrgID;
    qrOrg.Open;
    pbProc.Position := 0;
    pbProc.Max := 0;
    for i:=0 to ComponentCount-1 do
      if Components[i] is TADOQuery then begin
        if not (Components[i] as TADOQuery).Active then
          (Components[i] as TADOQuery).Open;
        pbProc.Max := pbProc.Max+(Components[i] as TADOQuery).RecordCount + 1;
      end;
    pbProc.Max := pbProc.Max - qrFS.RecordCount - qrKOPF.RecordCount-2;
    if rbFloppy.Checked then path := 'A:\'
    else
      if rbPath.Checked then path := Trim(edPath.Text)
      else begin
        GetTempPath(MAX_PATH,buf);
        path := string(buf)+'\'+'GranVUS';
      end;
    ToCSV(qrOrg,path,'org.csv');
    ToCSV(qrCont,path,'orgcont.csv');
    ToCSV(qrPaym,path,'orgpaym.csv');
    ToCSV(qrForm6Hdr,path,'form6hdr.csv');
    ToCSV(qrForm6,path,'form6.csv');
    ToCSV(qrPer,path,'orgper.csv');
    ToCSV(qrOsn,path,'orgosn.csv');
    PC.ActivePage := tshDone;
  except
    on E:Exception do begin
      SaveEvent(dbMain, evs_Export_Failed, '', [E.ClassName+': '+E.Message]);
      ShowErr('Ошибка при экспорте данных!'#13#13+
        E.ClassName+': '+E.Message);
      ModalResult := mrCancel;
    end;
  end;
  SaveEvent(dbMain, evs_Export, '', [path]);
end;

procedure TfmExport.FormCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMEssage('Close default connection!');
  PC.ActivePageIndex := 0;
  Application.HelpFile := ExtractFilePath(Application.ExeName)+'granvus.hlp';
end;

procedure TfmExport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key=VK_TAB) then Key := 0; 
end;

procedure TfmExport.actDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmExport.actShiftDummyExecute(Sender: TObject);
begin
//
end;

end.

unit fExportOrg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, DB, ADODB, ActnList;

type
  TfmExportOrg = class(TForm)
    PC: TPageControl;
    tshInfo: TTabSheet;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    tshParams: TTabSheet;
    bvTop: TBevel;
    Label5: TLabel;
    sbPath: TSpeedButton;
    sbEMail: TSpeedButton;
    pnlTop: TPanel;
    Image2: TImage;
    lbTop: TLabel;
    rbFloppy: TRadioButton;
    rbPath: TRadioButton;
    rbEMail: TRadioButton;
    edPath: TEdit;
    edEMail: TEdit;
    tshProcess: TTabSheet;
    Label7: TLabel;
    tshDone: TTabSheet;
    Label6: TLabel;
    Bevel1: TBevel;
    btnBack: TButton;
    btnNext: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    dbMain: TADOConnection;
    ActionList1: TActionList;
    actDummy: TAction;
    actShiftDummy: TAction;
    tmGo: TTimer;
    pbProc: TProgressBar;
    qrOrg: TADOQuery;
    qrOrgCont: TADOQuery;
    qrOrgPaym: TADOQuery;
    qrForm6Hdr: TADOQuery;
    qrForm6: TADOQuery;
    qrPer: TADOQuery;
    qrOsn: TADOQuery;
    procedure tshParamsShow(Sender: TObject);
    procedure tshProcessShow(Sender: TObject);
    procedure tshDoneShow(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actDummyExecute(Sender: TObject);
    procedure actShiftDummyExecute(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure tmGoTimer(Sender: TObject);
    procedure rbFloppyClick(Sender: TObject);
    procedure sbPathClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    path: string;
  public
    { Public declarations }
    OrgId: Integer;
  end;

var
  fmExportOrg: TfmExportOrg;

implementation

uses msg, FileCtrl, Dates;

{$R *.dfm}

procedure TfmExportOrg.tshParamsShow(Sender: TObject);
begin
  lbTop.Caption := 'Выбор параметров экспорта данных';
  btnBack.Enabled := true;
  pnlTop.Parent := tshParams;
  bvTop.Parent := tshParams;
end;

procedure TfmExportOrg.tshProcessShow(Sender: TObject);
begin
  lbTop.Caption := 'Процесс экспорта данных';
  pnlTop.Parent := tshProcess;
  bvTop.Parent := tshProcess;
  tmGo.Enabled := true;
  btnBack.Visible:= false;
  btnNext.Visible := false;
end;

procedure TfmExportOrg.tshDoneShow(Sender: TObject);
begin
  lbTop.Caption := 'Экспорт данных завершен';
  btnBack.Enabled := true;
  pnlTop.Parent := tshDone;
  bvTop.Parent := tshDone;
  btnCancel.Caption := 'Закрыть';
  btnCancel.Default := true;
end;

procedure TfmExportOrg.btnHelpClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,HelpContext);
end;

procedure TfmExportOrg.FormCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMEssage('Close default connection!');
  PC.ActivePageIndex := 0;
end;

procedure TfmExportOrg.actDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmExportOrg.actShiftDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmExportOrg.btnBackClick(Sender: TObject);
begin
  if PC.ActivePageIndex>0 then
   PC.ActivePageIndex := PC.ActivePageIndex-1;
  btnBack.Enabled := PC.ActivePageIndex>0;
end;

procedure TfmExportOrg.btnNextClick(Sender: TObject);
var buf: Array[0..MAX_PATH-1] of char;
begin
  if PC.ActivePage=tshInfo then PC.ActivePage := tshParams
  else
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

    if rbFloppy.Checked then path := 'A:\'
    else
      if rbPath.Checked then path := Trim(edPath.Text)
      else begin
        GetTempPath(MAX_PATH,buf);
        path := string(buf)+'\'+'GranVUS';
      end;
    if Length(path)>0 then
     if path[Length(path)]<>'\' then path := path + '\';
    PC.ActivePage := tshProcess;
  end;
end;

procedure TfmExportOrg.btnCancelClick(Sender: TObject);
begin
  if btnCancel.Caption='Закрыть' then begin
    ModalResult := mrOk
  end
  else
    if Confirm('Прервать процесс обмена данными?') then ModalResult := mrCancel;
end;

procedure TfmExportOrg.rbFloppyClick(Sender: TObject);
begin
  edPath.Enabled := rbPath.Checked;
  sbPath.Enabled := rbPath.Checked;
  if edPath.Enabled then edPath.Color := clWindow
  else edPath.Color := clBtnFace;
  edEMail.Enabled := rbEMail.Checked;
  if edEmail.Enabled then edEmail.Color := clWindow
  else edEmail.Color := clBtnFace;
end;

procedure TfmExportOrg.sbPathClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Укажите размещение файлов на диске...',EmptyStr,s,
  [sdNewFolder, sdShowShares, sdNewUI, sdValidateDir]) then
    edPath.Text := s;
end;

procedure TfmExportOrg.tmGoTimer(Sender: TObject);
  procedure ToCSV(Query: TADOQuery; FileName: string);
  var FList: TStringList;
      F: TextFile;
      n: Integer;
  begin
    FList := TStringList.Create;
    try
      AssignFile(F,path+FileName);
      ReWrite(F);
      FList.Clear;
      for n:=0 to Query.FieldCount-1 do
        FList.Add(Query.Fields[n].FieldName);
      WriteLn(F,StringReplace(StringReplace(FList.CommaText,#13,' ',[rfReplaceAll]),#10,' ',[rfReplaceAll]));
      Query.First;
      while not Query.EOF do begin
        FList.Clear;
        for n:=0 to Query.FieldCount-1 do
          if Query.Fields[n].DataType in [ftDate,ftDateTime] then begin
            if Query.Fields[n].IsNull then FList.Add(EmptyStr)
            else FList.Add(Date2Str(Query.Fields[n].AsDateTime));
          end else if Query.Fields[n].DataType in [ftBoolean] then begin
            if Query.Fields[n].IsNull then FList.Add(EmptyStr)
            else FList.Add(IntToStr(Integer(Query.Fields[n].AsBoolean)));
          end else
            FList.Add(Query.Fields[n].AsString);
        WriteLn(F,StringReplace(StringReplace(FList.CommaText,#13,' ',[rfReplaceAll]),#10,' ',[rfReplaceAll]));
        Query.Next;
      end;
    finally
      CloseFile(F);
      FList.Free;
    end;
    pbProc.StepIt;
  end;
var i: Integer;
begin
  tmGo.Enabled := false;
  Application.ProcessMessages;
  for i:=0 to ComponentCount-1 do
    if Components[i] is TADOQuery then
      with (Components[i] as TADOQuery) do begin
        Close;
        Parameters.ParamByName('OrgId').Value := OrgId;
        Open;
      end;
  pbProc.StepIt;
  ToCSV(qrOrg,'org.csv');
  ToCSV(qrOrgCont,'orgcont.csv');
  ToCSV(qrOrgPaym,'orgpaym.csv');
  ToCSV(qrForm6Hdr,'form6hdr.csv');
  ToCSV(qrForm6,'form6.csv');
  ToCSV(qrPer,'orgper.csv');
  ToCSV(qrOsn,'orgosn.csv');
  PC.ActivePage := tshDone;
end;


procedure TfmExportOrg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then btnHelp.Click;
end;

end.

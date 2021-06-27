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
    qrSubj: TADOQuery;
    qrSubjInfo: TADOQuery;
    qrSubjParam: TADOQuery;
    qrFS: TADOQuery;
    qrKOPF: TADOQuery;
    ActionList1: TActionList;
    actDummy: TAction;
    actShiftDummy: TAction;
    qrForm6Hdr: TADOQuery;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qrForm6: TADOQuery;
    tshContents: TTabSheet;
    Panel2: TPanel;
    Image3: TImage;
    Label4: TLabel;
    Label8: TLabel;
    cbAggr: TCheckBox;
    GroupBox1: TGroupBox;
    rbOrgAll: TRadioButton;
    rbOrgBron: TRadioButton;
    cbInfo: TCheckBox;
    GroupBox2: TGroupBox;
    rbPerAll: TRadioButton;
    rbPerSince: TRadioButton;
    dtpSince: TDateTimePicker;
    qrKTERR: TADOQuery;
    qrOrg: TADOQuery;
    qrOrgCont: TADOQuery;
    qrOrgPaym: TADOQuery;
    qrCurrSubj: TADOQuery;
    qrOrgPer: TADOQuery;
    qrOrgOsn: TADOQuery;
    qrCreate: TADOQuery;
    qrDrop: TADOQuery;
    qrKTerrExp: TADOQuery;
    rbNoOrg: TRadioButton;
    qrFFS: TADOQuery;
    qrFOKVED: TADOQuery;
    rbOrgSet: TRadioButton;
    qrFFS2010: TADOQuery;
    qrFOKVED2010: TADOQuery;
    qrFSVT2012: TADOQuery;
    qrFAnaliz: TADOQuery;
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
    procedure rbPerClick(Sender: TObject);
    procedure tshContentsShow(Sender: TObject);
    procedure cbContClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OrgID: Integer;
  end;


implementation

uses msg, FileCtrl, Dates, IniSupport, StrUtils;

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

procedure TfmExport.tshContentsShow(Sender: TObject);
begin
  lbTop.Caption := 'Выбор содержимого экспортируемых данных';
  btnBack.Enabled := true;
  pnlTop.Parent := tshContents;
  bvTop.Parent := tshContents;
end;

procedure TfmExport.tshParamsShow(Sender: TObject);
begin
  lbTop.Caption := 'Выбор параметров экспорта данных';
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
  if SelectDirectory('Выберите место на диске для помещения файлов...',EmptyStr,s,
  [sdNewFolder, sdShowShares, sdNewUI, sdValidateDir]) then
    edPath.Text := s;
end;

procedure TfmExport.tmGoTimer(Sender: TObject);

  function GetKODTERR(TERR_ID: Integer): string;
  begin
    with qrKTERR do begin
      if not Active then Open;
      if Locate('TERR_ID', TERR_ID, []) then
        Result:= FieldByName('KODTERR').AsString
      else Result:= EmptyStr;
    end;
  end;

  function GetFS_KOD(FS_ID: Integer): string;
  begin
    with qrFS do begin
      if not Active then Open;
      if Locate('FS_ID', FS_ID, []) then
        Result:= FieldByName('KOD').AsString
      else Result:= EmptyStr;
    end;
  end;

  function GetKOPF_KOD(KOPF_ID: Integer): string;
  begin
    with qrKOPF do begin
      if not Active then Open;
      if Locate('KOPF_ID', KOPF_ID, []) then
        Result:= FieldByName('KOD').AsString
      else Result:= EmptyStr;
    end;
  end;

  procedure ToCSV(qr: TADOQuery; path: string; fname: string);
  var F: TextFile;
      n: Integer;
      lst : TStringList;
  begin
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
        if qr.Fields[n].FieldName='FS_ID'   then lst.Add('OKFS') else
        if qr.Fields[n].FieldName='TERR_ID' then lst.Add('KODTERR') else
        if qr.Fields[n].FieldName='KOPF_ID' then lst.Add('OKOPF') else
        if qr.Fields[n].FieldName='KONH_ID' then lst.Add('KONH') else
//        if SameText(fname,'fonh.csv') and
//           AnsiContainsText('ORG_COUNT,ORG_BRON_COUNT',qr.Fields[n].FieldName) then else
        lst.Add(qr.Fields[n].FieldName);

      WriteLn(F,StringReplace(StringReplace(lst.CommaText,#13,' ',[rfReplaceAll]),#10,' ',[rfReplaceAll]));
      pbProc.StepIt;
      qr.First;
      while not qr.EOF do begin
        lst.Clear;
        for n:=0 to qr.Fields.Count-1 do
          if qr.Fields[n].FieldName='FS_ID'   then lst.Add(GetFS_KOD(qr.Fields[n].AsInteger)) else
          if qr.Fields[n].FieldName='TERR_ID' then lst.Add(GetKODTERR(qr.Fields[n].AsInteger))else
          if qr.Fields[n].FieldName='KOPF_ID' then lst.Add(GetKOPF_KOD(qr.Fields[n].AsInteger))else
//          if qr.Fields[n].FieldName='KONH_ID' then lst.Add(GetKONH_KOD(qr.Fields[n].AsInteger))else
          if qr.Fields[n].DataType in [ftDate,ftDateTime] then begin
            if qr.Fields[n].IsNull then lst.Add(EmptyStr) else lst.Add(Date2Str(qr.Fields[n].AsDateTime));
          end else
          if qr.Fields[n].DataType in [ftBoolean] then begin
            if qr.Fields[n].IsNull then lst.Add(EmptyStr)  else lst.Add(IntToStr(Integer(qr.Fields[n].AsBoolean)));
          end else
//          if SameText(fname,'fonh.csv') and
//           AnsiContainsText('ORG_COUNT,ORG_BRON_COUNT',qr.Fields[n].FieldName) then else
          lst.Add(qr.Fields[n].AsString);
        WriteLn(F,StringReplace(StringReplace(lst.CommaText,#13,' ',[rfReplaceAll]),#10,' ',[rfReplaceAll]));
        pbProc.StepIt;
        Application.ProcessMessages;
        qr.Next;
      end;
    finally
      lst.Free;
      CloseFile(F);
    end;
  end;
//
  procedure JustHeader(AFileName: String; S: String);
  var T: TextFile;
  begin
    AssignFile(T, AFileName); Rewrite(T); WriteLn(T,S); CloseFile(T);
  end;
//
var
    path: string;
    buf: Array[0..MAX_PATH-1] of char;
begin
tmGo.Enabled := false;
Application.ProcessMessages;
try
  if rbFloppy.Checked then path := 'A:\'
  else if rbPath.Checked then path := Trim(edPath.Text)
  else begin
    GetTempPath(MAX_PATH,buf);
    path := string(buf)+'\'+'GranVUS2';
  end;
  path := IncludeTrailingPathDelimiter(path);
  pbProc.Position := 0;
  pbProc.Max := 0;

  if rbOrgSet.Checked then
    qrCreate.SQL.Add('select Org.OrgId from Org, OrgSet where Org.OrgID=OrgSet.OrgID')
  else with qrCreate.SQL do begin
    Add('  select OrgId from Org join KTerr on Org.Terr_Id=KTerr.Terr_Id');
    Add('  where KTerr.KodTerr LIKE');
    Add('    ( select  dbo.GetSubjMask(KTERR.KODTERR)');
    Add('      from CURR_SUBJ');
    Add('      join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID');
    Add('      join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)');
  end;

  if rbNoOrg.Checked then
    qrCreate.SQL.Add('AND 0=1');
  if rbOrgBron.Checked then
    qrCreate.SQL.Add('AND Org.HAS_BRON=1');
  if rbPerSince.Checked then begin
    qrCreate.SQL.Add('AND (Org.CONFDATE >= :CONFDATE OR Org.ORGID IN (SELECT ORGID FROM FORM6HDR WHERE CONFDATE >= :F6CONFDATE))');
    qrCreate.Parameters.ParamByName('CONFDATE').DataType:= ftDateTime;
    qrCreate.Parameters.ParamByName('CONFDATE').Value:= dtpSince.Date;
    qrCreate.Parameters.ParamByName('F6CONFDATE').DataType:= ftDateTime;
    qrCreate.Parameters.ParamByName('F6CONFDATE').Value:= dtpSince.Date;
//перестало работать - х.з.
//    qrCreate.Parameters.ParamValues['CONFDATE']:= dtpSince.Date;
//    qrCreate.Parameters.ParamValues['F6CONFDATE']:= dtpSince.Date;
  end;
  qrCreate.ExecSQL;
  try

    with qrCurrSubj do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT S.SUBJ_ID, S.TYPE_ID, S.TERR_ID, S.ORGID, S.SUBJ_NAME, S.SUBJ_FULLNAME, S.SUBJ_ADDRESS, S.SUBJ_AGG_ID,');
      if cbAggr.Checked then
        SQL.Add('CAST(1 As bit) As AggData,')
      else
        SQL.Add('CAST(0 As bit) As AggData,');
      if rbOrgBron.Checked or rbNoOrg.Checked then
        SQL.Add('CAST(1 As bit) As BronOnly,')
      else
        SQL.Add('CAST(0 As bit) As BronOnly,');
      if rbPerSince.Checked then begin
        SQL.Add('CAST(:CONFDATE As datetime) As CONFDATE');
        Parameters.ParamByName('CONFDATE').DataType:= ftDateTime;
        Parameters.ParamByName('CONFDATE').Value:= dtpSince.Date;
      end else
        SQL.Add('CAST(NULL As datetime) As CONFDATE');
      SQL.Add('FROM SUBJ S JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID');
      Open;
      if RecordCount <> 1 then
        raise Exception.Create('Не указан текущий территориальный орган в списке территориальных органов.');
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    with qrSubj do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT S.SUBJ_ID, S.TYPE_ID, S.TERR_ID, S.ORGID, S.SUBJ_NAME, S.SUBJ_FULLNAME, S.SUBJ_ADDRESS,');
      if rbOrgBron.Checked or rbNoOrg.Checked then
        SQL.Add('CASE WHEN C.SUBJ_ID IS NULL THEN 3 ELSE 2 END AS SUBJ_AGG_ID')
      else
        SQL.Add('S.SUBJ_AGG_ID');
      SQL.Add('FROM SUBJ S LEFT JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID');
      SQL.Add('where S.Subj_Id in (SELECT SubjId FROM [dbo].[##SubjSet])');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    qrSubjInfo.SQL.Add('where Subj_Id in (SELECT SubjId FROM [dbo].[##SubjSet])');
    qrSubjInfo.Open;
    pbProc.Max := pbProc.Max + qrSubjInfo.RecordCount + 1;

    qrSubjParam.SQL.Add('where Subj_Id in (SELECT SubjId FROM [dbo].[##SubjSet])');
    qrSubjParam.Open;
    pbProc.Max := pbProc.Max + qrSubjParam.RecordCount + 1;

    with qrOrg do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT O.*,KOVK.OVK_NAME FROM ORG O LEFT OUTER JOIN KOVK ON O.OVK_ID=KOVK.OVK_ID');
      SQL.Add('WHERE O.OrgId in (SELECT OrgId FROM [dbo].[##OrgSet])');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    with qrOrgCont do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ORG_CONT');
      SQL.Add('WHERE ORGID IN (SELECT ORGID FROM [dbo].[##OrgSet])');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    with qrOrgPaym do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ORG_PAYM');
      SQL.Add('WHERE ORGID IN (SELECT ORGID FROM [dbo].[##OrgSet])');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    with qrOrgPer do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM PER');
      SQL.Add('WHERE ORGID IN (SELECT ORGID FROM [dbo].[##OrgSet])');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    with qrOrgOsn do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM OSN');
      SQL.Add('WHERE ORGID IN (SELECT ORGID FROM [dbo].[##OrgSet])');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    with qrForm6Hdr do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FORM6HDR');
      SQL.Add('WHERE ORGID IN (SELECT ORGID FROM [dbo].[##OrgSet])');
      if cbAggr.Checked then
        SQL.Add('OR SUBJ_ID IN (select SubjId from [dbo].[##SubjSet])');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    with qrForm6 do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FORM6');
      SQL.Add('WHERE F6_ID IN (SELECT F6_ID FROM (');
      SQL.Add(qrForm6Hdr.SQL.Text);
      SQL.Add(') FF)');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

{    with qrFONH do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FONH');
      if cbAggr.Checked then
        SQL.Add('WHERE SUBJ_ID IN (select SubjId from [dbo].[##SubjSet])')
      else
        SQL.Add('WHERE 1=0');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;}

    with qrFFS do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FFS');
      if cbAggr.Checked then
        SQL.Add('WHERE SUBJ_ID IN (select SubjId from [dbo].[##SubjSet])')
      else
        SQL.Add('WHERE 1=0');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;
    with qrFOKVED do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FOKVED');
      if cbAggr.Checked then
        SQL.Add('WHERE SUBJ_ID IN (select SubjId from [dbo].[##SubjSet])')
      else
        SQL.Add('WHERE 1=0');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;
    with qrFFS2010 do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FFS2010');
      if cbAggr.Checked then
        SQL.Add('WHERE SUBJ_ID IN (select SubjId from [dbo].[##SubjSet])')
      else
        SQL.Add('WHERE 1=0');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;
    with qrFOKVED2010 do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FOKVED2010');
      if cbAggr.Checked then
        SQL.Add('WHERE SUBJ_ID IN (select SubjId from [dbo].[##SubjSet])')
      else
        SQL.Add('WHERE 1=0');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;
    with qrFSVT2012 do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FSVT2012');
      if cbAggr.Checked then
        SQL.Add('WHERE SUBJ_ID IN (select SubjId from [dbo].[##SubjSet])')
      else
        SQL.Add('WHERE 1=0');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;
    with qrFAnaliz do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM FAnaliz');
      if cbAggr.Checked then
        SQL.Add('WHERE SUBJ_ID IN (select SubjId from [dbo].[##SubjSet])')
      else
        SQL.Add('WHERE 1=0');
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    with qrKTerrExp do begin
      Close;
      Open;
      pbProc.Max := pbProc.Max + RecordCount + 1;
    end;

    ToCSV(qrCurrSubj,path,'currsubj.csv');
    ToCSV(qrSubj,path,'subj.csv');
    ToCSV(qrSubjInfo,path,'subjinfo.csv');
    ToCSV(qrSubjParam,path,'subjpar.csv');
    ToCSV(qrOrg,path,'org2.csv');
    ToCSV(qrOrgCont,path,'orgcont.csv');
    ToCSV(qrOrgPaym,path,'orgpaym.csv');
    ToCSV(qrOrgPer,path,'orgper.csv');
    ToCSV(qrOrgOsn,path,'orgosn.csv');
    ToCSV(qrForm6Hdr,path,'form6hdr.csv');
    ToCSV(qrForm6,path,'form6.csv');
//    ToCSV(qrFONH,path,'fonh.csv');
//    ToCSV(qrFONH,path,'fonh37.csv');
    JustHeader(path+'fonh.csv', 'SUBJ_ID,KBONH_ID,RAB_COUNT,ZAP_COUNT,ZAB_COUNT'); //for 3.61
    ToCSV(qrFFS,path,'ffs.csv');
    ToCSV(qrFOKVED,path,'fokved.csv');
    ToCSV(qrFFS2010,path,'ffs2010.csv');
    ToCSV(qrFOKVED2010,path,'fokved2010.csv');
    ToCSV(qrFSVT2012,path,'fsvt2012.csv');
    ToCSV(qrFAnaliz,path,'fanaliz.csv');
    ToCSV(qrKTerrExp,path,'kterr.csv');
    SetLastExport(Date);
    SetExpAgg(cbAggr.Checked);
    SetExpBron(rbOrgBron.Checked or rbNoOrg.Checked);
  finally
    qrDrop.ExecSQL;
  end;
  PC.ActivePage := tshDone;
except
  on E:Exception do begin
    ShowErr('Ошибка при экспорте данных!'#13#13+
      E.ClassName+': '+E.Message);
    ModalResult := mrCancel;
  end;
end;
end;

procedure TfmExport.FormCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMEssage('Close default connection!');
  PC.ActivePageIndex := 0;
  dtpSince.Date:= Date;
  if GetLastExport = 0 then
    rbPerAll.Checked:= True
  else begin
    rbPerSince.Checked:= True;
    dtpSince.Date:= GetLastExport;
  end;
  cbAggr.Checked:= GetExpAgg;
  cbContClick(Sender);
  if GetExpBron then begin
    if rbNoOrg.Enabled then rbNoOrg.Checked:= True;
  end else begin
    if rbOrgAll.Enabled then rbOrgAll.Checked:= True;
  end;
end;

procedure TfmExport.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key=VK_TAB) then Key := 0;
  if (Shift=[]) and (Key=VK_F1) then btnHelp.Click;
end;

procedure TfmExport.actDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmExport.actShiftDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmExport.rbPerClick(Sender: TObject);
begin
  dtpSince.Enabled:= rbPerSince.Checked;
end;

procedure TfmExport.cbContClick(Sender: TObject);
begin
  if not cbAggr.Checked then begin
    rbOrgAll.Checked:= True;
  end;
  rbOrgBron.Enabled:= cbAggr.Checked;
  rbNoOrg.Enabled := cbAggr.Checked;
  if rbOrgBron.Checked or rbNoOrg.Checked then begin
    cbAggr.Checked:= True;
  end;
  cbAggr.Enabled:= not (rbOrgBron.Checked or rbNoOrg.Checked);
  rbPerAll.Enabled := not rbNoOrg.Checked;
  rbPerSince.Enabled := not rbNoOrg.Checked;
  dtpSince.Enabled := not rbNoOrg.Checked;
end;

end.

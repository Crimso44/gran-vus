unit fImportSubj;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, ExtCtrls, StdCtrls, ComCtrls, Buttons, ActnList, Db, dxCntner,
  dxEditor, dxExEdtr, dxEdLib, dxTL, dxDBCtrl, dxDBGrid, Variants;

type
  TfmImportSubj = class(TForm)
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
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    sbEMail: TSpeedButton;
    qrCreate: TADOQuery;
    qrDrop: TADOQuery;
    qrFS: TADOQuery;
    qrKOPF: TADOQuery;
    qrOrg: TADOQuery;
    qrOrgCont: TADOQuery;
    qrOrgPaym: TADOQuery;
    qrForm6Hdr: TADOQuery;
    qrForm6: TADOQuery;
    tshWrng: TTabSheet;
    Label4: TLabel;
    Label8: TLabel;
    qrOrgChk: TADOQuery;
    DataSource1: TDataSource;
    sp_ImportSubj: TADOStoredProc;
    tshSubjInfo: TTabSheet;
    Label25: TLabel;
    Label26: TLabel;
    edName: TEdit;
    Label27: TLabel;
    qrSubj: TADOQuery;
    qrSubjInfo: TADOQuery;
    qrSubjParam: TADOQuery;
    qrOrgOsn: TADOQuery;
    qrOrgPer: TADOQuery;
    cbAggr: TCheckBox;
    GroupBox3: TGroupBox;
    rbOrgAll: TRadioButton;
    rbOrgBron: TRadioButton;
    GroupBox4: TGroupBox;
    rbPerAll: TRadioButton;
    rbPerSince: TRadioButton;
    dtpSince: TDateTimePicker;
    Label28: TLabel;
    edOKATO: TEdit;
    Label29: TLabel;
    edFullName: TEdit;
    qrTERR: TADOQuery;
    qrCurrSubj: TADOQuery;
    qrFFS: TADOQuery;
    qrFOKVED: TADOQuery;
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
    procedure FormDestroy(Sender: TObject);
  private
    path: string;
    SubjLst, SubjFLst: TStringList;
  public
  end;


implementation

uses msg, FileCtrl, Dates, StrUtils;

{$R *.DFM}

procedure TfmImportSubj.btnCancelClick(Sender: TObject);
begin
  if btnCancel.Caption='Закрыть' then ModalResult := mrOk
  else
    if Confirm('Прервать процесс обмена данными?') then ModalResult := mrCancel;
end;

procedure TfmImportSubj.btnHelpClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,HelpContext);
end;

procedure TfmImportSubj.rbFloppyClick(Sender: TObject);
begin
  edPath.Enabled := rbPath.Checked;
  sbPath.Enabled := rbPath.Checked;
  if edPath.Enabled then edPath.Color := clWindow
  else edPath.Color := clBtnFace;
  edEMail.Enabled := rbEMail.Checked;
  if edEmail.Enabled then edEmail.Color := clWindow
  else edEmail.Color := clBtnFace;
end;

procedure TfmImportSubj.tshInfoShow(Sender: TObject);
begin
  btnBack.Enabled := false;
end;

procedure TfmImportSubj.tshParamsShow(Sender: TObject);
begin
  lbTop.Caption := 'Выбор параметров импорта данных';
  btnBack.Enabled := true;
  pnlTop.Parent := tshParams;
  bvTop.Parent := tshParams;
end;

procedure TfmImportSubj.tshProcessShow(Sender: TObject);
begin
  lbTop.Caption := 'Процесс импорта данных';
  btnBack.Visible:= false;
  btnNext.Visible := false;
  pnlTop.Parent := tshProcess;
  bvTop.Parent := tshProcess;
  tmGo.Enabled := true;
end;

procedure TfmImportSubj.tshDoneShow(Sender: TObject);
begin
  lbTop.Caption := 'Импорт данных завершен';
  btnCancel.Caption := 'Закрыть';
  btnCancel.Default := true;
  pnlTop.Parent := tshDone;
  bvTop.Parent := tshDone;
end;

procedure TfmImportSubj.btnBackClick(Sender: TObject);
begin
  if PC.ActivePage = tshWrng then begin
    PC.ActivePageIndex:= tshParams.PageIndex;
  end else
    PC.ActivePageIndex := PC.ActivePageIndex-1;
end;

procedure TfmImportSubj.btnNextClick(Sender: TObject);
var
  F: TextFile;
  n,p: Integer;
  idxNAME: Integer;
  idxTERR: Integer;
  idxFULLNAME: Integer;
  idxAggData: Integer;
  idxBronOnly: Integer;
  idxCONFDATE: Integer;
  buf: Array[0..MAX_PATH-1] of char;
  s: string;
begin
  p:= PC.ActivePageIndex;
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
    path := IncludeTrailingPathDelimiter(path);
    try
      AssignFile(F,path+'currsubj.csv');
      ReSet(F);
      ReadLn(F,s);
      SubjFLst.CommaText := AnsiUpperCase(s);
      n := SubjFLst.Count;
      idxNAME := SubjFLst.IndexOf('SUBJ_NAME');
      idxTERR := SubjFLst.IndexOf('KODTERR');
      idxFULLNAME := SubjFLst.IndexOf('SUBJ_FULLNAME');
      idxAggData := SubjFLst.IndexOf('AggData');
      idxBronOnly := SubjFLst.IndexOf('BronOnly');
      idxCONFDATE := SubjFLst.IndexOf('CONFDATE');
      if (idxNAME<0) or (idxTERR<0) or (idxFULLNAME<0) or (idxAggData<0) or (idxBronOnly<0) or (idxCONFDATE<0) then begin
        ShowErr('Файлы данных источника повреждены или имеют некорректный формат!');
        ModalResult := mrCancel;
        Exit;
      end;
      ReadLn(F,s);
      SubjLst.CommaText := s;
      while SubjLst.Count<n do SubjLst.Add(EmptyStr);
      edName.Text:= SubjLst[idxNAME];
      edFullName.Text:= SubjLst[idxFULLNAME];
      edOKATO.Text:= Trim(SubjLst[idxTERR]);
      cbAggr.Checked:= Boolean(StrToInt(SubjLst[idxAggData]));
      if Boolean(StrToInt(SubjLst[idxBronOnly])) then
        rbOrgBron.Checked:= True
      else rbOrgAll.Checked:= True;
      if Trim(SubjLst[idxCONFDATE]) = EmptyStr then
        rbPerAll.Checked:= True
      else begin
        rbPerSince.Checked:= True;
        dtpSince.Date:= Str2Date(SubjLst[idxCONFDATE]);
      end;
    finally
      CloseFile(F);
    end;
    Inc(p);
  end else if PC.ActivePage=tshSubjInfo then begin
    if rbPerSince.Checked then Inc(p);
    Inc(p);
  end else
    Inc(p);

  PC.ActivePageIndex:= p;
end;

procedure TfmImportSubj.sbPathClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Укажите размещение файлов на диске...',EmptyStr,s) then
    edPath.Text := s;
end;

procedure TfmImportSubj.tmGoTimer(Sender: TObject);

  function GetFS_ID(FS_KOD: string): variant;
  begin
    with qrFS do begin
      if not Active then Open;
      if Locate('KOD', FS_KOD, []) then
        Result:= FieldByName('FS_ID').AsInteger
      else Result:= Null;
      if VarIsNull(Result) and (Trim(FS_KOD) <> '') then begin
        Append;
        FieldByName('KOD').AsString:= Trim(FS_KOD);
        FieldByName('FS_NAME').AsString:= '?';
        Post;
        if Locate('KOD', FS_KOD, []) then
          Result:= FieldByName('FS_ID').AsInteger
        else Result:= Null;
      end;
    end;
  end;

  function GetTERR_ID(KODTERR: string): variant;
  begin
    with qrTERR do begin
      if not Active then Open;
      if not Locate('KODTERR', KODTERR, []) then begin
        Append;
        FieldByName('KODTERR').Value := KODTERR;
        FieldByName('NAME').Value := 'Код '+KODTERR;
        Post;
      end;
      Result:= FieldByName('TERR_ID').AsInteger
    end;
  end;

  function GetKOPF_ID(KOPF_KOD: string): variant;
  begin
    with qrKOPF do begin
      if not Active then Open;
      if Locate('KOD', KOPF_KOD, []) then
        Result:= FieldByName('KOPF_ID').AsInteger
      else Result:= Null;
      if VarIsNull(Result) and (Trim(KOPF_KOD) <> '') then begin
        Append;
        FieldByName('KOD').AsString:= Trim(KOPF_KOD);
        FieldByName('KOPF_NAME').AsString:= '?';
        Post;
        if Locate('KOD', KOPF_KOD, []) then
          Result:= FieldByName('KOPF_ID').AsInteger
        else Result:= Null;
      end;
    end;
  end;

  function GetBASE_ID(BASE_ID: string): Variant;
  begin
    if BASE_ID = '' then Result := NULL
    else if BASE_ID = '8' then Result := 1
    else if BASE_ID = '9' then Result := 2
    else if BASE_ID = '10' then Result := 3
    else if BASE_ID = '11' then Result := 4
    else if BASE_ID = '7' then Result := 6
    else Result := StrToInt(BASE_ID);
  end;

{  function GetKONH_ID(KONH_KOD: string): variant;
  begin
    with qrKONH do begin
      if not Active then Open;
      if Locate('KONH_KOD', KONH_KOD, []) then
        Result:= FieldByName('KONH_ID').AsInteger
      else Result:= Null;
    end;
  end;}

  procedure ImportKTerr;
  var F: TextFile;
      head,lst : TStringList;
      s: string;
      n,nn: Integer;
  begin
    if not qrTerr.Active then qrTerr.Open;
    AssignFile(F,path+'kterr.csv');
    ReSet(F);
    head := TStringList.Create;
    lst := TStringList.Create;
    try
      ReadLn(F,s);
      head.CommaText := AnsiUpperCase(s);
      n := head.IndexOf('KODTERR');
      nn := head.IndexOf('NAME');
      while not EOF(F) do begin
        ReadLn(F,s);
        lst.CommaText := s;
        if (n<0) or (nn<0) or (n>=lst.Count) or (nn>=lst.Count) then
          raise Exception.Create('Неверный формат файла: "kterr.csv".');
        if not qrTerr.Locate('KODTERR',lst[n],[]) then begin
          qrTerr.Append;
          qrTerr.FieldByName('KODTERR').Value := lst[n];
          qrTerr.FieldByName('NAME').Value := lst[nn];
          qrTerr.Post;
        end;
      end;
    finally
      CloseFile(F);
    end;
  end;

  procedure FromCSV(qr: TADOQuery; path: string; fname: string);
  var F: TextFile;
      flst,lst : TStringList;
      s,ss,sss: string;
      n,i: Integer;
      fld: TField;
  begin
    while not qr.EOF do qr.Delete;
    if not FileExists(path+fname) then Exit;

    AssignFile(F,path+fname);
    ReSet(F);
    flst:= TStringList.Create;
    try
      ReadLn(F,s);
      if Trim(s) <> '' then begin
        flst.CommaText := AnsiUpperCase(s);
        lst := TStringList.Create;
        try
          while not EOF(F) do begin
            ReadLn(F,s);
            lst.CommaText := s;
            qr.Append;
            for n:= 0 to lst.Count - 1 do begin
              s:= flst.Strings[n];
              if s = 'OKFS' then s:= 'FS_ID'
              else if s = 'KODTERR' then s:= 'TERR_ID'
//              else if s = 'KONH' then s:= 'KONH_ID'
              else if s = 'OKOPF' then s:= 'KOPF_ID';
              fld:= qr.FindField(s);
              if not Assigned(fld) then
                if SameText(flst.Strings[n],'KONH_ID') then Continue else
                raise Exception.Create('Неизвестное поле. Поле: ' + flst.Strings[n] + ' файл: ' + fname + #10 +
                                       'Файлы данных источника повреждены или имеют некорректный формат!');
              if (s='FIO') and not Assigned(qr.FindField('SUBJ_ID')) then begin
                ss := lst.Strings[n];
                i := Pos(' ',ss);
                if i=0 then begin
                  qr.FieldByName('Fam').Value := ss;
                  qr.FieldByName('Im').Value := null;
                  qr.FieldByName('Otch').Value := null;
                end
                else begin
                  qr.FieldByName('Fam').Value := LeftStr(ss,i-1);
                  ss := RightStr(ss,Length(ss)-i);
                  i := Pos(' ',ss);
                  if i=0 then begin
                    qr.FieldByName('Im').Value := ss;
                    qr.FieldByName('Otch').Value := null;
                  end
                  else begin
                    qr.FieldByName('Im').Value := LeftStr(ss,i-1);
                    qr.FieldByName('Otch').Value := RightStr(ss,Length(ss)-i);
                  end;
                end;
              end else if fld.FieldName = 'FS_ID' then begin
                fld.Value:= GetFS_ID(lst.Strings[n]);
              end else if fld.FieldName='TERR_ID' then begin
                fld.Value:= GetTERR_ID(lst.Strings[n]);
              end else if fld.FieldName='BASE_ID' then begin
                fld.Value:= GetBASE_ID(lst.Strings[n]);
              end else if fld.FieldName='KOPF_ID' then begin
                fld.Value:= GetKOPF_ID(lst.Strings[n]);
//              end else if fld.FieldName='KONH_ID' then begin
//                fld.Value:= GetKONH_ID(lst.Strings[n]);
              end else if fld.DataType in [ftDate,ftDateTime] then begin
                if lst.Strings[n] <> EmptyStr then fld.Value:= Str2Date(lst.Strings[n]);
              end else if fld.DataType in [ftBoolean] then begin
                if lst.Strings[n] <> '' then
                  fld.Value:= Boolean(StrToInt(lst.Strings[n]));
              end else if fld.DataType in [ftFloat] then begin
                sss := StringReplace(StringReplace(lst.Strings[n],'.',DecimalSeparator,[]),',',DecimalSeparator,[]);
                if sss=EmptyStr then fld.Value := null else fld.Value := StrToFloat(sss);
              end else
                fld.AsString:= lst.Strings[n];
            end;
            Application.ProcessMessages;
            qr.Post;
          end;
        finally
          lst.Free;
        end;
      end;
    finally
      flst.Free;
      CloseFile(F);
    end;
  end;

begin
  tmGo.Enabled := false;
  Application.ProcessMessages;
  try
    qrDrop.ExecSQL;
    qrCreate.ExecSQL;
    pbProc.StepIt;

    qrCurrSubj.Open;
    pbProc.StepIt;
    qrSubj.Open;
    pbProc.StepIt;
    qrSubjInfo.Open;
    pbProc.StepIt;
    qrSubjParam.Open;
    pbProc.StepIt;
    qrOrg.Open;
    pbProc.StepIt;
    qrOrgCont.Open;
    pbProc.StepIt;
    qrOrgPaym.Open;
    pbProc.StepIt;
    qrOrgPer.Open;
    pbProc.StepIt;
    qrOrgOsn.Open;
    pbProc.StepIt;
    qrForm6Hdr.Open;
    pbProc.StepIt;
    qrForm6.Open;
    pbProc.StepIt;
//    qrFONH.Open;
    qrFFS.Open;
    qrFOKVED.Open;
    qrFFS2010.Open;
    qrFOKVED2010.Open;
    qrFSVT2012.Open;
    qrFAnaliz.Open;
    pbProc.StepIt;

    FromCSV(qrCurrSubj, path, 'currsubj.csv');
    if qrCurrSubj.RecordCount <> 1 then
      raise Exception.Create('В файле currsubj.csv должна содержаться одна запись.' + #10 +
                             'Файлы данных источника повреждены или имеют некорректный формат!');
    pbProc.StepIt;

    ImportKTerr;
    pbProc.StepIt;

    FromCSV(qrSubj, path, 'subj.csv');
    pbProc.StepIt;
    FromCSV(qrSubjInfo, path, 'subjinfo.csv');
    pbProc.StepIt;
    FromCSV(qrSubjParam, path, 'subjpar.csv');
    pbProc.StepIt;
    FromCSV(qrOrg, path, 'org2.csv');
    pbProc.StepIt;
    FromCSV(qrOrgCont, path, 'orgcont.csv');
    pbProc.StepIt;
    FromCSV(qrOrgPaym, path, 'orgpaym.csv');
    pbProc.StepIt;
    FromCSV(qrOrgPer, path, 'orgper.csv');
    pbProc.StepIt;
    FromCSV(qrOrgOsn, path, 'orgosn.csv');
    pbProc.StepIt;
    FromCSV(qrForm6Hdr, path, 'form6hdr.csv');
    pbProc.StepIt;
    FromCSV(qrForm6, path, 'form6.csv');
    pbProc.StepIt;              
//    if FileExists(IncludeTrailingPathDelimiter(path)+'fonh37.csv')
//      then FromCSV(qrFONH, path, 'fonh37.csv')
//      else FromCSV(qrFONH, path, 'fonh.csv');
    FromCSV(qrFFS, path, 'ffs.csv');
    FromCSV(qrFOKVED, path, 'fokved.csv');
    FromCSV(qrFFS2010, path, 'ffs2010.csv');
    FromCSV(qrFOKVED2010, path, 'fokved2010.csv');
    FromCSV(qrFSVT2012, path, 'fsvt2012.csv');
    FromCSV(qrFAnaliz, path, 'fanaliz.csv');
    pbProc.StepIt;

//    qrFONH.Close;
    qrFFS.Close;
    qrFOKVED.Close;
    qrFFS2010.Close;
    qrFOKVED2010.Close;
    qrFSVT2012.Close;
    qrFAnaliz.Close;
    pbProc.StepIt;
    qrForm6.Close;
    pbProc.StepIt;
    qrForm6Hdr.Close;
    pbProc.StepIt;
    qrOrgOsn.Close;
    pbProc.StepIt;
    qrOrgPer.Close;
    pbProc.StepIt;
    qrOrgPaym.Close;
    pbProc.StepIt;
    qrOrgCont.Close;
    pbProc.StepIt;
    qrOrg.Close;
    pbProc.StepIt;
    qrSubjParam.Close;
    pbProc.StepIt;
    qrSubjInfo.Close;
    pbProc.StepIt;
    qrSubj.Close;
    pbProc.StepIt;
    qrCurrSubj.Close;
    pbProc.StepIt;

    sp_ImportSubj.ExecProc;
    pbProc.StepIt;

    qrDrop.ExecSQL;
    pbProc.StepIt;

    PC.ActivePage := tshDone;

  except
    on E:Exception do begin
      ShowErr('Ошибка при импорте данных!'#13#13+
        E.ClassName+': '+E.Message);
      ModalResult := mrCancel;
    end;
  end;
end;

procedure TfmImportSubj.FormCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  SubjFLst:= TStringList.Create;
  SubjLst:= TStringList.Create;
  PC.ActivePageIndex := 0;
end;

procedure TfmImportSubj.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key=VK_TAB) then Key := 0;
  if (Shift=[]) and (Key=VK_F1) then btnHelp.Click;
end;

procedure TfmImportSubj.actDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmImportSubj.actShiftDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmImportSubj.FormDestroy(Sender: TObject);
begin
  FreeAndNil(SubjLst);
  FreeAndNil(SubjFLst);
end;

end.

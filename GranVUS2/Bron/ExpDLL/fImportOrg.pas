unit fImportOrg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ADODB, ExtCtrls, StdCtrls, ComCtrls, Buttons, ActnList, Db, dxCntner,
  dxEditor, dxExEdtr, dxEdLib, dxTL, dxDBCtrl, dxDBGrid, Variants;

type
  TfmImportOrg = class(TForm)
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
    tshNew: TTabSheet;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    edOKBV: TEdit;
    Label11: TLabel;
    dFIRST_DATE: TdxDateEdit;
    cbHAS_BRON: TCheckBox;
    qrOrgChk: TADOQuery;
    tshWrongInn: TTabSheet;
    tshWrongId: TTabSheet;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    GroupBox1: TGroupBox;
    rbReplace: TRadioButton;
    rbNew: TRadioButton;
    rbExit: TRadioButton;
    edCurInn: TEdit;
    edNewInn: TEdit;
    mNewName: TMemo;
    mCurName: TMemo;
    Label18: TLabel;
    GroupBox2: TGroupBox;
    rbReplace1: TRadioButton;
    rbNew1: TRadioButton;
    rbExit1: TRadioButton;
    Label19: TLabel;
    dxDBGrid1: TdxDBGrid;
    DataSource1: TDataSource;
    dxDBGrid1Column1: TdxDBGridColumn;
    dxDBGrid1Column2: TdxDBGridColumn;
    dxDBGrid1Column3: TdxDBGridColumn;
    sp_ImportOrg: TADOStoredProc;
    tshWrongTerr: TTabSheet;
    Label10: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    edCurOKATO: TEdit;
    edNewOKATO: TEdit;
    Label23: TLabel;
    tshOrgInfo: TTabSheet;
    Label25: TLabel;
    Label26: TLabel;
    edInn: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    mName: TMemo;
    Label29: TLabel;
    cbF6_SHIFR: TComboBox;
    chkOpenOrgCard: TCheckBox;
    rbTerrSetCurrent: TRadioButton;
    rbTerrKeep: TRadioButton;
    qrTerr: TADOQuery;
    qrOrgPer: TADOQuery;
    qrOrgOsn: TADOQuery;
    Label24: TLabel;
    Label30: TLabel;
    edTerrName: TEdit;
    edSubjName: TEdit;
    qrSubj: TADOQuery;
    qrOVK: TADOQuery;
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
    procedure actDummyExecute(Sender: TObject);
    procedure actShiftDummyExecute(Sender: TObject);
    procedure tshWrongInnShow(Sender: TObject);
    procedure rbWrongInnClick(Sender: TObject);
    procedure rbWrongIdClick(Sender: TObject);
    procedure tshWrongIdShow(Sender: TObject);
    procedure tshWrongIdHide(Sender: TObject);
    procedure tshWrongTerrShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tshOrgInfoShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rbTerrSetCurrentClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    path: string;
    EXT_ID: Integer;
    INN, ORGNAME, OKATO, CurOKATO: string;
    OrgLst, OrgFLst: TStringList;
    function DoChecks: Integer;
  public
  end;

var
  fOpenOrgCard: boolean;
  OrgId: Integer;

implementation

uses msg, FileCtrl, Dates, StrUtils, fPreview;

{$R *.DFM}

procedure TfmImportOrg.btnCancelClick(Sender: TObject);
begin
  if btnCancel.Caption='Закрыть' then begin
    ModalResult := mrOk
  end
  else
    if Confirm('Прервать процесс обмена данными?') then ModalResult := mrCancel;
end;

procedure TfmImportOrg.btnHelpClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTEXT,HelpContext);
end;

procedure TfmImportOrg.rbFloppyClick(Sender: TObject);
begin
  edPath.Enabled := rbPath.Checked;
  sbPath.Enabled := rbPath.Checked;
  if edPath.Enabled then edPath.Color := clWindow
  else edPath.Color := clBtnFace;
  edEMail.Enabled := rbEMail.Checked;
  if edEmail.Enabled then edEmail.Color := clWindow
  else edEmail.Color := clBtnFace;
end;

procedure TfmImportOrg.tshInfoShow(Sender: TObject);
begin
  btnBack.Enabled := false;
end;

procedure TfmImportOrg.tshParamsShow(Sender: TObject);
begin
  lbTop.Caption := 'Выбор параметров импорта данных';
  btnBack.Enabled := true;
  pnlTop.Parent := tshParams;
  bvTop.Parent := tshParams;
end;

procedure TfmImportOrg.tshProcessShow(Sender: TObject);
begin
  lbTop.Caption := 'Процесс импорта данных';
  btnBack.Visible:= false;
  btnNext.Visible := false;
  pnlTop.Parent := tshProcess;
  bvTop.Parent := tshProcess;
  tmGo.Enabled := true;
end;

procedure TfmImportOrg.tshDoneShow(Sender: TObject);
begin
  lbTop.Caption := 'Импорт данных завершен';
  btnCancel.Caption := 'Закрыть';
  btnCancel.Default := true;
  pnlTop.Parent := tshDone;
  bvTop.Parent := tshDone;
end;

procedure TfmImportOrg.btnBackClick(Sender: TObject);
begin
  if PC.ActivePage = tshWrongInn then begin
    btnNext.Enabled:= True;
    PC.ActivePageIndex:= tshParams.PageIndex;
  end else if PC.ActivePage = tshWrongId then begin
    btnNext.Enabled:= True;
    PC.ActivePageIndex:= tshParams.PageIndex;
  end else if PC.ActivePage = tshNew then begin
    PC.ActivePageIndex:= tshParams.PageIndex;
  end else if PC.ActivePage = tshWrongTerr then begin
    PC.ActivePageIndex:= tshParams.PageIndex;
  end else
    PC.ActivePageIndex := PC.ActivePageIndex-1;
end;

function TfmImportOrg.DoChecks: Integer;
begin
  Result:= PC.ActivePageIndex;
  if EXT_ID > 0 then begin
    with qrOrgChk do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ORG');
      SQL.Add('WHERE ORGID = :ORGID');
      Parameters.ParamValues['ORGID']:= EXT_ID;
      Open;
      if IsEmpty then EXT_ID:= 0
      else begin
        if FieldByName('INN').AsString = INN then begin
          Result:= tshProcess.PageIndex;
        end else
          Result:= tshWrongInn.PageIndex;
      end;
      Close;
    end;
  end;
  if EXT_ID = 0 then begin
    with qrOrgChk do begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ORG');
      SQL.Add('WHERE INN = :INN');
      Parameters.ParamValues['INN']:= INN;
      Open;
      if IsEmpty then begin
        Result:= tshNew.PageIndex;
      end else begin
        Result:= tshWrongId.PageIndex;
      end;
      Close;
    end;
  end;
end;

procedure TfmImportOrg.btnNextClick(Sender: TObject);
//
  function OrgValue(const AField: String): String;
  var I: Integer;
  begin
    I := OrgFLst.IndexOf(AField);
    if I>=0 then Result := Trim(OrgLst[I]) else Result := '';
  end;
//
var
  F            : TextFile;
  n,p          : Integer;
  sFIRST_DATE  : String;
  sF6_SHIFR    : String;
  buf          : Array[0..MAX_PATH-1] of char;
  s            : string;
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
    if Length(path)>0 then
     if path[Length(path)]<>'\' then path := path + '\';

    try
      AssignFile(F,path+'org.csv');
      ReSet(F);
      ReadLn(F,s);
      s := AnsiUpperCase(s);
      if (Pos(',EXT_ID,',s)=0) or (Pos(',INN,',s)=0) or (Pos(',ORGNAME,',s)=0) or (Pos(',KODTERR,',s)=0) then begin
        ShowErr('Файлы данных источника повреждены или имеют некорректный формат!');
        ModalResult := mrCancel;
        Exit;
      end;
      OrgFLst.CommaText := s;
      n := OrgFLst.Count;
      ReadLn(F,s);
      OrgLst.CommaText := s;
      while OrgLst.Count<n do OrgLst.Add(EmptyStr);
      EXT_ID             := StrToIntDef(OrgValue('EXT_ID'),0);
      INN                := OrgValue('INN');
      ORGNAME            := OrgValue('ORGNAME');
      OKATO              := OrgValue('KODTERR');
      edOKBV.Text        := OrgValue('OKBV');
      cbHAS_BRON.Checked := OrgValue('HAS_BRON')='1';
      sFIRST_DATE        := OrgValue('FIRST_DATE');
      sF6_SHIFR          := OrgValue('F6_SHIFR');

      if sFIRST_DATE<>''
        then dFIRST_DATE.Date := Str2Date(sFIRST_DATE)
        else dFIRST_DATE.Date := Date;
      if sF6_SHIFR <> ''
        then cbF6_SHIFR.ItemIndex:= cbF6_SHIFR.Items.IndexOf(sF6_SHIFR)
        else cbF6_SHIFR.ItemIndex:= -1;
    finally
      CloseFile(F);
    end;

    with TADOQuery.Create(Self) do try
      Connection := dbMain;
      SQL.Text := 'SELECT T.KODTERR FROM SUBJ S JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID JOIN KTERR T ON S.TERR_ID = T.TERR_ID';
      Open;
      if IsEmpty then begin
        ShowErr('Не указан текущий ВУО. Необходимо выбрать текущий ВУО в списке.');
        Exit;
      end else CurOKATO := Fields[0].AsString;
    finally
      Free;
    end;

    p:= tshOrgInfo.PageIndex;
  end else if PC.ActivePage = tshOrgInfo then begin
    if OKATO <> CurOKATO then
      p:= tshWrongTerr.PageIndex
    else p:= DoChecks;
  end else if PC.ActivePage = tshWrongTerr then begin
    if rbTerrKeep.Checked then begin
      if Trim(edTerrName.Text)=EmptyStr then begin
        edTerrName.SetFocus;
        ShowErr('Не указано наименование территории или отрасли!');
        Exit;
      end;
      if Trim(edSubjName.Text)=EmptyStr then begin
        edSubjName.SetFocus;
        ShowErr('Не указано наименование ВУО!');
        Exit;
      end;
    end;
    p:= DoChecks;
  end else if PC.ActivePage = tshWrongInn then begin
    if rbReplace.Checked then begin
      p:= tshProcess.PageIndex;
    end else if rbNew.Checked then begin
      p:= tshNew.PageIndex;
    end else if rbExit.Checked then begin
      ShowInfo('Импорт прерван.');
      ModalResult := mrCancel;
      Exit;
    end;
  end else if PC.ActivePage = tshWrongId then begin
    if rbReplace1.Checked then begin
      EXT_ID:= qrOrgChk.FieldByName('ORGID').AsInteger;
      p:= tshProcess.PageIndex;
    end else if rbNew1.Checked then begin
      p:= tshNew.PageIndex;
    end else if rbExit1.Checked then begin
      ShowInfo('Импорт прерван.');
      ModalResult := mrCancel;
      Exit;
    end;
  end else if PC.ActivePage = tshNew then begin
    if Trim(edOKBV.Text) = EmptyStr then begin
      ShowErr('Необходимо заполнить номер ОКБВ.');
      edOKBV.SetFocus;
    end else begin
      EXT_ID:= 0;
      p:= tshProcess.PageIndex;
    end
  end
  else Inc(p);

  PC.ActivePageIndex:= p;
end;

procedure TfmImportOrg.sbPathClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Укажите размещение файлов на диске...',EmptyStr,s) then
    edPath.Text := s;
end;

procedure TfmImportOrg.tmGoTimer(Sender: TObject);

  function GetFS_ID(FS_KOD: string): variant;
  begin
    with qrFS do begin
      if not Active then Open;
      if Locate('KOD', FS_KOD, []) then
        Result:= FieldByName('FS_ID').AsInteger
      else Result:= Null;
      if VarIsNull(Result) and (Trim(FS_KOD) <> '') then
        if Confirm('В справочнике форм собственности нет элемента с кодом: ' + Trim(FS_KOD) + '. Добавить?') then begin
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

  function GetKOPF_ID(KOPF_KOD: string): variant;
  begin
    with qrKOPF do begin
      if not Active then Open;
      if Locate('KOD', KOPF_KOD, []) then
        Result:= FieldByName('KOPF_ID').AsInteger
      else Result:= Null;
      if VarIsNull(Result) and (Trim(KOPF_KOD) <> '') then
        if Confirm('В справочника организационно-правовых форм нет элемента с кодом: ' + Trim(KOPF_KOD) + '. Добавить?') then begin
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

  function GetTerrID(TERR_KOD: string): Integer;
  begin
    with qrTerr do begin
      if not Active then Open;
      if not Locate('KODTERR',TERR_KOD,[]) then begin
        Append;
        FieldByName('KODTERR').Value := TERR_KOD;
        FieldByName('NAME').Value := edTerrName.Text;
        Post;
      end;
      Result := FieldByName('TERR_ID').Value;
    end;
    with qrSubj do begin
      if not Active then Open;
      if not Locate('TERR_ID',Result,[]) then begin
        Append;
        FieldByName('TYPE_ID').Value := 2;
        FieldByName('TERR_ID').Value := Result;
        FieldByName('SUBJ_NAME').Value := edTerrName.Text;
        FieldByName('SUBJ_FULLNAME').Value := edSubjName.Text;
        FieldByName('SUBJ_AGG_ID').Value := 1;
        Post;
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

  procedure FromCSV(qr: TADOQuery; path: string; fname: string);
  var F: TextFile;
      flst,lst : TStringList;
      s,ss: string;
      n,i: Integer;
      fld: TField;
  begin
    while not qr.EOF do qr.Delete;
    if Length(path)>0 then
      if path[Length(path)]<>'\' then path := path + '\';
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
              else if s = 'OKOPF' then s:= 'KOPF_ID'
              else if s = 'KODTERR' then s := 'TERR_ID';
              fld:= qr.FindField(s);

              if not Assigned(fld) then
                //raise Exception.Create('Неизвестное поле. Поле: ' + flst.Strings[n] + ' файл: ' + fname + #10 +
                //                       'Файлы данных источника повреждены или имеют некорректный формат!');
                 Continue;
              if s='FIO' then begin
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
              end else if fld.FieldName='KOPF_ID' then begin
                fld.Value:= GetKOPF_ID(lst.Strings[n]);
              end else if fld.FieldName='BASE_ID' then begin
                fld.Value:= GetBASE_ID(lst.Strings[n]);
              end else if fld.FieldName='TERR_ID' then begin
                if rbTerrSetCurrent.Checked then
                  fld.Value:=GetTerrID(CurOKATO)
                else
                  fld.Value:=GetTerrID(OKATO);
              end else if fld.DataType in [ftDate,ftDateTime] then begin
                if lst.Strings[n] <> EmptyStr then fld.Value:= Str2Date(lst.Strings[n]);
              end else if fld.DataType in [ftBoolean] then begin
                if lst.Strings[n] <> '' then
                  fld.Value:= Boolean(StrToInt(lst.Strings[n]));
              end else
                fld.AsString:= lst.Strings[n];
            end;
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

var
  idxFirstDate,idxLastDate,idxOKBV,idxF6_SHIFR: Integer;
begin
  tmGo.Enabled := false;
  Application.ProcessMessages;
  try
    qrDrop.ExecSQL;
    qrCreate.ExecSQL;
    pbProc.StepIt;

    qrOrg.Open;
    pbProc.StepIt;
    qrOVK.Open;
    pbProc.StepIt;
    qrOrgCont.Open;
    pbProc.StepIt;
    qrOrgPaym.Open;
    pbProc.StepIt;
    qrForm6Hdr.Open;
    pbProc.StepIt;
    qrForm6.Open;
    pbProc.StepIt;
    qrOrgOsn.Open;
    pbProc.StepIt;
    qrOrgPer.Open;
    pbProc.StepIt;

    FromCSV(qrOrg, path, 'org.csv');
    if qrOrg.RecordCount <> 1 then
      raise Exception.Create('В файле org.csv должна содержаться одна запись.' + #10 +
                             'Файлы данных источника повреждены или имеют некорректный формат!');
    pbProc.StepIt;
    FromCSV(qrOrgCont, path, 'orgcont.csv');
    pbProc.StepIt;
    FromCSV(qrOrgPaym, path, 'orgpaym.csv');
    pbProc.StepIt;
    FromCSV(qrForm6Hdr, path, 'form6hdr.csv');
    pbProc.StepIt;
    FromCSV(qrForm6, path, 'form6.csv');
    pbProc.StepIt;
    FromCSV(qrOrgPer, path, 'orgper.csv');
    pbProc.StepIt;
    FromCSV(qrOrgOsn, path, 'orgosn.csv');
    pbProc.StepIt;

    qrOrg.Edit;
    if EXT_ID = 0 then begin
      qrOrg.FieldByName('OKBV').AsString:= edOKBV.Text;
      qrOrg.FieldByName('FIRST_DATE').AsDateTime:= dFIRST_DATE.Date;
      qrOrg.FieldByName('HAS_BRON').AsBoolean:= cbHAS_BRON.Checked;
      qrOrg.FieldByName('F6_SHIFR').AsString:= cbF6_SHIFR.Text;
    end;
    qrOrg.FieldByName('LAST_DATE').AsDateTime:= Date;
    qrOrg.Post;
    pbProc.StepIt;

    idxFirstDate := OrgFLst.IndexOf('FIRST_DATE');
    if idxFirstDate < 0 then begin
      idxFirstDate:= OrgFLst.Add('FIRST_DATE');
      OrgLst.Add('');
    end;
    idxLastDate := OrgFLst.IndexOf('LAST_DATE');
    if idxLastDate < 0 then begin
      idxLastDate:= OrgFLst.Add('LAST_DATE');
      OrgLst.Add('');
    end;
    idxOKBV := OrgFLst.IndexOf('OKBV');
    if idxOKBV < 0 then begin
      idxOKBV:= OrgFLst.Add('OKBV');
      OrgLst.Add('');
    end;
    idxF6_SHIFR := OrgFLst.IndexOf('F6_SHIFR');
    if idxF6_SHIFR < 0 then begin
      idxF6_SHIFR:= OrgFLst.Add('F6_SHIFR');
      OrgLst.Add('');
    end;

    OrgLst.Strings[idxFirstDate]:= Date2Str(qrOrg.FieldByName('FIRST_DATE').AsDateTime);
    OrgLst.Strings[idxLastDate]:= Date2Str(qrOrg.FieldByName('LAST_DATE').AsDateTime);
    OrgLst.Strings[idxOKBV]:= qrOrg.FieldByName('OKBV').AsString;
    OrgLst.Strings[idxF6_SHIFR]:= qrOrg.FieldByName('F6_SHIFR').AsString;

    qrOVK.Close;
    pbProc.StepIt;
    qrForm6.Close;
    pbProc.StepIt;
    qrForm6Hdr.Close;
    pbProc.StepIt;
    qrOrgPaym.Close;
    pbProc.StepIt;
    qrOrgCont.Close;
    pbProc.StepIt;
    qrOrg.Close;
    pbProc.StepIt;
    qrOrgPer.Close;
    pbProc.StepIt;
    qrOrgOsn.Close;
    pbProc.StepIt;

    if EXT_ID = 0 then
      sp_ImportOrg.Parameters.ParamValues['@EXT_ID']:= Null
    else sp_ImportOrg.Parameters.ParamValues['@EXT_ID']:= EXT_ID;
    sp_ImportOrg.ExecProc;
    OrgId := sp_ImportOrg.Parameters.ParamValues['@EXT_ID'];
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

procedure TfmImportOrg.FormCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMEssage('Close default connection!');
  OrgFLst:= TStringList.Create;
  OrgLst:= TStringList.Create;
  PC.ActivePageIndex := 0;
end;

procedure TfmImportOrg.actDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmImportOrg.actShiftDummyExecute(Sender: TObject);
begin
//
end;

procedure TfmImportOrg.tshWrongInnShow(Sender: TObject);
begin
  rbReplace.Checked:= False;
  rbNew.Checked:= False;
  rbExit.Checked:= False;
  qrOrgChk.Open;
  edCurInn.Text:= qrOrgChk.FieldByName('INN').AsString;
  edNewInn.Text:= INN;
  mCurName.Lines.Text:= qrOrgChk.FieldByName('ORGNAME').AsString;
  mNewName.Lines.Text:= ORGNAME;
  qrOrgChk.Close;
  rbWrongInnClick(Sender);
end;

procedure TfmImportOrg.rbWrongInnClick(Sender: TObject);
begin
  btnNext.Enabled:= rbReplace.Checked or rbNew.Checked or rbExit.Checked;
end;

procedure TfmImportOrg.rbWrongIdClick(Sender: TObject);
begin
  btnNext.Enabled:= rbReplace1.Checked or rbNew1.Checked or rbExit1.Checked;
end;

procedure TfmImportOrg.tshWrongIdShow(Sender: TObject);
begin
  rbReplace1.Checked:= False;
  rbNew1.Checked:= False;
  rbExit1.Checked:= False;
  qrOrgChk.Open;
  rbWrongIdClick(Sender);
end;

procedure TfmImportOrg.tshWrongIdHide(Sender: TObject);
begin
  qrOrgChk.Close;
end;

procedure TfmImportOrg.tshWrongTerrShow(Sender: TObject);
begin
  edCurOKATO.Text:= CurOKATO;
  edNewOKATO.Text:= OKATO;
  rbTerrKeep.Enabled := OKATO<>EmptyStr;
  if rbTerrKeep.Enabled then begin
    if not qrTerr.Active then qrTerr.Open;
    if qrTerr.Locate('KODTERR',OKATO,[]) then begin
      edTerrName.Text := qrTerr.FieldByName('NAME').AsString;
      if not qrSubj.Active then qrSubj.Open;
      if qrSubj.Locate('TERR_ID',qrTerr.FieldByName('TERR_ID').AsInteger,[]) then
        edSubjName.Text := qrSubj.FieldByName('SUBJ_FULLNAME').AsString;
    end;
  end;
end;

procedure TfmImportOrg.FormDestroy(Sender: TObject);
begin
  FreeAndNil(OrgLst);
  FreeAndNil(OrgFLst);
end;

procedure TfmImportOrg.tshOrgInfoShow(Sender: TObject);
begin
  edInn.Text:= INN;
  mName.Lines.Text:= ORGNAME;
end;

procedure TfmImportOrg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fOpenOrgCard := chkOpenOrgCard.Checked;
end;

procedure TfmImportOrg.rbTerrSetCurrentClick(Sender: TObject);
begin
  edTerrName.Enabled := rbTerrKeep.Checked;
  edSubjName.Enabled := rbTerrKeep.Checked;
  if rbTerrKeep.Checked then begin
    edTerrName.Color := clWindow;
    edSubjName.Color := clWindow;
  end
  else begin
    edTerrName.Color := clBtnFace;
    edSubjName.Color := clBtnFace;
  end;
end;

procedure TfmImportOrg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then btnHelp.Click;
end;

initialization
  fOpenOrgCard := false;
end.

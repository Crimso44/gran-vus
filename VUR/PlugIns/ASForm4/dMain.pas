unit dMain;

interface

uses
  fSetFilter,
  SysUtils, Classes, DB, ADODB, ekbasereport, ekrtf, Dialogs, Forms, Windows,
  ekfunc, Controls, dxmdaset;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    EkUDFList1: TEkUDFList;
    qrOrg: TADOQuery;
    qrOrgIOFam: TStringField;
    qrOrgFamIO: TStringField;
    qrOrgorgname: TStringField;
    qrOrgfam: TStringField;
    qrOrgIm: TStringField;
    qrOrgOtch: TStringField;
    qrOrgPOST: TStringField;
    qrOrgMAINOKONH: TWideStringField;
    qrOrgORGID: TIntegerField;
    qrOrgPARENT: TWideStringField;
    qrOrgFS_ID: TIntegerField;
    qrOrgINN: TWideStringField;
    qrOrgOKPO: TWideStringField;
    qrOrgOKONH: TWideMemoField;
    qrOrgSOOGU: TWideStringField;
    qrOrgKOPF_ID: TIntegerField;
    qrOrgKODREG: TWideStringField;
    qrOrgREGDATE: TDateTimeField;
    qrOrgREGNUM: TWideStringField;
    qrOrgORGSNAME: TWideStringField;
    qrOrgCOMMENT: TWideMemoField;
    qrOrgFIZADDR: TWideStringField;
    qrOrgURADDR: TWideStringField;
    qrOrgPOSTADDR: TWideStringField;
    qrOrgPHONE: TWideStringField;
    qrOrgFAX: TWideStringField;
    qrOrgEMAIL: TWideStringField;
    qrOrgWWW: TWideStringField;
    qrOrgMYORG: TSmallintField;
    qrOrgCONFDATE: TDateTimeField;
    qrOrgOKBV: TWideStringField;
    qrOrgFIRST_DATE: TDateTimeField;
    qrOrgLAST_DATE: TDateTimeField;
    qrOrgEXT_ID: TIntegerField;
    qrOrgF6_SHIFR: TWideStringField;
    qrOrgOCCUPATION: TWideStringField;
    qrOrgSBM_ID: TIntegerField;
    qrOrgTERR_ID: TIntegerField;
    qrOrgHAS_BRON: TBooleanField;
    qrOrgREGPL_ID: TIntegerField;
    qrOrgOKATO2: TWideStringField;
    qrOrgOKATO3: TWideStringField;
    qrOrgFeature1: TWideStringField;
    qrOrgFeature2: TWideStringField;
    qrOrgFeature3: TWideStringField;
    qrOrgOVK_ID: TIntegerField;
    qrOrgLicense1: TWideStringField;
    qrOrgLicense1_date: TDateTimeField;
    qrOrgLicense1Who: TWideStringField;
    qrOrgLicense2: TWideStringField;
    qrOrgLicense2_date: TDateTimeField;
    qrOrgLicense2Who: TWideStringField;
    qrOrgCertificate: TWideStringField;
    qrOrgBeginCertificate_date: TDateTimeField;
    qrOrgEndCertificate_date: TDateTimeField;
    qrOrgCertificateWho: TWideStringField;
    qrOrgWhoPuts: TWideStringField;
    qrOrgHasVK: TBooleanField;
    qrOrgVKChief: TWideStringField;
    qrOrgVKChiefRange: TIntegerField;
    qrOrgKODOKTMO: TWideStringField;
    qrOrgKODOKTMO2: TWideStringField;
    qrOrgREGPLACE: TWideStringField;
    qrOrgCOMPUTERS: TIntegerField;
    qrOrgSOFTWARENUM: TIntegerField;
    qrOrgSOFTWARE: TWideStringField;
    qrOrgfam1: TWideStringField;
    qrOrgim1: TWideStringField;
    qrOrgotch1: TWideStringField;
    qrOrgpost1: TWideStringField;
    qrOrgIOFam1: TStringField;
    qrOrgFamIO1: TStringField;
    qrMaster: TADOQuery;
    mData: TdxMemData;
    mDataRecNo: TIntegerField;
    mDataDep_NameX: TStringField;
    mDatahead: TBooleanField;
    mDatahead2: TBooleanField;
    mDataN1: TIntegerField;
    mDataN2: TIntegerField;
    mDataN3: TIntegerField;
    mDataN4: TIntegerField;
    mDataN5: TIntegerField;
    mDataN6: TIntegerField;
    mDataN7: TIntegerField;
    mDataM1: TIntegerField;
    mDataM2: TIntegerField;
    mDataM3: TIntegerField;
    mDataM4: TIntegerField;
    mDataM5: TIntegerField;
    mDataM6: TIntegerField;
    mDataM7: TIntegerField;
    mDataheadX: TBooleanField;
    qrStaffPlan: TADOQuery;
    qrStaffQty: TADOQuery;
    mDataNM1: TStringField;
    mDataNM2: TStringField;
    mDataNM3: TStringField;
    mDataNM4: TStringField;
    mDataNM5: TStringField;
    mDataNM6: TStringField;
    mDataNM7: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1dateCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1NotIsNullCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure qrOrgCalcFields(DataSet: TDataSet);
    procedure qrDetailCalcFields(DataSet: TDataSet);
    procedure mDataCalcFields(DataSet: TDataSet);
  public
    flt: TfxSetFilter;
    function PrintData: boolean;
    function GetMonthName(m: Integer): String;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'НАСФ: Ведомость учета ЛС и техники НАСФ';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils;

function TdmMain.PrintData: boolean;
var
  res, dd, mm, yy: Word;
  sKMtrAsf, sKMtrAsfSub: String;
  i, recNo, cnt: Integer;
  sAsf: TStringList;
  fill, first, cont: Boolean;
  s, ssASF, ssMTR: String;
  IsJet: Boolean;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  flt := TfxSetFilter.Create(Self);

  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain; ParamCheck := False;
    SQL.Text := 'SELECT '+
      'Id as KAsfMtr_Id, Iif((ShortName is null), Name, ShortName) As NameX '+
      ' FROM KAsfMtr ' +
      ' ORDER BY Iif((ShortName is null), Name, ShortName)';
    Open;
    while not EOF do begin
      flt.cbDeps.Items.AddObject(FieldByName('NameX').AsString,Pointer(FieldByName('KAsfMtr_Id').AsInteger));
      flt.cbDeps.Checked[flt.cbDeps.Items.Count-1] := True;
      Next;
    end;
    Close;
    cnt := 0;
    SQL.Text := 'SELECT * FROM ASF ORDER BY Iif((OrgSName is null), OrgName, OrgSName)';
    Open;
    while not EOF do begin
      s := FieldByName('OrgSName').AsString;
      if s = '' then s := FieldByName('OrgName').AsString;
      flt.cbPosts.Items.AddObject(s,Pointer(FieldByName('ASF_ID').AsInteger));
      flt.cbPosts.Checked[flt.cbPosts.Items.Count-1] := cnt < 7;
      Inc(cnt);
      Next;
    end;
  finally Free;
  end;

  cont := True;
  while cont do begin
    res := flt.ShowModal;
    if res = mrOK then begin
      ssASF := ''; ssMTR := ''; cnt := 0;
      cont := False;
      for i := 0 to flt.cbPosts.Items.Count - 1 do begin
        if flt.cbPosts.Checked[i] then begin
          ssASF := ssASF + IntToStr(Integer(flt.cbPosts.Items.Objects[i])) + ',';
          Inc(cnt);
          if cnt > 7 then begin
            MessageBox(flt.Handle, 'Для построения отчета требуется выбрать не более 7 формирований!', 'Ошибка', Mb_Ok+Mb_IconError);
            cont := True;
            Break;
          end;
        end;
      end;
      if (not cont) and (cnt = 0) then begin
        MessageBox(flt.Handle, 'Пожалуйста, выберите хотя бы одно формирование', 'Ошибка', Mb_Ok+Mb_IconError);
        cont := True;
      end;
      if not cont then begin
        ssASF := Copy(ssASF, 1, Length(ssASF)-1);
        for i := 0 to flt.cbDeps.Items.Count - 1 do begin
          if flt.cbDeps.Checked[i] then begin
            ssMTR := ssMTR + IntToStr(Integer(flt.cbDeps.Items.Objects[i])) + ',';
          end;
        end;
        if ssMTR = '' then begin
          MessageBox(flt.Handle, 'Пожалуйста, выберите хотя бы один вид МТР', 'Ошибка', Mb_Ok+Mb_IconError);
          cont := True;
        end;
        ssMTR := Copy(ssMTR, 1, Length(ssMTR)-1);
      end;
    end else begin
      Result := True;
      Break;
    end;
  end;

  try

  if res = mrOK then begin

    sAsf := TStringList.Create;
    sAsf.Sorted := True;
    sAsf.Duplicates := dupIgnore;

    qrOrg.Open;

    qrMaster.SQL.Text := StringReplace(StringReplace(qrMaster.SQL.Text,
      '%ASF%', ssASF, [rfReplaceAll]), '%MTR%', ssMTR, [rfReplaceAll]);
    qrMaster.Open;
    mData.Open;

    sKMtrAsf := ''; recNo := 0;
    while not qrMaster.Eof do begin
      if sKMtrAsf <> qrMaster.FieldByName('KAsfMtrName').AsString then begin
        Inc(recNo);
        mData.Append;
        mDataRecNo.AsInteger := recNo;
        mDataDep_NameX.AsString := qrMaster.FieldByName('KAsfMtrName').AsString;
        if qrMaster.FieldByName('Name').AsString = '' then
          mDataHead.AsBoolean := True
        else
          mDataHeadX.AsBoolean := True;
        mData.Post;
      end;
      if qrMaster.FieldByName('Name').AsString <> '' then begin
        mData.Append;
        mDataHead2.AsBoolean := True;
        mDataDep_NameX.AsString := qrMaster.FieldByName('Name').AsString;
        mData.Post;
      end;

      sKMtrAsf := qrMaster.FieldByName('KAsfMtrName').AsString;
      sKMtrAsfSub := qrMaster.FieldByName('Name').AsString;
      while
        (sKMtrAsf = qrMaster.FieldByName('KAsfMtrName').AsString) and
        (sKMtrAsfSub = qrMaster.FieldByName('Name').AsString) and
        not qrMaster.Eof do begin

        sAsf.Append(qrMaster.FieldByName('Dep_Name').AsString);

        qrMaster.Next;
      end;
    end;

    qrStaffPlan.SQL.Text := StringReplace(qrStaffPlan.SQL.Text, '%ASF%', ssASF, [rfReplaceAll]);
    qrStaffPlan.Open;
    while not qrStaffPlan.Eof do begin
      sAsf.Append(qrStaffPlan.FieldByName('Dep_Name').AsString);
      qrStaffPlan.Next;
    end;

    qrStaffQty.SQL.Text := StringReplace(qrStaffQty.SQL.Text, '%ASF%', ssASF, [rfReplaceAll]);
    if not IsJet then
      qrStaffQty.SQL.Text := StringReplace(qrStaffQty.SQL.Text, 'Date()', 'GetDate()', [rfReplaceAll]);
    qrStaffQty.Open;
    while not qrStaffQty.Eof do begin
      sAsf.Append(qrStaffQty.FieldByName('Dep_Name').AsString);
      qrStaffQty.Next;
    end;

    qrMaster.First; mData.First;
    sKMtrAsf := ''; sKMtrAsfSub := ''; first := True;
    while not qrMaster.Eof do begin
      fill := False;
      if sKMtrAsf <> qrMaster.FieldByName('KAsfMtrName').AsString then begin
        if not first then mData.Next else first := False;
      end;
      if qrMaster.FieldByName('Name').AsString <> '' then begin
        if not first then mData.Next else first := False;
      end;

      sKMtrAsf := qrMaster.FieldByName('KAsfMtrName').AsString;
      sKMtrAsfSub := qrMaster.FieldByName('Name').AsString;
      mData.Edit;
      while
        (sKMtrAsf = qrMaster.FieldByName('KAsfMtrName').AsString) and
        (sKMtrAsfSub = qrMaster.FieldByName('Name').AsString) and
        not qrMaster.Eof do begin

        mData.FieldByName('N'+IntToStr(sAsf.IndexOf(qrMaster.FieldByName('Dep_Name').AsString)+1)).AsInteger :=
          qrMaster.FieldByName('GenPlan').AsInteger;
        mData.FieldByName('M'+IntToStr(sAsf.IndexOf(qrMaster.FieldByName('Dep_Name').AsString)+1)).AsInteger :=
          qrMaster.FieldByName('GenQty').AsInteger;

        qrMaster.Next;
      end;
      mData.Post;

      first := False;
    end;

    for i := 0 to 6 do begin
      if i < sAsf.Count then begin
        EkRTF1.CreateVar('ASF'+IntToStr(i+1), sAsf[i]);
        if qrStaffPlan.Locate('dep_name', sAsf[i], []) then
          EkRTF1.CreateVar('QPlan'+IntToStr(i+1), qrStaffPlan.FieldByName('GenPlan').AsInteger)
        else
          EkRTF1.CreateVar('QPlan'+IntToStr(i+1), '');
        if qrStaffQty.Locate('dep_name', sAsf[i], []) then
          EkRTF1.CreateVar('QQty'+IntToStr(i+1), qrStaffQty.FieldByName('GenQty').AsInteger)
        else
          EkRTF1.CreateVar('QQty'+IntToStr(i+1), '');
      end else begin
        EkRTF1.CreateVar('ASF'+IntToStr(i+1), '');
        EkRTF1.CreateVar('QPlan'+IntToStr(i+1), '');
        EkRTF1.CreateVar('QQty'+IntToStr(i+1), '');
      end;
    end;

    DecodeDate(Date, yy, mm, dd);
    EkRTF1.CreateVar('CurDate', '"'+IntToStr(dd)+'" '+GetMonthName(mm)+' '+IntToStr(yy)+' г.');
    EkRTF1.ExecuteOpen([mData, qrOrg],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, Copy(sEventObject, 1, 50), []);
    sAsf.Free;
  end;
  except
//    on E: Exception do ShowMessage(e.Message);
  end;

  flt.Free;
end;

procedure TdmMain.qrOrgCalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('IOFam').Value :=
      (FieldByName('Im').AsString+' ')[1]+'.'+
      (FieldByName('Otch').AsString+' ')[1]+'. '+
      FieldByName('Fam').AsString;
    FieldByName('FamIO').Value :=
      FieldByName('Fam').AsString+' '+
      (FieldByName('Im').AsString+' ')[1]+'.'+
      (FieldByName('Otch').AsString+' ')[1]+'.';
    FieldByName('IOFam1').Value :=
      (FieldByName('Im1').AsString+' ')[1]+'.'+
      (FieldByName('Otch1').AsString+' ')[1]+'. '+
      FieldByName('Fam1').AsString;
    FieldByName('FamIO1').Value :=
      FieldByName('Fam1').AsString+' '+
      (FieldByName('Im1').AsString+' ')[1]+'.'+
      (FieldByName('Otch1').AsString+' ')[1]+'.';
  end;
end;

procedure TdmMain.qrDetailCalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('RecNo').Value := abs(RecNo);
  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'ASForm4.rtf';
  EkRTF1.Outfile := GetReportsDir + 'НАСФ Форма № 4.rtf';
end;

procedure TdmMain.EkUDFList1dateCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  (UDFResult as TEkReportVariable).AsString := FormatDateTime('dd.mm.yyyy',Date);
end;

procedure TdmMain.EkUDFList1NotIsNullCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
function CheckNull(O: TObject): Boolean;
begin
  if O is TField then Result := TField(O).IsNull or (TField(O).AsString='')
  else Result := Trim(TEkReportVariable(O).AsString) <> '';
end;
var
  I: integer;
  B: boolean;
begin
  B := True;
  for I := 0 to Length(Args)-1 do B := B and not CheckNull(Args[I]);
  (UDFResult as TEkReportVariable).AsBoolean := B;
end;

function TdmMain.GetMonthName(m: Integer): String;
begin
  Result := '';
  case m of
    1: Result := 'января';
    2: Result := 'февраля';
    3: Result := 'марта';
    4: Result := 'апреля';
    5: Result := 'мая';
    6: Result := 'июня';
    7: Result := 'июля';
    8: Result := 'августа';
    9: Result := 'сентября';
    10: Result := 'октября';
    11: Result := 'ноября';
    12: Result := 'декабря';
  end;
end;

procedure TdmMain.mDataCalcFields(DataSet: TDataSet);
begin
  if (mDataN1.AsInteger = 0) and (mDataM1.AsInteger = 0) then
    mDataNM1.AsString := ''
  else
    mDataNM1.AsString := mDataN1.AsString + ' / ' + mDataM1.AsString;
  if (mDataN2.AsInteger = 0) and (mDataM2.AsInteger = 0) then
    mDataNM2.AsString := ''
  else
    mDataNM2.AsString := mDataN2.AsString + ' / ' + mDataM2.AsString;
  if (mDataN3.AsInteger = 0) and (mDataM3.AsInteger = 0) then
    mDataNM3.AsString := ''
  else
    mDataNM3.AsString := mDataN3.AsString + ' / ' + mDataM3.AsString;
  if (mDataN4.AsInteger = 0) and (mDataM4.AsInteger = 0) then
    mDataNM4.AsString := ''
  else
    mDataNM4.AsString := mDataN4.AsString + ' / ' + mDataM4.AsString;
  if (mDataN5.AsInteger = 0) and (mDataM5.AsInteger = 0) then
    mDataNM5.AsString := ''
  else
    mDataNM5.AsString := mDataN5.AsString + ' / ' + mDataM5.AsString;
  if (mDataN6.AsInteger = 0) and (mDataM6.AsInteger = 0) then
    mDataNM6.AsString := ''
  else
    mDataNM6.AsString := mDataN6.AsString + ' / ' + mDataM6.AsString;
  if (mDataN7.AsInteger = 0) and (mDataM7.AsInteger = 0) then
    mDataNM7.AsString := ''
  else
    mDataNM7.AsString := mDataN7.AsString + ' / ' + mDataM7.AsString;
end;

end.

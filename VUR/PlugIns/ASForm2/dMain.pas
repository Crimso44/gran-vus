unit dMain;

interface

uses
  fSelASF,
  SysUtils, Classes, DB, ADODB, ekbasereport, ekrtf, Dialogs, Forms, Windows,
  ekfunc, Controls, dxmdaset;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrASP: TADOQuery;
    EkUDFList1: TEkUDFList;
    qrOrg: TADOQuery;
    qrOrgIOFam: TStringField;
    qrOrgFamIO: TStringField;
    qrOrgorgname: TStringField;
    qrOrgfam: TStringField;
    qrOrgIm: TStringField;
    qrOrgOtch: TStringField;
    qrOrgPOST: TStringField;
    qrASPRecNo: TIntegerField;
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
    dxMemData: TdxMemData;
    qrASPASP_ID: TIntegerField;
    qrASPASF_ID: TIntegerField;
    qrASPName: TWideStringField;
    qrASPDEP_Name: TWideStringField;
    qrASPASP_Num: TIntegerField;
    qrASPASP_Type: TIntegerField;
    dxMemDataPostName: TStringField;
    dxMemDataFIO: TStringField;
    dxMemDataPlacePost: TStringField;
    dxMemDataAddress: TStringField;
    dxMemDatann: TIntegerField;
    qrASF: TADOQuery;
    WideStringField40: TWideStringField;
    WideStringField41: TWideStringField;
    WideStringField42: TWideStringField;
    WideStringField43: TWideStringField;
    WideStringField44: TWideStringField;
    StringField10: TStringField;
    StringField11: TStringField;
    qrAsfASF_Id: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1dateCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1NotIsNullCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure qrOrgCalcFields(DataSet: TDataSet);
    procedure qrASPCalcFields(DataSet: TDataSet);
    procedure EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
    procedure qrASFCalcFields(DataSet: TDataSet);
    procedure qrASPBeforeOpen(DataSet: TDataSet);
  public
    nn: Integer;
    IsJet: Boolean;
    function PrintData: boolean;
    function GetMonthName(m: Integer): String;
    procedure CalcPosts;
    function GetParamValue(Id: Integer): String;
    function IIsJet(strJet, strSql: String): String;
  end;

var
  dmMain: TdmMain;
  sqlASP: String;


const
  sEventObject = 'НАСФ: Штатно-должностной список НАСФ';

implementation

{$R *.dfm}
uses DateUtils, SaveEvents, IniSupport, StrUtils;

function TdmMain.IIsJet(strJet, strSql: String): String;
begin
  if isJet then
    Result := strJet
  else
    Result := strSql;
end;

function TdmMain.PrintData: boolean;
var
  res, dd, mm, yy: Word;
  i: Integer;
  f: TfrmASF;
  ASF: String;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  try
    f := TfrmASF.Create(Self);
    try
      if f.ShowModal <> mrOK then begin
        Result := True;
        Exit;
      end;
      ASF := '';
      f.mASF.First;
      while not f.mASF.Eof do begin
        if f.mASFSelected.AsBoolean then
          ASF := ASF + f.mASFASF_Id.AsString + ',';
        f.mASF.Next;
      end;
      if ASF = '' then Exit;
      ASF := Copy(ASF, 1, Length(ASF)-1);
    finally
      f.Free;
    end;

    qrOrg.Open;
    qrASF.SQL.Text := StringReplace(qrASF.SQL.Text, '%ASF%', ASF, [rfReplaceAll]);
    if not IsJet then
      qrASF.SQL.Text := StringReplace(qrASF.SQL.Text, 'Date()', 'GetDate()', [rfReplaceAll]);

    qrASF.Open;
    sqlASP := qrASP.SQL.Text;
    qrASP.SQL.Text := StringReplace(sqlASP, '%ASF%', ASF, [rfReplaceAll]);
    qrASP.Open;
    dxMemData.Open;

    DecodeDate(Date, yy, mm, dd);
    EkRTF1.CreateVar('CurDate', '"'+IntToStr(dd)+'" '+GetMonthName(mm)+' '+IntToStr(yy)+' г.');
    nn := 1;
    EkRTF1.ExecuteOpen([qrASP, dxMemData, qrASF, qrOrg],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, Copy(sEventObject, 1, 50), []);
  except
    on E: Exception do ShowMessage(e.Message);
  end;
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

procedure TdmMain.qrASFCalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('IOFam3').Value :=
      (FieldByName('Im3').AsString+' ')[1]+'.'+
      (FieldByName('Otch3').AsString+' ')[1]+'. '+
      FieldByName('Fam3').AsString;
    FieldByName('FamIO3').Value :=
      FieldByName('Fam3').AsString+' '+
      (FieldByName('Im3').AsString+' ')[1]+'.'+
      (FieldByName('Otch3').AsString+' ')[1]+'.';
  end;
end;

procedure TdmMain.qrASPBeforeOpen(DataSet: TDataSet);
begin
  if GetParamValue(6) = '1' then
    qrASP.SQL[qrASP.SQL.Count-1] := 'order by SortName, ASP_Name'
  else
    qrASP.SQL[qrASP.SQL.Count-1] := 'order by SortName, ASP_Num';
end;

procedure TdmMain.qrASPCalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('RecNo').Value := abs(RecNo);
  end;
end;

procedure TdmMain.CalcPosts;
var
  q, qq: TADOQuery;
  i, cnt: Integer;
begin
  dxMemData.Close;
  dxMemData.Open;

  q := TADOQuery.Create(Self);
  qq := TADOQuery.Create(Self);
  with q do try
    Connection := dbMain;
    qq.Connection := dbMain;

    cnt := 0;
    SQL.Text :=
      'Select ASPost_Num, Post_Name, GeneralPlan '+
      'From ASPost as p Inner Join ASStaffList as s on p.ASPost_Id = s.ASPost_Id '+
      'Where GeneralPlan > 0 and ASP_ID = '+qrASPAsp_Id.AsString+' '+
      'Order By ASPost_Num';
    Open;
    if not Eof then cnt := FieldByName('GeneralPlan').AsInteger;

    qq.SQL.Text :=
      'SELECT ASPost_Num, px.Post_Name, Fam+'' ''+Im+'' ''+Otch as FIO, '+
        'iif((Dep_Full_Name is null), Dep_Name, Dep_Full_Name)+'', ''+pp.Post_Name as PlacePost, '+
        'iif((a1.Addr_Str is null),'''', ''По регистрации: ''+a1.Addr_Str)+iif((a2.Addr_Str is null),'''', '' / Фактически: ''+a2.Addr_Str) as Addr '+
      'from ((((((ASPost as px '+
      'inner join ASAppointmentLastAll as a on px.ASPost_Id = a.ASPost_Id) '+
      'inner join Person as p on p.Pers_Id = a.Pers_Id) '+
      'left join AppointmentLastAll as aa on aa.Pers_id = p.Pers_Id) '+
      'left join KPost as pp on pp.Post_Id = aa.Post_Id) '+
      'left join KDepart as d on d.Dep_Id = aa.Dep_Id) '+
      'left join Addr as a1 on (a1.Pers_id = p.Pers_Id and a1.Addr_Type = 0)) '+
      'left join Addr as a2 on (a2.Pers_id = p.Pers_Id and a2.Addr_Type = 1) '+
      'Where a.ASP_ID = '+qrASPAsp_Id.AsString+' '+
        'and (p.ASOut_Date is null or p.ASOut_Date > '+IIsJet('','Get')+'Date()) '+
      'Order By ASPost_Num';
    qq.Open;

    while (not Eof) and (not qq.Eof) do begin
      if FieldByName('ASPost_Num').AsInteger = qq.FieldByName('ASPost_Num').AsInteger then begin
        dxMemData.Append;
        dxMemDataPostName.AsString := FieldByName('Post_Name').AsString;
        dxMemDataFIO.AsString := qq.FieldByName('FIO').AsString;
        dxMemDataPlacePost.AsString := qq.FieldByName('PlacePost').AsString;
        dxMemDataAddress.AsString := qq.FieldByName('Addr').AsString;
        if cnt > 0 then
          Dec(cnt)
        else
          dxMemDataPostName.AsString := dxMemDataPostName.AsString+' (сверх штата)';
        dxMemDataNn.AsInteger := nn; Inc(nn);
        dxMemData.Post;
        qq.Next;
      end else if FieldByName('ASPost_Num').AsInteger < qq.FieldByName('ASPost_Num').AsInteger then begin
        while cnt > 0 do begin
          dxMemData.Append;
          dxMemDataPostName.AsString := FieldByName('Post_Name').AsString+' (вакантно)';
          dxMemDataNn.AsInteger := nn; Inc(nn);
          dxMemData.Post;
          Dec(cnt);
        end;
        Next;
        if not Eof then cnt := FieldByName('GeneralPlan').AsInteger;
      end else if FieldByName('ASPost_Num').AsInteger > qq.FieldByName('ASPost_Num').AsInteger then begin
        dxMemData.Append;
        dxMemDataPostName.AsString := qq.FieldByName('Post_Name').AsString+' (сверх штата)';
        dxMemDataFIO.AsString := qq.FieldByName('FIO').AsString;
        dxMemDataPlacePost.AsString := qq.FieldByName('PlacePost').AsString;
        dxMemDataAddress.AsString := qq.FieldByName('Addr').AsString;
        dxMemDataNn.AsInteger := nn; Inc(nn);
        dxMemData.Post;
        qq.Next;
      end;
    end;
    while (cnt > 0) or not Eof do begin
      while cnt > 0 do begin
        dxMemData.Append;
        dxMemDataPostName.AsString := FieldByName('Post_Name').AsString+' (вакантно)';
        dxMemDataNn.AsInteger := nn; Inc(nn);
        dxMemData.Post;
        Dec(cnt);
      end;
      Next;
      if not Eof then cnt := FieldByName('GeneralPlan').AsInteger;
    end;
    while not qq.Eof do begin
      dxMemData.Append;
      dxMemDataPostName.AsString := qq.FieldByName('Post_Name').AsString+' (сверх штата)';
      dxMemDataFIO.AsString := qq.FieldByName('FIO').AsString;
      dxMemDataPlacePost.AsString := qq.FieldByName('PlacePost').AsString;
      dxMemDataAddress.AsString := qq.FieldByName('Addr').AsString;
      dxMemDataNn.AsInteger := nn; Inc(nn);
      dxMemData.Post;
      qq.Next;
    end;
    Close;
    qq.Close;
  finally
    Free;
    qq.Free;
  end;
end;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'ASForm2.rtf';
  EkRTF1.Outfile := GetReportsDir + 'НАСФ Форма № 2.rtf';
end;

procedure TdmMain.EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
begin
  if ScanInfo.DataSet = qrASP then
    CalcPosts;
  if ScanInfo.DataSet = qrAsf then begin
    qrASP.Close;
    qrASP.SQL.Text := StringReplace(sqlASP, '%ASF%', qrAsfASF_Id.AsString, [rfReplaceAll]);
    qrASP.Open;
  end;
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

end.

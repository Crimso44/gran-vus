unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ekbasereport;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrOrg: TADOQuery;
    dsOrg: TDataSource;
    qrCont: TADOQuery;
    qrKOPF: TADOQuery;
    qrOKFS: TADOQuery;
    qrPer: TADOQuery;
    qrF6: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function OpenData(nOrgID: Integer): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Форма №18';

implementation

{$R *.DFM}
uses SaveEvents, IniSupport;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'form18.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Форма 18.rtf';
end;

function TdmMain.OpenData(nOrgID: Integer): boolean;
var i: Integer;
begin
  try
    qrOrg.Close;
    qrOrg.Parameters.ParamByName('ID').Value := nOrgID;
    for i:=0 to ComponentCount-1 do
      if Components[i] is TADOQuery then
        if (Components[i] as TADOQuery).Tag<>-1 then
          if not (Components[i] as TADOQuery).Active then
            (Components[i] as TADOQuery).Open;
    Result := true;
  except
    Result := false;
  end;
end;

function TdmMain.PrintData: boolean;
var n: integer;
    s: string;
begin
  try
    EkRTF1.ClearVars;
    EkRTF1.CreateVar('OKBV',qrOrg.FieldByName('OKBV').AsString);
    if not qrOrg.FieldByName('FIRST_DATE').IsNull then
      EkRTF1.CreateVar('FIRST_DATE',qrOrg.FieldByName('FIRST_DATE').AsDateTime,true);
    EkRTF1.CreateVar('OrgName',qrOrg.FieldByName('ORGNAME').AsString);
    if qrCont.Locate('IS_GEN',1,[]) then begin
      EkRTF1.CreateVar('GenName',
        qrCont.FieldByName('FIO').AsString+' '+
        qrCont.FieldByName('PHONE').AsString+' '+
        qrCont.FieldByName('FAX').AsString);
      EkRTF1.CreateVar('GenPost',qrCont.FieldByName('POST').AsString);
      EkRTF1.CreateVar('GenIOFam',
        (qrCont.FieldByName('Im').AsString+' ')[1]+'.'+' '+
        (qrCont.FieldByName('Otch').AsString+' ')[1]+'.'+' '+
        qrCont.FieldByName('Fam').AsString);
    end;
    if qrCont.Locate('IS_VUS',1,[]) then
      EkRTF1.CreateVar('VURName',
        qrCont.FieldByName('FIO').AsString+' '+
        qrCont.FieldByName('PHONE').AsString+' '+
        qrCont.FieldByName('FAX').AsString);
    EkRTF1.CreateVar('RegNum',qrOrg.FieldByName('REGNUM').AsString);
    if not qrOrg.FieldByName('REGDATE').IsNull then
      EkRTF1.CreateVar('RegDate',qrOrg.FieldByName('REGDATE').AsDateTime,true);
    EkRTF1.CreateVar('UrAddr',qrOrg.FieldByName('URADDR').AsString);
    EkRTF1.CreateVar('FizAddr',qrOrg.FieldByName('FIZADDR').AsString);
    EkRTF1.CreateVar('PostAddr',qrOrg.FieldByName('POSTADDR').AsString);
    EkRTF1.CreateVar('ParentOrg',qrOrg.FieldByName('PARENT').AsString);
    EkRTF1.CreateVar('OKPO',qrOrg.FieldByName('OKPO').AsString);
    EkRTF1.CreateVar('OPFName',qrKOPF.FieldByName('KOPF_NAME').AsString);
    EkRTF1.CreateVar('OKOPF',qrKOPF.FieldByName('KOD').AsString);
    EkRTF1.CreateVar('FSName',qrOKFS.FieldByName('FS_NAME').AsString);
    EkRTF1.CreateVar('OKFS',qrOKFS.FieldByName('KOD').AsString);
    EkRTF1.CreateVar('INN',qrOrg.FieldByName('INN').AsString);
    EkRTF1.CreateVar('OKATO',qrOrg.FieldByName('KODREG').AsString);
    if qrOrg.FieldByName('OUT_DATE').IsNull then begin
      EkRTF1.CreateVar('Out_Date','');
      EkRTF1.CreateVar('Out_Reason','');
    end else begin
      EkRTF1.CreateVar('Out_Date','Снята с учета: '+qrOrg.FieldByName('OUT_DATE').AsString);
      EkRTF1.CreateVar('Out_Reason','Основание: '+qrOrg.FieldByName('OUT_REASON').AsString);
    end;

    try
      EkRTF1.CreateVar('OCCUPATION',qrOrg.FieldByName('OCCUPATION').AsString);
    except
    end;
    s := StringReplace(qrOrg.FieldByName('OKONH').AsString,',',', ',[rfReplaceAll]);
    if Pos(qrOrg.FieldByName('MAINOKONH').AsString+',',s) = 1 then begin
      s := Trim(Copy(s, Pos(',', s)+1, MaxInt));
    end;
    EkRTF1.CreateVar('OKONH',s);
    EkRTF1.CreateVar('MAINOKONH',qrOrg.FieldByName('MAINOKONH').AsString);
    EkRTF1.CreateVar('RegPlace',qrOrg.FieldByName('REGPLACE').AsString);
    EkRTF1.CreateVar('Computers',qrOrg.FieldByName('COMPUTERS').AsString);
    EkRTF1.CreateVar('Software',qrOrg.FieldByName('SOFTWARE').AsString);
    EkRTF1.CreateVar('SoftwareNum',qrOrg.FieldByName('SOFTWARENUM').AsString);
    with TADOQuery.Create(Self) do begin
      Connection := dbMain;
      SQL.Text := 'SELECT F6_ID FROM FORM6HDR WHERE ORGID='+
        qrOrg.FieldByName('ORGID').AsString;
      Open;
      if not IsEmpty then begin
        n := Fields[0].AsInteger;
        Close;
        SQL.Text := 'SELECT * FROM FORM6 WHERE F6_ID='+IntToStr(n)+
          ' AND CPROF_ID=1000';
        Open;
        if not IsEmpty then begin
          EkRTF1.CreateVar('Total',FieldByName('COL_1').AsString);
          EkRTF1.CreateVar('TotalW',FieldByName('COL_2').AsString);
          EkRTF1.CreateVar('Total3',FieldByName('COL_3').AsString);
          EkRTF1.CreateVar('Total2',FieldByName('COL_4').AsString);
          EkRTF1.CreateVar('TotalOgr',FieldByName('COL_5').AsString);
          //EkRTF1.CreateVar('TotalFree',FieldByName('COL_9').AsString);
          EkRTF1.CreateVar('TotalNoFree',FieldByName('COL_10').AsString);
          EkRTF1.CreateVar('Total0',FieldByName('COL_11').AsString);
          EkRTF1.CreateVar('TotalBron',FieldByName('COL_6').AsString);
          n := FieldByName('COL_2').AsInteger
              -FieldByName('COL_6').AsInteger;
              //-FieldByName('COL_9').AsInteger;
          if n=0 then s := EmptyStr else s := IntToStr(n);
          EkRTF1.CreateVar('TotalFree',s);
        end;
      end;
      Close;
      EkRTF1.CreateVar('SbmName',qrOrg.FieldByName('SBM').AsString);
      Free;
    end;

    if qrOrg.FieldByName('HAS_BRON').AsBoolean then
      s := 'Да'
    else
      s := 'Нет';
    EkRTF1.CreateVar('HasBron',s);

    s := qrOrg.FieldByName('F6_SHIFR').AsString;
    if (s = '03') or (s = '05') then
      s := 'Да'
    else
      s := 'Нет';
    EkRTF1.CreateVar('Gos',s);

    s := EmptyStr;
    try
      qrPer.Parameters.ParamByName('cur_date').Value := Date;
      qrPer.Parameters.ParamByName('org_id').Value := qrOrg.FieldByName('ORGID').Value;
      try
        qrPer.Open;
      except
        qrPer.Close;
        qrPer.SQL.Text :=
          'select distinct per_no, razd_no'#13+
          'from  PER'#13+
          'where (end_date is null or end_date>:cur_date)';
        qrPer.Parameters.ParseSQL(qrPer.SQL.Text,true);
        qrPer.Parameters.ParamByName('cur_date').Value := Date;
        qrPer.Open;
      end;
      while not qrPer.EOF do begin
        s := s+'ОКВЭД '+qrPer.Fields[0].AsString+' ОКПДТР '+qrPer.Fields[1].AsString+', ';
        qrPer.Next;
      end;
      if Length(s)>0 then SetLength(s,Length(s)-2);
    except
    end;
    EkRTF1.CreateVar('PerList',s);
    EkRTF1.CreateVar('DopInfo',qrOrg.FieldByName('Comment').AsString);
    EkRTF1.CreateVar('showF6',IniSupport.Get6in18);
    qrF6.Parameters[0].Value := qrOrg.FieldByName('ORGID').Value;
    qrF6.Open;
    EkRTF1.ExecuteOpen([qrF6],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(qrOrg.Parameters.ParamByName('ID').Value)]);
  except
    Result := false;
  end;
end;

end.

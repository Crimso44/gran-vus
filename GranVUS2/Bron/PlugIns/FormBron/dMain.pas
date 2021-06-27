unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, Generics.Collections;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrDataBrief: TADOQuery;
    qrDataBriefROW_NO: TIntegerField;
    qrDataBriefORGNAME: TStringField;
    qrDataBriefURADDR: TStringField;
    qrDataBriefDIRECTOR: TStringField;
    ImageList: TImageList;
    qrDataFull: TADOQuery;
    IntegerField1: TIntegerField;
    qrDataBriefKFS: TStringField;
    qrDataFullORGDATA: TStringField;
    qrDataFullMAINOKONH: TStringField;
    qrDataFullKFS_KOD: TStringField;
    qrDataFullKODREG: TStringField;
    qrDataFullRAB_COUNT: TIntegerField;
    qrDataFullZAB_COUNT: TIntegerField;
    qrDataFullZAP_COUNT: TIntegerField;
    qrDataFullSUB_FOGV: TIntegerField;
    qrDataFullSUB_OIVS: TIntegerField;
    qrDataFullSUB_OMSU: TIntegerField;
    qrDataFullSUB_OTHER: TIntegerField;
    qrDataFullTPDP_RAZD: TStringField;
    qrPER: TADOQuery;
    qrDataFullORGID: TAutoIncField;
    qrOSN: TADOQuery;
    qrDataFullBASE_FOGV: TStringField;
    qrDataFullBASE_OIVS: TStringField;
    qrDataFullBASE_OMSU: TStringField;
    qrDataFullBASE_UVVMZ: TStringField;
    qrDataFullBASE_NZVV: TStringField;
    qrDataFullBASE_PDVV: TStringField;
    qrDataFullZAB_PERC: TStringField;
    qrDataBriefMAINOKONH: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataBriefCalcFields(DataSet: TDataSet);
    procedure qrDataFullCalcFields(DataSet: TDataSet);
  private
    FPrinting: Boolean;
  public
    tlPath: string;
    repPath: string;
    calc_summ: Boolean;
    vars: TDictionary<String, Integer>;
    SUM_ZAB_PERC: String;
    procedure PrintData(IsFull: Boolean; FilterType: SmallInt);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Список организаций, ведущих бронирование';

implementation

{$R *.DFM}

uses IniSupport, SaveEvents, msg, StrUtils, Math;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  tlPath := GetTemplatesDir;
  repPath := GetReportsDir;
end;

procedure TdmMain.PrintData(IsFull: Boolean; FilterType: SmallInt);
begin
  try
    EkRTF1.ClearVars;
    with TADOQuery.Create(Self) do try
      Connection := dbMain;
      SQL.Text := 'SELECT SUBJ_FULLNAME FROM SUBJ JOIN CURR_SUBJ ON SUBJ.SUBJ_ID = CURR_SUBJ.SUBJ_ID';
      Open;
      EkRTF1.CreateVar('SUBJ_FULLNAME', FieldByName('SUBJ_FULLNAME').AsString);
    finally
      Free;
    end;

    if IsFull then
      try
        FPrinting:= False;
        EkRTF1.Infile := tlPath + 'formbronfull.rtf';
        EkRTF1.Outfile := repPath + 'Форма по брони полная.rtf';
        vars := TDictionary<String, Integer>.Create();
        vars.Add('SUM_ROW', 0);
        vars.Add('SUM_SUB_FOGV', 0);
        vars.Add('SUM_SUB_OIVS', 0);
        vars.Add('SUM_SUB_OMSU', 0);
        vars.Add('SUM_SUB_OTHER', 0);
        vars.Add('SUM_BASE_FOGV', 0);
        vars.Add('SUM_BASE_OIVS', 0);
        vars.Add('SUM_BASE_OMSU', 0);
        vars.Add('SUM_BASE_UVVMZ', 0);
        vars.Add('SUM_BASE_NZVV', 0);
        vars.Add('SUM_BASE_PDVV', 0);
        vars.Add('SUM_RAB_COUNT', 0);
        vars.Add('SUM_ZAP_COUNT', 0);
        vars.Add('SUM_ZAB_COUNT', 0);
        SUM_ZAB_PERC := '';

        qrDataFull.Close;
        case FilterType of
        1: begin
             qrDataFull.SQL.Add('AND (SELECT KODTERR FROM KTERR WHERE TERR_ID=O.TERR_ID) LIKE ');
             qrDataFull.SQL.Add(
                '(select dbo.GetSubjMask(KTERR.KODTERR)'#13+
                'from CURR_SUBJ'#13+
                'join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID'#13+
                'join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)');
           end;
        2: qrDataFull.SQL.Add('AND O.ORGID IN (SELECT ORGID FROM ORGSET)');
        end;
        qrDataFull.SQL.Add('ORDER BY ORGNAME');
        qrPER.Open;
        qrOSN.Open;
        qrDataFull.Open;
        calc_summ := True;
        FPrinting:= True;
        qrDataFull.First;
        while not qrDataFull.Eof do begin
          qrDataFull.Next;
        end;
        calc_summ := False;
        qrDataFull.First;

        EkRTF1.CreateVar('SUM_ROW', vars['SUM_ROW']);
        EkRTF1.CreateVar('SUM_SUB_FOGV', vars['SUM_SUB_FOGV']);
        EkRTF1.CreateVar('SUM_SUB_OIVS', vars['SUM_SUB_OIVS']);
        EkRTF1.CreateVar('SUM_SUB_OMSU', vars['SUM_SUB_OMSU']);
        EkRTF1.CreateVar('SUM_SUB_OTHER', vars['SUM_SUB_OTHER']);
        EkRTF1.CreateVar('SUM_BASE_FOGV', vars['SUM_BASE_FOGV']);
        EkRTF1.CreateVar('SUM_BASE_OIVS', vars['SUM_BASE_OIVS']);
        EkRTF1.CreateVar('SUM_BASE_OMSU', vars['SUM_BASE_OMSU']);
        EkRTF1.CreateVar('SUM_BASE_UVVMZ', vars['SUM_BASE_UVVMZ']);
        EkRTF1.CreateVar('SUM_BASE_NZVV', vars['SUM_BASE_NZVV']);
        EkRTF1.CreateVar('SUM_BASE_PDVV', vars['SUM_BASE_PDVV']);
        EkRTF1.CreateVar('SUM_RAB_COUNT', vars['SUM_RAB_COUNT']);
        EkRTF1.CreateVar('SUM_ZAP_COUNT', vars['SUM_ZAP_COUNT']);
        EkRTF1.CreateVar('SUM_ZAB_COUNT', vars['SUM_ZAB_COUNT']);
        EkRTF1.CreateVar('SUM_ZAB_PERC', SUM_ZAB_PERC);


        EkRTF1.ExecuteOpen([qrDataFull],SW_SHOWDEFAULT);
        SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,[]);
      finally
        vars.Free;
        FPrinting:= False;
        qrDataFull.Close;
        qrOSN.Close;
        qrPER.Close;
      end
    else //brief
      try
        FPrinting:= False;
        EkRTF1.Infile := tlPath + 'formbronbrief.rtf';
        EkRTF1.Outfile := repPath + 'Форма по брони усеченная.rtf';
        qrDataBrief.Close;
        case FilterType of
        1: begin
             qrDataBrief.SQL.Add('AND (SELECT KODTERR FROM KTERR WHERE TERR_ID=O.TERR_ID) LIKE ');
             qrDataBrief.SQL.Add(
                '(select dbo.GetSubjMask(KTERR.KODTERR)'#13+
                'from CURR_SUBJ'#13+
                'join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID'#13+
                'join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)');
           end;
        2: qrDataBrief.SQL.Add('AND O.ORGID IN (SELECT ORGID FROM ORGSET)');
        end;
        qrDataBrief.SQL.Add('ORDER BY O.ORGNAME');
        qrDataBrief.Open;
        FPrinting:= True;
        EkRTF1.ExecuteOpen([qrDataBrief],SW_SHOWDEFAULT);
        SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,[]);
      finally
        FPrinting:= False;
        qrDataBrief.Close;
      end;
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...');
  end;
end;

procedure TdmMain.qrDataBriefCalcFields(DataSet: TDataSet);
begin
  if not FPrinting then Exit;

  if DataSet.RecNo <= 0 then
    DataSet.FieldByName('ROW_NO').AsInteger:= 1
  else
    DataSet.FieldByName('ROW_NO').AsInteger:= DataSet.RecNo;
end;

procedure TdmMain.qrDataFullCalcFields(DataSet: TDataSet);
//
function ExcludeTrailingSemicolon(S: String): String;
begin
  S := Trim(S);
  if (S<>'') and (S[Length(S)]=';') then  SetLength(S, Length(S)-1);
  Result := S;
end;
//
const FldVar: array [0..5] of record fvFld, fvVar: String end =
  (
  (fvFld:'BASE_FOGV'  ;fvVar:'SUM_BASE_FOGV'),
  (fvFld:'BASE_OIVS'  ;fvVar:'SUM_BASE_OIVS'),
  (fvFld:'BASE_OMSU'  ;fvVar:'SUM_BASE_OMSU'),
  (fvFld:'BASE_UVVMZ' ;fvVar:'SUM_BASE_UVVMZ'),
  (fvFld:'BASE_NZVV'  ;fvVar:'SUM_BASE_NZVV'),
  (fvFld:'BASE_PDVV'  ;fvVar:'SUM_BASE_PDVV')
  );
var FldVarIdx: Integer;
begin
  if not FPrinting then Exit;

  if DataSet.RecNo <= 0
    then DataSet.FieldByName('ROW_NO').AsInteger:= 1
    else DataSet.FieldByName('ROW_NO').AsInteger:= DataSet.RecNo;

  if DataSet.FieldByName('ZAP_COUNT').AsInteger > 0 then
    DataSet.FieldByName('ZAB_PERC').AsString:=
      FormatFloat('(0%)', 100*
        DataSet.FieldByName('ZAB_COUNT').AsInteger /
        DataSet.FieldByName('ZAP_COUNT').AsInteger)
  else
    DataSet.FieldByName('ZAB_PERC').AsString:= '';

  DataSet.FieldByName('TPDP_RAZD').AsString:= '';
  if qrPER.Locate('ORGID', DataSet.FieldByName('ORGID').AsInteger, []) then begin
    while not qrPER.EOF and (DataSet.FieldByName('ORGID').AsInteger = qrPER.FieldByName('ORGID').AsInteger) do begin
      DataSet.FieldByName('TPDP_RAZD').AsString:=
        DataSet.FieldByName('TPDP_RAZD').AsString +
        Trim(qrPER.FieldByName('PER_NO').AsString +
         IfThen(qrPER.FieldByName('RAZD_NO').AsString<>'', ', '+qrPER.FieldByName('RAZD_NO').AsString+' ',' ') +
         qrPER.FieldByName('DOC_NAME').AsString + ' ' +
         qrPER.FieldByName('DOC_NO').AsString) + '; ';
      qrPER.Next;
    end;
  end;
  DataSet.FieldByName('TPDP_RAZD').AsString := ExcludeTrailingSemicolon(DataSet.FieldByName('TPDP_RAZD').AsString);
  for FldVarIdx := 0 to 5 do with FldVar[FldVarIdx] do DataSet.FieldByName(fvFld).AsString:= '';

  if qrOSN.Locate('ORGID', DataSet.FieldByName('ORGID').AsInteger, []) then begin
    while not qrOSN.EOF and (DataSet.FieldByName('ORGID').AsInteger = qrOSN.FieldByName('ORGID').AsInteger) do begin
      FldVarIdx := Min(AnsiIndexStr(qrOSN.FieldByName('BASE_KOD').AsString,
        ['01','02','03','04','05','06','07','08','09','10','11']),5);
      if FldvarIdx>=0 then with FldVar[FldVarIdx] do begin
        DataSet.FieldByName(fvFld).AsString:= DataSet.FieldByName(fvFld).AsString + '№'+
          qrOSN.FieldByName('DOC_NO').AsString + ' от ' +
          qrOSN.FieldByName('DOC_DATE').AsString + '; ';
        if calc_summ then
          vars[fvVar] := vars[fvVar] + 1;
      end;
      qrOSN.Next;
    end;
  end;
  for FldVarIdx := 0 to 5 do with FldVar[FldVarIdx] do
    DataSet.FieldByName(fvFld).AsString := ExcludeTrailingSemicolon(DataSet.FieldByName(fvFld).AsString);

  if calc_summ then begin
    vars['SUM_ROW'] := vars['SUM_ROW'] + 1;
    vars['SUM_SUB_FOGV'] := vars['SUM_SUB_FOGV'] + DataSet.FieldByName('SUB_FOGV').AsInteger;
    vars['SUM_SUB_OIVS'] := vars['SUM_SUB_OIVS'] + DataSet.FieldByName('SUB_OIVS').AsInteger;
    vars['SUM_SUB_OMSU'] := vars['SUM_SUB_OMSU'] + DataSet.FieldByName('SUB_OMSU').AsInteger;
    vars['SUM_SUB_OTHER'] := vars['SUM_SUB_OTHER'] + DataSet.FieldByName('SUB_OTHER').AsInteger;
    vars['SUM_RAB_COUNT'] := vars['SUM_RAB_COUNT'] + DataSet.FieldByName('RAB_COUNT').AsInteger;
    vars['SUM_ZAP_COUNT'] := vars['SUM_ZAP_COUNT'] + DataSet.FieldByName('ZAP_COUNT').AsInteger;
    vars['SUM_ZAB_COUNT'] := vars['SUM_ZAB_COUNT'] + DataSet.FieldByName('ZAB_COUNT').AsInteger;

    if vars['SUM_ZAP_COUNT'] > 0 then
      SUM_ZAB_PERC :=
        FormatFloat('(0%)', 100*
          vars['SUM_ZAB_COUNT'] /
          vars['SUM_ZAP_COUNT'])
    else
      SUM_ZAB_PERC := '';
  end;

end;

end.


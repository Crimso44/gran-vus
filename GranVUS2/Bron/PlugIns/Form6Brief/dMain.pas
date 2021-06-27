unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport;

type
  TFilter = record fShifr, fFilter, fSort, fDesc: Byte; end;

  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrData: TADOQuery;
    qrDataROW_NO: TIntegerField;
    qrDataOKPO: TStringField;
    qrDataOKBV: TStringField;
    qrDataNUM_WORK: TIntegerField;
    qrDataNUM_VOEN: TIntegerField;
    qrDataNUM_OFFIC: TIntegerField;
    qrDataNUM_PRIZ: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataCalcFields(DataSet: TDataSet);
  private
    FPrinting: Boolean;
  public
    procedure PrintData(AFilter: TFilter);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Численный состав работников организаций';

implementation

{$R *.DFM}

uses IniSupport, SaveEvents, msg;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile  := GetTemplatesDir + 'form6brief.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Усеченная Форма 6.rtf';
end;

procedure TdmMain.PrintData(AFilter: TFilter);
const
  SortField: array [0..5] of String = ('OKPO','OKBV','NUM_WORK','NUM_VOEN','NUM_OFFIC','NUM_PRIZ');
  Desc: array [0..1] of String = ('',' DESC');
  Filter: array [0..2] of String = (
    'по всем организациям картотеки',
    'по организациям, подотчётным ',
    'по заданному набору');
  Shifr: array [0..5] of String = ('01','02','03','04','05','06');
  ShifrText: array [0..5] of String = ('01, 02, 03, 04, 05, 06','02, 03','03','04, 05, 06','05','06');
var
  SUBJ_NAME: String;
begin
  with AFilter do
  try
    try
      FPrinting:= False;
      EkRTF1.ClearVars;
      EkRTF1.CreateVar('SUM_ROW', Integer(0));
      EkRTF1.CreateVar('SUM_NUM_WORK', Integer(0));
      EkRTF1.CreateVar('SUM_NUM_VOEN', Integer(0));
      EkRTF1.CreateVar('SUM_NUM_OFFIC', Integer(0));
      EkRTF1.CreateVar('SUM_NUM_PRIZ', Integer(0));
      if fFilter = 1 then with TADOQuery.Create(nil) do
      try
        Connection := dbMain;
        ParamCheck := False;
        SQL.Text := 'SELECT s.SUBJ_FULLNAME FROM SUBJ s, CURR_SUBJ cs WHERE s.SUBJ_ID=cs.SUBJ_ID';
        Open;
        SUBJ_NAME := Fields[0].AsString;
      finally Free;
      end
      else
        SUBJ_NAME := '';
      EkRTF1.CreateVar('CAPTION', Format('Численный состав работников организаций %s%s с шифром формы №6 %s.',
        [Filter[fFilter], SUBJ_NAME, ShifrText[fShifr]]));
      with qrData do begin
        Close;
        SQL.Clear;
        SQL.Text:= 'SELECT O.OKPO, O.OKBV, F.COL_1 AS NUM_WORK, F.COL_2 AS NUM_VOEN, F.COL_3 AS NUM_OFFIC, F.COL_11 AS NUM_PRIZ'#10+
                   'FROM v_ORG_'+Shifr[fShifr]+' O LEFT JOIN FORM6HDR H JOIN FORM6 F on F.F6_ID = H.F6_ID and F.CPROF_ID = 1000 on O.ORGID = H.ORGID';
        case fFilter of
          1: begin
               SQL.Add('WHERE (SELECT KODTERR FROM KTERR WHERE TERR_ID=O.TERR_ID) LIKE ');
               SQL.Add(
                  '(select dbo.GetSubjMask(KTERR.KODTERR)'#13+
                  'from CURR_SUBJ'#13+
                  'join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID'#13+
                  'join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)');
             end;
          2: SQL.Add('WHERE O.ORGID in (SELECT ORGID FROM ORGSET)');
        end;
        SQL.Add('ORDER BY '+SortField[fSort]+Desc[fDesc]);
        Open;
      end;
      FPrinting:= True;
      EkRTF1.ExecuteOpen([qrData],SW_SHOWDEFAULT);
      FPrinting:= False;
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject, []);
    finally
      qrData.Close;
    end;
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...');
  end;
end;

procedure TdmMain.qrDataCalcFields(DataSet: TDataSet);
begin
  if not FPrinting then Exit;

  if DataSet.RecNo <= 0 then
    DataSet.FieldByName('ROW_NO').AsInteger:= 1
  else
    DataSet.FieldByName('ROW_NO').AsInteger:= DataSet.RecNo;

  EkRTF1.VarByName('SUM_ROW').AsInteger:= EkRTF1.VarByName('SUM_ROW').AsInteger + 1;
  EkRTF1.VarByName('SUM_NUM_WORK').AsInteger:= EkRTF1.VarByName('SUM_NUM_WORK').AsInteger + DataSet.FieldByName('NUM_WORK').AsInteger;
  EkRTF1.VarByName('SUM_NUM_VOEN').AsInteger:= EkRTF1.VarByName('SUM_NUM_VOEN').AsInteger + DataSet.FieldByName('NUM_VOEN').AsInteger;
  EkRTF1.VarByName('SUM_NUM_OFFIC').AsInteger:= EkRTF1.VarByName('SUM_NUM_OFFIC').AsInteger + DataSet.FieldByName('NUM_OFFIC').AsInteger;
  EkRTF1.VarByName('SUM_NUM_PRIZ').AsInteger:= EkRTF1.VarByName('SUM_NUM_PRIZ').AsInteger + DataSet.FieldByName('NUM_PRIZ').AsInteger;

end;


end.

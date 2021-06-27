unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrData: TADOQuery;
    qrDataROW_NO: TIntegerField;
    qrDataORGNAME: TStringField;
    qrDataPHONE: TStringField;
    qrDataURADDR: TStringField;
    qrDataDIRECTOR: TStringField;
    qrDataVUS: TStringField;
    ImageList: TImageList;
    qrDataINN: TStringField;
    qrDataQTY: TIntegerField;
    qrDataFIZADDR: TStringField;
    qrDataPOSTADDR: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataCalcFields(DataSet: TDataSet);
  private
  public
    procedure PrintData;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Общие списки организаций';

implementation

{$R *.DFM}
uses IniSupport, SaveEvents, msg, fFilDlg;

procedure TdmMain.DataModuleCreate(Sender: TObject);

begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'formokbv.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Форма ОКБВ.rtf';
end;

procedure TdmMain.PrintData;
const
  Filter: array [0..2] of String = (
    'по всей картотеке',
    'подотчётных ',
    'по заданному набору');
  Shifr: array [0..5] of String = ('01','02','03','04','05','06');
  ShifrText: array [0..5] of String = ('01, 02, 03, 04, 05, 06','02, 03','03','04, 05, 06','05','06');
var
  AShifr,AFilter: Byte;
  SUBJ_FULLNAME: String;
begin
  AShifr  := 0;
  AFilter := 1;
  if ShowFltDlg(AShifr,AFilter) then
  try
    if AFilter = 1 then
    with TADOQuery.Create(Self) do try
      Connection := dbMain;
      SQL.Text := 'SELECT SUBJ_FULLNAME FROM SUBJ JOIN CURR_SUBJ ON SUBJ.SUBJ_ID = CURR_SUBJ.SUBJ_ID';
      Open;
      SUBJ_FULLNAME := Fields[0].AsString;
    finally
      Free;
    end
    else
      SUBJ_FULLNAME := '';
    EkRTF1.ClearVars;
    try
      with qrData do begin
        Close;
        SQL.Clear;
        SQL.Text:= 'SELECT *,'#10+
          '(select top 1 ISNULL(FIO,'''') + CHAR(13) + ISNULL(PHONE,'''') from ORG_CONT where ORGID = O.ORGID and IS_GEN = 1) AS DIRECTOR,'#13+
          '(select top 1 ISNULL(FIO,'''') + CHAR(13) + ISNULL(PHONE,'''') from ORG_CONT where ORGID = O.ORGID and IS_VUS = 1) AS VUS,'#13+
          'f6.qty as QTY'#13+
          'FROM v_ORG_'+Shifr[AShifr]+' O left outer join'#13+
          '(select col_1 as QTY, h.ORGID as f6orgid from form6hdr h join form6 f on f.f6_id=h.f6_id and f.col_b=5) f6'#13+
          'on O.ORGID = f6.f6orgid';
        case AFilter of
          1: begin
               SQL.Add('WHERE (SELECT KODTERR FROM KTERR WHERE TERR_ID=O.TERR_ID) LIKE ');
               SQL.Add(
                  '(select dbo.GetSubjMask(KTERR.KODTERR)'#13+
                  'from CURR_SUBJ'#13+
                  'join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID'#13+
                  'join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)');
             end;
          2: SQL.Add('WHERE O.ORGID IN (SELECT ORGID FROM ORGSET)');
        end;
        SQL.Add('ORDER BY O.ORGNAME');
        Open;
      end;
      EkRTF1.CreateVar('CAPTION', Format('Перечень организаций %s%s с шифром формы №6 %s.',
        [Filter[AFilter], SUBJ_FULLNAME, ShifrText[AShifr]]));
      EkRTF1.ExecuteOpen([qrData],SW_SHOWDEFAULT);
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,[]);
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
  if DataSet.RecNo <= 0 then
    DataSet.FieldByName('ROW_NO').AsInteger:= 1
  else
    DataSet.FieldByName('ROW_NO').AsInteger:= DataSet.RecNo;
end;

end.

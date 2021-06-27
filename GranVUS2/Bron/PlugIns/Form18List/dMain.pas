unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    ImageList: TImageList;
    qrData: TADOQuery;
    qrDataFIRST_DATE: TDateTimeField;
    qrDataORGDATA: TStringField;
    qrDataHAS_BRON: TIntegerField;
    qrDataHAS_REG: TIntegerField;
    qrDataCOMMENT: TStringField;
    qrDataROW_NO: TIntegerField;
    qrDataOKBV: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataCalcFields(DataSet: TDataSet);
  private
    FPrinting: Boolean;
  public
    tlPath: string;
    repPath: string;
    procedure PrintData(FilterType: SmallInt);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Журнал форм № 18';

implementation

uses SaveEvents, Msg, IniSupport;

{$R *.DFM}

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  tlPath := GetTemplatesDir;
  repPath := GetReportsDir;
end;

procedure TdmMain.PrintData(FilterType: SmallInt);
begin
  try
    EkRTF1.Infile := tlPath + 'form18list.rtf';
    EkRTF1.Outfile := repPath + 'Журнал форм 18.rtf';

    EkRTF1.ClearVars;

    with TADOQuery.Create(Self) do try
      Connection := dbMain;
      SQL.Text := 'SELECT SUBJ_FULLNAME FROM SUBJ JOIN CURR_SUBJ ON SUBJ.SUBJ_ID = CURR_SUBJ.SUBJ_ID';
      Open;
      EkRTF1.CreateVar('SUBJ_FULLNAME', FieldByName('SUBJ_FULLNAME').AsString);
    finally
      Free;
    end;

    try
      FPrinting:= False;
      EkRTF1.CreateVar('SUM_ROW', Integer(0));
      EkRTF1.CreateVar('SUM_HAS_REG', Integer(0));
      EkRTF1.CreateVar('SUM_HAS_BRON', Integer(0));
      qrData.Close;
      case FilterType of
        1: begin
             qrData.SQL.Add('AND (SELECT KODTERR FROM KTERR WHERE TERR_ID=O.TERR_ID) LIKE ');
             qrData.SQL.Add(
                '(select dbo.GetSubjMask(KTERR.KODTERR)'#13+
                'from CURR_SUBJ'#13+
                'join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID'#13+
                'join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)');
           end;
        2: qrData.SQL.Add('AND O.ORGID in (select ORGID from ORGSET)');
      end;
      qrData.SQL.Add('ORDER BY OKBV, FIRST_DATE, ORGNAME');
      qrData.Open;
      FPrinting:= True;
      EkRTF1.ExecuteOpen([qrData],SW_SHOWDEFAULT);
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject, []);
    finally
      FPrinting:= False;
      qrData.Close;
    end
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
  EkRTF1.VarByName('SUM_HAS_BRON').AsInteger:= EkRTF1.VarByName('SUM_HAS_BRON').AsInteger + DataSet.FieldByName('HAS_BRON').AsInteger;
  EkRTF1.VarByName('SUM_HAS_REG').AsInteger:= EkRTF1.VarByName('SUM_HAS_REG').AsInteger + DataSet.FieldByName('HAS_REG').AsInteger;
end;

end.


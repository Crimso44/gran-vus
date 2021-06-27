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
    qrDataROW_NO: TIntegerField;
    qrDataORGDATA: TStringField;
    qrDataSUBMISSION: TStringField;
    qrDataRAB_COUNT: TIntegerField;
    qrDataZAP_COUNT: TIntegerField;
    qrDataZAB_COUNT: TIntegerField;
    qrDataCOMMENT: TStringField;
    qrPER: TADOQuery;
    qrDataRAZD_BRON: TStringField;
    qrDataORGID: TAutoIncField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataBriefCalcFields(DataSet: TDataSet);
  private
    FPrinting: Boolean;
  public
    tlPath: string;
    repPath: string;
    procedure PrintData(FilterType: SmallInt; PerNumb: string);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Список организаций, прикреплённых к перечню бронирования';

implementation

{$R *.DFM}

uses IniSupport, SaveEvents, msg;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  tlPath := GetTemplatesDir;
  repPath := GetReportsDir;
end;

procedure TdmMain.PrintData(FilterType: SmallInt; PerNumb: string);
begin
  try
    EkRTF1.Infile := tlPath + 'form77Tlist.rtf';
    EkRTF1.Outfile := repPath + 'Список организаций по перечню бронирования.rtf';

    EkRTF1.ClearVars;

    with TADOQuery.Create(Self) do try
      Connection := dbMain;
      SQL.Text := 'SELECT SUBJ_FULLNAME FROM SUBJ JOIN CURR_SUBJ ON SUBJ.SUBJ_ID = CURR_SUBJ.SUBJ_ID';
      Open;
      EkRTF1.CreateVar('SUBJ_FULLNAME', FieldByName('SUBJ_FULLNAME').AsString);
    finally
      Free;
    end;
    EkRTF1.CreateVar('PER_NUMB',PerNumb);

    try
      FPrinting:= False;
      EkRTF1.CreateVar('CURRDATE', DateToStr(Date));
      EkRTF1.CreateVar('SUM_ROW', Integer(0));
      EkRTF1.CreateVar('SUM_RAB_COUNT', Integer(0));
      EkRTF1.CreateVar('SUM_ZAP_COUNT', Integer(0));
      EkRTF1.CreateVar('SUM_ZAB_COUNT', Integer(0));
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
      2: qrData.SQL.Add('AND O.ORGID IN (SELECT ORGID FROM ORGSET)');
      end;
      qrData.SQL.Add('ORDER BY O.ORGNAME');
      qrData.Parameters.ParamByName('PER_MASK').Value := PerNumb+'%';
      qrPER.Open;
      qrData.Open;
      FPrinting:= True;
      EkRTF1.ExecuteOpen([qrData],SW_SHOWDEFAULT);
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,[]);
    finally
      FPrinting:= False;
      qrData.Close;
      qrPER.Close;
    end
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...');
  end;
end;

procedure TdmMain.qrDataBriefCalcFields(DataSet: TDataSet);
var s: string;
begin
  if not FPrinting then Exit;

  if DataSet.RecNo <= 0 then
    DataSet.FieldByName('ROW_NO').AsInteger:= 1
  else
    DataSet.FieldByName('ROW_NO').AsInteger:= DataSet.RecNo;

  DataSet.FieldByName('RAZD_BRON').AsString:= '';
  if qrPER.Locate('ORGID', DataSet.FieldByName('ORGID').AsInteger, []) then begin
    while not qrPER.EOF and (DataSet.FieldByName('ORGID').AsInteger = qrPER.FieldByName('ORGID').AsInteger) do begin
      s:= qrPER.FieldByName('RAZD_NO').AsString + '; ';
      DataSet.FieldByName('RAZD_BRON').AsString:=
        DataSet.FieldByName('RAZD_BRON').AsString + s;
      qrPER.Next;
    end;
  end;

  EkRTF1.VarByName('SUM_ROW').AsInteger:= EkRTF1.VarByName('SUM_ROW').AsInteger + 1;
  EkRTF1.VarByName('SUM_RAB_COUNT').AsInteger:= EkRTF1.VarByName('SUM_RAB_COUNT').AsInteger + DataSet.FieldByName('RAB_COUNT').AsInteger;
  EkRTF1.VarByName('SUM_ZAP_COUNT').AsInteger:= EkRTF1.VarByName('SUM_ZAP_COUNT').AsInteger + DataSet.FieldByName('ZAP_COUNT').AsInteger;
  EkRTF1.VarByName('SUM_ZAB_COUNT').AsInteger:= EkRTF1.VarByName('SUM_ZAB_COUNT').AsInteger + DataSet.FieldByName('ZAB_COUNT').AsInteger;
end;

end.


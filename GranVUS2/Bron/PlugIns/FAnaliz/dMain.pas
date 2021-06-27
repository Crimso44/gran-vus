unit dMain;

interface

uses
  DateUtils,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, OleServer, dxTL, Variants, Excel2000, dxDBGrid, dxGrClms,
  ExcelXP;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    ilSmall: TImageList;
    ExcelApplication: TExcelApplication;
    qrData: TADOQuery;
    qrDataPRINT_NAME: TStringField;
    qrDataSUBJ_ID: TIntegerField;
    qrDataNUM: TIntegerField;
    qrDataN01: TIntegerField;
    qrDataN02: TIntegerField;
    qrDataN10: TIntegerField;
    qrDataN12: TIntegerField;
    qrDataN01_10: TIntegerField;
    qrDataN01_10_12: TIntegerField;
    qrDataPerc: TStringField;
    qrDataN06: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataCalcFields(DataSet: TDataSet);
  private
    FPrinting: Boolean;
    procedure FieldGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  public
    rPrint: Boolean;//User's rights
    tlPath: string;
    repPath: string;
    procedure PrintData(ID:Integer);
    procedure GridToExcel(Grid: TdxDBGrid; ACaption: string ='';
      PrintBands: boolean=false; PrintHeaders: boolean=true);
  end;

var
  dmMain: TdmMain;
  FPrintOnly: Boolean;

const
  sEventObject = 'Форма № 19';

implementation

{$R *.DFM}

uses IniSupport, msg, SaveEvents, StrUtils, ShellAPI;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  tlPath := GetTemplatesDir;
  repPath := GetReportsDir;
end;

procedure TdmMain.PrintData(ID: Integer);
//
  function GetReportDate: String;
  var
    y: Integer;
    AfterNY: Boolean;
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select * from curr_subj';
      Open;
      if Fields[0].AsInteger = ID
        then AfterNY := GetMainVUOAfterNY
        else AfterNY := GetVUOAfterNY;
      Close;
      SQL.Text := 'SELECT REPORT_DATE FROM SUBJ WHERE SUBJ_ID='+IntToStr(ID);
      Open;
      Y := YearOf(Fields[0].AsDateTime);
      if Fields[0].IsNull
        then Result := ''
        else Result := IntToStr(Y-Byte(AfterNY));
    finally Free;
    end;
  end;
//
  type TPerson = record Post, FIO: String end;
  function GetPerson: TPerson;
  var I,O: Integer;
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT POSITION_NAME, FIO FROM SUBJ_INFO WHERE SUBJ_INFO_ID = 4 and SUBJ_ID='+IntToStr(ID);
      Open;
      with Result do begin
        POST := Fields[0].AsString;
        FIO := Fields[1].AsString;
        I := Pos(' ',FIO);
        if I>0 then O := PosEx(' ',FIO,I+1) else O := 0;
        if (O>0) and (O<Length(FIO)) then
          FIO := LeftStr(FIO, I+1)+'.'+FIO[O+1]+'.';
      end;
    finally Free;
    end;
  end;
//
begin
  EkRTF1.Infile := tlPath + 'Analiz.rtf';
  EkRTF1.Outfile := repPath + 'Форма № 19.rtf';

  try
    try
      EkRTF1.ClearVars;

      dmMain.EkRTF1.CreateVar('REPORT_DATE', GetReportDate);
      dmMain.EkRTF1.CreateVar('Year', GetReportDate);
      dmMain.EkRTF1.CreateVar('CurDate',SysUtils.FormatDateTime('dd.mm.yyyy', Date));
      with GetPerson do begin
        dmMain.EkRTF1.CreateVar('GenPOST', POST);
        dmMain.EkRTF1.CreateVar('GenIOFam', FIO);
      end;
      with TADOQuery.Create(Self) do
      try
        Connection := dmMain.dbMain;
        SQL.Text := 'SELECT * '+
          'FROM FAnaliz f '+
          'WHERE f.Subj_ID = '+IntToStr(ID)+' and f.Num = 1000 ';
        Open;
        if FieldByName('N12').AsInteger = 0 then
          dmMain.EkRTF1.CreateVar('Perc',0)
        else
          dmMain.EkRTF1.CreateVar('Perc',Round(100*
            (1.0*(FieldByName('N01').AsInteger - FieldByName('N10').AsInteger)) /
              FieldByName('N12').AsInteger));
        SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ'#10 +
                    'WHERE SUBJ_ID = ' + IntToStr(ID);
        Open;
        EkRTF1.CreateVar('SUBJ_NAME', FieldByName('SUBJ_NAME').AsString);
      finally
        Free;
      end;
      qrData.Parameters.ParamByName('SUBJ_ID').Value := ID;
      qrData.Open;
      EkRTF1.ExecuteOpen([qrData],SW_SHOWDEFAULT);
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,
        ['Номер организации: '+IntToStr(ID)]);
    finally
      FPrinting:= False;
      qrData.Close;
    end
  except on e: Exception do begin
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'#13+
      'Возможно неверно указаны рабочие папки '#13+
      'или шаблон отчета используется другой программой...'#13+E.Message);
  end;
  end;
end;

procedure TdmMain.qrDataCalcFields(DataSet: TDataSet);
begin
  qrDataN01_10.AsInteger := qrDataN01.AsInteger - qrDataN10.AsInteger;
  qrDataN01_10_12.AsInteger := qrDataN01.AsInteger - qrDataN10.AsInteger - qrDataN12.AsInteger;

    if qrDataN12.AsInteger = 0 then
      qrDataPerc.AsString := '0'
    else
      qrDataPerc.AsString := FloatToStr(Round(100*
        (1.0*(qrDataN01.AsInteger - qrDataN10.AsInteger)) /
          qrDataN12.AsInteger));

end;

procedure TdmMain.FieldGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
const True2X : array [Boolean] of String = (' ','X');
begin
  Text := Sender.AsString;
  Text := True2X[SameText(Text,'true')];
end;

procedure TdmMain.GridToExcel(Grid: TdxDBGrid; ACaption: string =''; PrintBands: boolean=false; PrintHeaders: boolean=true);
var
  FName : String;
  I     : Integer;
begin
  if not dmMain.rPrint then begin
    ShowErr('Вы не обладаете правом на печать документов. '+
            'За разъяснениями вы можете обратиться к администратору системы.');
    Exit;
  end;
  if ACaption=''
    then FName := 'Отчёт в Excel.XLS'
    else FName := ACaption+'.XLS';
  for I := 1 to Length(FName) do if FName[I] in ['\','/',':','*','?','"','<','>','|']
  then FName[I] := '_';
  FName := GetReportsDir+FName;
  try
    for I := 0 to Grid.ColumnCount-1 do
    if Grid.Columns[I] is TdxDBGridCheckColumn then
    with Grid.Columns[I] do begin
      Field.OnGetText := FieldGetText;
      Alignment := taCenter;
    end;

    Grid.OptionsDB := Grid.OptionsDB+[edgoLoadAllRecords]; 
    Grid.SaveToXLS(FName, True);

    for I := 0 to Grid.ColumnCount-1 do
    if Grid.Columns[I] is TdxDBGridCheckColumn then
      Grid.Columns[I].Field.OnGetText := nil;

    ShellExecute(0,'open',PChar(FName),nil,nil,SW_SHOWMAXIMIZED);
    SaveEvent(dbMain, evs_Report_Print, ACaption,[]);
  except
    SaveEvent(dbMain, evs_Report_Error, ACaption,[]);
    raise;
  end;
end;

end.


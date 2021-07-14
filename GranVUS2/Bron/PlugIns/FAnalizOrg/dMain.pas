unit dMain;

interface

uses
  DateUtils,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, OleServer, dxTL, Variants, Excel2000, dxDBGrid, dxGrClms,
  ExcelXP, ekfunc;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    ilSmall: TImageList;
    ExcelApplication: TExcelApplication;
    qrData: TADOQuery;
    qrDataPRINT_NAME: TStringField;
    qrDataNUM: TIntegerField;
    qrDataN01: TIntegerField;
    qrDataN02: TIntegerField;
    qrDataN10: TIntegerField;
    qrDataN12: TIntegerField;
    qrDataN01_10: TIntegerField;
    qrDataN01_10_12: TIntegerField;
    qrDataPerc: TStringField;
    qrDataN06: TIntegerField;
    qrDataGr5: TStringField;
    EkUDFList1: TEkUDFList;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataCalcFields(DataSet: TDataSet);
    procedure EkUDFList1Functions0Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
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
  sEventObject = 'Форма № 19 организации';

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
begin
  EkRTF1.Infile := tlPath + 'Analiz.rtf';
  EkRTF1.Outfile := repPath + 'Форма № 19 организации.rtf';

  try
    try
      EkRTF1.ClearVars;

      dmMain.EkRTF1.CreateVar('REPORT_DATE', GetReportDate);
      dmMain.EkRTF1.CreateVar('Year', GetReportDate);
      dmMain.EkRTF1.CreateVar('CurDate',SysUtils.FormatDateTime('dd.mm.yyyy', Date));
      dmMain.EkRTF1.CreateVar('GenPOST', '');
      dmMain.EkRTF1.CreateVar('GenIOFam', '');
      with TADOQuery.Create(Self) do
      try
        Connection := dmMain.dbMain;
        SQL.Text := 'SELECT OrgName '+
          'FROM Org '+
          'WHERE ORGID = '+IntToStr(ID);
        Open;
        EkRTF1.CreateVar('SUBJ_NAME', FieldByName('OrgName').AsString);
      finally
        Free;
      end;
      qrData.Parameters.ParamByName('ORG_ID').Value := ID;
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
    else if (qrDataN01.AsInteger - qrDataN10.AsInteger) > qrDataN12.AsInteger then
      qrDataPerc.AsString := '100'
    else
      qrDataPerc.AsString := FloatToStr(Round(100*
        (1.0*(qrDataN01.AsInteger - qrDataN10.AsInteger)) /
          qrDataN12.AsInteger));

    if qrDataN02.AsInteger = 0 then
      qrDataGr5.AsString := '0'
    else
      qrDataGr5.AsString := FloatToStr(Round(100*
        (1.0*qrDataN06.AsInteger) / qrDataN02.AsInteger));


end;

procedure TdmMain.EkUDFList1Functions0Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
  function GetString(O: TObject): String;
  begin
    if O is TField then Result := TField(O).AsString else Result := TEkReportVariable(O).AsString;
  end;
var
  i: Integer;
begin
  (UDFResult as TEkReportVariable).AsBoolean := False;
  for i:=1 to ArgCount-1 do
    if GetString(Args[0])=GetString(Args[i]) then
    begin
      (UDFResult as TEkReportVariable).AsBoolean := True;
      Exit;
    end;
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


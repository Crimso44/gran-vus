unit dMain;

interface

uses
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
    procedure DataModuleCreate(Sender: TObject);
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
  sEventObject = 'Сведения об использовании СВТ и СПО';

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
begin
  EkRTF1.Infile := tlPath + 'FormSVT.rtf';
  EkRTF1.Outfile := repPath + 'Сведения об использовании СВТ и СПО.rtf';

  try
    try
      EkRTF1.ClearVars;

      with TADOQuery.Create(Self) do try
        Connection := dbMain;
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
  except
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'#13+
      'Возможно неверно указаны рабочие папки '#13+
      'или шаблон отчета используется другой программой...');
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


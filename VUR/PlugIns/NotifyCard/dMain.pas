unit dMain;

interface

uses
  DateUtils,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EkRtf, Db, ADODB, ekbasereport;

type
  TdmMain = class(TDataModule)
    EkRTF1: TEkRTF;
    dbMain: TADOConnection;
    qrPers: TADOQuery;
    dsPers: TDataSource;
    qrWRng: TADOQuery;
    qrOVK: TADOQuery;
    qrDep: TADOQuery;
    qrOrg: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function OpenData(ID: Integer): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Карточка оповещения';

implementation

{$R *.DFM}

uses SaveEvents, IniSupport;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'notcard.rtf';
  EkRTF1.Outfile := GetReportsDir + 'notcard.rtf';
end;

function TdmMain.OpenData(ID: Integer): boolean;
var i: Integer;
  IsJet: Boolean;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  try
    qrPers.Close;
    qrPers.Parameters.ParamByName('ID').Value := ID;
    qrPers.Open;
    for i:=0 to ComponentCount-1 do
      if Components[i] is TADOQuery then
        if not (Components[i] as TADOQuery).Active then begin
          if not IsJet then
            (Components[i] as TADOQuery).SQL.Text :=
              StringReplace((Components[i] as TADOQuery).SQL.Text,
                '(kovk.IsOVK', '(kovk.IsOVK = 1', [rfReplaceAll]);
          (Components[i] as TADOQuery).Open;
        end;
    Result := true;
  except
    Result := false;
  end;
end;

function TdmMain.PrintData: boolean;
var
  d: TDateTime;
begin
  try
    EkRTF1.OutFile := ExtractFilePath(EkRTF1.OutFile)+'\Карточка оповещения для '+
      qrPers.FieldByName('Fam').AsString+' '+
      qrPers.FieldByName('Im').AsString+' '+
      qrPers.FieldByName('Otch').AsString+'.rtf';
    d := Date;
    EkRTF1.CreateVar('CurDate', IntToStr(DayOfTheMonth(d))+'.'+IntToStr(MonthOfTheYear(d))+'.'+IntToStr(YearOf(d)));
    EkRTF1.ExecuteOpen([qrPers,qrOVK,qrDep,qrWRng,qrOrg],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер сотрудника: '+IntToStr(qrPers.Parameters.ParamByName('ID').Value)]);
  except
    Result := false;
  end;
end;


end.

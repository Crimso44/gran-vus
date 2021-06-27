unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ekbasereport, DateUtils;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrData: TADOQuery;
    qrDataVUO: TStringField;
    qrDataQTY: TIntegerField;
    qrDataZAP: TIntegerField;
    qrDataZAB: TIntegerField;
    qrDataPRZ: TIntegerField;
    qrDataMOB: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    OrgId: Integer;
  public
    { Public declarations }
    function OpenData(nOrgID: Integer): boolean;
    function PrintData: boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Сводные показатели ВУО';

implementation

{$R *.DFM}
uses SaveEvents, IniSupport;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'svod.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Сводные показатели ВУО.rtf';
end;

function TdmMain.OpenData(nOrgID: Integer): boolean;
var i: Integer;
begin
  OrgId := nOrgId;
  try
    qrData.Close;
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
var
  d: TDateTime;

  function GetMonth(n: Integer): String;
  begin
    case n of
      1: Result := 'января';
      2: Result := 'февраля';
      3: Result := 'марта';
      4: Result := 'апреля';
      5: Result := 'мая';
      6: Result := 'июня';
      7: Result := 'июля';
      8: Result := 'августа';
      9: Result := 'сентября';
      10: Result := 'октября';
      11: Result := 'ноября';
      12: Result := 'декабря';
    end;
  end;

begin
  try
    EkRTF1.ClearVars;
    d := Date;
    EkRTF1.CreateVar('CurDate', IntToStr(DayOf(d))+' '+GetMonth(MonthOf(d))+' '+IntToStr(YearOf(d))+' г.');
    EkRTF1.ExecuteOpen([qrData],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(OrgId)]);
  except
    Result := false;
  end;
end;

end.

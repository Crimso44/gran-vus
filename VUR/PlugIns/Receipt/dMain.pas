unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EkRtf, Db, ADODB, ekbasereport;

type
  TdmMain = class(TDataModule)
    EkRTF1: TEkRTF;
    dbMain: TADOConnection;
    qrPers: TADOQuery;
    qrVUR: TADOQuery;
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
  sEventObject = 'Расписка в получении документа';

implementation

{$R *.DFM}

uses SaveEvents, IniSupport;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'Receipt.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Receipt.rtf';
end;

function TdmMain.OpenData(ID: Integer): boolean;
var i: Integer;
begin
  try
    qrPers.Close;
    qrPers.Parameters.ParamByName('ID').Value := ID;
    qrPers.Open;
    for i:=0 to ComponentCount-1 do
      if Components[i] is TADOQuery then
        if not (Components[i] as TADOQuery).Active then
          (Components[i] as TADOQuery).Open;
    Result := true;
  except
    Result := false;
  end;
end;

function TdmMain.PrintData: boolean;
begin
  try
    EkRTF1.OutFile := ExtractFilePath(EkRTF1.OutFile)+'\Расписка в получении документа для '+
      qrPers.FieldByName('Fam').AsString+' '+
      qrPers.FieldByName('Im').AsString+' '+
      qrPers.FieldByName('Otch').AsString+'.rtf';
    EkRTF1.ExecuteOpen([qrPers, qrVUR],SW_SHOWDEFAULT);
    Result := true;
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер сотрудника: '+IntToStr(qrPers.Parameters.ParamByName('ID').Value)]);
  except
    Result := false;
  end;
end;


end.

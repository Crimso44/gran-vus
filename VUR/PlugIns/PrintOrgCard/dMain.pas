unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ekbasereport;

type
  TdmMain = class(TDataModule)
    qrOrgData: TADOQuery;
    qrOrgCont: TADOQuery;
    qrOrgPaym: TADOQuery;
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Карточка организации';

implementation

{$R *.DFM}

uses IniFiles;

procedure TdmMain.DataModuleCreate(Sender: TObject);
var s: string;
    path: string;
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  path := ExtractFilePath(Application.ExeName);
  with TIniFile.Create(path+'settings.ini') do begin
    s := ReadString('PATHS','TEMPLATES',path+'Templates');
    if Copy(s,Length(s),1)<>'\' then s := s + '\';
    EkRTF1.Infile := s + 'org_card.rtf';
    s := ReadString('PATHS','REPORTS',path+'Reports');
    if Copy(s,Length(s),1)<>'\' then s := s + '\';
    EkRTF1.Outfile := s + 'Сведения об организации.rtf';
    Free;
  end;
end;

end.

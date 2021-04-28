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
    procedure FillExecutor;
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

procedure TdmMain.FillExecutor;
var
  qrExecutor: TADOQuery;
begin
  qrExecutor := TADOQuery.Create(Self);
  qrExecutor.Connection := dmMain.dbMain;
  qrExecutor.SQL.Text := 'Select * from ORG_Cont where Is_Gen = 3';
  qrExecutor.Open;
  if qrExecutor.Eof then begin
    EkRtf1.CreateVar('ExecutorFam', '');
    EkRtf1.CreateVar('ExecutorIm', '');
    EkRtf1.CreateVar('ExecutorOtch', '');
    EkRtf1.CreateVar('ExecutorPhone', '');
    EkRtf1.CreateVar('ExecutorPost', '');
  end else begin
    EkRtf1.CreateVar('ExecutorFam', qrExecutor.FieldByName('Fam').AsString);
    EkRtf1.CreateVar('ExecutorIm', qrExecutor.FieldByName('Im').AsString);
    EkRtf1.CreateVar('ExecutorOtch', qrExecutor.FieldByName('Otch').AsString);
    EkRtf1.CreateVar('ExecutorPhone', qrExecutor.FieldByName('Phone').AsString);
    EkRtf1.CreateVar('ExecutorPost', qrExecutor.FieldByName('Post').AsString);
  end;
  qrExecutor.Close;
end;

end.

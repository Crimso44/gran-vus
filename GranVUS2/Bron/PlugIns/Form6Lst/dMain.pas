unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    ilSmall: TImageList;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;

var
  dmMain: TdmMain;
  FPrintOnly: Boolean;

const
  sEventObject = '����� � 5, � 6 ���';

implementation

{$R *.DFM}

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
end;

end.

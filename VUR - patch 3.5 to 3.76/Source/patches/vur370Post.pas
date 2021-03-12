unit vur370Post;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, StdCtrls, dxCntner, dxTL, dxDBCtrl, dxDBGrid, DB,
  dxmdaset, dxDBTLCl, dxGrClms, ADODB;

type
  TfrmVur370Post = class(TForm)
    Label1: TLabel;
    dbgPOST: TdxDBGrid;
    Button1: TButton;
    dsPost: TDataSource;
    qrPost: TADOQuery;
    qrCProf: TADOQuery;
    qrCProfCPROF_ID: TIntegerField;
    qrCProfCPROF_NAME: TStringField;
    qrPostPOST_ID: TIntegerField;
    qrPostPOST_NAME: TStringField;
    qrPostCPROF_ID: TIntegerField;
    qrPostCPROF_NAME: TStringField;
    dbgPOSTPOST_NAME: TdxDBGridMaskColumn;
    dbgPOSTCPROF_NAME: TdxDBGridLookupColumn;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVur370Post: TfrmVur370Post;

implementation

{$R *.dfm}

procedure TfrmVur370Post.Button1Click(Sender: TObject);
begin
  with qrPost do if State = dsEdit then Post;
end;

end.

unit fPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Grids;

type
  TfrmPreview = class(TForm)
    Panel1: TPanel;
    bClose: TButton;
    StringGrid1: TStringGrid;
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPreview: TfrmPreview;

implementation

{$R *.dfm}

procedure TfrmPreview.FormResize(Sender: TObject);
var
  koef0, koef1: double;
begin
  koef0 := 1.0 * StringGrid1.ColWidths[0] / (StringGrid1.ColWidths[0] + StringGrid1.ColWidths[1]);
  koef1 := 1 - koef0;
  StringGrid1.ColWidths[0] := Round(StringGrid1.ClientWidth * koef0 - 2);
  StringGrid1.ColWidths[1] := Round(StringGrid1.ClientWidth * koef1 - 2);
end;

end.

unit DisplayDSs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid, dxmdaset, DB;

type
  TForm1 = class(TForm)
    Grid2: TdxDBGrid;
    DataSource1: TDataSource;
    Grid1: TdxDBGrid;
    DataSource2: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure DisplayDataSets(ds, ds1: TdxMemData);

implementation

procedure DisplayDataSets(ds, ds1: TdxMemData);
begin
  with TForm1.Create(Application) do
  try
    ds.EnableControls;
    ds1.EnableControls;
    DataSource1.DataSet := ds;
    Grid1.ClearNodes;
    Grid1.CreateDefaultColumns(ds, Grid1);
    DataSource2.DataSet := ds1;
    Grid2.ClearNodes;
    Grid2.CreateDefaultColumns(ds1, Grid2);
    ShowModal;
  finally
    ds.DisableControls;
    ds1.DisableControls;
    Free;
  end;
end;

{$R *.dfm}

end.

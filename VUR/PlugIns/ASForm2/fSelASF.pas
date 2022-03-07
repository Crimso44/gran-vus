unit fSelASF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, ADODB, dxExEdtr, dxDBGrid, dxTL,
  dxDBCtrl, dxCntner, dxDBTLCl, dxGrClms, dxmdaset;

type
  TfrmASF = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    qASF: TADOQuery;
    dsASF: TDataSource;
    dxDBGrid1: TdxDBGrid;
    qASFASF_ID: TIntegerField;
    qASFOrgName: TWideStringField;
    qASFOrgSName: TWideStringField;
    qASFPERS_ID: TIntegerField;
    dxDBGrid1ASF_ID: TdxDBGridMaskColumn;
    dxDBGrid1OrgName: TdxDBGridColumn;
    dxDBGrid1OrgSName: TdxDBGridColumn;
    mASF: TdxMemData;
    mASFSelected: TBooleanField;
    mASFOrgSName: TStringField;
    mASFOrgName: TStringField;
    mASFASF_ID: TIntegerField;
    dxDBGrid1RecId: TdxDBGridColumn;
    dxDBGrid1Selected: TdxDBGridCheckColumn;
    procedure FormActivate(Sender: TObject);
    procedure dxDBGrid1CustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure dxDBGrid1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmASF: TfrmASF;

implementation

{$R *.dfm}

uses dMain;


procedure TfrmASF.dxDBGrid1Click(Sender: TObject);
begin
  mASF.Edit;
  mASFSelected.AsBoolean := not mASFSelected.AsBoolean;
  mASF.Post;
end;

procedure TfrmASF.dxDBGrid1CustomDrawCell(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; ASelected,
  AFocused, ANewItemRow: Boolean; var AText: string; var AColor: TColor;
  AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
begin
  AColor := $ffffff;
  if not VarIsNull(ANode.Values[dxDBGrid1Selected.Index]) then
    if ANode.Values[dxDBGrid1Selected.Index] then
      AColor := $ffdddd;
end;

procedure TfrmASF.FormActivate(Sender: TObject);
var
  col: TdxDBGridColumn;
  i: Integer;
begin
  // см. камент  "не понимаю, какого хрена" в \DevExOld\ExpressQuantumTreeList 3\Sources\dxDBCtrl.pas
  (*for i := 0 to dxDbGrid1.ColumnCount - 1 do begin
    col := TdxDBGridColumn(dxDbGrid1.Columns[i]);
    col.GroupIndex := -1;
  end;*)

  qASF.Open;
  mASF.Open;
  while not qASF.Eof do begin
    mASF.Append;
    mASFASF_Id.AsInteger := qASFASF_Id.AsInteger;
    mASFOrgName.AsString := qASFOrgName.AsString;
    mASFOrgSName.AsString := qASFOrgSName.AsString;
    mASF.Post;

    qASF.Next;
  end;
  mASF.First;
end;

end.

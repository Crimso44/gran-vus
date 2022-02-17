unit fReplacePlan;

interface

uses
  dMain, msg,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, ComCtrls, DB,
  dxDBTLCl, dxGrClms, Vcl.Buttons;

type
  TfrmReplacePlan = class(TForm)
    ToolBar1: TToolBar;
    MainGrid: TdxDBGrid;
    dsGrid: TDataSource;
    MainGridPers_id: TdxDBGridMaskColumn;
    MainGridPers_Fio: TdxDBGridMaskColumn;
    MainGridPers_Dep: TdxDBGridMaskColumn;
    MainGridPers_Post: TdxDBGridMaskColumn;
    MainGridRepl_Id: TdxDBGridMaskColumn;
    MainGridRepl_Dep: TdxDBGridMaskColumn;
    MainGridRepl_Post: TdxDBGridMaskColumn;
    MainGridRepl_War: TdxDBGridMaskColumn;
    bSave: TToolButton;
    ToolButton2: TToolButton;
    bPrint: TToolButton;
    MainGridRepl_Fio: TdxDBGridButtonColumn;
    bExcel: TToolButton;
    MainGridRecId: TdxDBGridColumn;
    procedure bSaveClick(Sender: TObject);
    procedure MainGridRepl_FioButtonClick(Sender: TObject;
      AbsoluteIndex: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure bExcelClick(Sender: TObject);
    procedure bPrintClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReplacePlan: TfrmReplacePlan;

implementation

{$R *.dfm}

uses fSelectPerson;

procedure TfrmReplacePlan.bExcelClick(Sender: TObject);
begin
  dmMain.GridToExcel(MainGrid,Caption,true,true);
end;

procedure TfrmReplacePlan.bPrintClick(Sender: TObject);
begin
  dmMain.PrintData;
end;

procedure TfrmReplacePlan.bSaveClick(Sender: TObject);
begin
  dmMain.SaveData;
end;

procedure TfrmReplacePlan.FormActivate(Sender: TObject);
var
  col: TdxDBGridColumn;
  i: Integer;
begin
  for i := 0 to MainGrid.ColumnCount - 1 do begin
    col := TdxDBGridColumn(MainGrid.Columns[i]);
    col.GroupIndex := -1;
  end;
end;

procedure TfrmReplacePlan.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  dmMain.mReplacePlan.CheckBrowseMode;
  if dmMain.is_changed then begin
    CanClose := Confirm('Данные были изменены и не сохранены!'#13'Все равно закрыть форму?')
  end else
    CanClose := True;
end;

procedure TfrmReplacePlan.MainGridRepl_FioButtonClick(Sender: TObject;
  AbsoluteIndex: Integer);
var
  f: TfrmSelectPerson;
begin
  f := TfrmSelectPerson.Create(Self);
  with dmMain do try
    qrSelectPerson.Locate('Pers_Id', mReplacePlanRepl_Id.AsInteger, []);
    if f.ShowModal = mrOK then begin
      mReplacePlan.Edit;
      mReplacePlanRepl_Id.AsInteger := qrSelectPersonPers_Id.AsInteger;
      mReplacePlanRepl_Fio.AsString := qrSelectPersonPers_FIO.AsString;
      mReplacePlanRepl_Dep.AsString := qrSelectPersonPers_Dep.AsString;
      mReplacePlanRepl_Post.AsString := qrSelectPersonPers_Post.AsString;
      mReplacePlanRepl_War.AsString := qrSelectPersonWar.AsString;
      mReplacePlan.Post;
    end;
  finally
    f.Free;
  end;
end;

end.

unit ColumnCustomize;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, CheckLst, dbGrids, dxDBGrid;

type
  TColumnCustomizeForm = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    CheckListBox: TCheckListBox;
    ApplyButton: TButton;
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure CheckListBoxDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure CheckListBoxDragDrop(Sender, Source: TObject; X, Y: Integer);
  private
    FControl: TCustomControl;
  public
  end;

  function ShowColumnCustomize(Control: TCustomControl): Integer;

implementation

{$R *.DFM}

uses dxTL;

function ShowColumnCustomize(Control: TCustomControl): Integer;
var ColumnCustomizeForm: TColumnCustomizeForm;
begin
  ColumnCustomizeForm:=TColumnCustomizeForm.Create(Application);
  try
    ColumnCustomizeForm.FControl:= Control;
    Result:=ColumnCustomizeForm.ShowModal;
  finally
    ColumnCustomizeForm.Free;
  end;
end;

procedure TColumnCustomizeForm.FormShow(Sender: TObject);
var i: Integer;
begin
  with CheckListBox do begin
    Clear;
    if FControl is TDBGrid then
      for i:= 0 to TDBGrid(FControl).Columns.Count - 1 do begin
        Checked[Items.AddObject(TDBGrid(FControl).Columns[i].Title.Caption, TDBGrid(FControl).Columns[i])]:=TDBGrid(FControl).Columns[i].Visible
      end
    else if FControl is TCustomdxTreeListControl then
      for i:= 0 to TCustomdxTreeListControl(FControl).ColumnCount - 1 do
        if (TCustomdxTreeListControl(FControl).Columns[i].HeaderMaxLineCount > 0) and
            not TCustomdxTreeListControl(FControl).Columns[i].DisableCustomizing then
          Checked[Items.AddObject(TCustomdxTreeListControl(FControl).Columns[i].Caption, TCustomdxTreeListControl(FControl).Columns[i])]:=TCustomdxTreeListControl(FControl).Columns[i].Visible;
  end;
end;

procedure TColumnCustomizeForm.OKBtnClick(Sender: TObject);
begin
  ApplyButtonClick(Sender);
end;

procedure TColumnCustomizeForm.ApplyButtonClick(Sender: TObject);
var i: Integer;
begin
  if FControl is TDBGrid then
    for i:= 0 to CheckListBox.Items.Count - 1 do begin
      TColumn(CheckListBox.Items.Objects[i]).Visible:= CheckListBox.Checked[i];
      TColumn(CheckListBox.Items.Objects[i]).Index:= i;
    end
  else if FControl is TCustomdxTreeListControl then
    for i:= 0 to CheckListBox.Items.Count - 1 do begin
      TdxTreeListColumn(CheckListBox.Items.Objects[i]).Visible:= CheckListBox.Checked[i];
      TdxTreeListColumn(CheckListBox.Items.Objects[i]).Index:= i;
    end;
end;

procedure TColumnCustomizeForm.CheckListBoxDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  Item: Integer;
begin
  Item := CheckListBox.ItemAtPos(Point(X, Y), False);
  Accept := (Source = CheckListBox) and
    (Item >= 0) and (Item < CheckListBox.Items.Count) and
    not CheckListBox.Selected[Item];
end;

procedure TColumnCustomizeForm.CheckListBoxDragDrop(Sender,
  Source: TObject; X, Y: Integer);
var
  Item: Integer;
begin
  Item := CheckListBox.ItemAtPos(Point(X, Y), False);
  CheckListBox.Items.Move(CheckListBox.ItemIndex, Item);
end;

end.

unit fSelectPerson;

interface

uses
  dMain,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid;

type
  TfrmSelectPerson = class(TForm)
    Panel1: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    dsSelectPerson: TDataSource;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1Pers_Id: TdxDBGridMaskColumn;
    dxDBGrid1Pers_FIO: TdxDBGridColumn;
    dxDBGrid1Pers_Dep: TdxDBGridColumn;
    dxDBGrid1Pers_Post: TdxDBGridColumn;
    dxDBGrid1war: TdxDBGridColumn;
    procedure dxDBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelectPerson: TfrmSelectPerson;

implementation

{$R *.dfm}

procedure TfrmSelectPerson.dxDBGrid1DblClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

end.

unit fParamDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  dxDBTLCl, dxGrClms, ActnList;

type
  TfmParamDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1N26_ID: TdxDBGridMaskColumn;
    dxDBGrid1Form_Num: TdxDBGridMaskColumn;
    dxDBGrid1Create_Date: TdxDBGridDateColumn;
    dxDBGrid1Give_Date: TdxDBGridDateColumn;
    ActionList1: TActionList;
    Action1: TAction;
    procedure Action1Update(Sender: TObject);
    procedure dxDBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetN26_ID: Integer;

var
  fmParamDlg: TfmParamDlg;

implementation

{$R *.dfm}

uses ADOdb, dMain, msg;

function GetN26_ID: Integer;
begin
  with TfmParamDlg.Create(Application) do
  try
    if ShowModal = mrOK then
      Result := dmMain.qrN26History.FieldByName('N26_ID').AsInteger
    else
      Result := -1;
  finally
    Free;
  end;
end;

procedure TfmParamDlg.Action1Update(Sender: TObject);
begin
  Action1.Enabled := dxDBGrid1.Count > 0;
end;

procedure TfmParamDlg.dxDBGrid1DblClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

end.

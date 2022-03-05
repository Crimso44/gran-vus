unit frmAddr;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, dxCntner,
  dxEditor, dxExEdtr, dxEdLib, dxTL, dxTLClms, Vcl.Menus;

type
  TfAddr = class(TForm)
    Panel1: TPanel;
    btnOk: TButton;
    dxtFamily: TdxTreeList;
    colFamType: TdxTreeListPickColumn;
    dxTreeListMaskColumn1: TdxTreeListMaskColumn;
    dxTreeListMaskColumn2: TdxTreeListMaskColumn;
    cbFamState: TComboBox;
    Label20: TLabel;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    dtADDR_DATE1: TdxDateEdit;
    Label168: TLabel;
    dtADDR_DATE_END1: TdxDateEdit;
    edAddr1: TEdit;
    edIndex1: TEdit;
    Label13: TLabel;
    GroupBox2: TGroupBox;
    Label14: TLabel;
    edIndex2: TEdit;
    edAddr2: TEdit;
    Label6: TLabel;
    dtADDR_DATE2: TdxDateEdit;
    pmFamily: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    dxtFamilyColumn4: TdxTreeListMaskColumn;
    procedure edIndex1Change(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure cbFamStateChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OnChange: procedure (Sender: TObject) of object;
  end;

var
  fAddr: TfAddr;

implementation

{$R *.dfm}

procedure TfAddr.btnOkClick(Sender: TObject);
begin
  Close;
end;

procedure TfAddr.cbFamStateChange(Sender: TObject);
begin
  if cbFamState.ItemIndex = (cbFamState.Items.Count - 1) then
    cbFamState.Font.Color := clRed
  else
    cbFamState.Font.Color := clBtnText;
  OnChange(Sender);
end;

procedure TfAddr.edIndex1Change(Sender: TObject);
begin
  OnChange(nil);
end;

procedure TfAddr.MenuItem1Click(Sender: TObject);
begin
  dxtFamily.Add.Focused := true;
  OnChange(Self);
end;

procedure TfAddr.MenuItem2Click(Sender: TObject);
begin
  if dxtFamily.FocusedNode<>nil then begin
    dxtFamily.FocusedNode.Destroy;
    OnChange(Self);
  end;
end;

end.

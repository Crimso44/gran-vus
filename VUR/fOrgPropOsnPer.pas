unit fOrgPropOsnPer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, dxExEdtr, dxTLClms, dxTL, dxCntner, FrmKeep,
  Menus, ActnList;

type
  TfmOrgPropOsnPer = class(TForm)
    Label1: TLabel;
    edName: TEdit;
    Bevel1: TBevel;
    Label2: TLabel;
    dxtOSN: TdxTreeList;
    colBASE_ID: TdxTreeListPickColumn;
    colDOC_ID: TdxTreeListPickColumn;
    colDOC_NO: TdxTreeListColumn;
    colDOC_DATE: TdxTreeListDateColumn;
    Bevel2: TBevel;
    Button1: TButton;
    pmOsn: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    ActionList: TActionList;
    actAdd: TAction;
    actDel: TAction;
    pbOSNAdd: TButton;
    pbOSNDel: TButton;
    procedure FormShow(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxtOSNEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure dxtOSNEnter(Sender: TObject);
    procedure dxtOSNExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
  public
    FOrgProp: TForm;
  end;


implementation

uses fOrgProp, dMain;

{$R *.dfm}

procedure TfmOrgPropOsnPer.FormShow(Sender: TObject);
var  F: TfmOrgProp;
begin
  F := TfmOrgProp(FOrgProp);
  edName.Text := StringReplace(F.mmName.Text,#13#10,' ',[rfReplaceAll]);
end;

procedure TfmOrgPropOsnPer.N1Click(Sender: TObject);
begin
  with dxtOSN.Add do begin
    Focused := true;
    Values[colBase_Id.Index] := colBase_Id.Items[0];
    Values[colDoc_Id.Index] := colDoc_Id.Items[0];
  end;
  TfmOrgProp(FOrgProp).mmName.OnChange(Self);
end;

procedure TfmOrgPropOsnPer.N2Click(Sender: TObject);
begin
  if dxtOSN.FocusedNode<>nil then begin
    dxtOSN.FocusedNode.Destroy;
    TfmOrgProp(FOrgProp).mmName.OnChange(Self);
  end;
end;

procedure TfmOrgPropOsnPer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TfmOrgPropOsnPer.dxtOSNEdited(Sender: TObject;
  Node: TdxTreeListNode);
begin
  TfmOrgProp(FOrgProp).mmName.OnChange(Self);
end;

procedure TfmOrgPropOsnPer.dxtOSNEnter(Sender: TObject);
begin
  (Sender as TdxTreeList).LookAndFeel := lfStandard;
end;

procedure TfmOrgPropOsnPer.dxtOSNExit(Sender: TObject);
begin
  (Sender as TdxTreeList).LookAndFeel := lfFlat;
end;

procedure TfmOrgPropOsnPer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_F1) and (Shift=[]) then Application.HelpContext(HelpContext);
end;

procedure TfmOrgPropOsnPer.FormCreate(Sender: TObject);
begin
  dxtOSN.Enabled := dmMain.rEdit;
  pbOSNAdd.Enabled := dmMain.rEdit;
  pbOSNDel.Enabled := dmMain.rEdit;
end;

end.

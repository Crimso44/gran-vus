unit fOrgPropVoenkom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmOrgPropVoenkom = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    edFam1: TEdit;
    edIm1: TEdit;
    edOtch1: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Bevel2: TBevel;
    Label5: TLabel;
    edFam2: TEdit;
    edIm2: TEdit;
    edOtch2: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Bevel3: TBevel;
    btnClose: TButton;
    procedure edFam1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure edFam1KeyPress(Sender: TObject; var Key: Char);
  private
  public
    FOrgProp: TForm;
  end;


implementation

uses fOrgProp, StrUtils, dMain;

{$R *.dfm}

procedure TfmOrgPropVoenkom.edFam1Change(Sender: TObject);
begin
  TfmOrgProp(FOrgProp).mmName.OnChange(Self);
end;

procedure TfmOrgPropVoenkom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;
end;

procedure TfmOrgPropVoenkom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_F1) and (Shift=[]) then Application.HelpContext(HelpContext);
end;

procedure TfmOrgPropVoenkom.FormCreate(Sender: TObject);
begin
  edFam1.Enabled   := dmMain.rEdit;
  edIm1.Enabled    := dmMain.rEdit; 
  edOtch1.Enabled  := dmMain.rEdit; 
  edFam2.Enabled   := dmMain.rEdit;
  edIm2.Enabled    := dmMain.rEdit;
  edOtch2.Enabled  := dmMain.rEdit;
end;

procedure TfmOrgPropVoenkom.edFam1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=' ' then Key := #0;
end;

end.

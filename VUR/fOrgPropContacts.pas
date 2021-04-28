unit fOrgPropContacts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfmOrgPropContacts = class(TForm)
    Label1: TLabel;
    edOrgName: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel1: TBevel;
    edFam1: TEdit;
    edIm1: TEdit;
    edOtch1: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edPhone1: TEdit;
    Label9: TLabel;
    edPost1: TEdit;
    Bevel2: TBevel;
    Label5: TLabel;
    edFam2: TEdit;
    edIm2: TEdit;
    edOtch2: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edPhone2: TEdit;
    Label13: TLabel;
    edPost2: TEdit;
    Bevel3: TBevel;
    btnClose: TButton;
    edPost3: TEdit;
    edPhone3: TEdit;
    edOtch3: TEdit;
    edIm3: TEdit;
    edFam3: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Bevel4: TBevel;
    Label19: TLabel;
    procedure edFam1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

procedure TfmOrgPropContacts.edFam1Change(Sender: TObject);
begin
  TfmOrgProp(FOrgProp).mmName.OnChange(Self);
end;

procedure TfmOrgPropContacts.FormShow(Sender: TObject);
var n: Integer;
    s: string;
begin
  edOrgName.Text := StringReplace(TfmOrgProp(FOrgProp).mmName.Text,#13#10,' ',[rfReplaceAll]);

  s := TfmOrgProp(FOrgProp).edVUR.Text;
  while Pos('  ',s)>0 do
    s := StringReplace(s,'  ',' ',[rfReplaceAll]);
  n := Pos(' ',s);
  if n=0 then begin
    edFam2.Text := EmptyStr;
    edIm2.Text := EmptyStr;
    edOtch2.Text := EmptyStr;
  end
  else begin
    edFam2.Text := LeftStr(s,n-1);
    s := RightStr(s,Length(s)-n);
    n := Pos(' ',s);
    if n=0 then begin
      edIm2.Text := s;
      edOtch2.Text := EmptyStr;
    end
    else begin
      edIm2.Text := LeftStr(s,n-1);
      edOtch2.Text := RightStr(s,Length(s)-n);
    end;
  end;
  edPhone2.Text := TfmOrgProp(FOrgProp).edPhone.Text;
end;

procedure TfmOrgPropContacts.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caHide;

  if (Trim(edFam2.Text) = '') and (Trim(edIm2.Text) = '') and (Trim(edOtch2.Text) = '') and
   (Trim(edPhone2.Text) = '') and (Trim(edPost2.Text) = '') then begin
    edFam2.Text := edFam1.Text;
    edIm2.Text := edIm1.Text;
    edOtch2.Text := edOtch1.Text;
    edPhone2.Text := edPhone1.Text;
    edPost2.Text := edPost1.Text;
  end;

  TfmOrgProp(FOrgProp).edVUR.Text := edFam2.Text+' '+edIm2.Text+' '+edOtch2.Text;
  TfmOrgProp(FOrgProp).edPhone.Text := edPhone2.Text;
end;

procedure TfmOrgPropContacts.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_F1) and (Shift=[]) then Application.HelpContext(HelpContext);
end;

procedure TfmOrgPropContacts.FormCreate(Sender: TObject);
begin
  edFam1.Enabled   := dmMain.rEdit;
  edIm1.Enabled    := dmMain.rEdit; 
  edOtch1.Enabled  := dmMain.rEdit; 
  edPhone1.Enabled := dmMain.rEdit; 
  edPost1.Enabled  := dmMain.rEdit; 
  edFam2.Enabled   := dmMain.rEdit; 
  edIm2.Enabled    := dmMain.rEdit; 
  edOtch2.Enabled  := dmMain.rEdit; 
  edPhone2.Enabled := dmMain.rEdit; 
  edPost2.Enabled  := dmMain.rEdit; 
end;

procedure TfmOrgPropContacts.edFam1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=' ' then Key := #0;
end;

end.

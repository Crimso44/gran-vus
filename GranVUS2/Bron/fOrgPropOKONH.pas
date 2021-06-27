unit fOrgPropOKONH;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmOrgPropOKONH = class(TForm)
    mmOKONH: TMemo;
    Button1: TButton;
    procedure mmOKONHChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure mmOKONHKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
  public
    FOrgProp: TForm;
  end;

implementation

uses fOrgProp, StrUtils, dMain;

{$R *.dfm}

procedure TfmOrgPropOKONH.mmOKONHChange(Sender: TObject);
begin
  TfmOrgProp(FOrgProp).mmName.OnChange(Self);
end;

procedure TfmOrgPropOKONH.Button1Click(Sender: TObject);
var s: string;
    n: Integer;
begin
  if (mmOKONH.Text<>EmptyStr){ and (TfmOrgProp(FOrgProp).edOKONH.Text=EmptyStr)} then begin
    s := mmOKONH.Lines[0];
    n := Pos(',',s);
    if n>0 then SetLength(s,n-1);
    TfmOrgProp(FOrgProp).edOKONH.Text := LeftStr(Trim(s),15);
  end;
end;

procedure TfmOrgPropOKONH.mmOKONHKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9','.',',']) then Key := #0;
end;

procedure TfmOrgPropOKONH.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_F1) and (Shift=[]) then Application.HelpContext(HelpContext);
end;

procedure TfmOrgPropOKONH.FormCreate(Sender: TObject);
begin
  mmOKONH.Enabled := dmMain.rEdit;
end;

end.

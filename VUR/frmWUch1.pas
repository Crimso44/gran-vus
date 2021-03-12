unit frmWUch1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dxExEdtr, dxEdLib, dxCntner, dxEditor;

type
  TfWUch1 = class(TForm)
    chkSpecialWuch1: TCheckBox;
    edWUch1: TEdit;
    Panel1: TPanel;
    btnOk: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edMob_CardDate: TdxDateEdit;
    edMob_Days: TdxSpinEdit;
    edMob_Hours: TdxSpinEdit;
    edMob_Mins: TdxSpinEdit;
    edMob_MissReason: TEdit;
    Label7: TLabel;
    edMob_Place: TEdit;
    Label8: TLabel;
    procedure edMob_DaysChange(Sender: TObject);
    procedure edWUch1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    OnChange: procedure (Sender: TObject) of object;
  end;

implementation

{$R *.dfm}

uses dMain;

procedure TfWUch1.edMob_DaysChange(Sender: TObject);
begin
  OnChange(nil);
end;

procedure TfWUch1.edWUch1Change(Sender: TObject);
begin
  with chkSpecialWUch1 do
  if edWUch1.Text='' then begin
    Enabled := False; Checked := False;
  end
  else
    Enabled := dmMain.rEdit;
  OnChange(nil);
end;

end.

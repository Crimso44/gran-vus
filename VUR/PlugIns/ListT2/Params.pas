unit Params;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib;

type
  TdlgParams = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    rgSort: TRadioGroup;
    rgType: TRadioGroup;
    Label3: TLabel;
    Label4: TLabel;
    Date_From: TdxDateEdit;
    Label5: TLabel;
    Date_To: TdxDateEdit;
    procedure Date_FromDateValidateInput(Sender: TObject; const AText: string;
      var ADate: TDateTime; var AMessage: string; var AError: Boolean);
    procedure Date_ToDateValidateInput(Sender: TObject; const AText: string;
      var ADate: TDateTime; var AMessage: string; var AError: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dlgParams: TdlgParams;

implementation

{$R *.dfm}

uses DateUtils, msg;

procedure TdlgParams.BitBtn1Click(Sender: TObject);
begin
  if (Date_From.Text = '') or (Date_To.Text = '') then begin
    ShowInfo('Необходимо указать период!');
    Exit;
  end;
  ModalResult := mrOK;
end;

procedure TdlgParams.Date_FromDateValidateInput(Sender: TObject;
  const AText: string; var ADate: TDateTime; var AMessage: string;
  var AError: Boolean);
begin
  if ADate >= Date_To.Date then ADate := IncYear(Date_To.Date, -1);
end;

procedure TdlgParams.Date_ToDateValidateInput(Sender: TObject;
  const AText: string; var ADate: TDateTime; var AMessage: string;
  var AError: Boolean);
begin
  if ADate <= Date_From.Date then ADate := IncYear(Date_From.Date, 1);
end;

procedure TdlgParams.FormCreate(Sender: TObject);
begin
  Date_From.Date := IncYear(Date, -1);
  Date_To.Date := Date;
end;

end.

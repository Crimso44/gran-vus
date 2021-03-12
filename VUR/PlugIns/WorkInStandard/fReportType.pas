unit fReportType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, ActnList;

type
  TfmReportType = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton6: TRadioButton;
    ActionList1: TActionList;
    aChange: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Checked: Integer;
    { Public declarations }
  end;

var
  fmReportType: TfmReportType;

implementation

{$R *.dfm}

uses WinHelpViewer;

procedure TfmReportType.Button1Click(Sender: TObject);
begin
  if RadioButton1.Checked then Checked := 0
  else if RadioButton6.Checked then Checked := 5;
end;

procedure TfmReportType.FormCreate(Sender: TObject);
begin
  HelpFile := ExtractFileDir(Application.ExeName) + '/granvus.hlp';
end;

end.

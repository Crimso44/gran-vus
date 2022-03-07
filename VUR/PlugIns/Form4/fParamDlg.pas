unit fParamDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, CheckLst, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid,
  dxDBTLCl, dxGrClms, ActnList, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxTextEdit, cxMaskEdit, cxSpinEdit, dxSkinBasic,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkroom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinOffice2019Black, dxSkinOffice2019Colorful,
  dxSkinOffice2019DarkGray, dxSkinOffice2019White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringtime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinTheBezier, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, System.Actions, dxEditor, dxEdLib;

type
  TfmParamDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    cbPrintVK: TCheckBox;
    cbPrintAddr: TCheckBox;
    ActionList1: TActionList;
    Action1: TAction;
    Label1: TLabel;
    Button3: TButton;
    lNumStr: TLabel;
    Label2: TLabel;
    edFioDat: TEdit;
    Label3: TLabel;
    edPostRod: TEdit;
    edMonthCount: TdxSpinEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure edMonthCountPropertiesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmParamDlg: TfmParamDlg;

implementation

{$R *.dfm}

uses ADOdb, dMain, msg, IniSupport, Num2Str;

procedure TfmParamDlg.Button3Click(Sender: TObject);
var
  fileName: String;
begin
  fileName := GetTemplatesDir + 'form4blank.pdf';
  ShellExecute(0,'open',PChar(fileName),nil,nil,SW_NORMAL);
end;

procedure TfmParamDlg.edMonthCountPropertiesChange(Sender: TObject);
begin
  lNumStr.Caption := convert(edMonthCount.IntValue);
end;

procedure TfmParamDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'granvus.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.

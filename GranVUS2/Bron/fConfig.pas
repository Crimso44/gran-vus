unit fConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, FrmKeep;

type
  TfmConfig = class(TForm)
    PC: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    edTemp: TEdit;
    sbTemp: TSpeedButton;
    sbRep: TSpeedButton;
    edRep: TEdit;
    Label2: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    FrmKeep1: TFrmKeep;
    chkTimeOut: TCheckBox;
    lbTimeOut: TLabel;
    edTimeOut: TEdit;
    udTimeOut: TUpDown;
    Label6: TLabel;
    edPlug: TEdit;
    sbPlug: TSpeedButton;
    Label5: TLabel;
    edBackUp: TEdit;
    sbBackUp: TSpeedButton;
    TabSheet3: TTabSheet;
    cbOrgFilter: TCheckBox;
    Label3: TLabel;
    edSubjCode: TEdit;
    Label4: TLabel;
    edReportdate: TDateTimePicker;
    chAfterNY: TCheckBox;
    chVUOAfterNY: TCheckBox;
    chMainVUOAfterNY: TCheckBox;
    cb6in18: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure sbTempClick(Sender: TObject);
    procedure sbRepClick(Sender: TObject);
    procedure edTimeOutKeyPress(Sender: TObject; var Key: Char);
    procedure sbPlugClick(Sender: TObject);
    procedure chkTimeOutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

  procedure ConfigDlg;

implementation

uses FileCtrl, IniSupport, ADOdb, dMain, MD5, msg, fKbdMouHk, fMain;

{$R *.DFM}

procedure ConfigDlg;
var  fmConfig: TfmConfig;
begin
  Application.CreateForm(TfmConfig,fmConfig);
  if fmMain.MainScale <> 100 then
    fmConfig.ScaleBy(fmMain.MainScale, 100);
  fmConfig.ShowModal;
  fmConfig.Free;
end;


procedure TfmConfig.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmConfig.sbTempClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выбор папки с шаблонами',EmptyStr,s) then edTemp.Text := s;
end;

procedure TfmConfig.sbRepClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выбор папки с отчетами',EmptyStr,s) then edRep.Text := s;
end;

procedure TfmConfig.sbPlugClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выбор папки с внешними модулями',EmptyStr,s) then edPlug.Text := s;
end;

procedure TfmConfig.edTimeOutKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9']) then Key := #0;
end;


procedure TfmConfig.chkTimeOutClick(Sender: TObject);
begin
  lbTimeOut.Enabled := chkTimeOut.Checked;
  edTimeOut.Enabled := chkTimeOut.Checked;
  udTimeOut.Enabled := chkTimeOut.Checked;
end;

procedure TfmConfig.FormShow(Sender: TObject);
begin
  chkTimeOut.Checked := IniSupport.GetTimeOut>0;
  chkTimeOut.OnClick(chkTimeOut);
  udTimeOut.Position := abs(IniSupport.GetTimeOut div 60);
  cbOrgFilter.Checked := IniSupport.GetOrgFilter;
  edTemp.Text := IniSupport.GetTemplatesDir;
  edRep.Text := IniSupport.GetReportsDir;
  edPlug.Text := IniSupport.GetPlugInsDir;
  edBackUp.Text := IniSupport.GetBackUpDir;
  edSubjCode.Text := IniSupport.GetSubjCode;
  edReportdate.Date := IniSupport.GetReportDate;
  chAfterNY.Checked := IniSupport.GetAfterNY;
  chVUOAfterNY.Checked := IniSupport.GetVUOAfterNY;
  chMainVUOAfterNY.Checked := IniSupport.GetMainVUOAfterNY;
  cb6in18.Checked := IniSupport.Get6in18;
end;

procedure TfmConfig.Button1Click(Sender: TObject);
begin
  if ChkTimeOut.Checked
    then IniSupport.SetTimeOut(udTimeOut.Position*60)
    else IniSupport.SetTimeOut(0);
  IniSupport.SetAfterNY(chAfterNY.Checked);
  IniSupport.SetVUOAfterNY(chVUOAfterNY.Checked);
  IniSupport.SetMainVUOAfterNY(chMainVUOAfterNY.Checked);
  IniSupport.Set6in18(cb6in18.Checked);
  IniSupport.SetPlugInsDir(edPlug.Text);
  IniSupport.SetTemplatesDir(edTemp.Text);
  IniSupport.SetReportsDir(edRep.Text);
  IniSupport.SetBackUpDir(edBackUp.Text);
  IniSupport.SetOrgFilter(cbOrgFilter.Checked);
  IniSupport.SetSubjCode(Trim(edSubjCode.Text));
  IniSupport.SetReportDate(edReportDate.Date);
  dmMain.time_out := IniSupport.GetTimeOut;
  EnableHook(dmMain.time_out);
  ModalResult := mrOk;
end;

end.

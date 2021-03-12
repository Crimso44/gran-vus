unit fOrgPropCommon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxEdLib, dxCntner, dxEditor, StdCtrls, ExtCtrls,
  Buttons, FrmKeep, Spin;

type
  TfmOrgPropCommon = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    mmName: TMemo;
    edRegNum: TEdit;
    dtRegDate: TdxDateEdit;
    edINN: TEdit;
    edOKPO: TEdit;
    Label7: TLabel;
    cbOKATO1: TdxPopupEdit;
    Label8: TLabel;
    edUrAddr: TEdit;
    Label9: TLabel;
    edSName: TEdit;
    sbToUrAddr: TSpeedButton;
    Label10: TLabel;
    cbOKATO2: TdxPopupEdit;
    Label11: TLabel;
    edFactAddr: TEdit;
    sbToFactAddr: TSpeedButton;
    Label12: TLabel;
    cbOKATO3: TdxPopupEdit;
    Label13: TLabel;
    edPostAddr: TEdit;
    sbToPostAddr: TSpeedButton;
    Bevel1: TBevel;
    Button1: TButton;
    Label14: TLabel;
    edParent: TEdit;
    Label15: TLabel;
    edPhone: TEdit;
    Label16: TLabel;
    edFax: TEdit;
    Label17: TLabel;
    mmComments: TMemo;
    eRegplace: TEdit;
    Label18: TLabel;
    eComputers: TSpinEdit;
    Label19: TLabel;
    eSoftware: TEdit;
    eSoftwareNum: TSpinEdit;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    eComputersS: TSpinEdit;
    Label23: TLabel;
    Label24: TLabel;
    eSoftwareNumS: TSpinEdit;
    eKpisS: TSpinEdit;
    Label25: TLabel;
    eKpis: TSpinEdit;
    Label26: TLabel;
    Label27: TLabel;
    edEmail: TEdit;
    Label28: TLabel;
    edWww: TEdit;
    Label29: TLabel;
    procedure edOKPOKeyPress(Sender: TObject; var Key: Char);
    procedure mmNameChange(Sender: TObject);
    procedure sbToUrAddrClick(Sender: TObject);
    procedure sbToFactAddrClick(Sender: TObject);
    procedure sbToPostAddrClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    FLoadData: boolean;
  public
    FOrgProp: TForm;
  end;

implementation

{$R *.dfm}
uses fOrgProp, dMain;

procedure TfmOrgPropCommon.edOKPOKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9']) then Key := #0;
end;

procedure TfmOrgPropCommon.mmNameChange(Sender: TObject);
begin
  if not FLoadData then
    TfmOrgProp(FOrgProp).mmName.OnChange(Self);
end;

procedure TfmOrgPropCommon.sbToUrAddrClick(Sender: TObject);
begin
  edUrAddr.Text := edFactAddr.Text;
  cbOKATO1.Text := cbOKATO2.Text;
end;

procedure TfmOrgPropCommon.sbToFactAddrClick(Sender: TObject);
begin
  edFactAddr.Text := edUrAddr.Text;
  cbOKATO2.Text := cbOKATO1.Text;
end;

procedure TfmOrgPropCommon.sbToPostAddrClick(Sender: TObject);
begin
  edPostAddr.Text := edFactAddr.Text;
  cbOKATO3.Text := cbOKATO2.Text;
end;

procedure TfmOrgPropCommon.FormShow(Sender: TObject);
var F: TfmOrgProp;
begin
  F := TfmOrgProp(FOrgProp);
//get data
  FLoadData := true;
  mmName.Text := F.mmName.Text;
  edRegNum.Text := F.edRegNum.Text;
  if F.dtRegDate.Text=EmptyStr then
    dtRegDate.Text := EmptyStr
  else
    dtRegDate.Date := F.dtRegDate.Date;
  eRegPlace.Text := F.eRegPlace.Text;
  edINN.Text := F.edINN.Text;
  edOKPO.Text := F.edOKPO.Text;
  edUrAddr.Text := F.edUAddr.Text;
  edFactAddr.Text := F.edFAddr.Text;
  cbOKATO1.Text := F.cbOKATO1.Text;
  cbOKATO2.Text := F.cbOKATO2.Text;
  FLoadData := false;
end;

procedure TfmOrgPropCommon.FormClose(Sender: TObject;
  var Action: TCloseAction);
var F: TfmOrgProp;
begin
  F := TfmOrgProp(FOrgProp);
//set data
  F.mmName.Text := mmName.Text;
  F.edRegNum.Text := edRegNum.Text;
  if dtRegDate.Text=EmptyStr then
    F.dtRegDate.Text := EmptyStr
  else
    F.dtRegDate.Date := dtRegDate.Date;
  F.eRegPlace.Text := eRegPlace.Text;
  F.edINN.Text := edINN.Text;
  F.edOKPO.Text := edOKPO.Text;
  F.edUAddr.Text := edUrAddr.Text;
  F.edFAddr.Text := edFactAddr.Text;
  F.cbOKATO1.Text := cbOKATO1.Text;
  F.cbOKATO2.Text := cbOKATO2.Text;
end;

procedure TfmOrgPropCommon.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key=VK_F1) and (Shift=[]) then Application.HelpContext(HelpContext);
end;

procedure TfmOrgPropCommon.FormCreate(Sender: TObject);
begin
  mmName.Enabled       := dmMain.rEdit;                    
  edSName.Enabled      := dmMain.rEdit;                    
  edParent.Enabled     := dmMain.rEdit;                    
  edPhone.Enabled      := dmMain.rEdit;                    
  edEmail.Enabled      := dmMain.rEdit;
  edWww.Enabled        := dmMain.rEdit;
  edFax.Enabled        := dmMain.rEdit;
  edRegNum.Enabled     := dmMain.rEdit;                    
  edINN.Enabled        := dmMain.rEdit;                    
  dtRegDate.Enabled    := dmMain.rEdit;                    
  edOKPO.Enabled       := dmMain.rEdit;                    
  eRegPlace.Enabled    := dmMain.rEdit;
  sbToUrAddr.Enabled   := dmMain.rEdit;                    
  edUrAddr.Enabled     := dmMain.rEdit;                    
  cbOKATO1.Enabled     := dmMain.rEdit;                    
  sbToFactAddr.Enabled := dmMain.rEdit;                    
  edFactAddr.Enabled   := dmMain.rEdit;                    
  cbOKATO2.Enabled     := dmMain.rEdit;                    
  sbToPostAddr.Enabled := dmMain.rEdit;                    
  edPostAddr.Enabled   := dmMain.rEdit;                    
  cbOKATO3.Enabled     := dmMain.rEdit;                    
  mmComments.Enabled   := dmMain.rEdit;
  eSoftware.Enabled    := dmMain.rEdit;
  eComputers.Enabled   := dmMain.rEdit;
  eSoftwareNum.Enabled := dmMain.rEdit;
  eKpis.Enabled        := dmMain.rEdit;
  eComputersS.Enabled   := dmMain.rEdit;
  eSoftwareNumS.Enabled := dmMain.rEdit;
  eKpisS.Enabled        := dmMain.rEdit;
end;

end.

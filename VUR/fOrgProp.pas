unit fOrgProp;

interface           

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, FrmKeep, ExtCtrls, dxExEdtr,
  dxEdLib, dxCntner, dxEditor, fOrgPropCommon, fOrgPropContacts, fOrgPropVoenkom, fOrgPropOsnPer,
  fOrgPropOKONH, fOrgVUZOnly, dxTL, Menus, DB, dxmdaset, dxDBCtrl, dxDBGrid,
  dxDBTLCl, dxGrClms, ADODB, dxBar, dxBarDBNav, cxClasses, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinsdxBarPainter;

type
  TfmOrgProp = class(TForm)
    dxtOKATO: TdxTreeList;
    dxtOKATOCode: TdxTreeListColumn;
    dxtOKATONameTerr: TdxTreeListColumn;
    pmOKATO: TPopupMenu;
    N1: TMenuItem;
    dxtKTerr: TdxTreeList;
    dxtKTerrCode: TdxTreeListColumn;
    dxtKTerrName: TdxTreeListColumn;
    pmTerr: TPopupMenu;
    MenuItem1: TMenuItem;
    dxtOKTMO: TdxTreeList;
    dxtOKTMOCode: TdxTreeListColumn;
    dxtOKTMOName: TdxTreeListColumn;
    pmOKTMO: TPopupMenu;
    mi1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Bevel3: TBevel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Bevel4: TBevel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label17: TLabel;
    Bevel2: TBevel;
    Bevel5: TBevel;
    Label16: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label54: TLabel;
    Label10: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    mmName: TMemo;
    edRegNum: TEdit;
    dtRegDate: TdxDateEdit;
    edINN: TEdit;
    edOKPO: TEdit;
    btnShowCommon: TButton;
    cbOKATO1: TdxPopupEdit;
    edUAddr: TEdit;
    btnShowContacts: TButton;
    edOKONH: TEdit;
    edOCCUPATION: TEdit;
    edOKBV: TEdit;
    dtFirst: TdxDateEdit;
    dtLast: TdxDateEdit;
    chkHasBron: TCheckBox;
    cbForm6Shifr: TdxPickEdit;
    edVUR: TEdit;
    edPhone: TEdit;
    cbOKFS: TdxPickEdit;
    cbOKOPF: TdxPickEdit;
    edOKOGU: TEdit;
    btnShowOKONH: TButton;
    btnPerList: TButton;
    dtConf: TdxDateEdit;
    btnForm6: TButton;
    cbKTerr: TdxPopupEdit;
    btnBronDol: TButton;
    edFeature1: TEdit;
    edFeature2: TEdit;
    edFeature3: TEdit;
    dxpOVK: TdxMRUEdit;
    btnVUZOnly: TButton;
    cbOKTMO: TdxPopupEdit;
    cbOKTMO2: TdxPopupEdit;
    cbOKATO2: TdxPopupEdit;
    edFAddr: TEdit;
    eRegplace: TEdit;
    Panel1: TPanel;
    btnCancel: TButton;
    btnApply: TButton;
    mAsdnrAttest: TdxMemData;
    mAsdnrMade: TdxMemData;
    mBuildings: TdxMemData;
    mAsdnrAttestAsf_Id: TIntegerField;
    mAsdnrAttestWho_Attest: TStringField;
    mAsdnrMadeContent: TStringField;
    mAsdnrMadeDate_Begin: TDateField;
    mAsdnrMadeDate_End: TDateField;
    mAsdnrAttestWhen_Attest: TDateField;
    mBuildingsNaim: TStringField;
    mBuildingsPurpose: TStringField;
    mBuildingsArea: TStringField;
    mBuildingsComment: TStringField;
    dsAsdnrAttest: TDataSource;
    dsAsdnrMade: TDataSource;
    dsBuildings: TDataSource;
    Panel2: TPanel;
    cbASFGround: TdxPickEdit;
    Label15: TLabel;
    KASDNR: TADOQuery;
    KASDNRID: TIntegerField;
    KASDNRName: TWideStringField;
    mAsdnrAttestAsdnr_Id: TIntegerField;
    mAsdnrMadeAsdnr_Id: TIntegerField;
    mAsdnrAttestAsdnr: TStringField;
    qASF: TADOQuery;
    qASFAsf_Id: TIntegerField;
    qASFName: TWideStringField;
    mAsdnrAttestAsf: TStringField;
    mAsdnrMadeAsndr: TStringField;
    dxBarDBNavigator1: TdxBarDBNavigator;
    dxBarManager1: TdxBarManager;
    dxBarDBNavInsert1: TdxBarDBNavButton;
    dxBarDBNavDelete1: TdxBarDBNavButton;
    dxBarManager1Bar1: TdxBar;
    dxBarDockControl1: TdxBarDockControl;
    dxBarDBNavigator2: TdxBarDBNavigator;
    dxBarDBNavInsert2: TdxBarDBNavButton;
    dxBarDBNavDelete2: TdxBarDBNavButton;
    dxBarDBNavPost2: TdxBarDBNavButton;
    dxBarDBNavEdit1: TdxBarDBNavButton;
    dxBarDBNavEdit2: TdxBarDBNavButton;
    dxBarDockControl2: TdxBarDockControl;
    dxBarManager1Bar2: TdxBar;
    dxBarDBNavigator3: TdxBarDBNavigator;
    dxBarDBNavInsert3: TdxBarDBNavButton;
    dxBarDBNavDelete3: TdxBarDBNavButton;
    dxBarDBNavEdit3: TdxBarDBNavButton;
    dxBarDBNavPost3: TdxBarDBNavButton;
    dxBarManager1Bar3: TdxBar;
    dxBarDockControl3: TdxBarDockControl;
    dxBarDBNavPost1: TdxBarDBNavButton;
    dxBarDBNavCancel1: TdxBarDBNavButton;
    dxBarDBNavCancel2: TdxBarDBNavButton;
    dxBarDBNavCancel3: TdxBarDBNavButton;
    Bevel1: TBevel;
    Label37: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Bevel6: TBevel;
    edFam3: TEdit;
    edOtch3: TEdit;
    edIm3: TEdit;
    edPost3: TEdit;
    edPhone3: TEdit;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    dxDBGrid1: TdxDBGrid;
    dxDBGrid1RecId: TdxDBGridColumn;
    dxDBGrid1Asdnr: TdxDBGridLookupColumn;
    dxDBGrid1Asf: TdxDBGridLookupColumn;
    dxDBGrid1Who_Attest: TdxDBGridMaskColumn;
    dxDBGrid1When_Attest: TdxDBGridDateColumn;
    dxDBGrid1Asdnr_Id: TdxDBGridMaskColumn;
    dxDBGrid1Asf_Id: TdxDBGridMaskColumn;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    dxDBGrid3: TdxDBGrid;
    dxDBGrid3RecId: TdxDBGridColumn;
    dxDBGrid3Asdnr_Id: TdxDBGridMaskColumn;
    dxDBGrid3Asndr: TdxDBGridLookupColumn;
    dxDBGrid3Content: TdxDBGridMaskColumn;
    dxDBGrid3Date_Begin: TdxDBGridDateColumn;
    dxDBGrid3Date_End: TdxDBGridDateColumn;
    dxDBGrid2: TdxDBGrid;
    dxDBGrid2RecId: TdxDBGridColumn;
    dxDBGrid2Naim: TdxDBGridMaskColumn;
    dxDBGrid2Purpose: TdxDBGridMaskColumn;
    dxDBGrid2Area: TdxDBGridMaskColumn;
    dxDBGrid2Comment: TdxDBGridMaskColumn;
    dxBarDBNavigator4: TdxBarDBNavigator;
    dsAHOV: TDataSource;
    mAHOV: TdxMemData;
    mAHOVAHOV_Naim: TStringField;
    mAHOVAHOV_Amount: TStringField;
    dxBarDockControl4: TdxBarDockControl;
    dxBarManager1Bar4: TdxBar;
    dxBarDBNavInsert4: TdxBarDBNavButton;
    dxBarDBNavDelete4: TdxBarDBNavButton;
    dxBarDBNavEdit4: TdxBarDBNavButton;
    dxBarDBNavPost4: TdxBarDBNavButton;
    dxBarDBNavCancel4: TdxBarDBNavButton;
    dxDBGrid4: TdxDBGrid;
    dxDBGrid4RecId: TdxDBGridColumn;
    dxDBGrid4AHOV_Naim: TdxDBGridMaskColumn;
    dxDBGrid4AHOV_Amount: TdxDBGridMaskColumn;
    cbASFType: TdxPickEdit;
    Label42: TLabel;
    eSBM: TEdit;
    bVoenkom: TButton;
    procedure dxpOVKButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure mmNameChange(Sender: TObject);
    procedure edOKPOKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edOKONHKeyPress(Sender: TObject; var Key: Char);
    procedure chkHasBronClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbKONHExit(Sender: TObject);
    procedure btnShowCommonClick(Sender: TObject);
    procedure btnShowContactsClick(Sender: TObject);
    procedure btnPerListClick(Sender: TObject);
    procedure cbOKATO1Popup(Sender: TObject; const EditText: String);
    procedure cbOKATO1CloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure dxtOKATODblClick(Sender: TObject);
    procedure btnShowOKONHClick(Sender: TObject);
    procedure cbOKFSChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnForm6Click(Sender: TObject);
    procedure dxtKTerrDblClick(Sender: TObject);
    procedure cbKTerrPopup(Sender: TObject; const EditText: String);
    procedure cbKTerrCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure cbKTerrExit(Sender: TObject);
    procedure btnBronDolClick(Sender: TObject);
    procedure btnVUZOnlyClick(Sender: TObject);
    procedure mAsdnrAttestAfterPost(DataSet: TDataSet);
    procedure dxDBGrid1ChangedColumnsWidth(Sender: TObject);
    procedure dxDBGrid3ChangedColumnsWidth(Sender: TObject);
    procedure bVoenkomClick(Sender: TObject);
  private
    FCommon: TfmOrgPropCommon;
    FContacts: TfmOrgPropContacts;
    FVoenkom: TfmOrgPropVoenkom;
    FOsnPer: TfmOrgPropOsnPer;
    FOKONHList: TfmOrgPropOKONH;
    FVUZOnly: TfmOrgVUZOnly;
    procedure FLoadData;
    function FStoreData: boolean;
    procedure SetOKATOList;
    procedure SetOKTMOList;
    procedure LocateOKATO(Sender: TdxTreeList; Value: string);
    procedure SetKTerrList;
    function LocateKTerr(Value: string): boolean;
    procedure UpdateForm6;
    function GetTerrCode(TerrId: Integer): string;
    procedure LoadStrings(Items: TStrings; HasEmpty: boolean;
                        sSQL,FldID,FldData: string);
    procedure LoadStrings1(AList: TStrings; ASQL: string; FHasNull: boolean=true);
    function GetOkonhText(OkonhList, MainOkonh: String): String;

  public
    FId: Integer;
  end;

  procedure ShowOrgCard;

implementation

uses Math, dMain, msg, StrUtils, dxTLClms, Rdialogs, IniSupport, misc,
  fTPDP, fBaseLst;

{$R *.dfm}
procedure ShowOrgCard;
(*var n: Integer;
    F: TfmOrgProp;
begin
  F := nil;
  for n:=0 to Application.MainForm.MDIChildCount-1 do
    if Application.MainForm.MDIChildren[n] is TfmOrgProp then begin
        F := Application.MainForm.MDIChildren[n] as TfmOrgProp;
        break;
      end;
  if F=nil then begin
    F := TfmOrgProp.Create(Application);
    F.FLoadData;
  end;
  if IsIconic(F.Handle) then ShowWindow(F.Handle,SW_RESTORE);
  F.BringToFront;*)
begin
  with TfmOrgProp.Create(Application) do
  try FLoadData; ShowModal;
  finally Free;
  end;
end;


procedure TfmOrgProp.LoadStrings1(AList: TStrings; ASQL: string; FHasNull: boolean=true);
begin
  AList.Clear;
  if FHasNull then
    AList.AddObject('<не указано>',nil);
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := ASQL;
    Open;
    while not EOF do begin
      AList.AddObject(Fields[1].AsString+' - '+Fields[2].AsString,Pointer(Fields[0].AsInteger));
      Next;
    end;
  finally
    Free;
  end;
end;


procedure TfmOrgProp.FormCreate(Sender: TObject);
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select min(OrgId) from Org';
    Open;
    FId := Fields[0].AsInteger;
  finally
    Free;
  end;

//create extended forms
  FCommon := TfmOrgPropCommon.Create(Application);
  FCommon.FOrgProp := Self;
  FCommon.cbOKATO1.PopupControl := dxtOKATO;
  FCommon.cbOKATO1.OnPopup := cbOKATO1.OnPopup;
  FCommon.cbOKATO1.OnCloseUp := cbOKATO1.OnCloseUp;
  FCommon.cbOKATO2.PopupControl := dxtOKATO;
  FCommon.cbOKATO2.OnPopup := cbOKATO1.OnPopup;
  FCommon.cbOKATO2.OnCloseUp := cbOKATO1.OnCloseUp;
  FCommon.cbOKATO3.PopupControl := dxtOKATO;
  FCommon.cbOKATO3.OnPopup := cbOKATO1.OnPopup;
  FCommon.cbOKATO3.OnCloseUp := cbOKATO1.OnCloseUp;
  FOKONHList := TfmOrgPropOKONH.Create(Application);
  FOKONHList.FOrgProp := Self;
  FContacts := TfmOrgPropContacts.Create(Application);
  FContacts.FOrgProp := Self;
  FVoenkom := TfmOrgPropVoenkom.Create(Application);
  FVoenkom.FOrgProp := Self;
  FOsnPer := TfmOrgPropOsnPer.Create(Application);
  FOsnPer.FOrgProp := Self;
  FVUZOnly := TfmOrgVUZOnly.Create(Application);
  FVUZOnly.FOrgProp := Self;
//init form
  try
    KASDNR.Open;
    qASF.Open;

    LoadStrings1(cbOKFS.Items,'select FS_ID, KOD, FS_NAME from KFS ORDER BY KOD');
    cbOKFS.ItemIndex := 0;
    LoadStrings1(cbASFGround.Items,'select ID, ID as kod, NAME from KASFGround ORDER BY ID', False);
    cbASFGround.ItemIndex := 0;
    cbASFType.ItemIndex := 0;
    LoadStrings1(cbOKOPF.Items,'select KOPF_ID, KOD, KOPF_NAME from KOPF ORDER BY KOD');
    cbOKOPF.ItemIndex := 0;
    LoadStrings1(FOsnPer.colBASE_ID.Items,'SELECT ID, KOD, NAME FROM VV3 ORDER BY KOD');
    LoadStrings1(FOsnPer.colDOC_ID.Items,'SELECT ID, KOD, NAME FROM VV4 ORDER BY KOD');
    SetOKATOList;
    SetOKTMOList;
    SetKTerrList;
    Self.LoadStrings(dxpOVK.Items,false,'SELECT * FROM KOVK ORDER BY OVK_NAME','OVK_ID','OVK_NAME');
  except
    on E: Exception do
      ShowErr('Ошибка при загрузке базовых справочников!'#13#13+E.Message);
  end;
  cbForm6Shifr.ItemIndex := 0;
  btnApply.Enabled := false;
  //rEdit
  mmName.Enabled       := dmMain.rEdit;
  edRegNum.Enabled     := dmMain.rEdit;
  dtRegDate.Enabled    := dmMain.rEdit;
  eRegPlace.Enabled    := dmMain.rEdit;
  cbOKATO1.Enabled     := dmMain.rEdit;
  cbOKATO2.Enabled     := dmMain.rEdit;
  cbOKTMO.Enabled     := dmMain.rEdit;
  cbOKTMO2.Enabled     := dmMain.rEdit;
  edINN.Enabled        := dmMain.rEdit;
  edOKPO.Enabled       := dmMain.rEdit;
  edUAddr.Enabled      := dmMain.rEdit;
  edFAddr.Enabled      := dmMain.rEdit;
  edVUR.Enabled        := dmMain.rEdit;
  edPhone.Enabled      := dmMain.rEdit;
  edOKONH.Enabled      := dmMain.rEdit;
  edOCCUPATION.Enabled := dmMain.rEdit;
  cbOKFS.Enabled       := dmMain.rEdit;
  cbASFGround.Enabled  := dmMain.rEdit;
  cbASFType.Enabled    := dmMain.rEdit;
  cbOKOPF.Enabled      := dmMain.rEdit;
  edOKOGU.Enabled      := dmMain.rEdit;
  edOKBV.Enabled       := dmMain.rEdit;
  dtFirst.Enabled      := dmMain.rEdit;
  dtLast.Enabled       := dmMain.rEdit;
  dxpOVK.Enabled       := dmMain.rEdit;
  cbForm6Shifr.Enabled := dmMain.rEdit;
  eSBM.Enabled         := dmMain.rEdit;
  cbKTerr.Enabled      := dmMain.rEdit;
  dtConf.Enabled       := dmMain.rEdit;
  chkHasBron.Enabled   := dmMain.rEdit;
  edFeature1.Enabled   := dmMain.rEdit;
  edFeature2.Enabled   := dmMain.rEdit;
  edFeature3.Enabled   := dmMain.rEdit;
  btnApply.Visible     := dmMain.rEdit;
  edFam3.Enabled   := dmMain.rEdit;
  edIm3.Enabled    := dmMain.rEdit;
  edOtch3.Enabled  := dmMain.rEdit;
  edPhone3.Enabled := dmMain.rEdit;
  edPost3.Enabled  := dmMain.rEdit;
  if not dmMain.rEdit then btnCancel.Caption := 'Закрыть';

  dxDBGrid1ChangedColumnsWidth(Sender);
  dxDBGrid3ChangedColumnsWidth(Sender);
end;

procedure TfmOrgProp.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#27 then Close;
end;

procedure TfmOrgProp.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not btnApply.Enabled or Confirm(
          'Сведения об организации не сохранены!'#13+
          'Выйти из карточки без сохранения данных?');
end;

procedure TfmOrgProp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FCommon);
  FreeAndNil(FContacts);
  FreeAndNil(FVoenkom);
  FreeAndNil(FOsnPer);
  FreeAndNil(FOKONHList);
  FreeAndNil(FVUZOnly);
//  Action := caFree;
end;

procedure TfmOrgProp.mAsdnrAttestAfterPost(DataSet: TDataSet);
begin
  btnApply.Enabled := true;
end;

procedure TfmOrgProp.mmNameChange(Sender: TObject);
begin
  btnApply.Enabled := true;
end;

procedure TfmOrgProp.edOKPOKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9']) then Key := #0;
end;

procedure TfmOrgProp.edOKONHKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9','.',',']) then Key := #0
  else
    if Key=',' then Key := '.';
end;

procedure TfmOrgProp.chkHasBronClick(Sender: TObject);
begin
//recalc OKBV
  mmName.OnChange(Self);
end;

procedure TfmOrgProp.FLoadData;
var
  i: Integer;
  fld: TField;

  procedure SetFeature(cb: TdxPickEdit; Value: Integer);
  var I: Integer;
  begin
    for I := 1 to cb.Items.Count-1 do //0-<NULL>
    if Integer(cb.Items.Objects[I])=Value then begin
      cb.ItemIndex := I; Break;
    end;
  end;

begin
  if FId=0 then Exit;
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select * from ORG where OrgId='+IntToStr(FId);
    Open;
    if IsEmpty then begin
      ShowErr('Требуемая запись не найдена!'#13'Возможно она была удалена другим пользователем...');
      Exit;
    end;
    mmName.Text := FieldByName('OrgName').AsString;
    edRegNum.Text := FieldByName('RegNum').AsString;
    with FieldByName('RegDate') do
      if IsNull then dtRegDate.Text := EmptyStr
      else dtRegDate.Date := Value;
    eRegPlace          .Text := FieldByName('REGPLACE').AsString;
    edINN              .Text := FieldByName('INN').AsString;
    edOKPO             .Text := FieldByName('OKPO').AsString;
    edUAddr            .Text := FieldByName('UrAddr').AsString;
    edFAddr            .Text := FieldByName('FizAddr').AsString;
    cbOKATO1           .Text := FieldByName('KodReg').AsString;
    cbOKATO2           .Text := FieldByName('OKATO2').AsString;
    cbOKTMO            .Text := FieldByName('KodOktmo').AsString;
    cbOKTMO2           .Text := FieldByName('KodOktmo2').AsString;
    FCommon.eComputers.Value := FieldByName('Computers').AsInteger;
    FCommon.eSoftwareNum.Value := FieldByName('SoftwareNum').AsInteger;
    FCommon.eKpis.Value      := FieldByName('Kpis').AsInteger;
    FCommon.eComputersS.Value := FieldByName('ComputersS').AsInteger;
    FCommon.eSoftwareNumS.Value := FieldByName('SoftwareNumS').AsInteger;
    FCommon.eKpisS.Value     := FieldByName('KpisS').AsInteger;
    FCommon.eSoftware  .Text := FieldByName('Software').AsString;
    FCommon.edSName    .Text := FieldByName('OrgSName').AsString;
    FCommon.edParent   .Text := FieldByName('Parent').AsString;
    FCommon.edPhone    .Text := FieldByName('Phone').AsString;
    FCommon.edEmail    .Text := FieldByName('Email').AsString;
    FCommon.edWww      .Text := FieldByName('Www').AsString;
    FCommon.edFax      .Text := FieldByName('Fax').AsString;
    FCommon.edFactAddr .Text := FieldByName('FizAddr').AsString;
    FCommon.cbOKATO2   .Text := FieldByName('OKATO2').AsString;
    FCommon.edPostAddr .Text := FieldByName('PostAddr').AsString;
    FCommon.cbOKATO3   .Text := FieldByName('OKATO3').AsString;
    FCommon.mmComments .Text := FieldByName('Comment').AsString;
    edOKONH            .Text := FieldByName('MAINOKONH').AsString;
    FOKONHList.mmOKONH .Text := GetOkonhText(
      StringReplace(FieldByName('OKONH').AsString,',',', ',[rfReplaceAll]),
      FieldByName('MAINOKONH').AsString);
    edOccupation.Text := FieldByName('Occupation').AsString;
    cbOKFS.ItemIndex := cbOKFS.Items.IndexOfObject(Pointer(FieldByName('FS_ID').AsInteger));
    cbOKFS.OnExit(cbOKFS);
    cbASFGround.ItemIndex := cbASFGround.Items.IndexOfObject(Pointer(FieldByName('ASFGround_ID').AsInteger));
    cbASFGround.OnExit(cbASFGround);
    cbASFType.ItemIndex := FieldByName('ASFType_ID').AsInteger;
    cbASFType.OnExit(cbASFType);
    cbOKOPF.ItemIndex := cbOKOPF.Items.IndexOfObject(Pointer(FieldByName('KOPF_ID').AsInteger));
    cbOKOPF.OnExit(cbOKOPF);
    edOKOGU            .Text := FieldByName('SOOGU').AsString;
    edOKBV             .Text := FieldByName('OKBV').AsString;
    with FieldByName('First_Date') do
      if IsNull then dtFirst.Text := EmptyStr
      else dtFirst.Date := Value;
    with FieldByName('Last_Date') do
      if IsNull then dtLast.Text := EmptyStr
      else dtLast.Date := Value;
    chkHasBron.Checked := FieldByName('Has_Bron').AsBoolean;
    dxpOVK.ItemIndex := dxpOVK.Items.IndexOfObject(TObject(FieldByName('OVK_ID').AsInteger));
    if dxpOVK.ItemIndex>=0 then dxpOVK.Text := dxpOVK.Items[dxpOVK.ItemIndex];
    cbForm6Shifr.ItemIndex := cbForm6Shifr.Items.IndexOf(FieldByName('F6_Shifr').AsString);
    cbForm6Shifr.OnExit(cbForm6Shifr);
    eSBM.Text := FieldByName('SBM').AsString;
    cbKTerr.Text := GetTerrCode(FieldByName('Terr_Id').AsInteger);
    cbKTerr.OnExit(cbKTerr);
    edFeature1         .Text := FieldByName('Feature1').AsString;
    edFeature2         .Text := FieldByName('Feature2').AsString;
    edFeature3         .Text := FieldByName('Feature3').AsString;
    with FieldByName('ConfDate') do
      if IsNull then dtConf.Text := EmptyStr
      else dtConf.Date := Value;

    // Только для ВУЗов
    FVUZOnly.edLicense1.Text := FieldByName('License1').AsString;
    with FieldByName('License1_date') do
      if IsNull then FVUZOnly.dtLicense1.Text := EmptyStr
      else FVUZOnly.dtLicense1.Date := Value;
    FVUZOnly.edLicense1Who.Text := FieldByName('License1Who').AsString;
    FVUZOnly.edLicense2.Text := FieldByName('License2').AsString;
    with FieldByName('License2_date') do
      if IsNull then FVUZOnly.dtLicense2.Text := EmptyStr
      else FVUZOnly.dtLicense2.Date := Value;
    FVUZOnly.edLicense2Who.Text := FieldByName('License2Who').AsString;
    FVUZOnly.edCertificate.Text := FieldByName('Certificate').AsString;
    with FieldByName('BeginCertificate_date') do
      if IsNull then FVUZOnly.dtBeginCertificate.Text := EmptyStr
      else FVUZOnly.dtBeginCertificate.Date := Value;
    with FieldByName('EndCertificate_date') do
      if IsNull then FVUZOnly.dtEndCertificate.Text := EmptyStr
      else FVUZOnly.dtEndCertificate.Date := Value;
    FVUZOnly.edCertificateWho.Text := FieldByName('CertificateWho').AsString;
    FVUZOnly.edWhoPuts.Text := FieldByName('WhoPuts').AsString;
    with FieldByName('HasVK') do
      if IsNull then FVUZOnly.cbHasVK.ItemIndex := 0
      else FVUZOnly.cbHasVK.ItemIndex := Abs(Integer(Value));
    FVUZOnly.edVKChief.Text := FieldByName('VKChief').AsString;
    FVUZOnly.peVKChiefRange.ItemIndex :=
      FVUZOnly.peVKChiefRange.Items.IndexOfObject(TObject(FieldByName('VKChiefRange').AsInteger));
    FVUZOnly.cbHasVKChange(nil);

    FVoenkom.edFam1   .Text := FieldByName('Voenkom1F').AsString;
    FVoenkom.edIm1    .Text := FieldByName('Voenkom1I').AsString;
    FVoenkom.edOtch1  .Text := FieldByName('Voenkom1O').AsString;
    FVoenkom.edFam2   .Text := FieldByName('Voenkom2F').AsString;
    FVoenkom.edIm2    .Text := FieldByName('Voenkom2I').AsString;
    FVoenkom.edOtch2  .Text := FieldByName('Voenkom2O').AsString;

    ///////////////////

    Close;
    SQL.Text := 'select * from ORG_CONT where OrgId='+IntToStr(FId);
    Open;
    if Locate('is_gen',1,[]) then begin
      FContacts.edFam1   .Text := FieldByName('Fam').AsString;
      FContacts.edIm1    .Text := FieldByName('Im').AsString;
      FContacts.edOtch1  .Text := FieldByName('Otch').AsString;
      FContacts.edPhone1 .Text := FieldByName('Phone').AsString;
      FContacts.edPost1  .Text := FieldByName('Post').AsString;
    end
    else begin
      FContacts.edFam1   .Text := EmptyStr;
      FContacts.edIm1    .Text := EmptyStr;
      FContacts.edOtch1  .Text := EmptyStr;
      FContacts.edPhone1 .Text := EmptyStr;
      FContacts.edPost1  .Text := EmptyStr;
    end;
    if Locate('is_gen',2,[]) then begin
      edFam3   .Text := FieldByName('Fam').AsString;
      edIm3    .Text := FieldByName('Im').AsString;
      edOtch3  .Text := FieldByName('Otch').AsString;
      edPhone3 .Text := FieldByName('Phone').AsString;
      edPost3  .Text := FieldByName('Post').AsString;
    end
    else begin
      edFam3   .Text := EmptyStr;
      edIm3    .Text := EmptyStr;
      edOtch3  .Text := EmptyStr;
      edPhone3 .Text := EmptyStr;
      edPost3  .Text := EmptyStr;
    end;
    if Locate('is_vus',1,[]) then begin
      FContacts.edFam2   .Text := FieldByName('Fam').AsString;
      FContacts.edIm2    .Text := FieldByName('Im').AsString;
      FContacts.edOtch2  .Text := FieldByName('Otch').AsString;
      FContacts.edPhone2 .Text := FieldByName('Phone').AsString;
      FContacts.edPost2  .Text := FieldByName('Post').AsString;
    end
    else begin
      FContacts.edFam2   .Text := EmptyStr;
      FContacts.edIm2    .Text := EmptyStr;
      FContacts.edOtch2  .Text := EmptyStr;
      FContacts.edPhone2 .Text := EmptyStr;
      FContacts.edPost2  .Text := EmptyStr;
    end;
    if Locate('is_gen',3,[]) then begin
      FContacts.edFam3   .Text := FieldByName('Fam').AsString;
      FContacts.edIm3    .Text := FieldByName('Im').AsString;
      FContacts.edOtch3  .Text := FieldByName('Otch').AsString;
      FContacts.edPhone3 .Text := FieldByName('Phone').AsString;
      FContacts.edPost3  .Text := FieldByName('Post').AsString;
    end
    else begin
      FContacts.edFam3   .Text := EmptyStr;
      FContacts.edIm3    .Text := EmptyStr;
      FContacts.edOtch3  .Text := EmptyStr;
      FContacts.edPhone3 .Text := EmptyStr;
      FContacts.edPost3  .Text := EmptyStr;
    end;
    edVUR.Text :=
      FContacts.edFam2   .Text+' '+
      FContacts.edIm2    .Text+' '+
      FContacts.edOtch2  .Text;
    edPhone.Text := FContacts.edPhone2.Text;
    Close;
    FOsnPer.dxtOSN.ClearNodes;
    SQL.Text := 'select * from OSN';
    Open;
    while not EOF do begin
      with FOsnPer.dxtOSN.Add do begin
        Values[FOsnPer.colBASE_ID.Index] :=
          FOsnPer.colBASE_ID.Items[FOsnPer.colBASE_ID.Items.IndexOfObject(Pointer(FieldByName('base_id').AsInteger))];
        Values[FOsnPer.colDOC_ID.Index] :=
          FOsnPer.colDOC_ID.Items[FOsnPer.colDOC_ID.Items.IndexOfObject(Pointer(FieldByName('doc_id').AsInteger))];
        Values[FOsnPer.colDOC_NO.Index] := FieldByName('doc_no').Value;
        Values[FOsnPer.colDOC_DATE.Index] := FieldByName('doc_date').Value;
      end;
      Next;
    end;
    if FOsnPer.dxtOSN.Count>0 then
      FOsnPer.dxtOSN.Items[0].Focused := true;
    Close;

    mAsdnrAttest.Open;
    SQL.Text := 'Select * From Org_Asdnr_Attest';
    Open;
    while not Eof do begin
      mAsdnrAttest.Append;
      for i := 1 to Fields.Count - 1 do begin
        fld := mAsdnrAttest.FindField(Fields[i].FieldName);
        if Assigned(fld) then
          fld.Value := Fields[i].Value;
      end;
      mAsdnrAttest.Post;

      Next;
    end;
    Close;
    mAsdnrMade.Open;
    SQL.Text := 'Select * From Org_Asdnr_Made';
    Open;
    while not Eof do begin
      mAsdnrMade.Append;
      for i := 1 to Fields.Count - 1 do begin
        fld := mAsdnrMade.FindField(Fields[i].FieldName);
        if Assigned(fld) then
          fld.Value := Fields[i].Value;
      end;
      mAsdnrMade.Post;

      Next;
    end;
    Close;
    mBuildings.Open;
    SQL.Text := 'Select * From Org_Buildings';
    Open;
    while not Eof do begin
      mBuildings.Append;
      for i := 1 to Fields.Count - 1 do begin
        fld := mBuildings.FindField(Fields[i].FieldName);
        if Assigned(fld) then
          fld.Value := Fields[i].Value;
      end;
      mBuildings.Post;

      Next;
    end;
    Close;
    mAHOV.Open;
    SQL.Text := 'Select * From Org_AHOV';
    Open;
    while not Eof do begin
      mAHOV.Append;
      for i := 1 to Fields.Count - 1 do begin
        fld := mAHOV.FindField(Fields[i].FieldName);
        if Assigned(fld) then
          fld.Value := Fields[i].Value;
      end;
      mAHOV.Post;

      Next;
    end;
    Close;
  finally
    Free;
  end;
  btnApply.Enabled := false;
end;

procedure TfmOrgProp.cbKONHExit(Sender: TObject);
begin
//check item index
  if (Sender as TdxPickEdit).ItemIndex<0 then
    (Sender as TdxPickEdit).ItemIndex := 0;
end;

procedure TfmOrgProp.btnShowCommonClick(Sender: TObject);
begin
  FCommon.ShowModal;
end;

procedure TfmOrgProp.btnShowContactsClick(Sender: TObject);
begin
  FContacts.ShowModal;
end;

procedure TfmOrgProp.btnPerListClick(Sender: TObject);
begin
  FOsnPer.ShowModal;
end;

procedure TfmOrgProp.SetOKATOList;
var Codes: TStringList;
    n,k: Integer;
    tn: TdxTreeListNode;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select KODTERR, NAME from KTERR where IS_OKATO<>0';
    Open;
    Codes := TStringList.Create;
    Codes.Sorted := true;
    try
//fill and sort terr. codes
      First;
      while not EOF do begin
      if Codes.IndexOf(Fields[0].AsString)<0 then
        Codes.Add(Fields[0].AsString);
        Next;
      end;
//loading and find parent
      for n:=0 to Codes.Count-1 do begin
        tn := nil;
        for k := n-1 downto 0 do
          if SameValue(Codes[n],Codes[k]) then begin
            tn := TdxTreeListNode(Codes.Objects[k]);
            break;
          end;
        if tn=nil
          then tn := dxtOKATO.Add
          else tn := tn.AddChild;
        Codes.Objects[n] := tn;
        tn.Strings[0] := Codes[n];
        Locate(Fields[0].FieldName,Codes[n],[]);
        tn.Strings[1] := Fields[1].AsString;
      end;
    finally
      Codes.Free;
    end;
  finally
    Free;
  end;
  dxtOKATO.ApplyBestFit(dxtOKATOCode);
end;

procedure TfmOrgProp.SetOKTMOList;
  function SameValue(s_item,s_parent: string): boolean;
  var n,k: Integer;
  begin
    Result := false;
    for n := Length(s_parent) downto 1 do
      if s_parent[n]<>'0' then begin
        case n of
          0: k := 0;
          1,2  : k := 2;
          3,4,5: k := 5;
          6,7,8: k := 8;
        else
          k := 11;
        end;
        Result := LeftStr(s_parent,k)=LeftStr(s_item,k);
        break;
      end;
  end;
var Codes: TStringList;
    n,k: Integer;
    tn: TdxTreeListNode;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select KODOKTMO, NAME from KOKTMO';
    Open;
    Codes := TStringList.Create;
    Codes.Sorted := true;
    try
//fill and sort terr. codes
      First;
      while not EOF do begin
      if Codes.IndexOf(Fields[0].AsString)<0 then
        Codes.Add(Fields[0].AsString);
        Next;
      end;
//loading and find parent
      for n:=0 to Codes.Count-1 do begin
        tn := nil;
        for k := n-1 downto 0 do
          if SameValue(Codes[n],Codes[k]) then begin
            tn := TdxTreeListNode(Codes.Objects[k]);
            break;
          end;
        if tn=nil then
          tn := dxtOKTMO.Add
        else
          tn := tn.AddChild;
        Codes.Objects[n] := tn;
        tn.Strings[0] := Codes[n];
        Locate(Fields[0].FieldName,Codes[n],[]);
        tn.Strings[1] := Fields[1].AsString;
      end;
    finally
      Codes.Free;
    end;
  finally
    Free;
  end;
  dxtOKTMO.ApplyBestFit(dxtOKTMOCode);
end;

procedure TfmOrgProp.cbOKATO1Popup(Sender: TObject; const EditText: String);
begin
  LocateOKATO(((Sender as TdxPopupEdit).PopupControl as TdxTreeList), EditText)
end;

procedure TfmOrgProp.cbOKATO1CloseUp(Sender: TObject; var Text: String;
  var Accept: Boolean);
begin
  Text := ((Sender as TdxPopupEdit).PopupControl as TdxTreeList).FocusedNode.Strings[0];
  Accept := true;
end;

procedure TfmOrgProp.dxtOKATODblClick(Sender: TObject);
begin
  if Sender is TdxTreeList then (Sender as TdxTreeList).Parent.Hide
  else if Sender = mi1 then dxtOKTMO.Parent.Hide
  else dxtOKATO.Parent.Hide;
end;

procedure TfmOrgProp.LocateOKATO(Sender: TdxTreeList; Value: string);
  function FindNode(node: TdxTreeListNode): boolean;
  var n: Integer;
  begin
    Result := false;
    if node.Strings[0]=Value then begin
      node.Focused := true;
      node.MakeVisible;
      Result := true;
      Exit;
    end;
    for n:=0 to node.Count-1 do
      if node.Items[n].Strings[0]=Value then begin
        node.Items[n].Focused := true;
        node.Items[n].MakeVisible;
        Result := true;
        break;
      end
      else
        if FindNode(node.Items[n]) then begin
          Result := true;
          break;
        end;
  end;
var n: Integer;
begin
  for n:=0 to (Sender as TdxTreeList).Count-1 do
    if FindNode((Sender as TdxTreeList).Items[n]) then break;
  (Sender as TdxTreeList).ApplyBestFit((Sender as TdxTreeList).Columns[0]);
  (Sender as TdxTreeList).ApplyBestFit((Sender as TdxTreeList).Columns[1]);
end;

procedure TfmOrgProp.btnShowOKONHClick(Sender: TObject);
begin
  with btnShowOKONH.ClientToScreen(btnShowOKONH.ClientRect.BottomRight) do begin
    FOKONHList.Top := y;
    FOKONHList.Left := x-FOKONHList.Width;
  end;
  FOKONHList.mmOKONH.Text := GetOkonhText(FOKONHList.mmOKONH.Text, edOKONH.Text);
  FOKONHList.ShowModal;
end;

procedure TfmOrgProp.btnVUZOnlyClick(Sender: TObject);
begin
  FVUZOnly.ShowModal;
end;

procedure TfmOrgProp.bVoenkomClick(Sender: TObject);
begin
  FVoenkom.ShowModal;
end;

procedure TfmOrgProp.cbOKFSChange(Sender: TObject);
begin
  {if cbOKFS.ItemIndex>0 then
    case StrToInt('0'+Copy(cbOKFS.Text,1,2)) of
      10,11,12,17,30,31,40,41,42,43,49:
        cbVV5.ItemIndex := 1;
      13,14:
        cbVV5.ItemIndex := 2;
      15,16,18,19,20,22,34,35,50,51,52,53,54:
        cbVV5.ItemIndex := 4;
    end;}
  mmName.OnChange(Self);
end;

function TfmOrgProp.FStoreData: boolean;
  function NULLIF(Value1,Value2: Variant): Variant;
  begin
    if Value1=Value2 then Result := NULL else Result := Value1;
  end;
  function GetID(tbl,fld: string): Integer;
  begin
    with TADOQuery.Create(Self) do begin
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT MAX('+fld+')+1 FROM '+tbl;
      Open;
      if Fields[0].IsNull then Result := 1
      else Result := Fields[0].AsInteger;
      Free;
    end;
  end;

var n: Integer;
    s: string;
    i: Integer;
    fld: TField;
begin
  Result := false;
//check not null values
  if mmName.Text=EmptyStr then begin
    mmName.SetFocus;
    ShowErr('Не указано наименование организации!');
    Exit;
  end;
  if Trim(edINN.Text)=EmptyStr then begin
    edINN.SetFocus;
    ShowErr('Не указан ИНН!');
    Exit;
  end;
  if Trim(cbOKATO1.Text)=EmptyStr then begin
    cbOKATO1.SetFocus;
    ShowErr('Не указано ОКАТО!');
    Exit;
  end;
  if Trim(cbOKATO2.Text)=EmptyStr then begin
    cbOKATO2.SetFocus;
    ShowErr('Не указано ОКАТО (факт.)!');
    Exit;
  end;
  if Trim(cbOKTMO.Text)=EmptyStr then begin
    cbOKTMO.SetFocus;
    ShowErr('Не указано ОКТМО!');
    Exit;
  end;
  if Trim(edOKONH.Text)=EmptyStr then begin
    edOKONH.SetFocus;
    ShowErr('Не указан основной ОКВЭД!');
    Exit;
  end;
  if cbOKFS.ItemIndex<=0 then begin
    cbOKFS.SetFocus;
    ShowErr('Не задан ОКФС!');
    Exit;
  end;
  if Trim(dxpOVK.Text)=EmptyStr then begin
    dxpOVK.SetFocus;
    ShowErr('Не задан ОВК!');
    Exit;
  end;
  if cbForm6Shifr.ItemIndex<0 then begin
    cbForm6Shifr.SetFocus;
    ShowErr('Не задан Шифр формы № 6!');
    Exit;
  end;
  if Trim(cbKTerr.Text)=EmptyStr then begin
    cbKTerr.SetFocus;
    ShowErr('Не задана область курирования вышестоящего ВУО!');
    Exit;
  end;


  //HAS_BRON - Form6
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; paramCheck := false;
    SQL.Text := 'SELECT HAS_BRON FROM ORG WHERE ORGID='+IntToStr(FID);
    Open;
    if Fields[0].AsBoolean<>chkHasBron.Checked then begin
      Close;
      if chkHasBron.Checked then begin
        ShowInfo('ВНИМАНИЕ: Изменено значение флага "Ведёт бронирование"!'#13#13+
         'Организация, ведущая бронирование, отчитывается не формой №18,'+
         ' а более подробной формой №6 (по каждой категории работников отдельно).'
         {' Сейчас в форме №6 заполнена только строка 25. После внесения всех сведений'+
         ' в картотеку работников для правильного заполнения формы №6 зайдите в пункт'+
         ' "\Расчётные данные\по категориям персонала и отношению к воинской обязанности" и воспольуйтесь кнопкой'+
         ' "Расчёт по картотеке"(с изображением молнии).'});
      end
      else begin
        SQL.Text := 'SELECT * FROM PERSON WHERE WUCHET2_IsWork = 1 and ((W_DEND is null) or Year(W_DEND) >= Year(date())) and (OUT_ORD_NUMB is null)';
        Open;
        if IsEmpty then begin
          ShowInfo('ВНИМАНИЕ: Изменено значение флага "Ведёт бронирование"!'#13#13+
           'Организация, не ведущая бронирование, отчитывается не формой №6,'+
           ' а формой №18. Для правильного заполнения формы №18 зайдите в пункт'+
           ' "\Расчётные данные\по категориям персонала и отношению к воинской обязанности" и воспольуйтесь кнопкой'+
           ' "Расчёт по картотеке"(с изображением молнии).');
        end
        else begin
          ShowErr('ВНИМАНИЕ: Изменено значение флага "Ведёт бронирование"!'#13#13+
           'В картотеке пристутсвуют забронированные работники. Для снятия флага '+
           ' "Ведёт бронирование" исправьте данные в картотеке работников.');
          chkHasBron.Checked := True;
          Exit;
        end;
        Close;
      end;
    end;
  finally Free;
  end;

//refresh VUR info
  FContacts.OnShow(Self);
//refresh bron lists
  FOsnPer.OnShow(Self);
  try
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select * from ORG where OrgId='+IntToStr(FId);
      Open;
      if FId>0 then Edit else Append;
      FieldByName('Computers').AsInteger := FCommon.eComputers.Value;
      FieldByName('SoftwareNum').AsInteger := FCommon.eSoftwareNum.Value;
      FieldByName('Kpis').AsInteger := FCommon.eKpis.Value;
      FieldByName('ComputersS').AsInteger := FCommon.eComputersS.Value;
      FieldByName('SoftwareNumS').AsInteger := FCommon.eSoftwareNumS.Value;
      FieldByName('KpisS').AsInteger := FCommon.eKpisS.Value;
      FieldByName('Software').AsString := FCommon.eSoftware.Text;
      FieldByName('PARENT').Value := NULLIF(FCommon.edParent.Text,EmptyStr);
      FieldByName('FS_Id').Value := NULLIF(Integer(cbOKFS.Items.Objects[cbOKFS.ItemIndex]),0);
      FieldByName('ASFGround_Id').Value := NULLIF(Integer(cbASFGround.Items.Objects[cbASFGround.ItemIndex]),0);
      FieldByName('ASFType_Id').Value := NULLIF(cbASFType.ItemIndex,0);
      FieldByName('INN').Value := NULLIF(edINN.Text,EmptyStr);
      FieldByName('OKPO').Value := NULLIF(edOKPO.Text,EmptyStr);
      FieldByName('MAINOKONH').Value := NULLIF(edOKONH.Text,EmptyStr);
      with TStringList.Create do
      try
        Text := StringReplace(StringReplace(GetOkonhText(FOKONHList.mmOKONH.Text, edOKONH.Text),' ','',[rfReplaceAll]),',',#13,[rfReplaceAll]);
        FieldByName('OKONH').Value := NULLIF(CommaText,EmptyStr);
      finally
        Free;
      end;
      FieldByName('SOOGU').Value := NULLIF(edOKOGU.Text,EmptyStr);
      FieldByName('KOPF_ID').Value := NULLIF(Integer(cbOKOPF.Items.Objects[cbOKOPF.ItemIndex]),0);
      FieldByName('KODREG').Value := NULLIF(cbOKATO1.Text,EmptyStr);
      FieldByName('OKATO2').Value := NULLIF(cbOKATO2.Text,EmptyStr);
      FieldByName('KODOKTMO').Value := NULLIF(cbOKTMO.Text,EmptyStr);
      FieldByName('KODOKTMO2').Value := NULLIF(cbOKTMO2.Text,EmptyStr);
      if dtRegDate.Text=EmptyStr then
        FieldByName('REGDATE').Value := NULL
      else
        FieldByName('REGDATE').Value := dtRegDate.Date;
      FieldByName('REGNUM').Value := NULLIF(edRegNum.Text,EmptyStr);
      FieldByName('ORGNAME').Value := NULLIF(mmName.Text,EmptyStr);
      FieldByName('ORGSNAME').Value := NULLIF(FCommon.edSName.Text,EmptyStr);
      FieldByName('COMMENT').Value := NULLIF(FCommon.mmComments.Text,EmptyStr);
      FieldByName('URADDR').Value := NULLIF(edUAddr.Text,EmptyStr);
      FieldByName('FIZADDR').Value := NULLIF(edFAddr.Text,EmptyStr);
      FieldByName('POSTADDR').Value := NULLIF(FCommon.edPostAddr.Text,EmptyStr);
      FieldByName('PHONE').Value := NULLIF(FCommon.edPhone.Text,EmptyStr);
      FieldByName('Email').Value := NULLIF(FCommon.edEmail.Text,EmptyStr);
      FieldByName('Www').Value := NULLIF(FCommon.edWww.Text,EmptyStr);
      FieldByName('FAX').Value := NULLIF(FCommon.edFax.Text,EmptyStr);
      if dtConf.Text=EmptyStr then
        FieldByName('CONFDATE').Value := null
      else
        FieldByName('CONFDATE').Value := dtConf.Date;
      FieldByName('OKBV').Value := NULLIF(edOKBV.Text,EmptyStr);
      FieldByName('OCCUPATION').Value := NULLIF(edOccupation.Text,EmptyStr);
      if dtFirst.Text=EmptyStr then
        FieldByName('FIRST_DATE').Value := NULL
      else
        FieldByName('FIRST_DATE').Value := dtFirst.Date;
      if dtLast.Text=EmptyStr then
        FieldByName('LAST_DATE').Value := NULL
      else
        FieldByName('LAST_DATE').Value := dtLast.Date;
      FieldByName('SBM').Value := eSBM.Text;
      if LocateKTerr(cbKTErr.Text) then
        FieldByName('TERR_ID').Value := Integer(dxtKTerr.FocusedNode.Data)
      else
        FieldByName('TERR_ID').Value := NULL;
      FieldByName('HAS_BRON').Value := chkHasBron.Checked;

      if dxpOVK.ItemIndex>=0
      then
        FieldByName('OVK_ID').Value := Integer(dxpOVK.Items.Objects[dxpOVK.ItemIndex])
      else
        if Trim(dxpOVK.Text)=EmptyStr then FieldByName('OVK_ID').Value := NULL
        else
      //creating new record in KOVK
          with TADOTable.Create(Self) do begin
            Connection := dmMain.dbMain;
            TableName := 'KOVK';
            Open;
            Append;
            if FieldByName('OVK_ID').DataType<>ftAutoInc then
              FieldByName('OVK_ID').Value := GetID('KOVK','OVK_ID');
            FieldByName('OVK_NAME').Value := dxpOVK.Text;
            Post;
            FieldByName('OVK_ID').Value := FieldByName('OVK_ID').AsInteger;
            Free;
            dxpOVK.Items.AddObject(dxpOVK.Text,Pointer(FieldByName('OVK_ID').AsInteger));
            dxpOVK.ItemIndex := dxpOVK.Items.Count-1;
          end;

      FieldByName('F6_SHIFR').Value := NULLIF(cbForm6Shifr.Text,EmptyStr);
      FieldByName('REGPLACE').Value := NULLIF(eRegPlace.Text,EmptyStr);
      //FieldByName('OKATO2').Value := NULLIF(FCommon.cbOKATO2.Text,EmptyStr);
      FieldByName('OKATO3').Value := NULLIF(FCommon.cbOKATO3.Text,EmptyStr);
      FieldByName('Feature1').Value := NULLIF(edFeature1.Text,EmptyStr);
      FieldByName('Feature2').Value := NULLIF(edFeature2.Text,EmptyStr);
      FieldByName('Feature3').Value := NULLIF(edFeature3.Text,EmptyStr);

      // Только для ВУЗов
      FieldByName('License1').Value := NULLIF(FVUZOnly.edLicense1.Text,EmptyStr);
      if FVUZOnly.dtLicense1.Text = EmptyStr then
        FieldByName('License1_date').Value := NULL
      else
        FieldByName('License1_date').Value := FVUZOnly.dtLicense1.Date;
      FieldByName('License1Who').Value := NULLIF(FVUZOnly.edLicense1Who.Text,EmptyStr);
      FieldByName('License2').Value := NULLIF(FVUZOnly.edLicense2.Text,EmptyStr);
      if FVUZOnly.dtLicense2.Text = EmptyStr then
        FieldByName('License2_date').Value := NULL
      else
        FieldByName('License2_date').Value := FVUZOnly.dtLicense2.Date;
      FieldByName('License2Who').Value := NULLIF(FVUZOnly.edLicense2Who.Text,EmptyStr);
      FieldByName('Certificate').Value := NULLIF(FVUZOnly.edCertificate.Text,EmptyStr);
      if FVUZOnly.dtBeginCertificate.Text = EmptyStr then
        FieldByName('BeginCertificate_date').Value := NULL
      else
        FieldByName('BeginCertificate_date').Value := FVUZOnly.dtBeginCertificate.Date;
      if FVUZOnly.dtEndCertificate.Text = EmptyStr then
        FieldByName('EndCertificate_date').Value := NULL
      else
        FieldByName('EndCertificate_date').Value := FVUZOnly.dtEndCertificate.Date;
      FieldByName('CertificateWho').Value := NULLIF(FVUZOnly.edCertificateWho.Text,EmptyStr);
      FieldByName('WhoPuts').Value := NULLIF(FVUZOnly.edWhoPuts.Text,EmptyStr);
      if FVUZOnly.cbHasVK.ItemIndex < 0 then
        FieldByName('HasVK').Value := NULL
      else
        FieldByName('HasVK').Value := FVUZOnly.cbHasVK.ItemIndex;
      FieldByName('VKChief').Value := NULLIF(FVUZOnly.edVKChief.Text,EmptyStr);
      FieldByName('VKChiefRange').Value :=
        Integer(FVUZOnly.peVKChiefRange.Items.Objects[FVUZOnly.peVKChiefRange.ItemIndex]);

      FieldByName('Voenkom1F').Value := NULLIF(FVoenkom.edFam1.Text,EmptyStr);
      FieldByName('Voenkom1I').Value := NULLIF(FVoenkom.edIm1.Text,EmptyStr);
      FieldByName('Voenkom1O').Value := NULLIF(FVoenkom.edOtch1.Text,EmptyStr);
      FieldByName('Voenkom2F').Value := NULLIF(FVoenkom.edFam2.Text,EmptyStr);
      FieldByName('Voenkom2I').Value := NULLIF(FVoenkom.edIm2.Text,EmptyStr);
      FieldByName('Voenkom2O').Value := NULLIF(FVoenkom.edOtch2.Text,EmptyStr);
      ///////////////////

      Post;
      FId := FieldByName('OrgId').Value;
      UpdateForm6;
      Close;
      SQL.Text := 'delete from ORG_CONT where OrgId='+IntToStr(FId);
      ExecSQL;
      SQL.Text := 'select * from ORG_CONT where OrgId='+IntToStr(FId);
      Open;
      if (FContacts.edFam1.Text<>EmptyStr) or (FContacts.edIm1.Text<>EmptyStr) or
         (FContacts.edOtch1.Text<>EmptyStr) or (FContacts.edPhone1.Text<>EmptyStr) or
         (FContacts.edPost1.Text<>EmptyStr) then
      begin
        Append;
        FieldByName('ContId').Value := 1;
        FieldByName('OrgId').Value := FId;
        FieldByName('Fam').Value := NULLIF(FContacts.edFam1.Text,EmptyStr);
        FieldByName('Im').Value := NULLIF(FContacts.edIm1.Text,EmptyStr);
        FieldByName('Otch').Value := NULLIF(FContacts.edOtch1.Text,EmptyStr);
        FieldByName('FIO').Value := FContacts.edFam1.Text+' '+FContacts.edIm1.Text+' '+FContacts.edOtch1.Text;
        FieldByName('Phone').Value := NULLIF(FContacts.edPhone1.Text,EmptyStr);
        FieldByName('Post').Value := NULLIF(FContacts.edPost1.Text,EmptyStr);
        FieldByName('IS_GEN').Value := 1;
        FieldByName('IS_VUS').Value := 0;
        Post;
      end;
      if (FContacts.edFam2.Text<>EmptyStr) or (FContacts.edIm2.Text<>EmptyStr) or
         (FContacts.edOtch2.Text<>EmptyStr) or (FContacts.edPhone2.Text<>EmptyStr) or
         (FContacts.edPost2.Text<>EmptyStr) then
      begin
        Append;
        FieldByName('ContId').Value := 2;
        FieldByName('OrgId').Value := FId;
        FieldByName('Fam').Value := NULLIF(FContacts.edFam2.Text,EmptyStr);
        FieldByName('Im').Value := NULLIF(FContacts.edIm2.Text,EmptyStr);
        FieldByName('Otch').Value := NULLIF(FContacts.edOtch2.Text,EmptyStr);
        FieldByName('FIO').Value := FContacts.edFam2.Text+' '+FContacts.edIm2.Text+' '+FContacts.edOtch2.Text;
        FieldByName('Phone').Value := NULLIF(FContacts.edPhone2.Text,EmptyStr);
        FieldByName('Post').Value := NULLIF(FContacts.edPost2.Text,EmptyStr);
        FieldByName('IS_GEN').Value := 0;
        FieldByName('IS_VUS').Value := 1;
        Post;
      end;
      if (edFam3.Text<>EmptyStr) or (edIm3.Text<>EmptyStr) or
         (edOtch3.Text<>EmptyStr) or (edPhone3.Text<>EmptyStr) or
         (edPost3.Text<>EmptyStr) then
      begin
        Append;
        FieldByName('ContId').Value := 3;
        FieldByName('OrgId').Value := FId;
        FieldByName('Fam').Value := NULLIF(edFam3.Text,EmptyStr);
        FieldByName('Im').Value := NULLIF(edIm3.Text,EmptyStr);
        FieldByName('Otch').Value := NULLIF(edOtch3.Text,EmptyStr);
        FieldByName('FIO').Value := edFam3.Text+' '+edIm3.Text+' '+edOtch3.Text;
        FieldByName('Phone').Value := NULLIF(edPhone3.Text,EmptyStr);
        FieldByName('Post').Value := NULLIF(edPost3.Text,EmptyStr);
        FieldByName('IS_GEN').Value := 2;
        FieldByName('IS_VUS').Value := 0;
        Post;
      end;
      if (FContacts.edFam3.Text<>EmptyStr) or (FContacts.edIm3.Text<>EmptyStr) or
         (FContacts.edOtch3.Text<>EmptyStr) or (FContacts.edPhone3.Text<>EmptyStr) or
         (FContacts.edPost3.Text<>EmptyStr) then
      begin
        Append;
        FieldByName('ContId').Value := 4;
        FieldByName('OrgId').Value := FId;
        FieldByName('Fam').Value := NULLIF(FContacts.edFam3.Text,EmptyStr);
        FieldByName('Im').Value := NULLIF(FContacts.edIm3.Text,EmptyStr);
        FieldByName('Otch').Value := NULLIF(FContacts.edOtch3.Text,EmptyStr);
        FieldByName('FIO').Value := FContacts.edFam3.Text+' '+FContacts.edIm3.Text+' '+FContacts.edOtch3.Text;
        FieldByName('Phone').Value := NULLIF(FContacts.edPhone3.Text,EmptyStr);
        FieldByName('Post').Value := NULLIF(FContacts.edPost3.Text,EmptyStr);
        FieldByName('IS_GEN').Value := 3;
        FieldByName('IS_VUS').Value := 0;
        Post;
      end;
      Close;
      SQL.Text := 'delete from OSN';
      ExecSQL;
      SQL.Text := 'select * from OSN';
      Open;
      for n:=0 to FOsnPer.dxtOSN.Count-1 do begin
        Append;
        FieldByName('BASE_ID').Value :=
          NULLIF(Integer(FOsnPer.colBASE_ID.Items.Objects[FOsnPer.colBASE_ID.Items.IndexOf(FOsnPer.dxtOSN.Items[n].Strings[FOsnPer.colBASE_ID.Index])]),0);
        FieldByName('DOC_ID').Value :=
          NULLIF(Integer(FOsnPer.colDOC_ID.Items.Objects[FOsnPer.colDOC_ID.Items.IndexOf(FOsnPer.dxtOSN.Items[n].Strings[FOsnPer.colDOC_ID.Index])]),0);
        FieldByName('DOC_NO').Value := NULLIF(FOsnPer.dxtOSN.Items[n].Strings[FOsnPer.colDOC_NO.Index],EmptyStr);
        s := FOsnPer.dxtOSN.Items[n].Strings[FOsnPer.colDOC_DATE.Index];
        if s=EmptyStr then
          FieldByName('DOC_DATE').Value := NULL
        else
          FieldByName('DOC_DATE').Value := StrToDate(s);
        Post;
      end;
      Close;

      SQL.Text := 'Delete From Org_Asdnr_Attest';
      ExecSQL;
      mAsdnrAttest.First;
      SQL.Text := 'Select * From Org_Asdnr_Attest';
      Open;
      while not mAsdnrAttest.Eof do begin
        Append;
        for i := 1 to Fields.Count - 1 do begin
          fld := mAsdnrAttest.FindField(Fields[i].FieldName);
          if Assigned(fld) then
            Fields[i].Value := fld.Value;
        end;
        Post;

        mAsdnrAttest.Next;
      end;
      Close;
      SQL.Text := 'Delete From Org_Asdnr_Made';
      ExecSQL;
      mAsdnrMade.First;
      SQL.Text := 'Select * From Org_Asdnr_Made';
      Open;
      while not mAsdnrMade.Eof do begin
        Append;
        for i := 1 to Fields.Count - 1 do begin
          fld := mAsdnrMade.FindField(Fields[i].FieldName);
          if Assigned(fld) then
            Fields[i].Value := fld.Value;
        end;
        Post;

        mAsdnrMade.Next;
      end;
      Close;
      SQL.Text := 'Delete From Org_Buildings';
      ExecSQL;
      mAsdnrMade.First;
      SQL.Text := 'Select * From Org_Buildings';
      Open;
      while not mBuildings.Eof do begin
        Append;
        for i := 1 to Fields.Count - 1 do begin
          fld := mBuildings.FindField(Fields[i].FieldName);
          if Assigned(fld) then
            Fields[i].Value := fld.Value;
        end;
        Post;

        mBuildings.Next;
      end;
      Close;
      SQL.Text := 'Delete From Org_AHOV';
      ExecSQL;
      mAHOV.First;
      SQL.Text := 'Select * From Org_AHOV';
      Open;
      while not mAHOV.Eof do begin
        Append;
        for i := 1 to Fields.Count - 1 do begin
          fld := mAHOV.FindField(Fields[i].FieldName);
          if Assigned(fld) then
            Fields[i].Value := fld.Value;
        end;
        Post;

        mAHOV.Next;
      end;
      Close;

    finally
      Free;
    end;
    Result := true;
    btnApply.Enabled := false;
  except
    on E: Exception do
      ShowErr('Ошибка при сохранении сведений об организации!'#13#13+E.Message);
  end;
end;

procedure TfmOrgProp.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmOrgProp.btnApplyClick(Sender: TObject);
begin
  btnApply.SetFocus;
  mAsdnrAttest.CheckBrowseMode;
  mAsdnrMade.CheckBrowseMode;
  mBuildings.CheckBrowseMode;
  mAHOV.CheckBrowseMode;
  if FStoreData then Close;
end;

procedure TfmOrgProp.UpdateForm6;
begin
with TADOQuery.Create(Self) do begin
    Connection := dmMain.dbMain;
    if dmMain.GetF6Id > 0 then
      SQL.Text := 'UPDATE FORM6HDR '+
                  'SET ORGNAME = :ORGNAME, '+
                  'ORGID = :ORGID, '+
                  'F6_SHIFR = :F6SHIFR'
    else
      SQL.Text := 'INSERT INTO FORM6HDR (F6_ID, ORGID, ORGNAME, F6_SHIFR)'+
                  'VALUES (1, :ORGID, :ORGNAME, :F6SHIFR)';
    Parameters.ParseSQL(SQL.Text,true);
    Parameters.ParamByName('ORGID').Value := FId;
    Parameters.ParamByName('ORGNAME').Value := mmName.Text;
    if cbForm6Shifr.ItemIndex<0 then begin
      Parameters.ParamByName('F6SHIFR').Value := NULL;
      Parameters.ParamByName('F6SHIFR').DataType := ftString;
      Parameters.ParamByName('F6SHIFR').Size := 2;
    end
    else
      Parameters.ParamByName('F6SHIFR').Value := cbForm6Shifr.Text;
    ExecSQL;
    if dmMain.GetF6Id > 0 then
      SQL.Text := 'UPDATE FORM6HDR_2015 '+
                  'SET ORGNAME = :ORGNAME, '+
                  'ORGID = :ORGID, '+
                  'F6_SHIFR = :F6SHIFR'
    else
      SQL.Text := 'INSERT INTO FORM6HDR_2015 (F6_ID, ORGID, ORGNAME, F6_SHIFR)'+
                  'VALUES (1, :ORGID, :ORGNAME, :F6SHIFR)';
    Parameters.ParseSQL(SQL.Text,true);
    Parameters.ParamByName('ORGID').Value := FId;
    Parameters.ParamByName('ORGNAME').Value := mmName.Text;
    if cbForm6Shifr.ItemIndex<0 then begin
      Parameters.ParamByName('F6SHIFR').Value := NULL;
      Parameters.ParamByName('F6SHIFR').DataType := ftString;
      Parameters.ParamByName('F6SHIFR').Size := 2;
    end
    else
      Parameters.ParamByName('F6SHIFR').Value := cbForm6Shifr.Text;
    ExecSQL;
  end;
end;

procedure TfmOrgProp.btnForm6Click(Sender: TObject);
var
    fnExec: Pointer;
    hDll: THandle;
begin
//вызов формы 6
  hDll := LoadLibrary(PChar(IniSupport.GetPlugInsDir+'form6.dll'));
  if hDll=0 then ShowErr('Ошибка при загрузке модуля расчётной численности.')
  else begin
    fnExec := GetProcAddress(hDll,'PlugInExecForm');
    if fnExec=nil then ShowErr('Модуль расчётной численности имеет неверный формат.')
    else begin
        if dmMain.GetF6ID > 0 then begin
          TPlugInExecF6(fnExec)(Application.Handle,dmMain.dbMain.ConnectionObject,dmMain.GetF6ID);
          with TADOQuery.Create(Self) do
          try
            Connection := dmMain.dbMain;
            SQL.Text := 'select OKBV from ORG where OrgId='+IntToStr(FId);
            Open;
            edOKBV.Text := Fields[0].AsString;
            btnApply.Enabled := false;
          finally
            Free;
          end;
        end;
    end;
    FreeLibrary(hDll);
  end;
end;

procedure TfmOrgProp.dxDBGrid1ChangedColumnsWidth(Sender: TObject);
begin
  dxDBGrid1Asdnr.DropDownWidth := dxDBGrid1Asdnr.Width * 2;
  dxDBGrid1Asf.DropDownWidth := dxDBGrid1Asf.Width * 2;
end;

procedure TfmOrgProp.dxDBGrid3ChangedColumnsWidth(Sender: TObject);
begin
  dxDBGrid3Asndr.DropDownWidth := dxDBGrid3Asndr.Width * 2;
end;

procedure TfmOrgProp.dxpOVKButtonClick(Sender: TObject);
var S: String;
begin
  EditBaseLstModal(1);//KOVK
  S := dxpOVK.Text;
  LoadStrings(dxpOVK.Items,false,'SELECT * FROM KOVK ORDER BY OVK_NAME','OVK_ID','OVK_NAME');
  dxpOVK.ItemIndex := Max(dxpOVK.Items.IndexOf(S),0);
end;

procedure TfmOrgProp.dxtKTerrDblClick(Sender: TObject);
begin
  dxtKTerr.Parent.Hide;
end;

procedure TfmOrgProp.SetKTerrList;
var Codes: TStringList;
    n,k: Integer;
    tn: TdxTreeListNode;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select KODTERR, NAME, TERR_ID from KTERR';
    Open;
    Codes := TStringList.Create;
    Codes.Sorted := true;
    try
//fill and sort terr. codes
      First;
      while not EOF do begin
      if Codes.IndexOf(Fields[0].AsString)<0 then
        Codes.Add(Fields[0].AsString);
        Next;
      end;
//loading and find parent
      for n:=0 to Codes.Count-1 do begin
        tn := nil;
        for k := n-1 downto 0 do
          if SameValue(Codes[n],Codes[k]) then begin
            tn := TdxTreeListNode(Codes.Objects[k]);
            break;
          end;
        if tn=nil then
          tn := dxtKTerr.Add
        else
          tn := tn.AddChild;
        Codes.Objects[n] := tn;
        tn.Strings[0] := Codes[n];
        Locate(Fields[0].FieldName,Codes[n],[]);
        tn.Strings[1] := Fields[1].AsString;
        tn.Data := Pointer(Fields[2].AsInteger);
      end;
    finally
      Codes.Free;
    end;
  finally
    Free;
  end;
  dxtKTerr.ApplyBestFit(dxtKTerrCode);
end;

procedure TfmOrgProp.LoadStrings(Items: TStrings; HasEmpty: boolean;
                        sSQL,FldID,FldData: string);
var DataOnly: Boolean;
begin
  DataOnly := FldID = EmptyStr;
  with TADOQuery.Create(Self) do begin
    Items.Clear;
    if HasEmpty then Items.AddObject('<не указано>',nil);
    Connection := dmMain.dbMain;
    SQL.Text := sSQL;
    Open;
    while not EOF do begin
      if DataOnly
      then Items.Add(FieldByName(FldData).AsString)
      else Items.AddObject(
        FieldByName(FldData).AsString,
        Pointer(FieldByName(FldID).AsInteger));
      Next;
    end;
    Free;
  end;
end;

function TfmOrgProp.LocateKTerr(Value: string): boolean;
  function FindNode(node: TdxTreeListNode): boolean;
  var n: Integer;
  begin
    Result := false;
    if node.Strings[1]=Value then begin
      node.Focused := true;
      node.MakeVisible;
      Result := true;
      Exit;
    end;
    for n:=0 to node.Count-1 do
      if node.Items[n].Strings[1]=Value then begin
        node.Items[n].Focused := true;
        node.Items[n].MakeVisible;
        Result := true;
        break;
      end
      else
        if FindNode(node.Items[n]) then begin
          Result := true;
          break;
        end;
  end;
var n: Integer;
begin
  Result := false;
  for n:=0 to dxtKTerr.Count-1 do
    if FindNode(dxtKTerr.Items[n]) then begin
      Result := true;
      break;
    end;
  dxtKTerr.ApplyBestFit(dxtKTerrCode);
end;

procedure TfmOrgProp.cbKTerrPopup(Sender: TObject; const EditText: String);
begin
  LocateKTerr(EditText);
end;

procedure TfmOrgProp.cbKTerrCloseUp(Sender: TObject; var Text: String;
  var Accept: Boolean);
begin
  with dxtKTerr.FocusedNode do
    Text := Strings[dxtKTerrName.Index];
  Accept := true;
end;

procedure TfmOrgProp.cbKTerrExit(Sender: TObject);
begin
  if not LocateKTerr(cbKTerr.Text) then
    cbKTerr.Text := EmptyStr;
end;

function TfmOrgProp.GetOkonhText(OkonhList, MainOkonh: String): String;
var
  n: Integer;
begin
  n := Pos(',', OkonhList);
  if n > 0 then
    Result := MainOkonh + Copy(OkonhList, n, MaxInt)
  else
    Result := MainOkonh;
end;

function TfmOrgProp.GetTerrCode(TerrId: Integer): string;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select NAME from KTERR where TERR_ID='+IntToStr(TerrId);//instead KODTERR
    Open;
    if IsEmpty then Result := EmptyStr
    else Result := Fields[0].AsString;
  finally
    Free;
  end;
end;

procedure TfmOrgProp.btnBronDolClick(Sender: TObject);
begin
  ShowTPDPModal;
end;

end.

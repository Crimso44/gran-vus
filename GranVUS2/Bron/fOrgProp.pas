unit fOrgProp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, dxExEdtr,
  dxEdLib, dxCntner, dxEditor, fOrgPropCommon, fOrgPropContacts, fOrgPropOsnPer,
  fOrgPropOKONH, dxTL, Menus, fOrgLst, DB;

type
  TfmOrgProp = class(TForm)
    Label1: TLabel;
    mmName: TMemo;
    Label2: TLabel;
    edRegNum: TEdit;
    dtRegDate: TdxDateEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edINN: TEdit;
    edOKPO: TEdit;
    btnShowCommon: TButton;
    Label7: TLabel;
    cbOKATO1: TdxPopupEdit;
    Label8: TLabel;
    edUAddr: TEdit;
    btnShowContacts: TButton;
    Label9: TLabel;
    edOKONH: TEdit;
    Label11: TLabel;
    edOCCUPATION: TEdit;
    Label12: TLabel;
    edOKBV: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    dtFirst: TdxDateEdit;
    dtLast: TdxDateEdit;
    chkHasBron: TCheckBox;
    Label18: TLabel;
    cbForm6Shifr: TdxPickEdit;
    Label19: TLabel;
    cbVV5: TdxPickEdit;
    Label20: TLabel;
    Label21: TLabel;
    dtCheck: TdxDateEdit;
    Label22: TLabel;
    dtOut: TdxDateEdit;
    laEdOut: TLabel;
    edOut: TEdit;
    Label24: TLabel;
    edVUR: TEdit;
    Label25: TLabel;
    edPhone: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    cbOKFS: TdxPickEdit;
    cbOKOPF: TdxPickEdit;
    edOKOGU: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    btnShowOKONH: TButton;
    btnPerList: TButton;
    laDtConf: TLabel;
    dtConf: TdxDateEdit;
    btnForm6: TButton;
    Bevel6: TBevel;
    sbFirst: TSpeedButton;
    sbPrior: TSpeedButton;
    sbNext: TSpeedButton;
    sbLast: TSpeedButton;
    cbTERR: TdxPickEdit;
    dxtOKATO: TdxTreeList;
    dxtOKATOCode: TdxTreeListColumn;
    dxtOKATONameTerr: TdxTreeListColumn;
    pmOKATO: TPopupMenu;
    N1: TMenuItem;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    edFeature1: TEdit;
    edFeature2: TEdit;
    edFeature3: TEdit;
    Bevel1: TBevel;
    Label33: TLabel;
    Label34: TLabel;
    Bevel2: TBevel;
    Label35: TLabel;
    Bevel3: TBevel;
    Label15: TLabel;
    Bevel4: TBevel;
    Label16: TLabel;
    Bevel5: TBevel;
    paNone: TPanel;
    chkGPZGPPNone: TCheckBox;
    chkReportNone: TCheckBox;
    Label10: TLabel;
    cbOVK: TdxMRUEdit;
    Label17: TLabel;
    cbOKTMO: TdxPopupEdit;
    dxtOKTMO: TdxTreeList;
    dxtOKTMOCode: TdxTreeListColumn;
    dxtOKTMOName: TdxTreeListColumn;
    pmOKTMO: TPopupMenu;
    mi1: TMenuItem;
    edSName: TEdit;
    Label23: TLabel;
    cbOKATO2: TdxPopupEdit;
    Label29: TLabel;
    edFactAddr: TEdit;
    Label36: TLabel;
    cbOKTMO2: TdxPopupEdit;
    Label37: TLabel;
    eRegplace: TEdit;
    procedure mmNameChange(Sender: TObject);
    procedure edOKPOKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edOKONHKeyPress(Sender: TObject; var Key: Char);
    procedure chkHasBronClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnShowCommonClick(Sender: TObject);
    procedure btnShowContactsClick(Sender: TObject);
    procedure btnPerListClick(Sender: TObject);
    procedure cbOKATO1Popup(Sender: TObject; const EditText: String);
    procedure cbOKATO1CloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure dxtOKATODblClick(Sender: TObject);
    procedure btnShowOKONHClick(Sender: TObject);
    procedure cbOKFSChange(Sender: TObject);
    procedure edOKBVExit(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure sbFirstClick(Sender: TObject);
    procedure sbPriorClick(Sender: TObject);
    procedure sbNextClick(Sender: TObject);
    procedure sbLastClick(Sender: TObject);
    procedure btnForm6Click(Sender: TObject);
    procedure FilterChange(Sender: TObject);
    procedure cbRegPlaceExit(Sender: TObject);
    procedure cbOVKButtonClick(Sender: TObject);
  private
    FCurrTerr: Integer;
    FLoading : boolean;
    procedure FLoadData;
    function FStoreData: boolean;
    procedure SetOKATOList;
    procedure SetOKTMOList;
    procedure LocateOKATO(Sender: TdxTreeList; Value: string);
    function FCanMove: boolean;
    function FParentValid: boolean;
    function FCheckOKBV: Integer;
    function FCheckOrgName: boolean;
    function FCheckINN: boolean;
    function FCheckOKPO: boolean;
    procedure UpdateForm6;
    procedure InitFilterArray;
    procedure ReturnFilter;
    procedure LoadStrings(AList: TStrings; ASQL: string; FHasNull: boolean=true);
    function GetOkonhText(OkonhList, MainOkonh: String): String;
    function ExtractNumber(s: String): Integer;
    function CheckOkved(s: String): Boolean;
  public
    FId: Integer;
    FCommon: TfmOrgPropCommon;
    FContacts: TfmOrgPropContacts;
    FOsnPer: TfmOrgPropOsnPer;
    FOKONHList: TfmOrgPropOKONH;
    FParentList: TfmOrgList;
    FKOPF_Changed: Boolean;
    FOKVED_Changed: Boolean;
  end;

  function ShowOrgCard(id: Integer; ParentList: TfmOrgList=nil): Boolean;

implementation

uses ADOdb, dMain, msg, StrUtils, dxTLClms, Rdialogs, IniSupport, math,
  fBaseLst;

{$R *.dfm}

type
  TFilterType = (ptString,ptDate,ptInteger,ptList,ptSet,ptBoolean,ptCompare);
  TCardFilterRec = record
    FldName        : String;
    FldType        : TFilterType;
    ControlName    : String;
    Control        : TWinControl;
//    OldOnChange    : TNotifyEvent;
    Changed        : Boolean;
  end;

const
  AFilterArray : Array[0..53] of TCardFilterRec = (
    (FldName:'gen.Fam';    FldType: ptString;     ControlName: 'FContacts.edFam1'),
    (FldName:'gen.Im';     FldType: ptString;     ControlName: 'FContacts.edIm1'),
    (FldName:'gen.Otch';   FldType: ptString;     ControlName: 'FContacts.edOtch1'),
    (FldName:'gen.Phone';  FldType: ptString;     ControlName: 'FContacts.edPhone1'),
    (FldName:'gen.Post';   FldType: ptString;     ControlName: 'FContacts.edPost1'),
    (FldName:'gen2.Fam';    FldType: ptString;     ControlName: 'FContacts.edFam3'),
    (FldName:'gen2.Im';     FldType: ptString;     ControlName: 'FContacts.edIm3'),
    (FldName:'gen2.Otch';   FldType: ptString;     ControlName: 'FContacts.edOtch3'),
    (FldName:'gen2.Phone';  FldType: ptString;     ControlName: 'FContacts.edPhone3'),
    (FldName:'gen2.Post';   FldType: ptString;     ControlName: 'FContacts.edPost3'),
    (FldName:'vus.Fam';    FldType: ptString;     ControlName: 'FContacts.edFam2'),
    (FldName:'vus.Im';     FldType: ptString;     ControlName: 'FContacts.edIm2'),
    (FldName:'vus.Otch';   FldType: ptString;     ControlName: 'FContacts.edOtch2'),
    (FldName:'vus.Phone';  FldType: ptString;     ControlName: 'FContacts.edPhone2'),
    (FldName:'vus.Post';   FldType: ptString;     ControlName: 'FContacts.edPost2'),
    (FldName:'ORGNAME';    FldType: ptString;     ControlName: 'mmName'),
    (FldName:'ORGSNAME';   FldType: ptString;     ControlName: 'edSName'),
    (FldName:'REGNUM';     FldType: ptString;     ControlName: 'edRegNum'),
    (FldName:'REGDATE';    FldType: ptDate;       ControlName: 'dtRegDate'),
    (FldName:'URADDR';     FldType: ptString;     ControlName: 'edUAddr'),
    (FldName:'FIZADDR';    FldType: ptString;     ControlName: 'edFactAddr'),
    (FldName:'POSTADDR';   FldType: ptString;     ControlName: 'FCommon.edPostAddr'),
    (FldName:'PHONE';      FldType: ptString;     ControlName: 'FCommon.edPhone'),
    (FldName:'EMAIL';      FldType: ptString;     ControlName: 'FCommon.edEmail'),
    (FldName:'WWW';        FldType: ptString;     ControlName: 'FCommon.edWww'),
    (FldName:'KODREG';     FldType: ptString;     ControlName: 'cbOKATO1'),
    (FldName:'OKATO2';     FldType: ptString;     ControlName: 'cbOKATO2'),
    (FldName:'KODOKTMO';   FldType: ptString;     ControlName: 'cbOKTMO'),
    (FldName:'KODOKTMO2';  FldType: ptString;     ControlName: 'cbOKTMO2'),
    (FldName:'OKPO';       FldType: ptSet;        ControlName: 'edOKPO'),
    (FldName:'INN';        FldType: ptSet;        ControlName: 'edINN'),
    (FldName:'COMMENT';    FldType: ptString;     ControlName: 'FCommon.mmComments'),
    (FldName:'TERR_ID';    FldType:ptList;        ControlName: 'cbTerr'),
    (FldName:'dbo.ExtractNumber(OKBV)'; FldType: ptSet; ControlName: 'edOKBV'),//numbers must be only
    (FldName:'SOOGU';      FldType: ptSet;        ControlName: 'edOKOGU'),
    (FldName:'MAINOKONH';  FldType: ptSet;        ControlName: 'edOKONH'),
    (FldName:'OKONH';      FldType: ptString;     ControlName: 'FOKONHList.mmOKONH'),
    (FldName:'FS_ID';      FldType: ptList;       ControlName: 'cbOKFS'),
    (FldName:'KOPF_ID';    FldType: ptList;       ControlName: 'cbOKOPF'),
    (FldName:'OCCUPATION'; FldType: ptString;     ControlName: 'edOccupation'),
    (FldName:'OVK_ID';     FldType: ptList;       ControlName: 'cbOVK'),
    (FldName:'SBM_ID';     FldType: ptList;       ControlName: 'cbVV5'),
    (FldName:'F6_SHIFR';   FldType: ptList;       ControlName: 'cbForm6Shifr'),
    (FldName:'REGPLACE';   FldType: ptString;     ControlName: 'eRegPlace'),
    (FldName:'FIRST_DATE'; FldType: ptDate;       ControlName: 'dtFirst'),
    (FldName:'LAST_DATE';  FldType: ptDate;       ControlName: 'dtLast'),
    (FldName:'OUT_DATE';   FldType: ptDate;       ControlName: 'dtOut'),
    (FldName:'CHK_DATE';   FldType: ptDate;       ControlName: 'dtCheck'),
    (FldName:'HAS_BRON';   FldType: ptBoolean;    ControlName: 'chkHasBron'),
//    (FldName:'HAS_F6';     FldType: ptBoolean;    ControlName: 'Есть форма №6'), missing in card
//    (FldName:'F6CHECKED';  FldType: ptBoolean;    ControlName: 'Форма №6 проверена'), missing in card
//    (FldName:'RAB_COUNT';  FldType: ptInteger;    ControlName: 'Кол-во работающих'), missing in card
//    (FldName:'ZAP_COUNT';  FldType: ptInteger;    ControlName: 'Из них в запасе'), missing in card
//    (FldName:'ZAB_COUNT';  FldType: ptInteger;    ControlName: 'Из них забронировано'), missing in card
    (FldName:'GPZGPPNone'; FldType: ptBoolean;    ControlName: 'chkGPZGPPNone'),
    (FldName:'ReportNone'; FldType: ptBoolean;    ControlName: 'chkReportNone'),
//    (FldName:'PER_NO';     FldType: ptString;     ControlName: 'FOsnPer.dxtPer'), table is too complexity
    (FldName:'Feature1';   FldType: ptString;     ControlName: 'edFeature1'),
    (FldName:'Feature2';   FldType: ptString;     ControlName: 'edFeature2'),
    (FldName:'Feature3';   FldType: ptString;     ControlName: 'edFeature3')
  );




function ShowOrgCard(id: Integer; ParentList: TfmOrgList=nil): Boolean;
var n: Integer;
    F: TfmOrgProp;
begin
  Result := True;
  if id<0 then begin
    with TfmOrgProp.Create(Application) do
    try
      Fid                  := -1;
      FParentList          := ParentList; 
      FormStyle            := fsNormal;
      Visible              := False;
      mmName.Enabled       := True;
      edSName.Enabled      := True;
      edRegNum.Enabled     := True;
      dtRegDate.Enabled    := True;
      eRegPlace.Enabled    := True;
      cbOKATO1.Enabled     := True;
      cbOKATO2.Enabled     := True;
      cbOKTMO.Enabled      := True;
      cbOKTMO2.Enabled     := True;
      edINN.Enabled        := True;
      edOKPO.Enabled       := True;
      edUAddr.Enabled      := True;
      edFactAddr.Enabled   := True;
      edVUR.Enabled        := True;
      edPhone.Enabled      := True;
      edOKONH.Enabled      := True;
      edOCCUPATION.Enabled := True;
      cbOKFS.Enabled       := True;
      cbOKOPF.Enabled      := True;
      edOKOGU.Enabled      := True;
      edOKBV.Enabled       := True;
      dtFirst.Enabled      := True;
      dtLast.Enabled       := True;
      cbForm6Shifr.Enabled := True;
      cbVV5.Enabled        := True;
      cbTerr.Enabled       := True;
      dtConf.Enabled       := True;
      chkHasBron.Enabled   := True;
      edFeature1.Enabled   := True;
      edFeature2.Enabled   := True;
      edFeature3.Enabled   := True;
      btnOk.Visible        := True;
      btnApply.Visible     := False;
      dtCheck.Enabled      := True;
      dtOut.Enabled        := True;
      edOut.Enabled        := True;
      paNone.Enabled       := True;
      FCommon.mmName.Enabled       := True;
      FCommon.edSName.Enabled      := True;
      FCommon.edParent.Enabled     := True;
      FCommon.edPhone.Enabled      := True;
      FCommon.edEmail.Enabled      := True;
      FCommon.edWww.Enabled        := True;
      FCommon.edFax.Enabled        := True;
      FCommon.edRegNum.Enabled     := True;
      FCommon.edINN.Enabled        := True;
      FCommon.dtRegDate.Enabled    := True;
      FCommon.edOKPO.Enabled       := True;
      FCommon.eRegPlace.Enabled    := True;
      FCommon.sbToUrAddr.Enabled   := True;
      FCommon.edUrAddr.Enabled     := True;
      FCommon.cbOKATO1.Enabled     := True;
      FCommon.sbToFactAddr.Enabled := True;
      FCommon.edFactAddr.Enabled   := True;
      FCommon.cbOKATO2.Enabled     := True;
      FCommon.sbToPostAddr.Enabled := True;
      FCommon.edPostAddr.Enabled   := True;
      FCommon.cbOKATO3.Enabled     := True;
      FCommon.mmComments.Enabled   := True;
      FContacts.edFam1.Enabled   := True;
      FContacts.edIm1.Enabled    := True;
      FContacts.edOtch1.Enabled  := True;
      FContacts.edPhone1.Enabled := True;
      FContacts.edPost1.Enabled  := True;
      FContacts.edFam2.Enabled   := True;
      FContacts.edIm2.Enabled    := True;
      FContacts.edOtch2.Enabled  := True;
      FContacts.edPhone2.Enabled := True;
      FContacts.edPost2.Enabled  := True;
      FContacts.edFam3.Enabled   := True;
      FContacts.edIm3.Enabled    := True;
      FContacts.edOtch3.Enabled  := True;
      FContacts.edPhone3.Enabled := True;
      FContacts.edPost3.Enabled  := True;
      FOKONHList.mmOKONH.Enabled := True;
      btnPerList.Visible   := False;
      btnForm6.Visible     := False;
      btnPerList.Visible   := False;
      sbFirst.Visible      := False;
      sbPrior.Visible      := False;
      sbNext.Visible       := False;
      sbLast.Visible       := False;
      cbTERR.ItemIndex     := 0;
      chkHasBron.AllowGrayed    := True;
      chkGPZGPPNone.AllowGrayed := True;
      chkReportNone.AllowGrayed := True;
      chkHasBron.State     := cbGrayed;
      chkGPZGPPNone.State  := cbGrayed;
      chkReportNone.State  := cbGrayed;
      cbForm6Shifr.Items.Insert(0,'??');
      cbForm6Shifr.ItemIndex := 0;
      edVUR.ParentColor    := True;
      edVUR.ReadOnly       := True;
      edPhone.ParentColor  := True;
      edPhone.ReadOnly     := True;
      edOut.Visible        := False;
      dtConf.Visible       := False;
      laedOut.Visible      := False;
      ladtConf.Visible     := False;
      edOKBV.OnExit        := nil;
      FLoadData;
      Result := ShowModal=mrOk;
    finally Free;
    end;
  end
  else begin
    F := nil;
    if id>0 then
      for n:=0 to Application.MainForm.MDIChildCount-1 do
        if Application.MainForm.MDIChildren[n] is TfmOrgProp then
          if (Application.MainForm.MDIChildren[n] as TfmOrgProp).FId=id then begin
            F := Application.MainForm.MDIChildren[n] as TfmOrgProp;
            break;
          end;
    if F=nil then begin
      F := TfmOrgProp.Create(Application);
      F.FId := id;
      if id>0 then F.FLoadData;
    end;
    F.FParentList := ParentList;
    if IsIconic(F.Handle) then ShowWindow(F.Handle,SW_RESTORE);
    F.BringToFront;
  end;
end;

procedure TfmOrgProp.FilterChange(Sender: TObject);
var I: Integer;
begin
  for I := Low(AFilterArray) to High(AFilterArray) do
  with AFilterArray[I] do
  if Sender=Control then begin
    Changed := True;
//    if Assigned(OldOnChange) then OldOnChange(Sender);
    Exit;
  end;
end;

type
  TMydxInplaceEdit = class(TdxInplaceEdit)
  public
    property OnChange;
  end;
  TMyCustomEdit = class(TCustomEdit)
  public
    property OnChange;
  end;

procedure TfmOrgProp.InitFilterArray;
//
  function GetFirstFromSet(S: String): String;
  var I: integer;
  begin
    with TStringList.Create do
    try
      I := Pos('(value) in (',LowerCase(S));
      CommaText := Copy(S,I+12,Length(S)-I-12);
      Result := AnsiDequotedStr(Strings[0],'''');
    finally Free;
    end;
  end;
//
  function GetStringValue(S: String): String;
  begin
    if SameText(LeftStr(S,13),'(value) LIKE ')
    then begin
      Result := AnsiDequotedStr(RightStr(S,Length(S)-13),'''');
      Result := Copy(Result,2,Length(Result)-2); //Strip %%
    end
    else Result := AnsiDequotedStr(RightStr(S,Length(S)-10),''''); // =
  end;
//
var
  I,Dot  : Integer;
  F      : TForm;
  CN     : String; //ControlName
  S      : String; //temporary string
begin
  for I := Low(AFilterArray) to High(AFilterArray) do
  with AFilterArray[I] do begin
    Dot := Pos('.',ControlName);
    case AnsiIndexText(LeftStr(ControlName,Dot-1),['FCommon','FContacts','FOsnPer','FOKONHList']) of
      0: F := FCommon;
      1: F := FContacts;
      2: F := FOsnPer;
      3: F := FOKONHList;
    else
      F := Self;
    end;
    if Dot>0
      then CN := RightStr(ControlName, Length(ControlName)-Dot)
      else CN := ControlName;

    Control :=   F.FindComponent(CN) as TWinControl;
    if Control is TdxInplaceEdit then begin
//      OldOnChange := TMydxInplaceEdit(Control).OnChange;
      TMydxInplaceEdit(Control).OnChange := FilterChange;
    end else
    if Control is TCustomEdit then begin
  //    OldOnChange := TMyCustomEdit(Control).OnChange;
      TMyCustomEdit(Control).OnChange := FilterChange;
    end else
    if Control is TCheckBox then begin
//      OldOnChange := TCheckBox(Control).OnClick;
      TCheckBox(Control).OnClick := FilterChange;
    end else
      ShowMessage(Format('%s:%s.OnChange is not found',[Control.Name, Control.ClassName]));

    S := Trim(TStringList(FParentList).Values[FldName]);
    if S <> '' then
    case FldType of
      ptString  : if SameText(LeftStr(S,10),'(value) = ') or SameText(LeftStr(S,13),'(value) LIKE ') then
        if Control is TMemo        then (Control as Tmemo).Lines.Text := GetStringValue(S) else
        if Control is TdxPopupEdit then (Control as TdxPopupEdit).Text := GetStringValue(S) else
        (Control as TEdit).Text := GetStringValue(S);
      ptDate    : if SameText(LeftStr(S,11),'(value) >= ') or SameText(LeftStr(S,11),'(value) <= ') then
        (Control as TdxDateEdit).Date := EncodeDate(
           StrToInt(Copy(S,13,4)),StrToInt(Copy(S,17,2)),StrToInt(Copy(S,19,2)));
      ptInteger : Continue;
      ptList    : if Pos('(value) in (',LowerCase(S))>0 then
        if Control is TdxMRUEdit then
          with (Control as TdxMRUEdit) do
          ItemIndex := Items.IndexOfObject(Pointer(StrToIntDef(GetFirstFromSet(S),0)))
        else
        with (Control as TdxPickEdit) do
        if Control = cbForm6Shifr
          then ItemIndex := Items.IndexOf('0'+GetFirstFromSet(S))
          else ItemIndex := Items.IndexOfObject(Pointer(StrToIntDef(GetFirstFromSet(S),0)));
      ptSet     : if Pos('(value) in (',LowerCase(S))>0 then
        (Control as TEdit).Text := GetFirstFromSet(S);
      ptBoolean : if SameText(S,'(value) != 0')
        then (Control as TCheckBox).State := cbChecked
        else (Control as TCheckBox).State := cbUnchecked;
      ptCompare : Continue;
    end;
    Changed :=False;
  end;//for
  with FContacts do begin
    edVUR.Text   := edFam2.Text+' '+edIm2.Text+' '+edOtch2.Text;
    edPhone.Text := edPhone2.Text;
  end;
end;

procedure TfmOrgProp.FormCreate(Sender: TObject);
begin
  FId := 0;
  FLoading := false;
  FParentList := nil;
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
  FOsnPer := TfmOrgPropOsnPer.Create(Application);
  FOsnPer.FOrgProp := Self;
//init form
  try
    LoadStrings(cbTERR.Items,'SELECT K.TERR_ID, K.KODTERR + '' - '' + ISNULL(K.NAME,'''') As TERR_NAME FROM KTERR K JOIN SUBJ S ON K.TERR_ID = S.TERR_ID ORDER BY TERR_NAME');
    cbTERR.ItemIndex := 0;
    LoadStrings(cbOVK.Items,'SELECT OVK_ID, OVK_NAME FROM KOVK ORDER BY OVK_NAME');
    cbOVK.ItemIndex := 0;
    LoadStrings(cbVV5.Items,'SELECT ID, KOD + '' - '' + NAME As NAME FROM VV5 ORDER BY NAME');
    cbVV5.ItemIndex := 0;
    LoadStrings(cbOKFS.Items,'select FS_ID, KOD+'' - ''+ISNULL(FS_NAME,'''') from KFS ORDER BY KOD');
    cbOKFS.ItemIndex := 0;
    LoadStrings(cbOKOPF.Items,'select KOPF_ID, KOD+'' - ''+ISNULL(KOPF_NAME,'''') from KOPF Where CharIndex(''-'',kod) <= 0 ORDER BY KOD');
    cbOKOPF.ItemIndex := 0;
    LoadStrings(FOsnPer.colBASE_ID.Items,'SELECT ID, KOD + '' - '' + NAME As NAME FROM VV3 ORDER BY NAME');
    LoadStrings(FOsnPer.colDOC_ID.Items,'SELECT ID, KOD + '' - '' + NAME As NAME FROM VV4 ORDER BY NAME');
    SetOKATOList;
    SetOKTMOList;
  except
    on E: Exception do
      ShowErr('Ошибка при загрузке базовых справочников!'#13#13+E.Message);
  end;
  FCurrTerr := 0;
  with TADOQuery.Create(Self) do begin
    Connection := dmMain.dbMain;
    try
      SQL.Text := 'SELECT TERR_ID FROM SUBJ S JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID';
      Open;
      if not IsEmpty then
        if not FieldByName('TERR_ID').IsNull then begin
          FCurrTerr := FieldByName('TERR_ID').AsInteger;
          cbTERR.ItemIndex := cbTERR.Items.IndexOfObject(Pointer(FCurrTerr));
        end;
    except
    end;
    Free;
  end;
  cbForm6Shifr.ItemIndex := 0;
  btnApply.Enabled := false;
  //rEdit
  mmName.Enabled       := dmMain.rEdit;
  edSName.Enabled      := dmMain.rEdit;
  edRegNum.Enabled     := dmMain.rEdit;
  dtRegDate.Enabled    := dmMain.rEdit;
  eRegPlace.Enabled    := dmMain.rEdit;
  cbOKATO1.Enabled     := dmMain.rEdit;
  cbOKATO2.Enabled     := dmMain.rEdit;
  cbOKTMO.Enabled      := dmMain.rEdit;
  cbOKTMO2.Enabled     := dmMain.rEdit;
  edINN.Enabled        := dmMain.rEdit;
  edOKPO.Enabled       := dmMain.rEdit;
  edUAddr.Enabled      := dmMain.rEdit;
  edFactAddr.Enabled   := dmMain.rEdit;
  edVUR.Enabled        := dmMain.rEdit;
  edPhone.Enabled      := dmMain.rEdit;
  edOKONH.Enabled      := dmMain.rEdit;
  edOCCUPATION.Enabled := dmMain.rEdit;
  cbOKFS.Enabled       := dmMain.rEdit;
  cbOKOPF.Enabled      := dmMain.rEdit;
  edOKOGU.Enabled      := dmMain.rEdit;
  edOKBV.Enabled       := dmMain.rEdit;
  dtFirst.Enabled      := dmMain.rEdit;
  dtLast.Enabled       := dmMain.rEdit;
  cbForm6Shifr.Enabled := dmMain.rEdit;
  cbOVK.Enabled        := dmMain.rEdit;
  cbVV5.Enabled        := dmMain.rEdit;
  cbTerr.Enabled       := dmMain.rEdit;
  dtConf.Enabled       := dmMain.rEdit;
  chkHasBron.Enabled   := dmMain.rEdit;
  edFeature1.Enabled   := dmMain.rEdit;
  edFeature2.Enabled   := dmMain.rEdit;
  edFeature3.Enabled   := dmMain.rEdit;
  btnOk.Visible        := dmMain.rEdit;
  btnApply.Visible     := dmMain.rEdit;
  if not dmMain.rEdit then btnCancel.Caption := 'Закрыть';
  dtCheck.Enabled      := dmMain.rEdit;
  dtOut.Enabled        := dmMain.rEdit;
  edOut.Enabled        := dmMain.rEdit;
end;

procedure TfmOrgProp.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := (FId<0) or not btnApply.Enabled;
  if not CanClose then
    case RMessageDlg(
          'Сведения об организации не сохранены!'+
          #13'Сделать это перед закрытием формы?',
          mtConfirmation,[mbYes,mbNo,mbCancel],0)
    of
      mrYes: CanClose := FStoreData;
      mrNo: CanClose := true;
    else begin
     //nothing to do
      end;
    end;

end;

procedure TfmOrgProp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FCommon);
  FreeAndNil(FContacts);
  FreeAndNil(FOsnPer);
  FreeAndNil(FOKONHList);
  Action := caFree;
end;

procedure TfmOrgProp.mmNameChange(Sender: TObject);
begin
  btnApply.Enabled := true;
end;

procedure TfmOrgProp.edOKPOKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9']) then Key := #0;
end;

function TfmOrgProp.ExtractNumber(s: String): Integer;
var
  ss: String;
  n: Integer;
begin
  Result := 0;
  ss := EmptyStr;
  for n:=1 to Length(s) do
    if s[n] in ['0'..'9'] then
      ss := ss + s[n]
    else
      if ss <> EmptyStr then break;
  if ss <> EmptyStr then
    Result := StrToInt(ss);
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
  if Assigned(edOKBV.OnExit) then edOKBV.OnExit(Self);
  mmName.OnChange(Self);
end;

procedure TfmOrgProp.FLoadData;
begin
  if FId=0 then Exit;
  if FId<0 then begin
    InitFilterArray;
    Exit;
  end;
  FLoading := true;
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
    edSName.Text := FieldByName('OrgSName').AsString;
    edRegNum.Text := FieldByName('RegNum').AsString;
    with FieldByName('RegDate') do
      if IsNull then dtRegDate.Text := EmptyStr
      else dtRegDate.Date := Value;
    eRegPlace.Text := FieldByName('REGPLACE').AsString;
    edINN.Text := FieldByName('INN').AsString;
    edOKPO.Text := FieldByName('OKPO').AsString;
    edUAddr.Text := FieldByName('UrAddr').AsString;
    edFactAddr.Text := FieldByName('FizAddr').AsString;
    cbOKATO1.Text := FieldByName('KodReg').AsString;
    cbOKATO2.Text := FieldByName('OKATO2').AsString;
    cbOKTMO.Text := FieldByName('KodOktmo').AsString;
    cbOKTMO2.Text := FieldByName('KodOktmo2').AsString;
    FCommon.edParent.Text := FieldByName('Parent').AsString;
    FCommon.edPhone.Text := FieldByName('Phone').AsString;
    FCommon.edEmail.Text := FieldByName('Email').AsString;
    FCommon.edWww.Text := FieldByName('Www').AsString;
    FCommon.edFax.Text := FieldByName('Fax').AsString;
    FCommon.edFactAddr.Text := FieldByName('FizAddr').AsString;
    FCommon.cbOKATO2.Text := FieldByName('OKATO2').AsString;
    FCommon.edPostAddr.Text := FieldByName('PostAddr').AsString;
    FCommon.cbOKATO3.Text := FieldByName('OKATO3').AsString;
    FCommon.mmComments.Text := FieldByName('Comment').AsString;
    FCommon.eComputers.Value := FieldByName('Computers').AsInteger;
    FCommon.eSoftwareNum.Value := FieldByName('SoftwareNum').AsInteger;
    FCommon.eKpis.Value := FieldByName('Kpis').AsInteger;
    FCommon.eComputersS.Value := FieldByName('ComputersS').AsInteger;
    FCommon.eSoftwareNumS.Value := FieldByName('SoftwareNumS').AsInteger;
    FCommon.eKpisS.Value := FieldByName('KpisS').AsInteger;
    FCommon.eSoftware  .Text := FieldByName('Software').AsString;
    edOKONH.Text := FieldByName('MAINOKONH').AsString;
    FOKONHList.mmOKONH .Text := GetOkonhText(
      StringReplace(FieldByName('OKONH').AsString,',',', ',[rfReplaceAll]),
      FieldByName('MAINOKONH').AsString);
    edOccupation.Text := FieldByName('Occupation').AsString;
    cbOKFS.ItemIndex := cbOKFS.Items.IndexOfObject(Pointer(FieldByName('FS_ID').AsInteger));
    cbOKFS.OnExit(cbOKFS);
    cbOKOPF.ItemIndex := cbOKOPF.Items.IndexOfObject(Pointer(FieldByName('KOPF_ID').AsInteger));
    if (cbOKOPF.ItemIndex < 0) and (FieldByName('KOPF_ID').AsInteger > 0) then begin
      LoadStrings(cbOKOPF.Items,'select KOPF_ID, KOD+'' - ''+ISNULL(KOPF_NAME,'''') from KOPF ORDER BY KOD');
      cbOKOPF.ItemIndex := cbOKOPF.Items.IndexOfObject(Pointer(FieldByName('KOPF_ID').AsInteger));
    end;
    cbOKOPF.OnExit(cbOKOPF);
    edOKOGU.Text := FieldByName('SOOGU').AsString;
    edOKBV.Text := FieldByName('OKBV').AsString;
    with FieldByName('First_Date') do
      if IsNull then dtFirst.Text := EmptyStr
      else dtFirst.Date := Value;
    with FieldByName('Last_Date') do
      if IsNull then dtLast.Text := EmptyStr
      else dtLast.Date := Value;
    with FieldByName('Chk_Date') do
      if IsNull then dtCheck.Text := EmptyStr
      else dtCheck.Date := Value;
    chkHasBron.Checked := FieldByName('Has_Bron').AsBoolean;
    cbForm6Shifr.ItemIndex := cbForm6Shifr.Items.IndexOf(FieldByName('F6_Shifr').AsString);
    cbForm6Shifr.OnExit(cbForm6Shifr);
    cbOVK.ItemIndex := cbOVK.Items.IndexOfObject(Pointer(FieldByName('OVK_Id').AsInteger));
    cbOVK.OnExit(cbOVK);
    cbVV5.ItemIndex := cbVV5.Items.IndexOfObject(Pointer(FieldByName('Sbm_Id').AsInteger));
    cbVV5.OnExit(cbVV5);
    cbTerr.ItemIndex := cbTerr.Items.IndexOfObject(Pointer(FieldByName('Terr_Id').AsInteger));
    cbTerr.OnExit(cbTerr);
    with FieldByName('Out_Date') do
      if IsNull then dtOut.Text := EmptyStr
      else dtOut.Date := Value;
    edOut.Text := FieldByName('Out_Reason').AsString;
    edFeature1.Text := FieldByName('Feature1').AsString;
    edFeature2.Text := FieldByName('Feature2').AsString;
    edFeature3.Text := FieldByName('Feature3').AsString;
    with FieldByName('ConfDate') do
      if IsNull then dtConf.Text := EmptyStr
      else dtConf.Date := Value;
    FKOPF_Changed := FieldByName('KOPF_Changed').AsBoolean;
    FOkved_Changed := FieldByName('Okved_Changed').AsBoolean;
    Close;
    SQL.Text := 'select * from ORG_CONT where OrgId='+IntToStr(FId);
    Open;
    if Locate('is_gen',1,[]) then begin
      FContacts.edFam1.Text := FieldByName('Fam').AsString;
      FContacts.edIm1.Text := FieldByName('Im').AsString;
      FContacts.edOtch1.Text := FieldByName('Otch').AsString;
      FContacts.edPhone1.Text := FieldByName('Phone').AsString;
      FContacts.edPost1.Text := FieldByName('Post').AsString;
    end
    else begin
      FContacts.edFam1.Text := EmptyStr;
      FContacts.edIm1.Text := EmptyStr;
      FContacts.edOtch1.Text := EmptyStr;
      FContacts.edPhone1.Text := EmptyStr;
      FContacts.edPost1.Text := EmptyStr;
    end;
    if Locate('is_gen',2,[]) then begin
      FContacts.edFam3.Text := FieldByName('Fam').AsString;
      FContacts.edIm3.Text := FieldByName('Im').AsString;
      FContacts.edOtch3.Text := FieldByName('Otch').AsString;
      FContacts.edPhone3.Text := FieldByName('Phone').AsString;
      FContacts.edPost3.Text := FieldByName('Post').AsString;
    end
    else begin
      FContacts.edFam3.Text := EmptyStr;
      FContacts.edIm3.Text := EmptyStr;
      FContacts.edOtch3.Text := EmptyStr;
      FContacts.edPhone3.Text := EmptyStr;
      FContacts.edPost3.Text := EmptyStr;
    end;
    if Locate('is_vus',1,[]) then begin
      FContacts.edFam2.Text := FieldByName('Fam').AsString;
      FContacts.edIm2.Text := FieldByName('Im').AsString;
      FContacts.edOtch2.Text := FieldByName('Otch').AsString;
      FContacts.edPhone2.Text := FieldByName('Phone').AsString;
      FContacts.edPost2.Text := FieldByName('Post').AsString;
    end
    else begin
      FContacts.edFam2.Text := EmptyStr;
      FContacts.edIm2.Text := EmptyStr;
      FContacts.edOtch2.Text := EmptyStr;
      FContacts.edPhone2.Text := EmptyStr;
      FContacts.edPost2.Text := EmptyStr;
    end;
    edVUR.Text :=
      FContacts.edFam2.Text+' '+
      FContacts.edIm2.Text+' '+
      FContacts.edOtch2.Text;
    edPhone.Text := FContacts.edPhone2.Text;
    Close;
    FOsnPer.dxtPer.ClearNodes;
    SQL.Text := 'select * from PER where OrgId='+IntToStr(FId);
    Open;
    while not EOF do begin
      with FOsnPer.dxtPer.Add do begin
        Values[FOsnPer.colpOkvedName.Index] := FieldByName('Okved_Name').Value;
        Values[FOsnPer.colpPER_NO.Index] := FieldByName('Per_No').Value;
        Values[FOsnPer.colpRAZD_NO.Index] := FieldByName('Razd_No').Value;
      end;
      Next;
    end;
    Close;
    FOsnPer.dxtOSN.ClearNodes;
    SQL.Text := 'select * from OSN where OrgId='+IntToStr(FId);
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
    SQL.Text := 'SELECT * FROM FORM6HDR H, FORM6 F '+
                'WHERE H.F6_ID = F.F6_ID AND F.CPROF_ID = 1000 AND OrgID = '+IntToStr(FId);
    Open;
    chkGPZGPPNone.Checked := (FieldByName('COL_2').AsInteger+FieldByName('COL_11').AsInteger) = 0;
    Close;
    SQL.Text := 'SELECT LAST_DATE FROM v_ORG WHERE OrgID = '+IntToStr(FId);
    Open;
    chkReportNone.Checked := Fields[0].AsDateTime < IniSupport.GetReportDate;
  finally
    FLoading := false;
    Free;
  end;
  btnApply.Enabled := false;
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
    SQL.Text := 'select KODTERR, NAME from KTERR where IS_OKATO=1';
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
          tn := dxtOKATO.Add
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

procedure TfmOrgProp.LoadStrings(AList: TStrings; ASQL: string;
  FHasNull: boolean);
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
      AList.AddObject(Fields[1].AsString,Pointer(Fields[0].AsInteger));
      Next;
    end;
  finally
    Free;
  end;
end;

procedure TfmOrgProp.LocateOKATO(Sender: TdxTreeList; Value: string);
  function FindNode(node: TdxTreeListNode): boolean;
  var n: Integer;
  begin
    Result := false;
    for n:=0 to node.Count-1 do
      if node.Items[n].Strings[0]=Value then begin
        node.Items[n].Focused := true;
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
    if (Sender as TdxTreeList).Items[n].Strings[0]=Value then begin
      (Sender as TdxTreeList).Items[n].Focused := true;
      break;
    end else
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

procedure TfmOrgProp.cbOKFSChange(Sender: TObject);
begin
  if cbOKFS.ItemIndex>0 then
    case StrToInt('0'+Copy(cbOKFS.Text,1,2)) of
      10,11,12,17,30,31,40,41,42,43,49:
        cbVV5.ItemIndex := 1;
      13,14:
        cbVV5.ItemIndex := 2;
      15,16,18,19,20,22,34,35,50,51,52,53,54:
        cbVV5.ItemIndex := 4;
    end;
  mmName.OnChange(Self);
end;

procedure TfmOrgProp.cbOVKButtonClick(Sender: TObject);
var S: String;
begin
  EditBaseLstModal('KOVK');
  S := cbOVK.Text;
  LoadStrings(cbOVK.Items,'SELECT OVK_ID, OVK_NAME FROM KOVK ORDER BY OVK_NAME');
  cbOVK.ItemIndex := Max(cbOVK.Items.IndexOf(S),0);
end;

procedure TfmOrgProp.edOKBVExit(Sender: TObject);
var s: string;
    n: Integer;
begin
//calc OKBV number
  if not FLoading then
    if Integer(cbTerr.Items.Objects[cbTerr.ItemIndex])=FCurrTerr then begin
      s := EmptyStr;
      for n:=1 to Length(edOKBV.Text) do
        if edOKBV.Text[n] in ['0'..'9'] then
          s := s + edOKBV.Text[n]
        else
          if s<>EmptyStr then break;
      if s<>EmptyStr then
        edOKBV.Text := s + dmMain.GetOKBVSuffix(FId,true,chkHasBron.Checked);
    end;
end;

function TfmOrgProp.FStoreData: boolean;
//
  function NULLIF(Value1,Value2: Variant): Variant;
  begin
    if Value1=Value2 then Result := NULL else Result := Value1;
  end;
  function DateValue(e:TdxDateEdit): Variant;
  begin
    if e.Text = EmptyStr
      then Result := NULL
      else Result := e.Date;
  end;
  function PickValue(tree: TdxTreeList; col: TdxTreeListPickColumn; const n: Integer): Variant;
  begin
    with col do
    Result := NULLIF(Integer(Items.Objects[Items.IndexOf(tree.Items[n].Strings[Index])]),0);
  end;
//
var n: Integer;
    s, ss: string;
begin
  ModalResult := mrNone;
  Result := false;
//check not null values
  if Trim(mmName.Text)=EmptyStr then begin
    mmName.SetFocus;
    ShowErr('Не указано наименование организации!');
    Exit;
  end;
  if Trim(edSName.Text)=EmptyStr then begin
    edSName.Text := mmName.Text;
    {edSName.SetFocus;
    ShowErr('Не указано краткое наименование организации!');
    Exit;}
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
    ShowErr('Не указано фактическое ОКАТО!');
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
  if not CheckOkved(Trim(edOKONH.Text)) then begin
    edOKONH.SetFocus;
    ShowErr('Неверный код ОКВЭД: '+Trim(edOKONH.Text));
    Exit;
  end;
  s := StringReplace(GetOkonhText(FOKONHList.mmOKONH.Text, edOKONH.Text),' ','',[rfReplaceAll]);
  n := Pos(',', s);
  repeat
    ss := Copy(s, 1, n-1);
    if not CheckOkved(ss) then begin
      edOKONH.SetFocus;
      ShowErr('Неверный код ОКВЭД: '+ss);
      Exit;
    end;
    s := Copy(s, n+1, MaxInt);
    n := Pos(',', s);
  until n = 0;
  if not CheckOkved(s) then begin
    edOKONH.SetFocus;
    ShowErr('Неверный код ОКВЭД: '+s);
    Exit;
  end;

  if cbOKFS.ItemIndex<=0 then begin
    cbOKFS.SetFocus;
    ShowErr('Не задан ОКФС!');
    Exit;
  end;
  if Trim(cbOVK.Text)=EmptyStr then begin
    cbOVK.SetFocus;
    ShowErr('Не задан ОВК!');
    Exit;
  end;
  if cbForm6Shifr.ItemIndex<0 then begin
    cbForm6Shifr.SetFocus;
    ShowErr('Не задан Шифр формы № 6!');
    Exit;
  end;
  if cbTerr.ItemIndex<=0 then begin
    cbTerr.SetFocus;
    ShowErr('Не задана область курирования вышестоящего ВУО!');
    Exit;
  end;
  n := FCheckOKBV;
  if n <> 0 then begin
    edOKBV.SetFocus;
    ShowErr('Такой № в ВУО уже существует!'#13#10'Ближайший свободный номер '+IntToStr(n));
    Exit;
  end;

  if Copy(Trim(cbOKOPF.Text), 1, 1)='-' then begin
    cbOKOPF.SetFocus;
    ShowErr('Устаревшее значение справочника ОКОПФ!');
    Exit;
  end;

  //HAS_BRON - Form6
  if FID>0 then
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; paramCheck := false;
    SQL.Text := 'SELECT HAS_BRON FROM ORG WHERE ORGID='+IntToStr(FID);
    Open;
    if Fields[0].AsBoolean<>chkHasBron.Checked then begin
      if chkHasBron.Checked then begin
        ShowInfo('ВНИМАНИЕ: Изменено значение флага "Ведёт бронирование"!'#13#13+
         'Организация, ведущая бронирование, отчитывается не формой №18,'+
         ' а более подробной формой №6 (по каждой категории работников отдельно).'
         {' Сейчас в форме №6 заполнена только строка 25. Введите недостающие данные по категориям вручную.'+
         ' Во избежание двойного счёта не забудьте обнулить строку 25!'});
      end
      else begin
        Close;
        SQL.Text := 'SELECT * FROM FORM6 F, FORM6HDR H WHERE F.F6_ID=H.F6_ID AND H.ORGID='+IntToStr(FID)+
         ' AND (ISNULL(F.COL_6,0)<>0 OR'+
         '      ISNULL(F.COL_7,0)<>0 OR'+
         '      ISNULL(F.COL_8,0)<>0)';
        Open;
        if IsEmpty then begin

          ShowInfo('ВНИМАНИЕ: Изменено значение флага "Ведёт бронирование"!'#13#13+
           'Организация, не ведущая бронирование, отчитывается не формой №6,'+
           ' а формой №18.');

          Close;

          {SQL.Text := 'UPDATE FORM6 SET COL_1=F26.COL_1,COL_2=F26.COL_2,COL_3=F26.COL_3,'+
          'COL_4=F26.COL_4,COL_5=F26.COL_5,COL_6=F26.COL_6,COL_7=F26.COL_7,'+
          'COL_8=F26.COL_8,COL_9=F26.COL_9,COL_10=F26.COL_10,COL_11=F26.COL_11,'+
          'COL_12=F26.COL_12,COL_13=F26.COL_13,COL_14=F26.COL_14,COL_15=F26.COL_15,COL_16=F26.COL_16'+
          ' FROM FORM6, FORM6 F26, FORM6HDR H WHERE FORM6.F6_ID=H.F6_ID AND F26.F6_ID=H.F6_ID AND H.ORGID='+IntToStr(FID)+
          ' AND FORM6.COL_B=25 AND F26.COL_B=26';
          ExecSQL;

          SQL.Text := 'UPDATE FORM6 SET COL_1=NULL,COL_2=NULL,COL_3=NULL,COL_4=NULL,COL_5=NULL,COL_6=NULL,COL_7=NULL,'+
          'COL_8=NULL,COL_9=NULL,COL_10=NULL,COL_11=NULL,COL_12=NULL,COL_13=NULL,COL_14=NULL,COL_15=NULL,COL_16=NULL'+
          ' FROM FORM6, FORM6HDR H WHERE FORM6.F6_ID=H.F6_ID AND FORM6.CPROF_ID<1500 AND H.ORGID='+IntToStr(FID);
          ExecSQL;}

        end
        else begin
          ShowErr('ВНИМАНИЕ: Изменено значение флага "Ведёт бронирование"!'#13#13+
           'Согласно форме №6 в организации имеются забронированные работники. Для снятия флага '+
           ' "Ведёт бронирование" следует откорректировать форму №6.');
          chkHasBron.Checked := True;
          Exit;
        end;
      end;
    end;
  finally Free;
  end;



  if not FCheckOrgName then Exit;
  if not FCheckINN then Exit;
  if not FCheckOKPO then Exit;


  if FKOPF_Changed then begin
    if Confirm('Сверка кода ОКОПФ проведена?') then
      FKOPF_Changed := False;
  end;
  if FOkved_Changed then begin
    if Confirm('Сверка кода ОКВЭД проведена?') then
      FOkved_Changed := False;
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
      FieldByName('INN').Value := NULLIF(edINN.Text,EmptyStr);
      FieldByName('OKPO').Value := NULLIF(edOKPO.Text,EmptyStr);
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
      FieldByName('REGDATE').Value := DateValue(dtRegDate);
      FieldByName('REGNUM').Value := NULLIF(edRegNum.Text,EmptyStr);
      FieldByName('ORGNAME').Value := NULLIF(mmName.Text,EmptyStr);
      FieldByName('ORGSNAME').Value := NULLIF(edSName.Text,EmptyStr);
      FieldByName('COMMENT').Value := NULLIF(FCommon.mmComments.Text,EmptyStr);
      FieldByName('FIZADDR').Value := NULLIF(edFactAddr.Text,EmptyStr);
      FieldByName('URADDR').Value := NULLIF(edUAddr.Text,EmptyStr);
      FieldByName('POSTADDR').Value := NULLIF(FCommon.edPostAddr.Text,EmptyStr);
      FieldByName('PHONE').Value := NULLIF(FCommon.edPhone.Text,EmptyStr);
      FieldByName('EMAIL').Value := NULLIF(FCommon.edEmail.Text,EmptyStr);
      FieldByName('WWW').Value := NULLIF(FCommon.edWww.Text,EmptyStr);
      FieldByName('FAX').Value := NULLIF(FCommon.edFax.Text,EmptyStr);
      FieldByName('CONFDATE').Value := DateValue(dtConf);
      FieldByName('MAINOKONH').Value := NULLIF(edOKONH.Text,EmptyStr);
      FieldByName('OKBV').Value := NULLIF(edOKBV.Text,EmptyStr);
      FieldByName('OCCUPATION').Value := NULLIF(edOccupation.Text,EmptyStr);
      FieldByName('FIRST_DATE').Value := DateValue(dtFirst);
      FieldByName('LAST_DATE').Value := DateValue(dtLast);
      FieldByName('OUT_REASON').Value := NULLIF(edOut.Text,EmptyStr);
      FieldByName('OUT_DATE').Value := DateValue(dtOut);
      FieldByName('Feature1').Value := NULLIF(edFeature1.Text,EmptyStr);
      FieldByName('Feature2').Value := NULLIF(edFeature2.Text,EmptyStr);
      FieldByName('Feature3').Value := NULLIF(edFeature3.Text,EmptyStr);
      FieldByName('OVK_ID').Value := NULLIF(Integer(cbOVK.Items.Objects[cbOVK.ItemIndex]),0);
      FieldByName('SBM_ID').Value := NULLIF(Integer(cbVV5.Items.Objects[cbVV5.ItemIndex]),0);
      FieldByName('TERR_ID').Value := Integer(cbTERR.Items.Objects[cbTerr.ItemIndex]);
      FieldByName('HAS_BRON').Value := chkHasBron.Checked;
      FieldByName('F6_SHIFR').Value := NULLIF(cbForm6Shifr.Text,EmptyStr);
      FieldByName('REGPLACE').Value := NULLIF(eRegPlace.Text,EmptyStr);
      FieldByName('CHK_DATE').Value := DateValue(dtCheck);
      FieldByName('OKATO3').Value := NULLIF(FCommon.cbOKATO3.Text,EmptyStr);
      FieldByName('KOPF_Changed').Value := FKOPF_Changed;
      FieldByName('Okved_Changed').Value := FOkved_Changed;
      Post;
      FId := FieldByName('OrgId').Value;
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
        FieldByName('OrgId').Value := FId;
        FieldByName('Fam').Value := NULLIF(FContacts.edFam1.Text,EmptyStr);
        FieldByName('Im').Value := NULLIF(FContacts.edIm1.Text,EmptyStr);
        FieldByName('Otch').Value := NULLIF(FContacts.edOtch1.Text,EmptyStr);
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
        FieldByName('OrgId').Value := FId;
        FieldByName('Fam').Value := NULLIF(FContacts.edFam2.Text,EmptyStr);
        FieldByName('Im').Value := NULLIF(FContacts.edIm2.Text,EmptyStr);
        FieldByName('Otch').Value := NULLIF(FContacts.edOtch2.Text,EmptyStr);
        FieldByName('Phone').Value := NULLIF(FContacts.edPhone2.Text,EmptyStr);
        FieldByName('Post').Value := NULLIF(FContacts.edPost2.Text,EmptyStr);
        FieldByName('IS_GEN').Value := 0;
        FieldByName('IS_VUS').Value := 1;
        Post;
      end;
      if (FContacts.edFam3.Text<>EmptyStr) or (FContacts.edIm3.Text<>EmptyStr) or
         (FContacts.edOtch3.Text<>EmptyStr) or (FContacts.edPhone3.Text<>EmptyStr) or
         (FContacts.edPost3.Text<>EmptyStr) then
      begin
        Append;
        FieldByName('OrgId').Value := FId;
        FieldByName('Fam').Value := NULLIF(FContacts.edFam3.Text,EmptyStr);
        FieldByName('Im').Value := NULLIF(FContacts.edIm3.Text,EmptyStr);
        FieldByName('Otch').Value := NULLIF(FContacts.edOtch3.Text,EmptyStr);
        FieldByName('Phone').Value := NULLIF(FContacts.edPhone3.Text,EmptyStr);
        FieldByName('Post').Value := NULLIF(FContacts.edPost3.Text,EmptyStr);
        FieldByName('IS_GEN').Value := 2;
        FieldByName('IS_VUS').Value := 0;
        Post;
      end;
      Close;
      SQL.Text := 'delete from OSN where OrgId='+IntToStr(FId);
      ExecSQL;
      SQL.Text := 'select * from OSN where OrgId='+IntToStr(FId);
      Open;
      for n:=0 to FOsnPer.dxtOSN.Count-1 do begin
        Append;
        FieldByName('ORGID').Value := FId;
        FieldByName('BASE_ID').Value := PickValue(FOsnPer.dxtOSN,FOsnPer.colBASE_ID,n);
        FieldByName('DOC_ID').Value :=  PickValue(FOsnPer.dxtOSN,FOsnPer.colDOC_ID,n);
        FieldByName('DOC_NO').Value := NULLIF(FOsnPer.dxtOSN.Items[n].Strings[FOsnPer.colDOC_NO.Index],EmptyStr);
        s := FOsnPer.dxtOSN.Items[n].Strings[FOsnPer.colDOC_DATE.Index];
        if s=EmptyStr
          then FieldByName('DOC_DATE').Value := NULL
          else FieldByName('DOC_DATE').Value := StrToDate(s);
        Post;
      end;
      Close;
      SQL.Text := 'delete from PER where OrgId='+IntToStr(FId);
      ExecSQL;
      SQL.Text := 'select * from PER where OrgId='+IntToStr(FId);
      Open;
      for n:=0 to FOsnPer.dxtPer.Count-1 do begin
        Append;
        FieldByName('ORGID').Value := FId;
        FieldByName('PER_NO').Value := NULLIF(FOsnPer.dxtPer.Items[n].Strings[FOsnPer.colpPER_NO.Index],EmptyStr);
        FieldByName('RAZD_NO').Value := NULLIF(FOsnPer.dxtPer.Items[n].Strings[FOsnPer.colpRAZD_NO.Index],EmptyStr);
        FieldByName('Okved_Name').Value := NULLIF(FOsnPer.dxtPer.Items[n].Strings[FOsnPer.colpOkvedName.Index],EmptyStr);
        Post;
      end;
      Close;
    finally
      Free;
    end;
    Result := true;
    btnApply.Enabled := false;
    UpdateForm6;
    if FParentValid then begin
      FParentList.qrData.Requery;
      FParentList.qrData.Locate('ORGID',FId,[]);
    end;
  except
    on E: Exception do
      ShowErr('Ошибка при сохранении сведений об организации!'#13#13+E.Message);
  end;
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

procedure TfmOrgProp.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmOrgProp.btnOkClick(Sender: TObject);
begin
  btnOk.SetFocus;
  if FId<0 then begin
    ReturnFilter; Exit;
  end;
  if not btnApply.Enabled then begin
    if FOkved_Changed then begin
      if Confirm('Сверка кода ОКВЭД проведена?') then begin
        FOkved_Changed := False;
        if FStoreData then
          Close;
      end else
        Close;
    end else
      Close;
  end else if FStoreData then
    Close;
end;

procedure TfmOrgProp.btnApplyClick(Sender: TObject);
begin
  btnApply.SetFocus;
  if FStoreData then FLoadData;
end;

procedure TfmOrgProp.sbFirstClick(Sender: TObject);
begin
  if not FCanMove then Exit;
  if FParentValid then begin
    FParentList.dbgData.GotoFirst;
    if not FParentList.qrData.IsEmpty then
      if FId<>FParentList.qrData.FieldByName('OrgId').Value then begin
        FId := FParentList.qrData.FieldByName('OrgId').Value;
        FLoadData;
      end;
  end
  else
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select top 1 OrgId from Org order by OrgName';
      Open;
      if not IsEmpty then
        if FId<>Fields[0].AsInteger then begin
          FId := Fields[0].AsInteger;
          FLoadData;
        end;
    finally
      Free;
    end;
end;

procedure TfmOrgProp.sbPriorClick(Sender: TObject);
begin
  if not FCanMove then Exit;
  if FParentValid then begin
    FParentList.dbgData.GotoPrev(false);
    if not FParentList.qrData.IsEmpty then
      if FId<>FParentList.qrData.FieldByName('OrgId').Value then begin
        FId := FParentList.qrData.FieldByName('OrgId').Value;
        FLoadData;
      end;
  end
  else
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select top 1 OrgId from Org where OrgName<(select OrgName from Org where OrgId='+IntToStr(FId)+') order by OrgName desc';
      Parameters.ParseSQL(SQL.Text,true);
      Open;
      if not IsEmpty then
        if FId<>Fields[0].AsInteger then begin
          FId := Fields[0].AsInteger;
          FLoadData;
        end;
    finally
      Free;
    end;
end;

procedure TfmOrgProp.sbNextClick(Sender: TObject);
begin
  if not FCanMove then Exit;
  if FParentValid then begin
    FParentList.dbgData.GotoNext(false);
    if not FParentList.qrData.IsEmpty then
      if FId<>FParentList.qrData.FieldByName('OrgId').Value then begin
        FId := FParentList.qrData.FieldByName('OrgId').Value;
        FLoadData;
      end;
  end
  else
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select top 1 OrgId from Org where OrgName>(select OrgName from Org where OrgId='+IntToStr(FId)+') order by OrgName';
      Parameters.ParseSQL(SQL.Text,true);
      Open;
      if not IsEmpty then
        if FId<>Fields[0].AsInteger then begin
          FId := Fields[0].AsInteger;
          FLoadData;
        end;
    finally
      Free;
    end;
end;

procedure TfmOrgProp.sbLastClick(Sender: TObject);
begin
  if not FCanMove then Exit;
  if FParentValid then begin
    FParentList.dbgData.GotoLast(false);
    if not FParentList.qrData.IsEmpty then
      if FId<>FParentList.qrData.FieldByName('OrgId').Value then begin
        FId := FParentList.qrData.FieldByName('OrgId').Value;
        FLoadData;
      end;
  end
  else
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select top 1 OrgId from Org order by OrgName desc';
      Open;
      if not IsEmpty then
        if FId<>Fields[0].AsInteger then begin
          FId := Fields[0].AsInteger;
          FLoadData;
        end;
    finally
      Free;
    end;
end;

function TfmOrgProp.FCanMove: boolean;
begin
  Result := true;
  OnCloseQuery(Self,Result);
end;

function TfmOrgProp.FParentValid: boolean;
var n: Integer;
begin
  if Assigned(FParentList) then begin
    Result := true;
    for n:=0 to Application.MainForm.MDIChildCount-1 do
      if Application.MainForm.MDIChildren[n]=FParentList then Exit;
    FParentList := nil;
  end;
  Result := false;
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
          dmMain.UpdateCurrentOKBV;
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

function TfmOrgProp.FCheckOKBV: Integer;
var
  iOKBV: Integer;
begin
  Result := 0;
  if Trim(edOKBV.Text) = '' then Exit;
  with TADOQuery.Create(Self) do
  try
    iOKBV := ExtractNumber(edOKBV.Text);
    Connection := dmMain.dbMain;
    SQL.Text :=
      'select dbo.ExtractNumber(OKBV) from ORG where dbo.ExtractNumber(OKBV)>=:OKBV and OrgId<>'+IntToStr(FId)+
      ' Order by dbo.ExtractNumber(OKBV)';
    Parameters.ParseSQL(SQL.Text,true);
    Parameters.ParamByName('OKBV').Value := iOKBV;
    Open;
    if Fields[0].AsInteger <> iOKBV then Result := 0
    else begin
      repeat
        Inc(iOKBV);
        Next;
      until Eof or (Fields[0].AsInteger <> iOKBV);
      Result := iOKBV;
    end;
  finally
    Free;
  end;
end;

function TfmOrgProp.FCheckOrgName: boolean;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select count(*) from ORG where OrgName=:OrgName and OrgId<>'+IntToStr(FId);
    Parameters.ParseSQL(SQL.Text,true);
    Parameters.ParamByName('OrgName').Value := mmName.Text;
    Open;
    Result := Fields[0].AsInteger=0;
    if not Result then
      Result := Confirm('В базе данных присутствует организация с таким наименованием!'#13+
                        'Продолжить сохранение?');

  finally
    Free;
  end;
end;

function TfmOrgProp.FCheckINN: boolean;
begin
  if edINN.Text=EmptyStr then Result := true
  else
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select count(*) from ORG where INN=:INN and OrgId<>'+IntToStr(FId);
      Parameters.ParseSQL(SQL.Text,true);
      Parameters.ParamByName('INN').Value := edINN.Text;
      Open;
      Result := Fields[0].AsInteger=0;
      if not Result then
        Result := Confirm('В базе данных присутствует организация с таким ИНН!'#13+
                          'Продолжить сохранение?');

    finally
      Free;
    end;
end;

function TfmOrgProp.FCheckOKPO: boolean;
begin
  if edOKPO.Text=EmptyStr then Result := true
  else
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select count(*) from ORG where OKPO=:OKPO and OrgId<>'+IntToStr(FId);
      Parameters.ParseSQL(SQL.Text,true);
      Parameters.ParamByName('OKPO').Value := edOKPO.Text;
      Open;
      Result := Fields[0].AsInteger=0;
      if not Result then
        Result := Confirm('В базе данных присутствует организация с таким ОКПО!'#13+
                          'Продолжить сохранение?');

    finally
      Free;
    end;
end;

procedure TfmOrgProp.UpdateForm6;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'UPDATE FORM6HDR '+
                'SET ORGNAME = :ORGNAME, '+
                'F6_SHIFR = :F6SHIFR '+
                'WHERE ORGID=:ORGID';
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
  finally
    Free;
  end;
end;

procedure TfmOrgProp.ReturnFilter;
var
  I,J: Integer;
  S: String;
begin
  for I := Low(AFilterArray) to High(AFilterArray) do
  with AFilterArray[I] do
  if Changed then begin
    S := '';
    case FldType of
      ptString  : begin
        if Control is TMemo        then S := (Control as Tmemo).Lines.Text else
        if Control is TdxPopupEdit then S := (Control as TdxPopupEdit).Text else
                                        S := (Control as TEdit).Text;
        S := Trim(S);
        if S<>'' then S := '(value) LIKE '+QuotedStr('%'+S+'%');
      end;
      ptDate    :
        if (Control as TdxDateEdit).Text <> ''
        then S := Format('(value) >= ''%s'' AND (value) <= ''%0:s''',
          [FormatDateTime('YYYYMMDD',(Control as TdxDateEdit).Date)]);
      ptInteger : Continue;
      ptList    :
        if Control is TdxMRUEdit then
        with (Control as TdxMRUEdit) do
        if ItemIndex>0 then begin
          S := IntToStr(Integer(Items.Objects[ItemIndex]));
          S := '(value) IN ('+S+')';
        end
        else
        with (Control as TdxPickEdit) do  if ItemIndex>0 then begin
          if Control = cbForm6Shifr
            then S := RightStr(Items[ItemIndex],1)
            else S := IntToStr(Integer(Items.Objects[ItemIndex]));
          S := '(value) IN ('+S+')';
        end;
      ptSet     : begin
        S := Trim((Control as TEdit).Text);
        if S<>'' then S := '(value) IN ('+QuotedStr(S)+')';
      end;
      ptBoolean : case (Control as TCheckBox).State of
        cbChecked   : S := '(value) != 0';
        cbUnchecked : S := '(value) = 0';
      end;
      ptCompare : Continue;
    end;// case
    with TStringList(FParentList) do begin
      J := IndexOfName(FldName);
      if (S='')
      then
        if J>=0 then Delete(J) else
      else
        if J<0 then Add(FldName+'='+S) else ValueFromIndex[J] := S;
    end;
  end;//for
end;

procedure TfmOrgProp.cbRegPlaceExit(Sender: TObject);
begin
  if Sender is TdxMRUEdit then
    with (Sender as TdxMRUEdit) do ItemIndex := Max(ItemIndex, 0)
  else
  if Sender is TdxPickEdit then
    with (Sender as TdxPickEdit) do ItemIndex := Max(ItemIndex, 0);
end;

function TfmOrgProp.CheckOkved(s: String): Boolean;
begin
  if Length(s) = 0 then Result := true
  else if ((Length(s) = 2) and (s[1] in ['0'..'9']) and (s[2] in ['0'..'9'])) or
     ((Length(s) > 3) and (s[1] in ['0'..'9']) and (s[2] in ['0'..'9']) and (s[3] = '.')) then begin
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'Select * From KOkved where '+Copy(s, 1, 2)+' BETWEEN OKVED_BEGIN AND OKVED_END';
      Open;
      Result := not Eof;
    finally
      Free;
    end;

  end else Result := false;
end;

end.


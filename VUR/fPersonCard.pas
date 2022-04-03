unit fPersonCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Menus, ExtCtrls, dxExEdtr, dxEdLib,
  dxDBELib, dxDBEdtr, dxCntner, dxEditor, dxTL, dxTLClms, ADOdb, Db,
  fNav, Variants, fPersLst, dxDBTLCl, dxGrClms, dxDBCtrl, dxDBGrid,
  frmWUch1, frmWUch2, frmAddr,
  Mask, ActnList, ADOInt, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  cxButtons, System.Actions, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCheckBox, cxCheckComboBox;

const WM_OPEN_WUCH2 = WM_User + 2;

type
  TfmPersonForm = class(TForm)
    PC: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    tabSheetX0: TTabSheet;
    TabSheet4: TTabSheet;
    Label3: TLabel;
    Bevel1: TBevel;
    btnOk: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    dtBirth: TdxDateEdit;
    Label19: TLabel;
    dxtLang: TdxTreeList;
    colLangName: TdxTreeListPickColumn;
    colLangSkill: TdxTreeListPickColumn;
    pmLang: TPopupMenu;
    N7: TMenuItem;
    N8: TMenuItem;
    Label21: TLabel;
    Label22: TLabel;
    edDipl1: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    cbUz1: TdxPickEdit;
    Label27: TLabel;
    cbEduc: TComboBox;
    cbUz2: TdxPickEdit;
    edDipl2: TEdit;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    edOKPDTR1: TEdit;
    edOKPDTR2: TEdit;
    Label1: TLabel;
    edFam: TEdit;
    Label2: TLabel;
    edIm: TEdit;
    Label37: TLabel;
    edOtch: TEdit;
    edBirth: TEdit;
    Label39: TLabel;
    cbNat: TComboBox;
    Label4: TLabel;
    edINN: TEdit;
    Label38: TLabel;
    edStrah: TEdit;
    Label40: TLabel;
    rbMale: TRadioButton;
    rbFemale: TRadioButton;
    Bevel2: TBevel;
    Label41: TLabel;
    edTabNumb: TEdit;
    Label43: TLabel;
    Label44: TLabel;
    edDogNumb: TEdit;
    dtDogDate: TdxDateEdit;
    Label49: TLabel;
    cbWRange: TComboBox;
    Label50: TLabel;
    cbWProf: TComboBox;
    Label51: TLabel;
    edCZap: TEdit;
    Label52: TLabel;
    edVUS: TEdit;
    Label53: TLabel;
    edWCat: TEdit;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    edProf1: TEdit;
    edProf2: TEdit;
    qrWRange: TADOQuery;
    qrData: TADOQuery;
    Label60: TLabel;
    dtConf: TdxDateEdit;
    pnlWarMain: TPanel;
    lbCateg: TLabel;
    chkVoen: TCheckBox;
    qrAddr: TADOQuery;
    dsData: TDataSource;
    qrPhones: TADOQuery;
    qrLangs: TADOQuery;
    qrFam: TADOQuery;
    qrEduc: TADOQuery;
    edWDiscl: TEdit;
    Label61: TLabel;
    dtWEnd: TdxDateEdit;
    Label62: TLabel;
    edNumbT2: TEdit;
    Label63: TLabel;
    dtWBeg: TdxDateEdit;
    Label64: TLabel;
    dtOVK: TdxDateEdit;
    Label65: TLabel;
    dtWBil: TdxDateEdit;
    Bevel3: TBevel;
    Label66: TLabel;
    edOKATO: TEdit;
    edDate1: TEdit;
    edDate2: TEdit;
    Label5: TLabel;
    Bevel4: TBevel;
    btnAppointments: TButton;
    dtOutDate: TdxDateEdit;
    Label68: TLabel;
    Label69: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    edDate3: TEdit;
    edDipl3: TEdit;
    cbUz3: TdxPickEdit;
    Label36: TLabel;
    edKval3: TdxMRUEdit;
    Label83: TLabel;
    edEOARMY_DATE: TEdit;
    Label47: TLabel;
    Label42: TLabel;
    Label48: TLabel;
    Label45: TLabel;
    Label72: TLabel;
    Label84: TLabel;
    Label67: TLabel;
    Label70: TLabel;
    edOutOrdNumb: TEdit;
    Label71: TLabel;
    dtOutOrdDate: TdxDateEdit;
    Label85: TLabel;
    stWorkType: TEdit;
    stInDate: TEdit;
    stWorkChar: TEdit;
    stDepart: TEdit;
    stPost: TEdit;
    cbGos: TCheckBox;
    stCateg: TEdit;
    dxpOVK: TdxMRUEdit;
    laWID: TLabel;
    edWID: TEdit;
    Label59: TLabel;
    Label87: TLabel;
    cbBranch: TComboBox;
    Label86: TLabel;
    tabSheetX1: TTabSheet;
    lBeginStudy: TLabel;
    dtBeginStudy: TdxDateEdit;
    Label90: TLabel;
    dxtN26History: TdxTreeList;
    dxTreeListColumn1: TdxTreeListColumn;
    Label91: TLabel;
    edOrder: TEdit;
    Label92: TLabel;
    dtOrder: TdxDateEdit;
    Label93: TLabel;
    dtEndStudy: TdxDateEdit;
    PC1: TPageControl;
    TabSheet6: TTabSheet;
    tbVK: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    Label94: TLabel;
    edOrderAkadem: TEdit;
    Label95: TLabel;
    dtOrderAkadem: TdxDateEdit;
    Label96: TLabel;
    edReasonAkadem: TEdit;
    Label98: TLabel;
    dtBeginAkadem: TdxDateEdit;
    Label97: TLabel;
    dtEndAkadem: TdxDateEdit;
    Label99: TLabel;
    dtRealEndAkadem: TdxDateEdit;
    Label100: TLabel;
    rbNone: TRadioButton;
    rbInProcess: TRadioButton;
    rbCompleted: TRadioButton;
    rbFailed: TRadioButton;
    Label101: TLabel;
    Label102: TLabel;
    dtBeginWar: TdxDateEdit;
    Label103: TLabel;
    dtEndWar: TdxDateEdit;
    Label104: TLabel;
    dtRealEndWar: TdxDateEdit;
    Label105: TLabel;
    edOrderDismissal: TEdit;
    Label106: TLabel;
    dtOrderDismissal: TdxDateEdit;
    Label107: TLabel;
    edReasonDismissal: TEdit;
    Label108: TLabel;
    dtDismissal: TdxDateEdit;
    Label111: TLabel;
    Label116: TLabel;
    dtRealDefend: TdxDateEdit;
    Label117: TLabel;
    dtMedResult: TdxDateEdit;
    cbMedResult: TComboBox;
    Label118: TLabel;
    qrStudyHistory: TADOQuery;
    qrN26History: TADOQuery;
    pmN26History: TPopupMenu;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    dxtN26HistoryColumn4: TdxTreeListDateColumn;
    dxtN26HistoryColumn5: TdxTreeListDateColumn;
    Label119: TLabel;
    edReasonEndWar: TEdit;
    N1: TMenuItem;
    ActionList1: TActionList;
    aPrintForm26: TAction;
    dxtN26HistoryColumn6: TdxTreeListMaskColumn;
    Label120: TLabel;
    edContractEnd: TEdit;
    Label121: TLabel;
    edStudyForm: TEdit;
    Label125: TLabel;
    edDocNumb: TEdit;
    Label126: TLabel;
    dtDocDate: TdxDateEdit;
    Label127: TLabel;
    GroupBox1: TGroupBox;
    dxpDelay: TdxMRUEdit;
    Label122: TLabel;
    Label123: TLabel;
    dtDelayBeg: TdxDateEdit;
    dtDelayEnd: TdxDateEdit;
    GroupBox2: TGroupBox;
    Label128: TLabel;
    Label129: TLabel;
    dtHealthDoc_date: TdxDateEdit;
    edHealth: TEdit;
    edHealthDoc: TEdit;
    qrChanges: TADOQuery;
    qrChangesCHANGE_ID: TAutoIncField;
    qrChangesPERS_ID: TIntegerField;
    qrChangesGROUP_ID: TIntegerField;
    qrChangesOLDVALUE: TWideMemoField;
    qrChangesNEWVALUE: TWideMemoField;
    qrChangesCHANGE_DATE: TDateTimeField;
    qrChangesBEGIN_DATE: TDateTimeField;
    qrChangesNOTBEGINREASON: TWideStringField;
    qrChangesEND_DATE: TDateTimeField;
    qrChangesSEND_DATE: TDateTimeField;
    Label130: TLabel;
    dxtAssign: TdxTreeList;
    dxtAssign_date: TdxTreeListDateColumn;
    dxtAssignText: TdxTreeListMRUColumn;
    dxtAssignReason: TdxTreeListMRUColumn;
    qrAssign: TADOQuery;
    pmAssign: TPopupMenu;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    DataSource1: TDataSource;
    dbgData: TdxDBGrid;
    dbgDataColumn1: TdxDBGridDateColumn;
    dbgDataColumn2: TdxDBGridMaskColumn;
    dbgDataColumn3: TdxDBGridDateColumn;
    GroupBox3: TGroupBox;
    Label16: TLabel;
    edPhone1: TEdit;
    edPhone2: TEdit;
    Label17: TLabel;
    Label18: TLabel;
    edPhone3: TEdit;
    Label15: TLabel;
    lblConf: TLabel;
    edComments: TMemo;
    edWarfare: TEdit;
    Label110: TLabel;
    qrChangesOutNumber: TWideStringField;
    qrChangesOutDate: TDateTimeField;
    edWBNum: TEdit;
    edWBSer: TEdit;
    cbDocument: TComboBox;
    tabSheetX2: TTabSheet;
    dxtASAssign: TdxTreeList;
    dxTreeListDateColumn1: TdxTreeListDateColumn;
    dxtASAssignWhere: TdxTreeListMRUColumn;
    dxtASAssignWhat: TdxTreeListMRUColumn;
    Label131: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    dtASOut_Date: TdxDateEdit;
    Label135: TLabel;
    Label136: TLabel;
    edASOut_ORD_NUMB: TEdit;
    Label137: TLabel;
    dtASOut_ORD_Date: TdxDateEdit;
    stASPost: TEdit;
    stASDepart: TEdit;
    Label138: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    stASInDate: TEdit;
    btnASAppointments: TButton;
    Bevel5: TBevel;
    Label145: TLabel;
    Label146: TLabel;
    dtASOrder_Date: TdxDateEdit;
    edASOrder_In: TEdit;
    dxTreeList1Column4: TdxTreeListDateColumn;
    Label132: TLabel;
    psASAssing: TPopupMenu;
    MenuItem9: TMenuItem;
    MenuItem10: TMenuItem;
    qrASAssign: TADOQuery;
    Label139: TLabel;
    stASF: TEdit;
    GroupBox4: TGroupBox;
    edMed_Where: TEdit;
    Label140: TLabel;
    edMed_Result: TEdit;
    Label144: TLabel;
    edMed_Date: TdxDateEdit;
    Label147: TLabel;
    GroupBox5: TGroupBox;
    Label148: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    edPsy_Where: TEdit;
    edPsy_Result: TEdit;
    edPsy_Date: TdxDateEdit;
    Label151: TLabel;
    edAsf_Sport: TEdit;
    edWUch1Info: TEdit;
    bWUch1: TSpeedButton;
    bWUch2: TSpeedButton;
    edWUch2Info: TEdit;
    edWUch2_IsWork: TCheckBox;
    Label88: TLabel;
    qrChangesAppointment_Id: TIntegerField;
    stOKPDTR: TEdit;
    Label152: TLabel;
    dtWrng: TdxDateEdit;
    Label153: TLabel;
    Label154: TLabel;
    stCateg2015: TEdit;
    cbObrDoc1: TdxPickEdit;
    edDiplSer1: TEdit;
    Label155: TLabel;
    Label156: TLabel;
    Label28: TLabel;
    edDiplSer2: TEdit;
    Label157: TLabel;
    cbObrDoc2: TdxPickEdit;
    Label158: TLabel;
    Label159: TLabel;
    edDateGive3: TEdit;
    Label78: TLabel;
    Label160: TLabel;
    edDiplSer3: TEdit;
    Label161: TLabel;
    cbObrDoc3: TdxPickEdit;
    Label162: TLabel;
    cbFormPrep3: TdxPickEdit;
    edNapr4: TComboBox;
    edNapr1: TComboBox;
    edKval1: TComboBox;
    edNapr2: TComboBox;
    edKval2: TComboBox;
    edNapr3: TComboBox;
    bNapr1: TSpeedButton;
    SpeedButton1: TSpeedButton;
    bNapr3: TSpeedButton;
    bKval1: TSpeedButton;
    bKval2: TSpeedButton;
    bNapr4: TSpeedButton;
    edAssignText: TdxPickEdit;
    edAssignDate: TdxDateEdit;
    edAssignReason: TdxMRUEdit;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    TabSheetUpol: TTabSheet;
    Label166: TLabel;
    dxtPersDeps: TdxTreeList;
    colDepName: TdxTreeListPickColumn;
    qrPersDeps: TADOQuery;
    dtWBDate: TdxDateEdit;
    Label167: TLabel;
    Label169: TLabel;
    dtMobContract: TdxDateEdit;
    bDriver: TCheckBox;
    SpeedButton2: TSpeedButton;
    GroupBox6: TGroupBox;
    Label171: TLabel;
    Label172: TLabel;
    dtVodUdDate: TdxDateEdit;
    edVodUdNum: TEdit;
    Label173: TLabel;
    edVodUdSer: TEdit;
    Label170: TLabel;
    GroupBox7: TGroupBox;
    dtPspDate: TdxDateEdit;
    Label9: TLabel;
    edPspPlace: TEdit;
    Label8: TLabel;
    edPspNum: TEdit;
    Label7: TLabel;
    edPspSer: TEdit;
    cbKVodUd: TcxCheckComboBox;
    Label6: TLabel;
    bAddr: TButton;
    rbEduc1Main: TRadioButton;
    rbEduc2Main: TRadioButton;
    rbEduc3Main: TRadioButton;
    pmPersDeps: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    cbStudent: TCheckBox;
    edSovet_Shifr: TEdit;
    Label10: TLabel;
    edSovet_Org: TEdit;
    Label11: TLabel;
    edSovet_Num: TEdit;
    Label12: TLabel;
    edSovet_Org_Order: TEdit;
    Label13: TLabel;
    dtSovet_Date: TdxDateEdit;
    Label14: TLabel;
    rbWarProgram: TRadioGroup;
    bStudyHistory: TButton;
    Label20: TLabel;
    dxpWBOvk: TdxMRUEdit;
    procedure PCChanging(Sender: TObject; var AllowChange: Boolean);
    procedure PCDrawTab(Control: TCustomTabControl; TabIndex: Integer;
      const Rect: TRect; Active: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure cbWRangeChange(Sender: TObject);
    procedure chkVoenClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edFamChange(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edOKATOKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure btnAppointmentsClick(Sender: TObject);
    procedure dsDataDataChange(Sender: TObject; Field: TField);
    procedure edKval3ButtonClick(Sender: TObject);
    procedure dxpOVKButtonClick(Sender: TObject);
    procedure rbAspirantClick(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure edOrderAkademExit(Sender: TObject);
    procedure WarChange(Sender: TObject);
    procedure dxtStudyHistoryEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure aPrintForm26Update(Sender: TObject);
    procedure aPrintForm26Execute(Sender: TObject);
    procedure edKvalnNaprButtonClick(Sender: TObject);
    procedure edKvalnNaprChange(Sender: TObject);
    procedure dxpDelayButtonClick(Sender: TObject);
    procedure cbBranchDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbBranchSelect(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure cbGosClick(Sender: TObject);
    procedure dxtAssignEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure MenuItem9Click(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure btnASAppointmentsClick(Sender: TObject);
    procedure cbWProfChange(Sender: TObject);
    procedure bWUch1Click(Sender: TObject);
    procedure bWUch2Click(Sender: TObject);
    procedure edWUch2_IsWorkClick(Sender: TObject);
    procedure cbDocumentChange(Sender: TObject);
    procedure bNapr1Click(Sender: TObject);
    procedure bKval1Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure bDriverClick(Sender: TObject);
    procedure edVodUdSerKeyPress(Sender: TObject; var Key: Char);
    procedure bAddrClick(Sender: TObject);
    procedure bStudyHistoryClick(Sender: TObject);
  private
    { Private declarations }
    PrevTab: Integer;
    fChanged: boolean;
    fAkadem: boolean;
    fLoad: Boolean;
    fChanging: Boolean;
    isAllGroups: Boolean;
    hNav: HWND;
    FParentList: TfmPersonList;
    dep_full_name: string;
    Appointment_Id: Integer;
    OldValues, NewValues: array[1..10]of string;
    HideInCard: String;
    cbEduc_Saved: Integer;

    Post_Id, Dep_Id: Integer;
    OKVED: string;
    OKVEDChoice: TStringList;

    procedure WM_NavNotify(var msg: TMEssage); message WM_NAV_NOTIFY;
    procedure WM_OnMove(var msg: TMessage); message WM_MOVE;
    procedure RefreshAppointment;
    procedure RefreshStudyHistory;
    procedure RefreshASAppointment;
    procedure FillGroupValues(var groupvalues: array of string);
    procedure FillChanges;

    procedure GetPostAndDep;
    procedure SetPostAndDep;
  public
    { Public declarations}
    ID: Integer;
    fWUch1: TfWUch1;
    fWUch2: TfWUch2;
    fAddr: TfAddr;
    PDPCode: String;
    cbDocumentZero: integer;
    function GetIsStudent: Boolean;
    procedure LoadStrings(Items: TStrings; HasEmpty: boolean;
                          sSQL,FldID,FldData: string);
    procedure LoadComboStrings(CheckCombo: TcxCheckComboBox; sSQL,FldID,FldData: string);
    function LoadData: boolean;
    function StoreData: boolean;
    function ChkData: boolean;
    function ChkReserv(saving: Boolean): boolean;
    procedure CalcWuch1Info;
    procedure CalcWuch2Info;
    function GetPdpCode: String;
    function ClearPdpCode(PDPCode: String): String;
    function GetWSOST_IDstr: String;
    function GetWRng_IdStr: String;
    procedure LoadWStateList(force_all: Boolean);
    procedure SetWarPageActive;
    procedure OpenWuch2(var msg: TMessage); message WM_OPEN_WUCH2;
  end;

  procedure ShowPersonCard(id: Integer; ParentList: TfmPersonList);

implementation

uses
  msg, dMain, fMain, MD5, misc, fAppointments, fASAppointments, fBaseLst,
  DateUtils, Math, StrUtils, BirthDay, fStudyHistory;

{$R *.DFM}

procedure ShowPersonCard(id: Integer; ParentList: TfmPersonList);
var  fmPersonForm: TfmPersonForm;
     i: Integer;
begin
  fmPersonForm := nil;
  if id>0 then
    for i:=0 to Application.ComponentCount-1 do
      if Application.Components[i] is TfmPersonForm then
        if (Application.Components[i] as TfmPersonForm).ID=id then begin
          fmPersonForm := (Application.Components[i] as TfmPersonForm);
          break;
        end;
  if fmPersonForm=nil then begin
    Application.CreateForm(TfmPersonForm,fmPersonForm);
    if fmMain.MainScale <> 100 then
      fmPersonForm.ScaleBy(fmMain.MainScale, 100);
    fmPersonForm.ID := id;
    if id>0 then
      if not fmPersonForm.LoadData then begin
        fmPersonForm.Free;
        Exit;
      end;
  end;
  fmPersonForm.FParentList := ParentList;
  if IsIconic(fmPersonForm.Handle) then ShowWindow(fmPersonForm.Handle,SW_RESTORE);
  fmPersonForm.BringToFront;
end;

procedure TfmPersonForm.PCChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  PrevTab := PC.ActivePageIndex;
end;

procedure TfmPersonForm.PCDrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  i, j: Integer;
begin
  if TabIndex>5 then PC.Canvas.Font.Color := clGrayText
  else
    if Active then begin
      PC.Canvas.Brush.Color := clBtnHighlight;
      PC.Canvas.Font.Color := clHighlight
    end
    else PC.Canvas.Font.Color := clBtnText;
  i := 0; j := 0;
  while i < TabIndex do begin
    Inc(i); Inc(j);
    while not PC.Pages[j].TabVisible do Inc(j);
  end;

  PC.Canvas.TextRect(Rect,Rect.Left+5,Rect.Top+2,PC.Pages[j].Caption);
end;

procedure TfmPersonForm.rbAspirantClick(Sender: TObject);
var
  i: Integer;
begin
  dtBeginStudy.Text := '';
  edOrder.Text := '';
  dtOrder.Text := '';
  edStudyForm.Text := '';

  if cbStudent.Checked then begin
    RefreshStudyHistory;
  end;

  Application.ProcessMessages;
  edFamChange(nil);
end;

procedure TfmPersonForm.WarChange(Sender: TObject);
begin
  if fLoad then Exit;
  if (rbNone.Checked)and
     ((Trim(dtBeginWar.Text)<>'')or
     (Trim(dtEndWar.Text)<>'')or(Trim(dtRealEndWar.Text)<>'')or
     (Trim(edReasonEndWar.Text)<>'')) then
    ShowErr('При значении переключателя "к обучению не приступал" ' +
            '- даты начала, планового и фактического окончания обучения на ВК, '+
            'а также причина расторжения контракта' +
            ' не должны быть заполнены!');
  if (rbInProcess.Checked)and((Trim(dtRealEndWar.Text)<>'')or
     (Trim(edReasonEndWar.Text)<>'')) then
    ShowErr('При значении переключателя "обучается" ' +
            '- дата фактического окончания обучения на ВК' +
            'а также причина расторжения контракта не должны быть заполнены!');
  if (rbCompleted.Checked)and(Trim(edReasonEndWar.Text)<>'') then
    ShowErr('При значении переключателя "успешно окончил" ' +
            '- поле "причина расторжения контракта" не должно быть заполнено!');
  edFamChange(nil);
end;

procedure TfmPersonForm.LoadStrings(Items: TStrings; HasEmpty: boolean;
                        sSQL,FldID,FldData: string);
var DataOnly: Boolean;
  qry: TADOQuery;
begin
  DataOnly := FldID = EmptyStr;
  qry := TADOQuery.Create(Self);
  with qry do begin
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

procedure TfmPersonForm.LoadComboStrings(CheckCombo: TcxCheckComboBox; sSQL,FldID,FldData: string);
var
  qry: TADOQuery;
begin
  qry := TADOQuery.Create(Self);
  with qry do begin
    CheckCombo.ActiveProperties.Items.Clear;
    Connection := dmMain.dbMain;
    SQL.Text := sSQL;
    Open;
    while not EOF do begin
      CheckCombo.ActiveProperties.Items.AddCheckItem(
        FieldByName(FldData).AsString,
        FieldByName(FldID).AsString);
      Next;
    end;
    Free;
  end;
end;

procedure TfmPersonForm.LoadWStateList(force_all: Boolean);
var
  n: Integer;
  is_found: boolean;
  newCbDocumentZero, docInd: Integer;
begin
  if cbWRange.ItemIndex<0 then Exit;
  if not qrWRange.Active then qrWRange.Open;
  qrWRange.RecNo := Integer(cbWRange.Items.Objects[cbWRange.ItemIndex]);
  if cbWProf.ItemIndex>=0 then
     n := Integer(cbWProf.Items.Objects[cbWProf.ItemIndex])
  else n := -1;
  cbWProf.Items.Clear;
  with TADOQuery.Create(Self) do begin
    Connection := dmMain.dbMain;
    SQL.Text :=
      'SELECT * FROM KWSOST '+
      'WHERE STATE='+qrWRange.FieldByName('STATE').AsString + ' ' +
      'Order By WSost_Id';
    try
      Open;
      is_found := False;
      while not EOF do begin
        if force_all or ((n >= 0) and not is_found) or (FieldByName('WSOST_ID').AsInteger <> 17) then begin
          cbWProf.Items.AddObject(
            FieldByName('WSOST_NAME').AsString,
            Pointer(FieldByName('WSOST_ID').AsInteger));
          if n=FieldByName('WSOST_ID').AsInteger then begin
            cbWProf.ItemIndex := cbWProf.Items.Count-1;
            is_found := True;
          end;
        end;
        Next;
      end;
    except
    end;
    Free;
  end;
  (*if qrWRange.FieldByName('STATE').AsInteger = 0 then begin
    newCbDocumentZero := 1;
  end else begin
    newCbDocumentZero := 2;
  end;
  if cbDocumentZero <> newCbDocumentZero then begin
    docInd := cbDocument.ItemIndex;
    cbDocument.Items.Clear;
    if newCbDocumentZero = 1 then begin
      cbDocument.Items.Add('Приписное свидетельство');
      cbDocument.Items.Add('Справка взамен военного билета (справка уклониста)');
    end else if newCbDocumentZero = 2 then begin
      cbDocument.Items.Add('Военный билет');
      cbDocument.Items.Add('Временное удостоверение');
    end;
    if docInd > 1 then Dec(docInd,2);
    if (cbDocumentZero = 0) or force_all then
      cbDocument.ItemIndex := docInd
    else
      cbDocument.ItemIndex := -1;
    cbDocumentZero := newCbDocumentZero;
  end;*)
  edFam.OnChange(edFam);
end;

procedure TfmPersonForm.FormCreate(Sender: TObject);
begin
  FParentList := nil;
  ID := 0;
  PC.OwnerDraw := true;
  PC.ActivePageIndex := 0;
  PC1.ActivePageIndex := 0;
  fChanging := False;
  dep_full_name := '';
  fWUch1 := TfWUch1.Create(self);
  fWUch1.Visible := False;
  fWUch1.OnChange := edFamChange;
  fWUch2 := TfWUch2.Create(self);
  fWUch2.Visible := False;
  fWUch2.OnChange := edFamChange;
  fAddr := TfAddr.Create(self);
  fAddr.Visible := False;
  fAddr.OnChange := edFamChange;
  OKVEDChoice := TStringList.Create;
  (*cbDocumentZero := 0;*)

// Loading base lists
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select HasVK from Org where OrgId = (select min(OrgId) from Org)';
    Open;
    if Fields[0].IsNull or not Fields[0].AsBoolean then begin
      tbVK.Enabled := False;
      tbVK.Font.Color := clGrayText;
    end;
    Close;

    SQL.Text := 'SELECT * FROM Params Where Param_Id = 3';
    Open;
    HideInCard := FieldByName('Param_Value').AsString;
    if Pos('.0.', HideInCard) > 0 then tabSheetX0.TabVisible := False;
    if Pos('.1.', HideInCard) > 0 then tabSheetX1.TabVisible := False;
    if Pos('.2.', HideInCard) > 0 then tabSheetX2.TabVisible := False;
    Close;

    SQL.Text := 'SELECT * FROM Params Where Param_Id = 10';
    Open;
    isAllGroups := FieldByName('Param_Value').AsString = '1';
    Close;

  finally
    Free;
  end; 

  try
    LoadStrings(cbNat.Items,false,'SELECT * FROM KNATION ORDER BY NAT_NAME','NAT_ID','NAT_NAME');
    LoadStrings(colLangName.Items,false,'SELECT * FROM KLANG ORDER BY LANG_NAME','LANG_ID','LANG_NAME');
    LoadStrings(colLangSkill.Items,false,'SELECT * FROM KLANGSK','LSK_ID','LSK_NAME');
    LoadStrings(colDepName.Items,false,'SELECT * FROM KDepart ORDER BY DEP_NAME','DEP_ID','DEP_NAME');
    LoadStrings(fAddr.cbFamState.Items,false,'SELECT * FROM KFSTATE Where OKIN is not null ORDER BY '+
      'iif(IsNull(OKIN),999999,OKIN)','FST_ID','FST_NAME');
    LoadComboStrings(cbKVodUd, 'SELECT Code, Code + '' '' + Name as Name FROM KVodUd ORDER BY Code ',
      'Code','Name');
    LoadStrings(fAddr.colFamType.Items,false,'SELECT * FROM KFAMTYPE ORDER BY FT_NAME','FT_ID','FT_NAME');
    LoadStrings(cbEduc.Items,false,'SELECT * FROM KEDUC Where Okin is not null Order by '+
      'iif(IsNull(OKIN),999999,OKIN)','ED_ID','ED_NAME');
    LoadStrings(cbUz1.Items,false,'SELECT * FROM KUZ ORDER BY UZ_NAME','UZ_ID','UZ_NAME');
    LoadStrings(cbUz2.Items,false,'SELECT * FROM KUZ ORDER BY UZ_NAME','UZ_ID','UZ_NAME');
    LoadStrings(cbUz3.Items,false,'SELECT * FROM KUZ ORDER BY UZ_NAME','UZ_ID','UZ_NAME');
    LoadStrings(cbObrDoc1.Items,false,'SELECT * FROM KObrDoc ORDER BY KObrDoc_NAME','KObrDoc_ID','KObrDoc_NAME');
    LoadStrings(cbObrDoc2.Items,false,'SELECT * FROM KObrDoc ORDER BY KObrDoc_NAME','KObrDoc_ID','KObrDoc_NAME');
    LoadStrings(cbObrDoc3.Items,false,'SELECT * FROM KObrDoc ORDER BY KObrDoc_NAME','KObrDoc_ID','KObrDoc_NAME');
    LoadStrings(cbFormPrep3.Items,false,'SELECT * FROM KFormPrep ORDER BY KFormPrep_NAME','KFormPrep_ID','KFormPrep_NAME');
    LoadStrings(edKval1.Items,true,'SELECT Kval_Id, KVAL_Name FROM KKVAL ORDER BY KVAL_Name','Kval_Id','KVAL_Name');
    LoadStrings(edKval2.Items,true,'SELECT Kval_Id, KVAL_Name FROM KKVAL ORDER BY KVAL_Name','Kval_Id','KVAL_Name');
//    LoadStrings(edKval3.Items,false,'SELECT DISTINCT KVAL FROM EDUC WHERE Type=3 ORDER BY KVAL','','KVAL');
    LoadStrings(edKval3.Items,true,'SELECT * FROM KSCIENCE ORDER BY SC_NAME','SC_ID','SC_NAME');
    edKval3.ItemIndex := 0;
    LoadStrings(edNapr1.Items,true,'SELECT NAPR_ID, iif(IsNull(Napr_Kod), "", Trim(NAPR_KOD)) + " " + NAPR_NAME as NAPR_NAME FROM KNAPR ORDER BY NAPR_KOD, NAPR_NAME','NAPR_ID','NAPR_NAME');
    edNapr1.ItemIndex := edNapr1.Items.IndexOfObject(TObject(0));
    LoadStrings(edNapr2.Items,true,'SELECT NAPR_ID, iif(IsNull(Napr_Kod), "", Trim(NAPR_KOD)) + " " + NAPR_NAME as NAPR_NAME FROM KNAPR ORDER BY NAPR_KOD, NAPR_NAME','NAPR_ID','NAPR_NAME');
    edNapr2.ItemIndex := edNapr2.Items.IndexOfObject(TObject(0));
    LoadStrings(edNapr3.Items,true,'SELECT NAPR_ID, iif(IsNull(Napr_Kod), "", Trim(NAPR_KOD)) + " " + NAPR_NAME as NAPR_NAME FROM KNAPR ORDER BY NAPR_KOD, NAPR_NAME','NAPR_ID','NAPR_NAME');
    edNapr3.ItemIndex := edNapr3.Items.IndexOfObject(TObject(0));
    (*LoadStrings(edNapr1.Items,false,'SELECT DISTINCT NAPR FROM EDUC WHERE Type IN (1,2) ORDER BY NAPR','','NAPR');
    LoadStrings(edNapr2.Items,false,'SELECT DISTINCT NAPR FROM EDUC WHERE Type IN (1,2) ORDER BY NAPR','','NAPR');
    LoadStrings(edNapr3.Items,false,'SELECT DISTINCT NAPR FROM EDUC WHERE Type=3 ORDER BY NAPR','','NAPR');*)
//    LoadStrings(cbCateg.Items,false,'SELECT * FROM KCPROF WHERE STATE = 0 ORDER BY CPROF_ID','CPROF_ID','CPROF_NAME');
    LoadStrings(dxpOVK.Items,false,'SELECT * FROM KOVK ORDER BY OVK_NAME','OVK_ID','OVK_NAME');
    LoadStrings(dxpWBOVK.Items,false,'SELECT * FROM KOVK ORDER BY OVK_NAME','OVK_ID','OVK_NAME');
    LoadStrings(dxpDelay.Items,false,'SELECT ID, DelayName FROM KDELAY ORDER BY DelayName','ID','DelayName');

    LoadStrings(edAssignText.Items, false, 'SELECT Id, Name FROM KAssign ORDER BY Name','Id','Name');
    LoadStrings(edAssignReason.Items, false, 'SELECT DISTINCT AssignReason FROM Assign ORDER BY AssignReason','','AssignReason');

    //LoadStrings(dxtAssignText.Items, false, 'SELECT DISTINCT AssignText FROM Assign ORDER BY AssignText','','AssignText');
    //LoadStrings(dxtAssignReason.Items, false, 'SELECT DISTINCT AssignReason FROM Assign ORDER BY AssignReason','','AssignReason');
    //LoadStrings(dxtASAssignWhat.Items, false, 'SELECT DISTINCT AssignWhat FROM ASAssign ORDER BY AssignWhat','','AssignWhat');
    //LoadStrings(dxtASAssignWhere.Items, false, 'SELECT DISTINCT AssignWhere FROM ASAssign ORDER BY AssignWhere','','AssignWhere');

    //Сведения об учащемся
    LoadStrings(edNapr4.Items,true,'SELECT NAPR_ID, iif(IsNull(Napr_Kod), NAPR_NAME, NAPR_KOD+'' / ''+NAPR_NAME) As NAPR_NAME FROM KNAPR ORDER BY NAPR_KOD, NAPR_NAME','NAPR_ID','NAPR_NAME');
    edNapr4.ItemIndex := edNapr4.Items.IndexOfObject(TObject(0));
    //////////////////////

    qrWRange.Open;
    cbWRange.Items.Clear;
    while not qrWRange.EOF do begin
      cbWRange.Items.AddObject(qrWRange.FieldByName('WRNG_NAME').AsString,Pointer(qrWRange.RecNo));
      qrWRange.Next;
    end;
    lblConf.Caption := '<Не заполнено>';
    dtConf.Date := Date;
    fChanged := true;
    btnApply.Enabled := true;
  except
    ShowErr('Ошибка при загрузке базовых справочников!');
  end;
//create navigation window
  with TfmNav.Create(nil) do begin
    hParent := Self.Handle;
    Show;
    hNav := Handle;
  end;
  //rEdit
  edFam.Enabled := dmMain.rEdit;
  edIm.Enabled := dmMain.rEdit;
  edOtch.Enabled := dmMain.rEdit;
  rbMale.Enabled := dmMain.rEdit;
  rbFemale.Enabled := dmMain.rEdit;
  dtBirth.Enabled := dmMain.rEdit;
  edBirth.Enabled := dmMain.rEdit;
  edOKATO.Enabled := dmMain.rEdit;
  dtConf.Enabled := dmMain.rEdit;
  cbNat.Enabled := dmMain.rEdit;
  edINN.Enabled := dmMain.rEdit;
  edVodUdSer.Enabled := dmMain.rEdit;
  dtVodUdDate.Enabled := dmMain.rEdit;
  edVodUdNum.Enabled := dmMain.rEdit;
  cbKVodUd.Enabled := dmMain.rEdit;
  edPspSer.Enabled := dmMain.rEdit;
  edPspNum.Enabled := dmMain.rEdit;
  edStrah.Enabled := dmMain.rEdit;
  edPspPlace.Enabled := dmMain.rEdit;
  dtPspDate.Enabled := dmMain.rEdit;
  dxtLang.Enabled := dmMain.rEdit;
  dxtPersDeps.Enabled := dmMain.rEdit;
  fAddr.edIndex1.Enabled := dmMain.rEdit;
  fAddr.dtAddr_Date1.Enabled := dmMain.rEdit;
  fAddr.dtAddr_Date_End1.Enabled := dmMain.rEdit;
  fAddr.edAddr1.Enabled := dmMain.rEdit;
  fAddr.edIndex2.Enabled := dmMain.rEdit;
  fAddr.edAddr2.Enabled := dmMain.rEdit;
  fAddr.dtAddr_Date2.Enabled := dmMain.rEdit;
  edPhone1.Enabled := dmMain.rEdit;
  edPhone2.Enabled := dmMain.rEdit;
  edPhone3.Enabled := dmMain.rEdit;
  fAddr.cbFamState.Enabled := dmMain.rEdit;
  fAddr.dxtFamily.Enabled := dmMain.rEdit;
  cbEduc.Enabled := dmMain.rEdit;
  cbUz1.Enabled := dmMain.rEdit;
  cbObrDoc1.Enabled := dmMain.rEdit;
  cbObrDoc2.Enabled := dmMain.rEdit;
  cbObrDoc3.Enabled := dmMain.rEdit;
  cbFormPrep3.Enabled := dmMain.rEdit;
  edDiplSer1.Enabled := dmMain.rEdit;
  edDiplSer2.Enabled := dmMain.rEdit;
  edDiplSer3.Enabled := dmMain.rEdit;
  edDateGive3.Enabled := dmMain.rEdit;
  edDipl1.Enabled := dmMain.rEdit;
  edDate1.Enabled := dmMain.rEdit;
  edKval1.Enabled := dmMain.rEdit;
  edNapr1.Enabled := dmMain.rEdit;
  cbUz2.Enabled := dmMain.rEdit;
  edDipl2.Enabled := dmMain.rEdit;
  edDate2.Enabled := dmMain.rEdit;
  edKval2.Enabled := dmMain.rEdit;
  edNapr2.Enabled := dmMain.rEdit;
  cbUz3.Enabled := dmMain.rEdit;
  edDipl3.Enabled := dmMain.rEdit;
  edDate3.Enabled := dmMain.rEdit;
  edKval3.Enabled := dmMain.rEdit;
  edNapr3.Enabled := dmMain.rEdit;
  edProf1.Enabled := dmMain.rEdit;
  edOKPDTR1.Enabled := dmMain.rEdit;
  edProf2.Enabled := dmMain.rEdit;
  edOKPDTR2.Enabled := dmMain.rEdit;
  chkVoen.Enabled := dmMain.rEdit;
  edNumbT2.Enabled := dmMain.rEdit;
  cbDocument.Enabled := dmMain.rEdit;
  edWBSer.Enabled := dmMain.rEdit;
  edWBNum.Enabled := dmMain.rEdit;
  dtWBeg.Enabled := dmMain.rEdit;
  dtMobContract.Enabled := dmMain.rEdit;
  bDriver.Enabled := dmMain.rEdit;
  dtWBDate.Enabled := dmMain.rEdit;
  dtWRng.Enabled := dmMain.rEdit;
  cbBranch.Enabled := dmMain.rEdit;
  edWID.Enabled := dmMain.rEdit;
  edEOARMY_DATE.Enabled := dmMain.rEdit;
  cbWRange.Enabled := dmMain.rEdit;
  edCZap.Enabled := dmMain.rEdit;
  cbWProf.Enabled := dmMain.rEdit;
  edWCat.Enabled := dmMain.rEdit;
  edVUS.Enabled := dmMain.rEdit;
  dxpOVK.Enabled := dmMain.rEdit;
  dxpWBOVK.Enabled := dmMain.rEdit;
  dxpDelay.Enabled := dmMain.rEdit;
  dtDelayBeg.Enabled := dmMain.rEdit;
  dtDelayEnd.Enabled := dmMain.rEdit;
  edHealth.Enabled := dmMain.rEdit;
  edHealthDoc.Enabled := dmMain.rEdit;
  dtHealthDoc_date.Enabled := dmMain.rEdit;
  fWUch1.edWUch1.Enabled := dmMain.rEdit;
  fWUch1.chkSpecialWUch1.Enabled := False; // See edWUch1.OnChange
  fWUch1.edMob_Days.Enabled := dmMain.rEdit;
  fWUch1.edMob_Hours.Enabled := dmMain.rEdit;
  fWUch1.edMob_Mins.Enabled := dmMain.rEdit;
  fWUch1.edMob_CardDate.Enabled := dmMain.rEdit;
  fWUch1.edMob_MissReason.Enabled := dmMain.rEdit;
  fWUch1.edMob_Place.Enabled := dmMain.rEdit;
  fWUch2.edWUch2.Enabled := dmMain.rEdit;
  fWUch2.edWUch2_Ser.Enabled := dmMain.rEdit;
  fWUch2.edWUch2_Motiv.Enabled := dmMain.rEdit;
  fWUch2.dtWUch2_date.Enabled := dmMain.rEdit;
  fWUch2.edWUch2ListNumb.Enabled := dmMain.rEdit;
  fWUch2.edWUch2ListDate.Enabled := dmMain.rEdit;
  edWUch2_IsWork.Enabled := dmMain.rEdit;
  rbEduc1Main.Enabled := dmMain.rEdit;
  rbEduc2Main.Enabled := dmMain.rEdit;
  rbEduc3Main.Enabled := dmMain.rEdit;
  dtWEnd.Enabled := dmMain.rEdit;
  edWDiscl.Enabled := dmMain.rEdit;
  edWarfare.Enabled := dmMain.rEdit;
  dtOVK.Enabled := dmMain.rEdit;
  dtWBil.Enabled := dmMain.rEdit;
  edTabNumb.Enabled := dmMain.rEdit;
  edDogNumb.Enabled := dmMain.rEdit;
  edASOrder_In.Enabled := dmMain.rEdit;
  edASOut_Ord_Numb.Enabled := dmMain.rEdit;
  dtASOrder_Date.Enabled := dmMain.rEdit;
  dtASOut_Date.Enabled := dmMain.rEdit;
  dtASOut_Ord_Date.Enabled := dmMain.rEdit;
  cbGos.Enabled := dmMain.rEdit;
  dtDogDate.Enabled := dmMain.rEdit;
  dtOutDate.Enabled := dmMain.rEdit;
  edOutOrdNumb.Enabled := dmMain.rEdit;
  dtOutOrdDate.Enabled := dmMain.rEdit;
  edComments.Enabled := dmMain.rEdit;
  edContractEnd.Enabled := dmMain.rEdit;
  edAssignDate.Enabled := dmMain.rEdit;
  edAssignText.Enabled := dmMain.rEdit;
  edAssignReason.Enabled := dmMain.rEdit;
  dxtAssign.Enabled := dmMain.rEdit;
  dxtASAssign.Enabled := dmMain.rEdit;

  edMed_Where.Enabled := dmMain.rEdit;
  edMed_Date.Enabled := dmMain.rEdit;
  edMed_Result.Enabled := dmMain.rEdit;
  edPsy_Where.Enabled := dmMain.rEdit;
  edPsy_Result.Enabled := dmMain.rEdit;
  edPsy_Date.Enabled := dmMain.rEdit;
  edAsf_Sport.Enabled := dmMain.rEdit;

  // Сведения об учащемся
  cbStudent.Enabled := dmMain.rEdit;
  dtEndStudy.Enabled := dmMain.rEdit;
  dxtN26History.Enabled := dmMain.rEdit;
  edOrderAkadem.Enabled := dmMain.rEdit;
  dtOrderAkadem.Enabled := dmMain.rEdit;
  edReasonAkadem.Enabled := dmMain.rEdit;
  dtBeginAkadem.Enabled := dmMain.rEdit;
  dtEndAkadem.Enabled := dmMain.rEdit;
  dtRealEndAkadem.Enabled := dmMain.rEdit;
  dtMedResult.Enabled := dmMain.rEdit;
  cbMedResult.Enabled := dmMain.rEdit;
  rbWarProgram.Enabled := dmMain.rEdit;
  rbNone.Enabled := dmMain.rEdit;
  rbInProcess.Enabled := dmMain.rEdit;
  rbCompleted.Enabled := dmMain.rEdit;
  rbFailed.Enabled := dmMain.rEdit;
  dtBeginWar.Enabled := dmMain.rEdit;
  dtEndWar.Enabled := dmMain.rEdit;
  dtRealEndWar.Enabled := dmMain.rEdit;
  edReasonEndWar.Enabled := dmMain.rEdit;
  dtDismissal.Enabled := dmMain.rEdit;
  edOrderDismissal.Enabled := dmMain.rEdit;
  dtOrderDismissal.Enabled := dmMain.rEdit;
  edReasonDismissal.Enabled := dmMain.rEdit;
  edNapr4.Enabled := dmMain.rEdit;
  dtRealDefend.Enabled := dmMain.rEdit;
  dtSovet_Date.Enabled := dmMain.rEdit;
  edSovet_Shifr.Enabled := dmMain.rEdit;
  edSovet_Org.Enabled := dmMain.rEdit;
  edSovet_Num.Enabled := dmMain.rEdit;
  edSovet_Org_Order.Enabled := dmMain.rEdit;
  ///////////////////////

  btnOk.Visible        := dmMain.rEdit;
  btnApply.Visible     := dmMain.rEdit;
  if not dmMain.rEdit then btnCancel.Caption := 'Закрыть';
end;


procedure TfmPersonForm.N7Click(Sender: TObject);
begin
  dxtLang.Add.Focused := true;
  edFam.OnChange(Self);
end;

procedure TfmPersonForm.N8Click(Sender: TObject);
begin
  if dxtLang.FocusedNode<>nil then begin
    dxtLang.FocusedNode.Destroy;
    edFam.OnChange(Self);
  end;
end;

procedure TfmPersonForm.OpenWuch2(var msg: TMessage);
begin
  bWUch2Click(Self);
end;

procedure TfmPersonForm.MenuItem10Click(Sender: TObject);
begin
  if dxtASAssign.FocusedNode<>nil then begin
    dxtASAssign.FocusedNode.Destroy;
    edFam.OnChange(Self);
  end;
end;

procedure TfmPersonForm.MenuItem11Click(Sender: TObject);
begin
  dxtPersDeps.Add.Focused := true;
  edFam.OnChange(Self);
end;

procedure TfmPersonForm.MenuItem12Click(Sender: TObject);
begin
  if dxtPersDeps.FocusedNode<>nil then begin
    dxtPersDeps.FocusedNode.Destroy;
    edFam.OnChange(Self);
  end;
end;

procedure TfmPersonForm.MenuItem5Click(Sender: TObject);
begin
  dxtN26History.Add.Focused := true;
  edFam.OnChange(Self);
end;

procedure TfmPersonForm.MenuItem6Click(Sender: TObject);
begin
  if dxtN26History.FocusedNode<>nil then begin
    dxtN26History.FocusedNode.Destroy;
    edFam.OnChange(Self);
  end;
end;

procedure TfmPersonForm.MenuItem7Click(Sender: TObject);
begin
  dxtAssign.Add.Focused := True;
  dxtAssign.FocusedNode.Values[0] := Date;
  edFam.OnChange(Self);
end;

procedure TfmPersonForm.MenuItem8Click(Sender: TObject);
begin
  if dxtAssign.FocusedNode<>nil then begin
    dxtAssign.FocusedNode.Destroy;
    edFam.OnChange(Self);
  end;
end;

procedure TfmPersonForm.MenuItem9Click(Sender: TObject);
begin
  dxtASAssign.Add.Focused := True;
  dxtASAssign.FocusedNode.Values[0] := Date;
  edFam.OnChange(Self);
end;

procedure TfmPersonForm.cbBranchDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  if (Index > 1) and not isAllGroups then begin
    State := [odDisabled];
    cbBranch.Canvas.Brush.Color := clLtGray;
    cbBranch.Canvas.FillRect(Rect);
  end;
  cbBranch.Canvas.TextOut(Rect.Left, Rect.Top, cbBranch.Items[Index]);
end;

procedure TfmPersonForm.cbBranchSelect(Sender: TObject);
begin
  if (cbBranch.ItemIndex > 1) and not isAllGroups then cbBranch.ItemIndex := 0
  else cbWRangeChange(Sender);
end;

procedure TfmPersonForm.cbDocumentChange(Sender: TObject);
begin
  cbDocument.Hint := cbDocument.Text;
  cbWRangeChange(Sender);
end;

procedure TfmPersonForm.cbGosClick(Sender: TObject);
begin
  dxtAssign.Enabled := cbGos.Checked;
  edAssignDate.Enabled := cbGos.Checked;
  edAssignText.Enabled := cbGos.Checked;
  edAssignReason.Enabled := cbGos.Checked;
  if dxtAssign.Enabled then dxtAssign.PopupMenu := pmAssign
  else dxtAssign.PopupMenu := nil;
  edFam.OnChange(edFam);
end;

procedure TfmPersonForm.cbWProfChange(Sender: TObject);
var col: TColor;
begin
  col := clWindowText;
  if cbWProf.ItemIndex >= 0 then
    if Integer(cbWProf.Items.Objects[cbWProf.ItemIndex]) = 17 then
      col := clRed;
  cbWProf.Font.Color := col;
  edFamChange(Sender);
end;

procedure TfmPersonForm.cbWRangeChange(Sender: TObject);
begin
  LoadWStateList(false);
end;

function TfmPersonForm.GetIsStudent: Boolean;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := qrData.Connection;
    SQL.Text := 'select cprof_id, cprof2015_id from KPOST ' +
                'inner join Appointment al on al.POST_ID = KPOST.POST_ID ' +
                'where al.pers_id = ' + IntToStr(ID) + ' and ' +
                'not exists(select id from appointment where in_date > al.in_date and ' +
                'pers_id = ' + IntToStr(ID) + ')';
    Open;
    First;
    Result := False;
    if not EOF then Result := (Fields[0].AsInteger = 500) or (Fields[1].AsInteger = 500);
  finally
    Free;
  end;
end;

function TfmPersonForm.ClearPdpCode(PDPCode: String): String;
begin
  Result := PdpCode;
  {if Copy(PDPCode, 1, 2)='//' then
    Result := Copy(PDPCode, 3, MaxInt)
  else if Copy(PDPCode, 1, 1)='/' then
    Result := Copy(PDPCode, 2, MaxInt)
  else
    Result := StringReplace(PDPCode, '//', '/',[rfReplaceAll]);}
end;

function TfmPersonForm.GetPdpCode: String;
var
  q: TADOQuery;
  Male, i: Integer;
  XPDPCode1, XPDPCode2, XPDPCode3, XPDPCode4: String;
begin
  Result := ''; XPDPCode1 := ''; XPDPCode2 := ''; XPDPCode3 := ''; XPDPCode4 := '';
  if rbMale.Checked then Male := 1 else Male := 0;
  q := TADOQuery.Create(nil);
  with q do
  try
    Connection := dMain.dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := 'SELECT '#13+
                  'iif(IsNull(OKVED), '''',OKVED) as XPDPCode1, '#13+
                  'PDP.KOKPDTR_Code as XPDPCode3, ' +
                  '  PDP.* '#13+
                '  FROM (AppointmentLastAll as a '#13+
                '  Left Join PDP On PDP.POST_ID = a.POST_ID)'#13+
                                  '  WHERE (PDP.Limited = 0 OR '''+edWCat.Text+'''=''В'')'#13+
                                  '   AND PDP.WSOST LIKE ''%.'+GetWSOST_IDstr+'.%'''#13+
                                  '   AND (PDP.WRange=0 OR PDP.CHE >= (SELECT CHE FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr+'))'#13+
                                  '   AND PDP.AGE <= '+IntToStr(GetFullAge(dtBirth.Date))+#13+
                                  '   AND ((PDP.Sex=1 and '+IntToStr(Male)+'=1) or (PDP.Sex=2 and '+IntToStr(Male)+'<>1) or (PDP.Sex is null) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
                ' And a.PERS_ID = '+IntToStr(ID)+' '#13+
                ' Order by 1';
    Open;
    OKVEDChoice.Clear;
    if not Eof then begin
      XPDPCode1 := FieldByName('XPDPCode1').AsString;
      XPDPCode3 := FieldByName('XPDPCode3').AsString;
      Next;
      if not Eof then begin
        OKVEDChoice.Add(XPDPCode1);
        XPDPCode1 := '???';
        while not Eof do begin
          OKVEDChoice.Add(FieldByName('XPDPCode1').AsString);
          Next;
        end;
        if OKVED <> '' then begin
          i := OKVEDChoice.IndexOf(OKVED);
          if i >= 0 then begin
            XPDPCode1 := OKVEDChoice[i];
          end else begin
            OKVED := '';
            edFamChange(self);
            ShowMessage('Для корректного бронирования работника необходимо в карточке параметров «б). специальный» выбрать код ОКВЭД из выписки из ПДП');
          end;
        end;
      end;
    end;
    Close;
    SQL.Text := 'SELECT '#13+
                  'iif(IsNull(mo.DocNumber), '''',mo.DocNumber+'' от ''+Format(mo.DocDate, ''dd.mm.yyyy'')) as XPDPCode2, '#13+
                  'KPost.Post_Name as XPDPCode3 ' +
                '  FROM (AppointmentLastAll as a '#13+
                '  inner Join MvkOrder as mo on mo.Pers_id = a.Pers_id and mo.Post_Id = a.Post_Id) '#13+
                '  inner Join KPost on mo.Post_ID = KPost.Post_ID '#13+
                '  Where a.PERS_ID = '+IntToStr(ID)+' '#13+
                ' Order by 1';
    Open;
    if not Eof then begin
      XPDPCode2 := FieldByName('XPDPCode2').AsString;
      XPDPCode4 := FieldByName('XPDPCode3').AsString;
    end;
    Close;
    Result :=
      StringReplace(XPDPCode1,'/','<!!!>', [rfReplaceAll]) + '/' +
      StringReplace(XPDPCode3,'/','<!!!>', [rfReplaceAll]);
      if XPDPCode2 <> '' then
        Result := Result + '/' +
          StringReplace(XPDPCode2,'/','<!!!>', [rfReplaceAll]) + '/' +
          StringReplace(XPDPCode4,'/','<!!!>', [rfReplaceAll]);
  finally Free;
  end;
end;

procedure TfmPersonForm.GetPostAndDep;
begin
  Post_Id := -1; Dep_Id := -1;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := Format('SELECT Dismissal_Date, Out_Date From Person '+
      'WHERE PERS_ID = %d ', [ID]);
    Open;
    if Fields[0].IsNull and Fields[1].IsNull then begin
      Close;
      SQL.Text := Format('SELECT Post_Id, Dep_Id FROM Appointment '+
        'WHERE PERS_ID = %d AND IN_DATE IS NOT NULL ' + //AND '+
        //'POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID = 500)'+
        'Order By In_Date Desc', [ID]);
      Open;
      if not IsEmpty then begin
        Post_Id := Fields[0].AsInteger;
        Dep_Id := Fields[1].AsInteger;
      end;
    end;
  finally Free;
  end;
end;

function TfmPersonForm.LoadData: boolean;
var napr, n, nn: Integer;
    isStudent: Boolean;
    NewPDPCode, ss: String;

  function ListIndex(Items: TStrings; ID: Integer; DefVal: Integer=-1): Integer;
  begin
    Result := Items.IndexOfObject(TObject(ID));
    if Result<0  then Result := DefVal;
  end;

  procedure LoadPhone(PhoneType: Integer);
  var edPhone: TEdit;
  begin
    edPhone := FindComponent('edPhone'+IntToStr(PhoneType)) as TEdit;
    if qrPhones.Locate('PH_TYPE',PhoneType,[]) then
      edPhone.Text := qrPhones.FieldByName('PH_NUMBER').AsString
    else edPhone.Text := EmptyStr;
  end;

  procedure LoadEducation(EduType: Integer);
  var
    cbUz, cbObrDoc, cbFormPrep: TdxPickEdit;
    edDipl, edDiplSer, edDate, edDateGive: TEdit;
    edKval, edNapr: TComboBox;
    edKval3: TdxMRUEdit;
    rbEducMain: TRadioButton;
  begin
    cbUz   := FindComponent('cbUz'  +IntToStr(EduType)) as TdxPickEdit;
    cbObrDoc := FindComponent('cbObrDoc'  +IntToStr(EduType)) as TdxPickEdit;
    cbFormPrep := FindComponent('cbFormPrep'+IntToStr(EduType)) as TdxPickEdit;
    edDipl := FindComponent('edDipl'+IntToStr(EduType)) as TEdit;
    edDiplSer:= FindComponent('edDiplSer'+IntToStr(EduType)) as TEdit;
    edDate := FindComponent('edDate'+IntToStr(EduType)) as TEdit;
    edDateGive := FindComponent('edDateGive'+IntToStr(EduType)) as TEdit;
    if EduType = 3 then
      edKval3 := FindComponent('edKval'+IntToStr(EduType)) as TdxMRUEdit
    else
      edKval := FindComponent('edKval'+IntToStr(EduType)) as TComboBox;
    edNapr := FindComponent('edNapr'+IntToStr(EduType)) as TComboBox;
    rbEducMain := FindComponent('rbEduc'+IntToStr(EduType)+'Main') as TRadioButton;

    if qrEduc.Locate('TYPE',EduType,[]) then begin

      cbUz.Tag := qrEduc.FieldByName('EDQ_ID').AsInteger;
      n := ListIndex(cbUz.Items,qrEduc.FieldByName('UZ_ID').AsInteger);
      cbUz.ItemIndex := n;
      if n>=0 then
        cbUz.Text := cbUz.Items[n];

      cbObrDoc.Tag := qrEduc.FieldByName('EDQ_ID').AsInteger;
      n := ListIndex(cbObrDoc.Items,qrEduc.FieldByName('ObrDoc_ID').AsInteger);
      cbObrDoc.ItemIndex := n;
      if n>=0 then
        cbObrDoc.Text := cbObrDoc.Items[n];

      edDipl.Text := qrEduc.FieldByName('DIPLOM').AsString;
      edDiplSer.Text := qrEduc.FieldByName('DIPLOM_SER').AsString;
      edDate.Text := qrEduc.FieldByName('END_DATE').AsString;
      if EduType<>3 then begin// 3 - Science

        n := ListIndex(edKval.Items,qrEduc.FieldByName('KVAL_ID').AsInteger);
        edKval.ItemIndex := n;
        if n>=0 then edKval.Text := edKval.Items[n];

      end else begin

        edDateGive.Text := qrEduc.FieldByName('END_DATE_GIVE').AsString;

        cbFormPrep.Tag := qrEduc.FieldByName('EDQ_ID').AsInteger;
        n := ListIndex(cbFormPrep.Items,qrEduc.FieldByName('FormPrep_ID').AsInteger);
        cbFormPrep.ItemIndex := n;
        if n>=0 then
          cbFormPrep.Text := cbFormPrep.Items[n];

      end;

      n := ListIndex(edNapr.Items,qrEduc.FieldByName('NAPR_ID').AsInteger);
      edNapr.ItemIndex := n;
      if n>=0 then edNapr.Text := edNapr.Items[n];

      rbEducMain.Checked := qrEduc.FieldByName('IsMain').AsBoolean;
    end
    else begin
      cbUz.Tag := 0;
      cbUz.Text := EmptyStr;
      cbObrDoc.Tag := 0;
      cbObrDoc.Text := EmptyStr;
      edDipl.Text := EmptyStr;
      edDiplSer.Text := EmptyStr;
      edDate.Text := EmptyStr;
      if EduType<>3 then begin // 3 - Science
        edKval.ItemIndex := 0;
      end else begin
        edDateGive.Text := EmptyStr;
        cbFormPrep.Tag := 0;
        cbFormPrep.Text := EmptyStr;
        edKval3.Text := EmptyStr;
      end;
      edNapr4.ItemIndex := 0;
      rbEducMain.Checked := false;
    end;
  end;
//
  procedure LoadText(ed:TCustomEdit; FLD: String; DS: TDataSet); overload;
  begin
    ed.Text := Trim(DS.FieldByName(FLD).AsString);
  end;
  procedure LoadText(ed:TCustomEdit; FLD: String); overload;
  begin
    LoadText(ed, FLD, qrData);
  end;
//
  procedure LoadDate(dt: TdxDateEdit; FLD: String; DS: TDataSet); overload;
  begin
    if DS.FieldByName(FLD).IsNull
      then dt.Text := EmptyStr
      else dt.Date := DS.FieldByName(FLD).AsDateTime;
  end;
  procedure LoadDate(dt: TdxDateEdit; FLD: String); overload;
  begin
    LoadDate(dt, FLD, qrData);
  end;
//
begin
  Result := false;
  if qrData.Active then qrData.Close;
  try
    qrData.Parameters.ParamByName('ID').Value := ID;
    qrData.Open;
    if qrData.IsEmpty then begin
      ShowErr('Требуемая запись не найдена в БД!'#13'Возможно она была удалена другим пользователем...');
      Exit;
    end;
    fLoad := True;

    IsStudent := GetIsStudent;

    OKVED := Trim(qrData.FieldByName('OKVED').AsString);
    LoadText(edFam  ,'FAM');
    LoadText(edIm   ,'IM');
    LoadText(edOtch ,'OTCH');
    rbMale.Checked := qrData.FieldByName('MALE').AsInteger<>0;
    rbFemale.Checked := not rbMale.Checked;
    LoadDate(dtBirth,'BIRTHDAY');
    LoadText(edBirth  ,'BIRTHPLACE');
    LoadText(edOKATO  ,'OKATO');
    cbNat.ItemIndex := ListIndex(cbNat.Items,qrData.FieldByName('NAT_ID').AsInteger);
    LoadText(edPspSer   ,'PSP_SER');
    LoadText(edPspNum   ,'PSP_NUM');
    LoadText(edPspPlace ,'PSP_PLACE');
    LoadDate(dtPspDate,'PSP_DATE');
    LoadText(edComments ,'Comments');
    //loading addresses
    if qrAddr.Active then qrAddr.Requery else qrAddr.Open;
    if qrAddr.Locate('ADDR_TYPE',0,[]) then begin
      LoadText(fAddr.edIndex1      ,'POST_CODE',qrAddr);
      LoadText(fAddr.edAddr1       ,'ADDR_STR' ,qrAddr);
      LoadDate(fAddr.dtADDR_DATE1  ,'ADDR_DATE',qrAddr);
      LoadDate(fAddr.dtADDR_DATE_END1,'ADDR_DATE_END',qrAddr);
    end
    else begin
      fAddr.edIndex1.Text := EmptyStr;
      fAddr.edAddr1.Text := EmptyStr;
      fAddr.dtADDR_DATE1.Text := EmptyStr;
      fAddr.dtADDR_DATE_END1.Text := EmptyStr;
    end;
    if qrAddr.Locate('ADDR_TYPE',1,[]) then begin
      LoadText(fAddr.edIndex2      ,'POST_CODE',qrAddr);
      LoadText(fAddr.edAddr2       ,'ADDR_STR' ,qrAddr);
      LoadDate(fAddr.dtADDR_DATE2  ,'ADDR_DATE',qrAddr);
    end
    else begin
      fAddr.edIndex2.Text := EmptyStr;
      fAddr.edAddr2.Text := EmptyStr;
    end;
    //loading phones
    if qrPhones.Active then qrPhones.Requery else qrPhones.Open;
    LoadPhone(1);
    LoadPhone(2);
    LoadPhone(3);
    LoadText(edINN   ,'INN');
    LoadText(edStrah ,'STRAH');
    LoadText(edVodUdSer, 'VodUdSer');
    LoadText(edVodUdNum, 'VodUdNum');
    LoadDate(dtVodUdDate, 'VodUdDate');
    cbKVodUd.Value := Trim(qrData.FieldByName('KVodUd').AsString);
    //loading langs
    if qrLangs.Active then qrLangs.Requery else qrLangs.Open;
    qrLangs.First;
    dxtLang.ClearNodes;
    while not qrLangs.EOF do begin
      with dxtLang.Add do begin
        Values[0] := colLangName.Items[ListIndex(colLangName.Items,qrLangs.FieldByName('LANG_ID').AsInteger,0)];
        Values[1] := colLangSkill.Items[ListIndex(colLangSkill.Items,qrLangs.FieldByName('LSK_ID').AsInteger,0)];
      end;
      qrLangs.Next;
    end;
    //loading persdeps
    if qrPersDeps.Active then qrPersDeps.Requery else qrPersDeps.Open;
    qrPersDeps.First;
    dxtPersDeps.ClearNodes;
    while not qrPersDeps.EOF do begin
      with dxtPersDeps.Add do begin
        Values[0] := colDepName.Items[ListIndex(colDepName.Items,qrPersDeps.FieldByName('Dep_ID').AsInteger,0)];
      end;
      qrPersDeps.Next;
    end;

    if (not qrData.FieldByName('FST_ID').IsNull) and (ListIndex(fAddr.cbFamState.Items,qrData.FieldByName('FST_ID').AsInteger) < 0) then begin
      fAddr.cbFamState.Items.Clear;
      LoadStrings(fAddr.cbFamState.Items,false,'SELECT * FROM KFSTATE ORDER BY '+
        'iif(IsNull(OKIN),999999,OKIN)','FST_ID','FST_NAME');
    end;
    fAddr.cbFamState.ItemIndex := ListIndex(fAddr.cbFamState.Items,qrData.FieldByName('FST_ID').AsInteger);
    fAddr.cbFamStateChange(Self);
    //loadings family
    if qrFam.Active then qrFam.Requery else qrFam.Open;
    qrFam.First;
    fAddr.dxtFamily.ClearNodes;
    while not qrFam.EOF do begin
      with fAddr.dxtFamily.Add do begin
        Data := Pointer(qrFam.FieldByName('FAM_ID').AsInteger);
        Values[0] := fAddr.colFamType.Items[ListIndex(fAddr.colFamType.Items,qrFam.FieldByName('FT_ID').Value,0)];
        Values[1] := qrFam.FieldByName('FAM_NAME').Value;
        Values[2] := qrFam.FieldByName('FAM_BIRTH').Value;
        Values[3] := qrFam.FieldByName('FAM_PLACE').Value;
      end;
      qrFam.Next;
    end;
    if qrChanges.Active then qrChanges.Requery else qrChanges.Open;
    if (not qrData.FieldByName('ED_ID').IsNull) and (ListIndex(cbEduc.Items,qrData.FieldByName('ED_ID').AsInteger) < 0) then begin
      cbEduc.Items.Clear;
      LoadStrings(cbEduc.Items,false,'SELECT * FROM KEDUC Order by '+
        'iif(IsNull(OKIN),999999,OKIN)','ED_ID','ED_NAME');
    end;
    cbEduc.ItemIndex := ListIndex(cbEduc.Items,qrData.FieldByName('ED_ID').AsInteger);
    cbEduc_saved := cbEduc.ItemIndex;
    //loading education
    if qrEduc.Active then qrEduc.Requery else qrEduc.Open;
    LoadEducation(1);
    LoadEducation(2);
    LoadEducation(3);
    edKval3.ItemIndex := ListIndex(edKval3.Items,qrData.FieldByName('SC_ID').AsInteger,0);

    edProf1.Text := Trim(qrData.FieldByName('PROF1').AsString);
    edOKPDTR1.Text := Trim(qrData.FieldByName('OKPDTR1').AsString);
    edProf2.Text := Trim(qrData.FieldByName('PROF2').AsString);
    edOKPDTR2.Text := Trim(qrData.FieldByName('OKPDTR2').AsString);

    chkVoen.Checked := qrData.FieldByName('IS_WAR').AsInteger<>0;
    chkVoen.OnClick(chkVoen);
//    cbCateg.ItemIndex := ListIndex(cbCateg.Items,qrData.FieldByName('CPROF_ID').AsInteger);
    LoadText(edNumbT2      ,'NUMB_T2');
    LoadDate(dtWBeg        ,'W_DBEG');
    LoadDate(dtWBDate      ,'WBDate');
    LoadDate(dtWRng        ,'WRNG_Date');
    LoadDate(dtMobContract ,'MobContract');
    LoadText(edEOARMY_DATE ,'EOARMY_DATE');
    bDriver.Checked := qrData.FieldByName('Driver').AsInteger <> 0;

    (*cbDocumentZero := 0;
    cbDocument.Items.Clear;
    cbDocument.Items.Add('Военный билет');
    cbDocument.Items.Add('Временное удостоверение');
    cbDocument.Items.Add('Приписное свидетельство');
    cbDocument.Items.Add('Справка взамен военного билета (справка уклониста)');*)
    cbDocument.ItemIndex := qrData.FieldbyName('Document').AsInteger;
    cbDocument.Hint := cbDocument.Text;

    LoadText(edWBser       ,'WBser');
    LoadText(edWBnum       ,'WBnum');
    cbBranch.ItemIndex := qrData.FieldbyName('Branch').AsInteger;
    LoadText(edWID         ,'WID');
    cbWRange.ItemIndex := ListIndex(cbWRange.Items,qrData.FieldByName('WRNG_ID').AsInteger);
    cbWRange.OnChange(cbWRange);
    LoadText(edCZap        ,'CAT_ZAP');
    LoadWStateList(True);
    cbWProf.ItemIndex := ListIndex(cbWProf.Items,qrData.FieldByName('WSOST_ID').AsInteger);
    if qrData.FieldByName('WSOST_ID').AsInteger = 17 then
      cbWProf.Font.Color := clRed
    else begin
      cbWProf.Font.Color := clWindowText;
      LoadWStateList(False); // чтобы убрать устаревшее значение из списка
    end;
    LoadText(edVUS         ,'VUS');
    LoadText(edWCat        ,'WCAT');
    n := ListIndex(dxpOVK.Items,qrData.FieldByName('OVK_ID').AsInteger);
    dxpOVK.ItemIndex := n; if n>=0 then dxpOVK.Text := dxpOVK.Items[n];
    n := ListIndex(dxpWBOVK.Items,qrData.FieldByName('WBOVK').AsInteger);
    dxpWBOVK.ItemIndex := n; if n>=0 then dxpWBOVK.Text := dxpWBOVK.Items[n];
    n := ListIndex(dxpDelay.Items,qrData.FieldByName('Delay_ID').AsInteger);
    dxpDelay.ItemIndex := n; if n>=0 then dxpDelay.Text := dxpDelay.Items[n];
    LoadDate(dtDelayBeg    ,'DelayStart_date');
    LoadDate(dtDelayEnd    ,'DelayEnd_date');
    LoadText(edHealth      ,'Health');
    LoadText(edHealthDoc   ,'HealthDocNo');
    LoadDate(dtHealthDoc_date,'HealthDoc_date');
    LoadText(fWUch1.edWUch1,'WUCHET1');
    fWUch1.chkSpecialWUch1.Checked := qrData.FieldByName('SpecialWUchet1').AsInteger<>0;
    fWUch1.edMob_Days.IntValue := qrData.FieldByName('Mob_Days').AsInteger;
    fWUch1.edMob_Hours.IntValue := qrData.FieldByName('Mob_Hours').AsInteger;
    fWUch1.edMob_Mins.IntValue := qrData.FieldByName('Mob_Mins').AsInteger;
    LoadDate(fWUch1.edMob_CardDate, 'Mob_CardDate');
    LoadText(fWUch1.edMob_MissReason, 'Mob_MissReason');
    LoadText(fWUch1.edMob_Place,    'Mob_Place');
    CalcWuch1Info;
    LoadText(fWUch2.edWUch2       ,'WUCHET2');
    LoadDate(fWUch2.dtWUCH2_date  ,'WUCHET2_date');
    LoadText(fWUch2.edWUch2_Ser   ,'WUCHET2_Ser');
    LoadText(fWUch2.edWUch2_Motiv   ,'WUCHET2_Motiv');
    LoadText(fWUch2.edWuch2ListNumb  ,'WUCH2_ListNumb');
    LoadDate(fWUch2.edWuch2ListDate  ,'WUCH2_ListDate');
    edWUch2_IsWork.Checked := qrData.FieldByName('WUchet2_IsWork').AsInteger<>0;
    CalcWuch2Info;
    PDPCode := qrData.FieldByName('PDPCode').AsString;
    LoadDate(dtWEnd        ,'W_DEND');
    LoadText(edWDiscl      ,'WDISCL');
    LoadText(edWarfare     ,'WARFARE');
    LoadDate(dtOVK         ,'D_OVK');
    LoadDate(dtWBIL        ,'D_WBIL');
    LoadText(edTabNumb     ,'TAB_NUMB');
    edDogNumb.Clear;
    dtDogDate.Clear;
    edDocNumb.Clear;
    dtDocDate.Clear;
    edASOrder_In.Clear;
    edASOut_Ord_Numb.Clear;
    dtASOrder_Date.Clear;
    dtASOut_Date.Clear;
    dtASOut_Ord_Date.Clear;
    edMed_Where.Clear;
    edMed_Date.Clear;
    edMed_Result.Clear;
    edPsy_Where.Clear;
    edPsy_Result.Clear;
    edPsy_Date.Clear;
    edAsf_Sport.Clear;
    if not IsStudent then LoadText(edDogNumb     ,'DOG_NUMB')
    else LoadText(edDocNumb     ,'DOG_NUMB');
    if not IsStudent then LoadDate(dtDogDate     ,'DOG_DATE')
    else LoadDate(dtDocDate     ,'DOG_DATE');
    cbGos.Checked := qrData.FieldByName('IS_RAB').AsInteger=0;
    LoadDate(dtOutDate     ,'OUT_DATE');
    LoadText(edOutOrdNumb  ,'OUT_ORD_NUMB');
    LoadDate(dtOutOrdDate  ,'OUT_ORD_DATE');
    LoadText(edASOrder_In, 'ASOrder_In');
    LoadText(edASOut_Ord_Numb, 'ASOut_Ord_Numb');
    LoadDate(dtASOrder_Date, 'ASDate_In');
    LoadDate(dtASOut_Date, 'ASOut_Date');
    LoadDate(dtASOut_Ord_Date, 'ASOut_Ord_Date');

    LoadText(edMed_Where, 'Med_Where');
    LoadDate(edMed_Date, 'Med_Date');
    LoadText(edMed_Result, 'Med_Result');
    LoadText(edPsy_Where, 'Psy_Where');
    LoadText(edPsy_Result, 'Psy_Result');
    LoadDate(edPsy_Date, 'Psy_Date');
    LoadText(edAsf_Sport, 'Asf_Sport');

    lblConf.Caption := FormatDateTime('dd.mm.yyyy', qrData.FieldByName('CONFDATE').AsDateTime);
    dtConf.Date := Date;
    LoadText(edContractEnd ,'CONTRACTEND');

    if qrAssign.Active then qrAssign.Requery else qrAssign.Open;
    qrAssign.First;
    dxtAssign.ClearNodes;
    edAssignDate.Clear;
    edAssignText.ItemIndex := -1;
    edAssignReason.Clear;
    while not qrAssign.EOF do begin
      with dxtAssign.Add do begin
        Data := Pointer(qrAssign.FieldByName('Assign_ID').AsInteger);
        try Values[0] := qrAssign.FieldByName('Assign_Date').Value except {} end;
        Values[1] := qrAssign.FieldByName('AssignText').Value;
        Values[2] := qrAssign.FieldByName('AssignReason').Value;
      end;
      edAssignDate.Date := qrAssign.FieldByName('Assign_Date').Value;
      n := ListIndex(edAssignText.Items,qrAssign.FieldByName('KAssign').AsInteger);
      edAssignText.ItemIndex := n;
      edAssignReason.Text := qrAssign.FieldByName('AssignReason').Value;
      qrAssign.Next;
    end;
    cbGosClick(nil);

    if qrASAssign.Active then qrASAssign.Requery else qrASAssign.Open;
    qrAsAssign.First;
    dxtASAssign.ClearNodes;
    while not qrASAssign.EOF do begin
      with dxtASAssign.Add do begin
        Data := Pointer(qrASAssign.FieldByName('Assign_ID').AsInteger);
        Values[0] := qrASAssign.FieldByName('Assign_Date').Value;
        Values[1] := qrASAssign.FieldByName('Assign_Date_End').Value;
        Values[2] := qrASAssign.FieldByName('AssignWhere').Value;
        Values[3] := qrASAssign.FieldByName('AssignWhat').Value;
      end;
      qrASAssign.Next;
    end;

    // Сведения об учащемся
    cbStudent.Checked := False;
    if not qrData.FieldByName('IsAspirant').IsNull then
    begin
      cbStudent.Checked := true;
    end;
    LoadDate(dtEndStudy,'StudyEnd_date');

    rbAspirantClick(nil);

    if qrN26History.Active then qrN26History.Requery else qrN26History.Open;
    qrN26History.First;
    dxtN26History.ClearNodes;
    while not qrN26History.EOF do begin
      with dxtN26History.Add do begin
        Values[0] := qrN26History.FieldByName('N26_ID').Value;
        Values[1] := qrN26History.FieldByName('FORM_NUM').Value;
        Values[2] := qrN26History.FieldByName('CREATE_DATE').Value;
        Values[3] := qrN26History.FieldByName('GIVE_DATE').Value;
      end;
      qrN26History.Next;
    end;

    LoadText(edOrderAkadem,'OrderAkadem');
    LoadDate(dtOrderAkadem,'OrderAkadem_date');
    LoadText(edReasonAkadem,'ReasonAkadem');
    LoadDate(dtBeginAkadem,'BeginAkadem_date');
    LoadDate(dtEndAkadem,'EndAkadem_date');
    LoadDate(dtRealEndAkadem,'RealEndAkadem_date');
    LoadDate(dtMedResult,'MedResult_date');
    cbMedResult.ItemIndex := qrData.FieldbyName('MedResult').AsInteger;
    rbNone.Checked := qrData.FieldByName('VKStatus').AsInteger = 0;
    rbInProcess.Checked := qrData.FieldByName('VKStatus').AsInteger = 1;
    rbCompleted.Checked := qrData.FieldByName('VKStatus').AsInteger = 2;
    rbFailed.Checked := qrData.FieldByName('VKStatus').AsInteger = 3;
    rbWarProgram.ItemIndex := qrData.FieldByName('War_Program').AsInteger;
    LoadDate(dtBeginWar,'BeginWar_date');
    LoadDate(dtEndWar,'EndWar_date');
    LoadDate(dtRealEndWar,'RealEndWar_date');
    LoadText(edReasonEndWar,'ReasonEndWar');
    LoadDate(dtDismissal,'Dismissal_date');
    LoadText(edOrderDismissal,'OrderDismissal');
    LoadDate(dtOrderDismissal,'OrderDismissal_date');
    LoadText(edReasonDismissal,'ReasonDismissal');

    if qrEduc.Locate('PERS_ID;TYPE',VarArrayOf([qrData.FieldByName('PERS_ID').AsInteger,4]),[]) then begin
      n := ListIndex(edNapr4.Items,qrEduc.FieldByName('NAPR_ID').AsInteger);
      edNapr4.ItemIndex := n;
      if n>=0 then edNapr4.Text := edNapr4.Items[n];
    end
    else begin
      edNapr4.ItemIndex := 0;
      //edNapr4.Text := EmptyStr;
    end;

    LoadDate(dtRealDefend,'RealDefend_date');
    LoadDate(dtSovet_Date,'Sovet_Date');
    LoadText(edSovet_Shifr,'Sovet_Shifr');
    LoadText(edSovet_Org,'Sovet_Org');
    LoadText(edSovet_Num,'Sovet_Num');
    LoadText(edSovet_Org_Order,'Sovet_Org_Order');
    ///////////////////////

    fAkadem := (Trim(edOrderAkadem.Text)<>'')or
               (Trim(dtOrderAkadem.Text)<>'')or
               (Trim(edReasonAkadem.Text)<>'')or
               (Trim(dtBeginAkadem.Text)<>'')or
               (Trim(dtEndAkadem.Text)<>'')or
               (Trim(dtRealEndAkadem.Text)<>'')or
               (Trim(dtMedResult.Text)<>'')or
               (cbMedResult.ItemIndex<>0);
    fLoad := False;
    fChanged := false;
    btnApply.Enabled := false;
    FillGroupValues(OldValues);

    NewPDPCode := GetPDPCode;
    if (PDPCode <> ClearPdpCode(NewPDPCode)) and (edWUch2_IsWork.Checked) then begin
      if NewPDPCode = '' then begin
        ShowInfo('Работник не попадает ни под один пункт ПДП. Отсрочка от призыва неправомерна.');
      end else begin
        ShowInfo(
          'Основание для бронирования изменилось.'#13+
          'Было: '+fWUch2.DecodePDPCode(PDPCode)+#13+
          'Стало: '+fWUch2.DecodePDPCode(NewPDPCode)+#13+
          'Необходимо выписать новое удостоверение и извещение.');
      end;
    end;


    Result := true;
  except on e: Exception do begin
    ShowErr('Ошибка при загрузке сведений личной карточки из БД!'#13#13+E.Message);
  end end;
end;


function TfmPersonForm.ChkData: boolean;
  procedure SetPageFocus(C: TWinControl);
  var AParent: TWinControl;
  begin
    AParent := C.Parent;
    while (AParent<>Self) and not (AParent is TTabSheet) do AParent := AParent.Parent;
    if AParent is TTabSheet then PC.ActivePage := AParent as TTabSheet;
    if C.CanFocus and not (C is TRadioButton) then C.SetFocus;
  end;

  procedure ShowErrAt(C: TWinControl; Msg: String);
  begin  SetPageFocus(C); ShowErr(msg);  end;

  procedure ErrorAt(C: TWinControl; Msg: String);
  begin  ShowErrAt(C, Msg); Abort;  end;

  procedure ChkFiled(ed: TEdit; msg: string); overload;
  begin if Trim(ed.Text)=EmptyStr then ErrorAt(ed, msg); end;

  procedure ChkFiled(ed: TdxDateEdit; msg: string); overload;
  begin if Trim(ed.Text)=EmptyStr then ErrorAt(ed, msg); end;

  procedure ChkDateOrYear(edDate: TEdit);
  begin
    if (edDate.Text<>EmptyStr) and
        not IsDateOrYear(edDate.Text)
    then
      ErrorAt(edDate, E_InvDateOrYear);
  end;
  function GetNewNUMB_T2: String;
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dMain.dmMain.dbMain;
      ParamCheck := False;
      SQL.Text := 'SELECT IIF((MAX(NUMB_T2) is null),1,MAX(NUMB_T2)+1) AS NewNUMB_T FROM PERSON';
      Open;
      Result := Fields[0].AsString;
    finally Free;
    end;
  end;
var
  i, cnt     : Integer;
  lst        : TStringList;
  NewNUMB_T2 : String;
  checked: Boolean;
begin
  Result := false;
  try
    ChkFiled(edFam, 'Не указана фамилия сотрудника!');
    ChkFiled(edIm,  'Не указано имя сотрудника!');
//    ChkFiled(edOtch,'Не указано отчество сотрудника!');
    if dtBirth.Text=EmptyStr then ErrorAt(dtBirth, 'Не указана дата рождения сотрудника!');
    if cbNat.ItemIndex<0     then ErrorAt(cbNat,   'Не указано гражданство сотрудника!');
    for i:=0 to dxtLang.Count-1 do
      if (dxtLang.Items[i].Strings[0]=EmptyStr) or (dxtLang.Items[i].Strings[1]=EmptyStr) then
      begin
        ShowErrAt(dxtLang,'Некорректно заполнены сведения о знаниях иностранных языков!');
        dxtLang.Items[i].Selected := true;
        Abort;
      end;
    for i:=0 to dxtPersDeps.Count-1 do
      if dxtPersDeps.Items[i].Strings[0]=EmptyStr then
      begin
        ShowErrAt(dxtPersDeps,'Некорректно заполнены сведения об уполномоченных подразделениях!');
        dxtPersDeps.Items[i].Selected := true;
        Abort;
      end;
    for i:=0 to fAddr.dxtFamily.Count-1 do
      if (fAddr.dxtFamily.Items[i].Strings[0]=EmptyStr) or
         (fAddr.dxtFamily.Items[i].Strings[1]=EmptyStr) or
         (not IsDateOrYear(fAddr.dxtFamily.Items[i].Strings[2])) then
      begin
        ShowErrAt(fAddr.dxtFamily, 'Некорректно заполнены сведения о членах семьи!');
        fAddr.dxtFamily.Items[i].Focused := true;
        Abort;
      end;
    ChkDateOrYear(edDate1);
    ChkDateOrYear(edDate2);
    ChkDateOrYear(edDate3);
//    if cbCateg.ItemIndex<0 then ErrorAt(cbCateg, 'Не указана категория должности сотрудника!');

    if (cbEduc.ItemIndex >= 0) and (cbEduc_saved <> cbEduc.ItemIndex) then begin
      with TADOQuery.Create(nil) do
      try
        Connection := dMain.dmMain.dbMain;
        ParamCheck := False;
        SQL.Text := 'SELECT OKIN From KEduc where Ed_Id = ' +
          IntToStr(Integer(cbEduc.Items.Objects[cbEduc.ItemIndex]));
        Open;
        if Fields[0].IsNull then begin
          ShowErrAt(cbEduc,'Этот вид образования закрыт для выбора!');
          Abort;
        end;
      finally Free;
      end;
    end;

    cnt := 0;
    checked := false;
    if cbUz1.ItemIndex >= 0 then begin
      Inc(cnt);
      if rbEduc1Main.Checked then checked := true;
    end;
    if cbUz2.ItemIndex >= 0 then begin
      Inc(cnt);
      if rbEduc2Main.Checked then checked := true;
    end;
    if cbUz3.ItemIndex >= 0 then begin
      Inc(cnt);
      if rbEduc3Main.Checked then checked := true;
    end;
    if (cnt > 1) and not checked then begin
      ShowErrAt(rbEduc1Main,'Вы не указали, какое образование является основным!');
      Abort;
    end;

    NewNUMB_T2 := GetNewNUMB_T2;
    if Trim(edNumbT2.Text)<>EmptyStr then begin

      if not TryStrToInt(Trim(edNumbT2.Text), I) then begin
        if Confirm(
            'Указанный регистрационный номер карточки формы Т-2 не преобразуется в число!'#13+
            'Использовать автоматически созданный номер('+NewNUMB_T2+')?')
        then
          edNumbT2.Text := NewNUMB_T2
        else begin
          SetPageFocus(edNumbT2); Abort;
        end;
      end;

      with TADOQuery.Create(nil) do
      try
        Connection := dMain.dmMain.dbMain;
        ParamCheck := False;
        SQL.Text := Format('SELECT * FROM PERSON WHERE PERS_ID<>%d AND NUMB_T2=%s',
                           [Self.id, Trim(edNumbT2.Text)]);
        Open;
        if not IsEmpty then begin
          if Confirm(
              'Введённый регистрационный номер карточки формы Т-2 уже используется!'#13+
              'Использовать автоматически созданный номер('+NewNUMB_T2+')?')
          then
            edNumbT2.Text := NewNUMB_T2
          else begin
            SetPageFocus(edNumbT2); Abort;
          end;
        end;
      finally Free;
      end;
    end;
    if chkVoen.Checked then begin
      if Trim(edNumbT2.Text)=EmptyStr then begin
        if Confirm(
            'Не указан регистрационный номер карточки формы Т-2!'#13+
            'Использовать автоматически созданный номер('+NewNUMB_T2+')?')
        then
          edNumbT2.Text := NewNUMB_T2
        else begin
          SetPageFocus(edNumbT2); Abort;
        end;
      end;
      ChkFiled(dtWBeg, 'Не указана дата постановки на воинский учет!');
      ChkDateOrYear(edEOARMY_DATE);
      if cbWRange.ItemIndex<0 then begin
        ShowErrAt(cbWRange, 'Не указано воинское звание сотрудника!');
        Exit;
      end;
      qrWRange.RecNo := Integer(cbWRange.Items.Objects[cbWRange.ItemIndex]);

      if (cbDocument.ItemIndex = 3) and (LowerCase(qrWRange.FieldByName('WRNG_NAME').AsString) <> 'рядовой') then begin
        ShowErrAt(cbDocument, 'Если указан документ «Справка взамен военного билета (справка уклониста)», то звание может быть только «Рядовой»!');
        Exit;
      end;

      lst := TStringList.Create;
      try
        lst.CommaText := qrWrange.FieldByName('ZAP').AsString;
        if lst.Count>0 then begin
          if lst.IndexOf(edCZap.Text)<0 then ErrorAt(edCZap, 'Для указанной категории военнообязанных поле "Категория запаса" должна иметь значения "'+lst.CommaText+'"!');
        end
        else
          if edCZap.Text<>EmptyStr then ErrorAt(edCZap, 'На указанную категорию военнообязанных поле "Категория запаса" не заполняется!');
        if cbWProf.Items.Count>0 then
          if cbWProf.ItemIndex<0 then ErrorAt(cbWProf, 'Не указан состав или профиль военнообязанного сотрудника!');
        if qrWRange.FieldByName('STATE').AsInteger<>0 then begin
//          ChkFiled(edVUS, 'Не указана ВУС военнообязанного сотрудника!');
        end
        else
          if edVUS.Text<>EmptyStr then ErrorAt(edVUS, 'На лиц подлежащих призыву поле "ВУС" не заполняется!');
        lst.CommaText := qrWRange.FieldByName('GODN').AsString;
        if lst.Count>0 then begin
          if lst.IndexOf(edWCat.Text)<0 then ErrorAt(edWCat, 'На указанную категорию военнообязанных поле "Категория годности к военной службе" может иметь следующие значения "'+lst.CommaText+'"!');
        end
        else
          if edWCat.Text<>EmptyStr then ErrorAt(edWCat, 'На указанную категорию военнообязанных поле "Категория годности к военной службе" не заполняется!');
      finally lst.Free;
      end;
      if Trim(dxpOVK.Text)=EmptyStr then ErrorAt(dxpOVK, 'Не заполнено поле "ОВК по месту жительства"!');
      if Trim(edWDiscl.Text)<>EmptyStr then
        ChkFiled(dtWEnd, 'Не указана дата снятия с воинского учета/сдачи карточки в архив!');
    end;

    for i := 0 to dxtN26History.Count - 1 do
      if (dxtN26History.Items[i].Strings[0] = EmptyStr) and
         (not IsDateOrYear(dxtN26History.Items[i].Strings[1])) and
         (not IsDateOrYear(dxtN26History.Items[i].Strings[2])) then
      begin
        ShowErrAt(dxtN26History, 'Некорректно заполнены сведения об истории выдачи формы № 26!');
        dxtN26History.Items[i].Focused := true;
        Abort;
      end;

    ChkFiled(dtConf, 'Не указана дата заполнения личной карточки сотрудника!');

    if edWUch2_IsWork.Checked and (Trim(fWUch2.edWUch2.Text) = '') and (Trim(fWUch2.edWUch2ListNumb.Text) = '') then begin
        ShowErrAt(edWUch2_IsWork, 'Не указан номер удостоверения об отсрочке!');
        Abort;
    end;

    if (OKVEDChoice.Count > 0) and (OKVED = '') then begin
        ShowErrAt(edWUch2_IsWork, 'Для корректного бронирования работника необходимо в карточке параметров «б). специальный» выбрать код ОКВЭД из выписки из ПДП');
        Abort;
    end;

  except Exit;
  end;
  Result := true;
end;

procedure TfmPersonForm.SetPostAndDep;
var
  new_Post_Id, new_Dep_Id: Integer;
  new_Dismissed: Boolean;
  q: TADOQuery;
  Study, NoStudy: TList;
  ALast, ALastAll, ALastStudy, AFirst, AFirstStudy: Integer;

  function iNull(i: Integer): String;
  begin
    if i = -1 then
      Result := 'Null'
    else
      Result := IntToStr(i);
  end;

begin
  new_Post_Id := -1; new_Dep_Id := -1;
  q := TADOQuery.Create(nil);
  with q do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := Format('SELECT Dismissal_Date, Out_Date From Person '+
      'WHERE PERS_ID = %d ', [ID]);
    Open;
    if Fields[0].IsNull and Fields[1].IsNull then begin
      Close;
      SQL.Text := Format('SELECT Post_Id, Dep_Id FROM Appointment '+
        'WHERE PERS_ID = %d AND IN_DATE IS NOT NULL '+ //AND '+
        //'POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID = 500)'+
        'Order By In_Date Desc', [ID]);
      Open;
      if not IsEmpty then begin
        new_Post_Id := Fields[0].AsInteger;
        new_Dep_Id := Fields[1].AsInteger;
      end;
    end;
    Close;

    if (Dep_Id <> new_Dep_Id) or (Post_Id <> new_Post_Id) then begin
      SQL.Text :=
        'Update StaffList Set GeneralQty = GeneralQty - 1 '+
        'Where Dep_Id = '+IntToStr(Dep_Id)+' and Post_Id = '+IntToStr(Post_Id)+' and '+
          'GeneralQty > 0';
      ExecSQL;
      SQL.Text :=
        'Insert Into StaffList (Dep_Id, Post_Id, GeneralQty) '+
        'Select Top 1 '+IntToStr(new_Dep_Id)+', '+IntToStr(new_Post_Id)+', 0 '+
        'From VerInfo '+
        'Where not exists (select * from StaffList '+
          'Where Dep_Id = '+IntToStr(new_Dep_Id)+' and Post_Id = '+IntToStr(new_Post_Id)+')';
      ExecSQL;
      SQL.Text :=
        'Update StaffList Set GeneralQty = GeneralQty + 1 '+
        'Where Dep_Id = '+IntToStr(new_Dep_Id)+' and Post_Id = '+IntToStr(new_Post_Id);
      ExecSQL;
    end;

    Study := TList.Create; NoStudy := TList.Create;
    SQL.Text := 'SELECT POST_ID FROM KPOST WHERE CPROF_ID = 500 or CPROF2015_ID = 500';
    Open;
    while not Eof do begin
      Study.Add(Pointer(Fields[0].AsInteger));
      Next;
    end;
    Close;
    SQL.Text := 'SELECT POST_ID FROM KPOST WHERE CPROF_ID <> 500 and CPROF2015_ID <> 500';
    Open;
    while not Eof do begin
      NoStudy.Add(Pointer(Fields[0].AsInteger));
      Next;
    end;
    Close;

    ALast  := -1; ALastAll  := -1; ALastStudy  := -1;
    AFirst := -1; AFirstStudy := -1;
    SQL.Text := Format(
      'Select ID, Post_Id '+
      'From Appointment WHERE In_Date is not null and PERS_ID = %d '+
      'Order By In_Date Desc, ID Desc', [ID]);
    Open;
    while not Eof do begin
      if ALastAll = -1 then ALastAll := Fields[0].AsInteger;
      if Study.IndexOf(Pointer(Fields[1].AsInteger)) >= 0 then begin
        AFirstStudy := Fields[0].AsInteger;
        if ALastStudy = -1 then ALastStudy := Fields[0].AsInteger;
      end;
      if NoStudy.IndexOf(Pointer(Fields[1].AsInteger)) >= 0 then begin
        AFirst := Fields[0].AsInteger;
        if ALast = -1 then ALast := Fields[0].AsInteger;
      end;
      //if (ALast <> -1) and (ALastStudy <> -1) then break;
      Next;
    end;
    Close;
    SQL.Text :=
      'Update Person Set '+
        'AppLast = '+iNull(ALast)+', '+
        'AppLastAll = '+iNull(ALastAll)+', '+
        'AppLastStudy = '+iNull(ALastStudy)+', '+
        'AppFirst = '+iNull(AFirst)+', '+
        'AppFirstStudy = '+iNull(AFirstStudy)+' '+
      'Where Pers_Id = '+IntToStr(ID);
    ExecSQL;

    Study.Free; NoStudy.Free;
  finally Free;
  end;
end;

procedure TfmPersonForm.SetWarPageActive;
begin
  PC.ActivePage := TabSheetX0;
  edWUch2Info.SetFocus;
  PostMessage(Handle, WM_OPEN_WUCH2, 0, 0);
end;

function TfmPersonForm.StoreData: boolean;
var
  napr: integer;


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
  procedure AssignStr(fld: TField; ed: TCustomEdit);      overload;
  begin
    if Trim(ed.Text)=EmptyStr then fld.Value := NULL
    else fld.Value := Trim(ed.Text);
  end;
  procedure AssignStr(fld: TField; ed: TCustomdxMRUEdit); overload;
  begin
    if Trim(ed.Text)=EmptyStr then fld.Value := NULL
    else fld.Value := Trim(ed.Text);
  end;
  procedure AssignDate(fld: TField; dt: TdxDateEdit);
  var
    dd,mm,yy: Word;
  begin
    if dt.Text=EmptyStr then fld.Value := NULL
    else begin
      DecodeDate(dt.Date, yy,mm,dd);
      if (yy < 1900) or (yy > 2050) then
        raise Exception.CreateFmt('Недопустимая дата: %d.%d.%d',[dd,mm,yy]);
      fld.Value := dt.Date;

    end;
  end;

  procedure StorePhone(PhoneType: Integer);
  var edPhone: TEdit;
  begin
    edPhone := FindComponent('edPhone'+IntToStr(PhoneType)) as TEdit;
    if Trim(edPhone.Text)<>EmptyStr then begin
      qrPhones.Append;
      if qrPhones.FieldByName('PH_ID').DataType<>ftAutoInc then
        qrPhones.FieldByName('PH_ID').Value := GetID('PHONES','PH_ID');
      qrPhones.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
      qrPhones.FieldByName('PH_TYPE').Value := PhoneType;
      AssignStr(qrPhones.FieldByName('PH_NUMBER'),edPhone);
      qrPhones.Post;
    end;
  end;

  function StoreEducation(EduType: Integer): TDateTime;
  var
    cbUz, cbObrDoc, cbFormPrep: TdxPickEdit;
    edDipl, edDiplSer, edDate, edDateGive: TEdit;
    edKval, edNapr: TComboBox;
    edKval3: TdxMRUEdit;
    rbEducMain: TRadioButton;
    d: TDateTime;
    sd: String;
    fmt: TFormatSettings;
    qry: TAdoQuery;
  begin
    GetLocaleFormatSettings(0, fmt);
    fmt.ShortDateFormat := 'dd/mm/yyyy';
    fmt.DateSeparator := '.';
    d := StrToDate('01.01.1900', fmt);
    Result := d;

    cbUz   := FindComponent('cbUz'  +IntToStr(EduType)) as TdxPickEdit;
    cbObrDoc   := FindComponent('cbObrDoc'  +IntToStr(EduType)) as TdxPickEdit;
    cbFormPrep   := FindComponent('cbFormPrep'  +IntToStr(EduType)) as TdxPickEdit;
    edDipl := FindComponent('edDipl'+IntToStr(EduType)) as TEdit;
    edDiplSer := FindComponent('edDiplSer'+IntToStr(EduType)) as TEdit;
    edDate := FindComponent('edDate'+IntToStr(EduType)) as TEdit;
    edDateGive := FindComponent('edDateGive'+IntToStr(EduType)) as TEdit;
    rbEducMain := FindComponent('rbEduc'+IntToStr(EduType)+'Main') as TRadioButton;
    if EduType = 3 then
      edKval3 := FindComponent('edKval'+IntToStr(EduType)) as TdxMRUEdit
    else
      edKval := FindComponent('edKval'+IntToStr(EduType)) as TComboBox;
    edNapr := FindComponent('edNapr'+IntToStr(EduType)) as TComboBox;
    if (Trim(cbUz.Text)<>EmptyStr)
    or (Trim(cbObrDoc.Text)<>EmptyStr)
    or (Trim(edDipl.Text)<>EmptyStr)
    or (Trim(edDiplSer.Text)<>EmptyStr)
    or (Trim(edDate.Text)<>EmptyStr)
    or ((EduType<3) and (Trim(edKval.Text)<>EmptyStr))
    or ((EduType=3) and (Integer(edKval3.Items.Objects[edKval3.ItemIndex])>0))
    or ((EduType=3) and (Trim(edDateGive.Text)<>EmptyStr))
    or ((EduType=3) and (Trim(cbFormPrep.Text)<>EmptyStr))
    or (Trim(edNapr.Text)<>EmptyStr)
    then begin
      if (cbUz.ItemIndex<0) and (Trim(cbUz.Text)<>EmptyStr) then
      with TADOTable.Create(Self) do begin// store education-org
        Connection := dmMain.dbMain;
        TableName := 'KUZ';
        Open;
        Append;
        if FieldByName('UZ_ID').DataType<>ftAutoInc then
          FieldByName('UZ_ID').Value := GetID('KUZ','UZ_ID');
        FieldByName('UZ_NAME').Value := Trim(cbUz.Text);
        Post;
        cbUz.Items.AddObject(Trim(cbUz.Text),Pointer(FieldByName('UZ_ID').AsInteger));
        cbUz.ItemIndex := cbUz.Items.Count-1;
        Free;
      end;
      qrEduc.Append;
      if qrEduc.FieldByName('EDQ_ID').DataType<>ftAutoInc then
        qrEduc.FieldByName('EDQ_ID').Value := GetID('EDUC','EDQ_ID');
      qrEduc.FieldByName('PERS_ID' ).Value := qrData.FieldByName('PERS_ID').AsInteger;
      if cbUz.ItemIndex>=0 then
        qrEduc.FieldByName('UZ_ID' ).Value := Integer(cbUz.Items.Objects[cbUz.ItemIndex]);
      if cbObrDoc.ItemIndex>=0 then
        qrEduc.FieldByName('ObrDoc_ID' ).Value := Integer(cbObrDoc.Items.Objects[cbObrDoc.ItemIndex]);
      AssignStr(qrEduc.FieldByName('DIPLOM'),edDipl);
      AssignStr(qrEduc.FieldByName('DIPLOM_SER'),edDiplSer);
      AssignStr(qrEduc.FieldByName('END_DATE'),edDate);
      if Length(edDate.Text) = 0 then
        qrEduc.FieldByName('END_DATE_DATE').Clear
      else try
          sd := edDate.Text;
          if Length(edDate.Text) = 4 then
            sd := '01.01.' + sd;

          GetLocaleFormatSettings(0, fmt);

          fmt.ShortDateFormat := 'dd/mm/yyyy';
          fmt.DateSeparator := '.';
          d := StrToDate(sd, fmt);

          qrEduc.FieldByName('END_DATE_DATE').AsDateTime := d;
          Result := d;
        except
          qrEduc.FieldByName('END_DATE_DATE').Clear
        end;

      if EduType<>3 then begin
        if edKval.ItemIndex>=0 then
          qrEduc.FieldByName('KVAL_ID').Value := Integer(edKval.Items.Objects[edKval.ItemIndex]);
      end
      else begin
        {if Integer(edKval.Items.Objects[edKval.ItemIndex])=0
        then qrEduc.FieldByName('KVAL').AsString := EmptyStr
        else} AssignStr(qrEduc.FieldByName('KVAL'), edKval3); //See also SC_ID
        AssignStr(qrEduc.FieldByName('END_DATE_GIVE'),edDateGive);
        if cbFormPrep.ItemIndex>=0 then
          qrEduc.FieldByName('FormPrep_ID' ).Value := Integer(cbFormPrep.Items.Objects[cbFormPrep.ItemIndex]);
      end;

      qrEduc.FieldByName('OKSO').AsString := '000000';
      if edNapr.ItemIndex>=0 then begin
        qrEduc.FieldByName('NAPR_ID').Value := Integer(edNapr.Items.Objects[edNapr.ItemIndex]);
        qry := TAdoQuery.Create(Self);
        qry.Connection := qrData.Connection;
        qry.SQL.Text := 'Select * from KNapr where Napr_Id = '+IntToStr(Integer(edNapr.Items.Objects[edNapr.ItemIndex]));
        qry.Open;
        if not qry.Eof then
          if qry.FieldByName('Napr_Kod').IsNull then
            qrEduc.FieldByName('OKSO').AsString := '000000'
          else
            qrEduc.FieldByName('OKSO').AsString := qry.FieldByName('Napr_Kod').AsString;
        qry.Free;
      end;

      qrEduc.FieldByName('Type').AsInteger := EduType;
      qrEduc.FieldByName('IsMain').AsBoolean := rbEducMain.Checked;
      qrEduc.Post;
    end;
  end;

var n, nn: Integer;
  ss: string;
  IsStudent, IsNewCard: Boolean;
  dMax, d: TDateTime;
begin  //StoreData
  Result := false;
  IsNewCard := false;
  if not ChkData then Exit;
  if not ChkReserv(true) then Exit;
  try
    dmMain.dbMain.BeginTrans;
  except
  end;
  try
    if not qrData.Active then qrData.Open;
    if ID<=0 then begin
      IsNewCard := true;
      qrData.Append;
      if qrData.FieldByName('PERS_ID').DataType <> ftAutoInc then
        qrData.FieldByName('PERS_ID').Value := GetID('PERSON','PERS_ID');
    end
    else begin
      qrData.Edit;
    end;

    GetPostAndDep;

    IsStudent := GetIsStudent;

    qrData.FieldByName('ORG_ID').Value := dmMain.GetOrgID;
    if OKVED = '' then
      qrData.FieldByName('OKVED').Clear
    else
      qrData.FieldByName('OKVED').Value := OKVED;
    AssignStr(qrData.FieldByName('FAM'),edFam);
    AssignStr(qrData.FieldByName('IM'),edIM);
    AssignStr(qrData.FieldByName('OTCH'),edOtch);
    if rbMale.Checked then qrData.FieldByName('MALE').Value := 1
    else qrData.FieldByName('MALE').Value := 0;
    AssignDate(qrData.FieldByName('BIRTHDAY'),dtBirth);
    AssignStr(qrData.FieldByName('BIRTHPLACE'),edBirth);
    AssignStr(qrData.FieldByName('OKATO'),edOKATO);
    qrData.FieldByName('NAT_ID').Value :=
      Integer(cbNat.Items.Objects[cbNat.ItemIndex]);
    AssignStr(qrData.FieldByName('PSP_SER'),edPspSer);
    AssignStr(qrData.FieldByName('PSP_NUM'),edPspNum);
    AssignStr(qrData.FieldByName('PSP_PLACE'),edPspPlace);
    AssignDate(qrData.FieldByName('PSP_DATE'),dtPspDate);
    AssignStr(qrData.FieldByName('INN'),edINN);
    AssignStr(qrData.FieldByName('VodUdSer'),edVodUdSer);
    AssignStr(qrData.FieldByName('VodUdNum'),edVodUdNum);
    AssignDate(qrData.FieldByName('VodUdDate'),dtVodUdDate);
    qrData.FieldByName('KVodUd').AsString := cbKVodUd.Value;
    qrData.FieldByName('KVodUdTxt').AsString := cbKVodUd.Text;
    AssignStr(qrData.FieldByName('STRAH'),edStrah);
    AssignStr(qrData.FieldByName('Comments'),edComments);
    if fAddr.cbFamState.ItemIndex>=0 then
      qrData.FieldByName('FST_ID').Value :=
        Integer(fAddr.cbFamState.Items.Objects[fAddr.cbFamState.ItemIndex])
    else
      qrData.FieldByName('FST_ID').Value := NULL;
    if cbEduc.ItemIndex>=0 then begin
      qrData.FieldByName('ED_ID').Value := Integer(cbEduc.Items.Objects[cbEduc.ItemIndex])
    end else
      qrData.FieldByName('ED_ID').Value := NULL;
    AssignStr(qrData.FieldByName('PROF1'),edProf1);
    AssignStr(qrData.FieldByName('OKPDTR1'),edOKPDTR1);
    AssignStr(qrData.FieldByName('PROF2'),edProf2);
    AssignStr(qrData.FieldByName('OKPDTR2'),edOKPDTR2);

//    qrData.FieldByName('CPROF_ID').Value :=
//      Integer(cbCateg.Items.Objects[cbCateg.ItemIndex]);
    if chkVoen.Checked
      then qrData.FieldByName('IS_WAR').Value := 1
      else qrData.FieldByName('IS_WAR').Value := 0;

    AssignStr(qrData.FieldByName('NUMB_T2'),edNumbT2);


    qrData.Post;
    if ID <= 0 then begin
      ID := qrData.FieldByName('PERS_ID').AsInteger;
      qrData.Close;
      qrData.Parameters.ParamByName('ID').Value := ID;
      qrData.Open;
    end;
    qrData.Edit;

  /////////////////////

    AssignDate(qrData.FieldByName('W_DBEG'),dtWBeg);
    AssignDate(qrData.FieldByName('MobContract'), dtMobContract);
    AssignDate(qrData.FieldByName('WBDate'),dtWBDate);
    AssignDate(qrData.FieldByName('WRNG_Date'),dtWRng);
    AssignStr(qrData.FieldByName('EOARMY_DATE'),edEOARMY_DATE);
    (*if cbDocumentZero = 1 then
      qrData.FieldbyName('Document').AsInteger := cbDocument.ItemIndex + 2
    else*)
      qrData.FieldbyName('Document').AsInteger := cbDocument.ItemIndex;
    if bDriver.Checked then qrData.FieldByName('Driver').AsInteger := 1 else qrData.FieldByName('Driver').AsInteger := 0;
    AssignStr(qrData.FieldByName('WBser'),edWBser);
    AssignStr(qrData.FieldByName('WBnum'),edWBnum);
    qrData.FieldbyName('Branch').AsInteger := cbBranch.ItemIndex;
    AssignStr(qrData.FieldByName('WID'),edWID);
    if cbWRange.ItemIndex<0 then
      qrData.FieldByName('WRNG_ID').Value := NULL
    else begin
      qrWRange.RecNo := Integer(cbWRange.Items.Objects[cbWRange.ItemIndex]);
      qrData.FieldByName('WRNG_ID').Value := qrWRange.FieldByName('WRNG_ID').AsInteger;
    end;
    AssignStr(qrData.FieldByName('CAT_ZAP'),edCZap);
    if cbWProf.ItemIndex<0
      then qrData.FieldByName('WSOST_ID').Value := NULL
      else qrData.FieldByName('WSOST_ID').Value := Integer(cbWProf.Items.Objects[cbWProf.ItemIndex]);
    AssignStr(qrData.FieldByName('VUS'),edVUS);
    AssignStr(qrData.FieldByName('WCAT'),edWCat);
    if dxpOVK.ItemIndex>=0
    then
      qrData.FieldByName('OVK_ID').Value := Integer(dxpOVK.Items.Objects[dxpOVK.ItemIndex])
    else
      if Trim(dxpOVK.Text)=EmptyStr then qrData.FieldByName('OVK_ID').Value := NULL
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
          qrData.FieldByName('OVK_ID').Value := FieldByName('OVK_ID').AsInteger;
          Free;
          dxpOVK.Items.AddObject(dxpOVK.Text,Pointer(qrData.FieldByName('OVK_ID').AsInteger));
          dxpOVK.ItemIndex := dxpOVK.Items.Count-1;
        end;
    qrData.FieldByName('WBOVK').Clear;
    if dxpWBOVK.ItemIndex>=0
    then
      qrData.FieldByName('WBOVK').Value := Integer(dxpWBOVK.Items.Objects[dxpWBOVK.ItemIndex])
    else
      if Trim(dxpWBOVK.Text)=EmptyStr then qrData.FieldByName('WBOVK').Value := NULL
      else
    //creating new record in KOVK
        with TADOTable.Create(Self) do begin
          Connection := dmMain.dbMain;
          TableName := 'KOVK';
          Open;
          Append;
          if FieldByName('OVK_ID').DataType<>ftAutoInc then
            FieldByName('OVK_ID').Value := GetID('KOVK','OVK_ID');
          FieldByName('OVK_NAME').Value := dxpWBOVK.Text;
          Post;
          qrData.FieldByName('WBOVK').Value := FieldByName('OVK_ID').AsInteger;
          Free;
          dxpWBOVK.Items.AddObject(dxpWBOVK.Text,Pointer(qrData.FieldByName('WBOVK').AsInteger));
          dxpWBOVK.ItemIndex := dxpWBOVK.Items.Count-1;
        end;
    with dxpDelay do
      if ItemIndex >= 0 then begin
        if Integer(Items.Objects[ItemIndex])=0 then qrData.FieldByName('Delay_ID').Value := NULL
        else qrData.FieldByName('Delay_ID').Value := Integer(Items.Objects[ItemIndex]);
      end
      else qrData.FieldByName('Delay_ID').Value := NULL;

    AssignDate(qrData.FieldByName('DelayStart_date'),dtDelayBeg);
    AssignDate(qrData.FieldByName('DelayEnd_date'),dtDelayEnd);
    AssignStr(qrData.FieldByName('Health'),edHealth);
    AssignStr(qrData.FieldByName('HealthDocNo'),edHealthDoc);
    AssignDate(qrData.FieldByName('HealthDoc_date'),dtHealthDoc_date);
    AssignStr(qrData.FieldByName('WUCHET1'),fWUch1.edWUCH1);
    if fWUch1.chkSpecialWUch1.Checked then
      qrData.FieldByName('SpecialWUchet1').AsInteger := 1
    else
      qrData.FieldByName('SpecialWUchet1').AsInteger := 0;

    qrData.FieldByName('Mob_Days').AsInteger := fWUch1.edMob_Days.IntValue;
    qrData.FieldByName('Mob_Hours').AsInteger := fWUch1.edMob_Hours.IntValue;
    qrData.FieldByName('Mob_Mins').AsInteger := fWUch1.edMob_Mins.IntValue;
    AssignDate(qrData.FieldByName('Mob_CardDate'), fWUch1.edMob_CardDate);
    AssignStr(qrData.FieldByName('Mob_MissReason'), fWUch1.edMob_MissReason);
    AssignStr(qrData.FieldByName('Mob_Place'), fWUch1.edMob_Place);

    AssignStr(qrData.FieldByName('WUCHET2'),fWUch2.edWUCH2);
    AssignStr(qrData.FieldByName('WUCHET2_Ser'),fWUch2.edWUCH2_Ser);
    AssignStr(qrData.FieldByName('WUCHET2_Motiv'),fWUch2.edWUCH2_Motiv);
    AssignDate(qrData.FieldByName('WUCHET2_date'),fWUch2.dtWUCH2_date);
    AssignStr(qrData.FieldByName('WUCH2_ListNumb'),fWUch2.edWuch2ListNumb);
    AssignDate(qrData.FieldByName('WUCH2_ListDate'),fWUch2.edWuch2ListDate);
    if edWUch2_IsWork.Checked then begin
      qrData.FieldByName('WUchet2_IsWork').AsInteger := 1;
    end else begin
      qrData.FieldByName('WUchet2_IsWork').AsInteger := 0;
    end;
    qrData.FieldByName('PDPCode').AsString := ClearPdpCode(GetPDPCode);

    AssignDate(qrData.FieldByName('W_DEND'),dtWEnd);
    AssignStr(qrData.FieldByName('WDISCL'),edWDISCL);
    AssignStr(qrData.FieldByName('WARFARE'),edWarfare);
    AssignDate(qrData.FieldByName('D_OVK'),dtOVK);
    AssignDate(qrData.FieldByName('D_WBIL'),dtWBIL);
    AssignStr(qrData.FieldByName('TAB_NUMB'),edTabNumb);
    if IsStudent then AssignStr(qrData.FieldByName('DOG_NUMB'),edDocNumb)
    else AssignStr(qrData.FieldByName('DOG_NUMB'),edDogNumb);
    if IsStudent then AssignDate(qrData.FieldByName('DOG_DATE'),dtDocDate)
    else AssignDate(qrData.FieldByName('DOG_DATE'),dtDogDate);
    qrData.FieldByName('IS_RAB').Value := Byte(not cbGos.Checked);
    AssignDate(qrData.FieldByName('OUT_DATE'),dtOutDate);
    AssignStr (qrData.FieldByName('OUT_ORD_NUMB'),edOutOrdNumb);
    AssignDate(qrData.FieldByName('OUT_ORD_DATE'),dtOutOrdDate);
    AssignStr (qrData.FieldByName('CONTRACTEND'),edContractEnd);

    AssignStr (qrData.FieldByName('ASOrder_In'), edASOrder_In);
    AssignStr (qrData.FieldByName('ASOut_Ord_Numb'), edASOut_Ord_Numb);
    AssignDate(qrData.FieldByName('ASDate_In'), dtASOrder_Date);
    AssignDate(qrData.FieldByName('ASOut_Date'), dtASOut_Date);
    AssignDate(qrData.FieldByName('ASOut_Ord_Date'), dtASOut_Ord_Date);

    AssignStr (qrData.FieldByName('Med_Where'), edMed_Where);
    AssignDate(qrData.FieldByName('Med_Date'), edMed_Date);
    AssignStr (qrData.FieldByName('Med_Result'), edMed_Result);
    AssignStr (qrData.FieldByName('Psy_Where'), edPsy_Where);
    AssignStr (qrData.FieldByName('Psy_Result'), edPsy_Result);
    AssignDate(qrData.FieldByName('Psy_Date'), edPsy_Date);
    AssignStr (qrData.FieldByName('Asf_Sport'), edAsf_Sport);

    if not qrAssign.Active then qrAssign.Open;
    while not qrAssign.IsEmpty do qrAssign.Delete;
    if (edAssignDate.Text <> '') or (edAssignText.Text <> '') or (edAssignReason.Text <> '') then begin
      qrAssign.Append;
      qrAssign.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
      qrAssign.FieldByName('Assign_Date').Value := edAssignDate.Date;
      if edAssignText.Text <> '' then begin
        n := Integer(edAssignText.Items.Objects[edAssignText.ItemIndex]);
        qrAssign.FieldByName('KAssign').Value := n;
      end;
      qrAssign.FieldByName('AssignText').Value := edAssignText.Text;
      qrAssign.FieldByName('AssignReason').Value := edAssignReason.Text;
      qrAssign.Post;
    end;
    (*for n:=0 to dxtAssign.Count-1 do begin
      qrAssign.Append;
      qrAssign.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
      qrAssign.FieldByName('Assign_Date').Value := dxtAssign.Items[n].Values[0];
      qrAssign.FieldByName('AssignText').Value := dxtAssign.Items[n].Strings[1];
      qrAssign.FieldByName('AssignReason').Value := dxtAssign.Items[n].Strings[2];
      qrAssign.Post;
    end;*)


    if not qrASAssign.Active then qrASAssign.Open;
    while not qrASAssign.IsEmpty do qrASAssign.Delete;
    for n:=0 to dxtASAssign.Count-1 do begin
      qrASAssign.Append;
      qrASAssign.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
      qrASAssign.FieldByName('Assign_Date').Value := dxtASAssign.Items[n].Values[0];
      qrASAssign.FieldByName('Assign_Date_End').Value := dxtASAssign.Items[n].Values[1];
      qrASAssign.FieldByName('AssignWhere').Value := dxtASAssign.Items[n].Strings[2];
      qrASAssign.FieldByName('AssignWhat').Value := dxtASAssign.Items[n].Strings[3];
      qrASAssign.Post;
    end;

    if qrData.FieldByName('OUT_DATE').IsNull
      then qrData.FieldByName('OUT_DATE').Value := qrData.FieldByName('OUT_ORD_DATE').Value
      else
    if qrData.FieldByName('OUT_ORD_DATE').IsNull
      then qrData.FieldByName('OUT_ORD_DATE').Value := qrData.FieldByName('OUT_DATE').Value;
    AssignDate(qrData.FieldByName('CONFDATE'),dtConf);
    with edKval3 do  // See also StoreEducation
    if Integer(Items.Objects[ItemIndex])=0
      then qrData.FieldByName('SC_ID').Value := NULL
      else qrData.FieldByName('SC_ID').Value := Integer(Items.Objects[ItemIndex]);

    //Сведения об учащемся
    if cbStudent.Checked then qrData.FieldByName('IsAspirant').Value := 0
    else qrData.FieldByName('IsAspirant').Clear;
    AssignDate(qrData.FieldByName('StudyEnd_date'),dtEndStudy);
    AssignStr(qrData.FieldByName('OrderAkadem'),edOrderAkadem);
    AssignDate(qrData.FieldByName('OrderAkadem_date'),dtOrderAkadem);
    AssignStr(qrData.FieldByName('ReasonAkadem'),edReasonAkadem);
    AssignDate(qrData.FieldByName('BeginAkadem_date'),dtBeginAkadem);
    AssignDate(qrData.FieldByName('EndAkadem_date'),dtEndAkadem);
    AssignDate(qrData.FieldByName('RealEndAkadem_date'),dtRealEndAkadem);
    AssignDate(qrData.FieldByName('MedResult_date'),dtMedResult);
    qrData.FieldbyName('MedResult').AsInteger := cbMedResult.ItemIndex;
    if rbNone.Checked then qrData.FieldByName('VKStatus').AsInteger := 0;
    if rbInProcess.Checked then qrData.FieldByName('VKStatus').AsInteger := 1;
    if rbCompleted.Checked then qrData.FieldByName('VKStatus').AsInteger := 2;
    if rbFailed.Checked then qrData.FieldByName('VKStatus').AsInteger := 3;
    qrData.FieldByName('War_Program').AsInteger := rbWarProgram.ItemIndex;
    AssignDate(qrData.FieldByName('BeginWar_date'),dtBeginWar);
    AssignDate(qrData.FieldByName('EndWar_date'),dtEndWar);
    AssignDate(qrData.FieldByName('RealEndWar_date'),dtRealEndWar);
    AssignStr(qrData.FieldByName('ReasonEndWar'),edReasonEndWar);
    AssignDate(qrData.FieldByName('Dismissal_date'),dtDismissal);
    AssignStr(qrData.FieldByName('OrderDismissal'),edOrderDismissal);
    AssignDate(qrData.FieldByName('OrderDismissal_date'),dtOrderDismissal);
    AssignStr(qrData.FieldByName('ReasonDismissal'),edReasonDismissal);
    AssignDate(qrData.FieldByName('RealDefend_date'),dtRealDefend);

    AssignDate(qrData.FieldByName('Sovet_Date'), dtSovet_Date);
    AssignStr(qrData.FieldByName('Sovet_Shifr'), edSovet_Shifr);
    AssignStr(qrData.FieldByName('Sovet_Org'), edSovet_Org);
    AssignStr(qrData.FieldByName('Sovet_Num'), edSovet_Num);
    AssignStr(qrData.FieldByName('Sovet_Org_Order'), edSovet_Org_Order);

    //////////////////////
    qrData.Post;
    SetPostAndDep;

// store addresses
    if not qrAddr.Active then qrAddr.Open;
    while not qrAddr.IsEmpty do qrAddr.Delete;
    qrAddr.Append;
    if qrAddr.FieldByName('ADDR_ID').DataType<>ftAutoInc then
      qrAddr.FieldByName('ADDR_ID').Value := GetID('ADDR','ADDR_ID');
    qrAddr.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
    qrAddr.FieldByName('ADDR_TYPE').Value := 0;
    AssignStr(qrAddr.FieldByName('POST_CODE'),fAddr.edIndex1);
    AssignStr(qrAddr.FieldByName('ADDR_STR'),fAddr.edAddr1);
    AssignDate(qrAddr.FieldByName('ADDR_DATE'),fAddr.dtADDR_DATE1);
    AssignDate(qrAddr.FieldByName('ADDR_DATE_END'),fAddr.dtADDR_DATE_END1);
    qrAddr.Post;
    qrAddr.Append;
    if qrAddr.FieldByName('ADDR_ID').DataType<>ftAutoInc then
      qrAddr.FieldByName('ADDR_ID').Value := GetID('ADDR','ADDR_ID');
    qrAddr.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
    qrAddr.FieldByName('ADDR_TYPE').Value := 1;
    AssignDate(qrAddr.FieldByName('ADDR_DATE'),fAddr.dtADDR_DATE2);
    AssignStr(qrAddr.FieldByName('POST_CODE'),fAddr.edIndex2);
    AssignStr(qrAddr.FieldByName('ADDR_STR'),fAddr.edAddr2);
    qrAddr.Post;
// store phones
    if not qrPhones.Active then qrPhones.Open;
    while not qrPhones.IsEmpty do qrPhones.Delete;
    StorePhone(1);
    StorePhone(2);
    StorePhone(3);
// store languages
    if not qrLangs.Active then qrLangs.Open;
    while not qrLangs.IsEmpty do qrLangs.Delete;
    for n:=0 to dxtLang.Count-1 do begin
      qrLangs.Append;
      qrLangs.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
      qrLangs.FieldByName('LANG_ID').Value :=
        Integer(colLangName.Items.Objects[colLangName.Items.IndexOf(dxtLang.Items[n].Values[0])]);
      qrLangs.FieldByName('LSK_ID').Value :=
        Integer(colLangSkill.Items.Objects[colLangSkill.Items.IndexOf(dxtLang.Items[n].Values[1])]);
      qrLangs.Post;
    end;
// store persdeps
    if not qrPersDeps.Active then qrPersDeps.Open;
    while not qrPersDeps.IsEmpty do qrPersDeps.Delete;
    for n:=0 to dxtPersDeps.Count-1 do begin
      qrPersDeps.Append;
      qrPersDeps.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
      qrPersDeps.FieldByName('DEP_ID').Value :=
        Integer(colDepName.Items.Objects[colDepName.Items.IndexOf(dxtPersDeps.Items[n].Values[0])]);
      qrPersDeps.Post;
    end;
// store family
    if not qrFam.Active then qrFam.Open;
    while not qrFam.IsEmpty do qrFam.Delete;
    for n:=0 to fAddr.dxtFamily.Count-1 do begin
      qrFam.Append;
      if qrFam.FieldByName('FAM_ID').DataType<>ftAutoInc then
        qrFam.FieldByName('FAM_ID').Value := GetID('FAMILY','FAM_ID');
      qrFam.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
      qrFam.FieldByName('FT_ID').Value :=
        Integer(fAddr.colFamType.Items.Objects[fAddr.colFamType.Items.IndexOf(fAddr.dxtFamily.Items[n].Values[0])]);
      qrFam.FieldByName('FAM_NAME').Value := fAddr.dxtFamily.Items[n].Strings[1];
      qrFam.FieldByName('FAM_BIRTH').Value := fAddr.dxtFamily.Items[n].Values[2];
      qrFam.FieldByName('FAM_PLACE').Value := fAddr.dxtFamily.Items[n].Values[3];
      qrFam.Post;
    end;
// store education data
    if not qrEduc.Active then qrEduc.Open;
    while not qrEduc.IsEmpty do qrEduc.Delete;
    dMax := StoreEducation(1);
    d := StoreEducation(2);
    if dMax < d then dMax := d;
    d := StoreEducation(3);
    if dMax < d then dMax := d;
    qrData.Edit;
    if DateUtils.YearOf(dMax) = 1900 then
      qrData.FieldByName('END_DATE_DATE').Clear
    else
      qrData.FieldByName('END_DATE_DATE').AsDateTime := dMax;
    qrData.Post;
// store N26History
    if not qrN26History.Active then qrN26History.Open;
    while not qrN26History.IsEmpty do qrN26History.Delete;
    for n:=0 to dxtN26History.Count-1 do begin
      qrN26History.Append;
      if qrN26History.FieldByName('N26_ID').DataType<>ftAutoInc then
        qrN26History.FieldByName('N26_ID').Value := GetID('N26History','N26_ID');
      qrN26History.FieldByName('PERS_ID').Value := qrData.FieldByName('PERS_ID').AsInteger;
      dxtN26History.Items[n].Values[0] := qrN26History.FieldByName('N26_ID').Value;
      qrN26History.FieldByName('FORM_NUM').Value := dxtN26History.Items[n].Strings[1];
      if Trim(dxtN26History.Items[n].Strings[2]) <> '' then
        qrN26History.FieldByName('CREATE_DATE').Value := dxtN26History.Items[n].Values[2];
      if Trim(dxtN26History.Items[n].Strings[3]) <> '' then
        qrN26History.FieldByName('GIVE_DATE').Value := dxtN26History.Items[n].Values[3];
      qrN26History.Post;
    end;
// store education data for aspirant
    if edNapr4.ItemIndex >= 0 then begin
      if (edNapr4.Items.Objects[edNapr4.ItemIndex] <> nil) then begin
        qrEduc.Append;
        if qrEduc.FieldByName('EDQ_ID').DataType<>ftAutoInc then
          qrEduc.FieldByName('EDQ_ID').Value := GetID('EDUC','EDQ_ID');
        qrEduc.FieldByName('PERS_ID' ).Value := qrData.FieldByName('PERS_ID').AsInteger;
        if edNapr4.ItemIndex>=0 then
          qrEduc.FieldByName('NAPR_ID').Value := Integer(edNapr4.Items.Objects[edNapr4.ItemIndex]);
        qrEduc.FieldByName('TYPE').AsInteger := 4;
        qrEduc.Post;
      end;
    end;

    if dmMain.dbMain.InTransaction then dmMain.dbMain.CommitTrans;
    ID := qrData.FieldByName('PERS_ID').AsInteger;
    Result := true;
//refresh lists
    for n:=0 to Application.ComponentCount-1 do
      if Application.Components[n] is TfmPersonList then begin
        (Application.Components[n] as TfmPersonList).qrData.Requery([]);
        (Application.Components[n] as TfmPersonList).qrData.Locate('PERS_ID',ID,[]);
      end;
    FillGroupValues(NewValues);
    FillChanges;
    lblConf.Caption := FormatDateTime('dd.mm.yyyy', dtConf.Date);
  except on e: Exception do begin
    if dmMain.dbMain.InTransaction then dmMain.dbMain.RollbackTrans;
    qrData.Close; qrData.Open;
    qrAddr.Close; qrAddr.Open;
    qrAssign.Close; qrAssign.Open;
    qrASAssign.Close; qrASAssign.Open;
    qrEduc.Close; qrEduc.Open;
    qrFam.Close; qrFam.Open;
    qrLangs.Close; qrLangs.Open;
    qrN26History.Close; qrN26History.Open;
    qrPersDeps.Close; qrPersDeps.Open;
    qrPhones.Close; qrPhones.Open;
    qrStudyHistory.Close; qrStudyHistory.Open;
    if IsNewCard then ID := -1;
    ShowErr('Ошибка при сохранении сведений карточки сотрудника!'#13#10+e.Message);
  end end;
end;

procedure TfmPersonForm.chkVoenClick(Sender: TObject);
var i: Integer;
begin
  for i:=0 to pnlWarMain.Parent.ControlCount-1 do
    if pnlWarMain.Parent.Controls[i]<>pnlWarMain then
      if pnlWarMain.Parent.Controls[i]<>fWUch1.chkSpecialWUch1
        then pnlWarMain.Parent.Controls[i].Enabled := chkVoen.Checked and dmMain.rEdit
        else pnlWarMain.Parent.Controls[i].Enabled := chkVoen.Checked and dmMain.rEdit
                                               and (fWUch1.edWUch1.Text<>'');
  edFam.OnChange(edFam);
end;

procedure TfmPersonForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if fChanged then
    CanClose := Confirm('Сведения личной карточки не сохранены!'+#13+
      'Выйти из карточки без сохранения данных?');
end;

procedure TfmPersonForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SendMessage(hNav,WM_NAV_NOTIFY,NAV_CLOSE,0);
  Action := caFree;
end;

procedure TfmPersonForm.edFamChange(Sender: TObject);
begin
  fChanged := true;
  btnApply.Enabled := fChanged;
end;

procedure TfmPersonForm.aPrintForm26Execute(Sender: TObject);
begin
  fmMain.ShowReport(-1,dxtN26History.FocusedNode.Values[0]);
end;

procedure TfmPersonForm.aPrintForm26Update(Sender: TObject);
begin
  aPrintForm26.Enabled := (dxtN26History.Count > 0) and
                          (not btnApply.Enabled) and
                          (dmMain.rPrint);
end;

procedure TfmPersonForm.bAddrClick(Sender: TObject);
begin
  fAddr.Show;
end;

procedure TfmPersonForm.bDriverClick(Sender: TObject);
begin
  edFam.OnChange(edFam);
end;

procedure TfmPersonForm.bKval1Click(Sender: TObject);
var S: String;
begin
  EditBaseLstModal(30);//KKVAL
  S := edKval1.Text;
  LoadStrings(edKval1.Items,true,'SELECT Kval_ID, Kval_NAME FROM KKval ORDER BY Kval_KOD, Kval_NAME','Kval_ID','Kval_NAME');
  edKval1.ItemIndex := Max(edKval1.Items.IndexOf(S),0);
  S := edKval2.Text;
  LoadStrings(edKval2.Items,true,'SELECT Kval_ID, Kval_NAME FROM KKval ORDER BY Kval_KOD, Kval_NAME','Kval_ID','Kval_NAME');
  edKval2.ItemIndex := Max(edKval2.Items.IndexOf(S),0);
end;

procedure TfmPersonForm.bNapr1Click(Sender: TObject);
var S: String;
begin
  EditBaseLstModal(31);//KNAPR
  S := edNapr1.Text;
  LoadStrings(edNapr1.Items,true,'SELECT NAPR_ID, iif(IsNull(Napr_Kod), "", Trim(NAPR_KOD)) + " " + NAPR_NAME as NAPR_NAME FROM KNAPR ORDER BY NAPR_KOD, NAPR_NAME','NAPR_ID','NAPR_NAME');
  edNapr1.ItemIndex := Max(edNapr1.Items.IndexOf(S),0);
  S := edNapr2.Text;
  LoadStrings(edNapr2.Items,true,'SELECT NAPR_ID, iif(IsNull(Napr_Kod), "", Trim(NAPR_KOD)) + " " + NAPR_NAME as NAPR_NAME FROM KNAPR ORDER BY NAPR_KOD, NAPR_NAME','NAPR_ID','NAPR_NAME');
  edNapr2.ItemIndex := Max(edNapr2.Items.IndexOf(S),0);
  S := edNapr3.Text;
  LoadStrings(edNapr3.Items,true,'SELECT NAPR_ID, iif(IsNull(Napr_Kod), "", Trim(NAPR_KOD)) + " " + NAPR_NAME as NAPR_NAME FROM KNAPR ORDER BY NAPR_KOD, NAPR_NAME','NAPR_ID','NAPR_NAME');
  edNapr3.ItemIndex := Max(edNapr3.Items.IndexOf(S),0);
  S := edNapr4.Text;
  LoadStrings(edNapr4.Items,true,'SELECT NAPR_ID, iif(IsNull(Napr_Kod), "", Trim(NAPR_KOD)) + " " + NAPR_NAME as NAPR_NAME FROM KNAPR ORDER BY NAPR_KOD, NAPR_NAME','NAPR_ID','NAPR_NAME');
  edNapr4.ItemIndex := Max(edNapr4.Items.IndexOf(S),0);
end;

procedure TfmPersonForm.bStudyHistoryClick(Sender: TObject);
begin
  if ID<=0
  then
    ShowErr('Команда будет доступна после сохранения карточки сотрудника!')
  else begin
    ShowStudyHistory(qrData.FieldByName('PERS_ID').AsInteger, qrData.FieldByName('OVK_ID').AsInteger);
    RefreshStudyHistory;
  end;
end;

procedure TfmPersonForm.btnApplyClick(Sender: TObject);
begin
  fChanged := not StoreData;
  btnApply.Enabled := fChanged;
end;

procedure TfmPersonForm.btnOkClick(Sender: TObject);
begin
  if fChanged then
    if not StoreData then Exit
    else fChanged := false;
  btnApply.Enabled := not fChanged;
  Close;
end;

procedure TfmPersonForm.bWUch1Click(Sender: TObject);
begin
  fWUch1.ShowModal;
  CalcWUch1Info;
end;

procedure TfmPersonForm.bWUch2Click(Sender: TObject);
begin
  fWUch2.OldPDPCode := PDPCode;
  fWUch2.NewPDPCode := GetPDPCode;
  fWUch2.ClearedNewPDPCode := ClearPDPCode(GetPDPCode);
  fWUch2.OKVED := OKVED;
  fWUch2.OKVEDChoice := OKVEDChoice;
  fWUch2.ShowModal;
  CalcWUch2Info;
  PDPCode := fWUch2.NewPDPCode;
  OKVED := fWUch2.OKVED;
end;

procedure TfmPersonForm.CalcWuch1Info;
var
  s: String;
begin
  s := '';
  if fWUch1.edWUch1.Text <> '' then
    s := s + 'Команда: '+fWUch1.edWUch1.Text+'; ';
  if (fWUch1.edMob_Days.IntValue > 0) or
     (fWUch1.edMob_Hours.IntValue > 0) or
     (fWUch1.edMob_Mins.IntValue > 0) then begin
    s := s + ' Время явки: ';
    if fWUch1.edMob_Days.IntValue > 0 then
      s := s + 'сутки ' + IntToStr(fWUch1.edMob_Days.IntValue) + ',';
    if fWUch1.edMob_Hours.IntValue > 0 then
      s := s + 'часы ' + IntToStr(fWUch1.edMob_Hours.IntValue) + ',';
    if fWUch1.edMob_Mins.IntValue > 0 then
      s := s + 'минуты ' + IntToStr(fWUch1.edMob_Mins.IntValue) + ',';
    s := Copy(s, 1, Length(s)-1)+'; ';
  end;
  if fWUch1.chkSpecialWuch1.Checked then
    s := s + 'Спецформирование';
  edWUch1Info.Text := s;
end;

procedure TfmPersonForm.CalcWuch2Info;
var
  s: String;
begin
  s := '';
  if edWUch2_IsWork.Checked then begin
    if (fWUch2.edWUch2_Ser.Text <> '') or
       (fWUch2.edWUch2.Text <> '') or
       (fWUch2.dtWUch2_Date.Text <> '') then begin
      s := s + 'Удостоверение: ';
      if fWUch2.edWUch2_Ser.Text <> '' then
        s := s + 'Серия '+fWUch2.edWUch2_Ser.Text+' ';
      if fWUch2.edWUch2.Text <> '' then
        s := s + '№ '+fWUch2.edWUch2.Text+' ';
      if fWUch2.dtWUch2_Date.Text <> '' then
        s := s + 'от '+fWUch2.dtWUch2_Date.Text+' ';
    end;
  end;
  edWUch2Info.Text := s;
end;

procedure TfmPersonForm.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmPersonForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[ssAlt]) and (Key>=ord('0')) and (Key<=ord('9')) then begin
    if Key=ord('0') then Key := ord('9')+1;
    PC.ActivePageIndex := Key - ord('1');
    Key := 0;
  end;
end;

procedure TfmPersonForm.edOKATOKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9']) then Key := #0;
end;

procedure TfmPersonForm.edOrderAkademExit(Sender: TObject);
begin
  if (not fAkadem)and(Trim(dtEndStudy.Text)<>'') then begin
    if Confirm('Прибавить к дате ожидаемого окончания ВУЗа 1 год?') then
      dtEndStudy.Date := IncYear(dtEndStudy.Date);
  end;
  fAkadem := True;
end;

procedure TfmPersonForm.edVodUdSerKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9', 'A'..'Z', 'a'..'z', 'А'..'Я', 'а'..'я']) then Key := #0;
end;

procedure TfmPersonForm.edWUch2_IsWorkClick(Sender: TObject);
begin
  ChkReserv(false);
  CalcWuch2Info;
  edFamChange(Sender);
end;

procedure TfmPersonForm.WM_NavNotify(var msg: TMessage); //message WM_NAV_NOTIFY;
var n,k: Integer;
begin
  ShowWindow(Handle,SW_SHOW);
  fChanging := False;
  if fChanged then
    if Confirm('В карточке имеются несохраненные данные!'#13+
      'Сохранить их?') then
      if not StoreData then Exit;
  if Assigned(FParentList) then
    for n:=0 to Application.MainForm.MDIChildCount-1 do
      if Application.MainForm.MDIChildren[n]=FParentList then begin
        FParentList.qrData.Locate('PERS_ID',ID,[]);
        k := FParentList.dbgData.FocusedNode.Index;
        FParentList.dbgData.Items[k].Focused := false;
        FParentList.dbgData.Items[k].Selected := false;
        case msg.WParam of
          NAV_PREV:
            if FParentList.dbgData.FocusedNode.Index>0 then
            begin
              k := FParentList.dbgData.FocusedNode.Index-1;
              FParentList.dbgData.Items[k].Focused := true;
              FParentList.dbgData.Items[k].Selected := true;
            end;
          NAV_NEXT:
            if FParentList.dbgData.Count-1>FParentList.dbgData.FocusedNode.Index then
            begin
              k := FParentList.dbgData.FocusedNode.Index+1;
              FParentList.dbgData.Items[k].Focused := true;
              FParentList.dbgData.Items[k].Selected := true;
            end;
          NAV_FIRST:
            if FParentList.dbgData.Count>0 then begin
              FParentList.dbgData.Items[0].Focused := true;
              FParentList.dbgData.Items[0].Selected := true;
            end;
          NAV_LAST:
            if FParentList.dbgData.Count>0 then begin
              FParentList.dbgData.Items[FParentList.dbgData.Count-1].Focused := true;
              FParentList.dbgData.Items[FParentList.dbgData.Count-1].Selected := true;
            end;
        end;
        if FParentList.qrData.FieldByName('PERS_ID').AsInteger<>ID then begin
          ID := FParentList.qrData.FieldByName('PERS_ID').AsInteger;
          LoadData;
        end;
        Exit;
      end;
  FParentList := nil;
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select pers_id from Person order by fam, im ,otch';
    Open;
    if not IsEmpty then begin
      Locate('pers_id',ID,[]);
      case msg.WParam of
        NAV_PREV:  Prior;
        NAV_NEXT:  Next;
        NAV_FIRST: First;
        NAV_LAST:  Last;
      end;
      if Fields[0].AsInteger<>ID then begin
        ID := Fields[0].AsInteger;
        LoadData;
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfmPersonForm.FillChanges;
var
  i: Integer;
begin
  qrChanges.Open;
  for i := 1 to Length(OldValues) do
    if OldValues[i] <> NewValues[i] then begin
      qrChanges.Insert;
      qrChangesPERS_ID.Value := ID;
      qrChangesGROUP_ID.Value := i;
      qrChangesOLDVALUE.Value := OldValues[i];
      qrChangesNEWVALUE.Value := NewValues[i];
      qrChangesCHANGE_DATE.Value := dtConf.Date;
      qrChangesOutDate.Value := dtConf.Date;
      if (i in [5,6]) and (Appointment_Id > 0) then
        qrChangesAppointment_Id.AsInteger := Appointment_Id;
      qrChanges.Post;
    end;
  qrChanges.Close;
  qrChanges.Open;
  FillGroupValues(OldValues);
end;

procedure TfmPersonForm.FillGroupValues(var groupvalues: array of string);
var
  values: array[1..10]of string absolute groupvalues;
  i: Integer;
  s: String;
begin
  values[1] := fAddr.cbFamState.Text;
  for i := 0 to fAddr.dxtFamily.Count - 1 do begin
    if values[1] <> '' then values[1] := values[1] + ', ';
    values[1] := values[1] + fAddr.dxtFamily.Items[i].Strings[0] + ' ' +
      fAddr.dxtFamily.Items[i].Strings[1] + ' д.р. ' + fAddr.dxtFamily.Items[i].Strings[2] + ' г.';
  end;

  values[2] := cbUz1.Text;
  if (values[2] <> '') and (Trim(cbObrDoc1.Text) <> '') then values[2] := values[2] + ', ';
  values[2] := values[2] + cbObrDoc1.Text;
  if (values[2] <> '') and (Trim(edDiplSer1.Text) <> '') then values[2] := values[2] + ', ';
  values[2] := values[2] + edDiplSer1.Text;
  if (values[2] <> '') and (Trim(edDipl1.Text) <> '') then values[2] := values[2] + ', ';
  values[2] := values[2] + edDipl1.Text;
  if (values[2] <> '') and (Trim(edDate1.Text) <> '') then values[2] := values[2] + ', ';
  values[2] := values[2] + edDate1.Text;
  if (values[2] <> '') and (Trim(edKval1.Text) <> '') then values[2] := values[2] + ', ';
  values[2] := values[2] + edKval1.Text;
  if (values[2] <> '') and (Trim(edNapr1.Text) <> '') then values[2] := values[2] + ', ';
  values[2] := values[2] + edNapr1.Text;

  values[3] := cbUz2.Text;
  if (values[3] <> '') and (Trim(cbObrDoc2.Text) <> '') then values[3] := values[3] + ', ';
  values[3] := values[3] + cbObrDoc2.Text;
  if (values[3] <> '') and (Trim(edDiplSer2.Text) <> '') then values[3] := values[3] + ', ';
  values[3] := values[3] + edDiplSer2.Text;
  if (values[3] <> '') and (Trim(edDipl2.Text) <> '') then values[3] := values[3] + ', ';
  values[3] := values[3] + edDipl2.Text;
  if (values[3] <> '') and (Trim(edDate2.Text) <> '') then values[3] := values[3] + ', ';
  values[3] := values[3] + edDate2.Text;
  if (values[3] <> '') and (Trim(edKval2.Text) <> '') then values[3] := values[3] + ', ';
  values[3] := values[3] + edKval2.Text;
  if (values[3] <> '') and (Trim(edNapr2.Text) <> '') then values[3] := values[3] + ', ';
  values[3] := values[3] + edNapr2.Text;
  
  values[4] := cbFormPrep3.Text;
  if (values[4] <> '') and (Trim(cbUz3.Text) <> '') then values[4] := values[4] + ', ';
  values[4] := values[4] + cbUz3.Text;
  if (values[4] <> '') and (Trim(edDate3.Text) <> '') then values[4] := values[4] + ', ';
  values[4] := values[4] + edDate3.Text;
  if (values[4] <> '') and (Trim(cbObrDoc3.Text) <> '') then values[4] := values[4] + ', ';
  values[4] := values[4] + cbObrDoc3.Text;
  if (values[4] <> '') and (Trim(edDiplSer3.Text) <> '') then values[4] := values[4] + ', ';
  values[4] := values[4] + edDiplSer3.Text;
  if (values[4] <> '') and (Trim(edDipl3.Text) <> '') then values[4] := values[4] + ', ';
  values[4] := values[4] + edDipl3.Text;
  if (values[4] <> '') and (Trim(edDateGive3.Text) <> '') then values[4] := values[4] + ', ';
  values[4] := values[4] + edDateGive3.Text;
  if (edKval3.Text <> '<не указано>') and (Trim(edKval3.Text) <> '') then begin
    if values[4] <> '' then values[4] := values[4] + ', ';
    values[4] := values[4] + edKval3.Text;
  end;
  if (values[4] <> '') and (Trim(edNapr3.Text) <> '') then values[4] := values[4] + ', ';
  values[4] := values[4] + edNapr3.Text;

  values[5] := '';
  values[6] := '';
  if not cbStudent.Checked then
  begin
    values[5] := IfThen(dep_full_name = '', stDepart.Text, dep_full_name);
    values[6] := stPost.Text;
  end;

  values[7] := fAddr.dtADDR_DATE1.Text;
  if (values[7] <> '') and (Trim(fAddr.edIndex1.Text) <> '') then values[7] := values[7] + ', ';
  values[7] := values[7] + fAddr.edIndex1.Text;
  if (values[7] <> '') and (Trim(fAddr.edAddr1.Text) <> '') then values[7] := values[7] + ', ';
  values[7] := values[7] + fAddr.edAddr1.Text;

  values[8] := fAddr.edIndex2.Text;
  if (values[8] <> '') and (Trim(fAddr.edAddr2.Text) <> '') then values[8] := values[8] + ', ';
  values[8] := values[8] + fAddr.edAddr2.Text;

  values[9] := edHealth.Text;
  if (values[9] <> '') and (Trim(edHealthDoc.Text) <> '') then values[9] := values[9] + ', ';
  values[9] := values[9] + edHealthDoc.Text;
  if (values[9] <> '') and (Trim(dtHealthDoc_date.Text) <> '') then values[9] := values[9] + ', ';
  values[9] := values[9] + dtHealthDoc_date.Text;

  s := '';
  if (Trim(edOrderAkadem.Text) <> '') or (Trim(dtOrderAkadem.Text) <> '') then begin
    s := s + 'Приказ';
    if (Trim(edOrderAkadem.Text) <> '') then
      s := s + ' № ' + Trim(edOrderAkadem.Text);
    if (Trim(dtOrderAkadem.Text) <> '') then
      s := s + ' от ' + Trim(dtOrderAkadem.Text);
    s := s + ', ';
  end;
  if (Trim(edReasonAkadem.Text) <> '') then
    s := s + 'Причина: ' + Trim(edReasonAkadem.Text) + ', ';
  if (Trim(dtBeginAkadem.Text) <> '') or (Trim(dtEndAkadem.Text) <> '') then begin
    if (Trim(dtBeginAkadem.Text) <> '') then
      s := s + ' с ' + Trim(dtBeginAkadem.Text);
    if (Trim(dtEndAkadem.Text) <> '') then
      s := s + ' по ' + Trim(dtEndAkadem.Text);
    s := s + ', ';
  end;
  if (Trim(dtRealEndAkadem.Text) <> '') then
    s := s + 'Факт.выход: ' + Trim(dtRealEndAkadem.Text) + ', ';
  if (Trim(dtMedResult.Text) <> '') then
    s := s + 'Медкомиссия: ' + Trim(dtMedResult.Text) + ', ';
  if (Trim(cbMedResult.Text) <> '') then
    s := s + 'Результат медкомиссии: ' + Trim(cbMedResult.Text) + ', ';

  if s <> '' then
    s := Copy(s, 1, Length(s) - 2);
  values[10] := s;


end;

procedure TfmPersonForm.FormActivate(Sender: TObject);
var r,r2: TRect;
begin
// set nav position
  GetWindowRect(Handle,r);
  GetWindowRect(hNav,r2);
  with r do
    SendMessage(hNav,WM_NAV_NOTIFY,NAV_POS,MAKELPARAM(Word(Right),Word(Bottom-r2.Bottom+r2.Top)));
end;

procedure TfmPersonForm.WM_OnMove(var msg: TMessage); //message WM_MOVING;
begin
  FormActivate(Self);
end;

procedure TfmPersonForm.FormDeactivate(Sender: TObject);
begin
  if IsIconic(Handle) or (Application.MainForm.ActiveMDIChild<>Self) then
    ShowWindow(hNav,SW_HIDE);
end;

function TfmPersonForm.GetWSOST_IDstr: String;
begin
  if cbWProf.ItemIndex<0
    then Result := '-1'
    else Result := IntToStr(Integer(cbWProf.Items.Objects[cbWProf.ItemIndex]));
end;

function TfmPersonForm.GetWRng_IdStr: String;
begin
  if cbWRange.ItemIndex<0 then
    Result := '-1'
  else begin
    qrWRange.RecNo := Integer(cbWRange.Items.Objects[cbWRange.ItemIndex]);
    Result := qrWRange.FieldByName('WRNG_ID').AsString;
  end;
end;

function TfmPersonForm.ChkReserv(saving: Boolean): boolean;
//
  function IIF(Condition: Boolean; TrueRes, FalseRes: Integer): Integer;
  begin
    if Condition
    then Result := Trueres
    else result := FalseRes;
  end;
//
var
  WorkMain  : Boolean; //Работа основная.
  WorkPerm  : Boolean; //Работа постоянная.
  DepIsWar  : Boolean; //Подразделение в ШРВВ.
  VUSIsOk   : Boolean; //ВУС не дефицитна.
  Cmd300    : Boolean; //Шаблон %300% подходит!
  SpecForm  : Boolean; //Спецформирование!
  DocIsSprav: Boolean; //Справка уклониста
  DocIsOk: Boolean; //Не Справка уклониста и не приписное
  StudWRangeOk: Boolean; // Звание не "подлежит призыву" или "допризывник"
  ProbationOk: Boolean; // Испытательный срок завершен
  IsIgnore  : Boolean; //игнорировать при расчете ф.6
  DefPost   : Boolean; //Должность найдена в перечне бронируемых.
  DefPost_Post, DefPost_WRange, DefPost_WSost: Boolean;
  DoReserv  : Boolean; //Должен быть забронирован.
  CHE       : Integer; //Численный эквивалент звания
  AGE       : Integer; //Возраст на начало года
  Driver: Boolean; // водитель моб. транспорта
  MobContract: Boolean; // контракт на моб. резерв
  DEP_NAME  : String;
  POST_NAME : String;
  Msg       : String;
  Male: Integer;
  q: TADOQuery;
  Wrng_Len: Integer;
  IsMvkOrder: Boolean;
  IsStudent: Boolean;
begin
  Result := True;
  if not chkVoen.Checked or (dtWEnd.Text<>EmptyStr) then Exit;

  if rbMale.Checked then Male := 1 else Male := 0;

  q := TADOQuery.Create(nil);
  with q do
  try
    Connection := dMain.dmMain.dbMain;
    ParamCheck := False;

    SQL.Text :=
      'Select * FROM (Person AS P '#13+
      'inner JOIN Appointment as AppointmentLastAll ON P.AppLast=AppointmentLastAll.ID) '#13+
      'inner join MvkOrder as mo on p.Pers_Id = mo.Pers_Id and AppointmentLastAll.Post_Id = mo.Post_Id ' +
      'Where p.Pers_Id = '+ IntToStr(ID);
    Open;
    IsMvkOrder := not Eof;
    Close;
    SQL.Text :=
      'SELECT AppointmentLastAll.*, KDEPART.DEP_NAME, KPOST.POST_NAME, KPOST.IsIgnore,  '#13+
            ' Iif(KPost.CPROF_ID = 500 or KPost.CPROF2015_ID = 500, 1, 0) as IsStudent  '#13+
            '     , IIF(IIF(ISNULL([StaffList].WartimePlan),0,[StaffList].WartimePlan)>0,1,0) AS WARTIME'#13+
            '     , IIF(EXISTS(SELECT *'#13+
                              '  FROM PDP'#13+
                              ' WHERE PDP.POST_ID = AppointmentLastAll.POST_ID'#13+
                              '   AND (PDP.Limited = 0 OR '''+edWCat.Text+'''=''В'')'#13+
                              '   AND PDP.WSOST LIKE ''%.'+GetWSOST_IDstr+'.%'''#13+
                              '   AND (PDP.WRange=0 OR PDP.CHE >= (SELECT CHE FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr+'))'#13+
                              '   AND PDP.AGE <= '+IntToStr(GetFullAge(dtBirth.Date))+#13+
                              '   AND ((PDP.Sex=1 and '+IntToStr(Male)+'=1) or (PDP.Sex=2 and '+IntToStr(Male)+'<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2))), 1, 0) AS DefPOST, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID '#13+
          '   AND (PDP.Limited = 0 OR '''+edWCat.Text+'''=''В'')'#13+
          '   AND PDP.WSOST LIKE ''%.'+GetWSOST_IDstr+'.%'''#13+
          '   AND (PDP.WRange=0 OR PDP.CHE >= (SELECT CHE FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr+'))'#13+
          '   AND PDP.AGE <= '+IntToStr(GetFullAge(dtBirth.Date))+#13+
          '   AND ((PDP.Sex=1 and '+IntToStr(Male)+'=1) or (PDP.Sex=2 and '+IntToStr(Male)+'<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE (PDP.POST_ID = AppointmentLastAll.POST_ID)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
          '   (PDP.Limited = 0 OR '''+edWCat.Text+'''=''В'')'#13+
          '   AND PDP.WSOST LIKE ''%.'+GetWSOST_IDstr+'.%'''#13+
          '   AND (PDP.WRange=0 OR PDP.CHE >= (SELECT CHE FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr+'))'#13+
          '   AND PDP.AGE <= '+IntToStr(GetFullAge(dtBirth.Date))+#13+
          '   AND ((PDP.Sex=1 and '+IntToStr(Male)+'=1) or (PDP.Sex=2 and '+IntToStr(Male)+'<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_Post, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID '#13+
          '   AND (PDP.Limited = 0 OR '''+edWCat.Text+'''=''В'')'#13+
          '   AND PDP.WSOST LIKE ''%.'+GetWSOST_IDstr+'.%'''#13+
          '   AND (PDP.WRange=0 OR PDP.CHE >= (SELECT CHE FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr+'))'#13+
          '   AND PDP.AGE <= '+IntToStr(GetFullAge(dtBirth.Date))+#13+
          '   AND ((PDP.Sex=1 and '+IntToStr(Male)+'=1) or (PDP.Sex=2 and '+IntToStr(Male)+'<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE  (PDP.WRange=0 OR PDP.CHE >= (SELECT CHE FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr+'))) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID '#13+
          '   AND (PDP.Limited = 0 OR '''+edWCat.Text+'''=''В'')'#13+
          '   AND PDP.WSOST LIKE ''%.'+GetWSOST_IDstr+'.%'''#13+
          '   AND PDP.AGE <= '+IntToStr(GetFullAge(dtBirth.Date))+#13+
          '   AND ((PDP.Sex=1 and '+IntToStr(Male)+'=1) or (PDP.Sex=2 and '+IntToStr(Male)+'<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_WRange, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID '#13+
          '   AND (PDP.Limited = 0 OR '''+edWCat.Text+'''=''В'')'#13+
          '   AND PDP.WSOST LIKE ''%.'+GetWSOST_IDstr+'.%'''#13+
          '   AND (PDP.WRange=0 OR PDP.CHE >= (SELECT CHE FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr+'))'#13+
          '   AND PDP.AGE <= '+IntToStr(GetFullAge(dtBirth.Date))+#13+
          '   AND ((PDP.Sex=1 and '+IntToStr(Male)+'=1) or (PDP.Sex=2 and '+IntToStr(Male)+'<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE PDP.WSOST LIKE ''%.'+GetWSOST_IDstr+'.%'') or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID '#13+
          '   AND (PDP.Limited = 0 OR '''+edWCat.Text+'''=''В'')'#13+
          '   AND (PDP.WRange=0 OR PDP.CHE >= (SELECT CHE FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr+'))'#13+
          '   AND PDP.AGE <= '+IntToStr(GetFullAge(dtBirth.Date))+#13+
          '   AND ((PDP.Sex=1 and '+IntToStr(Male)+'=1) or (PDP.Sex=2 and '+IntToStr(Male)+'<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_WSost '#13+


      '  FROM ((AppointmentLastAll '#13+
      '   LEFT JOIN KDepart ON KDepart.DEP_ID = AppointmentLastAll.DEP_ID)'#13+
      '   LEFT JOIN KPOST ON KPOST.POST_ID = AppointmentLastAll.POST_ID)'#13+
      '   LEFT JOIN StaffList ON AppointmentLastAll.DEP_ID=[StaffList].DEP_ID'#13+
      '                      AND AppointmentLastAll.POST_ID=[StaffList].POST_ID'#13+
      ' WHERE PERS_ID = '+IntToStr(ID);


    Open;
    if IsEmpty then begin
      WorkMain  := False;
      WorkPerm  := False;
      DepIsWar  := False;
      DefPost   := False;
      DefPost_Post  := False;
      DefPost_WRange:= False;
      DefPost_WSost := False;
      DEP_NAME  := '';
      POST_NAME := '';
      IsIgnore := False;
      IsStudent := False;
      ProbationOk := False;
      Driver := False;
      MobContract := False;
    end
    else begin
      WorkMain  := FieldByName('WTP_ID')   .AsInteger in [1,3,9];
      WorkPerm  := FieldByName('WCH_ID')   .AsInteger = 1;
      DepIsWar  := FieldByName('WARTIME')  .AsInteger = 1;
      DefPost   := FieldByName('DefPost')  .AsInteger = 1;
      DefPost_Post   := FieldByName('DefPost_Post')  .AsInteger = 1;
      DefPost_WRange := FieldByName('DefPost_WRange').AsInteger = 1;
      DefPost_WSost  := FieldByName('DefPost_WSost') .AsInteger = 1;
      DEP_NAME  := FieldByName('DEP_NAME') .AsString;
      POST_NAME := FieldByName('POST_NAME').AsString;
      IsIgnore  := FieldByName('IsIgnore') .AsBoolean;
      IsStudent := FieldByName('IsStudent').AsInteger = 1;
      Driver := bDriver.Checked;
      ProbationOk := FieldByName('Probation_Date').IsNull or (FieldByName('Probation_Date').AsDateTime < Date);
      MobContract := (dtMobContract.Text<>EmptyStr) and not (dtMobContract.Date < Date);
    end;
    DocIsSprav := cbDocument.ItemIndex = 3;
    DocIsOk := cbDocument.ItemIndex < 2;
    StudWRangeOk := (GetWRng_IdStr <> '1') and (GetWRng_IdStr <> '37');
    Close;
    SQL.Text := 'SELECT state FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr;
    Open;
    Wrng_Len := 3;
    if not Eof then begin
      if not Fields[0].IsNull then begin
        if Fields[0].AsInteger = 3 then Wrng_Len := 6;
      end;
    end;
    Close;
    SQL.Text := 'SELECT * FROM KDEFVUS WHERE NAME = '+QuotedStr(Copy(edVUS.Text, 1, Wrng_Len));
    //left(P.VUS, IIF((select state from KWRANGE where WRNG_ID = P.WRNG_ID) = 3, 6, 3))),1,0)
    Open;
    VUSIsOk := IsEmpty;
    Close;
    SQL.Text := 'SELECT * FROM Command300 WHERE '+QuotedStr(fWUch1.edWUCH1.Text)+' LIKE Template';
    Open;
    Cmd300 := not IsEmpty;
    Close;
    SQL.Text := 'SELECT CHE FROM KWRange WHERE WRng_Id = '+GetWRng_IdStr;
    Open;
    CHE := Fields[0].AsInteger;
    Close;
    AGE := CurrentYear-YearOf(dtBirth.Date);
    SpecForm := fWUch1.chkSpecialWUch1.Checked;
    edEOARMY_DATE.Text := Trim(edEOARMY_DATE.Text);
  finally Free;
  end;
  DoReserv := IsMvkOrder or
    (WorkMain and WorkPerm and DepIsWar and VUSIsOk and not Cmd300 and not SpecForm and DefPost and
      ProbationOk and not DocIsSprav and not Driver and not MobContract) or
    (IsStudent and StudWRangeOk and DocIsOk and VUSIsOk and (fWUch1.edWUCH1.Text = '') and not IsIgnore);

  Msg := '';
  if edWUch2_IsWork.Checked then begin //IsReserved
    if not DoReserv then begin
      if IsStudent then begin
        if not StudWRangeOk then Msg := 'воинское звание студента «подлежит призыву» или «допризывник».' else
        if not DocIsOk then Msg := 'воинский документ студента «справка уклониста» или «приписное свидетельство».' else
        if not VUSIsOk  then Msg := 'ВУС входит в список дефицитных.' else
        if fWUch1.edWUCH1.Text <> ''  then Msg := 'студент имеет мобилизационное предписание.' else
        if IsIgnore  then Msg := 'статус учащегося помечен как игнорируемый.' else
      end else begin
        if not WorkMain then Msg := 'вид работы - по совместительству.' else
        if not WorkPerm then Msg := 'характер работы - временный.' else
        if not DepIsWar then Msg := Format(
          'должность "%s" в подразделении "%s" не задействована в '+
          'штатном расписании военного времени.',
          [POST_NAME, DEP_NAME]) else
        if not VUSIsOk  then Msg := 'ВУС входит в список дефицитных.' else
        if Cmd300       then Msg := 'имеется моб. предписание по небронируемой команде.' else
        if SpecForm     then Msg := 'имеется моб. предписание в спецформирование.' else
        if DocIsSprav   then Msg := 'не подлежит бронированию как владелец справки уклониста.' else
        if not ProbationOk then Msg := 'не подлежит бронированию как не завершивший испытательный срок.' else
        if Driver then Msg := 'не подлежит бронированию как водитель транспорта для поставки по мобилизации.' else
        if MobContract then Msg := 'не подлежит бронированию как заключивший контракт на пребывание в мобилизационном людском резерве.' else
        if not DefPost  then begin
          Msg := 'работник не подпадает ни под один пункт ПДП.';
          if not DefPost_Post then
            Msg := Msg + #13#10'Для данной должности в ПДП бронирование не предусмотрено.';
          if not DefPost_WRange then
            Msg := Msg + #13#10'Для данного воинского звания в ПДП бронирование не предусмотрено.';
          if not DefPost_WSost then
            Msg := Msg + #13#10'Военнослужащие такого состава/профиля не фигурируют в ПДП.';
        end;{ else
          Msg := 'уволен из армии менее 5-ти лет назад и пребывает в запасе по I разряду.';}
      end;
      Msg := 'Бронирование некорректно, т.к. '+Msg;
    end
  end
  else begin
    if DoReserv then  Msg := 'Данный сотрудник не забронирован, но отвечает всем условиям бронирования.';
  end;
  if Msg<>'' then
    if saving then
      Result := Confirm('Внимание! '+Msg+ #13#13'Продолжить сохранение?')
    else
      ShowInfo('Внимание! '+Msg);
end;

procedure TfmPersonForm.btnAppointmentsClick(Sender: TObject);
begin
  if ID<=0
  then
    ShowErr('Команда будет доступна после сохранения карточки сотрудника!')
  else begin
    ShowAppointments(qrData.FieldByName('PERS_ID').AsInteger, qrData.FieldByName('OVK_ID').AsInteger);
    RefreshAppointment;

    NewValues := OldValues;
    if (not cbStudent.Checked) then begin
      NewValues[5] := IfThen(dep_full_name = '', stDepart.Text, dep_full_name);
      NewValues[6] := stPost.Text;
      FillChanges;
    end;
  end;
end;

procedure TfmPersonForm.btnASAppointmentsClick(Sender: TObject);
begin
  if ID<=0
  then
    ShowErr('Команда будет доступна после сохранения карточки сотрудника!')
  else begin
    ShowASAppointments(qrData.FieldByName('PERS_ID').AsInteger);
    RefreshASAppointment;
  end;
end;

procedure TfmPersonForm.dsDataDataChange(Sender: TObject; Field: TField);
begin
  RefreshAppointment;
  RefreshASAppointment;
end;

procedure TfmPersonForm.RefreshAppointment;
var CPROF_ID, CPROF2015_ID: String;
begin
  if (qrData.State = dsBrowse) and not qrData.IsEmpty  then
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;

    SQL.Text := 'SELECT * FROM (((((Appointment'+
      ' LEFT JOIN KWKTYPE ON KWKTYPE.WTP_ID=Appointment.WTP_ID)'+
      ' LEFT JOIN KWKCHAR ON KWKCHAR.WCH_ID=Appointment.WCH_ID)'+
      ' LEFT JOIN KPOST   ON KPOST.POST_ID=Appointment.POST_ID)'+
      ' LEFT JOIN KDEPART ON KDEPART.DEP_ID=Appointment.DEP_ID)'+
      ' LEFT JOIN KOKPDTR ON KOKPDTR.KOKPDTR_ID=KPOST.KOKPDTR)'+
      ' WHERE PERS_ID='+
      qrData.FieldByName('PERS_ID').AsString+
      ' AND Appointment.POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID <> 500 and CPROF2015_ID <> 500)' +
      ' ORDER BY IN_DATE';
    Open;
    First;
    if (stInDate.Text <> FieldByName('IN_DATE').AsString) then edFamChange(nil);
    stInDate.Text := FieldByName('IN_DATE').AsString;
    Last;
    if (stWorkType.Text <> FieldByName('WTP_NAME').AsString) then edFamChange(nil);
    stWorkType.Text := FieldByName('WTP_NAME').AsString;
    edContractEnd.Enabled := FieldByName('Appointment.WCH_ID').AsInteger = 2;
    with edContractEnd do if Enabled then Color := clWindow else Color := clBtnFace;
    if (stWorkChar.Text <> FieldByName('WCH_NAME').AsString) then edFamChange(nil);
    stWorkChar.Text := FieldByName('WCH_NAME').AsString;
    if (stPost.Text <> FieldByName('POST_NAME').AsString) then edFamChange(nil);
    stPost    .Text := FieldByName('POST_NAME').AsString;
    if (stDepart.Text <> FieldByName('DEP_NAME').AsString) then edFamChange(nil);
    stDepart  .Text := FieldByName('DEP_NAME').AsString;
    stOKPDTR  .Text := FieldByName('KOKPDTR_CODE').AsString + ' ' + FieldByName('KOKPDTR_NAME').AsString;
    dep_full_name := FieldByName('DEP_FULL_NAME').AsString;
    CPROF_ID        := FieldByName('CPROF_ID').AsString;
    CPROF2015_ID    := FieldByName('CPROF2015_ID').AsString;
    Appointment_Id  := FieldByName('Id').AsInteger;
    Close;
    if CPROF_ID<>'' then begin
      SQL.Text := 'SELECT CPROF_NAME FROM KCPROF WHERE CPROF_ID='+CPROF_ID;
      Open;
      if (stCateg.Text <> Fields[0].AsString) then edFamChange(nil);
      stCateg.Text := Fields[0].AsString;
    end
    else begin
      if (stCateg.Text <> '') then edFamChange(nil);
      stCateg.Text := '';
    end;
    if CPROF2015_ID<>'' then begin
      SQL.Text := 'SELECT CPROF_NAME FROM KCPROF2015 WHERE CPROF_ID='+CPROF2015_ID;
      Open;
      if (stCateg2015.Text <> Fields[0].AsString) then edFamChange(nil);
      stCateg2015.Text := Fields[0].AsString;
    end
    else begin
      if (stCateg2015.Text <> '') then edFamChange(nil);
      stCateg2015.Text := '';
    end;
  finally Free;
  end;
end;

procedure TfmPersonForm.RefreshASAppointment;
var
  q: TADOQuery;
begin
  if (qrData.State = dsBrowse) and not qrData.IsEmpty  then begin
    q := TADOQuery.Create(nil);
    with q do try
      Connection := dmMain.dbMain;
      ParamCheck := False;

      SQL.Text := 'SELECT * FROM ((ASAppointment'+
        ' LEFT JOIN ASPost ON ASPost.ASPOST_ID=ASAppointment.ASPOST_ID)'+
        ' LEFT JOIN '+
        ' (Select ASP.ASP_ID, ASP.ASF_ID, ASP.DEP_Name, ASP.ASP_Num, ASP.ASP_Type,  ASF.ORGName, ASF.ORGSName, ASF.ASFType_Id '+
        ' from ASP '+
        ' Inner JOIN ASF ON ASF.ASF_ID=ASP.ASF_ID '+
        ' union '+
        ' Select -ASF_ID, ASF_ID, iif(ASF.ORGSName='''',ASF.ORGName, ASF.ORGSName), -1, null,  ASF.ORGName, ASF.ORGSName, ASF.ASFType_Id '+
        ' from ASF) As ASPX on ASAppointment.ASP_Id = ASPX.ASP_Id) '+
        ' WHERE ASAppointment.PERS_ID='+
        qrData.FieldByName('PERS_ID').AsString+
        ' ORDER BY IN_DATE';
      Open;
      First;
      if (stASInDate.Text <> FieldByName('IN_DATE').AsString) then edFamChange(nil);
      stASInDate.Text := FieldByName('IN_DATE').AsString;
      Last;
      if (stASPost.Text <> FieldByName('POST_NAME').AsString) then edFamChange(nil);
      stASPost    .Text := FieldByName('POST_NAME').AsString;
      if (stASDepart.Text <> FieldByName('DEP_NAME').AsString) then edFamChange(nil);
      stASDepart  .Text := FieldByName('DEP_NAME').AsString;
      stASF       .Text := FieldByName('OrgSNAME').AsString;
      if stASF.Text = '' then stASF.Text := FieldByName('OrgNAME').AsString;
      Close;
    finally Free;
    end;
  end;
end;

procedure TfmPersonForm.RefreshStudyHistory;
var CPROF_ID, CPROF2015_ID: String;
begin
  if (qrData.State = dsBrowse) and not qrData.IsEmpty  then
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;

    SQL.Text := 'SELECT *, iif(IsNull(Napr_Kod), "", Trim(NAPR_KOD)) + " " + NAPR_NAME as XNAPR_NAME '+
      ' FROM (Appointment'+
      ' LEFT JOIN KNAPR   ON KNAPR.NAPR_ID=Appointment.NAPR_ID)'+
      ' WHERE PERS_ID='+
      qrData.FieldByName('PERS_ID').AsString+
      ' AND Appointment.POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID = 500 or CPROF2015_ID = 500)' +
      ' ORDER BY IN_DATE';
    Open;
    Last;
    dtBeginStudy.Text := FieldByName('IN_DATE').AsString;
    edOrder.Text := FieldByName('IN_ORD_NUMB').AsString;
    dtOrder.Text := FieldByName('IN_ORD_DATE').AsString;
    edStudyForm.Text := FieldByName('XNAPR_NAME').AsString;
    //Appointment_Id  := FieldByName('Id').AsInteger;
    Close;
  finally Free;
  end;
end;

procedure TfmPersonForm.edKvalnNaprChange(Sender: TObject);
var
  Comp: TdxMRUEdit absolute Sender;
  Comp2: TdxMRUEdit;
begin
  if fChanging then Exit;
  fChanging := True;
  if Length(Comp.Name) > 7 then
    Comp2 := FindComponent(LeftStr(Comp.Name, 6) + RightStr(Comp.Name, 1)) as TdxMRUEdit
  else
    Comp2 := FindComponent(LeftStr(Comp.Name, 6) + 'Kod' + RightStr(Comp.Name, 1)) as TdxMRUEdit;
  if Comp.ItemIndex < 0 then Comp.ItemIndex := Comp.Items.IndexOfObject(TObject(0));
  Comp2.ItemIndex := Comp2.Items.IndexOfObject(Comp.Items.Objects[Comp.ItemIndex]);
  if Comp2.ItemIndex < 0 then Comp2.ItemIndex := Comp2.Items.IndexOfObject(TObject(0));
  edFamChange(nil);
  fChanging := False;
end;

procedure TfmPersonForm.edKval3ButtonClick(Sender: TObject);
var S: String;
begin
  EditBaseLstModal(15);//KSCIENCE
  S := edKval3.Text;
  LoadStrings(edKval3.Items,true,'SELECT * FROM KSCIENCE WHERE SC_FLAG = 2 ORDER BY SC_NAME','SC_ID','SC_NAME');
  edKval3.ItemIndex := Max(edKval3.Items.IndexOf(S),0);
  rbAspirantClick(nil);
//  S := edDegree.Text;
//  LoadStrings(edDegree.Items,true,'SELECT * FROM KSCIENCE WHERE SC_FLAG = 2 ORDER BY SC_NAME','SC_ID','SC_NAME');
//  edDegree.ItemIndex := Max(edDegree.Items.IndexOf(S),0);
end;

procedure TfmPersonForm.edKvalnNaprButtonClick(Sender: TObject);
var
  i: Integer;
  IsKval: Boolean;
  S, Name: String;
  Comp: TdxMRUEdit absolute Sender;
begin
  IsKval := LeftStr(Comp.Name, 6) = 'edKval';
  Name := IfThen(IsKval, 'KVAL', 'NAPR');
  EditBaseLstModal(IfThen(IsKval, 30, 31));
  for i := 1 to IfThen(IsKval, 2, 3) do begin
    Comp := FindComponent(LeftStr(Comp.Name, 6) + IntToStr(i)) as TdxMRUEdit;
    S := Comp.Text;
    LoadStrings(Comp.Items,true,
      'SELECT ' + Name + '_ID, ' + Name + '_NAME FROM K' + Name + ' WHERE ' + Name + '_FLAG = ' +
        IfThen(i = 3, '2', '1') + ' ORDER BY ' + Name + '_NAME',Name + '_ID',Name + '_NAME');
    LoadStrings((FindComponent(LeftStr(Comp.Name, 6) + 'Kod' + IntToStr(i)) as TdxMRUEdit).Items,true,
      'SELECT ' + Name + '_ID, ' + Name + '_KOD FROM K' + Name + ' WHERE ' + Name + '_FLAG = ' +
        IfThen(i = 3, '2', '1') + ' AND ' + Name + '_KOD IS NOT NULL AND ' + Name + '_KOD <> '''' ' +
        'ORDER BY ' + Name + '_KOD',Name + '_ID',Name + '_KOD');
    Comp.ItemIndex := Comp.Items.IndexOf(S);
    if Comp.ItemIndex < 0 then Comp.ItemIndex := Comp.Items.IndexOfObject(TObject(0));
  end;
end;

procedure TfmPersonForm.dxpDelayButtonClick(Sender: TObject);
var S: String;
begin
  EditBaseLstModal(32);//KDELAY
  S := dxpDelay.Text;
  LoadStrings(dxpDelay.Items,false,'SELECT ID, DelayName FROM KDELAY ORDER BY DelayName','ID','DelayName');
  dxpDelay.ItemIndex := Max(dxpDelay.Items.IndexOf(S),0);
end;

procedure TfmPersonForm.dxpOVKButtonClick(Sender: TObject);
var S: String;
  dxp: TdxMRUEdit;
begin
  dxp := Sender as TdxMRUEdit;
  EditBaseLstModal(1);//KOVK
  S := dxp.Text;
  LoadStrings(dxp.Items,false,'SELECT * FROM KOVK ORDER BY OVK_NAME','OVK_ID','OVK_NAME');
  dxp.ItemIndex := Max(dxp.Items.IndexOf(S),0);
end;

procedure TfmPersonForm.dxtAssignEdited(Sender: TObject; Node: TdxTreeListNode);
begin
  if (Node.Values[0] = NULL) or (Node.Values[0] = '') then Node.Values[0] := Date;  
end;

procedure TfmPersonForm.dxtStudyHistoryEdited(Sender: TObject;
  Node: TdxTreeListNode);
begin
  rbAspirantClick(nil);
end;

end.


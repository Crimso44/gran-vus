unit fPersLst;

interface

uses
  ColumnCustomize,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin,
  dxBar, Db, ADODB, Menus, dxDBTLCl, dxGrClms, dxExEdtr, Variants, dMain,
  StdCtrls, cxClasses, dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter,
  System.Actions;

type
  TfmPersonList = class(TForm)
    dbgData: TdxDBGrid;
    ActionList1: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDel: TAction;
    actFiltr: TAction;
    dxBarManager1: TdxBarManager;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
    qrData: TADOQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    qrDataFIO: TStringField;
    qrDataFLD_A: TStringField;
    qrDataFLD_B: TStringField;
    dbgDataColumnNUMB_T2: TdxDBGridColumn;
    dbgDataColumn3: TdxDBGridColumn;
    dbgDataColumnFIO: TdxDBGridColumn;
    dbgDataColumnW_DBEG: TdxDBGridDateColumn;
    dbgDataColumn6: TdxDBGridColumn;
    dbgDataDEP_NAME: TdxDBGridColumn;
    dbgDataBIRTHDAY: TdxDBGridDateColumn;
    dbgDataColumnFLD_A: TdxDBGridColumn;
    dbgDataColumnFLD_B: TdxDBGridColumn;
    dbgDataColumnW_DEND: TdxDBGridDateColumn;
    dbgDataColumnWDISCL: TdxDBGridColumn;
    actRefresh: TAction;
    qrReserv: TADOQuery;
    dbgDataIS_BAD: TdxDBGridMaskColumn;
    qrDataPERS_ID: TIntegerField;
    qrDataORG_ID: TIntegerField;
    qrDataFAM: TWideStringField;
    qrDataIM: TWideStringField;
    qrDataOTCH: TWideStringField;
    qrDataMALE: TSmallintField;
    qrDataBIRTHDAY: TDateTimeField;
    qrDataBIRTHPLACE: TWideStringField;
    qrDataOKATO: TWideStringField;
    qrDataNAT_ID: TIntegerField;
    qrDataPSP_SER: TWideStringField;
    qrDataPSP_NUM: TWideStringField;
    qrDataPSP_PLACE: TWideStringField;
    qrDataPSP_DATE: TDateTimeField;
    qrDataINN: TWideStringField;
    qrDataSTRAH: TWideStringField;
    qrDataFST_ID: TIntegerField;
    qrDataED_ID: TIntegerField;
    qrDataSC_ID: TIntegerField;
    qrDataIS_WAR: TSmallintField;
    qrDataCPROF_ID: TIntegerField;
    qrDataCSOST: TSmallintField;
    qrDataWRNG_ID: TIntegerField;
    qrDataWSOST_ID: TIntegerField;
    qrDataCAT_ZAP: TSmallintField;
    qrDataVUS: TWideStringField;
    qrDataWCAT: TWideStringField;
    qrDataOVK_ID: TIntegerField;
    qrDataWUCHET1: TWideStringField;
    qrDataWUCHET2: TWideStringField;
    qrDataWDISCL: TWideStringField;
    qrDataTAB_NUMB: TWideStringField;
    qrDataDOG_NUMB: TWideStringField;
    qrDataDOG_DATE: TDateTimeField;
    qrDataIS_RAB: TSmallintField;
    qrDataPROF1: TWideStringField;
    qrDataOKPDTR1: TWideStringField;
    qrDataPROF2: TWideStringField;
    qrDataOKPDTR2: TWideStringField;
    qrDataCONFDATE: TDateTimeField;
    qrDataW_DBEG: TDateTimeField;
    qrDataW_DEND: TDateTimeField;
    qrDataD_OVK: TDateTimeField;
    qrDataD_WBIL: TDateTimeField;
    qrDataDep_name: TWideStringField;
    qrDataWRange: TWideStringField;
    actExcel: TAction;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    actStoreSet: TAction;
    actClearSet: TAction;
    dxBarButton7: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    qrDataNUMB_T2: TIntegerField;
    qrDataReserved: TIntegerField;
    qrDataWartime: TIntegerField;
    qrDataDefVUS: TIntegerField;
    qrDataCommand300: TIntegerField;
    qrDataEOARMY_DATE: TWideStringField;
    qrDataDefPost: TIntegerField;
    qrDataIS_BAD: TIntegerField;
    actWhyIsBad: TAction;
    N9: TMenuItem;
    N10: TMenuItem;
    dxBarButton10: TdxBarButton;
    dbgDataReserved: TdxDBGridColumn;
    qrDataMainWork: TIntegerField;
    qrDataPermanentWork: TIntegerField;
    DataSQL: TMemo;
    qrDataPOST_NAME: TStringField;
    qrDataSpecialWUchet1: TIntegerField;
    qrDataW_EndCount: TIntegerField;
    qrDataChe: TIntegerField;
    dbgDataTooOld: TdxDBGridColumn;
    qrDataWID: TStringField;
    qrDataWBser: TStringField;
    qrDataWBNum: TStringField;
    qrDataTooOld: TIntegerField;
    dbgDataColumnIS_WAR: TdxDBGridColumn;
    dbgDataColumnOUT_ORD_NUMB: TdxDBGridColumn;
    qrDataOUT_DATE: TDateTimeField;
    qrDataOUT_ORD_NUMB: TStringField;
    dbgDataColumnOUT_DATE: TdxDBGridDateColumn;
    dbgDataColumnPOST_NAME: TdxDBGridColumn;
    dbgDataEndAkadem_date: TdxDBGridDateColumn;
    qrDataEndAkadem_date: TDateField;
    qrDataRealEndAkadem_date: TDateField;
    dbgDataRealEndAkadem_date: TdxDBGridDateColumn;
    qrDataDismissal_Date: TDateField;
    dbgDataColumnDismissal_Date: TdxDBGridDateColumn;
    qrDataBeginWork_Date: TDateField;
    qrDataBeginStudy_Date: TDateField;
    dbgDataColumnBeginWork_Date: TdxDBGridDateColumn;
    dbgDataColumnBeginStudy_Date: TdxDBGridDateColumn;
    qrDataPHONEMOB: TStringField;
    qrDataPHONEDOM: TStringField;
    qrDataADDRPASS: TStringField;
    qrDataADDRREAL: TStringField;
    qrDataMobFlag: TStringField;
    dbgDataNum: TdxDBGridColumn;
    dbgDataWBSer: TdxDBGridMaskColumn;
    dbgDataWBNum: TdxDBGridMaskColumn;
    dbgDataWUCHET1: TdxDBGridColumn;
    dbgDataTAB_NUMB: TdxDBGridColumn;
    dxBarButton11: TdxBarButton;
    dbgDataColumn34: TdxDBGridColumn;
    dbgDataColumn35: TdxDBGridColumn;
    dbgDataColumn36: TdxDBGridColumn;
    dbgDataColumn37: TdxDBGridColumn;
    dbgDataColumn38: TdxDBGridColumn;
    dbgDataColumn39: TdxDBGridColumn;
    dbgDataColumn40: TdxDBGridColumn;
    qrDataOUT_ORD_DATE: TDateTimeField;
    qrDataWUCHET2_date: TDateTimeField;
    qrDataDocument: TIntegerField;
    qrDataBranch: TIntegerField;
    qrDataIsAspirant: TIntegerField;
    qrDataStudyForm: TIntegerField;
    qrDataStudyEnd_date: TDateTimeField;
    qrDataOrderAkadem: TWideStringField;
    qrDataOrderAkadem_date: TDateTimeField;
    qrDataReasonAkadem: TWideStringField;
    qrDataBeginAkadem_date: TDateTimeField;
    qrDataMedResult_date: TDateTimeField;
    qrDataMedResult: TIntegerField;
    qrDataVKStatus: TIntegerField;
    qrDataBeginWar_date: TDateTimeField;
    qrDataEndWar_date: TDateTimeField;
    qrDataRealEndWar_date: TDateTimeField;
    qrDataReasonEndWar: TWideStringField;
    qrDataOrderDismissal: TWideStringField;
    qrDataOrderDismissal_date: TDateTimeField;
    qrDataReasonDismissal: TWideStringField;
    qrDataDisserName: TWideStringField;
    qrDataDegree_ID: TIntegerField;
    qrDataGuideDegree_ID: TIntegerField;
    qrDataFIOGuide: TWideStringField;
    qrDataDefend_date: TDateTimeField;
    qrDataRealDefend_date: TDateTimeField;
    qrDataContractEnd: TWideStringField;
    qrDataKval_Id: TIntegerField;
    qrDataDelay_ID: TIntegerField;
    qrDataDelayStart_date: TDateTimeField;
    qrDataDelayEnd_date: TDateTimeField;
    qrDataHealth: TWideStringField;
    qrDataHealthDocNo: TWideStringField;
    qrDataHealthDoc_date: TDateTimeField;
    qrDataWarfare: TWideStringField;
    qrDataEOARMY_YEAR: TWideStringField;
    qrDataINDADDRPASS: TIntegerField;
    qrDataINDADDRREAL: TIntegerField;
    dbgDataColumn41: TdxDBGridColumn;
    dbgDataColumn42: TdxDBGridColumn;
    qrDataPHONEWRK: TWideStringField;
    dbgDataColumn43: TdxDBGridColumn;
    dbgDataColumn44: TdxDBGridColumn;
    dbgDataColumn45: TdxDBGridColumn;
    qrDataFST_NAME: TWideStringField;
    dbgDataColumn46: TdxDBGridColumn;
    qrDataED_NAME: TWideStringField;
    dbgDataColumn47: TdxDBGridColumn;
    dbgDataColumn48: TdxDBGridColumn;
    qrDataCPROF_NAME: TWideStringField;
    dbgDataColumn49: TdxDBGridColumn;
    qrDataBranchName: TWideStringField;
    dbgDataColumn50: TdxDBGridColumn;
    dbgDataColumn51: TdxDBGridColumn;
    dbgDataColumn52: TdxDBGridColumn;
    dbgDataColumn53: TdxDBGridColumn;
    dbgDataColumn54: TdxDBGridColumn;
    qrDataOVK_NAME: TWideStringField;
    dbgDataColumn55: TdxDBGridColumn;
    dbgDataColumn56: TdxDBGridColumn;
    qrDataDelayName: TWideStringField;
    dbgDataColumn57: TdxDBGridColumn;
    dbgDataColumn58: TdxDBGridColumn;
    dbgDataColumn59: TdxDBGridColumn;
    dbgDataColumn60: TdxDBGridColumn;
    dbgDataColumn61: TdxDBGridColumn;
    dbgDataColumn62: TdxDBGridColumn;
    dbgDataColumn63: TdxDBGridColumn;
    dbgDataColumn64: TdxDBGridColumn;
    qrDataGos: TWideStringField;
    dbgDataColumn65: TdxDBGridColumn;
    qrDataPostStudy: TWideStringField;
    dbgDataColumn66: TdxDBGridColumn;
    dbgDataColumn67: TdxDBGridColumn;
    qrDataDog_NumbStudy: TWideStringField;
    qrDataDog_DateStudy: TDateTimeField;
    qrDataDog_NumbWork: TWideStringField;
    qrDataDog_DateWork: TDateTimeField;
    dbgDataColumn68: TdxDBGridColumn;
    dbgDataColumn69: TdxDBGridColumn;
    qrDataNapr: TWideStringField;
    dbgDataColumn70: TdxDBGridColumn;
    dbgDataColumn71: TdxDBGridColumn;
    dbgDataColumn72: TdxDBGridColumn;
    dbgDataColumn73: TdxDBGridColumn;
    dbgDataColumn74: TdxDBGridColumn;
    qrDataMedResultText: TWideStringField;
    dbgDataColumn75: TdxDBGridColumn;
    dbgDataColumn76: TdxDBGridColumn;
    dbgDataColumn77: TdxDBGridColumn;
    dbgDataColumn78: TdxDBGridColumn;
    dbgDataColumn79: TdxDBGridColumn;
    qrDataASOrder_In: TWideStringField;
    qrDataASDate_In: TDateTimeField;
    qrDataASOut_ORD_NUMB: TWideStringField;
    qrDataASOut_ORD_Date: TDateTimeField;
    qrDataASOut_Date: TDateTimeField;
    dbgDataColumn80: TdxDBGridColumn;
    qrDataASDep_Name: TWideStringField;
    qrDataASPost_Name: TWideStringField;
    dbgDataColumn81: TdxDBGridColumn;
    dbgDataColumn84: TdxDBGridColumn;
    qrDataASIn_Date: TDateTimeField;
    dbgDataColumn85: TdxDBGridColumn;
    dbgDataColumn86: TdxDBGridColumn;
    dbgDataColumn87: TdxDBGridColumn;
    dbgDataColumn88: TdxDBGridColumn;
    dbgDataColumn89: TdxDBGridColumn;
    qrDataIS_ASF: TBooleanField;
    dbgDataIS_ASF: TdxDBGridCheckColumn;
    qrDataAppLast: TIntegerField;
    qrDataAppLastAll: TIntegerField;
    qrDataAppLastStudy: TIntegerField;
    qrDataAppFirst: TIntegerField;
    qrDataAppFirstStudy: TIntegerField;
    qrDataASAppLast: TIntegerField;
    qrDataASAppFirst: TIntegerField;
    qrDataMed_Where: TWideStringField;
    qrDataMed_Date: TDateTimeField;
    qrDataMed_Result: TWideStringField;
    qrDataPsy_Where: TWideStringField;
    qrDataPsy_Date: TDateTimeField;
    qrDataPsy_Result: TWideStringField;
    qrDataAsf_Sport: TWideStringField;
    qrDataASFName: TWideStringField;
    dbgDataASFName: TdxDBGridColumn;
    qrDataWUCHET2_IsWork: TIntegerField;
    qrDataDefPost_Post: TIntegerField;
    qrDataDefPost_WRange: TIntegerField;
    qrDataDefPost_WSost: TIntegerField;
    dbgDataColumn90: TdxDBGridColumn;
    qrDataWSost_Name: TStringField;
    qrDataWUch1: TStringField;
    qrDataMob_CardDate: TDateField;
    qrDataMob_MissReason: TStringField;
    qrDataWUch2: TStringField;
    dbgDataWUch1: TdxDBGridMaskColumn;
    dbgDataMob_CardDate: TdxDBGridDateColumn;
    dbgDataMob_MissReason: TdxDBGridMaskColumn;
    dbgDataWUch2: TdxDBGridMaskColumn;
    dbgDataWUCHET2_date: TdxDBGridDateColumn;
    qrDataWRng_Date: TDateTimeField;
    dbgDataWrng_Date: TdxDBGridColumn;
    dbgDataColumn97: TdxDBGridColumn;
    dbgDataColumn98: TdxDBGridColumn;
    qrDataPersonMale: TStringField;
    dbgDataPersonMale: TdxDBGridColumn;
    dbgDataBirthPlace: TdxDBGridColumn;
    qrDataKUZ_Name1: TStringField;
    qrDataKObrDoc_Name1: TStringField;
    qrDataKVal_Name1: TStringField;
    qrDataNapr_Name1: TStringField;
    qrDataDiplom1: TStringField;
    qrDataDiplom_Ser1: TStringField;
    qrDataEnd_Date1: TStringField;
    qrDataKUZ_Name2: TStringField;
    qrDataKObrDoc_Name2: TStringField;
    qrDataKVal_Name2: TStringField;
    qrDataNapr_Name2: TStringField;
    qrDataDiplom2: TStringField;
    qrDataDiplom_Ser2: TStringField;
    qrDataEnd_Date2: TStringField;
    dbgDataKUZ_Name1: TdxDBGridMaskColumn;
    dbgDataKObrDoc_Name1: TdxDBGridMaskColumn;
    dbgDataKVal_Name1: TdxDBGridMaskColumn;
    dbgDataNapr_Name1: TdxDBGridMaskColumn;
    dbgDataDiplom1: TdxDBGridMaskColumn;
    dbgDataDiplom_Ser1: TdxDBGridMaskColumn;
    dbgDataEnd_Date1: TdxDBGridMaskColumn;
    dbgDataKUZ_Name2: TdxDBGridMaskColumn;
    dbgDataKObrDoc_Name2: TdxDBGridMaskColumn;
    dbgDataKVal_Name2: TdxDBGridMaskColumn;
    dbgDataNapr_Name2: TdxDBGridMaskColumn;
    dbgDataDiplom2: TdxDBGridMaskColumn;
    dbgDataDiplom_Ser2: TdxDBGridMaskColumn;
    dbgDataEnd_Date2: TdxDBGridMaskColumn;
    qrDataDep_Full_Name: TStringField;
    qrDataKOKPDTR_Code: TStringField;
    qrDataKOKPDTR_Name: TStringField;
    qrDataWTP_Name: TStringField;
    qrDataWCH_Name: TStringField;
    dbgDataDep_Full_Name: TdxDBGridColumn;
    dbgDataKOKPDTR_Code: TdxDBGridColumn;
    dbgDataKOKPDTR_Name: TdxDBGridColumn;
    dbgDataWTP_Name: TdxDBGridColumn;
    dbgDataWCH_Name: TdxDBGridColumn;
    dbgDataComments: TdxDBGridMaskColumn;
    qrDataComments: TStringField;
    qrDataAssignText: TStringField;
    dbgDataColumn186: TdxDBGridMaskColumn;
    dbgDataColumn187: TdxDBGridMaskColumn;
    dbgDataOUT_DATE: TdxDBGridDateColumn;
    dbgDataOUT_ORD_NUMB: TdxDBGridMaskColumn;
    dbgDataAssignText: TdxDBGridMaskColumn;
    dbgDataADDR_DATE_END: TdxDBGridDateColumn;
    qrDataADDR_DATE_END: TDateTimeField;
    dbgDataPers_ID: TdxDBGridColumn;
    qrDataIn_Ord_NumbStudy: TStringField;
    qrDataIn_Ord_DateStudy: TDateField;
    qrDataIn_DateStudy: TDateField;
    dbgDataIn_Ord_NumbStudy: TdxDBGridColumn;
    dbgDataIn_Ord_DateStudy: TdxDBGridDateColumn;
    dbgDataIn_DateStudy: TdxDBGridDateColumn;
    qrDataIsStudent: TIntegerField;
    qrDataStudWRangeOk: TIntegerField;
    qrDataIsIgnore: TBooleanField;
    qrDataProbation_Date: TDateField;
    qrDataDriver: TIntegerField;
    qrDataMobContract: TDateTimeField;
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actFiltrExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrDataCalcFields(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure dbgDataCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure actRefreshExecute(Sender: TObject);
    procedure actExcelExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actStoreSetExecute(Sender: TObject);
    procedure actClearSetExecute(Sender: TObject);
    procedure actWhyIsBadExecute(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure dbgDataNumGetText(Sender: TObject; ANode: TdxTreeListNode;
      var AText: string);
    procedure dbgDataColumnSorting(Sender: TObject; Column: TdxDBTreeListColumn;
      var Allow: Boolean);
    procedure dxBarButton11Click(Sender: TObject);
    procedure dbgDataCompare(Sender: TObject; Node1, Node2: TdxTreeListNode;
      var Compare: Integer);
  private
    { Private declarations }
    FMaximized: Boolean;
    procedure ReOpenList;
    function GeneralSQLSelect(FilterFields: String): String;
    function StrToDateX(s: String): TDateTime;
  public
    { Public declarations }
    FTempFile: string;
    FFilterSQL, FFlds: String;
    procedure SetFiltr(SQL, FilterFields: String);
  end;


  procedure ShowPersonList;

implementation

uses fPersonCard, msg, misc, MD5, fFltMgr, fRegister, DateUtils, BirthDay, fMain;

{$R *.DFM}

function TfmPersonList.GeneralSQLSelect(FilterFields: String): String;
var
  i, j: Integer;
  flds: TStringList;
  s, ss: String;
  found: Boolean;
  band: TdxTreeListBand;
  dataLines: TMemo;
begin

  // Составляем список видимых полей
  flds := TStringList.Create;
  i := Pos(';', FilterFields);
  while i > 0 do begin
    flds.Add(UpperCase(Copy(FilterFields, 1, i-1)));
    FilterFields :=Copy(FilterFields, i+1, MaxInt);
    i := Pos(';', FilterFields);
  end;
  //Заодно прячем Bands в которых нет видимых полей
  for i := 0 to dbgData.Bands.Count - 1 do
    dbgData.Bands[i].Visible := False;

  for i := 0 to dbgData.ColumnCount - 1 do
    if dbgData.Columns[i].Visible and (dbgData.Columns[i].FieldName <> '') then begin
      flds.Add(UpperCase(dbgData.Columns[i].FieldName));
      dbgData.Bands[dbgData.Columns[i].BandIndex].Visible := True;
    end;

  dataLines := DataSQL;

  // Удаляем ненужные строки из запроса
  Result := '';
  for i := 0 to dataLines.Lines.Count - 1 do begin
    s := dataLines.Lines[i];
    if Pos('--', s) > 0 then begin // если строка помечена
      ss := UpperCase(s);
      found := False;
      for j := 0 to flds.Count - 1 do
        if Pos('--'+flds[j], ss) > 0 then begin
          found := True;
          Break;
        end;
      if found then //поле видимо
        Result := Result + Copy(s, 1, Pos('--', s)-1) + #13
      else if Pos('!!!', s) > 0 then // в этой строке join
        Result := Result + ')'#13
      else if Pos('???', s) > 0 then // в этой строке where
        Result := Result + #13
      else begin // в этой строке поле
        ss := Copy(s, Pos('--', s)+2);
        // Определяем тип поля
        if Pos('!!I', ss) > 0 then begin
          Result := Result + '0 as ' + Copy(ss, 1, Pos('!!I', ss)-2) + ','#13;
        end else if Pos('!!D', ss) > 0 then begin
          Result := Result + 'Date() as ' + Copy(ss, 1, Pos('!!D', ss)-2) + ','#13;
        end else
          Result := Result + ''' '' as ' + ss + ','#13;
      end;
    end else
      Result := Result + s + #13;
  end;

  Result := ReplaceFullAges(Result);

  flds.Free;
end;

function GeneralSQLOrderBy: String;
begin
  Result := 'ORDER BY '+
    'SGN(LEN([Person].WUchet2)) DESC, '+
    'KWRangeX.State DESC, '+
    '[KDepart].'+iifStr(dmMain.isAbcSort, 'Dep_Name', 'KDEPART_Num')+', '+
    '[Person].Fam, '+
    '[Person].Im, '+
    '[Person].Otch';
end;

procedure ShowPersonList;
var fmPersonList: TfmPersonList;
begin
  Application.CreateForm(TfmPersonList,fmPersonList);
  if fmMain.MainScale <> 100 then
    fmPersonList.ScaleBy(fmMain.MainScale, 100);
  if IsIconic(fmPersonList.Handle) then ShowWindow(fmPersonList.Handle,SW_RESTORE);
  fmPersonList.BringToFront;
end;

procedure TfmPersonList.actAddExecute(Sender: TObject);
begin
  try
    {$IFNDEF BackDoors}
    if IsDemoVersion then
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select count(*) from Person';
      Open;
      if Fields[0].AsInteger>=10 then
        raise Exception.Create(EmptyStr);
    finally
      Free;
    end;
    {$ENDIF}
    ShowPersonCard(0,Self);
  except
    ShowInfo(
      'Система работает в демо-режиме с ограниченным функционированием!'#13+
      'Для активации продукта вызовите команду "Активация продукта..." из пункта "?" главного меню...'
      );
  end;
end;

procedure TfmPersonList.actEditExecute(Sender: TObject);
begin
  if qrData.IsEmpty then Beep
  else
    ShowPersonCard(qrData.FieldByName('PERS_ID').AsInteger,Self);
end;

procedure TfmPersonList.actDelExecute(Sender: TObject);
var
   i: Integer;

  procedure DelFromTable(tbl_name: string; id: String);
  begin
    with TADOQuery.Create(Self) do begin
      Connection := dmMain.dbMain;
      SQL.Text := 'DELETE FROM '+tbl_name+' WHERE PERS_ID='+id;
      ExecSQL;
      Free;
    end;
  end;
begin
  if qrData.IsEmpty then Beep
  else
    if dbgData.SelectedCount = 0 then Beep
    else if dbgData.SelectedCount = 1 then begin
      if Confirm('Удалить личную карточку выбранного сотрудника?') then begin
        try
          dmMain.dbMain.BeginTrans;
        except
        end;
        try
          DelFromTable('ADDR', qrData.FieldByName('PERS_ID').AsString);
          DelFromTable('PHONES', qrData.FieldByName('PERS_ID').AsString);
          DelFromTable('LANGS', qrData.FieldByName('PERS_ID').AsString);
          DelFromTable('FAMILY', qrData.FieldByName('PERS_ID').AsString);
          DelFromTable('EDUC', qrData.FieldByName('PERS_ID').AsString);
          DelFromTable('Appointment', qrData.FieldByName('PERS_ID').AsString);
          DelFromTable('Assign', qrData.FieldByName('PERS_ID').AsString);
          DelFromTable('PersonChanges', qrData.FieldByName('PERS_ID').AsString);
          DelFromTable('PERSON', qrData.FieldByName('PERS_ID').AsString);
          with qrData do begin Close; Open; end;
          if dmMain.dbMain.InTransaction then dmMain.dbMain.CommitTrans;
        except
          if dmMain.dbMain.InTransaction then dmMain.dbMain.RollbackTrans;
          ShowErr('Ошибка при удалении личной карточки сотрудника!!');
        end;
      end;
    end else begin
      if Confirm('Удалить личные карточки '+IntToStr(dbgData.SelectedCount)+' выбранных сотрудников?') then begin
        try
          dmMain.dbMain.BeginTrans;
        except
        end;
        try
          for i := 0 to dbgData.SelectedCount - 1 do begin
            DelFromTable('ADDR', dbgData.SelectedNodes[i].Strings[dbgDataPers_ID.Index]);
            DelFromTable('PHONES', dbgData.SelectedNodes[i].Strings[dbgDataPers_ID.Index]);
            DelFromTable('LANGS', dbgData.SelectedNodes[i].Strings[dbgDataPers_ID.Index]);
            DelFromTable('FAMILY', dbgData.SelectedNodes[i].Strings[dbgDataPers_ID.Index]);
            DelFromTable('EDUC', dbgData.SelectedNodes[i].Strings[dbgDataPers_ID.Index]);
            DelFromTable('Appointment', dbgData.SelectedNodes[i].Strings[dbgDataPers_ID.Index]);
            DelFromTable('Assign', dbgData.SelectedNodes[i].Strings[dbgDataPers_ID.Index]);
            DelFromTable('PersonChanges', dbgData.SelectedNodes[i].Strings[dbgDataPers_ID.Index]);
            DelFromTable('PERSON', dbgData.SelectedNodes[i].Strings[dbgDataPers_ID.Index]);
          end;
          with qrData do begin Close; Open; end;
          if dmMain.dbMain.InTransaction then dmMain.dbMain.CommitTrans;
        except
          if dmMain.dbMain.InTransaction then dmMain.dbMain.RollbackTrans;
          ShowErr('Ошибка при удалении личной карточки сотрудника!!');
        end;
      end;
    end;
end;

procedure TfmPersonList.actFiltrExecute(Sender: TObject);
var SQL, flds: string; NewForm: TForm; AMax: Boolean;
begin
  AMax := FMaximized;//if new window
  SQL := ''; //GeneralSQLSelect;
  if GetSQLText(NewForm, ffPersons, SQL, flds, FTempFile) then SetFiltr(SQL, flds);
  if Assigned(NewForm) then begin
    BringToFront;
    NewForm.BringToFront;
    FMaximized := AMax;
  end;
end;

procedure TfmPersonList.SetFiltr(SQL, FilterFields: String);
var
  sl: TStringList;
begin
  FFilterSQL := SQL;
  FFlds := FilterFields;
  qrData.Close;
  //!!!
  (*sl := TStringList.Create();
  sl.Text := GeneralSQLSelect(FilterFields)+FFilterSQL+#13+GeneralSQLOrderBy;
  sl.SaveToFile('c:\sql.sql');
  sl.Free;*)
  //!!!
  qrData.SQL.Text := GeneralSQLSelect(FilterFields)+FFilterSQL+#13+GeneralSQLOrderBy;
  try
    qrData.Open;
  except on E: Exception do begin
    ShowMessage(E.Message + #13 + qrData.SQL.Text);
  end end;
end;


function TfmPersonList.StrToDateX(s: String): TDateTime;
var
  dd, mm, yy: Word;
begin
  dd := 7; mm := 11; yy := 1917;
  if s <> '' then begin
    dd := StrToInt(Copy(s, 1, 2));
    mm := StrToInt(Copy(s, 4, 2));
    yy := StrToInt(Copy(s, 7, 4));
  end;
  Result := EncodeDate(yy, mm, dd);
end;

procedure TfmPersonList.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmPersonList.qrDataCalcFields(DataSet: TDataSet);
begin
  with qrData do begin
    qrDataFIO.AsString :=
      qrDataFAM.AsString + ' ' +
      Copy(qrDataIM.AsString,1,1) + '. ' +
      Copy(qrDataOTCH.AsString,1,1) + '. ';
    qrDataFLD_A.Value := '0';
    qrDataFLD_B.Value := '0';
    if (qrDataIS_WAR.AsInteger<>0) and
       (qrDataWDISCL.AsString='') and
       (qrDataOUT_DATE.IsNull or (qrDataOUT_ORD_NUMB.AsString='')) and
       (qrDataW_DEND.IsNull or (qrDataW_DEND.AsDateTime>=Now))
    then begin
      if FieldByName('WUCHET2_IsWork').AsInteger = 1
        then qrDataFLD_B.Value := '1'
        else qrDataFLD_A.Value := '1';
    end;
    qrDataMobFlag.Value := '0';
    if (qrDataIS_WAR.AsInteger<>0) and
       (qrDataWDISCL.AsString='') and
       (qrDataOUT_DATE.IsNull or (qrDataOUT_ORD_NUMB.AsString=''))
    then begin
      if Trim(FieldByName('WUCHET1').AsString)<>EmptyStr
        then qrDataMobFlag.Value := '1';
    end;

    {qrDataEOARMY_DATEX.Clear;
    try
      if Length(qrDataEOARMY_DATE.AsString)=4 then
        qrDataEOARMY_DATEX.AsDateTime := StrToDateX('1.1.'+qrDataEOARMY_DATE.AsString)
      else if Length(qrDataEOARMY_DATE.AsString)=10 then
        qrDataEOARMY_DATEX.AsDateTime := StrToDateX(qrDataEOARMY_DATE.AsString);
    except
      qrDataEOARMY_DATEX.AsDateTime := StrToDateX('7.11.1917');
    end;}

  end;
end;

procedure TfmPersonList.FormCreate(Sender: TObject);
begin
  FMaximized := True;
  FTempFile := ExtractFilePath(Application.ExeName)+'~'+IntToStr(GetTickCount)+'.flt';
  FFilterSQL := '';
  FFlds := '';
  qrData.SQL.Text := GeneralSQLSelect('')+#13+GeneralSQLOrderBy;
  //ShowMessage(qrData.SQL.Text);
  ReOpenList;
end;

procedure TfmPersonList.ReOpenList;
begin
  try //!!!
    //qrData.SQL.SaveToFile('c:\sql.sql');
    qrData.Open;
  except on E: Exception do begin
    ShowMessage(E.Message (*+ #13 + qrData.SQL.Text*));
  end end;
end;

procedure TfmPersonList.dbgDataColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := Column <> dbgDataNum;
end;

procedure TfmPersonList.dbgDataCompare(Sender: TObject; Node1,
  Node2: TdxTreeListNode; var Compare: Integer);
var
  i: Integer;
  col: TdxDBTreeListColumn;
  Val1, Val2, v: Integer;
  s1, s2: String;
  b1, b2: Boolean;
  d1, d2: TDateTime;

  function GetNumber(s: String): String;
  var
    i, i0: Integer;
  begin
    Result := s;
    i := 1;
    while (i <= Length(s)) and (Pos(s[i], '0123456789') = 0) do Inc(i);
    if i <= Length(s) then begin
      while (i <= Length(s)) and (Pos(s[i], '0123456789') <> 0) do Inc(i);
      Result := Copy(s, 1, i0-1) + StringOfChar('0', 10-(i-i0)) + Copy(s, i0, MaxInt);
    end;
  end;

  function CompareColumn(col: TdxDBTreeListColumn): Integer;
  var
    ii: Integer;
  begin
    Result := 0;
    ii := 1;
    if col.Sorted = csDown then ii := -1;
    if col.FieldName <> '' then begin
      case qrData.FieldByName(col.FieldName).DataType of
        ftInteger, ftSmallint: begin
            Val(Node1.Strings[col.Index], Val1, v);
            Val(Node2.Strings[col.Index], Val2, v);
            if      Val1 > Val2 then Result :=  1
            else if Val1 < Val2 then Result := -1
            else                     Result :=  0;
          end;
        ftDate, ftDateTime: begin
            if Node1.Strings[col.Index] = '' then d1 := StrToDate('1.1.1917')
                                             else d1 := Node1.Values[col.Index];
            if Node2.Strings[col.Index] = '' then d2 := StrToDate('1.1.1917')
                                             else d2 := Node2.Values[col.Index];
            if      d1 > d2 then Result :=  1
            else if d1 < d2 then Result := -1
            else                 Result :=  0;
          end;
        ftString, ftWideString: begin
            s1 := Node1.Strings[col.Index];
            s2 := Node2.Strings[col.Index];
            if col = dbgDataTab_Numb then begin
              s1 := GetNumber(s1);
              s2 := GetNumber(s2);
            end;
            if      s1 > s2 then Result :=  1
            else if s1 < s2 then Result := -1
            else                 Result :=  0;
          end;
        ftBoolean: begin
            s1 := AnsiUpperCase(Node1.Strings[col.Index]);
            s2 := AnsiUpperCase(Node2.Strings[col.Index]);
            b1 := (Pos('ИСТИНА',s1)>0) or (Pos('TRUE',s1)>0) or (Pos('1',s1)>0);
            b2 := (Pos('ИСТИНА',s2)>0) or (Pos('TRUE',s2)>0) or (Pos('1',s2)>0);
            if      b1 > b2 then Result :=  1
            else if b1 < b2 then Result := -1
            else                 Result :=  0;
          end;
        //else ShowMessage('Sort: '+IntToStr(Integer(qrData.FieldByName(col.FieldName).DataType)));
      end;
      Result := ii * Result;
    end;
  end;

begin
  Compare := 0;
  for i := 0 to dbgData.SortedColumnCount - 1 do begin
    col := dbgData.SortedColumns[i];
    Compare := CompareColumn(col);
    if Compare <> 0 then Exit;
  end;
end;

procedure TfmPersonList.dbgDataCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
const
  scTooOld         = $FFDDDD; //Blue
  scBadReserved    = $DDDDFF; //Red
  scBadNotReserved = $DDFFDD; //Green
  scFired          = $DDFFFF; //Yellow
  scNotWar         = $DDDDDD; //Gray
  scAkadem         = $6666FF; //Dark Red
  scSpec           = $FFFFDD; // Magenta

  procedure SetColor(const C: TColor);
  begin
    AColor := C;
  end;
begin

  if (ANode.Strings[dbgDataWUchet1.Index]<>'')
  then SetColor(scSpec);

  if (ANode.Strings[dbgDataColumnDismissal_Date.Index]<>'')and
     (ANode.Values[dbgDataColumnDismissal_Date.Index]<=Now)
  then SetColor(scFired)
  else
  if (ANode.Strings[dbgDataColumnOUT_DATE.Index]<>'')and
     (ANode.Values[dbgDataColumnOUT_DATE.Index]<=Now)
  then SetColor(scFired)
  else
  if (ANode.Strings[dbgDataColumnIS_WAR.Index]<>'1') or
     ((ANode.Values[dbgDataColumnW_DEND.Index] <> NULL) and
     (ANode.Values[dbgDataColumnW_DEND.Index] <= Now))
//     (ANode.Strings[dbgDataColumnWDISCL.Index]<>'')
  then SetColor(scNotWar)
  else
  if (ANode.Strings[dbgDataTooOld.Index]<>'0') and
     ((ANode.Values[dbgDataColumnW_DEND.Index] = NULL) or
      (ANode.Values[dbgDataColumnW_DEND.Index] > Now))
  then SetColor(scTooOld)
  else
  if ANode.Strings[dbgDataIS_BAD.Index]<>'0'  then begin
    if ANode.Strings[dbgDataReserved.Index]<>'0'
      then SetColor(scBadReserved)
      else SetColor(scBadNotReserved);
  end
  else
  if (ANode.Strings[dbgDataEndAkadem_date.Index]<>'') and
     (ANode.Strings[dbgDataRealEndAkadem_date.Index]='') and
     (ANode.Values[dbgDataEndAkadem_date.Index] < Now + 7)
  then SetColor(scAkadem);

  if AFocused or ASelected then begin
    AFont.Style := AFont.Style + [fsBold];
    if AColor = clHighlight then
      AColor := clWhite - $224444
    else
      AColor := AColor - $224444;
  end;

  if (AColumn.Caption = 'Семейное положение') and (AText = 'Не состоит в браке') then
    AFont.Color := clRed
  else
    AFont.Color := clBlack;
end;

procedure TfmPersonList.dbgDataNumGetText(Sender: TObject;
  ANode: TdxTreeListNode; var AText: string);
begin
  AText := IntToStr(ANode.Index + 1);
end;

procedure TfmPersonList.dxBarButton11Click(Sender: TObject);
begin
  if ShowColumnCustomize(dbgData) = mrOK then begin
    qrData.Close;
    qrData.SQL.Text := GeneralSQLSelect(FFlds)+FFilterSQL+#13+GeneralSQLOrderBy;
    //!!!
    //qrData.SQL.SaveToFile('c:\sql.sql');
    //try
      qrData.Open;
    //except on E: Exception do begin
    //  ShowMessage(E.Message + #13 + qrData.SQL.Text);
    //end end;
  end;
end;

procedure TfmPersonList.actRefreshExecute(Sender: TObject);
var PERS_ID: Integer;
begin
  with qrData do begin
    if Active then PERS_ID := FieldByName('PERS_ID').AsInteger else PERS_ID := -1;
    Close; Open;
    if PERS_ID>-1 then Locate('PERS_ID', PERS_ID, []);
  end;
end;

procedure TfmPersonList.actExcelExecute(Sender: TObject);
begin
  dmMain.GridToExcel(dbgData,Caption,true,true);
end;

procedure TfmPersonList.FormDestroy(Sender: TObject);
begin
  DeleteFile(FTempFile);
end;

procedure TfmPersonList.actStoreSetExecute(Sender: TObject);
var k: Integer;
begin
  if Confirm('Сохранить текущий список(набор) для построения отчетности?') then
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'delete from [PERS_SET]';
      ExecSQL;
      k := qrData.RecNo;
      try
        qrData.First;
        SQL.Text := 'select * from [PERS_SET]';
        Open;
        while not qrData.EOF do begin
          Append;
          Fields[0].Value := qrData.FieldbyName('PERS_ID').Value;
          Post;
          qrData.Next;
        end;
      finally
        if not qrData.IsEmpty then
           qrData.RecNo := k;
      end;
    finally
      Free;
    end;
end;

procedure TfmPersonList.actClearSetExecute(Sender: TObject);
begin
  if Confirm('Очистить ранее заданный список(набор) для построения отчетности?') then
    with TADOQuery.Create(Self) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'delete from [PERS_SET]';
      ExecSQL;
    finally
      Free;
    end;
end;

procedure TfmPersonList.actWhyIsBadExecute(Sender: TObject);
var Msg: String;
begin
  if qrDataIS_BAD.AsInteger = 0 then begin
    Msg := 'Ошибок бронирования не выявлено.';
    if qrDataIS_WAR.AsInteger = 0                                   then Msg := Msg + ' Не военнообязанный.';
    if not qrDataW_DEND.IsNull and (qrDataW_DEND.AsDateTime<=Now) then Msg := Msg + ' Снят с учёта.';
    if qrDataWUchet1.AsString <> '' then Msg := Msg + ' Имеет Моб. предписание.'
  end
  else begin
    if qrDataReserved.AsInteger = 1 then begin
      if qrDataIsStudent.AsInteger = 1 then begin
        if qrDataStudWRangeOk.AsInteger = 0 then Msg := 'Забронирован, но воинское звание студента «подлежит призыву» или «допризывник».' else
        if qrDataDocument.AsInteger >= 2 then Msg := 'Забронирован, но воинский документ студента «справка уклониста» или «приписное свидетельство».' else
        if qrDataDefVUS.AsInteger = 1  then Msg := 'Забронирован, но ВУС входит в список дефицитных.' else
        if qrDataWUchet1.AsString <> ''  then Msg := 'Забронирован, но студент имеет мобилизационное предписание.' else
        if qrDataIsIgnore.AsBoolean  then Msg := 'Забронирован, но статус учащегося помечен как игнорируемый.' else
      end else begin
        if qrDataMainWork       .AsInteger = 0 then Msg := 'Забронирован, но работает по совместительству.' else
        if qrDataPermanentWork  .AsInteger = 0 then Msg := 'Забронирован, но работает временно.' else
        if qrDataWartime        .AsInteger = 0 then Msg := Format(
          'Забронирован, но должность "%s" в подразделении "%s" не задействована в '+
          'штатном расписании военного времени.',
          [qrDataPOST_NAME.AsString, qrDataDEP_NAME.AsString]) else
        if qrDataDefVUS         .AsInteger = 1 then Msg := 'Забронирован, но ВУС входит в список дефицитных.' else
        if qrDataCommand300     .AsInteger = 1 then Msg := 'Забронирован, но имеет моб. предписание по небронируемой команде.' else
        if qrDataSpecialWUchet1 .AsInteger = 1 then Msg := 'Забронирован, но имеет моб. предписание в спецформирование.' else
        if qrDataDocument       .AsInteger = 3 then Msg := 'Забронирован, но не подлежит бронированию как владелец справки уклониста.' else
        if not (qrDataProbation_Date.IsNull or (qrDataProbation_Date.AsDateTime < Date)) then Msg := 'Забронирован, но не завершил испытательный срок.' else
        if qrDataDriver.AsInteger = 1 then Msg := 'Забронирован, но не подлежит бронированию как водитель транспорта для поставки по мобилизации.' else
        if not (qrDataMobContract.IsNull or (qrDataMobContract.AsDateTime < Date)) then Msg := 'Забронирован, но не подлежит бронированию как заключивший контракт на пребывание в мобилизационном людском резерве.' else

        if qrDataDefPost        .AsInteger = 0 then begin
          Msg := 'Забронирован, но не подпадает ни под один пункт ПДП.';
          if qrDataDefPost_Post.AsInteger = 0 then
            Msg := Msg + #13#10'Для данной должности в ПДП бронирование не предусмотрено.';
          if qrDataDefPost_WRange.AsInteger = 0 then
            Msg := Msg + #13#10'Для данного воинского звания в ПДП бронирование не предусмотрено.';
          if qrDataDefPost_WSost.AsInteger = 0 then
            Msg := Msg + #13#10'Военнослужащие такого состава/профиля не фигурируют в ПДП.';
        end; {else
          Msg := 'Забронирован, но уволен из армии менее 5-ти лет назад и пребывает в запасе по I разряду.'}
      end;
    end
    else
      Msg := 'Не забронирован, но отвечает всем условиям бронирования.';
  end;
  if qrDataW_DEND.IsNull and (qrDataTooOld.AsInteger=1) then Msg := Msg+
    #13#10'Подлежит снятию с воинского учёта по возрасту.';
  if not qrDataOUT_DATE.IsNull and (qrDataOUT_DATE.AsDateTime<=Now) then Msg := Msg+
    #13#10'Уволен.';
  if not qrDataDismissal_Date.IsNull and (qrDataDismissal_Date.AsDateTime<=Now) then Msg := Msg+
    #13#10'Отчислен.';
  if (not qrDataEndAkadem_date.IsNull) and qrDataRealEndAkadem_date.IsNull then
    if qrDataEndAkadem_date.AsDateTime < Now + 7 then Msg := Msg +
      #13#10'До окончания академ. отпуска осталось менее 7 дней.';

  ShowMessage(Trim(qrDataFIO.AsString)+': '+Msg);
end;

procedure TfmPersonList.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  actAdd.Enabled := dmMain.rEdit;
  actDel.Enabled := dmMain.rEdit;
end;

procedure TfmPersonList.FormActivate(Sender: TObject);
var
  col: TdxDBGridColumn;
  i: Integer;
begin
  // см. камент  "не понимаю, какого хрена" в \DevExOld\ExpressQuantumTreeList 3\Sources\dxDBCtrl.pas
  (*for i := 0 to dbgData.ColumnCount - 1 do begin
    col := TdxDBGridColumn(dbgData.Columns[i]);
    col.GroupIndex := -1;
  end;*)
  if FMaximized then ShowWindow(handle, sw_ShowMaximized);
end;

procedure TfmPersonList.FormDeactivate(Sender: TObject);
begin
  FMaximized := IsZoomed(Handle);
end;

end.


unit fFOKVED;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, Menus, ActnList, dxTL, dxDBCtrl, dxDBGrid, dxCntner, ComCtrls,
  ToolWin, dxExEdtr, FrmKeep, Variants;

type
  TfmFOKVED = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    dxDBGrid: TdxDBGrid;
    NAMEColumn: TdxDBGridColumn;
    dsData: TDataSource;
    ActionList: TActionList;
    actGenerate: TAction;
    actPrint: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    qrData: TADOQuery;
    actClear: TAction;
    actCreate: TAction;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    sp_FOKVEDCreate: TADOStoredProc;
    sp_FOKVEDClear: TADOStoredProc;
    sp_FOKVEDGenerate: TADOStoredProc;
    actExcel: TAction;
    ToolButton5: TToolButton;
    qrKOKVED: TADOQuery;
    qrKOKVEDNUM: TIntegerField;
    qrKOKVEDNAME: TStringField;
    qrDataSUBJ_ID: TIntegerField;
    qrDataNUM: TIntegerField;
    qrDataNAME: TStringField;
    dxDBGridA: TdxDBGridMaskColumn;
    dxDBGridB: TdxDBGridMaskColumn;
    dxDBGridC: TdxDBGridMaskColumn;
    dxDBGridD: TdxDBGridMaskColumn;
    dxDBGridE: TdxDBGridMaskColumn;
    dxDBGridF: TdxDBGridMaskColumn;
    dxDBGridG: TdxDBGridMaskColumn;
    dxDBGridH: TdxDBGridMaskColumn;
    dxDBGridI: TdxDBGridMaskColumn;
    dxDBGridJ: TdxDBGridMaskColumn;
    dxDBGridK: TdxDBGridMaskColumn;
    dxDBGridL: TdxDBGridMaskColumn;
    dxDBGridM: TdxDBGridMaskColumn;
    dxDBGridN: TdxDBGridMaskColumn;
    dxDBGridO: TdxDBGridMaskColumn;
    dxDBGridP: TdxDBGridMaskColumn;
    dxDBGridQ: TdxDBGridMaskColumn;
    dxDBGridSum: TdxDBGridColumn;
    dxDBGridNUM: TdxDBGridColumn;
    qrDataA: TFloatField;
    qrDataB: TFloatField;
    qrDataC: TFloatField;
    qrDataD: TFloatField;
    qrDataE: TFloatField;
    qrDataF: TFloatField;
    qrDataG: TFloatField;
    qrDataH: TFloatField;
    qrDataI: TFloatField;
    qrDataJ: TFloatField;
    qrDataK: TFloatField;
    qrDataL: TFloatField;
    qrDataM: TFloatField;
    qrDataN: TFloatField;
    qrDataO: TFloatField;
    qrDataP: TFloatField;
    qrDataQ: TFloatField;
    qrDataSum: TFloatField;
    ToolButton6: TToolButton;
    actCheck: TAction;
    dxDBGridR: TdxDBGridMaskColumn;
    dxDBGridS: TdxDBGridMaskColumn;
    dxDBGridT: TdxDBGridMaskColumn;
    dxDBGridU: TdxDBGridMaskColumn;
    qrDataR: TFloatField;
    qrDataS: TFloatField;
    qrDataT: TFloatField;
    qrDataU: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actGenerateExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actExcelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dxDBGridEditing(Sender: TObject; Node: TdxTreeListNode;
      var Allow: Boolean);
    procedure dxDBGridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure dxDBGridColumnSorting(Sender: TObject;
      Column: TdxDBTreeListColumn; var Allow: Boolean);
    procedure qrDataCalcFields(DataSet: TDataSet);
    procedure actCheckExecute(Sender: TObject);
    procedure qrDataBeforePost(DataSet: TDataSet);
    procedure dxDBGridEdited(Sender: TObject; Node: TdxTreeListNode);
  private
  public
    ID: Integer;
    function GetCurrSubjID: Integer;
  end;

var
  fmFOKVED    : TfmFOKVED;

implementation

{$R *.DFM}

uses dMain, fOtrDlg, msg, rdialogs;

procedure TfmFOKVED.FormShow(Sender: TObject);
begin
  actGenerate.Visible:= (ID > 0) and (ID = GetCurrSubjID);
  qrData.Parameters.ParamByName('SUBJ_ID').Value := ID;
  qrData.Open;
  if qrData.RecordCount < 6 then begin
    actCreateExecute(nil);
    qrData.Close;
    qrData.Open;
  end;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; ParamCheck := false;
    SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ WHERE SUBJ_ID = '+IntToStr(ID);
    Open;
    Caption := Caption+' - '+Fields[0].AsString;
  finally Free;
  end;
end;

procedure TfmFOKVED.actPrintExecute(Sender: TObject);
begin
  dxDBGrid.CancelEditor;
  dmMain.PrintData(ID);
end;

procedure TfmFOKVED.dxDBGridColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := False;
end;

procedure TfmFOKVED.dxDBGridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
  ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn; ASelected,
  AFocused, ANewItemRow: Boolean; var AText: string; var AColor: TColor;
  AFont: TFont; var AAlignment: TAlignment; var ADone: Boolean);
begin
  if StrToInt(ANode.Strings[0]) in [35,45] then begin
    if (AFocused) or (ASelected) then AColor := clHighlight
    else AColor := clBtnFace;
  end;
end;

procedure TfmFOKVED.dxDBGridEdited(Sender: TObject; Node: TdxTreeListNode);
var
  i: Integer;
  s: String;
begin
  i := qrData.RecNo;
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    s := VarToStr(dxDBGrid.FocusedField.Value);
    if s = '' then s := 'NULL';
    SQL.Text := Format('update FOKVED2010 set %s = %s where NUM = %s AND SUBJ_ID = %s',
      [dxDBGrid.FocusedField.FieldName,  s, IntToStr(qrDataNUM.Value),
        IntToStr(qrDataSUBJ_ID.Value)]);
    ExecSQL;
  finally
    Free;
  end;
  qrData.Close;
  qrData.Open;
  qrData.RecNo := i;
end;

procedure TfmFOKVED.dxDBGridEditing(Sender: TObject; Node: TdxTreeListNode;
  var Allow: Boolean);
begin
  Allow := not (StrToInt(Node.Strings[0]) in [35,45]);
end;

function TfmFOKVED.GetCurrSubjID: Integer;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT SUBJ_ID FROM CURR_SUBJ';
    try
      Open;
      if IsEmpty then Result := 0
      else Result := Fields[0].AsInteger;
    except
      Result := -1;
    end;
  finally Free;
  end;
end;

procedure TfmFOKVED.qrDataBeforePost(DataSet: TDataSet);
begin
  Abort;
end;

procedure TfmFOKVED.qrDataCalcFields(DataSet: TDataSet);
var
  v: Variant;
  f: Double;
begin
  if not (qrDataNUM.Value in [35,45]) then begin
    qrDataSum.Value := qrDataA.Value + qrDataB.Value + qrDataC.Value + qrDataD.Value +
     qrDataE.Value + qrDataF.Value + qrDataG.Value + qrDataH.Value + qrDataI.Value +
     qrDataJ.Value + qrDataK.Value + qrDataL.Value + qrDataM.Value + qrDataN.Value +
     qrDataO.Value + qrDataP.Value + qrDataQ.Value + qrDataR.Value + qrDataS.Value +
     qrDataT.Value + qrDataU.Value;
  end
  else if qrData.RecordCount = 6 then begin
    v := dxDBGrid.Items[2].Values[dxDBGrid.ColumnByFieldName('Sum').Index];
    if v = NULL then Exit;
    f := v;
    if qrDataNUM.Value = 35 then begin
      v := dxDBGrid.Items[1].Values[dxDBGrid.ColumnByFieldName('Sum').Index];
      if (v = NULL) or (v = 0) then Exit;
      qrDataSum.AsString := FormatFloat('0.00', f / v * 100);
    end
    else if qrDataNUM.Value = 45 then begin
      if f = 0 then Exit;
      v := dxDBGrid.Items[4].Values[dxDBGrid.ColumnByFieldName('Sum').Index];
      if (v = NULL) then Exit;
      qrDataSum.AsString := FormatFloat('0.00', v / f * 100);
    end;
  end;
end;

procedure TfmFOKVED.actGenerateExecute(Sender: TObject);
var IsFull: Boolean; FilterType: SmallInt;
begin
  dxDBGrid.CancelEditor;
  IsFull:= True;
  FilterType := 1;
  if ShowOtrDlg(IsFull, FilterType) = mrOk then begin
    sp_FOKVEDGenerate.Parameters.ParamByName('@SUBJ_ID').Value := ID;
    sp_FOKVEDGenerate.Parameters.ParamByName('@IS_FULL').Value := IsFull;
    sp_FOKVEDGenerate.Parameters.ParamByName('@FilterType').Value := FilterType;
    sp_FOKVEDGenerate.ExecProc;
    qrData.Close;
    qrData.Open;

    with TADOQuery.Create(Self) do try
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT NULLIF(COUNT(O.ORGID),0) AS ORG_COUNT'#10 +
        'FROM KOKVED_ K'#10 +
        'LEFT OUTER JOIN (select OO.ORGID, '#10 +
        ' OKVED_FIRST = CASE WHEN (OO.MainOKONH LIKE ''[0-9][0-9]'' OR OO.MainOKONH LIKE ''[0-9][0-9].%'')'#10 +
        ' AND EXISTS( SELECT * FROM KOKVED '#10 +
        '   WHERE CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int) BETWEEN OKVED_BEGIN AND OKVED_END)'#10 +
        '     THEN CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int) ELSE 0 END'#10 +
        '   from v_ORG OO'#10 +
        '   where oo.out_date is null or oo.out_date > getdate()'#10 +
	      ' ) O ON (O.OKVED_FIRST BETWEEN K.OKVED_BEGIN AND K.OKVED_END)'#10 +
        'where OKVED_SECTION = ''_'' GROUP BY K.OKVED_SECTION';

      Open;
      if Fields[0].AsInteger > 0 then
        ShowMessage('Обнаружено ' + Fields[0].AsString + ' организаций, с неправильным кодом ВЭД ' +
          'и поэтому не вошедших в сведения по видам экон. деятельности');
    finally
      Free;
    end;
  end;
end;

procedure TfmFOKVED.actCheckExecute(Sender: TObject);
var
  i: Integer;
begin
  dxDBGrid.CancelEditor;
  if qrData.State in dsEditModes then qrData.Post;
  for i := 0 to qrData.Fields.Count - 1 do
    if Length(qrData.Fields[i].FieldName) = 1 then begin
      qrData.Locate('NUM', 35, []);
      if (qrData.Fields[i].AsFloat > 100) then begin
        dxDBGrid.FocusedField := qrData.Fields[i];
        if RMessageDlg('Кол-во работающих должно быть больше, чем ГПЗ!'#13'Продолжить проверку?',
          mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;
      end;
      qrData.Locate('NUM', 45, []);
      if (qrData.Fields[i].AsFloat > 100) then begin
        dxDBGrid.FocusedField := qrData.Fields[i];
        if RMessageDlg('ГПЗ должно быть больше, чем забронировано!'#13'Продолжить проверку?',
          mtWarning, [mbYes, mbNo], 0) = mrNo then Exit;
      end;
    end;
  ShowMessage('Проверка завершена!');
end;

procedure TfmFOKVED.actClearExecute(Sender: TObject);
begin
  if not Confirm('Очистить форму?') then Exit;
  qrData.Close;
  sp_FOKVEDClear.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FOKVEDClear.ExecProc;
  qrData.Open;
end;

procedure TfmFOKVED.actCreateExecute(Sender: TObject);
begin
  if Sender <> nil then if not Confirm('Очистить форму и сформировать пустую?') then Exit;
  dxDBGrid.CancelEditor;
  qrData.Close;
  sp_FOKVEDCreate.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FOKVEDCreate.ExecProc;
  qrData.Open;
end;

procedure TfmFOKVED.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

procedure TfmFOKVED.actExcelExecute(Sender: TObject);
begin
  dxDBGrid.CancelEditor;
  dmMain.GridToExcel(dxDBGrid,Caption,false,true);
end;

procedure TfmFOKVED.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  dxDBGrid.CancelEditor;
  CanClose := True;
  try if qrData.State = dsEdit then qrData.Post
  except   CanClose := False;
  end;
end;

end.

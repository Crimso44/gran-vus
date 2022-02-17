unit fGeneralQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, dxBar, dxExEdtr, StdCtrls, dxTL, dxCntner, ADODB,
  DB, Buttons, dxmdaset, dxDBCtrl, dxDBGrid;

type
  TfmGeneralQty = class(TForm)
    pbCalc: TButton;
    pbOk: TButton;
    pbCancel: TButton;
    qrPARAMload: TADOQuery;
    qrPARAMsave: TADOQuery;
    edName: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    mData: TdxMemData;
    dxtParam: TdxDBGrid;
    colpID: TdxDBGridColumn;
    colpPARAM_NAME: TdxDBGridColumn;
    colpVALUE2: TdxDBGridColumn;
    dsData: TDataSource;
    colpVALUE3: TdxDBGridColumn;
    colpVALUE4: TdxDBGridColumn;
    colpVALUE5: TdxDBGridColumn;
    colpVALUE6: TdxDBGridColumn;
    colpVALUE7: TdxDBGridColumn;
    colpVALUE8: TdxDBGridColumn;
    sp_CalcSubjParams: TADOStoredProc;
    procedure colpVALUE2Validate(Sender: TObject;
      var ErrorText: String; var Accept: Boolean);
    procedure pbCalcClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pbOkClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure dxtParamCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: string;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure mDataBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    ID: Integer;
    FOriginal: array [0..4, 2..8] of String;
  public
    { Public declarations }
  end;

procedure Execute;

implementation

uses dMain, msg;

{$R *.dfm}

procedure Execute;
begin
  with    TfmGeneralQty.Create(Application) do
  try     ShowModal;
  finally Free;
  end;
end;

procedure TfmGeneralQty.colpVALUE2Validate(Sender: TObject;
  var ErrorText: String; var Accept: Boolean);
begin
  if Assigned(dxtParam.InplaceEditor) {and (Sender = colpPARAM_VALUE)} then
    if dxtParam.InplaceEditor.GetEditingText <> '' then
      try
        if dxtParam.FocusedNode.Values[colpID.Index] = 2
          then StrToFloat(dxtParam.InplaceEditor.GetEditingText)
          else StrToInt(dxtParam.InplaceEditor.GetEditingText);
      except
        Accept:= False;
        ErrorText := 'Неверное числовое значение';
      end;
end;

procedure TfmGeneralQty.dxtParamCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: string; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if (AColumn = colpValue2) or
    ((AColumn = colpValue4) and (ANode.Values[colpID.Index] = 2)) or
    ((AColumn = colpValue7) and (ANode.Values[colpID.Index] <> 2)) or
    (((AColumn = colpValue5) or (AColumn = colpValue6) or (AColumn = colpValue7)) and (ANode.Values[colpID.Index] = 3)) then
    AColor := clLtGray;
end;

procedure TfmGeneralQty.pbCalcClick(Sender: TObject);
begin
  with sp_CalcSubjParams do begin
    Open;
    First;
    while not EOF do begin
      if mData.Locate('ID', FieldByName('SUBJ_PARAM_ID').AsInteger, []) then begin
        mData.Edit;
        mData.FieldByName('PARAM_VALUE').Value := FieldByName('PARAM_VALUE').Value;
        mData.FieldByName('VALUE3').Value := FieldByName('VALUE3').Value;
        mData.FieldByName('VALUE4').Value := FieldByName('VALUE4').Value;
        mData.FieldByName('VALUE5').Value := FieldByName('VALUE5').Value;
        mData.FieldByName('VALUE6').Value := FieldByName('VALUE6').Value;
        mData.FieldByName('VALUE7').Value := FieldByName('VALUE7').Value;
        mData.FieldByName('VALUE8').Value := FieldByName('VALUE8').Value;
        mData.Post;
      end;
      Next;
    end;
  end;
end;

procedure TfmGeneralQty.FormCreate(Sender: TObject);
var I, J: Integer;
begin
  ID := dmMain.GetSubjID;
  try
    qrPARAMload.Close;
    qrPARAMload.Parameters.ParamByName('SUBJ_ID').Value := ID;
    qrPARAMload.Open;
    mData.LoadFromDataSet(qrPARAMload);
(*    qrPARAMload.First;
    dxtPARAM.ClearNodes;
    while not qrPARAMload.EOF do begin
      with dxtParam.Add do begin
        Values[colpID.Index] := qrPARAMload.FieldByName('ID').Value;
        with qrPARAMload.FieldByName('PARAM_NAME') do
          if not IsNull then Values[colpPARAM_NAME.Index] := Value;
        with qrPARAMload.FieldByName('PARAM_VALUE') do if not IsNull then
          if Values[colpID.Index]<3
            then Values[colpPARAM_VALUE.Index] := FormatFloat('0.000', Value)
            else Values[colpPARAM_VALUE.Index] := FormatFloat('0', Value);
      end;
      qrPARAMload.Next;
    end;
*)
  finally
    qrPARAMload.Close;
  end;

  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; ParamCheck := false;
    SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ WHERE SUBJ_ID = '+IntToStr(ID);
    Open;
    edName.Text := Fields[0].AsString;
  finally Free;
  end;

  for I := 0 to 4 do
    for j := 2 to 8 do
      FOriginal[I,j] := dxtParam.Items[I].Strings[dxtParam.ColumnByName('colpValue'+IntToStr(j)).Index];
  dxtParam.Enabled := dmMain.rEdit;
  pbCalc.Enabled   := dmMain.rEdit and (ID > 0) and (ID = dmMain.GetCurrSubjID);
  pbOk.Enabled     := dmMain.rEdit;
end;

procedure TfmGeneralQty.mDataBeforePost(DataSet: TDataSet);

  function ToFloat(f: TField): double;
  begin
    Result := 0;
    if Trim(f.AsString) <>'' then
      Result := f.AsFloat;
  end;

begin
  if mData.FieldByName('ID').AsInteger = 2 then begin
     mData.FieldByName('Value4').AsFloat :=
       ToFloat(mData.FieldByName('Value5')) +
       ToFloat(mData.FieldByName('Value6')) +
       ToFloat(mData.FieldByName('Value7'));
     mData.FieldByName('Param_Value').AsFloat :=
       ToFloat(mData.FieldByName('Value3')) +
       ToFloat(mData.FieldByName('Value4')) +
       ToFloat(mData.FieldByName('Value8'));
  end else begin
     mData.FieldByName('Param_Value').AsFloat :=
       ToFloat(mData.FieldByName('Value3')) +
       ToFloat(mData.FieldByName('Value4')) +
       ToFloat(mData.FieldByName('Value5')) +
       ToFloat(mData.FieldByName('Value6')) +
       ToFloat(mData.FieldByName('Value8'));
  end;
end;

procedure TfmGeneralQty.pbOkClick(Sender: TObject);
var I, J: Integer;

  function iif(cond: boolean; vtrue, vfalse: String): String;
  begin
    if cond then Result := vtrue
            else Result := vfalse;
  end;

begin
  try
    qrPARAMsave.Close;
    qrPARAMsave.Parameters.ParamByName('SUBJ_ID').Value := ID;
    qrPARAMsave.Open;
    while not qrPARAMsave.IsEmpty do qrPARAMsave.Delete;
    for I := 0 to dxtParam.Count-1 do begin
      qrPARAMsave.Append;
      qrPARAMsave.FieldByName('SUBJ_ID').Value := ID;
      qrPARAMsave.FieldByName('SUBJ_PARAM_ID').Value := dxtParam.Items[I].Values[colpID.Index];
      for j := 2 to 8 do
        if dxtParam.Items[I].Values[dxtParam.ColumnByName('colpValue'+IntToStr(j)).Index] <> '' then
          qrPARAMsave.FieldByName(iif(j=2,'PARAM_','')+'VALUE'+iif(j=2,'', IntToStr(j))).Value :=
            dxtParam.Items[I].Values[dxtParam.ColumnByName('colpValue'+IntToStr(j)).Index];
      qrPARAMsave.Post;
    end;
  finally
    qrPARAMsave.Close;
  end;
end;

procedure TfmGeneralQty.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var I, j: Integer;
begin
  if ModalResult=mrOk then Exit;
  dxtParam.CloseEditor;
  for I := 0 to 4 do
    for j := 2 to 8 do
      if FOriginal[I,j] <> dxtParam.Items[I].Strings[dxtParam.ColumnByName('colpValue'+IntToStr(j)).Index] then begin
        CanClose := Confirm('Данные были изменены. Выйти без сохранения?'); Exit;
  end;
end;

procedure TfmGeneralQty.BitBtn1Click(Sender: TObject);
begin
  dmMain.GridToExcel(dxtParam,Caption,false,true);
end;
{
  Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoCaseInsensitive]
  OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand]
  TreeLineColor = clGrayText
  ShowRoot = False
}
end.



unit fSubjCard;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, Menus, ExtCtrls, dxExEdtr, dxEdLib,
  dxDBELib, dxDBEdtr, dxCntner, dxEditor, dxTL, dxTLClms, ADOdb, Db,
  Variants;

type
  TfmSubjCard = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    Label1: TLabel;
    edName: TEdit;
    qrData: TADOQuery;
    dsData: TDataSource;
    qrINFOload: TADOQuery;
    qrINFOsave: TADOQuery;
    PC: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label3: TLabel;
    cbTYPE: TComboBox;
    Label4: TLabel;
    Label2: TLabel;
    edFullName: TEdit;
    Label6: TLabel;
    edAddress: TEdit;
    dxtInfo: TdxTreeList;
    colID: TdxTreeListColumn;
    colINFO_NAME: TdxTreeListColumn;
    colORG_NAME: TdxTreeListColumn;
    colPOSITION_NAME: TdxTreeListColumn;
    colFIO: TdxTreeListColumn;
    colPHONE: TdxTreeListColumn;
    dxtParam: TdxTreeList;
    colpID: TdxTreeListColumn;
    colpPARAM_NAME: TdxTreeListColumn;
    colpPARAM_VALUE: TdxTreeListColumn;
    Label7: TLabel;
    qrPARAMload: TADOQuery;
    qrPARAMsave: TADOQuery;
    CalcButton: TButton;
    Label8: TLabel;
    cbSUBJ_AGG: TComboBox;
    sp_CalcSubjParams: TADOStoredProc;
    cbKterr: TdxPopupEdit;
    dxtKTerr: TdxTreeList;
    dxtKTerrCode: TdxTreeListColumn;
    dxtKTerrNameTerr: TdxTreeListColumn;
    dxtKTerrId: TdxTreeListColumn;
    pmKTerr: TPopupMenu;
    miKTerr: TMenuItem;
    cbOKATO1: TdxPopupEdit;
    Label9: TLabel;
    dxtOKATO: TdxTreeList;
    dxtOKATOCode: TdxTreeListColumn;
    dxtOKATONameTerr: TdxTreeListColumn;
    Label5: TLabel;
    edREPORT_DATE: TdxDateEdit;
    GroupBox1: TGroupBox;
    edPHONE: TEdit;
    Label12: TLabel;
    Label11: TLabel;
    edFIO: TEdit;
    edPOSITION_NAME: TEdit;
    Label10: TLabel;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edPHONE2: TEdit;
    edFIO2: TEdit;
    edPOSITION_NAME2: TEdit;
    colPOSITION_NAME2: TdxTreeListColumn;
    colFIO2: TdxTreeListColumn;
    colPHONE2: TdxTreeListColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edNameChange(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure colpPARAM_VALUEValidate(Sender: TObject;
      var ErrorText: String; var Accept: Boolean);
    procedure CalcButtonClick(Sender: TObject);
    procedure cbKterrCloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure dxtKTerrDblClick(Sender: TObject);
    procedure dxtOKATODblClick(Sender: TObject);
    procedure cbOKATO1CloseUp(Sender: TObject; var Text: String;
      var Accept: Boolean);
    procedure cbOKATO1KeyPress(Sender: TObject; var Key: Char);
    procedure cbOKATO1Popup(Sender: TObject; const EditText: String);
    procedure dxtInfoChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure edPOSITION_NAMEChange(Sender: TObject);
    procedure edFIOChange(Sender: TObject);
    procedure edPHONEChange(Sender: TObject);
    procedure edPOSITION_NAME2Change(Sender: TObject);
    procedure edFIO2Change(Sender: TObject);
    procedure edPHONE2Change(Sender: TObject);
  private
    fChanged: boolean;
    procedure SetKTerr(Value: Integer);
    procedure FillKTerrTree;
    procedure AfterSaveSubj;
    procedure LocateOKATO(Value: string);
    procedure SetOKATOList;
  public
    ID: Integer;
    function LoadData: boolean;
    function StoreData: boolean;
    function ChkData: boolean;
  end;

  procedure ShowSubjCard(ID: Integer);

implementation

uses msg, dMain, fMain, fSubjLst, StrUtils;

{$R *.DFM}

procedure ShowSubjCard(ID: Integer);
var  fmSubjCard: TfmSubjCard;
     i: Integer;
begin
  fmSubjCard := nil;
  if id>0 then
    for i:=0 to Application.ComponentCount-1 do
      if Application.Components[i] is TfmSubjCard then
        if (Application.Components[i] as TfmSubjCard).ID=id then begin
          fmSubjCard := (Application.Components[i] as TfmSubjCard);
          break;
        end;
  if fmSubjCard=nil then begin
    Application.CreateForm(TfmSubjCard,fmSubjCard);
    if fmMain.MainScale <> 100 then
      fmSubjCard.ScaleBy(fmMain.MainScale, 100);
    fmSubjCard.ID := id;
    if not fmSubjCard.LoadData then begin
      fmSubjCard.Free;
      Exit;
    end;
  end;
  if IsIConic(fmSubjCard.Handle) then ShowWindow(fmSubjCard.Handle,SW_RESTORE);
  fmSubjCard.BringToFront;
end;


procedure TfmSubjCard.FormCreate(Sender: TObject);
  procedure LoadStrings(Items: TStrings; HasEmpty: boolean; sSQL,FldID,FldData: string);
  begin
    Items.Clear;
    if HasEmpty then Items.AddObject('<не указано>',nil);
    with TADOQuery.Create(Self) do try
      Connection := dmMain.dbMain;
      LockType:= ltReadonly;
      SQL.Text := sSQL;
      Open;
      while not EOF do begin
        Items.AddObject(
          FieldByName(FldData).AsString,
          Pointer(FieldByName(FldID).AsInteger));
        Next;
      end;
    finally
      Free;
    end;
  end;
begin
  cbTYPE        .Enabled := dmMain.rEdit;
  cbKterr       .Enabled := dmMain.rEdit;
  edFullName    .Enabled := dmMain.rEdit;
  edAddress     .Enabled := dmMain.rEdit;
  cbSUBJ_AGG    .Enabled := dmMain.rEdit;
  cbOKATO1      .Enabled := dmMain.rEdit;
  dxtInfo       .Enabled := dmMain.rEdit;
  edREPORT_DATE .Enabled := dmMain.rEdit;
  btnOk         .Visible := dmMain.rEdit;
  btnApply      .Visible := dmMain.rEdit;
  if not dmMain.rEdit then btnCancel.Caption := 'Закрыть';

  ID := 0;
// Loading base lists
  try
    FillKTerrTree;

    LoadStrings(cbTYPE.Items,false,'SELECT TYPE_ID, TYPE_NAME FROM SUBJ_TYPE ORDER BY TYPE_ID','TYPE_ID','TYPE_NAME');
    LoadStrings(cbSUBJ_AGG.Items,false,'SELECT SUBJ_AGG_ID, SUBJ_AGG_NAME FROM SUBJ_AGG_TYPE ORDER BY SUBJ_AGG_ID','SUBJ_AGG_ID','SUBJ_AGG_NAME');

    fChanged := true;
    btnApply.Enabled := true;
  except
    ShowErr('Ошибка при загрузке базовых справочников!');
  end;
  SetOKATOList;
end;

function TfmSubjCard.LoadData: boolean;
  function ListIndex(Items: TStrings; ID: Integer; DefVal: Integer=-1): Integer;
  var i: Integer;
  begin
    Result := DefVal;
    for i:=0 to Items.Count-1 do
      if Integer(Items.Objects[i])=ID then begin
        Result := i;
        break;
      end;
  end;
begin
  Result := false;
  if qrData.Active then qrData.Close;
  try
    if ID > 0 then begin
      qrData.Parameters.ParamByName('SUBJ_ID').Value := ID;
      qrData.Open;
      edName.Text := Trim(qrData.FieldByName('SUBJ_NAME').AsString);
      edFullName.Text := Trim(qrData.FieldByName('SUBJ_FULLNAME').AsString);
      edAddress.Text := Trim(qrData.FieldByName('SUBJ_ADDRESS').AsString);
      SetKTerr(qrData.FieldByName('TERR_ID').AsInteger);
      if not qrData.FieldByName('TYPE_ID').IsNull then
        cbTYPE.ItemIndex := ListIndex(cbTYPE.Items,qrData.FieldByName('TYPE_ID').AsInteger);
      if not qrData.FieldByName('SUBJ_AGG_ID').IsNull then
        cbSUBJ_AGG.ItemIndex := ListIndex(cbSUBJ_AGG.Items,qrData.FieldByName('SUBJ_AGG_ID').AsInteger);
      cbOKATO1.Text := qrData.FieldByName('KodReg').AsString;
      with qrData.FieldByName('REPORT_DATE') do
      if IsNull
        then edREPORT_DATE.Text := EmptyStr
        else edREPORT_DATE.Date := Value;
      qrData.Close;
    end;

    try
      qrINFOload.Close;
      qrINFOload.Parameters.ParamByName('SUBJ_ID').Value := ID;
      qrINFOload.Open;
      dxtInfo.ClearNodes;
      while not qrINFOload.EOF do begin
        with dxtInfo.Add do begin
          Values[colID.Index] := qrINFOload.FieldByName('SUBJ_INFO_ID').Value;
          if not qrINFOload.FieldByName('SUBJ_INFO_NAME').IsNull then
            Values[colINFO_NAME.Index] := qrINFOload.FieldByName('SUBJ_INFO_NAME').Value;
          if not qrINFOload.FieldByName('ORG_NAME').IsNull then
            Values[colORG_NAME.Index] := qrINFOload.FieldByName('ORG_NAME').Value;
          if not qrINFOload.FieldByName('POSITION_NAME').IsNull then
            Values[colPOSITION_NAME.Index] := qrINFOload.FieldByName('POSITION_NAME').Value;
          if not qrINFOload.FieldByName('FIO').IsNull then
            Values[colFIO.Index] := qrINFOload.FieldByName('FIO').Value;
          if not qrINFOload.FieldByName('PHONE').IsNull then
            Values[colPHONE.Index] := qrINFOload.FieldByName('PHONE').Value;
          if not qrINFOload.FieldByName('POSITION_NAME2').IsNull then
            Values[colPOSITION_NAME2.Index] := qrINFOload.FieldByName('POSITION_NAME2').Value;
          if not qrINFOload.FieldByName('FIO2').IsNull then
            Values[colFIO2.Index] := qrINFOload.FieldByName('FIO2').Value;
          if not qrINFOload.FieldByName('PHONE2').IsNull then
            Values[colPHONE2.Index] := qrINFOload.FieldByName('PHONE2').Value;
        end;
        qrINFOload.Next;
      end;
    finally
      qrINFOload.Close;
    end;
    dxtInfoChangeNode(dxtInfo,dxtInfo.FocusedNode,dxtInfo.FocusedNode);
(*
    try
      qrPARAMload.Close;
      qrPARAMload.Parameters.ParamByName('SUBJ_ID').Value := ID;
      qrPARAMload.Open;
      dxtPARAM.ClearNodes;
      while not qrPARAMload.EOF do begin
        with dxtParam.Add do begin
          Values[colpID.Index] := qrPARAMload.FieldByName('SUBJ_PARAM_ID').Value;
          if not qrPARAMload.FieldByName('SUBJ_PARAM_NAME').IsNull then
            Values[colpPARAM_NAME.Index] := qrPARAMload.FieldByName('SUBJ_PARAM_NAME').Value;
          if not qrPARAMload.FieldByName('PARAM_VALUE').IsNull then
            Values[colpPARAM_VALUE.Index] := FormatFloat('0.00', qrPARAMload.FieldByName('PARAM_VALUE').Value);
        end;
        qrPARAMload.Next;
      end;
    finally
      qrPARAMload.Close;
    end;
*)
    if ID > 0 then begin
      fChanged := false;
      btnApply.Enabled := false;
    end;

    CalcButton.Enabled:= (ID > 0) and (ID = dmMain.GetCurrSubjID);
    if CalcButton.Enabled then begin
      cbSUBJ_AGG.ItemIndex := ListIndex(cbSUBJ_AGG.Items,1);
      cbSUBJ_AGG.Enabled:= False;
    end;

    Result := true;
  except
    ShowErr('Ошибка при загрузке сведений карточки ВУО из БД!');
  end;
end;

function TfmSubjCard.StoreData: boolean;
  procedure AssignStr(fld: TField; ed: TCustomEdit);
  begin
    if Trim(ed.Text)=EmptyStr then fld.Value := NULL
    else fld.Value := Trim(ed.Text);
  end;
  function NULLIF(Value1,Value2: Variant): Variant;
  begin
    if Value1=Value2 then Result := NULL else Result := Value1;
  end;
var
  n: Integer;
begin
  Result := false;
  if not ChkData then Exit;
  try
    dmMain.dbMain.BeginTrans;
  except
  end;
  try
    if ID<=0 then begin
      qrData.Close;
      qrData.Parameters.ParamByName('fAll').Value := 1;
      qrData.Open;
      qrData.Append;
    end
    else begin
      qrData.Close;
      qrData.Parameters.ParamByName('fAll').Value := 0;
      qrData.Parameters.ParamByName('SUBJ_ID').Value := ID;
      qrData.Open;
      qrData.Edit;
    end;
    AssignStr(qrData.FieldByName('SUBJ_NAME'),edName);
    AssignStr(qrData.FieldByName('SUBJ_FULLNAME'),edFullName);
    AssignStr(qrData.FieldByName('SUBJ_ADDRESS'),edAddress);
    if cbKTERR.Tag>0 then
      qrData.FieldByName('TERR_ID').Value := cbKTERR.Tag
    else
      qrData.FieldByName('TERR_ID').Value := NULL;
    if cbTYPE.ItemIndex >= 0 then
      qrData.FieldByName('TYPE_ID').Value :=
        Integer(cbTYPE.Items.Objects[cbTYPE.ItemIndex])
    else
      qrData.FieldByName('TYPE_ID').Value := NULL;
    if cbSUBJ_AGG.ItemIndex >= 0 then
      qrData.FieldByName('SUBJ_AGG_ID').Value :=
        Integer(cbSUBJ_AGG.Items.Objects[cbSUBJ_AGG.ItemIndex])
    else
      qrData.FieldByName('SUBJ_AGG_ID').Value := NULL;
    qrData.FieldByName('KODREG').Value := NULLIF(cbOKATO1.Text,EmptyStr);
    if edREPORT_DATE.Text=EmptyStr
      then qrData.FieldByName('REPORT_DATE').Value := NULL
      else qrData.FieldByName('REPORT_DATE').Value := edREPORT_DATE.Date;

    qrData.Post;

    try
      qrINFOsave.Open;
      while not qrINFOsave.IsEmpty do qrINFOsave.Delete;
      for n:=0 to dxtInfo.Count-1 do begin
        qrINFOsave.Append;
        qrINFOsave.FieldByName('SUBJ_ID').Value := qrData.FieldByName('SUBJ_ID').AsInteger;
        qrINFOsave.FieldByName('SUBJ_INFO_ID').Value := dxtInfo.Items[n].Values[colID.Index];
        qrINFOsave.FieldByName('ORG_NAME').Value := dxtInfo.Items[n].Values[colORG_NAME.Index];
        qrINFOsave.FieldByName('POSITION_NAME').Value := dxtInfo.Items[n].Values[colPOSITION_NAME.Index];
        qrINFOsave.FieldByName('FIO').Value := dxtInfo.Items[n].Values[colFIO.Index];
        qrINFOsave.FieldByName('PHONE').Value := dxtInfo.Items[n].Values[colPHONE.Index];
        qrINFOsave.FieldByName('POSITION_NAME2').Value := dxtInfo.Items[n].Values[colPOSITION_NAME2.Index];
        qrINFOsave.FieldByName('FIO2').Value := dxtInfo.Items[n].Values[colFIO2.Index];
        qrINFOsave.FieldByName('PHONE2').Value := dxtInfo.Items[n].Values[colPHONE2.Index];
        qrINFOsave.Post;
      end;
    finally
      qrINFOsave.Close;
    end;
    (*
    try
      qrPARAMsave.Open;
      while not qrPARAMsave.IsEmpty do qrPARAMsave.Delete;
      for n:=0 to dxtParam.Count-1 do begin
        qrPARAMsave.Append;
        qrPARAMsave.FieldByName('SUBJ_ID').Value := qrData.FieldByName('SUBJ_ID').AsInteger;
        qrPARAMsave.FieldByName('SUBJ_PARAM_ID').Value := dxtParam.Items[n].Values[colpID.Index];
        if dxtParam.Items[n].Values[colpPARAM_VALUE.Index] <> '' then
          qrPARAMsave.FieldByName('PARAM_VALUE').Value := dxtParam.Items[n].Values[colpPARAM_VALUE.Index];
        qrPARAMsave.Post;
      end;
    finally
      qrPARAMsave.Close;
    end;
    *)
    if dmMain.dbMain.InTransaction then
      dmMain.dbMain.CommitTrans;
    ID:= qrData.FieldByName('SUBJ_ID').AsInteger;

    AfterSaveSubj;

    Result := true;
//refresh lists
    for n:=0 to Application.ComponentCount-1 do
      if Application.Components[n] is TfmSubjList then begin
        (Application.Components[n] as TfmSubjList).qrData.Requery([]);
        (Application.Components[n] as TfmSubjList).qrData.Locate('SUBJ_ID',ID,[]);
      end;
  except
    if dmMain.dbMain.InTransaction then dmMain.dbMain.RollbackTrans;
    ShowErr('Ошибка при сохранении сведений карточки ВУО!');
  end;
end;

procedure TfmSubjCard.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if fChanged then
    CanClose := Confirm('Сведения карточки ВУО не сохранены!'+#13+
      'Выйти из карточки без сохранения данных?');
end;

procedure TfmSubjCard.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmSubjCard.edNameChange(Sender: TObject);
begin
  fChanged := true;
  btnApply.Enabled := fChanged;
end;

procedure TfmSubjCard.btnApplyClick(Sender: TObject);
begin
  fChanged := not StoreData;
  btnApply.Enabled := fChanged;
end;

procedure TfmSubjCard.btnOkClick(Sender: TObject);
begin
  btnOk.SetFocus;
  if fChanged then
    if not StoreData then Exit
    else fChanged := false;
  btnApply.Enabled := not fChanged;
  Close;
end;

procedure TfmSubjCard.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmSubjCard.colpPARAM_VALUEValidate(Sender: TObject;
  var ErrorText: String; var Accept: Boolean);
begin
  if dxtParam.InplaceEditor <> nil then
  begin
    if Sender = colpPARAM_VALUE then
    begin
      try
        StrToFloat(dxtParam.InplaceEditor.GetEditingText);
      except
        Accept:= False;
        ErrorText := 'Неверное числовое значение';
      end;
    end;
  end;
end;

procedure TfmSubjCard.CalcButtonClick(Sender: TObject);
var
  i: Integer;
begin
  with sp_CalcSubjParams do begin
    ExecProc;
    for i:= 0 to dxtParam.Count - 1 do begin
      if dxtParam.Items[i].Values[colpID.Index] = 2 then
        dxtParam.Items[i].Values[colpPARAM_VALUE.Index]:= Parameters.ParamByName('@RAB_COUNT').Value
      else if dxtParam.Items[i].Values[colpID.Index] = 10 then
        dxtParam.Items[i].Values[colpPARAM_VALUE.Index]:= Parameters.ParamByName('@ORG_COUNT').Value
      else if dxtParam.Items[i].Values[colpID.Index] = 11 then
        dxtParam.Items[i].Values[colpPARAM_VALUE.Index]:= Parameters.ParamByName('@PRIVORG_COUNT').Value;
    end;
  end;
  edNameChange(Sender);
end;

procedure TfmSubjCard.AfterSaveSubj;
begin
  with TADOQuery.Create(Self) do try
    Connection := dmMain.dbMain;
    LockType:= ltReadonly;
    SQL.Text := 'SET NOCOUNT ON '#10+
                'UPDATE FORM6HDR '#10+
                'SET ORGNAME = :ORGNAME '#10+
                'WHERE SUBJ_ID = :SUBJ_ID';
    Parameters.ParseSQL(SQL.Text, True);
    Parameters.ParamByName('SUBJ_ID').Value:= ID;
    Parameters.ParamByName('ORGNAME').Value:= edFullName.Text;
    ExecSQL;
  finally
    Free;
  end;
end;

function TfmSubjCard.ChkData: boolean;
  function ChkEdit(ed: TEdit; page_index: Integer; msg: string): boolean;
  begin
    Result := true;
    if Trim(ed.Text)=EmptyStr then begin
      Result := false;
      if page_index >= 0 then PC.ActivePageIndex := page_index;
      ed.SetFocus;
      ShowErr(msg);
    end;
  end;
var
  ex: Boolean;
begin
  Result:= False;
  if not ChkEdit(edName,-1,'Не указано наименование ВУО!') then Exit;
  if not ChkEdit(edFullName,-1,'Не указано полное наименование ВУО!') then Exit;
  if cbTYPE.ItemIndex<0 then begin
    PC.ActivePageIndex:= 0;
    cbTYPE.SetFocus;
    ShowErr('Не указан тип ВУО!');
    Exit;
  end;
  if cbKTERR.Tag<=0 then begin
    PC.ActivePageIndex:= 0;
    cbKTERR.SetFocus;
    ShowErr('Не указан положение ВУО!');
    Exit;
  end;
  if cbSUBJ_AGG.ItemIndex<0 then begin
    PC.ActivePageIndex:= 0;
    cbSUBJ_AGG.SetFocus;
    ShowErr('Не указан способ учета!');
    Exit;
  end;

  with TADOQuery.Create(Self) do try
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT * '+
                'FROM SUBJ '+
                'WHERE TERR_ID = :TERR_ID '+
                'AND SUBJ_ID <> :SUBJ_ID';
    Parameters.ParamByName('SUBJ_ID').Value:= ID;
    Parameters.ParamByName('TERR_ID').Value:= cbKTERR.Tag;
    Open;
    ex:= RecordCount > 0;
    Close;
  finally
    Free;
  end;

  if ex then begin
    PC.ActivePageIndex:= 0;
    cbKTERR.SetFocus;
    ShowErr('ВУО с таким положением уже есть в базе!');
    Exit;
  end;

  Result:= True;
end;

procedure TfmSubjCard.SetKTerr(Value: Integer);
  var n: TdxTreeListNode;
begin
  cbKTerr.Tag := Value;
//locate in tree
  n := dxtKTerr.TopNode;
  while Assigned(n) and (n.Values[dxtKTerrId.Index]<>Value) do n := n.GetNext;
  if Assigned(n) then n.Focused := true;
//set string value
  cbKTerr.Text :=
    dxtKTErr.FocusedNode.Strings[dxtKTerrCode.Index]+
    ' - '+
    dxtKTErr.FocusedNode.Strings[dxtKTerrNameTerr.Index];
end;

procedure TfmSubjCard.cbKterrCloseUp(Sender: TObject; var Text: String;
  var Accept: Boolean);
begin
  SetKTerr(dxtKTerr.FocusedNode.Values[dxtKTerrId.Index]);
  Accept := true;
end;

procedure TfmSubjCard.dxtKTerrDblClick(Sender: TObject);
begin
  cbKTerr.PopupForm.ClosePopup(true);
end;

procedure TfmSubjCard.FillKTerrTree;
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
    DS: TADOQuery;
begin
  DS := TADOQuery.Create(Self);
  DS.Connection := dmMain.dbMain;
  DS.SQL.Text := 'select kodterr, name, terr_id from kterr';
  DS.Open;
  try
    Codes := TStringList.Create;
    Codes.Sorted := true;
    try
//fill and sort terr. codes
      DS.First;
      while not DS.EOF do begin
        if Codes.IndexOf(DS.Fields[0].AsString)<0 then
          Codes.Add(DS.Fields[0].AsString);
        DS.Next;
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
        DS.Locate(DS.Fields[0].FieldName,Codes[n],[]);
        tn.Strings[1] := DS.Fields[1].AsString;
        tn.Values[2] := DS.Fields[2].AsInteger;
      end;
      dxtKTerr.ApplyBestFit(dxtKTerrCode);
      dxtKTerr.ApplyBestFit(dxtKTerrNameTerr);
    finally
      Codes.Free;
    end;
  finally
    DS.Free;
  end;
end;

procedure TfmSubjCard.dxtOKATODblClick(Sender: TObject);
begin
  dxtOKATO.Parent.Hide;
end;

procedure TfmSubjCard.LocateOKATO(Value: string);
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
  for n:=0 to dxtOKATO.Count-1 do
    if FindNode(dxtOKATO.Items[n]) then break;
  dxtOKATO.ApplyBestFit(dxtOKATOCode);
  dxtOKATO.ApplyBestFit(dxtOKATONameTerr);
end;

procedure TfmSubjCard.cbOKATO1CloseUp(Sender: TObject; var Text: String;
  var Accept: Boolean);
begin
  Text := dxtOKATO.FocusedNode.Strings[dxtOKATOCode.Index];
  Accept := true;
end;

procedure TfmSubjCard.cbOKATO1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9']) then Key := #0;
end;

procedure TfmSubjCard.cbOKATO1Popup(Sender: TObject;
  const EditText: String);
begin
  LocateOKATO(EditText);
end;

procedure TfmSubjCard.SetOKATOList;
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

var
  InScroll: Boolean;

procedure TfmSubjCard.dxtInfoChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  InScroll := True;
  edPOSITION_NAME.Text := Node.Strings[colPOSITION_NAME.Index];
  edFIO.Text           := Node.Strings[colFIO.Index];
  edPHONE.Text         := Node.Strings[colPHONE.Index];
  edPOSITION_NAME2.Text := Node.Strings[colPOSITION_NAME2.Index];
  edFIO2.Text           := Node.Strings[colFIO2.Index];
  edPHONE2.Text         := Node.Strings[colPHONE2.Index];
  InScroll := False;
end;

procedure TfmSubjCard.edPOSITION_NAMEChange(Sender: TObject);
begin
  if InScroll then Exit;
  dxtInfo.FocusedNode.Strings[colPOSITION_NAME.Index] := edPOSITION_NAME.Text;
  edNameChange(nil);
end;

procedure TfmSubjCard.edFIOChange(Sender: TObject);
begin
  if InScroll then Exit;
  dxtInfo.FocusedNode.Strings[colFIO.Index] := edFIO.Text;
  edNameChange(nil);
end;

procedure TfmSubjCard.edPHONEChange(Sender: TObject);
begin
  if InScroll then Exit;
  dxtInfo.FocusedNode.Strings[colPHONE.Index] := edPHONE.Text;
  edNameChange(nil);
end;


procedure TfmSubjCard.edPOSITION_NAME2Change(Sender: TObject);
begin
  if InScroll then Exit;
  dxtInfo.FocusedNode.Strings[colPOSITION_NAME2.Index] := edPOSITION_NAME2.Text;
  edNameChange(nil);
end;

procedure TfmSubjCard.edFIO2Change(Sender: TObject);
begin
  if InScroll then Exit;
  dxtInfo.FocusedNode.Strings[colFIO2.Index] := edFIO2.Text;
  edNameChange(nil);
end;

procedure TfmSubjCard.edPHONE2Change(Sender: TObject);
begin
  if InScroll then Exit;
  dxtInfo.FocusedNode.Strings[colPHONE2.Index] := edPHONE2.Text;
  edNameChange(nil);
end;

end.

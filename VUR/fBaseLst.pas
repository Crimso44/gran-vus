unit fBaseLst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Contnrs, dxCntner, dxTL, dxDBCtrl, dxDBGrid, Db, ADODB, dxBar,
  dxBarDBNav, Variants, dxExEdtr, dxDBTLCl, dxGrClms, ActnList,
  cxClasses, dxSkinsCore, dxSkinsDefaultPainters, dxSkinsdxBarPainter,
  System.Actions;

type
  TLuData = class
    query: TDataSet;
    fldFrom: String;
    fldFilter: String;
  end;


type
  TfmBaseLst = class(TForm)
    StatBar: TStatusBar;
    qrTblData: TADOQuery;
    qrFldData: TADOQuery;
    dxBarDBNavigator1: TdxBarDBNavigator;
    dxBarManager1: TdxBarManager;
    dxBarDBNavFirst1: TdxBarDBNavButton;
    dxBarDBNavPrev1: TdxBarDBNavButton;
    dxBarDBNavNext1: TdxBarDBNavButton;
    dxBarDBNavLast1: TdxBarDBNavButton;
    dxBarDBNavInsert1: TdxBarDBNavButton;
    dxBarDBNavDelete1: TdxBarDBNavButton;
    dxBarDBNavEdit1: TdxBarDBNavButton;
    dxBarDBNavPost1: TdxBarDBNavButton;
    dxBarDBNavCancel1: TdxBarDBNavButton;
    qrData: TADOQuery;
    dsData: TDataSource;
    dbgData: TdxDBGrid;
    TmpFields: TADOQuery;
    ActionList: TActionList;
    actExcel: TAction;
    dxBarButton1: TdxBarButton;
    dbgDataNum: TdxDBGridColumn;
    bMoveUp: TdxBarButton;
    bMoveDown: TdxBarButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrDataBeforePost(DataSet: TDataSet);
    procedure qrDataBeforeDelete(DataSet: TDataSet);
    procedure dbgDataChangedColumnsWidth(Sender: TObject);
    procedure dbgDataEditing(Sender: TObject; Node: TdxTreeListNode;
      var Allow: Boolean);
    procedure dsDataDataChange(Sender: TObject; Field: TField);
    procedure actExcelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbgDataNumGetText(Sender: TObject; ANode: TdxTreeListNode;
      var AText: string);
    procedure dbgDataColumnSorting(Sender: TObject; Column: TdxDBTreeListColumn;
      var Allow: Boolean);
    procedure bMoveUpClick(Sender: TObject);
    procedure bMoveDownClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    LstIndex: Integer;
    HandSort: String;
    need_confirm: Boolean;
    LUDatas: TObjectList;
    LUDataSets: TObjectList;
    LUColumns: TObjectList;
    validators: TStringList;
    checkState: TdxCheckBoxState;
    procedure AssignLstData;
    procedure OnPopup(Sender: TObject);
    procedure DoValidate(Sender: TObject; var ErrorText: string; var Accept: Boolean);
    procedure CheckColumnToggleClick(Sender: TObject; const Text: String; State: TdxCheckBoxState);
    function GetFullTrim(s: String): String;
    procedure GetText(Sender: TObject; ANode: TdxTreeListNode; var AText: string);
  end;


  procedure EditBaseLst(index: Integer);
  procedure EditBaseLstModal(index: Integer);

implementation

uses dMain, msg, StrUtils;

{$R *.DFM}


procedure TfmBaseLst.CheckColumnToggleClick(
  Sender: TObject;
  const Text: String;
  State: TdxCheckBoxState);
begin
  checkState := State;
end;

procedure EditBaseLst(index: Integer);
var fmBaseLst: TfmBaseLst;
    i: Integer;
begin
  fmBaseLst := nil;
  for i:=0 to Application.ComponentCount-1 do
    if Application.Components[i] is TfmBaseLst then
      if (Application.Components[i] as TfmBaseLst).LstIndex=index then begin
        fmBaseLst := Application.Components[i] as TfmBaseLst;
        break;
      end;
  if fmBaseLst=nil then begin
    Application.CreateForm(TfmBaseLst,fmBaseLst);
    fmBaseLst.FormStyle := fsMDIChild;
    fmBaseLst.LstIndex := index;
    fmBaseLst.AssignLstData;
    fmBaseLst.Show;
  end;
  if IsIconic(fmBaseLst.Handle) then ShowWindow(fmBaseLst.Handle,SW_RESTORE);
  fmBaseLst.BringToFront;
end;

procedure EditBaseLstModal(index: Integer);
var i: Integer;
begin
  for i:=0 to Application.ComponentCount-1 do
  if Application.Components[i] is TfmBaseLst then
  with Application.Components[i] as TfmBaseLst do
  if LstIndex=index then begin
    Free;
    Break;
  end;

  with TfmBaseLst.Create(Application) do
  try
    LstIndex := index;
    AssignLstData;
//    FormStyle := fsNormal;
//    Visible := false;
    ShowModal;
  finally Free;
  end;
end;

procedure CopyDataSetFields(Source, Destination : TDataSet);
var
  AField : TField;
  i : Integer;
begin
  if (Source = nil) or (Destination = nil) or (Source.FieldCount = 0) then exit;
  Destination.Close;
  while Destination.FieldCount > 1 do
    Destination.Fields[Destination.FieldCount - 1].Free;

  for i := 0 to Source.FieldCount - 1 do begin
    AField := DefaultFieldClasses[Source.Fields[i].DataType].Create(Destination);
    with  Source.Fields[i] do
    begin
      AField.Name := Destination.Name + FieldName;
      AField.DisplayLabel := Source.Fields[i].DisplayLabel;
      AField.DisplayWidth := Source.Fields[i].DisplayWidth;
      AField.EditMask := Source.Fields[i].EditMask;
      AField.FieldName := FieldName;
      if AField is TStringField then
        TStringField(AField).Size := Size;
      if AField is TBlobField then
        TBlobField(AField).Size := Size;
      if AField is TFloatField then begin
        TFloatField(AField).Currency  := TFloatField(Source.Fields[i]).Currency;
        TFloatField(AField).Precision := TFloatField(Source.Fields[i]).Precision;
      end;
      AField.DataSet    := Destination;
      AField.Calculated := Calculated;
      AField.Lookup     := Lookup;
      if Lookup then
      begin
        AField.KeyFields         := KeyFields;
        AField.LookupDataSet     := LookupDataSet;
        AField.LookupKeyFields   := LookupKeyFields;
        AField.LookupResultField := LookupResultField;
      end;
    end;
  end;
end;

procedure TfmBaseLst.AssignLstData;
//
  procedure ProcessLookUp;
  var
    S          : String;
    N          : Integer;
    LU_DataSet : TADOQuery;
    NAME_LU    : String;
    fld: TStringField;
  begin
    S := StringReplace(qrFldData.FieldByName('DEF_VALUE').AsString, '"', '''', [rfReplaceAll]);
    N := Pos('{LU:',S);
    if N = 0 then Exit;

    NAME_LU := qrFldData.FieldByName('FLD_NAME').AsString+'_LU';
    S := Copy(S,N+4, Length(S));
    S := LeftStr(S, Pos('}',S)-1);
    LU_DataSet := TADOQuery.Create(Self); //Will disposed on form's dispose
    LUDataSets.Add(LU_DataSet);
    with LU_DataSet do begin
      Name       := 'qr'+NAME_LU;
      Connection := dmMain.dbMain;
      ParamCheck := False;
      SQL.Text   := S;
      Open;
    end;
    fld := TStringField.Create(TmpFields);
    with fld do begin
      Name              := TmpFields.Name + NAME_LU;
      DisplayLabel      := qrFldData.FieldByName('DISP_NAME').AsString;
      DisplayWidth      := LU_DataSet.Fields[1].DisplayWidth;
      FieldName         := NAME_LU;
      Size              := LU_DataSet.Fields[1].Size;
      DataSet           := TmpFields;
      Lookup            := True;
      KeyFields         := qrFldData.FieldByName('FLD_NAME').AsString;
      LookupDataSet     := LU_DataSet;
      LookupKeyFields   := LU_DataSet.Fields[0].FieldName;
      LookupResultField := LU_DataSet.Fields[1].FieldName;
    end;
  end;
//
var
  col, colLu: TdxDBTreeListColumn;
  maskCol: TdxDBGridMaskColumn;
  len, i: Integer;
  ss, sn, def_value: String;
  dd: TLuData;
  lc: TdxDBTreeListLookupColumn;
begin
  Self.Name := 'fmBaseLst'+IntToStr(LstIndex);
  if FormStyle<>fsMDIChild then begin
    Self.Name := Self.Name+'_Modal';
    Self.BorderIcons := Self.BorderIcons - [biMinimize,biMaximize];
  end;
  try
    qrTblData.Close;
    qrTblData.Parameters.ParamByName('KL_ID').Value := LstIndex;
    qrTblData.Open;
    HandSort := qrTblData.FieldByName('HandSort').AsString;
    qrFldData.Close;
    qrFldData.Parameters.ParamByName('KL_ID').Value := LstIndex;
    qrFldData.Open;
    Caption := 'Базовые справочники: '+qrTblData.FieldByName('DISP_NAME').AsString;
    qrData.Close;
    qrData.SQL.Text := 'SELECT * FROM '+qrTblData.FieldByName('KL_NAME').AsString;
    if qrFldData.Locate('IS_KEY',1,[]) then begin
      dbgData.KeyField := qrFldData.FieldByName('FLD_NAME').AsString;
//      qrData.SQL.Add('ORDER BY '+dbgData.KeyField);
    end;
    if (qrTblData.FieldByName('IS_EDIT').AsInteger=0) or not dmMain.rEdit then qrData.LockType := ltReadOnly;
    //BO Add lookup fields
    qrData.Open; //Get query fields
    CopyDataSetFields(qrData,TmpFields);
    qrFldData.First;
    while not qrFldData.EOF do begin
      ProcessLookUp;
      qrFldData.Next;
    end;
    CopyDataSetFields(TmpFields, qrData);
    //EO Add lookup fields
    qrData.Open;
    qrFldData.First;
    len := 0;
    while not qrFldData.EOF do begin

      def_value := StringReplace(qrFldData.FieldByName('DEF_VALUE').AsString, '"', '''', [rfReplaceAll]);

      i := Pos('{Type:',def_value);
      ss := '';
      if i > 0 then begin
        ss := Copy(def_value, i+6, MaxInt);
        i := Pos('}', ss);
        ss := Copy(ss, 1, i-1);
      end;
      if ss = 'OKVED' then begin
        col := dbgData.CreateColumn(TdxDBGridMaskColumn);
        maskCol := TdxDBGridMaskColumn(col);
        maskCOl.EditMask := '!00.99.99;1; ';

        maskCol.OnSetFieldText := GetText;
        maskCol.OnGetFieldText := GetText;

      end else
        col := dbgData.CreateColumn(
          dbgData.GetDefaultFieldColumnClass(
            qrData.FieldByName(
              qrFldData.FieldByName('FLD_NAME').AsString)));
      with col do
      begin
        FieldName     := qrFldData.FieldByName('FLD_NAME').AsString;
        Caption       := qrFldData.FieldByName('DISP_NAME').AsString;
        if Length(Caption) > len then len := Length(Caption);
        Width         := qrFldData.FieldByName('DISP_SIZE').AsInteger;
        if Pos('{LU:',def_value)>0 then begin
          colLu := dbgData.CreateColumn(
            dbgData.GetDefaultFieldColumnClass(
              qrData.FieldByName(
                qrFldData.FieldByName('FLD_NAME').AsString+'_LU')));
          with colLu do begin
            lc := TdxDBTreeListLookupColumn(colLu);
            lc.DropDownRows := 20;
            lc.DropDownWidth := 350;
            LUColumns.Add(lc);
            i := Pos('{FLT:',def_value);
            if i > 0 then begin
              ss := Copy(def_value, i+5, MaxInt);
              i := Pos('}', ss);
              ss := Copy(ss, 1, i-1);
              i := Pos(',', ss);

              dd := TLuData.Create;
              dd.fldFrom := Copy(ss, 1, i-1);
              dd.fldFilter := Copy(ss, i+1, MaxInt);

              sn := 'qr'+qrFldData.FieldByName('FLD_NAME').AsString+'_LU';
              for i := 0 to LUDataSets.Count - 1 do
                if TDataSet(LUDataSets[i]).Name = sn then begin
                  dd.query := TDataSet(LUDataSets[i]);
                  break;
                end;

              lc.OnEditButtonClick := OnPopup;

              LUDatas.Add(dd);
              Tag := Integer(dd);
            end;
            FieldName := qrFldData.FieldByName('FLD_NAME').AsString+'_LU';
            Width     := qrFldData.FieldByName('DISP_SIZE').AsInteger;
            if qrFldData.FieldByName('HAS_NULL').AsString = '1' then
              lc.ClearKey := Vk_Delete;
          end;
        end;
        Visible       := qrFldData.FieldByName('VISIBLE').AsInteger=1;
        DisableEditor := qrFldData.FieldByName('IS_EDIT').AsInteger<>1;
        if DisableEditor then Color := clSilver;
        if (FieldName=dbgData.KeyField) and (HandSort='') then Sorted := csUp;
        HeaderAlignment := taCenter;
      end;
      if col is TdxDBGridCheckColumn then begin
        TdxDBGridCheckColumn(col).ValueChecked := '1';
        TdxDBGridCheckColumn(col).ValueUnChecked := '0';
      end;
      i := Pos('{Valid:',def_value);
      if i > 0 then begin
        ss := Copy(def_value, i+7, MaxInt);
        i := Pos('}', ss);
        ss := Copy(ss, 1, i-1);

        validators.Add(ss);
        col.Tag := validators.Count - 1;
        col.OnValidate := DoValidate;
        if col is TdxDBGridCheckColumn then
          TdxDBGridCheckColumn(col).OnToggleClick := CheckColumnToggleClick;
      end;

      qrFldData.Next;
    end;

    if HandSort <> '' then begin
      col := dbgData.CreateColumn(TdxDBGridColumn);
      with col do
      begin
        FieldName     := HandSort;
        Caption       := 'Сортировка';
        Visible       := False;
        Sorted := csUp;
      end;
      //dbgData.OptionsBehavior := dbgData.OptionsBehavior - [edgoAutoSort];
      bMoveUp.Visible := ivAlways;
      bMoveDown.Visible := ivAlways;
    end;

    if len > 25 then begin
      dbgData.HeaderMinRowCount := len div 25 + 1;
    end;
    if (qrTblData.FieldByName('IS_EDIT').AsInteger=0) then begin
      dsData.AutoEdit := false;
      dbgData.OptionsBehavior := dbgData.OptionsBehavior - [edgoEditing];
      StatBar.SimpleText := 'Только просмотр';
    end;
    if qrTblData.FieldByName('IS_EDIT').AsInteger<0 then begin
      dbgData.OptionsDB := dbgData.OptionsDB - [edgoCanDelete, edgoCanInsert];
      StatBar.SimpleText := 'Только исправление';
    end;
    dbgDataChangedColumnsWidth(dbgData);
  except on e: Exception do begin
    ShowErr('Ошибка при загрузке сведений о справочнике!'#13#13+E.Message);
  end end;
end;

function TfmBaseLst.GetFullTrim(s: String): String;
begin
  Result := Trim(s);
  while (Result <> '') and (Copy(Result, Length(Result), 1) = '.') do begin
    Result := Trim(Copy(Result, 1, Length(Result)-1));
  end;
end;



procedure TfmBaseLst.GetText(Sender: TObject; ANode: TdxTreeListNode;
  var AText: string);
begin
  AText := GetFullTrim(AText);
end;

procedure TfmBaseLst.bMoveDownClick(Sender: TObject);
var
  nn, nnx: Integer;
  n, nx: TdxTreeListNode;
  col: TdxDBTreeListColumn;
begin
  col := dbgData.FindColumnByFieldName(HandSort);
  col.Sorted := csUp;
  n := dbgData.FocusedNode;
  nn := n.Values[col.Index];
  nx := n.GetNext;
  if Assigned(nx) then begin
    nnx := nx.Values[col.Index];
    with qrData do begin
      DisableControls;
      need_confirm := False;
      Locate(HandSort, nn, []);
      Edit;
      FieldByName(HandSort).AsInteger := -1;
      Post;
      Locate(HandSort, nnx, []);
      Edit;
      FieldByName(HandSort).AsInteger := nn;
      Post;
      Locate(HandSort, -1, []);
      Edit;
      FieldByName(HandSort).AsInteger := nnx;
      Post;
      need_confirm := True;
      EnableControls;
      Close;
      Open;
      Locate(HandSort, nnx, []);
      dbgData.Refresh;
    end;
  end;
end;

procedure TfmBaseLst.bMoveUpClick(Sender: TObject);
var
  nn, nnx: Integer;
  n, nx: TdxTreeListNode;
  col: TdxDBTreeListColumn;
begin
  col := dbgData.FindColumnByFieldName(HandSort);
  col.Sorted := csUp;
  n := dbgData.FocusedNode;
  nn := n.Values[col.Index];
  nx := n.GetPrev;
  if Assigned(nx) then begin
    nnx := nx.Values[col.Index];
    with qrData do begin
      DisableControls;
      need_confirm := False;
      Locate(HandSort, nn, []);
      Edit;
      FieldByName(HandSort).AsInteger := -1;
      Post;
      Locate(HandSort, nnx, []);
      Edit;
      FieldByName(HandSort).AsInteger := nn;
      Post;
      Locate(HandSort, -1, []);
      Edit;
      FieldByName(HandSort).AsInteger := nnx;
      Post;
      need_confirm := True;
      EnableControls;
      Close;
      Open;
      Locate(HandSort, nnx, []);
      dbgData.Refresh;
    end;
  end;
end;

procedure TfmBaseLst.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LUDatas.Free;
  LUDataSets.Free;
  LUColumns.Free;
  validators.Free;
  Action := caFree;
end;

procedure TfmBaseLst.qrDataBeforePost(DataSet: TDataSet);
var s, def_value: string;
    n: Integer;
    fld: TField;
    fAbort: boolean;
begin
  if (qrData.State = dsEdit) and need_confirm and
      not Confirm('Сохранить изменения данных?')
  then Abort;

  fAbort := false;
  qrFldData.First;
  while not qrFldData.EOF do begin
    fld := qrData.FieldByName(qrFldData.FieldByName('FLD_NAME').AsString);
    if not fld.IsNull and (fld.AsString=EmptyStr) then fld.Value := NULL;
    if not fld.IsNull then
      fld.AsString := Trim(fld.AsString);
    if fld.IsNull then
      if qrFldData.FieldByName('HAS_NULL').AsString<>'1' then begin
        s := StringReplace(qrFldData.FieldByName('DEF_VALUE').AsString, '"', '''', [rfReplaceAll]);
        n := Pos('{SQL:',s);
        if n>0 then begin
          s := Copy(s,n+5,Length(s));
          n := Pos('}',s);
          if n=0 then n := Length(s)+1;
          s := Copy(s,1,n-1);
          with TADOQuery.Create(Self) do begin
            Connection := dmMain.dbMain;
            SQL.Text := s;
            Open;
            if not IsEmpty then
              fld.Value := Fields[0].Value;
            Free;
          end;
        end;
        if fld.IsNull then begin
          s := StringReplace(qrFldData.FieldByName('DEF_VALUE').AsString, '"', '''', [rfReplaceAll]);
          n := Pos('{TXT:',s);
          if n>0 then begin
            s := Copy(s,n+5,Length(s));
            n := Pos('}',s);
            if n=0 then n := Length(s)+1;
            s := Copy(s,1,n-1);
            if s<>EmptyStr then fld.Value := s;
          end
        end;
        if fld.IsNull then begin
          if fld.DataType in [ftBoolean] then
            fld.Value := False;
        end;
        fAbort := fld.IsNull;
      end;
    if fAbort then break;
    def_value := StringReplace(qrFldData.FieldByName('DEF_VALUE').AsString, '"', '''', [rfReplaceAll]);
    if POS('{KODTERR}',def_value)>0 then begin
      s := fld.AsString;
      case (Length(S)-2) mod 3 of
        1: s := s+'00';
        2: s := s+'0';
      end;
      if Length(s)<11 then s := s+StringOfChar('0',11-Length(s));
      fld.AsString := s;
    end;
    qrFldData.Next;
  end;
  if fAbort then begin
    ShowErr('Не указано обязательное значение для поля "'+
      qrFldData.FieldByName('DISP_NAME').AsString+'"!');
    Abort;
  end;

  if (HandSort <> '') and (qrData.FieldByName(HandSort).IsNull) then begin
    with TADOQuery.Create(Self) do begin
      Connection := dmMain.dbMain;
      SQL.Text := 'Select Max('+HandSort+') From '+qrTblData.FieldByName('KL_NAME').AsString;
      Open;
      if not Eof then
        qrData.FieldByName(HandSort).AsInteger := Fields[0].AsInteger + 1
      else
        qrData.FieldByName(HandSort).AsInteger := 1;
      Free;
    end;
  end;
end;

procedure TfmBaseLst.qrDataBeforeDelete(DataSet: TDataSet);
var s: string;
    n: Integer;
begin
  s := qrTblData.FieldByName('CHK_DEL').AsString;
  if s<>EmptyStr then
    with TADOQuery.Create(Self) do begin
      Connection := dmMain.dbMain;
      SQL.Text := s;
      Parameters.ParseSQL(SQL.Text,true);
      for n:=0 to Parameters.Count-1 do
        if UpperCase(Parameters[n].Name)='ID' then begin
          Parameters[n].Value := qrData.FieldByName(dbgData.KeyField).Value;
          Parameters[n].DataType := qrData.FieldByName(dbgData.KeyField).DataType;
        end;
      Open;
      First;
      n := 0;
      while not EOF do begin
        Inc(n,Fields[0].AsInteger);
        Next;
      end;
      Free;
      if n>0 then begin
        ShowInfo('Невозможно удалить выбранную запись, т.к. на нее присутствуют ссылки!');
        Abort;
      end;
    end;
  if not Confirm('Удалить выбранную запись?') then Abort;
end;

procedure TfmBaseLst.dbgDataChangedColumnsWidth(Sender: TObject);
var
  def_value: String;
  i: Integer;
  col: TdxDBTreeListLookupColumn;
begin
  qrFldData.First;
  while not qrFldData.EOF do begin
    qrFldData.Edit;
    def_value := StringReplace(qrFldData.FieldByName('DEF_VALUE').AsString, '"', '''', [rfReplaceAll]);
    if Pos('{LU:', def_value)=0
      then qrFldData.FieldByName('DISP_SIZE').AsInteger :=
        dbgData.ColumnByFieldName(qrFldData.FieldByName('FLD_NAME').AsString).Width
      else qrFldData.FieldByName('DISP_SIZE').AsInteger :=
        dbgData.ColumnByFieldName(qrFldData.FieldByName('FLD_NAME').AsString+'_LU').Width;
    qrFldData.Post;
    qrFldData.Next;
  end;
  for i := 0 to LUColumns.Count - 1 do begin
    col := LUColumns[i] as TdxDBTreeListLookupColumn;
    col.DropDownWidth := col.Width * 2;
  end;
end;

procedure TfmBaseLst.dbgDataColumnSorting(Sender: TObject;
  Column: TdxDBTreeListColumn; var Allow: Boolean);
begin
  Allow := Column <> dbgDataNum;
end;

procedure TfmBaseLst.dbgDataEditing(Sender: TObject; Node: TdxTreeListNode;
  var Allow: Boolean);
begin
  Allow := not qrFldData.Locate('IS_KEY',1,[]);
  if not Allow then
    Allow := (qrData.State=dsInsert) or
      (dbgData.ColumnByFieldName(qrFldData.FieldByName('FLD_NAME').AsString)<>
       dbgData.VisibleColumns[dbgData.FocusedColumn]);
end;

procedure TfmBaseLst.dbgDataNumGetText(Sender: TObject; ANode: TdxTreeListNode;
  var AText: string);
begin
  AText := IntToStr(ANode.Index + 1);
end;

procedure TfmBaseLst.DoValidate(Sender: TObject; var ErrorText: string;
  var Accept: Boolean);
var
  s, sId, sTag: string;
  col: TdxDBGridCheckColumn;
  tCol: TdxDBTreeListColumn;
begin
  sTag := validators[TdxTreeListColumn(Sender).Tag];
  if sTag = 'isDepValid' then begin
    col := TdxDBGridCheckColumn(Sender);
    if (checkState = cbsChecked) and (qrData.FieldByName('Dep_Id').AsString <> '') then begin
      with TADOQuery.Create(Self) do begin
        Connection := dmMain.dbMain;
        SQL.Text :=
          'select 1 from Person '+
          'Inner Join Appointment on Person.AppLastAll = Appointment.Id '+
          'Where '+
            '(Out_Date is null or Out_Date > Date()) and '+
            '(Dismissal_Date is null or Dismissal_Date > Date()) and '+
            'Appointment.Dep_Id = ' + qrData.FieldByName('Dep_Id').AsString;
        Open;
        if not IsEmpty then begin
          Accept := false;
          ErrorText := 'В этом подразделении имеются не уволенные работники';
        end;
        Free;
      end;
    end;
  end else if sTag = 'isPostValid' then begin
    col := TdxDBGridCheckColumn(Sender);
    if (checkState = cbsChecked) and (qrData.FieldByName('Post_Id').AsString <> '') then begin
      with TADOQuery.Create(Self) do begin
        Connection := dmMain.dbMain;
        SQL.Text :=
          'select 1 from Person '+
          'Inner Join Appointment on Person.AppLastAll = Appointment.Id '+
          'Where '+
            '(Out_Date is null or Out_Date > Date()) and '+
            '(Dismissal_Date is null or Dismissal_Date > Date()) and '+
            'Appointment.Post_Id = ' + qrData.FieldByName('Post_Id').AsString;
        Open;
        if not IsEmpty then begin
          Accept := false;
          ErrorText := 'На этой должности имеются не уволенные работники';
        end;
        Free;
      end;
    end;
  end else if sTag = 'OKPDTR' then begin
    s := dbgData.EditingText;
    with TADOQuery.Create(Self) do begin
      Connection := dmMain.dbMain;
      sId := qrData.FieldByName('KOKPDTR_Id').AsString;
      if sId = '' then sId := '-1';
      SQL.Text :=
        'select 1 from KOKPDTR '+
        'Where KOKPDTR_Code = :KOKPDTR and KOKPDTR_Id <> ' + sId;
      Parameters.ParamByName('KOKPDTR').Value := s;
      Open;
      if not IsEmpty then begin
        Accept := false;
        ErrorText := 'Такое значение ОКПДТР уже введено';
      end;
      Free;
    end;
  end;
end;

procedure TfmBaseLst.dsDataDataChange(Sender: TObject; Field: TField);
begin
  if qrTblData.FieldByName('IS_EDIT').AsInteger<0 then begin
    dxBarDBNavDelete1.Enabled := False;
    dxBarDBNavInsert1.Enabled := False;
  end;
end;

procedure TfmBaseLst.actExcelExecute(Sender: TObject);
begin
  dmMain.GridToExcel(dbgData,Caption,true,true);
end;

procedure TfmBaseLst.OnPopup(Sender: TObject);
var
  col: TdxDBTreeListLookupColumn;
  dd: TLuData;
  fld: TField;
begin
  col := Sender as TdxDBTreeListLookupColumn;
  dd := TLuData(col.Tag);
  if col.Field.DataSet.FieldByName(dd.fldFrom).IsNull then begin
    dd.query.Filtered := False;
  end else begin
    dd.query.Filter := dd.fldFilter+'='+col.Field.DataSet.FieldByName(dd.fldFrom).AsString;
    dd.query.Filtered := True;
  end;
end;

procedure TfmBaseLst.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if qrData.State in [dsEdit, dsInsert] then CanClose := Confirm(
    'Текущая запись не сохранена. Выйти без сохранения?'); 
end;

procedure TfmBaseLst.FormCreate(Sender: TObject);
begin
  need_confirm := True;
  LUDatas := TObjectList.Create;
  LUDataSets := TObjectList.Create;
  LUColumns := TObjectList.Create;
  validators := TStringList.Create;
end;

end.


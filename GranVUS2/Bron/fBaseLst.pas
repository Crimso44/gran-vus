unit fBaseLst;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, dxCntner, dxTL, dxDBCtrl, dxDBGrid, Db, ADODB, dxBar,
  dxBarDBNav, dxExEdtr, Variants, cxClasses, dxGrClms;

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
    dxBarExcel: TdxBarButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrDataBeforePost(DataSet: TDataSet);
    procedure qrDataBeforeDelete(DataSet: TDataSet);
    procedure dbgDataChangedColumnsWidth(Sender: TObject);
    procedure dbgDataEditing(Sender: TObject; Node: TdxTreeListNode;
      var Allow: Boolean);
    procedure dxBarExcelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LstIndex: Integer;

    procedure AssignLstData;
  end;


  procedure EditBaseLst(index: Integer);
  procedure EditBaseLstModal(const VocName: String);

implementation

uses dMain, msg, fMain;

{$R *.DFM}

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
    if fmMain.MainScale <> 100 then
      fmBaseLst.ScaleBy(fmMain.MainScale, 100);
    fmBaseLst.LstIndex := index;
    fmBaseLst.FormStyle := fsMDIChild;
    fmBaseLst.AssignLstData;
    fmBaseLst.Show;
  end;
  if IsIconic(fmBaseLst.Handle) then ShowWindow(fmBaseLst.Handle,SW_RESTORE);
  fmBaseLst.BringToFront;
end;

procedure EditBaseLstModal(const VocName: String);
var
  i, index: Integer;
begin
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'select [KL_ID] from [KL_DATA] where [KL_NAME]='+QuotedStr(VocName);
    Open;
    index := Fields[0].AsInteger;
  finally Free;
  end;
  if index=0 then raise Exception.Create('Не найден словарь '+QuotedStr(VocName));
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

procedure TfmBaseLst.AssignLstData;
var
  col: TdxDBTreeListColumn;
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
    qrFldData.Close;
    qrFldData.Parameters.ParamByName('KL_ID').Value := LstIndex;
    qrFldData.Open;
    Caption := 'Базовые справочники: '+qrTblData.FieldByName('DISP_NAME').AsString;
    qrData.Close;
    qrData.SQL.Text := 'SELECT * FROM '+qrTblData.FieldByName('KL_NAME').AsString;
    if qrFldData.Locate('IS_KEY',1,[]) then
      dbgData.KeyField := qrFldData.FieldByName('FLD_NAME').AsString;
    if qrTblData.FieldByName('IS_EDIT').AsInteger=0 then qrData.LockType := ltReadOnly;
    qrData.Open;
    qrFldData.First;
    while not qrFldData.EOF do begin
      //col := dbgData.ColumnByFieldName(qrFldData.FieldByName('FLD_NAME').AsString);
      col := dbgData.CreateColumn(
        dbgData.GetDefaultFieldColumnClass(
          qrData.FieldByName(
            qrFldData.FieldByName('FLD_NAME').AsString)));
      with col do
      begin
        FieldName     := qrFldData.FieldByName('FLD_NAME').AsString;
        Caption := qrFldData.FieldByName('DISP_NAME').AsString;
        Width := qrFldData.FieldByName('DISP_SIZE').AsInteger;
        Visible := qrFldData.FieldByName('VISIBLE').AsInteger=1;
        DisableEditor := qrFldData.FieldByName('IS_EDIT').AsInteger<>1;
      end;
      if col is TdxDBGridCheckColumn then begin
        TdxDBGridCheckColumn(col).ValueChecked := '1';
        TdxDBGridCheckColumn(col).ValueUnChecked := '0';
      end;

      qrFldData.Next;
    end;
    if qrTblData.FieldByName('IS_EDIT').AsInteger=0 then begin
      dsData.AutoEdit := false;
      dbgData.OptionsBehavior := dbgData.OptionsBehavior - [edgoEditing];
      StatBar.SimpleText := 'Только просмотр';
    end;
  except
    ShowErr('Ошибка при загрузке сведений о справочнике!');
  end;
end;

procedure TfmBaseLst.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmBaseLst.qrDataBeforePost(DataSet: TDataSet);
var s: string;
    n: Integer;
    fld: TField;
    fAbort: boolean;
begin
  if qrData.State = dsEdit then
    if not Confirm('Сохранить изменения данных?') then begin
      qrData.Cancel;
      Abort;
      Exit;
    end;
  fAbort := false;
  qrFldData.First;
  while not qrFldData.EOF do begin
    fld := qrData.FieldByName(qrFldData.FieldByName('FLD_NAME').AsString);
    if not fld.IsNull and (fld.AsString=EmptyStr) then fld.Value := NULL;
    if fld.IsNull then
      if qrFldData.FieldByName('HAS_NULL').AsString<>'1' then begin
        s := qrFldData.FieldByName('DEF_VALUE').AsString;
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
          s := qrFldData.FieldByName('DEF_VALUE').AsString;
          n := Pos('{TXT:',s);
          if n>0 then begin
            s := Copy(s,n+5,Length(s));
            n := Pos('}',s);
            if n=0 then n := Length(s)+1;
            s := Copy(s,1,n-1);
            if s<>EmptyStr then fld.Value := s;
          end
        end;
        fAbort := fld.IsNull;
      end;
    if fAbort then break;
    if POS('{KODTERR}',qrFldData.FieldByName('DEF_VALUE').AsString)>0 then begin
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
      if Parameters.ParamByName('ID')<>nil then
        Parameters.ParamByName('ID').Value := qrData.FieldByName(dbgData.KeyField).Value;
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
begin
  qrFldData.First;
  while not qrFldData.EOF do begin
    qrFldData.Edit;
    qrFldData.FieldByName('DISP_SIZE').AsInteger :=
      dbgData.ColumnByFieldName(qrFldData.FieldByName('FLD_NAME').AsString).Width;
    qrFldData.Post;
    qrFldData.Next;
  end;
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

procedure TfmBaseLst.dxBarExcelClick(Sender: TObject);
begin
  dmMain.GridToExcel(dbgData,Caption,false,true);
end;

end.

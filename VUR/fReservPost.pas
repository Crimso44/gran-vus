unit fReservPost;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FrmKeep, dxCntner, dxTL, dxBar, ComCtrls, Db, ADODB, dxTLClms, ActnList,dxExEdtr,
  StdCtrls, Variants;

type
  TfmReservPost = class(TForm)
    StatusBar1: TStatusBar;
    dxBarManager1: TdxBarManager;
    dxtData: TdxTreeList;
    FrmKeep1: TFrmKeep;
    qrData: TADOQuery;
    dxtDataColumn1: TdxTreeListColumn;
    ActionList1: TActionList;
    actStrore: TAction;
    actClose: TAction;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actStroreExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    fChanged : boolean;
    procedure LoadData;
    procedure OnToggleClick(Sender: TObject;
      const Text: String; State: TdxCheckBoxState);
  public
    { Public declarations }
  end;


  procedure ShowReservList;

implementation

uses dMain, msg;

{$R *.DFM}

var
  fmReservPost: TfmReservPost;

procedure ShowReservList;
begin
  if fmReservPost=nil then begin
    Application.CreateForm(TfmReservPost,fmReservPost);
    fmReservPost.LoadData;
  end;
  if IsIconic(fmReservPost.Handle) then
    ShowWindow(fmReservPost.Handle,SW_RESTORE);
end;

procedure TfmReservPost.LoadData;
var i: Integer;
begin
  qrData.Open;
  with TADOQuery.Create(Self) do begin
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT * FROM KDEPART ORDER BY DEP_NAME';
    Open;
    while not EOF do begin
      with dxtData.CreateColumn(TdxTreeListCheckColumn) as  TdxTreeListCheckColumn do begin
        BandIndex := 1;
        ValueChecked := '1';
        ValueUnchecked := '0';
        Width := 85;
        Caption := FieldByName('DEP_NAME').AsString;
        Tag := FieldByName('DEP_ID').AsInteger;
        OnToggleClick := Self.OnToggleClick;
      end;
      Next;
    end;
//check deleted departments
    qrData.First;
    while not qrData.EOF do begin
      if not Locate('DEP_ID',qrData.FieldByName('DEP_ID').Value,[]) then
        qrData.Delete
      else
        qrData.Next;
    end;
    Free;
  end;
  with TADOQuery.Create(Self) do begin
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT * FROM KPOST ORDER BY POST_NAME';
    Open;
    while not EOF do begin
      with dxtData.Add do begin
        Data := Pointer(FieldByName('POST_ID').AsInteger);
        Strings[0] := FieldByName('POST_NAME').AsString;
        for i:=1 to dxtData.ColumnCount-1 do
          if qrData.Locate('POST_ID;DEP_ID',
            VarArrayOf([FieldByName('POST_ID').AsInteger,dxtData.Columns[i].Tag]),[])
          then
            Strings[i] := '1'
          else
            Strings[i] := '0';
      end;
      Next;
    end;
//check deleted posts
    qrData.First;
    while not qrData.EOF do begin
      if not Locate('POST_ID',qrData.FieldByName('POST_ID').Value,[]) then
        qrData.Delete
      else
        qrData.Next;
    end;
    Free;
  end;
  fChanged := false;
end;

procedure TfmReservPost.OnToggleClick(Sender: TObject;
  const Text: String; State: TdxCheckBoxState);
begin
  fChanged := true;
end;

procedure TfmReservPost.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := not fChanged;
  if not CanClose then
    CanClose := Confirm('Список бронируемых должностей содержит несохраненные изменения!'#13+
    'Закрыть список без сохранения данных?');
end;

procedure TfmReservPost.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  fmReservPost := nil;
end;

procedure TfmReservPost.actStroreExecute(Sender: TObject);
var i,j: Integer;
begin
//store data
  Button1.SetFocus;
  Screen.Cursor := crHourglass;
  try
    try
      dmMain.dbMain.BeginTrans;
    except
    end;
    for i:=0 to dxtData.Count-1 do
      for j:=1 to dxtData.ColumnCount-1 do
        if dxtData.Items[i].Strings[j]='1' then begin
          if not qrData.Locate('DEP_ID;POST_ID',
            VarArrayOf([dxtData.Columns[j].Tag,Integer(dxtData.Items[i].Data)]),[]) then
          begin
            qrData.Append;
            qrData.FieldByName('DEP_ID').Value := dxtData.Columns[j].Tag;
            qrData.FieldByName('POST_ID').Value := Integer(dxtData.Items[i].Data);
            qrData.Post;
          end;
        end
        else begin
          if qrData.Locate('DEP_ID;POST_ID',
            VarArrayOf([dxtData.Columns[j].Tag,Integer(dxtData.Items[i].Data)]),[])
          then qrData.Delete;
        end;
    if dmMain.dbMain.InTransaction then dmMain.dbMain.CommitTrans;
    fChanged := false;
    Screen.Cursor := crDefault;
  except
    Screen.Cursor := crDefault;
    if dmMain.dbMain.InTransaction then begin
      dmMain.dbMain.RollbackTrans;
      ShowErr('Ошибка при сохранении данных!');
    end
    else
      ShowErr('Ошибка при сохранении данных!'#13+
        'Изменения были сохранены не полностью...');
  end;
  dxtData.SetFocus;
end;

procedure TfmReservPost.actCloseExecute(Sender: TObject);
begin
  Close;
end;

initialization
  fmReservPost := nil;

end.

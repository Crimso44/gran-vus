unit fTPDPPunkt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dxExEdtr, Menus, ActnList, FrmKeep, DB,
  ADODB, dxDBTLCl, dxGrClms, dxTL, dxDBCtrl, dxDBGrid, dxCntner, ComCtrls,
  ToolWin, Buttons, dxmdaset, Mask, Grids, DBGrids, DBCtrls;

type
  TfmTPDPPunkt = class(TForm)
    Panel1: TPanel;
    paLeft: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Panel4: TPanel;
    lbPosts: TListBox;
    Panel5: TPanel;
    dsData: TDataSource;
    dbgData: TdxDBGrid;
    dbgDataWSosts: TdxDBGridMaskColumn;
    dbgDataLimited: TdxDBGridCheckColumn;
    dbgDataWRange_Name: TdxDBGridMaskColumn;
    dbgDataAge: TdxDBGridMaskColumn;
    FrmKeep1: TFrmKeep;
    ActionList: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    laPosts: TLabel;
    laCond: TLabel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Panel6: TPanel;
    Panel7: TPanel;
    pbOk: TBitBtn;
    pbCancel: TBitBtn;
    taCond: TdxMemData;
    taCondAge: TIntegerField;
    taCondWRange: TIntegerField;
    taCondWSost: TStringField;
    taCondLimited: TIntegerField;
    taCondWSosts: TStringField;
    qryKWRange: TADOQuery;
    qryKWRangeWRng_ID: TIntegerField;
    qryKWRangeWrng_Name: TStringField;
    taCondWRange_Name: TStringField;
    taCondSex: TSmallintField;
    mSex: TdxMemData;
    mSexSex: TSmallintField;
    mSexSexName: TStringField;
    dsSex: TDataSource;
    taCondSexName: TStringField;
    dbgDataSexName: TdxDBGridLookupColumn;
    edOKPDTR: TEdit;
    edOkved: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edOKPDTRName: TEdit;
    lWarning: TLabel;
    bAddOKPDTR: TSpeedButton;
    edOKVEDName: TEdit;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure pbOkClick(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edPer_NoChange(Sender: TObject);
    procedure taCondAfterPost(DataSet: TDataSet);
    procedure taCondAgeGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure dbgDataDblClick(Sender: TObject);
    procedure dbgDataCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure edOKPDTRChange(Sender: TObject);
    procedure bAddOKPDTRClick(Sender: TObject);
    procedure dbgDataChangedColumnsWidth(Sender: TObject);
    procedure edOkvedChange(Sender: TObject);
  private
    { Private declarations }
    q: TADOQuery;
    KOKPDTR : Integer;
    function StoreData: Boolean;
  public
    { Public declarations }
    procedure LoadPosts;
    function GetFullTrim(s: String): String;
  end;

procedure Edit  (ADS: TDataSet);
procedure Add   (ADS: TDataSet);
procedure Delete(ADS: TDataSet);

implementation

uses dMain, IniFiles, msg, fTPDPPost, fTPDPCond;

procedure SetLBWidth(LB: TListBox);
var
 i, MaxWidth: integer;
begin
 MaxWidth := 0;
 for i := 0 to LB.Items.Count - 1 do
 if MaxWidth < LB.Canvas.TextWidth(LB.Items.Strings[i]) then
   MaxWidth := LB.Canvas.TextWidth(LB.Items.Strings[i]);
 SendMessage(LB.Handle, LB_SETHORIZONTALEXTENT, MaxWidth+2, 0);
end;

{$R *.dfm}

type TMode = (mEdit, mAdd);
var
  FMode    : TMode;
  FDS      : TDataSet;
  FChanged : Boolean;

procedure Go(ADS: TDataSet; AMode: TMode);
begin
  FMode    := AMode;
  FDS      := ADS;
  with    TfmTPDPPunkt.Create(Application) do
  try     ShowModal;
  finally Free;
  end;
end;

procedure Edit; begin Go(ADS, mEdit) end;
procedure Add;  begin Go(ADS, mAdd)  end;

procedure Delete;
var TPDP_ID: String;
begin
  if not Confirm('Удалить текущий пункт перечня?') then Exit;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; ParamCheck := False;
    TPDP_ID := ADS.FieldByName('TPDP_ID').AsString;
    SQL.Text := 'DELETE FROM [TPDPPost] WHERE TPDP_ID = '+TPDP_ID;
    ExecSQL;
    SQL.Text := 'DELETE FROM [TPDPCond] WHERE TPDP_ID = '+TPDP_ID;
    ExecSQL;
    SQL.Text := 'DELETE FROM [TPDP] WHERE ID = '+TPDP_ID;
    ExecSQL;
  finally Free;
  end;
  ADS.Close; ADS.Open;
end;

procedure TfmTPDPPunkt.LoadPosts;
begin
  lbPosts.Items.Clear;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; ParamCheck := False;
    SQL.Text := 'SELECT POST_ID, POST_NAME FROM [KPOST] WHERE KOKPDTR = ' +
       IntToStr(KOKPDTR);
    Open;
    while not EOF do begin
      lbPosts.Items.AddObject(Fields[1].AsString, TObject(Fields[0].AsInteger));
      Next;
    end;
  finally Free;
  end;
  SetLBWidth(lbPosts);
end;

procedure TfmTPDPPunkt.FormCreate(Sender: TObject);
//
  function GetNextPunkt(APer, ARazd, APodrazd: String): String;
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain; ParamCheck := False;
      SQL.Text := Format(
        'SELECT Max(Punkt) FROM [TPDP] WHERE Per_No=%s AND Razd_No=%s AND Podrazd_No=%s',
        [QuotedStr(APer), QuotedStr(ARazd), QuotedStr(APodrazd)]);
      Open;
      Result := Fields[0].AsString;
    finally Free;
    end;
  end;
//
  procedure LoadCond;
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain; ParamCheck := False;
      SQL.Text := 'SELECT Limited, Age, WRange, WSost, WSosts, Sex FROM [TPDPCond] '+
        'WHERE TPDP_ID = '+FDS.FieldByName('TPDP_ID').AsString;
      Open;
      while not Eof do begin
        taCond.Append;
        taCondLimited .Value := FieldByName('Limited').AsInteger;
        taCondAge     .Value := FieldByName('Age').AsInteger;
        taCondWRange  .Value := FieldByName('WRange').AsInteger;
        taCondWSost   .Value := FieldByName('WSost').AsString;
        taCondWSosts  .Value := FieldByName('WSosts').AsString;
        taCondSex     .AsInteger := FieldByName('Sex').AsInteger;
        taCond.Post;
        Next;
      end;
    finally Free;
    end;
  end;
//
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'frmdata.ini') do
  try
    paLeft.Width := ReadInteger('Forms', 'fTPDPPunkt.LeftWidth', paLeft.Width);
  finally Free;
  end;

  q := TADOQuery.Create(nil);
  q.Connection := dmMain.dbMain; q.ParamCheck := False;

  mSex.Open;
  mSex.AppendRecord([0, 0, 'М и Ж']);
  mSex.AppendRecord([1, 1, 'М']);
  mSex.AppendRecord([2, 2, 'Ж']);

  taCond.Open;
  case FMode of
    mEdit: begin
      edOKVED      .Text := FDS.FieldByName('OKVED').AsString;
      edOKVEDName  .Text := FDS.FieldByName('OKVED_Name').AsString;
      edOKPDTR     .Text := FDS.FieldByName('KOKPDTR_Code').AsString;
      edOKPDTRName .Text := FDS.FieldByName('KOKPDTR_Name').AsString;
      LoadPosts;
      LoadCond;
    end;
    mAdd: begin
      if not FDS.IsEmpty then begin
      edOKVED      .Text := '';
      edOKPDTR     .Text := '';
      edOKPDTRName .Text := '';
      end
      else begin
        ActiveControl := edOkved;
      end;
    end;
  end;

  dbgDataChangedColumnsWidth(Sender);

  FChanged := False;
end;

procedure TfmTPDPPunkt.FormDestroy(Sender: TObject);
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'frmdata.ini') do
  try
    WriteInteger('Forms', 'fTPDPPunkt.LeftWidth', paLeft.Width);
  finally Free;
  end;
end;

function TfmTPDPPunkt.GetFullTrim(s: String): String;
begin
  Result := Trim(s);
  while (Result <> '') and (Copy(Result, Length(Result), 1) = '.') do begin
    Result := Trim(Copy(Result, 1, Length(Result)-1));
  end;
end;

procedure TfmTPDPPunkt.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
const
  Msg: array [TMode] of String = ('Данные были изменены.','Новая запись не сохранена.');
begin
  CanClose := not FChanged or Confirm(Msg[FMode]+#13'Выйти без сохранения?');
end;

type
  ESaveError = class(Exception)
    FCtrl: TWinControl;
    constructor CreateCtrlMsg(ACtrl: TWinControl; AMsg: String);
  end;
  constructor ESaveError.CreateCtrlMsg;
  begin
    FCtrl := ACtrl;
    inherited Create(AMsg);                     
  end;
  procedure SaveError(ACtrl: TWinControl; AMsg: String);
  begin
    raise ESaveError.CreateCtrlMsg(ACtrl, AMsg);
  end;


function TfmTPDPPunkt.StoreData;
var
  TPDP_ID : Integer;
  I       : Integer;
  s, okved: String;
  q: TADOQuery;
begin
  Result := False;
  try
    //Check it
    if Trim(edOKVED.Text)='' then SaveError(edOKVED, 'Задайте код ОКВЭД!');
    if KOKPDTR = 0 then SaveError(edOKPDTR, 'Задайте код ОКПДТР!');
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain; ParamCheck := False;
      if (FMode=mAdd) {or
         (FDS.FieldByName('Punkt').AsString<>Trim(edPunkt.Text))}
      then begin
        SQL.Text := Format(
          'SELECT * FROM [TPDP] '+
          'WHERE OKVED=%s AND KOKPDTR=%s',
          [QuotedStr(edOKVED.Text), IntToStr(KOKPDTR)]);
        Open;
        if not IsEmpty then SaveError(edOKVED, 'Данный пункт перечня уже существует!');
        Close;
      end;
    finally Free;
    end;
    if lbPosts.Count=0 then SaveError(lbPosts, 'Должен быть заполнен список профессий/дожностей!');
    if taCond.IsEmpty then SaveError(dbgData, 'Необходимо задать условия предоставления отсрочки!');
    //Store it
    dmMain.dbMain.BeginTrans;
    try
      q := TADOQuery.Create(nil);
      with q do
      try
        Connection := dmMain.dbMain; ParamCheck := False;
        if FMode = mEdit then begin
          TPDP_ID := FDS.FieldByName('TPDP_ID').AsInteger;
          SQL.Text := 'DELETE FROM [TPDPPost] WHERE TPDP_ID = '+IntToStr(TPDP_ID);
          ExecSQL;
          SQL.Text := 'DELETE FROM [TPDPCond] WHERE TPDP_ID = '+IntToStr(TPDP_ID);
          ExecSQL;
          SQL.Text := 'DELETE FROM [TPDP] WHERE ID = '+IntToStr(TPDP_ID);
          ExecSQL;
        end;
        SQL.Text := 'SELECT * FROM [TPDP]';
        Open;
        Append;
        okved := GetFullTrim(edOKVED.Text);
        FieldByName('OKVED').AsString := okved;
        FieldByName('KOKPDTR').AsInteger := KOKPDTR;
        s := StringReplace(lbPosts.Items.Text,#13#10,', ',[rfReplaceAll]);
        s := System.Copy(s, 1, Length(s)-2); //Strip last comma
        FieldByName('POSTS').AsString := Copy(s, 1, 255);
        Post;
        TPDP_ID := FieldByName('ID').AsInteger;
        Close;
        SQL.Text := 'SELECT * FROM [TPDPPost]';
        Open;
        for I := 0 to lbPosts.Count-1 do begin
          Append;
          FieldByName('TPDP_ID').AsInteger := TPDP_ID;
          FieldByName('POST_ID').AsInteger := Integer(lbPosts.Items.Objects[I]);
          Post;
        end;
        Close;
        SQL.Text := 'SELECT * FROM [TPDPCond]';
        Open;
        taCond.First;
        while not taCond.Eof do begin
          Append;
          FieldByName('TPDP_ID').AsInteger := TPDP_ID;
          FieldByName('Limited').AsInteger := taCondLimited.AsInteger;
          FieldByName('AGE').AsInteger     := taCondAge.AsInteger;
          FieldByName('WRange').Asinteger  := taCondWRange.AsInteger;
          FieldByName('WSost').AsString    := taCondWSost.AsString;
          FieldByName('WSosts').AsString   := taCondWSosts.AsString;
          FieldByName('Sex').AsInteger     := taCondSex.AsInteger;
          Post;
          taCond.Next;
        end;
        if okved <> '' then begin
          SQL.Text := 'Select * from KOKVED where code = :code';
          Parameters.ParseSQL(SQL.Text, True);
          Parameters.ParamByName('code').Value := okved;
          Open;
          if Eof then begin
            Close;
            SQL.Text := 'Select * from KOKVED';
            Open;
            Append;
            FieldByName('code').AsString := okved;
            Post;
          end;
          Close;
        end;
      finally Free;
      end;
      dmMain.dbMain.CommitTrans;
    except
      dmMain.dbMain.RollbackTrans;
      raise;
    end;
  except
    on E: ESaveError do begin
      if Assigned(E.FCtrl) then E.FCtrl.SetFocus;  ShowErr(E.Message);  Exit;
    end;
  end;
  Result := True;
  FChanged := False;
  FDS.Close; FDS.Open; FDS.Locate('TPDP_ID',TPDP_ID,[]);
end;

procedure TfmTPDPPunkt.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
//
 procedure SetShortCutByControl(A: TAction; Key: Word; Shift: TShiftState; C: TWinControl);
 begin
   if C.Focused then A.ShortCut := ShortCut(Key, Shift) else A.ShortCut := 0;
 end;
//
begin
  SetShortCutByControl(actAdd     , VK_INSERT, []      , dbgData);
  SetShortCutByControl(actEdit    , VK_RETURN, []      , dbgData);
  SetShortCutByControl(actDelete  , VK_DELETE, []      , dbgData);

  actEdit   .Enabled := not taCond.IsEmpty;
  actDelete .Enabled := not taCond.IsEmpty;
end;

procedure TfmTPDPPunkt.bAddOKPDTRClick(Sender: TObject);
var
  f: TfmTPDPPost;
  cprof, cprof2, i: Integer;
  s: String;
begin
  f := TfmTPDPPost.Create(Self);
  try
    f.edOKPDTR.Text := edOKPDTR.Text;
    f.edOKPDTRName.Text := edOKPDTRName.Text;
    if f.ShowModal = mrOk then begin
      q.SQL.Text :=
        'SELECT MAX(KOKPDTR_ID)+1 From KOKPDTR';
      q.Open;
      KOKPDTR := q.Fields[0].AsInteger;
      if KOKPDTR = 0 then KOKPDTR := 1;
      q.Close;
      q.SQL.Text :=
        'Insert Into KOKPDTR (KOKPDTR_Id, KOKPDTR_Code, KOKPDTR_Name) '+
        'Values (' + IntToStr(KOKPDTR) + ', '+
          '''' + StringReplace(Trim(f.edOKPDTR.Text),'''','''',[rfReplaceAll]) + ''', '+
          '''' + StringReplace(Trim(f.edOKPDTRName.Text),'''','''',[rfReplaceAll]) + ''') ';
      q.ExecSQL;

      cprof := Integer(f.edCprof.Items.Objects[f.edCPROF.ItemIndex]);
      cprof2 := cprof;
      if (cprof >= 200) and (cprof < 300) then
        cprof2 := 200
      else if cprof = 470 then
        cprof2 := 410
      else if(cprof >= 400) and (cprof < 500) then
        cprof2 := 400;

      if f.lbPosts.Items.Count = 0 then
        q.SQL.Text :=
          'Insert Into KPOST (POST_Id, KOKPDTR, POST_Name, CPROF_ID, CPROF2015_ID) '+
          'SELECT MAX(POST_ID)+1, '+
            IntToStr(KOKPDTR) + ', '+
            '''' + StringReplace(Trim(f.edOKPDTRName.Text),'''','''',[rfReplaceAll]) + ''', '+
            IntToStr(cprof) + ', '+ IntToStr(cprof2) + ' '+
          'FROM KPOST'
      else begin
        s := '';
        for i := 0 to f.lbPosts.Items.Count - 1 do
            s := s + IntToStr(Integer(f.lbPosts.Items.Objects[i])) + ',';
        s := Copy(s, 1, Length(s)-1);
        q.SQL.Text :=
          'Update KPOST '+
          'Set KOKPDTR = ' + IntToStr(KOKPDTR) + ' '+
          'Where Post_Id in (' + s + ')';
      end;
      q.ExecSQL;
      edOKPDTRChange(Self);
    end;
  finally
    f.Free;
  end;
end;

procedure TfmTPDPPunkt.pbOkClick(Sender: TObject);
begin
  if StoreData then Close;
end;

procedure TfmTPDPPunkt.actAddExecute(Sender: TObject);
begin
  fTPDPCond.Add(taCond);
end;

procedure TfmTPDPPunkt.actEditExecute(Sender: TObject);
begin
  fTPDPCond.Edit(taCond);
end;

procedure TfmTPDPPunkt.actDeleteExecute(Sender: TObject);
begin
  fTPDPCond.Delete(taCond);
end;

procedure TfmTPDPPunkt.edOKPDTRChange(Sender: TObject);
var
  s: String;
begin
  FChanged := True;

  s := Trim(edOKPDTR.Text);
  edOKPDTR.Color := clWindow;
  edOKPDTRName.Color := clBtnFace;
  if KOKPDTR <> -1 then
    edOKPDTRName.Text := '';
  edOKPDTRName.Enabled := False;
  lWarning.Visible := False;
  bAddOKPDTR.Visible := False;
  KOKPDTR := -1;
  if s <> '' then begin
    with q do begin
      SQL.Text := Format('Select KOKPDTR_Id, KOKPDTR_Code, KOKPDTR_Name From [KOKPDTR] Where KOKPDTR_Code = %s', [QuotedStr(s)]);
      Open;
      if Eof then begin
        edOKPDTR.Color := RGB(255, 200, 200);
        edOKPDTRName.Color := clWindow;
        edOKPDTRName.Enabled := True;
        lWarning.Visible := True;
        bAddOKPDTR.Visible := True;
      end else begin
        KOKPDTR := Fields[0].AsInteger;
        edOKPDTRName.Text := Fields[2].AsString;
      end;
      Close;
    end;
  end;
  LoadPosts;
end;

procedure TfmTPDPPunkt.edOkvedChange(Sender: TObject);
var
  okved: String;
begin
  FChanged := True;

  okved := GetFullTrim(edOKVED.Text);
  if okved <> '' then begin
    with q do begin
      SQL.Text := Format('Select Code, Name From [KOKVED] Where Code = %s', [QuotedStr(okved)]);
      Open;
      if Eof then begin
        edOKVEDName.Text := '';
      end else begin
        edOKVEDName.Text := Fields[1].AsString;
      end;
      Close;
    end;
  end;
end;

procedure TfmTPDPPunkt.edPer_NoChange(Sender: TObject);
begin
  FChanged := True;
end;

procedure TfmTPDPPunkt.taCondAfterPost(DataSet: TDataSet);
begin
  FChanged := True;
end;

procedure TfmTPDPPunkt.taCondAgeGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if DisplayText and (Sender.AsInteger=0)
    then Text := 'Без ограничения'
    else Text := Sender.AsString;
end;

procedure TfmTPDPPunkt.dbgDataDblClick(Sender: TObject);
begin
  actEdit.Execute;
end;

procedure TfmTPDPPunkt.dbgDataChangedColumnsWidth(Sender: TObject);
begin
  dbgDataSexName.DropDownWidth := dbgDataSexName.Width * 2;
end;

procedure TfmTPDPPunkt.dbgDataCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if (AColumn = dbgDataWRange_Name) and
     SameText(ANode.Strings[AColumn.Index], 'Независимо от звания')
  then AFont.Color := clGrayText;
  if (AColumn = dbgDataAge) and
     SameText(ANode.Strings[AColumn.Index], 'Без ограничения')
  then AFont.Color := clGrayText;
end;

end.


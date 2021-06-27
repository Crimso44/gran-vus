unit fForm6NoBron;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dxExEdtr, dxTL, dxCntner;

type
  TForm6NoBron = class(TForm)
    pbOk: TButton;
    pbCancel: TButton;
    Grid: TdxTreeList;
    GridName: TdxTreeListColumn;
    GridCOL_B: TdxTreeListColumn;
    GridValue: TdxTreeListMaskColumn;
    procedure GridCustomDrawCell(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; ANode: TdxTreeListNode; AColumn: TdxTreeListColumn;
      ASelected, AFocused, ANewItemRow: Boolean; var AText: String;
      var AColor: TColor; AFont: TFont; var AAlignment: TAlignment;
      var ADone: Boolean);
    procedure GridEditing(Sender: TObject; Node: TdxTreeListNode;
      var Allow: Boolean);
    procedure pbOkClick(Sender: TObject);
    procedure GridEdited(Sender: TObject; Node: TdxTreeListNode);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    ID: Integer;
    function LoadData: Boolean;
    function StoreData: Boolean;
  end;

var
  Form6NoBron: TForm6NoBron;

implementation

uses dMain;

{$R *.dfm}

procedure TForm6NoBron.GridCustomDrawCell(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; ANode: TdxTreeListNode;
  AColumn: TdxTreeListColumn; ASelected, AFocused, ANewItemRow: Boolean;
  var AText: String; var AColor: TColor; AFont: TFont;
  var AAlignment: TAlignment; var ADone: Boolean);
begin
  if (ANode.Strings[GridCOL_B.Index]='2') or
     (ANode.Strings[GridCOL_B.Index]='9')
    then AColor := Grid.Color;
end;

procedure TForm6NoBron.GridEditing(Sender: TObject; Node: TdxTreeListNode;
  var Allow: Boolean);
begin
  Allow :=
    (Node.Strings[GridCOL_B.Index]<>'2') and
    (Node.Strings[GridCOL_B.Index]<>'9');
end;

procedure TForm6NoBron.GridEdited(Sender: TObject; Node: TdxTreeListNode);
var I,J: Integer;
begin
  I := GridValue.Index;
  with Grid do begin
    J :=  StrToIntDef(Trim(Items[2].Strings[I]),0)
         +StrToIntDef(Trim(Items[3].Strings[I]),0);
    if J=0
      then Items[1].Values[I] := NULL
      else Items[1].Values[I] := J;

    {J :=  StrToIntDef(Trim(Items[1].Strings[I]),0)
         -StrToIntDef(Trim(Items[6].Strings[I]),0);
    if J=0
      then Items[5].Values[I] := NULL
      else Items[5].Values[I] := J;}
  end;
  J := StrToIntDef(Trim(Node.Strings[I]),0);
  if J=0
    then Node.Values[I] := NULL
    else Node.Values[I] := J;
end;

function TForm6NoBron.LoadData: Boolean;
var I: Integer;
begin
  dmMain.Form6Query.Locate('COL_B',row_Itogo {row_Vsego},[]);
  for I := 0 to 6 do with Grid.Items[I] do
    Values[GridValue.Index] :=
    dmMain.Form6Query.FieldByName('COL_'+Strings[GridCOL_B.Index]).Value;
  Result := True;
end;

function TForm6NoBron.StoreData: Boolean;
var I: Integer;
begin
  Result := False;
  I := GridValue.Index;
  with Grid do begin
    if  StrToIntDef(Trim(Items[0].Strings[I]),0)<
        StrToIntDef(Trim(Items[1].Strings[I]),0)
       +StrToIntDef(Trim(Items[6].Strings[I]),0)
    then begin
      ShowMessage('Значение показателя "1.Всего работают" должно быть не меньше '+
        'суммы показателей "2.Всего ГПЗ" и "11.Всего ГПП".'); Exit;
    end;
    if  StrToIntDef(Trim(Items[4].Strings[I]),0)>
        StrToIntDef(Trim(Items[3].Strings[I]),0)
    then begin
      ShowMessage('Значение показателя "5.Ограниченно годых(не офицеров)" должно быть не больше '+
        'показателя "4.Прапорщиков, старшин, сержантов, рядовых, матросов".'); Exit;
    end;
    if  {StrToIntDef(Trim(Items[5].Strings[I]),0)+}
        StrToIntDef(Trim(Items[4].Strings[I]),0)>
        StrToIntDef(Trim(Items[1].Strings[I]),0)
    then begin
      ShowMessage('Значение показателя "10.Имеют мобилизационное предписание" должно быть '+
      'не больше значения показателя "2.Всего ГПЗ".'); Exit;
    end;
  end;

  with dmMain.Form6Query do begin
    First;
    while not Eof do begin
      Edit;
      for I := 1 to 16 do FieldByName('COL_'+IntToStr(I)).Clear;
      Post;
      Next;
    end;
    {Locate('COL_B',row_NoBron,[]);
    Edit;
    for I := 0 to 6 do with Grid.Items[I] do
      if StrTointDef(Strings[GridValue.Index],0)>0 then
      FieldByName('COL_'+Strings[GridCOL_B.Index]).Value := Values[GridValue.Index];
    Post;
    Locate('COL_B',row_Vsego,[]);
    Edit;
    for I := 0 to 6 do with Grid.Items[I] do
      if StrTointDef(Strings[GridValue.Index],0)>0 then
      FieldByName('COL_'+Strings[GridCOL_B.Index]).Value := Values[GridValue.Index];
    Post;}
  end;

  with dmMain.Form6HdrQuery do begin
    Edit;

    with Grid.Items[0] do
    if StrTointDef(Strings[GridValue.Index],0)>0
      then FieldByName('RAB_COUNT').AsInteger:= Values[GridValue.Index]
      else FieldByName('RAB_COUNT').Clear;

    with Grid.Items[1] do
    if StrTointDef(Strings[GridValue.Index],0)>0
      then FieldByName('ZAP_COUNT').AsInteger:= Values[GridValue.Index]
      else FieldByName('ZAP_COUNT').Clear;

    FieldByName('ZAB_COUNT').Clear;

    FieldByName('CONFDATE').AsDateTime:= Date;
    FieldByName('CHECKED').Value:= 1;
    Post;
  end;

  Result := True;
end;

procedure TForm6NoBron.pbOkClick(Sender: TObject);
begin
  if not pbCancel.Enabled then Exit;
  if not StoreData then ModalResult := mrNone;
end;


procedure TForm6NoBron.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.

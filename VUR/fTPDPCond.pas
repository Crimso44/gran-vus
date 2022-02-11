unit fTPDPCond;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, dxCntner, dxEditor, dxExEdtr, dxEdLib, Mask,
  CheckLst, ExtCtrls, ADODB, DB;

type
  TfmTPDPCond = class(TForm)
    clbWSost: TCheckListBox;
    laWSost: TLabel;
    cbLimited: TCheckBox;
    laAge: TLabel;
    edAge: TMaskEdit;
    cbAge: TCheckBox;
    laWRange: TLabel;
    edWRange: TdxPickEdit;
    pbOk: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    edSex: TdxPickEdit;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edAgeChange(Sender: TObject);
    procedure cbAgeClick(Sender: TObject);
    procedure pbOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTPDPCond: TfmTPDPCond;

procedure Edit  (ADS: TDataSet);
procedure Add   (ADS: TDataSet);
procedure Delete(ADS: TDataSet);

implementation
uses dMain, Msg;

{$R *.dfm}

type TMode = (mEdit, mAdd);
var
  FMode    : TMode;
  FDS      : TDataSet;
const
  WSostStr : array [0..5] of String = //See KWSost
    ('.1'
    ,'.2.3'
    ,'.4'
    ,'.5'
    ,'.7.8.9.17'
    ,'.10.11');

procedure Go(ADS: TDataSet; AMode: TMode);
begin
  FMode   := AMode;
  FDS     := ADS;
  with    TfmTPDPCond.Create(Application) do
  try     ShowModal;
  finally Free;
  end;
end;

procedure Edit; begin Go(ADS, mEdit) end;
procedure Add;  begin Go(ADS, mAdd)  end;

procedure Delete;
begin
  if Confirm('Удалить текущее условие?') then ADS.Delete;
end;

procedure TfmTPDPCond.FormCreate(Sender: TObject);
var I: Integer;
begin
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; ParamCheck := False;
    SQL.Text := 'SELECT DISTINCT Wrng_ID, Wrng_Name FROM [KWRange] '+
                'WHERE State>2 '+
                'UNION SELECT 0, ''<Независимо от звания>'' FROM [KWRange]'+
                'ORDER BY Wrng_ID';
    Open;
    while not Eof do begin
      edWRange.Items.AddObject(Fields[1].AsString, TObject(Fields[0].AsInteger));
      Next;
    end;
  finally Free;
  end;
  edWRange.ItemIndex := 0;
  edSex.ItemIndex := 0;
  if FMode=mEdit then begin
    for I := 0 to 5 do clbWSost.Checked[I] :=
      Pos(WSostStr[I]+'.', FDS.FieldByName('WSost').AsString) > 0;
    cbLimited.Checked := FDS.FieldByName('Limited').AsInteger > 0;
    edAge.Text := FDS.FieldByName('Age').AsString;
    edWRange.ItemIndex := edWRange.Items.IndexOfObject(TObject(FDS.FieldByName('WRange').AsInteger));
    edSex.ItemIndex := FDS.FieldByName('Sex').AsInteger;
  end;
end;

procedure TfmTPDPCond.edAgeChange(Sender: TObject);
begin
  cbAge.Checked := StrToIntDef(edAge.Text,0)=0;
end;

procedure TfmTPDPCond.cbAgeClick(Sender: TObject);
begin
  if cbAge.Checked then edAge.Text := '0';
end;

procedure TfmTPDPCond.pbOkClick(Sender: TObject);
var
  I       : Integer;
  WSost   : String;
  WSosts  : String;
begin
  WSost := '';
  for I := 0 to 5 do if clbWSost.Checked[I] then WSost := WSost + WSostStr[I];
  if WSost = '' then begin
    ShowErr('Невыбранно ни одной категории воинского состава!');
    clbWSost.SetFocus; ModalResult := mrNone; Exit;
  end;
  WSost := WSost+'.';

  if (FMode = mEdit) and
     (WSost = FDS.FieldByName('WSost').AsString) and
     (cbLimited.Checked = (FDS.FieldByName('Limited').AsInteger>0)) and
     (StrToIntDef(edAge.Text,0) = FDS.FieldByName('Age').AsInteger) and
     (Integer(edWRange.Items.Objects[edWRange.ItemIndex]) = FDS.FieldByName('WRange').AsInteger) and
     (FDS.FieldByName('Sex').AsInteger = edSex.ItemIndex)
  then Exit;

  if FMode=mEdit then FDS.Edit else FDS.Append;

  WSosts := '';
  for I := 0 to 5 do
  if clbWSost.Checked[I] then WSosts := WSosts + clbWSost.Items[I]+', ';
  SetLength(WSosts, Length(WSosts)-2); //Strip last comma

  FDS.FieldByName('Limited').AsInteger := Integer(cbLimited.Checked);
  FDS.FieldByName('Age').AsInteger := StrToIntDef(edAge.Text,0);
  FDS.FieldByName('WRange').AsInteger := Integer(edWRange.Items.Objects[edWRange.ItemIndex]);
  FDS.FieldByName('WSost').AsString := WSost;
  FDS.FieldByName('WSosts').AsString := WSosts;
  FDS.FieldByName('Sex').AsInteger := edSex.ItemIndex;

  FDS.Post;
end;

end.

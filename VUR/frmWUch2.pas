unit frmWUch2;

interface

uses
  msg,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, dxCntner, dxEditor, dxExEdtr, dxEdLib, ADODB;

const WM_CalcPDP = WM_User + 1;

type
  TfWUch2 = class(TForm)
    Panel1: TPanel;
    btnOk: TButton;
    edWUch2: TEdit;
    dtWUch2_date: TdxDateEdit;
    Label1: TLabel;
    edWUch2_Ser: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edWUOKVED: TEdit;
    edWUOKPDTR: TEdit;
    edWUOKPDTRName: TEdit;
    edWUMvkOrd: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edWUOKPDTRNameMvk: TEdit;
    Label11: TLabel;
    edWUch2_Motiv: TEdit;
    Label12: TLabel;
    edWUOKVEDCombo: TComboBox;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    edWUch2ListNumb: TEdit;
    edWUch2ListDate: TdxDateEdit;
    Label14: TLabel;
    procedure edWUch2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edWUOKVEDComboChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    q: TADOQuery;
    OldPDPCode, NewPDPCode, ClearedNewPDPCode, OKVED: String;
    OKVEDChoice: TStringList;
    OnChange: procedure (Sender: TObject) of object;
    function DecodePDPCode(PDPCode: String): String;
    procedure DoCalcPDP(var msg: TMessage); message WM_CalcPDP;
  end;

var
  fWUch2: TfWUch2;

implementation

{$R *.dfm}

uses dMain;

procedure Split(Delimiter: Char; Str: string; ListOfStrings: TStrings) ;
begin
   ListOfStrings.Clear;
   ListOfStrings.Delimiter       := Delimiter;
   ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
   ListOfStrings.DelimitedText   := Str;
end;


function TfWUch2.DecodePDPCode(PDPCode: String): String;
var
  strList: TStringList;
  i: Integer;
  s, sx: String;
begin
  Result := '';
  if PDPCode = '' then
    Result := '<нет>'
  else begin
    strList := TStringList.Create;
    Split('/', PDPCode, strList);
    if strList.Count = 1 then
      Result := PDPCode
    else begin
      for i := 0 to 3 do begin
        if i < strList.Count then begin
          s := strList[i];
          if s <> '' then begin
            if Result <> '' then Result := Result + ', ';
            if i=0 then sx:='ОКВЭД' else if i=1 then sx:='ОКПДТР' else if i=2 then sx:='Постановление МВК' else sx:='Должность';
            Result := Result + sx + ' ' + StringReplace(s,'<!!!>', '/', [rfReplaceAll]);
          end;
        end;
      end;
    end;
    strList.Free;
  end;
end;

procedure TfWUch2.DoCalcPDP(var msg: TMessage);
begin
  if (edWUOKVED.Text <> '') and (edWUMvkOrd.Text <> '') then begin
      ShowInfo('Работник подлежит бронированию одновременно по ПДП и постановлению. Внесите корректировку в ПДП или постановление МВК.');
  end else if OldPDPCode <> ClearedNewPDPCode then begin
    if NewPDPCode = '' then begin
      ShowInfo('Работник не попадает ни под один пункт ПДП. Отсрочка от призыва неправомерна.');
    end else begin
      ShowInfo(
        'Основание для бронирования изменилось.'#13+
        'Было: '+DecodePDPCode(OldPDPCode)+#13+
        'Стало: '+DecodePDPCode(NewPDPCode)+#13+
        'Необходимо выписать новое удостоверение и извещение.');
    end;
  end;
end;

procedure TfWUch2.edWUch2Change(Sender: TObject);
begin
  OnChange(nil);
end;

procedure TfWUch2.edWUOKVEDComboChange(Sender: TObject);
begin
  if edWUOKVEDCombo.ItemIndex < 1 then
    OKVED := ''
  else
    OKVED := OKVEDChoice[edWUOKVEDCombo.ItemIndex - 1];
  OnChange(nil);
end;

procedure TfWUch2.FormCreate(Sender: TObject);
begin
  q := TADOQuery.Create(Self);
  with q do begin
    Connection := dmMain.dbMain; ParamCheck := False;
  end;
end;

procedure TfWUch2.FormShow(Sender: TObject);
var
  s, okpdtr, okpdtrPdp, okpdtrMvk: String;
  i: Integer;
  strList: TStringList;
begin
  strList := TStringList.Create;
  Split('/', NewPDPCode, strList);

  if strList.Count > 0 then
    edWUOKVED.Text := StringReplace(strList[0],'<!!!>', '/', [rfReplaceAll]);
  if strList.Count > 1 then
    edWUOKPDTR.Text := StringReplace(strList[1],'<!!!>', '/', [rfReplaceAll]);
  if strList.Count > 2 then
    edWUMvkOrd.Text := StringReplace(strList[2],'<!!!>', '/', [rfReplaceAll]);
  if strList.Count > 3 then
    edWUOKPDTRNameMvk.Text := StringReplace(strList[3],'<!!!>', '/', [rfReplaceAll]);

  if edWUOKPDTR.Text <> '' then begin
    q.SQL.Text :=
      'Select KOKPDTR_Name From KOKPDTR Where KOKPDTR_Code = '''+edWUOKPDTR.Text+'''';
    q.Open;
    edWUOKPDTRName.Text := q.Fields[0].AsString;
    q.Close;
  end;

  edWUOKVED.Visible := true;
  edWUOKVEDCombo.Visible := false;
  if OKVEDChoice.Count > 0 then begin
    edWUOKVEDCombo.Items.Clear;
    edWUOKVEDCombo.Items.Add('<выбрать>');
    for i := 0 to OKVEDChoice.Count - 1 do
      edWUOKVEDCombo.Items.Add(OKVEDChoice[i]);
    edWUOKVEDCombo.ItemIndex := 0;
    i := OKVEDChoice.IndexOf(OKVED);
    if i >= 0 then
      edWUOKVEDCombo.ItemIndex := i + 1;

    edWUOKVED.Visible := false;
    edWUOKVEDCombo.Visible := true;
  end;

  PostMessage(Handle, WM_CalcPDP, 0, 0);

end;

end.

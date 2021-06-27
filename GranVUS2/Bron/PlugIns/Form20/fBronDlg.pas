unit fBronDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, dxCntner, dxTL, dxDBCtrl, dxDBGrid, ToolWin, FrmKeep,
  Db, ADODB, Menus, dxDBTLCl, dxGrClms, StdCtrls, ExtCtrls, Registry, CheckLst;

type
  TfmBronDlg = class(TForm)
    FrmKeep1: TFrmKeep;
    bPrint: TButton;
    bCancel: TButton;
    rgFilter: TRadioGroup;
    Label1: TLabel;
    edAddr: TEdit;
    rgFilter2: TRadioGroup;
    rgFilter3: TRadioGroup;
    lRegions: TCheckListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bPrintClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure rgFilter3Click(Sender: TObject);
  private
  public
  end;

var
  fmBronDlg: TfmBronDlg;

implementation

uses dMain;

{$R *.DFM}

procedure TfmBronDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmBronDlg.FormCreate(Sender: TObject);
begin
  with TRegistryIniFile.Create('Software\Granit\GranVus2') do
  try
    rgFilter.ItemIndex := ReadInteger('Form20','rgFilter', 0);
  finally  Free;
  end;

  with TADOQuery.Create(Self) do try
    Connection := dmMain.dbMain;
    SQL.Text :=
      'SELECT [TERR_ID],[NAME],[KODTERR] '+
      'FROM [KTERR] '+
      'where substring(kodterr, 3, 9) = ''000000000'' and is_okato = 1 '+
      'order by terr_id';
    Open;
    while not Eof do begin

      lRegions.Items.AddObject(
          Fields[1].AsString,
          TObject(StrToInt(Copy(Fields[2].AsString, 1, 2))));

      Next;
    end;
  finally
    Free;
  end;

end;

procedure TfmBronDlg.bPrintClick(Sender: TObject);
var
  i: Integer;
  s: String;
  regs: TStringList;
begin
  with TRegistryIniFile.Create('Software\Granit\GranVus2') do
  try
    WriteInteger('Form20','rgFilter', rgFilter.ItemIndex);
  finally  Free;
  end;
  regs := TStringList.Create;
  for i := 0 to lRegions.Items.Count - 1 do begin
    if lRegions.Checked[i] then begin
      s := IntToStr(Integer(lRegions.Items.Objects[i]));
      if Length(s) < 2 then s := '0' + s;
      regs.Add(s);
    end;
  end;
  dmMain.PrintData(rgFilter.ItemIndex, rgFilter2.ItemIndex, rgFilter3.ItemIndex, edAddr.Text, regs);
  regs.Free;
  Close;
end;

procedure TfmBronDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

procedure TfmBronDlg.rgFilter3Click(Sender: TObject);
begin
  lRegions.Enabled := rgFilter3.ItemIndex > 0;
end;

end.


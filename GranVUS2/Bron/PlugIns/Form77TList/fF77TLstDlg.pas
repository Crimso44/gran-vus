unit fF77TLstDlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ActnList, ToolWin, FrmKeep, Db, ADODB, Menus, StdCtrls,
  ExtCtrls, Mask;

type
  TfmF77TLstDlg = class(TForm)
    bPrint: TButton;
    bCancel: TButton;
    rgFilter: TRadioGroup;
    Label1: TLabel;
    edPerNumb: TMaskEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bPrintClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
  end;

var
  fmF77TLstDlg: TfmF77TLstDlg;

implementation

uses dMain, msg, IniFiles;

{$R *.DFM}

procedure TfmF77TLstDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmF77TLstDlg.bPrintClick(Sender: TObject);
var
  perNumb: String;
  i: Integer;
begin
  if Trim(edPerNumb.Text)=EmptyStr then begin
    edPerNumb.SetFocus;
    ShowErr('Не указан номер перечня!');
    Exit;
  end;
  perNumb := Trim(edPerNumb.Text);
  while perNumb[Length(perNumb)] = '.' do
    perNumb := Trim(Copy(perNumb, 1, Length(perNumb)-1));
  i := Pos(' ', perNumb);
  if i > 0 then begin
    perNumb := Copy(perNumb, 1, i-1);
    if perNumb[Length(perNumb)] = '.' then
      perNumb := Trim(Copy(perNumb, 1, Length(perNumb)-1));
  end;
  dmMain.PrintData(rgFilter.ItemIndex,perNumb);
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'\settings.ini') do
  try
    WriteString('MISC','PER_NUMBER',Trim(edPerNumb.Text));
  finally
    Free;
  end;

  Close;
end;

procedure TfmF77TLstDlg.FormCreate(Sender: TObject);
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName)+'\settings.ini') do
  try
    edPerNumb.Text := ReadString('MISC','PER_NUMBER','77-Т');
    if edPerNumb.Text=EmptyStr then
      edPerNumb.Text := '77-Т';
  finally
    Free;
  end;
end;

procedure TfmF77TLstDlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

end.


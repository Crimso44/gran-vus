unit DBError;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ADODb;

type
  TDBErrorDlg = class(TForm)
    TextPanel: TPanel;
    DetailPanel: TPanel;
    Memo: TMemo;
    DetailButton: TButton;
    OKButton: TButton;
    IconImage: TImage;
    ErrorLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DetailButtonClick(Sender: TObject);
  private
    FErrors: Errors;
    FMessage: string;
    procedure UpdateFormState;
  public
  end;

  function ShowDBErrorDlg(Errors: Errors; AMessage: string): Integer;

implementation

{$R *.DFM}

function ShowDBErrorDlg(Errors: Errors; AMessage: string): Integer;
var DBErrorDlg: TDBErrorDlg;
begin
  DBErrorDlg:=TDBErrorDlg.Create(Application);
  try
    DBErrorDlg.FErrors:= Errors;
    DBErrorDlg.FMessage:= AMessage;
    Result:=DBErrorDlg.ShowModal;
  finally
    DBErrorDlg.Free;
  end;
end;

procedure TDBErrorDlg.FormShow(Sender: TObject);
var i: Integer;
begin
  if FErrors.Count > 0 then begin
    case FErrors[0].NativeError of
      547: ErrorLabel.Caption:='���������� ������� ������� � ��������� ��������� ����������� ����. �������� �� ����� ���� ���������.';
      2627,2601: ErrorLabel.Caption:='������� ��������� ������������. ����� ������ ��� ����������. �������� �� ����� ���� ���������.';
      233,515,59999: ErrorLabel.Caption:='���� ������ ���� ���������.';
      1205: ErrorLabel.Caption:='��������� �������� ����� �������������� �������. ���������� ��������� ��������.';
    else
      ErrorLabel.Caption:='������ ��� ��������� � ���� ������.';
    end;
    Memo.Lines.Add('--���� ������:');
    for i:=0 to FErrors.Count - 1 do begin
      Memo.Lines.Add(IntToStr(FErrors[i].NativeError)+': '+FErrors[i].Description);
      if FErrors[i].NativeError >= 50000 then
        ErrorLabel.Caption:= ErrorLabel.Caption + #10 + IntToStr(FErrors[i].NativeError) + ': ' + FErrors[i].Description;
    end;
  end;
  Memo.Lines.Add('--�������� ���������:');
  Memo.Lines.Add(FMessage);
  DetailPanel.Visible:=False;
  UpdateFormState;
end;

procedure TDBErrorDlg.DetailButtonClick(Sender: TObject);
begin
  DetailPanel.Visible:= not DetailPanel.Visible;
  UpdateFormState;
end;

procedure TDBErrorDlg.UpdateFormState;
begin
  if DetailPanel.Visible then begin
    DetailButton.Caption:='<< ������';
    ClientHeight:=DetailPanel.Top + DetailPanel.Height;
  end else begin
    DetailButton.Caption:='������ >>';
    ClientHeight:=TextPanel.Height;
  end;
end;

end.

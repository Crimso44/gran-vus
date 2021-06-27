unit fBG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  TfmBG = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    tmStart: TTimer;
    Image1: TImage;
    procedure tmStartTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBG: TfmBG;

implementation

uses fMain;

{$R *.DFM}

procedure TfmBG.tmStartTimer(Sender: TObject);
begin
  tmStart.Enabled := false;
  fmMain.ShowModal;
  Close;
end;

end.

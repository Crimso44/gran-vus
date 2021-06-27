unit DoRestore;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfDoRestore = class(TForm)
    Panel1: TPanel;
    btnOk: TBitBtn;
    btnCancel: TBitBtn;
    Label1: TLabel;
    eBaseName: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDoRestore: TfDoRestore;

implementation

{$R *.dfm}

end.

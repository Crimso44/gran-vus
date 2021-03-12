unit fUseImpDLL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses ADODB;

procedure TForm3.Button1Click(Sender: TObject);
type
  ImportData = function(AppHandle: Cardinal; Conn: _Connection; schemaPath: PChar): Integer; stdcall;
var
  proc: FarProc;
  Lib: HINST;
begin
  try
    Lib := LoadLibrary('ImpData.dll');
    Proc := GetProcAddress(Lib, 'ImportData');
    if Assigned(Proc) then ImportData(Proc)(Application.Handle, nil, 'C:\Documents and Settings\grehovvl\Мои документы\Borland Studio Projects\GranVUS\Source\VUR\ImpDLL\Schema\VURSchema.xsd');
  finally
    FreeLibrary(Lib);
  end;
end;

end.

unit fConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TfmConfig = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edTemp: TEdit;
    sbTemp: TSpeedButton;
    sbRep: TSpeedButton;
    edRep: TEdit;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure sbTempClick(Sender: TObject);
    procedure sbRepClick(Sender: TObject);
  private
    { Private declarations }
    dll_name: Array[0..255] of char;
  public
    { Public declarations }
  end;

var
  fmConfig: TfmConfig;

implementation

uses IniFiles, FileCtrl;

{$R *.DFM}

procedure TfmConfig.FormCreate(Sender: TObject);
begin
  GetModuleFileName(hInstance,dll_name,256);
  with TIniFile.Create(ChangeFileExt(dll_name,'.INI')) do begin
    edTemp.Text := ReadString('MAIN','SRC_PATH',ExtractFilePath(dll_name));
    edRep.Text := ReadString('MAIN','DEST_PATH',ExtractFilePath(dll_name));
    Free;
  end;
end;

procedure TfmConfig.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmConfig.Button1Click(Sender: TObject);
begin
  with TIniFile.Create(ChangeFileExt(dll_name,'.INI')) do begin
    WriteString('MAIN','SRC_PATH',Trim(edTemp.Text));
    WriteString('MAIN','DEST_PATH',Trim(edRep.Text));
    Free;
  end;
  Close;
end;

procedure TfmConfig.sbTempClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выбор папки с шаблонами',EmptyStr,s) then edTemp.Text := s;
end;

procedure TfmConfig.sbRepClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выбор папки с отчетами',EmptyStr,s) then edRep.Text := s;
end;

end.

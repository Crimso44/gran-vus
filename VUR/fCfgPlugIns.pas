unit fCfgPlugIns;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dxCntner, dxTL, FrmKeep, dxExEdtr;

type
  TfmCfgPlugIns = class(TForm)
    dxtData: TdxTreeList;
    btnConfig: TButton;
    Button2: TButton;
    dxtDataColumn1: TdxTreeListColumn;
    dxtDataColumn2: TdxTreeListColumn;
    dxtDataColumn3: TdxTreeListColumn;
    dxtDataColumn4: TdxTreeListColumn;
    FrmKeep1: TFrmKeep;
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfigClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  procedure ConfigPlugIns;

implementation

uses dMain, msg, fMain;

{$R *.DFM}

procedure ConfigPlugIns;
var fmCfgPlugIns: TfmCfgPlugIns;
    i: Integer;
begin
  fmCfgPlugIns := nil;
  for i:=0 to Application.ComponentCount-1 do
    if Application.Components[i] is TfmCfgPlugIns then begin
      fmCfgPlugIns := Application.Components[i] as TfmCfgPlugIns;
      break;
    end;
  if fmCfgPlugIns=nil then begin
    Application.CreateForm(TfmCfgPlugIns,fmCfgPlugIns);
    if fmMain.MainScale <> 100 then
      fmCfgPlugIns.ScaleBy(fmMain.MainScale, 100);
  end;
  if IsIconic(fmCfgPlugIns.Handle) then ShowWindow(fmCfgPlugIns.Handle,SW_RESTORE);
  fmCfgPlugIns.BringToFront;
end;

procedure TfmCfgPlugIns.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmCfgPlugIns.FormCreate(Sender: TObject);
var i: Integer;
    sl: TStringList;
    F: File of byte;
begin
  sl := TStringList.Create;
  for i:=0 to dmMain.slPlugIns.Count-1 do begin
    sl.Clear;
    sl.CommaText := dmMain.slPlugIns[i];
    with dxtData.Add do begin
// имя_dll,имя_плагина,копирайт,тип,image_index
      Data := Pointer(i);
      ImageIndex := StrToInt(sl[4]);
      SelectedIndex := StrToInt(sl[4]);
      Strings[0] := sl[1];
      Strings[1] := sl[2];
      case StrToInt(sl[3]) of
        0: Strings[2] := 'общий';
        1: Strings[2] := 'организация';
        2: Strings[2] := 'личн. карточка';
        3: Strings[2] := 'форма № 6';
        4: Strings[2] := 'список карточек';
      end;
      Strings[3] := sl[0];
      try
        AssignFile(F,sl[0]);
        Reset(F);
        Strings[3] := Strings[3] + ', '+FloatToStrF(FileSize(F)/1024,ffFixed,10,2)+' кб';
        CloseFile(F);
      except
      end;
    end;
  end;
  sl.Free;
end;

procedure TfmCfgPlugIns.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfmCfgPlugIns.btnConfigClick(Sender: TObject);
var sl: TStringList;
    fnConfig: TPlugInConfig;
    hDll: THandle;
begin
  if dxtData.FocusedNode=nil then Beep
  else begin
    sl := TStringList.Create;
    sl.CommaText := dmMain.slPlugIns[Integer(dxtData.FocusedNode.Data)];
    hDll := LoadLibrary(PChar(sl[0]));
    if hDll=0 then ShowErr('Ошибка при загрузке модуля: '+#13+sl[0])
    else begin
      @fnConfig := GetProcAddress(hDll,'PlugInConfig');
      if @fnConfig=nil then ShowInfo('В данном модуле отсутствует функция конфигурации.')
      else
        fnConfig(Application.Handle,dmMain.dbMain.ConnectionObject);
      FreeLibrary(hDll);
    end;
    sl.Free;
  end;
end;

end.

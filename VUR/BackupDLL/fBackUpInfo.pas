unit fBackUpInfo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  dxTL, StdCtrls, dxCntner, ExtCtrls, ComCtrls, dxExEdtr;

type
  TfmBackUpInfo = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    edDate: TEdit;
    edCntTables: TEdit;
    dxtTables: TdxTreeList;
    Button1: TButton;
    dxtTablesColumn1: TdxTreeListColumn;
    dxtTablesColumn2: TdxTreeListColumn;
    dxtTablesColumn3: TdxTreeListColumn;
    dxtTablesColumn4: TdxTreeListColumn;
  private
    { Private declarations }
  public
    { Public declarations }
    function AssignData(fname: string): boolean;
  end;

  procedure ShowBackUpInfo(fname: string);

implementation

uses ArcData, msg;

{$R *.DFM}

procedure ShowBackUpInfo(fname: string);
var fmBackUpInfo: TfmBackUpInfo;
begin
  Application.CreateForm(TfmBackUpInfo,fmBackUpInfo);
  if fmBackUpInfo.AssignData(fname) then fmBackUpInfo.ShowModal;
  fmBackUpInfo.Free;
end;

function TfmBackUpInfo.AssignData(fname: string): boolean;
var ArcHead: TArcHeader;
    TblHead: TTableHeader;
    i: Integer;
begin
  Result := false;
  try
    with TFileStream.Create(fname,fmOpenRead) do begin
      Read(ArcHead,sizeof(TArcHeader));
      if ArcHead.ArcID<>_ArcID then begin
        ShowInfo('Выбранный файл не является снимком БД или имеет поврежденную структуру!');
        Free;
        Exit;
      end;
      edDate.Text := DateTimeToStr(TimeStampToDateTime(ArcHead.ArcDate));
      edCntTables.Text := IntToStr(ArcHead.TableCount);
    dxtTables.ClearNodes;
      for i:=0 to ArcHead.TableCount-1 do begin
        Read(TblHead,sizeof(TTableHeader));
        with dxtTables.Add do begin
          Strings[0] := TblHead.TblName;
          Strings[1] := IntToStr(TblHead.RecCount);
          Strings[2] := IntToStr(TblHead.FldCount);
          Strings[3] := FloatToStrF(TblHead.DataSize/1024,ffFixed,10,2);
        end;
      end;
      Free;
    end;
    Result := true;
  except
    ShowErr('Ошибка при обработке файла "'+fname+'".');
  end;
end;

end.

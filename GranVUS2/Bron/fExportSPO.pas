unit fExportSPO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxCntner, dxTL, dxDBCtrl, dxDBGrid, DB, ADODB,
  StdCtrls, ActnList, dxDBTLCl, dxGrClms;

type
  TfmExportSPO = class(TForm)
    edSubj: TEdit;
    laSubj: TLabel;
    laList: TLabel;
    qrData: TADOQuery;
    dsData: TDataSource;
    DBGrid: TdxDBGrid;
    SaveDialog: TSaveDialog;
    ActionList1: TActionList;
    actExport: TAction;
    pbExport: TButton;
    pbClose: TButton;
    DBGridF6_SHIFR: TdxDBGridColumn;
    DBGridORG_SHIFR: TdxDBGridColumn;
    DBGridF6_COUNT: TdxDBGridColumn;
    DBGridKUO_COUNT: TdxDBGridColumn;
    DBGridCHECKED: TdxDBGridCheckColumn;
    qry: TADOQuery;
    DBGridF6_ID: TdxDBGridColumn;
    procedure actExportUpdate(Sender: TObject);
    procedure pbCloseClick(Sender: TObject);
    procedure DBGridDblClick(Sender: TObject);
    procedure actExportExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure ExportSPO(ASubjID: Integer);

implementation

uses dMain;

{$R *.dfm}

procedure ExportSPO(ASubjID: Integer);
begin
  with TfmExportSPO.Create(Application) do
  try
    with qry do
    try
      SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ WHERE SUBJ_ID = '+IntToStr(ASubjID);
      Open;
      edSubj.Text := Fields[0].AsString;
    finally Close;
    end;
    qrData.Parameters[0].Value := ASubjID;
    qrData.Open;
    ShowModal;
  finally Free;
  end;
end;


procedure TfmExportSPO.actExportUpdate(Sender: TObject);
begin
  actExport.Enabled := Assigned(DBGrid.FocusedNode);
end;

procedure TfmExportSPO.pbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmExportSPO.DBGridDblClick(Sender: TObject);
begin
  actExport.Execute;
end;

procedure TfmExportSPO.actExportExecute(Sender: TObject);
var
  L : TStringList;
  I : Integer;
begin
  if not SaveDialog.Execute then Exit;

  L := TStringList.Create;
  try
    L.Add(DBGrid.FocusedNode.Strings[DBGridORG_SHIFR.Index]);
    with qry do
    try
      SQL.Text := 'SELECT * FROM FORM6 WHERE COL_B IS NOT NULL AND F6_ID = '+
        DBGrid.FocusedNode.Strings[DBGridF6_ID.Index]+
        ' ORDER BY CPROF_ID';
      Open;
      I := 0;
      while not EOF do begin
        Inc(I);
        if I=21 then
          L.Add('0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0')
        else begin
          L.Add(Format('%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d 0',[
            FieldByName('COL_1').AsInteger,
            FieldByName('COL_2').AsInteger,
            FieldByName('COL_3').AsInteger,
            FieldByName('COL_4').AsInteger,
            FieldByName('COL_5').AsInteger,
            FieldByName('COL_6').AsInteger,
            FieldByName('COL_7').AsInteger,
            FieldByName('COL_8').AsInteger,
            FieldByName('COL_9').AsInteger,
            FieldByName('COL_10').AsInteger,
            FieldByName('COL_11').AsInteger,
            FieldByName('COL_12').AsInteger,
            FieldByName('COL_13').AsInteger,
            FieldByName('COL_14').AsInteger,
            FieldByName('COL_15').AsInteger
          ]));
          Next;
        end;
      end;
    finally Close;
    end;
    L.Add(edSubj.Text);
    L.Add(FormatDateTime('dd.mm.yyyy',Date));
    L.Add(DBGrid.FocusedNode.Strings[DBGridF6_COUNT.Index]);
    L.Add(DBGrid.FocusedNode.Strings[DBGridKUO_COUNT.Index]);
    L.Add(DBGrid.FocusedNode.Strings[DBGridF6_SHIFR.Index]);
    L.SaveToFile(SaveDialog.FileName);
  finally L.Free;
  end;
end;

end.

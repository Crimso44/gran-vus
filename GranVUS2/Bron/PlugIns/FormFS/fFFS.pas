unit fFFS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, Menus, ActnList, dxTL, dxDBCtrl, dxDBGrid, dxCntner, ComCtrls,
  ToolWin, dxExEdtr, FrmKeep, Grids, DBGrids;

type
  TfmFFS = class(TForm)
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    dxDBGrid: TdxDBGrid;
    KBONH_IDColumn: TdxDBGridColumn;
    NAMEColumn: TdxDBGridColumn;
    dsData: TDataSource;
    ActionList: TActionList;
    actGenerate: TAction;
    actPrint: TAction;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N2: TMenuItem;
    qrData: TADOQuery;
    actClear: TAction;
    actCreate: TAction;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    sp_FFSCreate: TADOStoredProc;
    sp_FFSClear: TADOStoredProc;
    sp_FFSGenerate: TADOStoredProc;
    ALLColumn: TdxDBGridColumn;
    ALLTOWNVILLAGEColumn: TdxDBGridColumn;
    actExcel: TAction;
    ToolButton5: TToolButton;
    CITYColumn: TdxDBGridColumn;
    qrDataFS_ID: TIntegerField;
    qrDataFS_NAME: TStringField;
    qrDataCITY: TIntegerField;
    qrDataTOWN: TIntegerField;
    qrDataVILLAGE: TIntegerField;
    qrDataTOWNVILLAGE: TIntegerField;
    qrDataINCITY: TIntegerField;
    TOWNColumn: TdxDBGridColumn;
    VILLAGEColumn: TdxDBGridColumn;
    TOWNVILLAGEColumn: TdxDBGridColumn;
    INCITYColumn: TdxDBGridColumn;
    dxDBGridColumn12: TdxDBGridColumn;
    qrDataKOD: TStringField;
    qrDataNPP: TIntegerField;
    qrDataALL: TIntegerField;
    qrDataALLTOWNVILLAGE: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure actPrintExecute(Sender: TObject);
    procedure actGenerateExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actExcelExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure KBONH_IDColumnGetText(Sender: TObject;
      ANode: TdxTreeListNode; var AText: String);
    procedure qrDataCalcFields(DataSet: TDataSet);
  private
  public
    ID: Integer;
    function GetCurrSubjID: Integer;
  end;

var
  fmFFS    : TfmFFS;

implementation

{$R *.DFM}

uses dMain, fOtrDlg, msg;

procedure TfmFFS.FormShow(Sender: TObject);
begin
  actGenerate.Visible:= (ID > 0) and (ID = GetCurrSubjID);
  qrData.Parameters.ParamByName('SUBJ_ID').Value := ID;
  qrData.Open;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain; ParamCheck := false;
    SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ WHERE SUBJ_ID = '+IntToStr(ID);
    Open;
    Caption := Caption+' - '+Fields[0].AsString;
  finally Free;
  end;
end;

procedure TfmFFS.actPrintExecute(Sender: TObject);
begin
  dmMain.PrintData(ID);
end;

function TfmFFS.GetCurrSubjID: Integer;
begin
  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT SUBJ_ID FROM CURR_SUBJ';
    try
      Open;
      if IsEmpty then Result := 0
      else Result := Fields[0].AsInteger;
    except
      Result := -1;
    end;
  finally Free;
  end;
end;

procedure TfmFFS.actGenerateExecute(Sender: TObject);
var FilterType: SmallInt;
begin
  FilterType := 1;
  if ShowOtrDlg(FilterType) = mrOk then begin
    sp_FFSGenerate.Parameters.ParamByName('@SUBJ_ID').Value := ID;
    sp_FFSGenerate.Parameters.ParamByName('@FilterType').Value := FilterType;
    sp_FFSGenerate.ExecProc;
    qrData.Close;
    qrData.Open;

    with TADOQuery.Create(Self) do try
        Connection := dmMain.dbMain;
        SQL.Text := 'SELECT count(*) FROM ORG'#10 +
          'WHERE  case when '#10+
          ' (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''40'' and --CITY'#10 +
            ' SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''45'' and'#10 +
            ' SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''67'' and'#10 +
            ' (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''7'' or'#10 +
                ' (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''850'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''898'') or'#10 +
                ' (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''950'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''998''))) or'#10 +

            ' (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''40'' and --CITY'#10 +
             ' SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''45'' and'#10 +
             ' SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''67'' and'#10 +
             ' SUBSTRING(ISNULL(KODOKTMO,0),6,1) in (''1'',''4'',''7'') and '#13+
             ' (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' or'#10 +
              ' (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''810'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''849'') or'#10 +
              ' (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''910'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''949''))) or'#10 +

          ' (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' and SUBSTRING(ISNULL(KODOKTMO,0),6,1) = ''1'') or --TOWN'#10 +
           ' (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' and SUBSTRING(ISNULL(KODOKTMO,0),6,1) = ''4'') or --VILLAGE'#10 +
           ' (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' and SUBSTRING(ISNULL(KODOKTMO,0),6,1) = ''7'') or --TOWNVILLAGE'#10 +
          ' ((SUBSTRING(ISNULL(KODOKTMO,0),1,2) = ''40'' or --INCITY'#10 +
            ' SUBSTRING(ISNULL(KODOKTMO,0),1,2) = ''45'' or'#10 +
            ' SUBSTRING(ISNULL(KODOKTMO,0),1,2) = ''67'') and'#10 +
          ' (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''3'' or SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''9'')) '#10 +
            'then 1 else 0 end = 0'#10 +
          ' and (org.out_date is null or org.out_date > getdate())';

        Open;
        if (Fields[0].AsInteger > 0) then
          ShowMessage('Обнаружено ' + Fields[0].AsString + ' организаций с неправильным кодом МО ' +
            'и поэтому не вошедших в сведения по видам собственности');
        Close;
    finally
      Free;
    end;
  end;
end;

procedure TfmFFS.actClearExecute(Sender: TObject);
begin
  if not Confirm('Очистить форму?') then Exit;
  qrData.Close;
  sp_FFSClear.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FFSClear.ExecProc;
  qrData.Open;
end;

procedure TfmFFS.actCreateExecute(Sender: TObject);
begin
  if not Confirm('Очистить форму и сформировать пустую?') then Exit;
  qrData.Close;
  sp_FFSCreate.Parameters.ParamValues['@SUBJ_ID']:= ID;
  sp_FFSCreate.ExecProc;
  qrData.Open;
end;

procedure TfmFFS.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift=[]) and (Key=VK_F1) then begin
    Application.HelpFile := ExtractFilePath(Application.ExeName)+'bron.hlp';
    Application.HelpContext(HelpContext);
  end;
end;

procedure TfmFFS.actExcelExecute(Sender: TObject);
begin
  dmMain.GridToExcel(dxDBGrid,Caption,false,true);
end;

procedure TfmFFS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True;
  try if qrData.State = dsEdit then qrData.Post
  except   CanClose := False;
  end;
end;

procedure TfmFFS.KBONH_IDColumnGetText(Sender: TObject;
  ANode: TdxTreeListNode; var AText: String);
begin
  AText := IntToStr(ANode.Index+1)
end;

procedure TfmFFS.qrDataCalcFields(DataSet: TDataSet);
begin
 if DataSet.RecNo>1
   then qrDataNPP.Value := DataSet.RecNo
   else qrDataNPP.Value := 1;

 qrDataALLTOWNVILLAGE.Value := qrDataTOWN.Value + qrDataVILLAGE.Value + qrDataTOWNVILLAGE.Value;
 qrDataALL.Value := qrDataCITY.Value + qrDataALLTOWNVILLAGE.Value + qrDataINCITY.Value;
end;

end.

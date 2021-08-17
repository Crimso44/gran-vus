unit fCorrectOkved;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxmdaset, ADODB, Buttons, ExtCtrls;

type
  TfmCorrectOkved = class(TForm)
    dxMemData1: TdxMemData;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    dxMemData1pers_id: TIntegerField;
    dxMemData1fio: TStringField;
    dxMemData1okpdtr: TStringField;
    dxMemData1okpdtr_name: TStringField;
    DataSource1: TDataSource;
    cxGrid1DBTableView1RecId: TcxGridDBColumn;
    cxGrid1DBTableView1pers_id: TcxGridDBColumn;
    cxGrid1DBTableView1fio: TcxGridDBColumn;
    cxGrid1DBTableView1okpdtr: TcxGridDBColumn;
    cxGrid1DBTableView1okpdtr_name: TcxGridDBColumn;
    ADOQuery1: TADOQuery;
    dxMemData1Broned: TBooleanField;
    cxGrid1DBTableView1Broned: TcxGridDBColumn;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    dxMemData1Fixed: TBooleanField;
    cxGrid1DBTableView1Fixed: TcxGridDBColumn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxGrid1DBTableView1CellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadData;
  end;

var
  fmCorrectOkved: TfmCorrectOkved;

procedure ShowCorrectOkved;

implementation

{$R *.dfm}

uses fMain, dMain, fPersonCard, fPersLst;

procedure ShowCorrectOkved;
begin
  if fmCorrectOkved=nil then begin
    Application.CreateForm(TfmCorrectOkved, fmCorrectOkved);
    if fmMain.MainScale <> 100 then
      fmCorrectOkved.ScaleBy(fmMain.MainScale, 100);
    with fmCorrectOkved do begin
      LoadData;
    end;
  end;
  if IsIconic(fmCorrectOkved.Handle) then
    ShowWindow(fmCorrectOkved.Handle,SW_RESTORE);
  fmCorrectOkved.BringToFront;
end;


{ TfmCorrectOkved }


procedure ShowPersonCard(id: Integer);
var  fmPersonForm: TfmPersonForm;
     i: Integer;
begin
  fmPersonForm := nil;
  if id>0 then
    for i:=0 to Application.ComponentCount-1 do
      if Application.Components[i] is TfmPersonForm then
        if (Application.Components[i] as TfmPersonForm).ID=id then begin
          fmPersonForm := (Application.Components[i] as TfmPersonForm);
          break;
        end;
  if fmPersonForm=nil then begin
    Application.CreateForm(TfmPersonForm,fmPersonForm);
    if fmMain.MainScale <> 100 then
      fmPersonForm.ScaleBy(fmMain.MainScale, 100);
    fmPersonForm.ID := id;
    if id>0 then
      if not fmPersonForm.LoadData then begin
        fmPersonForm.Free;
        Exit;
      end;
      fmPersonForm.SetWarPageActive;
  end;
  if IsIconic(fmPersonForm.Handle) then ShowWindow(fmPersonForm.Handle,SW_RESTORE);
  fmPersonForm.BringToFront;
end;



procedure TfmCorrectOkved.cxGrid1DBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  ShowPersonCard(ACellViewInfo.GridRecord.Values[TcxGridDBTableView(Sender).GetColumnByFieldName('pers_id').Index]);
end;

procedure TfmCorrectOkved.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  fmCorrectOkved := nil;
end;

procedure TfmCorrectOkved.LoadData;
begin
  dxMemData1.Close;
  dxMemData1.Open;
  ADOQuery1.Open;
  while not ADOQuery1.Eof do begin

    dxMemData1.Append;
    dxMemData1.FieldByName('pers_id').AsInteger := ADOQuery1.FieldByName('pers_id').AsInteger;
    dxMemData1.FieldByName('fio').AsString :=
      ADOQuery1.FieldByName('fam').AsString + ' ' + ADOQuery1.FieldByName('im').AsString + ' ' + ADOQuery1.FieldByName('otch').AsString;
    dxMemData1.FieldByName('broned').AsBoolean := ADOQuery1.FieldByName('WUchet2_IsWork').AsInteger = 1;
    dxMemData1.FieldByName('okpdtr').AsString := ADOQuery1.FieldByName('kokpdtr_code').AsString;
    dxMemData1.FieldByName('okpdtr_name').AsString := ADOQuery1.FieldByName('kokpdtr_name').AsString;
    dxMemData1.FieldByName('fixed').AsBoolean := ADOQuery1.FieldByName('okved').AsString <> '';
    dxMemData1.Post;

    ADOQuery1.Next;
  end;
  ADOQuery1.Close;
end;

procedure TfmCorrectOkved.SpeedButton1Click(Sender: TObject);
begin
  LoadData;
end;

end.

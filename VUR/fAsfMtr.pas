unit fAsfMtr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxBar, DB, ADODB, dxBarDBNav, cxClasses, dxExEdtr, dxDBTLCl,
  dxGrClms, dxTL, dxDBCtrl, dxDBGrid, dxCntner, dxSkinsCore,
  dxSkinsDefaultPainters, dxSkinsdxBarPainter;

type
  TTfmAsfMtr = class(TForm)
    dxBarManager1: TdxBarManager;
    qrMain: TADOQuery;
    dsMain: TDataSource;
    dxBarDBNavigator1: TdxBarDBNavigator;
    dxBarDBNavInsert1: TdxBarDBNavButton;
    dxBarDBNavDelete1: TdxBarDBNavButton;
    dxBarDBNavEdit1: TdxBarDBNavButton;
    dxBarDBNavPost1: TdxBarDBNavButton;
    dxBarDBNavCancel1: TdxBarDBNavButton;
    dxBarManager1Bar1: TdxBar;
    qrMainID: TAutoIncField;
    qrMainAsfMtr_Id: TIntegerField;
    qrMainDep_Id: TIntegerField;
    qrMainAmount: TFloatField;
    qrMainAmountAsf: TFloatField;
    qrMainAmountVs: TFloatField;
    qrKAsfMtr: TADOQuery;
    qrDep: TADOQuery;
    qrMainKAsfMtr: TStringField;
    qrDepDEP_ID: TIntegerField;
    qrDepDEP_NAME: TWideStringField;
    qrDepDEP_FULL_NAME: TWideStringField;
    qrDepKDEPART_Num: TIntegerField;
    qrMainKDep: TStringField;
    dxDBGrid1: TdxDBGrid;
    qrAsfMtr: TADOQuery;
    qrMainKAsfMtr_Id: TIntegerField;
    qrKAsfMtrXName: TWideStringField;
    qrKAsfMtrKMtrId: TIntegerField;
    qrAsfMtrMtrName: TWideStringField;
    qrAsfMtrEdIzm: TWideStringField;
    qrAsfMtrMtrId: TIntegerField;
    qrMainAsfMtr: TStringField;
    qrMainAsfMtrEdIzm: TStringField;
    dxDBGrid1ID: TdxDBGridMaskColumn;
    dxDBGrid1AsfMtr_Id: TdxDBGridMaskColumn;
    dxDBGrid1Dep_Id: TdxDBGridMaskColumn;
    dxDBGrid1Amount: TdxDBGridMaskColumn;
    dxDBGrid1AmountAsf: TdxDBGridMaskColumn;
    dxDBGrid1AmountVs: TdxDBGridMaskColumn;
    dxDBGrid1KAsfMtr: TdxDBGridLookupColumn;
    dxDBGrid1KDep: TdxDBGridLookupColumn;
    dxDBGrid1KAsfMtr_Id: TdxDBGridMaskColumn;
    dxDBGrid1AsfMtr: TdxDBGridLookupColumn;
    dxDBGrid1AsfMtrEdIzm: TdxDBGridLookupColumn;
    qrAsfMtrKAsfMtr_Id: TIntegerField;
    qrMainKAsfMtr_Id_Add: TIntegerField;
    dxDBGrid1KAsfMtr2: TdxDBGridLookupColumn;
    dxBarButton1: TdxBarButton;
    procedure qrMainBeforeInsert(DataSet: TDataSet);
    procedure qrMainAfterInsert(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure qrMainBeforePost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dxDBGrid1AsfMtrEditButtonClick(Sender: TObject);
    procedure dxBarButton1Click(Sender: TObject);
    procedure dxDBGrid1ChangedColumnsWidth(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CurrKAsfMtr: Integer;
  end;

var
  TfmAsfMtr: TTfmAsfMtr;

implementation

{$R *.dfm}

uses dMain;

procedure TTfmAsfMtr.dxBarButton1Click(Sender: TObject);
begin
  dmMain.GridToExcel(dxDBGrid1,Caption,False,True);
end;

procedure TTfmAsfMtr.dxDBGrid1AsfMtrEditButtonClick(Sender: TObject);
begin
  qrAsfMtr.Filter := 'KAsfMtr_Id = '+qrMainKAsfMtr_Id.AsString;
  qrAsfMtr.Filtered := True;
end;

procedure TTfmAsfMtr.dxDBGrid1ChangedColumnsWidth(Sender: TObject);
begin
    dxDBGrid1KAsfMtr.DropDownWidth := dxDBGrid1KAsfMtr.Width * 2;
    dxDBGrid1KDep.DropDownWidth := dxDBGrid1KDep.Width * 2;
    dxDBGrid1AsfMtr.DropDownWidth := dxDBGrid1AsfMtr.Width * 2;
    dxDBGrid1AsfMtrEdIzm.DropDownWidth := dxDBGrid1AsfMtrEdIzm.Width * 2;
    dxDBGrid1KAsfMtr2.DropDownWidth := dxDBGrid1KAsfMtr2.Width * 2;
end;

procedure TTfmAsfMtr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TTfmAsfMtr.FormCreate(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  if dmMain.ListMTR.Count > 0 then begin
    s := '';
    for i := 0 to dmMain.ListMTR.Count - 1 do begin
      s := s + dmMain.ListMTR[i] + ',';
    end;
    s := Copy(s, 1, Length(s)-1);
    for i := 0 to qrKAsfMtr.SQL.Count - 1 do begin
      if qrKAsfMtr.SQL[i] = 'Where 1=1' then begin
        qrKAsfMtr.SQL[i] := 'Where Id in ('+s+')';
        Break;
      end;
    end;
    for i := 0 to qrAsfMtr.SQL.Count - 1 do begin
      if qrAsfMtr.SQL[i] = 'Where 1=1' then begin
        qrAsfMtr.SQL[i] := 'Where KAsfMtr_Id in ('+s+')';
        Break;
      end;
    end;
    for i := 0 to qrMain.SQL.Count - 1 do begin
      if qrMain.SQL[i] = 'Where 1=1' then begin
        qrMain.SQL[i] := 'Where KAsfMtr_Id in ('+s+')';
        Break;
      end;
    end;

  end;

  qrKAsfMtr.Open;
  qrAsfMtr.Open;
  qrDep.Open;

  qrMain.Open;

  dxDBGrid1ChangedColumnsWidth(Sender);
end;

procedure TTfmAsfMtr.qrMainAfterInsert(DataSet: TDataSet);
begin
  if CurrKAsfMtr > 0 then
    qrMainKAsfMtr_Id.AsInteger := CurrKAsfMtr;
end;

procedure TTfmAsfMtr.qrMainBeforeInsert(DataSet: TDataSet);
begin
  CurrKAsfMtr := qrMainKAsfMtr_Id.AsInteger;
end;

procedure TTfmAsfMtr.qrMainBeforePost(DataSet: TDataSet);
begin
  qrMainKAsfMtr_Id.AsInteger := qrMainKAsfMtr_Id_Add.AsInteger;
  if qrMainAmount.AsFloat < (qrMainAmountASF.AsFloat + qrMainAmountVS.AsFloat) then begin
    MessageBox(Handle, 'ÌÒÐ â îðãàíèçàöèè < ÌÒÐ â ÀÑÔ + ÌÒÐ â âîéñêà', 'Îøèáêà', Mb_Ok+Mb_IconError);
    Abort;
  end;
end;

end.

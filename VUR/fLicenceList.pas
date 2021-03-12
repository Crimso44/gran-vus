unit fLicenceList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, tList, dxExEdtr, dxBar, DB, ActnList, dxCntner, dxTL, dxDBCtrl,
  dxDBGrid, ComCtrls, ADODB, dxDBTLCl, dxGrClms;

type
  TfmLicenceList = class(TtmList)
    qrData: TADOQuery;
    dxDBGridlicence_id: TdxDBGridMaskColumn;
    dxDBGridlicence_number: TdxDBGridMaskColumn;
    dxDBGridlicence_count: TdxDBGridMaskColumn;
    dxDBGridlicence_start: TdxDBGridDateColumn;
    dxDBGridlicence_end: TdxDBGridDateColumn;
    dxDBGridcustomer_sname: TdxDBGridMaskColumn;
    dxDBGridcustomer_phone: TdxDBGridMaskColumn;
    dxDBGridcustomer_fax: TdxDBGridMaskColumn;
    dxDBGridproduct_sname: TdxDBGridMaskColumn;
    dxDBGridver_info: TdxDBGridMaskColumn;
    dxDBGridproduct_code: TdxDBGridMaskColumn;
    dxDBGridpstate_name: TdxDBGridMaskColumn;
    procedure actInsertExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
  private
  protected
    procedure FReopenQuery; override;
  public
  end;

implementation

uses dMain, msg, fLicenceProp;

{$R *.dfm}

procedure TfmLicenceList.FReopenQuery;
begin
  if qrData.Active then
    qrData.Requery
  else
    qrData.Open;
end;

procedure TfmLicenceList.actInsertExecute(Sender: TObject);
begin
  inherited;
  EditLicence(0,Self);
end;

procedure TfmLicenceList.actEditExecute(Sender: TObject);
begin
  inherited;
  EditLicence(qrData.FieldByName('licence_id').AsInteger,Self);
end;

procedure TfmLicenceList.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if Confirm('Удалить выбранную лицензию?') then
    with dmMain.OpenSQL(
      'select count(*) from LicenceKey where licence_id='+qrData.FieldByName('licence_id').AsString
    ) do
      try
        if Fields[0].AsInteger>0 then
          if not Confirm('По выбранной лицензии были выданы ключи!'#13+
                         'Продолжить удаление?') then Exit;
        dmMain.ExecSQL('delete from Licence where licence_id='+qrData.FieldByName('licence_id').AsString);
        actRefresh.Execute;
      finally
        Free;
      end;
end;

end.

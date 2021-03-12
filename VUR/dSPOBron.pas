unit dSPOBron;

interface

uses
  SysUtils, Classes, DB, ADODB, Dialogs, Forms;

type
  TdmSPOBron = class(TDataModule)
    SaveDialog: TSaveDialog;
    qry: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure DoExport;

implementation

uses dMain, StrUtils;

{$R *.dfm}

procedure DoExport;
//
  function ExtractZIP(S: String): String;
  var I, L: Integer;
  begin
    L := 0;
    for I := 1 to Length(S) do
    if S[I] in ['0'..'9'] then
      if L=5 then begin
        Result := Copy(S, I-L, 6); Exit;
      end
      else Inc(L)
    else
      L := 0;
    Result := '';
  end;
//
begin
  with TdmSPOBron.Create(Application) do
  try
    with TStringList.Create do
    try
      qry.Close;
      qry.SQL.Text := 'SELECT * FROM ORG ORDER BY OrgId';
      qry.Open;
      Add(qry.FieldByName('ORGSNAME').AsString);
      Add(IntToStr(Integer(qry.FieldByName('Has_Bron').AsBoolean)));
      if qry.FieldByName('Has_Bron').AsBoolean then
      with TADOQuery.Create(nil) do
      try
        Connection := dmMain.dbMain; ParamCheck := False;
        SQL.Text := 'SELECT * FROM Form6 WHERE NOT (col_b is null) AND Col_B<25 ORDER BY CPROF_ID';
        Open;
        while not Eof do begin
          Add(Format('%d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %s',[
            FieldByName('COL_1').AsInteger
          , FieldByName('COL_2').AsInteger
          , FieldByName('COL_3').AsInteger
          , FieldByName('COL_4').AsInteger
          , FieldByName('COL_5').AsInteger
          , FieldByName('COL_6').AsInteger
          , FieldByName('COL_7').AsInteger
          , FieldByName('COL_8').AsInteger
          , FieldByName('COL_9').AsInteger
          , FieldByName('COL_10').AsInteger
          , FieldByName('COL_11').AsInteger
          , FieldByName('COL_12').AsInteger
          , FieldByName('COL_13').AsInteger
          , FieldByName('COL_14').AsInteger
          , FieldByName('COL_15').AsInteger
          , FieldByName('COL_16').AsString
          ]));
          Next;
        end;
      finally Free;
      end;
      Add(qry.FieldByName('OKBV').AsString);
      Add(ExtractZip(qry.FieldByName('UrAddr').AsString));
      Add(StringReplace(qry.FieldByName('OrgName').AsString,#13#10,' ',[rfReplaceAll]));
      Add(qry.FieldByName('UrAddr').AsString);
      Add('');//Дом
      Add(qry.FieldByName('RegNum').AsString);
      Add(FormatDateTime('dd.mm.yyy',qry.FieldByName('RegDate').AsDateTime));
      Add(qry.FieldByName('OKPO').AsString);
      with TADOQuery.Create(nil) do
      try
        Connection := dmMain.dbMain; ParamCheck := False;
        SQL.Text := 'SELECT * FROM ORG_CONT WHERE is_gen=1 AND ORGID='+qry.FieldByName('ORGID').AsString;
        Open;
        Add(Format('%s %s %s',[FieldByName('Fam').AsString,FieldByName('Im').AsString,FieldByName('Otch').AsString]));
        Add(FieldByName('Phone').AsString);
        Close;
        SQL.Text := 'SELECT * FROM ORG_CONT WHERE is_vus=1 AND ORGID='+qry.FieldByName('ORGID').AsString;
        Open;
        Add(Format('%s %s %s',[FieldByName('Fam').AsString,FieldByName('Im').AsString,FieldByName('Otch').AsString]));
        Add(FieldByName('Phone').AsString);

        Close;  SQL.Text := 'SELECT Per_No FROM TPDP'; Open;
        Add(Fields[0].AsString);
        Close;  SQL.Text := 'SELECT VV4.NAME, OSN.DOC_NO, OSN.DOC_DATE FROM OSN, VV4 WHERE OSN.DOC_ID=VV4.ID'; Open;
        Add(Format('%s №%s от %s',[Fields[0].AsString,Fields[1].AsString,Fields[2].AsString]));
        Add(qry.FieldByName('Fax').AsString);
        Add('');//Адрес вышестоящей организации

        Close;  SQL.Text := 'SELECT * FROM FORM6 WHERE CPROF_ID=2000 AND F6_ID=(SELECT F6_ID FROM FORM6HDR WHERE ORGID='+qry.FieldByName('ORGID').AsString+')'; Open;
        Add(FieldByName('COL_1').AsString);
        Add(FieldByName('COL_2').AsString);
        Add(FieldByName('COL_3').AsString);
        Add(FieldByName('COL_4').AsString);
        Add(FieldByName('COL_5').AsString);
        Add(FieldByName('COL_15').AsString);

        Close;  SQL.Text := 'SELECT NAME FROM KTERR WHERE KODTERR LIKE '''+LeftStr(qry.FieldByName('KodReg').AsString,2)+'000000%'''; Open;
        Add(Fields[0].AsString);
        Close;  SQL.Text := 'SELECT NAME FROM KTERR WHERE KODTERR = '''+qry.FieldByName('KodReg').AsString+''''; Open;
        Add(Fields[0].AsString);
        Add('');//Город
        Add('');//Улица
        Add(qry.FieldByName('Feature1').AsString);
        Close;  SQL.Text := 'SELECT POST FROM ORG_CONT WHERE is_gen=1 AND ORGID='+qry.FieldByName('ORGID').AsString; Open;
        Add(Fields[0].AsString);
        Close;  SQL.Text := 'SELECT POST FROM ORG_CONT WHERE is_vus=1 AND ORGID='+qry.FieldByName('ORGID').AsString; Open;
        Add(Fields[0].AsString);
        Add(qry.FieldByName('Parent').AsString);
        Close;  SQL.Text := 'SELECT KOD FROM KOPF WHERE KOPF_ID='+IntToStr(qry.FieldByName('KOPF_ID').AsInteger); Open;
        Add(Fields[0].AsString);
        Close;  SQL.Text := 'SELECT KOD FROM KFS WHERE FS_ID='+IntToStr(qry.FieldByName('FS_ID').AsInteger); Open;
        Add(Fields[0].AsString);
        Add('');//ОК ОТ
        Add(qry.FieldByName('MAINOKONH').AsString);
        Add('');//ОК ВП

        Close;  SQL.Text := 'SELECT * FROM FORM6 WHERE CPROF_ID=2000 AND F6_ID=(SELECT F6_ID FROM FORM6HDR WHERE ORGID='+qry.FieldByName('ORGID').AsString+')'; Open;
        Add(FieldByName('COL_14').AsString);
        Add(FieldByName('COL_6').AsString);

      finally Free;
      end;
      Add(qry.FieldByName('KodReg').AsString);
      Add(qry.FieldByName('INN').AsString);
      Add(StringReplace(qry.FieldByName('Comment').AsString,#13#10,' ',[rfReplaceAll]));

      if SaveDialog.Execute then SaveToFile(SaveDialog.FileName) else Exit;
    finally Free; //Strings
    end;
  finally Free; //Module
  end;
  ShowMessage('Экспорт данных в формате СПО "Бронирование" завершён.');
end;

end.

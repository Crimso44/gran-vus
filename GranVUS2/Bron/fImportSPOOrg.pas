unit fImportSPOOrg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxExEdtr, dxTL, dxCntner, StdCtrls, DB, ADODB;

type
  TfmImportSPOOrg = class(TForm)
    OpenDialog: TOpenDialog;
    edFileName: TEdit;
    laFileName: TLabel;
    pbOpen: TButton;
    Grid: TdxTreeList;
    Label1: TLabel;
    dxTreeList1Column1: TdxTreeListColumn;
    dxTreeList1Column2: TdxTreeListColumn;
    pbCard: TButton;
    pbF6: TButton;
    pbClose: TButton;
    Label2: TLabel;
    sp_GenerateForm6: TADOStoredProc;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure pbOpenClick(Sender: TObject);
    procedure pbCloseClick(Sender: TObject);
    procedure pbCardClick(Sender: TObject);
    procedure pbF6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmImportSPOOrg: TfmImportSPOOrg;

procedure ImportSPOBron;

implementation

uses dMain, fOrgProp, fOrgPropCommon, fOrgPropContacts, StrUtils;

{$R *.dfm}

const
  ImpNameCount = 66;
  ImpName: array [0..ImpNameCount-1] of String = (
  'Краткое наименование организации',
  'Признак ведения бронирования',
  'Форма 6, строка 1',
  'Форма 6, строка 2',
  'Форма 6, строка 3',
  'Форма 6, строка 4',
  'Форма 6, строка 5',
  'Форма 6, строка 6',
  'Форма 6, строка 7',
  'Форма 6, строка 8',
  'Форма 6, строка 9',
  'Форма 6, строка 10',
  'Форма 6, строка 11',
  'Форма 6, строка 12',
  'Форма 6, строка 13',
  'Форма 6, строка 14',
  'Форма 6, строка 15',
  'Форма 6, строка 16',
  'Форма 6, строка 17',
  'Форма 6, строка 18',
  'Форма 6, строка 19',
  'Форма 6, строка 20',
  'Форма 6, строка 21',
  'Форма 6, строка 22',
  'Форма 6, строка 23',
  'Форма 6, строка 24',
  'Номер в ВУО',
  'Почтовый индекс',
  'Полное наименование организации',
  'Юридический адрес',
  'Номер дома',
  'Номер государственной регистрации',
  'Дата регистрации',
  'Код ОКПО',
  'ФИО руководителя организации',
  'Телефон руководителя организации',
  'ФИО военно-учётного работника',
  'Телефон военно-учётного работника',
  'Номер ПДП',
  'Постановление',
  'Факс',
  'Адрес вышестоящей организации',
  'Всего работающих',
  'Всего ГПЗ',
  'Число офицеров',
  'Число прапорщиков и сержантов',
  'Число солдат и матросов',
  'Число неимеющих моб. предписание',
  'Субъект',
  'Район',
  'Город',
  'Улица',
  'Признак 1',
  'Должность руководителя',
  'Должность военно-учётного работника',
  'Вышестоящая организация',
  'Код ОКОПФ',
  'Код ОКФС',
  'Код ОКОТ',
  'Код ОКВД',
  'Код ОКВП',
  'Число незабронированных, неимеющих моб. предписание',
  'Число ограниченно годных',
  'Код ОКАТО',
  'ИНН',
  'Дополнительная информация');

procedure ImportSPOBron;
begin
  if not Assigned(fmImportSPOOrg) then fmImportSPOOrg := TfmImportSPOOrg.Create(Application);
  fmImportSPOOrg.Show;
end;

procedure TfmImportSPOOrg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  fmImportSPOOrg := nil;
end;

procedure TfmImportSPOOrg.FormCreate(Sender: TObject);
var I: Integer;
begin
  for I := 0 to ImpNameCount-1 do with Grid.Add do Strings[0] := ImpName[I];
end;

procedure TfmImportSPOOrg.pbOpenClick(Sender: TObject);
var I: Integer;
begin
  if not OpenDialog.Execute then Exit;
  edFileName.Text := OpenDialog.FileName;
  with TStringList.Create do
  try
    LoadFromFile(OpenDialog.FileName);
    if Count<2 then Exit;
    if Strings[1]='0' then for I := 1 to 24 do Insert(2,'');
    while Count>ImpNameCount do Delete(Count-1);
    for I := 0 to Count-1 do Grid.Items[I].Strings[1] := Strings[I];
  finally Free;
  end;
  Grid.Refresh;
end;

procedure TfmImportSPOOrg.pbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmImportSPOOrg.pbCardClick(Sender: TObject);
//
  function GetWord(S: String; N: Integer): String;
  var I,J: Integer; InWord: Boolean;
  begin
    Result := '';  S := S+' '; InWord := S[1]<>' '; J := 1;
    for I := 1 to Length(S) do
    if S[I]=' ' then begin
      if InWord then begin
        InWord := False; Dec(N);
        if N<1 then begin
          Result := Copy(S, J, I-J); Exit;
        end;
      end;
    end
    else begin
      if not InWord then begin
        J := I; InWord := True;
      end;
    end;
  end;
//
var
  I : Integer;
  F : TfmOrgProp;
begin
  F := nil;
  for I :=0 to Application.MainForm.MDIChildCount-1 do
  if Application.MainForm.MDIChildren[I] is TfmOrgProp then begin
    F := Application.MainForm.MDIChildren[I] as TfmOrgProp; Break;
  end;
  if not Assigned(F) then begin
    ShowMessage('Вы должны открыть карточку организации для заполнения.');
    Exit;
  end;
  F.FCommon.edSName.Text    := Grid.Items[0].Strings[1];
  F.chkHasBron.Checked      := Grid.Items[1].Strings[1]='1';
  //2..25=F6
  F.edOKBV.Text             := Grid.Items[26].Strings[1];
  //28=ZIP
  F.mmName.Lines.Text       := Grid.Items[28].Strings[1];
  F.edUAddr.Text            := Grid.Items[29].Strings[1];
  //30=Houm
  F.edRegNum.Text           := Grid.Items[31].Strings[1];
  F.dtRegDate.Date          := StrTodateTimeDef(Grid.Items[32].Strings[1],Date);
  F.edOKPO.Text             := Grid.Items[33].Strings[1];
  F.FContacts.edFam1.Text   := GetWord(Grid.Items[34].Strings[1],1);
  F.FContacts.edIm1.Text    := GetWord(Grid.Items[34].Strings[1],2);
  F.FContacts.edOtch1.Text  := GetWord(Grid.Items[34].Strings[1],3);
  F.FContacts.edPhone1.Text := Grid.Items[35].Strings[1];
  F.edVUR.Text              := Grid.Items[36].Strings[1];
  F.edPhone.Text            := Grid.Items[37].Strings[1];
  //38=PDP
  //39=OSN_DOC
  F.FCommon.edFax.Text      := Grid.Items[40].Strings[1];//Fax
  //41=Parent's address
  //42..47=COL_1,2,3,4,5,15 for CPROF_ID=1000
  //48=Subject
  //49=Rayon
  //50=City, Town, etc.
  //51=Street
  F.edFeature1.Text := Grid.Items[52].Strings[1];
  F.FContacts.edPost1.Text  := Grid.Items[53].Strings[1];
  F.FContacts.edPost2.Text  := Grid.Items[54].Strings[1];
  F.FCommon.edParent.Text   := Grid.Items[55].Strings[1];
  for I := 0 to F.cbOKOPF.Items.Count-1 do
  if LeftStr(F.cbOKOPF.Items[I],Length(Grid.Items[56].Strings[1]))=Grid.Items[56].Strings[1]
  then begin
    F.cbOKOPF.ItemIndex := I; Break;
  end;
  for I := 0 to F.cbOKFS.Items.Count-1 do
  if LeftStr(F.cbOKFS.Items[I],Length(Grid.Items[57].Strings[1]))=Grid.Items[57].Strings[1]
  then begin
    F.cbOKFS.ItemIndex := I; Break;
  end;
  //58=OKOT
  F.edOKONH.Text            := Grid.Items[59].Strings[1];
  //60=OKVP
  //61,62=COL_14,COL_6 for CPROF_ID=1000
  F.cbOKATO1.Text           := Grid.Items[63].Strings[1];
  F.edINN.Text              := Grid.Items[64].Strings[1];
  F.FCommon.mmComments.Text := Grid.Items[65].Strings[1];
  F.dtLast.Date             := Date;
  ShowMessage('Поля карточки заполнены. Проверьте правильность данных.');
  F.BringToFront;
end;

procedure TfmImportSPOOrg.pbF6Click(Sender: TObject);
//
  function ImpF6Line(S: String): String;
  var I,J,N: Integer; Value: Boolean;
  begin
    Result := 'UPDATE FORM6 SET ';
    S := S + ' ';
    N := 0; //Value count
    Value := S[1] in ['0'..'9'];
    J := 1; // Any way
    for I := 1 to Length(S) do
    if S[I] in ['0'..'9'] then begin
      if not Value then begin
        Value := True; J := I;
      end;
    end
    else begin
      if Value then begin
        Inc(N);
        Value := False; Result := Result + Format(' COL_%d = NULLIF(%d,0),',
          [N, StrToIntDef(Copy(S, J, I-J),0)]);
        if N=16 then Break;
      end;
    end;
    for I := N+1 to 16 do Result := Result + Format(' COL_%d = NULL,',[I]);
    SetLength(Result,Length(Result)-1); //Strip last comma
  end;
//
var
  I     : Integer;
  F     : TfmOrgProp;
  F6_ID : Integer;
begin
  F := nil;
  for I :=0 to Application.MainForm.MDIChildCount-1 do
  if Application.MainForm.MDIChildren[I] is TfmOrgProp then begin
    F := Application.MainForm.MDIChildren[I] as TfmOrgProp; Break;
  end;
  if not Assigned(F) then begin
    ShowMessage('Вы должны открыть карточку организации для заполнения.');
    Exit;
  end;
  if F.FId<1 then begin
    ShowMessage('Вы должны сохранить новую карточку организации для заполнения формы №6.');
    Exit;
  end;
  with sp_GenerateForm6 do begin
    Parameters.ParamValues['@ORG_ID']:= F.FId;
    ExecProc;
  end;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := false;
    SQL.Text := 'SELECT F6_ID FROM FORM6HDR WHERE ORGID='+IntToStr(F.FId);
    Open;
    F6_ID := Fields[0].AsInteger;
    Close;
    if Grid.Items[1].Strings[1]='1' then begin
      for I := 2 to 25 do begin
        SQL.Text := Format('%s WHERE F6_ID=%d AND COL_B=%d',
          [ImpF6Line(Grid.Items[I].Strings[1]), F6_ID, I-1]);
        ExecSQL;
      end;
      SQL.Text := 'UPDATE FORM6 SET'+
        ' COL_1=f.COL_1,'+
        ' COL_2=f.COL_2,'+
        ' COL_3=f.COL_3,'+
        ' COL_4=f.COL_4,'+
        ' COL_5=f.COL_5,'+
        ' COL_6=f.COL_6,'+
        ' COL_7=f.COL_7,'+
        ' COL_8=f.COL_8,'+
        ' COL_9=f.COL_9,'+
        ' COL_10=f.COL_10,'+
        ' COL_11=f.COL_11,'+
        ' COL_12=f.COL_12,'+
        ' COL_13=f.COL_13,'+
        ' COL_14=f.COL_14,'+
        ' COL_15=f.COL_15'+
        ' FROM FORM6 f, FORM6 '+
        ' WHERE F.COL_B=24 AND F.F6_ID=FORM6.F6_ID AND '+
        ' FORM6.COL_B=26 AND FORM6.F6_ID='+IntToStr(F6_ID);
      ExecSQL;
    end
    else begin
      SQL.Text := Format('UPDATE FORM6 SET'+
        ' COL_1 = %d,'+
        ' COL_2 = %d,'+
        ' COL_3 = %d,'+
        ' COL_4 = %d,'+
        ' COL_5 = %d,'+
        ' COL_6 = %d,'+
        ' COL_14 = %d,'+
        ' COL_15 = %d'+
        ' WHERE F6_ID=%d AND COL_B IN (25,26)',[
        StrToIntDef(Grid.Items[42].Strings[1],0),
        StrToIntDef(Grid.Items[43].Strings[1],0),
        StrToIntDef(Grid.Items[44].Strings[1],0),
        StrToIntDef(Grid.Items[45].Strings[1],0),
        StrToIntDef(Grid.Items[46].Strings[1],0),
        StrToIntDef(Grid.Items[62].Strings[1],0),
        StrToIntDef(Grid.Items[61].Strings[1],0),
        StrToIntDef(Grid.Items[47].Strings[1],0),
        F6_ID]);
      ExecSQL;
    end;
    SQL.Text := 'UPDATE FORM6HDR SET '+
      ' ORGNAME = '+QuotedStr(Grid.Items[0].Strings[1])+
      ',F6_SHIFR = '+QuotedStr(F.cbForm6Shifr.Text)+
      ',RAB_COUNT = f.COL_1'+
      ',ZAP_COUNT = f.COL_2'+
      ',ZAB_COUNT = f.COL_7'+
      ',CHECKED = 0'+
      ' FROM FORM6 f, FORM6 '+
      ' WHERE F.COL_B=26 AND F.F6_ID=FORM6.F6_ID AND FORM6.F6_ID='+IntToStr(F6_ID);
    ExecSQL;
  finally Free;
  end;
  F.dtLast.Date := Date;
  ShowMessage('Форма 6 заполнена. Нажмите кнопку "Расчётная численность по категориям" для просмотра и редактирования.');
  F.BringToFront;
end;

end.

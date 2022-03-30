unit vur395;

interface

  function Patch395_GetInfo: string;
  function Patch395_GetStepCount: Integer;
  procedure Patch395_Process;

implementation

uses Classes,Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch395_GetInfo: string;
begin
  Result :=
   'Версия 3.82.3'#13;
end;

function Patch395_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch395_Process;
var
  Q, QQ: TADOQuery;
  i, id, idid: Integer;
  s: String;
  sl: TStringList;
  is_need: Boolean;

  procedure DoSQL(const ASQL: String; const NoCount: Boolean = False);
  begin
    with Q do
    try
      SQL.Text := ASQL;
      ExecSQL;
    except on e: Exception do showmessage(e.message); end;
    if not NoCount then
      fmMain.pbMain.StepIt;
  end;
  procedure AddField(const ATable, AField, AType: String);
  begin
    with Q do begin
      SQL.Text := 'select * from '+ATable+' where 1<>1';
      Open;
      if FindField(AField)=nil then begin
        Close;
        DoSQL('alter table '+ATable+' add column '+AField+' '+AType, True);
      end
      else
        Close;
    end;
    //fmMain.pbMain.StepIt;
  end;
begin
  Q := TADOQuery.Create(fmMain);
  QQ := TADOQuery.Create(fmMain);
  QQ.Connection := fmMain.dbConn; QQ.ParamCheck := False;
  with Q do
  try
    Connection := fmMain.dbConn; ParamCheck := False;

    fmMain.lbProcState.Caption := '...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//

      AddField('KNapr', 'Time_Y', 'int null');
      AddField('KNapr', 'Time_M', 'int null');
      AddField('KNapr', 'Time_D', 'int null');
      AddField('Appointment', 'NAPR_ID', 'int null');
      AddField('Person', 'Sovet_Shifr', 'varchar(50) null');
      AddField('Person', 'Sovet_Org', 'varchar(150) null');
      AddField('Person', 'Sovet_Date', 'DateTime null');
      AddField('Person', 'Sovet_Num', 'varchar(50) null');
      AddField('Person', 'Sovet_Org_Order', 'varchar(150) null');
      AddField('Person', 'War_Program', 'int null');
      AddField('Person', 'WBovk', 'int null');

      DoSQL('Update KL_DATA set Disp_Name = "Классификатор специальностей по ОКСО" Where Kl_Id = 31', True);

      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (185, 31, "TIME_Y", "Срок обучения, лет", 150, 0, 1, 1, ' +
            'null, 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (186, 31, "TIME_M", "Срок обучения, месяцев", 150, 0, 1, 1, ' +
            'null, 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (187, 31, "TIME_D", "Срок обучения, дней", 150, 0, 1, 1, ' +
            'null, 1)', True);


    DoSQL('Update VerInfo Set '+
          'VerStr = ''3.82.3'', VerDesc = ''Версия релиза 3.82.3'', VerDate = #25/03/2022#');


  finally Free;
  end;
end;

end.


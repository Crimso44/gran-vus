unit vur385;

interface

  function Patch385_GetInfo: string;
  function Patch385_GetStepCount: Integer;
  procedure Patch385_Process;

implementation

uses Classes,Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch385_GetInfo: string;
begin
  Result :=
   'Версия 3.80.1'#13;
end;

function Patch385_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch385_Process;
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
      DoSQL('insert into KKVAL (KVAL_Id, KVAL_NAME, Kval_Flag) '+
        'select iif(isNull((select Max(Kval_Id) From KKval)),0,(select Max(Kval_Id) From KKval))+EDQID, Kval, 1 '+
        'from (select Kval, max(EDQ_ID) as EDQID '+
          'From Educ Inner Join Person on Person.Pers_Id = Educ.Pers_Id '+
        'Where Kval <> "" '+
          'and not exists (select 1 from KKVAL as KKVAL2 where KKVAL2.KVAL_NAME = Educ.Kval and KKval2.Kval_Flag = 1) '+
        'group by Kval '+
        ') as x', True);

      DoSQL('update Educ '+
        'inner join KKval on KKVal.Kval_Name = Educ.Kval '+
        'set Educ.Kval_Id = KKval.Kval_Id '+
        'Where Kval <> "" and KKval.Kval_Flag = 1', True);

      DoSQL('insert into KNapr (Napr_Id, Napr_NAME, Napr_Flag) '+
        'select iif(IsNull((select Max(Napr_Id) From KNapr)),0,(select Max(Napr_Id) From KNapr)) + EDQId, '+
          'Napr, Napr_Flag from (select Napr, Max(EDQ_ID) as EDQID, '+
          'iif(Educ.Type=4,iif(Person.isAspirant,2, 1),1) as Napr_Flag '+
        'From Educ Inner Join Person on Person.Pers_Id = Educ.Pers_Id '+
        'Where Napr <> "" '+
          'and not exists (select 1 from KNapr as Knapr2 where KNapr2.Napr_Name = Educ.Napr and KNapr2.Napr_Flag = iif(Educ.Type=4,iif(Person.isAspirant,2, 1),1)) '+
        'group by Napr, '+
          'iif(Educ.Type=4,iif(Person.isAspirant,2, 1),1) '+
        ') as x', True);

      DoSQL('update (Educ '+
        'inner join KNapr on KNapr.Napr_Name = Educ.Napr) '+
        'Inner Join Person on Person.Pers_Id = Educ.Pers_Id '+
        'set Educ.Napr_Id = KNapr.Napr_Id '+
        'Where Napr <> ""  and KNapr.Napr_Flag = iif(Educ.Type=4,iif(Person.isAspirant,2, 1),1)', True);

      DoSQL('Update VerInfo Set '+
          'VerStr = ''3.80.1'', VerDesc = ''Версия релиза 3.80.1'', VerDate = #25/9/2017#');

  finally Free;
  end;
end;

end.


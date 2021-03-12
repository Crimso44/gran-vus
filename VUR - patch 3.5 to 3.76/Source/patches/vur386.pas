unit vur386;

interface

  function Patch386_GetInfo: string;
  function Patch386_GetStepCount: Integer;
  procedure Patch386_Process;

implementation

uses Classes,Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch386_GetInfo: string;
begin
  Result :=
   'Версия 3.80.2'#13;
end;

function Patch386_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch386_Process;
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

      DoSQL('Create table KAssign (' +
            'ID Int NOT NULL Primary Key,' +
            'Name Varchar(255) NULL' +
            ')', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (46, "KAssign", "Звание, разряд, класс, чин госслужащего", 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (172, 46, "ID", "Код внутренний", 99, 1, 0, 0, ' +
            '"{SQL:SELECT MAX(ID)+1 FROM KAssign}{TXT:1}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (173, 46, "Name", "Наименование", 200, 0, 1, 1, ' +
            'null, 0)', True);
      AddField('Assign','KAssign','Int NULL');
      DoSQL('insert into KAssign (Id, NAME) '+
        'select iif(isNull((select Max(Id) From KAssign)),0,(select Max(Id) From KAssign))+AssignID, AssignText '+
        'from (select AssignText, max(Assign_ID) as AssignID '+
          'From Assign '+
        'Where AssignText <> "" '+
          'and not exists (select 1 from KAssign as KAssign2 where KAssign2.NAME = Assign.AssignText) '+
        'group by AssignText '+
        ') as x', True);
      DoSQL('Update Assign '+
        'Inner join KAssign on KAssign.Name = Assign.AssignText '+
        'set Assign.KAssign = KAssign.Id', True);


      DoSQL('Update VerInfo Set '+
          'VerStr = ''3.80.2'', VerDesc = ''Версия релиза 3.80.2'', VerDate = #13/3/2018#');

  finally Free;
  end;
end;

end.


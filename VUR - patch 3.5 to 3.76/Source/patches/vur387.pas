unit vur387;

interface

  function Patch387_GetInfo: string;
  function Patch387_GetStepCount: Integer;
  procedure Patch387_Process;

implementation

uses Classes,Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch387_GetInfo: string;
begin
  Result :=
   'Версия 3.80.3'#13;
end;

function Patch387_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch387_Process;
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

      DoSQL('Alter Table Appointment Alter IN_ORD_NUMB Varchar(255)', True);
      DoSQL('alter table Org Alter OrgName Memo', True);
      DoSQL('alter table Form6Hdr Alter OrgName Memo', True);
      DoSQL('alter table Form6Hdr_2015 Alter OrgName Memo', True);



      DoSQL('Update VerInfo Set '+
          'VerStr = ''3.80.3'', VerDesc = ''Версия релиза 3.80.3'', VerDate = #22/6/2018#');

  finally Free;
  end;
end;

end.


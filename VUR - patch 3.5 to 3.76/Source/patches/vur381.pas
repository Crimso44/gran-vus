unit vur381;

interface

  function Patch381_GetInfo: string;
  function Patch381_GetStepCount: Integer;
  procedure Patch381_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch381_GetInfo: string;
begin
  Result :=
   'Версия 3.79.2'#13;
end;

function Patch381_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch381_Process;
var
  Q, QQ: TADOQuery;
  i, id, idid: Integer;
  s: String;
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
      DoSQL('Update Kl_Fld Set Has_Null = 1 Where Fld_Id = 164', False);

      DoSQL('Update VerInfo Set '+
          'VerStr = ''3.79.2'', VerDesc = ''Версия релиза 3.79.2'', VerDate = #15/4/2016#');

  finally Free;
  end;
end;

end.


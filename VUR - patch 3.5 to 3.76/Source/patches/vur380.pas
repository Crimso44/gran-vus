unit vur380;

interface

  function Patch380_GetInfo: string;
  function Patch380_GetStepCount: Integer;
  procedure Patch380_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch380_GetInfo: string;
begin
  Result :=
   'Версия 3.79.1'#13;
end;

function Patch380_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch380_Process;
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
      DoSQL('Update Kl_Data ' +
            'set Chk_Del = ''SELECT COUNT(*) FROM KPOST WHERE KOKPDTR=:ID'' ' +
            'Where Kl_Name = ''KOKPDTR''', False);

      DoSQL('Update VerInfo Set '+
          'VerStr = ''3.79.1'', VerDesc = ''Версия релиза 3.79.1'', VerDate = #1/3/2016#');

  finally Free;
  end;
end;

end.

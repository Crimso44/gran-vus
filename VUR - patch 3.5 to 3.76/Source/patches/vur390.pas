unit vur390;

interface

  function Patch390_GetInfo: string;
  function Patch390_GetStepCount: Integer;
  procedure Patch390_Process;

implementation

uses Classes,Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch390_GetInfo: string;
begin
  Result :=
   'Версия 3.81.2'#13;
end;

function Patch390_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch390_Process;
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

    DoSQL('Update VerInfo Set '+
          'VerStr = ''3.81.2'', VerDesc = ''Версия релиза 3.81.2'', VerDate = #17/11/2019#');


  finally Free;
  end;
end;

end.


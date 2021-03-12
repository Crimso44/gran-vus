unit vur389;

interface

  function Patch389_GetInfo: string;
  function Patch389_GetStepCount: Integer;
  procedure Patch389_Process;

implementation

uses Classes,Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch389_GetInfo: string;
begin
  Result :=
   'Версия 3.81.1'#13;
end;

function Patch389_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch389_Process;
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

    DoSQL('Insert Into Params (Param_Id, Param_Name, Param_Value) Values ('+
          '14, ''Печатать в форме Т-2 (ВУС) п.9 раздела 2 (сведения о воинском учете)'',''1'')', True);


    DoSQL('DROP view PersonreservChkInfo',True);
    DoSQL('CREATE VIEW PersonreservChkInfo AS '#13#10+
    'SELECT PERS_ID, Reserved, MainWork, PermanentWork, WARTIME, DefVUS, Command300, EOARMY_YEAR, DefPOST,'#13 +
    ' DefPOST_WRange, DefPOST_Post, DefPOST_WSost, DefPOST_Age, '#13 +
    'IIF(IS_WAR<>1 or (not ISNULL(W_DEND) and W_DEND<=Date()), 0,'#13 +
    'IIF((Reserved=1)<>(('#13 +
    '        (MainWork=1) and'#13 +
    '        (PermanentWork=1) and'#13 +
    '        (WARTIME=1) and'#13 +
    '        (DefVUS=0) and'#13 +
    '        (Command300=0) and'#13 +
    '        (SpecialWUchet1<>1) and'#13 +
    '        (DefPOST=1)) or (MvkPost_Id = AppPost_Id and not IsNull(MvkOrdDocDate))),1,0)) AS IS_BAD'#13 +
    'FROM PersonReservChkInfoBase;', True);

    DoSQL('Update VerInfo Set '+
          'VerStr = ''3.81.1'', VerDesc = ''Версия релиза 3.81.1'', VerDate = #1/9/2019#');


  finally Free;
  end;
end;

end.


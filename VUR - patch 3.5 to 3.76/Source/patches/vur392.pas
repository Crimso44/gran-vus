unit vur392;

interface

  function Patch392_GetInfo: string;
  function Patch392_GetStepCount: Integer;
  procedure Patch392_Process;

implementation

uses Classes,Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch392_GetInfo: string;
begin
  Result :=
   'Версия 3.82'#13;
end;

function Patch392_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch392_Process;
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
      //SQL.SaveToFile('c:\qqq.sql');
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

      AddField('Appointment','PROBATION_DATE','datetime NULL');
      AddField('Person', 'Driver', 'int NULL');
      AddField('Person', 'MobContract', 'datetime null');

    DoSQL('Drop View PersonreservChkInfoBase', True);
    DoSQL(
      'Create View PersonreservChkInfoBase As '#13+
      'SELECT '#13+
      '  P.PERS_ID, P.IS_WAR, P.W_DEND, P.SpecialWUchet1, P.WUchet1, P.BIRTHDAY, P.Male, R.CHE, R.LIMIT1, '#13+
      '  iif(IsNull(P.WUCHET2_IsWork),0,P.WUCHET2_IsWork) AS Reserved, '#13+
      '  IIf(AppointmentLastAll.WTP_ID in (1,3,9),1,0) AS MainWork, '#13+
      '  IIf(AppointmentLastAll.WCH_ID=1,1,0) AS PermanentWork, '#13+
      '  IIf(IIf(ISNULL(StaffList.WartimePlan),0,StaffList.WartimePlan)>0,1,0) AS WARTIME, '#13+
      '  IIF(EXISTS(SELECT * FROM KDEFVUS WHERE NAME = left(P.VUS, IIF((select state from KWRANGE where WRNG_ID = P.WRNG_ID) = 3, 6, 3))), 1,0) AS DefVUS, '#13+
      '  IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300), 1,0) AS Command300, '#13+
      '  P.EOARMY_DATE AS EOARMY_YEAR, P.Driver, P.MobContract, '#13+
      '  P.Document, PostStudy.IsIgnore, '#13 +
      '  MvkOrd.DocNumber as MvkOrdDocNumber, MvkOrd.DocDate as MvkOrdDocDate, '#13+
      '  AppointmentLastAll.Post_Id as AppPost_Id, MvkOrd.Post_Id as MvkPost_Id, '#13+
      '  IIF(IsNull(AppointmentLastAll.Probation_Date) or AppointmentLastAll.Probation_Date < Date(), 1, 0) as ProbationOk, '#13+
      '  IIF(EXISTS( '#13+
      '    SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay')+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ),1,0) AS DefPOST, '#13+


      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay')+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE (PDP.POST_ID = AppointmentLastAll.POST_ID)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay')+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_Post, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay')+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE  (PDP.WRange=0 OR PDP.CHE >= R.CHE)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay')+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_WRange, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay')+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ((not Exists (SELECT * FROM PDP   WHERE (InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0)) or '#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay')+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '))),0,1) AS DefPOST_WSost, '#13+

      'IIf(not Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age <= '+FullAges('P.BirthDay')+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ) '#13+
      'and ('#13+
      'Exists (SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLastAll.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="В") AND '#13+
      '      InStr(PDP.WSOST, "."&P.WSOST_ID&".")>0 AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age > '+FullAges('P.BirthDay')+' And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      ')),0,1) AS DefPOST_Age, '#13+
      'Iif(IsNull(PostStudy.Post_Id), 0, 1) as IsStudent, '#13+
      'Iif(P.WRNG_ID <> 1 and P.WRNG_ID <> 37, 1, 0) as StudWRangeOk '#13+

      'FROM (((((Person AS P '#13+
      'LEFT JOIN Appointment as AppointmentLastAll ON P.AppLast=AppointmentLastAll.ID) '#13+
      'LEFT JOIN Appointment as AppointmentLastStudy ON P.AppLastStudy=AppointmentLastStudy.ID) '#13+
      'LEFT JOIN KPost as PostStudy ON AppointmentLastStudy.POST_ID = PostStudy.POST_ID) '#13+
      'LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) '#13+
      'LEFT JOIN MvkOrder AS MvkOrd ON P.Pers_Id=MvkOrd.Pers_Id) '#13+
      'LEFT JOIN StaffList ON (AppointmentLastAll.POST_ID=StaffList.POST_ID) AND (AppointmentLastAll.DEP_ID=StaffList.DEP_ID) '
    , True);

    DoSQL('DROP view PersonreservChkInfo',True);
    DoSQL('CREATE VIEW PersonreservChkInfo AS '#13#10+
    'SELECT PERS_ID, Reserved, MainWork, PermanentWork, WARTIME, DefVUS, Command300, EOARMY_YEAR, Document, DefPOST,'#13 +
    ' DefPOST_WRange, DefPOST_Post, DefPOST_WSost, DefPOST_Age, '#13 +
    ' IsStudent, StudWRangeOk, IsIgnore, '#13 +
    'IIF(IsStudent=0 and (IS_WAR<>1 or (not ISNULL(W_DEND) and W_DEND<=Date())), 0,'#13 +
    'IIF((Reserved=1)<>(('#13 +
    '        (MainWork=1) and'#13 +
    '        (PermanentWork=1) and'#13 +
    '        (WARTIME=1) and'#13 +
    '        (DefVUS=0) and'#13 +
    '        (Command300=0) and'#13 +
    '        (SpecialWUchet1<>1) and'#13 +
    '        (Document<>3) and '#13 +
    '        (ProbationOk=1) and'#13 +
    '        (ISNULL(EOARMY_YEAR) or (Male<>1) or'#13 +
    '         (R.LIMIT1 <= Year(Date())-Year(BIRTHDAY)) or not ('#13 +
    '         ((R.CHE<= 8)             and (Year(Date())-Year(BIRTHDAY)<=35)) or'#13 +
    '         ((R.CHE IN (9,10,11,12)) and (Year(Date())-Year(BIRTHDAY)<=45)) or'#13 +
    '         ((R.CHE IN (13,14))      and (Year(Date())-Year(BIRTHDAY)<=50)) or'#13 +
    '         ((R.CHE =15)             and (Year(Date())-Year(BIRTHDAY)<=55)) or'#13 +
    '         ((R.CHE >15)             and (Year(Date())-Year(BIRTHDAY)<=60)))'#13 +
    '        ) and'#13 +
    '        (Driver<>1) and'#13 +
    '        (MobContract is null or MobContract < Date()) and'#13 +
    '        (DefPOST=1)) or '#13 +

    '  (MvkPost_Id = AppPost_Id and not IsNull(MvkOrdDocDate) or '#13 +
    '  (IsStudent=1 and StudWRangeOk=1 and Document<2 and DefVUS=0 and IsNull(WUchet1) and IsIgnore=0))'#13 +
    '),1,0)) AS IS_BAD'#13 +
    'FROM PersonReservChkInfoBase;', True);










    DoSQL('Update VerInfo Set '+
          'VerStr = ''3.82'', VerDesc = ''Версия релиза 3.82'', VerDate = #01/05/2020#');


  finally Free;
  end;
end;

end.


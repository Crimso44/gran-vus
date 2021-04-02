unit vur384;

interface

  function Patch384_GetInfo: string;
  function Patch384_GetStepCount: Integer;
  procedure Patch384_Process;

implementation

uses Classes,Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch384_GetInfo: string;
begin
  Result :=
   'Версия 3.80'#13;
end;

function Patch384_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch384_Process;
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
      AddField('KDepart','IS_OLD','bit NULL');
      AddField('KPost','IS_OLD','bit NULL');
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (170, 11, "IS_OLD", "Упразднен", 50, 0, 1, 1, ' +
            '"{Valid:isDepValid}", 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (171,  4, "IS_OLD", "Упразднен", 50, 0, 1, 1, ' +
            '"{Valid:isPostValid}", 1)', True);
      DoSQL('Update Kl_Fld set Def_Value = "{Valid:OKPDTR}" Where Fld_Name = "KOKPDTR_Code" and KL_ID=43', True);
      DoSQL('Update Kl_Data set Disp_Name = "Военные комиссариаты (администрации районов)" Where Kl_Name = "KOVK"', True);
      DoSQL('Alter Table KOVK Alter OVK_NAME Varchar(250)', True);
      DoSQL('Alter Table ADDR Alter ADDR_STR Varchar(200)', True);
      DoSQL('Alter Table ORG Alter INN Varchar(50)', True);
      DoSQL('Update Kl_Fld set HAS_Null = 1 Where Fld_Name = "CPROF_ID" and KL_ID=4', True);
      DoSQL('Update Kl_Fld set HAS_Null = 0 Where Fld_Name = "CPROF2015_ID" and KL_ID=4', True);

    DoSQL('Drop View PersonreservChkInfoBase', True);
    DoSQL(
      'Create View PersonreservChkInfoBase As '#13+
      'SELECT '#13+
      '  P.PERS_ID, P.IS_WAR, P.W_DEND, P.SpecialWUchet1, P.BIRTHDAY, P.Male, R.CHE, R.LIMIT1, '#13+
      '  iif(IsNull(P.WUCHET2_IsWork),0,P.WUCHET2_IsWork) AS Reserved, '#13+
      '  IIf(AppointmentLastAll.WTP_ID in (1,3,9),1,0) AS MainWork, '#13+
      '  IIf(AppointmentLastAll.WCH_ID=1,1,0) AS PermanentWork, '#13+
      '  IIf(IIf(ISNULL(StaffList.WartimePlan),0,StaffList.WartimePlan)>0,1,0) AS WARTIME, '#13+
      '  IIF(EXISTS(SELECT * FROM KDEFVUS WHERE NAME = left(P.VUS, IIF((select state from KWRANGE where WRNG_ID = P.WRNG_ID) = 3, 6, 3))), 1,0) AS DefVUS, '#13+
      '  IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300), 1,0) AS Command300, '#13+
      '  P.EOARMY_DATE AS EOARMY_YEAR, '#13+
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
      ')),0,1) AS DefPOST_Age '#13+

      'FROM ((Person AS P '#13+
      'LEFT JOIN Appointment as AppointmentLastAll ON P.AppLast=AppointmentLastAll.ID) '#13+
      'LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) '#13+
      'LEFT JOIN StaffList ON (AppointmentLastAll.POST_ID=StaffList.POST_ID) AND (AppointmentLastAll.DEP_ID=StaffList.DEP_ID) '
    , True);

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

      DoSQL('Delete from Kl_Fld where Kl_Id = 30 and Fld_Name = "KVAL_FLAG"', True);
      DoSQL('Delete from Kl_Fld where Kl_Id = 31 and Fld_Name = "NAPR_FLAG"', True);

      DoSQL('Update VerInfo Set '+
          'VerStr = ''3.80'', VerDesc = ''Версия релиза 3.80'', VerDate = #7/7/2017#');

  finally Free;
  end;
end;

end.


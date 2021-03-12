unit vur377;

interface

  function Patch377_GetInfo: string;
  function Patch377_GetStepCount: Integer;
  procedure Patch377_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs;

function Patch377_GetInfo: string;
begin
  Result :=
   'Версия 3.77:'#13;
end;

function Patch377_GetStepCount: Integer;
begin
  Result := 4;
end;

procedure Patch377_Process;
var
  Q: TADOQuery;

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
  with Q do
  try
    Connection := fmMain.dbConn; ParamCheck := False;
    fmMain.lbProcState.Caption := 'создание таблиц...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//1
    fmMain.lbProcState.Caption := 'изменения в картотеке работников...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('alter table ORG Alter SOOGU Text(7)');

//8
    fmMain.lbProcState.Caption := 'добавление учета АСФ...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//
    DoSQL('Create table ASF (' +
          'ASF_ID INTEGER NOT NULL Primary Key,' +
          'OrgName varchar(250) NULL,' +
          'OrgSName varchar(100) NOT NULL,' +
          'PERS_ID INTEGER NULL' +
          ')', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (34, ''ASF'', ''Аварийно-спасательные формирования'', 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (128, 34, ''ASF_ID'', ''Код внутренний'', 99, 1, 0, 0, ' +
            '''{SQL:SELECT MAX(ASF_ID)+1 FROM ASF}{TXT:1}'', 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (129, 34, ''OrgSName'', ''Краткое наименование'', 100, 0, 1, 1, ' +
            'null, 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (130, 34, ''OrgName'', ''Полное наименование'', 250, 0, 1, 1, ' +
            'null, 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (131, 34, ''PERS_ID'', ''Командир АСФ'', 150, 0, 1, 0, ' +
            '''{LU:SELECT Pers_ID, Fam+" "+Im+" "+Otch FROM Person Order By Fam, Im, Otch}'', 1)', True);

    DoSQL('Create table KASP (' +
          'ID INTEGER NOT NULL Primary Key,' +
          'Name varchar(250) NULL' +
          ')', True);
    DoSQL('Insert Into KASP (ID, Name) Values (0, "Управление")', True);
    DoSQL('Insert Into KASP (ID, Name) Values (1, "Основные подразделения")', True);
    DoSQL('Insert Into KASP (ID, Name) Values (2, "Подразделения обеспечения")', True);

    DoSQL('Create table ASP (' +
          'ASP_ID INTEGER NOT NULL Primary Key,' +
          'ASF_ID INTEGER NOT NULL,' +
          'Name varchar(250) NULL,' +
          'DEP_Name varchar(100) NOT NULL,' +
          'ASP_Num INTEGER NULL,' +
          'ASP_Type INTEGER NOT NULL' +
          ')', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL, HandSort) ' +
            'VALUES (35, ''ASP'', ''Аварийно-спасательные подразделения'', 1, ' +
            'null, ''ASP_Num'')', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (132, 35, ''ASP_ID'', ''Код внутренний'', 99, 1, 0, 0, ' +
            '''{SQL:SELECT MAX(ASP_ID)+1 FROM ASP}{TXT:1}'', 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (133, 35, ''ASF_ID'', ''АСФ'', 150, 0, 1, 0, ' +
            '''{LU:SELECT ASF_ID, OrgSName FROM ASF Order By OrgSName}'', 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (134, 35, ''DEP_Name'', ''Краткое наименование'', 100, 0, 1, 1, ' +
            'null, 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (135, 35, ''Name'', ''Полное наименование'', 250, 0, 1, 1, ' +
            'null, 1)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (136, 35, ''ASP_Type'', ''Вид подразделения'', 100, 0, 1, 0, ' +
            '''{LU:SELECT ID, Name From KASP}'', 0)', True);

      DoSQL('Create table ASPost (' +
            'ASPost_ID INTEGER NOT NULL Primary Key,' +
            'Post_Name varchar(250) NULL,' +
            'ASPost_Num INTEGER NULL' +
            ')', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL, HandSort) ' +
            'VALUES (36, ''ASPost'', ''Аварийно-спасательные должности'', 1, ' +
            'null, ''ASPost_Num'')', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (137, 36, ''ASPost_ID'', ''Код внутренний'', 99, 1, 0, 0, ' +
            '''{SQL:SELECT MAX(ASPost_ID)+1 FROM ASPost}{TXT:1}'', 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (138, 36, ''Post_Name'', ''Наименование'', 250, 0, 1, 1, ' +
            'null, 1)', True);

      DoSQL('Create table ASAppointment (' +
            'ID Counter NOT NULL Primary Key,' +
            'PERS_ID INTEGER NOT NULL,' +
            'ASPost_ID INTEGER NULL,' +
            'ASP_ID INTEGER NULL,' +
            'IN_ORD_NUMB Varchar(50) NULL,' +
            'IN_ORD_Date DateTime NULL,' +
            'IN_Date DateTime NOT NULL,' +
            'TRAINING Varchar(250) NULL,' +
            'TRAINING_Date DateTime NULL,' +
            'ATTESTED Varchar(50) NULL' +
            ')', True);

//8
    fmMain.lbProcState.Caption := 'добавление учета АСФ...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//
      AddField('PERSON','ASOrder_In','VARCHAR(20) NULL');
      AddField('PERSON','ASDate_In','DateTime NULL');
      AddField('PERSON','ASOut_ORD_NUMB','Varchar(50) NULL');
      AddField('PERSON','ASOut_ORD_Date','DateTime NULL');
      AddField('PERSON','ASOut_Date','DateTime NULL');

      DoSQL('Create table ASAssign (' +
            'Assign_ID Counter NOT NULL Primary Key,' +
            'PERS_ID INTEGER NOT NULL,' +
            'Assign_Date DateTime NOT NULL,' +
            'Assign_Date_End DateTime NULL,' +
            'AssignWhat Varchar(250) NULL,' +
            'AssignWhere Varchar(250) NULL' +
            ')', True);

      DoSQL('Create table ASStaffList (' +
            'ASP_ID INTEGER NOT NULL,' +
            'ASPost_ID INTEGER NOT NULL,' +
            'GeneralPlan INTEGER NULL,' +
            'GeneralQty INTEGER NULL,' +
            'GeneralVacancy INTEGER NULL' +
            ')', True);

      DoSQL('Create View ASDepAndPost As '+
            'SELECT ASP.ASP_ID, ASF.OrgSName+" "+ASP.Dep_NAME AS DEP_NAME, ASPOST.ASPOST_ID, ASPOST.POST_NAME '+
            'FROM ASPOST, ASP INNER JOIN ASF ON ASP.ASF_ID=ASF.ASF_ID', True);

      DoSQL('Create View ASStaffListFull As '+
            'SELECT ASDepAndPost.ASP_ID, ASDepAndPost.DEP_NAME, ASDepAndPost.ASPOST_ID, ASDepAndPost.POST_NAME, '+
              'ASStaffList.GeneralPlan, ASStaffList.GeneralQty, ASStaffList.GeneralVacancy '+
            'FROM ASDepAndPost LEFT JOIN ASStaffList ON (ASDepAndPost.[ASP_ID] = ASStaffList.[ASP_ID]) AND (ASDepAndPost.[ASPOST_ID] = ASStaffList.[ASPOST_ID])',
            True);

      DoSQL('Create View ASAppointmentMaxIn_DateAll As '+
            'SELECT a.PERS_ID, Max(a.ID) AS [Max-ID], a.IN_DATE AS [MAX-In_Date] '+
            'FROM ASAppointment AS a '+
            'WHERE (((a.[IN_DATE])=(SELECT Max(IN_DATE) FROM ASAppointment WHERE PERS_ID = a.PERS_ID))) '+
            'GROUP BY a.PERS_ID, a.IN_DATE', True);


      DoSQL('Create View ASAppointmentLastAll As '+
            'SELECT ASAppointment.* '+
            'FROM ASAppointment '+
            'INNER JOIN ASAppointmentMaxIn_DateAll ON ASAppointment.ID = ASAppointmentMaxIn_DateAll.[Max-ID]',
            True);


      DoSQL('Create View ASStaffListAll As '+
            'SELECT ASStaffListFull.ASP_ID, ASStaffListFull.DEP_NAME, ASStaffListFull.ASPOST_ID, ASStaffListFull.POST_NAME, '+
              'IIf(IsNull(ASStaffListFull.GeneralPlan),0,ASStaffListFull.GeneralPlan) AS GeneralPlan, '+
              'IIf(IsNull(ASStaffListFull.GeneralQty),0,ASStaffListFull.GeneralQty) AS GeneralQty, '+
              'IIf(IsNull(ASStaffListFull.GeneralVacancy),0,ASStaffListFull.GeneralVacancy) AS GeneralVacancy, '+
              'Count(IIf(PERSON.PERS_ID Is Not Null And (PERSON.ASOUT_DATE Is Null Or PERSON.ASOUT_DATE>Date()),1,Null)) AS QtyAll '+
              'FROM ASStaffListFull '+
              'LEFT JOIN (ASAppointmentLastAll LEFT JOIN PERSON ON ASAppointmentLastAll.PERS_ID = PERSON.PERS_ID) '+
                'ON (ASStaffListFull.ASP_ID = ASAppointmentLastAll.ASP_ID) AND (ASStaffListFull.ASPOST_ID = ASAppointmentLastAll.ASPOST_ID) '+
              'GROUP BY ASStaffListFull.ASP_ID, ASStaffListFull.DEP_NAME, ASStaffListFull.ASPOST_ID, ASStaffListFull.POST_NAME, ASStaffListFull.GeneralPlan, ASStaffListFull.GeneralQty, ASStaffListFull.GeneralVacancy',
              True);

      DoSQL('Create View ASQtyByDep As '+
            'SELECT a.Dep_Id, Count(*) AS GenQty '+
            'from (Person as p '+
            'inner join AppointmentLastAll as a on a.Pers_Id = p.Pers_Id) '+
            'inner join ASAppointmentLastAll as aa on aa.Pers_Id = p.Pers_Id '+
            'Where p.Out_Date is null and p.ASOut_Date is null '+
            'Group By a.Dep_Id',
              True);

      DoSQL('Create View ASQtyForRep As '+
            'SELECT a.Dep_Id, Count(*) AS GenQty, '+
            'Sum(iif(p.Is_War=1 and (p.W_DEND is null or p.W_DEND > Date()), 1, 0)) as WarQty, '+
            'Sum(iif(p.Is_War<>1 or (p.W_DEND is not null and p.W_DEND <= Date()) and p.Male=0,1,0)) as WomenQty '+
            'FROM (Person AS p '+
            'INNER JOIN AppointmentLastAll AS a ON a.Pers_Id=p.Pers_Id) '+
            'Left JOIN ASAppointmentLastAll AS aa ON aa.Pers_Id=p.Pers_Id '+
            'WHERE p.Out_Date is null and (aa.Pers_Id is null or p.ASOut_Date <= Date()) '+
            'GROUP BY a.Dep_Id'
              );

//8
    fmMain.lbProcState.Caption := 'Оптимизация быстродействия...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//
      AddField('PERSON','AppLast','Integer NULL');
      AddField('PERSON','AppLastAll','Integer NULL');
      AddField('PERSON','AppLastStudy','Integer NULL');
      AddField('PERSON','AppFirst','Integer NULL');
      AddField('PERSON','AppFirstStudy','Integer NULL');
      AddField('PERSON','ASAppLast','Integer NULL');
      AddField('PERSON','ASAppFirst','Integer NULL');

      DoSQL('Create Table Temp (ID integer, pers_id integer) ',
              True);

      DoSQL('Insert Into Temp (ID, pers_id) '+
            'Select ID, Pers_Id From AppointmentLast ',
              True);
      DoSQL('Update Person Inner Join Temp on Temp.Pers_Id = Person.Pers_Id '+
            'Set AppLast = Temp.Id ',
              True);
      DoSQL('Delete From Temp ',
              True);

      DoSQL('Insert Into Temp (ID, pers_id) '+
            'Select ID, Pers_Id From AppointmentLastAll ',
              True);
      DoSQL('Update Person Inner Join Temp on Temp.Pers_Id = Person.Pers_Id '+
            'Set AppLastAll = Temp.Id ',
              True);
      DoSQL('Delete From Temp ',
              True);

      DoSQL('Insert Into Temp (ID, pers_id) '+
            'Select Appointment.ID, Appointment.Pers_Id '+
            'FROM Appointment INNER JOIN ( '+
            '  SELECT a.PERS_ID, max(a.ID) AS [Max-ID], a.IN_DATE AS [MAX-In_Date] '+
            '  FROM Appointment AS a '+
            '  WHERE IN_DATE = (SELECT Max(IN_DATE) '+
            '  FROM Appointment '+
            '  WHERE PERS_ID = a.PERS_ID AND Appointment.POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID = 500)) '+
            '  GROUP BY a.PERS_ID, a.IN_DATE '+
            ') as AppointmentMaxIn_DateAll ON Appointment.ID=AppointmentMaxIn_DateAll.[Max-ID] ',
              True);
      DoSQL('Update Person Inner Join Temp on Temp.Pers_Id = Person.Pers_Id '+
            'Set AppLastStudy = Temp.Id ',
              True);
      DoSQL('Delete From Temp ',
              True);

      DoSQL('Insert Into Temp (ID, pers_id) '+
            'Select Appointment.ID, Appointment.Pers_Id '+
            'FROM Appointment INNER JOIN ( '+
            '  SELECT a.PERS_ID, max(a.ID) AS [Max-ID], a.IN_DATE AS [MAX-In_Date] '+
            '  FROM Appointment AS a '+
            '  WHERE IN_DATE = (SELECT Min(IN_DATE) '+
            '  FROM Appointment '+
            '  WHERE PERS_ID = a.PERS_ID AND Appointment.POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID <> 500)) '+
            '  GROUP BY a.PERS_ID, a.IN_DATE '+
            ') as AppointmentMaxIn_DateAll ON Appointment.ID=AppointmentMaxIn_DateAll.[Max-ID] ',
              True);
      DoSQL('Update Person Inner Join Temp on Temp.Pers_Id = Person.Pers_Id '+
            'Set AppFirst = Temp.Id ',
              True);
      DoSQL('Delete From Temp ',
              True);

      DoSQL('Insert Into Temp (ID, pers_id) '+
            'Select Appointment.ID, Appointment.Pers_Id '+
            'FROM Appointment INNER JOIN ( '+
            '  SELECT a.PERS_ID, max(a.ID) AS [Max-ID], a.IN_DATE AS [MAX-In_Date] '+
            '  FROM Appointment AS a '+
            '  WHERE IN_DATE = (SELECT Min(IN_DATE) '+
            '  FROM Appointment '+
            '  WHERE PERS_ID = a.PERS_ID AND Appointment.POST_ID IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID = 500)) '+
            '  GROUP BY a.PERS_ID, a.IN_DATE '+
            ') as AppointmentMaxIn_DateAll ON Appointment.ID=AppointmentMaxIn_DateAll.[Max-ID] ',
              True);
      DoSQL('Update Person Inner Join Temp on Temp.Pers_Id = Person.Pers_Id '+
            'Set AppFirstStudy = Temp.Id ',
              True);
      DoSQL('Delete From Temp ',
              True);

      DoSQL('Insert Into Temp (ID, pers_id) '+
            'Select ID, Pers_Id From ASAppointmentLastAll ',
              True);
      DoSQL('Update Person Inner Join Temp on Temp.Pers_Id = Person.Pers_Id '+
            'Set ASAppLast = Temp.Id ',
              True);
      DoSQL('Delete From Temp ',
              True);

      DoSQL('Insert Into Temp (ID, pers_id) '+
            'Select ASAppointment.ID, ASAppointment.Pers_Id '+
            'FROM ASAppointment INNER JOIN ( '+
            '  SELECT a.PERS_ID, min(a.ID) AS [Min-ID], a.IN_DATE AS [Min-In_Date] '+
            '  FROM ASAppointment AS a '+
            '  WHERE IN_DATE = (SELECT Min(IN_DATE) '+
            '  FROM ASAppointment '+
            '  WHERE PERS_ID = a.PERS_ID) '+
            '  GROUP BY a.PERS_ID, a.IN_DATE '+
            ') as ASAppointmentMinIn_DateAll ON ASAppointment.ID=ASAppointmentMinIn_DateAll.[Min-ID] ',
              True);
      DoSQL('Update Person Inner Join Temp on Temp.Pers_Id = Person.Pers_Id '+
            'Set ASAppFirst = Temp.Id ',
              True);
      DoSQL('Delete From Temp ',
              True);

      DoSQL('Drop Table Temp'
              );

      AddField('ORG','Kpis','Integer NULL');
      AddField('ORG','ComputersS','Integer NULL');
      AddField('ORG','SoftwareNumS','Integer NULL');
      AddField('ORG','KpisS','Integer NULL');

// 8

    DoSQL('Drop View PersonreservChkInfoBase', True);
    DoSQL(
      'Create View PersonreservChkInfoBase As '#13+
      'SELECT '#13+
      '  P.PERS_ID, P.IS_WAR, P.W_DEND, P.SpecialWUchet1, P.BIRTHDAY, P.Male, R.CHE, R.LIMIT1, '#13+
      '  IIf(ISNULL(P.WUCHET2),0,1) AS Reserved, '#13+
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
      '      PDP.Age < Year(Date())-Year(P.BIRTHDAY) And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ),1,0) AS DefPOST '#13+
      'FROM ((Person AS P LEFT JOIN AppointmentLastAll ON P.PERS_ID=AppointmentLastAll.PERS_ID) '#13+
      'LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) '#13+
      'LEFT JOIN StaffList ON (AppointmentLastAll.POST_ID=StaffList.POST_ID) AND (AppointmentLastAll.DEP_ID=StaffList.DEP_ID) '
    );

    DoSQL('Update VerInfo Set '+
          'VerStr = ''3.77'', VerDesc = ''Версия релиза 3.77'', VerDate = #1/4/2012#');
  finally Free;
  end;
end;

end.

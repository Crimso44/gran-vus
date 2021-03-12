unit vur376;

interface

  function Patch376_GetInfo: string;
  function Patch376_GetStepCount: Integer;
  procedure Patch376_Process;

type
  TOKTMOList = array[1..126*2] of String;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs;

var
  OKTMO: TOKTMOList = (
'������������� ����������� ������ ������ ������� ���������� ��������� ������ ������������ ��������','45',
'�����������','45301000',
'�������','45302000',
'��������� ���������','45303000',
'���������','45304000',
'���������','45305000',
'����������','45306000',
'���������','45307000',
'������-���������','45308000',
'�����������','45309000',
'����������','45310000',
'������������','45311000',
'������','45312000',
'�������� ���������','45313000',
'��������� ����','45314000',
'����������','45315000',
'��������������','45316000',
'�������','45317000',
'������������','45318000',
'����������','45319000',
'�������','45320000',
'���������','45321000',
'����-�����������','45322000',
'�������-�����������','45323000',
'�������� �����������','45324000',
'�������','45325000',
'��������','45326000',
'���������-��������','45327000',
'��������� ����','45328000',
'����-���������','45329000',
'�������','45330000',
'���������','45331000',
'������','45332000',
'��������','45333000',
'�������','45334000',
'���������������','45335000',
'����������','45336000',
'��������� ��������','45337000',
'�����������','45338000',
'�����������','45339000',
'�������� ��������','45340000',
'�������','45341000',
'������������','45342000',
'��������������','45343000',
'�����������','45344000',
'�����','45345000',
'�������������','45346000',
'�������','45347000',
'�����������','45348000',
'������������','45349000',
'������������','45350000',
'������������','45351000',
'��������','45352000',
'���������','45353000',
'���������','45354000',
'����������������','45355000',
'�������','45356000',
'������� ����','45357000',
'������������','45358000',
'��������','45359000',
'���������','45360000',
'��������','45361000',
'�������� ����������','45362000',
'��������','45363000',
'����� ����������','45364000',
'�����������','45365000',
'�������','45366000',
'������','45367000',
'����������-���������','45368000',
'�������� ������','45369000',
'��������','45370000',
'��������-��������','45371000',
'������','45372000',
'����� ������','45373000',
'�����','45374000',
'���������','45375000',
'�������������','45376000',
'�������','45377000',
'��������������','45378000',
'���������','45379000',
'�����������','45380000',
'���������','45381000',
'��������','45382000',
'���������','45383000',
'��������','45384000',
'������-��������','45385000',
'�������','45386000',
'���������','45387000',
'���������','45388000',
'�������','45389000',
'�������','45390000',
'����������','45391000',
'�������������','45392000',
'���������','45393000',
'���������','45394000',
'������������','45395000',
'������������','45396000',
'�������������','45397000',
'�����������','45398000',
'������','45901000',
'��������','45902000',
'��������','45903000',
'�������������','45904000',
'�����������','45905000',
'�������� ������','45906000',
'������ ����','45907000',
'���������','45908000',
'����� ������','45909000',
'�������','45910000',
'�������� ���������','45911000',
'�������� ��������','45912000',
'��������','45913000',
'�����������','45914000',
'�������','45915000',
'���������','45916000',
'�����������-��������','45917000',
'��������-���������','45918000',
'����������� �����','45919000',
'��������','45920000',
'�������-�������� ��������','45921000',
'�������-�������� �����','45922000',
'��������','45923000',
'��������� ��������','45924000',
'��������� �����������','45925000',
'��������� �����','45926000',
'������ �������','459272000');





function Patch376_GetInfo: string;
begin
  Result :=
   '������ 3.76:'#13+
   '  - � �������� "�������� ����" ��������� ���� "�������� ������ ��������"'#13+
   '  - � ��������� �� ���������� � ������� ������ ���������� ������������ �������� � �������������� ��������� �������������� ������� � � ��� ����������� �� �������������� �������'#13+
   '  - � ������� "��������� �� ���������� � ������� ������ ���������� � ��������" ��������� ���� "��������� �" � "����"'#13+
   '  - ��� �������� ���������� ����������� ��������� ������������� �������������� �������� � ���������� ���������� � ������� ����������'#13+
   '  - �������� ����� �� ���������� � �������������� � ������ ���� "������� ���������� � ���� ����� ����������"'#13+
   '  - �������� ����� "������ ������� �������� ���� 15- � 16-������� ��������"'#13+
   '  - � ������� ������������ ��������� ����������� ���������� � ����������'#13+
   '  - � ������������ "���������" � "������������� �����������" ������� ������ ����������'#13+
   '  - �������� ������ "��������� � ����������� ��������" � "������ � ���"'#13+
   '  - ��������� ��������� ���� � ���������'#13+
   '  - ���������� "����������" ������� �� "������ ������� ������������� (������������� �������)"'#13+
   '  - �������� ���������� �����'#13+
   '  - ������� ������ ������� ����� � 6 �����������';
end;

function Patch376_GetStepCount: Integer;
begin
  Result := 7;
end;

procedure Patch376_Process;
var
  Q: TADOQuery;
  i: Integer;

  procedure DoSQL(const ASQL: String; const NoCount: Boolean = False);
  begin
    with Q do
    try
      SQL.Text := ASQL;
      ExecSQL;
    except {} end;
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
    fmMain.lbProcState.Caption := '�������� ������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
//1
    fmMain.lbProcState.Caption := '��������� � ��������� ����������...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('alter table PERSON Alter Comments Memo', True);
    DoSQL('alter table PERSON Add Warfare Text(255)', True);
    DoSQL('Insert Into KL_FLDGROUPS (Group_Id, Group_Name) Values (10, "������������� ������")');
//2
    fmMain.lbProcState.Caption := '��������� � "��������� �� ���������� � ������� ������"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('alter table PersonChanges Add OutNumber Text(255), OutDate Datetime');
//3
    fmMain.lbProcState.Caption := '������� �� ������ ���������� ������������ "���������" � "������������� �����������"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('alter table KPOST Alter POST_NAME Text(255)', True);
    DoSQL('alter table KPOST Add KPost_Num Integer', True);
    DoSQL('Update KPOST set KPOST_Num = Post_Id', True);
    DoSQL('alter table KL_DATA Add HandSort Text(50)', True);
    DoSQL('Update KL_DATA set HandSort = "KPOST_Num" Where KL_NAME = "KPOST"', True);
    DoSQL('alter table KDEPART Add KDEPART_Num Integer', True);
    DoSQL('Update KDEPART set KDEPART_Num = Dep_Id', True);
    DoSQL('Update KL_DATA set HandSort = "KDEPART_Num" Where KL_NAME = "KDEPART"');
//4
    fmMain.lbProcState.Caption := '��������� ����������� "����������"...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    DoSQL('alter table KOVK Alter OVK_Phone Text(250)', True);
    DoSQL('alter table KL_Data Alter Disp_Name Text(150)', True);
    DoSQL('update KL_Data set Disp_Name = "������ ������� ������������� (������������� �������)" where KL_ID = 1', True);
    DoSQL('update KL_Fld set Disp_Name = "���������� ����� ������������ ������, �������� ��������� �������� ���� ''����� �������� ������������ ...'' ��� ''������������� ...''" where KL_Id = 1 and Fld_Name = "OVK_NAME"', True);
    DoSQL('update KL_Fld set Disp_Size = 200, Disp_Name = "�������������� ����������" where KL_Id = 1 and Fld_Name = "OVK_PHONE"', True);
    DoSQL('update KL_Fld set Disp_Size = 200, Disp_Name = "��������� �������� ���� ����� ��� (�� �������� - ���� ����� �������������)" where KL_Id = 1 and Fld_Name = "ISOVK"');

//5
    fmMain.lbProcState.Caption := '���������� ����������� �����...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;

    try
      DoSQL('Create table KOKTMO (' +
            'OKTMO_ID int not null primary key,' +
            'NAME varchar(150),' +
            'KODOKTMO varchar(20)' +
            ')', True);

      DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
            'VALUES (1, ''������������� ����������� ������������� �������'', ''11'')', True);
      DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
            'VALUES (2, ''������������� ������ ������������� �������'', ''11600000'')', True);
      DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
            'VALUES (3, ''�������� ������������� �����'', ''11605000'')', True);
      DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
            'VALUES (4, ''��������� ��������� ��������� �������������� ������'', ''11605100'')', True);
      DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
            'VALUES (5, ''- ��������'', ''11605101'')', True);
      DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
            'VALUES (6, ''�������� ��������� ��������� �������������� ������'', ''11605400'')', True);
      DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
            'VALUES (7, ''- �����������'', ''11605402'')', True);
      DoSQL('INSERT INTO KOKTMO (OKTMO_ID, NAME, KODOKTMO)'#13 +
            'VALUES (8, ''- ��������������'', ''11605404'')', True);

      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (33, ''KOKTMO'', ''������������� ���������� ������������� �����������'', 1, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (124, 33, ''OKTMO_ID'', ''��� ����������'', 99, 1, 0, 0, ' +
            '''{SQL:SELECT MAX(OKTMO_ID)+1 FROM KOKTMO}{TXT:1}'', 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (125, 33, ''NAME'', ''������������'', 300, 0, 1, 1, ' +
            'null, 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (126, 33, ''KODOKTMO'', ''���'', 250, 0, 1, 1, ' +
            '''{KODOKTMO}'', 0)', True);

      AddField('ORG','KODOKTMO','VARCHAR(11) NULL');

    except {} end;

    for i := 1 to 126 do
      DoSQL('insert into KOKTMO (OKTMO_ID,NAME,KODOKTMO) '+
            'select ID, NM, KOD from '+
            '(select max(OKTMO_ID)+1 as ID,"'+OKTMO[(i-1)*2+1]+'" As NM,"'+OKTMO[(i-1)*2+2]+'" AS KOD '+
            'from KOKTMO where not exists (select * from KOKTMO where KODOKTMO = "'+OKTMO[(i-1)*2+2]+'")) '+
            'where ID is not null', True);
    DoSQL('Update KOKTMO set KODOKTMO = KODOKTMO');
//6
    fmMain.lbProcState.Caption := '���������� ����� 6...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;

    AddField('KPOST','IsIgnore','bit NULL');
    DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
          'DEF_VALUE, HAS_NULL) VALUES (127, 4, ''IsIgnore'', ''������������ ��� ������� �������� �������� 1-12 �.� 6'', 200, 0, 1, 1, ' +
          '''false'', 1)', True);

    DoSQL('alter table KCPROF Alter CPROF_NAME Text(100)', True);
    DoSQL('alter table KCPROF Alter PRINT_NAME Text(100)', True);
    DoSQL('alter table FORM6 Alter PRINT_NAME Text(100)', True);
    DoSQL('Update KCPROF Set STATE = -1, PRINT_NAME = ''����������� � �����, �� ��� �� �������� ����� ������������� ������������'', '+
          'EXPRESSION = ''210+221+231+241+251+271+281+291+295'' '+
          'Where CPROF_ID = 200', True);
    DoSQL('Update KCPROF Set PRINT_NAME = ''A. �������� ���������'' '+
          'Where CPROF_ID = 210', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (221, ''����������� �� ������ �������� ����������'', ''C. ������ �������� ����������'', '+
          ''' '', 0, 4)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (231, ''����������� �� ��������������� ������������'', ''D. �������������� ������������'', '+
          ''' '', 0, 5)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (241, ''����������� �� ������������ � ������������� ��������������, ���� � ����'', ''E. ������������ � ������������� ��������������, ���� � ����'', '+
          ''' '', 0, 6)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (251, ''����������� �� �������������'', ''F. �������������'', '+
          ''' '', 0, 7)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (271, ''����������� �� ���������� � �����'', ''I. ��������� � �����'', '+
          ''' '', 0, 8)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (281, ''����������� �����������'', ''M. �����������'', '+
          ''' '', 0, 9)', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (291, ''����������� �� ��������������� � �������������� ���������� �����'', ''N. ��������������� � �������������� ���������� �����'', '+
          ''' '', 0, 10)', True);
    DoSQL('Update KCPROF Set LINE_NO = LINE_NO + 1 Where LINE_NO Between 11 and 13', True);
    DoSQL('Insert Into KCPROF (CPROF_ID, CPROF_NAME, PRINT_NAME, EXPRESSION, STATE, LINE_NO) '+
          'Values (295, ''����������� ������ ����� ������������� ������������'', ''������ ���� ������������� ������������'', '+
          ''' '', 0, 11)', True);
    DoSQL('Update KCPROF Set '+
          'EXPRESSION = ''410+440+450+460+470+480'' '+
          'Where CPROF_ID = 400', True);
    DoSQL('Update KCPROF Set '+
          'CPROF_NAME = ''�������, ������� �������� ������'', '+
          'PRINT_NAME = ''- ������� �������� ������'' '+
          'Where CPROF_ID = 410', True);
    DoSQL('Update KCPROF Set '+
          'PRINT_NAME = ''�� ����������� �������������, ������������ � �������:'' '+
          'Where CPROF_ID = 490', True);
    DoSQL('Update KCPROF Set LINE_NO = Null '+
          'Where CPROF_ID = 500', True);
    DoSQL('Update KCPROF Set PRINT_NAME = ''����� (����� ����� 1+2+12+13)'', '+
          'EXPRESSION = ''100+200+300+400'' '+
          'Where CPROF_ID = 1000', True);
    DoSQL('Update KCPROF Set PRINT_NAME = ''����� (����� ����� 22+23)'' '+
          'Where CPROF_ID = 2000', True);
    DoSQL('Update KCPROF Set LINE_NO = LINE_NO - 1 Where LINE_NO Between 16 and 22', True);
    DoSQL('Update KCPROF Set LINE_NO = LINE_NO - 2 Where LINE_NO > 23', True);
    DoSQL('Update KPOST Set CPROF_ID = 281 Where CPROF_ID in (250)', True);
    DoSQL('Update KPOST Set CPROF_ID = 291 Where CPROF_ID in (264, 265)', True);
    DoSQL('Update KPOST Set CPROF_ID = 295 Where CPROF_ID in (200, 220, 230, 240)', True);
    DoSQL('Update KPOST Set CPROF_ID = 410 Where CPROF_ID in (420, 430)', True);
    DoSQL('Delete From KCPROF Where CPROF_ID in (205, 220, 230, 240, 250, 260, 261, 264, 265, 401, 420, 430, 491)', True);
    //DoSQL('Update Form6 set col_10 = col_2 - col_6 - col_9', True);

    AddField('FORM6', 'COL_10T', 'Text(100)');
    AddField('FORM6', 'COL_12T', 'Text(100)');

    AddField('ORG', 'KODOKTMO2', 'Text(11)');
    AddField('ORG', 'REGPLACE', 'Text(100)');
    AddField('ORG', 'COMPUTERS', 'Integer');
    AddField('ORG', 'SOFTWARENUM', 'Integer');
    AddField('ORG', 'SOFTWARE', 'Text(255)');
    AddField('TPDPCond', 'Sex', 'Byte');

    DoSQL('UPDATE (org inner join kregpl on kregpl.regpl_id = org.regpl_id) SET regplace = regpl_name', True);
    DoSQL('Insert Into KDelayType (ID, DelayType) Values (5, ''�� ������ ��������'')', True);

    DoSQL('Drop View PDP', True);
    DoSQL(
      'Create View PDP As '#13+
      'SELECT TPDPPost.Post_ID AS POST_ID, TPDPCond.Limited AS Limited, TPDPCond.Age AS Age, TPDPCond.WRange AS WRange, TPDPCond.WSost AS WSost, KWRange.ChE AS ChE, '#13+
      'TPDPCond.Sex As Sex '#13+
      'FROM (TPDPPost INNER JOIN (TPDP INNER JOIN TPDPCond ON TPDP.id=TPDPCond.TPDP_ID) ON TPDPPost.TPDP_ID=TPDP.id) LEFT JOIN KWRANGE ON TPDPCond.WRange=KWRANGE.WRNG_ID',
    True);

    DoSQL('Drop View PersonreservChkInfoBase', True);
    DoSQL(
      'Create View PersonreservChkInfoBase As '#13+
      'SELECT '#13+
      '  P.PERS_ID, P.IS_WAR, P.W_DEND, P.SpecialWUchet1, P.BIRTHDAY, P.Male, R.CHE, R.LIMIT1, '#13+
      '  IIf(ISNULL(P.WUCHET2),0,1) AS Reserved, IIf(AppointmentLast.WTP_ID=1,1,0) AS MainWork, '#13+
      '  IIf(AppointmentLast.WCH_ID=1,1,0) AS PermanentWork, '#13+
      '  IIf(IIf(ISNULL(StaffList.WartimePlan),0,StaffList.WartimePlan)>0,1,0) AS WARTIME, '#13+
      '  IIF(EXISTS(SELECT * FROM KDEFVUS WHERE NAME = left(P.VUS, IIF((select state from KWRANGE where WRNG_ID = P.WRNG_ID) = 3, 6, 3))), 1,0) AS DefVUS, '#13+
      '  IIF(P.WUCHET1 LIKE (SELECT Template FROM Command300), 1,0) AS Command300, '#13+
      '  P.EOARMY_DATE AS EOARMY_YEAR, '#13+
      '  IIF(EXISTS( '#13+
      '    SELECT * FROM PDP   WHERE '#13+
      '      PDP.POST_ID = AppointmentLast.POST_ID AND '#13+
      '      (PDP.Limited = 0 OR P.WCAT="�") AND '#13+
      '      PDP.WSOST LIKE "%."&P.WSOST_ID&".%" AND '#13+
      '      (PDP.WRange=0 OR PDP.CHE >= R.CHE) AND '#13+
      '      PDP.Age < Year(Date())-Year(P.BIRTHDAY) And '#13+
      '      ((PDP.Sex=1 and P.Male=1) or (PDP.Sex=2 and P.Male<>1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) '#13+
      '    ),1,0) AS DefPOST '#13+
      'FROM ((Person AS P LEFT JOIN AppointmentLast ON P.PERS_ID=AppointmentLast.PERS_ID) LEFT JOIN KWRange AS R ON P.WRng_Id=R.WRng_Id) LEFT JOIN StaffList ON (AppointmentLast.POST_ID=StaffList.POST_ID) AND (AppointmentLast.DEP_ID=StaffList.DEP_ID) '
    );

//7
    DoSQL('alter table VV5 Alter NAME Text(100)', True);
    DoSQL('UPDATE VV5 SET NAME = ''����������� ������ �������������� ������ (����)'' WHERE KOD = ''01''', True);
    DoSQL('UPDATE VV5 SET NAME = ''�������� ��'' WHERE KOD = ''04''', True);
    DoSQL('UPDATE Org SET SBM_ID = 4 Where SBM_ID in (2,3)', True);
    DoSQL('Delete From VV5 Where ID in (2,3)', True);

    DoSQL('UPDATE KWSOST SET WSOST_NAME = ''���������� � �����������'' WHERE WSOST_ID = 5', True);
    DoSQL('UPDATE KWSOST SET WSOST_NAME = ''������������'' WHERE WSOST_ID = 7', True);
    DoSQL('UPDATE PERSON SET WSOST_ID = 7 WHERE WSOST_ID = 9', True);
    DoSQL('UPDATE PERSON SET WSOST_ID = 10 WHERE WSOST_ID = 11', True);
    DoSQL('DELETE From KWSOST WHERE WSOST_ID = 9', True);
    DoSQL('DELETE From KWSOST WHERE WSOST_ID = 11');
//8
    DoSQL('Update VerInfo Set '+
          'VerStr = ''3.76'', VerDesc = ''������ ������ 3.76'', VerDate = #27/10/2010#');
  finally Free;
  end;
end;

end.

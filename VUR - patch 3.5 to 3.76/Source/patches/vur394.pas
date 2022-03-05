unit vur394;

interface

  function Patch394_GetInfo: string;
  function Patch394_GetStepCount: Integer;
  procedure Patch394_Process;

implementation

uses Classes,Forms,MainForm,ADODb,SysUtils,StrUtils,Registry,Variants,Dialogs, BirthDay;


function Patch394_GetInfo: string;
begin
  Result :=
   '������ 3.82.2'#13;
end;

function Patch394_GetStepCount: Integer;
begin
  Result := 1;
end;

procedure Patch394_Process;
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

      DoSQL('Create table KVodUd (' +
            'Code Varchar(4) NOT NULL Primary Key,' +
            'Name Varchar(255) NULL' +
            ')', True);
      DoSQL('INSERT INTO KL_DATA (KL_ID, KL_NAME, DISP_NAME, IS_EDIT, CHK_DEL) ' +
            'VALUES (49, "KVodUd", "��������� ������������� �������������", 0, ' +
            'null)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (183, 49, "Code", "���", 99, 1, 1, 1, ' +
            '"{Type:OKVED}", 0)', True);
      DoSQL('INSERT INTO KL_FLD (FLD_ID, KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, '+
            'DEF_VALUE, HAS_NULL) VALUES (184, 49, "Name", "������������", 200, 0, 1, 1, ' +
            'null, 0)', True);

      DoSQL('Insert into KVodUd (Code, Name) values (''A'', ''���������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''A1'', ''������ ���������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''B'', ''�������� ����������, ��������� ��������� (�� 3,5 ����)'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''BE'', ''�������� ���������� � ��������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''B1'', ''��������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''C'', ''�������� ���������� (�� 3,5 ����)'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''CE'', ''�������� ���������� � ��������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''C1'', ''������� ��������� (�� 3,5 �� 7,5 ����)'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''C1E'', ''������� ��������� � ��������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''D'', ''��������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''DE'', ''�������� � ��������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''D1'', ''��������� ��������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''D1E'', ''��������� �������� � ��������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''M'', ''������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''Tm'', ''�������'')', True);
      DoSQL('Insert into KVodUd (Code, Name) values (''Tb'', ''�����������'')', True);

            AddField('Person', 'VodUdSer', 'varchar(4) NULL');
            AddField('Person', 'VodUdNum', 'varchar(20) NULL');
            AddField('Person', 'KVodUd', 'varchar(50) NULL');
            AddField('Person', 'KVodUdTxt', 'varchar(255) NULL');
            AddField('Person', 'VodUdDate', 'DateTime NULL');
            AddField('Person', 'WUch2_ListNumb', 'varchar(20) NULL');
            AddField('Person', 'WUch2_ListDate', 'DateTime NULL');
            AddField('Person', 'VodUdDate', 'DateTime NULL');
            AddField('Appointment', 'XOVK_ID', 'int NULL');
            AddField('Appointment', 'OVK_Date', 'DateTime NULL');
            AddField('Appointment', 'OVK_Num', 'varchar(255) NULL');
            AddField('Family', 'Fam_Place', 'varchar(255) NULL');
            AddField('Educ', 'IsMain', 'bit NULL');

      DoSQL('Insert Into Params (Param_Id, Param_Name, Param_Value) Values ('+
          '15, ''��������� � ����� � 10 ���� ��� ���������� ����������'',''1'')', True);


    DoSQL('Update VerInfo Set '+
          'VerStr = ''3.82.2'', VerDesc = ''������ ������ 3.82.2'', VerDate = #01/03/2022#');


  finally Free;
  end;
end;

end.


unit vur370;

interface

  function Patch370_GetInfo: string;
  function Patch370_GetStepCount: Integer;
  procedure Patch370_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils,Dialogs,DB, vur370Users, MD5,
  vur370Post, IniFiles, Registry, Classes;

function Patch370_GetInfo: string;
begin
  Result :=
   'Версия 3.70:'#13+
   '  - изменилась структура главного меню'#13+
   '  - введена множественность пользователей с раздачей прав'#13+
   '  - запрещён пользовательский пароль менее шести символов'#13+
   '  - добавлен журнал событий'#13+
   '  - добавлено штатное расписание'#13+
   '  - добавлена выписка из перечня бронируемых должностей'#13+
   '  - введён новый алгоритм правильности бронирования'#13+
   '  - введена история назначений работника'#13+
   '  - в карточке работника добавлен реквизит "Год/дата увольнения из армии"'#13+
   '  - в карточке работника добавлен реквизит "Спецформирование"'#13+
   '  - реквизит "категория должности" стал аттрибутом должности'#13+
   '  - код ВУО расширен до 20-ти цифр'#13+
   '  - код ОКПДТР должности расширен до 17 символов'#13+
   '  - "Всего работающих" для формы 6 вводится в штатном расписании'#13+
   '  - добавлены значения "для печати" в словари, помеченные жёлтым цветом'#13+
   '  - сокращён словарь видов семейных положений'#13+
   '  - введён шаблон команды в моб.предписании, не подлежащей бронированию'#13+
   '  - прочее...';
end;

function Patch370_GetStepCount: Integer;
begin
  Result := 5;
end;

procedure Patch370_Process;
var FConnectionString: String;
//
  function ClearAll: Boolean;
  const
    taCount = 31;
    Tables: array [1..taCount] of String =(
      'Event',
      'EventDetail',
      'KDefVUS',
      'TPDP',
      'TPDPCond',
      'TPDPPost',
      'Users',
      'ADDR',
      'FAMILY',
      'FORM6',
      'FORM6HDR',
      'KDEPART',
      'KLANGSK',
      'KONH',
      'KOVK',
      'KSCIENCE',
      'KTERR',
      'KUZ',
      'LANGS',
      'ORG_CONT',
      'ORG_PAYM',
      'PERS_SET',
      'PHONES',
      'RES_LIST',
      'ORG',
      'KPOST',
      'OSN',
      'PERSON',
      'EDUC',
      'Appointment',
      'StaffList');
  var
    I: Integer;
    ft: TFieldType;
    fn: String;
  begin
    Result := False;
    with TADOQuery.Create(nil) do
    try
      ConnectionString := FConnectionString; ParamCheck := False;
      for I := 1 to taCount do begin
        fmMain.lbProcState.Caption := 'Подготовка таблицы '+Tables[I]+'...';
        Application.ProcessMessages;
        if fmMain.FBreak then Exit;
        SQL.Text := 'DELETE FROM ['+Tables[I]+']'; ExecSQL;
        SQL.Text := 'SELECT * FROM ['+Tables[I]+']'; Open;
        with Fields[0] do begin ft := DataType; fn := FieldName; end;
        Close;
        if ft = ftAutoInc then begin
          SQL.Text := 'ALTER TABLE ['+Tables[I]+'] ALTER COLUMN ['+fn+'] Counter(1,1)';
          ExecSQL;
        end;
      end;
    finally Free;
    end;
    Result := True;
  end;
//
  function CopyAll: Boolean;
  const
    taCount = 25;
    Tables: array [1..taCount] of String =(
      'Users',
      'ADDR',
      'FAMILY',
      'FORM6',
      'FORM6HDR',
      'KDEPART',
      'KLANGSK',
      'KONH',
      'KOVK',
      'KSCIENCE',
      'KTERR',
      'KUZ',
      'LANGS',
      'ORG_CONT',
      'ORG_PAYM',
      'PERS_SET',
      'PHONES',
      'RES_LIST',
      'ORG',
      'KPOST',
      'OSN',
      'PERSON',
      'EDUC',
      'Appointment',
      'StaffList');
  //
    procedure CopyDefault(ATable: String);
    var
      qO, qN : TADOQuery;
      I      : Integer;
      NF     : TField;
    begin
      qO := TADOQuery.Create(nil);
      qN := TADOQuery.Create(nil);
      qO.Connection := fmMain.dbConn; qO.ParamCheck := False;
      qN.ConnectionString := FConnectionString; qN.ParamCheck := False;
      try
        qO.SQL.Text := 'SELECT * FROM ['+ATable+']'; qO.Open;
        qN.SQL.Text := 'SELECT * FROM ['+ATable+']'; qN.Open;
        while not qO.Eof do begin
          qN.Append;
          for I := 0 to qO.FieldCount-1 do begin
            NF := qN.FindField(qO.Fields[I].FieldName);
            if not Assigned(NF) then Continue;
            if NF.DataType=qO.Fields[I].DataType
            then NF.Value := qO.Fields[I].Value
            else
              if (NF.DataType=ftInteger) and (qO.Fields[I].DataType=ftWideString)
              then NF.Value := StrToIntDef(qO.Fields[I].AsString,0);//Person.Numb_T2
          end;
          qN.Post;
          qO.Next;
        end;
      finally qN.Free; qO.Free;
      end;
    end;
  //
    procedure CopyFamily;
    begin
      CopyDefault('FAMILY');
      with TADOQuery.Create(nil) do
      try
        ConnectionString := FConnectionString; ParamCheck := False;
        SQL.Text := 'UPDATE (SELECT * FROM [FAMILY] WHERE [FT_ID] IN (7,8,9,10,17,18,19,20,21,22)) SET [FT_ID] = 23';
        ExecSQL;
        SQL.Text := 'UPDATE (SELECT * FROM [FAMILY] WHERE [FT_ID] IN (13,14,15,16)) SET [FT_ID] = [FT_ID]-10';
        ExecSQL;
      finally Free;
      end;
    end;
  //
    procedure CopyUsers;
    begin
      with TfrmVur370Users.Create(fmMain) do
      try
        ShowModal;
        with TADOQuery.Create(nil) do
        try
          ConnectionString := FConnectionString; ParamCheck := False;
          SQL.Text := Format(
            'INSERT INTO [Users]([Login],[Fam],[Im],[Otch],[HASH],[rAdmin],[rImport],[rExport],[rPrint],[rEdit],[rLogin]) '+
            'VALUES(''ADMIN'', %s, %s, %s, %s, 1,1,1,1,1,1)',
            [QuotedStr(Trim(edFam.Text))
            ,QuotedStr(Trim(edIm.Text))
            ,QuotedStr(Trim(edOtch.Text))
            ,QuotedStr(StrMD5('ADMIN'+edPsw.Text))]);
          ExecSQL;
        finally Free;
        end;
      finally Free;
      end;
    end;
  //
    procedure CopyPOST;
    var f: TfrmVur370Post;
    begin
      CopyDefault('KPOST');
      with TADOQuery.Create(nil) do
      try
        ConnectionString := FConnectionString; ParamCheck := False;
        SQL.Text := 'UPDATE [KPOST] SET [OKPDTR_NAME] = [POST_NAME]';
        ExecSQL;
        Connection := fmMain.dbConn;
        SQL.Text :=
          'SELECT a.[POST_ID], a.[CPROF_ID]'+
          '  FROM (SELECT [POST_ID], [CPROF_ID], Count([PERS_ID]) AS Qty'+
          '          FROM [Person] P GROUP BY [POST_ID], [CPROF_ID]) a'+
          '  WHERE NOT EXISTS'+
          '  (SELECT * FROM (SELECT [POST_ID], [CPROF_ID], Count([PERS_ID]) AS Qty'+
          '                    FROM [Person] GROUP BY [POST_ID], [CPROF_ID]) b'+
          '    WHERE a.[POST_ID]=b.[POST_ID]AND a.Qty<b.Qty)';
        Open;
        f := TfrmVur370Post.Create(fmMain);
        try
          f.qrPost.ConnectionString  := FConnectionString; f.qrPost.ParamCheck := False;
          f.qrCProf.ConnectionString := FConnectionString; f.qrCProf.ParamCheck := False;
          f.qrPost.Open;
          while not Eof do begin
            if f.qrPost.Locate('POST_ID',Fields[0].Value,[]) then begin
              f.qrPost.Edit;
              f.qrPostCPRof_ID.Value := Fields[1].Value;
              f.qrPost.Post;
            end;
            Next;
          end;
          f.qrPost.First;
          f.ShowModal;
        finally f.Free;
        end;
      finally Free;
      end;
    end;
  //
    procedure CopyOSN;
    begin
      CopyDefault('OSN');
      with TADOQuery.Create(nil) do
      try
        ConnectionString := FConnectionString; ParamCheck := False;
        SQL.Text := 'UPDATE (SELECT * FROM [OSN] WHERE NOT [BASE_ID] IN (SELECT [ID] FROM [VV3])) SET [BASE_ID] = NULL';
        ExecSQL;
      finally Free;
      end;
    end;
  //
    procedure CopyPerson;
    begin
      CopyDefault('Person');
      with TADOQuery.Create(nil) do
      try
        ConnectionString := FConnectionString; ParamCheck := False;
        SQL.Text := 'UPDATE [Person] SET [OUT_DATE] = [OUT_ORD_DATE]';
        ExecSQL;
      finally Free;
      end;
    end;
  //
    procedure CopyEduc;
    var AID, AType: Integer;
    begin
      CopyDefault('Educ');
      with TADOQuery.Create(nil) do
      try
        ConnectionString := FConnectionString; ParamCheck := False;
        SQL.Text := 'SELECT * FROM [EDUC] ORDER BY [PERS_ID], [EDQ_ID]';
        Open; AID := -1; AType := 1;
        while not Eof do begin
          Edit;
          if FieldByName('PERS_ID').AsInteger <> AID then begin
            AID := FieldByName('PERS_ID').AsInteger; AType := 1;
          end;
          FieldByName('Type').AsInteger := AType;
          Inc(AType);
          Post;
          Next;
        end;
      finally Free;
      end;
    end;
  //
    procedure CopyAppointment;
    var
      qO, qN : TADOQuery;
    begin
      qO := TADOQuery.Create(nil);
      qN := TADOQuery.Create(nil);
      qO.Connection := fmMain.dbConn; qO.ParamCheck := False;
      qN.ConnectionString := FConnectionString; qN.ParamCheck := False;
      try
        qO.SQL.Text := 'SELECT [PERS_ID],[WTP_ID],[WCH_ID],[POST_ID],'+
                       '[DEP_ID],[IN_ORD_NUMB],[IN_ORD_DATE] FROM [Person]';
        qO.Open;
        qN.SQL.Text := 'SELECT * FROM [Appointment]';
        qN.Open;
        while not qO.Eof do begin
          qN.Append;
          qN.FieldByName('PERS_ID')     .Value := qO.FieldByName('PERS_ID').Value;
          qN.FieldByName('WTP_ID')      .Value := qO.FieldByName('WTP_ID').Value;
          qN.FieldByName('WCH_ID')      .Value := qO.FieldByName('WCH_ID').Value;
          qN.FieldByName('POST_ID')     .Value := qO.FieldByName('POST_ID').Value;
          qN.FieldByName('DEP_ID')      .Value := qO.FieldByName('DEP_ID').Value;
          qN.FieldByName('IN_ORD_NUMB') .Value := qO.FieldByName('IN_ORD_NUMB').Value;
          qN.FieldByName('IN_ORD_DATE') .Value := qO.FieldByName('IN_ORD_DATE').Value;
          qN.FieldByName('IN_DATE')     .Value := qO.FieldByName('IN_ORD_DATE').Value;
          if qN.FieldByName('IN_DATE').IsNull then qN.FieldByName('IN_DATE').Value := Date;
          qN.Post;
          qO.Next;
        end;
      finally qN.Free; qO.Free;
      end;
    end;
  //
    procedure CopyStaffList;
    var
      qO, qN : TADOQuery;
    begin
      qO := TADOQuery.Create(nil);
      qN := TADOQuery.Create(nil);
      qO.Connection := fmMain.dbConn; qO.ParamCheck := False;
      qN.ConnectionString := FConnectionString; qN.ParamCheck := False;
      try
        qO.SQL.Text :=
          'SELECT dp.[DEP_ID] '+
          '     , dp.[POST_ID] '+
          '     , COUNT(a.[PERS_ID]) as GeneralPlan '+
          '     , COUNT(a.[PERS_ID]) as WartimePlan '+
          '     , COUNT(a.[PERS_ID]) as GeneralQty '+
          '     , 0                  as GeneralVacancy '+
          '     , 0                  as WartimeVacancy '+
          '  FROM (SELECT [DEP_ID], [POST_ID] FROM [KDEPART], [KPOST]) dp '+
          '       LEFT OUTER JOIN [Person] a ON a.[DEP_ID]=dp.[DEP_ID] AND a.[POST_ID]=dp.[POST_ID] '+
          'GROUP BY dp.[DEP_ID], dp.[POST_ID]';
        qO.Open;
        qN.SQL.Text := 'SELECT * FROM [StaffList]';
        qN.Open;
        while not qO.Eof do begin
          qN.Append;
          qN.FieldByName('DEP_ID')         .Value := qO.FieldByName('DEP_ID').Value;
          qN.FieldByName('POST_ID')        .Value := qO.FieldByName('POST_ID').Value;
          qN.FieldByName('GeneralPlan')    .Value := qO.FieldByName('GeneralPlan').Value;
          qN.FieldByName('WartimePlan')    .Value := qO.FieldByName('WartimePlan').Value;
          qN.FieldByName('GeneralVacancy') .Value := qO.FieldByName('GeneralVacancy').Value;
          qN.FieldByName('WartimeVacancy') .Value := qO.FieldByName('WartimeVacancy').Value;
          qN.Post;
          qO.Next;
        end;
      finally qN.Free; qO.Free;
      end;
    end;
  //
  var I: Integer;
  begin
    Result := False;
    for I := 1 to taCount do begin
      fmMain.lbProcState.Caption := 'Заполнение таблицы '+Tables[I]+'...';
      Application.ProcessMessages;
      if fmMain.FBreak then Exit;
      if SameText(Tables[I],'Users')       then CopyUsers       else
      if SameText(Tables[I],'Family')      then CopyFamily      else
      if SameText(Tables[I],'KPost')       then CopyPOST        else
      if SameText(Tables[I],'OSN')         then CopyOSN         else
      if SameText(Tables[I],'Person')      then CopyPerson      else
      if SameText(Tables[I],'Educ')        then CopyEduc        else
      if SameText(Tables[I],'Appointment') then CopyAppointment else
      if SameText(Tables[I],'StaffList')   then CopyStaffList   else
      CopyDefault(Tables[I]);
    end;
    Result := True;
  end;
//
  function SwapMDB: Boolean;
  var OFN, BFN, UFN, Msg: String;  //Old File Name, BAK File Name, Upgrade File Name
  begin
    Result := False;
    fmMain.lbProcState.Caption := 'Замена файла базы данных...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    OFN := fmMain.dbConn.Properties['Data Source'].Value;
    BFN := ChangeFileExt(fmMain.dbConn.Properties['Data Source'].Value,'.bak');
    fmMain.dbConn.Close;
    if FileExists(BFN) then DeleteFile(BFN);
    if not RenameFile(OFN, BFN) then begin
      ShowMessage('Не удалось произвести замену файлов баз данных. Возможно, файлы заняты другими программами.');
      Exit;
    end;
    fmMain.dbConn.ConnectionString := FConnectionString;
    UFN := fmMain.dbConn.Properties['Data Source'].Value;
    if not RenameFile(UFN, OFN) then begin
      Msg := Format('Не удалось переименовать файл "%s" в "%s".', [UFN, OFN]);
      if not SameText(ExtractFileDrive(UFN),ExtractFileDrive(OFN)) then
        Msg := Msg+#13'Вероятнее всего, причина в том, что старый файл и '+
                      'файл обновления находятся на разных устройствах. '+
                      'Вы можете самостоятельно скопировать файл данных или '+
                      'настроить подключение к базе данных.';
      ShowMessage(Msg);
      Exit;
    end;
    Result := True;
  end;
//
  function SetRegistry: Boolean;
  var
    SL  : TStringList;
    INI : TIniFile;
    REG : TRegIniFile;
  //
    procedure CopySection(Section: String);
    var I: Integer;
    begin
      SL.Clear;
      INI.ReadSectionValues(Section,SL);
      for I := 0 to SL.Count-1 do REG.WriteString(Section,SL.Names[I],SL.ValueFromIndex[I]);
    end;
  //
  begin
    Result := False;
    fmMain.lbProcState.Caption := 'Установка ключей реестра...';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    SL := TStringList.Create;
    try
      INI := TIniFile.Create(IncludeTrailingPathDelimiter(fmMain.edPath.Text)+'settings.ini');
      try
        REG := TRegIniFile.Create('Software\Granit\GranVus\Settings');
        try
          CopySection('CONNECTION');
          CopySection('FORM6');
          CopySection('COMMON');
          CopySection('PATHS');
        finally REG.Free;
        end;
      finally INI.Free;
      end;
    finally SL.Free;
    end;
    Result := True;
  end;
//
begin
//1
  fmMain.lbProcState.Caption := 'Подключение к базе данных нового формата...';
  Application.ProcessMessages;
  if fmMain.FBreak then Exit;
  FConnectionString :=
     StringReplace(fmMain.dbConn.ConnectionString,
                   fmMain.dbConn.Properties['Data Source'].Value,
                   IncludeTrailingPathDelimiter(fmMain.edPath.Text)+'DATA\granvus370.mdb',
                   [rfReplaceAll, rfIgnoreCase])+
    ';Jet OLEDB:Database Password='+ReverseString('9011ets18q54');
  with TADOQuery.Create(nil) do
  try
    ConnectionString := FConnectionString; ParamCheck := False;
    SQL.Text := 'SELECT * FROM Event';
    try Open; Close; //Test
    except
      ShowMessage('Не удалось подключиться к базе данных нового формата!');
      Exit;
    end;
  finally Free;
  end;
  fmMain.pbMain.StepIt;
//2
  if not ClearAll then Exit;
  fmMain.pbMain.StepIt;
//3
  if not CopyAll then Exit;
  fmMain.pbMain.StepIt;
//4
  if not SwapMDB then Exit;
  fmMain.pbMain.StepIt;
//5
  if not SetRegistry then Exit;
  fmMain.pbMain.StepIt;

  with TRegistryIniFile.Create('Software\Granit\GranVus\Settings') do
  try
    fmMain.dbConn.Close;
    fmMain.dbConn.ConnectionString := ReadString('CONNECTION','CONNECTION_STRING',EmptyStr);
    fmMain.dbConn.LoginPrompt := ReadBool('CONNECTION','CONNECTION_PROMPT',false);
    fmMain.dbConn.ConnectionTimeout := ReadInteger('CONNECTION','CONNECTION_TIMEOUT',150);
    fmMain.dbConn.CommandTimeout := ReadInteger('CONNECTION','COMMAND_TIMEOUT',300);
    fmMain.dbConn.Properties['Jet OLEDB:Database Password'].Value := ReverseString('9011ets18q54');
  finally Free;
  end;

end;

end.


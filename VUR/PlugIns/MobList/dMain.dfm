object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 479
  Width = 741
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    Charset = DEFAULT_CHARSET
    Lang = 1049
    Options = [eoGraphicsBinary, eoClearMissedFields, eoDotAsColon]
    DisableControls = True
    Left = 32
    Top = 68
  end
  object dbMain: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Pr' +
      'ogram Files\GranVUS\Data\granvus.mdb;Mode=Share Deny None;Jet OL' +
      'EDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Data' +
      'base Password=45q81ste1109;Jet OLEDB:Engine Type=5;Jet OLEDB:Dat' +
      'abase Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLE' +
      'DB:Global Bulk Transactions=1;Jet OLEDB:New Database Password=""' +
      ';Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Databa' +
      'se=False;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:' +
      'Compact Without Replica Repair=False;Jet OLEDB:SFP=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 16
  end
  object qrPers: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    BeforeOpen = qrPersBeforeOpen
    AfterClose = qrPersAfterClose
    OnCalcFields = qrPersCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT PERSON.*, app.DEP_ID, app.Post_Id,'
      
        '  KWR.WRNG_NAME + iif((select Param_Value from Params Where Para' +
        'ms.Param_Id = 8) = '#39'1'#39', iif(PERSON.WSOST_ID=9,'#39' '#1102#1089#1090#1080#1094#1080#1080#39',iif(PER' +
        'SON.WSOST_ID=10,'#39' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#39','#39#39')),'#39#39') as WRNG_Name1'
      'FROM ((PERSON'
      '     LEFT OUTER JOIN AppointmentLast app'
      'on PERSON.Pers_Id = app.Pers_Id)'
      'left outer join KWRANGE KWR  on (PERSON.WRNG_ID=KWR.WRNG_ID))'
      'left outer join KDepart on KDepart.dep_id = app.dep_id'
      'WHERE '
      '    (W_DEND is NULL or Year(W_DEND) < Year(Date()))'
      '  AND (WUCHET1 IS NOT NULL)'
      '  AND (WUCHET1<>'#39#39')'
      '  AND IS_WAR<>0'
      '  AND ((select COUNT(*) from PERS_SET)=0'
      '     or PERSON.PERS_ID in (select PERS_ID from PERS_SET))'
      ' AND '
      
        '(((select max(In_Date) from Appointment where pers_id = PERSON.p' +
        'ers_id and post_id in (select post_id from kpost where cprof_id ' +
        '<> 500)) IS NOT NULL AND PERSON.OUT_ORD_DATE IS NULL)'
      
        'OR ((select max(In_Date) from Appointment where pers_id = PERSON' +
        '.pers_id and post_id in (select post_id from kpost where cprof_i' +
        'd = 500)) IS NOT NULL AND PERSON.ORDERDISMISSAL_DATE IS NULL))')
    Left = 80
    Top = 16
    object qrPersWRNG_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'WRNG_NAME'
      Size = 100
      Calculated = True
    end
    object qrPersDEP_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'DEP_NAME'
      Size = 100
      Calculated = True
    end
    object qrPersOVK_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'OVK_NAME'
      Size = 250
      Calculated = True
    end
    object qrPersDEP_ID: TIntegerField
      FieldName = 'DEP_ID'
    end
    object qrPersRecNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'RecNo'
      Calculated = True
    end
    object qrPersPost_Id: TIntegerField
      FieldName = 'Post_Id'
    end
    object qrPersPOST_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'POST_NAME'
      Size = 100
      Calculated = True
    end
    object qrPersWRNG_Name1: TStringField
      FieldName = 'WRNG_Name1'
      Size = 100
    end
    object qrPersWRNG_ID: TIntegerField
      FieldName = 'WRNG_ID'
    end
    object qrPersOVK_ID: TIntegerField
      FieldName = 'OVK_ID'
    end
    object qrPersPERS_ID: TIntegerField
      FieldName = 'PERS_ID'
    end
    object qrPersORG_ID: TIntegerField
      FieldName = 'ORG_ID'
    end
    object qrPersFAM: TWideStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrPersIM: TWideStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrPersOTCH: TWideStringField
      FieldName = 'OTCH'
      Size = 50
    end
    object qrPersMALE: TSmallintField
      FieldName = 'MALE'
    end
    object qrPersBIRTHDAY: TDateTimeField
      FieldName = 'BIRTHDAY'
    end
    object qrPersBIRTHPLACE: TWideStringField
      FieldName = 'BIRTHPLACE'
      Size = 100
    end
    object qrPersOKATO: TWideStringField
      FieldName = 'OKATO'
      Size = 11
    end
    object qrPersNAT_ID: TIntegerField
      FieldName = 'NAT_ID'
    end
    object qrPersPSP_SER: TWideStringField
      FieldName = 'PSP_SER'
      Size = 10
    end
    object qrPersPSP_NUM: TWideStringField
      FieldName = 'PSP_NUM'
      Size = 10
    end
    object qrPersPSP_PLACE: TWideStringField
      FieldName = 'PSP_PLACE'
      Size = 100
    end
    object qrPersPSP_DATE: TDateTimeField
      FieldName = 'PSP_DATE'
    end
    object qrPersINN: TWideStringField
      FieldName = 'INN'
      Size = 12
    end
    object qrPersSTRAH: TWideStringField
      FieldName = 'STRAH'
    end
    object qrPersFST_ID: TIntegerField
      FieldName = 'FST_ID'
    end
    object qrPersED_ID: TIntegerField
      FieldName = 'ED_ID'
    end
    object qrPersSC_ID: TIntegerField
      FieldName = 'SC_ID'
    end
    object qrPersIS_WAR: TSmallintField
      FieldName = 'IS_WAR'
    end
    object qrPersEOARMY_DATE: TWideStringField
      FieldName = 'EOARMY_DATE'
      Size = 10
    end
    object qrPersCSOST: TSmallintField
      FieldName = 'CSOST'
    end
    object qrPersWSOST_ID: TIntegerField
      FieldName = 'WSOST_ID'
    end
    object qrPersCAT_ZAP: TSmallintField
      FieldName = 'CAT_ZAP'
    end
    object qrPersVUS: TWideStringField
      FieldName = 'VUS'
      Size = 10
    end
    object qrPersWCAT: TWideStringField
      FieldName = 'WCAT'
      Size = 1
    end
    object qrPersWUCHET1: TWideStringField
      FieldName = 'WUCHET1'
      Size = 100
    end
    object qrPersSpecialWUchet1: TIntegerField
      FieldName = 'SpecialWUchet1'
    end
    object qrPersWUCHET2: TWideStringField
      FieldName = 'WUCHET2'
      Size = 100
    end
    object qrPersWDISCL: TWideStringField
      FieldName = 'WDISCL'
      Size = 100
    end
    object qrPersTAB_NUMB: TWideStringField
      FieldName = 'TAB_NUMB'
      Size = 10
    end
    object qrPersDOG_NUMB: TWideStringField
      FieldName = 'DOG_NUMB'
    end
    object qrPersDOG_DATE: TDateTimeField
      FieldName = 'DOG_DATE'
    end
    object qrPersIS_RAB: TSmallintField
      FieldName = 'IS_RAB'
    end
    object qrPersPROF1: TWideStringField
      FieldName = 'PROF1'
      Size = 50
    end
    object qrPersOKPDTR1: TWideStringField
      FieldName = 'OKPDTR1'
      Size = 10
    end
    object qrPersPROF2: TWideStringField
      FieldName = 'PROF2'
      Size = 50
    end
    object qrPersOKPDTR2: TWideStringField
      FieldName = 'OKPDTR2'
      Size = 10
    end
    object qrPersCONFDATE: TDateTimeField
      FieldName = 'CONFDATE'
    end
    object qrPersNUMB_T2: TIntegerField
      FieldName = 'NUMB_T2'
    end
    object qrPersW_DBEG: TDateTimeField
      FieldName = 'W_DBEG'
    end
    object qrPersW_DEND: TDateTimeField
      FieldName = 'W_DEND'
    end
    object qrPersD_OVK: TDateTimeField
      FieldName = 'D_OVK'
    end
    object qrPersD_WBIL: TDateTimeField
      FieldName = 'D_WBIL'
    end
    object qrPersOUT_ORD_NUMB: TWideStringField
      FieldName = 'OUT_ORD_NUMB'
      Size = 50
    end
    object qrPersOUT_ORD_DATE: TDateTimeField
      FieldName = 'OUT_ORD_DATE'
    end
    object qrPersOUT_DATE: TDateTimeField
      FieldName = 'OUT_DATE'
    end
    object qrPersWID: TWideStringField
      FieldName = 'WID'
      Size = 10
    end
    object qrPersWBser: TWideStringField
      FieldName = 'WBser'
      Size = 2
    end
    object qrPersWBnum: TWideStringField
      FieldName = 'WBnum'
      Size = 8
    end
    object qrPersComments: TWideMemoField
      FieldName = 'Comments'
      BlobType = ftWideMemo
    end
    object qrPersWUCHET2_date: TDateTimeField
      FieldName = 'WUCHET2_date'
    end
    object qrPersDocument: TIntegerField
      FieldName = 'Document'
    end
    object qrPersBranch: TIntegerField
      FieldName = 'Branch'
    end
    object qrPersIsAspirant: TIntegerField
      FieldName = 'IsAspirant'
    end
    object qrPersStudyEnd_date: TDateTimeField
      FieldName = 'StudyEnd_date'
    end
    object qrPersOrderAkadem: TWideStringField
      FieldName = 'OrderAkadem'
    end
    object qrPersOrderAkadem_date: TDateTimeField
      FieldName = 'OrderAkadem_date'
    end
    object qrPersReasonAkadem: TWideStringField
      FieldName = 'ReasonAkadem'
      Size = 100
    end
    object qrPersBeginAkadem_date: TDateTimeField
      FieldName = 'BeginAkadem_date'
    end
    object qrPersEndAkadem_date: TDateTimeField
      FieldName = 'EndAkadem_date'
    end
    object qrPersRealEndAkadem_date: TDateTimeField
      FieldName = 'RealEndAkadem_date'
    end
    object qrPersMedResult_date: TDateTimeField
      FieldName = 'MedResult_date'
    end
    object qrPersMedResult: TIntegerField
      FieldName = 'MedResult'
    end
    object qrPersVKStatus: TIntegerField
      FieldName = 'VKStatus'
    end
    object qrPersBeginWar_date: TDateTimeField
      FieldName = 'BeginWar_date'
    end
    object qrPersEndWar_date: TDateTimeField
      FieldName = 'EndWar_date'
    end
    object qrPersRealEndWar_date: TDateTimeField
      FieldName = 'RealEndWar_date'
    end
    object qrPersReasonEndWar: TWideStringField
      FieldName = 'ReasonEndWar'
      Size = 100
    end
    object qrPersDismissal_date: TDateTimeField
      FieldName = 'Dismissal_date'
    end
    object qrPersOrderDismissal: TWideStringField
      FieldName = 'OrderDismissal'
    end
    object qrPersOrderDismissal_date: TDateTimeField
      FieldName = 'OrderDismissal_date'
    end
    object qrPersReasonDismissal: TWideStringField
      FieldName = 'ReasonDismissal'
      Size = 100
    end
    object qrPersDisserName: TWideStringField
      FieldName = 'DisserName'
      Size = 100
    end
    object qrPersDegree_ID: TIntegerField
      FieldName = 'Degree_ID'
    end
    object qrPersGuideDegree_ID: TIntegerField
      FieldName = 'GuideDegree_ID'
    end
    object qrPersFIOGuide: TWideStringField
      FieldName = 'FIOGuide'
      Size = 100
    end
    object qrPersDefend_date: TDateTimeField
      FieldName = 'Defend_date'
    end
    object qrPersRealDefend_date: TDateTimeField
      FieldName = 'RealDefend_date'
    end
    object qrPersContractEnd: TWideStringField
      FieldName = 'ContractEnd'
      Size = 50
    end
    object qrPersStudyForm: TIntegerField
      FieldName = 'StudyForm'
    end
    object qrPersKval_Id: TIntegerField
      FieldName = 'Kval_Id'
    end
    object qrPersDelay_ID: TIntegerField
      FieldName = 'Delay_ID'
    end
    object qrPersDelayStart_date: TDateTimeField
      FieldName = 'DelayStart_date'
    end
    object qrPersDelayEnd_date: TDateTimeField
      FieldName = 'DelayEnd_date'
    end
    object qrPersHealth: TWideStringField
      FieldName = 'Health'
      Size = 60
    end
    object qrPersHealthDocNo: TWideStringField
      FieldName = 'HealthDocNo'
      Size = 60
    end
    object qrPersHealthDoc_date: TDateTimeField
      FieldName = 'HealthDoc_date'
    end
    object qrPersWarfare: TWideStringField
      FieldName = 'Warfare'
      Size = 255
    end
    object qrPersASOrder_In: TWideStringField
      FieldName = 'ASOrder_In'
    end
    object qrPersASDate_In: TDateTimeField
      FieldName = 'ASDate_In'
    end
    object qrPersASOut_ORD_NUMB: TWideStringField
      FieldName = 'ASOut_ORD_NUMB'
      Size = 50
    end
    object qrPersASOut_ORD_Date: TDateTimeField
      FieldName = 'ASOut_ORD_Date'
    end
    object qrPersASOut_Date: TDateTimeField
      FieldName = 'ASOut_Date'
    end
    object qrPersAppLast: TIntegerField
      FieldName = 'AppLast'
    end
    object qrPersAppLastAll: TIntegerField
      FieldName = 'AppLastAll'
    end
    object qrPersAppLastStudy: TIntegerField
      FieldName = 'AppLastStudy'
    end
    object qrPersASAppLast: TIntegerField
      FieldName = 'ASAppLast'
    end
    object qrPersASAppFirst: TIntegerField
      FieldName = 'ASAppFirst'
    end
    object qrPersAppFirst: TIntegerField
      FieldName = 'AppFirst'
    end
    object qrPersAppFirstStudy: TIntegerField
      FieldName = 'AppFirstStudy'
    end
    object qrPersMed_Where: TWideStringField
      FieldName = 'Med_Where'
      Size = 40
    end
    object qrPersMed_Date: TDateTimeField
      FieldName = 'Med_Date'
    end
    object qrPersMed_Result: TWideStringField
      FieldName = 'Med_Result'
      Size = 100
    end
    object qrPersPsy_Where: TWideStringField
      FieldName = 'Psy_Where'
      Size = 40
    end
    object qrPersPsy_Date: TDateTimeField
      FieldName = 'Psy_Date'
    end
    object qrPersPsy_Result: TWideStringField
      FieldName = 'Psy_Result'
      Size = 100
    end
    object qrPersAsf_Sport: TWideStringField
      FieldName = 'Asf_Sport'
      Size = 40
    end
    object qrPersMob_Days: TIntegerField
      FieldName = 'Mob_Days'
    end
    object qrPersMob_Hours: TIntegerField
      FieldName = 'Mob_Hours'
    end
    object qrPersMob_Mins: TIntegerField
      FieldName = 'Mob_Mins'
    end
    object qrPersMob_CardDate: TDateTimeField
      FieldName = 'Mob_CardDate'
    end
    object qrPersMob_MissReason: TWideStringField
      FieldName = 'Mob_MissReason'
      Size = 255
    end
    object qrPersWUCHET2_Ser: TWideStringField
      FieldName = 'WUCHET2_Ser'
      Size = 50
    end
    object qrPersWUCHET2_IsWork: TIntegerField
      FieldName = 'WUCHET2_IsWork'
    end
    object qrPersPDPCode: TWideStringField
      FieldName = 'PDPCode'
      Size = 50
    end
    object qrPersWRNG_Date: TDateTimeField
      FieldName = 'WRNG_Date'
    end
    object qrPersdeadline: TStringField
      FieldKind = fkCalculated
      FieldName = 'deadline'
      Size = 512
      Calculated = True
    end
    object qrPersMob_Place: TStringField
      FieldName = 'Mob_Place'
      Size = 1000
    end
  end
  object qrWRng: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM KWRANGE')
    Left = 100
    Top = 68
  end
  object qrDep: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      
        'DEP_ID, IIF((DEP_FULL_NAME is null) OR DEP_FULL_NAME='#39#39', DEP_NAM' +
        'E, DEP_FULL_NAME) as DEP_NAME'
      'FROM KDEPART')
    Left = 148
    Top = 68
  end
  object qrOVK: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      'select * from KOVK')
    Left = 200
    Top = 72
  end
  object qrDepSQL: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      'DEP_ID, DEP_NAME'
      'FROM KDEPART')
    Left = 148
    Top = 132
  end
  object qrPost: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      'POST_ID, POST_NAME'
      'FROM KPOST')
    Left = 244
    Top = 156
  end
end

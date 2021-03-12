object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 344
  Width = 403
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
    Left = 28
    Top = 32
  end
  object qrOVK: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select *, '
      'IIF(ISOVK, '
      '  (select Param_Value from Params Where Params.Param_Id = 12), '
      '  (select Param_Value from Params Where Params.Param_Id = 13)'
      ') as OVK'
      'from KOVK')
    Left = 44
    Top = 120
  end
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    Charset = DEFAULT_CHARSET
    Lang = 0
    Options = [eoGraphicsBinary, eoDotAsColon]
    OnScanRecord = EkRTF1ScanRecord
    DisableControls = True
    Left = 224
    Top = 36
  end
  object qrOrg: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      'select * from ORG')
    Left = 112
    Top = 120
  end
  object qrVUR: TADOQuery
    Connection = dbMain
    OnCalcFields = qrVURCalcFields
    Parameters = <>
    SQL.Strings = (
      'select * from ORG_CONT')
    Left = 168
    Top = 132
    object qrVURCONTID: TIntegerField
      FieldName = 'CONTID'
    end
    object qrVURORGID: TIntegerField
      FieldName = 'ORGID'
    end
    object qrVURDEPART: TWideStringField
      FieldName = 'DEPART'
      Size = 50
    end
    object qrVURPOST: TWideStringField
      FieldName = 'POST'
      Size = 50
    end
    object qrVURFIO: TWideStringField
      FieldName = 'FIO'
      Size = 150
    end
    object qrVURPHONE: TWideStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object qrVURFAX: TWideStringField
      FieldName = 'FAX'
      Size = 50
    end
    object qrVUREMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object qrVURIS_GEN: TSmallintField
      FieldName = 'IS_GEN'
    end
    object qrVURIS_VUS: TSmallintField
      FieldName = 'IS_VUS'
    end
    object qrVURFAM: TWideStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrVURIM: TWideStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrVUROTCH: TWideStringField
      FieldName = 'OTCH'
      Size = 50
    end
    object qrVURIOFam: TStringField
      FieldKind = fkCalculated
      FieldName = 'IOFam'
      Size = 150
      Calculated = True
    end
    object qrVURFamIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamIO'
      Size = 150
      Calculated = True
    end
  end
  object qrGen: TADOQuery
    Connection = dbMain
    OnCalcFields = qrVURCalcFields
    Parameters = <>
    SQL.Strings = (
      'select * from ORG_CONT')
    Left = 224
    Top = 132
    object qrGenCONTID: TIntegerField
      FieldName = 'CONTID'
    end
    object qrGenORGID: TIntegerField
      FieldName = 'ORGID'
    end
    object qrGenDEPART: TWideStringField
      FieldName = 'DEPART'
      Size = 50
    end
    object qrGenPOST: TWideStringField
      FieldName = 'POST'
      Size = 50
    end
    object qrGenFIO: TWideStringField
      FieldName = 'FIO'
      Size = 150
    end
    object qrGenPHONE: TWideStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object qrGenFAX: TWideStringField
      FieldName = 'FAX'
      Size = 50
    end
    object qrGenEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object qrGenIS_GEN: TSmallintField
      FieldName = 'IS_GEN'
    end
    object qrGenIS_VUS: TSmallintField
      FieldName = 'IS_VUS'
    end
    object qrGenFAM: TWideStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrGenIM: TWideStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrGenOTCH: TWideStringField
      FieldName = 'OTCH'
      Size = 50
    end
    object qrGenIOFam: TStringField
      FieldKind = fkCalculated
      FieldName = 'IOFam'
      Size = 150
      Calculated = True
    end
    object qrGenFamIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamIO'
      Size = 150
      Calculated = True
    end
  end
  object qrPerson: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrPersonCalcFields
    Parameters = <
      item
        Name = 'OVK_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      
        'select P.*,KWR.*,KWS.*,KED.*,A.*,A1.POST_CODE as POST_CODE1,A1.A' +
        'DDR_STR as ADDR_STR1,PH.*,KFST.*'
      ',AppointmentLast.*,KP.*,'
      'P.Pers_Id as PPers_Id, '
      
        'iif(MvkOrder.Post_Id=AppointmentLast.Post_Id, MvkOrder.DocNumber' +
        ', '#39#39') as DocNumber, '
      
        'iif(MvkOrder.Post_Id=AppointmentLast.Post_Id, MvkOrder.DocDate, ' +
        'null) as DocDate,'
      '  KWR.WRNG_NAME as WRNG_Name1'
      'from ((((((((((Person P'
      'left outer join KWRANGE KWR  on (P.WRNG_ID=KWR.WRNG_ID))'
      'left outer join KWSOST  KWS  on (P.WSOST_ID=KWS.WSOST_ID))'
      'left outer join KEDUC   KED  on (P.ED_ID=KED.ED_ID))'
      
        'left outer join (select * from ADDR ax  where (Ax.ADDR_TYPE=0 or' +
        ' Ax.ADDR_TYPE is null)) A on (P.PERS_ID=A.PERS_ID))'
      
        'left outer join (select * from ADDR A1x where A1x.ADDR_TYPE=1) A' +
        '1 on (P.PERS_ID=A1.PERS_ID))'
      
        'left outer join (select * from PHONES PHx where (PHx.PH_TYPE=2 o' +
        'r PHx.PH_TYPE is null)) PH on (P.PERS_ID=PH.PERS_ID))'
      'left outer join KFSTATE KFST on (P.FST_ID=KFST.FST_ID))'
      
        'left outer join Appointment as AppointmentLast on (P.AppLast=App' +
        'ointmentLast.Id))'
      
        'left outer join [KPOST] KP on (AppointmentLast.POST_ID=[KP].POST' +
        '_ID))'
      'left outer join MvkOrder on MvkOrder.Pers_ID = p.Pers_ID)'
      ''
      ''
      'WHERE P.OVK_ID=:OVK_ID'
      '  AND P.IS_WAR<>0 and'
      '(p.W_DEND is NULL or p.W_DEND > date()) and ('
      
        '         (p.MALE=1 and (kwr.M_LIMIT is not NULL) and  (#FullAges' +
        '#p.BIRTHDAY#)>=kwr.M_LIMIT  ) or'
      
        '         (p.MALE=0 and (kwr.FEM_LIMIT is not NULL) and  (#FullAg' +
        'es#p.BIRTHDAY#)>=kwr.FEM_LIMIT  )) and p.Wuchet2_IsWork = 1'
      '  /*PERS_SET*/'
      'AND '
      '((P.AppLast IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR (P.AppLastStudy IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL' +
        '))'
      'ORDER BY P.FAM, P.IM, P.OTCH'
      '')
    Left = 128
    Top = 188
    object qrPersonORG_ID: TIntegerField
      FieldName = 'ORG_ID'
    end
    object qrPersonFAM: TWideStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrPersonIM: TWideStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrPersonOTCH: TWideStringField
      FieldName = 'OTCH'
      Size = 50
    end
    object qrPersonMALE: TSmallintField
      FieldName = 'MALE'
    end
    object qrPersonBIRTHDAY: TDateTimeField
      FieldName = 'BIRTHDAY'
    end
    object qrPersonBIRTHPLACE: TWideStringField
      FieldName = 'BIRTHPLACE'
      Size = 100
    end
    object qrPersonOKATO: TWideStringField
      FieldName = 'OKATO'
      Size = 11
    end
    object qrPersonNAT_ID: TIntegerField
      FieldName = 'NAT_ID'
    end
    object qrPersonPSP_SER: TWideStringField
      FieldName = 'PSP_SER'
      Size = 10
    end
    object qrPersonPSP_NUM: TWideStringField
      FieldName = 'PSP_NUM'
      Size = 10
    end
    object qrPersonPSP_PLACE: TWideStringField
      FieldName = 'PSP_PLACE'
      Size = 100
    end
    object qrPersonPSP_DATE: TDateTimeField
      FieldName = 'PSP_DATE'
    end
    object qrPersonINN: TWideStringField
      FieldName = 'INN'
      Size = 12
    end
    object qrPersonSTRAH: TWideStringField
      FieldName = 'STRAH'
    end
    object qrPersonSC_ID: TIntegerField
      FieldName = 'SC_ID'
    end
    object qrPersonIS_WAR: TSmallintField
      FieldName = 'IS_WAR'
    end
    object qrPersonCPROF_ID: TIntegerField
      FieldName = 'CPROF_ID'
    end
    object qrPersonCSOST: TSmallintField
      FieldName = 'CSOST'
    end
    object qrPersonCAT_ZAP: TSmallintField
      FieldName = 'CAT_ZAP'
    end
    object qrPersonVUS: TWideStringField
      FieldName = 'VUS'
      Size = 7
    end
    object qrPersonWCAT: TWideStringField
      FieldName = 'WCAT'
      Size = 1
    end
    object qrPersonOVK_ID: TIntegerField
      FieldName = 'OVK_ID'
    end
    object qrPersonWUCHET1: TWideStringField
      FieldName = 'WUCHET1'
      Size = 100
    end
    object qrPersonWUCHET2: TWideStringField
      FieldName = 'WUCHET2'
      Size = 100
    end
    object qrPersonWDISCL: TWideStringField
      FieldName = 'WDISCL'
      Size = 100
    end
    object qrPersonTAB_NUMB: TWideStringField
      FieldName = 'TAB_NUMB'
      Size = 10
    end
    object qrPersonDOG_NUMB: TWideStringField
      FieldName = 'DOG_NUMB'
    end
    object qrPersonDOG_DATE: TDateTimeField
      FieldName = 'DOG_DATE'
    end
    object qrPersonIS_RAB: TSmallintField
      FieldName = 'IS_RAB'
    end
    object qrPersonWTP_ID: TIntegerField
      FieldName = 'WTP_ID'
    end
    object qrPersonWCH_ID: TIntegerField
      FieldName = 'WCH_ID'
    end
    object qrPersonDEP_ID: TIntegerField
      FieldName = 'DEP_ID'
    end
    object qrPersonPROF1: TWideStringField
      FieldName = 'PROF1'
      OnGetText = qrPersonPROF1GetText
      Size = 50
    end
    object qrPersonOKPDTR1: TWideStringField
      FieldName = 'OKPDTR1'
      Size = 10
    end
    object qrPersonPROF2: TWideStringField
      FieldName = 'PROF2'
      Size = 50
    end
    object qrPersonOKPDTR2: TWideStringField
      FieldName = 'OKPDTR2'
      Size = 10
    end
    object qrPersonCONFDATE: TDateTimeField
      FieldName = 'CONFDATE'
    end
    object qrPersonW_DBEG: TDateTimeField
      FieldName = 'W_DBEG'
    end
    object qrPersonW_DEND: TDateTimeField
      FieldName = 'W_DEND'
    end
    object qrPersonD_OVK: TDateTimeField
      FieldName = 'D_OVK'
    end
    object qrPersonD_WBIL: TDateTimeField
      FieldName = 'D_WBIL'
    end
    object qrPersonWRNG_NAME: TWideStringField
      FieldName = 'WRNG_NAME'
      Size = 100
    end
    object qrPersonM_LIMIT: TSmallintField
      FieldName = 'M_LIMIT'
    end
    object qrPersonFEM_LIMIT: TSmallintField
      FieldName = 'FEM_LIMIT'
    end
    object qrPersonZAP: TWideStringField
      FieldName = 'ZAP'
      Size = 10
    end
    object qrPersonGODN: TWideStringField
      FieldName = 'GODN'
      Size = 10
    end
    object qrPersonWSOST_NAME: TWideStringField
      FieldName = 'WSOST_NAME'
      Size = 50
    end
    object qrPersonED_NAME: TWideStringField
      FieldName = 'ED_NAME'
      Size = 50
    end
    object qrPersonADDR_ID: TIntegerField
      FieldName = 'ADDR_ID'
    end
    object qrPersonNUMB_T2: TIntegerField
      FieldName = 'NUMB_T2'
    end
    object qrPersonADDR_TYPE: TSmallintField
      FieldName = 'ADDR_TYPE'
    end
    object qrPersonPOST_CODE: TIntegerField
      FieldName = 'POST_CODE'
    end
    object qrPersonADDR_STR: TWideStringField
      FieldName = 'ADDR_STR'
      Size = 100
    end
    object qrPersonFST_NAME: TWideStringField
      FieldName = 'FST_NAME'
      Size = 50
    end
    object qrPersonPOST_NAME: TWideStringField
      FieldName = 'POST_NAME'
      Size = 50
    end
    object qrPersonRecNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'RecNo'
      Calculated = True
    end
    object qrPersonWUCHET: TStringField
      FieldKind = fkCalculated
      FieldName = 'WUCHET'
      Size = 250
      Calculated = True
    end
    object qrPersonFAM_LIST: TStringField
      FieldKind = fkCalculated
      FieldName = 'FAM_LIST'
      Size = 500
      Calculated = True
    end
    object qrPersonEOARMY_DATE: TWideStringField
      FieldName = 'EOARMY_DATE'
      Size = 10
    end
    object qrPersonSpecialWUchet1: TIntegerField
      FieldName = 'SpecialWUchet1'
    end
    object qrPersonOUT_ORD_NUMB: TWideStringField
      FieldName = 'OUT_ORD_NUMB'
      Size = 50
    end
    object qrPersonOUT_ORD_DATE: TDateTimeField
      FieldName = 'OUT_ORD_DATE'
    end
    object qrPersonOUT_DATE: TDateTimeField
      FieldName = 'OUT_DATE'
    end
    object qrPersonWID: TWideStringField
      FieldName = 'WID'
      Size = 10
    end
    object qrPersonWBser: TWideStringField
      FieldName = 'WBser'
      Size = 2
    end
    object qrPersonWBnum: TWideStringField
      FieldName = 'WBnum'
      Size = 8
    end
    object qrPersonCHE: TIntegerField
      FieldName = 'CHE'
    end
    object qrPersonID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object qrPersonIN_ORD_NUMB: TWideStringField
      FieldName = 'IN_ORD_NUMB'
      Size = 50
    end
    object qrPersonIN_ORD_DATE: TDateTimeField
      FieldName = 'IN_ORD_DATE'
    end
    object qrPersonIN_DATE: TDateTimeField
      FieldName = 'IN_DATE'
    end
    object qrPersonOKPDTR: TWideStringField
      FieldName = 'OKPDTR'
      Size = 17
    end
    object qrPersonOKPDTR_NAME: TWideStringField
      FieldName = 'OKPDTR_NAME'
      Size = 50
    end
    object qrPersonPH_ID: TIntegerField
      FieldName = 'PH_ID'
    end
    object qrPersonPH_TYPE: TSmallintField
      FieldName = 'PH_TYPE'
    end
    object qrPersonPH_NUMBER: TWideStringField
      FieldName = 'PH_NUMBER'
      Size = 50
    end
    object qrPersonADDR_STR1: TStringField
      FieldName = 'ADDR_STR1'
      Size = 100
    end
    object qrPersonEducation: TStringField
      FieldKind = fkCalculated
      FieldName = 'Education'
      Size = 4000
      Calculated = True
    end
    object qrPersonWUchet2_IsWork: TIntegerField
      FieldName = 'WUchet2_IsWork'
    end
    object qrPersonComments: TWideMemoField
      FieldName = 'Comments'
      BlobType = ftWideMemo
    end
    object qrPersonWUCHET2_date: TDateTimeField
      FieldName = 'WUCHET2_date'
    end
    object qrPersonDocument: TIntegerField
      FieldName = 'Document'
    end
    object qrPersonBranch: TIntegerField
      FieldName = 'Branch'
    end
    object qrPersonIsAspirant: TIntegerField
      FieldName = 'IsAspirant'
    end
    object qrPersonStudyForm: TIntegerField
      FieldName = 'StudyForm'
    end
    object qrPersonStudyEnd_date: TDateTimeField
      FieldName = 'StudyEnd_date'
    end
    object qrPersonOrderAkadem: TWideStringField
      FieldName = 'OrderAkadem'
    end
    object qrPersonOrderAkadem_date: TDateTimeField
      FieldName = 'OrderAkadem_date'
    end
    object qrPersonReasonAkadem: TWideStringField
      FieldName = 'ReasonAkadem'
      Size = 100
    end
    object qrPersonBeginAkadem_date: TDateTimeField
      FieldName = 'BeginAkadem_date'
    end
    object qrPersonEndAkadem_date: TDateTimeField
      FieldName = 'EndAkadem_date'
    end
    object qrPersonRealEndAkadem_date: TDateTimeField
      FieldName = 'RealEndAkadem_date'
    end
    object qrPersonMedResult_date: TDateTimeField
      FieldName = 'MedResult_date'
    end
    object qrPersonMedResult: TIntegerField
      FieldName = 'MedResult'
    end
    object qrPersonVKStatus: TIntegerField
      FieldName = 'VKStatus'
    end
    object qrPersonBeginWar_date: TDateTimeField
      FieldName = 'BeginWar_date'
    end
    object qrPersonEndWar_date: TDateTimeField
      FieldName = 'EndWar_date'
    end
    object qrPersonRealEndWar_date: TDateTimeField
      FieldName = 'RealEndWar_date'
    end
    object qrPersonReasonEndWar: TWideStringField
      FieldName = 'ReasonEndWar'
      Size = 100
    end
    object qrPersonDismissal_date: TDateTimeField
      FieldName = 'Dismissal_date'
    end
    object qrPersonOrderDismissal: TWideStringField
      FieldName = 'OrderDismissal'
    end
    object qrPersonOrderDismissal_date: TDateTimeField
      FieldName = 'OrderDismissal_date'
    end
    object qrPersonReasonDismissal: TWideStringField
      FieldName = 'ReasonDismissal'
      Size = 100
    end
    object qrPersonDisserName: TWideStringField
      FieldName = 'DisserName'
      Size = 100
    end
    object qrPersonDegree_ID: TIntegerField
      FieldName = 'Degree_ID'
    end
    object qrPersonGuideDegree_ID: TIntegerField
      FieldName = 'GuideDegree_ID'
    end
    object qrPersonFIOGuide: TWideStringField
      FieldName = 'FIOGuide'
      Size = 100
    end
    object qrPersonDefend_date: TDateTimeField
      FieldName = 'Defend_date'
    end
    object qrPersonRealDefend_date: TDateTimeField
      FieldName = 'RealDefend_date'
    end
    object qrPersonContractEnd: TWideStringField
      FieldName = 'ContractEnd'
      Size = 50
    end
    object qrPersonKval_Id: TIntegerField
      FieldName = 'Kval_Id'
    end
    object qrPersonDelay_ID: TIntegerField
      FieldName = 'Delay_ID'
    end
    object qrPersonDelayStart_date: TDateTimeField
      FieldName = 'DelayStart_date'
    end
    object qrPersonDelayEnd_date: TDateTimeField
      FieldName = 'DelayEnd_date'
    end
    object qrPersonHealth: TWideStringField
      FieldName = 'Health'
      Size = 60
    end
    object qrPersonHealthDocNo: TWideStringField
      FieldName = 'HealthDocNo'
      Size = 60
    end
    object qrPersonHealthDoc_date: TDateTimeField
      FieldName = 'HealthDoc_date'
    end
    object qrPersonWarfare: TWideStringField
      FieldName = 'Warfare'
      Size = 255
    end
    object qrPersonASOrder_In: TWideStringField
      FieldName = 'ASOrder_In'
    end
    object qrPersonASDate_In: TDateTimeField
      FieldName = 'ASDate_In'
    end
    object qrPersonASOut_ORD_NUMB: TWideStringField
      FieldName = 'ASOut_ORD_NUMB'
      Size = 50
    end
    object qrPersonASOut_ORD_Date: TDateTimeField
      FieldName = 'ASOut_ORD_Date'
    end
    object qrPersonASOut_Date: TDateTimeField
      FieldName = 'ASOut_Date'
    end
    object qrPersonAppLast: TIntegerField
      FieldName = 'AppLast'
    end
    object qrPersonAppLastAll: TIntegerField
      FieldName = 'AppLastAll'
    end
    object qrPersonAppLastStudy: TIntegerField
      FieldName = 'AppLastStudy'
    end
    object qrPersonAppFirst: TIntegerField
      FieldName = 'AppFirst'
    end
    object qrPersonAppFirstStudy: TIntegerField
      FieldName = 'AppFirstStudy'
    end
    object qrPersonASAppLast: TIntegerField
      FieldName = 'ASAppLast'
    end
    object qrPersonASAppFirst: TIntegerField
      FieldName = 'ASAppFirst'
    end
    object qrPersonMed_Where: TWideStringField
      FieldName = 'Med_Where'
      Size = 40
    end
    object qrPersonMed_Date: TDateTimeField
      FieldName = 'Med_Date'
    end
    object qrPersonMed_Result: TWideStringField
      FieldName = 'Med_Result'
      Size = 100
    end
    object qrPersonPsy_Where: TWideStringField
      FieldName = 'Psy_Where'
      Size = 40
    end
    object qrPersonPsy_Date: TDateTimeField
      FieldName = 'Psy_Date'
    end
    object qrPersonPsy_Result: TWideStringField
      FieldName = 'Psy_Result'
      Size = 100
    end
    object qrPersonAsf_Sport: TWideStringField
      FieldName = 'Asf_Sport'
      Size = 40
    end
    object qrPersonMob_Days: TIntegerField
      FieldName = 'Mob_Days'
    end
    object qrPersonMob_Hours: TIntegerField
      FieldName = 'Mob_Hours'
    end
    object qrPersonMob_Mins: TIntegerField
      FieldName = 'Mob_Mins'
    end
    object qrPersonMob_CardDate: TDateTimeField
      FieldName = 'Mob_CardDate'
    end
    object qrPersonMob_MissReason: TWideStringField
      FieldName = 'Mob_MissReason'
      Size = 255
    end
    object qrPersonWUCHET2_Ser: TWideStringField
      FieldName = 'WUCHET2_Ser'
      Size = 50
    end
    object qrPersonPDPCode: TWideStringField
      FieldName = 'PDPCode'
      Size = 50
    end
    object qrPersonZAPSTATE: TIntegerField
      FieldName = 'ZAPSTATE'
    end
    object qrPersonLIMIT1: TIntegerField
      FieldName = 'LIMIT1'
    end
    object qrPersonLIMIT2: TIntegerField
      FieldName = 'LIMIT2'
    end
    object qrPersonLIMIT3: TIntegerField
      FieldName = 'LIMIT3'
    end
    object qrPersonADDR_DATE: TDateTimeField
      FieldName = 'ADDR_DATE'
    end
    object qrPersonPOST_CODE1: TIntegerField
      FieldName = 'POST_CODE1'
    end
    object qrPersonKPost_Num: TIntegerField
      FieldName = 'KPost_Num'
    end
    object qrPersonIsIgnore: TBooleanField
      FieldName = 'IsIgnore'
    end
    object qrPersonYellow_Data: TStringField
      FieldKind = fkCalculated
      FieldName = 'Yellow_Data'
      Size = 10
      Calculated = True
    end
    object qrPersonWRNG_Name1: TStringField
      FieldName = 'WRNG_Name1'
      Size = 100
    end
    object qrPersonOKVED_OKPDTR: TStringField
      FieldKind = fkCalculated
      FieldName = 'OKVED_OKPDTR'
      Size = 100
      Calculated = True
    end
    object qrPersonWUchet22: TStringField
      FieldKind = fkCalculated
      FieldName = 'WUchet22'
      Size = 100
      Calculated = True
    end
    object qrPersonPPers_Id: TIntegerField
      FieldName = 'PPers_Id'
    end
    object qrPersonDocNumber: TStringField
      FieldName = 'DocNumber'
      Size = 255
    end
    object qrPersonDocDate: TDateTimeField
      FieldName = 'DocDate'
    end
  end
  object qrEduc: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'pers_id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'select '
      ' iif(IsNull(Kuz.UZ_NAME)   ,"",", "&Kuz.UZ_NAME)'
      ' &iif(IsNull(Educ.END_DATE) ,"",", "&Educ.END_DATE)'
      ' &iif((KKVAL.Kval_Name is null)     ,'#39#39','#39', '#39'&KKVAL.Kval_Name)'
      ' &iif((KNapr.NAPR_Name is null)     ,'#39#39','#39', '#39'&KNapr.NAPR_Name) as'
      'Education'
      'from (((Educ '
      'left outer join KKval on KKval.kval_id = [Educ].Kval_Id)'
      'left outer join KNapr on KNapr.Napr_id = [Educ].Napr_Id)'
      'left outer join [KUz] on [KUz].UZ_ID=[Educ].UZ_ID)'
      'Where Educ.Pers_Id = :Pers_Id and Educ.Type in (1,2,3)'
      'Order by Educ.Type')
    Left = 204
    Top = 188
  end
  object qrFam: TADOQuery
    Connection = dbMain
    Parameters = <
      item
        Name = 'pers_id'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'select *'
      'from FAMILY inner join KFAMTYPE on FAMILY.FT_ID=KFAMTYPE.FT_ID'
      'where pers_id=:pers_id'
      'order by fam_birth')
    Left = 268
    Top = 204
  end
  object qrPersonSQL: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrPersonCalcFields
    Parameters = <
      item
        Name = 'OVK_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      
        'select P.*,KWR.*,KWS.*,KED.*,A.*,A1.POST_CODE as POST_CODE1,A1.A' +
        'DDR_STR as ADDR_STR1,PH.*,KFST.*'
      ',AppointmentLast.*,KP.*,'
      'P.Pers_Id as PPers_Id'
      ',KED.ED_NAME'
      ''
      ' +iif((Kuz.UZ_NAME is null)   ,'#39#39','#39', '#39'+Kuz.UZ_NAME)'
      ' +iif((Educ.END_DATE is null) ,'#39#39','#39', '#39'+Educ.END_DATE)'
      ' +iif((Educ.KVAL is null)     ,'#39#39','#39', '#39'+Educ.KVAL)'
      ' +iif((Educ.NAPR is null)     ,'#39#39','#39', '#39'+Educ.NAPR)'
      ''
      ' +iif((Kuz2.UZ_NAME is null)  ,'#39#39','#39', '#39'+Kuz2.UZ_NAME)'
      ' +iif((Educ2.END_DATE is null),'#39#39','#39', '#39'+Educ2.END_DATE)'
      ' +iif((Educ2.KVAL is null)    ,'#39#39','#39', '#39'+Educ2.KVAL)'
      ' +iif((Educ2.NAPR is null)    ,'#39#39','#39', '#39'+Educ2.NAPR)'
      ''
      ' +iif((P.PROF1 is null)       ,'#39#39','#39', '#39'+P.PROF1)'
      ' as Education,'
      
        '  KWR.WRNG_NAME + iif((select Param_Value from Params Where Para' +
        'ms.Param_Id = 8) = '#39'1'#39', iif(P.WSOST_ID=9,'#39' '#1102#1089#1090#1080#1094#1080#1080#39',iif(P.WSOST_' +
        'ID=10,'#39' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#39','#39#39')),'#39#39') as WRNG_Name1'
      'from ((((((((((((Person P'
      'left outer join KWRANGE KWR  on (P.WRNG_ID=KWR.WRNG_ID))'
      'left outer join KWSOST  KWS  on (P.WSOST_ID=KWS.WSOST_ID))'
      'left outer join KEDUC   KED  on (P.ED_ID=KED.ED_ID))'
      
        'left outer join ADDR    A    on (P.PERS_ID=A.PERS_ID AND (A.ADDR' +
        '_TYPE=0 or A.ADDR_TYPE is null)))'
      
        'left outer join ADDR    A1   on (P.PERS_ID=A1.PERS_ID AND A1.ADD' +
        'R_TYPE=1))'
      
        'left outer join PHONES  PH   on (P.PERS_ID=PH.PERS_ID AND (PH.PH' +
        '_TYPE=2 or PH.PH_TYPE is null)))'
      'left outer join KFSTATE KFST on (P.FST_ID=KFST.FST_ID))'
      
        'left outer join AppointmentLast on (P.Pers_Id=AppointmentLast.Pe' +
        'rs_Id))'
      
        'left outer join [KPOST] KP on (AppointmentLast.POST_ID=[KP].POST' +
        '_ID))'
      
        'left outer join [Educ] on (P.PERS_ID=[Educ].PERS_ID and [Educ].t' +
        'ype=1))'
      
        'left outer join [Educ] as Educ2 on (P.PERS_ID=[Educ2].PERS_ID an' +
        'd [Educ2].type=2))'
      'left outer join [KUz] on [KUz].UZ_ID=[Educ].UZ_ID)'
      'left outer join [KUz] as KUz2 on [KUz2].UZ_ID=[Educ2].UZ_ID'
      ''
      ''
      'WHERE P.OVK_ID=:OVK_ID'
      '  AND P.IS_WAR<>0 and'
      '(p.W_DEND is NULL or p.W_DEND > GetDate()) and ('
      
        '         (p.MALE=1 and (kwr.M_LIMIT is not NULL) and  (#FullAges' +
        '#p.BIRTHDAY#)>=kwr.M_LIMIT  ) or'
      
        '         (p.MALE=0 and (kwr.FEM_LIMIT is not NULL) and  (#FullAg' +
        'es#p.BIRTHDAY#)>=kwr.FEM_LIMIT  )) and p.Wuchet2_IsWork = 1'
      
        'and ((select COUNT(*) from PERS_SET)=0 or P.PERS_ID in (select P' +
        'ERS_ID from PERS_SET))'
      'AND '
      
        '(((select max(In_Date) from Appointment where pers_id = P.pers_i' +
        'd and post_id in (select post_id from kpost where cprof_id <> 50' +
        '0)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR ((select max(In_Date) from Appointment where pers_id = P.pers' +
        '_id and post_id in (select post_id from kpost where cprof_id = 5' +
        '00)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))'
      'ORDER BY P.FAM, P.IM, P.OTCH'
      '')
    Left = 128
    Top = 244
  end
end

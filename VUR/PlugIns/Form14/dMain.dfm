object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 263
  Width = 430
  object dbMain: TADOConnection
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 18
    Top = 32
  end
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    UDFList = EkUDFList1
    Charset = DEFAULT_CHARSET
    Lang = 0
    Options = [eoGraphicsBinary, eoDotAsColon]
    OnScanRecord = EkRTF1ScanRecord
    DisableControls = True
    Left = 89
    Top = 30
  end
  object qrPerson: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrPersonCalcFields
    Parameters = <
      item
        Name = 'TPDP_Id'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'MvkOrderNumber'
        Size = -1
        Value = Null
      end
      item
        Name = 'MvkOrderDate'
        Size = -1
        Value = Null
      end
      item
        Name = 'IsAspirant'
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
      ',Appointment.*,KP.*,'
      'P.Pers_Id as PPers_Id,'
      '  KWR.WRNG_NAME  as WRNG_Name1,'
      'pdp.*, Year(p.BirthDay) as BirthYear, '
      
        'iif(Appointment.Post_Id = MvkOrder.Post_Id,MvkOrder.DocNumber, n' +
        'ull) as DocNumber, MvkOrder.DocDate'
      'from (((((((((((Person P'
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
      'left outer join Appointment on (P.AppLastAll=Appointment.Id))'
      
        'left outer join [KPOST] KP on (Appointment.POST_ID=[KP].POST_ID)' +
        ')'
      
        'left outer join PersonReservChkInfo pr on pr.Pers_Id = P.pers_Id' +
        ' )'
      'left outer join TPDP pdp on pdp.kokpdtr = KP.kokpdtr)'
      'left outer join MvkOrder on MvkOrder.Pers_Id = p.Pers_Id'
      ''
      
        'WHERE (pdp.Id = :TPDP_Id or (MvkOrder.DocNumber = :MvkOrderNumbe' +
        'r and MvkOrder.DocDate = :MvkOrderDate))'
      
        'and (iif(p.IsAspirant is null, 1, 0)) = iif(:IsAspirant = 1, 0, ' +
        '1)'
      '  AND P.IS_WAR<>0 and'
      'pr.Is_Bad = 1 and pr.Reserved = 0 and'
      
        '(not ((p.MALE=1 and (kwr.M_LIMIT is not NULL) and  (#FullAges#p.' +
        'BIRTHDAY#)>kwr.M_LIMIT  ) or '
      
        '(p.MALE=0 and (kwr.FEM_LIMIT is not NULL) and  (#FullAges#p.BIRT' +
        'HDAY#)>kwr.FEM_LIMIT)))'
      'and (p.Wuchet2_IsWork is null or p.Wuchet2_IsWork = 0)'
      '  /*PERS_SET*/'
      'AND '
      '((P.AppLast IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR (P.AppLastStudy IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL' +
        '))'
      'ORDER BY P.FAM, P.IM, P.OTCH')
    Left = 96
    Top = 85
    object qrPersonPPers_Id: TIntegerField
      FieldName = 'PPers_Id'
    end
    object qrPersonRecNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'RecNo'
      Calculated = True
    end
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
    object qrPersonEOARMY_DATE: TWideStringField
      FieldName = 'EOARMY_DATE'
      Size = 10
    end
    object qrPersonCSOST: TSmallintField
      FieldName = 'CSOST'
    end
    object qrPersonCAT_ZAP: TSmallintField
      FieldName = 'CAT_ZAP'
    end
    object qrPersonVUS: TWideStringField
      FieldName = 'VUS'
      Size = 10
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
    object qrPersonSpecialWUchet1: TIntegerField
      FieldName = 'SpecialWUchet1'
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
    object qrPersonPROF1: TWideStringField
      FieldName = 'PROF1'
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
    object qrPersonNUMB_T2: TIntegerField
      FieldName = 'NUMB_T2'
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
    object qrPersonStudyForm: TIntegerField
      FieldName = 'StudyForm'
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
    object qrPersonCHE: TIntegerField
      FieldName = 'CHE'
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
    object qrPersonADDR_DATE: TDateTimeField
      FieldName = 'ADDR_DATE'
    end
    object qrPersonPOST_CODE1: TIntegerField
      FieldName = 'POST_CODE1'
    end
    object qrPersonADDR_STR1: TWideStringField
      FieldName = 'ADDR_STR1'
      Size = 100
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
    object qrPersonFST_NAME: TWideStringField
      FieldName = 'FST_NAME'
      Size = 50
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
    object qrPersonPOST_NAME: TWideStringField
      FieldName = 'POST_NAME'
      Size = 255
    end
    object qrPersonOKPDTR: TWideStringField
      FieldName = 'OKPDTR'
      Size = 17
    end
    object qrPersonOKPDTR_NAME: TWideStringField
      FieldName = 'OKPDTR_NAME'
      Size = 50
    end
    object qrPersonCPROF_ID: TIntegerField
      FieldName = 'CPROF_ID'
    end
    object qrPersonKPost_Num: TIntegerField
      FieldName = 'KPost_Num'
    end
    object qrPersonIsIgnore: TBooleanField
      FieldName = 'IsIgnore'
    end
    object qrPersonEducation: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Education'
      ReadOnly = True
      Size = 255
      Calculated = True
    end
    object qrPersonPer_No: TWideStringField
      FieldName = 'Per_No'
      Size = 10
    end
    object qrPersonRazd_No: TWideStringField
      FieldName = 'Razd_No'
      Size = 10
    end
    object qrPersonPodrazd_No: TWideStringField
      FieldName = 'Podrazd_No'
      Size = 10
    end
    object qrPersonPunkt: TWideStringField
      FieldName = 'Punkt'
      Size = 10
    end
    object qrPersonBirthYear: TSmallintField
      FieldName = 'BirthYear'
      ReadOnly = True
    end
    object qrPersonPosts: TWideStringField
      FieldName = 'Posts'
      Size = 255
    end
    object qrPersonWRNG_Name1: TStringField
      FieldName = 'WRNG_Name1'
      Size = 100
    end
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1dateCalculate
        Name = 'date'
        ArgMinCount = 0
        ArgMaxCount = 0
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1NotIsNullCalculate
        Name = 'NotIsNull'
        ArgMinCount = 1
        ArgMaxCount = 16
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1Functions2Calculate
        Name = 'IOFam'
        ArgMinCount = 3
        ArgMaxCount = 3
        ResultType = 1
      end>
    Left = 157
    Top = 29
  end
  object qrOrg: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    AfterScroll = qrOrgAfterScroll
    OnCalcFields = qrOrgCalcFields
    Parameters = <>
    SQL.Strings = (
      'select o.*, oc.fam, oc.im, oc.otch, oc.POST'
      'from ORG o, ORG_CONT oc'
      'where oc.is_gen = 1')
    Left = 145
    Top = 89
    object qrOrgIOFam: TStringField
      FieldKind = fkCalculated
      FieldName = 'IOFam'
      Size = 150
      Calculated = True
    end
    object qrOrgFamIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamIO'
      Size = 150
      Calculated = True
    end
    object qrOrgorgname: TWideMemoField
      FieldName = 'OrgName'
      BlobType = ftWideMemo
    end
    object qrOrgfam: TStringField
      FieldName = 'fam'
      Size = 4000
    end
    object qrOrgIm: TStringField
      FieldName = 'Im'
      Size = 4000
    end
    object qrOrgOtch: TStringField
      FieldName = 'Otch'
      Size = 4000
    end
    object qrOrgPOST: TStringField
      FieldName = 'POST'
      Size = 4000
    end
    object qrOrgMAINOKONH: TWideStringField
      FieldName = 'MAINOKONH'
      Size = 15
    end
    object qrOrgORGID: TIntegerField
      FieldName = 'ORGID'
    end
    object qrOrgPARENT: TWideStringField
      FieldName = 'PARENT'
      Size = 100
    end
    object qrOrgFS_ID: TIntegerField
      FieldName = 'FS_ID'
    end
    object qrOrgINN: TWideStringField
      FieldName = 'INN'
      Size = 15
    end
    object qrOrgOKPO: TWideStringField
      FieldName = 'OKPO'
      Size = 8
    end
    object qrOrgOKONH: TWideMemoField
      FieldName = 'OKONH'
      BlobType = ftWideMemo
    end
    object qrOrgSOOGU: TWideStringField
      FieldName = 'SOOGU'
      Size = 7
    end
    object qrOrgKOPF_ID: TIntegerField
      FieldName = 'KOPF_ID'
    end
    object qrOrgKODREG: TWideStringField
      FieldName = 'KODREG'
      Size = 11
    end
    object qrOrgREGDATE: TDateTimeField
      FieldName = 'REGDATE'
    end
    object qrOrgREGNUM: TWideStringField
      FieldName = 'REGNUM'
    end
    object qrOrgORGSNAME: TWideStringField
      FieldName = 'ORGSNAME'
      Size = 50
    end
    object qrOrgCOMMENT: TWideMemoField
      FieldName = 'COMMENT'
      BlobType = ftWideMemo
    end
    object qrOrgFIZADDR: TWideStringField
      FieldName = 'FIZADDR'
      Size = 250
    end
    object qrOrgURADDR: TWideStringField
      FieldName = 'URADDR'
      Size = 250
    end
    object qrOrgPOSTADDR: TWideStringField
      FieldName = 'POSTADDR'
      Size = 250
    end
    object qrOrgPHONE: TWideStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object qrOrgFAX: TWideStringField
      FieldName = 'FAX'
      Size = 50
    end
    object qrOrgEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object qrOrgWWW: TWideStringField
      FieldName = 'WWW'
      Size = 100
    end
    object qrOrgMYORG: TSmallintField
      FieldName = 'MYORG'
    end
    object qrOrgCONFDATE: TDateTimeField
      FieldName = 'CONFDATE'
    end
    object qrOrgOKBV: TWideStringField
      FieldName = 'OKBV'
      Size = 12
    end
    object qrOrgFIRST_DATE: TDateTimeField
      FieldName = 'FIRST_DATE'
    end
    object qrOrgLAST_DATE: TDateTimeField
      FieldName = 'LAST_DATE'
    end
    object qrOrgEXT_ID: TIntegerField
      FieldName = 'EXT_ID'
    end
    object qrOrgF6_SHIFR: TWideStringField
      FieldName = 'F6_SHIFR'
      Size = 2
    end
    object qrOrgOCCUPATION: TWideStringField
      FieldName = 'OCCUPATION'
      Size = 150
    end
    object qrOrgSBM_ID: TIntegerField
      FieldName = 'SBM_ID'
    end
    object qrOrgTERR_ID: TIntegerField
      FieldName = 'TERR_ID'
    end
    object qrOrgHAS_BRON: TBooleanField
      FieldName = 'HAS_BRON'
    end
    object qrOrgREGPL_ID: TIntegerField
      FieldName = 'REGPL_ID'
    end
    object qrOrgOKATO2: TWideStringField
      FieldName = 'OKATO2'
      Size = 50
    end
    object qrOrgOKATO3: TWideStringField
      FieldName = 'OKATO3'
      Size = 50
    end
    object qrOrgFeature1: TWideStringField
      FieldName = 'Feature1'
      Size = 30
    end
    object qrOrgFeature2: TWideStringField
      FieldName = 'Feature2'
      Size = 30
    end
    object qrOrgFeature3: TWideStringField
      FieldName = 'Feature3'
      Size = 30
    end
    object qrOrgOVK_ID: TIntegerField
      FieldName = 'OVK_ID'
    end
    object qrOrgLicense1: TWideStringField
      FieldName = 'License1'
      Size = 30
    end
    object qrOrgLicense1_date: TDateTimeField
      FieldName = 'License1_date'
    end
    object qrOrgLicense1Who: TWideStringField
      FieldName = 'License1Who'
      Size = 255
    end
    object qrOrgLicense2: TWideStringField
      FieldName = 'License2'
      Size = 30
    end
    object qrOrgLicense2_date: TDateTimeField
      FieldName = 'License2_date'
    end
    object qrOrgLicense2Who: TWideStringField
      FieldName = 'License2Who'
      Size = 255
    end
    object qrOrgCertificate: TWideStringField
      FieldName = 'Certificate'
      Size = 30
    end
    object qrOrgBeginCertificate_date: TDateTimeField
      FieldName = 'BeginCertificate_date'
    end
    object qrOrgEndCertificate_date: TDateTimeField
      FieldName = 'EndCertificate_date'
    end
    object qrOrgCertificateWho: TWideStringField
      FieldName = 'CertificateWho'
      Size = 255
    end
    object qrOrgWhoPuts: TWideStringField
      FieldName = 'WhoPuts'
      Size = 255
    end
    object qrOrgHasVK: TBooleanField
      FieldName = 'HasVK'
    end
    object qrOrgVKChief: TWideStringField
      FieldName = 'VKChief'
      Size = 100
    end
    object qrOrgVKChiefRange: TIntegerField
      FieldName = 'VKChiefRange'
    end
    object qrOrgKODOKTMO: TWideStringField
      FieldName = 'KODOKTMO'
      Size = 11
    end
    object qrOrgKODOKTMO2: TWideStringField
      FieldName = 'KODOKTMO2'
      Size = 11
    end
  end
  object qrPDP: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrOrgCalcFields
    Parameters = <>
    SQL.Strings = (
      
        'select id, Per_No, Razd_No, Podrazd_No, PUNKT, Posts, OKVED, KOK' +
        'PDTR_Code, null as DocNumber, Date() as DocDate'
      'from TPDP left join KOKPDTR on KOKPDTR.KOKPDTR_Id = TPDP.KOKPDTR'
      'union'
      
        'select distinct null as Id, null as Per_No, null as Razd_No, nul' +
        'l as Podrazd_No, null as PUNKT, null as Posts, null as OKVED, nu' +
        'll as KOKPDTR_Code, DocNumber, DocDate'
      'from MvkOrder')
    Left = 145
    Top = 153
    object qrPDPid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
    end
    object qrPDPPer_No: TWideStringField
      FieldName = 'Per_No'
      Size = 10
    end
    object qrPDPRazd_No: TWideStringField
      FieldName = 'Razd_No'
      Size = 10
    end
    object qrPDPPodrazd_No: TWideStringField
      FieldName = 'Podrazd_No'
      Size = 10
    end
    object qrPDPPUNKT: TWideStringField
      FieldName = 'PUNKT'
      Size = 10
    end
    object qrPDPPosts: TWideStringField
      FieldName = 'Posts'
      Size = 255
    end
    object qrPDPOKVED: TStringField
      FieldName = 'OKVED'
      Size = 100
    end
    object qrPDPKOKPDTR_Code: TStringField
      FieldName = 'KOKPDTR_Code'
      Size = 100
    end
    object qrPDPDocNumber: TStringField
      FieldName = 'DocNumber'
      Size = 255
    end
    object qrPDPDocDate: TDateTimeField
      FieldName = 'DocDate'
    end
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
  object qrEduc: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
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
end

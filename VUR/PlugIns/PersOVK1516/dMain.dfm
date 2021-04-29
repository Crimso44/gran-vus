object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 344
  Width = 403
  object dbMain: TADOConnection
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
    UDFList = EkUDFList1
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
      
        ',AppointmentLastAll.*,KP.*,IIF(KD.DEP_FULL_NAME is null, KD.DEP_' +
        'NAME, KD.DEP_FULL_NAME) as DEP_FULL_NAME,'
      'P.Pers_Id as PPers_Id,'
      'KED.ED_NAME'
      ' &iif(IsNull(Kuz.UZ_NAME)   ,"",", "&Kuz.UZ_NAME)'
      ' &iif(IsNull(Educ.END_DATE) ,"",", "&Educ.END_DATE)'
      ' &iif((KKVAL.Kval_Name is null)     ,'#39#39','#39', '#39'&KKVAL.Kval_Name)'
      ' &iif((KNapr.NAPR_Name is null)     ,'#39#39','#39', '#39'&KNapr.NAPR_Name) '
      ''
      ' &iif(IsNull(Kuz2.UZ_NAME)  ,"",", "&Kuz2.UZ_NAME)'
      ' &iif(IsNull(Educ2.END_DATE),"",", "&Educ2.END_DATE)'
      ' &iif((KKVAL2.Kval_Name is null)     ,'#39#39','#39', '#39'&KKVAL2.Kval_Name)'
      ' &iif((KNapr2.NAPR_Name is null)     ,'#39#39','#39', '#39'&KNapr2.NAPR_Name) '
      ''
      ' &iif(IsNull(P.PROF1)       ,"",", "&P.PROF1)'
      ' as Education,'
      ' KN.NAT_NAME'
      'from ((((((((((((((((((Person P'
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
      
        'left outer join AppointmentLastAll on (P.Pers_Id=AppointmentLast' +
        'All.Pers_Id))'
      
        'left outer join [KPOST] KP on (AppointmentLastAll.POST_ID=[KP].P' +
        'OST_ID))'
      
        'left outer join [KDEPART] KD on (AppointmentLastAll.DEP_ID=[KD].' +
        'DEP_ID))'
      
        'left outer join [Educ] on (P.PERS_ID=[Educ].PERS_ID and [Educ].t' +
        'ype=1))'
      'left outer join KKval on KKval.kval_id = [Educ].Kval_Id)'
      'left outer join KNapr on KNapr.Napr_id = [Educ].Napr_Id)'
      
        'left outer join [Educ] as Educ2 on (P.PERS_ID=[Educ2].PERS_ID an' +
        'd [Educ2].type=2))'
      
        'left outer join KKval as KKval2 on KKval2.kval_id = Educ2.Kval_I' +
        'd)'
      
        'left outer join KNapr as KNapr2 on KNapr2.Napr_id = Educ2.Napr_I' +
        'd)'
      'left outer join [KUz] on [KUz].UZ_ID=[Educ].UZ_ID)'
      'left outer join [KUz] as KUz2 on [KUz2].UZ_ID=[Educ2].UZ_ID)'
      'left outer join KNation KN  on (KN.NAT_ID=P.NAT_ID)'
      ''
      'WHERE P.OVK_ID=:OVK_ID'
      
        '  and ((select COUNT(*) from PERS_SET)=0 or P.PERS_ID in (select' +
        ' PERS_ID from PERS_SET))'
      'AND  not (KD.DEP_ID is null)'
      'and dateadd("yyyy",15,p.Birthday) <= Date()'
      'and dateadd("yyyy",17,p.Birthday) > Date()'
      'ORDER BY P.FAM, P.IM, P.OTCH')
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
    object qrPersonUZ_NAME: TStringField
      FieldKind = fkCalculated
      FieldName = 'UZ_NAME'
      Size = 250
      Calculated = True
    end
    object qrPersonDIPLOM: TStringField
      FieldKind = fkCalculated
      FieldName = 'DIPLOM'
      Size = 50
      Calculated = True
    end
    object qrPersonEND_DATE: TStringField
      FieldKind = fkCalculated
      FieldName = 'END_DATE'
      Size = 10
      Calculated = True
    end
    object qrPersonKVAL: TStringField
      FieldKind = fkCalculated
      FieldName = 'KVAL'
      Size = 250
      Calculated = True
    end
    object qrPersonNAPR: TStringField
      FieldKind = fkCalculated
      FieldName = 'NAPR'
      Size = 250
      Calculated = True
    end
    object qrPersonOKSO: TStringField
      FieldKind = fkCalculated
      FieldName = 'OKSO'
      Size = 50
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
      FieldName = 'Education'
      Size = 4000
    end
    object qrPersonDEP_FULL_NAME: TStringField
      FieldName = 'DEP_FULL_NAME'
      Size = 250
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
    object qrPersonNAT_NAME: TWideStringField
      FieldName = 'NAT_NAME'
      Size = 100
    end
    object qrPersonWUchet2_IsWork: TIntegerField
      FieldName = 'WUchet2_IsWork'
    end
    object qrPersonPPers_Id: TIntegerField
      FieldName = 'PPers_Id'
    end
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
      'select *'
      'from EDUC inner join KUZ on EDUC.uz_id=KUZ.uz_id'
      'where EDUC.PERS_ID=:pers_id'
      'order by end_date')
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
      
        ',AppointmentLastAll.*,KP.*,IIF(KD.DEP_FULL_NAME is null, KD.DEP_' +
        'NAME, KD.DEP_FULL_NAME) as DEP_FULL_NAME,'
      'P.Pers_Id as PPers_Id,'
      'KED.ED_NAME'
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
      ' KN.NAT_NAME'
      'from ((((((((((((((Person P'
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
      
        'left outer join AppointmentLastAll on (P.Pers_Id=AppointmentLast' +
        'All.Pers_Id))'
      
        'left outer join [KPOST] KP on (AppointmentLastAll.POST_ID=[KP].P' +
        'OST_ID))'
      
        'left outer join [KDEPART] KD on (AppointmentLastAll.DEP_ID=[KD].' +
        'DEP_ID))'
      
        'left outer join [Educ] on (P.PERS_ID=[Educ].PERS_ID and [Educ].t' +
        'ype=1))'
      
        'left outer join [Educ] as Educ2 on (P.PERS_ID=[Educ2].PERS_ID an' +
        'd [Educ2].type=2))'
      'left outer join [KUz] on [KUz].UZ_ID=[Educ].UZ_ID)'
      'left outer join [KUz] as KUz2 on [KUz2].UZ_ID=[Educ2].UZ_ID)'
      'left outer join KNation KN  on (KN.NAT_ID=P.NAT_ID)'
      ''
      'WHERE P.OVK_ID=:OVK_ID'
      
        '  and ((select COUNT(*) from PERS_SET)=0 or P.PERS_ID in (select' +
        ' PERS_ID from PERS_SET))'
      'AND  not (KD.DEP_ID is null)'
      'and dateadd(yy,15,p.Birthday) <= GetDate()'
      'and dateadd(yy,17,p.Birthday) > GetDate()'
      'ORDER BY P.FAM, P.IM, P.OTCH'
      '')
    Left = 128
    Top = 244
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1Functions0Calculate
        Name = 'date'
        ArgMinCount = 0
        ArgMaxCount = 0
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1Functions1Calculate
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
end

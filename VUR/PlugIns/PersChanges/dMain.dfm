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
      
        'select P.*,KWR.*, fg.GROUP_NAME, pc1.OLDVALUE, pc2.NEWVALUE, IIF' +
        '(pc1.BEGIN_DATE is null, pc1.NOTBEGINREASON, CStr(pc1.BEGIN_DATE' +
        ')) as BEG, pc1.SEND_DATE, fg.GROUP_ID,'
      'app.in_date, app.in_ord_numb, app.in_ord_date,'
      
        '  KWR.WRNG_NAME + iif((select Param_Value from Params Where Para' +
        'ms.Param_Id = 8) = '#39'1'#39', iif(P.WSOST_ID=9,'#39' '#1102#1089#1090#1080#1094#1080#1080#39',iif(P.WSOST_' +
        'ID=10,'#39' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#39','#39#39')),'#39#39') as WRNG_Name1'
      'from ((((PersonChanges pc1'
      
        'inner join PersonChanges pc2 on pc1.PERS_ID = pc2.PERS_ID and pc' +
        '1.GROUP_ID = pc2.GROUP_ID)'
      'inner join PERSON P on pc1.PERS_ID = P.PERS_ID)'
      'inner join KL_FLDGROUPS fg on fg.GROUP_ID = pc1.GROUP_ID)'
      'left outer join KWRANGE KWR  on P.WRNG_ID=KWR.WRNG_ID)'
      'left outer join Appointment app on app.Id = pc2.appointment_id'
      'WHERE P.OVK_ID = :OVK_ID '
      '  AND P.IS_WAR<>0'
      '  AND (P.W_DEND is  null or Year(P.W_DEND) >= Year(Date()))'
      'AND '
      
        '(((select max(In_Date) from Appointment where pers_id = P.pers_i' +
        'd and post_id in (select post_id from kpost where cprof_id <> 50' +
        '0)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR ((select max(In_Date) from Appointment where pers_id = P.pers' +
        '_id and post_id in (select post_id from kpost where cprof_id = 5' +
        '00)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))')
    Left = 128
    Top = 188
    object qrPersonPERS_ID: TIntegerField
      FieldName = 'PERS_ID'
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
    object qrPersonFST_ID: TIntegerField
      FieldName = 'FST_ID'
    end
    object qrPersonED_ID: TIntegerField
      FieldName = 'ED_ID'
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
    object qrPersonWSOST_ID: TIntegerField
      FieldName = 'WSOST_ID'
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
    object qrPersonSTATE: TSmallintField
      FieldName = 'STATE'
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
    object qrPersonGROUP_NAME: TWideStringField
      FieldName = 'GROUP_NAME'
      Size = 255
    end
    object qrPersonOLDVALUE: TWideMemoField
      FieldName = 'OLDVALUE'
      BlobType = ftWideMemo
    end
    object qrPersonNEWVALUE: TWideMemoField
      FieldName = 'NEWVALUE'
      BlobType = ftWideMemo
    end
    object qrPersonSEND_DATE: TDateTimeField
      FieldName = 'SEND_DATE'
    end
    object qrPersonWuchet: TStringField
      FieldKind = fkCalculated
      FieldName = 'Wuchet'
      Size = 500
      Calculated = True
    end
    object qrPersonRecNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'RecNo'
      Calculated = True
    end
    object qrPersonBEG: TStringField
      FieldName = 'BEG'
      Size = 300
    end
    object qrPersonComments: TWideMemoField
      FieldName = 'Comments'
      BlobType = ftWideMemo
    end
    object qrPersonWarfare: TWideStringField
      FieldName = 'Warfare'
      Size = 255
    end
    object qrPersonWUchet2_IsWork: TIntegerField
      FieldName = 'WUchet2_IsWork'
    end
    object qrPersonAddInfo: TStringField
      FieldKind = fkCalculated
      FieldName = 'AddInfo'
      Size = 255
      Calculated = True
    end
    object qrPersonGroup_Id: TIntegerField
      FieldName = 'Group_Id'
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
    object qrPersonin_date: TDateTimeField
      FieldName = 'in_date'
    end
    object qrPersonin_ord_numb: TWideStringField
      FieldName = 'in_ord_numb'
      Size = 50
    end
    object qrPersonin_ord_date: TDateTimeField
      FieldName = 'in_ord_date'
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
  end
  object qrUpdate: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrPersonCalcFields
    Parameters = <
      item
        Name = 'SEND_DATE'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end
      item
        Name = 'Date_From'
        Size = -1
        Value = Null
      end
      item
        Name = 'Date_To'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'update PersonChanges pc inner join PERSON P on pc.PERS_ID = P.PE' +
        'RS_ID set SEND_DATE = :SEND_DATE '
      'WHERE P.OVK_ID = :OVK_ID'
      '  AND P.IS_WAR<>0'
      '  AND (P.W_DEND is  null or Year(P.W_DEND) >= Year(Date()))'
      'AND '
      
        '(((select max(In_Date) from Appointment where pers_id = P.pers_i' +
        'd and post_id in (select post_id from kpost where cprof_id <> 50' +
        '0)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR ((select max(In_Date) from Appointment where pers_id = P.pers' +
        '_id and post_id in (select post_id from kpost where cprof_id = 5' +
        '00)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))'
      ' AND pc.CHANGE_DATE >= :Date_From AND pc.CHANGE_DATE <= :Date_To')
    Left = 224
    Top = 196
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1Functions0Calculate
        Name = 'NotIsNull'
        ArgMinCount = 1
        ArgMaxCount = 16
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1Functions1Calculate
        Name = 'Equal'
        ArgMinCount = 2
        ArgMaxCount = 10
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1Functions2Calculate
        Name = 'date'
        ArgMinCount = 0
        ArgMaxCount = 0
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1Functions3Calculate
        Name = 'IOFam'
        ArgMinCount = 3
        ArgMaxCount = 3
        ResultType = 1
      end>
    Left = 295
    Top = 33
  end
end

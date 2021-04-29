object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 480
  Width = 696
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    UDFList = EkUDFList1
    Charset = DEFAULT_CHARSET
    Lang = 0
    Options = [eoGraphicsBinary, eoClearMissedFields, eoDotAsColon]
    DisableControls = True
    Left = 28
    Top = 24
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1Functions0Calculate
        Name = 'FIO'
        ArgMinCount = 3
        ArgMaxCount = 3
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
    Left = 96
    Top = 24
  end
  object dbMain: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=C:\Prog' +
      'ram Files\GranVUS\Data\granvus.mdb;Mode=Share Deny None;Persist ' +
      'Security Info=True;Jet OLEDB:Database Password=45q81ste1109'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 28
    Top = 84
  end
  object qrOrg: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      
        'SELECT o.OrgName, oc.FIO, oc.POST, count(p.W_DBEG) as plus, coun' +
        't(p.W_DEND) as minus'
      'FROM (ORG o'
      'inner join PERSON p on p.ORG_ID = o.ORGID)'
      
        'left outer join ORG_CONT oc on (oc.ORGID = o.ORGID and oc.IS_VUS' +
        ' = 1)'
      'where o.ORGID = 1')
    Left = 84
    Top = 84
  end
  object qrData: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrDataCalcFields
    Parameters = <
      item
        Name = 'ORG_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT PERSON.*, '
      
        '  IIF((d.DEP_FULL_NAME is null) OR d.DEP_FULL_NAME='#39#39', d.DEP_NAM' +
        'E, d.DEP_FULL_NAME) as DEP_NAME, '
      '  p.POST_NAME, Year(PERSON.BIRTHDAY) as BirthYear, '
      
        '  w.WRNG_NAME + iif((select Param_Value from Params Where Params' +
        '.Param_Id = 8) = '#39'1'#39', iif(PERSON.WSOST_ID=9,'#39' '#1102#1089#1090#1080#1094#1080#1080#39',iif(PERSO' +
        'N.WSOST_ID=10,'#39' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#39','#39#39')),'#39#39') as WRNG_Name, '
      '  IIF(PERSON.WUCHET2_IsWork = 1, '#39#1089#1087#1077#1094#1080#1072#1083#1100#1085#1099#1081#39', '#39#1086#1073#1097#1080#1081#39') + '
      '  '#9'IIF(PERSON.WUCHET1 is null, '#39#39', '#39', '#39' + PERSON.WUCHET1) + '
      
        '  '#9'IIF(PERSON.WUCHET2_IsWork = 1, '#39', '#39' + PERSON.WUCHET2_Ser + '#39' ' +
        #39' + PERSON.WUCHET2, '#39#39') as WUCHET, '
      
        '  o.OVK_NAME, IIF(a1.POST_CODE is null, '#39#39', CStr(a1.POST_CODE) +' +
        ' '#39', '#39') + a1.ADDR_STR as ADDR1, '
      
        '  IIF(a2.POST_CODE is null, '#39#39', CStr(a2.POST_CODE) + '#39', '#39') + a2.' +
        'ADDR_STR as ADDR2,'
      '  ed.ED_NAME'
      'FROM (((((((PERSON'
      'LEFT OUTER JOIN AppointmentLast app'
      '    ON app.PERS_ID = PERSON.PERS_ID)'
      'LEFT OUTER JOIN KDEPART d'
      '    ON app.DEP_ID = d.DEP_ID)'
      'LEFT OUTER JOIN KPOST p'
      '    ON app.POST_ID = p.POST_ID)'
      'LEFT OUTER JOIN KWRANGE w'
      '    ON PERSON.WRNG_ID = w.WRNG_ID)'
      'LEFT OUTER JOIN KOVK o'
      '    ON o.OVK_ID = PERSON.OVK_ID)'
      'LEFT OUTER JOIN ADDR a1'
      '    ON (a1.PERS_ID = PERSON.PERS_ID and a1.ADDR_TYPE = 0))'
      'LEFT OUTER JOIN ADDR a2'
      '    ON (a2.PERS_ID = PERSON.PERS_ID and a2.ADDR_TYPE = 1))'
      'LEFT OUTER JOIN KEDUC ed'
      '    ON (ed.ED_ID = PERSON.ED_ID)'
      'WHERE PERSON.ORG_ID = :ORG_ID'
      '  AND ((select COUNT(*) from PERS_SET)=0'
      '   OR PERSON.PERS_ID in (select PERS_ID from PERS_SET))'
      '')
    Left = 152
    Top = 84
    object qrDataPERS_ID: TIntegerField
      FieldName = 'PERS_ID'
    end
    object qrDataORG_ID: TIntegerField
      FieldName = 'ORG_ID'
    end
    object qrDataFAM: TWideStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrDataIM: TWideStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrDataOTCH: TWideStringField
      FieldName = 'OTCH'
      Size = 50
    end
    object qrDataMALE: TSmallintField
      FieldName = 'MALE'
    end
    object qrDataBIRTHDAY: TDateTimeField
      FieldName = 'BIRTHDAY'
    end
    object qrDataBIRTHPLACE: TWideStringField
      FieldName = 'BIRTHPLACE'
      Size = 100
    end
    object qrDataOKATO: TWideStringField
      FieldName = 'OKATO'
      Size = 11
    end
    object qrDataNAT_ID: TIntegerField
      FieldName = 'NAT_ID'
    end
    object qrDataPSP_SER: TWideStringField
      FieldName = 'PSP_SER'
      Size = 10
    end
    object qrDataPSP_NUM: TWideStringField
      FieldName = 'PSP_NUM'
      Size = 10
    end
    object qrDataPSP_PLACE: TWideStringField
      FieldName = 'PSP_PLACE'
      Size = 100
    end
    object qrDataPSP_DATE: TDateTimeField
      FieldName = 'PSP_DATE'
    end
    object qrDataINN: TWideStringField
      FieldName = 'INN'
      Size = 12
    end
    object qrDataSTRAH: TWideStringField
      FieldName = 'STRAH'
    end
    object qrDataFST_ID: TIntegerField
      FieldName = 'FST_ID'
    end
    object qrDataED_ID: TIntegerField
      FieldName = 'ED_ID'
    end
    object qrDataSC_ID: TIntegerField
      FieldName = 'SC_ID'
    end
    object qrDataIS_WAR: TSmallintField
      FieldName = 'IS_WAR'
    end
    object qrDataEOARMY_DATE: TWideStringField
      FieldName = 'EOARMY_DATE'
      Size = 10
    end
    object qrDataCSOST: TSmallintField
      FieldName = 'CSOST'
    end
    object qrDataWRNG_ID: TIntegerField
      FieldName = 'WRNG_ID'
    end
    object qrDataWSOST_ID: TIntegerField
      FieldName = 'WSOST_ID'
    end
    object qrDataCAT_ZAP: TSmallintField
      FieldName = 'CAT_ZAP'
    end
    object qrDataVUS: TWideStringField
      FieldName = 'VUS'
      Size = 10
    end
    object qrDataWCAT: TWideStringField
      FieldName = 'WCAT'
      Size = 1
    end
    object qrDataOVK_ID: TIntegerField
      FieldName = 'OVK_ID'
    end
    object qrDataWUCHET1: TWideStringField
      FieldName = 'WUCHET1'
      Size = 100
    end
    object qrDataSpecialWUchet1: TIntegerField
      FieldName = 'SpecialWUchet1'
    end
    object qrDataWUCHET2: TWideStringField
      FieldName = 'WUCHET2'
      Size = 100
    end
    object qrDataWDISCL: TWideStringField
      FieldName = 'WDISCL'
      Size = 100
    end
    object qrDataTAB_NUMB: TWideStringField
      FieldName = 'TAB_NUMB'
      Size = 10
    end
    object qrDataDOG_NUMB: TWideStringField
      FieldName = 'DOG_NUMB'
    end
    object qrDataDOG_DATE: TDateTimeField
      FieldName = 'DOG_DATE'
    end
    object qrDataIS_RAB: TSmallintField
      FieldName = 'IS_RAB'
    end
    object qrDataPROF1: TWideStringField
      FieldName = 'PROF1'
      Size = 50
    end
    object qrDataOKPDTR1: TWideStringField
      FieldName = 'OKPDTR1'
      Size = 10
    end
    object qrDataPROF2: TWideStringField
      FieldName = 'PROF2'
      Size = 50
    end
    object qrDataOKPDTR2: TWideStringField
      FieldName = 'OKPDTR2'
      Size = 10
    end
    object qrDataCONFDATE: TDateTimeField
      FieldName = 'CONFDATE'
    end
    object qrDataNUMB_T2: TIntegerField
      FieldName = 'NUMB_T2'
    end
    object qrDataW_DBEG: TDateTimeField
      FieldName = 'W_DBEG'
    end
    object qrDataW_DEND: TDateTimeField
      FieldName = 'W_DEND'
    end
    object qrDataD_OVK: TDateTimeField
      FieldName = 'D_OVK'
    end
    object qrDataD_WBIL: TDateTimeField
      FieldName = 'D_WBIL'
    end
    object qrDataOUT_ORD_NUMB: TWideStringField
      FieldName = 'OUT_ORD_NUMB'
      Size = 50
    end
    object qrDataOUT_ORD_DATE: TDateTimeField
      FieldName = 'OUT_ORD_DATE'
    end
    object qrDataOUT_DATE: TDateTimeField
      FieldName = 'OUT_DATE'
    end
    object qrDataWID: TWideStringField
      FieldName = 'WID'
      Size = 10
    end
    object qrDataWBser: TWideStringField
      FieldName = 'WBser'
      Size = 2
    end
    object qrDataWBnum: TWideStringField
      FieldName = 'WBnum'
      Size = 8
    end
    object qrDataComments: TWideMemoField
      FieldName = 'Comments'
      BlobType = ftWideMemo
    end
    object qrDataWUCHET2_date: TDateTimeField
      FieldName = 'WUCHET2_date'
    end
    object qrDataDocument: TIntegerField
      FieldName = 'Document'
    end
    object qrDataBranch: TIntegerField
      FieldName = 'Branch'
    end
    object qrDataIsAspirant: TIntegerField
      FieldName = 'IsAspirant'
    end
    object qrDataStudyForm: TIntegerField
      FieldName = 'StudyForm'
    end
    object qrDataStudyEnd_date: TDateTimeField
      FieldName = 'StudyEnd_date'
    end
    object qrDataOrderAkadem: TWideStringField
      FieldName = 'OrderAkadem'
    end
    object qrDataOrderAkadem_date: TDateTimeField
      FieldName = 'OrderAkadem_date'
    end
    object qrDataReasonAkadem: TWideStringField
      FieldName = 'ReasonAkadem'
      Size = 100
    end
    object qrDataBeginAkadem_date: TDateTimeField
      FieldName = 'BeginAkadem_date'
    end
    object qrDataEndAkadem_date: TDateTimeField
      FieldName = 'EndAkadem_date'
    end
    object qrDataRealEndAkadem_date: TDateTimeField
      FieldName = 'RealEndAkadem_date'
    end
    object qrDataMedResult_date: TDateTimeField
      FieldName = 'MedResult_date'
    end
    object qrDataMedResult: TIntegerField
      FieldName = 'MedResult'
    end
    object qrDataVKStatus: TIntegerField
      FieldName = 'VKStatus'
    end
    object qrDataBeginWar_date: TDateTimeField
      FieldName = 'BeginWar_date'
    end
    object qrDataEndWar_date: TDateTimeField
      FieldName = 'EndWar_date'
    end
    object qrDataRealEndWar_date: TDateTimeField
      FieldName = 'RealEndWar_date'
    end
    object qrDataReasonEndWar: TWideStringField
      FieldName = 'ReasonEndWar'
      Size = 100
    end
    object qrDataDismissal_date: TDateTimeField
      FieldName = 'Dismissal_date'
    end
    object qrDataOrderDismissal: TWideStringField
      FieldName = 'OrderDismissal'
    end
    object qrDataOrderDismissal_date: TDateTimeField
      FieldName = 'OrderDismissal_date'
    end
    object qrDataReasonDismissal: TWideStringField
      FieldName = 'ReasonDismissal'
      Size = 100
    end
    object qrDataDisserName: TWideStringField
      FieldName = 'DisserName'
      Size = 100
    end
    object qrDataDegree_ID: TIntegerField
      FieldName = 'Degree_ID'
    end
    object qrDataGuideDegree_ID: TIntegerField
      FieldName = 'GuideDegree_ID'
    end
    object qrDataFIOGuide: TWideStringField
      FieldName = 'FIOGuide'
      Size = 100
    end
    object qrDataDefend_date: TDateTimeField
      FieldName = 'Defend_date'
    end
    object qrDataRealDefend_date: TDateTimeField
      FieldName = 'RealDefend_date'
    end
    object qrDataContractEnd: TWideStringField
      FieldName = 'ContractEnd'
      Size = 50
    end
    object qrDataKval_Id: TIntegerField
      FieldName = 'Kval_Id'
    end
    object qrDataDelay_ID: TIntegerField
      FieldName = 'Delay_ID'
    end
    object qrDataDelayStart_date: TDateTimeField
      FieldName = 'DelayStart_date'
    end
    object qrDataDelayEnd_date: TDateTimeField
      FieldName = 'DelayEnd_date'
    end
    object qrDataHealth: TWideStringField
      FieldName = 'Health'
      Size = 60
    end
    object qrDataHealthDocNo: TWideStringField
      FieldName = 'HealthDocNo'
      Size = 60
    end
    object qrDataHealthDoc_date: TDateTimeField
      FieldName = 'HealthDoc_date'
    end
    object qrDataWarfare: TWideStringField
      FieldName = 'Warfare'
      Size = 255
    end
    object qrDataASOrder_In: TWideStringField
      FieldName = 'ASOrder_In'
    end
    object qrDataASDate_In: TDateTimeField
      FieldName = 'ASDate_In'
    end
    object qrDataASOut_ORD_NUMB: TWideStringField
      FieldName = 'ASOut_ORD_NUMB'
      Size = 50
    end
    object qrDataASOut_ORD_Date: TDateTimeField
      FieldName = 'ASOut_ORD_Date'
    end
    object qrDataASOut_Date: TDateTimeField
      FieldName = 'ASOut_Date'
    end
    object qrDataAppLast: TIntegerField
      FieldName = 'AppLast'
    end
    object qrDataAppLastAll: TIntegerField
      FieldName = 'AppLastAll'
    end
    object qrDataAppLastStudy: TIntegerField
      FieldName = 'AppLastStudy'
    end
    object qrDataAppFirst: TIntegerField
      FieldName = 'AppFirst'
    end
    object qrDataAppFirstStudy: TIntegerField
      FieldName = 'AppFirstStudy'
    end
    object qrDataASAppLast: TIntegerField
      FieldName = 'ASAppLast'
    end
    object qrDataASAppFirst: TIntegerField
      FieldName = 'ASAppFirst'
    end
    object qrDataMed_Where: TWideStringField
      FieldName = 'Med_Where'
      Size = 40
    end
    object qrDataMed_Date: TDateTimeField
      FieldName = 'Med_Date'
    end
    object qrDataMed_Result: TWideStringField
      FieldName = 'Med_Result'
      Size = 100
    end
    object qrDataPsy_Where: TWideStringField
      FieldName = 'Psy_Where'
      Size = 40
    end
    object qrDataPsy_Date: TDateTimeField
      FieldName = 'Psy_Date'
    end
    object qrDataPsy_Result: TWideStringField
      FieldName = 'Psy_Result'
      Size = 100
    end
    object qrDataAsf_Sport: TWideStringField
      FieldName = 'Asf_Sport'
      Size = 40
    end
    object qrDataMob_Days: TIntegerField
      FieldName = 'Mob_Days'
    end
    object qrDataMob_Hours: TIntegerField
      FieldName = 'Mob_Hours'
    end
    object qrDataMob_Mins: TIntegerField
      FieldName = 'Mob_Mins'
    end
    object qrDataMob_CardDate: TDateTimeField
      FieldName = 'Mob_CardDate'
    end
    object qrDataMob_MissReason: TWideStringField
      FieldName = 'Mob_MissReason'
      Size = 255
    end
    object qrDataWUCHET2_Ser: TWideStringField
      FieldName = 'WUCHET2_Ser'
      Size = 50
    end
    object qrDataWUCHET2_IsWork: TIntegerField
      FieldName = 'WUCHET2_IsWork'
    end
    object qrDataPDPCode: TWideStringField
      FieldName = 'PDPCode'
      Size = 50
    end
    object qrDataWRNG_Date: TDateTimeField
      FieldName = 'WRNG_Date'
    end
    object qrDataDEP_NAME: TWideStringField
      FieldName = 'DEP_NAME'
      ReadOnly = True
      Size = 255
    end
    object qrDataPOST_NAME: TWideStringField
      FieldName = 'POST_NAME'
      Size = 255
    end
    object qrDataBirthYear: TSmallintField
      FieldName = 'BirthYear'
      ReadOnly = True
    end
    object qrDataWRNG_Name: TWideStringField
      FieldName = 'WRNG_Name'
      ReadOnly = True
      Size = 255
    end
    object qrDataWUCHET: TWideStringField
      FieldName = 'WUCHET'
      ReadOnly = True
      Size = 255
    end
    object qrDataOVK_NAME: TWideStringField
      FieldName = 'OVK_NAME'
      Size = 100
    end
    object qrDataADDR1: TWideStringField
      FieldName = 'ADDR1'
      ReadOnly = True
      Size = 255
    end
    object qrDataADDR2: TWideStringField
      FieldName = 'ADDR2'
      ReadOnly = True
      Size = 255
    end
    object qrDataED_NAME: TWideStringField
      FieldName = 'ED_NAME'
      Size = 255
    end
    object qrDataOKVED_OKPDTR: TStringField
      FieldKind = fkCalculated
      FieldName = 'OKVED_OKPDTR'
      Size = 100
      Calculated = True
    end
  end
end

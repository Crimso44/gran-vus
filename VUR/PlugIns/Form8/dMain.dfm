object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 202
  Width = 295
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
    DisableControls = True
    Left = 89
    Top = 30
  end
  object qrPerson: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrPersonCalcFields
    Parameters = <>
    SQL.Strings = (
      
        'select p.fam, p.im, p.otch, Year(p.BirthDay) as BirthYear, s.WSo' +
        'st_Name, VUS, [KWR].WRNG_NAME, p.WCAT, KPOST.POST_NAME, '
      
        'iif((MvkOrder.Post_Id = ala.post_Id and MvkOrder.DocNumber is no' +
        't null) or pdp.Okved is null, '#39#39', '#39#1054#1050#1042#1069#1044': '#39'+pdp.Okved) as Okved,' +
        ' '
      
        'iif((MvkOrder.Post_Id = ala.post_Id and MvkOrder.DocNumber is no' +
        't null) or KOKPDTR.KOKPDTR_Code is null, '#39#39', '#39#1054#1050#1055#1044#1058#1056': '#39'+KOKPDTR.' +
        'KOKPDTR_Code) as KOKPDTR_Code,'
      
        'iif((MvkOrder.Post_Id <> ala.post_Id or MvkOrder.DocNumber is nu' +
        'll), '#39#39', '#39#1055#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1052#1042#1050' '#8470' '#39' + MvkOrder.DocNumber + '#39' '#1086#1090' '#39' + ' +
        'CStr(MvkOrder.DocDate)) as MvkData,'
      '  KWR.WRNG_NAME as WRNG_Name1'
      'from (((((((Person p'
      'left outer join KWSOST s on s.WSost_ID = p.WSost_ID)'
      'left outer join KWRANGE KWR on KWR.WRNG_ID = p.WRNG_ID)'
      
        'left outer join AppointmentLastAll ala on ala.PERS_ID = p.PERS_I' +
        'D)'
      'left outer join KPOST on KPOST.POST_ID = ala.POST_ID)'
      'left outer join MvkOrder on MvkOrder.Pers_ID = p.Pers_ID)'
      
        'inner join PersonReservChkInfo prc on (prc.PERS_ID = p.PERS_ID a' +
        'nd prc.IS_BAD = 1 and prc.Reserved = 0))'
      'left outer join KOKPDTR on KOKPDTR.KOKPDTR_Id = KPOST.KOKPDTR)'
      'left outer join TPDP pdp on pdp.kokpdtr = KPOST.KOKPDTR'
      'where P.IS_WAR<>0 and'
      
        '  (not ((p.MALE=1 and (KWR.M_LIMIT is not NULL) and  (#FullAges#' +
        'p.BIRTHDAY#)>KWR.M_LIMIT  ) or '
      
        '  (p.MALE=0 and (KWR.FEM_LIMIT is not NULL) and  (#FullAges#p.BI' +
        'RTHDAY#)>KWR.FEM_LIMIT)))'
      'and (IsNull(p.OKVED) or p.OKVED = pdp.OKVED)'
      'and (p.Wuchet2_IsWork is null or p.Wuchet2_IsWork = 0)'
      ' AND '
      '((P.AppLast IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR (P.AppLastStudy IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL' +
        '))'
      '/*PERS_SET*/')
    Left = 96
    Top = 85
    object qrPersonfam: TStringField
      FieldName = 'fam'
      Size = 4000
    end
    object qrPersonim: TStringField
      FieldName = 'im'
      Size = 4000
    end
    object qrPersonotch: TStringField
      FieldName = 'otch'
      Size = 4000
    end
    object qrPersonBirthYear: TIntegerField
      FieldName = 'BirthYear'
    end
    object qrPersonWSost_Name: TStringField
      FieldName = 'WSost_Name'
      Size = 4000
    end
    object qrPersonVUS: TStringField
      FieldName = 'VUS'
      Size = 4000
    end
    object qrPersonWRNG_NAME: TStringField
      FieldName = 'WRNG_NAME'
      Size = 4000
    end
    object qrPersonWCAT: TStringField
      FieldName = 'WCAT'
      Size = 4000
    end
    object qrPersonPOST_NAME: TStringField
      FieldName = 'POST_NAME'
      Size = 4000
    end
    object qrPersonRecNo: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'RecNo'
      Calculated = True
    end
    object qrPersonOkved: TStringField
      FieldName = 'Okved'
      Size = 100
    end
    object qrPersonKOKPDTR_Code: TStringField
      FieldName = 'KOKPDTR_Code'
      Size = 100
    end
    object qrPersonWRNG_Name1: TStringField
      FieldName = 'WRNG_Name1'
      Size = 100
    end
    object qrPersonMvkData: TStringField
      FieldName = 'MvkData'
      Size = 255
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
    OnCalcFields = qrOrgCalcFields
    Parameters = <>
    SQL.Strings = (
      'select o.orgname, oc.fam, oc.im, oc.otch, oc.POST'
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
    object qrOrgorgname: TWideMemoField
      FieldName = 'orgname'
      BlobType = ftWideMemo
    end
  end
  object qrExecutor: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ORG_Cont Where Is_Gen = 3')
    Left = 200
    Top = 112
    object qrExecutorCONTID: TIntegerField
      FieldName = 'CONTID'
    end
    object qrExecutorORGID: TIntegerField
      FieldName = 'ORGID'
    end
    object qrExecutorDEPART: TWideStringField
      FieldName = 'DEPART'
      Size = 50
    end
    object qrExecutorPOST: TWideStringField
      FieldName = 'POST'
      Size = 50
    end
    object qrExecutorFIO: TWideStringField
      FieldName = 'FIO'
      Size = 150
    end
    object qrExecutorPHONE: TWideStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object qrExecutorFAX: TWideStringField
      FieldName = 'FAX'
      Size = 50
    end
    object qrExecutorEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object qrExecutorIS_GEN: TSmallintField
      FieldName = 'IS_GEN'
    end
    object qrExecutorIS_VUS: TSmallintField
      FieldName = 'IS_VUS'
    end
    object qrExecutorFAM: TWideStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrExecutorIM: TWideStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrExecutorOTCH: TWideStringField
      FieldName = 'OTCH'
      Size = 50
    end
  end
end

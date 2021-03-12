object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 216
  Width = 331
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
  object qrOrg: TADOQuery
    Connection = dbMain
    Parameters = <
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select'
      '1 as RecNo,'
      'o.OrgName,'
      'o.MAINOKONH,'
      'o.Occupation,'
      'IIF(k.ISOVK, '
      '  (select Param_Value from Params Where Params.Param_Id = 12), '
      '  (select Param_Value from Params Where Params.Param_Id = 13)'
      ') as ISOVK,'
      'k.OVK_NAME,'
      'k.OVK_ADDR,'
      '(select sum(Col_1) from Form6_2015 Where Col_B = 5) as AllPers,'
      ''
      
        '(select sum(Col_2) from Form6_2015 Where Col_B = 5) as AllReserv' +
        'e,'
      ''
      
        '(select sum(Col_3) from Form6_2015 Where Col_B = 5) as AllOffice' +
        'rReserve,'
      ''
      '(select sum(Col_6) from Form6_2015 Where Col_B = 5) as AllBron,'
      ''
      
        '(select sum(Col_7) from Form6_2015 Where Col_B = 5) as AllOffice' +
        'rBron,'
      ''
      
        'Iif(AllReserve>0,Round(AllBron/AllReserve*100,1),0) as BronPerce' +
        'nt,'
      ''
      '(select count(*) from (Person P'
      'inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)'
      'where Org_Id = o.OrgId and not IsNull(WUchet1) AND'
      
        '(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Da' +
        'te())) and'
      '(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(Date())) and ('
      
        '         (P.MALE=1 and (kr.M_LIMIT is not NULL) and  (#FullAges#' +
        'P.BIRTHDAY#)>kr.M_LIMIT  ) or'
      
        '         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  (#FullAge' +
        's#P.BIRTHDAY#)>kr.FEM_LIMIT  ))'
      '        ,1,0)) = 0)'
      'AND kr.CHE > 0 and'
      
        '(((select max(In_Date) from Appointment where pers_id = P.pers_i' +
        'd and post_id in (select post_id from kpost where cprof_id <> 50' +
        '0)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR ((select max(In_Date) from Appointment where pers_id = P.pers' +
        '_id and post_id in (select post_id from kpost where cprof_id = 5' +
        '00)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))'
      ') as AllAttached,'
      ''
      '(select count(*) from (Person P'
      'inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)'
      'where Org_Id = o.OrgId and not IsNull(WUchet1) and'
      
        '(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Da' +
        'te())) and'
      '(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(Date())) and ('
      
        '         (P.MALE=1 and (kr.M_LIMIT is not NULL) and (#FullAges#P' +
        '.BIRTHDAY#)>kr.M_LIMIT  ) or'
      
        '         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  (#FullAge' +
        's#P.BIRTHDAY#)>kr.FEM_LIMIT  ))'
      '        ,1,0)) = 0)'
      'and kr.State = 3 AND kr.CHE > 0 and'
      
        '(((select max(In_Date) from Appointment where pers_id = P.pers_i' +
        'd and post_id in (select post_id from kpost where cprof_id <> 50' +
        '0)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR ((select max(In_Date) from Appointment where pers_id = P.pers' +
        '_id and post_id in (select post_id from kpost where cprof_id = 5' +
        '00)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))'
      ') as AllOfficerAttached,'
      ''
      
        'Iif(AllReserve>0,Round(AllAttached/AllReserve*100,1),0) as Attac' +
        'hedPercent,'
      ''
      
        '(select sum(Col_11) from Form6_2015 Where Col_B = 5) as AllConsc' +
        'ript'
      ''
      'from (ORG o'
      'inner join KOVK k on k.OVK_ID = o.OVK_ID)')
    Left = 96
    Top = 85
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
      end>
    Left = 157
    Top = 29
  end
  object qrGen: TADOQuery
    Connection = dbMain
    OnCalcFields = qrGenCalcFields
    Parameters = <>
    SQL.Strings = (
      'select * from ORG_CONT')
    Left = 145
    Top = 89
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
  object qrOrgNoJet: TADOQuery
    Connection = dbMain
    Parameters = <
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end
      item
        Name = 'OVK_Id'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select *, '
      
        #9'Iif(AllReserve>0,Round(AllBron/AllReserve*100,1),0) as BronPerc' +
        'ent,'
      
        #9'Iif(AllReserve>0,Round(AllAttached/AllReserve*100,1),0) as Atta' +
        'chedPercent'
      'from ('
      'select'
      '1 as RecNo, o.OrgName, o.OrgId, o.MAINOKONH, o.Occupation,'
      'IIF(k.ISOVK = 1, '#39#1042#1086#1077#1085#1085#1086#1084#1091' '#1082#1086#1084#1080#1089#1089#1072#1088#1091#39', '#39#1056#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1102#39') as ISOVK,'
      'k.OVK_NAME,'
      'k.OVK_ADDR,'
      '(select sum(Col_1) from Form6_2015 Where Col_B = 5) as AllPers,'
      
        '(select sum(Col_2) from Form6_2015 Where Col_B = 5) as AllReserv' +
        'e,'
      
        '(select sum(Col_3) from Form6_2015 Where Col_B = 5) as AllOffice' +
        'rReserve,'
      '(select sum(Col_6) from Form6_2015 Where Col_B = 5) as AllBron,'
      
        '(select sum(Col_7) from Form6_2015 Where Col_B = 5) as AllOffice' +
        'rBron,'
      ''
      '(select count(*) from (Person P'
      'inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)'
      'where Org_Id = o.OrgId and not (WUchet1 is null) AND'
      
        '(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Ge' +
        'tDate())) and'
      
        '(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(GetDate())) and' +
        ' ('
      
        '         (P.MALE=1 and (kr.M_LIMIT is not NULL) and  (#FullAges#' +
        'P.BIRTHDAY#)>kr.M_LIMIT  ) or'
      
        '         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  (#FullAge' +
        's#P.BIRTHDAY#)>kr.FEM_LIMIT  ))'
      '        ,1,0)) = 0)'
      'AND kr.CHE > 0 and'
      
        '(((select max(In_Date) from Appointment where pers_id = P.pers_i' +
        'd and post_id in (select post_id from kpost where cprof_id <> 50' +
        '0)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR ((select max(In_Date) from Appointment where pers_id = P.pers' +
        '_id and post_id in (select post_id from kpost where cprof_id = 5' +
        '00)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))'
      ') as AllAttached,'
      ''
      '(select count(*) from (Person P'
      'inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)'
      'where Org_Id = o.OrgId and not (WUchet1 is null) and'
      
        '(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Ge' +
        'tDate())) and'
      
        '(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(GetDate())) and' +
        ' ('
      
        '         (P.MALE=1 and (kr.M_LIMIT is not NULL) and (#FullAges#P' +
        '.BIRTHDAY#)>kr.M_LIMIT  ) or'
      
        '         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  (#FullAge' +
        's#P.BIRTHDAY#)>kr.FEM_LIMIT  ))'
      '        ,1,0)) = 0)'
      'and kr.State = 3 AND kr.CHE > 0 and'
      
        '(((select max(In_Date) from Appointment where pers_id = P.pers_i' +
        'd and post_id in (select post_id from kpost where cprof_id <> 50' +
        '0)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)'
      
        'OR ((select max(In_Date) from Appointment where pers_id = P.pers' +
        '_id and post_id in (select post_id from kpost where cprof_id = 5' +
        '00)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))'
      ') as AllOfficerAttached,'
      ''
      
        '(select sum(Col_11) from Form6_2015 Where Col_B = 5) as AllConsc' +
        'ript'
      ''
      'from (ORG o'
      'inner join KOVK k on k.OVK_ID = o.OVK_ID)'
      ') x'
      '')
    Left = 104
    Top = 141
  end
end

object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 260
  Width = 383
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
  object ReportQuery: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'Dep_ID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT IIF((dep.DEP_FULL_NAME is null) OR dep.DEP_FULL_NAME='#39#39', ' +
        'dep.DEP_NAME, dep.DEP_FULL_NAME) as Dep_NAME_X, '
      '  ppd.fam+'#39' '#39'+ppd.im+'#39' '#39'+ppd.otch AS fio, count(*) AS Cnt'
      
        'FROM ((((((Person AS p INNER JOIN Appointment AS AppointmentLast' +
        'All ON p.AppLastAll=AppointmentLastAll.Id) '
      
        'INNER JOIN KDepart AS dep ON dep.Dep_Id = AppointmentLastAll.Dep' +
        '_Id) '
      'LEFT JOIN Pers_Deps AS pd ON pd.Dep_Id = dep.Dep_Id) '
      'LEFT JOIN Person AS ppd ON ppd.Pers_Id = pd.Pers_Id) '
      'LEFT JOIN KWRange ON p.WRng_Id=[KWRange].WRng_Id) '
      
        'LEFT JOIN Appointment AS AppointmentFirst ON p.AppLast=Appointme' +
        'ntFirst.Id) '
      
        'LEFT JOIN Appointment AS AppointmentFirstStudy ON p.AppFirstStud' +
        'y=AppointmentFirstStudy.Id'
      'WHERE p.WUchet2_IsWork = 1'
      
        'and (p.Out_Date is null or p.Out_Date > Date() or ((p.Dismissal_' +
        'Date is null or p.Dismissal_Date > Date() or AppointmentFirstStu' +
        'dy.In_Date is null) and AppointmentFirstStudy.In_Date is not nul' +
        'l))'
      
        'and (p.Out_Date is null or p.Out_Date > Date() or ((p.Dismissal_' +
        'Date is null or p.Dismissal_Date > Date() or AppointmentFirst.In' +
        '_Date is null) and AppointmentFirst.In_Date is not null))'
      'and (p.W_DEnd is null or p.W_DEnd > Date())'
      'and p.is_war = 1'
      'and  IIF(p.W_DEND is NULL and ('
      
        '         (p.MALE=1 and ([KWRANGE].M_LIMIT is not NULL) and  (#Fu' +
        'llAges#p.BIRTHDAY#)>[KWRANGE].M_LIMIT  ) or'
      
        '         (p.MALE=0 and ([KWRANGE].FEM_LIMIT is not NULL) and  (#' +
        'FullAges#p.BIRTHDAY#)>[KWRANGE].FEM_LIMIT  ))'
      '        ,1,0) = 0'
      '/*PERS_SET*/'
      
        'GROUP BY IIF((dep.DEP_FULL_NAME is null) OR dep.DEP_FULL_NAME='#39#39 +
        ', dep.DEP_NAME, dep.DEP_FULL_NAME), ppd.fam+'#39' '#39'+ppd.im+'#39' '#39'+ppd.o' +
        'tch'
      'Order by 1, 2')
    Left = 232
    Top = 152
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1Functions0Calculate
        Name = 'RowNum'
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
    Left = 224
    Top = 56
  end
  object qrExecutor: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ORG_Cont Where Is_Gen = 3')
    Left = 120
    Top = 56
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

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
    Lang = 1049
    Options = [eoGraphicsBinary, eoClearMissedFields, eoDotAsColon]
    DisableControls = True
    Left = 12
    Top = 132
  end
  object dbMain: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password="";Persist Security Info=True;Data S' +
      'ource=GranVUS;Extended Properties="DSN=GranVUS;DBQ=D:\WORK\GRANV' +
      'US\DATA;DefaultDir=D:\WORK\GRANVUS\DATA;DriverId=533;FIL=dBase 5' +
      '.0;MaxBufferSize=2048;PageTimeout=300;";Initial Catalog=D:\WORK\' +
      'GRANVUS\DATA'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 28
    Top = 16
  end
  object qrPerson: TADOQuery
    Connection = dbMain
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'select Person.*,KOVK.*,KWRange.*,KFState.*,Addr.*,A1.POST_CODE a' +
        's POST_CODE1,A1.ADDR_STR as ADDR_STR1'
      
        ',AppointmentLastAll.*,KPost.*, IIF([KDepart].DEP_FULL_NAME is nu' +
        'll, [KDEPART].DEP_NAME, [KDepart].DEP_FULL_NAME) as DEP_NAME,'
      'IIF(Person.IsAspirant is null, '#39#1088#1072#1073#1086#1090#1099#39', '#39#1091#1095#1077#1073#1099#39') as Mesto, '
      'IIF(KOVK.ISOVK, '
      '  (select Param_Value from Params Where Params.Param_Id = 12), '
      '  (select Param_Value from Params Where Params.Param_Id = 13)'
      ') as OVK,'
      
        'IIF(Person.IsAspirant is null, '#39#1076#1086#1083#1078#1085#1086#1089#1090#1100#39', '#39#1082#1091#1088#1089#39') as Dolg, Yea' +
        'r(BirthDay) as BirthYear,'
      ' KEduc.ED_NAME'
      ' &iif(IsNull(Kuz.UZ_NAME),"",", "&Kuz.UZ_NAME) '
      ' &iif(IsNull(Educ.END_DATE),"",", "&Educ.END_DATE) '
      ' &iif((KKVAL.Kval_Name is null)     ,'#39#39','#39', '#39'&KKVAL.Kval_Name)'
      ' &iif((KNapr.NAPR_Name is null)     ,'#39#39','#39', '#39'&KNapr.NAPR_Name) '
      ' &iif(IsNull(Kuz2.UZ_NAME),"",", "&Kuz2.UZ_NAME) '
      ' &iif(IsNull(Educ2.END_DATE),"",", "&Educ2.END_DATE) '
      ' &iif((KKVAL2.Kval_Name is null)     ,'#39#39','#39', '#39'&KKVAL2.Kval_Name)'
      ' &iif((KNapr2.NAPR_Name is null)     ,'#39#39','#39', '#39'&KNapr2.NAPR_Name) '
      ' &iif(IsNull(Kuz3.UZ_NAME),"",", "&Kuz3.UZ_NAME) '
      ' &iif(IsNull(Educ3.END_DATE),"",", "&Educ3.END_DATE) '
      ' &iif((KKVAL3.Kval_Name is null)     ,'#39#39','#39', '#39'&KKVAL3.Kval_Name)'
      ' &iif((KNapr3.NAPR_Name is null)     ,'#39#39','#39', '#39'&KNapr3.NAPR_Name) '
      ' &iif(IsNull(Person.PROF1),"",", "&Person.PROF1) '
      'as Education,'
      
        '  KWRange.WRNG_NAME + iif((select Param_Value from Params Where ' +
        'Params.Param_Id = 8) = '#39'1'#39', iif(Person.WSOST_ID=9,'#39' '#1102#1089#1090#1080#1094#1080#1080#39',iif' +
        '(Person.WSOST_ID=10,'#39' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#39','#39#39')),'#39#39') as WRNG_Name1'
      'from (((((((((((((((((((([Person]'
      'left outer join [KOVK] on [Person].OVK_ID=[KOVK].OVK_ID)'
      'left outer join [KWRange] on [Person].WRNG_ID=[KWRange].WRNG_ID)'
      'left outer join [KEduc] on [Person].ED_ID=[KEduc].ED_ID)'
      'left outer join [KFState] on [Person].FST_ID=[KFState].FST_ID)'
      
        'left outer join [Addr] on ([Person].PERS_ID=[Addr].PERS_ID and [' +
        'Addr].ADDR_TYPE=0))'
      
        'left outer join [Addr] A1 on ([Person].PERS_ID=A1.PERS_ID and A1' +
        '.ADDR_TYPE=1))'
      
        'left outer join [Educ] on ([Person].PERS_ID=[Educ].PERS_ID and [' +
        'Educ].type=1))'
      'left outer join KKval on KKval.kval_id = [Educ].Kval_Id)'
      'left outer join KNapr on KNapr.Napr_id = [Educ].Napr_Id)'
      'left outer join [KUz] on [KUz].UZ_ID=[Educ].UZ_ID)'
      
        'left outer join [Educ] As Educ2 on ([Person].PERS_ID=[Educ2].PER' +
        'S_ID and [Educ2].type=2))'
      
        'left outer join KKval as KKval2 on KKval2.kval_id = Educ2.Kval_I' +
        'd)'
      
        'left outer join KNapr as KNapr2 on KNapr2.Napr_id = Educ2.Napr_I' +
        'd)'
      'left outer join [KUz] As KUz2 on [KUz2].UZ_ID=[Educ2].UZ_ID)'
      
        'left outer join [Educ] As Educ3 on ([Person].PERS_ID=[Educ3].PER' +
        'S_ID and [Educ3].type=3))'
      
        'left outer join KKval as KKval3 on KKval3.kval_id = Educ3.Kval_I' +
        'd)'
      
        'left outer join KNapr as KNapr3 on KNapr3.Napr_id = Educ3.Napr_I' +
        'd)'
      'left outer join [KUz] As KUz3 on [KUz3].UZ_ID=[Educ3].UZ_ID)'
      
        'left outer join AppointmentLastAll on [Person].Pers_Id=Appointme' +
        'ntLastAll.Pers_Id)'
      
        'left outer join [KPost] on AppointmentLastAll.POST_ID=[KPost].PO' +
        'ST_ID)'
      
        'left outer join [KDepart] on AppointmentLastAll.DEP_ID=[KDepart]' +
        '.DEP_ID'
      ''
      'where [Person].PERS_ID=:PERS_ID')
    Left = 76
    Top = 16
  end
  object qrFamily: TADOQuery
    Connection = dbMain
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select *'
      
        'from [Family] left outer join [KFamType] on [Family].FT_ID=[KFam' +
        'Type].FT_ID'
      'where [Family].PERS_ID=:PERS_ID')
    Left = 124
    Top = 16
  end
  object qrOrg: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      'select *'
      ', IIF((ORGNAME is null), ORGSNAME, ORGNAME) AS _ORGNAME'
      ', IIF((ORGSNAME is null), ORGNAME, ORGSNAME) AS _ORGSNAME'
      'from [ORG]')
    Left = 92
    Top = 72
  end
  object qrOrgCont: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      'select * from [ORG_CONT]')
    Left = 140
    Top = 72
  end
  object qrReportType: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      'select null as REPORT_TYPE')
    Left = 212
    Top = 68
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1NotIsNullCalculate
        Name = 'NotIsNull'
        ArgMinCount = 1
        ArgMaxCount = 16
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1EqualCalculate
        Name = 'Equal'
        ArgMinCount = 2
        ArgMaxCount = 10
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1dateCalculate
        Name = 'date'
        ArgMinCount = 0
        ArgMaxCount = 0
        ResultType = 1
      end>
    Left = 71
    Top = 129
  end
  object qrPersonSQL: TADOQuery
    Connection = dbMain
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'select Person.*,KOVK.*,KWRange.*,KFState.*,Addr.*,A1.POST_CODE a' +
        's POST_CODE1,A1.ADDR_STR as ADDR_STR1'
      
        ',AppointmentLastAll.*,KPost.*, IIF([KDepart].DEP_FULL_NAME is nu' +
        'll, [KDEPART].DEP_NAME, [KDepart].DEP_FULL_NAME) as DEP_NAME,'
      
        'IIF(Person.IsAspirant is null, '#39#1088#1072#1073#1086#1090#1099#39', '#39#1091#1095#1077#1073#1099#39') as Mesto, IIF(' +
        'KOVK.ISOVK=1, '#39#1042#1086#1077#1085#1085#1086#1084#1091' '#1082#1086#1084#1080#1089#1089#1072#1088#1091#39', '#39#1056#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1102#39') as OVK,'
      
        'IIF(Person.IsAspirant is null, '#39#1076#1086#1083#1078#1085#1086#1089#1090#1100#39', '#39#1082#1091#1088#1089#39') as Dolg, Yea' +
        'r(BirthDay) as BirthYear,'
      ' KEduc.ED_NAME'
      ' +iif((Kuz.UZ_NAME is null),'#39#39','#39', '#39'+Kuz.UZ_NAME) '
      ' +iif((Educ.END_DATE is null),'#39#39','#39', '#39'+Educ.END_DATE) '
      ' +iif((Educ.KVAL is null),'#39#39','#39', '#39'+Educ.KVAL) '
      ' +iif((Educ.NAPR is null),'#39#39','#39', '#39'+Educ.NAPR) '
      ' +iif((Kuz2.UZ_NAME is null),'#39#39','#39', '#39'+Kuz2.UZ_NAME) '
      ' +iif((Educ2.END_DATE is null),'#39#39','#39', '#39'+Educ2.END_DATE) '
      ' +iif((Educ2.KVAL is null),'#39#39','#39', '#39'+Educ2.KVAL) '
      ' +iif((Educ2.NAPR is null),'#39#39','#39', '#39'+Educ2.NAPR) '
      ' +iif((Kuz3.UZ_NAME is null),'#39#39','#39', '#39'+Kuz3.UZ_NAME) '
      ' +iif((Educ3.END_DATE is null),'#39#39','#39', '#39'+Educ3.END_DATE) '
      ' +iif((Educ3.KVAL is null),'#39#39','#39', '#39'+Educ3.KVAL) '
      ' +iif((Educ3.NAPR is null),'#39#39','#39', '#39'+Educ3.NAPR) '
      ' +iif((Person.PROF1 is null),'#39#39','#39', '#39'+Person.PROF1) '
      'as Education,'
      
        '  KWRange.WRNG_NAME + iif((select Param_Value from Params Where ' +
        'Params.Param_Id = 8) = '#39'1'#39', iif(Person.WSOST_ID=9,'#39' '#1102#1089#1090#1080#1094#1080#1080#39',iif' +
        '(Person.WSOST_ID=10,'#39' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#39','#39#39')),'#39#39') as WRNG_Name1'
      'from (((((((((((((([Person]'
      'left outer join [KOVK] on [Person].OVK_ID=[KOVK].OVK_ID)'
      'left outer join [KWRange] on [Person].WRNG_ID=[KWRange].WRNG_ID)'
      'left outer join [KEduc] on [Person].ED_ID=[KEduc].ED_ID)'
      'left outer join [KFState] on [Person].FST_ID=[KFState].FST_ID)'
      
        'left outer join [Addr] on ([Person].PERS_ID=[Addr].PERS_ID and [' +
        'Addr].ADDR_TYPE=0))'
      
        'left outer join [Addr] A1 on ([Person].PERS_ID=A1.PERS_ID and A1' +
        '.ADDR_TYPE=1))'
      
        'left outer join [Educ] on ([Person].PERS_ID=[Educ].PERS_ID and [' +
        'Educ].type=1))'
      'left outer join [KUz] on [KUz].UZ_ID=[Educ].UZ_ID)'
      
        'left outer join [Educ] As Educ2 on ([Person].PERS_ID=[Educ2].PER' +
        'S_ID and [Educ2].type=2))'
      'left outer join [KUz] As KUz2 on [KUz2].UZ_ID=[Educ2].UZ_ID)'
      
        'left outer join [Educ] As Educ3 on ([Person].PERS_ID=[Educ3].PER' +
        'S_ID and [Educ3].type=3))'
      'left outer join [KUz] As KUz3 on [KUz3].UZ_ID=[Educ3].UZ_ID)'
      
        'left outer join AppointmentLastAll on [Person].Pers_Id=Appointme' +
        'ntLastAll.Pers_Id)'
      
        'left outer join [KPost] on AppointmentLastAll.POST_ID=[KPost].PO' +
        'ST_ID)'
      
        'left outer join [KDepart] on AppointmentLastAll.DEP_ID=[KDepart]' +
        '.DEP_ID'
      ''
      'where [Person].PERS_ID=:PERS_ID'
      '')
    Left = 36
    Top = 72
  end
end

object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 188
  Width = 400
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    UDFList = EkUDFList1
    Charset = DEFAULT_CHARSET
    Lang = 1049
    Options = [eoGraphicsBinary, eoClearMissedFields, eoDotAsColon]
    DisableControls = True
    Left = 32
    Top = 68
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
    Left = 32
    Top = 16
  end
  object qrPers: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT P.*'
      '     , AL.WTP_ID'
      '     , AL.WCH_ID'
      '     , KEDUC.ED_NAME'
      '     , n.NAPR_NAME'
      '     , n.NAPR_KOD'
      '  ,Year(StudyEnd_date) as StudyEnd_year'
      'FROM (((PERSON P '
      'LEFT OUTER JOIN KEDUC on KEDUC.ED_ID = P.ED_ID)'
      'LEFT OUTER JOIN Appointment as AL ON AL.ID = P.AppLast)'
      
        'LEFT OUTER JOIN EDUC e on (e.Pers_ID = P.Pers_ID and e.Type = 4)' +
        ')'
      'LEFT OUTER JOIN KNAPR n on n.NAPR_ID = e.NAPR_ID'
      'WHERE P.PERS_ID=:ID')
    Left = 80
    Top = 16
  end
  object dsPers: TDataSource
    DataSet = qrPers
    Left = 136
    Top = 16
  end
  object qrOrg: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'ORG_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT o.*, wr.WRNG_NAME AS VKChiefRangeName, '
      'oc1.fio as fio1, oc1.post as post1, oc1.phone as phone1,'
      'oc2.fio as fio2, oc2.post as post2, oc2.phone as phone2'
      'FROM ((ORG o'
      'left join KWRANGE wr on wr.WRNG_ID = o.VKChiefRange)'
      'left join Org_Cont oc1 on oc1.orgid = o.orgid)'
      'left join Org_Cont oc2 on oc2.orgid = o.orgid'
      'WHERE o.ORGID=:ORG_ID and oc1.contid = 1 and oc2.contid = 2')
    Left = 84
    Top = 68
  end
  object qrOVK: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'OVK_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *,'
      'IIF(ISOVK, '
      '  (select Param_Value from Params Where Params.Param_Id = 12), '
      '  (select Param_Value from Params Where Params.Param_Id = 13)'
      ') as OVK'
      'FROM KOVK'
      'WHERE OVK_ID=:OVK_ID')
    Left = 345
    Top = 69
  end
  object qrVUR: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'ORG_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM ORG_CONT'
      'WHERE ORGID=:ORG_ID AND IS_GEN<>0')
    Left = 140
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
        OnCalculate = EkUDFList1Functions2Calculate
        Name = 'fdt'
        ArgMinCount = 1
        ArgMaxCount = 2
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1Functions3Calculate
        Name = 'IOFam'
        ArgMinCount = 3
        ArgMaxCount = 3
        ResultType = 1
      end>
    Left = 28
    Top = 121
  end
  object qrStudyHistory: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT p.POST_NAME, '
      'd.DEP_NAME,'
      'd.DEP_FULL_NAME, '
      'IN_DATE, '
      'IN_ORD_NUMB,'
      'IN_ORD_DATE'
      'from ((Appointment sh'
      'left join KPOST p on p.POST_ID = sh.POST_ID)'
      'left join KDEPART d on d.DEP_ID = sh.DEP_ID)'
      'WHERE PERS_ID = :PERS_ID'
      'ORDER BY IN_DATE')
    Left = 207
    Top = 66
  end
  object qrN26History: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      'N26_ID,'
      'FORM_NUM, '
      'CREATE_DATE, '
      'GIVE_DATE'
      'from N26History n26'
      'WHERE PERS_ID = :PERS_ID'
      'ORDER BY CREATE_DATE DESC')
    Left = 286
    Top = 66
    object qrN26HistoryN26_ID: TIntegerField
      FieldName = 'N26_ID'
    end
    object qrN26HistoryCreate_Date: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1074#1099#1087#1080#1089#1082#1080
      FieldName = 'Create_Date'
    end
    object qrN26HistoryGive_Date: TDateField
      DisplayLabel = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080' '#1085#1072' '#1088#1091#1082#1080
      FieldName = 'Give_Date'
    end
    object qrN26HistoryForm_Num: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1092#1086#1088#1084#1099
      FieldName = 'Form_Num'
    end
  end
  object dsN26History: TDataSource
    DataSet = qrN26History
    Left = 287
    Top = 121
  end
  object qrN26: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsN26History
    Parameters = <
      item
        Name = 'N26_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      'FORM_NUM, '
      'CREATE_DATE, '
      'GIVE_DATE'
      'from N26History n26'
      'WHERE N26_ID = :N26_ID')
    Left = 208
    Top = 125
  end
  object qrDegree: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'ORG_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KScience')
    Left = 140
    Top = 124
  end
end

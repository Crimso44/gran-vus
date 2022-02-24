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
      '   , AL.WTP_ID'
      '   , AL.WCH_ID'
      '   , s.SC_NAME'
      '   , d.DelayName,'
      
        '  KWR.WRNG_NAME + iif((select Param_Value from Params Where Para' +
        'ms.Param_Id = 8) = '#39'1'#39', iif(P.WSOST_ID=9,'#39' '#1102#1089#1090#1080#1094#1080#1080#39',iif(P.WSOST_' +
        'ID=10,'#39' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#39','#39#39')),'#39#39') as WRNG_Name1'
      'FROM (((PERSON P '
      'left outer join KWRANGE KWR  on (P.WRNG_ID=KWR.WRNG_ID))'
      'LEFT OUTER JOIN KScience s ON s.SC_ID = P.DEGREE_ID)'
      'LEFT OUTER JOIN KDELAY d ON d.ID = P.Delay_ID)'
      'LEFT OUTER JOIN AppointmentLast AL ON AL.PERS_ID = P.PERS_ID'
      'WHERE P.PERS_ID=:ID')
    Left = 81
    Top = 14
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
      'SELECT * FROM ORG'
      'WHERE ORGID=:ORG_ID')
    Left = 84
    Top = 68
  end
  object qrWkType: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'WTP_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KWKTYPE'
      'WHERE WTP_ID=:WTP_ID')
    Left = 80
    Top = 120
  end
  object qrWkChar: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'WCH_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KWKCHAR'
      'WHERE WCH_ID=:WCH_ID')
    Left = 128
    Top = 120
  end
  object qrNat: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'NAT_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KNATION'
      'WHERE NAT_ID=:NAT_ID')
    Left = 184
    Top = 120
  end
  object qrLangs: TADOQuery
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
      'SELECT *'
      'FROM LANGS L, KLANG KL, KLANGSK KSK'
      
        'WHERE L.PERS_ID=:PERS_ID AND L.LANG_ID=KL.LANG_ID AND L.LSK_ID=K' +
        'SK.LSK_ID')
    Left = 240
    Top = 120
  end
  object qrEduc: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'ED_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KEDUC'
      'WHERE ED_ID=:ED_ID')
    Left = 296
    Top = 120
  end
  object qrEdData: TADOQuery
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
      
        'SELECT E.EDQ_ID, E.PERS_ID, E.DIPLOM, E.END_DATE, E.TYPE, UZ.UZ_' +
        'NAME, KKval.Kval_Name as KVAL, KNapr.Napr_Name as NAPR, E.OKSO, ' +
        'E.DIPLOM_SER, E.END_DATE_GIVE,'
      
        ' KObrDoc.KObrDoc_Name As ObrDoc,  KFormPrep.KFormPrep_Name As Fo' +
        'rmPrep  '
      'FROM ((((EDUC E '
      'INNER JOIN KUZ UZ ON E.UZ_ID=UZ.UZ_ID)'
      'Left Join KObrDoc On KObrDoc.KObrDoc_Id = E.ObrDoc_Id)'
      'Left Join KFormPrep On KFormPrep.KFormPrep_Id = E.FormPrep_Id)'
      'Left Join KKval on KKval.Kval_Id = E.Kval_Id)'
      'Left Join KNapr on KNapr.Napr_Id = E.Napr_Id'
      'WHERE E.PERS_ID=:PERS_ID')
    Left = 348
    Top = 120
  end
  object qrFamState: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'FST_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KFSTATE'
      'WHERE FST_ID=:FST_ID')
    Left = 80
    Top = 172
  end
  object qrFamily: TADOQuery
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
      'SELECT *'
      'FROM FAMILY F, KFAMTYPE FT'
      'WHERE F.PERS_ID=:PERS_ID AND F.FT_ID=FT.FT_ID')
    Left = 140
    Top = 172
  end
  object qrAddr: TADOQuery
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
      'SELECT *'
      'FROM ADDR'
      'WHERE PERS_ID=:PERS_ID')
    Left = 192
    Top = 172
  end
  object qrPhones: TADOQuery
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
      'SELECT *'
      'FROM PHONES'
      'WHERE PERS_ID=:PERS_ID')
    Left = 240
    Top = 172
  end
  object qrWRng: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'WRNG_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KWRANGE'
      'WHERE WRNG_ID=:WRNG_ID')
    Left = 296
    Top = 172
  end
  object qrWSost: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'WSOST_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KWSOST'
      'WHERE WSOST_ID=:WSOST_ID')
    Left = 352
    Top = 172
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
      '  '#39#1042#1086#1077#1085#1085#1099#1081' '#1082#1086#1084#1080#1089#1089#1072#1088#1080#1072#1090#39', '
      '  '#39#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1094#1080#1103#39
      ') as OVK'
      'FROM KOVK'
      'WHERE OVK_ID=:OVK_ID')
    Left = 404
    Top = 172
  end
  object qrSc: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'SC_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KSCIENCE'
      'WHERE SC_ID=:SC_ID')
    Left = 400
    Top = 120
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
      'WHERE ORGID=:ORG_ID AND IS_VUS<>0')
    Left = 140
    Top = 68
  end
  object taAppointment: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 72
    Top = 280
  end
  object qrAppointment: TADOQuery
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
      '   WTP_NAME, WCH_NAME, POST_NAME'
      
        '   , IIF((DEP_FULL_NAME is null) OR DEP_FULL_NAME='#39#39', DEP_NAME, ' +
        'DEP_FULL_NAME) as DEP_NAME'
      '   , OKPDTR,'
      '    IIF((IN_ORD_NUMB is null),'#39'_____'#39',IN_ORD_NUMB)+'
      '    IIF((IN_ORD_DATE is null),'#39#39','#39' '#1086#1090' '#39'&IN_ORD_DATE)'
      '   AS IN_ORD,'
      '  IN_DATE,'
      '  CPROF2015_Id as CPROF_ID,'
      '  IN_ORD_NUMB,'
      '  IN_ORD_DATE '
      'FROM (((Appointment'
      '   LEFT JOIN KWKTYPE ON Appointment.WTP_ID=KWKTYPE.WTP_ID)'
      '   LEFT JOIN KWKCHAR ON Appointment.WCH_ID=KWKCHAR.WCH_ID)'
      '   LEFT JOIN KPOST   ON Appointment.POST_ID=KPOST.POST_ID)'
      '   LEFT JOIN KDEPART ON Appointment.DEP_ID=KDEPART.DEP_ID'
      'WHERE PERS_ID = :PERS_ID'
      'ORDER BY IN_DATE')
    Left = 72
    Top = 232
  end
  object qrAssign: TADOQuery
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
      'SELECT * FROM Assign'
      'WHERE PERS_ID = :PERS_ID'
      'ORDER BY Assign_Date')
    Left = 144
    Top = 232
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
  object dxFamily: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 336
    Top = 224
    object dxFamilytitle: TStringField
      FieldName = 'title'
      Size = 255
    end
    object dxFamilyFamType1: TStringField
      FieldName = 'FamType1'
      Size = 255
    end
    object dxFamilyFamName1: TStringField
      FieldName = 'FamName1'
      Size = 255
    end
    object dxFamilyFamYear1: TStringField
      FieldName = 'FamYear1'
      Size = 255
    end
  end
end

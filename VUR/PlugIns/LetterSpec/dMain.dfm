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
      '     , AF.IN_ORD_NUMB, AF.IN_ORD_DATE'
      
        '     , PH.PH_NUMBER AS WORK_PHONE, Year(P.Birthday) as YearBirth' +
        'day,'
      'A.ADDR_STR as ADDR_STR,'
      'iif(IsNull(A1.ADDR_STR),A.ADDR_STR,A1.ADDR_STR) as ADDR_STR1,'
      
        '  KWR.WRNG_NAME + iif((select Param_Value from Params Where Para' +
        'ms.Param_Id = 8) = '#39'1'#39', iif(P.WSOST_ID=9,'#39' '#1102#1089#1090#1080#1094#1080#1080#39',iif(P.WSOST_' +
        'ID=10,'#39' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#39','#39#39')),'#39#39') as WRNG_Name1'
      'FROM ((((PERSON P'
      
        'left outer join (select * from ADDR ax  where (Ax.ADDR_TYPE=0 or' +
        ' Ax.ADDR_TYPE is null)) as A on (P.PERS_ID=A.PERS_ID))'
      
        'left outer join (select * from ADDR A1x where A1x.ADDR_TYPE=1) a' +
        's A1 on (P.PERS_ID=A1.PERS_ID))'
      '     LEFT OUTER JOIN Appointment AF ON P.AppFirst=AF.Id)'
      'left outer join KWRANGE KWR  on (P.WRNG_ID=KWR.WRNG_ID))'
      
        '     LEFT OUTER JOIN PHONES PH ON (P.Pers_Id=PH.Pers_Id AND PH.P' +
        'H_TYPE = 1)'
      'WHERE P.PERS_ID=:ID')
    Left = 80
    Top = 20
  end
  object dsPers: TDataSource
    DataSet = qrPers
    Left = 136
    Top = 16
  end
  object qrWRng: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'WRNG_ID'
        DataType = ftInteger
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KWRANGE'
      'WHERE WRNG_ID=:WRNG_ID')
    Left = 80
    Top = 72
  end
  object qrOVK: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'OVK_ID'
        DataType = ftInteger
        Value = Null
      end>
    SQL.Strings = (
      'select *,'
      'IIF(ISOVK, '
      '  (select Param_Value from Params Where Params.Param_Id = 12), '
      '  (select Param_Value from Params Where Params.Param_Id = 13)'
      ') as OVK'
      'FROM KOVK'
      'WHERE OVK_ID=:OVK_ID')
    Left = 128
    Top = 72
  end
  object qrDep: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'DEP_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      
        'DEP_ID, IIF((DEP_FULL_NAME is null) OR DEP_FULL_NAME='#39#39', DEP_NAM' +
        'E, DEP_FULL_NAME) as DEP_NAME'
      'FROM KDEPART'
      'WHERE DEP_ID=:DEP_ID')
    Left = 172
    Top = 72
  end
  object qrOrg: TADOQuery
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
      
        'select o.OrgName, o.OrgSName, left(oc.im,1)+'#39'.'#39'+left(oc.otch,1)+' +
        #39'.'#39'+oc.fam as fio, oc.post, kovk.ovk_name,'
      
        'IIF(kovk.IsOVK, '#39#1074#1086#1077#1085#1085#1099#1081' '#1082#1086#1084#1080#1089#1089#1072#1088#1080#1072#1090#39', '#39#1074#1086#1077#1085#1085#1086'-'#1091#1095#1077#1090#1085#1099#1081' '#1089#1090#1086#1083' '#1072#1076#1084#1080 +
        #1085#1080#1089#1090#1088#1072#1094#1080#1080#39') as OVK '
      'from (Org o'
      
        'left outer join Org_Cont oc on (oc.OrgId = o.OrgId and oc.is_vus' +
        ' = 1))'
      'left outer join kovk on (kovk.ovk_id = o.ovk_id)')
    Left = 80
    Top = 132
  end
  object qrOrgCont: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      'select * from [ORG_CONT]')
    Left = 164
    Top = 152
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

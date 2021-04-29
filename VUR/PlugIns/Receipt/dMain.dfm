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
      
        'SELECT P.FAM, P.IM, P.OTCH, YEAR(P.BIRTHDAY) AS BIRTHDAY, WR.WRN' +
        'G_NAME, P.VUS,'
      
        'IIF(P.Document = 0, '#39#1042#1086#1077#1085#1085#1099#1081' '#1073#1080#1083#1077#1090#39', IIF(P.Document = 1, '#39#1042#1088#1077#1084#1077#1085 +
        #1085#1086#1077' '#1091#1076#1086#1089#1090#1086#1074#1077#1088#1077#1085#1080#1077#39', IIF(P.Document = 2, '#39#1055#1088#1080#1087#1080#1089#1085#1086#1077' '#1089#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1086 +
        #39','#39#1057#1087#1088#1072#1074#1082#1072' '#1074#1079#1072#1084#1077#1085' '#1074#1086#1077#1085#1085#1086#1075#1086' '#1073#1080#1083#1077#1090#1072#39'))) as Document, P.WBSer, P.WB' +
        'Num,'
      
        '  WR.WRNG_NAME + iif((select Param_Value from Params Where Param' +
        's.Param_Id = 8) = '#39'1'#39', iif(P.WSOST_ID=9,'#39' '#1102#1089#1090#1080#1094#1080#1080#39',iif(P.WSOST_I' +
        'D=10,'#39' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#39','#39#39')),'#39#39') as WRNG_Name1'
      'FROM ((PERSON P'
      '     LEFT OUTER JOIN KWRANGE WR ON WR.WRNG_ID = P.WRNG_ID)'
      '     LEFT OUTER JOIN AppointmentLast AL ON P.Pers_Id=AL.Pers_Id)'
      
        '     LEFT OUTER JOIN PHONES PH ON (P.Pers_Id=PH.Pers_Id AND PH.P' +
        'H_TYPE = 1)'
      'WHERE P.PERS_ID=:ID')
    Left = 80
    Top = 20
  end
  object qrVUR: TADOQuery
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
      
        'SELECT POST, Left(IM, 1) + '#39'. '#39' + Left(OTCH, 1) + '#39'. '#39' + FAM as ' +
        'FIO FROM ORG_CONT WHERE IS_VUS = 1')
    Left = 96
    Top = 68
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

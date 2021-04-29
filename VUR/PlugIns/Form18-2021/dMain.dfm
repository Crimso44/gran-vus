object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 480
  Width = 696
  object dbMain: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Password="";Persist Security Info=True;Data S' +
      'ource=GranVUS;Extended Properties="DSN=GranVUS;DBQ=D:\WORK\GRANV' +
      'US\DATA;DefaultDir=D:\WORK\GRANVUS\DATA;DriverId=533;FIL=dBase 5' +
      '.0;MaxBufferSize=2048;PageTimeout=300;";Initial Catalog=D:\WORK\' +
      'GRANVUS\DATA'
    LoginPrompt = False
    Provider = 'MSDASQL.1'
    Left = 24
    Top = 68
  end
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    UDFList = EkUDFList1
    Charset = DEFAULT_CHARSET
    Lang = 1049
    Options = [eoGraphicsBinary, eoClearMissedFields, eoDotAsColon]
    DisableControls = True
    Left = 24
    Top = 16
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
      'SELECT *'
      'FROM ORG'
      'WHERE ORGID=:ID')
    Left = 88
    Top = 68
  end
  object dsOrg: TDataSource
    DataSet = qrOrg
    Left = 144
    Top = 68
  end
  object qrCont: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsOrg
    Parameters = <
      item
        Name = 'ORGID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM ORG_CONT'
      'WHERE ORGID=:ORGID')
    Left = 96
    Top = 128
  end
  object qrKOPF: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsOrg
    Parameters = <
      item
        Name = 'KOPF_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KOPF'
      'WHERE KOPF_ID=:KOPF_ID')
    Left = 149
    Top = 128
  end
  object qrOKFS: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsOrg
    Parameters = <
      item
        Name = 'FS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM KFS'
      'WHERE FS_ID=:FS_ID')
    Left = 201
    Top = 128
  end
  object qrPer: TADOQuery
    Tag = -1
    Connection = dbMain
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      
        'select distinct okved as per_no, kokpdtr.kokpdtr_Code as razd_no' +
        ' from  TPDP'
      'inner join kokpdtr on kokpdtr.kokpdtr_id = tpdp.kokpdtr')
    Left = 132
    Top = 192
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

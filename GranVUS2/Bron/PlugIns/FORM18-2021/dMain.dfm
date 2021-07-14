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
    Parameters = <
      item
        Name = 'cur_date'
        DataType = ftDateTime
        Size = -1
        Value = Null
      end
      item
        Name = 'org_id'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select distinct per_no, razd_no'
      'from  PER'
      'where (end_date is null or end_date>:cur_date) and orgid=:org_id')
    Left = 132
    Top = 192
  end
  object qrF6: TADOQuery
    Tag = -1
    Connection = dbMain
    Parameters = <
      item
        Name = 'orgid'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'select f6.* from form6 f6'
      'join form6hdr h on h.f6_id = f6.f6_id'
      'where col_b is not null and orgid=:orgid'
      'order by col_b')
    Left = 236
    Top = 232
  end
end

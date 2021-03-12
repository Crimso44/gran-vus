object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 480
  Width = 696
  object qrOrgData: TADOQuery
    Connection = dbMain
    Parameters = <
      item
        Name = 'ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM ORG LEFT OUTER JOIN KOPF ON (ORG.KOPF_ID=KOPF.KOPF_ID)'
      'WHERE ORG.ORGID=:ID')
    Left = 40
    Top = 53
  end
  object qrOrgCont: TADOQuery
    Connection = dbMain
    Parameters = <
      item
        Name = 'ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM ORG_CONT'
      'WHERE ORGID=:ID AND IS_GEN=1')
    Left = 96
    Top = 53
  end
  object qrOrgPaym: TADOQuery
    Connection = dbMain
    Parameters = <
      item
        Name = 'ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM ORG_PAYM'
      'WHERE ORGID=:ID')
    Left = 148
    Top = 53
  end
  object dbMain: TADOConnection
    CommandTimeout = 600
    ConnectionTimeout = 120
    LoginPrompt = False
    Left = 20
    Top = 124
  end
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    Charset = DEFAULT_CHARSET
    Lang = 0
    Options = [eoGraphicsBinary, eoDotAsColon]
    DisableControls = True
    Left = 68
    Top = 124
  end
end

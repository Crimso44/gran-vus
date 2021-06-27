object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 480
  Width = 696
  object dbMain: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=sysadm;Persist Security Info=True;U' +
      'ser ID=sysadm;Initial Catalog=GranVUS2;Data Source=GRANSQL2\GDSQ' +
      'L3;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4' +
      '096;Workstation ID=SAFONENKOV;Use Encryption for Data=False;Tag ' +
      'with column collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
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
  object qrData: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrDataCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      '  O.OKPO, O.OKBV, '
      
        '  F.COL_1 AS NUM_WORK, F.COL_2 AS NUM_VOEN, F.COL_3 AS NUM_OFFIC' +
        ', '
      '  F.COL_11 AS NUM_PRIZ'
      'FROM v_ORG O '
      'LEFT JOIN FORM6HDR H '
      
        'JOIN FORM6 F on F.F6_ID = H.F6_ID and F.CPROF_ID = 1000 on O.ORG' +
        'ID = H.ORGID'
      'ORDER BY OKPO')
    Left = 88
    Top = 128
    object qrDataROW_NO: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ROW_NO'
      Calculated = True
    end
    object qrDataOKPO: TStringField
      FieldName = 'OKPO'
      Size = 8
    end
    object qrDataOKBV: TStringField
      FieldName = 'OKBV'
      Size = 12
    end
    object qrDataNUM_WORK: TIntegerField
      FieldName = 'NUM_WORK'
    end
    object qrDataNUM_VOEN: TIntegerField
      FieldName = 'NUM_VOEN'
    end
    object qrDataNUM_OFFIC: TIntegerField
      FieldName = 'NUM_OFFIC'
    end
    object qrDataNUM_PRIZ: TIntegerField
      FieldName = 'NUM_PRIZ'
    end
  end
end

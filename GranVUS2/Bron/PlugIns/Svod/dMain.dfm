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
  object qrData: TADOQuery
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
      'SELECT '
      #9'VUO = S.SUBJ_NAME, '
      #9'QTY = SUM(F.COL_1),'
      #9'ZAP = SUM(F.COL_2), '
      #9'ZAB = SUM(F.COL_6), '
      #9'PRZ = SUM(F.COL_11), '
      #9'MOB = SUM(IsNull(F.COL_10,NULLIF(F.COL_2-F.COL_6-F.COL_9,0)))'
      'FROM ('
      
        #9'SELECT MAIN = -1, SUBJ_ID, SUBJ_NAME FROM SUBJ WHERE SUBJ_ID IN' +
        ' (SELECT SUBJ_ID FROM CURR_SUBJ)'
      '    UNION'
      
        '    SELECT 0, SUBJ_ID, SUBJ_NAME FROM SUBJ WHERE NOT SUBJ_ID IN ' +
        '(SELECT SUBJ_ID FROM CURR_SUBJ)) S'
      
        'LEFT OUTER JOIN FORM6HDR H ON H.SUBJ_ID = S.SUBJ_ID AND H.F6_SHI' +
        'FR='#39'01'#39
      'LEFT OUTER JOIN FORM6    F ON F.F6_ID   = H.F6_ID AND F.COL_B=5'
      'GROUP BY S.MAIN, S.SUBJ_NAME'
      'ORDER BY S.MAIN')
    Left = 88
    Top = 68
    object qrDataVUO: TStringField
      FieldName = 'VUO'
      ReadOnly = True
      Size = 250
    end
    object qrDataQTY: TIntegerField
      FieldName = 'QTY'
      ReadOnly = True
    end
    object qrDataZAP: TIntegerField
      FieldName = 'ZAP'
      ReadOnly = True
    end
    object qrDataZAB: TIntegerField
      FieldName = 'ZAB'
      ReadOnly = True
    end
    object qrDataPRZ: TIntegerField
      FieldName = 'PRZ'
      ReadOnly = True
    end
    object qrDataMOB: TIntegerField
      FieldName = 'MOB'
      ReadOnly = True
    end
  end
end

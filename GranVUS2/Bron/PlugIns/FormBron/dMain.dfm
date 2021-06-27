object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 462
  Width = 671
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
  object qrDataBrief: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrDataBriefCalcFields
    Parameters = <
      item
        Name = 'FILTERED'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *,'
      '(select top 1 FIO + CHAR(13) + PHONE'
      '   from ORG_CONT'
      '  where ORGID = O.ORGID'
      '    and IS_GEN = 1) AS DIRECTOR'
      'FROM v_ORG O'
      'WHERE O.OUT_DATE IS NULL AND O.HAS_BRON = 1')
    Left = 88
    Top = 128
    object qrDataBriefROW_NO: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ROW_NO'
      Calculated = True
    end
    object qrDataBriefORGNAME: TStringField
      FieldName = 'ORGNAME'
      Size = 250
    end
    object qrDataBriefURADDR: TStringField
      FieldName = 'URADDR'
      Size = 250
    end
    object qrDataBriefDIRECTOR: TStringField
      FieldName = 'DIRECTOR'
      ReadOnly = True
      Size = 101
    end
    object qrDataBriefKFS: TStringField
      FieldName = 'KFS'
      ReadOnly = True
      Size = 105
    end
    object qrDataBriefMAINOKONH: TStringField
      FieldName = 'MAINOKONH'
      Size = 5
    end
  end
  object ImageList: TImageList
    Left = 80
    Top = 24
    Bitmap = {
      494C010107000900080010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000080800000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000808000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000808000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000808000FFFFFF0000FFFF000000000000808000008080000080
      80000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000FFFF00FFFFFF0000FFFF0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F007F7F7F007F7F
      7F007F7F7F00000000007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000000
      000000000000000000000000000000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F007F7F7F000000
      00000000000000000000000000007F7F7F007F7F7F007F7F7F00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000808000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F007F7F7F007F7F7F007F7F7F00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      8000FFFFFF0000FFFF00FFFFFF0000FFFF000000000000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F007F7F7F00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000080
      800000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F7F7F007F7F7F007F7F
      7F00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000080800000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F007F7F7F00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000808000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000808000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F007F7F7F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000080800000808000008080000080800000808000008080000080
      8000008080000080800000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00000000007B7B
      7B007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000008400000084000000840000008400000084000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C6000000000000000000000000000000000000000000000000007B7B
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B0000000000000000008400000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600000000000000000000000000000000007B7B7B000000
      00000000000000000000BDBDBD00BDBDBD00BDBDBD0000000000000000000000
      000000000000000000007B7B7B00000000008400000084000000840000008400
      000084000000840000008484840084000000FFFFFF0084000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C60000FFFF0000FFFF0000FFFF00C6C6C600C6C6
      C60000000000000000000000000000000000000000007B7B7B0000000000BDBD
      BD007B7B7B000000000000000000BDBDBD00BDBDBD00000000007B7B7B00BDBD
      BD0000000000000000007B7B7B00000000008400000084000000848484008484
      840084848400848484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF008400000084000000000000008484840084848400848484000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FFFF
      FF000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600848484008484840084848400C6C6C600C6C6
      C60000000000C6C6C600000000000000000000000000000000007B7B7B00BDBD
      BD007B7B7B00BDBDBD00BDBDBD007B7B7B0000000000BDBDBD007B7B7B007B7B
      7B007B7B7B007B7B7B007B7B7B00000000008400000084000000848484008484
      840084848400848484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000840000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600C6C6C600000000000000000000000000000000000000
      0000BDBDBD00BDBDBD0000000000FFFFFF00FFFFFF0000000000BDBDBD000000
      00000000000000000000000000007B7B7B008400000084000000848484008484
      840084848400848484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000840000000000000000000000FFFFFF00840000008400
      000000000000FF000000FF000000FF000000FF000000FF000000FF000000FFFF
      FF000000000000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C6000000
      0000C6C6C60000000000C6C6C600000000007B7B7B0000000000BDBDBD000000
      0000BDBDBD0000000000BDBDBD00BDBDBD00BDBDBD00FFFFFF007B7B7B000000
      0000BDBDBD00BDBDBD00000000007B7B7B008400000084000000848484008484
      840084848400848484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000840000000000000000000000FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C60000000000C6C6C60000000000000000007B7B7B0000000000BDBDBD00BDBD
      BD00FFFFFF00000000007B7B7B0000000000BDBDBD00FFFFFF007B7B7B00BDBD
      BD00BDBDBD00BDBDBD00000000007B7B7B008400000084000000848484008484
      840084848400848484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000840000000000000000000000FFFFFF00840000008400
      00008400000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000C6C6C60000000000C6C6C600000000007B7B7B0000000000000000000000
      0000FFFFFF00000000007B7B7B007B7B7B00BDBDBD0000000000BDBDBD000000
      0000000000000000000000000000000000008400000084000000848484008484
      840084848400848484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000840000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000000000000000000000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDBDBD00FFFFFF00000000000000000000000000BDBDBD00BDBDBD000000
      0000000000007B7B7B0000000000000000008400000084000000848484008484
      840084848400848484008484840084000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000840000000000000000000000FFFFFF00840000008400
      000084000000840000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000084848400000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000000000007B7B7B00BDBD
      BD007B7B7B00BDBDBD00FFFFFF00FFFFFF00BDBDBD00BDBDBD007B7B7B007B7B
      7B007B7B7B00000000007B7B7B00000000008400000084000000848484008484
      84008484840084848400840000000000000084000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0084000000840000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C6000000000000000000000000000000
      0000FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      000000000000FFFFFF000000000000000000000000000000000000000000FFFF
      FF0000000000000000000000000000000000000000007B7B7B0000000000BDBD
      BD007B7B7B000000000000000000BDBDBD000000000000000000BDBDBD00BDBD
      BD00000000007B7B7B0000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000084000000840000008400
      00008400000084000000000000000000000000000000FFFFFF00840000008400
      00008400000084000000FFFFFF00C6C6C600FFFFFF0084000000840000008400
      0000840000008400000084848400000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000000000000000000000000000000000007B7B7B000000
      00007B7B7B0000000000BDBDBD00BDBDBD00BDBDBD00000000007B7B7B000000
      00007B7B7B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007B7B
      7B0000000000000000000000000000000000000000007B7B7B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B007B7B7B007B7B7B0000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FBFFFFFFFFFF0000F9FFFFFFFCFF0000
      FCFFF9FFF87F0000FC7FF0FFF07F0000F03FF0FFF03F0000F01FE07FE03F0000
      F80FC07FC01F0000F83F843F841F0000C01F1E3F1E0F0000C00FFE1FFE0F0000
      E00FFF1FFF070000E03FFF8FFF830000F01FFFC7FFC10000F00FFFE3FFE00000
      F807FFF8FFF80000F803FFFFFFFF0000FFFFFFFEFFFFFC7FFFFFFF0CC007FC27
      F83FFC008003EC230001F8050001C4010001F80500018001000100060001C001
      000100060000E0000001000600000000000100068000000000010005C0000003
      00010005E001E00300010001E007C00101010001F007800383830001F003C407
      FFFF0001F803EC3FFFFF0001FFFFFC7F00000000000000000000000000000000
      000000000000}
  end
  object qrDataFull: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrDataFullCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT O.ORGID, O.MAINOKONH, O.KFS_KOD, O.KODREG,'
      'O.RAB_COUNT, O.ZAP_COUNT, O.ZAB_COUNT,'
      'O.ORGNAME + '
      'ISNULL('#39' / '#39' + O.URADDR, '#39#39') + '
      'ISNULL('#39' / '#39' + O.FIZADDR, '#39#39') + '
      'ISNULL('#39' / '#39' + O.REGNUM, '#39#39') +'
      'ISNULL('#39' '#1086#1090' '#39' + CONVERT(varchar(20), O.REGDATE, 4), '#39#39') + '
      'ISNULL('#39' / '#39' + O.REG_PLACE, '#39#39') + '
      
        'REPLACE('#39' / '#39' + ISNULL(O.PHONE, '#39#39') + ISNULL('#39', '#39' + OC1.PHONE, '#39 +
        #39') + ISNULL('#39', '#39' + OC2.PHONE, '#39#39'),'#39' / , '#39','#39' / '#39')  AS ORGDATA,'
      ''
      'CASE WHEN O.SBM_KOD = '#39'01'#39' THEN 1 ELSE NULL END AS SUB_FOGV,'
      'CASE WHEN O.SBM_KOD = '#39'02'#39' THEN 1 ELSE NULL END AS SUB_OIVS,'
      'CASE WHEN O.SBM_KOD = '#39'03'#39' THEN 1 ELSE NULL END AS SUB_OMSU,'
      'CASE WHEN O.SBM_KOD = '#39'04'#39' THEN 1 ELSE NULL END AS SUB_OTHER'
      'FROM v_ORG O'
      
        'LEFT OUTER JOIN ORG_CONT OC1 ON O.ORGID=OC1.ORGID AND OC1.IS_GEN' +
        '=1 AND ISNULL(O.PHONE,'#39#39')<>ISNULL(OC1.PHONE,'#39#39')'
      
        'LEFT OUTER JOIN ORG_CONT OC2 ON O.ORGID=OC2.ORGID AND OC2.IS_VUS' +
        '=1 AND ISNULL(OC1.PHONE,'#39#39')<>ISNULL(OC2.PHONE,'#39#39')'
      'WHERE OUT_DATE IS NULL AND HAS_BRON = 1')
    Left = 88
    Top = 176
    object qrDataFullORGID: TAutoIncField
      FieldName = 'ORGID'
      ReadOnly = True
    end
    object IntegerField1: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ROW_NO'
      Calculated = True
    end
    object qrDataFullORGDATA: TStringField
      FieldName = 'ORGDATA'
      ReadOnly = True
      Size = 911
    end
    object qrDataFullMAINOKONH: TStringField
      FieldName = 'MAINOKONH'
      Size = 5
    end
    object qrDataFullKFS_KOD: TStringField
      FieldName = 'KFS_KOD'
      Size = 2
    end
    object qrDataFullKODREG: TStringField
      FieldName = 'KODREG'
      Size = 11
    end
    object qrDataFullRAB_COUNT: TIntegerField
      FieldName = 'RAB_COUNT'
    end
    object qrDataFullZAP_COUNT: TIntegerField
      FieldName = 'ZAP_COUNT'
    end
    object qrDataFullZAB_COUNT: TIntegerField
      FieldName = 'ZAB_COUNT'
    end
    object qrDataFullSUB_FOGV: TIntegerField
      FieldName = 'SUB_FOGV'
      ReadOnly = True
    end
    object qrDataFullSUB_OIVS: TIntegerField
      FieldName = 'SUB_OIVS'
      ReadOnly = True
    end
    object qrDataFullSUB_OMSU: TIntegerField
      FieldName = 'SUB_OMSU'
      ReadOnly = True
    end
    object qrDataFullSUB_OTHER: TIntegerField
      FieldName = 'SUB_OTHER'
      ReadOnly = True
    end
    object qrDataFullBASE_FOGV: TStringField
      FieldKind = fkCalculated
      FieldName = 'BASE_FOGV'
      Size = 2000
      Calculated = True
    end
    object qrDataFullBASE_OIVS: TStringField
      FieldKind = fkCalculated
      FieldName = 'BASE_OIVS'
      Size = 2000
      Calculated = True
    end
    object qrDataFullBASE_OMSU: TStringField
      FieldKind = fkCalculated
      FieldName = 'BASE_OMSU'
      Size = 2000
      Calculated = True
    end
    object qrDataFullBASE_UVVMZ: TStringField
      FieldKind = fkCalculated
      FieldName = 'BASE_UVVMZ'
      Size = 2000
      Calculated = True
    end
    object qrDataFullBASE_NZVV: TStringField
      FieldKind = fkCalculated
      FieldName = 'BASE_NZVV'
      Size = 2000
      Calculated = True
    end
    object qrDataFullBASE_PDVV: TStringField
      FieldKind = fkCalculated
      FieldName = 'BASE_PDVV'
      Size = 2000
      Calculated = True
    end
    object qrDataFullTPDP_RAZD: TStringField
      FieldKind = fkCalculated
      FieldName = 'TPDP_RAZD'
      Size = 2000
      Calculated = True
    end
    object qrDataFullZAB_PERC: TStringField
      FieldKind = fkCalculated
      FieldName = 'ZAB_PERC'
      Calculated = True
    end
  end
  object qrPER: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT PER.*, VV4.NAME AS DOC_NAME'
      'FROM PER LEFT JOIN VV4 ON PER.DOC_ID = VV4.ID'
      'ORDER BY ORGID, START_DATE')
    Left = 88
    Top = 224
  end
  object qrOSN: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT OSN.*, VV4.KOD AS BASE_KOD, VV4.NAME AS DOC_NAME'
      'FROM OSN LEFT JOIN VV3 ON OSN.BASE_ID = VV3.ID'
      'LEFT JOIN VV4 ON OSN.DOC_ID = VV4.ID'
      'ORDER BY ORGID, DOC_DATE')
    Left = 88
    Top = 272
  end
end

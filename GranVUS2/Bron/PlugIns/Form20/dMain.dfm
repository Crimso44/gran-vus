object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 462
  Width = 671
  object dbMain: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;User ID=sysadm;Initial Catalog=GranVUS2XXX;Data Source=' +
      'GR-OSTROJINSKY\SQL2008;Use Procedure for Prepare=1;Auto Translat' +
      'e=True;Packet Size=4096;Workstation ID=SAFONENKOV;Use Encryption' +
      ' for Data=False;Tag with column collation when possible=False;'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
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
  object ImageList: TImageList
    Left = 80
    Top = 24
    Bitmap = {
      494C010107000900200010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    AfterScroll = qrDataFullAfterScroll
    OnCalcFields = qrDataFullCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT O.ORGID, O.Occupation+'#39' / '#39'+O.OKONH OKONH, '
      'O.ORGNAME + ISNULL('#39' / '#39' + O.ORGSNAME, '#39#39') ORGNAME,'
      'O.URADDR + '
      'ISNULL('#39' / '#39' + O.FIZADDR, '#39#39') + '
      'ISNULL('#39' / '#39' + O.POSTADDR, '#39#39') + '
      
        'REPLACE('#39' / '#39' + ISNULL(O.PHONE, '#39#39') + ISNULL('#39', '#39' + OC1.PHONE, '#39 +
        #39') + ISNULL('#39', '#39' + OC2.PHONE, '#39#39'),'#39' / , '#39','#39' / '#39')  AS ORGDATA,'
      '(select top 1 FIO + CHAR(13) + PHONE'
      '   from ORG_CONT'
      '  where ORGID = O.ORGID'
      '    and IS_GEN = 1) AS DIRECTOR,'
      ' '#39#8470' '#39'+OSN.DOC_NO+'#39' '#1086#1090' '#39'+convert(varchar,OSN.DOC_DATE,104) OSN,'
      'KTerr.Name as Terr_Name, KTerr.Terr_Id as KTerr_Id'
      'FROM v_ORG O'
      
        'Inner Join KTerr on KTerr.KodTerr = substring(O.KodReg,1,2)+'#39'000' +
        '000000'#39
      
        'LEFT OUTER JOIN ORG_CONT OC1 ON O.ORGID=OC1.ORGID AND OC1.IS_GEN' +
        '=1 AND ISNULL(O.PHONE,'#39#39')<>ISNULL(OC1.PHONE,'#39#39')'
      
        'LEFT OUTER JOIN ORG_CONT OC2 ON O.ORGID=OC2.ORGID AND OC2.IS_VUS' +
        '=1 AND ISNULL(OC1.PHONE,'#39#39')<>ISNULL(OC2.PHONE,'#39#39')'
      'Left Outer Join OSN on OSN.ORGID = O.ORGID and OSN.DOC_ID = 5'
      'WHERE  OUT_DATE IS NULL AND HAS_BRON = 1'
      '')
    Left = 88
    Top = 176
  end
  object qrOKATO: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    AfterScroll = qrOKATOAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select * from kterr')
    Left = 232
    Top = 128
  end
  object qrSubj: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    AfterScroll = qrOKATOAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select distinct '
      '  i.Position_Name, i.fio, s.subj_name'
      'from CURR_SUBJ C '
      'Join v_SUBJ S on S.SUBJ_ID = C.SUBJ_ID'
      'join SUBJ_INFO i on i.SUBJ_ID = s.subj_id and i.subj_info_id = 1')
    Left = 224
    Top = 248
  end
  object qrOSN: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'OrgId'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select convert(varchar,OSN.Doc_Date,104) Osn_Date, * '
      'from OSN join VV4 on OSN.DOC_ID = VV4.ID'
      'where OSN.OrgId = :OrgId')
    Left = 248
    Top = 192
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1Functions0Calculate
        Name = 'NotIsNull'
        ArgMinCount = 1
        ArgMaxCount = 1
        ResultType = 1
      end>
    Left = 320
    Top = 216
  end
  object qrPer: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'OrgId'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select Per_No, Okved_Name'
      'from Per'
      'where OrgId = :OrgId'
      'order by Per_No')
    Left = 440
    Top = 160
  end
end
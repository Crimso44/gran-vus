object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 696
  object dbMain: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source=C:\Prog' +
      'ram Files\GranVUS\Data\granvus.mdb;Mode=Share Deny None;Persist ' +
      'Security Info=True;Jet OLEDB:Database Password=45q81ste1109'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 24
    Top = 20
  end
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    UDFList = EkUDFList1
    Charset = DEFAULT_CHARSET
    Lang = 0
    Options = [eoGraphicsBinary, eoDotAsColon]
    OnScanRecord = EkRTF1ScanRecord
    DisableControls = True
    Left = 228
    Top = 108
  end
  object ImageList: TImageList
    Left = 80
    Top = 24
    Bitmap = {
      494C010109000B00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
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
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
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
      000000000000000000000000000000000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000808000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007F7F7F007F7F7F00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000080800000FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000FF000000FF00
      0000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      000000808000000000000000000000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      000000808000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FF000000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      00000000000000808000FFFFFF0000FFFF000000000000808000008080000080
      80000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F007F7F7F007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF00FFFFFF000000
      000000000000000000000000000000000000000000000000000000000000FF00
      000000000000000000000000000000000000FF000000FF000000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000000000000000
      0000000000000080800000FFFF00FFFFFF0000FFFF0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F000000FF000000
      FF0000000000000000000000FF000000FF000000FF0000000000000000000000
      000000000000000000000000000000000000000000007F7F7F007F7F7F007F7F
      7F007F7F7F00000000007F7F7F007F7F7F007F7F7F007F7F7F00FFFFFF000000
      0000000000000000000000000000000000000000000000000000FF000000FF00
      00000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C00000000000000000000000000000000000008080000000
      000000000000000000000000000000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000007F7F7F000000FF00000000000000
      00000000000000000000000000000000FF000000FF0000000000000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F007F7F7F000000
      00000000000000000000000000007F7F7F007F7F7F007F7F7F00FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000808000FFFF
      FF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007F7F7F007F7F7F007F7F7F007F7F7F00FFFF
      FF000000000000000000000000000000000000000000FF000000FF000000FF00
      0000FF000000FF000000FF000000C0C0C00000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000080
      8000FFFFFF0000FFFF00FFFFFF0000FFFF000000000000808000008080000080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000007F7F7F007F7F7F007F7F7F00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000FF000000FF00
      0000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000080
      800000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007F7F7F007F7F7F007F7F
      7F00FFFFFF00FFFFFF0000000000000000000000000000000000C0C0C000FF00
      0000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000080800000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F000000
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007F7F7F007F7F
      7F007F7F7F00FFFFFF00FFFFFF00000000000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000808000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007F7F
      7F007F7F7F007F7F7F00FFFFFF00FFFFFF000000000000000000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
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
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFFF000000000000
      C007000000000000C007000000000000C007000000000000C007000000000000
      C007000000000000C007000000000000C007000000000000C007000000000000
      C007000000000000C007000000000000C00F000000000000C01F000000000000
      C03F000000000000FFFF000000000000FBFFFFFFFFFFFFFFF9FFFFFFFCFFFF3F
      FCFFF9FFF87FFE01FC7FF0FFF07FFC01F03FF0FFF03FFF01F01FE07FE03FFF01
      F80FC07FC01FEF01F83F843F841FCF01C01F1E3F1E0F8001C00FFE1FFE0F8001
      E00FFF1FFF078001E03FFF8FFF838001F01FFFC7FFC18001F00FFFE3FFE08001
      F807FFF8FFF88001F803FFFFFFFFFFFFFFFFFFFEFFFFFC7FFFFFFF0CC007FC27
      F83FFC008003EC230001F8050001C4010001F80500018001000100060001C001
      000100060000E0000001000600000000000100068000000000010005C0000003
      00010005E001E00300010001E007C00101010001F007800383830001F003C407
      FFFF0001F803EC3FFFFF0001FFFFFC7F00000000000000000000000000000000
      000000000000}
  end
  object ReportQuery: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'Dep_Id'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT p.fam+'#39' '#39'+p.im+'#39' '#39'+p.otch AS fio, p.WUchet2_Ser, p.WUchet' +
        '2'
      'FROM (((Person AS p '
      
        'INNER JOIN Appointment AS AppointmentLastAll ON p.AppLastAll=App' +
        'ointmentLastAll.Id) '
      'LEFT JOIN KWRange ON p.WRng_Id=[KWRange].WRng_Id) '
      
        'LEFT JOIN Appointment AS AppointmentFirst ON p.AppLast=Appointme' +
        'ntFirst.Id) '
      
        'LEFT JOIN Appointment AS AppointmentFirstStudy ON p.AppFirstStud' +
        'y=AppointmentFirstStudy.Id'
      'WHERE AppointmentLastAll.Dep_Id = :Dep_Id'
      'and p.WUchet2_IsWork = 1'
      
        'and (p.Out_Date is null or p.Out_Date > Date() or ((p.Dismissal_' +
        'Date is null or p.Dismissal_Date > Date() or AppointmentFirstStu' +
        'dy.In_Date is null) and AppointmentFirstStudy.In_Date is not nul' +
        'l))'
      
        'and (p.Out_Date is null or p.Out_Date > Date() or ((p.Dismissal_' +
        'Date is null or p.Dismissal_Date > Date() or AppointmentFirst.In' +
        '_Date is null) and AppointmentFirst.In_Date is not null))'
      'and (p.W_DEnd is null or p.W_DEnd > Date())'
      'and p.is_war = 1'
      'and  IIF(p.W_DEND is NULL and ('
      
        '         (p.MALE=1 and ([KWRANGE].M_LIMIT is not NULL) and  (#Fu' +
        'llAges#p.BIRTHDAY#)>[KWRANGE].M_LIMIT  ) or'
      
        '         (p.MALE=0 and ([KWRANGE].FEM_LIMIT is not NULL) and  (#' +
        'FullAges#p.BIRTHDAY#)>[KWRANGE].FEM_LIMIT  ))'
      '        ,1,0) = 0'
      '/*PERS_SET*/'
      'Order by 1')
    Left = 232
    Top = 152
  end
  object OrgQuery: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'ORG_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM ORG')
    Left = 100
    Top = 236
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1Functions0Calculate
        Name = 'RowNum'
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
    Left = 336
    Top = 224
  end
  object qrDep: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      
        'DEP_ID, IIF((DEP_FULL_NAME is null) OR DEP_FULL_NAME='#39#39', DEP_NAM' +
        'E, DEP_FULL_NAME) as DEP_NAME_X'
      'FROM KDEPART')
    Left = 148
    Top = 68
  end
  object qrExecutor: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ORG_Cont Where Is_Gen = 3')
    Left = 168
    Top = 32
    object qrExecutorCONTID: TIntegerField
      FieldName = 'CONTID'
    end
    object qrExecutorORGID: TIntegerField
      FieldName = 'ORGID'
    end
    object qrExecutorDEPART: TWideStringField
      FieldName = 'DEPART'
      Size = 50
    end
    object qrExecutorPOST: TWideStringField
      FieldName = 'POST'
      Size = 50
    end
    object qrExecutorFIO: TWideStringField
      FieldName = 'FIO'
      Size = 150
    end
    object qrExecutorPHONE: TWideStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object qrExecutorFAX: TWideStringField
      FieldName = 'FAX'
      Size = 50
    end
    object qrExecutorEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object qrExecutorIS_GEN: TSmallintField
      FieldName = 'IS_GEN'
    end
    object qrExecutorIS_VUS: TSmallintField
      FieldName = 'IS_VUS'
    end
    object qrExecutorFAM: TWideStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrExecutorIM: TWideStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrExecutorOTCH: TWideStringField
      FieldName = 'OTCH'
      Size = 50
    end
  end
end

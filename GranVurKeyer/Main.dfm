object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'KeyGen for Granit'
  ClientHeight = 268
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 76
    Height = 13
    Caption = #1050#1086#1076' '#1087#1088#1086#1076#1091#1082#1090#1072':'
  end
  object Label2: TLabel
    Left = 8
    Top = 38
    Width = 85
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1083#1080#1094#1077#1085#1079#1080#1080':'
  end
  object Label3: TLabel
    Left = 8
    Top = 65
    Width = 114
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1083#1080#1094#1077#1085#1079#1080#1081':'
  end
  object Label4: TLabel
    Left = 8
    Top = 92
    Width = 79
    Height = 13
    Caption = #1057#1088#1086#1082' '#1083#1080#1094#1077#1085#1079#1080#1080':'
  end
  object Label5: TLabel
    Left = 8
    Top = 119
    Width = 67
    Height = 13
    Caption = #1050#1086#1076' '#1079#1072#1087#1088#1086#1089#1072':'
  end
  object Button1: TButton
    Left = 182
    Top = 210
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    Visible = False
    OnClick = Button1Click
  end
  object eProductCode: TEdit
    Left = 136
    Top = 8
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 1
    Text = '0000-0737'
  end
  object eLicenceNumber: TEdit
    Left = 136
    Top = 35
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '1'
  end
  object eLicenseCount: TEdit
    Left = 136
    Top = 62
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '1'
  end
  object DateTimePicker1: TDateTimePicker
    Left = 136
    Top = 89
    Width = 121
    Height = 21
    Date = 80721.000000000000000000
    Time = 0.891304178250720700
    TabOrder = 4
  end
  object eHardwareCode: TEdit
    Left = 136
    Top = 116
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 5
  end
  object Button2: TButton
    Left = 8
    Top = 152
    Width = 249
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1082#1083#1102#1095
    TabOrder = 6
    OnClick = Button2Click
  end
  object eKey: TEdit
    Left = 8
    Top = 183
    Width = 249
    Height = 21
    ReadOnly = True
    TabOrder = 7
  end
  object bSaveFile: TButton
    Left = 8
    Top = 209
    Width = 114
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1092#1072#1081#1083
    Enabled = False
    TabOrder = 8
    OnClick = bSaveFileClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 240
    Width = 265
    Height = 28
    Align = alBottom
    BevelOuter = bvLowered
    TabOrder = 9
    ExplicitTop = 256
    object bPlay: TBitBtn
      Left = 2
      Top = 2
      Width = 25
      Height = 25
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000C21E0000C21E00000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
        8100828282008383830084848400858585008686860087878700888888008989
        89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
        9100929292009393930094949400959595009696960097979700989898009999
        99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
        A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
        A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
        B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
        C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
        D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
        D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
        E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
        E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
        F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF51E5FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000F97FEFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF0000003BD6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF00001A000680F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000F0670100
        29C4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFC328000269F0FFFFFFFF
        FFFFFFFFFFFFFFFFFFFF0000FFFFFFF97D06001BAEFFFFFFFFFFFFFFFFFFFFFF
        FFFF0000FFFFFFF97D06001BAEFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFC328
        000269F0FFFFFFFFFFFFFFFFFFFFFFFFFFFF0000F067010029C4FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF00001A000680F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF0000003BD6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000F97FEFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF51E5FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 0
      Visible = False
      OnClick = bPlayClick
    end
    object bPause: TBitBtn
      Left = 2
      Top = 2
      Width = 25
      Height = 25
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000C21E0000C21E00000001000000000000000000000101
        0100020202000303030004040400050505000606060007070700080808000909
        09000A0A0A000B0B0B000C0C0C000D0D0D000E0E0E000F0F0F00101010001111
        1100121212001313130014141400151515001616160017171700181818001919
        19001A1A1A001B1B1B001C1C1C001D1D1D001E1E1E001F1F1F00202020002121
        2100222222002323230024242400252525002626260027272700282828002929
        29002A2A2A002B2B2B002C2C2C002D2D2D002E2E2E002F2F2F00303030003131
        3100323232003333330034343400353535003636360037373700383838003939
        39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
        4100424242004343430044444400454545004646460047474700484848004949
        49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
        5100525252005353530054545400555555005656560057575700585858005959
        59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
        6100626262006363630064646400656565006666660067676700686868006969
        69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
        7100727272007373730074747400757575007676760077777700787878007979
        79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
        8100828282008383830084848400858585008686860087878700888888008989
        89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
        9100929292009393930094949400959595009696960097979700989898009999
        99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
        A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
        A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
        B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
        B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
        C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
        C900CACACA00CBCBCB00CCCCCC00CDCDCD00CECECE00CFCFCF00D0D0D000D1D1
        D100D2D2D200D3D3D300D4D4D400D5D5D500D6D6D600D7D7D700D8D8D800D9D9
        D900DADADA00DBDBDB00DCDCDC00DDDDDD00DEDEDE00DFDFDF00E0E0E000E1E1
        E100E2E2E200E3E3E300E4E4E400E5E5E500E6E6E600E7E7E700E8E8E800E9E9
        E900EAEAEA00EBEBEB00ECECEC00EDEDED00EEEEEE00EFEFEF00F0F0F000F1F1
        F100F2F2F200F3F3F300F4F4F400F5F5F500F6F6F600F7F7F700F8F8F800F9F9
        F900FAFAFA00FBFBFB00FCFCFC00FDFDFD00FEFEFE00FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF
        00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF
        FFFFFFFFFFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
        00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF
        00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF
        FFFFFFFFFFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
        00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF
        00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF
        FFFFFFFFFFFFFFFF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF
        00000000FFFFFFFF00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF
        00000000FFFFFFFFFFFFFFFFFFFFFFFF00000000FFFFFFFF00000000FFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      TabOrder = 1
      OnClick = bPauseClick
    end
    object pInfo: TPanel
      Left = 28
      Top = 1
      Width = 236
      Height = 26
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      ExplicitLeft = 33
      object lInfo: TLabel
        Left = 4
        Top = 6
        Width = 435
        Height = 13
        Caption = 
          'KeyGen for GranVUS and GranBron (c) 2021 by Crimso. Happy work f' +
          'or all!!!.....'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsItalic]
        ParentFont = False
      end
    end
  end
  object Timer1: TTimer
    Interval = 10
    OnTimer = Timer1Timer
    Left = 120
    Top = 136
  end
end

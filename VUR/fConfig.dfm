object fmConfig: TfmConfig
  Left = 319
  Top = 238
  HelpContext = 33
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 321
  ClientWidth = 433
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnShow = FormShow
  DesignSize = (
    433
    321)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 285
    Width = 425
    Height = 12
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsTopLine
    ExplicitTop = 212
    ExplicitWidth = 343
  end
  object PC: TPageControl
    Left = 0
    Top = 0
    Width = 433
    Height = 285
    ActivePage = TabSheet1
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1041#1077#1079#1086#1087#1072#1089#1085#1086#1089#1090#1100
      DesignSize = (
        425
        254)
      object lbTimeOut: TLabel
        Left = 52
        Top = 28
        Width = 249
        Height = 13
        Caption = #1074#1082#1083#1102#1095#1072#1090#1100' '#1095#1077#1088#1077#1079'                          '#1084#1080#1085'. '#1073#1077#1079#1076#1077#1081#1089#1090#1074#1080#1103
        Enabled = False
      end
      object Bevel3: TBevel
        Left = 12
        Top = 56
        Width = 402
        Height = 5
        Anchors = [akLeft, akTop, akRight]
        Shape = bsTopLine
        ExplicitWidth = 325
      end
      object chkTimeOut: TCheckBox
        Left = 20
        Top = 4
        Width = 297
        Height = 17
        Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1091#1102' '#1073#1083#1086#1082#1080#1088#1086#1074#1082#1091
        TabOrder = 0
        OnClick = chkTimeOutClick
      end
      object edTimeOut: TEdit
        Left = 144
        Top = 24
        Width = 45
        Height = 21
        MaxLength = 3
        TabOrder = 1
        Text = '0'
        OnKeyPress = edTimeOutKeyPress
      end
      object udTimeOut: TUpDown
        Left = 189
        Top = 24
        Width = 12
        Height = 21
        Associate = edTimeOut
        Enabled = False
        Max = 999
        TabOrder = 2
      end
      object chkExtMenu: TCheckBox
        Left = 20
        Top = 68
        Width = 297
        Height = 17
        Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1088#1072#1089#1096#1080#1088#1077#1085#1085#1099#1077' '#1087#1091#1085#1082#1090#1099' '#1084#1077#1085#1102
        TabOrder = 3
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1060#1072#1081#1083#1099' '#1080' '#1087#1072#1087#1082#1080
      ImageIndex = 1
      DesignSize = (
        425
        254)
      object Label1: TLabel
        Left = 12
        Top = 0
        Width = 139
        Height = 13
        Caption = #1055#1091#1090#1100' '#1082' '#1087#1072#1087#1082#1077' '#1089' '#1096#1072#1073#1083#1086#1085#1072#1084#1080':'
      end
      object sbTemp: TSpeedButton
        Left = 393
        Top = 20
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000000080000080
          000080000080000080000080000080000080000080000080000080000080BF00
          00BF000000008000008000008000008000008000008000008000008000008000
          0080000080000080000080BF0000C0C0C0BF0000BF0000000080000080000080
          000080000080000080000080000080000080000080000080BF0000C0C0C0BF00
          00BF0000BF000000008000008000008000008000008000008000008000008000
          0080000080BF0000C0C0C0BF0000BF0000BF0000000080000080000080000080
          000080000080000000000000000000000000BF0000C0C0C0BF0000BF0000BF00
          00000080000080000080000080000080000000000000C0C0C0C0C0C0C0C0C0FF
          FFFF808080BF0000BF0000BF0000000080000080000080000080000080000000
          808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF8080800000008080800000
          80000080000080000080000080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0FFFFFF000000000080000080000080000080000080000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000
          80000080000080000080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0000000000080000080000080000080000000C0C0C0
          FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000
          80000080000080000080000000C0C0C0FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0000000000080000080000080000080000080000000
          FFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000800000
          80000080000080000080000080000000808080FFFFFFFFFFFFFFFFFFC0C0C0C0
          C0C0C0C0C0808080000000000080000080000080000080000080000080000080
          000000000000C0C0C0C0C0C0C0C0C0C0C0C00000000000000000800000800000
          8000008000008000008000008000008000008000008000000000000000000000
          0000000080000080000080000080000080000080000080000080}
        OnClick = sbTempClick
        ExplicitLeft = 316
      end
      object sbRep: TSpeedButton
        Left = 393
        Top = 64
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000000080000080
          000080000080000080000080000080000080000080000080000080000080BF00
          00BF000000008000008000008000008000008000008000008000008000008000
          0080000080000080000080BF0000C0C0C0BF0000BF0000000080000080000080
          000080000080000080000080000080000080000080000080BF0000C0C0C0BF00
          00BF0000BF000000008000008000008000008000008000008000008000008000
          0080000080BF0000C0C0C0BF0000BF0000BF0000000080000080000080000080
          000080000080000000000000000000000000BF0000C0C0C0BF0000BF0000BF00
          00000080000080000080000080000080000000000000C0C0C0C0C0C0C0C0C0FF
          FFFF808080BF0000BF0000BF0000000080000080000080000080000080000000
          808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF8080800000008080800000
          80000080000080000080000080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0FFFFFF000000000080000080000080000080000080000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000
          80000080000080000080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0000000000080000080000080000080000000C0C0C0
          FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000
          80000080000080000080000000C0C0C0FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0000000000080000080000080000080000080000000
          FFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000800000
          80000080000080000080000080000000808080FFFFFFFFFFFFFFFFFFC0C0C0C0
          C0C0C0C0C0808080000000000080000080000080000080000080000080000080
          000000000000C0C0C0C0C0C0C0C0C0C0C0C00000000000000000800000800000
          8000008000008000008000008000008000008000008000000000000000000000
          0000000080000080000080000080000080000080000080000080}
        OnClick = sbRepClick
        ExplicitLeft = 316
      end
      object Label2: TLabel
        Left = 12
        Top = 44
        Width = 128
        Height = 13
        Caption = #1055#1091#1090#1100' '#1082' '#1087#1072#1087#1082#1077' '#1089' '#1086#1090#1095#1077#1090#1072#1084#1080':'
      end
      object Label6: TLabel
        Left = 12
        Top = 92
        Width = 187
        Height = 13
        Caption = #1055#1091#1090#1100' '#1082' '#1087#1072#1087#1082#1077' '#1089' '#1074#1085#1077#1096#1085#1080#1084#1080' '#1084#1086#1076#1091#1083#1103#1084#1080':'
      end
      object sbPlug: TSpeedButton
        Left = 393
        Top = 112
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000000080000080
          000080000080000080000080000080000080000080000080000080000080BF00
          00BF000000008000008000008000008000008000008000008000008000008000
          0080000080000080000080BF0000C0C0C0BF0000BF0000000080000080000080
          000080000080000080000080000080000080000080000080BF0000C0C0C0BF00
          00BF0000BF000000008000008000008000008000008000008000008000008000
          0080000080BF0000C0C0C0BF0000BF0000BF0000000080000080000080000080
          000080000080000000000000000000000000BF0000C0C0C0BF0000BF0000BF00
          00000080000080000080000080000080000000000000C0C0C0C0C0C0C0C0C0FF
          FFFF808080BF0000BF0000BF0000000080000080000080000080000080000000
          808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF8080800000008080800000
          80000080000080000080000080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0FFFFFF000000000080000080000080000080000080000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000
          80000080000080000080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0000000000080000080000080000080000000C0C0C0
          FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000
          80000080000080000080000000C0C0C0FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0000000000080000080000080000080000080000000
          FFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000800000
          80000080000080000080000080000000808080FFFFFFFFFFFFFFFFFFC0C0C0C0
          C0C0C0C0C0808080000000000080000080000080000080000080000080000080
          000000000000C0C0C0C0C0C0C0C0C0C0C0C00000000000000000800000800000
          8000008000008000008000008000008000008000008000000000000000000000
          0000000080000080000080000080000080000080000080000080}
        OnClick = sbPlugClick
        ExplicitLeft = 316
      end
      object Label5: TLabel
        Left = 12
        Top = 136
        Width = 218
        Height = 13
        Caption = #1055#1091#1090#1100' '#1082' '#1087#1072#1087#1082#1077' '#1089' '#1092#1072#1081#1083#1072#1084#1080' '#1088#1077#1079#1077#1088#1074#1085#1099#1093' '#1082#1086#1087#1080#1081':'
      end
      object sbBackUp: TSpeedButton
        Left = 393
        Top = 156
        Width = 23
        Height = 22
        Anchors = [akTop, akRight]
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000000080000080
          000080000080000080000080000080000080000080000080000080000080BF00
          00BF000000008000008000008000008000008000008000008000008000008000
          0080000080000080000080BF0000C0C0C0BF0000BF0000000080000080000080
          000080000080000080000080000080000080000080000080BF0000C0C0C0BF00
          00BF0000BF000000008000008000008000008000008000008000008000008000
          0080000080BF0000C0C0C0BF0000BF0000BF0000000080000080000080000080
          000080000080000000000000000000000000BF0000C0C0C0BF0000BF0000BF00
          00000080000080000080000080000080000000000000C0C0C0C0C0C0C0C0C0FF
          FFFF808080BF0000BF0000BF0000000080000080000080000080000080000000
          808080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0FFFFFF8080800000008080800000
          80000080000080000080000080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0FFFFFF000000000080000080000080000080000080000000C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000
          80000080000080000080000000C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0000000000080000080000080000080000000C0C0C0
          FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000
          80000080000080000080000000C0C0C0FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0000000000080000080000080000080000080000000
          FFFFFFFFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C00000000000800000
          80000080000080000080000080000000808080FFFFFFFFFFFFFFFFFFC0C0C0C0
          C0C0C0C0C0808080000000000080000080000080000080000080000080000080
          000000000000C0C0C0C0C0C0C0C0C0C0C0C00000000000000000800000800000
          8000008000008000008000008000008000008000008000000000000000000000
          0000000080000080000080000080000080000080000080000080}
        OnClick = sbBackUpClick
        ExplicitLeft = 316
      end
      object edTemp: TEdit
        Left = 28
        Top = 20
        Width = 362
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 250
        TabOrder = 0
      end
      object edRep: TEdit
        Left = 28
        Top = 64
        Width = 362
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 250
        TabOrder = 1
      end
      object edPlug: TEdit
        Left = 28
        Top = 112
        Width = 362
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 250
        TabOrder = 2
      end
      object edBackUp: TEdit
        Left = 28
        Top = 156
        Width = 362
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 250
        TabOrder = 3
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1054#1073#1085#1086#1074#1083#1077#1085#1080#1103
      ImageIndex = 3
      TabVisible = False
      object chkUpdate: TCheckBox
        Left = 20
        Top = 3
        Width = 297
        Height = 17
        Caption = #1055#1088#1086#1074#1077#1088#1103#1090#1100' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1087#1088#1080' '#1082#1072#1078#1076#1086#1084' '#1079#1072#1087#1091#1089#1082#1077
        TabOrder = 0
        OnClick = chkTimeOutClick
      end
      object btnSettings: TButton
        Left = 20
        Top = 26
        Width = 75
        Height = 25
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        TabOrder = 1
        OnClick = btnSettingsClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = #1042#1080#1076#1080#1084#1086#1089#1090#1100
      ImageIndex = 4
      object Label4: TLabel
        Left = 3
        Top = 5
        Width = 111
        Height = 13
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1082#1083#1072#1076#1082#1080':'
      end
      object Label9: TLabel
        Left = 222
        Top = 5
        Width = 97
        Height = 13
        Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1084#1077#1085#1102':'
      end
      object lbShowInCard: TCheckListBox
        Left = 3
        Top = 24
        Width = 200
        Height = 97
        ItemHeight = 13
        Items.Strings = (
          #1042#1086#1080#1085#1089#1082#1080#1081' '#1091#1095#1077#1090
          #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1091#1095#1072#1097#1077#1084#1089#1103
          #1040#1057#1060' ('#1053#1040#1057#1060')')
        TabOrder = 0
      end
      object lbShowMenu: TCheckListBox
        Left = 222
        Top = 24
        Width = 200
        Height = 97
        ItemHeight = 13
        Items.Strings = (
          #1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1042#1059#1056
          #1056#1072#1089#1095#1077#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1042#1059#1056
          #1060#1086#1088#1084#1099' '#1080' '#1086#1090#1095#1077#1090#1099' '#1042#1059#1056
          #1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1040#1057#1060
          #1060#1086#1088#1084#1099' '#1080' '#1086#1090#1095#1077#1090#1099' '#1040#1057#1060)
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1044#1088#1091#1075#1080#1077
      ImageIndex = 2
      DesignSize = (
        425
        254)
      object Label7: TLabel
        Left = 4
        Top = 4
        Width = 298
        Height = 13
        Caption = #1064#1072#1073#1083#1086#1085' '#1076#1083#1103' '#1085#1077#1073#1088#1086#1085#1080#1088#1091#1077#1084#1086#1081' '#1082#1086#1084#1072#1085#1076#1099' '#1074' '#1084#1086#1073'. '#1087#1088#1077#1076#1087#1080#1089#1072#1085#1080#1080':'
      end
      object Label8: TLabel
        Left = 8
        Top = 44
        Width = 402
        Height = 45
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 
          #1042#1053#1048#1052#1040#1053#1048#1045'! '#1042' '#1076#1072#1085#1085#1086#1084' '#1087#1072#1088#1072#1084#1077#1090#1088#1077' '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1090#1089#1103' '#1089#1080#1085#1090#1072#1082#1089#1080#1089' '#1103#1079#1099#1082#1072' SQL. '#1053 +
          #1077#1082#1086#1088#1088#1077#1082#1090#1085#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1072' '#1084#1086#1078#1077#1090' '#1087#1088#1080#1074#1077#1089#1090#1080' '#1082' '#1086#1096#1080#1073#1082#1072#1084' '#1074' '#1088#1072#1073#1086#1090#1077 +
          ' '#1082#1072#1088#1090#1086#1090#1077#1082#1080' '#1088#1072#1073#1086#1090#1085#1080#1082#1086#1074'.'
        WordWrap = True
      end
      object Label3: TLabel
        Left = 3
        Top = 91
        Width = 387
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = 
          #1060#1086#1088#1084#1091' '#1089#1074#1077#1088#1082#1080' '#1076#1072#1085#1085#1099#1093' '#1089' '#1074#1086#1077#1085#1082#1086#1084#1072#1090#1072#1084#1080' '#1080' '#1076#1086#1085#1077#1089#1077#1085#1080#1077' '#1060'-11 '#1052#1059' '#1087#1086#1076#1087#1080#1089#1099#1074#1072 +
          #1077#1090
        WordWrap = True
      end
      object edCommand300: TEdit
        Left = 4
        Top = 20
        Width = 410
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 50
        TabOrder = 0
      end
      object rbLeader: TRadioButton
        Left = 3
        Top = 108
        Width = 113
        Height = 17
        Caption = #1056#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1100
        TabOrder = 1
      end
      object rbVUR: TRadioButton
        Left = 173
        Top = 110
        Width = 113
        Height = 17
        Caption = #1042#1059#1056
        TabOrder = 2
      end
      object cbMedUst: TCheckBox
        Left = 3
        Top = 137
        Width = 411
        Height = 17
        Caption = 
          #1055#1086#1076#1089#1090#1072#1074#1083#1103#1090#1100' '#1082' '#1079#1074#1072#1085#1080#1102' '#1087#1088#1080#1089#1090#1072#1074#1082#1091' '#171#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1081' '#1089#1083#1091#1078#1073#1099#187' '#1080#1083#1080' '#171#1102#1089#1090#1080#1094#1080#1080 +
          #187
        TabOrder = 3
      end
      object cb6in18: TCheckBox
        Left = 3
        Top = 160
        Width = 411
        Height = 17
        Caption = #1055#1086#1084#1077#1097#1072#1090#1100' '#1095#1080#1089#1083#1086#1074#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1074' '#1087'.15 '#1092#1086#1088#1084#1099' '#8470' 18'
        TabOrder = 4
      end
      object cbAllGroups: TCheckBox
        Left = 3
        Top = 183
        Width = 411
        Height = 17
        Caption = #1044#1086#1089#1090#1091#1087#1085#1099' '#1074#1089#1077' '#1075#1088#1091#1087#1087#1099' '#1091#1095#1077#1090#1072
        TabOrder = 5
      end
      object cbFillT2: TCheckBox
        Left = 3
        Top = 206
        Width = 411
        Height = 17
        Caption = #1047#1072#1087#1086#1083#1085#1103#1090#1100' '#1087'.7 '#1088#1072#1079#1076#1077#1083#1072' II '#1092#1086#1088#1084#1099' '#1058'-2'
        TabOrder = 6
      end
      object cbFillT2_9: TCheckBox
        Left = 3
        Top = 229
        Width = 411
        Height = 17
        Caption = 
          #1047#1072#1087#1086#1083#1085#1103#1090#1100' '#1087'.9 '#1088#1072#1079#1076#1077#1083#1072' II ('#1089#1074#1077#1076#1077#1085#1080#1103' '#1086' '#1074#1086#1080#1085#1089#1082#1086#1084' '#1091#1095#1077#1090#1077') '#1092#1086#1088#1084#1099' '#1058'-2 (' +
          #1042#1059#1057')'
        TabOrder = 7
      end
    end
    object TabSheet6: TTabSheet
      Caption = #1044#1088#1091#1075#1080#1077' 2'
      ImageIndex = 5
      DesignSize = (
        425
        254)
      object Label10: TLabel
        Left = 4
        Top = 4
        Width = 178
        Height = 13
        Caption = #1054#1073#1088#1072#1097#1077#1085#1080#1077' '#1082' '#1074#1086#1077#1085#1085#1086#1084#1091' '#1082#1086#1084#1080#1089#1089#1072#1088#1091
      end
      object Label11: TLabel
        Left = 4
        Top = 52
        Width = 225
        Height = 13
        Caption = #1054#1073#1088#1072#1097#1077#1085#1080#1077' '#1082' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1102' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1094#1080#1080
      end
      object eOvkKomissar: TEdit
        Left = 4
        Top = 20
        Width = 410
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 50
        TabOrder = 0
      end
      object eOvkAdmin: TEdit
        Left = 4
        Top = 68
        Width = 410
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        MaxLength = 50
        TabOrder = 1
      end
      object cbAbcSort: TCheckBox
        Left = 4
        Top = 107
        Width = 398
        Height = 28
        Caption = 
          #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1074#1099#1087#1072#1076#1072#1102#1097#1080#1093' '#1089#1087#1080#1089#1082#1072#1093' '#1087#1086' '#1072#1083#1092#1072#1074#1080#1090#1091', '#1072' '#1085#1077' '#1087#1086' '#1088#1091#1095 +
          #1085#1086#1081' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1077
        TabOrder = 2
        WordWrap = True
      end
    end
  end
  object Button1: TButton
    Left = 274
    Top = 293
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 354
    Top = 293
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
    OnClick = Button2Click
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 332
    Top = 95
  end
end

object fmOrgPropCommon: TfmOrgPropCommon
  Left = 471
  Top = 277
  HelpContext = 508
  ActiveControl = mmName
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' - '#1086#1073#1097#1080#1077' '#1076#1072#1085#1085#1099#1077
  ClientHeight = 654
  ClientWidth = 511
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    511
    654)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 8
    Width = 79
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object Label2: TLabel
    Left = 12
    Top = 188
    Width = 32
    Height = 13
    Caption = #1054#1043#1056#1053':'
  end
  object Label3: TLabel
    Left = 12
    Top = 212
    Width = 96
    Height = 13
    Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080':'
  end
  object Label4: TLabel
    Left = 12
    Top = 236
    Width = 102
    Height = 13
    Caption = #1052#1077#1089#1090#1086' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080':'
  end
  object Label5: TLabel
    Left = 252
    Top = 188
    Width = 55
    Height = 13
    Caption = #1048#1053#1053'/'#1050#1055#1055':'
  end
  object Label6: TLabel
    Left = 252
    Top = 212
    Width = 34
    Height = 13
    Caption = #1054#1050#1055#1054':'
  end
  object Label7: TLabel
    Left = 348
    Top = 284
    Width = 40
    Height = 13
    Caption = #1054#1050#1040#1058#1054':'
  end
  object Label8: TLabel
    Left = 12
    Top = 260
    Width = 104
    Height = 13
    Caption = #1070#1088#1080#1076#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089':'
  end
  object Label9: TLabel
    Left = 12
    Top = 68
    Width = 109
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1086#1082#1088'.:'
  end
  object sbToUrAddr: TSpeedButton
    Left = 12
    Top = 280
    Width = 13
    Height = 22
    Glyph.Data = {
      7A000000424D7A000000000000003E000000280000000A0000000F0000000100
      0100000000003C0000000000000000000000020000000000000000000000FFFF
      FF00FFC00000FFC00000DFC00000CFC00000C7C00000C3C00000C1C00000C0C0
      0000C1C00000C3C00000C7C00000CFC00000DFC00000FFC00000FFC00000}
    OnClick = sbToUrAddrClick
  end
  object Label10: TLabel
    Left = 348
    Top = 332
    Width = 40
    Height = 13
    Caption = #1054#1050#1040#1058#1054':'
  end
  object Label11: TLabel
    Left = 12
    Top = 308
    Width = 105
    Height = 13
    Caption = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089':'
  end
  object sbToFactAddr: TSpeedButton
    Left = 12
    Top = 328
    Width = 13
    Height = 22
    Glyph.Data = {
      7A000000424D7A000000000000003E000000280000000A0000000F0000000100
      0100000000003C0000000000000000000000020000000000000000000000FFFF
      FF00FFC00000FFC00000DFC00000CFC00000C7C00000C3C00000C1C00000C0C0
      0000C1C00000C3C00000C7C00000CFC00000DFC00000FFC00000FFC00000}
    OnClick = sbToFactAddrClick
  end
  object Label12: TLabel
    Left = 348
    Top = 380
    Width = 40
    Height = 13
    Caption = #1054#1050#1040#1058#1054':'
  end
  object Label13: TLabel
    Left = 12
    Top = 356
    Width = 86
    Height = 13
    Caption = #1055#1086#1095#1090#1086#1074#1099#1081' '#1072#1076#1088#1077#1089':'
  end
  object sbToPostAddr: TSpeedButton
    Left = 12
    Top = 376
    Width = 13
    Height = 22
    Glyph.Data = {
      7A000000424D7A000000000000003E000000280000000A0000000F0000000100
      0100000000003C0000000000000000000000020000000000000000000000FFFF
      FF00FFC00000FFC00000DFC00000CFC00000C7C00000C3C00000C1C00000C0C0
      0000C1C00000C3C00000C7C00000CFC00000DFC00000FFC00000FFC00000}
    OnClick = sbToPostAddrClick
  end
  object Bevel1: TBevel
    Left = -2
    Top = 600
    Width = 503
    Height = 5
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label14: TLabel
    Left = 12
    Top = 92
    Width = 114
    Height = 13
    Caption = #1042#1099#1096#1077#1089#1090'. '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103':'
  end
  object Label15: TLabel
    Left = 12
    Top = 116
    Width = 48
    Height = 13
    Caption = #1058#1077#1083#1077#1092#1086#1085':'
  end
  object Label16: TLabel
    Left = 300
    Top = 116
    Width = 32
    Height = 13
    Caption = #1060#1072#1082#1089':'
  end
  object Label17: TLabel
    Left = 8
    Top = 505
    Width = 142
    Height = 13
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1074#1077#1076#1077#1085#1080#1103':'
  end
  object Label18: TLabel
    Left = 16
    Top = 407
    Width = 178
    Height = 13
    Caption = #1057#1088#1077#1076#1089#1090#1074#1072' '#1074#1099#1095#1080#1089#1083#1080#1090#1077#1083#1100#1085#1086#1081' '#1090#1077#1093#1085#1080#1082#1080
  end
  object Label19: TLabel
    Left = 16
    Top = 432
    Width = 210
    Height = 13
    Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1085#1086#1077' '#1086#1073#1077#1089#1087#1077#1095#1077#1085#1080#1077':'
  end
  object Label20: TLabel
    Left = 253
    Top = 432
    Width = 33
    Height = 13
    Caption = #1082#1086#1083'-'#1074#1086
  end
  object Label21: TLabel
    Left = 32
    Top = 444
    Width = 74
    Height = 13
    Caption = #1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label22: TLabel
    Left = 253
    Top = 407
    Width = 33
    Height = 13
    Caption = #1082#1086#1083'-'#1074#1086
  end
  object Label23: TLabel
    Left = 351
    Top = 407
    Width = 91
    Height = 13
    Caption = #1089#1077#1088#1090#1080#1092#1080#1094#1080#1088#1086#1074#1072#1085#1086
  end
  object Label24: TLabel
    Left = 351
    Top = 432
    Width = 91
    Height = 13
    Caption = #1089#1077#1088#1090#1080#1092#1080#1094#1080#1088#1086#1074#1072#1085#1086
  end
  object Label25: TLabel
    Left = 350
    Top = 486
    Width = 91
    Height = 13
    Caption = #1089#1077#1088#1090#1080#1092#1080#1094#1080#1088#1086#1074#1072#1085#1086
  end
  object Label26: TLabel
    Left = 252
    Top = 486
    Width = 33
    Height = 13
    Caption = #1082#1086#1083'-'#1074#1086
  end
  object Label27: TLabel
    Left = 15
    Top = 486
    Width = 93
    Height = 13
    Caption = #1057#1055#1054' "'#1050#1055#1048#1057' '#1052#1055#1069'"'
  end
  object Label28: TLabel
    Left = 12
    Top = 140
    Width = 31
    Height = 13
    Caption = 'E-mail:'
  end
  object Label29: TLabel
    Left = 12
    Top = 165
    Width = 48
    Height = 13
    Caption = #1042#1077#1073'-'#1089#1072#1081#1090':'
  end
  object mmName: TMemo
    Left = 12
    Top = 24
    Width = 487
    Height = 37
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 1024
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = mmNameChange
  end
  object edRegNum: TEdit
    Left = 136
    Top = 184
    Width = 97
    Height = 21
    MaxLength = 20
    TabOrder = 7
    OnChange = mmNameChange
  end
  object dtRegDate: TdxDateEdit
    Left = 136
    Top = 208
    Width = 101
    TabOrder = 8
    OnChange = mmNameChange
    Date = -700000.000000000000000000
  end
  object edINN: TEdit
    Left = 313
    Top = 184
    Width = 186
    Height = 21
    MaxLength = 50
    TabOrder = 9
    OnChange = mmNameChange
  end
  object edOKPO: TEdit
    Left = 313
    Top = 208
    Width = 186
    Height = 21
    MaxLength = 8
    TabOrder = 10
    OnChange = mmNameChange
    OnKeyPress = edOKPOKeyPress
  end
  object cbOKATO1: TdxPopupEdit
    Left = 396
    Top = 280
    Width = 101
    TabOrder = 13
    OnKeyPress = edOKPOKeyPress
    MaxLength = 11
    OnChange = mmNameChange
    PopupFormBorderStyle = pbsSimple
    PopupClientEdge = True
    StoredValues = 2
  end
  object edUrAddr: TEdit
    Left = 28
    Top = 280
    Width = 304
    Height = 21
    MaxLength = 250
    TabOrder = 12
    OnChange = mmNameChange
  end
  object edSName: TEdit
    Left = 136
    Top = 64
    Width = 363
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 50
    TabOrder = 1
    OnChange = mmNameChange
  end
  object cbOKATO2: TdxPopupEdit
    Left = 396
    Top = 328
    Width = 101
    TabOrder = 15
    OnKeyPress = edOKPOKeyPress
    MaxLength = 11
    OnChange = mmNameChange
    PopupFormBorderStyle = pbsSimple
    PopupClientEdge = True
    StoredValues = 2
  end
  object edFactAddr: TEdit
    Left = 28
    Top = 328
    Width = 304
    Height = 21
    MaxLength = 250
    TabOrder = 14
    OnChange = mmNameChange
  end
  object cbOKATO3: TdxPopupEdit
    Left = 396
    Top = 376
    Width = 101
    TabOrder = 17
    OnKeyPress = edOKPOKeyPress
    MaxLength = 11
    OnChange = mmNameChange
    PopupFormBorderStyle = pbsSimple
    PopupClientEdge = True
    StoredValues = 2
  end
  object edPostAddr: TEdit
    Left = 28
    Top = 376
    Width = 304
    Height = 21
    MaxLength = 250
    TabOrder = 16
    OnChange = mmNameChange
  end
  object Button1: TButton
    Left = 416
    Top = 611
    Width = 83
    Height = 25
    Anchors = [akTop, akRight]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 26
  end
  object edParent: TEdit
    Left = 136
    Top = 88
    Width = 363
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 100
    TabOrder = 2
    OnChange = mmNameChange
  end
  object edPhone: TEdit
    Left = 136
    Top = 112
    Width = 157
    Height = 21
    MaxLength = 50
    TabOrder = 3
    OnChange = mmNameChange
  end
  object edFax: TEdit
    Left = 344
    Top = 112
    Width = 155
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 50
    TabOrder = 4
    OnChange = mmNameChange
  end
  object mmComments: TMemo
    Left = 8
    Top = 524
    Width = 489
    Height = 71
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 500
    ScrollBars = ssVertical
    TabOrder = 25
    OnChange = mmNameChange
  end
  object eRegplace: TEdit
    Left = 136
    Top = 231
    Width = 363
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 100
    TabOrder = 11
    OnChange = mmNameChange
  end
  object eComputers: TSpinEdit
    Left = 292
    Top = 403
    Width = 53
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 18
    Value = 0
    OnChange = mmNameChange
  end
  object eSoftware: TEdit
    Left = 8
    Top = 459
    Width = 489
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 22
    OnChange = mmNameChange
  end
  object eSoftwareNum: TSpinEdit
    Left = 292
    Top = 431
    Width = 53
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 20
    Value = 0
    OnChange = mmNameChange
  end
  object eComputersS: TSpinEdit
    Left = 444
    Top = 403
    Width = 53
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 19
    Value = 0
    OnChange = mmNameChange
  end
  object eSoftwareNumS: TSpinEdit
    Left = 444
    Top = 431
    Width = 53
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 21
    Value = 0
    OnChange = mmNameChange
  end
  object eKpisS: TSpinEdit
    Left = 443
    Top = 485
    Width = 53
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 24
    Value = 0
    OnChange = mmNameChange
  end
  object eKpis: TSpinEdit
    Left = 291
    Top = 485
    Width = 53
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 23
    Value = 0
    OnChange = mmNameChange
  end
  object edEmail: TEdit
    Left = 136
    Top = 136
    Width = 363
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 100
    TabOrder = 5
    OnChange = mmNameChange
  end
  object edWww: TEdit
    Left = 136
    Top = 161
    Width = 363
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 100
    TabOrder = 6
    OnChange = mmNameChange
  end
end

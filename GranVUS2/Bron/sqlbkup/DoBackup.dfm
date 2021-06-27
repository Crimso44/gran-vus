object fDoBackup: TfDoBackup
  Left = 0
  Top = 0
  Caption = #1057#1086#1079#1076#1072#1085#1080#1077' '#1088#1077#1079#1077#1088#1074#1085#1086#1081' '#1082#1086#1087#1080#1080
  ClientHeight = 140
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    418
    140)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 77
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object Label4: TLabel
    Left = 8
    Top = 72
    Width = 66
    Height = 13
    Caption = #1056#1072#1079#1084#1077#1097#1077#1085#1080#1077':'
  end
  object bOpenFile: TSpeedButton
    Left = 387
    Top = 69
    Width = 23
    Height = 22
    Enabled = False
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      55555555FFFFFFFFFF55555000000000055555577777777775F55500B8B8B8B8
      B05555775F555555575F550F0B8B8B8B8B05557F75F555555575550BF0B8B8B8
      B8B0557F575FFFFFFFF7550FBF0000000000557F557777777777500BFBFBFBFB
      0555577F555555557F550B0FBFBFBFBF05557F7F555555FF75550F0BFBFBF000
      55557F75F555577755550BF0BFBF0B0555557F575FFF757F55550FB700007F05
      55557F557777557F55550BFBFBFBFB0555557F555555557F55550FBFBFBFBF05
      55557FFFFFFFFF7555550000000000555555777777777755555550FBFB055555
      5555575FFF755555555557000075555555555577775555555555}
    NumGlyphs = 2
    OnClick = bOpenFileClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 99
    Width = 418
    Height = 41
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 164
    DesignSize = (
      418
      41)
    object btnOk: TBitBtn
      Left = 254
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      DoubleBuffered = True
      Kind = bkOK
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancel: TBitBtn
      Left = 335
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      DoubleBuffered = True
      Kind = bkCancel
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
    end
  end
  object eName: TEdit
    Left = 104
    Top = 5
    Width = 306
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object cRewrite: TCheckBox
    Left = 24
    Top = 40
    Width = 386
    Height = 17
    Caption = #1055#1077#1088#1077#1079#1072#1087#1080#1089#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' ('#1087#1088#1077#1076#1099#1076#1091#1097#1080#1077' '#1082#1086#1087#1080#1080' '#1073#1091#1076#1091#1090' '#1091#1090#1077#1088#1103#1085#1099')'
    TabOrder = 1
  end
  object ePlace: TEdit
    Left = 104
    Top = 69
    Width = 284
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Enabled = False
    TabOrder = 2
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'bak'
    Filter = #1056#1077#1079#1077#1088#1074#1085#1099#1077' '#1082#1086#1087#1080#1080'|*.bak|'#1042#1089#1077' '#1092#1072#1081#1083#1099'|*.*'
    Title = #1057#1086#1079#1076#1072#1085#1080#1077' '#1088#1077#1079#1077#1088#1074#1085#1086#1081' '#1082#1086#1087#1080#1080
    Left = 376
    Top = 24
  end
end

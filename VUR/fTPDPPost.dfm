object fmTPDPPost: TfmTPDPPost
  Left = 337
  Top = 194
  HelpContext = 512
  BorderStyle = bsToolWindow
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1082#1086#1076#1072' '#1054#1050#1055#1044#1058#1056
  ClientHeight = 358
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    476
    358)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 14
    Width = 141
    Height = 13
    Caption = #1050#1086#1076' '#1076#1086#1083#1078#1085#1086#1089#1090#1080' '#1087#1086' '#1054#1050#1055#1044#1058#1056
  end
  object Label3: TLabel
    Left = 8
    Top = 38
    Width = 198
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1086#1083#1078#1085#1086#1089#1090#1080' '#1087#1086' '#1054#1050#1055#1044#1058#1056
  end
  object Label1: TLabel
    Left = 8
    Top = 87
    Width = 111
    Height = 13
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1080
  end
  object Label4: TLabel
    Left = 8
    Top = 142
    Width = 117
    Height = 13
    Caption = #1042#1099#1073#1088#1072#1085#1085#1099#1077' '#1076#1086#1083#1078#1085#1086#1089#1090#1080
  end
  object Label5: TLabel
    Left = 264
    Top = 143
    Width = 155
    Height = 13
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1080' '#1073#1077#1079' '#1082#1086#1076#1072' '#1054#1050#1055#1044#1058#1056
  end
  object bAddPost: TSpeedButton
    Left = 232
    Top = 200
    Width = 23
    Height = 22
    Hint = #1042#1099#1073#1088#1072#1090#1100' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
    Flat = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333FF3333333333333003333333333333F77F33333333333009033
      333333333F7737F333333333009990333333333F773337FFFFFF330099999000
      00003F773333377777770099999999999990773FF33333FFFFF7330099999000
      000033773FF33777777733330099903333333333773FF7F33333333333009033
      33333333337737F3333333333333003333333333333377333333333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = bAddPostClick
  end
  object bDelPost: TSpeedButton
    Left = 232
    Top = 256
    Width = 23
    Height = 22
    Hint = #1059#1073#1088#1072#1090#1100' '#1076#1086#1083#1078#1085#1086#1089#1090#1100' '#1080#1079' '#1074#1099#1073#1088#1072#1085#1085#1099#1093
    Flat = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333FF3333333333333003333
      3333333333773FF3333333333309003333333333337F773FF333333333099900
      33333FFFFF7F33773FF30000000999990033777777733333773F099999999999
      99007FFFFFFF33333F7700000009999900337777777F333F7733333333099900
      33333333337F3F77333333333309003333333333337F77333333333333003333
      3333333333773333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    ParentShowHint = False
    ShowHint = True
    OnClick = bDelPostClick
  end
  object lWarning: TLabel
    Left = 8
    Top = 120
    Width = 375
    Height = 13
    Caption = #1041#1091#1076#1077#1090' '#1089#1086#1079#1076#1072#1085#1072' '#1085#1086#1074#1072#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1100' '#1089' '#1091#1082#1072#1079#1072#1085#1085#1099#1084' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077#1084
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 158
    Top = 329
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = BitBtn1Click
    ExplicitTop = 153
  end
  object BitBtn2: TBitBtn
    Left = 242
    Top = 329
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = True
    ModalResult = 2
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 1
    ExplicitTop = 153
  end
  object edOKPDTR: TEdit
    Left = 167
    Top = 11
    Width = 73
    Height = 21
    Color = clBtnFace
    Enabled = False
    TabOrder = 2
  end
  object edOKPDTRName: TEdit
    Left = 8
    Top = 57
    Width = 460
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
  end
  object edCPROF: TComboBox
    Left = 167
    Top = 84
    Width = 301
    Height = 21
    Style = csDropDownList
    TabOrder = 4
    OnChange = edCPROFChange
  end
  object lbPosts: TListBox
    Left = 8
    Top = 161
    Width = 209
    Height = 160
    ItemHeight = 13
    Sorted = True
    TabOrder = 5
    OnDblClick = bDelPostClick
  end
  object lbAvailablePosts: TListBox
    Left = 264
    Top = 161
    Width = 204
    Height = 160
    Color = clBtnFace
    ItemHeight = 13
    Sorted = True
    TabOrder = 6
    OnDblClick = bAddPostClick
  end
  object ActionList: TActionList
    Left = 408
    Top = 12
    object actAdd: TAction
      Caption = '<- '#1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 16421
    end
    object actDel: TAction
      Caption = #1059#1073#1088#1072#1090#1100' ->'
      ShortCut = 16423
    end
    object actSelectAll: TAction
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
      ShortCut = 16449
    end
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 336
    Top = 8
  end
end

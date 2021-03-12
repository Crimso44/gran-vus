object fmTPDPCond: TfmTPDPCond
  Left = 291
  Top = 265
  HelpContext = 512
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1059#1089#1083#1086#1074#1080#1077' '#1087#1088#1077#1076#1086#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1086#1090#1089#1088#1086#1095#1082#1080
  ClientHeight = 247
  ClientWidth = 321
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object laWSost: TLabel
    Left = 4
    Top = 4
    Width = 170
    Height = 13
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1080#1103#1084' '#1074#1086#1080#1085#1089#1082#1086#1075#1086' '#1089#1086#1089#1090#1072#1074#1072':'
    FocusControl = clbWSost
  end
  object laAge: TLabel
    Left = 4
    Top = 138
    Width = 126
    Height = 13
    Caption = #1042' '#1074#1086#1079#1088#1072#1089#1090#1077' '#1089#1090#1072#1088#1096#1077' ('#1083#1077#1090'):'
  end
  object laWRange: TLabel
    Left = 4
    Top = 184
    Width = 57
    Height = 13
    Caption = #1044#1086' '#1079#1074#1072#1085#1080#1103':'
  end
  object Bevel1: TBevel
    Left = 4
    Top = 200
    Width = 313
    Height = 10
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 200
    Top = 138
    Width = 23
    Height = 13
    Caption = #1055#1086#1083':'
  end
  object clbWSost: TCheckListBox
    Left = 4
    Top = 20
    Width = 309
    Height = 85
    ItemHeight = 13
    Items.Strings = (
      #1057#1086#1083#1076#1072#1090#1099' '#1080' '#1084#1072#1090#1088#1086#1089#1099
      #1055#1088#1072#1087#1086#1088#1097#1080#1082#1080', '#1084#1080#1095#1084#1072#1085#1099', '#1089#1077#1088#1078#1072#1085#1090#1099' '#1080' '#1089#1090#1072#1088#1096#1080#1085#1099
      #1054#1092#1080#1094#1077#1088#1099' '#1089' '#1042#1059#1057' '#1082#1086#1084#1084#1072#1085#1076#1085#1086#1075#1086' '#1087#1088#1086#1092#1080#1083#1103
      #1054#1092#1080#1094#1077#1088#1099' '#1089' '#1042#1059#1057' '#1080#1085#1078#1077#1085#1077#1088#1085#1086#1075#1086' '#1080' '#1090#1077#1093#1085#1080#1095#1077#1089#1082#1086#1075#1086' '#1087#1088#1086#1092#1080#1083#1103
      
        #1054#1092#1080#1094#1077#1088#1099' '#1089' '#1042#1059#1057' '#1074#1086#1077#1085#1085#1086'-'#1075#1091#1084#1072#1085#1080#1090#1072#1088#1085#1086#1075#1086', '#1087#1077#1076#1072#1075#1086#1075#1080#1095#1077#1089#1082#1086#1075#1086' '#1080' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1086 +
        #1075#1086'  '#1087#1088#1086#1092#1080#1083#1103
      #1054#1092#1080#1094#1077#1088#1099' '#1089' '#1042#1059#1057' '#1084#1077#1076#1080#1094#1080#1085#1089#1082#1086#1075#1086' '#1080' '#1074#1077#1090#1077#1088#1080#1085#1072#1088#1085#1086#1075#1086' '#1087#1088#1086#1092#1080#1083#1103)
    TabOrder = 0
  end
  object cbLimited: TCheckBox
    Left = 4
    Top = 112
    Width = 313
    Height = 17
    Caption = #1054#1075#1088#1072#1085#1085#1080#1095#1077#1085#1085#1086' '#1075#1086#1076#1085#1099#1084' ('#1082#1072#1090#1077#1075#1086#1088#1080#1103' '#1075#1086#1076#1085#1086#1089#1090#1080' "'#1042'")'
    TabOrder = 1
  end
  object edAge: TMaskEdit
    Left = 132
    Top = 136
    Width = 23
    Height = 21
    EditMask = '99;0; '
    MaxLength = 2
    TabOrder = 2
    Text = '0'
    OnChange = edAgeChange
  end
  object cbAge: TCheckBox
    Left = 4
    Top = 156
    Width = 181
    Height = 17
    Caption = #1041#1077#1079' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080#1103' '#1087#1086' '#1074#1086#1079#1088#1072#1089#1090#1091
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = cbAgeClick
  end
  object edWRange: TdxPickEdit
    Left = 68
    Top = 180
    Width = 249
    TabOrder = 4
    DropDownListStyle = True
  end
  object pbOk: TBitBtn
    Left = 156
    Top = 216
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 5
    OnClick = pbOkClick
  end
  object BitBtn2: TBitBtn
    Left = 236
    Top = 216
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    DoubleBuffered = True
    ModalResult = 2
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 6
  end
  object edSex: TdxPickEdit
    Left = 236
    Top = 135
    Width = 81
    TabOrder = 7
    DropDownListStyle = True
    Items.Strings = (
      #1052' '#1080' '#1046
      #1052
      #1046)
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 188
    Top = 32
  end
end

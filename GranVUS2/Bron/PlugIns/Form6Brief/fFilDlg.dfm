object fmFilDlg: TfmFilDlg
  Left = 465
  Top = 252
  HelpContext = 25
  BorderStyle = bsDialog
  Caption = #1059#1089#1083#1086#1074#1080#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 261
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 6
    Top = 188
    Width = 78
    Height = 13
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1087#1086':'
  end
  object bPrint: TButton
    Left = 8
    Top = 232
    Width = 97
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object bCancel: TButton
    Left = 200
    Top = 232
    Width = 89
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 5
  end
  object cbSort: TComboBox
    Left = 88
    Top = 184
    Width = 201
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = #1050#1086#1076' '#1054#1050#1055#1054
    Items.Strings = (
      #1050#1086#1076' '#1054#1050#1055#1054
      #1053#1086#1084#1077#1088' '#1074' '#1042#1059#1054
      #1042#1089#1077#1075#1086' '#1088#1072#1073#1086#1090#1072#1077#1090
      #1042#1089#1077#1075#1086' '#1043#1055#1047
      #1042#1089#1077#1075#1086' '#1086#1092#1080#1094#1077#1088#1086#1074
      #1042#1089#1077#1075#1086' '#1043#1055#1055)
  end
  object rgFilter: TRadioGroup
    Left = 8
    Top = 92
    Width = 281
    Height = 81
    Caption = #1059#1089#1083#1086#1074#1080#1103
    ItemIndex = 1
    Items.Strings = (
      #1055#1086' '#1074#1089#1077#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084' '#1082#1072#1088#1090#1086#1090#1077#1082#1080
      #1055#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084', '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1084' '#1075#1083#1072#1074#1085#1086#1084#1091' '#1042#1059#1054
      #1055#1086' '#1079#1072#1076#1072#1085#1085#1086#1084#1091' '#1085#1072#1073#1086#1088#1091)
    TabOrder = 1
  end
  object chDesc: TCheckBox
    Left = 8
    Top = 208
    Width = 281
    Height = 17
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1086#1073#1088#1072#1090#1085#1086#1084' '#1087#1086#1088#1103#1076#1082#1077
    TabOrder = 3
  end
  object rgShifr: TRadioGroup
    Left = 8
    Top = 4
    Width = 281
    Height = 81
    Caption = #1064#1080#1092#1088' '#1092#1086#1088#1084#1099' '#8470'6'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      '01,02,03,04,05,06'
      '02,03'
      '03'
      '04,05,06'
      '05'
      '06')
    TabOrder = 0
  end
end

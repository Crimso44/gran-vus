object fmFilDlg: TfmFilDlg
  Left = 465
  Top = 252
  HelpContext = 23
  BorderStyle = bsDialog
  Caption = #1059#1089#1083#1086#1074#1080#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 121
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
  object bPrint: TButton
    Left = 8
    Top = 92
    Width = 97
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = bPrintClick
  end
  object bCancel: TButton
    Left = 200
    Top = 92
    Width = 89
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object rgFilter: TRadioGroup
    Left = 8
    Top = 4
    Width = 281
    Height = 81
    Caption = #1059#1089#1083#1086#1074#1080#1103
    ItemIndex = 1
    Items.Strings = (
      #1055#1086' '#1074#1089#1077#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084' '#1082#1072#1088#1090#1086#1090#1077#1082#1080
      #1055#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084', '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1084' '#1075#1083#1072#1074#1085#1086#1084#1091' '#1042#1059#1054
      #1055#1086' '#1079#1072#1076#1072#1085#1085#1086#1084#1091' '#1085#1072#1073#1086#1088#1091)
    TabOrder = 0
  end
end

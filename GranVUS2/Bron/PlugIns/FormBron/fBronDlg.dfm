object fmBronDlg: TfmBronDlg
  Left = 240
  Top = 206
  HelpContext = 28
  BorderStyle = bsDialog
  Caption = #1042#1077#1076#1091#1090' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 197
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 6
    Top = 8
    Width = 281
    Height = 65
    Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
    TabOrder = 0
    object rbFull: TRadioButton
      Left = 8
      Top = 16
      Width = 113
      Height = 17
      Caption = #1087#1086#1076#1088#1086#1073#1085#1099#1077
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbBrief: TRadioButton
      Left = 8
      Top = 36
      Width = 113
      Height = 17
      Caption = #1082#1088#1072#1090#1082#1080#1077
      TabOrder = 1
    end
  end
  object bPrint: TButton
    Left = 4
    Top = 168
    Width = 81
    Height = 25
    Caption = #1054#1090#1095#1077#1090
    Default = True
    TabOrder = 1
    OnClick = bPrintClick
  end
  object bCancel: TButton
    Left = 210
    Top = 168
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object rgFilter: TRadioGroup
    Left = 6
    Top = 80
    Width = 281
    Height = 81
    Caption = #1059#1089#1083#1086#1074#1080#1103
    ItemIndex = 1
    Items.Strings = (
      #1055#1086' '#1074#1089#1077#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084' '#1082#1072#1088#1090#1086#1090#1077#1082#1080
      #1055#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084', '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1084' '#1075#1083#1072#1074#1085#1086#1084#1091' '#1042#1059#1054
      #1055#1086' '#1079#1072#1076#1072#1085#1085#1086#1084#1091' '#1085#1072#1073#1086#1088#1091)
    TabOrder = 3
  end
end

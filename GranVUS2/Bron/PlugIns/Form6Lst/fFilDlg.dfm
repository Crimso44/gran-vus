object fmFilDlg: TfmFilDlg
  Left = 465
  Top = 252
  HelpContext = 16
  BorderStyle = bsDialog
  Caption = #1059#1089#1083#1086#1074#1080#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 136
  ClientWidth = 233
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
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 213
    Height = 85
    Caption = #1059#1089#1083#1086#1074#1080#1103
    TabOrder = 0
    object rbAll: TRadioButton
      Left = 8
      Top = 16
      Width = 145
      Height = 17
      Caption = #1055#1086' '#1074#1089#1077#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbFiltered: TRadioButton
      Left = 8
      Top = 56
      Width = 145
      Height = 17
      Caption = #1055#1086' '#1079#1072#1076#1072#1085#1085#1086#1084#1091' '#1085#1072#1073#1086#1088#1091
      TabOrder = 2
    end
    object rbSelf: TRadioButton
      Left = 8
      Top = 36
      Width = 181
      Height = 17
      Caption = #1055#1086' '#1087#1086#1076#1086#1090#1095#1077#1090#1085#1099#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
      TabOrder = 1
    end
  end
  object bPrint: TButton
    Left = 16
    Top = 104
    Width = 97
    Height = 25
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object bCancel: TButton
    Left = 128
    Top = 104
    Width = 89
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
end

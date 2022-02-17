object fmOtrDlg: TfmOtrDlg
  Left = 240
  Top = 206
  HelpContext = 18
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1059#1089#1083#1086#1074#1080#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 104
  ClientWidth = 201
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
  object bOK: TButton
    Left = 16
    Top = 76
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object bCancel: TButton
    Left = 110
    Top = 76
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object rbAll: TRadioButton
    Left = 8
    Top = 8
    Width = 145
    Height = 17
    Caption = #1055#1086' '#1074#1089#1077#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
    TabOrder = 2
  end
  object rbNative: TRadioButton
    Left = 8
    Top = 28
    Width = 181
    Height = 17
    Caption = #1055#1086' '#1087#1086#1076#1086#1090#1095#1077#1090#1085#1099#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
    Checked = True
    TabOrder = 3
    TabStop = True
  end
  object rbFiltered: TRadioButton
    Left = 8
    Top = 48
    Width = 145
    Height = 17
    Caption = #1055#1086' '#1079#1072#1076#1072#1085#1085#1086#1084#1091' '#1085#1072#1073#1086#1088#1091
    TabOrder = 4
  end
end

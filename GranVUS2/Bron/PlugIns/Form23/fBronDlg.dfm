object fmBronDlg: TfmBronDlg
  Left = 240
  Top = 206
  HelpContext = 28
  BorderStyle = bsDialog
  Caption = #1042#1077#1076#1091#1090' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 120
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
  DesignSize = (
    293
    120)
  PixelsPerInch = 96
  TextHeight = 13
  object bPrint: TButton
    Left = 4
    Top = 89
    Width = 81
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1095#1077#1090
    Default = True
    TabOrder = 0
    OnClick = bPrintClick
  end
  object bCancel: TButton
    Left = 210
    Top = 89
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object rgFilter: TRadioGroup
    Left = 4
    Top = 0
    Width = 281
    Height = 81
    Caption = #1059#1089#1083#1086#1074#1080#1103
    ItemIndex = 0
    Items.Strings = (
      #1055#1086' '#1074#1089#1077#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084' '#1082#1072#1088#1090#1086#1090#1077#1082#1080
      #1055#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084', '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1084' '#1075#1083#1072#1074#1085#1086#1084#1091' '#1042#1059#1054
      #1055#1086' '#1079#1072#1076#1072#1085#1085#1086#1084#1091' '#1085#1072#1073#1086#1088#1091)
    TabOrder = 2
  end
end

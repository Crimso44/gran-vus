object fmBronDlg: TfmBronDlg
  Left = 240
  Top = 206
  HelpContext = 28
  BorderStyle = bsDialog
  Caption = #1042#1077#1076#1091#1090' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 456
  ClientWidth = 293
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    293
    456)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 151
    Width = 95
    Height = 13
    Caption = #1060#1088#1072#1075#1084#1077#1085#1090' '#1072#1076#1088#1077#1089#1072':'
  end
  object bPrint: TButton
    Left = 4
    Top = 425
    Width = 81
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1095#1077#1090
    Default = True
    TabOrder = 0
    OnClick = bPrintClick
    ExplicitTop = 192
  end
  object bCancel: TButton
    Left = 210
    Top = 425
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 1
    ExplicitTop = 192
  end
  object rgFilter: TRadioGroup
    Left = 8
    Top = 8
    Width = 277
    Height = 73
    Caption = #1059#1089#1083#1086#1074#1080#1103
    ItemIndex = 1
    Items.Strings = (
      #1053#1072' '#1084#1085#1086#1078#1077#1089#1090#1074#1077' '#1074#1089#1077#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1074' '#1082#1072#1088#1090#1086#1090#1077#1082#1077
      #1053#1072' '#1084#1085#1086#1078#1077#1089#1090#1074#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081', '#1087#1086#1076#1086#1090#1095#1077#1090#1085#1099#1093' '#1075#1083#1072#1074#1085#1086#1084#1091' '#1042#1059#1054
      #1053#1072' '#1084#1085#1086#1078#1077#1089#1090#1074#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1080#1079' '#1079#1072#1076#1072#1085#1085#1086#1075#1086' '#1085#1072#1073#1086#1088#1072)
    TabOrder = 2
  end
  object edAddr: TEdit
    Left = 8
    Top = 170
    Width = 277
    Height = 21
    TabOrder = 4
  end
  object rgFilter2: TRadioGroup
    Left = 8
    Top = 87
    Width = 277
    Height = 58
    Caption = #1050#1086#1076' '#1054#1050#1040#1058#1054
    ItemIndex = 0
    Items.Strings = (
      #1048#1079' '#1102#1088#1080#1076#1080#1095#1077#1089#1082#1086#1075#1086' '#1072#1076#1088#1077#1089#1072
      #1048#1079' '#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1072#1076#1088#1077#1089#1072)
    TabOrder = 3
  end
  object rgFilter3: TRadioGroup
    Left = 8
    Top = 197
    Width = 277
    Height = 58
    Caption = #1056#1077#1075#1080#1086#1085#1099
    ItemIndex = 0
    Items.Strings = (
      #1055#1086' '#1074#1089#1077#1084' '#1088#1077#1075#1080#1086#1085#1072#1084
      #1055#1086' '#1074#1099#1073#1088#1072#1085#1085#1099#1084' '#1088#1077#1075#1080#1086#1085#1072#1084', '#1087#1086#1084#1077#1095#1077#1085#1085#1099#1084' '#1075#1072#1083#1086#1095#1082#1086#1081)
    TabOrder = 5
    OnClick = rgFilter3Click
  end
  object lRegions: TCheckListBox
    Left = 8
    Top = 261
    Width = 277
    Height = 156
    Enabled = False
    ItemHeight = 13
    TabOrder = 6
  end
end

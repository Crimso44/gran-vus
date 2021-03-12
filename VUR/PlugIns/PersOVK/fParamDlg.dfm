object fmParamDlg: TfmParamDlg
  Left = 285
  Top = 207
  HelpContext = 24
  Caption = #1060#1086#1088#1084#1072' '#1089#1074#1077#1088#1082#1080' '#1076#1072#1085#1085#1099#1093' '#1089' '#1074#1086#1077#1085#1082#1086#1084#1072#1090#1072#1084#1080
  ClientHeight = 282
  ClientWidth = 391
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    391
    282)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 375
    Height = 238
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1073#1086#1088#1072
    TabOrder = 0
    ExplicitHeight = 185
    DesignSize = (
      375
      238)
    object rbAll: TRadioButton
      Left = 24
      Top = 24
      Width = 150
      Height = 17
      Caption = #1087#1086' '#1074#1089#1077#1084' '#1054#1042#1050
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbAllClick
    end
    object rbSel: TRadioButton
      Left = 24
      Top = 48
      Width = 150
      Height = 17
      Caption = #1087#1086' '#1074#1099#1073#1088#1072#1085#1085#1099#1084' '#1054#1042#1050
      TabOrder = 1
      OnClick = rbAllClick
    end
    object cbxOVK: TCheckListBox
      Left = 20
      Top = 72
      Width = 335
      Height = 125
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clBtnFace
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      OnDblClick = cbxOVKDblClick
    end
    object chkPrintLetters: TCheckBox
      Left = 24
      Top = 215
      Width = 313
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1089#1086#1087#1088#1086#1074#1086#1076#1080#1090#1077#1083#1100#1085#1099#1077' '#1087#1080#1089#1100#1084#1072
      TabOrder = 3
    end
  end
  object Button1: TButton
    Left = 225
    Top = 252
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1077#1095#1072#1090#1100
    Default = True
    TabOrder = 1
    OnClick = Button1Click
    ExplicitTop = 199
  end
  object Button2: TButton
    Left = 309
    Top = 252
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
    ExplicitTop = 199
  end
end

object fmParamDlg: TfmParamDlg
  Left = 285
  Top = 207
  HelpContext = 24
  Caption = #1053#1072#1083#1080#1095#1080#1077' '#1089#1087#1072#1089#1072#1090#1077#1083#1100#1085#1086#1075#1086' '#1080#1084#1091#1097#1077#1089#1090#1074#1072' '#1080' '#1090#1077#1093#1085#1080#1082#1080' '#1074' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
  ClientHeight = 229
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
    229)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 375
    Height = 185
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1073#1086#1088#1072
    TabOrder = 0
    DesignSize = (
      375
      185)
    object rbAll: TRadioButton
      Left = 24
      Top = 24
      Width = 150
      Height = 17
      Caption = #1087#1086' '#1074#1089#1077#1084' '#1074#1080#1076#1072#1084' '#1052#1058#1056
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbAllClick
    end
    object rbSel: TRadioButton
      Left = 24
      Top = 48
      Width = 313
      Height = 17
      Caption = #1087#1086' '#1074#1099#1073#1088#1072#1085#1085#1099#1084' '#1074#1080#1076#1072#1084' '#1052#1058#1056
      TabOrder = 1
      OnClick = rbAllClick
    end
    object cbxMTR: TCheckListBox
      Left = 20
      Top = 72
      Width = 335
      Height = 97
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clBtnFace
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      OnDblClick = cbxMTRDblClick
    end
  end
  object Button1: TButton
    Left = 225
    Top = 199
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 309
    Top = 199
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
end

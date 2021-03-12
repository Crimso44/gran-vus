object fmParamDlg: TfmParamDlg
  Left = 285
  Top = 207
  BorderStyle = bsDialog
  Caption = #1044#1086#1085#1077#1089#1077#1085#1080#1077' '#1092'-11 '#1052#1059
  ClientHeight = 239
  ClientWidth = 380
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 365
    Height = 193
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1073#1086#1088#1072
    TabOrder = 0
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
      Width = 325
      Height = 105
      Color = clBtnFace
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      OnDblClick = cbxOVKDblClick
    end
  end
  object Button1: TButton
    Left = 204
    Top = 208
    Width = 75
    Height = 25
    Caption = #1055#1077#1095#1072#1090#1100
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 288
    Top = 208
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
end

object fmReportType: TfmReportType
  Left = 154
  Top = 161
  HelpContext = 25
  Action = aChange
  BorderStyle = bsDialog
  Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077' '#1074' '#1054#1042#1050
  ClientHeight = 119
  ClientWidth = 299
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
    299
    119)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 80
    Width = 289
    Height = 9
    Anchors = [akLeft, akBottom]
    Shape = bsTopLine
    ExplicitTop = 128
  end
  object Button1: TButton
    Left = 124
    Top = 88
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
    ExplicitTop = 318
  end
  object Button2: TButton
    Left = 208
    Top = 88
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 1
    ExplicitTop = 318
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 283
    Height = 66
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1080#1087' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
    TabOrder = 2
    ExplicitHeight = 89
    object RadioButton1: TRadioButton
      Left = 12
      Top = 16
      Width = 263
      Height = 17
      Caption = #1086' '#1087#1088#1080#1077#1084#1077' '#1085#1072' '#1088#1072#1073#1086#1090#1091'/'#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1080' '#1074' '#1042#1059#1047
      TabOrder = 0
    end
    object RadioButton6: TRadioButton
      Left = 12
      Top = 39
      Width = 263
      Height = 17
      Caption = #1086#1073' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1080'/'#1086#1090#1095#1080#1089#1083#1077#1085#1080#1080' '#1080#1079' '#1042#1059#1047#1072
      TabOrder = 1
    end
  end
  object ActionList1: TActionList
    Left = 240
    Top = 8
    object aChange: TAction
      Caption = 'aChange'
    end
  end
end

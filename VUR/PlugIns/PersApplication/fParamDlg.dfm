object fmParamDlg: TfmParamDlg
  Left = 285
  Top = 207
  HelpContext = 26
  Caption = #1047#1072#1103#1074#1083#1077#1085#1080#1077' '#1086' '#1087#1086#1089#1090#1072#1085#1086#1074#1082#1077' '#1085#1072' '#1074#1086#1080#1085#1089#1082#1080#1081' '#1091#1095#1077#1090
  ClientHeight = 88
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    384
    88)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 144
    Height = 13
    Caption = #1055#1088#1080#1095#1080#1085#1072' '#1087#1086#1089#1090#1072#1085#1086#1074#1082#1080' '#1085#1072' '#1091#1095#1077#1090
  end
  object Button1: TButton
    Left = 217
    Top = 58
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1077#1095#1072#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 0
    ExplicitTop = 199
  end
  object Button2: TButton
    Left = 301
    Top = 58
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
    ExplicitTop = 199
  end
  object eReason: TEdit
    Left = 8
    Top = 27
    Width = 368
    Height = 21
    TabOrder = 2
  end
end

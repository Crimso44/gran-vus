object fmParamDlg: TfmParamDlg
  Left = 285
  Top = 207
  HelpContext = 21
  BorderStyle = bsDialog
  Caption = #1057#1087#1088#1072#1074#1082#1072' '#1076#1083#1103' '#1086#1090#1089#1088#1086#1095#1082#1080' '#1087#1088#1080#1079#1099#1074#1072' '#1091#1095#1072#1097#1077#1075#1086#1089#1103
  ClientHeight = 105
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  DesignSize = (
    313
    105)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 152
    Top = 74
    Width = 75
    Height = 25
    Action = Action1
    Anchors = [akRight, akBottom]
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 236
    Top = 74
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 8
    Width = 249
    Height = 17
    Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1076#1086#1083#1078#1085#1086#1089#1090#1100' '#1080' '#1060#1048#1054' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object CheckBox2: TCheckBox
    Left = 8
    Top = 31
    Width = 249
    Height = 34
    Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1079#1074#1072#1085#1080#1077' '#1080' '#1060#1048#1054' '#1085#1072#1095#1072#1083#1100#1085#1080#1082#1072' '#1074#1086#1077#1085#1085#1086#1081' '#1082#1072#1092#1077#1076#1088#1099'/'#1091#1095#1077#1073#1085#1086#1075#1086' '#1094#1077#1085#1090#1088#1072
    Checked = True
    State = cbChecked
    TabOrder = 3
    WordWrap = True
  end
  object ActionList1: TActionList
    Left = 33
    Top = 161
    object Action1: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
    end
  end
end

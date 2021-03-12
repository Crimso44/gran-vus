object fmParamDlg: TfmParamDlg
  Left = 285
  Top = 207
  HelpContext = 21
  BorderStyle = bsDialog
  Caption = #1048#1079#1074#1077#1097#1077#1085#1080#1077' '#1086' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1080' '#1085#1072' '#1089#1087#1077#1094#1091#1095#1077#1090
  ClientHeight = 300
  ClientWidth = 396
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
    396
    300)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 11
    Width = 155
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1084#1077#1089#1103#1094#1077#1074' '#1086#1090#1089#1088#1086#1095#1082#1080
  end
  object lNumStr: TLabel
    Left = 200
    Top = 35
    Width = 70
    Height = 13
    Alignment = taRightJustify
    Caption = #1076#1074#1077#1085#1072#1076#1094#1072#1090#1100
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 21
    Top = 144
    Width = 345
    Height = 13
    Caption = #1059#1082#1072#1078#1080#1090#1077' '#1092#1072#1084#1080#1083#1080#1102', '#1080#1084#1103', '#1086#1090#1095#1077#1089#1090#1074#1086' '#1075#1088#1072#1078#1076#1072#1085#1080#1085#1072' '#1074' '#1076#1072#1090#1077#1083#1100#1085#1086#1084' '#1087#1072#1076#1077#1078#1077
  end
  object Label3: TLabel
    Left = 16
    Top = 208
    Width = 362
    Height = 13
    Caption = #1059#1082#1072#1078#1080#1090#1077' '#1076#1086#1083#1078#1085#1086#1089#1090#1100' ('#1087#1088#1086#1092#1077#1089#1089#1080#1102') '#1075#1088#1072#1078#1076#1072#1085#1080#1085#1072' '#1074' '#1088#1086#1076#1080#1090#1077#1083#1100#1085#1086#1084' '#1087#1072#1076#1077#1078#1077
  end
  object Button1: TButton
    Left = 235
    Top = 269
    Width = 75
    Height = 25
    Action = Action1
    Anchors = [akRight, akBottom]
    Default = True
    ModalResult = 1
    TabOrder = 0
    ExplicitLeft = 152
    ExplicitTop = 122
  end
  object Button2: TButton
    Left = 319
    Top = 269
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
    ExplicitLeft = 236
    ExplicitTop = 122
  end
  object cbPrintVK: TCheckBox
    Left = 21
    Top = 62
    Width = 249
    Height = 17
    Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1042#1050
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object cbPrintAddr: TCheckBox
    Left = 21
    Top = 85
    Width = 249
    Height = 34
    Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1076#1086#1084#1072#1096#1085#1080#1081' '#1072#1076#1088#1077#1089
    Checked = True
    State = cbChecked
    TabOrder = 3
    WordWrap = True
  end
  object edMonthCount: TcxSpinEdit
    Left = 221
    Top = 8
    Properties.OnChange = edMonthCountPropertiesChange
    TabOrder = 4
    Value = 12
    Width = 49
  end
  object Button3: TButton
    Left = 8
    Top = 267
    Width = 105
    Height = 25
    Caption = #1055#1077#1095#1072#1090#1100' '#1073#1083#1072#1085#1082#1072
    TabOrder = 5
    OnClick = Button3Click
  end
  object edFioDat: TEdit
    Left = 16
    Top = 168
    Width = 365
    Height = 21
    TabOrder = 6
    Text = 'edFioDat'
  end
  object edPostRod: TEdit
    Left = 16
    Top = 227
    Width = 362
    Height = 21
    TabOrder = 7
    Text = 'edPostRod'
  end
  object ActionList1: TActionList
    Left = 89
    Top = 153
    object Action1: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
    end
  end
end

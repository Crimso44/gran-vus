object fmReportType: TfmReportType
  Left = 154
  Top = 161
  HelpContext = 25
  Action = aChange
  BorderStyle = bsDialog
  Caption = #1051#1080#1089#1090#1086#1082'-'#1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1074' '#1054#1042#1050
  ClientHeight = 349
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
    349)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 310
    Width = 289
    Height = 9
    Anchors = [akLeft, akBottom]
    Shape = bsTopLine
    ExplicitTop = 128
  end
  object chkLabel: TCheckBox
    Left = 20
    Top = 286
    Width = 253
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1074#1072#1088#1080#1072#1085#1090' '#1089' '#1086#1090#1088#1099#1074#1085#1099#1084' '#1090#1072#1083#1086#1085#1086#1084
    TabOrder = 0
  end
  object Button1: TButton
    Left = 124
    Top = 318
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 208
    Top = 318
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 283
    Height = 272
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1080#1087' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
    TabOrder = 3
    object RadioButton1: TRadioButton
      Left = 12
      Top = 16
      Width = 263
      Height = 17
      Caption = #1086' '#1087#1088#1080#1077#1084#1077' '#1085#1072' '#1088#1072#1073#1086#1090#1091'/'#1087#1086#1089#1090#1091#1087#1083#1077#1085#1080#1080' '#1074' '#1042#1059#1047
      TabOrder = 0
    end
    object RadioButton2: TRadioButton
      Left = 12
      Top = 39
      Width = 179
      Height = 17
      Caption = #1086#1073' '#1080#1079#1084#1077#1085#1077#1085#1080#1103#1093
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object RadioButton3: TRadioButton
      Left = 12
      Top = 182
      Width = 253
      Height = 17
      Caption = #1086#1073' '#1091#1093#1086#1076#1077' '#1091#1095#1072#1097#1077#1075#1086#1089#1103' '#1074' '#1072#1082#1072#1076#1077#1084#1080#1095#1077#1089#1082#1080#1081' '#1086#1090#1087#1091#1089#1082
      TabOrder = 2
    end
    object RadioButton4: TRadioButton
      Left = 12
      Top = 205
      Width = 253
      Height = 17
      Caption = #1086#1073' '#1086#1082#1086#1085#1095#1072#1085#1080#1080' '#1072#1082#1072#1076#1077#1084#1080#1095#1077#1089#1082#1086#1075#1086' '#1086#1090#1087#1091#1089#1082#1072
      TabOrder = 3
    end
    object RadioButton5: TRadioButton
      Left = 12
      Top = 228
      Width = 221
      Height = 17
      Caption = #1086#1073' '#1086#1073#1091#1095#1077#1085#1080#1080' '#1085#1072' '#1074#1086#1077#1085#1085#1086#1081' '#1082#1072#1092#1077#1076#1088#1077
      TabOrder = 4
    end
    object RadioButton6: TRadioButton
      Left = 12
      Top = 247
      Width = 263
      Height = 17
      Caption = #1086#1073' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1080'/'#1086#1090#1095#1080#1089#1083#1077#1085#1080#1080' '#1080#1079' '#1042#1059#1047#1072
      TabOrder = 5
    end
    object cbSend_Date: TCheckBox
      Left = 26
      Top = 62
      Width = 254
      Height = 17
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1090#1091' '#1074#1088#1091#1095#1077#1085#1080#1103' '#1083#1080#1089#1090#1082#1072' '#1088#1072#1073#1086#1090#1085#1080#1082#1091
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object deSend_Date: TdxDateEdit
      Left = 40
      Top = 85
      Width = 121
      TabOrder = 7
      Date = 40017.000000000000000000
      DateButtons = [btnToday]
      DateOnError = deToday
      DateValidation = True
    end
    object cbReason: TCheckBox
      Left = 26
      Top = 112
      Width = 249
      Height = 37
      Caption = 
        #1047#1072#1092#1080#1082#1089#1080#1088#1086#1074#1072#1090#1100' '#1076#1088#1091#1075#1091#1102' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1102' ('#1087#1088#1080#1095#1080#1085#1072' '#1085#1077#1074#1088#1091#1095#1077#1085#1080#1103', '#1076#1072#1090#1072' '#1086#1090#1087#1088#1072#1074 +
        #1082#1080' '#1087#1086#1095#1090#1086#1081' '#1080' '#1076#1088'.)'
      TabOrder = 8
      WordWrap = True
      OnClick = cbReasonClick
    end
    object edReason: TEdit
      Left = 40
      Top = 155
      Width = 121
      Height = 21
      Enabled = False
      TabOrder = 9
    end
  end
  object ActionList1: TActionList
    Left = 240
    Top = 8
    object aChange: TAction
      Caption = 'aChange'
      OnUpdate = aChangeUpdate
    end
  end
end

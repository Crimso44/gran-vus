object fmParamDlg: TfmParamDlg
  Left = 285
  Top = 207
  HelpContext = 27
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1080#1079#1084#1077#1085#1077#1085#1080#1103#1093
  ClientHeight = 358
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    386
    358)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 371
    Height = 312
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1073#1086#1088#1072
    TabOrder = 0
    DesignSize = (
      371
      312)
    object Label1: TLabel
      Left = 24
      Top = 187
      Width = 52
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076
      ExplicitTop = 183
    end
    object Label2: TLabel
      Left = 24
      Top = 209
      Width = 6
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1089
      ExplicitTop = 205
    end
    object Label3: TLabel
      Left = 163
      Top = 209
      Width = 12
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = #1087#1086
      ExplicitTop = 205
    end
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
      Width = 331
      Height = 109
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clBtnFace
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      OnDblClick = cbxOVKDblClick
    end
    object Date_From: TdxDateEdit
      Left = 36
      Top = 206
      Width = 121
      TabOrder = 3
      Anchors = [akLeft, akBottom]
      Date = -700000.000000000000000000
      DateButtons = [btnToday]
      DateOnError = deToday
      DateValidation = True
      OnDateValidateInput = Date_FromDateValidateInput
    end
    object Date_To: TdxDateEdit
      Left = 181
      Top = 206
      Width = 121
      TabOrder = 4
      Anchors = [akLeft, akBottom]
      Date = -700000.000000000000000000
      DateButtons = [btnToday]
      DateOnError = deToday
      DateValidation = True
      OnDateValidateInput = Date_ToDateValidateInput
    end
    object cbAll: TCheckBox
      Left = 24
      Top = 233
      Width = 331
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = #1055#1077#1095#1072#1090#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1085#1077#1086#1090#1087#1088#1072#1074#1083#1077#1085#1085#1099#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object cbSend_Date: TCheckBox
      Left = 24
      Top = 256
      Width = 331
      Height = 17
      Anchors = [akLeft, akBottom]
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1076#1072#1090#1091' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1089#1074#1077#1076#1077#1085#1080#1081' '#1074' '#1054#1042#1050
      Checked = True
      State = cbChecked
      TabOrder = 6
      OnClick = cbSend_DateClick
    end
    object deSend_Date: TdxDateEdit
      Left = 24
      Top = 279
      Width = 121
      TabOrder = 7
      Anchors = [akLeft, akBottom]
      Date = 40017.000000000000000000
      DateButtons = [btnToday]
      DateOnError = deToday
      DateValidation = True
    end
  end
  object Button1: TButton
    Left = 210
    Top = 327
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1077#1095#1072#1090#1100
    Default = True
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 294
    Top = 327
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
end

object fmParamDlg: TfmParamDlg
  Left = 285
  Top = 207
  HelpContext = 23
  Caption = #1057#1087#1080#1089#1086#1082' '#1083#1080#1094', '#1080#1084#1077#1102#1097#1080#1093' '#1084#1086#1073'. '#1087#1088#1077#1076#1087#1080#1089#1072#1085#1080#1077
  ClientHeight = 289
  ClientWidth = 370
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
    370
    289)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 355
    Height = 245
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1073#1086#1088#1072
    TabOrder = 0
    ExplicitHeight = 185
    DesignSize = (
      355
      245)
    object rbAll: TRadioButton
      Left = 20
      Top = 71
      Width = 150
      Height = 17
      Caption = #1087#1086' '#1074#1089#1077#1084' '#1054#1042#1050
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbAllClick
    end
    object rbSel: TRadioButton
      Left = 20
      Top = 89
      Width = 150
      Height = 17
      Caption = #1087#1086' '#1074#1099#1073#1088#1072#1085#1085#1099#1084' '#1054#1042#1050
      TabOrder = 1
      OnClick = rbAllClick
    end
    object cbxOVK: TCheckListBox
      Left = 20
      Top = 112
      Width = 315
      Height = 117
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clBtnFace
      Enabled = False
      ItemHeight = 13
      TabOrder = 2
      OnDblClick = cbxOVKDblClick
    end
    object Panel1: TPanel
      Left = 20
      Top = 18
      Width = 315
      Height = 47
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 3
      object cbWSost0: TCheckBox
        Left = 8
        Top = 8
        Width = 97
        Height = 17
        Caption = #1086#1092#1080#1094#1077#1088#1099
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object cbWSost2: TCheckBox
        Left = 8
        Top = 24
        Width = 142
        Height = 17
        Caption = #1089#1077#1088#1078#1072#1085#1090#1099', '#1089#1090#1072#1088#1096#1080#1085#1099
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object cbWSost1: TCheckBox
        Left = 144
        Top = 8
        Width = 153
        Height = 17
        Caption = #1087#1088#1072#1087#1086#1088#1097#1080#1082#1080', '#1084#1080#1095#1084#1072#1085#1099
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object cbWSost3: TCheckBox
        Left = 144
        Top = 24
        Width = 97
        Height = 17
        Caption = #1088#1103#1076#1086#1074#1099#1077
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
    end
  end
  object Button1: TButton
    Left = 203
    Top = 259
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
    Left = 287
    Top = 259
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

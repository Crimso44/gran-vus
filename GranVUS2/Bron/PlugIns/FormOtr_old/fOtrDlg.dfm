object fmOtrDlg: TfmOtrDlg
  Left = 240
  Top = 206
  HelpContext = 519
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1059#1089#1083#1086#1074#1080#1103' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
  ClientHeight = 196
  ClientWidth = 218
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 201
    Height = 65
    Caption = #1042#1080#1076
    TabOrder = 0
    object rbFull: TRadioButton
      Left = 8
      Top = 16
      Width = 177
      Height = 17
      Caption = #1055#1086' '#1074#1089#1077#1084' '#1092#1086#1088#1084#1072#1084' '#8470' 6'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object rbChecked: TRadioButton
      Left = 8
      Top = 36
      Width = 177
      Height = 17
      Caption = #1055#1086' '#1074#1099#1074#1077#1088#1077#1085#1085#1099#1084' '#1092#1086#1088#1084#1072#1084' '#8470' 6'
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 76
    Width = 201
    Height = 81
    Caption = #1059#1089#1083#1086#1074#1080#1103
    TabOrder = 1
    object rbAll: TRadioButton
      Left = 8
      Top = 16
      Width = 145
      Height = 17
      Caption = #1055#1086' '#1074#1089#1077#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
      TabOrder = 0
    end
    object rbFiltered: TRadioButton
      Left = 8
      Top = 56
      Width = 145
      Height = 17
      Caption = #1055#1086' '#1079#1072#1076#1072#1085#1085#1086#1084#1091' '#1085#1072#1073#1086#1088#1091
      TabOrder = 2
    end
    object rbNative: TRadioButton
      Left = 8
      Top = 36
      Width = 181
      Height = 17
      Caption = #1055#1086' '#1087#1086#1076#1086#1090#1095#1077#1090#1085#1099#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084
      Checked = True
      TabOrder = 1
      TabStop = True
    end
  end
  object bOK: TButton
    Left = 24
    Top = 164
    Width = 81
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object bCancel: TButton
    Left = 118
    Top = 164
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
end

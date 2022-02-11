object fmUserCard: TfmUserCard
  Left = 416
  Top = 216
  HelpContext = 532
  BorderStyle = bsDialog
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
  ClientHeight = 292
  ClientWidth = 283
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object laFam: TLabel
    Left = 8
    Top = 10
    Width = 52
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
    FocusControl = edFAM
  end
  object laIM: TLabel
    Left = 8
    Top = 34
    Width = 25
    Height = 13
    Caption = #1048#1084#1103':'
    FocusControl = edIM
  end
  object laOTCH: TLabel
    Left = 8
    Top = 58
    Width = 47
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086
    FocusControl = edOTCH
  end
  object laLogin: TLabel
    Left = 8
    Top = 94
    Width = 82
    Height = 13
    Caption = #1057#1080#1089#1090#1077#1084#1085#1086#1077' '#1080#1084#1103':'
    FocusControl = edLOGIN
  end
  object laPSW1: TLabel
    Left = 8
    Top = 118
    Width = 41
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100':'
    FocusControl = edPSW1
  end
  object laPSW2: TLabel
    Left = 8
    Top = 142
    Width = 123
    Height = 13
    Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103':'
    FocusControl = edPSW2
  end
  object Bevel1: TBevel
    Left = 4
    Top = 246
    Width = 277
    Height = 9
    Shape = bsBottomLine
  end
  object laRights: TLabel
    Left = 8
    Top = 172
    Width = 35
    Height = 13
    Caption = #1055#1088#1072#1074#1072':'
  end
  object Bevel2: TBevel
    Left = 0
    Top = 75
    Width = 277
    Height = 9
    Shape = bsBottomLine
  end
  object Bevel3: TBevel
    Left = 4
    Top = 160
    Width = 273
    Height = 9
    Shape = bsBottomLine
  end
  object edFAM: TEdit
    Left = 148
    Top = 6
    Width = 121
    Height = 21
    MaxLength = 50
    TabOrder = 0
  end
  object edIM: TEdit
    Left = 148
    Top = 30
    Width = 121
    Height = 21
    MaxLength = 50
    TabOrder = 1
  end
  object edOTCH: TEdit
    Left = 148
    Top = 54
    Width = 121
    Height = 21
    MaxLength = 50
    TabOrder = 2
  end
  object edLOGIN: TEdit
    Left = 148
    Top = 90
    Width = 121
    Height = 21
    CharCase = ecUpperCase
    MaxLength = 50
    TabOrder = 3
  end
  object edPSW1: TEdit
    Left = 148
    Top = 114
    Width = 121
    Height = 21
    MaxLength = 50
    TabOrder = 4
    OnChange = edPSW1Change
  end
  object edPSW2: TEdit
    Left = 148
    Top = 138
    Width = 121
    Height = 21
    MaxLength = 50
    TabOrder = 5
  end
  object cbrLogin: TCheckBox
    Left = 8
    Top = 189
    Width = 120
    Height = 17
    Caption = #1056#1072#1079#1088#1077#1096#1077#1085' '#1074#1093#1086#1076
    Checked = True
    State = cbChecked
    TabOrder = 6
  end
  object cbrAdmin: TCheckBox
    Left = 144
    Top = 189
    Width = 130
    Height = 17
    Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077
    Checked = True
    State = cbChecked
    TabOrder = 7
  end
  object cbrEdit: TCheckBox
    Left = 8
    Top = 209
    Width = 120
    Height = 17
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object cbrImport: TCheckBox
    Left = 8
    Top = 229
    Width = 120
    Height = 17
    Caption = #1048#1084#1087#1086#1088#1090
    Checked = True
    State = cbChecked
    TabOrder = 9
    Visible = False
  end
  object cbrExport: TCheckBox
    Left = 144
    Top = 229
    Width = 130
    Height = 17
    Caption = #1069#1082#1089#1087#1086#1088#1090
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object cbrPrint: TCheckBox
    Left = 144
    Top = 209
    Width = 130
    Height = 13
    Caption = #1055#1077#1095#1072#1090#1100
    Checked = True
    State = cbChecked
    TabOrder = 11
  end
  object pbOk: TBitBtn
    Left = 120
    Top = 262
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 12
    OnClick = pbOkClick
  end
  object pbCancel: TBitBtn
    Left = 200
    Top = 262
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 2
    NumGlyphs = 2
    TabOrder = 13
  end
end

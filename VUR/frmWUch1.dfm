object fWUch1: TfWUch1
  Left = 0
  Top = 0
  Caption = #1052#1086#1073#1080#1083#1080#1079#1072#1094#1080#1086#1085#1085#1086#1077' '#1087#1088#1077#1076#1087#1080#1089#1072#1085#1080#1077
  ClientHeight = 286
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 104
    Height = 13
    Caption = #8470' '#1082#1086#1084#1072#1085#1076#1099', '#1087#1072#1088#1090#1080#1080
  end
  object Label2: TLabel
    Left = 8
    Top = 51
    Width = 57
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1103#1074#1082#1080
  end
  object Label3: TLabel
    Left = 61
    Top = 70
    Width = 35
    Height = 13
    Caption = #1057#1091#1090#1082#1080':'
  end
  object Label4: TLabel
    Left = 181
    Top = 70
    Width = 30
    Height = 13
    Caption = #1063#1072#1089#1099':'
  end
  object Label5: TLabel
    Left = 288
    Top = 70
    Width = 44
    Height = 13
    Caption = #1052#1080#1085#1091#1090#1099':'
  end
  object Label6: TLabel
    Left = 8
    Top = 148
    Width = 231
    Height = 13
    Caption = #1044#1072#1090#1072', '#1074#1088#1077#1084#1103' '#1074#1088#1091#1095#1077#1085#1080#1103' '#1082#1072#1088#1090#1086#1095#1082#1080' '#1086#1087#1086#1074#1077#1097#1077#1085#1080#1103
  end
  object Label7: TLabel
    Left = 8
    Top = 194
    Width = 104
    Height = 13
    Caption = #1055#1088#1080#1095#1080#1085#1072' '#1086#1090#1089#1091#1090#1089#1090#1074#1080#1103
  end
  object Label8: TLabel
    Left = 8
    Top = 99
    Width = 58
    Height = 13
    Caption = #1052#1077#1089#1090#1086' '#1103#1074#1082#1080
  end
  object chkSpecialWuch1: TCheckBox
    Left = 289
    Top = 26
    Width = 121
    Height = 17
    Caption = #1057#1087#1077#1094#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077
    TabOrder = 1
    OnClick = edMob_DaysChange
  end
  object edWUch1: TEdit
    Left = 61
    Top = 24
    Width = 205
    Height = 21
    MaxLength = 100
    TabOrder = 0
    OnChange = edWUch1Change
  end
  object Panel1: TPanel
    Left = 0
    Top = 245
    Width = 418
    Height = 41
    Align = alBottom
    TabOrder = 8
    ExplicitTop = 189
    object btnOk: TButton
      Left = 322
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
  end
  object edMob_CardDate: TdxDateEdit
    Left = 61
    Top = 167
    Width = 205
    TabOrder = 6
    OnClick = edMob_DaysChange
    Date = -700000.000000000000000000
  end
  object edMob_Days: TdxSpinEdit
    Left = 102
    Top = 67
    Width = 51
    TabOrder = 2
    OnChange = edMob_DaysChange
  end
  object edMob_Hours: TdxSpinEdit
    Left = 217
    Top = 67
    Width = 51
    TabOrder = 3
    OnClick = edMob_DaysChange
  end
  object edMob_Mins: TdxSpinEdit
    Left = 338
    Top = 67
    Width = 51
    TabOrder = 4
    OnClick = edMob_DaysChange
  end
  object edMob_MissReason: TEdit
    Left = 61
    Top = 213
    Width = 336
    Height = 21
    MaxLength = 100
    TabOrder = 7
    OnClick = edMob_DaysChange
  end
  object edMob_Place: TEdit
    Left = 61
    Top = 118
    Width = 336
    Height = 21
    MaxLength = 100
    TabOrder = 5
    OnClick = edMob_DaysChange
  end
end

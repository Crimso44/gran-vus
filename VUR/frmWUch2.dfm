object fWUch2: TfWUch2
  Left = 0
  Top = 0
  Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1099#1081' '#1074#1086#1080#1085#1089#1082#1080#1081' '#1091#1095#1077#1090
  ClientHeight = 389
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 92
    Height = 13
    Caption = #1059#1076#1086#1089#1090#1086#1074#1077#1088#1077#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 35
    Width = 31
    Height = 13
    Caption = #1057#1077#1088#1080#1103
  end
  object Label3: TLabel
    Left = 200
    Top = 35
    Width = 13
    Height = 13
    Caption = #8470
  end
  object Label4: TLabel
    Left = 32
    Top = 63
    Width = 153
    Height = 13
    Caption = #1044#1072#1090#1072' '#1074#1099#1087#1080#1089#1082#1080' '#1091#1076#1086#1089#1090#1086#1074#1077#1088#1077#1085#1080#1103
  end
  object Label5: TLabel
    Left = 222
    Top = 270
    Width = 65
    Height = 13
    Caption = #1050#1086#1076' '#1054#1050#1055#1044#1058#1056
  end
  object Label6: TLabel
    Left = 10
    Top = 294
    Width = 117
    Height = 13
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100' '#1087#1086' '#1054#1050#1055#1044#1058#1056
  end
  object Label7: TLabel
    Left = 32
    Top = 270
    Width = 59
    Height = 13
    Caption = #1050#1086#1076' '#1054#1050#1042#1069#1044
  end
  object Label8: TLabel
    Left = 32
    Top = 117
    Width = 102
    Height = 13
    Caption = #1055#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1052#1042#1050
  end
  object Label9: TLabel
    Left = 8
    Top = 98
    Width = 169
    Height = 13
    Caption = #1055#1077#1088#1089#1086#1085#1072#1083#1100#1085#1086#1077' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 8
    Top = 242
    Width = 128
    Height = 13
    Caption = #1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1055#1044#1055
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 10
    Top = 140
    Width = 91
    Height = 13
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100' '#1087#1086' '#1064#1056
  end
  object Label12: TLabel
    Left = 10
    Top = 188
    Width = 186
    Height = 13
    Caption = #1052#1086#1090#1080#1074' '#1087#1077#1088#1089#1086#1085#1072#1083#1100#1085#1086#1075#1086' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1103
  end
  object Panel1: TPanel
    Left = 0
    Top = 348
    Width = 418
    Height = 41
    Align = alBottom
    TabOrder = 3
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
  object edWUch2: TEdit
    Left = 232
    Top = 32
    Width = 165
    Height = 21
    MaxLength = 100
    TabOrder = 1
    OnChange = edWUch2Change
  end
  object dtWUch2_date: TdxDateEdit
    Left = 233
    Top = 59
    Width = 101
    TabOrder = 2
    OnChange = edWUch2Change
    Date = -700000.000000000000000000
    DateOnError = deToday
    SaveTime = False
  end
  object edWUch2_Ser: TEdit
    Left = 80
    Top = 32
    Width = 101
    Height = 21
    MaxLength = 100
    TabOrder = 0
    OnChange = edWUch2Change
  end
  object edWUOKVED: TEdit
    Left = 97
    Top = 267
    Width = 101
    Height = 21
    Color = clBtnFace
    Enabled = False
    ReadOnly = True
    TabOrder = 4
  end
  object edWUOKPDTR: TEdit
    Left = 293
    Top = 267
    Width = 101
    Height = 21
    Color = clBtnFace
    Enabled = False
    ReadOnly = True
    TabOrder = 5
  end
  object edWUOKPDTRName: TEdit
    Left = 8
    Top = 313
    Width = 389
    Height = 21
    Color = clBtnFace
    Enabled = False
    ReadOnly = True
    TabOrder = 6
  end
  object edWUMvkOrd: TEdit
    Left = 229
    Top = 114
    Width = 165
    Height = 21
    Color = clBtnFace
    Enabled = False
    ReadOnly = True
    TabOrder = 7
  end
  object edWUOKPDTRNameMvk: TEdit
    Left = 8
    Top = 159
    Width = 389
    Height = 21
    Color = clBtnFace
    Enabled = False
    ReadOnly = True
    TabOrder = 8
  end
  object edWUch2_Motiv: TEdit
    Left = 8
    Top = 207
    Width = 389
    Height = 21
    MaxLength = 255
    TabOrder = 9
    OnChange = edWUch2Change
  end
  object edWUOKVEDCombo: TComboBox
    Left = 95
    Top = 267
    Width = 101
    Height = 21
    Style = csDropDownList
    TabOrder = 10
    Visible = False
    OnChange = edWUOKVEDComboChange
  end
end

object fmOrgPropContacts: TfmOrgPropContacts
  Left = 382
  Top = 353
  HelpContext = 508
  ActiveControl = edFam1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' - '#1082#1086#1085#1090#1072#1082#1090#1099
  ClientHeight = 387
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 8
    Width = 147
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080':'
  end
  object Label2: TLabel
    Left = 368
    Top = 148
    Width = 131
    Height = 13
    Caption = #1042#1086#1077#1085#1085#1086'-'#1091#1095#1077#1090#1085#1099#1081' '#1088#1072#1073#1086#1090#1085#1080#1082
  end
  object Label3: TLabel
    Left = 428
    Top = 56
    Width = 71
    Height = 13
    Caption = #1056#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1100
  end
  object Label4: TLabel
    Left = 12
    Top = 76
    Width = 52
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 62
    Width = 417
    Height = 9
    Shape = bsTopLine
  end
  object Label6: TLabel
    Left = 12
    Top = 100
    Width = 25
    Height = 13
    Caption = #1048#1084#1103':'
  end
  object Label7: TLabel
    Left = 12
    Top = 124
    Width = 50
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
  end
  object Label8: TLabel
    Left = 244
    Top = 100
    Width = 48
    Height = 13
    Caption = #1058#1077#1083#1077#1092#1086#1085':'
  end
  object Label9: TLabel
    Left = 244
    Top = 124
    Width = 61
    Height = 13
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
  end
  object Bevel2: TBevel
    Left = 8
    Top = 154
    Width = 357
    Height = 9
    Shape = bsTopLine
  end
  object Label5: TLabel
    Left = 12
    Top = 168
    Width = 52
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
  end
  object Label10: TLabel
    Left = 12
    Top = 192
    Width = 25
    Height = 13
    Caption = #1048#1084#1103':'
  end
  object Label11: TLabel
    Left = 12
    Top = 216
    Width = 50
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
  end
  object Label12: TLabel
    Left = 244
    Top = 192
    Width = 48
    Height = 13
    Caption = #1058#1077#1083#1077#1092#1086#1085':'
  end
  object Label13: TLabel
    Left = 244
    Top = 216
    Width = 61
    Height = 13
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
  end
  object Bevel3: TBevel
    Left = 8
    Top = 344
    Width = 493
    Height = 5
    Shape = bsTopLine
  end
  object edOrgName: TEdit
    Left = 12
    Top = 28
    Width = 485
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
  end
  object edFam1: TEdit
    Left = 80
    Top = 72
    Width = 145
    Height = 21
    MaxLength = 50
    TabOrder = 1
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edIm1: TEdit
    Left = 80
    Top = 96
    Width = 97
    Height = 21
    MaxLength = 50
    TabOrder = 2
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edOtch1: TEdit
    Left = 80
    Top = 120
    Width = 121
    Height = 21
    MaxLength = 50
    TabOrder = 3
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edPhone1: TEdit
    Left = 316
    Top = 96
    Width = 181
    Height = 21
    MaxLength = 50
    TabOrder = 4
    OnChange = edFam1Change
  end
  object edPost1: TEdit
    Left = 316
    Top = 120
    Width = 181
    Height = 21
    MaxLength = 50
    TabOrder = 5
    OnChange = edFam1Change
  end
  object edFam2: TEdit
    Left = 80
    Top = 164
    Width = 145
    Height = 21
    MaxLength = 50
    TabOrder = 6
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edIm2: TEdit
    Left = 80
    Top = 188
    Width = 97
    Height = 21
    MaxLength = 50
    TabOrder = 7
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edOtch2: TEdit
    Left = 80
    Top = 212
    Width = 121
    Height = 21
    MaxLength = 50
    TabOrder = 8
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edPhone2: TEdit
    Left = 316
    Top = 188
    Width = 181
    Height = 21
    MaxLength = 50
    TabOrder = 9
    OnChange = edFam1Change
  end
  object edPost2: TEdit
    Left = 316
    Top = 212
    Width = 181
    Height = 21
    MaxLength = 50
    TabOrder = 10
    OnChange = edFam1Change
  end
  object btnClose: TButton
    Left = 412
    Top = 355
    Width = 87
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 11
  end
end

object fmOrgPropVoenkom: TfmOrgPropVoenkom
  Left = 382
  Top = 353
  HelpContext = 508
  ActiveControl = edFam1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' - '#1074#1086#1077#1085#1085#1099#1081' '#1082#1086#1084#1080#1089#1089#1072#1088
  ClientHeight = 243
  ClientWidth = 310
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 191
    Top = 100
    Width = 111
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1100#1085#1080#1082' '#1086#1090#1076#1077#1083#1077#1085#1080#1103
  end
  object Label3: TLabel
    Left = 204
    Top = 8
    Width = 98
    Height = 13
    Caption = #1042#1086#1077#1085#1085#1099#1081' '#1082#1086#1084#1080#1089#1089#1072#1088
  end
  object Label4: TLabel
    Left = 12
    Top = 28
    Width = 52
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 13
    Width = 161
    Height = 9
    Shape = bsTopLine
  end
  object Label6: TLabel
    Left = 12
    Top = 52
    Width = 25
    Height = 13
    Caption = #1048#1084#1103':'
  end
  object Label7: TLabel
    Left = 12
    Top = 76
    Width = 50
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
  end
  object Bevel2: TBevel
    Left = 8
    Top = 106
    Width = 161
    Height = 9
    Shape = bsTopLine
  end
  object Label5: TLabel
    Left = 12
    Top = 120
    Width = 52
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
  end
  object Label10: TLabel
    Left = 12
    Top = 144
    Width = 25
    Height = 13
    Caption = #1048#1084#1103':'
  end
  object Label11: TLabel
    Left = 12
    Top = 168
    Width = 50
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
  end
  object Bevel3: TBevel
    Left = 12
    Top = 200
    Width = 290
    Height = 5
    Shape = bsTopLine
  end
  object edFam1: TEdit
    Left = 110
    Top = 25
    Width = 145
    Height = 21
    MaxLength = 50
    TabOrder = 0
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edIm1: TEdit
    Left = 110
    Top = 49
    Width = 145
    Height = 21
    MaxLength = 50
    TabOrder = 1
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edOtch1: TEdit
    Left = 110
    Top = 73
    Width = 145
    Height = 21
    MaxLength = 50
    TabOrder = 2
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edFam2: TEdit
    Left = 110
    Top = 117
    Width = 145
    Height = 21
    MaxLength = 50
    TabOrder = 3
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edIm2: TEdit
    Left = 110
    Top = 141
    Width = 145
    Height = 21
    MaxLength = 50
    TabOrder = 4
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object edOtch2: TEdit
    Left = 110
    Top = 165
    Width = 145
    Height = 21
    MaxLength = 50
    TabOrder = 5
    OnChange = edFam1Change
    OnKeyPress = edFam1KeyPress
  end
  object btnClose: TButton
    Left = 215
    Top = 211
    Width = 87
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 6
  end
end

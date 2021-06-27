object fDelDev: TfDelDev
  Left = 0
  Top = 0
  Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1091#1089#1090#1088#1086#1081#1089#1090#1074#1072
  ClientHeight = 124
  ClientWidth = 348
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
    Left = 16
    Top = 16
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 16
    Top = 35
    Width = 31
    Height = 13
    Caption = 'Label2'
  end
  object Panel1: TPanel
    Left = 0
    Top = 83
    Width = 348
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 128
    ExplicitTop = 144
    ExplicitWidth = 185
    DesignSize = (
      348
      41)
    object btnOk: TBitBtn
      Left = 184
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      DoubleBuffered = True
      Kind = bkOK
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 0
      ExplicitLeft = 254
    end
    object btnCancel: TBitBtn
      Left = 265
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      DoubleBuffered = True
      Kind = bkCancel
      NumGlyphs = 2
      ParentDoubleBuffered = False
      TabOrder = 1
      ExplicitLeft = 335
    end
  end
  object cDelFile: TCheckBox
    Left = 56
    Top = 60
    Width = 273
    Height = 17
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1092#1072#1081#1083' '#1089' '#1076#1080#1089#1082#1072
    TabOrder = 1
  end
end

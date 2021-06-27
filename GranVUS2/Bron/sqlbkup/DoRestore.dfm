object fDoRestore: TfDoRestore
  Left = 0
  Top = 0
  Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1080#1079' '#1088#1077#1079#1077#1088#1074#1085#1086#1081' '#1082#1086#1087#1080#1080
  ClientHeight = 79
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    385
    79)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 69
    Height = 13
    Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093':'
  end
  object Panel1: TPanel
    Left = 0
    Top = 38
    Width = 385
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 128
    ExplicitTop = 144
    ExplicitWidth = 185
    DesignSize = (
      385
      41)
    object btnOk: TBitBtn
      Left = 221
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
      Left = 302
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
  object eBaseName: TEdit
    Left = 83
    Top = 5
    Width = 294
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    ExplicitWidth = 327
  end
end

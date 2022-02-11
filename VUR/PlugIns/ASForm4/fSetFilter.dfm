object fxSetFilter: TfxSetFilter
  Left = 0
  Top = 0
  Caption = #1042#1077#1076#1086#1084#1086#1089#1090#1100' '#1091#1095#1077#1090#1072' '#1040#1057#1060
  ClientHeight = 358
  ClientWidth = 362
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 362
    Height = 320
    Align = alClient
    TabOrder = 0
    object Splitter2: TSplitter
      Left = 1
      Top = 165
      Width = 360
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 98
      ExplicitWidth = 206
    end
    object Panel3: TPanel
      Left = 1
      Top = 168
      Width = 360
      Height = 151
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 360
        Height = 17
        Align = alTop
        BevelOuter = bvNone
        Caption = #1042#1080#1076#1099' '#1052#1058#1056
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object bDepsNone: TBitBtn
          Left = 343
          Top = 0
          Width = 17
          Height = 17
          Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1087#1086#1084#1077#1090#1082#1080
          Align = alRight
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = bDepsNoneClick
        end
        object bDepsAll: TBitBtn
          Left = 326
          Top = 0
          Width = 17
          Height = 17
          Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
          Align = alRight
          Caption = '+'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = bDepsAllClick
        end
      end
      object cbDeps: TCheckListBox
        Left = 0
        Top = 17
        Width = 360
        Height = 134
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
      end
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 360
      Height = 164
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 360
        Height = 17
        Align = alTop
        BevelOuter = bvNone
        Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object bPostsNone: TBitBtn
          Left = 343
          Top = 0
          Width = 17
          Height = 17
          Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1087#1086#1084#1077#1090#1082#1080
          Align = alRight
          Caption = '-'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          OnClick = bPostsNoneClick
        end
        object bPostsAll: TBitBtn
          Left = 326
          Top = 0
          Width = 17
          Height = 17
          Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
          Align = alRight
          Caption = '+'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          OnClick = bPostsAllClick
        end
      end
      object cbPosts: TCheckListBox
        Left = 0
        Top = 17
        Width = 360
        Height = 147
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
      end
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 320
    Width = 362
    Height = 38
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      362
      38)
    object bOK: TButton
      Left = 201
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1050
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object bCancel: TButton
      Left = 282
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
end

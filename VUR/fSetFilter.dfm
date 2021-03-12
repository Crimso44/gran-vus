object fxSetFilter: TfxSetFilter
  Left = 0
  Top = 0
  Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1092#1080#1083#1100#1090#1088
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
    ExplicitTop = -76
    ExplicitWidth = 185
    ExplicitHeight = 358
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
      ExplicitTop = 204
      ExplicitWidth = 183
      ExplicitHeight = 153
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 360
        Height = 17
        Align = alTop
        BevelOuter = bvNone
        Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        ExplicitWidth = 183
        object bDepsNone: TBitBtn
          Left = 343
          Top = 0
          Width = 17
          Height = 17
          Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1087#1086#1084#1077#1090#1082#1080
          Align = alRight
          Caption = '-'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 0
          OnClick = bDepsNoneClick
          ExplicitLeft = 166
        end
        object bDepsAll: TBitBtn
          Left = 326
          Top = 0
          Width = 17
          Height = 17
          Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
          Align = alRight
          Caption = '+'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 1
          OnClick = bDepsAllClick
          ExplicitLeft = 149
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
        ExplicitWidth = 183
        ExplicitHeight = 136
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
      ExplicitWidth = 416
      object Panel4: TPanel
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
        ExplicitWidth = 183
        object bPostsNone: TBitBtn
          Left = 343
          Top = 0
          Width = 17
          Height = 17
          Hint = #1057#1085#1103#1090#1100' '#1074#1089#1077' '#1087#1086#1084#1077#1090#1082#1080
          Align = alRight
          Caption = '-'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 0
          OnClick = bPostsNoneClick
          ExplicitLeft = 166
        end
        object bPostsAll: TBitBtn
          Left = 326
          Top = 0
          Width = 17
          Height = 17
          Hint = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
          Align = alRight
          Caption = '+'
          DoubleBuffered = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentDoubleBuffered = False
          ParentFont = False
          TabOrder = 1
          OnClick = bPostsAllClick
          ExplicitLeft = 149
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
        ExplicitWidth = 183
        ExplicitHeight = 183
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
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
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
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
    object bAbort: TButton
      Left = 8
      Top = 6
      Width = 101
      Height = 25
      Caption = #1057#1085#1103#1090#1100' '#1092#1080#1083#1100#1090#1088
      ModalResult = 3
      TabOrder = 2
    end
  end
end

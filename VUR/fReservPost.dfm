object fmReservPost: TfmReservPost
  Left = 305
  Top = 206
  Width = 586
  Height = 407
  HelpContext = 501
  Caption = #1041#1088#1086#1085#1080#1088#1091#1077#1084#1099#1077' '#1076#1086#1083#1078#1085#1086#1089#1090#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefaultPosOnly
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 452
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 6
    TabStop = False
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 354
    Width = 578
    Height = 19
    Panels = <>
  end
  object dxtData: TdxTreeList
    Left = 0
    Top = 26
    Width = 578
    Height = 328
    Bands = <
      item
        Fixed = bfLeft
      end
      item
      end>
    DefaultLayout = False
    HeaderPanelRowCount = 1
    Align = alClient
    TabOrder = 1
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoColumnMoving, aoEditing, aoTabThrough, aoImmediateEditor]
    TreeLineColor = clGrayText
    ShowGrid = True
    ShowRoot = False
    object dxtDataColumn1: TdxTreeListColumn
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      Color = clBtnHighlight
      DisableEditor = True
      ReadOnly = True
      Width = 147
      BandIndex = 0
      RowIndex = 0
    end
  end
  object dxBarManager1: TdxBarManager
    AllowReset = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Bars = <
      item
        AllowClose = False
        AllowCustomizing = False
        AllowQuickCustomizing = False
        AllowReset = False
        Caption = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 276
        FloatTop = 216
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = dxBarButton1
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButton2
            Visible = True
          end>
        Name = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
        NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = False
      end>
    Categories.Strings = (
      #1054#1089#1085#1086#1074#1085#1086#1081)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    Images = dmMain.ilSmall
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 208
    Top = 76
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarButton1: TdxBarButton
      Action = actStrore
      Category = 0
      PaintStyle = psCaptionGlyph
    end
    object dxBarButton2: TdxBarButton
      Action = actClose
      Category = 0
      PaintStyle = psCaptionGlyph
    end
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 76
    Top = 188
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM RES_LIST')
    Left = 68
    Top = 100
  end
  object ActionList1: TActionList
    Images = dmMain.ilSmall
    Left = 348
    Top = 88
    object actStrore: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1089#1087#1080#1089#1082#1072' '#1073#1088#1086#1085#1080#1088#1091#1077#1084#1099#1093' '#1076#1086#1083#1078#1085#1086#1089#1090#1077#1081
      ImageIndex = 38
      OnExecute = actStroreExecute
    end
    object actClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1073#1088#1086#1085#1080#1088#1091#1077#1084#1099#1093' '#1076#1086#1083#1078#1085#1086#1089#1090#1077#1081
      ImageIndex = 7
      OnExecute = actCloseExecute
    end
  end
end

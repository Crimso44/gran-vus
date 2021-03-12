object fmStaffList: TfmStaffList
  Left = 227
  Top = 229
  HelpContext = 15
  Caption = #1064#1090#1072#1090#1085#1086#1077' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077'. '#1059#1095#1105#1090' "'#1042#1089#1077#1075#1086' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093'"'
  ClientHeight = 369
  ClientWidth = 657
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 185
    Top = 26
    Height = 305
    ExplicitLeft = 200
    ExplicitTop = 216
    ExplicitHeight = 100
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 350
    Width = 657
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 200
      end
      item
        Width = 500
      end>
  end
  object TabControl: TTabControl
    Left = 188
    Top = 26
    Width = 469
    Height = 305
    Align = alClient
    MultiLine = True
    TabOrder = 2
    Tabs.Strings = (
      '')
    TabIndex = 0
    OnChange = TabControlChange
    object GridX: TcxGrid
      Left = 4
      Top = 24
      Width = 461
      Height = 277
      Align = alClient
      PopupMenu = mnuGrid
      TabOrder = 0
      object GridXDBTableView1: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Kind = skSum
            Column = ColGridPost_Total
          end>
        DataController.Summary.SummaryGroups = <
          item
            Links = <
              item
                Column = ColGridNum
              end
              item
                Column = ColGridPost_Name
              end
              item
                Column = ColGridPost_Total
              end>
            SummaryItems = <>
          end
          item
            Links = <>
            SummaryItems = <>
          end>
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        object ColGridNum: TcxGridDBColumn
          Caption = #8470' '#1087'/'#1087
          MinWidth = 40
          Options.Editing = False
          Options.HorzSizing = False
          Options.Moving = False
          Width = 40
        end
        object ColGridPost_Name: TcxGridDBColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1077#1089#1089#1080#1080'/'#1076#1086#1083#1078#1085#1086#1089#1090#1080
          Options.Editing = False
          Width = 177
        end
        object ColGridPost_Total: TcxGridDBColumn
          Caption = #1042#1089#1077#1075#1086
          Options.Editing = False
          Width = 41
        end
      end
      object GridXView: TcxGridBandedTableView
        NavigatorButtons.ConfirmDelete = False
        OnCustomDrawCell = GridXViewCustomDrawCell
        OnEditValueChanged = GridXViewEditValueChanged
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '0'
            Kind = skSum
            Column = GridPost_TotalX
          end>
        DataController.Summary.SummaryGroups = <>
        OptionsSelection.InvertSelect = False
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.BandHeaders = False
        Bands = <
          item
            FixedKind = fkLeft
            Options.HoldOwnColumnsOnly = True
            Options.Sizing = False
          end
          item
          end>
        object GridNumX: TcxGridBandedColumn
          Caption = #8470' '#1087'/'#1087
          DataBinding.ValueType = 'Integer'
          OnGetDisplayText = GridNumXGetDisplayText
          MinWidth = 40
          Options.Editing = False
          Options.HorzSizing = False
          Options.Moving = False
          Options.Sorting = False
          Width = 40
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object GridPost_NameX: TcxGridBandedColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1088#1086#1092#1077#1089#1089#1080#1080'/'#1076#1086#1083#1078#1085#1086#1089#1090#1080
          Options.Editing = False
          Width = 177
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object GridPost_TotalX: TcxGridBandedColumn
          Caption = #1042#1089#1077#1075#1086
          DataBinding.ValueType = 'Integer'
          Options.Editing = False
          Width = 41
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object GridPost_IdX: TcxGridBandedColumn
          DataBinding.ValueType = 'Integer'
          Visible = False
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
      end
      object GridXLevel2: TcxGridLevel
        GridView = GridXView
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 331
    Width = 657
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object Panel1: TPanel
    Left = 0
    Top = 26
    Width = 185
    Height = 305
    Align = alLeft
    TabOrder = 7
    Visible = False
    object Splitter2: TSplitter
      Left = 1
      Top = 201
      Width = 183
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitTop = 98
      ExplicitWidth = 206
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 200
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 183
        Height = 17
        Align = alTop
        BevelOuter = bvNone
        Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1080
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object bPostsNone: TBitBtn
          Left = 166
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
        end
        object bPostsAll: TBitBtn
          Left = 149
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
        end
      end
      object cbPosts: TCheckListBox
        Left = 0
        Top = 17
        Width = 183
        Height = 183
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 204
      Width = 183
      Height = 100
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 183
        Height = 17
        Align = alTop
        BevelOuter = bvNone
        Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object bDepsNone: TBitBtn
          Left = 166
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
        end
        object bDepsAll: TBitBtn
          Left = 149
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
        end
      end
      object cbDeps: TCheckListBox
        Left = 0
        Top = 17
        Width = 183
        Height = 83
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
      end
    end
  end
  object dxBarManager1: TdxBarManager
    AllowReset = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      #1054#1089#1085#1086#1074#1085#1086#1081)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ilSmall
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 96
    Top = 72
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
      CaptionButtons = <>
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
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'bFilter'
        end
        item
          Visible = True
          ItemName = 'dxBBHideOld'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItem1'
        end
        item
          BeginGroup = True
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'dxBarButton3'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OldName = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Action = actStore
      Category = 0
      PaintStyle = psCaptionGlyph
    end
    object dxBarButton2: TdxBarButton
      Action = actClose
      Category = 0
      PaintStyle = psCaptionGlyph
    end
    object dxBarButton5: TdxBarButton
      Action = actRefresh
      Category = 0
      PaintStyle = psCaptionGlyph
    end
    object dxBarSubItem1: TdxBarSubItem
      Action = actRevert
      Category = 0
      ShowCaption = False
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarButton8'
        end>
    end
    object dxBarButton4: TdxBarButton
      Action = actRevertCell
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Action = actRevertColumn
      Category = 0
    end
    object dxBarButton7: TdxBarButton
      Action = actRevertRow
      Category = 0
    end
    object dxBarButton8: TdxBarButton
      Action = actRevertAll
      Category = 0
    end
    object dxBarSubItem2: TdxBarSubItem
      Action = actCalculate
      Category = 0
      ShowCaption = False
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton11'
        end
        item
          Visible = True
          ItemName = 'dxBarButton12'
        end>
    end
    object dxBarButton9: TdxBarButton
      Action = actCalculateCell
      Category = 0
    end
    object dxBarButton10: TdxBarButton
      Action = actCalculateColumn
      Category = 0
    end
    object dxBarButton11: TdxBarButton
      Action = actCalculateRow
      Category = 0
    end
    object dxBarButton12: TdxBarButton
      Action = actCalculateAll
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actExcel
      Category = 0
    end
    object bFilter: TdxBarButton
      Caption = #1060#1080#1083#1100#1090#1088
      Category = 0
      Hint = #1060#1080#1083#1100#1090#1088
      Visible = ivAlways
      AllowAllUp = True
      ButtonStyle = bsChecked
      ImageIndex = 34
      OnClick = bFilterClick
    end
    object dxBBHideOld: TdxBarButton
      Caption = #1057#1082#1088#1099#1090#1100' '#1091#1087#1088#1072#1079#1076#1085#1077#1085#1085#1099#1077
      Category = 0
      Hint = #1057#1082#1088#1099#1090#1100' '#1091#1087#1088#1072#1079#1076#1085#1077#1085#1085#1099#1077
      Visible = ivAlways
      AllowAllUp = True
      ButtonStyle = bsChecked
      Down = True
      ImageIndex = 13
      OnClick = dxBBHideOldClick
    end
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 24
    Top = 128
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      
        'DEP_ID, POST_ID, GeneralPlan, WartimePlan, GeneralQty, GeneralVa' +
        'cancy, WartimeVacancy, QtyMOB, QtyRECRUIT, QtyRESERV, QtyWAR, Qt' +
        'yAll'
      'FROM StaffListAll '
      
        'where GeneralPlan <> 0 or WartimePlan <> 0 or GeneralQty <> 0 or' +
        ' GeneralVacancy <> 0 or WartimeVacancy <> 0 or QtyMOB <> 0 or Qt' +
        'yRECRUIT <> 0 or QtyRESERV <> 0 or QtyWAR <> 0 or QtyAll <> 0'
      'order by POST_ID, DEP_ID'
      '')
    Left = 28
    Top = 72
  end
  object ActionList1: TActionList
    Images = dmMain.ilSmall
    OnUpdate = ActionList1Update
    Left = 168
    Top = 80
    object actStore: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      ImageIndex = 38
      OnExecute = actStoreExecute
    end
    object actClose: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086' '#1096#1090#1072#1090#1085#1086#1075#1086' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1103
      ImageIndex = 41
      OnExecute = actCloseExecute
    end
    object actCalculate: TAction
      Caption = #1042#1099#1095#1080#1089#1083#1080#1090#1100
      Hint = #1042#1099#1095#1080#1089#1083#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1077
      ImageIndex = 44
      OnExecute = actCalculateExecute
    end
    object actRevert: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1089#1076#1077#1083#1072#1085#1085#1099#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
      ImageIndex = 7
      OnExecute = actRevertExecute
    end
    object actRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1080#1079' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 40
      OnExecute = actRefreshExecute
    end
    object actRevertCell: TAction
      Category = 'Revert'
      Caption = #1044#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1103#1095#1077#1081#1082#1080
      ImageIndex = 48
      OnExecute = actRevertCellExecute
    end
    object actRevertColumn: TAction
      Category = 'Revert'
      Caption = #1044#1083#1103' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      ImageIndex = 45
      OnExecute = actRevertColumnExecute
    end
    object actRevertRow: TAction
      Category = 'Revert'
      Caption = #1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1076#1086#1083#1078#1085#1086#1089#1090#1080
      ImageIndex = 46
      OnExecute = actRevertRowExecute
    end
    object actRevertAll: TAction
      Category = 'Revert'
      Caption = #1044#1083#1103' '#1074#1089#1077#1081' '#1089#1090#1088#1072#1085#1080#1094#1099
      ImageIndex = 47
      OnExecute = actRevertAllExecute
    end
    object actCalculateCell: TAction
      Category = 'Calculate'
      Caption = #1044#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1103#1095#1077#1081#1082#1080
      ImageIndex = 48
      OnExecute = actCalculateCellExecute
    end
    object actCalculateColumn: TAction
      Category = 'Calculate'
      Caption = #1044#1083#1103' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      ImageIndex = 45
      OnExecute = actCalculateColumnExecute
    end
    object actCalculateRow: TAction
      Category = 'Calculate'
      Caption = #1044#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1076#1086#1083#1078#1085#1086#1089#1090#1080
      ImageIndex = 46
      OnExecute = actCalculateRowExecute
    end
    object actCalculateAll: TAction
      Category = 'Calculate'
      Caption = #1044#1083#1103' '#1074#1089#1077#1081' '#1089#1090#1088#1072#1085#1080#1094#1099
      ImageIndex = 47
      OnExecute = actCalculateAllExecute
    end
    object actExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      ImageIndex = 39
      OnExecute = actExcelExecute
    end
  end
  object mnuGrid: TPopupMenu
    Images = dmMain.ilSmall
    Left = 168
    Top = 138
    object N1: TMenuItem
      Action = actCalculate
      object N2: TMenuItem
        Action = actCalculateCell
      end
      object N3: TMenuItem
        Action = actCalculateColumn
      end
      object N4: TMenuItem
        Action = actCalculateRow
      end
      object N5: TMenuItem
        Action = actCalculateAll
      end
    end
    object N6: TMenuItem
      Action = actRevert
      object N7: TMenuItem
        Action = actRevertCell
      end
      object N8: TMenuItem
        Action = actRevertColumn
      end
      object N9: TMenuItem
        Action = actRevertRow
      end
      object N10: TMenuItem
        Action = actRevertAll
      end
    end
    object N11: TMenuItem
      Action = actRefresh
    end
    object Excel1: TMenuItem
      Action = actExcel
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xls'
    Filter = #1060#1072#1081#1083#1099' Excel|*.xls'
    Left = 320
    Top = 192
  end
end

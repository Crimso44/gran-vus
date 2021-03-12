object fmUsers: TfmUsers
  Left = 330
  Top = 248
  HelpContext = 35
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
  ClientHeight = 238
  ClientWidth = 571
  Color = clBtnFace
  Constraints.MinHeight = 150
  Constraints.MinWidth = 390
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 219
    Width = 571
    Height = 19
    Panels = <>
  end
  object dbgData: TdxDBGrid
    Left = 0
    Top = 26
    Width = 571
    Height = 193
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    KeyField = 'ID'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 0
    OnDblClick = actEditExecute
    OnKeyDown = dbgDataKeyDown
    DataSource = dsData
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoAnsiSort, edgoAutoCopySelectedToClipboard, edgoAutoSort, edgoDblClick, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSort, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoFullSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks, edgoUseLocate]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoRowSelect, edgoUseBitmap]
    RegistryPath = '\Software\Granit\GranVUS\UsersGrid'
    OnColumnSorting = dbgDataColumnSorting
    object dbgDataNum: TdxDBGridColumn
      Caption = #8470' '#1087'/'#1087
      DisableDragging = True
      DisableEditor = True
      Sizing = False
      Width = 40
      BandIndex = 0
      RowIndex = 0
      OnGetText = dbgDataNumGetText
    end
    object dbgDataFIO: TdxDBGridColumn
      Caption = #1060#1048#1054
      Width = 161
      BandIndex = 0
      RowIndex = 0
      FieldName = 'FIO'
    end
    object dbgDataLOGIN: TdxDBGridColumn
      Caption = #1057#1080#1089#1090#1077#1084#1085#1086#1077' '#1080#1084#1103
      Width = 92
      BandIndex = 0
      RowIndex = 0
      FieldName = 'LOGIN'
    end
    object dbgDatarLogin: TdxDBGridCheckColumn
      Caption = #1056#1072#1079#1088#1077#1096#1105#1085' '#1074#1093#1086#1076
      Width = 56
      BandIndex = 0
      RowIndex = 0
      FieldName = 'rLogin'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDatarAdmin: TdxDBGridCheckColumn
      Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077
      Width = 55
      BandIndex = 0
      RowIndex = 0
      FieldName = 'rAdmin'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDatarImport: TdxDBGridCheckColumn
      Caption = #1048#1084#1087#1086#1088#1090
      Visible = False
      Width = 50
      BandIndex = 0
      RowIndex = 0
      FieldName = 'rImport'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDatarExport: TdxDBGridCheckColumn
      Caption = #1069#1082#1089#1087#1086#1088#1090
      Width = 48
      BandIndex = 0
      RowIndex = 0
      FieldName = 'rExport'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDatarPrint: TdxDBGridCheckColumn
      Caption = #1055#1077#1095#1072#1090#1100
      Width = 42
      BandIndex = 0
      RowIndex = 0
      FieldName = 'rPrint'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDatarEdit: TdxDBGridCheckColumn
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Width = 44
      BandIndex = 0
      RowIndex = 0
      FieldName = 'rEdit'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 12
    Top = 124
  end
  object dsData: TDataSource
    DataSet = qrData
    Left = 72
    Top = 24
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    OnCalcFields = qrDataCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM USERS')
    Left = 76
    Top = 80
    object qrDataID: TIntegerField
      FieldName = 'ID'
    end
    object qrDataLogin: TStringField
      FieldName = 'Login'
      Size = 50
    end
    object qrDataFAM: TStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrDataIM: TStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrDataOTCH: TStringField
      FieldName = 'OTCH'
      Size = 50
    end
    object qrDataFIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'FIO'
      Size = 60
      Calculated = True
    end
    object qrDatarAdmin: TBooleanField
      FieldName = 'rAdmin'
    end
    object qrDatarImport: TBooleanField
      FieldName = 'rImport'
    end
    object qrDatarExport: TBooleanField
      FieldName = 'rExport'
    end
    object qrDatarPrint: TBooleanField
      FieldName = 'rPrint'
    end
    object qrDatarEdit: TBooleanField
      FieldName = 'rEdit'
    end
    object qrDatarLogin: TBooleanField
      FieldName = 'rLogin'
    end
  end
  object ActionList: TActionList
    Images = dmMain.ilSmall
    OnUpdate = ActionListUpdate
    Left = 204
    Top = 68
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100'...'
      ImageIndex = 21
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100'...'
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100'...'
      ImageIndex = 9
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 33
      OnExecute = actDeleteExecute
    end
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1080#1079' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 40
      OnExecute = aRefreshExecute
    end
  end
  object dxBarManager1: TdxBarManager
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
    Left = 324
    Top = 36
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManager1Bar1: TdxBar
      AllowCustomizing = False
      AllowQuickCustomizing = False
      Caption = #1053#1086#1074#1072#1103' '#1055#1072#1085#1077#1083#1100'1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 340
      FloatTop = 261
      FloatClientWidth = 23
      FloatClientHeight = 22
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton4'
        end>
      OldName = #1053#1086#1074#1072#1103' '#1055#1072#1085#1077#1083#1100'1'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Action = actAdd
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100'...'
    end
    object dxBarButton3: TdxBarButton
      Action = actEdit
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100'...'
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actDelete
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = aRefresh
      Category = 0
    end
  end
  object PopupMenu1: TPopupMenu
    Images = dmMain.ilSmall
    Left = 276
    Top = 132
    object N1: TMenuItem
      Action = actAdd
    end
    object N2: TMenuItem
      Action = actDelete
    end
    object N3: TMenuItem
      Action = actEdit
    end
  end
end

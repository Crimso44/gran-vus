object fmSubjList: TfmSubjList
  Left = 287
  Top = 280
  HelpContext = 9
  Caption = #1050#1072#1088#1090#1086#1090#1077#1082#1072' '#1042#1059#1054
  ClientHeight = 339
  ClientWidth = 696
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 320
    Width = 696
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object dbgData: TdxDBGrid
    Left = 0
    Top = 26
    Width = 696
    Height = 294
    Bands = <
      item
      end>
    DefaultLayout = False
    HeaderMinRowCount = 2
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    KeyField = 'SUBJ_ID'
    PartialLoadBufferCount = 50
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnDblClick = actEditExecute
    DataSource = DataSource1
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoFullSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords]
    OptionsView = [edgoBandHeaderWidth, edgoRowSelect, edgoUseBitmap]
    RegistryPath = '\Software\GRANVUS2\TfmSubjList'
    OnCustomDrawCell = dbgDataCustomDrawCell
    object dbgDataColumn5: TdxDBGridCheckColumn
      Alignment = taCenter
      Caption = #1043#1083#1072#1074#1085#1099#1081
      HeaderAlignment = taCenter
      Width = 51
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IsCurrent'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDataColumn3: TdxDBGridColumn
      Caption = #1042#1059#1054' '#1082#1091#1088#1080#1088#1091#1077#1090
      HeaderAlignment = taCenter
      Width = 96
      BandIndex = 0
      RowIndex = 0
      FieldName = 'TERRNAME'
    end
    object dbgDataColumn1: TdxDBGridColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 249
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SUBJ_NAME'
    end
    object dbgDataColumn10: TdxDBGridColumn
      Caption = #1058#1080#1087
      HeaderAlignment = taCenter
      Width = 84
      BandIndex = 0
      RowIndex = 0
      FieldName = 'TYPE_NAME'
    end
    object dbgDataColumn4: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #1057#1087#1086#1089#1086#1073' '#1091#1095#1077#1090#1072
      HeaderAlignment = taCenter
      Width = 116
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SUBJ_AGG_NAME'
    end
    object dbgDataIsReported: TdxDBGridCheckColumn
      Alignment = taCenter
      Caption = #1054#1090#1095#1080#1090#1072#1083#1080#1089#1100
      MinWidth = 20
      Width = 65
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IsReported'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDataChecked: TdxDBGridCheckColumn
      Alignment = taCenter
      Caption = #1060#1086#1088#1084#1099' 6 '#1087#1088#1086#1074#1077#1088#1077#1085#1099
      HeaderAlignment = taCenter
      Width = 65
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CHECKED'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  object ActionList1: TActionList
    Images = dmMain.ilSmall
    OnUpdate = ActionList1Update
    Left = 392
    Top = 60
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1089#1091#1073#1098#1077#1082#1090#1072
      ImageIndex = 21
      ShortCut = 45
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = #1055#1088#1072#1074#1080#1090#1100
      Hint = #1055#1088#1072#1074#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1089#1091#1073#1098#1077#1082#1090#1072
      ImageIndex = 9
      ShortCut = 13
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1089#1091#1073#1098#1077#1082#1090#1072
      ImageIndex = 33
      ShortCut = 16430
      OnExecute = actDelExecute
    end
    object actRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 42
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actCurrent: TAction
      Caption = #1043#1083#1072#1074#1085#1099#1081
      Hint = #1057#1076#1077#1083#1072#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1099#1081' '#1089#1091#1073#1098#1077#1082#1090' '#1075#1083#1072#1074#1085#1099#1084
      ImageIndex = 23
      OnExecute = actCurrentExecute
      OnUpdate = actCurrentUpdate
    end
    object actView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1087#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1089#1091#1073#1098#1077#1082#1090#1072
      ImageIndex = 36
      ShortCut = 13
      OnExecute = actEditExecute
    end
    object actExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1074' Microsoft Excel'
      ImageIndex = 49
      OnExecute = actExcelExecute
    end
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 32
    Top = 272
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1054#1089#1085#1086#1074#1085#1086#1081)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ilSmall
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 328
    Top = 104
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
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton6'
        end>
      NotDocking = [dsNone]
      OldName = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Action = actAdd
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actEdit
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actDel
      Category = 0
    end
    object dxBarButton10: TdxBarButton
      Action = actRefresh
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = actCurrent
      Category = 0
    end
    object dxBarButton5: TdxBarButton
      Action = actView
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Action = actExcel
      Category = 0
    end
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'SELECT S.*'
      
        '     , IsCurrent = CAST(CASE WHEN C.SUBJ_ID IS NULL THEN 0 ELSE ' +
        '1 END AS bit)'
      
        '     , Checked = CAST(CASE WHEN EXISTS(SELECT * FROM FORM6HDR WH' +
        'ERE CHECKED=0 AND SUBJ_ID=S.SUBJ_ID) THEN 0 ELSE 1 END AS bit)'
      '  FROM'
      'v_SUBJ S LEFT JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID')
    Left = 380
    Top = 116
  end
  object DataSource1: TDataSource
    DataSet = qrData
    Left = 424
    Top = 168
  end
  object PopupMenu1: TPopupMenu
    Left = 124
    Top = 108
    object N1: TMenuItem
      Action = actAdd
    end
    object N2: TMenuItem
      Action = actEdit
    end
    object N6: TMenuItem
      Action = actView
    end
    object N3: TMenuItem
      Action = actDel
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Action = actCurrent
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N14: TMenuItem
      Action = actRefresh
    end
  end
  object sp_SubjCardDelete: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_SubjCardDelete;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SUBJ_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 216
    Top = 152
  end
  object sp_SubjCurrSet: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_SubjCurrSet;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SUBJ_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 216
    Top = 192
  end
end

object fmFFS: TfmFFS
  Left = 330
  Top = 178
  Width = 782
  Height = 480
  HelpContext = 545
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1093' '#1087#1086' '#1074#1080#1076#1072#1084' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefaultPosOnly
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 774
    Height = 26
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 44
        Width = 770
      end>
    Images = dmMain.ilSmall
    object ToolBar1: TToolBar
      Left = 9
      Top = 0
      Width = 545
      Height = 22
      Align = alNone
      AutoSize = True
      ButtonWidth = 109
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = dmMain.ilSmall
      List = True
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 0
      object ToolButton4: TToolButton
        Left = 0
        Top = 0
        Action = actClear
      end
      object ToolButton2: TToolButton
        Left = 109
        Top = 0
        Action = actCreate
      end
      object ToolButton3: TToolButton
        Left = 218
        Top = 0
        Action = actPrint
      end
      object ToolButton1: TToolButton
        Left = 327
        Top = 0
        Action = actGenerate
      end
      object ToolButton5: TToolButton
        Left = 436
        Top = 0
        Action = actExcel
      end
    end
  end
  object dxDBGrid: TdxDBGrid
    Left = 0
    Top = 26
    Width = 774
    Height = 420
    Bands = <
      item
        DisableCustomizing = True
        DisableDragging = True
        Fixed = bfLeft
        OnlyOwnColumns = True
        Width = 412
      end
      item
        Caption = #1042#1059#1054' '#1082#1091#1088#1080#1088#1091#1077#1090
      end
      item
        Caption = #1042' '#1075#1086#1088#1086#1076#1072#1093
      end
      item
        Caption = #1042' '#1089#1077#1083#1100#1089#1082#1086#1081' '#1084#1077#1089#1090#1085#1086#1089#1090#1080
      end>
    DefaultLayout = False
    HeaderMinRowCount = 2
    HeaderPanelRowCount = 1
    KeyField = 'KOD'
    ShowSummaryFooter = True
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    BandFont.Charset = RUSSIAN_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -11
    BandFont.Name = 'MS Sans Serif'
    BandFont.Style = []
    DataSource = dsData
    Filter.Criteria = {00000000}
    FixedBandLineWidth = 1
    HeaderFont.Charset = RUSSIAN_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    OptionsBehavior = [edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandSizing, edgoColumnSizing]
    OptionsDB = [edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    ShowBands = True
    object KBONH_IDColumn: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #8470' '#1087'/'#1087
      Color = clBtnFace
      DisableCustomizing = True
      DisableDragging = True
      DisableEditor = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderAlignment = taCenter
      ReadOnly = True
      Width = 31
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'NPP'
      OnGetText = KBONH_IDColumnGetText
    end
    object NAMEColumn: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #1042#1080#1076#1099' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
      Color = clBtnFace
      DisableCustomizing = True
      DisableDragging = True
      DisableEditor = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderAlignment = taCenter
      ReadOnly = True
      Width = 259
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'FS_NAME'
      SummaryFooterType = cstCount
      SummaryFooterFormat = #39#1048#1090#1086#1075#1086': ('#1089#1091#1084#1084#1072' '#1089#1090#1088#1086#1082' 1 - '#39'#0'#39')'#39
    end
    object WHOLEColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1089#1077#1075#1086
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WHOLE'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object WUColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1077#1076#1091#1097#1080#1093' '#1074#1086#1080#1085#1089#1082#1080#1081' '#1091#1095#1105#1090
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WU'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object BRONColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1077#1076#1091#1097#1080#1093' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 1
      RowIndex = 0
      FieldName = 'BRON'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object TOWN_WHOLEColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1089#1077#1075#1086
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 2
      RowIndex = 0
      FieldName = 'TOWN_WHOLE'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object TOWN_WUColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1077#1076#1091#1097#1080#1093' '#1074#1086#1080#1085#1089#1082#1080#1081' '#1091#1095#1105#1090
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 2
      RowIndex = 0
      FieldName = 'TOWN_WU'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object TOWN_BRONColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1077#1076#1091#1097#1080#1093' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 2
      RowIndex = 0
      FieldName = 'TOWN_BRON'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object VILLAGE_WHOLEColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1089#1077#1075#1086
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 3
      RowIndex = 0
      FieldName = 'VILLAGE_WHOLE'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object VILLAGE_WUColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1077#1076#1091#1097#1080#1093' '#1074#1086#1080#1085#1089#1082#1080#1081' '#1091#1095#1105#1090
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 3
      RowIndex = 0
      FieldName = 'VILLAGE_WU'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object VILLAGE_BRONColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1077#1076#1091#1097#1080#1093' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 3
      RowIndex = 0
      FieldName = 'VILLAGE_BRON'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object dxDBGridColumn12: TdxDBGridColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'KOD'
    end
  end
  object dsData: TDataSource
    DataSet = qrData
    Left = 144
    Top = 208
  end
  object ActionList: TActionList
    Images = dmMain.ilSmall
    Left = 184
    Top = 208
    object actGenerate: TAction
      Caption = '&'#1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      Hint = 
        #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1072#1075#1088#1077#1075#1080#1088#1086#1074#1072#1085#1085#1091#1102' '#1092#1086#1088#1084#1091' '#1087#1086' '#1074#1080#1076#1072#1084' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1086#1081' '#1076#1077#1103#1090#1077#1083#1100 +
        #1085#1086#1089#1090#1080
      ImageIndex = 40
      OnExecute = actGenerateExecute
    end
    object actPrint: TAction
      Caption = '&'#1054#1090#1095#1077#1090
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1092#1086#1088#1084#1091' '#1074' '#1090#1077#1082#1089#1090#1086#1074#1099#1081' '#1088#1077#1076#1072#1082#1090#1086#1088
      ImageIndex = 37
      OnExecute = actPrintExecute
    end
    object actClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1086#1088#1084#1091
      ImageIndex = 4
      OnExecute = actClearExecute
    end
    object actCreate: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1087#1091#1089#1090#1091#1102' '#1092#1086#1088#1084#1091
      ImageIndex = 21
      OnExecute = actCreateExecute
    end
    object actExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1090#1072#1073#1083#1080#1094#1099' '#1074' Microsoft Excel'
      ImageIndex = 43
      OnExecute = actExcelExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 224
    Top = 208
    object N1: TMenuItem
      Action = actGenerate
    end
    object N3: TMenuItem
      Action = actCreate
    end
    object N2: TMenuItem
      Action = actClear
    end
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    OnCalcFields = qrDataCalcFields
    Parameters = <
      item
        Name = 'SUBJ_ID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  [SUBJ_ID], [FS_ID],[FS_NAME],[KOD]'
      ', [WHOLE], [WU], [BRON]'
      ', [TOWN_WHOLE], [TOWN_WU], [TOWN_BRON]'
      ', [VILLAGE_WHOLE], [VILLAGE_WU], [VILLAGE_BRON]'
      'FROM FFS F'
      'where F.SUBJ_ID = :SUBJ_ID'
      'ORDER BY KOD')
    Left = 104
    Top = 208
    object qrDataFS_ID: TIntegerField
      FieldName = 'FS_ID'
    end
    object qrDataFS_NAME: TStringField
      FieldName = 'FS_NAME'
      Size = 100
    end
    object qrDataWHOLE: TIntegerField
      FieldName = 'WHOLE'
    end
    object qrDataWU: TIntegerField
      FieldName = 'WU'
    end
    object qrDataBRON: TIntegerField
      FieldName = 'BRON'
    end
    object qrDataTOWN_WHOLE: TIntegerField
      FieldName = 'TOWN_WHOLE'
    end
    object qrDataTOWN_WU: TIntegerField
      FieldName = 'TOWN_WU'
    end
    object qrDataTOWN_BRON: TIntegerField
      FieldName = 'TOWN_BRON'
    end
    object qrDataVILLAGE_WHOLE: TIntegerField
      FieldName = 'VILLAGE_WHOLE'
    end
    object qrDataVILLAGE_WU: TIntegerField
      FieldName = 'VILLAGE_WU'
    end
    object qrDataVILLAGE_BRON: TIntegerField
      FieldName = 'VILLAGE_BRON'
    end
    object qrDataKOD: TStringField
      FieldName = 'KOD'
      Size = 2
    end
    object qrDataNPP: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'NPP'
      Calculated = True
    end
  end
  object sp_FFSCreate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FFSCreate'
    Parameters = <
      item
        Name = '@SUBJ_ID'
        DataType = ftInteger
        Value = Null
      end>
    Left = 236
    Top = 96
  end
  object sp_FFSClear: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FFSClear'
    Parameters = <
      item
        Name = '@SUBJ_ID'
        DataType = ftInteger
        Value = Null
      end>
    Left = 300
    Top = 132
  end
  object sp_FFSGenerate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FFSGenerate'
    Parameters = <
      item
        Name = '@SUBJ_ID'
        DataType = ftInteger
        Value = Null
      end
      item
        Name = '@FilterType'
        DataType = ftInteger
        Value = Null
      end>
    Left = 364
    Top = 96
  end
end

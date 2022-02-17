object fmFOKVED: TfmFOKVED
  Left = 264
  Top = 179
  Width = 800
  Height = 480
  HelpContext = 519
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086' '#1095#1080#1089#1083#1077#1085#1085#1086#1089#1090#1080' '#1087#1086' '#1074#1080#1076#1072#1084' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1086#1081' '#1076#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1080
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
    Width = 792
    Height = 26
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 22
        Width = 788
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
    Width = 792
    Height = 420
    Bands = <
      item
        DisableCustomizing = True
        DisableDragging = True
        OnlyOwnColumns = True
        Width = 412
      end>
    DefaultLayout = False
    HeaderMinRowCount = 2
    HeaderPanelRowCount = 1
    KeyField = 'N'
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
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -8
    BandFont.Name = 'Small Fonts'
    BandFont.Style = []
    DataSource = dsData
    Filter.Criteria = {00000000}
    FixedBandLineWidth = 1
    HeaderFont.Charset = RUSSIAN_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    OptionsCustomize = [edgoBandSizing, edgoColumnSizing]
    OptionsDB = [edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
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
      FieldName = 'N'
    end
    object KBONH_NAMEColumn: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #1056#1072#1079#1076#1077#1083#1099' '#1054#1050#1042#1069#1044
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
      FieldName = 'SECTION'
      SummaryFooterType = cstMax
      SummaryFooterField = 'N'
      SummaryFooterFormat = #39#1048#1090#1086#1075#1086': ('#1089#1091#1084#1084#1072' '#1089#1090#1088#1086#1082' 1 - '#39'#0'#39')'#39
    end
    object ORG_COUNTColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1074#1089#1077#1075#1086
      HeaderAlignment = taCenter
      Width = 75
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ORG_COUNT'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object ORG_WU_COUNTColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1077#1076#1091#1097#1080#1093' '#1074#1086#1080#1085#1089#1082#1080#1081' '#1091#1095#1105#1090
      HeaderAlignment = taCenter
      Width = 83
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ORG_WU_COUNT'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object ORG_BRON_COUNTColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074#1077#1076#1091#1097#1080#1093' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 85
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ORG_BRON_COUNT'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object RAB_COUNTColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042#1089#1077#1075#1086' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093
      DisableCustomizing = True
      DisableDragging = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderAlignment = taCenter
      Width = 75
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'RAB_COUNT'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object ZAP_COUNTColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074' '#1090'.'#1095'.'#10#1075#1088#1072#1078#1076#1072#1085' '#1079#1072#1087#1072#1089#1072
      DisableCustomizing = True
      DisableDragging = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderAlignment = taCenter
      Width = 92
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'ZAP_COUNT'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object ZAB_COUNTColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074' '#1090'.'#1095'.'#10#1079#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1086
      DisableCustomizing = True
      DisableDragging = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderAlignment = taCenter
      Width = 86
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'ZAB_COUNT'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
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
      'select F.SUBJ_ID, F.OKVED_SECTION,'
      ' F.ORG_COUNT, F.ORG_BRON_COUNT, F.ORG_WU_COUNT,'
      ' F.RAB_COUNT, F.ZAP_COUNT, F.ZAB_COUNT'
      'from FOKVED F'
      'where F.SUBJ_ID = :SUBJ_ID'
      'order by ASCII(F.OKVED_SECTION)')
    Left = 104
    Top = 208
    object qrDataOKVED_SECTION: TStringField
      FieldName = 'OKVED_SECTION'
      Size = 1
    end
    object qrDataN: TIntegerField
      FieldKind = fkLookup
      FieldName = 'N'
      LookupDataSet = qrKOKVED
      LookupKeyFields = 'OKVED_SECTION'
      LookupResultField = 'N'
      KeyFields = 'OKVED_SECTION'
      Lookup = True
    end
    object qrDataSECTION: TStringField
      FieldKind = fkLookup
      FieldName = 'SECTION'
      LookupDataSet = qrKOKVED
      LookupKeyFields = 'OKVED_SECTION'
      LookupResultField = 'SECTION'
      KeyFields = 'OKVED_SECTION'
      Size = 300
      Lookup = True
    end
    object qrDataORG_COUNT: TIntegerField
      FieldName = 'ORG_COUNT'
    end
    object qrDataORG_BRON_COUNT: TIntegerField
      FieldName = 'ORG_BRON_COUNT'
    end
    object qrDataORG_WU_COUNT: TIntegerField
      FieldName = 'ORG_WU_COUNT'
    end
    object qrDataRAB_COUNT: TIntegerField
      FieldName = 'RAB_COUNT'
    end
    object qrDataZAP_COUNT: TIntegerField
      FieldName = 'ZAP_COUNT'
    end
    object qrDataZAB_COUNT: TIntegerField
      FieldName = 'ZAB_COUNT'
    end
  end
  object sp_FOKVEDCreate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FOKVEDCreate'
    Parameters = <
      item
        Name = '@Subj_ID'
        DataType = ftInteger
        Value = Null
      end>
    Left = 236
    Top = 96
  end
  object sp_FOKVEDClear: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FOKVEDClear'
    Parameters = <
      item
        Name = '@SUBJ_ID'
        DataType = ftInteger
        Value = Null
      end>
    Left = 304
    Top = 148
  end
  object sp_FOKVEDGenerate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FOKVEDGenerate'
    Parameters = <
      item
        Name = '@SUBJ_ID'
        DataType = ftInteger
        Value = Null
      end
      item
        Name = '@IS_FULL'
        DataType = ftInteger
        Value = Null
      end
      item
        Name = '@FilterType'
        DataType = ftInteger
        Value = Null
      end>
    Left = 384
    Top = 104
  end
  object qrKOKVED: TADOQuery
    Connection = dmMain.dbMain
    Parameters = <>
    SQL.Strings = (
      'SELECT OKVED_SECTION, N, '
      'OKVED_SECTION+'#39'.'#39'+OKVED_SECTION_NAME AS SECTION'
      'FROM KOKVED_')
    Left = 336
    Top = 204
    object qrKOKVEDOKVED_SECTION: TStringField
      FieldName = 'OKVED_SECTION'
      Size = 1
    end
    object qrKOKVEDN: TIntegerField
      FieldName = 'N'
    end
    object qrKOKVEDSECTION: TStringField
      FieldName = 'SECTION'
      Size = 300
    end
  end
end

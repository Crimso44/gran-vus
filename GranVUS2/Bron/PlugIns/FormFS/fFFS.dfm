object fmFFS: TfmFFS
  Left = 330
  Top = 178
  HelpContext = 18
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1093' '#1087#1086' '#1074#1080#1076#1072#1084' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
  ClientHeight = 446
  ClientWidth = 774
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 774
    Height = 22
    AutoSize = True
    ButtonWidth = 103
    Caption = 'ToolBar1'
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
      Left = 103
      Top = 0
      Action = actCreate
    end
    object ToolButton1: TToolButton
      Left = 206
      Top = 0
      Action = actGenerate
    end
    object ToolButton5: TToolButton
      Left = 309
      Top = 0
      Action = actExcel
    end
    object ToolButton3: TToolButton
      Left = 412
      Top = 0
      Action = actPrint
    end
  end
  object dxDBGrid: TdxDBGrid
    Left = 0
    Top = 22
    Width = 774
    Height = 424
    Bands = <
      item
        DisableCustomizing = True
        DisableDragging = True
        Fixed = bfLeft
        OnlyOwnColumns = True
        Width = 412
      end
      item
      end
      item
        Caption = #1042' '#1084#1091#1085#1080#1094#1080#1087#1072#1083#1100#1085#1099#1093' '#1088#1072#1081#1086#1085#1072#1093
      end
      item
      end>
    DefaultLayout = False
    HeaderMinRowCount = 3
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
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
    object ALLColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1048#1090#1086#1075#1086
      Color = clBtnFace
      DisableEditor = True
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 1
      RowIndex = 0
      FieldName = 'ALL'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object CITYColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042' '#1075#1086#1088#1086#1076#1089#1082#1080#1093' '#1054#1082#1088#1091#1075#1072#1093
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 1
      RowIndex = 0
      FieldName = 'CITY'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object ALLTOWNVILLAGEColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042#1089#1077#1075#1086
      Color = clBtnFace
      DisableEditor = True
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 2
      RowIndex = 0
      FieldName = 'ALLTOWNVILLAGE'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object TOWNColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074' '#1075#1086#1088#1086#1076#1089#1082#1080#1093' '#1087#1086#1089#1077#1083#1077#1085#1080#1103#1093
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 2
      RowIndex = 0
      FieldName = 'TOWN'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object VILLAGEColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1074' '#1089#1077#1083#1100#1089#1082#1080#1093' '#1087#1086#1089#1077#1083#1077#1085#1080#1103#1093
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 2
      RowIndex = 0
      FieldName = 'VILLAGE'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object TOWNVILLAGEColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1085#1072' '#1084#1077#1078#1089#1077#1083#1105#1085#1085#1099#1093' '#1090#1077#1088#1088#1080#1090#1086#1088#1080#1103#1093
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 2
      RowIndex = 0
      FieldName = 'TOWNVILLAGE'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
    object INCITYColumn: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1053#1072' '#1074#1085#1091#1090#1088#1080#1075#1086#1088#1086#1076#1089#1082#1080#1093' '#1090#1077#1088#1088#1080#1090#1086#1088#1080#1103#1093' '#1075#1086#1088#1086#1076#1086#1074' '#1092#1077#1076#1077#1088#1072#1083#1100#1085#1086#1075#1086' '#1055#1086#1076#1095#1080#1085#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Width = 150
      BandIndex = 3
      RowIndex = 0
      FieldName = 'INCITY'
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
      ', [CITY], [TOWN], [VILLAGE]'
      ', [TOWNVILLAGE], [INCITY]'
      'FROM FFS2010 F'
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
    object qrDataCITY: TIntegerField
      FieldName = 'CITY'
    end
    object qrDataTOWN: TIntegerField
      FieldName = 'TOWN'
    end
    object qrDataVILLAGE: TIntegerField
      FieldName = 'VILLAGE'
    end
    object qrDataTOWNVILLAGE: TIntegerField
      FieldName = 'TOWNVILLAGE'
    end
    object qrDataINCITY: TIntegerField
      FieldName = 'INCITY'
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
    object qrDataALL: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ALL'
      Calculated = True
    end
    object qrDataALLTOWNVILLAGE: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'ALLTOWNVILLAGE'
      Calculated = True
    end
  end
  object sp_FFSCreate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FFS2010Create'
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
    Left = 236
    Top = 96
  end
  object sp_FFSClear: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FFS2010Clear'
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
    Left = 300
    Top = 132
  end
  object sp_FFSGenerate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FFS2010Generate'
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
      end
      item
        Name = '@FilterType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 364
    Top = 96
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 100
    Top = 92
  end
end

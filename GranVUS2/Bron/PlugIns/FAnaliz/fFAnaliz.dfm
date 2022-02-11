object fmFSVT: TfmFSVT
  Left = 264
  Top = 179
  HelpContext = 17
  Caption = #1040#1085#1072#1083#1080#1079' '#1086#1073#1077#1089#1087#1077#1095#1077#1085#1085#1086#1089#1090#1080' '#1090#1088#1091#1076#1086#1074#1099#1084#1080' '#1088#1077#1089#1091#1088#1089#1072#1084#1080
  ClientHeight = 446
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -7
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
    Width = 792
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
    object ToolButton3: TToolButton
      Left = 206
      Top = 0
      Action = actPrint
    end
    object ToolButton1: TToolButton
      Left = 309
      Top = 0
      Action = actGenerate
    end
    object ToolButton6: TToolButton
      Left = 412
      Top = 0
      Action = actCheck
    end
    object ToolButton5: TToolButton
      Left = 515
      Top = 0
      Action = actExcel
    end
  end
  object dxDBGrid: TdxDBGrid
    Left = 0
    Top = 22
    Width = 792
    Height = 424
    Bands = <
      item
        DisableCustomizing = True
        DisableDragging = True
        OnlyOwnColumns = True
        Width = 412
      end>
    DefaultLayout = False
    HeaderPanelRowCount = 1
    KeyField = 'NUM'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -7
    BandFont.Name = 'MS Sans Serif'
    BandFont.Style = []
    DataSource = dsData
    Filter.Criteria = {00000000}
    FixedBandLineWidth = 1
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -7
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    OptionsCustomize = [edgoBandSizing, edgoColumnSizing, edgoRowSizing]
    OptionsDB = [edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -7
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    OnColumnSorting = dxDBGridColumnSorting
    OnCustomDrawCell = dxDBGridCustomDrawCell
    OnEdited = dxDBGridEdited
    OnEditing = dxDBGridEditing
    object dxDBGridNUM: TdxDBGridColumn
      Visible = False
      Width = 59
      BandIndex = 0
      RowIndex = 0
      FieldName = 'NUM'
    end
    object NAMEColumn: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #1055#1086#1082#1072#1079#1072#1090#1077#1083#1080
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
      FieldName = 'NAME'
      SummaryFooterType = cstMax
      SummaryFooterField = 'SUBJ_ID'
      SummaryFooterFormat = #39#1048#1090#1086#1075#1086':'#39
    end
    object dxDBGridN01: TdxDBGridMaskColumn
      Caption = #1042#1089#1077#1075#1086' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N01'
    end
    object dxDBGridN02: TdxDBGridMaskColumn
      Caption = #1043#1055#1047
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N02'
    end
    object dxDBGridN06: TdxDBGridColumn
      Caption = #1047#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1086' '#1075#1088#1072#1078#1076#1072#1085', '#1087#1088#1077#1073#1099#1074#1072#1102#1097#1080#1093' '#1074' '#1079#1072#1087#1072#1089#1077
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N06'
    end
    object dxDBGridN10: TdxDBGridMaskColumn
      Caption = #1055#1086#1076#1083#1077#1078#1080#1090' '#1087#1088#1080#1079#1099#1074#1091
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N10'
    end
    object dxDBGridN01_10: TdxDBGridColumn
      Caption = #1054#1089#1090#1072#1077#1090#1089#1103' '#1074' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      Color = clSilver
      DisableEditor = True
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N01_10'
    end
    object dxDBGridN12: TdxDBGridMaskColumn
      Caption = #1055#1086#1090#1088#1077#1073#1085#1086#1089#1090#1100
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N12'
    end
    object dxDBGridN01_10_12: TdxDBGridColumn
      Caption = #1053#1077#1082#1086#1084#1087#1083#1077#1082#1090'/'#1048#1079#1073#1099#1090#1086#1082
      Color = clSilver
      DisableEditor = True
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N01_10_12'
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
    object actCheck: TAction
      Caption = #1055'&'#1088#1086#1074#1077#1088#1082#1072
      ImageIndex = 23
      Visible = False
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
    BeforePost = qrDataBeforePost
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
      'declare @SUBJ_ID int'
      'set @SUBJ_ID = :SUBJ_ID'
      ''
      'select *'
      'from FAnaliz F'
      'where F.SUBJ_ID = @SUBJ_ID')
    Left = 104
    Top = 208
    object qrDataSUBJ_ID: TIntegerField
      FieldName = 'SUBJ_ID'
    end
    object qrDataNUM: TIntegerField
      FieldName = 'NUM'
    end
    object qrDataNAME: TStringField
      DisplayWidth = 500
      FieldKind = fkLookup
      FieldName = 'NAME'
      LookupDataSet = qrKAnaliz
      LookupKeyFields = 'NUM'
      LookupResultField = 'NAME'
      KeyFields = 'NUM'
      Size = 500
      Lookup = True
    end
    object qrDataN01: TIntegerField
      FieldName = 'N01'
    end
    object qrDataN02: TIntegerField
      FieldName = 'N02'
    end
    object qrDataN06: TIntegerField
      FieldName = 'N06'
    end
    object qrDataN10: TIntegerField
      FieldName = 'N10'
    end
    object qrDataN12: TIntegerField
      FieldName = 'N12'
    end
    object qrDataN01_10: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'N01_10'
      Calculated = True
    end
    object qrDataN01_10_12: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'N01_10_12'
      Calculated = True
    end
  end
  object sp_FAnalizCreate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FAnalizCreate;1'
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
  object sp_FAnalizClear: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FAnalizClear;1'
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
    Left = 304
    Top = 148
  end
  object sp_FAnalizGenerate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FAnalizGenerate;1'
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
        Name = '@IS_FULL'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@FilterType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 384
    Top = 104
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 100
    Top = 92
  end
  object qrKAnaliz: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      #9'f.CPROF_ID NUM,'
      #9'case when SubString(f.PRINT_NAME,1,5)='#39#1042#1057#1045#1043#1054#39' then '#39#1042#1057#1045#1043#1054#39' '
      #9#9'else f.PRINT_NAME end As NAME'
      'FROM KCProf f'
      'WHERE f.CPROF_ID in (100,200,300,400,410,1000)'
      'ORDER BY f.CPROF_ID')
    Left = 336
    Top = 204
    object qrKAnalizNUM: TIntegerField
      FieldName = 'NUM'
      ReadOnly = True
    end
    object qrKAnalizNAME: TStringField
      FieldName = 'NAME'
      ReadOnly = True
      Size = 30
    end
  end
end

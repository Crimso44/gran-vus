object fmF6List: TfmF6List
  Left = 290
  Top = 177
  HelpContext = 16
  Caption = #1057#1087#1080#1089#1086#1082' '#1072#1075#1088#1077#1075#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1092#1086#1088#1084' '#8470' 6'
  ClientHeight = 435
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 416
    Width = 642
    Height = 19
    Panels = <>
  end
  object dbgData: TdxDBGrid
    Left = 0
    Top = 44
    Width = 642
    Height = 372
    Bands = <
      item
      end>
    DefaultLayout = False
    HeaderMinRowCount = 3
    HeaderPanelRowCount = 1
    KeyField = 'F6_ID'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 1
    DataSource = DataSource1
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoAutoSort, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords]
    OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoRowAutoHeight, edgoUseBitmap]
    object dbgDataColumn3: TdxDBGridColumn
      Caption = #1064#1080#1092#1088' '#1092#1086#1088#1084#1099
      DisableEditor = True
      Sizing = False
      Sorted = csUp
      Width = 95
      BandIndex = 0
      RowIndex = 0
      FieldName = 'F6_SHIFR'
    end
    object dbgDataColumn10: TdxDBGridColumn
      Caption = #1064#1080#1092#1088' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      Sizing = False
      Width = 91
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ORG_SHIFR'
    end
    object dbgDataColumn11: TdxDBGridColumn
      Caption = #1063#1080#1089#1083#1086' '#1086#1073#1086#1073#1097#1077#1085#1085#1099#1093' '#1092#1086#1088#1084' '#8470' 6'
      Sizing = False
      Width = 102
      BandIndex = 0
      RowIndex = 0
      FieldName = 'F6_COUNT'
    end
    object dbgDataColumn12: TdxDBGridColumn
      Caption = #1063#1080#1089#1083#1086' '#1086#1073#1086#1073#1097#1077#1085#1085#1099#1093' '#1050#1059#1054
      Sizing = False
      Width = 119
      BandIndex = 0
      RowIndex = 0
      FieldName = 'KUO_COUNT'
    end
    object dbgDataColumn6: TdxDBGridCheckColumn
      Alignment = taCenter
      Caption = #1055#1088#1086#1074#1077#1088#1077#1085#1086
      DisableEditor = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 68
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Checked'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDataColumn7: TdxDBGridMaskColumn
      DisableEditor = True
      Width = 150
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Comment'
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 642
    Height = 44
    AutoSize = True
    ButtonWidth = 104
    Caption = 'ToolBar1'
    Images = dmMain.ilSmall
    List = True
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = actClear
    end
    object ToolButton3: TToolButton
      Left = 104
      Top = 0
      Action = actCreate
    end
    object ToolButton4: TToolButton
      Left = 208
      Top = 0
      Action = actEdit
    end
    object ToolButton6: TToolButton
      Left = 312
      Top = 0
      Action = actView
      Wrap = True
    end
    object ToolButton2: TToolButton
      Left = 0
      Top = 22
      Action = actGenerate
    end
    object ToolButton5: TToolButton
      Left = 104
      Top = 22
      Action = actPrint
    end
    object ToolButton7: TToolButton
      Left = 208
      Top = 22
      Action = actPrintF5
    end
  end
  object ActionList1: TActionList
    Left = 392
    Top = 60
    object actClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1092#1086#1088#1084#1099' '#8470' 6 '#1089#1091#1073#1098#1077#1082#1090#1072
      ImageIndex = 4
      OnExecute = actClearExecute
    end
    object actGenerate: TAction
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      Hint = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1072#1075#1088#1077#1075#1080#1088#1086#1074#1072#1085#1085#1091#1102' '#1060#1086#1088#1084#1091' '#8470' 6'
      ImageIndex = 40
      OnExecute = actGenerateExecute
      OnUpdate = actGenerateUpdate
    end
    object actCreate: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1087#1091#1089#1090#1099#1077' '#1092#1086#1088#1084#1099' '#8470' 6'
      ImageIndex = 21
      OnExecute = actCreateExecute
    end
    object actEdit: TAction
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1092#1086#1088#1084#1091' '#8470' 6'
      ImageIndex = 9
      OnExecute = actEditExecute
      OnUpdate = actEditUpdate
    end
    object actPrint: TAction
      Caption = #1055#1077#1095#1072#1090#1100' ('#1092'.6)'
      Hint = #1055#1077#1095#1072#1090#1072#1090#1100' '#1092#1086#1088#1084#1091' '#8470' 6'
      ImageIndex = 37
      OnExecute = actPrintExecute
    end
    object actPrintF5: TAction
      Caption = #1055#1077#1095#1072#1090#1100' ('#1092'.5)'
      Hint = #1055#1077#1095#1072#1090#1072#1090#1100' '#1092#1086#1088#1084#1091' '#8470' 5'
      ImageIndex = 37
      OnExecute = actPrintF5Execute
    end
    object actView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1092#1086#1088#1084#1091' '#8470' 6'
      ImageIndex = 36
      OnExecute = actViewExecute
    end
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 32
    Top = 272
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    OnCalcFields = qrDataCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM FORM6HDR'
      'WHERE ORGID IS NULL')
    Left = 380
    Top = 116
    object qrDataF6_ID: TAutoIncField
      FieldName = 'F6_ID'
      ReadOnly = True
    end
    object qrDataORGID: TIntegerField
      FieldName = 'ORGID'
    end
    object qrDataORGNAME: TStringField
      FieldName = 'ORGNAME'
      Size = 250
    end
    object qrDataF6_SHIFR: TStringField
      FieldName = 'F6_SHIFR'
      Size = 2
    end
    object qrDataORG_SHIFR: TStringField
      FieldName = 'ORG_SHIFR'
      Size = 10
    end
    object qrDataF6_COUNT: TIntegerField
      FieldName = 'F6_COUNT'
    end
    object qrDataKUO_COUNT: TIntegerField
      FieldName = 'KUO_COUNT'
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
    object qrDataCHECKED: TBooleanField
      FieldName = 'CHECKED'
    end
    object qrDataCONFDATE: TDateTimeField
      FieldName = 'CONFDATE'
    end
    object qrDataSUBJ_ID: TIntegerField
      FieldName = 'SUBJ_ID'
    end
    object qrDataComment: TStringField
      DisplayLabel = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
      DisplayWidth = 150
      FieldKind = fkCalculated
      FieldName = 'Comment'
      Size = 1000
      Calculated = True
    end
  end
  object DataSource1: TDataSource
    DataSet = qrData
    Left = 424
    Top = 168
  end
  object PopupMenu1: TPopupMenu
    Left = 124
    Top = 108
    object N3: TMenuItem
      Action = actClear
    end
    object N1: TMenuItem
      Action = actCreate
    end
    object N2: TMenuItem
      Action = actEdit
    end
    object N5: TMenuItem
      Action = actView
    end
    object N61: TMenuItem
      Action = actGenerate
    end
    object N4: TMenuItem
      Action = actPrint
    end
  end
  object sp_Form6Clear: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_Form6Clear;1'
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
  object sp_GenerateResultForm6: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_GenerateResultForm6;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@F6_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 216
    Top = 192
  end
  object sp_Form6Create: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_Form6Create;1'
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
    Left = 256
    Top = 152
  end
end

object frmReplacePlan: TfrmReplacePlan
  Left = 0
  Top = 0
  Caption = #1055#1083#1072#1085' '#1079#1072#1084#1077#1085#1099' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1086#1074', '#1087#1088#1080#1079#1099#1074#1072#1077#1084#1099#1093' '#1087#1086' '#1084#1086#1073#1080#1083#1080#1079#1072#1094#1080#1080
  ClientHeight = 460
  ClientWidth = 855
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 855
    Height = 24
    Caption = 'ToolBar1'
    Images = dmMain.ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object bSave: TToolButton
      Left = 0
      Top = 0
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      Caption = 'bSave'
      ImageIndex = 0
      OnClick = bSaveClick
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'ToolButton2'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object bPrint: TToolButton
      Left = 31
      Top = 0
      Hint = #1055#1077#1095#1072#1090#1100
      Caption = 'bPrint'
      ImageIndex = 1
      OnClick = bPrintClick
    end
    object bExcel: TToolButton
      Left = 54
      Top = 0
      Hint = #1042#1099#1074#1086#1076' '#1074' Excel'
      Caption = 'bExcel'
      ImageIndex = 2
      OnClick = bExcelClick
    end
  end
  object MainGrid: TdxDBGrid
    Left = 0
    Top = 24
    Width = 855
    Height = 436
    BandRowCount = 2
    Bands = <
      item
        Caption = 
          #1043#1088#1072#1078#1076#1072#1085#1077', '#1087#1088#1077#1073#1099#1074#1072#1102#1097#1080#1077' '#1074' '#1079#1072#1087#1072#1089#1077', '#1087#1086#1076#1083#1077#1078#1072#1097#1080#1077' '#1087#1088#1080#1079#1099#1074#1091' '#1087#1086' '#1084#1086#1073#1080#1083#1080#1079#1072#1094#1080 +
          #1080' '#1080' '#1074' '#1074#1086#1077#1085#1085#1086#1077' '#1074#1088#1077#1084#1103
      end
      item
        Caption = #1050#1077#1084' '#1079#1072#1084#1077#1085#1103#1077#1090#1089#1103
        Width = 530
      end>
    DefaultLayout = False
    HeaderMinRowCount = 2
    HeaderPanelRowCount = 1
    KeyField = 'RecId'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    TabOrder = 1
    DataSource = dsGrid
    Filter.Criteria = {00000000}
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    ShowBands = True
    object MainGridPers_Dep: TdxDBGridMaskColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1083#1091#1078#1073', '#1087#1088#1086#1080#1079#1074#1086#1076#1089#1090#1074', '#1094#1077#1093#1086#1074
      DisableEditor = True
      HeaderAlignment = taCenter
      ReadOnly = True
      Sorted = csUp
      Visible = False
      Width = 100
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'Pers_Dep'
    end
    object MainGridPers_id: TdxDBGridMaskColumn
      DisableEditor = True
      HeaderAlignment = taCenter
      ReadOnly = True
      Visible = False
      Width = 100
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'Pers_id'
    end
    object MainGridPers_Post: TdxDBGridMaskColumn
      Caption = #1047#1072#1085#1080#1084#1072#1077#1084#1072#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
      DisableEditor = True
      HeaderAlignment = taCenter
      ReadOnly = True
      Width = 100
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'Pers_Post'
    end
    object MainGridPers_Fio: TdxDBGridMaskColumn
      Caption = #1060#1072#1084#1080#1083#1080#1103', '#1080#1084#1103', '#1086#1090#1095#1077#1089#1090#1074#1086
      DisableEditor = True
      HeaderAlignment = taCenter
      ReadOnly = True
      Width = 100
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'Pers_Fio'
    end
    object MainGridRepl_Id: TdxDBGridMaskColumn
      DisableEditor = True
      HeaderAlignment = taCenter
      ReadOnly = True
      Visible = False
      Width = 133
      BandIndex = 1
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'Repl_Id'
    end
    object MainGridRepl_Dep: TdxDBGridMaskColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1083#1091#1078#1073', '#1086#1090#1076#1077#1083#1086#1074
      HeaderAlignment = taCenter
      Width = 133
      BandIndex = 1
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'Repl_Dep'
    end
    object MainGridRepl_Post: TdxDBGridMaskColumn
      Caption = #1047#1072#1085#1080#1084#1072#1077#1084#1072#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
      HeaderAlignment = taCenter
      Width = 133
      BandIndex = 1
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'Repl_Post'
    end
    object MainGridRepl_Fio: TdxDBGridButtonColumn
      Caption = #1060#1072#1084#1080#1083#1080#1103', '#1080#1084#1103', '#1086#1090#1095#1077#1089#1090#1074#1086
      HeaderAlignment = taCenter
      Width = 133
      BandIndex = 1
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'Repl_Fio'
      OnEditButtonClick = MainGridRepl_FioEditButtonClick
      Buttons = <
        item
          Default = True
        end>
    end
    object MainGridRepl_War: TdxDBGridMaskColumn
      Caption = #1054#1090#1085#1086#1096#1077#1085#1080#1077' '#1082' '#1074#1086#1077#1085#1085#1086#1081' '#1089#1083#1091#1078#1073#1077
      HeaderAlignment = taCenter
      Width = 133
      BandIndex = 1
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'Repl_War'
    end
    object MainGridRecId: TdxDBGridColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'RecId'
    end
  end
  object dsGrid: TDataSource
    DataSet = dmMain.mReplacePlan
    Left = 336
    Top = 232
  end
end

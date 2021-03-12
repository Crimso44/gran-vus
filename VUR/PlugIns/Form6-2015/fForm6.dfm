object Form6List: TForm6List
  Left = 326
  Top = 261
  HelpContext = 14
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 
    #1056#1072#1089#1095#1105#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1080' '#1086#1090#1085#1086#1096#1077#1085#1080#1102' '#1082' '#1074#1086#1080#1085#1089#1082#1086#1081' ' +
    #1086#1073#1103#1079#1072#1085#1085#1086#1089#1090#1080
  ClientHeight = 468
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object dxDBGrid: TdxDBGrid
    Left = 0
    Top = 22
    Width = 790
    Height = 427
    Bands = <
      item
        DisableCustomizing = True
        DisableDragging = True
        Fixed = bfLeft
        OnlyOwnColumns = True
        Sizing = False
        Width = 180
      end
      item
        DisableCustomizing = True
        DisableDragging = True
        OnlyOwnColumns = True
        Sizing = False
        Width = 80
      end
      item
        Caption = #1048#1079' '#1095#1080#1089#1083#1077#1085#1085#1086#1089#1090#1080' '#1074#1089#1077#1075#1086' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093' '#1075#1088#1072#1078#1076#1072#1085', '#1087#1088#1077#1073#1099#1074#1072#1102#1097#1080#1093' '#1074' '#1079#1072#1087#1072#1089#1077
        DisableCustomizing = True
        DisableDragging = True
        OnlyOwnColumns = True
        Sizing = False
        Width = 261
      end
      item
        Caption = #1048#1079' '#1095#1080#1089#1083#1077#1085#1085#1086#1089#1090#1080' '#1075#1088#1072#1078#1076#1072#1085', '#1087#1088#1077#1073#1099#1074#1072#1102#1097#1080#1093' '#1074' '#1079#1072#1087#1072#1089#1077', '#1079#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1086
        DisableCustomizing = True
        DisableDragging = True
        OnlyOwnColumns = True
        Sizing = False
      end
      item
      end
      item
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
        DisableCustomizing = True
        DisableDragging = True
        OnlyOwnColumns = True
        Sizing = False
      end>
    DefaultLayout = False
    HeaderMinRowCount = 9
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
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
    TabOrder = 0
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -8
    BandFont.Name = 'Small Fonts'
    BandFont.Style = []
    DataSource = Form6DataSource
    Filter.Criteria = {00000000}
    FixedBandLineWidth = 1
    GridLineColor = clBtnShadow
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -8
    HeaderFont.Name = 'Small Fonts'
    HeaderFont.Style = []
    OptionsCustomize = [edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoUseBookmarks]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    ShowBands = True
    OnCustomDrawCell = dxDBGridCustomDrawCell
    OnEdited = dxDBGridEdited
    OnEditing = dxDBGridEditing
    object PRINT_NAMEColumn: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = 
        #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1082#1072#1090#1077#1075#1086#1088#1080#1081' '#1076#1086#1083#1078#1085#1086#1089#1090#1077#1081#10' '#1089#1083#1091#1078#1072#1097#1080#1093' '#1080' '#1087#1088#1086#1092#1077#1089#1089#1080#1081' '#1088#1072#1073#1086#1095#1080#1093#10 +
        #10#10#10#10#10#10'(1)'
      Color = clBtnFace
      DisableCustomizing = True
      DisableDragging = True
      DisableEditor = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      HeaderAlignment = taCenter
      ReadOnly = True
      Sizing = False
      Width = 190
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'CPROF_NAME'
    end
    object COL_BColumn: TdxDBGridColumn
      Alignment = taCenter
      Caption = #8470#10#1089#1090#1088#1086#1082#1080#10#1087'/'#1087#10#10#10#10#10#10'('#1041')'
      Color = clBtnFace
      DisableCustomizing = True
      DisableDragging = True
      DisableEditor = True
      HeaderAlignment = taCenter
      ReadOnly = True
      Sizing = False
      Width = 39
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_B'
    end
    object COL_1Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042#1089#1077#1075#1086#10#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093#10#10#10#10#10#10#10'(2)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 80
      BandIndex = 1
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_1'
    end
    object COL_2Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042#1089#1077#1075#1086#10#10#10#10#10#10#10#10'(3)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 80
      BandIndex = 2
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_2'
    end
    object COL_3Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042' '#1090'.'#1095'.'#10#1086#1092#1080#1094#1077#1088#1086#1074#10#10#10#10#10#10#10'(4)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 80
      BandIndex = 2
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_3'
    end
    object COL_4Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = 
        #1042' '#1090'.'#1095'.'#10#1087#1088#1072#1087#1086#1088#1097#1080#1082#1086#1074','#10#1084#1080#1095#1084#1072#1085#1086#1074','#10#1089#1077#1088#1078#1072#1085#1090#1086#1074','#10' '#1089#1090#1072#1088#1096#1080#1085','#10#1089#1086#1083#1076#1072#1090' '#1080#10#1084#1072#1090#1088 +
        #1086#1089#1086#1074#10#10'(5)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 80
      BandIndex = 2
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_4'
    end
    object COL_6Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042#1089#1077#1075#1086#10#10#10#10#10#10#10#10'(6)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 80
      BandIndex = 3
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_6'
    end
    object COL_7Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042' '#1090'.'#1095'.'#10#1086#1092#1080#1094#1077#1088#1086#1074#10#10#10#10#10#10#10'(7)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 80
      BandIndex = 3
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_7'
    end
    object COL_8Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = 
        #1042' '#1090'.'#1095'.'#10#1087#1088#1072#1087#1086#1088#1097#1080#1082#1086#1074','#10#1084#1080#1095#1084#1072#1085#1086#1074','#10#1089#1077#1088#1078#1072#1085#1090#1086#1074','#10#1089#1090#1072#1088#1096#1080#1085', '#1089#1086#1083#1076#1072#1090#10#1080' '#1084#1072#1090#1088#1086 +
        #1089#1086#1074#10#10#10'(8)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 80
      BandIndex = 3
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_8'
    end
    object COL_10T: TdxDBGridColumn
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077#10#10#10#10#10#10#10#10'(9)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 4
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_10T'
    end
    object COL_10Column: TdxDBGridColumn
      Caption = #1063#1080#1089#1083#1077#1085#1085#1086#1089#1090#1100#10#1043#1055#1047', '#1080#1084#1077#1102#1097#1080#1093#10#1084#1086#1073#1080#1083#1080#1079#1072#1094#1080#1086#1085#1085#1099#1077#10#1087#1088#1077#1076#1087#1080#1089#1072#1085#1080#1103#10#10#10#10#10'(10)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 80
      BandIndex = 5
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_10'
    end
    object COL_11Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = 
        #1048#1079#10#1095#1080#1089#1083#1077#1085#1085#1086#1089#1090#1080#10#1074#1089#1077#1075#1086#10#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093#10#1075#1088#1072#1078#1076#1072#1085','#10#1087#1086#1076#1083#1077#1078#1072#1097#1080#1093#10#1087#1088#1080#1079#1099#1074#1091#10#10'(11' +
        ')'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 80
      BandIndex = 5
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_11'
    end
    object COL_12Column: TdxDBGridColumn
      Caption = #1055#1086#1090#1088#1077#1073#1085#1086#1089#1090#1100#10#1085#1072' '#1056#1043#10#10#10#10#10#10#10'(12)'
      DisableCustomizing = True
      DisableDragging = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 5
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_12'
    end
    object COL_5Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1063#1080#1089#1083#1077#1085#1085#1086#1089#1090#1100#10#1086#1075#1088#1072#1085#1080#1095#1077#1085#1085#1086' '#1075#1086#1076#1085#1099#1093#10#1084#1083#1072#1076#1096#1080#1093' '#1095#1080#1085#1086#1074#10#10#10#10#10#10'(13)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 100
      BandIndex = 5
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_5'
    end
    object COL_9Column: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1063#1080#1089#1083#1077#1085#1085#1086#1089#1090#1100#10#1086#1075#1088#1072#1085#1080#1095#1077#1085#1085#1086' '#1075#1086#1076#1085#1099#1093#10#1084#1083#1072#1076#1096#1080#1093' '#1095#1080#1085#1086#1074#10#10#10#10#10'(13)'
      DisableCustomizing = True
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Visible = False
      Width = 80
      BandIndex = 5
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_9'
    end
    object COL_EXPRColumn: TdxDBGridColumn
      Visible = False
      Width = 80
      BandIndex = 0
      RowIndex = 0
      FieldName = 'EXPRESSION'
    end
    object COL_CPROF_ID: TdxDBGridColumn
      Visible = False
      Width = 80
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CPROF_ID'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 449
    Width = 790
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 790
    Height = 22
    AutoSize = True
    Caption = 'ToolBar1'
    Images = dmMain.ImageList
    List = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object ToolButton3: TToolButton
      Left = 0
      Top = 0
      Action = ClearAction
    end
    object ToolButton5: TToolButton
      Left = 23
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 4
      Style = tbsSeparator
    end
    object Panel1: TPanel
      Left = 31
      Top = 0
      Width = 125
      Height = 22
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 5
        Top = 4
        Width = 78
        Height = 13
        Caption = #1056#1072#1089#1095#1105#1090#1085#1099#1081' '#1075#1086#1076':'
      end
      object edYear: TEdit
        Left = 88
        Top = 0
        Width = 33
        Height = 21
        ParentColor = True
        ReadOnly = True
        TabOrder = 0
        Text = '2000'
      end
    end
    object ToolButton1: TToolButton
      Left = 156
      Top = 0
      Action = GenerateAction
      AutoSize = True
    end
    object ToolButton6: TToolButton
      Left = 183
      Top = 0
      Action = CalcUpAction
      AutoSize = True
    end
    object ToolButton2: TToolButton
      Left = 210
      Top = 0
      Action = CheckAction
      AutoSize = True
    end
    object ToolButton4: TToolButton
      Left = 237
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 1
      Style = tbsSeparator
    end
    object tbCalcMode: TToolButton
      Left = 245
      Top = 0
      Hint = #1056#1077#1078#1080#1084' '#1088#1072#1089#1095#1105#1090#1072
      AutoSize = True
      DropdownMenu = PopupMenu2
      ImageIndex = 3
      Style = tbsDropDown
    end
  end
  object Form6DataSource: TDataSource
    DataSet = dmMain.Form6Query
    Left = 104
    Top = 208
  end
  object ActionList: TActionList
    Left = 184
    Top = 208
    object GenerateAction: TAction
      Caption = '&'#1056#1072#1089#1095#1105#1090' '#1087#1086' '#1082#1072#1088#1090#1086#1090#1077#1082#1077
      Hint = #1056#1072#1089#1095#1105#1090' '#1087#1086' '#1082#1072#1088#1090#1086#1090#1077#1082#1077
      ImageIndex = 4
      OnExecute = GenerateActionExecute
    end
    object PrintAction: TAction
      Caption = '&'#1055#1077#1095#1072#1090#1100
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1092#1086#1088#1084#1091' '#8470' 6 '#1074' '#1090#1077#1082#1089#1090#1086#1074#1099#1081' '#1088#1077#1076#1072#1082#1090#1086#1088
      ImageIndex = 0
      OnExecute = PrintActionExecute
    end
    object CheckAction: TAction
      Caption = #1055'&'#1088#1086#1074#1077#1088#1082#1072
      Hint = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1087#1088#1072#1074#1080#1083#1100#1085#1086#1089#1090#1100' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1103
      ImageIndex = 5
      OnExecute = CheckActionExecute
    end
    object CalcUpAction: TAction
      Caption = #1055#1077#1088#1077#1089#1095#1077#1090' '#1080#1090#1086#1075#1086#1074
      Hint = #1047#1072#1087#1086#1083#1085#1077#1085#1080#1077' '#1080#1090#1086#1075#1086#1074#1099#1093' '#1087#1086#1079#1080#1094#1080#1081' '#1089#1077#1090#1082#1080
      ImageIndex = 7
      OnExecute = CalcUpActionExecute
    end
    object ClearAction: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Hint = #1054#1073#1085#1091#1083#1080#1090#1100' '#1074#1089#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
      ImageIndex = 8
      OnExecute = ClearActionExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 224
    Top = 208
    object N1: TMenuItem
      Action = GenerateAction
    end
    object N3: TMenuItem
      Action = CheckAction
    end
    object N2: TMenuItem
      Action = PrintAction
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 368
    Top = 216
    object miRecalcCols: TMenuItem
      Caption = #1055#1077#1088#1077#1089#1095#1077#1090' '#1087#1086' '#1089#1090#1086#1083#1073#1094#1072#1084
      Checked = True
      OnClick = miRecalcRowsClick
    end
    object miRecalcRows: TMenuItem
      Caption = #1055#1077#1088#1077#1089#1095#1077#1090' '#1087#1086' '#1089#1090#1088#1086#1082#1072#1084
      Checked = True
      OnClick = miRecalcRowsClick
    end
  end
end

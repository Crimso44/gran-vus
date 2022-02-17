object fmOrgList: TfmOrgList
  Left = 254
  Top = 118
  HelpContext = 4
  Caption = #1050#1072#1088#1090#1086#1090#1077#1082#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
  ClientHeight = 498
  ClientWidth = 902
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
    Top = 479
    Width = 902
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object dbgData: TdxDBGrid
    Left = 0
    Top = 28
    Width = 902
    Height = 451
    Bands = <
      item
      end>
    DefaultLayout = False
    HeaderMinRowCount = 3
    HeaderPanelRowCount = 1
    KeyField = 'ORGID'
    PartialLoadBufferCount = 50
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 1
    OnDblClick = actEditExecute
    DataSource = DataSource1
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoAutoSearch, edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSelect, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoFullSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords]
    OptionsView = [edgoBandHeaderWidth, edgoIndicator, edgoUseBitmap]
    RegistryPath = '\Software\GRANVUS2\TfmOrgList'
    OnCustomDrawCell = dbgDataCustomDrawCell
    OnColumnClick = dbgDataColumnClick
    ExplicitTop = 22
    object gridTERR: TdxDBGridColumn
      Caption = #1042#1099#1096#1077#1089#1090#1086#1103#1097#1080#1081' '#1042#1059#1054' '#1082#1091#1088#1080#1088#1091#1077#1090
      HeaderAlignment = taCenter
      Width = 88
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'TERR'
    end
    object gridORGNAME: TdxDBGridColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 248
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'ORGNAME'
      GroupIndex = 0
    end
    object gridORGSNAME: TdxDBGridColumn
      Caption = #1050#1088#1072#1090#1082#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      HeaderAlignment = taCenter
      Visible = False
      Width = 248
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'ORGSNAME'
      GroupIndex = 0
    end
    object gridOKPO: TdxDBGridColumn
      Caption = #1054#1050#1055#1054
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'OKPO'
      GroupIndex = 0
    end
    object gridOKTMO: TdxDBGridColumn
      Caption = #1054#1050#1058#1052#1054
      HeaderAlignment = taCenter
      Visible = False
      Width = 60
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'KODOKTMO'
      GroupIndex = 0
    end
    object gridINN: TdxDBGridColumn
      Caption = #1048#1053#1053'/'#1050#1055#1055
      HeaderAlignment = taCenter
      Width = 73
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'INN'
      GroupIndex = 0
    end
    object gridOKBV: TdxDBGridColumn
      Caption = #1054#1050#1041#1042
      HeaderAlignment = taCenter
      Width = 72
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'OKBV'
      GroupIndex = 0
    end
    object gridURADDR: TdxDBGridColumn
      Caption = #1070#1088'. '#1072#1076#1088#1077#1089
      Width = 250
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'URADDR'
      GroupIndex = 0
    end
    object gridFIZADDR: TdxDBGridColumn
      Caption = #1060#1072#1082#1090'. '#1072#1076#1088#1077#1089
      Visible = False
      Width = 251
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'FIZADDR'
      GroupIndex = 0
    end
    object gridPOSTADDR: TdxDBGridColumn
      Caption = #1055#1086#1095#1090'. '#1072#1076#1088#1077#1089
      Visible = False
      Width = 251
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'POSTADDR'
      GroupIndex = 0
    end
    object gridPHONE: TdxDBGridColumn
      Caption = #1058#1077#1083#1077#1092#1086#1085
      Visible = False
      Width = 60
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'PHONE'
      GroupIndex = 0
    end
    object gridEmail: TdxDBGridColumn
      Caption = 'E-mail'
      Width = 100
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'EMAIL'
      GroupIndex = 0
    end
    object gridFIRST_DATE: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1087#1077#1088#1074#1080#1095#1085'. '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      Width = 67
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'FIRST_DATE'
      GroupIndex = 0
    end
    object gridLAST_DATE: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1087#1088#1080#1093#1086#1076#1072
      HeaderAlignment = taCenter
      Width = 67
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'LAST_DATE'
      GroupIndex = 0
    end
    object gridHAS_F6: TdxDBGridCheckColumn
      Caption = #1060'-6'
      HeaderAlignment = taCenter
      MinWidth = 20
      Width = 31
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'HAS_F6'
      ValueChecked = '1'
      GroupIndex = 0
      DisplayChecked = '0'
    end
    object gridPARENT: TdxDBGridColumn
      Caption = #1042#1099#1096#1077#1089#1090#1086#1103#1097#1072#1103' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
      HeaderAlignment = taCenter
      Width = 130
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'PARENT'
      GroupIndex = 0
    end
    object gridMAINOKONH: TdxDBGridColumn
      Caption = #1054#1089#1085'. '#1054#1050#1042#1069#1044
      HeaderAlignment = taCenter
      Width = 51
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'MAINOKONH'
      GroupIndex = 0
    end
    object gridKFS: TdxDBGridColumn
      Caption = #1054#1050#1060#1057
      HeaderAlignment = taCenter
      Width = 52
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'KFS'
      GroupIndex = 0
    end
    object gridKOPF: TdxDBGridColumn
      Caption = #1054#1050#1054#1055#1060
      HeaderAlignment = taCenter
      Width = 47
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'KOPF'
      GroupIndex = 0
    end
    object gridREG_PLACE: TdxDBGridColumn
      Caption = #1052#1077#1089#1090#1086' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      Width = 105
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'REG_PLACE'
      GroupIndex = 0
    end
    object gridCOMMENT: TdxDBGridColumn
      Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1103
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COMMENT'
      GroupIndex = 0
    end
    object gridOUT_DATE: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1089#1085#1103#1090#1080#1103' '#1089' '#1091#1095#1077#1090#1072
      HeaderAlignment = taCenter
      Width = 57
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'OUT_DATE'
      GroupIndex = 0
    end
    object gridSUBMISSION: TdxDBGridColumn
      Caption = #1055#1086#1076#1095#1080#1085#1077#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 150
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'SUBMISSION'
      GroupIndex = 0
    end
    object gridRAB_COUNT: TdxDBGridColumn
      Caption = #1042#1089#1077#1075#1086' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093
      HeaderAlignment = taCenter
      Width = 75
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'RAB_COUNT'
      GroupIndex = 0
    end
    object gridZAP_COUNT: TdxDBGridColumn
      Caption = #1048#1079' '#1085#1080#1093' '#1074' '#1079#1072#1087#1072#1089#1077
      HeaderAlignment = taCenter
      Width = 73
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'ZAP_COUNT'
      GroupIndex = 0
    end
    object gridZAB_COUNT: TdxDBGridColumn
      Caption = #1048#1079' '#1085#1080#1093' '#1079#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1086
      HeaderAlignment = taCenter
      Width = 82
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'ZAB_COUNT'
      GroupIndex = 0
    end
    object gridF6CHECKED: TdxDBGridCheckColumn
      Alignment = taLeftJustify
      Caption = #1060#1086#1088#1084#1072' 6 '#1087#1088#1086#1074#1077#1088#1077#1085#1072
      HeaderAlignment = taCenter
      Width = 59
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'F6CHECKED'
      ValueChecked = '1'
      GroupIndex = 0
      DisplayChecked = '0'
    end
    object gridHAS_BRON: TdxDBGridCheckColumn
      Caption = #1041#1088#1086#1085#1080#1088#1091#1077#1090
      HeaderAlignment = taCenter
      MinWidth = 20
      Width = 58
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'HAS_BRON'
      ValueChecked = '1'
      GroupIndex = 0
      DisplayChecked = '0'
    end
    object gridCHK_DATE: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1089#1074#1077#1088#1082#1080
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'CHK_DATE'
      UseEditMask = True
      GroupIndex = 0
    end
    object gridKodReg: TdxDBGridColumn
      Caption = #1054#1050#1040#1058#1054
      Width = 43
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'KodReg'
      GroupIndex = 0
    end
    object gridHEADFAM: TdxDBGridColumn
      Caption = #1060#1048#1054' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
      Width = 106
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'HEADFAM'
      GroupIndex = 0
    end
    object gridVURFAM: TdxDBGridColumn
      Caption = #1060#1048#1054' '#1042#1059#1056
      Width = 87
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'VURFAM'
      GroupIndex = 0
    end
    object gridHEADPHONE: TdxDBGridColumn
      Caption = #1058#1077#1083#1077#1092#1086#1085' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
      Width = 103
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'HEADPHONE'
      GroupIndex = 0
    end
    object gridVURPHONE: TdxDBGridColumn
      Caption = #1058#1077#1083#1077#1092#1086#1085' '#1042#1059#1056
      Width = 76
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'VURPHONE'
      GroupIndex = 0
    end
    object gridKOPF_Changed: TdxDBGridColumn
      DisableCustomizing = True
      Visible = False
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'KOPF_Changed'
      GroupIndex = 0
    end
    object gridOKVED_Changed: TdxDBGridColumn
      DisableCustomizing = True
      Visible = False
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'OKVED_Changed'
      GroupIndex = 0
    end
    object dbgDataOrg_Id: TdxDBGridColumn
      DisableCustomizing = True
      Visible = False
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'ORGID'
      GroupIndex = 0
    end
    object dbgDataCol_10: TdxDBGridColumn
      Caption = #1048#1084#1077#1102#1090' '#1084#1086#1073'. '#1087#1088#1077#1076#1087#1080#1089#1072#1085#1080#1077
      Width = 60
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_10'
      GroupIndex = 0
    end
    object dbgDataCol_11: TdxDBGridColumn
      Caption = #1055#1086#1076#1083#1077#1078#1072#1090' '#1087#1088#1080#1079#1099#1074#1091
      Width = 60
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_11'
      GroupIndex = 0
    end
    object dbgDataCol_12: TdxDBGridColumn
      Caption = #1055#1086#1090#1088#1077#1073#1085#1086#1089#1090#1100' '#1085#1072' '#1056#1043
      Width = 60
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'COL_12'
      GroupIndex = 0
    end
  end
  object ActionList1: TActionList
    Images = dmMain.ilSmall
    OnUpdate = ActionList1Update
    Left = 392
    Top = 60
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      ImageIndex = 21
      ShortCut = 45
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = #1055#1088#1072#1074#1080#1090#1100
      Hint = #1055#1088#1072#1074#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      ImageIndex = 9
      ShortCut = 13
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      ImageIndex = 33
      ShortCut = 16430
      OnExecute = actDelExecute
    end
    object actFiltr: TAction
      Caption = #1060#1080#1083#1100#1090#1088
      Hint = #1060#1080#1083#1100#1090#1088' '#1089#1087#1080#1089#1082#1072' '#1082#1072#1088#1090#1086#1095#1077#1082
      ImageIndex = 34
      ShortCut = 16454
      OnExecute = actFiltrExecute
    end
    object actGenerate: TAction
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1060#1086#1088#1084#1091' '#8470' 6'
      Hint = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1087#1091#1089#1090#1091#1102' '#1060#1086#1088#1084#1091' '#8470' 6'
      ImageIndex = 14
      OnExecute = actGenerateExecute
    end
    object actDeleteF6: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1060#1086#1088#1084#1091' '#8470' 6'
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1060#1086#1088#1084#1091' '#8470' 6 '#1091' '#1074#1099#1073#1088#1072#1085#1085#1086#1081' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      ImageIndex = 7
      OnExecute = actDeleteF6Execute
    end
    object actSave: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1074' '#1092#1072#1081#1083
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1074' '#1092#1072#1081#1083
      ImageIndex = 39
      OnExecute = actSaveExecute
    end
    object actSet: TAction
      Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1085#1072#1073#1086#1088
      Hint = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1076#1083#1103' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1086#1090#1095#1077#1090#1086#1074
      ImageIndex = 15
      OnExecute = actSetExecute
    end
    object actColumns: TAction
      Caption = #1050#1086#1083#1086#1085#1082#1080' '#1090#1072#1073#1083#1080#1094#1099
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1082#1086#1083#1086#1085#1086#1082' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 41
      OnExecute = actColumnsExecute
    end
    object actRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 42
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actView: TAction
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      ImageIndex = 36
      ShortCut = 13
      OnExecute = actEditExecute
    end
    object actClearSet: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1085#1072#1073#1086#1088
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1076#1083#1103' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1086#1090#1095#1077#1090#1086#1074
      ImageIndex = 7
      OnExecute = actClearSetExecute
    end
    object actExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1074' Microsoft Excel'
      ImageIndex = 49
      OnExecute = actExcelExecute
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1054#1089#1085#1086#1074#1085#1086#1081
      #1056#1072#1073#1086#1090#1072' '#1089' '#1085#1072#1073#1086#1088#1086#1084)
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmMain.ilSmall
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 328
    Top = 104
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      28
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
          ItemName = 'dxBarButton11'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
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
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxbKopf_Changed'
        end
        item
          Visible = True
          ItemName = 'dxbOkved_Changed'
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
    object dxBarButton4: TdxBarButton
      Action = actFiltr
      Category = 0
    end
    object dxBarButton5: TdxBarButton
      Action = actGenerate
      Category = 0
      UnclickAfterDoing = False
    end
    object dxBarButton6: TdxBarButton
      Action = actDeleteF6
      Category = 0
      UnclickAfterDoing = False
    end
    object dxBarButton7: TdxBarButton
      Action = actSave
      Category = 0
    end
    object dxBarButton9: TdxBarButton
      Action = actColumns
      Category = 0
    end
    object dxBarButton10: TdxBarButton
      Action = actRefresh
      Category = 0
    end
    object dxBarButton11: TdxBarButton
      Action = actView
      Category = 0
    end
    object dxBarButton13: TdxBarButton
      Action = actExcel
      Category = 0
    end
    object dxbKopf_Changed: TdxBarButton
      Caption = #1042#1080#1079#1091#1072#1083#1100#1085#1072#1103' '#1089#1074#1077#1088#1082#1072' '#1082#1086#1076#1086#1074' '#1054#1050#1054#1055#1060
      Category = 0
      Hint = #1042#1080#1079#1091#1072#1083#1100#1085#1072#1103' '#1089#1074#1077#1088#1082#1072' '#1082#1086#1076#1086#1074' '#1054#1050#1054#1055#1060
      Visible = ivNever
      ImageIndex = 13
      OnClick = dxbKopf_ChangedClick
    end
    object dxbOkved_Changed: TdxBarButton
      Caption = #1042#1080#1079#1091#1072#1083#1100#1085#1072#1103' '#1089#1074#1077#1088#1082#1072' '#1082#1086#1076#1086#1074' '#1054#1050#1042#1069#1044
      Category = 0
      Hint = #1042#1080#1079#1091#1072#1083#1100#1085#1072#1103' '#1089#1074#1077#1088#1082#1072' '#1082#1086#1076#1086#1074' '#1054#1050#1042#1069#1044
      Visible = ivNever
      ImageIndex = 13
      OnClick = dxbOkved_ChangedClick
    end
    object dxBarButton8: TdxBarButton
      Action = actSet
      Category = 1
      ButtonStyle = bsDropDown
      DropDownMenu = dxBarPopupMenu1
    end
    object dxBarButton12: TdxBarButton
      Action = actClearSet
      Category = 1
    end
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM '
      'v_ORG'
      ' ')
    Left = 424
    Top = 120
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
    object N15: TMenuItem
      Action = actView
    end
    object N2: TMenuItem
      Action = actEdit
    end
    object N3: TMenuItem
      Action = actDel
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object N11: TMenuItem
      Action = actFiltr
    end
    object N12: TMenuItem
      Action = actSet
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object N61: TMenuItem
      Action = actGenerate
    end
    object N7: TMenuItem
      Action = actDeleteF6
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object N9: TMenuItem
      Action = actSave
    end
    object N13: TMenuItem
      Action = actColumns
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Action = actFiltr
    end
    object N14: TMenuItem
      Action = actRefresh
    end
  end
  object sp_OrgCardDelete: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_OrgCardDelete;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ORG_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 216
    Top = 148
  end
  object sp_GenerateForm6: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_GenerateForm6;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ORG_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@F6_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 216
    Top = 192
  end
  object sp_DeleteForm6: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_DeleteForm6;1'
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
    Top = 236
  end
  object qrFS: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT FS_ID, KOD + '#39' - '#39' + ISNULL(FS_NAME,'#39#39') AS FS_NAME '
      'FROM KFS'
      'ORDER BY FS_NAME')
    Left = 420
    Top = 264
  end
  object qrKOPF: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT KOPF_ID, KOD + '#39' - '#39' + ISNULL(KOPF_NAME,'#39#39') AS KOPF_NAME '
      'FROM KOPF'
      'ORDER BY KOPF_NAME')
    Left = 460
    Top = 264
  end
  object qrKONH: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT KONH_ID, KONH_KOD + '#39' - '#39' + ISNULL(KONH_NAME,'#39#39') AS KONH_' +
        'NAME '
      'FROM KONH'
      'ORDER BY KONH_NAME')
    Left = 500
    Top = 264
  end
  object qrKTERR: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT TERR_ID, KODTERR, NAME'
      'FROM KTERR'
      'ORDER BY NAME')
    Left = 540
    Top = 264
    object qrKTERRTERR_ID: TIntegerField
      FieldName = 'TERR_ID'
    end
    object qrKTERRKODTERR: TStringField
      FieldName = 'KODTERR'
      Size = 11
    end
    object qrKTERRNAME: TStringField
      DisplayWidth = 30
      FieldName = 'NAME'
      Size = 150
    end
  end
  object qrVV5: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT ID, KOD + '#39' - '#39' + NAME As NAME'
      'FROM VV5'
      'ORDER BY NAME')
    Left = 580
    Top = 264
  end
  object dsFS: TDataSource
    DataSet = qrFS
    Left = 420
    Top = 308
  end
  object dsKOPF: TDataSource
    DataSet = qrKOPF
    Left = 460
    Top = 308
  end
  object dsKONH: TDataSource
    DataSet = qrKONH
    Left = 500
    Top = 308
  end
  object dsKTERR: TDataSource
    DataSet = qrKTERR
    Left = 540
    Top = 308
  end
  object dsVV5: TDataSource
    DataSet = qrVV5
    Left = 580
    Top = 308
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'xls'
    Filter = 
      'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls|HTML File (*.htm; *.' +
      'html)|*.htm;*.html|Text File (*.txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 328
    Top = 192
  end
  object qrSet: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    Left = 292
    Top = 292
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton12'
      end>
    UseOwnFont = False
    Left = 252
    Top = 88
    PixelsPerInch = 96
  end
end

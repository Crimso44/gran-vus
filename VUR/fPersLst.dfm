object fmPersonList: TfmPersonList
  Left = 306
  Top = 164
  HelpContext = 9
  Caption = #1050#1072#1088#1090#1086#1090#1077#1082#1072' '#1088#1072#1073#1086#1090#1085#1080#1082#1086#1074
  ClientHeight = 476
  ClientWidth = 716
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Scaled = False
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnDeactivate = FormDeactivate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgData: TdxDBGrid
    Left = 0
    Top = 26
    Width = 716
    Height = 450
    Bands = <
      item
        Fixed = bfLeft
        Width = 151
      end
      item
        Caption = #1044#1072#1085#1085#1099#1077' '#1086' '#1075#1088#1072#1078#1076#1072#1085#1072#1093' '#1079#1072#1087#1072#1089#1072
        Width = 440
      end
      item
        Caption = #1044#1074#1080#1078#1077#1085#1080#1077' '#1082#1072#1088#1090#1086#1095#1077#1082
        Width = 172
      end
      item
      end
      item
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
      end
      item
        Caption = #1053#1040#1057#1060
      end
      item
        Visible = False
      end
      item
        Caption = #1052#1086#1073'. '#1087#1088#1077#1076#1087#1080#1089#1072#1085#1080#1077
      end
      item
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1099#1081' '#1091#1095#1077#1090
      end
      item
        Caption = #1055#1077#1088#1074#1086#1077' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077
      end
      item
        Caption = #1042#1090#1086#1088#1086#1077' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077
      end>
    DefaultLayout = False
    HeaderMinRowCount = 3
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    KeyField = 'PERS_ID'
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
    TabOrder = 0
    OnDblClick = actEditExecute
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -11
    BandFont.Name = 'MS Sans Serif'
    BandFont.Style = []
    DataSource = DataSource1
    Filter.Criteria = {00000000}
    FixedBandLineWidth = 1
    HeaderFont.Charset = RUSSIAN_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -9
    HeaderFont.Name = 'Small Fonts'
    HeaderFont.Style = []
    IniFileName = 'GranVUS.ini'
    IniSectionName = 'PersList'
    OptionsBehavior = [edgoAnsiSort, edgoAutoSearch, edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSelect, edgoMultiSort, edgoStoreToIniFile, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoFullSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseLocate]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoIndicator, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    ShowBands = True
    OnColumnSorting = dbgDataColumnSorting
    OnCompare = dbgDataCompare
    OnCustomDrawCell = dbgDataCustomDrawCell
    object dbgDataNum: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #8470' '#1087'/'#1087
      DisableDragging = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 30
      BandIndex = 0
      RowIndex = 0
      OnGetText = dbgDataNumGetText
    end
    object dbgDataPers_ID: TdxDBGridColumn
      Caption = 'ID'
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'PERS_ID'
    end
    object dbgDataTAB_NUMB: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #1058#1072#1073'.'#8470
      HeaderAlignment = taCenter
      Width = 40
      BandIndex = 0
      RowIndex = 0
      FieldName = 'TAB_NUMB'
    end
    object dbgDataColumnFIO: TdxDBGridColumn
      Caption = #1060#1072#1084#1080#1083#1080#1103' '#1080' '#1080#1085#1080#1094#1080#1072#1083#1099
      HeaderAlignment = taCenter
      Width = 151
      BandIndex = 0
      RowIndex = 0
      FieldName = 'FIO'
      SummaryFooterType = cstCount
      SummaryFooterFormat = '0'
    end
    object dbgDataPersonMale: TdxDBGridColumn
      Caption = #1055#1086#1083
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'PersonMale'
    end
    object dbgDataBIRTHDAY: TdxDBGridDateColumn
      Caption = #1063#1080#1089#1083#1086' '#1084#1077#1089#1103#1094' '#1080' '#1075#1086#1076' '#1088#1086#1078#1076#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Width = 65
      BandIndex = 1
      RowIndex = 0
      FieldName = 'BIRTHDAY'
    end
    object dbgDataBirthPlace: TdxDBGridColumn
      Caption = #1052#1077#1089#1090#1086' '#1088#1086#1078#1076#1077#1085#1080#1103
      Visible = False
      Width = 80
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ADDRPASS'
    end
    object dbgDataDEP_NAME: TdxDBGridColumn
      Caption = #1057#1090#1088#1091#1082#1090#1091#1088#1085#1086#1077' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077', '#1074' '#1082#1086#1090#1086#1088#1086#1084' '#1088#1072#1073#1086#1090#1072#1077#1090
      HeaderAlignment = taCenter
      Width = 101
      BandIndex = 1
      RowIndex = 0
      FieldName = 'DEP_NAME'
    end
    object dbgDataDep_Full_Name: TdxDBGridColumn
      Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1090#1088#1091#1082#1090#1091#1088#1085#1086#1075#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103
      Visible = False
      Width = 80
      BandIndex = 1
      RowIndex = 0
      FieldName = 'Dep_Full_Name'
    end
    object dbgDataColumnBeginWork_Date: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
      Visible = False
      Width = 40
      BandIndex = 1
      RowIndex = 0
      FieldName = 'BeginWork_Date'
    end
    object dbgDataIS_ASF: TdxDBGridCheckColumn
      Caption = #1055#1086#1076#1088'. '#1040#1057#1060
      Visible = False
      Width = 30
      BandIndex = 1
      RowIndex = 0
      FieldName = 'IS_ASF'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDataColumnPOST_NAME: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100' / '#1075#1086#1076' '#1086#1073#1091#1095#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Width = 103
      BandIndex = 1
      RowIndex = 0
      FieldName = 'POST_NAME'
    end
    object dbgDataColumn3: TdxDBGridColumn
      Caption = #1042#1086#1080#1085#1089#1082#1086#1077' '#1079#1074#1072#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 133
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WRANGE'
    end
    object dbgDataWrng_Date: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1089#1074#1086#1077#1085#1080#1103
      Width = 70
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WRng_Date'
    end
    object dbgDataColumn6: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042#1059#1057
      HeaderAlignment = taCenter
      Width = 56
      BandIndex = 1
      RowIndex = 0
      FieldName = 'VUS'
    end
    object dbgDataColumnFLD_A: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042' '#1088#1072#1079#1076#1077#1083#1077' '#1086#1073#1097#1077#1075#1086' '#1091#1095#1077#1090#1072
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 2
      RowIndex = 0
      FieldName = 'FLD_A'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '0'
    end
    object dbgDataWBSer: TdxDBGridMaskColumn
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WBser'
    end
    object dbgDataWBNum: TdxDBGridMaskColumn
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WBNum'
    end
    object dbgDataColumnW_DBEG: TdxDBGridDateColumn
      Alignment = taLeftJustify
      Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1085#1086#1074#1082#1080' '#1085#1072' '#1074#1086#1080#1085#1089#1082#1080#1081' '#1091#1095#1077#1090
      HeaderAlignment = taCenter
      Width = 70
      BandIndex = 1
      RowIndex = 0
      FieldName = 'W_DBEG'
      SummaryFooterFormat = '0'
    end
    object dbgDataColumnFLD_B: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042' '#1088#1072#1079#1076#1077#1083#1077' '#1089#1087#1077#1094'. '#1091#1095#1077#1090#1072
      HeaderAlignment = taCenter
      Width = 50
      BandIndex = 2
      RowIndex = 0
      FieldName = 'FLD_B'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '0'
    end
    object dbgDataColumnNUMB_T2: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1056#1077#1075#1080#1089#1090#1088'. '#1085#1086#1084#1077#1088' '#1082#1072#1088#1090#1086#1095#1082#1080
      HeaderAlignment = taCenter
      Width = 62
      BandIndex = 1
      RowIndex = 0
      FieldName = 'NUMB_T2'
    end
    object dbgDataColumnW_DEND: TdxDBGridDateColumn
      Alignment = taRightJustify
      Caption = #1044#1072#1090#1072' '#1089#1085#1103#1090#1080#1103' '#1089' '#1091#1095#1077#1090#1072' / '#1087#1086#1084#1077#1097'. '#1074' '#1072#1088#1093#1080#1074
      HeaderAlignment = taCenter
      Width = 75
      BandIndex = 2
      RowIndex = 0
      FieldName = 'W_DEND'
      SummaryFooterType = cstSum
      SummaryFooterField = 'W_EndCount'
      SummaryFooterFormat = '0'
    end
    object dbgDataColumnWDISCL: TdxDBGridColumn
      Caption = #1054#1090#1084#1077#1090#1082#1080' '#1086' '#1089#1085#1103#1090#1080#1080' '#1089' '#1091#1095#1077#1090#1072'/'#1087#1086#1084#1077#1097#1077#1085#1080#1080' '#1074' '#1072#1088#1093#1080#1074
      HeaderAlignment = taCenter
      Width = 185
      BandIndex = 3
      RowIndex = 0
      FieldName = 'WDISCL'
    end
    object dbgDataMOBFLAG: TdxDBGridMaskColumn
      Caption = #1048#1084#1077#1077#1090' '#1084#1086#1073'. '#1087#1088#1077#1076#1087#1080#1089#1072#1085#1080#1077
      HeaderAlignment = taCenter
      MaxLength = 1
      MinWidth = 50
      Width = 65
      BandIndex = 4
      RowIndex = 0
      FieldName = 'MobFlag'
    end
    object dbgDataColumn43: TdxDBGridColumn
      Caption = #1058#1077#1083#1077#1092#1086#1085' '#1088#1072#1073#1086#1095#1080#1081
      HeaderAlignment = taCenter
      Width = 65
      BandIndex = 4
      RowIndex = 0
      FieldName = 'PHONEWRK'
    end
    object dbgDataPHONEMOB: TdxDBGridMaskColumn
      Alignment = taLeftJustify
      Caption = #1058#1077#1083#1077#1092#1086#1085' '#1084#1086#1073#1080#1083#1100#1085#1099#1081
      HeaderAlignment = taCenter
      Width = 65
      BandIndex = 4
      RowIndex = 0
      FieldName = 'PHONEMOB'
    end
    object dbgDataPHONEDOM: TdxDBGridMaskColumn
      Caption = #1058#1077#1083#1077#1092#1086#1085' '#1076#1086#1084#1072#1096#1085#1080#1081
      HeaderAlignment = taCenter
      Width = 65
      BandIndex = 4
      RowIndex = 0
      FieldName = 'PHONEDOM'
    end
    object dbgDataADDRPASS: TdxDBGridMaskColumn
      Caption = #1040#1076#1088#1077#1089' '#1087#1086' '#1087#1088#1086#1087#1080#1089#1082#1077
      HeaderAlignment = taCenter
      MinWidth = 100
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'ADDRPASS'
    end
    object dbgDataADDR_DATE_END: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      HeaderAlignment = taCenter
      Width = 75
      BandIndex = 4
      RowIndex = 0
      FieldName = 'ADDR_DATE_END'
    end
    object dbgDataColumn41: TdxDBGridColumn
      Caption = #1048#1085#1076#1077#1082#1089' '#1072#1076#1088'. '#1087#1086' '#1087#1088#1086#1087#1080#1089#1082#1077
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'INDADDRPASS'
    end
    object dbgDataADDRREAL: TdxDBGridMaskColumn
      Caption = #1040#1076#1088#1077#1089' '#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1087#1088#1086#1078#1080#1074#1072#1085#1080#1103
      HeaderAlignment = taCenter
      MinWidth = 100
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'ADDRREAL'
    end
    object dbgDataIS_BAD: TdxDBGridMaskColumn
      DisableCustomizing = True
      Visible = False
      Width = 65
      BandIndex = 6
      RowIndex = 0
      FieldName = 'IS_BAD'
    end
    object dbgDataReserved: TdxDBGridColumn
      DisableCustomizing = True
      Visible = False
      Width = 65
      BandIndex = 6
      RowIndex = 0
      FieldName = 'Reserved'
    end
    object dbgDataTooOld: TdxDBGridColumn
      DisableCustomizing = True
      Visible = False
      Width = 65
      BandIndex = 6
      RowIndex = 0
      FieldName = 'TooOld'
    end
    object dbgDataColumnIS_WAR: TdxDBGridColumn
      DisableCustomizing = True
      Visible = False
      Width = 65
      BandIndex = 6
      RowIndex = 0
      FieldName = 'IS_WAR'
    end
    object dbgDataColumnOUT_DATE: TdxDBGridDateColumn
      DisableCustomizing = True
      Visible = False
      Width = 115
      BandIndex = 6
      RowIndex = 0
      FieldName = 'OUT_DATE'
    end
    object dbgDataColumnOUT_ORD_NUMB: TdxDBGridColumn
      DisableCustomizing = True
      Visible = False
      Width = 311
      BandIndex = 6
      RowIndex = 0
      FieldName = 'OUT_ORD_NUMB'
    end
    object dbgDataEndAkadem_date: TdxDBGridDateColumn
      DisableCustomizing = True
      Visible = False
      BandIndex = 6
      RowIndex = 0
      FieldName = 'EndAkadem_date'
    end
    object dbgDataRealEndAkadem_date: TdxDBGridDateColumn
      DisableCustomizing = True
      Visible = False
      BandIndex = 6
      RowIndex = 0
      FieldName = 'RealEndAkadem_date'
    end
    object dbgDataColumnDismissal_Date: TdxDBGridDateColumn
      DisableCustomizing = True
      Visible = False
      BandIndex = 6
      RowIndex = 0
      FieldName = 'Dismissal_Date'
    end
    object dbgDataColumnBeginStudy_Date: TdxDBGridDateColumn
      DisableCustomizing = True
      Visible = False
      BandIndex = 6
      RowIndex = 0
      FieldName = 'BeginStudy_Date'
    end
    object dbgDataWUCHET1: TdxDBGridColumn
      DisableCustomizing = True
      Visible = False
      BandIndex = 6
      RowIndex = 0
      FieldName = 'WUCHET1'
    end
    object dbgDataColumn42: TdxDBGridColumn
      Caption = #1048#1085#1076#1077#1082#1089' '#1072#1076#1088#1077#1089#1072' '#1092#1072#1082#1090'.'
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'INDADDRREAL'
    end
    object dbgDataColumn34: TdxDBGridColumn
      Caption = #1060#1072#1084#1080#1083#1080#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 307
      BandIndex = 0
      RowIndex = 0
      FieldName = 'FAM'
    end
    object dbgDataColumn35: TdxDBGridColumn
      Caption = #1048#1084#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 205
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IM'
    end
    object dbgDataColumn36: TdxDBGridColumn
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086
      HeaderAlignment = taCenter
      Visible = False
      Width = 205
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OTCH'
    end
    object dbgDataColumn37: TdxDBGridColumn
      Caption = #1057#1077#1088#1080#1103' '#1087#1072#1089#1087#1086#1088#1090#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'PSP_SER'
    end
    object dbgDataColumn38: TdxDBGridColumn
      Caption = #8470' '#1087#1072#1089#1087#1086#1088#1090#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'PSP_NUM'
    end
    object dbgDataColumn40: TdxDBGridColumn
      Caption = #1050#1077#1084' '#1074#1099#1076#1072#1085' '#1087#1072#1089#1087#1086#1088#1090
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'PSP_PLACE'
    end
    object dbgDataColumn39: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080' '#1087#1072#1089#1087#1086#1088#1090#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'PSP_DATE'
    end
    object dbgDataColumn44: TdxDBGridColumn
      Caption = #1048#1053#1053
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'INN'
    end
    object dbgDataColumn45: TdxDBGridColumn
      Caption = #8470' '#1089#1090#1088#1072#1093#1086#1074#1086#1075#1086' '#1089#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'STRAH'
    end
    object dbgDataColumn46: TdxDBGridColumn
      Caption = #1057#1077#1084#1077#1081#1085#1086#1077' '#1087#1086#1083#1086#1078#1077#1085#1080#1077
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'FST_NAME'
    end
    object dbgDataColumn47: TdxDBGridColumn
      Caption = #1042#1080#1076' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'ED_NAME'
    end
    object dbgDataColumn48: TdxDBGridColumn
      Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1103' '#1087#1086' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1102
      HeaderAlignment = taCenter
      Visible = False
      BandIndex = 4
      RowIndex = 0
      FieldName = 'PROF1'
    end
    object dbgDataColumn49: TdxDBGridColumn
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1080
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'CPROF_NAME'
    end
    object dbgDataColumn50: TdxDBGridColumn
      Caption = #1043#1088#1091#1087#1087#1072' '#1091#1095#1077#1090#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'BranchName'
    end
    object dbgDataColumn51: TdxDBGridColumn
      Caption = #1051#1080#1095#1085#1099#1081' '#8470
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'WID'
    end
    object dbgDataColumn52: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1103' '#1080#1079' '#1072#1088#1084#1080#1080
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'EOARMY_DATE'
    end
    object dbgDataColumn53: TdxDBGridColumn
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103' '#1079#1072#1087#1072#1089#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'CAT_ZAP'
    end
    object dbgDataColumn54: TdxDBGridColumn
      Caption = #1043#1086#1076#1085#1086#1089#1090#1100' '#1082' '#1089#1083#1091#1078#1073#1077
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'WCAT'
    end
    object dbgDataColumn55: TdxDBGridColumn
      Caption = #1054#1042#1050
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'OVK_NAME'
    end
    object dbgDataColumn56: TdxDBGridColumn
      Caption = #1059#1095#1072#1089#1090#1085#1080#1082' '#1073#1086#1077#1074#1099#1093' '#1076#1077#1081#1089#1090#1074#1080#1081
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Warfare'
    end
    object dbgDataColumn57: TdxDBGridColumn
      Caption = #1054#1090#1089#1088#1086#1095#1082#1072' '#1086#1090' '#1087#1088#1080#1079#1099#1074#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'DelayName'
    end
    object dbgDataColumn58: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1086#1090#1089#1088#1086#1095#1082#1080
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'DelayEnd_date'
    end
    object dbgDataColumn59: TdxDBGridColumn
      Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1079#1076#1086#1088#1086#1074#1100#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Health'
    end
    object dbgDataColumn60: TdxDBGridColumn
      Caption = #1058#1088#1091#1076#1086#1074#1086#1081' '#1076#1086#1075#1086#1074#1086#1088
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Dog_NumbWork'
    end
    object dbgDataColumn61: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1090#1088#1091#1076#1086#1074#1086#1075#1086' '#1076#1086#1075#1086#1074#1086#1088#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Dog_DateWork'
    end
    object dbgDataColumn62: TdxDBGridColumn
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'OUT_DATE'
    end
    object dbgDataColumn63: TdxDBGridColumn
      Caption = #8470' '#1087#1088#1080#1082#1072#1079#1072' '#1086#1073' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1080
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'OUT_ORD_NUMB'
    end
    object dbgDataColumn64: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1082#1072#1079#1072' '#1086#1073' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1080
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'OUT_ORD_DATE'
    end
    object dbgDataColumn65: TdxDBGridColumn
      Caption = #1043#1086#1089#1089#1083#1091#1078#1072#1097#1080#1081
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Gos'
    end
    object dbgDataColumn66: TdxDBGridColumn
      Caption = #1057#1090#1072#1090#1091#1089' '#1091#1095#1072#1097#1077#1075#1086#1089#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'PostStudy'
    end
    object dbgDataColumn67: TdxDBGridColumn
      Caption = #1055#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1086#1073#1091#1095#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'StudyEnd_date'
    end
    object dbgDataColumn68: TdxDBGridColumn
      Caption = #8470' '#1076#1086#1075#1086#1074#1086#1088#1072' '#1086#1073' '#1086#1073#1091#1095#1077#1085#1080#1080
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Dog_NumbStudy'
    end
    object dbgDataColumn69: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1076#1086#1075#1086#1074#1086#1088#1072' '#1086#1073' '#1086#1073#1091#1095#1077#1085#1080#1080
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Dog_DateStudy'
    end
    object dbgDataColumn70: TdxDBGridColumn
      Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100' '#1087#1086' '#1082#1086#1090#1086#1088#1086#1081' '#1091#1095#1080#1090#1089#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Napr'
    end
    object dbgDataColumn71: TdxDBGridColumn
      Caption = #1053#1072#1095#1072#1083#1086' '#1072#1082#1072#1076#1077#1084#1080#1095#1077#1089#1082#1086#1075#1086' '#1086#1090#1087#1091#1089#1082#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'BeginAkadem_date'
    end
    object dbgDataColumn72: TdxDBGridColumn
      Caption = #1055#1083#1072#1085#1086#1074#1086#1077' '#1086#1082#1086#1085#1095#1072#1085#1080#1077' '#1072#1082#1072#1076#1077#1084#1080#1095#1077#1089#1082#1086#1075#1086' '#1086#1090#1087#1091#1089#1082#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'EndAkadem_date'
    end
    object dbgDataColumn73: TdxDBGridColumn
      Caption = #1060#1072#1082#1090'. '#1086#1082#1086#1085#1095#1072#1085#1080#1077' '#1072#1082#1072#1076#1077#1084#1080#1095#1077#1089#1082#1086#1075#1086' '#1086#1090#1087#1091#1089#1082#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'RealEndAkadem_date'
    end
    object dbgDataColumn74: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1084#1077#1076#1082#1086#1084#1080#1089#1089#1080#1080' '#1087#1086#1089#1083#1077' '#1072#1082#1072#1076#1077#1084'. '#1086#1090#1087#1091#1089#1082#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'MedResult_date'
    end
    object dbgDataColumn75: TdxDBGridColumn
      Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1084#1077#1076#1082#1086#1084#1080#1089#1089#1080#1080' '#1087#1086#1089#1083#1077' '#1072#1082#1072#1076#1077#1084'.'#1086#1090#1087#1091#1089#1082#1072
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'MedResultText'
    end
    object dbgDataColumn76: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Dismissal_Date'
    end
    object dbgDataColumn77: TdxDBGridColumn
      Caption = #8470' '#1087#1088#1080#1082#1072#1079#1072' '#1086#1073' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1080
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'OrderDismissal'
    end
    object dbgDataColumn78: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1082#1072#1079#1072' '#1086#1073' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1080
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'OrderDismissal_date'
    end
    object dbgDataColumn79: TdxDBGridColumn
      Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1080#1089#1083#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'ReasonDismissal'
    end
    object dbgDataASFName: TdxDBGridColumn
      Caption = #1053#1040#1057#1060
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 5
      RowIndex = 0
      FieldName = 'ASFName'
    end
    object dbgDataColumn80: TdxDBGridColumn
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' ('#1053#1040#1057#1060')'
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 5
      RowIndex = 0
      FieldName = 'ASDep_Name'
    end
    object dbgDataColumn81: TdxDBGridColumn
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100' ('#1053#1040#1057#1060')'
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 5
      RowIndex = 0
      FieldName = 'ASPost_Name'
    end
    object dbgDataColumn84: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1103' ('#1053#1040#1057#1060')'
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 5
      RowIndex = 0
      FieldName = 'ASIn_Date'
    end
    object dbgDataColumn85: TdxDBGridColumn
      Caption = #8470' '#1087#1088#1080#1082#1072#1079#1072' '#1086' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1080' ('#1053#1040#1057#1060')'
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 5
      RowIndex = 0
      FieldName = 'ASOrder_In'
    end
    object dbgDataColumn86: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1082#1072#1079#1072' '#1086' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1080' ('#1053#1040#1057#1060')'
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 5
      RowIndex = 0
      FieldName = 'ASDate_In'
    end
    object dbgDataColumn87: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1074#1099#1093#1086#1076#1072' ('#1053#1040#1057#1060')'
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 5
      RowIndex = 0
      FieldName = 'ASOut_Date'
    end
    object dbgDataColumn88: TdxDBGridColumn
      Caption = #8470' '#1087#1088#1080#1082#1072#1079#1072' '#1086' '#1074#1099#1093#1086#1076#1077' ('#1053#1040#1057#1060')'
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 5
      RowIndex = 0
      FieldName = 'ASOut_ORD_NUMB'
    end
    object dbgDataColumn89: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1082#1072#1079#1072' '#1086' '#1074#1099#1093#1086#1076#1077' ('#1053#1040#1057#1060')'
      HeaderAlignment = taCenter
      Visible = False
      Width = 100
      BandIndex = 5
      RowIndex = 0
      FieldName = 'ASOut_ORD_Date'
    end
    object dbgDataColumn90: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #1057#1086#1089#1090#1072#1074' / '#1087#1088#1086#1092#1080#1083#1100
      HeaderAlignment = taCenter
      Visible = False
      Width = 80
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WSOST_Name'
    end
    object dbgDataWUch1: TdxDBGridMaskColumn
      Caption = #8470' '#1082#1086#1084#1072#1085#1076#1099' ('#1084#1086#1073')'
      HeaderAlignment = taCenter
      Visible = False
      Width = 80
      BandIndex = 7
      RowIndex = 0
      FieldName = 'WUch1'
    end
    object dbgDataMob_CardDate: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1074#1088#1091#1095#1077#1085#1080#1103' ('#1084#1086#1073')'
      HeaderAlignment = taCenter
      Visible = False
      Width = 80
      BandIndex = 7
      RowIndex = 0
      FieldName = 'Mob_CardDate'
    end
    object dbgDataMob_MissReason: TdxDBGridMaskColumn
      Caption = #1055#1088#1080#1095#1080#1085#1072' '#1085#1077#1074#1088#1091#1095#1077#1085#1080#1103' ('#1084#1086#1073')'
      HeaderAlignment = taCenter
      Visible = False
      Width = 80
      BandIndex = 7
      RowIndex = 0
      FieldName = 'Mob_MissReason'
    end
    object dbgDataWUch2: TdxDBGridMaskColumn
      Caption = #1057#1077#1088#1080#1103', '#8470' '#1091#1076#1086#1089#1090#1086#1074#1077#1088#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 80
      BandIndex = 8
      RowIndex = 0
      FieldName = 'WUch2'
    end
    object dbgDataWUCHET2_date: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1091#1076#1086#1089#1090#1086#1074#1077#1088#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Visible = False
      Width = 80
      BandIndex = 8
      RowIndex = 0
      FieldName = 'WUCHET2_date'
    end
    object dbgDataColumn97: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1089#1074#1077#1088#1082#1080' '#1089' '#1054#1042#1050
      HeaderAlignment = taCenter
      Visible = False
      Width = 70
      BandIndex = 1
      RowIndex = 0
      FieldName = 'D_OVK'
    end
    object dbgDataColumn98: TdxDBGridColumn
      Caption = #1044#1072#1090#1072' '#1089#1074#1077#1088#1082#1080' '#1089' '#1074#1086#1077#1085#1085#1099#1084' '#1073#1080#1083#1077#1090#1086#1084
      HeaderAlignment = taCenter
      Visible = False
      Width = 70
      BandIndex = 1
      RowIndex = 0
      FieldName = 'D_WBIL'
    end
    object dbgDataKUZ_Name1: TdxDBGridMaskColumn
      Caption = #1059#1095#1077#1073#1085#1086#1077' '#1079#1072#1074#1077#1076#1077#1085#1080#1077' (1)'
      Visible = False
      Width = 60
      BandIndex = 9
      RowIndex = 0
      FieldName = 'KUZ_Name1'
    end
    object dbgDataKObrDoc_Name1: TdxDBGridMaskColumn
      Caption = #1042#1080#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' (1)'
      Visible = False
      Width = 60
      BandIndex = 9
      RowIndex = 0
      FieldName = 'KObrDoc_Name1'
    end
    object dbgDataKVal_Name1: TdxDBGridMaskColumn
      Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103' (1)'
      Visible = False
      Width = 60
      BandIndex = 9
      RowIndex = 0
      FieldName = 'KVal_Name1'
    end
    object dbgDataNapr_Name1: TdxDBGridMaskColumn
      Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100' (1)'
      Visible = False
      Width = 60
      BandIndex = 9
      RowIndex = 0
      FieldName = 'Napr_Name1'
    end
    object dbgDataDiplom_Ser1: TdxDBGridMaskColumn
      Caption = #1057#1077#1088#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' (1)'
      Visible = False
      Width = 40
      BandIndex = 9
      RowIndex = 0
      FieldName = 'Diplom_Ser1'
    end
    object dbgDataDiplom1: TdxDBGridMaskColumn
      Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' (1)'
      Visible = False
      Width = 40
      BandIndex = 9
      RowIndex = 0
      FieldName = 'Diplom1'
    end
    object dbgDataEnd_Date1: TdxDBGridMaskColumn
      Caption = #1044#1072#1090#1072'/'#1075#1086#1076' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' (1)'
      Visible = False
      Width = 40
      BandIndex = 9
      RowIndex = 0
      FieldName = 'End_Date1'
    end
    object dbgDataKUZ_Name2: TdxDBGridMaskColumn
      Caption = #1059#1095#1077#1073#1085#1086#1077' '#1079#1072#1074#1077#1076#1077#1085#1080#1077' (2)'
      Visible = False
      Width = 60
      BandIndex = 10
      RowIndex = 0
      FieldName = 'KUZ_Name2'
    end
    object dbgDataKObrDoc_Name2: TdxDBGridMaskColumn
      Caption = #1042#1080#1076' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' (2)'
      Visible = False
      Width = 60
      BandIndex = 10
      RowIndex = 0
      FieldName = 'KObrDoc_Name2'
    end
    object dbgDataKVal_Name2: TdxDBGridMaskColumn
      Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103' (2)'
      Visible = False
      Width = 60
      BandIndex = 10
      RowIndex = 0
      FieldName = 'KVal_Name2'
    end
    object dbgDataNapr_Name2: TdxDBGridMaskColumn
      Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100' (2)'
      Visible = False
      Width = 60
      BandIndex = 10
      RowIndex = 0
      FieldName = 'Napr_Name2'
    end
    object dbgDataDiplom_Ser2: TdxDBGridMaskColumn
      Caption = #1057#1077#1088#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' (2)'
      Visible = False
      Width = 40
      BandIndex = 10
      RowIndex = 0
      FieldName = 'Diplom_Ser2'
    end
    object dbgDataDiplom2: TdxDBGridMaskColumn
      Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' (2)'
      Visible = False
      Width = 40
      BandIndex = 10
      RowIndex = 0
      FieldName = 'Diplom2'
    end
    object dbgDataEnd_Date2: TdxDBGridMaskColumn
      Caption = #1044#1072#1090#1072'/'#1075#1086#1076' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' (2)'
      Visible = False
      Width = 40
      BandIndex = 10
      RowIndex = 0
      FieldName = 'End_Date2'
    end
    object dbgDataKOKPDTR_Code: TdxDBGridColumn
      Caption = #1050#1086#1076' '#1087#1086' '#1054#1050#1055#1044#1058#1056
      Visible = False
      Width = 60
      BandIndex = 1
      RowIndex = 0
      FieldName = 'KOKPDTR_Code'
    end
    object dbgDataKOKPDTR_Name: TdxDBGridColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1087#1086' '#1054#1050#1055#1044#1058#1056
      Visible = False
      Width = 60
      BandIndex = 1
      RowIndex = 0
      FieldName = 'KOKPDTR_Name'
    end
    object dbgDataWTP_Name: TdxDBGridColumn
      Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090#1099
      Visible = False
      Width = 60
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WTP_Name'
    end
    object dbgDataWCH_Name: TdxDBGridColumn
      Caption = #1061#1072#1088#1072#1082#1090#1077#1088' '#1088#1072#1073#1086#1090#1099
      Visible = False
      Width = 60
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WCH_Name'
    end
    object dbgDataComments: TdxDBGridMaskColumn
      Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
      Width = 200
      BandIndex = 4
      RowIndex = 0
      FieldName = 'Comments'
    end
    object dbgDataColumn186: TdxDBGridMaskColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'WBser'
    end
    object dbgDataColumn187: TdxDBGridMaskColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'WBNum'
    end
    object dbgDataOUT_DATE: TdxDBGridDateColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OUT_DATE'
    end
    object dbgDataOUT_ORD_NUMB: TdxDBGridMaskColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OUT_ORD_NUMB'
    end
    object dbgDataAssignText: TdxDBGridMaskColumn
      Caption = #1056#1072#1079#1088#1103#1076', '#1095#1080#1085', '#1088#1072#1085#1075
      Visible = False
      Width = 80
      BandIndex = 4
      RowIndex = 0
      FieldName = 'AssignText'
    end
    object dbgDataIn_Ord_NumbStudy: TdxDBGridColumn
      Caption = #1053#1086#1084#1077#1088' '#1087#1088#1080#1082#1072#1079#1072' '#1086' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1080
      Width = 100
      BandIndex = 1
      RowIndex = 0
      FieldName = 'In_Ord_NumbStudy'
    end
    object dbgDataIn_Ord_DateStudy: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1082#1072#1079#1072' '#1086' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1080
      Width = 100
      BandIndex = 1
      RowIndex = 0
      FieldName = 'In_Ord_DateStudy'
    end
    object dbgDataIn_DateStudy: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1103
      Width = 100
      BandIndex = 1
      RowIndex = 0
      FieldName = 'In_DateStudy'
    end
  end
  object DataSQL: TMemo
    Left = 448
    Top = 112
    Width = 53
    Height = 21
    Lines.Strings = (
      'SELECT distinct '
      
        '[Person].[PERS_ID],[Person].[ORG_ID],[Person].[FAM],[Person].[IM' +
        '],[Person].[OTCH],[Person].[MALE],[Person].[BIRTHDAY],[Person].[' +
        'BIRTHPLACE],'
      
        '[Person].[OKATO],[Person].[NAT_ID],[Person].[PSP_SER],[Person].[' +
        'PSP_NUM],[Person].[PSP_PLACE],[Person].[PSP_DATE],[Person].[INN]' +
        ','
      
        '[Person].[STRAH],[Person].[FST_ID],[Person].[ED_ID],[Person].[SC' +
        '_ID],[Person].[IS_WAR],[Person].[EOARMY_DATE],[Person].[CSOST],'
      
        '[Person].[WRNG_ID],[Person].[WSOST_ID],[Person].[CAT_ZAP],[Perso' +
        'n].[VUS],[Person].[WCAT],[Person].[OVK_ID],[Person].[WUCHET1],'
      
        '[Person].[SpecialWUchet1],[Person].[WUCHET2],[Person].[WDISCL],[' +
        'Person].[TAB_NUMB],[Person].[DOG_NUMB],[Person].[DOG_DATE],'
      
        '[Person].[IS_RAB],[Person].[PROF1],[Person].[OKPDTR1],[Person].[' +
        'PROF2],[Person].[OKPDTR2],[Person].[CONFDATE],[Person].[NUMB_T2]' +
        ','
      
        '[Person].[W_DBEG],[Person].[W_DEND],[Person].[D_OVK],[Person].[D' +
        '_WBIL],[Person].[OUT_ORD_NUMB],[Person].[OUT_ORD_DATE],'
      
        '[Person].[OUT_DATE],[Person].[WID],[Person].[WBser],[Person].[WB' +
        'num],[Person].[WUCHET2_date],[Person].[Document],[Person].[Branc' +
        'h],'
      
        '[Person].[IsAspirant],[Person].[StudyEnd_date],[Person].[OrderAk' +
        'adem],[Person].[OrderAkadem_date],[Person].[ReasonAkadem],'
      
        '[Person].[BeginAkadem_date],[Person].[EndAkadem_date],[Person].[' +
        'RealEndAkadem_date],[Person].[MedResult_date],[Person].[MedResul' +
        't],'
      
        '[Person].[VKStatus],[Person].[BeginWar_date],[Person].[EndWar_da' +
        'te],[Person].[RealEndWar_date],[Person].[ReasonEndWar],'
      
        '[Person].[Dismissal_date],[Person].[OrderDismissal],[Person].[Or' +
        'derDismissal_date],[Person].[ReasonDismissal],[Person].[DisserNa' +
        'me],'
      
        '[Person].[Degree_ID],[Person].[GuideDegree_ID],[Person].[FIOGuid' +
        'e],[Person].[Defend_date],[Person].[RealDefend_date],'
      
        '[Person].[ContractEnd],[Person].[StudyForm],[Person].[Kval_Id],[' +
        'Person].[Delay_ID],[Person].[DelayStart_date],[Person].[DelayEnd' +
        '_date],'
      
        '[Person].[Health],[Person].[HealthDocNo],[Person].[HealthDoc_dat' +
        'e],[Person].[Warfare],[Person].[ASOrder_In],[Person].[ASDate_In]' +
        ','
      
        '[Person].[ASOut_ORD_NUMB],[Person].[ASOut_ORD_Date],[Person].[AS' +
        'Out_Date],[Person].[AppLast],[Person].[AppLastAll],[Person].[App' +
        'LastStudy],'
      
        '[Person].[ASAppLast],[Person].[ASAppFirst],[Person].[AppFirst],[' +
        'Person].[AppFirstStudy],[Person].[Med_Where],[Person].[Med_Date]' +
        ','
      
        '[Person].[Med_Result],[Person].[Psy_Where],[Person].[Psy_Date],[' +
        'Person].[Psy_Result],[Person].[Asf_Sport],[Person].[Mob_Days],'
      
        '[Person].[Mob_Hours],[Person].[Mob_Mins],[Person].[Mob_CardDate]' +
        ',[Person].[Mob_MissReason],[Person].[WUCHET2_Ser],'
      
        '[Person].[WUCHET2_IsWork],[Person].[PDPCode],[Person].[WRNG_Date' +
        '], [Person].[Driver], [Person].[MobContract],'
      'Left([Person].[Comments], 255) as Comments,'
      'iif(Person.Male=1,'#39#1052#39','#39#1046#39') as PersonMale,'
      '  SGN(LEN([Person].WUchet2)),'
      '    IIF(ISNULL([Person].W_DEND),0,1) AS W_EndCount,'
      '    IIF([PERSON].W_DEND is NULL and ('
      
        '         ([PERSON].MALE=1 and (KWRangeX.M_LIMIT is not NULL) and' +
        '  (#FullAges#[PERSON].BIRTHDAY#)>=KWRangeX.M_LIMIT  ) or'
      
        '         ([PERSON].MALE=0 and (KWRangeX.FEM_LIMIT is not NULL) a' +
        'nd  (#FullAges#[PERSON].BIRTHDAY#)>=KWRangeX.FEM_LIMIT  ))'
      '        ,1,0) AS TooOld,'
      
        '   iif([Person].MedResult=1,'#39#1042#1086#1079#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1086#1090#1089#1088#1086#1095#1082#1080#39',iif([Person' +
        '].MedResult=2,'#39#1057#1085#1103#1090#1080#1077' '#1089' '#1074#1086#1080#1085#1089#1082#1086#1075#1086' '#1091#1095#1077#1090#1072#39')) as MedResultText,'
      
        '   iif(Branch=0,'#39#1056#1040#39',iif(Branch=1,'#39#1042#1052#1060#39',iif(Branch=2,'#39#1060#1057#1041#39',iif(B' +
        'ranch=3,'#39#1052#1042#1044#39','#39#39')))) as BranchName,'
      
        '   WUchet1+iif(SpecialWUchet1=1,'#39' '#1057#1087#1077#1094#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077#39','#39#39') as WUch1' +
        ','
      
        '   iif(IsNull(WUCHET2_Ser) or WUCHET2_Ser='#39#39','#39#39','#39#1057#1077#1088#1080#1103' '#39'+WUCHET2' +
        '_Ser+'#39' '#39')+iif(IsNull(WUCHET2) or WUCHET2='#39#39','#39#39','#39#8470' '#39'+WUCHET2) as ' +
        'WUch2,'
      '   PersonReservChkInfo.Reserved,'
      '   PersonReservChkInfo.MainWork,'
      '   PersonReservChkInfo.PermanentWork,'
      '   PersonReservChkInfo.WARTIME,'
      '   PersonReservChkInfo.DefVUS,'
      '   PersonReservChkInfo.Command300,'
      '   PersonReservChkInfo.EOARMY_YEAR,'
      '   PersonReservChkInfo.DefPOST,'
      '   PersonReservChkInfo.DefPOST_Post,'
      '   PersonReservChkInfo.DefPOST_WRange,'
      '   PersonReservChkInfo.DefPOST_WSost,'
      '   PersonReservChkInfo.IS_BAD,'
      
        '   PersonReservChkInfo.IsStudent,    PersonReservChkInfo.StudWRa' +
        'ngeOk,    PersonReservChkInfo.IsIgnore,'
      '    '
      '   ph0.PH_NUMBER as PHONEWRK, --PHONEWRK'
      '   ph1.PH_NUMBER as PHONEDOM, --PHONEDOM'
      '   ph2.PH_NUMBER as PHONEMOB, --PHONEMOB'
      '   addr1.ADDR_STR as ADDRPASS, --ADDRPASS'
      '   addr2.ADDR_STR as ADDRREAL, --ADDRREAL'
      '   addr1.POST_CODE as INDADDRPASS, --INDADDRPASS !!I'
      '   addr2.POST_CODE as INDADDRREAL, --INDADDRREAL !!I'
      '   addr1.ADDR_DATE_END, --ADDR_DATE_END !!D'
      ''
      '   [KPOST].CPROF2015_ID AS CPROF_ID, --CPROF_ID !!I'
      '   [KPOST].POST_NAME, --POST_NAME'
      
        '   iif([KPOST].CPROF_ID=500 or [KPOST].CPROF2015_ID=500,'#39#39',iif([' +
        'Person].Is_Rab=0,'#39#1076#1072#39','#39#1085#1077#1090#39')) as Gos, --Gos'
      
        '   iif([KPOST].CPROF_ID=500 or [KPOST].CPROF2015_ID=500, [Person' +
        '].Dog_Numb, null) as Dog_NumbStudy, --Dog_NumbStudy'
      
        '   iif([KPOST].CPROF_ID=500 or [KPOST].CPROF2015_ID=500, [Person' +
        '].Dog_Date, null) as Dog_DateStudy, --Dog_DateStudy !!D'
      
        '   iif([KPOST].CPROF_ID=500 or [KPOST].CPROF2015_ID=500, null, [' +
        'Person].Dog_Numb) as Dog_NumbWork, --Dog_NumbWork'
      
        '   iif([KPOST].CPROF_ID=500 or [KPOST].CPROF2015_ID=500, null, [' +
        'Person].Dog_Date) as Dog_DateWork, --Dog_DateWork !!D'
      ''
      
        '   iif([KPOST].CPROF_ID=500 or [KPOST].CPROF2015_ID=500, Appoint' +
        'mentFirstStudy.In_Ord_Numb, null) as In_Ord_NumbStudy, --In_Ord_' +
        'NumbStudy'
      
        '   iif([KPOST].CPROF_ID=500 or [KPOST].CPROF2015_ID=500, Appoint' +
        'mentFirstStudy.In_Ord_Date, null) as In_Ord_DateStudy, --In_Ord_' +
        'DateStudy !!D'
      
        '   iif([KPOST].CPROF_ID=500 or [KPOST].CPROF2015_ID=500, Appoint' +
        'mentFirstStudy.In_Date, null) as In_DateStudy, --In_DateStudy !!' +
        'D'
      ''
      '   AppointmentFirst.In_Date as BeginWork_Date, '
      
        '   AppointmentFirstStudy.In_Date as BeginStudy_Date, --BeginStud' +
        'y_Date !!D'
      ''
      '   PStudy.Post_Name as PostStudy, --PostStudy'
      
        '   [KDepart].Dep_name,   [KDepart].Dep_full_name,   [KDepart].KD' +
        'epart_num,'
      '   [KDepart].IS_ASF, '
      
        '   iif(IsNull([ASF].OrgSName), '#39#39', [ASF].OrgSName) As ASFName, -' +
        '-ASFName'
      '   [ASPX].DEP_Name As ASDep_Name, --ASDep_Name'
      '   KWRangeX.WRng_Name AS WRange, KWRangeX.State As WRState,'
      '   KWRangeX.Che AS Che,'
      '   AppointmentLastAll.Probation_Date,'
      ''
      '   ASAppointmentFirst.In_Date As ASIn_Date, --ASIn_Date !!D'
      '   [ASPOST].POST_NAME As ASPost_Name, --ASPost_Name'
      ''
      '   [KFSTATE].FST_NAME, --FST_NAME'
      '   [KEDUC].ED_NAME, --ED_NAME'
      '   [KCPROF].CPROF_NAME, --CPROF_NAME'
      '   [KOVK].OVK_NAME, --OVK_NAME'
      '   [KDelay].DelayName, --DelayName'
      '   [KNapr].NAPR_KOD+" / "+[KNapr].NAPR_NAME as Napr, --Napr'
      '   [KWsost].WSost_Name, --WSOST_NAME'
      ''
      '   [KUZ1].UZ_Name as KUZ_Name1, --KUZ_Name1'
      '   [KObrDoc1].KObrDoc_Name as KObrDoc_Name1, --KObrDoc_Name1'
      '   [KKval1].KVal_Name as KVal_Name1, --KVal_Name1'
      '   [KNapr1].Napr_Name as Napr_Name1, --Napr_Name1'
      '   [EDUC1].Diplom as Diplom1, --Diplom1'
      '   [EDUC1].Diplom_Ser as Diplom_Ser1, --Diplom_Ser1'
      '   [EDUC1].End_Date as End_Date1, --End_Date1'
      '   [KUZ2].UZ_Name as KUZ_Name2, --KUZ_Name2'
      '   [KObrDoc2].KObrDoc_Name as KObrDoc_Name2, --KObrDoc_Name2'
      '   [KKval2].KVal_Name as KVal_Name2, --KVal_Name2'
      '   [KNapr2].Napr_Name as Napr_Name2, --Napr_Name2'
      '   [EDUC2].Diplom as Diplom2, --Diplom2'
      '   [EDUC2].Diplom_Ser as Diplom_Ser2, --Diplom_Ser2'
      '   [EDUC2].End_Date as End_Date2, --End_Date2'
      ''
      '   KOKPDTR.KOKPDTR_Code, --KOKPDTR_Code'
      '   KOKPDTR.KOKPDTR_Name, --KOKPDTR_Name'
      '   KWKTYPE.WTP_Name, --WTP_Name'
      '   KWKCHAR.WCH_Name, --WCH_Name'
      ''
      '   KAssign.Name as AssignText, --AssignText'
      ''
      '   1 As Foo'
      ''
      ' FROM ((((((((((((((((((((((((((((((((((((((((((('
      
        ' '#9#9#9'[Person] INNER JOIN PersonReservChkInfo ON [Person].PERS_ID ' +
        '= PersonReservChkInfo.PERS_ID)'
      
        ' left outer join Appointment As AppointmentLastAll on [Person].A' +
        'ppLastAll=AppointmentLastAll.Id)'
      
        '                  left outer join [KDepart] on AppointmentLastAl' +
        'l.Dep_Id=[KDepart].Dep_Id) '
      
        #9#9#9#9'  left outer join [KPOST] on [KPOST].POST_ID=AppointmentLast' +
        'All.POST_ID) --CPROF_ID --POST_NAME --Gos --Dog_NumbStudy --Dog_' +
        'DateStudy --Dog_NumbWork --Dog_DateWork --CPROF_NAME --KOKPDTR_C' +
        'ode --KOKPDTR_Name !!!'
      
        #9#9#9#9'  left outer join KCPROF2015 as [KCPROF] on [KCPROF].CPROF_I' +
        'D=iif(IsNull([KPOST].CPROF2015_ID),[KPOST].CPROF_ID,[KPOST].CPRO' +
        'F2015_ID)) --CPROF_NAME !!!'
      '    '
      
        ' LEFT outer JOIN KWKTYPE ON KWKTYPE.WTP_ID=AppointmentLastAll.WT' +
        'P_ID) --WTP_Name !!!'
      
        ' LEFT outer JOIN KWKCHAR ON KWKCHAR.WCH_ID=AppointmentLastAll.WC' +
        'H_ID) --WCH_Name !!!'
      
        ' LEFT outer JOIN KOKPDTR ON KOKPDTR.KOKPDTR_ID=KPOST.KOKPDTR) --' +
        'KOKPDTR_Code --KOKPDTR_Name !!!'
      ''
      ' left outer join Assign on Assign.Pers_ID=[Person].PERS_ID) '
      
        ' left outer join KAssign on KAssign.ID=Assign.KAssign) --AssignT' +
        'ext !!!'
      '        '
      
        ' left outer join ASAppointmentLastAll on [Person].ASAppLast=ASAp' +
        'pointmentLastAll.Id) --ASDep_Name --ASPost_Name --ASFName !!!'
      
        '                  left outer join (select ASP_ID, ASF_ID, DEP_NA' +
        'ME from ASP) as ASPX on ASAppointmentLastAll.ASP_Id=[ASPX].ASP_I' +
        'd) --ASDep_Name --ASFName !!!'
      
        '                  left outer join ASF on ASF.ASF_Id = ASAppointm' +
        'entLastAll.ASFX_Id) --ASFName --ASDep_Name !!!'
      
        '                  left outer join [ASPOST] on [ASPOST].ASPOST_ID' +
        '=ASAppointmentLastAll.ASPOST_ID) --ASPost_Name !!!'
      ''
      
        ' left outer join [Phones] ph0 on (ph0.PERS_ID=[Person].PERS_ID a' +
        'nd ph0.PH_TYPE = 1)) --PHONEWRK !!!'
      
        ' left outer join [Phones] ph1 on (ph1.PERS_ID=[Person].PERS_ID a' +
        'nd ph1.PH_TYPE = 2)) --PHONEDOM !!!'
      
        ' left outer join [Phones] ph2 on (ph2.PERS_ID=[Person].PERS_ID a' +
        'nd ph2.PH_TYPE = 3)) --PHONEMOB !!!'
      
        ' left outer join [ADDR] addr1 on (addr1.PERS_ID=[Person].PERS_ID' +
        ' and addr1.ADDR_TYPE = 0)) --ADDRPASS --INDADDRPASS --ADDR_DATE_' +
        'END !!!'
      
        ' left outer join [ADDR] addr2 on (addr2.PERS_ID=[Person].PERS_ID' +
        ' and addr2.ADDR_TYPE = 1)) --ADDRREAL --INDADDRREAL !!!'
      ''
      
        ' left outer join [KWRange] as KWRangeX on [Person].WRng_Id=KWRan' +
        'geX.WRng_Id)'
      
        ' left outer join [KWSost] on [Person].WSost_Id=[KWSost].WSost_Id' +
        ') ---WSOST_NAME !!!'
      
        ' left outer join [KFSTATE] on [KFSTATE].FST_ID=[Person].FST_ID) ' +
        '--FST_NAME !!!'
      
        ' left outer join [KEDUC] on [KEDUC].ED_ID=[Person].ED_ID) --ED_N' +
        'AME !!!'
      
        ' left outer join [EDUC] on ([EDUC].Pers_ID=[Person].Pers_ID and ' +
        '[Educ].Type=4)) --Napr --End_Date !!!'
      
        ' left outer join [KNapr] on [KNapr].Napr_ID=[Educ].Napr_ID) --Na' +
        'pr !!!'
      
        ' left outer join [KOVK] on [KOVK].OVK_ID=[Person].OVK_ID) --OVK_' +
        'NAME !!!'
      
        ' left outer join [KDelay] on [KDelay].ID=[Person].Delay_ID) --De' +
        'layName !!!'
      ''
      
        ' left outer join EDUC as [EDUC1] on ([EDUC1].Pers_ID=[Person].Pe' +
        'rs_ID and [Educ1].Type=1)) --KUZ_Name1 --KObrDoc_Name1 --KVal_Na' +
        'me1 --Napr_Name1 --Diplom1 --Diplom_Ser1 --End_Date1 !!!'
      
        ' left outer join KUZ as [KUZ1] on [KUZ1].UZ_ID=[Educ1].UZ_ID) --' +
        'KUZ_Name1 !!!'
      
        ' left outer join KObrDoc as [KObrDoc1] on [KObrDoc1].KObrDoc_ID=' +
        '[Educ1].ObrDoc_ID) --KObrDoc_Name1 !!!'
      
        ' left outer join KKval as [KKval1] on [KKval1].Kval_ID=[Educ1].K' +
        'val_ID) --Kval_Name1 !!!'
      
        ' left outer join KNapr as [KNapr1] on [KNapr1].Napr_ID=[Educ1].N' +
        'apr_ID) --Napr_Name1 !!!'
      
        ' left outer join EDUC as [EDUC2] on ([EDUC2].Pers_ID=[Person].Pe' +
        'rs_ID and [Educ2].Type=2)) --KUZ_Name2 --KObrDoc_Name2 --KVal_Na' +
        'me2 --Napr_Name2 --Diplom2 --Diplom_Ser2 --End_Date2 !!!'
      
        ' left outer join KUZ as [KUZ2] on [KUZ2].UZ_ID=[Educ2].UZ_ID) --' +
        'KUZ_Name2 !!!'
      
        ' left outer join KObrDoc as [KObrDoc2] on [KObrDoc2].KObrDoc_ID=' +
        '[Educ2].ObrDoc_ID) --KObrDoc_Name2 !!!'
      
        ' left outer join KKval as [KKval2] on [KKval2].Kval_ID=[Educ2].K' +
        'val_ID) --Kval_Name2 !!!'
      
        ' left outer join KNapr as [KNapr2] on [KNapr2].Napr_ID=[Educ2].N' +
        'apr_ID) --Napr_Name2 !!!'
      ''
      
        ' left outer join Appointment As AppointmentFirst on [Person].App' +
        'Last=AppointmentFirst.Id) '
      
        ' left outer join ASAppointment as ASAppointmentFirst on [Person]' +
        '.ASAppFirst=ASAppointmentFirst.Id) --ASIn_Date !!!'
      
        ' left outer join Appointment As AppointmentFirstStudy on [Person' +
        '].AppFirstStudy=AppointmentFirstStudy.Id)  --In_Ord_NumbStudy --' +
        'In_Ord_DateStudy --In_DateStudy --BeginStudy_Date !!!'
      
        ' left outer join Appointment As AppointmentLastStudy on [Person]' +
        '.AppLastStudy=AppointmentLastStudy.Id) --PostStudy --LastStudy !' +
        '!! '
      
        ' '#9#9#9#9'left outer join [KPOST] as PStudy on PStudy.POST_ID=Appoint' +
        'mentLastStudy.POST_ID) --PostStudy !!!'
      
        'left outer join PDP on PDP.POST_ID = AppointmentLastAll.POST_ID)' +
        ' --PDPCode !!! '#9#9#9
      'WHERE 1=1'
      
        'and  (PDP.Limited = 0 OR Person.WCAT="'#1042'") AND InStr(PDP.WSOST, "' +
        '."&Person.WSOST_ID&".")>0 AND  (PDP.WRange=0 OR PDP.CHE >= KWRan' +
        'geX.CHE) AND  PDP.Age <= #FullAges#[PERSON].BIRTHDAY# And --PDPC' +
        'ode ???'
      
        '  ((PDP.Sex=1 and Person.Male=1) or (PDP.Sex=2 and Person.Male<>' +
        '1) or IsNull(PDP.Sex) or (PDP.Sex<>1 and PDP.Sex <>2)) --PDPCode' +
        ' ???')
    TabOrder = 1
    Visible = False
    WordWrap = False
  end
  object ActionList1: TActionList
    Images = dmMain.ilSmall
    OnUpdate = ActionList1Update
    Left = 244
    Top = 156
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      ImageIndex = 21
      ShortCut = 45
      OnExecute = actAddExecute
    end
    object actEdit: TAction
      Caption = #1055#1088#1072#1074#1080#1090#1100
      Hint = #1055#1088#1072#1074#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      ImageIndex = 9
      ShortCut = 13
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      ImageIndex = 33
      ShortCut = 16430
      OnExecute = actDelExecute
    end
    object actFiltr: TAction
      Caption = #1060#1080#1083#1100#1090#1088
      Hint = #1060#1080#1083#1100#1090#1088' '#1089#1087#1080#1089#1082#1072' '#1083#1080#1095#1085#1099#1093' '#1082#1072#1088#1090#1086#1095#1077#1082
      ImageIndex = 34
      ShortCut = 16454
      OnExecute = actFiltrExecute
    end
    object actRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
      ImageIndex = 40
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
    object actExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1074' Microsoft Excel'
      ImageIndex = 39
      OnExecute = actExcelExecute
    end
    object actStoreSet: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1072#1073#1086#1088
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1085#1072#1073#1086#1088' '#1076#1083#1103' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1086#1090#1095#1077#1090#1085#1086#1089#1090#1080
      ImageIndex = 15
      OnExecute = actStoreSetExecute
    end
    object actClearSet: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1085#1072#1073#1086#1088
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1085#1072#1073#1086#1088' '#1076#1083#1103' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1086#1090#1095#1077#1090#1085#1086#1089#1090#1080
      ImageIndex = 7
      OnExecute = actClearSetExecute
    end
    object actWhyIsBad: TAction
      Caption = #1054#1073' '#1086#1096#1080#1073#1082#1077
      Hint = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1086#1096#1080#1073#1082#1077' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1103
      ImageIndex = 18
      ShortCut = 120
      OnExecute = actWhyIsBadExecute
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
      #1054#1089#1085#1086#1074#1085#1086#1081
      #1060#1091#1085#1082#1094#1080#1080' '#1088#1072#1073#1086#1090#1099' '#1089' '#1085#1072#1073#1086#1088#1086#1084)
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
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'dxBarButton1'
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
          ItemName = 'dxBarButton7'
        end
        item
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
          ItemName = 'dxBarButton11'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton10'
        end>
      NotDocking = [dsNone]
      OldName = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRecentItems = False
      Visible = True
      WholeRow = True
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
      Action = actRefresh
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Action = actExcel
      Category = 0
    end
    object dxBarButton7: TdxBarButton
      Action = actStoreSet
      Category = 0
      ButtonStyle = bsDropDown
      DropDownMenu = dxBarPopupMenu1
    end
    object dxBarButton10: TdxBarButton
      Action = actWhyIsBad
      Category = 0
    end
    object dxBarButton11: TdxBarButton
      Caption = #1050#1086#1083#1086#1085#1082#1080' '#1090#1072#1073#1083#1080#1094#1099
      Category = 0
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1082#1086#1083#1086#1085#1086#1082' '#1090#1072#1073#1083#1080#1094#1099
      Visible = ivAlways
      ImageIndex = 57
      OnClick = dxBarButton11Click
    end
    object dxBarButton8: TdxBarButton
      Action = actStoreSet
      Category = 1
    end
    object dxBarButton9: TdxBarButton
      Action = actClearSet
      Category = 1
    end
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    OnCalcFields = qrDataCalcFields
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        [Person].*'
      '      , IIF(ISNULL([Person].W_DEND),0,1) AS W_EndCount  '
      '      , [KDepart].Dep_name'
      '      , [ASF].OrgSName As ASFName'
      '      , [ASP].DEP_Name As ASDep_Name'
      '      , [KWRange].WRng_Name AS WRange'
      '      , [KWRange].Che AS Che'
      '      , [KPOST].CPROF_ID AS CPROF_ID'
      '      , [KPOST].POST_NAME'
      '      , [ASPOST].POST_NAME As ASPost_Name'
      '      , PersonReservChkInfo.Reserved'
      '      , PersonReservChkInfo.MainWork'
      '      , PersonReservChkInfo.PermanentWork'
      '      , PersonReservChkInfo.WARTIME'
      '      , PersonReservChkInfo.DefVUS'
      '      , PersonReservChkInfo.Command300'
      '      , PersonReservChkInfo.EOARMY_YEAR'
      '      , PersonReservChkInfo.DefPOST'
      '      , PersonReservChkInfo.IS_BAD'
      '  , ph0.PH_NUMBER as PHONEWRK'
      '  , ph1.PH_NUMBER as PHONEDOM'
      '  , ph2.PH_NUMBER as PHONEMOB'
      '  , addr1.ADDR_STR as ADDRPASS'
      '  , addr2.ADDR_STR as ADDRREAL'
      '  , addr1.POST_CODE as INDADDRPASS'
      '  , addr2.POST_CODE as INDADDRREAL'
      '      , IIF([PERSON].W_DEND is NULL and ('
      
        '         ([PERSON].MALE=1 and ([KWRANGE].M_LIMIT is not NULL) an' +
        'd  (YEAR(date()-[PERSON].BIRTHDAY)-1898-1)>[KWRANGE].M_LIMIT  ) ' +
        'or'
      
        '         ([PERSON].MALE=0 and ([KWRANGE].FEM_LIMIT is not NULL) ' +
        'and  (YEAR(date()-[PERSON].BIRTHDAY)-1898-1)>[KWRANGE].FEM_LIMIT' +
        '  ))'
      '        ,1,0) AS TooOld,'
      'AppointmentLast.In_Date as BeginWork_Date,'
      'ASAppointmentFirst.In_Date As ASIn_Date,'
      'AppointmentLastStudy.In_Date as BeginStudy_Date,'
      '[KFSTATE].FST_NAME, [KEDUC].ED_NAME, [KCPROF].CPROF_NAME,'
      
        'iif(Branch=0,'#39#1056#1040#39',iif(Branch=1,'#39#1042#1052#1060#39',iif(Branch=2,'#39#1060#1057#1041#39',iif(Bran' +
        'ch=3,'#39#1052#1042#1044#39','#39#39')))) as BranchName,'
      '[KOVK].OVK_NAME, [KDelay].DelayName, '
      
        'iif([KPOST].CPROF_ID=500,'#39#39',iif([Person].Is_Rab=0,'#39#1076#1072#39','#39#1085#1077#1090#39')) a' +
        's Gos, '
      'AssignLast.AssignText, PStudy.Post_Name as PostStudy,'
      
        'iif([KPOST].CPROF_ID=500, null, [Person].Dog_Numb) as Dog_NumbSt' +
        'udy,iif([KPOST].CPROF_ID=500, null, [Person].Dog_Date) as Dog_Da' +
        'teStudy,'
      
        'iif([KPOST].CPROF_ID=500, [Person].Dog_Numb, null) as Dog_NumbWo' +
        'rk,iif([KPOST].CPROF_ID=500, [Person].Dog_Date, null) as Dog_Dat' +
        'eWork,'
      '[KNapr].NAPR_KOD+" / "+[KNapr].NAPR_NAME as Napr,'
      
        'iif([Person].MedResult=1,'#39#1042#1086#1079#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1086#1090#1089#1088#1086#1095#1082#1080#39',iif([Person].M' +
        'edResult=2,'#39#1057#1085#1103#1090#1080#1077' '#1089' '#1074#1086#1080#1085#1089#1082#1086#1075#1086' '#1091#1095#1077#1090#1072#39')) as MedResultText, KDepar' +
        't.IS_ASF'
      ''
      
        ' FROM (((((((((((((((((((((((([Person] INNER JOIN PersonReservCh' +
        'kInfo ON [Person].PERS_ID = PersonReservChkInfo.PERS_ID)'
      ' left outer join (AppointmentLastAll'
      
        '                  left outer join [KDepart] on AppointmentLastAl' +
        'l.Dep_Id=[KDepart].Dep_Id)'
      '            on [Person].Pers_Id=AppointmentLastAll.Pers_Id)'
      ' left outer join ((ASAppointmentLastAll'
      
        '                  left outer join ASP on ASAppointmentLastAll.AS' +
        'P_Id=[ASP].ASP_Id)'
      
        '                  left outer join ASF on ASF.ASF_Id = ASP.ASF_Id' +
        ')'
      '            on [Person].Pers_Id=ASAppointmentLastAll.Pers_Id)'
      ' left outer join (select * from [Appointment] a where ID ='
      
        '                  (select Min(ID) from [Appointment] b where a.P' +
        'ers_Id = b.Pers_Id and not exists(select 1 from [Appointment] wh' +
        'ere In_Date < b.In_Date and Pers_Id = b.Pers_Id)))'
      '                 as AppointmentFirst '
      '            on [Person].Pers_Id=AppointmentFirst.Pers_Id)'
      ' left outer join (select * from [Assign] a where Assign_ID ='
      
        '                  (select Min(Assign_ID) from [Assign] b where a' +
        '.Pers_Id = b.Pers_Id and not exists(select 1 from [Assign] where' +
        ' Assign_Date > b.Assign_Date and Pers_Id = b.Pers_Id)))'
      '                 as AssignLast '
      '            on [Person].Pers_Id=AssignLast.Pers_Id)'
      
        ' left outer join [KWRange] on [Person].WRng_Id=[KWRange].WRng_Id' +
        ')'
      
        ' left outer join [KPOST] on [KPOST].POST_ID=AppointmentLastAll.P' +
        'OST_ID)'
      
        ' left outer join [ASPOST] on [ASPOST].ASPOST_ID=ASAppointmentLas' +
        'tAll.ASPOST_ID)'
      
        ' left outer join [Phones] ph0 on (ph0.PERS_ID=[Person].PERS_ID a' +
        'nd ph0.PH_TYPE = 1))'
      
        ' left outer join [Phones] ph1 on (ph1.PERS_ID=[Person].PERS_ID a' +
        'nd ph1.PH_TYPE = 2))'
      
        ' left outer join [Phones] ph2 on (ph2.PERS_ID=[Person].PERS_ID a' +
        'nd ph2.PH_TYPE = 3))'
      
        ' left outer join [ADDR] addr1 on (addr1.PERS_ID=[Person].PERS_ID' +
        ' and addr1.ADDR_TYPE = 0))'
      
        ' left outer join [ADDR] addr2 on (addr2.PERS_ID=[Person].PERS_ID' +
        ' and addr2.ADDR_TYPE = 1))'
      ' left outer join [KFSTATE] on [KFSTATE].FST_ID=[Person].FST_ID)'
      ' left outer join [KEDUC] on [KEDUC].ED_ID=[Person].ED_ID)'
      
        ' left outer join [EDUC] on ([EDUC].Pers_ID=[Person].Pers_ID and ' +
        '[Educ].Type=4))'
      ' left outer join [KNapr] on [KNapr].Napr_ID=[Educ].Napr_ID)'
      ' left outer join [KCPROF] on [KCPROF].CPROF_ID=[KPOST].CPROF_ID)'
      ' left outer join [KOVK] on [KOVK].OVK_ID=[Person].OVK_ID)'
      ' left outer join [KDelay] on [KDelay].ID=[Person].Delay_ID)'
      
        ' left outer join AppointmentLast on [Person].Pers_Id=Appointment' +
        'Last.Pers_Id)'
      ' left outer join (select * from [Appointment] a where ID ='
      
        '                   (select Max(ID) from [Appointment] b where a.' +
        'Pers_Id = b.Pers_Id and not exists(select 1 from [Appointment] w' +
        'here In_Date > b.In_Date and Pers_Id = b.Pers_Id)) '
      
        '                    and post_id in (select post_id from kpost wh' +
        'ere cprof_id = 500)'
      
        '                   ) AppointmentLastStudy on [Person].Pers_Id=Ap' +
        'pointmentLastStudy.Pers_Id)'
      ' left outer join (select * from [Appointment] a where ID ='
      
        '                   (select min(ID) from [Appointment] b where a.' +
        'Pers_Id = b.Pers_Id and not exists(select 1 from [Appointment] w' +
        'here In_Date < b.In_Date and Pers_Id = b.Pers_Id)) '
      
        '                    and post_id in (select post_id from kpost wh' +
        'ere cprof_id = 500)'
      
        '                   ) AppointmentFirstStudy on [Person].Pers_Id=A' +
        'ppointmentFirstStudy.Pers_Id)'
      ' left outer join (select * from [ASAppointment] a where ID ='
      
        '                  (select Min(ID) from [ASAppointment] b where a' +
        '.Pers_Id = b.Pers_Id and not exists(select 1 from [ASAppointment' +
        '] where In_Date < b.In_Date and Pers_Id = b.Pers_Id)))'
      '                 as ASAppointmentFirst '
      '            on [Person].Pers_Id=ASAppointmentFirst.Pers_Id)'
      
        ' left outer join [KPOST] as PStudy on PStudy.POST_ID=Appointment' +
        'LastStudy.POST_ID'
      'WHERE 1=1'
      ''
      ''
      '')
    Left = 408
    Top = 108
    object qrDataFIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'FIO'
      Size = 100
      Calculated = True
    end
    object qrDataFLD_A: TStringField
      FieldKind = fkCalculated
      FieldName = 'FLD_A'
      Size = 1
      Calculated = True
    end
    object qrDataFLD_B: TStringField
      FieldKind = fkCalculated
      FieldName = 'FLD_B'
      Size = 1
      Calculated = True
    end
    object qrDataMobFlag: TStringField
      FieldKind = fkCalculated
      FieldName = 'MobFlag'
      Calculated = True
    end
    object qrDataPERS_ID: TIntegerField
      FieldName = 'PERS_ID'
    end
    object qrDataORG_ID: TIntegerField
      FieldName = 'ORG_ID'
    end
    object qrDataFAM: TWideStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrDataIM: TWideStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrDataOTCH: TWideStringField
      FieldName = 'OTCH'
      Size = 50
    end
    object qrDataMALE: TSmallintField
      FieldName = 'MALE'
    end
    object qrDataBIRTHDAY: TDateTimeField
      FieldName = 'BIRTHDAY'
    end
    object qrDataBIRTHPLACE: TWideStringField
      FieldName = 'BIRTHPLACE'
      Size = 100
    end
    object qrDataOKATO: TWideStringField
      FieldName = 'OKATO'
      Size = 11
    end
    object qrDataNAT_ID: TIntegerField
      FieldName = 'NAT_ID'
    end
    object qrDataPSP_SER: TWideStringField
      FieldName = 'PSP_SER'
      Size = 10
    end
    object qrDataPSP_NUM: TWideStringField
      FieldName = 'PSP_NUM'
      Size = 10
    end
    object qrDataPSP_PLACE: TWideStringField
      FieldName = 'PSP_PLACE'
      Size = 100
    end
    object qrDataPSP_DATE: TDateTimeField
      FieldName = 'PSP_DATE'
    end
    object qrDataINN: TWideStringField
      FieldName = 'INN'
      Size = 12
    end
    object qrDataSTRAH: TWideStringField
      FieldName = 'STRAH'
    end
    object qrDataFST_ID: TIntegerField
      FieldName = 'FST_ID'
    end
    object qrDataED_ID: TIntegerField
      FieldName = 'ED_ID'
    end
    object qrDataSC_ID: TIntegerField
      FieldName = 'SC_ID'
    end
    object qrDataIS_WAR: TSmallintField
      FieldName = 'IS_WAR'
    end
    object qrDataCPROF_ID: TIntegerField
      FieldName = 'CPROF_ID'
    end
    object qrDataCSOST: TSmallintField
      FieldName = 'CSOST'
    end
    object qrDataWRNG_ID: TIntegerField
      FieldName = 'WRNG_ID'
    end
    object qrDataWSOST_ID: TIntegerField
      FieldName = 'WSOST_ID'
    end
    object qrDataCAT_ZAP: TSmallintField
      FieldName = 'CAT_ZAP'
    end
    object qrDataVUS: TWideStringField
      FieldName = 'VUS'
      Size = 7
    end
    object qrDataWCAT: TWideStringField
      FieldName = 'WCAT'
      Size = 1
    end
    object qrDataOVK_ID: TIntegerField
      FieldName = 'OVK_ID'
    end
    object qrDataWUCHET1: TWideStringField
      FieldName = 'WUCHET1'
      Size = 100
    end
    object qrDataWUCHET2: TWideStringField
      FieldName = 'WUCHET2'
      Size = 100
    end
    object qrDataWDISCL: TWideStringField
      FieldName = 'WDISCL'
      Size = 100
    end
    object qrDataTAB_NUMB: TWideStringField
      FieldName = 'TAB_NUMB'
      Size = 10
    end
    object qrDataDOG_NUMB: TWideStringField
      FieldName = 'DOG_NUMB'
    end
    object qrDataDOG_DATE: TDateTimeField
      FieldName = 'DOG_DATE'
    end
    object qrDataIS_RAB: TSmallintField
      FieldName = 'IS_RAB'
    end
    object qrDataPROF1: TWideStringField
      FieldName = 'PROF1'
      Size = 50
    end
    object qrDataOKPDTR1: TWideStringField
      FieldName = 'OKPDTR1'
      Size = 10
    end
    object qrDataPROF2: TWideStringField
      FieldName = 'PROF2'
      Size = 50
    end
    object qrDataOKPDTR2: TWideStringField
      FieldName = 'OKPDTR2'
      Size = 10
    end
    object qrDataCONFDATE: TDateTimeField
      FieldName = 'CONFDATE'
    end
    object qrDataNUMB_T2: TIntegerField
      FieldName = 'NUMB_T2'
    end
    object qrDataW_DBEG: TDateTimeField
      FieldName = 'W_DBEG'
    end
    object qrDataW_DEND: TDateTimeField
      FieldName = 'W_DEND'
    end
    object qrDataD_OVK: TDateTimeField
      FieldName = 'D_OVK'
    end
    object qrDataD_WBIL: TDateTimeField
      FieldName = 'D_WBIL'
    end
    object qrDataDep_name: TWideStringField
      FieldName = 'Dep_name'
      Size = 50
    end
    object qrDataWRange: TWideStringField
      FieldName = 'WRange'
      Size = 100
    end
    object qrDataReserved: TIntegerField
      FieldName = 'Reserved'
    end
    object qrDataWartime: TIntegerField
      FieldName = 'Wartime'
    end
    object qrDataDefVUS: TIntegerField
      FieldName = 'DefVUS'
    end
    object qrDataCommand300: TIntegerField
      FieldName = 'Command300'
    end
    object qrDataEOARMY_DATE: TWideStringField
      FieldName = 'EOARMY_DATE'
    end
    object qrDataDefPost: TIntegerField
      FieldName = 'DefPost'
    end
    object qrDataIS_BAD: TIntegerField
      FieldName = 'IS_BAD'
    end
    object qrDataMainWork: TIntegerField
      FieldName = 'MainWork'
    end
    object qrDataPermanentWork: TIntegerField
      FieldName = 'PermanentWork'
    end
    object qrDataPOST_NAME: TStringField
      FieldName = 'POST_NAME'
      Size = 50
    end
    object qrDataSpecialWUchet1: TIntegerField
      FieldName = 'SpecialWUchet1'
    end
    object qrDataW_EndCount: TIntegerField
      FieldName = 'W_EndCount'
    end
    object qrDataChe: TIntegerField
      FieldName = 'Che'
    end
    object qrDataWID: TStringField
      FieldName = 'WID'
      Size = 10
    end
    object qrDataWBser: TStringField
      DisplayLabel = #1057#1077#1088#1080#1103' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      FieldName = 'WBser'
      Size = 2
    end
    object qrDataWBNum: TStringField
      DisplayLabel = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      FieldName = 'WBNum'
      Size = 8
    end
    object qrDataTooOld: TIntegerField
      FieldName = 'TooOld'
    end
    object qrDataOUT_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1103
      FieldName = 'OUT_DATE'
    end
    object qrDataOUT_ORD_NUMB: TStringField
      DisplayLabel = #1053#1086#1084#1077#1088' '#1087#1088#1080#1082#1072#1079#1072' '#1086#1073' '#1091#1074#1086#1083#1100#1085#1077#1085#1080#1080
      FieldName = 'OUT_ORD_NUMB'
      Size = 50
    end
    object qrDataEndAkadem_date: TDateField
      FieldName = 'EndAkadem_date'
    end
    object qrDataRealEndAkadem_date: TDateField
      FieldName = 'RealEndAkadem_date'
    end
    object qrDataDismissal_Date: TDateField
      FieldName = 'Dismissal_Date'
    end
    object qrDataBeginWork_Date: TDateField
      FieldName = 'BeginWork_Date'
    end
    object qrDataBeginStudy_Date: TDateField
      FieldName = 'BeginStudy_Date'
    end
    object qrDataPHONEMOB: TStringField
      FieldName = 'PHONEMOB'
    end
    object qrDataPHONEDOM: TStringField
      FieldName = 'PHONEDOM'
    end
    object qrDataADDRPASS: TStringField
      FieldName = 'ADDRPASS'
      Size = 100
    end
    object qrDataADDRREAL: TStringField
      FieldName = 'ADDRREAL'
      Size = 100
    end
    object qrDataOUT_ORD_DATE: TDateTimeField
      FieldName = 'OUT_ORD_DATE'
    end
    object qrDataWUCHET2_date: TDateTimeField
      FieldName = 'WUCHET2_date'
    end
    object qrDataDocument: TIntegerField
      FieldName = 'Document'
    end
    object qrDataBranch: TIntegerField
      FieldName = 'Branch'
    end
    object qrDataIsAspirant: TIntegerField
      FieldName = 'IsAspirant'
    end
    object qrDataStudyForm: TIntegerField
      FieldName = 'StudyForm'
    end
    object qrDataStudyEnd_date: TDateTimeField
      FieldName = 'StudyEnd_date'
    end
    object qrDataOrderAkadem: TWideStringField
      FieldName = 'OrderAkadem'
    end
    object qrDataOrderAkadem_date: TDateTimeField
      FieldName = 'OrderAkadem_date'
    end
    object qrDataReasonAkadem: TWideStringField
      FieldName = 'ReasonAkadem'
      Size = 100
    end
    object qrDataBeginAkadem_date: TDateTimeField
      FieldName = 'BeginAkadem_date'
    end
    object qrDataMedResult_date: TDateTimeField
      FieldName = 'MedResult_date'
    end
    object qrDataMedResult: TIntegerField
      FieldName = 'MedResult'
    end
    object qrDataVKStatus: TIntegerField
      FieldName = 'VKStatus'
    end
    object qrDataBeginWar_date: TDateTimeField
      FieldName = 'BeginWar_date'
    end
    object qrDataEndWar_date: TDateTimeField
      FieldName = 'EndWar_date'
    end
    object qrDataRealEndWar_date: TDateTimeField
      FieldName = 'RealEndWar_date'
    end
    object qrDataReasonEndWar: TWideStringField
      FieldName = 'ReasonEndWar'
      Size = 100
    end
    object qrDataOrderDismissal: TWideStringField
      FieldName = 'OrderDismissal'
    end
    object qrDataOrderDismissal_date: TDateTimeField
      FieldName = 'OrderDismissal_date'
    end
    object qrDataReasonDismissal: TWideStringField
      FieldName = 'ReasonDismissal'
      Size = 100
    end
    object qrDataDisserName: TWideStringField
      FieldName = 'DisserName'
      Size = 100
    end
    object qrDataDegree_ID: TIntegerField
      FieldName = 'Degree_ID'
    end
    object qrDataGuideDegree_ID: TIntegerField
      FieldName = 'GuideDegree_ID'
    end
    object qrDataFIOGuide: TWideStringField
      FieldName = 'FIOGuide'
      Size = 100
    end
    object qrDataDefend_date: TDateTimeField
      FieldName = 'Defend_date'
    end
    object qrDataRealDefend_date: TDateTimeField
      FieldName = 'RealDefend_date'
    end
    object qrDataContractEnd: TWideStringField
      FieldName = 'ContractEnd'
      Size = 50
    end
    object qrDataKval_Id: TIntegerField
      FieldName = 'Kval_Id'
    end
    object qrDataDelay_ID: TIntegerField
      FieldName = 'Delay_ID'
    end
    object qrDataDelayStart_date: TDateTimeField
      FieldName = 'DelayStart_date'
    end
    object qrDataDelayEnd_date: TDateTimeField
      FieldName = 'DelayEnd_date'
    end
    object qrDataHealth: TWideStringField
      FieldName = 'Health'
      Size = 60
    end
    object qrDataHealthDocNo: TWideStringField
      FieldName = 'HealthDocNo'
      Size = 60
    end
    object qrDataHealthDoc_date: TDateTimeField
      FieldName = 'HealthDoc_date'
    end
    object qrDataWarfare: TWideStringField
      FieldName = 'Warfare'
      Size = 255
    end
    object qrDataEOARMY_YEAR: TWideStringField
      FieldName = 'EOARMY_YEAR'
      Size = 10
    end
    object qrDataINDADDRPASS: TIntegerField
      FieldName = 'INDADDRPASS'
    end
    object qrDataINDADDRREAL: TIntegerField
      FieldName = 'INDADDRREAL'
    end
    object qrDataPHONEWRK: TWideStringField
      FieldName = 'PHONEWRK'
      Size = 50
    end
    object qrDataFST_NAME: TWideStringField
      FieldName = 'FST_NAME'
      Size = 50
    end
    object qrDataED_NAME: TWideStringField
      FieldName = 'ED_NAME'
      Size = 50
    end
    object qrDataCPROF_NAME: TWideStringField
      FieldName = 'CPROF_NAME'
      Size = 100
    end
    object qrDataBranchName: TWideStringField
      FieldName = 'BranchName'
      ReadOnly = True
      Size = 255
    end
    object qrDataOVK_NAME: TWideStringField
      FieldName = 'OVK_NAME'
      Size = 100
    end
    object qrDataDelayName: TWideStringField
      FieldName = 'DelayName'
      Size = 255
    end
    object qrDataGos: TWideStringField
      FieldName = 'Gos'
      ReadOnly = True
      Size = 255
    end
    object qrDataPostStudy: TWideStringField
      FieldName = 'PostStudy'
      Size = 255
    end
    object qrDataDog_NumbStudy: TWideStringField
      FieldName = 'Dog_NumbStudy'
      ReadOnly = True
      Size = 255
    end
    object qrDataDog_DateStudy: TDateTimeField
      FieldName = 'Dog_DateStudy'
      ReadOnly = True
    end
    object qrDataDog_NumbWork: TWideStringField
      FieldName = 'Dog_NumbWork'
      ReadOnly = True
      Size = 255
    end
    object qrDataDog_DateWork: TDateTimeField
      FieldName = 'Dog_DateWork'
      ReadOnly = True
    end
    object qrDataNapr: TWideStringField
      FieldName = 'Napr'
      ReadOnly = True
      Size = 255
    end
    object qrDataMedResultText: TWideStringField
      FieldName = 'MedResultText'
      ReadOnly = True
      Size = 255
    end
    object qrDataASOrder_In: TWideStringField
      FieldName = 'ASOrder_In'
    end
    object qrDataASDate_In: TDateTimeField
      FieldName = 'ASDate_In'
    end
    object qrDataASOut_ORD_NUMB: TWideStringField
      FieldName = 'ASOut_ORD_NUMB'
      Size = 50
    end
    object qrDataASOut_ORD_Date: TDateTimeField
      FieldName = 'ASOut_ORD_Date'
    end
    object qrDataASOut_Date: TDateTimeField
      FieldName = 'ASOut_Date'
    end
    object qrDataASDep_Name: TWideStringField
      FieldName = 'ASDep_Name'
      ReadOnly = True
      Size = 255
    end
    object qrDataASPost_Name: TWideStringField
      FieldName = 'ASPost_Name'
      Size = 250
    end
    object qrDataASIn_Date: TDateTimeField
      FieldName = 'ASIn_Date'
    end
    object qrDataIS_ASF: TBooleanField
      FieldName = 'IS_ASF'
    end
    object qrDataAppLast: TIntegerField
      FieldName = 'AppLast'
    end
    object qrDataAppLastAll: TIntegerField
      FieldName = 'AppLastAll'
    end
    object qrDataAppLastStudy: TIntegerField
      FieldName = 'AppLastStudy'
    end
    object qrDataAppFirst: TIntegerField
      FieldName = 'AppFirst'
    end
    object qrDataAppFirstStudy: TIntegerField
      FieldName = 'AppFirstStudy'
    end
    object qrDataASAppLast: TIntegerField
      FieldName = 'ASAppLast'
    end
    object qrDataASAppFirst: TIntegerField
      FieldName = 'ASAppFirst'
    end
    object qrDataMed_Where: TWideStringField
      FieldName = 'Med_Where'
      Size = 40
    end
    object qrDataMed_Date: TDateTimeField
      FieldName = 'Med_Date'
    end
    object qrDataMed_Result: TWideStringField
      FieldName = 'Med_Result'
      Size = 100
    end
    object qrDataPsy_Where: TWideStringField
      FieldName = 'Psy_Where'
      Size = 40
    end
    object qrDataPsy_Date: TDateTimeField
      FieldName = 'Psy_Date'
    end
    object qrDataPsy_Result: TWideStringField
      FieldName = 'Psy_Result'
      Size = 100
    end
    object qrDataAsf_Sport: TWideStringField
      FieldName = 'Asf_Sport'
      Size = 40
    end
    object qrDataASFName: TWideStringField
      FieldName = 'ASFName'
      Size = 100
    end
    object qrDataWUCHET2_IsWork: TIntegerField
      FieldName = 'WUCHET2_IsWork'
    end
    object qrDataDefPost_Post: TIntegerField
      FieldName = 'DefPost_Post'
    end
    object qrDataDefPost_WRange: TIntegerField
      FieldName = 'DefPost_WRange'
    end
    object qrDataDefPost_WSost: TIntegerField
      FieldName = 'DefPost_WSost'
    end
    object qrDataWSost_Name: TStringField
      FieldName = 'WSost_Name'
      Size = 50
    end
    object qrDataWUch1: TStringField
      FieldName = 'WUch1'
      Size = 100
    end
    object qrDataMob_CardDate: TDateField
      FieldName = 'Mob_CardDate'
    end
    object qrDataMob_MissReason: TStringField
      FieldName = 'Mob_MissReason'
      Size = 255
    end
    object qrDataWUch2: TStringField
      FieldName = 'WUch2'
      Size = 100
    end
    object qrDataWRng_Date: TDateTimeField
      FieldName = 'WRng_Date'
    end
    object qrDataPersonMale: TStringField
      FieldName = 'PersonMale'
      Size = 5
    end
    object qrDataKUZ_Name1: TStringField
      FieldName = 'KUZ_Name1'
      Size = 255
    end
    object qrDataKObrDoc_Name1: TStringField
      FieldName = 'KObrDoc_Name1'
      Size = 255
    end
    object qrDataKVal_Name1: TStringField
      FieldName = 'KVal_Name1'
      Size = 255
    end
    object qrDataNapr_Name1: TStringField
      FieldName = 'Napr_Name1'
      Size = 255
    end
    object qrDataDiplom1: TStringField
      FieldName = 'Diplom1'
      Size = 50
    end
    object qrDataDiplom_Ser1: TStringField
      FieldName = 'Diplom_Ser1'
      Size = 50
    end
    object qrDataEnd_Date1: TStringField
      FieldName = 'End_Date1'
      Size = 50
    end
    object qrDataKUZ_Name2: TStringField
      FieldName = 'KUZ_Name2'
      Size = 255
    end
    object qrDataKObrDoc_Name2: TStringField
      FieldName = 'KObrDoc_Name2'
      Size = 255
    end
    object qrDataKVal_Name2: TStringField
      FieldName = 'KVal_Name2'
      Size = 255
    end
    object qrDataNapr_Name2: TStringField
      FieldName = 'Napr_Name2'
      Size = 255
    end
    object qrDataDiplom2: TStringField
      FieldName = 'Diplom2'
      Size = 50
    end
    object qrDataDiplom_Ser2: TStringField
      FieldName = 'Diplom_Ser2'
      Size = 50
    end
    object qrDataEnd_Date2: TStringField
      FieldName = 'End_Date2'
      Size = 50
    end
    object qrDataDep_Full_Name: TStringField
      FieldName = 'Dep_Full_Name'
      Size = 255
    end
    object qrDataKOKPDTR_Code: TStringField
      FieldName = 'KOKPDTR_Code'
      Size = 50
    end
    object qrDataKOKPDTR_Name: TStringField
      FieldName = 'KOKPDTR_Name'
      Size = 255
    end
    object qrDataWTP_Name: TStringField
      FieldName = 'WTP_Name'
      Size = 50
    end
    object qrDataWCH_Name: TStringField
      FieldName = 'WCH_Name'
      Size = 50
    end
    object qrDataComments: TStringField
      FieldName = 'Comments'
      Size = 255
    end
    object qrDataAssignText: TStringField
      FieldName = 'AssignText'
      Size = 255
    end
    object qrDataADDR_DATE_END: TDateTimeField
      FieldName = 'ADDR_DATE_END'
    end
    object qrDataIn_Ord_NumbStudy: TStringField
      FieldName = 'In_Ord_NumbStudy'
      Size = 255
    end
    object qrDataIn_Ord_DateStudy: TDateField
      FieldName = 'In_Ord_DateStudy'
    end
    object qrDataIn_DateStudy: TDateField
      FieldName = 'In_DateStudy'
    end
    object qrDataIsStudent: TIntegerField
      FieldName = 'IsStudent'
    end
    object qrDataStudWRangeOk: TIntegerField
      FieldName = 'StudWRangeOk'
    end
    object qrDataIsIgnore: TBooleanField
      FieldName = 'IsIgnore'
    end
    object qrDataProbation_Date: TDateField
      FieldName = 'Probation_Date'
    end
    object qrDataDriver: TIntegerField
      FieldName = 'Driver'
    end
    object qrDataMobContract: TDateTimeField
      FieldName = 'MobContract'
    end
  end
  object DataSource1: TDataSource
    DataSet = qrData
    Left = 392
    Top = 196
  end
  object PopupMenu1: TPopupMenu
    Images = dmMain.ilSmall
    Left = 124
    Top = 108
    object N1: TMenuItem
      Action = actAdd
    end
    object N2: TMenuItem
      Action = actEdit
    end
    object N3: TMenuItem
      Action = actDel
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Action = actFiltr
    end
    object N6: TMenuItem
      Action = actRefresh
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object N10: TMenuItem
      Action = actWhyIsBad
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Action = actExcel
    end
  end
  object qrReserv: TADOQuery
    Connection = dmMain.dbMain
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM RES_LIST')
    Left = 508
    Top = 184
  end
  object dxBarPopupMenu1: TdxBarPopupMenu
    BarManager = dxBarManager1
    ItemLinks = <
      item
        Visible = True
        ItemName = 'dxBarButton8'
      end
      item
        Visible = True
        ItemName = 'dxBarButton9'
      end>
    UseOwnFont = False
    Left = 184
    Top = 140
  end
end

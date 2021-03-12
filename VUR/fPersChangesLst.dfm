object fmPersonChangesList: TfmPersonChangesList
  Left = 306
  Top = 164
  HelpContext = 16
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1080#1079#1084#1077#1085#1077#1085#1080#1103#1093' '#1074' '#1091#1095#1077#1090#1085#1099#1093' '#1076#1072#1085#1085#1099#1093' '#1088#1072#1073#1086#1090#1085#1080#1082#1086#1074' '#1080' '#1091#1095#1072#1097#1080#1093#1089#1103
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
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
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
        Width = 440
      end
      item
        Caption = #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
        Width = 172
      end
      item
      end
      item
        Caption = #1051#1080#1089#1090#1086#1082'-'#1089#1086#1086#1073#1097#1077#1085#1080#1077
      end>
    DefaultLayout = False
    HeaderMinRowCount = 3
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    KeyField = 'CHANGE_ID'
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
    OnDblClick = dbgDataDblClick
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
    OptionsBehavior = [edgoAnsiSort, edgoAutoSearch, edgoAutoSort, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSort, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoFullSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoIndicator, edgoRowAutoHeight, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    ShowBands = True
    OnColumnSorting = dbgDataColumnSorting
    object dbgDataNum: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = '          '#8470' '#1087'/'#1087
      DisableDragging = True
      DisableEditor = True
      HeaderAlignment = taCenter
      Sizing = False
      Width = 30
      BandIndex = 0
      RowIndex = 0
      OnGetText = dbgDataNumGetText
    end
    object dbgDataColumnFIO: TdxDBGridColumn
      Caption = 
        '                                                          '#1060#1072#1084#1080#1083#1080 +
        #1103' '#1080' '#1080#1085#1080#1094#1080#1072#1083#1099
      DisableEditor = True
      HeaderAlignment = taCenter
      Width = 151
      BandIndex = 0
      RowIndex = 0
      FieldName = 'FIO'
      SummaryFooterType = cstCount
      SummaryFooterFormat = '0'
    end
    object dbgDataColumn3: TdxDBGridColumn
      Caption = 
        '                                                     '#1042#1086#1080#1085#1089#1082#1086#1077' '#1079#1074 +
        #1072#1085#1080#1077
      DisableEditor = True
      HeaderAlignment = taCenter
      Width = 133
      BandIndex = 1
      RowIndex = 0
      FieldName = 'WRANGE'
    end
    object dbgDataColumn5: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
      DisableEditor = True
      HeaderAlignment = taCenter
      Width = 65
      BandIndex = 1
      RowIndex = 0
      FieldName = 'BIRTHDAY'
    end
    object dbgDataColumn7: TdxDBGridColumn
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077', '#1076#1086#1083#1078#1085#1086#1089#1090#1100
      DisableEditor = True
      HeaderAlignment = taCenter
      Width = 101
      BandIndex = 1
      RowIndex = 0
      FieldName = 'DEPPOST'
    end
    object dbgDataGROUP_NAME: TdxDBGridColumn
      Caption = 
        '                                                      '#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085 +
        #1080#1077' '#1087#1086#1083#1103
      DisableEditor = True
      HeaderAlignment = taCenter
      Width = 150
      BandIndex = 2
      RowIndex = 0
      FieldName = 'GROUP_NAME'
    end
    object dbgDataOldValue: TdxDBGridMemoColumn
      Caption = 
        '                                                                ' +
        ' '#1057#1090#1072#1088#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 150
      BandIndex = 2
      RowIndex = 0
      HeaderMaxLineCount = 1
      FieldName = 'OLDVALUE'
    end
    object dbgDataNewValue: TdxDBGridMemoColumn
      Caption = 
        '                                                            '#1053#1086#1074#1086 +
        #1077' '#1079#1085#1072#1095#1077#1085#1080#1077
      HeaderAlignment = taCenter
      Width = 150
      BandIndex = 2
      RowIndex = 0
      HeaderMaxLineCount = 1
      FieldName = 'NEWVALUE'
    end
    object dbgDataChange_Date: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1074#1085#1077#1089#1077#1085#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1074' '#1041#1044
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 3
      RowIndex = 0
      FieldName = 'CHANGE_DATE'
    end
    object dbgDataBegin_Date: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1074#1088#1091#1095#1077#1085#1080#1103' '#1083#1080#1089#1090#1082#1072' '#1088#1072#1073#1086#1090#1085#1080#1082#1091
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 3
      RowIndex = 0
      FieldName = 'BEGIN_DATE'
    end
    object dbgDataNotBeginReason: TdxDBGridColumn
      Caption = 
        #1044#1088#1091#1075#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' ('#1087#1088#1080#1095#1080#1085#1072' '#1085#1077#1074#1088#1091#1095#1077#1085#1080#1103', '#1076#1072#1090#1072' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1087#1086#1095#1090#1086#1081' '#1080' '#1076#1088 +
        '.)'
      HeaderAlignment = taCenter
      Width = 150
      BandIndex = 3
      RowIndex = 0
      FieldName = 'NOTBEGINREASON'
    end
    object dbgDataEnd_Date: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1083#1080#1089#1090#1082#1072' '#1074' '#1054#1042#1050
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 3
      RowIndex = 0
      FieldName = 'END_DATE'
    end
    object dbgDataSend_Date: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1089#1074#1077#1076#1077#1085#1080#1081' '#1074' '#1054#1042#1050
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 3
      RowIndex = 0
      FieldName = 'SEND_DATE'
    end
    object dbgDataOutNumber: TdxDBGridColumn
      Caption = #1048#1089#1093#1086#1076#1103#1097#1080#1081' '#8470
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'OutNumber'
    end
    object dbgDataOutDate: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072
      HeaderAlignment = taCenter
      Width = 100
      BandIndex = 4
      RowIndex = 0
      FieldName = 'OutDate'
    end
  end
  object DataSQL: TMemo
    Left = 448
    Top = 112
    Width = 81
    Height = 25
    Lines.Strings = (
      'SELECT'
      '        [Person].PERS_ID'
      '      , [Person].FAM'
      '      , [Person].IM'
      '      , [Person].OTCH'
      '      , [Person].WRNG_ID'
      '      , [Person].BIRTHDAY'
      '      , [KWRange].WRng_Name AS WRange'
      '      , [KPOST].POST_NAME'
      '      , [KDEPART].DEP_NAME'
      '      , [PersonChanges].GROUP_ID'
      '      , [KL_FLDGROUPS].GROUP_NAME'
      '      , [PersonChanges].CHANGE_ID'
      '      , [PersonChanges].OLDVALUE'
      '      , [PersonChanges].NEWVALUE'
      '      , [PersonChanges].CHANGE_DATE'
      '      , [PersonChanges].BEGIN_DATE'
      '      , [PersonChanges].NOTBEGINREASON'
      '      , [PersonChanges].END_DATE'
      '      , [PersonChanges].SEND_DATE'
      '      , [PersonChanges].OutNumber'
      '      , [PersonChanges].OutDate'
      
        ' FROM ((((([Person] INNER JOIN [PersonChanges] on [PersonChanges' +
        '].PERS_ID = [Person].PERS_ID)'
      
        ' INNER JOIN [KL_FLDGROUPS] on [KL_FLDGROUPS].GROUP_ID = [PersonC' +
        'hanges].GROUP_ID)'
      ' left outer join (AppointmentLastAll'
      
        '                  left outer join [KDepart] on AppointmentLastAl' +
        'l.Dep_Id=[KDepart].Dep_Id)'
      '            on [Person].Pers_Id=AppointmentLastAll.Pers_Id)'
      
        ' left outer join [KWRange] on [Person].WRng_Id=[KWRange].WRng_Id' +
        ')'
      
        ' left outer join [KPOST] on [KPOST].POST_ID=AppointmentLastAll.P' +
        'OST_ID)'
      
        ' left outer join (select PERS_ID, 1 as VAL from [PersonChanges] ' +
        'pc where ((BEGIN_DATE is null and NOTBEGINREASON is null) or (EN' +
        'D_DATE is null and BEGIN_DATE is not null) or (END_DATE is not n' +
        'ull and BEGIN_DATE is not null and SEND_DATE is null)) and not e' +
        'xists(select 1 from [PersonChanges] where PERS_ID = pc.PERS_ID a' +
        'nd CHANGE_ID > pc.CHANGE_ID))  FLAG on FLAG.Pers_ID = [Person].P' +
        'ERS_ID'
      ' WHERE 1=1')
    TabOrder = 5
    Visible = False
    WordWrap = False
  end
  object ActionList1: TActionList
    Images = dmMain.ilSmall
    OnUpdate = ActionList1Update
    Left = 244
    Top = 156
    object actEdit: TAction
      Caption = #1055#1088#1072#1074#1080#1090#1100
      Hint = #1055#1088#1072#1074#1080#1090#1100
      ImageIndex = 9
      ShortCut = 13
      Visible = False
      OnExecute = actEditExecute
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100
      ImageIndex = 33
      ShortCut = 16430
      OnExecute = actDelExecute
    end
    object actFiltr: TAction
      Caption = #1060#1080#1083#1100#1090#1088
      Hint = #1060#1080#1083#1100#1090#1088' '#1089#1087#1080#1089#1082#1072' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
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
      Visible = False
      OnExecute = actStoreSetExecute
    end
    object actClearSet: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1085#1072#1073#1086#1088
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1085#1072#1073#1086#1088' '#1076#1083#1103' '#1087#1086#1089#1090#1088#1086#1077#1085#1080#1103' '#1086#1090#1095#1077#1090#1085#1086#1089#1090#1080
      ImageIndex = 7
      Visible = False
      OnExecute = actClearSetExecute
    end
    object actSave: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      ImageIndex = 38
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
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
          Visible = True
          ItemName = 'dxBarDBNavEdit1'
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
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Category = 0
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
      Visible = ivAlways
      ImageIndex = 21
      ShortCut = 45
    end
    object dxBarDBNavEdit1: TdxBarDBNavButton
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivNever
      ImageIndex = 9
      ShortCut = 13
      OnClick = actEditExecute
      NavButton = dxbnEdit
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
      Caption = #1054#1073' '#1086#1096#1080#1073#1082#1077
      Category = 0
      Hint = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086#1073' '#1086#1096#1080#1073#1082#1077' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1103
      Visible = ivAlways
      ImageIndex = 18
      ShortCut = 120
    end
    object dxBarDBNavPost1: TdxBarDBNavButton
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Category = 0
      Enabled = False
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Visible = ivAlways
      ImageIndex = 38
      NavButton = dxbnPost
    end
    object dxBarButton2: TdxBarButton
      Action = actSave
      Category = 0
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
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '        [Person].PERS_ID'
      '      , [Person].FAM'
      '      , [Person].IM'
      '      , [Person].OTCH'
      '      , [Person].WRNG_ID'
      '      , [Person].BIRTHDAY'
      '      , [KWRange].WRng_Name AS WRange'
      '      , [KPOST].POST_NAME'
      '      , [KDEPART].DEP_NAME'
      '      , [PersonChanges].GROUP_ID'
      '      , [KL_FLDGROUPS].GROUP_NAME'
      '      , [PersonChanges].CHANGE_ID'
      '      , [PersonChanges].OLDVALUE'
      '      , [PersonChanges].NEWVALUE'
      '      , [PersonChanges].CHANGE_DATE'
      '      , [PersonChanges].BEGIN_DATE'
      '      , [PersonChanges].NOTBEGINREASON'
      '      , [PersonChanges].END_DATE'
      '      , [PersonChanges].SEND_DATE'
      '      , [PersonChanges].OutNumber'
      '      , [PersonChanges].OutDate'
      
        ' FROM ((((([Person] INNER JOIN [PersonChanges] on [PersonChanges' +
        '].PERS_ID = [Person].PERS_ID)'
      
        ' INNER JOIN [KL_FLDGROUPS] on [KL_FLDGROUPS].GROUP_ID = [PersonC' +
        'hanges].GROUP_ID)'
      ' left outer join (AppointmentLastAll'
      
        '                  left outer join [KDepart] on AppointmentLastAl' +
        'l.Dep_Id=[KDepart].Dep_Id)'
      '            on [Person].Pers_Id=AppointmentLastAll.Pers_Id)'
      
        ' left outer join [KWRange] on [Person].WRng_Id=[KWRange].WRng_Id' +
        ')'
      
        ' left outer join [KPOST] on [KPOST].POST_ID=AppointmentLastAll.P' +
        'OST_ID)'
      
        ' left outer join (select PERS_ID, 1 as VAL from [PersonChanges] ' +
        'pc where ((BEGIN_DATE is null and NOTBEGINREASON is null) or (EN' +
        'D_DATE is null and BEGIN_DATE is not null) or (END_DATE is not n' +
        'ull and BEGIN_DATE is not null and SEND_DATE is null)) and not e' +
        'xists(select 1 from [PersonChanges] where PERS_ID = pc.PERS_ID a' +
        'nd CHANGE_ID > pc.CHANGE_ID))  FLAG on FLAG.Pers_ID = [Person].P' +
        'ERS_ID'
      ' WHERE 1=1')
    Left = 400
    Top = 108
    object qrDataFIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'FIO'
      Size = 100
      Calculated = True
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
    object qrDataWRNG_ID: TIntegerField
      FieldName = 'WRNG_ID'
    end
    object qrDataBIRTHDAY: TDateTimeField
      FieldName = 'BIRTHDAY'
    end
    object qrDataWRange: TWideStringField
      FieldName = 'WRange'
      Size = 100
    end
    object qrDataPOST_NAME: TWideStringField
      FieldName = 'POST_NAME'
      Size = 50
    end
    object qrDataDEP_NAME: TWideStringField
      FieldName = 'DEP_NAME'
      Size = 50
    end
    object qrDataGROUP_ID: TIntegerField
      FieldName = 'GROUP_ID'
    end
    object qrDataGROUP_NAME: TWideStringField
      FieldName = 'GROUP_NAME'
      Size = 255
    end
    object qrDataOLDVALUE: TWideMemoField
      FieldName = 'OLDVALUE'
      BlobType = ftWideMemo
    end
    object qrDataNEWVALUE: TWideMemoField
      FieldName = 'NEWVALUE'
      BlobType = ftWideMemo
    end
    object qrDataCHANGE_DATE: TDateTimeField
      FieldName = 'CHANGE_DATE'
    end
    object qrDataBEGIN_DATE: TDateTimeField
      FieldName = 'BEGIN_DATE'
    end
    object qrDataNOTBEGINREASON: TWideStringField
      FieldName = 'NOTBEGINREASON'
      Size = 255
    end
    object qrDataEND_DATE: TDateTimeField
      FieldName = 'END_DATE'
    end
    object qrDataSEND_DATE: TDateTimeField
      FieldName = 'SEND_DATE'
    end
    object qrDataDEPPOST: TStringField
      FieldKind = fkCalculated
      FieldName = 'DEPPOST'
      Size = 4000
      Calculated = True
    end
    object qrDataCHANGE_ID: TAutoIncField
      FieldName = 'CHANGE_ID'
    end
    object qrDataPERS_ID: TIntegerField
      FieldName = 'PERS_ID'
    end
    object qrDataOutNumber: TWideStringField
      FieldName = 'OutNumber'
      Size = 255
    end
    object qrDataOutDate: TDateTimeField
      FieldName = 'OutDate'
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
    object N7: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Action = actExcel
    end
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

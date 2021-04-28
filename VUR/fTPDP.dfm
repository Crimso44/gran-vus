object fmTPDP: TfmTPDP
  Left = 345
  Top = 250
  HelpContext = 12
  Caption = #1042#1099#1087#1080#1089#1082#1072' '#1080#1079' '#1055#1044#1055
  ClientHeight = 266
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 247
    Width = 589
    Height = 19
    Panels = <>
  end
  object dbgData: TdxDBGrid
    Left = 0
    Top = 26
    Width = 589
    Height = 221
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    KeyField = 'ID'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    PopupMenu = PopupMenu
    TabOrder = 5
    OnDblClick = dbgDataDblClick
    DataSource = dsData
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoAnsiSort, edgoAutoSort, edgoDblClick, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSort, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoRowAutoHeight, edgoRowSelect, edgoUseBitmap]
    RegistryPath = '\Software\Granit\GranVUS\TPDPDGrid'
    OnCustomDrawCell = dbgDataCustomDrawCell
    object dbgDataTPDP_ID: TdxDBGridMaskColumn
      Visible = False
      Width = 24
      BandIndex = 0
      RowIndex = 0
      FieldName = 'TPDP_ID'
    end
    object dbgDataCOND_ID: TdxDBGridMaskColumn
      Visible = False
      Width = 24
      BandIndex = 0
      RowIndex = 0
      FieldName = 'COND_ID'
    end
    object dbgDataWSosts: TdxDBGridMaskColumn
      Alignment = taLeftJustify
      Caption = #1057#1086#1089#1090#1072#1074'/'#1087#1088#1086#1092#1080#1083#1100
      HeaderAlignment = taCenter
      Width = 71
      BandIndex = 0
      RowIndex = 0
      FieldName = 'WSosts'
    end
    object dbgDataLimited: TdxDBGridCheckColumn
      Caption = #1054#1075#1088#1072#1085#1080#1095#1077#1085#1085#1086' '#1075#1086#1076#1085#1099#1084
      Width = 124
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Limited'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object dbgDataWRange: TdxDBGridMaskColumn
      Caption = #1044#1086' '#1079#1074#1072#1085#1080#1103
      Width = 120
      BandIndex = 0
      RowIndex = 0
      FieldName = 'WRange'
    end
    object dbgDataAge: TdxDBGridMaskColumn
      Caption = #1042' '#1074#1086#1079#1088#1072#1089#1090#1077' '#1089#1090#1072#1088#1096#1077
      Width = 108
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Age'
    end
    object dbgDataSexName: TdxDBGridColumn
      Caption = #1055#1086#1083
      Width = 50
      BandIndex = 0
      RowIndex = 0
      FieldName = 'SexName'
    end
    object dbgDataKOKPDTR: TdxDBGridMaskColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'KOKPDTR'
    end
    object dbgDataKOKPDTR_NAME: TdxDBGridMaskColumn
      Caption = #1050#1086#1076' '#1076#1086#1083#1078#1085#1086#1089#1090#1080' '#1087#1086' '#1054#1050#1055#1044#1058#1056
      Sorted = csUp
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'KOKPDTR_Name_Full'
      GroupIndex = 1
    end
    object dbgDataOKVED: TdxDBGridMaskColumn
      Caption = #1050#1086#1076' '#1054#1050#1042#1069#1044
      Sorted = csUp
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OKVED'
      GroupIndex = 0
    end
  end
  object dsData: TDataSource
    DataSet = qrData
    Left = 92
    Top = 72
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    AfterOpen = qrDataAfterOpen
    Parameters = <>
    SQL.Strings = (
      'SELECT [TPDP].ID&'#39'.'#39'&IIF((Cond.ID is null),0,Cond.ID) AS ID'
      '     , [TPDP].ID AS TPDP_ID'
      '     , [TPDP].OKVED'
      '     , [TPDP].KOKPDTR'
      '     , [KOKPDTR].KOKPDTR_CODE'
      '     , [KOKPDTR].KOKPDTR_Name'
      
        '     , [KOKPDTR].KOKPDTR_CODE + '#39' '#39' + [KOKPDTR].KOKPDTR_NAME As ' +
        'KOKPDTR_NAME_Full'
      '     , Cond.ID AS COND_ID'
      '     , Cond.Limited'
      
        '     , IIF(IIF((Cond.Age is null),0,Cond.Age)=0, '#39#1041#1077#1079' '#1086#1075#1088#1072#1085#1080#1095#1077#1085#1080 +
        #1103#39', Cond.Age) AS Age'
      
        '     , IIF(IIF((Cond.WRange is null),0,Cond.WRange)=0, '#39#1053#1077#1079#1072#1074#1080#1089#1080 +
        #1084#1086' '#1086#1090' '#1079#1074#1072#1085#1080#1103#39', Rng.WRNG_NAME) AS WRange'
      '     , Cond.WSosts'
      '     , IIF(Sex=1,'#39#1052#39',IIF(Sex=2,'#39#1046#39','#39#1052' '#1080' '#1046#39')) As SexName'
      '     , [KOKVED].Name As OKVED_Name'
      '  FROM ((([TPDP] '
      
        '       LEFT OUTER JOIN [TPDPCond] As Cond ON ([TPDP].ID=Cond.TPD' +
        'P_ID))'
      
        '       LEFT OUTER JOIN [KWRange] AS Rng ON (Cond.WRange=Rng.WRNG' +
        '_ID))'
      
        '       LEFT OUTER JOIN [KOKPDTR] ON ([TPDP].KOKPDTR = [KOKPDTR].' +
        'KOKPDTR_ID))'
      
        '       LEFT OUTER JOIN [KOKVED] ON ([TPDP].OKVED = [KOKVED].Code' +
        ')'
      ''
      '')
    Left = 40
    Top = 72
    object qrDataID2: TStringField
      FieldName = 'ID'
      Size = 50
    end
    object qrDataTPDP_ID: TIntegerField
      FieldName = 'TPDP_ID'
    end
    object qrDataCOND_ID: TIntegerField
      FieldName = 'COND_ID'
    end
    object qrDataLimited: TIntegerField
      FieldName = 'Limited'
    end
    object qrDataAge: TStringField
      FieldName = 'Age'
      Size = 15
    end
    object qrDataWRange: TStringField
      FieldName = 'WRange'
      Size = 100
    end
    object qrDataWSosts: TStringField
      FieldName = 'WSosts'
      Size = 255
    end
    object qrDataSexName: TWideStringField
      FieldName = 'SexName'
      ReadOnly = True
      Size = 255
    end
    object qrDataKOKPDTR: TIntegerField
      FieldName = 'KOKPDTR'
    end
    object qrDataKOKPDTR_NAME: TStringField
      FieldName = 'KOKPDTR_NAME'
      Size = 255
    end
    object qrDataOKVED: TStringField
      FieldName = 'OKVED'
      Size = 8
    end
    object qrDataKOKPDTR_CODE: TStringField
      FieldName = 'KOKPDTR_CODE'
      Size = 10
    end
    object qrDataKOKPDTR_Name_Full: TStringField
      FieldName = 'KOKPDTR_Name_Full'
      Size = 250
    end
    object qrDataOKVED_Name: TWideStringField
      FieldName = 'OKVED_Name'
      Size = 255
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      #1054#1089#1085#1086#1074#1085#1086#1081)
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    ImageOptions.Images = dmMain.ilSmall
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 160
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
      Caption = #1053#1086#1074#1072#1103' '#1055#1072#1085#1077#1083#1100'1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 340
      FloatTop = 261
      FloatClientWidth = 23
      FloatClientHeight = 22
      ItemLinks = <
        item
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
        end>
      OldName = #1053#1086#1074#1072#1103' '#1055#1072#1085#1077#1083#1100'1'
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      UseRestSpace = True
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Action = actNew
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actEdit
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actDelete
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = actRefresh
      Category = 0
    end
  end
  object ActionList: TActionList
    Images = dmMain.ilSmall
    OnUpdate = ActionListUpdate
    Left = 36
    Top = 140
    object actNew: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1099#1081' '#1087#1091#1085#1082#1090' '#1087#1077#1088#1077#1095#1085#1103
      ImageIndex = 21
      ShortCut = 45
      OnExecute = actNewExecute
    end
    object actEdit: TAction
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1091#1085#1082#1090' '#1087#1077#1088#1077#1095#1085#1103
      ImageIndex = 9
      ShortCut = 13
      OnExecute = actEditExecute
    end
    object actDelete: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1087#1091#1085#1082#1090' '#1087#1077#1088#1077#1095#1085#1103
      ImageIndex = 33
      ShortCut = 46
      OnExecute = actDeleteExecute
    end
    object actRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1080#1079' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 40
      ShortCut = 116
      OnExecute = actRefreshExecute
    end
  end
  object PopupMenu: TPopupMenu
    Images = dmMain.ilSmall
    Left = 92
    Top = 124
    object N1: TMenuItem
      Action = actNew
    end
    object N2: TMenuItem
      Action = actEdit
    end
    object N3: TMenuItem
      Action = actDelete
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Action = actRefresh
    end
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 144
    Top = 56
  end
end

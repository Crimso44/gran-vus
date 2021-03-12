object fmAppointments: TfmAppointments
  Left = 307
  Top = 274
  HelpContext = 511
  Caption = #1055#1088#1080#1077#1084' '#1085#1072' '#1088#1072#1073#1086#1090#1091' '#1080' '#1087#1077#1088#1077#1074#1086#1076' '#1085#1072' '#1076#1088#1091#1075#1091#1102' '#1088#1072#1073#1086#1090#1091
  ClientHeight = 297
  ClientWidth = 681
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object qridAppointment: TdxDBGrid
    Left = 0
    Top = 26
    Width = 681
    Height = 252
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
    TabOrder = 4
    DataSource = dsAppointment
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoFullSizing, edgoRowSizing]
    OptionsDB = [edgoCanAppend, edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoIndicator, edgoUseBitmap]
    RegistryPath = '\Software\Granit\GranVUS\Person_AppointmentGrid'
    OnChangedColumnsWidth = qridAppointmentChangedColumnsWidth
    OnColumnSorting = qridAppointmentColumnSorting
    ExplicitWidth = 534
    object qridAppointmentID: TdxDBGridColumn
      Visible = False
      Width = 82
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ID'
    end
    object qridAppointmentPERS_ID: TdxDBGridColumn
      Visible = False
      Width = 82
      BandIndex = 0
      RowIndex = 0
      FieldName = 'PERS_ID'
    end
    object qridAppointmentNum: TdxDBGridColumn
      Caption = #8470' '#1087'/'#1087
      DisableDragging = True
      DisableEditor = True
      Sizing = False
      Width = 40
      BandIndex = 0
      RowIndex = 0
      OnGetText = qridAppointmentNumGetText
    end
    object qridAppointmentWTP: TdxDBGridLookupColumn
      Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090#1099
      Width = 172
      BandIndex = 0
      RowIndex = 0
      FieldName = 'WTP_NAME'
      DropDownRows = 20
    end
    object qridAppointmentWCH: TdxDBGridLookupColumn
      Caption = #1061#1072#1088#1072#1082#1090#1077#1088' '#1088#1072#1073#1086#1090#1099
      Width = 175
      BandIndex = 0
      RowIndex = 0
      FieldName = 'WCH_NAME'
      DropDownRows = 20
    end
    object qridAppointmentPOST: TdxDBGridLookupColumn
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      Width = 124
      BandIndex = 0
      RowIndex = 0
      FieldName = 'POST_NAME'
      DropDownRows = 20
      DropDownWidth = 350
    end
    object qridAppointmentDEP: TdxDBGridLookupColumn
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Width = 124
      BandIndex = 0
      RowIndex = 0
      FieldName = 'DEP_NAME'
      DropDownRows = 20
      DropDownWidth = 350
    end
    object qridAppointmentIN_ORD_NUMB: TdxDBGridColumn
      Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
      Width = 83
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IN_ORD_NUMB'
    end
    object qridAppointmentIN_ORD_DATE: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1086#1089#1085#1086#1074#1072#1085#1080#1103
      Width = 106
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IN_ORD_DATE'
    end
    object qridAppointmentIN_DATE: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
      Sorted = csUp
      Width = 111
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IN_DATE'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 278
    Width = 681
    Height = 19
    Panels = <>
    ExplicitWidth = 534
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 224
    Top = 92
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'DB '#1053#1072#1074#1080#1075#1072#1090#1086#1088
      #1054#1089#1085#1086#1074#1085#1086#1081)
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 40
    Top = 48
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManager1Bar1: TdxBar
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
          ItemName = 'dxBarDBNavFirst1'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavPrev1'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavNext1'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavLast1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarDBNavInsert1'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavDelete1'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavEdit1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarDBNavPost1'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavCancel1'
        end>
      OldName = #1053#1086#1074#1072#1103' '#1055#1072#1085#1077#1083#1100'1'
      OneOnRow = True
      Row = 0
      ShowMark = False
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarDBNavFirst1: TdxBarDBNavButton
      Caption = #1055#1077#1088#1074#1072#1103
      Category = 0
      Enabled = False
      Hint = #1055#1077#1088#1074#1072#1103
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777087777778077777708777780007777770877800000777777088000000
        0777777087780000077777708777780007777770877777780777777777777777
        7777777777777777777777777777777777777777777777777777}
      BarDBNavigator = dxBarDBNavigator
      NavButton = dxbnFirst
    end
    object dxBarDBNavPrev1: TdxBarDBNavButton
      Caption = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103
      Category = 0
      Enabled = False
      Hint = #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777780777777777777800077777777778000007777777780000000
        7777777777800000777777777777800077777777777777807777777777777777
        7777777777777777777777777777777777777777777777777777}
      BarDBNavigator = dxBarDBNavigator
      NavButton = dxbnPrior
    end
    object dxBarDBNavNext1: TdxBarDBNavButton
      Caption = #1057#1083#1077#1076#1091#1102#1097#1072#1103
      Category = 0
      Enabled = False
      Hint = #1057#1083#1077#1076#1091#1102#1097#1072#1103
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777708777777777777770008777777777777000008777777777700000008
        7777777700000877777777770008777777777777087777777777777777777777
        7777777777777777777777777777777777777777777777777777}
      BarDBNavigator = dxBarDBNavigator
      NavButton = dxbnNext
    end
    object dxBarDBNavLast1: TdxBarDBNavButton
      Caption = #1055#1086#1089#1083#1077#1076#1085#1103#1103
      Category = 0
      Enabled = False
      Hint = #1055#1086#1089#1083#1077#1076#1085#1103#1103
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777087777778077777700087777807777770000087780777777000000088
        0777777000008778077777700087777807777770877777780777777777777777
        7777777777777777777777777777777777777777777777777777}
      BarDBNavigator = dxBarDBNavigator
      NavButton = dxbnLast
    end
    object dxBarDBNavInsert1: TdxBarDBNavButton
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Category = 0
      Enabled = False
      Hint = #1042#1089#1090#1072#1074#1080#1090#1100
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777000777
        7777777777000777777777777700077777777770000000007777777000000000
        7777777000000000777777777700077777777777770007777777777777000777
        7777777777777777777777777777777777777777777777777777}
      BarDBNavigator = dxBarDBNavigator
      NavButton = dxbnInsert
    end
    object dxBarDBNavDelete1: TdxBarDBNavButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 0
      Enabled = False
      Hint = #1059#1076#1072#1083#1080#1090#1100
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777770000000000777777000000000
        0777777000000000077777777777777777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777}
      BarDBNavigator = dxBarDBNavigator
      NavButton = dxbnDelete
    end
    object dxBarDBNavEdit1: TdxBarDBNavButton
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Category = 0
      Enabled = False
      Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777777777777
        7777777777777777777777700000000007777777000000007777777770000007
        7777777777000077777777777770077777777777777777777777777777777777
        7777777777777777777777777777777777777777777777777777}
      BarDBNavigator = dxBarDBNavigator
      NavButton = dxbnEdit
    end
    object dxBarDBNavPost1: TdxBarDBNavButton
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Category = 0
      Enabled = False
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777770777777
        7777777700077777777777700000777777777700070007777777770077700077
        7777777777770007777777777777700077777777777777000777777777777770
        0777777777777777777777777777777777777777777777777777}
      BarDBNavigator = dxBarDBNavigator
      NavButton = dxbnPost
    end
    object dxBarDBNavCancel1: TdxBarDBNavButton
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Category = 0
      Enabled = False
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
        7777777777777777777777777777777777777777777777777777777007777700
        7777777000777000777777770007000777777777700000777777777777000777
        7777777770000077777777770007000777777770007770007777777007777700
        7777777777777777777777777777777777777777777777777777}
      BarDBNavigator = dxBarDBNavigator
      NavButton = dxbnCancel
    end
  end
  object dxBarDBNavigator: TdxBarDBNavigator
    BarManager = dxBarManager1
    CategoryName = 'DB '#1053#1072#1074#1080#1075#1072#1090#1086#1088
    ConfirmDelete = False
    DataSource = dsAppointment
    DBCheckLinks = <>
    VisibleButtons = [dxbnFirst, dxbnPrior, dxbnNext, dxbnLast, dxbnInsert, dxbnDelete, dxbnEdit, dxbnPost, dxbnCancel]
    Left = 120
    Top = 60
  end
  object dsAppointment: TDataSource
    AutoEdit = False
    DataSet = qrAppointment
    Left = 60
    Top = 195
  end
  object qrAppointment: TADOQuery
    Connection = dmMain.dbMain
    BeforePost = qrAppointmentBeforePost
    AfterPost = qrAppointmentAfterPost
    BeforeDelete = qrAppointmentBeforeDelete
    AfterDelete = qrAppointmentAfterDelete
    OnNewRecord = qrAppointmentNewRecord
    Parameters = <
      item
        Name = 'PERS_ID'
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM Appointment WHERE PERS_ID = :PERS_ID'
      
        'AND POST_ID NOT IN (SELECT POST_ID FROM KPOST WHERE CPROF_ID = 5' +
        '00)')
    Left = 56
    Top = 147
    object qrAppointmentID: TIntegerField
      FieldName = 'ID'
    end
    object qrAppointmentPERS_ID: TIntegerField
      FieldName = 'PERS_ID'
    end
    object qrAppointmentWTP_ID: TIntegerField
      FieldName = 'WTP_ID'
    end
    object qrAppointmentWCH_ID: TIntegerField
      FieldName = 'WCH_ID'
    end
    object qrAppointmentPOST_ID: TIntegerField
      FieldName = 'POST_ID'
    end
    object qrAppointmentDEP_ID: TIntegerField
      FieldName = 'DEP_ID'
    end
    object qrAppointmentWTP_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'WTP_NAME'
      LookupDataSet = qrKWKTYPE
      LookupKeyFields = 'WTP_ID'
      LookupResultField = 'WTP_NAME'
      KeyFields = 'WTP_ID'
      Lookup = True
    end
    object qrAppointmentWCH_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'WCH_NAME'
      LookupDataSet = qrKWKCHAR
      LookupKeyFields = 'WCH_ID'
      LookupResultField = 'WCH_NAME'
      KeyFields = 'WCH_ID'
      Lookup = True
    end
    object qrAppointmentPOST_NAME: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'POST_NAME'
      LookupDataSet = qrKPOST
      LookupKeyFields = 'POST_ID'
      LookupResultField = 'XPOST_NAME'
      KeyFields = 'POST_ID'
      Size = 50
      Lookup = True
    end
    object qrAppointmentDEP_NAME: TStringField
      DisplayWidth = 50
      FieldKind = fkLookup
      FieldName = 'DEP_NAME'
      LookupDataSet = qrKDEPART
      LookupKeyFields = 'DEP_ID'
      LookupResultField = 'XDEP_NAME'
      KeyFields = 'DEP_ID'
      Size = 50
      Lookup = True
    end
    object qrAppointmentIN_ORD_DATE: TDateField
      FieldName = 'IN_ORD_DATE'
    end
    object qrAppointmentIN_DATE: TDateField
      FieldName = 'IN_DATE'
    end
    object qrAppointmentIN_ORD_NUMB: TStringField
      FieldName = 'IN_ORD_NUMB'
      Size = 255
    end
  end
  object qrKWKTYPE: TADOQuery
    Connection = dmMain.dbMain
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT WTP_ID, WTP_NAME FROM KWKTYPE'
      'UNION'
      'SELECT NULL, '#39'<'#1085#1077' '#1091#1082#1072#1079#1072#1085#1086'>'#39' FROM KWKTYPE'
      'ORDER BY WTP_NAME'
      '')
    Left = 116
    Top = 171
    object qrKWKTYPEWTP_ID: TIntegerField
      FieldName = 'WTP_ID'
    end
    object qrKWKTYPEWTP_NAME: TStringField
      FieldName = 'WTP_NAME'
    end
  end
  object qrKWKCHAR: TADOQuery
    Connection = dmMain.dbMain
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT WCH_ID, WCH_NAME FROM KWKCHAR'
      'UNION'
      'SELECT NULL, '#39'<'#1085#1077' '#1091#1082#1072#1079#1072#1085#1086'>'#39' FROM KWKCHAR'
      'ORDER BY WCH_NAME'
      '')
    Left = 176
    Top = 151
    object qrKWKCHARWCH_ID: TIntegerField
      FieldName = 'WCH_ID'
    end
    object qrKWKCHARWCH_NAME: TStringField
      FieldName = 'WCH_NAME'
    end
  end
  object qrKPOST: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT POST_ID, POST_NAME,'
      'POST_NAME + iif(is_old, '#39' ('#1091#1087#1088#1072#1079#1076#1085#1077#1085#1086')'#39', '#39#39') as XPost_Name, '
      'KPOST_Num FROM KPOST'
      'WHERE CPROF_ID <> 500 and CPROF2015_ID <> 500 '
      'UNION'
      'SELECT NULL, '#39#39', '#39'<'#1085#1077' '#1091#1082#1072#1079#1072#1085#1086'>'#39', -1 FROM KPOST'
      'Order By 1')
    Left = 232
    Top = 171
    object qrKPOSTPOST_ID: TIntegerField
      FieldName = 'POST_ID'
    end
    object qrKPOSTPOST_NAME: TStringField
      DisplayWidth = 50
      FieldName = 'POST_NAME'
      Size = 50
    end
    object qrKPOSTXPost_Name: TWideStringField
      FieldName = 'XPost_Name'
      Size = 255
    end
    object qrKPOSTKPOST_Num: TIntegerField
      FieldName = 'KPOST_Num'
    end
  end
  object qrKDEPART: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT DEP_ID, DEP_NAME,'
      'DEP_NAME + iif(is_old,'#39' ('#1091#1087#1088#1072#1079#1076#1085#1077#1085#1086')'#39', '#39#39') as XDep_Name, '
      'KDEPART_Num FROM KDEPART'
      'UNION'
      'SELECT NULL, '#39#39', '#39'<'#1085#1077' '#1091#1082#1072#1079#1072#1085#1086'>'#39', -1 FROM KDEPART'
      'Order By 1')
    Left = 292
    Top = 155
    object qrKDEPARTDEP_ID: TIntegerField
      FieldName = 'DEP_ID'
    end
    object qrKDEPARTDEP_NAME: TStringField
      DisplayWidth = 50
      FieldName = 'DEP_NAME'
      Size = 50
    end
    object qrKDEPARTXDep_Name: TWideStringField
      FieldName = 'XDep_Name'
      Size = 255
    end
    object qrKDEPARTKDEPART_Num: TIntegerField
      FieldName = 'KDEPART_Num'
    end
  end
end

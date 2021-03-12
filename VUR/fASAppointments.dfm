object fmASAppointments: TfmASAppointments
  Left = 307
  Top = 274
  HelpContext = 511
  Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1103' '#1074' '#1053#1040#1057#1060
  ClientHeight = 297
  ClientWidth = 534
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
    Width = 534
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
    object qridAppointmentPOST: TdxDBGridLookupColumn
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      Width = 124
      BandIndex = 0
      RowIndex = 0
      FieldName = 'POST_NAME'
      DropDownRows = 20
      DropDownWidth = 350
    end
    object qridAppointmentASF: TdxDBGridLookupColumn
      Caption = #1040#1057#1060
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Dep_Name_ASF'
      DropDownRows = 20
      DropDownWidth = 350
    end
    object qridAppointmentDEP: TdxDBGridLookupColumn
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1040#1057#1060
      Width = 124
      BandIndex = 0
      RowIndex = 0
      FieldName = 'DEP_NAME'
      OnEditButtonClick = qridAppointmentDEPEditButtonClick
      DropDownRows = 20
      DropDownWidth = 350
    end
    object qridAppointmentIN_ORD_NUMB: TdxDBGridColumn
      Caption = #1053#1086#1084#1077#1088' '#1087#1088#1080#1082#1072#1079#1072
      Width = 83
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IN_ORD_NUMB'
    end
    object qridAppointmentIN_ORD_DATE: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1082#1072#1079#1072
      Width = 56
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IN_ORD_DATE'
    end
    object qridAppointmentIN_DATE: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103
      Sorted = csUp
      BandIndex = 0
      RowIndex = 0
      FieldName = 'IN_DATE'
    end
    object qridAppointmentTRAINING: TdxDBGridColumn
      Caption = #1043#1076#1077' '#1087#1088#1086#1096#1077#1083' '#1086#1073#1091#1095#1077#1085#1080#1077
      Width = 250
      BandIndex = 0
      RowIndex = 0
      FieldName = 'TRAINING'
    end
    object qridAppointmentTRAINING_Date: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'TRAINING_Date'
    end
    object qridAppointmentTraining_Date_Out: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Training_Date_Out'
    end
    object qridAppointmentAttested_Id: TdxDBGridMaskColumn
      Caption = #1040#1090#1090#1077#1089#1090#1086#1074#1072#1085
      Visible = False
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Attested_Id'
    end
    object qridAppointmentAttested_Name: TdxDBGridLookupColumn
      Caption = #1040#1090#1090#1077#1089#1090#1086#1074#1072#1085
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Attested_Name'
    end
    object qridAppointmentAttested_Who: TdxDBGridColumn
      Caption = #1050#1077#1084' '#1072#1090#1090#1077#1089#1090#1086#1074#1072#1085
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Attested_Who'
    end
    object qridAppointmentAttested_Date: TdxDBGridDateColumn
      Caption = #1050#1086#1075#1076#1072' '#1072#1090#1090#1077#1089#1090#1086#1074#1072#1085
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Attested_Date'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 278
    Width = 534
    Height = 19
    Panels = <>
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
    CursorType = ctStatic
    BeforePost = qrAppointmentBeforePost
    AfterPost = qrAppointmentAfterPost
    BeforeDelete = qrAppointmentBeforeDelete
    AfterDelete = qrAppointmentAfterDelete
    OnNewRecord = qrAppointmentNewRecord
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = 0
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM ASAppointment WHERE PERS_ID = :PERS_ID')
    Left = 56
    Top = 147
    object qrAppointmentID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object qrAppointmentPERS_ID: TIntegerField
      FieldName = 'PERS_ID'
    end
    object qrAppointmentASPost_ID: TIntegerField
      FieldName = 'ASPost_ID'
    end
    object qrAppointmentASP_ID: TIntegerField
      FieldName = 'ASP_ID'
    end
    object qrAppointmentIN_ORD_NUMB: TWideStringField
      FieldName = 'IN_ORD_NUMB'
      Size = 50
    end
    object qrAppointmentIN_ORD_Date: TDateTimeField
      FieldName = 'IN_ORD_Date'
    end
    object qrAppointmentIN_Date: TDateTimeField
      FieldName = 'IN_Date'
    end
    object qrAppointmentPOST_Name: TStringField
      FieldKind = fkLookup
      FieldName = 'POST_Name'
      LookupDataSet = qrKPOST
      LookupKeyFields = 'ASPOST_ID'
      LookupResultField = 'POST_NAME'
      KeyFields = 'ASPost_ID'
      Size = 250
      Lookup = True
    end
    object qrAppointmentDep_Name: TStringField
      FieldKind = fkLookup
      FieldName = 'Dep_Name'
      LookupDataSet = qrASP
      LookupKeyFields = 'ASP_ID'
      LookupResultField = 'DEP_NAME'
      KeyFields = 'ASP_ID'
      Size = 250
      Lookup = True
    end
    object qrAppointmentTRAINING: TWideStringField
      FieldName = 'TRAINING'
      Size = 250
    end
    object qrAppointmentTRAINING_Date: TDateTimeField
      FieldName = 'TRAINING_Date'
    end
    object qrAppointmentATTESTED: TWideStringField
      FieldName = 'ATTESTED'
      Size = 50
    end
    object qrAppointmentDep_Name_ASF: TStringField
      FieldKind = fkLookup
      FieldName = 'Dep_Name_ASF'
      LookupDataSet = qrASF
      LookupKeyFields = 'ASF_ID'
      LookupResultField = 'ASFName'
      KeyFields = 'ASF_ID'
      Lookup = True
    end
    object qrAppointmentAttested_Id: TIntegerField
      FieldName = 'Attested_Id'
    end
    object qrAppointmentTraining_Date_Out: TDateTimeField
      FieldName = 'Training_Date_Out'
    end
    object qrAppointmentAttested_Who: TWideStringField
      FieldName = 'Attested_Who'
      Size = 100
    end
    object qrAppointmentAttested_Date: TDateTimeField
      FieldName = 'Attested_Date'
    end
    object qrAppointmentAttested_Name: TWideStringField
      FieldKind = fkLookup
      FieldName = 'Attested_Name'
      LookupDataSet = qrKAsfQualif
      LookupKeyFields = 'ID'
      LookupResultField = 'NAME'
      KeyFields = 'Attested_Id'
      Lookup = True
    end
    object qrAppointmentASF_ID: TIntegerField
      FieldName = 'ASF_ID'
    end
  end
  object qrKPOST: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    BeforeOpen = qrKPOSTBeforeOpen
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT ASPOST_ID, POST_NAME, ASPOST_Num FROM ASPOST'
      'Union'
      'SELECT NULL, '#39'<'#1085#1077' '#1091#1082#1072#1079#1072#1085#1086'>'#39', -1 FROM ASPOST'
      'Order By 1')
    Left = 232
    Top = 171
    object qrKPOSTASPOST_ID: TIntegerField
      FieldName = 'ASPOST_ID'
    end
    object qrKPOSTPOST_NAME: TWideStringField
      FieldName = 'POST_NAME'
      Size = 255
    end
    object qrKPOSTASPOST_Num: TIntegerField
      FieldName = 'ASPOST_Num'
    end
  end
  object qrASP: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    BeforeOpen = qrASPBeforeOpen
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      
        'SELECT ASP.ASP_ID, ASP.ASF_ID, ASP.DEP_NAME, ASP.ASP_Num, ASP.Na' +
        'me As ASP_Name'
      'FROM (ASP'
      'Inner Join ASF on ASF.ASF_ID = ASP.ASF_ID)'
      'UNION'
      'SELECT NULL, -1, '#39'<'#1085#1077' '#1091#1082#1072#1079#1072#1085#1086'>'#39', -1, '#39#39' FROM VerInfo'
      'Order By 1')
    Left = 292
    Top = 155
    object qrASPASP_ID: TIntegerField
      FieldName = 'ASP_ID'
    end
    object qrASPDEP_NAME: TWideStringField
      FieldName = 'DEP_NAME'
      Size = 255
    end
    object qrASPASP_Num: TIntegerField
      FieldName = 'ASP_Num'
    end
    object qrASPASF_ID: TIntegerField
      FieldName = 'ASF_ID'
    end
  end
  object qrKAsfQualif: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT ID, NAME FROM KAsfQualif'
      'Union'
      'SELECT NULL, '#39'<'#1085#1077' '#1091#1082#1072#1079#1072#1085#1086'>'#39' FROM KAsfQualif'
      'ORDER BY ID')
    Left = 286
    Top = 207
    object qrKAsfQualifID: TIntegerField
      FieldName = 'ID'
    end
    object qrKAsfQualifNAME: TWideStringField
      FieldName = 'NAME'
      Size = 255
    end
  end
  object qrASF: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT ASF.ASF_ID, '
      
        '  iif((ASF.OrgSName is null), ASF.OrgName, ASF.OrgSName) as ASFN' +
        'ame,'
      
        '  iif((ASF.OrgSName is null), ASF.OrgName, ASF.OrgSName) as Orde' +
        'rName'
      'FROM ASF'
      'UNION'
      'SELECT NULL, '#39'<'#1085#1077' '#1091#1082#1072#1079#1072#1085#1086'>'#39', '#39' '#39' From VerInfo'
      'ORDER BY 3')
    Left = 394
    Top = 151
    object qrASFASF_ID: TIntegerField
      FieldName = 'ASF_ID'
    end
    object qrASFASFName: TWideStringField
      FieldName = 'ASFName'
      Size = 255
    end
    object qrASFOrderName: TWideStringField
      FieldName = 'OrderName'
      Size = 255
    end
  end
end

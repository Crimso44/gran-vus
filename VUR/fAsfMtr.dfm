object TfmAsfMtr: TTfmAsfMtr
  Left = 0
  Top = 0
  Caption = #1053#1072#1083#1080#1095#1080#1077' '#1089#1087#1072#1089#1072#1090#1077#1083#1100#1085#1086#1075#1086' '#1080#1084#1091#1097#1077#1089#1090#1074#1072' '#1080' '#1090#1077#1093#1085#1080#1082#1080' '#1074' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
  ClientHeight = 345
  ClientWidth = 693
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dxDBGrid1: TdxDBGrid
    Left = 0
    Top = 26
    Width = 693
    Height = 319
    Bands = <
      item
      end>
    DefaultLayout = False
    HeaderMinRowCount = 2
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    KeyField = 'ID'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    TabOrder = 4
    DataSource = dsMain
    Filter.Criteria = {00000000}
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
    OnChangedColumnsWidth = dxDBGrid1ChangedColumnsWidth
    object dxDBGrid1KAsfMtr: TdxDBGridLookupColumn
      Caption = #1042#1080#1076' '#1052#1058#1056
      Sorted = csUp
      Visible = False
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'KAsfMtr'
      DropDownRows = 20
      DropDownWidth = 350
      GroupIndex = 0
    end
    object dxDBGrid1KAsfMtr2: TdxDBGridLookupColumn
      Caption = #1042#1080#1076' '#1052#1058#1056
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'KAsfMtr'
      DropDownRows = 20
      DropDownWidth = 350
    end
    object dxDBGrid1AsfMtr: TdxDBGridLookupColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1052#1058#1056
      Width = 150
      BandIndex = 0
      RowIndex = 0
      FieldName = 'AsfMtr'
      OnEditButtonClick = dxDBGrid1AsfMtrEditButtonClick
      DropDownRows = 20
      DropDownWidth = 350
    end
    object dxDBGrid1AsfMtrEdIzm: TdxDBGridLookupColumn
      Caption = #1045#1076#1080#1085#1080#1094#1072' '#1080#1079#1084#1077#1088#1077#1085#1080#1103
      ReadOnly = True
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'AsfMtrEdIzm'
    end
    object dxDBGrid1KDep: TdxDBGridLookupColumn
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Width = 150
      BandIndex = 0
      RowIndex = 0
      FieldName = 'KDep'
      DropDownRows = 20
      DropDownWidth = 350
    end
    object dxDBGrid1ID: TdxDBGridMaskColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ID'
    end
    object dxDBGrid1AsfMtr_Id: TdxDBGridMaskColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'AsfMtr_Id'
    end
    object dxDBGrid1Dep_Id: TdxDBGridMaskColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Dep_Id'
    end
    object dxDBGrid1Amount: TdxDBGridMaskColumn
      Caption = #1053#1072#1083#1080#1095#1080#1077' '#1074' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' ('#1074#1089#1077#1075#1086')'
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Amount'
    end
    object dxDBGrid1AmountAsf: TdxDBGridMaskColumn
      Caption = #1055#1088#1077#1076#1085#1072#1079#1085#1072#1095#1077#1085#1086' '#1076#1083#1103' '#1040#1057#1060
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'AmountAsf'
    end
    object dxDBGrid1AmountVs: TdxDBGridMaskColumn
      Caption = #1055#1086#1089#1090#1072#1074#1083#1103#1077#1090#1089#1103' '#1074' '#1042#1057
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'AmountVs'
    end
    object dxDBGrid1KAsfMtr_Id: TdxDBGridMaskColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'KAsfMtr_Id'
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'DB Navigator')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    ImageOptions.Images = dmMain.ilSmall
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 340
    Top = 178
    DockControlHeights = (
      0
      0
      26
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 727
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
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
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton1'
        end>
      OneOnRow = True
      Row = 0
      SizeGrip = False
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarButton1: TdxBarButton
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
      Category = 0
      Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Excel'
      Visible = ivAlways
      ImageIndex = 39
      OnClick = dxBarButton1Click
    end
    object dxBarDBNavInsert1: TdxBarDBNavButton
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Category = 1
      Enabled = False
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100
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
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnInsert
    end
    object dxBarDBNavDelete1: TdxBarDBNavButton
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Category = 1
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
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnDelete
    end
    object dxBarDBNavEdit1: TdxBarDBNavButton
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      Category = 1
      Enabled = False
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100
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
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnEdit
    end
    object dxBarDBNavPost1: TdxBarDBNavButton
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      Category = 1
      Enabled = False
      Hint = #1047#1072#1087#1080#1089#1072#1090#1100
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
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnPost
    end
    object dxBarDBNavCancel1: TdxBarDBNavButton
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Category = 1
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
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnCancel
    end
  end
  object qrMain: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    BeforeInsert = qrMainBeforeInsert
    AfterInsert = qrMainAfterInsert
    BeforePost = qrMainBeforePost
    Parameters = <>
    SQL.Strings = (
      'select * from Org_Mtr'
      'Where 1=1')
    Left = 442
    Top = 144
    object qrMainID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object qrMainAsfMtr_Id: TIntegerField
      FieldName = 'AsfMtr_Id'
    end
    object qrMainDep_Id: TIntegerField
      FieldName = 'Dep_Id'
    end
    object qrMainAmount: TFloatField
      FieldName = 'Amount'
    end
    object qrMainAmountAsf: TFloatField
      FieldName = 'AmountAsf'
    end
    object qrMainAmountVs: TFloatField
      FieldName = 'AmountVs'
    end
    object qrMainKAsfMtr: TStringField
      FieldKind = fkLookup
      FieldName = 'KAsfMtr'
      LookupDataSet = qrKAsfMtr
      LookupKeyFields = 'KMtrId'
      LookupResultField = 'XName'
      KeyFields = 'KAsfMtr_Id'
      Size = 100
      Lookup = True
    end
    object qrMainKDep: TStringField
      FieldKind = fkLookup
      FieldName = 'KDep'
      LookupDataSet = qrDep
      LookupKeyFields = 'DEP_ID'
      LookupResultField = 'DEP_NAME'
      KeyFields = 'Dep_Id'
      Size = 100
      Lookup = True
    end
    object qrMainKAsfMtr_Id: TIntegerField
      FieldName = 'KAsfMtr_Id'
    end
    object qrMainAsfMtr: TStringField
      FieldKind = fkLookup
      FieldName = 'AsfMtr'
      LookupDataSet = qrAsfMtr
      LookupKeyFields = 'MtrId'
      LookupResultField = 'MtrName'
      KeyFields = 'AsfMtr_Id'
      Size = 100
      Lookup = True
    end
    object qrMainAsfMtrEdIzm: TStringField
      FieldKind = fkLookup
      FieldName = 'AsfMtrEdIzm'
      LookupDataSet = qrAsfMtr
      LookupKeyFields = 'MtrId'
      LookupResultField = 'EdIzm'
      KeyFields = 'AsfMtr_Id'
      Size = 100
      Lookup = True
    end
    object qrMainKAsfMtr_Id_Add: TIntegerField
      FieldKind = fkLookup
      FieldName = 'KAsfMtr_Id_Add'
      LookupDataSet = qrAsfMtr
      LookupKeyFields = 'MtrId'
      LookupResultField = 'KAsfMtr_Id'
      KeyFields = 'AsfMtr_Id'
      Lookup = True
    end
  end
  object dsMain: TDataSource
    DataSet = qrMain
    Left = 492
    Top = 146
  end
  object dxBarDBNavigator1: TdxBarDBNavigator
    BarManager = dxBarManager1
    CategoryName = 'DB Navigator'
    ConfirmDelete = False
    DataSource = dsMain
    DBCheckLinks = <>
    VisibleButtons = [dxbnInsert, dxbnDelete, dxbnEdit, dxbnPost, dxbnCancel]
    Left = 360
    Top = 106
  end
  object qrKAsfMtr: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select '
      '  Iif((k.ShortName is null), k.Name, k.ShortName) As XName, '
      '  k.Id as KMtrId'
      'from KAsfMtr k '
      'Where 1=1'
      'Order by '
      '  Iif((k.ShortName is null), k.Name, k.ShortName)')
    Left = 444
    Top = 216
    object qrKAsfMtrXName: TWideStringField
      FieldName = 'XName'
      ReadOnly = True
      Size = 255
    end
    object qrKAsfMtrKMtrId: TIntegerField
      FieldName = 'KMtrId'
    end
  end
  object qrDep: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from KDepart'
      'order by KDepart_Num')
    Left = 496
    Top = 216
    object qrDepDEP_ID: TIntegerField
      FieldName = 'DEP_ID'
    end
    object qrDepDEP_NAME: TWideStringField
      FieldName = 'DEP_NAME'
      Size = 50
    end
    object qrDepDEP_FULL_NAME: TWideStringField
      FieldName = 'DEP_FULL_NAME'
      Size = 255
    end
    object qrDepKDEPART_Num: TIntegerField
      FieldName = 'KDEPART_Num'
    end
  end
  object qrAsfMtr: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select '
      
        '  Iif((a.ShortName is null), a.FullName, a.ShortName) As MtrName' +
        ', '
      '  a.EdIzm, a.Id as MtrId, KAsfMtr_Id'
      'from AsfMtr a'
      'Where 1=1'
      'Order by '
      '  Iif((a.ShortName is null), a.FullName, a.ShortName)')
    Left = 446
    Top = 272
    object qrAsfMtrMtrName: TWideStringField
      FieldName = 'MtrName'
      ReadOnly = True
      Size = 255
    end
    object qrAsfMtrEdIzm: TWideStringField
      FieldName = 'EdIzm'
    end
    object qrAsfMtrMtrId: TIntegerField
      FieldName = 'MtrId'
    end
    object qrAsfMtrKAsfMtr_Id: TIntegerField
      FieldName = 'KAsfMtr_Id'
    end
  end
end

inherited fmLicenceList: TfmLicenceList
  Tag = 4
  Left = 389
  Top = 249
  Caption = #1057#1087#1080#1089#1086#1082' '#1074#1099#1076#1072#1085#1085#1099#1093' '#1083#1080#1094#1077#1085#1079#1080#1081
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited dxDBGrid: TdxDBGrid
    Bands = <
      item
        Caption = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
        OnlyOwnColumns = True
        Width = 277
      end
      item
        Caption = #1050#1083#1080#1077#1085#1090
        OnlyOwnColumns = True
      end
      item
        Caption = #1055#1088#1086#1076#1091#1082#1090
        OnlyOwnColumns = True
      end>
    DefaultLayout = False
    KeyField = 'licence_id'
    Filter.Criteria = {00000000}
    ShowBands = True
    object dxDBGridlicence_id: TdxDBGridMaskColumn
      Caption = #1050#1086#1076
      Visible = False
      Width = 53
      BandIndex = 0
      RowIndex = 0
      FieldName = 'licence_id'
    end
    object dxDBGridlicence_number: TdxDBGridMaskColumn
      Alignment = taRightJustify
      Caption = #8470' '#1083#1080#1094#1077#1085#1079#1080#1080
      Width = 73
      BandIndex = 0
      RowIndex = 0
      FieldName = 'licence_number'
    end
    object dxDBGridlicence_count: TdxDBGridMaskColumn
      Caption = #1050#1086#1083'-'#1074#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      Width = 48
      BandIndex = 0
      RowIndex = 0
      FieldName = 'licence_count'
    end
    object dxDBGridlicence_start: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080
      Sorted = csDown
      Width = 70
      BandIndex = 0
      RowIndex = 0
      FieldName = 'licence_start'
    end
    object dxDBGridlicence_end: TdxDBGridDateColumn
      Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
      Width = 70
      BandIndex = 0
      RowIndex = 0
      FieldName = 'licence_end'
    end
    object dxDBGridcustomer_sname: TdxDBGridMaskColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Width = 200
      BandIndex = 1
      RowIndex = 0
      FieldName = 'customer_sname'
    end
    object dxDBGridcustomer_phone: TdxDBGridMaskColumn
      Caption = #1058#1077#1083#1077#1092#1086#1085
      Visible = False
      Width = 90
      BandIndex = 1
      RowIndex = 0
      FieldName = 'customer_phone'
    end
    object dxDBGridcustomer_fax: TdxDBGridMaskColumn
      Caption = #1060#1072#1082#1089
      Visible = False
      Width = 70
      BandIndex = 1
      RowIndex = 0
      FieldName = 'customer_fax'
    end
    object dxDBGridproduct_sname: TdxDBGridMaskColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Width = 150
      BandIndex = 2
      RowIndex = 0
      FieldName = 'product_sname'
    end
    object dxDBGridver_info: TdxDBGridMaskColumn
      Caption = #1042#1077#1088#1089#1080#1103
      Width = 50
      BandIndex = 2
      RowIndex = 0
      FieldName = 'ver_info'
    end
    object dxDBGridproduct_code: TdxDBGridMaskColumn
      Caption = #1050#1086#1076
      Visible = False
      Width = 60
      BandIndex = 2
      RowIndex = 0
      FieldName = 'product_code'
    end
    object dxDBGridpstate_name: TdxDBGridMaskColumn
      Caption = #1057#1090#1072#1090#1091#1089
      Visible = False
      Width = 100
      BandIndex = 2
      RowIndex = 0
      FieldName = 'pstate_name'
    end
  end
  inherited dxBarManager1: TdxBarManager
    Bars = <
      item
        AllowClose = False
        AllowCustomizing = False
        AllowQuickCustomizing = False
        AllowReset = False
        Caption = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
        DockedDockingStyle = dsTop
        DockedLeft = 0
        DockedTop = 0
        DockingStyle = dsTop
        FloatLeft = 276
        FloatTop = 213
        FloatClientWidth = 23
        FloatClientHeight = 22
        ItemLinks = <
          item
            Item = dxBarButton1
            Visible = True
          end
          item
            Item = dxBarButton2
            Visible = True
          end
          item
            Item = dxBarButton3
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButton10
            Visible = True
          end
          item
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButton4
            Visible = True
          end
          item
            Item = dxBarButton5
            Visible = True
          end
          item
            Item = dxBarButton7
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButton8
            Visible = True
          end
          item
            Item = dxBarButton9
            Visible = True
          end
          item
            BeginGroup = True
            Item = dxBarButton6
            Visible = True
          end>
        Name = #1055#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074
        NotDocking = [dsNone, dsLeft, dsRight, dsBottom]
        OneOnRow = True
        Row = 0
        UseOwnFont = False
        Visible = True
        WholeRow = True
      end>
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    DockControlHeights = (
      0
      0
      26
      0)
  end
  inherited dsGridData: TDataSource
    DataSet = qrData
  end
  inherited dxBarPopupMenu: TdxBarPopupMenu
    ItemLinks = <
      item
        Item = dxBarButton1
        Visible = True
      end
      item
        Item = dxBarButton2
        Visible = True
      end
      item
        Item = dxBarButton3
        Visible = True
      end
      item
        BeginGroup = True
        Item = dxBarButton10
        Visible = True
      end
      item
        Visible = True
      end
      item
        BeginGroup = True
        Item = dxBarButton4
        Visible = True
      end
      item
        Item = dxBarButton5
        Visible = True
      end
      item
        Item = dxBarButton7
        Visible = True
      end
      item
        BeginGroup = True
        Item = dxBarButton8
        Visible = True
      end
      item
        Item = dxBarButton9
        Visible = True
      end
      item
        BeginGroup = True
        Item = dxBarButton6
        Visible = True
      end>
  end
  object qrData: TADOQuery
    Connection = dmMain.ADOConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select '
      
        '  L.licence_id, REPLACE(STR(L.licence_number,7),'#39' '#39','#39'0'#39') as lice' +
        'nce_number, L.licence_count, L.licence_start, L.licence_end,'
      '  C.customer_sname, C.customer_phone, C.customer_fax,'
      '  P.product_sname,'
      
        '  CAST(P.version_major as varchar(10))+'#39'.'#39'+CAST(P.version_minor ' +
        'as varchar(10))+ISNULL('#39'.'#39'+CAST(P.version_build as varchar(10)),' +
        #39#39') as ver_info,'
      '  P.product_code,'
      '  PS.pstate_name'
      'from Licence L'
      'join Customer C on L.customer_id=C.customer_id'
      'join Product P on L.product_id=P.product_id'
      'join ProductState PS on P.pstate_id=PS.pstate_id'
      'order by 4 desc')
    Left = 180
    Top = 84
  end
end

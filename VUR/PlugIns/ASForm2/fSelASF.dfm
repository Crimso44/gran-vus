object frmASF: TfrmASF
  Left = 0
  Top = 0
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1040#1074#1072#1088#1080#1081#1085#1086'-'#1057#1087#1072#1089#1072#1090#1077#1083#1100#1085#1086#1077' '#1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077
  ClientHeight = 282
  ClientWidth = 446
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 241
    Width = 446
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 328
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object dxDBGrid1: TdxDBGrid
    Left = 0
    Top = 0
    Width = 446
    Height = 241
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'ASF_ID'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    TabOrder = 1
    OnClick = dxDBGrid1Click
    DataSource = dsASF
    Filter.Criteria = {00000000}
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoUseBookmarks]
    OnCustomDrawCell = dxDBGrid1CustomDrawCell
    object dxDBGrid1Selected: TdxDBGridCheckColumn
      Caption = '.'
      ReadOnly = True
      Sorted = csUp
      Visible = False
      Width = 20
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Selected'
      ValueChecked = 'True'
      GroupIndex = 0
      DisplayChecked = '0'
    end
    object dxDBGrid1ASF_ID: TdxDBGridMaskColumn
      ReadOnly = True
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ASF_ID'
      GroupIndex = 0
    end
    object dxDBGrid1OrgSName: TdxDBGridColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      ReadOnly = True
      Width = 150
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OrgSName'
      GroupIndex = 0
    end
    object dxDBGrid1OrgName: TdxDBGridColumn
      Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      ReadOnly = True
      Width = 250
      BandIndex = 0
      RowIndex = 0
      FieldName = 'OrgName'
      GroupIndex = 0
    end
    object dxDBGrid1RecId: TdxDBGridColumn
      ReadOnly = True
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'RecId'
      GroupIndex = 0
    end
  end
  object qASF: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ASF')
    Left = 200
    Top = 144
    object qASFASF_ID: TIntegerField
      FieldName = 'ASF_ID'
    end
    object qASFOrgName: TWideStringField
      FieldName = 'OrgName'
      Size = 250
    end
    object qASFOrgSName: TWideStringField
      FieldName = 'OrgSName'
      Size = 100
    end
    object qASFPERS_ID: TIntegerField
      FieldName = 'PERS_ID'
    end
  end
  object dsASF: TDataSource
    DataSet = mASF
    Left = 232
    Top = 80
  end
  object mASF: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 176
    Top = 80
    object mASFSelected: TBooleanField
      FieldName = 'Selected'
    end
    object mASFOrgSName: TStringField
      FieldName = 'OrgSName'
      Size = 200
    end
    object mASFOrgName: TStringField
      FieldName = 'OrgName'
      Size = 500
    end
    object mASFASF_ID: TIntegerField
      FieldName = 'ASF_ID'
    end
  end
end

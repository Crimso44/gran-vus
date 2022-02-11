object fmGeneralQty: TfmGeneralQty
  Left = 464
  Top = 198
  HelpContext = 19
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1054#1073#1097#1080#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1077#1085#1085#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
  ClientHeight = 282
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    697
    282)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 26
    Height = 13
    Caption = #1042#1059#1054':'
  end
  object pbCalc: TButton
    Left = 4
    Top = 253
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
    TabOrder = 0
    OnClick = pbCalcClick
  end
  object pbOk: TButton
    Left = 533
    Top = 253
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = pbOkClick
  end
  object pbCancel: TButton
    Left = 613
    Top = 253
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 3
  end
  object edName: TEdit
    Left = 4
    Top = 20
    Width = 682
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ParentColor = True
    ReadOnly = True
    TabOrder = 4
  end
  object BitBtn1: TBitBtn
    Left = 84
    Top = 253
    Width = 89
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100
    DoubleBuffered = True
    Glyph.Data = {
      42010000424D4201000000000000760000002800000011000000110000000100
      040000000000CC000000C40E0000C40E00001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777777777
      7777700000007778000000000000700000007778777777777770700000007778
      FFFFFFFFFF70700000007778F7777F777F707000000022222222227F7F707000
      00002FFFFFFFF2FF7F70700000002F22222222FFFF70700000002F2227222277
      7F70700000002FF27222F2FF7F70700000002F27222FF2777F70700000002F72
      2222F2FF7F70700000002F22FF22F2777F70700000002FFFFFFFF2FF00007000
      00002222222222FF8F07700000007778FFFFFFFF807770000000777888888888
      877770000000}
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object dxtParam: TdxDBGrid
    Left = 4
    Top = 48
    Width = 683
    Height = 199
    Bands = <
      item
      end>
    DefaultLayout = False
    HeaderMinRowCount = 2
    KeyField = 'ID'
    SummaryGroups = <>
    SummarySeparator = ', '
    TabOrder = 5
    DataSource = dsData
    Filter.Criteria = {00000000}
    LookAndFeel = lfFlat
    OptionsBehavior = [edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
    OptionsDB = [edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoAutoHeaderPanelHeight, edgoBandHeaderWidth, edgoRowAutoHeight, edgoUseBitmap]
    OnCustomDrawCell = dxtParamCustomDrawCell
    Anchors = [akLeft, akTop, akRight, akBottom]
    object colpID: TdxDBGridColumn
      DisableEditor = True
      Visible = False
      Width = 195
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ID'
    end
    object colpPARAM_NAME: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #1055#1086#1082#1072#1079#1072#1090#1077#1083#1080
      DisableEditor = True
      HeaderAlignment = taCenter
      Width = 296
      BandIndex = 0
      RowIndex = 0
      FieldName = 'PARAM_NAME'
    end
    object colpVALUE2: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1048#1090#1086#1075#1086
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 0
      RowIndex = 0
      OnValidate = colpVALUE2Validate
      FieldName = 'PARAM_VALUE'
    end
    object colpVALUE3: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1043#1086#1088#1086#1076#1089#1082#1080#1077' '#1086#1082#1088#1091#1075#1072
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 0
      RowIndex = 0
      OnValidate = colpVALUE2Validate
      FieldName = 'value3'
    end
    object colpVALUE4: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1052#1091#1085#1080#1094#1080#1087#1072#1083#1100#1085#1099#1077' '#1088#1072#1081#1086#1085#1099
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 0
      RowIndex = 0
      OnValidate = colpVALUE2Validate
      FieldName = 'value4'
    end
    object colpVALUE5: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1043#1086#1088#1086#1076#1089#1082#1080#1077' '#1087#1086#1089#1077#1083#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 0
      RowIndex = 0
      OnValidate = colpVALUE2Validate
      FieldName = 'value5'
    end
    object colpVALUE6: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1057#1077#1083#1100#1089#1082#1080#1077' '#1087#1086#1089#1077#1083#1077#1085#1080#1103
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 0
      RowIndex = 0
      OnValidate = colpVALUE2Validate
      FieldName = 'value6'
    end
    object colpVALUE7: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1084#1077#1078#1089#1077#1083#1077#1085#1085#1099#1077' '#1090#1077#1088#1088#1080#1090#1086#1088#1080#1080
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 0
      RowIndex = 0
      OnValidate = colpVALUE2Validate
      FieldName = 'value7'
    end
    object colpVALUE8: TdxDBGridColumn
      Alignment = taRightJustify
      Caption = #1042#1085#1091#1090#1088#1080#1075#1086#1088#1086#1076#1089#1082#1080#1077' '#1090#1077#1088#1088#1080#1090#1086#1088#1080#1080
      HeaderAlignment = taCenter
      Width = 80
      BandIndex = 0
      RowIndex = 0
      OnValidate = colpVALUE2Validate
      FieldName = 'value8'
    end
  end
  object qrPARAMload: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SUBJ_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      '  ID          = ST.SUBJ_PARAM_ID'
      ', PARAM_NAME  = ST.SUBJ_PARAM_NAME'
      
        ', PARAM_VALUE = REPLACE(CONVERT(VarChar(20),ROUND(SP.PARAM_VALUE' +
        ',CASE WHEN ST.SUBJ_PARAM_ID=2 THEN 1 ELSE 0 END)),'#39'.'#39','#39','#39')'
      
        ', VALUE3 = REPLACE(CONVERT(VarChar(20),ROUND(SP.VALUE3,CASE WHEN' +
        ' ST.SUBJ_PARAM_ID=2 THEN 1 ELSE 0 END)),'#39'.'#39','#39','#39')'
      
        ', VALUE4 = REPLACE(CONVERT(VarChar(20),ROUND(SP.VALUE4,CASE WHEN' +
        ' ST.SUBJ_PARAM_ID=2 THEN 1 ELSE 0 END)),'#39'.'#39','#39','#39')'
      
        ', VALUE5 = REPLACE(CONVERT(VarChar(20),ROUND(SP.VALUE5,CASE WHEN' +
        ' ST.SUBJ_PARAM_ID=2 THEN 1 ELSE 0 END)),'#39'.'#39','#39','#39')'
      
        ', VALUE6 = REPLACE(CONVERT(VarChar(20),ROUND(SP.VALUE6,CASE WHEN' +
        ' ST.SUBJ_PARAM_ID=2 THEN 1 ELSE 0 END)),'#39'.'#39','#39','#39')'
      
        ', VALUE7 = REPLACE(CONVERT(VarChar(20),ROUND(SP.VALUE7,CASE WHEN' +
        ' ST.SUBJ_PARAM_ID=2 THEN 1 ELSE 0 END)),'#39'.'#39','#39','#39')'
      
        ', VALUE8 = REPLACE(CONVERT(VarChar(20),ROUND(SP.VALUE8,CASE WHEN' +
        ' ST.SUBJ_PARAM_ID=2 THEN 1 ELSE 0 END)),'#39'.'#39','#39','#39')'
      '  FROM SUBJ_PARAM_TYPE ST LEFT JOIN SUBJ_PARAM SP on'
      '       ST.SUBJ_PARAM_ID = SP.SUBJ_PARAM_ID'
      '   AND SP.SUBJ_ID = :SUBJ_ID'
      ' ORDER BY ST.SUBJ_PARAM_ID   ')
    Left = 128
    Top = 136
  end
  object qrPARAMsave: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SUBJ_ID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * '
      'FROM SUBJ_PARAM'
      'WHERE SUBJ_ID = :SUBJ_ID')
    Left = 128
    Top = 88
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 28
    Top = 80
  end
  object mData: TdxMemData
    Indexes = <>
    SortOptions = []
    BeforePost = mDataBeforePost
    Left = 124
    Top = 192
  end
  object dsData: TDataSource
    DataSet = mData
    Left = 204
    Top = 184
  end
  object sp_CalcSubjParams: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_CalcSubjParams377;1'
    Parameters = <>
    Left = 247
    Top = 111
  end
end

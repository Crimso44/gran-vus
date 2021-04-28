object fmTPDPPunkt: TfmTPDPPunkt
  Left = 324
  Top = 247
  HelpContext = 512
  Caption = #1055#1091#1085#1082#1090' '#1080#1079' '#1055#1044#1055
  ClientHeight = 334
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 185
    Top = 75
    Height = 232
    ExplicitTop = 53
    ExplicitHeight = 186
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 697
    Height = 75
    Align = alTop
    TabOrder = 0
    DesignSize = (
      697
      75)
    object Label1: TLabel
      Left = 9
      Top = 6
      Width = 60
      Height = 13
      Caption = #1050#1086#1076' '#1054#1050#1042#1069#1044
    end
    object Label2: TLabel
      Left = 8
      Top = 31
      Width = 141
      Height = 13
      Caption = #1050#1086#1076' '#1076#1086#1083#1078#1085#1086#1089#1090#1080' '#1087#1086' '#1054#1050#1055#1044#1058#1056
    end
    object Label3: TLabel
      Left = 8
      Top = 54
      Width = 198
      Height = 13
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1086#1083#1078#1085#1086#1089#1090#1080' '#1087#1086' '#1054#1050#1055#1044#1058#1056
    end
    object lWarning: TLabel
      Left = 336
      Top = 32
      Width = 261
      Height = 13
      Caption = #1042#1074#1077#1076#1077#1085#1085#1099#1081' '#1082#1086#1076' '#1086#1090#1089#1091#1090#1089#1090#1074#1091#1077#1090' '#1074' '#1074#1099#1087#1080#1089#1082#1077' '#1080#1079' '#1054#1050#1055#1044#1058#1056
      Color = clWindow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Visible = False
    end
    object bAddOKPDTR: TSpeedButton
      Left = 307
      Top = 26
      Width = 23
      Height = 22
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1086#1076' '#1074' '#1074#1099#1087#1080#1089#1082#1091' '#1054#1050#1055#1044#1058#1056
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
        0000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
        0000FFFFFF0000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
        000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF000000000000000000000000000000000000000000000000000000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
      ParentShowHint = False
      ShowHint = True
      Visible = False
      OnClick = bAddOKPDTRClick
    end
    object Label4: TLabel
      Left = 146
      Top = 6
      Width = 71
      Height = 13
      Caption = #1056#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072
    end
    object edOKPDTR: TEdit
      Left = 228
      Top = 27
      Width = 73
      Height = 21
      TabOrder = 1
      OnChange = edOKPDTRChange
    end
    object edOkved: TMaskEdit
      Left = 75
      Top = 3
      Width = 54
      Height = 21
      EditMask = '!00.99.99;1; '
      MaxLength = 8
      TabOrder = 0
      Text = '  .  .  '
      OnChange = edOkvedChange
    end
    object edOKPDTRName: TEdit
      Left = 228
      Top = 51
      Width = 460
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Enabled = False
      TabOrder = 2
    end
    object edOKVEDName: TEdit
      Left = 228
      Top = 3
      Width = 460
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Enabled = False
      TabOrder = 3
    end
  end
  object paLeft: TPanel
    Left = 0
    Top = 75
    Width = 185
    Height = 232
    Align = alLeft
    TabOrder = 1
    ExplicitTop = 53
    ExplicitHeight = 186
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object laPosts: TLabel
        Left = 8
        Top = 0
        Width = 121
        Height = 13
        Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1080'/'#1076#1086#1083#1078#1085#1086#1089#1090#1080':'
      end
    end
    object lbPosts: TListBox
      Left = 1
      Top = 25
      Width = 183
      Height = 206
      Align = alClient
      ItemHeight = 13
      Sorted = True
      TabOrder = 1
      ExplicitHeight = 160
    end
  end
  object Panel3: TPanel
    Left = 188
    Top = 75
    Width = 509
    Height = 232
    Align = alClient
    TabOrder = 2
    ExplicitTop = 53
    ExplicitHeight = 186
    object dbgData: TdxDBGrid
      Left = 1
      Top = 42
      Width = 507
      Height = 189
      Bands = <
        item
        end>
      DefaultLayout = True
      HeaderPanelRowCount = 1
      DoNotAddFormNameToRegistryPath = False
      KeyField = 'RecId'
      SummaryGroups = <>
      SummarySeparator = ', '
      Align = alClient
      PopupMenu = PopupMenu
      TabOrder = 1
      OnDblClick = dbgDataDblClick
      DataSource = dsData
      Filter.Criteria = {00000000}
      OptionsBehavior = [edgoAnsiSort, edgoAutoSort, edgoDblClick, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSort, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
      OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
      OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
      OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoRowAutoHeight, edgoRowSelect, edgoUseBitmap]
      RegistryPath = '\Software\Granit\GranVUS\TPDPDPunktGrid'
      OnChangedColumnsWidth = dbgDataChangedColumnsWidth
      OnCustomDrawCell = dbgDataCustomDrawCell
      ExplicitHeight = 143
      object dbgDataWSosts: TdxDBGridMaskColumn
        Caption = #1057#1086#1089#1090#1072#1074'/'#1087#1088#1086#1092#1080#1083#1100
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
      object dbgDataWRange_Name: TdxDBGridMaskColumn
        Caption = #1044#1086' '#1079#1074#1072#1085#1080#1103
        Width = 120
        BandIndex = 0
        RowIndex = 0
        FieldName = 'WRange_Name'
      end
      object dbgDataAge: TdxDBGridMaskColumn
        Caption = #1042' '#1074#1086#1079#1088#1072#1089#1090#1077' '#1089#1090#1072#1088#1096#1077
        Width = 108
        BandIndex = 0
        RowIndex = 0
        FieldName = 'Age'
      end
      object dbgDataSexName: TdxDBGridLookupColumn
        Caption = #1055#1086#1083
        Width = 77
        BandIndex = 0
        RowIndex = 0
        FieldName = 'SexName'
      end
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 507
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object laCond: TLabel
        Left = 4
        Top = 0
        Width = 182
        Height = 13
        Caption = #1059#1089#1083#1086#1074#1080#1103' '#1087#1088#1077#1076#1086#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1086#1090#1089#1088#1086#1095#1082#1080':'
      end
      object ToolBar1: TToolBar
        Left = 0
        Top = 16
        Width = 507
        Height = 25
        Align = alBottom
        Caption = 'ToolBar'
        Images = dmMain.ilSmall
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object ToolButton1: TToolButton
          Left = 0
          Top = 0
          Action = actAdd
        end
        object ToolButton2: TToolButton
          Left = 23
          Top = 0
          Action = actEdit
        end
        object ToolButton3: TToolButton
          Left = 46
          Top = 0
          Action = actDelete
        end
      end
    end
  end
  object Panel6: TPanel
    Left = 0
    Top = 307
    Width = 697
    Height = 27
    Align = alBottom
    TabOrder = 3
    ExplicitTop = 239
    object Panel7: TPanel
      Left = 536
      Top = 1
      Width = 160
      Height = 25
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object pbOk: TBitBtn
        Left = 4
        Top = 0
        Width = 75
        Height = 25
        Caption = 'OK'
        Default = True
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = pbOkClick
      end
      object pbCancel: TBitBtn
        Left = 84
        Top = 0
        Width = 75
        Height = 25
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1080#1090#1100
        DoubleBuffered = True
        ModalResult = 2
        ParentDoubleBuffered = False
        TabOrder = 1
      end
    end
  end
  object dsData: TDataSource
    DataSet = taCond
    Left = 384
    Top = 128
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 120
    Top = 100
  end
  object ActionList: TActionList
    Images = dmMain.ilSmall
    OnUpdate = ActionListUpdate
    Left = 36
    Top = 144
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1091#1102' '#1075#1088#1091#1087#1087#1091' '#1091#1089#1083#1086#1074#1080#1081' '#1074' '#1087#1091#1085#1082#1090#1077
      ImageIndex = 21
      ShortCut = 45
      OnExecute = actAddExecute
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
  end
  object PopupMenu: TPopupMenu
    Images = dmMain.ilSmall
    Left = 92
    Top = 152
    object N1: TMenuItem
      Action = actAdd
    end
    object N2: TMenuItem
      Action = actEdit
    end
    object N3: TMenuItem
      Action = actDelete
    end
  end
  object taCond: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterPost = taCondAfterPost
    Left = 333
    Top = 130
    object taCondLimited: TIntegerField
      FieldName = 'Limited'
    end
    object taCondAge: TIntegerField
      FieldName = 'Age'
      OnGetText = taCondAgeGetText
    end
    object taCondWRange: TIntegerField
      FieldName = 'WRange'
    end
    object taCondWSost: TStringField
      FieldName = 'WSost'
      Size = 25
    end
    object taCondWSosts: TStringField
      FieldName = 'WSosts'
      Size = 255
    end
    object taCondWRange_Name: TStringField
      FieldKind = fkLookup
      FieldName = 'WRange_Name'
      LookupDataSet = qryKWRange
      LookupKeyFields = 'WRng_ID'
      LookupResultField = 'Wrng_Name'
      KeyFields = 'WRange'
      Size = 100
      Lookup = True
    end
    object taCondSex: TSmallintField
      FieldName = 'Sex'
    end
    object taCondSexName: TStringField
      FieldKind = fkLookup
      FieldName = 'SexName'
      LookupDataSet = mSex
      LookupKeyFields = 'Sex'
      LookupResultField = 'SexName'
      KeyFields = 'Sex'
      Lookup = True
    end
  end
  object qryKWRange: TADOQuery
    Connection = dmMain.dbMain
    DataSource = dsData
    Parameters = <
      item
        Name = 'WRange'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT* FROM ( SELECT WRng_ID, WRng_Name FROM [KWRange] '
      'UNION'
      'SELECT 0, '#39#1053#1077#1079#1072#1074#1080#1089#1080#1084#1086' '#1086#1090' '#1079#1074#1072#1085#1080#1103#39' FROM [KWRange]) a'
      'WHERE Wrng_ID = :WRange')
    Left = 448
    Top = 129
    object qryKWRangeWRng_ID: TIntegerField
      FieldName = 'WRng_ID'
    end
    object qryKWRangeWrng_Name: TStringField
      FieldName = 'WRng_Name'
      Size = 100
    end
  end
  object mSex: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 336
    Top = 176
    object mSexSex: TSmallintField
      FieldName = 'Sex'
    end
    object mSexSexName: TStringField
      FieldName = 'SexName'
    end
  end
  object dsSex: TDataSource
    DataSet = mSex
    Left = 384
    Top = 176
  end
end

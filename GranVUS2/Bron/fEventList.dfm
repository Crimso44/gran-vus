object fmEventList: TfmEventList
  Left = 324
  Top = 134
  HelpContext = 42
  Caption = #1046#1091#1088#1085#1072#1083' '#1089#1086#1073#1099#1090#1080#1081
  ClientHeight = 362
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 440
    Height = 26
    AutoSize = True
    ButtonWidth = 41
    Caption = 'ToolBar1'
    EdgeBorders = [ebTop, ebBottom]
    Images = dmMain.ilSmall
    List = True
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object ToolButton8: TToolButton
      Left = 0
      Top = 0
      Action = aRefresh
      AutoSize = True
    end
    object ToolButton1: TToolButton
      Left = 27
      Top = 0
      Action = aClear
      AutoSize = True
    end
    object ToolButton5: TToolButton
      Left = 54
      Top = 0
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 35
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 62
      Top = 0
      Action = aWord
      AutoSize = True
    end
    object ToolButton3: TToolButton
      Left = 89
      Top = 0
      Action = aSaveTo
      AutoSize = True
    end
    object ToolButton6: TToolButton
      Left = 116
      Top = 0
      Width = 8
      Caption = 'ToolButton6'
      ImageIndex = 35
      Style = tbsSeparator
    end
    object ToolButton4: TToolButton
      Left = 124
      Top = 0
      Action = aGroups
      AutoSize = True
    end
    object ToolButton7: TToolButton
      Left = 151
      Top = 0
      Action = aFilter
      AutoSize = True
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 343
    Width = 440
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 50
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 26
    Width = 440
    Height = 317
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 0
      Top = 214
      Width = 440
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      Beveled = True
      ExplicitTop = 218
      ExplicitWidth = 448
    end
    object paTop: TPanel
      Left = 0
      Top = 0
      Width = 440
      Height = 214
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object laLeft: TLabel
        Left = 0
        Top = 0
        Width = 440
        Height = 13
        Align = alTop
        Caption = #1057#1086#1073#1099#1090#1080#1103':'
        ExplicitWidth = 47
      end
      object gridMaster: TdxDBGrid
        Left = 0
        Top = 13
        Width = 440
        Height = 201
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        KeyField = 'Event_id'
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        PopupMenu = PopupMenu1
        TabOrder = 0
        DataSource = dsMaster
        Filter.Criteria = {00000000}
        OptionsBehavior = [edgoAnsiSort, edgoAutoSort, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSelect, edgoStoreToRegistry, edgoTabThrough, edgoVertThrough]
        OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoFullSizing, edgoRowSizing]
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks, edgoUseLocate]
        OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoRowSelect, edgoUseBitmap]
        RegistryPath = '\Software\Granit\GranVUS2\EvntsGrid'
        OnChangeNode = gridMasterChangeNode
        object gridMasterWhen: TdxDBGridColumn
          Caption = #1050#1086#1075#1076#1072
          Sorted = csUp
          Width = 113
          BandIndex = 0
          RowIndex = 0
          DisableGrouping = True
          FieldName = 'When'
        end
        object gridMasterType: TdxDBGridColumn
          Caption = #1063#1090#1086
          Width = 63
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Type'
        end
        object gridMasterObject: TdxDBGridColumn
          Caption = #1043#1076#1077
          Width = 101
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Object'
        end
        object gridMasterEvent_id: TdxDBGridColumn
          Caption = #1053#1086#1084#1077#1088
          Visible = False
          Width = 43
          BandIndex = 0
          RowIndex = 0
          FieldName = 'Event_id'
        end
        object gridMasterWhoLogin: TdxDBGridColumn
          Caption = #1050#1090#1086
          Width = 116
          BandIndex = 0
          RowIndex = 0
          FieldName = 'WhoLogin'
        end
      end
    end
    object paBottom: TPanel
      Left = 0
      Top = 217
      Width = 440
      Height = 100
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object laDetail: TLabel
        Left = 0
        Top = 0
        Width = 440
        Height = 13
        Align = alTop
        Caption = #1055#1086#1076#1088#1086#1073#1085#1086#1089#1090#1080' '#1089#1086#1073#1099#1090#1080#1103':'
        ExplicitWidth = 116
      end
      object gridDetail: TdxDBGrid
        Left = 0
        Top = 13
        Width = 440
        Height = 87
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        KeyField = 'EventDetail_id'
        SummaryGroups = <>
        SummarySeparator = ', '
        Align = alClient
        PopupMenu = PopupMenu1
        TabOrder = 0
        DataSource = dsDetail
        Filter.Criteria = {00000000}
        OptionsBehavior = [edgoAnsiSort, edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
        OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
        OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoRowAutoHeight, edgoRowSelect, edgoUseBitmap]
        ShowHeader = False
        object gridDetailValue: TdxDBGridMemoColumn
          BandIndex = 0
          RowIndex = 0
          HeaderMaxLineCount = 1
          FieldName = 'Value'
        end
      end
    end
  end
  object FrmKeep: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 32
    Top = 232
  end
  object qryMaster: TADOQuery
    Connection = dmMain.dbMain
    BeforeOpen = qryMasterBeforeOpen
    AfterOpen = qryMasterAfterOpen
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM Event ORDER BY Event_ID')
    Left = 128
    Top = 144
    object qryMasterEvent_ID: TIntegerField
      FieldName = 'Event_ID'
    end
    object qryMasterType: TStringField
      FieldName = 'Type'
      Size = 255
    end
    object qryMasterObject: TStringField
      FieldName = 'Object'
      Size = 50
    end
    object qryMasterWhen: TDateTimeField
      FieldName = 'When'
    end
    object qryMasterWho: TIntegerField
      FieldName = 'Who'
    end
    object qryMasterWhoLogin: TStringField
      FieldKind = fkLookup
      FieldName = 'WhoLogin'
      LookupDataSet = qryUsers
      LookupKeyFields = 'ID'
      LookupResultField = 'Name'
      KeyFields = 'Who'
      Size = 50
      Lookup = True
    end
  end
  object qryDetail: TADOQuery
    Connection = dmMain.dbMain
    BeforeOpen = qryDetailBeforeOpen
    Parameters = <
      item
        Name = 'Event_id'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM EventDetail WHERE Event_id = :Event_id')
    Left = 276
    Top = 108
  end
  object dsMaster: TDataSource
    DataSet = qryMaster
    OnDataChange = dsMasterDataChange
    Left = 184
    Top = 148
  end
  object dsDetail: TDataSource
    DataSet = qryDetail
    Left = 280
    Top = 160
  end
  object ActionList: TActionList
    Images = dmMain.ilSmall
    Left = 36
    Top = 160
    object aRefresh: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1086#1082#1085#1072
      ImageIndex = 42
      OnExecute = aRefreshExecute
    end
    object aClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1078#1091#1088#1085#1072#1083' '#1089' '#1087#1086#1083#1085#1099#1084' '#1074#1099#1074#1086#1076#1086#1084' '#1074' Word'
      ImageIndex = 33
      ShortCut = 46
      OnExecute = aClearExecute
    end
    object aWord: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1074' Word'
      Hint = #1042#1099#1075#1088#1091#1079#1080#1090#1100' '#1089#1086#1076#1077#1088#1078#1080#1084#1086#1077' '#1078#1091#1088#1085#1072#1083#1072' '#1074' Word'
      ImageIndex = 48
      ShortCut = 16464
      OnExecute = aWordExecute
    end
    object aSaveTo: TAction
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1090#1072#1073#1083#1080#1094#1091' '#1074' '#1092#1072#1081#1083
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1089#1086#1073#1099#1090#1080#1081' '#1074' '#1092#1072#1081#1083
      ImageIndex = 39
      OnExecute = aSaveToExecute
    end
    object aFilter: TAction
      Caption = #1060#1080#1083#1100#1090#1088
      Hint = #1060#1080#1083#1100#1090#1088
      ImageIndex = 34
      OnExecute = aFilterExecute
    end
    object aGroups: TAction
      Caption = #1055#1072#1085#1077#1083#1100' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080
      Hint = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080
      ImageIndex = 28
      OnExecute = aGroupsExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Images = dmMain.ilSmall
    Left = 140
    Top = 293
    object N6: TMenuItem
      Action = aRefresh
    end
    object N1: TMenuItem
      Action = aClear
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Action = aWord
    end
    object N3: TMenuItem
      Action = aSaveTo
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Action = aGroups
      Checked = True
    end
    object N5: TMenuItem
      Action = aFilter
    end
  end
  object qryUsers: TADOQuery
    Connection = dmMain.dbMain
    OnCalcFields = qryUsersCalcFields
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT ID, LOGIN, FAM, IM, OTCH FROM USERS '
      'UNION'
      'SELECT 0, '#39#39','#39#39','#39#39','#39#39' FROM USERS '
      '')
    Left = 128
    Top = 204
    object qryUsersID: TIntegerField
      FieldName = 'ID'
    end
    object qryUsersLogin: TStringField
      FieldName = 'Login'
      Size = 50
    end
    object qryUsersFam: TStringField
      FieldName = 'Fam'
      Size = 50
    end
    object qryUsersIm: TStringField
      FieldName = 'Im'
      Size = 50
    end
    object qryUsersOtch: TStringField
      FieldName = 'Otch'
      Size = 50
    end
    object qryUsersName: TStringField
      FieldKind = fkCalculated
      FieldName = 'Name'
      Size = 100
      Calculated = True
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'xls'
    Filter = 
      'Microsoft Excel 4.0 Worksheet (*.xls)|*.xls|HTML File (*.htm; *.' +
      'html)|*.htm;*.html|Text File (*.txt)|*.txt'
    Options = [ofOverwritePrompt, ofHideReadOnly]
    Left = 328
    Top = 192
  end
end

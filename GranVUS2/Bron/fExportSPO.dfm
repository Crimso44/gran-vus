object fmExportSPO: TfmExportSPO
  Left = 323
  Top = 205
  HelpContext = 36
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'"'
  ClientHeight = 177
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object laSubj: TLabel
    Left = 8
    Top = 8
    Width = 26
    Height = 13
    Caption = #1042#1059#1054':'
  end
  object laList: TLabel
    Left = 8
    Top = 32
    Width = 335
    Height = 13
    Caption = #1042#1099' '#1084#1086#1078#1077#1090#1077' '#1074#1099#1073#1088#1072#1090#1100' '#1076#1083#1103' '#1101#1082#1089#1087#1086#1088#1090#1072' '#1086#1076#1085#1091' '#1080#1079' '#1072#1075#1088#1077#1075#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1092#1086#1088#1084':'
  end
  object edSubj: TEdit
    Left = 40
    Top = 4
    Width = 305
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object DBGrid: TdxDBGrid
    Left = 8
    Top = 48
    Width = 337
    Height = 93
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderMinRowCount = 2
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    KeyField = 'F6_ID'
    SummaryGroups = <>
    SummarySeparator = ', '
    TabOrder = 1
    OnDblClick = DBGridDblClick
    DataSource = dsData
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoAnsiSort, edgoAutoCopySelectedToClipboard, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoRowSelect, edgoUseBitmap]
    object DBGridF6_SHIFR: TdxDBGridColumn
      Caption = #1064#1080#1092#1088' '#1092#1086#1088#1084#1099
      HeaderAlignment = taCenter
      Width = 46
      BandIndex = 0
      RowIndex = 0
      FieldName = 'F6_SHIFR'
    end
    object DBGridORG_SHIFR: TdxDBGridColumn
      Caption = #1064#1080#1092#1088' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      HeaderAlignment = taCenter
      Width = 118
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ORG_SHIFR'
    end
    object DBGridF6_COUNT: TdxDBGridColumn
      Caption = #1063#1080#1089#1083#1086' '#1060'6'
      HeaderAlignment = taCenter
      Width = 49
      BandIndex = 0
      RowIndex = 0
      FieldName = 'F6_COUNT'
    end
    object DBGridKUO_COUNT: TdxDBGridColumn
      Caption = #1063#1080#1089#1083#1086' '#1050#1059#1054
      HeaderAlignment = taCenter
      Width = 51
      BandIndex = 0
      RowIndex = 0
      FieldName = 'KUO_COUNT'
    end
    object DBGridCHECKED: TdxDBGridCheckColumn
      Alignment = taCenter
      Caption = #1055#1088#1086#1074#1077#1088#1077#1085#1086
      HeaderAlignment = taCenter
      Width = 69
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CHECKED'
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
    object DBGridF6_ID: TdxDBGridColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'F6_ID'
    end
  end
  object pbExport: TButton
    Left = 8
    Top = 148
    Width = 141
    Height = 25
    Action = actExport
    Default = True
    TabOrder = 2
  end
  object pbClose: TButton
    Left = 272
    Top = 148
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = pbCloseClick
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SUBJ_ID'
        DataType = ftInteger
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM FORM6HDR WHERE SUBJ_ID = :SUBJ_ID'
      'ORDER BY F6_SHIFR')
    Left = 16
    Top = 60
  end
  object dsData: TDataSource
    DataSet = qrData
    Left = 80
    Top = 72
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'brp'
    Filter = #1060#1072#1081#1083#1099' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'" (*.brp)|*.brp|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofNoReadOnlyReturn, ofEnableSizing]
    OptionsEx = [ofExNoPlacesBar]
    Left = 152
    Top = 100
  end
  object ActionList1: TActionList
    Images = dmMain.ilSmall
    Left = 244
    Top = 88
    object actExport: TAction
      Caption = #1069#1082#1089#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      ImageIndex = 10
      ShortCut = 13
      OnExecute = actExportExecute
      OnUpdate = actExportUpdate
    end
  end
  object qry: TADOQuery
    Connection = dmMain.dbMain
    ParamCheck = False
    Parameters = <>
    Left = 28
    Top = 112
  end
end

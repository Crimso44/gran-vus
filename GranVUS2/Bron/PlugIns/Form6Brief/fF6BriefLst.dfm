object fmF6BriefList: TfmF6BriefList
  Left = 240
  Top = 206
  HelpContext = 37
  Caption = #1057#1087#1080#1089#1086#1082' '#1091#1089#1077#1095#1077#1085#1085#1099#1093' '#1092#1086#1088#1084' 6'
  ClientHeight = 318
  ClientWidth = 612
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 299
    Width = 612
    Height = 19
    Panels = <>
  end
  object dbgData: TdxDBGrid
    Left = 0
    Top = 19
    Width = 612
    Height = 280
    Bands = <
      item
      end>
    DefaultLayout = False
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    KeyField = 'ID'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 1
    DataSource = DataSource1
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoAutoSort, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoMouseScroll, edgoTabThrough, edgoVertThrough]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords]
    ExplicitTop = 22
    ExplicitHeight = 277
    object dbgDataColumn3: TdxDBGridColumn
      Caption = #1064#1080#1092#1088
      DisableEditor = True
      Width = 153
      BandIndex = 0
      RowIndex = 0
      FieldName = 'F6_SHIFR'
    end
    object dbgDataColumn10: TdxDBGridColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Width = 148
      BandIndex = 0
      RowIndex = 0
      FieldName = 'NAME'
    end
    object dbgDataColumn11: TdxDBGridColumn
      Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
      Width = 139
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CAPTION'
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 612
    Height = 19
    AutoSize = True
    ButtonHeight = 19
    ButtonWidth = 41
    Caption = 'ToolBar1'
    List = True
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Action = PrintAction
    end
  end
  object ActionList1: TActionList
    Left = 392
    Top = 60
    object PrintAction: TAction
      Caption = '&'#1054#1090#1095#1077#1090
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1092#1086#1088#1084#1091' '#1074' '#1090#1077#1082#1089#1090#1086#1074#1099#1081' '#1088#1077#1076#1072#1082#1090#1086#1088
      ImageIndex = 0
      OnExecute = PrintActionExecute
      OnUpdate = PrintActionUpdate
    end
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 32
    Top = 272
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM FORM6BRIEF')
    Left = 380
    Top = 116
  end
  object DataSource1: TDataSource
    DataSet = qrData
    Left = 424
    Top = 168
  end
  object PopupMenu1: TPopupMenu
    Left = 124
    Top = 108
    object N1: TMenuItem
      Action = PrintAction
    end
  end
end

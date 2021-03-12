object frmVur370Post: TfrmVur370Post
  Left = 298
  Top = 138
  BorderStyle = bsToolWindow
  Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1080' '#1087#1088#1086#1092#1077#1089#1089#1080#1081
  ClientHeight = 402
  ClientWidth = 486
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 473
    Height = 93
    AutoSize = False
    Caption = 
      #1042' '#1074#1077#1088#1089#1080#1080' 3.70, '#1074' '#1086#1090#1083#1080#1095#1080#1077' '#1086#1090' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1093', '#1082#1072#1090#1077#1075#1086#1088#1080#1080' '#1087#1088#1086#1092#1077#1089#1089#1080#1081' '#1089#1074#1103#1079 +
      #1072#1085#1099' '#1085#1077#1087#1086#1089#1088#1077#1076#1089#1090#1074#1077#1085#1085#1086#13#10#1089'  '#1087#1088#1086#1092#1077#1089#1089#1080#1103#1084#1080'/'#1076#1086#1083#1078#1085#1086#1089#1090#1103#1084#1080', '#1072' '#1085#1077' '#1089' '#1088#1072#1073#1086#1090#1085#1080#1082 +
      #1072#1084#1080'. '#1055#1088#1086#1075#1088#1072#1084#1084#1072' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1087#1086#1087#1099#1090#1072#1083#1072#1089#1100#13#10#1086#1087#1088#1077#1076#1077#1083#1080#1090#1100' '#1082#1072#1090#1077#1075#1086#1088#1080#1080' '#1087#1088#1086#1092#1077 +
      #1089#1089#1080#1081'/'#1076#1086#1083#1078#1085#1086#1089#1090#1077#1081'. '#1057#1077#1081#1095#1072#1089' '#1074#1099' '#1084#1086#1078#1077#1090#1077' '#1087#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1080' '#13#10#1089#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1072#1090 +
      #1100' '#1088#1077#1079#1091#1083#1100#1090#1072#1090' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1080#1103'.'#13#10#13#10#1055#1056#1048#1052#1045#1063#1040#1053#1048#1045': '#1042#1099' '#1084#1086#1078#1077#1090 +
      #1077' '#1089#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1082#1072#1090#1077#1075#1086#1088#1080#1080' '#1087#1088#1086#1092#1077#1089#1089#1080#1081'/'#1076#1086#1083#1078#1085#1086#1089#1090#1077#1081' '#1087#1086#1079#1078#1077','#13#10#1089' '#1087#1086#1084#1086#1097 +
      #1100#1102' '#1087#1091#1085#1082#1090#1072' '#1084#1077#1085#1102' \'#1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077'\'#1041#1072#1079#1086#1074#1099#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080'\'#1044#1086#1083#1078#1085#1086#1089#1090#1080'.'
    WordWrap = True
  end
  object dbgPOST: TdxDBGrid
    Left = 4
    Top = 104
    Width = 477
    Height = 253
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'POST_ID'
    SummaryGroups = <>
    SummarySeparator = ', '
    TabOrder = 0
    DataSource = dsPost
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoAnsiSort, edgoAutoCopySelectedToClipboard, edgoAutoSort, edgoDragScroll, edgoEditing, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSort, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoColumnSizing, edgoFullSizing]
    OptionsDB = [edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoUseBitmap]
    object dbgPOSTPOST_NAME: TdxDBGridMaskColumn
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      Width = 220
      BandIndex = 0
      RowIndex = 0
      FieldName = 'POST_NAME'
    end
    object dbgPOSTCPROF_NAME: TdxDBGridLookupColumn
      Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
      Width = 236
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CPROF_NAME'
    end
  end
  object Button1: TButton
    Left = 392
    Top = 368
    Width = 89
    Height = 25
    Cancel = True
    Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
  object dsPost: TDataSource
    DataSet = qrPost
    Left = 68
    Top = 160
  end
  object qrPost: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT [POST_ID], [POST_NAME], [CPROF_ID] FROM [KPOST]')
    Left = 184
    Top = 184
    object qrPostPOST_ID: TIntegerField
      FieldName = 'POST_ID'
    end
    object qrPostPOST_NAME: TStringField
      FieldName = 'POST_NAME'
      Size = 50
    end
    object qrPostCPROF_ID: TIntegerField
      FieldName = 'CPROF_ID'
    end
    object qrPostCPROF_NAME: TStringField
      FieldKind = fkLookup
      FieldName = 'CPROF_NAME'
      LookupDataSet = qrCProf
      LookupKeyFields = 'CPROF_ID'
      LookupResultField = 'CPROF_NAME'
      KeyFields = 'CPROF_ID'
      Size = 50
      Lookup = True
    end
  end
  object qrCProf: TADOQuery
    Parameters = <>
    SQL.Strings = (
      'SELECT [CPROF_ID], [CPROF_NAME] FROM [KCPROF] '
      'WHERE [STATE]=0')
    Left = 268
    Top = 180
    object qrCProfCPROF_ID: TIntegerField
      FieldName = 'CPROF_ID'
    end
    object qrCProfCPROF_NAME: TStringField
      FieldName = 'CPROF_NAME'
      Size = 50
    end
  end
end

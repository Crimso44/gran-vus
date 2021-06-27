object fmImportSPOOrg: TfmImportSPOOrg
  Left = 282
  Top = 195
  HelpContext = 40
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' '#1080#1079' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'"'
  ClientHeight = 375
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object laFileName: TLabel
    Left = 4
    Top = 4
    Width = 183
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089' '#1080#1084#1087#1086#1088#1090#1080#1088#1091#1077#1084#1099#1084#1080' '#1076#1072#1085#1085#1099#1084#1080':'
  end
  object Label1: TLabel
    Left = 4
    Top = 48
    Width = 128
    Height = 13
    Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1091#1077#1084#1099#1077' '#1076#1072#1085#1085#1099#1077':'
  end
  object Label2: TLabel
    Left = 8
    Top = 328
    Width = 137
    Height = 41
    AutoSize = False
    Caption = #1054#1090#1082#1088#1086#1081#1090#1077' '#1082#1072#1088#1090#1086#1095#1082#1091' '#1085#1091#1078#1085#1086#1081' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' '#1080#1083#1080' '#1089#1086#1079#1076#1072#1081#1090#1077' '#1085#1086#1074#1091#1102'.'
    WordWrap = True
  end
  object edFileName: TEdit
    Left = 4
    Top = 20
    Width = 341
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object pbOpen: TButton
    Left = 352
    Top = 20
    Width = 75
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100'...'
    TabOrder = 1
    OnClick = pbOpenClick
  end
  object Grid: TdxTreeList
    Left = 4
    Top = 64
    Width = 425
    Height = 257
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    TabOrder = 2
    Options = [aoColumnSizing, aoEditing, aoTabThrough, aoAutoWidth]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoDragScroll, aoDragExpand, aoRowSizing]
    TreeLineColor = clGrayText
    ShowGrid = True
    ShowRoot = False
    object dxTreeList1Column1: TdxTreeListColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Color = clBtnFace
      ReadOnly = True
      BandIndex = 0
      RowIndex = 0
    end
    object dxTreeList1Column2: TdxTreeListColumn
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077
      BandIndex = 0
      RowIndex = 0
    end
  end
  object pbCard: TButton
    Left = 156
    Top = 332
    Width = 75
    Height = 33
    Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1082#1072#1088#1090#1086#1095#1082#1091
    TabOrder = 3
    WordWrap = True
    OnClick = pbCardClick
  end
  object pbF6: TButton
    Left = 240
    Top = 332
    Width = 75
    Height = 33
    Caption = #1047#1072#1087#1086#1083#1085#1080#1090#1100' '#1092#1086#1088#1084#1091' '#8470'6'
    TabOrder = 4
    WordWrap = True
    OnClick = pbF6Click
  end
  object pbClose: TButton
    Left = 348
    Top = 332
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 5
    OnClick = pbCloseClick
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'brp'
    Filter = #1060#1072#1081#1083#1099' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'" (*.bob)|*.bob|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing, ofForceShowHidden]
    OptionsEx = [ofExNoPlacesBar]
    Left = 252
    Top = 18
  end
  object sp_GenerateForm6: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_GenerateForm6;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ORG_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@F6_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end>
    Left = 216
    Top = 192
  end
end

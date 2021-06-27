object fmOrgPropOsnPer: TfmOrgPropOsnPer
  Left = 329
  Top = 430
  HelpContext = 6
  ActiveControl = dxtOSN
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' - '#1086#1089#1085#1086#1074#1072#1085#1080#1103' '#1080' '#1087#1077#1088#1077#1095#1085#1080
  ClientHeight = 327
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  DesignSize = (
    632
    327)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 4
    Top = 8
    Width = 147
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080':'
  end
  object Bevel1: TBevel
    Left = 4
    Top = 56
    Width = 621
    Height = 9
    Shape = bsTopLine
  end
  object Label2: TLabel
    Left = 4
    Top = 64
    Width = 199
    Height = 13
    Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1080' ('#1086#1089#1085#1086#1074#1072#1085#1080#1103'):'
  end
  object Bevel2: TBevel
    Left = 4
    Top = 172
    Width = 621
    Height = 9
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 8
    Top = 184
    Width = 323
    Height = 13
    Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1080' ('#1076#1086#1083#1078#1085#1086#1089#1090#1080' '#1087#1086' '#1074#1080#1076#1072#1084' '#1076#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1080'):'
  end
  object edName: TEdit
    Left = 4
    Top = 28
    Width = 621
    Height = 21
    TabStop = False
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
  end
  object dxtOSN: TdxTreeList
    Left = 4
    Top = 82
    Width = 621
    Height = 83
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    PopupMenu = pmOsn
    TabOrder = 3
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoAutoWidth, aoCaseInsensitive]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
    TreeLineColor = clGrayText
    ShowGrid = True
    ShowRoot = False
    ShowIndicator = True
    OnEnter = dxtOSNEnter
    OnExit = dxtOSNExit
    OnEdited = dxtOSNEdited
    object colBASE_ID: TdxTreeListPickColumn
      Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
      Width = 316
      BandIndex = 0
      RowIndex = 0
      DropDownListStyle = True
    end
    object colDOC_ID: TdxTreeListPickColumn
      Caption = #1044#1086#1082#1091#1084#1077#1085#1090
      Width = 133
      BandIndex = 0
      RowIndex = 0
      DropDownListStyle = True
      Revertable = True
    end
    object colDOC_NO: TdxTreeListColumn
      Caption = #8470' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
      MaxLength = 15
      Width = 86
      BandIndex = 0
      RowIndex = 0
    end
    object colDOC_DATE: TdxTreeListDateColumn
      Caption = #1044#1072#1090#1072
      Width = 72
      BandIndex = 0
      RowIndex = 0
    end
  end
  object dxtPer: TdxTreeList
    Left = 4
    Top = 203
    Width = 620
    Height = 83
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    PopupMenu = pmPer
    TabOrder = 6
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoAutoWidth, aoCaseInsensitive]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
    TreeLineColor = clGrayText
    ShowGrid = True
    ShowRoot = False
    ShowIndicator = True
    OnEnter = dxtOSNEnter
    OnExit = dxtOSNExit
    OnEdited = dxtOSNEdited
    object colpPER_NO: TdxTreeListColumn
      Caption = #1054#1050#1042#1069#1044
      Width = 121
      BandIndex = 0
      RowIndex = 0
    end
    object colpRAZD_NO: TdxTreeListColumn
      Caption = #1054#1050#1055#1044#1058#1056
      Width = 121
      BandIndex = 0
      RowIndex = 0
    end
  end
  object Button1: TButton
    Left = 536
    Top = 295
    Width = 91
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
  object pbOSNAdd: TButton
    Left = 468
    Top = 60
    Width = 75
    Height = 21
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 1
    OnClick = N1Click
  end
  object pbOSNDel: TButton
    Left = 548
    Top = 60
    Width = 75
    Height = 21
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 2
    OnClick = N2Click
  end
  object pbPerAdd: TButton
    Left = 468
    Top = 176
    Width = 75
    Height = 21
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 4
    OnClick = N3Click
  end
  object pbPerDel: TButton
    Left = 548
    Top = 176
    Width = 75
    Height = 21
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 5
    OnClick = N4Click
  end
  object pmOsn: TPopupMenu
    Left = 180
    Top = 116
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnClick = N2Click
    end
  end
  object pmPer: TPopupMenu
    Left = 156
    Top = 220
    object N3: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnClick = N4Click
    end
  end
end

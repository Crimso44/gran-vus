object fmOrgPropOsnPer: TfmOrgPropOsnPer
  Left = 386
  Top = 277
  HelpContext = 508
  ActiveControl = dxtOSN
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' - '#1086#1089#1085#1086#1074#1072#1085#1080#1103
  ClientHeight = 205
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
  object Button1: TButton
    Left = 536
    Top = 176
    Width = 91
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object pbOSNAdd: TButton
    Left = 468
    Top = 60
    Width = 75
    Height = 21
    Action = actAdd
    TabOrder = 1
  end
  object pbOSNDel: TButton
    Left = 548
    Top = 60
    Width = 75
    Height = 21
    Action = actDel
    TabOrder = 2
  end
  object pmOsn: TPopupMenu
    Left = 188
    Top = 116
    object N1: TMenuItem
      Action = actAdd
    end
    object N2: TMenuItem
      Action = actDel
    end
  end
  object ActionList: TActionList
    Left = 260
    Top = 120
    object actAdd: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnExecute = N1Click
    end
    object actDel: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnExecute = N2Click
    end
  end
end

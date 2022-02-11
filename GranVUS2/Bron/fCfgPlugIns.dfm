object fmCfgPlugIns: TfmCfgPlugIns
  Left = 265
  Top = 198
  Caption = #1057#1087#1080#1089#1086#1082' '#1088#1072#1089#1096#1080#1088#1077#1085#1080#1081' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 307
  ClientWidth = 446
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
  DesignSize = (
    446
    307)
  PixelsPerInch = 96
  TextHeight = 13
  object dxtData: TdxTreeList
    Left = 0
    Top = 0
    Width = 446
    Height = 277
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    Align = alTop
    TabOrder = 0
    HideSelection = False
    Images = dmMain.ilSmall
    Options = [aoColumnSizing, aoTabThrough, aoRowSelect]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoDragScroll, aoDragExpand, aoRowSizing]
    TreeLineColor = clGrayText
    ShowLines = False
    ShowRoot = False
    OnDblClick = btnConfigClick
    Anchors = [akLeft, akTop, akRight, akBottom]
    object dxtDataColumn1: TdxTreeListColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Width = 162
      BandIndex = 0
      RowIndex = 0
    end
    object dxtDataColumn2: TdxTreeListColumn
      Caption = #1040#1074#1090#1086#1088
      Width = 244
      BandIndex = 0
      RowIndex = 0
    end
    object dxtDataColumn3: TdxTreeListColumn
      Caption = #1058#1080#1087
      Width = 45
      BandIndex = 0
      RowIndex = 0
    end
    object dxtDataColumn4: TdxTreeListColumn
      Caption = #1060#1072#1081#1083
      Width = 200
      BandIndex = 0
      RowIndex = 0
    end
  end
  object btnConfig: TButton
    Left = 296
    Top = 282
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1053#1072#1089#1090#1088#1086#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = btnConfigClick
  end
  object Button2: TButton
    Left = 376
    Top = 282
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 2
    OnClick = Button2Click
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 32
    Top = 184
  end
end

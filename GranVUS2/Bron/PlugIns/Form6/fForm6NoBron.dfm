object Form6NoBron: TForm6NoBron
  Left = 333
  Top = 264
  HelpContext = 7
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093' '#1074' '#1092#1086#1088#1084#1077' '#8470'18'
  ClientHeight = 160
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  DesignSize = (
    316
    160)
  PixelsPerInch = 96
  TextHeight = 13
  object pbOk: TButton
    Left = 158
    Top = 133
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1050
    ModalResult = 1
    TabOrder = 1
    OnClick = pbOkClick
  end
  object pbCancel: TButton
    Left = 238
    Top = 133
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object Grid: TdxTreeList
    Left = 4
    Top = 4
    Width = 309
    Height = 124
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    ParentColor = True
    TabOrder = 0
    Options = [aoEditing, aoTabThrough, aoImmediateEditor, aoAutoWidth]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand]
    TreeLineColor = clGrayText
    ShowButtons = False
    ShowGrid = True
    ShowHeader = False
    ShowRoot = False
    OnCustomDrawCell = GridCustomDrawCell
    OnEdited = GridEdited
    OnEditing = GridEditing
    Anchors = [akLeft, akTop, akRight, akBottom]
    Data = {
      FFFFFFFF07000000180000000000000000000000FFFFFFFF0000000000000000
      0300000001000000310E000000C2F1E5E3EE20F0E0E1EEF2E0FEF20900000020
      2020202020202020180000000000000000000000FFFFFFFF0000000000000000
      03000000010000003209000000C2F1E5E3EE20C3CFC700000000180000000000
      000000000000FFFFFFFF000000000000000003000000010000003308000000CE
      F4E8F6E5F0EEE200000000180000000000000000000000FFFFFFFF0000000000
      00000003000000010000003432000000CFF0E0EFEEF0F9E8EAEEE22C20F1F2E0
      F0F8E8ED2C20F1E5F0E6E0EDF2EEE22C20F0FFE4EEE2FBF52C20ECE0F2F0EEF1
      EEE200000000180000000000000000000000FFFFFFFF00000000000000000300
      0000010000003520000000CEE3F0E0EDE8F7E5EDEDEE20E3EEE4EDFBF52028ED
      E520EEF4E8F6E5F0EEE22900000000180000000000000000000000FFFFFFFF00
      000000000000000300000002000000313021000000C8ECE5FEF220ECEEE1E8EB
      E8E7E0F6E8EEEDEDEEE520EFF0E5E4EFE8F1E0EDE8E500000000180000000000
      000000000000FFFFFFFF00000000000000000300000002000000313109000000
      C2F1E5E3EE20C3CFCF00000000}
    object GridCOL_B: TdxTreeListColumn
      Width = 20
      BandIndex = 0
      RowIndex = 0
    end
    object GridName: TdxTreeListColumn
      Width = 294
      BandIndex = 0
      RowIndex = 0
    end
    object GridValue: TdxTreeListMaskColumn
      Alignment = taRightJustify
      Color = clWindow
      Width = 84
      BandIndex = 0
      RowIndex = 0
      EditMask = '#########;0; '
    end
  end
end

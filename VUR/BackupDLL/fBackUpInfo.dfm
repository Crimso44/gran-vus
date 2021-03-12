object fmBackUpInfo: TfmBackUpInfo
  Left = 265
  Top = 229
  BorderStyle = bsDialog
  Caption = 'Информации о снимке БД'
  ClientHeight = 312
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 80
    Height = 13
    Caption = 'Дата создания:'
  end
  object Label2: TLabel
    Left = 16
    Top = 32
    Width = 100
    Height = 13
    Caption = 'Количество таблиц:'
  end
  object edDate: TEdit
    Left = 116
    Top = 4
    Width = 113
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
  end
  object edCntTables: TEdit
    Left = 160
    Top = 28
    Width = 69
    Height = 21
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 1
  end
  object dxtTables: TdxTreeList
    Left = 0
    Top = 52
    Width = 356
    Height = 260
    Bands = <
      item
        Width = 569
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    Align = alBottom
    TabOrder = 2
    HideSelection = False
    LookAndFeel = lfFlat
    Options = [aoEditing, aoTabThrough, aoRowSelect, aoImmediateEditor, aoAutoWidth]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoShowButtonAlways]
    TreeLineColor = clGrayText
    ShowGrid = True
    ShowRoot = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    object dxtTablesColumn1: TdxTreeListColumn
      Caption = 'Таблица'
      DisableEditor = True
      Width = 166
      BandIndex = 0
      RowIndex = 0
    end
    object dxtTablesColumn2: TdxTreeListColumn
      Alignment = taRightJustify
      Caption = 'Записей'
      DisableEditor = True
      Width = 60
      BandIndex = 0
      RowIndex = 0
    end
    object dxtTablesColumn4: TdxTreeListColumn
      Alignment = taRightJustify
      Caption = 'Полей'
      DisableEditor = True
      Width = 60
      BandIndex = 0
      RowIndex = 0
    end
    object dxtTablesColumn3: TdxTreeListColumn
      Alignment = taRightJustify
      Caption = 'Размер, кБайт'
      DisableEditor = True
      Width = 92
      BandIndex = 0
      RowIndex = 0
    end
  end
  object Button1: TButton
    Left = 276
    Top = 4
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Закрыть'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
end

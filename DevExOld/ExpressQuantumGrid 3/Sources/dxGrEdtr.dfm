object FdxDBGridEditor: TFdxDBGridEditor
  Left = 222
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'FdxDBGridEditor'
  ClientHeight = 267
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 359
    Height = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 367
  end
  object Panel2: TPanel
    Left = 0
    Top = 8
    Width = 6
    Height = 251
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitHeight = 263
  end
  object Panel3: TPanel
    Left = 353
    Top = 8
    Width = 6
    Height = 251
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = 361
    ExplicitHeight = 263
  end
  object Panel1: TPanel
    Left = 0
    Top = 259
    Width = 359
    Height = 8
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    ExplicitTop = 271
    ExplicitWidth = 367
  end
  object PageControl: TPageControl
    Left = 6
    Top = 8
    Width = 347
    Height = 251
    ActivePage = tsColumns
    Align = alClient
    TabOrder = 4
    OnChange = PageControlChange
    ExplicitWidth = 355
    ExplicitHeight = 263
    object tsBands: TTabSheet
      Caption = '  Bands  '
      object Panel12: TPanel
        Left = 241
        Top = 6
        Width = 106
        Height = 222
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object BAddBand: TButton
          Left = 8
          Top = 0
          Width = 91
          Height = 22
          Caption = '&Add'
          TabOrder = 0
          OnClick = BAddBandClick
        end
        object BDeleteBand: TButton
          Left = 8
          Top = 29
          Width = 91
          Height = 22
          Caption = '&Delete'
          TabOrder = 1
          OnClick = BDeleteBandClick
        end
        object BUpBand: TButton
          Left = 8
          Top = 58
          Width = 91
          Height = 22
          Caption = 'Move &Up'
          TabOrder = 2
          OnClick = BUpBandClick
        end
        object BDownBand: TButton
          Left = 8
          Top = 87
          Width = 91
          Height = 22
          Caption = 'Move Dow&n'
          TabOrder = 3
          OnClick = BDownBandClick
        end
        object BRestoreDefault: TButton
          Left = 8
          Top = 116
          Width = 91
          Height = 22
          Caption = 'Rest&ore Defaults'
          TabOrder = 4
          OnClick = BRestoreDefaultClick
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 0
        Width = 347
        Height = 6
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
      end
      object Panel15: TPanel
        Left = 0
        Top = 228
        Width = 347
        Height = 6
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
      end
      object Panel24: TPanel
        Left = 0
        Top = 6
        Width = 6
        Height = 222
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 3
      end
      object LBands: TListBox
        Left = 6
        Top = 6
        Width = 235
        Height = 222
        Align = alClient
        DragMode = dmAutomatic
        ItemHeight = 13
        MultiSelect = True
        PopupMenu = pmBands
        TabOrder = 4
        OnClick = LBandsClick
        OnDragDrop = LBandsDragDrop
        OnDragOver = LBandsDragOver
        OnEndDrag = LBandsEndDrag
        OnKeyDown = CListBoxKeyDown
        OnStartDrag = CListBoxStartDrag
      end
    end
    object tsColumns: TTabSheet
      Caption = '  Columns  '
      object Panel5: TPanel
        Left = 0
        Top = 6
        Width = 6
        Height = 223
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 347
        Height = 6
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
      end
      object Panel8: TPanel
        Left = 0
        Top = 229
        Width = 347
        Height = 6
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
      end
      object pnButtons: TPanel
        Left = 241
        Top = 6
        Width = 106
        Height = 223
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 3
        object BAdd: TButton
          Left = 8
          Top = 0
          Width = 91
          Height = 22
          Caption = '&Add...'
          TabOrder = 0
          OnClick = BAddClick
        end
        object BDelete: TButton
          Left = 8
          Top = 29
          Width = 91
          Height = 22
          Caption = '&Delete'
          TabOrder = 1
          OnClick = BDeleteClick
        end
        object BUp: TButton
          Left = 8
          Top = 87
          Width = 91
          Height = 22
          Caption = 'Move &Up'
          TabOrder = 3
          OnClick = BUpClick
        end
        object BDown: TButton
          Left = 8
          Top = 116
          Width = 91
          Height = 22
          Caption = 'Move Dow&n'
          TabOrder = 4
          OnClick = BDownClick
        end
        object BWizard: TButton
          Left = 8
          Top = 145
          Width = 91
          Height = 22
          Caption = 'Add All &Fields...'
          TabOrder = 5
          OnClick = BWizardClick
        end
        object BRestore: TButton
          Left = 8
          Top = 174
          Width = 91
          Height = 22
          Caption = 'Rest&ore Defaults'
          TabOrder = 6
          OnClick = BRestoreClick
        end
        object BChange: TButton
          Left = 8
          Top = 58
          Width = 91
          Height = 22
          Caption = '&Change type...'
          TabOrder = 2
          OnClick = BChangeClick
        end
        object BRestoreWidths: TButton
          Left = 8
          Top = 203
          Width = 91
          Height = 22
          Caption = 'Restore &Widths'
          TabOrder = 7
          OnClick = BRestoreWidthsClick
        end
      end
      object CListBox: TListBox
        Left = 6
        Top = 6
        Width = 235
        Height = 223
        Align = alClient
        DragMode = dmAutomatic
        ItemHeight = 13
        MultiSelect = True
        PopupMenu = pmColumns
        TabOrder = 4
        OnClick = CListBoxClick
        OnDragDrop = CListBoxDragDrop
        OnDragOver = CListBoxDragOver
        OnEndDrag = CListBoxEndDrag
        OnKeyDown = CListBoxKeyDown
        OnStartDrag = CListBoxStartDrag
      end
    end
    object tsSummaryGroups: TTabSheet
      Caption = '  Summary  '
      object Panel9: TPanel
        Left = 0
        Top = 0
        Width = 347
        Height = 6
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Panel10: TPanel
        Left = 0
        Top = 228
        Width = 347
        Height = 6
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
      end
      object pnItems: TPanel
        Left = 177
        Top = 6
        Width = 170
        Height = 222
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object Panel11: TPanel
          Left = 164
          Top = 0
          Width = 6
          Height = 222
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
        end
        object GroupBox2: TGroupBox
          Left = 0
          Top = 0
          Width = 164
          Height = 222
          Align = alClient
          Caption = ' SummaryItems '
          TabOrder = 1
          object LItems: TListBox
            Left = 8
            Top = 19
            Width = 148
            Height = 166
            Align = alClient
            DragMode = dmAutomatic
            ItemHeight = 13
            MultiSelect = True
            PopupMenu = pmItems
            TabOrder = 0
            OnClick = LItemsClick
            OnDragDrop = LItemsDragDrop
            OnDragOver = LItemsDragOver
            OnEndDrag = LItemsEndDrag
            OnKeyDown = CListBoxKeyDown
            OnStartDrag = CListBoxStartDrag
          end
          object Panel14: TPanel
            Left = 2
            Top = 19
            Width = 6
            Height = 155
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 1
            ExplicitHeight = 167
          end
          object Panel20: TPanel
            Left = 148
            Top = 19
            Width = 6
            Height = 155
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 2
            ExplicitLeft = 156
            ExplicitHeight = 167
          end
          object Panel22: TPanel
            Left = 2
            Top = 15
            Width = 152
            Height = 4
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 3
            ExplicitWidth = 160
          end
          object Panel23: TPanel
            Left = 2
            Top = 174
            Width = 152
            Height = 35
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 4
            ExplicitTop = 186
            ExplicitWidth = 160
            object BAddItem: TButton
              Left = 8
              Top = 7
              Width = 68
              Height = 22
              Caption = 'Add'
              TabOrder = 0
              OnClick = BAddItemClick
            end
            object BDeleteItem: TButton
              Left = 86
              Top = 7
              Width = 68
              Height = 22
              Caption = 'Delete'
              TabOrder = 1
              OnClick = BDeleteItemClick
            end
          end
        end
      end
      object pnGroups: TPanel
        Left = 0
        Top = 6
        Width = 177
        Height = 211
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 3
        ExplicitHeight = 223
        object Panel7: TPanel
          Left = 0
          Top = 0
          Width = 6
          Height = 222
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
        end
        object Panel16: TPanel
          Left = 170
          Top = 0
          Width = 7
          Height = 222
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
        end
        object GroupBox1: TGroupBox
          Left = 6
          Top = 0
          Width = 164
          Height = 222
          Align = alClient
          Caption = ' SummaryGroups '
          TabOrder = 2
          object LGroups: TListBox
            Left = 8
            Top = 19
            Width = 148
            Height = 166
            Align = alClient
            DragMode = dmAutomatic
            ItemHeight = 13
            MultiSelect = True
            PopupMenu = pmGroups
            TabOrder = 0
            OnClick = LGroupsClick
            OnDragDrop = LGroupsDragDrop
            OnDragOver = LGroupsDragOver
            OnEndDrag = LGroupsEndDrag
            OnKeyDown = CListBoxKeyDown
            OnStartDrag = CListBoxStartDrag
          end
          object Panel17: TPanel
            Left = 2
            Top = 19
            Width = 6
            Height = 155
            Align = alLeft
            BevelOuter = bvNone
            TabOrder = 1
            ExplicitHeight = 167
          end
          object Panel18: TPanel
            Left = 156
            Top = 19
            Width = 6
            Height = 155
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 2
            ExplicitHeight = 167
          end
          object Panel19: TPanel
            Left = 2
            Top = 15
            Width = 160
            Height = 4
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 3
          end
          object Panel21: TPanel
            Left = 2
            Top = 174
            Width = 160
            Height = 35
            Align = alBottom
            BevelOuter = bvNone
            TabOrder = 4
            ExplicitTop = 186
            object BAddGroup: TButton
              Left = 8
              Top = 7
              Width = 68
              Height = 22
              Caption = 'Add'
              TabOrder = 0
              OnClick = BAddGroupClick
            end
            object BDeleteGroup: TButton
              Left = 86
              Top = 7
              Width = 68
              Height = 22
              Caption = 'Delete'
              TabOrder = 1
              OnClick = BDeleteGroupClick
            end
          end
        end
      end
    end
  end
  object pmColumns: TPopupMenu
    Left = 228
    Top = 6
    object miAdd: TMenuItem
      Caption = '&Add...'
      ShortCut = 45
      OnClick = BAddClick
    end
    object miDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDeleteClick
    end
    object miChangetype: TMenuItem
      Caption = '&Change type...'
      OnClick = BChangeClick
    end
    object miUp: TMenuItem
      Caption = 'Move &Up'
      OnClick = BUpClick
    end
    object miDown: TMenuItem
      Caption = 'Move Dow&n'
      OnClick = BDownClick
    end
    object miWizard: TMenuItem
      Caption = 'Add All &Fields'
      OnClick = BWizardClick
    end
    object miRestore: TMenuItem
      Caption = 'Rest&ore Defaults'
      OnClick = BRestoreClick
    end
    object miRestoreDefaultWidths: TMenuItem
      Caption = 'Restore &Widths'
      OnClick = BRestoreWidthsClick
    end
    object miSelectAll: TMenuItem
      Caption = '&Select All'
      OnClick = miSelectAllClick
    end
  end
  object pmGroups: TPopupMenu
    Left = 260
    Top = 6
    object miAddGroup: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BAddGroupClick
    end
    object miDeleteGroup: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDeleteGroupClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miSellectGroup: TMenuItem
      Caption = '&Select All'
      OnClick = miSellectGroupClick
    end
  end
  object pmItems: TPopupMenu
    Left = 294
    Top = 6
    object miAddItem: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BAddItemClick
    end
    object miDeleteItem: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDeleteItemClick
    end
    object MenuItem3: TMenuItem
      Caption = '-'
    end
    object miSelectItems: TMenuItem
      Caption = '&Select All'
      OnClick = miSelectItemsClick
    end
  end
  object pmBands: TPopupMenu
    Left = 194
    Top = 6
    object miAddBand: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BAddBandClick
    end
    object miDeleteBand: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDeleteBandClick
    end
    object miUpBand: TMenuItem
      Caption = 'Move &Up'
      OnClick = BUpBandClick
    end
    object miDownBand: TMenuItem
      Caption = 'Move Dow&n'
      OnClick = BDownBandClick
    end
    object miRestoreBands: TMenuItem
      Caption = 'Rest&ore Defaults'
      OnClick = BRestoreDefaultClick
    end
    object miAllBands: TMenuItem
      Caption = '&Select All'
      OnClick = miAllBandsClick
    end
  end
end

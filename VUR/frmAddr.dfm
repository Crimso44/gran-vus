object fAddr: TfAddr
  Left = 0
  Top = 0
  Caption = #1040#1076#1088#1077#1089' '#1080' '#1089#1077#1084#1077#1081#1085#1086#1077' '#1087#1086#1083#1086#1078#1077#1085#1080#1077
  ClientHeight = 399
  ClientWidth = 737
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label20: TLabel
    Left = 8
    Top = 132
    Width = 133
    Height = 13
    Caption = #1057#1077#1084#1077#1081#1085#1086#1077' '#1087#1086#1083#1086#1078#1077#1085#1080#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 358
    Width = 737
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 233
    ExplicitWidth = 679
    DesignSize = (
      737
      41)
    object btnOk: TButton
      Left = 643
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
      OnClick = btnOkClick
      ExplicitLeft = 585
    end
  end
  object dxtFamily: TdxTreeList
    Left = 8
    Top = 182
    Width = 720
    Height = 159
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderMinRowCount = 2
    HeaderPanelRowCount = 1
    PopupMenu = pmFamily
    TabOrder = 1
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoCaseInsensitive]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
    TreeLineColor = clGrayText
    ShowRoot = False
    ShowIndicator = True
    object colFamType: TdxTreeListPickColumn
      Caption = #1057#1086#1089#1090#1072#1074' '#1089#1077#1084#1100#1080
      Width = 81
      BandIndex = 0
      RowIndex = 0
      DropDownListStyle = True
      Revertable = True
    end
    object dxTreeListMaskColumn1: TdxTreeListMaskColumn
      Caption = #1060#1048#1054
      MaxLength = 100
      Width = 219
      BandIndex = 0
      RowIndex = 0
    end
    object dxTreeListMaskColumn2: TdxTreeListMaskColumn
      Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
      Width = 93
      BandIndex = 0
      RowIndex = 0
    end
    object dxtFamilyColumn4: TdxTreeListMaskColumn
      Caption = #1040#1076#1088#1077#1089
      Width = 307
      BandIndex = 0
      RowIndex = 0
    end
  end
  object cbFamState: TComboBox
    Left = 8
    Top = 155
    Width = 281
    Height = 21
    Style = csDropDownList
    TabOrder = 2
    OnChange = cbFamStateChange
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 357
    Height = 119
    Caption = #1044#1086#1084#1072#1096#1085#1080#1081' '#1072#1076#1088#1077#1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object Label12: TLabel
      Left = 70
      Top = 85
      Width = 56
      Height = 13
      Caption = #1088#1077#1075#1080#1089#1090#1088'. '#1089':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label168: TLabel
      Left = 227
      Top = 85
      Width = 16
      Height = 13
      Caption = #1087#1086':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 211
      Top = 31
      Width = 70
      Height = 13
      Caption = #1087#1086#1095#1090'.  '#1080#1085#1076#1077#1082#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dtADDR_DATE1: TdxDateEdit
      Left = 128
      Top = 81
      Width = 93
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = edIndex1Change
      Date = -700000.000000000000000000
      SaveTime = False
    end
    object dtADDR_DATE_END1: TdxDateEdit
      Left = 251
      Top = 81
      Width = 93
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnChange = edIndex1Change
      Date = -700000.000000000000000000
      SaveTime = False
    end
    object edAddr1: TEdit
      Left = 8
      Top = 54
      Width = 336
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 200
      ParentFont = False
      TabOrder = 2
      OnChange = edIndex1Change
    end
    object edIndex1: TEdit
      Left = 283
      Top = 27
      Width = 61
      Height = 21
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 6
      NumbersOnly = True
      ParentFont = False
      TabOrder = 3
      OnChange = edIndex1Change
    end
  end
  object GroupBox2: TGroupBox
    Left = 371
    Top = 8
    Width = 357
    Height = 119
    Caption = #1060#1072#1082#1090#1080#1095#1077#1089#1082#1080#1081' '#1072#1076#1088#1077#1089
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object Label14: TLabel
      Left = 210
      Top = 30
      Width = 67
      Height = 13
      Caption = #1087#1086#1095#1090'. '#1080#1085#1076#1077#1082#1089
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 169
      Top = 85
      Width = 74
      Height = 13
      Caption = #1087#1088#1086#1078#1080#1074#1072#1085#1080#1077' '#1089':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edIndex2: TEdit
      Left = 283
      Top = 27
      Width = 61
      Height = 21
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 6
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnChange = edIndex1Change
    end
    object edAddr2: TEdit
      Left = 3
      Top = 54
      Width = 342
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 200
      ParentFont = False
      TabOrder = 1
      OnChange = edIndex1Change
    end
    object dtADDR_DATE2: TdxDateEdit
      Left = 251
      Top = 81
      Width = 93
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = edIndex1Change
      Date = -700000.000000000000000000
      SaveTime = False
    end
  end
  object pmFamily: TPopupMenu
    Left = 160
    Top = 15
    object MenuItem1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = MenuItem1Click
    end
    object MenuItem2: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnClick = MenuItem2Click
    end
  end
end

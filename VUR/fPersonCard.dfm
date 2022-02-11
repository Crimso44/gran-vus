object fmPersonForm: TfmPersonForm
  Left = 282
  Top = 143
  HelpContext = 11
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1051#1080#1095#1085#1072#1103' '#1082#1072#1088#1090#1086#1095#1082#1072' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
  ClientHeight = 494
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  Visible = True
  OnActivate = FormActivate
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDeactivate = FormDeactivate
  OnKeyDown = FormKeyDown
  DesignSize = (
    797
    494)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 32
    Width = 125
    Height = 13
    Caption = #1044#1072#1090#1072' '#1080' '#1084#1077#1089#1090#1086' '#1088#1086#1078#1076#1077#1085#1080#1103':'
  end
  object Bevel1: TBevel
    Left = 8
    Top = 460
    Width = 792
    Height = 4
    Anchors = [akLeft, akRight, akBottom]
    Shape = bsBottomLine
    ExplicitWidth = 793
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 52
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103':'
  end
  object Label2: TLabel
    Left = 204
    Top = 8
    Width = 25
    Height = 13
    Caption = #1048#1084#1103':'
  end
  object Label37: TLabel
    Left = 312
    Top = 8
    Width = 50
    Height = 13
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
  end
  object Label40: TLabel
    Left = 468
    Top = 8
    Width = 23
    Height = 13
    Caption = #1055#1086#1083':'
  end
  object Label60: TLabel
    Left = 8
    Top = 473
    Width = 202
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1053#1072#1079#1085#1072#1095#1080#1090#1100' '#1076#1072#1090#1091' '#1086#1095#1077#1088#1077#1076#1085#1086#1075#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103':'
  end
  object Label66: TLabel
    Left = 452
    Top = 32
    Width = 43
    Height = 13
    Caption = '(OKATO)'
    Visible = False
  end
  object Label68: TLabel
    Left = 28
    Top = 340
    Width = 47
    Height = 13
    Caption = #1042#1090#1086#1088#1086#1077':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label69: TLabel
    Left = 28
    Top = 364
    Width = 58
    Height = 13
    Caption = #1044#1080#1087#1083#1086#1084' '#8470':'
  end
  object Label73: TLabel
    Left = 364
    Top = 364
    Width = 85
    Height = 13
    Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
  end
  object Label74: TLabel
    Left = 28
    Top = 388
    Width = 78
    Height = 13
    Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103':'
  end
  object Label75: TLabel
    Left = 28
    Top = 412
    Width = 71
    Height = 13
    Caption = #1053#1072#1087#1088#1072#1074#1083#1077#1085#1080#1077':'
  end
  object Label76: TLabel
    Left = 364
    Top = 412
    Width = 70
    Height = 13
    Caption = #1050#1086#1076' '#1087#1086' '#1054#1050#1057#1054':'
  end
  object Bevel2: TBevel
    Left = 4
    Top = 48
    Width = 785
    Height = 6
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
    ExplicitWidth = 786
  end
  object Label15: TLabel
    Left = 341
    Top = 473
    Width = 150
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1044#1072#1090#1072' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103':'
  end
  object lblConf: TLabel
    Left = 497
    Top = 473
    Width = 54
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = '12.12.1999'
  end
  object SpeedButton2: TSpeedButton
    Left = 392
    Top = 248
    Width = 23
    Height = 22
  end
  object PC: TPageControl
    Left = 0
    Top = 55
    Width = 797
    Height = 406
    ActivePage = tabSheetX0
    HotTrack = True
    MultiLine = True
    RaggedRight = True
    Style = tsFlatButtons
    TabOrder = 8
    OnChanging = PCChanging
    OnDrawTab = PCDrawTab
    object TabSheet1: TTabSheet
      Caption = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103'   '
      object Label6: TLabel
        Left = 4
        Top = 28
        Width = 55
        Height = 13
        Caption = #1055#1072#1089#1087#1086#1088#1090':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 168
        Top = 28
        Width = 11
        Height = 13
        Caption = #8470
      end
      object Label8: TLabel
        Left = 12
        Top = 48
        Width = 59
        Height = 13
        Caption = #1050#1077#1084' '#1074#1099#1076#1072#1085':'
      end
      object Label9: TLabel
        Left = 12
        Top = 92
        Width = 69
        Height = 13
        Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080':'
      end
      object Label11: TLabel
        Left = 4
        Top = 108
        Width = 107
        Height = 13
        Caption = #1044#1086#1084#1072#1096#1085#1080#1081' '#1072#1076#1088#1077#1089':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 12
        Top = 128
        Width = 55
        Height = 13
        Caption = #1088#1077#1075#1080#1089#1090#1088'. '#1089':'
      end
      object Label10: TLabel
        Left = 12
        Top = 196
        Width = 69
        Height = 13
        Caption = #1092#1072#1082#1090#1080#1095#1077#1089#1082#1080#1081':'
      end
      object Label13: TLabel
        Left = 180
        Top = 151
        Width = 39
        Height = 13
        Caption = ' '#1080#1085#1076#1077#1082#1089
      end
      object Label14: TLabel
        Left = 156
        Top = 196
        Width = 64
        Height = 13
        Caption = #1087#1086#1095#1090'. '#1080#1085#1076#1077#1082#1089
      end
      object Label19: TLabel
        Left = 292
        Top = 56
        Width = 177
        Height = 13
        Caption = #1047#1085#1072#1085#1080#1077' '#1080#1085#1086#1089#1090#1088#1072#1085#1085#1099#1093' '#1103#1079#1099#1082#1086#1074':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label20: TLabel
        Left = 291
        Top = 167
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
      object Label39: TLabel
        Left = 4
        Top = 4
        Width = 83
        Height = 13
        Caption = #1043#1088#1072#1078#1076#1072#1085#1089#1090#1074#1086':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 415
        Top = 4
        Width = 32
        Height = 13
        Caption = #1048#1053#1053':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label38: TLabel
        Left = 296
        Top = 28
        Width = 151
        Height = 13
        Caption = #8470' '#1089#1090#1088#1072#1093'. '#1089#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label59: TLabel
        Left = 579
        Top = 167
        Width = 167
        Height = 13
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1074#1077#1076#1077#1085#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label168: TLabel
        Left = 169
        Top = 128
        Width = 15
        Height = 13
        Caption = #1087#1086':'
      end
      object edPspSer: TEdit
        Left = 108
        Top = 24
        Width = 49
        Height = 21
        MaxLength = 10
        TabOrder = 2
        OnChange = edFamChange
      end
      object edPspNum: TEdit
        Left = 188
        Top = 24
        Width = 73
        Height = 21
        MaxLength = 10
        TabOrder = 3
        OnChange = edFamChange
      end
      object dtPspDate: TdxDateEdit
        Left = 192
        Top = 88
        Width = 93
        TabOrder = 6
        OnChange = edFamChange
        Date = -700000.000000000000000000
        SaveTime = False
      end
      object edIndex1: TEdit
        Left = 224
        Top = 147
        Width = 61
        Height = 21
        AutoSize = False
        MaxLength = 6
        NumbersOnly = True
        TabOrder = 9
        OnChange = edFamChange
      end
      object edAddr1: TEdit
        Left = 21
        Top = 170
        Width = 264
        Height = 21
        MaxLength = 200
        TabOrder = 10
        OnChange = edFamChange
      end
      object edIndex2: TEdit
        Left = 224
        Top = 192
        Width = 61
        Height = 21
        AutoSize = False
        MaxLength = 6
        NumbersOnly = True
        TabOrder = 11
        OnChange = edFamChange
      end
      object edAddr2: TEdit
        Left = 21
        Top = 215
        Width = 264
        Height = 21
        MaxLength = 200
        TabOrder = 12
        OnChange = edFamChange
      end
      object dxtLang: TdxTreeList
        Left = 292
        Top = 72
        Width = 281
        Height = 89
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        PopupMenu = pmLang
        TabOrder = 14
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoCaseInsensitive]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
        TreeLineColor = clGrayText
        ShowRoot = False
        ShowIndicator = True
        object colLangName: TdxTreeListPickColumn
          Caption = #1071#1079#1099#1082
          CharCase = ecUpperCase
          Width = 117
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          DropDownListStyle = True
          Revertable = True
        end
        object colLangSkill: TdxTreeListPickColumn
          Caption = #1057#1090#1077#1087#1077#1085#1100' '#1074#1083#1072#1076#1077#1085#1080#1103
          Width = 150
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          DropDownListStyle = True
          Revertable = True
        end
      end
      object cbFamState: TComboBox
        Left = 291
        Top = 186
        Width = 281
        Height = 21
        Style = csDropDownList
        TabOrder = 15
        OnChange = cbFamStateChange
      end
      object dxtFamily: TdxTreeList
        Left = 291
        Top = 213
        Width = 281
        Height = 159
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderMinRowCount = 2
        HeaderPanelRowCount = 1
        PopupMenu = pmFamily
        TabOrder = 16
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoCaseInsensitive]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
        TreeLineColor = clGrayText
        ShowRoot = False
        ShowIndicator = True
        object colFamType: TdxTreeListPickColumn
          Caption = #1057#1086#1089#1090#1072#1074' '#1089#1077#1084#1100#1080
          Width = 57
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          DropDownListStyle = True
          Revertable = True
        end
        object dxTreeListMaskColumn1: TdxTreeListMaskColumn
          Caption = #1060#1048#1054
          MaxLength = 100
          Width = 116
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
        end
        object dxTreeListMaskColumn2: TdxTreeListMaskColumn
          Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
          Width = 93
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
        end
      end
      object edPspPlace: TEdit
        Left = 12
        Top = 64
        Width = 273
        Height = 21
        MaxLength = 100
        TabOrder = 5
        OnChange = edFamChange
      end
      object cbNat: TComboBox
        Left = 108
        Top = 0
        Width = 297
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = edFamChange
      end
      object edINN: TEdit
        Left = 460
        Top = 0
        Width = 113
        Height = 21
        MaxLength = 12
        TabOrder = 1
        OnChange = edFamChange
        OnKeyPress = edOKATOKeyPress
      end
      object edStrah: TEdit
        Left = 460
        Top = 24
        Width = 113
        Height = 21
        MaxLength = 20
        TabOrder = 4
        OnChange = edFamChange
        OnKeyPress = edOKATOKeyPress
      end
      object dtADDR_DATE1: TdxDateEdit
        Left = 70
        Top = 124
        Width = 93
        TabOrder = 7
        OnChange = edFamChange
        Date = -700000.000000000000000000
        SaveTime = False
      end
      object dbgData: TdxDBGrid
        Left = 3
        Top = 240
        Width = 282
        Height = 132
        TabStop = False
        Bands = <
          item
            Width = 151
          end>
        DefaultLayout = False
        HeaderMinRowCount = 3
        HeaderPanelRowCount = 1
        KeyField = 'CHANGE_ID'
        SummaryGroups = <>
        SummarySeparator = ', '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        BandFont.Charset = DEFAULT_CHARSET
        BandFont.Color = clWindowText
        BandFont.Height = -11
        BandFont.Name = 'MS Sans Serif'
        BandFont.Style = []
        DataSource = DataSource1
        Filter.Criteria = {00000000}
        FixedBandLineWidth = 1
        HeaderFont.Charset = RUSSIAN_CHARSET
        HeaderFont.Color = clWindowText
        HeaderFont.Height = -9
        HeaderFont.Name = 'Small Fonts'
        HeaderFont.Style = []
        OptionsBehavior = [edgoAnsiSort, edgoAutoSearch, edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoMultiSort, edgoTabThrough, edgoVertThrough]
        OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoRowSizing]
        OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseLocate]
        OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoUseBitmap]
        PreviewFont.Charset = DEFAULT_CHARSET
        PreviewFont.Color = clBlue
        PreviewFont.Height = -11
        PreviewFont.Name = 'MS Sans Serif'
        PreviewFont.Style = []
        object dbgDataColumn1: TdxDBGridDateColumn
          Width = 65
          BandIndex = 0
          RowIndex = 0
          FieldName = 'BEGIN_DATE'
        end
        object dbgDataColumn2: TdxDBGridMaskColumn
          Caption = 
            #1044#1088#1091#1075#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' ('#1087#1088#1080#1095#1080#1085#1072' '#1085#1077#1074#1088#1091#1095#1077#1085#1080#1103', '#1076#1072#1090#1072' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1087#1086#1095#1090#1086#1081' '#1080' '#1076#1088 +
            '.)'
          Width = 130
          BandIndex = 0
          RowIndex = 0
          FieldName = 'NOTBEGINREASON'
        end
        object dbgDataColumn3: TdxDBGridDateColumn
          Width = 65
          BandIndex = 0
          RowIndex = 0
          FieldName = 'END_DATE'
        end
      end
      object GroupBox3: TGroupBox
        Left = 579
        Top = 56
        Width = 207
        Height = 105
        Caption = #1058#1077#1083#1077#1092#1086#1085#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 17
        object Label16: TLabel
          Left = 3
          Top = 23
          Width = 41
          Height = 13
          Caption = #1088#1072#1073#1086#1095#1080#1081
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label17: TLabel
          Left = 3
          Top = 50
          Width = 52
          Height = 13
          Caption = #1076#1086#1084#1072#1096#1085#1080#1081
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 3
          Top = 77
          Width = 58
          Height = 13
          Caption = #1084#1086#1073#1080#1083#1100#1085#1099#1081
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edPhone1: TEdit
          Left = 67
          Top = 20
          Width = 126
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 50
          ParentFont = False
          TabOrder = 0
          OnChange = edFamChange
        end
        object edPhone2: TEdit
          Left = 67
          Top = 47
          Width = 126
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 50
          ParentFont = False
          TabOrder = 1
          OnChange = edFamChange
        end
        object edPhone3: TEdit
          Left = 67
          Top = 74
          Width = 126
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 50
          ParentFont = False
          TabOrder = 2
          OnChange = edFamChange
        end
      end
      object edComments: TMemo
        Left = 579
        Top = 186
        Width = 207
        Height = 186
        ScrollBars = ssVertical
        TabOrder = 18
        OnChange = edFamChange
      end
      object dtADDR_DATE_END1: TdxDateEdit
        Left = 193
        Top = 124
        Width = 93
        TabOrder = 8
        OnChange = edFamChange
        Date = -700000.000000000000000000
        SaveTime = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1054#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077'   '
      ImageIndex = 1
      object Label21: TLabel
        Left = 16
        Top = 28
        Width = 49
        Height = 13
        Caption = #1055#1077#1088#1074#1086#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label22: TLabel
        Left = 16
        Top = 50
        Width = 54
        Height = 13
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090':'
      end
      object Label23: TLabel
        Left = 16
        Top = 73
        Width = 81
        Height = 13
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100':'
      end
      object Label24: TLabel
        Left = 391
        Top = 49
        Width = 85
        Height = 13
        Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
      end
      object Label25: TLabel
        Left = 16
        Top = 96
        Width = 78
        Height = 13
        Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103':'
      end
      object Label27: TLabel
        Left = 0
        Top = 4
        Width = 108
        Height = 13
        Caption = #1042#1080#1076' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label29: TLabel
        Left = 16
        Top = 120
        Width = 47
        Height = 13
        Caption = #1042#1090#1086#1088#1086#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label30: TLabel
        Left = 16
        Top = 162
        Width = 81
        Height = 13
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100':'
      end
      object Label31: TLabel
        Left = 391
        Top = 139
        Width = 85
        Height = 13
        Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
      end
      object Label33: TLabel
        Left = 16
        Top = 184
        Width = 78
        Height = 13
        Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103':'
      end
      object Label34: TLabel
        Left = 0
        Top = 327
        Width = 173
        Height = 13
        Caption = #1055#1088#1086#1092#1077#1089#1089#1080#1103' '#1087#1086' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1102':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label35: TLabel
        Left = 172
        Top = 327
        Width = 100
        Height = 13
        Caption = #1086#1089#1085#1086#1074#1085#1072#1103', '#1054#1050#1055#1044#1058#1056
      end
      object Label77: TLabel
        Left = 16
        Top = 208
        Width = 104
        Height = 13
        Caption = #1055#1086#1089#1083#1077#1074#1091#1079#1086#1074#1089#1082#1086#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label79: TLabel
        Left = 391
        Top = 208
        Width = 85
        Height = 13
        Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103':'
      end
      object Label80: TLabel
        Left = 16
        Top = 282
        Width = 81
        Height = 13
        Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100':'
      end
      object Label81: TLabel
        Left = 16
        Top = 307
        Width = 84
        Height = 13
        Caption = #1059#1095#1105#1085#1072#1103' '#1089#1090#1077#1087#1077#1085#1100':'
      end
      object Label36: TLabel
        Left = 476
        Top = 327
        Width = 86
        Height = 13
        Caption = #1076#1088#1091#1075#1072#1103', '#1054#1050#1055#1044#1058#1056
      end
      object Label26: TLabel
        Left = 376
        Top = 95
        Width = 70
        Height = 13
        Caption = #1050#1086#1076' '#1087#1086' '#1054#1050#1057#1054':'
      end
      object Label32: TLabel
        Left = 376
        Top = 185
        Width = 70
        Height = 13
        Caption = #1050#1086#1076' '#1087#1086' '#1054#1050#1057#1054':'
      end
      object Label82: TLabel
        Left = 376
        Top = 306
        Width = 70
        Height = 13
        Caption = #1050#1086#1076' '#1087#1086' '#1054#1050#1057#1054':'
      end
      object Label155: TLabel
        Left = 179
        Top = 49
        Width = 31
        Height = 13
        Caption = #1057#1077#1088#1080#1103
      end
      object Label156: TLabel
        Left = 270
        Top = 49
        Width = 11
        Height = 13
        Caption = #8470
      end
      object Label28: TLabel
        Left = 270
        Top = 138
        Width = 11
        Height = 13
        Caption = #8470
      end
      object Label157: TLabel
        Left = 179
        Top = 138
        Width = 31
        Height = 13
        Caption = #1057#1077#1088#1080#1103
      end
      object Label158: TLabel
        Left = 16
        Top = 139
        Width = 54
        Height = 13
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090':'
      end
      object Label159: TLabel
        Left = 16
        Top = 230
        Width = 203
        Height = 13
        Caption = #1054#1073#1088#1072#1079#1086#1074#1072#1090#1077#1083#1100#1085#1086#1077', '#1085#1072#1091#1095#1085#1086#1077' '#1091#1095#1088#1077#1078#1076#1077#1085#1080#1077':'
      end
      object Label78: TLabel
        Left = 391
        Top = 254
        Width = 69
        Height = 13
        Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080':'
      end
      object Label160: TLabel
        Left = 270
        Top = 253
        Width = 11
        Height = 13
        Caption = #8470
      end
      object Label161: TLabel
        Left = 179
        Top = 253
        Width = 31
        Height = 13
        Caption = #1057#1077#1088#1080#1103
      end
      object Label162: TLabel
        Left = 16
        Top = 254
        Width = 54
        Height = 13
        Caption = #1044#1086#1082#1091#1084#1077#1085#1090':'
      end
      object bNapr1: TSpeedButton
        Left = 549
        Top = 68
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = bNapr1Click
      end
      object SpeedButton1: TSpeedButton
        Left = 549
        Top = 158
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = bNapr1Click
      end
      object bNapr3: TSpeedButton
        Left = 549
        Top = 279
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = bNapr1Click
      end
      object bKval1: TSpeedButton
        Left = 347
        Top = 90
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = bKval1Click
      end
      object bKval2: TSpeedButton
        Left = 347
        Top = 181
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = bKval1Click
      end
      object edDipl1: TEdit
        Left = 287
        Top = 46
        Width = 98
        Height = 21
        MaxLength = 50
        TabOrder = 4
        OnChange = edFamChange
      end
      object cbUz1: TdxPickEdit
        Left = 128
        Top = 24
        Width = 445
        TabOrder = 1
        MaxLength = 100
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        StoredValues = 2
      end
      object cbEduc: TComboBox
        Left = 128
        Top = 0
        Width = 445
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        TabOrder = 0
        OnChange = edFamChange
      end
      object cbUz2: TdxPickEdit
        Left = 128
        Top = 114
        Width = 445
        TabOrder = 9
        MaxLength = 100
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        StoredValues = 2
      end
      object edDipl2: TEdit
        Left = 287
        Top = 136
        Width = 98
        Height = 21
        MaxLength = 50
        TabOrder = 12
        OnChange = edFamChange
      end
      object edOKPDTR1: TEdit
        Left = 225
        Top = 343
        Width = 61
        Height = 21
        MaxLength = 10
        TabOrder = 28
        OnChange = edFamChange
        OnKeyPress = edOKATOKeyPress
      end
      object edOKPDTR2: TEdit
        Left = 512
        Top = 343
        Width = 61
        Height = 21
        MaxLength = 10
        TabOrder = 30
        OnChange = edFamChange
        OnKeyPress = edOKATOKeyPress
      end
      object edProf1: TEdit
        Left = 3
        Top = 343
        Width = 220
        Height = 21
        MaxLength = 50
        TabOrder = 27
        OnChange = edFamChange
      end
      object edProf2: TEdit
        Left = 292
        Top = 343
        Width = 220
        Height = 21
        MaxLength = 50
        TabOrder = 29
        OnChange = edFamChange
      end
      object edDate1: TEdit
        Left = 482
        Top = 46
        Width = 92
        Height = 21
        MaxLength = 10
        TabOrder = 5
        OnChange = edFamChange
      end
      object edDate2: TEdit
        Left = 482
        Top = 136
        Width = 91
        Height = 21
        MaxLength = 10
        TabOrder = 13
        OnChange = edFamChange
      end
      object edDate3: TEdit
        Left = 482
        Top = 204
        Width = 91
        Height = 21
        MaxLength = 10
        TabOrder = 18
        OnChange = edFamChange
      end
      object edDipl3: TEdit
        Left = 287
        Top = 252
        Width = 98
        Height = 21
        MaxLength = 50
        TabOrder = 22
        OnChange = edFamChange
      end
      object cbUz3: TdxPickEdit
        Left = 225
        Top = 227
        Width = 349
        TabOrder = 19
        MaxLength = 100
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        StoredValues = 2
      end
      object edKval3: TdxMRUEdit
        Left = 128
        Top = 301
        Width = 242
        TabOrder = 25
        MaxLength = 50
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        DropDownListStyle = True
        OnButtonClick = edKval3ButtonClick
        StoredValues = 2
      end
      object edOKSO1: TEdit
        Left = 452
        Top = 90
        Width = 121
        Height = 21
        MaxLength = 10
        TabOrder = 8
        OnChange = edFamChange
        OnKeyPress = edOKATOKeyPress
      end
      object edOKSO2: TEdit
        Left = 452
        Top = 180
        Width = 121
        Height = 21
        MaxLength = 10
        TabOrder = 16
        OnChange = edFamChange
        OnKeyPress = edOKATOKeyPress
      end
      object edOKSO3: TEdit
        Left = 452
        Top = 301
        Width = 121
        Height = 21
        MaxLength = 10
        TabOrder = 26
        OnChange = edFamChange
        OnKeyPress = edOKATOKeyPress
      end
      object cbObrDoc1: TdxPickEdit
        Left = 76
        Top = 46
        Width = 97
        TabOrder = 2
        MaxLength = 100
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        StoredValues = 2
      end
      object edDiplSer1: TEdit
        Left = 216
        Top = 46
        Width = 41
        Height = 21
        MaxLength = 50
        TabOrder = 3
        OnChange = edFamChange
      end
      object edDiplSer2: TEdit
        Left = 216
        Top = 135
        Width = 41
        Height = 21
        MaxLength = 50
        TabOrder = 11
        OnChange = edFamChange
      end
      object cbObrDoc2: TdxPickEdit
        Left = 76
        Top = 135
        Width = 97
        TabOrder = 10
        MaxLength = 100
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        StoredValues = 2
      end
      object edDateGive3: TEdit
        Left = 482
        Top = 251
        Width = 91
        Height = 21
        MaxLength = 10
        TabOrder = 23
        OnChange = edFamChange
      end
      object edDiplSer3: TEdit
        Left = 216
        Top = 250
        Width = 41
        Height = 21
        MaxLength = 50
        TabOrder = 21
        OnChange = edFamChange
      end
      object cbObrDoc3: TdxPickEdit
        Left = 76
        Top = 250
        Width = 97
        TabOrder = 20
        MaxLength = 100
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        StoredValues = 2
      end
      object cbFormPrep3: TdxPickEdit
        Left = 128
        Top = 203
        Width = 242
        TabOrder = 17
        MaxLength = 100
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        StoredValues = 2
      end
      object edNapr1: TComboBox
        Left = 128
        Top = 68
        Width = 419
        Height = 21
        TabOrder = 6
        OnChange = edFamChange
      end
      object edKval1: TComboBox
        Left = 128
        Top = 90
        Width = 217
        Height = 21
        TabOrder = 7
        OnChange = edFamChange
      end
      object edNapr2: TComboBox
        Left = 128
        Top = 158
        Width = 419
        Height = 21
        TabOrder = 14
        OnChange = edFamChange
      end
      object edKval2: TComboBox
        Left = 128
        Top = 181
        Width = 217
        Height = 21
        TabOrder = 15
        OnChange = edFamChange
      end
      object edNapr3: TComboBox
        Left = 128
        Top = 279
        Width = 419
        Height = 21
        TabOrder = 24
        OnChange = edFamChange
      end
    end
    object tabSheetX0: TTabSheet
      Caption = #1042#1086#1080#1085#1089#1082#1080#1081' '#1091#1095#1077#1090'   '
      ImageIndex = 2
      object Bevel3: TBevel
        Left = 0
        Top = 57
        Width = 789
        Height = 8
        Align = alTop
        Shape = bsTopLine
        ExplicitWidth = 573
      end
      object Label49: TLabel
        Left = 12
        Top = 116
        Width = 91
        Height = 13
        Caption = #1042#1086#1080#1085#1089#1082#1086#1077' '#1079#1074#1072#1085#1080#1077':'
      end
      object Label50: TLabel
        Left = 12
        Top = 140
        Width = 89
        Height = 13
        Caption = #1057#1086#1089#1090#1072#1074'('#1087#1088#1086#1092#1080#1083#1100'):'
      end
      object Label51: TLabel
        Left = 329
        Top = 140
        Width = 63
        Height = 13
        Caption = #1050#1072#1090'. '#1079#1072#1087#1072#1089#1072':'
      end
      object Label52: TLabel
        Left = 12
        Top = 164
        Width = 107
        Height = 13
        Caption = #1050#1086#1076#1086#1074#1086#1077' '#1086#1073#1086#1079#1085'. '#1042#1059#1057':'
      end
      object Label53: TLabel
        Left = 444
        Top = 140
        Width = 79
        Height = 13
        Caption = #1043#1086#1076#1085'. '#1082' '#1089#1083#1091#1078#1073#1077':'
      end
      object Label54: TLabel
        Left = 232
        Top = 164
        Width = 25
        Height = 13
        Caption = #1054#1042#1050':'
      end
      object Label55: TLabel
        Left = 12
        Top = 184
        Width = 142
        Height = 13
        Caption = #1057#1086#1089#1090#1086#1080#1090' '#1085#1072' '#1074#1086#1080#1085#1089#1082#1086#1084' '#1091#1095#1077#1090#1077':'
      end
      object Label56: TLabel
        Left = 36
        Top = 204
        Width = 181
        Height = 13
        Caption = #1072') '#1086#1073#1097#1077#1084' ('#1085#1086#1084#1077#1088' '#1082#1086#1084#1072#1085#1076#1099', '#1087#1072#1088#1090#1080#1080'):'
      end
      object Label57: TLabel
        Left = 36
        Top = 228
        Width = 83
        Height = 13
        Caption = #1073') '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1086#1084':'
      end
      object Label58: TLabel
        Left = 12
        Top = 272
        Width = 294
        Height = 13
        Caption = #1054#1090#1084#1077#1090#1082#1080' '#1086' '#1089#1085#1103#1090#1080#1080' '#1089' '#1074#1086#1080#1085#1089#1082#1086#1075#1086' '#1091#1095#1077#1090#1072'/'#1087#1086#1084#1077#1097#1077#1085#1080#1103' '#1074' '#1072#1088#1093#1080#1074':'
      end
      object Label61: TLabel
        Left = 12
        Top = 252
        Width = 267
        Height = 13
        Caption = #1044#1072#1090#1072' '#1089#1085#1103#1090#1080#1103' '#1089' '#1074#1086#1080#1085#1089#1082#1086#1075#1086' '#1091#1095#1077#1090#1072'/'#1087#1086#1084#1077#1097#1077#1085#1080#1103' '#1074' '#1072#1088#1093#1080#1074':'
      end
      object Label62: TLabel
        Left = 12
        Top = 68
        Width = 78
        Height = 13
        Caption = #1056#1077#1075'. '#1085#1086#1084#1077#1088' '#1058'-2:'
      end
      object Label63: TLabel
        Left = 332
        Top = 68
        Width = 130
        Height = 13
        Caption = #1044#1072#1090#1072' '#1087#1086#1089#1090#1072#1085#1086#1074#1082#1080' '#1085#1072' '#1091#1095#1077#1090':'
      end
      object Label64: TLabel
        Left = 12
        Top = 315
        Width = 134
        Height = 13
        Caption = #1044#1072#1090#1099' '#1089#1074#1077#1088#1082#1080' :          '#1089' '#1054#1042#1050
      end
      object Label65: TLabel
        Left = 356
        Top = 315
        Width = 101
        Height = 13
        Caption = #1089' '#1074#1086#1077#1085#1085#1099#1084' '#1073#1080#1083#1077#1090#1086#1084
      end
      object Label83: TLabel
        Left = 344
        Top = 92
        Width = 140
        Height = 13
        Caption = #1043#1086#1076'/'#1076#1072#1090#1072' '#1091#1074#1086#1083#1100#1085'. '#1080#1079' '#1072#1088#1084#1080#1080':'
      end
      object laWID: TLabel
        Left = 200
        Top = 92
        Width = 56
        Height = 13
        Caption = #1051#1080#1095#1085#1099#1081' '#8470':'
      end
      object Label86: TLabel
        Left = 12
        Top = 92
        Width = 68
        Height = 13
        Caption = #1043#1088#1091#1087#1087#1072' '#1091#1095#1105#1090#1072':'
      end
      object Label110: TLabel
        Left = 12
        Top = 339
        Width = 141
        Height = 13
        Caption = #1059#1095#1072#1089#1090#1085#1080#1082' '#1073#1086#1077#1074#1099#1093' '#1076#1077#1081#1089#1090#1074#1080#1081':'
      end
      object bWUch1: TSpeedButton
        Left = 547
        Top = 201
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = bWUch1Click
      end
      object bWUch2: TSpeedButton
        Left = 449
        Top = 225
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = bWUch2Click
      end
      object Label88: TLabel
        Left = 505
        Top = 228
        Width = 67
        Height = 39
        Caption = #1054#1090#1089#1088#1086#1095#1082#1072' '#1086#1092#1086#1088#1084#1083#1077#1085#1072' '#1080' '#1076#1077#1081#1089#1090#1074#1091#1077#1090
        WordWrap = True
      end
      object Label153: TLabel
        Left = 370
        Top = 117
        Width = 92
        Height = 13
        Caption = #1044#1072#1090#1072' '#1087#1088#1080#1089#1074#1086#1077#1085#1080#1103':'
      end
      object Label169: TLabel
        Left = 316
        Top = 359
        Width = 141
        Height = 13
        Caption = #1082#1086#1085#1090#1088#1072#1082#1090' '#1085#1072' '#1084#1086#1073'. '#1088#1077#1079#1077#1088#1074' '#1076#1086
      end
      object pnlWarMain: TPanel
        Left = 0
        Top = 0
        Width = 789
        Height = 57
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object lbCateg: TLabel
          Left = 422
          Top = 11
          Width = 50
          Height = 13
          Caption = #1076#1086' 2015'#1075'.:'
        end
        object Label46: TLabel
          Left = 500
          Top = 36
          Width = 39
          Height = 13
          Caption = 'C'#1086#1089#1090#1072#1074':'
        end
        object Label87: TLabel
          Left = 264
          Top = 36
          Width = 14
          Height = 13
          Caption = #8470':'
        end
        object Label154: TLabel
          Left = 12
          Top = 11
          Width = 93
          Height = 13
          Caption = #1050#1072#1090#1077#1075'. '#1076#1086#1083#1078#1085#1086#1089#1090#1080':'
        end
        object Label167: TLabel
          Left = 340
          Top = 36
          Width = 29
          Height = 13
          Caption = #1044#1072#1090#1072':'
        end
        object rbNoSost: TRadioButton
          Left = 547
          Top = 34
          Width = 36
          Height = 17
          Caption = #1085#1077#1090
          Checked = True
          TabOrder = 7
          TabStop = True
          OnClick = edFamChange
        end
        object rbFlySost: TRadioButton
          Left = 589
          Top = 34
          Width = 109
          Height = 17
          Caption = #1083#1077#1090#1085#1086'-'#1087#1086#1076#1098#1077#1084#1085#1099#1081
          TabOrder = 8
          OnClick = edFamChange
        end
        object rbSweemSost: TRadioButton
          Left = 704
          Top = 34
          Width = 76
          Height = 17
          Caption = #1087#1083#1072#1074#1072#1102#1097#1080#1081
          TabOrder = 9
          OnClick = edFamChange
        end
        object chkVoen: TCheckBox
          Left = 12
          Top = 36
          Width = 81
          Height = 17
          Caption = #1043#1055#1047', '#1043#1055#1055
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          State = cbChecked
          TabOrder = 2
          OnClick = chkVoenClick
        end
        object stCateg: TEdit
          Left = 494
          Top = 7
          Width = 286
          Height = 21
          TabStop = False
          ParentColor = True
          ReadOnly = True
          TabOrder = 1
        end
        object edWBNum: TEdit
          Left = 280
          Top = 32
          Width = 57
          Height = 21
          MaxLength = 8
          TabOrder = 5
          OnChange = edFamChange
        end
        object edWBSer: TEdit
          Left = 236
          Top = 32
          Width = 25
          Height = 21
          CharCase = ecUpperCase
          MaxLength = 2
          TabOrder = 4
          OnChange = edFamChange
        end
        object cbDocument: TComboBox
          Left = 96
          Top = 32
          Width = 137
          Height = 21
          Style = csDropDownList
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnChange = cbDocumentChange
          Items.Strings = (
            #1042#1086#1077#1085#1085#1099#1081' '#1073#1080#1083#1077#1090
            #1042#1088#1077#1084#1077#1085#1085#1086#1077' '#1091#1076#1086#1089#1090#1086#1074#1077#1088#1077#1085#1080#1077
            #1055#1088#1080#1087#1080#1089#1085#1086#1077' '#1089#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1086' '
            #1057#1087#1088#1072#1074#1082#1072' '#1074#1079#1072#1084#1077#1085' '#1074#1086#1077#1085#1085#1086#1075#1086' '#1073#1080#1083#1077#1090#1072' ('#1089#1087#1088#1072#1074#1082#1072' '#1091#1082#1083#1086#1085#1080#1089#1090#1072')')
        end
        object stCateg2015: TEdit
          Left = 116
          Top = 7
          Width = 285
          Height = 21
          TabStop = False
          ParentColor = True
          ReadOnly = True
          TabOrder = 0
        end
        object dtWBDate: TdxDateEdit
          Left = 372
          Top = 32
          Width = 101
          Style.ButtonStyle = btsDefault
          TabOrder = 6
          OnChange = edFamChange
          Date = -700000.000000000000000000
          DateOnError = deToday
        end
      end
      object cbWRange: TComboBox
        Left = 116
        Top = 113
        Width = 197
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        TabOrder = 6
        OnChange = cbWRangeChange
      end
      object cbWProf: TComboBox
        Left = 116
        Top = 137
        Width = 197
        Height = 21
        Style = csDropDownList
        DropDownCount = 20
        TabOrder = 8
        OnChange = cbWProfChange
      end
      object edCZap: TEdit
        Left = 397
        Top = 136
        Width = 41
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 9
        OnChange = edFamChange
      end
      object edVUS: TEdit
        Left = 140
        Top = 160
        Width = 89
        Height = 21
        MaxLength = 10
        TabOrder = 11
        OnChange = edFamChange
      end
      object edWCat: TEdit
        Left = 529
        Top = 136
        Width = 41
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 1
        TabOrder = 10
        OnChange = edFamChange
      end
      object edWDiscl: TEdit
        Left = 36
        Top = 288
        Width = 533
        Height = 21
        TabOrder = 17
        OnChange = edFamChange
      end
      object dtWEnd: TdxDateEdit
        Left = 336
        Top = 248
        Width = 101
        TabOrder = 16
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object edNumbT2: TEdit
        Left = 116
        Top = 64
        Width = 101
        Height = 21
        MaxLength = 9
        TabOrder = 1
        OnChange = edFamChange
        OnKeyPress = edOKATOKeyPress
      end
      object dtWBeg: TdxDateEdit
        Left = 468
        Top = 64
        Width = 101
        Style.ButtonStyle = btsDefault
        TabOrder = 2
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object dtOVK: TdxDateEdit
        Left = 159
        Top = 311
        Width = 101
        TabOrder = 18
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object dtWBil: TdxDateEdit
        Left = 468
        Top = 311
        Width = 101
        TabOrder = 19
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object edEOARMY_DATE: TEdit
        Left = 488
        Top = 88
        Width = 81
        Height = 21
        MaxLength = 10
        TabOrder = 5
        OnChange = edFamChange
      end
      object dxpOVK: TdxMRUEdit
        Left = 263
        Top = 160
        Width = 309
        TabOrder = 12
        MaxLength = 50
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        DropDownListStyle = True
        OnButtonClick = dxpOVKButtonClick
        StoredValues = 2
      end
      object edWID: TEdit
        Left = 260
        Top = 88
        Width = 77
        Height = 21
        MaxLength = 10
        TabOrder = 4
        OnChange = edFamChange
      end
      object cbBranch: TComboBox
        Left = 116
        Top = 88
        Width = 53
        Height = 19
        AutoComplete = False
        Style = csOwnerDrawFixed
        ItemHeight = 13
        TabOrder = 3
        OnDrawItem = cbBranchDrawItem
        OnSelect = cbBranchSelect
        Items.Strings = (
          #1056#1040
          #1042#1052#1060
          #1060#1057#1041
          #1052#1042#1044
          #1057#1042#1056
          #1056#1086#1089#1075#1074#1072#1088#1076#1080#1103)
      end
      object GroupBox1: TGroupBox
        Left = 584
        Top = 63
        Width = 202
        Height = 146
        Caption = #1054#1090#1089#1088#1086#1095#1082#1072' '#1086#1090' '#1087#1088#1080#1079#1099#1074#1072
        TabOrder = 21
        object Label122: TLabel
          Left = 5
          Top = 46
          Width = 161
          Height = 13
          Caption = #1044#1072#1090#1072' '#1087#1088#1077#1076#1086#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1086#1090#1089#1088#1086#1095#1082#1080
          WordWrap = True
        end
        object Label123: TLabel
          Left = 5
          Top = 90
          Width = 136
          Height = 26
          Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' / '#1087#1077#1088#1077#1086#1089#1074#1080#1076#1077#1090#1077#1083#1100#1089#1090#1074#1086#1074#1072#1085#1080#1103
          WordWrap = True
        end
        object dxpDelay: TdxMRUEdit
          Left = 5
          Top = 19
          Width = 191
          TabOrder = 0
          MaxLength = 50
          Text = ''
          OnChange = edFamChange
          DropDownRows = 20
          DropDownListStyle = True
          CanDeleteText = True
          OnButtonClick = dxpDelayButtonClick
          StoredValues = 2
        end
        object dtDelayBeg: TdxDateEdit
          Left = 5
          Top = 63
          Width = 101
          Style.ButtonStyle = btsDefault
          TabOrder = 1
          OnChange = edFamChange
          Date = -700000.000000000000000000
          DateOnError = deToday
        end
        object dtDelayEnd: TdxDateEdit
          Left = 5
          Top = 122
          Width = 101
          Style.ButtonStyle = btsDefault
          TabOrder = 2
          OnChange = edFamChange
          Date = -700000.000000000000000000
          DateOnError = deToday
        end
      end
      object GroupBox2: TGroupBox
        Left = 584
        Top = 212
        Width = 202
        Height = 146
        Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077' '#1079#1076#1086#1088#1086#1074#1100#1103
        TabOrder = 22
        object Label128: TLabel
          Left = 5
          Top = 46
          Width = 51
          Height = 13
          Caption = #1044#1086#1082#1091#1084#1077#1085#1090
          WordWrap = True
        end
        object Label129: TLabel
          Left = 5
          Top = 90
          Width = 83
          Height = 13
          Caption = #1044#1072#1090#1072' '#1076#1086#1082#1091#1084#1077#1085#1090#1072
          WordWrap = True
        end
        object dtHealthDoc_date: TdxDateEdit
          Left = 5
          Top = 111
          Width = 116
          Style.ButtonStyle = btsDefault
          TabOrder = 2
          OnChange = edFamChange
          Date = -700000.000000000000000000
          DateOnError = deToday
        end
        object edHealth: TEdit
          Left = 5
          Top = 19
          Width = 188
          Height = 21
          MaxLength = 60
          TabOrder = 0
          OnChange = edFamChange
        end
        object edHealthDoc: TEdit
          Left = 5
          Top = 63
          Width = 188
          Height = 21
          MaxLength = 60
          TabOrder = 1
          OnChange = edFamChange
        end
      end
      object edWarfare: TEdit
        Left = 159
        Top = 334
        Width = 410
        Height = 21
        MaxLength = 255
        TabOrder = 20
        OnChange = edFamChange
      end
      object edWUch1Info: TEdit
        Left = 223
        Top = 201
        Width = 324
        Height = 21
        Color = clBtnFace
        Enabled = False
        ReadOnly = True
        TabOrder = 13
      end
      object edWUch2Info: TEdit
        Left = 125
        Top = 225
        Width = 324
        Height = 21
        Color = clBtnFace
        Enabled = False
        ReadOnly = True
        TabOrder = 14
      end
      object edWUch2_IsWork: TCheckBox
        Left = 486
        Top = 228
        Width = 13
        Height = 13
        TabOrder = 15
        WordWrap = True
        OnClick = edWUch2_IsWorkClick
      end
      object dtWrng: TdxDateEdit
        Left = 468
        Top = 113
        Width = 101
        Style.ButtonStyle = btsDefault
        TabOrder = 7
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object dtMobContract: TdxDateEdit
        Left = 468
        Top = 356
        Width = 101
        TabOrder = 24
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object bDriver: TCheckBox
        Left = 16
        Top = 358
        Width = 249
        Height = 17
        Caption = #1042#1086#1076#1080#1090#1077#1083#1100' '#1084#1086#1073'. '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072
        TabOrder = 23
        OnClick = bDriverClick
      end
    end
    object TabSheetUpol: TTabSheet
      Caption = #1055#1086#1083#1085#1086#1084#1086#1095#1080#1103
      ImageIndex = 6
      object Label166: TLabel
        Left = 3
        Top = 0
        Width = 402
        Height = 13
        Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103', '#1074' '#1082#1086#1090#1086#1088#1099#1093' '#1091#1087#1086#1083#1085#1086#1084#1086#1095#1077#1085' '#1088#1072#1079#1076#1072#1074#1072#1090#1100' '#1091#1076#1086#1089#1090#1086#1074#1077#1088#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dxtPersDeps: TdxTreeList
        Left = 3
        Top = 19
        Width = 402
        Height = 89
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        TabOrder = 0
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoCaseInsensitive]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
        TreeLineColor = clGrayText
        ShowRoot = False
        ShowIndicator = True
        object colDepName: TdxTreeListPickColumn
          Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
          CharCase = ecUpperCase
          Width = 388
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          DropDownListStyle = True
          Revertable = True
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1103'   '
      ImageIndex = 3
      object Label47: TLabel
        Left = 16
        Top = 116
        Width = 58
        Height = 13
        Caption = #1074#1080#1076' '#1088#1072#1073#1086#1090#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label41: TLabel
        Left = 4
        Top = 4
        Width = 112
        Height = 13
        Caption = #1058#1072#1073#1077#1083#1100#1085#1099#1081' '#1085#1086#1084#1077#1088':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label43: TLabel
        Left = 280
        Top = 4
        Width = 129
        Height = 13
        Caption = #1058#1088#1091#1076#1086#1074#1086#1081' '#1076#1086#1075#1086#1074#1086#1088' '#8470':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label44: TLabel
        Left = 280
        Top = 32
        Width = 29
        Height = 13
        Caption = #1044#1072#1090#1072':'
      end
      object Label5: TLabel
        Left = 4
        Top = 68
        Width = 145
        Height = 13
        Caption = #1044#1072#1090#1072' '#1087#1088#1080#1077#1084#1072' '#1085#1072' '#1088#1072#1073#1086#1090#1091':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel4: TBevel
        Left = 0
        Top = 48
        Width = 549
        Height = 9
        Shape = bsBottomLine
      end
      object Label42: TLabel
        Left = 16
        Top = 152
        Width = 55
        Height = 13
        Caption = #1076#1086#1083#1078#1085#1086#1089#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label48: TLabel
        Left = 280
        Top = 116
        Width = 86
        Height = 13
        Caption = #1093#1072#1088#1072#1082#1090#1077#1088' '#1088#1072#1073#1086#1090#1099
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label45: TLabel
        Left = 179
        Top = 96
        Width = 78
        Height = 13
        Caption = #1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label72: TLabel
        Left = 4
        Top = 96
        Width = 143
        Height = 13
        Caption = #1055#1086#1089#1083#1077#1076#1085#1077#1077' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label84: TLabel
        Left = 4
        Top = 194
        Width = 77
        Height = 13
        Caption = #1059#1074#1086#1083#1100#1085#1077#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label67: TLabel
        Left = 87
        Top = 194
        Width = 29
        Height = 13
        Caption = #1044#1072#1090#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label70: TLabel
        Left = 220
        Top = 194
        Width = 41
        Height = 13
        Caption = #1055#1088#1080#1082#1072#1079':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label71: TLabel
        Left = 421
        Top = 194
        Width = 11
        Height = 13
        Caption = #1086#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label85: TLabel
        Left = 267
        Top = 194
        Width = 11
        Height = 13
        Caption = #8470
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label120: TLabel
        Left = 3
        Top = 218
        Width = 118
        Height = 13
        Caption = #1050#1086#1085#1090#1088#1072#1082#1090' '#1080#1089#1090#1077#1082#1072#1077#1090':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label130: TLabel
        Left = 3
        Top = 242
        Width = 540
        Height = 13
        Caption = 
          #1055#1088#1080#1089#1074#1086#1077#1085#1080#1077' '#1082#1074#1072#1083'. '#1088#1072#1079#1088#1103#1076#1072', '#1082#1083#1072#1089#1089#1085#1086#1075#1086' '#1095#1080#1085#1072', '#1076#1080#1087#1083#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1088#1072#1085#1075#1072 +
          ', '#1074#1086#1080#1085#1089#1082#1086#1075#1086' '#1079#1074#1072#1085#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label152: TLabel
        Left = 280
        Top = 152
        Width = 83
        Height = 13
        Caption = #1050#1086#1076' '#1087#1086' '#1054#1050#1055#1044#1058#1056
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label163: TLabel
        Left = 16
        Top = 260
        Width = 26
        Height = 13
        Caption = #1044#1072#1090#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label164: TLabel
        Left = 364
        Top = 260
        Width = 56
        Height = 13
        Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label165: TLabel
        Left = 116
        Top = 260
        Width = 98
        Height = 13
        Caption = #1056#1072#1079#1088#1103#1076', '#1095#1080#1085', '#1088#1072#1085#1075'...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edTabNumb: TEdit
        Left = 136
        Top = 0
        Width = 101
        Height = 21
        MaxLength = 10
        TabOrder = 0
        OnChange = edFamChange
      end
      object edDogNumb: TEdit
        Left = 440
        Top = 0
        Width = 105
        Height = 21
        MaxLength = 20
        TabOrder = 1
        OnChange = edFamChange
      end
      object dtDogDate: TdxDateEdit
        Left = 440
        Top = 24
        Width = 105
        TabOrder = 3
        OnChange = edFamChange
        Date = -700000.000000000000000000
        SaveTime = False
      end
      object btnAppointments: TButton
        Left = 268
        Top = 64
        Width = 123
        Height = 21
        Caption = #1042#1089#1077' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103'...'
        TabOrder = 5
        OnClick = btnAppointmentsClick
      end
      object dtOutDate: TdxDateEdit
        Left = 127
        Top = 191
        Width = 87
        TabOrder = 11
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object edOutOrdNumb: TEdit
        Left = 284
        Top = 191
        Width = 131
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 50
        ParentFont = False
        TabOrder = 12
        OnChange = edFamChange
      end
      object dtOutOrdDate: TdxDateEdit
        Left = 438
        Top = 191
        Width = 92
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object stWorkType: TEdit
        Left = 16
        Top = 130
        Width = 250
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 7
      end
      object stInDate: TEdit
        Left = 156
        Top = 65
        Width = 101
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 4
      end
      object stWorkChar: TEdit
        Left = 280
        Top = 130
        Width = 250
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 8
      end
      object stDepart: TEdit
        Left = 280
        Top = 91
        Width = 250
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 6
      end
      object stPost: TEdit
        Left = 16
        Top = 166
        Width = 250
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 9
      end
      object cbGos: TCheckBox
        Left = 136
        Top = 28
        Width = 101
        Height = 17
        Caption = #1043#1086#1089'. '#1089#1083#1091#1078#1072#1097#1080#1081
        TabOrder = 2
        OnClick = cbGosClick
      end
      object edContractEnd: TEdit
        Left = 127
        Top = 215
        Width = 145
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 50
        ParentFont = False
        TabOrder = 14
        OnChange = edFamChange
      end
      object dxtAssign: TdxTreeList
        Left = 3
        Top = 306
        Width = 530
        Height = 56
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        Enabled = False
        PopupMenu = pmAssign
        TabOrder = 18
        Visible = False
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoAutoWidth, aoCaseInsensitive]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
        TreeLineColor = clGrayText
        ShowRoot = False
        ShowIndicator = True
        OnEdited = dxtAssignEdited
        object dxtAssign_date: TdxTreeListDateColumn
          Caption = #1044#1072#1090#1072
          Width = 64
          BandIndex = 0
          RowIndex = 0
          DateButtons = [btnToday]
          SaveTime = False
        end
        object dxtAssignText: TdxTreeListMRUColumn
          Caption = #1056#1072#1079#1088#1103#1076', '#1095#1080#1085', '#1088#1072#1085#1075'...'
          Width = 303
          BandIndex = 0
          RowIndex = 0
          ShowEllipsis = False
        end
        object dxtAssignReason: TdxTreeListMRUColumn
          Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077
          Width = 149
          BandIndex = 0
          RowIndex = 0
          ShowEllipsis = False
        end
      end
      object stOKPDTR: TEdit
        Left = 280
        Top = 166
        Width = 250
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 10
      end
      object edAssignText: TdxPickEdit
        Left = 107
        Top = 279
        Width = 247
        TabOrder = 16
        MaxLength = 100
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        DropDownListStyle = True
        CanDeleteText = True
        StoredValues = 2
      end
      object edAssignDate: TdxDateEdit
        Left = 9
        Top = 279
        Width = 92
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object edAssignReason: TdxMRUEdit
        Left = 360
        Top = 279
        Width = 182
        TabOrder = 17
        MaxLength = 50
        Text = ''
        OnChange = edFamChange
        DropDownRows = 20
        CanDeleteText = True
        ShowEllipsis = False
        StoredValues = 2
      end
    end
    object tabSheetX1: TTabSheet
      Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1091#1095#1072#1097#1077#1084#1089#1103
      ImageIndex = 4
      object lBeginStudy: TLabel
        Left = 2
        Top = 26
        Width = 132
        Height = 13
        Caption = #1047#1072#1095#1080#1089#1083#1077#1085' '#1074' '#1072#1089#1087#1080#1088#1072#1085#1090#1091#1088#1091' '#1089
      end
      object Label89: TLabel
        Left = 2
        Top = 89
        Width = 113
        Height = 13
        Caption = #1048#1089#1090#1086#1088#1080#1103' '#1086#1073#1091#1095#1077#1085#1080#1103':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label90: TLabel
        Left = 589
        Top = 76
        Width = 173
        Height = 26
        Caption = #1048#1089#1090#1086#1088#1080#1103' '#1074#1099#1076#1072#1095#1080' '#1089#1087#1088#1072#1074#1086#1082' '#1085#1072' '#1086#1090#1089#1088#1086#1095#1082#1091' '#1087#1088#1080#1079#1099#1074#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label91: TLabel
        Left = 3
        Top = 48
        Width = 123
        Height = 13
        Caption = #1055#1088#1080#1082#1072#1079' '#1086' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1080' '#8470
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label92: TLabel
        Left = 296
        Top = 46
        Width = 11
        Height = 13
        Caption = #1086#1090
      end
      object Label93: TLabel
        Left = 3
        Top = 70
        Width = 181
        Height = 13
        Caption = #1055#1083#1072#1085#1086#1074#1072#1103' '#1076#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1086#1073#1091#1095#1077#1085#1080#1103
      end
      object Label121: TLabel
        Left = 295
        Top = 28
        Width = 86
        Height = 13
        Caption = #1060#1086#1088#1084#1072' '#1086#1073#1091#1095#1077#1085#1080#1103
      end
      object Label125: TLabel
        Left = 573
        Top = 4
        Width = 132
        Height = 13
        Caption = #1044#1086#1075#1086#1074#1086#1088' '#1085#1072' '#1086#1073#1091#1095#1077#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label126: TLabel
        Left = 573
        Top = 45
        Width = 29
        Height = 13
        Caption = #1044#1072#1090#1072':'
      end
      object Label127: TLabel
        Left = 573
        Top = 26
        Width = 11
        Height = 13
        Caption = #8470
      end
      object rbStudent: TRadioButton
        Left = 3
        Top = 3
        Width = 61
        Height = 17
        Caption = #1089#1090#1091#1076#1077#1085#1090
        TabOrder = 0
        OnClick = rbAspirantClick
      end
      object rbAspirant: TRadioButton
        Left = 70
        Top = 3
        Width = 75
        Height = 17
        Caption = #1072#1089#1087#1080#1088#1072#1085#1090
        TabOrder = 1
        OnClick = rbAspirantClick
      end
      object dtBeginStudy: TdxDateEdit
        Left = 190
        Top = 23
        Width = 100
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Style.ButtonStyle = btsDefault
        Style.ButtonTransparence = ebtNone
        TabOrder = 2
        OnChange = edFamChange
        Date = -700000.000000000000000000
      end
      object dxtStudyHistory: TdxTreeList
        Left = 0
        Top = 108
        Width = 584
        Height = 100
        Bands = <
          item
          end>
        DefaultLayout = False
        HeaderMinRowCount = 2
        HeaderPanelRowCount = 1
        PopupMenu = pmStudyHistory
        TabOrder = 9
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoCaseInsensitive]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
        TreeLineColor = clGrayText
        ShowRoot = False
        ShowIndicator = True
        OnChangeNode = dxtStudyHistoryChangeNode
        OnEdited = dxtStudyHistoryEdited
        object colStudentStatus: TdxTreeListPickColumn
          Caption = #1057#1090#1072#1090#1091#1089' '#1091#1095#1072#1097#1077#1075#1086#1089#1103
          CharCase = ecUpperCase
          Width = 137
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          DropDownListStyle = True
          Revertable = True
          OnCloseUp = colStudentStatusCloseUp
        end
        object colVUZDep: TdxTreeListPickColumn
          Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1042#1059#1047#1072
          Width = 92
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          DropDownListStyle = True
          Revertable = True
        end
        object dxtStudyHistoryColumn6: TdxTreeListDateColumn
          Caption = #1044#1072#1090#1072
          Width = 58
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
        end
        object dxtStudyHistoryColumn4: TdxTreeListColumn
          Caption = #8470' '#1087#1088#1080#1082#1072#1079#1072
          Width = 63
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
        end
        object dxtStudyHistoryColumn7: TdxTreeListDateColumn
          Caption = #1044#1072#1090#1072' '#1087#1088#1080#1082#1072#1079#1072
          Width = 61
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
        end
        object colStudyForm: TdxTreeListPickColumn
          Caption = #1060#1086#1088#1084#1072' '#1086#1073#1091#1095#1077#1085#1080#1103
          Width = 159
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          OnCloseUp = colStudyFormCloseUp
        end
      end
      object dxtN26History: TdxTreeList
        Left = 590
        Top = 108
        Width = 181
        Height = 100
        Bands = <
          item
          end>
        DefaultLayout = False
        HeaderMinRowCount = 2
        HeaderPanelRowCount = 1
        PopupMenu = pmN26History
        TabOrder = 10
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoCaseInsensitive]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
        TreeLineColor = clGrayText
        ShowRoot = False
        ShowIndicator = True
        object dxtN26HistoryColumn6: TdxTreeListMaskColumn
          Caption = 'ID'
          Visible = False
          BandIndex = 0
          RowIndex = 0
        end
        object dxTreeListColumn1: TdxTreeListColumn
          Caption = #1053#1086#1084#1077#1088' '#1092#1086#1088#1084#1099
          Width = 47
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
        end
        object dxtN26HistoryColumn4: TdxTreeListDateColumn
          Caption = #1044#1072#1090#1072' '#1074#1099#1087#1080#1089#1082#1080
          Width = 57
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
        end
        object dxtN26HistoryColumn5: TdxTreeListDateColumn
          Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080
          Width = 63
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
        end
      end
      object edOrder: TEdit
        Left = 190
        Top = 43
        Width = 99
        Height = 21
        Color = clBtnFace
        MaxLength = 12
        ReadOnly = True
        TabOrder = 3
        OnChange = edFamChange
      end
      object dtOrder: TdxDateEdit
        Left = 387
        Top = 43
        Width = 100
        Enabled = False
        TabOrder = 6
        OnChange = edFamChange
        Date = -700000.000000000000000000
        SaveTime = False
      end
      object dtEndStudy: TdxDateEdit
        Left = 190
        Top = 64
        Width = 100
        TabOrder = 4
        OnChange = edFamChange
        Date = -700000.000000000000000000
        SaveTime = False
      end
      object PC1: TPageControl
        Left = 0
        Top = 214
        Width = 792
        Height = 154
        ActivePage = TabSheet8
        HotTrack = True
        MultiLine = True
        RaggedRight = True
        Style = tsFlatButtons
        TabOrder = 11
        object TabSheet9: TTabSheet
          Caption = 'C'#1074#1077#1076#1077#1085#1080#1103' '#1086' '#1074#1099#1087#1091#1089#1082#1085#1080#1082#1077
          ImageIndex = 3
          object Label109: TLabel
            Left = -1
            Top = 1
            Width = 171
            Height = 26
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1080#1089#1089#1077#1088#1090#1072#1094#1080#1086#1085#1085#1086#1081' / '#1076#1080#1087#1083#1086#1084#1085#1086#1081' '#1088#1072#1073#1086#1090#1099
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label111: TLabel
            Left = 0
            Top = 28
            Width = 170
            Height = 26
            AutoSize = False
            Caption = #1050#1086#1076' / '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label112: TLabel
            Left = 513
            Top = 28
            Width = 158
            Height = 26
            Caption = #1048#1089#1082#1086#1084#1072#1103' '#1091#1095#1077#1085#1072#1103' '#1089#1090#1077#1087#1077#1085#1100' / '#1091#1088#1086#1074#1077#1085#1100' '#1074#1099#1089#1096#1077#1075#1086' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label113: TLabel
            Left = -1
            Top = 54
            Width = 132
            Height = 26
            Caption = #1059#1095#1077#1085#1072#1103' '#1089#1090#1077#1087#1077#1085#1100' '#1085#1072#1091#1095#1085#1086#1075#1086' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
            WordWrap = True
          end
          object Label114: TLabel
            Left = 297
            Top = 62
            Width = 100
            Height = 13
            Caption = #1060#1048#1054' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label115: TLabel
            Left = -2
            Top = 86
            Width = 110
            Height = 13
            Caption = #1047#1072#1097#1080#1090#1072' '#1085#1072#1079#1085#1072#1095#1077#1085#1072' '#1085#1072
          end
          object Label116: TLabel
            Left = 287
            Top = 88
            Width = 101
            Height = 13
            Caption = #1047#1072#1097#1080#1090#1072' '#1089#1086#1089#1090#1086#1103#1083#1072#1089#1100
          end
          object Label124: TLabel
            Left = 363
            Top = 7
            Width = 75
            Height = 13
            Caption = #1050#1074#1072#1083#1080#1092#1080#1082#1072#1094#1080#1103
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object bKval4: TSpeedButton
            Left = 758
            Top = 3
            Width = 23
            Height = 22
            Caption = '...'
            OnClick = bKval1Click
          end
          object bNapr4: TSpeedButton
            Left = 473
            Top = 30
            Width = 23
            Height = 22
            Caption = '...'
            OnClick = bNapr1Click
          end
          object edDisserName: TEdit
            Left = 180
            Top = 3
            Width = 177
            Height = 21
            MaxLength = 100
            TabOrder = 0
            OnChange = edFamChange
          end
          object edFIOGuide: TEdit
            Left = 403
            Top = 60
            Width = 176
            Height = 21
            MaxLength = 60
            TabOrder = 4
            OnChange = edFamChange
          end
          object dtDefend: TdxDateEdit
            Left = 180
            Top = 84
            Width = 100
            TabOrder = 5
            OnChange = edFamChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object dtRealDefend: TdxDateEdit
            Left = 403
            Top = 84
            Width = 100
            TabOrder = 6
            OnChange = edFamChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object edDegree: TdxMRUEdit
            Left = 675
            Top = 30
            Width = 111
            TabOrder = 2
            MaxLength = 50
            Text = ''
            OnChange = edFamChange
            DropDownListStyle = True
            OnButtonClick = edKval3ButtonClick
            StoredValues = 2
          end
          object edGuideDegree: TdxMRUEdit
            Left = 180
            Top = 57
            Width = 111
            TabOrder = 3
            MaxLength = 50
            Text = ''
            OnChange = edFamChange
            DropDownListStyle = True
            OnButtonClick = edKval3ButtonClick
            StoredValues = 2
          end
          object edNapr4: TComboBox
            Left = 180
            Top = 30
            Width = 293
            Height = 21
            TabOrder = 7
            OnChange = edFamChange
          end
          object edKval4: TComboBox
            Left = 444
            Top = 3
            Width = 314
            Height = 21
            TabOrder = 1
            OnChange = edFamChange
          end
        end
        object TabSheet6: TTabSheet
          Caption = #1040#1082#1072#1076#1077#1084'. '#1086#1090#1087#1091#1089#1082
          object Label94: TLabel
            Left = 3
            Top = 3
            Width = 56
            Height = 13
            Caption = #8470' '#1087#1088#1080#1082#1072#1079#1072
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label95: TLabel
            Left = 167
            Top = 3
            Width = 68
            Height = 13
            Caption = #1076#1072#1090#1072' '#1087#1088#1080#1082#1072#1079#1072
          end
          object Label96: TLabel
            Left = 3
            Top = 27
            Width = 86
            Height = 13
            Caption = #1055#1088#1080#1095#1080#1085#1072' '#1086#1090#1087#1091#1089#1082#1072
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label98: TLabel
            Left = 3
            Top = 63
            Width = 40
            Height = 26
            Caption = #1085#1072#1095#1072#1083#1072' '#1086#1090#1087#1091#1089#1082#1072
            WordWrap = True
          end
          object Label97: TLabel
            Left = 152
            Top = 62
            Width = 95
            Height = 26
            Caption = #1076#1072#1090#1072' '#1086#1078#1080#1076#1072#1077#1084#1086#1075#1086' '#1074#1099#1093#1086#1076#1072' '#1080#1079' '#1086#1090#1087#1091#1089#1082#1072
            WordWrap = True
          end
          object Label99: TLabel
            Left = 359
            Top = 62
            Width = 97
            Height = 26
            Caption = #1076#1072#1090#1072' '#1092#1072#1082#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1074#1099#1093#1086#1076#1072' '#1080#1079' '#1086#1090#1087#1091#1089#1082#1072
            WordWrap = True
          end
          object Label100: TLabel
            Left = 3
            Top = 46
            Width = 37
            Height = 13
            Caption = #1044#1072#1090#1099':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            WordWrap = True
          end
          object Label117: TLabel
            Left = 3
            Top = 94
            Width = 121
            Height = 26
            Caption = #1076#1072#1090#1072' '#1087#1088#1086#1093#1086#1078#1076#1077#1085#1080#1103' '#1084#1077#1076#1082#1086#1084#1080#1089#1089#1080#1080' '#1087#1086#1089#1083#1077' '#1040#1054
            WordWrap = True
          end
          object Label118: TLabel
            Left = 252
            Top = 103
            Width = 125
            Height = 13
            Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1084#1077#1076#1082#1086#1084#1080#1089#1089#1080#1080
          end
          object edOrderAkadem: TEdit
            Left = 95
            Top = 0
            Width = 66
            Height = 21
            MaxLength = 12
            TabOrder = 0
            OnChange = edFamChange
            OnExit = edOrderAkademExit
          end
          object dtOrderAkadem: TdxDateEdit
            Left = 241
            Top = 0
            Width = 100
            TabOrder = 1
            OnExit = edOrderAkademExit
            OnChange = edFamChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object edReasonAkadem: TEdit
            Left = 95
            Top = 22
            Width = 245
            Height = 21
            MaxLength = 60
            TabOrder = 2
            OnChange = edFamChange
            OnExit = edOrderAkademExit
          end
          object dtBeginAkadem: TdxDateEdit
            Left = 46
            Top = 67
            Width = 100
            TabOrder = 3
            OnExit = edOrderAkademExit
            OnChange = edFamChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object dtEndAkadem: TdxDateEdit
            Left = 253
            Top = 67
            Width = 100
            TabOrder = 4
            OnExit = edOrderAkademExit
            OnChange = edFamChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object dtRealEndAkadem: TdxDateEdit
            Left = 461
            Top = 67
            Width = 100
            TabOrder = 5
            OnExit = edOrderAkademExit
            OnChange = edFamChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object dtMedResult: TdxDateEdit
            Left = 135
            Top = 99
            Width = 100
            TabOrder = 6
            OnExit = edOrderAkademExit
            OnChange = edFamChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object cbMedResult: TComboBox
            Left = 383
            Top = 99
            Width = 178
            Height = 21
            Style = csDropDownList
            TabOrder = 7
            OnChange = edFamChange
            OnExit = edOrderAkademExit
            Items.Strings = (
              '<'#1053#1077' '#1091#1082#1072#1079#1072#1085#1086'>'
              #1042#1086#1079#1086#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1086#1090#1089#1088#1086#1095#1082#1080
              #1057#1085#1103#1090#1080#1077' '#1089' '#1074#1086#1080#1085#1089#1082#1086#1075#1086' '#1091#1095#1077#1090#1072)
          end
        end
        object tbVK: TTabSheet
          Caption = #1054#1073#1091#1095#1077#1085#1080#1077' '#1085#1072' '#1074#1086#1077#1085'. '#1082#1072#1092'.'
          ImageIndex = 1
          object Label101: TLabel
            Left = 248
            Top = 3
            Width = 271
            Height = 13
            Caption = #1044#1072#1090#1099', '#1089#1074#1103#1079#1072#1085#1085#1099#1077' '#1089' '#1101#1090#1072#1087#1072#1084#1080' '#1086#1073#1091#1095#1077#1085#1080#1103' '#1085#1072' '#1042#1050':'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label102: TLabel
            Left = 248
            Top = 25
            Width = 35
            Height = 13
            Caption = #1085#1072#1095#1072#1083#1072
          end
          object Label103: TLabel
            Left = 249
            Top = 58
            Width = 109
            Height = 13
            Caption = #1087#1083#1072#1085#1086#1074#1086#1075#1086' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          end
          object Label104: TLabel
            Left = 249
            Top = 86
            Width = 158
            Height = 26
            Caption = #1092#1072#1082#1090#1080#1095'. '#1086#1082#1086#1085#1095#1072#1085#1080#1103' ('#1091#1089#1087#1077#1096#1085#1086#1075#1086' '#1080#1083#1080' '#1088#1072#1089#1090#1086#1088#1078#1077#1085#1080#1103' '#1082#1086#1085#1090#1088#1072#1082#1090#1072')'
            WordWrap = True
          end
          object Label119: TLabel
            Left = 3
            Top = 80
            Width = 171
            Height = 13
            Caption = #1055#1088#1080#1095#1080#1085#1072' '#1088#1072#1089#1090#1086#1088#1078#1077#1085#1080#1103' '#1082#1086#1085#1090#1088#1072#1082#1090#1072':'
          end
          object rbNone: TRadioButton
            Left = 3
            Top = 0
            Width = 152
            Height = 17
            Caption = #1082' '#1086#1073#1091#1095#1077#1085#1080#1102' '#1085#1077' '#1087#1088#1080#1089#1090#1091#1087#1072#1083
            Checked = True
            TabOrder = 0
            TabStop = True
            OnClick = WarChange
          end
          object rbInProcess: TRadioButton
            Left = 3
            Top = 20
            Width = 78
            Height = 17
            Caption = #1086#1073#1091#1095#1072#1077#1090#1089#1103
            TabOrder = 1
            OnClick = WarChange
          end
          object rbCompleted: TRadioButton
            Left = 3
            Top = 40
            Width = 117
            Height = 17
            Caption = #1091#1089#1087#1077#1096#1085#1086' '#1086#1082#1086#1085#1095#1080#1083
            TabOrder = 2
            OnClick = WarChange
          end
          object rbFailed: TRadioButton
            Left = 3
            Top = 60
            Width = 232
            Height = 17
            Caption = #1087#1088#1077#1088#1074#1072#1083' '#1086#1073#1091#1095#1077#1085#1080#1077', '#1088#1072#1089#1090#1086#1088#1075#1085#1091#1083' '#1082#1086#1085#1090#1088#1072#1082#1090
            TabOrder = 3
            OnClick = WarChange
          end
          object dtBeginWar: TdxDateEdit
            Left = 413
            Top = 22
            Width = 100
            TabOrder = 5
            OnChange = WarChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object dtEndWar: TdxDateEdit
            Left = 414
            Top = 56
            Width = 100
            TabOrder = 6
            OnChange = WarChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object dtRealEndWar: TdxDateEdit
            Left = 414
            Top = 92
            Width = 100
            TabOrder = 7
            OnChange = WarChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object edReasonEndWar: TEdit
            Left = 3
            Top = 99
            Width = 240
            Height = 21
            MaxLength = 100
            TabOrder = 4
            OnChange = WarChange
          end
        end
        object TabSheet8: TTabSheet
          Caption = #1054#1090#1095#1080#1089#1083#1077#1085#1080#1077' '#1080#1079' '#1080#1085#1089#1090#1080#1090#1091#1090#1072
          ImageIndex = 2
          object Label105: TLabel
            Left = 138
            Top = 8
            Width = 56
            Height = 13
            Caption = #8470' '#1087#1088#1080#1082#1072#1079#1072
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label106: TLabel
            Left = 268
            Top = 8
            Width = 68
            Height = 13
            Caption = #1076#1072#1090#1072' '#1087#1088#1080#1082#1072#1079#1072
          end
          object Label107: TLabel
            Left = 3
            Top = 30
            Width = 101
            Height = 13
            Caption = #1086#1089#1085#1086#1074#1072#1085#1080#1077', '#1087#1088#1080#1095#1080#1085#1072
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = []
            ParentFont = False
          end
          object Label108: TLabel
            Left = 3
            Top = 8
            Width = 23
            Height = 13
            Caption = #1076#1072#1090#1072
          end
          object edOrderDismissal: TEdit
            Left = 200
            Top = 3
            Width = 62
            Height = 21
            MaxLength = 12
            TabOrder = 1
            OnChange = edFamChange
          end
          object dtOrderDismissal: TdxDateEdit
            Left = 342
            Top = 3
            Width = 100
            TabOrder = 2
            OnChange = edFamChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
          object edReasonDismissal: TEdit
            Left = 3
            Top = 49
            Width = 428
            Height = 21
            MaxLength = 60
            TabOrder = 3
            OnChange = edFamChange
          end
          object dtDismissal: TdxDateEdit
            Left = 32
            Top = 3
            Width = 100
            TabOrder = 0
            OnChange = edFamChange
            Date = -700000.000000000000000000
            SaveTime = False
          end
        end
      end
      object edStudyForm: TEdit
        Left = 387
        Top = 23
        Width = 180
        Height = 21
        Color = clBtnFace
        MaxLength = 12
        ReadOnly = True
        TabOrder = 5
        OnChange = edFamChange
      end
      object edDocNumb: TEdit
        Left = 608
        Top = 23
        Width = 105
        Height = 21
        MaxLength = 20
        TabOrder = 7
        OnChange = edFamChange
      end
      object dtDocDate: TdxDateEdit
        Left = 608
        Top = 45
        Width = 105
        TabOrder = 8
        OnChange = edFamChange
        Date = -700000.000000000000000000
        SaveTime = False
      end
      object bNonStudent: TcxButton
        Left = 140
        Top = 2
        Width = 157
        Height = 19
        Caption = #1089#1085#1103#1090#1100' '#1086#1090#1084#1077#1090#1082#1091' '#1086#1073' '#1086#1073#1091#1095#1077#1085#1080#1080
        TabOrder = 12
        OnClick = bNonStudentClick
      end
    end
    object tabSheetX2: TTabSheet
      Caption = #1040#1057#1060' ('#1053#1040#1057#1060')'
      ImageIndex = 5
      DesignSize = (
        789
        375)
      object Label131: TLabel
        Left = 3
        Top = 226
        Width = 262
        Height = 13
        Caption = #1048#1084#1077#1077#1090' '#1086#1087#1099#1090' '#1074' '#1083#1080#1082#1074#1080#1076#1072#1094#1080#1080' '#1087#1086#1089#1083#1077#1076#1089#1090#1074#1080#1081' '#1063#1057':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label133: TLabel
        Left = 5
        Top = 167
        Width = 101
        Height = 13
        Caption = #1042#1099#1093#1086#1076' '#1080#1079' '#1053#1040#1057#1060':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label134: TLabel
        Left = 200
        Top = 167
        Width = 29
        Height = 13
        Caption = #1044#1072#1090#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label135: TLabel
        Left = 200
        Top = 194
        Width = 41
        Height = 13
        Caption = #1055#1088#1080#1082#1072#1079':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label136: TLabel
        Left = 255
        Top = 194
        Width = 11
        Height = 13
        Caption = #8470
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label137: TLabel
        Left = 427
        Top = 194
        Width = 11
        Height = 13
        Caption = #1086#1090
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label138: TLabel
        Left = 376
        Top = 116
        Width = 106
        Height = 13
        Caption = #1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077' '#1040#1057#1060
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label141: TLabel
        Left = 16
        Top = 116
        Width = 55
        Height = 13
        Caption = #1076#1086#1083#1078#1085#1086#1089#1090#1100
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label142: TLabel
        Left = 4
        Top = 92
        Width = 143
        Height = 13
        Caption = #1055#1086#1089#1083#1077#1076#1085#1077#1077' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1077':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label143: TLabel
        Left = 4
        Top = 68
        Width = 160
        Height = 13
        Caption = #1044#1072#1090#1072' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1103' '#1074' '#1053#1040#1057#1060':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel5: TBevel
        Left = 0
        Top = 48
        Width = 549
        Height = 9
        Shape = bsBottomLine
      end
      object Label145: TLabel
        Left = 3
        Top = 3
        Width = 181
        Height = 13
        Caption = #1055#1088#1080#1082#1072#1079' '#1086' '#1079#1072#1095#1080#1089#1083#1077#1085#1080#1080' '#1074' '#1053#1040#1057#1060
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label146: TLabel
        Left = 237
        Top = 29
        Width = 29
        Height = 13
        Caption = #1044#1072#1090#1072':'
      end
      object Label132: TLabel
        Left = 237
        Top = 3
        Width = 11
        Height = 13
        Caption = #8470
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label139: TLabel
        Left = 212
        Top = 116
        Width = 25
        Height = 13
        Caption = #1040#1057#1060
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label151: TLabel
        Left = 556
        Top = 232
        Width = 157
        Height = 13
        Caption = #1057#1087#1086#1088#1090#1080#1074#1085#1099#1077' '#1088#1072#1079#1088#1103#1076#1099' '#1080' '#1079#1074#1072#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dxtASAssign: TdxTreeList
        Left = 3
        Top = 245
        Width = 530
        Height = 117
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        Enabled = False
        PopupMenu = psASAssing
        TabOrder = 0
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoAutoWidth, aoCaseInsensitive]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoRowSizing]
        TreeLineColor = clGrayText
        ShowRoot = False
        ShowIndicator = True
        OnEdited = dxtAssignEdited
        object dxTreeListDateColumn1: TdxTreeListDateColumn
          Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
          Width = 76
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          DateButtons = [btnToday]
          SaveTime = False
        end
        object dxTreeList1Column4: TdxTreeListDateColumn
          Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
          Width = 91
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          DateButtons = [btnToday]
          SaveTime = False
        end
        object dxtASAssignWhere: TdxTreeListMRUColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1063#1057
          Width = 185
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          ShowEllipsis = False
        end
        object dxtASAssignWhat: TdxTreeListMRUColumn
          Caption = #1063#1090#1086' '#1076#1077#1083#1072#1083
          Width = 164
          BandIndex = 0
          RowIndex = 0
          OnChange = edFamChange
          ShowEllipsis = False
        end
      end
      object dtASOut_Date: TdxDateEdit
        Left = 280
        Top = 164
        Width = 87
        TabOrder = 1
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object edASOut_ORD_NUMB: TEdit
        Left = 280
        Top = 191
        Width = 131
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 50
        ParentFont = False
        TabOrder = 2
        OnChange = edFamChange
      end
      object dtASOut_ORD_Date: TdxDateEdit
        Left = 444
        Top = 191
        Width = 92
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edFamChange
        Date = -700000.000000000000000000
        DateOnError = deToday
      end
      object stASPost: TEdit
        Left = 16
        Top = 132
        Width = 190
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 4
      end
      object stASDepart: TEdit
        Left = 376
        Top = 132
        Width = 156
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 5
      end
      object stASInDate: TEdit
        Left = 170
        Top = 63
        Width = 101
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 6
      end
      object btnASAppointments: TButton
        Left = 282
        Top = 62
        Width = 123
        Height = 21
        Caption = #1042#1089#1077' '#1085#1072#1079#1085#1072#1095#1077#1085#1080#1103'...'
        TabOrder = 7
        OnClick = btnASAppointmentsClick
      end
      object dtASOrder_Date: TdxDateEdit
        Left = 284
        Top = 24
        Width = 105
        TabOrder = 8
        Date = -700000.000000000000000000
        SaveTime = False
      end
      object edASOrder_In: TEdit
        Left = 284
        Top = 0
        Width = 105
        Height = 21
        MaxLength = 20
        TabOrder = 9
        OnChange = edFamChange
      end
      object stASF: TEdit
        Left = 212
        Top = 132
        Width = 156
        Height = 21
        TabStop = False
        ParentColor = True
        ReadOnly = True
        TabOrder = 10
      end
      object GroupBox4: TGroupBox
        Left = 555
        Top = 1
        Width = 231
        Height = 109
        Anchors = [akLeft, akTop, akRight]
        Caption = #1055#1086#1089#1083#1077#1076#1085#1080#1081' '#1084#1077#1076#1086#1089#1084#1086#1090#1088
        TabOrder = 11
        DesignSize = (
          231
          109)
        object Label140: TLabel
          Left = 8
          Top = 20
          Width = 18
          Height = 13
          Caption = #1043#1076#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label144: TLabel
          Left = 8
          Top = 66
          Width = 52
          Height = 13
          Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label147: TLabel
          Left = 8
          Top = 47
          Width = 30
          Height = 13
          Caption = #1050#1086#1075#1076#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edMed_Where: TEdit
          Left = 52
          Top = 18
          Width = 165
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 50
          ParentFont = False
          TabOrder = 0
          OnChange = edFamChange
        end
        object edMed_Result: TEdit
          Left = 8
          Top = 79
          Width = 209
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 50
          ParentFont = False
          TabOrder = 2
          OnChange = edFamChange
        end
        object edMed_Date: TdxDateEdit
          Left = 128
          Top = 44
          Width = 89
          TabOrder = 1
          Anchors = [akTop, akRight]
          OnChange = edFamChange
          Date = -700000.000000000000000000
          DateOnError = deToday
        end
      end
      object GroupBox5: TGroupBox
        Left = 555
        Top = 116
        Width = 231
        Height = 109
        Anchors = [akLeft, akTop, akRight]
        Caption = #1055#1086#1089#1083#1077#1076#1085#1077#1077' '#1087#1089#1080#1093#1080#1072#1090#1088#1080#1095'. '#1086#1089#1074#1080#1076'.'
        TabOrder = 12
        DesignSize = (
          231
          109)
        object Label148: TLabel
          Left = 8
          Top = 20
          Width = 18
          Height = 13
          Caption = #1043#1076#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label149: TLabel
          Left = 8
          Top = 66
          Width = 52
          Height = 13
          Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label150: TLabel
          Left = 8
          Top = 47
          Width = 30
          Height = 13
          Caption = #1050#1086#1075#1076#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object edPsy_Where: TEdit
          Left = 52
          Top = 18
          Width = 165
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 50
          ParentFont = False
          TabOrder = 0
          OnChange = edFamChange
        end
        object edPsy_Result: TEdit
          Left = 8
          Top = 79
          Width = 209
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          MaxLength = 50
          ParentFont = False
          TabOrder = 2
          OnChange = edFamChange
        end
        object edPsy_Date: TdxDateEdit
          Left = 128
          Top = 44
          Width = 89
          TabOrder = 1
          Anchors = [akTop, akRight]
          OnChange = edFamChange
          Date = -700000.000000000000000000
          DateOnError = deToday
        end
      end
      object edAsf_Sport: TEdit
        Left = 556
        Top = 245
        Width = 227
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 50
        ParentFont = False
        TabOrder = 13
        OnChange = edFamChange
      end
    end
  end
  object btnOk: TButton
    Left = 559
    Top = 467
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 9
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 639
    Top = 467
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 10
    OnClick = btnCancelClick
  end
  object btnApply: TButton
    Left = 719
    Top = 467
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 11
    OnClick = btnApplyClick
  end
  object dtBirth: TdxDateEdit
    Left = 148
    Top = 28
    Width = 85
    TabOrder = 5
    OnChange = edFamChange
    Date = -700000.000000000000000000
    SaveTime = False
  end
  object edFam: TEdit
    Left = 72
    Top = 4
    Width = 121
    Height = 21
    MaxLength = 50
    TabOrder = 0
    OnChange = edFamChange
  end
  object edIm: TEdit
    Left = 236
    Top = 4
    Width = 65
    Height = 21
    MaxLength = 50
    TabOrder = 1
    OnChange = edFamChange
  end
  object edOtch: TEdit
    Left = 368
    Top = 4
    Width = 93
    Height = 21
    MaxLength = 50
    TabOrder = 2
    OnChange = edFamChange
  end
  object edBirth: TEdit
    Left = 236
    Top = 28
    Width = 205
    Height = 21
    MaxLength = 100
    TabOrder = 6
    OnChange = edFamChange
  end
  object rbMale: TRadioButton
    Left = 504
    Top = 6
    Width = 33
    Height = 17
    Caption = #1084
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = edFamChange
  end
  object rbFemale: TRadioButton
    Left = 544
    Top = 6
    Width = 33
    Height = 17
    Caption = #1078
    TabOrder = 4
    OnClick = edFamChange
  end
  object dtConf: TdxDateEdit
    Left = 216
    Top = 469
    Width = 101
    TabOrder = 12
    Anchors = [akLeft, akBottom]
    OnChange = edFamChange
    Date = -700000.000000000000000000
    DateOnError = deToday
    DateValidation = True
    SaveTime = False
  end
  object edOKATO: TEdit
    Left = 500
    Top = 28
    Width = 77
    Height = 21
    MaxLength = 11
    TabOrder = 7
    Visible = False
    OnChange = edFamChange
    OnKeyPress = edOKATOKeyPress
  end
  object pmLang: TPopupMenu
    Left = 216
    Top = 11
    object N7: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = N7Click
    end
    object N8: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnClick = N8Click
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
  object qrWRange: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM KWRANGE ORDER BY WRNG_ID')
    Left = 759
    Top = 254
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    Parameters = <
      item
        Name = 'ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM Person'
      'WHERE PERS_ID=:ID')
    Left = 399
    Top = 15
  end
  object qrAddr: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM ADDR WHERE PERS_ID=:PERS_ID')
    Left = 604
    Top = 159
  end
  object dsData: TDataSource
    DataSet = qrData
    OnDataChange = dsDataDataChange
    Left = 434
    Top = 12
  end
  object qrPhones: TADOQuery
    Connection = dmMain.dbMain
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM PHONES'
      'WHERE PERS_ID=:PERS_ID')
    Left = 308
    Top = 11
  end
  object qrLangs: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM LANGS WHERE PERS_ID=:PERS_ID')
    Left = 633
    Top = 169
  end
  object qrFam: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM FAMILY WHERE PERS_ID=:PERS_ID')
    Left = 260
    Top = 11
  end
  object qrEduc: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM EDUC WHERE PERS_ID=:PERS_ID')
    Left = 356
    Top = 14
  end
  object qrStudyHistory: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM Appointment'
      'WHERE PERS_ID=:PERS_ID AND'
      'POST_ID IN (SELECT POST_ID FROM KPOST '
      'WHERE CPROF_ID = 500 or CPROF2015_ID = 500)')
    Left = 111
    Top = 235
  end
  object qrN26History: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM N26HISTORY WHERE PERS_ID=:PERS_ID')
    Left = 703
    Top = 287
  end
  object pmStudyHistory: TPopupMenu
    Left = 514
    Top = 327
    object MenuItem3: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = MenuItem3Click
    end
    object MenuItem4: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnClick = MenuItem4Click
    end
  end
  object pmN26History: TPopupMenu
    Left = 570
    Top = 323
    object MenuItem5: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = MenuItem5Click
    end
    object MenuItem6: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnClick = MenuItem6Click
    end
    object N1: TMenuItem
      Action = aPrintForm26
    end
  end
  object ActionList1: TActionList
    Left = 47
    Top = 14
    object aPrintForm26: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
      ShortCut = 16464
      OnExecute = aPrintForm26Execute
      OnUpdate = aPrintForm26Update
    end
  end
  object qrChanges: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM PERSONCHANGES'
      'WHERE PERS_ID=:PERS_ID AND '
      
        '(Begin_Date is not null or (NotBeginReason is not null and NotBe' +
        'ginReason <> '#39#39'))')
    Left = 660
    Top = 11
    object qrChangesCHANGE_ID: TAutoIncField
      FieldName = 'CHANGE_ID'
      ReadOnly = True
    end
    object qrChangesPERS_ID: TIntegerField
      FieldName = 'PERS_ID'
    end
    object qrChangesGROUP_ID: TIntegerField
      FieldName = 'GROUP_ID'
    end
    object qrChangesOLDVALUE: TWideMemoField
      FieldName = 'OLDVALUE'
      BlobType = ftWideMemo
    end
    object qrChangesNEWVALUE: TWideMemoField
      FieldName = 'NEWVALUE'
      BlobType = ftWideMemo
    end
    object qrChangesCHANGE_DATE: TDateTimeField
      FieldName = 'CHANGE_DATE'
    end
    object qrChangesBEGIN_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1074#1088#1091#1095#1077#1085#1080#1103' '#1083#1080#1089#1090#1082#1072
      FieldName = 'BEGIN_DATE'
    end
    object qrChangesNOTBEGINREASON: TWideStringField
      DisplayLabel = #1055#1088#1080#1095#1080#1085#1072' '#1085#1077#1074#1088#1091#1095#1077#1085#1080#1103
      FieldName = 'NOTBEGINREASON'
      Size = 255
    end
    object qrChangesEND_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1076#1086#1089#1090#1072#1074#1082#1080' '#1083#1080#1089#1090#1082#1072' '#1074' '#1054#1042#1050
      FieldName = 'END_DATE'
    end
    object qrChangesSEND_DATE: TDateTimeField
      DisplayLabel = #1044#1072#1090#1072' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1089#1074#1077#1076#1077#1085#1080#1081' '#1074' '#1054#1042#1050
      FieldName = 'SEND_DATE'
    end
    object qrChangesOutNumber: TWideStringField
      FieldName = 'OutNumber'
      Size = 255
    end
    object qrChangesOutDate: TDateTimeField
      FieldName = 'OutDate'
    end
    object qrChangesAppointment_Id: TIntegerField
      FieldName = 'Appointment_Id'
    end
  end
  object qrAssign: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM ASSIGN WHERE PERS_ID=:PERS_ID')
    Left = 476
    Top = 19
  end
  object pmAssign: TPopupMenu
    Left = 536
    Top = 327
    object MenuItem7: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = MenuItem7Click
    end
    object MenuItem8: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnClick = MenuItem8Click
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = qrChanges
    Left = 696
    Top = 12
  end
  object psASAssing: TPopupMenu
    Left = 360
    Top = 79
    object MenuItem9: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      ShortCut = 45
      OnClick = MenuItem9Click
    end
    object MenuItem10: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      ShortCut = 16430
      OnClick = MenuItem10Click
    end
  end
  object qrASAssign: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM ASASSIGN WHERE PERS_ID=:PERS_ID')
    Left = 204
    Top = 243
  end
  object qrPersDeps: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
    Parameters = <
      item
        Name = 'PERS_ID'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM Pers_Deps WHERE PERS_ID=:PERS_ID')
    Left = 633
    Top = 121
  end
end

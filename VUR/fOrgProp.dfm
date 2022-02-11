object fmOrgProp: TfmOrgProp
  Left = 321
  Top = 212
  HelpContext = 8
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1091#1095#1105#1090#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
  ClientHeight = 502
  ClientWidth = 709
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object dxtOKATO: TdxTreeList
    Left = 720
    Top = 20
    Width = 373
    Height = 201
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    PopupMenu = pmOKATO
    TabOrder = 1
    Visible = False
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoTabThrough, aoRowSelect]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoDragScroll, aoDragExpand, aoRowSizing]
    TreeLineColor = clGrayText
    ShowGrid = True
    OnDblClick = dxtOKATODblClick
    object dxtOKATOCode: TdxTreeListColumn
      Caption = #1050#1086#1076
      BandIndex = 0
      RowIndex = 0
    end
    object dxtOKATONameTerr: TdxTreeListColumn
      Caption = #1058#1077#1088#1088#1080#1090#1086#1088#1080#1103
      Width = 255
      BandIndex = 0
      RowIndex = 0
    end
  end
  object dxtKTerr: TdxTreeList
    Left = 720
    Top = 192
    Width = 373
    Height = 201
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    PopupMenu = pmTerr
    TabOrder = 0
    Visible = False
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoTabThrough, aoRowSelect]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoDragScroll, aoDragExpand, aoRowSizing]
    TreeLineColor = clGrayText
    ShowGrid = True
    OnDblClick = dxtKTerrDblClick
    object dxtKTerrCode: TdxTreeListColumn
      Caption = #1050#1086#1076
      BandIndex = 0
      RowIndex = 0
    end
    object dxtKTerrName: TdxTreeListColumn
      Caption = #1054#1073#1083#1072#1089#1090#1100' '#1082#1091#1088#1080#1088#1086#1074#1072#1085#1080#1103
      Width = 255
      BandIndex = 0
      RowIndex = 0
    end
  end
  object dxtOKTMO: TdxTreeList
    Left = 720
    Top = 132
    Width = 373
    Height = 201
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    PopupMenu = pmOKTMO
    TabOrder = 2
    Visible = False
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoTabThrough, aoRowSelect]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoDragScroll, aoDragExpand, aoRowSizing]
    TreeLineColor = clGrayText
    ShowGrid = True
    OnDblClick = dxtOKATODblClick
    object dxtOKTMOCode: TdxTreeListColumn
      Caption = #1050#1086#1076
      BandIndex = 0
      RowIndex = 0
    end
    object dxtOKTMOName: TdxTreeListColumn
      Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
      Width = 255
      BandIndex = 0
      RowIndex = 0
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 709
    Height = 461
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = #1042#1059#1056
      object Label1: TLabel
        Left = 12
        Top = 24
        Width = 79
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      end
      object Label2: TLabel
        Left = 319
        Top = 28
        Width = 32
        Height = 13
        Caption = #1054#1043#1056#1053':'
      end
      object Label3: TLabel
        Left = 319
        Top = 52
        Width = 96
        Height = 13
        Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080':'
      end
      object Label4: TLabel
        Left = 319
        Top = 76
        Width = 102
        Height = 13
        Caption = #1052#1077#1089#1090#1086' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080':'
      end
      object Label5: TLabel
        Left = 470
        Top = 28
        Width = 55
        Height = 13
        Caption = #1048#1053#1053'/'#1050#1055#1055':'
      end
      object Label6: TLabel
        Left = 542
        Top = 52
        Width = 34
        Height = 13
        Caption = #1054#1050#1055#1054':'
      end
      object Label7: TLabel
        Left = 381
        Top = 100
        Width = 40
        Height = 13
        Caption = #1054#1050#1040#1058#1054':'
      end
      object Label8: TLabel
        Left = 12
        Top = 100
        Width = 54
        Height = 13
        Caption = #1070#1088'. '#1072#1076#1088#1077#1089':'
      end
      object Label9: TLabel
        Left = 12
        Top = 200
        Width = 94
        Height = 13
        Caption = #1054#1089#1085#1086#1074#1085#1086#1081' '#1054#1050#1042#1069#1044':'
      end
      object Label11: TLabel
        Left = 12
        Top = 224
        Width = 76
        Height = 13
        Caption = #1044#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1100':'
      end
      object Bevel3: TBevel
        Left = 152
        Top = 244
        Width = 537
        Height = 9
        Shape = bsTopLine
      end
      object Label12: TLabel
        Left = 12
        Top = 260
        Width = 49
        Height = 13
        Caption = #8470' '#1074' '#1042#1059#1054':'
      end
      object Label13: TLabel
        Left = 188
        Top = 260
        Width = 131
        Height = 13
        Caption = #1044#1072#1090#1072' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080' '#1074' '#1042#1059#1054':'
      end
      object Label14: TLabel
        Left = 436
        Top = 260
        Width = 145
        Height = 13
        Caption = #1044#1072#1090#1072' '#1087#1088#1077#1076#1089#1090#1072#1074#1083#1077#1085#1080#1103' '#1086#1090#1095#1105#1090#1072':'
      end
      object Label18: TLabel
        Left = 12
        Top = 308
        Width = 97
        Height = 13
        Caption = #1064#1080#1092#1088' '#1060#1086#1088#1084#1099' '#8470' 6:'
      end
      object Label19: TLabel
        Left = 180
        Top = 307
        Width = 90
        Height = 13
        Caption = #1042' '#1089#1092#1077#1088#1077' '#1074#1077#1076#1077#1085#1080#1103':'
      end
      object Label20: TLabel
        Left = 12
        Top = 332
        Width = 150
        Height = 13
        Caption = #1042#1099#1096#1077#1089#1090#1086#1103#1097#1080#1081' '#1042#1059#1054' '#1082#1091#1088#1080#1088#1091#1077#1090':'
      end
      object Bevel4: TBevel
        Left = 172
        Top = 352
        Width = 517
        Height = 9
        Shape = bsTopLine
      end
      object Label24: TLabel
        Left = 12
        Top = 160
        Width = 25
        Height = 13
        Caption = #1042#1059#1056':'
      end
      object Label25: TLabel
        Left = 384
        Top = 160
        Width = 23
        Height = 13
        Caption = #1090#1077#1083'.:'
      end
      object Label26: TLabel
        Left = 356
        Top = 200
        Width = 36
        Height = 13
        Caption = #1054#1050#1060#1057':'
      end
      object Label27: TLabel
        Left = 356
        Top = 224
        Width = 45
        Height = 13
        Caption = #1054#1050#1054#1055#1060':'
      end
      object Label28: TLabel
        Left = 228
        Top = 200
        Width = 40
        Height = 13
        Caption = #1054#1050#1054#1043#1059':'
      end
      object Label17: TLabel
        Left = 12
        Top = 408
        Width = 92
        Height = 13
        Caption = #1044#1072#1090#1072' '#1079#1072#1087#1086#1083#1085#1077#1085#1080#1103':'
      end
      object Bevel2: TBevel
        Left = 168
        Top = 188
        Width = 521
        Height = 5
        Shape = bsTopLine
      end
      object Bevel5: TBevel
        Left = 116
        Top = 148
        Width = 577
        Height = 5
        Shape = bsTopLine
      end
      object Label16: TLabel
        Left = 8
        Top = 144
        Width = 104
        Height = 13
        Caption = #1050#1086#1085#1090#1072#1082#1090#1085#1099#1077' '#1083#1080#1094#1072
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 8
        Top = 184
        Width = 160
        Height = 13
        Caption = #1054#1089#1085#1086#1074#1085#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label22: TLabel
        Left = 8
        Top = 240
        Width = 144
        Height = 13
        Caption = #1042#1086#1077#1085#1085#1086'-'#1091#1095#1077#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 8
        Top = 348
        Width = 163
        Height = 13
        Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1099#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label29: TLabel
        Left = 12
        Top = 364
        Width = 56
        Height = 13
        Caption = #1055#1088#1080#1079#1085#1072#1082' 1:'
      end
      object Label30: TLabel
        Left = 237
        Top = 364
        Width = 56
        Height = 13
        Caption = #1055#1088#1080#1079#1085#1072#1082' 2:'
      end
      object Label31: TLabel
        Left = 463
        Top = 364
        Width = 56
        Height = 13
        Caption = #1055#1088#1080#1079#1085#1072#1082' 3:'
      end
      object Label54: TLabel
        Left = 396
        Top = 284
        Width = 25
        Height = 13
        Caption = #1054#1042#1050':'
      end
      object Label10: TLabel
        Left = 534
        Top = 100
        Width = 42
        Height = 13
        Caption = #1054#1050#1058#1052#1054':'
      end
      object Label32: TLabel
        Left = 534
        Top = 125
        Width = 42
        Height = 13
        Caption = #1054#1050#1058#1052#1054':'
      end
      object Label33: TLabel
        Left = 381
        Top = 125
        Width = 40
        Height = 13
        Caption = #1054#1050#1040#1058#1054':'
      end
      object Label34: TLabel
        Left = 12
        Top = 125
        Width = 67
        Height = 13
        Caption = #1060#1072#1082#1090'. '#1072#1076#1088#1077#1089':'
      end
      object Bevel1: TBevel
        Left = 112
        Top = 5
        Width = 577
        Height = 5
        Shape = bsTopLine
      end
      object Label37: TLabel
        Left = 8
        Top = 3
        Width = 101
        Height = 13
        Caption = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mmName: TMemo
        Left = 12
        Top = 40
        Width = 293
        Height = 49
        MaxLength = 4096
        ScrollBars = ssVertical
        TabOrder = 0
        OnChange = mmNameChange
      end
      object edRegNum: TEdit
        Left = 357
        Top = 24
        Width = 101
        Height = 21
        MaxLength = 20
        TabOrder = 1
        OnChange = mmNameChange
      end
      object dtRegDate: TdxDateEdit
        Left = 427
        Top = 48
        Width = 101
        TabOrder = 2
        OnChange = mmNameChange
        Date = -700000.000000000000000000
      end
      object edINN: TEdit
        Left = 531
        Top = 24
        Width = 150
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 50
        TabOrder = 3
        OnChange = mmNameChange
      end
      object edOKPO: TEdit
        Left = 581
        Top = 48
        Width = 100
        Height = 21
        MaxLength = 8
        TabOrder = 4
        OnChange = mmNameChange
        OnKeyPress = edOKPOKeyPress
      end
      object btnShowCommon: TButton
        Left = 194
        Top = 16
        Width = 111
        Height = 21
        Caption = #1055#1086#1083#1085#1086#1089#1090#1100#1102'...'
        TabOrder = 5
        OnClick = btnShowCommonClick
      end
      object cbOKATO1: TdxPopupEdit
        Left = 427
        Top = 96
        Width = 101
        TabOrder = 6
        OnKeyPress = edOKPOKeyPress
        MaxLength = 11
        Text = ''
        OnChange = mmNameChange
        PopupControl = dxtOKATO
        PopupFormBorderStyle = pbsSimple
        PopupClientEdge = True
        OnCloseUp = cbOKATO1CloseUp
        OnPopup = cbOKATO1Popup
        StoredValues = 2
      end
      object edUAddr: TEdit
        Left = 80
        Top = 96
        Width = 277
        Height = 21
        MaxLength = 250
        TabOrder = 7
        OnChange = mmNameChange
      end
      object btnShowContacts: TButton
        Left = 572
        Top = 156
        Width = 111
        Height = 21
        Caption = #1055#1086#1083#1085#1086#1089#1090#1100#1102'...'
        TabOrder = 8
        OnClick = btnShowContactsClick
      end
      object edOKONH: TEdit
        Left = 112
        Top = 196
        Width = 81
        Height = 21
        MaxLength = 15
        TabOrder = 9
        OnChange = mmNameChange
        OnKeyPress = edOKONHKeyPress
      end
      object edOCCUPATION: TEdit
        Left = 100
        Top = 220
        Width = 241
        Height = 21
        MaxLength = 150
        TabOrder = 10
        OnChange = mmNameChange
      end
      object edOKBV: TEdit
        Left = 64
        Top = 256
        Width = 97
        Height = 21
        TabOrder = 11
        OnChange = mmNameChange
      end
      object dtFirst: TdxDateEdit
        Left = 320
        Top = 256
        Width = 101
        TabOrder = 12
        OnChange = mmNameChange
        Date = -700000.000000000000000000
      end
      object dtLast: TdxDateEdit
        Left = 584
        Top = 256
        Width = 101
        TabOrder = 13
        OnChange = mmNameChange
        Date = -700000.000000000000000000
      end
      object chkHasBron: TCheckBox
        Left = 12
        Top = 284
        Width = 149
        Height = 17
        Caption = #1042#1077#1076#1077#1090' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077
        TabOrder = 14
        OnClick = chkHasBronClick
      end
      object cbForm6Shifr: TdxPickEdit
        Left = 112
        Top = 304
        Width = 49
        TabOrder = 15
        OnExit = cbKONHExit
        Alignment = taCenter
        Text = ''
        OnChange = mmNameChange
        Items.Strings = (
          '01'
          '02'
          '03'
          '04'
          '05'
          '06')
        StoredValues = 1
      end
      object edVUR: TEdit
        Left = 80
        Top = 156
        Width = 277
        Height = 21
        MaxLength = 100
        TabOrder = 18
        OnChange = mmNameChange
      end
      object edPhone: TEdit
        Left = 416
        Top = 156
        Width = 137
        Height = 21
        MaxLength = 50
        TabOrder = 19
        OnChange = mmNameChange
      end
      object cbOKFS: TdxPickEdit
        Left = 415
        Top = 196
        Width = 269
        TabOrder = 20
        OnExit = cbKONHExit
        ReadOnly = False
        Text = ''
        OnChange = cbOKFSChange
        DropDownRows = 20
        StoredValues = 64
      end
      object cbOKOPF: TdxPickEdit
        Left = 416
        Top = 220
        Width = 269
        TabOrder = 21
        OnExit = cbKONHExit
        ReadOnly = False
        Text = ''
        OnChange = mmNameChange
        DropDownRows = 20
        StoredValues = 64
      end
      object edOKOGU: TEdit
        Left = 276
        Top = 196
        Width = 65
        Height = 21
        MaxLength = 7
        TabOrder = 22
        OnChange = mmNameChange
      end
      object btnShowOKONH: TButton
        Left = 194
        Top = 196
        Width = 22
        Height = 22
        Caption = '...'
        TabOrder = 23
        OnClick = btnShowOKONHClick
      end
      object btnPerList: TButton
        Left = 280
        Top = 280
        Width = 109
        Height = 21
        Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1103'...'
        TabOrder = 24
        OnClick = btnPerListClick
      end
      object dtConf: TdxDateEdit
        Left = 132
        Top = 404
        Width = 101
        TabOrder = 25
        OnChange = mmNameChange
        Date = -700000.000000000000000000
      end
      object btnForm6: TButton
        Left = 463
        Top = 404
        Width = 221
        Height = 21
        Caption = #1056#1072#1089#1095#1077#1090#1085#1072#1103' '#1095#1080#1089#1083#1077#1085#1085#1086#1089#1090#1100' '#1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084
        TabOrder = 26
        Visible = False
        OnClick = btnForm6Click
      end
      object cbKTerr: TdxPopupEdit
        Left = 168
        Top = 328
        Width = 517
        TabOrder = 27
        OnExit = cbKTerrExit
        MaxLength = 11
        Text = ''
        OnChange = mmNameChange
        PopupControl = dxtKTerr
        PopupFormBorderStyle = pbsSimple
        PopupClientEdge = True
        OnCloseUp = cbKTerrCloseUp
        OnPopup = cbKTerrPopup
        StoredValues = 2
      end
      object btnBronDol: TButton
        Left = 164
        Top = 280
        Width = 109
        Height = 21
        Caption = #1042#1099#1087#1080#1089#1082#1072' '#1080#1079' '#1055#1044#1055'...'
        TabOrder = 28
        OnClick = btnBronDolClick
      end
      object edFeature1: TEdit
        Left = 12
        Top = 380
        Width = 221
        Height = 21
        MaxLength = 30
        TabOrder = 29
        OnChange = mmNameChange
      end
      object edFeature2: TEdit
        Left = 236
        Top = 380
        Width = 221
        Height = 21
        MaxLength = 30
        TabOrder = 30
        OnChange = mmNameChange
      end
      object edFeature3: TEdit
        Left = 464
        Top = 380
        Width = 221
        Height = 21
        MaxLength = 30
        TabOrder = 31
        OnChange = mmNameChange
      end
      object dxpOVK: TdxMRUEdit
        Left = 424
        Top = 280
        Width = 261
        TabOrder = 32
        MaxLength = 50
        Text = ''
        OnChange = mmNameChange
        DropDownRows = 20
        DropDownListStyle = True
        OnButtonClick = dxpOVKButtonClick
        StoredValues = 2
      end
      object btnVUZOnly: TButton
        Left = 464
        Top = 404
        Width = 221
        Height = 21
        Caption = #1058#1086#1083#1100#1082#1086' '#1076#1083#1103' '#1042#1059#1047#1086#1074
        TabOrder = 33
        OnClick = btnVUZOnlyClick
      end
      object cbOKTMO: TdxPopupEdit
        Left = 581
        Top = 96
        Width = 100
        TabOrder = 34
        OnKeyPress = edOKPOKeyPress
        MaxLength = 11
        Text = ''
        OnChange = mmNameChange
        PopupControl = dxtOKTMO
        PopupFormBorderStyle = pbsSimple
        PopupClientEdge = True
        OnCloseUp = cbOKATO1CloseUp
        OnPopup = cbOKATO1Popup
        StoredValues = 2
      end
      object cbOKTMO2: TdxPopupEdit
        Left = 581
        Top = 121
        Width = 100
        TabOrder = 35
        OnKeyPress = edOKPOKeyPress
        MaxLength = 11
        Text = ''
        OnChange = mmNameChange
        PopupControl = dxtOKTMO
        PopupFormBorderStyle = pbsSimple
        PopupClientEdge = True
        OnCloseUp = cbOKATO1CloseUp
        OnPopup = cbOKATO1Popup
        StoredValues = 2
      end
      object cbOKATO2: TdxPopupEdit
        Left = 427
        Top = 121
        Width = 101
        TabOrder = 36
        OnKeyPress = edOKPOKeyPress
        MaxLength = 11
        Text = ''
        OnChange = mmNameChange
        PopupControl = dxtOKATO
        PopupFormBorderStyle = pbsSimple
        PopupClientEdge = True
        OnCloseUp = cbOKATO1CloseUp
        OnPopup = cbOKATO1Popup
        StoredValues = 2
      end
      object edFAddr: TEdit
        Left = 80
        Top = 121
        Width = 277
        Height = 21
        MaxLength = 250
        TabOrder = 37
        OnChange = mmNameChange
      end
      object eRegplace: TEdit
        Left = 427
        Top = 71
        Width = 254
        Height = 21
        TabOrder = 38
        OnChange = mmNameChange
      end
      object eSBM: TEdit
        Left = 276
        Top = 304
        Width = 277
        Height = 21
        TabOrder = 16
        OnChange = mmNameChange
      end
      object bVoenkom: TButton
        Left = 572
        Top = 304
        Width = 111
        Height = 21
        Caption = #1042#1086#1077#1085#1082#1086#1084'...'
        TabOrder = 17
        OnClick = bVoenkomClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1043#1054#1063#1057
      ImageIndex = 1
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 701
        Height = 165
        Align = alTop
        TabOrder = 0
        DesignSize = (
          701
          165)
        object Label15: TLabel
          Left = 10
          Top = 38
          Width = 159
          Height = 13
          Caption = #1054#1089#1085#1086#1074#1072#1085#1080#1077' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1040#1057#1060':'
        end
        object Label35: TLabel
          Left = 10
          Top = 82
          Width = 52
          Height = 13
          Caption = #1060#1072#1084#1080#1083#1080#1103':'
        end
        object Label36: TLabel
          Left = 10
          Top = 106
          Width = 25
          Height = 13
          Caption = #1048#1084#1103':'
        end
        object Label38: TLabel
          Left = 10
          Top = 130
          Width = 50
          Height = 13
          Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
        end
        object Label39: TLabel
          Left = 242
          Top = 106
          Width = 48
          Height = 13
          Caption = #1058#1077#1083#1077#1092#1086#1085':'
        end
        object Label40: TLabel
          Left = 242
          Top = 130
          Width = 61
          Height = 13
          Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
        end
        object Label41: TLabel
          Left = 10
          Top = 61
          Width = 251
          Height = 13
          Caption = #1056#1072#1073#1086#1090#1085#1080#1082', '#1091#1087#1086#1083#1085#1086#1084#1086#1095#1077#1085#1085#1099#1081' '#1085#1072' '#1088#1077#1096#1077#1085#1080#1077' '#1079#1072#1076#1072#1095' '#1043#1054
        end
        object Bevel6: TBevel
          Left = 267
          Top = 68
          Width = 409
          Height = 9
          Shape = bsTopLine
        end
        object Label42: TLabel
          Left = 10
          Top = 12
          Width = 197
          Height = 13
          Caption = #1053#1072#1083#1080#1095#1080#1077' '#1089#1087#1072#1089#1072#1090#1077#1083#1100#1085#1099#1093' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1081
        end
        object cbASFGround: TdxPickEdit
          Left = 220
          Top = 34
          Width = 466
          TabOrder = 1
          OnExit = cbKONHExit
          Anchors = [akLeft, akTop, akRight]
          ReadOnly = False
          Text = ''
          OnChange = mmNameChange
          StoredValues = 64
        end
        object edFam3: TEdit
          Left = 78
          Top = 78
          Width = 145
          Height = 21
          MaxLength = 50
          TabOrder = 2
          OnChange = mmNameChange
        end
        object edOtch3: TEdit
          Left = 78
          Top = 126
          Width = 121
          Height = 21
          MaxLength = 50
          TabOrder = 3
          OnChange = mmNameChange
        end
        object edIm3: TEdit
          Left = 78
          Top = 102
          Width = 97
          Height = 21
          MaxLength = 50
          TabOrder = 4
          OnChange = mmNameChange
        end
        object edPost3: TEdit
          Left = 314
          Top = 126
          Width = 181
          Height = 21
          MaxLength = 50
          TabOrder = 5
          OnChange = mmNameChange
        end
        object edPhone3: TEdit
          Left = 314
          Top = 102
          Width = 181
          Height = 21
          MaxLength = 50
          TabOrder = 6
          OnChange = mmNameChange
        end
        object cbASFType: TdxPickEdit
          Left = 220
          Top = 8
          Width = 466
          TabOrder = 0
          OnExit = cbKONHExit
          Anchors = [akLeft, akTop, akRight]
          ReadOnly = False
          Text = ''
          OnChange = mmNameChange
          Items.Strings = (
            '<'#1079#1085#1072#1095#1077#1085#1080#1077' '#1085#1077' '#1086#1087#1088#1077#1076#1077#1083#1077#1085#1086'>'
            #1085#1077' '#1080#1084#1077#1077#1090
            #1080#1084#1077#1077#1090' '#1096#1090#1072#1090#1085#1099#1077' '#1040#1057#1060
            #1080#1084#1077#1077#1090' '#1053#1040#1057#1060)
          StoredValues = 64
        end
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 165
        Width = 701
        Height = 268
        ActivePage = TabSheet3
        Align = alClient
        MultiLine = True
        TabOrder = 1
        object TabSheet3: TTabSheet
          Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1040#1057#1044#1053#1056', '#1085#1072' '#1082#1086#1090#1086#1088#1099#1077' '#1072#1090#1090#1077#1089#1090#1086#1074#1072#1085#1099' '#1040#1057#1060' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
          object dxDBGrid1: TdxDBGrid
            Left = 0
            Top = 28
            Width = 693
            Height = 194
            Bands = <
              item
                Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1040#1057#1044#1053#1056', '#1085#1072' '#1082#1086#1090#1086#1088#1099#1077' '#1072#1090#1090#1077#1089#1090#1086#1074#1072#1085#1099' '#1040#1057#1060' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
              end>
            DefaultLayout = True
            HeaderPanelRowCount = 1
            KeyField = 'RecId'
            SummaryGroups = <>
            SummarySeparator = ', '
            Align = alClient
            TabOrder = 0
            DataSource = dsAsdnrAttest
            Filter.Criteria = {00000000}
            OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
            OnChangedColumnsWidth = dxDBGrid1ChangedColumnsWidth
            ExplicitTop = 26
            ExplicitHeight = 196
            object dxDBGrid1RecId: TdxDBGridColumn
              Visible = False
              BandIndex = 0
              RowIndex = 0
              FieldName = 'RecId'
            end
            object dxDBGrid1Asdnr: TdxDBGridLookupColumn
              Caption = #1042#1080#1076' '#1040#1057#1044#1053#1056
              Width = 150
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Asdnr'
            end
            object dxDBGrid1Asf: TdxDBGridLookupColumn
              Caption = #1040#1057#1060
              Width = 150
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Asf'
            end
            object dxDBGrid1Who_Attest: TdxDBGridMaskColumn
              Caption = #1050#1077#1084' '#1072#1090#1090#1077#1089#1090#1086#1074#1072#1085#1086
              Width = 200
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Who_Attest'
            end
            object dxDBGrid1When_Attest: TdxDBGridDateColumn
              Caption = #1050#1086#1075#1076#1072' '#1072#1090#1090#1077#1089#1090#1086#1074#1072#1085#1086
              Width = 150
              BandIndex = 0
              RowIndex = 0
              FieldName = 'When_Attest'
            end
            object dxDBGrid1Asdnr_Id: TdxDBGridMaskColumn
              Visible = False
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Asdnr_Id'
            end
            object dxDBGrid1Asf_Id: TdxDBGridMaskColumn
              Visible = False
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Asf_Id'
            end
          end
          object dxBarDockControl1: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 693
            Height = 28
            Align = dalTop
            BarManager = dxBarManager1
          end
        end
        object TabSheet4: TTabSheet
          Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1040#1057#1044#1053#1056', '#1091#1095#1077#1085#1080#1081' '#1080' '#1090#1088#1077#1085#1080#1088#1086#1074#1086#1082
          ImageIndex = 1
          object dxDBGrid3: TdxDBGrid
            Left = 0
            Top = 28
            Width = 693
            Height = 194
            Bands = <
              item
                Caption = #1055#1077#1088#1077#1095#1077#1085#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1085#1099#1093' '#1040#1057#1044#1053#1056', '#1091#1095#1077#1085#1080#1081' '#1080' '#1090#1088#1077#1085#1080#1088#1086#1074#1086#1082
              end>
            DefaultLayout = True
            HeaderPanelRowCount = 1
            KeyField = 'RecId'
            SummaryGroups = <>
            SummarySeparator = ', '
            Align = alClient
            TabOrder = 0
            DataSource = dsAsdnrMade
            Filter.Criteria = {00000000}
            OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
            OnChangedColumnsWidth = dxDBGrid3ChangedColumnsWidth
            ExplicitTop = 26
            ExplicitHeight = 196
            object dxDBGrid3RecId: TdxDBGridColumn
              Visible = False
              BandIndex = 0
              RowIndex = 0
              FieldName = 'RecId'
            end
            object dxDBGrid3Asdnr_Id: TdxDBGridMaskColumn
              Visible = False
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Asdnr_Id'
            end
            object dxDBGrid3Asndr: TdxDBGridLookupColumn
              Caption = #1042#1080#1076' '#1040#1057#1044#1053#1056
              Width = 150
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Asndr'
            end
            object dxDBGrid3Content: TdxDBGridMaskColumn
              Caption = #1050#1088#1072#1090#1082#1086#1077' '#1089#1086#1076#1077#1088#1078#1072#1085#1080#1077
              Width = 250
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Content'
            end
            object dxDBGrid3Date_Begin: TdxDBGridDateColumn
              Caption = #1044#1072#1090#1072' '#1085#1072#1095#1072#1083#1072
              Width = 100
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Date_Begin'
            end
            object dxDBGrid3Date_End: TdxDBGridDateColumn
              Caption = #1044#1072#1090#1072' '#1086#1082#1086#1085#1095#1072#1085#1080#1103
              Width = 100
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Date_End'
            end
          end
          object dxBarDockControl2: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 693
            Height = 28
            Align = dalTop
            BarManager = dxBarManager1
          end
        end
        object TabSheet5: TTabSheet
          Caption = #1053#1072#1083#1080#1095#1080#1077' '#1079#1076#1072#1085#1080#1081', '#1089#1090#1088#1086#1077#1085#1080#1081' '#1080' '#1087#1086#1084#1077#1097#1077#1085#1080#1081
          ImageIndex = 2
          object dxDBGrid2: TdxDBGrid
            Left = 0
            Top = 28
            Width = 693
            Height = 194
            Bands = <
              item
                Caption = #1053#1072#1083#1080#1095#1080#1077' '#1079#1076#1072#1085#1080#1081', '#1089#1090#1088#1086#1077#1085#1080#1081' '#1080' '#1087#1086#1084#1077#1097#1077#1085#1080#1081
              end>
            DefaultLayout = True
            HeaderPanelRowCount = 1
            KeyField = 'RecId'
            SummaryGroups = <>
            SummarySeparator = ', '
            Align = alClient
            TabOrder = 0
            DataSource = dsBuildings
            Filter.Criteria = {00000000}
            OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
            ExplicitTop = 26
            ExplicitHeight = 196
            object dxDBGrid2RecId: TdxDBGridColumn
              Visible = False
              BandIndex = 0
              RowIndex = 0
              FieldName = 'RecId'
            end
            object dxDBGrid2Naim: TdxDBGridMaskColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
              Width = 160
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Naim'
            end
            object dxDBGrid2Purpose: TdxDBGridMaskColumn
              Caption = #1053#1072#1079#1085#1072#1095#1077#1085#1080#1077
              Width = 160
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Purpose'
            end
            object dxDBGrid2Area: TdxDBGridMaskColumn
              Caption = #1055#1083#1086#1097#1072#1076#1100', '#1084'2'
              Width = 160
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Area'
            end
            object dxDBGrid2Comment: TdxDBGridMaskColumn
              Caption = #1055#1088#1080#1084#1077#1095#1072#1085#1080#1077
              Width = 160
              BandIndex = 0
              RowIndex = 0
              FieldName = 'Comment'
            end
          end
          object dxBarDockControl3: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 693
            Height = 28
            Align = dalTop
            BarManager = dxBarManager1
          end
        end
        object TabSheet6: TTabSheet
          Caption = #1040#1061#1054#1042
          ImageIndex = 3
          object dxBarDockControl4: TdxBarDockControl
            Left = 0
            Top = 0
            Width = 693
            Height = 28
            Align = dalTop
            BarManager = dxBarManager1
          end
          object dxDBGrid4: TdxDBGrid
            Left = 0
            Top = 28
            Width = 693
            Height = 194
            Bands = <
              item
                Caption = #1053#1072#1083#1080#1095#1080#1077' '#1079#1076#1072#1085#1080#1081', '#1089#1090#1088#1086#1077#1085#1080#1081' '#1080' '#1087#1086#1084#1077#1097#1077#1085#1080#1081
              end>
            DefaultLayout = True
            HeaderPanelRowCount = 1
            KeyField = 'RecId'
            SummaryGroups = <>
            SummarySeparator = ', '
            Align = alClient
            TabOrder = 1
            DataSource = dsAHOV
            Filter.Criteria = {00000000}
            OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
            ExplicitTop = 26
            ExplicitHeight = 196
            object dxDBGrid4RecId: TdxDBGridColumn
              Visible = False
              Width = 96
              BandIndex = 0
              RowIndex = 0
              FieldName = 'RecId'
            end
            object dxDBGrid4AHOV_Naim: TdxDBGridMaskColumn
              Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' ('#1074#1080#1076')'
              Width = 400
              BandIndex = 0
              RowIndex = 0
              FieldName = 'AHOV_Naim'
            end
            object dxDBGrid4AHOV_Amount: TdxDBGridMaskColumn
              Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' ('#1090#1086#1085#1085')'
              Width = 200
              BandIndex = 0
              RowIndex = 0
              FieldName = 'AHOV_Amount'
            end
          end
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 461
    Width = 709
    Height = 41
    Align = alBottom
    TabOrder = 4
    DesignSize = (
      709
      41)
    object btnCancel: TButton
      Left = 622
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnApply: TButton
      Left = 544
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      TabOrder = 1
      OnClick = btnApplyClick
    end
  end
  object pmOKATO: TPopupMenu
    Left = 760
    Top = 84
    object N1: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ShortCut = 13
      OnClick = dxtOKATODblClick
    end
  end
  object pmTerr: TPopupMenu
    Left = 776
    Top = 252
    object MenuItem1: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ShortCut = 13
      OnClick = dxtKTerrDblClick
    end
  end
  object pmOKTMO: TPopupMenu
    Left = 752
    Top = 196
    object mi1: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100
      ShortCut = 13
      OnClick = dxtOKATODblClick
    end
  end
  object mAsdnrAttest: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterInsert = mAsdnrAttestAfterPost
    AfterEdit = mAsdnrAttestAfterPost
    AfterPost = mAsdnrAttestAfterPost
    AfterDelete = mAsdnrAttestAfterPost
    Left = 344
    Top = 252
    object mAsdnrAttestAsdnr_Id: TIntegerField
      FieldName = 'Asdnr_Id'
    end
    object mAsdnrAttestAsf_Id: TIntegerField
      FieldName = 'Asf_Id'
    end
    object mAsdnrAttestWho_Attest: TStringField
      FieldName = 'Who_Attest'
      Size = 100
    end
    object mAsdnrAttestWhen_Attest: TDateField
      FieldName = 'When_Attest'
    end
    object mAsdnrAttestAsdnr: TStringField
      FieldKind = fkLookup
      FieldName = 'Asdnr'
      LookupDataSet = KASDNR
      LookupKeyFields = 'ID'
      LookupResultField = 'Name'
      KeyFields = 'Asdnr_Id'
      Size = 100
      Lookup = True
    end
    object mAsdnrAttestAsf: TStringField
      FieldKind = fkLookup
      FieldName = 'Asf'
      LookupDataSet = qASF
      LookupKeyFields = 'Asf_Id'
      LookupResultField = 'Name'
      KeyFields = 'Asf_Id'
      Size = 100
      Lookup = True
    end
  end
  object mAsdnrMade: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterInsert = mAsdnrAttestAfterPost
    AfterEdit = mAsdnrAttestAfterPost
    AfterPost = mAsdnrAttestAfterPost
    AfterDelete = mAsdnrAttestAfterPost
    Left = 342
    Top = 304
    object mAsdnrMadeAsdnr_Id: TIntegerField
      FieldName = 'Asdnr_Id'
    end
    object mAsdnrMadeContent: TStringField
      FieldName = 'Content'
      Size = 100
    end
    object mAsdnrMadeDate_Begin: TDateField
      FieldName = 'Date_Begin'
    end
    object mAsdnrMadeDate_End: TDateField
      FieldName = 'Date_End'
    end
    object mAsdnrMadeAsndr: TStringField
      FieldKind = fkLookup
      FieldName = 'Asndr'
      LookupDataSet = KASDNR
      LookupKeyFields = 'ID'
      LookupResultField = 'Name'
      KeyFields = 'Asdnr_Id'
      Size = 100
      Lookup = True
    end
  end
  object mBuildings: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterInsert = mAsdnrAttestAfterPost
    AfterEdit = mAsdnrAttestAfterPost
    AfterPost = mAsdnrAttestAfterPost
    AfterDelete = mAsdnrAttestAfterPost
    Left = 344
    Top = 358
    object mBuildingsNaim: TStringField
      FieldName = 'Naim'
      Size = 100
    end
    object mBuildingsPurpose: TStringField
      FieldName = 'Purpose'
      Size = 100
    end
    object mBuildingsArea: TStringField
      FieldName = 'Area'
      Size = 100
    end
    object mBuildingsComment: TStringField
      FieldName = 'Comment'
      Size = 100
    end
  end
  object dsAsdnrAttest: TDataSource
    DataSet = mAsdnrAttest
    Left = 410
    Top = 254
  end
  object dsAsdnrMade: TDataSource
    DataSet = mAsdnrMade
    Left = 426
    Top = 308
  end
  object dsBuildings: TDataSource
    DataSet = mBuildings
    Left = 404
    Top = 360
  end
  object KASDNR: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * From KASDNR')
    Left = 562
    Top = 246
    object KASDNRID: TIntegerField
      FieldName = 'ID'
    end
    object KASDNRName: TWideStringField
      FieldName = 'Name'
      Size = 100
    end
  end
  object qASF: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select Asf_Id, iif(OrgSName='#39#39', OrgName, OrgSName) As Name'
      'from ASF')
    Left = 564
    Top = 304
    object qASFAsf_Id: TIntegerField
      FieldName = 'Asf_Id'
    end
    object qASFName: TWideStringField
      FieldName = 'Name'
      ReadOnly = True
      Size = 255
    end
  end
  object dxBarDBNavigator1: TdxBarDBNavigator
    BarManager = dxBarManager1
    CategoryName = 'DB Navigator'
    ConfirmDelete = True
    DataSource = dsAsdnrAttest
    DBCheckLinks = <>
    VisibleButtons = [dxbnInsert, dxbnDelete, dxbnEdit, dxbnPost, dxbnCancel]
    Left = 398
    Top = 172
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default'
      'DB Navigator')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 306
    Top = 168
    PixelsPerInch = 96
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dxBarDockControl1
      DockedDockControl = dxBarDockControl1
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 0
      FloatTop = 148
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarDBNavInsert1'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavDelete1'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavEdit2'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarDBNavPost1'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavCancel1'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      SizeGrip = False
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarManager1Bar2: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 2'
      CaptionButtons = <>
      DockControl = dxBarDockControl2
      DockedDockControl = dxBarDockControl2
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 337
      FloatTop = 375
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarDBNavInsert2'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavDelete2'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavEdit1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarDBNavPost2'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavCancel2'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      SizeGrip = False
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarManager1Bar3: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 3'
      CaptionButtons = <>
      DockControl = dxBarDockControl3
      DockedDockControl = dxBarDockControl3
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 733
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarDBNavInsert3'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavDelete3'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavEdit3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarDBNavPost3'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavCancel3'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      SizeGrip = False
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarManager1Bar4: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = 'Custom 4'
      CaptionButtons = <>
      DockControl = dxBarDockControl4
      DockedDockControl = dxBarDockControl4
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 214
      FloatTop = 425
      FloatClientWidth = 51
      FloatClientHeight = 24
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarDBNavInsert4'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavDelete4'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavEdit4'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarDBNavPost4'
        end
        item
          Visible = True
          ItemName = 'dxBarDBNavCancel4'
        end>
      NotDocking = [dsNone, dsLeft, dsTop, dsRight, dsBottom]
      OneOnRow = True
      Row = 0
      SizeGrip = False
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxBarDBNavInsert1: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnInsert
      CaptionEx = #1044#1086#1073#1072#1074#1080#1090#1100
    end
    object dxBarDBNavDelete1: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnDelete
      CaptionEx = #1059#1076#1072#1083#1080#1090#1100
    end
    object dxBarDBNavInsert2: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator2
      NavButton = dxbnInsert
      CaptionEx = #1044#1086#1073#1072#1074#1080#1090#1100
    end
    object dxBarDBNavDelete2: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator2
      NavButton = dxbnDelete
      CaptionEx = #1059#1076#1072#1083#1080#1090#1100
    end
    object dxBarDBNavPost2: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FF000000FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator2
      NavButton = dxbnPost
      CaptionEx = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavEdit1: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator2
      NavButton = dxbnEdit
      CaptionEx = #1048#1079#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavEdit2: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnEdit
      CaptionEx = #1048#1079#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavInsert3: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator3
      NavButton = dxbnInsert
      CaptionEx = #1044#1086#1073#1072#1074#1080#1090#1100
    end
    object dxBarDBNavDelete3: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator3
      NavButton = dxbnDelete
      CaptionEx = #1059#1076#1072#1083#1080#1090#1100
    end
    object dxBarDBNavEdit3: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator3
      NavButton = dxbnEdit
      CaptionEx = #1048#1079#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavPost3: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FF000000FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator3
      NavButton = dxbnPost
      CaptionEx = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavPost1: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FF000000FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnPost
      CaptionEx = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavCancel1: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator1
      NavButton = dxbnCancel
      CaptionEx = #1054#1090#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavCancel2: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator2
      NavButton = dxbnCancel
      CaptionEx = #1054#1090#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavCancel3: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator3
      NavButton = dxbnCancel
      CaptionEx = #1054#1090#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavInsert4: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator4
      NavButton = dxbnInsert
      CaptionEx = #1044#1086#1073#1072#1074#1080#1090#1100
    end
    object dxBarDBNavDelete4: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator4
      NavButton = dxbnDelete
      CaptionEx = #1059#1076#1072#1083#1080#1090#1100
    end
    object dxBarDBNavEdit4: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator4
      NavButton = dxbnEdit
      CaptionEx = #1048#1079#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavPost4: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FF000000FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator4
      NavButton = dxbnPost
      CaptionEx = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    end
    object dxBarDBNavCancel4: TdxBarDBNavButton
      Category = 1
      Enabled = False
      Visible = ivAlways
      Glyph.SourceDPI = 96
      Glyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000C0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FF000000FF000000FF000000FF000000FF000000FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FF000000FF000000FF000000FFC0C0C0FF000000FF000000FF0000
        00FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FF000000FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FF000000FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF0000
        00FF000000FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0
        C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FFC0C0C0FF}
      BarDBNavigator = dxBarDBNavigator4
      NavButton = dxbnCancel
      CaptionEx = #1054#1090#1084#1077#1085#1080#1090#1100
    end
  end
  object dxBarDBNavigator2: TdxBarDBNavigator
    BarManager = dxBarManager1
    CategoryName = 'DB Navigator'
    ConfirmDelete = True
    DataSource = dsAsdnrMade
    DBCheckLinks = <>
    VisibleButtons = [dxbnInsert, dxbnDelete, dxbnEdit, dxbnPost, dxbnCancel]
    Left = 488
    Top = 256
  end
  object dxBarDBNavigator3: TdxBarDBNavigator
    BarManager = dxBarManager1
    CategoryName = 'DB Navigator'
    ConfirmDelete = True
    DataSource = dsBuildings
    DBCheckLinks = <>
    VisibleButtons = [dxbnInsert, dxbnDelete, dxbnEdit, dxbnPost, dxbnCancel]
    Left = 510
    Top = 372
  end
  object dxBarDBNavigator4: TdxBarDBNavigator
    BarManager = dxBarManager1
    CategoryName = 'DB Navigator'
    ConfirmDelete = True
    DataSource = dsAHOV
    DBCheckLinks = <>
    VisibleButtons = [dxbnInsert, dxbnDelete, dxbnEdit, dxbnPost, dxbnCancel]
    Left = 512
    Top = 424
  end
  object dsAHOV: TDataSource
    DataSet = mAHOV
    Left = 406
    Top = 412
  end
  object mAHOV: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterInsert = mAsdnrAttestAfterPost
    AfterEdit = mAsdnrAttestAfterPost
    AfterPost = mAsdnrAttestAfterPost
    AfterDelete = mAsdnrAttestAfterPost
    Left = 346
    Top = 410
    object mAHOVAHOV_Naim: TStringField
      FieldName = 'AHOV_Naim'
      Size = 100
    end
    object mAHOVAHOV_Amount: TStringField
      FieldName = 'AHOV_Amount'
      Size = 100
    end
  end
end

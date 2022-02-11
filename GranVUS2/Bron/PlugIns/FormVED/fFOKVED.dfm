object fmFOKVED: TfmFOKVED
  Left = 264
  Top = 179
  HelpContext = 17
  Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086' '#1095#1080#1089#1083#1077#1085#1085#1086#1089#1090#1080' '#1087#1086' '#1074#1080#1076#1072#1084' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1086#1081' '#1076#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1080
  ClientHeight = 446
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -7
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 792
    Height = 22
    AutoSize = True
    ButtonWidth = 103
    Caption = 'ToolBar1'
    Images = dmMain.ilSmall
    List = True
    ParentShowHint = False
    ShowCaptions = True
    ShowHint = True
    TabOrder = 0
    object ToolButton4: TToolButton
      Left = 0
      Top = 0
      Action = actClear
    end
    object ToolButton2: TToolButton
      Left = 103
      Top = 0
      Action = actCreate
    end
    object ToolButton3: TToolButton
      Left = 206
      Top = 0
      Action = actPrint
    end
    object ToolButton1: TToolButton
      Left = 309
      Top = 0
      Action = actGenerate
    end
    object ToolButton6: TToolButton
      Left = 412
      Top = 0
      Action = actCheck
    end
    object ToolButton5: TToolButton
      Left = 515
      Top = 0
      Action = actExcel
    end
  end
  object dxDBGrid: TdxDBGrid
    Left = 0
    Top = 22
    Width = 792
    Height = 424
    Bands = <
      item
        DisableCustomizing = True
        DisableDragging = True
        OnlyOwnColumns = True
        Width = 412
      end>
    DefaultLayout = False
    HeaderPanelRowCount = 1
    KeyField = 'NUM'
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -7
    BandFont.Name = 'MS Sans Serif'
    BandFont.Style = []
    DataSource = dsData
    Filter.Criteria = {00000000}
    FixedBandLineWidth = 1
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -7
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    OptionsCustomize = [edgoBandSizing, edgoColumnSizing]
    OptionsDB = [edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -7
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    OnColumnSorting = dxDBGridColumnSorting
    OnCustomDrawCell = dxDBGridCustomDrawCell
    OnEdited = dxDBGridEdited
    OnEditing = dxDBGridEditing
    object dxDBGridNUM: TdxDBGridColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'NUM'
    end
    object NAMEColumn: TdxDBGridColumn
      Alignment = taLeftJustify
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081', '#1075#1088#1072#1078#1076#1072#1085
      Color = clBtnFace
      DisableCustomizing = True
      DisableDragging = True
      DisableEditor = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      HeaderAlignment = taCenter
      ReadOnly = True
      Width = 259
      BandIndex = 0
      RowIndex = 0
      DisableGrouping = True
      FieldName = 'NAME'
      SummaryFooterType = cstMax
      SummaryFooterField = 'SUBJ_ID'
      SummaryFooterFormat = #39#1048#1090#1086#1075#1086':'#39
    end
    object dxDBGridA: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'A'
      SummaryFooterType = cstSum
    end
    object dxDBGridB: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'B'
      SummaryFooterType = cstSum
    end
    object dxDBGridC: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'C'
      SummaryFooterType = cstSum
    end
    object dxDBGridD: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'D'
      SummaryFooterType = cstSum
    end
    object dxDBGridE: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'E'
      SummaryFooterType = cstSum
    end
    object dxDBGridF: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'F'
      SummaryFooterType = cstSum
    end
    object dxDBGridG: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'G'
      SummaryFooterType = cstSum
    end
    object dxDBGridH: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'H'
      SummaryFooterType = cstSum
    end
    object dxDBGridI: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'I'
      SummaryFooterType = cstSum
    end
    object dxDBGridJ: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'J'
      SummaryFooterType = cstSum
    end
    object dxDBGridK: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'K'
      SummaryFooterType = cstSum
    end
    object dxDBGridL: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'L'
      SummaryFooterType = cstSum
    end
    object dxDBGridM: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'M'
      SummaryFooterType = cstSum
    end
    object dxDBGridN: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N'
      SummaryFooterType = cstSum
    end
    object dxDBGridO: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'O'
      SummaryFooterType = cstSum
    end
    object dxDBGridP: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'P'
      SummaryFooterType = cstSum
    end
    object dxDBGridQ: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Q'
      SummaryFooterType = cstSum
    end
    object dxDBGridR: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'R'
      SummaryFooterType = cstSum
    end
    object dxDBGridS: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'S'
      SummaryFooterType = cstSum
    end
    object dxDBGridT: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'T'
      SummaryFooterType = cstSum
    end
    object dxDBGridU: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 60
      BandIndex = 0
      RowIndex = 0
      FieldName = 'U'
      SummaryFooterType = cstSum
    end
    object dxDBGridSum: TdxDBGridColumn
      Caption = #1042#1089#1077#1075#1086
      Color = clBtnFace
      DisableEditor = True
      HeaderAlignment = taCenter
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Sum'
      SummaryFooterType = cstSum
      SummaryFooterFormat = '#0'
    end
  end
  object dsData: TDataSource
    DataSet = qrData
    Left = 144
    Top = 208
  end
  object ActionList: TActionList
    Images = dmMain.ilSmall
    Left = 184
    Top = 208
    object actGenerate: TAction
      Caption = '&'#1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100
      Hint = 
        #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1072#1075#1088#1077#1075#1080#1088#1086#1074#1072#1085#1085#1091#1102' '#1092#1086#1088#1084#1091' '#1087#1086' '#1074#1080#1076#1072#1084' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1086#1081' '#1076#1077#1103#1090#1077#1083#1100 +
        #1085#1086#1089#1090#1080
      ImageIndex = 40
      OnExecute = actGenerateExecute
    end
    object actPrint: TAction
      Caption = '&'#1054#1090#1095#1077#1090
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1091#1102' '#1092#1086#1088#1084#1091' '#1074' '#1090#1077#1082#1089#1090#1086#1074#1099#1081' '#1088#1077#1076#1072#1082#1090#1086#1088
      ImageIndex = 37
      OnExecute = actPrintExecute
    end
    object actClear: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1092#1086#1088#1084#1091
      ImageIndex = 4
      OnExecute = actClearExecute
    end
    object actCreate: TAction
      Caption = #1057#1086#1079#1076#1072#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1087#1091#1089#1090#1091#1102' '#1092#1086#1088#1084#1091
      ImageIndex = 21
      OnExecute = actCreateExecute
    end
    object actExcel: TAction
      Caption = #1042#1099#1075#1088#1091#1079#1082#1072
      Hint = #1042#1099#1075#1088#1091#1079#1082#1072' '#1090#1072#1073#1083#1080#1094#1099' '#1074' Microsoft Excel'
      ImageIndex = 43
      OnExecute = actExcelExecute
    end
    object actCheck: TAction
      Caption = #1055'&'#1088#1086#1074#1077#1088#1082#1072
      ImageIndex = 23
      OnExecute = actCheckExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 224
    Top = 208
    object N1: TMenuItem
      Action = actGenerate
    end
    object N3: TMenuItem
      Action = actCreate
    end
    object N2: TMenuItem
      Action = actClear
    end
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    BeforePost = qrDataBeforePost
    OnCalcFields = qrDataCalcFields
    Parameters = <
      item
        Name = 'SUBJ_ID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'declare @SUBJ_ID int'
      'set @SUBJ_ID = :SUBJ_ID'
      ''
      'select F.SUBJ_ID, F.NUM,'
      
        ' F.A, F.B, F.C, F.D, F.E, F.F, F.G, F.H, F.I, F.J, F.K, F.L, F.M' +
        ', F.N, F.O,'
      ' F.P, F.Q, F.R, F.S, F.T, F.U'
      'from FOKVED2010 F'
      'where F.SUBJ_ID = @SUBJ_ID'
      'union all'
      'select @SUBJ_ID, 35, '
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), A) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), A) from FOKVED2010 where NUM = 2' +
        '0 and A <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), B) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), B) from FOKVED2010 where NUM = 2' +
        '0 and B <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), C) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), C) from FOKVED2010 where NUM = 2' +
        '0 and C <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      'convert(decimal(18, 2),'
      
        '(select convert(decimal(18, 2), D) from FOKVED2010 where NUM = 3' +
        '0 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), D) from FOKVED2010 where NUM = 2' +
        '0 and D <> 0 and SUBJ_ID = @SUBJ_ID) * '
      '100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), E) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), E) from FOKVED2010 where NUM = 2' +
        '0 and E <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), F) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), F) from FOKVED2010 where NUM = 2' +
        '0 and F <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), G) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), G) from FOKVED2010 where NUM = 2' +
        '0 and G <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), H) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), H) from FOKVED2010 where NUM = 2' +
        '0 and H <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), I) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), I) from FOKVED2010 where NUM = 2' +
        '0 and I <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), J) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), J) from FOKVED2010 where NUM = 2' +
        '0 and J <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), K) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), K) from FOKVED2010 where NUM = 2' +
        '0 and K <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), L) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), L) from FOKVED2010 where NUM = 2' +
        '0 and L <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), M) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), M) from FOKVED2010 where NUM = 2' +
        '0 and M <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), N) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), N) from FOKVED2010 where NUM = 2' +
        '0 and N <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), O) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), O) from FOKVED2010 where NUM = 2' +
        '0 and O <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), P) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), P) from FOKVED2010 where NUM = 2' +
        '0 and P <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), Q) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), Q) from FOKVED2010 where NUM = 2' +
        '0 and Q <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), R) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), R) from FOKVED2010 where NUM = 2' +
        '0 and R <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), S) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), S) from FOKVED2010 where NUM = 2' +
        '0 and S <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), T) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), T) from FOKVED2010 where NUM = 2' +
        '0 and T <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), U) from F' +
        'OKVED2010 where NUM = 30 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), U) from FOKVED2010 where NUM = 2' +
        '0 and U <> 0 and SUBJ_ID = @SUBJ_ID) * 100)'
      'union all'
      'select @SUBJ_ID, 45,'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), A) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), A) from FOKVED2010 where NUM = 3' +
        '0 and A <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), B) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), B) from FOKVED2010 where NUM = 3' +
        '0 and B <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), C) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), C) from FOKVED2010 where NUM = 3' +
        '0 and C <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), D) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), D) from FOKVED2010 where NUM = 3' +
        '0 and D <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), E) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), E) from FOKVED2010 where NUM = 3' +
        '0 and E <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), F) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), F) from FOKVED2010 where NUM = 3' +
        '0 and F <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), G) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), G) from FOKVED2010 where NUM = 3' +
        '0 and G <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), H) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), H) from FOKVED2010 where NUM = 3' +
        '0 and H <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), I) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), I) from FOKVED2010 where NUM = 3' +
        '0 and I <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), J) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), J) from FOKVED2010 where NUM = 3' +
        '0 and J <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), K) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), K) from FOKVED2010 where NUM = 3' +
        '0 and K <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), L) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), L) from FOKVED2010 where NUM = 3' +
        '0 and L <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), M) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), M) from FOKVED2010 where NUM = 3' +
        '0 and M <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), N) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), N) from FOKVED2010 where NUM = 3' +
        '0 and N <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), O) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), O) from FOKVED2010 where NUM = 3' +
        '0 and O <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), P) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), P) from FOKVED2010 where NUM = 3' +
        '0 and P <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), Q) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), Q) from FOKVED2010 where NUM = 3' +
        '0 and Q <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), R) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), R) from FOKVED2010 where NUM = 3' +
        '0 and R <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), S) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), S) from FOKVED2010 where NUM = 3' +
        '0 and S <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), T) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), T) from FOKVED2010 where NUM = 3' +
        '0 and T <> 0 and SUBJ_ID = @SUBJ_ID) * 100),'
      
        'convert(decimal(18, 2),(select convert(decimal(18, 2), U) from F' +
        'OKVED2010 where NUM = 40 and SUBJ_ID = @SUBJ_ID) /'
      
        '(select convert(decimal(18, 2), U) from FOKVED2010 where NUM = 3' +
        '0 and U <> 0 and SUBJ_ID = @SUBJ_ID) * 100)'
      'order by F.NUM'
      '')
    Left = 104
    Top = 208
    object qrDataSUBJ_ID: TIntegerField
      FieldName = 'SUBJ_ID'
    end
    object qrDataNUM: TIntegerField
      FieldName = 'NUM'
    end
    object qrDataNAME: TStringField
      DisplayWidth = 500
      FieldKind = fkLookup
      FieldName = 'NAME'
      LookupDataSet = qrKOKVED
      LookupKeyFields = 'NUM'
      LookupResultField = 'NAME'
      KeyFields = 'NUM'
      Size = 500
      Lookup = True
    end
    object qrDataA: TFloatField
      FieldName = 'A'
    end
    object qrDataB: TFloatField
      FieldName = 'B'
    end
    object qrDataC: TFloatField
      FieldName = 'C'
    end
    object qrDataD: TFloatField
      FieldName = 'D'
    end
    object qrDataE: TFloatField
      FieldName = 'E'
    end
    object qrDataF: TFloatField
      FieldName = 'F'
    end
    object qrDataG: TFloatField
      FieldName = 'G'
    end
    object qrDataH: TFloatField
      FieldName = 'H'
    end
    object qrDataI: TFloatField
      FieldName = 'I'
    end
    object qrDataJ: TFloatField
      FieldName = 'J'
    end
    object qrDataK: TFloatField
      FieldName = 'K'
    end
    object qrDataL: TFloatField
      FieldName = 'L'
    end
    object qrDataM: TFloatField
      FieldName = 'M'
    end
    object qrDataN: TFloatField
      FieldName = 'N'
    end
    object qrDataO: TFloatField
      FieldName = 'O'
    end
    object qrDataP: TFloatField
      FieldName = 'P'
    end
    object qrDataQ: TFloatField
      FieldName = 'Q'
    end
    object qrDataSum: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Sum'
      Calculated = True
    end
    object qrDataR: TFloatField
      FieldName = 'R'
    end
    object qrDataS: TFloatField
      FieldName = 'S'
    end
    object qrDataT: TFloatField
      FieldName = 'T'
    end
    object qrDataU: TFloatField
      FieldName = 'U'
    end
  end
  object sp_FOKVEDCreate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FOKVED2010Create'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SUBJ_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 236
    Top = 96
  end
  object sp_FOKVEDClear: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FOKVED2010Clear;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SUBJ_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 304
    Top = 148
  end
  object sp_FOKVEDGenerate: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_FOKVED2010Generate;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SUBJ_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end
      item
        Name = '@IS_FULL'
        Attributes = [paNullable]
        DataType = ftBoolean
        Value = Null
      end
      item
        Name = '@FilterType'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 384
    Top = 104
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 100
    Top = 92
  end
  object qrKOKVED: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT 10 as NUM, '#39'1. '#1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081#39' as NAME'
      'union all'
      'SELECT 15, '#39'2. '#1080#1079' '#1085#1080#1093' '#1074#1077#1076#1091#1097#1080#1093' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077' '#1043#1055#1047#39
      'union all'
      'SELECT 20, '#39'3. '#1056#1072#1073#1086#1090#1072#1102#1097#1080#1093#39
      'union all'
      'SELECT 30, '#39'4. '#1080#1079' '#1085#1080#1093'  '#1043#1055#1047' '#1082#1086#1083'-'#1074#1086#39
      'union all'
      'SELECT 35, '#39'    '#1080#1079' '#1085#1080#1093'  '#1043#1055#1047' %'#39
      'union all'
      'SELECT 40, '#39'5. '#1074' '#1090'.'#1095'. '#1079#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1086' '#1082#1086#1083'-'#1074#1086#39
      'union all'
      'SELECT 45, '#39'    '#1074' '#1090'.'#1095'. '#1079#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1086' %'#39)
    Left = 336
    Top = 204
    object qrKOKVEDNUM: TIntegerField
      FieldName = 'NUM'
      ReadOnly = True
    end
    object qrKOKVEDNAME: TStringField
      FieldName = 'NAME'
      ReadOnly = True
      Size = 30
    end
  end
end

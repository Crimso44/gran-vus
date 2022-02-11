object fmSubjCard: TfmSubjCard
  Left = 277
  Top = 220
  HelpContext = 10
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1072#1088#1090#1086#1095#1082#1072' '#1042#1059#1054
  ClientHeight = 404
  ClientWidth = 484
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Scaled = False
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  DesignSize = (
    484
    404)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 79
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
  end
  object btnOk: TButton
    Left = 246
    Top = 376
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 326
    Top = 376
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    TabOrder = 3
    OnClick = btnCancelClick
  end
  object btnApply: TButton
    Left = 406
    Top = 376
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
    TabOrder = 4
    OnClick = btnApplyClick
  end
  object edName: TEdit
    Left = 100
    Top = 4
    Width = 381
    Height = 21
    MaxLength = 250
    TabOrder = 0
    OnChange = edNameChange
  end
  object PC: TPageControl
    Left = 3
    Top = 32
    Width = 478
    Height = 337
    ActivePage = TabSheet1
    MultiLine = True
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #1054#1073#1097#1080#1077' '#1089#1074#1077#1076#1077#1085#1080#1103
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label3: TLabel
        Left = 8
        Top = 8
        Width = 48
        Height = 13
        Caption = #1058#1080#1087' '#1042#1059#1054':'
      end
      object Label4: TLabel
        Left = 8
        Top = 40
        Width = 74
        Height = 13
        Caption = #1042#1059#1054' '#1082#1091#1088#1080#1088#1091#1077#1090':'
      end
      object Label2: TLabel
        Left = 8
        Top = 68
        Width = 115
        Height = 26
        Caption = #1055#1086#1083#1085#1086#1077' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1042#1059#1054':'
        WordWrap = True
      end
      object Label6: TLabel
        Left = 8
        Top = 104
        Width = 34
        Height = 13
        Caption = #1040#1076#1088#1077#1089':'
      end
      object Label8: TLabel
        Left = 8
        Top = 136
        Width = 70
        Height = 13
        Caption = #1057#1087#1086#1089#1086#1073' '#1091#1095#1077#1090#1072':'
      end
      object Label9: TLabel
        Left = 8
        Top = 168
        Width = 83
        Height = 13
        Caption = #1050#1086#1076' '#1090#1077#1088#1088#1080#1090#1086#1088#1080#1080':'
      end
      object Label5: TLabel
        Left = 8
        Top = 200
        Width = 65
        Height = 13
        Caption = #1044#1072#1090#1072' '#1086#1090#1095#1105#1090#1072':'
      end
      object cbTYPE: TComboBox
        Left = 136
        Top = 4
        Width = 329
        Height = 21
        Style = csDropDownList
        TabOrder = 0
        OnChange = edNameChange
      end
      object edFullName: TEdit
        Left = 136
        Top = 68
        Width = 329
        Height = 21
        MaxLength = 250
        TabOrder = 2
        OnChange = edNameChange
      end
      object edAddress: TEdit
        Left = 136
        Top = 100
        Width = 329
        Height = 21
        MaxLength = 250
        TabOrder = 3
        OnChange = edNameChange
      end
      object cbSUBJ_AGG: TComboBox
        Left = 136
        Top = 132
        Width = 329
        Height = 21
        Style = csDropDownList
        TabOrder = 4
        OnChange = edNameChange
      end
      object cbKterr: TdxPopupEdit
        Left = 136
        Top = 36
        Width = 329
        TabOrder = 1
        ReadOnly = True
        OnChange = edNameChange
        PopupAlignment = taRightJustify
        PopupControl = dxtKTerr
        PopupFormBorderStyle = pbsSysPanel
        OnCloseUp = cbKterrCloseUp
        StoredValues = 64
      end
      object cbOKATO1: TdxPopupEdit
        Left = 136
        Top = 164
        Width = 101
        TabOrder = 5
        OnKeyPress = cbOKATO1KeyPress
        MaxLength = 11
        OnChange = edNameChange
        PopupControl = dxtOKATO
        PopupFormBorderStyle = pbsSimple
        PopupClientEdge = True
        OnCloseUp = cbOKATO1CloseUp
        OnPopup = cbOKATO1Popup
        StoredValues = 2
      end
      object dxtOKATO: TdxTreeList
        Left = 637
        Top = 188
        Width = 373
        Height = 201
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        TabOrder = 6
        Visible = False
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoTabThrough, aoRowSelect]
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
      object edREPORT_DATE: TdxDateEdit
        Left = 136
        Top = 196
        Width = 101
        TabOrder = 7
        OnChange = edNameChange
        Date = -700000.000000000000000000
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1054#1088#1075#1072#1085#1099' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object dxtInfo: TdxTreeList
        Left = 4
        Top = 4
        Width = 461
        Height = 153
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        TabOrder = 0
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoCaseInsensitive]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand]
        TreeLineColor = clGrayText
        ShowRoot = False
        OnChangeNode = dxtInfoChangeNode
        object colID: TdxTreeListColumn
          DisableEditor = True
          Visible = False
          Width = 143
          BandIndex = 0
          RowIndex = 0
          OnChange = edNameChange
        end
        object colINFO_NAME: TdxTreeListColumn
          Caption = #1054#1088#1075#1072#1085
          DisableEditor = True
          Width = 229
          BandIndex = 0
          RowIndex = 0
          OnChange = edNameChange
        end
        object colORG_NAME: TdxTreeListColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          Width = 211
          BandIndex = 0
          RowIndex = 0
          OnChange = edNameChange
        end
        object colPOSITION_NAME: TdxTreeListColumn
          Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
          MaxLength = 60
          Visible = False
          Width = 88
          BandIndex = 0
          RowIndex = 0
          OnChange = edNameChange
        end
        object colFIO: TdxTreeListColumn
          Caption = #1060#1048#1054
          MaxLength = 100
          Visible = False
          Width = 116
          BandIndex = 0
          RowIndex = 0
          OnChange = edNameChange
        end
        object colPHONE: TdxTreeListColumn
          Caption = #1058#1077#1083#1077#1092#1086#1085#1099
          MaxLength = 100
          Visible = False
          Width = 83
          BandIndex = 0
          RowIndex = 0
          OnChange = edNameChange
        end
        object colPOSITION_NAME2: TdxTreeListColumn
          Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
          MaxLength = 60
          Visible = False
          BandIndex = 0
          RowIndex = 0
        end
        object colFIO2: TdxTreeListColumn
          Caption = #1060#1048#1054
          MaxLength = 100
          Visible = False
          BandIndex = 0
          RowIndex = 0
        end
        object colPHONE2: TdxTreeListColumn
          Caption = #1058#1077#1083#1077#1092#1086#1085#1099
          MaxLength = 100
          Visible = False
          BandIndex = 0
          RowIndex = 0
        end
      end
      object GroupBox1: TGroupBox
        Left = 3
        Top = 163
        Width = 230
        Height = 140
        Caption = #1056#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1100
        TabOrder = 1
        object Label12: TLabel
          Left = 3
          Top = 97
          Width = 56
          Height = 13
          Caption = #1058#1077#1083#1077#1092#1086#1085#1099':'
        end
        object Label11: TLabel
          Left = 4
          Top = 58
          Width = 30
          Height = 13
          Caption = #1060#1048#1054':'
        end
        object Label10: TLabel
          Left = 3
          Top = 19
          Width = 61
          Height = 13
          Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
        end
        object edPHONE: TEdit
          Left = 3
          Top = 111
          Width = 224
          Height = 21
          TabOrder = 2
          OnChange = edPHONEChange
        end
        object edFIO: TEdit
          Left = 3
          Top = 70
          Width = 224
          Height = 21
          TabOrder = 1
          OnChange = edFIOChange
        end
        object edPOSITION_NAME: TEdit
          Left = 3
          Top = 31
          Width = 224
          Height = 21
          TabOrder = 0
          OnChange = edPOSITION_NAMEChange
        end
      end
      object GroupBox2: TGroupBox
        Left = 239
        Top = 163
        Width = 230
        Height = 140
        Caption = #1047#1072#1084#1077#1089#1090#1080#1090#1077#1083#1100' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
        TabOrder = 2
        object Label13: TLabel
          Left = 3
          Top = 97
          Width = 56
          Height = 13
          Caption = #1058#1077#1083#1077#1092#1086#1085#1099':'
        end
        object Label14: TLabel
          Left = 4
          Top = 58
          Width = 30
          Height = 13
          Caption = #1060#1048#1054':'
        end
        object Label15: TLabel
          Left = 4
          Top = 19
          Width = 61
          Height = 13
          Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100':'
        end
        object edPHONE2: TEdit
          Left = 3
          Top = 111
          Width = 224
          Height = 21
          TabOrder = 2
          OnChange = edPHONE2Change
        end
        object edFIO2: TEdit
          Left = 3
          Top = 70
          Width = 224
          Height = 21
          TabOrder = 1
          OnChange = edFIO2Change
        end
        object edPOSITION_NAME2: TEdit
          Left = 4
          Top = 31
          Width = 224
          Height = 21
          TabOrder = 0
          OnChange = edPOSITION_NAME2Change
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1077#1085#1085#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label7: TLabel
        Left = 8
        Top = 8
        Width = 169
        Height = 13
        Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1077#1085#1085#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
      end
      object dxtParam: TdxTreeList
        Left = 8
        Top = 36
        Width = 425
        Height = 197
        Bands = <
          item
          end>
        DefaultLayout = True
        HeaderPanelRowCount = 1
        TabOrder = 0
        LookAndFeel = lfFlat
        Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoDrawEndEllipsis, aoCaseInsensitive]
        OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoEnterShowEditor, aoDragScroll, aoDragExpand]
        TreeLineColor = clGrayText
        ShowRoot = False
        object colpID: TdxTreeListColumn
          DisableEditor = True
          Visible = False
          Width = 195
          BandIndex = 0
          RowIndex = 0
          OnChange = edNameChange
        end
        object colpPARAM_NAME: TdxTreeListColumn
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
          DisableEditor = True
          Width = 296
          BandIndex = 0
          RowIndex = 0
          OnChange = edNameChange
        end
        object colpPARAM_VALUE: TdxTreeListColumn
          Caption = #1047#1085#1072#1095#1077#1085#1080#1077
          Width = 104
          BandIndex = 0
          RowIndex = 0
          OnChange = edNameChange
          OnValidate = colpPARAM_VALUEValidate
        end
      end
      object CalcButton: TButton
        Left = 360
        Top = 4
        Width = 75
        Height = 25
        Caption = #1056#1072#1089#1089#1095#1080#1090#1072#1090#1100
        TabOrder = 1
        OnClick = CalcButtonClick
      end
    end
  end
  object dxtKTerr: TdxTreeList
    Left = 655
    Top = 261
    Width = 373
    Height = 201
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    PopupMenu = pmKTerr
    TabOrder = 5
    Visible = False
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoTabThrough, aoRowSelect]
    TreeLineColor = clGrayText
    ShowGrid = True
    OnDblClick = dxtKTerrDblClick
    object dxtKTerrCode: TdxTreeListColumn
      Caption = #1050#1086#1076
      BandIndex = 0
      RowIndex = 0
    end
    object dxtKTerrNameTerr: TdxTreeListColumn
      Caption = #1054#1073#1083#1072#1089#1090#1100' '#1082#1091#1088#1080#1088#1086#1074#1072#1085#1080#1103
      Width = 255
      BandIndex = 0
      RowIndex = 0
    end
    object dxtKTerrId: TdxTreeListColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
    end
  end
  object qrData: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SUBJ_ID'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'fAll'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM SUBJ'
      'WHERE SUBJ_ID = :SUBJ_ID OR 1 = :fAll')
    Left = 44
    Top = 112
  end
  object dsData: TDataSource
    DataSet = qrData
    Left = 44
    Top = 159
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 212
    Top = 128
  end
  object qrINFOload: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SUBJ_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT '
      '  ST.SUBJ_INFO_ID, ST.SUBJ_INFO_NAME, '
      '  SI.ORG_NAME, '
      '  SI.POSITION_NAME, SI.FIO, SI.PHONE,'
      '  SI.POSITION_NAME2, SI.FIO2, SI.PHONE2'
      
        'FROM SUBJ_INFO_TYPE ST LEFT JOIN SUBJ_INFO SI on ST.SUBJ_INFO_ID' +
        ' = SI.SUBJ_INFO_ID'
      'AND SI.SUBJ_ID = :SUBJ_ID')
    Left = 156
    Top = 156
  end
  object qrINFOsave: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
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
      'SELECT * '
      'FROM SUBJ_INFO'
      'WHERE SUBJ_ID = :SUBJ_ID')
    Left = 264
    Top = 140
  end
  object qrPARAMload: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'SUBJ_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT ST.SUBJ_PARAM_ID, ST.SUBJ_PARAM_NAME, SP.PARAM_VALUE'
      
        'FROM SUBJ_PARAM_TYPE ST LEFT JOIN SUBJ_PARAM SP on ST.SUBJ_PARAM' +
        '_ID = SP.SUBJ_PARAM_ID'
      'AND SP.SUBJ_ID = :SUBJ_ID')
    Left = 380
    Top = 72
  end
  object qrPARAMsave: TADOQuery
    Connection = dmMain.dbMain
    CursorType = ctStatic
    DataSource = dsData
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
      'SELECT * '
      'FROM SUBJ_PARAM'
      'WHERE SUBJ_ID = :SUBJ_ID')
    Left = 380
    Top = 116
  end
  object sp_CalcSubjParams: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_CalcSubjParams;1'
    Parameters = <
      item
        Name = 'RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ORG_COUNT'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@PRIVORG_COUNT'
        Attributes = [paNullable]
        DataType = ftInteger
        Direction = pdInputOutput
        Precision = 10
        Value = Null
      end
      item
        Name = '@RAB_COUNT'
        Attributes = [paNullable]
        DataType = ftFloat
        Direction = pdInputOutput
        Value = Null
      end>
    Left = 383
    Top = 159
  end
  object pmKTerr: TPopupMenu
    Left = 120
    Top = 96
    object miKTerr: TMenuItem
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      ShortCut = 13
      OnClick = dxtKTerrDblClick
    end
  end
end

object fmFltMgr: TfmFltMgr
  Left = 270
  Top = 180
  HelpContext = 10
  BorderStyle = bsDialog
  Caption = #1052#1072#1089#1090#1077#1088' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103' '#1074#1099#1073#1086#1088#1082#1080
  ClientHeight = 361
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    535
    361)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlEditSet: TPanel
    Left = 116
    Top = 85
    Width = 317
    Height = 141
    BevelOuter = bvNone
    TabOrder = 6
    Visible = False
    object chkSetEnable: TCheckBox
      Left = 8
      Top = 8
      Width = 161
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
      TabOrder = 0
      OnClick = chkSetEnableClick
    end
    object chkSetNULL: TCheckBox
      Left = 36
      Top = 28
      Width = 201
      Height = 17
      Caption = #1042#1099#1074#1077#1089#1090#1080' '#1085#1077#1079#1072#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1079#1085#1072#1095#1077#1085#1080#1103
      Enabled = False
      TabOrder = 1
    end
    object mmSetValue: TMemo
      Left = 0
      Top = 48
      Width = 317
      Height = 93
      Align = alBottom
      Color = clBtnFace
      Enabled = False
      ScrollBars = ssVertical
      TabOrder = 2
      OnKeyPress = mmSetValueKeyPress
    end
  end
  object pnlEditBoolnDate: TPanel
    Left = 119
    Top = 131
    Width = 265
    Height = 103
    BevelOuter = bvNone
    TabOrder = 14
    Visible = False
    object Label3: TLabel
      Left = 21
      Top = 72
      Width = 9
      Height = 13
      Caption = 'c '
    end
    object Label4: TLabel
      Left = 139
      Top = 72
      Width = 15
      Height = 13
      Caption = #1087#1086' '
    end
    object chkBoolnDate: TCheckBox
      Left = 8
      Top = 8
      Width = 161
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
      TabOrder = 0
      OnClick = chkBoolnDateClick
    end
    object rbBoolnDateYes: TRadioButton
      Left = 32
      Top = 28
      Width = 113
      Height = 17
      Caption = #1044#1072
      Checked = True
      Enabled = False
      TabOrder = 1
      TabStop = True
    end
    object rbBoolnDateNo: TRadioButton
      Left = 32
      Top = 48
      Width = 113
      Height = 17
      Caption = #1053#1077#1090
      Enabled = False
      TabOrder = 2
    end
    object dtBoolnDateFrom: TdxDateEdit
      Left = 36
      Top = 71
      Width = 97
      Enabled = False
      TabOrder = 3
      OnChange = dtDateFromChange
      Date = -700000.000000000000000000
      DateButtons = [btnToday]
      DateOnError = deToday
    end
    object dtBoolnDateTo: TdxDateEdit
      Left = 160
      Top = 71
      Width = 97
      Enabled = False
      TabOrder = 4
      OnChange = dtDateFromChange
      Date = -700000.000000000000000000
      DateButtons = [btnToday]
      DateOnError = deToday
    end
  end
  object pnlEditAspirant: TPanel
    Left = 15
    Top = 127
    Width = 250
    Height = 106
    BevelOuter = bvNone
    TabOrder = 15
    Visible = False
    object chkAspirantEnable: TCheckBox
      Left = 8
      Top = 8
      Width = 161
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
      TabOrder = 0
      OnClick = chkAspirantEnableClick
    end
    object rbAspirantYes: TRadioButton
      Left = 32
      Top = 28
      Width = 113
      Height = 17
      Caption = #1040#1089#1087#1080#1088#1072#1085#1090
      Checked = True
      Enabled = False
      TabOrder = 1
      TabStop = True
    end
    object rbAspirantNo: TRadioButton
      Left = 32
      Top = 48
      Width = 113
      Height = 17
      Caption = #1057#1090#1091#1076#1077#1085#1090
      Enabled = False
      TabOrder = 2
    end
    object rbAspirantNull: TRadioButton
      Left = 32
      Top = 68
      Width = 113
      Height = 17
      Caption = #1053#1077' '#1079#1072#1087#1086#1083#1085#1077#1085#1086
      Enabled = False
      TabOrder = 3
    end
    object rbAspirantNotNull: TRadioButton
      Left = 32
      Top = 88
      Width = 134
      Height = 17
      Caption = #1040#1089#1087#1080#1088#1072#1085#1090' '#1080#1083#1080' '#1089#1090#1091#1076#1077#1085#1090
      Enabled = False
      TabOrder = 4
    end
  end
  object pnlEditBool: TPanel
    Left = 89
    Top = 60
    Width = 250
    Height = 69
    BevelOuter = bvNone
    TabOrder = 5
    Visible = False
    object rbBoolYes: TRadioButton
      Left = 32
      Top = 28
      Width = 113
      Height = 17
      Caption = #1044#1072
      Checked = True
      Enabled = False
      TabOrder = 1
      TabStop = True
    end
    object rbBoolNo: TRadioButton
      Left = 32
      Top = 48
      Width = 113
      Height = 17
      Caption = #1053#1077#1090
      Enabled = False
      TabOrder = 2
    end
    object chkBoolEnable: TCheckBox
      Left = 8
      Top = 8
      Width = 161
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
      TabOrder = 0
      OnClick = chkBoolEnableClick
    end
  end
  object pnlEditList: TPanel
    Left = 96
    Top = 72
    Width = 369
    Height = 209
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    object lvList: TListView
      Left = 0
      Top = 48
      Width = 369
      Height = 161
      Align = alBottom
      Checkboxes = True
      Color = clBtnFace
      Columns = <>
      Enabled = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 2
      ViewStyle = vsReport
      OnColumnClick = lvListColumnClick
      OnCompare = lvListCompare
      OnDblClick = lvListDblClick
      OnResize = lvListResize
    end
    object chkListEnable: TCheckBox
      Left = 8
      Top = 8
      Width = 165
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
      TabOrder = 0
      OnClick = chkListEnableClick
    end
    object chkListNULL: TCheckBox
      Left = 36
      Top = 28
      Width = 193
      Height = 17
      Caption = #1042#1099#1074#1077#1089#1090#1080' '#1085#1077#1079#1072#1087#1086#1083#1085#1077#1085#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
      Enabled = False
      TabOrder = 1
    end
  end
  object pnlEditInt: TPanel
    Left = 36
    Top = 44
    Width = 329
    Height = 121
    BevelOuter = bvNone
    TabOrder = 4
    Visible = False
    object chkIntEnable: TCheckBox
      Left = 8
      Top = 8
      Width = 165
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
      TabOrder = 0
      OnClick = chkIntEnableClick
    end
    object rbIntNotNull: TRadioButton
      Left = 32
      Top = 32
      Width = 113
      Height = 17
      Caption = #1079#1072#1087#1086#1083#1085#1077#1085#1085#1099#1077
      Enabled = False
      TabOrder = 1
      OnClick = rbIntNotNullClick
    end
    object rbIntNull: TRadioButton
      Left = 32
      Top = 52
      Width = 113
      Height = 17
      Caption = #1085#1077' '#1079#1072#1087#1086#1083#1085#1077#1085#1085#1099#1077
      Enabled = False
      TabOrder = 2
      OnClick = rbIntNotNullClick
    end
    object rbIntFromTo: TRadioButton
      Left = 32
      Top = 72
      Width = 113
      Height = 17
      Caption = #1076#1080#1072#1087#1072#1079#1086#1085
      Checked = True
      Enabled = False
      TabOrder = 3
      TabStop = True
      OnClick = rbIntNotNullClick
    end
    object chkIntFrom: TCheckBox
      Left = 48
      Top = 96
      Width = 29
      Height = 17
      Caption = 'c'
      Enabled = False
      TabOrder = 4
      OnClick = chkIntFromClick
    end
    object edIntFrom: TdxEdit
      Left = 84
      Top = 94
      Width = 97
      Enabled = False
      TabOrder = 5
      OnKeyPress = edIntFromKeyPress
      Alignment = taRightJustify
      MaxLength = 10
      StoredValues = 3
    end
    object edIntTo: TdxEdit
      Left = 224
      Top = 94
      Width = 97
      Enabled = False
      TabOrder = 7
      OnKeyPress = edIntFromKeyPress
      Alignment = taRightJustify
      MaxLength = 10
      StoredValues = 3
    end
    object chkIntTo: TCheckBox
      Left = 188
      Top = 96
      Width = 33
      Height = 17
      Caption = #1087#1086
      Enabled = False
      TabOrder = 6
      OnClick = chkIntToClick
    end
  end
  object pnlEditStr: TPanel
    Left = 8
    Top = 24
    Width = 277
    Height = 81
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    DesignSize = (
      277
      81)
    object Label1: TLabel
      Left = 24
      Top = 32
      Width = 66
      Height = 13
      Caption = #1058#1080#1087' '#1091#1089#1083#1086#1074#1080#1103':'
    end
    object Label2: TLabel
      Left = 24
      Top = 56
      Width = 51
      Height = 13
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077':'
    end
    object chkStrEnable: TCheckBox
      Left = 8
      Top = 8
      Width = 169
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
      TabOrder = 0
      OnClick = chkStrEnableClick
    end
    object cbStrType: TComboBox
      Left = 108
      Top = 28
      Width = 157
      Height = 21
      Style = csDropDownList
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Enabled = False
      TabOrder = 1
      OnChange = cbStrTypeChange
      Items.Strings = (
        #1057#1054#1044#1045#1056#1046#1048#1058
        #1053#1045' '#1057#1054#1044#1045#1056#1046#1048#1058
        #1053#1040#1063#1048#1053#1040#1045#1058#1057#1071' '#1057
        #1047#1040#1050#1040#1053#1063#1048#1042#1040#1045#1058#1057#1071' '#1053#1040
        #1056#1040#1042#1053#1054
        #1053#1045' '#1056#1040#1042#1053#1054
        #1047#1040#1055#1054#1051#1053#1045#1053#1054
        #1053#1045' '#1047#1040#1055#1054#1051#1053#1045#1053#1054)
    end
    object edStrValue: TEdit
      Left = 108
      Top = 52
      Width = 157
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Color = clBtnFace
      Enabled = False
      TabOrder = 2
      OnKeyPress = edStrValueKeyPress
    end
  end
  object dxtParams: TdxTreeList
    Left = 0
    Top = 0
    Width = 535
    Height = 306
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    TabOrder = 0
    Images = ImageList1
    Options = [aoColumnSizing, aoColumnMoving, aoEditing, aoTabThrough, aoAutoWidth]
    OptionsEx = [aoUseBitmap, aoBandHeaderWidth, aoAutoCalcPreviewLines, aoBandSizing, aoBandMoving, aoDragScroll, aoDragExpand, aoRowAutoHeight, aoRowSizing, aoShowButtonAlways]
    PaintStyle = psOutlook
    TreeLineColor = clGrayText
    ShowGrid = True
    ShowLines = False
    OnChangeNode = dxtParamsChangeNode
    Anchors = [akLeft, akTop, akRight, akBottom]
    object dxtParamsColumn1: TdxTreeListColumn
      Caption = #1055#1072#1088#1072#1084#1077#1090#1088
      DisableEditor = True
      Width = 212
      BandIndex = 0
      RowIndex = 0
    end
    object dxtParamsValueColumn: TdxTreeListButtonColumn
      Alignment = taLeftJustify
      Caption = #1047#1085#1072#1095#1077#1085#1080#1077
      DisableEditor = True
      ReadOnly = True
      Sizing = False
      VertAlignment = tlCenter
      Width = 250
      BandIndex = 0
      RowIndex = 0
      OnEditButtonClick = dxtParamsValueColumnEditButtonClick
      Buttons = <
        item
          Default = True
          Visible = False
        end>
      HideEditCursor = True
    end
  end
  object btnSaveFlt: TButton
    Left = 8
    Top = 330
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 7
    OnClick = btnSaveFltClick
  end
  object btnOpenFlt: TButton
    Left = 88
    Top = 330
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1047#1072#1075#1088#1091#1079#1080#1090#1100
    TabOrder = 8
    OnClick = btnOpenFltClick
  end
  object btnOk: TButton
    Left = 373
    Top = 330
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 11
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 453
    Top = 330
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 12
  end
  object pnlEditDate: TPanel
    Left = 44
    Top = 75
    Width = 329
    Height = 121
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object chkDateEnable: TCheckBox
      Left = 8
      Top = 8
      Width = 169
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1102
      TabOrder = 0
      OnClick = chkDateEnableClick
    end
    object rbDateNotNull: TRadioButton
      Left = 32
      Top = 32
      Width = 100
      Height = 17
      Caption = #1079#1072#1087#1086#1083#1085#1077#1085#1086
      Enabled = False
      TabOrder = 1
      OnClick = rbDateNotNullClick
    end
    object rbDateNull: TRadioButton
      Left = 32
      Top = 52
      Width = 100
      Height = 17
      Caption = #1085#1077' '#1079#1072#1087#1086#1083#1085#1077#1085#1086
      Enabled = False
      TabOrder = 2
      OnClick = rbDateNotNullClick
    end
    object rbDateFromTo: TRadioButton
      Left = 32
      Top = 72
      Width = 100
      Height = 17
      Caption = #1076#1080#1072#1087#1072#1079#1086#1085
      Checked = True
      Enabled = False
      TabOrder = 3
      TabStop = True
      OnClick = rbDateNotNullClick
    end
    object chkDateFrom: TCheckBox
      Left = 48
      Top = 96
      Width = 37
      Height = 17
      Caption = 'c'
      Enabled = False
      TabOrder = 4
      OnClick = chkDateFromClick
    end
    object chkDateTo: TCheckBox
      Left = 188
      Top = 96
      Width = 37
      Height = 17
      Caption = #1087#1086
      Enabled = False
      TabOrder = 6
      OnClick = chkDateToClick
    end
    object dtDateFrom: TdxDateEdit
      Left = 84
      Top = 94
      Width = 97
      Enabled = False
      TabOrder = 5
      OnChange = dtDateFromChange
      Date = -700000.000000000000000000
      DateButtons = [btnToday]
    end
    object dtDateTo: TdxDateEdit
      Left = 224
      Top = 94
      Width = 97
      Enabled = False
      TabOrder = 7
      OnChange = dtDateFromChange
      Date = -700000.000000000000000000
      DateButtons = [btnToday]
    end
  end
  object btnClear: TButton
    Left = 168
    Top = 330
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = '&'#1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 9
    OnClick = btnClearClick
  end
  object pnlEditOk: TPanel
    Left = 340
    Top = 224
    Width = 185
    Height = 41
    BevelOuter = bvNone
    TabOrder = 13
    Visible = False
    DesignSize = (
      185
      41)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 185
      Height = 9
      Align = alTop
      Shape = bsTopLine
    end
    object btnEditOk: TButton
      Left = 23
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnEditCancel: TButton
      Left = 104
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ModalResult = 2
      TabOrder = 1
    end
  end
  object chkNewWindow: TCheckBox
    Left = 376
    Top = 309
    Width = 133
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1085#1086#1074#1086#1077' '#1086#1082#1085#1086
    TabOrder = 10
  end
  object ImageList1: TImageList
    Left = 420
    Top = 68
    Bitmap = {
      494C010103000500C80010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FCB500000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C0008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000FF000000FF000000FF000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C0008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FCB50000FCB5000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0C0C0008080000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF000000FF000000FF000000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF800000FF800000FF800000FF000000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000808000008080000080800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCB5
      0000000000000000000000000000FCB500000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FF800000FF800000FF800000FF800000FF000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C00080800000808000008080000080800000808000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCB5
      000000000000000000000000000000000000FCB5000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FF800000FF800000FF800000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C0C0C000C0C0C00080800000808000008080000080800000808000008080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCB5
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00C3FFFFFFFFFF0000C381FFFFFF3F0000
      C381FFFFFE3F0000F781FFFFFC3F00008181FC3FFC3F00008001F81FFC3F0000
      8181F81FFC3F000081FFF81FF81F0000EEFFF81FF00F0000EF03FC3FE0070000
      EF83FFFFC00300008383FFFF800100008383FFFFE007000083FFFFFFFFFF0000
      83FFFFFFFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object dlgOpen: TOpenDialog
    DefaultExt = 'flt'
    Filter = #1060#1072#1081#1083#1099' '#1092#1080#1083#1100#1090#1088#1086#1074' (*.flt)|*.flt'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 212
    Top = 196
  end
  object dlgSave: TSaveDialog
    DefaultExt = 'flt'
    Filter = #1060#1072#1081#1083#1099' '#1092#1080#1083#1100#1090#1088#1086#1074' (*.flt)|*.flt'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 272
    Top = 196
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 372
    Top = 28
  end
end

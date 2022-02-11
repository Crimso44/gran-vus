object fmRegister: TfmRegister
  Left = 356
  Top = 175
  HelpContext = 3
  ActiveControl = dxDBGrid1
  BorderStyle = bsDialog
  Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1087#1088#1086#1076#1091#1082#1090#1072
  ClientHeight = 565
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    510
    565)
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 12
    Top = 12
    Width = 52
    Height = 16
    Caption = #1055#1088#1086#1076#1091#1082#1090':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbProductCode: TLabel
    Left = 116
    Top = 12
    Width = 61
    Height = 16
    Caption = '0000-0704'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbProductName: TLabel
    Left = 116
    Top = 32
    Width = 54
    Height = 16
    Caption = #1043#1088#1072#1085'-'#1042#1059#1056
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbProductVersion: TLabel
    Left = 116
    Top = 52
    Width = 25
    Height = 16
    Caption = '3.72'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbDemoVersion: TLabel
    Left = 116
    Top = 72
    Width = 176
    Height = 16
    Caption = '- '#1044#1077#1084#1086#1085#1089#1090#1088#1072#1094#1080#1086#1085#1085#1072#1103' '#1074#1077#1088#1089#1080#1103' -'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 12
    Top = 100
    Width = 87
    Height = 32
    Caption = #1051#1080#1094#1077#1085#1079#1080#1086#1085#1085#1099#1081#13#10#1094#1077#1085#1090#1088':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbCompanyName: TLabel
    Left = 116
    Top = 100
    Width = 127
    Height = 16
    Caption = #1043#1053#1055#1055' "'#1043#1088#1072#1085#1080#1090'-'#1062#1077#1085#1090#1088'"'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbCompanyAddress: TLabel
    Left = 116
    Top = 120
    Width = 226
    Height = 16
    Caption = '109147, '#1052#1086#1089#1082#1074#1072', '#1091#1083'. '#1042#1086#1088#1086#1085#1094#1086#1074#1089#1082#1072#1103', 23'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbCompanyPhone: TLabel
    Left = 116
    Top = 140
    Width = 191
    Height = 16
    Caption = #1090#1077#1083'. 645-84-72, '#1092#1072#1082#1089'. 645-84-73'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbCompanyUrl: TLabel
    Left = 116
    Top = 164
    Width = 72
    Height = 16
    Caption = 'vus.granit.ru'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lbCompanyUrlClick
    OnMouseEnter = lbCompanyUrlMouseEnter
    OnMouseLeave = lbCompanyUrlMouseLeave
  end
  object lbCompanyMail: TLabel
    Left = 116
    Top = 184
    Width = 79
    Height = 16
    Caption = 'vur@granit.ru'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    OnClick = lbCompanyMailClick
    OnMouseEnter = lbCompanyUrlMouseEnter
    OnMouseLeave = lbCompanyUrlMouseLeave
  end
  object Bevel1: TBevel
    Left = 8
    Top = 212
    Width = 494
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label3: TLabel
    Left = 12
    Top = 220
    Width = 188
    Height = 16
    Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1099#1077' '#1083#1080#1094#1077#1085#1079#1080#1080':'
  end
  object Label4: TLabel
    Left = 12
    Top = 384
    Width = 131
    Height = 16
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1083#1080#1094#1077#1085#1079#1080#1080
  end
  object Bevel2: TBevel
    Left = 152
    Top = 390
    Width = 349
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object Label5: TLabel
    Left = 28
    Top = 408
    Width = 77
    Height = 16
    Caption = #1050#1086#1076' '#1079#1072#1087#1088#1086#1089#1072':'
  end
  object Label6: TLabel
    Left = 28
    Top = 436
    Width = 101
    Height = 16
    Caption = #1050#1083#1102#1095' '#1072#1082#1090#1080#1074#1072#1094#1080#1080':'
  end
  object Shape1: TShape
    Left = 36
    Top = 470
    Width = 401
    Height = 1
    Brush.Style = bsClear
  end
  object sbPasteKey: TSpeedButton
    Left = 472
    Top = 460
    Width = 25
    Height = 25
    Flat = True
    Glyph.Data = {
      AA030000424DAA03000000000000360000002800000011000000110000000100
      1800000000007403000000000000000000000000000000000000D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC
      A47A7AAF7A6FAF7A6FAF7A6FAF7A6FAF7A6FAF7A6FAF7A6FAF7A6FD8E9ECD8E9
      EC00D8E9ECD8E9ECAFDAEF049ACF049ACF049ACFAF847AFACFA4FACFA4FACFA4
      FACFA4FACFA4FACFA4FACFBAAF7A6FD8E9ECD8E9EC00D8E9ECC4EFFA049ACF6F
      DAEF6FDAEF6FDAEFAF847AFAEFE4FAEFE4FAEFE4FAEFE4FAEFE4FAEFE4FACFBA
      AF7A6FD8E9ECD8E9EC00D8E9EC44AFDA8FFAFA6FDAEF6FDAEF6FDAEFBA8F7AFA
      EFE4FAEFE4FAEFE4FAEFE4FAEFE4FAEFE4FACFBAAF7A6FD8E9ECD8E9EC00D8E9
      EC44AFDA8FFAFA7ADAFA7ADAFA7ADAFAC48F84FAEFE4FADAAFFACFA4FACFA4FA
      CFA4FACFA4FADAC4AF7A6FD8E9ECD8E9EC00D8E9EC44AFDA8FFAFA84E4FA84E4
      FA84E4FAC48F84FAEFE4FAEFE4FAEFE4FAEFE4FAEFE4FAEFE4FADAC4AF7A6FD8
      E9ECD8E9EC00D8E9EC44AFDA9AFAFA8FEFFA8FEFFA8FEFFAC49A84FAEFE4FADA
      AFFADAAFFADAAFFADAAFFACFA4FACFC4AF7A6FD8E9ECD8E9EC00D8E9EC44AFDA
      9AFAFA8FFAFA8FFAFA8FFAFACF9A84FAEFE4FAEFE4FAEFE4FAEFE4FAEFE4FAE4
      CFFAAFAFAF7A6FD8E9ECD8E9EC00D8E9EC44AFDABAFAEF9AFAFA9AFAFA9AFAFA
      CF9A84FAFAEFFAFAFAFAFAFAFAFAEFFAFAEFAF7A6FAF7A6FAF7A6FD8E9ECD8E9
      EC00D8E9EC44AFDAC4EFFA9AFAFA9AFAFA9AFAFADAA484FAFAFAFAFAFAFAFAFA
      FAFAFAFAEFE4AF7A6FDABAA4D8E9ECD8E9ECD8E9EC00D8E9EC44AFDACFFAFABA
      FAEFBAFAEFBAFAEFDAAF8FDAA484DAA484DAA484DAA484DAA484AF7A6FD8E9EC
      D8E9ECD8E9ECD8E9EC00D8E9EC44AFDADAFAFACFFAFA9AE4EF9AE4EF9AE4EF9A
      E4EF9AE4EF9AE4EFC4EFFACFFAFA049ACFD8E9ECD8E9ECD8E9ECD8E9EC00D8E9
      EC44AFDAFAFAFACFDACFA48F84A48F84A48F84A48F84A48F84A48F84A4A4A4CF
      EFEF049ACFD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC44AFDA64C4E4849A
      84CFBAC4DADADADADADADADADA849A842F9AC41AA4CFA4DAE4D8E9ECD8E9ECD8
      E9ECD8E9EC00D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECA48F84AF9A8FAF9A8FAF9A
      8FBABABAD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9EC00D8E9ECD8E9EC
      D8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9ECD8E9
      ECD8E9ECD8E9ECD8E9ECD8E9EC00}
    Visible = False
  end
  object Bevel3: TBevel
    Left = 8
    Top = 520
    Width = 493
    Height = 9
    Anchors = [akLeft, akTop, akRight]
    Shape = bsTopLine
  end
  object btnLicenceDel: TButton
    Left = 384
    Top = 220
    Width = 109
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Enabled = False
    TabOrder = 0
    Visible = False
    OnClick = btnLicenceDelClick
  end
  object dxDBGrid1: TdxDBGrid
    Left = 12
    Top = 252
    Width = 486
    Height = 121
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'RecId'
    SummaryGroups = <>
    SummarySeparator = ', '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Microsoft Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -11
    BandFont.Name = 'Microsoft Sans Serif'
    BandFont.Style = []
    DataSource = dsKeys
    Filter.Criteria = {00000000}
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Microsoft Sans Serif'
    HeaderFont.Style = []
    LookAndFeel = lfUltraFlat
    OptionsBehavior = [edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -13
    PreviewFont.Name = 'Tahoma'
    PreviewFont.Style = []
    Anchors = [akLeft, akTop, akRight]
    object dxDBGrid1RecId: TdxDBGridColumn
      Visible = False
      Width = 53
      BandIndex = 0
      RowIndex = 0
      FieldName = 'RecId'
    end
    object dxDBGrid1licence_number: TdxDBGridMaskColumn
      Caption = #8470' '#1083#1080#1094#1077#1085#1079#1080#1080
      Width = 75
      BandIndex = 0
      RowIndex = 0
      FieldName = 'licence_number'
    end
    object dxDBGrid1licence_count: TdxDBGridMaskColumn
      Caption = #1050#1086#1083'-'#1074#1086' '#1083#1080#1094#1077#1085#1079#1080#1081
      Width = 97
      BandIndex = 0
      RowIndex = 0
      FieldName = 'licence_count'
    end
    object dxDBGrid1validity_date: TdxDBGridDateColumn
      Alignment = taCenter
      Caption = #1044#1077#1081#1089#1090#1074#1080#1090#1077#1083#1077#1085' '#1076#1086
      Sorted = csDown
      Width = 98
      BandIndex = 0
      RowIndex = 0
      FieldName = 'validity_date'
    end
    object dxDBGrid1certificate_key: TdxDBGridMaskColumn
      Caption = #1050#1083#1102#1095' '#1072#1082#1090#1080#1074#1072#1094#1080#1080
      Width = 209
      BandIndex = 0
      RowIndex = 0
      FieldName = 'certificate_key'
    end
  end
  object edRequestCode: TEdit
    Left = 128
    Top = 406
    Width = 365
    Height = 19
    TabStop = False
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
    Text = 'XXXX-XXXX-XXXX-XXXX'
  end
  object edKey1: TEdit
    Tag = 5
    Left = 28
    Top = 460
    Width = 69
    Height = 24
    CharCase = ecUpperCase
    MaxLength = 5
    TabOrder = 3
    OnChange = edKey1Change
  end
  object edKey2: TEdit
    Tag = 5
    Left = 104
    Top = 460
    Width = 69
    Height = 24
    CharCase = ecUpperCase
    MaxLength = 5
    TabOrder = 4
    OnChange = edKey1Change
  end
  object edKey3: TEdit
    Tag = 5
    Left = 180
    Top = 460
    Width = 69
    Height = 24
    CharCase = ecUpperCase
    MaxLength = 5
    TabOrder = 5
    OnChange = edKey1Change
  end
  object edKey4: TEdit
    Tag = 5
    Left = 256
    Top = 460
    Width = 69
    Height = 24
    CharCase = ecUpperCase
    MaxLength = 5
    TabOrder = 6
    OnChange = edKey1Change
  end
  object edKey5: TEdit
    Tag = 5
    Left = 332
    Top = 460
    Width = 69
    Height = 24
    CharCase = ecUpperCase
    MaxLength = 5
    TabOrder = 7
    OnChange = edKey1Change
  end
  object edKey6: TEdit
    Tag = 4
    Left = 408
    Top = 460
    Width = 61
    Height = 24
    CharCase = ecUpperCase
    MaxLength = 4
    TabOrder = 8
    OnChange = edKey1Change
  end
  object btnLicenceAdd: TButton
    Left = 28
    Top = 488
    Width = 145
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1083#1080#1094#1077#1085#1079#1080#1102
    Enabled = False
    TabOrder = 9
    OnClick = btnLicenceAddClick
  end
  object btnRunInDemo: TButton
    Left = 28
    Top = 532
    Width = 301
    Height = 25
    Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1074' '#1076#1077#1084#1086#1085#1089#1090#1088#1072#1094#1080#1086#1085#1085#1086#1084' '#1088#1077#1078#1080#1084#1077
    TabOrder = 10
    OnClick = btnRunInDemoClick
  end
  object btnClose: TButton
    Left = 396
    Top = 532
    Width = 103
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 11
    OnClick = btnCloseClick
  end
  object memKeys: TdxMemData
    Active = True
    Indexes = <>
    SortOptions = []
    AfterPost = memKeysAfterPost
    AfterDelete = memKeysAfterPost
    Left = 72
    Top = 280
    object memKeyslicence_number: TIntegerField
      FieldName = 'licence_number'
      DisplayFormat = '0000000'
    end
    object memKeyslicence_count: TIntegerField
      FieldName = 'licence_count'
    end
    object memKeysvalidity_date: TDateTimeField
      FieldName = 'validity_date'
    end
    object memKeyscertificate_key: TStringField
      FieldName = 'certificate_key'
      OnGetText = memKeyscertificate_keyGetText
      Size = 50
    end
  end
  object dsKeys: TDataSource
    DataSet = memKeys
    Left = 116
    Top = 300
  end
end

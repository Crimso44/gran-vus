object fmReg: TfmReg
  Left = 381
  Top = 336
  BorderStyle = bsDialog
  Caption = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1087#1088#1086#1076#1091#1082#1090#1072
  ClientHeight = 526
  ClientWidth = 513
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 12
    Top = 16
    Width = 59
    Height = 14
    Caption = #1055#1088#1086#1076#1091#1082#1090':'
  end
  object lbCode: TLabel
    Left = 120
    Top = 16
    Width = 44
    Height = 14
    Caption = 'lbCode'
  end
  object lbAddr: TLabel
    Left = 120
    Top = 124
    Width = 317
    Height = 14
    Caption = '115088, '#1052#1086#1089#1082#1074#1072', '#1091#1083'.'#1053#1086#1074#1086#1086#1089#1090#1072#1087#1086#1074#1089#1082#1072#1103', '#1076'.5, '#1089#1090#1088'.14'
  end
  object lbPhone: TLabel
    Left = 120
    Top = 144
    Width = 330
    Height = 14
    Caption = '(495) 911-0239; (495) 911-0106; '#1092'.(495) 911-0258'
  end
  object lbUrl: TLabel
    Left = 120
    Top = 168
    Width = 140
    Height = 16
    Cursor = crHandPoint
    Caption = 'http://www.granit.ru'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = lbUrlClick
    OnMouseEnter = lbUrlMouseEnter
    OnMouseLeave = lbUrlMouseLeave
  end
  object Bevel1: TBevel
    Left = 12
    Top = 212
    Width = 493
    Height = 9
    Shape = bsTopLine
  end
  object lbProduct: TLabel
    Left = 120
    Top = 36
    Width = 385
    Height = 49
    AutoSize = False
    Caption = 'lbProduct'
    WordWrap = True
  end
  object lbDemo: TLabel
    Left = 120
    Top = 84
    Width = 192
    Height = 14
    Caption = '- '#1044#1077#1084#1086#1085#1089#1090#1088#1072#1094#1080#1086#1085#1085#1072#1103' '#1074#1077#1088#1089#1080#1103' -'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clActiveCaption
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 12
    Top = 104
    Width = 97
    Height = 28
    Caption = #1051#1080#1094#1077#1085#1079#1080#1086#1085#1085#1099#1081#13#10#1094#1077#1085#1090#1088':'
  end
  object lbCompany: TLabel
    Left = 120
    Top = 104
    Width = 133
    Height = 14
    Caption = #1053#1055#1055' "'#1043#1088#1072#1085#1080#1090' '#1062#1077#1085#1090#1088'"'
  end
  object lbMail: TLabel
    Tag = 1
    Left = 120
    Top = 188
    Width = 107
    Height = 16
    Cursor = crHandPoint
    Caption = 'granit@granit.ru'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHighlight
    Font.Height = -13
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    OnClick = lbUrlClick
    OnMouseEnter = lbUrlMouseEnter
    OnMouseLeave = lbUrlMouseLeave
  end
  object Label2: TLabel
    Left = 12
    Top = 216
    Width = 209
    Height = 14
    Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1099#1077' '#1083#1080#1094#1077#1085#1079#1080#1080':'
  end
  object Label4: TLabel
    Left = 12
    Top = 364
    Width = 145
    Height = 14
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1083#1080#1094#1077#1085#1079#1080#1080
  end
  object Bevel2: TBevel
    Left = 168
    Top = 372
    Width = 333
    Height = 13
    Shape = bsTopLine
  end
  object Label5: TLabel
    Left = 32
    Top = 388
    Width = 85
    Height = 14
    Caption = #1050#1086#1076' '#1079#1072#1087#1088#1086#1089#1072':'
  end
  object Label6: TLabel
    Left = 32
    Top = 412
    Width = 113
    Height = 14
    Caption = #1050#1083#1102#1095' '#1072#1082#1090#1080#1074#1072#1094#1080#1080':'
  end
  object Label7: TLabel
    Left = 96
    Top = 436
    Width = 13
    Height = 14
    Caption = ' - '
  end
  object Label8: TLabel
    Left = 172
    Top = 436
    Width = 13
    Height = 14
    Caption = ' - '
  end
  object Label9: TLabel
    Left = 248
    Top = 436
    Width = 13
    Height = 14
    Caption = ' - '
  end
  object Label10: TLabel
    Left = 324
    Top = 436
    Width = 13
    Height = 14
    Caption = ' - '
  end
  object Label11: TLabel
    Left = 400
    Top = 436
    Width = 13
    Height = 14
    Caption = ' - '
  end
  object BtnPaste: TSpeedButton
    Left = 468
    Top = 432
    Width = 23
    Height = 22
    Hint = #1042#1089#1090#1072#1074#1080#1090#1100' '#1080#1079' '#1073#1091#1092#1077#1088#1072
    Flat = True
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000000000040404009A2F
      0400A4440400AF440400AF4F0400BA4F0400BA5A040004640400C4640400CF64
      0400046F0400DA6F0400DA7A040004840400E4840400EF840400049A0400AF5A
      0F00CF6F0F00047A0F000F7A0F000F9A0F0004AF0F009A441A00AF5A1A001A7A
      1A000F841A0024A41A001A7A24001A8F2400A45A2F002F7A2F002F842F001AAF
      2F0044AF2F000FBA2F00BA6F3A000F7A3A002F843A003A8F3A001ABA3A00DA8F
      44001ABA44005A5A4F00AF6F4F00BA7A4F002FAF4F0024C44F008F645A00846F
      5A00BA7A5A005A9A5A0084A45A00EFA45A0024BA5A009A6464009A6F6400E4A4
      6400FABA640044C464003ACF64009A6F6F00A46F6F00AF7A6F009A846F00AF84
      6F00648F6F002FC46F003AC46F006FC46F003ACF6F00A47A7A00AF7A7A00AF84
      7A00BA8F7A00AF9A7A0044DA7A004FE47A00AF7A8400BA8484009A8F8400A48F
      8400C48F8400849A8400C49A8400CF9A8400DAA48400E4AF840084BA84004FE4
      84008F8F8F00A48F8F00BA8F8F00A49A8F00AF9A8F00DAAF8F00E4AF8F00CFBA
      8F00EFBA8F00EFC48F005AEF8F009A8F9A00BA8F9A009A9A9A00CF9A9A00AFA4
      9A00CFAF9A00DAAF9A009ABA9A00BABA9A00EFC49A00EFCF9A00847AA400A4A4
      A400DABAA400E4CFA400FACFA4007ADAA40084DAA4008FDAA400AFDAA400FADA
      A400AFAFAF00DAAFAF00FAAFAF00EFBAAF00FADAAF009AE4AF000484BA000F9A
      BA004F9ABA0064BABA00AFBABA00BABABA00CFC4BA00FAC4BA00FACFBA00BADA
      BA00FADABA00FAEFBA004F7AC4000F8FC4002F9AC400CFBAC400C4C4C400DAC4
      C400E4C4C400FAC4C400FACFC400FADAC400FAEFC400FAFAC400042FCF000F8F
      CF00049ACF001AA4CF002FA4CF008FBACF00BABACF00AFC4CF00CFCFCF00E4CF
      CF00CFDACF00FAE4CF00FAEFCF00042FDA003A5ADA004464DA001A9ADA0024A4
      DA0024AFDA003AAFDA0044AFDA002FBADA004FBADA00DACFDA00DADADA00E4DA
      DA00EFDADA00FAEFDA00042FE4002444E4005A7AE4003AAFE4003ABAE400AFBA
      E40064C4E4007AC4E40084CFE4009ACFE400CFCFE400A4DAE400BADAE400DAE4
      E400E4E4E400EFE4E400FAEFE400042FEF000F3AEF002F5AEF00647AEF006F84
      EF003A8FEF008FA4EF008FBAEF004FC4EF005AC4EF008FCFEF00BACFEF006FDA
      EF008FDAEF00AFDAEF009AE4EF00DAE4EF00CFEFEF00E4EFEF00EFEFEF00BAFA
      EF00FAFAEF00042FFA000F44FA001A4FFA002F5AFA000F64FA00446FFA004F7A
      FA007A8FFA003A9AFA00849AFA008FA4FA0044AFFA004FAFFA004FBAFA005ABA
      FA006FBAFA0064C4FA000FCFFA0064CFFA0084CFFA009ACFFA002FDAFA007ADA
      FA0084DAFA009ADAFA0084E4FA009AE4FA00AFE4FA008FEFFA00A4EFFA00C4EF
      FA007AFAFA008FFAFA009AFAFA00CFFAFA00DAFAFA00FAFAFA00D7D7D7D7D7D7
      D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7D7473F3F3F3F3F3F3F3FD7D7D7D39A9A9A
      49747474747474883FD7D7F99AD1D1D149C4C4C4C4C4C4883FD7D7ACFBD1D1D1
      4AC4C4C4C4C4C4883FD7D7ACFBF1F1F152C47E74747474953FD7D7ACFBF4F4F4
      52C4C4C4C4C4C4953FD7D7ACFCF7F7F754C47E7E7E7E74943FD7D7ACFCFBFBFB
      55C4C4C4C4C4A37C3FD7D7ACD9FCFCFC55DAFFFFDADA3F3F3FD7D7ACF9FCFCFC
      56FFFFFFFFC43F72D7D7D7ACFDD9D9D95F56565656563FD7D7D7D7ACFEFDD4D4
      D4D4D4D4F9FD9AD7D7D7D7ACFFA251515151515171D69AD7D7D7D7D7ACBA538F
      B0B0B0538E9BBFD7D7D7D7D7D7D7D7515E5E5E85D7D7D7D7D7D7}
    ParentShowHint = False
    ShowHint = True
    OnClick = BtnPasteClick
  end
  object Bevel3: TBevel
    Left = 12
    Top = 488
    Width = 493
    Height = 10
    Shape = bsTopLine
  end
  object dxDBGrid1: TdxDBGrid
    Left = 12
    Top = 244
    Width = 493
    Height = 113
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    KeyField = 'CertificateKey'
    SummaryGroups = <>
    SummarySeparator = ', '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -13
    BandFont.Name = 'Verdana'
    BandFont.Style = []
    DataSource = dsList
    Filter.Criteria = {00000000}
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = []
    LookAndFeel = lfUltraFlat
    OptionsBehavior = [edgoAutoCopySelectedToClipboard, edgoAutoSearch, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
    OptionsDB = [edgoCancelOnExit, edgoCanDelete, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoLoadAllRecords, edgoUseBookmarks]
    OptionsView = [edgoAutoWidth, edgoBandHeaderWidth, edgoDrawEndEllipsis, edgoUseBitmap]
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -13
    PreviewFont.Name = 'Verdana'
    PreviewFont.Style = []
    OnCustomDrawCell = dxDBGrid1CustomDrawCell
    object dxDBGrid1ProductCode: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 53
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ProductCode'
    end
    object dxDBGrid1LicenseNumber: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 72
      BandIndex = 0
      RowIndex = 0
      FieldName = 'LicenceNumber'
    end
    object dxDBGrid1LicenseCount: TdxDBGridMaskColumn
      HeaderAlignment = taCenter
      Width = 91
      BandIndex = 0
      RowIndex = 0
      FieldName = 'LicenceCount'
    end
    object dxDBGrid1ValidityDate: TdxDBGridDateColumn
      HeaderAlignment = taCenter
      Width = 98
      BandIndex = 0
      RowIndex = 0
      FieldName = 'ValidityDate'
    end
    object dxDBGrid1CertificateKey: TdxDBGridMaskColumn
      Width = 177
      BandIndex = 0
      RowIndex = 0
      FieldName = 'CertificateKey'
    end
  end
  object Button1: TButton
    Left = 404
    Top = 384
    Width = 97
    Height = 25
    Caption = #1055#1086#1083#1091#1095#1080#1090#1100
    TabOrder = 3
    Visible = False
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 32
    Top = 432
    Width = 66
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 4
    OnChange = Edit1Change
    OnKeyDown = Edit1KeyDown
  end
  object Edit2: TEdit
    Left = 108
    Top = 432
    Width = 66
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 5
    OnChange = Edit1Change
    OnKeyDown = Edit1KeyDown
  end
  object Edit3: TEdit
    Left = 184
    Top = 432
    Width = 66
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 6
    OnChange = Edit1Change
    OnKeyDown = Edit1KeyDown
  end
  object Edit4: TEdit
    Left = 260
    Top = 432
    Width = 66
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 7
    OnChange = Edit1Change
    OnKeyDown = Edit1KeyDown
  end
  object Edit5: TEdit
    Left = 336
    Top = 432
    Width = 66
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 8
    OnChange = Edit1Change
    OnKeyDown = Edit1KeyDown
  end
  object Edit6: TEdit
    Left = 412
    Top = 432
    Width = 53
    Height = 21
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 4
    ParentFont = False
    TabOrder = 9
    OnChange = Edit1Change
    OnKeyDown = Edit1KeyDown
  end
  object Button2: TButton
    Left = 32
    Top = 456
    Width = 145
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1083#1080#1094#1077#1085#1079#1080#1102
    Enabled = False
    TabOrder = 10
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 404
    Top = 496
    Width = 97
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 12
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 408
    Top = 216
    Width = 97
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Enabled = False
    TabOrder = 1
    OnClick = Button4Click
  end
  object lbControl: TEdit
    Left = 128
    Top = 388
    Width = 269
    Height = 22
    TabStop = False
    BorderStyle = bsNone
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 2
  end
  object Button5: TButton
    Left = 32
    Top = 496
    Width = 309
    Height = 25
    Caption = #1055#1088#1086#1076#1086#1083#1078#1080#1090#1100' '#1074' '#1076#1077#1084#1086#1085#1089#1090#1088#1072#1094#1080#1086#1085#1085#1086#1084' '#1088#1077#1078#1080#1084#1077
    ModalResult = 5
    TabOrder = 11
  end
  object MainConn: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=GranKadr;Data Source=GR-MATVEEV'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 440
    Top = 12
  end
  object spList: TADOQuery
    Connection = MainConn
    CursorType = ctStatic
    LockType = ltReadOnly
    BeforeOpen = spListBeforeOpen
    AfterOpen = spListAfterOpen
    AfterScroll = spListAfterScroll
    Parameters = <
      item
        Name = 'code'
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 2049
      end>
    SQL.Strings = (
      'exec master..xp_crypt_list :code')
    Left = 428
    Top = 128
    object spListLicenseNumber: TIntegerField
      DisplayLabel = #8470' '#1083#1080#1094#1077#1085#1079#1080#1080
      FieldName = 'LicenceNumber'
    end
    object spListLicenceCount: TIntegerField
      DisplayLabel = #1050#1086#1083'-'#1074#1086' '#1083#1080#1094#1077#1085#1079#1080#1081
      FieldName = 'LicenceCount'
    end
    object spListValidityDate: TDateTimeField
      DisplayLabel = #1044#1077#1081#1089#1090#1074#1080#1090#1077#1083#1077#1085' '#1076#1086
      FieldName = 'ValidityDate'
      DisplayFormat = 'dd.mm.yyyy'
    end
    object spListCertificateKey: TStringField
      DisplayLabel = #1050#1083#1102#1095' '#1072#1082#1090#1080#1074#1072#1094#1080#1080
      FieldName = 'CertificateKey'
      OnGetText = spListCertificateKeyGetText
      Size = 29
    end
    object spListProductCode: TIntegerField
      DisplayLabel = #1055#1088#1086#1076#1091#1082#1090
      FieldName = 'ProductCode'
      ReadOnly = True
      OnGetText = spListProductCodeGetText
    end
  end
  object dsList: TDataSource
    DataSet = spList
    Left = 456
    Top = 128
  end
  object spPrep: TADOQuery
    Connection = MainConn
    LockType = ltReadOnly
    Parameters = <>
    SQL.Strings = (
      'exec master..xp_crypt_prepare')
    Left = 428
    Top = 160
    object spPrepHardwareKey: TIntegerField
      FieldName = 'HardwareKey'
    end
    object spPrepControlKey: TIntegerField
      FieldName = 'ControlKey'
    end
  end
  object spAdd: TADOQuery
    Connection = MainConn
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'control'
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'cert'
        DataType = ftString
        Size = 29
        Value = Null
      end
      item
        Name = 'val'
        DataType = ftString
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'EXEC master..xp_crypt_add :control, :cert, :val')
    Left = 456
    Top = 160
  end
  object spRem: TADOQuery
    Connection = MainConn
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'cert'
        DataType = ftString
        Size = 29
        Value = Null
      end>
    SQL.Strings = (
      'exec master..xp_crypt_remove :cert')
    Left = 428
    Top = 188
  end
end

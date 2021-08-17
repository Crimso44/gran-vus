object fmCorrectOkved: TfmCorrectOkved
  Left = 0
  Top = 0
  Caption = #1059#1090#1086#1095#1085#1077#1085#1080#1077' '#1042#1069#1044' '#1087#1088#1080' '#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1080' '#1087#1086' '#1055#1044#1055
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 0
    Top = 25
    Width = 635
    Height = 275
    Align = alClient
    TabOrder = 0
    object cxGrid1DBTableView1: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      OnCellDblClick = cxGrid1DBTableView1CellDblClick
      DataController.DataSource = DataSource1
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnGrouping = False
      OptionsData.Deleting = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1RecId: TcxGridDBColumn
        DataBinding.FieldName = 'RecId'
        Visible = False
      end
      object cxGrid1DBTableView1pers_id: TcxGridDBColumn
        DataBinding.FieldName = 'pers_id'
        Visible = False
      end
      object cxGrid1DBTableView1Fixed: TcxGridDBColumn
        Caption = #1059#1090#1086#1095#1085#1077#1085
        DataBinding.FieldName = 'Fixed'
        Width = 49
      end
      object cxGrid1DBTableView1fio: TcxGridDBColumn
        Caption = #1060#1048#1054
        DataBinding.FieldName = 'fio'
        Width = 200
      end
      object cxGrid1DBTableView1Broned: TcxGridDBColumn
        Caption = #1047#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085
        DataBinding.FieldName = 'Broned'
        Width = 94
      end
      object cxGrid1DBTableView1okpdtr: TcxGridDBColumn
        Caption = #1050#1086#1076' '#1054#1050#1055#1044#1058#1056
        DataBinding.FieldName = 'okpdtr'
        Width = 87
      end
      object cxGrid1DBTableView1okpdtr_name: TcxGridDBColumn
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1054#1050#1055#1044#1058#1056
        DataBinding.FieldName = 'okpdtr_name'
        Width = 235
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBTableView1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 25
    Hint = #1054#1073#1085#1086#1074#1080#1090#1100
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 4
      Top = 4
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF33339993707399933333773337F3777FF3399933000339
        9933377333777F3377F3399333707333993337733337333337FF993333333333
        399377F33333F333377F993333303333399377F33337FF333373993333707333
        333377F333777F333333993333101333333377F333777F3FFFFF993333000399
        999377FF33777F77777F3993330003399993373FF3777F37777F399933000333
        99933773FF777F3F777F339993707399999333773F373F77777F333999999999
        3393333777333777337333333999993333333333377777333333}
      NumGlyphs = 2
      OnClick = SpeedButton1Click
    end
  end
  object dxMemData1: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 240
    Top = 104
    object dxMemData1pers_id: TIntegerField
      FieldName = 'pers_id'
      KeyFields = 'pers_id'
    end
    object dxMemData1fio: TStringField
      FieldName = 'fio'
      Size = 1000
    end
    object dxMemData1okpdtr: TStringField
      FieldName = 'okpdtr'
      Size = 255
    end
    object dxMemData1okpdtr_name: TStringField
      FieldName = 'okpdtr_name'
      Size = 1000
    end
    object dxMemData1Broned: TBooleanField
      FieldName = 'Broned'
    end
    object dxMemData1Fixed: TBooleanField
      FieldName = 'Fixed'
    end
  end
  object DataSource1: TDataSource
    DataSet = dxMemData1
    Left = 376
    Top = 96
  end
  object ADOQuery1: TADOQuery
    Connection = dmMain.dbMain
    Parameters = <>
    SQL.Strings = (
      
        'select p.pers_id, p.fam, p.im, p.otch, p.WUchet2_IsWork, kokpdtr' +
        '.kokpdtr_code, kokpdtr.kokpdtr_name, p.okved,'
      'count(*)'
      'from ((((person p'
      'inner join PersonreservChkInfoBase pb on pb.pers_id = p.pers_id)'
      'inner join Appointment on (P.AppLast=Appointment.Id))'
      'inner join [KPOST] KP on (Appointment.POST_ID=[KP].POST_ID))'
      'inner join TPDP pdp on pdp.kokpdtr = KP.kokpdtr)'
      'inner join kokpdtr on kp.kokpdtr = kokpdtr.kokpdtr_id'
      'where '
      '            (pb.MainWork=1) and'
      '            (pb.PermanentWork=1) and'
      '            (pb.WARTIME=1) and'
      '            (pb.DefVUS=0) and'
      '            (pb.Command300=0) and'
      '            (pb.SpecialWUchet1<>1) and'
      '            (pb.Document<>3) and '
      '            (pb.ProbationOk=1) and'
      '            (ISNULL(pb.EOARMY_YEAR) or (pb.Male<>1) or'
      
        '             (R.LIMIT1 <= Year(Date())-Year(pb.BIRTHDAY)) or not' +
        ' ('
      
        '             ((R.CHE<= 8)             and (Year(Date())-Year(pb.' +
        'BIRTHDAY)<=35)) or'
      
        '             ((R.CHE IN (9,10,11,12)) and (Year(Date())-Year(pb.' +
        'BIRTHDAY)<=45)) or'
      
        '             ((R.CHE IN (13,14))      and (Year(Date())-Year(pb.' +
        'BIRTHDAY)<=50)) or'
      
        '             ((R.CHE =15)             and (Year(Date())-Year(pb.' +
        'BIRTHDAY)<=55)) or'
      
        '             ((R.CHE >15)             and (Year(Date())-Year(pb.' +
        'BIRTHDAY)<=60)))'
      '            ) and'
      '            (pb.Driver is null or pb.Driver<>1) and'
      
        '            (pb.MobContract is null or pb.MobContract < Date()) ' +
        'and'
      '            (pb.DefPOST=1)'
      
        'group by p.pers_id, p.fam, p.im, p.otch, p.WUchet2_IsWork, kokpd' +
        'tr.kokpdtr_code, kokpdtr.kokpdtr_name, p.okved'
      'having count(*) > 1'
      'order by p.fam, p.im, p.otch')
    Left = 144
    Top = 176
  end
end

object fmParamDlg: TfmParamDlg
  Left = 285
  Top = 207
  HelpContext = 519
  BorderStyle = bsDialog
  Caption = #1048#1089#1090#1086#1088#1080#1103' '#1074#1099#1076#1072#1095#1080' '#1092#1086#1088#1084' '#8470' 26'
  ClientHeight = 197
  ClientWidth = 313
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    313
    197)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 152
    Top = 166
    Width = 75
    Height = 25
    Action = Action1
    Anchors = [akRight, akBottom]
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 236
    Top = 166
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object dxDBGrid1: TdxDBGrid
    Left = 0
    Top = 0
    Width = 313
    Height = 160
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    SummaryGroups = <>
    SummarySeparator = ', '
    TabOrder = 2
    OnDblClick = dxDBGrid1DblClick
    DataSource = dmMain.dsN26History
    Filter.Criteria = {00000000}
    OptionsView = [edgoBandHeaderWidth, edgoRowSelect, edgoUseBitmap]
    Anchors = [akLeft, akTop, akRight, akBottom]
    object dxDBGrid1N26_ID: TdxDBGridMaskColumn
      Visible = False
      Width = 95
      BandIndex = 0
      RowIndex = 0
      FieldName = 'N26_ID'
    end
    object dxDBGrid1Form_Num: TdxDBGridMaskColumn
      Width = 89
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Form_Num'
    end
    object dxDBGrid1Create_Date: TdxDBGridDateColumn
      Width = 84
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Create_Date'
    end
    object dxDBGrid1Give_Date: TdxDBGridDateColumn
      Width = 116
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Give_Date'
    end
  end
  object ActionList1: TActionList
    Left = 33
    Top = 161
    object Action1: TAction
      Caption = #1055#1077#1095#1072#1090#1100
      Hint = #1055#1077#1095#1072#1090#1100
      OnUpdate = Action1Update
    end
  end
end

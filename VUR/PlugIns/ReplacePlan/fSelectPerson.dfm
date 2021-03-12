object frmSelectPerson: TfrmSelectPerson
  Left = 0
  Top = 0
  Caption = #1042#1099#1073#1086#1088' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1072
  ClientHeight = 352
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 311
    Width = 422
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      422
      41)
    object btnOk: TButton
      Left = 259
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #1042#1099#1073#1088#1072#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 340
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
  object dxDBGrid1: TdxDBGrid
    Left = 0
    Top = 0
    Width = 422
    Height = 311
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    DoNotAddFormNameToRegistryPath = False
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    TabOrder = 1
    OnDblClick = dxDBGrid1DblClick
    DataSource = dsSelectPerson
    Filter.Criteria = {00000000}
    OptionsBehavior = [edgoAutoSearch, edgoAutoSort, edgoDragScroll, edgoEnterShowEditor, edgoImmediateEditor, edgoTabThrough, edgoVertThrough]
    OptionsCustomize = [edgoBandMoving, edgoBandSizing, edgoColumnMoving, edgoColumnSizing, edgoRowSizing]
    OptionsDB = [edgoCancelOnExit, edgoCanInsert, edgoCanNavigation, edgoConfirmDelete, edgoUseBookmarks]
    object dxDBGrid1Pers_Id: TdxDBGridMaskColumn
      Visible = False
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Pers_Id'
    end
    object dxDBGrid1Pers_FIO: TdxDBGridColumn
      Caption = #1060'.'#1048'.'#1054'.'
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Pers_FIO'
    end
    object dxDBGrid1Pers_Dep: TdxDBGridColumn
      Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Pers_Dep'
    end
    object dxDBGrid1Pers_Post: TdxDBGridColumn
      Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'Pers_Post'
    end
    object dxDBGrid1war: TdxDBGridColumn
      Caption = #1074'/'#1086
      Width = 100
      BandIndex = 0
      RowIndex = 0
      FieldName = 'war'
    end
  end
  object dsSelectPerson: TDataSource
    DataSet = dmMain.qrSelectPerson
    Left = 200
    Top = 144
  end
end

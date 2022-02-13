object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 466
  ClientWidth = 596
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Grid2: TdxDBGrid
    Left = 0
    Top = 201
    Width = 596
    Height = 265
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alClient
    TabOrder = 0
    DataSource = DataSource2
    Filter.Criteria = {00000000}
  end
  object Grid1: TdxDBGrid
    Left = 0
    Top = 0
    Width = 596
    Height = 201
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    SummaryGroups = <>
    SummarySeparator = ', '
    Align = alTop
    TabOrder = 1
    DataSource = DataSource1
    Filter.Criteria = {00000000}
  end
  object DataSource1: TDataSource
    Left = 14
    Top = 41
  end
  object DataSource2: TDataSource
    Left = 56
    Top = 41
  end
end

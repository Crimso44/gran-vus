object frmPreview: TfrmPreview
  Left = 0
  Top = 0
  Caption = 'frmPreview'
  ClientHeight = 300
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 256
    Width = 635
    Height = 44
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      635
      44)
    object bClose: TButton
      Left = 552
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1047#1072#1082#1088#1099#1090#1100
      ModalResult = 1
      TabOrder = 0
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 256
    Align = alClient
    ColCount = 2
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 1
    ColWidths = (
      302
      323)
  end
end

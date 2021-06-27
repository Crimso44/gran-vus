object fmOrgPropOKONH: TfmOrgPropOKONH
  Left = 517
  Top = 370
  HelpContext = 6
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1087#1080#1089#1086#1082' '#1054#1050#1042#1069#1044
  ClientHeight = 244
  ClientWidth = 265
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    265
    244)
  PixelsPerInch = 96
  TextHeight = 13
  object mmOKONH: TMemo
    Left = 8
    Top = 8
    Width = 248
    Height = 197
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = mmOKONHChange
    OnKeyPress = mmOKONHKeyPress
  end
  object Button1: TButton
    Left = 176
    Top = 212
    Width = 78
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = Button1Click
  end
end

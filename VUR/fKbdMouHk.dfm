object fmKbdMouHk: TfmKbdMouHk
  Left = 374
  Top = 306
  BorderStyle = bsSingle
  Caption = 'fmKbdMouHk'
  ClientHeight = 87
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object tmCheck: TTimer
    OnTimer = tmCheckTimer
    Left = 16
    Top = 12
  end
end

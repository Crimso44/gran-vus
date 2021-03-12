object frmSplashProgress: TfrmSplashProgress
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  BorderWidth = 1
  Caption = 'frmSplashProgress'
  ClientHeight = 49
  ClientWidth = 425
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 425
    Height = 49
    Align = alClient
    Style = bsRaised
  end
  object Label1: TLabel
    Left = 4
    Top = 8
    Width = 417
    Height = 17
    Alignment = taCenter
    AutoSize = False
    Caption = '...'
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 28
    Width = 409
    Height = 17
    Step = 1
    TabOrder = 0
  end
end

object fmF77TLstDlg: TfmF77TLstDlg
  Left = 465
  Top = 252
  HelpContext = 27
  BorderStyle = bsDialog
  Caption = #1057#1087#1080#1089#1086#1082' '#1087#1086' '#1087#1077#1088#1077#1095#1085#1102
  ClientHeight = 152
  ClientWidth = 296
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 12
    Width = 121
    Height = 13
    Caption = #1050#1086#1076' '#1054#1050#1042#1069#1044' '#1087#1086' '#1087#1077#1088#1077#1095#1085#1102
  end
  object bPrint: TButton
    Left = 8
    Top = 124
    Width = 81
    Height = 25
    Caption = #1054#1090#1095#1077#1090
    Default = True
    TabOrder = 1
    OnClick = bPrintClick
  end
  object bCancel: TButton
    Left = 214
    Top = 124
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    ModalResult = 2
    TabOrder = 2
  end
  object rgFilter: TRadioGroup
    Left = 8
    Top = 36
    Width = 281
    Height = 81
    Caption = #1059#1089#1083#1086#1074#1080#1103
    ItemIndex = 1
    Items.Strings = (
      #1055#1086' '#1074#1089#1077#1084' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084' '#1082#1072#1088#1090#1086#1090#1077#1082#1080
      #1055#1086' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103#1084', '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1084' '#1075#1083#1072#1074#1085#1086#1084#1091' '#1042#1059#1054
      #1055#1086' '#1079#1072#1076#1072#1085#1085#1086#1084#1091' '#1085#1072#1073#1086#1088#1091)
    TabOrder = 0
  end
  object edPerNumb: TMaskEdit
    Left = 155
    Top = 8
    Width = 54
    Height = 21
    EditMask = '!00.99.99;1; '
    MaxLength = 8
    TabOrder = 3
    Text = '  .  .  '
  end
  object FrmKeep1: TFrmKeep
    IniName = 'frmdata.ini'
    IniSection = 'FORMS'
    AutoLoad = True
    Left = 180
    Top = 72
  end
end

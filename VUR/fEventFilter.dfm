object fmEventFilter: TfmEventFilter
  Left = 277
  Top = 117
  HelpContext = 531
  BorderStyle = bsDialog
  Caption = #1060#1080#1083#1100#1090#1088#1072#1094#1080#1103' '#1078#1091#1088#1085#1072#1083#1072' '#1089#1086#1073#1099#1090#1080#1081
  ClientHeight = 359
  ClientWidth = 499
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object laWhen: TLabel
    Left = 8
    Top = 52
    Width = 52
    Height = 13
    Caption = #1048#1085#1090#1077#1088#1074#1072#1083':'
  end
  object laFrom: TLabel
    Left = 8
    Top = 72
    Width = 6
    Height = 13
    Caption = 'c'
  end
  object laTo: TLabel
    Left = 204
    Top = 72
    Width = 12
    Height = 13
    Caption = #1087#1086
  end
  object laWhat: TLabel
    Left = 8
    Top = 96
    Width = 22
    Height = 13
    Caption = #1063#1090#1086':'
  end
  object laWhere: TLabel
    Left = 8
    Top = 224
    Width = 21
    Height = 13
    Caption = #1043#1076#1077':'
  end
  object laWho: TLabel
    Left = 8
    Top = 8
    Width = 76
    Height = 13
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
  end
  object dtWhenFromDate: TDateTimePicker
    Left = 36
    Top = 68
    Width = 81
    Height = 21
    Date = 25989.736244826390000000
    Time = 25989.736244826390000000
    Enabled = False
    TabOrder = 2
  end
  object dtWhenToDate: TDateTimePicker
    Left = 236
    Top = 68
    Width = 81
    Height = 21
    Date = 25989.736254039350000000
    Time = 25989.736254039350000000
    Enabled = False
    TabOrder = 6
  end
  object dtWhenFromTime: TDateTimePicker
    Left = 140
    Top = 68
    Width = 53
    Height = 21
    Date = 38061.000000000000000000
    Format = 'HH:mm'
    Time = 38061.000000000000000000
    Enabled = False
    Kind = dtkTime
    TabOrder = 4
  end
  object dtWhenToTime: TDateTimePicker
    Left = 340
    Top = 68
    Width = 53
    Height = 21
    Date = 38061.000000000000000000
    Format = 'HH:mm'
    Time = 38061.000000000000000000
    Enabled = False
    Kind = dtkTime
    TabOrder = 8
  end
  object clbWhat: TCheckListBox
    Left = 8
    Top = 108
    Width = 385
    Height = 113
    ItemHeight = 13
    PopupMenu = PopupMenu1
    TabOrder = 9
  end
  object clbWhere: TCheckListBox
    Left = 8
    Top = 236
    Width = 385
    Height = 113
    ItemHeight = 13
    PopupMenu = PopupMenu2
    TabOrder = 10
  end
  object cbWhenFromDate: TCheckBox
    Left = 20
    Top = 72
    Width = 16
    Height = 17
    TabOrder = 1
    OnClick = cbWhenFromDateClick
  end
  object cbWhenFromTime: TCheckBox
    Left = 124
    Top = 72
    Width = 16
    Height = 17
    Enabled = False
    TabOrder = 3
    OnClick = cbWhenFromDateClick
  end
  object cbWhenToDate: TCheckBox
    Left = 220
    Top = 72
    Width = 16
    Height = 17
    TabOrder = 5
    OnClick = cbWhenFromDateClick
  end
  object cbWhenToTime: TCheckBox
    Left = 324
    Top = 72
    Width = 16
    Height = 17
    Enabled = False
    TabOrder = 7
    OnClick = cbWhenFromDateClick
  end
  object edWho: TComboBox
    Left = 8
    Top = 24
    Width = 385
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object pbOk: TBitBtn
    Left = 408
    Top = 24
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    ModalResult = 1
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 11
    OnClick = pbOkClick
  end
  object pbCancel: TBitBtn
    Left = 408
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = True
    ModalResult = 2
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 12
  end
  object PopupMenu1: TPopupMenu
    Left = 228
    Top = 140
    object mnuSetAllEventsOn: TMenuItem
      Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1074#1089#1105
      OnClick = mnuSetAllEventsOnClick
    end
    object mnuSetAllEventsOff: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1105
      OnClick = mnuSetAllEventsOffClick
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 224
    Top = 384
    object mnuSetAllObjectsOn: TMenuItem
      Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1074#1089#1105
      OnClick = mnuSetAllObjectsOnClick
    end
    object mnuSetAllObjectsOff: TMenuItem
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1074#1089#1105
      OnClick = mnuSetAllObjectsOffClick
    end
  end
end

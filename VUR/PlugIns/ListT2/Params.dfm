object dlgParams: TdlgParams
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099
  ClientHeight = 305
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    316
    305)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 20
    Top = 8
    Width = 52
    Height = 13
    Caption = #1047#1072' '#1087#1077#1088#1080#1086#1076
  end
  object Label4: TLabel
    Left = 20
    Top = 30
    Width = 5
    Height = 13
    Caption = #1089
  end
  object Label5: TLabel
    Left = 159
    Top = 30
    Width = 12
    Height = 13
    Caption = #1087#1086
  end
  object BitBtn1: TBitBtn
    Left = 20
    Top = 275
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    Default = True
    DoubleBuffered = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 208
    Top = 275
    Width = 75
    Height = 25
    Anchors = [akLeft, akBottom]
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 2
  end
  object rgSort: TRadioGroup
    Left = 15
    Top = 165
    Width = 293
    Height = 105
    Caption = #1054#1087#1088#1077#1076#1077#1083#1080#1090#1077' '#1087#1086#1088#1103#1076#1086#1082' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1080' '#1074' '#1078#1091#1088#1085#1072#1083#1077' '#1092#1086#1088#1084' '#1058'-2'
    ItemIndex = 0
    Items.Strings = (
      #1055#1086' '#1085#1086#1084#1077#1088#1091' '#1082#1072#1088#1090#1086#1095#1082#1080
      #1055#1086' '#1060#1048#1054
      #1055#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1102', '#1076#1086#1083#1078#1085#1086#1089#1090#1080', '#1060#1048#1054)
    TabOrder = 0
  end
  object rgType: TRadioGroup
    Left = 15
    Top = 54
    Width = 293
    Height = 105
    Caption = #1046#1091#1088#1085#1072#1083' '#1092#1086#1088#1084' '#1058'-2'
    ItemIndex = 0
    Items.Strings = (
      #1042#1089#1103' '#1082#1072#1088#1090#1086#1090#1077#1082#1072
      #1055#1086#1089#1090#1072#1074#1083#1077#1085#1085#1099#1077' '#1085#1072' '#1091#1095#1077#1090' '#1080' '#1089#1085#1103#1090#1099#1077' '#1089' '#1091#1095#1077#1090#1072
      #1058#1086#1083#1100#1082#1086' '#1087#1086#1089#1090#1072#1074#1083#1077#1085#1085#1099#1077' '#1085#1072' '#1091#1095#1077#1090
      #1058#1086#1083#1100#1082#1086' '#1089#1085#1103#1090#1099#1077' '#1089' '#1091#1095#1077#1090#1072)
    TabOrder = 3
  end
  object Date_From: TdxDateEdit
    Left = 32
    Top = 27
    Width = 121
    TabOrder = 4
    Date = -700000.000000000000000000
    DateButtons = [btnToday]
    DateOnError = deToday
    DateValidation = True
    OnDateValidateInput = Date_FromDateValidateInput
  end
  object Date_To: TdxDateEdit
    Left = 177
    Top = 27
    Width = 121
    TabOrder = 5
    Date = -700000.000000000000000000
    DateButtons = [btnToday]
    DateOnError = deToday
    DateValidation = True
    OnDateValidateInput = Date_ToDateValidateInput
  end
end

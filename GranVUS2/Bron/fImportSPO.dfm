object fmImportSPO: TfmImportSPO
  Left = 343
  Top = 269
  HelpContext = 39
  Caption = #1048#1084#1087#1086#1088#1090' '#1072#1075#1088#1077#1075#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1092#1086#1088#1084' '#1080#1079' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'"'
  ClientHeight = 296
  ClientWidth = 360
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
  object laSubj: TLabel
    Left = 8
    Top = 8
    Width = 26
    Height = 13
    Caption = #1042#1059#1054':'
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 28
    Width = 361
    Height = 241
    ActivePage = TabSheet1
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object laFileName: TLabel
        Left = 4
        Top = 4
        Width = 183
        Height = 13
        Caption = #1060#1072#1081#1083' '#1089' '#1080#1084#1087#1086#1088#1090#1080#1088#1091#1077#1084#1099#1084#1080' '#1076#1072#1085#1085#1099#1084#1080':'
      end
      object edFileName: TEdit
        Left = 4
        Top = 20
        Width = 345
        Height = 21
        ParentColor = True
        ReadOnly = True
        TabOrder = 0
      end
      object pbOpen: TButton
        Left = 4
        Top = 48
        Width = 75
        Height = 25
        Caption = #1054#1090#1082#1088#1099#1090#1100'...'
        TabOrder = 1
        OnClick = pbOpenClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 4
        Top = 24
        Width = 71
        Height = 13
        Caption = #1064#1080#1092#1088' '#1092#1086#1088#1084#1099':'
      end
      object Label2: TLabel
        Left = 4
        Top = 44
        Width = 83
        Height = 13
        Caption = #1044#1072#1085#1085#1099#1077' '#1092#1086#1088#1084#1099':'
      end
      object Label3: TLabel
        Left = 4
        Top = 156
        Width = 79
        Height = 13
        Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
      end
      object Label4: TLabel
        Left = 8
        Top = 176
        Width = 65
        Height = 13
        Caption = #1044#1072#1090#1072' '#1086#1090#1095#1105#1090#1072':'
      end
      object Label5: TLabel
        Left = 140
        Top = 176
        Width = 52
        Height = 13
        Caption = #1063#1080#1089#1083#1086' '#1060'6'
      end
      object Label6: TLabel
        Left = 252
        Top = 176
        Width = 58
        Height = 13
        Caption = #1063#1080#1089#1083#1086' '#1050#1059#1054
      end
      object Label7: TLabel
        Left = 4
        Top = 0
        Width = 270
        Height = 13
        Caption = #1055#1086#1083#1091#1095#1077#1085#1099' '#1080' '#1075#1086#1090#1086#1074#1099' '#1076#1083#1103' '#1080#1084#1087#1086#1088#1090#1072' '#1089#1083#1077#1076#1091#1102#1097#1080#1077' '#1076#1072#1085#1085#1099#1077':'
      end
      object Label9: TLabel
        Left = 124
        Top = 28
        Width = 100
        Height = 13
        Caption = #1064#1080#1092#1088' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080':'
      end
      object edF6_SHIFR: TEdit
        Left = 80
        Top = 24
        Width = 25
        Height = 21
        MaxLength = 2
        ParentColor = True
        ReadOnly = True
        TabOrder = 0
      end
      object edF6: TMemo
        Left = 4
        Top = 60
        Width = 345
        Height = 89
        ParentColor = True
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object edORGNAME: TEdit
        Left = 88
        Top = 152
        Width = 261
        Height = 21
        MaxLength = 250
        ParentColor = True
        ReadOnly = True
        TabOrder = 3
      end
      object edDate: TEdit
        Left = 8
        Top = 192
        Width = 121
        Height = 21
        ParentColor = True
        ReadOnly = True
        TabOrder = 4
      end
      object edF6_COUNT: TEdit
        Left = 140
        Top = 192
        Width = 97
        Height = 21
        ParentColor = True
        ReadOnly = True
        TabOrder = 5
      end
      object edKUO_COUNT: TEdit
        Left = 252
        Top = 192
        Width = 97
        Height = 21
        ParentColor = True
        ReadOnly = True
        TabOrder = 6
      end
      object edORG_SHIFR: TEdit
        Left = 228
        Top = 24
        Width = 121
        Height = 21
        MaxLength = 10
        ParentColor = True
        ReadOnly = True
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label8: TLabel
        Left = 4
        Top = 80
        Width = 345
        Height = 57
        Alignment = taCenter
        AutoSize = False
        Caption = 
          #1048#1084#1087#1086#1088#1090' '#1079#1072#1074#1077#1088#1096#1105#1085'.'#13#10#13#10#1053#1072#1078#1084#1080#1090#1077' '#1082#1085#1086#1087#1082#1091' "'#1047#1072#1082#1088#1099#1090#1100'" '#1080#1083#1080' '#1082#1085#1086#1087#1082#1091' "'#1055#1086#1074#1090#1086#1088#1080 +
          #1090#1100'" '#1076#1083#1103' '#1080#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1089#1083#1077#1076#1091#1102#1097#1077#1075#1086' '#1092#1072#1081#1083#1072' '#1074' '#1076#1072#1085#1085#1099#1081' '#1042#1059#1054'.'
        WordWrap = True
      end
    end
  end
  object pbPrev: TButton
    Left = 8
    Top = 272
    Width = 75
    Height = 25
    Action = actPrev
    TabOrder = 2
  end
  object pbNext: TButton
    Left = 92
    Top = 272
    Width = 75
    Height = 25
    Action = actNext
    TabOrder = 3
  end
  object pbAgain: TButton
    Left = 200
    Top = 272
    Width = 75
    Height = 25
    Action = actAgain
    TabOrder = 4
  end
  object pbClose: TButton
    Left = 284
    Top = 272
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 5
    OnClick = pbCloseClick
  end
  object edSubj: TEdit
    Left = 36
    Top = 4
    Width = 325
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'brp'
    Filter = #1060#1072#1081#1083#1099' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'" (*.brp)|*.brp|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing, ofForceShowHidden]
    OptionsEx = [ofExNoPlacesBar]
    Left = 204
    Top = 254
  end
  object ActionList1: TActionList
    OnUpdate = ActionList1Update
    Left = 100
    Top = 54
    object actPrev: TAction
      Caption = '<< '#1053#1072#1079#1072#1076
      OnExecute = actPrevExecute
    end
    object actNext: TAction
      Caption = #1044#1072#1083#1077#1077' >>'
      OnExecute = actNextExecute
    end
    object actAgain: TAction
      Caption = #1055#1086#1074#1090#1086#1088#1080#1090#1100
      OnExecute = actAgainExecute
    end
  end
  object qry: TADOQuery
    Connection = dmMain.dbMain
    ParamCheck = False
    Parameters = <>
    Left = 256
    Top = 246
  end
  object sp_Form6Create: TADOStoredProc
    Connection = dmMain.dbMain
    ProcedureName = 'sp_Form6Create;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@SUBJ_ID'
        Attributes = [paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 256
    Top = 152
  end
end

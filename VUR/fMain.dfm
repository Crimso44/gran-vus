object fmMain: TfmMain
  Left = 377
  Top = 204
  HelpContext = 7
  Caption = #1043#1088#1072#1085'-'#1042#1059#1056
  ClientHeight = 467
  ClientWidth = 683
  Color = clAppWorkSpace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatBar: TStatusBar
    Left = 0
    Top = 448
    Width = 683
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 50
      end>
  end
  object Button1: TButton
    Left = 284
    Top = 112
    Width = 333
    Height = 25
    Action = aBadDatesCheck
    TabOrder = 5
    Visible = False
  end
  object alsMain: TActionList
    Images = dmMain.ilSmall
    Left = 24
    Top = 94
    object actOrgCard: TAction
      Caption = '&'#1050#1072#1088#1090#1086#1095#1082#1072' '#1091#1095#1105#1090#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      Hint = #1050#1072#1088#1090#1086#1095#1082#1072' '#1091#1095#1105#1090#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      ImageIndex = 19
      OnExecute = actOrgCardExecute
    end
    object actPersonLst: TAction
      Caption = #1050#1072#1088#1090#1086#1090#1077#1082#1072' &'#1088#1072#1073#1086#1090#1085#1080#1082#1086#1074
      Hint = #1050#1072#1088#1090#1086#1090#1077#1082#1072' '#1088#1072#1073#1086#1090#1085#1080#1082#1086#1074
      ImageIndex = 25
      OnExecute = actPersonLstExecute
    end
    object actStaffListRO: TAction
      Caption = '&'#1087#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103#1084' '#1080' '#1076#1086#1083#1078#1085#1086#1089#1090#1103#1084
      Hint = #1087#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103#1084' '#1080' '#1076#1086#1083#1078#1085#1086#1089#1090#1103#1084
      ImageIndex = 37
      OnExecute = actStaffListROExecute
    end
    object actASStaffListStored: TAction
      Caption = #1064#1090#1072#1090#1085#1072#1103' '#1095#1080#1089#1083#1077#1085#1085#1086#1089#1090#1100' '#1040#1057#1060
      Hint = #1064#1090#1072#1090#1085#1086#1077' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077'. '#1059#1095#1105#1090' "'#1042#1089#1077#1075#1086' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093'"'
      ImageIndex = 37
      OnExecute = actASStaffListStoredExecute
    end
    object actStaffListStored: TAction
      Caption = '&'#1064#1090#1072#1090#1085#1086#1077' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077'. '#1059#1095#1105#1090' "'#1042#1089#1077#1075#1086' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093'"'
      Hint = #1064#1090#1072#1090#1085#1086#1077' '#1088#1072#1089#1087#1080#1089#1072#1085#1080#1077'. '#1059#1095#1105#1090' "'#1042#1089#1077#1075#1086' '#1088#1072#1073#1086#1090#1072#1102#1097#1080#1093'"'
      ImageIndex = 37
      OnExecute = actStaffListStoredExecute
    end
    object actBronDol: TAction
      Caption = '&'#1042#1099#1087#1080#1089#1082#1072' '#1080#1079' '#1055#1044#1055
      Hint = #1042#1099#1087#1080#1089#1082#1072' '#1080#1079' '#1055#1044#1055
      ImageIndex = 49
      OnExecute = actBronDolExecute
    end
    object actClose: TAction
      Caption = #1042'&'#1099#1093#1086#1076
      Hint = #1042#1099#1081#1090#1080' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ShortCut = 32883
      OnExecute = actCloseExecute
    end
    object actBaseLst: TAction
      Caption = #1041#1072#1079#1086#1074#1099#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Hint = #1041#1072#1079#1086#1074#1099#1077' '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      ImageIndex = 53
      OnExecute = actBaseLstExecute
    end
    object actImport: TAction
      Caption = '&'#1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093
      Hint = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1042#1059#1057
      ImageIndex = 17
      OnExecute = actImportExecute
    end
    object actExport: TAction
      Caption = '&'#1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1042#1059#1057
      ImageIndex = 10
      OnExecute = actExportExecute
    end
    object actSets: TAction
      Caption = '&'#1055#1072#1088#1072#1084#1077#1090#1088#1099'...'
      Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 27
      OnExecute = actSetsExecute
    end
    object actConnect: TAction
      Caption = '&'#1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077'...'
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1080#1089#1090#1086#1095#1085#1080#1082#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      ImageIndex = 6
      OnExecute = actConnectExecute
    end
    object actHelp: TAction
      Caption = '&'#1055#1086#1084#1086#1097#1100'...'
      HelpContext = 7
      HelpType = htContext
      Hint = #1042#1099#1079#1086#1074' '#1089#1087#1088#1072#1074#1082#1080
      ImageIndex = 16
      ShortCut = 112
      OnExecute = actHelpExecute
    end
    object actAbout: TAction
      Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      Hint = #1042#1099#1079#1086#1074' '#1089#1074#1077#1076#1077#1085#1080#1081' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 18
      OnExecute = actAboutExecute
    end
    object actBaseLstExec: TAction
      Tag = 5
      Caption = 'actBaseLstExec'
      ImageIndex = 2
      OnExecute = actBaseLstExecExecute
    end
    object actReScanPlugIns: TAction
      Caption = '&'#1054#1073#1085#1086#1074#1080#1090#1100
      Hint = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1074#1085#1077#1096#1085#1080#1093' '#1084#1086#1076#1091#1083#1077#1081
      OnExecute = actReScanPlugInsExecute
    end
    object actExecPlugIn: TAction
      Caption = 'actExecPlugIn'
      OnExecute = actExecPlugInExecute
    end
    object actConfigPlugIns: TAction
      Caption = '&'#1053#1072#1089#1090#1088#1086#1081#1082#1080'...'
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1074#1085#1077#1096#1085#1080#1093' '#1084#1086#1076#1091#1083#1077#1081
      OnExecute = actConfigPlugInsExecute
    end
    object actStoreData: TAction
      Caption = #1056#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
      Hint = #1057#1086#1076#1072#1085#1080#1077' '#1088#1077#1079#1077#1088#1074#1085#1086#1081' '#1082#1086#1087#1080#1102' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 36
      OnExecute = actStoreDataExecute
    end
    object actRestoreData: TAction
      Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
      Hint = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093' '#1080#1079' '#1088#1077#1079#1077#1088#1074#1085#1086#1081' '#1082#1086#1087#1080#1080
      ImageIndex = 35
      OnExecute = actRestoreDataExecute
    end
    object actActivate: TAction
      Caption = '&'#1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1087#1088#1086#1076#1091#1082#1090#1072'...'
      Hint = #1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1087#1088#1086#1076#1091#1082#1090#1072' '#1080' '#1074#1099#1074#1086#1076' '#1089#1074#1077#1076#1077#1085#1080#1081' '#1086' '#1080#1084#1077#1102#1097#1080#1093#1089#1103' '#1083#1080#1094#1077#1085#1079#1080#1103#1093
      OnExecute = actActivateExecute
    end
    object actEvents: TAction
      Caption = '&'#1046#1091#1088#1085#1072#1083' '#1089#1086#1073#1099#1090#1080#1081
      Hint = #1055#1088#1086#1089#1084#1086#1090#1088', '#1086#1095#1080#1089#1090#1082#1072', '#1087#1077#1095#1072#1090#1100' '#1078#1091#1088#1085#1072#1083#1072' '#1089#1086#1073#1099#1090#1080#1081
      ImageIndex = 51
      OnExecute = actEventsExecute
    end
    object actUsers: TAction
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      Hint = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      ImageIndex = 24
      OnExecute = actUsersExecute
    end
    object actForm6: TAction
      Caption = 
        #1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1080' '#1086#1090#1085#1086#1096#1077#1085#1080#1102' '#1082' '#1074#1086#1080#1085#1089#1082#1086#1081' '#1086#1073#1103#1079#1072#1085#1085#1086#1089#1090#1080' (&201' +
        '4'#1075'.)'
      Hint = #1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1080' '#1086#1090#1085#1086#1096#1077#1085#1080#1102' '#1082' '#1074#1086#1080#1085#1089#1082#1086#1081' '#1086#1073#1103#1079#1072#1085#1085#1086#1089#1090#1080
      ImageIndex = 14
      OnExecute = actForm6Execute
    end
    object actForm6_2015: TAction
      Caption = #1087#1086' &'#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1080' '#1086#1090#1085#1086#1096#1077#1085#1080#1102' '#1082' '#1074#1086#1080#1085#1089#1082#1086#1081' '#1086#1073#1103#1079#1072#1085#1085#1086#1089#1090#1080
      Hint = #1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1080' '#1086#1090#1085#1086#1096#1077#1085#1080#1102' '#1082' '#1074#1086#1080#1085#1089#1082#1086#1081' '#1086#1073#1103#1079#1072#1085#1085#1086#1089#1090#1080
      ImageIndex = 14
      OnExecute = actForm6_2015Execute
    end
    object actSPOBronExport: TAction
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'"'
      OnExecute = actSPOBronExportExecute
    end
    object aSecret: TAction
      Caption = 'aSecret'
      ShortCut = 57382
      OnExecute = aSecretExecute
    end
    object aBadDatesCheck: TAction
      Caption = #1042#1099#1103#1074#1083#1077#1085#1080#1077' '#1080' '#1080#1089#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1085#1077#1082#1086#1088#1088#1077#1082#1090#1085#1099#1093' '#1082#1072#1083#1077#1085#1076#1072#1088#1085#1099#1093' '#1076#1072#1090
      OnExecute = aBadDatesCheckExecute
    end
    object aPersonChanges: TAction
      Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1080#1079#1084#1077#1085#1077#1085#1080#1103#1093' '#1074' '#1091#1095#1077#1090#1085#1099#1093' '#1076#1072#1085#1085#1099#1093' '#1088#1072#1073#1086#1090#1085#1080#1082#1086#1074
      ImageIndex = 54
      OnExecute = aPersonChangesExecute
    end
    object actAsfMtrStaffList: TAction
      Caption = 
        #1055#1086#1090#1088#1077#1073#1085#1086#1089#1090#1100' '#1080' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1052#1058#1056' '#1076#1083#1103' '#1086#1089#1085#1072#1097#1077#1085#1080#1103' '#1040#1057#1060'/'#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1081' ' +
        #1040#1057#1060
      ImageIndex = 37
      OnExecute = actAsfMtrStaffListExecute
    end
  end
  object dxBarManager1: TdxBarManager
    AllowReset = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      'Default'
      #1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      #1056#1072#1089#1095#1105#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      #1060#1086#1088#1084#1099' '#1080' '#1086#1090#1095#1077#1090#1099
      #1054#1073#1084#1077#1085' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077#1081
      #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077
      '?'
      #1053#1040#1057#1060)
    Categories.ItemsVisibles = (
      2
      2
      2
      2
      2
      2
      2
      2)
    Categories.Visibles = (
      True
      True
      True
      True
      True
      True
      True
      True)
    ImageOptions.Images = dmMain.ilSmall
    PopupMenuLinks = <>
    UseSystemFont = False
    Left = 24
    Top = 36
    DockControlHeights = (
      0
      0
      42
      0)
    object dxBarManager1Bar1: TdxBar
      AllowClose = False
      AllowCustomizing = False
      AllowQuickCustomizing = False
      AllowReset = False
      Caption = #1054#1089#1085#1086#1074#1085#1086#1077' '#1084#1077#1085#1102
      CaptionButtons = <>
      DockedDockingStyle = dsTop
      DockedLeft = 0
      DockedTop = 0
      DockingStyle = dsTop
      FloatLeft = 276
      FloatTop = 218
      FloatClientWidth = 23
      FloatClientHeight = 22
      IsMainMenu = True
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem5'
        end
        item
          Visible = True
          ItemName = 'dxbs0'
        end
        item
          Visible = True
          ItemName = 'dxbs1'
        end
        item
          Visible = True
          ItemName = 'dxsiPlugIns'
        end
        item
          Visible = True
          ItemName = 'dxbs3'
        end
        item
          Visible = True
          ItemName = 'dxsiPlugInsASF'
        end
        item
          Visible = True
          ItemName = 'dxBarInfoExchange'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItemAdmin'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem3'
        end>
      MultiLine = True
      OldName = #1054#1089#1085#1086#1074#1085#1086#1077' '#1084#1077#1085#1102
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object dxbs0: TdxBarSubItem
      Caption = '&'#1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1042#1059#1056
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton12'
        end
        item
          Visible = True
          ItemName = 'dxBarButton15'
        end
        item
          Visible = True
          ItemName = 'dxBBMvkOrder'
        end
        item
          Visible = True
          ItemName = 'dxsiBaseLst'
        end>
    end
    object dxbs1: TdxBarSubItem
      Caption = #1056#1072#1089#1095#1105#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1042#1059#1056
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'bForm6_2014'
        end
        item
          Visible = True
          ItemName = 'dxBarButton17'
        end
        item
          Visible = True
          ItemName = 'dxBarButton18'
        end
        item
          Visible = True
          ItemName = 'dxBarButton21'
        end>
    end
    object dxsiPlugIns: TdxBarSubItem
      Caption = '&'#1060#1086#1088#1084#1099' '#1080' '#1086#1090#1095#1105#1090#1099' '#1042#1059#1056
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarInfoExchange: TdxBarSubItem
      Caption = '&'#1054#1073#1084#1077#1085' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077#1081
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end>
    end
    object dxBarSubItemAdmin: TdxBarSubItem
      Caption = '&'#1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          Visible = True
          ItemName = 'dxBarButton14'
        end
        item
          Visible = True
          ItemName = 'dxBarButton16'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarSubItemModules'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton20'
        end>
    end
    object dxBarSubItem3: TdxBarSubItem
      Caption = '&?'
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxScalePlus'
        end
        item
          Visible = True
          ItemName = 'dxScaleMinus'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end>
    end
    object bbUpdate: TdxBarButton
      Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1085#1072#1083#1080#1095#1080#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081'...'
      Category = 0
      Hint = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1085#1072#1083#1080#1095#1080#1077' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081
      Visible = ivAlways
      ImageIndex = 40
      OnClick = bbUpdateClick
    end
    object bbHistory: TdxBarButton
      Caption = #1048#1089#1090#1086#1088#1080#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1081'...'
      Category = 0
      Hint = #1048#1089#1090#1086#1088#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      Visible = ivAlways
      ImageIndex = 3
      OnClick = bbUpdateClick
    end
    object dxBarButton21: TdxBarButton
      Action = aPersonChanges
      Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1080#1079#1084#1077#1085#1077#1085#1080#1103#1093' '#1074' '#1091#1095#1077#1090#1085#1099#1093' '#1076#1072#1085#1085#1099#1093' '#1088#1072#1073#1086#1090#1085#1080#1082#1086#1074' '#1080' '#1091#1095#1072#1097#1080#1093#1089#1103
      Category = 0
    end
    object dxBarSubItem4: TdxBarSubItem
      Caption = #1053#1040#1057#1060
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton22'
        end
        item
          Visible = True
          ItemName = 'dxBarButton23'
        end>
    end
    object dxBarSubItem5: TdxBarSubItem
      Caption = #1050#1072#1088#1090#1086#1090#1077#1082#1080
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton11'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton6'
        end>
    end
    object dxbs3: TdxBarSubItem
      Caption = #1048#1089#1093#1086#1076#1085#1099#1077' '#1080' '#1088#1072#1089#1095#1077#1090#1085#1099#1077' '#1076#1072#1085#1085#1099#1077' '#1040#1057#1060
      Category = 0
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton22'
        end
        item
          Visible = True
          ItemName = 'bbAsfMtr'
        end
        item
          Visible = True
          ItemName = 'bbAsfMtrList'
        end
        item
          Visible = True
          ItemName = 'dxsiASFLst'
        end>
    end
    object dxsiPlugInsASF: TdxBarSubItem
      Caption = #1060#1086#1088#1084#1099' '#1080' '#1086#1090#1095#1077#1090#1099' '#1040#1057#1060
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarButton24: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarSeparator1: TdxBarSeparator
      Caption = 'New Separator'
      Category = 0
      Hint = 'New Separator'
      Visible = ivAlways
    end
    object dxBarButton1: TdxBarButton
      Action = actOrgCard
      Category = 1
    end
    object dxBarButton11: TdxBarButton
      Action = actPersonLst
      Category = 1
    end
    object dxBarButton12: TdxBarButton
      Action = actStaffListStored
      Category = 1
    end
    object dxBarButton15: TdxBarButton
      Action = actBronDol
      Category = 1
    end
    object dxBarButton6: TdxBarButton
      Action = actClose
      Category = 1
    end
    object dxBBMvkOrder: TdxBarButton
      Tag = 47
      Caption = #1055#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1052#1042#1050
      Category = 1
      Hint = #1055#1086#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1052#1042#1050
      Visible = ivAlways
      ImageIndex = 2
      OnClick = actBaseLstExecExecute
    end
    object dxBarButton17: TdxBarButton
      Action = actForm6
      Category = 2
    end
    object dxBarButton18: TdxBarButton
      Action = actStaffListRO
      Category = 2
    end
    object bForm6_2014: TdxBarButton
      Action = actForm6_2015
      Category = 2
    end
    object dxbReScan: TdxBarButton
      Action = actReScanPlugIns
      Category = 3
    end
    object dxbCfgPlugIns: TdxBarButton
      Action = actConfigPlugIns
      Category = 3
    end
    object dxBarButton4: TdxBarButton
      Action = actExport
      Category = 4
    end
    object dxBarButton5: TdxBarButton
      Action = actImport
      Category = 4
    end
    object dxBarButton19: TdxBarButton
      Action = actSPOBronExport
      Category = 4
    end
    object dxBarButton7: TdxBarButton
      Action = actSets
      Category = 5
    end
    object dxBarButton8: TdxBarButton
      Action = actConnect
      Category = 5
    end
    object dxBarButton14: TdxBarButton
      Action = actEvents
      Category = 5
    end
    object dxBarButton2: TdxBarButton
      Action = actStoreData
      Category = 5
    end
    object dxBarButton3: TdxBarButton
      Action = actRestoreData
      Category = 5
    end
    object dxBarSubItemModules: TdxBarSubItem
      Caption = #1042#1085#1077#1096#1085#1080#1077' '#1084#1086#1076#1091#1083#1080
      Category = 5
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxbReScan'
        end
        item
          Visible = True
          ItemName = 'dxbCfgPlugIns'
        end>
    end
    object dxBarButton16: TdxBarButton
      Action = actUsers
      Category = 5
    end
    object dxBarButton20: TdxBarButton
      Action = aBadDatesCheck
      Category = 5
    end
    object dxBarButton9: TdxBarButton
      Action = actHelp
      Category = 6
    end
    object dxBarButton10: TdxBarButton
      Action = actAbout
      Category = 6
    end
    object dxBarButton13: TdxBarButton
      Action = actActivate
      Category = 6
    end
    object dxScalePlus: TdxBarButton
      Caption = #1059#1074#1077#1083#1080#1095#1080#1090#1100
      Category = 6
      Hint = #1059#1074#1077#1083#1080#1095#1080#1090#1100
      Visible = ivAlways
      ShortCut = 16464
      OnClick = dxScalePlusClick
    end
    object dxScaleMinus: TdxBarButton
      Caption = #1059#1084#1077#1085#1100#1096#1080#1090#1100
      Category = 6
      Hint = #1059#1084#1077#1085#1100#1096#1080#1090#1100
      Visible = ivAlways
      ShortCut = 16461
      OnClick = dxScaleMinusClick
    end
    object dxBarButton22: TdxBarButton
      Action = actASStaffListStored
      Category = 7
    end
    object dxBarButton23: TdxBarButton
      Caption = '&'#1087#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103#1084' '#1080' '#1076#1086#1083#1078#1085#1086#1089#1090#1103#1084
      Category = 7
      Hint = #1087#1086' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103#1084' '#1080' '#1076#1086#1083#1078#1085#1086#1089#1090#1103#1084
      Visible = ivAlways
      ImageIndex = 37
    end
    object bbAsfMtr: TdxBarButton
      Caption = #1053#1072#1083#1080#1095#1080#1077' '#1089#1087#1072#1089#1072#1090#1077#1083#1100#1085#1086#1075#1086' '#1080#1084#1091#1097#1077#1089#1090#1074#1072' '#1080' '#1090#1077#1093#1085#1080#1082#1080
      Category = 7
      Hint = #1053#1072#1083#1080#1095#1080#1077' '#1089#1087#1072#1089#1072#1090#1077#1083#1100#1085#1086#1075#1086' '#1080#1084#1091#1097#1077#1089#1090#1074#1072' '#1080' '#1090#1077#1093#1085#1080#1082#1080
      Visible = ivAlways
      OnClick = bbAsfMtrClick
    end
    object bbAsfMtrList: TdxBarButton
      Action = actAsfMtrStaffList
      Category = 7
    end
    object dxsiBaseLst: TdxBarSubItem
      Action = actBaseLst
      Caption = #1057#1083#1086#1074#1072#1088#1080', '#1082#1083#1072#1089#1089#1080#1092#1080#1082#1072#1090#1086#1088#1099', '#1089#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Category = 7
      ItemLinks = <>
    end
    object dxsiASFLst: TdxBarSubItem
      Action = actBaseLst
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      Category = 7
      ItemLinks = <>
    end
  end
end

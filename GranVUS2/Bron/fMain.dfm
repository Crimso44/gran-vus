object fmMain: TfmMain
  Left = 271
  Top = 186
  HelpContext = 3
  Caption = #1043#1088#1072#1085'-'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077' '
  ClientHeight = 353
  ClientWidth = 704
  Color = clAppWorkSpace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  OldCreateOrder = False
  Position = poMainFormCenter
  Scaled = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatBar: TStatusBar
    Left = 0
    Top = 334
    Width = 704
    Height = 19
    Panels = <
      item
        Width = 250
      end
      item
        Width = 50
      end>
  end
  object alsMain: TActionList
    Images = dmMain.ilSmall
    Left = 44
    Top = 108
    object actOrgLst: TAction
      Caption = #1050#1072#1088#1090#1086#1090#1077#1082#1072' &'#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
      ImageIndex = 19
      OnExecute = actOrgLstExecute
    end
    object actSubjList: TAction
      Caption = #1050#1072#1088#1090#1086#1090#1077#1082#1072' '#1042'&'#1059#1054
      ImageIndex = 50
      OnExecute = actSubjListExecute
    end
    object actExportSubj: TAction
      Category = 'DataExchange'
      Caption = '&'#1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1042#1059#1054
      Hint = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1042#1059#1057
      OnExecute = actExportSubjExecute
    end
    object actImportSubj: TAction
      Category = 'DataExchange'
      Caption = #1048'&'#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1042#1059#1054
      OnExecute = actImportSubjExecute
    end
    object actImportOrg: TAction
      Category = 'DataExchange'
      Caption = '&'#1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      Hint = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1042#1059#1057
      OnExecute = actImportOrgExecute
    end
    object actExportOrg: TAction
      Category = 'DataExchange'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
      OnExecute = actExportOrgExecute
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
      OnExecute = actBaseLstExecute
    end
    object actSets: TAction
      Caption = '&'#1059#1089#1090#1072#1085#1086#1074#1082#1080'...'
      Hint = #1059#1089#1090#1072#1085#1086#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 46
      OnExecute = actSetsExecute
    end
    object actConnect: TAction
      Caption = '&'#1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077'...'
      Hint = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1080#1089#1090#1086#1095#1085#1080#1082#1072' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      ImageIndex = 45
      OnExecute = actConnectExecute
    end
    object actHelp: TAction
      Caption = '&'#1055#1086#1084#1086#1097#1100'...'
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
    object actEvents: TAction
      Caption = '&'#1046#1091#1088#1085#1072#1083' '#1089#1086#1073#1099#1090#1080#1081'...'
      ImageIndex = 47
      OnExecute = actEventsExecute
    end
    object actFormVED: TAction
      Caption = 
        #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1087#1086' '#1074#1080#1076#1072#1084' '#1101#1082#1086#1085#1086#1084#1080 +
        #1095#1077#1089#1082#1086#1081' '#1076#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1080' 2010'
      ImageIndex = 14
      OnExecute = actFormOtrExecute
    end
    object actFAnaliz: TAction
      Caption = #1040#1085#1072#1083#1080#1079' '#1086#1073#1077#1089#1087#1077#1095#1077#1085#1085#1086#1089#1090#1080' '#1090#1088#1091#1076#1086#1074#1099#1084#1080' '#1088#1077#1089#1091#1088#1089#1072#1084#1080
      ImageIndex = 14
      OnExecute = actFAnalizExecute
    end
    object actUserList: TAction
      Caption = #1055'&'#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080'...'
      ImageIndex = 24
      OnExecute = actUserListExecute
    end
    object actFormFS: TAction
      Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1087#1086' '#1074#1080#1076#1072#1084' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080' 2010'
      ImageIndex = 14
      OnExecute = actFormSobstvExecute
    end
    object actBackup: TAction
      Caption = #1056#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1077' '#1080' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077'...'
      Hint = #1056#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1077' '#1080' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 44
      OnExecute = actBackupExecute
    end
    object actFormSVT: TAction
      Caption = #1057#1074#1077#1076#1077#1085#1080#1103' '#1086#1073' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1080' '#1057#1042#1058' '#1080' '#1057#1055#1054
      ImageIndex = 14
      OnExecute = actFormSVTExecute
    end
    object actActivate: TAction
      Caption = '&'#1040#1082#1090#1080#1074#1072#1094#1080#1103' '#1087#1088#1086#1076#1091#1082#1090#1072'...'
      Hint = #1042#1099#1079#1086#1074' '#1084#1086#1076#1091#1083#1103' '#1072#1082#1090#1080#1074#1072#1094#1080#1080' '#1087#1088#1086#1076#1091#1082#1090#1072' '#1080' '#1089#1074#1077#1076#1077#1085#1080#1081' '#1086' '#1076#1086#1089#1090#1091#1087#1085#1099#1093' '#1083#1080#1094#1077#1085#1079#1080#1103#1093
      OnExecute = actActivateExecute
    end
    object actForm6Lst: TAction
      Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084
      ImageIndex = 14
      OnExecute = actForm6LstExecute
    end
    object actCheckAll: TAction
      Caption = 
        #1055#1088#1086#1074#1077#1088#1082#1072' '#1089#1086#1075#1083#1072#1089#1086#1074#1072#1085#1085#1086#1089#1090#1080' '#1086#1090#1095#1077#1090#1085#1099#1093' '#1076#1072#1085#1085#1099#1093' '#1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1088#1072#1073#1086#1090#1085#1080#1082#1086 +
        #1074', '#1087#1086' '#1074#1080#1076#1072#1084' '#1101#1082#1086#1085#1086#1084#1080#1095#1077#1089#1082#1086#1081' '#1076#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1080' '#1080' '#1087#1086' '#1074#1080#1076#1072#1084' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
      ImageIndex = 23
      OnExecute = dxBarButton26Click
    end
    object actFormOtr: TAction
      Caption = 
        #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1087#1086' '#1074#1080#1076#1072#1084' '#1101#1082#1086#1085#1086#1084#1080 +
        #1095#1077#1089#1082#1086#1081' '#1076#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1080' 2008'
      ImageIndex = 14
      OnExecute = actFormOtrExecute
    end
    object actFormSobstv: TAction
      Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1087#1086' '#1074#1080#1076#1072#1084' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080' 2008'
      ImageIndex = 14
      OnExecute = actFormSobstvExecute
    end
    object actGeneralQty: TAction
      Caption = #1054#1073#1097#1080#1077' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1077#1085#1085#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080
      ImageIndex = 14
      OnExecute = actGeneralQtyExecute
    end
    object actCHECK_F6: TAction
      Caption = 
        #1055#1088#1086#1074#1077#1088#1082#1072' '#1076#1072#1085#1085#1099#1093' '#1086' '#1088#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1080' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080 +
        #1081' '#1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084
      ImageIndex = 23
      OnExecute = actCHECK_F6Execute
    end
    object actExportSPO: TAction
      Category = 'DataExchange'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'"'
      OnExecute = actExportSPOExecute
    end
    object actImportSPO: TAction
      Category = 'DataExchange'
      Caption = #1048#1084#1087#1086#1088#1090' '#1072#1075#1088#1077#1075#1080#1088#1086#1074#1072#1085#1085#1099#1093' '#1092#1086#1088#1084' '#1080#1079' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'"'
      OnExecute = actImportSPOExecute
    end
    object actImport: TAction
      Category = 'DataExchange'
      Caption = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 17
      OnExecute = actImportExecute
    end
    object actExport: TAction
      Category = 'DataExchange'
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 10
      OnExecute = actExportExecute
    end
    object actImportSPOOrg: TAction
      Category = 'DataExchange'
      Caption = #1048#1084#1087#1086#1088#1090' '#1076#1072#1085#1085#1099#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' '#1080#1079' '#1057#1055#1054' "'#1041#1088#1086#1085#1080#1088#1086#1074#1072#1085#1080#1077'"'
      OnExecute = actImportSPOOrgExecute
    end
    object aSecret: TAction
      Caption = 'aSecret'
      ShortCut = 57382
    end
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    CanCustomize = False
    Categories.Strings = (
      #1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      #1050#1086#1083#1080#1095#1077#1089#1090#1074#1077#1085#1085#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1042#1059#1054
      #1060#1086#1088#1084#1099' '#1080' '#1086#1090#1095#1077#1090#1099
      #1054#1073#1084#1077#1085' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077#1081
      #1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077
      '?'
      'Default'
      #1042#1085#1077#1096#1085#1080#1077' '#1084#1086#1076#1091#1083#1080)
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
    MenusShowRecentItemsFirst = False
    PopupMenuLinks = <>
    ShowShortCutInHint = True
    UseSystemFont = True
    Left = 44
    Top = 44
    PixelsPerInch = 96
    DockControlHeights = (
      0
      0
      46
      0)
    object dxBarManager1Bar1: TdxBar
      AllowCustomizing = False
      AllowQuickCustomizing = False
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
          ItemName = 'dxBarSubItem1'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem4'
        end
        item
          Visible = True
          ItemName = 'dxsiPlugIns'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem5'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem2'
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
      UseRecentItems = False
      Visible = True
      WholeRow = True
    end
    object dxBarButton11: TdxBarButton
      Action = actOrgLst
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actSubjList
      Category = 0
    end
    object dxsiBaseLst: TdxBarSubItem
      Action = actBaseLst
      Category = 0
      ItemLinks = <>
    end
    object dxBarButton16: TdxBarButton
      Action = actForm6Lst
      Category = 1
    end
    object dxBarButton17: TdxBarButton
      Action = actFormOtr
      Category = 1
    end
    object dxBarButton23: TdxBarButton
      Action = actFormSobstv
      Category = 1
    end
    object dxBarButton18: TdxBarButton
      Action = actGeneralQty
      Category = 1
    end
    object dxBarButton19: TdxBarButton
      Action = actCHECK_F6
      Category = 1
    end
    object dxBarButton27: TdxBarButton
      Action = actFormSVT
      Category = 1
    end
    object dxBarButton28: TdxBarButton
      Action = actFAnaliz
      Category = 1
    end
    object dxBarButton4: TdxBarButton
      Action = actExportSubj
      Category = 3
    end
    object dxBarButton13: TdxBarButton
      Action = actExportOrg
      Category = 3
    end
    object dxBarButton20: TdxBarButton
      Action = actExportSPO
      Category = 3
    end
    object dxBarButton3: TdxBarButton
      Action = actImportSubj
      Category = 3
    end
    object dxBarButton5: TdxBarButton
      Action = actImportOrg
      Category = 3
    end
    object dxBarButton21: TdxBarButton
      Action = actImportSPO
      Category = 3
    end
    object dxBarButton22: TdxBarButton
      Action = actImportSPOOrg
      Category = 3
    end
    object dxBarSubItem6: TdxBarSubItem
      Action = actExport
      Category = 3
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton13'
        end>
    end
    object dxBarSubItem7: TdxBarSubItem
      Action = actImport
      Category = 3
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end>
    end
    object dxBarButton7: TdxBarButton
      Action = actSets
      Category = 4
    end
    object dxBarButton8: TdxBarButton
      Action = actConnect
      Category = 4
    end
    object dxBarButton15: TdxBarButton
      Action = actEvents
      Category = 4
    end
    object dxBarButton1: TdxBarButton
      Action = actUserList
      Category = 4
    end
    object dxBarButton12: TdxBarButton
      Action = actBackup
      Category = 4
    end
    object dxBarButton9: TdxBarButton
      Action = actHelp
      Category = 5
    end
    object dxBarButton10: TdxBarButton
      Action = actAbout
      Category = 5
    end
    object dxBarButton14: TdxBarButton
      Action = actActivate
      Category = 5
    end
    object dxBBMore: TdxBarButton
      Caption = #1059#1074#1077#1083#1080#1095#1080#1090#1100
      Category = 5
      Hint = #1059#1074#1077#1083#1080#1095#1080#1090#1100
      Visible = ivAlways
      ShortCut = 16464
      OnClick = dxBBMoreClick
    end
    object dxBBLess: TdxBarButton
      Caption = #1059#1084#1077#1085#1100#1096#1080#1090#1100
      Category = 5
      Hint = #1059#1084#1077#1085#1100#1096#1080#1090#1100
      Visible = ivAlways
      ShortCut = 16461
      OnClick = dxBBLessClick
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = '&'#1048#1089#1093#1086#1076#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton11'
        end
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxsiBaseLst'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton6'
        end>
    end
    object dxBarSubItem4: TdxBarSubItem
      Caption = '&'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1077#1085#1085#1099#1077' '#1093#1072#1088#1072#1082#1090#1077#1088#1080#1089#1090#1080#1082#1080' '#1042#1059#1054
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton16'
        end
        item
          Visible = True
          ItemName = 'dxBarButton25'
        end
        item
          Visible = True
          ItemName = 'dxBarButton24'
        end
        item
          Visible = True
          ItemName = 'dxBarButton18'
        end
        item
          Visible = True
          ItemName = 'dxBarButton27'
        end
        item
          Visible = True
          ItemName = 'dxBarButton28'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton19'
        end
        item
          Visible = True
          ItemName = 'dxBarButton26'
        end>
    end
    object dxsiPlugIns: TdxBarSubItem
      Caption = '&'#1060#1086#1088#1084#1099' '#1080' '#1086#1090#1095#1105#1090#1099
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxbReScan'
        end>
    end
    object dxBarSubItem5: TdxBarSubItem
      Caption = '&'#1054#1073#1084#1077#1085' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077#1081
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarSubItem6'
        end
        item
          Visible = True
          ItemName = 'dxBarSubItem7'
        end>
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = '&'#1040#1076#1084#1080#1085#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1080#1077
      Category = 6
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
          ItemName = 'dxBarButton15'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton12'
        end>
    end
    object dxBarSubItem3: TdxBarSubItem
      Caption = '&?'
      Category = 6
      Visible = ivAlways
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBBMore'
        end
        item
          Visible = True
          ItemName = 'dxBBLess'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton14'
        end>
    end
    object dxBarButton6: TdxBarButton
      Action = actClose
      Category = 6
    end
    object dxBarButton24: TdxBarButton
      Action = actFormFS
      Caption = #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1087#1086' '#1074#1080#1076#1072#1084' '#1089#1086#1073#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080
      Category = 6
    end
    object dxBarButton25: TdxBarButton
      Action = actFormVED
      Caption = 
        #1056#1072#1089#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1087#1086#1076#1086#1090#1095#1105#1090#1085#1099#1093' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1087#1086' '#1074#1080#1076#1072#1084' '#1101#1082#1086#1085#1086#1084#1080 +
        #1095#1077#1089#1082#1086#1081' '#1076#1077#1103#1090#1077#1083#1100#1085#1086#1089#1090#1080
      Category = 6
    end
    object dxBarButton26: TdxBarButton
      Action = actCheckAll
      Category = 6
    end
    object dxbReScan: TdxBarButton
      Action = actReScanPlugIns
      Category = 7
    end
    object dxbCfgPlugIns: TdxBarButton
      Action = actConfigPlugIns
      Category = 7
    end
  end
end

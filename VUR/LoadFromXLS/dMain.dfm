object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 233
  Width = 300
  object ExcelApplication: TExcelApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 48
    Top = 108
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'XLS'
    Filter = #1060#1072#1081#1083#1099' Microsoft Excel (*.xls)|*.xls'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Left = 192
    Top = 36
  end
  object SaveDialog: TSaveDialog
    FileName = 'report.txt'
    Filter = #1058#1077#1082#1089#1090#1086#1074#1099#1077' '#1092#1072#1081#1083#1099' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*||'#13#10
    Left = 204
    Top = 108
  end
  object dbMain: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=C:\Pr' +
      'ogram Files\GranVUS\Data\granvus.mdb;Mode=Share Deny None;Jet OL' +
      'EDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:Data' +
      'base Password=45q81ste1109;Jet OLEDB:Engine Type=5;Jet OLEDB:Dat' +
      'abase Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLE' +
      'DB:Global Bulk Transactions=1;Jet OLEDB:New Database Password=""' +
      ';Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Databa' +
      'se=False;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:' +
      'Compact Without Replica Repair=False;Jet OLEDB:SFP=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    OnExecuteComplete = DBMainExecuteComplete
    OnWillExecute = DBMainWillExecute
    Left = 52
    Top = 36
  end
end

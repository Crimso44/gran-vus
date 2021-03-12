object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 233
  Width = 300
  object DBMain: TADOConnection
    LoginPrompt = False
    OnExecuteComplete = DBMainExecuteComplete
    OnWillExecute = DBMainWillExecute
    Left = 52
    Top = 40
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'MDB'
    Filter = #1060#1072#1081#1083#1099' Microsoft Access (*.mdb)|*.mdb'
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
  object DBFrom: TADOConnection
    LoginPrompt = False
    OnExecuteComplete = DBMainExecuteComplete
    OnWillExecute = DBMainWillExecute
    Left = 52
    Top = 120
  end
  object QueryTo: TADOQuery
    Connection = DBMain
    Parameters = <>
    Left = 128
    Top = 40
  end
  object QueryFrom: TADOQuery
    Connection = DBFrom
    Parameters = <>
    Left = 128
    Top = 120
  end
end

object dmSPOBron: TdmSPOBron
  OldCreateOrder = False
  Height = 150
  Width = 215
  object SaveDialog: TSaveDialog
    HelpContext = 528
    DefaultExt = 'bob'
    FileName = 'SPOBron.bob'
    Filter = #1060#1072#1081#1083#1099' '#1101#1082#1089#1087#1086#1088#1090#1072' (*.bob)|*.bob|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofShowHelp, ofNoReadOnlyReturn, ofEnableSizing]
    Left = 52
    Top = 48
  end
  object qry: TADOQuery
    Connection = dmMain.dbMain
    ParamCheck = False
    Parameters = <>
    Left = 128
    Top = 52
  end
end

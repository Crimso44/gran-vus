object dmEventListPrint: TdmEventListPrint
  OldCreateOrder = False
  Height = 150
  Width = 215
  object EkRTF1: TEkRTF
    InFile = 'C:\VSS\GranVUS\Source\EventList.rtf'
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    UDFList = EkUDFList1
    Charset = DEFAULT_CHARSET
    Lang = 0
    Options = [eoGraphicsBinary, eoDotAsColon]
    DisableControls = False
    Left = 16
    Top = 16
  end
  object Event: TADOQuery
    Connection = dmMain.dbMain
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      'SELECT Event.*'
      
        '     , Users.Fam+'#39' '#39'+Left(Users.Im,1)+'#39'.'#39'+Left(Users.Otch,1)+'#39'. ' +
        '('#39'+Users.Login+'#39')'#39' AS WhoLogin'
      
        '     , IIF(EXISTS(SELECT Event_ID FROM EventDetail WHERE Event_I' +
        'D=Event.Event_ID), 1, 0) AS DetailExists'
      'FROM Event LEFT OUTER JOIN Users ON Event.Who=Users.ID'
      'WHERE (1=1)')
    Left = 80
    Top = 16
  end
  object Detail: TADOQuery
    Connection = dmMain.dbMain
    DataSource = dsEvent
    Parameters = <
      item
        Name = 'Event_ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      'SELECT * FROM EventDetail WHERE Event_ID=:Event_ID')
    Left = 80
    Top = 64
  end
  object dsEvent: TDataSource
    DataSet = Event
    Left = 140
    Top = 16
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1Functions0Calculate
        Name = 'BitToBool'
        ArgMinCount = 1
        ArgMaxCount = 1
        ResultType = 1
      end>
    Left = 20
    Top = 68
  end
end

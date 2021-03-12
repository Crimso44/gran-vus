object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 479
  Width = 741
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    Charset = DEFAULT_CHARSET
    Lang = 1049
    Options = [eoGraphicsBinary, eoClearMissedFields, eoDotAsColon]
    DisableControls = True
    Left = 32
    Top = 68
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
    Left = 32
    Top = 16
  end
  object qrPers: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P.Pers_Id, p.Fam+'#39' '#39'+left(p.Im,1)+'#39'.'#39'+left(p.Otch,1)+'#39'.'#39' ' +
        'as Pers_FIO, d.dep_name as Pers_Dep, pp.Post_Name as Pers_Post,'
      '  r.depart, r.post, r.fio, r.war, r.repl_pers_id'
      'From ((((Person p'
      'inner join AppointmentLastAll a on a.Pers_Id = p.pers_id)'
      'inner join KDepart d on d.dep_id = a.dep_id)'
      'inner join KPost pp on pp.post_id = a.post_Id)'
      'left join ReplacePlan r on r.pers_id = p.pers_Id)'
      'where p.WUchet1 <> '#39#39
      'and ((p.W_DEND is null) or p.W_DEND > Date())'
      'and ((p.out_date is null) or p.out_date > Date())'
      'order by 2')
    Left = 80
    Top = 16
  end
  object mReplacePlan: TdxMemData
    Indexes = <>
    SortOptions = []
    AfterPost = mReplacePlanAfterPost
    OnCalcFields = mReplacePlanCalcFields
    Left = 352
    Top = 224
    object mReplacePlanPers_id: TIntegerField
      FieldName = 'Pers_id'
    end
    object mReplacePlanPers_Fio: TStringField
      FieldName = 'Pers_Fio'
      Size = 255
    end
    object mReplacePlanPers_Dep: TStringField
      FieldName = 'Pers_Dep'
      Size = 255
    end
    object mReplacePlanPers_Post: TStringField
      FieldName = 'Pers_Post'
      Size = 255
    end
    object mReplacePlanRepl_Id: TIntegerField
      FieldName = 'Repl_Id'
    end
    object mReplacePlanRepl_Fio: TStringField
      FieldName = 'Repl_Fio'
      Size = 255
    end
    object mReplacePlanRepl_Dep: TStringField
      FieldName = 'Repl_Dep'
      Size = 255
    end
    object mReplacePlanRepl_Post: TStringField
      FieldName = 'Repl_Post'
      Size = 255
    end
    object mReplacePlanRepl_War: TStringField
      FieldName = 'Repl_War'
      Size = 255
    end
    object mReplacePlannn: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'nn'
      Calculated = True
    end
  end
  object ImageList1: TImageList
    Left = 208
    Top = 80
    Bitmap = {
      494C0101030008002C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008080800080808000808080008080800080808000808080008080
      80000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000840000848484000084
      0000848484000084000084848400008400008484840000840000848484000084
      0000848484000084000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000000000000000000000000000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084848400008400008484
      8400008400008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000C0C0C0000000000000000000C0C0C000C0C0C000C0C0
      C0000000000000000000000000000000000000000000FFFFFF00C0C0C000FFFF
      FF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFF
      FF00C0C0C000FFFFFF00C0C0C000000000000000000084848400FFFFFF000084
      0000848484000084000084848400008400008484840000840000FFFFFF000084
      0000848484000084000000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000080808000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C0000000000000000000000000000000000000000000C0C0C000FFFFFF00C0C0
      C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0
      C000FFFFFF000000FF00FFFFFF00000000000000000000840000FFFFFF008484
      84000084000084848400008400008484840000840000FFFFFF00008400008484
      840000840000FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00C0C0C000FFFF
      FF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFFFF00C0C0C000FFFF
      FF00C0C0C000FFFFFF00C0C0C000000000000000000084848400FFFFFF000084
      000084848400008400008484840000840000FFFFFF0000840000848484000084
      000084848400FFFFFF0000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000FFFFFF00FFFF
      FF00008400008484840000840000FFFFFF000084000084848400008400008484
      840000840000FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000084848400FFFFFF00FFFF
      FF00FFFFFF0000840000FFFFFF0000840000848484000084000084848400FFFF
      FF00FFFFFF00FFFFFF0000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000000000000000000000000000FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000840000FFFFFF00FFFF
      FF0000840000FFFFFF0000840000848484000084000084848400008400008484
      8400FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000084848400FFFFFF000084
      0000FFFFFF000084000084848400008400008484840000840000848484000084
      000084848400FFFFFF0000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF000000000000000000FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000840000FFFFFF008484
      840000840000848484000084000084848400FFFFFF0084848400008400008484
      840000840000FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF000000
      0000000000000000000000000000000000000000000084848400FFFFFF000084
      0000848484000084000084848400FFFFFF00FFFFFF00FFFFFF00848484000084
      000084848400FFFFFF0000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000008080800000000000000000000000000000000000000000000000
      0000FFFFFF0000000000C0C0C000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000840000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400008400008484
      8400008400008484840000840000848484000084000084848400008400008484
      8400008400008484840000840000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF8001FFFF00008003000080010000
      0001000080010000000100008001000000010000800100000001000080010000
      000100008001000000010000800100000001E007800100000001E00780010000
      0001E007800100000001E007800100000001E00F800100000001E01F80010000
      0001E03F800100008003E07FFFFF000000000000000000000000000000000000
      000000000000}
  end
  object Query1: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P.Pers_Id, p.Fam+'#39' '#39'+left(p.Im,1)+'#39'.'#39'+left(p.Otch,1)+'#39'.'#39' ' +
        'as Pers_FIO, d.dep_name as Pers_Dep, pp.Post_Name as Pers_Post,'
      '  r.depart, r.post, r.fio, r.war, r.repl_pers_id'
      'From ((((Person p'
      'inner join AppointmentLastAll a on a.Pers_Id = p.pers_id)'
      'inner join KDepart d on d.dep_id = a.dep_id)'
      'inner join KPost pp on pp.post_id = a.post_Id)'
      'left join ReplacePlan r on r.pers_id = p.pers_Id)'
      'where p.WUchet1 <> '#39#39
      'order by 2')
    Left = 128
    Top = 232
  end
  object qrSelectPerson: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT P.Pers_Id, p.Fam+'#39' '#39'+left(p.Im,1)+'#39'.'#39'+left(p.Otch,1)+'#39'.'#39' ' +
        'as Pers_FIO, d.dep_name as Pers_Dep, pp.Post_Name as Pers_Post,'
      
        'iif(iif((p.Is_War is null),0,p.Is_War)=0 or p.w_dend <= Date(),'#39 +
        #1085#1077' '#1074'/'#1086#39','
      'iif(p.WUchet1 <> '#39#39','#39#1074'/'#1086', '#1080#1084#1077#1077#1090' '#1084#1086#1073'. '#1087#1088#1077#1076#1087#1080#1089#1072#1085#1080#1077#39','
      
        'iif(p.wuchet2_iswork = 1,'#39#1074'/'#1086', '#1079#1072#1073#1088#1086#1085#1080#1088#1086#1074#1072#1085#39','#39#1074'/'#1086', '#1075#1086#1076#1085#1086#1089#1090#1100' '#1082' '#1089#1083 +
        #1091#1078#1073#1077' '#39'+p.wcat))) as war'
      'From (((Person p'
      'inner join AppointmentLastAll a on a.Pers_Id = p.pers_id)'
      'inner join KDepart d on d.dep_id = a.dep_id)'
      'inner join KPost pp on pp.post_id = a.post_Id)'
      'order by 2')
    Left = 136
    Top = 16
    object qrSelectPersonPers_Id: TIntegerField
      FieldName = 'Pers_Id'
    end
    object qrSelectPersonPers_FIO: TWideStringField
      FieldName = 'Pers_FIO'
      ReadOnly = True
      Size = 255
    end
    object qrSelectPersonPers_Dep: TWideStringField
      FieldName = 'Pers_Dep'
      Size = 50
    end
    object qrSelectPersonPers_Post: TWideStringField
      FieldName = 'Pers_Post'
      Size = 255
    end
    object qrSelectPersonwar: TWideStringField
      FieldName = 'war'
      ReadOnly = True
      Size = 255
    end
  end
  object ExcelApplication: TExcelApplication
    AutoConnect = False
    ConnectKind = ckNewInstance
    AutoQuit = False
    Left = 324
    Top = 8
  end
end
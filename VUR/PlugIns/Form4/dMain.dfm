object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 188
  Width = 400
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    UDFList = EkUDFList1
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
      'ogram Files\GranVUS\Data\xxxgranvus.mdb;Mode=Share Deny None;Jet' +
      ' OLEDB:System database="";Jet OLEDB:Registry Path="";Jet OLEDB:D' +
      'atabase Password=45q81ste1109;Jet OLEDB:Engine Type=5;Jet OLEDB:' +
      'Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet ' +
      'OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Password' +
      '="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Dat' +
      'abase=False;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Jet OLE' +
      'DB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False;'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 16
  end
  object qrPers: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'ID'
        DataType = ftInteger
        Size = -1
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT P.*, Year(Birthday) as BirthYear, KWsost.Wsost_Name, KWRa' +
        'nge.WRng_Name, Post.Post_Name, Post.Degree as AssignText, KOkpDt' +
        'r.KOkpDtr_Code, TPDP.OKVED,'
      
        'Day(Mvk.DocDate) as MvkDay, Month(Mvk.DocDate) as MvkMonth, Year' +
        '(Mvk.DocDate) as MvkYear, '
      
        'iif(AL.Post_Id = Mvk.Post_Id,Mvk.DocNumber, null) as MvkDocNumbe' +
        'r, '
      'Mvk.CallNumber,'
      'KOVK.OVK_Name, Addr.Addr_Str'
      '     , AL.WTP_ID'
      '     , AL.WCH_ID,'
      'iif(p.wsost_Id<3,left(p.VUS,3),p.vus) as vusX'
      'FROM (((((((((PERSON P '
      'LEFT OUTER JOIN Appointment as AL ON AL.ID = P.AppLast)'
      'LEFT OUTER JOIN KPost as Post ON Post.Post_ID = AL.Post_Id)'
      'LEFT OUTER JOIN KOkpDtr ON KOkpDtr.KOkpDtr_ID = Post.KOkpDtr)'
      'LEFT OUTER JOIN TPdp ON KOkpDtr.KOkpDtr_ID = TPdp.KOkpDtr)'
      'LEFT OUTER JOIN KWsost ON KWsost.Wsost_ID = P.Wsost_Id)'
      'LEFT OUTER JOIN MvkOrder as Mvk ON Mvk.Pers_ID = P.Pers_Id)'
      'LEFT OUTER JOIN KWRange ON KWRange.WRng_ID = P.WRng_Id)'
      'LEFT OUTER JOIN Addr ON Addr.Pers_Id = P.Pers_Id)'
      'left join KOVK on KOVK.OVK_ID = P.OVK_Id)'
      
        'WHERE P.PERS_ID=:ID and (IsNull(Addr.Addr_Type) or Addr.Addr_Typ' +
        'e = 0)')
    Left = 80
    Top = 16
  end
  object dsPers: TDataSource
    DataSet = qrPers
    Left = 136
    Top = 16
  end
  object qrOrg: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'ORG_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT o.*, wr.WRNG_NAME AS VKChiefRangeName, '
      
        'Left(oc1.im, 1)+". "+Left(oc1.otch, 1)+". "+oc1.fam as fio1, oc1' +
        '.post as post1, oc1.phone as phone1,'
      
        'Left(oc2.im, 1)+". "+Left(oc2.otch, 1)+". "+oc2.fam as fio2, oc2' +
        '.post as post2, oc2.phone as phone2,'
      
        'Left(o.Voenkom1I, 1)+". "+Left(o.Voenkom1O, 1)+". "+o.Voenkom1F ' +
        'as Voenkom1, '
      
        'Left(o.Voenkom2I, 1)+". "+Left(o.Voenkom2O, 1)+". "+o.Voenkom2F ' +
        'as Voenkom2, '
      
        'KOVK.OVK_Name, iif(kovk.IsOvk,"'#1042#1086#1077#1085#1085#1099#1081' '#1082#1086#1084#1080#1089#1089#1072#1088#1080#1072#1090'","'#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1094 +
        #1080#1103'") as OvkType'
      'FROM (((ORG o'
      'left join KWRANGE wr on wr.WRNG_ID = o.VKChiefRange)'
      'left join KOVK on KOVK.OVK_ID = o.OVK_Id)'
      'left join Org_Cont oc1 on oc1.orgid = o.orgid)'
      'left join Org_Cont oc2 on oc2.orgid = o.orgid'
      'WHERE o.ORGID=:ORG_ID and oc1.contid = 1 and oc2.contid = 2')
    Left = 84
    Top = 68
  end
  object qrOVK: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'OVK_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *,'
      'IIF(ISOVK, '
      '  (select Param_Value from Params Where Params.Param_Id = 12), '
      '  (select Param_Value from Params Where Params.Param_Id = 13)'
      ') as OVK'
      'FROM KOVK'
      'WHERE OVK_ID=:OVK_ID')
    Left = 345
    Top = 69
  end
  object qrVUR: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    DataSource = dsPers
    Parameters = <
      item
        Name = 'ORG_ID'
        DataType = ftFloat
        Value = Null
      end>
    SQL.Strings = (
      'SELECT *'
      'FROM ORG_CONT'
      'WHERE ORGID=:ORG_ID AND IS_GEN<>0')
    Left = 140
    Top = 68
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1NotIsNullCalculate
        Name = 'NotIsNull'
        ArgMinCount = 1
        ArgMaxCount = 16
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1EqualCalculate
        Name = 'Equal'
        ArgMinCount = 2
        ArgMaxCount = 10
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1Functions2Calculate
        Name = 'fdt'
        ArgMinCount = 1
        ArgMaxCount = 2
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1Functions3Calculate
        Name = 'IOFam'
        ArgMinCount = 3
        ArgMaxCount = 3
        ResultType = 1
      end>
    Left = 28
    Top = 121
  end
  object qrExecutor: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from ORG_Cont Where Is_Gen = 3')
    Left = 208
    Top = 32
    object qrExecutorCONTID: TIntegerField
      FieldName = 'CONTID'
    end
    object qrExecutorORGID: TIntegerField
      FieldName = 'ORGID'
    end
    object qrExecutorDEPART: TWideStringField
      FieldName = 'DEPART'
      Size = 50
    end
    object qrExecutorPOST: TWideStringField
      FieldName = 'POST'
      Size = 50
    end
    object qrExecutorFIO: TWideStringField
      FieldName = 'FIO'
      Size = 150
    end
    object qrExecutorPHONE: TWideStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object qrExecutorFAX: TWideStringField
      FieldName = 'FAX'
      Size = 50
    end
    object qrExecutorEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object qrExecutorIS_GEN: TSmallintField
      FieldName = 'IS_GEN'
    end
    object qrExecutorIS_VUS: TSmallintField
      FieldName = 'IS_VUS'
    end
    object qrExecutorFAM: TWideStringField
      FieldName = 'FAM'
      Size = 50
    end
    object qrExecutorIM: TWideStringField
      FieldName = 'IM'
      Size = 50
    end
    object qrExecutorOTCH: TWideStringField
      FieldName = 'OTCH'
      Size = 50
    end
  end
end

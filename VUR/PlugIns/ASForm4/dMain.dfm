object dmMain: TdmMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 263
  Width = 430
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
    Left = 18
    Top = 32
  end
  object EkRTF1: TEkRTF
    OutFile = 'outfile.doc'
    TrueValue = 'True'
    FalseValue = 'False'
    UDFList = EkUDFList1
    Charset = DEFAULT_CHARSET
    Lang = 0
    Options = [eoGraphicsBinary, eoDotAsColon]
    DisableControls = True
    Left = 89
    Top = 30
  end
  object EkUDFList1: TEkUDFList
    Functions = <
      item
        OnCalculate = EkUDFList1dateCalculate
        Name = 'date'
        ArgMinCount = 0
        ArgMaxCount = 0
        ResultType = 1
      end
      item
        OnCalculate = EkUDFList1NotIsNullCalculate
        Name = 'NotIsNull'
        ArgMinCount = 1
        ArgMaxCount = 16
        ResultType = 1
      end>
    Left = 157
    Top = 29
  end
  object qrOrg: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrOrgCalcFields
    Parameters = <>
    SQL.Strings = (
      
        'select o.*, oc.fam, oc.im, oc.otch, oc.POST, occ.fam as fam1, oc' +
        'c.im as im1, occ.otch as otch1, occ.POST as post1'
      'from ((ORG o'
      'left join ORG_CONT oc on (o.orgid = oc.orgid and oc.is_gen = 1))'
      
        'left join ORG_CONT occ on (o.orgid = occ.orgid and occ.is_gen = ' +
        '2))')
    Left = 145
    Top = 89
    object qrOrgIOFam: TStringField
      FieldKind = fkCalculated
      FieldName = 'IOFam'
      Size = 150
      Calculated = True
    end
    object qrOrgFamIO: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamIO'
      Size = 150
      Calculated = True
    end
    object qrOrgorgname: TStringField
      FieldName = 'orgname'
      Size = 4000
    end
    object qrOrgfam: TStringField
      FieldName = 'fam'
      Size = 4000
    end
    object qrOrgIm: TStringField
      FieldName = 'Im'
      Size = 4000
    end
    object qrOrgOtch: TStringField
      FieldName = 'Otch'
      Size = 4000
    end
    object qrOrgPOST: TStringField
      FieldName = 'POST'
      Size = 4000
    end
    object qrOrgMAINOKONH: TWideStringField
      FieldName = 'MAINOKONH'
      Size = 15
    end
    object qrOrgORGID: TIntegerField
      FieldName = 'ORGID'
    end
    object qrOrgPARENT: TWideStringField
      FieldName = 'PARENT'
      Size = 100
    end
    object qrOrgFS_ID: TIntegerField
      FieldName = 'FS_ID'
    end
    object qrOrgINN: TWideStringField
      FieldName = 'INN'
      Size = 15
    end
    object qrOrgOKPO: TWideStringField
      FieldName = 'OKPO'
      Size = 8
    end
    object qrOrgOKONH: TWideMemoField
      FieldName = 'OKONH'
      BlobType = ftWideMemo
    end
    object qrOrgSOOGU: TWideStringField
      FieldName = 'SOOGU'
      Size = 7
    end
    object qrOrgKOPF_ID: TIntegerField
      FieldName = 'KOPF_ID'
    end
    object qrOrgKODREG: TWideStringField
      FieldName = 'KODREG'
      Size = 11
    end
    object qrOrgREGDATE: TDateTimeField
      FieldName = 'REGDATE'
    end
    object qrOrgREGNUM: TWideStringField
      FieldName = 'REGNUM'
    end
    object qrOrgORGSNAME: TWideStringField
      FieldName = 'ORGSNAME'
      Size = 50
    end
    object qrOrgCOMMENT: TWideMemoField
      FieldName = 'COMMENT'
      BlobType = ftWideMemo
    end
    object qrOrgFIZADDR: TWideStringField
      FieldName = 'FIZADDR'
      Size = 250
    end
    object qrOrgURADDR: TWideStringField
      FieldName = 'URADDR'
      Size = 250
    end
    object qrOrgPOSTADDR: TWideStringField
      FieldName = 'POSTADDR'
      Size = 250
    end
    object qrOrgPHONE: TWideStringField
      FieldName = 'PHONE'
      Size = 50
    end
    object qrOrgFAX: TWideStringField
      FieldName = 'FAX'
      Size = 50
    end
    object qrOrgEMAIL: TWideStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object qrOrgWWW: TWideStringField
      FieldName = 'WWW'
      Size = 100
    end
    object qrOrgMYORG: TSmallintField
      FieldName = 'MYORG'
    end
    object qrOrgCONFDATE: TDateTimeField
      FieldName = 'CONFDATE'
    end
    object qrOrgOKBV: TWideStringField
      FieldName = 'OKBV'
      Size = 12
    end
    object qrOrgFIRST_DATE: TDateTimeField
      FieldName = 'FIRST_DATE'
    end
    object qrOrgLAST_DATE: TDateTimeField
      FieldName = 'LAST_DATE'
    end
    object qrOrgEXT_ID: TIntegerField
      FieldName = 'EXT_ID'
    end
    object qrOrgF6_SHIFR: TWideStringField
      FieldName = 'F6_SHIFR'
      Size = 2
    end
    object qrOrgOCCUPATION: TWideStringField
      FieldName = 'OCCUPATION'
      Size = 150
    end
    object qrOrgSBM_ID: TIntegerField
      FieldName = 'SBM_ID'
    end
    object qrOrgTERR_ID: TIntegerField
      FieldName = 'TERR_ID'
    end
    object qrOrgHAS_BRON: TBooleanField
      FieldName = 'HAS_BRON'
    end
    object qrOrgREGPL_ID: TIntegerField
      FieldName = 'REGPL_ID'
    end
    object qrOrgOKATO2: TWideStringField
      FieldName = 'OKATO2'
      Size = 50
    end
    object qrOrgOKATO3: TWideStringField
      FieldName = 'OKATO3'
      Size = 50
    end
    object qrOrgFeature1: TWideStringField
      FieldName = 'Feature1'
      Size = 30
    end
    object qrOrgFeature2: TWideStringField
      FieldName = 'Feature2'
      Size = 30
    end
    object qrOrgFeature3: TWideStringField
      FieldName = 'Feature3'
      Size = 30
    end
    object qrOrgOVK_ID: TIntegerField
      FieldName = 'OVK_ID'
    end
    object qrOrgLicense1: TWideStringField
      FieldName = 'License1'
      Size = 30
    end
    object qrOrgLicense1_date: TDateTimeField
      FieldName = 'License1_date'
    end
    object qrOrgLicense1Who: TWideStringField
      FieldName = 'License1Who'
      Size = 255
    end
    object qrOrgLicense2: TWideStringField
      FieldName = 'License2'
      Size = 30
    end
    object qrOrgLicense2_date: TDateTimeField
      FieldName = 'License2_date'
    end
    object qrOrgLicense2Who: TWideStringField
      FieldName = 'License2Who'
      Size = 255
    end
    object qrOrgCertificate: TWideStringField
      FieldName = 'Certificate'
      Size = 30
    end
    object qrOrgBeginCertificate_date: TDateTimeField
      FieldName = 'BeginCertificate_date'
    end
    object qrOrgEndCertificate_date: TDateTimeField
      FieldName = 'EndCertificate_date'
    end
    object qrOrgCertificateWho: TWideStringField
      FieldName = 'CertificateWho'
      Size = 255
    end
    object qrOrgWhoPuts: TWideStringField
      FieldName = 'WhoPuts'
      Size = 255
    end
    object qrOrgHasVK: TBooleanField
      FieldName = 'HasVK'
    end
    object qrOrgVKChief: TWideStringField
      FieldName = 'VKChief'
      Size = 100
    end
    object qrOrgVKChiefRange: TIntegerField
      FieldName = 'VKChiefRange'
    end
    object qrOrgKODOKTMO: TWideStringField
      FieldName = 'KODOKTMO'
      Size = 11
    end
    object qrOrgKODOKTMO2: TWideStringField
      FieldName = 'KODOKTMO2'
      Size = 11
    end
    object qrOrgREGPLACE: TWideStringField
      FieldName = 'REGPLACE'
      Size = 100
    end
    object qrOrgCOMPUTERS: TIntegerField
      FieldName = 'COMPUTERS'
    end
    object qrOrgSOFTWARENUM: TIntegerField
      FieldName = 'SOFTWARENUM'
    end
    object qrOrgSOFTWARE: TWideStringField
      FieldName = 'SOFTWARE'
      Size = 255
    end
    object qrOrgfam1: TWideStringField
      FieldName = 'fam1'
      Size = 50
    end
    object qrOrgim1: TWideStringField
      FieldName = 'im1'
      Size = 50
    end
    object qrOrgotch1: TWideStringField
      FieldName = 'otch1'
      Size = 50
    end
    object qrOrgpost1: TWideStringField
      FieldName = 'post1'
      Size = 50
    end
    object qrOrgIOFam1: TStringField
      FieldKind = fkCalculated
      FieldName = 'IOFam1'
      Size = 250
      Calculated = True
    end
    object qrOrgFamIO1: TStringField
      FieldKind = fkCalculated
      FieldName = 'FamIO1'
      Size = 250
      Calculated = True
    end
  end
  object qrMaster: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrDetailCalcFields
    Parameters = <>
    SQL.Strings = (
      'select '
      
        '  iif((KASFMtr.ShortName is null), KASFMtr.Name, KASFMtr.ShortNa' +
        'me) As KASFMtrName, KASFMtrSub.Name, '
      
        '  iif((ASF.OrgSName is null), ASF.OrgName, ASF.OrgSName) As dep_' +
        'name, '
      
        '  sum(AsMtrList.GeneralPlan) as GenPlan, sum(AsMtrList.GeneralQt' +
        'y) as GenQty'
      'from ((((KASFMtr'
      'left join KASFMtrSub on KASFMtrSub.KASFMtr_Id = KASFMtr.id)'
      'inner join AsfMtr on ASFMtr.KASFMtr_Id = KASFMtr.Id)'
      'inner join '
      '('
      
        'select ASP_ID, ASF_ID, Name, DEP_Name, ASP_Num, ASP_Type From AS' +
        'P'
      'union'
      
        'select -ASF_ID, ASF_ID, iif((OrgSName is null), OrgName, OrgSNam' +
        'e), iif((OrgSName is null), OrgName, OrgSName), -1, null From AS' +
        'F'
      ')'
      
        'As ASP on iif((ASP.ASP_Id is null),0, iif((KASFMtr.Id is null),0' +
        ',1))=1)'
      'Inner join ASF on ASP.ASF_Id = ASF.ASF_Id)'
      'Left join AsMtrList on AsMtrList.ASFMtr_Id = ASFMtr.Id'
      
        'Where iif((ASFMtr.KASFMtrSub_Id is null), 0, ASFMtr.KASFMtrSub_I' +
        'd) = iif((KASFMtrSub.Id is null), 0, KASFMtrSub.Id)'
      '  and (AsMtrList.ASP_Id = ASP.ASP_Id)'
      '  and ASF.ASF_Id in (%ASF%)'
      '  and KASFMtr.Id in (%MTR%)'
      'Group By'
      
        '  iif((KASFMtr.ShortName is null), KASFMtr.Name, KASFMtr.ShortNa' +
        'me), KASFMtrSub.Name, '
      '  iif((ASF.OrgSName is null), ASF.OrgName, ASF.OrgSName) '
      'order by 1,2, 3')
    Left = 98
    Top = 151
  end
  object mData: TdxMemData
    Indexes = <>
    SortOptions = []
    OnCalcFields = mDataCalcFields
    Left = 200
    Top = 116
    object mDataRecNo: TIntegerField
      FieldName = 'RecNo'
    end
    object mDataDep_NameX: TStringField
      FieldName = 'Dep_NameX'
      Size = 200
    end
    object mDatahead: TBooleanField
      FieldName = 'head'
    end
    object mDatahead2: TBooleanField
      FieldName = 'head2'
    end
    object mDataN1: TIntegerField
      FieldName = 'N1'
    end
    object mDataN2: TIntegerField
      FieldName = 'N2'
    end
    object mDataN3: TIntegerField
      FieldName = 'N3'
    end
    object mDataN4: TIntegerField
      FieldName = 'N4'
    end
    object mDataN5: TIntegerField
      FieldName = 'N5'
    end
    object mDataN6: TIntegerField
      FieldName = 'N6'
    end
    object mDataN7: TIntegerField
      FieldName = 'N7'
    end
    object mDataM1: TIntegerField
      FieldName = 'M1'
    end
    object mDataM2: TIntegerField
      FieldName = 'M2'
    end
    object mDataM3: TIntegerField
      FieldName = 'M3'
    end
    object mDataM4: TIntegerField
      FieldName = 'M4'
    end
    object mDataM5: TIntegerField
      FieldName = 'M5'
    end
    object mDataM6: TIntegerField
      FieldName = 'M6'
    end
    object mDataM7: TIntegerField
      FieldName = 'M7'
    end
    object mDataheadX: TBooleanField
      FieldName = 'headX'
    end
    object mDataNM1: TStringField
      FieldKind = fkCalculated
      FieldName = 'NM1'
      Calculated = True
    end
    object mDataNM2: TStringField
      FieldKind = fkCalculated
      FieldName = 'NM2'
      Calculated = True
    end
    object mDataNM3: TStringField
      FieldKind = fkCalculated
      FieldName = 'NM3'
      Calculated = True
    end
    object mDataNM4: TStringField
      FieldKind = fkCalculated
      FieldName = 'NM4'
      Calculated = True
    end
    object mDataNM5: TStringField
      FieldKind = fkCalculated
      FieldName = 'NM5'
      Calculated = True
    end
    object mDataNM6: TStringField
      FieldKind = fkCalculated
      FieldName = 'NM6'
      Calculated = True
    end
    object mDataNM7: TStringField
      FieldKind = fkCalculated
      FieldName = 'NM7'
      Calculated = True
    end
  end
  object qrStaffPlan: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrDetailCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      
        '  iif((ASF.OrgSName is null), ASF.OrgName, ASF.OrgSName) As dep_' +
        'name,   '
      '  sum(ASStaffList.GeneralPlan) As GenPlan'
      'FROM ('
      '('
      
        'select ASP_ID, ASF_ID, Name, DEP_Name, ASP_Num, ASP_Type From AS' +
        'P'
      'union'
      
        'select -ASF_ID, ASF_ID, iif((OrgSName is null), OrgName, OrgSNam' +
        'e), iif((OrgSName is null), OrgName, OrgSName), -1, null From AS' +
        'F'
      ')'
      'As ASP INNER JOIN ASF ON ASP.ASF_ID = ASF.ASF_ID)'
      'Inner JOIN ASStaffList ON ASP.[ASP_ID] = ASStaffList.[ASP_ID]'
      'Where ASF.ASF_ID in (%ASF%)'
      'Group By'
      '  iif((ASF.OrgSName is null), ASF.OrgName, ASF.OrgSName) ')
    Left = 192
    Top = 165
  end
  object qrStaffQty: TADOQuery
    Connection = dbMain
    CursorType = ctStatic
    OnCalcFields = qrDetailCalcFields
    Parameters = <>
    SQL.Strings = (
      'SELECT '
      
        '  iif((ASF.OrgSName is null), ASF.OrgName, ASF.OrgSName) As dep_' +
        'name,   '
      
        '  Count(IIf(PERSON.PERS_ID Is Not Null And (PERSON.ASOUT_DATE Is' +
        ' Null Or PERSON.ASOUT_DATE>Date()),1,Null)) As GenQty'
      'FROM (('
      '('
      
        'select ASP_ID, ASF_ID, Name, DEP_Name, ASP_Num, ASP_Type From AS' +
        'P'
      'union'
      
        'select -ASF_ID, ASF_ID, iif((OrgSName is null), OrgName, OrgSNam' +
        'e), iif((OrgSName is null), OrgName, OrgSName), -1, null From AS' +
        'F'
      ')'
      'As ASP INNER JOIN ASF ON ASP.ASF_ID = ASF.ASF_ID)'
      
        'Inner JOIN ASAppointmentLastAll ON ASP.[ASP_ID] = ASAppointmentL' +
        'astAll.[ASP_ID])'
      
        'Inner Join Person on Person.Pers_Id = ASAppointmentLastAll.Pers_' +
        'Id'
      'Where ASF.ASF_ID in (%ASF%)'
      'Group By'
      '  iif((ASF.OrgSName is null), ASF.OrgName, ASF.OrgSName) ')
    Left = 262
    Top = 169
  end
end

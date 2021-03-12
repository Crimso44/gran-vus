select
1 as RecNo,
o.OrgName,
o.MAINOKONH,
o.Occupation,
IIF(k.ISOVK, 'Начальнику отдела военного комиссариата', 'Руководителю') as ISOVK,
k.OVK_NAME,
k.OVK_ADDR,
(select sum(GeneralQty) from StaffListAll) as AllPers,

(select count(*) from (Person P
inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)
where Org_Id = o.OrgId and
(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Date())) and
(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(Date())) and (
         (P.MALE=1 and (kr.M_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.M_LIMIT  ) or
         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.FEM_LIMIT  ))
        ,1,0)) = 0)
and kr.State <> 0 AND kr.CHE > 0 and
(((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)
OR ((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))
) as AllReserve,

(select count(*) from (Person P
inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)
where Org_Id = o.OrgId and
(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Date())) and
(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(Date())) and (
         (P.MALE=1 and (kr.M_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.M_LIMIT  ) or
         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.FEM_LIMIT  ))
        ,1,0)) = 0)
and kr.State = 3 AND kr.CHE > 0 and
(((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)
OR ((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))
) as AllOfficerReserve,

(select count(*) from (Person P
inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)
where Org_Id = o.OrgId and not IsNull(WUchet2) AND
(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Date())) and
(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(Date())) and (
         (P.MALE=1 and (kr.M_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.M_LIMIT  ) or
         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.FEM_LIMIT  ))
        ,1,0)) = 0) and
kr.CHE > 0 and
(((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)
OR ((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))
) as AllBron,

(select count(*) from (Person P
inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)
where Org_Id = o.OrgId and not IsNull(WUchet2) and
(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Date())) and
(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(Date())) and (
         (P.MALE=1 and (kr.M_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.M_LIMIT  ) or
         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.FEM_LIMIT  ))
        ,1,0)) = 0)
and kr.State = 3 AND kr.CHE > 0 and
(((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)
OR ((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))
) as AllOfficerBron,

Iif(AllReserve>0,Round(AllBron/AllReserve*100,1),0) as BronPercent,

(select count(*) from (Person P
inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)
where Org_Id = o.OrgId and not IsNull(WUchet1) AND
(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Date())) and
(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(Date())) and (
         (P.MALE=1 and (kr.M_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.M_LIMIT  ) or
         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.FEM_LIMIT  ))
        ,1,0)) = 0)
AND kr.CHE > 0 and
(((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)
OR ((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))
) as AllAttached,

(select count(*) from (Person P
inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)
where Org_Id = o.OrgId and not IsNull(WUchet1) and
(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Date())) and
(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(Date())) and (
         (P.MALE=1 and (kr.M_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.M_LIMIT  ) or
         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.FEM_LIMIT  ))
        ,1,0)) = 0)
and kr.State = 3 AND kr.CHE > 0 and
(((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)
OR ((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))
) as AllOfficerAttached,

Iif(AllReserve>0,Round(AllAttached/AllReserve*100,1),0) as AttachedPercent,

(select count(*) from (Person P
inner join KWRange kr on kr.WRNG_Id = P.WRNG_Id)
where Org_Id = o.OrgId and P.WRNG_ID = 1 AND
(P.Is_War = 1 and (P.W_DEND is null or Year(P.W_DEND) >= Year(Date())) and
(IIF((P.W_DEND is NULL or Year(P.W_DEND) >= Year(Date())) and (
         (P.MALE=1 and (kr.M_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.M_LIMIT  ) or
         (P.MALE=0 and (kr.FEM_LIMIT is not NULL) and  YEAR(date())-YEAR(P.BIRTHDAY)>kr.FEM_LIMIT  ))
        ,1,0)) = 0) and
(((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)
OR ((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))
) as AllConscript

from (ORG o
inner join KOVK k on k.OVK_ID = o.OVK_ID)

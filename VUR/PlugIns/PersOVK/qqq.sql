select P.*,KWR.*,KWS.*,KED.*,A.*,A1.POST_CODE as POST_CODE1,A1.ADDR_STR as ADDR_STR1,PH.*,KFST.*
,AppointmentLastAll.*,KP.*,IIF(KD.DEP_FULL_NAME is null, KD.DEP_NAME, KD.DEP_FULL_NAME) as DEP_FULL_NAME
,

  iif(IsNull(Kuz.UZ_NAME)   ,"",", "&Kuz.UZ_NAME)
 &iif(IsNull(Educ.END_DATE) ,"",", "&Educ.END_DATE)
 &iif(IsNull(Educ.KVAL)     ,"",", "&Educ.KVAL)
 &iif(IsNull(Educ.NAPR)     ,"",", "&Educ.NAPR) as Educ1,

  iif(IsNull(Kuz2.UZ_NAME)  ,"",", "&Kuz2.UZ_NAME)
 &iif(IsNull(Educ2.END_DATE),"",", "&Educ2.END_DATE)
 &iif(IsNull(Educ2.KVAL)    ,"",", "&Educ2.KVAL)
 &iif(IsNull(Educ2.NAPR)    ,"",", "&Educ2.NAPR) as Educ2,

  iif(IsNull(Kuz3.UZ_NAME)  ,"",", "&Kuz3.UZ_NAME)
 &iif(IsNull(Educ3.END_DATE),"",", "&Educ3.END_DATE)
 &iif(IsNull(Educ3.KVAL)    ,"",", "&Educ3.KVAL)
 &iif(IsNull(Educ3.NAPR)    ,"",", "&Educ3.NAPR) as Educ3,

 iif(IsNull(P.PROF1)       ,"",", "&P.PROF1) as Prof1
 
from (((((((((((((((Person P
left outer join KWRANGE KWR  on (P.WRNG_ID=KWR.WRNG_ID))
left outer join KWSOST  KWS  on (P.WSOST_ID=KWS.WSOST_ID))
left outer join KEDUC   KED  on (P.ED_ID=KED.ED_ID))
left outer join ADDR    A    on (P.PERS_ID=A.PERS_ID AND (A.ADDR_TYPE=0 or A.ADDR_TYPE is null)))
left outer join ADDR    A1   on (P.PERS_ID=A1.PERS_ID AND A1.ADDR_TYPE=1))
left outer join PHONES  PH   on (P.PERS_ID=PH.PERS_ID AND (PH.PH_TYPE=2 or PH.PH_TYPE is null)))
left outer join KFSTATE KFST on (P.FST_ID=KFST.FST_ID))
left outer join AppointmentLastAll on (P.Pers_Id=AppointmentLastAll.Pers_Id))
left outer join [KPOST] KP on (AppointmentLastAll.POST_ID=[KP].POST_ID))
left outer join [KDEPART] KD on (AppointmentLastAll.DEP_ID=[KD].DEP_ID))
left outer join [Educ] on (P.PERS_ID=[Educ].PERS_ID and [Educ].type=1))
left outer join [Educ] as Educ2 on (P.PERS_ID=[Educ2].PERS_ID and [Educ2].type=2))
left outer join [Educ] as Educ3 on (P.PERS_ID=[Educ3].PERS_ID and [Educ3].type=3))
left outer join [KUz] on [KUz].UZ_ID=[Educ].UZ_ID)
left outer join [KUz] as KUz2 on [KUz2].UZ_ID=[Educ2].UZ_ID)
left outer join [KUz] as KUz3 on [KUz3].UZ_ID=[Educ3].UZ_ID

WHERE P.OVK_ID=:OVK_ID
  AND P.IS_WAR<>0
  AND (P.W_DEND is  null or Year(P.W_DEND) >= Year(Date()))
  and ((select COUNT(*) from PERS_SET)=0 or P.PERS_ID in (select PERS_ID from PERS_SET))
AND 
(((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id <> 500)) IS NOT NULL AND P.OUT_ORD_DATE IS NULL)
OR ((select max(In_Date) from Appointment where pers_id = P.pers_id and post_id in (select post_id from kpost where cprof_id = 500)) IS NOT NULL AND P.ORDERDISMISSAL_DATE IS NULL))
ORDER BY P.FAM, P.IM, P.OTCH


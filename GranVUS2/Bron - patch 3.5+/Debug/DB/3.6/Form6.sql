update Form6
set Form6.EXPRESSION=KCPROF.EXPRESSION
from Form6 join KCPROF on Form6.CPROF_ID=KCPROF.CPROF_ID
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, 'ќбновлено значение пол€ EXPRESSION таблицы FORM6 из справочника KCPROF'
from VerInfo
where VerStr='3.6'
GO

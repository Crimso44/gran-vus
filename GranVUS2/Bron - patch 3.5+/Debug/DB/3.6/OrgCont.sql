alter table ORG_CONT add Fam varchar(50) null
GO
alter table ORG_CONT add Im varchar(50) null
GO
alter table ORG_CONT add Otch varchar(50) null
GO
declare cont cursor for select contid, fio from org_cont
declare @contid int, @fio varchar(50), @fam varchar(50), @im varchar(50), @otch varchar(50), @n int
open cont
fetch next from cont
into @contid,@fio
while @@FETCH_STATUS=0 begin
  set @n=CHARINDEX(' ',@fio)
  if @n=0 begin
    set @fam=@fio
    set @im=''
    set @otch=''
  end
  else begin
    set @fam=LEFT(@fio,@n-1)
    set @fio=RIGHT(@fio,LEN(@fio)-@n)
    set @n=CHARINDEX(' ',@fio)
    if @n=0 begin
      set @im=@fio
      set @otch=''
    end
    else begin
      set @im=LEFT(@fio,@n-1)
      set @otch=RIGHT(@fio,LEN(@fio)-@n)
    end
  end

  update ORG_CONT
  set FAM=@fam, IM=@im, OTCH=@otch
  where CONTID=@contid
fetch next from cont
into @contid,@fio
end
close cont
deallocate cont
GO
alter table ORG_CONT drop column FIO
GO
alter table ORG_CONT add FIO as ISNULL(Fam,'')+' '+ISNULL(Im,'')+' '+ISNULL(Otch,'')
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, 'Добавлены поля в таблицу ORG_CONT Fam,Im,Otch varchar(50) null, поле FIO - вычесляемое как сумма'
from VerInfo
where VerStr='3.6'
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ExtractNumber]') and xtype in (N'FN', N'IF', N'TF'))
drop function [dbo].[ExtractNumber]
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO
CREATE FUNCTION [dbo].[ExtractNumber] (@value varchar(250))
RETURNS int
AS  
BEGIN 
DECLARE  @res varchar(250), @n int, @ch char(1)
  SET @n=1
  SET @res=''
  WHILE @n<=LEN(@value) BEGIN
    SET @ch=SUBSTRING(@value,@n,1)
    IF CHARINDEX(@ch,'0123456789')>0 
     SET @res = @res + @ch
    ELSE
     IF @res<>'' BREAK
    SET @n=@n+1
  END
  IF @res='' RETURN null
  RETURN CAST(@res as int)
END
GO
insert into VerChanges(VerId,VerChgDesc)
select VerId, 'Создана UDF ExtractNumber'
from VerInfo
where VerStr='3.6'
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


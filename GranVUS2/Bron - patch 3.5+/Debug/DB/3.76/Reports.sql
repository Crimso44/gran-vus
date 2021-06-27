if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FFS2010]'))
begin
        create table FFS2010 (
                SUBJ_ID int not null,
                FS_ID int,
                FS_NAME varchar(100),
                KOD varchar(2),
                CITY int,
                TOWN int,
                VILLAGE int,
                TOWNVILLAGE int,
                INCITY int
        )
end
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFS2010Clear]'))
DROP PROCEDURE [dbo].[sp_FFS2010Clear]
GO

CREATE  PROCEDURE [dbo].[sp_FFS2010Clear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FFS2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50100 'Невозможно удалить форму по видам собственности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFS2010Create]'))
DROP PROCEDURE [dbo].[sp_FFS2010Create]
GO

CREATE  PROCEDURE [dbo].[sp_FFS2010Create]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FFS2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50200 'Невозможно создать форму по видам собственности.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FFS2010(SUBJ_ID, FS_ID, FS_NAME, KOD)
        SELECT @SUBJ_ID, FS_ID, FS_NAME, KOD FROM KFS_
        if @@ERROR != 0
        begin
                raiserror 50201 'Невозможно создать форму по видам собственности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FFS2010Generate]'))
DROP PROCEDURE [dbo].[sp_FFS2010Generate]
GO

CREATE  PROCEDURE [dbo].[sp_FFS2010Generate]
        @SUBJ_ID        int,
        @FilterType     int
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from v_ORG_CALC

    insert into [dbo].[#SubjSet]
    select Subj_Id from v_Subj_Calc
  end

  if @FilterType=1 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org join KTerr on Org.Terr_Id=KTerr.Terr_Id
    where KTerr.KodTerr LIKE
    ( select  dbo.GetSubjMask(KTERR.KODTERR)
      from CURR_SUBJ
      join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID
      join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)
    and OrgId in (SELECT ORGID FROM v_ORG_CALC)

    insert into [dbo].[#SubjSet]
    select Subj_Id from Subj join KTerr on Subj.Terr_Id=KTerr.Terr_Id
    where Subj_Id in (select * from v_Subj_Calc) and KTerr.KodTerr LIKE
    ( select  dbo.GetSubjMask(KTERR.KODTERR)
      from CURR_SUBJ
      join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID
      join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)
   end;

  if @FilterType=2
    insert into [dbo].[#OrgSet]
    select OrgId from OrgSet where OrgId in (SELECT ORGID FROM v_ORG_CALC)



  DELETE FROM FFS2010
  WHERE SUBJ_ID = @SUBJ_ID

  if @@ERROR != 0
  begin
    raiserror 50300 'Невозможно создать форму по видам собственности.'
    ROLLBACK TRANSACTION
    return
  end

  INSERT INTO FFS2010(
    SUBJ_ID
  , FS_ID
  , FS_NAME
  , KOD
  , CITY
  , TOWN
  , VILLAGE
  , TOWNVILLAGE
  , INCITY
  )
  SELECT @SUBJ_ID, K.FS_ID, K.FS_NAME, K.KOD
  , NULLIF(SUM(CITY),0) AS CITY
  , NULLIF(SUM(TOWN),0) AS TOWN
  , NULLIF(SUM(VILLAGE),0) AS VILLAGE
  , NULLIF(SUM(TOWNVILLAGE),0) AS TOWNVILLAGE
  , NULLIF(SUM(INCITY),0) AS INCITY
  FROM KFS_ K LEFT OUTER JOIN
       (select
        FS_ID = CASE WHEN OO.FS_ID IN (SELECT FS_ID FROM KFS_)
                  THEN OO.FS_ID ELSE 0 END
                , CITY = case when SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '40' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '45' and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '7' or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '850' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '898') or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '950' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '998')) then 1 else 0 end
                , TOWN = case when SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '1' then 1 else 0 end
                , VILLAGE = case when SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 1 else 0 end
                , TOWNVILLAGE = case when SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '7' then 1 else 0 end
                , INCITY = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '40' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '45') and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '3' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '9') then 1 else 0 end
        from v_ORG OO
        where OO.OUT_DATE IS NULL
          AND OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
                and EXISTS(SELECT * FROM FORM6HDR, FORM6
                                     WHERE FORM6HDR.OrgID=OO.ORGID
                                       AND FORM6.F6_ID=FORM6HDR.F6_ID
                                       AND FORM6.COL_B=24
                                       AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0)
       ) O ON (O.FS_ID = K.FS_ID)
  GROUP BY K.FS_ID, K.FS_NAME, K.KOD

  if @@ERROR != 0
  begin
        raiserror 50301 'Невозможно создать форму по видам собственности.'
        ROLLBACK TRANSACTION
        return
  end

  UPDATE FFS2010 SET
    CITY         = S.CITY
  , TOWN         = S.TOWN
  , VILLAGE      = S.VILLAGE
  , TOWNVILLAGE  = S.TOWNVILLAGE
  , INCITY       = S.INCITY
  FROM (
        SELECT
        FS_ID = ISNULL(FS_ID,0),
        NULLIF(SUM(CITY),0) AS CITY,
        NULLIF(SUM(TOWN),0) AS TOWN,
        NULLIF(SUM(VILLAGE),0) AS VILLAGE,
        NULLIF(SUM(TOWNVILLAGE),0) AS TOWNVILLAGE,
        NULLIF(SUM(INCITY),0) AS INCITY
        FROM FFS2010
        WHERE (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        GROUP BY ISNULL(FS_ID,0)
        ) S
  WHERE S.FS_ID = FFS2010.FS_ID AND FFS2010.SUBJ_ID=@SUBJ_ID

        if @@ERROR != 0
        begin
                raiserror 50302 'Невозможно создать форму по видам собственности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FOKVED2010]'))
begin
        create table FOKVED2010 (
                SUBJ_ID int not null,
                NUM int not null,
                A int,
                B int,
                C int,
                D int,
                E int,
                F int,
                G int,
                H int,
                I int,
                J int,
                K int,
                L int,
                M int,
                N int,
                O int,
                P int,
                Q int
        )
end
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVED2010Clear]'))
DROP PROCEDURE [dbo].[sp_FOKVED2010Clear]
GO

CREATE PROCEDURE [dbo].[sp_FOKVED2010Clear]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FOKVED2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50100 'Невозможно удалить форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVED2010Create]'))
DROP PROCEDURE [dbo].[sp_FOKVED2010Create]
GO

CREATE PROCEDURE [dbo].[sp_FOKVED2010Create]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FOKVED2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50200 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FOKVED2010(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, 10 UNION ALL
        SELECT @SUBJ_ID, 20 UNION ALL
        SELECT @SUBJ_ID, 30 UNION ALL
        SELECT @SUBJ_ID, 40
        if @@ERROR != 0
        begin
                raiserror 50201 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_FOKVED2010Generate]'))
DROP PROCEDURE [dbo].[sp_FOKVED2010Generate]
GO

CREATE    PROCEDURE [dbo].[sp_FOKVED2010Generate]
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  create table [dbo].[#temp] (SUBJ_ID int, OKVED_SECTION char(1),
        ORG_COUNT int, RAB_COUNT int, ZAP_COUNT int, ZAB_COUNT int
  )

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from v_ORG_CALC

    insert into [dbo].[#SubjSet]
    select Subj_Id from v_Subj_Calc
  end

  if @FilterType=1 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org join KTerr on Org.Terr_Id=KTerr.Terr_Id
    where KTerr.KodTerr LIKE
    ( select  dbo.GetSubjMask(KTERR.KODTERR)
      from CURR_SUBJ
      join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID
      join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)
    and OrgId in (SELECT ORGID FROM v_ORG_CALC)

    insert into [dbo].[#SubjSet]
    select Subj_Id from Subj join KTerr on Subj.Terr_Id=KTerr.Terr_Id
    where Subj_Id in (select * from v_Subj_Calc) and KTerr.KodTerr LIKE
    ( select  dbo.GetSubjMask(KTERR.KODTERR)
      from CURR_SUBJ
      join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID
      join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)
   end;

if @FilterType=2
  insert into [dbo].[#OrgSet]
  select OrgId from OrgSet where OrgId in (SELECT ORGID FROM v_ORG_CALC)

        DELETE FROM FOKVED2010
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO [dbo].[#temp]([SUBJ_ID], [OKVED_SECTION]
        , [ORG_COUNT]
        , [RAB_COUNT]
        , [ZAP_COUNT]
        , [ZAB_COUNT])
        SELECT @SUBJ_ID, K.OKVED_SECTION,
          NULLIF(COUNT(O.ORGID),0) AS ORG_COUNT,
          NULLIF(SUM(O.RAB_COUNT),0) AS RAB_COUNT,
          NULLIF(SUM(O.ZAP_COUNT),0) AS ZAP_COUNT,
          NULLIF(SUM(O.ZAB_COUNT),0) AS ZAB_COUNT
          FROM KOKVED_ K LEFT OUTER JOIN
               (select
                  OO.ORGID
                , OO.RAB_COUNT as RAB_COUNT
                , OO.ZAP_COUNT as ZAP_COUNT
                , OO.ZAB_COUNT as ZAB_COUNT
                , OKVED_FIRST = CASE WHEN (OO.MainOKONH LIKE '[0-9][0-9]' OR OO.MainOKONH LIKE '[0-9][0-9].%')
                                      AND EXISTS( SELECT * FROM KOKVED WHERE
                                                CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int) BETWEEN OKVED_BEGIN AND OKVED_END)
                                THEN CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int)
                                ELSE 0 END
                  from v_ORG OO
                 where OO.OUT_DATE IS NULL
                   AND (@IS_FULL = 1 OR OO.F6CHECKED = 1)
                   AND OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
                                        AND EXISTS(SELECT * FROM FORM6HDR, FORM6
                                             WHERE FORM6HDR.OrgID=OO.ORGID
                                               AND FORM6.F6_ID=FORM6HDR.F6_ID
                                               AND FORM6.COL_B=24
                                               AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0)
               ) O ON (O.OKVED_FIRST BETWEEN K.OKVED_BEGIN AND K.OKVED_END)
        GROUP BY K.OKVED_SECTION

        if @@ERROR != 0
        begin
                raiserror 50301 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end

insert into FOKVED2010 (SUBJ_ID, NUM, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q)
select SUBJ_ID = @SUBJ_ID, NUM = 10,
  A = (select ORG_COUNT from #temp where OKVED_SECTION = 'A'),
  B = (select ORG_COUNT from #temp where OKVED_SECTION = 'B'),
  C = (select ORG_COUNT from #temp where OKVED_SECTION = 'C'),
  D = (select ORG_COUNT from #temp where OKVED_SECTION = 'D'),
  E = (select ORG_COUNT from #temp where OKVED_SECTION = 'E'),
  F = (select ORG_COUNT from #temp where OKVED_SECTION = 'F'),
  G = (select ORG_COUNT from #temp where OKVED_SECTION = 'G'),
  H = (select ORG_COUNT from #temp where OKVED_SECTION = 'H'),
  I = (select ORG_COUNT from #temp where OKVED_SECTION = 'I'),
  J = (select ORG_COUNT from #temp where OKVED_SECTION = 'J'),
  K = (select ORG_COUNT from #temp where OKVED_SECTION = 'K'),
  L = (select ORG_COUNT from #temp where OKVED_SECTION = 'L'),
  M = (select ORG_COUNT from #temp where OKVED_SECTION = 'M'),
  N = (select ORG_COUNT from #temp where OKVED_SECTION = 'N'),
  O = (select ORG_COUNT from #temp where OKVED_SECTION = 'O'),
  P = (select ORG_COUNT from #temp where OKVED_SECTION = 'P'),
  Q = (select ORG_COUNT from #temp where OKVED_SECTION = 'Q')
union all
select @SUBJ_ID, 20,
  (select RAB_COUNT from #temp where OKVED_SECTION = 'A'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'B'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'C'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'D'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'E'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'F'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'G'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'H'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'I'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'J'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'K'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'L'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'M'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'N'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'O'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'P'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'Q')
union all
select @SUBJ_ID, 30,
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'A'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'B'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'C'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'D'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'E'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'F'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'G'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'H'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'I'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'J'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'K'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'L'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'M'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'N'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'O'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'P'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'Q')
union all
select @SUBJ_ID, 40,
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'A'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'B'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'C'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'D'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'E'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'F'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'G'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'H'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'I'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'J'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'K'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'L'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'M'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'N'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'O'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'P'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'Q')

        UPDATE FOKVED2010
        SET
                A = S.SUM_A,
        B = S.SUM_B,
                C = S.SUM_C,
                D = S.SUM_D,
                E = S.SUM_E,
                F = S.SUM_F,
                G = S.SUM_G,
                H = S.SUM_H,
                I = S.SUM_I,
                J = S.SUM_J,
                K = S.SUM_K,
                L = S.SUM_L,
                M = S.SUM_M,
                N = S.SUM_N,
                O = S.SUM_O,
                P = S.SUM_P,
                Q = S.SUM_Q
        FROM (
                SELECT
                NUM,
        NULLIF(SUM(A),0) AS SUM_A,
        NULLIF(SUM(B),0) AS SUM_B,
        NULLIF(SUM(C),0) AS SUM_C,
        NULLIF(SUM(D),0) AS SUM_D,
        NULLIF(SUM(E),0) AS SUM_E,
        NULLIF(SUM(F),0) AS SUM_F,
        NULLIF(SUM(G),0) AS SUM_G,
        NULLIF(SUM(H),0) AS SUM_H,
        NULLIF(SUM(I),0) AS SUM_I,
        NULLIF(SUM(J),0) AS SUM_J,
        NULLIF(SUM(K),0) AS SUM_K,
        NULLIF(SUM(L),0) AS SUM_L,
        NULLIF(SUM(M),0) AS SUM_M,
        NULLIF(SUM(N),0) AS SUM_N,
        NULLIF(SUM(O),0) AS SUM_O,
        NULLIF(SUM(p),0) AS SUM_P,
        NULLIF(SUM(Q),0) AS SUM_Q
                FROM FOKVED2010
                WHERE (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY NUM
        ) S
        WHERE S.NUM = FOKVED2010.NUM AND FOKVED2010.SUBJ_ID=@SUBJ_ID

        if @@ERROR != 0
        begin
                raiserror 50302 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CHECK_ALL]'))
DROP PROCEDURE [dbo].[CHECK_ALL]
GO

CREATE    PROCEDURE [dbo].[CHECK_ALL]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
declare @DIFF int, @SUBJ_NAME varchar(250), @error varchar(8000)
select @SUBJ_NAME = SUBJ_NAME from SUBJ where SUBJ_ID = @SUBJ_ID
set @error = ''

select
@DIFF = (IsNull((select IsNull(F6_COUNT, 0) + IsNull(KUO_COUNT, 0)
        from form6hdr where F6_SHIFR = '01' and SUBJ_ID = @SUBJ_ID), 0) +
IsNull((select IsNull(F6_COUNT, 0) + IsNull(KUO_COUNT, 0)
        from form6hdr where F6_SHIFR = '04' and SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 10

  if @DIFF != 0
        set @error = @error + 'Количество подотчетных организаций в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select
@DIFF = (IsNull((select IsNull(F6_COUNT, 0) + IsNull(KUO_COUNT, 0)
        from form6hdr where F6_SHIFR = '01' and SUBJ_ID = @SUBJ_ID), 0) +
IsNull((select IsNull(F6_COUNT, 0) + IsNull(KUO_COUNT, 0)
        from form6hdr where F6_SHIFR = '04' and SUBJ_ID = @SUBJ_ID), 0)) -
(Sum(IsNull(CITY, 0)) + Sum(IsNull(TOWN, 0)) + Sum(IsNull(VILLAGE, 0)) + Sum(IsNull(TOWNVILLAGE, 0)) +
        Sum(IsNull(INCITY, 0)))
from FFS2010
where SUBJ_ID = @SUBJ_ID

  if @DIFF != 0
        set @error = @error + 'Количество подотчетных организаций в форме 6 и по видам собственности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select @DIFF =
(IsNull((select Sum(IsNull(f6.COL_1, 0))
from form6 f6
join form6hdr f6h on f6h.F6_ID = f6.F6_ID
where f6.CPROF_ID = 2000 and f6h.F6_SHIFR in ('01', '04') and f6h.SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 20

  if @DIFF != 0
        set @error = @error + 'Количество "Всего работающих" в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select @DIFF =
(IsNull((select Sum(IsNull(f6.COL_2, 0))
from form6 f6
join form6hdr f6h on f6h.F6_ID = f6.F6_ID
where f6.CPROF_ID = 2000 and f6h.F6_SHIFR in ('01', '04') and f6h.SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 30

  if @DIFF != 0
        set @error = @error + 'Количество "Всего ГПЗ" в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select @DIFF =
(IsNull((select Sum(IsNull(f6.COL_6, 0))
from form6 f6
join form6hdr f6h on f6h.F6_ID = f6.F6_ID
where f6.CPROF_ID = 2000 and f6h.F6_SHIFR in ('01', '04') and f6h.SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 40

  if @DIFF != 0
        set @error = @error + 'Количество "Всего забронировано" в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)


if @error != ''
begin
    raiserror 52000 @error
    return
end
GO
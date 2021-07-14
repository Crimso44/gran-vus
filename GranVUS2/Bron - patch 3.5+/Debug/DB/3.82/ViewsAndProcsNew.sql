Alter Table Per Add Okved_Name varchar(255)

go


ALTER PROCEDURE [dbo].[sp_ImportOrg]
        @EXT_ID int     out
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare
        @ORG_ID int,
        @MAINOKONH      varchar(5),
        @KODREG varchar(11),
        @TERR_ID        int,
        @F6_ID  int,
        @F6_SHIFR       varchar(2)

        SELECT @ORG_ID = ORGID, @MAINOKONH = LEFT(OKONH, 5), @F6_SHIFR = F6_SHIFR
        FROM [dbo].[#ORG]

        SELECT @KODREG = T.KODTERR, @TERR_ID = S.TERR_ID
        FROM SUBJ S JOIN CURR_SUBJ C ON S.SUBJ_ID = C.SUBJ_ID JOIN KTERR T ON S.TERR_ID = T.TERR_ID


        INSERT INTO KOVK (OVK_NAME,OVK_ADDR,OVK_PHONE)
        SELECT OVK_NAME,OVK_ADDR,OVK_PHONE from #ORG where ISNULL(OVK_NAME,'')<>'' and OVK_NAME not in (select OVK_NAME from KOVK)

        UPDATE #ORG
           SET OVK_ID = NULL
         WHERE ISNULL(OVK_NAME,'')=''

        UPDATE #ORG
           SET OVK_ID = KOVK.OVK_ID
          FROM KOVK
         WHERE KOVK.OVK_NAME = #ORG.OVK_NAME

        if @EXT_ID IS NOT NULL
        begin
                DELETE FROM FORM6
                WHERE F6_ID in (select F6_ID from FORM6HDR where ORGID = @EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror 51400 'Невозможно произвести импорт организации.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6HDR
                WHERE ORGID = @EXT_ID
                if @@ERROR != 0
                begin
                        raiserror 51401 'Невозможно произвести импорт организации.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_CONT
                WHERE ORGID = @EXT_ID
                if @@ERROR != 0
                begin
                        raiserror 51402 'Невозможно произвести импорт организации.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_PAYM
                WHERE ORGID = @EXT_ID
                if @@ERROR != 0
                begin
                        raiserror 51403 'Невозможно произвести импорт организации.'
                        ROLLBACK TRANSACTION
                        return
                end
                UPDATE ORG
                SET
                        PARENT = T.PARENT,
                        FS_ID = T.FS_ID,
                        INN = T.INN,
                        OKPO = T.OKPO,
                        OKONH = T.OKONH,
                        SOOGU = T.SOOGU,
                        KOPF_ID = T.KOPF_ID,
                        KODREG = T.KODREG,
                        REGDATE = T.REGDATE,
                        REGNUM = T.REGNUM,
                        ORGNAME = T.ORGNAME,
                        ORGSNAME = T.ORGSNAME,
                        COMMENT = T.COMMENT,
                        FIZADDR = T.FIZADDR,
                        URADDR = T.URADDR,
                        POSTADDR = T.POSTADDR,
                        PHONE = T.PHONE,
                        FAX = T.FAX,
                        EMAIL = T.EMAIL,
                        WWW = T.WWW,
                        MYORG = T.MYORG,
                        CONFDATE = T.CONFDATE,
                        LAST_DATE = T.LAST_DATE,
                        SBM_ID = T.SBM_ID,
                        SBM = T.SBM,
                        TERR_ID = T.TERR_ID,
                        F6_SHIFR = T.F6_SHIFR,
                        REGPL_ID=T.REGPL_ID,
                        OKATO2=T.OKATO2,
                        OKATO3=T.OKATO3,
                        FEATURE1=T.FEATURE1,
                        FEATURE2=T.FEATURE2,
                        FEATURE3=T.FEATURE3,
                        OVK_ID = T.OVK_ID,
                        KODOKTMO = T.KODOKTMO,
						KODOKTMO2 = T.KODOKTMO2,
						REGPLACE = T.REGPLACE,
						COMPUTERS = T.COMPUTERS,
						SOFTWARENUM = T.SOFTWARENUM,
						KPIS = T.KPIS,
						COMPUTERSS = T.COMPUTERSS,
						SOFTWARENUMS = T.SOFTWARENUMS,
						KPISS = T.KPISS,
						SOFTWARE = T.SOFTWARE,
                        Kopf_Changed = T.Kopf_Changed,
                        Okved_Changed = T.Okved_Changed
                FROM [dbo].[#ORG] T
                WHERE ORG.ORGID = @EXT_ID
                if @@ERROR != 0
                begin
                        raiserror 51404 'Невозможно произвести импорт организации.'
                        ROLLBACK TRANSACTION
                        return
                end
        end else begin
                INSERT INTO ORG (
                        PARENT,
                        FS_ID,
                        INN,
                        OKPO,
                        OKONH,
                        SOOGU,
                        KOPF_ID,
                        KODREG,
                        REGDATE,
                        REGNUM,
                        ORGNAME,
                        ORGSNAME,
                        COMMENT,
                        FIZADDR,
                        URADDR,
                        POSTADDR,
                        PHONE,
                        FAX,
                        EMAIL,
                        WWW,
                        MYORG,
                        CONFDATE,
                        MAINOKONH,
                        OKBV,
                        OCCUPATION,
                        FIRST_DATE,
                        LAST_DATE,
                        OUT_REASON,
                        OUT_DATE,
                        SBM_ID,
                        SBM,
                        TERR_ID,
                        EXT_ID,
                        HAS_BRON,
                        CHK_DATE,
                        F6_SHIFR,
                        REGPL_ID,
                        OKATO2,
                        OKATO3,
                        FEATURE1,
                        FEATURE2,
                        FEATURE3,
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed,
                        Okved_Changed
                )
                SELECT
                        PARENT,
                        FS_ID,
                        INN,
                        OKPO,
                        OKONH,
                        SOOGU,
                        KOPF_ID,
                        KODREG,
                        REGDATE,
                        REGNUM,
                        ORGNAME,
                        ORGSNAME,
                        COMMENT,
                        FIZADDR,
                        URADDR,
                        POSTADDR,
                        PHONE,
                        FAX,
                        EMAIL,
                        WWW,
                        MYORG,
                        CONFDATE,
                        @MAINOKONH,
                        OKBV,
                        OCCUPATION,
                        FIRST_DATE,
                        LAST_DATE,
                        OUT_REASON,
                        OUT_DATE,
                        SBM_ID,
                        SBM,
                        TERR_ID,
                        EXT_ID,
                        HAS_BRON,
                        null,
                        F6_SHIFR,
                        REGPL_ID,
                        OKATO2,
                        OKATO3,
                        FEATURE1,
                        FEATURE2,
                        FEATURE3,
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed,
                        Okved_Changed
                FROM [dbo].[#ORG]
                if @@ERROR != 0
                begin
                        raiserror 51405 'Невозможно произвести импорт организации.'
                        ROLLBACK TRANSACTION
                        return
                end

                SELECT @EXT_ID = @@IDENTITY
        end
        INSERT INTO ORG_PAYM (
                ORGID,
                KS,
                RS,
                BIK,
                BANK

        )
        SELECT
                @EXT_ID,
                KS,
                RS,
                BIK,
                BANK
        FROM [dbo].[#ORG_PAYM]
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror 51406 'Невозможно произвести импорт организации.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO ORG_CONT (
                ORGID,
                DEPART,
                POST,
                PHONE,
                FAX,
                EMAIL,
                IS_GEN,
                IS_VUS,
                FAM,
                IM,
                OTCH
        )
        SELECT
                @EXT_ID,
                DEPART,
                POST,
                PHONE,
                FAX,
                EMAIL,
                IS_GEN,
                IS_VUS,
                FAM,
                IM,
                OTCH
        FROM [dbo].[#ORG_CONT]
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror 51407 'Невозможно произвести импорт организации.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FORM6HDR (
                ORGID,
                ORGNAME,
                F6_SHIFR,
                ORG_SHIFR,
                F6_COUNT,
                KUO_COUNT,
                RAB_COUNT,
                ZAP_COUNT,
                ZAB_COUNT,
                CHECKED,
                CONFDATE,
                SUBJ_ID
        )
        SELECT TOP 1
                @EXT_ID,
                ORGNAME,
                @F6_SHIFR,
                ORG_SHIFR,
                F6_COUNT,
                KUO_COUNT,
                RAB_COUNT,
                ZAP_COUNT,
                ZAB_COUNT,
                CHECKED,
                CONFDATE,
                SUBJ_ID
        FROM [dbo].[#FORM6HDR]
        WHERE ORGID = @ORG_ID
        if @@ERROR != 0
        begin
                raiserror 51408 'Невозможно произвести импорт организации.'
                ROLLBACK TRANSACTION
                return
        end
        SELECT @F6_ID = @@IDENTITY
        INSERT INTO FORM6 (
                CPROF_ID,
                F6_ID,
                PRINT_NAME,
                EXPRESSION,
                CALCULATE,
                COL_B,
                COL_1,
                COL_2,
                COL_3,
                COL_4,
                COL_5,
                COL_6,
                COL_7,
                COL_8,
                COL_9,
                COL_10,
                COL_11,
                COL_12,
                COL_13,
                COL_14,
                COL_15,
                COL_16,
                COL_10T,
                COL_12T
        )
        SELECT
                CPROF_ID,
                @F6_ID,
                PRINT_NAME,
                EXPRESSION,
                CALCULATE,
                COL_B,
                COL_1,
                COL_2,
                COL_3,
                COL_4,
                COL_5,
                COL_6,
                COL_7,
                COL_8,
                COL_9,
                COL_10,
                COL_11,
                COL_12,
                COL_13,
                COL_14,
                COL_15,
                COL_16,
                COL_10T,
                COL_12T
        FROM [dbo].[#FORM6]
        WHERE F6_ID = (SELECT TOP 1 F6_ID FROM [dbo].[#FORM6HDR])
        if @@ERROR != 0
        begin
                raiserror 51409 'Невозможно произвести импорт организации.'
                ROLLBACK TRANSACTION
                return
        end
             insert into [dbo].[#ORG_OSN] (base_id, doc_id, doc_no, doc_date)
             select base_id, doc_id, doc_no, doc_date
             from OSN
             where OrgId=@EXT_ID
             delete from OSN
             where OrgId=@EXT_ID
             insert into OSN(OrgId, base_id, doc_id, doc_no, doc_date)
             select DISTINCT @EXT_ID, base_id, doc_id, doc_no, doc_date
             from [dbo].[#ORG_OSN]
             where  (base_id is null or base_id in (select [id] from VV3))
             and  (doc_id is null or doc_id in (select [id] from VV4))
        if @@ERROR != 0
        begin
                raiserror 51410 'Невозможно произвести импорт организации.'
                ROLLBACK TRANSACTION
                return
        end
              /*insert into [dbo].[#ORG_PER] (doc_id, doc_no, start_date, end_date, per_no, razd_no)
              select doc_id, doc_no, start_date, end_date, per_no, razd_no
              from PER
              where OrgId=@EXT_ID*/
              delete
              from PER
              where OrgId=@EXT_ID

              declare @per_no varchar(4000), @okved_name varchar(255), @razd_no varchar(4000), @r_no varchar(4000)
              declare xx cursor for 
              select per_no, max(Okved_Name)  
              from [dbo].[#ORG_PER]
			  group by per_no
              open xx
              fetch next from xx into @per_no, @okved_name
              while @@fetch_status = 0 begin

              	  set @razd_no = ''

	              declare yy cursor for 
				  select distinct razd_no  
				  from [dbo].[#ORG_PER] Where per_no = @per_no
				  open yy
			      fetch next from yy into @r_no
                  while @@fetch_status = 0 begin
              		  set @razd_no = @razd_no + @r_no + '; '
					  fetch next from yy into @r_no
				  end
				  close yy
				  deallocate yy

				  if len(@razd_no) > 0 set @razd_no = SUBSTRING(@razd_no, 1, len(@razd_no)-1)

	              insert into PER (orgid, per_no, razd_no, okved_name)
		          Values (@EXT_ID, @per_no, @razd_no, @okved_name)

	              fetch next from xx into @per_no, @okved_name
              end
			  close xx
			  deallocate xx


COMMIT TRANSACTION


go


Create PROCEDURE [dbo].[sp_FOrgAnalizGenerate]
--declare
        @ORG_ID        int
--set @Org_Id = 36
AS
SET NOCOUNT ON

CREATE TABLE #FAnaliz(
	[NUM] [int] NOT NULL,
	[N01] [int] NULL,
	[N02] [int] NULL,
	[N06] [int] NULL,
	[N10] [int] NULL,
	[N12] [int] NULL
)


        INSERT INTO #FAnaliz(NUM)
        SELECT CProf_Id
        From KCProf
        WHERE CPROF_ID in (100,200,300,400,410,1000)

        

Update #FAnaliz set
	N01 = IsNull(y.Col_1, 0), 
	N02 = IsNull(y.Col_2, 0), 
	N06 = IsNull(y.Col_6, 0), 
	N10 = IsNull(y.Col_10, 0), 
	N12 = IsNull(y.Col_12, 0)
from #FAnaliz F
left join (
	select CProf_Id Num, Sum(Col_1) Col_1, Sum(Col_2) Col_2, Sum(Col_6) Col_6, Sum(Col_10) Col_10, Sum(Col_12) Col_12
	
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join FORM6HDR h on h.ORGID = oo.ORGID
	     join Form6 f on f.f6_id = h.f6_id

		WHERE f.CPROF_ID in (100,200,300,400,410,1000)
		and h.ORGID = @Org_Id
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL
	   AND oo.HAs_Bron = 1
    group by CProf_Id
) y on y.Num = F.Num
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end

select 
	case when SubString(ff.PRINT_NAME,1,5)='ВСЕГО' then 'ВСЕГО' 
		else ff.PRINT_NAME end As PRINT_NAME,
  F.*
from #FAnaliz F
join KCProf ff on f.num = ff.cprof_id
order by f.NUM


Drop TABLE #FAnaliz
go

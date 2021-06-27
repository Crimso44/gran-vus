if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[KOKTMO]'))
begin
        create table KOKTMO (
                OKTMO_ID int not null primary key IDENTITY(1, 1),
                NAME varchar(150),
                KODOKTMO varchar(20),
                SHORTNAME varchar(150)
        )

        insert into KOKTMO (NAME, KODOKTMO, SHORTNAME)
        values ('Муниципальные образования Архангельской области', '11', null)
        insert into KOKTMO (NAME, KODOKTMO, SHORTNAME)
        values ('Муниципальные районы Архангельской области', '11600000', null)
        insert into KOKTMO (NAME, KODOKTMO, SHORTNAME)
        values ('Вельский муниципальный район', '11605000', null)
        insert into KOKTMO (NAME, KODOKTMO, SHORTNAME)
        values ('Городские поселения Вельского муниципального района', '11605100', null)
        insert into KOKTMO (NAME, KODOKTMO, SHORTNAME)
        values ('- Вельское', '11605101', null)
        insert into KOKTMO (NAME, KODOKTMO, SHORTNAME)
        values ('Сельские поселения Вельского муниципального района', '11605400', null)
        insert into KOKTMO (NAME, KODOKTMO, SHORTNAME)
        values ('- Аргуновское', '11605402', null)
        insert into KOKTMO (NAME, KODOKTMO, SHORTNAME)
        values ('- Благовещенское', '11605404', null)
end
GO

if not exists (select 1 from KL_DATA where KL_NAME = 'KOKTMO')
begin
        declare @id int

        insert into KL_DATA (KL_NAME, DISP_NAME, IS_EDIT)
        values ('KOKTMO', 'Классификатор территорий муниципальных образований', 1)

    select @id = @@IDENTITY

        insert into KL_FLD (KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, DEF_VALUE,
                HAS_NULL)
        values (@id, 'OKTMO_ID', 'Код (внутр.)', 80, 1, 0, 0, null, 1)

        insert into KL_FLD (KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, DEF_VALUE,
                HAS_NULL)
        values (@id, 'NAME', 'Наименование', 300, 0, 1, 1, null, 0)

        insert into KL_FLD (KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, DEF_VALUE,
                HAS_NULL)
        values (@id, 'KODOKTMO', 'Код', 250, 0, 1, 1, '{KODOKTMO}', 0)

        insert into KL_FLD (KL_ID, FLD_NAME, DISP_NAME, DISP_SIZE, IS_KEY, IS_EDIT, VISIBLE, DEF_VALUE,
                HAS_NULL)
        values (@id, 'SHORTNAME', 'Краткое наименование', 300, 0, 1, 1, null, 1)
end
GO

update KL_DATA
set DISP_NAME = 'Классификатор структуры ВУО и выписка из ОКАТО'
where KL_NAME = 'KTERR'
GO

ALTER   PROCEDURE [dbo].[sp_ImportSubj]
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare
        @SUBJ_ID        int,
        @AggData        bit,
        @BronOnly       bit,
        @CONFDATE       datetime

        SELECT @SUBJ_ID = SUBJ_ID, @AggData = AggData, @BronOnly = BronOnly, @CONFDATE = CONFDATE
        FROM [dbo].[#CURR_SUBJ]
        DELETE FROM SUBJ_INFO
        WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] SS ON S.TERR_ID = SS.TERR_ID)
        if @@ERROR != 0
        begin
                raiserror 51501 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
        DELETE FROM SUBJ_PARAM
        WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] SS ON S.TERR_ID = SS.TERR_ID)
        if @@ERROR != 0
        begin
                raiserror 51502 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE SUBJ SET
                TYPE_ID = S.TYPE_ID,
                SUBJ_NAME = S.SUBJ_NAME,
                SUBJ_FULLNAME = S.SUBJ_FULLNAME,
                SUBJ_ADDRESS = S.SUBJ_ADDRESS
        FROM [dbo].[#SUBJ] S
        WHERE SUBJ.TERR_ID = S.TERR_ID
        if @@ERROR != 0
        begin
                raiserror 51503 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO SUBJ (
                TYPE_ID,
                TERR_ID,
                ORGID,
                SUBJ_NAME,
                SUBJ_FULLNAME,
                SUBJ_ADDRESS,
                SUBJ_AGG_ID
                )
        SELECT
                TYPE_ID,
                TERR_ID,
                NULL,
                SUBJ_NAME,
                SUBJ_FULLNAME,
                SUBJ_ADDRESS,
                SUBJ_AGG_ID
        FROM [dbo].[#SUBJ]
        WHERE TERR_ID NOT IN (SELECT TERR_ID FROM SUBJ)
        if @@ERROR != 0
        begin
                raiserror 51504 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO SUBJ_INFO (
                SUBJ_ID,
                SUBJ_INFO_ID,
                ORG_NAME,
                POSITION_NAME,
                FIO,
                PHONE
                )
        SELECT
                SS.SUBJ_ID,
                I.SUBJ_INFO_ID,
                I.ORG_NAME,
                I.POSITION_NAME,
                I.FIO,
                I.PHONE
        FROM [dbo].[#SUBJ_INFO] I JOIN [dbo].[#SUBJ] S ON I.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
        if @@ERROR != 0
        begin
                raiserror 51505 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO SUBJ_PARAM (
                SUBJ_ID,
                SUBJ_PARAM_ID,
                PARAM_VALUE
                )
        SELECT
                SS.SUBJ_ID,
                P.SUBJ_PARAM_ID,
                P.PARAM_VALUE
        FROM [dbo].[#SUBJ_PARAM] P JOIN [dbo].[#SUBJ] S ON P.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
        if @@ERROR != 0
        begin
                raiserror 51506 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
        if @AggData = 1
        begin
                DELETE FROM FFS
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51507 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FOKVED
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51507 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FFS2010
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51507 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FOKVED2010
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51507 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6
                WHERE F6_ID IN (SELECT F.F6_ID FROM FORM6HDR F JOIN SUBJ S ON F.SUBJ_ID = S.SUBJ_ID JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51508 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6HDR
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51509 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FOKVED (
                        [SUBJ_ID],
                        [OKVED_SECTION],
                        [ORG_COUNT],
                        [ORG_BRON_COUNT],
                        [ORG_WU_COUNT],
                        [RAB_COUNT],
                        [ZAP_COUNT],
                        [ZAB_COUNT]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[OKVED_SECTION],
                        F.[ORG_COUNT],
                        F.[ORG_BRON_COUNT],
                        F.[ORG_WU_COUNT],
                        F.[RAB_COUNT],
                        F.[ZAP_COUNT],
                        F.[ZAB_COUNT]
                FROM [dbo].[#FOKVED] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror 51510 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FOKVED2010 (
                        [SUBJ_ID],
                        [NUM],
                        [A],
                        [B],
                        [C],
                        [D],
                        [E],
                        [F],
                        [G],
                        [H],
                        [I],
                        [J],
                        [K],
                        [L],
                        [M],
                        [N],
                        [O],
                        [P],
                        [Q]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
                        F.[A],
                        F.[B],
                        F.[C],
                        F.[D],
                        F.[E],
                        F.[F],
                        F.[G],
                        F.[H],
                        F.[I],
                        F.[J],
                        F.[K],
                        F.[L],
                        F.[M],
                        F.[N],
                        F.[O],
                        F.[P],
                        F.[Q]
                FROM [dbo].[#FOKVED2010] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror 51510 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FFS (
                        [SUBJ_ID],
                        [FS_ID],
                        [FS_NAME],
                        [KOD],
                        [WHOLE],
                        [WU],
                        [BRON],
                        [TOWN_WHOLE],
                        [TOWN_WU],
                        [TOWN_BRON],
                        [VILLAGE_WHOLE],
                        [VILLAGE_WU],
                        [VILLAGE_BRON]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[FS_ID],
                        F.[FS_NAME],
                        F.[KOD],
                        F.[WHOLE],
                        F.[WU],
                        F.[BRON],
                        F.[TOWN_WHOLE],
                        F.[TOWN_WU],
                        F.[TOWN_BRON],
                        F.[VILLAGE_WHOLE],
                        F.[VILLAGE_WU],
                        F.[VILLAGE_BRON]
                FROM [dbo].[#FFS] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror 51510 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FFS2010 (
                        [SUBJ_ID],
                        [FS_ID],
                        [FS_NAME],
                        [KOD],
                        [CITY],
                        [TOWN],
                        [VILLAGE],
                        [TOWNVILLAGE],
                        [INCITY]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[FS_ID],
                        F.[FS_NAME],
                        F.[KOD],
                        F.[CITY],
                        F.[TOWN],
                        F.[VILLAGE],
                        F.[TOWNVILLAGE],
                        F.[INCITY]
                FROM [dbo].[#FFS2010] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror 51510 'Невозможно произвести импорт субъекта.'
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
                SELECT
                        NULL,
                        F.ORGNAME,
                        F.F6_SHIFR,
                        F.ORG_SHIFR,
                        F.F6_COUNT,
                        F.KUO_COUNT,
      F.RAB_COUNT,
      F.ZAP_COUNT,
      F.ZAB_COUNT,
      F.CHECKED,
                        F.CONFDATE,
                        SS.SUBJ_ID
                FROM [dbo].[#FORM6HDR] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON SS.TERR_ID = S.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror 51511 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
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
                        FF.CPROF_ID,
                        H.F6_ID,
                        FF.PRINT_NAME,
                        FF.EXPRESSION,
                        FF.CALCULATE,
                        FF.COL_B,
                        FF.COL_1,
                        FF.COL_2,
                        FF.COL_3,
                        FF.COL_4,
                        FF.COL_5,
                        FF.COL_6,
                        FF.COL_7,
                        FF.COL_8,
                        FF.COL_9,
                        FF.COL_10,
                        FF.COL_11,
                        FF.COL_12,
                        FF.COL_13,
                        FF.COL_14,
                        FF.COL_15,
                        FF.COL_16,
		                FF.COL_10T,
				        FF.COL_12T
                FROM [dbo].[#FORM6] FF JOIN [dbo].[#FORM6HDR] F ON FF.F6_ID = F.F6_ID JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID =S.SUBJ_ID JOIN SUBJ SS ON SS.TERR_ID = S.TERR_ID JOIN FORM6HDR H ON H.SUBJ_ID = SS.SUBJ_ID AND CAST(H.F6_SHIFR as int)=CAST(F.F6_SHIFR as int)
                if @@ERROR != 0
                begin
                        raiserror 51512 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
        end


        INSERT INTO KOVK (OVK_NAME,OVK_ADDR,OVK_PHONE)
        SELECT OVK_NAME,OVK_ADDR,OVK_PHONE from #ORG where ISNULL(OVK_NAME,'')<>'' and OVK_NAME not in (select OVK_NAME from KOVK)

        UPDATE #ORG
           SET OVK_ID = NULL
         WHERE ISNULL(OVK_NAME,'')=''

        UPDATE #ORG
           SET OVK_ID = KOVK.OVK_ID
          FROM KOVK
         WHERE KOVK.OVK_NAME = #ORG.OVK_NAME

        if @CONFDATE IS NULL
        begin
                DELETE FROM FORM6
                WHERE F6_ID IN (SELECT F.F6_ID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN FORM6HDR F ON O.ORGID = F.ORGID)
                if @@ERROR != 0
                begin
                        raiserror 51513 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6HDR
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51514 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_CONT
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51515 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_PAYM
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51516 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM OSN
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51517 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM PER
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51518 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORGSET
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51519 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG
                WHERE TERR_ID IN (SELECT TERR_ID FROM [dbo].[#SUBJ])
                if @@ERROR != 0
                begin
                        raiserror 51520 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end


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
                        TERR_ID,
                        EXT_ID, --xx
                        HAS_BRON,
                        CHK_DATE,
                        F6_SHIFR,
                        REGPL_ID,
                        OKATO2,
                        OKATO3,
                        Feature1,
                        Feature2,
                        Feature3,
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						SOFTWARE
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
                        MAINOKONH,
                        OKBV,
                        OCCUPATION,
                        FIRST_DATE,
                        LAST_DATE,
                        OUT_REASON,
                        OUT_DATE,
                        SBM_ID,
                        TERR_ID,
                        ORGID,
                        HAS_BRON,
                        CHK_DATE,
                        F6_SHIFR,
                        REGPL_ID,
                        OKATO2,
                        OKATO3,
                        Feature1,
                        Feature2,
                        Feature3,
                        OVK_ID,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						SOFTWARE
                FROM [dbo].[#ORG]
                WHERE TERR_ID IN (SELECT TERR_ID FROM [dbo].[#SUBJ])
                if @@ERROR != 0
                begin
                        raiserror 51521 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
        end else begin
                DELETE FROM FORM6
                WHERE F6_ID IN (SELECT F.F6_ID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID JOIN FORM6HDR F ON O.ORGID = F.ORGID)
                if @@ERROR != 0
                begin
                        raiserror 51522 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FORM6HDR
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror 51523 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_CONT
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror 51524 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM ORG_PAYM
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror 51525 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM OSN
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror 51526 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM PER
                WHERE ORGID IN (SELECT O.ORGID FROM [dbo].[#SUBJ] S JOIN ORG O ON S.TERR_ID = O.TERR_ID JOIN [dbo].[#ORG] OO ON O.TERR_ID = OO.TERR_ID AND OO.ORGID = O.EXT_ID)
                if @@ERROR != 0
                begin
                        raiserror 51526 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end

                UPDATE ORG SET
                        PARENT = O.PARENT,
                        FS_ID = O.FS_ID,
                        INN = O.INN,
                        OKPO = O.OKPO,
                        OKONH = O.OKONH,
                        SOOGU = O.SOOGU,
                        KOPF_ID = O.KOPF_ID,
                        KODREG = O.KODREG,
                        REGDATE = O.REGDATE,
                        REGNUM = O.REGNUM,
                        ORGNAME = O.ORGNAME,
                        ORGSNAME = O.ORGSNAME,
                        COMMENT = O.COMMENT,
                        FIZADDR = O.FIZADDR,
                        URADDR = O.URADDR,
                        POSTADDR = O.POSTADDR,
                        PHONE = O.PHONE,
                        FAX = O.FAX,
                        EMAIL = O.EMAIL,
                        WWW = O.WWW,
                        MYORG = O.MYORG,
                        CONFDATE = O.CONFDATE,
                        MAINOKONH = O.MAINOKONH,
                        OKBV = O.OKBV,
                        OCCUPATION = O.OCCUPATION,
                        FIRST_DATE = O.FIRST_DATE,
                        LAST_DATE = O.LAST_DATE,
                        OUT_REASON = O.OUT_REASON,
                        OUT_DATE = O.OUT_DATE,
                        SBM_ID = O.SBM_ID,
                        TERR_ID = O.TERR_ID,
                        EXT_ID = O.EXT_ID,
                        HAS_BRON = O.HAS_BRON,
                        CHK_DATE = O.CHK_DATE,
                        F6_SHIFR = O.F6_SHIFR,
                        REGPL_ID = O.REGPL_ID,
                        OKATO2 = O.OKATO2,
                        OKATO3 = O.OKATO3,
                        Feature1 = O.Feature1,
                        Feature2 = O.Feature2,
                        Feature3 = O.Feature3,
                        OVK_ID = O.OVK_ID,
                        KODOKTMO = O.KODOKTMO,
						KODOKTMO2 = O.KODOKTMO2,
						REGPLACE = O.REGPLACE,
						COMPUTERS = O.COMPUTERS,
						SOFTWARENUM = O.SOFTWARENUM,
						SOFTWARE = O.SOFTWARE
                FROM [dbo].[#ORG] O
                WHERE O.TERR_ID IN (SELECT TERR_ID FROM [dbo].[#SUBJ])
                AND ORG.TERR_ID = O.TERR_ID AND ORG.EXT_ID = O.ORGID
                if @@ERROR != 0
                begin
                        raiserror 51527 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
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
                        TERR_ID,
                        EXT_ID,
                        HAS_BRON,
                        CHK_DATE,
                        F6_SHIFR,
                        REGPL_ID,
                        OKATO2,
                        OKATO3,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						SOFTWARE
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
                        MAINOKONH,
                        OKBV,
                        OCCUPATION,
                        FIRST_DATE,
                        LAST_DATE,
                        OUT_REASON,
                        OUT_DATE,
                        SBM_ID,
                        TERR_ID,
                        ORGID,
                        HAS_BRON,
                        CHK_DATE,
                        F6_SHIFR,
                        REGPL_ID,
                        OKATO2,
                        OKATO3,
                        KODOKTMO,
						KODOKTMO2,
						REGPLACE,
						COMPUTERS,
						SOFTWARENUM,
						SOFTWARE
                FROM [dbo].[#ORG] O
                WHERE ORGID NOT IN (
                        SELECT O.ORGID FROM [dbo].[#ORG] O JOIN [dbo].[#SUBJ] S ON S.TERR_ID = O.TERR_ID
                                       JOIN ORG OO ON OO.EXT_ID = O.ORGID AND OO.TERR_ID = O.TERR_ID)

                if @@ERROR != 0
                begin
                        raiserror 51528 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
        end
        INSERT INTO ORG_PAYM (
                ORGID,
                KS,
                RS,
                BIK,
                BANK
        )
        SELECT
                OO.ORGID,
                P.KS,
                P.RS,
                P.BIK,
                P.BANK
        FROM [dbo].[#ORG_PAYM] P JOIN [dbo].[#ORG] O ON P.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
        if @@ERROR != 0
        begin
                raiserror 51529 'Невозможно произвести импорт субъекта.'
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
                OO.ORGID,
                C.DEPART,
                C.POST,
                C.PHONE,
                C.FAX,
                C.EMAIL,
                C.IS_GEN,
                C.IS_VUS,
                C.FAM,
                C.IM,
                C.OTCH
        FROM [dbo].[#ORG_CONT] C JOIN [dbo].[#ORG] O ON C.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
        if @@ERROR != 0
        begin
                raiserror 51530 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO OSN (
                ORGID,
                BASE_ID,
                DOC_ID,
                DOC_NO,
                DOC_DATE
        )
        SELECT
                OO.ORGID,
                S.BASE_ID,
                S.DOC_ID,
                S.DOC_NO,
                S.DOC_DATE
        FROM [dbo].[#OSN] S JOIN [dbo].[#ORG] O ON S.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
        if @@ERROR != 0
        begin
                raiserror 51531 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO PER (
                ORGID,
                DOC_ID,
                DOC_NO,
                START_DATE,
                END_DATE,
                PER_NO,
                RAZD_NO
        )
        SELECT
                OO.ORGID,
                P.DOC_ID,
                P.DOC_NO,
                P.START_DATE,
                P.END_DATE,
                P.PER_NO,
                P.RAZD_NO
        FROM [dbo].[#PER] P JOIN [dbo].[#ORG] O ON P.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
        if @@ERROR != 0
        begin
                raiserror 51532 'Невозможно произвести импорт субъекта.'
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
        SELECT
                OO.ORGID,
                F.ORGNAME,
                F.F6_SHIFR,
                F.ORG_SHIFR,
                F.F6_COUNT,
                F.KUO_COUNT,
                F.RAB_COUNT,
                F.ZAP_COUNT,
                F.ZAB_COUNT,
                F.CHECKED,
                F.CONFDATE,
                Null
        FROM [dbo].[#FORM6HDR] F JOIN [dbo].[#ORG] O ON F.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID
        if @@ERROR != 0
        begin
                raiserror 51533 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
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
                FF.CPROF_ID,
                H.F6_ID,
                FF.PRINT_NAME,
                FF.EXPRESSION,
                FF.CALCULATE,
                FF.COL_B,
                FF.COL_1,
                FF.COL_2,
                FF.COL_3,
                FF.COL_4,
                FF.COL_5,
                FF.COL_6,
                FF.COL_7,
                FF.COL_8,
                FF.COL_9,
                FF.COL_10,
                FF.COL_11,
                FF.COL_12,
                FF.COL_13,
                FF.COL_14,
                FF.COL_15,
                FF.COL_16,
                FF.COL_10T,
		        FF.COL_12T
        FROM [dbo].[#FORM6] FF JOIN [dbo].[#FORM6HDR] F ON FF.F6_ID = F.F6_ID JOIN [dbo].[#ORG] O ON F.ORGID = O.ORGID JOIN ORG OO ON OO.TERR_ID = O.TERR_ID AND OO.EXT_ID = O.ORGID JOIN FORM6HDR H ON H.ORGID = OO.ORGID
        if @@ERROR != 0
        begin
                raiserror 51534 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE SUBJ SET REPORT_DATE = GETDATE() WHERE SUBJ_ID=@SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 51534 'Невозможно произвести импорт субъекта.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION





GO


ALTER  PROCEDURE [dbo].[sp_ImportOrg]
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
						SOFTWARE = T.SOFTWARE
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
						SOFTWARE
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
						SOFTWARE
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
              insert into [dbo].[#ORG_PER] (doc_id, doc_no, start_date, end_date, per_no, razd_no)
              select doc_id, doc_no, start_date, end_date, per_no, razd_no
              from PER
              where OrgId=@EXT_ID
              delete
              from PER
              where OrgId=@EXT_ID
              insert into PER (orgid, doc_id, doc_no, start_date, end_date, per_no, razd_no)
              select DISTINCT @EXT_ID, doc_id, doc_no, start_date, end_date, per_no, razd_no
              from [dbo].[#ORG_PER]
COMMIT TRANSACTION







GO

insert into koktmo (name, kodoktmo)
select 'Муниципальные образования города Москвы (столицы Российской Федерации города Федерального значения)','45'
where not exists (select * from koktmo where kodoktmo = '45')

insert into koktmo (name, kodoktmo)
select 'Богородское','45301000'
where not exists (select * from koktmo where kodoktmo = '45301000')

insert into koktmo (name, kodoktmo)
select 'Вешняки','45302000'
where not exists (select * from koktmo where kodoktmo = '45302000')

insert into koktmo (name, kodoktmo)
select 'Восточное Измайлово','45303000'
where not exists (select * from koktmo where kodoktmo = '45303000')

insert into koktmo (name, kodoktmo)
select 'Восточное','45304000'
where not exists (select * from koktmo where kodoktmo = '45304000')

insert into koktmo (name, kodoktmo)
select 'Гольяново','45305000'
where not exists (select * from koktmo where kodoktmo = '45305000')

insert into koktmo (name, kodoktmo)
select 'Ивановское','45306000'
where not exists (select * from koktmo where kodoktmo = '45306000')

insert into koktmo (name, kodoktmo)
select 'Измайлово','45307000'
where not exists (select * from koktmo where kodoktmo = '45307000')

insert into koktmo (name, kodoktmo)
select 'Косино-Ухтомское','45308000'
where not exists (select * from koktmo where kodoktmo = '45308000')

insert into koktmo (name, kodoktmo)
select 'Новогиреево','45309000'
where not exists (select * from koktmo where kodoktmo = '45309000')

insert into koktmo (name, kodoktmo)
select 'Новокосино','45310000'
where not exists (select * from koktmo where kodoktmo = '45310000')

insert into koktmo (name, kodoktmo)
select 'Метрогородок','45311000'
where not exists (select * from koktmo where kodoktmo = '45311000')

insert into koktmo (name, kodoktmo)
select 'Перово','45312000'
where not exists (select * from koktmo where kodoktmo = '45312000')

insert into koktmo (name, kodoktmo)
select 'Северное Измайлово','45313000'
where not exists (select * from koktmo where kodoktmo = '45313000')

insert into koktmo (name, kodoktmo)
select 'Соколиная Гора','45314000'
where not exists (select * from koktmo where kodoktmo = '45314000')

insert into koktmo (name, kodoktmo)
select 'Сокольники','45315000'
where not exists (select * from koktmo where kodoktmo = '45315000')

insert into koktmo (name, kodoktmo)
select 'Преображенское','45316000'
where not exists (select * from koktmo where kodoktmo = '45316000')

insert into koktmo (name, kodoktmo)
select 'Внуково','45317000'
where not exists (select * from koktmo where kodoktmo = '45317000')

insert into koktmo (name, kodoktmo)
select 'Дорогомилово','45318000'
where not exists (select * from koktmo where kodoktmo = '45318000')

insert into koktmo (name, kodoktmo)
select 'Крылатское','45319000'
where not exists (select * from koktmo where kodoktmo = '45319000')

insert into koktmo (name, kodoktmo)
select 'Кунцево','45320000'
where not exists (select * from koktmo where kodoktmo = '45320000')

insert into koktmo (name, kodoktmo)
select 'Можайское','45321000'
where not exists (select * from koktmo where kodoktmo = '45321000')

insert into koktmo (name, kodoktmo)
select 'Ново-Переделкино','45322000'
where not exists (select * from koktmo where kodoktmo = '45322000')

insert into koktmo (name, kodoktmo)
select 'Очаково-Матвеевское','45323000'
where not exists (select * from koktmo where kodoktmo = '45323000')

insert into koktmo (name, kodoktmo)
select 'Проспект Вернадского','45324000'
where not exists (select * from koktmo where kodoktmo = '45324000')

insert into koktmo (name, kodoktmo)
select 'Раменки','45325000'
where not exists (select * from koktmo where kodoktmo = '45325000')

insert into koktmo (name, kodoktmo)
select 'Солнцево','45326000'
where not exists (select * from koktmo where kodoktmo = '45326000')

insert into koktmo (name, kodoktmo)
select 'Тропарево-Никулино','45327000'
where not exists (select * from koktmo where kodoktmo = '45327000')

insert into koktmo (name, kodoktmo)
select 'Филевский Парк','45328000'
where not exists (select * from koktmo where kodoktmo = '45328000')

insert into koktmo (name, kodoktmo)
select 'Фили-Давыдково','45329000'
where not exists (select * from koktmo where kodoktmo = '45329000')

insert into koktmo (name, kodoktmo)
select 'Крюково','45330000'
where not exists (select * from koktmo where kodoktmo = '45330000')

insert into koktmo (name, kodoktmo)
select 'Матушкино','45331000'
where not exists (select * from koktmo where kodoktmo = '45331000')

insert into koktmo (name, kodoktmo)
select 'Силино','45332000'
where not exists (select * from koktmo where kodoktmo = '45332000')

insert into koktmo (name, kodoktmo)
select 'Аэропорт','45333000'
where not exists (select * from koktmo where kodoktmo = '45333000')

insert into koktmo (name, kodoktmo)
select 'Беговое','45334000'
where not exists (select * from koktmo where kodoktmo = '45334000')

insert into koktmo (name, kodoktmo)
select 'Бескудниковское','45335000'
where not exists (select * from koktmo where kodoktmo = '45335000')

insert into koktmo (name, kodoktmo)
select 'Войковское','45336000'
where not exists (select * from koktmo where kodoktmo = '45336000')

insert into koktmo (name, kodoktmo)
select 'Восточное Дегунино','45337000'
where not exists (select * from koktmo where kodoktmo = '45337000')

insert into koktmo (name, kodoktmo)
select 'Головинское','45338000'
where not exists (select * from koktmo where kodoktmo = '45338000')

insert into koktmo (name, kodoktmo)
select 'Дмитровское','45339000'
where not exists (select * from koktmo where kodoktmo = '45339000')

insert into koktmo (name, kodoktmo)
select 'Западное Дегунино','45340000'
where not exists (select * from koktmo where kodoktmo = '45340000')

insert into koktmo (name, kodoktmo)
select 'Коптево','45341000'
where not exists (select * from koktmo where kodoktmo = '45341000')

insert into koktmo (name, kodoktmo)
select 'Левобережное','45342000'
where not exists (select * from koktmo where kodoktmo = '45342000')

insert into koktmo (name, kodoktmo)
select 'Молжаниновское','45343000'
where not exists (select * from koktmo where kodoktmo = '45343000')

insert into koktmo (name, kodoktmo)
select 'Савеловское','45344000'
where not exists (select * from koktmo where kodoktmo = '45344000')

insert into koktmo (name, kodoktmo)
select 'Сокол','45345000'
where not exists (select * from koktmo where kodoktmo = '45345000')

insert into koktmo (name, kodoktmo)
select 'Тимирязевское','45346000'
where not exists (select * from koktmo where kodoktmo = '45346000')

insert into koktmo (name, kodoktmo)
select 'Ховрино','45347000'
where not exists (select * from koktmo where kodoktmo = '45347000')

insert into koktmo (name, kodoktmo)
select 'Хорошевское','45348000'
where not exists (select * from koktmo where kodoktmo = '45348000')

insert into koktmo (name, kodoktmo)
select 'Алексеевское','45349000'
where not exists (select * from koktmo where kodoktmo = '45349000')

insert into koktmo (name, kodoktmo)
select 'Алтуфьевское','45350000'
where not exists (select * from koktmo where kodoktmo = '45350000')

insert into koktmo (name, kodoktmo)
select 'Бабушкинское','45351000'
where not exists (select * from koktmo where kodoktmo = '45351000')

insert into koktmo (name, kodoktmo)
select 'Бибирево','45352000'
where not exists (select * from koktmo where kodoktmo = '45352000')

insert into koktmo (name, kodoktmo)
select 'Бутырское','45353000'
where not exists (select * from koktmo where kodoktmo = '45353000')

insert into koktmo (name, kodoktmo)
select 'Лианозово','45354000'
where not exists (select * from koktmo where kodoktmo = '45354000')

insert into koktmo (name, kodoktmo)
select 'Лосиноостровское','45355000'
where not exists (select * from koktmo where kodoktmo = '45355000')

insert into koktmo (name, kodoktmo)
select 'Марфино','45356000'
where not exists (select * from koktmo where kodoktmo = '45356000')

insert into koktmo (name, kodoktmo)
select 'Марьина Роща','45357000'
where not exists (select * from koktmo where kodoktmo = '45357000')

insert into koktmo (name, kodoktmo)
select 'Останкинское','45358000'
where not exists (select * from koktmo where kodoktmo = '45358000')

insert into koktmo (name, kodoktmo)
select 'Отрадное','45359000'
where not exists (select * from koktmo where kodoktmo = '45359000')

insert into koktmo (name, kodoktmo)
select 'Ростокино','45360000'
where not exists (select * from koktmo where kodoktmo = '45360000')

insert into koktmo (name, kodoktmo)
select 'Свиблово','45361000'
where not exists (select * from koktmo where kodoktmo = '45361000')

insert into koktmo (name, kodoktmo)
select 'Северное Медведково','45362000'
where not exists (select * from koktmo where kodoktmo = '45362000')

insert into koktmo (name, kodoktmo)
select 'Северное','45363000'
where not exists (select * from koktmo where kodoktmo = '45363000')

insert into koktmo (name, kodoktmo)
select 'Южное Медведково','45364000'
where not exists (select * from koktmo where kodoktmo = '45364000')

insert into koktmo (name, kodoktmo)
select 'Ярославское','45365000'
where not exists (select * from koktmo where kodoktmo = '45365000')

insert into koktmo (name, kodoktmo)
select 'Куркино','45366000'
where not exists (select * from koktmo where kodoktmo = '45366000')

insert into koktmo (name, kodoktmo)
select 'Митино','45367000'
where not exists (select * from koktmo where kodoktmo = '45367000')

insert into koktmo (name, kodoktmo)
select 'Покровское-Стрешнево','45368000'
where not exists (select * from koktmo where kodoktmo = '45368000')

insert into koktmo (name, kodoktmo)
select 'Северное Тушино','45369000'
where not exists (select * from koktmo where kodoktmo = '45369000')

insert into koktmo (name, kodoktmo)
select 'Строгино','45370000'
where not exists (select * from koktmo where kodoktmo = '45370000')

insert into koktmo (name, kodoktmo)
select 'Хорошево-Мневники','45371000'
where not exists (select * from koktmo where kodoktmo = '45371000')

insert into koktmo (name, kodoktmo)
select 'Щукино','45372000'
where not exists (select * from koktmo where kodoktmo = '45372000')

insert into koktmo (name, kodoktmo)
select 'Южное Тушино','45373000'
where not exists (select * from koktmo where kodoktmo = '45373000')

insert into koktmo (name, kodoktmo)
select 'Арбат','45374000'
where not exists (select * from koktmo where kodoktmo = '45374000')

insert into koktmo (name, kodoktmo)
select 'Басманное','45375000'
where not exists (select * from koktmo where kodoktmo = '45375000')

insert into koktmo (name, kodoktmo)
select 'Замоскворечье','45376000'
where not exists (select * from koktmo where kodoktmo = '45376000')

insert into koktmo (name, kodoktmo)
select 'Савелки','45377000'
where not exists (select * from koktmo where kodoktmo = '45377000')

insert into koktmo (name, kodoktmo)
select 'Красносельское','45378000'
where not exists (select * from koktmo where kodoktmo = '45378000')

insert into koktmo (name, kodoktmo)
select 'Мещанское','45379000'
where not exists (select * from koktmo where kodoktmo = '45379000')

insert into koktmo (name, kodoktmo)
select 'Пресненское','45380000'
where not exists (select * from koktmo where kodoktmo = '45380000')

insert into koktmo (name, kodoktmo)
select 'Таганское','45381000'
where not exists (select * from koktmo where kodoktmo = '45381000')

insert into koktmo (name, kodoktmo)
select 'Тверское','45382000'
where not exists (select * from koktmo where kodoktmo = '45382000')

insert into koktmo (name, kodoktmo)
select 'Хамовники','45383000'
where not exists (select * from koktmo where kodoktmo = '45383000')

insert into koktmo (name, kodoktmo)
select 'Якиманка','45384000'
where not exists (select * from koktmo where kodoktmo = '45384000')

insert into koktmo (name, kodoktmo)
select 'Выхино-Жулебино','45385000'
where not exists (select * from koktmo where kodoktmo = '45385000')

insert into koktmo (name, kodoktmo)
select 'Капотня','45386000'
where not exists (select * from koktmo where kodoktmo = '45386000')

insert into koktmo (name, kodoktmo)
select 'Кузьминки','45387000'
where not exists (select * from koktmo where kodoktmo = '45387000')

insert into koktmo (name, kodoktmo)
select 'Лефортово','45388000'
where not exists (select * from koktmo where kodoktmo = '45388000')

insert into koktmo (name, kodoktmo)
select 'Люблино','45389000'
where not exists (select * from koktmo where kodoktmo = '45389000')

insert into koktmo (name, kodoktmo)
select 'Марьино','45390000'
where not exists (select * from koktmo where kodoktmo = '45390000')

insert into koktmo (name, kodoktmo)
select 'Некрасовка','45391000'
where not exists (select * from koktmo where kodoktmo = '45391000')

insert into koktmo (name, kodoktmo)
select 'Нижегородское','45392000'
where not exists (select * from koktmo where kodoktmo = '45392000')

insert into koktmo (name, kodoktmo)
select 'Печатники','45393000'
where not exists (select * from koktmo where kodoktmo = '45393000')

insert into koktmo (name, kodoktmo)
select 'Рязанское','45394000'
where not exists (select * from koktmo where kodoktmo = '45394000')

insert into koktmo (name, kodoktmo)
select 'Текстильщики','45395000'
where not exists (select * from koktmo where kodoktmo = '45395000')

insert into koktmo (name, kodoktmo)
select 'Южнопортовое','45396000'
where not exists (select * from koktmo where kodoktmo = '45396000')

insert into koktmo (name, kodoktmo)
select 'Академическое','45397000'
where not exists (select * from koktmo where kodoktmo = '45397000')

insert into koktmo (name, kodoktmo)
select 'Гагаринское','45398000'
where not exists (select * from koktmo where kodoktmo = '45398000')

insert into koktmo (name, kodoktmo)
select 'Зюзино','45901000'
where not exists (select * from koktmo where kodoktmo = '45901000')

insert into koktmo (name, kodoktmo)
select 'Коньково','45902000'
where not exists (select * from koktmo where kodoktmo = '45902000')

insert into koktmo (name, kodoktmo)
select 'Котловка','45903000'
where not exists (select * from koktmo where kodoktmo = '45903000')

insert into koktmo (name, kodoktmo)
select 'Ломоносовское','45904000'
where not exists (select * from koktmo where kodoktmo = '45904000')

insert into koktmo (name, kodoktmo)
select 'Обручевское','45905000'
where not exists (select * from koktmo where kodoktmo = '45905000')

insert into koktmo (name, kodoktmo)
select 'Северное Бутово','45906000'
where not exists (select * from koktmo where kodoktmo = '45906000')

insert into koktmo (name, kodoktmo)
select 'Теплый Стан','45907000'
where not exists (select * from koktmo where kodoktmo = '45907000')

insert into koktmo (name, kodoktmo)
select 'Черемушки','45908000'
where not exists (select * from koktmo where kodoktmo = '45908000')

insert into koktmo (name, kodoktmo)
select 'Южное Бутово','45909000'
where not exists (select * from koktmo where kodoktmo = '45909000')

insert into koktmo (name, kodoktmo)
select 'Ясенево','45910000'
where not exists (select * from koktmo where kodoktmo = '45910000')

insert into koktmo (name, kodoktmo)
select 'Бирюлево Восточное','45911000'
where not exists (select * from koktmo where kodoktmo = '45911000')

insert into koktmo (name, kodoktmo)
select 'Бирюлево Западное','45912000'
where not exists (select * from koktmo where kodoktmo = '45912000')

insert into koktmo (name, kodoktmo)
select 'Братеево','45913000'
where not exists (select * from koktmo where kodoktmo = '45913000')

insert into koktmo (name, kodoktmo)
select 'Даниловское','45914000'
where not exists (select * from koktmo where kodoktmo = '45914000')

insert into koktmo (name, kodoktmo)
select 'Донское','45915000'
where not exists (select * from koktmo where kodoktmo = '45915000')

insert into koktmo (name, kodoktmo)
select 'Зябликово','45916000'
where not exists (select * from koktmo where kodoktmo = '45916000')

insert into koktmo (name, kodoktmo)
select 'Москворечье-Сабурово','45917000'
where not exists (select * from koktmo where kodoktmo = '45917000')

insert into koktmo (name, kodoktmo)
select 'Нагатино-Садовники','45918000'
where not exists (select * from koktmo where kodoktmo = '45918000')

insert into koktmo (name, kodoktmo)
select 'Нагатинский Затон','45919000'
where not exists (select * from koktmo where kodoktmo = '45919000')

insert into koktmo (name, kodoktmo)
select 'Нагорное','45920000'
where not exists (select * from koktmo where kodoktmo = '45920000')

insert into koktmo (name, kodoktmo)
select 'Орехово-Борисово Северное','45921000'
where not exists (select * from koktmo where kodoktmo = '45921000')

insert into koktmo (name, kodoktmo)
select 'Орехово-Борисово Южное','45922000'
where not exists (select * from koktmo where kodoktmo = '45922000')

insert into koktmo (name, kodoktmo)
select 'Царицыно','45923000'
where not exists (select * from koktmo where kodoktmo = '45923000')

insert into koktmo (name, kodoktmo)
select 'Чертаново Северное','45924000'
where not exists (select * from koktmo where kodoktmo = '45924000')

insert into koktmo (name, kodoktmo)
select 'Чертаново Центральное','45925000'
where not exists (select * from koktmo where kodoktmo = '45925000')

insert into koktmo (name, kodoktmo)
select 'Чертаново Южное','45926000'
where not exists (select * from koktmo where kodoktmo = '45926000')

insert into koktmo (name, kodoktmo)
select 'Старое Крюково','459272000'
where not exists (select * from koktmo where kodoktmo = '459272000')

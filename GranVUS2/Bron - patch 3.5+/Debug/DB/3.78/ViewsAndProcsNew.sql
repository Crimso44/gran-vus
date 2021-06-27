BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_KOPF
	(
	KOPF_ID int NOT NULL IDENTITY (1, 1),
	KOPF_NAME varchar(150) NULL,
	KOD varchar(5) NULL
	)  ON [PRIMARY]
GO
SET IDENTITY_INSERT dbo.Tmp_KOPF ON
GO
IF EXISTS(SELECT * FROM dbo.KOPF)
	 EXEC('INSERT INTO dbo.Tmp_KOPF (KOPF_ID, KOPF_NAME, KOD)
		SELECT KOPF_ID, KOPF_NAME, KOD FROM dbo.KOPF WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_KOPF OFF
GO
ALTER TABLE dbo.ORG
	DROP CONSTRAINT FK_ORG_KOPF
GO
DROP TABLE dbo.KOPF
GO
EXECUTE sp_rename N'dbo.Tmp_KOPF', N'KOPF', 'OBJECT' 
GO
ALTER TABLE dbo.KOPF ADD CONSTRAINT
	PK_KOPF PRIMARY KEY CLUSTERED 
	(
	KOPF_ID
	) ON [PRIMARY]

GO
ALTER TABLE dbo.KOPF ADD CONSTRAINT
	IX_KOPF UNIQUE NONCLUSTERED 
	(
	KOD
	) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.ORG ADD CONSTRAINT
	FK_ORG_KOPF FOREIGN KEY
	(
	KOPF_ID
	) REFERENCES dbo.KOPF
	(
	KOPF_ID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
go

Alter Table KOPF Add KOD_OLD Varchar(2)
Alter Table Org Add Kopf_Changed bit

go

Update KOPF Set KOD_OLD = KOD

go

Create table kopf_Tmp (old int, new int, name varchar(500))

go

insert into kopf_tmp
select 39, 10000, 'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ КОММЕРЧЕСКИМИ ОРГАНИЗАЦИЯМИ' union
select 48, 11000, 'Хозяйственные товарищества' union
select -1, 12000, 'Хозяйственные общества' union
select 51, 11051, 'Полные товарищества' union
select 64, 11064, 'Товарищества на вере (коммандитные товарищества)' union
select 65, 12165, 'Общества с ограниченной ответственностью' union
select 66, 12166, 'Общества с дополнительной ответственностью' union
select 60, 12200, 'Акционерные общества' union
select 47, 12247, 'Открытые акционерные общества' union
select 67, 12267, 'Закрытые акционерные общества' union
select 61, 13000, 'Хозяйственные партнерства' union
select 52, 14100, 'Сельскохозяйственные производственные кооперативы' union
select -1, 14153, 'Сельскохозяйственные артели (колхозы)' union
select -1, 14154, 'Рыболовецкие артели (колхозы)' union
select -1, 14155, 'Кооперативные хозяйства (коопхозы)' union
select -1, 14200, 'Производственные кооперативы (кроме сельскохозяйственных производственных кооперативов)' union
select 53, 19000, 'Прочие юридические лица, являющиеся коммерческими организациями' union
select 40, 15000, 'Унитарные предприятия' union
select 42, 15200, 'Унитарные предприятия, основанные на праве хозяйственного ведения' union
select -1, 15241, 'Федеральные государственные унитарные предприятия' union
select -1, 15242, 'Государственные унитарные предприятия субъектов Российской Федерации' union
select -1, 15243, 'Муниципальные унитарные предприятия' union
select 41, 15100, 'Унитарные предприятия, основанные на праве оперативного управления (казенные предприятия)' union
select -1, 15141, 'Федеральные казенные предприятия' union
select -1, 15142, 'Казенные предприятия субъектов Российской Федерации' union
select -1, 15143, 'Муниципальные казенные предприятия' union
select 70, 20000, 'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ НЕКОММЕРЧЕСКИМИ ОРГАНИЗАЦИЯМИ' union
select 85, 20100, 'Потребительские кооперативы' union
select -1, 20101, 'Гаражные и гаражно-строительные кооперативы' union
select -1, 20102, 'Жилищные и жилищно-строительные кооперативы' union
select -1, 20103, 'Жилищные накопительные кооперативы' union
select -1, 20104, 'Кредитные потребительские кооперативы' union
select -1, 20105, 'Кредитные потребительские кооперативы граждан' union
select -1, 20106, 'Кредитные кооперативы второго уровня' union
select -1, 20107, 'Потребительские общества' union
select -1, 20109, 'Сельскохозяйственные потребительские перерабатывающие кооперативы' union
select -1, 20110, 'Сельскохозяйственные потребительские сбытовые (торговые) кооперативы' union
select -1, 20111, 'Сельскохозяйственные потребительские обслуживающие кооперативы' union
select -1, 20112, 'Сельскохозяйственные потребительские снабженческие кооперативы' union
select -1, 20113, 'Сельскохозяйственные потребительские садоводческие кооперативы' union
select -1, 20114, 'Сельскохозяйственные потребительские огороднические кооперативы' union
select -1, 20115, 'Сельскохозяйственные потребительские животноводческие кооперативы' union
select -1, 21002, 'Садоводческие, огороднические или дачные потребительские кооперативы' union
select 83, 20200, 'Общественные организации (объединения)' union
select -1, 20201, 'Политические партии' union
select -1, 20202, 'Профсоюзные организации' union
select -1, 20905, 'Общественные учреждения' union
select -1, 20300, 'Религиозные организации' union
select 84, 20210, 'Общественные движения' union
select 88, 20400, 'Фонды' union
select -1, 20401, 'Благотворительные фонды' union
select -1, 20402, 'Негосударственные пенсионные фонды' union
select -1, 20403, 'Общественные фонды' union
select -1, 20404, 'Экологические фонды' union
select 81, 20900, 'Учреждения' union
select 71, 20906, 'Частные учреждения' union
select -1, 20902, 'Благотворительные учреждения' union
select -1, 20908, 'Учреждения религиозных организаций' union
select 72, 20903, 'Бюджетные учреждения' union
select -1, 20907, 'Учреждения академий наук' union
select -1, 28003, 'Государственные академии наук' union
select 73, 20901, 'Автономные учреждения' union
select 74, 20904, 'Казенные учреждения' union
select 82, 28005, 'Государственные корпорации' union
select -1, 28004, 'Государственные компании' union
select 78, 20211, 'Органы общественной самодеятельности' union
select 96, 20500, 'Некоммерческие партнерства' union
select -1, 21003, 'Садоводческие, огороднические или дачные некоммерческие партнерства' union
select -1, 28002, 'Адвокатские бюро' union
select 97, 28001, 'Автономные некоммерческие организации' union
select 93, 20600, 'Объединения юридических лиц' union
select -1, 20601, 'Ассоциации (союзы) экономического взаимодействия субъектов Российской Федерации' union
select -1, 20603, 'Советы муниципальных образований субъектов Российской Федерации' union
select -1, 20604, 'Союзы (ассоциации) кредитных кооперативов' union
select -1, 20605, 'Союзы (ассоциации) кооперативов' union
select -1, 20606, 'Союзы (ассоциации) общественных объединений' union
select -1, 20607, 'Союзы (ассоциации) общин малочисленных народов' union
select -1, 20608, 'Союзы потребительских обществ' union
select 77, 28013, 'Объединения (союзы) крестьянских (фермерских) хозяйств' union
select 80, 28017, 'Территориальные общественные самоуправления' union
select 94, 28016, 'Товарищества собственников жилья' union
select 76, 21001, 'Садоводческие, огороднические или дачные некоммерческие товарищества' union
select 89, 28006, 'Казачьи общества' union
select -1, 28007, 'Коллегии адвокатов' union
select -1, 28008, 'Общества взаимного страхования' union
select -1, 28010, 'Общины коренных малочисленных народов' union
select -1, 28012, 'Объединения работодателей' union
select -1, 28014, 'Отделения иностранных некоммерческих неправительственных организаций' union
select -1, 20801, 'Адвокатские палаты' union
select -1, 20802, 'Нотариальные палаты' union
select -1, 20803, 'Торгово-промышленные палаты' union
select -1, 29000, 'Иные некоммерческие организации, не включенные в другие группировки' union
select 99, 30000, 'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ОРГАНИЗАЦИЙ, СОЗДАННЫХ БЕЗ ПРАВ ЮРИДИЧЕСКОГО ЛИЦА' union
select 92, 30005, 'Паевые инвестиционные фонды' union
select 87, 30006, 'Простые товарищества' union
select 90, 30001, 'Представительства юридических лиц' union
select -1, 30002, 'Филиалы юридических лиц' union
select -1, 30003, 'Обособленные подразделения юридических лиц' union
select -1, 30004, 'Структурные подразделения обособленных подразделений юридических лиц' union
select 95, 50101, 'Главы крестьянских (фермерских) хозяйств' union
select 98, 40001, 'Межправительственные международные организации' union
select -1, 40002, 'Неправительственные международные организации' union
select 91, 50102, 'Индивидуальные предприниматели' union
select -1, 50201, 'Адвокаты, учредившие адвокатский кабинет' union
select -1, 50202, 'Нотариусы, занимающиеся частной практикой'

declare @old int, @new int, @name varchar(500)
declare xxx cursor for select old, new, name from kopf_tmp
open xxx
fetch next from xxx into @old, @new, @name
while @@fetch_status = 0 begin

	if @old < 0 or not exists (select 1 from KOPF where kod = convert(varchar,@old))
		insert into KOPF (Kod, Kopf_Name) Values (convert(varchar,@new), @name)
	else
		update KOPF set Kod = convert(varchar,@new), Kopf_Name = @name
		where Kod = convert(varchar,@old)

	fetch next from xxx into @old, @new, @name
end
close xxx
deallocate xxx


select @new = Kopf_Id from Kopf where Kod = '10000'

update Org Set Kopf_Id = @new, Kopf_Changed = 1
Where (select Len(Kod) from Kopf where kopf.Kopf_Id = Org.Kopf_Id) < 5

Delete from KOPF Where Len(Kod) < 5

drop Table kopf_tmp


go


ALTER   VIEW [dbo].[v_ORG]
AS
SELECT     O.ORGID, O.TERR_ID, KTERR.NAME AS TERR, O.ORGNAME AS ORGNAME, O.OrgSName, O.URADDR, O.FIZADDR, O.POSTADDR, O.PHONE, O.OKPO, O.INN, O.OKBV,
                      O.FIRST_DATE, O.LAST_DATE, CAST(CASE WHEN FORM6HDR.F6_ID IS NULL THEN 0 ELSE 1 END AS bit) AS HAS_F6, O.SOOGU, O.PARENT,
                      O.MAINOKONH, O.OKONH, O.OCCUPATION,
                      O.FS_ID, KFS.KOD AS KFS_KOD, KFS.FS_NAME, KFS.KOD + ' - ' + KFS.FS_NAME AS KFS,
                      O.KOPF_ID, KOPF.KOD + ' - ' + KOPF.KOPF_NAME AS KOPF, O.KODREG, O.KODOKTMO, O.REGDATE, O.REGNUM,
                      O.REGPLACE AS REG_PLACE, O.COMMENT, O.OUT_REASON, O.OUT_DATE,
                      O.SBM_ID, VV5.KOD AS SBM_KOD, VV5.KOD + ' - ' + VV5.NAME AS SUBMISSION,
                      FORM6HDR.F6_ID, O.HAS_BRON, O.F6_SHIFR,
                      O.CHK_DATE AS CHK_DATE, FORM6HDR.RAB_COUNT, FORM6HDR.ZAP_COUNT, FORM6HDR.ZAB_COUNT, FORM6HDR.CHECKED AS F6CHECKED,
                      CASE WHEN (KFS.KOD = '12' OR KFS.KOD = '41' OR (KFS.KOD = '43' AND VV5.KOD = '01')) THEN 1
                      WHEN (KFS.KOD = '13' OR KFS.KOD = '14' OR KFS.KOD = '42' OR (KFS.KOD = '43' AND (VV5.KOD = '02' OR VV5.KOD = '03'))) THEN 2
                      ELSE 3 END AS KFP_ID,
                      O.Feature1,O.Feature2,O.Feature3,
                      O.OVK_ID,
                      HEAD.FIO AS HEADFAM, HEAD.PHONE AS HEADPHONE,
                      VUR.FIO AS VURFAM, VUR.PHONE AS VURPHONE,
					  o.kopf_changed, o.Email
FROM         ORG O LEFT JOIN
                      KTERR ON O.TERR_ID = KTERR.TERR_ID LEFT JOIN
                      KFS ON O.FS_ID = KFS.FS_ID LEFT JOIN
                      KOPF ON O.KOPF_ID = KOPF.KOPF_ID LEFT JOIN
                      VV5 ON O.SBM_ID = VV5.ID LEFT JOIN
                      FORM6HDR ON O.ORGID = FORM6HDR.ORGID LEFT JOIN
                      ORG_CONT HEAD ON O.ORGID = HEAD.ORGID and HEAD.IS_GEN = 1 LEFT JOIN
                      ORG_CONT VUR ON O.ORGID = VUR.ORGID and VUR.IS_VUS = 1

GO


update kfs set fs_name = 'Собственность субъектов Российской Федерации' where kod = 13
update kfs set fs_name = 'Собственность российских граждан, постоянно проживающих за границей' where kod = 18
update kfs set fs_name = 'Совместная федеральная и иностранная собственность' where kod = 31


go

Alter PROCEDURE [dbo].[sp_ImportSubj]
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
                PHONE,
                POSITION_NAME2,
                FIO2,
                PHONE2
                )
        SELECT
                SS.SUBJ_ID,
                I.SUBJ_INFO_ID,
                I.ORG_NAME,
                I.POSITION_NAME,
                I.FIO,
                I.PHONE,
                I.POSITION_NAME2,
                I.FIO2,
                I.PHONE2
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
                PARAM_VALUE,
				value3,
				value4,
				value5,
				value6,
				value7,
				value8
                )
        SELECT
                SS.SUBJ_ID,
                P.SUBJ_PARAM_ID,
                P.PARAM_VALUE,
				P.value3,
				P.value4,
				P.value5,
				P.value6,
				P.value7,
				P.value8
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
                DELETE FROM FSVT2012
                WHERE SUBJ_ID IN (SELECT S.SUBJ_ID FROM SUBJ S JOIN [dbo].[#SUBJ] T ON S.TERR_ID = T.TERR_ID)
                if @@ERROR != 0
                begin
                        raiserror 51507 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                DELETE FROM FAnaliz
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
                INSERT INTO FSVT2012 (
                        [SUBJ_ID],
                        [NUM],
						[N02],
						[N03],
						[N04],
						[N05],
						[N06],
						[N07],
						[N08],
						[N09],
						[N10],
						[N11]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
						F.[N02],
						F.[N03],
						F.[N04],
						F.[N05],
						F.[N06],
						F.[N07],
						F.[N08],
						F.[N09],
						F.[N10],
						F.[N11]
                FROM [dbo].[#FSVT2012] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
                if @@ERROR != 0
                begin
                        raiserror 51510 'Невозможно произвести импорт субъекта.'
                        ROLLBACK TRANSACTION
                        return
                end
                INSERT INTO FAnaliz (
                        [SUBJ_ID],
                        [NUM],
						[N01],
						[N02],
						[N10],
						[N12]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
						F.[N01],
						F.[N02],
						F.[N10],
						F.[N12]
                FROM [dbo].[#FAnaliz] F JOIN [dbo].[#SUBJ] S ON F.SUBJ_ID = S.SUBJ_ID JOIN SUBJ SS ON S.TERR_ID = SS.TERR_ID
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
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed
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
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed
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
						KPIS = O.KPIS,
						COMPUTERSS = O.COMPUTERSS,
						SOFTWARENUMS = O.SOFTWARENUMS,
						KPISS = O.KPISS,
						SOFTWARE = O.SOFTWARE,
                        Kopf_Changed = O.Kopf_Changed
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
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed
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
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed
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


go


Alter PROCEDURE [dbo].[sp_ImportOrg]
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
						KPIS = T.KPIS,
						COMPUTERSS = T.COMPUTERSS,
						SOFTWARENUMS = T.SOFTWARENUMS,
						KPISS = T.KPISS,
						SOFTWARE = T.SOFTWARE,
                        Kopf_Changed = T.Kopf_Changed
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
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed
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
						KPIS,
						COMPUTERSS,
						SOFTWARENUMS,
						KPISS,
						SOFTWARE,
                        Kopf_Changed
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




go





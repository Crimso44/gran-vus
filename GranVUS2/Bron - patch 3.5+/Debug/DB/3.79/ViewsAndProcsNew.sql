Update KCProf Set 
	Print_Name = 'Специалисты', Expression = null, State = 0
Where CProf_Id = 200;
Update Form6 Set 
	Print_Name = 'Специалисты', Expression = null
Where CProf_Id = 200;

Delete from Form6 Where CProf_Id > 200 and CProf_Id < 300;
Delete from KCprof Where CProf_Id > 200 and CProf_Id < 300;

Update KCProf Set 
	CProf_Name = 'Служащие', Print_Name = 'Служащие', Line_No = 3
Where CProf_Id = 300;
Update Form6 Set 
	Print_Name = 'Служащие', Col_B = 3
Where CProf_Id = 300;

Update KCProf Set 
	Print_Name = 'Рабочие', Expression = '410+420', Line_No = 4
Where CProf_Id = 400;
Update Form6 Set 
	Print_Name = 'Рабочие', Expression = '410+420', Col_B = 4
Where CProf_Id = 400;

Delete from Form6 Where CProf_Id > 400 and CProf_Id < 500 and CProf_Id <> 470;
Delete from KCprof Where CProf_Id > 400 and CProf_Id < 500 and CProf_Id <> 470;

ALTER TABLE [dbo].[FORM6] DROP CONSTRAINT FK_FORM6_KCPROF;

Update KCProf Set 
	CProf_Id = 410, CProf_Name = 'Рабочие-водители', Print_Name = 'из них водители', Line_No = null
Where CProf_Id = 470;
Update Form6 Set 
	CProf_Id = 410, Print_Name = 'из них водители', Col_B = null
Where CProf_Id = 470;
ALTER TABLE [dbo].[FORM6] ADD
        CONSTRAINT [FK_FORM6_KCPROF] FOREIGN KEY
        (
                [CPROF_ID]
        ) REFERENCES [dbo].[KCPROF] (
                [CPROF_ID]
        );


Insert Into KCProf (CProf_Id, CProf_Name, Print_Name, Expression, State, Line_No)
Values (420, 'Прочие рабочие', 'Прочие рабочие', Null, 0, Null);

INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B,
  col_1, col_2, col_3, col_4, col_5, col_6, col_7, col_8, col_9, col_10, col_11, col_12, col_13, col_14, col_15)
SELECT k.CPROF_ID, f.F6_ID, k.PRINT_NAME, k.EXPRESSION, 0, k.LINE_NO,
  NullIf(IsNull(f400.col_1,0) - IsNull(f.col_1,0),0), 
  NullIf(IsNull(f400.col_2,0) - IsNull(f.col_2,0),0), 
  NullIf(IsNull(f400.col_3,0) - IsNull(f.col_3,0),0), 
  NullIf(IsNull(f400.col_4,0) - IsNull(f.col_4,0),0), 
  NullIf(IsNull(f400.col_5,0) - IsNull(f.col_5,0),0), 
  NullIf(IsNull(f400.col_6,0) - IsNull(f.col_6,0),0), 
  NullIf(IsNull(f400.col_7,0) - IsNull(f.col_7,0),0), 
  NullIf(IsNull(f400.col_8,0) - IsNull(f.col_8,0),0), 
  NullIf(IsNull(f400.col_9,0) - IsNull(f.col_9,0),0), 
  NullIf(IsNull(f400.col_10,0) - IsNull(f.col_10,0),0), 
  NullIf(IsNull(f400.col_11,0) - IsNull(f.col_11,0),0), 
  NullIf(IsNull(f400.col_12,0) - IsNull(f.col_12,0),0), 
  NullIf(IsNull(f400.col_13,0) - IsNull(f.col_13,0),0), 
  NullIf(IsNull(f400.col_14,0) - IsNull(f.col_14,0),0), 
  NullIf(IsNull(f400.col_15,0) - IsNull(f.col_15,0),0)
FROM KCPROF k 
join Form6 f on f.cprof_id = 410
join Form6 f400 on f.f6_id = f400.f6_id and f400.cprof_id = 400
Where k.CProf_Id = 420;



Update KCProf Set 
	Line_No = null
Where CProf_Id = 500;
Update Form6 Set 
	Col_B = Null
Where CProf_Id = 500;


Update KCProf Set 
	CProf_Name = 'Всего', Print_Name = 'Всего (сумма строк 1+2+3+4)', Line_No = 5
Where CProf_Id = 1000;
Update Form6 Set 
	Print_Name = 'Всего (сумма строк 1+2+3+4)', Col_B = 5
Where CProf_Id = 1000;

Delete Form6 Where CProf_Id in (1500, 2000);
Delete KCProf Where CProf_Id in (1500, 2000);


go

Alter Table Org Add Okved_Changed bit
go

update Org Set Okved_Changed = 1

go



alter table kopf add kod_old2 varchar(5)
go

update kopf set kod_old2 = kod
go


Alter TABLE [dbo].[FAnaliz] Add	[N06] [int] NULL;
go

alter table dbo.ORG add SBM varchar(50) NULL
go

alter table dbo.PER alter column Razd_No varchar(4000) NULL
go


update kopf set kod = '12300', kopf_name = 'Общества с ограниченной ответственностью' where kod_old2='12165';
update kopf set kod = '65000', kopf_name = 'Унитарные предприятия'                                                                                where kod_old2='15000';
update kopf set kod = '65100', kopf_name = 'Унитарные предприятия, основанные на праве оперативного управления (казенные предприятия)'            where kod_old2='15100';
update kopf set kod = '65141', kopf_name = 'Федеральные казенные предприятия'                                                                     where kod_old2='15141';
update kopf set kod = '65142', kopf_name = 'Казенные предприятия субъектов Российской Федерации'                                                  where kod_old2='15142';
update kopf set kod = '65143', kopf_name = 'Муниципальные казенные предприятия'                                                                   where kod_old2='15143';
update kopf set kod = '65200', kopf_name = 'Унитарные предприятия, основанные на праве хозяйственного ведения'                                    where kod_old2='15200';
update kopf set kod = '65241', kopf_name = 'Федеральные государственные унитарные предприятия'                                                    where kod_old2='15241';
update kopf set kod = '65242', kopf_name = 'Государственные унитарные предприятия субъектов Российской Федерации'                                 where kod_old2='15242';
update kopf set kod = '65243', kopf_name = 'Муниципальные унитарные предприятия'                                                                  where kod_old2='15243';
update kopf set kod = '71500', kopf_name = 'Религиозные организации'                                                                              where kod_old2='20300';
update kopf set kod = '70400', kopf_name = 'Фонды'                                                                                                where kod_old2='20400';
update kopf set kod = '70401', kopf_name = 'Благотворительные фонды'                                                                              where kod_old2='20401';
update kopf set kod = '70402', kopf_name = 'Негосударственные пенсионные фонды'                                                                   where kod_old2='20402';
update kopf set kod = '70403', kopf_name = 'Общественные фонды'                                                                                   where kod_old2='20403';
update kopf set kod = '70404', kopf_name = 'Экологические фонды'                                                                                  where kod_old2='20404';
update kopf set kod = '20614', kopf_name = 'Некоммерческие партнерства'                                                                           where kod_old2='20500';
update kopf set kod = '20609', kopf_name = 'Адвокатские палаты'                                                                                   where kod_old2='20801';
update kopf set kod = '20610', kopf_name = 'Нотариальные палаты'                                                                                  where kod_old2='20802';
update kopf set kod = '20611', kopf_name = 'Торгово-промышленные палаты'                                                                          where kod_old2='20803';
update kopf set kod = '75000', kopf_name = 'Учреждения'                                                                                           where kod_old2='20900';
update kopf set kod = '20701', kopf_name = 'Садоводческие, огороднические или дачные некоммерческие товарищества'                                 where kod_old2='21001';
update kopf set kod = '20120', kopf_name = 'Садоводческие, огороднические или дачные потребительские кооперативы'                                 where kod_old2='21002';
update kopf set kod = '20617', kopf_name = 'Садоводческие, огороднические или дачные некоммерческие партнерства'                                  where kod_old2='21003';
update kopf set kod = '71400', kopf_name = 'Автономные некоммерческие организации'                                                                where kod_old2='28001';
update kopf set kod = '20615', kopf_name = 'Адвокатские бюро'                                                                                     where kod_old2='28002';
update kopf set kod = '75300', kopf_name = 'Государственные академии наук'                                                                        where kod_old2='28003';
update kopf set kod = '71602', kopf_name = 'Государственные компании'                                                                             where kod_old2='28004';
update kopf set kod = '71601', kopf_name = 'Государственные корпорации'                                                                           where kod_old2='28005';
update kopf set kod = '20616', kopf_name = 'Коллегии адвокатов'                                                                                   where kod_old2='28007';
update kopf set kod = '20108', kopf_name = 'Общества взаимного страхования'                                                                       where kod_old2='28008';
update kopf set kod = '21200', kopf_name = 'Общины коренных малочисленных народов Российской Федерации'                                           where kod_old2='28010';
update kopf set kod = '20612', kopf_name = 'Объединения работодателей'                                                                            where kod_old2='28012';
update kopf set kod = '71610', kopf_name = 'Отделения иностранных некоммерческих неправительственных организаций'                                 where kod_old2='28014';
update kopf set kod = '20716', kopf_name = 'Товарищества собственников жилья'                                                                     where kod_old2='28016';
update kopf set kod = '20217', kopf_name = 'Территориальные общественные самоуправления'                                                          where kod_old2='28017';
update kopf set kod = '10000', kopf_name = 'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ КОММЕРЧЕСКИМИ КОРПОРАТИВНЫМИ ОРГАНИЗАЦИЯМИ' where kod_old2='10000';
update kopf set kod = '12247', kopf_name = 'Публичные акционерные общества'                                                                       where kod_old2='12247';
update kopf set kod = '12267', kopf_name = 'Непубличные акционерные общества'                                                                     where kod_old2='12267';
update kopf set kod = '20000', kopf_name = 'ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ НЕКОММЕРЧЕСКИМИ КОРПОРАТИВНЫМИ ОРГАНИЗАЦИЯМИ' where kod_old2='20000';
update kopf set kod = '20102', kopf_name = 'Жилищные или жилищно-строительные кооперативы'                                                        where kod_old2='20102';
update kopf set kod = '20200', kopf_name = 'Общественные организации'                                                                             where kod_old2='20200';
update kopf set kod = '20600', kopf_name = 'Ассоциации (союзы)'                                                                                   where kod_old2='20600';
update kopf set kod = '-1', kopf_name = 'Иные некоммерческие организации, не включенные в другие группировки'                                     where kod_old2='29000';
update kopf set kod = '-2', kopf_name = 'Объединения (союзы) крестьянских (фермерских) хозяйств'                                                  where kod_old2='28013';
update kopf set kod = '-3', kopf_name = 'Казачьи общества'                                                                                        where kod_old2='28006';
update kopf set kod = '-4', kopf_name = 'Автономные учреждения'                                                                                   where kod_old2='20901';
update kopf set kod = '-5', kopf_name = 'Благотворительные учреждения'                                                                            where kod_old2='20902';
update kopf set kod = '-6', kopf_name = 'Бюджетные учреждения'                                                                                    where kod_old2='20903';
update kopf set kod = '-7', kopf_name = 'Казенные учреждения'                                                                                     where kod_old2='20904';
update kopf set kod = '-8', kopf_name = 'Общественные учреждения'                                                                                 where kod_old2='20905';
update kopf set kod = '-9', kopf_name = 'Частные учреждения'                                                                                      where kod_old2='20906';
update kopf set kod = '-10', kopf_name = 'Учреждения академий наук'                                                                                where kod_old2='20907';
update kopf set kod = '-11', kopf_name = 'Учреждения религиозных организаций'                                                                      where kod_old2='20908';


Insert into kopf (kod, kopf_name) Values('20121','Фонды проката');
Insert into kopf (kod, kopf_name) Values('20613','Объединения фермерских хозяйств'                                                                      );
Insert into kopf (kod, kopf_name) Values('20618','Ассоциации (союзы) садоводческих, огороднических и дачных некоммерческих объединений'                 );
Insert into kopf (kod, kopf_name) Values('20619','Саморегулируемые организации'                                                                         );
Insert into kopf (kod, kopf_name) Values('20620','Объединения (ассоциации и союзы) благотворительных организаций'                                       );
Insert into kopf (kod, kopf_name) Values('20700','Товарищества собственников недвижимости'                                                              );
Insert into kopf (kod, kopf_name) Values('21100','Казачьи общества, внесенные в государственный реестр казачьих обществ в Российской Федерации'         );
Insert into kopf (kod, kopf_name) Values('30008','Районные суды, городские суды, межрайонные суды (районные суды)'                                      );
Insert into kopf (kod, kopf_name) Values('60000','ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ КОММЕРЧЕСКИМИ УНИТАРНЫМИ ОРГАНИЗАЦИЯМИ'     );
Insert into kopf (kod, kopf_name) Values('70000','ОРГАНИЗАЦИОННО-ПРАВОВЫЕ ФОРМЫ ЮРИДИЧЕСКИХ ЛИЦ, ЯВЛЯЮЩИХСЯ НЕКОММЕРЧЕСКИМИ УНИТАРНЫМИ ОРГАНИЗАЦИЯМИ'   );
Insert into kopf (kod, kopf_name) Values('71600','Публично-правовые компании'                                                                           );
Insert into kopf (kod, kopf_name) Values('75100','Учреждения, созданные Российской Федерацией'                                                          );
Insert into kopf (kod, kopf_name) Values('75101','Федеральные государственные автономные учреждения'                                                    );
Insert into kopf (kod, kopf_name) Values('75103','Федеральные государственные бюджетные учреждения'                                                     );
Insert into kopf (kod, kopf_name) Values('75104','Федеральные государственные казенные учреждения'                                                      );
Insert into kopf (kod, kopf_name) Values('75200','Учреждения, созданные субъектом Российской Федерации'                                                 );
Insert into kopf (kod, kopf_name) Values('75201','Государственные автономные учреждения субъектов Российской Федерации'                                 );
Insert into kopf (kod, kopf_name) Values('75203','Государственные бюджетные учреждения субъектов Российской Федерации'                                  );
Insert into kopf (kod, kopf_name) Values('75204','Государственные казенные учреждения субъектов Российской Федерации'                                   );
Insert into kopf (kod, kopf_name) Values('75400','Учреждения, созданные муниципальным образованием (муниципальные учреждения)'                          );
Insert into kopf (kod, kopf_name) Values('75401','Муниципальные автономные учреждения'                                                                  );
Insert into kopf (kod, kopf_name) Values('15300','Крестьянские (фермерские) хозяйства'                                                                  );
                                                                                                                                  

go

update org set Kopf_Changed = 1 
from org join kopf on kopf.kopf_id = org.KOPF_ID
where CHARINDEX('-',kopf.KOD) > 0


go

Alter   PROCEDURE [dbo].[sp_ImportSubj]
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
                        [Q],
                        [R],
                        [S],
                        [T],
                        [U]
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
                        F.[Q],
                        F.[R],
                        F.[S],
                        F.[T],
                        F.[U]
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
						[N06],
						[N10],
						[N12]
                        )
                SELECT
                        SS.SUBJ_ID,
                        F.[NUM],
						F.[N01],
						F.[N02],
						F.[N06],
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
                        SBM,
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
                        Kopf_Changed,
                        Okved_Changed
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
                        SBM = O.SBM,
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
                        Kopf_Changed = O.Kopf_Changed,
                        Okved_Changed = O.Okved_Changed
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
                        SBM,
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
                        Kopf_Changed,
                        Okved_Changed
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

              declare @per_no varchar(4000), @razd_no varchar(4000), @r_no varchar(4000)
              declare xx cursor for 
              select distinct per_no  
              from [dbo].[#ORG_PER]
              open xx
              fetch next from xx into @per_no
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

	              insert into PER (orgid, per_no, razd_no)
		          Values (@EXT_ID, @per_no, @razd_no)

	              fetch next from xx into @per_no
              end
			  close xx
			  deallocate xx


COMMIT TRANSACTION



go



Alter PROCEDURE CHECK_F6 AS

UPDATE form6hdr
   SET CHECKED = CASE WHEN F6_ID in(
                    SELECT f6.F6_ID
                      FROM FORM6 f6
                     WHERE
                           ISNULL(COL_1,0) <  ISNULL(COL_2,0)+ISNULL(COL_11,0)
                        OR ISNULL(COL_2,0) <> ISNULL(COL_3,0)+ISNULL(COL_4,0)
                        OR ISNULL(COL_2,0) <  ISNULL(COL_9,0)+ISNULL(COL_10,0)
                        OR ISNULL(COL_3,0) <  ISNULL(COL_7,0)
                        OR ISNULL(COL_4,0) <  ISNULL(COL_8,0)
                        OR ISNULL(COL_6,0) <> ISNULL(COL_7,0)+ISNULL(COL_8,0)
                    UNION
                    SELECT F6_ID FROM (
                    SELECT
                           f6.F6_ID
                         , f6.CPROF_ID
                         , n_1  = SUM(ISNULL(sf6.COL_1,0)) - ISNULL(f6.COL_1,0)
                         , n_2  = SUM(ISNULL(sf6.COL_2,0)) - ISNULL(f6.COL_2,0)
                         , n_3  = SUM(ISNULL(sf6.COL_3,0)) - ISNULL(f6.COL_3,0)
                         , n_4  = SUM(ISNULL(sf6.COL_4,0)) - ISNULL(f6.COL_4,0)
                         , n_5  = SUM(ISNULL(sf6.COL_5,0)) - ISNULL(f6.COL_5,0)
                         , n_6  = SUM(ISNULL(sf6.COL_6,0)) - ISNULL(f6.COL_6,0)
                         , n_7  = SUM(ISNULL(sf6.COL_7,0)) - ISNULL(f6.COL_7,0)
                         , n_8  = SUM(ISNULL(sf6.COL_8,0)) - ISNULL(f6.COL_8,0)
                         , n_9  = SUM(ISNULL(sf6.COL_9,0)) - ISNULL(f6.COL_9,0)
                         , n_10 = SUM(ISNULL(sf6.COL_10,0))- ISNULL(f6.COL_10,0)
                         , n_11 = SUM(ISNULL(sf6.COL_11,0))- ISNULL(f6.COL_11,0)
                         /*, n_12 = SUM(ISNULL(sf6.COL_12,0))- ISNULL(f6.COL_12,0)
                         , n_13 = SUM(ISNULL(sf6.COL_13,0))- ISNULL(f6.COL_13,0)
                         , n_14 = SUM(ISNULL(sf6.COL_14,0))- ISNULL(f6.COL_14,0)
                         , n_15 = SUM(ISNULL(sf6.COL_15,0))- ISNULL(f6.COL_15,0)*/
                      FROM (SELECT *
                                 , ExpPlus = '+'+ISNULL(
                                                CASE CPROF_ID
                                                  WHEN 400 THEN '410+420'
                                                  WHEN 1000 THEN '100+200+300+400'
                                                  WHEN 496 THEN '1000'
                                                  WHEN 500 THEN '1000'
                                                  ELSE LTrim(EXPRESSION)
                                                END
                                                       ,'')+'+'
                              FROM FORM6) f6
                           LEFT OUTER JOIN
                           FORM6 sf6 ON sf6.F6_ID=f6.F6_ID
                                    AND sf6.CPROF_ID<>f6.CPROF_ID
                                    AND CHARINDEX('+'+CAST(sf6.CPROF_ID AS VarChar)+'+',f6.ExpPlus) > 0
                     WHERE f6.ExpPlus<>'++'
                     GROUP BY
                           f6.F6_ID
                         , f6.CPROF_ID
                         , f6.COL_1
                         , f6.COL_2
                         , f6.COL_3
                         , f6.COL_4
                         , f6.COL_5
                         , f6.COL_6
                         , f6.COL_7
                         , f6.COL_8
                         , f6.COL_9
                         , f6.COL_10
                         , f6.COL_11
                         /*, f6.COL_12
                         , f6.COL_13
                         , f6.COL_14
                         , f6.COL_15*/
                         , f6.ExpPlus
                    ) f6
                     WHERE 1= CASE WHEN (CPROF_ID <> 200
                                     AND (n_1 < 0
                                       OR n_2 < 0
                                       OR n_3 < 0
                                       OR n_4 < 0
                                       OR n_5 < 0
                                       OR n_6 < 0
                                       OR n_7 < 0
                                       OR n_8 < 0
                                       OR n_9 < 0
                                       OR n_10< 0
                                       OR n_11< 0
                                       /*OR n_12< 0
                                       OR n_13< 0
                                       OR n_14< 0
                                       OR n_15< 0*/))
                                     OR (CPROF_ID = 200
                                     AND (n_1 > 0
                                       OR n_2 > 0
                                       OR n_3 > 0
                                       OR n_4 > 0
                                       OR n_5 > 0
                                       OR n_6 > 0
                                       OR n_7 > 0
                                       OR n_8 > 0
                                       OR n_9 > 0
                                       OR n_10> 0
                                       OR n_11> 0
                                       /*OR n_12> 0
                                       OR n_13> 0
                                       OR n_14> 0
                                       OR n_15> 0*/))
                         OR (CPROF_ID in (400, 1000)
                         AND (n_1 <> 0
                                       OR n_2 <> 0
                                       OR n_3 <> 0
                                       OR n_4 <> 0
                                       OR n_5 <> 0
                                       OR n_6 <> 0
                                       OR n_7 <> 0
                                       OR n_8 <> 0
                                       OR n_9 <> 0
                                       OR n_10<> 0
                                       /*OR n_11<> 0
                                       OR n_12<> 0
                                       OR n_13<> 0
                                       OR n_14<> 0
                                       OR n_15<> 0*/))
                                   THEN 1 ELSE 0 END)
THEN 0 ELSE 1 END

GO



Alter     PROCEDURE [dbo].[sp_FFSGenerate] -- changed in ver 3.71
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



  DELETE FROM FFS
  WHERE SUBJ_ID = @SUBJ_ID

  if @@ERROR != 0
  begin
    raiserror 50300 'Невозможно создать форму по видам собственности.'
    ROLLBACK TRANSACTION
    return
  end

  INSERT INTO FFS(
    SUBJ_ID
  , FS_ID
  , FS_NAME
  , KOD
  , WHOLE
  , WU
  , BRON
  , TOWN_WHOLE
  , TOWN_WU
  , TOWN_BRON
  , VILLAGE_WHOLE
  , VILLAGE_WU
  , VILLAGE_BRON
  )
  SELECT @SUBJ_ID, K.FS_ID, K.FS_NAME, K.KOD
  , NULLIF(COUNT(O.ORGID),0)   AS WHOLE
  , NULLIF(SUM(CAST(O.HAS_WU AS Int)),0)    AS WU
  , NULLIF(SUM(CAST(O.HAS_BRON AS Int)),0)  AS BRON
  , NULLIF(SUM(CASE O.PLACE WHEN 1 THEN 1 ELSE 0 END),0)    AS TOWN_WHOLE
  , NULLIF(SUM(CASE O.PLACE WHEN 1 THEN O.HAS_WU ELSE 0 END),0)    AS TOWN_WU
  , NULLIF(SUM(CASE O.PLACE WHEN 1 THEN O.HAS_BRON ELSE 0 END),0)  AS TOWN_BRON
  , NULLIF(SUM(CASE O.PLACE WHEN 2 THEN 1 ELSE 0 END),0) AS VILLAGE_WHOLE
  , NULLIF(SUM(CASE O.PLACE WHEN 2 THEN O.HAS_WU ELSE 0 END),0)    AS VILLAGE_WU
  , NULLIF(SUM(CASE O.PLACE WHEN 2 THEN O.HAS_BRON ELSE 0 END),0)  AS VILLAGE_BRON
  FROM KFS_ K LEFT OUTER JOIN
       (select
          OO.ORGID
        , FS_ID = CASE WHEN OO.FS_ID IN (SELECT FS_ID FROM KFS_)
                  THEN OO.FS_ID ELSE 0 END
        , OO.HAS_BRON
        , HAS_WU = CASE WHEN EXISTS(SELECT * FROM FORM6HDR, FORM6
                                     WHERE FORM6HDR.OrgID=OO.ORGID
                                       AND FORM6.F6_ID=FORM6HDR.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                   THEN 1 ELSE 0 END
        , PLACE = CASE SUBSTRING(ISNULL(OO.KODREG,0),6,1)
                    WHEN '3' THEN 1
                    WHEN '5' THEN 1
                    WHEN '6' THEN 1
                    WHEN '8' THEN 2
                    WHEN '9' THEN 2
                    ELSE 0 END
        from v_ORG OO
        where OO.OUT_DATE IS NULL
          AND OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
       ) O ON (O.FS_ID = K.FS_ID)
  GROUP BY K.FS_ID, K.FS_NAME, K.KOD

  if @@ERROR != 0
  begin
        raiserror 50301 'Невозможно создать форму по видам собственности.'
        ROLLBACK TRANSACTION
        return
  end

  UPDATE FFS SET
    WHOLE         = S.SUM_WHOLE
  , WU            = S.SUM_WU
  , BRON          = S.SUM_BRON
  , TOWN_WHOLE    = S.SUM_TOWN_WHOLE
  , TOWN_WU       = S.SUM_TOWN_WU
  , TOWN_BRON     = S.SUM_TOWN_BRON
  , VILLAGE_WHOLE = S.SUM_VILLAGE_WHOLE
  , VILLAGE_WU    = S.SUM_VILLAGE_WU
  , VILLAGE_BRON  = S.SUM_VILLAGE_BRON
  FROM (
        SELECT
        FS_ID = ISNULL(FS_ID,0),
        NULLIF(SUM(WHOLE),0) AS SUM_WHOLE,
        NULLIF(SUM(WU),0) AS SUM_WU,
        NULLIF(SUM(BRON),0) AS SUM_BRON,
        NULLIF(SUM(TOWN_WHOLE),0) AS SUM_TOWN_WHOLE,
        NULLIF(SUM(TOWN_WU),0) AS SUM_TOWN_WU,
        NULLIF(SUM(TOWN_BRON),0) AS SUM_TOWN_BRON,
        NULLIF(SUM(VILLAGE_WHOLE),0) AS SUM_VILLAGE_WHOLE,
        NULLIF(SUM(VILLAGE_WU),0) AS SUM_VILLAGE_WU,
        NULLIF(SUM(VILLAGE_BRON),0) AS SUM_VILLAGE_BRON
        FROM FFS
        WHERE (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        GROUP BY ISNULL(FS_ID,0)
        ) S
  WHERE S.FS_ID = FFS.FS_ID AND FFS.SUBJ_ID=@SUBJ_ID

        if @@ERROR != 0
        begin
                raiserror 50302 'Невозможно создать форму по видам собственности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION


GO

Alter     PROCEDURE [dbo].[sp_FOKVEDGenerate]
        @SUBJ_ID        int,
        @IS_FULL        bit,
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

        DELETE FROM FOKVED
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FOKVED([SUBJ_ID], [OKVED_SECTION]
        , [ORG_COUNT]
        , [ORG_BRON_COUNT]
        , [ORG_WU_COUNT]
        , [RAB_COUNT]
        , [ZAP_COUNT]
        , [ZAB_COUNT])
        SELECT @SUBJ_ID, K.OKVED_SECTION,
          NULLIF(COUNT(O.ORGID),0) AS ORG_COUNT,
          NULLIF(SUM(CAST(O.HAS_BRON AS Int)),0) AS ORG_BRON_COUNT,
          NULLIF(SUM(O.HAS_WU),0)  AS ORG_WU_COUNT,
          NULLIF(SUM(O.RAB_COUNT),0) AS RAB_COUNT,
          NULLIF(SUM(O.ZAP_COUNT),0) AS ZAP_COUNT,
          NULLIF(SUM(O.ZAB_COUNT),0) AS ZAB_COUNT
          FROM KOKVED_ K LEFT OUTER JOIN
               (select
                  OO.ORGID
                , OO.HAS_BRON
                , OO.RAB_COUNT
                , OO.ZAP_COUNT
                , OO.ZAB_COUNT
                , HAS_WU = CASE WHEN EXISTS(SELECT * FROM FORM6HDR, FORM6
                                             WHERE FORM6HDR.OrgID=OO.ORGID
                                               AND FORM6.F6_ID=FORM6HDR.F6_ID
                                               AND FORM6.COL_B=5
                                               --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                               )
                           THEN 1 ELSE 0 END
                , OKVED_FIRST = CASE WHEN (OO.MainOKONH LIKE '[0-9][0-9]' OR OO.MainOKONH LIKE '[0-9][0-9].%')
                                      AND EXISTS( SELECT * FROM KOKVED WHERE
                                                CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int) BETWEEN OKVED_BEGIN AND OKVED_END)
                                THEN CAST(SUBSTRING(OO.MainOKONH,1,2) AS Int)
                                ELSE 0 END
                  from v_ORG OO
                 where OO.OUT_DATE IS NULL
                   AND (@IS_FULL = 1 OR OO.F6CHECKED = 1)
                   AND OO.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
               ) O ON (O.OKVED_FIRST BETWEEN K.OKVED_BEGIN AND K.OKVED_END)
        GROUP BY K.OKVED_SECTION

        if @@ERROR != 0
        begin
                raiserror 50301 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end

        UPDATE FOKVED
        SET
                ORG_COUNT      = S.SUM_ORG_COUNT,
                ORG_BRON_COUNT = S.SUM_ORG_BRON_COUNT,
                ORG_WU_COUNT   = S.SUM_ORG_WU_COUNT,
                RAB_COUNT      = S.SUM_RAB_COUNT,
                ZAB_COUNT      = S.SUM_ZAB_COUNT,
                ZAP_COUNT      = S.SUM_ZAP_COUNT
        FROM (
                SELECT
                OKVED_SECTION,
                NULLIF(SUM(ORG_COUNT),0) AS SUM_ORG_COUNT,
                NULLIF(SUM(ORG_BRON_COUNT),0) AS SUM_ORG_BRON_COUNT,
                NULLIF(SUM(ORG_WU_COUNT),0) AS SUM_ORG_WU_COUNT,
                NULLIF(Sum(RAB_COUNT),0) AS SUM_RAB_COUNT,
                NULLIF(Sum(ZAP_COUNT),0) AS SUM_ZAP_COUNT,
                NULLIF(Sum(ZAB_COUNT),0) AS SUM_ZAB_COUNT
                FROM FOKVED
                WHERE (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY OKVED_SECTION
        ) S
        WHERE S.OKVED_SECTION = FOKVED.OKVED_SECTION AND FOKVED.SUBJ_ID=@SUBJ_ID

        if @@ERROR != 0
        begin
                raiserror 50302 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION







GO


Alter PROCEDURE [dbo].[sp_CalcSubjParams377] -- changed in ver 3.71
AS

DECLARE @OKATO VarChar(11), @KODTERR VarChar(20), @KTERR VarChar(20), @Subj_Id int

SELECT @OKATO   = SUBJ.KodReg
     , @KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
     , @KTERR   = KTERR.KODTERR
     , @Subj_Id = SUBJ.SUBJ_ID
  FROM SUBJ, CURR_SUBJ, KTERR
 WHERE SUBJ.SUBJ_ID=CURR_SUBJ.SUBJ_ID
   AND SUBJ.TERR_ID=KTERR.TERR_ID

declare @CITY float, @TOWN float, @VILLAGE float, @TOWNVILLAGE float, @INCITY float


SELECT
                @CITY = Round(convert(float,Sum(case when 
                		(SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '40' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '45' and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '7' or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '850' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '898') or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '950' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '998'))) 
                                	then f6.col_1 else 0 end))/1000,1)
                , @TOWN = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or 

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '1' then f6.col_1 else 0 end))/1000,1)
                , @VILLAGE = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then f6.col_1 else 0 end))/1000,1)
                , @TOWNVILLAGE = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '7' then f6.col_1 else 0 end))/1000,1)
                , @INCITY = Round(convert(float,Sum(case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '40' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) = '45') and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '3' or
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '9') then f6.col_1 else 0 end))/1000,1)
  FROM v_ORG oo
     join SUBJ s on oo.TERR_ID = s.TERR_ID
     join KTERR t on oo.TERR_ID = t.TERR_ID
     join FORM6HDR f6h on f6h.ORGID = oo.ORGID
     join FORM6 f6 on f6.F6_ID = f6h.F6_ID and f6.col_b = 5
 WHERE t.KODTERR LIKE @KODTERR --child or self
   AND s.SUBJ_AGG_ID = 1
   AND oo.OUT_DATE IS NULL


SELECT
  pt.SUBJ_PARAM_ID,
  case when pt.SUBJ_PARAM_ID in (1,4,5) then
	Sum(IsNull(value3,0)+IsNull(value4,0)+IsNull(value5,0)+IsNull(value6,0)+IsNull(value8,0))
       when pt.SUBJ_PARAM_ID = 2 then
	IsNull(@CITY,0)+IsNull(@TOWN,0)+IsNull(@VILLAGE,0)+IsNull(@TOWNVILLAGE,0)+IsNull(@INCITY,0)+
	Sum(case when p.SUBJ_AGG_ID = 2 then Param_Value else 0 end)
       when pt.SUBJ_PARAM_ID = 3 then
	Sum(IsNull(value3,0)+IsNull(value4,0)+IsNull(value8,0)) end PARAM_VALUE,
  case when pt.SUBJ_PARAM_ID = 2 then IsNull(@CITY,0) + 
		Sum(case when p.SUBJ_AGG_ID = 2 then value3 else 0 end)
	else Sum(value3) end value3,
  case when pt.SUBJ_PARAM_ID = 2 then 
	IsNull(@TOWN,0)+IsNull(@VILLAGE,0)+IsNull(@TOWNVILLAGE,0)+
	Sum(case when p.SUBJ_AGG_ID = 2 then value4 else 0 end)
	else Sum(value4) end value4,
  case pt.SUBJ_PARAM_ID when 2 then IsNull(@TOWN,0)+
  		Sum(case when p.SUBJ_AGG_ID = 2 then value5 else 0 end)
	when 3 then null else Sum(value5) end value5,
  case pt.SUBJ_PARAM_ID when 2 then IsNull(@VILLAGE,0)+
  		Sum(case when p.SUBJ_AGG_ID = 2 then value6 else 0 end)
	when 3 then null else Sum(value6) end value6,
  case when pt.SUBJ_PARAM_ID = 2 then IsNull(@TOWNVILLAGE,0)+ 
  		Sum(case when p.SUBJ_AGG_ID = 2 then value7 else 0 end)
	else null end value7,
  case when pt.SUBJ_PARAM_ID = 2 then IsNull(@INCITY,0)+
  		Sum(case when p.SUBJ_AGG_ID = 2 then value8 else 0 end)
	  else Sum(value8) end value8
 FROM SUBJ_PARAM_TYPE pt
	 left join (
		Select p.*, s.SUBJ_AGG_ID
		from SUBJ_PARAM p 
		join SUBJ s on p.SUBJ_ID = s.SUBJ_ID and s.Subj_Id <> @Subj_Id AND s.SUBJ_AGG_ID in (1,2)
		join KTERR t on s.TERR_ID = t.TERR_ID and t.KODTERR LIKE @KODTERR --child and not self
) p on p.SUBJ_PARAM_ID = pt.SUBJ_PARAM_ID     
 Group by pt.SUBJ_PARAM_ID
 Order BY pt.SUBJ_PARAM_ID




GO

Alter PROCEDURE [dbo].[sp_GenerateForm6_01]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int
  create table [dbo].[#OrgSet] (OrgId int)
  create table [dbo].[#SubjSet] (SubjId int)
  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet
        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50700 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 50701 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_01 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50702 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50705 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_01 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50706 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_01 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50707 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50708 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror 50709 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50710 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO


Alter PROCEDURE [dbo].[sp_GenerateForm6_02]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int
  create table [dbo].[#OrgSet] (OrgId int)
  create table [dbo].[#SubjSet] (SubjId int)
  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet
        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50800 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 50801 'Невозможно сформировать агрегированную форму ј 6.01.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_02 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50802 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50805 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_02 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50806 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_02 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50807 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50808 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror 50809 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50810 'Невозможно сформировать агрегированную форму ј 6.02.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

Alter PROCEDURE [dbo].[sp_GenerateForm6_03]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int
  create table [dbo].[#OrgSet] (OrgId int)
  create table [dbo].[#SubjSet] (SubjId int)
  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet
        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50900 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 50901 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_03 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50902 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 50905 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_03 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50906 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_03 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50907 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 50908 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror 50909 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50910 'Невозможно сформировать агрегированную форму ј 6.03.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

Alter PROCEDURE [dbo].[sp_GenerateForm6_04]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet


        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51700 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 51701 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_04 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 51702 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID

        if @@ERROR != 0
        begin
                raiserror 51705 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_04 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51706 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_04 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51707 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51708 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror 51709 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 51710 'Невозможно сформировать агрегированную форму ј 6.04.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

Alter PROCEDURE [dbo].[sp_GenerateForm6_05]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet


        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51800 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 51801 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_05 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 51802 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID

        if @@ERROR != 0
        begin
                raiserror 51805 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_05 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51806 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_05 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51807 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51808 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror 51809 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 51810 'Невозможно сформировать агрегированную форму ј 6.05.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION

GO

Alter PROCEDURE [dbo].[sp_GenerateForm6_06]
        @F6_ID int,
        @FilterType int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
declare @F6_SHIFR varchar(10),
        @ORG_SHIFR varchar(10),
        @SUBJ_ID int

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  if @FilterType=0 begin
    insert into [dbo].[#OrgSet]
    select OrgId from Org
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
  select OrgId from OrgSet


        SELECT @F6_SHIFR = F6_SHIFR, @SUBJ_ID = SUBJ_ID FROM FORM6HDR WHERE F6_ID = @F6_ID
        DELETE FROM FORM6
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51900 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end

        INSERT INTO FORM6 (CPROF_ID, F6_ID, PRINT_NAME, EXPRESSION, CALCULATE, COL_B)
        SELECT CPROF_ID, @F6_ID, PRINT_NAME, EXPRESSION, 0, LINE_NO
        FROM KCPROF
        if @@ERROR != 0
        begin
                raiserror 51901 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT
                F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F
                JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                JOIN v_ORG_06 O ON FH.ORGID = O.ORGID
                WHERE O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID
        if @@ERROR != 0
        begin
                raiserror 51902 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6
        SET     COL_1 = S.SUM_COL_1,
                COL_2 = S.SUM_COL_2,
                COL_3 = S.SUM_COL_3,
                COL_4 = S.SUM_COL_4,
                COL_5 = S.SUM_COL_5,
                COL_6 = S.SUM_COL_6,
                COL_7 = S.SUM_COL_7,
                COL_8 = S.SUM_COL_8,
                COL_9 = S.SUM_COL_9,
                COL_10 = S.SUM_COL_10,
                COL_11 = S.SUM_COL_11,
                COL_12 = S.SUM_COL_12,
                COL_13 = S.SUM_COL_13,
                COL_14 = S.SUM_COL_14,
                COL_15 = S.SUM_COL_15
        FROM (
                SELECT F.CPROF_ID,
                Sum(COL_1) As SUM_COL_1,
                Sum(COL_2) As SUM_COL_2,
                Sum(COL_3) As SUM_COL_3,
                Sum(COL_4) As SUM_COL_4,
                Sum(COL_5) As SUM_COL_5,
                Sum(COL_6) As SUM_COL_6,
                Sum(COL_7) As SUM_COL_7,
                Sum(COL_8) As SUM_COL_8,
                Sum(COL_9) As SUM_COL_9,
                Sum(COL_10) As SUM_COL_10,
                Sum(COL_11) As SUM_COL_11,
                Sum(COL_12) As SUM_COL_12,
                Sum(COL_13) As SUM_COL_13,
                Sum(COL_14) As SUM_COL_14,
                Sum(COL_15) As SUM_COL_15
                FROM FORM6 F JOIN FORM6HDR FH ON F.F6_ID = FH.F6_ID
                WHERE FH.F6_SHIFR = @F6_SHIFR
                AND (FH.SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
                GROUP BY F.CPROF_ID
                ) S
        WHERE FORM6.F6_ID = @F6_ID
        AND FORM6.CPROF_ID = S.CPROF_ID

        if @@ERROR != 0
        begin
                raiserror 51905 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.F6COUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As F6COUNT
                FROM FORM6HDR FH
                JOIN v_ORG_06 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51906 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     KUO_COUNT = S.KUOCOUNT
        FROM (
                SELECT
                Count(FH.F6_ID) As KUOCOUNT
                FROM FORM6HDR FH
                JOIN v_ORG_06 O ON FH.ORGID = O.ORGID
                WHERE O.HAS_BRON!=1
                AND O.ORGID IN (SELECT ORGID from [dbo].[#ORGSET])
                AND O.ORGID IN (SELECT ORGID FROM v_ORG_CALC)
                and EXISTS(SELECT * FROM FORM6
                                     WHERE FORM6.F6_ID=FH.F6_ID
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
                ) S
        WHERE FORM6HDR.F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51907 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     F6_COUNT = S.SUM_F6_COUNT,
                KUO_COUNT = S.SUM_KUO_COUNT
        FROM (
                SELECT
                Sum(F6_COUNT) As SUM_F6_COUNT,
                Sum(KUO_COUNT) As SUM_KUO_COUNT
                FROM FORM6HDR
                WHERE F6_SHIFR = @F6_SHIFR
                AND (SUBJ_ID IN (SELECT SubjId FROM [dbo].[#SubjSet]) OR SUBJ_ID = @SUBJ_ID)
        ) S
        WHERE F6_ID = @F6_ID
        if @@ERROR != 0
        begin
                raiserror 51908 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     RAB_COUNT = S.COL_1,
                ZAP_COUNT = S.COL_2,
                ZAB_COUNT = S.COL_6
        FROM FORM6 S
        WHERE S.F6_ID = FORM6HDR.F6_ID
        AND     S.CPROF_ID = 1000
        if @@ERROR != 0
        begin
                raiserror 51909 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
        UPDATE FORM6HDR
        SET     ORGNAME = SUBJ_FULLNAME,
                CHECKED = 0
        FROM SUBJ
        WHERE FORM6HDR.F6_ID = @F6_ID
        AND FORM6HDR.SUBJ_ID = SUBJ.SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 51910 'Невозможно сформировать агрегированную форму ј 6.06.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION


GO


Alter PROCEDURE [dbo].[sp_FFS2010Generate]
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
                , CITY = case when 
                		(SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '40' and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),1,2) <> '45' and
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '7' or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '850' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '898') or
                        (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) >= '950' and
                                SUBSTRING(ISNULL(OO.KODOKTMO,0),3,3) <= '998'))) 
                        
                                	then 1 else 0 end
                , TOWN = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or 

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '1' then 1 else 0 end
                , VILLAGE = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
                        SUBSTRING(ISNULL(OO.KODOKTMO,0),6,1) = '4' then 1 else 0 end
                , TOWNVILLAGE = case when (SUBSTRING(ISNULL(OO.KODOKTMO,0),3,1) = '6' or

                        (SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '40' and 
                        	SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> '45' and 
					    (SUBSTRING(ISNULL(KODOKTMO,0),3,1) = '6' or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '811' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '849') or 
						    (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= '911' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= '949')  )) 

                		) and
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
                                       AND FORM6.COL_B=5
                                       --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                       )
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


Alter PROCEDURE [dbo].[sp_FAnalizCreate]
        @SUBJ_ID        int
AS
SET NOCOUNT ON
BEGIN TRANSACTION
        DELETE FROM FAnaliz
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50200 'Невозможно создать форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end
        INSERT INTO FAnaliz(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, CProf_Id
        From KCProf
        WHERE CPROF_ID in (100,200,300,400,410,1000)
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end
COMMIT TRANSACTION
GO


Alter PROCEDURE [dbo].[sp_FAnalizGenerate]
--declare
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
--set        @SUBJ_ID        = 2
--set        @IS_FULL        = 1
--set        @FilterType     = 1
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)


DECLARE @KODTERR VarChar(20)

SELECT @KODTERR = dbo.GetSubjMask(KTERR.KODTERR)
  FROM SUBJ, KTERR
 WHERE SUBJ.TERR_ID=KTERR.TERR_ID and Subj.Subj_Id = @Subj_Id


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


        DELETE FROM FAnaliz
        WHERE SUBJ_ID = @SUBJ_ID
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end
        
        INSERT INTO FAnaliz(SUBJ_ID, NUM)
        SELECT @SUBJ_ID, CProf_Id
        From KCProf
        WHERE CPROF_ID in (100,200,300,400,410,1000)

        

Update FAnaliz set
	N01 = IsNull(x.N01,0) + IsNull(y.Col_1, 0), 
	N02 = IsNull(x.N02,0) + IsNull(y.Col_2, 0), 
	N06 = IsNull(x.N06,0) + IsNull(y.Col_6, 0), 
	N10 = IsNull(x.N10,0) + IsNull(y.Col_10, 0), 
	N12 = IsNull(x.N12,0) + IsNull(y.Col_12, 0)
from FAnaliz F
left join (
	select Num, Sum(N01) N01, Sum(N02) N02, Sum(N06) N06, Sum(N10) N10, Sum(N12) N12
	from FAnaliz FF
    join SUBJ s on ff.SUBJ_ID = s.SUBJ_ID and s.Subj_Id <> @Subj_Id AND 
	   s.Subj_Id IN (SELECT ss.SubjId FROM [dbo].[#SubjSET] ss)
    --join KTERR t on s.TERR_ID = t.TERR_ID and t.KODTERR LIKE @KODTERR --child and not self
	where s.Subj_Agg_Id = 2
    group by Num
) x on x.Num = F.Num
left join (
	select CProf_Id Num, Sum(Col_1) Col_1, Sum(Col_2) Col_2, Sum(Col_6) Col_6, Sum(Col_10) Col_10, Sum(Col_12) Col_12
	
	  FROM ORG oo
	     join SUBJ s on oo.TERR_ID = s.TERR_ID
	     join FORM6HDR h on h.ORGID = oo.ORGID
	     join Form6 f on f.f6_id = h.f6_id

		WHERE f.CPROF_ID in (100,200,300,400,410,1000)
		and h.ORGID IN (SELECT ORGID FROM [dbo].[#ORGSET])
	   and s.Subj_Agg_Id = 1
	   AND oo.OUT_DATE IS NULL
	   AND oo.HAs_Bron = 1
    group by CProf_Id
) y on y.Num = F.Num
Where F.Subj_Id = @Subj_Id
        if @@ERROR != 0
        begin
                raiserror 50300 'Невозможно создать форму по анализу обеспеченности.'
                ROLLBACK TRANSACTION
                return
        end


Update FAnaliz set
	N01 = SN01, 
	N02 = SN02, 
	N06 = SN06, 
	N10 = SN10, 
	N12 = SN12
from FAnaliz F
left join (select Sum(ff.N01) SN01, Sum(ff.N02) SN02, Sum(ff.N06) SN06, Sum(ff.N10) SN10, Sum(ff.N12) SN12
 from FAnaliz ff where FF.Subj_Id = @Subj_Id and FF.Num in (100,200,300,400)) x on 1=1
Where F.Subj_Id = @Subj_Id and F.Num = 1000


drop table [dbo].[#OrgSet] 

drop table [dbo].[#SubjSet]

COMMIT TRANSACTION

--select * from FAnaliz


GO

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
					  o.kopf_changed, o.Email, o.okved_changed, o.SBM
FROM         ORG O LEFT JOIN
                      KTERR ON O.TERR_ID = KTERR.TERR_ID LEFT JOIN
                      KFS ON O.FS_ID = KFS.FS_ID LEFT JOIN
                      KOPF ON O.KOPF_ID = KOPF.KOPF_ID LEFT JOIN
                      VV5 ON O.SBM_ID = VV5.ID LEFT JOIN
                      FORM6HDR ON O.ORGID = FORM6HDR.ORGID LEFT JOIN
                      ORG_CONT HEAD ON O.ORGID = HEAD.ORGID and HEAD.IS_GEN = 1 LEFT JOIN
                      ORG_CONT VUR ON O.ORGID = VUR.ORGID and VUR.IS_VUS = 1

GO


Alter Table dbo.FOKVED2010 Add 
  R int, S int, T int, U int

go


ALTER    PROCEDURE [dbo].[sp_FOKVED2010Generate]
        @SUBJ_ID        int,
        @IS_FULL        bit,
        @FilterType     int
AS
SET NOCOUNT ON
BEGIN TRANSACTION

  create table [dbo].[#OrgSet] (OrgId int)

  create table [dbo].[#SubjSet] (SubjId int)

  create table [dbo].[#temp] (SUBJ_ID int, OKVED_SECTION char(1),
        ORG_COUNT int, ORGB_COUNT int, RAB_COUNT int, ZAP_COUNT int, ZAB_COUNT int
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
        , [ORGB_COUNT]
        , [RAB_COUNT]
        , [ZAP_COUNT]
        , [ZAB_COUNT])
        SELECT @SUBJ_ID, K.OKVED_SECTION,
          NULLIF(COUNT(O.ORGID),0) AS ORG_COUNT,
          NULLIF(SUM(case when O.HAS_BRON = 1 then 1 else 0 end),0) AS ORGB_COUNT,
          NULLIF(SUM(O.RAB_COUNT),0) AS RAB_COUNT,
          NULLIF(SUM(O.ZAP_COUNT),0) AS ZAP_COUNT,
          NULLIF(SUM(O.ZAB_COUNT),0) AS ZAB_COUNT
          FROM KOKVED_ K LEFT OUTER JOIN
               (select
                  OO.ORGID
                , OO.RAB_COUNT as RAB_COUNT
                , OO.ZAP_COUNT as ZAP_COUNT
                , OO.ZAB_COUNT as ZAB_COUNT
                , OO.HAS_BRON
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
                                               AND FORM6.COL_B=5
                                               --AND ISNULL(FORM6.COL_2,0)+ISNULL(FORM6.COL_15,0)>0
                                               )
               ) O ON (O.OKVED_FIRST BETWEEN K.OKVED_BEGIN AND K.OKVED_END)
        GROUP BY K.OKVED_SECTION

        if @@ERROR != 0
        begin
                raiserror 50301 'Невозможно создать форму по видам экономической деятельности.'
                ROLLBACK TRANSACTION
                return
        end

insert into FOKVED2010 (SUBJ_ID, NUM, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U)
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
  Q = (select ORG_COUNT from #temp where OKVED_SECTION = 'Q'),
  R = (select ORG_COUNT from #temp where OKVED_SECTION = 'R'),
  S = (select ORG_COUNT from #temp where OKVED_SECTION = 'S'),
  T = (select ORG_COUNT from #temp where OKVED_SECTION = 'T'),
  U = (select ORG_COUNT from #temp where OKVED_SECTION = 'U')
union all
select SUBJ_ID = @SUBJ_ID, NUM = 15,
  A = (select ORGB_COUNT from #temp where OKVED_SECTION = 'A'),
  B = (select ORGB_COUNT from #temp where OKVED_SECTION = 'B'),
  C = (select ORGB_COUNT from #temp where OKVED_SECTION = 'C'),
  D = (select ORGB_COUNT from #temp where OKVED_SECTION = 'D'),
  E = (select ORGB_COUNT from #temp where OKVED_SECTION = 'E'),
  F = (select ORGB_COUNT from #temp where OKVED_SECTION = 'F'),
  G = (select ORGB_COUNT from #temp where OKVED_SECTION = 'G'),
  H = (select ORGB_COUNT from #temp where OKVED_SECTION = 'H'),
  I = (select ORGB_COUNT from #temp where OKVED_SECTION = 'I'),
  J = (select ORGB_COUNT from #temp where OKVED_SECTION = 'J'),
  K = (select ORGB_COUNT from #temp where OKVED_SECTION = 'K'),
  L = (select ORGB_COUNT from #temp where OKVED_SECTION = 'L'),
  M = (select ORGB_COUNT from #temp where OKVED_SECTION = 'M'),
  N = (select ORGB_COUNT from #temp where OKVED_SECTION = 'N'),
  O = (select ORGB_COUNT from #temp where OKVED_SECTION = 'O'),
  P = (select ORGB_COUNT from #temp where OKVED_SECTION = 'P'),
  Q = (select ORGB_COUNT from #temp where OKVED_SECTION = 'Q'),
  R = (select ORGB_COUNT from #temp where OKVED_SECTION = 'R'),
  S = (select ORGB_COUNT from #temp where OKVED_SECTION = 'S'),
  T = (select ORGB_COUNT from #temp where OKVED_SECTION = 'T'),
  U = (select ORGB_COUNT from #temp where OKVED_SECTION = 'U')
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
  (select RAB_COUNT from #temp where OKVED_SECTION = 'Q'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'R'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'S'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'T'),
  (select RAB_COUNT from #temp where OKVED_SECTION = 'U')
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
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'Q'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'R'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'S'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'T'),
  (select ZAP_COUNT from #temp where OKVED_SECTION = 'U')
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
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'Q'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'R'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'S'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'T'),
  (select ZAB_COUNT from #temp where OKVED_SECTION = 'U')

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
                Q = S.SUM_Q,
                R = S.SUM_R,
                S = S.SUM_S,
                T = S.SUM_T,
                U = S.SUM_U
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
        NULLIF(SUM(P),0) AS SUM_P,
        NULLIF(SUM(Q),0) AS SUM_Q,
        NULLIF(SUM(R),0) AS SUM_R,
        NULLIF(SUM(S),0) AS SUM_S,
        NULLIF(SUM(T),0) AS SUM_T,
        NULLIF(SUM(U),0) AS SUM_U
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

go


ALTER VIEW [dbo].[KOKVED_] AS
      SELECT N = ASCII(OKVED_SECTION)-ASCII('A')+1, * FROM KOKVED
UNION SELECT (SELECT COUNT(*)+1 FROM KOKVED), '_','Прочее',0,0

go


Update KOKVED Set Okved_Begin = 1, Okved_End = 3, Okved_Section_Name = 'Сельское, лесное хозяйство, охота, рыболовство и рыбоводство'
Where Okved_Section = 'A';
Update KOKVED Set Okved_Begin = 5, Okved_End = 9, Okved_Section_Name = 'Добыча полезных ископаемых'
Where Okved_Section = 'B';
Update KOKVED Set Okved_Begin = 10, Okved_End = 33, Okved_Section_Name = 'Обрабатывающие производства'
Where Okved_Section = 'C';
Update KOKVED Set Okved_Begin = 35, Okved_End = 35, Okved_Section_Name = 'Обеспечение электроэнергией, газом и паром;  кондиц-ие воздуха'
Where Okved_Section = 'D';
Update KOKVED Set Okved_Begin = 36, Okved_End = 39, Okved_Section_Name = 'Водоснабжение; водоотведение, организация сбора и утилизации отходов, деятельность по ликвидации загрязнений'
Where Okved_Section = 'E';
Update KOKVED Set Okved_Begin = 41, Okved_End = 43, Okved_Section_Name = 'Строительство'
Where Okved_Section = 'F';
Update KOKVED Set Okved_Begin = 45, Okved_End = 47, Okved_Section_Name = 'Торговля оптовая и розничная; ремонт автотранспортных средств и мотоциклов'
Where Okved_Section = 'G';
Update KOKVED Set Okved_Begin = 49, Okved_End = 53, Okved_Section_Name = 'Транспортировка и хранение'
Where Okved_Section = 'H';
Update KOKVED Set Okved_Begin = 55, Okved_End = 56, Okved_Section_Name = 'Деятельность гостиниц и предприятий общественного питания'
Where Okved_Section = 'I';
Update KOKVED Set Okved_Begin = 58, Okved_End = 63, Okved_Section_Name = 'Деятельность в области информации и связи'
Where Okved_Section = 'J';
Update KOKVED Set Okved_Begin = 64, Okved_End = 66, Okved_Section_Name = 'Деятельность финансовая и страховая'
Where Okved_Section = 'K';
Update KOKVED Set Okved_Begin = 68, Okved_End = 68, Okved_Section_Name = 'Деятельность по операциям с недвижимым имуществом'
Where Okved_Section = 'L';
Update KOKVED Set Okved_Begin = 69, Okved_End = 75, Okved_Section_Name = 'Деятельность профессиональная, научная и техническая'
Where Okved_Section = 'M';
Update KOKVED Set Okved_Begin = 77, Okved_End = 82, Okved_Section_Name = 'Деятельность административная и сопутствующие дополнительные  услуги'
Where Okved_Section = 'N';
Update KOKVED Set Okved_Begin = 84, Okved_End = 84, Okved_Section_Name = 'Государственное управление и обеспечение военной безопасности; социальное обеспечение'
Where Okved_Section = 'O';
Update KOKVED Set Okved_Begin = 85, Okved_End = 85, Okved_Section_Name = 'Образование'
Where Okved_Section = 'P';
Update KOKVED Set Okved_Begin = 86, Okved_End = 88, Okved_Section_Name = 'Деятельность в области здравоохранения и социальных услуг'
Where Okved_Section = 'Q';

Insert Into KOKVED (Okved_Section, Okved_Begin, Okved_End, Okved_Section_Name) Values (
	'R', 90, 93, 'Деятельность в области культуры, спорта, организации досуга и развлечений');
Insert Into KOKVED (Okved_Section, Okved_Begin, Okved_End, Okved_Section_Name) Values (
	'S', 94, 96, 'Предоставление прочих видов услуг');
Insert Into KOKVED (Okved_Section, Okved_Begin, Okved_End, Okved_Section_Name) Values (
	'T', 97, 98, 'Деятельность домашних хозяйств как работодателей; недифференцированная деятельность частных домашних хозяйств по производству товаров и оказанию услуг для собственного потребления');
Insert Into KOKVED (Okved_Section, Okved_Begin, Okved_End, Okved_Section_Name) Values (
	'U', 99, 99, 'Деятельность экстерриториальных организаций и органов');

go


Alter PROCEDURE [dbo].[CHECK_ALL]
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
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0) + 
        IsNull(R, 0) + IsNull(S, 0) + IsNull(T, 0) + IsNull(U, 0))
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
where f6.CPROF_ID = 1000 and f6h.F6_SHIFR in ('01', '04') and f6h.SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0) + 
        IsNull(R, 0) + IsNull(S, 0) + IsNull(T, 0) + IsNull(U, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 20

  if @DIFF != 0
        set @error = @error + 'Количество "Всего работающих" в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select @DIFF =
(IsNull((select Sum(IsNull(f6.COL_2, 0))
from form6 f6
join form6hdr f6h on f6h.F6_ID = f6.F6_ID
where f6.CPROF_ID = 1000 and f6h.F6_SHIFR in ('01', '04') and f6h.SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0) + 
        IsNull(R, 0) + IsNull(S, 0) + IsNull(T, 0) + IsNull(U, 0))
from FOKVED2010
where SUBJ_ID = @SUBJ_ID and NUM = 30

  if @DIFF != 0
        set @error = @error + 'Количество "Всего ГПЗ" в форме 6 и по видам экономической деятельности для ' + @SUBJ_NAME + ' не совпадает. Расхождение: ' + convert(varchar(50), abs(@DIFF)) + char(10) + char(13) + char(10) + char(13)

select @DIFF =
(IsNull((select Sum(IsNull(f6.COL_6, 0))
from form6 f6
join form6hdr f6h on f6h.F6_ID = f6.F6_ID
where f6.CPROF_ID = 1000 and f6h.F6_SHIFR in ('01', '04') and f6h.SUBJ_ID = @SUBJ_ID), 0)) -
(IsNull(A, 0) + IsNull(B, 0) + IsNull(C, 0) + IsNull(D, 0) + IsNull(E, 0) + IsNull(F, 0) +
        IsNull(G, 0) + IsNull(H, 0) + IsNull(I, 0) + IsNull(J, 0) + IsNull(K, 0) + IsNull(L, 0) +
        IsNull(M, 0) + IsNull(N, 0) + IsNull(O, 0) + IsNull(P, 0) + IsNull(Q, 0) + 
        IsNull(R, 0) + IsNull(S, 0) + IsNull(T, 0) + IsNull(U, 0))
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

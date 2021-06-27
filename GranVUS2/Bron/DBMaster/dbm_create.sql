CREATE TABLE [dbo].[#KEYWRD] (
	[KOD_KEY] [varchar] (10) NULL ,
	[KEYWRD] [varchar] (50) NULL 
)

CREATE TABLE [dbo].[#CFS] (
	[NAME] [varchar] (100) NULL ,
	[KFS_] [varchar] (2) NULL 
)

CREATE TABLE [dbo].[#CONH] (
	[NAME] [varchar] (150) NULL ,
	[KODF_] [varchar] (5) NULL ,
	[KODT_] [varchar] (5) NULL ,
	[KODONH] [varchar] (3) NULL 
)

CREATE TABLE [dbo].[#CONT] (
	[POLE_1] [smallint] NULL ,
	[POLE_2] [smallint] NULL ,
	[POLE_3] [varchar] (65) NULL ,
	[POLE_4] [varchar] (180) NULL ,
	[POLE_5] [varchar] (30) NULL ,
	[POLE_6] [varchar] (75) NULL ,
	[POLE_7] [varchar] (80) NULL ,
	[POLE_8] [smallint] NULL ,
	[POLE_9] [bit] NOT NULL ,
	[POLE_10] [varchar] (40) NULL ,
	[POLE_11] [varchar] (40) NULL 
)

CREATE TABLE [dbo].[#COPF] (
	[NAME] [varchar] (100) NULL ,
	[KOPF_] [varchar] (2) NULL 
)

CREATE TABLE [dbo].[#CTY] (
	[NAME] [varchar] (20) NULL ,
	[KODTY] [varchar] (11) NULL 
)

CREATE TABLE [dbo].[#DBIN] (
	[RREG] [varchar] (6) NULL ,
	[DB_NAME] [varchar] (40) NULL ,
	[IND_NAME] [varchar] (40) NULL ,
	[KEY] [varchar] (150) NULL ,
	[NAME] [varchar] (60) NULL ,
	[USR_FUNC] [varchar] (60) NULL 
)

CREATE TABLE [dbo].[#FILES] (
	[POLE_1] [varchar] (8) NULL ,
	[POLE_2] [varchar] (125) NULL ,
	[POLE_3] [varchar] (10) NULL ,
	[POLE_4] [varchar] (2) NULL 
)

CREATE TABLE [dbo].[#F_MENU] (
	[KOD_M] [varchar] (10) NULL ,
	[NUM_OPT] [varchar] (2) NULL ,
	[NAM_OPT] [varchar] (80) NULL ,
	[KOD_F] [varchar] (10) NULL ,
	[TYP_MN] [varchar] (2) NULL ,
	[EXECUTE] [varchar] (250) NULL 
)

CREATE TABLE [dbo].[#HLP] (
	[HCOD] [varchar] (10) NULL ,
	[HTXT] [varchar] (80) NULL 
)

CREATE TABLE [dbo].[#KEYFUN] (
	[KOD_TBL] [smallint] NULL ,
	[KOD_KEY] [smallint] NULL ,
	[US_FUN] [varchar] (40) NULL 
)

CREATE TABLE [dbo].[#ORG] (
	[ORGID] [int] NOT NULL IDENTITY(1000000, 1) ,
	[OKPO] [varchar] (8) NULL ,
	[SOATO_] [varchar] (11) NULL ,
	[SOOGU_] [varchar] (5) NULL ,
	[OKONH_] [varchar] (5) NULL ,
	[KFS_] [varchar] (2) NULL ,
	[KOPF_] [varchar] (2) NULL ,
	[KODONH] [varchar] (3) NULL ,
	[NAME] [varchar] (254) NULL ,
	[PIND] [varchar] (6) NULL ,
	[ADR] [varchar] (150) NULL ,
	[TFON] [varchar] (20) NULL ,
	[DIREC] [varchar] (50) NULL ,
	[BUH] [varchar] (12) NULL ,
	[VUS_FIO] [varchar] (50) NULL ,
	[VUS_TEL] [varchar] (20) NULL ,
	[RESH_NOM] [varchar] (10) NULL ,
	[RESH_DAT] [datetime] NULL ,
	[PERE_NOM] [varchar] (10) NULL ,
	[FL_RAB] [bit] NOT NULL ,
	[FL_BR] [bit] NOT NULL ,
	[DR] [datetime] NULL ,
	[NR] [varchar] (20) NULL ,
	[VD] [varchar] (150) NULL ,
	[D_LAST] [datetime] NULL ,
	[FL_F6] [bit] NOT NULL ,
	[OKPO_] [varchar] (10) NULL ,
	[F_ADR] [varchar] (150) NULL ,
	[SER_NUM] [varchar] (14) NULL ,
	[P_ADR] [varchar] (150) NULL ,
	[R_ADR] [varchar] (60) NULL ,
	[V_NAME] [varchar] (100) NULL ,
	[INN] [varchar] (10) NULL ,
	[D_FIRST] [datetime] NULL ,
	[COMMENTS] [varchar] (200) NULL ,
	[OUT] [varchar] (60) NULL ,
	[D_OUT] [datetime] NULL ,
	[SV_D] [varchar] (2) NULL ,
	[OKONHS_] [varchar] (60) NULL 
)

CREATE TABLE [dbo].[#OSN] (
	[OKPO] [varchar] (10) NULL ,
	[KOD1] [varchar] (2) NULL ,
	[KOD2] [varchar] (2) NULL ,
	[NUMB] [varchar] (15) NULL ,
	[DD] [datetime] NULL 
)

CREATE TABLE [dbo].[#OSVTY] (
	[SOATO_] [varchar] (11) NULL ,
	[KOD_SPEC] [varchar] (3) NULL ,
	[V1] [float] NULL ,
	[V2] [float] NULL ,
	[V3] [float] NULL ,
	[V4] [float] NULL ,
	[V5] [float] NULL ,
	[V6] [float] NULL ,
	[B7] [float] NULL ,
	[B8] [float] NULL ,
	[B9] [float] NULL ,
	[B10] [float] NULL ,
	[B11] [float] NULL ,
	[B12] [float] NULL ,
	[B13] [float] NULL ,
	[B14] [float] NULL ,
	[B15] [float] NULL ,
	[B16] [float] NOT NULL ,
	[DATE_] [datetime] NULL 
)

CREATE TABLE [dbo].[#O_S_V] (
	[OKPO] [varchar] (10) NULL ,
	[KOD_SPEC] [varchar] (3) NULL ,
	[V1] [float] NULL ,
	[V2] [float] NULL ,
	[V3] [float] NULL ,
	[V4] [float] NULL ,
	[V5] [float] NULL ,
	[V6] [float] NULL ,
	[B7] [float] NULL ,
	[B8] [float] NULL ,
	[B9] [float] NULL ,
	[B10] [float] NULL ,
	[B11] [float] NULL ,
	[B12] [float] NULL ,
	[B13] [float] NULL ,
	[B14] [float] NULL ,
	[B15] [float] NULL ,
	[B16] [float] NULL 
)

CREATE TABLE [dbo].[#PER] (
	[OKPO] [varchar] (10) NULL ,
	[KOD2] [varchar] (2) NULL ,
	[NUMB_D] [varchar] (15) NULL ,
	[DD_D] [datetime] NULL ,
	[DD_END] [datetime] NULL ,
	[NUMB_P] [varchar] (10) NULL ,
	[RAZD_P] [varchar] (10) NULL 
)

CREATE TABLE [dbo].[#PROTF] (
	[KOD_TYPE] [varchar] (1) NULL ,
	[EXT] [varchar] (3) NULL ,
	[PATH] [varchar] (100) NULL 
)

CREATE TABLE [dbo].[#Q_CONT] (
	[Q_NUMB] [varchar] (3) NULL ,
	[Q_SIGN] [varchar] (1) NULL ,
	[Q_PARAM] [varchar] (3) NULL ,
	[Q_TYPE] [varchar] (1) NULL ,
	[Q_PNAME] [varchar] (50) NULL ,
	[Q_BSEEK] [varchar] (8) NULL ,
	[Q_FSEEK] [varchar] (250) NULL ,
	[Q_KEY] [varchar] (30) NULL ,
	[Q_LOOK] [varchar] (60) NULL ,
	[Q_X] [smallint] NULL ,
	[Q_Y] [smallint] NULL ,
	[Q_CLR] [varchar] (15) NULL ,
	[Q_CONNECT] [smallint] NULL 
)

CREATE TABLE [dbo].[#Q_TABL] (
	[Q_NUMB] [varchar] (3) NULL ,
	[Q_SIGN] [varchar] (1) NULL ,
	[Q_BASES] [varchar] (250) NULL ,
	[Q_X] [smallint] NULL ,
	[Q_Y] [smallint] NULL ,
	[Q_XX] [smallint] NULL ,
	[Q_YY] [smallint] NULL ,
	[Q_CLR] [varchar] (15) NULL ,
	[Q_CHEAD] [varchar] (40) NULL ,
	[Q_BOTTOM] [varchar] (70) NULL ,
	[Q_PHEAD] [varchar] (250) NULL ,
	[Q_ROWS] [smallint] NULL ,
	[Q_COLS] [smallint] NULL 
)

CREATE TABLE [dbo].[#SPEC] (
	[KOD] [varchar] (3) NULL ,
	[SPEC] [varchar] (30) NULL ,
	[SPEC1] [varchar] (60) NULL ,
	[FORMULA] [varchar] (80) NULL ,
	[CPROF_ID] [int] NULL
)

CREATE TABLE [dbo].[#SUB] (
	[KOD] [varchar] (2) NULL ,
	[NAME] [varchar] (100) NULL ,
	[ADR] [varchar] (100) NULL ,
	[FIO1] [varchar] (50) NULL ,
	[TEL1] [varchar] (30) NULL ,
	[FIO2] [varchar] (50) NULL ,
	[TEL2] [varchar] (30) NULL 
)

CREATE TABLE [dbo].[#SUBK] (
	[KOD] [varchar] (2) NULL ,
	[HOW] [float] NULL 
)

CREATE TABLE [dbo].[#TABLE] (
	[POLE_1] [smallint] NULL ,
	[POLE_2] [varchar] (80) NULL ,
	[POLE_3] [smallint] NULL ,
	[POLE_4] [smallint] NULL ,
	[POLE_5] [smallint] NULL ,
	[POLE_6] [smallint] NULL ,
	[POLE_7] [bit] NOT NULL ,
	[POLE_8] [varchar] (15) NULL ,
	[POLE_9] [smallint] NULL ,
	[POLE_10] [varchar] (20) NULL ,
	[POLE_11] [smallint] NULL ,
	[POLE_12] [varchar] (200) NULL ,
	[POLE_13] [varchar] (3) NULL ,
	[POLE_14] [smallint] NULL ,
	[POLE_15] [varchar] (40) NULL ,
	[POLE_16] [varchar] (40) NULL 
)

CREATE TABLE [dbo].[#T_LINK] (
	[POLE_1] [smallint] NULL ,
	[POLE_2] [smallint] NULL ,
	[POLE_3] [varchar] (100) NULL ,
	[POLE_4] [bit] NOT NULL ,
	[POLE_0] [smallint] NULL 
)

CREATE TABLE [dbo].[#USERS] (
	[NAME] [varchar] (20) NULL ,
	[PASSWORD] [varchar] (8) NULL ,
	[CATEGORY] [varchar] (1) NULL ,
	[EXTEN] [varchar] (3) NULL 
)

CREATE TABLE [dbo].[#VV1] (
	[KOD] [varchar] (2) NULL ,
	[NAME] [varchar] (60) NULL ,
	[NAME1] [varchar] (60) NULL 
)

CREATE TABLE [dbo].[#VV2] (
	[KOD] [varchar] (2) NULL ,
	[NAME] [varchar] (45) NULL 
)

CREATE TABLE [dbo].[#VV3] (
	[KOD] [varchar] (2) NULL ,
	[NAME] [varchar] (30) NULL 
)

CREATE TABLE [dbo].[#VV4] (
	[KOD] [varchar] (2) NULL ,
	[NAME] [varchar] (25) NULL 
)

CREATE TABLE [dbo].[#VV5] (
	[KOD] [varchar] (2) NULL ,
	[NAME] [varchar] (40) NULL 
)

CREATE TABLE [dbo].[#VV6] (
	[KOD] [float] NULL ,
	[NAME] [varchar] (60) NULL ,
	[NAME1] [varchar] (60) NULL 
)

CREATE TABLE [dbo].[#V_TYPE] (
	[KOD] [varchar] (1) NULL ,
	[NAME] [varchar] (47) NULL 
)

CREATE TABLE [dbo].[#V_US] (
	[KOD] [varchar] (1) NULL ,
	[NAME] [varchar] (40) NULL ,
	[RIGHTS] [smallint] NULL 
)

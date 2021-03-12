unit fFltMgr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, dxCntner, dxTL, ImgList, dxTLClms, StdCtrls, FrmKeep, dxTLClEx,
  ComCtrls, dxEditor, dxExEdtr, dxEdLib, ADOdb;

type
  TFilterForm = (ffPersons, ffPersChanges);

  TfmFltMgr = class(TForm)
    dxtParams: TdxTreeList;
    ImageList1: TImageList;
    dxtParamsColumn1: TdxTreeListColumn;
    btnSaveFlt: TButton;
    btnOpenFlt: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    pnlEditStr: TPanel;
    chkStrEnable: TCheckBox;
    Label1: TLabel;
    cbStrType: TComboBox;
    Label2: TLabel;
    edStrValue: TEdit;
    pnlEditDate: TPanel;
    chkDateEnable: TCheckBox;
    rbDateNotNull: TRadioButton;
    rbDateNull: TRadioButton;
    rbDateFromTo: TRadioButton;
    chkDateFrom: TCheckBox;
    chkDateTo: TCheckBox;
    dtDateFrom: TdxDateEdit;
    dtDateTo: TdxDateEdit;
    pnlEditList: TPanel;
    lvList: TListView;
    chkListEnable: TCheckBox;
    chkListNULL: TCheckBox;
    pnlEditInt: TPanel;
    chkIntEnable: TCheckBox;
    rbIntNotNull: TRadioButton;
    rbIntNull: TRadioButton;
    rbIntFromTo: TRadioButton;
    chkIntFrom: TCheckBox;
    edIntFrom: TdxEdit;
    edIntTo: TdxEdit;
    chkIntTo: TCheckBox;
    pnlEditBool: TPanel;
    chkBoolEnable: TCheckBox;
    rbBoolYes: TRadioButton;
    rbBoolNo: TRadioButton;
    pnlEditSet: TPanel;
    chkSetEnable: TCheckBox;
    chkSetNULL: TCheckBox;
    mmSetValue: TMemo;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    btnClear: TButton;
    dxtParamsValueColumn: TdxTreeListButtonColumn;
    pnlEditOk: TPanel;
    Bevel1: TBevel;
    btnEditOk: TButton;
    btnEditCancel: TButton;
    chkNewWindow: TCheckBox;
    FrmKeep1: TFrmKeep;
    pnlEditBoolnDate: TPanel;
    chkBoolnDate: TCheckBox;
    rbBoolnDateYes: TRadioButton;
    rbBoolnDateNo: TRadioButton;
    dtBoolnDateFrom: TdxDateEdit;
    dtBoolnDateTo: TdxDateEdit;
    Label3: TLabel;
    Label4: TLabel;
    pnlEditAspirant: TPanel;
    chkAspirantEnable: TCheckBox;
    rbAspirantYes: TRadioButton;
    rbAspirantNo: TRadioButton;
    rbAspirantNull: TRadioButton;
    rbAspirantNotNull: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure dxtParamsChangeNode(Sender: TObject; OldNode,
      Node: TdxTreeListNode);
    procedure chkStrEnableClick(Sender: TObject);
    procedure cbStrTypeChange(Sender: TObject);
    procedure dxtParamsValueColumnPopup(Sender: TObject;
      const EditText: String);
    procedure chkDateEnableClick(Sender: TObject);
    procedure rbDateNotNullClick(Sender: TObject);
    procedure chkDateFromClick(Sender: TObject);
    procedure chkDateToClick(Sender: TObject);
    procedure dtDateFromChange(Sender: TObject);
    procedure dxtParamsValueColumnCloseUp(Sender: TObject;
      var Text: String; var Accept: Boolean);
    procedure lvListResize(Sender: TObject);
    procedure lvListDblClick(Sender: TObject);
    procedure chkListEnableClick(Sender: TObject);
    procedure edIntFromKeyPress(Sender: TObject; var Key: Char);
    procedure chkIntEnableClick(Sender: TObject);
    procedure rbIntNotNullClick(Sender: TObject);
    procedure chkIntFromClick(Sender: TObject);
    procedure chkIntToClick(Sender: TObject);
    procedure chkBoolEnableClick(Sender: TObject);
    procedure chkAspirantEnableClick(Sender: TObject);
    procedure mmSetValueKeyPress(Sender: TObject; var Key: Char);
    procedure chkSetEnableClick(Sender: TObject);
    procedure edStrValueKeyPress(Sender: TObject; var Key: Char);
    procedure btnSaveFltClick(Sender: TObject);
    procedure btnOpenFltClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure dxtParamsValueColumnEditButtonClick(Sender: TObject);
    procedure chkBoolnDateClick(Sender: TObject);
    procedure lvListColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private declarations }
    FSQL: TStringList;
    sflds: String;
    FTempFile: string;
    FNewForm: TForm;
    FForm: TFilterForm;
    procedure SetDateValue;
    procedure SetListDateValue(Table: string);
    procedure FLoadFilter(AFileName: string);
    procedure FSaveFilter(AFileName: string);
    function GetPanel: TPanel;
  public
    { Public declarations }
    SortedColumn: Integer;
    Descending: Boolean;
    procedure AssignParams;
  end;


  function GetSQLText(out ANewForm: TForm; form: TFilterForm; var ASQL, AFlds: string; TempFile: string = ''): boolean;


implementation

uses dMain, msg, Rdialogs, fPersLst, fPersChangesLst, IniSupport, DateUtils, BirthDay, fMain;

{$R *.DFM}

type
 TFilterForms = set of TFilterForm;
 TFilterType = (ptString,ptDate,ptInteger,ptList,ptSet,ptBoolean,ptBoolnDate,ptAspirant,ptListString,ptListDate);
 TFilterRec = record
   FldName: string;
   FldNameSQL: string;
   FldType: TFilterType;
   DispName: string;
   DispGroup: string;
   Form: TFilterForms;
   ListSQL: string;
   InnerTable: string;
   SetIsString: boolean;
   FldAlias: String;
 end;

var
  AFilterArray : Array[0..147] of TFilterRec = (
//Общие
{$REGION 'COMMON'}
    (FldName:'FAM';        FldType: ptString;  DispName: 'Фамилия'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]),
    (FldName:'IM';         FldType: ptString;  DispName: 'Имя'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]),
    (FldName:'OTCH';       FldType: ptString;  DispName: 'Отчество'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]),
    (FldName:'MALE'; FldType: ptBoolean; DispName: 'Пол мужской'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]),
    (FldName:'BIRTHDAY';   FldType: ptDate;    DispName: 'Дата рождения'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]),
    (FldName:'BIRTHPLACE'; FldType: ptString;  DispName: 'Место рождения'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]),
    (FldName:'NAT_ID';     FldType:ptList;     DispName: 'Гражданство'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges];
       ListSQL: 'select NAT_ID as [ID], NAT_NAME as [Наименование_70], OKIN as [ОКИН_30] from KNATION order by 3'),
    (FldName:'LANG_ID';    FldType:ptList;     DispName: 'Иностранные языки'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges];
       ListSQL: 'select LANG_ID as [ID], LANG_NAME as [Наименование_70], OKIN as [ОКИН_30] from KLANG order by 3'; InnerTable: 'LANGS'),
    (FldName:'[Person].FST_ID';     FldType:ptList;     DispName: 'Семейное положение'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges];
       ListSQL: 'select FST_ID as [ID], FST_NAME as [Наименование_70], OKIN as [ОКИН_30] from KFSTATE order by 3'),
    (FldName:'ADDR0';   FldType: ptString;  DispName: 'Адрес по регистрации'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]; InnerTable: '(SELECT PERS_ID, ADDR_STR as ADDR0 FROM ADDR WHERE ADDR_TYPE = 0)'),
    (FldName:'ADDR_END0';  FldType: ptDate;    DispName: 'Дата завершения регистрации'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]; InnerTable: '(SELECT PERS_ID, ADDR_DATE_END as ADDR_END0 FROM ADDR WHERE ADDR_TYPE = 0)'),
    (FldName:'ADDR1';   FldType: ptString;  DispName: 'Адрес фактический'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]   ; InnerTable: '(SELECT PERS_ID, ADDR_STR as ADDR1 FROM ADDR WHERE ADDR_TYPE = 1)'),
    (FldName:'PHONE2';   FldType: ptString;  DispName: 'Телефон домашний'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]; InnerTable: '(SELECT PERS_ID, PH_NUMBER as PHONE2 FROM PHONES WHERE PH_TYPE = 2)'),
    (FldName:'PHONE3';   FldType: ptString;  DispName: 'Телефон мобильный'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]; InnerTable: '(SELECT PERS_ID, PH_NUMBER as PHONE3 FROM PHONES WHERE PH_TYPE = 3)'),
    (FldName:'Comments';   FldType: ptString;  DispName: 'Дополнительные сведения'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]),
    (FldName:'CONFDATE';   FldType: ptDate;    DispName: 'Дата изменения'; DispGroup: 'Общие'; Form: [ffPersons]),
    (FldName:'INN';   FldType: ptString;  DispName: 'ИНН'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]),
    (FldName:'STRAH';   FldType: ptString;  DispName: 'СНИЛС'; DispGroup: 'Общие'; Form: [ffPersons, ffPersChanges]),
{$ENDREGION 'COMMON'}
//Образование
{$REGION 'EDU'}
    (FldName:'[Person].ED_ID';      FldType:ptList;     DispName: 'Вид образования'; DispGroup: 'Образование'; Form: [ffPersons];
       ListSQL: 'select ED_ID as [ID], ED_NAME as [Наименование_70], OKIN as [ОКИН_30] from KEDUC order by 3'),
    (FldName:'UZ_ID';      FldType:ptList;     DispName: 'Учебное заведение'; DispGroup: 'Образование'; Form: [ffPersons];
       ListSQL: 'select UZ_ID as [ID], UZ_NAME as [Наименование_100] from KUZ order by 2';
       InnerTable: '(Select p.Pers_Id, EDUC.UZ_ID From Person p Left Join EDUC on (p.Pers_Id = Educ.Pers_Id and EDUC.Type <> 4) Where EDUC.UZ_ID > 0)'),
    (FldName:'KVAL_ID';       FldType: ptList;  DispName: 'Квалификация/Ученая степень'; DispGroup: 'Образование'; Form: [ffPersons];
       ListSQL: 'select KVAL_ID as [ID], KVAL_NAME as [Наименование_100] from KKVAL order by 2';
       InnerTable: '(Select p.Pers_Id, EDUC.KVAL_ID From (Person p Inner Join EDUC on (p.Pers_Id = Educ.Pers_Id and EDUC.Type <> 4)) Where EDUC.KVAL_ID > 0)'),
    (FldName:'NAPR_ID';       FldType: ptList;  DispName: 'Специальность'; DispGroup: 'Образование'; Form: [ffPersons];
       ListSQL: 'select NAPR_ID as [ID], NAPR_NAME as [Наименование_100] from KNAPR order by 2';
       InnerTable: '(Select p.Pers_Id, EDUC.NAPR_ID From (Person p Inner Join EDUC on (p.Pers_Id = Educ.Pers_Id and EDUC.Type <> 4)) Where EDUC.NAPR_ID > 0)'),
    (FldName:'END_DATE_DATE'; FldType: ptDate; DispName: 'Дата окончания'; DispGroup: 'Образование'; Form: [ffPersons]),
    (FldName:'(PROF1&'' ''&PROF2)'; FldType: ptString; DispName: 'Профессия'; DispGroup: 'Образование'; Form: [ffPersons];
       FldAlias: 'PROF1'),
//    (FldName:'SC_ID'; FldType:ptList; DispName: 'Ученая степень'; DispGroup: 'Образование'; Form: [ffPersons];
//       ListSQL: 'select SC_ID as [ID], SC_NAME as [Наименование_70], OKIN as [ОКИН_30] from KSCIENCE order by 3'),
{$ENDREGION 'EDU'}
//Воинский учет
{$REGION 'VU'}
    (FldName:'[KPOST].CPROF2015_ID';
                            FldType:ptList;     DispName: 'Категория должности'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
       ListSQL: 'select CPROF_ID as [ID], CPROF_NAME as [Наименование_100] from KCPROF2015 where STATE = 0 order by 1';
       FldAlias: 'CPROF_ID'),
    (FldName:'[KPOST].CPROF_ID';
                            FldType:ptList;     DispName: 'Категория должности до 2015 г.'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
       ListSQL: 'select CPROF_ID as [ID], CPROF_NAME as [Наименование_100] from KCPROF where STATE = 0 order by 1';
       FldAlias: 'CPROF_ID'),
    (FldName:'CSOST';       FldType: ptList;    DispName: 'Категория состава'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
       ListSQL: 'SELECT 0 as ID, ''нет'' as [Наименование_100] from org union all SELECT 1, ''летно-подъемный''  from org union all SELECT 2, ''плавающий''  from org'),
    (FldName:'iif((IS_WAR <> 1) or (not (W_DEND is null) and W_DEND < Date()) , 0, 1)';
     FldType: ptBoolean; DispName: 'Военнообязанный'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
       FldAlias: 'IS_WAR'),

    (FldName:'VAL(''0''&NUMB_T2)';
                            FldType: ptString;  DispName: 'Номер Т-2'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
       FldAlias: 'NUMB_T2'),
    (FldName:'W_DBEG';      FldType: ptDate;    DispName: 'Дата постановки'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'Document';    FldType: ptList;    DispName: 'Вид воинского документа'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
       ListSQL: 'SELECT 0 as ID, ''Военный билет'' as [Наименование_100] from org '+
        'union all SELECT 1, ''Временное удостоверение''  from org '+
        'union all SELECT 2, ''Приписное свидетельство''  from org '+
        'union all SELECT 3, ''Справка взамен военного билета (справка уклониста)''  from org'),
    (FldName:'WBser';       FldType: ptString;  DispName: 'Воинский документ, серия'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'WBnum';       FldType: ptString;  DispName: 'Воинский документ, номер'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'WBDate';      FldType: ptDate;    DispName: 'Дата выдачи воинского документа'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'WID';         FldType: ptString;  DispName: 'Личный номер'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'iif((EOARMY_DATE is null), null, '+
               'iif(Len(EOARMY_DATE)=4, cdate(''1.1.''+EOARMY_DATE), '+
                 'iif(Len(EOARMY_DATE)=10, cdate(EOARMY_DATE), null)))';
        FldType: ptDate;    DispName: 'Дата увольнения из армии'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
       FldAlias: 'EOARMY_DATE'),
    (FldName:'[Person].WRNG_ID';
                            FldType: ptList;    DispName: 'Воинское звание'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select WRNG_ID as [ID], WRNG_NAME as [Наименование_100] from KWRANGE order by 1';
       FldAlias: 'WRNG_ID'),
    (FldName:'[Person].WSOST_ID';    FldType: ptList;    DispName: 'Состав (профиль)'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select WSOST_ID as [ID], WSOST_NAME as [Наименование_100] from KWSOST order by 2'),
    (FldName:'WCAT';        FldType: ptString;  DispName: 'Категория годности'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'CAT_ZAP';     FldType: ptString;  DispName: 'Категория запаса'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'IIf((VUS is null),null,val(IIf((VUS is null),''0'',VUS)))'; FldType: ptString; DispName: 'Код ВУС'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
       FldAlias: 'VUS'),
    (FldName:'iif((KWrangeX.STATE >= 2 AND VUS in (select NAME from KDEFVUS)) OR (KWrangeX.STATE = 1 AND LEFT(VUS, 3) in (select NAME from KDEFVUS where Len(NAME) = 3)) , 1, 0)'; FldType: ptBoolean; DispName: 'ВУС - дефицитная'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'iif(KWrangeX.LIMIT1 is null, null, iif(#FullAges#BirthDay# <= KWrangeX.LIMIT1, 1, iif(#FullAges#BirthDay# <= KWrangeX.LIMIT2, 2, iif(#FullAges#BirthDay# <= iif(KWrangeX.LIMIT3 is null, 1000, KWrangeX.LIMIT3), 3, null))))';    FldType: ptList;    DispName: 'Возрастной разряд'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select 1 as [ID], ''1-ый возрастной разряд'' as [Наименование_30] from org union select 2, ''2-ой возрастной разряд'' from org union select 3, ''3-ий возрастной разряд'' from org'),
    (FldName:'[Person].OVK_ID';      FldType: ptList;    DispName: 'ОВК'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select OVK_ID as [ID], OVK_NAME as [Наименование_100] from KOVK order by 1'),
    (FldName:
        'iif(([PERSON].W_DEND is NULL or Year([PERSON].W_DEND) >= Year( Date())) and ( '+
        '([PERSON].MALE=1 and (KWrangeX.M_LIMIT is not NULL) and  (#FullAges#[Person].BirthDay#)>=KWrangeX.M_LIMIT  ) or '+
        '([PERSON].MALE=0 and (KWrangeX.FEM_LIMIT is not NULL) and  (#FullAges#[Person].BirthDay#)>=KWrangeX.FEM_LIMIT  ) ),1,0)';
                            FldType: ptBoolean; DispName: 'Не снятые с учета в прошлые годы'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:
        'iif(([PERSON].W_DEND is NULL or Year([PERSON].W_DEND) >= Year( Date())) and ( '+
        '([PERSON].MALE=1 and (KWrangeX.M_LIMIT is not NULL) and  ((#FullAges#[Person].BirthDay#)+1)=KWrangeX.M_LIMIT  ) or '+
        '([PERSON].MALE=0 and (KWrangeX.FEM_LIMIT is not NULL) and  ((#FullAges#[Person].BirthDay#)+1)=KWrangeX.FEM_LIMIT  ) ),1,0)';
                            FldType: ptBoolean; DispName: 'Состоит на учёте последний год'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'W_DEND';      FldType: ptDate;    DispName: 'Дата снятия с учета'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'WDISCL';      FldType: ptString;  DispName: 'Отметки о снятии с учета'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'D_OVK';       FldType: ptDate;    DispName: 'Дата сверки с ОВК'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'D_WBIL';      FldType: ptDate;    DispName: 'Дата сверки с военным билетом'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'Branch';      FldType: ptList;    DispName: 'Группа учёта'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select 0 as [ID], ''РА'' as [Наименование_5] from org '+
      'union select 1, ''ВМФ'' from org '+
      'union select 2, ''ФСБ'' from org '+
      'union select 3, ''МВД'' from org '+
      'union select 4, ''СВР'' from org '+
      'union select 5, ''Росгвардия'' from org'),
    (FldName:'Delay_ID';    FldType: ptList;    DispName: 'Отсрочка от призыва'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select ID as [ID], DelayName as [Наименование_100] from KDELAY order by 1'),
    (FldName:'DelayStart_date'; FldType: ptDate; DispName: 'Дата предоставления отсрочки'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'DelayEnd_date'; FldType: ptDate;  DispName: 'Дата окончания / переосвидетельствования'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'Health';      FldType: ptString;  DispName: 'Состояние здоровья'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'HealthDocNo';      FldType: ptString;  DispName: '№ документа о состоянии здоровья'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'HealthDoc_date'; FldType: ptDate;  DispName: 'Дата документа о состоянии здоровья'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
    (FldName:'Warfare';     FldType: ptString;  DispName: 'Участник боевых действий'; DispGroup: 'Воинский учет'; Form: [ffPersons, ffPersChanges]),
{$ENDREGION 'VU'}
//Моб. предписание
{$REGION 'MOB'}
    (FldName:'iif((WUCHET1 is null),0,1)';
                            FldType: ptBoolean; DispName: 'Имеет моб. предписание'; DispGroup: 'Моб. предписание'; Form: [ffPersons, ffPersChanges];
       FldAlias: 'WUCHET1'),
    (FldName:'WUCHET1';     FldType: ptString;  DispName: '№ команды, партии'; DispGroup: 'Моб. предписание'; Form: [ffPersons, ffPersChanges]),
    (FldName:'SpecialWUCHET1';
                            FldType: ptBoolean; DispName: 'Спецформирование'; DispGroup: 'Моб. предписание'; Form: [ffPersons, ffPersChanges]),
    (FldName:'iif(Mob_Days=0,null,Mob_Days)'; FldType: ptInteger; DispName: 'Время явки, сутки'; DispGroup: 'Моб. предписание'; Form: [ffPersons, ffPersChanges]),
    (FldName:'iif(Mob_Hours=0,null,Mob_Hours)'; FldType: ptInteger; DispName: 'Время явки, часы'; DispGroup: 'Моб. предписание'; Form: [ffPersons, ffPersChanges]),
    (FldName:'iif(Mob_Mins=0,null,Mob_Mins)'; FldType: ptInteger; DispName: 'Время явки, минуты'; DispGroup: 'Моб. предписание'; Form: [ffPersons, ffPersChanges]),
    (FldName:'Mob_CardDate'; FldType: ptDate; DispName: 'Дата вручения карточки оповещения'; DispGroup: 'Моб. предписание'; Form: [ffPersons, ffPersChanges]),
    (FldName:'Mob_MissReason'; FldType: ptString;  DispName: 'Причина отсутствия'; DispGroup: 'Моб. предписание'; Form: [ffPersons, ffPersChanges]),
{$ENDREGION 'MOB'}
//Спецучет
{$REGION 'WUchet2'}
    (FldName:'WUCHET2_Ser + WUCHET2';FldType: ptString;    DispName: 'Серия и № удостоверения'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons, ffPersChanges]; FldAlias: 'WUCHET2_Ser'),
    (FldName:'WUCHET2_date';FldType: ptDate;    DispName: 'Дата выписки удостоверения'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons, ffPersChanges]),

    (FldName: 'PDP.OKVED';
      FldType: ptString;   DispName: 'Код ОКВЭД'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons, ffPersChanges];
      FldAlias: 'PDPCode'),
    (FldName: 'PDP.KOKPDTR_Code';
      FldType: ptString;   DispName: 'Код ОКПДТР'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons, ffPersChanges];
      FldAlias: 'PDPCode'),

    (FldName:'(WUCHET2_IsWork = 1)'; FldNameSQL:'iif(WUCHET2_IsWork = 1, 1, 0)';
                            FldType: ptBoolean; DispName: 'Забронирован'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons, ffPersChanges];
       FldAlias: 'WUCHET2_IsWork'),
    (FldName:'PersonReservChkInfo.IS_BAD';
                            FldType: ptBoolean; DispName: 'Бронирование некорректно'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons];
       FldAlias: 'IS_BAD'),
    (FldName:'iif(PersonReservChkInfo.IS_BAD = 1 and PersonReservChkInfo.DefPost_Post = 0, 1, 0)';
                            FldType: ptBoolean; DispName: 'Бронирование некорректно (должность не бронируется)'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons];
       FldAlias: 'DefPost_Post'),
    (FldName:'iif(PersonReservChkInfo.IS_BAD = 1 and PersonReservChkInfo.DefPost_WRange = 0, 1, 0)';
                            FldType: ptBoolean; DispName: 'Бронирование некорректно (звание не бронируется)'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons];
       FldAlias: 'DefPost_WRange'),
    (FldName:'iif(PersonReservChkInfo.IS_BAD = 1 and PersonReservChkInfo.DefPost_WSost = 0, 1, 0)';
                            FldType: ptBoolean; DispName: 'Бронирование некорректно (профиль не бронируется)'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons];
       FldAlias: 'DefPost_WSost'),
    (FldName:'IIf(PersonReservChkInfo.IS_BAD <> 0 and PersonReservChkInfo.Reserved = 0,1,0)';
                            FldType: ptBoolean; DispName: 'Подлежат бронированию'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons]),
    (FldName:'iif(PersonReservChkInfo.IS_BAD = 1 and PersonReservChkInfo.DefPost_Age = 0, 1, 0)';
                            FldType: ptBoolean; DispName: 'По возрасту согласно выписке из ПДП не подлежит бронированию'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons];
       FldAlias: 'DefPost_Age'),
    (FldName:'XDEP_ID';      FldType:ptList;     DispName: 'Уполномоченный в подразделениях'; DispGroup: 'Специальный воинский учет'; Form: [ffPersons];
       ListSQL: 'select DEP_ID as [ID], DEP_NAME as [Наименование_100] from KDepart order by 2';
       InnerTable: '(Select p.Pers_Id, XDEP.Dep_ID as XDep_Id From Person p Inner Join Pers_Deps as XDep on (p.Pers_Id = XDep.Pers_Id))'),
{$ENDREGION 'WUchet2'}
//Назначения
{$REGION 'APPOINTMENT'}
    (FldName:'VAL(''0''&TAB_NUMB)';    FldType: ptString;  DispName: 'Табельный номер'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges];
      FldAlias: 'TAB_NUMB'),
    (FldName:'DOG_NUMB';               FldType: ptString;  DispName: 'Номер договора(соглашения)'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges]),
    (FldName:'DOG_DATE';               FldType: ptDate;    DispName: 'Дата договора(соглашения)'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges]),
    (FldName:'(NOT IS_RAB)';FldNameSQL:'(case when IS_RAB<>0 then 0 else 1 end)';FldType: ptBoolean; DispName:'Является гос. служащим'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges];
      FldAlias: 'Gos'),
    (FldName:'AppointmentLastAll.WTP_ID'; FldType: ptList;    DispName:'Вид работы'; DispGroup: 'Назначения'; Form: [ffPersons];
      ListSQL: 'select WTP_ID as [ID], WTP_NAME as [Наименование_100] from KWKTYPE where WTP_FLAG = 3 order by 2'),
    (FldName:'AppointmentLastAll.WCH_ID'; FldType: ptList;    DispName:'Характер работы'; DispGroup: 'Назначения'; Form: [ffPersons];
      ListSQL: 'select WCH_ID as [ID], WCH_NAME as [Наименование_100] from KWKCHAR order by 2'),
    (FldName:'AppointmentLastAll.POST_ID';FldType: ptList;    DispName:'Текущая должность'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'AppointmentLastAll.POST_ID'; FldAlias: 'LastPost'),
    (FldName:'YPost_Id';FldType: ptList;    DispName:'Текущая и предыдущие должности'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'AppointmentLastAll.POST_ID';
      InnerTable: '(Select Pers_Id, Post_Id as YPost_Id From Appointment)';
      FldAlias: 'AllPosts'),
    (FldName:'AppointmentLastAll.DEP_ID'; FldType: ptList;    DispName:'Подразделение'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'AppointmentLastAll.DEP_ID'),
    (FldName:'YDEP_ID'; FldType: ptList;    DispName:'Текущее и предыдущие подразделения'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'AppointmentLastAll.DEP_ID';
      InnerTable: '(Select Pers_Id, Dep_Id as YDep_Id From Appointment)';
      FldAlias: 'AllDeps'),
    (FldName:'KDepart.IS_ASF';         FldType: ptBoolean;    DispName:'Подразделение АСФ'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges];),
//    (FldName:'IIf((IN_ORD_NUMB is null),null,val(IIf((IN_ORD_NUMB is null),''0'',IN_ORD_NUMB)))'; FldType: ptSet;
//                                                           DispName: '№ приказа о приеме на работу'; DispGroup: 'Назначения'; Form: [ffPersons];  SetIsString: false),
    (FldName:'AppointmentFirst.IN_DATE'; FldType: ptDate;  DispName: 'Дата приема на работу'; DispGroup: 'Назначения'; Form: [ffPersons]),
    (FldName:'OUT_DATE';               FldType: ptDate;    DispName: 'Дата увольнения'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges]),
    (FldName:'OUT_ORD_NUMB';            FldType: ptString; DispName: '№ приказа об увольнении'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges];),
    (FldName:'OUT_ORD_DATE';           FldType: ptDate;    DispName: 'Дата приказа об увольнении'; DispGroup: 'Назначения'; Form: [ffPersons, ffPersChanges]),
    (FldName:'Assign.KAssign'; FldType: ptList;    DispName:'Разряд, чин, ранг'; DispGroup: 'Назначения'; Form: [ffPersons];
      ListSQL: 'select ID, NAME as [Наименование_100] from KAssign order by 2'),
{$ENDREGION 'APPOINTMENT'}
//Сведения об учащемся
{$REGION 'STUDENTINFO'}
    (FldName:'ISASPIRANT';                        FldType: ptAspirant; DispName: 'Аспирант или студент';                    DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'STUDYEND_DATE';                     FldType: ptDate;     DispName: 'Плановая дата окончания обучения';        DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'AppointmentLastStudy.WTP_ID';       FldType: ptList;     DispName:'Форма обучения';                           DispGroup: 'Сведения об учащемся'; Form: [ffPersons];
      ListSQL: 'select WTP_ID as [ID], WTP_NAME+iif(WTP_FLAG=2,'' (аспирант)'','''') as [Наименование_100] from KWKTYPE where WTP_FLAG <> 3 order by 2';
      FldAlias: 'LastStudy'),
    (FldName:'AppointmentLastStudy.IN_DATE';      FldType: ptDate;     DispName: 'Дата зачисления';                         DispGroup: 'Сведения об учащемся'; Form: [ffPersons];
      FldAlias: 'LastStudy'),
    (FldName:'AppointmentLastStudy.IN_ORD_NUMB';  FldType: ptString;   DispName: '№ приказа о зачислении';                  DispGroup: 'Сведения об учащемся'; Form: [ffPersons];
      FldAlias: 'LastStudy'),
    (FldName:'AppointmentLastStudy.IN_ORD_DATE';  FldType: ptDate;     DispName: 'Дата приказа о зачислении';               DispGroup: 'Сведения об учащемся'; Form: [ffPersons];
      FldAlias: 'LastStudy'),
    (FldName:'DOG_NUMB';                          FldType: ptString;   DispName: '№ договора на обучение';                  DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'DOG_DATE';                          FldType: ptDate;     DispName: 'Дата договора на обучение';               DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'ORDERAKADEM';                       FldType: ptString;   DispName: '№ приказа об уходе в АО';                 DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'ORDERAKADEM_DATE';                  FldType: ptDate;     DispName: 'Дата приказа об уходе в АО';              DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'REASONAKADEM';                      FldType: ptString;   DispName: 'Причина ухода в АО';                      DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'BEGINAKADEM_DATE';                  FldType: ptDate;     DispName: 'Дата начала АО';                          DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'ENDAKADEM_DATE';                    FldType: ptDate;     DispName: 'Дата ожидаемого выхода из АО';            DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'REALENDAKADEM_DATE';                FldType: ptDate;     DispName: 'Дата фактического выхода из АО';          DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'MEDRESULT_DATE';                    FldType: ptDate;     DispName: 'Дата прохождения медкомиссии после АО';   DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'MEDRESULT';                         FldType: ptList;     DispName: 'Результат медкомиссии';                   DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select 1 as [ID], ''Возобновление отсрочки'' as [Наименование_25] from org union select 2, ''Снятие с воинского учета'' from org'),
    (FldName:'VKSTATUS';                          FldType: ptList;     DispName: 'Статус обучения на военной кафедре';      DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select 0 as [ID], ''К обучению не приступал'' as [Наименование_40] from org union select 1, ''Обучается'' from org union select 2, ''Успешно окончил'' from org union select 3, ''Прервал обучение, расторгнул контракт'' from org'),
    (FldName:'BEGINWAR_DATE';                     FldType: ptDate;     DispName: 'Дата начала обучения на ВК';              DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'ENDWAR_DATE';                       FldType: ptDate;     DispName: 'Дата планового окончания обучения на ВК'; DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'REALENDWAR_DATE';                   FldType: ptDate;     DispName: 'Дата фактич. окончания обучения на ВК';   DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'REASONENDWAR';                      FldType: ptString;   DispName: 'Причина расторжения контракта';           DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'DISMISSAL_DATE';                    FldType: ptDate;     DispName: 'Дата отчисления из института';            DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'ORDERDISMISSAL';                    FldType: ptString;   DispName: '№ приказа об отчислении из института';    DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'ORDERDISMISSAL_DATE';               FldType: ptDate;     DispName: 'Дата приказа об отчислении из института'; DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'REASONDISMISSAL';                   FldType: ptString;   DispName: 'Причина отчисления из института';         DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'DISSERNAME';                        FldType: ptString;   DispName: 'Наименование диссертационной работы';     DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'DEGREE_ID';                         FldType: ptList;     DispName: 'Искомая ученая степень';                  DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select SC_ID as [ID], SC_NAME as [Наименование_70], SC_OKIN as [ОКИН_30] from KSCIENCE order by 3'),
    (FldName:'GUIDEDEGREE_ID';                    FldType: ptList;     DispName: 'Ученая степень научного руководителя';    DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges];
      ListSQL: 'select SC_ID as [ID], SC_NAME as [Наименование_70], SC_OKIN as [ОКИН_30] from KSCIENCE order by 3'),
    (FldName:'FIOGUIDE';                          FldType: ptString;   DispName: 'ФИО руководителя';                        DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'DEFEND_DATE';                       FldType: ptDate;     DispName: 'Защита назначена на';                     DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'REALDEFEND_DATE';                   FldType: ptDate;     DispName: 'Защита состоялась';                       DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'[Person].IsAspirant is not null) and (iif((exists(select 1 from N26History ' +
        'where #DATE# and pers_id = [Person].pers_id)),1,0)';
      FldType: ptBoolnDate; DispName: 'Получил форму № 26';       DispGroup: 'Сведения об учащемся'; Form: [ffPersons, ffPersChanges]),
    (FldName:'(Select Napr_Name From KNAPR Where KNapr.Napr_Id = EDUC.Napr_Id)';
      FldType: ptString;  DispName: 'Специальность'; DispGroup: 'Сведения об учащемся'; Form: [ffPersons];
       InnerTable: '(Select p.Pers_Id, EDUC.NAPR_ID From Person p Left Join EDUC on (p.Pers_Id = Educ.Pers_Id and EDUC.Type = 4))';
      FldAlias: 'Napr'),
    (FldName:'NAPR_ID';      FldType:ptList;     DispName: 'Код специальности'; DispGroup: 'Сведения об учащемся'; Form: [ffPersons];
       ListSQL: 'SELECT NAPR_ID as ID, NAPR_KOD+'' / ''+NAPR_NAME As [Наименование_100] FROM KNAPR ORDER BY NAPR_KOD, NAPR_NAME';
       InnerTable: '(Select p.Pers_Id, EDUC.NAPR_ID From Person p Left Join EDUC on (p.Pers_Id = Educ.Pers_Id and EDUC.Type = 4))';
      FldAlias: 'Napr'),
{$ENDREGION 'STUDENTINFO'}
//Сведения об изменениях
{$REGION 'CHANGES'}
    (FldName:'[PersonChanges].GROUP_ID';     FldType:ptList;     DispName: 'Наименование поля'; DispGroup: 'Сведения об изменениях'; Form: [ffPersChanges];
       ListSQL: 'select GROUP_ID as [ID], GROUP_NAME as [Наименование_100] from KL_FLDGROUPS order by 2';
      FldAlias: 'PersonChanges'),
    (FldName:'[PersonChanges].OLDVALUE';        FldType: ptString;  DispName: 'Старое значение'; DispGroup: 'Сведения об изменениях'; Form: [ffPersChanges];
      FldAlias: 'PersonChanges'),
    (FldName:'[PersonChanges].NEWVALUE';        FldType: ptString;  DispName: 'Новое значение'; DispGroup: 'Сведения об изменениях'; Form: [ffPersChanges];
      FldAlias: 'PersonChanges'),
    (FldName:'[PersonChanges].CHANGE_DATE';   FldType: ptDate;    DispName: 'Дата внесения изменения в БД'; DispGroup: 'Сведения об изменениях'; Form: [ffPersChanges];
      FldAlias: 'PersonChanges'),
    (FldName:'[PersonChanges].BEGIN_DATE';   FldType: ptDate;    DispName: 'Дата вручения листка работнику'; DispGroup: 'Сведения об изменениях'; Form: [ffPersChanges];
      FldAlias: 'PersonChanges'),
    (FldName:'[PersonChanges].NOTBEGINREASON';        FldType: ptString;  DispName: 'Другая информация (причина невручения, дата отправки почтой и др.)'; DispGroup: 'Сведения об изменениях'; Form: [ffPersChanges];
      FldAlias: 'PersonChanges'),
    (FldName:'[PersonChanges].END_DATE';   FldType: ptDate;    DispName: 'Дата доставки листка в ОВК'; DispGroup: 'Сведения об изменениях'; Form: [ffPersChanges];
      FldAlias: 'PersonChanges'),
    (FldName:'[PersonChanges].SEND_DATE';   FldType: ptDate;    DispName: 'Дата отправки сведений в ОВК'; DispGroup: 'Сведения об изменениях'; Form: [ffPersChanges];
      FldAlias: 'PersonChanges'),
    (FldName:'BEGIN_DATE';   FldType: ptDate;    DispName: 'Дата вручения листка работнику'; DispGroup: 'Сведения об изменениях'; Form: [ffPersons]; InnerTable: 'PersonChanges';
      FldAlias: 'PersonChanges'),
    (FldName:'NOTBEGINREASON'; FldType: ptString;  DispName: 'Другая информация (причина невручения, дата отправки почтой и др.)'; DispGroup: 'Сведения об изменениях'; Form: [ffPersons]; InnerTable: 'PersonChanges';
      FldAlias: 'PersonChanges'),
    (FldName:'END_DATE';   FldType: ptDate;    DispName: 'Дата доставки листка в ОВК'; DispGroup: 'Сведения об изменениях'; Form: [ffPersons]; InnerTable: 'PersonChanges';
      FldAlias: 'PersonChanges'),
{$ENDREGION 'CHANGES'}
//Аварийно-спасательные формирования
{$REGION 'ASF'}
    (FldName:'ASOrder_In';             FldType: ptString;  DispName: 'Номер приказа о зачислении'; DispGroup: 'НАСФ (АСФ)'; Form: [ffPersons]),
    (FldName:'ASDate_In';              FldType: ptDate;    DispName: 'Дата приказа о зачислении'; DispGroup: 'НАСФ (АСФ)'; Form: [ffPersons]),
    (FldName:'ASAppointmentLastAll.ASPOST_ID';FldType: ptList;    DispName:'Текущая должность'; DispGroup: 'НАСФ (АСФ)'; Form: [ffPersons];
      ListSQL: 'ASAppointmentLastAll.ASPOST_ID'; FldAlias: 'ASPost_Name'),
    (FldName:'ASAppointmentLastAll.ASFX_ID'; FldType: ptList;    DispName:'Формирование'; DispGroup: 'НАСФ (АСФ)'; Form: [ffPersons];
      ListSQL:
        'select ASF_ID As [ID], iif(ASF.ORGSName='''',ASF.ORGName, ASF.ORGSName) as [Наименование_100] from ASF '+
        'order by 2';
      FldAlias: 'ASFName'),
    (FldName:'ASAppointmentLastAll.ASP_ID'; FldType: ptList;    DispName:'Подразделение'; DispGroup: 'НАСФ (АСФ)'; Form: [ffPersons];
      ListSQL: 'ASAppointmentLastAll.ASP_ID'; FldAlias: 'ASDep_Name'),
    (FldName:'ASAppointmentFirst.IN_DATE'; FldType: ptDate;  DispName: 'Дата зачисления в НАСФ'; DispGroup: 'НАСФ (АСФ)'; Form: [ffPersons];
      FldAlias: 'ASIn_Date'),
    (FldName:'ASOUT_DATE';               FldType: ptDate;    DispName: 'Дата выхода из НАСФ'; DispGroup: 'НАСФ (АСФ)'; Form: [ffPersons]),
    (FldName:'ASOUT_ORD_NUMB';           FldType: ptString;  DispName: '№ приказа о выходе из НАСФ'; DispGroup: 'НАСФ (АСФ)'; Form: [ffPersons]),
    (FldName:'ASOUT_ORD_DATE';           FldType: ptDate;    DispName: 'Дата приказа о выходе из НАСФ'; DispGroup: 'НАСФ (АСФ)'; Form: [ffPersons])
{$ENDREGION 'ASF'}
   );

function GetSQLText(out ANewForm: TForm; form: TFilterForm; var ASQL, AFlds: string; TempFile: string = ''): boolean;
begin
   with TfmFltMgr.Create(Application) do
   try
     FTempFile := TempFile;
     FForm := form;
     AssignParams;
     FSQL.Text := ASQL;
     Result := ShowModal=mrOk;
     if Result then begin
        ASQL := FSQL.Text;
        AFlds := sflds;
     end;
     ANewForm := FNewForm;
   finally Free;
   end;
end;

procedure TfmFltMgr.FormCreate(Sender: TObject);
var
  i: Integer;
  rec: TFilterRec;
begin
  for i:= Low(AFilterArray) to High(AFilterArray) do begin
    rec := AFilterArray[i];
    if rec.ListSQL = 'AppointmentLastAll.POST_ID' then begin
      rec.ListSQL :=
        'select POST_ID as [ID], POST_NAME+iif(is_old,'' (упразднено)'','''') as [Наименование_100], KOKPDTR.KOKPDTR_Code as [ОКПДТР_60] '+
        'from KPOST left join KOKPDTR on KOKPDTR.KOKPDTR_Id = KPOST.KOKPDTR '+
        'order by '+iifStr(dmMain.isAbcSort,'Post_Name', 'KPOST_Num');
      AFilterArray[i] := rec;
    end;
    if rec.ListSQL = 'AppointmentLastAll.DEP_ID' then begin
      rec.ListSQL := 'select DEP_ID as [ID], DEP_NAME+iif(is_old,'' (упразднено)'','''') as [Наименование_100] from KDEPART order by '+iifStr(dmMain.isAbcSort, 'Dep_Name', 'KDEPART_Num');
      AFilterArray[i] := rec;
    end;
    if rec.ListSQL = 'AppointmentLastAll.ASP_ID'then begin
      rec.FldName := IsJet('AppointmentLastAll.','')+'ASP_ID';
      rec.ListSQL :=
        'select ASP_ID as [ID], iif(ASF.ORGSName='''',ASF.ORGName, ASF.ORGSName)+''/''+DEP_NAME as [Наименование_100], ASP_Num as AspNum from ASP '+
        'inner join ASF On ASF.ASF_Id = ASP.ASF_Id '+
        'order by iif(ASF.ORGSName='''',ASF.ORGName, ASF.ORGSName), '+iifStr(dmMain.isAbcSort, 'ASP.Name', 'ASP_Num');
      AFilterArray[i] := rec;
    end;
    if rec.ListSQL = 'AppointmentLastAll.ASPOST_ID' then begin
      rec.FldName := IsJet('AppointmentLastAll.','')+'ASPOST_ID';
      rec.ListSQL := 'select ASPOST_ID as [ID], POST_NAME as [Наименование_100] from ASPOST '+
        'order by '+iifStr(dmMain.isAbcSort,'Post_Name', 'ASPOST_Num');
    end;
  end;
  chkNewWindow.Checked := GetFltrNeWnd;
  FSQL := TStringList.Create;
  FSQL.Clear;
end;

procedure TfmFltMgr.FormDestroy(Sender: TObject);
begin
  SetFltrNeWnd(chkNewWindow.Checked);
  FSQL.Free;
end;

procedure TfmFltMgr.AssignParams;
var i,j: Integer;
    dxt: TdxTreeListNode;
begin
  dxtParams.ClearNodes;
  for i:= Low(AFilterArray) to High(AFilterArray) do begin
  if FForm in AFilterArray[i].Form then begin
    dxt := nil;
    for j:=0 to dxtParams.Count-1 do
    if dxtParams.Items[j].Values[0]=AFilterArray[i].DispGroup then begin
      dxt := dxtParams.Items[j];
      break;
    end;
    if dxt=nil then begin
      dxt := dxtParams.Add;
      dxt.Values[0] := AFilterArray[i].DispGroup;
      dxt.ImageIndex := 0;
      dxt.SelectedIndex := 0;
    end;
    with dxt.AddChild do begin
      Values[0] := AFilterArray[i].DispName;
      Values[1] := EmptyStr;
      Data := Pointer(i);
      ImageIndex := 1;
      SelectedIndex := 1;
    end;
  end;
  end;
  if FileExists(FTempFile) then FLoadFilter(FTempFile);
end;

procedure TfmFltMgr.btnOkClick(Sender: TObject);
var i,j, ii: Integer;
    s, s0,ss, sFld: string;
begin
  sflds := '';
  for i:=0 to dxtParams.Count-1 do
  for j:=0 to dxtParams.Items[i].Count-1 do
  with dxtParams.Items[i].Items[j] do
  if (ImageIndex=2) and (Values[1]<>EmptyStr) then begin
    s := Values[1];
    s0 := s;
    ii := Integer(dxtParams.Items[i].Items[j].Data);
    sFld := AFilterArray[ii].FldName;
    if (not dmMain.isJet) and (AFilterArray[ii].FldNameSQL <> '') then
      sFld := AFilterArray[ii].FldNameSQL;
    ss := AFilterArray[ii].FldAlias;
    if ss = '' then ss := sFld;
    sflds := sflds + ss + ';';
    if AFilterArray[ii].FldType=ptSet then
      if AFilterArray[ii].SetIsString=false then
        s := StringReplace(s,'''','',[rfReplaceAll]);
    if (AFilterArray[ii].FldType=ptString) and (s0 = '(value) IS NULL') then
      s := sFld + ' & "" = ""'
    else if (AFilterArray[ii].FldType=ptString) and (s0 = '(value) IS NOT NULL') then
      s := sFld + ' & "" <> ""'
    else
      s := StringReplace(s,'(value)',sFld,[rfReplaceAll]);
    if not dmMain.isJet then begin
      s := StringReplace(s,'DateValue(','dbo.DateValue(',[rfReplaceAll]);
      s := StringReplace(s,' Date()',' GetDate()',[rfReplaceAll]);
    end;
    while Pos('{', s) > 0 do Delete(s, Pos('{', s), Pos('}', s) - Pos('{', s) + 1);
    s := StringReplace(s, '#DATE#', 'CREATE_DATE >= ' + Date2SQL(dtBoolnDateFrom.Date) +
                       ' and CREATE_DATE <= ' + Date2SQL(dtBoolnDateTo.Date), [rfReplaceAll]);
    ss := AFilterArray[ii].InnerTable;
    if ss<>EmptyStr then begin
      if (AFilterArray[ii].FldType=ptList) and (s0 = '(value) IS NULL') then
        s := 'NOT Exists (SELECT PERS_ID FROM '+ss+' Where Pers_Id = [Person].PERS_ID)'
      else
        s := '[Person].PERS_ID IN (SELECT PERS_ID FROM '+ss+' WHERE '+s+')';
    end;
    FSQL.Add('AND ('+s+')');
  end;
  FSQL.Text := ReplaceFullAges(FSQL.Text, dmMain.isJet);
  if chkNewWindow.Checked then begin
    ModalResult := mrCancel;
    if FForm = ffPersons then begin
      Application.CreateForm(TfmPersonList, FNewForm);
      if fmMain.MainScale <> 100 then
        FNewForm.ScaleBy(fmMain.MainScale, 100);
      with FNewForm as TfmPersonList do begin
        SetFiltr(FSQL.Text, sflds);
        Self.FTempFile := FTempFile;
      end;
    end
    else if FForm = ffPersChanges then begin
      Application.CreateForm(TfmPersonChangesList, FNewForm);
      if fmMain.MainScale <> 100 then
        FNewForm.ScaleBy(fmMain.MainScale, 100);
      with FNewForm as TfmPersonChangesList do begin
        SetFiltr(FSQL.Text);
        Self.FTempFile := FTempFile;
      end;
    end;
  end;
  if FTempFile<>EmptyStr then FSaveFilter(FTempFile);
end;

procedure TfmFltMgr.dxtParamsChangeNode(Sender: TObject; OldNode,
  Node: TdxTreeListNode);
begin
  dxtParamsValueColumn.DisableEditor := Node.HasChildren;
  dxtParamsValueColumn.Buttons[0].Visible := not Node.HasChildren;
end;

procedure TfmFltMgr.dxtParamsValueColumnPopup(Sender: TObject;
  const EditText: String);
var n,k: Integer;
    s,s1,s2: string;
begin
//apply item settings
  case AFilterArray[Integer(dxtParams.FocusedNode.Data)].FldType of
    ptString,ptListString: begin
    //parse string text
      chkStrEnable.Checked := dxtParams.FocusedNode.ImageIndex=2;
      if Pos('LIKE'        ,EditText)=9 then cbStrType.ItemIndex:=0      else
      if Pos('NOT LIKE'    ,EditText)=9 then cbStrType.ItemIndex:=1      else
      if Pos('LEFT('       ,EditText)=1 then cbStrType.ItemIndex:=2      else
      if Pos('RIGHT('      ,EditText)=1 then cbStrType.ItemIndex:=3      else
      if Pos('='           ,EditText)=9 then cbStrType.ItemIndex:=4      else
      if Pos('<>'          ,EditText)=9 then cbStrType.ItemIndex:=5      else
      if Pos('IS NOT NULL' ,EditText)=9 then cbStrType.ItemIndex:=6      else
      if Pos('IS NULL'     ,EditText)=9 then cbStrType.ItemIndex:=7      else
        cbStrType.ItemIndex:=0;
      n := Pos('''',EditText);
      if n=0 then s := EmptyStr
      else begin
        s := Copy(EditText,n+1,1000);
        n := Pos('''',s);
        if n=0 then n := 1000;
        s := Copy(s,1,n-1);
        if s<>EmptyStr then
          if s[1]='%' then s := Copy(s,2,Length(s)-2);
      end;
      edStrValue.Text := s;
      chkStrEnable.OnClick(nil);
    end;
    ptDate,ptListDate: begin
    //parse date text
      chkDateEnable.Checked := dxtParams.FocusedNode.ImageIndex=2;
      if Pos('IS NOT NULL',EditText)=9 then        rbDateNotNull.Checked := true
      else
      if Pos('IS NULL',EditText)=9 then            rbDateNull.Checked := true
      else begin
        rbDateFromTo.Checked := true;
        n := Pos('>=',EditText);
        if n>0 then begin
          chkDateFrom.Checked := true;
          while EditText[n]<>'#' do Inc(n);
          Inc(n);
          s := EmptyStr;
          while EditText[n]<>'#' do begin
            s := s + EditText[n];
            Inc(n);
            if n>Length(EditText) then break;
          end;
          try
            dtDateFrom.Date := SQL2Date('#'+s+'#');
          except
          end;
        end
        else
          chkDateFrom.Checked := false;
        n := Pos('<=',EditText);
        if n>0 then begin
          chkDateTo.Checked := true;
          while EditText[n]<>'#' do Inc(n);
          Inc(n);
          s := EmptyStr;
          while EditText[n]<>'#' do begin
            s := s + EditText[n];
            Inc(n);
            if n>Length(EditText) then break;
          end;
          try
            dtDateTo.Date := SQL2Date('#'+s+'#');
          except
          end;
        end
        else
          chkDateTo.Checked := false;
      end;
      chkDateEnable.OnClick(nil);
    end;
    ptList: begin
      chkListEnable.Checked := dxtParams.FocusedNode.ImageIndex=2;
    //load list and parse data
      if Pos('IS NULL',EditText)<>0 then chkListNULL.Checked := true;
      with TADOQuery.Create(Self) do
        try
          lvList.Items.BeginUpdate;
          lvList.Items.Clear;
          lvList.Columns.Clear;
          Connection := dmMain.dbMain;
          SQL.Text := AFilterArray[Integer(dxtParams.FocusedNode.Data)].ListSQL;
          Open;
          for n:=0 to Fields.Count-1 do begin
            if Fields[n].FieldName='ID' then continue;
            s := Fields[n].FieldName;
            k := Pos('_',s);
            if k > 0 then with lvList.Columns.Add do begin
              Caption := Copy(s,1,k-1);
              Tag := StrToInt(Copy(s,k+1,1000));
            end;
          end;
          s := StringReplace(EditText,'(',',',[rfReplaceAll]);
          s := StringReplace(s,')',',',[rfReplaceAll]);
          while not EOF do begin
            with lvList.Items.Add do
              for n:=0 to Fields.Count-1 do
                if Fields[n].FieldName='ID' then begin
                  Data := Pointer(Fields[n].AsInteger);
                  Checked := Pos(','+Fields[n].AsString+',',s)>0;
                end
                else
                  if Caption=EmptyStr then
                    Caption := Fields[n].AsString
                  else
                    SubItems.Add(Fields[n].AsString);
            Next;
          end;
        finally
          lvList.Items.EndUpdate;
          lvList.Width := lvList.Width - 10;
          Free;
        end;
    end;
    ptInteger: begin
      chkIntEnable.Checked := dxtParams.FocusedNode.ImageIndex=2;
      if Pos('IS NOT NULL',EditText)=9 then
        rbIntNotNull.Checked := true
      else
      if Pos('IS NULL',EditText)=9 then
        rbIntNull.Checked := true
      else begin
        rbIntFromTo.Checked := true;
        edIntFrom.Text := EmptyStr;
        n := Pos('>=',EditText);
        if n>0 then begin
          chkIntFrom.Checked := true;
          Inc(n,3);
          while EditText[n] in ['0'..'9','-'] do begin
            edIntFrom.Text := edIntFrom.Text + EditText[n];
            Inc(n);
            if n>Length(EditText) then break;
          end;
        end
        else chkIntFrom.Checked := false;
        edIntTo.Text := EmptyStr;
        n := Pos('<=',EditText);
        if n>0 then begin
          chkIntTo.Checked := true;
          Inc(n,3);
          while EditText[n] in ['0'..'9','-'] do begin
            edIntTo.Text := edIntTo.Text + EditText[n];
            Inc(n);
            if n>Length(EditText) then break;
          end;
        end
        else chkIntTo.Checked := false;
      end;
      rbIntFromTo.OnClick(nil);
    end;
    ptBoolean: begin
      chkBoolEnable.Checked := dxtParams.FocusedNode.ImageIndex=2;
      rbBoolYes.Checked := Pos('<>',EditText)>0;
      rbBoolNo.Checked := not rbBoolYes.Checked;
      chkBoolEnable.OnClick(nil);
    end;
    ptAspirant: begin
      chkAspirantEnable.Checked := dxtParams.FocusedNode.ImageIndex=2;
      if Pos('IS NOT NULL',EditText) = 9 then rbAspirantNotNull.Checked := True
      else if Pos('IS NULL',EditText) = 9 then rbAspirantNull.Checked := True
      else if Pos('<>',EditText) > 0 then rbAspirantYes.Checked := True
      else rbAspirantNo.Checked := True;
    end;
    ptBoolnDate: begin
      chkBoolnDate.Checked := dxtParams.FocusedNode.ImageIndex=2;
      rbBoolnDateYes.Checked := Pos('<>',EditText)>0;
      rbBoolnDateNo.Checked := not rbBoolnDateYes.Checked;
      chkBoolnDate.OnClick(nil);
      n := Pos('>=',EditText);
      if n>0 then begin
        while EditText[n]<>'#' do Inc(n);
        Inc(n);
        s := EmptyStr;
        while EditText[n]<>'#' do begin
          s := s + EditText[n];
          Inc(n);
          if n>Length(EditText) then break;
        end;
        try
          dtBoolnDateFrom.Date := SQL2Date('#'+s+'#');
        except
        end;
      end
      else begin
        if MonthOf(Date) >= 9 then
          dtBoolnDateFrom.Date := EncodeDateTime(YearOf(Date), 9, 1, 0, 0, 0, 0)
        else
          dtBoolnDateFrom.Date := EncodeDateTime(YearOf(IncYear(Date, -1)), 9, 1, 0, 0, 0, 0)
      end;
      n := Pos('<=',EditText);
      if n>0 then begin
        while EditText[n]<>'#' do Inc(n);
        Inc(n);
        s := EmptyStr;
        while EditText[n]<>'#' do begin
          s := s + EditText[n];
          Inc(n);
          if n>Length(EditText) then break;
        end;
        try
          dtBoolnDateTo.Date := SQL2Date('#'+s+'#');
        except
        end;
      end
      else begin
        if MonthOf(Date) >= 9 then
          dtBoolnDateTo.Date := EncodeDateTime(YearOf(IncYear(Date, 1)), 8, 31, 0, 0, 0, 0)
        else
          dtBoolnDateTo.Date := EncodeDateTime(YearOf(Date), 8, 31, 0, 0, 0, 0)
      end;
    end;
    ptSet: begin
      chkSetEnable.Checked := dxtParams.FocusedNode.ImageIndex=2;
      chkSetEnable.OnClick(nil);
      s := EditText;
      if Pos('IS NULL',s)>0 then begin
        s := Copy(s,18,10000);
        chkSetNull.Checked := true;
      end;
      mmSetValue.Text := EmptyStr;
      while Pos('AND',s)>0 do begin
        n := 0;
        s1 := EmptyStr;
        while s[n]<>'''' do Inc(n);
        Inc(n);
        while s[n]<>'''' do begin
          s1 := s1 + s[n];
          Inc(n);
        end;
        Inc(n);
        s2 := EmptyStr;
        while s[n]<>'''' do Inc(n);
        Inc(n);
        while s[n]<>'''' do begin
          s2 := s2 + s[n];
          Inc(n);
        end;
        Inc(n);
        if mmSetValue.Text=EmptyStr then
          mmSetValue.Text := s1+'-'+s2
        else
          mmSetValue.Text := mmSetValue.Text+', '+s1+'-'+s2;
        s := Copy(s,n,10000);
      end;
      n := Pos('IN',s);
      if n>0 then
        while n<=Length(s) do begin
          while n<=Length(s) do
            if s[n]='''' then break
            else Inc(n);
          s1 := EmptyStr;
          Inc(n);
          while n<=Length(s) do
            if s[n]='''' then break
            else begin
              s1 := s1 + s[n];
              Inc(n);
            end;
          Inc(n);
          if s1<>EmptyStr then
            if mmSetValue.Text=EmptyStr then
              mmSetValue.Text := s1
            else
              mmSetValue.Text := mmSetValue.Text + ', '+s1;
        end;
    end;
//  else
//    dxtParamsValueColumn.PopupControl := nil;
  end;
end;

procedure TfmFltMgr.dxtParamsValueColumnCloseUp(Sender: TObject;
  var Text: String; var Accept: Boolean);
var i: Integer;
    s,s_in,ss: string;
begin
  s := '';
  case AFilterArray[Integer(dxtParams.FocusedNode.Data)].FldType of
    ptString,ptListString: begin
      if not chkStrEnable.Checked then s:='' else begin
      if AFilterArray[Integer(dxtParams.FocusedNode.Data)].FldType = ptString then s := EmptyStr
      else s := 'exists(select 1 from ' + AFilterArray[Integer(dxtParams.FocusedNode.Data)].InnerTable + ' where ';
      case cbStrType.ItemIndex of
        0: s := s + '(value) LIKE ''%'+edStrValue.Text+'%''';
        1: s := s + '(value) NOT LIKE ''%'+edStrValue.Text+'%''';
        2: s := s + 'LEFT((value),'+IntToStr(Length(edStrValue.Text))+') = '''+edStrValue.Text+'''';
        3: s := s + 'RIGHT((value),'+IntToStr(Length(edStrValue.Text))+') = '''+edStrValue.Text+'''';
        4: s := s + '(value) = '''+edStrValue.Text+'''';
        5: s := s + '(value) <> '''+edStrValue.Text+'''';
        6: s := s + '(value) IS NOT NULL';
        7: s := s + '(value) IS NULL';
      else
        s := EmptyStr;
      end;
      end;
      if (s <> EmptyStr) and (AFilterArray[Integer(dxtParams.FocusedNode.Data)].FldType = ptListString) then
        s := s + ')';
      dxtParams.FocusedNode.Values[1] := s;
    end;
    ptDate,ptListDate: begin
      if not chkdateEnable.Checked then begin
        s:='';
        dxtParams.FocusedNode.Values[1] := s;
      end else begin
        dtDateFrom.ValidateEdit;
        dtDateTo.ValidateEdit;
        if AFilterArray[Integer(dxtParams.FocusedNode.Data)].FldType = ptDate then SetDateValue
        else SetListDateValue(AFilterArray[Integer(dxtParams.FocusedNode.Data)].InnerTable);
      end;
    end;
    ptList: begin
      if not chkListEnable.Checked then s:='' else begin
        if chkListNULL.Checked then s := '(value) IS NULL' else s := EmptyStr;
        with TStringList.Create do
        try
          for i:=0 to lvList.Items.Count-1 do
          if lvList.Items[i].Checked then
            Add(IntToStr(Integer(lvList.Items[i].Data)));
          if (s<>EmptyStr) and (Count>0) then s := s + ' OR ';
          if Count>0 then  s := s + '(value) IN ('+CommaText+')';
        finally  Free
        end;
      end;
      dxtParams.FocusedNode.Values[1] := s;
    end;
    ptInteger: begin
      if not chkIntEnable.Checked then s:='' else
      if rbIntNotNull.Checked then s := '(value) IS NOT NULL'  else
      if rbIntNull.Checked then s := '(value) IS NULL'  else begin
        s := EmptyStr;
        if chkIntFrom.Checked then
           s := '(value) >= '+IntToStr(StrToIntDef(edIntFrom.Text,0));
        if chkIntTo.Checked then begin
          if s<>EmptyStr  then  s := s + ' AND ';
          s := s + '(value) <= '+IntToStr(StrToIntDef(edIntTo.Text,0))
        end;
      end;
      dxtParams.FocusedNode.Values[1] := s;
    end;
    ptBoolean: begin
      if not chkBoolEnable.Checked then s:='' else
      if rbBoolYes.Checked then s := '(value) <> 0' else s := '(value) = 0';
      dxtParams.FocusedNode.Values[1] := s;
    end;
    ptAspirant: begin
      if not chkAspirantEnable.Checked then s := '' else
      if rbAspirantNotNull.Checked then s := '(value) IS NOT NULL'
      else if rbAspirantNull.Checked then s := '(value) IS NULL'
      else if rbAspirantYes.Checked then s := '(value) <> 0'
      else s := '(value) = 0';
      dxtParams.FocusedNode.Values[1] := s;
    end;
    ptBoolnDate: begin
      if not chkBoolnDate.Checked then s:='' else begin
        if rbBoolnDateYes.Checked then s := '(value) <> 0' else s := '(value) = 0';
        s := s + ' {(Date) >= ' + Date2SQL(dtBoolnDateFrom.Date) +
             ', (Date) <= ' + Date2SQL(dtBoolnDateTo.Date) + '}';
        dxtParams.FocusedNode.Values[1] := s;
      end;
    end;
    ptSet: begin
      if not chkSetEnable.Checked then s:='' else begin
        if chkSetNULL.Checked then s := '(value) IS NULL' else s := EmptyStr;
        with TStringList.Create do
        try
          s_in := EmptyStr;
          CommaText := mmSetValue.Text;
          for i:=0 to Count-1 do begin
            ss := Trim(Strings[i]);
            while Pos('--',ss)>0 do ss := StringReplace(ss,'--','-',[rfReplaceAll]);
            if ss=EmptyStr then continue;
            if ss[1]='-' then ss := Copy(ss,2,Length(ss)-1);
            if ss=EmptyStr then continue;
            if ss[Length(ss)]='-' then SetLength(ss,Length(ss)-1);
            if ss=EmptyStr then continue;
            if Pos('-',ss)>0 then
              try
                ss := '( (value)>= '''+Copy(ss,1,Pos('-',ss)-1)+''' AND (value) <= '''+Copy(ss,Pos('-',ss)+1,1000)+''' )';
                if s=EmptyStr then s := ss else s := s+' OR '+ss;
              except
              end
            else
              if s_in=EmptyStr then s_in := ''''+ss+''''
              else s_in := s_in+','''+ss+'''';
          end;
        finally  Free;
        end;
        if s_in<>EmptyStr then begin
          if s<>EmptyStr then s := s + ' OR ';
          s := s + ' (value) IN ('+s_in+')';
        end;
      end;
      if s=EmptyStr then dxtParams.FocusedNode.ImageIndex := 1;
      dxtParams.FocusedNode.Values[1] := s;
    end;
  end;
end;


procedure TfmFltMgr.chkStrEnableClick(Sender: TObject);
begin
  cbStrType.Enabled := chkStrEnable.Checked;
  if cbStrType.Enabled then
    cbStrType.Color := clWindow
  else
    cbStrType.Color := clBtnFace;
  edStrValue.Enabled := chkStrEnable.Checked and (cbStrType.ItemIndex<4);
  if edStrValue.Enabled then
    edStrValue.Color := clWindow
  else
    edStrValue.Color := clBtnFace;
  if cbStrType.Enabled then begin
    if cbStrType.ItemIndex<0 then cbStrType.ItemIndex := 0;
    dxtParams.FocusedNode.ImageIndex := 2;
  end
  else
    dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
end;

procedure TfmFltMgr.cbStrTypeChange(Sender: TObject);
begin
  edStrValue.Enabled := cbStrType.ItemIndex<6;
  if edStrValue.Enabled
    then edStrValue.Color := clWindow
    else edStrValue.Color := clBtnFace;
end;

procedure TfmFltMgr.edStrValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['''','"'] then Key := #0;
end;

procedure TfmFltMgr.chkDateEnableClick(Sender: TObject);
begin
  if chkDateEnable.Checked
    then dxtParams.FocusedNode.ImageIndex := 2
    else dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
  rbDateNotNull  .Enabled := chkDateEnable.Checked;
  rbDateNull     .Enabled := chkDateEnable.Checked;
  rbDateFromTo   .Enabled := chkDateEnable.Checked;
  rbDateNotNull.OnClick(nil);
end;

procedure TfmFltMgr.rbDateNotNullClick(Sender: TObject);
begin
  chkDateFrom.Enabled := rbDateFromTo.Checked and chkDateEnable.Checked;
  chkDateFrom.OnClick(nil);
  chkDateTo.Enabled := rbDateFromTo.Checked and chkDateEnable.Checked;
  chkDateTo.OnClick(nil);
  SetDateValue;
end;

procedure TfmFltMgr.chkDateFromClick(Sender: TObject);
begin
  dtDateFrom.Enabled := chkDateFrom.Enabled and chkDateFrom.Checked and chkDateEnable.Checked;
  SetDateValue;
end;

procedure TfmFltMgr.chkDateToClick(Sender: TObject);
begin
  dtDateTo.Enabled := chkDateTo.Enabled and chkDateTo.Checked and chkDateEnable.Checked;
  SetDateValue;
end;

procedure TfmFltMgr.SetDateValue;
var s: string;
begin
  if rbDateNotNull.Checked then s := '(value) IS NOT NULL' else
  if rbDateNull.Checked then    s := '(value) IS NULL'     else begin
    s := EmptyStr;
    if chkDateFrom.Checked and (dtDateFrom.Text<>EmptyStr) then
      s := '(value) >= '+Date2SQL(dtDateFrom.Date);
    if chkDateTo.Checked and (dtDateTo.Text<>EmptyStr) then begin
      if s<>EmptyStr then s := s + ' AND ';
      s := s + '(value) <= '+Date2SQL(dtDateTo.Date);
    end;
  end;
  dxtParams.FocusedNode.Values[1] := s;
end;

procedure TfmFltMgr.SetListDateValue(Table: string);
var s: string;
begin
  s := 'exists(select 1 from ' + Table + ' where ';
  if rbDateNotNull.Checked then s := s + '(value) IS NOT NULL' else
  if rbDateNull.Checked then    s := s + '(value) IS NULL'     else begin
    if chkDateFrom.Checked and (dtDateFrom.Text<>EmptyStr) then
      s := s + '(value) >= '+Date2SQL(dtDateFrom.Date);
    if chkDateTo.Checked and (dtDateTo.Text<>EmptyStr) then begin
      if s<>'exists(select 1 from ' + Table + ' where ' then s := s + ' AND ';
      s := s + '(value) <= '+Date2SQL(dtDateTo.Date);
    end;
  end;
  dxtParams.FocusedNode.Values[1] := s + ')';
end;

procedure TfmFltMgr.dtDateFromChange(Sender: TObject);
begin
  SetDateValue;
end;

procedure TfmFltMgr.lvListResize(Sender: TObject);
var i,tot: Integer;
begin
  tot := 0;
  for i:=0 to lvList.Columns.Count-1 do  tot := tot + lvList.Columns[i].Tag;
  for i:=0 to lvList.Columns.Count-1 do  lvList.Columns[i].Width :=
    Round(lvList.ClientWidth/tot*lvList.Columns[i].Tag);
end;

procedure TfmFltMgr.lvListColumnClick(Sender: TObject; Column: TListColumn);
begin
  TListView(Sender).SortType := stNone;
  if Column.Index<>SortedColumn then begin
    SortedColumn := Column.Index;
    Descending := False;
  end else
    Descending := not Descending;
  TListView(Sender).SortType := stText;
end;

procedure TfmFltMgr.lvListCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
  if SortedColumn = 0 then Compare := CompareText(Item1.Caption, Item2.Caption)
  else
  if SortedColumn <> 0 then Compare := CompareText(Item1.SubItems[SortedColumn-1], Item2.SubItems[SortedColumn-1]);
  if Descending then Compare := -Compare;
end;

procedure TfmFltMgr.lvListDblClick(Sender: TObject);
var i: Integer;
begin
//invert selection
  for i:=0 to lvList.Items.Count-1 do
    lvList.Items[i].Checked := not lvList.Items[i].Checked;
end;

procedure TfmFltMgr.chkListEnableClick(Sender: TObject);
begin
  if chkListEnable.Checked
    then dxtParams.FocusedNode.ImageIndex := 2
    else dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
  chkListNULL .Enabled := chkListEnable.Checked;
  lvList      .Enabled := chkListEnable.Checked;
  if lvList.Enabled
    then lvList.Color := clWindow
    else lvList.Color := clBtnFace;
end;

procedure TfmFltMgr.edIntFromKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9','-']) then Key := #0;
end;

procedure TfmFltMgr.chkIntEnableClick(Sender: TObject);
begin
  if chkIntEnable.Checked
    then dxtParams.FocusedNode.ImageIndex := 2
    else dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
  rbIntNotNull .Enabled := chkIntEnable.Checked;
  rbIntNull    .Enabled := chkIntEnable.Checked;
  rbIntFromTo  .Enabled := chkIntEnable.Checked;
  rbIntNotNull.OnClick(nil);
end;

procedure TfmFltMgr.rbIntNotNullClick(Sender: TObject);
begin
  chkIntFrom.Enabled := rbIntFromTo.Checked and chkIntEnable.Checked;
  chkIntFrom.OnClick(nil);
  chkIntTo.Enabled := rbIntFromTo.Checked and chkIntEnable.Checked;
  chkIntTo.OnClick(nil);
end;

procedure TfmFltMgr.chkIntFromClick(Sender: TObject);
begin
  edIntFrom.Enabled := chkIntFrom.Enabled and chkIntFrom.Checked and chkIntEnable.Checked;
end;

procedure TfmFltMgr.chkIntToClick(Sender: TObject);
begin
  edIntTo.Enabled := chkIntTo.Enabled and chkIntTo.Checked and chkIntEnable.Checked;
end;

procedure TfmFltMgr.chkBoolEnableClick(Sender: TObject);
begin
  if chkBoolEnable.Checked
    then dxtParams.FocusedNode.ImageIndex := 2
    else dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
  rbBoolYes.Enabled := chkBoolEnable.Checked;
  rbBoolNo.Enabled := chkBoolEnable.Checked;
end;

procedure TfmFltMgr.chkAspirantEnableClick(Sender: TObject);
begin
  if chkAspirantEnable.Checked
    then dxtParams.FocusedNode.ImageIndex := 2
    else dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
  rbAspirantYes.Enabled := chkAspirantEnable.Checked;
  rbAspirantNo.Enabled := chkAspirantEnable.Checked;
  rbAspirantNull.Enabled := chkAspirantEnable.Checked;
  rbAspirantNotNull.Enabled := chkAspirantEnable.Checked;
end;

procedure TfmFltMgr.chkBoolnDateClick(Sender: TObject);
begin
  if chkBoolnDate.Checked
    then dxtParams.FocusedNode.ImageIndex := 2
    else dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
  rbBoolnDateYes.Enabled := chkBoolnDate.Checked;
  rbBoolnDateNo.Enabled := chkBoolnDate.Checked;
  dtBoolnDateFrom.Enabled := chkBoolnDate.Checked;
  dtBoolnDateTo.Enabled := chkBoolnDate.Checked;
end;

procedure TfmFltMgr.mmSetValueKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9','.',',','-']) then Key := #0
  else
    if Key='.' then Key := ',';
end;

procedure TfmFltMgr.chkSetEnableClick(Sender: TObject);
begin
  if chkSetEnable.Checked
    then dxtParams.FocusedNode.ImageIndex := 2
    else dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
  chkSetNull.Enabled := chkSetEnable.Checked;
  mmSetValue.Enabled := chkSetEnable.Checked;
  if mmSetValue.Enabled
    then mmSetValue.Color := clWindow
    else mmSetValue.Color := clBtnFace;
end;

procedure TfmFltMgr.FLoadFilter(AFileName: string);
var i,j,n: Integer;
    node: TdxTreeListNode;
    s: string;
begin
  with TStringList.Create do begin
    try
      LoadFromFile(AFileName);
      for i:=0 to dxtParams.Count-1 do
        for j:=0 to dxtParams.Items[i].Count-1 do begin
          node := dxtParams.Items[i].Items[j];
          s := StringReplace(AFilterArray[Integer(node.Data)].FldName,'=','@',[rfReplaceAll]);
          n := IndexOfName(s);
          if n>=0 then begin
            node.ImageIndex := 2;
            node.Values[1] := Values[s];
            node.Parent.Expanded := True;
            if (Integer(node.Data) = 84) then begin
              n := Pos('>=',node.Strings[1]);
              if n>0 then begin
                while node.Strings[1][n]<>'#' do Inc(n);
                Inc(n);
                s := EmptyStr;
                while node.Strings[1][n]<>'#' do begin
                  s := s + node.Strings[1][n];
                  Inc(n);
                  if n>Length(node.Strings[1]) then break;
                end;
                try
                  dtBoolnDateFrom.Date := SQL2Date('#'+s+'#');
                except
                end;
              end
              else begin
                if MonthOf(Date) >= 9 then
                  dtBoolnDateFrom.Date := EncodeDateTime(YearOf(Date), 9, 1, 0, 0, 0, 0)
                else
                  dtBoolnDateFrom.Date := EncodeDateTime(YearOf(IncYear(Date, -1)), 9, 1, 0, 0, 0, 0)
              end;
              n := Pos('<=',node.Strings[1]);
              if n>0 then begin
                while node.Strings[1][n]<>'#' do Inc(n);
                Inc(n);
                s := EmptyStr;
                while node.Strings[1][n]<>'#' do begin
                  s := s + node.Strings[1][n];
                  Inc(n);
                  if n>Length(node.Strings[1]) then break;
                end;
                try
                  dtBoolnDateTo.Date := SQL2Date('#'+s+'#');
                except
                end;
              end
              else begin
                if MonthOf(Date) >= 9 then
                  dtBoolnDateTo.Date := EncodeDateTime(YearOf(IncYear(Date, 1)), 8, 31, 0, 0, 0, 0)
                else
                  dtBoolnDateTo.Date := EncodeDateTime(YearOf(Date), 8, 31, 0, 0, 0, 0)
              end;
            end;
          end
          else begin
            node.ImageIndex := 1;
            node.Values[1] := EmptyStr;
          end;
          node.SelectedIndex := node.ImageIndex;
        end;
    except
      ShowErr('Ошибка при загрузке настроек выборки!');
    end;
    Free;
  end;
end;

procedure TfmFltMgr.FSaveFilter(AFileName: string);
var i,j: Integer;
begin
  with TStringList.Create do begin
    try
      for i:=0 to dxtParams.Count-1 do
        for j:=0 to dxtParams.Items[i].Count-1 do
          with dxtParams.Items[i].Items[j] do
            if ImageIndex=2 then
              Add(StringReplace(AFilterArray[Integer(Data)].FldName,'=','@',[rfReplaceAll])+'='+Values[1]);
      SaveToFile(AFileName);
    except
      ShowErr('Ошибка при сохранении настроек выборки!');
    end;
    Free;
  end;
end;

procedure TfmFltMgr.btnSaveFltClick(Sender: TObject);
begin
  dlgSave.InitialDir := ExtractFilePath(Application.ExeName);
  if dlgSave.FileName=EmptyStr then
    dlgSave.FileName := 'default.flt';
  if dlgSave.Execute then
    FSaveFilter(dlgSave.FileName);
end;

procedure TfmFltMgr.btnOpenFltClick(Sender: TObject);
begin
  dlgOpen.InitialDir := ExtractFilePath(Application.ExeName);
  if dlgOpen.FileName=EmptyStr then
    if dlgSave.FileName=EmptyStr
    then dlgOpen.FileName := 'default.flt'
    else dlgOpen.FileName := dlgSave.FileName;
  if dlgOpen.Execute then
    FLoadFilter(dlgOpen.FileName);
end;

procedure TfmFltMgr.btnClearClick(Sender: TObject);
var i,j: Integer;
begin
  if RMessageDlg('Очистить фильтры выборки?',mtConfirmation,[mbYes,mbNo],0)=mrYes then
    for i:=0 to dxtParams.Count-1 do
      for j:=0 to dxtParams.Items[i].Count-1 do
        with dxtParams.Items[i].Items[j] do begin
          ImageIndex := 1;
          SelectedIndex := 1;
          Values[1] := EmptyStr;
        end;
end;

procedure TfmFltMgr.dxtParamsValueColumnEditButtonClick(Sender: TObject);
var
  P: TPanel;
  F: TForm;
  AText: String;
  AACcept: Boolean; //Dump for CloseUp
begin
  P := GetPanel; if not Assigned(P) then Exit;
  F := TForm.Create(Self);
  try
    F.BorderStyle := bsSizeable; //bsToolWindow;
    F.Caption := dxtParams.FocusedNode.Strings[0];
    F.ClientWidth := P.Width;
    F.ClientHeight := P.Height + pnlEditOk.Height;
    F.Position := poOwnerFormCenter;
    pnlEditOk.Width := P.Width;
    P.Parent := F; P.Top := 0; P.Left := 0; P.Visible := True;
    P.Align := alClient;
    pnlEditOk.Parent := F; pnlEditOk.Top := P.Height; pnlEditOk.Left := 0; pnlEditOk.Visible := True;
    pnlEditOk.Align := alBottom;
    AText := dxtParams.FocusedNode.Strings[1];
    dxtParamsValueColumnPopup(nil,AText);
    if F.ShowModal = mrOk then dxtParamsValueColumnCloseUp(nil, AText, AAccept);
  finally
    P         .Visible := False; P        .Parent := Self;
    pnlEditOk .Visible := False; pnlEditOk.Parent := Self;
    F.Free;
  end;
  dxtParams.CloseEditor;
end;

function TfmFltMgr.GetPanel: TPanel;
var Node: tdxTreeListNode;
begin
  Result := nil;
  Node := dxtParams.FocusedNode;

  if not Assigned(Node) or Node.HasChildren then Exit;

  //assign editor for each item type
  case AFilterArray[Integer(Node.Data)].FldType of
    ptString,ptListString : begin
      Result := pnlEditStr;
      Result.Width := 277; Result.Height := 81;
    end;
    ptDate,ptListDate     : begin
      Result := pnlEditDate;
      Result.Width := 359; Result.Height := 121;
    end;
    ptList                : begin
      Result := pnlEditList;
      Result.Width := 399; Result.Height := 209;
    end;
    ptInteger             : begin
      Result := pnlEditInt;
      Result.Width := 359; Result.Height := 121;
    end;
    ptBoolean             : begin
      Result := pnlEditBool;
      Result.Width := 250; Result.Height := 69;
    end;
    ptSet                 : begin
      Result := pnlEditSet;
      Result.Width := 347; Result.Height := 141;
    end;
    ptBoolnDate           : begin
      Result := pnlEditBoolnDate;
      Result.Width := 265; Result.Height := 103;
    end;
    ptAspirant            : begin
      Result := pnlEditAspirant;
      Result.Width := 250; Result.Height := 106;
    end;
  end;
end;

end.



unit fFltMgr;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, dxCntner, dxTL, ImgList, dxTLClms, StdCtrls, FrmKeep, dxTLClEx,
  ComCtrls, dxEditor, dxExEdtr, dxEdLib, ADOdb;

type
  TfmFltMgr = class(TForm)
    dxtParams: TdxTreeList;
    ImageList1: TImageList;
    dxtParamsColumn1: TdxTreeListColumn;
    btnSaveFlt: TButton;
    btnOpenFlt: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    FrmKeep1: TFrmKeep;
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
    pnlEditCompare: TPanel;
    chkCompareEnable: TCheckBox;
    rbCompareEqu: TRadioButton;
    rbCompareNotEqu: TRadioButton;
    memSQL: TMemo;
    btnCard: TButton;
    dxtParamsValueColumn: TdxTreeListButtonColumn;
    pnlEditOk: TPanel;
    btnEditOk: TButton;
    Bevel1: TBevel;
    btnEditCancel: TButton;
    chkNewWindow: TCheckBox;
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
    procedure mmSetValueKeyPress(Sender: TObject; var Key: Char);
    procedure chkSetEnableClick(Sender: TObject);
    procedure edStrValueKeyPress(Sender: TObject; var Key: Char);
    procedure btnSaveFltClick(Sender: TObject);
    procedure btnOpenFltClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure chkCompareEnableClick(Sender: TObject);
    procedure btnCardClick(Sender: TObject);
    procedure dxtParamsValueColumnEditButtonClick(Sender: TObject);
  private
    { Private declarations }
    FSQL: TStringList;
    FTempFile: string;
    FNewForm: TForm;
    procedure SetDateValue;
    procedure FLoadFilter(AFileName: string);
    procedure FSaveFilter(AFileName: string);
    procedure FSetFilter(F: TStringList);
    procedure FGetFilter(F: TStringList);
    function GetPanel: TPanel;
  public
    { Public declarations }
    procedure AssignParams;
  end;


  function GetSQLText(out ANewForm: TForm; CanNewWin, ShowDialog: Boolean; var ASQL: string; TempFile: string = ''): boolean;

implementation

uses dMain, msg, Rdialogs, IniSupport, fOrgProp, fOrgLst, StrUtils, fMain;

{$R *.DFM}
{$REGION 'FilterArray'}
type
 TFilterType = (ptString,ptDate,ptInteger,ptList,ptSet,ptBoolean,ptCompare);
 TFilterRec = record
   FldName: string;
   FldType: TFilterType;
   CompareValue: string;
   DispName: string;
   DispGroup: string;
   ListSQL: string;
   InnerTable: string;
 end;

const
  AFilterArray : Array[0..67] of TFilterRec = (
    (FldName:'gen.Fam';   FldType: ptString; DispName:'Руководитель - фамилия';   DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=1) gen'),
    (FldName:'gen.Im';    FldType: ptString; DispName:'Руководитель - имя';       DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=1) gen'),
    (FldName:'gen.Otch';  FldType: ptString; DispName:'Руководитель - отчество';  DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=1) gen'),
    (FldName:'gen.Phone'; FldType: ptString; DispName:'Руководитель - телефон';   DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=1) gen'),
    (FldName:'gen.Post';  FldType: ptString; DispName:'Руководитель - должность'; DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=1) gen'),
    (FldName:'gen2.Fam';   FldType: ptString; DispName:'Отв. за ГОЧС - фамилия';   DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=2) gen2'),
    (FldName:'gen2.Im';    FldType: ptString; DispName:'Отв. за ГОЧС - имя';       DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=2) gen2'),
    (FldName:'gen2.Otch';  FldType: ptString; DispName:'Отв. за ГОЧС - отчество';  DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=2) gen2'),
    (FldName:'gen2.Phone'; FldType: ptString; DispName:'Отв. за ГОЧС - телефон';   DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=2) gen2'),
    (FldName:'gen2.Post';  FldType: ptString; DispName:'Отв. за ГОЧС - должность'; DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_GEN=2) gen2'),
    (FldName:'vus.Fam';   FldType: ptString; DispName:'ВУР - фамилия';   DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_VUS=1) vus'),
    (FldName:'vus.Im';    FldType: ptString; DispName:'ВУР - имя';       DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_VUS=1) vus'),
    (FldName:'vus.Otch';  FldType: ptString; DispName:'ВУР - отчество';  DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_VUS=1) vus'),
    (FldName:'vus.Phone'; FldType: ptString; DispName:'ВУР - телефон';   DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_VUS=1) vus'),
    (FldName:'vus.Post';  FldType: ptString; DispName:'ВУР - должность'; DispGroup: 'Контактные лица'; InnerTable: '(SELECT * FROM ORG_CONT WHERE IS_VUS=1) vus'),
    (FldName:'ORGNAME';   FldType: ptString; DispName: 'Наименование'; DispGroup: 'Основные'),
    (FldName:'ORGSNAME';   FldType: ptString; DispName: 'Краткое наименование'; DispGroup: 'Основные'),
    (FldName:'REGNUM';    FldType: ptString; DispName: 'Регистрационный номер'; DispGroup: 'Основные'),
    (FldName:'REGDATE';   FldType: ptDate; DispName: 'Дата регистрации'; DispGroup: 'Основные'),
    (FldName:'URADDR';    FldType: ptString; DispName: 'Юр. адрес'; DispGroup: 'Основные'),
    (FldName:'FIZADDR';   FldType: ptString; DispName: 'Факт. адрес'; DispGroup: 'Основные'),
    (FldName:'UPPER(ISNULL(FIZADDR,''''))'; FldType: ptCompare; CompareValue: 'UPPER(ISNULL(URADDR,''''))'; DispName: 'Сравнение факт. и юр. адресов'; DispGroup: 'Основные'),
    (FldName:'POSTADDR';  FldType: ptString; DispName: 'Почт. адрес'; DispGroup: 'Основные'),
    (FldName:'PHONE';     FldType: ptString; DispName: 'Телефон'; DispGroup: 'Основные'),
    (FldName:'OKPO';      FldType: ptSet; DispName: 'ОКПО'; DispGroup: 'Основные'),
    (FldName:'INN';       FldType: ptString; DispName: 'ИНН/КПП'; DispGroup: 'Основные'),
    (FldName:'COMMENT';   FldType: ptString; DispName: 'Примечания'; DispGroup: 'Основные'),
//    (FldName:'CASE WHEN (MainOKONH LIKE ''[0-9][0-9]'' OR MainOKONH LIKE ''[0-9][0-9].%'') AND EXISTS( SELECT * FROM KOKVED WHERE CAST(SUBSTRING(MainOKONH,1,2) AS Int) BETWEEN OKVED_BEGIN AND OKVED_END) THEN 0 ELSE 1 END';
//      FldType: ptBoolean; DispName: 'Неправильный код ВЭД'; DispGroup: 'Основные'),
    (FldName:'TERR_ID';   FldType:ptList; DispName: 'Вышестоящий ВУО курирует'; DispGroup: 'Регистрация';
       ListSQL: 'select KTERR.TERR_ID as [ID], NAME as [Наименование_70], KODTERR as [Код_30] from KTERR join SUBJ on KTERR.TERR_ID=SUBJ.TERR_ID order by 3'),
    (FldName:'dbo.ExtractNumber(OKBV)'; FldType: ptSet; DispName: '№ в ВУО'; DispGroup: 'Регистрация'),
    (FldName:'KODREG';    FldType: ptString; DispName: 'ОКАТО'; DispGroup: 'Классификация'),
    (FldName:'WRONG_KODREG'; FldType: ptBoolean; DispName: 'Недопустимое значение ОКАТО'; DispGroup: 'Классификация'),
    (FldName:'KODOKTMO';    FldType: ptString; DispName: 'ОКТМО'; DispGroup: 'Классификация'),
    (FldName:'case when '+
      '(SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''40'' and '#13+
        'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''45'' and  '#13+
        'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''67'' and  '#13+
        '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''7'' or '#13+
            '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''850'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''898'') or  '#13+
            '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''950'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''998''))) or '#13+

        '(SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''40'' and  '#13+
         'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''45'' and  '#13+
         'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''67'' and '#13+
         'SUBSTRING(ISNULL(KODOKTMO,0),6,1) in (''1'',''4'',''7'') and '#13+
         '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' or '#13+
        '  (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''810'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''849'') or '#13+
        '  (SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''910'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''949''))) or '#13+

      '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' and SUBSTRING(ISNULL(KODOKTMO,0),6,1) = ''1'') or '#13+
       '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' and SUBSTRING(ISNULL(KODOKTMO,0),6,1) = ''4'') or '#13+
       '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' and SUBSTRING(ISNULL(KODOKTMO,0),6,1) = ''7'') or ' +
      '((SUBSTRING(ISNULL(KODOKTMO,0),1,2) = ''40'' or '#13+
        'SUBSTRING(ISNULL(KODOKTMO,0),1,2) = ''45'' or '#13+
        'SUBSTRING(ISNULL(KODOKTMO,0),1,2) = ''67'') and '#13+
      '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''3'' or SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''9'')) then 0 else 1 end';
      FldType: ptBoolean; DispName: 'Недопустимое значение ОКТМО'; DispGroup: 'Классификация'),
    (FldName:'case when '#13+
                		'(SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''40'' and '#13+
                        'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''45'' and '#13+
                        'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''67'' and '#13+
                        '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''7'' or '#13+
                        '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''850'' and '#13+
                                'SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''898'') or '#13+
                        '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''950'' and '#13+
                                'SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''998''))) '#13+
        'Then 1 When '#13+
                  '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' or '#13+
                        '(SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''40'' and '#13+
                        	'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''45'' and '#13+
                          'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''67'' and '#13+
					    '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' or '#13+
						    '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''810'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''849'') or '#13+
						    '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''910'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''949'')  )) '#13+
                		') and '#13+
                        'SUBSTRING(ISNULL(KODOKTMO,0),6,1) = ''1'' '#13+
        'Then 2 When '#13+
                  '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' or '#13+
                        '(SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''40'' and '#13+
                        	'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''45'' and '#13+
                          'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''67'' and '#13+
					    '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' or '#13+
						    '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''810'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''849'') or '#13+
						    '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''910'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''949'')  )) '#13+
                		') and '#13+
                        'SUBSTRING(ISNULL(KODOKTMO,0),6,1) = ''4'' '#13+
        'Then 3 When '#13+
                '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' or '#13+
                        '(SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''40'' and '#13+
                        	'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''45'' and '#13+
	                        'SUBSTRING(ISNULL(KODOKTMO,0),1,2) <> ''67'' and '#13+
				    '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''6'' or '#13+
						    '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''810'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''849'') or '#13+
						    '(SUBSTRING(ISNULL(KODOKTMO,0),3,3) >= ''910'' and SUBSTRING(ISNULL(KODOKTMO,0),3,3) <= ''949'')  )) '#13+
                		') and '#13+
                        'SUBSTRING(ISNULL(KODOKTMO,0),6,1) = ''7'' '#13+
        'Then 4 When '#13+
               '(SUBSTRING(ISNULL(KODOKTMO,0),1,2) = ''40'' or '#13+
                        'SUBSTRING(ISNULL(KODOKTMO,0),1,2) = ''45'') and '#13+
                        'SUBSTRING(ISNULL(KODOKTMO,0),1,2) = ''67'' and '#13+
                        '(SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''3'' or '#13+
                        'SUBSTRING(ISNULL(KODOKTMO,0),3,1) = ''9'') '#13+
        'Then 5 end ';
      FldType: ptList; DispName: 'Расположен на территории (по ОКТМО)'; DispGroup: 'Классификация';
      ListSQL:
        'select 1 as [ID], ''городского округа'' as [Наименование_100] union all '+
        'select 2, ''городского поселения'' union all '+
        'select 3, ''сельского поселения'' union all '+
        'select 4, ''на межселенной территории'' union all '+
        'select 5, ''на территории города федерального значения'' '),
    (FldName:'SOOGU';     FldType: ptSet; DispName: 'СООГУ'; DispGroup: 'Классификация'),
    (FldName:'(select ASCII(OKVED_SECTION)-ASCII(''A'') from KOKVED where (len(mainokonh)=2 or substring(mainokonh,3,1)=''.'') and cast(left(mainokonh,2)as int) between OKVED_BEGIN and OKVED_END)';
                          FldType: ptList; DispName: 'Раздел ОКВЭД'; DispGroup: 'Классификация';
      ListSQL: 'select ASCII(OKVED_SECTION)-ASCII(''A'') as [ID], OKVED_SECTION+''. ''+OKVED_SECTION_NAME as [Раздел_100], CAST(OKVED_BEGIN as VarChar)+''-''+CAST(OKVED_END as VarChar) as [Диапазон_20] from KOKVED order by 2'),
    (FldName:'MAINOKONH'; FldType: ptString; DispName: 'Основной ОКВЭД'; DispGroup: 'Классификация'),
    (FldName:'WRONG_OKVED'; FldType: ptBoolean; DispName: 'Недопустимое значение ОКВЭД'; DispGroup: 'Классификация'),
    (FldName:'OKONH';     FldType: ptString; DispName: 'Прочие ОКВЭД'; DispGroup: 'Классификация'),
    (FldName:'FS_ID';     FldType: ptList; DispName: 'ОКФС'; DispGroup: 'Классификация';
       ListSQL:'select FS_ID as [ID], KOD as [Код_15], FS_NAME as [Наименование_85] from KFS order by 2'),
    (FldName:'KOPF_ID';   FldType: ptList; DispName: 'ОКОПФ'; DispGroup: 'Классификация';
       ListSQL:'select KOPF_ID as [ID], KOD as [Код_15], KOPF_NAME as [Наименование_85] from KOPF order by 2'),
    (FldName:'OCCUPATION'; FldType: ptString; DispName: 'Деятельность (слов.)'; DispGroup: 'Классификация'),
    (FldName:'OVK_ID';    FldType: ptList; DispName: 'ОВК'; DispGroup: 'Классификация';
       ListSQL:'select OVK_ID as [ID], OVK_NAME as [Наименование_100] from KOVK order by 2'),
    (FldName:'SBM_ID';    FldType: ptList; DispName: 'Подчиненность'; DispGroup: 'Классификация';
       ListSQL:'select ID as [ID], KOD as [Код_15], NAME as [Наименование_85] from VV5 order by 2'),
    (FldName:'F6_SHIFR';  FldType: ptList; DispName: 'Шифр формы №6'; DispGroup: 'Классификация';
       ListSQL:'select 01 as [ID], ''Шифр 01'' as [Наименование_100] union all select 02, ''Шифр 02'' union all select 03, ''Шифр 03'' union all select 04, ''Шифр 04'' union all select 05, ''Шифр 05'' union all select 06, ''Шифр 06'''),
    (FldName:'REGPL_ID';  FldType: ptList; DispName: 'Место регистрации'; DispGroup: 'Регистрация';
       ListSQL:'select REGPL_ID as [ID], REGPL_KOD as [Код_20], REGPL_NAME as [Наименование_80] from KREGPL order by 2'),
    (FldName:'FIRST_DATE'; FldType: ptDate; DispName: 'Дата первичн. регистрации'; DispGroup: 'Регистрация'),
    (FldName:'LAST_DATE'; FldType: ptDate; DispName: 'Дата последнего прихода'; DispGroup: 'Регистрация'),
    (FldName:'OUT_DATE';  FldType: ptDate; DispName: 'Дата снятия с учета'; DispGroup: 'Регистрация'),
    (FldName:'CHK_DATE';  FldType: ptDate; DispName: 'Данные сверены'; DispGroup: 'Регистрация'),
    (FldName:'HAS_BRON';  FldType: ptBoolean; DispName: 'Ведет бронирование'; DispGroup: 'Регистрация'),
    (FldName:'HAS_F6';    FldType: ptBoolean; DispName: 'Есть форма №6'; DispGroup: 'Регистрация'),
    (FldName:'F6CHECKED'; FldType: ptBoolean; DispName: 'Форма №6 проверена'; DispGroup: 'Регистрация'),
    (FldName:'RAB_COUNT'; FldType: ptInteger; DispName: 'Кол-во работающих'; DispGroup: 'Регистрация'),
    (FldName:'ZAP_COUNT'; FldType: ptInteger; DispName: 'Из них в запасе'; DispGroup: 'Регистрация'),
    (FldName:'ZAB_COUNT'; FldType: ptInteger; DispName: 'Из них забронировано'; DispGroup: 'Регистрация'),
    (FldName:'vv3.BASE_ID';    FldType: ptList; DispName:'Сведения о бронировании (основания)';   DispGroup: 'Регистрация';
       ListSQL:'select ID, KOD as [Код_15], NAME as [Наименование_85] from VV3 order by 2';
       InnerTable: '(SELECT o.ORGID, OSN.BASE_ID FROM v_org o left join OSN on OSN.ORGID = o.ORGID) vv3'),
    (FldName:'GPZGPPNone'; FldType: ptBoolean; DispName: 'ГПЗ, ГПП нет'; DispGroup: 'Регистрация'),
    (FldName:'ReportNone'; FldType: ptBoolean; DispName: 'Отчёт не предоставлен'; DispGroup: 'Регистрация'),
    (FldName:'PER_NO';    FldType: ptString; DispName: 'Номер перечня'; DispGroup: 'Регистрация'; InnerTable: 'PER'),
    (FldName:'Feature1';  FldType: ptString; DispName: 'Признак1'; DispGroup: 'Дополнительно'),
    (FldName:'Feature2';  FldType: ptString; DispName: 'Признак2'; DispGroup: 'Дополнительно'),
    (FldName:'Feature3';  FldType: ptString; DispName: 'Признак3'; DispGroup: 'Дополнительно'),
    (FldName:'case when IsNull(kopf_changed,0)=0 then 1 else 0 end';  FldType: ptBoolean; DispName: 'Сверка кода ОКОПФ проведена'; DispGroup: 'Дополнительно'),
    (FldName:'case when IsNull(okved_changed,0)=0 then 1 else 0 end';  FldType: ptBoolean; DispName: 'Сверка кода ОКВЭД проведена'; DispGroup: 'Дополнительно'),
    (FldName:'COL_10'; FldType: ptInteger; DispName: 'Имеют моб. предписание'; DispGroup: 'Регистрация'),
    (FldName:'COL_11'; FldType: ptInteger; DispName: 'Подлежат призыву'; DispGroup: 'Регистрация'),
    (FldName:'COL_12'; FldType: ptInteger; DispName: 'Потребность на РГ'; DispGroup: 'Регистрация')
  );
{$ENDREGION 'FilterArray'}
function GetSQLText(out ANewForm: TForm; CanNewWin, ShowDialog: Boolean; var ASQL: string; TempFile: string = ''): boolean;
begin
   with TfmFltMgr.Create(Application) do
   try
     FTempFile := TempFile;
     AssignParams;
     FSQL.Text := ASQL;
     chkNewWindow.Enabled := CanNewWin;
     Result := True;
     if ShowDialog then
        Result := ShowModal=mrOk
     else
        btnOkClick(nil);
     if Result then ASQL := FSQL.Text;
     ANewForm := FNewForm;
   finally Free;
   end;
end;

function Date2SQL(ADate: TDate): string;
begin
  Result := FormatDateTime('YYYYMMDD',ADate);
end;

function SQL2Date(ASQL: string): TDate;
begin
  Result := EncodeDate(
    StrToInt(Copy(ASQL,1,4)),
    StrToInt(Copy(ASQL,5,2)),
    StrToInt(Copy(ASQL,7,2)) );
end;

procedure TfmFltMgr.FormCreate(Sender: TObject);
begin
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
  if FileExists(FTempFile) then FLoadFilter(FTempFile);
end;

procedure TfmFltMgr.btnOkClick(Sender: TObject);
var i,j: Integer;
    s,ss: string;
begin
  FSQL.Text := Format(memSQL.Lines.Text,[DATE2SQL(IniSupport.GetReportDate)]);
  for i:=0 to dxtParams.Count-1 do
  for j:=0 to dxtParams.Items[i].Count-1 do
  with dxtParams.Items[i].Items[j] do
  if (ImageIndex=2) and (Values[1]<>EmptyStr) then begin
    s := Values[1];
    s := StringReplace(s,'(value)',AFilterArray[Integer(Data)].FldName,[rfReplaceAll]);
    ss := AFilterArray[Integer(dxtParams.Items[i].Items[j].Data)].InnerTable;
    if ss<>EmptyStr then
      s := 'ORGID IN (SELECT ORGID FROM '+ss+' WHERE '+s+')';
    FSQL.Add('AND ('+s+')');
  end;
  if chkNewWindow.Enabled and chkNewWindow.Checked then begin
    ModalResult := mrCancel;
    Application.CreateForm(TfmOrgList, FNewForm);
    if fmMain.MainScale <> 100 then
      FNewForm.ScaleBy(fmMain.MainScale, 100);
    with FNewForm as TfmOrgList do begin
      SetFiltr(FSQL.Text);
      Self.FTempFile := FTempFile;
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
    ptString: begin
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
    ptDate: begin
    //parse date text
      chkDateEnable.Checked := dxtParams.FocusedNode.ImageIndex=2;
      if Pos('IS NOT NULL',EditText)=9 then         rbDateNotNull.Checked := true
      else
      if Pos('IS NULL',EditText)=9 then             rbDateNull.Checked := true
      else begin
        rbDateFromTo.Checked := true;
        n := Pos('>=',EditText);
        if n>0 then begin
          chkDateFrom.Checked := true;
          while not (EditText[n] in ['0'..'9']) do Inc(n);
          s := EmptyStr;
          repeat
            s := s + EditText[n];
            Inc(n);
            if n>Length(EditText) then break;
          until not (EditText[n] in ['0'..'9']);
          try
            dtDateFrom.Date := SQL2Date(s);
          except
          end;
        end
        else
          chkDateFrom.Checked := false;
        n := Pos('<=',EditText);
        if n>0 then begin
          chkDateTo.Checked := true;
          while not (EditText[n] in ['0'..'9']) do Inc(n);
          s := EmptyStr;
          repeat
            s := s + EditText[n];
            Inc(n);
            if n>Length(EditText) then break;
          until not (EditText[n] in ['0'..'9']);
          try
            dtDateTo.Date := SQL2Date(s);
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
            with lvList.Columns.Add do begin
              s := Fields[n].FieldName;
              k := Pos('_',s);
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
      rbBoolYes.Checked := Pos('!=',EditText)>0;
      rbBoolNo.Checked := not rbBoolYes.Checked;
      chkBoolEnable.OnClick(nil);
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
    ptCompare: begin
      chkCompareEnable.Checked := dxtParams.FocusedNode.ImageIndex=2;
      rbCompareEqu.Checked := true;
      rbCompareNotEqu.Checked := Pos('!=',EditText)>0;
      chkCompareEnable.OnClick(nil);
    end;
  end;
end;

procedure TfmFltMgr.dxtParamsValueColumnCloseUp(Sender: TObject;
  var Text: String; var Accept: Boolean);
var i: Integer;
    s,s_in,ss: string;
begin
  s := '';
  case AFilterArray[Integer(dxtParams.FocusedNode.Data)].FldType of
    ptString: begin
      if not chkStrEnable.Checked then s:='' else
      case cbStrType.ItemIndex of
        0: s := '(value) LIKE ''%'+edStrValue.Text+'%''';
        1: s := '(value) NOT LIKE ''%'+edStrValue.Text+'%''';
        2: s := 'LEFT((value),'+IntToStr(Length(edStrValue.Text))+') = '''+edStrValue.Text+'''';
        3: s := 'RIGHT((value),'+IntToStr(Length(edStrValue.Text))+') = '''+edStrValue.Text+'''';
        4: s := '(value) = '''+edStrValue.Text+'''';
        5: s := '(value) <> '''+edStrValue.Text+'''';
        6: s := '(value) IS NOT NULL';
        7: s := '(value) IS NULL';
      else
        s := EmptyStr;
      end;
      dxtParams.FocusedNode.Values[1] := s;
    end;
    ptDate: begin
      if not chkdateEnable.Checked then s:='' else begin
        dtDateFrom.ValidateEdit;
        dtDateTo.ValidateEdit;
        SetDateValue;
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
      if rbBoolYes.Checked then s := '(value) != 0' else s := '(value) = 0';
      dxtParams.FocusedNode.Values[1] := s;
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
    ptCompare: begin
      if not chkCompareEnable.Checked then s:='' else begin
        if rbCompareEqu.Checked then s := '(value) = '  else
        if rbCompareNotEqu.Checked then s := '(value) != ';
        s :=  s + AFilterArray[Integer(dxtParams.FocusedNode.Data)].CompareValue;
      end;
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
  edStrValue.Enabled := chkStrEnable.Checked and (cbStrType.ItemIndex<6);
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
  if edStrValue.Enabled then
    edStrValue.Color := clWindow
  else
    edStrValue.Color := clBtnFace;
end;

procedure TfmFltMgr.edStrValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['''','"'] then Key := #0;
end;

procedure TfmFltMgr.chkDateEnableClick(Sender: TObject);
begin
  if chkDateEnable.Checked then
    dxtParams.FocusedNode.ImageIndex := 2
  else
    dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
  rbDateNotNull.Enabled := chkDateEnable.Checked;
  rbDateNull.Enabled := chkDateEnable.Checked;
  rbDateFromTo.Enabled := chkDateEnable.Checked;
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
      s := '(value) >= '''+Date2SQL(dtDateFrom.Date)+'''';
    if chkDateTo.Checked and (dtDateTo.Text<>EmptyStr) then begin
      if s<>EmptyStr then s := s + ' AND ';
      s := s + '(value) <= '''+Date2SQL(dtDateTo.Date)+'''';
    end;
  end;
  dxtParams.FocusedNode.Values[1] := s;
end;

procedure TfmFltMgr.dtDateFromChange(Sender: TObject);
begin
  SetDateValue;
end;

procedure TfmFltMgr.lvListResize(Sender: TObject);
var i,tot: Integer;
begin
  tot := 0;
  for i:=0 to lvList.Columns.Count-1 do
    tot := tot + lvList.Columns[i].Tag;
  for i:=0 to lvList.Columns.Count-1 do
    lvList.Columns[i].Width := Round(lvList.ClientWidth/tot*lvList.Columns[i].Tag);
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
  chkListNULL.Enabled := chkListEnable.Checked;
  lvList.Enabled := chkListEnable.Checked;
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
  rbIntNotNull.Enabled := chkIntEnable.Checked;
  rbIntNull.Enabled := chkIntEnable.Checked;
  rbIntFromTo.Enabled := chkIntEnable.Checked;
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

procedure TfmFltMgr.FSetFilter(F: TStringList);
//
 function ValueOf(S: String): String;
 var I: Integer; tmp: String;
 begin
   for I := 0 to F.Count-1 do begin
     tmp := F[I];
     if S+'=' = LeftStr(tmp,Length(S)+1) then begin
       Result := RightStr(tmp,Length(tmp)-Length(S)-1);
       Exit;
     end;
   end;
   Result := '';
 end;
//
var i,j: Integer; S: String;
begin
  for i:=0 to dxtParams.Count-1 do
  for j:=0 to dxtParams.Items[i].Count-1 do
  with dxtParams.Items[i].Items[j] do begin
    S := ValueOf(AFilterArray[Integer(Data)].FldName);
    if S<>'' then begin
      ImageIndex := 2;
      Values[1] := S;
      Parent.Expanded := True;
    end
    else begin
      ImageIndex := 1;
      Values[1] := EmptyStr;
    end;
    SelectedIndex := ImageIndex;
  end;
end;

procedure TfmFltMgr.FLoadFilter(AFileName: string);
var F: TStringList;
begin
  F := TStringList.Create;
  try    F.LoadFromFile(AFileName);
         FSetFilter(F);
  except ShowErr('Ошибка при загрузке настроек выборки!');
  end;
  F.Free;
end;

procedure TfmFltMgr.FGetFilter(F: TStringList);
var i,j: Integer;
begin
  for i:=0 to dxtParams.Count-1 do
  for j:=0 to dxtParams.Items[i].Count-1 do
  with dxtParams.Items[i].Items[j] do
  if ImageIndex=2 then  F.Add(AFilterArray[Integer(Data)].FldName+'='+Values[1]);
end;


procedure TfmFltMgr.FSaveFilter(AFileName: string);
var F: TStringList;
begin
  F := TStringList.Create;
  try    FGetFilter(F);
         F.SaveToFile(AFileName);
  except ShowErr('Ошибка при сохранении настроек выборки!');
  end;
  F.Free;
end;

procedure TfmFltMgr.btnSaveFltClick(Sender: TObject);
begin
  if dlgSave.FileName=EmptyStr then
    dlgSave.FileName := ExtractFilePath(Application.ExeName)+'default.flt';
  if dlgSave.Execute then
    FSaveFilter(dlgSave.FileName);
end;

procedure TfmFltMgr.btnOpenFltClick(Sender: TObject);
begin
  if dlgOpen.FileName=EmptyStr then
    if dlgSave.FileName=EmptyStr
      then dlgOpen.FileName := ExtractFilePath(Application.ExeName)+'default.flt'
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

procedure TfmFltMgr.chkCompareEnableClick(Sender: TObject);
begin
  if chkCompareEnable.Checked
    then dxtParams.FocusedNode.ImageIndex := 2
    else dxtParams.FocusedNode.ImageIndex := 1;
  dxtParams.FocusedNode.SelectedIndex := dxtParams.FocusedNode.ImageIndex;
  rbCompareEqu.Enabled := chkCompareEnable.Checked;
  rbCompareNotEqu.Enabled := chkCompareEnable.Checked;
end;

procedure TfmFltMgr.btnCardClick(Sender: TObject);
var F: TStringList;
begin
  F := TStringList.Create;
  try     FGetFilter(F);
          if fOrgProp.ShowOrgCard(-1, TfmOrgList(F)) then FSetFilter(F);
  finally F.Free;
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
    ptString : begin
      Result := pnlEditStr;
      Result.Width := 277; Result.Height := 81;
    end;
    ptDate     : begin
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
    ptCompare : begin
      Result := pnlEditCompare;
      Result.Width := 250; Result.Height := 78;
    end;
  end;
end;

end.

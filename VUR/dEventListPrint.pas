unit dEventListPrint;

interface

uses
  SysUtils, Classes, DB, ADODB, ekfunc, ekbasereport, ekrtf;

type
  TdmEventListPrint = class(TDataModule)
    EkRTF1: TEkRTF;
    Event: TADOQuery;
    Detail: TADOQuery;
    dsEvent: TDataSource;
    EkUDFList1: TEkUDFList;
    procedure EkUDFList1Functions0Calculate(Sender: TObject;
      Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmEventListPrint: TdmEventListPrint;

procedure Execute(All: Boolean=False);

implementation

uses dMain, IniSupport, Windows, Dialogs, SaveEvents;

{$R *.dfm}

procedure Execute(All: Boolean=False);
var
  S            : String;
  TemplateSize : Integer;
  EventDetail  : array of String;
//
  procedure AddEventDetail(ADetail: String);
  begin
    SetLength(EventDetail, Length(EventDetail)+1);
    EventDetail[High(EventDetail)] := ADetail;
  end;
//
begin
  SetLength(EventDetail, 0);
  with TdmEventListPrint.Create(nil) do
  try
    with EkRTF1 do begin
      SetTemplateBuffer(MakeRTFTemplate('RTF_EventList', TemplateSize), TemplateSize);
      OutFile :=GetReportsDir+'ЖурналСобытий.rtf';

      with TADOQuery.Create(nil) do
      try
        Connection := dmMain.dbMain;
        ParamCheck := False;
        SQL.Text := 'SELECT ORGNAME FROM ORG';
        Open;
        CreateVar('OrgName', Fields[0].AsString);
      finally Free;
      end;
      CreateVar('PrintDate',DateTimeToStr(Now));
      S := GetEventFilterSQL;
      if All then S := '';
      CreateVar('IsFiltered', S<>'');
      if S<>'' then with GetEventFilter do begin
        Event.SQL.Add(S);
        CreateVar('WhoExists', efWho>0);
        CreateVar('Who', efWho);
        with TADOQuery.Create(nil) do
        try
          Connection := dmMain.dbMain;
          ParamCheck := False;
          SQL.Text := 'SELECT Login FROM Users WHERE ID='+IntToStr(efWho);
          Open;
          CreateVar('WhoLogin', Fields[0].AsString);
          if efWho>0 then AddEventDetail('Кто: '+Fields[0].AsString);
        finally Free;
        end;
        CreateVar('FromDateCheck'    , efFromDateCheck);
        if efFromTimeCheck
          then CreateVar('FromDateTime', DateTimeToStr(efFromDateValue+efFromTimeValue))
          else CreateVar('FromDateTime', DateTimeToStr(efFromDateValue));
        if efFromDateCheck then
          if efFromTimeCheck
            then AddEventDetail('Время начала: '+DateTimeToStr(efFromDateValue+efFromTimeValue))
            else AddEventDetail('Время начала: '+DateTimeToStr(efFromDateValue));
        CreateVar('ToDateCheck'      , efToDateCheck);
        if efFromTimeCheck
          then CreateVar('ToDateTime'  , DateTimeToStr(efToDateValue+efToTimeValue))
          else CreateVar('ToDateTime'  , DateTimeToStr(efToDateValue));
        if efToDateCheck then
          if efToTimeCheck
            then AddEventDetail('Время окончания: '+DateTimeToStr(efToDateValue+efToTimeValue))
            else AddEventDetail('Время окончания: '+DateTimeToStr(efToDateValue));
        CreateVar('NotEventsExists'  , efNotEvents<>'');
        CreateVar('NotEvents'        , efNotEvents);
        if efNotEvents<>'' then AddEventDetail('Неучитывемые события:'#13#10+efNotEvents);
        CreateVar('NotObjectsExists' , efNotObjects<>'');
        CreateVar('NotObjects'       , efNotObjects);
        if efNotEvents<>'' then AddEventDetail('Неучитывемые объекты:'#13#10+efNotObjects);
      end;
      Event.SQL.Add('ORDER BY Event_ID');
      with TADOQuery.Create(nil) do
      try
        Connection := dmMain.dbMain;
        ParamCheck := False;
        SQL.Text := 'SELECT FAM, IM, OTCH FROM Users WHERE ID='+IntToStr(dmMain.dbMain.Tag);
        Open;
        CreateVar('CurrentUser', Fields[0].AsString+' '+
                            Copy(Fields[1].AsString,1,1)+'.'+
                            Copy(Fields[2].AsString,1,1)+'.');
      finally Free;
      end;
      if Length(EventDetail)=0 then AddEventDetail('Полный список, без фильтрации.');
      Event.Open; Detail.Open;
      try
        ExecuteOpen([Event,Detail],SW_SHOW);
        SaveEvent(dmMain.dbMain, evs_Report_Print, 'Журнал событий', EventDetail);
      except
        SaveEvent(dmMain.dbMain, evs_Report_Error, 'Журнал событий', EventDetail);
        MessageBox(0,
           PChar('Ошибка при выводе данных в MS-Word! Если, файл "'+OutFile+'" открыт, закройте его.'),
           'Печать журнала событий',MB_OK or MB_ICONERROR);
      end;
    end;
  finally Free;
  end;
end;

procedure TdmEventListPrint.EkUDFList1Functions0Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
var B: Boolean;
begin
  B := False;
  if Args[0] is TField then B:=Boolean(TField(Args[0]).AsInteger);
  if Args[0] is TEkReportVariable then B:=Boolean(TEkReportVariable(Args[0]).AsInteger);
  With UDFResult as TEkReportVariable do AsBoolean := B;
end;

end.

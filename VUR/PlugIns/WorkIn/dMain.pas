unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  EkRtf, Db, ADODB, ekbasereport, ekfunc, DateUtils;

type
  TdmMain = class(TDataModule)
    EkRTF1: TEkRTF;
    dbMain: TADOConnection;
    qrPerson: TADOQuery;
    qrFamily: TADOQuery;
    qrOrg: TADOQuery;
    qrOrgCont: TADOQuery;
    qrReportType: TADOQuery;
    EkUDFList1: TEkUDFList;
    qrPersonSQL: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1NotIsNullCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1EqualCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1dateCalculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions3Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    { Private declarations }
    function DateToStrDoc(d: TDateTime): String;
    procedure FillExecutor;
  public
    { Public declarations }
    function OpenData(ID: Integer): boolean;
    function PrintData(nType: Integer; UseSend_Date, UseReason: Boolean; Send_Date: TDateTime; Reason: string; bLabel: Boolean): boolean;
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Листок-сообщение в ОВК';

implementation

{$R *.DFM}

uses SaveEvents, IniSupport, StrUtils;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
end;

procedure TdmMain.EkUDFList1EqualCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
  function GetInt(O: TObject): Integer;
  begin
    if O is TField then Result := TField(O).AsInteger else Result := TEkReportVariable(O).AsInteger;
  end;
var
  i: Integer;
begin
  (UDFResult as TEkReportVariable).AsBoolean := False;
  for i:=1 to ArgCount-1 do
    if GetInt(Args[0])=GetInt(Args[i]) then
    begin
      (UDFResult as TEkReportVariable).AsBoolean := True;
      Exit;
    end;
end;

procedure TdmMain.EkUDFList1Functions3Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
  function ToString(O: TObject): string;
  begin
    if O is TField then Result := TField(O).AsString
    else Result := TEkReportVariable(O).AsString;
  end;
var res: string;
begin
  res :=
    (ToString(Args[0])+' ')[1] + '. ' +
    (ToString(Args[1])+' ')[1] + '. ' +
    ToString(Args[2]);
  (UDFResult as TEkReportVariable).AsString := res;
end;

function TdmMain.DateToStrDoc(d: TDateTime): String;
  function GetMonth(n: Integer): String;
  begin
    case n of
      1: Result := 'января';
      2: Result := 'февраля';
      3: Result := 'марта';
      4: Result := 'апреля';
      5: Result := 'мая';
      6: Result := 'июня';
      7: Result := 'июля';
      8: Result := 'августа';
      9: Result := 'сентября';
      10: Result := 'октября';
      11: Result := 'ноября';
      12: Result := 'декабря';
    end;
  end;
begin
  Result := '« '+IntToStr(DayOf(d))+' » '+GetMonth(MonthOf(d))+' '+IntToStr(YearOf(d))+' г.';
end;

procedure TdmMain.EkUDFList1dateCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  (UDFResult as TEkReportVariable).AsString := FormatDateTime('dd.mm.yyyy',Date)
end;

procedure TdmMain.EkUDFList1NotIsNullCalculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
var
  I: integer;
  B: boolean;
begin
  B := True;
  for I := 0 to Length(Args)-1 do B := B and not (TField(Args[I]).IsNull or (TField(Args[I]).AsString=''));
  (UDFResult as TEkReportVariable).AsBoolean := B;end;

function TdmMain.OpenData(ID: Integer): boolean;
var i: Integer;
  IsJet: Boolean;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  if not IsJet then begin
    qrPerson.SQL.Text := qrPersonSQL.SQL.Text;
  end;

  try
    qrPerson.Parameters.ParamByName('PERS_ID').Value := ID;
    qrPerson.Open;
    qrFamily.Parameters.ParamByName('PERS_ID').Value := ID;
    qrFamily.Open;
    for i:=0 to ComponentCount-1 do
      if Components[i] is TADOQuery then
        if not (Components[i] as TADOQuery).Active then
          (Components[i] as TADOQuery).Open;
    Result := true;
  except
    Result := false;
  end;
end;

function TdmMain.PrintData(nType: Integer; UseSend_Date, UseReason: Boolean; Send_Date: TDateTime; Reason: string; bLabel: Boolean): boolean;
const
  sAbout: array[0..5] of String = ('о приеме на работу',
                                   'об изменениях',
                                   'об уходе учащегося в академический отпуск',
                                   'об окончании академического отпуска',
                                   'об обучении на военной кафедре',
                                   'об увольнении');
  sReportTypeSQL: array[0..5] of String = (
      'select NULL as REPORT_TYPE from Person where 1=0',
      'select NULL as REPORT_TYPE from Person where 1=0',
      'select NULL as REPORT_TYPE from Person where 1=0',
      'select NULL as REPORT_TYPE from Person where 1=0',
      'select NULL as REPORT_TYPE from Person where 1=0',
      'select ''Уволен (приказ и дата)'' as REPORT_TYPE');
var
  s: string;
  sType, sLabel: String;
begin
  try
    sType  := sAbout[nType];
    sLabel := IfThen(bLabel,'да','нет');

    case nType of
      0,1,5: EkRTF1.Infile  := GetTemplatesDir + IfThen(bLabel, 'workin2.rtf', 'workin.rtf');
      2: EkRTF1.Infile  := GetTemplatesDir + IfThen(bLabel, 'BeginAkadem2.rtf', 'BeginAkadem.rtf');
      3: EkRTF1.Infile  := GetTemplatesDir + IfThen(bLabel, 'EndAkadem2.rtf', 'EndAkadem.rtf');
      4: EkRTF1.Infile  := GetTemplatesDir + IfThen(bLabel, 'StudyInProcess2.rtf', 'StudyInProcess.rtf');
    end;
    EkRTF1.OutFile := GetReportsDir + '\Сообщение '+sType+IfThen(bLabel,' (талон)','')+' - '+
      qrPerson.FieldByName('Fam').AsString+' '+
      qrPerson.FieldByName('Im').AsString+' '+
      qrPerson.FieldByName('Otch').AsString+'.rtf';

    s   := sType;
    if not qrPerson.FieldByName('IsAspirant').IsNull then begin
      if (nType = 0) then s := 'о поступлении';
      if (nType = 5) then begin
        s := 'об отчислении';
        sReportTypeSQL[5] := 'select ''Отчислен (приказ и дата)'' as REPORT_TYPE';
      end;
    end;
    if nType=1 then
      s := s + ' сведений о гражданине, ' +
      IfThen(qrPerson.FieldByName('STATE').AsString='0','подлeжащем призыву','пребывающем в запасе');
    EkRTF1.CreateVar('REPORT_TITLE',s+':');

    if qrOrgCont.Locate('IS_VUS',1,[]) then begin
      EkRTF1.CreateVar('VUR_PHONE',qrOrgCont.FieldByName('PHONE').AsString);
      EkRTF1.CreateVar('VUR_POST',qrOrgCont.FieldByName('POST').AsString);
      s := IfThen(qrOrgCont.FieldByName('IM').AsString<>'',
             LeftStr(qrOrgCont.FieldByName('IM').AsString,1)+'.','')+
           IfThen(qrOrgCont.FieldByName('OTCH').AsString<>'',
             LeftStr(qrOrgCont.FieldByName('OTCH').AsString,1)+'.','')+
           ' '+qrOrgCont.FieldByName('FAM').AsString;
      EkRTF1.CreateVar('VUR_NAME',s);
    end;
    if qrOrgCont.Locate('IS_GEN',1,[]) then begin
      EkRTF1.CreateVar('GEN_POST',qrOrgCont.FieldByName('POST').AsString);
      s := IfThen(qrOrgCont.FieldByName('IM').AsString<>'',
             LeftStr(qrOrgCont.FieldByName('IM').AsString,1)+'.','')+
           IfThen(qrOrgCont.FieldByName('OTCH').AsString<>'',
             LeftStr(qrOrgCont.FieldByName('OTCH').AsString,1)+'.','')+
           ' '+qrOrgCont.FieldByName('FAM').AsString;
      EkRTF1.CreateVar('GEN_NAME',s);
    end;

    if qrPerson.FieldByName('STATE').AsString='0' then begin
      EkRTF1.CreateVar('MAN_TYPE1','подлежащем призыву');
      EkRTF1.CreateVar('MAN_TYPE2','подлежащего призыву');
    end
    else begin
      EkRTF1.CreateVar('MAN_TYPE1','пребывающем в запасе');
      EkRTF1.CreateVar('MAN_TYPE2','пребывающего в запасе');
    end;

    qrReportType.Close;
    qrReportType.SQL.Text := sReportTypeSQL[nType];
    qrReportType.Open;

    case nType of
      5:
        if (not qrPerson.FieldByName('IsAspirant').IsNull) then
          s := qrPerson.FieldByName('Dismissal_date').AsString +
              '(№ '+qrPerson.FieldByName('OrderDismissal').AsString+
              ' от '+qrPerson.FieldByName('OrderDismissal_date').AsString+')'
        else s := qrPerson.FieldByName('OUT_DATE').AsString+
              '(№ '+qrPerson.FieldByName('OUT_ORD_NUMB').AsString+
              ' от '+qrPerson.FieldByName('OUT_ORD_DATE').AsString+')';
    else
      s := EmptyStr;
    end;
    EkRTF1.CreateVar('REPORT_ORDER',s);

    with TADOQuery.Create(Self) do
    try
      Connection := dbMain;
      SQL.Text :=
        'select OutNumber, OutDate from personchanges pc '+
        'where pc.Pers_Id = :Pers_ID and pc.OutNumber <> '''' and not exists ( '+
        '      select 1 from personchanges pcc where pcc.OutNumber <> '''' and pc.Pers_id = pcc.Pers_id and pc.OutDate < pcc.OutDate) ';
      Parameters.ParseSQL(SQL.Text, True);
      Parameters.ParamByName('Pers_ID').Value := qrPerson.Parameters.ParamByName('PERS_ID').Value;
      Open;
      if Eof then begin
        EkRTF1.CreateVar('OutNumber','          ');
        EkRTF1.CreateVar('OutDate','«      »                     20     г.');
      end else begin
        EkRTF1.CreateVar('OutNumber',Fields[0].AsString);
        EkRTF1.CreateVar('OutDate',DateToStrDoc(Fields[1].AsDateTime));
      end;
    finally
      Free;
    end;

    FillExecutor;

    EkRTF1.ExecuteOpen([qrPerson,qrFamily,qrOrg,qrReportType],SW_SHOWDEFAULT);
    SaveEvent(dbMain, evs_Report_Print, sEventObject,
      ['Номер сотрудника: '+IntToStr(qrPerson.Parameters.ParamByName('PERS_ID').Value),
       'Тип: '+sType,
       'Наличие талона: '+sLabel]);

    if UseSend_Date or UseReason then
    with TADOQuery.Create(Self) do
    try
      Connection := dbMain;
      if UseSend_Date then
        SQL.Text := 'update PersonChanges'#13 +
                    'set Begin_Date = :Param'#13 +
                    'where Pers_ID = :Pers_ID and Begin_Date is null and NotBeginReason is null'
      else
        SQL.Text := 'update PersonChanges'#13 +
                    'set NotBeginReason = :Param'#13 +
                    'where Pers_ID = :Pers_ID and Begin_Date is null and NotBeginReason is null';
      Parameters.ParseSQL(SQL.Text, True);
      if UseSend_Date then Parameters.ParamByName('Param').Value := Send_Date
      else Parameters.ParamByName('Param').Value := Reason;
      Parameters.ParamByName('Pers_ID').Value := qrPerson.Parameters.ParamByName('PERS_ID').Value;
      ExecSQL;
    finally
      Free;
    end;
    Result := true;
  except on e: Exception do begin
    Result := false;
  end end;
end;

procedure TdmMain.FillExecutor;
var
  qrExecutor: TADOQuery;
begin
  qrExecutor := TADOQuery.Create(Self);
  qrExecutor.Connection := dmMain.dbMain;
  qrExecutor.SQL.Text := 'Select * from ORG_Cont where Is_Gen = 3';
  qrExecutor.Open;
  if qrExecutor.Eof then begin
    EkRtf1.CreateVar('ExecutorFam', '');
    EkRtf1.CreateVar('ExecutorIm', '');
    EkRtf1.CreateVar('ExecutorOtch', '');
    EkRtf1.CreateVar('ExecutorPhone', '');
    EkRtf1.CreateVar('ExecutorPost', '');
  end else begin
    EkRtf1.CreateVar('ExecutorFam', qrExecutor.FieldByName('Fam').AsString);
    EkRtf1.CreateVar('ExecutorIm', qrExecutor.FieldByName('Im').AsString);
    EkRtf1.CreateVar('ExecutorOtch', qrExecutor.FieldByName('Otch').AsString);
    EkRtf1.CreateVar('ExecutorPhone', qrExecutor.FieldByName('Phone').AsString);
    EkRtf1.CreateVar('ExecutorPost', qrExecutor.FieldByName('Post').AsString);
  end;
  qrExecutor.Close;
end;


end.

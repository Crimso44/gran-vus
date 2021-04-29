unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, Variants, ekfunc;

type
  ColumnValues = array[1..15] of Integer;

  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    ImageList: TImageList;
    ReportQuery: TADOQuery;
    OrgQuery: TADOQuery;
    EkUDFList1: TEkUDFList;
    qrDep: TADOQuery;
    qrExecutor: TADOQuery;
    qrExecutorCONTID: TIntegerField;
    qrExecutorORGID: TIntegerField;
    qrExecutorDEPART: TWideStringField;
    qrExecutorPOST: TWideStringField;
    qrExecutorFIO: TWideStringField;
    qrExecutorPHONE: TWideStringField;
    qrExecutorFAX: TWideStringField;
    qrExecutorEMAIL: TWideStringField;
    qrExecutorIS_GEN: TSmallintField;
    qrExecutorIS_VUS: TSmallintField;
    qrExecutorFAM: TWideStringField;
    qrExecutorIM: TWideStringField;
    qrExecutorOTCH: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure EkUDFList1Functions0Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
    procedure EkUDFList1Functions1Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
    procedure EkUDFList1Functions2Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    procedure FillExecutor;
  public
    NoBronMode: Boolean;
    OrgName: String;
    IsJet: Boolean;
    ListOVK: TStringList;
    procedure Init;
    procedure PrintActionExecute(Sender: TObject);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Ведомость на выдачу удостоверений (Форма № 9)';

implementation

uses IniSupport, SaveEvents, msg, BirthDay;

{$R *.DFM}

{ TdmMain }

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  ListOVK := TStringList.Create;
  if dbMain.Connected then ShowMessage('Close default connection!');
  EkRTF1.Infile := GetTemplatesDir + 'Form9.rtf';
  EkRTF1.Outfile := GetReportsDir + 'Ведомость на выдачу удостоверений.rtf';
end;


procedure TdmMain.DataModuleDestroy(Sender: TObject);
begin
  ListOVK.Free;
end;

procedure TdmMain.EkRTF1ScanRecord(ScanInfo: TEkScanInfo);
begin
  if ScanInfo.DataSet=qrDep then begin
    ReportQuery.Close;
    ReportQuery.Parameters.ParamByName('Dep_ID').Value :=
      qrDep.FieldByName('Dep_ID').AsInteger;
    ReportQuery.Open;
  end;
end;

procedure TdmMain.EkUDFList1Functions0Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
begin
  With UDFResult as TEkReportVariable do AsInteger := ReportQuery.RecNo;
end;

procedure TdmMain.EkUDFList1Functions1Calculate(Sender: TObject;
  Args: TEkUDFArgs; ArgCount: Integer; UDFResult: TObject);
function CheckNull(O: TObject): Boolean;
begin
  if O is TField then Result := TField(O).IsNull or (TField(O).AsString='')
  else Result := Trim(TEkReportVariable(O).AsString) <> '';
end;
var
  I: integer;
  B: boolean;
begin
  B := True;
  for I := 0 to Length(Args)-1 do B := B and not CheckNull(Args[I]);
  (UDFResult as TEkReportVariable).AsBoolean := B;
end;

procedure TdmMain.EkUDFList1Functions2Calculate(Sender: TObject;
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

procedure TdmMain.Init;
begin
  IsJet := false;
  if Pos(WideString('Provider=Microsoft.Jet'), dbMain.ConnectionString) > 0 then
    IsJet := true;

  if not IsJet then
    ReportQuery.SQL.Text := StringReplace(ReportQuery.SQL.Text, 'Date()', 'GetDate()', [rfReplaceAll]);

    if ListOVK.Count > 0 then begin
      qrDep.SQL.Text :=
        'SELECT DEP_ID, IIF((DEP_FULL_NAME is null) OR DEP_FULL_NAME='''', DEP_NAME, DEP_FULL_NAME) as Dep_NAME_X '+
        'FROM KDepart'#13+
        'WHERE DEP_ID in ('+ListOVK.CommaText+')';
    end else begin
      qrDep.SQL.Text :=
        'SELECT DEP_ID, IIF((DEP_FULL_NAME is null) OR DEP_FULL_NAME='''', DEP_NAME, DEP_FULL_NAME) as Dep_NAME_X '+
        'FROM KDepart'#13+
        'WHERE EXISTS('#13+
        'SELECT * FROM ((((PERSON p'#13+
        ' left outer join [KWRange] on p.WRng_Id=[KWRange].WRng_Id)'#13+
        ' left outer join Appointment As AppointmentFirst on p.AppLast=AppointmentFirst.Id)'#13+
        ' left outer join Appointment As AppointmentFirstStudy on p.AppFirstStudy=AppointmentFirstStudy.Id)'#13+
        ' left outer join Appointment As AppointmentLastAll on p.AppLastAll=AppointmentLastAll.Id)'#13+
        'where AppointmentLastAll.Dep_Id = KDepart.Dep_Id'#13+
        'and p.WUchet2_IsWork = 1'#13+
        'and (p.Out_Date is null or p.Out_Date > Date() or ((p.Dismissal_Date is null or p.Dismissal_Date > Date() or AppointmentFirstStudy.In_Date is null) and AppointmentFirstStudy.In_Date is not null))'#13+
        'and (p.Out_Date is null or p.Out_Date > Date() or ((p.Dismissal_Date is null or p.Dismissal_Date > Date() or AppointmentFirst.In_Date is null) and AppointmentFirst.In_Date is not null))'#13+
        'and (p.W_DEnd is null or p.W_DEnd > Date())'#13+
        'and p.is_war = 1'#13+
        'and  IIF(p.W_DEND is NULL and ('#13+
        '         (p.MALE=1 and ([KWRANGE].M_LIMIT is not NULL) and  ('+FullAges('p.BIRTHDAY')+')>[KWRANGE].M_LIMIT  ) or'#13+
        '         (p.MALE=0 and ([KWRANGE].FEM_LIMIT is not NULL) and  ('+FullAges('p.BIRTHDAY')+')>[KWRANGE].FEM_LIMIT  ))'#13+
        '        ,1,0) = 0'#13+
        ') ORDER BY Dep_NAME';
    end;


    with TADOQuery.Create(nil) do
    try
      Connection := dbMain;
      SQL.Text := 'select COUNT(*) from PERS_SET';
      Open;
      if Fields[0].AsInteger > 0 then
        ReportQuery.SQL.Text := StringReplace(ReportQuery.SQL.Text,'/*PERS_SET*/',
          'and (P.PERS_ID in (select PERS_ID from PERS_SET))', [])
      else
        ReportQuery.SQL.Text := StringReplace(ReportQuery.SQL.Text,'/*PERS_SET*/',
          '', []);
      Close;
    finally Free;
    end;




  ReportQuery.SQL.Text := ReplaceFullAges(ReportQuery.SQL.Text);
  //ReportQuery.Open;
end;




procedure TdmMain.PrintActionExecute(Sender: TObject);
var OrgID: String; //for SaveEvent
begin
  {if not Boolean(dmMain.Form6HdrQuery.FieldByName('CHECKED').Value) and
     not Confirm('Форма не проверена! Игнорировать?')
  then
    Exit;}

  ORGQuery.Open;
  NoBronMode := not ORGQuery.FieldByName('HAS_BRON').AsBoolean;
  OrgName := ORGQuery.FieldByName('OrgName').AsString;
  if OrgName = '' then
    OrgName := ORGQuery.FieldByName('OrgSName').AsString;
  OrgName := StringReplace(OrgName, #13, ' ', [rfReplaceAll]);
  ORGQuery.Close;
  if NoBronMode then begin
    ShowErr('Ваша организация не ведет бронирование. Обращение к данной форме не правомерно.');
    Exit;
  end;
  try
    try
      qrDep.Open;
      dmMain.ReportQuery.SQL.Text := ReplaceFullAges(dmMain.ReportQuery.SQL.Text);
      dmMain.ReportQuery.Open;
      dmMain.EkRTF1.ClearVars;
      dmMain.EkRTF1.CreateVar('OrgName',OrgName);
      FillExecutor;
      dmMain.EkRTF1.ExecuteOpen(
        [dmMain.ReportQuery, dmMain.qrDep], SW_SHOWDEFAULT);
      SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,
        ['Номер организации: '+OrgID]);
    finally
      dmMain.ReportQuery.Close;
    end;
  except on e:Exception do begin
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...'#13+e.Message);
  end;
  end;
end;


procedure TdmMain.FillExecutor;
begin
  qrExecutor.Open;
  if qrExecutor.Eof then begin
    EkRtf1.CreateVar('ExecutorFam', '');
    EkRtf1.CreateVar('ExecutorIm', '');
    EkRtf1.CreateVar('ExecutorOtch', '');
    EkRtf1.CreateVar('ExecutorPhone', '');
    EkRtf1.CreateVar('ExecutorPost', '');
  end else begin
    EkRtf1.CreateVar('ExecutorFam', qrExecutorFam.AsString);
    EkRtf1.CreateVar('ExecutorIm', qrExecutorIm.AsString);
    EkRtf1.CreateVar('ExecutorOtch', qrExecutorOtch.AsString);
    EkRtf1.CreateVar('ExecutorPhone', qrExecutorPhone.AsString);
    EkRtf1.CreateVar('ExecutorPost', qrExecutorPost.AsString);
  end;
  qrExecutor.Close;
end;

end.


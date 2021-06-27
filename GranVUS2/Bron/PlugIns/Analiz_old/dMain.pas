unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, Variants, StrUtils, DateUtils;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    Form6HdrQuery: TADOQuery;
    ImageList: TImageList;
    ReportQuery: TADOQuery;
    ReportQueryCPROF_ID: TIntegerField;
    ReportQueryF6_ID: TIntegerField;
    ReportQueryPRINT_NAME: TStringField;
    ReportQueryEXPRESSION: TStringField;
    ReportQueryCALCULATE: TIntegerField;
    ReportQueryCOL_B: TIntegerField;
    ReportQueryCOL_1: TIntegerField;
    ReportQueryCOL_2: TIntegerField;
    ReportQueryCOL_3: TIntegerField;
    ReportQueryCOL_4: TIntegerField;
    ReportQueryCOL_5: TIntegerField;
    ReportQueryCOL_6: TIntegerField;
    ReportQueryCOL_7: TIntegerField;
    ReportQueryCOL_8: TIntegerField;
    ReportQueryCOL_9: TIntegerField;
    ReportQueryCOL_10: TIntegerField;
    ReportQueryCOL_11: TIntegerField;
    ReportQueryCOL_12: TIntegerField;
    ReportQueryCOL_13: TIntegerField;
    ReportQueryCOL_14: TIntegerField;
    ReportQueryCOL_15: TIntegerField;
    ReportQueryCOL_16: TStringField;
    ReportQueryCOL_17: TIntegerField;
    ReportQueryCOL_10T: TStringField;
    ReportQueryCOL_12T: TStringField;
    ReportQueryCOL_1_10: TIntegerField;
    ReportQueryCOL_1_10_12: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure ReportQueryCalcFields(DataSet: TDataSet);
  private
  public
    SUBJ_ID: Integer;
    procedure Init;
    procedure PrintActionExecute(Sender: TObject);
  end;

  function ISNULL(v: variant; rv: variant) : variant;

var
  dmMain: TdmMain;

const
  sEventObject = 'Àíàëèç îáåñïå÷åííîñòè òğóäîâûìè ğåñóğñàìè';

implementation

uses IniSupport, SaveEvents, msg, RDialogs;

{$R *.DFM}

{ TdmMain }

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
end;

function ISNULL(v: variant; rv: variant) : variant;
begin
  if VarIsNull(v) then Result:=rv else Result:=v;
end;


procedure TdmMain.Init;
begin
  Form6HdrQuery.Parameters.ParamValues['Subj_ID']:= Subj_ID;
  ReportQuery.Parameters.ParamValues['Subj_ID']:= Subj_ID;
end;

function NULLIF(Value1,Value2: Variant): Variant;
begin
  if Value1=Value2 then Result := NULL else Result := Value1;
end;

procedure TdmMain.ReportQueryCalcFields(DataSet: TDataSet);
begin
  ReportQuery.FieldByName('COL_17').Value :=
     NULLIF(ReportQueryCOL_2.AsInteger
            - ReportQueryCOL_7.AsInteger
            - ReportQueryCOL_14.AsInteger,0);
  ReportQueryCol_1_10.AsInteger := ReportQueryCol_1.AsInteger - ReportQueryCol_10.AsInteger;
  ReportQueryCol_1_10_12.AsInteger := ReportQueryCol_1_10.AsInteger - ReportQueryCol_12.AsInteger;
end;

procedure TdmMain.PrintActionExecute(Sender: TObject);
var OrgID, SubjID: String; //for SaveEvent and GetReportDate
//
  function GetReportDate: String;
  var
    y: Integer;
    AfterNY: Boolean;
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'select * from curr_subj';
      Open;
      if Fields[0].AsString = SubjID
        then AfterNY := GetMainVUOAfterNY
        else AfterNY := GetVUOAfterNY;
      Close;
      SQL.Text := 'SELECT REPORT_DATE FROM SUBJ WHERE SUBJ_ID='+SubjID;
      Open;
      Y := YearOf(Fields[0].AsDateTime);
      if Fields[0].IsNull
        then Result := ''
        else Result := IntToStr(Y-Byte(AfterNY));
    finally Free;
    end;
  end;
//
  type TPerson = record Post, FIO: String end;
  function GetPerson: TPerson;
  var I,O: Integer;
  begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT POSITION_NAME, FIO FROM SUBJ_INFO WHERE SUBJ_INFO_ID = 1 and SUBJ_ID='+SubjID;
      Open;
      with Result do begin
        POST := Fields[0].AsString;
        FIO := Fields[1].AsString;
        I := Pos(' ',FIO);
        if I>0 then O := PosEx(' ',FIO,I+1) else O := 0;
        if (O>0) and (O<Length(FIO)) then
          FIO := LeftStr(FIO, I+1)+'.'+FIO[O+1]+'.';
      end;
    finally Free;
    end;
  end;
//
const
  AnInFile: String = 'Analiz.rtf';
  AnOutFile: String = 'Àíàëèç îáåñïå÷åííîñòè òğóäîâûìè ğåñóğñàìè.rtf';
var
  s: String;
  res: Integer;
begin
  SubjID := IntToStr(dmMain.SUBJ_ID);
  {if not Boolean(dmMain.Form6HdrQuery.FieldByName('CHECKED').Value) and
     not Confirm('Ôîğìà íå ïğîâåğåíà! Èãíîğèğîâàòü?')
  then
    Exit;}

  try
    try
      dmMain.EkRTF1.CreateVar('REPORT_DATE', GetReportDate);
      dmMain.EkRTF1.CreateVar('Year', GetReportDate);
      dmMain.EkRTF1.CreateVar('CurDate',SysUtils.FormatDateTime('dd.mm.yyyy', Date));
      with GetPerson do begin
        dmMain.EkRTF1.CreateVar('GenPOST', POST);
        dmMain.EkRTF1.CreateVar('GenIOFam', FIO);
      end;
      with TADOQuery.Create(Self) do
      try
        Connection := dmMain.dbMain;
        SQL.Text := 'SELECT * '+
          'FROM FORM6 f '+
          'join Form6Hdr h on f.f6_id = h.f6_id '+
          'WHERE h.Subj_ID = '+IntToStr(Subj_ID)+' and f.CPROF_ID = 2000 '+
          'and h.f6_shifr = ''01''';
        Open;
        if FieldByName('COL_12').AsInteger = 0 then
          dmMain.EkRTF1.CreateVar('Perc',0)
        else
          dmMain.EkRTF1.CreateVar('Perc',Round(100*
            (1.0*(FieldByName('COL_1').AsInteger - FieldByName('COL_10').AsInteger)) /
              FieldByName('COL_12').AsInteger));
      finally
        Free;
      end;
      dmMain.ReportQuery.Open;
      dmMain.Form6HdrQuery.Open;
      dmMain.EkRTF1.Infile := GetTemplatesDir + AnInFile;
      dmMain.EkRTF1.Outfile := GetReportsDir + AnOutFile;
      dmMain.EkRTF1.ExecuteOpen(
        [dmMain.ReportQuery, dmMain.Form6HdrQuery], SW_SHOWDEFAULT);
    finally
      dmMain.ReportQuery.Close;
      dmMain.Form6HdrQuery.Close;
    end;
  except on e: Exception do begin
    RMessageDlg('Îøèáêà ïğè ñîçäàíèè îò÷åòà!'+#13+
      'Âîçìîæíî íåâåğíî óêàçàíû ğàáî÷èå ïàïêè '+#13+
      'èëè øàáëîí îò÷åòà èñïîëüçóåòñÿ äğóãîé ïğîãğàììîé...'#13#13+
      e.Message,
      mtError, [mbOk], 0);
    end;
  end;
end;


end.


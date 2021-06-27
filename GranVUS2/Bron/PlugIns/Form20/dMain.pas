unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport, ekfunc;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    ImageList: TImageList;
    qrDataFull: TADOQuery;
    qrOKATO: TADOQuery;
    qrSubj: TADOQuery;
    qrOSN: TADOQuery;
    EkUDFList1: TEkUDFList;
    procedure DataModuleCreate(Sender: TObject);
    procedure qrDataFullCalcFields(DataSet: TDataSet);
    procedure qrOKATOAfterScroll(DataSet: TDataSet);
    procedure qrDataFullAfterScroll(DataSet: TDataSet);
    procedure EkUDFList1Functions0Calculate(Sender: TObject; Args: TEkUDFArgs;
      ArgCount: Integer; UDFResult: TObject);
  private
    FPrinting: Boolean;
  public
    tlPath: string;
    repPath: string;
    x, xaddr: String;
    procedure PrintData(FilterType: SmallInt; FilterType2: SmallInt; FilterType3: SmallInt; addr: String; regions: TStringList);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Форма № 20';

implementation

{$R *.DFM}

uses IniSupport, SaveEvents, msg, StrUtils, Math;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  tlPath := GetTemplatesDir;
  repPath := GetReportsDir;
end;

procedure TdmMain.EkUDFList1Functions0Calculate(Sender: TObject;
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

procedure TdmMain.PrintData(FilterType: SmallInt; FilterType2: SmallInt; FilterType3: SmallInt; addr: String; regions: TStringList);
var
  i: Integer;
  s: String;
begin
  try
    EkRTF1.ClearVars;
    with TADOQuery.Create(Self) do try
      Connection := dbMain;
      SQL.Text := 'SELECT SUBJ_FULLNAME FROM SUBJ JOIN CURR_SUBJ ON SUBJ.SUBJ_ID = CURR_SUBJ.SUBJ_ID';
      Open;
      EkRTF1.CreateVar('SUBJ_FULLNAME', FieldByName('SUBJ_FULLNAME').AsString);
    finally
      Free;
    end;

    xaddr := addr;

      try
        FPrinting:= False;
        EkRTF1.Infile := tlPath + 'form20.rtf';
        EkRTF1.Outfile := repPath + 'Форма № 20.rtf';
        qrDataFull.Close;
        case FilterType of
          1: begin
               qrDataFull.SQL.Add('AND (SELECT KODTERR FROM KTERR WHERE TERR_ID=O.TERR_ID) LIKE ');
               qrDataFull.SQL.Add(
                  '(select dbo.GetSubjMask(KTERR.KODTERR)'#13+
                  'from CURR_SUBJ'#13+
                  'join SUBJ ON CURR_SUBJ.SUBJ_ID=SUBJ.SUBJ_ID'#13+
                  'join KTERR ON SUBJ.TERR_ID=KTERR.TERR_ID)');
             end;
          2: qrDataFull.SQL.Add('AND O.ORGID IN (SELECT ORGID FROM ORGSET)');
        end;
        case FilterType2 of
          0: if Trim(addr) <> '' then
              qrDataFull.SQL.Add('AND O.URADDR Like ''%'+StringReplace(addr, '''','"',[rfReplaceAll])+'%''');
          1: begin
            if Trim(addr) <> '' then
              qrDataFull.SQL.Add('AND O.FIZADDR Like ''%'+StringReplace(addr, '''','"',[rfReplaceAll])+'%''');
            qrDataFull.SQL.Text := StringReplace(qrDataFull.SQL.Text, 'substring(O.KodReg,1,2)', 'substring(O.Okato2,1,2)', [rfReplaceAll]);
          end;
        end;
        case FilterType3 of
          1: begin
            s := '';
            for i := 0 to regions.Count - 1 do
              s := s + '''' + regions[i] + ''',';
            if s <> '' then begin
              s := Copy(s, 1, Length(s)-1);
              if FilterType2 = 0 then
                qrDataFull.SQL.Add(
                  'AND Substring(O.KODREG, 1, 2) in (' + s + ') ')
              else begin
                qrDataFull.SQL.Add(
                  'AND Substring(O.OKATO2, 1, 2) in (' + s + ') ');
              end;
            end;
          end;
        end;
        qrDataFull.SQL.Add('ORDER BY KTerr.KodTerr, ORGNAME');
        s := ''; i := -1;
        x := 'qrDataFull.Open';
        qrDataFull.Open;
        x := '';
        while not qrDataFull.Eof do begin

          if i <> qrDataFull.FieldByName('KTerr_Id').AsInteger then begin
            i := qrDataFull.FieldByName('KTerr_Id').AsInteger;
            s := s + IntToStr(i) + ',';
          end;

          qrDataFull.Next;
        end;
        qrDataFull.Close;
        if s <> '' then begin
          s := Copy(s, 1, Length(s)-1);
          qrOkato.SQL.Add('where Terr_Id in ('+s+')')
        end else
          qrOkato.SQL.Add('where 1=2');
        qrDataFull.SQL.Insert(qrDataFull.SQL.Count-1,' and KTerr.KodTerr = :KodTerr');
        x := 'qrOkato.Open';
        qrOkato.Open;
        x := 'qrSubj.Open';
        qrSubj.Open;
        x := '';
        FPrinting:= True;
        EkRTF1.ExecuteOpen([qrDataFull, qrOkato, qrSubj, qrOsn],SW_SHOWDEFAULT);
        SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,[]);
      finally
        FPrinting:= False;
        qrOkato.Close;
        qrDataFull.Close;
        qrSubj.Close;
      end
  except on e: Exception do begin
    if x = 'qrDataFull.Open' then begin
      ShowErr('Организации с указанным адресом в картотеке отсутствуют');
    end else begin
      ShowErr('Ошибка при создании отчета!'+#13+
        'Возможно неверно указаны рабочие папки '+#13+
        'или шаблон отчета используется другой программой...');
      //#13 + E.Message + #13 + x + #13 + xaddr + #13 + qrDataFull.SQL.Text);
      SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
        ['Ошибка при создании отчета.']);
    end;
  end end;
end;

procedure TdmMain.qrDataFullAfterScroll(DataSet: TDataSet);
begin
  qrOsn.Close;
  qrOsn.Parameters[0].Value := qrDataFull.FieldByName('OrgId').Value;
  x := 'qrOsn.Open';
  qrOsn.Open;
  x := '';
end;

procedure TdmMain.qrDataFullCalcFields(DataSet: TDataSet);
//
function ExcludeTrailingSemicolon(S: String): String;
begin
  S := Trim(S);
  if (S<>'') and (S[Length(S)]=';') then  SetLength(S, Length(S)-1);
  Result := S;
end;
//
begin
  if not FPrinting then Exit;

  if DataSet.RecNo <= 0
    then DataSet.FieldByName('ROW_NO').AsInteger:= 1
    else DataSet.FieldByName('ROW_NO').AsInteger:= DataSet.RecNo;

end;

procedure TdmMain.qrOKATOAfterScroll(DataSet: TDataSet);
begin
  qrDataFull.Close;
  qrDataFull.Parameters[0].Value := qrOKATO.FieldByName('KodTerr').AsString;
  x := 'qrDataFull.Open';
  qrDataFull.Open;
  x := '';
end;

end.


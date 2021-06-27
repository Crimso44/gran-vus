unit dMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, ADODB, EkRtf, ImgList, ekbasereport;

type
  TdmMain = class(TDataModule)
    dbMain: TADOConnection;
    EkRTF1: TEkRTF;
    qrInfo: TADOQuery;
    ImageList: TImageList;
    qrSubj: TADOQuery;
    qrParam: TADOQuery;
    qrData: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    FSubjID: Integer;
  public
    tlPath: string;
    repPath: string;
    function PrintData: Boolean;
    procedure InitData(ASubjID: Integer);
  end;

var
  dmMain: TdmMain;

const
  sEventObject = 'Информационная карта';

implementation

{$R *.DFM}

uses IniSupport, SaveEvents, msg;

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  if dbMain.Connected then ShowMessage('Close default connection!');
  tlPath := GetTemplatesDir;
  repPath := GetReportsDir;
end;

procedure TdmMain.InitData(ASubjID: Integer);
begin
  FSubjID := ASubjID;
  qrSubj.Parameters.ParamValues['SUBJ_ID']:= fSubjID;
  qrInfo.Parameters.ParamValues['SUBJ_ID']:= fSubjID;
  qrParam.Parameters.ParamValues['SUBJ_ID']:= fSubjID;
end;

function TdmMain.PrintData: Boolean;
//
  //a: Fam Im Otch->Fam I.O.;b: Fam I.O.->Fam I.O.
  function FIOtoIOFam(S: String): String;
  var
    I: Integer;
    State: (sFam, sIm, sSkip, sOtch);
    Fa,Im,Ot: String;
  begin
    Result := ''; Fa := ''; Im:= ''; Ot := '';
    State := sFam;
    for I := 1 to Length(S) do
    case State of
      sFam : if S[I]<>' ' then Fa := Fa+S[I] else State := sIm;
      sIm  : if S[I]<>' ' then begin Im := S[I]+'.'; State := sSkip; end;
      sSkip: if S[I] in [' ','.'] then State := sOtch;
      sOtch: if S[I]<>' ' then begin Ot := S[I]+'.'; Break end;
    end;
    Result := Im+Ot+' '+Fa;
  end;
//
var
  t: Integer;
  c: Integer;
begin
  try
    EkRTF1.Infile := tlPath + 'infocard.rtf';
    EkRTF1.Outfile := repPath + 'Информационная карта.rtf';

    EkRTF1.ClearVars;

    with qrSubj do begin
      Open;
      t:= FieldByName('TYPE_ID').Asinteger;
      EkRTF1.CreateVar('SUBJ_NAME', FieldByName('NAME').AsString);
      EkRTF1.CreateVar('SUBJ_ADDRESS', FieldByName('SUBJ_ADDRESS').AsString);
      Close;
    end;

    EkRTF1.Infile := tlPath + 'infocard.rtf';
    if t = 1 then begin
      //RTF1.Infile := tlPath + 'infocardrai.rtf';
      EkRTF1.Outfile := repPath + 'Информационная карта органа местного самоуправления.rtf';
      EkRTF1.CreateVar('SUBJ', 'муниципального образования');
      EkRTF1.CreateVar('SUBJ2', 'органа местного самоуправления');
    end else if t = 2 then begin
      //EkRTF1.Infile := tlPath + 'infocardokr.rtf';
      EkRTF1.Outfile := repPath + 'Информационная карта территориального органа исполнительной власти.rtf';
      EkRTF1.CreateVar('SUBJ', 'округа');
      EkRTF1.CreateVar('SUBJ2', 'территориального органа исполнительной власти');
    end else begin
      //EkRTF1.Infile := tlPath + 'infocardsub.rtf';
      EkRTF1.Outfile := repPath + 'Информационная карта субъекта Российской Федерации.rtf';
      EkRTF1.CreateVar('SUBJ', 'субъекта РФ');
      EkRTF1.CreateVar('SUBJ2', 'территориального органа исполнительной власти');
    end;

    EkRTF1.CreateVar('CURDATE', DateToStr(Date));

    with qrInfo do begin
      Open;
      while not EOF do begin
        c:= FieldByName('SUBJ_INFO_ID').AsInteger;
        if c = 1 then begin
          EkRTF1.CreateVar('OIV_NAME', FieldByName('ORG_NAME').AsString);
          EkRTF1.CreateVar('DIRECTOR_INFO', FieldByName('POSITION_NAME').AsString + ', ' + FieldByName('FIO').AsString);
          EkRTF1.CreateVar('DIRECTOR_FIO', FieldByName('FIO').AsString);
          EkRTF1.CreateVar('DIRECTOR_PHONE', FieldByName('PHONE').AsString);
        end else if c = 2 then begin
          EkRTF1.CreateVar('PRED_POS', FieldByName('POSITION_NAME').AsString);
          EkRTF1.CreateVar('PRED_FIO', FieldByName('FIO').AsString);
          EkRTF1.CreateVar('OBG_NAME', FieldByName('ORG_NAME').AsString);
          EkRTF1.CreateVar('PRED_INFO', FieldByName('POSITION_NAME').AsString + ', ' + FieldByName('FIO').AsString);
          EkRTF1.CreateVar('PRED_PHONE', FieldByName('PHONE').AsString);
          EkRTF1.CreateVar('PRED_POST', FieldByName('POSITION_NAME').AsString);
          EkRTF1.CreateVar('PRED_IOFam', FIOtoIOFam(FieldByName('FIO').AsString));
        end else if c = 3 then begin
          EkRTF1.CreateVar('MO_NAME', FieldByName('ORG_NAME').AsString);
          EkRTF1.CreateVar('NACH_INFO', FieldByName('POSITION_NAME').AsString + ', ' + FieldByName('FIO').AsString);
          EkRTF1.CreateVar('NACH_FIO', FieldByName('FIO').AsString);
          EkRTF1.CreateVar('NACH_PHONE', FieldByName('PHONE').AsString);
          EkRTF1.CreateVar('ZAM_INFO', FieldByName('POSITION_NAME2').AsString + ', ' + FieldByName('FIO2').AsString);
          EkRTF1.CreateVar('ZAM_FIO', FieldByName('FIO2').AsString);
          EkRTF1.CreateVar('ZAM_PHONE', FieldByName('PHONE2').AsString);
        end else if c = 4 then begin
          EkRTF1.CreateVar('PBG_NAME', FieldByName('ORG_NAME').AsString);
          EkRTF1.CreateVar('SECRET_INFO', FieldByName('POSITION_NAME').AsString + ', ' + FieldByName('FIO').AsString);
          EkRTF1.CreateVar('SECRET_PHONE', FieldByName('PHONE').AsString);
        end;
        Next;
      end;
      Close;
    end;

      qrData.Parameters.ParamByName('SUBJ_ID').Value := fSubjID;
      qrData.Open;
    qrParam.Open;

    EkRTF1.ExecuteOpen([qrParam, qrData],SW_SHOWDEFAULT);
    SaveEvent(dmMain.dbMain, evs_Report_Print, sEventObject,
      ['Номер организации: '+IntToStr(fSubjID)]);
    Result := true;
  except
    Result := false;
    SaveEvent(dmMain.dbMain, evs_Report_Error, sEventObject,
      ['Ошибка при создании отчета.']);
    ShowErr('Ошибка при создании отчета!'+#13+
      'Возможно неверно указаны рабочие папки '+#13+
      'или шаблон отчета используется другой программой...');
  end;
end;

end.


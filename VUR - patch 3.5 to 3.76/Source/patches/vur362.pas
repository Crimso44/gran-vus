unit vur362;

interface

  function Patch362_GetInfo: string;
  function Patch362_GetStepCount: Integer;
  procedure Patch362_Process;

implementation

uses Forms,MainForm,ADODb,SysUtils,StrUtils;

type
  tblKFSTATE=record
    FST_ID: Integer;
    FST_NAME: string;
    OKIN: string;
  end;
  tblKWSOST=record
    WSOST_ID: Integer;
    WSOST_NAME: string;
    STATE: Integer;
  end;
const
  arrKFSTATE: Array[1..6] of tblKFSTATE = (
    (FST_ID:1; FST_NAME:'Никогда не состоял (не состояла в браке)'; OKIN:'100001'),
    (FST_ID:2; FST_NAME:'Состоит в зарегистрированном браке'; OKIN:'100002'),
    (FST_ID:3; FST_NAME:'Состоит в незарегистрированном браке'; OKIN:'100003'),
    (FST_ID:4; FST_NAME:'Вдовец (вдова)'; OKIN:'100004'),
    (FST_ID:5; FST_NAME:'Разведен (разведена)'; OKIN:'100005'),
    (FST_ID:6; FST_NAME:'Разошелся (разошлась)'; OKIN:'100006') );
  arrKWSOST: Array[1..9] of tblKWSOST = (
    (WSOST_ID:1; WSOST_NAME:'СОЛДАТЫ (МАТРОСЫ)'; STATE:1),
    (WSOST_ID:2; WSOST_NAME:'СЕРЖАНТЫ (СТАРШИНЫ)'; STATE:2),
    (WSOST_ID:3; WSOST_NAME:'ПРАПОРЩИКИ (МИЧМАНЫ)'; STATE:2),
    (WSOST_ID:4; WSOST_NAME:'КОМАНДНЫЙ'; STATE:3),
    (WSOST_ID:5; WSOST_NAME:'ИНЖЕНЕРНЫЙ И ТЕХНИЧЕСКИЙ'; STATE:3),
    (WSOST_ID:7; WSOST_NAME:'ВОЕННО-ГУМАНИТАРНЫЙ И ПЕДАГОГИЧЕСКИЙ'; STATE:3),
    (WSOST_ID:9; WSOST_NAME:'ЮРИДИЧЕСКИЙ'; STATE:3),
    (WSOST_ID:10; WSOST_NAME:'МЕДИЦИНСКИЙ'; STATE:3),
    (WSOST_ID:11; WSOST_NAME:'ВЕТЕРИНАРНЫЙ'; STATE:3) );

  function Patch362_GetInfo: string;
begin
  Result :=
   'Версия 3.62:'#13+
   '  - обновлены классификаторы "Семейное положение" и "Военный состав (профиль)"'#13+
   '  - мелкие доработки отчета "Форма сверки данных с ОВК"';
end;

function Patch362_GetStepCount: Integer;
begin
  Result := 2;
end;

procedure Patch362_Process;
var n: Integer;
begin
  with TADOTable.Create(fmMain) do
  try
    Connection := fmMain.dbConn;
//1
    fmMain.lbProcState.Caption := 'Обновление классификатора "Семейное положение"..."';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    TableName := 'KFSTATE';
    Active := true;
    for n:=Low(arrKFSTATE) to High(arrKFSTATE) do begin
      if Locate('FST_ID',arrKFSTATE[n].FST_ID,[]) then
        Edit
      else begin
        Append;
        FieldByName('FST_ID').Value := arrKFSTATE[n].FST_ID;
      end;
      FieldByName('FST_NAME').Value := arrKFSTATE[n].FST_NAME;
      FieldByName('OKIN').Value := arrKFSTATE[n].OKIN;
      Post;
    end;
    Active := false;
    fmMain.pbMain.StepIt;
//2
    fmMain.lbProcState.Caption := 'Обновление классификатора "Военный состав (профиль)"..."';
    Application.ProcessMessages;
    if fmMain.FBreak then Exit;
    TableName := 'KWSOST';
    Active := true;
    for n:=Low(arrKWSOST) to High(arrKWSOST) do begin
      if Locate('WSOST_ID',arrKWSOST[n].WSOST_ID,[]) then
        Edit
      else begin
        Append;
        FieldByName('WSOST_ID').Value := arrKWSOST[n].WSOST_ID;
      end;
      FieldByName('WSOST_NAME').Value := arrKWSOST[n].WSOST_NAME;
      FieldByName('STATE').Value := arrKWSOST[n].STATE;
      Post;
    end;
    Active := false;
    fmMain.pbMain.StepIt;


  finally
    Free;
  end;
end;

end.

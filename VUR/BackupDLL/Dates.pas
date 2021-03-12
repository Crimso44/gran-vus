unit Dates;

interface

function Date2Str(dt: TDateTime): string;
function Str2Date(val: string): TDateTime;

implementation

uses SysUtils, Dialogs;

function Date2Str(dt: TDateTime): string;
var day,month,year: Word;
begin
  DecodeDate(dt,year,month,day);
  Result := Format('%.4d-%.2d-%.2d',[year,month,day]);
end;

function Str2Date(val: string): TDateTime;
var day,month,year: Word;
    s: string;
    n: Integer;
begin
  s := val;
  n := Pos('-',s);
  if n<0 then n := 1000;
  year := StrToInt('0'+Copy(s,1,n-1));
  s := Copy(s,n+1,1000);
  n := Pos('-',s);
  if n<0 then n := 1000;
  month := StrToInt('0'+Copy(s,1,n-1));
  day := StrToInt('0'+Copy(s,n+1,1000));
  if not TryEncodeDate(year,month,day, Result) then ShowMessage('Ошибка в дате: "'+val+'"');
end;


end.

unit BirthDay;

interface

uses SysUtils, StrUtils;

function FullAges(s: String; isJet: Boolean): String;
function ReplaceFullAges(s: String; isJet: Boolean): String;
function GetFullAge(d: TDateTime): Integer;

implementation

function FullAges(s: String; isJet: Boolean): String;
begin
  if isJet then
    Result :=
      '(Year(Date())-Year('+s+')-'+
        'iif(Month(Date())<Month('+s+') or '+
        '(Month(Date())=Month('+s+') and Day(Date())<Day('+s+')),1,0))'
  else
    Result :=
      '(Year(GetDate())-Year('+s+')-'+
        'iif(Month(GetDate())<Month('+s+') or '+
        '(Month(GetDate())=Month('+s+') and Day(GetDate())<Day('+s+')),1,0))';
end;

function ReplaceFullAges(s: String; isJet: Boolean): String;
var
  i, j: Integer;
begin
  Result := s;
  i := Pos('#FullAges#', Result);
  while i > 0 do begin
    j := PosEx('#', Result, i+10);
    Result := Copy(Result, 1, i-1) +
      FullAges(Copy(Result, i+10, j-i-10), isJet) +
      Copy(Result, j+1, MaxInt);

    i := Pos('#FullAges#', Result);
  end;
end;


function GetFullAge(d: TDateTime): Integer;
var
  dd, mm, yy: Word;
  dn, mn, yn: Word;
begin
  DecodeDate(d, yy, mm, dd);
  DecodeDate(Now, yn, mn, dn);
  Result := yn - yy - 1;
  if mn > mm then
    Inc(Result)
  else if mn = mm then
    if dn >= dd then
      Inc(Result);
end;

end.

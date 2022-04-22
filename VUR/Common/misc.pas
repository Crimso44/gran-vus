unit misc;

interface

function Hex2Int(s: string): Int64;
function SameValue(s_item,s_parent: string): boolean;
function IsDateOrYear(s: string): boolean;
function FormatOKSO(s: string): string;

const
   E_InvDateOrYear =
     'Неверно указана дата или год.'#13#13+
     'Допустимый формат: ДД.ММ.ГГГГ или ГГГГ';
implementation

uses SysUtils, StrUtils, DateUtils;

function FormatOKSO(s: string): string;
begin
  Result := Copy(s, 1, 2);
  if Length(s) > 2 then begin
    Result := Result + '.' + Copy(s, 3, 2);
    if Length(s) > 4 then begin
      Result := Result + '.' + Copy(s, 5, MaxInt);
    end;
  end;
end;

function Hex2Int(s: string): Int64;
var i: Integer;
    ch: char;
begin
  Result := 0;
  for i:= 1 to Length(s) do begin
    ch := UpperCase(s)[i];
    case ch of
    '0'..'9': begin Result := Result*16+(ord(ch)-ord('0'))  end;
    'A'..'F': begin Result := Result*16+(ord(ch)-ord('A')+10) end;
    else raise EIntError.CreateFmt('Неверный аргумент : %s',[s]);
    end;
  end;
end;

function SameValue(s_item,s_parent: string): boolean;
var n,k: Integer;
begin
  Result := false;
  for n := Length(s_parent) downto 1 do
  if s_parent[n]<>'0' then begin
    case n of
      1,2  : k := 2;
    else
      case (n-2) mod 3 of
        1: k := n+2;
        2: k := n+1;
      else
        k := n;
      end;
    end;
    Result := LeftStr(s_parent,k)=LeftStr(s_item,k);
    Exit;
  end;
end;

function IsDateOrYear(s: string): boolean;
var month, day: Word;
    n: Integer;
begin
  if Length(s)=4 then begin
    Result := TryStrToInt(s,n);
    if Result then
      Result := (n>=1900) and (n<=2050);
  end
  else
    if Length(s)=10 then begin
      Result := (s[3]='.') and (s[6]='.');
      if Result then begin
        Result := TryStrToInt(Copy(s,1,2),n);
        if Result then begin
          day := n;
          Result := TryStrToInt(Copy(s,4,2),n);
          if Result then begin
            month := n;
            Result := TryStrToInt(Copy(s,7,4),n);
            if Result then
              Result := IsValidDate(n,month,day);
          end;
        end;
      end;
    end
    else
      Result := false;
end;

end.

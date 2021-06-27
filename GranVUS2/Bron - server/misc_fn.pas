unit misc_fn;

interface

function MakeConnStr(srv,db: string; use_nt: boolean;
   user,psw: string; keep_psw: boolean): string;

implementation

uses SysUtils;

function MakeConnStr(srv,db: string; use_nt: boolean;
   user,psw: string; keep_psw: boolean): string;
var s: string;
begin
  s := AnsiUpperCase(srv);
  Result := 'Provider=SQLOLEDB.1;Data Source='+s+';Initial Catalog='+db+';';
  if use_nt then
    Result := Result +'Integrated Security=SSPI;Persist Security Info=False;'
  else begin
    Result := Result +'Persist Security Info=True;User ID='+user+';';
    if keep_psw then Result := Result + 'Password='+psw+';';
  end;
end;

end.

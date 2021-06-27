unit utils_misc;

interface

uses Classes, Windows, Controls;

function GetVolumeSerialNumber(root: string): DWORD;
procedure CompactAccessDatabase(DatabaseName,Password:String);

function CheckINN(const INN: string): Boolean;

function FIO(const Fam,Im,Otch: string): string;

procedure EncodeBits(B: TBits; A: PChar);
procedure DecodeBits(B: TBits; A: PChar);

function Date2SQL(ADate: TDate): string;
function SQL2Date(ASQL: string): TDate;

function GetVersionString(FileName: string): string;

function CodeTableConvert(AData: String; AType: Integer = 0): String;

implementation

uses ComObj,SysUtils,Variants;

const
  CodeTable: PChar = '0123456789ABCDEFGHJKLMNPRTUVWXYZ';
  CodeRus: PChar   = '0123456789јЅ¬√ƒ≈∆ё» ЋћЌќѕ–—“”‘„я';

function CodeTableType(AData: String): Integer;
var
  ch: Char;
  bt: Byte;
  i: Integer;
begin
  bt := 0;
  for ch in AData do begin
    if ch in ['0'..'9'] then
      Continue;
    i := Pos(ch, CodeTable);
    if i > 0 then begin
      bt := bt or $0F;
      Continue;
    end;
    i := Pos(ch, CodeRus);
    if i > 0 then begin
      bt := bt or $F0;
      Continue;
    end;
  end;
  case bt of
    0, $0F:
      Result := 1;
    $F0:
      Result := 2;
  else
    Result := 0;
  end;
end;

function CodeTableConvert(AData: String; AType: Integer = 0): String;
var
  i, ct, p: Integer;
  tbl_from, tbl_to: PChar;
  ch: Char;
begin
  Result := AData;
  ct := CodeTableType(AData);
  if ct = AType then
    Exit;
  case ct of
    1:
      begin
        tbl_from := CodeTable;
        tbl_to := CodeRus;
      end;
    2:
      begin
        tbl_from := CodeRus;
        tbl_to := CodeTable;
      end
  else
    Result := '';
    Exit;
  end;
  i := 1;
  for ch in AData do begin
    p := Pos(ch, tbl_from);
    if p > 0 then
      Result[i] := tbl_to[p - 1]
    else
      Result[i] := AData[i];
    Inc(i);
  end;
end;

procedure EncodeBits(B: TBits; A: PChar);
var n,i,j: Integer;
    k: Word;
begin
  j := 0;
  n := 0;
  while n<B.Size do begin
    k := 0;
    for i:=0 to 4 do
      if n+i<B.Size then
        if B.Bits[n+i] then k := k or ($10 shr i);
    A[j] := CodeTable[k];
    Inc(j);
    Inc(n,5);
  end;
  A[j] := #0;
end;

procedure DecodeBits(B: TBits; A: PChar);
var i,k: Integer;
    n: Word;
begin
  B.Size := StrLen(A)*5;
  for i:=0 to StrLen(A)-1 do begin
    n := 0;
    while n<32 do begin
      if A[i]=CodeTable[n] then break;
      Inc(n);
    end;
    for k:=0 to 4 do
      B.Bits[i*5+k] := (n and ($10 shr k))<>0;
  end;
end;

function GetVolumeSerialNumber(root: string): DWORD;
var FSName,VolName: Array[0..MAX_PATH-1] of char;
    MaxCompLen,SysFlags: DWORD;
begin
  Result := 0;
  GetVolumeInformation(PChar(root),VolName,MAX_PATH,@Result,MaxCompLen,SysFlags,FSName,MAX_PATH);
end;

procedure CompactAccessDatabase(DatabaseName,Password:String);
Var
  TempName : Array[0..MAX_PATH] of Char; // им€ временного файла
  TempPath : String; // путь
  Name : String;
  tmpDAO : OleVariant;
begin
  try // получим ClassID
    try
      tmpDAO := CreateOleObject('DAO.DBEngine.36');
    except
      try
        tmpDAO := CreateOleObject('DAO.DBEngine.35');
      except
        raise; // что то нам неизвестное
      end;
    end;
    // получаем путь дл€ временного файла
    TempPath:=ExtractFilePath(DatabaseName);
    if TempPath='' Then TempPath:=GetCurrentDir;
    //получаем им€ временного файла
    GetTempFileName(PChar(TempPath),'mdb',0,TempName);
    Name:=StrPas(TempName);
    DeleteFile(PChar(Name));// этого файла не должно существовать :))
    if Password <> '' Then Password:=';pwd='+Password;
    tmpDAO.CompactDatabase(DatabaseName,Name,0,0,Password);
    DeleteFile(PChar(DatabaseName)); // удал€ем не упакованную базу
    RenameFile(Name,DatabaseName); // переименовываем упакованную базу
  finally
    tmpDAO := NULL;
  end;
end;

function CheckINN(const INN: string): Boolean;
const
  factor1: array[0..8] of byte = (2, 4, 10, 3, 5, 9, 4, 6, 8);
  factor2: array[0..9] of byte = (7, 2, 4, 10, 3, 5, 9, 4, 6, 8);
  factor3: array[0..10] of byte = (3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8);
var
 i: byte;
 sum: word;
 sum2: word;
begin
  Result := False;

  try
    if Length(INN) = 10 then begin
      sum := 0;
      for i:=0 to 8 do
        sum := sum + StrToInt(INN[i+1])*factor1[i];
      sum := sum mod 11;
      sum := sum mod 10;
      Result := StrToInt(INN[10]) = sum;
    end
    else if Length(INN) = 12 then begin
      sum := 0;
      for i:=0 to 9 do
        sum := sum + StrToInt(INN[i+1])*factor2[i];
      sum := sum mod 11;
      sum := sum mod 10;
      sum2 := 0;
      for i:=0 to 10 do
        sum2 := sum2 + StrToInt(INN[i+1])*factor3[i];
      sum2 := sum2 mod 11;
      sum2 := sum2 mod 10;
      Result := (StrToInt(INN[11]) = sum) and
                (StrToInt(INN[12]) = sum2);
    end; //
  except
    Result := False;
  end; // try
end;

function FIO(const Fam,Im,Otch: string): string;
begin
  Result := Fam;
  if Result=EmptyStr then Result := Trim(Im+' '+Otch)
  else
    if Im<>EmptyStr then
      if Otch<>EmptyStr then
        Result := Result+' '+Im[1]+'. '+Otch[1]+'.'
      else
        Result := Result+' '+Im;
end;

function Date2SQL(ADate: TDate): string;
begin
  Result := FormatDateTime('YYYYMMDD',ADate);
end;

function SQL2Date(ASQL: string): TDate;
begin
  Result := EncodeDate(
    StrToInt(Copy(ASQL,1,4)),
    StrToInt(Copy(ASQL,5,2)),
    StrToInt(Copy(ASQL,7,2)) );
end;

function GetVersionString(FileName: string): string;
var
  Info: Pointer;
  InfoSize: DWORD;
  FileInfo: PVSFixedFileInfo;
  FileInfoSize: DWORD;
  Tmp: DWORD;
begin
  Result := '(n/a)';
  InfoSize := GetFileVersionInfoSize(PChar(FileName),Tmp);
  if InfoSize<>0 then begin
    GetMem(Info,InfoSize);
    try
      GetFileVersionInfo(PChar(FileName),0,InfoSize,Info);
      VerQueryValue(Info,'\',Pointer(FileInfo),FileInfoSize);
      Result :=
        Format('%d.%d.%d (%.3d)',
               [FileInfo.dwFileVersionMS shr 16,
                FileInfo.dwFileVersionMS and $FFFF,
                FileInfo.dwFileVersionLS shr 16,
                FileInfo.dwFileVersionLS and $FFFF]);

    finally
      FreeMem(Info);
    end;
  end;
end;

end.

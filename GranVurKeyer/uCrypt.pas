unit uCrypt;

interface

uses WinTypes, SysUtils, Classes, dialogs;

type
  TCertificate=record
    ProductCode: Word;
    LicenceNumber: DWord;
    LicenceCount: Word;
    ValidityDate: TDateTime;
    HardwareKey: DWord;
    ControlKey: DWord;
  end;


procedure CertificateToBits(C: TCertificate; B: TBits);
procedure BitsToCertificate(B: TBits; var C: TCertificate);

procedure CalcValidateKey(B: TBits; VK: PChar);

procedure EncodeBits(B: TBits; A: PChar);
procedure DecodeBits(B: TBits; A: PChar);

function GetRandom(Value: Word): Word;
procedure MixBits(B: TBits; Key: DWord; Reverse: boolean = false);

function GetHardwareKey: DWord;

var
  ProductCode: String;
  LicenseKey: String;

implementation

uses IniFiles, Forms;

const
  CodeTable: PChar = '0123456789ABCDEFGHJKLMNPRTUVWXYZ';

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

procedure CertificateToBits(C: TCertificate; B: TBits);
var n,i: Integer;
    day,month,year: Word;
begin
  B.Size := 125;
  for i:=0 to 15 do
    B.Bits[i] := (C.ProductCode and (1 shl i))<>0;
  for i:=0 to 23 do
    B.Bits[16+i] := (C.LicenceNumber and (1 shl i))<>0;
  for i:=0 to 9 do
    B.Bits[40+i] := (C.LicenceCount and (1 shl i))<>0;
  DecodeDate(C.ValidityDate,year,month,day);
  n := (year - 2001)*12+(month-1);
  for i:=0 to 10 do
    B.Bits[50+i] := (n and (1 shl i))<>0;
  for i:=0 to 31 do
    B.Bits[61+i] := (C.HardwareKey and (1 shl i))<>0;
  for i:=0 to 31 do
    B.Bits[93+i] := (C.ControlKey and (1 shl i))<>0;
end;

procedure BitsToCertificate(B: TBits; var C: TCertificate);
var n,i: Integer;
begin
  if B.Size<>125 then raise Exception.Create('Неверно определен массив бит!');
  C.ProductCode := 0;
  for i:=0 to 15 do
    if B.Bits[i] then
      C.ProductCode := C.ProductCode or (1 shl i);
  C.LicenceNumber := 0;
  for i:=0 to 23 do
    if B.Bits[16+i] then
      C.LicenceNumber := C.LicenceNumber or (1 shl i);
  C.LicenceCount := 0;
  for i:=0 to 9 do
    if B.Bits[40+i] then
      C.LicenceCount := C.LicenceCount or (1 shl i);
  n := 0;
  for i:=0 to 10 do
    if B.Bits[50+i] then
      n := n or (1 shl i);
  C.ValidityDate := IncMonth(EncodeDate(2001,1,1),n);
  C.HardwareKey := 0;
  for i:=0 to 31 do
    if B.Bits[61+i] then
      C.HardwareKey := C.HardwareKey or (1 shl i);
  C.ControlKey := 0;
  for i:=0 to 31 do
    if B.Bits[93+i] then
      C.ControlKey := C.ControlKey or (1 shl i);
end;

procedure CalcValidateKey(B: TBits; VK: PChar);
  function GetWord(Index: Integer): Word;
  var n,k: Integer;
  begin
    n := Index*16;
    k := n + 15;
    Result :=0;
    for n:=n to k do begin
      if n<B.Size then
        if B.Bits[n] then Result := Result or 1;
      Result := Result shl 1;
    end;
  end;
var
  res: Word;
  k: DWord;
  n,cnt: Integer;
  bits: TBits;
begin
  res := 0;
  cnt := B.Size div 16;
  if (B.Size mod 16)>0 then Inc(cnt);
  for n:=0 to cnt-1 do begin
    k := GetWord(n);
    k := k*k;
    res := res xor (k shr 8);
  end;
  bits := TBits.Create;
  bits.Size := 16;
  for n:=0 to 15 do
    bits.Bits[n] := ((1 shl n) and res)<>0;
  EncodeBits(bits,VK);
  bits.Free;
end;

function GetRandom(Value: Word): Word;
const
  A = 10287705;
  C = 7850143;
begin
  Result := Value*A+C;
end;

procedure MixBits(B: TBits; Key: DWord; Reverse: boolean = false);
var BB: TBits;
    moves: Array of DWord;
    n: Integer;
    k: DWord;
begin
  BB := TBits.Create;
  BB.Size := B.Size;
  SetLength(moves,B.Size);
  k := Key;
  for n:=0 to B.Size-1 do begin
    BB.Bits[n] := B.Bits[n];
    repeat
      k := GetRandom(k) mod 128;
    until k<125;
    moves[n] := k;
  end;
  for n:=0 to B.Size-1 do
    if Reverse then
       B.Bits[n] := BB.Bits[moves[n]]
    else
       B.Bits[moves[n]] := BB.Bits[n];
  SetLength(moves,0);
  BB.Free;
end;

function GetHardwareKey: DWord;
var
  lpVolumeNameBuffer,
  lpFileSystemNameBuffer: Array[0..MAX_PATH] of char;
  lpVolumeSerialNumber,
  lpMaximumComponentLength,
  lpFileSystemFlags: dword;
begin
  if not GetVolumeInformation(PChar(Copy(ParamStr(0),1,3)),lpVolumeNameBuffer,MAX_PATH,
                       @lpVolumeSerialNumber,lpMaximumComponentLength,
                       lpFileSystemFlags,lpFileSystemNameBuffer,MAX_PATH)
  then lpVolumeSerialNumber := $0AAAA5555;
  Result := lpVolumeSerialNumber;
end;

end.

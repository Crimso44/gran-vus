(* ekrtfstream September 16 2002*)
unit ekrtfstream;

interface

uses
  Windows, Messages, SysUtils, Classes, ekbasereport;

type TEKkwType=(kwNone, kwOpen, kwClose, kwKeyDest, kwKeyWord, kwKeyChar, kwHexChar, kwChar);
type TEKkwActionMethod=(amSkip, amSave, amSaveChange, amSaveRun,
                        amSkipRun, amSkipBlock, amSaveBlock, amReadBlockRun, amSkipInTable);
type TEKkwAction=record
                 n:AnsiString; //наименование слова
                 a:TEKkwActionMethod;
                 proc:word;
                 end;


{$I keyword.inc}

type TEKReplCell=record
     old,new:integer;
     end;

     TEkStream=class;

     TEKReplTable=class(TObject)
     private
      FRepl:array of TEKReplCell;
      FReplCount:integer;
      FReplSorted:boolean;
     protected
      procedure SortReplTable;
      procedure AddRepl(vrepl,vnew:integer);
      function Old2New(n:integer):integer;
      constructor create(Owner:TEKStream); virtual;
     public
      destructor destroy; override;
     end;

     TEKStyleStr=record
     n:word;
     t:byte;
     text:AnsiString;
     new:boolean;
     end;

     TEKStyleStrings=class(TEKReplTable)
     private
      FStrings:array of TEKStyleStr;
      FCount:integer;
      FHighNumber:integer;
      FOwnerEKS:TEkStream;
     protected
      function  CutNumber(var s:AnsiString; var tp:byte):AnsiString;
      function  FindNumber(s:AnsiString):integer;
      function  GetString(index:integer):AnsiString;
     public
      property    HighNumber:integer read FHighNumber;
      property    Count:integer read FCount;
      property    strings[index:integer]:AnsiString read GetString;
      function    Add(s:AnsiString):boolean;
      function    AddNew(s:AnsiString):boolean;
      procedure   CorrectNewStyles;
      //procedure   AddFromList(LS:TStrings);
      constructor create(Owner:TEKStream); override;
      destructor  destroy; override;
     end;


     TEKColorStrings=class(TEKReplTable)
     private
      FStrings:array of AnsiString;
      FCount:integer;
      FOwnerEKS:TEkStream;
     protected
      function FindNumber(s:AnsiString):integer;
      function  GetString(index:integer):AnsiString;
     public
      property    Count:integer read FCount;
      property    strings[index:integer]:AnsiString read GetString;
      function Add(s:AnsiString):boolean;
      function AddNew(oldnumber:integer; s:AnsiString):boolean;
      constructor create(Owner:TEKStream); override;
      destructor destroy; override;
     end;

     TEKFontStr=record
     n:word;
     text:AnsiString;
     end;

     TEKFontStrings=class(TEKReplTable)
     private
      FStrings:array of TEKFontStr;
      FCount:integer;
      FHighNumber:integer;
      FOwnerEKS:TEkStream;
     protected
      function  FindNumber(s:AnsiString):integer;
      function  GetString(index:integer):AnsiString;
     public
      property    Count:integer read FCount;
      property    strings[index:integer]:AnsiString read GetString;
      property    HighNumber:integer read FHighNumber;
      function    Add(s:AnsiString):boolean;
      function    AddNew(s:AnsiString):boolean;
      procedure   AddFromList(LS:TStrings);
      constructor create(Owner:TEKStream); override;
      destructor  destroy; override;
     end;

   TEKStream=class(TObject)
   private
    FStream:TStream;
    FOutStream:TStream;
    FOwner:TEkBaseRTFReport;
    FSize:longint;
    Fkw  : TEKkwType;
    FPreWrite:AnsiString;
    FLastRead:AnsiString;
    FLastKey:AnsiString;
    FLastParam:AnsiString;
    FLastDelimeter:AnsiString;
    FLastParPosition:int64;
    FLastParDelimeter:AnsiString;
    FPositionStack:array of longint;
    FStackSize:longint;
    FStackCur:longint;
    //----- text attributes ----
    FDefFont:AnsiString;
    FNewDefFont:AnsiString;
    FStyleTable:TEKStyleStrings;
    FFontTable:TEKFontStrings;
    FColorTable:TEKColorStrings;
   protected
    function Push:boolean;
    function Pop:longint;
    function ReadNext:TEKkwType;
    function SeekStr(FTests:AnsiString):boolean;
    function ReadGroup(var Buffer:PAnsiChar; var Count:Longint):boolean;
    function SkipGroup:boolean;
    function SaveGroup:boolean;
    function FindKeyWord:integer;
    function ReadFontTable:boolean;
    function ReadColorTable:boolean;
    function ReadStyleSheet:boolean;
    function ProcessSkipRun(proc:word):boolean;
    function ProcessSaveChange(proc:word):boolean;
    function ProcessSaveRun(proc:word):boolean;
    function ProcessReadBlockRun(proc:word):boolean;
    function ProcessSkipBlock:boolean;
    function ProcessSaveBlock:boolean;
    function ProcessKeyWord:boolean;
    procedure SetOutStream(Value:TStream);
    procedure Write(s:AnsiString);
   public
    property OutStream:TStream read FOutStream write SetOutStream;
    property StyleTable:TEKStyleStrings read FStyleTable;
    property ColorTable:TEKColorStrings read FColorTable;
    property FontTable:TEKFontStrings read FFontTable;
    constructor create(Owner:TEkBaseRTFReport; Source:TStream);
    function Process:boolean;
    destructor destroy; override;
end;

procedure InsertRtfMemo(Sender:TObject; OutputStream:TStream; var RtfContent:AnsiString);
procedure InsertRtfMemoPar(Sender:TObject; OutputStream:TStream; var RtfContent:AnsiString);
procedure InsertRtfMemoStream(Sender:TObject; OutputStream:TStream; var RtfStream:TStream);
procedure InsertRtfMemoStreamPar(Sender:TObject; OutputStream:TStream; var RtfStream:TStream);

implementation


function Letter(ch:AnsiChar):boolean;
begin
Result:=false;
if ((ch>='a') and (ch<='z')) or ((ch>='A') and (ch<='Z')) then Result:=true;
end;

function Digit(ch:AnsiChar):boolean;
begin
Result:=false;
if (ch='0') or (ch='1') or (ch='2') or (ch='3') or
   (ch='4') or (ch='5') or (ch='6') or (ch='7') or
   (ch='8') or (ch='9') then Result:=True;
end; //Digit

{TEKReplTable}
constructor TEKReplTable.create;
begin
 FRepl:=nil; //FReplMin:=0; FReplMax:=0;
 FReplCount:=0;
 FReplSorted:=false;
end;

destructor TEKReplTable.destroy;
begin
 inherited;
 FRepl:=nil;
end;

procedure TEKReplTable.SortReplTable;
 procedure Sort(l,r:integer);
 var
     i, j: integer;
        x: integer;
        y: TEKReplCell;
 begin
  i := l; j := r; x := FRepl[(l+r) DIV 2].old;
  repeat
    while FRepl[i].old < x do i := i + 1;
    while x < FRepl[j].old do j := j - 1;
    if i <= j then
    begin
      y := FRepl[i]; FRepl[i] := FRepl[j]; FRepl[j] := y;
      i := i + 1; j := j - 1;
    end;
  until i > j;
  if l < j then Sort(l, j);
  if i < r then Sort(i, r);
  end;//Sort
begin
 Sort(0, FReplCount-1);
 FReplSorted:=true;
end; //TEKFontStrings.SortReplTable;

procedure TEKReplTable.AddRepl(vrepl,vnew:integer);
begin
  inc(FReplCount);
  SetLength(FRepl,FReplCount);
  FRepl[FReplCount-1].old:=vrepl;
  FRepl[FReplCount-1].new:=vnew;
  //if vrepl<FReplMin then FReplMin:=vrepl;
  //if vrepl>FReplMax then FReplMax:=vrepl;
  FReplSorted:=false;
end;

function TEKReplTable.Old2New(n:integer):integer;
var idx, n1, n2:integer;
begin
 Result:=n;
 if FReplCount=0 then exit;
 if not FReplSorted then SortReplTable;

 n1:=Low(FRepl); n2:=high(FRepl);
 repeat
 idx:=n1+round((n2-n1)/2);
 if n=FRepl[idx].old then begin n1:=idx; break; end;
 if n<FRepl[idx].old then n2:=idx else n1:=idx;
 until n2-n1<2;
 if n=FRepl[n1].old then Result:=FRepl[n1].new else
          if n=FRepl[n2].old then Result:=FRepl[n2].new;
end; //TEKReplTable.Old2New;

{TEKStyleStrings}
constructor TEKStyleStrings.create(Owner:TEKStream);
begin
inherited;
FStrings:=nil;  FCount:=0; FHighNumber:=0;
FOwnerEKS:=Owner;
end;

destructor TEKStyleStrings.destroy;
begin
 inherited;
 FStrings:=nil;
end;

//Функция возвращает номер стиля, тип 0-неопределено, 1-\s 2-\*\cs 3-\ds
//если тип определен (не равен 0), то отрезает тип и номер стиля
//(или одну скобку "{" ) от начала строки
function TEKStyleStrings.CutNumber(var s:AnsiString; var tp:byte):AnsiString;
var i2, i0, ln:integer;
begin
 ln:=length(s);
 if ln<6 then begin Result:='0'; tp:=0; exit; end;

 //find number of style
 if (s[2]='\') and (s[3]='s') then begin i2:=4; tp:=1; end //paragraph style
    else
    if (copy(s,2,5)='\*\cs') or (copy(s,2,5)='\*\ds') then
           begin i2:=7;
                 if s[5]='c' then tp:=2 else tp:=3;
           end
       else
       if (copy(s,2,3)='\cs') or (copy(s,2,3)='\ds') then
           begin i2:=5;
                 if s[3]='c' then tp:=2 else tp:=3;
           end
          else  //handle it as default \s0
              begin i2:=0; Result:='0'; tp:=1; end;

 if i2>0 then
    begin
     i0:=i2;
     while (i2<=ln) and (Digit(s[i2])) do inc(i2);
     Result:=copy(s,i0,i2-i0);
     s:=copy(s,i2,ln);       //оставляем строку без идентификатора
    end else begin
             s:=copy(s,2,ln); //идентификатора нет, оставляем строку без первой фигурной скобки
             end;
end; //Style CutNumber

function TEKStyleStrings.Add(s:AnsiString):boolean;
var ln,f:integer;
    tp:byte;
    sn:AnsiString;
    s2:AnsiString;
begin
 Result:=true;
 ln:=length(s);
 s2:='';
 for f:=1 to ln do if ord(s[f])>31 then s2:=s2+s[f];
 s:=s2; s2:='';
 ln:=length(s);
 if ln<6 then begin Result:=false; exit; end;
 if (s[1]<>'{') or (s[ln-1]<>';') or (s[ln]<>'}') then begin Result:=false; exit; end;

 inc(FCount);
 SetLength(FStrings,FCount);
 tp:=0;
 sn:=CutNumber(s,tp);
   with FStrings[FCount-1] do
   begin
     n:=strtoint(sn);
     t:=tp;
     text:=s;
     new:=false;
     if n>FHighNumber then FHighNumber:=n;
   end;
end; //TEKStyleStrings.Add

function TEKStyleStrings.AddNew(s:AnsiString):boolean;
var ln, p, i3, i0, f:integer;
    tp:byte;
    foundnumber, replnumber:integer;
    OneFS:TEKStyleStr;
    sn, s2:AnsiString;
    canfind:boolean;
begin
 Result:=true;
 ln:=length(s);
 s2:='';
 for f:=1 to ln do if ord(s[f])>31 then s2:=s2+s[f];
 s:=s2; s2:='';
 ln:=length(s);
 if ln<6 then begin Result:=false; exit; end;
 if (s[1]<>'{') or (s[ln-1]<>';') or (s[ln]<>'}') then begin Result:=false; exit; end;

 tp:=0;
 sn:=CutNumber(s,tp);
 ln:=length(s);
 OneFS.n:=strtoint(sn);
 OneFS.t:=tp;
 OneFS.text:=s;
 OneFS.new:=true;

 canfind:=false; foundnumber:=-1;
 p:=pos('\snext',s);
 if pos('\sbasedon',s)=0 then
    if p=0 then //можно поискать замену
       begin
       canfind:=true;
       end else begin
                 i3:=p+6; i0:=i3;
                 while (i3<=ln) and (Digit(s[i3])) do inc(i3);
                 //если snext равен самому себе
                 //(это в основном будет работать когда 0=0 для Normal;)
                 if sn=copy(s,i0,i3-i0) then canfind:=true;
                end;

 replnumber:=OneFS.n;
 if canfind then foundnumber:=FindNumber(OneFS.text);

 if foundnumber=-1 then  // добавляем новый стиль
 begin
  inc(FCount);
  SetLength(FStrings,FCount);
  inc(FHighNumber);
  OneFS.n:=FHighNumber;
  FStrings[FCount-1]:=OneFS; //остается неверный номер в snext sbasedon
                             //замена номеров отдельным методом CorrectNewStyles по признаку new
 end else begin
          OneFS.n:=FStrings[foundnumber].n;
          end;
  //менять replnumber на OneFS.n
  AddRepl(replnumber,OneFS.n);
end; //TEKStyleStrings.AddNew

procedure TEKStyleStrings.CorrectNewStyles;
var f, p, i, i0, ln:integer;
    s:AnsiString;
    newnumber:integer;
    oldnumber:integer;
begin
  //смотрим весь FStrings, для новых меняем номера snext и sbasedon в
  //соответствии с таблицей замены.
  for f:=0 to High(FStrings) do
  begin
     if FStrings[f].new then
     begin
      s:=FStrings[f].text;

        //change fonts
        p:=1;
        while p<=length(s)-2 do begin
          if (s[p]='\') and (s[p+1]='f') and (Digit(s[p+2])) then
             begin
             i:=p+2; i0:=i; ln:=length(s);
             while (i<=ln) and (Digit(s[i])) do inc(i);
             oldnumber:=strtoint(copy(s,i0,i-i0));
             newnumber:=FOwnerEKS.FontTable.Old2New(oldnumber);
             s:=copy(s,1,p-1)+'\f'+trim(inttostr(newnumber))+copy(s,i,ln);
             end;//if
         inc(p);
        end;//while


        //***!!! highlight
        //change colors
        p:=1;
        while p<=length(s)-3 do begin
          if (s[p]='\') and (s[p+1]='c') and (s[p+2]='f') and (Digit(s[p+3])) then
             begin
             i:=p+3; i0:=i; ln:=length(s);
             while (i<=ln) and (Digit(s[i])) do inc(i);
             oldnumber:=strtoint(copy(s,i0,i-i0));
             newnumber:=FOwnerEKS.ColorTable.Old2New(oldnumber);
             s:=copy(s,1,p-1)+'\cf'+trim(inttostr(newnumber))+copy(s,i,ln);
             end;//if
         inc(p);
        end;//while


         p:=pos('\snext',s);
          if p>0 then
             begin
             i:=p+6; i0:=i; ln:=length(s);
             while (i<=ln) and (Digit(s[i])) do inc(i);
             oldnumber:=strtoint(copy(s,i0,i-i0));
             newnumber:=Old2New(oldnumber);
             s:=copy(s,1,p-1)+'\snext'+trim(inttostr(newnumber))+copy(s,i,ln);
             end;

         p:=pos('\sbasedon',s);
          if p>0 then
             begin
             i:=p+9; i0:=i; ln:=length(s);
             while (i<=ln) and (Digit(s[i])) do inc(i);
             oldnumber:=strtoint(copy(s,i0,i-i0));
             newnumber:=Old2New(oldnumber);
             s:=copy(s,1,p-1)+'\sbasedon'+trim(inttostr(newnumber))+copy(s,i,ln);
             end;
      FStrings[f].text:=s;
      FStrings[f].new:=false;
     end; //if new
  end;//for
end; //Styles CorrectNewStyles;

function TEKStyleStrings.FindNumber(s:AnsiString):integer;
var f, p0, p1, i, ln:integer;
    s0,s1:AnsiString;
begin
 Result:=-1;
 //Здесь будем сравнивать строки не обращая внимания на номер в \snext
 //Строки с \snext будут попадать сюда только для стилей в
 //которых \snext указывает на самого себя.

   s1:=s;
   p1:=pos('\snext',s1);
   if p1>0 then
      begin
       i:=p1+6; ln:=length(s);
       while (i<=ln) and (Digit(s[i])) do inc(i);
       s1:=copy(s,1,p1-1)+copy(s,i,ln); //Вырезали слово \snext вместе с номером
      end;

 for f:=0 to FCount-1 do
 begin
      s0:=FStrings[f].text;
      p0:=pos('\snext',s0);

      if ((p0>0) and (p1>0)) or ((p0=0) and (p1=0)) then
      begin  //если в одном есть snext а в другом нет, то не будем даже сравнивать
             //иначе сравниваем без номеров
             if p0>0 then
                begin
                 i:=p0+6; ln:=length(s0);
                 while (i<=ln) and (Digit(s0[i])) do inc(i);
                 s0:=copy(s0,1,p0-1)+copy(s0,i,ln); //Вырезали слово \snext вместе с номером
                end;

         if s0=s1 then begin Result:=f; break; end;
      end;

 end;//for
end; //TEKStyleStrings.FindNumber


function TEKStyleStrings.GetString(index: integer): AnsiString;
var s:AnsiString;
begin
   Result:='';
   if (index<0) or (index>=FCount) then exit;
   case FStrings[index].t of
     0:s:='{';
     1:s:='{\s'+inttostr(FStrings[index].n);
     2:s:='{\*\cs'+inttostr(FStrings[index].n);
     3:s:='{\ds'+inttostr(FStrings[index].n);
   end;
   Result:=s+FStrings[index].text;
end;

{TEKColorStrings}
constructor TEKColorStrings.create(Owner:TEKStream);
begin
 inherited;
 FStrings:=nil; FCount:=0;
 FOwnerEKS:=Owner;
end;

destructor TEKColorStrings.destroy;
begin
 inherited;
 FStrings:=nil;
end;

function TEKColorStrings.FindNumber(s:AnsiString):integer;
var f:integer;
begin
 Result:=-1;
 for f:=0 to FCount-1 do
 begin
 if FStrings[f]=s then begin Result:=f; break; end;
 end;
end; //TEKColorStrings.FindNumber

//Добавление строки вида \red0\green0\blue0;
//Может быть только один знак ; что означает autocolor
function TEKColorStrings.Add(s:AnsiString):boolean;
var ln:integer;
begin
 Result:=true;
 ln:=length(s);
 if ln<1 then begin Result:=false; exit; end;
 if (s[ln]<>';') then begin Result:=false; exit; end;
 inc(FCount);
 SetLength(FStrings,FCount);
 FStrings[FCount-1]:=s;
end; //TEKColorStrings.Add

function TEKColorStrings.AddNew(oldnumber:integer;s:AnsiString):boolean;
var ln, foundnumber, newnumber:integer;
begin
 Result:=true;
 ln:=length(s);
 if ln<1 then begin Result:=false; exit; end;
 if (s[ln]<>';') then begin Result:=false; exit; end;

 foundnumber:=FindNumber(s);

 if foundnumber=-1 then  //нет такого цвета, добавляем новый
 begin
  inc(FCount);
  SetLength(FStrings,FCount);
  FStrings[FCount-1]:=s;
  newnumber:=FCount-1;
 end else begin
          newnumber:=foundnumber;
          //В отличие от фонтов, здесь номер цвета равен номеру строки
          //таблицы
          end;
  //менять replnumber на OneFS.n
  AddRepl(oldnumber,newnumber);

end;


function TEKColorStrings.GetString(index: integer): AnsiString;
begin
   Result:='';
   if (index<0) or (index>=FCount) then exit;
   Result:=FStrings[index];
end;

{TEKFontStrings}
constructor TEKFontStrings.create(Owner:TEKStream);
begin
inherited;
FStrings:=nil;  FCount:=0; FHighNumber:=0;
FOwnerEKS:=Owner;
end;

destructor TEKFontStrings.destroy;
begin
 inherited;
 FStrings:=nil;
end;

//Разбираем строку {\f0\froman...} на номер фонта и оставшуюся часть
function TEKFontStrings.Add(s:AnsiString):boolean;
var ln:integer;
    i2:integer;
    sn:AnsiString;
begin
 Result:=true;
 ln:=length(s);
 if ln<6 then begin Result:=false; exit; end;
 if (s[1]<>'{') or (s[2]<>'\') or (s[3]<>'f') or (not digit(s[4])) or (s[ln]<>'}') then begin Result:=false; exit; end;
 inc(FCount);
 SetLength(FStrings,FCount);
 i2:=4;
 while (i2<=ln) and (Digit(s[i2])) do inc(i2);
 sn:=copy(s,4,i2-4);
   with FStrings[FCount-1] do
   begin
     n:=strtoint(sn);
     text:=copy(s,i2,ln);
     if n>FHighNumber then FHighNumber:=n;
   end;
end; //TEKFontStrings.Add

function TEKFontStrings.AddNew(s:AnsiString):boolean;
var ln:integer;
    i2, foundnumber, replnumber:integer;
    OneFS:TEKFontStr;
    sn:AnsiString;
begin
 Result:=true;
 ln:=length(s);
 if ln<6 then begin Result:=false; exit; end;
 if (s[1]<>'{') or (s[2]<>'\') or (s[3]<>'f') or (not digit(s[4])) or (s[ln]<>'}') then begin Result:=false; exit; end;

 i2:=4;
 while (i2<=ln) and (Digit(s[i2])) do inc(i2);
 sn:=copy(s,4,i2-4);
  OneFS.n:=strtoint(sn);
  OneFS.text:=copy(s,i2,ln);
 replnumber:=OneFS.n;
 foundnumber:=FindNumber(OneFS.text);

 if foundnumber=-1 then  //нет такого фонта, добавляем новый
 begin
  inc(FCount);
  SetLength(FStrings,FCount);
  inc(FHighNumber);
  OneFS.n:=FHighNumber;
  FStrings[FCount-1]:=OneFS;
 end else begin
          OneFS.n:=FStrings[foundnumber].n;
          end;
  //менять replnumber на OneFS.n
  AddRepl(replnumber,OneFS.n);

end; //TEKFontStrings.AddNew

procedure TEKFontStrings.AddFromList(LS:TStrings);
var f:integer;
begin
    for f:=0 to LS.Count-1 do Add(LS[f]);
end; //TEKFontStrings.AddFromList

function TEKFontStrings.FindNumber(s:AnsiString):integer;
var f:integer;
begin
 Result:=-1;
 for f:=0 to FCount-1 do
 begin
 if FStrings[f].text=s then begin Result:=f; break; end;
 end;
end; //TEKFontStrings.FindNumber

function TEKFontStrings.GetString(index: integer): AnsiString;
begin
   Result:='';
   if (index<0) or (index>=FCount) then exit;
   Result:='{\f'+inttostr(FStrings[index].n)+FStrings[index].text;
end;

{ TEKStream }

constructor TEKStream.create(Owner:TEkBaseRTFReport; Source: TStream);
begin
   FStream:=Source;
   FOwner:=Owner;
   FOutStream:=nil;
   FSize:=FStream.Size;
   Fkw:=kwNone;
   FPreWrite:='';
   FLastRead:='';
   FLastKey:='';
   FLastParam:=''; FLastDelimeter:='';
   FPositionStack:=nil;
   FStackSize:=0;
   FStackCur:=-1;
   FLastParPosition:=-1;
   FLastParDelimeter:='';
   FDefFont:='';
   FNewDefFont:='';
   FFontTable:=TEKFontStrings.create(Self);
   FColorTable:=TEKColorStrings.create(Self);
   FStyleTable:=TEKStyleStrings.create(Self);
end;

destructor TEKStream.destroy;
begin
inherited;
FPositionStack:=nil;
FFontTable.Free;
FColorTable.Free;
FStyleTable.Free;
end;

procedure TEKStream.SetOutStream(Value:TStream);
begin
  FOutStream:=Value;
end;

procedure TEKStream.Write(s:AnsiString);
var ln:word;
begin
  ln:=length(FPreWrite);
  if ln>0 then begin
               FOutStream.WriteBuffer(pointer(FPreWrite)^,ln);
               FPreWrite:='';
               end;
  FOutStream.WriteBuffer(pointer(s)^,length(s));
end;

// Функция ищет подстроку в потоке начиная с текущей позиции
// в случае успеха возвращается ИСТИНА и поток устанавливается
// в позицию перед искомой строкой (так чтобы ее считать)
// В случае неудачи поток возвращается в исходную позицию
function TEKStream.SeekStr(FTests: AnsiString): boolean;
const block=1000;
var i, j, lens:longint;
    found:boolean;
    Pagecount:longint;
    oldposition:longint;
    FChP:PAnsiChar;
    FMax :Longint;
begin
//scan stream for test AnsiString from current position
Pagecount:=-1;
lens:=length(FTests);
found:=false;
oldposition:=FStream.Position;
if (lens=0) or (FSize<lens) then begin Result:=false; exit; end;

//take memory for block+length of test AnsiString-1
GetMem(Fchp,block+lens-1);
i:=0;
 while (not found) and (FStream.Position<FSize) do
 begin
 inc(pagecount);
 FMax:=FStream.Read(FChp^,block+lens-1);
 i:=0;
 while i+lens-1<FMax do //reiterate i from 0 to 999
 begin
  if FTests[1]=(FChp+i)^ then
     begin
        found:=true;
        for j:=1 to lens-1 do
            if (FTests[1+j]<>(FChp+i+j)^) then begin found:=false; break; end;
        if found then break;
     end;
 inc(i);
 end; // while 2
 if (FStream.Position<FSize) then FStream.Seek(-(lens-1),soFromCurrent);
 end;//while 1

 //showmessage(inttostr(pagecount)+' '+inttostr(i));

  FreeMem(FChp,block);
  if found then FStream.Seek(pagecount*block+i,sofrombeginning)
                else begin FStream.Seek(oldposition,sofrombeginning); end;
 Result:=found;
end; //TEkStream.SeekStr

// Функция считывает группу, заключенную в фигурные скобки, выделяет под нее
// память. В случае удачи Buffer указывает на область памяти длиной Count.
// В случае неудачи поток возвращается в исходную позицию, память не выделяется.
function TEKStream.ReadGroup(var Buffer:PAnsiChar; var Count:Longint):boolean;
const block=500;
var PPages: array of PAnsiChar;
    POneP : PAnsiChar;
    pagecur,i,f:longint;
    FMax:longint;
    braces:longint;
    chp,ch:AnsiChar;
    oldposition:longint;
begin
 Result:=false;
 pagecur:=-1;
 braces:=0; FMax:=0;
 chp:=' ';
 i:=0; count:=0; buffer:=nil;
 if not (FStream.Position<FSize) then exit;
 oldposition:=FStream.Position;
 try
 while (FStream.Position<FSize) do
 begin
 i:=0;
 GetMem(POneP,block);
 inc(pagecur);
 SetLength(PPages,pagecur+1);
 PPages[pagecur]:=POneP;
 FMax:=FStream.Read(PPages[pagecur]^,block);
 repeat
    ch:=(PPages[pagecur]+i)^;
    if (ch='{') and (chp<>'\') then inc(braces);
    if (ch='}') and (chp<>'\') then dec(braces);
    inc(i); chp:=ch;
 until (braces<=0) or (i=block) or (i=FMax);
 if braces<=0 then break;

 end; //while

 if (braces=0) and (FMax>0) then
 begin
     FStream.Seek(-(FMax-i),sofromcurrent);
     Count:=(pagecur)*block+i;
     GetMem(Buffer,Count+1);
     for f:=0 to pagecur-1 do Move(PPages[f]^,(Buffer+f*block)^,block);
     Move(PPages[pagecur]^,(Buffer+pagecur*block)^,i);
     (Buffer+Count)^:=#0;
     Result:=true;
 end else begin
          FStream.Seek(oldposition,sofrombeginning);
          end;
 finally
  for f:=0 to high(PPages) do FreeMem(PPages[f],block);
 end;//try
end; //TEKStream.ReadGroup;

//------------------------------------------------------------------------
function TEKStream.SaveGroup:boolean;
const block=1000;
var POneP : PAnsiChar;
    i,FMax,count,pagecur:longint;
    braces:longint;
    chp,ch:AnsiChar;
    oldposition:longint;
begin
 Result:=false;
 braces:=0; FMax:=0;
 chp:=' ';
 pagecur:=-1;
 i:=0;
 if not (FStream.Position<FSize) then exit;
 oldposition:=FStream.Position;

 Ponep:=nil;
 try
 GetMem(POneP,block);
 while (FStream.Position<FSize) do
 begin
 i:=0;
 inc(pagecur);
 FMax:=FStream.Read(POnep^,block);
  repeat
    ch:=(POnep+i)^;
    if (ch='{') and (chp<>'\') then inc(braces);
    if (ch='}') and (chp<>'\') then dec(braces);
    inc(i); chp:=ch;
  until (braces<=0) or (i=block) or (i=FMax);
  if braces<=0 then break;
 end; //while

  FStream.Seek(oldposition,sofrombeginning);

  if (braces=0) and (FMax>0) then
  begin
     Count:=(pagecur)*block+i;
     FOutStream.CopyFrom(FStream,Count);
     Result:=true;
  end;
 finally
   if PoneP<>nil then FreeMem(Ponep,block);
 end;//try

end; //TEKStream.SaveGroup;

//-------------------------------------------------------------------------
//если баланс скобок не равен 0, то FStream остается в последней считанной
// позиции и результат = false
function TEKStream.SkipGroup:boolean;
const block=1000;
var POneP : PAnsiChar;
    i,FMax:longint;
    braces:longint;
    chp,ch:AnsiChar;
begin
 Result:=false;
 braces:=0; FMax:=0;
 chp:=' ';
 i:=0;
 if not (FStream.Position<FSize) then exit;

 Ponep:=nil;
 try
 GetMem(POneP,block);
 while (FStream.Position<FSize) do
 begin
 i:=0;
 FMax:=FStream.Read(POnep^,block);
  repeat
    ch:=(POnep+i)^;
    if (ch='{') and (chp<>'\') then inc(braces);
    if (ch='}') and (chp<>'\') then dec(braces);
    inc(i); chp:=ch;
  until (braces<=0) or (i=block) or (i=FMax);
  if braces<=0 then break;
 end; //while

  if (braces=0) and (FMax>0) then
  begin
     FStream.Seek(-(FMax-i),sofromcurrent);
     Result:=true;
  end;
 finally
   if PoneP<>nil then FreeMem(Ponep,block);
 end;//try
end; //TEKStream.SkipGroup;
//-------------------------------------------------------------------------
function TEkStream.Push:boolean;
var NextPos:longint;
begin
 Result:=true;
 try
  NextPos:=FStackCur+1;
  if not (FStackSize>NextPos) then
        begin
        SetLength(FPositionStack,FStackSize+1);
        inc(FStackSize);
        end;
   inc(FStackCur);
   FPositionStack[FStackCur]:=FStream.Position-1;
 except
 Result:=false;
 end;//try
end; //TEkStream.Push

function TEkStream.Pop:longint;
begin
   if FStackCur>-1 then begin Result:=FPositionStack[FStackCur];
                        dec(FStackCur);
                        end
                   else Result:=-1;
end; //TEkStream.Pop;


function TEkStream.ReadNext: TEKkwType;
const block=100;
var FMax,i:word;
    POneP:PAnsiChar;
    ch, ch2:AnsiChar;
    oldposition:longint;
begin
 Result:=kwNone;
 FLastRead:='';  FLastKey:=''; FLastParam:=''; FLastDelimeter:='';
 if not (FStream.Position<FSize) then exit;
 POnep:=nil;
 try
 GetMem(POneP,block);
 oldposition:=FStream.Position;
 FMax:=FStream.Read(POneP^,block);

 if FMax>0 then
 begin
 ch:=POneP^;
   case ch of
     '{':begin Result:=kwOpen; FLastRead:='{'; end;
     '}':begin Result:=kwClose; FLastRead:='}'; end;
     '\':begin
          if FMax>1 then
          begin
             ch2:=(POneP+1)^;
             if Letter(ch2) then
             begin
                 i:=2; FLastRead:='\';
                 while (Letter(ch2)) and (i<=FMax) do
                 begin
                 FLastRead:=FLastRead+ch2;
                 inc(i);
                 if i<=FMax then ch2:=(POnep+i-1)^ else ch2:=#0;
                 end;//while
                 FLastKey:=FLastRead;

                 if (ch2='-') and (i<=FMax) then  begin
                                                  FLastParam:=FLastParam+'-';
                                                  inc(i);
                                                  if i<=FMax then ch2:=(POnep+i-1)^ else ch2:=#0;
                                                  end;
                 while (digit(ch2)) and (i<=FMax) do
                 begin
                 FLastParam:=FLastParam+ch2;
                 inc(i);
                 if i<=FMax then ch2:=(POnep+i-1)^ else ch2:=#0;
                 end;//while
                 FLastRead:=FLastRead+FLastParam;

                 //Проверить последний символ после ключевого слова
                 //check if last AnsiChar is space and part of keyword
{
\LetterSequence<Delimiter>
Note that a backslash begins each control word.
The LetterSequence is made up of lowercase alphabetic characters between "a"
and "z" inclusive. RTF is case sensitive, and all RTF control words must be
lowercase.
The delimiter marks the end of an RTF control word, and can be one of the
following:
    · A space. In this case, the space is part of the control word.
    · A digit or a hyphen (-), which indicates that a numeric parameter
      follows. The subsequent digital sequence is then delimited by a space
      or any character other than a letter or a digit. The parameter can be
      a positive or a negative number.  If a numeric parameter immediately follows the
      control word, this parameter becomes part of the control word.
      The control word is then delimited by a space or a nonalphabetic or
      nonnumeric character in the same manner as any other control word.
    · Any character other than a letter or a digit. In this case, the
      delimiting character terminates the control word but is not actually
      part of the control word.

 }
                 if ch2=#32 then begin FLastRead:=FLastRead+#32;
                                       FLastDelimeter:=#32;
                                 end;
                 Result:=kwKeyWord;

             end else //If letter(ch2)
                 begin
                   case ch2 of
                   '''':begin
                         if FMax>3 then begin
                                        Result:=kwHexChar; FLastRead:='\'''+(POnep+2)^+(POnep+3)^;
                                        end else begin Result:=kwNone;
                                                 FLastRead:='\''';
                                                  if FMax=3 then FLastRead:=FLastRead+(POnep+2)^;
                                                 end;
                        end;
                   '\','-','{','}','~' :begin Result:=kwKeyChar; FLastRead:=ch+ch2; end;
                   '*' :begin Result:=kwKeyDest; FLastRead:='\*'; end;
                   else begin Result:=kwNone; FLastRead:=ch+ch2; end;
                   end; //case ch2
                 end; //else Letter(ch2)

          end else begin Result:=kwNone; FLastRead:='\'; end;//if FMax>1
         end;// case '\'
       #0:begin
           Result:=kwNone; FLastRead:='';
          end;
    else begin
         Result:=kwChar; FLastRead:=ch;
         end; //case else
   end;//case
   //Вернуть поток в корректную позицию
   //Set stream to correct position
   i:=length(FLastRead);
   FStream.Seek(oldposition+i,soFromBeginning);
 end;//if FMax>0
 finally
   if POnep<>nil then FreeMem(POneP,block);
 end;//try
end; //TEkStream.ReadNext

//-------------------------------------------------------------------------
// Функция добавляет шрифты в fonttable. автоматически формируется
// таблица замены.
function TEKStream.ReadFontTable:boolean;
var Buffer:PAnsiChar;
    Count,i,cnt:integer;
    ch:AnsiChar;
    s:AnsiString;
begin
 Result:=ReadGroup(Buffer,Count);
 if (Result=false) or (Count<17) then begin Result:=false; exit; end;
 try
  i:=1; //нулевой символ пропускаем

  while i<Count do
  begin
  ch:=#32;
  //Ищем первую скобку для шрифта
   while (i<Count) and (ch<>'{') do begin ch:=(Buffer+i)^; inc(i); end;
  if ch='{' then
  begin
   cnt:=1;  s:='{';
   while (i<count) and (cnt>0) do
     begin
        ch:=(Buffer+i)^; s:=s+ch;
        if ch='{' then inc(cnt);
        if ch='}' then dec(cnt);
        inc(i);
     end;
    Result:=FontTable.AddNew(s);
  end else Result:=false;
  end;//while

  //FDefFont может быть неопределен т.е. равен пустой строке
  if FDefFont='' then FDefFont:='0';

  FNewDefFont:=Trim(inttostr(FontTable.Old2New(strtoint(FDefFont))));
 finally
  FreeMem(Buffer,Count);
 end;

end;//ReadFontTable

//-------------------------------------------------------------------------
function TEKStream.ReadColorTable:boolean;
var Buffer:PAnsiChar;
    Count,i,cnumber:integer;
    ch:AnsiChar;
    s:AnsiString;
begin
 Result:=ReadGroup(Buffer,Count);
 if (Result=false) or (Count<12) then begin Result:=false; exit; end;
 try
  i:=10; //становимся на первый символ после слова \colortbl
  cnumber:=0;
  while i<Count do
  begin
  ch:=#32;
  //Ищем ;
  s:='';
   while (i<count) and (ch<>';') do
     begin
        ch:=(Buffer+i)^; s:=s+ch;
        inc(i);
     end;
    if ch=';' then begin
                   Result:=ColorTable.AddNew(cnumber,s);
                   inc(cnumber);
                   end;
  end;//while

 finally
  FreeMem(Buffer,Count);
 end;

end;//ReadColorTable


//-------------------------------------------------------------------
function TEKStream.ReadStyleSheet:boolean;
var Buffer:PAnsiChar;
    Count,i,cnt:integer;
    ch:AnsiChar;
    s:AnsiString;
begin
 Result:=ReadGroup(Buffer,Count);
 if (Result=false) or (Count<18) then exit;
 try

  i:=1; //нулевой символ пропускаем

  while i<Count do
  begin
  ch:=#32;
  //Ищем первую скобку для стиля
     while (i<Count) and (ch<>'{') do begin ch:=(Buffer+i)^; inc(i); end;
   if ch='{' then
   begin
    cnt:=1;  s:='{';
    while (i<count) and (cnt>0) do
     begin
        ch:=(Buffer+i)^; s:=s+ch;
        if ch='{' then inc(cnt);
        if ch='}' then dec(cnt);
        inc(i);
     end;
    Result:=StyleTable.AddNew(s);
   end else Result:=false;
  end;//while
 finally
  FreeMem(Buffer,Count);
 end;
 StyleTable.CorrectNewStyles;
end;//ReadStylesheet

//----------------------------------------------------------------
//Поиск номера элемента в массиве kwtable
//соответстующему FLastRead, FLastKey, FLastParam
function TEKStream.FindKeyword:integer;
var idx, n1, n2:integer;
    testname:AnsiString;
    s:AnsiString;
begin
 Result:=-1;
 s:=lowercase(FLastKey);
 n1:=Low(kwtable); n2:=high(kwtable);
 repeat
 idx:=n1+round((n2-n1)/2);
 testname:=kwtable[idx].n;
 if s=testname then begin n1:=idx; break; end;
 if s<testname then n2:=idx else n1:=idx;
 until n2-n1<2;
 if s=kwtable[n1].n then Result:=n1 else
          if s=kwtable[n2].n then Result:=n2;
 end; //FindKeyword

//-------------------------------------------------------------------------
function TEKstream.ProcessSkipRun(proc:word):boolean;
begin
 Result:=true;
 case proc of
 1:begin FDefFont:=FLastParam; end; //\deff0
 end; //case
end;//ProcessSkipRun

//--------------------------------------------------------------------------
function TEKStream.ProcessSaveChange(proc:word):boolean;
begin
 Result:=true;
 case proc of
 6:begin  //change fontnumber \f
   Write('\f'+Trim(inttostr(FontTable.Old2New(strtoint(FLastParam))))+FLastDelimeter);
   end;
 7:begin // change background color \cb
   Write('\cb'+Trim(inttostr(ColorTable.Old2New(strtoint(FLastParam))))+FLastDelimeter);
   end;
 8:begin // change fore color \cf  \pncf \brdrcf ...
   Write(FLastKey+Trim(inttostr(ColorTable.Old2New(strtoint(FLastParam))))+FLastDelimeter);
   end;
 9:begin // change style number for \s
   Write('\s'+Trim(inttostr(StyleTable.Old2New(strtoint(FLastParam))))+FLastDelimeter);
   end;
 10:begin // change style number for \cs
   Write('\cs'+Trim(inttostr(StyleTable.Old2New(strtoint(FLastParam))))+FLastDelimeter);
   end;
 11:begin // change style number for \ds
   Write('\ds'+Trim(inttostr(StyleTable.Old2New(strtoint(FLastParam))))+FLastDelimeter);
   end;
 12:begin //add FNewDefFont to \plain
    Write('\plain\f'+FNewDefFont+FLastDelimeter);
    end;
 13:begin //подставляем номер цвета в highlight
    Write('\highlight'+Trim(inttostr(ColorTable.Old2New(strtoint(FLastParam))))+FLastDelimeter);
    end;
 14:begin // \row в таблице меняем на \line
    if FOwner.InTable then Write('\line'+FLastDelimeter)
                      else Write('\row'+FLastDelimeter);
    end;
 15:begin //меняем номер font'а в bullet pnfNN
     Write('\pnf'+Trim(inttostr(FontTable.Old2New(strtoint(FLastParam))))+FLastDelimeter);
    end;
 16:begin //меняем \pard в таблице
    if FOwner.InTable then Write('\ql \li0\ri0\widctlpar\aspalpha\aspnum\faauto\adjustright\rin0\lin0\itap0 \cgrid'+FLastDelimeter)
                      else Write('\pard'+FLastDelimeter);
    end;
 17:begin // \clcfpat ... в таблице пропускаем, иначе записываем и меняем цвет
     if not FOwner.InTable then Write(FLastKey+Trim(inttostr(ColorTable.Old2New(strtoint(FLastParam))))+FLastDelimeter);
    end;
 end;//case
end;//ProcessSaveChange

function TEKStream.ProcessSaveRun(proc:word):boolean;
begin
 Result:=true;
 case proc of

 //3:begin  // \bin
 //  end;

 18:begin  //save \par output position
   FLastParPosition:=FOutStream.Position;
   FLastParDelimeter:=FLastDelimeter;
   Write('\par'+FLastDelimeter);
   end;
 end;//case
end;//ProcessSaveRun

//-------------------------------------------------------------------------
function TEKStream.ProcessReadBlockRun(proc:word):boolean;
var n:longint;
begin
 n:=Pop;
 if n>-1 then begin
    FStream.Seek(n,soFromBeginning);
    FPreWrite:='';

  case proc of
    2:begin Result:=ReadFontTable; end; //Read FontTable
    4:begin Result:=ReadColorTable; end; //Read ColorTable
    5:begin Result:=ReadStyleSheet; end; //Read StyleSheet
  else begin Result:=false; end;
  end;//case

 end else begin Result:=false; end;
end;//ProcessReadBlockRun;


//-------------------------------------------------------------------------
function TEKStream.ProcessSaveBlock:boolean;
var n:longint;
begin
 n:=Pop;
 if n>-1 then begin
    FStream.Seek(n,soFromBeginning);
    FPreWrite:='';
    Result:=SaveGroup;
 end else begin Result:=false; end;
end;//ProcessSaveBlock


//-------------------------------------------------------------------------
function TEKStream.ProcessSkipBlock:boolean;
var n:longint;
begin
 n:=Pop;
 if n>-1 then begin
    FStream.Seek(n,soFromBeginning);
    FPreWrite:='';
    Result:=SkipGroup;
 end else begin Result:=false; end;
end;//ProcessSkipBlock

//-------------------------------------------------------------------------
function TEKStream.ProcessKeyWord:boolean;
var num:integer;
    action:TEKkwActionMethod;
    proc:word;
begin
 Result:=true;
 num:=FindKeyWord;
 //if num>-1 then showmessage(FLastKey+' '+kwtable[num].n+' '+inttostr(num));

 if num=-1 then
 begin
    //что делать если нет в таблице
    //action:=amSave;
    action:=amSkip;
    //showmessage('|'+FPreWrite+'|'+FLastRead);
    proc:=0;
 end else begin
          action:=kwtable[num].a;
          proc:=kwtable[num].proc;
          end;

 case action of
  amSkip: begin // - Пропустить слово

          end;
  amSave: begin // - Записать слово без изменений
          Write(FLastRead);
          end;
  amSaveChange: begin // - Записать слово с изменениями
                    // - изменить номер шрифта, цвет, либо другие атрибуты
             ProcessSaveChange(proc);
          end;
  amSaveRun: begin // - Записать и что-нибудь сделать,
                  // например записать \bin и следующие за ним данные
               ProcessSaveRun(proc);
             end;
  amSkipRun: begin // - Пропустить и выполнить процедуру,
                  // напрмер \deff0 - пропустить и взять номер default font
             ProcessSkipRun(proc);
          end;
  amSkipBlock: begin // - Пропустить группу, например {\info}
             ProcessSkipBlock;
          end;
  amSaveBlock: begin // - Записать группу без изменений, например {\object}, {\pict}
             ProcessSaveBlock;
          end;
  amReadBlockRun: begin // - Считать группу и выполнить процедуру
                       // например fonttbl или colortbl
             ProcessReadBlockRun(proc);
          end;

  amSkipInTable: begin // Пропустить если в таблице
                 if not FOwner.InTable then Write(FLastRead);
                end;
 end;//case

end; //ProcessKeyWord

//--------------- Main Cycle --------------------------
function TEKStream.Process: boolean;
var ln:longint;
    kwResult:TEKkwType;
begin
 if FOutStream=nil then begin Result:=false; exit; end;

 Result:=true;
 repeat
 kwResult:=ReadNext;
   case kwResult of
   kwOpen   :begin //opening brace
             Push;
               ln:=length(FPreWrite);
               if ln>0 then FOutStream.WriteBuffer(pointer(FPreWrite)^,ln);
               FPreWrite:='{';
             end;
   kwClose  :begin //closing brace
             Pop;
             Write(FlastRead);
             end;
   kwKeyDest:begin
             FPreWrite:=FPreWrite+FLastRead; // это будет \* может быть с пробелом
             end;
   kwKeyWord:begin
             ProcessKeyWord;
             end;
   kwKeyChar:begin
              Write(FlastRead);
             end;
   kwHexChar:begin
              Write(FlastRead);
             end;
   kwChar   :begin
              Write(FlastRead);
             end;
   end;//case kwResult



 until kwResult=kwNone;

  //Showmessage(']'+FLastRead+'[');
 //Showmessage(s+':'+inttostr(fstackcur)+':'+inttostr(fstacksize));

end;//TEKStream.Process


procedure InsertRtfMemo(Sender:TObject; OutputStream:TStream; var RtfContent:AnsiString);
var f:integer;
    RTFData:TMemoryStream;
    Bs:TStringStream;
    EKs:TEkStream;
 begin

  Eks:=nil;
  Bs:=nil;

  try
    Bs:=TStringStream.create(RtfContent);
    RTFData:=TMemoryStream.Create;
    RTFData.CopyFrom(Bs,0);
    RTFData.Seek(0,sofrombeginning);
  finally
    if Assigned(BS) then BS.Free;
  end;//try

 try
  EKs:=TEkStream.Create(TEkBaseRtfReport(Sender),RTFData);
  EKs.OutStream:=OutputStream;

  EKs.FontTable.AddFromList(TEkBaseRtfReport(Sender).RTFFont);
  for f:=0 to TEkBaseRtfReport(Sender).RTFColor.Count-1 do EKs.ColorTable.Add(TEkBaseRtfReport(Sender).RTFColor[f]);
  for f:=0 to TEkBaseRtfReport(Sender).RTFStyle.Count-1 do EKs.StyleTable.Add(TEkBaseRtfReport(Sender).RTFStyle[f]);

 EKs.Process;

 With Sender as TEkBaseRtfReport do begin
   RTFFont.Clear;
   for f:=0 to EKs.FontTable.Count-1 do RTFFont.Add(EKs.FontTable.Strings[f]);
   RTFColor.Clear;
   for f:=0 to EKs.ColorTable.Count-1 do RTFColor.Add(EKs.ColorTable.Strings[f]);
   RTFStyle.Clear;
   for f:=0 to EKs.StyleTable.Count-1 do RTFStyle.Add(EKs.StyleTable.Strings[f]);
 end;

 finally

 if Assigned(EKs) then EKs.Free;
 if Assigned(RTFData) then RTFData.Free;

 end;//try

end;//procedure InsertRtfMemo

procedure InsertRtfMemoPar(Sender:TObject; OutputStream:TStream; var RtfContent:AnsiString);
var f:integer;
    RTFData:TMemoryStream;
    Bs:TStringStream;
    EKs:TEkStream;
    PCur, PPar:int64;
 begin

  Eks:=nil;
  Bs:=nil;

  try
    Bs:=TStringStream.create(RtfContent);
    RTFData:=TMemoryStream.Create;
    RTFData.CopyFrom(Bs,0);
    RTFData.Seek(0,sofrombeginning);
  finally
    if Assigned(BS) then BS.Free;
  end;//try

 try
  EKs:=TEkStream.Create(TEkBaseRtfReport(Sender),RTFData);
  EKs.OutStream:=OutputStream;

  EKs.FontTable.AddFromList(TEkBaseRtfReport(Sender).RTFFont);
  for f:=0 to TEkBaseRtfReport(Sender).RTFColor.Count-1 do EKs.ColorTable.Add(TEkBaseRtfReport(Sender).RTFColor[f]);
  for f:=0 to TEkBaseRtfReport(Sender).RTFStyle.Count-1 do EKs.StyleTable.Add(TEkBaseRtfReport(Sender).RTFStyle[f]);

 EKs.Process;

 With Sender as TEkBaseRtfReport do begin
   RTFFont.Clear;
   for f:=0 to EKs.FontTable.Count-1 do RTFFont.Add(EKs.FontTable.Strings[f]);
   RTFColor.Clear;
   for f:=0 to EKs.ColorTable.Count-1 do RTFColor.Add(EKs.ColorTable.Strings[f]);
   RTFStyle.Clear;
   for f:=0 to EKs.StyleTable.Count-1 do RTFStyle.Add(EKs.StyleTable.Strings[f]);
 end;

 PCur:=EKs.OutStream.Position;
 PPar:=EKs.FLastParPosition;
 if PPar>-1 then begin
   EKs.OutStream.Seek(PPar-PCur,soFromCurrent);
   EKs.Write(#13#13#13#13);
   if length(EKs.FLastParDelimeter)>0 then for f:=1 to length(EKs.FLastParDelimeter) do EKs.Write(#13);
   EKs.OutStream.Seek(PCur,soFromBeginning);
 end;

 finally

 if Assigned(EKs) then EKs.Free;
 if Assigned(RTFData) then RTFData.Free;

 end;//try

end;//procedure InsertRtfMemoPar


procedure InsertRtfMemoStream(Sender:TObject; OutputStream:TStream; var RtfStream:TStream);
var f:integer;
    EKs:TEkStream;
 begin

  Eks:=nil;

 try
  RtfStream.Seek(0,sofrombeginning);
  EKs:=TEkStream.Create(TEkBaseRtfReport(Sender),RtfStream);
  EKs.OutStream:=OutputStream;

  EKs.FontTable.AddFromList(TEkBaseRtfReport(Sender).RTFFont);
  for f:=0 to TEkBaseRtfReport(Sender).RTFColor.Count-1 do EKs.ColorTable.Add(TEkBaseRtfReport(Sender).RTFColor[f]);
  for f:=0 to TEkBaseRtfReport(Sender).RTFStyle.Count-1 do EKs.StyleTable.Add(TEkBaseRtfReport(Sender).RTFStyle[f]);

 EKs.Process;

 With Sender as TEkBaseRtfReport do begin
   RTFFont.Clear;
   for f:=0 to EKs.FontTable.Count-1 do RTFFont.Add(EKs.FontTable.Strings[f]);
   RTFColor.Clear;
   for f:=0 to EKs.ColorTable.Count-1 do RTFColor.Add(EKs.ColorTable.Strings[f]);
   RTFStyle.Clear;
   for f:=0 to EKs.StyleTable.Count-1 do RTFStyle.Add(EKs.StyleTable.Strings[f]);
 end;

 finally

 if Assigned(EKs) then EKs.Free;

 end;//try

end;//procedure InsertRtfMemoStream


procedure InsertRtfMemoStreamPar(Sender:TObject; OutputStream:TStream; var RtfStream:TStream);
var f:integer;
    EKs:TEkStream;
    PCur, PPar:int64;
 begin

  Eks:=nil;

 try
  RtfStream.Seek(0,sofrombeginning);
  EKs:=TEkStream.Create(TEkBaseRtfReport(Sender),RtfStream);
  EKs.OutStream:=OutputStream;

  EKs.FontTable.AddFromList(TEkBaseRtfReport(Sender).RTFFont);
  for f:=0 to TEkBaseRtfReport(Sender).RTFColor.Count-1 do EKs.ColorTable.Add(TEkBaseRtfReport(Sender).RTFColor[f]);
  for f:=0 to TEkBaseRtfReport(Sender).RTFStyle.Count-1 do EKs.StyleTable.Add(TEkBaseRtfReport(Sender).RTFStyle[f]);

 EKs.Process;

 With Sender as TEkBaseRtfReport do begin
   RTFFont.Clear;
   for f:=0 to EKs.FontTable.Count-1 do RTFFont.Add(EKs.FontTable.Strings[f]);
   RTFColor.Clear;
   for f:=0 to EKs.ColorTable.Count-1 do RTFColor.Add(EKs.ColorTable.Strings[f]);
   RTFStyle.Clear;
   for f:=0 to EKs.StyleTable.Count-1 do RTFStyle.Add(EKs.StyleTable.Strings[f]);
 end;

 PCur:=EKs.OutStream.Position;
 PPar:=EKs.FLastParPosition;
 if PPar>-1 then begin
   EKs.OutStream.Seek(PPar-PCur,soFromCurrent);
   EKs.Write(#13#13#13#13);
   if length(EKs.FLastParDelimeter)>0 then for f:=1 to length(EKs.FLastParDelimeter) do EKs.Write(#13);
   EKs.OutStream.Seek(PCur,soFromBeginning);
 end;

 finally

 if Assigned(EKs) then EKs.Free;

 end;//try

end;//procedure InsertRtfMemoStreamPar



end.

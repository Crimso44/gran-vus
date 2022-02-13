(*****************************************)
(*           Ek RTF report v 2.02        *)
(*   (C) Eugene Kuchugurov, 2000-2003    *)
(*****************************************)
unit ekbasereport;

interface
uses
  Windows,
{$IFDEF VER120}
  FileCtrl,
{$ENDIF}
{$IFDEF VER130}
  FileCtrl,
{$ENDIF}
   SysUtils, Classes, Graphics,
  conscom,  ekfunc; 


  type
    TEkBaseReport=class;

  TEkReportVariable=class
     private
       FOwnerBaseReport:TEkBaseReport;
       FVarName:AnsiString;
       FLocal:boolean;
       FLocalValue:AnsiString;
     protected
       property OwnerBaseReport:TEkBaseReport read FOwnerBaseReport;
       function GetCheckVarNumber(ErrMsg:AnsiString):longint;
       function GetAsString:AnsiString;
       procedure SetAsString(Value:AnsiString);
       function GetAsFloat:Double;
       procedure SetAsFloat(Value:Double);
       function GetAsInteger:int64;
       procedure SetAsInteger(Value:int64);
       function GetAsDate:TDateTime;
       procedure SetAsDate(Value:TDateTime);
       function GetAsDateTime:TDateTime;
       procedure SetAsDateTime(Value:TDateTime);
       function GetAsBoolean:boolean;
       procedure SetAsBoolean(Value:boolean);
       procedure SetLocal(Value:boolean);
     public
       //***!!! was protected
       property Local:boolean read FLocal write SetLocal;
       procedure SetVarName(VarName:AnsiString);

       constructor create(VarOwner:TEkBaseReport);
       property AsString:AnsiString read GetAsString write SetAsString;
       property AsFloat:Double read GetAsFloat write SetAsFloat;
       property AsInteger:int64 read GetAsInteger write SetAsInteger;
       property AsDate:TDateTime read GetAsDate write SetAsDate;
       property AsDateTime:TDateTime read GetAsDateTime write SetAsDateTime;
       property AsBoolean:boolean read GetAsBoolean write SetAsBoolean;
       property Name:AnsiString read FVarName;
       //destructor destroy;override;
  end;

  TEkOperand=record
    Text:AnsiString;
    IsOperand:boolean;
    ReqBoolArg:boolean;
    AllowBoolArg:boolean;
    RetBoolRes:boolean;
    Priority:integer;
    Fldnum:integer;
  end;

  TEkOperationStack=class
  private
    FExpression:array of TEkOperand;
    FCount:integer;
    function GetOperation(index:integer):TEkOperand;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Push(MOperand:TEkOperand);
    function Pop:TEkOperand;
    property Count:integer read FCount;
    property Operation[index:integer]: TEkOperand read GetOperation;    
  end;


  TEkExpression=class
  private
    FExpression:array of TEkOperand;
    FCount:integer;
    function GetOperand(index:integer):TEkOperand;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(MText:AnsiString; MIsOperand,MReqBoolArg, MAllowBoolArg, MRetBoolRes:boolean; MPriority,MFldnum:integer);overload;
    procedure Add(MOperand:TEkOperand);overload;    
    property Operand[index:integer]: TEkOperand read GetOperand;
    property Count:integer read FCount;
  end;


  TEkRcTypes=(rcdata, rcsimple, rcnottext);
  TEkRowContent=record
       stestf,
       Dalias,
       Field,
       sout:AnsiString;
       NField:longint;
       fmt:TEkFieldFormat;
       ftype, DefinedType:TEkRcTypes;
       Defined:boolean;
   end;


  TEkBaseReport = class(TComponent)
  private
    FVarList:TStrings;
    FReportVariable:TEkReportVariable;
    FTrueValue:AnsiString;
    FFalseValue:AnsiString;
    FDecimalRTerminator:AnsiChar;
    FDecimalRSeparator:AnsiChar;
    FUDFList:TEkUDFList;

    FInFile:TFileName;
    FOutFile:TFileName;

    FInDList:TStringList; //List of input data files names Name=NNN

    FExecute:boolean; //is report executing
    FOnFinished:TNotifyEvent;

    FPFile:PAnsiChar;
    FTmLoaded:boolean;
    Fpnt,Flent : longint;
    FLastBoundaryPnt: longint;
    FKwdPnt    : longint;
    FSzi:longint;

    FTmpStream:TStream;  //Temporary stream
    FTmpFileName:String; //Temporary file in case of not using memory
    FOutStream:TStream;   //for output to memory
    FUseStream:boolean;   //use output to memory
    FOutf  : TStream;     //foutf is created file stream or =FOutStream
    FOutfCreated:boolean; //had been outfile created?

    FCmPos:longint;
    FCmLastId:longint;
    FCmLastFpnt:longint;
    FCmSkip:longint;
    FCmStream: TMemoryStream;
    FCmStrings: array of AnsiString;

  protected
    procedure SetVarList(Value:Tstrings);
    procedure SetTrueValue(Value:AnsiString);
    procedure SetFalseValue(Value:AnsiString);
    procedure SetUDFList(Value:TEkUDFList);
    procedure SetInFile(Value:TFileName);
    procedure SetOutFile(Value:TFileName);
    procedure SetOnFinished(Value: TNotifyEvent);

    function CmStoreString(var s:AnsiString):longint;
    function CmGetString(n:longint):AnsiString;
    procedure CmSaveItemInfo(id, skipbytes, cmfpnt:integer);
    procedure CmReadItemInfo;
    procedure CmSaveItemPos;
    procedure CmReadItemPos;
    procedure CmSaveBegin;
    procedure CmSaveEnd;

    procedure CmSaveBlocItem; virtual;
    procedure CmReadBlocItem; virtual;
    procedure CmSaveBalancedBlocItem; virtual;
    procedure CmReadBalancedBlocItem; virtual;
    procedure CmSaveTableBegin; virtual;
    procedure CmReadTableBegin; virtual;
    procedure CmSaveTableEnd; virtual;
    procedure CmReadTableEnd; virtual;
    procedure CmSaveRawItem(var s:AnsiString); virtual;
    procedure CmReadRawItem(var s:AnsiString); virtual;
    procedure CmSaveScanItem(var OutStr,SPar:AnsiString; n:word); virtual;
    procedure CmReadScanItem(var OutStr,SPar:AnsiString;var n:word); virtual;
    procedure CmSaveScanWhileItem(var OutStr,SPar:AnsiString; n:word); virtual;
    procedure CmReadScanWhileItem(var OutStr,SPar:AnsiString;var n:word); virtual;
    procedure CmSaveIfItem(var OutStr,SPar:AnsiString; n:word; elseflag:boolean); virtual;
    procedure CmReadIfItem(var OutStr,SPar:AnsiString;var n:word; var elseflag:boolean); virtual;
    procedure CmSaveScanEntryItem(var OutStr,SPar:AnsiString; n:word); virtual;
    procedure CmReadScanEntryItem(var OutStr,SPar:AnsiString; var n:word); virtual;
    procedure CmSaveScanFooterItem(var OutStr,SPar:AnsiString; n:word); virtual;
    procedure CmReadScanFooterItem(var OutStr,SPar:AnsiString; var n:word); virtual;
    procedure CmSaveEndScanItem(var OutStr,SPar:AnsiString; n:word); virtual;
    procedure CmReadEndScanItem(var OutStr,SPar:AnsiString;var n:word); virtual;
    procedure CmSaveEndIfItem(var OutStr,SPar:AnsiString; n:word); virtual;
    procedure CmReadEndIfItem(var OutStr,SPar:AnsiString;var n:word); virtual;
    procedure CmSaveScanSkipItem(n:word); virtual;
    procedure CmReadScanSkipItem(var n:word); virtual;
    procedure CmSaveScanFirstItem(n:word); virtual;
    procedure CmReadScanFirstItem(var n:word); virtual;
    procedure CmSaveField(id:longint; FieldContent:TEKRowContent); virtual;
    procedure CmUpdateField(n:longint; tp:TEkRcTypes; defined:boolean); virtual;
    procedure CmReadField(var FieldContent:TEKRowContent); virtual;
    procedure CmSaveExprBeginItem(FieldContent:TEKRowContent; InDocument,IsManage:boolean; ScanNum:word); virtual;
    procedure CmReadExprBeginItem(var FieldContent:TEKRowContent; var InDocument,IsManage:boolean; var ScanNum:word); virtual;
    procedure CmSaveExprEndItem; virtual;
    procedure CmReadExprEndItem; virtual;
    procedure CmSaveExecuteUDFItem(udfnumber,parcount:longint); virtual;
    procedure CmReadExecuteUDFItem(out udfnumber,parcount:longint); virtual;


    procedure SetOutfToNil;
    procedure SetOutfToTmp;
    procedure SetOutf;
    procedure FreeOutf;
    procedure CreateCmStream;
    procedure FreeCmStream;
    procedure SeekToBeginCmStream;
    procedure CreateTmpStream;
    procedure FreeTmpStream;

    function GetVarNumber(ident:AnsiString):integer;
    function GetVarByNumber(number:integer):AnsiString;

    function CtoN(c: AnsiString): integer; virtual;
    function SplitArgs(s:AnsiString; var List:TStringList):boolean;
    function LeftQuote(c:AnsiChar):boolean; virtual; abstract;
    function RightQuote(lc,rc:AnsiChar):boolean; virtual; abstract;
    function IsQuoted(s:AnsiString):boolean; virtual; abstract;
    function CheckFormat(var s:AnsiString):TEkFieldFormat;
    function DateConstToStr(s:AnsiString):AnsiString;

    procedure ReadFileBody;
    procedure wr(s:AnsiString);
    function  FileEof:boolean;
    function FileBof:boolean;

    function  GetUDFNumber(s:AnsiString; out udfnumber:longint):boolean;
    function  GetArgMinCount(udfnumber:longint):longint;
    function  GetArgMaxCount(udfnumber:longint):longint;
    function  GetUDFResultType(udfnumber:longint):longint;
    function  CheckUdfFormat(var udfnumber:longint; var infmtvar:TEkFieldFormat):boolean;
    function  ProcessUDFName(fname:AnsiString; udfargs:TStringList; out udfnumber:longint):boolean;
    procedure IncPnt(delta:longint);

    property PFile:PAnsiChar read FPfile;
    property Pnt:longint read Fpnt write Fpnt;
    property Lent:longint read Flent write Flent;
    property LastBoundaryPnt: longint read FLastBoundaryPnt write FLastBoundaryPnt;
    property KwdPnt: longint read FKwdPnt write FKwdPnt;
    property Szi:longint read FSzi;
    property UseStream:boolean read FUseStream write FUseStream;
    property TmLoaded:boolean read FTmLoaded;
    property IsExecute:boolean read FExecute write FExecute;
    property InDList:TStringList read FInDlist write FInDList;

    property OutputUserStream:TStream read FOutStream write FOutStream;
    property TmpStream:TStream read FTmpStream;
    property Outf:TStream read FOutf;
    property OutfCreated:boolean read FOutfCreated;
    property CmLastId:longint read FCmLastId;
    property CmLastPnt:longint read FCmLastFpnt;
    property CmSkip:longint read FCmSkip;
    property CmPos:longint read FCmPos;
    property CmStream:TMemoryStream read FCmStream;

  public
    function Letter(ch:AnsiChar):boolean;
    function Digit(ch:AnsiChar):boolean;
    function ZeroOut(s:AnsiString):boolean;

    property DecimalRTerminator:AnsiChar read FDecimalRTerminator write FDecimalRTerminator;
    property DecimalRSeparator:AnsiChar read FDecimalRSeparator write FDecimalRSeparator;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Notification(AComponent:TComponent; Operation:TOperation); override;
    function ShellOpenFile(const FileName:WideString; ShowCmd: Integer): THandle; virtual;
    function CreateTmpFileName(Prefix: String): AnsiString;
    procedure FreeTemplate;
    procedure SetTemplateBuffer(Buffer:pointer; Size:longint);
    function VarByName(VarName:AnsiString):TEkReportVariable;
    procedure ClearVars;
    procedure CreateVar(Name:AnsiString; Value:AnsiString);overload;
    procedure CreateVar(Name:AnsiString; Value:Double);overload;
    procedure CreateVar(Name:AnsiString; Value:TDateTime; IgnoreTime:boolean);overload;
    procedure CreateVar(Name:AnsiString; Value:boolean);overload;
    procedure FreeVar(Name:AnsiString);
    function Version:longint;

  published

    property OnFinished:TNotifyEvent read FOnFinished write SetOnFinished;

    property InFile:TFileName read FInFile write SetInFile;
    property OutFile:TFileName read FOutFile write SetOutFile;
    property VarList:TStrings read FVarList write SetVarList;
    property TrueValue:AnsiString read FTrueValue write SetTrueValue;
    property FalseValue:AnsiString read FFalseValue write SetFalseValue;
    property UDFList:TEkUDFList read FUDFList write SetUDFList;
  end;

  type
  TEkColor=class
  private
   fr,fg,fb:byte;
  protected
   function GetColor:TColor;
   procedure SetColor(Value:TColor);
   procedure SetFr(Value:byte);
   procedure SetFg(Value:byte);
   procedure SetFb(Value:byte);
  public
   constructor create;
   property r:byte read fr write Setfr;
   property g:byte read fg write Setfg;
   property b:byte read fb write Setfb;
   property color:TColor read GetColor write SetColor;
  end;

  TEkColorArray=array of TEkColor;

  //Report options
  TEkRTFOption=(eoGraphicsWmfCompatible, eoGraphicsBinary, eoClearMissedFields,
                   eoDotAsColon, eoNumericFormatClearZero);
  TEkRTFOptions=set of TEkRTFOption;

  TEkOutTabRec = record
                 n1, n2, id:longint;
                 end;
  TEkOutTabArray = array of TEkOutTabRec;

  TEkFontStringList = class(TStringList);

  TEkColorStringList = class(TStringList)
  public
    function UseColor(s:AnsiString):longint;
  end;

     TEkImageFormat=class
           private
            FSizeXmm, FSizeYmm:Double;
            FSizeX,FSizeY:Word;
            FScaleX,FScaleY:Word;
            FBorder:TEkImageBorder;
            FBorderTwips:byte;
            FProportional:boolean;
           protected
            procedure SetScaleX(Value:Word);
            procedure SetScaleY(Value:Word);
            procedure SetSizeXmm(Value:Double);
            procedure SetSizeYmm(Value:Double);
            procedure SetBorder(Value:TEkImageBorder);
           public
            constructor create(x,y:word);
            procedure FitScaleToX(x:word);
            procedure FitScaleToY(y:word);
            procedure SetSizeXY(x,y:word);
            procedure SetBorderType(BrType:TEkImageBorderType; BrWidth:Single; ColorIndex:Word);
            property SizeX:Word read FSizeX;
            property SizeY:Word read FSizeY; //Size X,Y in pixels
            property ScaleX:Word read FScaleX write SetScaleX;
            property ScaleY:Word read FScaleY write SetScaleY; //Scale 1-100
            property SizeXmm:Double read FSizeXmm write SetSizeXmm;
            property SizeYmm:Double read FSizeYmm write SetSizeYmm;
            property Border:TEkImageBorder read FBorder;
            property BorderTwips:byte read FBorderTwips;
            property Proportional:boolean read FProportional write FProportional;
           end;//TEkImageFormat

  TEkOnImageFormat = procedure(FormatIndex:integer; var ImageFormat:TEkImageFormat) of object;

  TEkBaseRTFReport=class(TEkBaseReport)
  private
    FOutTab:TEkOutTabArray;

    FCharset:TFontCharset;
    FLang:TEkLanguageID;

    FQuoteIndex:longint;
    FQuoteSkip:longint;
    FQuoteStr:AnsiString;

    FIsFontTable:boolean;
    FIsColorTable:boolean;
    FIsStyle:boolean;
    FIsDocInfo:boolean;
    FInTable:boolean;

    FDocColorCount:Word;    //Color count in table in input file
    FDocColorTable:TEkColorArray; //Colors in color table in input file
    FColorCount:Word;       //16
    FColorTable:TEkColorArray;

    FRTFFont:TEkFontStringList;  //list for font table ***!!!
    FRTFColor:TEkColorStringList;
    FRTFStyle:TStringList;
    FRTFDocInfo:TStringList;

    FOptions:TEkRTFOptions;

  protected
    function GetCharset: TFontCharset;
    procedure SetCharset(Value: TFontCharset);
    function GetLang: TEkLanguageID;
    procedure SetLang(Value:TEkLanguageID);
    procedure SetOptions(Value:TEkRTFOptions);

    procedure CmSaveFontTable;
    procedure CmReadFontTable;
    procedure CmSaveColorTable;
    procedure CmReadColorTable;
    procedure CmSaveStyleSheet;
    procedure CmReadStyleSheet;
    procedure CmSaveDocInfo;
    procedure CmReadDocInfo;

    procedure ReadFb(var ch:AnsiChar);
    procedure ReadBack(var ch:AnsiChar);
    function LeftQuote(c:AnsiChar):boolean; override;
    function RightQuote(lc,rc:AnsiChar):boolean; override;
    function IsQuoted(s:AnsiString):boolean; override;

    procedure OutRaw;
    procedure OutColorTable;
    procedure OutFontTable;
    procedure OutStyle;

    procedure SaveToOutTable(fid:longint);
    procedure CutRtString(rtstring:AnsiString; var fldstring, outstring:AnsiString);
    function getnch(n:integer):AnsiChar;
    function GetNextReportField:AnsiString;
    function KillPar:AnsiString;


    property IsFontTable:boolean read FIsFontTable write FIsFontTable;
    property IsColorTable:boolean read FIsColorTable write FIsFontTable;
    property IsStyle:boolean read FIsStyle write FIsStyle;
    property IsDocInfo:boolean read FIsDocInfo write FIsDocInfo;
    property DocColorTable:TEkColorArray read FDocColorTable write FDocColorTable;
    property DocColorCount:Word read FDocColorCount write FDocColorCount;

    property OutTab:TEkOutTabArray read FOutTab write FOutTab;


  public
    property RTFFont:TEkFontStringList read FRTFFont write FRTFFont;
    property RTFColor:TEkColorStringList read FRTFColor write FRTFColor;
    property RTFStyle:TStringList read FRTFStyle write FRTFStyle;
    property RTFDocInfo:TStringList read FRTFDocInfo write FRTFDocInfo;

    property InTable:boolean read FInTable write FInTable;
    property ColorTable:TEkColorArray read FColorTable;
    property ColorCount:Word read FColorCount;

    function txt2rtf(s:AnsiString):AnsiString;
    function CreateFileName(Directory, Prefix: AnsiString): AnsiString; overload; virtual;
    function CreateFileName(Directory, Prefix, Extension: AnsiString): AnsiString; overload; virtual;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property Charset: TFontCharset read GetCharset write SetCharset;
    property Lang:TEkLanguageID read GetLang write SetLang;
    property Options:TEkRTFOptions read FOptions write SetOptions;
  end;


implementation
uses ShellApi;

{----------------- common functions -------------------}

function TEkBaseReport.CreateTmpFileName(Prefix: String): AnsiString;
var
  Path : array[0..MAX_PATH] of WideChar;
    sf : array[0..MAX_PATH] of WideChar;
  xPrefix: WideString;
begin
    FillChar(Path,SizeOf(Path),#0);
    FillChar(sf,SizeOf(sf),#0);
    GetTempPath(MAX_PATH,Path);
    xPrefix := Prefix;
    GetTempFilename(@Path, PWideChar(Prefix), 0, @sf);
    Result := sf;
end;


function TEkBaseReport.Letter(ch:AnsiChar):boolean;
begin
Result:=false;
if ((ch>='a') and (ch<='z')) or ((ch>='A') and (ch<='Z')) then Result:=true;
end;


function TEkBaseReport.Digit(ch:AnsiChar):boolean;
begin
Result:=false;
if (ch='0') or(ch='1') or (ch='2') or (ch='3') or
   (ch='4') or (ch='5') or (ch='6') or (ch='7') or
   (ch='8') or (ch='9') then Result:=True;
end; //Digit

function TEkBaseReport.ZeroOut(s:AnsiString):boolean;
var f,ln:longint;
begin
 Result:=true;
 ln:=length(s);
 for f:=1 to ln do if (Digit(s[f])) and (s[f]<>'0') then begin Result:=false; exit; end;
end;

function TEkBaseReport.CtoN(c: AnsiString): integer;
var s,sn:AnsiString;
begin
   s:=UpperCase(trim(c));
   if Length(s)=0 then begin Result:=-1; exit; end;
   if (Length(s)=1) and (s>='A') and (S<='Z')
      then begin Result:=ord(S[1])-ord('A'); exit; end;

   sn:=FInDList.Values[s];
   if length(sn)>0 then Result:=strtoint(sn) else Result:=-1;
end;//TEkBaseReport.CtoN


{ TEkReportVariable }
constructor TEkReportVariable.create(VarOwner:TEkBaseReport);
begin
 FOwnerBaseReport:=VarOwner;
 FVarName:='';
 if VarOwner=nil then FLocal:=true else FLocal:=false;
 FLocalValue:='';
end;

procedure TEkReportVariable.SetLocal(Value:boolean);
begin
 if Flocal<>Value then begin
    Flocal:=Value;
    FLocalValue:='';
 end;
end;

procedure TEkReportVariable.SetVarName(VarName:AnsiString);
begin
 FVarName:=VarName;
end;

function TEkReportVariable.GetCheckVarNumber(ErrMsg:AnsiString):longint;
begin
 Result:=0;
 if not Local then begin
    With OwnerBaseReport do
    begin
    Result:=GetVarNumber(FVarName);
    if Result=0 then raise EIOError.create(ErrMsg+': report variable not found: '+FVarName);
    end;//with
 end;//if not local
end;

function TEkReportVariable.GetAsString: AnsiString;
var i:longint;
begin
  Result:='';
  if Local then begin
    Result:=FLocalValue;
  end else begin
    With OwnerBaseReport do
    begin
      i:=GetCheckVarNumber('Get variable');
      Result:=GetVarByNumber(i);
    end;//with
  end;//if local
end;//TEkReportVariable.GetAsString

procedure TEkReportVariable.SetAsString(Value: AnsiString);
var i:longint;
begin
  if Local then begin
    FLocalValue:=Value;
  end else begin
     With OwnerBaseReport do
     begin
     i:=GetCheckVarNumber('Set variable');
     FVarList.Strings[i-1]:=FVarName+'='+Value;
     end;//with
  end;//if local
end;//TEkReportVariable.SetAsString

function TEkReportVariable.GetAsFloat: Double;
var i:longint;
    sv:AnsiString;
begin
  if Local then begin
    sv:=FLocalValue;
    if length(Trim(sv))=0 then sv:='0';
    Result:=StrToFloat(sv);
  end else begin
    With OwnerBaseReport do
    begin
    i:=GetCheckVarNumber('Get variable');
    sv:=GetVarByNumber(i);
    if length(Trim(sv))=0 then sv:='0';
    Result:=StrToFloat(sv);
    end;//with
  end;//if local
end;//TEkReportVariable.GetAsFloat

procedure TEkReportVariable.SetAsFloat(Value: Double);
var i:longint;
begin
  if Local then begin
     FLocalValue:=FloatToStr(Value);
  end else begin
     With OwnerBaseReport do
     begin
     i:=GetCheckVarNumber('Set variable');
     FVarList.Strings[i-1]:=FVarName+'='+FloatToStr(Value);
     end;//with
  end;//if local
end;//TEkReportVariable.SetAsFloat

function TEkReportVariable.GetAsInteger: int64;
var i:longint;
    sv:AnsiString;
begin
  if Local then begin
     sv:=FLocalValue;
     if length(Trim(sv))=0 then sv:='0';
     Result:=StrToInt64(sv);
  end else begin
     With OwnerBaseReport do
     begin
     i:=GetCheckVarNumber('Get variable');
     sv:=GetVarByNumber(i);
     if length(Trim(sv))=0 then sv:='0';
     Result:=StrToInt64(sv);
     end;//with
  end;//if local
end;//TEkReportVariable.GetAsFloat

procedure TEkReportVariable.SetAsInteger(Value: int64);
var i:longint;
begin
  if Local then begin
     FLocalValue:=IntToStr(Value);
  end else begin
     With OwnerBaseReport do
     begin
     i:=GetCheckVarNumber('Set variable');
     FVarList.Strings[i-1]:=FVarName+'='+IntToStr(Value);
     end;//with
  end;//if local
end;//TEkReportVariable.SetAsFloat

function TEkReportVariable.GetAsDate: TDateTime;
var i:longint;
begin
  if Local then begin
     Result:=StrToDate(FLocalValue);
  end else begin
     With OwnerBaseReport do
     begin
     i:=GetCheckVarNumber('Get variable');
     Result:=StrToDate(GetVarByNumber(i));
     end;//with
  end;//if local
end;//TEkReportVariable.GetAsDate

procedure TEkReportVariable.SetAsDate(Value: TDateTime);
var i:longint;
begin
  if Local then begin
     FLocalValue:=DateToStr(Value);
  end else begin
     With OwnerBaseReport do
     begin
     i:=GetCheckVarNumber('Set variable');
     FVarList.Strings[i-1]:=FVarName+'='+DateToStr(Value);
     end;//with
  end;//if local
end;//TEkReportVariable.SetAsDate

function TEkReportVariable.GetAsDateTime: TDateTime;
var i:longint;
begin
  if Local then begin
    Result:=StrToDateTime(FLocalValue);
  end else begin
    With OwnerBaseReport do
    begin
    i:=GetCheckVarNumber('Get variable');
    Result:=StrToDateTime(GetVarByNumber(i));
    end;//with
  end;//if local
end;//TEkReportVariable.GetAsDateTime

procedure TEkReportVariable.SetAsDateTime(Value: TDateTime);
var i:longint;
begin
  if Local then begin
     FLocalValue:=DateTimeToStr(Value);
  end else begin
     With OwnerBaseReport do
     begin
     i:=GetCheckVarNumber('Set variable');
     FVarList.Strings[i-1]:=FVarName+'='+DateTimeToStr(Value);
     end;//with
  end;//if local
end;//TEkReportVariable.SetAsDateTime

function TEkReportVariable.GetAsBoolean: boolean;
var i:longint;
    s:AnsiString;
begin
  if Local then begin
     s:=FLocalValue;
     Result:=false; if (s=OwnerBaseReport.FTrueValue)or(UpperCase(s)='TRUE') then Result:=true;
  end else begin
     With OwnerBaseReport do
     begin
      i:=GetCheckVarNumber('Get variable');
      s:=GetVarByNumber(i);
      Result:=false;
      if (s=FTrueValue)or(UpperCase(s)='TRUE') then Result:=true;
     end;//with
  end;//if local
end;//TEkReportVariable.GetAsBoolean

procedure TEkReportVariable.SetAsBoolean(Value: boolean);
var i:longint;
    s:AnsiString;
begin

  With OwnerBaseReport do begin
    if Value then s:=FTrueValue else s:=FFalseValue;
    if FTrueValue=FFalseValue then
    begin
       if Value then s:='True' else s:='False';
    end;
  end;//with

  if Local then begin
     FLocalValue:=s;
  end else begin
     With OwnerBaseReport do
     begin
     i:=GetCheckVarNumber('Set variable');
     FVarList.Strings[i-1]:=FVarName+'='+s;
     end;//with
  end;//if local

end;//TEkReportVariable.SetAsBoolean


{ TEkBaseReport }

procedure TEkBaseReport.ClearVars;
begin
 VarList.Clear;
 FReportVariable.SetVarName('');
end;

procedure TEkBaseReport.CreateVar(Name: AnsiString; Value: boolean);
begin
   if GetVarNumber(Name)>0 then raise EIOError.create('Can''t add report variable '+Name+' - variable already exists.')
      else if value then VarList.Add(Trim(Name)+'='+FTrueValue)
                    else VarList.Add(Trim(Name)+'='+FFalseValue);
end;

procedure TEkBaseReport.CreateVar(Name, Value: AnsiString);
begin
   if GetVarNumber(Name)>0 then raise EIOError.create('Can''t add report variable '+Name+' - variable already exists.')
      else VarList.Add(Trim(Name)+'='+Value);
end;

procedure TEkBaseReport.CreateVar(Name: AnsiString; Value: Double);
begin
   if GetVarNumber(Name)>0 then raise EIOError.create('Can''t add report variable '+Name+' - variable already exists.')
      else VarList.Add(Trim(Name)+'='+FloatToStr(Value));
end;

procedure TEkBaseReport.CreateVar(Name: AnsiString; Value: TDateTime;
  IgnoreTime: boolean);
begin
   if GetVarNumber(Name)>0 then raise EIOError.create('Can''t add report variable '+Name+' - variable already exists.')
      else if IgnoreTime then VarList.Add(Trim(Name)+'='+DateToStr(Value))
                         else VarList.Add(Trim(Name)+'='+DateTimeToStr(Value));
end;

procedure TEkBaseReport.FreeTemplate;
begin
     if FTmLoaded then
     begin
        try FreeMem(FPFile); except end;
        FTmLoaded:=false;
        Fpnt:=1; Flent:=-1;
     end;
end;

procedure TEkBaseReport.FreeVar(Name: AnsiString);
var i:longint;
begin
  i:=GetVarNumber(Name);
  if i>0 then VarList.Delete(i-1);
end;

procedure TEkBaseReport.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove ) and (AComponent=FUDFList) then
    FUDFList:=nil;
end;

procedure TEkBaseReport.SetInFile(Value: TFileName);
begin
  if Value<>FInFile then
     begin
         FTmLoaded:=false;
         FInFile:=Value;
     end;
end;

procedure TEkBaseReport.SetOnFinished(Value: TNotifyEvent);
begin
  FOnFinished := Value;
end;

procedure TEkBaseReport.SetOutFile(Value: TFileName);
begin
  if Value<>FOutFile then FOutFile:=Value;
end;

procedure TEkBaseReport.SetTemplateBuffer(Buffer: pointer; Size: Integer);
begin
 if not FExecute then
 begin
     FPFile:=Buffer;
     flent:=size;
     FTmLoaded:=true;
     FInFile:='';
  end else
      begin
      raise EIOError.create('Can''t set template while executing report');
      end;//if not FExecute;
end;

procedure TEkBaseReport.SetTrueValue(Value: AnsiString);
begin
   if Value<>FTrueValue then FTrueValue:=Value;
end;

procedure TEkBaseReport.SetFalseValue(Value: AnsiString);
begin
   if Value<>FFalseValue then FFalseValue:=Value;
end;

procedure TEkBaseReport.SetUDFList(Value: TEkUDFList);
begin
  if Value<>FUDFList then begin
  if not FExecute then begin

    if Value<>nil then begin
         if Self.version<>Value.version then begin
          raise EIllegalFunctionUse.Create('TEkRTF version '+inttostr(Self.Version)+' doesn''t equal TEkUDFList version '+inttostr(Value.Version));
         end else begin
          FUDFList:=Value;
          Value.FreeNotification(Self);
         end;
    end else begin
        FUDFList:=Value;
    end;//if Value<>nil

  end else begin
           raise EIllegalFunctionUse.create('Can''t set UDFList while executing report');
           end;//if not FExecute
  end;//if Value
end;

procedure TEkBaseReport.SetVarList(Value: Tstrings);
begin
   FVarList.Assign(Value);
end;

function TEkBaseReport.ShellOpenFile(const FileName: WideString;
  ShowCmd: Integer): THandle;
begin
  Result := ShellExecute(0, nil, PWideChar(FileName), nil, nil, ShowCmd);
end;

function TEkBaseReport.VarByName(VarName: AnsiString): TEkReportVariable;
begin
 FReportVariable.SetVarName(VarName);
 Result:=FReportVariable;
end;

function TEkBaseReport.Version: longint;
begin
Result:=202;
end;

function TEkBaseReport.GetVarByNumber(number: integer): AnsiString;
var p:integer;
    s:AnsiString;
begin
  dec(number);
  s:=FVarList[number];
  p:=pos('=',s);
  if p>1 then
  begin
     Result:=copy(s,p+1,length(s));
  end else begin
           Result:='';
           end;
end;//GetVarByNumber

function TEkBaseReport.GetVarNumber(ident: AnsiString): integer;
var f,p,n:integer;
begin
    n:=FVarList.Count;
    if n>0 then
    begin
       Result:=0;
          for f:=0 to n-1 do
              begin
               p:=pos('=',FVarList[f]);
               if (p>1) and ( uppercase(copy(FVarList[f],1,p-1))=uppercase(ident) ) then
                  begin Result:=f+1; break; end;
              end;//for
    end else begin
             Result:=0;
             end;
end;//GetVarNumber

function TEkBaseReport.SplitArgs(s: AnsiString;
  var List: TStringList): boolean;
var f,ln,nested:integer;
    argone:AnsiString;
    lq, c:AnsiChar;
    inquote:boolean;
begin
   Result:=true;
   if Trim(s)='' then exit;
   s:=s+',';
   ln:=length(s);
   argone:=''; nested:=0; inquote:=false; lq:=' ';
   for f:=1 to ln do
   begin
     c:=s[f];

      if (not inquote) and (LeftQuote(c)) then begin
          inquote:=true; lq:=c;
          argone:=argone+c;
          continue;
          end;

      if (inquote) and (not RightQuote(lq,c)) then begin
          argone:=argone+c;
          continue;
          end;

      if (inquote) and (RightQuote(lq,c)) then begin
         inquote:=false;
         argone:=argone+c;
         continue;
         end;

     if c='(' then inc(nested);
     if c=')' then begin
                   dec(nested);
                   if nested<0 then begin
                      Result:=false; //error
                      list.add(argone);
                      break;
                   end;
              end;

     if (c=',') and (nested=0) then begin
                   list.add(argone); argone:='';
                   continue;
     end;
      argone:=argone+c;
    end;//for

    if nested>0 then begin
                      Result:=false; //error
                      list.add(argone);
                     end;
end; //TEkBaseReport.SplitArgs


function TEkBaseReport.CheckFormat(var s:AnsiString):TEkFieldFormat; //Check if format function present
 var p1,p2,p3,ndec,nprec,f,ln,argcount:longint;
     Args:TStringList;
     formatname, sdec,sprec:AnsiString;
     isdec:boolean;
     secondarg:AnsiString;
 begin
    Result.fmtnumber:=0; //No format eq ffGeneral
    Result.precision:=18;
    Result.decimals:=2;

    //find first '(' after format name
    ln:=length(s);
    if ln=0 then exit;

    f:=1; formatname:='';
    while (f<ln) and letter(s[f]) do inc(f);
    if not ( (s[f]='(')and(f<ln-1)and(s[ln]=')') ) then exit;

    p1:=f; p3:=ln; p2:=p3;
    formatname:=UpperCase(copy(s,1,p1-1));

    isdec:=false;
    sdec:=''; sprec:=''; ndec:=0; nprec:=0; secondarg:='';

    //Find format name in table
    for f:=Low(EkBaseFormatsArr) to High(EkBaseFormatsArr) do begin
        if formatname=EkBaseFormatsArr[f].name then begin
        Result.fmtnumber:=f; break;
        end;
    end;//for

    if Result.fmtnumber=0 then exit; //format not found, exit with 0 result

    Args:=TStringList.Create;
    try
     if SplitArgs(copy(s,p1+1,p3-p1-1),args) then begin
        argcount:=args.Count;
        if argcount<EkBaseFormatsArr[Result.fmtnumber].argmin  then
           raise EIllegalFunctionUse.create('Illegal format function use: '+s+' - number of arguments is less than minimum required');
        if argcount>EkBaseFormatsArr[Result.fmtnumber].argmax then
           raise EIllegalFunctionUse.create('Illegal format function use: '+s+' - number of arguments is more than maximum allowed');
     end else begin
              raise EIllegalFunctionUse.create('Brackets balance violation in format function '+s);
             end; //if SplitArgs

     if argcount=2 then begin
        for f:=ln downto p1 do if s[f]=',' then begin p2:=f; break; end;
        isdec:=true;
        secondarg:=Args[1];
     end;

    finally
     Args.free;
    end;//try

    //if number expected after comma and isdec
    if ((EkBaseFormatsArr[Result.fmtnumber].isfloat) or (Result.fmtnumber=5)) and isdec then
    begin
       for f:=1 to length(secondarg) do begin
           if not ((digit(secondarg[f])) or (secondarg[f]=#32)
                   or ( (secondarg[f]=':') and (f>1) and (f<length(secondarg)) )
                  ) then begin
              raise EIllegalFunctionUse.create('Illegal use of format function '+s+' - cannot understand argument '+secondarg);
           end;
       end;//for

       if (pos(':',secondarg)>1) then
       begin
         sprec:=copy(secondarg,1,pos(':',secondarg)-1);
         nprec:=StrToInt(sprec);
         sdec:=copy(secondarg,pos(':',secondarg)+1,length(secondarg));
         ndec:=StrToInt(sdec);
       end else ndec:=StrToInt(secondarg);
    end;//if

       case Result.fmtnumber of
       //FEXP FFIX FNUM FFIXR FNUMR
       0,1,2,3,7,8:begin
             if isdec then Result.decimals:=ndec;
             if (isdec) and (nprec>0) then Result.precision:=nprec;
             s:=copy(s,p1+1,p2-p1-1); exit;
             end;//FEXP FFIX FNUM FFIXR FNUMR

       //FCUR
       4:begin
         if isdec then Result.decimals:=ndec else Result.decimals:=FormatSettings.CurrencyDecimals;
         if (isdec) and (nprec>0) then Result.precision:=nprec;
         s:=copy(s,p1+1,p2-p1-1); exit;
         end;//FCUR

       //FIMG
       5:begin
         Result.ImgFmt:=0;
         if isdec then Result.ImgFmt:=ndec;
         if (isdec) and (nprec>0) then Result.ImgFmt:=nprec;
         s:=copy(s,p1+1,p2-p1-1); exit;
         end;//FIMG

       //FLNK
       6:begin
         s:=copy(s,p1+1,p2-p1-1); exit;
         end;

       //FDTM
       9:begin
         Result.NDtstr:=CmStoreString(secondarg);
         s:=copy(s,p1+1,p2-p1-1); exit;
         end;

       //FBOOL
      10:begin
         s:=copy(s,p1+1,p2-p1-1); exit;
         end;
      //FRTF
      11:begin
         s:=copy(s,p1+1,p2-p1-1); exit;
         end;

       end;//case

end; //function CheckFormat


function TEkBaseReport.DateConstToStr(s: AnsiString): AnsiString;
begin
  Result:=DateToStr(EncodeDate(strtoint(copy(s,2,4)),strtoint(copy(s,7,2)),strtoint(copy(s,10,2))));
end;


 //Search UDF name in UDFList and in Built in functions such as SUM, CTN ...
function TEkBaseReport.GetUDFNumber(s:AnsiString; out udfnumber:longint):boolean;
var f:longint;
begin
   udfnumber:=-1;
   Result:=false;
   if (Assigned(UDFList)) and (UDFList.Count>0) then begin
      udfnumber:=UDFList.FindFunction(s);
      if udfnumber>-1 then begin Result:=true; exit; end;
   end;

   //Search in built in
  udfnumber:=0;
  s:=Trim(UpperCase(s));
  for f:=Low(EkBaseFunctionsArr) to High(EkBaseFunctionsArr) do begin
     if s=EkBaseFunctionsArr[f].name then begin udfnumber:=EkBaseFunctionsArr[f].id; break; end;
  end;
  if udfnumber<0 then Result:=true;
end; //GetUDFNumber


function TEkBaseReport.GetArgMinCount(udfnumber:longint):longint;
begin
   Result:=0;
   if (Assigned(UDFList)) and (udfnumber>-1) then Result:=UDFList.Functions[udfnumber].ArgMinCount;
   if udfnumber<0 then Result:=EkBaseFunctionsArr[-1-udfnumber].argmin;
end;

function TEkBaseReport.GetArgMaxCount(udfnumber:longint):longint;
begin
   Result:=0;
   if (Assigned(UDFList)) and (udfnumber>-1) then Result:=UDFList.Functions[udfnumber].ArgMaxCount;
   if udfnumber<0 then Result:=EkBaseFunctionsArr[-1-udfnumber].argmax;
end;

function TEkBaseReport.GetUDFResultType(udfnumber:longint):longint;
var f:integer;
begin
   Result:=0;
   if udfnumber<0 then begin
      for f:=Low(EkBaseFunctionsArr) to High(EkBaseFunctionsArr) do begin
          if EkBaseFunctionsArr[f].id=udfnumber then begin
                        Result:=EkBaseFunctionsArr[f].ResultType;
                        break;
                        end;
      end;//for
   end;//if
   if (Assigned(UDFList)) and (udfnumber>-1) then Result:=UDFList.Functions[udfnumber].ResultType;
end;

function TEkBaseReport.CheckUdfFormat(var udfnumber:longint; var infmtvar:TEkFieldFormat):boolean;
var f:integer;
   RT:TEkUDFResultType;
begin
   Result:=false;
   RT:=0;
   if udfnumber<0 then begin //built in functions
      for f:=Low(EkBaseFunctionsArr) to High(EkBaseFunctionsArr) do begin
          if EkBaseFunctionsArr[f].id=udfnumber then begin
                        RT:=EkBaseFunctionsArr[f].ResultType;
                        break;
                        end;
      end;//for

      if (infmtvar.fmtnumber>0) and not (RT in EkBaseFormatsArr[infmtvar.fmtnumber].argtype)
                   then Result:=false else Result:=true;
   end;//if<0
   //--------------------------------------------------------------------
   if (Assigned(UDFList)) and (udfnumber>-1) then begin
       if (infmtvar.fmtnumber>0) and not (UDFList.Functions[udfnumber].ResultType
                   in EkBaseFormatsArr[infmtvar.fmtnumber].argtype)
                   then Result:=false else Result:=true;
   end;//if
end;

 //This function gets AnsiString 'fname(...,...,...)' and empty TStringList
 //Result is true o false, udfnumber=fn number in UDFList or -number of predefined function
 //udfargs became filled with parameter strings

function TEkBaseReport.ProcessUDFName(fname:AnsiString; udfargs:TStringList; out udfnumber:longint):boolean;
var p1,p3,f,ln,argcount:longint;
    udfname,s:AnsiString;
begin
    Result:=false;
    s:=fname; //s is AnsiString atleast F(A)
    ln:=length(s);
    f:=1; udfname:='';
    p3:=ln;

    if (ln>2) and (s[1]='(') and (s[ln]=')') then begin
       //empty function
       p1:=1;
    end else begin
       //not empty function
       //find first '(' after udf name
       while (f<ln) and (s[f]<>'(') do inc(f);
       if not ( (s[f]='(')and(f<ln)and(s[ln]=')') ) then exit;
       p1:=f; //p1=position of '('
       //p3=position of last ')'
       udfname:=trim(UpperCase(copy(s,1,p1-1)));
    end;//if

    if not GetUDFNumber(udfname,udfnumber) then exit;

    if SplitArgs(copy(s,p1+1,p3-p1-1),udfargs) then begin
       argcount:=udfargs.Count;

       if argcount<GetArgMinCount(udfnumber)  then
          raise EIllegalFunctionUse.create('Illegal function use: '+s+' - number of arguments is less than minimum required');
       if argcount>GetArgMaxCount(udfnumber) then
          raise EIllegalFunctionUse.create('Illegal function use: '+s+' - number of arguments is more than maximum allowed');
    end else begin
             raise EIllegalFunctionUse.create('Brackets balance violation in function '+s);
             end; //if SplitArgs

    Result:=true;

end;//ProcessUDFName


constructor TEkBaseReport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPFile:=nil;
  FExecute:=false;  
  FTmLoaded:=false;
  Fpnt:=0; Flent:=-1;
  FLastBoundaryPnt:=-1;
  FKwdPnt:=-1;
  FSzi:=sizeof(Fpnt);

  FInFile:='';
  FOutFile:='';

  FTmpStream:=nil;
  FTmpFileName:='';
  FOutStream:=nil;
  FUseStream:=false;
  FOutf:=nil;
  FOutfCreated:=false;

  FCmpos:=0;
  FCmLastId:=-9999; FCmLastFpnt:=0;
  FCmSkip:=0;
  FCmStream:=nil;
  FCmStrings:=nil;

  FVarList:=TStringList.create;
  FReportVariable:=TEkReportVariable.create(Self);
  FTrueValue:='True';
  FFalseValue:='False';
  FDecimalRTerminator:='=';
  FDecimalRSeparator:='-';
  FUDFList:=nil;

end;

destructor TEkBaseReport.Destroy;
begin
  FCmStrings:=nil;
  FreeTemplate;
  FVarList.Free;
  FReportVariable.Free;
  inherited Destroy;
end;

procedure TEkBaseReport.ReadFileBody;//Load file or blobfield into memory
var
   ActualRead: cardinal;
   FileHandle: Integer;
   SearchRec : TsearchRec;
        size : longint;
begin
    Fpnt:=1; size:=0;
    if not FTmLoaded then
      begin   //load from inFile

      try
      if FindFirst(FInFile, faAnyFile, SearchRec)=0 then
      begin
      size:=SearchRec.Size;
      GetMem(FPFile,size+2);
      FileHandle := FileOpen(FInFile, fmOpenRead);
      ActualRead :=FileRead(FileHandle, FPFile^, size);
      FileClose(FileHandle);

      Flent:=ActualRead;//size
      end //if findfirst
      except
        try FreeMem(FPFile); except end;
        raise EIOError.create('Can''t read file '+FInFile);
      end;
      if Flent<size then begin raise EIOError.create('Can''t read report template from file: '+FInFile); end;
      FindClose(SearchRec);

    end; //if not FFileLoaded

end;//TEkBaseReport.ReadFileBody


procedure TEkBaseReport.IncPnt(delta: Integer);
begin
inc(FPnt,delta);
end;

procedure TEkBaseReport.wr(s:AnsiString);
begin
 FOutf.WriteBuffer(pointer(s)^,length(s));
end;//procedure wr

function TEkBaseReport.FileEof: boolean;
begin
   Result:=(Fpnt>Flent);
end;

function TEkBaseReport.FileBof: boolean;
begin
   Result:=(Fpnt>1);
end;

procedure TEkBaseReport.SetOutfToNil;
begin
  FOutf:=nil;
end;

procedure TEkBaseReport.SetOutfToTmp;
begin
  FOutf:=FTmpStream;
end;

procedure TEkBaseReport.SetOutf;
begin
   if UseStream then begin
                      FOutStream.Seek(0,0);
                      FOutf:=FOutStream; //This is user defined out stream - shouldn't be destroyed
                    end else begin
                          FOutf:=TFileStream.create(OutFile,fmCreate);
                          FOutfCreated:=true;
                        end;
end;//SetOutf

procedure TEkBaseReport.FreeOutf;
begin
   //if Outf was set within SetOutf, it will be destroyed here:
   if (not UseStream) then
   begin
            if (FOutfCreated) and (Assigned(FOutf)) then begin
               FOutf.free; FOutf:=nil;
               FOutfCreated:=false;
            end;
   end else if Assigned(FOutf) then FOutf.seek(0,0);
end;//FreeOutf

procedure TEkBaseReport.CreateTmpStream;
begin
  FTmpStream:=nil;
  FTmpFileName:='';
  if (FUseStream) and (FOutStream is TMemoryStream) then begin
     FTmpStream:=TMemoryStream.Create;
  end else begin
     FTmpFileName:=CreateTmpFileName('ekr');
     FTmpStream:=TFileStream.Create(FTmpFileName,fmCreate);
  end;
end;


procedure TEkBaseReport.CreateCmStream;
begin
 FCmStream:=TMemoryStream.Create;
 FCmStream.SetSize(1000);
 FCmStrings:=nil;
 FCmPos:=0; FCmLastId:=-9999;
end;

procedure TEkBaseReport.FreeTmpStream;
begin
   if Assigned(FTmpStream) then begin FTmpStream.free; FTmpStream:=nil; end;
   if (not FUseStream) then DeleteFile(FTmpFileName);
end;

procedure TEkBaseReport.FreeCmStream;
begin
  if (FCmStream)<>nil then begin FCmStream.free; FCmStream:=nil; end;
  FCmStrings:=nil;
  FCmPos:=0; FCmLastId:=-9999;
end;

procedure TEkBaseReport.SeekToBeginCmStream;
begin
 FCmStream.Seek(0,sofrombeginning);
 FCmLastId:=-9999; FCmLastFpnt:=0; FCmPos:=0;
end;

function TEkBaseReport.CmGetString(n: Integer): AnsiString;
var i:longint;
begin
  i:=High(FCmStrings);
  if (n>-1) and (n<=i) then Result:=FCmStrings[n] else Result:='';
end;

function TEkBaseReport.CmStoreString(var s: AnsiString): longint;
var n:longint;
begin
   n:=High(FCmStrings)+1; //new index
   SetLength(FCmStrings,n+1);
   FCmStrings[n]:=s;
   Result:=n;
end;

procedure TEkBaseReport.CmSaveItemInfo(id, skipbytes, cmfpnt:integer);
begin
  with FCmStream do
  begin
  Write(id, Szi);
  FCmLastId:=id;
  inc(skipbytes,Szi);  //one more fszi for last field FCmPos
  Write(cmfpnt,Szi);
  Write(skipbytes,Szi);
  end;
end;

procedure TEkBaseReport.CmReadItemInfo;
var mpnt:longint;
begin
   With FCmStream do
   begin
     Read(FCmLastId,Szi);
     FCmLastFpnt:=Pnt;
     Read(mpnt,Szi);
     Read(FCmSkip,Szi);
     Pnt:=mpnt;
   end;
end;

procedure TEkBaseReport.CmSaveItemPos;
begin
  FCmStream.Write(Fcmpos,Szi); //first time Fcmpos=0;
  Fcmpos:=FCmStream.Position;
end;

procedure TEkBaseReport.CmReadItemPos;
begin
  FCmStream.Read(Fcmpos,Szi);
end;

procedure TEkBaseReport.CmSaveBegin;
begin
CmSaveItemInfo(-9999,0,Pnt);
CmSaveItemPos;
end;

procedure TEkBaseReport.CmSaveEnd;
begin
CmSaveItemInfo(-10000,0,Pnt);
CmSaveItemPos;
end;

procedure TEkBaseReport.CmSaveBlocItem;
begin
   if CmLastId=-5 then
      begin
        CmStream.Seek(-Szi-Szi-Szi,sofromcurrent);
        CmStream.Write(Pnt,Szi);
        CmStream.Seek(Szi+Szi,sofromcurrent);
      end else begin
               CmSaveItemInfo(-5,0,Pnt);
               //nothing here
               CmSaveItemPos;
               end;
end;

procedure TEkBaseReport.CmReadBlocItem;
begin
  //Nothing to read, just item position
  CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveBalancedBlocItem;
begin
  CmSaveItemInfo(-10,0,Pnt);
  //nothing here
  CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadBalancedBlocItem;
begin
  //Nothing to read, just item position
  CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveTableEnd;
begin
   CmSaveItemInfo(-7,0,Pnt);
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadTableEnd;
begin
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveTableBegin;
begin
   CmSaveItemInfo(-6,0,Pnt);
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadTableBegin;
begin
   //nothing
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveRawItem(var s:AnsiString);
var i:longint;
begin
  CmSaveItemInfo(-16,Szi,Pnt);
  i:=CmStoreString(s); CmStream.Write(i,Szi);
  CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadRawItem(var s:AnsiString);
var i:longint;
begin
    CmStream.Read(i,Szi); s:=CmGetString(i);
    CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveScanItem(var OutStr,SPar:AnsiString; n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   CmSaveItemInfo(-3,Szi+Szi+szn,Pnt);
   With CmStream do
   begin
     i:=CmStoreString(OutStr); Write(i,Szi);
     i:=CmStoreString(Spar);   Write(i,Szi);
     Write(n,szn);
   end;
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadScanItem(var OutStr,SPar:AnsiString;var n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   With CmStream do
   begin
    Read(i,Szi); Outstr:=CmGetString(i);
    Read(i,Szi); SPar:=CmGetString(i);
    Read(n,szn);
   end;
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveScanWhileItem(var OutStr,SPar:AnsiString; n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   CmSaveItemInfo(-21,Szi+Szi+szn,Pnt);
   With CmStream do
   begin
     i:=CmStoreString(OutStr); Write(i,Szi);
     i:=CmStoreString(Spar);   Write(i,Szi);
     Write(n,szn);
   end;
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadScanWhileItem(var OutStr,SPar:AnsiString;var n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   With CmStream do
   begin
    Read(i,Szi); Outstr:=CmGetString(i);
    Read(i,Szi); SPar:=CmGetString(i);
    Read(n,szn);
   end;
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveIfItem(var OutStr,SPar:AnsiString; n:word; elseflag:boolean);
var szn, i, nelse : longint;
begin
   szn:=sizeof(word);
   CmSaveItemInfo(-23,Szi+Szi+szn+Szi,Pnt);
   With CmStream do
   begin
     i:=CmStoreString(OutStr); Write(i,Szi);
     i:=CmStoreString(Spar);   Write(i,Szi);
     Write(n,szn);

     nelse:=0;
     if elseflag then nelse:=1;
     Write(nelse,Szi);

   end;
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadIfItem(var OutStr,SPar:AnsiString;var n:word; var elseflag:boolean);
var szn, i, nelse : longint;
begin
   szn:=sizeof(word);
   With CmStream do
   begin
    Read(i,Szi); Outstr:=CmGetString(i);
    Read(i,Szi); SPar:=CmGetString(i);
    Read(n,szn);

    Read(nelse, Szi);
    if nelse=1 then elseflag:=true else elseflag:=false;

   end;
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveScanEntryItem(var OutStr,SPar:AnsiString; n:word);
var szn,i : longint;
begin
   szn:=sizeof(word);
   CmSaveItemInfo(-11,Szi+Szi+szn,Pnt);
   With CmStream do
   begin
     i:=CmStoreString(OutStr); Write(i,Szi);
     i:=CmStoreString(Spar);   Write(i,Szi);
     Write(n,szn);
   end;
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadScanEntryItem(var OutStr,SPar:AnsiString; var n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   With CmStream do
   begin
    Read(i,Szi); Outstr:=CmGetString(i);
    Read(i,Szi); SPar:=CmGetString(i);
    Read(n,szn);
   end;
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveScanFooterItem(var OutStr,SPar:AnsiString; n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   CmSaveItemInfo(-12,Szi+Szi+szn,Pnt);
   With CmStream do
   begin
     i:=CmStoreString(OutStr); Write(i,Szi);
     i:=CmStoreString(Spar);   Write(i,Szi);
     Write(n,szn);
   end;
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadScanFooterItem(var OutStr,SPar:AnsiString; var n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   With CmStream do
   begin
    Read(i,Szi); Outstr:=CmGetString(i);
    Read(i,Szi); SPar:=CmGetString(i);
    Read(n,szn);
   end;
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveEndScanItem(var OutStr,SPar:AnsiString; n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   CmSaveItemInfo(-4,Szi+Szi+szn,Pnt);
   With CmStream do
   begin
     i:=CmStoreString(OutStr); Write(i,Szi);
     i:=CmStoreString(Spar);   Write(i,Szi);
     Write(n,szn);
   end;
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadEndScanItem(var OutStr,SPar:AnsiString;var n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   With CmStream do
   begin
    Read(i,Szi); Outstr:=CmGetString(i);
    Read(i,Szi); SPar:=CmGetString(i);
    Read(n,szn);
   end;
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveEndIfItem(var OutStr,SPar:AnsiString; n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   CmSaveItemInfo(-24,Szi+Szi+szn,Pnt);
   With CmStream do
   begin
     i:=CmStoreString(OutStr); Write(i,Szi);
     i:=CmStoreString(Spar);   Write(i,Szi);
     Write(n,szn);
   end;
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadEndIfItem(var OutStr,SPar:AnsiString;var n:word);
var szn, i : longint;
begin
   szn:=sizeof(word);
   With CmStream do
   begin
    Read(i,Szi); Outstr:=CmGetString(i);
    Read(i,Szi); SPar:=CmGetString(i);
    Read(n,szn);
   end;
   CmReadItemPos;
end;


procedure TEkBaseReport.CmSaveScanSkipItem(n:word);
var szn:longint;
begin
   szn:=sizeof(word);
   CmSaveItemInfo(-22,szn,Pnt);
   CmStream.Write(n,szn);
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadScanSkipItem(var n:word);
var szn:longint;
begin
   szn:=sizeof(word);
   CmStream.Read(n,szn);
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveScanFirstItem(n: word);
var szn:longint;
begin
   szn:=sizeof(word);
   CmSaveItemInfo(-26,szn,Pnt);
   CmStream.Write(n,szn);
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadScanFirstItem(var n: word);
var szn:longint;
begin
   szn:=sizeof(word);
   CmStream.Read(n,szn);
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveField(id:longint; FieldContent:TEKRowContent);
var szfmt, sztype,n:longint;
begin
  szfmt:=sizeof(TEkFieldFormat);
  sztype:=sizeof(TEkRcTypes);
  CmSaveItemInfo(id, 6*Szi+szfmt+sztype+sztype, Pnt);
  With CmStream do
  begin
   n:=CmStoreString(FieldContent.stestf); Write(n,Szi);
   n:=CmStoreString(FieldContent.dalias); Write(n,Szi);
   n:=CmStoreString(FieldContent.field);  Write(n,Szi);
   n:=CmStoreString(FieldContent.sout);   Write(n,Szi);
   Write(FieldContent.fmt,szfmt);
   Write(FieldContent.ftype,sztype);
   Write(FieldContent.NField,Szi);
   Write(FieldContent.definedtype,sztype);
   n:=0;
   if FieldContent.Defined then n:=1;
   Write(n,Szi);
  end;
  CmSaveItemPos;
end;

procedure TEkBaseReport.CmUpdateField(n:longint; tp:TEkRcTypes; defined:boolean);
var szfmt, sztype:longint;
    i:longint;
begin
  szfmt:=sizeof(TEkFieldFormat);
  sztype:=sizeof(TEkRcTypes);
  //Read and Skip item info
  CmReadItemInfo;
  CmStream.Seek(4*Szi+szfmt+sztype, sofromcurrent);
  CmStream.Write(n,Szi); //NField
  CmStream.Write(tp,sztype); //DefinedType
  i:=0;
  if defined then i:=1;
  CmStream.Write(i,Szi);
  //Read and Skip item pos
  CmReadItemPos;
end;

procedure TEkBaseReport.CmReadField(var FieldContent:TEKRowContent);
var szfmt, sztype, n:longint;
    R:TEkRowContent;
begin
  szfmt:=sizeof(TEkFieldFormat);
  sztype:=sizeof(TEkRcTypes);
  With CmStream do
  begin
   Read(n,Szi); R.stestf:=CmGetString(n);
   Read(n,Szi); R.dalias:=CmGetString(n);
   Read(n,Szi); R.field:=CmGetString(n);
   Read(n,Szi); R.sout:=CmGetString(n);
   Read(R.fmt,szfmt);
   Read(R.ftype,sztype);
   Read(R.NField,Szi);
   Read(R.definedtype,sztype);
   Read(n,Szi);
   if n=1 then R.Defined:=true else R.Defined:=false;
  end;//with
  FieldContent:=R;
  CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveExprBeginItem(FieldContent:TEKRowContent; InDocument, IsManage:boolean; ScanNum:word);
var szn, szfmt, sztype,n:longint;
begin
  szn:=sizeof(word);
  szfmt:=sizeof(TEkFieldFormat);
  sztype:=sizeof(TEkRcTypes);
  CmSaveItemInfo(-13, 8*Szi+szfmt+sztype+sztype+szn, Pnt);
  With CmStream do
  begin
   n:=CmStoreString(FieldContent.stestf); Write(n,Szi);
   n:=CmStoreString(FieldContent.dalias); Write(n,Szi);
   n:=CmStoreString(FieldContent.field);  Write(n,Szi);
   n:=CmStoreString(FieldContent.sout);   Write(n,Szi);
   Write(FieldContent.fmt,szfmt);
   Write(FieldContent.ftype,sztype);
   Write(FieldContent.NField,Szi);
   Write(FieldContent.definedtype,sztype);
   n:=0;
   if FieldContent.Defined then n:=1;
   Write(n,Szi);
   n:=0;
   if InDocument then n:=1;
   Write(n,Szi);
   n:=0;
   if IsManage then n:=1;
   Write(n,Szi);
   Write(ScanNum,szn);
  end;
  CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadExprBeginItem(var FieldContent:TEKRowContent; var InDocument, IsManage:boolean; var ScanNum:word);
var szn, szfmt, sztype, n:longint;
    R:TEkRowContent;
begin
  szn:=sizeof(word);
  szfmt:=sizeof(TEkFieldFormat);
  sztype:=sizeof(TEkRcTypes);
  With CmStream do
  begin
   Read(n,Szi); R.stestf:=CmGetString(n);
   Read(n,Szi); R.dalias:=CmGetString(n);
   Read(n,Szi); R.field:=CmGetString(n);
   Read(n,Szi); R.sout:=CmGetString(n);
   Read(R.fmt,szfmt);
   Read(R.ftype,sztype);
   Read(R.NField,Szi);
   Read(R.definedtype,sztype);
   Read(n,Szi);
   if n=1 then R.Defined:=true else R.Defined:=false;
   Read(n,Szi);
   if n=1 then InDocument:=true else InDocument:=false;
   Read(n,Szi);
   if n=1 then IsManage:=true else IsManage:=false;
   Read(ScanNum,szn);
  end;//with
  FieldContent:=R;
  CmReadItemPos;

end;

procedure TEkBaseReport.CmSaveExprEndItem;
begin
   CmSaveItemInfo(-14,0,Pnt);
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadExprEndItem;
begin
   CmReadItemPos;
end;

procedure TEkBaseReport.CmSaveExecuteUDFItem(udfnumber, parcount:longint);
begin
   CmSaveItemInfo(-15,Szi+Szi,Pnt);
   CmStream.Write(udfnumber,Szi);
   CmStream.Write(parcount,Szi);
   CmSaveItemPos;
end;

procedure TEkBaseReport.CmReadExecuteUDFItem(out udfnumber, parcount:longint);
begin
   CmStream.Read(udfnumber,Szi);
   CmStream.Read(parcount,Szi);
   CmReadItemPos;
end;


{-----------------TEkColor-----------------------------}
constructor TEkColor.create;
begin
  inherited create;
  fr:=0; fg:=0; fb:=0;
end;
function TEkColor.GetColor:TColor;
begin
  Result:=FB Shl 16 Or
          FG Shl 8  Or
          FR;
end;
procedure TEkColor.SetColor(Value:TColor);
begin
  FB:=(Value and $00FF0000) shr 16;
  FG:=(Value and $0000FF00) shr 8;
  FR:=Value and $000000FF;
end;
procedure TEkColor.SetFr(Value:byte);
begin
   If Value<>Fr then Fr:=value;
end;
procedure TEkColor.SetFg(Value:byte);
begin
   If Value<>Fg then Fg:=value;
end;
procedure TEkColor.SetFb(Value:byte);
begin
   If Value<>Fb then Fb:=value;
end;


//-----------------------------------------------------------------
function TEkBaseRTFReport.GetCharSet:TFontCharSet;
begin
Result:=FCharset;
end;
//-----------------------------------------------------------------
procedure TEkBaseRTFReport.SetCharSet(Value:TFontCharset);
begin
  if Value<>FCharset then FCharset:=Value;
end;
//-----------------------------------------------------------------
function TEkBaseRTFReport.GetLang: TEkLanguageID;
begin
Result:=FLang;
end;
//-----------------------------------------------------------------
procedure TEkBaseRTFReport.SetLang(Value:TEkLanguageID);
begin
  if Value<>FLang then FLang:=Value;
end;

procedure TEkBaseRTFReport.SetOptions(Value: TEkRTFOptions);
begin
  if Value<>FOptions then FOptions:=Value;
end;

//-----------------------------------------------------------
function TEkBaseRTFReport.txt2rtf(s:AnsiString):AnsiString;
var o,f,i:Longint;
begin
f:=length(s);
i:=1;
Result:='';
while i<=f do
begin
o:=ord(s[i]);
 case o of
        9: Result:=Result+'\tab ';
       11: Result:=Result+'\line ';
       12: Result:=Result+'\page ';
       13: Result:=Result+'\par ';
       92: Result:=Result+'\\';
      123: Result:=Result+'\{';
      125: Result:=Result+'\}';
 128..255: Result:=Result+'\'''+inttohex(o,2);
 else
     Result:=Result+s[i];
 end;//case
inc(i);
end;
end;//function txt2rtf

function TEkBaseRTFReport.CreateFileName(Directory, Prefix: AnsiString): AnsiString;
var ln:integer;
    tic:AnsiString;
begin
    ln:=length(Directory);
    if (ln>0) and not DirectoryExists(Directory) then begin
       raise EIOError.Create('CreateFileName: directory '+Directory+' does not exist');
    end;
    if (ln>0) then begin
       if Directory[ln]<>'\' then Directory:=Directory+'\';
    end;
    tic:=IntTohex( Gettickcount, 8 );
    while (tic[1]='0') and (length(tic)>1) do tic:=copy(tic,2,length(tic)-1);
    randomize;
    Result :=Directory + Prefix+tic + IntToHex(Random($FFFF),4) + '.doc';
end;

function TEkBaseRTFReport.CreateFileName(Directory, Prefix, Extension: AnsiString): AnsiString;
var ln:integer;
    tic:AnsiString;
begin
    ln:=length(Directory);
    if (ln>0) and not DirectoryExists(Directory) then begin
       raise EIOError.Create('CreateFileName: directory '+Directory+' does not exist');
    end;
    if (ln>0) then begin
       if Directory[ln]<>'\' then Directory:=Directory+'\';
    end;
    if (length(Extension)>0) and (Extension[1]<>'.') then Extension:='.'+Extension;
    tic:=IntTohex( Gettickcount, 8 );
    while (tic[1]='0') and (length(tic)>1) do tic:=copy(tic,2,length(tic)-1);
    randomize;
    Result :=Directory + Prefix+tic + IntToHex(Random($FFFF),4) + Extension;
end;



constructor TEkBaseRTFReport.Create(AOwner: TComponent);
var i:integer;
begin
  inherited Create(AOwner);
  FCharset:=DEFAULT_CHARSET;
  FLang:=0;

  //this AnsiString is empty in BaseReport
  //set outfile name here
  OutFile:='outfile.doc';
  FOutTab:=nil;
  FQuoteIndex:=0; FQuoteSkip:=0; FQuoteStr:='';

  Include(FOptions,eoGraphicsBinary);
  Include(FOptions,eoDotAsColon);

  FRTFFont:=nil;
  FRTFColor:=nil;
  FRTFStyle:=nil;
  FRTFDocInfo:=nil;

  FIsFontTable:=false;
  FIsStyle:=false;
  FIsColorTable:=false; //not known
  FIsDocInfo:=false;
  FInTable:=false;

  FDocColorCount:=0; // not known at creation
  FColorCount:=16;

  Setlength(FColorTable,FColorCount);
  for i:=0 to FColorCount-1 do FColorTable[i]:=TEkcolor.create;
  FColorTable[0].b:=$00; FColorTable[0].g:=$00; FColorTable[0].r:=$00;
  FColorTable[1].b:=$FF; FColorTable[1].g:=$00; FColorTable[1].r:=$00;
  FColorTable[2].b:=$FF; FColorTable[2].g:=$FF; FColorTable[2].r:=$00;
  FColorTable[3].b:=$00; FColorTable[3].g:=$FF; FColorTable[3].r:=$00;
  FColorTable[4].b:=$FF; FColorTable[4].g:=$00; FColorTable[4].r:=$FF;
  FColorTable[5].b:=$00; FColorTable[5].g:=$00; FColorTable[5].r:=$FF;
  FColorTable[6].b:=$00; FColorTable[6].g:=$FF; FColorTable[6].r:=$FF;
  FColorTable[7].b:=$FF; FColorTable[7].g:=$FF; FColorTable[7].r:=$FF;
  FColorTable[8].b:=$80; FColorTable[8].g:=$00; FColorTable[8].r:=$00;
  FColorTable[9].b:=$80; FColorTable[9].g:=$80; FColorTable[9].r:=$00;
  FColorTable[10].b:=$00; FColorTable[10].g:=$80; FColorTable[10].r:=$00;
  FColorTable[11].b:=$80; FColorTable[11].g:=$00; FColorTable[11].r:=$80;
  FColorTable[12].b:=$00; FColorTable[12].g:=$00; FColorTable[12].r:=$80;
  FColorTable[13].b:=$00; FColorTable[13].g:=$80; FColorTable[13].r:=$80;
  FColorTable[14].b:=$80; FColorTable[14].g:=$80; FColorTable[14].r:=$80;
  FColorTable[15].b:=$C0; FColorTable[15].g:=$C0; FColorTable[15].r:=$C0;
end;//end constructor

destructor TEkBaseRTFReport.Destroy;
var i:integer;
begin
  FRTFFont.Free;
  FRTFColor.Free;
  FRTFStyle.Free;
  FRTFDocInfo.Free;
  for i:=0 to FColorCount-1 do FColorTable[i].free;
  FColorTable:=nil;
  FDocColorTable:=nil;
  inherited Destroy;
end;//end destructor

procedure TEkBaseRTFReport.CmSaveFontTable;
begin
   //Not fonttable, but sign of it
   CmSaveItemInfo(-17,0,Pnt);
   CmSaveItemPos;
end;

procedure TEkBaseRTFReport.CmReadFontTable;
begin
   CmReadItemPos;
end;

procedure TEkBaseRTFReport.CmSaveColorTable;
begin
   //Just sign of it
   CmSaveItemInfo(-18,0,Pnt);
   CmSaveItemPos;
end;

procedure TEkBaseRTFReport.CmReadColorTable;
begin
   CmReadItemPos;
end;

procedure TEkBaseRTFReport.CmSaveStyleSheet;
begin
   //Just sign of it
   CmSaveItemInfo(-19,0,Pnt);
   CmSaveItemPos;
end;

procedure TEkBaseRTFReport.CmReadStyleSheet;
begin
   CmReadItemPos;
end;


procedure TEkBaseRTFReport.CmSaveDocInfo;
begin
   //Just sign of it
   CmSaveItemInfo(-20,0,Pnt);
   CmSaveItemPos;
end;

procedure TEkBaseRTFReport.CmReadDocInfo;
begin
   CmReadItemPos;
end;

//-----------------------------------------------------------------------------

procedure TEkBaseRTFReport.ReadFb(var ch:AnsiChar);
label 1;
begin
    1:
    if Pnt<=Lent then begin ch:=(Pfile+Pnt-1)^ ; IncPnt(1); end
                   else begin ch:=#26; end;
    if ((ch<#32) and (ch<>#10) and (ch<>#09)) and (Pnt<=Lent) then goto 1;
end;//proc ReadFb

procedure TEkBaseRTFReport.ReadBack(var ch:AnsiChar);
label 1;
begin
    1:
    if (Pnt<=Lent) and (Pnt>1) then begin IncPnt(-1); ch:=(Pfile+Pnt-1)^;  end
                   else begin ch:=#26; end;
    if ((ch<#32) and (ch<>#10) and (ch<>#09)) and (Pnt<=Lent) and (Pnt>1) then goto 1;
end;//proc ReadBack

function TEkBaseRTFReport.LeftQuote(c:AnsiChar):boolean;
begin
  Result:=false;
  if (c=#147) or (c=#148) or (c=#171) or (c=#187) or (c=#34) or
     (c=#39) or (c=#96) or (c=#126) then Result:=true;
end;

function TEkBaseRTFReport.RightQuote(lc,rc:AnsiChar):boolean;
begin
  Result:=false;
  case lc of
   #147,#148:if rc=#148 then Result:=true;
   #171,#187:if rc=#187 then Result:=true;
   #34: if rc=#34 then Result:=true;
   #39: if rc=#39 then Result:=true;
   #96: if rc=#96 then Result:=true;
   #126: if rc=#126 then Result:=true;
  end;//case
end;

function TEkBaseRTFReport.IsQuoted(s:AnsiString):boolean;
var lq,rq:AnsiChar;
    f,ln:longint;
begin
   Result:=false;
   ln:=length(s);
   if (ln>2) and (LeftQuote(s[1])) then begin
        lq:=s[1];
        rq:=s[ln];
        if (not RightQuote(lq,rq)) then begin Result:=false; exit; end;
        for f:=2 to ln-1 do if s[f]=rq then begin Result:=false; exit; end;
        Result:=true;
   end;
end;//func IsQuoted


procedure TEkBaseRTFReport.OutRaw;
var s:AnsiString;
begin
   CmReadRawItem(s);
   wr(s);
end;

procedure TEkBaseRTFReport.OutColorTable;
var f:longint;
begin
  wr('{\colortbl');
  for f:=0 to RTFColor.Count-1 do wr(RTFColor[f]);
  wr('}');
end;

procedure TEkBaseRTFReport.OutFontTable;
var f:longint;
begin
  wr('{\fonttbl');
  for f:=0 to RTFFont.Count-1 do wr(RTFFont[f]);
  wr('}');
  //if no color table in input file, but colors added
  if (not IsColorTable) and (RTFColor.Count>0) then OutColorTable;
end;

procedure TEkBaseRTFReport.OutStyle;
var f:longint;
begin
  wr('{\stylesheet');
  for f:=0 to RTFStyle.Count-1 do wr(RTFStyle[f]);
  wr('}');
end;



{ gets AnsiString \\...\\ with field name mixed with rtf tags
  result: fldstring=\\field\\ outstring=other rtf tags}

procedure TEkBaseRTFReport.CutRtString(rtstring:AnsiString; var fldstring, outstring:AnsiString);
     var f,ln,hexn:integer;
           ch, ch1,ch2,ch3,lq:AnsiChar;
           delspace, inquote:boolean;
           fldres:AnsiString;
     begin
       ln:=length(rtstring);
       rtstring:=rtstring+'          ';
       fldstring:=''; outstring:='';
       f:=1;
       while f<=ln do
       begin
            ch:=rtstring[f];
            case ch of
            '\':begin
                   ch1:=rtstring[f+1];
                   case ch1 of
                   '\': begin fldstring:=fldstring+'\'; inc(f,2); end;
                   // brackets that may be in document
                   '}': begin fldstring:=fldstring+'}'; inc(f,2); end;
                   '{': begin fldstring:=fldstring+'{'; inc(f,2); end;
                        //non-breaking space
                   '~': begin fldstring:=fldstring+' '; inc(f,2); end;
                   #39: begin ch2:=rtstring[f+2]; ch3:=rtstring[f+3];
                              hexn:=StrToIntDef('$'+ch2+ch3,0);
                              if hexn>0 then fldstring:=fldstring+AnsiChar(chr(hexn));
                              inc(f,4);
                        end;
                    else
                       begin

                         if (copy(rtstring,f+1,6)='lquote') and (not Letter(rtstring[f+7])) and (not Digit(rtstring[f+7])) then
                            begin
                            fldstring:=fldstring+#39;
                            inc(f,7);
                            if rtstring[f]=' ' then inc(f);
                            continue;
                            end;

                         if (copy(rtstring,f+1,6)='rquote') and (not Letter(rtstring[f+7])) and (not Digit(rtstring[f+7])) then
                            begin
                            fldstring:=fldstring+#39;
                            inc(f,7);
                            if rtstring[f]=' ' then inc(f);
                            continue;
                            end;

                         if (copy(rtstring,f+1,9)='ldblquote') and (not Letter(rtstring[f+10])) and (not Digit(rtstring[f+10])) then
                            begin
                            fldstring:=fldstring+#147;
                            inc(f,10);
                            if rtstring[f]=' ' then inc(f);
                            continue;
                            end;

                         if (copy(rtstring,f+1,9)='rdblquote') and (not Letter(rtstring[f+10])) and (not Digit(rtstring[f+10])) then
                            begin
                            fldstring:=fldstring+#148;
                            inc(f,10);
                            if rtstring[f]=' ' then inc(f);
                            continue;
                            end;

                        repeat
                        outstring:=outstring+rtstring[f];
                        inc(f);
                        until  (rtstring[f]='\') or (rtstring[f]=' ')
                           or (rtstring[f]='}') or (rtstring[f]='{');
                        //Add Last space to keyword
                        if (rtstring[f]=' ') then begin outstring:=outstring+' '; inc(f); end;

                       end;
                   end; //case nested
                end;
       'A'..'Z',
       'a'..'z',
       ' ','_','!','?','"','#','$','%','&',#39,'(',')','*','+',',','-','.','/',':',';','[',']','@','|',
       #147, #148, #171, #187, #96, #126,
       '0'..'9':begin fldstring:=fldstring+ch; inc(f); end;

            else //case
              //here will be symbols that not processed including rtf tags
              outstring:=outstring+rtstring[f];
              inc(f);
            end;//case
       end;//while

       fldstring:=Trim(fldstring);
       ln:=length(fldstring);
       delspace:=true; inquote:=false; fldres:=''; lq:=' ';
       for f:=1 to ln do begin
                           ch:=fldstring[f];
                           if (not inquote) and (LeftQuote(ch)) then begin
                               inquote:=true; lq:=ch;
                               fldres:=fldres+ch;
                               continue;
                               end;

                           if (inquote) and (not RightQuote(lq,ch)) then begin
                               fldres:=fldres+ch;
                               continue;
                               end;

                           if (inquote) and (RightQuote(lq,ch)) then begin
                              inquote:=false;
                              fldres:=fldres+ch;
                              continue;
                              end;

                           if ch='[' then begin delspace:=false; continue; end;
                           if ch=']' then begin delspace:=true; continue; end;
                           if (delspace) and (ch=' ') then continue else fldres:=fldres+ch;
                         end;
       fldstring:=Trim(fldres);
end;//proc

     //Returns symbols with n chars offset from current position fpnt
function TEkBaseRTFReport.getnch(n:integer):AnsiChar;
label 1,2;
     begin
        if n>=0 then
        begin //positive n
          1:
          if Pnt+n<=Lent then begin Result:=(Pfile+Pnt+n-1-1)^; inc(n); end
                         else begin Result:=#26; end;
          if (Result<#32) and (Pnt+n<=Lent) then goto 1;
        end
        else
         begin //negative n
          2:
          if Pnt+n>=1 then begin Result:=(Pfile+Pnt+n-1-1)^; Dec(n); end
                         else begin Result:=#26; end;
          if (Result<#32) and (Pnt+n>=1) then goto 2;
         end;
end;//function getnch



function TEkBaseRTFReport.GetNextReportField:AnsiString;
const MaxLens=10000;
var    ch : AnsiChar   ;
      cnt : integer;
MStoredPnt:longint ;


     //Reading from FileBody
     procedure ReadScan(var ch:AnsiChar);
     begin
      repeat
      readFB(ch);
      until (FileEof()) or (ch>#31) or (ch=#10) or (ch=#09);

     end; //procedure ReadScan

  //------------------------------------------------------------
  function isLeftQuote:boolean;
  begin
     Result:=false;
     //chr(147)----------------
     if (ch=#147) then begin
                       FQuoteIndex:=1; FQuoteSkip:=1; FQuoteStr:=#147;
                       Result:=true; exit;
                       end;
     if ( (ch='\') and (getnch(1)=#39) and (getnch(2)='9') and (getnch(3)='3') )
         then begin
              FQuoteIndex:=1; FQuoteSkip:=4; FQuoteStr:='\'+#39+'93';
              Result:=true; exit;
              end;
     //chr(148)----------------
     if (ch=#148) then begin
                       FQuoteIndex:=1; FQuoteSkip:=1; FQuoteStr:=#148;
                       Result:=true; exit;
                       end;
     if ( (ch='\') and (getnch(1)=#39) and (getnch(2)='9') and (getnch(3)='4') )
         then begin
              FQuoteIndex:=1; FQuoteSkip:=4; FQuoteStr:='\'+#39+'94';
              Result:=true; exit;
              end;


     //lquote------------------
     if (ch='\') and (UpperCase(getnch(1))='L') and (UpperCase(getnch(2))='Q') and (UpperCase(getnch(3))='U') and (UpperCase(getnch(4))='O') and (UpperCase(getnch(5))='T') and (UpperCase(getnch(6))='E') and ( not ((UpperCase(getnch(7))>='A') and (UpperCase(getnch(7))<='Z')))
        then begin
             FQuoteIndex:=2; FQuoteSkip:=7; FQuoteStr:='\lquote';
             Result:=true; exit;
             end;

     //ldblquote------------------
     if (ch='\') and (UpperCase(getnch(1))='L') and (UpperCase(getnch(2))='D') and (UpperCase(getnch(3))='B') and (UpperCase(getnch(4))='L') and (UpperCase(getnch(5))='Q') and (UpperCase(getnch(6))='U') and (UpperCase(getnch(7))='O') and (UpperCase(getnch(8))='T') and (UpperCase(getnch(9))='E') and ( not ((UpperCase(getnch(10))>='A') and (UpperCase(getnch(10))<='Z')))
        then begin
             FQuoteIndex:=8; FQuoteSkip:=10; FQuoteStr:='\ldblquote';
             Result:=true; exit;
             end;

     //rdblquote------------------
     if (ch='\') and (UpperCase(getnch(1))='R') and (UpperCase(getnch(2))='D') and (UpperCase(getnch(3))='B') and (UpperCase(getnch(4))='L') and (UpperCase(getnch(5))='Q') and (UpperCase(getnch(6))='U') and (UpperCase(getnch(7))='O') and (UpperCase(getnch(8))='T') and (UpperCase(getnch(9))='E') and ( not ((UpperCase(getnch(10))>='A') and (UpperCase(getnch(10))<='Z')))
        then begin
             FQuoteIndex:=8; FQuoteSkip:=10; FQuoteStr:='\rdblquote';
             Result:=true; exit;
             end;


     //rquote------------------
     if (ch='\') and (UpperCase(getnch(1))='R') and (UpperCase(getnch(2))='Q') and (UpperCase(getnch(3))='U') and (UpperCase(getnch(4))='O') and (UpperCase(getnch(5))='T') and (UpperCase(getnch(6))='E') and ( not ((UpperCase(getnch(7))>='A') and (UpperCase(getnch(7))<='Z')))
        then begin
             FQuoteIndex:=2; FQuoteSkip:=7; FQuoteStr:='\rquote';
             Result:=true; exit;
             end;


     //chr(171)----------------
     if (ch=#171) then begin
                       FQuoteIndex:=3; FQuoteSkip:=1; FQuoteStr:=#171;
                       Result:=true; exit;
                       end;

     if ( (ch='\') and (getnch(1)=#39) and (UpperCase(getnch(2))='A') and (UpperCase(getnch(3))='B') )
         then begin
              FQuoteIndex:=3; FQuoteSkip:=4; FQuoteStr:='\'+#39+'ab';
              Result:=true; exit;
              end;

     //chr(187)----------------
     if (ch=#187) then begin
                       FQuoteIndex:=3; FQuoteSkip:=1; FQuoteStr:=#187;
                       Result:=true; exit;
                       end;

     if ( (ch='\') and (getnch(1)=#39) and (UpperCase(getnch(2))='B') and (UpperCase(getnch(3))='B') )
         then begin
              FQuoteIndex:=3; FQuoteSkip:=4; FQuoteStr:='\'+#39+'bb';
              Result:=true; exit;
              end;

     if ch=#34 then begin FQuoteIndex:=4; FQuoteSkip:=1; FQuoteStr:=#34;
                          Result:=true; exit; end;
     if ch=#39 then begin FQuoteIndex:=5; FQuoteSkip:=1; FQuoteStr:=#39;
                          Result:=true; exit; end;
     if ch=#96 then begin FQuoteIndex:=6; FQuoteSkip:=1; FQuoteStr:=#96;
                          Result:=true; exit; end;
     if ch=#126 then begin FQuoteIndex:=7; FQuoteSkip:=1; FQuoteStr:=#126;
                           Result:=true; exit; end;
  end;// isLeftQuote

  function isRightQuote:boolean;
  begin
     Result:=false;
     case FQuoteIndex of
     1,8:begin
         //chr(148)----------------
         if (ch=#148) then begin
                           FQuoteSkip:=1; FQuoteStr:=#148;
                           Result:=true; exit;
                           end;
         if ( (ch='\') and (getnch(1)=#39) and (getnch(2)='9') and (getnch(3)='4') )
             then begin
                  FQuoteSkip:=4; FQuoteStr:='\'+#39+'94';
                  Result:=true; exit;
                  end;
         //rdblquote------------------
         if (ch='\') and (UpperCase(getnch(1))='R') and (UpperCase(getnch(2))='D') and (UpperCase(getnch(3))='B') and (UpperCase(getnch(4))='L') and (UpperCase(getnch(5))='Q') and (UpperCase(getnch(6))='U') and (UpperCase(getnch(7))='O') and (UpperCase(getnch(8))='T') and (UpperCase(getnch(9))='E') and ( not ((UpperCase(getnch(10))>='A') and (UpperCase(getnch(10))<='Z')))
            then begin
                 FQuoteSkip:=10; FQuoteStr:='\rdblquote';
                 Result:=true; exit;
                 end;
       end;//1

     2,5:begin
       if ch=#39 then begin FQuoteSkip:=1; FQuoteStr:=#39;
                            Result:=true; exit; end;
       //rquote------------------
       if (ch='\') and (UpperCase(getnch(1))='R') and (UpperCase(getnch(2))='Q') and (UpperCase(getnch(3))='U') and (UpperCase(getnch(4))='O') and (UpperCase(getnch(5))='T') and (UpperCase(getnch(6))='E') and ( not ((UpperCase(getnch(7))>='A') and (UpperCase(getnch(7))<='Z')))
          then begin
               FQuoteSkip:=7; FQuoteStr:='\rquote';
               Result:=true; exit;
               end;
       end;//2

     3:begin
       //chr(187)----------------
       if ( (ch='\') and (getnch(1)=#39) and (UpperCase(getnch(2))='B') and (UpperCase(getnch(3))='B') )
           then begin
                FQuoteSkip:=4; FQuoteStr:='\'+#39+'bb';
                Result:=true; exit;
                end;
       if (ch=#187) then begin
                         FQuoteSkip:=1; FQuoteStr:=#187;
                         Result:=true; exit;
                         end;

       end;//3

     4:begin if ch=#34 then begin FQuoteSkip:=1; FQuoteStr:=#34;
                                  Result:=true; exit; end; end;
     6:begin if ch=#96 then begin FQuoteSkip:=1; FQuoteStr:=#96;
                                  Result:=true; exit; end; end;
     7:begin if ch=#126 then begin FQuoteSkip:=1; FQuoteStr:=#126;
                                   Result:=true; exit; end; end;

     end;//case

  end;// isRightQuote

  //-------------------- check if we have read \\ or \'5c
  function isBackSlash:boolean;
  begin
     if (
         ( (ch='\') and (getnch(1)='\') ) or
         ( (ch='\') and (getnch(1)=#39) and (getnch(2)='5') and (UpperCase(getnch(3))='C') )
        )
         and not
        (
          ( (ch='\') and (getnch(1)='*') ) or
          ( (ch='\') and (getnch(1)='\') and (getnch(2)='*') )
        )
          then Result:=true else Result:=false;
  end;


  function TableRow:boolean;
  begin
      //trowd
      if (ch='\') and (UpperCase(getnch(1))='T') and (UpperCase(getnch(2))='R') and (UpperCase(getnch(3))='O') and (UpperCase(getnch(4))='W') and (UpperCase(getnch(5))='D') and ( not ((UpperCase(getnch(6))>='A') and (UpperCase(getnch(6))<='Z'))) then
              begin Result:=true; exit; end;
      Result:=false;
  end;

  function TableEndRow:boolean;
  begin
      //row
      if (ch='\') and (UpperCase(getnch(1))='R') and (UpperCase(getnch(2))='O') and (UpperCase(getnch(3))='W') and ( not ((UpperCase(getnch(4))>='A') and (UpperCase(getnch(4))<='Z'))) then
              begin Result:=true; exit; end;
      Result:=false;
  end;

  function FontTable:boolean;
  begin
      //{\fonttbl
      if (ch='{') and (UpperCase(getnch(1))='\') and (UpperCase(getnch(2))='F') and (UpperCase(getnch(3))='O') and (UpperCase(getnch(4))='N') and (UpperCase(getnch(5))='T') and (UpperCase(getnch(6))='T') and (UpperCase(getnch(7))='B') and (UpperCase(getnch(8))='L') and ( not ((UpperCase(getnch(9))>='A') and (UpperCase(getnch(9))<='Z'))) then
              begin Result:=true; exit; end;
      Result:=false;
  end;

  function ColorTable:boolean;
  begin
      //{\colortbl
      if (ch='{') and (UpperCase(getnch(1))='\') and (UpperCase(getnch(2))='C') and (UpperCase(getnch(3))='O') and (UpperCase(getnch(4))='L') and (UpperCase(getnch(5))='O') and (UpperCase(getnch(6))='R') and (UpperCase(getnch(7))='T') and (UpperCase(getnch(8))='B') and (UpperCase(getnch(9))='L') and ( not ((UpperCase(getnch(10))>='A') and (UpperCase(getnch(10))<='Z'))) then
              begin Result:=true; exit; end;
      Result:=false;
  end;

  function DocInfo:boolean;
  begin
      //{\info
      if (ch='{') and (UpperCase(getnch(1))='\') and (UpperCase(getnch(2))='I') and (UpperCase(getnch(3))='N') and (UpperCase(getnch(4))='F') and (UpperCase(getnch(5))='O') and ( not ((UpperCase(getnch(6))>='A') and (UpperCase(getnch(6))<='Z'))) then
              begin Result:=true; exit; end;
      Result:=false;
  end;

  function StyleSheet:boolean;
  begin
      //{\stylesheet
      if (ch='{') and (UpperCase(getnch(1))='\') and (UpperCase(getnch(2))='S') and (UpperCase(getnch(3))='T') and (UpperCase(getnch(4))='Y') and (UpperCase(getnch(5))='L') and (UpperCase(getnch(6))='E') and (UpperCase(getnch(7))='S') and (UpperCase(getnch(8))='H') and (UpperCase(getnch(9))='E') and (UpperCase(getnch(10))='E') and (UpperCase(getnch(11))='T') and ( not ((UpperCase(getnch(12))>='A') and (UpperCase(getnch(12))<='Z'))) then
              begin Result:=true; exit; end;
      Result:=false;
  end;


  function NeedToSkipBlock:boolean;
  begin
      if (ch='{') and (getnch(1)='\') and (UpperCase(getnch(2))='F') and (UpperCase(getnch(3))='I') and (UpperCase(getnch(4))='E') and (UpperCase(getnch(5))='L') and (UpperCase(getnch(6))='D') and ( not ((UpperCase(getnch(7))>='A') and (UpperCase(getnch(7))<='Z'))) then
              begin Result:=true; exit; end;
      if (ch='{') and (getnch(1)='\') and (UpperCase(getnch(2))='P') and (UpperCase(getnch(3))='I') and (UpperCase(getnch(4))='C') and (UpperCase(getnch(5))='T') and ( not ((UpperCase(getnch(6))>='A') and (UpperCase(getnch(6))<='Z'))) then
              begin Result:=true; exit; end;
      if (ch='{') and (getnch(1)='\') and (UpperCase(getnch(2))='O') and (UpperCase(getnch(3))='B') and (UpperCase(getnch(4))='J') and (UpperCase(getnch(5))='E') and (UpperCase(getnch(6))='C') and (UpperCase(getnch(7))='T') and ( not ((UpperCase(getnch(8))>='A') and (UpperCase(getnch(8))<='Z'))) then
              begin Result:=true; exit; end;
      Result:=false;
  end;

  function IsPar:boolean;
  begin
      //\par
      Result:=false;
      if (ch='\') and (getnch(-1)<>'\') and (UpperCase(getnch(1))='P') and (UpperCase(getnch(2))='A') and (UpperCase(getnch(3))='R') and ( not Letter(getnch(4))) then
              begin  Result:=true; end;
  end;

  function IsBoundary:boolean;
  begin
      //\trowd
      if (ch='\') and (getnch(-1)<>'\') and (UpperCase(getnch(1))='T') and (UpperCase(getnch(2))='R') and (UpperCase(getnch(3))='O') and (UpperCase(getnch(4))='W') and (UpperCase(getnch(5))='D') and ( not Letter(getnch(6))) then
              begin Result:=true; FLastBoundaryPnt:=Pnt-1; exit; end;
      //\row
      if (ch='\') and (getnch(-1)<>'\') and (UpperCase(getnch(1))='R') and (UpperCase(getnch(2))='O') and (UpperCase(getnch(3))='W') and ( not Letter(getnch(4))) then
              begin Result:=true; FLastBoundaryPnt:=Pnt-1; exit; end;
      //\cell
      if (ch='\') and (getnch(-1)<>'\') and (UpperCase(getnch(1))='C') and (UpperCase(getnch(2))='E') and (UpperCase(getnch(3))='L') and (UpperCase(getnch(4))='L') and ( not Letter(getnch(5))) then
              begin Result:=true; FLastBoundaryPnt:=Pnt-1; exit; end;
      //\page
      if (ch='\') and (getnch(-1)<>'\') and (UpperCase(getnch(1))='P') and (UpperCase(getnch(2))='A') and (UpperCase(getnch(3))='G') and (UpperCase(getnch(4))='E') and ( not Letter(getnch(5))) then
              begin Result:=true; FLastBoundaryPnt:=Pnt-1; exit; end;
      //\sect
      if (ch='\') and (getnch(-1)<>'\') and (UpperCase(getnch(1))='S') and (UpperCase(getnch(2))='E') and (UpperCase(getnch(3))='C') and (UpperCase(getnch(4))='T') and ( not Letter(getnch(5))) then
              begin Result:=true; FLastBoundaryPnt:=Pnt-1; exit; end;
      //\line
      if (ch='\') and (getnch(-1)<>'\') and (UpperCase(getnch(1))='L') and (UpperCase(getnch(2))='I') and (UpperCase(getnch(3))='N') and (UpperCase(getnch(4))='E') and ( not Letter(getnch(5))) then
              begin Result:=true; FLastBoundaryPnt:=Pnt-1; exit; end;
      //\par
      if IsPar() then begin Result:=true; FLastBoundaryPnt:=Pnt-1; exit; end;
      Result:=false;
  end;

  procedure ProcessFontTable; //Compiling
    function charset(s:AnsiString):integer;
    var p:integer;
        c:AnsiString;
     begin
     p:=pos('fcharset',s)+8;
     c:='';
     while (Digit(s[p])) and (p<length(s)) do begin
            c:=c+s[p]; inc(p);
            end;
     try
     Result:=strToint(c);
     except
     raise EBadRtfFormat.Create('Can''t define font charset in input file');
     end;//try
     end;//function charset

     procedure FTReadStrings;
     var s:AnsiString;
        DefCharSet:AnsiString;
        cnt, nread,t:integer;
        p,ln:integer;
     begin
     try
      ch:=' '; nread:=0;
      DefCharSet:=intToStr(FCharset);

      while (ch<>'}') and (not FileEof()) do
      begin
         while (ch<>'{') and (ch<>'}') and (not FileEof()) do readFB(ch);
         if ch='{' then
         begin
         cnt:=1; s:='{';

         while (cnt>0) and (not FileEof()) do
         begin
         readFb(ch);
         if ch='{' then inc(cnt);
         if ch='}' then dec(cnt);
         s:=s+ch;
         end;
         ch:=' ';
         FRTFFont.Add(s); inc(nread);
         end;
      end; //while not eof(f)

      for t:=0 to nread-1 do
      begin
         p:=pos('fcharset',FRTFFont[t]);
         if p>0 then begin
                     s:=FRTFFont[t];
                     ln:=length(s);
                     FRTFFont[t]:=copy(s,1,p-1)+'fcharset'+DefCharSet+copy(s,p+8+length(inttostr(CharSet(s))),ln);
                    end;
      end;

     except
        raise EBadRtfFormat.Create('Can''t read font table from input file');
     end;//try
    end;//FTReadStrings
  Begin//ProcessFontTable
      //fpnt points to '\'  {\fonttbl
      IncPnt(8);
      FTReadStrings;
      CmSaveFontTable; //order of CmSaving is important due to CmPos and Pnt changing
      FIsFontTable:=true;
  end;//ProcessFontTable

  procedure ProcessColorTable; //Compiling
  const ptests: PAnsiChar='\colortbl';
  var ch:AnsiChar;
      s,dgc:AnsiString;
      cnt, n, i:integer;
      c:TEkColor;

  begin
    //fpnt points to '\'  {\colortbl
    IncPnt(9);

          c:=TEkColor.create;

          cnt:=1; s:='';
          while (cnt>0) and (not FileEof()) do
          begin
          readFb(ch);
          if ch='{' then inc(cnt);
          if ch='}' then dec(cnt);
          s:=s+ch;
          end;
          if FileEof() then  raise EBadRtfFormat.Create('Can''t read color table from input file');

          //AnsiString s contains red green blue sequences and final bracket
          n:=pos('red',s);
          while n>0 do
          begin
              inc(FDocColorCount);
              Setlength(FDocColorTable,FDocColorCount);
              c.r:=0; c.g:=0; c.b:=0;
              s[n]:='_'; inc(n,3);
              dgc:='';
                 while Digit(s[n]) do begin dgc:=dgc+s[n]; inc(n); end;
              c.r:=strtoint(dgc);
              FDocColorTable[FDocColorCount-1]:=TEkColor.create;
              FDocColorTable[FDocColorCount-1].color:=c.color;
              n:=pos('red',s)
          end;

          for i:=0 to FDocColorCount-1 do
          begin
              //------green---------
              c.color:=FDocColorTable[i].color;
              n:=pos('green',s);
              s[n]:='_'; inc(n,5);
              dgc:=''; while Digit(s[n]) do begin dgc:=dgc+s[n]; inc(n); end;
              c.g:=strtoint(dgc);
              //----------blue------
              n:=pos('blue',s);
              s[n]:='_'; inc(n,4);
              dgc:=''; while Digit(s[n]) do begin dgc:=dgc+s[n]; inc(n); end;
              c.b:=strtoint(dgc);

              FDocColorTable[i].color:=c.color;
          end;//for
          c.free;

          FRTFColor.Add(';');
          for i:=0 to FDocColorCount-1 do
          begin
          FRTFColor.Add('\red'+inttostr(FDocColorTable[i].r)+'\green'+inttostr(FDocColorTable[i].g)+'\blue'+inttostr(FDocColorTable[i].b)+';');
          end;//for

    CmSaveColorTable;
    FIsColorTable:=true;

  end;//ProcessColorTable

  procedure ProcessStyleSheet; //Compiling
  var  cnt:integer;
         s:AnsiString;
  begin
    //fpnt points to '\'  {\stylesheet
    IncPnt(11);

      ch:=' ';
      while (ch<>'}') and (not FileEof()) do
      begin
         while (ch<>'{') and (ch<>'}') and (not FileEof()) do readFB(ch);
         if ch='{' then
         begin
         cnt:=1; s:='{';

         while (cnt>0) and (not FileEof()) do
         begin
         readFb(ch);
         if ch='{' then inc(cnt);
         if ch='}' then dec(cnt);
         s:=s+ch;
         end;
         ch:=' ';
         FRTFStyle.Add(s);
         end;
      end; //while not eof(f)

    CmSaveStyleSheet;
    FIsStyle:=true;
  end;//ProcessStyleSheet

  procedure ProcessDocInfo; //Compiling
  var  cnt:integer;
         s:AnsiString;
  begin
    //fpnt points to '\'  {\info
    IncPnt(5);

      ch:=' ';
      while (ch<>'}') and (not FileEof()) do
      begin
         while (ch<>'{') and (ch<>'}') and (not FileEof()) do readFB(ch);
         if ch='{' then
         begin
         cnt:=1; s:='{';

         while (cnt>0) and (not FileEof()) do
         begin
         readFb(ch);
         if ch='{' then inc(cnt);
         if ch='}' then dec(cnt);
         s:=s+ch;
         end;
         ch:=' ';
         FRTFDocInfo.Add(s);
         end;
      end; //while not eof(f)

    CmSaveDocInfo;
    FIsDocInfo:=true;
  end;//ProcessDocInfo

  procedure SkipBlock(WriteBlock:boolean);
  var np, n, ct:integer;
      binsize:AnsiString;
      c:AnsiChar;
  begin
       ct:=1; np:=1;
       // ch='{' first symbol in block
       while (ct<>0) and (not FileEof()) do
       begin
           c:=(Pfile+Pnt+np-1-1)^;
              if (c='{') then begin inc(ct);  end;
              if (c='}') then begin dec(ct);  end;

            //if bin control
            if (c='\') and (UpperCase(getnch(1))='B') and (UpperCase(getnch(2))='I') and (UpperCase(getnch(3))='N') and ((getnch(4)>='0') and (getnch(4)<='9')) then
                begin
                //write bin control
                   n:=4;
                   while ((Pfile+Pnt+np-1-1)^>='0') and ((Pfile+Pnt+np-1-1)^>='9') do
                   begin
                      binsize:=binsize+getnch(n);
                      inc(n);
                   end;
                   n:=n+1+strtoint(binsize); //n=length of binary block with \bin word
                   np:=np+n;
                end else begin
                         inc(np);
                         end;{if not bin}

       end;{while not end of block}
       if WriteBlock then Outf.WriteBuffer((Pfile+Pnt-2)^,np);
       IncPnt(np-1);
  end;//proc SkipBlock


begin //---- GetNextReportField

    ch:=' '; Result:='';
    while not FileEof() do
          begin
          readFb(ch);
          IsBoundary();
          if FontTable() then begin ProcessFontTable; continue; end;
          if ColorTable() then begin ProcessColorTable; continue; end;
          if StyleSheet() then begin ProcessStyleSheet; continue; end;
          if DocInfo() then begin ProcessDocInfo; continue; end;

          if NeedToSkipBlock() then begin SkipBlock(false);
                                          CmSaveBalancedBlocItem;
                                          continue; end;

          if TableRow() then begin
                             IncPnt(-1);
                             CmSaveTableBegin;
                             FInTable:=true;
                             IncPnt(1);
                             CmSaveBlocItem;
                             continue;
                             end;

          if TableEndRow() then begin
                                IncPnt(3);
                                CmSaveBlocItem;
                                CmSaveTableEnd;
                                FInTable:=false;
                                continue;
                                end;


          if (not isBackSlash()) then begin CmSaveBlocItem; end else begin FKwdPnt:=Pnt-1; break; end;
    end; //while 2

    if not FileEof() then
    begin
          readScan(ch);
          if ch=#39 then begin readscan(ch); readscan(ch); end; //if 5c then read two chars more.

             cnt:=0; Result:=''; ch:=' ';
             MStoredPnt:=Pnt;

             while (cnt<MaxLens) and (not IsBoundary()) and (not NeedToSkipBlock()) and (not FileEof()) do
             begin
               readScan(ch);

                 if (FQuoteIndex=0) and (isLeftQuote()) then begin
                    Result:=Result+FQuoteStr;
                    inc(cnt,FQuoteSkip);
                    if FQuoteSkip>1 then IncPnt(FQuoteSkip-1);
                    //in case of \l(dbl)quote skip space after control word if it exists
                    if ((FQuoteIndex=2) or (FQuoteIndex=8)) and (getnch(1)=#32) then begin
                                                                readScan(ch);
                                                                Result:=Result+ch;
                                                                inc(cnt);
                                                                end;
                    continue;
                 end;//if

                 if (FQuoteIndex>0) and (not isRightQuote()) then begin

                      if (ch='\') and (getnch(1)=#39) then begin
                          readscan(ch);
                          Result:=Result+'\'+#39;
                          readscan(ch); Result:=Result+ch;
                          readscan(ch); Result:=Result+ch;
                          inc(cnt,4);
                          continue;
                          end;

                      if (ch='\') and (getnch(1)=#126) then begin
                          readscan(ch);
                          Result:=Result+'\'+#126;
                          inc(cnt,2);
                          continue;
                         end;

                     Result:=Result+ch; inc(cnt);
                     continue;
                 end;//if

                 if (FQuoteIndex>0) and (isRightQuote()) then begin
                    Result:=Result+FQuoteStr;
                    inc(cnt,FQuoteSkip);
                    if FQuoteSkip>1 then IncPnt(FQuoteSkip-1);
                    //in case of \l(dbl)quote skip space after control word if it exists
                    if ((FQuoteIndex=2) or (FQuoteIndex=8)) and (getnch(1)=#32) then begin
                                                                readScan(ch);
                                                                Result:=Result+ch;
                                                                inc(cnt);
                                                                end;
                    FQuoteIndex:=0; FQuoteStr:=''; FQuoteSkip:=0;
                    continue;
                 end;//if


                 if (FQuoteIndex=0) and (not isBackSlash()) then begin
                      if (ch='\') and (getnch(1)=#39) then begin
                          readscan(ch);
                          Result:=Result+'\'+#39;
                          readscan(ch); Result:=Result+ch;
                          readscan(ch); Result:=Result+ch;
                          inc(cnt,4);
                          continue;
                          end;

                      if (ch='\') and (getnch(1)=#126) then begin
                          readscan(ch);
                          Result:=Result+'\'+#126;
                          inc(cnt,2);
                          continue;
                         end;

                     Result:=Result+ch; inc(cnt);
                 end else break;

             end;//while cnt<MaxLens

             if (not isBackSlash()) then
             begin
               //Not a field name - write '\\' to outf and scan again
               Pnt:=MStoredPnt;
               FQuoteIndex:=0; FQuoteSkip:=0; FQuoteStr:='';
               CmSaveBlocItem;
               Result:='';
             end else begin
                readScan(ch);
                if ch=#39 then begin readscan(ch); readscan(ch); end; //if 5c then read two chars more.
                exit;  //***************** Return
             end;
    end; //if not eof

end; //function GetNextReportField;

procedure TEkBaseRTFReport.SaveToOutTable(fid:longint);
var tlnt, tn1:longint;
begin
    tlnt:=Length(FOutTab);
    if tlnt=0 then begin
       SetLength(FOutTab,1);
       FOutTab[0].n1:=0;
       FOutTab[0].n2:=TmpStream.Position;
       FOutTab[0].id:=fid;
    end else begin
             tn1:=FOutTab[tlnt-1].n2;
             SetLength(FOutTab,tlnt+1);
             FOutTab[tlnt].n1:=tn1;
             FOutTab[tlnt].n2:=TmpStream.Position;
             FOutTab[tlnt].id:=fid;
             end;
end;//SaveToOutTable

function TEkBaseRTFReport.KillPar:AnsiString;
var bakpnt:Longint;
    teststr, text, rtf:AnsiString;
    testch:AnsiChar;
    y0,y:boolean;
begin
        bakpnt:=Pnt;
        teststr:='';
        y0:=true;
        if (FLastBoundaryPnt>-1) and (FKwdPnt>FLastBoundaryPnt) then begin
           Pnt:=FLastBoundaryPnt;
           while Pnt<FKwdPnt do begin
              ReadFb(testch);
              teststr:=teststr+testch;
           end;//while
           CutRtString(teststr,text,rtf);
           if length(text)>0 then begin
              y0:=false;  //don't delete the paragraph after next keyword
           end;//if
        end;//if

        Pnt:=bakpnt;
        y:=false;
        Result:='';

        ReadFb(testch);
        teststr:=testch;


      while (not FileEof()) and not
        (
        (testch='\')
        and (getnch(1)='p') and (getnch(2)='a')
        and (getnch(3)='r')
        and (
             (
             (not Digit(getnch(4)))  and (not Letter(getnch(4)))
             )
             or (getnch(4)=#32)
            )
        ) do
        begin
            ReadFb(testch);
            teststr:=teststr+testch;
        end;//while

        if not FileEof() then
           begin
           //set LastBoundaryPnt here as we have found a "\par"
           FLastBoundaryPnt:=Pnt-1;
           CutRtString(copy(teststr,1,length(teststr)-1),text,rtf);
               //if there is no text then kill paragraph
               if (length(text)=0) and (y0) then
               begin
                y:=true;
                if getnch(4)=#32 then IncPnt(4) else IncPnt(3);
                //remove last \
                if length(teststr)>0 then teststr:=copy(teststr,1,length(teststr)-1);
                Result:=teststr;   //chars to save after keyword scan without \par
               end;
           end;
        if not y then Pnt:=bakpnt; //nothing to do - here is the contents of the scan block or after endscan
end;//func KillPar

{------------------ TEkColorStringList ---------------------------}
function TEkColorStringList.UseColor(s: AnsiString): longint;
begin
  Result:=IndexOf(s);
  if Result=-1 then begin
     if Count=0 then Add(';');
     Result:=Add(s);
  end;
end;

{-----------------TEkImageFormat-----------------------------}
constructor TEkImageFormat.create(x,y:word);
//var p:double;
begin
  inherited create;
  FSizeX:=x; FSizeY:=y;
  FScaleX:=100; FScaleY:=100;
  FProportional:=true;
  FSizeXmm:=x*0.264596930676; FSizeYmm:=y*0.264596930676;
  //p:=1440/(56.69*Screen.PixelsPerInch);
  //FSizeXmm:=x*p; FSizeYmm:=y*p;
  FBorder.BrType:=brNone; FBorder.Width:=0; FBorder.ColorIndex:=0;
end;

procedure TEkImageFormat.SetScaleX(Value:Word);
var k:Double;
begin
    if Value<1 then Value:=1;
    k:=Value/FScaleX; FScaleX:=Value;
    FSizeX:=round(FSizeX*k);
    FSizeXmm:=FSizeXmm*k;
    if FProportional then begin FScaleY:=round(FScaleY*k);
                                FSizeY:=round(FSizeY*k);
                                FSizeYmm:=FSizeYmm*k;
                          end;
end;

procedure TEkImageFormat.SetScaleY(Value:Word);
var k:Double;
begin
    if Value<1 then Value:=1;
    k:=Value/FScaleY; FScaleY:=Value;
    FSizeY:=round(FSizeY*k);
    FSizeYmm:=FSizeYmm*k;
    if FProportional then begin FScaleX:=round(FScaleX*k);
                                FSizeX:=round(FSizeX*k);
                                FSizeXmm:=FSizeXmm*k;
                          end;
end;

procedure TEkImageFormat.SetSizeXY(x, y: Word);
begin
  FSizeX:=x; FSizeY:=y;
  FScaleX:=100; FScaleY:=100;
  FSizeXmm:=x*0.264596930676; FSizeYmm:=y*0.264596930676;
end;

procedure TEkImageFormat.SetSizeXmm(Value: Double);
var k:Double;
begin
  if (Value>0) and (Value<>FSizeXmm) then
     begin
       if FSizeXmm>0 then k:=Value/FSizeXmm else k:=1;
       FSizeXmm:=Value;
       FSizeX:=round(FSizeX*k);
       FScaleX:=round(FScaleX*k);
       if FProportional then begin FSizeYmm:=round(FSizeYmm*k);
                                   FSizeY:=round(FSizeY*k);
                                   FScaleY:=round(FScaleY*k);
                             end;
     end;
end;

procedure TEkImageFormat.SetSizeYmm(Value: Double);
var k:Double;
begin

  if (Value>0) and (Value<>FSizeYmm) then
     begin
       if FSizeYmm>0 then k:=Value/FSizeYmm else k:=1;;
       FSizeYmm:=Value;
       FSizeY:=round(FSizeY*k);
       FScaleY:=round(FScaleY*k);
       if FProportional then begin FSizeXmm:=round(FSizeXmm*k);
                                   FSizeX:=round(FSizeX*k);
                                   FScaleX:=round(FScaleX*k);
                             end;
     end;
end;

procedure TEkImageFormat.FitScaleToX(x:Word);
var k:Double;
    NewScaleX:Word;
begin
    if x<1 then x:=1;
    k:=x/FSizeX; NewScaleX:=round(100*k);
    SetScaleX(NewScaleX);
end;

procedure TEkImageFormat.FitScaleToY(y:Word);
var k:Double;
    NewScaley:Word;
begin
    if y<1 then y:=1;
    k:=y/FSizeY; NewScaleY:=round(100*k);
    SetScaleY(NewScaleY);
end;

procedure TEkImageFormat.SetBorder(Value:TEkImageBorder);
var wtwip:byte;
begin
      FBorder.BrType:=Value.BrType;
      if value.Width>3.5 then value.Width:=3.5;
      wtwip:=round(20*Value.width);
      if wtwip>75 then wtwip:=75;
      FBorderTwips:=wtwip;
      if wtwip=0 then FBorder.BrType:=brNone;
      FBorder.ColorIndex:=Value.ColorIndex;
end;

procedure TEkImageFormat.SetBorderType(BrType:TEkImageBorderType; BrWidth:Single; ColorIndex:Word);
var B:TEkImageBorder;
begin
   B.BrType:=BrType;
   B.Width:=BrWidth;
   B.ColorIndex:=ColorIndex;
   SetBorder(B);
end;

{ TEkExpression }

procedure TEkExpression.Add(MText: AnsiString; MIsOperand, MReqBoolArg, MAllowBoolArg, MRetBoolRes: boolean;
  MPriority, MFldnum: integer);
begin
 SetLength(FExpression,FCount+1);
 if (MReqBoolArg) and (not MAllowBoolArg) then raise Exception.Create('TEkExpression Add  - cannot set AllowBoolArg to false when ReqBoolArg is true');
 with FExpression[FCount] do begin
    Text:=MText;
    IsOperand:=MIsOperand;
    ReqBoolArg:=MReqBoolArg;
    AllowBoolArg:=MAllowBoolArg;
    RetBoolRes:=MRetBoolRes;
    Priority:=MPriority;
    Fldnum:=MFldnum;
 end;//with
 Inc(FCount);
end;

procedure TEkExpression.Add(MOperand: TEkOperand);
begin
 SetLength(FExpression,FCount+1);
 if (MOperand.ReqBoolArg) and (not MOperand.AllowBoolArg) then raise Exception.Create('TEkExpression Add  - cannot set AllowBoolArg to false when ReqBoolArg is true');
 FExpression[FCount]:=MOperand;
 Inc(FCount);
end;

constructor TEkExpression.Create;
begin
 inherited Create;
 FCount:=0;
end;

destructor TEkExpression.Destroy;
begin
  FExpression:=nil;
  inherited Destroy;
end;

function TEkExpression.GetOperand(index: integer): TEkOperand;
begin
  if (index>=0) and (index<FCount) then begin
     Result:=FExpression[index];
   end else begin
     raise Exception.Create('TEkExpression GetOperand '+inttostr(index)+' - invalid index of operand');
  end;
end;



{ TEkOperandStack }

constructor TEkOperationStack.Create;
begin
 inherited Create;
 FCount:=0;
end;

destructor TEkOperationStack.Destroy;
begin
  FExpression:=nil;
  inherited Destroy;
end;

function TEkOperationStack.GetOperation(index: integer): TEkOperand;
begin
  if (index>=0) and (index<FCount) then begin
     Result:=FExpression[index];
   end else begin
     raise Exception.Create('TEkOperationStack GetOperation '+inttostr(index)+' - invalid index of operation');
  end;
end;

function TEkOperationStack.Pop: TEkOperand;
begin
 Result:=GetOperation(FCount-1);
 Dec(FCount);
 SetLength(FExpression,FCount+1);
end;

procedure TEkOperationStack.Push(MOperand: TEkOperand);
begin
 SetLength(FExpression,FCount+1);
 FExpression[FCount]:=MOperand;
 Inc(FCount);
end;

end.

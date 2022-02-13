(*****************************************)
(*           Ek RTF report v 2.02        *)
(*   (C) Eugene Kuchugurov, 2000-2003    *)
(*****************************************)

//fldnum
//ProcessExpression
//ProcessConst
//processUDFArgs
//CountIfBalanceEmp
//CountScanBalanceEmp
//CountScanBalanceFull
//PutField + init LastBoundary
//ExecReport
//OutConst
//WriteVarRTF
//WriteFieldRTF
//GetFieldString
//OutUDF
//InitSkipUDF

{$DEFINE registered}
unit ekrtf;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, DB, DBGrids,
  ekbasereport, conscom, ekfunc;


   type
      TEkRTF=class;
   //Scan
   TEkScanInfo=class
     protected
       FOwnerReport    :TEkRtf;
       FScanPnt        : longint;
       FCmPosition     : longint;
       FNumber         : longint;
       FLevel          : longint;
       //----scanentry-----------
       FEntryCmPosition: longint;
       FScanEntryPnt   : longint;
       FIsEntry        : boolean;
       //----scanfooter----------
       FFooterCmPosition: longint;
       FScanFooterPnt  : longint;
       FIsFooter       : boolean;
       //------------------------
       FDataSet        : TDataSet;
       FUseBookMarkList: boolean;
       FBookMarkList   : TBookMarkList;
       FBookMarkPos    : integer;
       FNewPage        : boolean;
       FNoEof          : boolean;
       FIsCompleted    : boolean;
       FFirstPass      : boolean;
       FIsWhile        : boolean;
       FWhileString    : AnsiString;
       FScanManageResult: boolean;
       //----balance-------------
       FBalance        : boolean;
       FFullBalance    : longint;
       FEmptyBalanceS  : AnsiString;
       //-----If-----------------
       FeklngId        : longint;
       //---functions------------
       constructor create(OwnerReport:TEkRtf; m_pnt, m_cmpos,n,level:longint; D:TDataSet; m_page, m_noeof, m_iswhile:boolean; swh:AnsiString; meklngId:longint);
     public

       procedure SetSelectedRows(Value:TBookMarkList);

       property CmPosition:longint read FCmPosition;
       property EntryCmPosition:longint read FEntryCmPosition;

       property NewPage:boolean read FNewPage;
       property NoEof:boolean read FNoEof;
       property IsCompleted:boolean read FIsCompleted write FIsCompleted;
       property IsEntry:boolean read FIsEntry;
       property IsFooter:boolean read FIsFooter;
       property IsWhile:boolean read FIsWhile;
       property WhileString:AnsiString read FWhileString;
       property ScanManageResult:boolean read FScanManageResult write FScanManageResult;
       property EkLngId:longint read FeklngId;
       property FirstPass:boolean read FFirstPass write FFirstPass;
       property Balance:boolean read FBalance write FBalance;
       property FullBalance:longint read FFullBalance write FFullBalance;
       property EmptyBalance:AnsiString read FEmptyBalanceS write FEmptyBalanceS;
       property OwnerReport:TEkRtf read FOwnerReport;
       property Number:longint read FNumber;
       property ScanLevel:longint read FLevel;
       property DataSet:TDataSet read FDataSet;
       property UseSelectedRows:boolean read FUseBookmarklist write FUseBookmarklist;
       property SelectedRows:TBookMarkList read FBookmarkList write SetSelectedRows;
       destructor Destroy;override;
    end;


    TEkScans = class
    protected
      FOwnerReport : TEkRtf;
      FScCount, FScLevel, FNum:word;
      FScLevelMax : word;
      FScanNum    : array of word;
      FArrScanInfo : array of TEkScanInfo;
      function GetCurrentScanNum: longint;
      function GetCurrentScanInfo: TEkScanInfo;
      function GetTopScanInfo: TEkScanInfo;
      function GetScanpnt:longint;
      function GetScanEntryPnt:longint;
    public
      property ScLevel:Word read FScLevel;
      property ScCount:Word read FScCount;
      property ScanPnt:longint read GetScanPnt;
      property ScanEntryPnt:longint read GetScanEntryPnt;
      property CurrentScanNum:longint read GetCurrentScanNum;
      property CurrentScanInfo:TEkScanInfo read GetCurrentScanInfo;
      property CurrentTopScanInfo:TEkScanInfo read GetTopScanInfo;
      property OwnerReport:TEkRtf read FOwnerReport;
      constructor Create(OwnerReport:TEkRtf);
      destructor Destroy;override;
      procedure SetScanEntry(m_cmpos,m_pnt:longint);
      procedure SetScanFooter(m_cmpos,m_pnt:longint);
      procedure EnterScan(m_cmpos,m_pnt:longint; Ds:TDataSet; m_page, m_noeof, m_iswhile:boolean; swh:AnsiString; meklngId:longint);
      procedure ExitScan;
      procedure SetCurrentScan(n:word);
      procedure GoFirst;
      procedure GoNext;
      function NotEof:boolean;
      function LastManageResult:boolean;
      function NotDataSetEof:boolean;
    end;


   TEkOnScanBefore = procedure(ScanInfo:TEkScanInfo) of object;
   TEkOnScanRecord = procedure(ScanInfo:TEkScanInfo) of object;
   TEkOnScanEof = procedure(ScanInfo:TEkScanInfo) of object;

  TEkRTF = class(TEkBaseRTFReport)
  private

    FOnScanBefore:TEkOnScanBefore;
    FOnScanRecord:TEkOnScanRecord;
    FOnScanEof:TEkOnScanEof;
    FOnImageFormat:TEkOnImageFormat;

    FScs: TEkScans;
    FManageResult:boolean;

    FDisableControls:boolean;
    FControlStatus:TEkControlStatus;
    FExecuteSuccessful:boolean;
    FLastErrMsg:AnsiString;

    protected

    procedure SetDisableControls(Value: boolean);
    property Scs:TEkScans read FScs write FScs;
    property ManageResult:boolean read FManageResult write FManageResult;
    procedure DisControls(DS:Array of TDataSet);
    procedure EnaControls(DS:Array of TDataSet);
    procedure ExecReport(DS:Array of TDataSet);
    procedure PutField(DFiles:array of TDataSet);virtual;
    procedure DefineFieldNumber(DFiles:array of TDataSet; var R:TEkRowContent);
    procedure InitFunctions(udfnumber:longint;Args:TEkUDFArgs; ArgCount:integer; var ishexpr:AnsiString);
    procedure DoFunctions(udfnumber:longint; Args:TEkUDFArgs; UDFResult:TEkUDFResult);
    procedure ExecUDF(udfnumber:longint; Args:TEkUDFArgs; ArgCount:integer; UDFResult:TEkUDFResult; var ishexpr:AnsiString);

  public
    { Public declarations }

    procedure Execute(DS:Array of TDataSet);virtual;
    procedure ExecuteOpen(DS:Array of TDataSet; ShowCmd:integer);virtual;
    procedure ExecuteStream(DS:Array of TDataSet; OutStream:TStream);virtual;
    property ExecuteSuccessful:boolean read FExecuteSuccessful;
    property LastErrMsg:AnsiString read FLastErrMsg;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  published
    property OnImageFormat:TEkOnImageFormat read FOnImageFormat write FOnImageFormat;
    property OnScanBefore:TEkOnScanBefore read FOnScanBefore write FOnScanBefore;
    property OnScanRecord:TEkOnScanRecord read FOnScanRecord write FOnScanRecord;
    property OnScanEof:TEkOnScanEof read FOnScanEof write FOnScanEof;
    property DisableControls: boolean read FDisableControls write SetDisableControls;

  end;

  procedure Register;

implementation
uses Jpeg, ekrtfstream, ShellAPI;

{function half(c:AnsiChar;def:integer):integer;
begin
 if ord(c)<64 then Result:=def else
    if ord(c)>127 then Result:=2 else Result:=1;
end;

function sides(n:byte):AnsiChar;
begin
  case n of
  1:Result:='t';
  2:Result:='l';
  3:Result:='b';
  4:Result:='r';
  5:Result:='h';
  6:Result:='v';
  else
    begin Result:='r'; end;
  end;
end;}

{----------*** PutField ***----------------------------------}
procedure TEkRTF.PutField(DFiles:array of TDataSet);
                       var
                         i      : integer  ;
                         testf, //chars between
                       fldname, //field name found
                     fldoutstr  : AnsiString; //formatting tags
                         fmtvar : TEkFieldFormat; //for single variables
                        DefLang : AnsiString;

                          MPar:AnsiString;
                          MCmpos:longint;
                          MCmLastId:longint;
                          Mn:word;
                          MElseFlag:boolean;
                          MIFFirstPass:boolean;

    function GetNextExprOperation(var ex, nextop, tail:AnsiString; Unary:boolean):boolean;
    var ln:longint;
        c:AnsiChar;
        s:AnsiString;
    begin
       Result:=false;
       ex:=trim(ex);
       ln:=length(ex);
       nextop:=''; tail:=ex;
       if (ln<1) then exit;

       if (ln>1) then begin
          s:=copy(ex,1,2);
          if (s='&&') or (s='||') or (s='<=') or (s='>=') or (s='<>') or (s='!=') then begin
             nextop:=s;
             tail:='';
             if (ln>2) then tail:=copy(ex,3,ln-2);
             Result:=true;
             exit;
          end;
       end;//if (ln>1)

       c:=ex[1];
       if c in ['(',')','*','/','%','+','-','!','>','<','='] then begin
          nextop:=c;
          tail:='';
          if (ln>1) then tail:=copy(ex,2,ln-1);
          if (Unary) and (c in ['+','-']) then nextop:='u'+nextop;
          Result:=true;
       end;

    end;//GetNextExprOperation

     function GetNextExprField(var ex, nextfield, tail:AnsiString):integer;
     var ln,f,lastcf,nested, p:longint;
         inquote, IsDecSp, IsExp, IsExpDigit, IsExpSign, IsNumber, IsBreak:boolean;
         IsVar, IsUDF, IsData:boolean;
         lq,c,cp, dlm:AnsiChar;
         ADecimalSeparator: AnsiChar;
     begin
       ADecimalSeparator := AnsiChar(FormatSettings.DecimalSeparator);

       Result:=-5;
       ex:=trim(ex);
       ln:=length(ex);
       nextfield:=''; tail:=ex;

       if (ln<1) or (ex[1]=')') or (ex[1]=':')
          or (ex[1]='<') or (ex[1]='>') or (ex[1]='=') or (ex[1]='*')
          or (ex[1]='/') or (ex[1]='%') then begin tail:=ex; exit; end;

       //check if data {dddd-dd-dd} expected {yyyy-mm-dd} not checked
       if (ln>=12) and (ex[1]='{') and (ex[12]='}')
          and (digit(ex[2])) and (digit(ex[3])) and (digit(ex[4])) and (digit(ex[5]))
          and (ex[6]='-') and (digit(ex[7])) and (digit(ex[8])) and (ex[9]='-')
          and (digit(ex[10])) and (digit(ex[11])) then begin
          Result:=5;
          nextfield:=copy(ex,1,12);
          tail:='';
          if ln>12 then tail:=copy(ex,13,ln-12);
          exit;
       end; //-----------------------------------------------------------------

       //check if true
       if (ln>=4) and (UpperCase(copy(ex,1,4))='TRUE') then begin
          Result:=4;
          nextfield:='TRUE';
          tail:='';
          if ln>4 then tail:=copy(ex,5,ln-4);
          exit;
       end;

       //check if false
       if (ln>=5) and (UpperCase(copy(ex,1,5))='FALSE') then begin
          Result:=4;
          nextfield:='FALSE';
          tail:='';
          if ln>5 then tail:=copy(ex,6,ln-5);
          exit;
       end; //----------------------------------------------------------------

      //check if numeric constant
       lastcf:=1;
       IsDecSp:=false; IsExp:=false;
       IsExpDigit:=false; IsExpSign:=false;
       IsNumber:=true; IsBreak:=false;
       c:=ex[1];
      if (c=ADecimalSeparator) or (c='+') or (c='-') or (digit(c)) then begin
       for f:=2 to ln do begin  // ====
        cp:=c;
        c:=ex[f];
        lastcf:=f;
        if not IsExp then begin // before E
             if ((digit(cp)) or (f=2)) and (not IsDecSp) and
                                          ( (digit(c)) or (c=ADecimalSeparator) or (c='E') or (c='e')
                                           ) then begin continue; end;
             if ((digit(cp)) or (f=2)) and (IsDecSp) and
                                          ( (digit(c)) or (c='E') or (c='e')
                                           ) then begin continue; end;
             if (cp=ADecimalSeparator) and (not IsDecSp) and ( (digit(c))
                                           ) then begin
                                             IsDecSp:=true; continue;
                                             end;
             if ((cp='E') or (cp='e')) and ( (digit(c)) or (c='+') or (c='-')
                                            ) then begin
                                              IsExp:=true; continue;
                                              end;
             if (not digit(cp)) then IsNumber:=false;
             IsBreak:=true; break;

        end else begin //after E

             if (digit(cp)) and (digit(c)) then begin
                                           IsExpDigit:=true; continue;
                                           end;
             if (not IsExpDigit) and (not IsExpSign) and ((cp='+') or (cp='-')) and (digit(c))
                                              then begin
                                              IsExpSign:=true; continue;
                                              end;
             if (not digit(cp)) then IsNumber:=false;
             IsBreak:=true; break;

        end;//if before/after E

       end;//for                   ====

       if (not IsBreak) and (not digit(c)) then IsNumber:=false;

       if IsNumber then begin
          if IsBreak then begin
                           nextfield:=copy(ex,1,lastcf-1);
                           tail:=copy(ex,lastcf,ln-lastcf+1);
                          end else begin
                           nextfield:=ex;
                           tail:='';
                          end;
          Result:=2; exit;
       end;//if

      end;//if (c=DecimalSeparator ...
      //end if numeric constant -------------------------------------------


   // check if it is quoted constant -----
   if (ln>1) and (LeftQuote(ex[1])) then begin

   inquote:=false; lq:=' ';
   for f:=1 to ln do
   begin
      c:=ex[f];
      if (not inquote) and (LeftQuote(c)) then begin
          inquote:=true; lq:=c;
          continue;
          end;
      if (inquote) and (not RightQuote(lq,c)) then continue;
      if (inquote) and (RightQuote(lq,c)) then begin
         inquote:=false;
         nextfield:=copy(ex,1,f);
         tail:='';
         if f<ln then tail:=copy(ex,f+1,ln-f);
         break;
         end;
    end;//for

       if not inquote then begin
          //right quote was found
          Result:=3;
          exit;
       end;

   end;//if
   // end quoted constant -----------------------------------------------------


   //0 variable
       cp:=ex[1]; c:=cp;
       lastcf:=1; IsVar:=true; IsBreak:=false;
      if (Letter(cp)) or (ord(cp)>191) or (cp='_') then begin

       for f:=2 to ln do begin
        cp:=c;
        c:=ex[f];
        lastcf:=f;
        if (Letter(c)) or (ord(c)>191)
            or (c='_') or (c=#32) or (digit(c))
                                   then begin
                                   continue;
                                   end;
        if (cp=#32) then begin IsVar:=false; end;
        IsBreak:=true; break;
       end;//for

       if (not IsBreak) and (c=#32) then IsVar:=false;

       if (IsVar) and (c<>'(') and (c<>':') and (c<>'.') then begin
          if IsBreak then begin
                           nextfield:=copy(ex,1,lastcf-1);
                           tail:=copy(ex,lastcf,ln-lastcf+1);
                          end else begin
                           nextfield:=ex;
                           tail:='';
                          end;
          Result:=0; exit;
       end;//if
 // A
 // |
 // V
       //1 UDF lastcf='('
       if (IsBreak) and (c='(') and (ln>lastcf) and ((Letter(cp)) or (ord(cp)>191)
                                        or (cp='_') or (digit(cp))
                                       ) then begin
       IsUDF:=true;
       nested:=1; inquote:=false; lq:=' ';
       inc(lastcf);
       for f:=lastcf to ln do
        begin
         c:=ex[f];
         lastcf:=f;
          if (not inquote) and (LeftQuote(c)) then begin
              inquote:=true; lq:=c;
              continue;
              end;
          if (inquote) and (not RightQuote(lq,c)) then continue;
          if (inquote) and (RightQuote(lq,c)) then begin
             inquote:=false; continue;
             end;
          if c='(' then inc(nested);
          if c=')' then dec(nested);
          if nested=0 then break;
       end;//for

       if (nested>0) then IsUDF:=false;

       if IsUDF then begin
          nextfield:=copy(ex,1,lastcf);  // lastcf=')'
          tail:='';
          if lastcf<ln then tail:=copy(ex,lastcf+1,ln-lastcf);
          Result:=1; exit;
       end;

       end;//If UDF


       //-1 -2 datafield
       if (IsBreak) and ((c=':') or (c='.')) and ((Letter(cp)) or (ord(cp)>191)
                                                   or (cp='_') or (digit(cp))
                                                  ) then begin
         dlm:=c;
         if (ln>lastcf) then c:=ex[lastcf+1];

         if (ln>lastcf) and ((Letter(c)) or (ord(c)>191) or (c='_') or (digit(c))) then begin
             //by name dataset:field
                IsData:=false;
                lastcf:=lastcf+1;
                IsBreak:=false;
                for f:=lastcf to ln do
                begin
                 c:=ex[f];
                 lastcf:=f;
                 if ((Letter(c)) or (ord(c)>191) or (c='_') or (digit(c)) or (c=#32)) then begin
                                                                           IsData:=true;
                                                                           continue;
                                                                           end;
                 IsBreak:=true; break;
                end;//for

                if IsData then begin
                   tail:='';
                   if IsBreak then begin
                      nextfield:=copy(ex,1,lastcf-1);
                      tail:=copy(ex,lastcf,ln-lastcf+1);
                    end else begin
                      nextfield:=copy(ex,1,lastcf);
                      if lastcf<ln then tail:=copy(ex,lastcf+1,ln-lastcf);
                    end;
                    if dlm=':' then Result:=-2 else Result:=-1;
                    if (eoDotAsColon in Options) and (dlm='.') then begin
                       Result:=-2;
                       p:=pos('.',nextfield);
                       nextfield[p]:=':';
                    end;
                    exit;
                end;//if IsData

         end else begin
             if (ln>lastcf+1) and (c='(') then begin
             //by number dataset:(nnn)
                IsData:=false;
                lastcf:=lastcf+2;

                for f:=lastcf to ln do
                begin
                 c:=ex[f];
                 lastcf:=f;
                 if digit(c) then begin IsData:=true; continue; end;
                 break;
                end;//for

                if c<>')' then IsData:=false;
                if IsData then begin
                    nextfield:=copy(ex,1,lastcf);
                    tail:='';
                    if lastcf<ln then tail:=copy(ex,lastcf+1,ln-lastcf);
                    if dlm=':' then Result:=-2 else Result:=-1;
                    if (eoDotAsColon in Options) and (dlm='.') then begin
                       Result:=-2;
                       p:=pos('.',nextfield);
                       nextfield[p]:=':';
                    end;
                    exit;
                end;//if IsData

             end;//if (ln>lastcf+1)
         end;//if

       end;//if datafield

      end;//if variable -- UDF -- datafield --------------------------

      //-13 expression
      if (ex[1]='(') or (ex[1]='-') or (ex[1]='+') then begin
         Result:=-13; exit;
      end;

     end;//GetNextExprField

    procedure ProcessExpression(var ex, infldoutstr:AnsiString; var infmtvar:TEkFieldFormat);
    var nested,n,f:longint;
        nextfield,nextop, prevop, tail, s, nextex, errpart:AnsiString;
        AllowUnary, IsOperand, PrevIsOperand, completed :boolean;
        c:AnsiChar;
        DirectExpr,InversExpr:TEkExpression;
        MOperation:TEkOperand;
        OpStack:TEkOperationStack;
    begin
       //ln:=length(ex);
       DirectExpr:=TEkExpression.Create;
       InversExpr:=TEkExpression.Create;
       OpStack:=TEkOperationStack.Create;
      try
       s:='';
       nested:=0; nextfield:='';
       nextop:=#32; prevop:=#32;
       tail:=''; nextex:='';
       PrevIsOperand:=false;
       IsOperand:=true;
       AllowUnary:=true;
       n:=GetNextExprField(ex,nextfield,tail);
       //-5, -13
       if n=-5 then raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex);
       if n=-13 then begin
          IsOperand:=false;
          if not GetNextExprOperation(ex,nextop,tail,AllowUnary) then
             raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex);
       end;//if n=-13

       //Operand, unary + -, unary ! (not), "("  expected at the beginning
       if not IsOperand then begin
          if not ( (nextop='u+') or (nextop='u-') or (nextop='!') or (nextop='(') ) then
             raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex);
       end;//if not

        //5,4,3,2,1,0,-1,-2, -5
       //--------------------------->
       errpart:=' - error at the beginning ';
       completed:=false;
       repeat
          if IsOperand then begin
             if PrevIsOperand then begin //cannot be operand after operand
                raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - operation expected');
             end;
             if nextop=')' then begin //cannot be operand after ")"
                raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - operation expected');
             end;
             //store operand
             //s:=s+nextfield+' fldnum='+inttostr(n)+#13;
             s:=s+nextfield;
             DirectExpr.Add(nextfield,true,false,false,false,0,n);

             AllowUnary:=false;

          end else begin

             if (PrevIsOperand) then begin
                if (nextop='!') or (nextop='(') then begin
                  raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - "'+nextop+'" not expected');
                end;
             end;//if

             if not PrevIsOperand then begin
                if (prevop[1] in ['*','/','%','+','-']) then begin
                   if ((nextop='&&') or (nextop='||') or (nextop='<=') or (nextop='=>') or (nextop='<>') or (nextop='!=') ) or
                      (nextop[1] in ['*','/','%','=','<','>','!','+','-']) or
                      (nextop=')') then begin
                       raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - "'+nextop+'" not expected');
                   end;
                end;//if prev */%
                if (prevop='&&') or (prevop='||') then begin
                    if (nextop<>'!') and (nextop<>'(') then begin
                       raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - "'+nextop+'" not expected');
                    end;
                end;
                if (prevop='<') or (prevop='>') or (prevop='=') or (prevop='<=')
                    or (prevop='>=') or (prevop='<>') or (prevop='!=') then begin
                    if (nextop<>'(') and (nextop<>'u+') and (nextop<>'u-') then begin
                       raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - "'+nextop+'" not expected');
                    end;
                end;
                if (prevop='u+') or (prevop='u-') then begin
                   if (nextop<>'(') then begin
                      raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - "'+nextop+'" not expected');
                   end;
                end;
                if (prevop='!')  then begin
                    if (nextop<>'!') and (nextop<>'(') then begin
                       raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - "'+nextop+'" not expected');
                    end;
                end;
                if (prevop='(')  then begin
                    if (nextop<>'u+') and (nextop<>'u-') and (nextop<>'!') and (nextop<>'(') then begin
                       raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - "'+nextop+'" not expected');
                    end;
                end;
                if (prevop=')')  then begin
                    if (nextop='u+') or (nextop='u-') or (nextop='!') or (nextop='(') then begin
                       raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+errpart+s+ ' - "'+nextop+'" not expected');
                    end;
                end;

             end;// If not PrevIsOperand

             //AllowUnary for some operations
             AllowUnary:=false;
             MOperation.Text:=nextop;
             MOperation.IsOperand:=false;
             MOperation.ReqBoolArg:=false;
             MOperation.AllowBoolArg:=false;
             MOperation.RetBoolRes:=false;
             MOperation.Priority:=0;
             MOperation.Fldnum:=0;

             if nextop='&&' then begin
                MOperation.ReqBoolArg:=true;
                MOperation.AllowBoolArg:=true;
                MOperation.RetBoolRes:=true;
                MOperation.Priority:=2;  //7;
             end;
             if nextop='||' then begin
                MOperation.ReqBoolArg:=true;
                MOperation.AllowBoolArg:=true;
                MOperation.RetBoolRes:=true;
                MOperation.Priority:=2;  //7;
             end;
             if nextop='<=' then begin
                MOperation.ReqBoolArg:=false;
                MOperation.AllowBoolArg:=false;
                MOperation.RetBoolRes:=true;
                MOperation.Priority:=4;  //5;
             end;
             if nextop='=>' then begin
                MOperation.ReqBoolArg:=false;
                MOperation.AllowBoolArg:=false;
                MOperation.RetBoolRes:=true;
                MOperation.Priority:=4;  //5;
             end;
             if (nextop='<>') or (nextop='!=') then begin
                MOperation.ReqBoolArg:=false;
                MOperation.AllowBoolArg:=true;
                MOperation.RetBoolRes:=true;
                MOperation.Priority:=3;  //6;
             end;
             if (nextop='u-') or (nextop='u+') then begin
                MOperation.ReqBoolArg:=false;
                MOperation.AllowBoolArg:=false;
                MOperation.RetBoolRes:=false;
                MOperation.Priority:=7;  //2;
             end;

             if length(nextop)=1 then begin

             case nextop[1] of
              '!':begin
                   MOperation.ReqBoolArg:=true;
                   MOperation.AllowBoolArg:=true;
                   MOperation.RetBoolRes:=true;
                   MOperation.Priority:=7;  //2;
                  end;
             '*','/','%':begin
                         MOperation.ReqBoolArg:=false;
                         MOperation.AllowBoolArg:=false;
                         MOperation.RetBoolRes:=false;
                         MOperation.Priority:=6;  //3;
                         AllowUnary:=true;
                         end;
             '+','-':begin
                     MOperation.ReqBoolArg:=false;
                     MOperation.AllowBoolArg:=false;
                     MOperation.RetBoolRes:=false;
                     MOperation.Priority:=5;  //4;
                     AllowUnary:=true;
                     end;
              '(':begin
                  MOperation.ReqBoolArg:=false;
                  MOperation.AllowBoolArg:=false;
                  MOperation.RetBoolRes:=false;
                  MOperation.Priority:=0;
                   inc(nested);
                   AllowUnary:=true;
                  end;
              ')':begin
                  MOperation.ReqBoolArg:=false;
                  MOperation.AllowBoolArg:=false;
                  MOperation.RetBoolRes:=false;
                  MOperation.Priority:=1;
                   dec(nested);
                   if nested<0 then begin
                               raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+' - number of ")" is more than number of "(" brackets');
                               end;
                  end;
              '>':begin
                  MOperation.ReqBoolArg:=false;
                  MOperation.AllowBoolArg:=false;
                  MOperation.RetBoolRes:=true;
                  MOperation.Priority:=4;  //5;
                  AllowUnary:=true;
                  end;
              '<':begin
                  MOperation.ReqBoolArg:=false;
                  MOperation.AllowBoolArg:=false;
                  MOperation.RetBoolRes:=true;
                  MOperation.Priority:=4;  //5;
                  AllowUnary:=true;
                  end;
              '=':begin
                  MOperation.ReqBoolArg:=false;
                  MOperation.AllowBoolArg:=true;
                  MOperation.RetBoolRes:=true;
                  MOperation.Priority:=3;  //6;
                  AllowUnary:=true;
                  end;
             end;//case
             end;//if lenght()=1


             //store operation
             //s:=s+nextop+#13;
             s:=s+nextop;
             DirectExpr.Add(MOperation);

          end;//if IsOperand or Operation;

          errpart:=' - error after ';

          //Get next part of expression
          if length(tail)>0 then begin
             c:=tail[1];
             nextex:=tail;
             PrevIsOperand:=IsOperand;

             if c in ['*', '/', '%', '+', '-', '&', '|', '!', '(', ')','<','>','='] then begin

                    prevop:=nextop;
                    if not GetNextExprOperation(nextex,nextop,tail,AllowUnary) then
                             raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+' - error after '+s);
                    IsOperand:=false;

             end else begin

                    n:=GetNextExprField(nextex,nextfield,tail);
                    if n=-5 then begin
                            raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+' - error after '+s);
                            end;
                    IsOperand:=true;

             end;//if

          end else begin completed:=true; end;//if

       until completed;
       //--------------------------->

       if nested>0 then begin
          raise EIllegalFunctionUse.Create('Cannot process an expression: '+ex+' - ")" expected');
       end;

       //end of expression
       if not ((IsOperand) or ((not IsOperand) and (nextop=')'))) then begin
          raise EIllegalFunctionUse.Create('Unexpected end of expression: '+ex);
       end;


       //showmessage('expression '+s);

       //*** invert expression

       for f:=0 to DirectExpr.Count-1 do begin
           MOperation:=DirectExpr.Operand[f];
           if MOperation.IsOperand then begin
              InversExpr.Add(MOperation);
           end else begin
               if (OpStack.Count>0) and (MOperation.Text=')') and (OpStack.Operation[OpStack.Count-1].Text='(') then
               begin //prevent empty brackets () from being stored in stack
                    OpStack.Pop;
                    continue;
               end;
               if (MOperation.Priority=0)
                  or ((OpStack.Count>0) and (MOperation.Priority > OpStack.Operation[OpStack.Count-1].Priority))
                  or (OpStack.Count=0) then begin
                     OpStack.Push(MOperation);
               end else begin
                     while (OpStack.Count>0) and
                          (OpStack.Operation[OpStack.Count-1].Priority >= MOperation.Priority) do begin
                       InversExpr.Add(OpStack.Pop);
                     end;//while
                     if (OpStack.Count>0) and (OpStack.Operation[OpStack.Count-1].Text='(') then OpStack.Pop;
                     if MOperation.Text<>')' then OpStack.Push(MOperation);
               end;//if
           end;//if
       end;//for

       while OpStack.Count>0 do begin InversExpr.Add(OpStack.Pop); end;
       if InversExpr.Operand[InversExpr.Count-1].IsOperand then begin
          raise EIllegalFunctionUse.Create('Operation or function name missed in expression: '+ex+', operand: '+InversExpr.Operand[InversExpr.Count-1].Text);
       end;

       //debug
       s:='';
       for f:=0 to InversExpr.Count-1 do s:=s+InversExpr.Operand[f].Text+#13;
       //showmessage(s);
       //debug

       //*** end invert expression


      finally
       OpStack.Free;
       DirectExpr.Free;
       InversExpr.Free;
      end;//try
    end;//ProcessExpression;

     function fldnum(var tst:AnsiString; var fformat:TEkFieldFormat):integer;
     var tst1,nextfield, tail:AnsiString;
     begin
       tst1:=UpperCase(tst);
       if (copy(tst1,1,5)='SCAN(')  and (pos(')',tst1)>5) then begin Result:=-3;  exit; end;
       if copy(tst1,1,9)='SCANENTRY' then begin Result:=-11; exit; end;
       if copy(tst1,1,10)='SCANFOOTER' then begin Result:=-12; exit; end;
       if copy(tst1,1,7)='ENDSCAN' then begin Result:=-4; exit; end;
       if (copy(tst1,1,3)='IF(')  and (pos(')',tst1)>4) then begin Result:=-23;  exit; end;
       if copy(tst1,1,5)='ENDIF' then begin Result:=-24; exit; end;
       if copy(tst1,1,4)='ELSE' then begin Result:=-25; exit; end;

       fformat:=CheckFormat(tst); //Remove format function if present

       tst:=trim(tst); nextfield:=''; tail:='';
       Result:=GetNextExprField(tst,nextfield, tail);

       if (length(tail)>0) and (Result<>-5) then Result:=-13;
       if (Result<>-5) and (Result<>-13) then begin tst:=nextfield; end;

     end; //function fldnum

procedure WritePictureWMF(var b1:TPicture;var fmt:TEkFieldFormat);
 var
            m: tmetafile;
           mc: tmetafileCanvas;
          Buf: Pointer;
          Lnt: UINT;
            s: AnsiString;
        xw,yh: word;
     xtw, ytw:Longint;
  ImageFormat,OriginalImageFormat: TEkImageFormat;
         Rect:TRect;
          ppi:integer;

   RefDC:HDC;
   DblBuf, Buf1, Buf2:Pointer;
   b2:byte;
   s2:String[2];


    procedure MakeRTFString(m:tmetafile; kx,ky:Double); //WMF
    var CurrentColorString:AnsiString;
        CurrentColorNumber:longint;
    begin

    if (b1.graphic is TMetafile) and (b1.Metafile.Enhanced=false) then
     begin
     xw:=round(b1.Width*96/ppi); yh:=round(b1.Height*96/ppi);
     end else begin xw:=b1.Width; yh:=b1.Height; end;

     ImageFormat:=TEkImageFormat.create(xw,yh);
     OriginalImageFormat:=ImageFormat;

     If Assigned(FOnImageFormat) then FOnImageFormat(Fmt.ImgFmt,ImageFormat);
     If ImageFormat.Border.ColorIndex>ColorCount-1 then ImageFormat.SetBorderType(Imageformat.Border.BrType,imageformat.border.Width,0);

         m.mmwidth:=round(ImageFormat.SizeXmm*100);
         m.mmheight:=round(ImageFormat.SizeYmm*100);

         xtw:=round(ImageFormat.SizeX*26.4596930676*kx);
         ytw:=round(ImageFormat.SizeY*26.4596930676*ky);

     s:='{\pict\picscalex'+trim(inttostr(100))+
              '\picscaley'+trim(inttostr(100))
             +'\piccropl0\piccropr0\piccropt0\piccropb0'+
        '\picw'+trim(inttostr(xtw))+'\pich'+trim(inttostr(ytw))
       +'\wmetafile8';

     case ImageFormat.Border.BrType of
        brSingle: s:=s+'\brdrs';
        brDouble: s:=s+'\brdrdb';
        brThick : s:=s+'\brdrth';
        brShadow: s:=s+'\brdrsh';
        brDot   : s:=s+'\brdrdot';
        brHair  : s:=s+'\brdrhair';
     end;

    //find real color number, add if necessary
    CurrentColorString:='\red'+inttostr(ColorTable[ImageFormat.Border.ColorIndex].r)
                     +'\green'+inttostr(ColorTable[ImageFormat.Border.ColorIndex].g)
                      +'\blue'+inttostr(ColorTable[ImageFormat.Border.ColorIndex].b)+';';
    CurrentColorNumber:=RTFColor.UseColor(CurrentColorString);

        s:=s+'\brdrw'+trim(inttostr(ImageFormat.BorderTwips))+
             '\brdrcf'+trim(inttostr(CurrentColorNumber));


     OriginalImageFormat.Free;
   end;//MakeRTFString;

  procedure WriteGraphicBitsWMF;
  var i:integer;
  begin
      if eoGraphicsBinary in Options then
         begin      //Save graphic binary
          s:='\bin'+trim(inttostr(Lnt))+' ';
          Outf.WriteBuffer(Pointer(s)^,length(s));
          Outf.WriteBuffer(Buf^, Lnt);
          s:=#13+'}';
          Outf.WriteBuffer(Pointer(s)^,length(s));
         end else
             begin  //Save as a hex
               GetMem(DblBuf,Lnt*2); Buf1:=Buf; Buf2:=DblBuf;
                 For i:=0 to Lnt-1 do
                 begin
                      b2:=PByte(Buf1)^;
                      s2:=inttohex(b2,2);
                      PByte(Buf2)^:=Byte(s2[1]);
                      inc(PByte(Buf2));
                      PByte(Buf2)^:=Byte(s2[2]);
                      inc(PByte(Buf1));
                      inc(PByte(Buf2));
                 end;
               s:=' '; Outf.WriteBuffer(Pointer(s)^,length(s));
               Outf.WriteBuffer(DblBuf^, Lnt*2);
               s:=#13+'}';
               Outf.WriteBuffer(Pointer(s)^,length(s));

               FreeMem(DblBuf, Lnt*2);
             end; {if binary or hex}
  end; {proc WriteGraphicBitsWMF;}

 Begin {proc WritePictureWmf}
 ppi:=Screen.PixelsPerInch;
 //-------Bitmap and JPEG------------------
 //if not (b1.Graphic is TMetafile) then
 if b1.Graphic.Empty then
 begin
    exit;
 end else
     begin
     m:=TMetaFile.create;
     m.Enhanced:=true;

     m.height:=round(b1.graphic.height*ppi/96);
     m.width:=round(b1.graphic.width*ppi/96);

     Rect.Left:=0; Rect.Top:=0;
     Rect.Right:=m.width-1;
     Rect.Bottom:=m.height-1;

     mc:=TMetafileCanvas.Create(m,0);
     if ppi=96 then  mc.Draw(0,0,b1.graphic) else mc.StretchDraw(Rect,b1.graphic);
     mc.free;

     s:='';
     MakeRTFString(m,1,1); //Make s='{\pict' and so on ...
     Outf.WriteBuffer(Pointer(s)^,length(s));

      RefDC:=GetDC(0);
      Lnt:=GetWinMetaFileBits(m.handle,0,nil,MM_ANISOTROPIC,RefDC);
      GetMem(Buf,Lnt);
      GetWinMetaFileBits(m.handle,Lnt,Buf,MM_ANISOTROPIC,RefDC);

      WriteGraphicBitsWMF;

       FreeMem(Buf, Lnt);
       ReleaseDC(0,RefDc);

     m.free;
     exit;
 end;

 end;{proc WritePictureWmf}


 procedure WritePicture(var b1:TPicture;var fmt:TEkFieldFormat);
 var
            m: tmetafile;
           mc: tmetafileCanvas;
          Buf: Pointer;
          Lnt: Longint;
            s: AnsiString;
        xw,yh: word;
     xtw, ytw:Longint;
  ImageFormat,OriginalImageFormat: TEkImageFormat;
        Rect:Trect;
        ppi:Longint;

    procedure MakeRTFString(m:tmetafile; kx,ky:Double); //EMF
    var CurrentColorString:AnsiString;
        CurrentColorNumber:longint;
    begin

    if (b1.graphic is TMetafile) and (b1.Metafile.Enhanced=false) then
     begin
     xw:=round(b1.Width*96/ppi); yh:=round(b1.Height*96/ppi);
     end else begin xw:=b1.Width; yh:=b1.Height; end;

     ImageFormat:=TEkImageFormat.create(xw,yh);

     OriginalImageFormat:=ImageFormat;

     If Assigned(FOnImageFormat) then FOnImageFormat(Fmt.ImgFmt,ImageFormat);
     If ImageFormat.Border.ColorIndex>ColorCount-1 then ImageFormat.SetBorderType(Imageformat.Border.BrType,imageformat.border.Width,0);

         m.mmwidth:=round(ImageFormat.SizeXmm*100);
         m.mmheight:=round(ImageFormat.SizeYmm*100);

         xtw:=round(5669*ImageFormat.SizeXmm/100);
         ytw:=round(5669*ImageFormat.SizeYmm/100);

     s:='{\pict\picscalex'+trim(inttostr(ImageFormat.ScaleX))+
              '\picscaley'+trim(inttostr(ImageFormat.ScaleY))
             +'\piccropl0\piccropr0\piccropt0\piccropb0'+
        '\picw'+trim(inttostr(xtw))+'\pich'+trim(inttostr(ytw))
       +'\emfblip';

     case ImageFormat.Border.BrType of
        brSingle: s:=s+'\brdrs';
        brDouble: s:=s+'\brdrdb';
        brThick : s:=s+'\brdrth';
        brShadow: s:=s+'\brdrsh';
        brDot   : s:=s+'\brdrdot';
        brHair  : s:=s+'\brdrhair';
     end;

    //find real color number, add if necessary
    CurrentColorString:='\red'+inttostr(ColorTable[ImageFormat.Border.ColorIndex].r)
                     +'\green'+inttostr(ColorTable[ImageFormat.Border.ColorIndex].g)
                      +'\blue'+inttostr(ColorTable[ImageFormat.Border.ColorIndex].b)+';';
    CurrentColorNumber:=RTFColor.UseColor(CurrentColorString);

        s:=s+'\brdrw'+trim(inttostr(ImageFormat.BorderTwips))+
             '\brdrcf'+trim(inttostr(CurrentColorNumber));

     OriginalImageFormat.Free;
   end;//MakeRTFString;

   procedure WriteGraphicBits;
   var DblBuf,Buf1,Buf2:Pointer;
       i:integer;
       b2:byte;
       s2:String[2];
   begin
     if not (eoGraphicsBinary in Options) then
      begin //write hexadecimal
               GetMem(DblBuf,Lnt*2); Buf1:=Buf; Buf2:=DblBuf;
                 For i:=0 to Lnt-1 do
                 begin
                      b2:=PByte(Buf1)^;
                      s2:=inttohex(b2,2);
                      PByte(Buf2)^:=Byte(s2[1]);
                      inc(PByte(Buf2));
                      PByte(Buf2)^:=Byte(s2[2]);
                      inc(PByte(Buf1));
                      inc(PByte(Buf2));
                 end;
               s:=' '; Outf.WriteBuffer(Pointer(s)^,length(s));
               Outf.WriteBuffer(DblBuf^, Lnt*2);
               s:=#13+'}';
               Outf.WriteBuffer(Pointer(s)^,length(s));

                       FreeMem(DblBuf, Lnt*2);


      end else begin //write binary
               s:='\bin'+trim(inttostr(Lnt))+' ';
               Outf.WriteBuffer(Pointer(s)^,length(s));
               Outf.WriteBuffer(Buf^, Lnt);
               s:=#13+'}';
               Outf.WriteBuffer(Pointer(s)^,length(s));
               end;{if}
   end;{WriteGraphicBits}

 begin
  ppi:=Screen.PixelsPerInch;
 //-------Bitmap and JPEG------------------
 //if not (b1.Graphic is TMetafile) then
 if b1.Graphic.Empty then
 begin
    exit;
 end else
     begin

     m:=TMetaFile.create;
     m.Enhanced:=true;

     if (b1.graphic is TMetafile) and (b1.Metafile.Enhanced=false) then
     begin
     m.height:=b1.graphic.height;
     m.width:=b1.graphic.width;
     end else begin
     m.height:=round(b1.graphic.height*ppi/96);
     m.width:=round(b1.graphic.width*ppi/96);
              end;

     Rect.Left:=0; Rect.Top:=0;
     Rect.Right:=m.width-1;
     Rect.Bottom:=m.height-1;
     mc:=TMetafileCanvas.Create(m,0);
     if ppi=96 then  mc.Draw(0,0,b1.graphic) else mc.StretchDraw(Rect,b1.graphic);
     mc.free;

     s:='';
     MakeRTFString(m,1,1); //Make s='{\pict' and so on ...
     Outf.WriteBuffer(Pointer(s)^,length(s));

     Lnt := GetEnhMetaFileBits(m.handle, 0, nil);
     GetMem(Buf, Lnt);
     try
        GetEnhMetaFileBits(m.handle, Lnt, Buf);
        WriteGraphicBits;
     finally
        FreeMem(Buf, Lnt);
     end;
     m.free;
     exit;
 end;

 end;{proc WritePicture}

 procedure WriteGraphicVarRTF(var s:AnsiString; var fmt:TEkFieldFormat; var soutrtf:AnsiString);
 var b1:TPicture;
 begin
 b1:=TPicture.Create;
 try b1.LoadFromFile(s); except
                        //if not File loaded
                        s:=txt2rtf('#Can''t load file '+s)+soutrtf;
                        Outf.WriteBuffer(Pointer(s)^,length(s));
                        b1.free; exit;
                        end;
  if eoGraphicsWmfCompatible in Options then
                  WritePictureWmf(b1,fmt) else WritePicture(b1,fmt);
  b1.free;
  Outf.WriteBuffer(Pointer(soutrtf)^,length(soutrtf));
 end;{proc WriteGraphicVarRTF}

 procedure WriteGraphicRTF(Fld:TField;var fmt:TEkFieldFormat; var soutrtf:AnsiString);
 var b1: TPicture;
     bfld: TBlobField;
     s: String[20];
     Photo: TJPEGImage;
     MS1:TStringStream;
 begin
  b1:=TPicture.create;

  bfld:=Fld as TBlobField;
  Photo:=nil; MS1:=nil;
  s:=copy(bfld.AsString{.Value},1,20);

      if (Pos('GIF8',s)>0) or (Pos('JFIF',s)>0) then begin
        try
          Photo := TJPEGImage.Create;
          MS1 := TStringStream.Create(bfld.AsString);
          Photo.LoadFromStream(MS1);
          b1.Assign(Photo);
        finally
          if Assigned(Photo) then Photo.Free;
          if Assigned(MS1) then MS1.Free;
        end;//try
      end else b1.Assign(bfld);//if

      if Assigned(b1.graphic) then begin
         if eoGraphicsWmfCompatible in Options then
                 WritePictureWmf(b1,fmt) else WritePicture(b1,fmt);
      end;

  b1.free;
  Outf.WriteBuffer(Pointer(soutrtf)^,length(soutrtf));
 end;//proc WriteGraphicRTF

 procedure WriteLink(s:AnsiString; var soutrtf:AnsiString);
 var url, name:AnsiString;
     d:integer;
 begin
  url:=''; name:='';
  d:=pos('|',s);
  if d=0 then url:=s;
  if d>1 then begin url:=copy(s,1,d-1); name:=copy(s,d+1,length(s)-d); end;
  if length(name)=0 then name:=url;

  wr('{\field{\*\fldinst {'+'\lang'+DefLang+' HYPERLINK "'+txt2rtf(url)+'" }}'
     +'{\fldrslt '+'\lang'+DefLang+' '+txt2rtf(name)+'}}'+soutrtf);
 end;

 procedure MakeFloatString(var s:AnsiString; fmt:TEkFieldFormat);
 var n:Extended;
     isconv:boolean;
     pdc:longint;
 begin
 if Length(Trim(s))>0 then
 begin
    try n:=StrToFloat(s); isconv:=true; except isconv:=false; n:=0; end;
    if isconv then begin
       s:=Trim(FloatToStrF(n, EkBaseFormatsArr[fmt.fmtnumber].floatformat ,fmt.precision, fmt.decimals));
        if (ZeroOut(s)) and (eoNumericFormatClearZero in Options) then begin
           s:=''; end else
        begin
         if (fmt.fmtnumber=7) or (fmt.fmtnumber=8) then
         begin
          pdc:=pos(FormatSettings.DecimalSeparator,s);
          if pdc=0 then s:=s+DecimalRTerminator else
                 begin
                 s[pdc]:=DecimalRSeparator;
                   if (pdc<length(s)) and (strtoint(copy(s,pdc+1,length(s)-pdc))=0) then
                   begin
                   s:=copy(s,1,pdc);
                   s[pdc]:=DecimalRTerminator;
                   end;
                 end;
         end;//if 7,8
        end;

    end;//if isconv

 end;//if length>0
 end;// MakeFloatString

 // running
 procedure WriteVarRTF(var s:AnsiString; var fmt:TEkFieldFormat; var soutrtf:AnsiString);
 var dfs,dfsvar:AnsiString;
 begin
   if EkBaseFormatsArr[fmt.fmtnumber].isfloat then
     begin //1..4, 7,8
         MakeFloatString(s,fmt);
         wr('\lang'+DefLang+' '+txt2rtf(s)+soutrtf);

     end else begin
         case fmt.fmtnumber of
           0: begin
              wr('\lang'+DefLang+' '+txt2rtf(s)+soutrtf);
              end;
           5: WriteGraphicVarRTF(s,fmt,soutrtf); //fimg
           6: WriteLink(s,soutrtf); //flnk
           9: begin
              dfsvar:=Trim(CmGetString(fmt.NDtStr));
              if length(dfsvar)>0 then begin
                                        if IsQuoted(dfsvar) then dfs:=copy(dfsvar,2,length(dfsvar)-2)
                                                            else dfs:=VarByName(dfsvar).AsString;
                                       end else dfs:='';
              s:=FormatDateTime(dfs,StrToDateTime(s));
              wr('\lang'+DefLang+' '+txt2rtf(s)+soutrtf);
              end;
          10: begin //fbool
                 if (s=TrueValue)or(UpperCase(s)='TRUE') then begin
                    wr('\lang'+DefLang+' '+txt2rtf(TrueValue)+soutrtf);
                   end else begin
                    wr('\lang'+DefLang+' '+txt2rtf(FalseValue)+soutrtf);
                 end;//if
              end;//10
          11: begin //frtf
                InsertRTFMemoPar(Self,Outf,s);
                Outf.WriteBuffer(Pointer(soutrtf)^,length(soutrtf));
              end;//11

         else begin
              raise EIllegalFunctionUse.create('Unknown format function '+EkBaseFormatsArr[fmt.fmtnumber].name);
              end;
         end;//case
      end;//if
 end;//proc WriteVarRTF

 function GetFieldString(Fld:TField;fmt:TEkFieldFormat):AnsiString;
 var s,dfs,dfsvar:AnsiString;
     p:longint;
 begin

   case Fld.DataType of
   ftBoolean:begin
             if Fld.AsBoolean then s:=TrueValue else s:=FalseValue;
             end;
   //Unformatted Dates returned without time by default
    ftDate,ftDateTime:begin
                        if fmt.fmtnumber=9 then
                        begin
                           dfsvar:=CmGetString(fmt.NDtStr);
                           if length(Trim(dfsvar))>0 then begin
                                                            if IsQuoted(dfsvar) then dfs:=copy(dfsvar,2,length(dfsvar)-2)
                                                                                else dfs:=VarByName(dfsvar).AsString;
                                                          end else dfs:='';
                           s:=FormatDateTime(dfs,Fld.AsDateTime);
                        end else begin
                                  s:=Fld.AsString;
                                  p:=pos(#32,s);
                                  if (p>8) then s:=copy(s,1,p-1);
                                 end;
                      end;//ftDate
   else begin //case
        s:=TrimRight(Fld.AsString);
        if EkBaseFormatsArr[fmt.fmtnumber].isfloat then
        begin //1..4, 7,8
           MakeFloatString(s,fmt);

        end else begin
                 case fmt.fmtnumber  of
                 0:begin {nothing to do} end;
                 9:begin  //fdtm
                    dfsvar:=CmGetString(fmt.NDtStr);
                    if length(Trim(dfsvar))>0 then begin
                                                    if IsQuoted(dfsvar) then dfs:=copy(dfsvar,2,length(dfsvar)-2)
                                                                        else dfs:=VarByName(dfsvar).AsString;
                                                   end else dfs:='';
                    s:=FormatDateTime(dfs,StrToDateTime(s));
                 end;//9
                10:begin //fbool
                       if (s=TrueValue)or(UpperCase(s)='TRUE') then begin
                              s:=TrueValue;
                           end else begin
                              s:=FalseValue;
                       end;//if
                   end;//10

                 else begin raise EIllegalFunctionUse.create('Unknown format function '+EkBaseFormatsArr[fmt.fmtnumber].name); end;
                 end;//case
        end;//if

        end;//else case
   end;//case
   Result:=s;
 end;//function GetFieldString

 //running
 procedure WriteFieldRTF(Fld:TField;var fmt:TEkFieldFormat; var soutrtf:AnsiString);
 var MS1:TStream;
 begin
   //if FIMG or ftgraphic
   if (fmt.fmtnumber=5) or (fld.datatype=ftgraphic) then
   begin
      if fmt.fmtnumber<>5 then begin fmt.fmtnumber:=5; fmt.ImgFmt:=0; end;
      WriteGraphicRTF(Fld,fmt,soutrtf);
   end else
       case fmt.fmtnumber of
  0..4,7..10:wr('\lang'+DefLang+' '+txt2rtf( GetFieldString(Fld,fmt) )+soutrtf);
          6:WriteLink(Fld.AsString,soutrtf);
         11:begin
            MS1:=TStringStream.Create(Fld.AsString);
             try
              InsertRTFMemoStreamPar(Self,Outf,MS1);
              Outf.WriteBuffer(Pointer(soutrtf)^,length(soutrtf));
             finally
              MS1.Free;
             end;
            end;//11
       else begin //case
            raise EIllegalFunctionUse.create('Unknown format function '+EkBaseFormatsArr[fmt.fmtnumber].name);
            end;
       end;//case
 end;//WriteFieldRTF


   //------------------------------------------------------------------
  function ProcessVar(var infldname, infldoutstr, intestf:AnsiString; var infmtvar:TEkFieldFormat):TEkRowContent; //compiling Save var to CmStream
  begin
    With Result do begin
         fmt:=infmtvar;
         DAlias:='';
         stestf:='\\'+intestf+'\\';
         Field:=infldname;
         NField:=-1; //Number in VarList not defined
         sout:=infldoutstr;
         ftype:=rcSimple;
         DefinedType:=rcSimple;
         Defined:=false;
    end;//with
  end;//ProcessVar

  function ProcessConst(n:longint; var infldname, infldoutstr, intestf:AnsiString; var infmtvar:TEkFieldFormat):TEkRowContent; //compiling Save var to CmStream
  begin
    With Result do begin
         fmt:=infmtvar;
         DAlias:='';
         stestf:='\\'+intestf+'\\';

         if n=3 then begin //quoted AnsiString
             Field:=copy(infldname,2,length(infldname)-2); //This is the value without quotes
         end else begin
             Field:=infldname;
         end;

         NField:=-1; //Number in VarList not defined
         sout:=infldoutstr;
         ftype:=rcSimple;
         DefinedType:=rcSimple;
         Defined:=false;
    end;//with
  end;//ProcessConst

  //Define FieldContent for saving it to CmStream:
  function ProcessField(id:longint; var infldname, infldoutstr, intestf:AnsiString; var infmtvar:TEkFieldFormat):TEkRowContent;
  var RCont:TEkRowContent;
      dlm:AnsiChar;
      p:longint;
  begin
         if (id=-9) or (id=-2) then dlm:=':' else dlm:='.';
         RCont.fmt:=infmtvar;
         p:=pos(dlm,infldname);
         if p=2 then RCont.DAlias:=infldname[1]
                    else RCont.DAlias:=UpperCase(copy(infldname,1,p-1));
         RCont.stestf:='\\'+intestf+'\\';
         RCont.Field:=copy(infldname,p+1,length(infldname)-p);
         RCont.NField:=-1;
         RCont.sout:=infldoutstr;
         RCont.ftype:=rcSimple;
         RCont.DefinedType:=rcSimple;
         RCont.Defined:=false;
         Result:=RCont;
  end;//func ProcessField

  //Define UDF Begin Expression FieldContent for saving it to CmStream:
  function ProcessUDFExprBegin(udfnumber:longint; var infldname, infldoutstr:AnsiString; var infmtvar:TEkFieldFormat):TEkRowContent;
  var RCont:TEkRowContent;
  begin
         RCont.fmt:=infmtvar;
         RCont.DAlias:='';
         RCont.stestf:='';
         RCont.Field:=infldname;
         RCont.NField:=udfnumber;
         RCont.sout:=infldoutstr;
         RCont.ftype:=rcData;
         RCont.DefinedType:=rcData;
         RCont.Defined:=true;
         Result:=RCont;
  end;//func ProcessUDFExprBegin

 //This function saves udfargs to stream as field or variable.
 //Item of list may be nested UDF. In this case sign of its
 //execution is written after its arguments.
 //Procedure calls itself recursively.

 procedure ProcessUDFArgs(udfnumber:longint; udfargs:TStringList);
 var f,i,newnumber:longint;
     fmt:TEkFieldFormat;
     s,s2:AnsiString;
     newargs:TStringList;
 begin
   for f:=0 to udfargs.count-1 do
   begin
      s:=udfargs[f];
      i:=fldnum(s,fmt);
      //format cannot be there
      if fmt.fmtnumber>0 then raise EIllegalFunctionUse.create('Illegal function use: expression '+s+' has format function '+EkBaseFormatsArr[fmt.fmtnumber].name+', which is not allowed within another expression');
       case i of
       -13:begin
               //***!!! ProcessExpression
              raise exception.Create('Capability not supported: '+s);
           end;
       -2,-1:begin //data field as parameter
             s2:='';
             CmSaveField(i,ProcessField(i,s,s2,s2,fmt));
             end;
        0:begin  //variable as parameter (or keyword NoReset)
             s2:='';
             CmSaveField(0,ProcessVar(s,s2,s2,fmt));
          end;
        1:begin //UDF as parameter
             newargs:=TStringList.Create;
             try
               if not ProcessUDFName(s,newargs,newnumber) then raise EIllegalFunctionUse.create('Function not found: '+s);
               ProcessUDFArgs(newnumber,newargs);
             finally
               if Assigned(newargs) then newargs.free;
             end;//try
          end;//1

         2,3,4,5: begin //const
             s2:='';
             CmSaveField(i,ProcessConst(i,s,s2,s2,fmt));
            end;//2
       else
          //invalid argument
          raise EIllegalFunctionUse.create('Cannot use '+s+' as argument for another expression');
       end;//case

   end;//for;

   CmSaveExecuteUDFItem(udfnumber,udfargs.count);

 end;//ProcessUDFArgs

 procedure ProcessUDF(var infldname, infldoutstr:AnsiString; var infmtvar:TEkFieldFormat);
 const InDocumentTrue=True;
       IsManageFalse=False;
 var Args:TStringList;
     udfnumber:longint;
 begin
    Args:=TStringList.Create;
    try
     if not ProcessUDFName(infldname,Args,udfnumber) then begin //udf not found
        if (eoClearMissedFields in Options) then CmSaveRawItem(infldoutstr) else CmSaveBlocItem;
        exit;// exit to finally section
      end;
     //check if format is correct
     if not CheckUDFformat(udfnumber,infmtvar) then
               raise EIllegalFunctionUse.create('Format function '+EkBaseFormatsArr[infmtvar.fmtnumber].name+' doesn''t conform to it''s expression: '+infldname);

     //SaveExprBegin
     CmSaveExprBeginItem(ProcessUDFExprBegin(udfnumber, infldname, infldoutstr, infmtvar),InDocumentTrue,IsManageFalse,Scs.CurrentScanNum);
     ProcessUDFArgs(udfnumber,Args);
     CmSaveExprEndItem;

    finally
     Args.free;
    end;//try

 end;//ProcessUDF


  procedure OutUDF; //running
  var InDocument, IsManage:boolean;
      RContExpr,RCont:TEkRowContent;
      MyCreated:array of TObject;
      MyCount,ScanNum:word;

      ArgStack,ArgStackNested:TEkUDFArgs;
      NestedResult:TObject;
      ArgStackCount,ArgStackPos:longint;
      i,f,udfnumber,parcount, rtype:longint;
      s:AnsiString;

      procedure AddToMy(Obj:TObject);
      begin
          inc(MyCount);
          SetLength(MyCreated,MyCount);
          MyCreated[MyCount-1]:=Obj;
      end;

  begin//OutUDF
     ArgStackPos:=-1;
     ArgStackCount:=0;
     SetLength(ArgStack,0);
     SetLength(ArgStackNested,0);
     MyCount:=0;
     SetLength(MyCreated,0);

     InDocument:=false; ScanNum:=0;
     CmReadExprBeginItem(RContExpr,InDocument,IsManage,ScanNum);
     Scs.SetCurrentScan(ScanNum);//even if ScanNum=0
     try
      repeat
       CmReadItemInfo;
       i:=CmLastId;
       case i of
       -2,-1:begin

              CmReadField(RCont);
              if not RCont.Defined then
              begin
                 DefineFieldNumber(DFiles,RCont);
                 RCont.Defined:=true;
                 //Save changes
                 CmStream.Seek(CmPos,sofrombeginning);
                 CmUpdateField(RCont.NField,RCont.DefinedType,RCont.defined);
              end;

              if RCont.DefinedType=rcData then
              begin //data field
                 inc(ArgStackPos);
                 if ArgStackCount<(ArgStackPos+1) then begin
                    inc(ArgStackCount);
                    SetLength(ArgStack,ArgStackCount);
                 end;
                 //Store TField in the stack
                 ArgStack[ArgStackPos]:=DFiles[CToN(RCont.DAlias)].Fields[RCont.NField];
              end else begin
                       raise EIllegalFunctionUse.Create('Illegal function use: '+RContExpr.Field+' - dataset field '+RCont.field+' not found');
                       end;//if rcData
             end;//-2,-1

           0:begin
              CmReadField(RCont);
              //Here we don't check if variable exists
              inc(ArgStackPos);
              if ArgStackCount<(ArgStackPos+1) then begin
                  inc(ArgStackCount);
                  SetLength(ArgStack,ArgStackCount);
              end;
              ArgStack[ArgStackPos]:=TEkReportVariable.create(Self);
              TEkReportVariable(ArgStack[ArgStackPos]).SetVarName(RCont.Field);
              AddToMy(ArgStack[ArgStackPos]);

             end;//0

          2,3,4,5:begin //const //***!!!
              CmReadField(RCont);
              inc(ArgStackPos);
              if ArgStackCount<(ArgStackPos+1) then begin
                  inc(ArgStackCount);
                  SetLength(ArgStack,ArgStackCount);
              end;
              ArgStack[ArgStackPos]:=TEkReportVariable.create(Self);
              //name is ''
              TEkReportVariable(ArgStack[ArgStackPos]).local:=true;
              if i=5 then
                        TEkReportVariable(ArgStack[ArgStackPos]).AsString:=DateConstToStr(RCont.Field)
                     else
                        TEkReportVariable(ArgStack[ArgStackPos]).AsString:=RCont.Field;
              AddToMy(ArgStack[ArgStackPos]);

            end;//2

          -14:begin
                CmReadExprEndItem;
              end;

          -15:begin
              CmReadExecuteUDFItem(udfnumber,parcount);
              SetLength(ArgStackNested,parcount);
              //fill in arguments to call nested function
               for f:=parcount-1 downto 0 do ArgStackNested[f]:=ArgStack[ArgStackPos-parcount+f+1];

               NestedResult:=nil;
               rtype:=GetUDFResultType(udfnumber);
               case rtype of
                 0:begin end; //nil - nothing to do
                 1:begin //report variable
                    NestedResult:=TEkReportVariable.create(Self);
                    TEkReportVariable(NestedResult).local:=true;
                    AddToMy(NestedResult);
                   end;
                 2:begin//TPicture
                    NestedResult:=TPicture.create;
                    AddToMy(NestedResult);
                   end;
                 3:begin//udfrTMemoryStream
                    NestedResult:=TMemoryStream.Create;
                    AddToMy(NestedResult);
                   end;
                 else begin
                      raise EIllegalFunctionUse.Create('Result type defined in function'+UDFList.Functions[udfnumber].name+' is not supported');
                      end;
               end;//case

                 if (udfnumber>-4) and (udfnumber<0) and (parcount=3)  //only SUM, CTN, CTS
                    and (UpperCase(Trim(TEkReportVariable(ArgStackNested[2]).name))='NORESET')
                 then begin  //if scan function
                      TEkReportVariable(ArgStackNested[2]).local:=true;
                      TEkReportVariable(ArgStackNested[2]).AsBoolean:=false;
                 end;

               ExecUDF(udfnumber,ArgStackNested,parcount,NestedResult,RContExpr.Field);

               //Decrease mainstack pos
               ArgStackNested:=nil;
               ArgStackPos:=ArgStackPos-parcount;

               //push the nested result
               inc(ArgStackPos);
               if ArgStackCount<(ArgStackPos+1) then begin
                  inc(ArgStackCount);
                  SetLength(ArgStack,ArgStackCount);
                 end;
               ArgStack[ArgStackPos]:=NestedResult;

             end;//-15

       else begin
            if CmLastId<>-14 then raise EIOError.Create('Undefined argument in UDF');
            //CmStream.Seek(CmSkip,sofromcurrent);
            end;
       end;//case

     until CmLastId=-14;

     //Here we have executed te main UDF
     //nestedresult=ArgStack[0]
     //Write it to RTF file

    if InDocument then begin
     rtype:=GetUDFResultType(udfnumber);
     case rtype of
        0:begin//nil - nothing to write
            wr(RContExpr.sout);
          end;
        1:begin //report variable
           s:=TEkReportVariable(NestedResult).AsString;
           WriteVarRTF(s, RContExpr.fmt, RContExpr.sout);
          end;
        2:begin//TPicture
             if eoGraphicsWmfCompatible in Options then
                             WritePictureWmf(TPicture(NestedResult),RContExpr.fmt) else WritePicture(TPicture(NestedResult),RContExpr.fmt);
                Outf.WriteBuffer(Pointer(RContExpr.sout)^,length(RContExpr.sout));
          end;//2
        3:begin   //udfrTMemoryStream
           TMemoryStream(NestedResult).Seek(0,sofrombeginning);
           if TMemoryStream(NestedResult).size>0 then Outf.CopyFrom(TMemoryStream(NestedResult),0);
           wr(RContExpr.sout);
          end;
     end;//case
    end;//if in document

    if IsManage then begin  //If this is scanwhile UDF
       with NestedResult as TEkReportVariable do ManageResult:=AsBoolean;
    end;

    finally
       for f:=0 to MyCount-1 do MyCreated[f].Free;
       ArgStack:=nil;
       ArgStackNested:=nil;
       MyCreated:=nil;
    end;//try

  end;//OutUDF;

 procedure InitSkipUDF;//---called from SkipScanBlock ------------
  var InDocument, IsManage:boolean;
      RContExpr,RCont:TEkRowContent;
      MyCreated:array of TObject;
      MyCount,ScanNum:word;

      ArgStack,ArgStackNested:TEkUDFArgs;
      ArgStackCount,ArgStackPos:longint;
      f,udfnumber,parcount:longint;

      procedure AddToMy(Obj:TObject);
      begin
          inc(MyCount);
          SetLength(MyCreated,MyCount);
          MyCreated[MyCount-1]:=Obj;
      end;

  begin//InitSkipUDF
     ArgStackPos:=-1;
     ArgStackCount:=0;
     SetLength(ArgStack,0);
     SetLength(ArgStackNested,0);
     MyCount:=0;
     SetLength(MyCreated,0);

     InDocument:=false; ScanNum:=0;
     CmReadExprBeginItem(RContExpr,InDocument,IsManage,ScanNum);
     Scs.SetCurrentScan(ScanNum);
     try
      repeat
       CmReadItemInfo;
       case CmLastId of
       -2,-1:begin
              CmReadField(RCont);
                 inc(ArgStackPos);
                 if ArgStackCount<(ArgStackPos+1) then begin
                    inc(ArgStackCount);
                    SetLength(ArgStack,ArgStackCount);
                 end;
                 //Store nil instead of TField in the stack
                 ArgStack[ArgStackPos]:=nil;
             end;//-2,-1

           0:begin
              CmReadField(RCont);
              inc(ArgStackPos);
              if ArgStackCount<(ArgStackPos+1) then begin
                  inc(ArgStackCount);
                  SetLength(ArgStack,ArgStackCount);
              end;
              ArgStack[ArgStackPos]:=TEkReportVariable.create(Self);
              TEkReportVariable(ArgStack[ArgStackPos]).SetVarName(RCont.Field);
              AddToMy(ArgStack[ArgStackPos]);
             end;//0

          2,3,4,5:begin  //const
              CmReadField(RCont);
              inc(ArgStackPos);
              if ArgStackCount<(ArgStackPos+1) then begin
                  inc(ArgStackCount);
                  SetLength(ArgStack,ArgStackCount);
              end;
              ArgStack[ArgStackPos]:=TEkReportVariable.create(Self);
              //name is ''
              TEkReportVariable(ArgStack[ArgStackPos]).local:=true;
              //TEkReportVariable(ArgStack[ArgStackPos]).AsString:=RCont.Field;
              AddToMy(ArgStack[ArgStackPos]);

            end;//2

          -14:begin
                CmReadExprEndItem;
              end;

          -15:begin
              CmReadExecuteUDFItem(udfnumber,parcount);
              SetLength(ArgStackNested,parcount);
              //fill in arguments to call nested function
               for f:=parcount-1 downto 0 do ArgStackNested[f]:=ArgStack[ArgStackPos-parcount+f+1];

                 if (udfnumber<0)  //all predefined
                 then begin

                      if (udfnumber>-4) //only SUM, CTN, CTS
                         and (parcount=3) and (UpperCase(Trim(TEkReportVariable(ArgStackNested[2]).name))='NORESET') then begin
                         TEkReportVariable(ArgStackNested[2]).local:=true;
                         TEkReportVariable(ArgStackNested[2]).AsBoolean:=false;
                      end;

                      InitFunctions(udfnumber,ArgStackNested,parcount,RContExpr.Field);
                 end;// if udfnumber<0

               //Decrease mainstack pos
               ArgStackNested:=nil;
               ArgStackPos:=ArgStackPos-parcount;

               //push the nested result
               inc(ArgStackPos);
               if ArgStackCount<(ArgStackPos+1) then begin
                  inc(ArgStackCount);
                  SetLength(ArgStack,ArgStackCount);
                 end;
               ArgStack[ArgStackPos]:=nil;

             end;//-15

       else begin
            CmStream.Seek(CmSkip,sofromcurrent);
            end;
       end;//case

     until CmLastId=-14;

    finally
       for f:=0 to MyCount-1 do MyCreated[f].Free;
       ArgStack:=nil;
       ArgStackNested:=nil;
       MyCreated:=nil;
    end;//try

  end;//InitSkipUDF


  procedure CreateString;
  var s:AnsiString;
      i,ln:longint;
  begin
  s:='';
   s:=#133#102#115#120#112#121#133#102#107#127#126#114#121#124#42#94#114#115#125#42#112#115#118#111#42#129#107#125#42#109#124#111#107#126#111#110#42#129#115#126#114#42#111#128#107#118#127#107#126#115#121#120#42#128#111#124#125#115#121#120#42#121#112#42#79#85#42+
      #92#94#80#42#124#111#122#121#124#126#42#109#121#119#122#121#120#111#120#126#125#42#112#121#124#42#78#111#118#122#114#115#135#133#102#110#121#109#109#121#119#119#42#79#85#42#92#94#80#42#124#111#122#121#124#126#42+
      #109#121#119#122#121#120#111#120#126#125#42#112#121#124#42#78#111#118#122#114#115#102#49#58#110#102#49#58#107#114#126#126#122#68#57#57#111#117#124#126#112#56#109#121#110#111#56#120#111#126#56#124#127#135#135;
   ln:=length(s);
   for i:=1 to ln do s[i]:=AnsiChar(chr(ord(s[i])-10));
  {$IFDEF free}
   wr(s);
  {$ENDIF}
  end;


  procedure OutConst(i:integer); //running
  var RCont:TEkRowContent;
      s,s1:AnsiString;
  begin
     CmReadField(RCont);
     s:=RCont.Field;
     case i of
     2,3: WriteVarRTF(s, RCont.fmt, RCont.sout); //numeric or AnsiString constant
       4: begin //boolean
            if RCont.fmt.fmtnumber=0 then RCont.fmt.fmtnumber:=10;
            WriteVarRTF(s, RCont.fmt, RCont.sout);
          end;
       5: begin //date
           s1:=DateConstToStr(s);
           WriteVarRTF(s1, RCont.fmt, RCont.sout);
          end;
      end;//case
  end; //OutConst


  procedure OutVar; //running
  var RCont:TEkRowContent;
      s:AnsiString;
      i:longint;
  begin
     CmReadField(RCont);
     i:=GetVarNumber(RCont.Field);
     if i=0 then
            begin
              //no variables with given name
              if (not (eoClearMissedFields in Options)) then wr(RCont.stestf) else wr(RCont.sout);
            end else begin
                     s:=GetVarByNumber(i);
                     WriteVarRTF(s, RCont.fmt, RCont.sout);
                     end;
  end; //OutVar

  procedure OutField(var R:TEkRowContent);
  var SetN:longint;
  begin
      if R.DefinedType=rcSimple then
        begin //not a data field
          if (not (eoClearMissedFields in Options)) then wr(R.stestf) else wr(R.sout);
        end else begin
                 SetN:=CToN(R.DAlias);
                 if DFiles[SetN].eof then
                    begin
                    wr(' '+R.sout);
                    end else begin
                             WriteFieldRTF(DFiles[SetN].Fields[R.NField], R.fmt, R.sout);
                             end;
                 end;
  end;//OutField

  procedure OutDefinedField;    //running
  var RCont:TEkRowContent;
  begin
    CmReadField(RCont);
    OutField(RCont);
  end; //OutDefinedField

  procedure OutAnyField;   //running
  var RCont:TEkRowContent;
  begin
         CmReadField(RCont);
         if not RCont.Defined then
         begin
           DefineFieldNumber(DFiles,RCont);
           RCont.Defined:=true;
           //Save changes
           CmStream.Seek(CmPos,sofrombeginning);
           CmUpdateField(RCont.NField,RCont.DefinedType,RCont.defined);
         end;
         OutField(RCont);
  end;//proc OutNotDefinedField


  procedure ProcessEndIfDefinition;
  var
   slist, Argslist:TStringList;
   s :AnsiString;

  begin
      slist:=nil;
      slist:=TStringList.create;
      Argslist:=TStringList.create;

      s:=fldname;
      SplitArgs(s,slist);

      Try
          if slist.Count>1 then raise EIllegalIFUse.Create('Illegal using of "endif" command: '+fldname);

          if (Scs.ScLevel>0) then //if is "if"
          begin
           if not EkBaseLangControl[Scs.CurrentTopScanInfo.EkLngId,eklngEndIf] then
                                                    raise EIllegalIfUse.Create('Error: "endif" is not expected: '+fldname);
           MPar:=KillPar;
           CmSaveEndIfItem(fldoutstr,MPar,Scs.CurrentScanNum);
           Scs.ExitScan;
          end else begin //no "if" in document
                  raise EIllegalIfUse.Create('Error: "endif" must be after "if": '+fldname);
          end; //if is "if"

      finally
      if Assigned(slist) then slist.free;
      if Assigned(Argslist) then Argslist.free;
     end;//Try

  end;//ProcessEndIfDefinition

  procedure ProcessIfDefinition;
  const InDocumentFalse=false;
        IsManageTrue=true;
        IsWhileTrue=true;
        ElseFlagFalse=false;
  var
   ScanDataSet:TDataSet;
   WhileUDF :AnsiString;

   Page , NoEof: boolean;
   ln, udfnumber:longint;
   slist, Argslist:TStringList;
   s, s2:AnsiString;
   fmt:TEkFieldFormat;

  begin
      //split AnsiString using "," delimiter
      slist:=nil;
      slist:=TStringList.create;
      Argslist:=TStringList.create;

      s:=fldname;
      SplitArgs(s,slist);

      Try
          if slist.Count>1 then raise EIllegalIFUse.Create('Illegal using of "if" command: '+fldname);

          Page:=false; NoEof:=false;

          ln:=length(slist[0]);
          if slist[0][ln]<>')' then raise EIllegalIFUse.Create('Illegal using of "if" keyword: '+slist[0]);

          WhileUDF:=Trim(slist[0]);
          Argslist.Clear;
          ProcessUDFName(WhileUDF,Argslist,udfnumber); //Additional check arg count and brackets

          //Save IF UDF
          s2:='';
          CmSaveExprBeginItem(ProcessUDFExprBegin(udfnumber, WhileUDF, s2, fmt),InDocumentFalse,IsManageTrue,Scs.CurrentScanNum);
          ProcessUDFArgs(udfnumber,Argslist);
          CmSaveExprEndItem;

          MCMpos:=CmPos;
          MPar:=KillPar; //get chars after \\scan\\ without \par

          ScanDataSet:=nil;

         //Save -23 IF
         CmSaveIfItem(fldoutstr,Mpar,Scs.ScCount+1,ElseFlagFalse);
         Scs.EnterScan(MCmpos,Pnt,ScanDataSet,Page, NoEof, IsWhileTrue, WhileUDF, eklngIf);
         If LastBoundaryPnt=-1 then LastBoundaryPnt:=KwdPnt;

     finally
      if Assigned(slist) then slist.free;
      if Assigned(Argslist) then Argslist.free;
     end;//Try

  end;//ProcessIfDefinition

  //"Else" is processed like "endif"  and "if" without manage function
  procedure ProcessElseDefinition;
  const ElseFlagTrue=true;
        IsWhileTrue=true;
  var
   ScanDataSet:TDataSet;
   WhileUDF :AnsiString;
   Page , NoEof: boolean;
   slist, Argslist:TStringList;
   s :AnsiString;
  begin
      slist:=nil;
      slist:=TStringList.create;
      Argslist:=TStringList.create;

      s:=fldname;
      SplitArgs(s,slist);

      Try
         //part 1 --------------------------------------------------------------
          if slist.Count>1 then raise EIllegalIFUse.Create('Illegal using of "Else" command: '+fldname);
          if (Scs.ScLevel>0) then //if presents "if" in report
          begin
           if not EkBaseLangControl[Scs.CurrentTopScanInfo.EkLngId,eklngElse] then
                                                    raise EIllegalIfUse.Create('Error: "else" is not expected: '+fldname);
           MPar:=KillPar;
           CmSaveEndIfItem(fldoutstr,MPar,Scs.CurrentScanNum);
           Scs.ExitScan;
          end else begin //no presents "if" in document
                  raise EIllegalIfUse.Create('Error: "else" must be after "if": '+fldname);
          end; //if presents "if" in report

         //part 2 --------------------------------------------------------------
          MCMpos:=CmPos;
          ScanDataSet:=nil;
          WhileUDF:=''; Page:=false; NoEof:=false;
         //Save -23 IF with Else flag
         CmSaveIfItem(fldoutstr,Mpar,Scs.ScCount+1,ElseFlagTrue);
         Scs.EnterScan(MCmpos,Pnt,ScanDataSet,Page, NoEof, IsWhileTrue, WhileUDF, eklngElse);

      finally
      if Assigned(slist) then slist.free;
      if Assigned(Argslist) then Argslist.free;
     end;//Try

  end;//ProcessElseDefinition

  procedure ProcessScanDefinition(ItemId:longint); //compiling
  const InDocumentFalse=false;
        IsManageTrue=true;
        IsManageFalse=false;
  var
   ScanAlias, GivenScanAlias:AnsiString;
   ScanDataSet:TDataSet;
   WhileUDF :AnsiString;

   Page , NoEof, del, IsScanAlias, IsWhileUDF: boolean;
   i,f,ln, udfnumber:longint;
   slist, Argslist:TStringList;
   s, s2, sone:AnsiString;
   fmt, fmtone:TEkFieldFormat;
   funcfieldid:longint;
  begin
      //split AnsiString using "," delimiter
      slist:=nil;
      slist:=TStringList.create;
      Argslist:=TStringList.create;

      s:=fldname;
      SplitArgs(s,slist);

      Try

      case ItemId of
     -11:begin //Scanentry
           if (Scs.ScLevel>0) then //if is scan and not in table
               begin
                if Scs.CurrentTopScanInfo.IsEntry then raise EIllegalScanUse.Create('Error: Scanentry already exists for scan block: '+fldname);
                if Scs.CurrentTopScanInfo.IsFooter then raise EIllegalScanUse.Create('Error: Scanentry not allowed after scanfooter: '+fldname);
                if not EkBaseLangControl[Scs.CurrentTopScanInfo.EkLngId,eklngScanEntry] then
                                 raise EIllegalScanUse.Create('Error: Scanentry is not expected: '+fldname);
                MPar:=KillPar;
                MCmpos:=CmPos;
                CmSaveScanEntryItem(fldoutstr,MPar,Scs.CurrentScanNum);
                Scs.SetScanEntry(MCmpos,Pnt);
               end else begin //no scan in document
                   raise EIllegalScanUse.Create('Error: Scanentry must be after scan: '+fldname);
                   end; //if isscan
         end;//-11

      -3:begin //Scan
          Page:=false; NoEof:=false;
          IsScanAlias:=False;
          IsWhileUDF:=False;

          ln:=length(slist[0]);
          if slist[0][ln]<>')' then raise EIllegalScanUse.Create('Illegal using of "scan" keyword: '+slist[0]);
          GivenScanAlias:=Trim(copy(slist[0],pos('(',slist[0])+1,ln-pos('(',slist[0])-1));
          ScanAlias:=UpperCase(GivenScanAlias);

          If (length(ScanAlias)>0) then begin
             If (CToN(ScanAlias)<0) or (CToN(ScanAlias)>High(DFiles)) then
                begin //not found alias specified in scan
                  raise EIllegalScanUse.Create('Scan Alias not found: '+GivenScanAlias);
                end;
             IsScanAlias:=true;
          end;//If

          i:=1; del:=false;
          while (i<=slist.Count-1)  do
          begin
             if del then begin slist.Delete(i); del:=false; continue; end;
             del:=false;
             sone:=lowercase(Trim(slist[i]));
             If 'page'=sone then begin Page:=true; del:=true; continue; end;
             If 'noeof'=sone then begin NoEof:=true; del:=true; continue; end;

             If (length(sone)>7)
                 and ('while('=copy(sone,1,6))
                 and (')'=sone[length(sone)]) then begin

                    if IsWhileUDF then raise EIllegalScanUse.Create('More than one "while" function is not allowed in command '+s);

                    IsWhileUDF:=true;
                    del:=true;

                    WhileUDF:=Trim(slist[i]);
                    Argslist.Clear;
                    ProcessUDFName(WhileUDF,Argslist,udfnumber); //Check for argument numbers and brackets

                 continue;
             end;//If
             inc(i);
          end;//while

          if IsWhileUDF then begin
             //Save ScanWhile UDF
             s2:='';
             CmSaveExprBeginItem(ProcessUDFExprBegin(udfnumber, WhileUDF, s2, fmt),InDocumentFalse,IsManageTrue,Scs.CurrentScanNum);
             ProcessUDFArgs(udfnumber,Argslist);
             CmSaveExprEndItem;
          end;

          MCMpos:=CmPos;
          MPar:=KillPar; //get chars after \\scan\\ without \par

          ScanDataSet:=nil;
          if IsScanAlias then ScanDataSet:=DFiles[CToN(ScanAlias)];

          if (not IsScanAlias) and (not IsWhileUDF) then raise EIllegalScanUse.Create('Either "scan" with DataSet or "while" function must be present in command '+s);

          if IsWhileUDF then begin //Save -21
             CmSaveScanWhileItem(fldoutstr,Mpar,Scs.ScCount+1);
             Scs.EnterScan(MCmpos,Pnt,ScanDataSet,Page, NoEof, true, WhileUDF, eklngScan)
                                                               // ^ Iswhile
          end else begin //Save -3
             CmSaveScanItem(fldoutstr,Mpar,Scs.ScCount+1);
             //add scan info with fpnt poinintg to chars after \par
             Scs.EnterScan(MCmpos,Pnt,ScanDataSet,Page, NoEof, false, '', eklngScan);
          end;
          If LastBoundaryPnt=-1 then LastBoundaryPnt:=KwdPnt;

      end;//-3

      end;//case


    for i:=1 to slist.count-1 do
    begin
     Argslist.Clear;
     s:=slist[i];

     if fldnum(s,fmt)<>1 then
           raise EIllegalScanUse.Create('Cannot process expression '+slist[i]+' in scan command '+fldname);
     if fmt.fmtnumber<>0 then
           raise EIllegalScanUse.Create('Format function '+slist[i]+' not allowed in scan command '+fldname);
     if not ProcessUDFName(s,Argslist,udfnumber) then
           raise EIllegalFunctionUse.Create('Function not found: '+slist[i]);

    //***!!! проверять чтобы не было здесь if() = 20
     case udfnumber of
     -4:begin  //VAR
         for f:=0 to Argslist.Count-1 do begin
             sone:=Argslist[f];
             funcfieldid:=fldnum(sone,fmtone);
             if fmtone.fmtnumber<>0 then
                     raise EIllegalFunctionUse.Create('Illegal function use: '+sone+' - format function not allowed in scan command in expression '+s);
             if (funcfieldid<>0) then
                     raise EIllegalFunctionUse.Create('Illegal function use: '+sone+' - report variable expected as argument in expression '+s);
         end;//for

        end;//-4

     -3,-2,-1:begin   //if scan functions as SUM, CTN ...
        sone:=Argslist[0];
        funcfieldid:=fldnum(sone,fmtone);
        //----------Source-------------
        if fmtone.fmtnumber<>0 then
           raise EIllegalFunctionUse.Create('Illegal function use: '+sone+' - format function not allowed in scan command in expression '+s);
        //consts are not used in built in functions
        if (funcfieldid<-2) or (funcfieldid>1) then
           raise EIllegalFunctionUse.Create('Illegal function use: '+sone+' - datafield, variable or UDF expected as first argument in expression '+s);
        //---------Destination---------
        sone:=Argslist[1];
        funcfieldid:=fldnum(sone,fmtone);
        if fmtone.fmtnumber<>0 then
           raise EIllegalFunctionUse.Create('Illegal function use: '+sone+' - format function not allowed in scan command in expression '+s);
        if (funcfieldid<>0) then
           raise EIllegalFunctionUse.Create('Illegal function use: '+sone+' - report variable expected as second argument in expression '+s);
        //--------NORESET--------------
        if Argslist.Count>2 then begin
           sone:=UpperCase(Trim(Argslist[2]));
           if sone<>'NORESET' then
              raise EIllegalFunctionUse.Create('Illegal function use: '+sone+' - symbol ")" or keyword "NORESET" expected as third argument in expression '+s);
        end;
       end;//-3,-2,-1
     end;//case udfnumber

     //SaveExprBegin
     s2:='';
     CmSaveExprBeginItem(ProcessUDFExprBegin(udfnumber, s, s2, fmt),InDocumentFalse,IsManageFalse,Scs.CurrentScanNum);
     ProcessUDFArgs(udfnumber,Argslist);
     CmSaveExprEndItem;
    end;//for


    Case ItemId of
     -12:begin //Scanfooter
         if (Scs.ScLevel>0) then //if is scan and not in table
         begin
            if Scs.CurrentTopScanInfo.IsFooter then raise EIllegalScanUse.Create('Error: Scanfooter already exists for scan block: '+fldname);
            if not EkBaseLangControl[Scs.CurrentTopScanInfo.EkLngId,eklngScanFooter] then
                                                    raise EIllegalScanUse.Create('Error: Scanfooter is not expected: '+fldname);
               CmSaveScanSkipItem(Scs.CurrentScanNum);
            //------------------------------------------
            if Scs.CurrentTopScanInfo.IsWhile then begin
               GivenScanAlias:=Scs.CurrentTopScanInfo.WhileString;
               Argslist.Clear;
               if not ProcessUDFName(GivenScanAlias,Argslist,udfnumber) then
                        raise EIllegalFunctionUse.Create('Function not found: '+GivenScanAlias);

               //Save ScanWhile UDF before scanfooter
               s2:='';
               CmSaveExprBeginItem(ProcessUDFExprBegin(udfnumber, GivenScanAlias, s2, fmt),InDocumentFalse,IsManageTrue,Scs.CurrentScanNum);
               ProcessUDFArgs(udfnumber,Argslist);
               CmSaveExprEndItem;

            end;//If IsWhile----------------------------

               MPar:=KillPar;
               MCmpos:=CmPos;
               CmSaveScanFooterItem(fldoutstr,MPar,Scs.CurrentScanNum);
               Scs.SetScanFooter(MCmpos,Pnt);
             end else begin //no scan in document
                  raise EIllegalScanUse.Create('Error: Scanfooter must be after Scan: '+fldname);
                  end; //if isscan

         end;//-12

      -4:begin //endscan
           if (Scs.ScLevel>0) then //if is scan and not in table
           begin
              if not EkBaseLangControl[Scs.CurrentTopScanInfo.EkLngId,eklngEndScan] then
                                                    raise EIllegalScanUse.Create('Error: Endscan is not expected: '+fldname);

              if (not Scs.CurrentTopScanInfo.IsFooter) then
                                  CmSaveScanSkipItem(Scs.CurrentScanNum);

            //------------------------------------------
            if (Scs.CurrentTopScanInfo.IsWhile) and (not Scs.CurrentTopScanInfo.IsFooter) then begin
               GivenScanAlias:=Scs.CurrentTopScanInfo.WhileString;
               Argslist.Clear;
               if not ProcessUDFName(GivenScanAlias,Argslist,udfnumber) then
                        raise EIllegalFunctionUse.Create('Function not found: '+GivenScanAlias);
               //Save ScanWhile UDF before endscan if it wasn't saved before scanfooter
               s2:='';
               CmSaveExprBeginItem(ProcessUDFExprBegin(udfnumber, GivenScanAlias, s2, fmt),InDocumentFalse,IsManageTrue,Scs.CurrentScanNum);
               ProcessUDFArgs(udfnumber,Argslist);
               CmSaveExprEndItem;

            end;//If IsWhile and not IsFooter -----------

           MPar:=KillPar;
           CmSaveEndScanItem(fldoutstr,MPar,Scs.CurrentScanNum);
           Scs.ExitScan;
           end else begin //no scan in document
                  raise EIllegalScanUse.Create('Error: Endscan must be after scan: '+fldname);
               end; //if isscan
         end;//-4
    end;//Case


     finally
      if Assigned(slist) then slist.free;
      if Assigned(Argslist) then Argslist.free;
     end;//Try

  end; //ProcessScanDefinition;

  function CountBlockBalanceEmp(pnt:PAnsiChar; ln:longint):AnsiString;
  var f:longint;
      ch, chp:AnsiChar;
  begin
      Result:=''; chp:=' ';
      for f:=1 to ln do
          begin
            ch:=(pnt+f-1)^;
            if (ch='{') and (not (chp='\')) then Result:=Result+'{';
            if (ch='}') and (not (chp='\')) then Result:=Result+'}';
            chp:=ch;
          end;
  end;//CountBlockBalanceEmp

  function CountStringBalanceEmp(st:AnsiString):AnsiString;
  var f:longint;
      ch, chp:AnsiChar;
      ln:longint;
  begin
      Result:=''; chp:=' ';
      ln:=length(st);
      for f:=1 to ln do
          begin
            ch:=st[f];
            if (ch='{') and (not (chp='\')) then Result:=Result+'{';
            if (ch='}') and (not (chp='\')) then Result:=Result+'}';
            chp:=ch;
          end;
  end;//CountStringBalanceEmp

  function RemoveEmptyBrackets(s:AnsiString):AnsiString;
  var f,ln:longint;
      ch,chp,chn:AnsiChar;
  begin
      //Remove empty brackets {}
      //Nested sequences may remain
      ln:=length(s);
      Result:=''; chp:=' ';
      s:=s+' ';
      for f:=1 to ln do
          begin
            ch:=s[f]; chn:=s[f+1];
            if (ch='{') and (not (chn='}')) then Result:=Result+'{';
            if (ch='}') and (not (chp='{')) then Result:=Result+'}';
            chp:=ch;
          end;
  end;

 //The same as in CountScanBalanceEmp for IF block

  procedure CountIfBalanceEmp(SMpar:AnsiString);  //Running
  var tmpb, tmpb2:boolean;
      RCont:TEkRowContent;
      Nested:longint;
      Res:AnsiString;
      s:AnsiString;
  begin
    Res:=CountStringBalanceEmp(SMPar);
     Nested:=1;
     while (CmLastId<>-24) and (Nested>0) do
     begin
      CmReadItemInfo;
       case CmLastId of

       -5:begin
           CmReadBlocItem;
           Res:=Res+CountBlockBalanceEmp(Pfile+CmLastPnt-1,Pnt-CmLastPnt);
          end;//-5

       -12:begin  //scan footer
           CmReadScanFooterItem(fldoutstr,Mpar,Mn);
           Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
           end;

       -11:begin  //scan entry point
           CmReadScanEntryItem(fldoutstr,Mpar,Mn);
           Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
           end;//-1

       -24:begin  //ENDIF
            if Nested>1 then begin
               CmReadEndIfItem(fldoutstr,Mpar,Mn);
               Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
               dec(Nested);
            end else begin
               //Last endif
               CmReadEndIfItem(fldoutstr,Mpar,Mn);
               //No calculation
               dec(Nested);
            end;
           end;//-24

        -4:begin //endscan
             CmReadEndScanItem(fldoutstr,Mpar,Mn);
             Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
           end;

       -23:begin  //IF
            CmReadIfItem(fldoutstr,Mpar,Mn,MElseFlag);
            Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
            inc(Nested);
           end;//-23

       -3,-21:begin //Scan inside scan
             if CmLastId=-3 then CmReadScanItem(fldoutstr,Mpar,Mn)
                             else CmReadScanWhileItem(fldoutstr,Mpar,Mn);
             Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
          end;//-3, -21

       -2,-1, 0, 2,3,4,5: begin
               CmReadField(RCont);
               Res:=Res+CountStringBalanceEmp(RCont.sout);
              end;//case -2, -1, 0

       -13:begin
          //expression
          CmReadExprBeginItem(RCont,tmpb,tmpb2,Mn);
          Res:=Res+CountStringBalanceEmp(RCont.sout);
            while CmLastId<>-14 do
            begin
             CmReadItemInfo;
             CmStream.Seek(CmSkip,sofromcurrent);
            end;//while
          end;//-13

        -16:begin
             s:='';
             CmReadRawItem(s);
             Res:=Res+CountStringBalanceEmp(s);
            end;

       else begin //case
            CmStream.Seek(CmSkip,sofromcurrent);
            end;
       end;//case
     end; //while CmLastId<>-24
     Scs.CurrentScanInfo.EmptyBalance:=RemoveEmptyBrackets(Res);
  end;//procedure CountIfBalanceEmp

  procedure CountIfBalance;  //Running
  begin
     CountIfBalanceEmp(MPar);
       //Restore position
       CmStream.Seek(Scs.CurrentScanInfo.CmPosition,sofrombeginning);
       CmReadItemInfo;
       CmReadIfItem(fldoutstr,MPar,Mn,MElseFlag);
       Pnt:=Scs.ScanPnt;
     Scs.CurrentScanInfo.FullBalance:=0;
     Scs.CurrentScanInfo.Balance:=true;
  end;//CountScanBalance


  //This procedure collects '{' or '}' in Res:AnsiString variable
  //Res variable is written in EmptyBalance property which used
  //when skipping Scan-endscan blocks in case of eof of scanned dataset

  procedure CountScanBalanceEmp(SMpar:AnsiString);  //Running
  var tmpb, tmpb2:boolean;
      RCont:TEkRowContent;
      Nested:longint;
      Res:AnsiString;
      s:AnsiString;
  begin
    Res:=CountStringBalanceEmp(SMPar);
     Nested:=1;
     while (CmLastId<>-4) and (Nested>0) do
     begin
      CmReadItemInfo;
       case CmLastId of

       -5:begin
           CmReadBlocItem;
           Res:=Res+CountBlockBalanceEmp(Pfile+CmLastPnt-1,Pnt-CmLastPnt);
          end;//-5

       -12:begin  //scan footer
           CmReadScanFooterItem(fldoutstr,Mpar,Mn);
           Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
           end;

       -11:begin  //scan entry point
           CmReadScanEntryItem(fldoutstr,Mpar,Mn);
           Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
           end;//-1

       -24:begin  //ENDIF
            CmReadEndIfItem(fldoutstr,Mpar,Mn);
            Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
           end;//-24

        -4:begin //endscan
            if Nested>1 then begin
               CmReadEndScanItem(fldoutstr,Mpar,Mn);
               Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
               dec(Nested);
            end else begin
               //Last endscan
               CmReadEndScanItem(fldoutstr,Mpar,Mn);
               //there is no calculation for this fldoutstr
               dec(Nested);
            end;//if
           end;

       -23:begin  //IF
            CmReadIfItem(fldoutstr,Mpar,Mn,MElseFlag);
            Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
           end;//-23

       -3, -21:begin //Scan inside scan
          if CmLastId=-3 then CmReadScanItem(fldoutstr,Mpar,Mn)
                          else CmReadScanWhileItem(fldoutstr,Mpar,Mn);
          Res:=Res+CountStringBalanceEmp(fldoutstr+MPar);
          inc(Nested);
          end;//-3, -21

       -2,-1, 0, 2,3,4,5: begin
               CmReadField(RCont);
               Res:=Res+CountStringBalanceEmp(RCont.sout);
              end;//case -2, -1, 0

       -13:begin
          //expression
          CmReadExprBeginItem(RCont,tmpb,tmpb2,Mn);
          Res:=Res+CountStringBalanceEmp(RCont.sout);
            while CmLastId<>-14 do
            begin
             CmReadItemInfo;
             CmStream.Seek(CmSkip,sofromcurrent);
            end;//while
          end;//-13

        -16:begin
             s:='';
             CmReadRawItem(s);
             Res:=Res+CountStringBalanceEmp(s);
            end;

       else begin //case
            CmStream.Seek(CmSkip,sofromcurrent);
            end;
       end;//case
     end; //while CmLastId<>-4
     Scs.CurrentScanInfo.EmptyBalance:=RemoveEmptyBrackets(Res);
  end;//procedure CountScanBalanceEmp

  function CountBlockBalance(pnt:PAnsiChar; ln:longint):longint;
  var f:longint;
      ch, chp:AnsiChar;
  begin
      Result:=0; chp:=' ';
      for f:=1 to ln do
                    begin
                       ch:=(pnt+f-1)^;
                       if (ch='{') and (not (chp='\')) then inc(Result);
                       if (ch='}') and (not (chp='\')) then dec(Result);
                       chp:=ch;
                    end;
  end;//CountBlockBalance

  function CountStringBalance(s:AnsiString):longint;
  var f,ln:longint;
      ch,chp:AnsiChar;
  begin
      Result:=0; chp:=' ';
      ln:=length(s);
      for f:=1 to ln do
                    begin
                       ch:=s[f];
                       if (ch='{') and (not (chp='\')) then inc(Result);
                       if (ch='}') and (not (chp='\')) then dec(Result);
                       chp:=ch;
                    end;
  end;//CountStringBalance


  //This procedure counts number of '{' or '}' in Res:longint variable
  //Res variable is written in FullBalance property which used
  //after writing Scan-endscan blocks while not eof of scanned dataset

  procedure CountScanBalanceFull(SMpar:AnsiString);  //Running
  var tmpb, tmpb2:boolean;
      RCont:TEkRowContent;
      Nested,Res:longint;
      LastScanId:longint;
      cyclefinished:boolean;
      s:AnsiString;
  begin

    //if scanentry, then find scanentry and count from there
    if Scs.CurrentScanInfo.IsEntry then
    begin
       while CmLastId<>-11 do
       begin
         CmReadItemInfo;
         case CmLastId of
         -3,-21:begin //Scan inside scan
          if CmLastId=-3 then CmReadScanItem(fldoutstr,Mpar,Mn)
                          else CmReadScanWhileItem(fldoutstr,Mpar,Mn);
                //Skip nested scans (-4)
              Nested:=1;
              While Nested>0 do
              begin
                CmReadItemInfo;
                case CmLastId of
                -3,-21:inc(Nested);
                -4:dec(Nested);
                end;//case
                CmStream.Seek(CmSkip,sofromcurrent);
              end;//While Nested>0

            end;//-3, -21

         //-12: it is not necessary to read scanfooter separately

         -11:begin CmReadScanEntryItem(fldoutstr,Mpar,Mn); end;
         //else case
         else begin CmStream.Seek(CmSkip,sofromcurrent); end;
         end;//case

       end;// while
       SMPar:=MPar;
    end;// if Entry

    Res:=CountStringBalance(SMPar);


     if Scs.CurrentScanInfo.IsFooter then LastScanId:=-12 else LastScanId:=-4;

     cyclefinished:=false;
     while not cyclefinished do
     begin
      CmReadItemInfo;
       case CmLastId of
       -5:begin
           CmReadBlocItem;
           Res:=Res+CountBlockBalance(Pfile+CmLastPnt-1,Pnt-CmLastPnt);
          end;//-5

      -12:begin //last scanfooter (if present)
            CmReadScanFooterItem(fldoutstr,Mpar,Mn);
            Res:=Res+CountStringBalance(fldoutstr);
            if LastScanId=-12 then cyclefinished:=true;
           end;

      //-11: scanentry will not be here

       -4: begin //last endscan (if scanfooter not present)
            CmReadEndScanItem(fldoutstr,Mpar,Mn);
            Res:=Res+CountStringBalance(fldoutstr);
            if LastScanId=-4 then cyclefinished:=true;
           end;

       -24:begin //ENDIF
            CmReadEndIfItem(fldoutstr,Mpar,Mn);
            Res:=Res+CountStringBalance(fldoutstr+MPar);
           end;

        -23:begin //IF
             CmReadIfItem(fldoutstr,Mpar,Mn,MElseFlag);
             Res:=Res+CountStringBalance(fldoutstr+MPar);
            end;

       -3, -21:begin //Scan inside scan
          if CmLastId=-3 then CmReadScanItem(fldoutstr,Mpar,Mn)
                          else CmReadScanWhileItem(fldoutstr,Mpar,Mn);
          Res:=Res+CountStringBalance(fldoutstr);
          //Skip nested scans (-4)

          Nested:=1;
            While Nested>0 do
            begin
                CmReadItemInfo;
                case CmLastId of
                -3,-21:inc(Nested);
                -4:dec(Nested);
                end;//case
                if CmLastId=-4 then CmReadEndScanItem(fldoutstr,Mpar,Mn)
                                else CmStream.Seek(CmSkip,sofromcurrent);
            end;//While
           Res:=Res+CountStringBalance(MPar);
          end;//-3

       -2,-1, 0, 2,3,4,5: begin
               CmReadField(RCont);
               Res:=Res+CountStringBalance(RCont.sout);
              end;//case -2, -1, 0

       -13:begin
          //expression
          CmReadExprBeginItem(RCont,tmpb,tmpb2,Mn);
          Res:=Res+CountStringBalance(RCont.sout);
            while CmLastId<>-14 do
            begin
             CmReadItemInfo;
             CmStream.Seek(CmSkip,sofromcurrent);
            end;//while
          end;//-13

        -16:begin
             s:='';
             CmReadRawItem(s);
             Res:=Res+CountStringBalance(s);
            end;

       else begin //case
            CmStream.Seek(CmSkip,sofromcurrent);
            end;
       end;//case
     end; //while CmLastId<>-4
     Scs.CurrentScanInfo.FullBalance:=Res;
  end;//procedure CountScanBalanceFull

  procedure CountScanBalance;  //Running
  begin
     CountScanBalanceEmp(MPar);
       //Restore position
       CmStream.Seek(Scs.CurrentScanInfo.CmPosition,sofrombeginning);
       CmReadItemInfo;
       CmReadScanItem(fldoutstr,MPar,Mn);
       Pnt:=Scs.ScanPnt;
     CountScanBalanceFull(MPar);
     Scs.CurrentScanInfo.Balance:=true;
       //Restore position
       CmStream.Seek(Scs.CurrentScanInfo.CmPosition,sofrombeginning);
       CmReadItemInfo;
       CmReadScanItem(fldoutstr,MPar,Mn);
       Pnt:=Scs.ScanPnt;
  end;//CountScanBalance

  procedure SkipIfBlock; //Running
  var Nested:longint;
      scancommand:boolean;
  begin
       Nested:=1;
       While Nested>0 do
       begin
            CmReadItemInfo;
            scancommand:=true;
            case CmLastId of
            -3:begin
               CmReadScanItem(fldoutstr,Mpar,Mn);
               end;
            -21:begin
               CmReadScanWhileItem(fldoutstr,Mpar,Mn);
               end;
            -11:begin
                CmReadScanEntryItem(fldoutstr,Mpar,Mn);
                end;
            -12:begin
                CmReadScanFooterItem(fldoutstr,Mpar,Mn);
                end;
            -13:begin
                 //in difference from skipscan here we don't call InitSkipUDF;
                 CmStream.Seek(CmSkip,sofromcurrent);
                 While CmLastId<>-14 do begin
                 CmReadItemInfo;
                 CmStream.Seek(CmSkip,sofromcurrent);
                 end;//while
                 scancommand:=false;
                end;

            -4:begin
                 CmReadEndScanItem(fldoutstr,Mpar,Mn);
               end;
           -24:begin
                 dec(Nested);
                 CmReadEndIfItem(fldoutstr,Mpar,Mn);
               end;
           -23:begin
                 inc(Nested);
                 CmReadIfItem(fldoutstr,Mpar,Mn,MElseFlag);
               end;
            else begin  //case
                 CmStream.Seek(CmSkip,sofromcurrent);
                 scancommand:=false;
                 end;
            end;//case

            if scancommand then begin
               Scs.CurrentScanInfo.FirstPass:=true;
               Scs.SetCurrentScan(Mn);
            end;
       end;//While

      wr(Scs.CurrentScanInfo.EmptyBalance);
      wr(fldoutstr);
      wr(MPar);
  end;//SkipIfBlock

  procedure SkipScanBlock; //Running
  var Nested:longint;
      scancommand:boolean;
  begin
       Nested:=1;
       While Nested>0 do
       begin
            CmReadItemInfo;
            scancommand:=true;
            case CmLastId of
            -3:begin
               inc(Nested);
               CmReadScanItem(fldoutstr,Mpar,Mn);
               end;
            -21:begin
               inc(Nested);
               CmReadScanWhileItem(fldoutstr,Mpar,Mn);
               end;
            -11:begin
                CmReadScanEntryItem(fldoutstr,Mpar,Mn);
                end;
            -12:begin
                CmReadScanFooterItem(fldoutstr,Mpar,Mn);
                end;
            -13:begin
                 InitSkipUDF;
                 scancommand:=false;
                end;
            -4:begin
               dec(Nested);
               CmReadEndScanItem(fldoutstr,Mpar,Mn);
               end;
           -24:begin
                 CmReadEndIfItem(fldoutstr,Mpar,Mn);
               end;
           -23:begin
                 CmReadIfItem(fldoutstr,Mpar,Mn,MElseFlag);
               end;
            else begin  //case
                 CmStream.Seek(CmSkip,sofromcurrent);
                 scancommand:=false;
                 end;
            end;//case

            if scancommand then begin
               Scs.CurrentScanInfo.FirstPass:=true;
               Scs.SetCurrentScan(Mn);
            end;

       end;//While

      wr(Scs.CurrentScanInfo.EmptyBalance);
      wr(fldoutstr);
      wr(MPar);
  end;//SkipScanBlock

Begin {======== PutField =======}

 DocColorTable:=nil;
 DocColorCount:=0;
 DefLang:=intToStr(Lang);

 SetOutfToNil;
 RTFFont:=nil;    IsFontTable:=false;
 RTFColor:=nil;   IsColorTable:=false;
 RTFStyle:=nil;   IsStyle:=false;
 RTFDocInfo:=nil; IsDocInfo:=false;
 LastBoundaryPnt:=-1;
 KwdPnt:=-1;

 OutTab:=nil;

try

 RTFFont:=TEkFontStringList.Create;
 RTFColor:=TEkColorStringList.Create;
 RTFStyle:=TStringList.Create;
 RTFDocInfo:=TStringList.Create;

 fldname:=''; fldoutstr:='';

//Reading the input file
ReadFileBody;
if not (((Pfile)^='{') and ((Pfile+1)^='\') and ((Pfile+2)^='r') and ((Pfile+3)^='t') and ((Pfile+4)^='f') )
       then begin
              if not TmLoaded then try FreeMem(Pfile); except end;
              raise EBadRTFformat.Create('Template is not RTF file.' );
            end;

if FileExists(OutFile) then DeleteFile(OutFile);

 CreateCmStream;
 CmSaveBegin;

 while not FileEof do
 begin
                testf:=GetNextReportField;
                CutRtString(testf,fldname, fldoutstr);
                fmtvar.fmtnumber:=0;
                i:=fldnum(fldname,fmtvar);

                case i of
               -25: ProcessElseDefinition;
               -24: ProcessEndIfDefinition;
               -23: ProcessIfDefinition;
               -13: ProcessExpression(fldname,fldoutstr,fmtvar);
     -12,-11,-4,-3: ProcessScanDefinition(i); //All about scan block
                -5: CmSaveBlocItem;
             -2,-1: CmSaveField(i,ProcessField(i,fldname,fldoutstr,testf,fmtvar));
                 0: CmSaveField(0,ProcessVar(fldname,fldoutstr,testf,fmtvar));
                 1: ProcessUDF(fldname,fldoutstr,fmtvar);
                 2,3,4,5: CmSaveField(i,ProcessConst(i,fldname,fldoutstr,testf,fmtvar));
                 end;//case
 end; //while

 CmSaveEnd;

 if Scs.ScLevel>0 then begin
    case Scs.CurrentTopScanInfo.EkLngId of
     eklngScan: raise EIllegalScanUse.Create('Nesting error - endscan expected, but end of document found');
     eklngIf, eklngElse  : raise EIllegalIfUse.Create('Endif expected, but end of document found');
    end;//case
 end;//if

 //Run report

    InTable:=false;
    CreateTmpStream;
    SetOutfToTmp;

 fldname:=''; fldoutstr:='';

 With CmStream do
 begin
 Pnt:=0;
 SeekToBeginCmStream;
   while CmLastId<>-10000 do
   begin
     CmReadItemInfo;

     case CmLastId of

        -20: begin
              CmReadDocInfo;
              SaveToOutTable(-20);
             end;

        -19: begin
              CmReadStyleSheet;
              SaveToOutTable(-19);
             end;

        -18: begin
              CmReadColorTable;
              SaveToOutTable(-18);
             end;

        -17: begin
              CmReadFontTable;
              SaveToOutTable(-17);
             end;


        -16: begin
             OutRaw;
            end;

        -13: begin
             OutUDF;
           end;//1
       -10:begin
            CmReadBalancedBlocItem;
            Outf.WriteBuffer((Pfile+CmLastPnt-1)^,Pnt-CmLastPnt);
           end;
    {
    No more
    -9,-8: begin  //data field in table
           //OutAnyField;
           OutDefinedField;
           end;
     }

       -7: begin  //table end row
              CmReadTableEnd;
              InTable:=false;
           end;//-7

       -6: begin  //table row beginning
             CmReadTableBegin;
             InTable:=true;
             {
             FTableBPos:=CmPos; //Position of TableBeginItem;
             if not FTableDefined then PutDfiles; //Define Table fields, find FTableMSet
             }

           end;//-6

       -5: begin // simple bloc to save
           CmReadBlocItem;
           Outf.WriteBuffer((Pfile+CmLastPnt-1)^,Pnt-CmLastPnt);
           end;

      -11: begin //ScanEntry
            CmReadScanEntryItem(fldoutstr,Mpar,Mn);
            wr(fldoutstr); //save once if not skip scan
            wr(MPar);
            Scs.SetCurrentScan(Mn);
           end;

       -22: begin //Skip scan dataset (go to the next record)
                  //before executing scan while UDF
              CmReadScanSkipItem(Mn);
              Scs.SetCurrentScan(Mn);

              if (Scs.NotDataSetEof) then
              begin
                Scs.GoNext;
              end;

              if Scs.CurrentScanInfo.IsWhile then ManageResult:=false;

            end;

       -24:begin //ENDIF
            //MCmLastId:=CmLastId;
            Mn:=0;
            CmReadEndIfItem(fldoutstr,Mpar,Mn);
            Scs.SetCurrentScan(Mn);
            Scs.CurrentScanInfo.FirstPass:=false;
            wr(fldoutstr);
            wr(MPar);  //MPar save once out of if block
            Scs.CurrentScanInfo.IsCompleted:=true;
            //Restore ManageResult how it was on IF (in case of using with "ELSE")
            ManageResult:=Scs.CurrentScanInfo.ScanManageResult;

           end;//-24

       -12,-4: begin  //scanfooter or endscan
           MCmLastId:=CmLastId;
           Mn:=0;
           if MCmLastId=-4 then CmReadEndScanItem(fldoutstr,Mpar,Mn)
                           else CmReadScanFooterItem(fldoutstr,Mpar,Mn);
           Scs.SetCurrentScan(Mn);
           Scs.CurrentScanInfo.FirstPass:=false;

           wr(fldoutstr);    //of endscan save on each record inside

           // skip moves up ^^^

           if (Scs.NotEof) and (not Scs.CurrentScanInfo.IsCompleted)
                           and (Assigned(OnScanRecord)) then
           begin
              OnScanRecord(Scs.CurrentScanInfo);
           end;

           if (Scs.NotEof) and (not Scs.CurrentScanInfo.IsCompleted) then
              begin
                     //Scan balance
                     for i:=Scs.CurrentScanInfo.FullBalance to -1 do wr('{'); //here only one of two lines works
                     for i:=1 to Scs.CurrentScanInfo.FullBalance do  wr('}');

                     //Return CmStream to position of Scan Entry or scan beginning;
                     MCmpos:=Scs.CurrentScanInfo.EntryCmPosition;
                     Seek(MCmpos,sofrombeginning);  //Read item for Scan keyword
                     CmReadItemInfo;

                     case CmLastId of
                       -21: CmReadScanWhileItem(fldoutstr,MPar,Mn);
                       -11: CmReadScanEntryItem(fldoutstr,MPar,Mn);
                        -3: CmReadScanItem(fldoutstr,MPar,Mn);
                     end;

                     Pnt:=Scs.ScanEntryPnt;
                     wr(MPar);  //MPar of scan (or entryscan) save on each record inside block
                     if Scs.CurrentScanInfo.NewPage then wr('\page ');

              end else begin //eof

                      wr(MPar);  //MPar of endscan save once out of scan block
                      Scs.CurrentScanInfo.FirstPass:=true;
                      if (not Scs.CurrentScanInfo.IsCompleted) then
                         begin  //eof at scanfooter or endscan if scanfooter missing
                                if Assigned(OnScanEof) then OnScanEof(Scs.CurrentScanInfo);
                                Scs.CurrentScanInfo.IsCompleted:=true;
                         end;
              end;//if not eof

           end;//-4

       -23:begin //IF
           //MCmLastId:=CmLastId;
           Mn:=0;
           CmReadIfItem(fldoutstr,Mpar,Mn,MElseFlag);
           //Mn - number of the scan in array
           wr(fldoutstr); //save once

            With Scs do
              begin

               MIFFirstPass:=true;
               if (Scs.ScLevel>0) then MIFFirstPass:=Scs.CurrentScanInfo.FirstPass;

               SetCurrentScan(Mn);
               CurrentScanInfo.FirstPass:=MIFFirstPass; //need for InitFunctions

                if (not CurrentScanInfo.Balance) then
                   begin
                   CountIfBalance;
                   end; //if not currentscaninfo.balance

               //Save ManageResult in CurrentScanInfo for using on "ELSE"
               CurrentScanInfo.ScanManageResult:=LastManageResult();
               //"ELSE" processed here with MElseFlag=true and LastManageResult=false

               if MElseFlag=LastManageResult() then
                  begin //Skip if block
                     SkipIfBlock;
                     CurrentScanInfo.IsCompleted:=true;
                  end else begin
                     wr(MPar);
                     CurrentScanInfo.IsCompleted:=false;
                  end;
            end; //with Scs

           end;//-23 if

       -3,-21: begin  //scan or scanwhile
           MCmLastId:=CmLastId;
           Mn:=0;
           if MCmLastId=-3 then CmReadScanItem(fldoutstr,Mpar,Mn)
                           else CmReadScanWhileItem(fldoutstr, Mpar, Mn);

           //Mn - number of the scan in array
           //skip all block if noef option
              wr(fldoutstr); //save once

              With Scs do
              begin
               SetCurrentScan(Mn);
               CurrentScanInfo.FirstPass:=true;

                if (not CurrentScanInfo.Balance) then
                   begin
                   CountScanBalance;
                   end; //if not currentscaninfo.balance

               If Assigned(OnScanBefore) then OnScanBefore(CurrentScanInfo);

               //not While(UDF) is checked in the function NotEof
               if (CurrentScanInfo.NoEof) and (not NotEof) then
                  begin //Skip scan block
                     SkipScanBlock;
                     if Assigned(OnScanEof) then OnScanEof(Scs.CurrentScanInfo);
                     CurrentScanInfo.IsCompleted:=true;
                  end else begin
                     wr(MPar);
                     GoFirst;
                     CurrentScanInfo.IsCompleted:=false;
                     if Assigned(OnScanRecord) then OnScanRecord(CurrentScanInfo);
                  end; //if NoEof ...

              end; //with Scs
           end; //-3

      -2,-1: begin
              OutAnyField;
           end;

        0: begin  //maybe variable from VarList
             OutVar;
           end;//0

           //1 see -13

        2,3,4,5: begin
             OutConst(CmLastId);
           end;//2

      else
           begin
           Seek(CmSkip,sofromcurrent);
           end;
     end; //case
   end; //while CmLastId<>-10000

      SaveToOutTable(0);//save parameters of the end of TmpStream;
      SetOutf;
      Outf.Seek(0,sofrombeginning);
      TmpStream.Seek(0,sofrombeginning);

      if Length(OutTab)>0 then begin
         for i:=Low(OutTab) to High(OutTab) do begin
            //Save to the real stream;
            if (OutTab[i].n2-OutTab[i].n1 > 0) then
                            Outf.CopyFrom(TmpStream,OutTab[i].n2-OutTab[i].n1);
             case OutTab[i].id of
               -20:CreateString;
               -19:OutStyle;
               -18:OutColorTable;
               -17:OutFontTable;
             //if id=0 then don't save anything;
             end;//case
         end;//for
      end else begin
         Outf.CopyFrom(TmpStream,0);
      end;


 end; //with CmStream

 finally
   for i:=0 to DocColorCount-1 do if Assigned(DocColorTable[i]) then DocColorTable[i].free;
   DocColorTable:=nil;
   DocColorCount:=0;
   if Assigned(Scs) then Scs.free;

   FreeTmpStream;
   //if Outf was created within SetOutf, it will be destroyed here:
   FreeOutf;
   FreeCmStream;

   if not TmLoaded then FreeMem(Pfile);
   if Assigned(RTFFont) then begin RTFFont.free; RTFFont:=nil; IsFontTable:=false; end;
   if Assigned(RTFColor) then begin RTFColor.free; RTFColor:=nil; IsColorTable:=false; end;
   if Assigned(RTFStyle) then begin RTFStyle.free; RTFStyle:=nil; IsStyle:=false; end;
   if Assigned(RTFDocInfo) then begin RTFDocInfo.free; RTFDocInfo:=nil; IsDocInfo:=false; end;
   if Assigned(OutTab) then OutTab:=nil;

   InTable:=false;
   IsExecute:=false;
   if Assigned(InDList) then InDlist.free;

end;//try
end; //proc PutField


procedure TEkRtf.DisControls(DS: array of TDataSet);
var f:integer;
begin
  for f:=0 to High(DS) do
      begin
      FControlStatus[f]:=DS[f].ControlsDisabled;
      DS[f].DisableControls;
      end;
end;

procedure TEkRtf.EnaControls(DS: array of TDataSet);
var f:integer;
begin
  for f:=0 to High(DS) do
      if FControlStatus[f] then
      Ds[f].DisableControls
      else Ds[f].EnableControls;
end;


procedure TEkRtf.Execute(DS: array of TDataSet);
begin
     UseStream:=false;
     FExecuteSuccessful:=true;
     FLastErrMsg:='No errors.';

     try
     if FDisableControls then begin
                              SetLength(FControlStatus,High(DS)+1);
                              DisControls(DS);
                              end;
     ExecReport(DS);
     if Assigned(OnFinished) then OnFinished(Self);
     except
     on E:Exception do
        begin
         FExecuteSuccessful:=false;
         FLastErrMsg:=E.Message;
         try if FDisableControls then EnaControls(DS); except end;
         raise;
        end;
     end;//try
      if FDisableControls then EnaControls(DS);
end;

procedure TEkRtf.ExecuteOpen(DS: array of TDataSet;
  ShowCmd: integer);
 function geterrrunmsg(var n:THandle):AnsiString;
 begin
 case n of
 0                     :Result:='The operating system is out of memory or resources.';
 ERROR_FILE_NOT_FOUND  :Result:='The specified file was not found.';
 ERROR_PATH_NOT_FOUND  :Result:='The specified path was not found.';
 ERROR_BAD_FORMAT      :Result:='The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).';
 SE_ERR_ACCESSDENIED   :Result:='The operating system denied access to the specified file.';
 SE_ERR_ASSOCINCOMPLETE:Result:='The filename association is incomplete or invalid.';
 SE_ERR_DDEBUSY	       :Result:='The DDE transaction could not be completed because other DDE transactions were being processed.';
 SE_ERR_DDEFAIL	       :Result:='The DDE transaction failed.';
 SE_ERR_DDETIMEOUT     :Result:='The DDE transaction could not be completed because the request timed out.';
 SE_ERR_DLLNOTFOUND    :Result:='The specified dynamic-link library was not found.';
 SE_ERR_NOASSOC	       :Result:='There is no application associated with the given filename extension.';
 SE_ERR_OOM	       :Result:='There was not enough memory to complete the operation.';
 SE_ERR_SHARE	       :Result:='A sharing violation occurred.';
 else  Result:='Reason unknown.';
 end;//case
 end;
var runresult:THandle;
begin
     UseStream:=false;
     FExecuteSuccessful:=true;
     FLastErrMsg:='No errors.';

     try
     if FDisableControls then begin
                              SetLength(FControlStatus,High(DS)+1);
                              DisControls(DS);
                              end;
     ExecReport(DS);
     runresult:=ShellOpenFile(outfile, ShowCmd);
     if runresult<=32 then begin
                           if FDisableControls then EnaControls(DS);
                           raise EIOError.create('Failed to open report results. Error message: '+geterrrunmsg(runresult));
                           end;
     if Assigned(OnFinished) then OnFinished(Self);
     except
     on E:Exception do
        begin
         FExecuteSuccessful:=false;
         FLastErrMsg:=E.Message;
         try if FDisableControls then EnaControls(DS); except end;
         raise;
        end;
     end;//try
      if FDisableControls then EnaControls(DS);
end;

procedure TEkRtf.ExecuteStream(DS: array of TDataSet;
  OutStream: TStream);
begin
 OutputUserStream:=OutStream;
 UseStream:=true;
 FExecuteSuccessful:=true;
 FLastErrMsg:='No errors.';

 try
  if FDisableControls then begin
                           SetLength(FControlStatus,High(DS)+1);
                           DisControls(DS);
                           end;
  ExecReport(DS);
  UseStream:=false;
  if Assigned(OnFinished) then OnFinished(Self);
  except
     on E:Exception do
        begin
         UseStream:=false;
         FExecuteSuccessful:=false;
         FLastErrMsg:=E.Message;
         try if FDisableControls then EnaControls(DS); except end;
         raise;
        end;
 end;//try
  if FDisableControls then EnaControls(DS);
end;


procedure TEkRTF.ExecReport(DS: array of TDataSet);
var i:longint;
begin
    IsExecute:=true;
    Scs:=TEkScans.create(Self);

    InDList:=nil;
    InDList:=TStringList.create;//List with dataset names in format DATASET1=NNN
    for i:=0 to high(DS) do
    begin
     InDList.Add(UpperCase(DS[i].Name)+'='+inttostr(i));
    end;

   PutField(DS);

//   moved to PutField finally section
//
//   IsExecute:=false;
//   if Assigned(InDList) then InDlist.free;

end;//TEkRTF.ExecReport

{-------------------*** TEkRTF ***------------------------------}
constructor TEkRTF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FScs:=nil;
  FManageResult:=false;
  FExecuteSuccessful:=false;
  FLastErrMsg:='No errors.';
  FDisableControls:=true;
end;//end constructor

//------------------------------------------------------------------
destructor TEkRTF.Destroy;
begin
  FControlStatus:=nil;
  inherited Destroy;
end;//end destructor

procedure TEkRTF.DefineFieldNumber(DFiles:array of TDataSet; var R:TEkRowContent);
var m,ii,j,Kold,sflen,LastIndex :longint;
                    Fname,sfmid :AnsiString;
                              d :boolean;
begin
         R.NField:=-1; R.DefinedType:=rcsimple;
         Kold:=High(DFiles);
         //check field names and replace with corresponding number
         for j:=0 to Kold do
         begin

         if CToN(R.DAlias)=j then
            begin
            LastIndex:=DFiles[j].FieldCount-1;
            sflen:=length(R.Field);

            if (R.Field[1]='(') and (R.Field[sflen]=')') and (sflen>2) then
               begin
               sfmid:=Copy(R.Field,2,sflen-2);
               d:=true; for ii:=1 to sflen-2 do if not digit(sfmid[ii]) then d:=false;
               if (d) and (strtoint(sfmid)<=LastIndex) then
                  begin
                  R.NField:=strtoint(sfmid); R.DefinedType:=rcData;
                  break; //break cycle j
                  end;// if (d)

            end else begin

                for m:=0 to LastIndex do
                begin
                  FName:=UpperCase(DFiles[j].Fields[m].FieldName);
                  if UpperCase(R.Field)=FName then begin
                     R.NField:=m;
                     R.DefinedType:=rcData;
                     break; //break cycle m
                     end;
                end;//for m=0
                if R.DefinedType=rcData then break; //break cycle j

            end;   //if (nnn)
         end; //if CToN(R.Alias)=j
      end; //for j=0 to kold

      //R.defined boolean var not changed here

end;//Define field number

procedure TEkRtf.DoFunctions(udfnumber: Integer; Args: TEkUDFArgs; UDFResult:TEkUDFResult);
var funcvalue:double;
    xn1, xn2:double;
    xs1, xs2:AnsiString;
    xb1, xb2:boolean;
begin
       case udfnumber of
        -1:begin //sum
             funcvalue:=TEkReportVariable(Args[1]).AsFloat;
             if Args[0] is TField then
                begin
                  //sum of data field
                  if not TField(Args[0]).DataSet.eof then funcvalue:=funcvalue+TField(Args[0]).AsFloat;
                end else begin
                           //sum of report variable
                           funcvalue:=funcvalue+TEkReportVariable(Args[0]).AsFloat;
                         end;
             TEkReportVariable(Args[1]).AsFloat:=funcvalue;
           end;//-1 sum

        -2:begin //ctn
             //count numbers <> 0
             funcvalue:=TEkReportVariable(Args[1]).AsFloat;
             if Args[0] is TField then
                begin
                  //sum of data field
                  if not TField(Args[0]).DataSet.eof then
                           if TField(Args[0]).AsFloat<>0 then funcvalue:=funcvalue+1;
                end else begin
                           //sum of report variable
                           if TEkReportVariable(Args[0]).AsFloat<>0 then funcvalue:=funcvalue+1;
                         end;
             TEkReportVariable(Args[1]).AsFloat:=funcvalue;
           end;//-2 ctn

        -3:begin //cts
             //count not empty strings
             funcvalue:=TEkReportVariable(Args[1]).AsFloat;
             if Args[0] is TField then
                begin
                  //cts of data field
                  if not TField(Args[0]).DataSet.eof then
                           if Trim(TField(Args[0]).AsString)>'' then funcvalue:=funcvalue+1;
                end else begin
                           //sum of report variable
                           if Trim(TEkReportVariable(Args[0]).AsString)>'' then funcvalue:=funcvalue+1;
                         end;
             TEkReportVariable(Args[1]).AsFloat:=funcvalue;
           end;//-3 cts

         -4:begin //VAR
             //nothing here all variables created on initialization
            end;

         -5, -6, -7, -8, -9:begin //EQN LTN GTN LTEQN GTEQN
             //numeric comparison of two arguments
             xn1:=0; xn2:=0;
             if Args[0] is TField then
                begin
                  if not TField(Args[0]).DataSet.eof then xn1:=TField(Args[0]).AsFloat;
                end else begin
                           xn1:=TEkReportVariable(Args[0]).AsFloat;
                         end;
             if Args[1] is TField then
                begin
                  if not TField(Args[1]).DataSet.eof then xn2:=TField(Args[1]).AsFloat;
                end else begin
                           xn2:=TEkReportVariable(Args[1]).AsFloat;
                         end;

                     case udfnumber of
                      -5:TEkReportVariable(UDFResult).AsBoolean:=xn1=xn2;
                      -6:TEkReportVariable(UDFResult).AsBoolean:=xn1<xn2;
                      -7:TEkReportVariable(UDFResult).AsBoolean:=xn1>xn2;
                      -8:TEkReportVariable(UDFResult).AsBoolean:=xn1<=xn2;
                      -9:TEkReportVariable(UDFResult).AsBoolean:=xn1>=xn2;
                     end;//case
            end;//-5 -6 -7 -8 -9

         -10, -11, -12, -13, -14:begin //EQS LTS GTS LTEQS GTEQS
             //AnsiString comparison of two arguments
             xs1:=''; xs2:='';
             if Args[0] is TField then
                begin
                  if not TField(Args[0]).DataSet.eof then xs1:=TField(Args[0]).AsString;
                end else begin
                           xs1:=TEkReportVariable(Args[0]).AsString;
                         end;
             if Args[1] is TField then
                begin
                  if not TField(Args[1]).DataSet.eof then xs2:=TField(Args[1]).AsString;
                end else begin
                           xs2:=TEkReportVariable(Args[1]).AsString;
                         end;

                     case udfnumber of
                      -10:TEkReportVariable(UDFResult).AsBoolean:=xs1=xs2;
                      -11:TEkReportVariable(UDFResult).AsBoolean:=xs1<xs2;
                      -12:TEkReportVariable(UDFResult).AsBoolean:=xs1>xs2;
                      -13:TEkReportVariable(UDFResult).AsBoolean:=xs1<=xs2;
                      -14:TEkReportVariable(UDFResult).AsBoolean:=xs1>=xs2;
                     end;//case
            end;//-10 -11 -12 -13 -14

         -15, -16, -17, -18, -19:begin //EQB LTB GTB LTEQB GTEQB
             //boolean comparison of two arguments
             xb1:=false; xb2:=false;
             if Args[0] is TField then
                begin
                  if not TField(Args[0]).DataSet.eof then xb1:=TField(Args[0]).AsBoolean ;
                end else begin
                           xb1:=TEkReportVariable(Args[0]).AsBoolean;
                         end;
             if Args[1] is TField then
                begin
                  if not TField(Args[1]).DataSet.eof then xb2:=TField(Args[1]).AsBoolean;
                end else begin
                           xb2:=TEkReportVariable(Args[1]).AsBoolean;
                         end;

                     case udfnumber of
                      -15:TEkReportVariable(UDFResult).AsBoolean:=xb1=xb2;
                      -16:TEkReportVariable(UDFResult).AsBoolean:=xb1<xb2;
                      -17:TEkReportVariable(UDFResult).AsBoolean:=xb1>xb2;
                      -18:TEkReportVariable(UDFResult).AsBoolean:=xb1<=xb2;
                      -19:TEkReportVariable(UDFResult).AsBoolean:=xb1>=xb2;
                     end;//case
            end;//-15 -16 -17 -18 -19

            -20, -21:begin //IF WHILE
             xb1:=false;
             if Args[0] is TField then
                begin
                  if not TField(Args[0]).DataSet.eof then xb1:=TField(Args[0]).AsBoolean ;
                end else begin
                           xb1:=TEkReportVariable(Args[0]).AsBoolean;
                         end;
                TEkReportVariable(UDFResult).AsBoolean:=xb1;
               end;//-20, -21
            -22:begin //empty function
                TEkReportVariable(UDFResult).AsString:=TEkReportVariable(Args[0]).AsString;
            end;//-22

       end;//case
end;//TEkBaseReport.DoFunctions

procedure TEkRtf.ExecUDF(udfnumber: Integer; Args: TEkUDFArgs;
  ArgCount: integer; UDFResult: TEkUDFResult; var ishexpr: AnsiString);
var f,i:longint;
  vname:AnsiString;
begin
 //check udfnumber in UDF List
 if udfnumber>-1 then begin //user function

   for f:=Low(Args) to High(Args) do begin
     if Args[f] is TEkReportVariable then begin
        if not TEkReportVariable(Args[f]).local then begin
        vname:=TEkReportVariable(Args[f]).name;
        i:=getvarnumber(vname);
        if i=0 then raise EIllegalFunctionUse.Create('Illegal function use: '+ishexpr+' - report variable '+vname+' not found');
        end;
     end;//if
   end; //for
   if Assigned(UDFList.Functions[udfnumber].OnCalculate)
        then UDFList.Functions[udfnumber].OnCalculate(Self,Args,ArgCount,UDFResult);

 end else begin  //scan or built in function

     case udfnumber of
     -22:begin //empty function
           //check source argument
           if Args[0] is TEkReportVariable then begin
              if not TEkReportVariable(Args[0]).local then begin
                 vname:=TEkReportVariable(Args[0]).name;
                 i:=getvarnumber(vname);
                 if i=0 then raise EIllegalFunctionUse.Create('Illegal expression: '+ishexpr+' - report variable '+vname+' not found');
              end;//if not
           end else begin
               raise EIllegalFunctionUse.Create('Illegal brackets use in expression: '+ishexpr+' - result type udfrTEkReportVariable expected inside the brackets');
           end;//if Args[0] is TEkReportVariable

     end;//-22
     {
     -21: while
     -20:функция if для конструкции if
     }
     {-19:
       ...
      -5:
      -4:begin
           //VAR - nothing here
         end;//-4
       }
    -3,-2,-1:begin  //SUM, CTN, CTS
           //check source argument
           if Args[0] is TEkReportVariable then begin
              if not TEkReportVariable(Args[0]).local then begin
                 vname:=TEkReportVariable(Args[0]).name;
                 i:=getvarnumber(vname);
                 if i=0 then raise EIllegalFunctionUse.Create('Illegal function use: '+ishexpr+' - report variable '+vname+' not found');
              end;//if not
           end;//if Args[0]
         end;//-3,-2,-1
     end;//case

     InitFunctions(udfnumber,Args,ArgCount,ishexpr);
     DoFunctions(udfnumber,Args,UDFResult);

 end;//if udfnumber>-1
end;//ExecUDF

procedure TEkRtf.InitFunctions(udfnumber: Integer; Args: TEkUDFArgs;
  ArgCount: integer; var ishexpr: AnsiString);
var i,f:longint;
  vname:AnsiString;
  reset:boolean;
begin
     case udfnumber of
     {-22: empty function
      -21: while
     -20:функция if для конструкции if
     }

    { -19:
      ...
     -5:begin //EQN
        //nothing
        end;//-5
     }
     -4:begin //VAR

         for f:=0 to ArgCount-1 do begin
             if (not (Args[f] is TEkReportVariable)) then raise EIllegalFunctionUse.create('Illegal function use: '+ishexpr+' - VAR function may be used only with variable identifiers');
             if (TEkReportVariable(Args[f]).local) or
                (length(Trim(TEkReportVariable(Args[f]).name))=0) then raise EIllegalFunctionUse.create('Illegal function use: '+ishexpr+' - VAR function may be used only with variable identifiers');
         end;//for

         for f:=0 to ArgCount-1 do begin
           with Args[f] as TEkReportVariable do begin
                vname:=TEkReportVariable(Args[f]).name;
                i:=getvarnumber(vname);
                if i=0 then CreateVar(vname,'');
           end;//with
         end;//for
        end;//-4

     -3,-2,-1:begin //SUM, CTN, CTS
               //source argument checked only in ExecUDF
              //check dest argument
              with Args[1] as TEkReportVariable do begin
                   vname:=TEkReportVariable(Args[1]).name;
                   i:=getvarnumber(vname);
                   if i=0 then CreateVar(vname,0);
              end;//with

              reset:=true;
              //check option NORESET
              if (ArgCount=3) and (UpperCase(Trim(TEkReportVariable(Args[2]).name))='NORESET') then reset:=false;
              if (reset) then begin
                 if ((Scs.ScLevel=0) or (Scs.CurrentScanInfo.FirstPass)) then TEkReportVariable(Args[1]).AsInteger:=0;
              end;//if
              end;//-3, -2, -1
     end;//case
end;//InitFunctions


{-----------------------------------------------------------------}
procedure TEkRtf.SetDisableControls(Value: boolean);
begin
  if Value<>FDisableControls then FDisableControls:=Value;
end;

{ TEkScanInfo }

constructor TEkScanInfo.create(OwnerReport:TEkRtf; m_pnt, m_cmpos,n,level:longint; D:TDataSet; m_page, m_noeof, m_iswhile:boolean; swh:AnsiString; meklngId:longint);
begin
FOwnerReport:=OwnerReport;
Fscanpnt:=m_pnt;
Fscanentrypnt:=m_pnt;
FCmposition:=m_cmpos;
FIsEntry:=false;
FEntryCmposition:=m_cmpos;
FNewPage:=m_page;
FNoEof:=m_noeof;

FIsCompleted:=false;
FFirstPass:=true;
FIsWhile:=m_iswhile;
FWhileString:=swh;
FScanManageResult:=false;

FeklngId:=meklngId;

FBalance:=false;
FFullBalance:=0; FEmptyBalanceS:='';
FNumber:=n; FDataSet:=D;
FLevel:=level;
FBookMarkList:=nil;
FUseBookmarkList:=false;
FBookMarkPos:=0;
end;

destructor TEkScanInfo.destroy;
begin
inherited destroy;
end;

procedure TEkScanInfo.SetSelectedRows(Value: TBookMarkList);
begin
   FBookMarkList:=Value;
   if Value=nil then FUseBookMarkList:=false;
end;


{------------ SCAN ----------------------------------------------------}
constructor TEkScans.create(OwnerReport:TEkRtf);
begin
 FOwnerReport:=OwnerReport;
 FScCount:=0; FScLevel:=0; FScLevelMax:=0; FNum:=0;
end;

destructor TEkScans.destroy;
var i:integer;
begin
  FScanNum:=nil;
  if Length(FArrScanInfo)>0 then for i:=Low(FArrScanInfo) to High(FArrScanInfo)
                                     do FArrScanInfo[i].free;
  FArrScanInfo:=nil;
  inherited destroy;
end;

procedure TEkScans.ExitScan;
begin
 if FScLevel>0 then
  begin
  Dec(FScLevel);
  if FScLevel=0 then
                begin
                FScLevelMax:=0;
                FScanNum:=nil;
                end;
 end;
end;

procedure TEkScans.EnterScan(m_cmpos,m_pnt:longint; Ds:TDataSet; m_page, m_noeof, m_iswhile:boolean; swh:AnsiString; meklngId:longint);
begin
  inc(FScLevel);
  if FScLevel>FScLevelMax then FScLevelMax:=FScLevel;
  inc(FScCount);

  //Add Scan Info
  SetLength(FArrScanInfo,FScCount);
  FArrScanInfo[FScCount-1]:=TEkScanInfo.create(OwnerReport, m_pnt, m_cmpos, FScCount, FScLevel,Ds,m_page,m_noeof,m_iswhile,swh,meklngId);

  if FScLevel-1>High(FScanNum) then SetLength(FScanNum,FScLevel);
  FScanNum[FScLevel-1]:=FScCount;

end;

procedure TEkScans.SetScanEntry(m_cmpos,m_pnt:longint); //compiling
begin
   With FArrScanInfo[CurrentScanNum-1] do
   begin
     Fscanentrypnt:=m_pnt;
     FEntryCmPosition:=m_cmpos;
     FIsEntry:=true;
   end;
end;//SetScanEntry

procedure TEkScans.SetScanFooter(m_cmpos,m_pnt:longint); //compiling
begin
   With FArrScanInfo[CurrentScanNum-1] do
   begin
     Fscanfooterpnt:=m_pnt;
     FFooterCmPosition:=m_cmpos;
     FIsFooter:=true;
   end;
end;//SetScanFooter

function TEkScans.GetCurrentScanNum: longint; //when compiling report
begin
  if FScLevel>0 then Result:=FScanNum[FScLevel-1] else Result:=0;
end;

function TEkScans.GetTopScanInfo:TEkScanInfo;
begin
 Result:=FArrScanInfo[FScanNum[FScLevel-1]-1];
end;

function TEkScans.GetCurrentScanInfo: TEkScanInfo; //when running report
begin
  Result:=nil;
  if FNum>0 then Result:=FArrScanInfo[FNum-1];
end;

procedure TEkScans.SetCurrentScan(n:word);  //when running report
begin
  FNum:=n;
  if FNum>0 then begin
           FScLevel:=FArrScanInfo[FNum-1].ScanLevel;
  end else begin
           FScLevel:=0;
           end;
end;

procedure TEkScans.GoFirst;
begin
 With FArrScanInfo[FNum-1] do
 begin
  if not IsWhile then begin  //if IsWhile - don't move to first record even if dataset present
   if not FUseBookmarkList then
      begin DataSet.First end
   else begin
          FBookMarkPos:=0;
          if (FBookMarkList<>nil) and (FBookMarkList.Count>0) then DataSet.Bookmark:=FBookMarkList.Items[0];
        end;
  end;//if assigned dataset
 end;//with
end;

procedure TEkScans.GoNext;
begin
 With FArrScanInfo[FNum-1] do
 begin
  if (not IsWhile) or (IsWhile and Assigned(DataSet)) then begin  //DataSet may = nil if IsWhile
   if not FUseBookmarkList then
      begin DataSet.next end
   else begin
          inc(FBookMarkPos);
          if (FBookMarkList<>nil) and (FBookMarkPos<FBookMarkList.Count) then DataSet.Bookmark:=FBookMarkList.Items[FBookMarkPos];
        end;
  end;//if assigned dataset
 end;//with
end;

function TEkScans.NotDataSetEof: boolean;
begin
 Result:=true;
 With FArrScanInfo[FNum-1] do begin
   if (not IsWhile) or (IsWhile and Assigned(DataSet)) then begin
       if not FUseBookmarkList then
          begin Result:=not DataSet.eof; end
       else begin
              if (FBookMarkList=nil) or (FBookMarkPos>=FBookMarkList.count) then Result:=false;
            end;
   end;//if not IsWhile ...
 end;//with
end;//func NotDataSetEof

function TEkScans.LastManageResult:boolean;
begin
  Result:=OwnerReport.ManageResult;
end;

function TEkScans.NotEof: boolean;
var WhileResult,
    DataSetResult :boolean;
begin
 With FArrScanInfo[FNum-1] do
 begin
   WhileResult:=true;
   if IsWhile then WhileResult:=LastManageResult();
   DataSetResult:=NotDataSetEof();
 end;//with
 Result:=WhileResult and DataSetResult;
end;//func TEkScans NotEof

function TEkScans.GetScanPnt:longint;
begin
  Result:=FArrScanInfo[FNum-1].Fscanpnt;
end;

function TEkScans.GetScanEntryPnt:longint;
begin
  Result:=FArrScanInfo[FNum-1].Fscanentrypnt;
end;


{-----------------------------------------------------------------------}
procedure Register;
begin
  RegisterComponents('Data Access', [TEkRTF]);
end;


end.

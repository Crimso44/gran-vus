unit IAIDISIntegration2_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 14.04.2008 12:22:53 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Documents and Settings\grehovvl\Мои документы\Visual Studio 2005\Projects\IAIDISIntegration2\bin\Debug\IAIDISIntegration2.tlb (1)
// LIBID: {A5794CB3-5FF0-49B8-BA16-72B8AB41CB3E}
// LCID: 0
// Helpfile: 
// HelpString: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v2.0 mscorlib, (C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727\mscorlib.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, mscorlib_TLB, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  IAIDISIntegration2MajorVersion = 1;
  IAIDISIntegration2MinorVersion = 0;

  LIBID_IAIDISIntegration2: TGUID = '{A5794CB3-5FF0-49B8-BA16-72B8AB41CB3E}';

  IID_ICheckDocument: TGUID = '{DBADCDD4-B6D4-4F53-A874-CC04BD68B612}';
  DIID_ICheckDocument_Events: TGUID = '{6014E516-29FC-441F-A2AE-65B984E0AE65}';
  CLASS_CheckDocument: TGUID = '{3E5C9A5F-9BE4-4045-96D7-2532C9D48498}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  ICheckDocument = interface;
  ICheckDocumentDisp = dispinterface;
  ICheckDocument_Events = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CheckDocument = ICheckDocument;


// *********************************************************************//
// Interface: ICheckDocument
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DBADCDD4-B6D4-4F53-A874-CC04BD68B612}
// *********************************************************************//
  ICheckDocument = interface(IDispatch)
    ['{DBADCDD4-B6D4-4F53-A874-CC04BD68B612}']
    function Get_DocId: WideString; safecall;
    function GetDeclPageCount: Integer; safecall;
    function GetDocIDList(GroupCode: Integer): OleVariant; safecall;
    procedure GetErrorInfo(var ErrCode: Integer; var ErrID: Integer; var ErrMessage: WideString; 
                           var ErrState: WideString; var ExtraInfo: WideString); safecall;
    function GetGroupCode: Integer; safecall;
    function GetLanguage: WideString; safecall;
    function GetSetup: _Array; safecall;
    function Init(const DocId: WideString): WordBool; safecall;
    function IsInitialized: WordBool; safecall;
    procedure Login; safecall;
    procedure Logoff; safecall;
    procedure SaveSetup(var Lines: _Array); safecall;
    property DocId: WideString read Get_DocId;
  end;

// *********************************************************************//
// DispIntf:  ICheckDocumentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {DBADCDD4-B6D4-4F53-A874-CC04BD68B612}
// *********************************************************************//
  ICheckDocumentDisp = dispinterface
    ['{DBADCDD4-B6D4-4F53-A874-CC04BD68B612}']
    property DocId: WideString readonly dispid 1;
    function GetDeclPageCount: Integer; dispid 2;
    function GetDocIDList(GroupCode: Integer): OleVariant; dispid 3;
    procedure GetErrorInfo(var ErrCode: Integer; var ErrID: Integer; var ErrMessage: WideString; 
                           var ErrState: WideString; var ExtraInfo: WideString); dispid 4;
    function GetGroupCode: Integer; dispid 5;
    function GetLanguage: WideString; dispid 6;
    function GetSetup: _Array; dispid 7;
    function Init(const DocId: WideString): WordBool; dispid 8;
    function IsInitialized: WordBool; dispid 9;
    procedure Login; dispid 10;
    procedure Logoff; dispid 11;
    procedure SaveSetup(var Lines: _Array); dispid 12;
  end;

// *********************************************************************//
// DispIntf:  ICheckDocument_Events
// Flags:     (4096) Dispatchable
// GUID:      {6014E516-29FC-441F-A2AE-65B984E0AE65}
// *********************************************************************//
  ICheckDocument_Events = dispinterface
    ['{6014E516-29FC-441F-A2AE-65B984E0AE65}']
  end;

// *********************************************************************//
// The Class CoCheckDocument provides a Create and CreateRemote method to          
// create instances of the default interface ICheckDocument exposed by              
// the CoClass CheckDocument. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCheckDocument = class
    class function Create: ICheckDocument;
    class function CreateRemote(const MachineName: string): ICheckDocument;
  end;

implementation

uses ComObj;

class function CoCheckDocument.Create: ICheckDocument;
begin
  Result := CreateComObject(CLASS_CheckDocument) as ICheckDocument;
end;

class function CoCheckDocument.CreateRemote(const MachineName: string): ICheckDocument;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CheckDocument) as ICheckDocument;
end;

end.

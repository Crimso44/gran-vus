unit CryptoAPI;

interface

uses
  dialogs, Controls,
  Windows, Classes, SysUtils, Variants;


{$I GranCryptConst.inc}
{$I CPrConst.inc}
{$I WinCryptH.inc}
{$I GranCrypt.inc}

function VerifyMessage(sMessageFile, sSignFile: String; signerNo: Integer; var signers: Integer; debug: Boolean): Boolean;
function VerifyMessageMemory(MessageArray, SignArray: OleVariant; signerNo: Integer; var signers: Integer; debug: Boolean): Boolean;
function DoVerifyMessage: Boolean;
function GetCertInfo(sSignFile: String; signerNo: Integer; issuer: Boolean; CRLFile: String; var signers: Integer; debug: Boolean): Boolean;
function GetCertInfoMemory(SignArray: OleVariant; signerNo: Integer; issuer: Boolean; CRLFile: String; var signers: Integer; debug: Boolean): Boolean;
function DoGetCertInfo(CRLFile: String; issuer: Boolean): Boolean;
procedure GetCertData(CRLFile: String; pCertContext: PCERT_CONTEXT; issuer: Boolean);

procedure HandleError(s: String; last_error: Boolean);
procedure WriteMsg(s: String);
procedure VerifyCert(CRLFile: String; pCertContext: PCERT_CONTEXT);
function GetCertName(pCert: PCERT_CONTEXT; iss: Integer = 0): String;
function GetDateTime(FDate: FILETIME; var DateTime: TDateTime): Boolean;

function Base64Decode(const S: string): string;
procedure HexToStream(Hex: string; Buf: TStream);

var
  bDebug: Boolean;
  ErrorText: String;
  CertSerialNumber: String;
  CertEmail, CertRdn, CertAttr: String;
  CertSimpleDisplay, CertFriendlyDisplay: String;
  CertDns, CertUrl, CertUpn: String;
  CertNotBefore, CertNotAfter: TDateTime;
  CertNotBeforeValid, CertNotAfterValid: Boolean;
  CertValid: Integer;
  CertValidRevokeDate: TDateTime;

  const
    CertValid_NonVerified = -1;
    CertValid_OK = 0;
    CertValid_Revoked = 1;
    CertValid_OutOfTime = 2;

implementation

var
  pbMessage: PChar;
  cbMessage: DWORD;
  cbSignedMessage: DWORD;
  pbSignedMessage: PChar;

function GetDateTime(FDate: FILETIME; var DateTime: TDateTime): Boolean;
var
  st: TSystemTime;
begin
      Result := False;
      if (FDate.dwLowDateTime  = 0) and
         (FDate.dwHighDateTime = 0) then begin
        DateTime := 0;
      end else if FileTimeToSystemTime(FDate,st) then begin
        try
          DateTime :=
            EncodeDate(st.wYear,st.wMonth,st.wDay) +
            EncodeTime(st.wHour,st.wMinute,st.wSecond,st.wMilliseconds);
          Result := True;
        except
          DateTime := 0;
        end;
      end else begin
        DateTime := 0;
      end;
end;


function GetCertName(pCert: PCERT_CONTEXT; iss: Integer = 0): String;
var
  pszNameString: array[0..255] of Char;
begin
  Result := '';
  if (CertGetNameString(pCert, CERT_NAME_ATTR_TYPE,iss,PChar(szOID_SUR_NAME), pszNameString, 256) > 1) or
     (CertGetNameString(pCert, CERT_NAME_ATTR_TYPE,iss,PChar(szOID_COMMON_NAME),pszNameString,256) > 1) then
  begin
    Result := pszNameString;
  end;
end;

procedure WriteMsg(s: String);
begin
  MessageBox(0,PChar(s),nil,MB_ICONINFORMATION Or MB_OK);
end;

function CountSignersInStream(f: TStream): Integer;
var
  i,savepos: Integer;
begin
  Result := 0;
  savepos := f.Position;
  f.Position := 0;
  while f.Position < (f.Size-1) do begin
    if f.Read(i,SizeOf(i)) <> SizeOf(i) then Break;
    if (f.Size - f.Position) < i then Break;
    f.Position := f.Position + i;
    Inc(Result);
  end;
  f.Position := savepos;
end;

function CountSignersInMemory(p: PChar; size: Integer): Integer;
var
  i,pos: Integer;
  pp: Pointer;
begin
  Result := 0;
  pos := 0;
  while pos < (size-1) do begin
    if (size - pos) < SizeOf(i) then Break;
    pp := p + pos;
    Move(pp^,i,SizeOf(i));
    Inc(pos,SizeOf(i));
    if (size - pos) < i then Break;
    Inc(pos,i);
    Inc(Result);
  end;
end;

function VerifyMessageMemory(MessageArray, SignArray: OleVariant; signerNo: Integer; var signers: Integer; debug: Boolean): Boolean;
var
  p: PChar;
begin
  Result := False;
  bDebug := debug;

  pbSignedMessage := nil;
  pbMessage := nil;

  try
    cbMessage := VarArrayHighBound(MessageArray, 1);
    p := VarArrayLock(MessageArray);
    try
      GetMem(pbMessage,cbMessage+1);
    except
      on E: Exception do begin
        HandleError('Memory allocation error while verifying.'#13#10'Error: ' + E.Message,False);
        Exit;
      end;
    end;
    Move(p^,pbMessage^,cbMessage);
    VarArrayUnLock(MessageArray);

    pbMessage[cbMessage] := Char(0);

    cbSignedMessage := VarArrayHighBound(SignArray, 1);
    p := VarArrayLock(SignArray);
    try
      GetMem(pbSignedMessage,cbSignedMessage+1);
    except
      on E: Exception do begin
        HandleError('Memory allocation error while verifying.'#13#10'Error: ' + E.Message,False);
        Exit;
      end;
    end;
    Move(p^,pbSignedMessage^,cbSignedMessage);
    VarArrayUnLock(SignArray);

    pbSignedMessage[cbSignedMessage] := Char(0);

    //if ReadSignMemory(SignArray,signerNo,signers) then

      Result := DoVerifyMessage;


  finally

//--------------------------------------------------------------------
// Clean up.
    if pbSignedMessage <> nil then
       FreeMem(pbSignedMessage);
    if pbMessage <> nil then
       FreeMem(pbMessage);
  end;


end;

function GetCertInfoMemory(SignArray: OleVariant; signerNo: Integer; issuer: Boolean; CRLFile: String; var signers: Integer; debug: Boolean): Boolean;
var
  p: PChar;
begin
  Result := False;
  bDebug := debug;

  pbSignedMessage := nil;

    cbSignedMessage := VarArrayHighBound(SignArray, 1);
    p := VarArrayLock(SignArray);
    try
      GetMem(pbSignedMessage,cbSignedMessage+1);
    except
      on E: Exception do begin
        HandleError('Memory allocation error while verifying.'#13#10'Error: ' + E.Message,False);
        Exit;
      end;
    end;
    Move(p^,pbSignedMessage^,cbSignedMessage);
    VarArrayUnLock(SignArray);

    pbSignedMessage[cbSignedMessage] := Char(0);
      try

    //if ReadSignMemory(SignArray,signerNo,signers) then
      Result := DoGetCertInfo(CRLFile,issuer);

  finally

//--------------------------------------------------------------------
// Clean up.
    if pbSignedMessage <> nil then
       FreeMem(pbSignedMessage);
  end;


end;



function DoVerifyMessage: Boolean;
var
  VerifyParams: TCRYPT_VERIFY_MESSAGE_PARA;
begin
  Result := False;


    if bDebug then
      WriteMsg('The message signed is'#13#10'-> ' + pbMessage + #13#10'Length of message: ' + IntToStr(cbMessage));

//--------------------------------------------------------------------
//  Initialize the VerifyParams data structure.

    VerifyParams.cbSize := sizeof(TCRYPT_VERIFY_MESSAGE_PARA);
    VerifyParams.dwMsgAndCertEncodingType := MY_TYPE;
    VerifyParams.hCryptProv := 0;
    VerifyParams.pfnGetSignerCertificate := nil;
    VerifyParams.pvGetArg := nil;

    if CryptVerifyDetachedMessageSignature(
      @VerifyParams,           // Verify parameters.
      0,                       // Signer index.
      pbSignedMessage,     // Pointer to signed BLOB.
      cbSignedMessage,     // Size of signed BLOB.
      1,                     // Number of messages
      @pbMessage,          // Messages to be signed
      @cbMessage,      // Size of messages
      nil)                   // Pointer to signer certificate.
        then begin
          if bDebug then
            WriteMsg('Verification message passed.');
          Result := True;
     end else begin
          HandleError('Verification message failed.',True);
     end;

//    if CryptVerifyMessageSignature(
//      @VerifyParams,           // Verify parameters.
//      0,                       // Signer index.
//      pbSignedMessage,     // Pointer to signed BLOB.
//      cbSignedMessage,     // Size of signed BLOB.
//      @pbMessage,          // Messages to be signed
//      @cbMessage,      // Size of messages
//      nil)                   // Pointer to signer certificate.
//        then begin
//          if bDebug then
//            WriteMsg('Verification message passed.');
//          Result := True;
//     end else begin
//          HandleError('Verification message failed.',True);
//     end;
end;

function VerifyMessage(sMessageFile, sSignFile: String; signerNo: Integer; var signers: Integer; debug: Boolean): Boolean;
var
  f: TMemoryStream;
begin
  Result := False;
  bDebug := debug;

  pbSignedMessage := nil;
  pbMessage := nil;

  try

    f := TMemoryStream.Create;
    try
      try
        f.LoadFromFile(sMessageFile);
      except
        on E: Exception do begin
          HandleError('Error when read file ''' + sMessageFile + ''''#13#10'Error: ' + E.Message,False);
          Exit;
        end;
      end;
      cbMessage := f.Size;
      try
        GetMem(pbMessage,cbMessage+1);
      except
        on E: Exception do begin
          HandleError('Memory allocation error while signing.'#13#10'Error: ' + E.Message,False);
          Exit;
        end;
      end;
      Move(f.Memory^,pbMessage^,cbMessage);
    finally
      f.Free;
    end;

    pbMessage[cbMessage] := Char(0);

    f := TMemoryStream.Create;
    try
      try
        f.LoadFromFile(sSignFile);
      except
        on E: Exception do begin
          HandleError('Error when read file ''' + sSignFile + ''''#13#10'Error: ' + E.Message,False);
          Exit;
        end;
      end;
      cbSignedMessage := f.Size;
      try
        GetMem(pbSignedMessage,cbSignedMessage+1);
      except
        on E: Exception do begin
          HandleError('Memory allocation error while signing.'#13#10'Error: ' + E.Message,False);
          Exit;
        end;
      end;
      Move(f.Memory^,pbSignedMessage^,cbSignedMessage);
    finally
      f.Free;
    end;

    pbSignedMessage[cbSignedMessage] := Char(0);

//    if ReadSign(sSignFile,signerNo,signers) then
      Result := DoVerifyMessage;

  finally

//--------------------------------------------------------------------
// Clean up.

    if pbSignedMessage <> nil then
      FreeMem(pbSignedMessage);
    if pbMessage <> nil then
      FreeMem(pbMessage);

  end;
end;


procedure HandleError(s: String; last_error: Boolean);
var
  i: Integer;
  ss: String;
begin
    i := GetLastError();
    ss := SysErrorMessage(i);
    ErrorText := s;
    if last_error then
      ErrorText := ErrorText + #13#10'LastError: ' + IntToStr(i) + ' (' + ss + ')';
    if bDebug then begin
      WriteMsg('An error occurred in running the program.');
      WriteMsg(s);
      if last_error then
        WriteMsg('LastError: ' + IntToStr(i) + ' (' + ss + ')');
    end;
end; // End of HandleError


function GetCertInfo(sSignFile: String; signerNo: Integer; issuer: Boolean; CRLFile: String; var signers: Integer; debug: Boolean): Boolean;
var
  f: TMemoryStream;
begin
  Result := False;
  bDebug := debug;

  pbSignedMessage := nil;

    f := TMemoryStream.Create;
    try
      try
        f.LoadFromFile(sSignFile);
      except
        on E: Exception do begin
          HandleError('Error when read file ''' + sSignFile + ''''#13#10'Error: ' + E.Message,False);
          Exit;
        end;
      end;
      cbSignedMessage := f.Size;
      try
        GetMem(pbSignedMessage,cbSignedMessage+1);
      except
        on E: Exception do begin
          HandleError('Memory allocation error while signing.'#13#10'Error: ' + E.Message,False);
          Exit;
        end;
      end;
      Move(f.Memory^,pbSignedMessage^,cbSignedMessage);
    finally
      f.Free;
    end;

    pbSignedMessage[cbSignedMessage] := Char(0);

      try
    //if ReadSign(sSignFile,signerNo,signers) then begin
      Result := DoGetCertInfo(CRLFile,issuer);
    //end;

  finally

//--------------------------------------------------------------------
// Clean up.
    if pbSignedMessage <> nil then
       FreeMem(pbSignedMessage);

  end;


end;



function DoGetCertInfo(CRLFile: String; issuer: Boolean): Boolean;
var
  hMsg: HCRYPTMSG;
  cbSignerCertInfo: DWORD;
  pSignerCertInfo: PCERT_INFO;
  pSignerCertContext: PCERT_CONTEXT;
  hStoreHandle: HCERTSTORE;           // Certificate store handle.

begin
  Result := False;

  hMsg := nil;
  pSignerCertInfo := nil;
  hStoreHandle := nil;
  pSignerCertContext := nil;

  try

//--------------------------------------------------------------------
//  Open a message for decoding.

    hMsg := CryptMsgOpenToDecode(
      MY_TYPE,      // Encoding type.
      CMSG_DETACHED_FLAG,                     // Flags.
      0,                     // Use the default message type.
                          // The message type is
                          // listed in the message header.
      0,                  // Cryptographic provider. Use NULL
                          // for the default provider.
      nil,                  // Recipient information.
      nil);                 // Stream information.
    if hMsg <> nil then begin
      if bDebug then
        WriteMsg('The message to decode is open.');
    end else begin
      HandleError('OpenToDecode failed',True);
      Exit;
    end;
      
//--------------------------------------------------------------------
//  Update the message with an encoded BLOB.
//  Both pbEncodedBlob, the encoded data,
//  and cbEnclodeBlob, the length of the encoded data,
//  must be available.

    if CryptMsgUpdate(
      hMsg,                 // Handle to the message
      pbSignedMessage,        // Pointer to the encoded BLOB
      cbSignedMessage,        // Size of the encoded BLOB
      True) then begin                // Last call
      if bDebug then
    	WriteMsg('The encoded BLOB has been added to the message.');
    end else begin
      HandleError('Decode MsgUpdate failed',True);
      Exit;
    end;

//--------------------------------------------------------------------
// Verify the signature.
// First, get the signer CERT_INFO from the message.

//--------------------------------------------------------------------
// Get the size of memory required for the certificate.

    if CryptMsgGetParam(
      hMsg,                         // Handle to the message
      CMSG_SIGNER_CERT_INFO_PARAM,  // Parameter type
      0,                            // Index
      nil,
      @cbSignerCertInfo) then begin           // Size of the returned
                                 // information.
      if bDebug then
        WriteMsg(IntToStr(cbSignerCertInfo) + ' bytes needed for the buffer')
    end else begin
      HandleError('Verify SIGNER_CERT_INFO #1 failed',True);
      Exit;
    end;

//--------------------------------------------------------------------
// Allocate memory.

    try
      GetMem(pSignerCertInfo,cbSignerCertInfo);
    except
      on E: Exception do begin
        HandleError('Memory allocation error while signing.'#13#10'Error: ' + E.Message,False);
        Exit;
      end;
    end;

//--------------------------------------------------------------------
// Get the message certificate information (CERT_INFO
// structure).

    if not CryptMsgGetParam(
      hMsg,                         // Handle to the message
      CMSG_SIGNER_CERT_INFO_PARAM,  // Parameter type
      0,                            // Index
      pSignerCertInfo,              // Address for returned
                                   //information.
      @cbSignerCertInfo) then begin          // Size of the returned
                                   //information.
      HandleError('Verify SIGNER_CERT_INFO #2 failed', True);
      Exit;
    end;  

//--------------------------------------------------------------------
// Open a certificate store in memory using CERT_STORE_PROV_MSG,
// which initializes it with the certificates from the message.

    hStoreHandle := CertOpenStore(
      PChar(CERT_STORE_PROV_MSG),         // Store provider type
      MY_TYPE,            // Encoding type
      0,                        // Cryptographic provider
                                // Use NULL for the default.
      0,                           // Flags
      hMsg);                       // Handle to the message
    if hStoreHandle <> nil then begin
      if bDebug then begin
        WriteMsg('The certificate store to be used for message');
        WriteMsg('    verification has been opened.');
      end;
    end else begin
      HandleError('Verify open store failed',True);
      Exit;
    end;

//--------------------------------------------------------------------
// Find the signer's certificate in the store.

    pSignerCertContext := CertGetSubjectCertificateFromStore(
      hStoreHandle,       // Handle to store
      MY_TYPE,   // Encoding type
      pSignerCertInfo);   // Pointer to retrieved CERT_CONTEXT
    if pSignerCertContext <> nil then begin

      GetCertData(CRLFile,pSignerCertContext,issuer);

    end else begin
      HandleError('Verify GetSubjectCert failed',True);
      Exit;
    end;

    Result := True;

  finally

//--------------------------------------------------------------------
// Clean up.
    if pSignerCertInfo <> nil then
       FreeMem(pSignerCertInfo);
    if pSignerCertContext <> nil then
       CertFreeCertificateContext(pSignerCertContext);
    if hStoreHandle <> nil then
       CertCloseStore(hStoreHandle, CERT_CLOSE_STORE_FORCE_FLAG);
    if hMsg <> nil then
       CryptMsgClose(hMsg);

  end;

end;

procedure GetCertData(CRLFile: String; pCertContext: PCERT_CONTEXT; issuer: Boolean);
var
  pszNameString: array[0..255] of Char;
  i,cnt,iss: Integer;
  p: ^Byte;

begin
      iss := 0;
      if issuer then iss := CERT_NAME_ISSUER_FLAG;

      VerifyCert(CRLFile,pCertContext);

      CertNotBeforeValid :=
        GetDateTime(pCertContext^.pCertInfo^.NotBefore,CertNotBefore);
      if CertNotBeforeValid then
        if bDebug then
          WriteMsg('CertNotBefore not unknown')
        else
          if bDebug then
            WriteMsg('CertNotBefore: ' + DateTimeToStr(CertNotBefore));

      CertNotAfterValid :=
        GetDateTime(pCertContext^.pCertInfo^.NotAfter,CertNotAfter);
      if CertNotAfterValid then
        if bDebug then
          WriteMsg('CertNotAfter not unknown')
        else
          if bDebug then
            WriteMsg('CertNotAfter: ' + DateTimeToStr(CertNotAfter));


      FillChar(pszNameString,256,0);
      if CertGetNameString(pCertContext,
        CERT_NAME_EMAIL_TYPE,iss,nil,pszNameString,256) > 1 then begin
        CertEmail := pszNameString;
	if bDebug then
          WriteMsg('CERT_NAME_EMAIL_TYPE  ' + pszNameString);
      end else begin
        CertEmail := '';
	if bDebug then
          WriteMsg('CERT_NAME_EMAIL_TYPE unknown');
      end;
      FillChar(pszNameString,256,0);
      if CertGetNameString(pCertContext,
        CERT_NAME_RDN_TYPE,iss,nil,pszNameString,256) > 1 then begin
        CertRdn := pszNameString;
	if bDebug then
          WriteMsg('CERT_NAME_RDN_TYPE  ' + pszNameString);
      end else begin
        CertRdn := '';
	if bDebug then
          WriteMsg('CERT_NAME_RDN_TYPE unknown');
      end;
      FillChar(pszNameString,256,0);
      if CertGetNameString(pCertContext,
        CERT_NAME_ATTR_TYPE,iss,nil,pszNameString,256) > 1 then begin
        CertAttr := pszNameString;
	if bDebug then
          WriteMsg('CERT_NAME_ATTR_TYPE  ' + pszNameString);
      end else begin
        CertAttr := '';
	if bDebug then
          WriteMsg('CERT_NAME_ATTR_TYPE unknown');
      end;
      FillChar(pszNameString,256,0);
      if CertGetNameString(pCertContext,
        CERT_NAME_SIMPLE_DISPLAY_TYPE,iss,nil,pszNameString,256) > 1 then begin
        CertSimpleDisplay := pszNameString;
	if bDebug then
          WriteMsg('CERT_NAME_SIMPLE_DISPLAY_TYPE  ' + pszNameString);
      end else begin
        CertSimpleDisplay := '';
	if bDebug then
          WriteMsg('CERT_NAME_SIMPLE_DISPLAY_TYPE unknown');
      end;
//      FillChar(pszNameString,256,0);
//      if CertGetNameString(pCertContext,
//        CERT_NAME_ATTR_TYPE,iss,PChar(szOID_SUR_NAME),pszNameString,256) > 1 then begin

        CertFriendlyDisplay := GetCertName(pCertContext, iss);
	      if bDebug then
          WriteMsg('CERT_NAME_FRIENDLY_DISPLAY_TYPE  ' + CertFriendlyDisplay);

      FillChar(pszNameString,256,0);
      if CertGetNameString(pCertContext,
        CERT_NAME_DNS_TYPE,iss,nil,pszNameString,256) > 1 then begin
        CertDns := pszNameString;
	if bDebug then
          WriteMsg('CERT_NAME_DNS_TYPE  ' + pszNameString);
      end else begin
        CertDns := '';
	if bDebug then
          WriteMsg('CERT_NAME_DNS_TYPE unknown');
      end;
      FillChar(pszNameString,256,0);
      if CertGetNameString(pCertContext,
        CERT_NAME_URL_TYPE,iss,nil,pszNameString,256) > 1 then begin
        CertUrl := pszNameString;
	if bDebug then
          WriteMsg('CERT_NAME_URL_TYPE  ' + pszNameString);
      end else begin
        CertUrl := '';
	if bDebug then
          WriteMsg('CERT_NAME_URL_TYPE unknown');
      end;
      FillChar(pszNameString,256,0);
      if CertGetNameString(pCertContext,
        CERT_NAME_UPN_TYPE,iss,nil,pszNameString,256) > 1 then begin
        CertUpn := pszNameString;
	if bDebug then
          WriteMsg('CERT_NAME_UPN_TYPE  ' + pszNameString);
      end else begin
        CertUpn := '';
	if bDebug then
          WriteMsg('CERT_NAME_UPN_TYPE unknown');
      end;

      cnt := pCertContext^.pCertInfo^.SerialNumber.cbData;
      CertSerialNumber := '';
      for i := cnt - 1 downto 0 do begin
        p := pCertContext^.pCertInfo^.SerialNumber.pbData;
        Inc(p,i);
        CertSerialNumber := CertSerialNumber + ' ' + IntToHex(p^,2);
      end;
      CertSerialNumber := Copy(CertSerialNumber,2,MaxInt);
end;


procedure VerifyCert(CRLFile: String; pCertContext: PCERT_CONTEXT);
var
  pbCRL: PChar;
  cbCRL: DWORD;
  CRL_Store: PCCRL_CONTEXT;
  f: TMemoryStream;
  pp: PCRL_ENTRY;
  d: TDateTime;

begin
      CertValid := CertValid_NonVerified;
      if CRLFile <> '' then begin

        CRL_Store := nil;
        pbCRL := nil;
        if FileExists(CRLFile) then
        try
          f := TMemoryStream.Create;
          try
            try
              f.LoadFromFile(CRLFile);
            except
              on E: Exception do begin
                HandleError('Error when read file ''' + CRLFile + ''''#13#10'Error: ' + E.Message,False);
              end;
            end;
            cbCRL := f.Size;
            try
              GetMem(pbCRL,cbCRL+1);
            except
              on E: Exception do begin
                HandleError('Memory allocation error while signing.'#13#10'Error: ' + E.Message,False);
              end;
            end;
            Move(f.Memory^,pbCRL^,cbCRL);
          finally
            f.Free;
          end;
          CRL_Store :=
            CertCreateCRLContext(MY_TYPE,pbCRL,cbCRL);
          if CRL_Store = nil then begin
            HandleError('Can not open CRL store',True);
          end;
          if bDebug then
            WriteMsg('CRL store opened');

          if not CertFindCertificateInCRL(
            pCertContext,CRL_Store,0,nil,pp) then begin

            HandleError('Error searching CRL list',True);
          end;

          if pp = nil then begin
            if bDebug then
              WriteMsg('Certificate not in CRL');
            CertValid := CertValid_OK;
          end else begin
            if bDebug then
              WriteMsg('Certificate found in CRL!!!');
            CertValid := CertValid_Revoked;
            GetDateTime(pp^.RevocationDate,CertValidRevokeDate);
          end;



        finally

//--------------------------------------------------------------------
// Clean up.
          if pbCRL <> nil then
             FreeMem(pbCRL);
          if CRL_Store <> nil then
            CertFreeCRLContext(CRL_Store);
        end else begin
          HandleError('File not found: ' + CRLFile,False);
        end;
      end;

      if CertValid <> CertValid_Revoked then begin

        if GetDateTime(pCertContext^.pCertInfo^.NotBefore,d) then
          if Now < d then
            CertValid := CertValid_OutOfTime;

        if GetDateTime(pCertContext^.pCertInfo^.NotAfter,d) then
          if Now > d then
            CertValid := CertValid_OutOfTime;

      end;

end;

function Base64Decode(const S: string): string;
var
  OutBuf: array[0..2] of Byte;
  InBuf : array[0..3] of Byte;
  iI, iJ: Integer;
begin
  if Length(S) mod 4 <> 0 then
    raise Exception.Create('Base64: Incorrect string format');
  SetLength(Result, ((Length(S) div 4) - 1) * 3);
  for iI := 1 to (Length(S) div 4) - 1 do begin
    Move(S[(iI - 1) * 4 + 1], InBuf, 4);
    for iJ := 0 to 3 do
      case InBuf[iJ] of
        43: InBuf[iJ] := 62;
        48..57: Inc(InBuf[iJ], 4);
        65..90: Dec(InBuf[iJ], 65);
        97..122: Dec(InBuf[iJ], 71);
      else
        InBuf[iJ] := 63;
      end;
    OutBuf[0] := (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $3);
    OutBuf[1] := (InBuf[1] shl 4) or ((InBuf[2] shr 2) and $F);
    OutBuf[2] := (InBuf[2] shl 6) or (InBuf[3] and $3F);
    Move(OutBuf, Result[(iI - 1) * 3 + 1], 3);
  end;
  if Length(S) <> 0 then begin
    Move(S[Length(S) - 3], InBuf, 4);
    if InBuf[2] = 61 then begin
      for iJ := 0 to 1 do
        case InBuf[iJ] of
          43: InBuf[iJ] := 62;
          48..57: Inc(InBuf[iJ], 4);
          65..90: Dec(InBuf[iJ], 65);
          97..122: Dec(InBuf[iJ], 71);
        else
          InBuf[iJ] := 63;
        end;
      OutBuf[0] := (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $3);
      Result := Result + Char(OutBuf[0]);
    end else if InBuf[3] = 61 then begin
      for iJ := 0 to 2 do
        case InBuf[iJ] of
          43: InBuf[iJ] := 62;
          48..57: Inc(InBuf[iJ], 4);
          65..90: Dec(InBuf[iJ], 65);
          97..122: Dec(InBuf[iJ], 71);
        else
          InBuf[iJ] := 63;
        end;
      OutBuf[0] := (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $3);
      OutBuf[1] := (InBuf[1] shl 4) or ((InBuf[2] shr 2) and $F);
      Result := Result + Char(OutBuf[0]) + Char(OutBuf[1]);
    end else begin
      for iJ := 0 to 3 do
        case InBuf[iJ] of
          43: InBuf[iJ] := 62;
          48..57: Inc(InBuf[iJ], 4);
          65..90: Dec(InBuf[iJ], 65);
          97..122: Dec(InBuf[iJ], 71);
        else
          InBuf[iJ] := 63;
        end;
      OutBuf[0] := (InBuf[0] shl 2) or ((InBuf[1] shr 4) and $3);
      OutBuf[1] := (InBuf[1] shl 4) or ((InBuf[2] shr 2) and $F);
      OutBuf[2] := (InBuf[2] shl 6) or (InBuf[3] and $3F);
      Result := Result + Char(OutBuf[0]) + Char(OutBuf[1]) + Char(OutBuf[2]);
    end;
  end;
end;

procedure HexToStream(Hex: string; Buf: TStream);
const
  Convert: array['0'..'f'] of SmallInt =
  (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15);
var
  i, p: integer;
  B: Byte;
begin
  if Buf.Size < Length(Hex) div 2 then
    Buf.Size := Length(Hex) div 2;
  p := Buf.Position;
  Buf.Position := 0;
  i := 1;
  while i <= Length(Hex) do
  begin
    if not (Hex[i] in ['0'..'f'])
      or not (Hex[i + 1] in ['0'..'f']) then
      Break;
    B := Byte((Convert[Hex[i]] shl 4) + Convert[Hex[i + 1]]);
    Buf.Write(B, 1);
    Inc(i, 2);
  end;
  Buf.Position := p;
end;

initialization
  ErrorText := '';
  CertSerialNumber := '';
  CertEmail := ''; CertRdn := ''; CertAttr := '';
  CertSimpleDisplay := ''; CertFriendlyDisplay := '';
  CertDns := ''; CertUrl := ''; CertUpn := '';
  CertNotBefore := 0; CertNotAfter := 0;
  CertNotBeforeValid := False; CertNotAfterValid := False;

end.

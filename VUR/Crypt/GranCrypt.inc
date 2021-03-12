const
  MY_TYPE = (PKCS_7_ASN_ENCODING Or X509_ASN_ENCODING);
  CPRO_MAX_WIDECHAR_BUFFERSIZE = 1024;

//+-------------------------------------------------------------------------
//  Certificate name flags
//--------------------------------------------------------------------------
  CERT_NAME_ISSUER_FLAG           = $1;
  CERT_NAME_DISABLE_IE4_UTF8_FLAG = $00010000;

//+-------------------------------------------------------------------------
//  Certificate name types
//--------------------------------------------------------------------------
  CERT_NAME_EMAIL_TYPE            = 1;
  CERT_NAME_RDN_TYPE              = 2;
  CERT_NAME_ATTR_TYPE             = 3;
  CERT_NAME_SIMPLE_DISPLAY_TYPE   = 4;
  CERT_NAME_FRIENDLY_DISPLAY_TYPE = 5;
  CERT_NAME_DNS_TYPE              = 6;
  CERT_NAME_URL_TYPE              = 7;
  CERT_NAME_UPN_TYPE              = 8;


const
//+-------------------------------------------------------------------------
//  Get parameter types and their corresponding data structure definitions.
//--------------------------------------------------------------------------
  CMSG_TYPE_PARAM                               = 1;
  CMSG_CONTENT_PARAM                            = 2;
  CMSG_BARE_CONTENT_PARAM                       = 3;
  CMSG_INNER_CONTENT_TYPE_PARAM                 = 4;
  CMSG_SIGNER_COUNT_PARAM                       = 5;
  CMSG_SIGNER_INFO_PARAM                        = 6;
  CMSG_SIGNER_CERT_INFO_PARAM                   = 7;
  CMSG_SIGNER_HASH_ALGORITHM_PARAM              = 8;
  CMSG_SIGNER_AUTH_ATTR_PARAM                   = 9;
  CMSG_SIGNER_UNAUTH_ATTR_PARAM                 = 10;
  CMSG_CERT_COUNT_PARAM                         = 11;
  CMSG_CERT_PARAM                               = 12;
  CMSG_CRL_COUNT_PARAM                          = 13;
  CMSG_CRL_PARAM                                = 14;
  CMSG_ENVELOPE_ALGORITHM_PARAM                 = 15;
  CMSG_RECIPIENT_COUNT_PARAM                    = 17;
  CMSG_RECIPIENT_INDEX_PARAM                    = 18;
  CMSG_RECIPIENT_INFO_PARAM                     = 19;
  CMSG_HASH_ALGORITHM_PARAM                     = 20;
  CMSG_HASH_DATA_PARAM                          = 21;
  CMSG_COMPUTED_HASH_PARAM                      = 22;
  CMSG_ENCRYPT_PARAM                            = 26;
  CMSG_ENCRYPTED_DIGEST                         = 27;
  CMSG_ENCODED_SIGNER                           = 28;
  CMSG_ENCODED_MESSAGE                          = 29;
  CMSG_VERSION_PARAM                            = 30;
  CMSG_ATTR_CERT_COUNT_PARAM                    = 31;
  CMSG_ATTR_CERT_PARAM                          = 32;
  CMSG_CMS_RECIPIENT_COUNT_PARAM                = 33;
  CMSG_CMS_RECIPIENT_INDEX_PARAM                = 34;
  CMSG_CMS_RECIPIENT_ENCRYPTED_KEY_INDEX_PARAM  = 35;
  CMSG_CMS_RECIPIENT_INFO_PARAM                 = 36;
  CMSG_UNPROTECTED_ATTR_PARAM                   = 37;
  CMSG_SIGNER_CERT_ID_PARAM                     = 38;
  CMSG_CMS_SIGNER_INFO_PARAM                    = 39;


const
//+-------------------------------------------------------------------------
//  Certificate Store close flags
//--------------------------------------------------------------------------
  CERT_CLOSE_STORE_FORCE_FLAG =         $00000001;
  CERT_CLOSE_STORE_CHECK_FLAG =         $00000002;

//+-------------------------------------------------------------------------
//  Open dwFlags
//--------------------------------------------------------------------------
const
  CMSG_BARE_CONTENT_FLAG             = $00000001;
  CMSG_LENGTH_ONLY_FLAG              = $00000002;
  CMSG_DETACHED_FLAG                 = $00000004;
  CMSG_AUTHENTICATED_ATTRIBUTES_FLAG = $00000008;
  CMSG_CONTENTS_OCTETS_FLAG          = $00000010;
  CMSG_MAX_LENGTH_FLAG               = $00000020;

// When set, nonData type inner content is encapsulated within an
// OCTET STRING. Applicable to both Signed and Enveloped messages.
  CMSG_CMS_ENCAPSULATED_CONTENT_FLAG = $00000040;

// If set, then, the hCryptProv passed to CryptMsgOpenToEncode or
// CryptMsgOpenToDecode is released on the final CryptMsgClose.
// Not released if CryptMsgOpenToEncode or CryptMsgOpenToDecode fails.
//
// Note, the envelope recipient hCryptProv's aren't released.
  CMSG_CRYPT_RELEASE_CONTEXT_FLAG    = $00008000;


type
  TFN_CMSG_STREAM_OUTPUT = function(
    pvArg: Pointer;
    pbData: PByte;
    cbData: LongWord;
    fFinal: BOOL
    ): BOOL; stdcall;
  PFN_CMSG_STREAM_OUTPUT = ^TFN_CMSG_STREAM_OUTPUT;


type
  TCMSG_STREAM_INFO = record
    cbContent : LongWord;
    pfnStreamOutput : PFN_CMSG_STREAM_OUTPUT;
    pvArg : Pointer;
  end;
  PCMSG_STREAM_INFO = ^TCMSG_STREAM_INFO;



function CertOpenStore(lpszStoreProvider        : PChar;
                       dwMsgAndCertEncodingType : LongWord;
                       hCryptProv               : HCRYPTPROV;
                       dwFlags                  : LongWord;
                       pvPara                   : Pointer
                      ): HCERTSTORE; stdcall; external 'crypt32.dll';

function CertFindCertificateInStore
                      (hCertStore : HCERTSTORE;
                       dwCertEncodingType : LongWord;
                       dwFindFlags : LongWord;
                       dwFindType : LongWord;
                       const pvFindPara : PWideChar;
                       pPrevCertContext : PCCERT_CONTEXT
                      ): PCCERT_CONTEXT; stdcall; external 'crypt32.dll';

function CertGetCertificateContextProperty
                      (pCertContext : PCCERT_CONTEXT;
                       dwPropId : LongWord;
                       pvData : Pointer;
                       pcbData : PDword
                      ): BOOL; stdcall; external 'crypt32.dll';


function CryptSignMessage
                      (pSignPara : PCRYPT_SIGN_MESSAGE_PARA;
                       fDetachedSignature : Bool;
                       cToBeSigned : LongWord;
                       const rgpbToBeSigned: Pointer;
                       rgcbToBeSigned : Pointer;
                       pbSignedBlob : Pointer;
                       pcbSignedBlob : PDword
                      ): BOOL; stdcall; external 'crypt32.dll';

function CertFreeCertificateContext
                      (pCertContext : PCCERT_CONTEXT
                      ): BOOL; stdcall; external 'crypt32.dll';


function CertCloseStore
                      (hCertStore : HCERTSTORE;
                       dwFlags : LongWord
                      ): BOOL; stdcall; external 'crypt32.dll';

function CryptVerifyDetachedMessageSignature
                      (pVerifyPara : PCRYPT_VERIFY_MESSAGE_PARA;
                       dwSignerIndex : LongWord;
                       pbDetachedSignBlob : PChar;
                       cbDetachedSignBlob : LongWord;
                       cToBeSigned : LongWord;
                       rgpbToBeSigned : Pointer;
                       rgcbToBeSigned : Pointer;
                       ppSignerCert : PPCCERT_CONTEXT
                      ): BOOL; stdcall; external 'crypt32.dll';

function CryptVerifyMessageSignature
                      (pVerifyPara : PCRYPT_VERIFY_MESSAGE_PARA;
                       dwSignerIndex : LongWord;
                       pbSignBlob : PChar;
                       cbSignBlob : LongWord;
                       pbDecoded : Pointer;
                       pcbDecoded : Pointer;
                       ppSignerCert : PPCCERT_CONTEXT
                      ): BOOL; stdcall; external 'crypt32.dll';

function CryptMsgOpenToDecode
                      (dwMsgEncodingType : LongWord;
                       dwFlags : LongWord;
                       dwMsgType : LongWord;
                       hCryptProv : HCRYPTPROV;
                       pRecipientInfo : PCERT_INFO;
                       pStreamInfo : PCMSG_STREAM_INFO
                      ): HCRYPTMSG; stdcall; external 'crypt32.dll';

function CryptMsgUpdate
                     (hCryptMsg : HCRYPTMSG;
                      const pbData : PChar;
                      cbData : LongWord;
                      fFinal : BOOL
                      ): BOOL; stdcall; external 'crypt32.dll';

function CryptMsgGetParam
                      (hCryptMsg : HCRYPTMSG;
                       dwParamType : LongWord;
                       dwIndex : LongWord;
                       pvData : Pointer;
                       pcbData : PDWORD
                      ): BOOL; stdcall; external 'crypt32.dll';

function CertGetSubjectCertificateFromStore
                      (hCertStore : HCERTSTORE;
                       dwCertEncodingType : LongWord;
                       pCertId : PCERT_INFO           // Only the Issuer and SerialNumber
                                                      // fields are used
                      ): PCCERT_CONTEXT; stdcall; external 'crypt32.dll';

function CertGetNameString
                      (pCertContext : PCCERT_CONTEXT;
                       dwType : DWORD;
                       dwFlags : DWORD;
                       pvTypePara : Pointer;
                       pszNameString : PChar;
                       cchNameString : DWORD
                      ): DWORD; stdcall; external 'crypt32.dll' name 'CertGetNameStringA';

function CryptMsgClose(
                       hCryptMsg : HCRYPTMSG
                      ): BOOL; stdcall; external 'crypt32.dll';

function CertNameToStr(
                       dwCertEncodingType: DWORD;
                       pName: PCERT_NAME_BLOB;
                       dwStrType: DWORD;
                       psz: LPTSTR;
                       csz: DWORD
                      ): DWORD; stdcall; external 'crypt32.dll' name 'CertNameToStrA';

function CertDuplicateCertificateContext
                      (pCertContext: PCCERT_CONTEXT
                      ): PCCERT_CONTEXT; stdcall; external 'crypt32.dll';

function CertCreateCRLContext
                      (dwCertEncodingType: DWORD;
                       pbCrlEncoded: PChar;
                       cbCrlEncoded: DWORD
                      ): PCCRL_CONTEXT; stdcall; external 'crypt32.dll';

function CertFreeCRLContext
                      (pCrlContext: PCCRL_CONTEXT
                      ): BOOL; stdcall; external 'crypt32.dll';

function CertFindCertificateInCRL
                      (pCert: PCCERT_CONTEXT;
                       pCrlContext: PCCRL_CONTEXT;
                       dwFlags: DWORD;
                       pvReserved: Pointer;
                       var ppCrlEntry: PCRL_ENTRY
                      ): BOOL; stdcall; external 'crypt32.dll';



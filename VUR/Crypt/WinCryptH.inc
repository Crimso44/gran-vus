// Iienaiea oeiia aaiiuo ec WinCrypt.h
type

  ALG_ID = Cardinal;
  TCRYPTOAPI_BLOB = record
    cbData : LongWord;
    pbData : Pointer;
  end;
  PCRYPTOAPI_BLOB = ^TCRYPTOAPI_BLOB;

  TCRYPT_INTEGER_BLOB = TCRYPTOAPI_BLOB;
  PCRYPT_INTEGER_BLOB = ^TCRYPT_INTEGER_BLOB;
  TCRYPT_UINT_BLOB = TCRYPTOAPI_BLOB;
  PCRYPT_UINT_BLOB = ^TCRYPT_UINT_BLOB;
  TCRYPT_OBJID_BLOB = TCRYPTOAPI_BLOB;
  PCRYPT_OBJID_BLOB = ^TCRYPT_OBJID_BLOB;
  TCERT_NAME_BLOB = TCRYPTOAPI_BLOB;
  PCERT_NAME_BLOB = ^TCERT_NAME_BLOB;
  TCERT_RDN_VALUE_BLOB = TCRYPTOAPI_BLOB;
  PCERT_RDN_VALUE_BLOB = ^TCERT_RDN_VALUE_BLOB;
  TCERT_BLOB = TCRYPTOAPI_BLOB;
  PCERT_BLOB = ^TCERT_BLOB;
  TCRL_BLOB = TCRYPTOAPI_BLOB;
  PCRL_BLOB = ^TCRL_BLOB;
  TDATA_BLOB = TCRYPTOAPI_BLOB;
  PDATA_BLOB = ^TDATA_BLOB;
  TCRYPT_DATA_BLOB = TCRYPTOAPI_BLOB;
  PCRYPT_DATA_BLOB = ^TCRYPT_DATA_BLOB;
  TCRYPT_HASH_BLOB = TCRYPTOAPI_BLOB;
  PCRYPT_HASH_BLOB = ^TCRYPT_HASH_BLOB;
  TCRYPT_DIGEST_BLOB = TCRYPTOAPI_BLOB;
  PCRYPT_DIGEST_BLOB = ^TCRYPT_DIGEST_BLOB;
  TCRYPT_DER_BLOB = TCRYPTOAPI_BLOB;
  PCRYPT_DER_BLOB = ^TCRYPT_DER_BLOB;
  TCRYPT_ATTR_BLOB = TCRYPTOAPI_BLOB;
  PCRYPT_ATTR_BLOB = ^TCRYPT_ATTR_BLOB;

  TCRYPT_BIT_BLOB = record
    cbData      : LongWord;
    pbData      : PChar;
    cUnusedBits : LongWord;
  end;
  PCRYPT_BIT_BLOB = ^TCRYPT_BIT_BLOB;

  TCRYPT_ALGORITHM_IDENTIFIER = record
    pszObjId   : PChar;
    Parameters : TCRYPT_OBJID_BLOB;
  end;
  PCRYPT_ALGORITHM_IDENTIFIER = ^TCRYPT_ALGORITHM_IDENTIFIER;


  TCERT_SIGNED_CONTENT_INFO = record
    ToBeSigned          : TCRYPT_DER_BLOB;
    SignatureAlgorithm  : TCRYPT_ALGORITHM_IDENTIFIER;
    Signature           : TCRYPT_BIT_BLOB;
  end;
  PCERT_SIGNED_CONTENT_INFO = ^TCERT_SIGNED_CONTENT_INFO;

  TCERT_PUBLIC_KEY_INFO = record
    Algorithm : TCRYPT_ALGORITHM_IDENTIFIER;
    PublicKey : TCRYPT_BIT_BLOB;
  end;
  PCERT_PUBLIC_KEY_INFO = ^TCERT_PUBLIC_KEY_INFO;

  TCRYPT_ATTRIBUTE = record
    pszObjId : PChar;
    cValue   : LongWord;
    rgValue  : PCRYPT_ATTR_BLOB;
  end;
  PCRYPT_ATTRIBUTE = ^TCRYPT_ATTRIBUTE;

  TCERT_REQUEST_INFO = record
    dwVersion            : LongWord;
    Subject              : TCERT_NAME_BLOB;
    SubjectPublicKeyInfo : TCERT_PUBLIC_KEY_INFO;
    cAttribute           : LongWord;
    rgAttribute          : PCRYPT_ATTRIBUTE;
  end;
  PCERT_REQUEST_INFO = ^TCERT_REQUEST_INFO;

  TCERT_EXTENSION = record
    pszObjId : PChar;
    fCritical : BOOL;
    Value : TCRYPT_OBJID_BLOB;
  end;
  PCERT_EXTENSION = ^TCERT_EXTENSION;

  TCERT_INFO = record
    dwVersion            : LongWord;
    SerialNumber         : TCRYPT_INTEGER_BLOB;
    SignatureAlgorithm   : TCRYPT_ALGORITHM_IDENTIFIER;
    Issuer               : TCERT_NAME_BLOB;
    NotBefore            : FILETIME;
    NotAfter             : FILETIME;
    Subject              : TCERT_NAME_BLOB;
    SubjectPublicKeyInfo : TCERT_PUBLIC_KEY_INFO;
    IssuerUniqueId       : TCRYPT_BIT_BLOB;
    SubjectUniqueId      : TCRYPT_BIT_BLOB;
    cExtension           : LongWord;
    rgExtension          : PCERT_EXTENSION;
  end;
  PCERT_INFO = ^TCERT_INFO;

  HCERTSTORE = Pointer;
  PHCERTSTORE = ^HCERTSTORE;
  PBool = ^BOOL;

  TCERT_CONTEXT = record
    dwCertEncodingType  : LongWord;
    pbCertEncoded       : PChar;
    cbCertEncoded       : LongWord;
    pCertInfo           : PCERT_INFO;
    hCertStore          : HCERTSTORE;
  end;
  PCERT_CONTEXT = ^TCERT_CONTEXT;
  PCCERT_CONTEXT = PCERT_CONTEXT;
  PPCCERT_CONTEXT = ^PCCERT_CONTEXT;

  TCRL_ENTRY = record
    SerialNumber   : TCRYPT_INTEGER_BLOB;
    RevocationDate : FILETIME;
    cExtension     : LongWord;
    rgExtension    : PCERT_EXTENSION;
  end;
  PCRL_ENTRY = ^TCRL_ENTRY;

  TCRL_INFO = record
    dwVersion           : LongWord;
    SignatureAlgorithm  : TCRYPT_ALGORITHM_IDENTIFIER;
    Issuer              : TCERT_NAME_BLOB;
    ThisUpdate          : FILETIME;
    NextUpdate          : FILETIME;
    cCRLEntry           : LongWord;
    rgCRLEntry          : PCRL_ENTRY;
    cExtension          : LongWord;
    rgExtension         : PCERT_EXTENSION;
  end;
  PCRL_INFO = ^TCRL_INFO;

  TCRL_CONTEXT = record
    dwCertEncodingType  : LongWord;
    pbCrlEncoded        : PChar;
    cbCrlEncoded        : LongWord;
    pCrlInfo            : PCRL_INFO;
    hCertStore          : HCERTSTORE;
  end;
  PCRL_CONTEXT = ^TCRL_CONTEXT;
  PCCRL_CONTEXT = PCRL_CONTEXT;
  PPCCRL_CONTEXT = ^PCRL_CONTEXT;

  TCRYPT_SIGN_MESSAGE_PARA = record
    cbSize              : LongWord;
    dwMsgEncodingType   : LongWord;
    pSigningCert        : PCCERT_CONTEXT;
    HashAlgorithm       : TCRYPT_ALGORITHM_IDENTIFIER;
    pvHashAuxInfo       : Pointer;
    cMsgCert            : LongWord;
    rgpMsgCert          : PPCCERT_CONTEXT;
    cMsgCrl             : LongWord;
    rgpMsgCrl           : PPCCRL_CONTEXT;
    cAuthAttr           : longWord;
    rgAuthAttr          : PCRYPT_ATTRIBUTE;
    cUnauthAttr         : LongWord;
    rgUnauthAttr        : PCRYPT_ATTRIBUTE;
    dwFlags             : LongWord;
    dwInnerContentType  : LongWord;
// {$IFDEF CRYPT_SIGN_MESSAGE_PARA_HAS_CMS_FIELDS}
    HashEncryptionAlgorithm : TCRYPT_ALGORITHM_IDENTIFIER;
    pvHashEncryptionAuxInfo : Pointer;
// {$ENDIF}
  end;
  PCRYPT_SIGN_MESSAGE_PARA = ^TCRYPT_SIGN_MESSAGE_PARA;

  TCRYPT_VERIFY_MESSAGE_PARA = record
    cbSize                      : LongWord;
    dwMsgAndCertEncodingType    : LongWord;
    hCryptProv                  : HCRYPTPROV;
    pfnGetSignerCertificate     : Pointer; //PFN_CRYPT_GET_SIGNER_CERTIFICATE;
    pvGetArg                    : Pointer;
  end;
  PCRYPT_VERIFY_MESSAGE_PARA = ^TCRYPT_VERIFY_MESSAGE_PARA;

  TCRYPT_KEY_PROV_PARAM = record
    dwParam : LongWord;
    pbData  : PChar;
    cbData  : LongWord;
    dwFlags : LOngWord;
  end;
  PCRYPT_KEY_PROV_PARAM = ^TCRYPT_KEY_PROV_PARAM;

  TCRYPT_KEY_PROV_INFO = record
    pwszContainerName   : Pointer;
    pwszProvName        : Pointer;
    dwProvType          : LongWord;
    dwFlags             : LongWord;
    cProvParam          : LongWord;
    rgProvParam         : PCRYPT_KEY_PROV_PARAM;
    dwKeySpec           : LongWord;
  end;
  PCRYPT_KEY_PROV_INFO = ^TCRYPT_KEY_PROV_INFO;

  TCRYPT_ENCRYPT_MESSAGE_PARA = record
    cbSize                      : LongWord;
    dwMsgEncodingType           : LongWord;
    hCryptProv                  : HCRYPTPROV;
    ContentEncryptionAlgorithm  : TCRYPT_ALGORITHM_IDENTIFIER;
    pvEncryptionAuxInfo         : Pointer;
    dwFlags                     : LongWord;
    dwInnerContentType          : LongWord;
  end;
  PCRYPT_ENCRYPT_MESSAGE_PARA = ^TCRYPT_ENCRYPT_MESSAGE_PARA;

  TCRYPT_DECRYPT_MESSAGE_PARA = record
    cbSize                      : LongWord;
    dwMsgAndCertEncodingType    : LongWord;
    cCertStore                  : LongWord;
    rghCertStore                : PHCERTSTORE;
  end;
  PCRYPT_DECRYPT_MESSAGE_PARA = ^TCRYPT_DECRYPT_MESSAGE_PARA;

  TCERT_RDN_ATTR = record
    pszObjId : PChar;
    dwValueType : LongWord;
    Value : TCERT_RDN_VALUE_BLOB;
  end;
  PCERT_RDN_ATTR = ^TCERT_RDN_ATTR;

  TCERT_RDN = record
    cRDNAttr : LongWORD;
    rgRDNAttr: PCERT_RDN_ATTR;
  end;
  PCERT_RDN = ^TCERT_RDN;

  TCERT_NAME_INFO = record
    cRDN : LongWord;
    rgRDN: PCERT_RDN;
  end;
  PCERT_NAME_INFO = ^TCERT_NAME_INFO;

  TCERT_CHAIN_ENGINE_CONFIG = record
    cbSize: LongWord;
    hRestrictedRoot: HCERTSTORE;
    hRestrictedTrust: HCERTSTORE;
    hRestrictedOther: HCERTSTORE;
    cAdditionalStore: LongWord;
    rghAdditionalStore: PHCERTSTORE;
    dwFlags: LongWord;
    dwUrlRetrievalTimeout: LongWord;
    MaximumCachedCertificates: LongWord;
    CycleDetectionModulus: LongWord;
  end;
  PCERT_CHAIN_ENGINE_CONFIG = ^TCERT_CHAIN_ENGINE_CONFIG;

  HCERTCHAINENGINE = Pointer;
  PHCERTCHAINENGINE = ^HCERTCHAINENGINE;

  TCTL_USAGE = record
    cUsageIdentifier: LongWord;
    rgpszUsageIdentifier: Pointer;
  end;
  PCTL_USAGE = ^TCTL_USAGE;
  TCERT_ENHKEY_USAGE = TCTL_USAGE;
  PCERT_ENHKEY_USAGE = ^TCERT_ENHKEY_USAGE;

  TCERT_USAGE_MATCH = record
    dwType: LongWord;
    Usage: TCERT_ENHKEY_USAGE;
  end;
  PCERT_USAGE_MATCH = ^TCERT_USAGE_MATCH;

  TCERT_CHAIN_PARA = record
    cbSize: LongWord;
    RequestedUsage: TCERT_USAGE_MATCH;
  end;
  PCERT_CHAIN_PARA = ^TCERT_CHAIN_PARA;

  TCERT_TRUST_STATUS = record
    dwErrorStatus: LongWord;
    dwInfoStatus: LongWord;
  end;
  PCERT_TRUST_STATUS = ^TCERT_TRUST_STATUS;

  TCERT_REVOCATION_INFO = record
    cbSize: LongWord;
    dwRevocationResult: LongWord;
    pszRevocationOid: PChar;
    pvOidSpecificInfo: Pointer;
  end;
  PCERT_REVOCATION_INFO = ^TCERT_REVOCATION_INFO;

  TCERT_CHAIN_ELEMENT = record
    cbSize: LongWord;
    pCertContext: PCCERT_CONTEXT;
    TrustStatus: TCERT_TRUST_STATUS;
    pRevocationInfo: PCERT_REVOCATION_INFO;
  end;
  PCERT_CHAIN_ELEMENT = ^TCERT_CHAIN_ELEMENT;
  PPCERT_CHAIN_ELEMENT = ^PCERT_CHAIN_ELEMENT;

  TCTL_ENTRY = record
    SubjectIdentifier: TCRYPT_DATA_BLOB;          // For example, its hash
    cAttribute: LongWord;
    rgAttribute: PCRYPT_ATTRIBUTE;
  end;
  PCTL_ENTRY = ^TCTL_ENTRY;

  TCTL_INFO = record
    dwVersion: LongWord;
    SubjectUsage: TCTL_USAGE;
    ListIdentifier: TCRYPT_DATA_BLOB;     // OPTIONAL
    SequenceNumber: TCRYPT_INTEGER_BLOB;     // OPTIONAL
    ThisUpdate: FILETIME;
    NextUpdate: FILETIME;         // OPTIONAL
    SubjectAlgorithm: TCRYPT_ALGORITHM_IDENTIFIER;
    cCTLEntry: LongWord;
    rgCTLEntry: PCTL_ENTRY;         // OPTIONAL
    cExtension: LOngWord;
    rgExtension: PCERT_EXTENSION;        // OPTIONAL
  end;
  PCTL_INFO = ^TCTL_INFO;

  HCRYPTMSG = Pointer;

  TCTL_CONTEXT = record
    dwMsgAndCertEncodingType: LongWord;
    pbCtlEncoded: PChar;
    cbCtlEncoded: LongWord;
    pCtlInfo: PCTL_INFO;
    hCertStore: HCERTSTORE;
    hCryptMsg: HCRYPTMSG;
    pbCtlContent: PChar;
    cbCtlContent: LongWord;
  end;
  PCTL_CONTEXT = ^TCTL_CONTEXT;
  PCCTL_CONTEXT = ^TCTL_CONTEXT;

  TCERT_TRUST_LIST_INFO = record
    cbSize: LongWord;
    pCtlEntry: PCTL_ENTRY;
    pCtlContext: PCCTL_CONTEXT;
  end;
  PCERT_TRUST_LIST_INFO = ^TCERT_TRUST_LIST_INFO;

  TCERT_SIMPLE_CHAIN = record
    cbSize: LongWord;
    TrustStatus: TCERT_TRUST_STATUS;
    cElement: LongWord;
    rgpElement: PPCERT_CHAIN_ELEMENT;
    pTrustListInfo: PCERT_TRUST_LIST_INFO;
  end;
  PCERT_SIMPLE_CHAIN = ^TCERT_SIMPLE_CHAIN;
  PPCERT_SIMPLE_CHAIN = ^PCERT_SIMPLE_CHAIN;

  TCERT_CHAIN_CONTEXT = record
    cbSize: LongWord;
    TrustStatus: TCERT_TRUST_STATUS;
    cChain: LongWord;
    rgpChain: PPCERT_SIMPLE_CHAIN;
  end;
  PCERT_CHAIN_CONTEXT = ^TCERT_CHAIN_CONTEXT;
  PCCERT_CHAIN_CONTEXT = ^TCERT_CHAIN_CONTEXT;
  PPCCERT_CHAIN_CONTEXT = ^PCCERT_CHAIN_CONTEXT;

  //---------------------------------------------------
  {TCPAcquireContext = function(phProv: PHCRYPTPROV; pszContainer: PChar; dwFlags: LongWord; pVTable: PVTableProvStruc): BOOL; stdcall;
  TCPGetProvParam   = function(phProv: HCRYPTPROV; dwParam: LongWord; pbData: PChar; pdwDataLen: PDWord; dwFlags: LongWord): BOOL; stdcall;
  TCPReleaseContext = function(phProv: HCRYPTPROV; dwFlags: LOngWord): BOOL; stdcall;
  TCPSetProvParam   = function(phProv: HCRYPTPROV; dwParam: LongWord; pbData: PChar; dwFlags: LOngWord): BOOL; stdcall;}

  TCryptAcquireContext = function( phProv: PHCRYPTPROV; //*
                             pszContainer: PChar;
                              pszProvider: PChar;
                               dwProvType: LongWord;
                                  dwFlags: LongWord): BOOL; stdcall;
  TCryptGetProvParam   = function(phProv: HCRYPTPROV;
                                 dwParam: LongWord;
                                  pbData: PChar;
                              pdwDataLen: PDWord;
                                 dwFlags: LongWord): BOOL; stdcall;
  TCryptReleaseContext = function(phProv: HCRYPTPROV;
                                 dwFlags: LOngWord): BOOL; stdcall;
  TCryptSetProvParam   = function(phProv: HCRYPTPROV;
                                 dwParam: LongWord;
                                  pbData: PChar;
                                 dwFlags: LongWord): BOOL; stdcall;


  TCryptDeriveKey       = function(phProv: HCRYPTPROV;
                                    AlgId: ALG_ID;
                                hBaseData: HCRYPTHASH;
                                  dwFlags: LOngWord;
                                    phKey: PHCRYPTKEY): BOOL; stdcall;
  TCryptDestroyKey      = function(  hKey: HCRYPTKEY): BOOL; stdcall;
  TCryptDuplicateKey    = function(  hKey: HCRYPTKEY;
                              pdwReserved: PDWord;
                                  dwFlags: LongWord;
                                    phKey: PHCRYPTKEY): BOOL; stdcall;
  TCryptExportKey       = function(  hKey: HCRYPTKEY;
                                  hExpKey: HCRYPTKEY;
                               dwBlobType,
                                  dwFlags: LongWord;
                                   pbData: PChar;
                               pdwDataLen: PDword): BOOL; stdcall;
  TCryptGenKey          = function(phProv: HCRYPTPROV;
                                    AlgId: ALG_ID;
                                  dwFlags: LongWord;
                                    phKey: PHCRYPTKEY): BOOL; stdcall;
  TCryptGenRandom       = function(phProv: HCRYPTPROV;
                                    dwLen: PDWord;
                                 pbBuffer: PChar): BOOL; stdcall;
  TCryptGetKeyParam     = function(  hKey: HCRYPTKEY;
                                  dwParam: lOngWord;
                                   pbData: PChar;
                               pdwDataLen: PDword;
                                  dwFlags: LongWord): BOOL; stdcall;
  TCryptGetUserKey      = function(phProv: HCRYPTPROV;
                                dwKeySpec: LongWord;
                                phUserKey: PHCRYPTKEY): BOOL; stdcall;
  TCryptImportKey       = function(phProv: HCRYPTPROV;
                                   pbData: PChar;
                                dwDataLen: LongWord;
                                  hPubKey: HCRYPTKEY;
                                  dwFlags: LongWord;
                                    phKey: PHCRYPTKEY): BOOL; stdcall;
  TCryptSetKeyParam     = function(  hKey: HCRYPTKEY;
                                  dwParam: longWord;
                                   pbData: PChar;
                                  dwFlags: LongWord): BOOL; stdcall;

  TCryptDecrypt = function ( hKey: HCRYPTKEY;
                            hHash: HCRYPTHASH;
                            Final: BOOL;
                          dwFlags: LongWord;
                           pbData: PChar;
                       pdwDataLen: PDword): BOOL; stdcall;
  TCryptEncrypt = function (hKey : HCRYPTKEY;
                            hHash: HCRYPTHASH;
                            Final: BOOL;
                            dwFlags: LongWord;
                            pbData: PChar;
                            pdwDataLen: PDword;
                            dwBufLen: LongWord): BOOL; stdcall;



  TCryptCreateHash      = function (hProv: HCRYPTPROV;
                                    Algid: ALG_ID;
                                     hKey: HCRYPTKEY;
                                  dwFlags: LongWord;
                                   phHash: PHCRYPTHASH): BOOL; stdcall;
  TCryptDestroyHash     = function (hHash: HCRYPTHASH): BOOL; stdcall;
  TCryptDuplicateHash   = function (hHash: HCRYPTHASH;
                              pdwReserved: PDword;
                                  dwFlags: LongWord;
                                   phHash: PHCRYPTHASH): BOOL; stdcall;
  TCryptGetHashParam    = function (hHash: HCRYPTHASH;
                                  dwParam: LongWord;
                                   pbData: PChar;
                               pdwDataLen: PDword;
                                  dwFlags: LongWord): BOOL; stdcall;
  TCryptHashData        = function (hHash: HCRYPTHASH;
                                   pbData: PChar;
                                dwDataLen: LongWord;
                                  dwFlags: LongWord): BOOL; stdcall;
  TCryptHashSessionKey  = function (hHash: HCRYPTHASH;
                                     hKey: HCRYPTKEY;
                                  dwFlags: LongWord): BOOL; stdcall;
  TCryptSetHashParam    = function (hHash: HCRYPTHASH;
                                  dwParam: LongWord;
                                   pbData: PChar;
                                  dwFlags: LongWord): BOOL; stdcall;
  TCryptSignHash        = function (hHash: HCRYPTHASH;
                                dwKeySpec: LongWord;
                             sDescription: PWideChar;
                                  dwFlags: LongWord;
                              pbSignature: PChar;
                                pdwSigLen: PDword): BOOL; stdcall;
  TCryptVerifySignature = function (hHash: HCRYPTHASH;
                              pbSignature: PChar;
                                 dwSigLen: LongWord;
                                  hPubKey: HCRYPTKEY;
                             sDescription: PWideChar;
                                  dwFlags: LongWord): BOOL; stdcall;
  // ---------- from crypt32.dll
  TCryptDecodeObject = function ( dwCertEncodingType: LongWord;
                                      lpszStructType: PChar;
                                     const pbEncoded: PChar;
                                           cbEncoded: LongWord;
                                             dwFlags: LongWord;
                                        pvStructInfo: Pointer;
                                       pcbStructInfo: PDword
                                                   ): BOOL; stdcall;
  TCryptEncodeObject = function ( dwCertEncodingType: LongWord;
                                      lpszStructType: PChar;
                                  const pvStructInfo: Pointer;
                                           pbEncoded: PChar;
                                          pcbEncoded: PDWord
                                                   ): BOOL; stdcall;

  TCryptVerifyCertificateSignature = function( hCryptProv : HCRYPTPROV;
                                       dwCertEncodingType : LongWord;
                                                pbEncoded : PChar;
                                                cbEncoded : LongWord;
                                               pPublicKey : PCERT_PUBLIC_KEY_INFO
                                                         ): BOOL; stdcall;

  TCertFreeCertificateContext = function(pCertContext : PCCERT_CONTEXT): BOOL; stdcall;

  TCertOpenStore = function(lpszStoreProvider        : PChar;
                            dwMsgAndCertEncodingType : LongWord;
                            hCryptProv               : HCRYPTPROV;
                            dwFlags                  : LongWord;
                            pvPara                   : Pointer
                                                    ): HCERTSTORE; stdcall;
  TCertEnumCertificatesInStore = function(hCertStore: HCERTSTORE;
                                     pPrevCertContext: PCCERT_CONTEXT): PCCERT_CONTEXT; stdcall;

  TCertSetCertificateContextProperty = function(pCertContext : PCCERT_CONTEXT;
                                                    dwPropId : LongWord;
                                                     dwFlags : LongWord;
                                                 const pvData: Pointer
                                                            ): BOOL; stdcall;
  TCertGetCertificateContextProperty = function(pCertContext : PCCERT_CONTEXT;
                                                    dwPropId : LongWord;
                                                      pvData : Pointer;
                                                     pcbData : PDword
                                                            ): BOOL; stdcall;
  TCryptSignMessage = function( pSignPara : PCRYPT_SIGN_MESSAGE_PARA;
                       fDetachedSignature : Bool;
                              cToBeSigned : LongWord;
                      const rgpbToBeSigned: Pointer;
                           rgcbToBeSigned : Pointer;
                             pbSignedBlob : Pointer;
                            pcbSignedBlob : PDword): BOOL; stdcall;

  TCryptVerifyMessageSignature = function( pVerifyPara : PCRYPT_VERIFY_MESSAGE_PARA;
                                         dwSignerIndex : LongWord;
                                    const pbSignedBlob : PChar;
                                          cbSignedBlob : LongWord;
                                             pbDecoded : PChar;
                                            pcbDecoded : PDword;
                                          ppSignerCert : PPCCERT_CONTEXT
                                                      ): BOOL; stdcall;
  TCryptVerifyDetachedMessageSignature = function( pVerifyPara : PCRYPT_VERIFY_MESSAGE_PARA;
                                                 dwSignerIndex : LongWord;
                                            pbDetachedSignBlob : PChar;
                                            cbDetachedSignBlob : LongWord;
                                                   cToBeSigned : LongWord;
                                                rgpbToBeSigned : Pointer;
                                                rgcbToBeSigned : Pointer;
                                                  ppSignerCert : PPCCERT_CONTEXT
                                                      ): BOOL; stdcall;

  TCryptAcquireCertificatePrivateKey = function( pCert : PCCERT_CONTEXT;
                                               dwFlags : LongWord;
                                            pvReserved : Pointer;
                                           phCryptProv : PHCRYPTPROV;
                                            pdwKeySpec : PDword;
                                      pfCallerFreeProv : PBool
                                                      ): BOOL; stdcall;

  TCryptEncryptMessage = function( pEncryptPara : PCRYPT_ENCRYPT_MESSAGE_PARA;
                                 cRecipientCert : LongWord;
                               rgpRecipientCert : PPCCERT_CONTEXT;
                          const pbToBeEncrypted : PChar;
                                cbToBeEncrypted : longWord;
                                pbEncryptedBlob : PChar;
                               pcbEncryptedBlob : PDword
                                               ): BOOL; stdcall;

  TCertAddCertificateContextToStore = function(hCertStore : HCERTSTORE;
                                             pCertContext : PCCERT_CONTEXT;
                                         dwAddDisposition : LongWord;
                                           ppStoreContext : PPCCERT_CONTEXT
                                                         ): BOOL; stdcall;

  TCryptDecryptMessage = function( pDecryptPara : PCRYPT_DECRYPT_MESSAGE_PARA;
                          const pbEncryptedBlob : PChar;
                                cbEncryptedBlob : longWord;
                                    pbDecrypted : PChar;
                                   pcbDecrypted : PDword;
                                     ppXchgCert : PPCCERT_CONTEXT
                                               ): BOOL; stdcall;

  TCertFindCertificateInStore = function(hCertStore : HCERTSTORE;
                                 dwCertEncodingType : LongWord;
                                        dwFindFlags : LongWord;
                                         dwFindType : LongWord;
                                   const pvFindPara : PWideChar;
                                   pPrevCertContext : PCCERT_CONTEXT
                                                   ): PCCERT_CONTEXT; stdcall;
  TCertCloseStore = function( hCertStore : HCERTSTORE;
                                 dwFlags : LongWord
                                        ): BOOL; stdcall;

  TCertCreateCertificateContext = function( dwCertEncodingType : lOngWord;
                                           const pbCertEncoded : PChar;
                                                 cbCertEncoded : LongWord
                                                              ): PCCERT_CONTEXT; stdcall;

  TCertOpenSystemStore = function( hProv : HCRYPTPROV;
                      szSubsystemProtocol: PWideChar
                                        ): HCERTSTORE; stdcall;

  TCertGetStoreProperty = function( hCertStore: HCERTSTORE;
                                      dwPropId: LongWord;
                                        pvData: Pointer;
                                       pcbData: PDword
                                             ): BOOL; stdcall;
  TCertSetStoreProperty =  function (hCertStor: HCERTSTORE;
                                      dwPropId: LongWord;
                                       dwFlags: LongWord;
                                        pvData: Pointer): BOOL; stdcall;

  TCryptExportPublicKeyInfo = function( hCryptProv : HCRYPTPROV;
                                         dwKeySpec : LongWord;
                                dwCertEncodingType : LongWord;
                                             pInfo : PCERT_PUBLIC_KEY_INFO;
                                           pcbInfo : PDword): BOOL; stdcall;

  TCryptSignAndEncodeCertificate = function(hCryptProv : HCRYPTPROV;
                                             dwKeySpec : LongWord;
                                    dwCertEncodingType : LongWord;
                                        lpszStructType : PChar;       // "to be signed"
                                    const pvStructInfo : Pointer;
                                   pSignatureAlgorithm : PCRYPT_ALGORITHM_IDENTIFIER;
                                   const pvHashAuxInfo : Pointer;
                                             pbEncoded : PChar;
                                            pcbEncoded : PDWord): BOOL; stdcall;
  TCertDuplicateCertificateContext = function(aCertContext: PCCERT_CONTEXT): PCCERT_CONTEXT; stdcall;
  TCertDuplicateStore = function(hCertStore: HCERTSTORE): HCERTSTORE; stdcall;

  TCertCreateCertificateChainEngine = function(pConfig: PCERT_CHAIN_ENGINE_CONFIG; phChainEngine: PHCERTCHAINENGINE): BOOL; stdcall;
  TCertGetCertificateChain = function(hChainEngine: HCERTCHAINENGINE;
                                      pCertContext: PCCERT_CONTEXT;
                                      pTime: Pointer;
                                      hAdditionalStore: HCERTSTORE;
                                      pChainPara: PCERT_CHAIN_PARA;
                                      dwFlags: LongWord;
                                      pvReserved: Pointer;
                                      ppChainContext: PPCCERT_CHAIN_CONTEXT): BOOL; stdcall;
  TCertFreeCertificateChainEngine = procedure(hChainEngine: HCERTCHAINENGINE); stdcall;
  TCertDeleteCertificateFromStore = function(pCertContext: PCCERT_CONTEXT): BOOL; stdcall;
  TCertSaveStore = function(hCertStore: HCERTSTORE;
                            dwMsgAndCertEncodingType: LongWord;
                            dwSaveAs: LongWord;
                            dwSaveTo: LongWord;
                            pvSaveToPara: Pointer;
                            dwFlags: LongWord): BOOL; stdcall;
  TCryptGetMessageCertificates = function(dwMsgAndCertEncodingType: LongWord;
                                          hCryptProv: HCRYPTPROV;
                                          dwFlags: LongWord;
                                          pbSignedBlob: Pointer;
                                          cbSignedBlob: LongWord
                                        ): HCERTSTORE; stdcall;

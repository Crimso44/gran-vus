// Константы и типы данных Crypto-Pro, Ms Crypto API

{
 * Copyright(C) 2000 Проект ИОК
 *
 * Этот файл содержит информацию, являющуюся
 * собственностью компании Крипто Про.
 *
 * Любая часть этого файла не может быть скопирована,
 * исправлена, переведена на другие языки,
 * локализована или модифицирована любым способом,
 * откомпилирована, передана по сети с или на
 * любую компьютерную систему без предварительного
 * заключения соглашения с компанией Крипто Про.

}

Const

 PROV_GOST_DH     =       2;

// Описатели пользовательских ключей
 AT_KEYEXCHANGE   =       1;
 AT_SIGNATURE     =       2;

 // *******************************************************
 // copy from wincrypt.h, and over Ms Visual Studio Headers
   PROV_RSA_FULL                   = 1;
   CRYPT_MACHINE_DEFAULT           = $00000001;

   ALG_CLASS_ANY                   = 0;
   ALG_CLASS_SIGNATURE             = 1 shl 13;
   ALG_CLASS_MSG_ENCRYPT           = 2 shl 13;
   ALG_CLASS_DATA_ENCRYPT          = 3 shl 13;
   ALG_CLASS_HASH                  = 4 shl 13;
   ALG_CLASS_KEY_EXCHANGE          = 5 shl 13;

   ALG_TYPE_ANY                    = 0;
   ALG_TYPE_DSS                    = 1 shl 9;
   ALG_TYPE_RSA                    = 2 shl 9;
   ALG_TYPE_BLOCK                  = 3 shl 9;
   ALG_TYPE_STREAM                 = 4 shl 9;
   ALG_TYPE_DH                     = 5 shl 9;
   ALG_TYPE_SECURECHANNEL          = 6 shl 9;

   CRYPT_VERIFYCONTEXT             = $F0000000;
   CRYPT_NEWKEYSET                 = $00000008;
   CRYPT_DELETEKEYSET              = $00000010;
   CRYPT_MACHINE_KEYSET            = $00000020;

   PP_ENUMALGS             =  1;
   PP_ENUMCONTAINERS       =  2;
   PP_IMPTYPE              =  3;
   PP_NAME                 =  4;
   PP_VERSION              =  5;
   PP_CONTAINER            =  6;
   PP_CHANGE_PASSWORD      =  7;
   PP_KEYSET_SEC_DESCR     =  8;       // get/set security descriptor of keyset
   PP_CERTCHAIN            =  9;       // for retrieving certificates from tokens
   PP_KEY_TYPE_SUBTYPE     = 10;
   PP_PROVTYPE             = 16;
   PP_KEYSTORAGE           = 17;
   PP_APPLI_CERT           = 18;
   PP_SYM_KEYSIZE          = 19;
   PP_SESSION_KEYSIZE      = 20;
   PP_UI_PROMPT            = 21;
   PP_ENUMALGS_EX          = 22;

   MAX_PATH                = 256;

   CRYPT_FIRST             = 1;
   CRYPT_NEXT              = 2;

   SIMPLEBLOB              = $1;
   PUBLICKEYBLOB           = $6;
   PRIVATEKEYBLOB          = $7;

   CRYPT_EXPORTABLE        = $00000001;
   CRYPT_USER_PROTECTED    = $00000002;
   CRYPT_CREATE_SALT       = $00000004;
   CRYPT_UPDATE_KEY        = $00000008;
   CRYPT_NO_SALT           = $00000010;
   CRYPT_PREGEN            = $00000040;
   CRYPT_RECIPIENT         = $00000010;
   CRYPT_INITIATOR         = $00000040;
   CRYPT_ONLINE            = $00000080;
   CRYPT_SF                = $00000100;
   CRYPT_CREATE_IV         = $00000200;
   CRYPT_KEK               = $00000400;
   CRYPT_DATA_KEY          = $00000800;

   CRYPT_DECODE_NOCOPY_FLAG = $1;

   CRYPT_ENCODE_DECODE_NONE            = 0;
   X509_CERT                           = 1;
   X509_CERT_TO_BE_SIGNED              = 2;
   X509_CERT_CRL_TO_BE_SIGNED          = 3;
   X509_CERT_REQUEST_TO_BE_SIGNED      = 4;
   X509_EXTENSIONS                     = 5;
   X509_NAME_VALUE                     = 6;
   X509_NAME                           = 7;
   X509_PUBLIC_KEY_INFO                = 8;

  //+-------------------------------------------------------------------------
  //  Predefined X509 certificate extension data structures that can be
  //  encoded / decoded.
  //--------------------------------------------------------------------------
   X509_AUTHORITY_KEY_ID               = 9;
   X509_KEY_ATTRIBUTES                 = 10;
   X509_KEY_USAGE_RESTRICTION          = 11;
   X509_ALTERNATE_NAME                 = 12;
   X509_BASIC_CONSTRAINTS              = 13;
   X509_KEY_USAGE                      = 14;
   X509_BASIC_CONSTRAINTS2             = 15;
   X509_CERT_POLICIES                  = 16;

  //+-------------------------------------------------------------------------
  //  Additional predefined data structures that can be encoded / decoded.
  //--------------------------------------------------------------------------
   PKCS_UTC_TIME                       = 17;
   PKCS_TIME_REQUEST                   = 18;
   RSA_CSP_PUBLICKEYBLOB               = 19;
   X509_UNICODE_NAME                   = 20;

   X509_KEYGEN_REQUEST_TO_BE_SIGNED    = 21;
   PKCS_ATTRIBUTE                      = 22;
   PKCS_CONTENT_INFO_SEQUENCE_OF_ANY   = 23;

  //+-------------------------------------------------------------------------
  //  Predefined primitive data structures that can be encoded / decoded.
  //--------------------------------------------------------------------------
   X509_UNICODE_NAME_VALUE             = 24;
   X509_ANY_STRING                     = X509_NAME_VALUE;
   X509_UNICODE_ANY_STRING             = X509_UNICODE_NAME_VALUE;
   X509_OCTET_STRING                   = 25;
   X509_BITS                           = 26;
   X509_INTEGER                        = 27;
   X509_MULTI_BYTE_INTEGER             = 28;
   X509_ENUMERATED                     = 29;
   X509_CHOICE_OF_TIME                 = 30;

  //+-------------------------------------------------------------------------
  //  More predefined X509 certificate extension data structures that can be
  //  encoded / decoded.
  //--------------------------------------------------------------------------
   X509_AUTHORITY_KEY_ID2              = 31;
  // X509_AUTHORITY_INFO_ACCESS          = 32;
   X509_CRL_REASON_CODE                = X509_ENUMERATED;
   PKCS_CONTENT_INFO                   = 33;
   X509_SEQUENCE_OF_ANY                = 34;
   X509_CRL_DIST_POINTS                = 35;
   X509_ENHANCED_KEY_USAGE             = 36;
   PKCS_CTL                            = 37;

   X509_MULTI_BYTE_UINT                = 38;
   X509_DSS_PUBLICKEY                  = X509_MULTI_BYTE_UINT;
   X509_DSS_PARAMETERS                 = 39;
   X509_DSS_SIGNATURE                  = 40;
   PKCS_RC2_CBC_PARAMETERS             = 41;
   PKCS_SMIME_CAPABILITIES             = 42;


  //+-------------------------------------------------------------------------
  //  Predefined PKCS #7 data structures that can be encoded / decoded.
  //--------------------------------------------------------------------------
   PKCS7_SIGNER_INFO                   = 500;

   CRYPT_ASN_ENCODING          = $00000001;
   CRYPT_NDR_ENCODING          = $00000002;
   X509_ASN_ENCODING           = $00000001;
   X509_NDR_ENCODING           = $00000002;
   PKCS_7_ASN_ENCODING         = $00010000;
   PKCS_7_NDR_ENCODING         = $00020000;

   CERT_STORE_PROV_MSG                 = 1;
   CERT_STORE_PROV_MEMORY              = 2;
   CERT_STORE_PROV_FILE                = 3;
   CERT_STORE_PROV_REG                 = 4;

   CERT_STORE_PROV_PKCS7               = 5;
   CERT_STORE_PROV_SERIALIZED          = 6;
   CERT_STORE_PROV_FILENAME_A          = 7;
   CERT_STORE_PROV_FILENAME_W          = 8;
   CERT_STORE_PROV_FILENAME            = CERT_STORE_PROV_FILENAME_W;
   CERT_STORE_PROV_SYSTEM_A            = 9;
   CERT_STORE_PROV_SYSTEM_W            = 10;
   CERT_STORE_PROV_SYSTEM              = CERT_STORE_PROV_SYSTEM_W;

  //+-------------------------------------------------------------------------
  //  Certificate Store open/property flags
  //--------------------------------------------------------------------------
   CERT_STORE_NO_CRYPT_RELEASE_FLAG                = $00000001;
   CERT_STORE_SET_LOCALIZED_NAME_FLAG              = $00000002;
   CERT_STORE_DEFER_CLOSE_UNTIL_LAST_FREE_FLAG     = $00000004;
   CERT_STORE_DELETE_FLAG                          = $00000010;
   CERT_STORE_SHARE_STORE_FLAG                     = $00000040;
   CERT_STORE_SHARE_CONTEXT_FLAG                   = $00000080;
   CERT_STORE_MANIFOLD_FLAG                        = $00000100;
   CERT_STORE_ENUM_ARCHIVED_FLAG                   = $00000200;
   CERT_STORE_UPDATE_KEYID_FLAG                    = $00000400;
   CERT_STORE_BACKUP_RESTORE_FLAG                  = $00000800;
   CERT_STORE_READONLY_FLAG                        = $00008000;
   CERT_STORE_OPEN_EXISTING_FLAG                   = $00004000;
   CERT_STORE_CREATE_NEW_FLAG                      = $00002000;
   CERT_STORE_MAXIMUM_ALLOWED_FLAG                 = $00001000;

   sz_CERT_STORE_PROV_MEMORY           = 'Memory';
   sz_CERT_STORE_PROV_FILENAME_W       = 'File';
   sz_CERT_STORE_PROV_FILENAME         = sz_CERT_STORE_PROV_FILENAME_W;
   sz_CERT_STORE_PROV_SYSTEM_W         = 'System';
   sz_CERT_STORE_PROV_SYSTEM           = sz_CERT_STORE_PROV_SYSTEM_W;
   sz_CERT_STORE_PROV_PKCS7            = 'PKCS7';
   sz_CERT_STORE_PROV_SERIALIZED       = 'Serialized';

  //+-------------------------------------------------------------------------
  //  Certificate Store verify/results flags
  //--------------------------------------------------------------------------
   CERT_STORE_SIGNATURE_FLAG           = $00000001;
   CERT_STORE_TIME_VALIDITY_FLAG       = $00000002;
   CERT_STORE_REVOCATION_FLAG          = $00000004;
   CERT_STORE_NO_CRL_FLAG              = $00010000;
   CERT_STORE_NO_ISSUER_FLAG           = $00020000;

  //+-------------------------------------------------------------------------
  //  Certificate Store Provider flags are in the HiWord (= $FFFF0000;
  //--------------------------------------------------------------------------

  //+-------------------------------------------------------------------------
  //  Certificate System Store Flag Values
  //--------------------------------------------------------------------------
  // Location of the system store in the registry:
  //  HKEY_CURRENT_USER or HKEY_LOCAL_MACHINE
   CERT_SYSTEM_STORE_LOCATION_MASK         = $00030000;
   CERT_SYSTEM_STORE_CURRENT_USER          = $00010000;
   CERT_SYSTEM_STORE_LOCAL_MACHINE         = $00020000;

   CERT_COMPARE_MASK           = $FFFF;
   CERT_COMPARE_SHIFT          = 16;
   CERT_COMPARE_ANY            = 0;
   CERT_COMPARE_SHA1_HASH      = 1;
   CERT_COMPARE_NAME           = 2;
   CERT_COMPARE_ATTR           = 3;
   CERT_COMPARE_MD5_HASH       = 4;
   CERT_COMPARE_PROPERTY       = 5;
   CERT_COMPARE_PUBLIC_KEY     = 6;
   CERT_COMPARE_HASH           = CERT_COMPARE_SHA1_HASH;
   CERT_COMPARE_NAME_STR_A     = 7;
   CERT_COMPARE_NAME_STR_W     = 8;
   CERT_COMPARE_KEY_SPEC       = 9;
   CERT_COMPARE_ENHKEY_USAGE   = 10;
   CERT_COMPARE_CTL_USAGE      = CERT_COMPARE_ENHKEY_USAGE;

   CERT_INFO_VERSION_FLAG                      = 1;
   CERT_INFO_SERIAL_NUMBER_FLAG                = 2;
   CERT_INFO_SIGNATURE_ALGORITHM_FLAG          = 3;
   CERT_INFO_ISSUER_FLAG                       = 4;
   CERT_INFO_NOT_BEFORE_FLAG                   = 5;
   CERT_INFO_NOT_AFTER_FLAG                    = 6;
   CERT_INFO_SUBJECT_FLAG                      = 7;
   CERT_INFO_SUBJECT_PUBLIC_KEY_INFO_FLAG      = 8;
   CERT_INFO_ISSUER_UNIQUE_ID_FLAG             = 9;
   CERT_INFO_SUBJECT_UNIQUE_ID_FLAG            = 10;
   CERT_INFO_EXTENSION_FLAG                    = 11;

   CERT_FIND_ANY           = CERT_COMPARE_ANY shl CERT_COMPARE_SHIFT;
   CERT_FIND_SHA1_HASH     = CERT_COMPARE_SHA1_HASH shl CERT_COMPARE_SHIFT;
   CERT_FIND_MD5_HASH      = CERT_COMPARE_MD5_HASH shl CERT_COMPARE_SHIFT;
   CERT_FIND_HASH          = CERT_FIND_SHA1_HASH;
   CERT_FIND_PROPERTY      = CERT_COMPARE_PROPERTY shl CERT_COMPARE_SHIFT;
   CERT_FIND_PUBLIC_KEY    = CERT_COMPARE_PUBLIC_KEY shl CERT_COMPARE_SHIFT;
   CERT_FIND_SUBJECT_NAME  = (CERT_COMPARE_NAME shl CERT_COMPARE_SHIFT) Or CERT_INFO_SUBJECT_FLAG;
   CERT_FIND_SUBJECT_ATTR  = (CERT_COMPARE_ATTR shl CERT_COMPARE_SHIFT) Or CERT_INFO_SUBJECT_FLAG;
   CERT_FIND_ISSUER_NAME   = (CERT_COMPARE_NAME shl CERT_COMPARE_SHIFT) Or CERT_INFO_ISSUER_FLAG;
   CERT_FIND_ISSUER_ATTR   = (CERT_COMPARE_ATTR shl CERT_COMPARE_SHIFT) Or CERT_INFO_ISSUER_FLAG;
   CERT_FIND_SUBJECT_STR_A = (CERT_COMPARE_NAME_STR_A shl CERT_COMPARE_SHIFT) Or CERT_INFO_SUBJECT_FLAG;
   CERT_FIND_SUBJECT_STR_W = (CERT_COMPARE_NAME_STR_W shl CERT_COMPARE_SHIFT) Or CERT_INFO_SUBJECT_FLAG;
   CERT_FIND_SUBJECT_STR   = CERT_FIND_SUBJECT_STR_W;
   CERT_FIND_ISSUER_STR_A  = (CERT_COMPARE_NAME_STR_A shl CERT_COMPARE_SHIFT) Or CERT_INFO_ISSUER_FLAG;
   CERT_FIND_ISSUER_STR_W  = (CERT_COMPARE_NAME_STR_W shl CERT_COMPARE_SHIFT) Or CERT_INFO_ISSUER_FLAG;
   CERT_FIND_ISSUER_STR    = CERT_FIND_ISSUER_STR_W;
   CERT_FIND_KEY_SPEC      = CERT_COMPARE_KEY_SPEC Or CERT_COMPARE_SHIFT;
   CERT_FIND_ENHKEY_USAGE  = CERT_COMPARE_ENHKEY_USAGE Or CERT_COMPARE_SHIFT;
   CERT_FIND_CTL_USAGE     = CERT_FIND_ENHKEY_USAGE;

   CRYPT_E_NOT_FOUND       = $80092004;
   E_INVALIDARG            = $80070057;
   CERT_STORE_LOCALIZED_NAME_PROP_ID   = $1000;

   CERT_KEY_PROV_HANDLE_PROP_ID        = 1;
   CERT_KEY_PROV_INFO_PROP_ID          = 2;
   CERT_SHA1_HASH_PROP_ID              = 3;
   CERT_MD5_HASH_PROP_ID               = 4;
   CERT_HASH_PROP_ID                   = CERT_SHA1_HASH_PROP_ID;
   CERT_KEY_CONTEXT_PROP_ID            = 5;
   CERT_KEY_SPEC_PROP_ID               = 6;
   CERT_IE30_RESERVED_PROP_ID          = 7;
   CERT_PUBKEY_HASH_RESERVED_PROP_ID   = 8;
   CERT_ENHKEY_USAGE_PROP_ID           = 9;
   CERT_CTL_USAGE_PROP_ID              = CERT_ENHKEY_USAGE_PROP_ID;
   CERT_NEXT_UPDATE_LOCATION_PROP_ID   = 10;
   CERT_FRIENDLY_NAME_PROP_ID          = 11;
   CERT_PVK_FILE_PROP_ID               = 12;
   CERT_DESCRIPTION_PROP_ID            = 13;
   CERT_ACCESS_STATE_PROP_ID           = 14;
   CERT_SIGNATURE_HASH_PROP_ID         = 15;
   CERT_SMART_CARD_DATA_PROP_ID        = 16;
   CERT_EFS_PROP_ID                    = 17;
   CERT_FORTEZZA_DATA_PROP_ID          = 18;
   CERT_ARCHIVED_PROP_ID               = 19;
   CERT_KEY_IDENTIFIER_PROP_ID         = 20;
   CERT_AUTO_ENROLL_PROP_ID            = 21;
   CERT_PUBKEY_ALG_PARA_PROP_ID        = 22;
   CERT_CROSS_CERT_DIST_POINTS_PROP_ID = 23;
   CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID     = 24;
   CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID    = 25;
   CERT_ENROLLMENT_PROP_ID             = 26;
   CERT_DATE_STAMP_PROP_ID             = 27;
   CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID  = 28;
   CERT_SUBJECT_NAME_MD5_HASH_PROP_ID  = 29;
   CERT_EXTENDED_ERROR_INFO_PROP_ID    = 30;

   CERT_FIRST_RESERVED_PROP_ID         = 31;
// Note, 32 - 35 are reserved for the CERT, CRL, CTL and KeyId file element IDs.
   CERT_LAST_RESERVED_PROP_ID          = $00007FFF;
   CERT_FIRST_USER_PROP_ID             = $00008000;
   CERT_LAST_USER_PROP_ID              = $0000FFFF;

   CERT_SET_KEY_PROV_HANDLE_PROP_ID    = $00000001;
   CERT_SET_KEY_CONTEXT_PROP_ID        = $00000001;

   szOID_RSA               = '1.2.840.113549';
   szOID_PKCS              = '1.2.840.113549.1';
   szOID_RSA_HASH          = '1.2.840.113549.2';
   szOID_RSA_ENCRYPT       = '1.2.840.113549.3';

   szOID_PKCS_1            = '1.2.840.113549.1.1';
   szOID_PKCS_2            = '1.2.840.113549.1.2';
   szOID_PKCS_3            = '1.2.840.113549.1.3';
   szOID_PKCS_4            = '1.2.840.113549.1.4';
   szOID_PKCS_5            = '1.2.840.113549.1.5';
   szOID_PKCS_6            = '1.2.840.113549.1.6';
   szOID_PKCS_7            = '1.2.840.113549.1.7';
   szOID_PKCS_8            = '1.2.840.113549.1.8';
   szOID_PKCS_9            = '1.2.840.113549.1.9';
   szOID_PKCS_10           = '1.2.840.113549.1.10';
   szOID_PKCS_12           = '1.2.840.113549.1.12';

   szOID_RSA_RSA           = '1.2.840.113549.1.1.1';
   szOID_RSA_MD2RSA        = '1.2.840.113549.1.1.2';
   szOID_RSA_MD4RSA        = '1.2.840.113549.1.1.3';
   szOID_RSA_MD5RSA        = '1.2.840.113549.1.1.4';
   szOID_RSA_SHA1RSA       = '1.2.840.113549.1.1.5';
   szOID_RSA_SETOAEP_RSA   = '1.2.840.113549.1.1.6';

   szOID_RSA_DH            = '1.2.840.113549.1.3.1';

   szOID_RSA_data          = '1.2.840.113549.1.7.1';
   szOID_RSA_signedData    = '1.2.840.113549.1.7.2';
   szOID_RSA_envelopedData = '1.2.840.113549.1.7.3';
   szOID_RSA_signEnvData   = '1.2.840.113549.1.7.4';
   szOID_RSA_digestedData  = '1.2.840.113549.1.7.5';
   szOID_RSA_hashedData    = '1.2.840.113549.1.7.5';
   szOID_RSA_encryptedData = '1.2.840.113549.1.7.6';

   szOID_RSA_emailAddr     = '1.2.840.113549.1.9.1';
   szOID_RSA_unstructName  = '1.2.840.113549.1.9.2';
   szOID_RSA_contentType   = '1.2.840.113549.1.9.3';
   szOID_RSA_messageDigest = '1.2.840.113549.1.9.4';
   szOID_RSA_signingTime   = '1.2.840.113549.1.9.5';
   szOID_RSA_counterSign   = '1.2.840.113549.1.9.6';
   szOID_RSA_challengePwd  = '1.2.840.113549.1.9.7';
   szOID_RSA_unstructAddr  = '1.2.840.113549.1.9.8';
   szOID_RSA_extCertAttrs  = '1.2.840.113549.1.9.9';
   szOID_RSA_certExtensions = '1.2.840.113549.1.9.14';
   szOID_RSA_SMIMECapabilities = '1.2.840.113549.1.9.15';
   szOID_RSA_preferSignedData = '1.2.840.113549.1.9.15.1';

   szOID_RSA_SMIMEalg              = '1.2.840.113549.1.9.16.3';
   szOID_RSA_SMIMEalgESDH          = '1.2.840.113549.1.9.16.3.5';
   szOID_RSA_SMIMEalgCMS3DESwrap   = '1.2.840.113549.1.9.16.3.6';
   szOID_RSA_SMIMEalgCMSRC2wrap    = '1.2.840.113549.1.9.16.3.7';

   szOID_RSA_MD2           = '1.2.840.113549.2.2';
   szOID_RSA_MD4           = '1.2.840.113549.2.4';
   szOID_RSA_MD5           = '1.2.840.113549.2.5';

   szOID_RSA_RC2CBC        = '1.2.840.113549.3.2';
   szOID_RSA_RC4           = '1.2.840.113549.3.4';
   szOID_RSA_DES_EDE3_CBC  = '1.2.840.113549.3.7';
   szOID_RSA_RC5_CBCPad    = '1.2.840.113549.3.9';


   szOID_ANSI_X942         = '1.2.840.10046';
   szOID_ANSI_X942_DH      = '1.2.840.10046.2.1';

   szOID_X957              = '1.2.840.10040';
   szOID_X957_DSA          = '1.2.840.10040.4.1';
   szOID_X957_SHA1DSA      = '1.2.840.10040.4.3';

   // NIST OSE Implementors' Workshop (OIW) Security SIG algorithm identifiers
   szOID_OIWSEC             = '1.3.14.3.2';
   szOID_OIWSEC_md4RSA      = '1.3.14.3.2.2';
   szOID_OIWSEC_md5RSA      = '1.3.14.3.2.3';
   szOID_OIWSEC_md4RSA2     = '1.3.14.3.2.4';
   szOID_OIWSEC_desECB      = '1.3.14.3.2.6';
   szOID_OIWSEC_desCBC      = '1.3.14.3.2.7';
   szOID_OIWSEC_desOFB      = '1.3.14.3.2.8';
   szOID_OIWSEC_desCFB      = '1.3.14.3.2.9';
   szOID_OIWSEC_desMAC      = '1.3.14.3.2.10';
   szOID_OIWSEC_rsaSign     = '1.3.14.3.2.11';
   szOID_OIWSEC_dsa         = '1.3.14.3.2.12';
   szOID_OIWSEC_shaDSA      = '1.3.14.3.2.13';
   szOID_OIWSEC_mdc2RSA     = '1.3.14.3.2.14';
   szOID_OIWSEC_shaRSA      = '1.3.14.3.2.15';
   szOID_OIWSEC_dhCommMod   = '1.3.14.3.2.16';
   szOID_OIWSEC_desEDE      = '1.3.14.3.2.17';
   szOID_OIWSEC_sha         = '1.3.14.3.2.18';
   szOID_OIWSEC_mdc2        = '1.3.14.3.2.19';
   szOID_OIWSEC_dsaComm     = '1.3.14.3.2.20';
   szOID_OIWSEC_dsaCommSHA  = '1.3.14.3.2.21';
   szOID_OIWSEC_rsaXchg     = '1.3.14.3.2.22';
   szOID_OIWSEC_keyHashSeal = '1.3.14.3.2.23';
   szOID_OIWSEC_md2RSASign  = '1.3.14.3.2.24';
   szOID_OIWSEC_md5RSASign  = '1.3.14.3.2.25';
   szOID_OIWSEC_sha1        = '1.3.14.3.2.26';
   szOID_OIWSEC_dsaSHA1     = '1.3.14.3.2.27';
   szOID_OIWSEC_dsaCommSHA1 = '1.3.14.3.2.28';
   szOID_OIWSEC_sha1RSASign = '1.3.14.3.2.29';

   CERT_STORE_ADD_NEW                                  = 1;
   CERT_STORE_ADD_USE_EXISTING                         = 2;
   CERT_STORE_ADD_REPLACE_EXISTING                     = 3;
   CERT_STORE_ADD_ALWAYS                               = 4;
   CERT_STORE_ADD_REPLACE_EXISTING_INHERIT_PROPERTIES  = 5;
   CERT_STORE_ADD_NEWER                                = 6;
   CERT_STORE_ADD_NEWER_INHERIT_PROPERTIES             = 7;

   CERT_RDN_ANY_TYPE                = 0;
   CERT_RDN_ENCODED_BLOB            = 1;
   CERT_RDN_OCTET_STRING            = 2;
   CERT_RDN_NUMERIC_STRING          = 3;
   CERT_RDN_PRINTABLE_STRING        = 4;
   CERT_RDN_TELETEX_STRING          = 5;
   CERT_RDN_T61_STRING              = 5;
   CERT_RDN_VIDEOTEX_STRING         = 6;
   CERT_RDN_IA5_STRING              = 7;
   CERT_RDN_GRAPHIC_STRING          = 8;
   CERT_RDN_VISIBLE_STRING          = 9;
   CERT_RDN_ISO646_STRING           = 9;
   CERT_RDN_GENERAL_STRING          = 10;
   CERT_RDN_UNIVERSAL_STRING        = 11;
   CERT_RDN_INT4_STRING             = 11;
   CERT_RDN_BMP_STRING              = 12;
   CERT_RDN_UNICODE_STRING          = 12;
   CERT_RDN_UTF8_STRING             = 13;

   CERT_RDN_TYPE_MASK               = $000000FF;
   CERT_RDN_FLAGS_MASK              = $FF000000;

   szOID_COMMON_NAME                = '2.5.4.3';
   szOID_DEVICE_SERIAL_NUMBER       = '2.5.4.5';
   szOID_SUR_NAME                   =  '2.5.4.4';
   szOID_DESTINATION_INDICATOR      =  '2.5.4.27';
   szOID_TITLE                      = '2.5.4.12';

   szOID_COUNTRY_NAME               = '2.5.4.6';  // printable 2char string
   szOID_LOCALITY_NAME              = '2.5.4.7';  // case-ignore string
   szOID_STATE_OR_PROVINCE_NAME     = '2.5.4.8';  // case-ignore string
   szOID_ORGANIZATION_NAME          = '2.5.4.10'; // case-ignore string
   szOID_ORGANIZATIONAL_UNIT_NAME   = '2.5.4.11'; // case-ignore string

   KP_CERTIFICATE                   = 26;

   USAGE_MATCH_TYPE_AND         = $00000000;
   USAGE_MATCH_TYPE_OR          = $00000001;

   CERT_CHAIN_CACHE_END_CERT           = $00000001;
   CERT_CHAIN_THREAD_STORE_SYNC        = $00000002;
   CERT_CHAIN_CACHE_ONLY_URL_RETRIEVAL = $00000004;
   CERT_CHAIN_USE_LOCAL_MACHINE_STORE  = $00000008;
   CERT_CHAIN_ENABLE_CACHE_AUTO_UPDATE = $00000010;

   CERT_CHAIN_REVOCATION_CHECK_END_CERT           = $10000000;
   CERT_CHAIN_REVOCATION_CHECK_CHAIN              = $20000000;
   CERT_CHAIN_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT = $40000000;
   CERT_CHAIN_REVOCATION_CHECK_CACHE_ONLY         = $80000000;

   CERT_TRUST_NO_ERROR                   = $00000000;
   CERT_TRUST_IS_NOT_TIME_VALID          = $00000001;
   CERT_TRUST_IS_NOT_TIME_NESTED         = $00000002;
   CERT_TRUST_IS_REVOKED                 = $00000004;
   CERT_TRUST_IS_NOT_SIGNATURE_VALID     = $00000008;
   CERT_TRUST_IS_NOT_VALID_FOR_USAGE     = $00000010;
   CERT_TRUST_IS_UNTRUSTED_ROOT          = $00000020;
   CERT_TRUST_REVOCATION_STATUS_UNKNOWN  = $00000040;
   CERT_TRUST_IS_CYCLIC                  = $00000080;

   CERT_STORE_SAVE_AS_STORE        = 1;
   CERT_STORE_SAVE_AS_PKCS7        = 2;

   CERT_STORE_SAVE_TO_FILE         = 1;
   CERT_STORE_SAVE_TO_MEMORY       = 2;
 // end of copy from wincrypt.h and over Ms Visual Studio Headers
 // *******************************************************

 TYPE_DER = X509_ASN_ENCODING Or PKCS_7_ASN_ENCODING;

 USERKEY_KEYEXCHANGE		    =	AT_KEYEXCHANGE;
 USERKEY_SIGNATURE		    =	AT_SIGNATURE;
 USERKEY_SIMMERYMASTERKEY	    =	27;
 ALG_TYPE_GR3410		    =	7 shl 9;
 ALG_SID_GR3411			    =	30;
 ALG_SID_G28147			    =	30;
 ALG_SID_PRO_EXP		    =   31;
 ALG_SID_SIMPLE_EXP		    =	32;
 ALG_SID_GR3410			    =	30;
 ALG_SID_G28147_MAC		    =	31;
 ALG_SID_DH_EX_SF		    =	30;
 ALG_SID_DH_EX_EPHEM		    =	31;
 ALG_SID_PRO_AGREEDKEY_DH	    =	33;
 ALG_SID_PRO_SIMMETRYKEY	    =	34;

// Algorithm identifier definitions
 CALG_GR3411            = ALG_CLASS_HASH OR ALG_TYPE_ANY OR ALG_SID_GR3411;
 CALG_G28147_MAC        = ALG_CLASS_HASH OR ALG_TYPE_ANY OR ALG_SID_G28147_MAC;
 CALG_G28147_IMIT       = CALG_G28147_MAC;
 CALG_GR3410            = ALG_CLASS_SIGNATURE OR ALG_TYPE_GR3410 OR ALG_SID_GR3410;
 CALG_G28147            = ALG_CLASS_DATA_ENCRYPT OR ALG_TYPE_BLOCK OR ALG_SID_G28147;
 CALG_DH_EX_SF          = ALG_CLASS_KEY_EXCHANGE OR ALG_TYPE_DH OR ALG_SID_DH_EX_SF;
 CALG_DH_EX_EPHEM       = ALG_CLASS_KEY_EXCHANGE OR ALG_TYPE_DH OR ALG_SID_DH_EX_EPHEM;
 CALG_DH_EX             = CALG_DH_EX_SF;
 CALG_PRO_AGREEDKEY_DH  = ALG_CLASS_KEY_EXCHANGE OR ALG_TYPE_BLOCK OR ALG_SID_PRO_AGREEDKEY_DH;
 CALG_PRO_EXPORT        = ALG_CLASS_DATA_ENCRYPT OR ALG_TYPE_BLOCK OR ALG_SID_PRO_EXP;
 CALG_SIMPLE_EXPORT     = ALG_CLASS_DATA_ENCRYPT OR ALG_TYPE_BLOCK OR ALG_SID_SIMPLE_EXP;
 CALG_SIMMETRYKEY       = CALG_G28147;

//* Флаги, определенные для CryptGenKey
 CRYPT_INTRASERIAL      = $00000004;
 CRYPT_PROMIX_MODE      = $00000001;
 CRYPT_SIMPLEMIX_MODE   = $00000000;


//* Дополнительные параметры криптопровайдера
 PP_LAST_ERROR	       = 90;
 PP_ENUMOIDS_EX	       = 91;
 PP_HASHOID            = 92;
 PP_CIPHEROID          = 93;
 PP_SIGNATUREOID       = 94;
 PP_DHOID              = 95;
 PP_BIO_STATISTICA_LEN = 97;
 PP_REBOOT             = 98;

// Дополнительные параметры объекта хеша
 HP_HASHSTARTVECT      = $0008;
 HP_OID		       = $000a;

// Дополнительные параметры ключа
 KP_IV                  = 1;
 KP_SV                  = KP_IV;
 KP_MIXMODE             = 101;
 KP_OID	                = 102;
 KP_HASHOID             = 103;
 KP_CIPHEROID	        = 104;
 KP_SIGNATUREOID	= 105;
 KP_DHOID	        = 106;

//* Общие коды ошибок
//* Коды ошибок ДСЧ */
 GPE_FAIL_TESTBUFFER		      =	$0301;
 GPE_FAIL_STATBUFFER		      =	$0401;
// GPE_CORRUPT_PARAMETER			$0601
 GPE_DIFERENT_PARAMETERS	      =	$0501;
//* Коды ошибок функций ГОСТ 28147-89 */
 GPE_CORRUPT_KEYCONTEXT		      =	$0102;
 GPE_CHECKPROC_GAMMING_OFB	      =	$0402;
 GPE_CHECKPROC_ENCRYPT_CFB	      =	$0502;
//* Код ошибки контроля наличия носителя в считывателе при закрытии контейнера */
 GPE_CHECKCARRIER		      =	$0805;
//* Коды ошибок функций подписи */
 GPE_CORRUPT_KEYPAIR_INFO	      =	$0104;
//* Код отказа системы тестирования */
 GPE_CHECKPROC_TESTFAIL		      =	$0704;

//* CRYPT_HASH_ALG_OID_GROUP_ID */
 szOID_CP_GOST_R3411		      =	'1.2.643.2.2.9';

//* CRYPT_ENCRYPT_ALG_OID_GROUP_ID */
 szOID_CP_GOST_28147		      =	'1.2.643.2.2.21';

//* CRYPT_PUBKEY_ALG_OID_GROUP_ID */     
 szOID_CP_GOST_R3410		      =	'1.2.643.2.2.20';
 szOID_CP_DH_EX			      =	'1.2.643.2.2.99';

//* CRYPT_SIGN_ALG_OID_GROUP_ID */
 szOID_CP_GOST_R3411_R3410	      =	'1.2.643.2.2.4';

// OID for HASH
 OID_HashTest	                      = '1.2.643.2.2.30.0';	//Test
 OID_HashVerbaO                       = '1.2.643.2.2.30.1'; 	//VerbaO
 OID_HashVar_1                        = '1.2.643.2.2.30.2';
 OID_HashVar_2                        = '1.2.643.2.2.30.3';
 OID_HashVar_3                        = '1.2.643.2.2.30.4';
 OID_HashVar_Default                  = OID_HashVerbaO;
// OID for Crypt
 OID_CryptTest	                      = '1.2.643.2.2.31.0';	//Test
 OID_SipherVerbaO                     = '1.2.643.2.2.31.1'; 	//VerbaO
 OID_SipherVar_1                      = '1.2.643.2.2.31.2';
 OID_SipherVar_2                      = '1.2.643.2.2.31.3';
 OID_SipherVar_3                      = '1.2.643.2.2.31.4';
 OID_SipherVar_Default                = OID_SipherVerbaO;
 OID_SipherSimple_VerbaO              = '1.2.643.2.2.31.6';	//VerbaO Simple
 OID_SipherSimple_Var_1               = '1.2.643.2.2.31.7';
 OID_SipherSimple_Var_2               = '1.2.643.2.2.31.8';
 OID_SipherSimple_Var_3               = '1.2.643.2.2.31.9';
// OID for Signature 1024
 OID_SignDH128VerbaO                  = '1.2.643.2.2.32.2'; 	//VerbaO
// OID_Sign128Var_1   '1.2.643.2.2.32.3' //временно исключён
 OID_Sign128Var_2                     = '1.2.643.2.2.32.4';
 OID_Sign128Var_3                     = '1.2.643.2.2.32.5';
// OID for DH 1024
 OID_DH128Var_1                       = '1.2.643.2.2.33.1';
 OID_DH128Var_2                       = '1.2.643.2.2.33.2';
 OID_DH128Var_3                       = '1.2.643.2.2.33.3';

// Copyng from winerror.h
//  Bad UID.
NTE_BAD_UID                      = $80090001;

//  Bad Hash.
NTE_BAD_HASH                     = $80090002;

//  Bad Key.
NTE_BAD_KEY                      = $80090003;

//  Bad Length.
NTE_BAD_LEN                      = $80090004;

//  Bad Data.
NTE_BAD_DATA                     = $80090005;

//  Invalid Signature.
NTE_BAD_SIGNATURE                = $80090006;

//  Bad Version of provider.
NTE_BAD_VER                      = $80090007;

//  Invalid algorithm specified.
NTE_BAD_ALGID                    = $80090008;

//  Invalid flags specified.
NTE_BAD_FLAGS                    = $80090009;

//  Invalid type specified.
NTE_BAD_TYPE                     = $8009000A;

//  Key not valid for use in specified state.
NTE_BAD_KEY_STATE                = $8009000B;

//  Hash not valid for use in specified state.
NTE_BAD_HASH_STATE               = $8009000C;

//  Key does not exist.
NTE_NO_KEY                       = $8009000D;

//  Insufficient memory available for the operation.
NTE_NO_MEMORY                    = $8009000E;

//  Object already exists.
NTE_EXISTS                       = $8009000F;

//  Access denied.
NTE_PERM                         = $80090010;

//  Object was not found.
NTE_NOT_FOUND                    = $80090011;

//  Data already encrypted.
NTE_DOUBLE_ENCRYPT               = $80090012;

//  Invalid provider specified.
NTE_BAD_PROVIDER                 = $80090013;

//  Invalid provider type specified.
NTE_BAD_PROV_TYPE                = $80090014;

//  Provider's public key is invalid.
NTE_BAD_PUBLIC_KEY               = $80090015;

//  Keyset does not exist
NTE_BAD_KEYSET                   = $80090016;

//  Provider type not defined.
NTE_PROV_TYPE_NOT_DEF            = $80090017;

//  Provider type as registered is invalid.
NTE_PROV_TYPE_ENTRY_BAD          = $80090018;

//  The keyset is not defined.
NTE_KEYSET_NOT_DEF               = $80090019;

//  Keyset as registered is invalid.
NTE_KEYSET_ENTRY_BAD             = $8009001A;

//  Provider type does not match registered value.
NTE_PROV_TYPE_NO_MATCH           = $8009001B;

//  The digital signature file is corrupt.
NTE_SIGNATURE_FILE_BAD           = $8009001C;

//  Provider DLL failed to initialize correctly.
NTE_PROVIDER_DLL_FAIL            = $8009001D;

//  Provider DLL could not be found.
NTE_PROV_DLL_NOT_FOUND           = $8009001E;

//  The Keyset parameter is invalid.
NTE_BAD_KEYSET_PARAM             = $8009001F;

//  An internal error occurred.
NTE_FAIL                         = $80090020;

//  A base error occurred.
NTE_SYS_ERR                      = $80090021;


 CERT_DIGITAL_SIGNATURE_KEY_USAGE     = $80;
 CERT_NON_REPUDIATION_KEY_USAGE       = $40;
 CERT_KEY_ENCIPHERMENT_KEY_USAGE      = $20;
 CERT_DATA_ENCIPHERMENT_KEY_USAGE     = $10;
 CERT_KEY_AGREEMENT_KEY_USAGE         = $08;
 CERT_KEY_CERT_SIGN_KEY_USAGE         = $04;
 CERT_OFFLINE_CRL_SIGN_KEY_USAGE      = $02;
 CERT_CRL_SIGN_KEY_USAGE              = $02;
 CERT_ENCIPHER_ONLY_KEY_USAGE         = $01;

 szOID_AUTHORITY_KEY_IDENTIFIER   = '2.5.29.1';
 szOID_KEY_ATTRIBUTES             = '2.5.29.2';
 szOID_CERT_POLICIES_95           = '2.5.29.3';
 szOID_KEY_USAGE_RESTRICTION      = '2.5.29.4';
 szOID_SUBJECT_ALT_NAME           = '2.5.29.7';
 szOID_ISSUER_ALT_NAME            = '2.5.29.8';
 szOID_BASIC_CONSTRAINTS          = '2.5.29.10';
 szOID_KEY_USAGE                  = '2.5.29.15';
 szOID_PRIVATEKEY_USAGE_PERIOD    = '2.5.29.16';
 szOID_BASIC_CONSTRAINTS2         = '2.5.29.19';
 szOID_CERT_POLICIES              = '2.5.29.32';

 szOID_AUTHORITY_KEY_IDENTIFIER2  = '2.5.29.35';
 szOID_SUBJECT_KEY_IDENTIFIER     = '2.5.29.14';
 szOID_SUBJECT_ALT_NAME2          = '2.5.29.17';
 szOID_ISSUER_ALT_NAME2           = '2.5.29.18';
 szOID_CRL_REASON_CODE            = '2.5.29.21';
 szOID_CRL_DIST_POINTS            = '2.5.29.31';
 szOID_ENHANCED_KEY_USAGE         = '2.5.29.37';

 CERT_ALT_NAME_OTHER_NAME         = 1;
 CERT_ALT_NAME_RFC822_NAME        = 2;
 CERT_ALT_NAME_DNS_NAME           = 3;
 CERT_ALT_NAME_X400_ADDRESS       = 4;
 CERT_ALT_NAME_DIRECTORY_NAME     = 5;
 CERT_ALT_NAME_EDI_PARTY_NAME     = 6;
 CERT_ALT_NAME_URL                = 7;
 CERT_ALT_NAME_IP_ADDRESS         = 8;
 CERT_ALT_NAME_REGISTERED_ID      = 9;

 szOID_PKI_USERIDENTIFIER = '1.2.643.1.12345.1';

//+-------------------------------------------------------------------------
//  Certificate name string types
//--------------------------------------------------------------------------
 CERT_SIMPLE_NAME_STR        = 1;
 CERT_OID_NAME_STR           = 2;
 CERT_X500_NAME_STR          = 3;

//+-------------------------------------------------------------------------
//  Certificate name string type flags OR'ed with the above types
//--------------------------------------------------------------------------
 CERT_NAME_STR_SEMICOLON_FLAG    = $40000000;
 CERT_NAME_STR_NO_PLUS_FLAG      = $20000000;
 CERT_NAME_STR_NO_QUOTING_FLAG   = $10000000;
 CERT_NAME_STR_CRLF_FLAG         = $08000000;
 CERT_NAME_STR_COMMA_FLAG        = $04000000;
 CERT_NAME_STR_REVERSE_FLAG      = $02000000;

 CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG     = $00010000;
 CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG   = $00020000;
 CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG  = $00040000;



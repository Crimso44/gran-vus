Type

  ECApi20Error= Class(Exception);
  PDWord = ^LongWord;
  HCRYPTPROV = LongWord;
  PHCRYPTPROV = ^HCRYPTPROV;
  HCRYPTKEY  = LongWord;
  PHCRYPTKEY = ^HCRYPTKEY;
  HCRYPTHASH = LongWord;
  PHCRYPTHASH = ^HCRYPTHASH;

  T_VTableProvStruc = record
     Version:           LongWord;
     FuncVerifyImage:   Pointer;
     FuncReturnhWnd:    Pointer;
     dwProvType:        LongWord;
     pbContextInfo:     PChar;
     cbContextInfo:     LongWord;
     pszProvName:       PChar;
  end;
  PVTableProvStruc = ^T_VTableProvStruc;


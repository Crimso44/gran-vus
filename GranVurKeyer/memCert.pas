unit memCert;

interface

uses WinTypes;

type
  TMemCert = class
    ProductCode: Word;
    LicenceNumber: DWord;
    LicenceCount: Word;
    ValidityDate: TDateTime;
    HardwareKey: DWord;
    ControlKey: DWord;
    certificate_key: string;
  end;

implementation

end.

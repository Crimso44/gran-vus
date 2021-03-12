unit ArcData;

interface

uses SysUtils;

const
  _ArcID = 'GRVUSBKUP1797';

type
  TTableHeader=packed record
    TblName: Array[0..14] of AnsiChar;
    FldCount: Cardinal;
    RecCount: Cardinal;
    DataOffset: Integer;
    DataSize  : Integer;
  end;

  ATableHeader=packed array[0..0] of TTableHeader;
  PTableHeader=^ATableHeader;

  TArcHeader=packed record
    ArcID: Array[0..12] of AnsiChar;
    ArcDate: TTimeStamp;
    TableCount: Cardinal;
  end;


implementation

end.

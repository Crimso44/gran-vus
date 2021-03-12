unit uMemoTable;

interface

uses Classes, Contnrs;

type

  TMemoTable = class;

  TOnCalcFields = procedure (memo: TMemoTable; row: Integer) of object;

  TMemoTable = class
  private
    _rowCount: Integer;
    _onCalcFields: TOnCalcFields;
    _fieldName: String;
    _fieldId: Integer;
    procedure setRowCount(value: Integer);
  public
    Name: String;
    Tag: Integer;
    CurrentRow: Integer;
    ColumnNames: TStringList;
    StringField: array of string;
    Data: array of array of integer;
    property RowCount: Integer read _rowCount write setRowCount;
    property OnCalcFields: TOnCalcFields read _onCalcFields write _onCalcFields;
    procedure AddColumn(ColName: String);
    function FindRec(id: Integer): Integer;
    procedure SetField(FieldName: String; Value: Integer; Row: Integer = -1);
    function GetField(FieldName: String; Row: Integer = -1): Integer;
    function FindField(FieldName: String): Integer;
    procedure CalcFields(row: Integer);
    constructor Create;
    destructor Free;
  end;

  TMemoTables = class
    tables: TObjectList;
    function GetByName(Name: String): TMemoTable;
    constructor Create;
    destructor Free;
  end;

implementation

{ TMemoTables }

constructor TMemoTables.Create;
begin
  tables := TObjectList.Create;
  tables.OwnsObjects := True;
end;

destructor TMemoTables.Free;
begin
  tables.Clear;
  tables.Free;
end;

function TMemoTables.GetByName(Name: String): TMemoTable;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to tables.Count - 1 do
    if TMemoTable(tables[i]).Name = Name then begin
      Result := TMemoTable(tables[i]);
      Exit;
    end;
end;

{ TMemoTable }

procedure TMemoTable.AddColumn(ColName: String);
begin
  ColumnNames.Add(ColName);
  SetLength(Data, ColumnNames.Count);
  SetLength(Data[High(Data)], _rowCount);
end;

procedure TMemoTable.CalcFields(row: Integer);
begin
  if Assigned(OnCalcFields) then
    OnCalcFields(self, row);
end;

constructor TMemoTable.Create;
begin
  ColumnNames := TStringList.Create;
end;

function TMemoTable.FindField(FieldName: String): Integer;
begin
  if _fieldName = FieldName then begin
    Result := _fieldId;
    Exit;
  end;

  _fieldName := FieldName;
  _fieldId := ColumnNames.IndexOf(FieldName);
  Result := _fieldId;
end;

function TMemoTable.FindRec(id: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to High(Data[0]) do begin
    if Data[0, i] = id then begin
      CurrentRow := i;
      Result := i;
      Exit;
    end;
  end;
end;

destructor TMemoTable.Free;
begin
  ColumnNames.Free;
end;

function TMemoTable.GetField(FieldName: String; Row: Integer = -1): Integer;
var
  i, r: Integer;
begin
  i := FindField(FieldName);
  r := Row;
  if r < 0 then r := CurrentRow;
  Result := Data[i, r];
end;

procedure TMemoTable.SetField(FieldName: String; Value: Integer; Row: Integer = -1);
var
  i, r: Integer;
begin
  i := FindField(FieldName);
  r := Row;
  if r < 0 then r := CurrentRow;
  Data[i, r] := Value;
  if Assigned(_onCalcFields) then
    _onCalcFields(self, r);
end;

procedure TMemoTable.setRowCount(value: Integer);
var
  i: Integer;
begin
  _rowCount := value;
  SetLength(StringField, value);
  for i := 0 to High(Data) do
    SetLength(Data[i], value);
end;

end.

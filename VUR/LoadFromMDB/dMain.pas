unit dMain;

interface

uses
  SysUtils, Classes, Dialogs, OleServer, Excel2000, DB, ADODB
  {$IFDEF OfficeXP}, ExcelXP{$ENDIF};

type
  TdmMain = class(TDataModule)
    DBMain: TADOConnection;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    DBFrom: TADOConnection;
    QueryTo: TADOQuery;
    QueryFrom: TADOQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DBMainExecuteComplete(Connection: TADOConnection;
      RecordsAffected: Integer; const Error: Error;
      var EventStatus: TEventStatus; const Command: _Command;
      const Recordset: _Recordset);
    procedure DBMainWillExecute(Connection: TADOConnection;
      var CommandText: WideString; var CursorType: TCursorType;
      var LockType: TADOLockType; var CommandType: TCommandType;
      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
      const Command: _Command; const Recordset: _Recordset);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMain: TdmMain;

implementation

uses IniSupport, Forms, Controls;

{$R *.dfm}

procedure TdmMain.DataModuleCreate(Sender: TObject);
begin
  LoadConnAttr(DBMain);
end;

procedure TdmMain.DBMainExecuteComplete(Connection: TADOConnection;
  RecordsAffected: Integer; const Error: Error;
  var EventStatus: TEventStatus; const Command: _Command;
  const Recordset: _Recordset);
begin
  Screen.Cursor := crDefault;
end;

procedure TdmMain.DBMainWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
begin
  Screen.Cursor := crSQLWait;
  Command.CommandTimeout := Connection.CommandTimeout;
end;

end.

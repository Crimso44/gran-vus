{*************************************************************}
{                                                             }
{                АС ведения Адресного реестра                 }
{                                                             }
{                Модуль запуска внешних приложений            }
{                                                             }
{     Copyright (C) 2001, 2002  ГНПП "Гранит-Центр"           }
{     109147, г. Москва, ул. Воронцовская, д.23               }
{     тел. +7 (095) 911-0239                                  }
{          +7 (095) 911-0106                                  }
{     факс +7 (095) 911-0258          www.granit.ru           }
{*************************************************************}
unit exec;

interface

function ExecAndWait(const fname,params: string; nShowCmd: Cardinal): boolean;

implementation

uses Windows, ShellAPI, Forms;

function ExecAndWait(const fname,params: string; nShowCmd: Cardinal): boolean;
var data: TShellExecuteInfo;
begin
  Result := false;
  data.cbSize := sizeof(data);
  data.fMask  := SEE_MASK_DOENVSUBST or SEE_MASK_NOCLOSEPROCESS;
  data.Wnd := 0;
  data.lpVerb := nil;
  data.lpFile := PChar(fname);
  data.lpParameters := PChar(params);
  data.lpDirectory := nil;
  data.nShow := nShowCmd;
  ShellExecuteEx(@data);
  while true do begin
     Application.ProcessMessages;
    case WaitForSingleObject(data.hProcess,100) of
      WAIT_FAILED: Result := false;
      WAIT_OBJECT_0: Result := true;
      else continue;
    end;
    break;
  end;
end;

end.

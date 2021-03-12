library kbdmouhk;


uses
  WinTypes, Messages;

{$R *.RES}
const
    WM_MYHOOK = WM_USER + 10123;

var hKbdHk: Cardinal;
    hMouHk: Cardinal;


function MouseProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if nCode<0 then Result := CallNextHookEx(hMouHk,nCode,wParam,lParam)
  else Result := 0;
   SendMessage(FindWindow('TfmKbdMouHk','fmKbdMouHk'),WM_MYHOOK,1,0);
end;

function KeyboardProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
begin
  if nCode<0 then Result := CallNextHookEx(hKbdHk,nCode,wParam,lParam)
  else Result := 0;
  SendMessage(FindWindow('TfmKbdMouHk','fmKbdMouHk'),WM_MYHOOK,2,0);
end;

procedure SetHook; stdcall;
begin
  hKbdHk := SetWindowsHookEx(WH_KEYBOARD,KeyboardProc,hInstance,0);
  hMouHk := SetWindowsHookEx(WH_MOUSE,MouseProc,hInstance,0);
end;

procedure UnSetHook; stdcall;
begin
  UnhookWindowsHookEx(hKbdHk);
  UnhookWindowsHookEx(hMouHk);
end;

exports SetHook,UnSetHook;

end.

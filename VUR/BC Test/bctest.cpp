#include <windows.h>
#include <string.h>

__declspec (dllexport) int __stdcall PlugInInfo(LPSTR szName, LPSTR szAuthor)
{
  strcpy(szName,"Borland C++ test");
  strcpy(szAuthor,"Alexey V. Meleschenin");
  return 0;
}

__declspec (dllexport) int __stdcall PlugInExec(HWND AppHandle, void* _Conn)
{
  MessageBox(AppHandle,"Hello from Borland C++","Test",MB_OK);
  return 0;
}

__declspec (dllexport) int __stdcall PlugInConfig(HWND AppHandle, void* _Conn)
{
  MessageBox(AppHandle,"This simple plug-in has no configuration routine.","Config...",MB_OK);
  return 0;
}


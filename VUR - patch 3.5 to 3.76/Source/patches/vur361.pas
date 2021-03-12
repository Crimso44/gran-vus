unit vur361;

interface

  function Patch361_GetInfo: string;
  function Patch361_GetStepCount: Integer;
  procedure Patch361_Process;

implementation

function Patch361_GetInfo: string;
begin
  Result :=
   'Версия 3.61:'#13+
   '  - устранены ошибки при сохранении сведений карточки организации';
end;

function Patch361_GetStepCount: Integer;
begin
  Result := 0;
end;

procedure Patch361_Process;
begin
//no actions
end;

end.

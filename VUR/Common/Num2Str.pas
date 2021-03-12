unit Num2Str;
interface
uses SysUtils;

function convert(iNum: integer): string;

implementation
function convert(iNum: integer): string;
const s100: array[0..9] of string = ('', '���', '������', '������', '���������', '�������',
    '��������', '�������', '���������', '���������');
  s10: array[0..9] of string = ('', '', '��������', '��������', '�����', '���������',
    '����������', '���������', '�����������', '���������');
  s11: array[0..9] of string = ('������', '�����������', '����������', '����������', '������������',
    '����������', '�����������', '����������', '������������', '������������');
  s1: array[0..9, 0..1] of string = (('', ''), ('����', '����'), ('���', '���'),
    ('���', '���'), ('������', '������'), ('����', '����'),
    ('�����', '�����'), ('����', '����'),
    ('������', '������'), ('������', '������'));
  s1000: array[0..4, 0..2] of string = (('����������', '��������', '���������'),
    ('����������', '��������', '���������'),
    ('���������', '�������', '��������'),
    ('�����', '������', '������'), ('', '', ''));
var r, Num: string; i: integer;
  procedure ins(sr: string);
  begin
    if sr <> '' then r := r + ' ' + sr;
  end;

  function chtoint(ch: char): byte;
  var result_ch: byte;
  begin
    chtoint := 0;
    if (ch >= '0') and (ch <= '9') then chtoint := ord(ch) - ord('0')
    else chtoint := 0;
  end;
begin
  num := IntToStr(iNum);
  {�.�. ������� ������, �� ���� ���������, ��� � ��� ������ �����}
  for i:=1 to Length(num) do
    if not (num[i] in ['0'..'9']) then begin
      convert := '#������! ���������� ������ �� �������� ������!';
      Exit;
    end;

  r := '';
  for i := 1 to 15 - length(num) do insert('0', num, 1);
  for i := 0 to 4 do begin
    if copy(num, i * 3 + 1, 3) = '000' then continue;
    ins(s100[chtoint(num[i * 3 + 1])]);
    if num[i * 3 + 2] = '1' then begin ins(s11[chtoint(num[i * 3 + 3])]);
      ins(s1000[i, 0]);
      continue;
    end;
    ins(s10[chtoint(num[i * 3 + 2])]);
    if i = 3 then ins(s1[chtoint(num[i * 3 + 3]), 1]) else ins(s1[chtoint(num[i * 3 + 3]), 0]);
    case num[i * 3 + 3] of '0', '5', '6', '7', '8', '9': ins(s1000[i, 0]);
      '1': ins(s1000[i, 1]);
      '2', '3', '4': ins(s1000[i, 2]);
    end;
  end;
  if r <> '' then if r[1] = ' ' then delete(r, 1, 1);
  Convert := r;
end;


end.

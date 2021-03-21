unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, DB, ADODB;

type
  TfmMain = class(TForm)
    PC: TPageControl;
    Label1: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    P1: TTabSheet;
    P2: TTabSheet;
    P3: TTabSheet;
    Image1: TImage;
    pbExit1: TButton;
    pbNext: TButton;
    laLogin: TLabel;
    laPsw: TLabel;
    laFile: TLabel;
    edLogin: TEdit;
    edPsw: TEdit;
    edFile: TEdit;
    pbFile: TButton;
    pbStop: TButton;
    Bevel2: TBevel;
    pbExit3: TButton;
    Bevel4: TBevel;
    laReport: TLabel;
    meReport: TMemo;
    pbReportCopy: TButton;
    pbReportSave: TButton;
    laProcess: TLabel;
    laLine: TLabel;
    laEmpty: TLabel;
    laAdd: TLabel;
    laOverride: TLabel;
    laIgnoreDuplicate: TLabel;
    laEducation: TLabel;
    laPost: TLabel;
    laDepartment: TLabel;
    laRemark: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    cbKeepData: TCheckBox;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure pbExit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pbNextClick(Sender: TObject);
    procedure pbFileClick(Sender: TObject);
    procedure pbStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pbReportCopyClick(Sender: TObject);
    procedure pbReportSaveClick(Sender: TObject);
  private
    { Private declarations }
    FYesNoAll: (ynaAsk, ynaYes, ynaNo);
    function GetFileName: String;
    function GetKeepData: boolean;
    procedure SetFileName(AFileName: String);
    procedure SetKeepData(isKeepData: boolean);
    procedure Processing;
    function YesNoAll(Msg: String): Boolean;
    function GetCell(Idx: Integer): String;
    procedure AddReport(Msg: String; Idx: Integer=0);
    procedure ExecScript(query: TADOQuery; list: TStringList);
  public
    { Public declarations }
    FLine, FEmpty, FAdd, FOverride, FIgnoreDuplicate, FEducation, FPost, FDepartment: Integer;
    function iif(condition: Boolean; trueValue, falseValue: Integer): Integer;
  end;

var
  fmMain: TfmMain;

implementation

uses dMain, msg, IniSupport, MD5, SaveEvents,Clipbrd, Registry, StrUtils,
  misc, math;

{$R *.dfm}

const
  idx_FAM             = 1;
  idx_IM              = 2;
  idx_OTCH            = 3;
  idx_MALE            = 4;
  idx_BIRTHDAY        = 5;
  idx_BIRTHPLACE      = 6;
  idx_NAT_ID          = 7;
  idx_INN             = 8;
  idx_STRAH           = 9;
  idx_PSP_SER         = 10;
  idx_PSP_NUM         = 11;
  idx_PSP_PLACE       = 12;
  idx_PSP_DATE        = 13;
  idx_POST_CODE_0     = 14;
  idx_ADDR_STR_0      = 15;
  idx_POST_CODE_1     = 16;
  idx_ADDR_STR_1      = 17;
  idx_PH_NUMBER_1     = 18;
  idx_PH_NUMBER_2     = 19;
  idx_ED_ID           = 20;
  idx_UZ_NAME_1       = 21;
  idx_Obr_Doc_1       = 22;
  idx_Diplom_Ser_1    = 23;
  idx_DIPLOM_1        = 24;
  idx_END_DATE_1      = 25;
  idx_KVAL_1          = 26;
  idx_NAPR_1          = 27;
  idx_UZ_NAME_2       = 28;
  idx_Obr_Doc_2       = 29;
  idx_Diplom_Ser_2    = 30;
  idx_DIPLOM_2        = 31;
  idx_END_DATE_2      = 32;
  idx_KVAL_2          = 33;
  idx_NAPR_2          = 34;
  idx_TAB_NUMB        = 35;
  idx_POST_NAME       = 36;
  idx_OKPDTR_Code     = 37;
  idx_OKPDTR_Name     = 38;
  idx_DEP_FULL_NAME   = 39;
  idx_DEP_NAME        = 40;
  idx_WTP_ID          = 41;
  idx_WCH_ID          = 42;
  idx_IN_DATE         = 43;
  idx_KWRANGE         = 44;
  idx_Sostav          = 45;
  idx_VUS             = 46;
  idx_Cat_Zap         = 47;
  idx_SemPol          = 48;
  idx_WCAT            = 49;
  idx_WUCHET1         = 50;
  idx_hasMob          = 51;
  idx_Voenkomat       = 52;
  idx_War_Date        = 53;
  idx_Card_Num        = 54;
  ColCount = 54;
  ColName : array [1..ColCount] of String = (
    '�������',
    '���',
    '��������',
    '���',
    '���� ��������',
    '����� ��������',
    '�����������',
    '���',
    '� ������������� ������������� ������������ �����������',
    '����� ��������',
    '� ��������',
    '��� ����� �������',
    '���� ������ ��������',
    '�������� ������ �� ��������',
    '����� �� ��������',
    '�������� ������ �����������',
    '����� �����������',
    '������� ��������',
    '������� �������',
    '��� �����������',
    '������ ������� ���������',
    '��� ��������� (1)',
    '����� ������� (1)',
    '� ������� (1)',
    '����/��� ���������( 1)',
    '������������ (1)',
    '������������� (1)',
    '������ ������� ���������',
    '��� ��������� (2)',
    '����� ������� (2)',
    '� ������� (2)',
    '����/��� ��������� (2)',
    '������������ (2)',
    '������������� (2)',
    '��������� �����',
    '���������',
    '��� ������',
    '������������ ������',
    '������ ������������ ������������ �������������',
    '������� ������������ ������������ �������������',
    '��� ������',
    '�������� ������',
    '���� ���������� ����������',
    '�������� ������',
    '������, �������',
    '���',
    '��������� ������',
    '�������� ���������',
    '��������� ��������',
    '������� �� �����',
    '������� ���. �����������',
    '������� �����������',
    '���� ���������� �� �������� ����',
    '����� ������ ��������'
    );
  CellLen : array [1..ColCount] of Integer =  (
  50,
  50,
  50,
  0,//Dictonary
  -1,//Date
  100,
  0,
  12,
  20,
  10,
  10,
  100,
  -1,
  -3,//Signed DWord
  100,
  -3,
  100,
  50,
  50,
  0,
  100,
  0,
  50,
  50,
  -2,//Year or Date
  100,
  100,
  100,
  0,
  50,
  50,
  -2,
  100,
  100,
  10,
  50,
  10,
  100,
  255,
  50,
  0,
  0,
  -1,
  -3,
  -3,
  10,
  -3,
  -3,
  1,
  -3,
  100,
  -3,
  -1,
  -3
  );



procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if PC.ActivePage=P2
    then begin CanClose := False; pbStop.Click; end
    else CanClose := Confirm('�� ������������� ������ ������� ���������?');
end;

procedure TfmMain.pbExit1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  PC.ActivePage := P1;
  edLogin.Text := GetLastLogin;
  edFile.Text := GetFileName;
  cbKeepData.Checked := GetKeepData;
end;

procedure TfmMain.pbNextClick(Sender: TObject);
begin
  if not FileExists(edFile.Text) then begin
    ShowErr('������� ���� �� ������!'); Exit;
  end;
  try
    with dmMain.ExcelApplication do
    try
      Connect;
      Visible[0]:=False;
      Workbooks.Open(edFile.Text, 0, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, NULL,
      {$IFDEF OfficeXP}
      NULL, NULL, NULL,
      {$ELSE}
      0,
      {$ENDIF}
      0);
    finally
      Quit;
      Disconnect;
    end;
  except
    ShowErr('�� ������� ������� ���� ����������� �������!'); Exit;
  end;

  with TADOQuery.Create(Self) do
  try
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT * FROM USERS WHERE Login='+QuotedStr(edLogin.Text);
      Open;
      if IsEmpty then begin
        ShowErr('�������� ��������� ��� ������������!'); Exit;
      end;

      if StrMD5(edLogin.Text+edPsw.Text)<>FieldByName('HASH').AsString then begin
        SaveEvent(dmMain.dbMain, evs_Login_Failed,'',['�������� ������: '+edPsw.Text]);
        ShowErr('��������� ������ �������!');
        edPsw.SetFocus;
        edPsw.SelectAll;
        Exit;
      end;

      if not FieldByName('rLogin').AsBoolean then begin
        ShowErr('�� �� ��������� ������ ����� � �������. '+
                '�� ������������� �� ������ ���������� � �������������� �������.');
        Exit;
      end;

      if not FieldByName('rImport').AsBoolean then begin
        ShowErr('�� �� ��������� ������ �� ������ ������. '+
                '�� ������������� �� ������ ���������� � �������������� �������.');
        Exit;
      end;
    except
      ShowErr('������ ��� ��������� � ���� ������!');
      Exit;
    end;
  finally Free;
  end;
  SetLastLogin(edLogin.Text);
  SaveEvent(dmMain.dbMain, evs_Login_Ok,'LoadFromXLS',[]);
  PC.ActivePage := P2;
  try Processing; except ON E: Exception do ShowErr(E.Message) end;
  if meReport.Lines.Count=0 then meReport.Lines.Add('��� ���������.');
  meReport.Lines.Text :=
    Format('����������'#13#10#13#10+
           '������� �����: %d'#13#10+
           '��������� �����: %d'#13#10+
           '��������� ��������: %d'#13#10+
           '������������ ��������: %d'#13#10+
           '��������������� ����������: %d'#13#10+
           '��������� ������� ���������: %d'#13#10+
           '��������� ����������: %d'#13#10+
           '��������� �������������: %d'#13#10#13#10+
           '���������'#13#10#13#10,[
           FLine, FEmpty, FAdd, FOverride, FIgnoreDuplicate, FEducation, FPost, FDepartment
           ])+
    meReport.Lines.Text;
  PC.ActivePage := P3;
end;

procedure TfmMain.pbFileClick(Sender: TObject);
begin
  dmMain.OpenDialog.FileName := edFile.Text;
  if dmMain.OpenDialog.Execute then
    edFile.Text := dmMain.OpenDialog.FileName;
end;

procedure TfmMain.pbStopClick(Sender: TObject);
begin
  if not Confirm('�������� ������� ���������� ��������� �����������?') then Exit;
  pbStop.Enabled := False;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SetKeepData(cbKeepData.Checked);
  SetFileName(edFile.Text);
  if PC.ActivePage<>P1 then SaveEvent(dmMain.dbMain, evs_Logout,'',['�������: �������� ��������� LoadFromXLS.']);
end;

procedure TfmMain.pbReportCopyClick(Sender: TObject);
var
  Layout : HKL;
begin
  Layout := GetKeyboardLayout(0); // Save Current
  ActivateKeyboardLayout($00000419, 0); // Rus
  Clipboard.AsText := meReport.Text;
  ActivateKeyboardLayout(Layout, 0); // Restore
  ShowMessage('����� � ����������� ������ ���������� � ����� ������.');
end;

procedure TfmMain.pbReportSaveClick(Sender: TObject);
begin
  if not dmMain.SaveDialog.Execute then Exit;
  meReport.Lines.SaveToFile(dmMain.SaveDialog.FileName);
  ShowMessage('����� � ����������� ������ ������� � ����� "'+
              dmMain.SaveDialog.FileName+'".');
end;

procedure TfmMain.Processing;
//
var
  IsDuplicate: Boolean;
  Pers_ID    : Integer;
  Keep_Pers_ID    : Integer;
  Other_ID   : Integer;
  qry, qry2  : TADOQuery;
//
  function CheckEOF(AColumn: Integer): Boolean;
  var I : Integer;
  begin
    Result := GetCell(AColumn) = '';
    if not Result then Exit;
    for I :=  1 to ColCount do
    if GetCell(I)<>'' then
    AddReport('������ ��������� - ������ �������� � "%s", ������ ������ ������� �������� �������� ��������',AColumn);
  end;
//
  function CheckFIO: Boolean;
  var I: Integer;
  begin
    Result := True;
    for I :=  1 to  3 do
    if GetCell(I)='' then begin
      Result := False;
      Inc(FEmpty); laEmpty.Caption := IntToStr(FEmpty);
      AddReport('������ �� �������� - ����������� ������������ �������� "%s"',I);
      Exit;
    end;
  end;
//
  function CheckDuplicate: Boolean;
  var Ser, Num: String;
  begin
    Result := True;
    Ser := LeftStr(GetCell(idx_PSP_SER),CellLen[idx_PSP_SER]);
    Num := LeftStr(GetCell(idx_PSP_NUM),CellLen[idx_PSP_NUM]);
    with TADOQuery.Create(nil) do
    try
      Keep_Pers_Id := -1;
      Connection := dmMain.dbMain;
      SQL.Text := Format('SELECT * FROM PERSON WHERE PSP_SER=%s AND PSP_NUM=%s',
        [QuotedStr(Ser),QuotedStr(Num)]);
      Open;
      IsDuplicate := not IsEmpty;
      if IsDuplicate then begin
        Pers_ID := FieldByName('PERS_ID').AsInteger;
        Result := YesNoAll(Format(
          '����������� � ������ %d ���������� ������ ��� ������������ � ���� ������. '+
          '������ �� ���������� �� ���� ������ ����� ���� ������ ��� �������� ������ ������������ ��� ���������. '+
          '������������ ������?',
          [FLine+2]
        ));
        if Result then begin
           Pers_ID := FieldByName('Pers_ID').AsInteger;
           Close;
           SQL.Text := 'Delete from Phones      where Pers_id='+IntToStr(Pers_ID); ExecSQL;
           if cbKeepData.Checked then begin
             Keep_Pers_Id := Pers_Id;
           end else begin
             SQL.Text := 'Delete from Addr        where Pers_id='+IntToStr(Pers_ID); ExecSQL;
             SQL.Text := 'Delete from Langs       where Pers_id='+IntToStr(Pers_ID); ExecSQL;
             SQL.Text := 'Delete from Family      where Pers_id='+IntToStr(Pers_ID); ExecSQL;
             SQL.Text := 'Delete from Educ        where Pers_id='+IntToStr(Pers_ID); ExecSQL;
             SQL.Text := 'Delete from Appointment where Pers_id='+IntToStr(Pers_ID); ExecSQL;
             SQL.Text := 'Delete from Person      where Pers_id='+IntToStr(Pers_ID); ExecSQL;
           end;
          AddReport('������ ������������ - ������������ ���������� ������');
        end
        else begin
          Inc(FIgnoreDuplicate); laIgnoreDuplicate.Caption := IntToStr(FIgnoreDuplicate);
          AddReport('������ �� �������� - ������������ ���������� ������');
        end;
      end;
    finally Free;
    end;
  end;
//
  function CheckLen(Idx: Integer): Variant;
  var S: String;
  begin
    try
      S := GetCell(Idx);
      if CellLen[Idx]>=Length(S) then Exit;
      SetLength(S, CellLen[Idx]);
      AddReport('���������� �������� � "%s" ������ �����������, �������� �������',Idx);
    finally if S='' then Result := Null else Result := S;
    end;  
  end;
//
  type TByteSet = set of Byte;
  function CheckInt(Idx: Integer; Dictionary: TByteSet = []; CanBeNull: Boolean = False): Variant;
  begin
    if StrToIntDef(GetCell(Idx), -1) in Dictionary then begin
      Result := StrToIntDef(GetCell(Idx), -1);
      Exit;
    end
    else if Dictionary = [] then begin
      Result := StrToIntDef(GetCell(Idx), -1);
      if Result = -1 then Result := NULL;
      Exit;
    end;
    if CanBeNull then Result := NULL
    else begin
      Result := 1;
      AddReport('�������� � "%s" �� ������ � ��������� ���������� �������� � �������� �� ����������',Idx);
    end;     
  end;
//
  function CheckOvk(Idx: Integer): Variant;
  begin
    Result := StrToIntDef(GetCell(Idx), -1);
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.DBMain; ParamCheck := False;
      SQL.Text := 'SELECT * FROM KOVK WHERE OVK_ID='+IntToStr(Result); Open;
      if IsEmpty then begin
        Close;
        SQL.Text := 'SELECT OVK_ID FROM KOVK Order By OVK_ID'; Open;
        Result := Fields[0].AsInteger;
        AddReport('�������� � "%s" �� ������ � ��������� ���������� �������� � �������� �� ����������',Idx);
      end;
      Close;
    finally Free;
    end;
  end;
//
  function CheckZIP(Idx: Integer): Variant;
  var
    S: String;
    I: Integer;
  begin
    S := GetCell(Idx);
    if S='' then begin Result := Null; Exit; end;
    I := StrToIntDef(S,0);
    if (I>=100000) and (I<=999999) then begin Result := I; Exit; end;
    Result := Null;
    AddReport('�������� � "%s" �� ������ � ��������� ���������� �������� � �������� �� ����������',Idx);
  end;
//
  procedure AddAddr;
  begin
    with qry do begin
      SQL.Text := 'SELECT MAX(ADDR_ID) FROM ADDR'; Open;
      Other_ID := Fields[0].AsInteger+1; Close;

      if cbKeepData.Checked then begin
        SQL.Text :=
          'SELECT * FROM ADDR Where Addr_Type = 0 and Pers_Id = ' + IntToStr(Pers_Id);
        Open;
        if Eof then begin
          Append;
          FieldByName('ADDR_ID').Value := Other_ID;
          FieldByName('PERS_ID').Value := Pers_ID;
        end else begin
          Edit;
        end;
      end else begin
        SQL.Text := 'SELECT * FROM ADDR'; Open;
        Append;
        FieldByName('ADDR_ID').Value := Other_ID;
        FieldByName('PERS_ID').Value := Pers_ID;
      end;
      FieldByName('ADDR_TYPE').Value := 0;
      FieldByName('POST_CODE').Value := CheckZIP(idx_Post_Code_0);
      FieldByName('ADDR_STR').Value := CheckLen(idx_Addr_Str_0);
      Post;
      if cbKeepData.Checked then begin
        Close;
        SQL.Text :=
          'SELECT * FROM ADDR Where Addr_Type = 1 and Pers_Id = ' + IntToStr(Pers_Id);
        Open;
        if Eof then begin
          Append;
          FieldByName('ADDR_ID').Value := Other_ID+1;
          FieldByName('PERS_ID').Value := Pers_ID;
        end else begin
          Edit;
        end;
      end else begin
        Append;
        FieldByName('ADDR_ID').Value := Other_ID+1;
        FieldByName('PERS_ID').Value := Pers_ID;
      end;
      FieldByName('ADDR_TYPE').Value := 1;
      FieldByName('POST_CODE').Value := CheckZIP(idx_Post_Code_1);
      FieldByName('ADDR_STR').Value := CheckLen(idx_Addr_Str_1);
      Post;
      Close;
    end;
  end;
//
  procedure AddPhones;
  begin
    with qry do begin
      SQL.Text := 'SELECT MAX(PH_ID) FROM PHONES'; Open;
      Other_ID := Fields[0].AsInteger+1; Close;

      SQL.Text := 'SELECT * FROM PHONES'; Open;
      Append;
      FieldByName('PH_ID').Value := Other_ID;
      FieldByName('PERS_ID').Value := Pers_ID;
      FieldByName('PH_NUMBER').Value := CheckLen(idx_PH_NUMBER_2);
      FieldByName('PH_TYPE').Value := 1;
      Post;
      Append;
      FieldByName('PH_ID').Value := Other_ID+1;
      FieldByName('PERS_ID').Value := Pers_ID;
      FieldByName('PH_NUMBER').Value := CheckLen(idx_PH_NUMBER_1);
      FieldByName('PH_TYPE').Value := 2;
      Post;
      Close;
    end;
  end;
//
  function CheckUZ(Idx: Integer; out UZ_ID: Integer): Boolean;
  var
    S : String;
    I : Integer;
  begin
    S := GetCell(Idx);
    Result := S<>'';
    if not Result then begin
      for I := Idx+1 to Idx+4 do if GetCell(I)<>'' then begin
       AddReport('������ �������� � "%s", ������ ��������������� ������� �������� �������� ��������',Idx);
       Exit;
      end;
    end
    else
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.DBMain; ParamCheck := False;
      SQL.Text := 'SELECT * FROM KUZ WHERE UZ_NAME='+QuotedStr(S); Open;
      if IsEmpty then begin
        Close;
        SQL.Text := 'SELECT MAX(UZ_ID) FROM KUZ'; Open;
        UZ_ID := Fields[0].AsInteger+1; Close;

        SQL.Text := 'SELECT * FROM KUZ'; Open;
        Append;
        FieldByName('UZ_ID').Value   := UZ_ID;
        FieldByName('UZ_NAME').Value := CheckLen(Idx);
        Post;
        Inc(FEducation); laEducation.Caption := IntToStr(FEducation);
      end
      else
        UZ_ID := FieldByName('UZ_ID').Value;
    finally Free;
    end;
  end;
//
  function CheckObrDoc(Idx: Integer): Integer;
  var
    S : String;
    I : Integer;
  begin
    S := GetCell(Idx);
    if S = '' then begin
      Result := 1;
      Exit;
    end
    else
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.DBMain; ParamCheck := False;
      SQL.Text := 'SELECT * FROM KObrDoc WHERE KObrDoc_NAME='+QuotedStr(S); Open;
      if IsEmpty then begin
        Close;
        SQL.Text := 'SELECT MAX(KObrDoc_ID) FROM KObrDoc'; Open;
        Result := Fields[0].AsInteger+1; Close;

        SQL.Text := 'SELECT * FROM KObrDoc'; Open;
        Append;
        FieldByName('KObrDoc_ID').Value   := Result;
        FieldByName('KObrDoc_NAME').Value := S;
        Post;
      end
      else
        Result := FieldByName('KObrDoc_ID').Value;
    finally Free;
    end;
  end;
//
  function CheckDateYear(Idx: Integer): String;
  begin
    Result := GetCell(Idx);
    if (Result='') or IsDateOrYear(Result) then Exit;
    Result := '';
    AddReport('�������� � "%s" �� ������ � ��������� ���������� �������� � �������� �� ����������',Idx);
  end;
//
  function CheckDictonary(Idx: Integer; Dictonary: array of String; DefaultValue: Integer): Integer;
  begin
    Result := AnsiIndexText(GetCell(Idx),Dictonary);
    if Result >= 0 then Exit;
    Result := DefaultValue;
    AddReport('�������� � "%s" �� ������ � ��������� ���������� �������� � �������� �� ����������',Idx);
  end;
//
  function GetKval(s: String): Integer;
  begin
    with qry2 do begin
      SQL.Text := 'select * from KKval where Kval_Name = :name';
      Parameters[0].Value := s;
      Open;
      if Eof then begin
        Close;
        SQL.Text := 'select Max(Kval_Id) from KKval';
        Open;
        Result := Fields[0].AsInteger + 1;
        Close;
        SQL.Text :=
          'Insert Into KKval (Kval_Id, Kval_Name, Kval_Flag) '+
          'Values ('+IntToStr(Result)+',:Name, 1)';
        Parameters[0].Value := s;
        ExecSQL;
      end else
        Result := FieldByName('Kval_Id').AsInteger;
      Close;
    end;
  end;
//
  function GetNapr(s: String): Integer;
  begin
    with qry2 do begin
      SQL.Text := 'select * from KNapr where Napr_Name = :name';
      Parameters[0].Value := s;
      Open;
      if Eof then begin
        Close;
        SQL.Text := 'select Max(Napr_Id) from KNapr';
        Open;
        Result := Fields[0].AsInteger + 1;
        Close;
        SQL.Text :=
          'Insert Into KNapr (Napr_Id, Napr_Name, Napr_Flag) '+
          'Values ('+IntToStr(Result)+',:Name, 1)';
        Parameters[0].Value := s;
        ExecSQL;
      end else
        Result := FieldByName('Napr_Id').AsInteger;
      Close;
    end;
  end;
//
  procedure AddEduc;
  var
    UZ_ID, ObrDoc_Id : Integer;
  begin
    with qry do begin
      if cbKeepData.Checked and
        (CheckUZ(idx_UZ_NAME_1, UZ_ID) or CheckUZ(idx_UZ_NAME_2, UZ_ID)) then begin

        SQL.Text := 'Delete from Educ        where Pers_id='+IntToStr(Pers_ID); ExecSQL;
      end;
      SQL.Text := 'SELECT MAX(EDQ_ID) FROM EDUC'; Open;
      Other_ID := Fields[0].AsInteger+1; Close;

      SQL.Text := 'SELECT * FROM EDUC'; Open;
      if CheckUZ(idx_UZ_NAME_1, UZ_ID) then begin
        Append;
        FieldByName('EDQ_ID').Value := Other_ID;
        FieldByName('PERS_ID').Value := Pers_ID;
        FieldByName('UZ_ID').Value := UZ_ID;
        FieldByName('DIPLOM').Value := CheckLen(idx_DIPLOM_1);
        FieldByName('DIPLOM_SER').Value := CheckLen(idx_DIPLOM_Ser_1);
        FieldByName('ObrDoc_Id').Value := CheckObrDoc(idx_Obr_Doc_1);
        FieldByName('END_DATE').Value := CheckDateYear(idx_END_DATE_1);
        FieldByName('KVAL').Value := CheckLen(idx_KVAL_1);
        if Length(FieldByName('KVAL').AsString) > 0 then
          FieldByName('KVAL_Id').Value := GetKval(FieldByName('KVAL').AsString);
        FieldByName('NAPR').Value := CheckLen(idx_NAPR_1);
        if Length(FieldByName('NAPR').AsString) > 0 then
          FieldByName('NAPR_Id').Value := GetNapr(FieldByName('NAPR').AsString);
        FieldByName('Type').Value := 1;
        Post;
        Inc(Other_ID);
      end;
      if CheckUZ(idx_UZ_NAME_2, UZ_ID) then begin
        Append;
        FieldByName('EDQ_ID').Value := Other_ID;
        FieldByName('PERS_ID').Value := Pers_ID;
        FieldByName('UZ_ID').Value := UZ_ID;
        FieldByName('DIPLOM').Value := CheckLen(idx_DIPLOM_2);
        FieldByName('DIPLOM_SER').Value := CheckLen(idx_DIPLOM_Ser_2);
        FieldByName('ObrDoc_Id').Value := CheckObrDoc(idx_Obr_Doc_2);
        FieldByName('END_DATE').Value := CheckDateYear(idx_END_DATE_2);
        FieldByName('KVAL').Value := CheckLen(idx_KVAL_2);
        if Length(FieldByName('KVAL').AsString) > 0 then
          FieldByName('KVAL_Id').Value := GetKval(FieldByName('KVAL').AsString);
        FieldByName('NAPR').Value := CheckLen(idx_NAPR_2);
        if Length(FieldByName('NAPR').AsString) > 0 then
          FieldByName('NAPR_Id').Value := GetNapr(FieldByName('NAPR').AsString);
        FieldByName('Type').Value := 2;
        Post;
      end;
      Close;
    end;
  end;
//
  function CheckPOST(out POST_ID: Integer; out CProf_Id: Integer): Boolean;
  const Idx = idx_POST_NAME;
  var
    S, SS, SX : String;
    I, KOKPDTR_ID : Integer;
  begin
    S := GetCell(Idx);
    Result := (S<>'') and (GetCell(Idx+3)<>'');
    if not Result then begin
      if S='' then
      for I := Idx+3 to Idx+6 do if GetCell(I)<>'' then begin
       AddReport('������ �������� � "%s", ������ ��������������� ������� �������� �������� ��������',Idx);
       Exit;
      end;
    end
    else
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.DBMain; ParamCheck := False;

      KOKPDTR_ID := 0;
      SX := GetCell(idx_OKPDTR_Code);
      if SX <> '' then begin
         SS := GetCell(idx_OKPDTR_Name);
         if SS = '' then
           SS := S;
         SQL.Text := 'Select * From KOKPDTR Where KOKPDTR_Code='+QuotedStr(SX); Open;
         if IsEmpty then begin
           Close;
           SQL.Text := 'SELECT MAX(KOKPDTR_ID) FROM KOKPDTR'; Open;
           KOKPDTR_ID := Fields[0].AsInteger+1; Close;
           SQL.Text := 'SELECT * FROM KOKPDTR'; Open;
           Append;
           FieldByName('KOKPDTR_ID').Value   := KOKPDTR_ID;
           FieldByName('KOKPDTR_Code').Value := SX;
           FieldByName('KOKPDTR_Name').Value := SS;
           Post;
         end else
           KOKPDTR_ID := FieldByName('KOKPDTR_ID').Value;
         Close;
      end;

      SQL.Text := 'SELECT * FROM KPOST WHERE POST_NAME='+QuotedStr(S); Open;
      if IsEmpty then begin
        Close;
        SQL.Text := 'SELECT MAX(POST_ID) FROM KPOST'; Open;
        POST_ID := Fields[0].AsInteger+1; Close;

        SQL.Text := 'SELECT * FROM KPOST'; Open;
        Append;
        FieldByName('POST_ID').Value   := POST_ID;
        FieldByName('KPOST_Num').Value   := POST_ID;
        FieldByName('POST_NAME').Value := CheckLen(Idx);
        FieldByName('OKPDTR_NAME').Value := FieldByName('POST_NAME').Value;
        FieldByName('CProf_ID').Value := 200;
        if KOKPDTR_ID > 0 then
          FieldByName('KOKPDTR').Value := KOKPDTR_ID;
        Post;
        Inc(FPost); laPost.Caption := IntToStr(FPost);
      end
      else
        POST_ID := FieldByName('POST_ID').Value;
      CProf_Id := FieldByName('CProf_ID').AsInteger;

    finally Free;
    end;
  end;
//
  function CheckDepart(out DEP_ID: Integer): Boolean;
  const Idx = idx_DEP_NAME;
  var
    S : String;
    I : Integer;
  begin
    S := GetCell(Idx);
    Result := S<>'';
    if not Result then begin
      for I := Idx-1 to Idx+3 do if GetCell(iif(i=Idx-1,Idx-3,I))<>'' then begin
       AddReport('������ �������� � "%s", ������ ��������������� ������� �������� �������� ��������',Idx);
       Exit;
      end;
    end
    else
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.DBMain; ParamCheck := False;
      SQL.Text := 'SELECT * FROM KDEPART WHERE DEP_NAME='+QuotedStr(S); Open;
      if IsEmpty then begin
        Close;
        SQL.Text := 'SELECT MAX(DEP_ID) FROM KDEPART'; Open;
        DEP_ID := Fields[0].AsInteger+1; Close;

        SQL.Text := 'SELECT * FROM KDEPART'; Open;
        Append;
        FieldByName('DEP_ID').Value   := DEP_ID;
        FieldByName('KDEPART_Num').Value   := DEP_ID;
        FieldByName('DEP_NAME').Value := CheckLen(Idx);
        FieldByName('DEP_FULL_NAME').Value := CheckLen(idx_DEP_FULL_NAME);
        Post;
        Inc(FDepartment); laDepartment.Caption := IntToStr(FDepartment);
      end
      else
        DEP_ID := FieldByName('DEP_ID').Value;
    finally Free;
    end;
  end;
//
  function CheckDate(Idx: Integer; CanBeNULL: Boolean = True): Variant;
  var
    S  : String;
  begin
    S := GetCell(Idx);
    if (S='') and CanBeNULL then begin
      Result := Null; Exit;
    end;
    if (Length(S)=10) and IsDateOrYear(S)
    then
      Result := EncodeDate(StrToInt(Copy(S,7,4)),
                           StrToInt(Copy(S,4,2)),
                           StrToInt(Copy(S,1,2)))
    else begin
      AddReport('�������� � "%s" �� ������ � ��������� ���������� �������� � �������� �� ����������',Idx);
      if CanBeNull then Result := Null else Result := Date;
    end;
  end;
//
  var Post_Id, CProf_Id: Integer;

  function AddAppointment: Integer;
  var POST_ID, DEP_ID : Integer;
  begin
    Result := -1;
    if CheckPOST(POST_ID, CProf_Id) and CheckDepart(DEP_ID) then  with qry do begin
//      SQL.Text := 'SELECT MAX(ID) FROM Appointment'; Open;
//      Other_ID := Fields[0].AsInteger+1; Close;

      SQL.Text := 'SELECT * FROM Appointment'; Open;
      Append;
//      FieldByNAme('ID').Value := Other_ID;
      FieldByName('POST_ID').Value := POST_ID;
      FieldByName('DEP_ID').Value := DEP_ID;
      FieldByName('Pers_ID').Value := Pers_ID;
      FieldByName('WTP_ID').Value := CheckDictonary(idx_WTP_ID,['���','����'], 0)+1;
      FieldByName('WCH_ID').Value := CheckDictonary(idx_WCH_ID,['����','����'], 0)+1;
      FieldByName('IN_DATE').Value := CheckDate(idx_IN_DATE, False);
      FieldByName('IN_ORD_DATE').Value := FieldByName('IN_DATE').Value;
      Post;
      Result := FieldByNAme('ID').AsInteger;
      Close;
    end;
  end;
//
var
  sqlText: TStringList;
  sFile: String;
begin ////////////////// Processing //////////////////
  Forms.Application.ProcessMessages;

  qry := TADOQuery.Create(nil);
  qry2 := TADOQuery.Create(nil);
  with qry do
  try
    Connection := dmMain.DBMain; ParamCheck := False;
    qry2.Connection := dmMain.DBMain;

    with dmMain.ExcelApplication do
    try
      Connect;
      Visible[0]:=False;
        Workbooks.Open(edFile.Text, 0, 1, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, NULL,
        {$IFDEF OfficeXP}
        NULL, NULL, NULL,
        {$ELSE}
        0,
        {$ENDIF}
        0);

      while pbStop.Enabled do begin
        if CheckEOF(idx_PSP_SER) then Exit;
        if CheckEOF(idx_PSP_NUM) then Exit;
        if CheckFIO and CheckDuplicate then begin
          if Keep_Pers_Id > 0 then begin
            Pers_Id := Keep_Pers_Id
          end else begin
            SQL.Text := 'SELECT MAX(Pers_ID) FROM Person'; Open;
            Pers_ID := Fields[0].AsInteger+1; Close;
          end;

          AddAddr;
          AddPhones;
          AddEduc;
          post_id := AddAppointment;

          if Keep_Pers_Id > 0 then begin
            SQL.Text := 'SELECT * FROM PERSON Where Pers_Id = ' + IntToStr(Pers_Id);
            Open; Edit;
          end else begin
            SQL.Text := 'SELECT * FROM PERSON'; Open;
            Append;
          end;
          FieldByName('PERS_ID').Value := PERS_ID;
          FieldByName('ORG_ID').Value := 1;
          FieldByName('IS_RAB').Value := 1;
          FieldByName('Document').Value := 0;
          FieldByName('FAM').Value := CheckLen(idx_FAM);
          FieldByName('IM').Value := CheckLen(idx_IM);
          FieldByName('OTCH').Value := CheckLen(idx_OTCH);
          FieldByName('MALE').Value := CheckDictonary(idx_MALE,['�','�'],
            Byte(AnsiUpperCase(RightStr(GetCell(idx_OTCH),1))<>'�'));
          FieldByName('BIRTHDAY').Value := CheckDate(idx_BIRTHDAY);
          FieldByName('BIRTHPLACE').Value := CheckLen(idx_BIRTHPLACE);
          FieldByName('NAT_ID').Value := CheckDictonary(idx_NAT_ID,['��','��2','��','��'], 0)+1;
          FieldByName('INN').Value := CheckLen(idx_INN);
          FieldByName('STRAH').Value := CheckLen(idx_STRAH);
          FieldByName('PSP_SER').Value := CheckLen(idx_PSP_SER);
          FieldByName('PSP_NUM').Value := CheckLen(idx_PSP_NUM);
          FieldByName('PSP_PLACE').Value := CheckLen(idx_PSP_PLACE);
          FieldByName('PSP_DATE').Value := CheckDate(idx_PSP_DATE);
          FieldByName('ED_ID').Value := CheckDictonary(idx_ED_ID,
            ['','��','��','���','���','���','���','���','��','����','���','����','���','���'],-1)+1;
          FieldByName('TAB_NUMB').Value := CheckLen(idx_TAB_NUMB);
          FieldByName('WRNG_ID').Value := CheckInt(idx_KWRANGE, [1..37]);
          FieldByName('WSOST_ID').Value := CheckInt(idx_Sostav, [1,2,3,4,5,7,8,9,10,11], True);
          FieldByName('VUS').Value := CheckLen(idx_VUS);
          FieldByName('CAT_ZAP').Value := CheckInt(idx_Cat_Zap, [1,2], True);
          FieldByName('FST_ID').Value := CheckInt(idx_SemPol, [1,2,3,4,5,6,7]);
          FieldByName('WCAT').Value := CheckLen(idx_WCAT);
          FieldByName('IS_WAR').Value := CheckInt(idx_WUCHET1, [0,1]);
          FieldByName('WUCHET1').Value := CheckLen(idx_hasMob);
          FieldByName('OVK_ID').Value := CheckOvk(idx_Voenkomat);
          FieldByName('W_DBEG').Value := CheckDate(idx_War_Date);
          FieldByName('NUMB_T2').Value := CheckInt(idx_Card_Num);
          FieldByName('CONFDATE').Value := Date;
          if Post_Id > 0 then begin
            FieldByName('AppLastAll').AsInteger := Post_Id;
            if CProf_Id = 500 then begin
              FieldByName('AppFirstStudy').AsInteger := Post_Id;
              FieldByName('AppLastStudy').AsInteger := Post_Id;
            end else begin
              FieldByName('AppFirst').AsInteger := Post_Id;
              FieldByName('AppLast').AsInteger := Post_Id;
            end;
          end;

          Post;

          if Keep_Pers_Id < 0 then begin
            Inc(FAdd); laAdd.Caption := IntToStr(FAdd);
          end;
          if IsDuplicate then begin
            Inc(FOverride); laOverride.Caption := IntToStr(FOverride);
          end;
        end;
        Inc(FLine); laLine.Caption := IntToStr(FLine);
        Forms.Application.ProcessMessages;
      end;

    finally
      Quit;
      Disconnect;
    end;

    if not dmMain.isJet then begin
      sFile := ExtractFilePath(ParamStr(0)) + 'GranVusSql2.sql';
      sqlText.LoadFromFile(sFile);
      ExecScript(qry, sqlText);

      sqlText.Free;
    end;
  finally
    Free;
    qry2.Free;
  end;
end;

procedure TfmMain.ExecScript(query: TADOQuery; list: TStringList);
var
  i: Integer;
  s: String;
begin
  query.SQL.Text := '';
  for i := 0 to list.Count - 1 do begin
    s := list[i];
    if Trim(Uppercase(s)) = 'GO' then begin
      if query.SQL.Text <> '' then begin
        query.ExecSQL;
        query.SQL.Text := '';
      end;
    end else if Trim(s) <> '' then
      query.SQL.Add(s);
  end;
  if query.SQL.Text <> '' then
    query.ExecSQL;
end;

function TfmMain.GetFileName: String;
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    Result := ReadString('LoadFromXLS','FileName','');
  finally Free;
  end;
end;

function TfmMain.GetKeepData: boolean;
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    Result := ReadString('LoadFromXLS','KeepData','') = '1';
  finally Free;
  end;
end;

function TfmMain.iif(condition: Boolean; trueValue,
  falseValue: Integer): Integer;
begin
  if condition then Result := trueValue else Result := falseValue;
end;

procedure TfmMain.SetFileName(AFileName: String);
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    WriteString('LoadFromXLS','FileName',AFileName);
  finally Free;
  end;
end;


procedure TfmMain.SetKeepData(isKeepData: boolean);
var
  s: String;
begin
  with TRegistryIniFile.Create(_IniName) do
  try
    s := ''; if isKeepData then s := '1';
    WriteString('LoadFromXLS','KeepData',s);
  finally Free;
  end;
end;

function TfmMain.YesNoAll(Msg: String): Boolean;
var
  D: TForm;
  C: TCheckBox;
begin
  case FYesNoAll of
    ynaYes: Result := True;
    ynaNo: Result := False;
    else begin//ynaAsk
      D := CreateMessageDialog(Msg, mtCustom, [mbYes, mbNo]);
      try
        C := TCheckBox.Create(D); C.Parent := D;
        C.Caption := '��� ����';
        C.Left := 4;
        D.ClientHeight := D.ClientHeight+C.Height;
        C.Top := D.ClientHeight-C.Height-4;
        D.Position := poScreenCenter;
        Result := D.ShowModal = mrYes;
        if C.Checked then begin
          if Result then FYesNoAll := ynaYes else FYesNoAll := ynaNo;
        end;
      finally D.Free;
      end;
    end;
  end;//case
end;

function TfmMain.GetCell(Idx: Integer): String;
begin
  Result := dmMain.ExcelApplication.Cells.Item[FLine+2, Idx].Value;
end;

procedure TfmMain.AddReport(Msg: String; Idx: Integer = 0);
begin
  meReport.Lines.Add(Format('%d '+Msg,[FLine+2, Ifthen(Idx=0, '', ColName[Idx])]));
  laRemark.Caption := IntToStr(meReport.Lines.Count);
end;

end.


unit fConfig;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ComCtrls, CheckLst;

type
  TfmConfig = class(TForm)
    PC: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    edTemp: TEdit;
    sbTemp: TSpeedButton;
    sbRep: TSpeedButton;
    edRep: TEdit;
    Label2: TLabel;
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    chkTimeOut: TCheckBox;
    lbTimeOut: TLabel;
    edTimeOut: TEdit;
    udTimeOut: TUpDown;
    Label6: TLabel;
    edPlug: TEdit;
    sbPlug: TSpeedButton;
    Label5: TLabel;
    edBackUp: TEdit;
    sbBackUp: TSpeedButton;
    Bevel3: TBevel;
    chkExtMenu: TCheckBox;
    TabSheet3: TTabSheet;
    edCommand300: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    rbLeader: TRadioButton;
    rbVUR: TRadioButton;
    TabSheet4: TTabSheet;
    chkUpdate: TCheckBox;
    btnSettings: TButton;
    TabSheet5: TTabSheet;
    lbShowInCard: TCheckListBox;
    lbShowMenu: TCheckListBox;
    Label4: TLabel;
    Label9: TLabel;
    cbMedUst: TCheckBox;
    cb6in18: TCheckBox;
    cbAllGroups: TCheckBox;
    cbFillT2: TCheckBox;
    TabSheet6: TTabSheet;
    eOvkKomissar: TEdit;
    Label10: TLabel;
    eOvkAdmin: TEdit;
    Label11: TLabel;
    cbAbcSort: TCheckBox;
    cbFillT2_9: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure sbTempClick(Sender: TObject);
    procedure sbRepClick(Sender: TObject);
    procedure edTimeOutKeyPress(Sender: TObject; var Key: Char);
    procedure sbPlugClick(Sender: TObject);
    procedure chkTimeOutClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure sbBackUpClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ConfigDlg: boolean;

implementation

uses FileCtrl, IniSupport, ADOdb, dMain, msg, fKbdMouHk, StrUtils, IniFiles, fMain;

{$R *.DFM}

function ConfigDlg: boolean;
var  fmConfig: TfmConfig;
begin
  Application.CreateForm(TfmConfig,fmConfig);
  if fmMain.MainScale <> 100 then
    fmConfig.ScaleBy(fmMain.MainScale, 100);
  Result := fmConfig.ShowModal=mrOk;
  fmConfig.Free;
end;


procedure TfmConfig.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmConfig.sbTempClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выбор папки с шаблонами',EmptyStr,s) then edTemp.Text := s;
end;

procedure TfmConfig.sbRepClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выбор папки с отчетами',EmptyStr,s) then edRep.Text := s;
end;

procedure TfmConfig.sbPlugClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выбор папки с внешними модулями',EmptyStr,s) then edPlug.Text := s;
end;

procedure TfmConfig.edTimeOutKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#0..#27,'0'..'9']) then Key := #0;
end;

procedure TfmConfig.chkTimeOutClick(Sender: TObject);
begin
  lbTimeOut.Enabled := chkTimeOut.Checked;
  edTimeOut.Enabled := chkTimeOut.Checked;
  udTimeOut.Enabled := chkTimeOut.Checked;
end;

procedure TfmConfig.FormShow(Sender: TObject);
var
  HideInCard, HideMenu: String;
  i: Integer;
begin
  HideInCard := ''; HideMenu := '';
  chkTimeOut.Checked := IniSupport.GetTimeOut>0;
  chkTimeOut.OnClick(chkTimeOut);
  udTimeOut.Position := abs(IniSupport.GetTimeOut div 60);
  edTemp.Text := IniSupport.GetTemplatesDir;
  edRep.Text := IniSupport.GetReportsDir;
  edPlug.Text := IniSupport.GetPlugInsDir;
  edBackUp.Text := IniSupport.GetBackUpDir;
  chkExtMenu.Checked := IniSupport.GetExtMenu;
  cbMedUst.Checked := True;
  cb6in18.Checked := False;
  with TADOQuery.Create(nil) do
  try
    Connection := dmMain.dbMain;
    SQL.Text := 'SELECT Template FROM [Command300]';
    Open;
    edCommand300.Text := Fields[0].AsString;
    Close;
    SQL.Text := 'SELECT Param_ID, Param_Value FROM Params';
    Open;
    while not EOF do begin
      case Fields[0].AsInteger of
        1: rbVUR.Checked := Fields[1].AsString = '1';
        2: chkUpdate.Checked := Fields[1].AsString = '1';
        3: HideInCard := Fields[1].AsString;
        4: HideMenu := Fields[1].AsString;
        6: cbAbcSort.Checked := Fields[1].AsString = '1';
        8: cbMedUst.Checked := Fields[1].AsString = '1';
        9: cb6in18.Checked := Fields[1].AsString = '1';
        10: cbAllGroups.Checked := Fields[1].AsString = '1';
        11: cbFillT2.Checked := Fields[1].AsString = '1';
        12: eOvkKomissar.Text := Fields[1].AsString;
        13: eOvkAdmin.Text := Fields[1].AsString;
        14: cbFillT2_9.Checked := Fields[1].AsString = '1';
      end;
      Next;
    end;
    rbLeader.Checked := not rbVUR.Checked;
  finally Free;
  end;

  for i := 0 to lbShowInCard.Items.Count - 1 do
    lbShowInCard.Checked[i] := Pos('.'+IntToStr(i)+'.', HideInCard) <= 0;

  for i := 0 to lbShowMenu.Items.Count - 1 do
    lbShowMenu.Checked[i] := Pos('.'+IntToStr(i)+'.', HideMenu) <= 0;

end;

procedure TfmConfig.btnSettingsClick(Sender: TObject);
type
  ShowCustomUserSettings = procedure(bFTP, bHTTP, bProxy, bDB, bHDD, bDBVersion: Boolean); stdcall;
var
  proc: FarProc;
  Lib: HINST;
begin
  if CheckUpdateLibrary then begin
    Lib:=LoadLibrary(uFile);
    try
      Proc:=GetProcAddress(Lib, 'ShowCustomUserSettings');
      if Assigned(Proc) then ShowCustomUserSettings(Proc)(True, True, True, False, True, True);
    finally
      FreeLibrary(Lib);
    end;
  end
  else ShowMessage('Библиотека ' + uFile + ' не найдена!');
end;

procedure TfmConfig.Button1Click(Sender: TObject);
var
  HideInCard, HideMenu: String;
  i: Integer;
begin
  HideInCard := '.'; HideMenu := '.';
  for i := 0 to lbShowInCard.Items.Count - 1 do
    if not lbShowInCard.Checked[i] then
      HideInCard := HideInCard + IntToStr(i) + '.';

  for i := 0 to lbShowMenu.Items.Count - 1 do
    if not lbShowMenu.Checked[i] then
      HideMenu := HideMenu + IntToStr(i) + '.';

  with TADOQuery.Create(Self) do
  try
    Connection := dmMain.dbMain;
    ParamCheck := False;
    SQL.Text := 'UPDATE Params SET Param_value = ' + IfThen(rbVUR.Checked, '''1''', '''0''') +
                ' where Param_ID = 1';
    ExecSQL;
    SQL.Text := 'UPDATE Params SET Param_value = ' + IfThen(chkUpdate.Checked, '''1''', '''0''') +
                ' where Param_ID = 2';
    ExecSQL;
    SQL.Text := 'UPDATE [Command300] SET Template = '+QuotedStr(edCommand300.Text);
    ExecSQL;

    SQL.Text := 'Select * From Params Where Param_Id = 3';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 3;
    end else
      Edit;
    FieldByName('Param_Value').AsString := HideInCard;
    Post;
    Close;

    SQL.Text := 'Select * From Params Where Param_Id = 4';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 4;
    end else
      Edit;
    FieldByName('Param_Value').AsString := HideMenu;
    Post;
    Close;

    SQL.Text := 'Select * From Params Where Param_Id = 6';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 6;
      FieldByName('Param_Name').AsString := 'Сортировка по алфавиту';
    end else
      Edit;
    FieldByName('Param_Value').AsString := IfThen(cbAbcSort.Checked, '1', '0');
    Post;
    Close;

    SQL.Text := 'Select * From Params Where Param_Id = 8';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 8;
      FieldByName('Param_Name').AsString := 'Подставлять к званию приставку «медицинской службы» или «юстиции»';
    end else
      Edit;
    FieldByName('Param_Value').AsString := IfThen(cbMedUst.Checked, '1', '0');
    Post;
    Close;

    SQL.Text := 'Select * From Params Where Param_Id = 9';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 9;
      FieldByName('Param_Name').AsString := 'Помещать числовые данные в п.15 формы № 18';
    end else
      Edit;
    FieldByName('Param_Value').AsString := IfThen(cb6in18.Checked, '1', '0');
    Post;
    Close;

    SQL.Text := 'Select * From Params Where Param_Id = 10';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 10;
      FieldByName('Param_Name').AsString := 'Доступны все группы учета';
    end else
      Edit;
    FieldByName('Param_Value').AsString := IfThen(cbAllGroups.Checked, '1', '0');
    Post;
    Close;

    SQL.Text := 'Select * From Params Where Param_Id = 11';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 11;
      FieldByName('Param_Name').AsString := 'Заполнять п.7 раздела II формы Т-2';
    end else
      Edit;
    FieldByName('Param_Value').AsString := IfThen(cbFillT2.Checked, '1', '0');
    Post;
    Close;

    SQL.Text := 'Select * From Params Where Param_Id = 12';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 12;
    end else
      Edit;
    FieldByName('Param_Value').AsString := eOvkKomissar.Text;
    Post;
    Close;

    SQL.Text := 'Select * From Params Where Param_Id = 13';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 13;
    end else
      Edit;
    FieldByName('Param_Value').AsString := eOvkAdmin.Text;
    Post;
    Close;

    SQL.Text := 'Select * From Params Where Param_Id = 14';
    Open;
    if Eof then begin
      Append;
      FieldByName('Param_Id').AsInteger := 14;
      FieldByName('Param_Name').AsString := 'Заполнять п.9 раздела II (сведения о воинском учете) формы Т-2 (ВУС)';
    end else
      Edit;
    FieldByName('Param_Value').AsString := IfThen(cbFillT2_9.Checked, '1', '0');
    Post;
    Close;

    dmMain.isAbcSort := dmMain.GetParamValue(6) = '1';
  finally Free;
  end;
  if ChkTimeOut.Checked
    then IniSupport.SetTimeOut(udTimeOut.Position*60)
    else IniSupport.SetTimeOut(0);
  IniSupport.SetPlugInsDir(edPlug.Text);
  IniSupport.SetTemplatesDir(edTemp.Text);
  IniSupport.SetReportsDir(edRep.Text);
  IniSupport.SetBackUpDir(edBackUp.Text);
  IniSupport.SetExtMenu(chkExtMenu.Checked);
  dmMain.time_out := IniSupport.GetTimeOut;
  EnableHook(dmMain.time_out);
  ModalResult := mrOk;
end;

procedure TfmConfig.sbBackUpClick(Sender: TObject);
var s: string;
begin
  if SelectDirectory('Выбор папки с файлами резервных копий',EmptyStr,s) then edBackUp.Text := s;
end;

end.

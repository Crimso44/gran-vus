unit fEventFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ComCtrls, Buttons, Menus;

type
  TfmEventFilter = class(TForm)
    laWhen: TLabel;
    dtWhenFromDate: TDateTimePicker;
    dtWhenToDate: TDateTimePicker;
    laFrom: TLabel;
    laTo: TLabel;
    dtWhenFromTime: TDateTimePicker;
    dtWhenToTime: TDateTimePicker;
    laWhat: TLabel;
    clbWhat: TCheckListBox;
    clbWhere: TCheckListBox;
    laWhere: TLabel;
    cbWhenFromDate: TCheckBox;
    cbWhenFromTime: TCheckBox;
    cbWhenToDate: TCheckBox;
    cbWhenToTime: TCheckBox;
    laWho: TLabel;
    edWho: TComboBox;
    pbOk: TBitBtn;
    pbCancel: TBitBtn;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    mnuSetAllEventsOn: TMenuItem;
    mnuSetAllEventsOff: TMenuItem;
    mnuSetAllObjectsOn: TMenuItem;
    mnuSetAllObjectsOff: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure cbWhenFromDateClick(Sender: TObject);
    procedure pbOkClick(Sender: TObject);
    procedure mnuSetAllEventsOnClick(Sender: TObject);
    procedure mnuSetAllEventsOffClick(Sender: TObject);
    procedure mnuSetAllObjectsOnClick(Sender: TObject);
    procedure mnuSetAllObjectsOffClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FSQL: String;
  end;

function Execute: Boolean;

implementation

uses dMain, SaveEvents, IniSupport, Math, ADODB, Msg;

{$R *.dfm}

function Execute: Boolean;
begin
  with TfmEventFilter.Create(Application) do
  try Result := ShowModal=mrOk;
  finally Free;
  end;
end;

const
  EventCount = 19;
  Events: array [0..EventCount-1] of String =
   (evs_Login_Ok,
    evs_Login_Failed,
    evs_Logout,
    evs_Report_Print,
    evs_Report_Error,
    evs_Form6_Error,
    evs_Form6_Generate,
    evs_Form6_Check_Ok,
    evs_Form6_Check_Failed,
    evs_Backup,
    evs_Backup_Failed,
    evs_Restore,
    evs_Restore_Failed,
    evs_Export,
    evs_Export_Failed,
    evs_Import,
    evs_Import_Failed,
    evs_EventLog_Clear,
    evs_EventLog_Clear_Failed);

procedure TfmEventFilter.FormCreate(Sender: TObject);
var
  I : Integer;
  L : TStringList;
begin
  with GetEventFilter do begin
    with TADOQuery.Create(nil) do
    try
      Connection := dmMain.dbMain;
      SQL.Text := 'SELECT Fam+'' ''+Left(Im,1)+''.''+Left(Otch,1)+''. (''+Login+'')'' AS Login '+
                  '     , ID FROM Users UNION '+
                  'SELECT ''<Все>'',0 FROM Users ORDER BY Login';
      Open;
      while not Eof do begin
        edWho.Items.AddObject(Fields[0].AsString, TObject(Fields[1].AsInteger));
        Next;
      end;
    finally Free;
    end;
    I := edWho.Items.IndexOfObject(TObject(efWho));
    edWho.ItemIndex := Max(I, 0);
    cbWhenFromDate .Checked  := efFromDateCheck;
    dtWhenFromDate .DateTime := efFromDateValue;
    cbWhenFromTime .Checked  := efFromTimeCheck;
    dtWhenFromTime .DateTime := efFromTimeValue;
    cbWhenToDate   .Checked  := efToDateCheck;
    dtWhenToDate   .DateTime := efToDateValue;
    cbWhenToTime   .Checked  := efToTimeCheck;
    dtWhenToTime   .DateTime := efToTimeValue;
    L := TStringList.Create;
    try
      L.Text := efNotEvents;
      for I := 0 to EventCount-1 do begin
        clbWhat.Items.Add(Events[I]);
        clbWhat.Checked[I] := L.IndexOf(Events[I])<0;
      end;
      with TADOQuery.Create(nil) do
      try
        Connection := dmMain.dbMain;
        SQL.Text := 'SELECT DISTINCT Object FROM Event ORDER BY Object';
        Open;
        while not Eof do begin clbWhere.Items.Add(Fields[0].AsString); Next; end;
      finally Free;
      end;
      L.Text := efNotObjects;
      for I := 0 to clbWhere.Count-1 do
        clbWhere.Checked[I] := L.IndexOf(clbWhere.Items[I])<0;
    finally L.Free;
    end;
  end;
end;

procedure TfmEventFilter.cbWhenFromDateClick(Sender: TObject);
var
  cb : TCheckBox absolute Sender;
  c  : TControl;
begin
  c := FindComponent('dt'+Copy(cb.Name,3,40)) As TControl;
  c.Enabled := cb.Checked and cb.Enabled;
  if cb.Name = 'cbWhenFromDate' then begin
    cbWhenFromTime.Enabled := cb.Checked;
    dtWhenFromTime.Enabled := cb.Checked and cbWhenFromTime.Checked;
  end else
  if cb.Name = 'cbWhenToDate' then begin
    cbWhenToTime.Enabled := cb.Checked;
    dtWhenToTime.Enabled := cb.Checked and cbWhenToTime.Checked;
  end;
end;

procedure TfmEventFilter.pbOkClick(Sender: TObject);
var
  ef           : TEventFilter;
  I            : Integer;
  L            : TStringList;
  dtFrom, dtTo : TDateTime;
  NoCheck      : Boolean;
begin
  dtFrom := 0; dtTo := 0; //prevent compiler's warnings
  with ef do begin
    with edWho do
    efWho           := Integer(Items.Objects[ItemIndex]);
    efFromDateCheck := cbWhenFromDate.Checked;
    efFromDateValue := dtWhenFromDate.DateTime;
    efFromTimeCheck := cbWhenFromTime.Checked;
    efFromTimeValue := dtWhenFromTime.DateTime;
    efToDateCheck   := cbWhenToDate.Checked;
    efToDateValue   := dtWhenToDate.DateTime;
    efToTimeCheck   := cbWhenToTime.Checked;
    efToTimeValue   := dtWhenToTime.DateTime;
    if efFromDateCheck then begin
      dtFrom := efFromDateValue;
      if efFromTimeCheck then dtFrom := dtFrom + efFromTimeValue;
    end;
    if efToDateCheck then begin
      dtTo := efToDateValue;
      if efToTimeCheck then dtTo := dtTo + efToTimeValue;
    end;
    if efFromDateCheck and efToDateCheck and (dtFrom>dtTo) then begin
      ShowErr('Определённый временной интервал заведомо пуст. Проверьте значения в группе "Когда".');
      dtWhenFromDate.SetFocus;
      ModalResult := mrNone; Exit;
    end;

    L := TStringList.Create;
    try
      NoCheck := True;
      for I := 0 to EventCount-1 do
      if not clbWhat.Checked[I]
        then L.Add(clbWhat.Items[I])
        else NoCheck := False;
      efNotEvents := L.Text;
      if NoCheck then begin
        ShowErr('Для просмотра журнала событий должен быть выбран хотя бы один элемент в списке "Что".');
        clbWhat.SetFocus;
        ModalResult := mrNone; Exit;
      end;
      L.Clear;
      NoCheck := True;
      for I := 0 to clbWhere.Count-1 do
      if not clbWhere.Checked[I]
        then L.Add(clbWhere.Items[I])
        else NoCheck := False;
      efNotObjects := L.Text;
      if NoCheck then begin
        ShowErr('Для просмотра журнала событий должен быть выбран хотя бы один элемент в списке "Где".');
        clbWhere.SetFocus;
        ModalResult := mrNone; Exit;
      end;
    finally L.Free;
    end;
  end;
  SetEventFilter(ef);
end;

procedure SetCLBAll(clb: TCheckListBox; Value: Boolean);
var I: Integer;
begin
  for I := 0 to clb.Count-1 do clb.Checked[I] := Value;
end;


procedure TfmEventFilter.mnuSetAllEventsOnClick(Sender: TObject);
begin
  SetCLBAll(clbWhat, True);
end;

procedure TfmEventFilter.mnuSetAllEventsOffClick(Sender: TObject);
begin
  SetCLBAll(clbWhat, False);
end;

procedure TfmEventFilter.mnuSetAllObjectsOnClick(Sender: TObject);
begin
  SetCLBAll(clbWhere, True);
end;

procedure TfmEventFilter.mnuSetAllObjectsOffClick(Sender: TObject);
begin
  SetCLBAll(clbWhere, False);
end;

end.

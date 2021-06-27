unit fImportSPO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ActnList, DB, ADODB;

type
  TfmImportSPO = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    pbPrev: TButton;
    pbNext: TButton;
    pbAgain: TButton;
    pbClose: TButton;
    laSubj: TLabel;
    edSubj: TEdit;
    laFileName: TLabel;
    edFileName: TEdit;
    pbOpen: TButton;
    OpenDialog: TOpenDialog;
    Label1: TLabel;
    edF6_SHIFR: TEdit;
    Label2: TLabel;
    edF6: TMemo;
    Label3: TLabel;
    edORGNAME: TEdit;
    Label4: TLabel;
    edDate: TEdit;
    Label5: TLabel;
    edF6_COUNT: TEdit;
    Label6: TLabel;
    edKUO_COUNT: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    ActionList1: TActionList;
    actPrev: TAction;
    actNext: TAction;
    actAgain: TAction;
    qry: TADOQuery;
    edORG_SHIFR: TEdit;
    Label9: TLabel;
    sp_Form6Create: TADOStoredProc;
    procedure pbOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pbCloseClick(Sender: TObject);
    procedure ActionList1Update(Action: TBasicAction;
      var Handled: Boolean);
    procedure actPrevExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actAgainExecute(Sender: TObject);
  private
    { Private declarations }
    FData: TStringList;
    FSubjID: Integer;
  public
    { Public declarations }
  end;


procedure ImportSPO(ASubjID: Integer);

implementation

uses dMain, StrUtils;

{$R *.dfm}

procedure ImportSPO(ASubjID: Integer);
begin
  with TfmImportSPO.Create(Application) do
  try
    FSubjID := ASubjID;
    with qry do
    try
      SQL.Text := 'SELECT SUBJ_NAME FROM SUBJ WHERE SUBJ_ID = '+IntToStr(ASubjID);
      Open;
      edSubj.Text := Fields[0].AsString;
    finally Close;
    end;
    ShowModal;
  finally Free;
  end;
end;


procedure TfmImportSPO.FormCreate(Sender: TObject);
begin
  FData := TStringList.Create;
  PageControl1.ActivePageIndex := 0;
end;

procedure TfmImportSPO.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FData);
end;

procedure TfmImportSPO.pbOpenClick(Sender: TObject);
var I: Integer;
begin
  if not OpenDialog.Execute then Exit;
  edFileName.Text := OpenDialog.FileName;
  FData.LoadFromFile(OpenDialog.FileName);
  edF6_SHIFR  .Text := '';
  edORGNAME   .Text := '';
  edDate      .Text := '';
  edF6_COUNT  .Text := '';
  edKUO_COUNT .Text := '';
  edF6.Clear;
  for I := 0 to FData.Count-1 do
  case I of
    0: edORG_SHIFR.Text  := FData[I];
    1..20,22..27: edF6.Lines.Add(FData[I]);
    28: edORGNAME.Text   := FData[I];
    29: edDate.Text      := FData[I];
    30: edF6_COUNT.Text  := FData[I];
    31: edKUO_COUNT.Text := FData[I];
    32: edF6_SHIFR.Text  := FData[I];
  end;
end;

procedure TfmImportSPO.pbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmImportSPO.ActionList1Update(Action: TBasicAction;
  var Handled: Boolean);
begin
  actPrev .Enabled := PageControl1.ActivePageIndex = 1;
  actNext .Enabled := (PageControl1.ActivePageIndex < 2) and (edFileName.Text <> '');
  actAgain.Enabled := PageControl1.ActivePageIndex = 2;
end;

procedure TfmImportSPO.actPrevExecute(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

procedure TfmImportSPO.actNextExecute(Sender: TObject);
//
  function ImpF6Line(S: String): String;
  var I,J,N: Integer; Value: Boolean;
  begin
    Result := 'UPDATE FORM6 SET ';
    S := S + ' ';
    N := 0; //Value count
    Value := S[1] in ['0'..'9'];
    J := 1; // Any way
    for I := 1 to Length(S) do
    if S[I] in ['0'..'9'] then begin
      if not Value then begin
        Value := True; J := I;
      end;
    end
    else begin
      if Value then begin
        Inc(N);
        Value := False; Result := Result + Format(' COL_%d = NULLIF(%d,0),',
          [N, StrToIntDef(Copy(S, J, I-J),0)]);
        if N=16 then Break;
      end;
    end;
    for I := N+1 to 16 do Result := Result + Format(' COL_%d = NULL,',[I]);
    SetLength(Result,Length(Result)-1); //Strip last comma
  end;
//
var
  F6_ID : Integer;
  I     : Integer;
begin
  if PageControl1.ActivePageIndex = 1 then
  try     Screen.Cursor := crHourGlass;
    if not AnsiMatchText(edF6_SHIFR.Text,['01','02','03']) then edF6_SHIFR.Text := '01';
    with qry do
    try
      SQL.Text := Format('SELECT * FROM FORM6HDR WHERE F6_SHIFR=''%s'' AND SUBJ_ID=%d',
        [edF6_SHIFR.Text, FSubjID]);
      Open;
      if IsEmpty then begin
        sp_Form6Create.Parameters.ParamValues['@SUBJ_ID']:= FSubjID;
        sp_Form6Create.ExecProc;
        Requery;
      end;
      Edit;
      FieldByName('ORGNAME')  .AsString  := edORGNAME.Text;
      FieldByName('ORG_SHIFR').AsString  := edORG_SHIFR.Text;
      FieldByName('F6_COUNT') .AsInteger := StrToIntDef(edF6_COUNT.Text,0);
      FieldByName('KUO_COUNT').AsInteger := StrToIntDef(edKUO_COUNT.Text,0);
      FieldByName('CHECKED')  .AsBoolean := False;
      Post;
      F6_ID := FieldByName('F6_ID').AsInteger;
      Close;
      for I := 0 to edF6.Lines.Count-1 do begin
        SQL.Text := Format('%s WHERE F6_ID=%d AND COL_B=%d',
          [ImpF6Line(edF6.Lines[I]),F6_ID,I+1]);
        ExecSQL;
      end;
      SQL.Text := 'SELECT * FROM SUBJ WHERE SUBJ_ID='+IntToStr(FSubjID);
      Open;
      Edit;
      FieldByName('REPORT_DATE').AsDateTime := StrToDateTimeDef(edDate.Text, Date);
      Post;
      Close;
      SQL.Text := 'UPDATE FORM6HDR SET '+
        ' RAB_COUNT = FORM6.COL_1'+
        ',ZAP_COUNT = FORM6.COL_2'+
        ',ZAB_COUNT = FORM6.COL_7'+
        ' FROM FORM6, FORM6HDR'+
        ' WHERE FORM6.F6_ID=FORM6HDR.F6_ID'+
        ' AND FORM6.CPROF_ID=1000'+
        ' AND FORM6HDR.F6_ID = '+IntToStr(F6_ID);
      ExecSQL;
    finally Close;
    end;
  finally Screen.Cursor := crDefault;
  end;
  PageControl1.ActivePageIndex := PageControl1.ActivePageIndex+1;
end;

procedure TfmImportSPO.actAgainExecute(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
  edFileName.Text := '';
end;

end.

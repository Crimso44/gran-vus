unit fTPDPPost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ActnList, Buttons, FrmKeep, Menus, ADODB;

type
  TfmTPDPPost = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ActionList: TActionList;
    actAdd: TAction;
    actDel: TAction;
    actSelectAll: TAction;
    FrmKeep1: TFrmKeep;
    edOKPDTR: TEdit;
    Label2: TLabel;
    edOKPDTRName: TEdit;
    Label3: TLabel;
    Label1: TLabel;
    edCPROF: TComboBox;
    lbPosts: TListBox;
    Label4: TLabel;
    lbAvailablePosts: TListBox;
    Label5: TLabel;
    bAddPost: TSpeedButton;
    bDelPost: TSpeedButton;
    lWarning: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure edCPROFChange(Sender: TObject);
    procedure bAddPostClick(Sender: TObject);
    procedure bDelPostClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    q: TADOQuery;
    procedure LoadPosts;
  end;

var
  fmTPDPPost: TfmTPDPPost;

implementation


{$R *.dfm}

uses dMain, msg;

procedure TfmTPDPPost.bAddPostClick(Sender: TObject);
var
  i: Integer;
begin
  if lbAvailablePosts.ItemIndex >= 0 then begin
    lbPosts.AddItem(lbAvailablePosts.Items[lbAvailablePosts.ItemIndex], lbAvailablePosts.Items.Objects[lbAvailablePosts.ItemIndex]);
    lbAvailablePosts.Items.Delete(lbAvailablePosts.ItemIndex);
  end;
  if edCProf.ItemIndex < 0 then begin
    with q do begin
      SQL.Text :=
        'Select CProf2015_Id From KPost '+
        'Where Post_Id = ' + IntToStr(Integer(lbPosts.Items.Objects[0]));
      Open;
      i := Fields[0].AsInteger;
      Close;
      edCProf.ItemIndex := edCProf.Items.IndexOfObject(Pointer(i));
      LoadPosts;
    end;
  end;
  lWarning.Visible := False;
end;

procedure TfmTPDPPost.bDelPostClick(Sender: TObject);
begin
  if lbPosts.ItemIndex >= 0 then begin
    lbAvailablePosts.AddItem(lbPosts.Items[lbPosts.ItemIndex], lbPosts.Items.Objects[lbPosts.ItemIndex]);
    lbPosts.Items.Delete(lbPosts.ItemIndex);
  end;
  lWarning.Visible := lbPosts.Items.Count = 0;
end;

procedure TfmTPDPPost.BitBtn1Click(Sender: TObject);
begin
  if edCprof.ItemIndex < 0 then begin
    ShowErr('Выберите категорию должности!');
    ModalResult := mrNone;
  end else if Trim(edOKPDTRName.Text) = '' then begin
    ShowErr('Заполните наименование должности!');
    ModalResult := mrNone;
  end;
end;

procedure TfmTPDPPost.edCPROFChange(Sender: TObject);
begin
  LoadPosts;
end;

procedure TfmTPDPPost.FormCreate(Sender: TObject);
begin
  q := TADOQuery.Create(Self);
  with q do begin
    Connection := dmMain.dbMain; ParamCheck := False;

    SQL.Text :=
      'Select CProf_Id, CProf_Name From KCProf2015 '+
      'Where State = 0 Order By CProf_Id';
    Open;
    while not Eof do begin
      edCPROF.AddItem(Fields[1].AsString, Pointer(Fields[0].AsInteger));
      Next;
    end;
    Close;
  end;
  LoadPosts;
end;

procedure TfmTPDPPost.LoadPosts;
var
  l: TList;
  i: Integer;
  p: Pointer;
begin
  l := TList.Create;
  for i := 0 to lbPosts.Items.Count - 1 do
    l.Add(Pointer(lbPosts.Items.Objects[i]));
  with q do begin
    SQL.Text :=
      'Select Post_Id, Post_Name From KPost '+
      'Where KOKPDTR is null';
    if edCProf.ItemIndex >= 0 then
      SQL.Add(' and CProf2015_Id = ' + IntToStr(Integer(edCProf.Items.Objects[edCProf.ItemIndex])));
    Open;
    lbPosts.Items.Clear; lbAvailablePosts.Items.Clear;
    while not Eof do begin
      p := Pointer(Fields[0].AsInteger);
      if l.IndexOf(p) >= 0 then
        lbPosts.AddItem(Fields[1].AsString, p)
      else
        lbAvailablePosts.AddItem(Fields[1].AsString, p);
      Next;
    end;
    Close;
  end;
  lWarning.Visible := True;
  l.Free;
end;

end.

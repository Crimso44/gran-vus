unit fSetFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls;

type
  TfxSetFilter = class(TForm)
    Panel1: TPanel;
    Splitter2: TSplitter;
    Panel3: TPanel;
    Panel5: TPanel;
    bDepsNone: TBitBtn;
    bDepsAll: TBitBtn;
    cbDeps: TCheckListBox;
    Panel2: TPanel;
    Panel4: TPanel;
    bPostsNone: TBitBtn;
    bPostsAll: TBitBtn;
    cbPosts: TCheckListBox;
    Panel6: TPanel;
    bOK: TButton;
    bCancel: TButton;
    bAbort: TButton;
    procedure bPostsAllClick(Sender: TObject);
    procedure bPostsNoneClick(Sender: TObject);
    procedure bDepsAllClick(Sender: TObject);
    procedure bDepsNoneClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fxSetFilter: TfxSetFilter;

implementation

{$R *.dfm}

procedure TfxSetFilter.bDepsAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbDeps.Items.Count - 1 do
    cbDeps.Checked[i] := True;
end;

procedure TfxSetFilter.bDepsNoneClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbDeps.Items.Count - 1 do
    cbDeps.Checked[i] := False;
end;

procedure TfxSetFilter.bPostsAllClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbPosts.Items.Count - 1 do
    cbPosts.Checked[i] := True;
end;

procedure TfxSetFilter.bPostsNoneClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to cbPosts.Items.Count - 1 do
    cbPosts.Checked[i] := False;
end;

end.

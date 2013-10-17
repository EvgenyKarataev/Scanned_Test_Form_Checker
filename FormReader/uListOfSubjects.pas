unit uListOfSubjects;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls;

type
  TfmListOfSubjects = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    clbListOfSubjects: TCheckListBox;
    bbSelAllSubjects: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    bbDelSelAllSubjects: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure bbSelAllSubjectsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure clbListOfSubjectsClick(Sender: TObject);
    procedure bbDelSelAllSubjectsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListOfSubjects: TfmListOfSubjects;

implementation

uses uEditorCodes;

{$R *.dfm}

procedure TfmListOfSubjects.FormShow(Sender: TObject);
var
  i: Integer;
begin
  clbListOfSubjects.Clear;
  for i := 0 to High(fmEditorCodes.SubjectsFromFile) do
    clbListOfSubjects.Items.Add(fmEditorCodes.SubjectsFromFile[i]);

  bbDelSelAllSubjects.Enabled := False;
  bbSelAllSubjects.Enabled := True;
end;

procedure TfmListOfSubjects.bbSelAllSubjectsClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to clbListOfSubjects.Count - 1 do
    clbListOfSubjects.Checked[i] := True;

  bbDelSelAllSubjects.Enabled := True;
  bbSelAllSubjects.Enabled := False;
end;

procedure TfmListOfSubjects.FormCreate(Sender: TObject);
begin
  Self.Left := fmEditorCodes.Left + (fmEditorCodes.Width - Self.Width) div 2;
  Self.Top := fmEditorCodes.Height div 2;
end;

procedure TfmListOfSubjects.clbListOfSubjectsClick(Sender: TObject);
var
  i: Integer;
begin
  clbListOfSubjects.Tag := 0;

  
  for i := 0 to clbListOfSubjects.Count - 1 do
    if clbListOfSubjects.Checked[i] then
      clbListOfSubjects.Tag := clbListOfSubjects.Tag + 1;

    if clbListOfSubjects.Tag = clbListOfSubjects.Count then
      begin
        bbDelSelAllSubjects.Enabled := True;
        bbSelAllSubjects.Enabled := False;
      end //  if clbListOfSubjects.Tag = clbListOfSu
    else if clbListOfSubjects.Tag = 0 then
           begin
             bbDelSelAllSubjects.Enabled := False;
             bbSelAllSubjects.Enabled := True;
           end   // if clbListOfSubjects.Tag = clbListOfSubjects.Count
         else
           begin
             bbDelSelAllSubjects.Enabled := True;
             bbSelAllSubjects.Enabled := True;
           end;
end;

procedure TfmListOfSubjects.bbDelSelAllSubjectsClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to clbListOfSubjects.Count - 1 do
    clbListOfSubjects.Checked[i] := False;

  bbDelSelAllSubjects.Enabled := False;
  bbSelAllSubjects.Enabled := True;
end;

end.

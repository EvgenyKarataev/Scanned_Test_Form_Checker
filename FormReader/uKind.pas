unit uKind;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TfmView = class(TForm)
    pcOptions: TPageControl;
    TabSheet1: TTabSheet;
    gbFount: TGroupBox;
    lbName: TListBox;
    edName: TEdit;
    edStyle: TEdit;
    lbStyle: TListBox;
    edSize: TEdit;
    lbSize: TListBox;
    GroupBox1: TGroupBox;
    cbColor: TColorBox;
    lbColor: TLabel;
    GroupBox2: TGroupBox;
    lbDelColor: TLabel;
    lbSetColor: TLabel;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    bDef: TButton;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    cbDefColor: TColorBox;
    cbSelColor: TColorBox;
    cbSelSub: TColorBox;
    cbShowNumber: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure bDefClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbSizeClick(Sender: TObject);
    procedure edSizeChange(Sender: TObject);
    procedure edSizeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edSizeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbStyleClick(Sender: TObject);
    procedure edStyleChange(Sender: TObject);
    procedure edStyleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edStyleKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbNameClick(Sender: TObject);
    procedure edNameChange(Sender: TObject);
    procedure edNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edNameKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    FontStyle: TFontStyles;
  end;

var
  fmView: TfmView;

implementation

uses uEditorCodes;

{$R *.dfm}

procedure TfmView.bDefClick(Sender: TObject);
begin
  cbColor.Selected := cbColor.DefaultColorColor;
  cbDefColor.Selected := cbDefColor.DefaultColorColor;
  cbSelColor.Selected := cbSelColor.DefaultColorColor;
  cbSelSub.Selected := cbSelSub.DefaultColorColor;

  edSize.Text := '7';
  edName.Text := 'Tahoma';
  edStyle.Text := 'обычный';
  FontStyle := [];                                                

  edName.SetFocus;
end;

procedure TfmView.FormShow(Sender: TObject);
var
  i: Integer;
begin
  cbColor.Selected := fmEditorCodes.FontColor;
  cbDefColor.Selected := fmEditorCodes.DefColor;
  cbSelColor.Selected := fmEditorCodes.SelColor;
  cbSelSub.Selected := fmEditorCodes.SelSub;
  cbShowNumber.Checked := fmEditorCodes.acShowNumbers.Checked;
  edSize.Text := IntToStr(fmEditorCodes.FontSize);
  edName.Text := fmEditorCodes.FontName;

  if fmEditorCodes.FontStyle = [] then
    edStyle.Text := 'обычный'
  else if fmEditorCodes.FontStyle = [fsBold] then
    edStyle.Text := 'жирный'
  else if fmEditorCodes.FontStyle = [fsItalic] then
    edStyle.Text := 'курсив'
  else if fmEditorCodes.FontStyle = [fsBold, fsItalic] then
    edStyle.Text := 'жирный курсив';

  edName.SetFocus;
end;

procedure TfmView.lbSizeClick(Sender: TObject);
begin
  edSize.Text := lbSize.Items.Strings[lbSize.ItemIndex];
  edSize.SetFocus;
  edSize.SelectAll;
end;

procedure TfmView.edSizeChange(Sender: TObject);
begin
  if lbSize.Items.IndexOf(edSize.Text) <> -1 then
    lbSize.Selected[lbSize.Items.IndexOf(edSize.Text)] := True
  else
    lbSize.Selected[lbSize.ItemIndex] := False;
end;

procedure TfmView.edSizeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 38)or(Key = 40) then
  begin
    lbSize.SetFocus;
    if (lbSize.ItemIndex > 0) and ( lbSize.ItemIndex < lbSize.Count) then
      begin
        if Key = 38 then
          lbSize.ItemIndex := lbSize.ItemIndex - 1
        else if Key = 40 then
          lbSize.ItemIndex := lbSize.ItemIndex + 1;

        lbSize.OnClick(nil);
      end;
   end;
end;

procedure TfmView.edSizeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 38)or(Key = 40) then
    edSize.SelectAll;
end;

procedure TfmView.lbStyleClick(Sender: TObject);
begin
  edStyle.Text := lbStyle.Items.Strings[lbStyle.ItemIndex];
  if edStyle.Text = 'обычный' then
    FontStyle := []
  else if edStyle.Text = 'курсив' then
    FontStyle := [fsItalic]
  else if edStyle.Text = 'жирный' then
    FontStyle := [fsBold]
  else if edStyle.Text = 'жирный курсив' then
    FontStyle := [fsBold, fsItalic];

  edStyle.SetFocus;
  edStyle.SelectAll;
end;

procedure TfmView.edStyleChange(Sender: TObject);
begin
  if lbStyle.Items.IndexOf(edStyle.Text) <> -1 then
    lbStyle.Selected[lbStyle.Items.IndexOf(edStyle.Text)] := True
  else
    lbStyle.Selected[lbStyle.ItemIndex] := False;
end;

procedure TfmView.edStyleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 38)or(Key = 40) then
  begin
    lbStyle.SetFocus;
    if (lbStyle.ItemIndex > 0) and ( lbStyle.ItemIndex < lbStyle.Count) then
      begin
        if Key = 38 then
          lbStyle.ItemIndex := lbStyle.ItemIndex - 1
        else if Key = 40 then
          lbStyle.ItemIndex := lbStyle.ItemIndex + 1;

        lbStyle.OnClick(nil);
      end;
   end;
end;

procedure TfmView.edStyleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 38)or(Key = 40) then
    edStyle.SelectAll;
end;

procedure TfmView.lbNameClick(Sender: TObject);
begin
  edName.Text := lbName.Items.Strings[lbName.ItemIndex];
  edName.SetFocus;
  edName.SelectAll;
end;

procedure TfmView.edNameChange(Sender: TObject);
begin
  if lbName.Items.IndexOf(edName.Text) <> -1 then
    lbName.Selected[lbName.Items.IndexOf(edName.Text)] := True
  else
    lbName.Selected[lbName.ItemIndex] := False;
end;

procedure TfmView.edNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 38)or(Key = 40) then
  begin
    lbName.SetFocus;
    if (lbName.ItemIndex > 0) and ( lbName.ItemIndex < lbName.Count) then
      begin
        if Key = 38 then
          lbName.ItemIndex := lbName.ItemIndex - 1
        else if Key = 40 then
          lbName.ItemIndex := lbName.ItemIndex + 1;

        lbName.OnClick(nil);
      end;
   end;
end;

procedure TfmView.edNameKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 38)or(Key = 40) then
    edName.SelectAll;
end;

end.

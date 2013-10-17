unit uSameVar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfmSameVar = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    bbReplace: TBitBtn;
    bbIgnore: TBitBtn;
    lbForVar: TLabel;
    ScrollBox1: TScrollBox;
    lbNameFile1: TLabel;
    lbNameFile2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSameVar: TfmSameVar;

implementation

uses uWacher;

{$R *.dfm}

procedure TfmSameVar.BitBtn1Click(Sender: TObject);
begin
  fmWach.Caption := lbNameFile1.Caption;
  fmWach.ShowModal;
end;

procedure TfmSameVar.BitBtn2Click(Sender: TObject);
begin
  fmWach.Caption := lbNameFile2.Caption;
  fmWach.ShowModal;
end;

procedure TfmSameVar.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if Self.ModalResult = 2 then
    CanClose := False
  else
    CanClose := True;
end;

procedure TfmSameVar.FormShow(Sender: TObject);
begin
  Self.ModalResult := 2;
end;

end.

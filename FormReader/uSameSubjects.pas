unit uSameSubjects;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TfmSameSub = class(TForm)
    Panel1: TPanel;
    bbDelOld: TBitBtn;
    bbRename: TBitBtn;
    bbCancel: TBitBtn;
    Label1: TLabel;
    bbIgnoreActive: TBitBtn;
    lbSameSub: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSameSub: TfmSameSub;

implementation

uses uEditorCodes;

{$R *.dfm}

procedure TfmSameSub.FormShow(Sender: TObject);
begin
  lbSameSub.Caption := fmEditorCodes.NameOfSameSub;
end;

end.

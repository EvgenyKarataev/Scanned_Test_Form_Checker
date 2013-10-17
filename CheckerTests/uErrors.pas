unit uErrors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons;

type
  TfmErrors = class(TForm)
    pcErrors: TPageControl;
    tsErWithCode: TTabSheet;
    lbTitleWithCode: TLabel;
    lbListOfEr: TListBox;
    lb1WithCode: TLabel;
    lb2WithCode: TLabel;
    bbAddVar: TBitBtn;
    bbOutWithCode: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmErrors: TfmErrors;

implementation

uses uMain;

{$R *.dfm}

procedure TfmErrors.FormShow(Sender: TObject);
begin
  lbListOfEr.Clear;
  lbListOfEr.Items.Add(fmCheckerTests.Mistake);
end;

end.

unit uErrorWithBlank;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfmErrorWithBlank = class(TForm)
    pcErrors: TPageControl;
    tsErWithBlank: TTabSheet;
    lbTitleWithBlank: TLabel;
    lb1WithBlank: TLabel;
    lb2WithBlank: TLabel;
    lbErWithBlank: TListBox;
    bbAddBlank: TBitBtn;
    bbOutWithBlank: TBitBtn;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmErrorWithBlank: TfmErrorWithBlank;

implementation

uses uMain;

{$R *.dfm}

procedure TfmErrorWithBlank.FormShow(Sender: TObject);
begin
  lbErWithBlank.Clear;
  lbErWithBlank.Items.Add(fmCheckerTests.Mistake);
end;

end.

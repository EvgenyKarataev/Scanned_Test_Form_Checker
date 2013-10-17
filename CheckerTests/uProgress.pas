unit uProgress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls;

type
  TfmProgress = class(TForm)
    Panel1: TPanel;
    lbProgress: TLabel;
    pbProgress: TProgressBar;
    pbAllProc: TProgressBar;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmProgress: TfmProgress;

implementation

{$R *.dfm}

end.

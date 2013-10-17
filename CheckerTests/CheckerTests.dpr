program CheckerTests;

uses
  Forms,
  uMain in 'uMain.pas' {fmCheckerTests},
  uProgress in 'uProgress.pas' {fmProgress},
  uResult in 'uResult.pas' {fmResult},
  uErrors in 'uErrors.pas' {fmErrors},
  uErrorWithBlank in 'uErrorWithBlank.pas' {fmErrorWithBlank},
  uSameVar in 'uSameVar.pas' {fmSameVar},
  uWacher in 'uWacher.pas' {fmWach},
  uAbout in 'uAbout.pas' {fmAbout},
  uDataComponents in 'uDataComponents.pas' {DataComponents: TDataModule},
  uLoading in 'uLoading.pas' {fmLoading};

{$R *.res}

begin
  fmLoading := TfmLoading.Create(nil);

  try
    fmLoading.Show;
    fmLoading.Update;
    
    Application.Initialize;
    Application.Title := 'CheckerTests 2.9';
  Application.CreateForm(TfmCheckerTests, fmCheckerTests);
    Application.CreateForm(TfmProgress, fmProgress);
    Application.CreateForm(TfmResult, fmResult);
    Application.CreateForm(TfmErrors, fmErrors);
    Application.CreateForm(TfmErrorWithBlank, fmErrorWithBlank);
    Application.CreateForm(TfmSameVar, fmSameVar);
    Application.CreateForm(TfmWach, fmWach);
    Application.CreateForm(TfmAbout, fmAbout);
    Application.CreateForm(TDataComponents, DataComponents);
    Application.Run;
  finally
    fmLoading.Free;
  end;
end.

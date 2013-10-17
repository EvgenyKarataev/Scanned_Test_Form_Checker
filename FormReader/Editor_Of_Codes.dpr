program Editor_Of_Codes;

uses
  Controls,
  Dialogs,
  Windows,
  Forms,
  uEditorCodes in 'uEditorCodes.pas' {fmEditorCodes},
  uKind in 'uKind.pas' {fmView},
  uListOfSubjects in 'uListOfSubjects.pas' {fmListOfSubjects},
  uSameSubjects in 'uSameSubjects.pas' {fmSameSub},
  uEntrance in 'uEntrance.pas' {fmEntrance},
  uPas in 'uPas.pas' {fmPas},
  uLoad in 'uLoad.pas' {fmLoading},
  uAbout in 'uAbout.pas' {fmAbout};

{$R *.res}

begin
  fmPas := TfmPas.Create(nil);
  try
    fmPas.ShowModal;
    fmPas.Update;

    case fmPas.ModalResult of
    mrOk :
      begin
        fmLoading := TfmLoading.Create(nil);
        try
          fmLoading.Show;
          fmLoading.Update;

          Application.Initialize;
          Application.Title := 'FormReader 1.7';
  Application.CreateForm(TfmEditorCodes, fmEditorCodes);
  Application.CreateForm(TfmView, fmView);
  Application.CreateForm(TfmListOfSubjects, fmListOfSubjects);
  Application.CreateForm(TfmSameSub, fmSameSub);
  Application.CreateForm(TfmEntrance, fmEntrance);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.Run;
        finally
          fmLoading.Free;
        end; //try
      end;  //mrOk;
    mrAbort: Application.MessageBox('        Неверный пароль!!!          ', 'Внимание!!!', MB_OK);
    end; //case;
  finally
    fmPas.Free;
  end; //try
end.

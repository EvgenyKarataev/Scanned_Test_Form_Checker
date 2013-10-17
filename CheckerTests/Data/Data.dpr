program Data;

uses
  Controls,
  Dialogs,
  Windows,
  Forms,
  uMain in 'uMain.pas' {fmMain},
  uComponents in 'uComponents.pas' {DataComponents: TDataModule},
  uEditBase in 'uEditBase.pas' {fmEditing},
  uListOfClasses in 'uListOfClasses.pas' {fmListOfClasses},
  uEntrance in 'uEntrance.pas' {fmEntrance},
  uPassword in 'uPassword.pas' {fmPassword},
  uAbout in 'uAbout.pas' {fmAbout};

{$R *.res}

begin
  fmPassword := TfmPassword.Create(nil);
  try
    fmPassword.ShowModal;
    fmPassword.Update;

    case fmPassword.ModalResult of
    mrOk :
      begin
        Application.Initialize;
        Application.Title := 'PupilsBase';
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TDataComponents, DataComponents);
  Application.CreateForm(TfmEditing, fmEditing);
  Application.CreateForm(TfmListOfClasses, fmListOfClasses);
  Application.CreateForm(TfmEntrance, fmEntrance);
  Application.CreateForm(TfmPassword, fmPassword);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.Run;
      end; //mrOk
    mrAbort: Application.MessageBox('        Неверный пароль!!!          ', 'Внимание!!!', MB_OK);
    end; //case
  finally
    fmPassword.Free;
  end; //try
end.

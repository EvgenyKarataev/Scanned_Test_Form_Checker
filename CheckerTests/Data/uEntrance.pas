unit uEntrance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons;

type
  TfmEntrance = class(TForm)
    pcUndanger: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    edOldPassword: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edNewPassword: TEdit;
    Label6: TLabel;
    edNewPasswordAgain: TEdit;
    bbOk: TBitBtn;
    bbCAncel: TBitBtn;
    procedure bbOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEntrance: TfmEntrance;

implementation

uses uMain;

{$R *.dfm}

procedure TfmEntrance.bbOkClick(Sender: TObject);
begin
  if edOldPassword.Text <> fmMain.Password then
    Application.MessageBox('Задан неверный пароль в поле "Текущий пароль".' + #13#10
    + 'Введите правильный пароль.', 'Внимание!!!', MB_Ok)
  else
    if edNewPassword.Text <> edNewPasswordAgain.Text then
      Application.MessageBox('Введите новый пароль в поле "Подтверждение" еще раз и нажмите кнопку Ок.',
      'Внимание!!!', MB_Ok)
    else
      Self.ModalResult := mrOk;
end;

end.

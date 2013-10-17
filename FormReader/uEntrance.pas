unit uEntrance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls;

type
  TfmEntrance = class(TForm)
    pcUndanger: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    edOldPassword: TEdit;
    edNewPassword: TEdit;
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

uses uEditorCodes;

{$R *.dfm}

procedure TfmEntrance.bbOkClick(Sender: TObject);
begin
  if edOldPassword.Text <> fmEditorCodes.Password then
    Application.MessageBox('����� �������� ������ � ���� "������� ������".' + #13#10
    + '������� ���������� ������.', '��������!!!', MB_Ok)
  else
    if edNewPassword.Text <> edNewPasswordAgain.Text then
      Application.MessageBox('������� ����� ������ � ���� "�������������" ��� ��� � ������� ������ ��.',
      '��������!!!', MB_Ok)
    else
      Self.ModalResult := mrOk;
end;

end.

unit uPassword;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles;
const
  Code = 927;

type
  TfmPassword = class(TForm)
    Label1: TLabel;
    edPas: TEdit;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    procedure bbOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetPas: string;
  end;

var
  fmPassword: TfmPassword;

implementation

uses uMain;

{$R *.dfm}

function TfmPassword.GetPas: string; //получает пароль из файла
var
  Path, str: string;   //путь и  сам пароль
  i: Integer;
  Ini: TIniFile;
  j: Integer;
  Stch: Char;
  Go: Boolean;
begin
  Result := '';
  Go := False;

  Path := Application.ExeName;   //загружает весь путь

  for i := Length(Path) downto 0 do
    if Path[i] = '\' then
      begin
        if Go then
          begin
            Delete(Path, i + 1, Length(Path) - i);

            break;
          end;
          
        Go := True;
      end;
  Path := Path + 'Setting.ini';

  try
    Ini := TIniFile.Create(Path);

    Result := Ini.ReadString('Font', 'Caption', '');

    Str := Result;

    Result := '';

    for j := 1 to Length(Str) do
       begin
          Stch := Str[j];
          Result := Result+chr(ord(Stch) xor Code);
       end;

  finally
    if Assigned(Ini) then
      Ini.Free;
  end; //try
end;

procedure TfmPassword.bbOkClick(Sender: TObject);
begin
  if edPas.Text = GetPas then
    ModalResult := mrOk
  else
    ModalResult := mrAbort;
end;

end.

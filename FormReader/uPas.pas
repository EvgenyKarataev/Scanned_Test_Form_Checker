unit uPas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, IniFiles;
const
  Code = 654;
type
  TfmPas = class(TForm)
    edPas: TEdit;
    bbOk: TBitBtn;
    bbCancel: TBitBtn;
    Label1: TLabel;
    procedure bbOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Password: string;  //сюда записывается вводимый пароль

    function GetPas: string;
  end;

var
  fmPas: TfmPas;

implementation

uses uEditorCodes;

{$R *.dfm}

function TfmPas.GetPas: string; //получает пароль из файла
var
  Path, str: string;   //путь и  сам пароль
  i: Integer;
  Ini: TIniFile;
  j: Integer;
  Stch: Char;
begin
  Result := '';

  Path := Application.ExeName;   //загружает весь путь

  for i := Length(Path) downto 0 do
    if Path[i] = '\' then
      begin
        Delete(Path, i + 1, Length(Path) - i);
        break;
      end;
  Path := Path + 'Setting.ini';

  try
    Ini := TIniFile.Create(Path);

    Result := Ini.ReadString('Font', 'Text', '');

    Str := Result;

    Result := '';

    for j := 1 to length(Str) do
       begin
          Stch := str[j];
          Result := Result+chr(ord(Stch) xor Code);
       end;

  finally
    if Assigned(Ini) then
      Ini.Free;
  end; //try
end;

procedure TfmPas.bbOkClick(Sender: TObject);
begin
  if edPas.Text = GetPas then
    ModalResult := mrOk
  else
    ModalResult := mrAbort;
end;

end.

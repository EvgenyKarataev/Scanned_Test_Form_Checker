unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, Menus, StdCtrls, ExtCtrls, ActnList,
  XPStyleActnCtrls, ActnMan, ActnCtrls, ToolWin, ActnMenus, ComCtrls,
  ImgList, IniFiles;

const
  CodeS = 927;

type
  TNumber = class(TObject)
  private
    FNumber: String;     //записывается номер класса
  public
    property Number: String read FNumber write FNumber;
  end;

  TfmMain = class(TForm)
    dbgDirectory: TDBGrid;
    ActionManager1: TActionManager;
    acExit: TAction;
    acAddItem: TAction;
    acSortOnSername: TAction;
    acEditItem: TAction;
    acDelItem: TAction;
    ActionMainMenuBar1: TActionMainMenuBar;
    ActionToolBar1: TActionToolBar;
    tvClasses: TTreeView;
    acClasses: TAction;
    pmforList: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    pmForTree: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    ImageList1: TImageList;
    sbCount: TStatusBar;
    acSortOnClass: TAction;
    acSortOnName: TAction;
    acSortOnFathName: TAction;
    acSortOnNumber: TAction;
    ImageList2: TImageList;
    acDanger: TAction;
    acAbout: TAction;
    procedure edConditionChange(Sender: TObject);
    procedure acAddItemExecute(Sender: TObject);
    procedure acEditItemExecute(Sender: TObject);
    procedure acDelItemExecute(Sender: TObject);
    procedure acClassesExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tvClassesChange(Sender: TObject; Node: TTreeNode);
    procedure acExitExecute(Sender: TObject);
    procedure acSortOnSernameExecute(Sender: TObject);
    procedure acSortOnClassExecute(Sender: TObject);
    procedure acSortOnNameExecute(Sender: TObject);
    procedure acSortOnFathNameExecute(Sender: TObject);
    procedure acSortOnNumberExecute(Sender: TObject);
    procedure acProtecExecute(Sender: TObject);
    procedure dbgDirectoryDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acDangerExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acAboutExecute(Sender: TObject);
  private
    { Private declarations }
    procedure SavePas;
    function Shifrovka(Str: string): string;
  public
    { Public declarations }
    Number: TNumber;       //для записи в дерево номера класса как объект
    CountClasses: Integer;   //кол-во классов

    Code: Integer;

    Password, OldPassword: string;
    PasModified: Boolean;

    procedure RecToTree;    //записывает в древо
    procedure DelFromTree;  //удаляет из дерева
  end;

var
  fmMain: TfmMain;

implementation

uses uComponents, uEditBase, uListOfClasses, uEntrance, uAbout;

{$R *.dfm}

procedure TfmMain.edConditionChange(Sender: TObject);
//поиск
begin
 { if Length(edCondition.Text) > 0 then
    DataComponents.adotList.Filtered := True
  else
    DataComponents.adotList.Filtered := False;

  DataComponents.adotList.Filter :='Номер='''+ edCondition.Text + '''';}

end;

procedure TfmMain.acAddItemExecute(Sender: TObject);
begin
  DataComponents.adotList.Insert;  //добавляет новую строку в основ таблицу
  fmEditing.ShowModal;             //показывает окно ридактирования
end;

procedure TfmMain.acEditItemExecute(Sender: TObject);
begin
  fmEditing.ShowModal;       //нажатие на кнопке редактировать
end;

procedure TfmMain.acDelItemExecute(Sender: TObject);
//удаление ученика
begin
  if Application.MessageBox(PChar('Вы действительно хотите удалить запись: '
    + DataComponents.adotListDSDesigner2.AsString + ' ' + DataComponents.adotListDSDesigner3.AsString
    + ' ' + DataComponents.adotListDSDesigner4.AsString + ' ?'), 'Внимание!!!',
    MB_OKCANCEL) = id_OK then
      begin
        DataComponents.adotList.Delete;     //удаляет строку

        if tvClasses.Selected.Level = 0 then //если выделена школа то пишет сколько всего классов и учеников
          begin
            sbCount.Panels.Items[0].Width := fmMain.ClientWidth div 2;  //разбивает все панель на две равные
            sbCount.Panels.Items[0].Text := 'Количество классов: ' + IntToStr(DataComponents.adotClasses.RecordCount);

            sbCount.Panels.Items[1].Width := fmMain.ClientWidth div 2;
            sbCount.Panels.Items[1].Text := 'Количество учеников: ' + IntToStr(DataComponents.adotList.RecordCount);
          end //if tvClasses.Selected.Level = 0
        else
          begin           //если выделен класс
            sbCount.Panels.Items[1].Width := 0; //онду часть чтобы не было видно
            sbCount.Panels.Items[0].Width := fmMain.ClientWidth;
            sbCount.Panels.Items[0].Text := 'Количество количество учеников в ' + tvClasses.Selected.Text + ': ' + IntToStr(DataComponents.adotList.RecordCount);
          end; //else
      end;
end;

procedure TfmMain.acClassesExecute(Sender: TObject);
//список всех классов
begin
  CountClasses := DataComponents.adotClasses.RecordCount; //записывает кол-во классов перед открытием

  fmListOfClasses.ShowModal;          //показывает окно

  if CountClasses <> DataComponents.adotClasses.RecordCount then  //проверка, если кол-во изменилось
    begin
      tvClasses.Items.Clear;             //очищает дерево всех классов
      tvClasses.Items.AddChild(nil, 'Мурагер');  //пишет первым школу

      DataComponents.adotList.Filtered := False;    //запрещает фильтрацию, т.е. показывает все.

      DelFromTree; // вызывает процедуру удаления класса из дерева

      if DataComponents.adotClasses.RecordCount > 0 then  //проверяет кол-во классов
        RecToTree;      //вызывает процедуру добавления в дерево классов
    end; //if CountClasses <> DataComponents.adotClasses.RecordCount

  tvClasses.Items.Item[0].ImageIndex := 7;      //чтобы был портфель на школе
  tvCLasses.Items.Item[0].SelectedIndex := 7;   //чтобы был портфель на школе
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
  if DataComponents.adotClasses.RecordCount > 0 then  //проверяет количество классов
    RecToTree;   //вызывает процедуру добавления в дерево классов
  tvCLasses.Items.Item[0].Selected := True;

  DataComponents.adotList.IndexFieldNames := 'Номер';

  DataComponents.adotClasses.IndexFieldNames := 'Класс';
end;


procedure TfmMain.tvClassesChange(Sender: TObject; Node: TTreeNode);
//когда меняется выделение класса в дереве
begin
  if Length(Node.Text) > 0 then    //если длина класса больше нуля то разрешает фильтрацию
    DataComponents.adotList.Filtered := True
  else
    DataComponents.adotList.Filtered := False; //значит длина меньше нуля или равна нулю

  Number := tvClasses.Selected.Data;       //из выделенного узла забирает объект

  if Node.Text <> tvClasses.Items.Item[0].Text then //если текст узал не название школы то
    DataComponents.adotList.Filter :='Класс=''' + Number.Number + '''' //фильтрует по номеру класса
  else
    DataComponents.adotList.Filtered := False;    //запрещает фильтрацию, т.е. показывает все.

  if tvClasses.Selected.Level = 0 then //если выделена школа то пишет сколько всего классов и учеников
    begin
      sbCount.Panels.Items[0].Width := fmMain.ClientWidth div 2;  //разбивает все панель на две равные
      sbCount.Panels.Items[0].Text := 'Количество классов: ' + IntToStr(DataComponents.adotClasses.RecordCount);

      sbCount.Panels.Items[1].Width := fmMain.ClientWidth div 2;
      sbCount.Panels.Items[1].Text := 'Количество учеников: ' + IntToStr(DataComponents.adotList.RecordCount);
    end //if tvClasses.Selected.Level = 0
  else
    begin           //если выделен класс
      sbCount.Panels.Items[1].Width := 0; //онду часть чтобы не было видно
      sbCount.Panels.Items[0].Width := fmMain.ClientWidth;
      sbCount.Panels.Items[0].Text := 'Количество количество учеников в ' + tvClasses.Selected.Text + ': ' + IntToStr(DataComponents.adotList.RecordCount);
    end;

  tvClasses.Items.Item[0].ImageIndex := 7;
  tvCLasses.Items.Item[0].SelectedIndex := 7;  
end;

procedure TfmMain.RecToTree;
//Добавление в дерево классов
begin
  DataComponents.adotClasses.First;          //берет вервого
  repeat
    Number := TNumber.Create;                //создает для него номер
    Number.Number := IntToStr(DataComponents.adotClassesKey1.AsInteger);//и записывает его туда
    //добавляет в дерево
    tvClasses.Items.AddChildObject(tvCLasses.Items.Item[0], DataComponents.adotClassesDSDesigner.AsString, Number);

    DataComponents.adotClasses.Next;  //берет следующего
  until DataComponents.adotClasses.Eof;      //делает пока не дойдет до конца
end;

procedure TfmMain.DelFromTree;
//удаляет класс из дерева
begin
  DataComponents.adotList.Last;       //выделяет последнюю строку в таблице
  repeat
    if DataComponents.adotListClass.IsNull then     //проверяет если файл уже пустой
      DataComponents.adotList.Delete;

    DataComponents.adotList.Prior;         //выделяет предыдущую строку
  until DataComponents.adotList.Bof;       //продолжается пока не дойдет до начала таблицы
end;

procedure TfmMain.acExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.acSortOnSernameExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := 'Фамилия';   //сортировка по фамилии

  //делает отмеченным в меню нужную строку
  acSortOnClass.Checked := False;
  acSortOnName.Checked := False;
  acSortOnSerName.Checked := True;
  acSortOnNumber.Checked := False;
  acSortOnFathName.Checked := False;
end;

procedure TfmMain.acSortOnClassExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := 'Класс';  //сортировка по классу

  //делает отмеченным в меню нужную строку
  acSortOnClass.Checked := True;
  acSortOnName.Checked := False;
  acSortOnSerName.Checked := False;
  acSortOnNumber.Checked := False;
  acSortOnFathName.Checked := False;
end;

procedure TfmMain.acSortOnNameExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := 'Имя';    //сортировка по имени

  //делает отмеченным в меню нужную строку
  acSortOnClass.Checked := False;
  acSortOnName.Checked := True;
  acSortOnSerName.Checked := False;
  acSortOnNumber.Checked := False;
  acSortOnFathName.Checked := False;
end;

procedure TfmMain.acSortOnFathNameExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := 'Отчество';  //сортировка по отчеству

  //делает отмеченным в меню нужную строку
  acSortOnClass.Checked := False;
  acSortOnName.Checked := False;
  acSortOnSerName.Checked := False;
  acSortOnNumber.Checked := False;
  acSortOnFathName.Checked := True;
end;

procedure TfmMain.acSortOnNumberExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := 'Номер';      //сортировка по номеру

  //делает отмеченным в меню нужную строку
  acSortOnClass.Checked := False;
  acSortOnName.Checked := False;
  acSortOnSerName.Checked := False;
  acSortOnNumber.Checked := True;
  acSortOnFathName.Checked := False;
end;

procedure TfmMain.acProtecExecute(Sender: TObject);
begin
  fmEntrance.ShowModal;
end;

procedure TfmMain.dbgDirectoryDblClick(Sender: TObject);
begin
  acEditItem.OnExecute(Sender);
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  Path: string;
  i: Integer;
  Ini: TIniFile;
  Go: Boolean;
begin
  Code := CodeS;

  Go := False;

  Path := Application.ExeName;

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

    Password := Shifrovka(Ini.ReadString('Font', 'Caption', ''));
    OldPassword := Password;

  finally
    if Assigned(Ini) then
      Ini.Free;
  end; //try
end;

procedure TfmMain.acDangerExecute(Sender: TObject);
begin
  fmEntrance.ShowModal;
  case fmEntrance.ModalResult of
    mrOk:
      begin
        Password := fmEntrance.edNewPassword.Text;  //записывает новый пароль
          if Password <> OldPassword then    //если новый пароль не равен старому, то
            PasModified := True;             //нужно будет сохранить
      end; // mrOk
  end;   //case
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if PasModified then
    SavePas;
end;

procedure TfmMain.SavePas;
var
  Path: string;
  i: Integer;
  Ini: TIniFile;
  Go: Boolean;
begin
  Path := Application.ExeName;
  Go := False;

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
  Path := Path + 'Setting';

  try
    Ini := TIniFile.Create(ChangeFileExt(Path, '.ini'));

    Ini.WriteString('Font', 'Caption', Shifrovka(Password));

  finally
   Ini.Destroy;
  end;
end;

function TfmMain.Shifrovka(Str: string): string;
//зашифрововывает пароль
var
   j: Integer;
   Stch: Char;
begin
  Result := '';
     for j := 1 to Length(Str) do
       begin
          Stch := Str[j];
          Result := Result+chr(ord(Stch) xor Code);
       end;
end;

procedure TfmMain.acAboutExecute(Sender: TObject);
begin
  fmAbout.ShowModal;
end;

end.

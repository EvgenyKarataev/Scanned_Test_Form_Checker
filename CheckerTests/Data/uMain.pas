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
    FNumber: String;     //������������ ����� ������
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
    Number: TNumber;       //��� ������ � ������ ������ ������ ��� ������
    CountClasses: Integer;   //���-�� �������

    Code: Integer;

    Password, OldPassword: string;
    PasModified: Boolean;

    procedure RecToTree;    //���������� � �����
    procedure DelFromTree;  //������� �� ������
  end;

var
  fmMain: TfmMain;

implementation

uses uComponents, uEditBase, uListOfClasses, uEntrance, uAbout;

{$R *.dfm}

procedure TfmMain.edConditionChange(Sender: TObject);
//�����
begin
 { if Length(edCondition.Text) > 0 then
    DataComponents.adotList.Filtered := True
  else
    DataComponents.adotList.Filtered := False;

  DataComponents.adotList.Filter :='�����='''+ edCondition.Text + '''';}

end;

procedure TfmMain.acAddItemExecute(Sender: TObject);
begin
  DataComponents.adotList.Insert;  //��������� ����� ������ � ����� �������
  fmEditing.ShowModal;             //���������� ���� ��������������
end;

procedure TfmMain.acEditItemExecute(Sender: TObject);
begin
  fmEditing.ShowModal;       //������� �� ������ �������������
end;

procedure TfmMain.acDelItemExecute(Sender: TObject);
//�������� �������
begin
  if Application.MessageBox(PChar('�� ������������� ������ ������� ������: '
    + DataComponents.adotListDSDesigner2.AsString + ' ' + DataComponents.adotListDSDesigner3.AsString
    + ' ' + DataComponents.adotListDSDesigner4.AsString + ' ?'), '��������!!!',
    MB_OKCANCEL) = id_OK then
      begin
        DataComponents.adotList.Delete;     //������� ������

        if tvClasses.Selected.Level = 0 then //���� �������� ����� �� ����� ������� ����� ������� � ��������
          begin
            sbCount.Panels.Items[0].Width := fmMain.ClientWidth div 2;  //��������� ��� ������ �� ��� ������
            sbCount.Panels.Items[0].Text := '���������� �������: ' + IntToStr(DataComponents.adotClasses.RecordCount);

            sbCount.Panels.Items[1].Width := fmMain.ClientWidth div 2;
            sbCount.Panels.Items[1].Text := '���������� ��������: ' + IntToStr(DataComponents.adotList.RecordCount);
          end //if tvClasses.Selected.Level = 0
        else
          begin           //���� ������� �����
            sbCount.Panels.Items[1].Width := 0; //���� ����� ����� �� ���� �����
            sbCount.Panels.Items[0].Width := fmMain.ClientWidth;
            sbCount.Panels.Items[0].Text := '���������� ���������� �������� � ' + tvClasses.Selected.Text + ': ' + IntToStr(DataComponents.adotList.RecordCount);
          end; //else
      end;
end;

procedure TfmMain.acClassesExecute(Sender: TObject);
//������ ���� �������
begin
  CountClasses := DataComponents.adotClasses.RecordCount; //���������� ���-�� ������� ����� ���������

  fmListOfClasses.ShowModal;          //���������� ����

  if CountClasses <> DataComponents.adotClasses.RecordCount then  //��������, ���� ���-�� ����������
    begin
      tvClasses.Items.Clear;             //������� ������ ���� �������
      tvClasses.Items.AddChild(nil, '�������');  //����� ������ �����

      DataComponents.adotList.Filtered := False;    //��������� ����������, �.�. ���������� ���.

      DelFromTree; // �������� ��������� �������� ������ �� ������

      if DataComponents.adotClasses.RecordCount > 0 then  //��������� ���-�� �������
        RecToTree;      //�������� ��������� ���������� � ������ �������
    end; //if CountClasses <> DataComponents.adotClasses.RecordCount

  tvClasses.Items.Item[0].ImageIndex := 7;      //����� ��� �������� �� �����
  tvCLasses.Items.Item[0].SelectedIndex := 7;   //����� ��� �������� �� �����
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
  if DataComponents.adotClasses.RecordCount > 0 then  //��������� ���������� �������
    RecToTree;   //�������� ��������� ���������� � ������ �������
  tvCLasses.Items.Item[0].Selected := True;

  DataComponents.adotList.IndexFieldNames := '�����';

  DataComponents.adotClasses.IndexFieldNames := '�����';
end;


procedure TfmMain.tvClassesChange(Sender: TObject; Node: TTreeNode);
//����� �������� ��������� ������ � ������
begin
  if Length(Node.Text) > 0 then    //���� ����� ������ ������ ���� �� ��������� ����������
    DataComponents.adotList.Filtered := True
  else
    DataComponents.adotList.Filtered := False; //������ ����� ������ ���� ��� ����� ����

  Number := tvClasses.Selected.Data;       //�� ����������� ���� �������� ������

  if Node.Text <> tvClasses.Items.Item[0].Text then //���� ����� ���� �� �������� ����� ��
    DataComponents.adotList.Filter :='�����=''' + Number.Number + '''' //��������� �� ������ ������
  else
    DataComponents.adotList.Filtered := False;    //��������� ����������, �.�. ���������� ���.

  if tvClasses.Selected.Level = 0 then //���� �������� ����� �� ����� ������� ����� ������� � ��������
    begin
      sbCount.Panels.Items[0].Width := fmMain.ClientWidth div 2;  //��������� ��� ������ �� ��� ������
      sbCount.Panels.Items[0].Text := '���������� �������: ' + IntToStr(DataComponents.adotClasses.RecordCount);

      sbCount.Panels.Items[1].Width := fmMain.ClientWidth div 2;
      sbCount.Panels.Items[1].Text := '���������� ��������: ' + IntToStr(DataComponents.adotList.RecordCount);
    end //if tvClasses.Selected.Level = 0
  else
    begin           //���� ������� �����
      sbCount.Panels.Items[1].Width := 0; //���� ����� ����� �� ���� �����
      sbCount.Panels.Items[0].Width := fmMain.ClientWidth;
      sbCount.Panels.Items[0].Text := '���������� ���������� �������� � ' + tvClasses.Selected.Text + ': ' + IntToStr(DataComponents.adotList.RecordCount);
    end;

  tvClasses.Items.Item[0].ImageIndex := 7;
  tvCLasses.Items.Item[0].SelectedIndex := 7;  
end;

procedure TfmMain.RecToTree;
//���������� � ������ �������
begin
  DataComponents.adotClasses.First;          //����� �������
  repeat
    Number := TNumber.Create;                //������� ��� ���� �����
    Number.Number := IntToStr(DataComponents.adotClassesKey1.AsInteger);//� ���������� ��� ����
    //��������� � ������
    tvClasses.Items.AddChildObject(tvCLasses.Items.Item[0], DataComponents.adotClassesDSDesigner.AsString, Number);

    DataComponents.adotClasses.Next;  //����� ����������
  until DataComponents.adotClasses.Eof;      //������ ���� �� ������ �� �����
end;

procedure TfmMain.DelFromTree;
//������� ����� �� ������
begin
  DataComponents.adotList.Last;       //�������� ��������� ������ � �������
  repeat
    if DataComponents.adotListClass.IsNull then     //��������� ���� ���� ��� ������
      DataComponents.adotList.Delete;

    DataComponents.adotList.Prior;         //�������� ���������� ������
  until DataComponents.adotList.Bof;       //������������ ���� �� ������ �� ������ �������
end;

procedure TfmMain.acExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.acSortOnSernameExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := '�������';   //���������� �� �������

  //������ ���������� � ���� ������ ������
  acSortOnClass.Checked := False;
  acSortOnName.Checked := False;
  acSortOnSerName.Checked := True;
  acSortOnNumber.Checked := False;
  acSortOnFathName.Checked := False;
end;

procedure TfmMain.acSortOnClassExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := '�����';  //���������� �� ������

  //������ ���������� � ���� ������ ������
  acSortOnClass.Checked := True;
  acSortOnName.Checked := False;
  acSortOnSerName.Checked := False;
  acSortOnNumber.Checked := False;
  acSortOnFathName.Checked := False;
end;

procedure TfmMain.acSortOnNameExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := '���';    //���������� �� �����

  //������ ���������� � ���� ������ ������
  acSortOnClass.Checked := False;
  acSortOnName.Checked := True;
  acSortOnSerName.Checked := False;
  acSortOnNumber.Checked := False;
  acSortOnFathName.Checked := False;
end;

procedure TfmMain.acSortOnFathNameExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := '��������';  //���������� �� ��������

  //������ ���������� � ���� ������ ������
  acSortOnClass.Checked := False;
  acSortOnName.Checked := False;
  acSortOnSerName.Checked := False;
  acSortOnNumber.Checked := False;
  acSortOnFathName.Checked := True;
end;

procedure TfmMain.acSortOnNumberExecute(Sender: TObject);
begin
  DataComponents.adotList.IndexFieldNames := '�����';      //���������� �� ������

  //������ ���������� � ���� ������ ������
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
        Password := fmEntrance.edNewPassword.Text;  //���������� ����� ������
          if Password <> OldPassword then    //���� ����� ������ �� ����� �������, ��
            PasModified := True;             //����� ����� ���������
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
//��������������� ������
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

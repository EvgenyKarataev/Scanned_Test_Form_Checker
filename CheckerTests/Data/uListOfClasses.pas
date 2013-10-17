unit uListOfClasses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ActnList, XPStyleActnCtrls,
  ActnMan, ExtCtrls, ComCtrls;

type
  TfmListOfClasses = class(TForm)
    dbgListOfClasses: TDBGrid;
    ActionManager1: TActionManager;
    acAddItem: TAction;
    acDeleteItem: TAction;
    acSave: TAction;
    acOk: TAction;
    sbCountCAlsses: TStatusBar;
    Panel1: TPanel;
    bbOk: TBitBtn;
    bbAdd: TBitBtn;
    bbSave: TBitBtn;
    bbDelete: TBitBtn;
    procedure acAddItemExecute(Sender: TObject);
    procedure acDeleteItemExecute(Sender: TObject);
    procedure acDeleteItemUpdate(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure acOkExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListOfClasses: TfmListOfClasses;

implementation

uses uComponents;

{$R *.dfm}

procedure TfmListOfClasses.acAddItemExecute(Sender: TObject);
begin
  DataComponents.adotCLasses.Insert;  //��������� ����� �������
  dbgListOfClasses.SetFocus;          //������� ����� �����
end;

procedure TfmListOfClasses.acDeleteItemExecute(Sender: TObject);
//�������� ������
begin
  if Application.MessageBox(PChar('�� ������������� ������ ������� ������: '
    + DataComponents.adotClassesDSDesigner.AsString +' ?'), '��������!!!',
    MB_OKCANCEL) = id_OK then
      DataComponents.adotClasses.Delete;  //�������� ������� ������

  sbCountCAlsses.Panels.Items[0].Text := '���������� �������: ' + IntToStr(DataComponents.adotClasses.RecordCount);
end;

procedure TfmListOfClasses.acDeleteItemUpdate(Sender: TObject);
//������� ��� �� ������� ������� �������
begin
  if DataComponents.adotClasses.RecordCount > 0 then  //���� ���-�� ������� ������ 0, �� �������
    acDeleteItem.Enabled := True
  else
    acDeleteItem.Enabled := False;
end;

procedure TfmListOfClasses.acSaveExecute(Sender: TObject);
begin
  if DataComponents.adotClasses.Modified then  //���� ��������� ���������, �� ���������
    DataComponents.adotClasses.Post;      //���������

  sbCountCAlsses.Panels.Items[0].Text := '���������� �������: ' + IntToStr(DataComponents.adotClasses.RecordCount);
end;

procedure TfmListOfClasses.acOkExecute(Sender: TObject);
//������� �� ������ ��
begin
  acSave.OnExecute(Sender);
end;

procedure TfmListOfClasses.FormShow(Sender: TObject);
begin
  sbCountCAlsses.Panels.Items[0].Text := '���������� �������: ' + IntToStr(DataComponents.adotClasses.RecordCount);
end;

end.

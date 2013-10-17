unit uEditBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons, ExtCtrls, jpeg;

type
  TfmEditing = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    dbeFam: TDBEdit;
    dbeName: TDBEdit;
    dbeFAthes: TDBEdit;
    bbSave: TBitBtn;
    dbeNumber: TDBEdit;
    dblcbClass: TDBLookupComboBox;
    Label4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lbFAm: TLabel;
    Label3: TLabel;
    procedure bbSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    OldClass: Integer;
    OldSerName, OldName, OldPatronName, OldNumber: string;
    Saved: Boolean;
  public
    { Public declarations }
  end;

var
  fmEditing: TfmEditing;

implementation

uses uComponents, uMain;

{$R *.dfm}

procedure TfmEditing.bbSaveClick(Sender: TObject);
//сохраняет если были изменения
begin
  if DataComponents.adotList.Modified then
    begin
      DataComponents.adotList.Post;

      Saved := True;

      if fmMain.tvClasses.Selected.Level = 0 then //если выделена школа то пишет сколько всего классов и учеников
        begin
          fmMain.sbCount.Panels.Items[0].Width := fmMain.ClientWidth div 2;  //разбивает все панель на две равные
          fmMain.sbCount.Panels.Items[0].Text := 'Количество классов: ' + IntToStr(DataComponents.adotClasses.RecordCount);

          fmMain.sbCount.Panels.Items[1].Width := fmMain.ClientWidth div 2;
          fmMain.sbCount.Panels.Items[1].Text := 'Количество учеников: ' + IntToStr(DataComponents.adotList.RecordCount);
        end //if tvClasses.Selected.Level = 0
      else
        begin           //если выделен класс
          fmMain.sbCount.Panels.Items[1].Width := 0; //онду часть чтобы не было видно
          fmMain.sbCount.Panels.Items[0].Width := fmMain.ClientWidth;
          fmMain.sbCount.Panels.Items[0].Text := 'Количество количество учеников в ' + fmMain.tvClasses.Selected.Text + ': ' + IntToStr(DataComponents.adotList.RecordCount);
        end; //else
    end; // if DataComponents.adotList.Modified 
end;

procedure TfmEditing.FormShow(Sender: TObject);
begin
  OldClass := dblcbClass.ListFieldIndex;
  OldSerName := dbeFam.Text;
  OldName := dbeName.Text;
  OldPatronName := dbeFAthes.Text;
  OldNumber := dbeNumber.Text;

  Saved := False;
end;

procedure TfmEditing.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not Saved then
    begin
      dblcbClass.ListFieldIndex := OldClass;
      dbeFam.Text := OldSerName;
      dbeName.Text := OldName;
      dbeFAthes.Text := OldPatronName;
      dbeNumber.Text := OldNumber;

      if DataComponents.adotList.Modified then
        DataComponents.adotList.Post;
    end;
end;

end.

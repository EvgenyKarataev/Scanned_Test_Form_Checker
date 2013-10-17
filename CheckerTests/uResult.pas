unit uResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, OleCtnrs, ComCtrls, ExtCtrls;

const
  FormA = 3;

type
  TfmResult = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    bbOk: TBitBtn;
    rbSort: TRadioGroup;
    cbFIO: TComboBox;
    cbBalls: TComboBox;
    procedure bbOkClick(Sender: TObject);
    procedure rbSortClick(Sender: TObject);
  private
    { Private declarations }
    ListSub: array of string;

    OldWidth: Integer;

    procedure ExpotExel;
    procedure SortFIO;
    procedure SortBalls;
  public
    { Public declarations }
  end;

var
  fmResult: TfmResult;

implementation

uses uMain, ComObj, uDataComponents, DB;

{$R *.dfm}

procedure TfmResult.ExpotExel;
var
  XLApp, Sheet, Colum: Variant;
  i, z, g: Integer;
  Have: Boolean;
  FIO : string;
begin
  XLApp := CreateOleObject('Excel.Application');
  XLApp.Visible := True;
  XLApp.Workbooks.Add(-4167);

  XLApp.Workbooks[1].WorkSheets[1].Name := 'Отчёт';
  Colum := XLApp.Workbooks[1].WorkSheets['Отчёт'].Columns;
  Colum.Columns[1].ColumnWidth := 5;
  Colum.Columns[2].ColumnWidth := 10;
  Colum.Columns[3].ColumnWidth := 7;
  Colum.Columns[4].ColumnWidth := 20;
  Colum.Columns[5].ColumnWidth := 20;
  Colum := XLApp.Workbooks[1].WorkSheets['Отчёт'].Rows;
  Colum.Rows[2].Font.Bold := true;
  Colum.Rows[1].Font.Bold := true;
  Colum.Rows[1].Font.Color := clBlue;
  Colum.Rows[1].Font.Size := 14;
  Sheet := XLApp.Workbooks[1].WorkSheets['Отчёт'];
  Sheet.Cells[1,2] := 'Результаты тестирования';
  Sheet.Cells[2,1] := '№ п/п';
  Sheet.Cells[2,2] := 'ФИО';
  Sheet.Cells[2,3] := 'Вариант';

  SetLength(ListSub, 0);

  OldWidth := 10;

  DataComponents.adotList.Filtered := True; //включает фильтрацию

  for z := 0 to fmCheckerTests.Results.AmountOfBalls - 1 do
  begin
    Sheet.Cells[z + 3, 1] := z + 1;

    with fmCheckerTests.Results[z] do
    begin
      DataComponents.adotList.Filter := 'Номер=''' + IntToStr(NumberOfPupil) + '''';

      FIO := DataComponents.adotListSerName.AsString + ' ' + DataComponents.adotListName.AsString;

      if Length(FIO) > OldWidth then
        begin
          Colum.Columns[2].ColumnWidth := Length(FIO);
          OldWidth := Length(FIO);
        end;

      Sheet.Cells[z + 3, 2] := FIO;
      Sheet.Cells[z + 3, 3] := NumberOfVar;
    end; // with fmCheckerTests.Results[z]

    Have := False;

    for i := 0 to fmCheckerTests.Results[z].AmountOfSubjects - 1 do
    begin
      for g := 0 to Length(ListSub) - 1 do
        if fmCheckerTests.Results[z].Blank[i].TitleOfSubject = ListSub[g] then
          begin
            Have := True;
            break;
          end; //if fmCheckerTests.Results[z].Blank[i].TitleOfSubject = ListSub[g]

      if Length(ListSub) = 0 then
        g := 0;

      with fmCheckerTests.Results[z] do
      begin
        Sheet.Cells[2, g + 4] := Blank[i].TitleOfSubject;
        Colum.Columns[g + 4].ColumnWidth := Length(Blank[i].TitleOfSubject) + 1;
        if Have = False then
          begin
            SetLength(ListSub, Length(ListSub) + 1);
            ListSub[High(ListSub)] := Blank[i].TitleOfSubject;
          end; // if Have = False

        Sheet.Cells[z + 3, g + 4] := Blank[i].AmountOfRight;
      end; // with fmCheckerTests.Results[z]
    end; // for i := 0 to fmCheckerTests.Results[z].AmountOfSubjects - 1
  end;// for z := 0 to fmCheckerTests.Results.AmountOfBalls - 1

  Sheet.Cells[2, Length(ListSub) + 4] := 'Сумма балов';
   Colum.Columns[Length(ListSub) + 4].ColumnWidth := Length('Сумма балов') + 1;

  for z := 0 to fmCheckerTests.Results.AmountOfBalls - 1 do
    Sheet.Cells[z + 3, Length(ListSub) + 4] := fmCheckerTests.Results[z].FullSumBalls;

end;

procedure TfmResult.bbOkClick(Sender: TObject);
begin
  case  rbSort.ItemIndex of
    0 : SortFIO;
    1 : SortBalls;
  end; //case

  ExpotExel;
end;

procedure TfmResult.SortFIO;
var
  i, j: Integer;
  Buf: TResult;
  FIOi, FIOj: string;
begin
  DataComponents.adotList.Filtered := True;

  case cbFIO.ItemIndex of
  0 :
    begin
      for i := 0 to fmCheckerTests.Results.AmountOfBalls - 2 do
        for j := i + 1 to fmCheckerTests.Results.AmountOfBalls - 1 do
        begin
          //ищет первого для сравнения
          DataComponents.adotList.Filter := 'Номер=''' + IntToStr(fmCheckerTests.Results[i].NumberOfPupil) + ''''; //находит нужный
                 //считывает фамилию и имя
          FIOi := DataComponents.adotListSerName.AsString + ' ' + DataComponents.adotListName.AsString;

          //ищет еще один для сравнения этот уже по j
          DataComponents.adotList.Filter := 'Номер=''' + IntToStr(fmCheckerTests.Results[j].NumberOfPupil) + ''''; //находит нужный
                 //считывает фамилию и имя
          FIOj := DataComponents.adotListSerName.AsString + ' ' + DataComponents.adotListName.AsString;

          if FIOi < FIOj then
          begin
            Buf := fmCheckerTests.Results[i];
            fmCheckerTests.Results.Repalce(i, fmCheckerTests.Results[j]);
            fmCheckerTests.Results.Repalce(j, Buf);
          end; // if ListPupil[fmCheckerTests.Results[i].NumberOfPupil] > ListPupi
        end;  // for j := i + 1 to fmCheckerTests.Results.AmountOfBalls - 1 
    end; //0
  1 :
    begin
      for i := 0 to fmCheckerTests.Results.AmountOfBalls - 2 do
        for j := i + 1 to fmCheckerTests.Results.AmountOfBalls - 1 do
        begin
          //ищет первого для сравнения
          DataComponents.adotList.Filter := 'Номер=''' + IntToStr(fmCheckerTests.Results[i].NumberOfPupil) + ''''; //находит нужный
                 //считывает фамилию и имя
          FIOi := DataComponents.adotListSerName.AsString + ' ' + DataComponents.adotListName.AsString;

          //ищет еще один для сравнения этот уже по j
          DataComponents.adotList.Filter := 'Номер=''' + IntToStr(fmCheckerTests.Results[j].NumberOfPupil) + ''''; //находит нужный
                 //считывает фамилию и имя
          FIOj := DataComponents.adotListSerName.AsString + ' ' + DataComponents.adotListName.AsString;

          if FIOi > FIOj then
          begin
            Buf := fmCheckerTests.Results[i];
            fmCheckerTests.Results.Repalce(i, fmCheckerTests.Results[j]);
            fmCheckerTests.Results.Repalce(j, Buf);
          end; // if ListPupil[fmCheckerTests.Results[i].NumberOfPupil] > ListPupi
        end; // for j := i + 1 to fmCheckerTests.Results.AmountOfBalls - 1 
    end; //1
  end; //case
end;

procedure TfmResult.SortBalls;
var
  i, j : Integer;
  Buf: TResult;
  FIOi, FIOj: string;
begin
  DataComponents.adotList.Filtered := True;

  case cbBalls.ItemIndex of
  0 :
    begin
      for i := 0 to fmCheckerTests.Results.AmountOfBalls - 2 do
        for j := i + 1 to fmCheckerTests.Results.AmountOfBalls - 1 do
        begin
          //ищет первого для сравнения
          DataComponents.adotList.Filter := 'Номер=''' + IntToStr(fmCheckerTests.Results[i].NumberOfPupil) + ''''; //находит нужный
                 //считывает фамилию и имя
          FIOi := DataComponents.adotListSerName.AsString + ' ' + DataComponents.adotListName.AsString;

          //ищет еще один для сравнения этот уже по j
          DataComponents.adotList.Filter := 'Номер=''' + IntToStr(fmCheckerTests.Results[j].NumberOfPupil) + ''''; //находит нужный
                 //считывает фамилию и имя
          FIOj := DataComponents.adotListSerName.AsString + ' ' + DataComponents.adotListName.AsString;

          if fmCheckerTests.Results[i].FullSumBalls > fmCheckerTests.Results[j].FullSumBalls then
          begin
            Buf := fmCheckerTests.Results[i];
            fmCheckerTests.Results.Repalce(i, fmCheckerTests.Results[j]);
            fmCheckerTests.Results.Repalce(j, Buf);
          end //if  fmCheckerTests.Results[i].FullSumBalls < fmCheckerTests.Results[j].FullSumBalls
          else if fmCheckerTests.Results[i].FullSumBalls = fmCheckerTests.Results[j].FullSumBalls then
            if FIOi > FIOj then
            begin
              Buf := fmCheckerTests.Results[i];
              fmCheckerTests.Results.Repalce(i, fmCheckerTests.Results[j]);
              fmCheckerTests.Results.Repalce(j, Buf);
            end; // if ListPupil[fmCheckerTests.Results[i].NumberOfPupil] > ListPupi
        end; //for j := i + 1 to fmCheckerTests.Results.AmountOfBalls - 1 
    end; //0
  1 :
    begin
      for i := 0 to fmCheckerTests.Results.AmountOfBalls - 2 do
        for j := i + 1 to fmCheckerTests.Results.AmountOfBalls - 1 do
        begin
          //ищет первого для сравнения
          DataComponents.adotList.Filter := 'Номер=''' + IntToStr(fmCheckerTests.Results[i].NumberOfPupil) + ''''; //находит нужный
                 //считывает фамилию и имя
          FIOi := DataComponents.adotListSerName.AsString + ' ' + DataComponents.adotListName.AsString;

          //ищет еще один для сравнения этот уже по j
          DataComponents.adotList.Filter := 'Номер=''' + IntToStr(fmCheckerTests.Results[j].NumberOfPupil) + ''''; //находит нужный
                 //считывает фамилию и имя
          FIOj := DataComponents.adotListSerName.AsString + ' ' + DataComponents.adotListName.AsString;

          if fmCheckerTests.Results[i].FullSumBalls < fmCheckerTests.Results[j].FullSumBalls then
          begin
            Buf := fmCheckerTests.Results[i];
            fmCheckerTests.Results.Repalce(i, fmCheckerTests.Results[j]);
            fmCheckerTests.Results.Repalce(j, Buf);
          end //if  fmCheckerTests.Results[i].FullSumBalls < fmCheckerTests.Results[j].FullSumBalls
          else if fmCheckerTests.Results[i].FullSumBalls = fmCheckerTests.Results[j].FullSumBalls then
            if FIOi > FIOj then
              begin
                Buf := fmCheckerTests.Results[i];
                fmCheckerTests.Results.Repalce(i, fmCheckerTests.Results[j]);
                fmCheckerTests.Results.Repalce(j, Buf);
              end; // if ListPupil[fmCheckerTests.Results[i].NumberOfPupil] > ListPupi
        end; // for j := i + 1 to fmCheckerTests.Results.AmountOfBalls - 1
    end; //1
  end; //case
end;

procedure TfmResult.rbSortClick(Sender: TObject);
begin
  case rbSort.ItemIndex of
  0 :
    begin
      cbFIO.Enabled := True;
      cbBalls.Enabled := False;
    end; // 0
  1 :
    begin
      cbFIO.Enabled := False;
      cbBalls.Enabled := True;
    end;  // 1
  end; //case
end;

end.

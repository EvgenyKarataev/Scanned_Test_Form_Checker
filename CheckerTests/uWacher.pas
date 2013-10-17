unit uWacher;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ExtDlgs, ExtCtrls, ToolWin, ActnMan, ActnCtrls,
  XPStyleActnCtrls, ComCtrls, StdCtrls, IniFiles, ImgList;

const
  lbOffsetX = 2;
  lbOffsetY = 1;
  
type
  TTest = class(TObject)
  private
    FSel : TShape;
    FlbNo: TLabel;

    FX, FY, FWidth, FHeight, FdX, FdY: Integer;
    FTypeTest: string;
    FIndexCaption: Integer;

    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetX(const Value: Integer);
    procedure SetY(const Value: Integer);

    procedure SetParent(const Value: TWinControl);
    function GetParent: TWinControl;
    procedure SetIndexCaption(const Value: Integer);
  protected

  public
    property Sel: TShape read FSel;
    property lbNo: TLabel read FlbNo;
    property X: Integer read FX write SetX;
    property Y: Integer read FY write SetY;
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;
    property Parent: TWinControl read GetParent write SetParent;
    property TypeTest: string read FTypeTest write FTypeTest;
    property IndexCaption: Integer read FIndexCaption write SetIndexCaption;
    property dX: Integer read FdX write FdX;
    property dY: Integer read FdY write FdY;

    constructor Create;
    destructor Destroy;
  end;

  TTests = class(TObject)
  private
    FTests: array of TTest;

    FTitleOfSubject: string;
    function GetCount: Integer;
    function GetTest(Index: Integer): TTest;

    procedure Delete(Index: Integer);   //Удаляет
    procedure Clear;
    procedure SetLengthTests(Count: Integer);
  protected

  public
    property TitleOfSubject: string read FTitleOfSubject write FTitleOfSubject;
    property Tests[Index: Integer]: TTest read GetTest; default;
    property Count: Integer read GetCount;

    function AddTest: TTest;                //Добавляет вопрос ко всем остальным

    procedure AddTestInTests(Index: Integer; Test: TTest);
  end;

  TSubjects = class(TObject)
  private
    FSubjects: array of TTests;
    FNumberOfVariant: Integer;

    function GetTests(Index: Integer): TTests;
    function GetCountOfSubject: Integer;
  protected

  public
    property Subjects[Index: Integer]: TTests read GetTests;
    property CountOfSubject: Integer read GetCountOfSubject;
    property NumberOfVariant: Integer read FNumberOfVariant write FNumberOfVariant;

    procedure Clear;

    function LoadFromFile(FileName: string): Boolean;

    destructor Destroy;
  end;

  TfmWach = class(TForm)
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    sbOut: TScrollBox;
    pOut: TPanel;
    iOutBlank: TImage;
    opdOpenBlank: TOpenPictureDialog;
    acLoadBlank: TAction;
    sbStatus: TStatusBar;
    ImageList1: TImageList;
    procedure acLoadBlankExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Subjects: TSubjects;
    OldCaption: string;

    dX, dY: Integer;

    procedure Open;
  end;

var
  fmWach: TfmWach;

implementation

{$R *.dfm}

procedure TfmWach.acLoadBlankExecute(Sender: TObject);
var
  i, j: Integer;
  GoOut: Boolean;
begin
  if opdOpenBlank.Execute then
    begin
      if dX >= 0 then
       for i := 0 to Subjects.CountOfSubject - 1 do
        for j := 0 to Subjects.Subjects[i].Count - 1 do
          begin
            Subjects.Subjects[i].Tests[j].X := Subjects.Subjects[i].Tests[j].X - dX;
            Subjects.Subjects[i].Tests[j].Y :=Subjects.Subjects[i].Tests[j].Y - dY;
          end; //for j := 0 to Subjects.Subjects[i].Count - 1


      iOutBlank.Picture.LoadFromFile(opdOpenBlank.FileName);

      for i := 0 to iOutBlank.Width do
      begin
        for j := 0 to iOutBlank.Height do
          if iOutBlank.Canvas.Pixels[i,j] = clBlack then
            begin
              dX := i;
              dY := j + 1;
              GoOut := True;
              break;
            end;// if iOutBlank.Canvas.Pixels[i,j] = clBlack
        if GoOut then
          break;
      end; // for i := 0 to iOutBlank.Width

      for i := 0 to Subjects.CountOfSubject - 1 do
        for j := 0 to Subjects.Subjects[i].Count - 1 do
          begin
            Subjects.Subjects[i].Tests[j].dX := dX;
            Subjects.Subjects[i].Tests[j].dY := dY;

            Subjects.Subjects[i].Tests[j].X := Subjects.Subjects[i].Tests[j].X + dX;
            Subjects.Subjects[i].Tests[j].Y :=Subjects.Subjects[i].Tests[j].Y + dY;
          end; //for j := 0 to Subjects.Subjects[i].Count - 1
    end;// if opdOpenBlank.Execute
end;

{ TTest }

constructor TTest.Create;
begin
  inherited Create;

  FSel := TShape.Create(nil);      //Создает прямоуг
  FSel.Tag := Integer(Self);
  FSel.Brush.Color := clMoneyGreen;

  FlbNo := TLabel.Create(nil);     //Создает лейбл
  FlbNo.Transparent := True;       //и прозрачность
  FlbNo.Tag := Integer(Self);
  FlbNo.Font.Size := 7;
  FlbNo.Font.Name := 'Tahoma';
  FlbNo.Font.Color := clTeal;
end;

destructor TTest.Destroy;
begin
  FlbNo.Free;                       //Уничтожает цифру
  FSel.Free;                       //Уничтожает прямоугольник

  inherited;
end;

function TTest.GetParent: TWinControl;
begin
  Result := FSel.Parent;          //Получает родителя прямоугольника
end;

procedure TTest.SetHeight(const Value: Integer);
begin
  if Value = FHeight then Exit;

  FHeight := Value;   //Записывает в это поле высоту прямоуг
  FSel.Height := FHeight;                   //задает высоту
  FlbNo.Height := FHeight - lbOffsetY;
end;

procedure TTest.SetIndexCaption(const Value: Integer);
begin
  FlbNo.Caption := IntToStr(Value);     //В лейбл записывает номер вопроса
  FlbNo.Hint := 'Вопрос №' + FlbNo.Caption; //и в подсказку тоже
  FlbNo.ShowHint := True;                   //и вкл подсказки

  FIndexCaption := Value;
end;

procedure TTest.SetParent(const Value: TWinControl);
begin
  FSel.Parent := Value;                     //Установка родителей для прям
  FlbNo.Parent := Value;                    //и лейбла
end;

procedure TTest.SetWidth(const Value: Integer);
begin
  if Value = FWidth then Exit;

  FWidth := Value;                //Записывает в это поле ширину прямоуг
  FSel.Width := FWidth - lbOffsetX;                     //задает ширину
end;

procedure TTest.SetX(const Value: Integer);
begin
  if Value = FX then Exit;

  FX := Value;                //Записывает левую координ
  FSel.Left := Value;            //задает левую координ
  FlbNo.Left := Value + lbOffsetX;
end;

procedure TTest.SetY(const Value: Integer);
begin
  if Value = FY then Exit;

  FY := Value;                //Записывает верхнюю координ
  FSel.Top := Value;             //задает верхнюю координ
  FlbNo.Top := Value + lbOffsetY;
end;

{ TTests }

function TTests.AddTest: TTest;
begin
  Result := TTest.Create;         //Вызывает конструктор
end;

procedure TTests.AddTestInTests(Index: Integer; Test: TTest);
begin
  FTests[Index] := Test;
end;

procedure TTests.Clear;
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
    Delete(i);

  SetLength(FTests, 0);
end;


procedure TTests.Delete(Index: Integer);
begin
  if Index > -1 then
  begin
    Tests[Index].Sel.Free;  //Убивает прямоуг
    Tests[Index].lbNo.Free; //убивает лейбл
  end;
end;

function TTests.GetCount: Integer;
begin
  Result := Length(FTests);
end;

function TTests.GetTest(Index: Integer): TTest;
begin
  Result := FTests[Index];        //по индексу получает  тест(Вопрос)
end;

procedure TTests.SetLengthTests(Count: Integer);
begin
  SetLength(FTests, Count);
end;

{ TSubjects }

procedure TSubjects.Clear;
var
  i: Integer;
begin
  for i := High(FSubjects) downto Low(FSubjects) do
    begin
      FSubjects[i].Clear;
      FSubjects[i].Free;
    end;
  SetLength(FSubjects, 0);
end;

destructor TSubjects.Destroy;
begin
  Clear;

  inherited;
end;


function TSubjects.GetCountOfSubject: Integer;
begin
  Result := Length(FSubjects);
end;

function TSubjects.GetTests(Index: Integer): TTests;
begin
  Result := FSubjects[Index];
end;

function TSubjects.LoadFromFile(FileName: string): Boolean;
var
  AmountOfSubjects, AmountOfTests, i, k: Integer;
  Ini: TIniFile;
  Test: TTest;
  Section: string;
begin
  try
    Ini := TIniFile.Create(FileName);

    AmountOfSubjects := Ini.ReadInteger('About', 'AmountOfSubjects', 0);
    NumberOfVariant := Ini.ReadInteger('About', 'NumberOfVariant', 0);
    SetLength(FSubjects, AmountOfSubjects);


    for k := 0 to AmountOfSubjects - 1 do
    begin
    FSubjects[k] := TTests.Create;

    FSubjects[k].TitleOfSubject := Ini.ReadString('Subject' + IntToStr(k), 'TitleOfSubject', '');
    AmountOfTests := Ini.ReadInteger('Subject' + IntToStr(k), 'AmountOfTests', 0);
    
    FSubjects[k].SetLengthTests(AmountOfTests);

      for i := 0 to AmountOfTests - 1 do
        begin
          Section := 'Subject' + IntToStr(k) + IntToStr(i + 1);

          Test := Self.Subjects[k].AddTest;                //Добавляю новый вопрос
          Test.X := Ini.ReadInteger(Section, 'X', 0);
          Test.Y := Ini.ReadInteger(Section, 'Y', 0);

          Test.Height := Ini.ReadInteger(Section, 'Height', 0);
          Test.Width := Ini.ReadInteger(Section,'Width', 0);

          Test.TypeTest := Ini.ReadString(Section, 'TypeTest', '');

          FSubjects[k].AddTestInTests(i, Test);
        end;
    end;

     Result := True;   //Если все путем то заничт Ок
  except
    Result := False;   //значит не Ок
  end;
  Ini.Destroy;         //Убийство ИНИ
end;

procedure TfmWach.Open;
var
  i, k: Integer;
begin
  for k := 0 to Subjects.CountOfSubject - 1 do
  begin
    for i := 0 to Subjects.Subjects[k].Count - 1 do
      begin
        Subjects.Subjects[k].Tests[i].Parent := pOut;
        Subjects.Subjects[k].Tests[i].IndexCaption := i + 1;

        Subjects.Subjects[k].Tests[i].X := Subjects.Subjects[k].Tests[i].X + dX;
        Subjects.Subjects[k].Tests[i].Y := Subjects.Subjects[k].Tests[i].Y + dY;
      end; // for i := 0 to Subjects.Subjects[k].Count - 1

     with sbStatus.Panels.Add do
     begin
       Text := Subjects.Subjects[k].TitleOfSubject + ' : ' + IntToStr(Subjects.Subjects[k].Count);
       Width := sbStatus.Width div Subjects.CountOfSubject;
     end;
  end; // for k := 0 to Subjects.CountOfSubject - 1
end;

procedure TfmWach.FormCreate(Sender: TObject);
begin
  Subjects := TSubjects.Create;
  dX := 0;
  dY := 0;
end;

procedure TfmWach.FormDestroy(Sender: TObject);
begin
  Subjects.Destroy;
end;

procedure TfmWach.FormShow(Sender: TObject);
var
  i: Integer;
begin
  Screen.Cursor := crHourGlass;
  if Self.Caption <> OldCaption then
    begin
      OldCaption := Self.Caption;

      Subjects.Clear;
      for i := sbStatus.Panels.Count - 1 downto 0 do
    sbStatus.Panels.Delete(i);

      if Subjects.LoadFromFile(Self.Caption) then
        Open;
    end;  //  if Self.Caption <> OldCaption
  Screen.Cursor := crDefault;
end;

end.

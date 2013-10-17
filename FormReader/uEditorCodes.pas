unit uEditorCodes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMan, ImgList, ToolWin, ActnMan, ActnCtrls, ActnMenus,
  XPStyleActnCtrls, ActnList, ExtCtrls, ComCtrls, ExtDlgs, StdCtrls,
  ShellCtrls, Buttons, Menus, IniFiles;

const
  lbOffsetX = 2;
  lbOffsetY = 1;

  FontColorDef = clTeal;
  FontSIzeDef = 7;
  FontNameDef = 'Tahoma';

  FontStyleDef = [];

  NameDef = 'Новый вариант';
  ItemCount = 2;

  CodeS = 654;     //для текста

type
  TSave = record
    Saved, Modified, CanClose: Boolean;
    FileName, Caption: string;
  end;

  TTest = class;

  TTests = class(TObject)
  // Тесты
  private
    FTests: TList;      //Все тесты

    FTitleOfSubject: string;
    function GetTest(Index: Integer): TTest;
    function GetCount: Integer;
  protected

  public
    function AddTest: TTest;                //Добавляет вопрос ко всем остальным
    function IndexOf(Test: TTest): Integer;
    procedure Clear;
    procedure Delete(Index: Integer);   //Удаляет

    property TitleOfSubject: string read FTitleOfSubject write FTitleOfSubject;
    property Count: Integer read GetCount;
    property Tests[Index: Integer]: TTest read GetTest; default;
  end;

  TTest = class(TObject)
  // Тест
  private
    FSel: TShape;
    FlbNo: TLabel;
    FOwner: TTests;
    FTypeTest: string;
    FIndexOfSubject: Integer;
    FIndexCaption: Integer;                  //Какойон элемент в массиве по номеру этот вопрос
    FX, FY, FHeight, FWidth: Integer; //Коор вер лев верх(или цнтра окр) и  высота, ширина
    FdX, FdY: Integer;

    procedure SetX(const Value: Integer);     //Записывает лев координ
    procedure SetY(const Value: Integer);     //Записывает верх координ
    procedure SetHeight(const Value: Integer);//Записывает высоту
    procedure SetWidth(const Value: Integer); //Записывает ширину
    procedure SetIndexCaption(const Value: Integer);

    function GetIndex: Integer;
    function GetParent: TWinControl;
    procedure SetParent(const Value: TWinControl);
    procedure setXatOpen(const Value: Integer);
    procedure setYatOpen(const Value: Integer);
  protected

  public
    property Sel: TShape read FSel;
    property lbNo: TLabel read FlbNo;
    property Owner: TTests read FOwner;
    property TypeTest: string read FTypeTest write FTypeTest;
    property IndexOfSubject: Integer read FIndexOfSubject write FIndexOfSubject;
    property Parent: TWinControl read GetParent write SetParent;
    property IndexCaption: Integer read FIndexCaption write SetIndexCaption;
    property X: Integer read FX write SetX;
    property Y: Integer read FY write SetY;
    property XatOpen: Integer read FX write setXatOpen;
    property YatOpen: Integer read FY write setYatOpen;
    property Height: Integer read FHeight write SetHeight;
    property Width: Integer read FWidth write SetWidth;
    property dX: Integer read FdX write FdX;
    property dY: Integer read FdY write FdY;

    procedure SetColorAndFont(const FontSize: Integer; FontName: string; FontColor, DefColor: TColor;
                               FontStyle: TFontStyles);

    constructor Create(Tests: TTests);
    destructor Destroy;
  end;

  TSubjects = class(TObject)
  private
    FSubjects: array of TTests;

    FSubject, FNumberOfVariant: Integer;

    function GetCountOfSubject: Integer;
    function GetTests(Index: Integer): TTests;
  protected

  public
    property CountOfSubject: Integer read GetCountOfSubject;
    property Subject: Integer read FSubject write FSubject;
    property Subjects[Index: Integer]: TTests read GetTests;
    property NumberOfVariant: Integer read FNumberOfVariant write FNumberOfVariant; 

    procedure Delete(Index: Integer);
    procedure Clear;
    procedure AddSubject;
    procedure SetTitleOfSubject(Index: Integer; S: string);
    procedure SaveToFile(FileName: string);

    function LoadFromFile(FileName: string): Boolean;
    function LoadSubFromFile(FileName: string; Index: Integer): Boolean;

    destructor Destroy;
  end;

  TfmEditorCodes = class(TForm)
    acmMenu: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    ilImages: TImageList;
    XPManifest1: TXPManifest;
    acSave: TAction;
    acOpen: TAction;
    acOpenBlabk: TAction;
    odpOpenBlank: TOpenPictureDialog;
    rbBlankCircle: TRadioButton;
    rbBlankRec: TRadioButton;
    GroupBox1: TGroupBox;
    Panel3: TPanel;
    acReplace: TAction;
    ActionToolBar1: TActionToolBar;
    TimerBlink: TTimer;
    pmForTree: TPopupMenu;
    miDelSelect: TMenuItem;
    N1: TMenuItem;
    miReplace: TMenuItem;
    miCancel: TMenuItem;
    acCancel: TAction;
    sdSave: TSaveDialog;
    odOpen: TOpenDialog;
    acDelSelect: TAction;
    Bevel1: TBevel;
    sbOut: TScrollBox;
    pOut: TPanel;
    iOutBlank: TImage;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    acDel: TAction;
    acNew: TAction;
    N2: TMenuItem;
    miDel: TMenuItem;
    acReplaceNumber: TAction;
    N3: TMenuItem;
    miReplaceNumber: TMenuItem;
    acSaveAs: TAction;
    acDelAllAnswers: TAction;
    acShowNumbers: TAction;
    miAddSubject: TMenuItem;
    N5: TMenuItem;
    pmMenuForImage: TPopupMenu;
    miAddSubjectFromImage: TMenuItem;
    N6: TMenuItem;
    acSelSub: TAction;
    acAddSubject: TAction;
    acDelSubject: TAction;
    acDelAllSubjects: TAction;
    N4: TMenuItem;
    miDelSubject: TMenuItem;
    acTrun90OnHourRay: TAction;
    pmForTreeShell: TPopupMenu;
    asdfasdfsadf1: TMenuItem;
    acOpenFromTree: TAction;
    acClose: TAction;
    mmWelcome: TMemo;
    sbStatus: TStatusBar;
    acRecInStatusBar: TAction;
    acOptions: TAction;
    acAddSubFromFile: TAction;
    lbBlankCircle: TLabel;
    lbBlankRec: TLabel;
    tvTests: TTreeView;
    N7: TMenuItem;
    miChangeNumber: TMenuItem;
    acCangeNumber: TAction;
    acSetPas: TAction;
    N8: TMenuItem;
    N9: TMenuItem;
    acRename: TAction;
    Action1: TAction;
    procedure acOpenBlabkExecute(Sender: TObject);
    procedure iOutBlankMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acReplaceExecute(Sender: TObject);
    procedure TimerBlinkTimer(Sender: TObject);
    procedure acReplaceUpdate(Sender: TObject);
    procedure acCancelUpdate(Sender: TObject);
    procedure acCancelExecute(Sender: TObject);
    procedure acSaveExecute(Sender: TObject);
    procedure acOpenExecute(Sender: TObject);
    procedure acDelSelectExecute(Sender: TObject);
    procedure acDelSelectUpdate(Sender: TObject);
    procedure sbOutMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure sbOutMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure sbOutClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure acDelExecute(Sender: TObject);
    procedure acNewExecute(Sender: TObject);
    procedure acDelUpdate(Sender: TObject);
    procedure acReplaceNumberExecute(Sender: TObject);
    procedure acReplaceNumberUpdate(Sender: TObject);
    procedure acSaveUpdate(Sender: TObject);
    procedure acSaveAsExecute(Sender: TObject);
    procedure acDelAllAnswersExecute(Sender: TObject);
    procedure acDelAllAnswersUpdate(Sender: TObject);
    procedure acShowNumbersExecute(Sender: TObject);
    procedure tvTestsEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure acSelSubExecute(Sender: TObject);
    procedure acAddSubjectExecute(Sender: TObject);
    procedure acDelSubjectExecute(Sender: TObject);
    procedure acDelSubjectUpdate(Sender: TObject);
    procedure acDelAllSubjectsExecute(Sender: TObject);
    procedure acDelAllSubjectsUpdate(Sender: TObject);
    procedure acTrun90OnHourRayExecute(Sender: TObject);
    procedure tvTestsChange(Sender: TObject; Node: TTreeNode);
    procedure acCloseExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure acRecInStatusBarExecute(Sender: TObject);
    procedure acOptionsExecute(Sender: TObject);
    procedure acAddSubFromFileExecute(Sender: TObject);
    procedure lbBlankCircleClick(Sender: TObject);
    procedure lbBlankRecClick(Sender: TObject);
    procedure lbBlankCircleMouseEnter(Sender: TObject);
    procedure lbBlankCircleMouseLeave(Sender: TObject);
    procedure lbBlankRecMouseEnter(Sender: TObject);
    procedure lbBlankRecMouseLeave(Sender: TObject);
    procedure miChangeNumberClick(Sender: TObject);
    procedure acCangeNumberExecute(Sender: TObject);
    procedure acSetPasExecute(Sender: TObject);
    procedure acRenameExecute(Sender: TObject);
    procedure acRenameUpdate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    X1, X2, Y1, Y2: Integer;        //Когда ищу координ краев прямоугол.
    OldTest: TTest;
    OldSubject: TTests;
    Save: TSave;    //Для сохранения, если уже сохранен, то неактив
    SetModified, PasModified: Boolean;

    dXO, dYO: Integer;

    procedure SelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbNoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure SelectTest(Test: TTest);
    procedure SelectSub(Subject: TTests);
    procedure DelSelectSub(Subject: TTests);
    procedure ClearAll;
    procedure Open;
    procedure AddSubFromFile;
    procedure RePaint(FC, FS, FN, FSt, DC, SC, SS, Checked: Boolean);
    procedure SaveOfSettings;
    procedure NeedMovi;


    function UpCaseAllLetter(CH: Char): Char;
    function GetFileName(FileName: string): string;
    function FindCircle(Canvas: TCanvas; X, Y: Integer; var cX, cY, R: Integer): Boolean;
    function Number: boolean;
    function Shifrovka(Str: string): string;
  public
    { Public declarations }
    CountInTests: Integer;  //Когда щелкнули в Лите, то сюда записываем номер этого
                            //вопроса в общем массиве, чтобы потом перекрасить цвет и тд.}
    Subjects: TSubjects;

    DefColor, SelColor, SelSub, FontColor: TColor;
    FontName, NameOfSameSub: string;
    FontSize: Integer;
    FontStyle: TFontStyles;

    Code: Integer;

    SubjectsFromFile: array of string;

    Password, OldPassword: string;

    procedure IfRec(X, Y: Integer);
    procedure IfCircle(X, Y: Integer);
  end;

var
  fmEditorCodes: TfmEditorCodes;

implementation

uses uKind, uListOfSubjects, uSameSubjects, uEntrance, uAbout, uLoad;

{$R *.dfm}

procedure TfmEditorCodes.acOpenBlabkExecute(Sender: TObject);
//открытие бланка
begin
  if Subjects.CountOfSubject > 0 then
   case MessageDlg('Удалить предметы и варианты ответов?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
      if odpOpenBlank.Execute then
        begin
          Screen.Cursor := crHourGlass;

          iOutBlank.Picture.LoadFromFile(odpOpenBlank.FileName);
          ClearAll;
          mmWelcome.Visible := False;
        end;
    mrNo:
      if odpOpenBlank.Execute then
        begin
          Screen.Cursor := crHourGlass;

          iOutBlank.Picture.LoadFromFile(odpOpenBlank.FileName);
          mmWelcome.Visible := False;

          NeedMovi;

        end;
    mrCancel: Exit;
    end
  else
    if odpOpenBlank.Execute then
      begin
        Screen.Cursor := crHourGlass;

        iOutBlank.Picture.LoadFromFile(odpOpenBlank.FileName);
        mmWelcome.Visible := False;
      end;

  Screen.Cursor := crDefault;
end;

{ TTest }

constructor TTest.Create(Tests: TTests);
begin
  inherited Create;

  FOwner := Tests;
  FSel := TShape.Create(nil);      //Создает прямоуг
  FSel.Tag := Integer(Self);

  FlbNo := TLabel.Create(nil);     //Создает лейбл
  FlbNo.Transparent := True;       //и прозрачность
  FlbNo.Tag := Integer(Self);
end;

destructor TTest.Destroy;
begin
  FlbNo.Free;                       //Уничтожает цифру
  FSel.Free;                       //Уничтожает прямоугольник

  inherited;
end;

function TTest.GetIndex: Integer;
begin
  Result := FOwner.IndexOf(Self); //?
end;

function TTest.GetParent: TWinControl;
begin
  Result := FSel.Parent;          //Получает родителя прямоугольника
end;

procedure TTest.SetColorAndFont(const FontSize: Integer; FontName: string;
  FontColor, DefColor: TColor; FontStyle: TFontStyles);
begin
  FSel.Brush.Color := DefColor;    //делает его сним

  FlbNo.Font.Name := FontName;     //Устанавливается шрифт,
  FlbNo.Font.Size := FontSize;            //его размер,
  FlbNo.Font.Color := FontColor;     //его цвет,
  FlbNo.Font.Style := FontStyle;     //его стиль
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

  FX := Value - FdX;                //Записывает левую координ
  FSel.Left := Value;            //задает левую координ
  FlbNo.Left := Value + lbOffsetX;
end;

procedure TTest.setXatOpen(const Value: Integer);
begin
  FSel.Left := FX + Value;            //задает левую координ
  FlbNo.Left := FX + Value + lbOffsetX;
end;

procedure TTest.SetY(const Value: Integer);
begin
  if Value = FY then Exit;

  FY := Value - FdY;                //Записывает верхнюю координ
  FSel.Top := Value;             //задает верхнюю координ
  FlbNo.Top := Value + lbOffsetY;
end;

procedure TTest.setYatOpen(const Value: Integer);
begin
  FSel.Top := FY + Value;             //задает верхнюю координ
  FlbNo.Top := FY + Value + lbOffsetY;
end;

{ TTests }

procedure TTests.Clear;
//Отчистка всех тестов, начиная с конца удаляет все тесты
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
    Delete(i);
end;

function TTests.AddTest: TTest;
begin
  Result := TTest.Create(Self);         //Вызывает конструктор
  FTests.Add(Result);
//  Result.SetIndex(FTests.Add(Result));  // ?
end;

procedure TTests.Delete(Index: Integer);
//Удаление вопроса
begin
  if Index > -1 then
  begin
    Tests[Index].Sel.Free;  //Убивает прямоуг
    Tests[Index].lbNo.Free; //убивает лейбл
    FTests.Delete(Index);
  end;
end;

function TTests.GetCount: Integer;
begin
  Result := FTests.Count;          //Сколько всего вопросов уже
end;

function TTests.GetTest(Index: Integer): TTest;
begin
  Result := FTests[Index];        //по индексу получает  тест(Вопрос)
end;

procedure TfmEditorCodes.iOutBlankMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
//Нажатие на ИМЕЙДЖ
begin
  if (tvTests.Items.Count > 1)and(tvTests.Items.Item[0].Selected = False) then
  begin
    if Button = mbLeft then                //только если левой
      begin
        if rbBlankRec.Checked then IfRec(X, Y)  //смотрит какой отмечев вид бланка
          else IfCircle(X, Y);
        Save.Modified := True;                  //Говорит что что-то изменилось

        acRecInStatusBar.OnExecute(Sender);
      end;
  end;
end;

function TfmEditorCodes.FindCircle(Canvas: TCanvas; X, Y: Integer; var cX, cY, R: Integer): Boolean;
// Находит окружность с принадлежащей ей точкой
var
  srcColor: TColor;
  lX, rX, tY, bY: Integer;
begin
  Result := False;

  srcColor := Canvas.Pixels[X, Y];

  lX := X;
  while (lX > -1) and (Canvas.Pixels[lX, Y] = srcColor) do Dec(lX);
  rX := X;
  while (rX < Canvas.ClipRect.Right) and (Canvas.Pixels[rX, Y] = srcColor) do Inc(rX);

  cX := Round((rX + lX)/2);

  tY := Y;
  while (tY > -1) and (Canvas.Pixels[X, tY] = srcColor) do Dec(tY);
  bY := Y;
  while (bY < Canvas.ClipRect.Bottom) and (Canvas.Pixels[X, bY] = srcColor) do Inc(bY);

  cY := Round((bY + tY)/2);

  R := Round(((rX - lX)/2 + (bY - tY)/2)/2);
  Result := True;
end;

procedure TfmEditorCodes.IfCircle(X, Y: Integer);
var
  Test: TTest;
  cX, cY, R: Integer;
begin
  if (TimerBlink.Enabled = True)and(iOutBlank.Canvas.Pixels[X, Y] <> clBlack)
  and (FindCircle(iOutBlank.Canvas, X, Y, cX, cY, R)) then
    begin
      Test := TTest(tvTests.Selected.Data); //получаем тест по выделенуму номеру в листе
      Test.X := cX - R;                                      //Вызывает дан процедуру
      Test.Y := cY - R;                                      //Вызывает дан процедуру

      Test.Height := cY + R;                                 //Высчитывает высоту прямоугольника
      Test.Width := cX + R;
      Test.Sel.Brush.Color := SelColor; //install color

      TimerBlink.Enabled := False;      //timer off
      miDelSelect.Enabled := True;      //"Убрать выделение" on
    end
  else
  if iOutBlank.Canvas.Pixels[X, Y] <> clBlack then  //Если щелскнули не по черному
  begin
    if FindCircle(iOutBlank.Canvas, X, Y, cX, cY, R) then
      begin
        Test := Subjects.FSubjects[Subjects.Subject].AddTest; //Добавляю новый вопрос
        Test.IndexOfSubject := Subjects.Subject;
        Test.Sel.Shape := stCircle;              //задает вид шейпа
        Test.TypeTest := 'stCircle';
        Test.Sel.OnMouseUp := SelMouseUp;
        Test.lbNo.OnMouseUp := lbNoMouseUp;

        if tvTests.Selected.Level = 1 then
          Test.IndexCaption := tvTests.Selected.Count
        else
          Test.IndexCaption := tvTests.Selected.Parent.Count;

        Test.X := cX - R;                                      //Вызывает дан процедуру
        Test.Y := cY - R;                                      //Вызывает дан процедуру

        Test.Height := 2 * R;                                 //Высчитывает высоту прямоугольника
        Test.Width := 2 * R;                                  //Высчитывает ширину прямоугольника
        Test.Parent := pOut;

        if tvTests.Selected.Level = 1 then
          with tvTests.Items.AddChildObject(tvTests.Selected, IntToStr(Test.IndexCaption + 1), Test) do
            Selected := True
        else
          with tvTests.Items.AddObject(tvTests.Selected, IntToStr(Test.IndexCaption + 1), Test) do
            Selected := True;
          end;
   end;
end;

procedure TfmEditorCodes.IfRec(X, Y: Integer);
var
  i, j, Index, dX, dY: Integer;
  Test: TTest;
begin
  //Если уже мигает и кто-то не попал на ченую линию то перемещает прямоугольник
  if (TimerBlink.Enabled = True)and(iOutBlank.Canvas.Pixels[X, Y] <> clBlack) then
    begin
      for i := Y downto 0 do        //иду до верхней граници прямоуг
        if iOutBlank.Canvas.Pixels[X, i] = clBlack then
          begin
            Y1 := i;  //верхняя граница
            break;
          end;

      for i := X downto 0 do         //иду до левой граници прямоуг
        if iOutBlank.Canvas.Pixels[i, Y] = clBlack then
          begin
            X1 := i;   //левая граница
            break;
          end;
                //иду до правой граници прямоуг
      for i := X to iOutBlank.ClientWidth do
        if iOutBlank.Canvas.Pixels[i, Y] = clBlack then
          begin
            X2 := i + 3;    //правая граница
            break;
          end;
              //иду до нижней граници прямоуг
      for i := Y to iOutBlank.ClientHeight do
        if iOutBlank.Canvas.Pixels[X, i] = clBlack then
          begin
            Y2 := i + 1;   //нижняя граница
            break;
          end;

      Test := TTest(tvTests.Selected.Data); //получаем тест по выделенуму номеру в листе
      Test.X := X1;                     //зап. левая граница
      Test.Y := Y1;                     //rec. top boundary
      Test.Width := X2 - X1;            //rec. width of rect
      Test.Height := Y2 - Y1;           //rec height
      Test.Sel.Brush.Color := SelColor; //install color

      TimerBlink.Enabled := False;      //timer off
      miDelSelect.Enabled := True;      //"Убрать выделение" on
    end
  else //If blinks nothing
  if iOutBlank.Canvas.Pixels[X, Y] <> clBlack then  //Если щелскнули не по черному
  begin
    for i := Y downto 0 do //иду до верхней граници прямоуг
       if iOutBlank.Canvas.Pixels[X, i] = clBlack then
        begin
          Y1 := i;
          break;
        end;
              //иду до правой граници прямоуг
    for i := X to iOutBlank.ClientWidth do
      if iOutBlank.Canvas.Pixels[i, Y] = clBlack then
        begin
          X2 := i + 3;
          break;
        end;
              //иду до нижней граници прямоуг
    for i := Y to iOutBlank.ClientHeight do
      if iOutBlank.Canvas.Pixels[X, i] = clBlack then
        begin
          Y2 := i + 1;
          break;
        end;
              //иду до левой граници прямоуг
    for i := X downto 0 do
      if iOutBlank.Canvas.Pixels[i, Y] = clBlack then
        begin
          X1 := i;
          break;
        end;
        
    Test := Subjects.FSubjects[Subjects.Subject].AddTest; //Добавляю новый вопрос
    Test.SetColorAndFont(FontSize, FontName, FontColor, DefColor, FontStyle);
    Test.IndexOfSubject := Subjects.Subject;
    Test.Sel.Shape := stRectangle;              //задает вид шейпа
    Test.TypeTest := 'stRectangle';
    Test.Sel.OnMouseUp := SelMouseUp;
    Test.lbNo.OnMouseUp := lbNoMouseUp;
    Test.lbNo.Visible := acShowNumbers.Checked;

    if Subjects.Subjects[Subjects.Subject].Count = 1 then
       if tvTests.Selected.Level = 1 then
         Test.IndexCaption := tvTests.Selected.Count + 1
       else
         Test.IndexCaption := tvTests.Selected.Parent.Count + 1
     else
       begin
         Index := Subjects.Subjects[Subjects.Subject].IndexOf(Test) - 1;
         Test.IndexCaption := Subjects.Subjects[Subjects.Subject].Tests[Index].IndexCaption + 1;
       end;

    for i := 0 to X1 do
      if iOutBlank.Canvas.Pixels[i, Y1] = clBlack then
        begin
          dX := i;
          break;
        end;

    for i := 0 to Y1 do
      if iOutBlank.Canvas.Pixels[X1, i] = clBlack then
        begin
          dY := i;
          break;
        end;

    Test.dX := dX;
    Test.dY := dY;

    Test.X := X1;                                      //Вызывает дан процедуру
    Test.Y := Y1;                                      //Вызывает дан процедуру

    Test.Height := Y2 - Y1;                                 //Высчитывает высоту прямоугольника
    Test.Width := X2 - X1;                                  //Высчитывает ширину прямоугольника
    Test.Parent := pOut;

    if tvTests.Selected.Level = 1 then
      with tvTests.Items.AddChildObject(tvTests.Selected, IntToStr(Test.IndexCaption), Test) do
        Selected := True
    else
      with tvTests.Items.AddObject(tvTests.Selected, IntToStr(Test.IndexCaption), Test) do
        Selected := True;
      tvTests.Selected.ImageIndex := 2;
      tvTests.Selected.SelectedIndex := 2;
   end;
end;

procedure TfmEditorCodes.FormCreate(Sender: TObject);
var
  Welcome: string;
  Path: string;
  i: Integer;
  Ini: TIniFile;
begin
  SetModified := False;

  Code := CodeS;

  Subjects := TSubjects.Create;
  Save.Caption := Caption;
  Save.FileName := NameDef;
  Self.Caption := Save.Caption + ' - ' + Save.FileName;

  Path := Application.ExeName;

  for i := Length(Path) downto 0 do
    if Path[i] = '\' then
      begin
        Delete(Path, i + 1, Length(Path) - i);
        break;
      end;
  Path := Path + 'Setting.ini';

  try
    Ini := TIniFile.Create(Path);

    if Ini.ReadString('Font', 'Name', '') = '' then
      FontName := FontNameDef
    else
      FontName := Ini.ReadString('Font', 'Name', '');

    if Ini.ReadString('Font', 'Style', '') = '' then
      FontStyle := FontStyleDef
    else if Ini.ReadString('Font', 'Style', '') = 'обычный' then
           FontStyle := []
         else if Ini.ReadString('Font', 'Style', '') = 'жирный' then
           FontStyle := [fsBold]
         else if Ini.ReadString('Font', 'Style', '') = 'курсив' then
           FontStyle := [fsItalic]
         else if Ini.ReadString('Font', 'Style', '') = 'жирный курсив' then
           FontStyle := [fsBold, fsItalic];

    if Ini.ReadInteger('Font', 'Size', 0) = 0 then
      FontSize := FontSizeDef
    else
      FontSize := Ini.ReadInteger('Font', 'Size', 0);

    if Ini.ReadInteger('Colors', 'FontColor', -1) = -1  then
      FontColor := FontColorDef
    else
      FontColor := Ini.ReadInteger('Colors', 'FontColor', 0);

    if Ini.ReadInteger('Colors', 'DefColor', -1) = -1 then
      DefColor := clMoneyGreen
    else
      DefColor := Ini.ReadInteger('Colors', 'DefColor', 0);

    if Ini.ReadInteger('Colors', 'SelColor', -1) = -1 then
      SelColor := clSkyBlue
    else
      SelColor := Ini.ReadInteger('Colors', 'SelColor', 0);

    if Ini.ReadInteger('Colors', 'SelSub', -1) = -1 then
      SelSub := clYellow
    else
      SelSub := Ini.ReadInteger('Colors', 'SelSub', 0);

    Password := Shifrovka(Ini.ReadString('Font', 'Text', ''));
    OldPassword := Password;

  finally
    Ini.Destroy;
  end; //try
end;

procedure TfmEditorCodes.FormDestroy(Sender: TObject);
begin
  Subjects.Free;
end;

procedure TfmEditorCodes.SelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
//Когда нажимаем на прямоугольник, то его надо выделить. Для начала получаем его номер в
//листе и затем вызывем процедуру выделения Select
var
  Rec: TShape;
  Point: TPoint;
  Test: TTest;
begin

  if TimerBlink.Enabled then
    TimerBlink.Enabled := False;

  Rec := TShape(Sender);
  Test := TTest(Rec.Tag);

  case Button of
  mbLeft: SelectTest(Test);
  mbRight:
    begin
      SelectTest(Test);
      Point.X := X; Point.Y := Y;
      Point := Rec.ClientToScreen(Point);
      pmForTree.Popup(Point.X, Point.Y)
    end;
  end;
end;

procedure TfmEditorCodes.lbNoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  lb: TLabel;
  Test: TTest;
  Point: TPoint;
begin
  if TimerBlink.Enabled then
    TimerBlink.Enabled := False;

  lb := TLabel(Sender);
  Test := TTest(lb.Tag);

  case Button of
  mbLeft:  SelectTest(Test);
  mbRight:
    begin
      SelectTest(Test);
      Point.X := X; Point.Y := Y;
      Point := lb.ClientToScreen(Point);
      pmForTree.Popup(Point.X, Point.Y)
    end;
  end;
end;

procedure TfmEditorCodes.acReplaceExecute(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;

  TimerBlink.Enabled := True;    //Вкл. таймера
  miDelSelect.Enabled := False;  //Выкл "Убрать выделение"

  Screen.Cursor := crDefault;
end;

procedure TfmEditorCodes.TimerBlinkTimer(Sender: TObject);
//Меняет цвета син и крас
var
  Test: TTest;
begin
  Test := TTest(tvTests.Selected.Data);
  if TimerBlink.Tag mod 2 = 0 then
    begin
      TimerBlink.Tag := 1;
      Test.Sel.Brush.Color := DefColor;
    end
  else
    begin
      TimerBlink.Tag := 2;
      Test.Sel.Brush.Color := SelColor;
    end;
end;

{Контекстное меню для Листа}
procedure TfmEditorCodes.acDelSelectExecute(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;

  //Перекрашивает его наза в синий
  OldTest.Sel.Brush.Color := DefColor;
  tvTests.Items.Item[0].Item[OldTest.IndexOfSubject].Selected := True;
  OldTest := nil;
  miDelSelect.Enabled := False; //Выкл "Убрать выделение"

  Screen.Cursor := crDefault;
end;

procedure TfmEditorCodes.acReplaceUpdate(Sender: TObject);
//UpDate для "Изменить" вкл или выкл в зависимоти от "Убрать выделение"
begin
  if  miDelSelect.Enabled then
    begin
      acReplace.Enabled := True;
      miReplace.Enabled := True;
    end
  else
    begin
      acReplace.Enabled := False;
      miReplace.Enabled := False;
    end
end;

procedure TfmEditorCodes.acCancelUpdate(Sender: TObject);
//UpDate для "Отменить" вкл или выкл в зависимоти от таймера
begin
  if TimerBlink.Enabled then
    acCancel.Enabled := True
  else
    acCancel.Enabled := False;
end;

procedure TfmEditorCodes.acDelSelectUpdate(Sender: TObject);
//UpDate для "Убрать выделение" вкл или выкл в зависимоти от контекстного меню
begin
  if miDelSelect.Enabled then
    acDelSelect.Enabled := True
  else
    acDelSelect.Enabled := False;
end;

procedure TfmEditorCodes.acDelUpdate(Sender: TObject);
begin
  if miDelSelect.Enabled then
    acDel.Enabled := True
  else
    acDel.Enabled := False;
end;

procedure TfmEditorCodes.acReplaceNumberUpdate(Sender: TObject);
begin
  if (miDelSelect.Enabled)and(tvTests.Selected.Level > 1) then
    acReplaceNumber.Enabled := True
  else
    acReplaceNumber.Enabled := False;
end;

procedure TfmEditorCodes.acSaveUpdate(Sender: TObject);
begin
  if Save.Modified then
      acSave.Enabled := True
  else
    acSave.Enabled := False;
end;

procedure TfmEditorCodes.acCancelExecute(Sender: TObject);
//"Отменить" отменяет мигание прямоугольника. Становится нельзя поменять вариант
var
  Test: TTest;
begin
  Screen.Cursor := crHourGlass;

  TimerBlink.Enabled := False;
  Test := TTest(tvTests.Selected.Data);
  Test.Sel.Brush.Color := SelColor;
  miDelSelect.Enabled := True;

  Screen.Cursor := crDefault;
end;

procedure TfmEditorCodes.acSaveExecute(Sender: TObject);
begin
  if Number then
    begin
      Subjects.NumberOfVariant := StrToInt(tvTests.Items.Item[0].Text);
    if Save.Saved then
      begin
        Screen.Cursor := crHourGlass;

        Subjects.SaveToFile(sdSave.FileName);
        Save.Modified := False;
      end
    else
      if sdSave.Execute then
        begin
          Screen.Cursor := crHourGlass;

          Subjects.SaveToFile(sdSave.FileName);
          Save.Modified := False;
          Save.FileName := GetFileName(sdSave.FileName);
          Save.Saved := True;
          Save.CanClose := True;
        end
      else
        Save.CanClose := False;
    sdSave.Title := 'Сохранить';

    Screen.Cursor := crDefault;
    end // if Number
  else
    begin
      ShowMessage('Введите только номер варианта!');
      acCangeNumber.Execute;
    end;
end;

procedure TfmEditorCodes.acOpenExecute(Sender: TObject);
var
  i: Integer;
begin
  if Save.Modified then
  case MessageDlg('Сохранить изменения в файле ' + Save.FileName + '?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
    mrYes:  acSave.OnExecute(Sender);
    mrCancel: Exit;
    end;

  if odOpen.Execute then
    begin
      Screen.Cursor := crHourGlass;

      mmWelcome.Visible := False;
      Save.Saved := True;
      sdSave.FileName := odOpen.FileName;
      
      ClearAll;

      if Subjects.LoadFromFile(odOpen.FileName)  then
        Open;

      for i := 0 to Subjects.CountOfSubject - 1 do
        sbStatus.Panels.Add;

      acRecInStatusBar.OnExecute(Sender);

      Screen.Cursor := crDefault;
    end;
end;

procedure TfmEditorCodes.sbOutMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbOut.ScrollBy(0, 4);
end;

procedure TfmEditorCodes.sbOutMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  sbOut.ScrollBy(0, -4);
end;

procedure TfmEditorCodes.sbOutClick(Sender: TObject);
begin
  sbOut.SetFocus;
end;

procedure TfmEditorCodes.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if sbOut.Focused then sbOutMouseWheelDown(Sender, Shift, MousePos, Handled);
end;

procedure TfmEditorCodes.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if sbOut.Focused then sbOutMouseWheelUp(Sender, Shift, MousePos, Handled);
end;

function TTests.IndexOf(Test: TTest): Integer;
begin
  Result := FTests.IndexOf(Test)
end;

procedure TfmEditorCodes.SelectTest(Test: TTest);
var
  Index, i: Integer;
begin
  if Assigned(OldTest) then OldTest.Sel.Brush.Color := SelSub;

  Subjects.Subject := Test.IndexOfSubject;
  Index := Subjects.Subjects[Subjects.Subject].IndexOf(Test);

  tvTests.Items.Item[0].Item[Subjects.Subject].Item[Index].Selected := True;

  Test.Sel.Brush.Color := SelColor;

  OldTest := Test;
  miDelSelect.Enabled := True;

  for i := 0 to Subjects.CountOfSubject - 1 do
    pmMenuForImage.Items.Items[i + ItemCount].Checked := False;
  pmMenuForImage.Items.Items[Subjects.Subject + ItemCount].Checked := True;
end;

procedure TfmEditorCodes.acDelExecute(Sender: TObject);
var
  Test: TTest;
  Index: Integer;
begin
  Screen.Cursor := crHourGlass;

  Test := TTest(tvTests.Selected.Data);

  acDelSelect.Enabled := False;

  Index := Subjects.Subjects[Subjects.Subject].IndexOf(Test);
  Subjects.Subjects[Subjects.Subject].Delete(Index);
  OldTest := nil;

  tvTests.Items.Item[0].Item[Subjects.Subject].Item[Index].Delete;
  if Index < Subjects.Subjects[Subjects.Subject].Count then
    tvTests.Items.Item[0].Item[Subjects.Subject].Item[Index].Selected := True
  else if Index > 0 then
    tvTests.Items.Item[0].Item[Subjects.Subject].Item[Index - 1].Selected := True
    else
      begin
        tvTests.Items.Item[0].Item[Subjects.Subject].Selected := True;
         miDelSelect.Enabled := False;
      end;

  Save.Modified := True;

  acRecInStatusBar.OnExecute(Sender);

  Screen.Cursor := crDefault;
end;

procedure TfmEditorCodes.ClearAll;
var
  i: Integer;
begin
  Subjects.Clear;
  tvTests.Items.Clear;
  tvTests.Items.Add(nil, 'Введите номер варианта');
  OldTest := nil;

  for i := pmMenuForImage.Items.Count - 1 downto ItemCount do
    pmMenuForImage.Items.Delete(i);

  with tvTests.Items.Item[0] do
    begin
      SelectedIndex := 30;
      ImageIndex := 30;
      Selected := True;
    end;

  OldSubject := nil;

  for i := sbStatus.Panels.Count - 1 downto 0 do
    sbStatus.Panels.Delete(i);
end;

procedure TfmEditorCodes.acNewExecute(Sender: TObject);
begin
  if Save.Modified then
  case MessageDlg('Сохранить изменения в файле ' + Save.FileName + '?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
    mrYes:  acSave.OnExecute(Sender);
    mrCancel: Exit;
    end;

  Screen.Cursor := crHourGlass;

  ClearAll;

  miDelSelect.Enabled := False;

  Save.Saved := False;

  acSave.Enabled := False;

  Self.Caption := Save.Caption + ' - ' + NameDef;

  Screen.Cursor := crDefault;
end;

procedure TfmEditorCodes.acReplaceNumberExecute(Sender: TObject);
var
  Index, i, Next: Integer;
  Number: string;
  Test: TTest;
begin
 try
  if InputQuery('','Введите, новый номер вопроса', Number) and (StrToInt(Number) > 0) then
    begin
      Screen.Cursor := crHourGlass;

      Next := 0;
      Test := TTest(tvTests.Selected.Data);
      Index := Subjects.Subjects[Subjects.Subject].IndexOf(Test);
      for i := Index to Subjects.Subjects[Subjects.Subject].Count - 1 do
        begin
          Subjects.Subjects[Subjects.Subject].Tests[i].lbNo.Caption := IntToStr(StrToInt(Number) + Next);
          Subjects.Subjects[Subjects.Subject].Tests[i].IndexCaption := StrToInt(Number) + Next;
          tvTests.Items.Item[0].Item[Subjects.Subject].Item[i].Text := IntToStr(StrToInt(Number) + Next);
          inc(Next);
        end;
      Save.Modified := True;

      Screen.Cursor := crDefault;
    end
  else
    ShowMessage('Probably, number of question is less 1, please try again.'+ #13#10 + #13#10 + 'Вы ввели номер вопроса меньше 1, повторите попытку.');
 except
   ShowMessage('Введите целое число, которое не привышает 2 000 000!');
 end
end;

function TfmEditorCodes.GetFileName(FileName: string): string;
var
  i: Integer;
begin
  for i := Length(FileName) downto 0 do
      if FileName[i] = '\' then
        begin
          Result := Copy(FileName, i + 1, Length(FileName) - i);
            if Pos('.', Result) > 0 then
              Result := Copy(Result, 1, Pos('.', Result) - 1);
          break;
        end;
  Caption := Save.Caption + ' - ' + Result;
end;

procedure TfmEditorCodes.acSaveAsExecute(Sender: TObject);
begin
  Save.Saved := False;
  sdSave.Title := 'Сохранить как...';
  acSave.OnExecute(Sender);
end;

procedure TfmEditorCodes.acDelAllAnswersExecute(Sender: TObject);
var
  k, i: Integer;
begin
  case MessageDlg('Вы действительно хотите удалить все ответы?', mtConfirmation, [mbYes, mbNo], 0) of
    mrYes:
      begin
        Screen.Cursor := crHourGlass;

        for k := 0 to Subjects.CountOfSubject - 1 do
        begin
          for i := Subjects.Subjects[k].Count - 1 downto 0 do
            tvTests.Items.Item[0].Item[k].Item[i].Delete;
          Subjects.Subjects[k].Clear;
        end;
        OldTest := nil;
        miDelSelect.Enabled := False;

        acRecInStatusBar.OnExecute(Sender);

        Screen.Cursor := crDefault;
      end;
    mrNo: Exit;
  end;
end;

procedure TfmEditorCodes.acDelAllAnswersUpdate(Sender: TObject);
var
  k: Integer;
begin
  for k := 0 to Subjects.CountOfSubject - 1 do
  if (Subjects.Subjects[k].Count > 0) and (acCancel.Enabled = False) then
    begin
      acDelAllAnswers.Enabled := True;
      break
    end
  else
    acDelAllAnswers.Enabled := False;
end;

procedure TfmEditorCodes.acShowNumbersExecute(Sender: TObject);
var
  i, k: Integer;
begin
  Screen.Cursor := crHourGlass;

  acShowNumbers.Checked := not acShowNumbers.Checked;
  for k := 0 to Subjects.CountOfSubject - 1 do
  for i := 0 to Subjects.Subjects[k].Count - 1 do
    if acShowNumbers.Checked then
      Subjects.Subjects[k].Tests[i].lbNo.Visible := True
    else
      Subjects.Subjects[k].Tests[i].lbNo.Visible := False;

  Screen.Cursor := crDefault;
end;

{ TSubjects }

procedure TSubjects.AddSubject;
begin
  SetLength(FSubjects, Length(FSubjects) + 1);
  FSubjects[High(FSubjects)] := TTests.Create;
  FSubjects[High(FSubjects)].FTests := TList.Create;
end;

procedure TSubjects.Clear;
var
  i: Integer;
begin
  for i := High(FSubjects) downto Low(FSubjects) do
    Delete(i);
end;

procedure TSubjects.Delete(Index: Integer);
var
  i, k: Integer;
  Sub: TTests;
begin
 for i := Index to High(FSubjects) - 1 do
  begin
   Sub := FSubjects[i + 1];
     for k := 0 to Sub.Count - 1 do
       Sub.Tests[k].IndexOfSubject := i;
   FSubjects[i + 1] := FSubjects[i];
   FSubjects[i] := Sub;
  end;
 FSubjects[High(FSubjects)].Clear;
 FSubjects[High(FSubjects)].Free;
 SetLength(FSubjects, Length(FSubjects) - 1);
end;

destructor TSubjects.Destroy;
var
  i, k: Integer;
begin
  for k := Low(FSubjects) to High(FSubjects) do
  begin
    for i := 0 to Pred(FSubjects[k].FTests.Count) do TTest(FSubjects[k].FTests[i]).Free;
    FSubjects[k].FTests.Clear;
    FSubjects[k].FTests.Free;
  end;

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
//Загружает из файла
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
    FSubjects[k].FTests := TList.Create;

    FSubjects[k].TitleOfSubject := Ini.ReadString('Subject' + IntToStr(k), 'TitleOfSubject', '');
    AmountOfTests := Ini.ReadInteger('Subject' + IntToStr(k), 'AmountOfTests', 0);
      for i := 0 to AmountOfTests - 1 do
        begin
          Section := 'Subject' + IntToStr(k) + IntToStr(i + 1);

          Test := Self.Subjects[k].AddTest;                //Добавляю новый вопрос
          Test.X := Ini.ReadInteger(Section, 'X', 0);
          Test.Y := Ini.ReadInteger(Section, 'Y', 0);

          Test.Height := Ini.ReadInteger(Section, 'Height', 0);
          Test.Width := Ini.ReadInteger(Section,'Width', 0);

          Test.TypeTest := Ini.ReadString(Section, 'TypeTest', '')
        end;
    end;

     Result := True;   //Если все путем то заничт Ок
  except
    Result := False;   //значит не Ок
  end;
  Ini.Destroy;         //Убийство ИНИ
end;

function TSubjects.LoadSubFromFile(FileName: string;
  Index: Integer): Boolean;
var
  AmountOfSubjects, AmountOfTests, i, k: Integer;
  Ini: TIniFile;
  Test: TTest;
  Section: string;
begin
  try
    Ini := TIniFile.Create(FileName);

    SetLength(FSubjects, Length(FSubjects) + 1);
    k := Length(FSubjects) - 1;

    FSubjects[k] := TTests.Create;
    FSubjects[k].FTests := TList.Create;

    FSubjects[k].TitleOfSubject := Ini.ReadString('Subject' + IntToStr(Index), 'TitleOfSubject', '');
    AmountOfTests := Ini.ReadInteger('Subject' + IntToStr(Index), 'AmountOfTests', 0);
      for i := 0 to AmountOfTests - 1 do
        begin
          Section := 'Subject' + IntToStr(Index) + IntToStr(i + 1);

          Test := Self.Subjects[k].AddTest;                //Добавляю новый вопрос
          Test.X := Ini.ReadInteger(Section, 'X', 0);
          Test.Y := Ini.ReadInteger(Section, 'Y', 0);

          Test.Height := Ini.ReadInteger(Section, 'Height', 0);
          Test.Width := Ini.ReadInteger(Section,'Width', 0);

          Test.TypeTest := Ini.ReadString(Section, 'TypeTest', '')
        end; //for i :=

     Result := True;   //Если все путем то заничт Ок
  except
    Result := False;   //значит не Ок
  end;
  Ini.Destroy;         //Убийство ИНИ
end;

procedure TSubjects.SaveToFile(FileName: string);
//СОхранение в файл
var
  Ini: TIniFile;
  i, k: Integer;
  Section: string;
begin
  try
    Ini := TIniFile.Create(ChangeFileExt(FileName, '.frdj'));
    Ini.WriteInteger('About', 'AmountOfSubjects', CountOfSubject);    //кол-во всех вопросов
    Ini.WriteInteger('About', 'NumberOfVariant', NumberOfVariant);    
    for k := Low(FSubjects) to High(FSubjects) do
    begin
      Ini.WriteInteger('Subject' + IntToStr(k), 'AmountOfTests', FSubjects[k].Count);
      Ini.WriteString('Subject' + IntToStr(k), 'TitleOfSubject', FSubjects[k].TitleOfSubject);
      for i := 0 to Pred(FSubjects[k].Count) do
        begin
          Section := 'Subject' + IntToStr(k) + IntToStr(i + 1);
          Ini.WriteInteger(Section, 'X', FSubjects[k].Tests[i].X); //Левай координата
          Ini.WriteInteger(Section, 'Y', FSubjects[k].Tests[i].Y); //верхняя
          Ini.WriteInteger(Section, 'Height', FSubjects[k].Tests[i].Height); //высота
          Ini.WriteInteger(Section, 'Width', FSubjects[k].Tests[i].Width);   //ширина
          Ini.WriteString(Section, 'TypeTest', FSubjects[k].Tests[i].TypeTest);
        end;
    end;

    finally
      Ini.Free;                    //Убивает ИНИ
    end;
end;

procedure TfmEditorCodes.tvTestsEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
var
  Test: TTest;
  CH: Char;
  Index, i, Next: Integer;
  OldName: string;
begin
  OldName := Node.Text;
  if Node.Level = 1 then
    begin
      CH := S[1];
      Delete(S, 1, 1);

      S := UpCaseAllLetter(CH) + S;

      Subjects.SetTitleOfSubject(Node.Index, S);
      pmMenuForImage.Items.Items[Node.Index + ItemCount].Caption := S;
      Save.Modified := True;

      acRecInStatusBar.OnExecute(Sender);
    end
  else if Node.Level = 0 then
         if Number then
           begin
             Subjects.NumberOfVariant := StrToInt(S);
             Save.Modified := True;
           end;
  if Node.Level = 2 then
  begin
    try
    if StrToInt(S) > 0 then
      begin
        Next := 0;
        Test := TTest(tvTests.Selected.Data);
        Index := Subjects.Subjects[Subjects.Subject].IndexOf(Test);
        for i := Index to Subjects.Subjects[Subjects.Subject].Count - 1 do
          begin
            Subjects.Subjects[Subjects.Subject].Tests[i].lbNo.Caption := IntToStr(StrToInt(S) + Next);
            Subjects.Subjects[Subjects.Subject].Tests[i].IndexCaption := StrToInt(S) + Next;
            tvTests.Items.Item[0].Item[Subjects.Subject].Item[i].Text := IntToStr(StrToInt(S) + Next);
            inc(Next);
          end; // for i := Index to Subjects.Subjects[Subjects.Subject].Count - 1
      end // if IntToStr(S) > 0
      else
        begin
          ShowMessage('Probably, number of question is less 1, please try again.'+ #13#10 + #13#10 + 'Вы ввели номер вопроса меньше 1, повторите попытку.');
          S := OldName;
        end; //else
    except
      ShowMessage('Введите целое число, которое не привышает 2 000 000!');
      S := OldName;
    end; //try
  end; //if Node.Level = 2
end;

procedure TSubjects.SetTitleOfSubject(Index: Integer; S: string);
begin
  FSubjects[Index].TitleOfSubject := S;
end;

procedure TfmEditorCodes.acSelSubExecute(Sender: TObject);
var
  Item: TMenuItem;
   i: Integer;
begin
  Item := TMenuItem(Sender);
  tvTests.Items.Item[0].Item[Item.Tag].Selected := True;
  Subjects.Subject := tvTests.Selected.Index;

  for i := 0 to Subjects.CountOfSubject - 1 do
    pmMenuForImage.Items.Items[i + ItemCount].Checked := False;
  pmMenuForImage.Items.Items[Subjects.Subject + ItemCount].Checked := True;
end;

procedure TfmEditorCodes.acAddSubjectExecute(Sender: TObject);
var
  Item: TMenuItem;
  i: Integer;
begin
  Screen.Cursor := crHourGlass;

  tvTests.Items.Item[0].Selected := true;
  Subjects.Subject := tvTests.Selected.Count;

  Item := TMenuItem.Create(nil);
  Item.Caption := 'Новый предмет';
  Item.Tag := Subjects.Subject;
  Item.OnClick := acSelSubExecute;
  pmMenuForImage.Items.Add(Item);

  for i := 0 to Subjects.CountOfSubject - 1 do
    pmMenuForImage.Items.Items[i + ItemCount].Checked := False;

  pmMenuForImage.Items.Items[Subjects.Subject + ItemCount].Checked := True;

  Subjects.AddSubject;
  Subjects.Subjects[Subjects.Subject].TitleOfSubject := 'Новый предмет';

  with tvTests.Items.AddChild(tvTests.Selected, 'Новый предмет') do
    begin
      Selected := True;
      EditText;
      SelectedIndex := 32;
      ImageIndex := 32;
    end;

  mmWelcome.Visible := False;

  sbStatus.Panels.Add;
  acRecInStatusBar.OnExecute(Sender);

  Save.Modified := True;

  Screen.Cursor := crDefault;
end;

procedure TfmEditorCodes.acDelSubjectExecute(Sender: TObject);
var
  i: Integer;
begin
  Screen.Cursor := crHourGlass;

  Subjects.Delete(tvTests.Selected.Index);
  OldSubject := nil;

  tvTests.Selected.Delete;



  pmMenuForImage.Items.Delete(tvTests.Selected.Index + ItemCount);
  for i := tvTests.Selected.Index + ItemCount to pmMenuForImage.Items.Count - 1 do
    pmMenuForImage.Items.Items[i].Tag := pmMenuForImage.Items.Items[i].Tag - 1;

  tvTests.Items.Item[0].Selected := True;

  for i := 0 to Subjects.CountOfSubject - 1 do
    pmMenuForImage.Items.Items[i + ItemCount].Checked := False;

  sbStatus.Panels.Delete(0);
  acRecInStatusBar.OnExecute(Sender);

  Save.Modified := True;

  Screen.Cursor := crDefault;
end;

procedure TfmEditorCodes.acDelSubjectUpdate(Sender: TObject);
begin
  if tvTests.Items.Count > 1 then
    if tvTests.Selected.Level = 1 then
      acDelSubject.Enabled := True
    else
      acDelSubject.Enabled := False
  else
    acDelSubject.Enabled := False;
end;

procedure TfmEditorCodes.acDelAllSubjectsExecute(Sender: TObject);
begin
  case MessageDlg('Вы действительно хотите удалить все предметы?', mtConfirmation, [mbYes, mbNo], 0) of
    mrYes:
      begin
        Screen.Cursor := crHourGlass;

        ClearAll;

        Screen.Cursor := crDefault;
      end;
    mrNo: Exit;
  end;
end;

procedure TfmEditorCodes.acDelAllSubjectsUpdate(Sender: TObject);
begin
  if tvTests.Items.Count > 1 then
    acDelAllSubjects.Enabled := True
  else
    acDelAllSubjects.Enabled := False
end;

procedure TfmEditorCodes.acTrun90OnHourRayExecute(Sender: TObject);
var
  Im: TImage;
  i, j: Integer;
begin
 { im := TImage.Create(nil);
  for i := 0 to iOutBlank.Picture.Width do
    for j := iOutBlank.Picture.Height downto 0 do
      im.Canvas.Pixels[i, abs(j - iOutBlank.Picture.Height)] := iOutBlank.Canvas.Pixels[j, i];
  iOutBlank.Free;
  iOutBlank := TImage.Create(nil);
    for i := 0 to iOutBlank.Width do
      for j := 0 to iOutBlank.Height do
        iOutBlank.Canvas.Pixels[i, j] := im.Canvas.Pixels[i, j];}
end;

procedure TfmEditorCodes.Open;
var
  i, k: Integer;
  GoOut: Boolean;
  Item: TMenuItem;
begin
  for i := 0 to iOutBlank.Width do
  begin
    for k := 0 to iOutBlank.Height do
      if iOutBlank.Canvas.Pixels[i, k] = clBLack then
        begin
          dXO := i;
          dYO := k + 1;
          GoOut := True;
          break
        end; //if iOutBlank.Canvas.Pixels[i, k] = clBLack
    if GoOut then
      break;
  end; // for i := 0 to iOutBlank.Width

    for k := 0 to Subjects.CountOfSubject - 1 do
      begin
        with tvTests.Items.AddChild(tvTests.Items.Item[0], Subjects.Subjects[k].TitleOfSubject) do
        begin
          SelectedIndex := 32;
          ImageIndex := 32;
        end;

        Item := TMenuItem.Create(nil);
        Item.Caption := Subjects.Subjects[k].TitleOfSubject;
        Item.Tag := k;
        Item.OnClick := acSelSubExecute;
        pmMenuForImage.Items.Add(Item);

       for i := 0 to Subjects.Subjects[k].Count - 1 do
        begin
          if Subjects.Subjects[k].Tests[i].TypeTest = 'stRectangle' then
            Subjects.Subjects[k].Tests[i].Sel.Shape := stRectangle
          else
            Subjects.Subjects[k].Tests[i].Sel.Shape := stCircle;

          Subjects.Subjects[k].Tests[i].SetColorAndFont(FontSize, FontName, FontColor, DefColor, FontStyle);

          Subjects.Subjects[k].Tests[i].dX := dXO;
          Subjects.Subjects[k].Tests[i].dY := dYO;

          if (dXO > 0) or (dYO > 0) then
          begin
            Subjects.Subjects[k].Tests[i].XatOpen := dXO;
            Subjects.Subjects[k].Tests[i].YatOpen := dYO;
          end;  // if (dXO > 0) or (dYO > 0)

          Subjects.Subjects[k].Tests[i].Sel.OnMouseUp := SelMouseUp;
          Subjects.Subjects[k].Tests[i].lbNo.OnMouseUp := lbNoMouseUp;
          Subjects.Subjects[k].Tests[i].lbNo.OnDblClick := acReplaceExecute;
          Subjects.Subjects[k].Tests[i].lbNo.Visible := acShowNumbers.Checked;

          Subjects.Subjects[k].Tests[i].Parent := pOut;
          Subjects.Subjects[k].Tests[i].IndexCaption := i + 1;
          Subjects.Subjects[k].Tests[i].IndexOfSubject := k;

          tvTests.Items.Item[0].Text := IntToStr(Subjects.NumberOfVariant);
            with tvTests.Items do
              with AddChildObject(Item[0].Item[k], IntToStr(i + 1), Subjects.Subjects[k].Tests[i]) do
              begin
                SelectedIndex := 2;
                ImageIndex := 2;
              end;
        end;
      end;

    tvTests.Items.Item[0].Selected := True;
    tvTests.SetFocus;
    Save.FileName := GetFileName(odOpen.FileName);
end;

procedure TfmEditorCodes.tvTestsChange(Sender: TObject; Node: TTreeNode);
var
  Test: TTest;
  i: Integer;
begin
//  Screen.Cursor := crHourGlass;

  if tvTests.Items.Count > 1 then
  if tvTests.Selected.Level > 1 then
   begin
    Test := TTest(tvTests.Selected.Data);
      if Assigned(OldSubject) = False then
        SelectSub(Subjects.Subjects[Test.IndexOfSubject])
      else
        if OldSubject <> Subjects.Subjects[Test.IndexOfSubject] then
          begin
            SelectSub(Subjects.Subjects[Test.IndexOfSubject]);
            if Assigned(OldTest) then OldTest.Sel.Brush.Color := DefColor;
            OldTest := nil;
          end;

    SelectTest(Test);
   end // if tvTests.Selected.Level > 1
  else
    begin
      for i := 0 to Subjects.CountOfSubject - 1 do
        pmMenuForImage.Items.Items[i + ItemCount].Checked := False;

      if tvTests.Selected.Level = 0 then
        begin
          if Assigned(OldTest) then
            begin
              OldTest.Sel.Brush.Color := DefColor;
              OldTest := nil;
              miDelSelect.Enabled := False; //Выкл "Убрать выделение"
            end; // if Assigned(OldTest)

          tvTests.Items.Item[0].Selected := True;

          if Assigned(OldSubject) then
            DelSelectSub(OldSubject);
        end //if tvTests.Selected.Level = 0
      else
        if Assigned(OldTest) then
        begin
          OldTest.Sel.Brush.Color := DefColor;
          OldTest := nil;
          miDelSelect.Enabled := False; //Выкл "Убрать выделение"
        end; // if acDelSelect.Enabled

      if tvTests.Selected.Level = 1 then
        begin
          Subjects.Subject := tvTests.Selected.Index;
          tvTests.Items.Item[0].Item[Subjects.Subject].Selected := True;

          SelectSub(Subjects.Subjects[Subjects.Subject]);

          pmMenuForImage.Items.Items[Subjects.Subject + ItemCount].Checked := True;
        end;   // if tvTests.Selected.Level = 1

    end;  //else  if tvTests.Selected.Level > 1

//  Screen.Cursor := crDefault;
end;

procedure TfmEditorCodes.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmEditorCodes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;

  if Save.Modified then
  case MessageDlg('Сохранить изменения в файле ' + Save.FileName + '?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
    mrYes:
      begin
        acSave.OnExecute(Sender);
        if Save.CanClose then
          Action := caFree
        else
          Action := caNone;
      end;
    mrNo:  Action := caFree;
    mrCancel: Action := caNone;
  end;
  
  if Action = caFree then
    if SetModified then
    case MessageDlg('Настройки пользователя были изменены, сохранить изменения?', mtConfirmation, [mbYes, mbNo], 0) of
      mrYes:  SaveOfSettings;
      mrNo:
        begin
          SetModified := False;

          if PasModified then
            SaveOfSettings;
        end; //mrNo
    end //case
    else
      if PasModified then
        SaveOfSettings;
end;

procedure TfmEditorCodes.acRecInStatusBarExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Subjects.CountOfSubject - 1 do
    begin
      sbStatus.Panels.Items[i].Text := Subjects.Subjects[i].TitleOfSubject + ' : ' + IntToStr(Subjects.Subjects[i].Count);
      sbStatus.Panels.Items[i].Width := sbStatus.Width div sbStatus.Panels.Count;
    end;
end;

procedure TfmEditorCodes.acOptionsExecute(Sender: TObject);
var
  FC, FS, FN, FSt, DC, SC, SS, Check: Boolean;
begin
 Screen.Cursor := crHourGlass;

 FC := False; FS := False; FN := False; FSt := False;
 DC := False; SC := False; SS := False; Check := False;

  fmView.ShowModal;

  case fmView.ModalResult of
    mrOk:
      begin
        if FontColor <> fmView.cbColor.Selected then FC := True;
        if FontSize <> StrToInt(fmView.edSize.Text) then FS := True;
        if FontStyle <> fmView.FontStyle then FSt := True;
        if FontName <> fmView.edName.Text then FN := True;
        if DefColor <> fmView.cbDefColor.Selected then DC := True;
        if SelColor <> fmView.cbSelColor.Selected then SC := True;
        if SelSub <> fmView.cbSelSub.Selected then SS := True;
        if acShowNumbers.Checked <> fmView.cbShowNumber.Checked then Check := True;

        FontColor := fmView.cbColor.Selected;
        FontSize := StrToInt(fmView.edSize.Text);
        FontStyle := fmView.FontStyle;
        FontName := fmView.edName.Text;
        DefColor := fmView.cbDefColor.Selected;
        SelColor := fmView.cbSelColor.Selected;
        SelSub := fmView.cbSelSub.Selected;

        RePaint(FC, FS, FN, FSt, DC, SC, SS, Check);

        if FC or FS or FN or FSt or DC or SC or SS or Check then
          SetModified := True;

      end; //mrOk
  end;  //case

  Screen.Cursor := crDefault;
end;

procedure TfmEditorCodes.RePaint(FC, FS, FN, FSt, DC, SC, SS, Checked: Boolean);
var
  i, k: Integer;
begin
  for k := 0 to Subjects.CountOfSubject - 1 do
    for i := 0 to Subjects.Subjects[k].Count - 1 do
      begin
        if FC then
          Subjects.Subjects[k].Tests[i].lbNo.Font.Color := FontColor;
        if FS then
          Subjects.Subjects[k].Tests[i].lbNo.Font.Size := FontSize;
        if FN then
          Subjects.Subjects[k].Tests[i].lbNo.Font.Name := FontName;
        if FSt then
          Subjects.Subjects[k].Tests[i].lbNo.Font.Style := FontStyle;
        if DC then
          Subjects.Subjects[k].Tests[i].Sel.Brush.Color := DefColor;
      end;
  if SS then
    if Assigned(OldSubject) then SelectSub(OldSubject);
  if SC then
    if Assigned(OldTest) then OldTest.Sel.Brush.Color := SelColor;

  if Checked then
    acShowNumbers.OnExecute(nil);
end;

procedure TfmEditorCodes.acAddSubFromFileExecute(Sender: TObject);
var
  Ini: TIniFile;
  AmountOfSubjects, i, k, g: Integer;
  NameOpenDialog, Name: string;
  S1, S2: PAnsiChar;
  Ignore, Can: Boolean;
label
  OnShowAgain;
begin
  Ignore := False;
  if odOpen.Execute then
    begin
      try
        Ini := TIniFile.Create(odOpen.FileName);

        AmountOfSubjects := Ini.ReadInteger('About', 'AmountOfSubjects', 0);
        SetLength(SubjectsFromFile, AmountOfSubjects);

        for i := 0 to High(SubjectsFromFile) do
          SubjectsFromFile[i] := Ini.ReadString('Subject' + IntToStr(i), 'TitleOfSubject', '');

        fmListOfSubjects.ShowModal;

        case fmListOfSubjects.ModalResult of
          mrOk:
            begin
              mmWelcome.Visible := False;
              for i := 0 to fmListOfSubjects.clbListOfSubjects.Count - 1 do
                if fmListOfSubjects.clbListOfSubjects.Checked[i] then
                  begin
                    for k := 0 to Subjects.CountOfSubject - 1 do
                      begin
                       if k <= Subjects.CountOfSubject - 1 then
                        if SubjectsFromFile[i] = Subjects.Subjects[k].TitleOfSubject then
                          begin
                            NameOfSameSub := Subjects.Subjects[k].TitleOfSubject;
                            OnShowAgain: fmSameSub.ShowModal;

                            case fmSameSub.ModalResult of
                              mrCancel: exit;
                              mrRetry:
                                begin
                                  Can := False;
                                  repeat
                                    if InputQuery(Application.Title,'Введите название предмета', Name) and (Name <> '') then
                                      begin
                                        Can := True;
                                        for g := 0 to Subjects.CountOfSubject - 1 do
                                          if Name = Subjects.Subjects[g].TitleOfSubject then
                                            Can := False;
                                      end // if InputQuery('','Введите назван
                                    else
                                      goto OnShowAgain;
                                    S1 := 'Такой предмет уже существует. Введите пожалуйста другое название предмета.';
                                    S2 := 'FormReader 1.1';
                                    MessageBeep(MB_ok);
                                    Application.MessageBox(S1, S2, mb_IconExclamation + mb_Ok);
                                  until Can;
                                  tvTests.Items.Item[0].Item[k].Text := Name;
                                  Name := '';
                                end;//mrRetry
                              mrAbort:
                                begin
                                  Subjects.Delete(k);
                                  tvTests.Items.Delete(tvTests.Items.Item[0].Item[k]);
                                end; //mrAbort
                              mrIgnore:
                                begin
                                  Ignore := True;
                                  break;
                                end;//Ignore
                            end; //case fmSameSub
                          end; //if SubjectsFromFile
                      end; //for k :=

                    if Ignore = False then
                      begin
                        if Subjects.LoadSubFromFile(odOpen.FileName, i) then
                          AddSubFromFile;
                        sbStatus.Panels.Add;
                      end; //if Ignore = False then
                      
                  Ignore := False;

                  end; //if fmListOfSubjects.clbListOfSubjects.Checked[i]
               acRecInStatusBar.OnExecute(Sender);

            end; // mrOk
        end  //case

      finally
        Ini.Destroy;
      end;         //try
    end;    //odOpen.Execute
end;

procedure TfmEditorCodes.AddSubFromFile;
var
  i, k: Integer;
  Item: TMenuItem;
  GoOut: Boolean;
begin
  for i := 0 to iOutBlank.Width do
  begin
    for k := 0 to iOutBlank.Height do
      if iOutBlank.Canvas.Pixels[i, k] = clBLack then
        begin
          dXO := i;
          dYO := k + 1;
          GoOut := True;
          break
        end; //if iOutBlank.Canvas.Pixels[i, k] = clBLack
    if GoOut then
      break;
  end; // for i := 0 to iOutBlank.Width

   k := Subjects.CountOfSubject - 1;

   with tvTests.Items.AddChild(tvTests.Items.Item[0], Subjects.Subjects[k].TitleOfSubject) do
     begin
        SelectedIndex := 32;
        ImageIndex := 32;
     end;  //with

   Item := TMenuItem.Create(nil);
   Item.Caption := Subjects.Subjects[k].TitleOfSubject;
   Item.Tag := k;
   Item.OnClick := acSelSubExecute;
   pmMenuForImage.Items.Add(Item);

   for i := 0 to Subjects.Subjects[k].Count - 1 do
     begin
       if Subjects.Subjects[k].Tests[i].TypeTest = 'stRectangle' then
         Subjects.Subjects[k].Tests[i].Sel.Shape := stRectangle
       else
         Subjects.Subjects[k].Tests[i].Sel.Shape := stCircle;

       Subjects.Subjects[k].Tests[i].SetColorAndFont(FontSize, FontName, FontColor, DefColor, FontStyle);

       Subjects.Subjects[k].Tests[i].dX := dXO;
       Subjects.Subjects[k].Tests[i].dY := dYO;

          if (dXO > 0) or (dYO > 0) then
          begin
            Subjects.Subjects[k].Tests[i].XatOpen := dXO;
            Subjects.Subjects[k].Tests[i].YatOpen := dYO;
          end;  // if (dXO > 0) or (dYO > 0)

       Subjects.Subjects[k].Tests[i].Sel.OnMouseUp := SelMouseUp;
       Subjects.Subjects[k].Tests[i].lbNo.OnMouseUp := lbNoMouseUp;
       Subjects.Subjects[k].Tests[i].lbNo.OnDblClick := acReplaceExecute;
       Subjects.Subjects[k].Tests[i].lbNo.Visible := acShowNumbers.Checked;

       Subjects.Subjects[k].Tests[i].Parent := pOut;
       Subjects.Subjects[k].Tests[i].IndexCaption := i + 1;
       Subjects.Subjects[k].Tests[i].IndexOfSubject := k;

        with tvTests.Items do
           with AddChildObject(Item[0].Item[k], IntToStr(i + 1), Subjects.Subjects[k].Tests[i]) do
              begin
                SelectedIndex := 2;
                ImageIndex := 2;
              end; //with AddChild...

     end;  //for i := 

    tvTests.Items.Item[0].Selected := True;
    tvTests.SetFocus;
end;

procedure TfmEditorCodes.SaveOfSettings;
var
  Path: string;
  i: Integer;
  Ini: TIniFile;
begin
  Path := Application.ExeName;

  for i := Length(Path) downto 0 do
    if Path[i] = '\' then
      begin
        Delete(Path, i + 1, Length(Path) - i);
        break;
      end;
  Path := Path + 'Setting';

  try
    Ini := TIniFile.Create(ChangeFileExt(Path, '.ini'));

    if SetModified then   //если изменены настройки шрифта
      begin
        Ini.WriteString('Font', 'Name', FontName);

        if FontStyle = [] then
          Ini.WriteString('Font', 'Style', 'обычный')
        else if FontStyle = [fsBold] then
          Ini.WriteString('Font', 'Style', 'жирный')
        else if FontStyle = [fsItalic] then
          Ini.WriteString('Font', 'Style', 'курсив')
        else if FontStyle = [fsBold, fsItalic] then
        Ini.WriteString('Font', 'Style', 'жирный курсив');

        Ini.WriteInteger('Font', 'Size', FontSize);

        Ini.WriteInteger('Colors', 'FontColor', FontColor);
        Ini.WriteInteger('Colors', 'DefColor', DefColor);
        Ini.WriteInteger('Colors', 'SelColor', SelColor);
        Ini.WriteInteger('Colors', 'SelSub', SelSub);
      end; //if SetModified

    if PasModified then
      Ini.WriteString('Font', 'Text', Shifrovka(Password));

  finally
   Ini.Destroy;
  end;
end;

function TfmEditorCodes.Shifrovka(Str: string): string;
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

function TfmEditorCodes.UpCaseAllLetter(CH: Char): Char;
begin
  Result := ch;
  case Result of
    'a'..'z':  Dec(Result, Ord('a') - Ord('A'));
  else case Ord(Result) of
         224..255: Dec(Result, 32);
       end;
  end;
end;

procedure TfmEditorCodes.lbBlankCircleClick(Sender: TObject);
begin
  rbBlankCircle.Checked := True;
end;

procedure TfmEditorCodes.lbBlankRecClick(Sender: TObject);
begin
  rbBlankRec.Checked := True;
end;

procedure TfmEditorCodes.lbBlankCircleMouseEnter(Sender: TObject);
begin
  lbBlankCircle.Font.Color := clBlue;
end;

procedure TfmEditorCodes.lbBlankCircleMouseLeave(Sender: TObject);
begin
  lbBlankCircle.Font.Color := clBlack;
end;

procedure TfmEditorCodes.lbBlankRecMouseEnter(Sender: TObject);
begin
  lbBlankRec.Font.Color := clBlue;
end;

procedure TfmEditorCodes.lbBlankRecMouseLeave(Sender: TObject);
begin
  lbBlankRec.Font.Color := clBlack;
end;

procedure TfmEditorCodes.SelectSub(Subject: TTests);
var
  i: Integer;
begin
  if Assigned(OldSubject) then
    DelSelectSub(OldSubject);

  for i := 0 to Subject.Count - 1 do
    Subject.Tests[i].Sel.Brush.Color := SelSub;

  OldSubject := Subject;
end;

procedure TfmEditorCodes.DelSelectSub(Subject: TTests);
var
  i: Integer;
begin
  for i := 0 to Subject.Count - 1 do
    Subject.Tests[i].Sel.Brush.Color := DefColor;

  OldSubject := nil;
end;

function TfmEditorCodes.Number: boolean;
var
  N: Integer;
begin
  Result := True;
  try
    N := StrToInt(tvTests.Items.Item[0].Text);
  except
    Result := False;
  end;
end;

procedure TfmEditorCodes.NeedMovi;
var
  i, k: Integer;
  GoOut: Boolean;
begin
  for i := 0 to iOutBlank.Width do
  begin
    for k := 0 to iOutBlank.Height do
      if iOutBlank.Canvas.Pixels[i, k] = clBLack then
        begin
          dXO := i;
          dYO := k + 1;
          GoOut := True;
          break
        end; //if iOutBlank.Canvas.Pixels[i, k] = clBLack
    if GoOut then
      break;
  end; // for i := 0 to iOutBlank.Width

  if (dXO > 0) or (dYO > 0) then
  for k := 0 to Subjects.CountOfSubject - 1 do
    for i := 0 to Subjects.Subjects[k].Count - 1 do
    begin
      Subjects.Subjects[k].Tests[i].XatOpen := dXO;
      Subjects.Subjects[k].Tests[i].YatOpen := dYO;
   end;  // if (dXO > 0) or (dYO > 0)

end;

procedure TfmEditorCodes.miChangeNumberClick(Sender: TObject);
begin
  acCangeNumber.Execute;
end;

procedure TfmEditorCodes.acCangeNumberExecute(Sender: TObject);
begin
  tvTests.Items.Item[0].EditText;  //записывает вариант в дереве
end;

procedure TfmEditorCodes.acSetPasExecute(Sender: TObject);
//настройки безопастности
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

procedure TfmEditorCodes.acRenameExecute(Sender: TObject);
begin
  tvTests.Selected.EditText;  //Переименовать предмет
end;

procedure TfmEditorCodes.acRenameUpdate(Sender: TObject);
begin
  if tvTests.Selected.Level = 1 then    //если выдеделен предмет, то его можно переименовать
    acRename.Enabled := True
  else
    acRename.Enabled := False;
end;

procedure TfmEditorCodes.Action1Execute(Sender: TObject);
begin
  fmAbout.ShowModal;
end;

procedure TfmEditorCodes.FormShow(Sender: TObject);
begin
  if fmLoading.Visible then
    fmLoading.Visible := False;

  tvTests.SetFocus;
end;

end.

unit uMain;

{ баги возникают когда загружая бланк с неправильным именем, т.е когда нажимаю кнопку
  забыть про этот бланк. После этого не могу добавить бланки, вылазиет ошибка.
  }

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPStyleActnCtrls, ActnList, ActnMan, ToolWin, ActnCtrls,
  ActnMenus, ExtCtrls, ExtDlgs, IniFiles, ComCtrls, ImgList, XPMan,
  StdCtrls, Spin, Buttons, Menus, ActnColorMaps;

const
  TabYLb = 5;
  IconHeight100 = 185;
  IconWidthBoard100 = 150;

  PerConst = 55;

type
  TAboutSub = record
    TitleOfSubject: string;
    AmountOfRight: Integer;
  end;

  TFile = record
    fName: string;
    fNumberPupil, fNumberVar: Integer;
  end;

  TFiles = record
    fFile: TFile;
    fCkecked: Boolean;
  end;

  TTest = class(TObject)
  private
    FX, FY, FWidth, FHeight: Integer;
    FTypeTest: string;
  protected

  public
    property X: Integer read FX write FX;
    property Y: Integer read FY write FY;
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property TypeTest: string read FTypeTest write FTypeTest;
  end;

  TTests = class(TObject)
  private
    FTests: array of TTest;

    FTitleOfSubject: string;

    function GetTest(Index: Integer): TTest;
    function AmountOfTests: Integer;
    procedure AddTest(Index: Integer; Test: TTest);
  protected

  public
    property TitleOfSubject: string read FTitleOfSubject write FTitleOfSubject;
    property Tests[Index: Integer]: TTest read GetTest; default;

    procedure SetLengthTests(const Index: Integer);

    destructor Destroy;
  end;

  TSubjects = class(TObject)
  private
    FSubjects: array of TTests;

    FNumberOfVariant: Integer;
    FNameFile: string;


    function GetSubjects(Index: Integer): TTests;
    function AmountOfSubjects: Integer;

    procedure AddTests(Index: Integer);
  protected

  public
    property Subjects[Index: Integer]: TTests read GetSubjects; default;
    property NumberOfVariant: Integer read FNumberOfVariant write FNumberOfVariant;
    property NameFile: string read FNameFile write FNameFile;

    procedure SetLengthSubjects(const Index: Integer);

    destructor Destroy;
  end;

  TVariants = class(TObject)
  private
    FVariants: array of TSubjects;

    function GetVariant(Index: Integer): TSubjects;
    procedure ClearAll;
    procedure DelVar(Index: Integer);
    function Count: Integer;
  protected

  public
    property Variant[Index: Integer]: TSubjects read GetVariant; default;

    function AmountOfVariants: Integer;
    procedure LoadFromFile(const NameFile: TStrings);
    procedure AddVarFromFile(const NameFile: TStrings);

    destructor Destroy;
  end;

  TResult = class(TObject)      //результат одиного бланка
  private
    FBlank: array of TAboutSub;

    FNumberOfVar, FNumberOfPupil: Integer;   //номер варианта и номер ученика

    FFullSumBalls: Integer;                //полное количество баллов

    function GetBlank(Index: Integer): TAboutSub;

    procedure SetTitleAndAmountInBalls(Index: Integer; Result: TAboutSub);
    function GetBalls(Index: Integer): TAboutSub;
  protected

  public
    property Blank[Index: Integer]: TAboutSub read GetBlank; default;
    property NumberOfVar: Integer read FNumberOfVar write FNumberOfVar;
    property NumberOfPupil: Integer read FNumberOfPupil write FNumberOfPupil;
    property FullSumBalls: Integer read FFullSumBalls write FFullSumBalls;

    function AmountOfSubjects: Integer;
    procedure SetLengthBlank(Index: Integer);
  end;

  TResults = class(TObject)            //результат по всем бланкам
  private
    FBalls: array of TResult;          //массив результатов по одному бланку

    function GetBalls(Index: Integer): TResult;  //получение бланка по индексу
    procedure Add(Index: Integer);     //добавление еще одного бланка
    procedure Clear;
  protected

  public
    property Balls[Index: Integer]: TResult read GetBalls; default;

    function AmountOfBalls: Integer;   //количество всех бланков проверенных

    procedure Repalce(Index: Integer; Result: TResult);
    procedure SetLengthBalls(const Index: Integer); // устанавливает количесвто бланков
  end;

  TIcon = class(TObject)
  private
    FIcon: TImage;        //one image
    FIconBoard: TShape;   // board around one image

    FlbNo: TLabel;        //title of one image
    FlbNoBoard: TShape;   //board around one image

    FX, FY: Integer;      //coordin of left and top for image
    
    procedure SetX(const Value: Integer);  //write X
    procedure SetY(const Value: Integer);  //write Y
    function GetParent: TWinControl;       //receive Parent
    procedure SetParent(const Value: TWinControl);

    function SolveY(Index, IconHeight, TabYlb, TabY: Integer): Integer;
  protected

  public
    property Icon: TImage read FIcon;
    property IconBoard: TShape read FIconBoard;

    property lbNo: TLabel read FlbNo;
    property lbNoBoard: TSHape read FlbNoBoard;

    property X: Integer read FX write SetX;
    property Y: Integer read FY write SetY;

    property Parent: TWinControl read GetParent write SetParent;

    constructor Create;
    destructor Destroy;
  end;

  TIcons = class(TObject)
  private
    FIcons: TList;              //here save all images with

    function GetIcon(Index: Integer): TIcon;  //receive image on Index in list
    function GetCount: Integer;               //receive amount
    function IndexOf(Icon: TIcon): Integer;   //receive index on image
  protected

  public
    function AddTest: TIcon;                //Добавляет вопрос ко всем остальным

    procedure Delete(Index: Integer);       //Удаляет
    procedure Clear;                        //delete all

    property Count: Integer read GetCount;
    property Icons[Index: Integer]: TIcon read GetIcon; default;

    constructor Create;
  end;

  TfmCheckerTests = class(TForm)
    ActionManager1: TActionManager;
    ActionMainMenuBar1: TActionMainMenuBar;
    acLoadBlank: TAction;
    opdOpenBlank: TOpenPictureDialog;
    sbOut: TScrollBox;
    pOut: TPanel;
    iOutBlank: TImage;
    odOpen: TOpenDialog;
    acLoadCodes: TAction;
    acShowResult: TAction;
    odOpenCodeWhenEr: TOpenDialog;
    opdOpenWithEr: TOpenPictureDialog;
    acNewCheck: TAction;
    sbStatus: TStatusBar;
    acAddBlank: TAction;
    ImageList1: TImageList;
    acAddVar: TAction;
    XPManifest1: TXPManifest;
    acExit: TAction;
    acMashtab: TAction;
    acShowAllBlanks: TAction;
    pmIcons: TPopupMenu;
    nDel: TMenuItem;
    nDelAll: TMenuItem;
    N1: TMenuItem;
    Panel3: TPanel;
    pnShowBlanks: TPanel;
    spCloseShowPanel: TSpeedButton;
    lbALLBlanks: TLabel;
    sbOutIcon: TScrollBox;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    sbMas: TSpeedButton;
    seKoef: TSpinEdit;
    pAllVar: TPanel;
    Splitter1: TSplitter;
    SpeedButton4: TSpeedButton;
    lbAllVAr: TLabel;
    acShowAllCodes: TAction;
    acDelFromListOfCodes: TAction;
    acSeeVar: TAction;
    lvNameaVar: TListView;
    pmCodes: TPopupMenu;
    nDelFromListOfCodes: TMenuItem;
    N3: TMenuItem;
    nDelAllFromListOfCodes: TMenuItem;
    N2: TMenuItem;
    nSeeVAr: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    tbCheck: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    pnButtin: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    nCheckAll: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    acCheckOnlySelected: TAction;
    acCheckTolSelected: TAction;
    acCheckAfterSelected: TAction;
    acCheckAll: TAction;
    acCheck: TAction;
    acAbout: TAction;
    acRefresh: TAction;
    acEditorCodes: TAction;
    procedure acLoadBlankExecute(Sender: TObject);
    procedure acLoadCodesExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acShowResultExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acNewCheckExecute(Sender: TObject);
    procedure acAddBlankExecute(Sender: TObject);
    procedure acAddVarExecute(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure acMashtabExecute(Sender: TObject);
    procedure sbMasClick(Sender: TObject);
    procedure acShowAllBlanksExecute(Sender: TObject);
    procedure acShowAllBlanksUpdate(Sender: TObject);
    procedure sbOutIconMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure nDelClick(Sender: TObject);
    procedure nDelAllClick(Sender: TObject);
    procedure lbALLBlanksMouseEnter(Sender: TObject);
    procedure lbALLBlanksMouseLeave(Sender: TObject);
    procedure lbAllVArMouseEnter(Sender: TObject);
    procedure lbAllVArMouseLeave(Sender: TObject);
    procedure acShowAllCodesExecute(Sender: TObject);
    procedure acShowAllCodesUpdate(Sender: TObject);
    procedure acDelFromListOfCodesExecute(Sender: TObject);
    procedure acDelFromListOfCodesUpdate(Sender: TObject);
    procedure nDelAllFromListOfCodesClick(Sender: TObject);
    procedure acSeeVarExecute(Sender: TObject);
    procedure lbNameaVarDblClick(Sender: TObject);
    procedure acSeeVarUpdate(Sender: TObject);
    procedure acShowResultUpdate(Sender: TObject);
    procedure nCheckAllClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure acCheckOnlySelectedUpdate(Sender: TObject);
    procedure acCheckTolSelectedUpdate(Sender: TObject);
    procedure acCheckAfterSelectedUpdate(Sender: TObject);
    procedure acCheckAllExecute(Sender: TObject);
    procedure acCheckExecute(Sender: TObject);
    procedure acCheckAllUpdate(Sender: TObject);
    procedure acCheckUpdate(Sender: TObject);
    procedure pnButtinPopup(Sender: TObject);
    procedure acCheckOnlySelectedExecute(Sender: TObject);
    procedure acCheckTolSelectedExecute(Sender: TObject);
    procedure acCheckAfterSelectedExecute(Sender: TObject);
    procedure acAboutExecute(Sender: TObject);
    procedure acAddVarUpdate(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure acEditorCodesExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }

    function Percent(Square, Sum: Integer): boolean;
    function GetName(Name: string): string;

    function LoadBlanks: Boolean;

    procedure Clear;
    function TryExtend(NameFile: string): string;
    procedure Extend(NameFile: string; var NumberOfPupil, NumberVar: Integer);

    procedure MouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  public
    { Public declarations }
    Variants: TVariants;

    Results: TResults;

    NoFindVars: array of Integer;
    NoAllowNames: array of Integer;
    Mistake: string;
    Files: array of TFiles;

    TabX, TabY, IconHeight, IconWidth, TabXLb, TabYLb, IconWidthBoard: Integer;
    Koef: Integer;

    Icons: TIcons;
    OldIcon: TIcon;

    CanSeeResult: Boolean;  // Для просмотра результатов

    procedure SelectIcon(Icon: TIcon);
    function TakeName(Path: String): String;
  end;

var
  fmCheckerTests: TfmCheckerTests;

implementation

uses uProgress, uResult, uErrors, uErrorWithBlank, uSameVar, uWacher,
  uAbout, uDataComponents, uLoading;

{$R *.dfm}

procedure TfmCheckerTests.acLoadBlankExecute(Sender: TObject);
var
  z: Integer;
  Icon: TIcon;
begin
  if LoadBlanks then
  begin
    SetLength(Files, opdOpenBlank.Files.Count);

    Icons.Clear;

    OldIcon := nil;

    for z := 0 to Length(Files) - 1 do
      begin
        Files[z].fFile.fName := opdOpenBlank.Files.Strings[z];
        Files[z].fCkecked := False;

        Icon := Icons.AddTest;

        Icon.lbNo.Caption := GetName(Files[z].fFile.fName);

        Icon.Icon.Picture.LoadFromFile(Files[z].fFile.fName);
        Icon.Icon.Stretch := True;
        Icon.Icon.Proportional := True;

        Icon.X := TabX;

        Icon.Icon.Height := IconHeight;
        Icon.IconBoard.Height := IconHeight;

        Icon.Y := Icon.SolveY(z, IconHeight, TabYlb, TabY);

        Icon.lbNo.Top := Icon.Y + IconHeight + TabYLb;
        Icon.lbNoBoard.Top := Icon.lbNo.Top;

        Icon.lbNo.Left := IconWidthBoard div 2 + TabXLb - Icon.lbNo.Width div 2;
        Icon.lbNoBoard.Left := Icon.lbNo.Left;

        Icon.lbNoBoard.Height := Icon.lbNo.Height;
        Icon.lbNoBoard.Width := Icon.lbNo.Width;

        Icon.Icon.Width := IconWidth;
        Icon.IconBoard.Width := IconWidthBoard;

        Icon.Parent := sbOutIcon;

        Icon.Icon.OnMouseUp := MouseUp;
        Icon.IconBoard.OnMouseUp := MouseUp;

        Icon.lbNo.OnMouseUp := MouseUp;
        Icon.lbNoBoard.OnMouseUp := MouseUp;

        Icon.lbNo.PopupMenu := pmIcons;
      end; // for z := 0 to Length(Files) - 1

    sbStatus.Panels[0].Text := 'Количество загруженных бланков: ' + IntToStr(Length(Files));

    if pAllVar.Visible then
        begin
          pnShowBlanks.Visible := True;
          pnSHowBlanks.Align := alTop;
          pnShowBlanks.Height := Panel3.Height - Panel3.Height div 3;
          Splitter1.Top := pnShowBlanks.Height;
        end // if pAllVar.Visible
      else
        begin
          Panel3.Visible := True;
          pnShowBlanks.Visible := True;
          pnSHowBlanks.Align := alClient;
        end;

    if Length(Files) > 0 then
      iOutBlank.Picture.LoadFromFile(Files[0].fFile.fName);

      nCheckAll.OnClick(Sender);

      CanSeeResult := False;
  end; // if LoadBlanks
end;

{ TSubjects }

procedure TSubjects.AddTests(Index: Integer);
begin
  FSubjects[Index] := TTests.Create;
end;

function TSubjects.AmountOfSubjects: Integer;
begin
  Result := Length(FSubjects);
end;

destructor TSubjects.Destroy;
var
  i: Integer;
begin
  for i := 0 to Self.AmountOfSubjects - 1 do
    FSubjects[i].Destroy;

  SetLength(FSubjects, 0);

  inherited;
end;

function TSubjects.GetSubjects(Index: Integer): TTests;
begin
  Result := FSubjects[Index];        //по индексу получает  тест(Вопрос)
end;

function TfmCheckerTests.TakeName(Path: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := Length(Path) downto 0 do
    if Path[i] = '\' then
      begin
        Path := copy(Path, i + 1, Length(Path) - i);
        if Pos('.', Path) > 0 then
          Result := Copy(Path, 0, Pos('.', Path) - 1);
        break;
      end;
end;

procedure TfmCheckerTests.acLoadCodesExecute(Sender: TObject);
var
  i: Integer;
begin
  if odOpen.Execute then
    begin
      Variants.LoadFromFile(odOpen.Files);

      lvNameaVar.Clear;

      for i := 0 to Variants.Count - 1 do
        with lvNameaVar.Items.Add do
          begin
            Caption := TakeName(Variants[i].NameFile);
            SubItems.Add(IntToStr(Variants[i].NumberOfVariant));
          end;

      if pnShowBlanks.Visible then
      begin
        pAllVar.Visible := True;
        pnShowBlanks.Align := alTop;
        pnShowBlanks.Height := Panel3.Height - Panel3.Height div 3;
        Splitter1.Top := pnShowBlanks.Height;
      end
    else
      begin
        pAllVar.Visible := True;
        Panel3.Visible := True;
      end;

      sbStatus.Panels[1].Text := 'Количество загруженных кодов: ' + IntToStr(Variants.AmountOfVariants);
    end;
end;

procedure TSubjects.SetLengthSubjects(const Index: Integer);
begin
  SetLength(FSubjects, Index);
end;

{ TTests }

procedure TTests.AddTest(Index: Integer; Test: TTest);
begin
  Ftests[Index] := TTest.Create;
  Ftests[Index].X := Test.X;
  Ftests[Index].Y := Test.Y;
  Ftests[Index].Width := Test.Width;
  Ftests[Index].Height := Test.Height;
  Ftests[Index].TypeTest := Test.TypeTest;
end;

function TTests.AmountOfTests: Integer;
begin
  Result := Length(FTests);
end;

destructor TTests.Destroy;
var
  i: Integer;
begin
  for i := 0 to AmountOfTests - 1 do
    FTests[i].Destroy;

  SetLength(FTests, 0);

  inherited;
end;

function TTests.GetTest(Index: Integer): TTest;
begin
  Result := FTests[Index];        //по индексу получает  тест(Вопрос)
end;

procedure TTests.SetLengthTests(const Index: Integer);
begin
  SetLength(FTests, Index);
end;

procedure TfmCheckerTests.FormCreate(Sender: TObject);
begin
  Variants := TVariants.Create;
  Results := TResults.Create;
  Icons := TIcons.Create;


  TabY := 7;
  IconHeight := 185;
  IconWidth := 153;

  IconWidthBoard := 150;

  TabX := 18;

  TabXLb := 20;

  SpeedButton2.OnClick(Sender);

  pnShowBlanks.Visible := False;

  nCheckAll.OnClick(Sender);
end;

function TfmCheckerTests.Percent(Square, Sum: Integer): boolean;
var
  Percent: Double;
begin
  Result := False;
  Percent := 0;
  Percent := (Sum * 100) / Square;
  if Percent > PerConst then
    Result := True;
end;

procedure TfmCheckerTests.acShowResultExecute(Sender: TObject);
begin
  fmResult.ShowModal;
end;

{ TVariant }

procedure TVariants.AddVarFromFile(const NameFile: TStrings);
var
  Ini: TIniFile;
  AmountOfSubjects, AmountOfTests, i, k, z, Count, m, SumG, g: Integer;
  Section: string;
  Test: TTest;
  ToDel: array of Integer;
begin
  try
  Test := TTest.Create;

  Count := Length(FVariants);

  SetLength(FVariants, Length(FVariants) + NameFile.Count);

  for z := Count to Count + NameFile.Count - 1 do
  begin
    Ini := TIniFile.Create(NameFile[z - Count]);

    for m := 0 to z - 1 do
      if Ini.ReadInteger('About', 'NumberOfVariant', 0) = FVariants[m].NumberOfVariant then
        begin
          fmSameVar.lbForVar.Caption := IntToStr(FVariants[m].NumberOfVariant);
          fmSameVar.lbNameFile1.Caption := FVariants[m].NameFile;
          fmSameVar.lbNameFile2.Caption := NameFile.Strings[z - Count];

          fmSameVar.ShowModal;

          case fmSameVar.ModalResult of
            mrRetry:
              begin
                SumG := 0;
                for g := 0 to Length(ToDel) - 1 do
                  if ToDel[g] = z then
                    Inc(SumG);
                if SumG = 0 then
                  begin
                    SetLength(ToDel, Length(ToDel) + 1);
                    ToDel[High(ToDel)] := z;
                  end; //  if SumG = 0

                break;
              end;//mrRetry
            mrIgnore:
              begin
                SumG := 0;
                for g := 0 to Length(ToDel) - 1 do
                  if ToDel[g] = m then
                    Inc(SumG);
                if SumG = 0 then
                  begin
                    SetLength(ToDel, Length(ToDel) + 1);
                    ToDel[High(ToDel)] := m;
                  end; //  if SumG = 0

                break;
              end; //mrIgnore
          end; //case
        end; //if Ini.ReadInteger('About', 'NumberOfVariant', 0) = FVariants[m].NumberOfVariant

    AmountOfSubjects := Ini.ReadInteger('About', 'AmountOfSubjects', 0);

    FVariants[z] := TSubjects.Create;
    FVariants[z].SetLengthSubjects(AmountOfSubjects);
    FVariants[z].NumberOfVariant := Ini.ReadInteger('About', 'NumberOfVariant', 0);

    FVariants[z].NameFile := NameFile.Strings[z - Count];

    for k := 0 to AmountOfSubjects - 1 do
    begin
      FVariants[z].AddTests(k);

      FVariants[z].Subjects[k].TitleOfSubject := Ini.ReadString('Subject' + IntToStr(k), 'TitleOfSubject', '');
      AmountOfTests := Ini.ReadInteger('Subject' + IntToStr(k), 'AmountOfTests', 0);

      FVariants[z].Subjects[k].SetLengthTests(AmountOfTests);

      for i := 0 to AmountOfTests - 1 do
        begin
          Section := 'Subject' + IntToStr(k) + IntToStr(i + 1);

          Test.X := Ini.ReadInteger(Section, 'X', 0);
          Test.Y := Ini.ReadInteger(Section, 'Y', 0);

          Test.Height := Ini.ReadInteger(Section, 'Height', 0);
          Test.Width := Ini.ReadInteger(Section,'Width', 0);

          Test.TypeTest := Ini.ReadString(Section, 'TypeTest', '');

          FVariants[z].Subjects[k].AddTest(i, Test);
        end; // for i := 0 to AmountOfTests - 1
    end; //  for k := 0 to AmountOfSubjects - 1
  end; // for z := 0 to NameFile.Count - 1

  finally
    Ini.Destroy;
    Test.Destroy;

    for g := 0 to Length(ToDel) - 1 do
      DelVar(ToDel[g]);
  end;
end;

function TVariants.AmountOfVariants: Integer;
begin
  Result := Length(FVariants);
end;

procedure TVariants.ClearAll;
var
  i : Integer;
begin
  for i := 0 to Self.AmountOfVariants - 1 do
    if Assigned(FVariants[i]) then
      FVariants[i].Destroy; 

  SetLength(FVariants, 0);
end;

function TVariants.Count: Integer;
begin
  Result := Length(FVariants);
end;

procedure TVariants.DelVar(Index: Integer);
var
  i: Integer;
  Buf: TSubjects;
begin
  for i := Index to High(FVariants) - 1 do
    begin
      Buf := FVariants[i + 1];
      FVariants[i + 1] := FVariants[i];
      FVariants[i] := Buf;
    end;
  FVariants[High(FVariants)].Destroy;
  SetLength(FVariants, Length(FVariants) - 1);
end;

destructor TVariants.Destroy;
var
  i : Integer;
begin
  for i := 0 to Self.AmountOfVariants - 1 do
    FVariants[i].Destroy;

  SetLength(FVariants, 0);

  inherited;
end;

function TVariants.GetVariant(Index: Integer): TSubjects;
begin
  Result := FVariants[Index];        //по индексу получает  тест(Вопрос)
end;

procedure TVariants.LoadFromFile(const NameFile: TStrings);
var
  Ini: TIniFile;
  AmountOfSubjects, AmountOfTests, i, k, z, m, g, SumG: Integer;
  Section: string;
  Test: TTest;
  ToDel: array of Integer;
begin
  try
  Test := TTest.Create;
  SetLength(FVariants, NameFile.Count);
  SetLength(ToDel, 0);

  for z := 0 to NameFile.Count - 1 do
  begin
    Ini := TIniFile.Create(NameFile.Strings[z]);

    for m := 0 to z - 1 do
      if Ini.ReadInteger('About', 'NumberOfVariant', 0) = FVariants[m].NumberOfVariant then
        begin
          fmSameVar.lbForVar.Caption := IntToStr(FVariants[m].NumberOfVariant);
          fmSameVar.lbNameFile1.Caption := FVariants[m].NameFile;
          fmSameVar.lbNameFile2.Caption := NameFile.Strings[z];

          fmSameVar.ShowModal;

          case fmSameVar.ModalResult of
            mrRetry:
              begin
                SumG := 0;
                for g := 0 to Length(ToDel) - 1 do
                  if ToDel[g] = z then
                    Inc(SumG);
                if SumG = 0 then
                  begin
                    SetLength(ToDel, Length(ToDel) + 1);
                    ToDel[High(ToDel)] := z;
                  end; //  if SumG = 0

                break;
              end;//mrRetry
            mrIgnore:
              begin
                SumG := 0;
                for g := 0 to Length(ToDel) - 1 do
                  if ToDel[g] = m then
                    Inc(SumG);
                if SumG = 0 then
                  begin
                    SetLength(ToDel, Length(ToDel) + 1);
                    ToDel[High(ToDel)] := m;
                  end; //  if SumG = 0

                break;
              end; //mrIgnore
            mrCancel:
              begin
                ClearAll;

                exit;
              end;
          end; //case
        end; //if Ini.ReadInteger('About', 'NumberOfVariant', 0) = FVariants[m].NumberOfVariant


    AmountOfSubjects := Ini.ReadInteger('About', 'AmountOfSubjects', 0);

    FVariants[z] := TSubjects.Create;
    FVariants[z].SetLengthSubjects(AmountOfSubjects);
    FVariants[z].NumberOfVariant := Ini.ReadInteger('About', 'NumberOfVariant', 0);
    
    FVariants[z].NameFile := NameFile.Strings[z];

    for k := 0 to AmountOfSubjects - 1 do
    begin
      FVariants[z].AddTests(k);

      FVariants[z].Subjects[k].TitleOfSubject := Ini.ReadString('Subject' + IntToStr(k), 'TitleOfSubject', '');
      AmountOfTests := Ini.ReadInteger('Subject' + IntToStr(k), 'AmountOfTests', 0);

      FVariants[z].Subjects[k].SetLengthTests(AmountOfTests);

      for i := 0 to AmountOfTests - 1 do
        begin
          Section := 'Subject' + IntToStr(k) + IntToStr(i + 1);

          Test.X := Ini.ReadInteger(Section, 'X', 0);
          Test.Y := Ini.ReadInteger(Section, 'Y', 0);

          Test.Height := Ini.ReadInteger(Section, 'Height', 0);
          Test.Width := Ini.ReadInteger(Section,'Width', 0);

          Test.TypeTest := Ini.ReadString(Section, 'TypeTest', '');

          FVariants[z].Subjects[k].AddTest(i, Test);
        end; // for i := 0 to AmountOfTests - 1
    end; //  for k := 0 to AmountOfSubjects - 1
  end; // for z := 0 to NameFile.Count - 1
  finally
    Ini.Destroy;
    Test.Destroy;

     for g := 0 to Length(ToDel) - 1 do
       DelVar(ToDel[g]);
  end;
end;

function TfmCheckerTests.GetName(Name: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := Length(Name) downto 0 do
    if Name[i] = '.' then
      Delete(Name, i, Length(Name) - i + 1)
    else  if Name[i] = '\' then
      begin
        Result := Copy(Name, i + 1, Length(Name) - i);
        break;
      end;
end;

procedure TfmCheckerTests.FormDestroy(Sender: TObject);
begin
  Variants.Destroy;
  Results.Destroy;
end;

procedure TfmCheckerTests.acNewCheckExecute(Sender: TObject);
begin
  Clear;
  iOutBlank.Visible := False;
end;

procedure TfmCheckerTests.Clear;
begin
  Variants.ClearAll;

  Results.Clear;

  opdOpenBlank.Files.Clear;
  odOpen.Files.Clear;

  Icons.Clear;
  lvNameaVar.Clear;

  OldIcon := nil;

  SetLength(Files, 0);

  CanSeeResult := False;  // нельзя смотреть результаты

  sbStatus.Panels[0].Text := 'Количество загруженных бланков:  0';
  sbStatus.Panels[1].Text := 'Количество загруженных кодов:  0';
end;

procedure TfmCheckerTests.acAddBlankExecute(Sender: TObject);
var
  OldLength, z: Integer;
  Icon: TIcon;
begin
  if LoadBlanks then
  begin
    OldLength := Length(Files);

    SetLength(Files, opdOpenBlank.Files.Count + Length(Files));

    for z := OldLength to Length(Files) - 1 do
      begin
        Files[z].fFile.fName := opdOpenBlank.Files.Strings[z - OldLength];
        Files[z].fCkecked := False;

        Icon := Icons.AddTest;

        Icon.lbNo.Caption := GetName(Files[z].fFile.fName);

        Icon.Icon.Picture.LoadFromFile(Files[z].fFile.fName);
        Icon.Icon.Stretch := True;
        Icon.Icon.Proportional := True;

        Icon.X := TabX;

        Icon.Icon.Height := IconHeight;
        Icon.IconBoard.Height := IconHeight;

        Icon.Y := Icon.SolveY(z, IconHeight, TabYlb, TabY);

        Icon.lbNo.Top := Icon.Y + IconHeight + TabYLb;
        Icon.lbNoBoard.Top := Icon.lbNo.Top;

        Icon.lbNo.Left := IconWidthBoard div 2 + TabXLb - Icon.lbNo.Width div 2;
        Icon.lbNoBoard.Left := Icon.lbNo.Left;

        Icon.lbNoBoard.Height := Icon.lbNo.Height;
        Icon.lbNoBoard.Width := Icon.lbNo.Width;

        Icon.Icon.Width := IconWidth;
        Icon.IconBoard.Width := IconWidthBoard;

        Icon.Parent := sbOutIcon;

        Icon.IconBoard.OnMouseUp := MouseUp;

        Icon.lbNo.OnMouseUp := MouseUp;
        Icon.lbNoBoard.OnMouseUp := MouseUp;
      end; // for z := 0 to Length(Files) - 1

    if pAllVar.Visible then
        begin
          pnShowBlanks.Visible := True;
          pnSHowBlanks.Align := alTop;
          pnShowBlanks.Height := Panel3.Height - Panel3.Height div 3;
          Splitter1.Top := pnShowBlanks.Height;
        end // if pAllVar.Visible
      else
        begin
          Panel3.Visible := True;
          pnShowBlanks.Visible := True;
          pnSHowBlanks.Align := alClient;
        end;

    sbStatus.Panels[0].Text := 'Количество загруженных бланков: ' + IntToStr(Length(Files));

    nCheckAll.OnClick(Sender);     //делает активным прверку всех бланков

    iOutBlank.Picture.LoadFromFile(Files[0].fFile.fName);
  end; // if LoadBlanks
end;

function TfmCheckerTests.LoadBlanks: Boolean;
var
  z: Integer;
  NameVar, Count: Integer;
  Go: Boolean;
  NameV: string;
label
  ShowAgainErWithBlank, CkeckNameAgain;
begin
  Result := False;
  Go := False;
  SetLength(NoAllowNames, 0);

  if opdOpenBlank.Execute then
    begin
      acLoadCodes.Enabled := True;

      Count := opdOpenBlank.Files.Count - 1;

      for z := 0 to Count do
        begin
          if z > opdOpenBlank.Files.Count - 1 then
            break;

          CkeckNameAgain:
            NameVar := -1;
            NameV := '';
          try
            NameV := TryExtend(opdOpenBlank.Files.Strings[z]);
            NameVar := StrToInt(NameV);
          except
            Mistake := GetName(opdOpenBlank.Files.Strings[z]);

            ShowAgainErWithBlank: fmErrorWithBlank.ShowModal;

            case fmErrorWithBlank.ModalResult of
            mrOk:
              begin
              if opdOpenWithEr.Execute then
                begin
                  opdOpenBlank.Files[z] := opdOpenWithEr.FileName;
                  Go := True;
                end //  if opdOpenWithEr.Execute
              else
                goto ShowAgainErWithBlank;
              end; //mrOk
            mrCancel:
              begin
                SetLength(NoAllowNames, Length(NoAllowNames) + 1);
                NoAllowNames[High(NoAllowNames)] := z;

                //opdOpenBlank.Files.Delete(z);
               end; //mrCancel
            end;//case  fmErrorWithBlank.ModalResult
          end;   //try

          if Go then
            begin
              Go := False;
              goto CkeckNameAgain;
            end;   //if Go

        end; // for z := 0 to opdOpenBlank.Files.Count - 1

      for z := High(NoAllowNames) downto 0 do
        opdOpenBlank.Files.Delete(NoAllowNames[z]);

      Result := True;

      iOutBlank.Visible := True;
    end;
end;


procedure TfmCheckerTests.acShowResultUpdate(Sender: TObject);
begin
  if CanSeeResult then
    acShowResult.Enabled := True
  else
    acShowResult.Enabled := False
end;

{ TResults }

procedure TResults.Add(Index: Integer);
begin
  FBalls[Index] := TResult.Create;
end;

function TResults.AmountOfBalls: Integer;
begin
  Result := Length(FBalls);       //количество всех бланков проверенныхs
end;

procedure TResults.Clear;
var
  i: Integer;
begin
//  for i := AmountOfBalls - 1 downto 0 do
//    FBalls[i].Destroy;

  SetLength(FBalls, 0);
end;

function TResults.GetBalls(Index: Integer): TResult;
begin
  Result := FBalls[Index];
end;

procedure TResults.Repalce(Index: Integer; Result: TResult);
begin
  FBalls[Index] := Result;
end;

procedure TResults.SetLengthBalls(const Index: Integer);
begin
  SetLength(FBalls, Index);
end;

{ TResult }

function TResult.AmountOfSubjects: Integer;
begin
  Result := Length(FBlank);
end;

function TResult.GetBalls(Index: Integer): TAboutSub;
begin
  SetLength(FBlank, Index);
end;

function TResult.GetBlank(Index: Integer): TAboutSub;
begin
  Result := FBlank[Index];
end;

procedure TResult.SetLengthBlank(Index: Integer);
begin
  SetLength(FBlank, Index);
end;

procedure TResult.SetTitleAndAmountInBalls(Index: Integer;
  Result: TAboutSub);
begin
  FBlank[Index].TitleOfSubject := Result.TitleOfSubject;
  FBlank[Index].AmountOfRight := Result.AmountOfRight;
end;

function TfmCheckerTests.TryExtend(NameFile: string): string;
var
  i: Integer;
  LengthRes: string;
begin
  LengthRes := GetName(NameFile);

  for i := Length(LengthRes) downto 0 do
    if LengthRes[i] = '(' then
      begin
        Result := Copy(LengthRes, 1, i - 1);
        if Pos(')', LengthRes) <> 0 then
          Result := Result + Copy(LengthRes, i + 1, Pos(')', LengthRes) - i - 1);
        break;
      end;
end;

procedure TfmCheckerTests.Extend(NameFile: string; var NumberOfPupil,
  NumberVar: Integer);
var
  i: Integer;
begin
  NameFile := GetName(NameFile);

  for i := Length(NameFile) downto 0 do
    if NameFile[i] = '(' then
      begin
        NumberOfPupil := StrToInt(Copy(NameFile, 1, i - 1));
        if Pos(')', NameFile) <> 0 then
          NumberVar := StrToInt(Copy(NameFile, i + 1, Pos(')', NameFile) - i - 1));

        break;
      end;
end;

procedure TfmCheckerTests.acAddVarExecute(Sender: TObject);
var
  i: Integer;
begin
  if odOpen.Execute then
    begin
      Variants.AddVarFromFile(odOpen.Files);

      lvNameaVar.Items.Clear;

      for i := 0 to Variants.Count - 1 do
        with lvNameaVar.Items.Add do
          begin
            Caption := TakeName(Variants[i].NameFile);
            SubItems.Add(IntToStr(Variants[i].NumberOfVariant));
          end;

      if pnShowBlanks.Visible then
      begin
        pAllVar.Visible := True;
        pnShowBlanks.Align := alTop;
        pnShowBlanks.Height := Panel3.Height - Panel3.Height div 3;
        Splitter1.Top := pnShowBlanks.Height;
      end
      else
      begin
        pAllVar.Visible := True;
        Panel3.Visible := True;
      end;

      sbStatus.Panels[1].Text := 'Количество загруженных кодов: ' + IntToStr(Variants.AmountOfVariants);
    end; //if odOpen.Execute
end;

procedure TfmCheckerTests.acExitExecute(Sender: TObject);
begin
  Close;
end;

{ Icon }

constructor TIcon.Create;
begin
  inherited Create;

  FIcon := TImage.Create(nil);      //Создает прямоуг
  FIcon.Tag := Integer(Self);

  FIconBoard := TShape.Create(nil);      //Создает прямоуг
  FIconBoard.Tag := Integer(Self);

  FIconBoard.Pen.Mode := pmMask;
  FIconBoard.Pen.Style := psDot;

  FlbNo := TLabel.Create(nil);     //Создает лейбл
  FlbNo.Tag := Integer(Self);

  FlbNo.Transparent := False;

  FlbNoBoard := TShape.Create(nil);     //Создает лейбл
  FlbNoBoard.Tag := Integer(Self);

  FlbNoBoard.Pen.Mode := pmMask;
  FlbNoBoard.Pen.Style := psDot;

  FlbNoBoard.Visible := False;
end;

destructor TIcon.Destroy;
begin
  FlbNo.Free;                       //Уничтожает цифру
  FIcon.Free;                       //Уничтожает прямоугольник

  FlbNoBoard.Free;                       //Уничтожает цифру
  FIconBoard.Free;                       //Уничтожает прямоугольник

  inherited;
end;

function TIcon.GetParent: TWinControl;
begin
  Result := FIcon.Parent;          //Получает родителя image
end;

procedure TIcon.SetParent(const Value: TWinControl);
begin
  FIcon.Parent := Value;                     //Установка родителей для image
  FlbNo.Parent := Value;                    //и лейбла

  FIconBoard.Parent := Value;                     //Установка родителей для image
  FlbNoBoard.Parent := Value;                    //и лейбла
end;

procedure TIcon.SetX(const Value: Integer);
begin
  FX := Value;                //Записывает левую координ
  FIcon.Left := FX;            //задает левую координ
  FIconBoard.Left := FX;
end;

procedure TIcon.SetY(const Value: Integer);
begin
  FY := Value;                //Записывает верхнюю координ
  FIcon.Top := FY;             //задает верхнюю координ
  FIconBoard.Top := FY;
end;

{ TIcons }

function TIcons.AddTest: TIcon;
begin
  Result := TIcon.Create;         //Вызывает конструктор
  FIcons.Add(Result);
end;

procedure TIcons.Clear;
//Отчистка всех тестов, начиная с конца удаляет все тесты
var
  i: Integer;
begin
  for i := Count - 1 downto 0 do
    Delete(i);
end;

constructor TIcons.Create;
begin
  inherited Create;

  FIcons := TList.Create;
end;

procedure TIcons.Delete(Index: Integer);
begin
  if Index > -1 then
  begin
    Icons[Index].Icon.Free;  //Убивает прямоуг
    Icons[Index].lbNo.Free; //убивает лейбл
    Icons[Index].IconBoard.Free;
    Icons[Index].lbNoBoard.Free;
    
    FIcons.Delete(Index);
  end;
end;

function TIcons.GetCount: Integer;
begin
   Result := FIcons.Count;          //Сколько всего  уже
end;

function TIcons.GetIcon(Index: Integer): TIcon;
begin
  Result := FIcons[Index];        //по индексу получает  image
end;

function TIcon.SolveY(Index, IconHeight, TabYlb, TabY: Integer): Integer;
begin
  Result := Index * (IconHeight + 2 * TabYLb + 2 * TabY + lbNo.Height) + TabY;
end;

procedure TfmCheckerTests.SpeedButton2Click(Sender: TObject);
var
  i: Integer;
begin
  seKoef.Enabled := False;

  Koef := 60;

  IconHeight := 60 * IconHeight100 div 100;
  IconWidthBoard := 60 * IconWidthBoard100 div 100;

  for i := 0 to Icons.Count - 1 do
    begin
      Icons[i].Icon.Height := IconHeight;
      Icons[i].IconBoard.Height := IconHeight;

      Icons[i].IconBoard.Width := IconWidthBoard;

      Icons[i].Y := Icons[i].SolveY(i, IconHeight, TabYlb, TabY);

      Icons[i].lbNo.Top := Icons[i].Y + IconHeight + TabYLb;
      Icons[i].lbNoBoard.Top := Icons[i].lbNo.Top;

      Icons[i].lbNo.Left := IconWidthBoard div 2 + TabXLb - Icons[i].lbNo.Width div 2;
      Icons[i].lbNoBoard.Left := Icons[i].lbNo.Left;
    end;
end;

procedure TfmCheckerTests.SpeedButton1Click(Sender: TObject);
var
  i: Integer;
begin
  seKoef.Enabled := False;

  Koef := 100;

  IconHeight := IconHeight100;
  IconWidthBoard := IconWidthBoard100;

  for i := 0 to Icons.Count - 1 do
    begin
      Icons[i].Icon.Height := IconHeight;
      Icons[i].IconBoard.Height := IconHeight;

      Icons[i].IconBoard.Width := IconWidthBoard;

      Icons[i].Y := Icons[i].SolveY(i, IconHeight, TabYlb, TabY);

      Icons[i].lbNo.Top := Icons[i].Y + IconHeight + TabYLb;
      Icons[i].lbNoBoard.Top := Icons[i].lbNo.Top;

      Icons[i].lbNo.Left := IconWidthBoard div 2 + TabXLb - Icons[i].lbNo.Width div 2;
      Icons[i].lbNoBoard.Left := Icons[i].lbNo.Left;
    end;
end;

procedure TfmCheckerTests.SpeedButton3Click(Sender: TObject);
var
  i: Integer;
begin
  seKoef.Enabled := False;

  Koef := 30;

  IconHeight := 30 * IconHeight100 div 100;
  IconWidthBoard := 30 * IconWidthBoard100 div 100;

  for i := 0 to Icons.Count - 1 do
    begin
      Icons[i].Icon.Height := IconHeight;
      Icons[i].IconBoard.Height := IconHeight;

      Icons[i].IconBoard.Width := IconWidthBoard;

      Icons[i].Y := Icons[i].SolveY(i, IconHeight, TabYlb, TabY);

      Icons[i].lbNo.Top := Icons[i].Y + IconHeight + TabYLb;
      Icons[i].lbNoBoard.Top := Icons[i].lbNo.Top;

      Icons[i].lbNo.Left := IconWidthBoard div 2 + TabXLb - Icons[i].lbNo.Width div 2;
      Icons[i].lbNoBoard.Left := Icons[i].lbNo.Left;
    end;
end;

procedure TfmCheckerTests.acMashtabExecute(Sender: TObject);
var
  i: Integer;
begin
  if seKoef.Value < 0 then
    seKoef.Value := 1;
    
  if seKoef.Value > 100 then
    seKoef.Value := 100;

  IconHeight := seKoef.Value * IconHeight100 div 100;
  IconWidthBoard := seKoef.Value * IconWidthBoard100 div 100;

  for i := 0 to Icons.Count - 1 do
    begin
      Icons[i].Icon.Height := IconHeight;
      Icons[i].IconBoard.Height := IconHeight;

      Icons[i].IconBoard.Width := IconWidthBoard;

      Icons[i].Y := Icons[i].SolveY(i, IconHeight, TabYlb, TabY);

      Icons[i].lbNo.Top := Icons[i].Y + IconHeight + TabYLb;
      Icons[i].lbNoBoard.Top := Icons[i].lbNo.Top;

      Icons[i].lbNo.Left := IconWidthBoard div 2 + TabXLb - Icons[i].lbNo.Width div 2;
      Icons[i].lbNoBoard.Left := Icons[i].lbNo.Left;
    end;// for i := 0 to Icons.Count - 1 do
end;

procedure TfmCheckerTests.sbMasClick(Sender: TObject);
begin
  seKoef.Enabled := True;
  seKoef.Value := Koef;
end;

procedure TfmCheckerTests.acShowAllBlanksExecute(Sender: TObject);
begin
  if pnShowBlanks.Visible then
    begin
      pnShowBlanks.Visible := False;
        if not pAllVar.Visible then
          Panel3.Visible := False;
    end //if pnShowBlanks.Visible
  else
    begin
      if pAllVar.Visible then
        begin
          pnShowBlanks.Visible := True;
          pnSHowBlanks.Align := alTop;
          pnShowBlanks.Height := Panel3.Height - Panel3.Height div 3;
          Splitter1.Top := pnShowBlanks.Height;
        end // if pAllVar.Visible
      else
        begin
          Panel3.Visible := True;
          pnShowBlanks.Visible := True;
          pnSHowBlanks.Align := alClient;
        end
    end; //else
end;

procedure TfmCheckerTests.acShowAllBlanksUpdate(Sender: TObject);
begin
  if pnShowBlanks.Visible then
    acShowAllBlanks.Checked := True
  else
    acShowAllBlanks.Checked := False;
end;

procedure TfmCheckerTests.MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  IconBoard: TShape;
  Icon: TIcon;
  Point: TPoint;
begin
  IconBoard := TShape(Sender);
  Icon := TIcon(IconBoard.Tag);

  case Button of
  mbLeft: SelectIcon(Icon);
  mbRight:
    begin
      SelectIcon(Icon);
      Point.X := X; Point.Y := Y;
      Point := IconBoard.ClientToScreen(Point);
      pmIcons.Popup(Point.X, Point.Y);
    end;
  end; //case

end;

procedure TfmCheckerTests.SelectIcon(Icon: TIcon);
begin
  if Assigned(OldIcon) then
    begin
      OldIcon.IconBoard.Pen.Color := clBlack;
      OldIcon.lbNoBoard.Visible := False;
      OldIcon.lbNo.Color := clBtnFace;
      OldIcon.lbNo.Font.Color := clBlack;
    end;  // if Assigned(OldIcon)

  Icon.IconBoard.Pen.Color := clBlue;

  Icon.lbNoBoard.Visible := True;
  Icon.lbNo.Color := clBlue;
  Icon.lbNo.Font.Color := clYellow;

  OldIcon := Icon;

  iOutBlank.Picture.LoadFromFile(Files[Icons.IndexOf(Icon)].fFile.fName);
end;

procedure TfmCheckerTests.sbOutIconMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(OldIcon) then
    begin
      OldIcon.IconBoard.Pen.Color := clBlack;
      OldIcon.lbNoBoard.Visible := False;
      OldIcon.lbNo.Color := clBtnFace;
      OldIcon.lbNo.Font.Color := clBlack;
    end;  // if Assigned(OldIcon)

  OldIcon := nil;

  nCheckAll.OnClick(Sender);
end;

function TIcons.IndexOf(Icon: TIcon): Integer;
begin
  Result := FIcons.IndexOf(Icon);
end;

procedure TfmCheckerTests.nDelClick(Sender: TObject);
var
  i, Index: Integer;
  Fil: TFiles;
begin
  Index := Icons.IndexOf(OldIcon);

  Icons.Delete(Index);

  for i := Index to Icons.Count - 1 do
    begin
      Icons[i].Y := Icons[i].SolveY(i, IconHeight, TabYlb, TabY);

      Icons[i].lbNo.Top := Icons[i].Y + IconHeight + TabYLb;
      Icons[i].lbNoBoard.Top := Icons[i].lbNo.Top;
    end; // for i := Icons.IndexOf(OldIcon) to Icons.Count - 1

  for i := Index to Length(Files) - 2 do
    begin
      Fil := Files[i];
      Files[i] := Files[i + 1];
      Files[i + 1] := Fil;
    end; // for i := Index to Length(Files) - 1

  SetLength(Files, Length(Files) - 1);

  OldIcon := nil;

  sbStatus.Panels[0].Text := 'Количество загруженных бланков: ' + IntToStr(Length(Files));
end;

procedure TfmCheckerTests.nDelAllClick(Sender: TObject);
begin
  Icons.Clear;

  SetLength(Files, 0);

  OldIcon := nil;

  sbStatus.Panels[0].Text := 'Количество загруженных бланков: ' + IntToStr(Length(Files));
end;

procedure TfmCheckerTests.lbALLBlanksMouseEnter(Sender: TObject);
begin
  lbAllBlanks.Font.Color := clBlue;
end;

procedure TfmCheckerTests.lbALLBlanksMouseLeave(Sender: TObject);
begin
  lbAllBlanks.Font.Color := clBlack;
end;

procedure TfmCheckerTests.lbAllVArMouseEnter(Sender: TObject);
begin
  lbAllVar.Font.Color := clBlue;
end;

procedure TfmCheckerTests.lbAllVArMouseLeave(Sender: TObject);
begin
  lbAllVar.Font.Color := clBlack;
end;

procedure TfmCheckerTests.acShowAllCodesExecute(Sender: TObject);
begin
  if pAllVar.Visible then
    begin
      pAllVar.Visible := False;
        if pnShowBlanks.Visible then
          pnShowBlanks.Align := alClient
        else
          Panel3.Visible := False;
    end
  else
    if pnShowBlanks.Visible then
      begin
        pAllVar.Visible := True;
        pnShowBlanks.Align := alTop;
        pnShowBlanks.Height := Panel3.Height - Panel3.Height div 3;
        Splitter1.Top := pnShowBlanks.Height;
      end
    else
      begin
        pAllVar.Visible := True;
        Panel3.Visible := True;
      end;
end;

procedure TfmCheckerTests.acShowAllCodesUpdate(Sender: TObject);
begin
  if pAllVar.Visible then
    acShowAllCodes.Checked := True
  else
    acShowAllCodes.Checked := False;
end;

procedure TfmCheckerTests.acDelFromListOfCodesExecute(Sender: TObject);
//удаляет из списка
begin
  Variants.DelVar(lvNameaVar.ItemIndex);       //удаляет выделенный из класса

  lvNameaVar.Items.Delete(lvNameaVar.ItemIndex); //удаляет выделенный из списка

  sbStatus.Panels[1].Text := 'Количество загруженных кодов: ' + IntToStr(Variants.AmountOfVariants)
end;

procedure TfmCheckerTests.acDelFromListOfCodesUpdate(Sender: TObject);
//можно ли нажать удалить
begin
  if lvNameaVar.ItemIndex = - 1 then    //если не выделен ни один вариант, то неактивно удалить
    nDelFromListOfCodes.Enabled := False
  else
    nDelFromListOfCodes.Enabled := True;

  if lvNameaVar.Items.Count = 0 then     //это можно удалить
    nDelAllFromListOfCodes.Enabled := False
  else
    nDelAllFromListOfCodes.Enabled := True;
end;

procedure TfmCheckerTests.nDelAllFromListOfCodesClick(Sender: TObject);
//удаляет все загруженные варианты
begin
  lvNameaVar.Items.Clear;  //очищает список

  Variants.ClearAll;       //удаляет все варианты

  sbStatus.Panels[1].Text := 'Количество загруженных кодов: ' + IntToStr(Variants.AmountOfVariants)
end;

procedure TfmCheckerTests.acSeeVarExecute(Sender: TObject);
//вызывает окно просмоторщика
begin
  if lvNameaVar.ItemIndex > -1 then
    begin
      fmWach.Caption := Variants[lvNameaVar.ItemIndex].NameFile; //записывает имя файла в название
      fmWach.ShowModal;                 //поазывает окно
    end;
end;

procedure TfmCheckerTests.lbNameaVarDblClick(Sender: TObject);
//можно просмотреть выбранный вариант, двойным щелском
begin
  acSeeVar.OnExecute(Sender);  //включает просмотр
end;

procedure TfmCheckerTests.acSeeVarUpdate(Sender: TObject);
begin
  if lvNameaVar.ItemIndex > -1 then
    nSeeVAr.Enabled := True
  else
    nSeeVAr.Enabled := False;
end;

procedure TfmCheckerTests.nCheckAllClick(Sender: TObject);
begin
  tbCheck.Caption := nCheckAll.Caption;
  tbCheck.Tag  := nCheckAll.Tag;       //Передает номер в кнопку и это означает какой вариант проверки

  if N6.Checked then
    N6.Checked := False
  else if N5.Checked then
         N5.Checked := False
       else
         N4.Checked := False;

  nCheckAll.Checked := True;
end;

procedure TfmCheckerTests.N6Click(Sender: TObject);
begin
  tbCheck.Caption := N6.Caption;
  tbCheck.Tag  := N6.Tag;        //Передает номер в кнопку и это означает какой вариант проверки

  if nCheckAll.Checked then
    nCheckAll.Checked := False
  else if N5.Checked then
         N5.Checked := False
       else
         N4.Checked := False;

  N6.Checked := True;
end;

procedure TfmCheckerTests.N5Click(Sender: TObject);
begin
  tbCheck.Caption := N5.Caption;
  tbCheck.Tag  := N5.Tag;        //Передает номер в кнопку и это означает какой вариант проверки

  if N6.Checked then
    N6.Checked := False
  else if nCheckAll.Checked then
         nCheckAll.Checked := False
       else
         N4.Checked := False;

  N5.Checked := True;
end;

procedure TfmCheckerTests.N4Click(Sender: TObject);
begin
  tbCheck.Caption := N4.Caption;
  tbCheck.Tag  := N4.Tag;        //Передает номер в кнопку и это означает какой вариант проверки

  if N6.Checked then
    N6.Checked := False
  else if N5.Checked then
         N5.Checked := False
       else
         nCheckAll.Checked := False;

  N4.Checked := True;
end;

procedure TfmCheckerTests.acCheckOnlySelectedUpdate(Sender: TObject);
//Проверяет, если загруженны варианты и балнки и выделен любой бланк тогда
//экшен активен
begin
  if (Length(Files) > 0) and (Variants.AmountOfVariants > 0) and (Assigned(OldIcon)) then
    acCheckOnlySelected.Enabled := True
  else
    acCheckOnlySelected.Enabled := False;

  if N6.Checked then
    acCheckOnlySelected.Checked := True
  else
    acCheckOnlySelected.Checked := False;
end;

procedure TfmCheckerTests.acCheckTolSelectedUpdate(Sender: TObject);
//Проверяет, если загруженны варианты и балнки и выделен любой бланк тогда
//экшен активен
begin
  if (Length(Files) > 0) and (Variants.AmountOfVariants > 0) and (Assigned(OldIcon)) then
    acCheckTolSelected.Enabled := True
  else
    acCheckTolSelected.Enabled := False;

  if N4.Checked then
    acCheckTolSelected.Checked := True
  else
    acCheckTolSelected.Checked := False;
end;

procedure TfmCheckerTests.acCheckAfterSelectedUpdate(Sender: TObject);
//Проверяет, если загруженны варианты и балнки и выделен любой бланк тогда
//экшен активен
begin
  if (Length(Files) > 0) and (Variants.AmountOfVariants > 0) and (Assigned(OldIcon)) then
    acCheckAfterSelected.Enabled := True
  else
    acCheckAfterSelected.Enabled := False;

  if N5.Checked then
    acCheckAfterSelected.Checked := True
  else
    acCheckAfterSelected.Checked := False;
end;

procedure TfmCheckerTests.acCheckAllExecute(Sender: TObject);
//проверяет все бланки
var
  k, i, j, g, z, x, s, f, n, q,dX, dY, AmountOfPixels, AmountOfRight, NameVar, FullSumBalls: Integer;
  Title: string;
  Result: TAboutSub;
  GoOut: Boolean;
  Number: Integer;  //для прогресса кол-во всех бланков
label
  ShowAgainErWithCode, ToRecErWithCode;
begin
  tbCheck.Caption := acCheckAll.Caption;
  tbCheck.Tag := nCheckAll.Tag;

  if N6.Checked then
    N6.Checked := False
  else if N5.Checked then
         N5.Checked := False
       else
         N4.Checked := False;

  nCheckAll.Checked := True;

  Results.Clear;  //чистит промежуточные результаты

  fmProgress.Show;
  Self.Enabled := False;

  Results.SetLengthBalls(0);

  fmProgress.pbAllProc.Position := 0;

  Number := Length(Files);

  for z := 0 to Length(Files) - 1 do
  begin
    Results.SetLengthBalls(Results.AmountOfBalls + 1);

    iOutBlank.Picture.LoadFromFile(Files[z].fFile.fName);

    s := -1;
    NameVar := -1;

    Extend(Files[z].fFile.fName, Files[z].fFile.fNumberPupil, Files[z].fFile.fNumberVar);

    NameVar := Files[z].fFile.fNumberVar;

    ToRecErWithCode:  //сюда идет когда чувак загрузит необходимый вариант
    for x := 0 to Variants.AmountOfVariants - 1 do
      if NameVar = Variants[x].NumberOfVariant then
        begin
          s := x;
          break;
        end; // if NameVar = Variants[x].NumberOfVariant

    if s = -1 then
      begin
        Mistake := IntToStr(NameVar);

        //сюда пойдет если чувак при открытии файла нажал отмена
        ShowAgainErWithCode: fmErrors.ShowModal;

        case fmErrors.ModalResult of
          mrOk:
            begin
              if odOpenCodeWhenEr.Execute then
                begin
                  Variants.AddVarFromFile(odOpenCodeWhenEr.Files);

                  lvNameaVar.Items.Clear;

                  for q := 0 to Variants.Count - 1 do
                    with lvNameaVar.Items.Add do
                      begin
                        Caption := TakeName(Variants[q].NameFile);
                        SubItems.Add(IntToStr(Variants[q].NumberOfVariant));
                      end;

                  goto ToRecErWithCode;
                end  // if odOpenCodeWhenEr.Execute
              else
                goto ShowAgainErWithCode;
            end; //mrOk
          mrCancel:
            begin
              SetLength(NoFindVars, Length(NoFindVars) + 1);
              NoFindVars[High(NoFindVars)] := NameVar;

              Results.SetLengthBalls(Length(Files) - 1);

              continue;
            end; //meCancel
        end; // case fmErrors.ModalResult
      end;    //  if s = -1

    Results.Add(z);
    Results[z].SetLengthBlank(Variants[s].AmountOfSubjects);
    Results[z].NumberOfVar := Variants[s].NumberOfVariant;
    Results[z].NumberOfPupil := Files[z].fFile.fNumberPupil;

    FullSumBalls := 0;

    GoOut := False;

    for f := 0 to iOutBlank.Width do
    begin
      for n := 0 to iOutBlank.Height do
        if iOutBlank.Canvas.Pixels[f, n] = clBlack then
          begin
            dX := f;
            dY := n;
            GoOut := True;
            break;
          end; //if iOutBlank.Canvas.Pixels[f, n] = clBlack
      if GoOut then
        break;
    end;// for f := 0 to iOutBlank.Width

    for k := 0 to Variants[s].AmountOfSubjects - 1 do
    begin
      AmountOfRight := 0;
      fmProgress.pbProgress.Position := 0;

      fmProgress.pbAllProc.Step := Round(fmProgress.pbAllProc.Max / (Variants[s].AmountOfSubjects * Number));
      fmProgress.pbAllProc.Max := fmProgress.pbAllProc.Step * Variants[s].AmountOfSubjects * Number;

      fmProgress.pbAllProc.Position := fmProgress.pbAllProc.Position + fmProgress.pbAllProc.Step;

      for i := 0 to Variants[s].Subjects[k].AmountOfTests - 1 do
      begin
        fmProgress.lbProgress.Caption := 'Вариант № ' + IntToStr(Variants[s].NumberOfVariant) + '\' + Variants[s].Subjects[k].TitleOfSubject;
        fmProgress.lbProgress.Caption := fmProgress.lbProgress.Caption + '\' + IntToStr(i + 1);

        fmProgress.pbProgress.Step := Round(fmProgress.pbProgress.Max / Variants[s].Subjects[k].AmountOfTests);
        fmProgress.pbProgress.Max := fmProgress.pbProgress.Step * Variants[s].Subjects[k].AmountOfTests;

        fmProgress.pbProgress.Position := fmProgress.pbProgress.Position + fmProgress.pbProgress.Step;

        AmountOfPixels := 0;

        for j := Variants[s].Subjects[k].Tests[i].X + dX to Variants[s].Subjects[k].Tests[i].X + dX + Variants[s].Subjects[k].Tests[i].Width do
         for g := Variants[s].Subjects[k].Tests[i].Y + dY to Variants[s].Subjects[k].Tests[i].Y + dY + Variants[s].Subjects[k].Tests[i].Height do
           if iOutBlank.Canvas.Pixels[j, g] = clBlack then
             Inc(AmountOfPixels);
        if Percent(Variants[s].Subjects[k].Tests[i].Width * Variants[s].Subjects[k].Tests[i].Height, AmountOfPixels) then
          Inc(AmountOfRight);
      end; // for i := 0 to Subjects[k].AmountOfTests - do

      Result.TitleOfSubject := Variants[s].Subjects[k].TitleOfSubject;
      Result.AmountOfRight := AmountOfRight;

      FullSumBalls := FullSumBalls + AmountOfRight;

      Results[z].SetTitleAndAmountInBalls(k, Result);
    end; //  for k := 0 to Subjects.AmountOfSubjects - 1 do

    Results[z].FullSumBalls := FullSumBalls;
  end; //if  Files[z].fCkecked = False

  Self.Enabled := True;
  Self.SetFocus;
  fmProgress.Close;

  CanSeeResult := True;

  acShowResult.Enabled := True;
end;

procedure TfmCheckerTests.acCheckExecute(Sender: TObject);
//нажатие на кнопке проверить и выбирает как проверять в зависимости от выбранного
begin
  pOut.Visible := False;

  case tbCheck.Tag of
    1 : acCheckAll.OnExecute(Sender);   //все целиком
    2 : acCheckOnlySelected.OnExecute(Sender); //только выделеный
    3 : acCheckTolSelected.OnExecute(Sender);  //до выделенного
    4 : acCheckAfterSelected.OnExecute(Sender); //после выделенного
  end;
     
  pOut.Visible := True;
end;

procedure TfmCheckerTests.acCheckAllUpdate(Sender: TObject);
//Проверяет, если загруженны варианты и балнки и выделен любой бланк тогда
//экшен активен
begin
  if (Length(Files) > 0) and (Variants.AmountOfVariants > 0) then
    acCheckAll.Enabled := True
  else
    acCheckAll.Enabled := False;

  if nCheckAll.Checked then
    acCheckAll.Checked := True
  else
    acCheckAll.Checked := False;
end;

procedure TfmCheckerTests.acCheckUpdate(Sender: TObject);
// проверка если все загруженно то можно проверять
begin
  if (Length(Files) > 0) and (Variants.AmountOfVariants > 0) then
    acCheck.Enabled := True
  else
    acCheck.Enabled := False
end;

procedure TfmCheckerTests.pnButtinPopup(Sender: TObject);
//при нажатии на выборе проверки
begin
  //если уже все загруженно и выделен бланк, то делает все проверки активными
  if (Length(Files) > 0) and (Variants.AmountOfVariants > 0) and (Assigned(OldIcon)) then
    begin
      N6.Enabled := True;  //проверка по выделеному
      N4.Enabled := True;  //проверка до выделенного
      n5.Enabled := True;  //проверка полсе выделенного
    end
  else     //значит что-то не в порядке ( не загружено или не выбрано)
    begin
      N6.Enabled := False;  //проверка по выделеному
      N4.Enabled := False;  //проверка до выделенного
      n5.Enabled := False;  //проверка полсе выделенного
    end
end;

procedure TfmCheckerTests.acCheckOnlySelectedExecute(Sender: TObject);
//Проверяет только один бланк
var
  k, i, j, g, z, x, s, f, n, q,dX, dY, AmountOfPixels, AmountOfRight, NameVar, FullSumBalls: Integer;
  Title: string;
  Result: TAboutSub;  //промежуточные результаты для записи в общее
  GoOut: Boolean;  //чтобы выйти из верхнего фора
label
  ShowAgainErWithCode, ToRecErWithCode;
begin
  tbCheck.Caption := acCheckOnlySelected.Caption;
  tbCheck.Tag  := N6.Tag;        //Передает номер в кнопку и это означает какой вариант проверки

  if nCheckAll.Checked then
    nCheckAll.Checked := False
  else if N5.Checked then
         N5.Checked := False
       else
         N4.Checked := False;

  N6.Checked := True;

  Results.Clear;

  fmProgress.Show;
  Self.Enabled := False;

  fmProgress.pbAllProc.Position := 0;

  for z := Icons.IndexOf(OldIcon) to Icons.IndexOf(OldIcon) do //узнает индек в общем листе данного бланка
  begin
    Results.SetLengthBalls(Results.AmountOfBalls + 1);  //устанавливает длин

    iOutBlank.Picture.LoadFromFile(Files[z].fFile.fName);  //загрузка рисунка

    s := -1;
    NameVar := -1;

    Extend(Files[z].fFile.fName, Files[z].fFile.fNumberPupil, Files[z].fFile.fNumberVar);

    NameVar := Files[z].fFile.fNumberVar; //берет номер варианта

    ToRecErWithCode:  //сюда идет когда чувак загрузит необходимый вариант
    for x := 0 to Variants.AmountOfVariants - 1 do  //проверяет есль ли нужный вариант
      if NameVar = Variants[x].NumberOfVariant then  //если есть, то берем его номер
        begin
          s := x;           //берет его номер
          break;
        end; // if NameVar = Variants[x].NumberOfVariant

    if s = -1 then     //если варианта не было
      begin
        Mistake := IntToStr(NameVar);    //не найден нужный вариант

        //сюда пойдет если чувак при открытии файла нажал отмена
        ShowAgainErWithCode: fmErrors.ShowModal;

        case fmErrors.ModalResult of  //показывает окно
          mrOk:          //если нажал добавить
            begin
              if odOpenCodeWhenEr.Execute then  //диалог открыть
                begin
                  Variants.AddVarFromFile(odOpenCodeWhenEr.Files);  //добавляется новый вариант

                  lvNameaVar.Items.Clear;   //очищается список всех загруженных вариантов

                  for q := 0 to Variants.Count - 1 do  //и заново записывается
                    with lvNameaVar.Items.Add do
                      begin
                        Caption := TakeName(Variants[q].NameFile); //имя файла
                        SubItems.Add(IntToStr(Variants[q].NumberOfVariant)); //номер варианта
                      end;

                  goto ToRecErWithCode;   // идет еще раз на проверку
                end  // if odOpenCodeWhenEr.Execute
              else
                goto ShowAgainErWithCode;  //если в окне открыть нажал отмена
            end; //mrOk
          mrCancel:     //если нажал забыть про этот бланк
            begin
              SetLength(NoFindVars, Length(NoFindVars) + 1);
              NoFindVars[High(NoFindVars)] := NameVar;

              Results.SetLengthBalls(Length(Files) - 1);  //уменьшает кол-во бланков в результате

              continue;                       //берет следующего
            end; //meCancel
        end; // case fmErrors.ModalResult
      end;    //  if s = -1

    Results.Add(Results.AmountOfBalls - 1);    //добавляет еще один бланк
    Results[Results.AmountOfBalls - 1].SetLengthBlank(Variants[s].AmountOfSubjects);//кол-во предметов
    Results[Results.AmountOfBalls - 1].NumberOfVar := Variants[s].NumberOfVariant;  //номер варианта
    Results[Results.AmountOfBalls - 1].NumberOfPupil := Files[z].fFile.fNumberPupil;//номер ученика

    FullSumBalls := 0;

    GoOut := False;

    for f := 0 to iOutBlank.Width do    //ищет границы
    begin
      for n := 0 to iOutBlank.Height do
        if iOutBlank.Canvas.Pixels[f, n] = clBlack then
          begin
            dX := f;
            dY := n;
            GoOut := True;    //чтобы выйти из верхнего фора
            break;
          end; //if iOutBlank.Canvas.Pixels[f, n] = clBlack
      if GoOut then
        break;
    end;// for f := 0 to iOutBlank.Width

    for k := 0 to Variants[s].AmountOfSubjects - 1 do   //будет идти по всем предметам чтобы проверить
    begin
      AmountOfRight := 0;
      fmProgress.pbProgress.Position := 0;

      fmProgress.pbAllProc.Step := Round(fmProgress.pbAllProc.Max / Variants[s].AmountOfSubjects);
      fmProgress.pbAllProc.Max := fmProgress.pbAllProc.Step * Variants[s].AmountOfSubjects;

      fmProgress.pbAllProc.Position := fmProgress.pbAllProc.Position + fmProgress.pbAllProc.Step;

      for i := 0 to Variants[s].Subjects[k].AmountOfTests - 1 do  //идет по вопросам в каждом предмете
      begin
        fmProgress.lbProgress.Caption := 'Вариант № ' + IntToStr(Variants[s].NumberOfVariant) + '\' + Variants[s].Subjects[k].TitleOfSubject;
        fmProgress.lbProgress.Caption := fmProgress.lbProgress.Caption + '\' + IntToStr(i + 1);
        //по предмету
        fmProgress.pbProgress.Step := Round(fmProgress.pbProgress.Max / Variants[s].Subjects[k].AmountOfTests);
        fmProgress.pbProgress.Max := fmProgress.pbProgress.Step * Variants[s].Subjects[k].AmountOfTests;

        fmProgress.pbProgress.Position := fmProgress.pbProgress.Position + fmProgress.pbProgress.Step;

        AmountOfPixels := 0;    //кол-во совпавших пикселей

        for j := Variants[s].Subjects[k].Tests[i].X + dX to Variants[s].Subjects[k].Tests[i].X + dX + Variants[s].Subjects[k].Tests[i].Width do
         for g := Variants[s].Subjects[k].Tests[i].Y + dY to Variants[s].Subjects[k].Tests[i].Y + dY + Variants[s].Subjects[k].Tests[i].Height do
           if iOutBlank.Canvas.Pixels[j, g] = clBlack then
             Inc(AmountOfPixels);   //увеличивает кол-во совпавших пикселей
        if Percent(Variants[s].Subjects[k].Tests[i].Width * Variants[s].Subjects[k].Tests[i].Height, AmountOfPixels) then
          Inc(AmountOfRight);  //если по процентам прошло, то увеличивает кол-во правильных
      end; // for i := 0 to Subjects[k].AmountOfTests - do

      Result.TitleOfSubject := Variants[s].Subjects[k].TitleOfSubject;//записывает название предмета
      Result.AmountOfRight := AmountOfRight;           //кол-во правильных ответов

      FullSumBalls := FullSumBalls + AmountOfRight;    //считает польное кол-во правильных

      Results[Results.AmountOfBalls - 1].SetTitleAndAmountInBalls(k, Result);//записывает результаты в главные результаты по предмету
    end; //  for k := 0 to Subjects.AmountOfSubjects - 1 do

    Results[Results.AmountOfBalls - 1].FullSumBalls := FullSumBalls; //записывает кол-во правильных всего
  end; //if  Files[z].fCkecked = False

  Self.Enabled := True;
  Self.SetFocus;
  fmProgress.Close;

  CanSeeResult := True;

  acShowResult.Enabled := True;
end;

procedure TfmCheckerTests.acCheckTolSelectedExecute(Sender: TObject);
//Проверяет только до выделенного
var
  k, i, j, g, z, x, s, f, n, q,dX, dY, AmountOfPixels, AmountOfRight, NameVar, FullSumBalls: Integer;
  Title: string;
  Result: TAboutSub;  //промежуточные результаты для записи в общее
  GoOut: Boolean;  //чтобы выйти из верхнего фора
  Number: Integer;  //для прогресса кол-во всех бланков
label
  ShowAgainErWithCode, ToRecErWithCode;
begin
  tbCheck.Caption := acCheckTolSelected.Caption;
  tbCheck.Tag  := N4.Tag;        //Передает номер в кнопку и это означает какой вариант проверки

  if N6.Checked then
    N6.Checked := False
  else if N5.Checked then
         N5.Checked := False
       else
         nCheckAll.Checked := False;

  N4.Checked := True;

  Results.Clear;  //чистит промежуточные результаты

  fmProgress.Show;
  Self.Enabled := False;

  fmProgress.pbAllProc.Position := 0;

  Number := Icons.IndexOf(OldIcon) + 1;

  for z := 0 to Icons.IndexOf(OldIcon) do //узнает индек в общем листе данного бланка
  begin
    Results.SetLengthBalls(Results.AmountOfBalls + 1);  //устанавливает длин

    iOutBlank.Picture.LoadFromFile(Files[z].fFile.fName);  //загрузка рисунка

    s := -1;
    NameVar := -1;

    Extend(Files[z].fFile.fName, Files[z].fFile.fNumberPupil, Files[z].fFile.fNumberVar);

    NameVar := Files[z].fFile.fNumberVar; //берет номер варианта

    ToRecErWithCode:  //сюда идет когда чувак загрузит необходимый вариант
    for x := 0 to Variants.AmountOfVariants - 1 do  //проверяет есль ли нужный вариант
      if NameVar = Variants[x].NumberOfVariant then  //если есть, то берем его номер
        begin
          s := x;           //берет его номер
          break;
        end; // if NameVar = Variants[x].NumberOfVariant

    if s = -1 then     //если варианта не было
      begin
        Mistake := IntToStr(NameVar);    //не найден нужный вариант

        //сюда пойдет если чувак при открытии файла нажал отмена
        ShowAgainErWithCode: fmErrors.ShowModal;

        case fmErrors.ModalResult of  //показывает окно
          mrOk:          //если нажал добавить
            begin
              if odOpenCodeWhenEr.Execute then  //диалог открыть
                begin
                  Variants.AddVarFromFile(odOpenCodeWhenEr.Files);  //добавляется новый вариант
                  lvNameaVar.Items.Clear;   //очищается список всех загруженных вариантов

                  for q := 0 to Variants.Count - 1 do  //и заново записывается
                    with lvNameaVar.Items.Add do
                      begin
                        Caption := TakeName(Variants[q].NameFile); //имя файла
                        SubItems.Add(IntToStr(Variants[q].NumberOfVariant)); //номер варианта
                      end;

                  goto ToRecErWithCode;   // идет еще раз на проверку
                end  // if odOpenCodeWhenEr.Execute
              else
                goto ShowAgainErWithCode;  //если в окне открыть нажал отмена
            end; //mrOk
          mrCancel:     //если нажал забыть про этот бланк
            begin
              SetLength(NoFindVars, Length(NoFindVars) + 1);
              NoFindVars[High(NoFindVars)] := NameVar;

              Results.SetLengthBalls(Length(Files) - 1);  //уменьшает кол-во бланков в результате

              continue;                       //берет следующего
            end; //meCancel
        end; // case fmErrors.ModalResult
      end;    //  if s = -1

    Results.Add(Results.AmountOfBalls - 1);    //добавляет еще один бланк
    Results[Results.AmountOfBalls - 1].SetLengthBlank(Variants[s].AmountOfSubjects);//кол-во предметов
    Results[Results.AmountOfBalls - 1].NumberOfVar := Variants[s].NumberOfVariant;  //номер варианта
    Results[Results.AmountOfBalls - 1].NumberOfPupil := Files[z].fFile.fNumberPupil;//номер ученика

    FullSumBalls := 0;

    GoOut := False;

    for f := 0 to iOutBlank.Width do    //ищет границы
    begin
      for n := 0 to iOutBlank.Height do
        if iOutBlank.Canvas.Pixels[f, n] = clBlack then
          begin
            dX := f;
            dY := n;
            GoOut := True;    //чтобы выйти из верхнего фора
            break;
          end; //if iOutBlank.Canvas.Pixels[f, n] = clBlack
      if GoOut then
        break;
    end;// for f := 0 to iOutBlank.Width

    for k := 0 to Variants[s].AmountOfSubjects - 1 do   //будет идти по всем предметам чтобы проверить
    begin
      AmountOfRight := 0;
      fmProgress.pbProgress.Position := 0;

      fmProgress.pbAllProc.Step := Round(fmProgress.pbAllProc.Max / (Variants[s].AmountOfSubjects * Number));
      fmProgress.pbAllProc.Max := fmProgress.pbAllProc.Step * Variants[s].AmountOfSubjects * Number;

      fmProgress.pbAllProc.Position := fmProgress.pbAllProc.Position + fmProgress.pbAllProc.Step;

      for i := 0 to Variants[s].Subjects[k].AmountOfTests - 1 do  //идет по вопросам в каждом предмете
      begin
        fmProgress.lbProgress.Caption := 'Вариант № ' + IntToStr(Variants[s].NumberOfVariant) + '\' + Variants[s].Subjects[k].TitleOfSubject;
        fmProgress.lbProgress.Caption := fmProgress.lbProgress.Caption + '\' + IntToStr(i + 1);

        fmProgress.pbProgress.Step := Round(fmProgress.pbProgress.Max / Variants[s].Subjects[k].AmountOfTests);
        fmProgress.pbProgress.Max := fmProgress.pbProgress.Step * Variants[s].Subjects[k].AmountOfTests;

        fmProgress.pbProgress.Position := fmProgress.pbProgress.Position + fmProgress.pbProgress.Step;

        AmountOfPixels := 0;    //кол-во совпавших пикселей

        for j := Variants[s].Subjects[k].Tests[i].X + dX to Variants[s].Subjects[k].Tests[i].X + dX + Variants[s].Subjects[k].Tests[i].Width do
         for g := Variants[s].Subjects[k].Tests[i].Y + dY to Variants[s].Subjects[k].Tests[i].Y + dY + Variants[s].Subjects[k].Tests[i].Height do
           if iOutBlank.Canvas.Pixels[j, g] = clBlack then
             Inc(AmountOfPixels);   //увеличивает кол-во совпавших пикселей
        if Percent(Variants[s].Subjects[k].Tests[i].Width * Variants[s].Subjects[k].Tests[i].Height, AmountOfPixels) then
          Inc(AmountOfRight);  //если по процентам прошло, то увеличивает кол-во правильных
      end; // for i := 0 to Subjects[k].AmountOfTests - do

      Result.TitleOfSubject := Variants[s].Subjects[k].TitleOfSubject;//записывает название предмета
      Result.AmountOfRight := AmountOfRight;           //кол-во правильных ответов

      FullSumBalls := FullSumBalls + AmountOfRight;    //считает польное кол-во правильных
       Results[Results.AmountOfBalls - 1].SetTitleAndAmountInBalls(k, Result);//записывает результаты в главные результаты по предмету
    end; //  for k := 0 to Subjects.AmountOfSubjects - 1 do

    Results[Results.AmountOfBalls - 1].FullSumBalls := FullSumBalls; //записывает кол-во правильных всего
  end; // for z := 0 to Variants.AmountOfVariants - 1

  Self.Enabled := True;
  Self.SetFocus;
  fmProgress.Close;

  CanSeeResult := True;

  acShowResult.Enabled := True;
end;

procedure TfmCheckerTests.acCheckAfterSelectedExecute(Sender: TObject);
//Проверяет только после выделенного
var
  k, i, j, g, z, x, s, f, n, q,dX, dY, AmountOfPixels, AmountOfRight, NameVar, FullSumBalls: Integer;
  Title: string;
  Result: TAboutSub;  //промежуточные результаты для записи в общее
  GoOut: Boolean;  //чтобы выйти из верхнего фора
  Number: Integer;  //для прогресса кол-во всех бланков
label
  ShowAgainErWithCode, ToRecErWithCode;
begin
  tbCheck.Caption := acCheckAfterSelected.Caption;
  tbCheck.Tag  := N5.Tag;        //Передает номер в кнопку и это означает какой вариант проверки

  if N6.Checked then
    N6.Checked := False
  else if nCheckAll.Checked then
         nCheckAll.Checked := False
       else
         N4.Checked := False;

  N5.Checked := True;

  Results.Clear;

  fmProgress.Show;
  Self.Enabled := False;

  fmProgress.pbAllProc.Position := 0;

  Number := Length(Files) - Icons.IndexOf(OldIcon) - 1;

  for z := Icons.IndexOf(OldIcon) + 1 to Length(Files) - 1 do //узнает индек в общем листе данного бланка
  begin
    Results.SetLengthBalls(Results.AmountOfBalls + 1);  //устанавливает длин

    iOutBlank.Picture.LoadFromFile(Files[z].fFile.fName);  //загрузка рисунка

    s := -1;
    NameVar := -1;

    Extend(Files[z].fFile.fName, Files[z].fFile.fNumberPupil, Files[z].fFile.fNumberVar);

    NameVar := Files[z].fFile.fNumberVar; //берет номер варианта

    ToRecErWithCode:  //сюда идет когда чувак загрузит необходимый вариант
    for x := 0 to Variants.AmountOfVariants - 1 do  //проверяет есль ли нужный вариант
      if NameVar = Variants[x].NumberOfVariant then  //если есть, то берем его номер
        begin
          s := x;           //берет его номер
          break;
        end; // if NameVar = Variants[x].NumberOfVariant

    if s = -1 then     //если варианта не было
      begin
        Mistake := IntToStr(NameVar);    //не найден нужный вариант

        //сюда пойдет если чувак при открытии файла нажал отмена
        ShowAgainErWithCode: fmErrors.ShowModal;

        case fmErrors.ModalResult of  //показывает окно
          mrOk:          //если нажал добавить
            begin
              if odOpenCodeWhenEr.Execute then  //диалог открыть
                begin
                  Variants.AddVarFromFile(odOpenCodeWhenEr.Files);  //добавляется новый вариант

                  lvNameaVar.Items.Clear;   //очищается список всех загруженных вариантов

                  for q := 0 to Variants.Count - 1 do  //и заново записывается
                    with lvNameaVar.Items.Add do
                      begin
                        Caption := TakeName(Variants[q].NameFile); //имя файла
                        SubItems.Add(IntToStr(Variants[q].NumberOfVariant)); //номер варианта
                      end;

                  goto ToRecErWithCode;   // идет еще раз на проверку
                end  // if odOpenCodeWhenEr.Execute
              else
                goto ShowAgainErWithCode;  //если в окне открыть нажал отмена
            end; //mrOk
          mrCancel:     //если нажал забыть про этот бланк
            begin
              SetLength(NoFindVars, Length(NoFindVars) + 1);
              NoFindVars[High(NoFindVars)] := NameVar;

              Results.SetLengthBalls(Length(Files) - 1);  //уменьшает кол-во бланков в результате

              continue;                       //берет следующего
            end; //meCancel
        end; // case fmErrors.ModalResult
      end;    //  if s = -1

    Results.Add(Results.AmountOfBalls - 1);    //добавляет еще один бланк
    Results[Results.AmountOfBalls - 1].SetLengthBlank(Variants[s].AmountOfSubjects);//кол-во предметов
    Results[Results.AmountOfBalls - 1].NumberOfVar := Variants[s].NumberOfVariant;  //номер варианта
    Results[Results.AmountOfBalls - 1].NumberOfPupil := Files[z].fFile.fNumberPupil;//номер ученика

    FullSumBalls := 0;

    GoOut := False;

    for f := 0 to iOutBlank.Width do    //ищет границы
    begin
      for n := 0 to iOutBlank.Height do
        if iOutBlank.Canvas.Pixels[f, n] = clBlack then
          begin
            dX := f;
            dY := n;
            GoOut := True;    //чтобы выйти из верхнего фора
            break;
          end; //if iOutBlank.Canvas.Pixels[f, n] = clBlack
      if GoOut then
        break;
    end;// for f := 0 to iOutBlank.Width

    for k := 0 to Variants[s].AmountOfSubjects - 1 do   //будет идти по всем предметам чтобы проверить
    begin
      AmountOfRight := 0;
      fmProgress.pbProgress.Position := 0;

      fmProgress.pbAllProc.Step := Round(fmProgress.pbAllProc.Max / (Variants[s].AmountOfSubjects * Number));
      fmProgress.pbAllProc.Max := fmProgress.pbAllProc.Step * Variants[s].AmountOfSubjects * Number;

      fmProgress.pbAllProc.Position := fmProgress.pbAllProc.Position + fmProgress.pbAllProc.Step;

      for i := 0 to Variants[s].Subjects[k].AmountOfTests - 1 do  //идет по вопросам в каждом предмете
      begin
        fmProgress.lbProgress.Caption := 'Вариант № ' + IntToStr(Variants[s].NumberOfVariant) + '\' + Variants[s].Subjects[k].TitleOfSubject;
        fmProgress.lbProgress.Caption := fmProgress.lbProgress.Caption + '\' + IntToStr(i + 1);

        fmProgress.pbProgress.Step := Round(fmProgress.pbProgress.Max / Variants[s].Subjects[k].AmountOfTests);
        fmProgress.pbProgress.Max := fmProgress.pbProgress.Step * Variants[s].Subjects[k].AmountOfTests;

        fmProgress.pbProgress.Position := fmProgress.pbProgress.Position + fmProgress.pbProgress.Step;

        AmountOfPixels := 0;    //кол-во совпавших пикселей

        for j := Variants[s].Subjects[k].Tests[i].X + dX to Variants[s].Subjects[k].Tests[i].X + dX + Variants[s].Subjects[k].Tests[i].Width do
         for g := Variants[s].Subjects[k].Tests[i].Y + dY to Variants[s].Subjects[k].Tests[i].Y + dY + Variants[s].Subjects[k].Tests[i].Height do
           if iOutBlank.Canvas.Pixels[j, g] = clBlack then
             Inc(AmountOfPixels);   //увеличивает кол-во совпавших пикселей
        if Percent(Variants[s].Subjects[k].Tests[i].Width * Variants[s].Subjects[k].Tests[i].Height, AmountOfPixels) then
          Inc(AmountOfRight);  //если по процентам прошло, то увеличивает кол-во правильных
      end; // for i := 0 to Subjects[k].AmountOfTests - do

      Result.TitleOfSubject := Variants[s].Subjects[k].TitleOfSubject;//записывает название предмета
      Result.AmountOfRight := AmountOfRight;           //кол-во правильных ответов

      FullSumBalls := FullSumBalls + AmountOfRight;    //считает польное кол-во правильных

      Results[Results.AmountOfBalls - 1].SetTitleAndAmountInBalls(k, Result);//записывает результаты в главные результаты по предмету
    end; //  for k := 0 to Subjects.AmountOfSubjects - 1 do

    Results[Results.AmountOfBalls - 1].FullSumBalls := FullSumBalls; //записывает кол-во правильных всего
  end; // for z := 0 to Variants.AmountOfVariants - 1

  Self.Enabled := True;
  Self.SetFocus;
  fmProgress.Close;

  CanSeeResult := True;

  acShowResult.Enabled := True;
end;

procedure TfmCheckerTests.acAboutExecute(Sender: TObject);
begin
  fmAbout.ShowModal;
end;

procedure TfmCheckerTests.acAddVarUpdate(Sender: TObject);
begin
  if acLoadCodes.Enabled then
    acAddVar.Enabled := True
  else
    acAddVar.Enabled := False;
end;

procedure TfmCheckerTests.acRefreshExecute(Sender: TObject);
begin
  DataComponents.adotList.Refresh;
end;

procedure TfmCheckerTests.acEditorCodesExecute(Sender: TObject);
begin
  WinExec('Editor_Of_Codes', SW_SHOWNORMAL)
end;

procedure TfmCheckerTests.FormShow(Sender: TObject);
begin
  if fmLoading.Visible then
    fmLoading.Visible := False;
end;

end.

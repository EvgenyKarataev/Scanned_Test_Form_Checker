unit uComponents;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataComponents = class(TDataModule)
    ADOConnection1: TADOConnection;
    dsList: TDataSource;
    dsClasses: TDataSource;
    adotClasses: TADOTable;
    adotClassesKey1: TAutoIncField;
    adotClassesDSDesigner: TWideStringField;
    adotList: TADOTable;
    adotListKey1: TAutoIncField;
    adotListDSDesigner: TIntegerField;
    adotListDSDesigner2: TWideStringField;
    adotListDSDesigner3: TWideStringField;
    adotListDSDesigner4: TWideStringField;
    adotListDSDesigner5: TIntegerField;
    adotListClass: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataComponents: TDataComponents;

implementation

{$R *.dfm}

end.

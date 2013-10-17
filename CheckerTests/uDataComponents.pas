unit uDataComponents;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataComponents = class(TDataModule)
    ADOConnection1: TADOConnection;
    adotList: TADOTable;
    dsList: TDataSource;
    dcClasses: TDataSource;
    adorClasses: TADOTable;
    adotListKey1: TAutoIncField;
    adotListDSDesigner: TIntegerField;
    adotListSerName: TWideStringField;
    adotListName: TWideStringField;
    adotListDSDesigner4: TWideStringField;
    adotListDSDesigner5: TIntegerField;
    adorClassesKey1: TAutoIncField;
    adorClassesDSDesigner: TWideStringField;
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

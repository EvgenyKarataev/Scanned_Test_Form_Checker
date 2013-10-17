object DataComponents: TDataComponents
  OldCreateOrder = False
  Left = 242
  Top = 325
  Height = 163
  Width = 379
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=Data.' +
      'mdb;Mode=Share Deny None;Extended Properties="";Persist Security' +
      ' Info=False;Jet OLEDB:System database="";Jet OLEDB:Registry Path' +
      '="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;Jet O' +
      'LEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2' +
      ';Jet OLEDB:Global Bulk Transactions=1;Jet OLEDB:New Database Pas' +
      'sword="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encryp' +
      't Database=False;Jet OLEDB:Don'#39't Copy Locale on Compact=False;Je' +
      't OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 16
  end
  object dsList: TDataSource
    DataSet = adotList
    Left = 120
    Top = 16
  end
  object dsClasses: TDataSource
    DataSet = adotClasses
    Left = 192
    Top = 16
  end
  object adotClasses: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = #1057#1087#1080#1089#1086#1082' '#1082#1083#1072#1089#1089#1086#1074
    Left = 192
    Top = 72
    object adotClassesKey1: TAutoIncField
      FieldName = 'Key1'
      ReadOnly = True
      Visible = False
    end
    object adotClassesDSDesigner: TWideStringField
      FieldName = #1050#1083#1072#1089#1089
    end
  end
  object adotList: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = #1057#1087#1080#1089#1086#1082
    Left = 120
    Top = 72
    object adotListKey1: TAutoIncField
      FieldName = 'Key1'
      ReadOnly = True
      Visible = False
    end
    object adotListDSDesigner: TIntegerField
      FieldName = #1050#1083#1072#1089#1089
      Visible = False
    end
    object adotListClass: TStringField
      DisplayLabel = #1050#1083#1072#1089#1089
      DisplayWidth = 10
      FieldKind = fkLookup
      FieldName = 'Class'
      LookupDataSet = adotClasses
      LookupKeyFields = 'Key1'
      LookupResultField = #1050#1083#1072#1089#1089
      KeyFields = #1050#1083#1072#1089#1089
      Lookup = True
    end
    object adotListDSDesigner2: TWideStringField
      DisplayWidth = 25
      FieldName = #1060#1072#1084#1080#1083#1080#1103
      Size = 50
    end
    object adotListDSDesigner3: TWideStringField
      DisplayWidth = 15
      FieldName = #1048#1084#1103
      Size = 50
    end
    object adotListDSDesigner4: TWideStringField
      DisplayWidth = 25
      FieldName = #1054#1090#1095#1077#1089#1090#1074#1086
      Size = 50
    end
    object adotListDSDesigner5: TIntegerField
      ConstraintErrorMessage = #1053#1086#1084#1077#1088' '#1091#1095#1077#1085#1080#1082#1072' '#1086#1073#1103#1079#1072#1090#1077#1083#1077#1085
      FieldName = #1053#1086#1084#1077#1088
    end
  end
end

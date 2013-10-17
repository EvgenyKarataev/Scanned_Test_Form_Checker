object DataComponents: TDataComponents
  OldCreateOrder = False
  Left = 207
  Top = 114
  Height = 173
  Width = 320
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Data\Data.mdb;Persi' +
      'st Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 16
  end
  object adotList: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = #1057#1087#1080#1089#1086#1082
    Left = 112
    Top = 80
    object adotListKey1: TAutoIncField
      FieldName = 'Key1'
      ReadOnly = True
      Visible = False
    end
    object adotListDSDesigner: TIntegerField
      FieldName = #1050#1083#1072#1089#1089
    end
    object adotListClass: TStringField
      FieldKind = fkLookup
      FieldName = 'Class'
      LookupDataSet = adorClasses
      LookupKeyFields = 'Key1'
      LookupResultField = #1050#1083#1072#1089#1089
      KeyFields = #1050#1083#1072#1089#1089
      Lookup = True
    end
    object adotListSerName: TWideStringField
      DisplayWidth = 25
      FieldName = #1060#1072#1084#1080#1083#1080#1103
      Size = 50
    end
    object adotListName: TWideStringField
      DisplayWidth = 25
      FieldName = #1048#1084#1103
      Size = 50
    end
    object adotListDSDesigner4: TWideStringField
      DisplayWidth = 25
      FieldName = #1054#1090#1095#1077#1089#1090#1074#1086
      Size = 50
    end
    object adotListDSDesigner5: TIntegerField
      FieldName = #1053#1086#1084#1077#1088
    end
  end
  object dsList: TDataSource
    DataSet = adotList
    Left = 112
    Top = 16
  end
  object dcClasses: TDataSource
    Left = 184
    Top = 16
  end
  object adorClasses: TADOTable
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    TableName = #1057#1087#1080#1089#1086#1082' '#1082#1083#1072#1089#1089#1086#1074
    Left = 184
    Top = 80
    object adorClassesKey1: TAutoIncField
      FieldName = 'Key1'
      ReadOnly = True
      Visible = False
    end
    object adorClassesDSDesigner: TWideStringField
      FieldName = #1050#1083#1072#1089#1089
    end
  end
end

object fmView: TfmView
  Left = 277
  Top = 302
  BorderStyle = bsDialog
  Caption = #1042#1080#1076' - '#1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 439
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcOptions: TPageControl
    Left = 0
    Top = 0
    Width = 421
    Height = 439
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1064#1088#1080#1092#1090' '#1080' '#1094#1074#1077#1090
      object gbFount: TGroupBox
        Left = 8
        Top = 8
        Width = 401
        Height = 169
        Caption = #1064#1088#1080#1092#1090' '#1076#1083#1103' '#1094#1080#1092#1088
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 24
          Width = 37
          Height = 13
          Caption = #1064#1088#1080#1092#1090':'
        end
        object Label3: TLabel
          Left = 184
          Top = 24
          Width = 63
          Height = 13
          Caption = #1053#1072#1095#1077#1088#1090#1072#1085#1080#1077':'
        end
        object Label4: TLabel
          Left = 325
          Top = 24
          Width = 42
          Height = 13
          Caption = #1056#1072#1079#1084#1077#1088':'
        end
        object lbName: TListBox
          Left = 8
          Top = 64
          Width = 169
          Height = 97
          ItemHeight = 13
          Items.Strings = (
            'Arial'
            'Courier New'
            'Tahoma'
            'Times New Roman')
          TabOrder = 0
          OnClick = lbNameClick
        end
        object edName: TEdit
          Left = 8
          Top = 40
          Width = 169
          Height = 21
          TabOrder = 1
          OnChange = edNameChange
          OnKeyDown = edNameKeyDown
          OnKeyUp = edNameKeyUp
        end
        object edStyle: TEdit
          Left = 184
          Top = 40
          Width = 121
          Height = 21
          TabOrder = 2
          OnChange = edStyleChange
          OnKeyDown = edStyleKeyDown
          OnKeyUp = edStyleKeyUp
        end
        object lbStyle: TListBox
          Left = 184
          Top = 64
          Width = 121
          Height = 97
          ItemHeight = 13
          Items.Strings = (
            #1086#1073#1099#1095#1085#1099#1081
            #1082#1091#1088#1089#1080#1074
            #1078#1080#1088#1085#1099#1081
            #1078#1080#1088#1085#1099#1081' '#1082#1091#1088#1089#1080#1074)
          TabOrder = 3
          OnClick = lbStyleClick
        end
      end
      object GroupBox1: TGroupBox
        Left = 8
        Top = 184
        Width = 401
        Height = 49
        Caption = #1053#1086#1084#1077#1088#1072' '#1074#1086#1087#1088#1086#1089#1086#1074
        TabOrder = 1
        object lbColor: TLabel
          Left = 8
          Top = 24
          Width = 28
          Height = 13
          Caption = #1062#1074#1077#1090':'
        end
        object cbColor: TColorBox
          Left = 40
          Top = 20
          Width = 145
          Height = 22
          DefaultColorColor = clTeal
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 0
        end
        object cbShowNumber: TCheckBox
          Left = 216
          Top = 24
          Width = 177
          Height = 17
          Caption = #1055#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1085#1086#1084#1077#1088#1072' '#1074#1086#1087#1088#1086#1089#1086#1074
          TabOrder = 1
        end
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 240
        Width = 401
        Height = 73
        Caption = #1062#1074#1077#1090' '#1076#1083#1103' '#1074#1072#1088#1080#1072#1085#1090#1086#1074' '#1086#1090#1074#1077#1090#1072
        TabOrder = 2
        object lbDelColor: TLabel
          Left = 8
          Top = 24
          Width = 162
          Height = 13
          Caption = #1053#1077#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1074#1072#1088#1080#1072#1085#1090' '#1086#1090#1074#1077#1090#1072':'
        end
        object lbSetColor: TLabel
          Left = 8
          Top = 48
          Width = 149
          Height = 13
          Caption = #1042#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1074#1072#1088#1080#1072#1085#1090' '#1086#1090#1074#1077#1090#1072':'
        end
        object cbDefColor: TColorBox
          Left = 176
          Top = 20
          Width = 145
          Height = 22
          DefaultColorColor = clMoneyGreen
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 0
        end
        object cbSelColor: TColorBox
          Left = 176
          Top = 45
          Width = 145
          Height = 22
          DefaultColorColor = clSkyBlue
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 1
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 320
        Width = 401
        Height = 49
        Caption = #1062#1074#1090#1077' '#1087#1088#1077#1076#1084#1077#1090#1072
        TabOrder = 3
        object Label1: TLabel
          Left = 8
          Top = 24
          Width = 114
          Height = 13
          Caption = #1042#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1087#1088#1077#1076#1084#1077#1090':'
        end
        object cbSelSub: TColorBox
          Left = 176
          Top = 20
          Width = 145
          Height = 22
          DefaultColorColor = clYellow
          Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbIncludeDefault, cbCustomColor, cbPrettyNames]
          ItemHeight = 16
          TabOrder = 0
        end
      end
      object bDef: TButton
        Left = 8
        Top = 376
        Width = 193
        Height = 25
        Caption = #1062#1074#1077#1090#1072' '#1080' '#1096#1088#1080#1092#1090' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        TabOrder = 4
        OnClick = bDefClick
      end
      object bbOk: TBitBtn
        Left = 240
        Top = 376
        Width = 75
        Height = 25
        TabOrder = 5
        Kind = bkOK
      end
      object bbCancel: TBitBtn
        Left = 328
        Top = 376
        Width = 75
        Height = 25
        TabOrder = 6
        Kind = bkCancel
      end
    end
  end
  object edSize: TEdit
    Left = 336
    Top = 72
    Width = 65
    Height = 21
    TabOrder = 1
    OnChange = edSizeChange
    OnKeyDown = edSizeKeyDown
    OnKeyUp = edSizeKeyUp
  end
  object lbSize: TListBox
    Left = 336
    Top = 96
    Width = 65
    Height = 97
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    Items.Strings = (
      '7'
      '8'
      '10'
      '14'
      '18'
      '24')
    ParentFont = False
    TabOrder = 2
    OnClick = lbSizeClick
  end
end

object fmListOfSubjects: TfmListOfSubjects
  Left = 449
  Top = 329
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1055#1088#1077#1076#1084#1077#1090#1099' '#1074' '#1092#1072#1081#1083#1077
  ClientHeight = 253
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 431
    Height = 253
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 245
      Height = 13
      Caption = #1042' '#1042#1072#1096#1077#1084' '#1092#1072#1081#1083#1077' '#1085#1072#1081#1076#1077#1085#1099' '#1089#1083#1077#1076#1091#1102#1097#1080#1077' '#1087#1088#1077#1076#1084#1077#1090#1099':'
      Transparent = True
    end
    object Label2: TLabel
      Left = 8
      Top = 152
      Width = 321
      Height = 13
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1099#1077' '#1042#1072#1084' '#1087#1088#1077#1076#1084#1077#1090#1099' '#1080' '#1085#1072#1078#1076#1084#1080#1090#1077' '#1082#1085#1086#1087#1082#1091' '#1054#1082','
      Transparent = True
    end
    object Label3: TLabel
      Left = 8
      Top = 168
      Width = 154
      Height = 13
      Caption = #1095#1090#1086#1073#1099' '#1076#1086#1073#1072#1074#1080#1090#1100' '#1101#1090#1080' '#1087#1088#1077#1076#1084#1077#1090#1099
      Transparent = True
    end
    object clbListOfSubjects: TCheckListBox
      Left = 8
      Top = 24
      Width = 409
      Height = 121
      ItemHeight = 13
      TabOrder = 0
      OnClick = clbListOfSubjectsClick
    end
    object bbSelAllSubjects: TBitBtn
      Left = 8
      Top = 192
      Width = 161
      Height = 25
      Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077' '#1087#1088#1077#1076#1084#1077#1090#1099
      TabOrder = 1
      OnClick = bbSelAllSubjectsClick
    end
    object bbOk: TBitBtn
      Left = 192
      Top = 224
      Width = 97
      Height = 25
      TabOrder = 2
      Kind = bkOK
    end
    object bbCancel: TBitBtn
      Left = 320
      Top = 224
      Width = 91
      Height = 25
      TabOrder = 3
      Kind = bkCancel
    end
    object bbDelSelAllSubjects: TBitBtn
      Left = 192
      Top = 192
      Width = 217
      Height = 25
      Caption = #1059#1073#1088#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077' '#1087#1088#1077#1076#1084#1077#1090#1086#1074
      Enabled = False
      TabOrder = 4
      OnClick = bbDelSelAllSubjectsClick
    end
  end
end

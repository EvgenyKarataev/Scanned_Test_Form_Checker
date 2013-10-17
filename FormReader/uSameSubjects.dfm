object fmSameSub: TfmSameSub
  Left = 336
  Top = 234
  BorderStyle = bsDialog
  Caption = #1054#1076#1080#1085#1072#1082#1086#1074#1099#1077' '#1087#1088#1077#1076#1084#1077#1090#1099
  ClientHeight = 107
  ClientWidth = 533
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 533
    Height = 107
    Align = alClient
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 168
      Height = 13
      Caption = #1053#1072#1081#1076#1077#1085#1099' '#1086#1076#1080#1085#1072#1082#1086#1074#1099#1077' '#1087#1088#1077#1076#1084#1077#1090#1099':'
    end
    object lbSameSub: TLabel
      Left = 184
      Top = 16
      Width = 54
      Height = 13
      Caption = 'lbSameSub'
      Transparent = True
    end
    object bbDelOld: TBitBtn
      Left = 8
      Top = 72
      Width = 121
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1089#1090#1072#1088#1099#1081
      TabOrder = 0
      Kind = bkAbort
    end
    object bbRename: TBitBtn
      Left = 136
      Top = 72
      Width = 153
      Height = 25
      Caption = #1055#1077#1088#1077#1080#1084#1077#1085#1086#1074#1072#1090#1100' '#1089#1090#1072#1088#1099#1081
      TabOrder = 1
      Kind = bkRetry
    end
    object bbCancel: TBitBtn
      Left = 440
      Top = 72
      Width = 81
      Height = 25
      Caption = #1055#1088#1077#1088#1074#1072#1090#1100
      TabOrder = 2
      Kind = bkCancel
    end
    object bbIgnoreActive: TBitBtn
      Left = 296
      Top = 72
      Width = 137
      Height = 25
      Caption = #1055#1088#1086#1087#1091#1089#1090#1080#1090#1100' '#1090#1077#1082#1091#1097#1080#1081
      TabOrder = 3
      Kind = bkIgnore
    end
  end
end

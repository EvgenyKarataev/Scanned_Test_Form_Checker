object fmPas: TfmPas
  Left = 385
  Top = 302
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1087#1072#1088#1086#1083#1103
  ClientHeight = 109
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 81
    Height = 13
    Caption = #1042#1074#1077#1076#1080#1090#1077' '#1087#1072#1088#1086#1083#1100
  end
  object edPas: TEdit
    Left = 40
    Top = 32
    Width = 169
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  object bbOk: TBitBtn
    Left = 40
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 1
    OnClick = bbOkClick
    Kind = bkOK
  end
  object bbCancel: TBitBtn
    Left = 136
    Top = 72
    Width = 75
    Height = 25
    TabOrder = 2
    Kind = bkCancel
  end
end

object fmProgress: TfmProgress
  Left = 458
  Top = 289
  AutoSize = True
  BorderStyle = bsNone
  Caption = #1048#1085#1076#1080#1082#1072#1090#1086#1088' '#1087#1088#1086#1094#1077#1089#1089#1072
  ClientHeight = 137
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 457
    Height = 137
    TabOrder = 0
    object lbProgress: TLabel
      Left = 24
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Progress'
      Transparent = True
    end
    object pbProgress: TProgressBar
      Left = 32
      Top = 40
      Width = 409
      Height = 17
      TabOrder = 0
    end
    object pbAllProc: TProgressBar
      Left = 32
      Top = 80
      Width = 409
      Height = 17
      TabOrder = 1
    end
  end
end

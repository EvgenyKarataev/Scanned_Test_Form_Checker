object fmErrors: TfmErrors
  Left = 329
  Top = 187
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1053#1077' '#1085#1072#1081#1076#1077#1085' '#1085#1091#1078#1085#1099#1081' '#1074#1072#1088#1080#1072#1085#1090
  ClientHeight = 153
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pcErrors: TPageControl
    Left = 0
    Top = 0
    Width = 377
    Height = 153
    ActivePage = tsErWithCode
    TabOrder = 0
    object tsErWithCode: TTabSheet
      Caption = #1054#1096#1080#1073#1082#1072' '#1089' '#1082#1086#1076#1072#1084#1080
      ImageIndex = 1
      object lbTitleWithCode: TLabel
        Left = 8
        Top = 8
        Width = 169
        Height = 13
        Caption = #1053#1077' '#1085#1072#1081#1076#1077#1085#1099' '#1089#1083#1077#1076#1091#1102#1097#1080#1081' '#1074#1072#1088#1080#1072#1085#1090':'
      end
      object lb1WithCode: TLabel
        Left = 8
        Top = 56
        Width = 313
        Height = 13
        Caption = #1063#1090#1086#1073#1099' '#1087#1088#1086#1074#1077#1088#1080#1090#1100' '#1101#1090#1086#1090' '#1074#1072#1088#1072#1085#1090', '#1085#1072#1078#1084#1080#1090#1077' "'#1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1072#1088#1080#1072#1085#1090'" '
      end
      object lb2WithCode: TLabel
        Left = 8
        Top = 72
        Width = 172
        Height = 13
        Caption = #1080' '#1076#1086#1073#1072#1074#1100#1090#1077' '#1085#1077#1086#1073#1093#1086#1076#1080#1084#1099#1081' '#1074#1072#1088#1080#1072#1085#1090
      end
      object lbListOfEr: TListBox
        Left = 8
        Top = 32
        Width = 353
        Height = 17
        ItemHeight = 13
        TabOrder = 0
      end
      object bbAddVar: TBitBtn
        Left = 16
        Top = 96
        Width = 145
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074#1072#1088#1080#1072#1085#1090
        TabOrder = 1
        Kind = bkOK
      end
      object bbOutWithCode: TBitBtn
        Left = 184
        Top = 96
        Width = 177
        Height = 25
        Caption = #1047#1072#1073#1099#1090#1100' '#1087#1088#1086' '#1101#1090#1086#1090' '#1074#1072#1088#1080#1072#1085#1090
        TabOrder = 2
        Kind = bkCancel
      end
    end
  end
end

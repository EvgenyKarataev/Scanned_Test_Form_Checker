object fmResult: TfmResult
  Left = 414
  Top = 291
  Width = 358
  Height = 203
  AutoSize = True
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090' '#1087#1088#1086#1074#1077#1088#1082#1080
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 350
    Height = 169
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1082#1080' '#1086#1090#1095#1077#1090#1072
      object bbOk: TBitBtn
        Left = 128
        Top = 108
        Width = 75
        Height = 25
        TabOrder = 0
        OnClick = bbOkClick
        Kind = bkOK
      end
      object rbSort: TRadioGroup
        Left = 8
        Top = 8
        Width = 329
        Height = 81
        Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '
        ItemIndex = 1
        Items.Strings = (
          #1087#1086' '#1060#1048#1054
          #1087#1086' '#1073#1072#1083#1083#1072#1084)
        TabOrder = 1
        OnClick = rbSortClick
      end
      object cbFIO: TComboBox
        Left = 104
        Top = 24
        Width = 193
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        ItemIndex = 1
        Sorted = True
        TabOrder = 2
        Text = #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1072#1083#1092#1072#1074#1080#1090#1091
        Items.Strings = (
          #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1086#1073#1088#1072#1090#1085#1086#1084' '#1087#1086#1088#1103#1076#1082#1077
          #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1072#1083#1092#1072#1074#1080#1090#1091)
      end
      object cbBalls: TComboBox
        Left = 104
        Top = 56
        Width = 193
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 1
        Sorted = True
        TabOrder = 3
        Text = #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1091#1073#1099#1074#1072#1085#1080#1102
        Items.Strings = (
          #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1074#1086#1079#1088#1072#1089#1090#1072#1085#1080#1102
          #1089#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1091#1073#1099#1074#1072#1085#1080#1102)
      end
    end
  end
end

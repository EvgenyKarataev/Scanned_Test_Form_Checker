object fmErrorWithBlank: TfmErrorWithBlank
  Left = 363
  Top = 485
  AutoSize = True
  BorderStyle = bsDialog
  Caption = #1054#1096#1080#1073#1082#1072' '#1074' '#1085#1072#1079#1074#1072#1085#1080#1080' '#1092#1072#1081#1083#1072
  ClientHeight = 153
  ClientWidth = 361
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
    Width = 361
    Height = 153
    ActivePage = tsErWithBlank
    TabOrder = 0
    object tsErWithBlank: TTabSheet
      Caption = #1054#1096#1080#1073#1082#1072' '#1089'  '#1073#1083#1072#1085#1082#1072#1084#1080
      object lbTitleWithBlank: TLabel
        Left = 8
        Top = 8
        Width = 163
        Height = 13
        Caption = #1053#1077#1087#1088#1072#1074#1080#1083#1100#1085#1086#1077' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1072':'
      end
      object lb1WithBlank: TLabel
        Left = 8
        Top = 56
        Width = 318
        Height = 13
        Caption = #1063#1090#1086#1073#1099' '#1080#1089#1087#1088#1072#1074#1080#1090#1100' '#1101#1090#1091' '#1086#1096#1080#1073#1082#1091', '#1085#1072#1079#1086#1074#1080#1090#1077' '#1087#1088#1072#1074#1080#1083#1100#1085#1086' '#1101#1090#1086#1090' '#1092#1072#1081#1083', '
      end
      object lb2WithBlank: TLabel
        Left = 8
        Top = 72
        Width = 225
        Height = 13
        Caption = #1072' '#1079#1072#1090#1077#1084' '#1085#1072#1078#1084#1080#1090#1077' '#1082#1085#1086#1087#1082#1091' "'#1044#1086#1073#1072#1074#1080#1090#1100' '#1073#1083#1072#1085#1082'".'
      end
      object lbErWithBlank: TListBox
        Left = 8
        Top = 32
        Width = 337
        Height = 17
        ItemHeight = 13
        TabOrder = 0
      end
      object bbAddBlank: TBitBtn
        Left = 8
        Top = 96
        Width = 137
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1073#1083#1072#1085#1082
        Default = True
        ModalResult = 1
        TabOrder = 1
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
      object bbOutWithBlank: TBitBtn
        Left = 176
        Top = 96
        Width = 169
        Height = 25
        Caption = #1047#1072#1073#1099#1090#1100' '#1087#1088#1086' '#1101#1090#1086#1090' '#1073#1083#1072#1085#1082
        TabOrder = 2
        Kind = bkCancel
      end
    end
  end
end

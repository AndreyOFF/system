object Form3: TForm3
  Left = 514
  Top = 394
  Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077'_'#1087#1088#1077#1076#1084#1077#1090#1085#1099#1093'_'#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1081'_'#1084#1086#1076#1077#1083#1080
  ClientHeight = 165
  ClientWidth = 409
  Color = clSilver
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Выбор_ТЗ: TButton
    Left = 66
    Top = 112
    Width = 247
    Height = 30
    Caption = #1042#1074#1086#1076' '#1090#1072#1073#1083#1080#1095#1085#1099#1093' '#1076#1072#1085#1085#1099#1093' '#1058#1047
    TabOrder = 0
    OnClick = Выбор_ТЗClick
  end
  object Ввод_блок_схем_по_картинке: TButton
    Left = 66
    Top = 18
    Width = 247
    Height = 32
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = #1047#1072#1087#1080#1089#1100' '#1073#1083#1086#1082'-'#1089#1093#1077#1084' '#1085#1072' '#1103#1079#1099#1082#1077' '#1043#1077#1088#1072#1082#1083' '
    TabOrder = 1
    OnClick = Ввод_блок_схем_по_картинкеClick
  end
  object Алгоритмы_Visio_Геракл: TButton
    Left = 66
    Top = 66
    Width = 247
    Height = 29
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077' '#1073#1083#1086#1082'-'#1089#1093#1077#1084' '#1085#1072' '#1103#1079#1099#1082' '#1043#1077#1088#1072#1082#1083
    TabOrder = 2
    OnClick = Алгоритмы_Visio_ГераклClick
  end
  object OpenDialog1: TOpenDialog
    Left = 216
    Top = 176
  end
  object OpenDialog2: TOpenDialog
    Left = 304
    Top = 176
  end
end

object Sintez: TSintez
  Left = 0
  Top = 0
  Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077'_'#1087#1088#1086#1075#1088#1072#1084#1084#1085#1099#1093'_'#1082#1086#1085#1089#1090#1088#1091#1082#1094#1080#1081'_'#1084#1086#1076#1077#1083#1080
  ClientHeight = 67
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Функции_Кнопка: TButton
    Left = 134
    Top = 16
    Width = 75
    Height = 25
    Caption = #1060#1091#1085#1082#1094#1080#1080
    TabOrder = 0
    OnClick = Функции_КнопкаClick
  end
  object Алгоритмы_: TButton
    Left = 25
    Top = 16
    Width = 81
    Height = 25
    Caption = #1040#1083#1075#1086#1088#1080#1090#1084#1099
    TabOrder = 1
    OnClick = Алгоритмы_Click
  end
  object Команды_: TButton
    Left = 348
    Top = 16
    Width = 75
    Height = 25
    Caption = #1050#1086#1084#1072#1085#1076#1099
    TabOrder = 2
    OnClick = Команды_Click
  end
  object Входы_: TButton
    Left = 453
    Top = 16
    Width = 75
    Height = 25
    Caption = #1042#1093#1086#1076#1099
    TabOrder = 3
    OnClick = Входы_Click
  end
  object Таймеры_: TButton
    Left = 232
    Top = 16
    Width = 81
    Height = 25
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = #1058#1072#1081#1084#1077#1088#1099
    TabOrder = 4
    OnClick = Таймеры_Click
  end
end

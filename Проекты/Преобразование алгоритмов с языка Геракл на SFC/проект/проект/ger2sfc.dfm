object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Gerakl to SFC Converter'
  ClientHeight = 362
  ClientWidth = 557
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 8
    Width = 238
    Height = 13
    Caption = #1060#1072#1081#1083' '#1089' '#1086#1087#1080#1089#1072#1085#1080#1077#1084' '#1072#1083#1075#1086#1088#1080#1090#1084#1072' '#1085#1072' '#1103#1079#1099#1082#1077' '#1043#1077#1088#1072#1082#1083':'
  end
  object Edit1: TEdit
    Left = 8
    Top = 27
    Width = 458
    Height = 21
    TabOrder = 0
  end
  object Button1: TButton
    Left = 472
    Top = 25
    Width = 75
    Height = 25
    Caption = #1054#1073#1079#1086#1088
    TabOrder = 1
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 56
    Width = 539
    Height = 265
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Button2: TButton
    Left = 8
    Top = 329
    Width = 539
    Height = 25
    Caption = #1055#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077'_'#1072#1083#1075#1086#1088#1080#1090#1084#1072
    TabOrder = 3
    OnClick = Button2Click
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 520
    Top = 312
  end
end

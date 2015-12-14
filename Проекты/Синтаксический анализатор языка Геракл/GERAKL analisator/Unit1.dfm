object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1043#1045#1056#1040#1050#1051' '#1089#1080#1085#1090#1072#1082#1089#1080#1089' '#1072#1085#1072#1083#1080#1079#1072#1090#1086#1088
  ClientHeight = 421
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 248
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Read'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 248
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 1
    OnClick = Button2Click
  end
  object RichEdit1: TRichEdit
    Left = 8
    Top = 8
    Width = 217
    Height = 409
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
    OnChange = richeditchange
    OnKeyUp = richedit1keyup
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 424
    Top = 8
  end
end

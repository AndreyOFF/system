object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Find and exec app'
  ClientHeight = 300
  ClientWidth = 555
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 16
    Top = 24
    Width = 137
    Height = 21
    TabOrder = 0
    Text = '*.txt'
  end
  object Edit2: TEdit
    Left = 159
    Top = 24
    Width = 154
    Height = 21
    ReadOnly = True
    TabOrder = 1
  end
  object Button1: TButton
    Left = 319
    Top = 20
    Width = 98
    Height = 25
    Caption = 'Find'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 16
    Top = 51
    Width = 521
    Height = 230
    ItemHeight = 13
    TabOrder = 3
  end
  object Button2: TButton
    Left = 423
    Top = 20
    Width = 114
    Height = 25
    Caption = 'Exec'
    TabOrder = 4
    OnClick = Button2Click
  end
end

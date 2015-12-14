object Form1: TForm1
  Left = 0
  Top = 0
  Width = 477
  Height = 417
  AutoScroll = True
  Caption = #1057#1080#1085#1090#1072#1082#1089#1080#1095#1077#1089#1082#1080#1081' '#1072#1085#1072#1083#1080#1079#1072#1090#1086#1088' '#1103#1079#1099#1082#1072' '#1043#1077#1088#1072#1082#1083
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
  object Label1: TLabel
    Left = 8
    Top = 214
    Width = 337
    Height = 13
    Caption = #1055#1088#1086#1074#1077#1088#1082#1072' '#1092#1072#1081#1083#1072' '#1085#1072' '#1103#1079#1099#1082#1077' '#1043#1077#1088#1072#1082#1083' '#1085#1072' '#1085#1072#1083#1080#1095#1080#1077' '#1086#1096#1080#1073#1086#1082' '#1089#1080#1085#1090#1072#1082#1089#1080#1089#1072':'
  end
  object btnOpenFile: TButton
    Left = 364
    Top = 4
    Width = 93
    Height = 21
    Caption = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083
    TabOrder = 0
    OnClick = btnOpenFileClick
  end
  object mTextFromFile: TMemo
    Left = 8
    Top = 31
    Width = 350
    Height = 177
    Lines.Strings = (
      'mTextFromFile')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object edTextFilePath: TEdit
    Left = 8
    Top = 4
    Width = 350
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 364
    Top = 184
    Width = 93
    Height = 24
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1092#1072#1081#1083
    TabOrder = 3
    OnClick = Button1Click
  end
  object mErrors: TMemo
    Left = 8
    Top = 233
    Width = 445
    Height = 112
    Lines.Strings = (
      'mErrors')
    ReadOnly = True
    TabOrder = 4
  end
  object btnGo: TButton
    Left = 378
    Top = 351
    Width = 75
    Height = 25
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
    TabOrder = 5
    OnClick = btnGoClick
  end
  object btnClear: TButton
    Left = 283
    Top = 351
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 6
    OnClick = btnClearClick
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 392
    Top = 32
  end
  object SaveTextFileDialog1: TSaveTextFileDialog
    Left = 392
    Top = 88
  end
end

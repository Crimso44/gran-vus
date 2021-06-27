object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Fix'
  ClientHeight = 282
  ClientWidth = 418
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
    Left = 184
    Top = 152
    Width = 75
    Height = 25
    Caption = #1048#1089#1087#1088#1072#1074#1080#1090#1100'!'
    TabOrder = 0
    OnClick = Button1Click
  end
  object dbMain: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;User ID=sa;Initial Catalog=GranVus2_x;Data Source=(loca' +
      'l)'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 80
    Top = 36
  end
  object Query: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      
        'if (SELECT length FROM syscolumns WHERE NAME = '#39'KODOKTMO'#39' AND OB' +
        'JECT_NAME(id) = '#39'ORG'#39') <> 20'
      #9'alter table org alter column KODOKTMO varchar(20) ')
    Left = 192
    Top = 56
  end
  object Query2: TADOQuery
    Connection = dbMain
    Parameters = <>
    SQL.Strings = (
      
        'if (SELECT length FROM syscolumns WHERE NAME = '#39'KODOKTMO2'#39' AND O' +
        'BJECT_NAME(id) = '#39'ORG'#39') <> 20'
      #9'alter table org alter column KODOKTMO2 varchar(20) ')
    Left = 264
    Top = 56
  end
end

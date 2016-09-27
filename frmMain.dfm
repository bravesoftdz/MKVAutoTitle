object formMain: TformMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'MKV Auto Title v0.1'
  ClientHeight = 167
  ClientWidth = 476
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblWorkDir: TLabel
    Left = 12
    Top = 8
    Width = 85
    Height = 13
    Caption = 'Working directory'
  end
  object lblMkvEditPath: TLabel
    Left = 12
    Top = 53
    Width = 79
    Height = 13
    Caption = 'MKVToolnix path'
  end
  object edWorkDir: TJvDirectoryEdit
    Left = 8
    Top = 26
    Width = 457
    Height = 21
    DialogKind = dkWin32
    DirectInput = False
    ReadOnly = True
    TabOrder = 0
    OnChange = edWorkDirChange
  end
  object edMkvEditDir: TJvDirectoryEdit
    Left = 8
    Top = 69
    Width = 457
    Height = 21
    DialogKind = dkWin32
    DirectInput = False
    ReadOnly = True
    TabOrder = 1
    OnChange = edMkvEditDirChange
  end
  object btnStart: TButton
    Left = 390
    Top = 111
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 2
    OnClick = btnStartClick
  end
  object objStatusBar: TStatusBar
    Left = 0
    Top = 148
    Width = 476
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 146
  end
end

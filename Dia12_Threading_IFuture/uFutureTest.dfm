object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 460
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 193
    Height = 145
    Caption = 'IFuture'
    TabOrder = 0
    object Label1: TLabel
      Left = 17
      Top = 27
      Width = 145
      Height = 39
      Caption = 'Executa em paralelo e aguarda resposta ap'#243's finlizar o processo'
      WordWrap = True
    end
    object Button1: TButton
      Left = 17
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Boolean'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 101
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Attributo'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 168
    Width = 193
    Height = 57
    Caption = 'ITask'
    TabOrder = 1
    object Button3: TButton
      Left = 8
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Execute'
      TabOrder = 0
      OnClick = Button3Click
    end
    object Button6: TButton
      Left = 89
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Wait Any'
      TabOrder = 1
      OnClick = Button6Click
    end
  end
  object Memo1: TMemo
    Left = 207
    Top = 8
    Width = 232
    Height = 257
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 231
    Width = 193
    Height = 122
    Caption = 'Thread'
    TabOrder = 3
    object Button4: TButton
      Left = 17
      Top = 17
      Width = 104
      Height = 25
      Caption = 'GUI Syncronize'
      TabOrder = 0
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 17
      Top = 48
      Width = 104
      Height = 25
      Caption = 'Anonimous'
      TabOrder = 1
      OnClick = Button5Click
    end
    object Button7: TButton
      Left = 17
      Top = 79
      Width = 104
      Height = 25
      Caption = 'Parallel FOR'
      TabOrder = 2
      OnClick = Button7Click
    end
  end
  object Button8: TButton
    Left = 296
    Top = 328
    Width = 75
    Height = 25
    Caption = 'Todos'
    TabOrder = 4
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 8
    Top = 384
    Width = 164
    Height = 25
    Caption = 'Debug Parallel'
    TabOrder = 5
    OnClick = Button9Click
  end
end

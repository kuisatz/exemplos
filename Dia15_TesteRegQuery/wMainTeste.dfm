object Form6: TForm6
  Left = 0
  Top = 0
  Caption = 'Form6'
  ClientHeight = 493
  ClientWidth = 729
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object JvDBGrid1: TJvDBGrid
    Left = 16
    Top = 64
    Width = 705
    Height = 361
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    SelectColumnsDialogStrings.Caption = 'Select columns'
    SelectColumnsDialogStrings.OK = '&OK'
    SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
    EditControls = <>
    RowsHeight = 17
    TitleRowHeight = 17
  end
  object DBNav981: TDBNav98
    Left = 8
    Top = 8
    Width = 713
    Height = 41
    Cursor = crHandPoint
    TabOrder = 1
    Caption = ' '
    BtnAlign = alNone
    Flat = True
    DataSource = DataSource1
    DisableMsgDelete = False
    Position = alNone
    KeepFilter = False
  end
  object ALQuery1: TALQuery
    CachedUpdates = True
    Databasename = 'db'
    RequestLive = False
    SQL.Strings = (
      'Select * From ctgrupo Order by nome')
    UpdateMode = upWhereKeyOnly
    AfterPost = ALQuery1AfterPost
    SQLFields = '*'
    SQLDBFile = 'ctgrupo'
    SQLOrderBy = 'nome'
    NewRecno = True
    Left = 240
    Top = 256
  end
  object DataSource1: TDataSource
    DataSet = ALQuery1
    Left = 400
    Top = 256
  end
  object StdRegQuery1: TStdRegQuery
    AutoTrans = False
    AutoApply = False
    OnAfterPost = StdRegQuery1AfterPost
    Left = 272
    Top = 160
  end
end

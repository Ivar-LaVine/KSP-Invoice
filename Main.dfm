object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 409
  ClientWidth = 791
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 137
    Width = 6
    Height = 13
    Caption = 'X'
  end
  object Label2: TLabel
    Left = 12
    Top = 164
    Width = 6
    Height = 13
    Caption = 'Y'
  end
  object Label3: TLabel
    Left = 12
    Top = 191
    Width = 6
    Height = 13
    Caption = 'Z'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 320
    Height = 120
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'INV_ID'
        Title.Caption = #1053#1086#1084#1077#1088' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DATE_INV'
        Title.Caption = #1044#1072#1090#1072' '#1085#1072#1082#1083#1072#1076#1085#1086#1081
        Width = 100
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 334
    Top = 8
    Width = 281
    Height = 120
    DataSource = DataSource2
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NAME'
        Title.Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'COUNT_PRD'
        Title.Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRICE'
        Title.Alignment = taRightJustify
        Title.Caption = #1062#1077#1085#1072' '#1079#1072' '#1096#1090'.'
        Width = 75
        Visible = True
      end>
  end
  object DBGrid3: TDBGrid
    Left = 103
    Top = 134
    Width = 320
    Height = 120
    DataSource = DataSource3
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Edit1: TEdit
    Left = 24
    Top = 134
    Width = 73
    Height = 21
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 24
    Top = 161
    Width = 73
    Height = 21
    TabOrder = 4
  end
  object Button1: TButton
    Left = 8
    Top = 215
    Width = 89
    Height = 25
    Caption = #1053#1086#1084#1077#1088' 1'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 246
    Width = 89
    Height = 25
    Caption = #1053#1086#1084#1077#1088' 2'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 277
    Width = 89
    Height = 25
    Caption = #1053#1086#1084#1077#1088' 3'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 308
    Width = 89
    Height = 25
    Caption = #1053#1086#1084#1077#1088' 4'
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 339
    Width = 89
    Height = 25
    Caption = #1053#1086#1084#1077#1088' 5'
    TabOrder = 9
    OnClick = Button5Click
  end
  object Edit3: TEdit
    Left = 24
    Top = 188
    Width = 73
    Height = 21
    TabOrder = 10
  end
  object IBDatabase1: TIBDatabase
    Connected = True
    DatabaseName = '192.168.0.3:D:\DB\PackingListKSP4.fdb'
    Params.Strings = (
      'user_name=student'
      'password=edu-759'
      'lc_ctype=WIN1251')
    LoginPrompt = False
    Left = 8
    Top = 8
  end
  object IBTransaction1: TIBTransaction
    Active = True
    DefaultDatabase = IBDatabase1
    Left = 40
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = IBQuery1
    Left = 72
    Top = 8
  end
  object IBQuery1: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Active = True
    SQL.Strings = (
      'select * from invoice')
    Left = 104
    Top = 8
  end
  object DataSource2: TDataSource
    DataSet = IBQuery2
    Left = 334
    Top = 8
  end
  object IBQuery2: TIBQuery
    Database = IBDatabase1
    Transaction = IBTransaction1
    Active = True
    SQL.Strings = (
      'select * from product p'
      'inner join separator s on (p.prd_id = s.prd_id)'
      'inner join invoice i on (i.inv_id = s.inv_id)'
      'where(i.inv_id = (select min(inv_id) from invoice))'
      ''
      ''
      '/* where(i.inv_id = (select min(inv_id) from invoice)) */'
      '/* where (i.inv_id = 1)*/')
    Left = 366
    Top = 8
  end
  object DataSource3: TDataSource
    DataSet = IBQuery3
    Left = 104
    Top = 136
  end
  object IBQuery3: TIBQuery
    Transaction = IBTransaction1
    Left = 136
    Top = 136
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = IBDatabase1
    Left = 40
    Top = 40
  end
end

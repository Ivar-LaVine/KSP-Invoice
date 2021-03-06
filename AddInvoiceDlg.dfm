object Form3: TForm3
  Left = 0
  Top = 0
  Caption = '*New* Invoice'
  ClientHeight = 139
  ClientWidth = 175
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 53
    Width = 60
    Height = 13
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 44
    Height = 13
    Caption = #1055#1088#1086#1076#1091#1082#1090
  end
  object Button1: TButton
    Left = 8
    Top = 99
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 89
    Top = 99
    Width = 75
    Height = 25
    Caption = #1042#1099#1081#1090#1080
    ModalResult = 2
    TabOrder = 1
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 8
    Top = 26
    Width = 156
    Height = 21
    KeyField = 'PRD_ID'
    ListField = 'Name'
    ListSource = DataSource1
    TabOrder = 2
    OnDropDown = DBLookupComboBox1DropDown
  end
  object Edit1: TEdit
    Left = 8
    Top = 72
    Width = 156
    Height = 21
    TabOrder = 3
  end
  object DataSource1: TDataSource
    DataSet = IBTable1
    Left = 136
    Top = 40
  end
  object IBTable1: TIBTable
    Database = Form1.IBDatabase1
    Transaction = Form1.IBTransaction1
    Active = True
    FieldDefs = <
      item
        Name = 'PRD_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PRICE'
        DataType = ftBCD
        Precision = 18
        Size = 2
      end>
    IndexDefs = <
      item
        Name = 'RDB$2'
        Fields = 'NAME'
        Options = [ixUnique]
      end
      item
        Name = 'PK_PRODUCT'
        Fields = 'PRD_ID'
        Options = [ixUnique]
      end>
    StoreDefs = True
    TableName = 'PRODUCT'
    Left = 8
    Top = 40
  end
end

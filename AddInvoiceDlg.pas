unit AddInvoiceDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBTable, DBCtrls, StdCtrls;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DBLookupComboBox1: TDBLookupComboBox;
    DataSource1: TDataSource;
    IBTable1: TIBTable;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure DBLookupComboBox1DropDown(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Main;



procedure TForm3.Button1Click(Sender: TObject);
var id : integer;
begin
  id := -1;
  if Form1.IBTransaction2.Active = false then Form1.IBTransaction2.StartTransaction;
  try
    begin
      with Form1.IBQuery3 do
      begin
        DataBase := Form1.IBDataBase1;
        SQL.Clear;
        SQL.Add('select max(inv_id) from invoice');
        Open;
        id := Fields[0].AsInteger;
        SQL.Clear;
        SQL.Add('insert into separator (inv_id, prd_id, count_prd) values (:id, :x, :y) ');
        ParamByName('x').AsInteger := DBLookUpComboBox1.KeyValue; // ????????????? ????????
        ParamByName('y').AsInteger := StrToInt(Edit1.Text); // ??????????
        ParamByName('id').AsInteger := id;
        Open;
      end;
      Form1.IBTransaction2.Commit;
    end;
  except
    begin
      Form1.IBTransaction2.RollBack;
    end;
  end;
  Edit1.Text := '';
end;

procedure TForm3.DBLookupComboBox1DropDown(Sender: TObject);
begin
  IBTable1.FetchAll;
end;

end.

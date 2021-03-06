unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IniFiles, DB, IBDatabase, IBCustomDataSet, IBQuery, Grids, DBGrids,
  StdCtrls;

type
  TForm1 = class(TForm)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DataSource1: TDataSource;
    IBQuery1: TIBQuery;
    DataSource2: TDataSource;
    IBQuery2: TIBQuery;
    DBGrid3: TDBGrid;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Button1: TButton;
    DataSource3: TDataSource;
    IBQuery3: TIBQuery;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    IBTransaction2: TIBTransaction;
    Button5: TButton;
    Edit3: TEdit;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses PwdDlg, AddInvoiceDlg;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with IBQuery3 do
  begin
    DataBase := IBDataBase1;
    SQL.Clear;
    SQL.Add('select name as "????????????", price as "???? ?? ??." from product where (price > :x)');
    ParamByName('x').AsFloat := StrToFloat(Edit1.Text); // ???????? X 
    Open;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  with IBQuery3 do
  begin
    DataBase := IBDataBase1;
    SQL.Clear;
    SQL.Add('select name as "????????????", (count_prd * price) as "????????? "');
    SQL.Add('from product p inner join separator s on (p.prd_id = s.prd_id) ');
    SQL.Add('inner join invoice i on (i.inv_id = s.inv_id) ');
    SQL.Add('where (i.inv_id = :x) and (date_inv = :y) ');
    ParamByName('x').AsInteger := StrToInt(Edit1.Text); // ????? ?????????
    ParamByName('y').AsDate := StrToDate(Edit2.Text); // ???? ?????????
    Open;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if IBTransaction2.Active = false then IBTransaction2.StartTransaction;
  try
    begin
      with IBQuery3 do
      begin
        DataBase := IBDataBase1;
        SQL.Clear;
        SQL.Add('update product set price = :y where (name = :x)');
        ParamByName('x').AsString := Edit1.Text; // ???????????? ??????
        ParamByName('y').AsFloat := StrToFloat(Edit2.Text); // ????? ???? ??????
        Open;
      end;
      IBTransaction2.Commit;
      IBQuery2.Close;
      IBQuery2.Open;
    end;
  except
    begin
      IBTransaction2.RollBack;
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if IBTransaction2.Active = false then IBTransaction2.StartTransaction;
  try
    begin
      with IBQuery3 do
      begin
        DataBase := IBDataBase1;
        SQL.Clear;
        SQL.Add('insert into invoice(date_inv) values (:x) ');
        ParamByName('x').AsDate := StrToDate(Edit1.Text); // ???? ????? ?????????
        Open;
      end;
      with TForm3.Create(nil) do
      try
        ShowModal;
      finally
        Free;
      end;
      IBTransaction2.Commit;
      IBQuery1.Close;
      IBQuery1.Open;
    end;
  except
    begin
      IBTransaction2.RollBack;
    end;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var id : integer;
begin
  id := -1;
  if IBTransaction2.Active = false then IBTransaction2.StartTransaction;
  try
    begin
      with IBQuery3 do
      begin
        DataBase := IBDataBase1;
        SQL.Clear;
        SQL.Add('select prd_id from product where (name = :name) ');
        ParamByName('name').AsString := Edit3.Text;
        Open;
        id := Fields[0].AsInteger;
        SQL.Clear;
        SQL.Add('delete from separator where (inv_id = :x) and (prd_id = :z) ');
        ParamByName('x').AsInteger := StrToInt(Edit1.Text); // ????? ?????????
        //ParamByName('y').AsDate := StrToDate(Edit2.Text); // ???? ?????????
        ParamByName('z').AsInteger := id; // ???????????? ????????
        Open;
      end;
      IBTransaction2.Commit;
      IBQuery2.Close;
      IBQuery2.Open;
    end;
  except
    begin
      IBTransaction2.RollBack;
    end;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
var F: TIniFile;
    Charset, UserName, Password: String;
begin
// ?????? ???????? ?????????? ?? ini-?????
   try
      F:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'Invoice.ini');
      IBDataBase1.DatabaseName:=F.ReadString('Settings', 'Database', '');
      IBDataBase1.SQLDialect:=F.ReadInteger('Settings', 'SQLDialect', 3);
      Charset:=F.ReadString('Settings', 'Charset', 'WIN1251');
      UserName:=F.ReadString('Settings', 'UserName', 'SYSDBA');
      Password:=F.ReadString('Settings', 'Password', '123');
      IBDataBase1.Params.Clear;
      IBDataBase1.Params.Add('user_name='+UserName);
      IBDataBase1.Params.Add('password='+Password);
      IBDataBase1.Params.Add('lc_ctype='+Charset);
   finally
      F.Free;
   end;
// ??????? ???????? ???? ??????
   try                                         
      IBDataBase1.Open;
   except
// ???? ?????? ??????? Firebird
      if not(EnterPassword('?????? ??????? Firebird', UserName, Password)) then
      begin
         UserName:='';
         Password:='';
      end;
      try
         IBDataBase1.Params.Clear;
         IBDataBase1.Params.Add('user_name='+UserName);
         IBDataBase1.Params.Add('password='+Password);
         IBDataBase1.Params.Add('lc_ctype='+Charset);
// ???????? ????? ????? ?????? ?????????????         
         IBDataBase1.Open;
      except
         MessageDlg('?????? ???????? ?????? ??????? ???? ?????? ??? ??????????? '+
          '??????????? ????????? ? ini-?????.', mtWarning, [mbOK], 0);
      end;
   end;
   if not(IBDatabase1.Connected) then Form1.Close;   
end;


end.

program KSP;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  PwdDlg in 'PwdDlg.pas' {Form2},
  AddInvoiceDlg in 'AddInvoiceDlg.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.

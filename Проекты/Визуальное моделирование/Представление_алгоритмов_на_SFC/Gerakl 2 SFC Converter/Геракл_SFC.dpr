program Геракл_SFC;

uses
  Vcl.Forms,
  Преобразование_Геракл_SFC in 'Преобразование_Геракл_SFC.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

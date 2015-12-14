program Gerakl_to_SFC_Converter;

uses
  Vcl.Forms,
  ger2sfc in 'ger2sfc.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

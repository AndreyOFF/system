program ¬вод_модели;

uses
  Forms,
  ¬вод__модели in '¬вод__модели.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.

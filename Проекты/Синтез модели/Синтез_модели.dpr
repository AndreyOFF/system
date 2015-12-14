program Синтез_модели;

uses
  Forms,
  Синтез__модели in 'Синтез__модели.pas' {Sintez};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSintez, Sintez);
  Application.Run;
end.

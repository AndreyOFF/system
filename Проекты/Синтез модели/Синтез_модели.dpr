program ������_������;

uses
  Forms,
  ������__������ in '������__������.pas' {Sintez};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSintez, Sintez);
  Application.Run;
end.

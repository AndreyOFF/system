program ТЗ_1;

uses
  Classes,
  StdCtrls,
  Windows,
  ComCtrls,
  Controls,
  Forms,
  ExtCtrls,
  Управление in 'Управление.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

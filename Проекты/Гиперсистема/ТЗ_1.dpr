program ��_1;

uses
  Classes,
  StdCtrls,
  Windows,
  ComCtrls,
  Controls,
  Forms,
  ExtCtrls,
  ���������� in '����������.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

program ������������_�������������;

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  ShellApi,
  ExtCtrls,
  Grids,
  CheckLst,
  jpeg,
  ����������_�������������� in '����������_��������������.pas' {MainForm},
  ��������_������������� in '��������_�������������.pas',
  ������� in '�������.pas',
  ����������_���������� in '����������_����������.pas',
  �� in '��.pas',
  ��������� in '���������.pas',
  ��� in '���.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.

program Итерационное_моделирование;

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
  Управление_моделированием in 'Управление_моделированием.pas' {MainForm},
  Средства_моделирования in 'Средства_моделирования.pas',
  Функции in 'Функции.pas',
  Объявление_переменных in 'Объявление_переменных.pas',
  ВП in 'ВП.pas',
  Алгоритмы in 'Алгоритмы.pas',
  ВВП in 'ВВП.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;

end.

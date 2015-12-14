unit Объявление_переменных;

interface

uses
  ExtCtrls;

const
  S: array [boolean] of string = ('0', '1');

const
  B: array [0 .. 1] of boolean = (false, true);

Var
  ФС,Входы,Команды,Функции,Алгоритмы,ПВП,Переменные:textfile;

  Автономный_режим, Комплексный_режим, Команды_выполнены, Алгоритмы_выполнены,
  Блоки_выполнены, Входы_поданы, Есть_переключения: boolean;
  Процесс_, Шаг_, Ранг, Контролируемый_процесс, Блок: Integer;
  Назначение: String;
{$I Variables_of_functions}
{$I Variables_of_algorithms}
  : boolean;

implementation

end.

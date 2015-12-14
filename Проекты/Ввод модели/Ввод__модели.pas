unit Ввод__модели;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ComObj, StdCtrls,ShellApi,CheckLst;

type
  TForm3 = class(TForm)
    Выбор_ТЗ: TButton;
    OpenDialog1: TOpenDialog;
    Ввод_блок_схем_по_картинке: TButton;
    OpenDialog2: TOpenDialog;
    Алгоритмы_Visio_Геракл: TButton;
    procedure Выбор_ТЗClick(Sender: TObject);
    procedure Ввод_блок_схем_по_картинкеClick(Sender: TObject);
//    procedure Ввод_блок_схем_в_MS_VISIOClick(Sender: TObject);
    procedure Алгоритмы_Visio_ГераклClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  Функции_Техническое_задание:textfile;
  Запуск_алгоритмов:textfile;
  Сигналы_срабатывания_таймеров:textfile;
  Резиденция_Гиперсистема,Имя_входа:String;
  Резиденция_Предметные_конструкции_модели,Исходная_строка:String;
//  Резиденция_Ввод_модели:PWideChar;
  Команды, Входы:textfile;
  Номер_входа,Номер_символа,Длина_имени:Integer;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);

begin
  // Определение пути запуска
  GetDir(0,Резиденция_Гиперсистема);
  Резиденция_Гиперсистема := StringReplace(Резиденция_Гиперсистема,'\__history' , '', [rfReplaceAll, rfIgnoreCase]);
  ShowMessage('Резиденция_Гиперсистема: ' + Резиденция_Гиперсистема);
  Резиденция_Предметные_конструкции_модели:= Резиденция_Гиперсистема + '\Предметные конструкции модели';
  ShowMessage('Резиденция_Предметные_конструкции_модели: ' + Резиденция_Предметные_конструкции_модели);
end;

procedure TForm3.Алгоритмы_Visio_ГераклClick(Sender: TObject);
begin
    //Преобразование блок-схем на язык Геракл
//    ShellExecute(Handle,nil,'D:\Гперсистема\Ввод_модели\Представление алгоритмов  MS Visio на языке Геракл\Алгоритмы_Геракл.exe',nil,nil,SW_Restore);

  ShellExecute(Handle,nil,PWideChar(Резиденция_Гиперсистема + '\Проекты\Преобразование алгоритмов из MS Visio на язык Геракл\Алгоритмы_Геракл.exe'),nil,nil,SW_Restore);
end;

procedure TForm3.Ввод_блок_схем_по_картинкеClick(
  Sender: TObject);
  var Блок_схема:variant;
    dir_:string;
begin
  //  Запись блок-схем на языке Геракл
  //  Ввод_блок_схем_в_MS_VISIO
    Блок_схема:=CreateOleObject('Visio.Application');
    GetDir(0,dir_);
  if not OpenDialog2.Execute then begin chdir(dir_); exit; end;
  chdir(dir_);
  Блок_схема.Documents.Open(OpenDialog2.FileName);
  ShellExecute(Handle,nil,'NotePad.exe',nil,nil,SW_Restore);
end;



procedure TForm3.Выбор_ТЗClick(Sender: TObject);
  Label 1;
var dir_:string;
    Функция,Выражение,Имя_функции,Разъем,Контакты_разъема,Контакт,Слово_данных:string;
var Техническое_задание,Таблица,Начало,Конец:variant;
    Таблица_,Строка,Длина_имени:Integer;
var Слово:Integer;
begin
Техническое_задание:=CreateOleObject('Word.Application');

GetDir(0,dir_);
if not OpenDialog1.Execute then begin chdir(dir_); exit; end;
chdir(dir_);
Техническое_задание.Documents.Open(OpenDialog1.FileName);
Техническое_задание.Visible := True;
Таблица:=Техническое_задание.ActiveDocument.Tables.item(1);
//chdir(Резиденция_Предметные_конструкции_модели);
AssignFile(Функции_Техническое_задание,Резиденция_Предметные_конструкции_модели + '\Функции.txt');
AssignFile(Сигналы_срабатывания_таймеров,Резиденция_Предметные_конструкции_модели + '\Сигналы_срабатывания_таймеров.txt');
ReWrite(Функции_Техническое_задание);
ReWrite(Сигналы_срабатывания_таймеров);
AssignFile(Запуск_алгоритмов,Резиденция_Предметные_конструкции_модели + '\Запуск_алгоритмов.txt');
ReWrite(Запуск_алгоритмов);
AssignFile(Входы, 'd:\Гиперсистема\Предметные конструкции модели\Входы.txt');
ReSet(Входы);

//ShowMessage('Таблиц  ' + IntToStr(Техническое_задание.ActiveDocument.Tables.count));

// tCount:=Doc.Tables.Count;
//       for i := 1 to tCount-1 do
//           begin
//             table:=Doc.Tables.Item(i);
//             header:=table.Cell(1,1).Range.Previous(wdParagraph, 1);
//             header:=LowerCase(header);
//             // GET HEADER
//             if 	ContainsText(header, 'логическая функция')
//             then
//             begin
//             Label1.Caption:=header;
//ShowMessage(IntToStr(Техническое_задание.ActiveDocument.Words.count));

  Номер_входа := 0;
//  Начало := 0;
//  Конец := 0;
  while not Eof(Входы) do
    Begin
    Номер_входа := Номер_входа + 1;
    Readln(Входы,Исходная_строка);
    Исходная_строка := AnsiUpperCase(Исходная_строка);
    Номер_символа := 1;
    while Номер_символа <> 0 do
    Begin
      Номер_символа := Pos(' ',Исходная_строка);
      Delete(Исходная_строка,Номер_символа,1);
    End;
    Длина_имени := Pos('=',Исходная_строка);
     Имя_входа:= Copy(Исходная_строка,1,Длина_имени - 1);
//    ShowMessage(Имя_входа);
    if Техническое_задание.Selection.Find.Execute(Имя_входа) then
     Begin
     Техническое_задание.Selection.Font.Color:=clFuchsia;
//     ShowMessage('Найдено  ' + Имя_входа);
     Техническое_задание.Selection.Collapse(EmptyParam);
     End;
  End;
    ShowMessage('Созданы  Входы ТЗ!');
    CloseFile(Входы);
    goto 1;

Таблица:=Техническое_задание.ActiveDocument.Tables.item(1);

//Таблица логических функций
ShowMessage('Начало ввода логических функций!');
for  Строка:= 2 to Таблица.Rows.Count do
begin
Try
  Функция := AnsiUpperCase(Trim(Таблица.Cell(Строка,1).Range.Text));
Except
Continue
End;
  if ((Pos('Z',Функция) = 1) or (Pos('Y',Функция) = 1) or (Pos('V',Функция) = 1)
      or (Pos('S',Функция) = 1) or (Pos('F',Функция) = 1) or (Pos('H',Функция) = 1)
      or (Pos('M',Функция) = 1) or (Pos('I',Функция) = 1) or (Pos('O',Функция) = 1)
      or (Pos('A',Функция) = 1) or (Pos('N',Функция) = 1) or (Pos('L',Функция) = 1)
      or (Pos('E',Функция) = 1))
      and  (Pos('=',Функция) <> 0)
      then WriteLn(Функции_Техническое_задание,Trim(Таблица.Cell(Строка,1).Range.Text));
end;
ShowMessage('Конец ввода логических функций!');

Таблица:=Техническое_задание.ActiveDocument.Tables.item(2);
//Таблица команд управления

ShowMessage('Начало ввода команд управления!');
for Строка := 2 to Таблица.Rows.Count do
begin
Try
  Функция := AnsiUpperCase(Trim(Таблица.Cell(Строка,1).Range.Text));
Except
Continue
End;
//ShowMessage(Trim(Таблица.Cell(Строка,1).Range.Text) + '=' + Trim(Таблица.Cell(Строка,2).Range.Text));
   WriteLn(Функции_Техническое_задание,Trim(Таблица.Cell(Строка,1).Range.Text) + '=' + Trim(Таблица.Cell(Строка,2).Range.Text));
end;
ShowMessage('Конец ввода команд управления!');

Таблица:=Техническое_задание.ActiveDocument.Tables.item(3);

//Таблица Сигналы_срабатывания_таймеров

ShowMessage('Начало ввода Сигналы_срабатывания_таймеров!');
for Строка := 2 to Таблица.Rows.Count do
begin
   WriteLn(Сигналы_срабатывания_таймеров,Trim(Таблица.Cell(Строка,3).Range.Text));
end;
ShowMessage('Конец ввода Сигналы_срабатывания_таймеров!');

Таблица:=Техническое_задание.ActiveDocument.Tables.item(4);
//Таблица распайки внешних соединителей

ShowMessage('Начало ввода внешних соединителей!');
for Строка := 2 to Таблица.Rows.Count do
begin
  If (Pos('X',Таблица.Cell(Строка,1).Range.Text) <> 0) or (Pos('Х',Таблица.Cell(Строка,1).Range.Text) <> 0) Then
      Begin
      Разъем := AnsiUpperCase(Trim(Таблица.Cell(Строка,1).Range.Text));
//      Длина_имени := Pos(' ',Разъем);
//      Разъем := Copy(Разъем,1,Длина_имени - 1);
//      ShowMessage(Разъем);
      End;

  Try
    Функция := Trim(Таблица.Cell(Строка,3).Range.Text);
  Except
  Continue
  End;
//  ShowMessage(Функция);
  if (Pos('Y',Функция) = 1) or (Pos('У',Функция) = 1) then
  Begin
    WriteLn(Функции_Техническое_задание,Trim(Функция));
    Длина_имени := Pos('=',Функция);
    Имя_функции := Copy(Функция,1,Длина_имени - 1);
    Контакты_разъема := Таблица.Cell(Строка,1).Range.Text;
    while Pos('-',Контакты_разъема) <> 0 do
          Begin
            Insert('_',Контакты_разъема,Pos('-',Контакты_разъема));
            Delete(Контакты_разъема,Pos('-',Контакты_разъема),1);
          End;
    while Pos(',',Контакты_разъема) <> 0 do
          Begin
            Контакт:= Copy(Контакты_разъема,1,Pos(',',Контакты_разъема)-1);
            Delete(Контакты_разъема,1,Pos(',',Контакты_разъема));
            WriteLn(Функции_Техническое_задание,Разъем + '_' + Trim(Контакт) + ' = ' + Имя_функции);
          End;
    if Pos(',',Контакты_разъема) = 0 then
    Begin
      Контакт:= Контакты_разъема;
      WriteLn(Функции_Техническое_задание,Разъем + '_' + Trim(Контакт) + '=' + Имя_функции);
    End;
  End;

  if (Pos('X',Функция) = 1) or (Pos('Х',Функция) = 1) then
  Begin
  Try
  Имя_функции := Trim(Таблица.Cell(Строка,3).Range.Text);
  Except
  Continue
  End;
    Контакты_разъема := Таблица.Cell(Строка,1).Range.Text;
    Выражение := '';
    while Pos(',',Контакты_разъема) <> 0 do
          Begin
            Контакт:= Copy(Контакты_разъема,1,Pos(',',Контакты_разъема)-1);
            Delete(Контакты_разъема,1,Pos(',',Контакты_разъема));
            Выражение := Выражение + Разъем + '_' + Trim(Контакт) + ' + ';
          End;
          If Выражение <> '' Then
          Begin
            Контакт:= Контакты_разъема;
            Контакты_разъема:= ' ';
            Выражение := Выражение + Разъем + '_' + Trim(Контакт);
            WriteLn(Функции_Техническое_задание,Имя_функции + ' = ' + Выражение);
          End;

    if (Pos(',',Контакты_разъема) = 0) and (Контакты_разъема <> ' ')  then
    Begin
      Контакт:= Контакты_разъема;
      WriteLn(Функции_Техническое_задание,Имя_функции + ' = ' + Разъем + '_' + Trim(Контакт));
    End;
  End;
end;
ShowMessage('Конец ввода внешних соединителей!');

Таблица:=Техническое_задание.ActiveDocument.Tables.item(5);
//Таблица Запуск_алгоритмов
ShowMessage('Начало ввода условий запуска алгоритмов!');
//ShowMessage(IntToStr(Таблица.Rows.Count));
for Строка := 2 to Таблица.Rows.Count do
begin
//ShowMessage(Trim(Таблица.Cell(Строка,3).Range.Text));
WriteLn(Запуск_алгоритмов,'__' + Trim(Таблица.Cell(Строка,3).Range.Text) + ' = ' + Trim(Таблица.Cell(Строка,4).Range.Text));
end;
ShowMessage('Конец ввода условий запуска алгоритмов!');

CloseFile(Запуск_алгоритмов);
CloseFile(Функции_Техническое_задание);
CloseFile(Сигналы_срабатывания_таймеров);

//ShowMessage('Начало добавления условий запуска алгоритмов к функциям!');
AssignFile(Запуск_алгоритмов,Резиденция_Предметные_конструкции_модели + '\Запуск_алгоритмов.txt');
Reset(Запуск_алгоритмов);
AssignFile(Функции_Техническое_задание,Резиденция_Предметные_конструкции_модели + '\Функции.txt');
Append(Функции_Техническое_задание);
while not Eof(Запуск_алгоритмов) do
  Begin
  Readln(Запуск_алгоритмов,Слово_данных);
  WriteLn(Функции_Техническое_задание,Слово_данных);
  End;
CloseFile(Функции_Техническое_задание);
CloseFile(Запуск_алгоритмов);
//ShowMessage('Конец добавления условий запуска алгоритмов к функциям!');
ShowMessage('Ввод модели закончен!');
// Dыход без сохранения
1:
Техническое_задание.Documents.Close;
// А затем закрываеnся приложение WORD
Техническое_задание.Quit
end;
end.

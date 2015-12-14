unit Управление_моделированием;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics,
  Dialogs, StdCtrls, Forms, Controls, Classes,
  ComCtrls, ShellApi, VCL.ExtCtrls, Grids, CheckLst,
  Средства_моделирования, Объявление_переменных,
  ВВП, ВП, Алгоритмы, Функции;

Type
  Кнопка = TButton;

Type
  Граф_управления = TTreeView;

type
  TMainForm = class(TForm)
    ФС_: TTreeView;
    Команды_: TCheckListBox;
    Загрузка_команд_и_входов: TButton;
    Входы_: TCheckListBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Ф_С: TButton;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox3: TListBox;
    Создание_ПВП: TButton;
    Выбор_ПВП: TButton;
    Список_ПВП: TCheckListBox;
    Пакетное_моделирование: TButton;
    Сброс_ПВП: TButton;
    Label5: TLabel;
    Инициализация: TButton;
    ListBox2: TListBox;
    {$I Announcements_of_Timers}
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Загрузка_команд_и_входовClick(Sender: TObject);
    procedure Ф_СClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox2Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure Создание_ПВПClick(Sender: TObject);
    procedure Выбор_ПВПClick(Sender: TObject);
    procedure Пакетное_моделированиеClick(Sender: TObject);
    procedure Сброс_ПВПClick(Sender: TObject);
    procedure ИнициализацияClick(Sender: TObject);
    procedure СозданиеТаймеровClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
//    Procedure СозданиеТаймеров(Sender: TObject);

  private
    { Private declarations }
  public

    { Public declarations }

  end;

var
    MainForm: TMainForm;
    Резиденцмя_Гиперсистема:String;
    Резиденцмя_Итерационное_моделирование:String;
    Резиденцмя_Результаты_моделирования:String;
    Резиденцмя_Предметные_конструкции_модели:String;
procedure Запуск_таймера(Имя: TTimer; Время: Integer;Имя_: String);
procedure Перезапуск_таймера(Имя: TTimer; Время: Integer;Имя_: String);
procedure Останов_и_обнуление_таймера(Имя: TTimer;Имя_: String);

implementation

{$R *.dfm}
    {$I Creation_of_Timers}
    {$I Output_agents_of_events_of_Timers}
procedure TMainForm.FormCreate(Sender: TObject);
begin
  GetDir(0,Резиденцмя_Гиперсистема);
  Резиденцмя_Гиперсистема := StringReplace(Резиденцмя_Гиперсистема,'\__history' , '', [rfReplaceAll, rfIgnoreCase]);
//  ShowMessage('Резиденцмя_Гиперсистема: ' + Резиденцмя_Гиперсистема);
  Резиденцмя_Предметные_конструкции_модели:= Резиденцмя_Гиперсистема + '\Предметные конструкции модели';
//  ShowMessage('Резиденцмя_Предметные_конструкции_модели: ' + Резиденцмя_Предметные_конструкции_модели);
  Резиденцмя_Итерационное_моделирование := Резиденцмя_Гиперсистема + '\Проекты\Итерационное моделирование';
  ShowMessage('Резиденцмя_Итерационное_моделирование: ' + Резиденцмя_Итерационное_моделирование);
  Резиденцмя_Результаты_моделирования:= Резиденцмя_Гиперсистема + '\Результаты_моделирования';
//  ShowMessage('Резиденцмя_Результаты_моделирования: ' + Резиденцмя_Результаты_моделирования);
end;

procedure TMainForm.Сброс_ПВПClick(Sender: TObject);
// Сброс_ПВП
begin
  AssignFile(ПВП,Резиденцмя_Предметные_конструкции_модели + '\ПВП.txt');
  ReWrite(ПВП);
  CloseFile(ПВП);
end;

procedure TMainForm.Создание_ПВПClick(Sender: TObject);
// Создание_ПВП
Var
  i, j: Integer;
begin
  AssignFile(ПВП,Резиденцмя_Предметные_конструкции_модели +  '\ПВП.txt');
  Append(ПВП);
  For i := 0 to Команды_.Items.Count - 1 do
    If (Команды_.Checked[i]) then
    begin
      WriteLn(ПВП, Команды_.Items[i]);
    end;
  For j := 0 to Входы_.Items.Count - 1 do
    If (Входы_.Checked[j]) then
    begin
      WriteLn(ПВП, Входы_.Items[j]);
    end;
  CloseFile(ПВП);
end;

procedure TMainForm.Выбор_ПВПClick(Sender: TObject);
// Выбор_ПВП
begin
  ShellExecute(Handle, nil, 'c:\Windows\system32\notepad.exe',
  PwideChar(Резиденцмя_Предметные_конструкции_модели + '\ПВП.txt'), nil, SW_Restore);
  Список_ПВП.Items.LoadFromFile(Резиденцмя_Предметные_конструкции_модели + '\ПВП.txt');
  Список_ПВП.CheckAll(cbchecked, false, True);
  MainForm.ListBox3.Visible := True;
end;

//          процедура рекурсивного поиска файлов на диске
//			возвращает TStringList содержащий все найденные файлы в папке

procedure ScanDir(StartDir, Mask: String; List: TStrings);
var
SearchRec: TSearchRec;
begin
if Mask = '' then Mask:= '*.*';
if StartDir[Length(StartDir)] &lt;&gt; '' then StartDir := StartDir + '';
if FindFirst(StartDir+Mask, faAnyFile, SearchRec) = 0 then
begin
repeat
Application.ProcessMessages;
if (SearchRec.Attr and faDirectory) &lt;&gt; faDirectory then
List.Add(StartDir + SearchRec.Name)
else if (SearchRec.Name &lt;&gt; '..') and (SearchRec.Name &lt;&gt; '.') then
ScanDir(StartDir + SearchRec.Name + »,Mask,List);
until FindNext(SearchRec) &lt;&gt; 0;
FindClose(SearchRec);
end;
end;

// Пример использования
procedure TForm1.Button1Click(Sender: TObject);
var
list: TStrings;
begin
list:= TStringList.Create;
ScanDir(‘c:’, ’*.txt’, list);
Memo1.Lines:= list;
list.Free;
end;

procedure TMainForm.Пакетное_моделированиеClick(Sender: TObject);
// Пакетное_моделирование
Var
  i, j, Процесс, Шаг: Integer;
begin
//  TMainForm.СозданиеТаймеров(Sender);
  Список_ПВП.Items.LoadFromFile(Резиденцмя_Предметные_конструкции_модели + '\ПВП.txt');
  Список_ПВП.CheckAll(cbchecked, false, True);
  MainForm.ListBox3.Visible := True;
  Процесс_ := 0;
  Шаг_ := 0;
  For i := 0 to Список_ПВП.Items.Count - 1 do
    If (Список_ПВП.Checked[i]) then
    begin
      if Pos('Команда', Список_ПВП.Items[i]) > 0 then
      Begin
        Процесс := StrToInt(Copy(Список_ПВП.Items.Strings[i], 1,
          Pos(':', Список_ПВП.Items.Strings[i]) - 1));
        Процесс_ := Процесс;
        Внешняя_Входная_последоательность(Процесс);
        Алгоритм;
        Есть_переключения := false;
        Repeat
          Переключения;
  if Ранг > 50 then
  Begin
    Application.MessageBox('Зацикливание! Моделирование прервано!',
      'Ранг > 50!', MB_OK);
    Break;
  End;
        until not Есть_переключения;
        Процесс_ := 0;
      End
      else if Pos('Вход', Список_ПВП.Items[i]) > 0 then
      Begin
        Шаг := StrToInt(Copy(Список_ПВП.Items.Strings[i], 1,
          Pos(':', Список_ПВП.Items.Strings[i]) - 1));
        Шаг_ := Шаг;
        Входная_последоательность(Шаг);
        Есть_переключения := false;
        Repeat
          Переключения;
  if Ранг > 50 then
  Begin
    Application.MessageBox('Зацикливание! Моделирование прервано!',
      'Ранг > 50!', MB_OK);
    Break;
  End;
        until not Есть_переключения;
        Шаг_ := 0;
      End;
    end;
  Команды_.CheckAll(cbUnchecked, True, false);
  Входы_.CheckAll(cbUnchecked, True, false);
  Список_ПВП.CheckAll(cbUnchecked, True, false);
  // ShowMessage ('Моделирование выбранных команд и входов закончено!');
end;

procedure TMainForm.Ф_СClick(Sender: TObject);
// Анализ
Var
  i: Integer;
var
  Развернутый_узел: TTreeNode;
begin
  AssignFile(ФС,Резиденцмя_Результаты_моделирования + '\Фс.txt');
  Append(ФС);
  for i := 0 to MainForm.ListBox3.Items.Count - 1 do
  begin
    WriteLn(ФС, MainForm.ListBox3.Items[i]);
  end;
  CloseFile(ФС);
  MainForm.ListBox3.Visible := false;
  ФС_.LoadFromFile(Резиденцмя_Результаты_моделирования + '\Фс.txt');
  ФС_.Enabled := True;
  Развернутый_узел := ФС_.Items.GetFirstNode;
  while Развернутый_узел <> nil do
  begin
    if Развернутый_узел.Level = 1 then
      Развернутый_узел.Expand(True);
    Развернутый_узел := Развернутый_узел.GetNext;
  end;
  ShellExecute(Handle, nil,PwideChar(Резиденцмя_Результаты_моделирования + '\Outline.EXE'), nil, nil,SW_Restore);
end;

procedure Запуск_таймера(Имя: TTimer; Время: Integer;Имя_: String);
begin
  Имя.Enabled := True;
  Имя.Interval := Время;
  Ранг := Ранг - 1;
  MainForm.ListBox3.Items.Add(Pr(Ранг) + Имя_ + ' Запущен!');
end;

procedure Перезапуск_таймера(Имя: TTimer; Время: Integer;Имя_: String);
begin
  Имя.Enabled := True;
  Имя.Interval := Время;
  Ранг := Ранг - 1;
  MainForm.ListBox3.Items.Add(Pr(Ранг) + Имя_ + ' Перезапущен!');
end;

procedure Останов_и_обнуление_таймера(Имя: TTimer;Имя_: String);
begin
  Имя.Interval := 0;
  Имя.Enabled := false;
  Ранг := Ранг - 1;
  MainForm.ListBox3.Items.Add(Pr(Ранг) + Имя_ + ' Остановлен!');
end;

procedure TMainForm.Загрузка_команд_и_входовClick(Sender: TObject);
begin
  AssignFile(ФС,Резиденцмя_Результаты_моделирования + '\Фс.txt');
  ReWrite(ФС);
  CloseFile(ФС);
  Команды_.Items.LoadFromFile(Резиденцмя_Итерационное_моделирование + '\Commands__.pas');
  Входы_.Items.LoadFromFile(Резиденцмя_Итерационное_моделирование + '\Inputs__.pas');
  MainForm.ListBox1.Items.Clear;
  MainForm.ListBox2.Items.Clear;
  MainForm.ListBox3.Items.Clear;
  MainForm.ListBox3.Items.Add('Функциональная схема');
end;

procedure TMainForm.ИнициализацияClick(Sender: TObject);
begin
//  Есть_переключения := false;
//  Repeat
//    Переключения;
//  if Ранг > 50 then
//  Begin
//    Application.MessageBox('Зацикливание! Моделирование прервано!',
//      'Ранг > 50!', MB_OK);
//    Break;
//  End;
//  until not Есть_переключения;
end;

procedure TMainForm.Edit1Change(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Команды_.Items.Count - 1 do
  begin
    if Pos(Edit1.Text, Команды_.Items[i]) > 10 then
    begin
      Команды_.ItemIndex := i;
      Break;
    end;
    if Pos(Edit1.Text, Команды_.Items[i]) = 0 then
    begin
      // Снимаем выделение из ListBox
      Команды_.ItemIndex := -1;
    end;
  end;

end;

procedure TMainForm.Edit2Change(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Входы_.Items.Count - 1 do
  begin
    if Pos(Edit2.Text, Входы_.Items[i]) > 7 then
    begin
      Входы_.ItemIndex := i;
      Break;
    end;
    if Pos(Edit2.Text, Входы_.Items[i]) = 0 then
    begin
      // Снимаем выделение из ListBox
      Входы_.ItemIndex := -1;
    end;
  end;
end;

procedure TMainForm.ListBox1Click(Sender: TObject);
begin
  // Выходы для команд БИВК
end;

procedure TMainForm.ListBox2Click(Sender: TObject);
begin
  // Выходы для входов ИМС
end;

procedure TMainForm.ListBox3Click(Sender: TObject);
begin
  // ФС
end;

end.

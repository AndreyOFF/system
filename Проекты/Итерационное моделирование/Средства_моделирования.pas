unit Средства_моделирования;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Clipbrd, ShellApi, ComObj,
  // SpeechLib_TLB,
  Объявление_переменных;
Procedure Команда(Var Имя: Boolean; Состояние: Integer; Комментарий: String;
  Речь: Integer);
Procedure Вход(Var Имя: Boolean; Состояние: Integer; Комментарий: String;
  Речь: Integer);
procedure Выч(Var Имя: Boolean; Формула: Boolean; Комментарий: String;
  Речь: Integer);
Procedure Выч_Пф_Зф(Var Имя: Boolean; Формула: Boolean; Комментарий: String;
  Речь: Integer; Var Пф: Boolean; Var Зф: Boolean);
Procedure Выч_Пф(Var Имя: Boolean; Формула: Boolean; Комментарий: String;
  Речь: Integer; Var Пф: Boolean);
procedure Выч_Зф(Var Имя: Boolean; Формула: Boolean; Комментарий: String;
  Речь: Integer; Var Зф: Boolean);
Procedure FKU(Var Имя: Boolean; Состояние: Integer; Комментарий: String;
  Речь: Integer);
procedure Запись_ФС(Ранг_: Integer; Текст: String);
procedure Речевое_оповещение(Текст: String);
Function Pr(Ранг: Integer): String;

implementation

Uses Алгоритмы, Функции, Управление_моделированием;

Procedure Команда(Var Имя: Boolean; Состояние: Integer; Комментарий: String;
  Речь: Integer);
Begin
  Имя := B[Состояние];
  Ранг := 0;
  MainForm.ListBox1.Items.Add('Процесс ' + IntToStr(Процесс_));
  MainForm.ListBox1.Items.Add('Команда: ' + Комментарий + s[Имя]);
  MainForm.ListBox3.Items.Add(Pr(Ранг) + 'Процесс ' + IntToStr(Процесс_));
  MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Имя]);
  // if B[Речь] then
  // Begin
  // Назначение:= Комментарий + s[Имя];
  // Речевое_оповещение('Команда!' + Назначение);
  // End;
end;

Procedure Вход(Var Имя: Boolean; Состояние: Integer; Комментарий: String;
  Речь: Integer);
Begin
  Имя := B[Состояние];
  Ранг := 0;
  MainForm.ListBox2.Items.Add('Шаг ' + IntToStr(Шаг_));
  MainForm.ListBox2.Items.Add('Вход: ' + Комментарий + s[Имя]);
  MainForm.ListBox3.Items.Add(Pr(Ранг) + 'Шаг ' + IntToStr(Шаг_));
  MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Имя]);
  // if B[Речь] then
  // Begin
  // Назначение:= Комментарий + s[Имя];
  // Речевое_оповещение('Вход!' + Назначение);
  // End;
end;

Procedure Выч(Var Имя: Boolean; Формула: Boolean; Комментарий: String;
  Речь: Integer);
Begin
  if Формула <> Имя Then
  Begin
    Имя := not Имя;
    Есть_переключения := true;
    Ранг := Ранг + 1;
    MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Имя]);
    if ((Pos('Y', Комментарий) = 1) or (Pos('У', Комментарий) = 1)) then
    Begin
      if Процесс_ <> 0 then
        MainForm.ListBox1.Items.Add(Комментарий + s[Имя]);
      if Шаг_ <> 0 then
        MainForm.ListBox2.Items.Add(Комментарий + s[Имя]);
    End;
    // if B[Речь] then
    // Begin
    // Назначение:= Комментарий + s[Имя];
    // Речевое_оповещение(Назначение);
    // End;
  End;
  // Else Есть_переключение:= false;
end;

Procedure Выч_Пф_Зф(Var Имя: Boolean; Формула: Boolean; Комментарий: String;
  Речь: Integer; Var Пф: Boolean; Var Зф: Boolean);
Begin
  if Формула <> Имя Then
  Begin
    Имя := not Имя;
    Есть_переключения := true;
    Ранг := Ранг + 1;
    MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Имя]);
    if Имя then
    Begin
      Пф := true;
      Insert('_', Комментарий, Pos('(', Комментарий) + 1);
      MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Пф]);
      Алгоритм;
      Пф := False;
      // Insert('_',Комментарий,Pos(' =',Комментарий));
      // MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Пф]);
    End
    else
    Begin
      Зф := true;
      Insert('_', Комментарий, Pos(' =', Комментарий));
      MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Зф]);
      Алгоритм;
      Зф := False;
    End;
    // if B[Речь] then
    // Begin
    // Назначение:= Комментарий + s[Имя];
    // Речевое_оповещение(Назначение);
    // End;
  End
  Else
    Есть_переключения := False;
end;

Procedure Выч_Пф(Var Имя: Boolean; Формула: Boolean; Комментарий: String;
  Речь: Integer; Var Пф: Boolean);
Begin
  if Формула <> Имя Then
  Begin
    Имя := not Имя;
    Есть_переключения := true;
    Ранг := Ранг + 1;
    MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Имя]);
    if Имя then
    Begin
      Пф := true;
      Insert('_', Комментарий, Pos('(', Комментарий) + 1);
      MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Пф]);
      Алгоритм;
      Пф := False;
    End;
    // if B[Речь] then
    // Begin
    // Назначение:= Комментарий + s[Имя];
    // Речевое_оповещение(Назначение);
    // End;
  End
  Else
    Есть_переключения := False;
end;

Procedure Выч_Зф(Var Имя: Boolean; Формула: Boolean; Комментарий: String;
  Речь: Integer; Var Зф: Boolean);
Begin
  if Формула <> Имя Then
  Begin
    Имя := not Имя;
    Есть_переключения := true;
    Ранг := Ранг + 1;
    MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Имя]);
    if not Имя then
    Begin
      Зф := true;
      Insert('_', Комментарий, Pos(' =', Комментарий));
      MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Зф]);
      Алгоритм;
      Зф := False;
    End;
    // if B[Речь] then
    // Begin
    // Назначение:= Комментарий + s[Имя];
    // Речевое_оповещение(Назначение);
    // End;
  End
  Else
    Есть_переключения := False;
end;

Procedure FKU(Var Имя: Boolean; Состояние: Integer; Комментарий: String;
  Речь: Integer);
Begin
  Имя := B[Состояние];
  Ранг := Ранг - 1;
  MainForm.ListBox3.Items.Add(Pr(Ранг) + Комментарий + s[Имя]);
  // if B[Речь] then
  // Begin
  // Назначение:= Комментарий + s[Имя];
  // Речевое_оповещение(Назначение);
  // End;
  Переключения;
End;

procedure Запись_ФС(Ранг_: Integer; Текст: String);
begin
  Ранг := Ранг_;
  MainForm.ListBox3.Items.Add(Pr(Ранг) + Текст);
end;

procedure Речевое_оповещение(Текст: String);
// var
// pvoice: TSpVoice;
// Voices:ISpeechObjectTokens;
begin
  // pvoice:=TSpVoice.Create(nil);
  // Voices:=pvoice.GetVoices('Name=ELAN TTS Russian (Nicolai 16Khz)','');
  // pvoice.Voice:=Voices.Item(0);
  // pvoice.Speak(Текст, SVSFlagsAsync);
  // pvoice.WaitUntilDone(infinite);
end;

Function Pr(Ранг: Integer): String;
Var
  I: Integer;
  P: String;
Begin
  P := ' ';
  for I := 1 to Ранг do
    P := P + ' ';
  Pr := P;
End;

end.

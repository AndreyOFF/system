unit Управление;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,ShellApi,
  ExtCtrls, Grids, CheckLst, jpeg;
  type
  TMainForm = class(TForm)
    Моделирование: TButton;
    Синтез_модели: TButton;
    Компиляция: TButton;
    Ввод_данных_модели: TButton;
    Представление_алгоритмов_на_SFC: TButton;
    Моделирование_алгоритмов: TButton;
    Генерация_C_кода: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Экспорт_C_кода_в_Project_96: TButton;
    Руководство_пользователя: TButton;
    Представление_функций_на_LD: TButton;
    Представление_функций_на_ST: TButton;
    Презентация: TButton;
    Моделирование_функций_на_LD: TButton;
    Моделирование_функций_на_ST: TButton;
    OpenDialog1: TOpenDialog;

    procedure МоделированиеClick(Sender: TObject);
    procedure Синтез_моделиClick(Sender: TObject);
    procedure КомпиляцияClick(Sender: TObject);
    procedure Ввод_данных_моделиClick(Sender: TObject);
    procedure Представление_алгоритмов_на_SFCClick(Sender: TObject);
    procedure Представление_функций_на_LDClick(Sender: TObject);
    procedure Представление_функций_на_STClick(Sender: TObject);
    procedure Моделирование_алгоритмовClick(Sender: TObject);
    procedure Генерация_C_кодаClick(Sender: TObject);
    procedure Экспорт_C_кода_в_Project_96Click(Sender: TObject);
    procedure Руководство_пользователяClick(Sender: TObject);
    procedure ПрезентацияClick(Sender: TObject);
    procedure Моделирование_функций_на_LDClick(Sender: TObject);
    procedure Моделирование_функций_на_STClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public

  var
  Резиденцмя_Гиперсистемы: PWideChar;
  Резиденцмя_Гиперсистемы_: String;
  Путь_запуска: PWideChar;
  Путь_запуска_: String;
    { Public declarations }

  end;

var
  MainForm: TMainForm;

implementation
{$R *.dfm}

procedure TMainForm.FormShow(Sender: TObject);
begin
    // Определение пути запуска
  Резиденцмя_Гиперсистемы_:= GetCurrentDir;
   //Удаление всех вхождений заданной подстроки без учёта регистра букв.
//  Резиденцмя_Гиперсистемы_ := StringReplace(Резиденцмя_Гиперсистемы_,'\__history' , '', [rfReplaceAll, rfIgnoreCase]);
  ShowMessage('Резиденцмя Гиперсистемы: ' + Резиденцмя_Гиперсистемы_);
  Резиденцмя_Гиперсистемы:= PWideChar(Резиденцмя_Гиперсистемы_);
end;

function CopyDir(const fromDir, toDir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_COPY;
    fFlags := FOF_FILESONLY;
    pFrom  := PChar(fromDir + #0);
    pTo    := PChar(toDir)
  end;
  Result := (0 = ShFileOperation(fos));
end;

function DeleteDir(Dir : string) : boolean;
Var
Found : integer;
SearchRec : TSearchRec;
begin
result:=false;
if IOResult<>0 then ;
ChDir(Dir);
if IOResult<>0 then begin
ShowMessage('Не могу войти в каталог: '+Dir); exit;
end;
Found := FindFirst('*.*', faAnyFile, SearchRec);
while Found = 0 do
begin
if (SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
if (SearchRec.Attr and faDirectory)<>0 then begin
if not DeleteDir(SearchRec.Name) then exit;
end else
if not DeleteFile(SearchRec.Name) then begin
ShowMessage('Не могу удалить файл: '+SearchRec.Name); exit;
end;
Found := FindNext(SearchRec);
end;
FindClose(SearchRec);
ChDir('..'); RmDir(Dir);
result:=IOResult=0;
end;

procedure TMainForm.Ввод_данных_моделиClick(Sender: TObject);
begin
//Ввод_данных_модели
  Путь_запуска_:= Резиденцмя_Гиперсистемы +'\Проекты\Ввод модели\Ввод_модели.EXE';
  Путь_запуска:= PWideChar(Путь_запуска_);
  ShellExecute(Handle,nil, Путь_запуска,nil,nil,SW_Restore);
end;

procedure TMainForm.Синтез_моделиClick(Sender: TObject);
begin
//Синтез_модели
  Путь_запуска_:= Резиденцмя_Гиперсистемы +'\Проекты\Синтез модели\Синтез_модели.EXE';
  Путь_запуска:= PWideChar(Путь_запуска_);
  ShellExecute(Handle,nil, Путь_запуска,nil,nil,SW_Restore);
end;


procedure TMainForm.Экспорт_C_кода_в_Project_96Click(Sender: TObject);
begin
//Экспорт_C_кода_в_Project_96
  ShellExecute(Handle,nil,'C:\Phyton\Proj-96\3_10_07\PICE-196.EXE',nil,nil,SW_Restore);
end;

procedure TMainForm.КомпиляцияClick(Sender: TObject);
begin
//Компиляция
  ShellExecute(Handle,nil,'c:\Program Files\Embarcadero\RAD Studio\10.0\bin\BDS.EXE',nil,nil,SW_Restore);
end;

procedure TMainForm.МоделированиеClick(Sender: TObject);
begin
//Моделирование
  Путь_запуска_:= Резиденцмя_Гиперсистемы +'\Проекты\Итерационное моделирование\Итерационное_моделирование.exe';
  Путь_запуска:= PWideChar(Путь_запуска_);
  ShellExecute(Handle,nil,Путь_запуска,nil,nil,SW_Restore);
end;



procedure TMainForm.Руководство_пользователяClick(Sender: TObject);
begin
//  Руководство_пользователя
  Путь_запуска_:= 'c:\Program Files\Microsoft Office\Office14\WinWord.exe' + Резиденцмя_Гиперсистемы + '\Программная_документация\Описание_применения.docx';
  Путь_запуска:= PWideChar(Путь_запуска_);
  ShellExecute(Handle,nil,Путь_запуска,nil,nil,SW_RESTORE);
end;
procedure TMainForm.ПрезентацияClick(Sender: TObject);
begin
//  Презентация
  Путь_запуска_:= 'c:\Program Files\Microsoft Office\Office14\POWERPNT.EXE' + '/K ' + Резиденцмя_Гиперсистемы + '\Программная_документация\Презентация.pptx';
  Путь_запуска:= PWideChar(Путь_запуска_);
  ShellExecute(Handle,nil,Путь_запуска,nil,nil,SW_RESTORE);
end;
procedure TMainForm.Представление_алгоритмов_на_SFCClick(Sender: TObject);
begin
//  Представление_алгоритмов_на_SFC
    // Преобразование алгоритмов (Предметные конструкции модели) в SFC
    If DirectoryExists(Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Представление_алгоритмов_на_SFC\Pattern_SFC')
       Then Begin
//       ShowMessage('Удаляется папка алгоритма Pattern_SFC!');
       DeleteDir(Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Представление_алгоритмов_на_SFC\Pattern_SFC');
       end;
//    ShowMessage('Копируется  папка шаблона Pattern_SFC!');
    CopyDir(Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Pattern_SFC',Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Представление_алгоритмов_на_SFC\Pattern_SFC');
    Путь_запуска_:= Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Представление_алгоритмов_на_SFC\Gerakl 2 SFC Converter\Win32\Debug\Геракл_SFC.exe';
    Путь_запуска:= PWideChar(Путь_запуска_);
    ShellExecute(Handle,nil,Путь_запуска,nil,nil,SW_Restore);
end;
procedure TMainForm.Представление_функций_на_LDClick(Sender: TObject);
begin
//  Представление_функций_на_LD
    // Преобразование функций (Предметные конструкции модели) в LD
    If DirectoryExists(Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Представление_функций_на_LD\Pattern_LD')
       Then Begin
       ShowMessage('Удаляется папка Функции Pattern_LD!');
       DeleteDir(Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Представление_функций_на_LD\Pattern_LD');
       end;
//    ShowMessage('Копируется  папка шаблона Pattern_LD!');
    CopyDir(Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Pattern_LD',Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Представление_функций_на_LD\Pattern_LD');
    Путь_запуска_:= Резиденцмя_Гиперсистемы +'\Проекты\Визуальное моделирование\Представление_функций_на_LD\Функции_LD\Win32\Debug\Функции_LD.exe';
    Путь_запуска:= PWideChar(Путь_запуска_);
    ShellExecute(Handle,nil,Путь_запуска,nil,nil,SW_Restore);
end;
procedure TMainForm.Представление_функций_на_STClick(Sender: TObject);
begin
//  Представление_функций_на_ST
    // Преобразование функций (Предметные конструкции модели) в ST
       // .. Программа не разработана
end;

procedure TMainForm.Моделирование_алгоритмовClick(Sender: TObject);
  Var Имя_Алгоритма:String;
begin
//  Визуальное_моделирование
  ShowMessage('После моделирования сохраните Pattern_SFC под новым именем!!!');
  if not OpenDialog1.Execute then  begin ShowMessage('Нет компонента OpenDialog!');exit end;
  Имя_Алгоритма:=OpenDialog1.FileName;
//  ShowMessage(Имя_Алгоритма);
  ShellExecute(Handle,nil,PWideChar(Имя_Алгоритма),nil,nil,SW_Restore);
end;


procedure TMainForm.Моделирование_функций_на_LDClick(Sender: TObject);
  Var Имя_Функции:String;
begin
//  Визуальное_моделирование
  ShowMessage('После моделирования сохраните Pattern_LD под новым именем!!!');
  if not OpenDialog1.Execute then  begin ShowMessage('Нет компонента OpenDialog!');exit end;
  Имя_Функции:=OpenDialog1.FileName;
//  ShowMessage(Имя_Функции);
  ShellExecute(Handle,nil,PWideChar(Имя_Функции),nil,nil,SW_Restore);
end;

procedure TMainForm.Моделирование_функций_на_STClick(Sender: TObject);
begin
//  Визуальное_моделирование
  ShellExecute(Handle,nil,'D:\Гиперсистема\\Проекты\Визуальное моделирование\Представление_алгоритмов_на_SFC\Pattern_SFC\Pattern_SFC.isasln',nil,nil,SW_Restore);

end;

procedure TMainForm.Генерация_C_кодаClick(Sender: TObject);
begin
//  Генерация_C_кода
  ShellExecute(Handle,nil,'d:\ЭЛЕКТРИК_МК\ISAGRAF\BUBKU_LD\BUBKU_LD.ISASLN',nil,nil,SW_Restore);
end;

end.

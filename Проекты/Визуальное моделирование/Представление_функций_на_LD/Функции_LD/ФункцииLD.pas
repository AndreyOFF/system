unit ФункцииLD;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, VCL.Forms,
  Dialogs, ExtDlgs, VCL.StdCtrls,VCL.ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label3: TLabel;
    Button4: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit4: TEdit;
    Button5: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    function Транслитерация(str: string): string;
    function СтрокаВДиаграмме(str: string): string;
    function Переменная(str: string): boolean;
    function УстановитьКоординаты(str:string;iter:integer): string;
    function ПолучитьДиаграмму(TS: TStringList): string;
    function ПодсписокВСписок(TS:TStringList; b,e:integer):TStringList;
    function УстановитьТип(TS:TStringList):TStringList;
    function УстановитьСкобки(TS:TStringList):TStringList;
    procedure ЗаписьФайлов();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.Транслитерация(str: string): string;
begin
  str := StringReplace(str, 'А', 'A', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Б', 'B', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'В', 'V', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Г', 'G', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Д', 'D', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Е', 'E', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Ж', 'J', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'З', 'Z', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'И', 'I', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'К', 'K', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Л', 'L', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'М', 'M', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Н', 'N', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'О', 'O', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'П', 'P', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Р', 'R', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'С', 'S', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Т', 'T', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'У', 'Y', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Ф', 'F', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Х', 'X', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Ц', 'C', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Ч', 'H', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Ш', 'W', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Щ', 'W', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Ы', 'Y', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Ь', 'U', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Э', 'E', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Ю', 'YU', [rfReplaceAll, rfIgnoreCase]);
  str := StringReplace(str, 'Я', 'JA', [rfReplaceAll, rfIgnoreCase]);
  Result := str;
end;

function TForm1.Переменная(str: string): boolean;
begin
  if (Str <> '=') and
       (Str <> '(') and
       (Str <> ')') and
       (Str <> '+') and
       (Str <> '*') and
       (Str <> '^') then
       result := true
  else result := false;
end;

function TForm1.УстановитьКоординаты(str:string;iter:integer): string;
var
colToken, rowToken, i, sorRowToken: integer;
TS: TStringList;
begin
   result := ' ';
   colToken := 0;
   rowToken := 0;
   sorRowToken := 1;

   TS := TStringList.Create();
   TS.Delimiter := ' ';
   TS.DelimitedText := str;
   for i := 0 to TS.Count - 1 do
           begin
               if TS.Strings[i] = '[?C?,?R?]' then
               begin
                  if TS.Strings[i-1] = 'SOR' then
                  begin
                    TS.Strings[i] := StringReplace(TS.Strings[i], '?C?', '0', [rfReplaceAll, rfIgnoreCase]);
                    TS.Strings[i] := StringReplace(TS.Strings[i], '?R?', IntToStr(iter), [rfReplaceAll, rfIgnoreCase]);
                    colToken := 1;
                  end;

                  if (TS.Strings[i-1] = 'XIC') or
                     (TS.Strings[i-1] = 'XIO') or
                     (TS.Strings[i-1] = 'EOR') or
                     (TS.Strings[i-1] = 'OTE') or
                     (TS.Strings[i-1] = 'OTS') or
                     (TS.Strings[i-1] = 'OTR') then
                  begin
                    TS.Strings[i] := StringReplace(TS.Strings[i], '?C?', IntToStr(colToken), [rfReplaceAll, rfIgnoreCase]);
                    TS.Strings[i] := StringReplace(TS.Strings[i], '?R?', IntToStr(rowToken), [rfReplaceAll, rfIgnoreCase]);
                    colToken := colToken + 1;
                  end;

               end;
               if TS.Strings[i] = 'EOR' then
                  begin
                     sorRowToken := sorRowToken + 2;
                     //colToken := 0;
                     rowToken := 0;
                  end;


               if (TS.Strings[i] = 'NXB') then
                  begin
                    sorRowToken := sorRowToken + 1;
                    rowToken := rowToken + 1;
                    colToken := 1;
                  end;
               if (TS.Strings[i] = 'BND') then
                  begin
                    rowToken := rowToken - 1;
                  end;
           end;
   for i := 0 to TS.Count - 1 do
           begin
               result := result + ' ' + TS.Strings[i] + ' ';
           end;
end;

function TForm1.ПодсписокВСписок(TS: TStringList; b: Integer; e: Integer) : TStringList;
var
i: integer;
begin
  result := TStringList.Create();
  for i := b to e do
    result.Add(TS.Strings[i]);
end;

function TForm1.УстановитьТип(TS: TStringList) : TStringList;
var
i : integer;
begin
  result := TStringList.Create();
  for i := 2 to TS.Count - 1 do
      begin
        if Переменная(TS.Strings[i]) and
           (i > 0) and
           (TS.Strings[i-1] = '^') then
          TS.Strings[i] := ' XIO [?C?,?R?]  (*' + Транслитерация(TS.Strings[i]) + '*) (*' + TS.Strings[i] + '*) '
        else
          if  Переменная(TS.Strings[i]) then
            TS.Strings[i] := ' XIC [?C?,?R?]  (*' + Транслитерация(TS.Strings[i]) + '*) (*' + TS.Strings[i] + '*) ';
      end;

      for i := 0 to TS.Count - 1 do
        if TS.Strings[i] <> '^' then
          result.Add(TS.Strings[i]);
end;

function TForm1.УстановитьСкобки(TS: TStringList) : TStringList;
var
  i,c,PrevIndex,k : integer;
begin
  result := TStringList.Create();
  c := TS.Count;
      i := 2;

      while i < c do
      begin
        if TS.Strings[i] = '(' then
          PrevIndex := i
        else
          if TS.Strings[i] = ')' then
          begin
            TS.Strings[PrevIndex] := ПолучитьДиаграмму(ПодсписокВСписок(TS,PrevIndex + 1,i-1));

            for k := PrevIndex + 1 to i do
            begin
              TS.Delete(PrevIndex+1);
              c := c - 1;
            end;

            i := 0;
          end;

        i := i + 1;
      end;
      result := TS;
end;

function TForm1.ПолучитьДиаграмму(TS: TStringList): string;
var
  TS_result, TS_result2, TS_result3: TStringList;
  i, j : integer;
begin
  TS_result := TStringList.Create();
  TS_result2 := TStringList.Create();
  TS_result3 := TStringList.Create();
  j := 0;

  for i := 0 to TS.Count - 1 do
    TS_result.Add(TS.Strings[i]);

  for i := 0 to TS.Count - 1 do
  begin
    if TS.Strings[i] = '*' then
    begin
      TS_result.Strings[i-j-1] := TS_result.Strings[i-j-1] + TS.Strings[i+1];
      TS_result.Delete(i-j);
      j := j + 1;
      TS_result.Delete(i-j+1);
      j := j + 1;
    end;
  end;

  for i := 0 to TS_result.Count - 1 do
    TS_result2.Add(TS_result.Strings[i]);

  j := 0;

  for i := 0 to TS_result.Count - 1 do
  begin
    if TS_result.Strings[i] = '+' then
    begin
      TS_result2.Strings[i-j-1] := ' BST ' + TS_result2.Strings[i-j-1] + ' NXB ' + TS_result.Strings[i+1] + ' BND ';
      TS_result2.Delete(i-j);
      j := j + 1;
      TS_result2.Delete(i-j+1);
      j := j + 1;
    end;
  end;

  result := '';
  for i := 0 to TS_result2.Count - 1 do
    result := result + TS_result2.Strings[i] + ' ';
end;

function TForm1.СтрокаВДиаграмме(str: string): string;
var
  TS, TS_result, TS_result2, TS_result3,TS_fom1, TS_fom2 : TStringList;
  Str_result : string;
  i, j, c, k : integer;
  PrevIndex, FOMindex: integer;
  isFOM : boolean;
begin
  isFOM := false;
  PrevIndex := 0;
  TS_fom1 := TStringList.Create();
  TS_fom2 := TStringList.Create();
  TS_result := TStringList.Create();
  TS_result2 := TStringList.Create();
  TS_result3 := TStringList.Create();
  TS := TStringList.Create();
  TS.Delimiter := ' ';
  TS.DelimitedText := str;

  Str_result := '';
  j:= 0;
  if  Переменная(TS.Strings[0]) then
  begin
    if (TS.Strings[1] = '=') then
    begin
      for i := 2 to TS.Count - 3 do
      begin
        if  (TS.Strings[i] = TS.Strings[0]) and
            (TS.Strings[i-1] = '+') and
            (TS.Strings[i+1] = '*') and
            (TS.Strings[i+2] = '^')
            then
        begin
          isFOM := true;
          FOMindex := i;
        end;
      end;

      if isFOM = true then
      begin
        TS_fom1.Add(TS.Strings[0]);
        TS_fom1.Add(TS.Strings[1]);
        TS_fom2.Add(TS.Strings[0]);
        TS_fom2.Add(TS.Strings[1]);
        for i := 2 to FOMindex - 2 do
          TS_fom1.Add(TS[i]);
        for i := FOMindex + 3 to Ts.Count - 1 do
          TS_fom2.Add(TS[i]);
        TS_result := УстановитьСкобки(УстановитьТип(TS_fom1));
        TS_result.Strings[2] := ПолучитьДиаграмму(ПодсписокВСписок(TS_result,2,TS_result.Count-1));
        Str_result := 'SOR [?C?,?R?] (**) (**)' + TS_result.Strings[2] + ' OTS [?C?,?R?] (*' + Транслитерация(TS_fom1.Strings[0]) +'*) (*' + TS_fom1.Strings[0] + '*) ' +#13#10+ 'EOR [?C?,?R?] ';
        TS_result.Clear();
        TS_result := УстановитьСкобки(УстановитьТип(TS_fom2));
        TS_result.Strings[2] := ПолучитьДиаграмму(ПодсписокВСписок(TS_result,2,TS_result.Count-1));
        Str_result := Str_result + #13#10+#13#10+'(**)'+#13#10+#13#10+'SOR [?C?,?R?] (**) (**)' + TS_result.Strings[2] + ' OTR [?C?,?R?] (*' + Транслитерация(TS_fom2.Strings[0]) +'*) (*' + TS_fom2.Strings[0] + '*) ' +#13#10+ 'EOR [?C?,?R?] ';

      end
      else
      begin
        TS_result := УстановитьСкобки(УстановитьТип(TS));
        TS_result.Strings[2] := ПолучитьДиаграмму(ПодсписокВСписок(TS_result,2,TS_result.Count-1));
        Str_result := 'SOR [?C?,?R?] (**) (**)' + TS_result.Strings[2] + ' OTE [?C?,?R?] (*' + Транслитерация(TS.Strings[0]) +'*) (*' + TS.Strings[0] + '*) ' +#13#10+ 'EOR [?C?,?R?] ';
      end;
    end;

  end;


  result := str_result;
end;

procedure TForm1.ЗаписьФайлов();
var
  TS_src,TS_res_varst,TS_res_vars,TS_res_diag,TS_vars,TS_diag: TStringList;
  i,l: integer;
  TS : TStringList;
  s_all,S_src: string;
  Str_result: string;
  TF_src: TextFile;
  VarsIndex, PouBodyIndex: integer;
begin

  TS_res_vars := TStringList.Create();
  TS_res_varst := TStringList.Create();
  TS_res_diag := TStringList.Create();
  TS_src := TStringList.Create();
  s_all := '';
  AssignFile(TF_src, Edit1.Text);
  reset(TF_src);
     l:=0;
    while not eof(TF_src) do begin
      readln(TF_src, S_src); // в переменную str будут сохраняться строки из файла... по очереди...
      Trim(S_src);  // удаление граничных пробелов
      TS_src.Insert(TS_src.Count,S_src);
      S_src := AnsiUpperCase(S_src); // перевод в верхний регистр
      TS_res_diag.Add(СтрокаВДиаграмме(S_src)); //преобразование функции в STF-формат
      s_all := s_all + s_src + ' ';
    end;
   CloseFile(TF_src);
   TS := TStringList.Create();
   TS.Delimiter := ' ';
   TS.DelimitedText := s_all;

  //----------------копируем уникальные переменные в TS_result
  for i := 0 to TS.Count - 1 do
  begin
    if (TS.Strings[i] <> '=') and
       (TS.Strings[i] <> '(') and
       (TS.Strings[i] <> ')') and
       (TS.Strings[i] <> '+') and
       (TS.Strings[i] <> '*') and
       (TS.Strings[i] <> '^') and
       (TS_res_vars.IndexOf(TS.Strings[i]) = -1) then begin
      TS_res_vars.Add(TS.Strings[i]);
      TS_res_varst.Add(Транслитерация(TS.Strings[i]));
       end;
  end;
  //--------------чтение указанного файла словаря-----------
  TS_vars := TStringList.Create();
  TS_vars.LoadFromFile(Edit3.Text);
  for i := 0 to TS_vars.Count-1 do
    TS_vars[i]:=Trim(TS_vars[i]);

  //--------------запись переменных в файл-----------
  if Edit2.Text=Edit3.Text then begin  //проверка: хранятся ли переменные в том же файле, что и программа
    VarsIndex:=TS_vars.IndexOf('<LocalVars />')+1;
    if VarsIndex<>0 then begin
      TS_vars[VarsIndex-1]:='<LocalVars>';
      TS_vars.Insert(VarsIndex,'</LocalVars>')
    end
    else begin
      VarsIndex:=TS_vars.IndexOf('</LocalVars>');
    end;

  end
  else begin
    VarsIndex:=TS_vars.IndexOf('<GlobalVars />')+1;
    if VarsIndex<>0 then begin
      TS_vars[VarsIndex-1]:='<GlobalVars>';
      TS_vars.Insert(VarsIndex,'</GlobalVars>');
    end
    else
      VarsIndex:=TS_vars.IndexOf('</GlobalVars>');
  end;
  for i := TS_res_vars.Count - 1 downto 0 do
  begin
     TS_vars.Insert( VarsIndex,'<Variable Name="'+TS_res_varst[i]+'" DataType="BOOL" InitialValue="" Comment="" Address="" Modifier="NonRetain" Kind="Var" Alias="'+TS_res_vars[i]+'" AccessRights="ReadWrite" StringSize="0" />');
  end;
  TS_res_vars.Free;
  TS_res_varst.Free;
  TS_vars.SaveToFile(Edit3.Text);
  TS_vars.Free;



//----------------чтение указанного файла диаграмм-----------
  TS_diag := TStringList.Create();
  TS_diag.LoadFromFile(Edit2.Text);
  for i := 0 to TS_vars.Count-1 do
    TS_diag[i]:=Trim(TS_diag[i]);
//----------------определение положения тела программы в указанном файле диаграмм-----------
  PouBodyIndex:=TS_diag.IndexOf('EOF');
//----------------вставка ступеней диаграммы-----------
  //Str_result := УстановитьКоординаты(Str_result);

  for i := TS_res_diag.Count - 1 downto 0 do begin

    TS_diag.Insert(PouBodyIndex, УстановитьКоординаты(TS_res_diag.Strings[i],i+2));
    TS_diag.Insert(PouBodyIndex,#13#10+'(*'+TS_src[i]+'*)'+#13#10);
  end;
  TS_res_diag.Free;
  TS_diag.SaveToFile(Edit2.Text);
  TS_diag.Free;

  DeleteFile(Edit4.Text);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenTextFileDialog1.Filter:='Файл с логическими формулами *.*|*.*';
  if OpenTextFileDialog1.Execute then
    Edit1.Text := OpenTextFileDialog1.FileName;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  OpenTextFileDialog1.Filter:='Файлы словаря *.isaxml| *.isaxml';
  if OpenTextFileDialog1.Execute then
    Edit2.Text := OpenTextFileDialog1.FileName;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  OpenTextFileDialog1.Filter:='Файлы диаграмм *.isaxml| *.isaxml';

  if OpenTextFileDialog1.Execute then
    Edit3.Text := OpenTextFileDialog1.FileName;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  try
    ЗаписьФайлов(); // создание словаря и диаграммы (можно в разных файлах) .isaxml
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  OpenTextFileDialog1.Filter:='Файлы кэша проекта PrjLibrary.mdb| PrjLibrary.mdb';

  if OpenTextFileDialog1.Execute then
    Edit4.Text := OpenTextFileDialog1.FileName;
end;
end.

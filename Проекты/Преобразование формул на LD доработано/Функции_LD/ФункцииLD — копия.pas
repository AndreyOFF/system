
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
  DeleteFile(Edit5.Text);
end;
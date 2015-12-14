unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Generics.Collections,
  Graphics, Controls, Forms,
  Dialogs, StdCtrls, Visio_TLB, COMOBJ;

function ToStr(Value: Variant): String;
function CompareShapeName(shp: Shape; name: String): Boolean;
function GetBeginShapeIndex(): Integer;
function GetEndShapeIndex(): Integer;
function GetShapeWithIndex(indx: Integer): Shape;
function SearchMaxBlockListFigure_2(min_block: Integer): Integer;
function SearchMinBlockListFigure_2(max_block: Integer): Integer;
function GetShapeText(indx: Integer): String;
function PrepareComment1(currText: String; nextText: String): String;
function PrepareComment2(currText: String): String;
function GetCountBlockInWhile(indx_figure: Integer): Integer;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  figures: Array of Shape; // массив всех элементов фигур и связей
  connects: Array of Shape; // массив всех элементов связей
  shapes: Array of Shape; // массив всех элементов фигур

  elements: Array of Shape; // массив всех элементов фигур и связей
  connections: Array of Shape; // массив всех элементов связей
  figurs: Array of Shape; // массив всех элементов фигур
  connect_info: Array of Array of SmallInt; // массив всех элементов фигур
  figur_info: Array of Array of Integer; // массив всех элементов фигур
  str_info: String;
  temp_cur_left_while, temp_cur_right_while: Integer;

var
  list_passable_element: TList<Integer>;
  // список  list типа int  хранящий пройденные элементы

var
  list_passable_element_2: TList<Integer>;
  // список  list типа int  хранящий пройденные элементы

implementation

{$R *.dfm}

//Передаем значение и получаем строку
function ToStr(Value: Variant): String;
begin
  case TVarData(Value).VType of
    varSmallInt, varInteger:
      Result := IntToStr(Value);
    varSingle, varDouble, varCurrency:
      Result := FloatToStr(Value);
    varDate:
      Result := FormatDateTime('dd/mm/yyyy', Value);
    varBoolean:
      if Value then
        Result := 'T'
      else
        Result := 'F';
    varString:
      Result := Value;
  else
    Result := '';
  end;
end;
// 'Terminator', 'Process', 'Decision', 'Dynamic connector', 'Predefined process', 'Annotation'
// Проверяем объект на тип указанный в парамметре
function CompareShapeName(shp: Shape; name: String): Boolean;
var
  t: TStringList;
begin
  t := TStringList.create;
  t.Text := stringReplace(shp.NameU, '.', #13#10, [rfReplaceAll]);
  // заменяем точку, на перевод строки (везде)
  if AnsiCompareStr(t[0], name) = 0 then // Сравнивает последовательности
    Result := True
  else
    Result := False;
end;
// получаем элемент по индексу фигуры
function GetShapeWithIndex(indx: Integer): Shape;
var
  i: Integer;
begin
  for i := 0 to High(elements) do // проходимся по массиву figures
  begin
    if elements[i].index = indx then // ищем индекс нужного элемента
    begin
      Result := elements[i]; // возвращаем индетификатор элемента
      Break;
    end;
  end;
end;
// получаем текст фигуры
function GetShapeText(indx: Integer): String;
begin
  Result := GetShapeWithIndex(indx).Text; // получаем текст блока
end;
// Получаем Index фигуры начала
function GetBeginShapeIndex(): Integer;
var
  i: Integer; // счетчики i и j
var
  flag: Boolean; // флаг
begin
  Result := -1;
  for i := 0 to High(figurs) do // проходимся по массиву figurs
  begin
    flag := False;
    if CompareShapeName(figurs[i], 'Start/End') OR
      CompareShapeName(figurs[i], 'Terminator') then
    begin
      flag := True;
    end;

    if flag then
    begin
      Result := figurs[i].index; // получаем индекс начала
      Break;
    end;
  end;
end;
// Получаем Index фигуры конца
function GetEndShapeIndex(): Integer;
var
  i, Count: Integer;
var
  flag: Boolean;
begin
  Result := -1;
  Count := 0;
  for i := 0 to High(figurs) do // проходимся по массиву figurs
  begin
    flag := False;
    if CompareShapeName(figurs[i], 'Start/End') OR
      CompareShapeName(figurs[i], 'Terminator') then
    begin
      flag := True;
      Count := Count + 1;
    end;

    if flag AND (Count = 2) then
    begin
      Result := figurs[i].index; // получаем индекс конца
      Break;
    end;
  end;
end;
// формирование текста
function PrepareComment1(currText: String; nextText: String): String;
var
  res, first, second: String;
var
  posSymbol, lenComm: Integer;
var
  currComm, prevComm: String;
begin
  currComm := currText; // текст элемента
  prevComm := nextText;
  if Pos('FKU', prevComm) > 0 then // в тексте слово FKU
  begin
    prevComm := Copy(prevComm, 5, Length(prevComm));
    // формируем первый элемент и второй элемент
    first := Copy(currComm, 0, Pos('=', currComm) - 1);
    second := Copy(currComm, Pos('=', currComm) + 1, 1);
    // записываем полученный текст
    res := prevComm + '(' + first + ',' + second + ')';
  end
  else if Pos(' ', currComm) > 0 then
  begin
    res := 'Ком: ' + currComm; // остальное все тексты комментарии
  end
  else
  begin
    lenComm := Length(currComm);
    posSymbol := Pos(';', currComm);

    if posSymbol > 0 then
    begin
      while (posSymbol > 0) OR (lenComm > 0) do
      begin
        if (posSymbol > 0) then
        begin
          if (posSymbol <> lenComm) then
          begin
            res := res + Copy(currComm, 0, posSymbol - 1) + #13#10;
          end
          else
            res := res + Copy(currComm, 0, posSymbol - 1);
          currComm := Copy(currComm, posSymbol + 1);
          lenComm := Length(currComm);
          posSymbol := Pos(';', currComm);
        end
        else
        begin
          if (lenComm > 0) then
          begin
            res := res + currComm;
            currComm := '';
            lenComm := Length(currComm);
          end;
        end;
      end;
    end
    else
      res := currComm; // записываем полученный текст
  end;
  Result := res; // возвращаем сформированный текст
end;
// формирование текста
function PrepareComment2(currText: String): String;
var
  first, second, curr_temp_Text: String;
begin
  curr_temp_Text := currText;
  while(Pos('AND',curr_temp_Text) > 0) do
    begin
      first := Copy(curr_temp_Text,0,Pos('AND',curr_temp_Text)-1);
      second := Copy(curr_temp_Text,Pos('AND',curr_temp_Text)+3);
      curr_temp_Text := first + '^' + second;
    end;
  while(Pos('OR',curr_temp_Text) > 0) do
    begin
      first := Copy(curr_temp_Text,0,Pos('OR',curr_temp_Text)-1);
      second := Copy(curr_temp_Text,Pos('OR',curr_temp_Text)+2);
      curr_temp_Text := first + '*' + second;
    end;
  Result := curr_temp_Text; // возвращаем сформированный текст
end;
// получаем чиcло соответсвующее типу фигуры
function GetTypeFigure(indx_figure: Integer): Integer;
begin
  if CompareShapeName(GetShapeWithIndex(indx_figure), 'Start/End') OR
    CompareShapeName(GetShapeWithIndex(indx_figure), 'Terminator') then
  begin
    Result := 1;
  end
  else if CompareShapeName(GetShapeWithIndex(indx_figure), 'Process') then
  begin
    Result := 2;
  end
  else if CompareShapeName(GetShapeWithIndex(indx_figure), 'Decision') then
  begin
    Result := 3;
  end
  else if CompareShapeName(GetShapeWithIndex(indx_figure), 'Subprocess') then
  begin
    Result := 4
  end
  else
    Result := 0;
end;
// получаем позицию стрелки, отходящей из фигуры, в массиве connections
function GetArrowNextConn(indx_figure: Integer; cnt: Integer): Integer;
var
  i, Count: Integer;
begin
  Count := 0;
  for i := 0 to High(connections) do
  begin
    if (connections[i].connects[1].ToSheet.index = indx_figure) then
    begin
      Count := Count + 1;

      if (Count = cnt) then
        Result := i;
    end;
  end;
end;
// Получаем количество стрелок входящих в данный процесс
function CountProccInArray(indx_figure: Integer): Integer;
var
  i, Count: Integer;
begin
  Count := 0;
  for i := 0 to High(connections) do
  begin
    if (connections[i].connects[2].ToSheet.index = indx_figure) then
    begin
      Count := Count + 1;
    end;
  end;
  Result := Count;
end;
// ищем входит ли данная фигура в список пройденных фигур
function SearchListFigure(indx_figure: Integer): Boolean;
var
  i: Integer;
var
  res: Boolean;
begin
  res := False;
  for i := 0 to (list_passable_element.Count - 1) do
  begin
    if (list_passable_element.Items[i] = indx_figure) then
    begin
      res := True;
      Break;
    end;
  end;

  Result := res;
end;
// ищем входит ли данная фигура в список пройденных фигур
function SearchListFigure_2(indx_figure: Integer): Boolean;
var
  i: Integer;
var
  res: Boolean;
begin
  res := False;
  for i := 0 to (list_passable_element_2.Count - 1) do
  begin
    if (list_passable_element_2.Items[i] = indx_figure) then
    begin
      res := True;
      Break;
    end;
  end;

  Result := res;
end;
// переданному элементу в информации изменяем номер блока
function UpdateInfoFigureBlock(curF: Integer; num_block: Integer): Integer;
var
  i: Integer;
begin
  for i := 0 to High(figur_info) do
  begin
    if (figur_info[i, 0] = curF) then
      figur_info[i, 1] := num_block;
  end;
end;
// получаем номер блока, находящейся в ней фигуры
function GetInfoFigureBlock(curF: Integer): Integer;
var
  i: Integer;
begin
  for i := 0 to High(figur_info) do
  begin
    if (figur_info[i, 0] = curF) then
      Result := figur_info[i, 1];
  end;
end;
//Проверяем помечен ли блоком фигура, если да - возвращаем номер блока, иначе присваиваем текущий
function ProvFigureNext(curF: Integer; num_block: Integer): Integer;
var
  i: Integer;
begin
  i := GetInfoFigureBlock(curF);
  if (i > 0) then
  begin
    Result := i;
  end
  else
  begin
    UpdateInfoFigureBlock(curF, num_block);
    Result := num_block;
  end;
end;
// получаем количество блоков, которые возникают в результате условия
function GetCountBlockInWhile(indx_figure: Integer): Integer;
var
  cur_figure, cur_conn_pos, cur_next_figure, blockcount, count_el, type_figure,
     res_while: Integer;
var
  flag, prov: Boolean;
begin
  flag := True;
  blockcount := 0;
  count_el := 0;
  cur_conn_pos := GetArrowNextConn(indx_figure, 1);
  cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;

  while flag do
  begin
    cur_figure := cur_next_figure;
    type_figure := GetTypeFigure(cur_figure);

    if not SearchListFigure(cur_figure) then
    begin
      list_passable_element.Add(cur_figure);
      prov := True;
    end
    else
      prov := False;

    if (type_figure = 1) then
    begin
      flag := False;
      if prov then
        blockcount := blockcount + 1;
      if count_el > 0 then
      begin
        blockcount := blockcount + 1;
        count_el := 0;
      end;
    end
    else if (type_figure = 3) then
    begin
      if prov then
        blockcount := blockcount + 1;
      if count_el > 0 then
      begin
        blockcount := blockcount + 1;
        count_el := 0;
      end;
      res_while := GetCountBlockInWhile(cur_figure);
      blockcount := blockcount + res_while;
      flag := False;
    end
    else if ((type_figure = 2) OR (type_figure = 4)) AND
      (CountProccInArray(cur_figure) > 1) then
    begin
      if prov then
        blockcount := blockcount + 1;
      if count_el > 0 then
      begin
        blockcount := blockcount + 1;
        count_el := 0;
      end;
      cur_conn_pos := GetArrowNextConn(cur_figure, 1);
      // получение позиции в массиве connections следующей стрелки
      cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;
      // получаем следущюю фигуру, стрелка на который указывает
    end
    else
    begin
      if prov then
        count_el := count_el + 1;
      cur_conn_pos := GetArrowNextConn(cur_figure, 1);
      // получение позиции в массиве connections следующей стрелки
      cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;
      // получаем следущюю фигуру, стрелка на который указывает
    end;
  end;
  flag := True;

  cur_conn_pos := GetArrowNextConn(indx_figure, 2);
  cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;
  count_el := 0;

  while flag do
  begin
    cur_figure := cur_next_figure;
    type_figure := GetTypeFigure(cur_figure);

    if not SearchListFigure(cur_figure) then
    begin
      list_passable_element.Add(cur_figure);
      prov := True;
    end
    else
      prov := False;

    if (type_figure = 1) then
    begin
      flag := False;
      if prov then
        blockcount := blockcount + 1;
      if count_el > 0 then
      begin
        blockcount := blockcount + 1;
        count_el := 0;
      end;
    end
    else if (type_figure = 3) then
    begin
      if prov then
        blockcount := blockcount + 1;
      if count_el > 0 then
      begin
        blockcount := blockcount + 1;
        count_el := 0;
      end;
      res_while := GetCountBlockInWhile(cur_figure);
      blockcount := blockcount + res_while;
      flag := False;
    end
    else if ((type_figure = 2) OR (type_figure = 4)) AND
      (CountProccInArray(cur_figure) > 1) then
    begin
      if prov then
        if prov then
          blockcount := blockcount + 1;
      if count_el > 0 then
      begin
        blockcount := blockcount + 1;
        count_el := 0;
      end;
      cur_conn_pos := GetArrowNextConn(cur_figure, 1);
      // получение позиции в массиве connections следующей стрелки
      cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;
      // получаем следущюю фигуру, стрелка на который указывает
    end
    else
    begin
      if prov then
        count_el := count_el + 1;
      cur_conn_pos := GetArrowNextConn(cur_figure, 1);
      // получение позиции в массиве connections следующей стрелки
      cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;
      // получаем следущюю фигуру, стрелка на который указывает
    end;
  end;

  Result := blockcount;
end;
//Поиск минимального блока в list
function SearchMinBlockListFigure_2(max_block: Integer): Integer;
var
  i, min_block, temp, res: Integer;
begin
  res := -1;
  min_block := max_block;
  for i := 0 to (list_passable_element_2.Count - 1) do
  begin
    temp := GetInfoFigureBlock(list_passable_element_2.Items[i]);
    if (temp < min_block) then
    begin
      min_block := temp;
      res := list_passable_element_2.Items[i];
    end;
  end;

  Result := res;
end;
//Поиск максимального блока в list
function SearchMaxBlockListFigure_2(min_block: Integer): Integer;
var
  i, max_block, res, temp: Integer;
begin
  res := -1;
  max_block := min_block - 1;
  for i := 0 to (list_passable_element_2.Count - 1) do
  begin
    temp := GetInfoFigureBlock(list_passable_element_2.Items[i]);
    if (GetInfoFigureBlock(list_passable_element_2.Items[i]) > max_block) then
    begin
      max_block := temp;
      res := list_passable_element_2.Items[i];
    end;
  end;

  Result := res;
end;
//проверяем текущую фигуру получаем ее блок и сравниваем с текущим
function ProvFigureBlock(indx: Integer; now_block: Integer):Boolean;
var temp: Integer;
begin
  temp := GetInfoFigureBlock(indx);
  if(temp < now_block) then
    begin
      Result := false;
    end
  else
    Result := true;
end;
//Выводим в последовательности все блоки
function GetTextAll(): String;
var
  cur_left, cur_right, cur_next_figure_left, cur_next_figure_right
    : Integer; // счетчик для добавления элементов в list
var
  blockcount, next_numblock, temp_cur_figure, temp_type_figure,
    temp_cur_conn_pos, cur_figure, block_num, cur_next_figure, cur_conn_pos,
    next_type_figure, type_figure, res_while, count_el, cur_conn_pos_left,
    cur_conn_pos_right, max_block_now, get_block: Integer;
var
  Text, str_dop: String; // записываемая строка
var
  prov, prov_2: Boolean;

begin
  blockcount := 0;
  count_el := 0;
  cur_figure := GetBeginShapeIndex();
  list_passable_element.Add(cur_figure);
  Text := 'Нач: ' + GetShapeText(GetBeginShapeIndex()) + #13#10;

  cur_conn_pos := GetArrowNextConn(cur_figure, 1);
  // получение позиции в массиве connections следующей стрелки
  cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;
  // получаем следущюю фигуру, стрелка на который указывает

  while (list_passable_element.Count <> Length(figurs)) do
  begin
    cur_figure := cur_next_figure;
    type_figure := GetTypeFigure(cur_figure);

    if not SearchListFigure(cur_figure) then
    begin
      list_passable_element.Add(cur_figure);
      prov := True;
    end
    else
      prov := False;

    if (type_figure = 1) then
    begin
      if prov then
        blockcount := blockcount + 1;
      if count_el > 0 then
      begin
        blockcount := blockcount + 1;
        count_el := 0;
      end;
    end
    else if (type_figure = 3) then
    begin
      if prov then
        blockcount := blockcount + 1;
      if count_el > 0 then
      begin
        blockcount := blockcount + 1;
        count_el := 0;
      end;
      res_while := GetCountBlockInWhile(cur_figure);
      blockcount := blockcount + res_while;
    end
    else if ((type_figure = 2) OR (type_figure = 4)) AND
      (CountProccInArray(cur_figure) > 1) then
    begin
      if prov then
        blockcount := blockcount + 1;
      if count_el > 0 then
      begin
        blockcount := blockcount + 1;
        count_el := 0;
      end;
      cur_conn_pos := GetArrowNextConn(cur_figure, 1);
      // получение позиции в массиве connections следующей стрелки
      cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;
      // получаем следущюю фигуру, стрелка на который указывает
    end
    else
    begin
      if prov then
        count_el := count_el + 1;
      cur_conn_pos := GetArrowNextConn(cur_figure, 1);
      // получение позиции в массиве connections следующей стрелки
      cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;
      // получаем следущюю фигуру, стрелка на который указывает
    end;
  end;
  //Text := Text + '  Begin='+ToStr(blockcount)+ #13#10;

  block_num := 0;
  cur_figure := GetBeginShapeIndex();

  cur_conn_pos := GetArrowNextConn(cur_figure, 1);
  // получение позиции в массиве connections следующей стрелки
  cur_next_figure := connections[cur_conn_pos].connects[2].ToSheet.index;
  // получаем следущюю фигуру, стрелка на который указывает


  list_passable_element_2.Add(cur_next_figure);
  UpdateInfoFigureBlock(cur_next_figure, 1);

  UpdateInfoFigureBlock(GetEndShapeIndex(), blockcount);

  while (block_num <> (blockcount)) AND (list_passable_element_2.Count <> 0) do
  begin
    cur_figure := SearchMinBlockListFigure_2(blockcount);
    get_block := ProvFigureNext(cur_figure, 0);

    if block_num = get_block then
    begin
      type_figure := GetTypeFigure(cur_figure);
      if (type_figure = 1) then
      begin
        block_num := block_num + 1;
      end
      else if (type_figure = 3) then
      begin
        cur_conn_pos_left := GetArrowNextConn(cur_figure, 1);
        cur_next_figure_left := connections[cur_conn_pos_left].connects[2]
          .ToSheet.index;
        cur_conn_pos_right := GetArrowNextConn(cur_figure, 2);
        cur_next_figure_right := connections[cur_conn_pos_right].connects[2]
          .ToSheet.index;

        max_block_now := GetInfoFigureBlock
          (SearchMaxBlockListFigure_2(block_num));
        cur_left := ProvFigureNext(cur_next_figure_left, max_block_now + 1);

        if (cur_left <> blockcount) AND ((max_block_now + 1) = cur_left) then
        begin
          if ProvFigureBlock(cur_next_figure_left, block_num) then
            begin
              list_passable_element_2.Remove(cur_next_figure_left);
              list_passable_element_2.Add(cur_next_figure_left);
            end;
        end;

        max_block_now := GetInfoFigureBlock
          (SearchMaxBlockListFigure_2(block_num));
        cur_right := ProvFigureNext(cur_next_figure_right, max_block_now + 1);

        if (cur_right <> blockcount) AND ((max_block_now + 1) = cur_right) then
        begin
          if ProvFigureBlock(cur_next_figure_right, block_num) then
            begin
              list_passable_element_2.Remove(cur_next_figure_right);
              list_passable_element_2.Add(cur_next_figure_right);
            end;
        end;
        Text := Text + 'Если ' + PrepareComment2(GetShapeText(cur_figure)) + ' то ' +
          IntToStr(cur_left) + ' иначе ' + IntToStr(cur_right) + #13#10;
      end
      else if (type_figure = 4) then
      begin
        temp_cur_conn_pos := GetArrowNextConn(cur_figure, 1);
        // получение позиции в массиве connections следующей стрелки
        temp_cur_figure := connections[temp_cur_conn_pos].connects[2]
          .ToSheet.index;
        temp_type_figure := GetTypeFigure(temp_cur_figure);
        prov := True;

        if (((temp_type_figure = 2) OR (temp_type_figure = 4)) AND
          (CountProccInArray(temp_cur_figure) > 1)) OR (temp_type_figure = 3) OR
          (CountProccInArray(cur_figure) > 1) then
        begin
          max_block_now := GetInfoFigureBlock
            (SearchMaxBlockListFigure_2(block_num));
          // ProvFigureNext(temp_cur_figure, max_block_now + 1);
          if (ProvFigureNext(temp_cur_figure, max_block_now + 1) <> blockcount)
            AND prov then
          begin
            if ProvFigureBlock(temp_cur_figure, block_num) then
              begin
                list_passable_element_2.Remove(temp_cur_figure);
                list_passable_element_2.Add(temp_cur_figure);
              end;
          end;
          prov := False;
        end;

        prov_2 := False;
        if (ProvFigureNext(temp_cur_figure, block_num) <> blockcount) AND prov
        then
        begin
          if ProvFigureBlock(temp_cur_figure, block_num) then
            begin
              list_passable_element_2.Remove(temp_cur_figure);
              list_passable_element_2.Add(temp_cur_figure);
            end;
          prov_2 := False;
        end
        else if ((ProvFigureNext(temp_cur_figure, block_num)) <> block_num) AND
          (ProvFigureNext(temp_cur_figure, block_num) <> blockcount) then
        begin
          prov_2 := True;
          str_dop := IntToStr(ProvFigureNext(temp_cur_figure, block_num)
            ) + #13#10
        end
        else
        begin
          prov_2 := True;
          str_dop := IntToStr(blockcount) + #13#10
        end;

        Text := Text + GetShapeText(cur_figure) + '()' + #13#10;

        if prov_2 then
          Text := Text + str_dop;

      end
      else if (type_figure = 2) then
      begin
        temp_cur_conn_pos := GetArrowNextConn(cur_figure, 1);
        // получение позиции в массиве connections следующей стрелки
        temp_cur_figure := connections[temp_cur_conn_pos].connects[2]
          .ToSheet.index;
        // получаем следущюю фигуру, стрелка на который указывает
        temp_type_figure := GetTypeFigure(temp_cur_figure);
        prov := True;
        if (((temp_type_figure = 2) OR (temp_type_figure = 4)) AND
          (CountProccInArray(temp_cur_figure) > 1)) OR (temp_type_figure = 3) OR
          (CountProccInArray(cur_figure) > 1) then
        begin
          max_block_now := GetInfoFigureBlock
            (SearchMaxBlockListFigure_2(block_num));
          next_numblock := ProvFigureNext(temp_cur_figure, max_block_now + 1);
          if ProvFigureBlock(temp_cur_figure, block_num) then
            begin
              list_passable_element_2.Remove(temp_cur_figure);
              list_passable_element_2.Add(temp_cur_figure);
            end;
          str_dop := IntToStr(next_numblock) + #13#10;
          prov := False;
        end;
        /// ////////////
        if (temp_type_figure = 4) then
        begin
          // добавляем в позицию если равен текущему, то добавить в лист
          if ((ProvFigureNext(temp_cur_figure, block_num)) = block_num) AND
            (CountProccInArray(cur_figure) <= 1) then
          begin
            cur_conn_pos := GetArrowNextConn(temp_cur_figure, 1);
            cur_next_figure := connections[cur_conn_pos].connects[2]
              .ToSheet.index;
            next_type_figure := GetTypeFigure(cur_next_figure);

            prov := True;

            if (((next_type_figure = 2) OR (next_type_figure = 4)) AND
              (CountProccInArray(cur_next_figure) > 1)) OR (next_type_figure = 3)
            then
            begin
              max_block_now := GetInfoFigureBlock
                (SearchMaxBlockListFigure_2(block_num));
              next_numblock := ProvFigureNext(cur_next_figure,
                max_block_now + 1);
              str_dop := IntToStr(next_numblock) + #13#10;
              if ProvFigureBlock(cur_next_figure, block_num) then
                begin
                  list_passable_element_2.Remove(cur_next_figure);
                  list_passable_element_2.Add(cur_next_figure);
                end;
              prov := False;
            end
            else if (ProvFigureNext(cur_next_figure, block_num) <> blockcount)
              AND prov then
            begin
              if ProvFigureBlock(cur_next_figure, block_num) then
                begin
                  list_passable_element_2.Remove(cur_next_figure);
                  list_passable_element_2.Add(cur_next_figure);
                end;
              prov := True;
            end
            else if (ProvFigureNext(cur_next_figure, block_num) = blockcount)
            then
            begin
              str_dop := IntToStr(blockcount) + #13#10;
              prov := False;
            end;

            Text := Text + PrepareComment1(GetShapeText(cur_figure),
              ' FKU' + GetShapeText(temp_cur_figure)) + #13#10;

            if not prov then
              Text := Text + str_dop;
          end
          else
          begin
            Text := Text + PrepareComment1(GetShapeText(cur_figure), '') +
              #13#10 + IntToStr(ProvFigureNext(temp_cur_figure, block_num)
              ) + #13#10;
          end
        end
        else if (temp_type_figure = 2) then
        begin
          if (prov) then
          begin
            ProvFigureNext(temp_cur_figure, block_num);
            if ProvFigureBlock(temp_cur_figure, block_num) then
              begin
                list_passable_element_2.Remove(temp_cur_figure);
                list_passable_element_2.Add(temp_cur_figure);
              end;
            Text := Text + PrepareComment1(GetShapeText(cur_figure),
              '') + #13#10;
          end
          else
          begin
            Text := Text + PrepareComment1(GetShapeText(cur_figure), '') +
              #13#10 + IntToStr(ProvFigureNext(temp_cur_figure, block_num)
              ) + #13#10;
          end;
        end
        else if (temp_type_figure = 1) then
        begin
          Text := Text + PrepareComment1(GetShapeText(cur_figure), '') + #13#10
            + IntToStr(blockcount) + #13#10;
        end
        else
        begin
          Text := Text + PrepareComment1(GetShapeText(cur_figure), '') + #13#10
            + str_dop;
        end;
      end;
      list_passable_element_2.Remove(cur_figure);
    end
    else
    begin
      block_num := block_num + 1;
      if(block_num < blockcount) then
        Text := Text + IntToStr(block_num) + ':' + #13#10;
    end;

  end;


  Text := Text + IntToStr(blockcount)+ ':' + #13#10 + 'Кон: ' + GetShapeText(GetEndShapeIndex()) + #13#10;

  Result := Text;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  app: Visio_TLB.VisioApplication;
var
  doc: Visio_TLB.Document;
var
  i: Integer;
begin
  str_info := '';
  list_passable_element := TList<Integer>.create;
  list_passable_element_2 := TList<Integer>.create;
  temp_cur_left_while := -1;
  temp_cur_right_while := -1;
  app := CreateComObject(CLASS_VisioApplication) as Visio_TLB.VisioApplication;
  doc := app.Documents.Open('D:\visio.vsd') as Visio_TLB.Document;
  for i := 1 to doc.Pages[1].shapes.Count do
    // doc.Pages[1].Shapes - коллекция элементо
    if not CompareShapeName(doc.Pages[1].shapes[i], 'Annotation') then
    // добавляем все элементы кроме типа анотации
    begin
      SetLength(elements, Length(elements) + 1); // рассширяем массив elements
      elements[High(elements)] := doc.Pages[1].shapes[i];
      // добавляем в массив elements новый элемент
    end;

  for i := 0 to High(elements) do
  begin
    if CompareShapeName(elements[i], 'Dynamic connector') then
    // заполняем массив стрелок
    begin
      SetLength(connections, Length(connections) + 1);
      // рассширяем массив connections
      connections[High(connections)] := elements[i];
      // добавляем в массив connections новый элемент
    end
    else
    begin
      SetLength(figurs, Length(figurs) + 1);
      // Устанавливает длину последовательности, рассширяем массив figurs
      SetLength(figur_info, Length(figur_info) + 1);
      SetLength(figur_info[High(figur_info)], 2);
      figurs[High(figurs)] := elements[i];
      // добавляем в массив figurs новый элемент
      figur_info[High(figur_info), 0] := elements[i].index;
      figur_info[High(figur_info), 1] := -1;
    end;
  end;

  // Memo1.Text := GetShapeText(connections[GetArrowNextConn(GetBeginShapeIndex())].Connects[2].ToSheet.Index);
  // Memo1.Text := 'Begin='+GetShapeText(GetBeginShapeIndex())+'   End='+GetShapeText(GetEndShapeIndex());
  Memo1.Text := '';
  Memo1.Text := GetTextAll();

  doc.Close();
  app.Quit();
end;

end.

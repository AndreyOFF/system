unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Generics.Collections, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Visio_TLB, COMOBJ;

function ToStr(Value: Variant): String;
function CompareShapeName(shp: Shape; name: String): Boolean;
function GetShapeName(shp: Shape): String;
function GetBeginShapeIndex(): Integer;
function GetEndShapeIndex(): Integer;
function GetShapeWithIndex(indx: Integer): Shape;
function GetFromConnectsCount( indx: Integer): Integer;
function GetNextElemIndex(indx: Integer; number: Integer): Integer;
function GetAll(): String;
function GetShapeText(indx: Integer): String;
function PrepareComment1(curr: Integer): String;
function PrepareComment2(index: Integer): String;
function ArrSearch(arr: Array of Integer; num:Integer): Integer;
function GetPrevElemIndex(indx: Integer): Integer;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  figures: Array of Shape;
  connects: Array of Shape;
  shapes: Array of Shape;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var app: Visio_TLB.VisioApplication;
var doc: Visio_TLB.Document;
var i: Integer;

begin
    app := CreateComObject(CLASS_VisioApplication) as Visio_TLB.VisioApplication;
    doc := app.Documents.Open('D:\visio.vsd') as Visio_TLB.Document;

    for i := 1 to doc.Pages[1].Shapes.Count do
    if not CompareShapeName(doc.Pages[1].Shapes[i],'Annotation') then
      begin
        SetLength(figures,  Length(figures)+1);
        figures[High(figures)] := doc.Pages[1].Shapes[i];
      end;

    for i := 0 to High(figures) do
      begin
        if CompareShapeName(figures[i],'Dynamic connector') then
        begin
            SetLength(connects,  Length(connects)+1);
            connects[High(connects)] := figures[i];
        end
        else
        begin
            SetLength(shapes,  Length(shapes)+1);
            shapes[High(shapes)] := figures[i];
        end;
      end;

    Memo1.Text := GetAll();

    doc.Close();
    app.Quit();
end;

function ToStr(Value: Variant): String;
begin
  case TVarData(Value).VType of
    varSmallInt,
    varInteger   : Result := IntToStr(Value);
    varSingle,
    varDouble,
    varCurrency  : Result := FloatToStr(Value);
    varDate      : Result := FormatDateTime('dd/mm/yyyy', Value);
    varBoolean   : if Value then Result := 'T' else Result := 'F';
    varString    : Result := Value;
    else            Result := '';
  end;
end;

//    'Terminator', 'Process', 'Decision', 'Dynamic connector', 'Predefined process', 'Annotation'
function CompareShapeName(shp: Shape; name: String): Boolean;
var t:TStringList;
begin
    t:=TStringList.create;
    t.text := stringReplace(shp.NameU, '.', #13#10, [rfReplaceAll]);

    if AnsiCompareStr(t[0], name) = 0 then
        Result := True
    else
        Result := False;
end;

function GetShapeName(shp: Shape): String;
var t:TStringList;
begin
    t:=TStringList.create;
    t.text := stringReplace(shp.NameU, '.', #13#10, [rfReplaceAll]);

    Result := t[0];
end;



function GetShapeWithIndex(indx: Integer): Shape;
var i: Integer;
begin
    for i := 0 to High(figures) do
      begin
        if figures[i].Index = indx then
        begin
            Result := figures[i];
            Break;
        end;
      end;
end;

function GetShapeText(indx: Integer): String;
begin
    Result := GetShapeWithIndex(indx).Text;
end;

function GetBeginShapeIndex(): Integer;
var i,j:Integer;
var flag: Boolean;
begin
  Result := -1;
   for i := 0 to High(shapes) do
   begin
      flag := False;
      for j := 0 to High(connects) do
        if connects[j].Connects[2].ToSheet.Index = shapes[i].Index then
          flag := True;

      if not flag and CompareShapeName(shapes[i],'Terminator') then
      begin
         Result := shapes[i].Index;
         Break;
      end;

   end;
end;

function GetEndShapeIndex(): Integer;
var i,j:Integer;
var flag: Boolean;
begin
  Result := -1;
   for i := 0 to High(shapes) do
   begin
      flag := False;
      for j := 0 to High(connects) do
        if connects[j].Connects[1].ToSheet.Index = shapes[i].Index then
          flag := True;

      if not flag and CompareShapeName(shapes[i],'Terminator') then
      begin
         Result := shapes[i].Index;
         Break;
      end;

   end;
end;

function GetFromConnectsCount( indx: Integer): Integer;
var i,temp:Integer;
begin
  temp := 0;
  for i := 0 to High(connects) do
    if connects[i].Connects[1].ToSheet.Index = indx then
      temp := temp +1;

  Result := temp;
end;

function PrepareComment1(curr: Integer): String;
var res,first,second:String;
var currComm,prevComm: String;
begin
  currComm := GetShapeText(curr);

  if Pos('=',currComm) > 0 then
  begin
    res := currComm;
   end
   else

  if Pos('FKU',currComm) > 0 then
    begin
    prevComm := GetShapeText(GetPrevElemIndex(curr));
    first := Copy(prevComm,0,Pos('=',prevComm)-1);
    second := Copy(prevComm,Pos('=',prevComm)+1,1);

    res := 'FKU(' + first + ',' + second + ')';
   end

   else
    res := 'Ком:' + currComm;

   Result := res;
end;

function PrepareComment2(index: Integer): String;
var res,first,second,comment:String;
begin
  comment := GetShapeText(index);
  if Pos('=',comment) > 0 then
  begin
    first := Copy(comment,0,Pos('=',comment)-1);
    second := Copy(comment,Pos('=',comment)+1,1);
    if AnsiCompareStr(second,'0') = 0 then
      res := '^';

    res := res + first;

   end
   else
      res := comment;

   Result := res;
end;

function ArrSearch(arr: Array of Integer; num:Integer): Integer;
var i:Integer;
begin
  Result := -1;
  for i := 0 to High(arr) do
    if arr[i]= num then
      Result := i;

end;

function GetAll(): String;
var comm:String;
var resArr : Array of Integer;
var currnum: Integer;
var elemcount,curr,next,next2: Integer;
var list: TList<Integer>;
var res: String;
begin
  list := TList<Integer>.Create;
  SetLength(resArr,Length(shapes));
  resArr[0] := GetBeginShapeIndex();
  resArr[High(resArr)] := GetEndShapeIndex();
  currnum := 1;

  res := 'Нач:'+GetShapeText(resArr[0])+#13#10;

  list.Add(resArr[0]);
  list.Add(resArr[High(resArr)]);

  while list.Count > 1 do
  begin
    list.Sort();
    curr := list[0];

    elemcount := GetFromConnectsCount(curr);
    if elemcount = 1 then
    begin
      next := GetNextElemIndex(curr,1);
      if ArrSearch(resArr,next) = -1 then
      begin
        resArr[currnum] := next;
        currnum := currnum + 1;
      end;

      list.Remove(curr);
      if (resArr[High(resArr)] <> next) and (list.IndexOf(next) = -1) then
        list.Add(next);
    end;
    if elemcount = 2 then
    begin
      next := GetNextElemIndex(curr,1);
      next2 := GetNextElemIndex(curr,2);

      if ArrSearch(resArr,next) = -1 then
      begin
        resArr[currnum] := next;
        currnum := currnum + 1;
      end;

      if ArrSearch(resArr,next2) = -1 then
      begin
        resArr[currnum] := next2;
        currnum := currnum + 1;
      end;

      list.Remove(curr);
      if (resArr[High(resArr)] <> next) and (list.IndexOf(next) = -1) then
        list.Add(next);

      if (resArr[High(resArr)] <> next2) and (list.IndexOf(next2) = -1) then
        list.Add(next2);

    end;

  end;

  list.Add(resArr[0]);

  while list.Count > 1 do
  begin
    list.Sort();

    curr := list[0];
    elemcount := GetFromConnectsCount(curr);
    if elemcount = 1 then
    begin
      next := GetNextElemIndex(curr,1);
      if curr <> resArr[0] then
      begin
        res := res + ToStr(ArrSearch(resArr,curr)) + ':' + #13#10;
        comm := PrepareComment1(curr);
        res := res + comm + #13#10;
        res := res + ToStr(ArrSearch(resArr,next)) + #13#10;
      end;

      list.Remove(curr);
      if (resArr[High(resArr)] <> next) and (list.IndexOf(next) = -1) then
        list.Add(next);

    end;
    if elemcount = 2 then
    begin
      next := GetNextElemIndex(curr,1);
      next2 := GetNextElemIndex(curr,2);

      //тут нужно добавить if

      res := res + ToStr(ArrSearch(resArr,curr)) + ':' + #13#10;
      comm := PrepareComment2(curr);

      res := res + 'Если ' + comm + ' то ' + ToStr(ArrSearch(resArr,next)) + ' иначе ' + ToStr(ArrSearch(resArr,next2)) + #13#10;

      list.Remove(curr);
      if (resArr[High(resArr)] <> next) and (list.IndexOf(next) = -1) then
        list.Add(next);
      if (resArr[High(resArr)] <> next2) and (list.IndexOf(next2) = -1) then
        list.Add(next2);

    end;

    comm := '';

  end;

  curr := list[0];
  res := res + ToStr(ArrSearch(resArr,curr)) + ':' + #13#10;
  comm := GetShapeText(curr);
  res := res + 'Кон:' + comm + #13#10;

  Result := res;
end;

function GetNextElemIndex(indx: Integer; number: Integer): Integer;
var i,j:Integer;
var cc: Integer;
var res1, res2 : Extended;
var arr: Array of Shape;
begin
  Result := -1;
  cc := GetFromConnectsCount(indx);
  if cc = 1 then
  begin
    for i := 0 to High(connects) do
      if connects[i].Connects[1].ToSheet.Index = indx then
      begin
        Result := connects[i].Connects[2].ToSheet.Index;
        Break;
      end;
  end
  else
  if cc = 2 then
    begin
        SetLength(arr,  2);
        for j := 0 to High(connects) do
        if connects[j].Connects[1].ToSheet.Index = indx then
          begin
            res1 := connects[j].CellsU['PinX'].ResultIU;
            res2 := connects[j].Connects[2].ToSheet.CellsU['PinX'].ResultIU;
            if res1 = res2 then
              arr[0] := connects[j].Connects[2].ToSheet
            else
              arr[1] := connects[j].Connects[2].ToSheet;
          end;

    Result := arr[number-1].Index;

    end;
end;

function GetPrevElemIndex(indx: Integer): Integer;
var i:Integer;
begin
  Result := -1;
    for i := 0 to High(connects) do
      if connects[i].Connects[2].ToSheet.Index = indx then
      begin
        Result := connects[i].Connects[1].ToSheet.Index;
        Break;
      end;
end;

end.

unit Functions;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Generics.Collections, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Visio_TLB, COMOBJ;

function ToStr(Value: Variant): String;
function CompareShapeName(shp: Shape; name: String): Boolean;
function GetShapeName(shp: Shape): String;
function GetBeginShapeIndex(figures: Array of Shape; connects: Array of Shape; shapes: Array of Shape  ): Integer;
function GetEndShapeIndex(figures: Array of Shape; connects: Array of Shape; shapes: Array of Shape  ): Integer;
function GetShapeWithIndex(figures: Array of Shape; indx: Integer): Shape;
function GetFromConnectsCount(connects: Array of Shape;  indx: Integer): Integer;
function GetNextElemIndex(connects: Array of Shape; indx: Integer; number: Integer): Integer;
procedure GetAll(figures: Array of Shape; connects: Array of Shape; shapes: Array of Shape);
function GetShapeText(figures: Array of Shape; indx: Integer): String;
function PrepareComment1(comment: String): String;
function PrepareComment2(comment: String): String;

implementation

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



function GetShapeWithIndex(figures: Array of Shape; indx: Integer): Shape;
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

function GetShapeText(figures: Array of Shape; indx: Integer): String;
begin
    Result := GetShapeWithIndex(figures,indx).Text;
end;

function GetBeginShapeIndex(figures: Array of Shape; connects: Array of Shape; shapes: Array of Shape  ): Integer;
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

function GetEndShapeIndex(figures: Array of Shape; connects: Array of Shape; shapes: Array of Shape  ): Integer;
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

function GetFromConnectsCount(connects: Array of Shape;  indx: Integer): Integer;
var i,temp:Integer;
begin
  temp := 0;
  for i := 0 to High(connects) do
    if connects[i].Connects[1].ToSheet.Index = indx then
      temp := temp +1;

  Result := temp;
end;

function PrepareComment1(prev, next: Shape): String;
var res,first,second:String;
var prevComm,nextComm: String;
begin
  prevComm := GetShapeText()
  if Pos('=',comment) > 0 then
  begin
    first := Copy(comment,0,Pos('=',comment)-1);
    second := Copy(comment,Pos('=',comment)+1,1);
    if AnsiCompareStr(second,'0') = 0 then
      res := '^';

    res := res + first;

   end;

   Result := res;
end;

function PrepareComment2(comment: String): String;
var res,first,second:String;
begin
  if Pos('=',comment) > 0 then
  begin
    first := Copy(comment,0,Pos('=',comment)-1);
    second := Copy(comment,Pos('=',comment)+1,1);
    if AnsiCompareStr(second,'0') = 0 then
      res := '^';

    res := res + first;

   end;

   Result := res;
end;

//function GenDocSingle(figures: Array of Shape; connects: Array of Shape; shapes: Array of Shape; sfrom: Integer; sto: Integer): String;
//begin
//  if True then
//
//end;

procedure GetAll(figures: Array of Shape; connects: Array of Shape; shapes: Array of Shape);
var temp:Integer;
var beginComm,endComm:String;
var resArr : Array of Integer;
var empty: Integer;
var elemcount: Integer;
var list: TList<Integer>;
begin
  list := TList<Integer>.Create;
  SetLength(resArr,Length(shapes));
  resArr[0] := GetBeginShapeIndex(figures,connects,shapes);
  resArr[High(resArr)] := GetEndShapeIndex(figures,connects,shapes);
  empty := 1;
  list.Add(resArr[0]);
  list.Add(resArr[High(resArr)]);
  while list.Count > 1 do
  begin
    if list[0] = resArr[High(resArr)] then
      list.Exchange(0,1);

    elemcount := GetFromConnectsCount(connects,list[0]);
    if elemcount = 1 then
    begin

    end;







  end;





  beginComm := GetShapeText(figures, resArr[0]);
  endComm := GetShapeText(figures, resArr[High(resArr)]);
  temp := 0;
end;

function GetNextElemIndex(connects: Array of Shape; indx: Integer; number: Integer): Integer;
var i,j:Integer;
var cc: Integer;
var res1, res2 : Extended;
var arr: Array of Shape;
begin
  Result := -1;
  cc := GetFromConnectsCount(connects,indx);
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


end.

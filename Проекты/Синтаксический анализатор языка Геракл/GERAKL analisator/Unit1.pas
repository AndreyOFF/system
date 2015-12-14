unit Unit1;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, Vcl.ExtDlgs,
  Vcl.ComCtrls, Vcl.DBCtrls;

type
  TForm1 = class(TForm)

    Button2: TButton;
    Button1: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    RichEdit1: TRichEdit;
    procedure richedit1keyup(sender: tobject; var key: word;
    shift: tshiftstate);
    procedure highlight;
    function checklist(instring: string): boolean;
    function checkmistakes(instring: string): boolean;
    procedure Button2Click(Sender: TObject);

    procedure Button1Click(Sender: TObject);
    procedure richeditchange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  beginFlag: integer;
  ifFlag: boolean;
  endFlag: boolean;

implementation
{$R *.dfm}

// щелчок на кнопке ќткрыть
procedure TForm1.Button1Click(Sender: TObject);
var
  f: TextFile; // файл
  fName: String[80]; // им€ файла
  buf: string[80]; // буфер дл€ чтени€ из файла
begin
  if OpenTextFileDialog1.Execute(Self.Handle) then
    begin
    //Selecting the file name and the encoding
    fName := OpenTextFileDialog1.FileName;
    end;
   AssignFile(f, fName);
  Reset(f); // открыть дл€ чтени€
  {$I+}

  if IOResult <> 0 then
  begin
     exit;
  end;

  // чтение из файла
  while not EOF(f) do
  begin
    readln(f, buf); // прочитать строку из файла

    RichEdit1.Lines.Add(buf);
  end;

  CloseFile(f); // закрыть файл
end;




// щелчок на кнопке —охранить Ч запись в файл
procedure TForm1.Button2Click(Sender: TObject);
var
  f: TextFile; // файл
  fName: string[80]; // им€ файла
  i: integer;
begin
  fName := OpenTextFileDialog1.FileName;
  AssignFile(f, fName);
  Rewrite(f); // открыть дл€ перезаписи
  // запись в файл
  for i := 0 to RichEdit1.Lines.Count do // строки нумеруютс€ с нул€
    writeln(f, RichEdit1.Lines[i]);
  CloseFile(f); // закрыть файл

end;

function TForm1.checklist(instring: string): boolean;
const thelist: array[1..20] of string = ('1:', '2:', '3:','4:',
'5:;', '6:', '7:', '8:', '9:', '10:', '11:','false', 'true', 'нач', 'while','нач:', 'кон:', 'если','то','иначе');
var x: integer;
begin
result := false;
x := 1;
instring := stringreplace(instring, ' ', '',[rfreplaceall]);
instring := stringreplace(instring, #$a, '',[rfreplaceall]);
instring := stringreplace(instring, #$d, '',[rfreplaceall]);
while x < high(thelist) + 1 do
if 'нач:' = lowercase(instring) then
begin
result := true;
inc(beginFlag);
x := high(thelist) + 1;
end
else if 'если' = lowercase(instring) then
begin
result := true;
ifFlag:=true;
x := high(thelist) + 1;
end
else if thelist[x] = lowercase(instring) then
begin
result := true;
x := high(thelist) + 1;
end

else inc(x);

end;

function TForm1.checkmistakes(instring: string): boolean;
const thelist: array[1..13] of string = ('нач:', 'кон:', 'если','то',
'иначе;', '1:', '2:', '3:', '4:', 'if', 'to', 'string', 'while');
var x: integer;
begin
result := false;
x := 1;
instring := stringreplace(instring, ' ', '',[rfreplaceall]);
instring := stringreplace(instring, #$a, '',[rfreplaceall]);
instring := stringreplace(instring, #$d, '',[rfreplaceall]);
while x < high(thelist) + 1 do
if ('нач:' = lowercase(instring)) and (beginFlag>2) then
begin
result := true;
x := high(thelist) + 1;
end
else if ('иначе' = lowercase(instring)) and (ifFlag=false) then
begin
result := true;
x := high(thelist) + 1;
end
else inc(x);

end;

procedure TForm1.richedit1keyup(sender: tobject; var key: word;
shift: tshiftstate);
var wend, wstart, bcount: integer;
mark: string;
begin
if (ssctrl in shift) and (key = ord('v')) then button2click(self);
if (key = vk_return) or (key = vk_back) or (key = vk_space) then
begin
if richedit1.selstart > 1 then
begin
wstart := 0;
wend := richedit1.selstart;
bcount := wend - 1;
while bcount <> 0 do
begin
mark := copy(richedit1.text, bcount, 1);
if (mark = ' ') or (mark = #$a) then
begin
wstart := bcount;
bcount := 1;
end;
dec(bcount);
end;
richedit1.selstart := wend - (wend - wstart);
richedit1.sellength := wend - wstart;


if checkmistakes(richedit1.seltext) then
richedit1.selattributes.Color := clred
else if checklist(richedit1.seltext) then
richedit1.selattributes.Style := [fsbold]
else richedit1.selattributes.style := [];
richedit1.selstart := wend;
richedit1.selattributes.Style := [];
richedit1.selattributes.Color := clBlack;
end;
end;
end;

function searchfor(workspace, search: string; start: integer): integer;
var temp: string;
begin
temp := copy(workspace, start, length(workspace));
result := pos(search, temp);
end;

procedure tform1.highlight;
var wstart, wend, wend2: integer;
workspace, sword: string;
begin
wstart := 1;
wend := 1;
with richedit1 do
begin
workspace := text + ' ' + #$d#$a;
while wend > 0 do
begin
wend := searchfor(workspace, ' ', wstart);
wend2 := searchfor(workspace, #$a, wstart);
if wend2 < wend then wend := wend2;
sword := copy(workspace, wstart, wend - 1);
if (sword <> ' ') and (sword <>'') then
if checklist(sword) then
begin
selstart := wstart - 1;
sellength := length(sword);
selattributes.style := [fsbold];
selstart := wstart + length(sword) + 1;
selattributes.style := [];
end;
wstart := wstart + wend;
end;
selstart := length(text);
setfocus;
end;
end;


procedure TForm1.richeditchange(Sender: TObject);
begin
   form1.highlight();

end;

end.

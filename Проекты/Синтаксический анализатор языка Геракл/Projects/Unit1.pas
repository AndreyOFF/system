unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs, RegExpr;

type
  TForm1 = class(TForm)
    OpenTextFileDialog1: TOpenTextFileDialog;
    btnOpenFile: TButton;
    mTextFromFile: TMemo;
    edTextFilePath: TEdit;
    SaveTextFileDialog1: TSaveTextFileDialog;
    Button1: TButton;
    mErrors: TMemo;
    Label1: TLabel;
    btnGo: TButton;
    btnClear: TButton;
    procedure btnOpenFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnGoClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  result: Boolean;
  RegEx: TRegExpr;

implementation

{$R *.dfm}

procedure TForm1.btnGoClick(Sender: TObject);
var
 i: Integer;

begin
mErrors.Lines.Clear();
mErrors.Text:='';
  for i:=0 to mTextFromFile.Lines.Count-1 do
    begin
      if (AnsiPos('Нач:', Copy(mTextFromFile.Lines[i],1, 4))<>0) and not(i = 0) then
        begin
          mErrors.Lines.Add('Ошибка в строке №' + IntToStr(i) + ' - неверная позиция "Нач:"');
          continue;
        end;
      if (AnsiPos('Кон:', Copy(mTextFromFile.Lines[i],1, 4))<>0) and not(i = mTextFromFile.Lines.Count-1) then
        begin
          mErrors.Lines.Add('Ошибка в строке №'+IntToStr(i) + ' - неверная позиция "Кон:"');
          continue;
        end;
      if Trim(mTextFromFile.Lines[i]) = '' then
        begin
          mErrors.Lines.Add('Ошибка в строке №'+IntToStr(i) + ' - присутствует пустая строка!');
          continue;
        end;
      if Trim(mTextFromFile.Lines[i]) = '' then
        begin
          mErrors.Lines.Add('Ошибка в строке №'+IntToStr(i) + ' - присутствует пустая строка!');
          continue;
        end;
    end;
end;

procedure TForm1.btnOpenFileClick(Sender: TObject);
begin
if OpenTextFileDialog1.Execute
 then
   begin
    edTextFilePath.Text := OpenTextFileDialog1.FileName;
    mTextFromFile.Lines.LoadFromFile(OpenTextFileDialog1.FileName);
   end;
end;

procedure TForm1.btnClearClick(Sender: TObject);
begin
      mErrors.Lines.Clear();
      mErrors.Text := '';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if SaveTextFileDialog1.Execute
 then
   begin
    mTextFromFile.Lines.SaveToFile(SaveTextFileDialog1.FileName + '.txt');
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
mTextFromFile.Text := '';
mErrors.Text := '';
result := false;
OpenTextFileDialog1.Filter:='Текстовые файлы *.txt|*.txt';
SaveTextFileDialog1.Filter:='Текстовые файлы *.txt|*.txt';

//regular expressions
//RegEx:=TRegExpr.Create('Any regular expression');
end;

end.

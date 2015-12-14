unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Word_TLB, Vcl.StdCtrls, COMOBJ;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  w: variant;
var
  //doc: Word_TLB.WordApplication.Documents;
//var
  i: Integer;
var
  wordApp,
  vWhat, vName, ShapesAll,
  vText,
  vFileName,
  vFileFormat : Variant;
begin
  Screen.Cursor := crHourGlass;
  vFileName := 'D:\visio.docx';
  vWhat := wdGoToBookmark;
  //vName := "bookmark1";
  //vText := "NewText";

  wordApp := CreateOleObject('Word.Application');
  try
    wordApp.WindowState := wdWindowStateMaximize;
    wordApp.Visible := True;//False;
    wordApp.Documents.Add(vFileName);
    //wordApp.Visio.shapes.Count;
    ShapesAll := wordApp.Documents.Item(1).Range.InlineShapes.Item(1);
    Memo1.Text := '  ' +ShapesAll.OLEFormat.ClassType;
    //Memo1.Text := wordApp.Documents.Item(1).Select.Shapes.Count;
  finally
    wordApp.ActiveDocument.Close;
    wordApp.Quit;
    Screen.Cursor := crDefault;
  end;


end;

end.

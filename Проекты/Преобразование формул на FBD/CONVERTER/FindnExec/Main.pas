unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ShellAPI;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  List:TStringList;

implementation

{$R *.dfm}

procedure FindFiles(FilesList: TStringList; StartDir, FileMask: string);
var
  SR: TSearchRec;
  DirList: TStringList;
  IsFound: Boolean;
  i: integer;
begin
  if StartDir[length(StartDir)] <> '\' then
    StartDir := StartDir + '\';

  { Build a list of the files in directory StartDir
     (not the directories!)                         }

  IsFound :=
    FindFirst(StartDir+FileMask, faAnyFile-faDirectory, SR) = 0;
  while IsFound do begin
    FilesList.Add(StartDir + SR.Name);
    IsFound := FindNext(SR) = 0;
  end;
  FindClose(SR);

  // Build a list of subdirectories
  DirList := TStringList.Create;
  IsFound := FindFirst(StartDir+'*.*', faAnyFile, SR) = 0;
  while IsFound do begin
    if ((SR.Attr and faDirectory) <> 0) and
         (SR.Name[1] <> '.') then
      DirList.Add(StartDir + SR.Name);
    IsFound := FindNext(SR) = 0;
  end;
  FindClose(SR);

  // Scan the list of subdirectories
  for i := 0 to DirList.Count - 1 do
    FindFiles(FilesList, DirList[i], FileMask);

  DirList.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  FilesList: TStringList;
begin
  FilesList := TStringList.Create;
  try
    FindFiles(FilesList, GetCurrentDir, Edit1.Text);
    ListBox1.Items.Assign(FilesList);
    Edit2.Text := 'Files found: ' + IntToStr(FilesList.Count);
  finally
    FilesList.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ShellExecute(handle,'open',PWideChar(ListBox1.Items[0]),nil,nil,SW_SHOWNORMAL);
end;

end.

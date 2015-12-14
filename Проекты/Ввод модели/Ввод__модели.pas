unit ����__������;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,ComObj, StdCtrls,ShellApi,CheckLst;

type
  TForm3 = class(TForm)
    �����_��: TButton;
    OpenDialog1: TOpenDialog;
    ����_����_����_��_��������: TButton;
    OpenDialog2: TOpenDialog;
    ���������_Visio_������: TButton;
    procedure �����_��Click(Sender: TObject);
    procedure ����_����_����_��_��������Click(Sender: TObject);
//    procedure ����_����_����_�_MS_VISIOClick(Sender: TObject);
    procedure ���������_Visio_������Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  �������_�����������_�������:textfile;
  ������_����������:textfile;
  �������_������������_��������:textfile;
  ����������_������������,���_�����:String;
  ����������_����������_�����������_������,��������_������:String;
//  ����������_����_������:PWideChar;
  �������, �����:textfile;
  �����_�����,�����_�������,�����_�����:Integer;

implementation

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);

begin
  // ����������� ���� �������
  GetDir(0,����������_������������);
  ����������_������������ := StringReplace(����������_������������,'\__history' , '', [rfReplaceAll, rfIgnoreCase]);
  ShowMessage('����������_������������: ' + ����������_������������);
  ����������_����������_�����������_������:= ����������_������������ + '\���������� ����������� ������';
  ShowMessage('����������_����������_�����������_������: ' + ����������_����������_�����������_������);
end;

procedure TForm3.���������_Visio_������Click(Sender: TObject);
begin
    //�������������� ����-���� �� ���� ������
//    ShellExecute(Handle,nil,'D:\�����������\����_������\������������� ����������  MS Visio �� ����� ������\���������_������.exe',nil,nil,SW_Restore);

  ShellExecute(Handle,nil,PWideChar(����������_������������ + '\�������\�������������� ���������� �� MS Visio �� ���� ������\���������_������.exe'),nil,nil,SW_Restore);
end;

procedure TForm3.����_����_����_��_��������Click(
  Sender: TObject);
  var ����_�����:variant;
    dir_:string;
begin
  //  ������ ����-���� �� ����� ������
  //  ����_����_����_�_MS_VISIO
    ����_�����:=CreateOleObject('Visio.Application');
    GetDir(0,dir_);
  if not OpenDialog2.Execute then begin chdir(dir_); exit; end;
  chdir(dir_);
  ����_�����.Documents.Open(OpenDialog2.FileName);
  ShellExecute(Handle,nil,'NotePad.exe',nil,nil,SW_Restore);
end;



procedure TForm3.�����_��Click(Sender: TObject);
  Label 1;
var dir_:string;
    �������,���������,���_�������,������,��������_�������,�������,�����_������:string;
var �����������_�������,�������,������,�����:variant;
    �������_,������,�����_�����:Integer;
var �����:Integer;
begin
�����������_�������:=CreateOleObject('Word.Application');

GetDir(0,dir_);
if not OpenDialog1.Execute then begin chdir(dir_); exit; end;
chdir(dir_);
�����������_�������.Documents.Open(OpenDialog1.FileName);
�����������_�������.Visible := True;
�������:=�����������_�������.ActiveDocument.Tables.item(1);
//chdir(����������_����������_�����������_������);
AssignFile(�������_�����������_�������,����������_����������_�����������_������ + '\�������.txt');
AssignFile(�������_������������_��������,����������_����������_�����������_������ + '\�������_������������_��������.txt');
ReWrite(�������_�����������_�������);
ReWrite(�������_������������_��������);
AssignFile(������_����������,����������_����������_�����������_������ + '\������_����������.txt');
ReWrite(������_����������);
AssignFile(�����, 'd:\������������\���������� ����������� ������\�����.txt');
ReSet(�����);

//ShowMessage('������  ' + IntToStr(�����������_�������.ActiveDocument.Tables.count));

// tCount:=Doc.Tables.Count;
//       for i := 1 to tCount-1 do
//           begin
//             table:=Doc.Tables.Item(i);
//             header:=table.Cell(1,1).Range.Previous(wdParagraph, 1);
//             header:=LowerCase(header);
//             // GET HEADER
//             if 	ContainsText(header, '���������� �������')
//             then
//             begin
//             Label1.Caption:=header;
//ShowMessage(IntToStr(�����������_�������.ActiveDocument.Words.count));

  �����_����� := 0;
//  ������ := 0;
//  ����� := 0;
  while not Eof(�����) do
    Begin
    �����_����� := �����_����� + 1;
    Readln(�����,��������_������);
    ��������_������ := AnsiUpperCase(��������_������);
    �����_������� := 1;
    while �����_������� <> 0 do
    Begin
      �����_������� := Pos(' ',��������_������);
      Delete(��������_������,�����_�������,1);
    End;
    �����_����� := Pos('=',��������_������);
     ���_�����:= Copy(��������_������,1,�����_����� - 1);
//    ShowMessage(���_�����);
    if �����������_�������.Selection.Find.Execute(���_�����) then
     Begin
     �����������_�������.Selection.Font.Color:=clFuchsia;
//     ShowMessage('�������  ' + ���_�����);
     �����������_�������.Selection.Collapse(EmptyParam);
     End;
  End;
    ShowMessage('�������  ����� ��!');
    CloseFile(�����);
    goto 1;

�������:=�����������_�������.ActiveDocument.Tables.item(1);

//������� ���������� �������
ShowMessage('������ ����� ���������� �������!');
for  ������:= 2 to �������.Rows.Count do
begin
Try
  ������� := AnsiUpperCase(Trim(�������.Cell(������,1).Range.Text));
Except
Continue
End;
  if ((Pos('Z',�������) = 1) or (Pos('Y',�������) = 1) or (Pos('V',�������) = 1)
      or (Pos('S',�������) = 1) or (Pos('F',�������) = 1) or (Pos('H',�������) = 1)
      or (Pos('M',�������) = 1) or (Pos('I',�������) = 1) or (Pos('O',�������) = 1)
      or (Pos('A',�������) = 1) or (Pos('N',�������) = 1) or (Pos('L',�������) = 1)
      or (Pos('E',�������) = 1))
      and  (Pos('=',�������) <> 0)
      then WriteLn(�������_�����������_�������,Trim(�������.Cell(������,1).Range.Text));
end;
ShowMessage('����� ����� ���������� �������!');

�������:=�����������_�������.ActiveDocument.Tables.item(2);
//������� ������ ����������

ShowMessage('������ ����� ������ ����������!');
for ������ := 2 to �������.Rows.Count do
begin
Try
  ������� := AnsiUpperCase(Trim(�������.Cell(������,1).Range.Text));
Except
Continue
End;
//ShowMessage(Trim(�������.Cell(������,1).Range.Text) + '=' + Trim(�������.Cell(������,2).Range.Text));
   WriteLn(�������_�����������_�������,Trim(�������.Cell(������,1).Range.Text) + '=' + Trim(�������.Cell(������,2).Range.Text));
end;
ShowMessage('����� ����� ������ ����������!');

�������:=�����������_�������.ActiveDocument.Tables.item(3);

//������� �������_������������_��������

ShowMessage('������ ����� �������_������������_��������!');
for ������ := 2 to �������.Rows.Count do
begin
   WriteLn(�������_������������_��������,Trim(�������.Cell(������,3).Range.Text));
end;
ShowMessage('����� ����� �������_������������_��������!');

�������:=�����������_�������.ActiveDocument.Tables.item(4);
//������� �������� ������� ������������

ShowMessage('������ ����� ������� ������������!');
for ������ := 2 to �������.Rows.Count do
begin
  If (Pos('X',�������.Cell(������,1).Range.Text) <> 0) or (Pos('�',�������.Cell(������,1).Range.Text) <> 0) Then
      Begin
      ������ := AnsiUpperCase(Trim(�������.Cell(������,1).Range.Text));
//      �����_����� := Pos(' ',������);
//      ������ := Copy(������,1,�����_����� - 1);
//      ShowMessage(������);
      End;

  Try
    ������� := Trim(�������.Cell(������,3).Range.Text);
  Except
  Continue
  End;
//  ShowMessage(�������);
  if (Pos('Y',�������) = 1) or (Pos('�',�������) = 1) then
  Begin
    WriteLn(�������_�����������_�������,Trim(�������));
    �����_����� := Pos('=',�������);
    ���_������� := Copy(�������,1,�����_����� - 1);
    ��������_������� := �������.Cell(������,1).Range.Text;
    while Pos('-',��������_�������) <> 0 do
          Begin
            Insert('_',��������_�������,Pos('-',��������_�������));
            Delete(��������_�������,Pos('-',��������_�������),1);
          End;
    while Pos(',',��������_�������) <> 0 do
          Begin
            �������:= Copy(��������_�������,1,Pos(',',��������_�������)-1);
            Delete(��������_�������,1,Pos(',',��������_�������));
            WriteLn(�������_�����������_�������,������ + '_' + Trim(�������) + ' = ' + ���_�������);
          End;
    if Pos(',',��������_�������) = 0 then
    Begin
      �������:= ��������_�������;
      WriteLn(�������_�����������_�������,������ + '_' + Trim(�������) + '=' + ���_�������);
    End;
  End;

  if (Pos('X',�������) = 1) or (Pos('�',�������) = 1) then
  Begin
  Try
  ���_������� := Trim(�������.Cell(������,3).Range.Text);
  Except
  Continue
  End;
    ��������_������� := �������.Cell(������,1).Range.Text;
    ��������� := '';
    while Pos(',',��������_�������) <> 0 do
          Begin
            �������:= Copy(��������_�������,1,Pos(',',��������_�������)-1);
            Delete(��������_�������,1,Pos(',',��������_�������));
            ��������� := ��������� + ������ + '_' + Trim(�������) + ' + ';
          End;
          If ��������� <> '' Then
          Begin
            �������:= ��������_�������;
            ��������_�������:= ' ';
            ��������� := ��������� + ������ + '_' + Trim(�������);
            WriteLn(�������_�����������_�������,���_������� + ' = ' + ���������);
          End;

    if (Pos(',',��������_�������) = 0) and (��������_������� <> ' ')  then
    Begin
      �������:= ��������_�������;
      WriteLn(�������_�����������_�������,���_������� + ' = ' + ������ + '_' + Trim(�������));
    End;
  End;
end;
ShowMessage('����� ����� ������� ������������!');

�������:=�����������_�������.ActiveDocument.Tables.item(5);
//������� ������_����������
ShowMessage('������ ����� ������� ������� ����������!');
//ShowMessage(IntToStr(�������.Rows.Count));
for ������ := 2 to �������.Rows.Count do
begin
//ShowMessage(Trim(�������.Cell(������,3).Range.Text));
WriteLn(������_����������,'__' + Trim(�������.Cell(������,3).Range.Text) + ' = ' + Trim(�������.Cell(������,4).Range.Text));
end;
ShowMessage('����� ����� ������� ������� ����������!');

CloseFile(������_����������);
CloseFile(�������_�����������_�������);
CloseFile(�������_������������_��������);

//ShowMessage('������ ���������� ������� ������� ���������� � ��������!');
AssignFile(������_����������,����������_����������_�����������_������ + '\������_����������.txt');
Reset(������_����������);
AssignFile(�������_�����������_�������,����������_����������_�����������_������ + '\�������.txt');
Append(�������_�����������_�������);
while not Eof(������_����������) do
  Begin
  Readln(������_����������,�����_������);
  WriteLn(�������_�����������_�������,�����_������);
  End;
CloseFile(�������_�����������_�������);
CloseFile(������_����������);
//ShowMessage('����� ���������� ������� ������� ���������� � ��������!');
ShowMessage('���� ������ ��������!');
// D���� ��� ����������
1:
�����������_�������.Documents.Close;
// � ����� ��������n�� ���������� WORD
�����������_�������.Quit
end;
end.

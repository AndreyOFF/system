unit ��������_�������������;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Clipbrd, ShellApi, ComObj,
  // SpeechLib_TLB,
  ����������_����������;
Procedure �������(Var ���: Boolean; ���������: Integer; �����������: String;
  ����: Integer);
Procedure ����(Var ���: Boolean; ���������: Integer; �����������: String;
  ����: Integer);
procedure ���(Var ���: Boolean; �������: Boolean; �����������: String;
  ����: Integer);
Procedure ���_��_��(Var ���: Boolean; �������: Boolean; �����������: String;
  ����: Integer; Var ��: Boolean; Var ��: Boolean);
Procedure ���_��(Var ���: Boolean; �������: Boolean; �����������: String;
  ����: Integer; Var ��: Boolean);
procedure ���_��(Var ���: Boolean; �������: Boolean; �����������: String;
  ����: Integer; Var ��: Boolean);
Procedure FKU(Var ���: Boolean; ���������: Integer; �����������: String;
  ����: Integer);
procedure ������_��(����_: Integer; �����: String);
procedure �������_����������(�����: String);
Function Pr(����: Integer): String;

implementation

Uses ���������, �������, ����������_��������������;

Procedure �������(Var ���: Boolean; ���������: Integer; �����������: String;
  ����: Integer);
Begin
  ��� := B[���������];
  ���� := 0;
  MainForm.ListBox1.Items.Add('������� ' + IntToStr(�������_));
  MainForm.ListBox1.Items.Add('�������: ' + ����������� + s[���]);
  MainForm.ListBox3.Items.Add(Pr(����) + '������� ' + IntToStr(�������_));
  MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[���]);
  // if B[����] then
  // Begin
  // ����������:= ����������� + s[���];
  // �������_����������('�������!' + ����������);
  // End;
end;

Procedure ����(Var ���: Boolean; ���������: Integer; �����������: String;
  ����: Integer);
Begin
  ��� := B[���������];
  ���� := 0;
  MainForm.ListBox2.Items.Add('��� ' + IntToStr(���_));
  MainForm.ListBox2.Items.Add('����: ' + ����������� + s[���]);
  MainForm.ListBox3.Items.Add(Pr(����) + '��� ' + IntToStr(���_));
  MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[���]);
  // if B[����] then
  // Begin
  // ����������:= ����������� + s[���];
  // �������_����������('����!' + ����������);
  // End;
end;

Procedure ���(Var ���: Boolean; �������: Boolean; �����������: String;
  ����: Integer);
Begin
  if ������� <> ��� Then
  Begin
    ��� := not ���;
    ����_������������ := true;
    ���� := ���� + 1;
    MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[���]);
    if ((Pos('Y', �����������) = 1) or (Pos('�', �����������) = 1)) then
    Begin
      if �������_ <> 0 then
        MainForm.ListBox1.Items.Add(����������� + s[���]);
      if ���_ <> 0 then
        MainForm.ListBox2.Items.Add(����������� + s[���]);
    End;
    // if B[����] then
    // Begin
    // ����������:= ����������� + s[���];
    // �������_����������(����������);
    // End;
  End;
  // Else ����_������������:= false;
end;

Procedure ���_��_��(Var ���: Boolean; �������: Boolean; �����������: String;
  ����: Integer; Var ��: Boolean; Var ��: Boolean);
Begin
  if ������� <> ��� Then
  Begin
    ��� := not ���;
    ����_������������ := true;
    ���� := ���� + 1;
    MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[���]);
    if ��� then
    Begin
      �� := true;
      Insert('_', �����������, Pos('(', �����������) + 1);
      MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[��]);
      ��������;
      �� := False;
      // Insert('_',�����������,Pos(' =',�����������));
      // MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[��]);
    End
    else
    Begin
      �� := true;
      Insert('_', �����������, Pos(' =', �����������));
      MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[��]);
      ��������;
      �� := False;
    End;
    // if B[����] then
    // Begin
    // ����������:= ����������� + s[���];
    // �������_����������(����������);
    // End;
  End
  Else
    ����_������������ := False;
end;

Procedure ���_��(Var ���: Boolean; �������: Boolean; �����������: String;
  ����: Integer; Var ��: Boolean);
Begin
  if ������� <> ��� Then
  Begin
    ��� := not ���;
    ����_������������ := true;
    ���� := ���� + 1;
    MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[���]);
    if ��� then
    Begin
      �� := true;
      Insert('_', �����������, Pos('(', �����������) + 1);
      MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[��]);
      ��������;
      �� := False;
    End;
    // if B[����] then
    // Begin
    // ����������:= ����������� + s[���];
    // �������_����������(����������);
    // End;
  End
  Else
    ����_������������ := False;
end;

Procedure ���_��(Var ���: Boolean; �������: Boolean; �����������: String;
  ����: Integer; Var ��: Boolean);
Begin
  if ������� <> ��� Then
  Begin
    ��� := not ���;
    ����_������������ := true;
    ���� := ���� + 1;
    MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[���]);
    if not ��� then
    Begin
      �� := true;
      Insert('_', �����������, Pos(' =', �����������));
      MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[��]);
      ��������;
      �� := False;
    End;
    // if B[����] then
    // Begin
    // ����������:= ����������� + s[���];
    // �������_����������(����������);
    // End;
  End
  Else
    ����_������������ := False;
end;

Procedure FKU(Var ���: Boolean; ���������: Integer; �����������: String;
  ����: Integer);
Begin
  ��� := B[���������];
  ���� := ���� - 1;
  MainForm.ListBox3.Items.Add(Pr(����) + ����������� + s[���]);
  // if B[����] then
  // Begin
  // ����������:= ����������� + s[���];
  // �������_����������(����������);
  // End;
  ������������;
End;

procedure ������_��(����_: Integer; �����: String);
begin
  ���� := ����_;
  MainForm.ListBox3.Items.Add(Pr(����) + �����);
end;

procedure �������_����������(�����: String);
// var
// pvoice: TSpVoice;
// Voices:ISpeechObjectTokens;
begin
  // pvoice:=TSpVoice.Create(nil);
  // Voices:=pvoice.GetVoices('Name=ELAN TTS Russian (Nicolai 16Khz)','');
  // pvoice.Voice:=Voices.Item(0);
  // pvoice.Speak(�����, SVSFlagsAsync);
  // pvoice.WaitUntilDone(infinite);
end;

Function Pr(����: Integer): String;
Var
  I: Integer;
  P: String;
Begin
  P := ' ';
  for I := 1 to ���� do
    P := P + ' ';
  Pr := P;
End;

end.

unit Преобразование_Геракл_SFC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ExtDlgs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    OpenTextFileDialog1: TOpenTextFileDialog;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Algorithm();
    procedure CreateTransition(sfcSL: TStringList; var IndexStr: integer; var Ntrans: integer;
              Nstep: integer; Xcoord: integer; var Ycoord: integer; ORDIVside: integer;
              var ActInfoPos: integer);
    procedure CreateStep(sfcSL: TStringList; var IndexStr: integer; var Nstep: integer;
              var Nact: integer; Xcoord: integer; var Ycoord: integer; ORDIVside: integer; var ActInfoPos: integer);
    procedure CreateAction(sfcSL: TStringList; var IndexStr: integer; Nact: integer;
              var ActInfoPos: integer);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Algorithm();
var
    gerSL: TStringList;
    sfcSL: TStringList;
    VarsSL: TStringList;
    i, q, w, e, Ntrans, Nstep, Nact, Xcoord, Ycoord, IndexStr, LinkStr, LinkStrBefore,
    DictStrBefore, Ylink, Xlink, XlinkL, YlinkL, XlinkR, YlinkR, ORDIVside, IDblock,
    DictStr, ActInfoPos, lastElem: integer;

    progName, cashDel, NewVar, Expr, Com, Cond: string;


begin
    gerSL:= TStringList.Create();
    sfcSL:= TStringList.Create();
    VarsSL:= TStringList.Create();

    gerSL.LoadFromFile(Edit1.Text);
    sfcSL.LoadFromFile(Edit2.Text);

    Ntrans := 0;
    Nstep := 1;
    Nact := 1;
    Xcoord := 48;
    Ycoord := 12;
    Xlink := 56;
    Ylink := 23;
    ORDIVside := 0;
    IDblock := 1;

    LinkStr := 9;
    IndexStr := LinkStr + 5;
    DictStr := 3;


// Запись имени программы(алгоритма)
    if (Pos('Нач:', gerSL[0]) <> 0 ) then
    begin
      progName := copy(gerSL[0], 5, Length(gerSL[0])-4);
      sfcSL[4] := '<PouBody><![CDATA[PROGRAM ' + progName;
    end
          else
    begin
      ShowMessage('Ошибка: Нет "Нач:" в алгоритме');
      exit;
    end;
// ----------

// Проверка на наличие первого блока
    if (gerSL[1] <> '1:') then
    begin
      ShowMessage('Ошибка: Нет "1:" в алгоритме');
      exit;
    end;
// ---------------------------------

sfcSL[DictStr] := '  </LocalVars>';
sfcSL.Insert(DictStr, '  <LocalVars>');

sfcSL.Insert(11, 'Action'+IntToStr(Nact)+' (N);');
  IndexStr:=IndexStr+2;
  sfcSL.Insert(IndexStr, '');
CreateAction(sfcSL, IndexStr, Nact, ActInfoPos);


//---------- Цикл по алгоритму на Геракле ---------//
    for i := 2 to gerSL.Count-1 do
    begin

      // Если Метка Блока -----------------------------------------------
      if (TryStrToInt(gerSL[i][1],q)) and (Pos(':', gerSL[i]) <> 0) then
      begin
        IDblock := StrToInt(gerSL[i][1]);

        // Если Не блок Решение-------------------------
        if (Pos('Если', gerSL[i+1]) = 0) then
        begin

          // Если левая ветвь Решения (Блок после "То ")
          if(ORDIVside = 1) then
            begin

            CreateStep(sfcSL, IndexStr, Nstep, Nact, Xcoord, Ycoord, ORDIVside, ActInfoPos);
            ORDIVside := 11;
            CreateTransition(sfcSL, IndexStr, Ntrans, Nstep, Xcoord, Ycoord, ORDIVside, ActInfoPos);

            LinkStrBefore := LinkStr;

            // связь "условный левый переход - шаг"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            YlinkL := YlinkL+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(YlinkL));
            LinkStr := LinkStr+1;
            YlinkL := YlinkL+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(YlinkL));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 3 T'+IntToStr(Ntrans-2));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 2 S'+IntToStr(Nstep));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            // связь "шаг - 2-й левый переход"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            YlinkL := YlinkL+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(YlinkL));
            LinkStr := LinkStr+1;
            YlinkL := YlinkL+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(YlinkL));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 2 S'+IntToStr(Nstep));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 3 T'+IntToStr(Ntrans));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            // Запись связи "2-й левый переход - ORCONV"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            YlinkL := YlinkL+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(YlinkL));
            LinkStr := LinkStr+1;
            YlinkL := YlinkL+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(YlinkL));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 3 T'+IntToStr(Ntrans));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 8');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            IndexStr := IndexStr + (LinkStr - LinkStrBefore);
            ActInfoPos := ActInfoPos + (LinkStr - LinkStrBefore);

            ORDIVside := 2;

            continue;
            end;

          // Если правая ветвь Решения (Блок после "Иначе ")
          if(ORDIVside = 2) then
          begin

            CreateStep(sfcSL, IndexStr, Nstep, Nact, Xcoord, Ycoord, ORDIVside, ActInfoPos);
            ORDIVside := 22;
            CreateTransition(sfcSL, IndexStr, Ntrans, Nstep, Xcoord, Ycoord, ORDIVside, ActInfoPos);

            LinkStrBefore := LinkStr;
            // связь "условный правый переход - шаг"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            YlinkR := YlinkR+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(YlinkR));
            LinkStr := LinkStr+1;
            YlinkR := YlinkR+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(YlinkR));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 3 T'+IntToStr(Ntrans-2));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 2 S'+IntToStr(Nstep));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            // связь "шаг - 2-й правый переход"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            YlinkR := YlinkR+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(YlinkR));
            LinkStr := LinkStr+1;
            YlinkR := YlinkR+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(YlinkR));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 2 S'+IntToStr(Nstep));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 3 T'+IntToStr(Ntrans));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            // Запись связи "2-й правый переход - ORCONV"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            YlinkR := YlinkR+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(YlinkR));
            LinkStr := LinkStr+1;
            YlinkR := YlinkR+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(YlinkR));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 3 T'+IntToStr(Ntrans));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 8');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            Ylink := YlinkR+10;

            // Запись "ORCONV"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= ORCONV');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(Ylink-10));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(Ylink-10));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            // Запись связи "ORCONV - шаг"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            Ylink := Ylink+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 8');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 2 S'+IntToStr(Nstep+1));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            IndexStr := IndexStr + (LinkStr - LinkStrBefore);
            ActInfoPos := ActInfoPos + (LinkStr - LinkStrBefore);

            lastElem := 8; // последний элемент - ORCONV

            ORDIVside := 0;

            continue;
            end;

          // Если Не блок конца алгоритма -----------------------
          if(Pos('Кон:', gerSL[i+1]) = 0) then
          begin
            if(lastElem = 2)then // если последний элемент - шаг
              continue
            else if(lastElem = 8)then // если последний элемент - ORCONV
            begin
              Ycoord := Ycoord+12;
              CreateStep(sfcSL, IndexStr, Nstep, Nact, Xcoord, Ycoord, ORDIVside, ActInfoPos);
              lastElem := 2;
              continue;
            end;

            CreateTransition(sfcSL, IndexStr, Ntrans, Nstep, Xcoord, Ycoord, ORDIVside, ActInfoPos);

            LinkStrBefore := LinkStr;
            //Запись связей с переходом
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            Ylink := Ylink+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 2 S'+IntToStr(Nstep));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 3 T'+IntToStr(Ntrans));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            Ylink := Ylink+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            Ylink := Ylink+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 3 T'+IntToStr(Ntrans));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 2 S'+IntToStr(Nstep+1));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            IndexStr := IndexStr + (LinkStr - LinkStrBefore);
            ActInfoPos := ActInfoPos + (LinkStr - LinkStrBefore);

            // Запись шага
            CreateStep(sfcSL, IndexStr, Nstep, Nact, Xcoord, Ycoord, ORDIVside, ActInfoPos);

            continue;
          end;

        end;
        // конец.Если Не блок Решение-------------------------
      end;
     // конец.Если метка блока --------------------------------


     // Если Решение -----------------------------------------------
        if(Pos('Если', gerSL[i]) <> 0) then
        begin
            if(lastElem = 8)then // если последний элемент - ORCONV
            begin
              Ycoord := Ycoord+12;
              CreateStep(sfcSL, IndexStr, Nstep, Nact, Xcoord, Ycoord, ORDIVside, ActInfoPos);
            end;

          LinkStrBefore := LinkStr;
            // Запись связи "шаг - ORDIV"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            Ylink := Ylink+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            Ylink := Ylink+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 2 S'+IntToStr(Nstep));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 7');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            // Запись "ORDIV"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= ORDIV');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(Xlink)+' '+IntToStr(Ylink));
            LinkStr := LinkStr+1;
            XlinkL := Xlink-16;
            YlinkL := Ylink+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(YlinkL));
            LinkStr := LinkStr+1;
            XlinkR := Xlink+32;
            YlinkR := Ylink+10;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(YlinkR));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            IndexStr := IndexStr + (LinkStr - LinkStrBefore);
            ActInfoPos := ActInfoPos + (LinkStr - LinkStrBefore);

            ORDIVside := 1;
            CreateTransition(sfcSL, IndexStr, Ntrans, Nstep, Xcoord, Ycoord, ORDIVside, ActInfoPos);

            Cond := Copy(gerSL[i], 7, Length(gerSL[i])-7-(Length(gerSL[i])-Pos(')',gerSL[i])));

            sfcSL.Insert(ActInfoPos, Cond + ';');
            IndexStr := IndexStr+1;

            LinkStrBefore := LinkStr;
            // Запись связи "ORDIV - левый переход"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(YlinkL));
            LinkStr := LinkStr+1;
            YlinkL := YlinkL+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkL)+' '+IntToStr(YlinkL));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 7');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 3 T'+IntToStr(Ntrans));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            IndexStr := IndexStr + (LinkStr - LinkStrBefore);
            ActInfoPos := ActInfoPos + (LinkStr - LinkStrBefore);

            ORDIVside := 2;
            CreateTransition(sfcSL, IndexStr, Ntrans, Nstep, Xcoord, Ycoord, ORDIVside, ActInfoPos);

            sfcSL.Insert(ActInfoPos, 'not('+ Cond +');' );
            IndexStr := IndexStr+1;

            LinkStrBefore := LinkStr;
            // Запись связи "ORDIV - правый переход"
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#info= LINK');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(YlinkR));
            LinkStr := LinkStr+1;
            YlinkR := YlinkR+2;
            sfcSL.Insert(LinkStr, 'COORD= '+IntToStr(XlinkR)+' '+IntToStr(YlinkR));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'FROM= 7');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, 'TO= 3 T'+IntToStr(Ntrans));
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '#end_info');
            LinkStr := LinkStr+1;
            sfcSL.Insert(LinkStr, '');

            IndexStr := IndexStr + (LinkStr - LinkStrBefore);
            ActInfoPos := ActInfoPos + (LinkStr - LinkStrBefore);

            ORDIVside := 1;

            continue;
        end;


        // если Блок комментария ----------------------
        if(Pos('Ком:', gerSL[i]) <> 0) then
        begin
          Com := Copy(gerSL[i], 5, Length(gerSL[i])-4 );
          Com := AnsiToUtf8(Com);

          sfcSL.Insert(ActInfoPos, '(* ' + Com + ' *)');
          ActInfoPos := ActInfoPos+1;
          IndexStr := IndexStr+1;

        continue;
        end;


        // если Блок Действия --------------------------
        if(Pos('=', gerSL[i]) <> 0) then
        begin
            e := Pos('=', gerSL[i]);
            NewVar := Copy(gerSL[i], 1, e-1);
            Expr := Copy(gerSL[i], e+1, Length(gerSL[i])-e );

            if(VarsSL.IndexOf(NewVar) = -1) then
            begin
            DictStrBefore := DictStr;

            VarsSL.Add(NewVar) ;

            DictStr := DictStr+1;
            if(Pos('true', gerSL[i])<>0) or (Pos('false', gerSL[i])<>0) then
sfcSL.Insert(DictStr, '    <Variable Name="' + NewVar +
'" DataType="BOOL" InitialValue="" Comment="" Address="" Kind="Var" Alias="" AccessRights="ReadWrite" StringSize="0" />')
            else
sfcSL.Insert(DictStr, '    <Variable Name="' + NewVar +
'" DataType="DINT" InitialValue="" Comment="" Address="" Kind="Var" Alias="" AccessRights="ReadWrite" StringSize="0" />');

            LinkStr := LinkStr + (DictStr - DictStrBefore);
            IndexStr := IndexStr + (DictStr - DictStrBefore);
            ActInfoPos := ActInfoPos + (DictStr - DictStrBefore);
            end;

        sfcSL.Insert(ActInfoPos, NewVar + ' := ' + Expr + ';');
        ActInfoPos := ActInfoPos+1;
        IndexStr := IndexStr+1;

        continue;
        end;


        // если Блок вызова процедуры/функции ------------------
        if(Pos('()', gerSL[i]) <> 0) or
          ((Pos('(', gerSL[i]) <> 0) and (Pos( ')', gerSL[i]) <> 0)) then
        begin
          sfcSL.Insert(ActInfoPos, gerSL[i]+';');
          ActInfoPos := ActInfoPos+1;
          IndexStr := IndexStr+1;

          continue;
        end;


        // Если конец алгоритма -----------------
        if(Pos('Кон:', gerSL[i]) <> 0) then
        begin
            if(lastElem = 2)then // если последний элемент - шаг
              continue
            else if(lastElem = 8)then // если последний элемент - ORCONV
            begin
              Ycoord := Ycoord+12;
              CreateStep(sfcSL, IndexStr, Nstep, Nact, Xcoord, Ycoord, ORDIVside, ActInfoPos);
              continue;
            end;
        end;

    end;


    sfcSL.SaveToFile(Edit2.Text);

    gerSL.Free;
    sfcSL.Free;
    VarsSL.Free;

    // Удаление кэша программы для сохранения изменений
    cashDel := StringReplace(Edit2.Text, 'Device1\Resource1\Prog1.isaxml', 'PrjLibrary.mdb', []);
    DeleteFile(cashDel);
end;



procedure TForm1.CreateTransition(sfcSL: TStringList; var IndexStr: integer; var Ntrans: integer;
          Nstep: integer; Xcoord: integer; var Ycoord: integer; ORDIVside: integer;
          var ActInfoPos: integer);
begin
            Ntrans:=Ntrans+1;

            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, 'TRANSITION T'+ IntToStr(Ntrans));
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, 'FROM S'+ IntToStr(Nstep));
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, 'TO S'+IntToStr(Nstep+1)+' :');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '#info= ST');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '#end_info');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '#info= COORD');
            IndexStr:=IndexStr+1;
              if(ORDIVside = 1) then  // если переход с условием в левой ветви
              begin
                Ycoord:=Ycoord+24;
                ActInfoPos := IndexStr-2;
                sfcSL.Insert(IndexStr, '[ '+IntToStr(Xcoord-16)+' , ' +IntToStr(Ycoord)+ ' ]');
              end
              else if(ORDIVside = 11) then
              begin
                Ycoord:=Ycoord+12;
                sfcSL.Insert(IndexStr, '[ '+IntToStr(Xcoord-16)+' , ' +IntToStr(Ycoord)+ ' ]');
              end
              else if(ORDIVside = 2) then // если переход с условием в правой ветви
              begin
                ActInfoPos := IndexStr-2;
                sfcSL.Insert(IndexStr, '[ '+IntToStr(Xcoord+32)+' , ' +IntToStr(Ycoord)+ ' ]');
              end
              else if(ORDIVside = 22) then
              begin
                sfcSL.Insert(IndexStr, '[ '+IntToStr(Xcoord+32)+' , ' +IntToStr(Ycoord)+ ' ]');
              end
              else
              begin
                Ycoord:=Ycoord+12;
                sfcSL.Insert(IndexStr, '[ '+IntToStr(Xcoord)+' , ' +IntToStr(Ycoord)+ ' ]');
              end;
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '#end_info');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, 'END_TRANSITION');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '');
end;

procedure TForm1.CreateStep(sfcSL: TStringList; var IndexStr: integer; var Nstep: integer;
          var Nact: integer; Xcoord: integer; var Ycoord: integer; ORDIVside: integer; var ActInfoPos: integer);
begin
            Nstep := Nstep+1;

            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, 'STEP S'+IntToStr(Nstep)+' :');
            IndexStr:=IndexStr+1;
            Nact:=Nact+1;
            sfcSL.Insert(IndexStr, 'Action'+IntToStr(Nact)+' (N);');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '#info= COORD');
            IndexStr:=IndexStr+1;
            if(ORDIVside = 1) then
              begin
                Ycoord:=Ycoord+12;
                sfcSL.Insert(IndexStr, '[ '+IntToStr(Xcoord-16)+' , ' +IntToStr(Ycoord)+ ' ]');
              end
              else if(ORDIVside = 2) then
              begin
                sfcSL.Insert(IndexStr, '[ '+IntToStr(Xcoord+32)+' , ' +IntToStr(Ycoord-12)+ ' ]');
              end
              else
              begin
                Ycoord:=Ycoord+12;
                sfcSL.Insert(IndexStr, '[ '+IntToStr(Xcoord)+' , ' +IntToStr(Ycoord)+ ' ]');
              end;
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '#end_info');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, 'END_STEP');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '');

            CreateAction(sfcSL, IndexStr, Nact, ActInfoPos);
end;

procedure TForm1.CreateAction(sfcSL: TStringList; var IndexStr: integer; Nact: integer;
          var ActInfoPos: integer);
begin
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, 'ACTION Action'+IntToStr(Nact)+' :');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '#info= ST');
            IndexStr:=IndexStr+1;
            ActInfoPos := IndexStr;
            sfcSL.Insert(IndexStr, '#end_info');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, 'END_ACTION');
            IndexStr:=IndexStr+1;
            sfcSL.Insert(IndexStr, '');
end;


procedure TForm1.Button1Click(Sender: TObject);
begin
  OpenTextFileDialog1.Filter:='Файл с алгоритмом на языке Геракл *.txt|*.txt';
  if OpenTextFileDialog1.Execute then
    Edit1.Text := OpenTextFileDialog1.FileName;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  OpenTextFileDialog1.Filter:='Файл Prog1.isaxml | Prog1.isaxml';

  if OpenTextFileDialog1.Execute then
    Edit2.Text := OpenTextFileDialog1.FileName;
end;


procedure TForm1.Button3Click(Sender: TObject);
begin
    try
       Algorithm();
       ShowMessage('Программа успешно выполнена');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end;

end.

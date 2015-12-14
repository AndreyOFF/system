Procedure STVGK1;
Begin
Запись_ФС(0,'Начало: STVGK1');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР098:= True;
ПЕРЕЗАПУСК_ТАЙМЕРА(MainForm.TВГК1,400,'TВГК1');
Т_ВГК1:= True;
Запись_ФС(0,'Конец: STVGK1');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure STVGK2;
Begin
Запись_ФС(0,'Начало: STVGK2');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР099:= True;
ПЕРЕЗАПУСК_ТАЙМЕРА(MainForm.TВГК2,400,'TВГК2');
Т_ВГК2:= True;
Запись_ФС(0,'Конец: STVGK2');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure STVGK3;
Begin
Запись_ФС(0,'Начало: STVGK3');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР100:= True;
ПЕРЕЗАПУСК_ТАЙМЕРА(MainForm.TВГК3,400,'TВГК3');
Т_ВГК3:= True;
Запись_ФС(0,'Конец: STVGK3');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ATVGK1;
Begin
Запись_ФС(0,'Начало: ATVGK1');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР101:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.TВГК1,'TВГК1');
Т_ВГК1:= False;
ВКЛГК1:= True;
РОБГК1:= True;
Запись_ФС(0,'Конец: ATVGK1');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ATVGK2;
Begin
Запись_ФС(0,'Начало: ATVGK2');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР102:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.TВГК2,'TВГК2');
Т_ВГК2:= False;
ВКЛГК2:= True;
РОБГК2:= True;
Запись_ФС(0,'Конец: ATVGK2');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ATVGK3;
Begin
Запись_ФС(0,'Начало: ATVGK3');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР103:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.TВГК3,'TВГК3');
Т_ВГК3:= False;
ВКЛГК3:= True;
РОБГК3:= True;
Запись_ФС(0,'Конец: ATVGK3');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OGK1;
Begin
Запись_ФС(0,'Начало: OGK1');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР088:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.TВГК1,'TВГК1');
Т_ВГК1:= False;
ВКЛГК1:= True;
РОБГК1:= True;
Запись_ФС(0,'Конец: OGK1');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OGK2;
Begin
Запись_ФС(0,'Начало: OGK2');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР089:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.TВГК2,'TВГК2');
Т_ВГК2:= False;
ВКЛГК2:= True;
РОБГК2:= True;
Запись_ФС(0,'Конец: OGK2');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OGK3;
Begin
Запись_ФС(0,'Начало: OGK3');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР090:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.TВГК3,'TВГК3');
Т_ВГК3:= False;
ВКЛГК3:= True;
РОБГК3:= True;
Запись_ФС(0,'Конец: OGK3');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ONDK;
Begin
Запись_ФС(0,'Начало: ONDK');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР077:= True;
FKU(X2KY78,1,'X2KY78 = ',0);
FKU(X2KY79,1,'X2KY79 = ',0);
FKU(X2KY6E,1,'X2KY6E = ',0);
FKU(X2KY6F,1,'X2KY6F = ',0);
FKU(X2KY47,1,'X2KY47 = ',0);
FKU(X2KY4A,1,'X2KY4A = ',0);
FKU(X2KY5B,1,'X2KY5B = ',0);
FKU(X2KY5E,1,'X2KY5E = ',0);
Запись_ФС(0,'Конец: ONDK');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDNDK1;
Begin
Запись_ФС(0,'Начало: VDNDK1');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР073:= True;
FKU(X2КУ78,1,'X2КУ78 = ',0);
 If   Not ЗКУДК  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X2КУ46,1,'X2КУ46 = ',0);
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: VDNDK1');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDNDK2;
Begin
Запись_ФС(0,'Начало: VDNDK2');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР074:= True;
FKU(X2КУ79,1,'X2КУ79 = ',0);
 If   Not ЗКУДК  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X2КУ49,1,'X2КУ49 = ',0);
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: VDNDK2');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDNDK3;
Begin
Запись_ФС(0,'Начало: VDNDK3');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР075:= True;
FKU(X2КУ6E,1,'X2КУ6E = ',0);
 If   Not ЗКУДК  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X2КУ5A,1,'X2КУ5A = ',0);
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: VDNDK3');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDNDK4;
Begin
Запись_ФС(0,'Начало: VDNDK4');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР076:= True;
FKU(X2КУ6F,1,'X2КУ6F = ',0);
 If   Not ЗКУДК  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X2КУ5D,1,'X2КУ5D = ',0);
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: VDNDK4');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ODO;
Begin
Запись_ФС(0,'Начало: ODO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР200:= True;
FKU(X2КУ61,1,'X2КУ61 = ',0);
FKU(X2КУ63,1,'X2КУ63 = ',0);
FKU(X2КУ65,1,'X2КУ65 = ',0);
FKU(X2КУ67,1,'X2КУ67 = ',0);
FKU(X2КУ69,1,'X2КУ69 = ',0);
FKU(X2КУB,1,'X2КУB = ',0);
Запись_ФС(0,'Конец: ODO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ODK;
Begin
Запись_ФС(0,'Начало: ODK');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР201:= True;
FKU(X2КУ76,1,'X2КУ76 = ',0);
FKU(X2КУ77,1,'X2КУ77 = ',0);
FKU(X2КУ7A,1,'X2КУ7A = ',0);
FKU(X2КУ7B,1,'X2КУ7B = ',0);
Запись_ФС(0,'Конец: ODK');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ZAWRASO;
Begin
Запись_ФС(0,'Начало: ZAWRASO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР025:= True;
FKU(X1КУ24,1,'X1КУ24 = ',0);
FKU(X1КУ05,1,'X1КУ05 = ',0);
Запись_ФС(0,'Конец: ZAWRASO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ATOPRD;
Begin
Запись_ФС(0,'Начало: ATOPRD');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР040:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.ТОПРД,'ТОПРД');
Т_ОПРД:= False;
FKU(X2КУ49,1,'X2КУ49 = ',0);
Запись_ФС(0,'Конец: ATOPRD');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ATOBDO;
Begin
Запись_ФС(0,'Начало: ATOBDO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР041:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.ТОПРД,'ТОПРД');
Т_ОБДО:= False;
FKU(X2КУ0B,1,'X2КУ0B = ',0);
Запись_ФС(0,'Конец: ATOBDO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ОBRKKU;
Begin
Запись_ФС(0,'Начало: ОBRKKU');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР073:= True;
FKU(X1КУ14,1,'X1КУ14 = ',0);
 If  ТОБРК_  Then Блок := 3  Else Блок :=  2;
End;
2:Begin Ранг := 2;
ЗАПУСК_ТАЙМЕРА(MainForm.ТОБРК,500,'ТОБРК');
Т_ОБРК:= True;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: ОBRKKU');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ОUDM;
Begin
Запись_ФС(0,'Начало: ОUDM');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР045:= True;
FKU(X3КУ50,1,'X3КУ50 = ',0);
FKU(X3КУ51,1,'X3КУ51 = ',0);
FKU(X3КУ52,1,'X3КУ52 = ',0);
FKU(X3КУ53,1,'X3КУ53 = ',0);
Запись_ФС(0,'Конец: ОUDM');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ОPS24BS;
Begin
Запись_ФС(0,'Начало: ОPS24BS');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР046:= True;
FKU(X4КУ09,1,'X4КУ09 = ',0);
FKU(X4КУ0B,1,'X4КУ0B = ',0);
Запись_ФС(0,'Конец: ОPS24BS');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure P1BHP;
Begin
Запись_ФС(0,'Начало: P1BHP');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР047:= True;
FKU(X4КУ18,1,'X4КУ18 = ',0);
FKU(X4КУ1A,1,'X4КУ1A = ',0);
Запись_ФС(0,'Конец: P1BHP');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure P2BHP;
Begin
Запись_ФС(0,'Начало: P2BHP');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР048:= True;
FKU(X4КУ19,1,'X4КУ19 = ',0);
FKU(X4КУ1B,1,'X4КУ1B = ',0);
Запись_ФС(0,'Конец: P2BHP');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure  STTREV;
Begin
Запись_ФС(0,'Начало:  STTREV');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР035:= True;
 If  ТТРЕВОГ_  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
ЗАПУСК_ТАЙМЕРА(MainForm.ТТРЕВОГ, 1100,'ТТРЕВОГ');
Т_ТРЕВОГ:= True;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец:  STTREV');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure  HTTREV;
Begin
Запись_ФС(0,'Начало:  HTTREV');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР037:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА (MainForm.ТТРЕВОГ,'ТТРЕВОГ');
Т_ТРЕВОГ:= False;
FKU(X1KY1E,1,'X1KY1E = ',0);
Запись_ФС(0,'Конец:  HTTREV');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure SOPDO;
Begin
Запись_ФС(0,'Начало: SOPDO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР200:= True;
 If  ОПДО  Then Блок := 3  Else Блок :=  2;
End;
2:Begin Ранг := 2;
ЗАПУСК_ТАЙМЕРА(MainForm.ТОПДО, 1200,'ТОПДО');
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: SOPDO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure STTEN;
Begin
Запись_ФС(0,'Начало: STTEN');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР027:= True;
FKU(X1KY07,1,'X1KY07 = ',0);
ЗАПУСК_ТАЙМЕРА(MainForm.TТЕНЬ,1600,'TТЕНЬ');
РТТЕНЬ:= True;
Запись_ФС(0,'Конец: STTEN');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ATTEN;
Begin
Запись_ФС(0,'Начало: ATTEN');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР028:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.TТЕНЬ,'TТЕНЬ');
РТТЕНЬ:= False;
FKU(X1KY08,1,'X1KY08 = ',0);
Запись_ФС(0,'Конец: ATTEN');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ATVKSNA;
Begin
Запись_ФС(0,'Начало: ATVKSNA');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР038:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.ТВКСНА,'ТВКСНА');
Т_ВКСНА:= False;
FKU(X3KY30,1,'X3KY30 = ',0);
FKU(X3KY33,1,'X3KY33 = ',0);
FKU(X3KY36,1,'X3KY36 = ',0);
FKU(X3KY39,1,'X3KY39 = ',0);
Запись_ФС(0,'Конец: ATVKSNA');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ATOBRK;
Begin
Запись_ФС(0,'Начало: ATOBRK');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.ТОБРК,'ТОБРК');
Т_ОБРК:= False;
FKU(X1KY15,1,'X1KY15 = ',0);
Запись_ФС(0,'Конец: ATOBRK');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure  STRNSO;
Begin
Запись_ФС(0,'Начало:  STRNSO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР033:= True;
FKU(X1KY07,1,'X1KY07 = ',0);
 If  РТРНСО  Then Блок := 3  Else Блок :=  2;
End;
2:Begin Ранг := 2;
ЗАПУСК_ТАЙМЕРА(MainForm.ТРНСО,1500,'ТРНСО');
РТРНСО:= True;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: STRNSO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure  ATRNSO;
Begin
Запись_ФС(0,'Начало:  ATRNSO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР094:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.ТРНСО,'ТРНСО');
РТРНСО:= False;
FKU(X1KY08,1,'X1KY08 = ',0);
Запись_ФС(0,'Конец:  ATRNSO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure HTTENRNS;
Begin
Запись_ФС(0,'Начало: HTTENRNS');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР029:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.TТЕНЬ,'TТЕНЬ');
РТТЕНЬ:= False;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.ТРНСО,'ТРНСО');
РТРНСО:= False;
Запись_ФС(0,'Конец: HTTENRNS');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure NVIP;
Begin
Запись_ФС(0,'Начало: NVIP');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР009:= True;
 If  ЗАПВИП  Then Блок := 7  Else Блок :=  2;
End;
2:Begin Ранг := 2;
 If  СДПНК13 And ВИП1МС And ННВИПМС  Then Блок := 3  Else Блок :=  4;
End;
3:Begin Ранг := 2;
// ВЫДАТЬ В УУ СК1 FПВИП НА T 50 100МС
Блок := 4;
End;
4:Begin Ранг := 2;
 If  СДПНК13 And ВИП1МС  Then Блок := 5  Else Блок :=  6;
End;
5:Begin Ранг := 2;
ННВИП:= True;
Блок := 7;
End;
6:Begin Ранг := 2;
ННВИП:= False;
Блок := 7;
End;
7:Begin Ранг := 2;
Запись_ФС(0,'Конец: NVIP');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure NVIPD;
Begin
Запись_ФС(0,'Начало: NVIPD');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР010:= True;
 If  ЗАПВИПД  Then Блок := 6  Else Блок :=  2;
End;
2:Begin Ранг := 2;
 If   Not НВИПС And ВИП1 And ННИПСК  Then Блок := 3  Else Блок :=  4;
End;
3:Begin Ранг := 2;
FKU(X2KY0E,1,'X2KY0E = ',0);
End;
4:Begin Ранг := 2;
 If   Not НВИПД And ВИПД1  Then Блок := 5  Else Блок :=  6;
End;
5:Begin Ранг := 2;
ННВИПД:= True;
Блок := 6;
End;
7:Begin Ранг := 2;
ННВИПД:= False;
Блок := 6;
End;
6:Begin Ранг := 2;
Запись_ФС(0,'Конец: NVIPD');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OPODG;
Begin
Запись_ФС(0,'Начало: OPODG');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР021:= True;
 If  ОПДО  Then Блок := 2  Else Блок :=  15;
End;
2:Begin Ранг := 2;
Т_ОПДО:= False;
FKU(X2KY70,1,'X2KY70 = ',0);
FKU(X2KY18,1,'X2KY18 = ',0);
FKU(X2KY71,1,'X2KY71 = ',0);
FKU(X2KY1B,1,'X2KY1B = ',0);
FKU(X2KY72,1,'X2KY72 = ',0);
FKU(X2KY3F,1,'X2KY3F = ',0);
FKU(X2KY73,1,'X2KY73 = ',0);
FKU(X2KY41,1,'X2KY41 = ',0);
FKU(X2KY74,1,'X2KY74 = ',0);
FKU(X2KY04,1,'X2KY04 = ',0);
FKU(X2KY75,1,'X2KY75 = ',0);
FKU(X2KY07,1,'X2KY07 = ',0);
 If  ПНДК1  Then Блок := 3  Else Блок :=  5;
End;
3:Begin Ранг := 2;
FKU(X2KY78,1,'X2KY78 = ',0);
 If  ЗКУДК  Then Блок := 4  Else Блок :=  5;
End;
4:Begin Ранг := 2;
FKU(X2KY46,1,'X2KY46 = ',0);
Блок := 5;
End;
5:Begin Ранг := 2;
FKU(X2KY07,1,'X2KY07 = ',0);
 If  ПНДК2  Then Блок := 6  Else Блок :=  8;
End;
6:Begin Ранг := 2;
FKU(X2KY79,1,'X2KY79 = ',0);
 If   Not ЗКУДК  Then Блок := 7  Else Блок :=  8;
End;
7:Begin Ранг := 2;
FKU(X2KY49,1,'X2KY49 = ',0);
Блок := 8;
End;
8:Begin Ранг := 2;
 If  ПНДК3  Then Блок := 9  Else Блок :=  11;
End;
9:Begin Ранг := 2;
FKU(X2KY6Е,1,'X2KY6Е = ',0);
 If   Not ЗКУДК  Then Блок := 10  Else Блок :=  11;
End;
10:Begin Ранг := 2;
FKU(X2KY5А,1,'X2KY5А = ',0);
Блок := 11;
End;
11:Begin Ранг := 2;
 If  ПНДК4  Then Блок := 12  Else Блок :=  14;
End;
12:Begin Ранг := 2;
FKU(X2KY6F,1,'X2KY6F = ',0);
 If   Not ЗКУДК  Then Блок := 13  Else Блок :=  14;
End;
13:Begin Ранг := 2;
FKU(X2KY5D,1,'X2KY5D = ',0);
Блок := 14;
End;
14:Begin Ранг := 2;
FKU(X2KY0C,1,'X2KY0C = ',0);
Блок := 15;
End;
15:Begin Ранг := 2;
Запись_ФС(0,'Конец: OPODG');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VNGDO;
Begin
Запись_ФС(0,'Начало: VNGDO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР054:= True;
 If  ВПОДГ  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X2KY1A,1,'X2KY1A = ',0);
FKU(X2KY1D,1,'X2KY1D = ',0);
FKU(X2KY0E,1,'X2KY0E = ',0);
FKU(X2KY0F,1,'X2KY0F = ',0);
FKU(X2KY06,1,'X2KY06 = ',0);
FKU(X2KY09,1,'X2KY09 = ',0);
Блок := 4;
End;
3:Begin Ранг := 2;
FKU(X2KY70,1,'X2KY70 = ',0);
FKU(X2KY18,1,'X2KY18 = ',0);
FKU(X2KY71,1,'X2KY71 = ',0);
FKU(X2KY1B,1,'X2KY1B = ',0);
FKU(X2KY72,1,'X2KY72 = ',0);
FKU(X2KY3F,1,'X2KY3F = ',0);
FKU(X2KY73,1,'X2KY73 = ',0);
FKU(X2KY41,1,'X2KY41 = ',0);
FKU(X2KY74,1,'X2KY74 = ',0);
FKU(X2KY04,1,'X2KY04 = ',0);
FKU(X2KY75,1,'X2KY75 = ',0);
FKU(X2KY075,1,'X2KY075 = ',0);
Блок := 4;
End;
4:Begin Ранг := 2;
Запись_ФС(0,'Конец: VNGDO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VODO;
Begin
Запись_ФС(0,'Начало: VODO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР055:= True;
FKU(X2KY14,1,'X2KY14 = ',0);
FKU(X2KY16,1,'X2KY16 = ',0);
FKU(X2KY3B,1,'X2KY3B = ',0);
FKU(X2KY3D,1,'X2KY3D = ',0);
FKU(X2KY00,1,'X2KY00 = ',0);
FKU(X2KY02,1,'X2KY02 = ',0);
Запись_ФС(0,'Конец: VODO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VRDO;
Begin
Запись_ФС(0,'Начало: VRDO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР056:= True;
FKU(X2KY15,1,'X2KY15 = ',0);
FKU(X2KY17,1,'X2KY17 = ',0);
FKU(X2KY3C,1,'X2KY3C = ',0);
FKU(X2KY3E,1,'X2KY3E = ',0);
FKU(X2KY01,1,'X2KY01 = ',0);
FKU(X2KY03,1,'X2KY03 = ',0);
Запись_ФС(0,'Конец: VRDO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OND1;
Begin
Запись_ФС(0,'Начало: OND1');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР078:= True;
FKU(X2KY70,1,'X2KY70 = ',0);
FKU(X2KY19,1,'X2KY19 = ',0);
Запись_ФС(0,'Конец: OND1');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OND2;
Begin
Запись_ФС(0,'Начало: OND2');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР079:= True;
FKU(X2KY71,1,'X2KY71 = ',0);
FKU(X2KY1C,1,'X2KY1C = ',0);
Запись_ФС(0,'Конец: OND2');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OND3;
Begin
Запись_ФС(0,'Начало: OND3');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР080:= True;
FKU(X2KY72,1,'X2KY72 = ',0);
FKU(X2KY40,1,'X2KY40 = ',0);
Запись_ФС(0,'Конец: OND3');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OND4;
Begin
Запись_ФС(0,'Начало: OND4');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР081:= True;
FKU(X2KY73,1,'X2KY73 = ',0);
FKU(X2KY42,1,'X2KY42 = ',0);
Запись_ФС(0,'Конец: OND4');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OND5;
Begin
Запись_ФС(0,'Начало: OND5');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР082:= True;
FKU(X2KY74,1,'X2KY74 = ',0);
FKU(X2KY05,1,'X2KY05 = ',0);
Запись_ФС(0,'Конец: OND5');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OND6;
Begin
Запись_ФС(0,'Начало: OND6');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР083:= True;
FKU(X2KY75,1,'X2KY75 = ',0);
FKU(X2KY08,1,'X2KY08 = ',0);
Запись_ФС(0,'Конец: OND6');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDND1;
Begin
Запись_ФС(0,'Начало: VDND1');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР067:= True;
FKU(X2KY70,1,'X2KY70 = ',0);
FKU(X2KY18,1,'X2KY18 = ',0);
Запись_ФС(0,'Конец: VDND1');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDND2;
Begin
Запись_ФС(0,'Начало: VDND2');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР068:= True;
FKU(X2KY71,1,'X2KY71 = ',0);
FKU(X2KY1B,1,'X2KY1B = ',0);
Запись_ФС(0,'Конец: VDND2');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDND3;
Begin
Запись_ФС(0,'Начало: VDND3');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР069:= True;
FKU(X2KY72,1,'X2KY72 = ',0);
FKU(X2KY3F,1,'X2KY3F = ',0);
Запись_ФС(0,'Конец: VDND3');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDND4;
Begin
Запись_ФС(0,'Начало: VDND4');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР070:= True;
FKU(X2KY73,1,'X2KY73 = ',0);
FKU(X2KY41,1,'X2KY41 = ',0);
Запись_ФС(0,'Конец: VDND4');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDND5;
Begin
Запись_ФС(0,'Начало: VDND5');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР071:= True;
FKU(X2KY74,1,'X2KY74 = ',0);
FKU(X2KY04,1,'X2KY04 = ',0);
Запись_ФС(0,'Конец: VDND5');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VDND6;
Begin
Запись_ФС(0,'Начало: VDND6');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР072:= True;
FKU(X2KY75,1,'X2KY75 = ',0);
FKU(X2KY07,1,'X2KY07 = ',0);
Запись_ФС(0,'Конец: VDND6');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure  RRU;
Begin
Запись_ФС(0,'Начало:  RRU');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР030:= True;
 If  РТРУУ  Then Блок := 3  Else Блок :=  2;
End;
2:Begin Ранг := 2;
ЗАПУСК_ТАЙМЕРА(MainForm.ТРРУ,1000,'ТРРУ');
РТРУУ:= True;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: RRU');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OBSD;
Begin
Запись_ФС(0,'Начало: OBSD');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР027:= True;
FKU(X2KY35,1,'X2KY35 = ',0);
FKU(X2KY37,1,'X2KY37 = ',0);
Запись_ФС(0,'Конец: OBSD');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VVIPD1;
Begin
Запись_ФС(0,'Начало: VVIPD1');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР085:= True;
FKU(X2KY7F,1,'X2KY7F = ',0);
FKU(X2KY7C,1,'X2KY7C = ',0);
Запись_ФС(0,'Конец: VVIPD1');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VVIPD2;
Begin
Запись_ФС(0,'Начало: VVIPD2');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР086:= True;
FKU(X2KY7D,1,'X2KY7D = ',0);
FKU(X2KY7E,1,'X2KY7E = ',0);
Запись_ФС(0,'Конец: VVIPD2');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VVIPD;
Begin
Запись_ФС(0,'Начало: VVIPD');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР087:= True;
FKU(X2KY7D,1,'X2KY7D = ',0);
FKU(X2KY7F,1,'X2KY7F = ',0);
Запись_ФС(0,'Конец: VVIPD');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure V1REK;
Begin
Запись_ФС(0,'Начало: V1REK');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР091:= True;
FKU(X5KY0B,1,'X5KY0B = ',0);
FKU(X5KY08,1,'X5KY08 = ',0);
Запись_ФС(0,'Конец: V1REK');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OREK;
Begin
Запись_ФС(0,'Начало: OREK');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР092:= True;
FKU(X5KY0A,1,'X5KY0A = ',0);
FKU(X5KY0B,1,'X5KY0B = ',0);
Запись_ФС(0,'Конец: OREK');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OPNK;
Begin
Запись_ФС(0,'Начало: OPNK');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР093:= True;
FKU(X5KY01,1,'X5KY01 = ',0);
FKU(X5KY05,1,'X5KY05 = ',0);
Запись_ФС(0,'Конец: OPNK');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ONDO;
Begin
Запись_ФС(0,'Начало: ONDO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР084:= True;
OND1;
OND2;
OND3;
OND4;
OND5;
OND6;
FKU(X2КУ13,1,'X2КУ13 = ',0);
Запись_ФС(0,'Конец: ONDO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure OKUD;
Begin
Запись_ФС(0,'Начало: OKUD');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР052:= True;
ODO;
ODK;
FKU(X2КУ39,1,'X2КУ39 = ',0);
Запись_ФС(0,'Конец: OKUD');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure TREV;
Begin
Запись_ФС(0,'Начало: TREV');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР034:= True;
ODO;
ODK;
FKU(X2KY1D,1,'X2KY1D = ',0);
FKU(X1KY10,1,'X1KY10 = ',0);
Запись_ФС(0,'Конец: TREV');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPD1;
Begin
Запись_ФС(0,'Начало: VPD1');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР057:= True;
FKU(X2KY1A,1,'X2KY1A = ',0);
SOPDO;
Запись_ФС(0,'Конец: VPD1');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPD2;
Begin
Запись_ФС(0,'Начало: VPD2');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР058:= True;
FKU(X2KY1D,1,'X2KY1D = ',0);
SOPDO;
Запись_ФС(0,'Конец: VPD2');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPD3;
Begin
Запись_ФС(0,'Начало: VPD3');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР057:= True;
FKU(X2КУ0E,1,'X2КУ0E = ',0);
SOPDO;
Запись_ФС(0,'Конец: VPD3');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPD4;
Begin
Запись_ФС(0,'Начало: VPD4');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР060:= True;
FKU(X2KY0F,1,'X2KY0F = ',0);
SOPDO;
Запись_ФС(0,'Конец: VPD4');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPD5;
Begin
Запись_ФС(0,'Начало: VPD5');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР061:= True;
FKU(X2KY06,1,'X2KY06 = ',0);
SOPDO;
Запись_ФС(0,'Конец: VPD5');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPD6;
Begin
Запись_ФС(0,'Начало: VPD6');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР062:= True;
FKU(X2KY09,1,'X2KY09 = ',0);
SOPDO;
Запись_ФС(0,'Конец: VPD6');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ONBU;
Begin
Запись_ФС(0,'Начало: ONBU');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР020:= True;
 If  ZOН  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X1KY25,1,'X1KY25 = ',0);
ОBRKKU;
FKU(X1KY16,1,'X1KY16 = ',0);
FKU(X1KY17,1,'X1KY17 = ',0);
FKU(X2KY76,1,'X2KY76 = ',0);
FKU(X2KY77,1,'X2KY77 = ',0);
FKU(X2KY7A,1,'X2KY7A = ',0);
FKU(X2KY7B,1,'X2KY7B = ',0);
FKU(X2KY78,1,'X2KY78 = ',0);
FKU(X2KY79,1,'X2KY79 = ',0);
FKU(X2KY6E,1,'X2KY6E = ',0);
FKU(X2KY6F,1,'X2KY6F = ',0);
FKU(X2KY47,1,'X2KY47 = ',0);
FKU(X2KY4A,1,'X2KY4A = ',0);
FKU(X2KY5B,1,'X2KY5B = ',0);
FKU(X2KY5E,1,'X2KY5E = ',0);
FKU(X3KY32,1,'X3KY32 = ',0);
FKU(X3KY35,1,'X3KY35 = ',0);
FKU(X3KY38,1,'X3KY38 = ',0);
FKU(X3KY3B,1,'X3KY3B = ',0);
ЗАПУСК_ТАЙМЕРА(MainForm.ТВКСНА,1400,'ТВКСНА');
Т_ВКСНА:= True;
FKU(X1KY09,1,'X1KY09 = ',0);
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: ONBU');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPDK1;
Begin
Запись_ФС(0,'Начало: VPDK1');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР063:= True;
 If   Not ЗКУДК  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X2KY18,1,'X2KY18 = ',0);
SOPDO;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: VPDK1');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPDK2;
Begin
Запись_ФС(0,'Начало: VPDK2');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР064:= True;
 If   Not ЗКУДК  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X2KY4B,1,'X2KY4B = ',0);
SOPDO;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: VPDK2');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPDK3;
Begin
Запись_ФС(0,'Начало: VPDK3');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР065:= True;
 If   Not ЗКУДК  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X2KY5C,1,'X2KY5C = ',0);
SOPDO;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: VPDK3');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VPDK4;
Begin
Запись_ФС(0,'Начало: VPDK4');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР066:= True;
 If   Not ЗКУДК  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X2KY5F,1,'X2KY5F = ',0);
SOPDO;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: VPDK4');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure  HTRRU;
Begin
Запись_ФС(0,'Начало:  HTRRU');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР032:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.TТЕНЬ,'TТЕНЬ');
РТРУУ:= False;
Запись_ФС(0,'Конец:  HTRRU');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure VKRASO;
Begin
Запись_ФС(0,'Начало: VKRASO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР024 := True;
ODO;
FKU(X3KY59,1,'X3KY59 = ',0);
FKU(X1KY1A,1,'X1KY1A = ',0);
FKU(X1KY1C,1,'X1KY1C = ',0);
ЗАПУСК_ТАЙМЕРА(MainForm.ТОПРД,1300,'ТОПРД');;
Т_ОПРД:= True;
ONBU;
FKU(X1KY20,1,'X1KY20 = ',0);
FKU(X2KY0A,1,'X2KY0A = ',0);
ЗАПУСК_ТАЙМЕРА(MainForm.ТОБДО,1200,'ТОБДО');;
Т_ОБДО:= True;
ОUDM;
FKU(X3KY02,1,'X3KY02 = ',0);
FKU(X3KY03,1,'X3KY03 = ',0);
FKU(X3KY1D,1,'X3KY1D = ',0);
FKU(X3KY0C,1,'X3KY0C = ',0);
FKU(X3KY0D,1,'X3KY0D = ',0);
FKU(X3KY06,1,'X3KY06 = ',0);
FKU(X3KY07,1,'X3KY07 = ',0);
FKU(X3KY43,1,'X3KY43 = ',0);
FKU(X3KY3F,1,'X3KY3F = ',0);
FKU(X3KY48,1,'X3KY48 = ',0);
FKU(X3KY47,1,'X3KY47 = ',0);
 If  РДНС  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
FKU(X3KY14,1,'X3KY14 = ',0);
Блок := 3;
End;
3:Begin Ранг := 2;
FKU(X3KY15,1,'X3KY15 = ',0);
FKU(X3KY0E,1,'X3KY0E = ',0);
FKU(X3KY0F,1,'X3KY0F = ',0);
FKU(X3KY10,1,'X3KY10 = ',0);
// ВЫДАТЬ КОМАНДУ В ГК1 АНАЛОГ  X6KYD0
// ВЫДАТЬ КОМАНДУ В ГК2 АНАЛОГ  X6KYD4
// ВЫДАТЬ КОМАНДУ В ГК3 АНАЛОГ  X6KYD8
FKU(X1KY02,1,'X1KY02 = ',0);
Запись_ФС(0,'Конец: VKRASO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure TREVOG;
Begin
Запись_ФС(0,'Начало: TREVOG');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР095:= True;
TREV;
STTREV;
 If  ТТРЕВОГ_ And X6KY34  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
HTTREV;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: TREVOG');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure STRASO;
Begin
Запись_ФС(0,'Начало: STRASO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР022:= True;
FKU(X1KY03,1,'X1KY03 = ',0);
FKU(X1KY00,1,'X1KY00 = ',0);
FKU(X1KY0C,1,'X1KY0C = ',0);
FKU(X1KY1D,1,'X1KY1D = ',0);
ЗАПУСК_ТАЙМЕРА(MainForm.TТЕНЬ,1000,'TТЕНЬ');;
Запись_ФС(0,'Конец: STRASO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure STPASO;
Begin
Запись_ФС(0,'Начало: STPASO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР023:= True;
ODO;
FKU(X1KY20,1,'X1KY20 = ',0);
 If   Not РДНС  Then Блок := 2  Else Блок :=  4;
End;
2:Begin Ранг := 2;
FKU(X3KY14,1,'X3KY14 = ',0);
Блок := 3;
End;
4:Begin Ранг := 2;
FKU(X3KY15,1,'X3KY15 = ',0);
Блок := 3;
End;
3:Begin Ранг := 2;
FKU(X1KY04,1,'X1KY04 = ',0);
FKU(X1KY02,1,'X1KY02 = ',0);
Запись_ФС(0,'Конец: STPASO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ATTREV;
Begin
Запись_ФС(0,'Начало: ATTREV');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР036:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА (MainForm.ТТРЕВОГ,'ТТРЕВОГ');
Т_ТРЕВОГ:= False;
STRASO;
FKU(X1KY1F,1,'X1KY1F = ',0);
Запись_ФС(0,'Конец: ATTREV');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure ОRASO;
Begin
Запись_ФС(0,'Начало: ОRASO');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР043:= True;
FKU(X1KY01,1,'X1KY01 = ',0);
FKU(X1KY13,1,'X1KY13 = ',0);
ODO;
Запись_ФС(0,'Конец: ОRASO');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure  ATRRU;
Begin
Запись_ФС(0,'Начало:  ATRRU');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР031:= True;
ОСТАНОВ_И_ОБНУЛЕНИЕ_ТАЙМЕРА(MainForm.ТРРУ,'ТРРУ');
РТРУУ:= False;
STRASO;
FKU(X1КУС6,1,'X1КУС6 = ',0);
Запись_ФС(0,'Конец: ATRRU');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;
Procedure SRRU;
Begin
Запись_ФС(0,'Начало: SRRU');
Блок := 1;
Блоки_выполнены := False;
while not Блоки_выполнены do
Begin
case Блок of
1:Begin Ранг := 2;
ФР096:= True;
RRU;
ATRRU;
 If  РТРУУ  Then Блок := 2  Else Блок :=  3;
End;
2:Begin Ранг := 2;
HTRRU;
Блок := 3;
End;
3:Begin Ранг := 2;
Запись_ФС(0,'Конец: SRRU');
Блоки_выполнены := True;
End;
End;
End;
Блоки_выполнены := False;
End;

uses 
  Crt, GraphABC;
label F, G, H;


var
  line1, line2, line3, line4, line5, line6, lev, he, down, lr, butt, del, metr: integer;
  ch: char;
  resfil:file;

procedure sat();//настраиваем начальный экран, заставку и вход в игру, ассоциируемся с файлом рекордов
begin
  Assign (resfil, 'hgsc');
  
  SetWindowWidth(400);
  SetWindowHeight(600);
  SetPenWidth(1);
  
  SetBrushColor(clred);
  Rectangle(0, 0, 400, 600);
  setpenwidth(10);
  Setpencolor(clyellow);
  Rectangle(50, 50, 350, 250);
  Setfontcolor(clyellow);
  Setfontsize(70);
  TextOut(75, 75, 'racing');
  Setfontsize(20);
  TextOut(25, 400, 'Чтобы продолжить, нажми  ');
  TextOut(150, 430, '"Enter"');
  while (not (ord(readkey) = 13)) do 
  begin end;
end;


procedure setcar();//рисуем машину в зависимости от значения переменной lr
begin
  
  
  if (KeyPressed) then ch := readkey();
  if ((ch = 'd') or (ch = 'в') or (ch = 'D') or (ch = 'В')) then 
  begin
    if (not (GetPixel(200 + lr, 420).Equals(GetPixel(1, 1)) or GetPixel(200 + lr, 460).Equals(GetPixel(1, 1)))) then
      lr := lr + 100;
  end;
  if ((ch = 'a') or (ch = 'ф') or (ch = 'A') or (ch = 'Ф')) then   
  begin
    if (not (GetPixel(25 + lr, 420).Equals(GetPixel(1, 1)) or GetPixel(25 + lr, 460).Equals(GetPixel(1, 1)))) then
      lr := lr - 100;
  end;
  ch := '*';
  if lr < 0 then lr := 0;
  if lr > 200 then lr := 200;
  SetBrushColor(clYellow);
  Rectangle(50, 0, 350, 600);{дорога}
  SetBrushColor(clBlack);
  Rectangle(80 + lr, 415, 120 + lr, 485);{кузов машины}
  Rectangle(65 + lr, 465, 90 + lr, 495);{заднее левое колесо}
  Rectangle(110 + lr, 465, 135 + lr, 495);{заднее правое колесо}
  Rectangle(110 + lr, 410, 130 + lr, 440);{переднее правое колесо}
  Rectangle(70 + lr, 410, 90 + lr, 440);{переднее левое колесо}
end;


procedure setlevel();//создает и выводит шесть случайных препятствий
begin
  
  //первый ряд
  SetBrushColor(clred);
  Rectangle(line1, lev - 100 + he * 20, 100 + line1, lev + he * 20);
  //второй ряд
  Rectangle(line2, lev - 300 + he * 20, 100 + line2, lev - 200 + he * 20);
  //третий ряд
  Rectangle(line3, lev - 500 + he * 20, 100 + line3, lev - 400 + he * 20);
  //четвертый ряд
  Rectangle(line4, lev - 700 + he * 20, 100 + line4, lev - 600 + he * 20);
  //пятый ряд
  Rectangle(line5, lev - 900 + he * 20, 100 + line5, lev - 800 + he * 20);
  //шестой ряд
  Rectangle(line6, lev - 1100 + he * 20, 100 + line6, lev - 1000 + he * 20);
end;


function lose(): boolean;//функция, проверяющая условие проигрыша

begin
  setpixel(1, 1, clred);
  lose := (GetPixel(100 + lr, 400).Equals(GetPixel(1, 1))); 
  
end;

procedure countdown();//отсчитывает пять секунд перед началом от заезда
label k;
var
  i, j: integer;
begin
  Setfontcolor(clred);
  Setfontsize(17);
  SetBrushColor(clYellow);
  TextOut(55, 150, 'Для управления используй');
  TextOut(100, 180, 'клавиши "A" и "D"');
  Setfontsize(70);
  SetBrushColor(clblack);
  for i := 0 to 4 do 
  begin
    TextOut(175, 250, 5 - i);
    j:=0;
    for j := 0 to 500 do
    begin
      if (KeyPressed) then
        goto k;
      delay(1);
    end;
  end;
  goto k;
  k:
  SetBrushColor(clYellow);
  Setpencolor(clyellow);
  Rectangle(175, 250, 275, 380);
  Setfontsize(45);
  TextOut(55, 250, 'Поехали!!!');
  delay(1000);
  Setpencolor(clblack);
  SetPenWidth(1);
end;


function highsc(): integer;
var
hg:integer;
begin
  Reset(resfil);
  Read(resfil,hg);
  if (metr > hg) then
  begin
    Rewrite(resfil);
    Write(resfil, metr);
  end;
  Reset(resfil);
  Read(resfil,hg);
  highsc:=hg;
end;

procedure endgame();//настройка экрана в случае проигрыша

begin
  delay(1000);
  SetBrushColor(clRed);
  Rectangle(0, 0, 400, 600);
  Setfontcolor(clyellow);
  Setfontsize(35);
  TextOut(10, 110, 'ТЫ РАЗДОЛБАЛ');
  Setfontsize(50);
  TextOut(80, 180, 'ТАЧКУ');
  TextOut(60, 260, '¯\_(ツ)_/¯');
  Setfontsize(25);
  TextOut(50, 360, 'ИТОГ:');
  SetBrushColor(clblack);
  Setfontsize(30);
  TextOut(150, 360, metr);
  Setfontsize(25);
  Setfontcolor(clyellow);
  SetBrushColor(clRed);
  TextOut(50, 410, 'РЕКОРД:');
  Setfontcolor(clred);
  SetBrushColor(clblack);
  Setfontsize(30);
  TextOut(200, 410, highsc);
  Setfontsize(18);
  Setfontcolor(clyellow);
  Rectangle(50, 470, 150, 510);
  TextOut(55, 475, '"Enter"');
  SetBrushColor(clred);
  TextOut(165, 475, '- играть ещё раз');
  
  SetBrushColor(clblack);
  Rectangle(100, 515, 180, 555);
  TextOut(105, 520, '"Esc"');
  SetBrushColor(clred);
  TextOut(195, 520, '- выйти');
  butt := ord(readkey);
  while((not (butt = 27)) and (not (butt = 13))) do begin butt := ord(readkey); end;
end;


//тело программы
begin
  sat();
  goto H;
  H:
  Setpencolor(clblack);
  SetPenWidth(1);
  ClearWindow(clBlack);  {задний фон}
  setpixel(1, 1, clred);
  
  down := 0;
  lr := 100;
  randomize;
  del := 50;
  metr := 0;
  lev := 0;
  //создаём первые шесть препятствий
  line1 := 50 + 100 * random(3);
  line2 := 50 + 100 * random(3);
  line3 := 50 + 100 * random(3);
  line4 := 50 + 100 * random(3);
  line5 := 50 + 100 * random(3);
  line6 := 50 + 100 * random(3);
  
  setcar();
  countdown(); 
  
  F:
  metr := down * 3 div 5;
  if (down < 60) then
    he := down mod 60
  else
    he := down mod 30;
  
  //создаём новый уровень
  if ((he = 0) and (down >= 60)) then
  begin
    randomize;
    line1 := line4;
    line2 := line5;
    line3 := line6;
    line4 := 50 + 100 * random(3);
    line5 := 50 + 100 * random(3);
    line6 := 50 + 100 * random(3);  
    lev := 600;
    
  end;
  
  setlevel();
  //вывод пройденного расстояния
  Setfontcolor(clyellow);
  setfontsize(25);
  Textout(0, 530, 'расстояние:');
  setfontsize(45);
  Textout(185, 530, metr);
  
  
  
  
  
  if (lose()) then goto G;
  down := down + 1;
  Delay(del);
  if ((down mod 18 = 0) and (del > 10)) then del := del - 1;//ускоряем игру
  setcar();
  goto F;
  G:
  endgame();
  if (butt = 13) then goto H;
  if (butt = 27) then halt;
end.
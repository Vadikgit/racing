uses
  Crt, GraphABC,Sounds;
label F, G, H;


var
  i, lev, he, down, lr, butt, del, metr: integer;
  line:array [0..5] of integer;
  ch: char;
  resfil:file of integer;
  s,s1,s2:Sound;


procedure sat;//����������� ��������� �����, �������� � ���� � ����, ������������� � ������ ��������
begin
  Assign (resfil, 'hgsc');

  SetWindowWidth(400);
  SetWindowHeight(600);
  //MaximizeWindow;
  SetPenWidth(1);

  SetFontName('timesnewrooman');


  SetBrushColor(clred);
  Rectangle(0, 0, 400, 600);
  setpenwidth(10);
  Setpencolor(clyellow);
  Rectangle(50, 50, 350, 250);
  Setfontcolor(clyellow);
  Setfontsize(70);

  TextOut(75, 75, 'racing');
  Setfontsize(20);
  TextOut(25, 400, '����� ����������, �����  ');

  TextOut(150, 430, '"Enter"');
  while (not (ord(readkey) = 13)) do
  begin end;
end;



procedure pause;
var
e:char;

begin
  setbrushcolor(clred);
  SetPenWidth(5);
  Setpencolor(cLblack);
  Rectangle(75, 150, 325, 350);
  s.Stop;

  Setfontcolor(clyellow);
  Setfontsize(30);
  SEtfontstyle(fsBold);
  TextOut(90, 160, '����� ||');
  Setfontsize(20);
  setbrushcolor(clblack);
  TextOut(85, 250, ' "Space" ');
  TextOut(93, 300, ' "Esc" ');
  setbrushcolor(clred);
  SEtfontstyle(fsNormal);
  TextOut(215, 250, '- ������');
  TextOut(190, 300, '- �����');
  e:='*';
  while(not ( (e=' ') or (ord(e)=27) )  ) do
    begin
       e:=readkey();
    end;
  if (e=' ') then begin
  s.play;
  end
  else
  begin
    Reset(resfil);
    Close(resfil);
    CloseWindow;
    exit;
  end;
end;



procedure setcar;//������ ������ � ����������� �� �������� ���������� lr
begin


  if (KeyPressed) then ch := readkey();
  if ((ch = 'd') or (ch = '�') or (ch = 'D') or (ch = '�')or (ch = '+')) then
  begin
    if (not ( (GetPixel(200 + lr, 420)=clred) or (GetPixel(200 + lr, 460)=clred) )) then
      lr := lr + 100;
  end;
  if ((ch = 'a') or (ch = '�') or (ch = 'A') or (ch = '�') or (ch = '`') or (ch = '~')or (ch = '�')or (ch = '�')) then
  begin
    if (not (  (GetPixel(25 + lr, 420)=clred) or (GetPixel(25 + lr, 460)=clred) )) then
      lr := lr - 100;
  end;
  if (ch = ' ') then pause();
  ch := '*';
  if lr < 0 then lr := 0;
  if lr > 200 then lr := 200;
  SetBrushColor(clYellow);
  SetPenWidth(1);
  Setpencolor(clblack);
  Rectangle(50, 0, 350, 600);{������}
  SetBrushColor(clBlack);
  Rectangle(80 + lr, 415, 120 + lr, 485);{����� ������}
  Rectangle(65 + lr, 465, 90 + lr, 495);{������ ����� ������}
  Rectangle(110 + lr, 465, 135 + lr, 495);{������ ������ ������}
  Rectangle(110 + lr, 410, 130 + lr, 440);{�������� ������ ������}
  Rectangle(70 + lr, 410, 90 + lr, 440);{�������� ����� ������}
end;


procedure setlevel;//������� � ������� ����� ��������� �����������
begin

  SetBrushColor(clred);
  for i := 0 to 5 do
      Rectangle(line[i], lev - 100 -200*i + he * 20, 100 + line[i], lev - 200*i + he * 20);
end;


function lose: boolean;//�������, ����������� ������� ���������

begin
  lose := (GetPixel(100 + lr, 400)=clred);
end;

procedure countdown;//����������� ���� ������ ����� ������� ������
label k;
var
  i, j: integer;
begin
s.rewind;
s.Play;
  Setfontcolor(clred);
  Setfontsize(17);
  SetBrushColor(clYellow);
  TextOut(55, 150, '��� ���������� ���������');
  TextOut(100, 180, '������� "�" � "D"');
  Setfontsize(70);
  SetBrushColor(clblack);
  for i := 0 to 4 do
  begin
    TextOut(175, 250,inttostr(5 - i));
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
  TextOut(51, 250, '�������!!!');
  delay(1000);
  Setpencolor(clblack);
  SetPenWidth(1);
end;


function highsc: integer;
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




procedure endgame;//��������� ������ � ������ ���������

begin

  s.Stop;
  s2.rewind;
  s2.play;
  s2.stop;
  s1.rewind;
  s1.play;
  delay(500);

  SetBrushColor(clRed);
  Rectangle(0, 0, 400, 600);
  Setfontcolor(clyellow);
  Setfontsize(35);
  TextOut(10, 110, '�� ���������');
  Setfontsize(50);
  TextOut(80, 180, '�����');

  Setfontsize(25);
  TextOut(50, 360, '����:');
  SetBrushColor(clblack);
  Setfontsize(30);
  TextOut(150, 360, inttostr(metr));
  Setfontsize(25);
  Setfontcolor(clyellow);
  SetBrushColor(clRed);
  TextOut(50, 410, '������:');
  Setfontcolor(clred);
  SetBrushColor(clblack);
  Setfontsize(30);
  TextOut(200, 410, inttostr(highsc));
  Setfontsize(18);
  Setfontcolor(clyellow);
  Rectangle(50, 470, 150, 510);
  TextOut(55, 475, '"Enter"');
  SetBrushColor(clred);
  TextOut(165, 475, '- ������ ��� ���');

  SetBrushColor(clblack);
  Rectangle(100, 515, 180, 555);
  TextOut(105, 520, '"Esc"');
  SetBrushColor(clred);
  TextOut(195, 520, '- �����');
  butt := ord(readkey);
  while((not (butt = 27)) and (not (butt = 13))) do begin butt := ord(readkey); end;
  s1.stop;
end;


//���� ���������
begin


s:=Sound.Create('8bit.mp3');
s1:=Sound.Create('sliv.mp3');
s2:=Sound.Create('crac.mp3');
  sat();
  goto H;
  H:
  Setpencolor(clblack);
  SetPenWidth(1);
  ClearWindow(clBlack); {������ ���}
  down := 0;
  lr := 100;
  randomize;
  del := 50;
  metr := 0;
  lev := 0;
  //������ ������ ����� �����������
  for i := 0 to 5 do
      line[i] := 50 + 100 * random(3);

  setcar();
  countdown();

  F:
  metr := down * 3 div 5;
  if (down < 60) then
    he := down mod 60
  else
    he := down mod 30;

  //������ ����� �������
  if ((he = 0) and (down >= 60)) then
  begin
    randomize;
    for i := 0 to 2 do
        line[i] := line[i+3];

    for i:= 3 to 5 do
        line[i] := 50 + 100 * random(3);

    lev := 600;

  end;

  setlevel();
  //����� ����������� ����������
  Setfontcolor(clyellow);
  setfontsize(25);
  Textout(0, 530, '����������:');
  setfontsize(45);
  Textout(185, 530, inttostr(metr));





  if (lose()) then goto G;
  down := down + 1;
  Delay(del);
  if ((down mod 36 = 0) and (del > 10)) then del := del - 1;//�������� ����
  setcar();
  goto F;
  G:
  endgame();
  if (butt = 13) then goto H;
  if (butt = 27) then
  begin
  Close(resfil);
  CloseWindow;
  exit;

  end;
end.
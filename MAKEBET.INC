{ Objektum haszn lhat¢ mez‹i
  KeepBet     : integer;         T‚t tart s hoz szks‚ges ‚rt‚k
  ActBet      : integer;         Aktu lis licit ‚rt‚ke
  Round       : word;            Els‹ vagy m sodik k”r licit
  MaxBet      : integer;         Maxim lis licit ‚rt‚k
  Value_1     : word;            Ki‚rt‚kel‚s 0(semmi)..9(Royal Flush
}

Procedure MyPokerType.MakeBet;
var ww:integer;xx:word;k:real;
Begin
WW:=KeepBet;
Case Value_1 of
{ Semmi } 0 : if Round=1
                 then begin
                      k:=random;
                      If K>0.8 then xx:=random(MaxBet div 4) else xx:=0;
                      WW:=WW+xx;
                      end
                 else WW:=-1;
{ 1 p r } 1 : begin
              xx:=random(MaxBet div 4)+1;
              If random>0.1 then xx:=0;WW:=WW+xx;
              end;
{ 2 p r } 2 : begin
              xx:=random(MaxBet div 4)+1;
              If random>0.3 then xx:=0;WW:=WW+xx;
              end;
{ Drill } 3 : begin
              xx:=random(MaxBet div 2)+1;
              If random>0.5 then xx:=0;WW:=WW+xx;
              end;
{ Sor }   4 : begin
              xx:=random(MaxBet)+1;
              If random>0.75 then xx:=0;WW:=WW+xx;
              end;
{ Szin }  5 : begin
              xx:=random(MaxBet)+1;
              If random>0.85 then xx:=0;WW:=WW+xx;
              end;
{ Full }  6 : begin
              xx:=random(MaxBet)+MaxBet div 10;If xx>MaxBet then xx:=MaxBet;
              If random>0.85 then xx:=0;WW:=WW+xx;
              end;
{ Poker } 7 : begin
              xx:=random(MaxBet)+MaxBet div 4;If xx>MaxBet then xx:=MaxBet;
              If random>0.99 then xx:=0;WW:=WW+xx;
              end;
{ Flush } 8 : begin
              xx:=random(MaxBet)+MaxBet div 4;If xx>MaxBet then xx:=MaxBet;;
              If random>0.85 then xx:=0;WW:=WW+xx;
              end;
{ RFlush }9 : begin
              xx:=random(MaxBet)+MaxBet div 2;If xx>MaxBet then xx:=MaxBet;
              If random>0.95 then xx:=0;WW:=WW+xx;
              end;
{ - }    10 : begin
              end;
     end;
ActBet:=WW;
{ ActBet= -1        -> Kisz ll a partib¢l
  ActNet= 0         -> T‚t tart sa
  ActBet= 1..MaxBet -> T‚t emel‚se
}
End;
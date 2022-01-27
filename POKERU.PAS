Unit PokerU;

{****************************************************************************}
{***                                                                      ***}
{***                 PC P¢ker objektumszerkezet Unit V1.1a                ***}
{***                                                                      ***}
{***                        (C) TwinNet 1995-1997                         ***}
{***                        (P) Szab¢ Andr†s 1988			  ***}
{***		           1997.04.01. - 1998.06.02.                      ***}
{***                                                                      ***}
{****************************************************************************}

Interface

Uses Cards{V1.1},TWSys{V1.1a};

{****************************************************************************}
{***                          Konstansok defini†l†sa                      ***}
{****************************************************************************}

Const
     C_PokerCards=  5; { P¢ker k†rtyalapok sz†ma                             }
     C_CardColor : array [1..4]  of string[5] = ('Treff','K†r¢','Kãr','Pikk');
     C_CardValue : array [0..13] of string[6] = ('','2-es','3-as','4-es',
                                                 '5-îs','6-os','7-es','8-as',
                                                 '9-es','10-es','Bubi','D†ma'
                                                 ,'Kir†ly','µsz');
     C_Values    : array [0..10] of string[11]= ( 'Semmi','p†r','kÇt p†r',
                                                  'drill','Sor','Sz°n',
                                                  'full','p¢ker','Flush',
                                                  'Royal Flush','Pisztoly');
     WTime       : word     = 1;     { V†rakoz†s a lapok megjelen°tÇs kîzîtt }


{****************************************************************************}
{***                           T°pusok  defini†l†sa                       ***}
{****************************************************************************}

Type
    O_PokerType = object             { P¢kerlap objektum                     }
     private
      Cards       : array [1..C_PokerCards] of word; { P¢kerlapok            }
     public
      Value_1     : word;            { KiÇrtÇkelÇs 0(semmi)..9(Royal Flush   }
      Value_2     : word;            { LaperãssÇg                            }
      Value       : longint;         { Teljes laperãssÇg                     }
      ChangeCards : array [1..C_PokerCards] of boolean; { Cserelapokat jelzi }
      AChangeCards: array [1..C_PokerCards] of boolean; { Javasolt cserelapok}
      X           : array [1..C_PokerCards] of word;    { Lapok X koordin†ta }
      Y           : array [1..C_PokerCards] of word;    { Lapok Y koordin†ta }
      DX,DY       : word;            { K†rtyalap szÇlessÇg,magass†ga         }
      Visible     : array [1..C_PokerCards] of boolean; { L†that¢ a lap      }
      ChCardNum   : word;            { H†ny lapot cserÇlt                    }
      Winner      : boolean;         { Nyert ?                               }
      Act         : boolean;         { Akt°v, j†tÇkban van                   }
      PlayerType  : byte;            { 0: Computer 1:Player                  }
      MaxBet      : integer;         { Maxim†lis licit ÇrtÇk                 }
      KeepBet     : integer;         { TÇt tart†s†hoz szÅksÇges              }
      ActBet      : integer;         { Aktu†lis licit ÇrtÇke                 }
      Round       : word;            { 1. vagy 2. kîr licit                  }
      Constructor Init;              { Inicializ†l¢ elj†r†s                  }
      Destructor  Done;              { Lez†r¢ elj†r†s                        }
      Procedure   SetAllCardVisible(M:boolean); { Megjelen°tÇs be†ll°t†sa    }
      Procedure   Change;            { Lapcsere+KiÇrtÇkelÇs                  }
      Procedure   Get;               { Leoszt†s+KiÇrtÇkelÇs                  }
      Procedure   MakeBet;virtual;   { Licit                                 }
      Procedure   Show;virtual;      { Pokerlapok megjelen°tÇse              }
      Procedure   Hide(BGColor:byte);virtual; { Pokerlapok eltÅntetÇse       }
     private
      Procedure   MakeValues;        { Lapok kiÇrtÇkelÇse                    }
      end;

Var
   PlayerCard       : O_CardType;    { K†rtyalapok objektuma                 }

{****************************************************************************}
{***                           Implement†ci¢s rÇsz                        ***}
{****************************************************************************}

Implementation

{****************************************************************************}
{************************ O_PokerType objektum met¢dusai ********************}
{****************************************************************************}

Constructor O_PokerType.Init;
Begin
SetAllCardVisible(False);ChCardNum:=0;
End;

Destructor O_PokerType.Done;
Begin
End;

Procedure O_PokerType.Get;
var i:word;
Begin
For i:=1 to C_PokerCards do Cards[i]:=PlayerCard.GetNextCard;
MakeValues;
End;

Procedure O_PokerType.Change;
var i,k:word;
Begin
ChCardNum:=0;
For i:=1 to C_PokerCards do If ChangeCards[i]
    then begin Cards[i]:=PlayerCard.GetNextCard;Inc(ChCardNum);end;
MakeValues;
End;

Procedure O_PokerType.SetAllCardVisible(M:boolean);
var j:word;
Begin
for j:=1 to C_PokerCards do Visible[j]:=M;
End;

Procedure O_PokerType.Show;
var i:word;
Begin
For I:=1 to C_PokerCards do
    begin
    If Visible[i]
       then PlayerCard.Show(x[i],y[i],hi(Cards[i]),lo(Cards[i]))
       else PlayerCard.ShowBack(x[i],y[i]);
    Wait(WTime);
    end;
End;

Procedure O_PokerType.Hide(BGColor:byte);
var i:word;
Begin
For I:=1 to C_PokerCards do PlayerCard.Hide(x[i],y[i],BGColor)
End;


Procedure O_PokerType.MakeValues;
const ple:array [0..15] of byte = (0,1,1,3,1,2,3,7,1,2,2,6,3,6,7,10);
var i,j,TMPCard:word;Z:array[1..4] of byte;v:byte;
Begin
Value_1:=0;Value_2:=0;
{ RendezÇs }
For i:=1 to C_PokerCards do
    For j:=1 to C_PokerCards do
        If lo(Cards[i])<lo(Cards[j])
           then begin
                TMPCard:=Cards[i];Cards[i]:=Cards[j];Cards[j]:=TMPCard;
                end;
{ êrtÇkelÇs I. -> Value_1 ÇrtÇkÇnek meghat†roz†sa }
For i:=1 to C_PokerCards-1 do
    if lo(Cards[i])=lo(Cards[i+1]) then Z[i]:=1 else Z[i]:=0;
v:=Z[1]*8+Z[2]*4+Z[3]*2+Z[4];Value_1:=PLE[v];
If Value_1=0 then
   begin
   i:=1;while (i<5) and (hi(Cards[i])=hi(Cards[i+1])) do inc(i);
   If I=5 then Value_1:=5; { Sz°nsor }
   i:=1;while (i<5) and (lo(Cards[i])+1=lo(Cards[i+1])) do inc(i);
   If i=5
      then if Value_1=0
              then Value_1:=4 { Sor }
              else if lo(Cards[5])=13 { Royal Flush vagy Flush       }
                      then Value_1:=9 else Value_1:=8;
   end;
{ êrtÇkelÇs II. Value_2 ÇrtÇkÇnek meghat†roz†sa + CserÇk meghat†roz†sa }
for i:=1 to 5 do ChangeCards[i]:=false;
Case v of
       0 : begin
           Value_2:=0;
           Case Value_1 of
                0 : begin { Semmi }
                    ChangeCards[1]:=true;ChangeCards[2]:=true;
                    If random>0.5 then ChangeCards[3]:=true;
                    If random>0.8 then ChangeCards[4]:=true;
                    If (random>0.9) and (lo(Cards[5])<12)
                       then ChangeCards[5]:=true;
                    If lo(Cards[5])<10 {Nincs figur†s lap - 4 csere}
                       then for i:=1 to 4 do ChangeCards[i]:=true;
                    If random>0.95 { 0 csere -> Blîff }
                       then for i:=1 to 4 do ChangeCards[i]:=false;
                    end;
                else Value_2:=0; {lo(Cards[5]); { Flush esetÇn az utols¢ lap }
                end;
           end;
       1 : begin { 1 p†r esetÇn }
           Value_2:=lo(Cards[5]);
           ChangeCards[1]:=true;ChangeCards[2]:=true;ChangeCards[3]:=true;
           end;
       2 : begin { 1 p†r esetÇn }
           Value_2:=lo(Cards[4]);
           ChangeCards[1]:=true;ChangeCards[2]:=true;
           If lo(Cards[5])<12 then ChangeCards[5]:=true;
           end;
       3 : begin { Drill esetÇn }
           Value_2:=lo(Cards[5]);
           ChangeCards[1]:=true;ChangeCards[2]:=true;
           end;
       4 : begin { 1 p†r esetÇn }
           Value_2:=lo(Cards[3]);
           ChangeCards[1]:=true;ChangeCards[4]:=true;
           If lo(Cards[5])<12 then ChangeCards[5]:=true;
           end;
       5 : begin { 2 p†r esetÇn }
           Value_2:=lo(Cards[5])*256+lo(Cards[2]);
           ChangeCards[1]:=true;
           end;
       6 : begin { Drill esetÇn }
           Value_2:=lo(Cards[4]);
           ChangeCards[1]:=true;ChangeCards[5]:=true;
           end;
       7 : begin { P¢ker esetÇn }
           Value_2:=lo(Cards[5]);
           ChangeCards[1]:=true;
           end;
       8 : begin { 1 p†r esetÇn }
           Value_2:=lo(Cards[2]);
           ChangeCards[3]:=true;ChangeCards[4]:=true;
           If lo(Cards[5])<12 then ChangeCards[5]:=true;
           end;
       9 : begin { 2 p†r esetÇn }
           Value_2:=lo(Cards[5])*256+lo(Cards[2]);
           ChangeCards[3]:=true;
           end;
       10: begin { 2 p†r esetÇn }
           Value_2:=lo(Cards[4])*256+lo(Cards[2]);
           ChangeCards[5]:=true;
           end;
       11: begin { Full esetÇn }
           Value_2:=lo(Cards[5])*256+lo(Cards[1]);
           end;
       12: begin { Drill esetÇn }
           Value_2:=lo(Cards[1]);
           ChangeCards[4]:=true;ChangeCards[5]:=true;
           end;
       13: begin { Full esetÇn }
           Value_2:=lo(Cards[1])*256+lo(Cards[5]);
           end;
       14: begin { P¢ker esetÇn }
           Value_2:=lo(Cards[1]);
           ChangeCards[5]:=true;
           end;
       15: begin { Ilyen eset nincs: ît egyforma lap }
           Value_2:=$FF;
           end;
       end;
Value:=10000*longint(Value_1)+100*longint(hi(Value_2))+longint(lo(Value_2));
For i:=1 to C_PokerCards do AChangeCards[i]:=ChangeCards[i];
End;

Procedure O_PokerType.MakeBet;
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
{ 1 p†r } 1 : begin
              xx:=random(MaxBet div 4)+1;
              If random>0.1 then xx:=0;WW:=WW+xx;
              end;
{ 2 p†r } 2 : begin
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
ActBet:=WW; {-1 kisz†ll, 0:tart, 1..MaxBet: emel a tÇten }
End;

{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

BEGIN
END.
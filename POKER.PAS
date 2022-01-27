{$A+,B-,D+,E+,F+,G+,I+,L+,N-,O-,P-,Q+,R+,S+,T-,V+,X+}
{$M 32768,0,655360}
Program Poker;
{*****************************************************************************
******************************************************************************
*                          PcPoker 2.0d Verzi¢                               *
*                       1997.04.02. - 1999.01.07.                            *
*                       (P) Szab¢ Andr†s 1984-98                             *
*                       (C) TwinNet Kft. 1997-98                             *
******************************************************************************
*****************************************************************************}


Uses TWSys{V1.1a},TObject{V4.1d},TObjects{V1.1d},PokerU{V1.1b},BigChar{V1.1b};

{****************************************************************************}
{***                             T°pusok                                  ***}
{****************************************************************************}

Type
 PlayerType  = record
  PName   : string[4];          { J†tÇkos neve                               }
  V       : boolean;            { FÅggãleges/vizszintes lapkirajzol†s        }
  XX,YY   : word;               { K†rty†k pozici¢ja                          }
  DXX,DYY : word;               { K†rty†k szÇlessÇg, magass†g                }
  SDX     : word;               { K†rty†k kîzîtti szabad hely                }
  SM      : longint;            { KezdãpÇnz                                  }
  Pl      : byte;               { J†tÇkos t°pusa 0:Computer 1:Player         }
  MB      : word;               { Maxim†lis tÇt                              }
 end;

{****************************************************************************}
{***                              Konstansok                              ***}
{****************************************************************************}

Const
 VMode                 :  word    = _640x480_256;   { Vide¢m¢d k¢dja         }
 ProgramName           :  string  = ' PcPoker V2.0· (P) Szab¢ Andr†s 1998';
 Info1                 :  string  = 'e-mail:szaboand@mail.petrik.mumszki.hu';
 InfoFileName          :  string  = 'POKER.PIC';
 CardFileName          :  string  = 'CARDS.PIC';
 CardDX                :  word    = 65;
 CardDY                :  word    = 95;
 XMS_Size              :  word    = 400;         { 400K XMS mem¢ria          }
 UseXMS                :  boolean = FALSE;       { XMS mem¢ria haszn†lata    }
 ConfigNum                        = 4;           { Konfig be†ll°t†sok sz†ma  }
 MaxPlayerNum                     = 3;           { Max ellenfelek sz†ma      }
 PlayerNum             :  word    = 3;           { Ellenfelek sz†ma          }

 MDVX                  :  word    = $0003;       { Mouse X oszt†sar†ny (SHR) }
 MDVY                  :  word    = $0003;       { Mouse X oszt†sar†ny (SHR) }
 PixRat                :  word    = $0001;       { Mouse Pixel/Ratio         }
 MouseAct              :  boolean = TRUE;        { Saj†t mouse megjelen°tÇs  }

 BackgroundColor       :  byte    = $FE;         { H†ttÇrszin                }
 DBackgroundColor      :  byte    = $FC;         { SîtÇt h†ttÇrszin          }
 DDBackgroundColor     :  byte    = $00;         { SîtÇt h†ttÇrszin          }
 LBackgroundColor      :  byte    = $FA;         { Vil†gos h†ttÇrszin        }
 InfoTextColor         :  byte    = $0A;         { Info textszin             }
 DInfoTextColor        :  byte    = $03;         { SîtÇt info textszin       }

 _SystemExitButtonCode            = $0001;       { Command k¢dok             }
 _GoOnButtonCode                  = $0002;       { Command k¢dok             }
 _GiveUpButtonCode                = $0003;       { Command k¢dok             }
 _IncButtonCode                   = $0004;       { Command k¢dok             }
 _DecButtonCode                   = $0005;       { Command k¢dok             }
 _InfoButtonCode                  = $0006;       { Command k¢dok             }
 _OptionsButtonCode               = $0007;       { Command k¢dok             }
 _AdvanceButtonCode               = $0008;       { Command k¢dok             }
 _OkButtonCode                    = $0009;       { Command k¢dok             }
 _InfoOkButtonCode                = $000A;       { Command k¢dok             }

 _MaxBetCode                      = $000A;       { Max tÇt k¢d               }
 _MinBetCode                      = $000B;       { Min tÇt k¢d               }

 _SystemExitButtonString          = ' KilÇp ';   { Exit Button felirat       }
 _GoOnButtonString                = 'Mehet!';    { GoOn Button felirat       }
 _GiveUpButtonString              = 'Felad!';    { GiveUp Button felirat     }
 _InfoButtonString                = ' Info ';    { Info Button felirat       }
 _OptionsButtonString             = 'Be†ll°t';   { Help Button felirat       }
 _AdvanceButtonString             = 'Tan†cs';    { Advance Button felirat    }
 _OkButtonString                  = ' OK ';        { Ok Button felirat         }
 _SetModeCButtonString : array [1..ConfigNum] of string[6] = ('Dem¢','Idã',
                                                           'Tan†cs','Napl¢');
 _SetModeRButtonString : array [1..MaxPlayerNum] of string[9] = ('2 j†tÇkos','3 j†tÇkos',
                                                                 '4 j†tÇkos');
 ConfigCode            : array [1..ConfigNum] of word = (0,1,0,0);

 MaxTextLine                      = 50;          { Pokertext szîveg sorok    }
 Elv                   : string   = '---------------------------------';
 DemoMode              : boolean  = FALSE;       { Demo m¢d jelzãje          }
 AlwaysAdvice          : boolean  = FALSE;       { Tan†cs m¢d                }
 LogFile               : boolean  = FALSE;       { Logfile ON/OFF            }
 WTimeP                : word     = 1;           { Demo m¢d v†rakoz†s        }
 WPlayerN              : word     = 0;           { Melyik a J†tÇkos (0..max) }

 St_Player             : array [0..MaxPlayerNum] of PlayerType = (
                         (PName:'Jack';V:True;XX:7;YY:10;DXX:70;DYY:88;SDX:1;SM:100;Pl:1;MB:20),
                         (PName:'Judy';V:False;XX:295;YY:136;DXX:70;DYY:20;SDX:0;SM:100;Pl:0;MB:20),
                         (PName:'Bill';V:True;XX:7;YY:340;DXX:70;DYY:88;SDX:1;SM:100;Pl:0;MB:20),
                         (PName:'Fred';V:False;XX:5;YY:136;DXX:70;DYY:20;SDX:0;SM:100;Pl:0;MB:20) );

{$I PCONST.PAS }

{****************************************************************************}
{***                          Objektumok                                  ***}
{****************************************************************************}

Type

 MyButtonType   = object(ButtonType)
  Procedure DoButton;virtual;
  Procedure SetInit;virtual;
 end;

 TimeType       = object(TextType)
  TF           : boolean;
  Constructor  Init(IDd,XX,YY:word);
  Procedure    SetInit;virtual;
  Procedure    Draw;virtual;
  Procedure    Timer;virtual;
 end;

 MyIconType     = object(IconType)
  WHO         : word;
  Procedure   SetInit;virtual;
  Procedure   MouseLeftButtonPush;virtual;
 end;

 MyTextType     = object(TextType)
  Procedure    Draw;virtual;
 end;

 MyEditType     = object(EditType)
  Procedure    SetInit;virtual;
 end;

{******************************** MyPokerType *******************************}
  MyPokerType    = object(O_PokerType)
  Name         : string[5];                      { NÇv                       }
  Money        : real;                           { PÇnz                      }
  CardIcon     : array [1..C_PokerCards] of MyIconType; { K†rtya ikonobjektum}
  Constructor  Init(N:string;V:boolean;XX,YY,DXX,DYY,SDX:word;SM:longint;Pl:byte;MB:word);
  Procedure    GetBet;
  Procedure    MakeBet;virtual;
 end;
{****************************************************************************}

{****************************************************************************}
{***                               V†ltoz¢k                               ***}
{****************************************************************************}

Var
 ExitButton           : MyButtonType;
 GoOnButton           : MyButtonType;
 GiveUpButton         : MyButtonType;
 IncButton            : MyButtonType;
 DecButton            : MyButtonType;
 InfoButton           : MyButtonType;
 OptionsButton        : MyButtonType;
 AdvanceButton        : MyButtonType;
 OkButton             : MyButtonType;
 TimeText             : TimeType;
 PokerText            : MyTextType;
 SetModeCButton       : array [1..ConfigNum] of CButtonType;
 SetPlayerModeRButton : array [1..MaxPlayerNum] of RButtonType;
 PlayerNameEdit       : MyEditType;

 Player               : array [0..MaxPlayerNum] of MyPokerType;

 CommandCode          : word;
 TextPuffer           : array [1..MaxTextLine+1,1..34] of byte;
 ActTextLine          : word;                    { Kîvetkezã sor a textpufban}
 SumBet               : word;                    { ôsszes tÇt a partiban     }
 ActPlayerNum         : word;                    { A partiban lÇvã j†tÇkosok }
 WTime                : word;                    { V†rakoz†si idã            }


{****************************************************************************}
{***                Szîveg besz£r†sa a szîvegpufferbe                     ***}
{****************************************************************************}

Procedure AddToTextPuffer(SS:string);
var II:word;
Begin
while length(SS)<33 do SS:=SS+' ';
If ActTextLine>MaxTextLine
   then begin
        For II:=2 to ActTextLine do TextPuffer[II-1]:=TextPuffer[II];
        Dec(ActTextLine);
        end;
For II:=1 to 33 do TextPuffer[ActTextLine,II]:=Ord(SS[II]);
TextPuffer[ActTextLine,34]:=EndOfLine;
Inc(ActTextLine);TextPuffer[ActTextLine,1]:=0;
End;

Procedure InsertBetText(i:word);
var S,SS:string;
Begin
SS:='';
If Player[i].KeepBet>0
   then begin Str(Player[i].KeepBet,S);SS:=S+' $-t megadom.';end;
If Player[i].ActBet>Player[i].KeepBet
   then str(Player[i].ActBet-Player[i].KeepBet,S) else S:='';
If S<>'' then SS:=SS+'Emelek '+S+' $-t!';
If Player[i].Act=False then SS:='Feladom!';
If SS='' then SS:='Tartom!';SS:=Player[i].Name+':'+SS;
AddToTextPuffer(SS);
End;

Procedure InsertMoneyText(i:word);
var S,SS:string;
Begin
With Player[i] do
     begin
     str(Money:7:1,SS);
     If SS[length(ss)]='0' then SS:=Copy(SS,1,length(SS)-2);
     AddToTextPuffer(Name+' pÇnze: '+SS+' $');
     end;
End;

{****************************************************************************}
{***                           SumBet Draw                                 **}
{****************************************************************************}

Procedure SumBetDraw(M:word);
var EIX:word;S:String;
Begin
MouseHide;
Str(SumBet,S);EIX:=(length(S)-1)*15;
ShowBigNum(SumBet,182+EIX+10,(GetMaxY-40) div 2,0,length(S),M);
MouseShow;
End;

{****************************************************************************}
{***                      MyTextType objektum met¢dusai                   ***}
{****************************************************************************}

Procedure MyTextType.Draw;
Begin
MouseHide;
while ActTextLine>EY+CDY+1 do Inc(EY);
Inherited Draw;
MouseShow;
End;

{****************************************************************************}
{***                      MyEditType objektum met¢dusai                   ***}
{****************************************************************************}

Procedure MyEditType.SetInit;
Begin
TextColor:=8;TextBackColor:=7;KFocusTextColor:=0;KFocusTextBackColor:=7;
CursorColor:=4;
End;

{****************************************************************************}
{***                      MyIconType objektum met¢dusai                   ***}
{****************************************************************************}

Procedure MyIconType.MouseLeftButtonPush;
Begin
With Player[Who]
     do begin Visible[ID]:=Not Visible[ID];ChangeCards[ID]:=Not ChangeCards[ID];end;
Player[Who].Show;
End;

Procedure MyIconType.SetInit;
Begin
Mask:=C_TObjectMouseFocusMask+C_TObjectKeyFocusMask;
Who:=ID div 10;ID:=ID mod 10;
End;

{****************************************************************************}
{***                    MyButtonType objektum met¢dusai                   ***}
{****************************************************************************}

Procedure MyButtonType.DoButton;
Begin
CommandCode:=ID;
End;

Procedure MyButtonType.SetInit;
Begin
Case ID of
     _SystemExitButtonCode : begin
                             Group:=1;
                             end;
     _IncButtonCode        : begin
                             IX:=2;IY:=2;IDX:=16;IDY:=18;DX:=22;DY:=22;
                             IconShape:=@BM_HandUp;Mask:=C_TObjectKeyFocusMask;
                             end;
     _DecButtonCode        : begin
                             IX:=2;IY:=2;IDX:=16;IDY:=18;DX:=22;DY:=22;
                             IconShape:=@BM_HandDown;Mask:=C_TObjectKeyFocusMask;
                             end;
     _GoOnButtonCode       : begin
                             DX:=64;DY:=45;TY:=15;
                             TX:=(DX-length(BText)*8) div 2;
                             end;
     _GiveUpButtonCode     : begin
                             DX:=64;DY:=30;TY:=8;
                             TX:=(DX-length(BText)*8) div 2;
                             end;
     _AdvanceButtonCode    : begin
                             DX:=64;DY:=30;TY:=8;
                             TX:=(DX-length(BText)*8) div 2;
                             end;
     _InfoOKButtonCode     : begin
                             DX:=48;
                             TX:=(DX-length(BText)*8) div 2;
                             end;
     end;
End;

{****************************************************************************}
{***                         TimeType objektum met¢dusai                  ***}
{****************************************************************************}

Constructor TimeType.Init(IDd,XX,YY:word);
Begin
Inherited Init(IDd,XX,YY,11,2,nil);
End;

Procedure TimeType.SetInit;
Begin
Chars:=1;LineSpace:=1;DY:=CDY*(8+LineSpace);
TextColor:=7;TextBackColor:=BackgroundColor;
End;

Procedure TimeType.Timer;
Begin
Draw;
End;

Procedure TimeType.Draw;
var t:string;tt:^byte;mh:boolean;i:word;
Begin
T:='˛';For i:=1 to Trunc(MemAvail div 163840) do T:=T+'˛';
While length(T)<4 do T:=T+' ';T:=T+' '+GetTimeStr(0);
If TF then T:=T+' ' else T:=T+'.';TF:=Not(TF);
T:=T+chr(10)+GetDateStr(false)+chr(0);
TT:=@T;Inc(TT);TextPointer:=TT;mh:=false;
If (GetMouseX<X+DX+16) and (GetMouseY+16>Y) then begin mh:=true;MouseHide;end;
Inherited Draw;if MH then MouseShow;
End;

{****************************************************************************}
{********************** .PCX kÇpfile beolvas¢ rutin *************************}
{****************************************************************************}

Function Load_PCXPic(FileNev:string;X1,Y1,X2,Y2:word;Flag,ov:byte):integer;
Const MaxPuffer=16000;
TYPE
  PcxHeaderType = record
                  Pflag: byte;	{10d=0Ah= ZSoft PCX}
 	          vers : byte;	{0=v2.5,2=v2.8 w/pal,3=v2.8 wo/pal,4=PC paintbrush for W,5=v3.0}
	          code : byte;	{1=PCX run length}
  	          bpp  : byte;	{bits/pixel/plane   1,2,4,8}
	          xmin : word;	{koordin†t†k}
	          ymin : word;
	          xmax : word;
	          ymax : word;
	          hres : word;	{v°sszintes pont/inch}
	          vres : word;	{fÅggîleges pont/inch}
	          pal  : array [0..15,0..2] of byte; {ColorMap}
	          res0 : byte;	{foglalt, 5 verzi¢n†l 0}
	          plnn : byte;	{plane sz†m 1,4}
	          bpl  : word;	{Bytes/scan/plane (†ltal†ban p†ros)}
	          pinf : word;	{Palette info (1=sz°nes/fekete-fehÇr, 2=szÅrke, 9=????)}
	          hss  : word;	{v°zszintes hossz pixelben}
                  vss  : word;  {fÅggîleges hossz pixelben}
	          res1 : array [$00..$35] of byte;	{foglalt}
                  end;
      PufferType    = array [1..MaxPuffer] of byte;
VAR
  PcxHeader : PcxHeaderType;FilePuffer:^PufferType;Paletta_256 : array [0..255,0..2] of byte;
  F,Count:word;HKod:integer;i,j,ww,jj,ii:word;
Begin
if MaxAvail<MaxPuffer+2048 then begin Load_PCXPic:=-1;exit;end;{ Keves a memoria }
GetMem(FilePuffer,MaxPuffer);
F:=OpenFile(FileNev,0);HKod:=IOError;
If HKod<>0 then begin Load_PCXPic:=Hkod;exit;end; { File hiba }
ReadFile(F,PCXHeader,SizeOf(PCXHeaderType));HKod:=IOError;
If HKod<>0 then begin Load_PCXPic:=Hkod;exit;end; { File hiba }
SeekFile(F,-768,2);ReadFile(F,Paletta_256,768);Hkod:=IOError;
If HKod<>0 then begin Load_PCXPic:=Hkod;exit;end; { File hiba }
SeekFile(F,128,0);Hkod:=IOError;
If HKod<>0 then begin Load_PCXPic:=Hkod;exit;end; { File hiba }
If Flag And 1=1 { Ha Flag 0.bitje =1 akkor Paletta betoltes }
   then begin
        for i:=0 to 255 do for j:=0 to 2 do Paletta_256[i,j]:=Paletta_256[i,j] div 4;
        asm mov ax,$1012;xor bx,bx;mov cx,256;push ss;pop es;lea dx,PALETTA_256;int $10;end;
        end;
i:=0;j:=0;Hkod:=0;
with pcxheader do
     begin
     ww:=1;Count:=ReadFile(F,FilePuffer^,MaxPuffer);
     while j<Ymax
           do begin
              if FilePuffer^[ww]>191
                 then begin
                      jj:=FilePuffer^[ww]-192;inc(ww);
                      if WW>Count then begin ww:=1;Count:=ReadFile(F,FilePuffer^,maxpuffer);end;
                      for ii:=1 to jj
                          do begin
                             If (i+x1<x2) and (j+y1<y2)
                                then If Flag and 2=2
                                        then if FilePuffer^[ww]<>OV
                                                then PutPixel(i+x1,j+y1,FilePuffer^[ww])
                                                else
                                        else putpixel(i+x1,j+y1,FilePuffer^[ww]);
                             INC(i);if i>Xmax then begin i:=Xmin;inc(j);end;
                             end;
                      end
                 else begin
                      If (i+x1<x2) and (j+y1<y2)
                                then If Flag and 2=2
                                     then if FilePuffer^[ww]<>OV
                                             then PutPixel(i+x1,j+y1,FilePuffer^[ww])
                                             else
                                     else putpixel(i+x1,j+y1,FilePuffer^[ww]);
                      INC(i);if i>Xmax then begin i:=Xmin;inc(j);end;
                      end;
              inc(ww);
              if WW>Count then begin ww:=1;Count:=ReadFile(F,FilePuffer^,maxpuffer);end;
              end;
     end;
CloseFile(F);
FreeMem(FilePuffer,MaxPuffer);Load_PCXpic:=0;
End;

{****************************************************************************}
{***                               Info                                   ***}
{****************************************************************************}

Procedure InitInfoPicture;
var K:word;
Begin
K:=Load_PCXPic(InfoFileName,0,GetMaxY,640,GetMaxY+480,0,0);
SetColor(0);Line(0,2*GetMaxY-1,GetMaxX,2*GetMaxY-1);
End;

Function Info:word;
var C:CommandType;YY:word;
Begin
SetFilter(-1);AllObjectsDisable;SetFilter(0);SetPalette(0,255,Colors2);
SetVideoMem(0,GetMaxY);YY:=GetMouseY;
SetMouseArea(0,GetMaxY-27,GetMaxX-2,2*GetMaxY-5);
MouseHide;SetMousePos(GetMouseX,YY+GetMaxY-27);MouseShow;
OkButton.Init(_InfoOkButtonCode,GetMaxX-52,2*GetMaxY-25,_OkButtonString);
ClearCommandPuffer;SetMouseFocus;CommandCode:=0;
repeat If GetCommand(C)<>0 then TObjectProcess(C) until CommandCode<>0;
OkButton.Done;AllObjectsEnable;
SetPalette(0,255,Colors);SetVideoMem(0,0);YY:=GetMouseY;
SetMouseArea(0,0,GetMaxX-2,GetMaxY-2);MouseHide;
SetMousePos(GetMouseX,YY-(GetMaxY-2));MouseShow;
Info:=CommandCode;
End;

{****************************************************************************}
{***                              Options                                 ***}
{****************************************************************************}

Procedure SetOptions;
var I:word;
Begin
If ConfigCode[1]=1
   then begin DemoMode:=True;For I:=0 to PlayerNum do Player[i].PlayerType:=0;end
   else begin DemoMode:=False;Player[WPlayerN].PlayerType:=1;end;
If ConfigCode[2]=0
   then begin TimeText.Hide;TimeText.DisableDraw;SetTimer(1,0,0,0,0,0);end
   else begin TimeText.EnableDraw;TimeText.Show;SetTimer(1,18,0,0,Seg(TimeText),Ofs(TimeText));end;
If ConfigCode[3]=0 then AlwaysAdvice:=False else AlwaysAdvice:=True;
ActTextLine:=1;TextPuffer[1,1]:=0;PokerText.EY:=0;
for i:=0 to PlayerNum do InsertMoneyText(I);PokerText.Draw;
End;

Function Options:word;
var C:CommandType;I:word;
Begin
SetFilter(-1);AllObjectsDisable;SetFilter(0);
MouseHide;
BorderDraw_1a(80,120,200,200,7,8,15);BorderDraw_3(90,135,100,80,7,8,15);
MouseShow;
For I:=1 to ConfigNum do SetModeCButton[i].Init(I,205,I*20+120,_SetModeCButtonString[i],ConfigCode[i]);
For I:=1 to MaxPlayerNum do SetPlayerModeRButton[i].Init(I,96,I*20+130,_SetModeRButtonString[i],1,word(PlayerNum=I));
SetTextBackColor(BackGroundColor);ROM_8x14;SetTextOver(0);
SetColor(0);OutStringXY(96,243,'J†tÇkos neve:');
PlayerNameEdit.Init(0,205,240,5,Player[0].Name);
OkButton.Init(_OkButtonCode,156,290,_OkButtonString);
ClearCommandPuffer;SetMouseFocus;CommandCode:=0;
repeat If GetCommand(C)<>0 then TObjectProcess(C) until CommandCode<>0;
OkButton.Done;
Player[0].Name:=Copy(PlayerNameEdit.EditText,1,4);PlayerNameEdit.Done;
For I:=1 to ConfigNum do ConfigCode[i]:=SetModeCButton[i].Value;
for i:=0 to PlayerNum do with Player[i] do Hide(BackGroundColor);
PlayerNum:=SetPlayerModeRButton[1].GetValue;
For I:=1 to MaxPlayerNum do SetPlayerModeRButton[i].Done;
for I:=ConfigNum downto 1 do SetModeCButton[i].Done;
MouseHide;SetColor(BackGroundColor);Bar(80,120,285,325);MouseShow;
AllObjectsEnable;Options:=CommandCode;
End;

{****************************************************************************}
{***                               PlayerBet                              ***}
{****************************************************************************}

Procedure PlayerBet_TObjectProcess(C:CommandType);
Begin
Case C.CommandType of
     _KeyType   : Case C.KeyCode of
                       73 : If C.CommandCode=_Key_Push then CommandCode:=_IncButtonCode;
                       81 : If C.CommandCode=_Key_Push then CommandCode:=_DecButtonCode;
                       79 : If C.CommandCode=_Key_Push then CommandCode:=_MaxBetCode;
                       71 : If C.CommandCode=_Key_Push then CommandCode:=_MinBetCode;
                       else TObjectProcess(C)
                       end;
     else TObjectProcess(C);
     end;
End;

Function PlayerBet(Act:integer;Min,Max:word):integer;
var C:CommandType;
Begin
ClearCommandPuffer;SetMouseFocus;GoOnButton.SetKeyFocus;
repeat
      CommandCode:=0;ShowBigNum(Act,GetMaxX-120,26,1,2,1);
      repeat If GetCommand(C)<>0 then PlayerBet_TObjectProcess(C) until CommandCode<>0;
      Case CommandCode of
           _IncButtonCode    : If Act<Max then Inc(Act);
           _DecButtonCode    : If Act>Min then Dec(Act);
           _MaxBetCode       : Act:=Max;
           _MinBetCode       : Act:=Min;
           _GiveUpButtonCode : Act:=-1;
           _SystemExitButtonCode : Act:=-1;
           _InfoButtonCode   : begin
                               CommandCode:=Info;GoOnButton.SetKeyFocus;
                               end;
           end;
until (CommandCode=_SystemExitButtonCode) or (CommandCode=_GiveUpButtonCode) or
      (CommandCode=_GoOnButtonCode);
PlayerBet:=Act;
End;

{****************************************************************************}
{***                    MyPokerType objektum met¢dusai                    ***}
{****************************************************************************}

Constructor MyPokerType.Init(N:string;V:boolean;XX,YY,DXX,DYY,SDX:word;SM:longint;Pl:byte;MB:word);
var i:word;
Begin
DX:=DXX;DY:=DYY;KeepBet:=0;ActBet:=0;Money:=SM;PlayerType:=Pl;Name:=N;MaxBet:=MB;
For I:=1 to C_PokerCards
    do begin
       X[I]:=XX;Y[I]:=YY;
       If V then Inc(XX,DXX+SDX) else Inc(YY,DYY+SDX);
       end;
Inherited Init;
End;

Procedure MyPokerType.GetBet;
Begin
Case PlayerType of
     0 : MakeBet;
     1 : begin
         AddToTextPuffer(Name+':');PokerText.Draw;Dec(ActTextLine);
         ActBet:=PlayerBet(KeepBet,KeepBet,MaxBet); { J†tÇkos licit }
         end;
     end;
If ActBet=-1
   then begin Act:=False;ActBet:=0;Hide(backGroundColor);Dec(ActPlayerNum);end;
Money:=Money-ActBet;
End;

{$I MAKEBET.INC  MyPokerType.MakeBet met¢dus }

{****************************************************************************}
{***                           SetWinnners                                ***}
{****************************************************************************}

Function SetWinners:word;
Var j,i:word;Z:longint;WNum:word;FA:boolean;Ny:real;
Begin
WNum:=1;FA:=True;for i:=0 to PlayerNum do Player[i].Winner:=FALSE;
for i:=0 to PlayerNum do with Player[i] do
    If Act
       then begin
            If FA
               then begin Winner:=TRUE;Z:=Value;FA:=False;end
               else If Value>Z
                       then begin
                            for j:=0 to PlayerNum do Player[j].Winner:=FALSE;
                            Winner:=TRUE;Z:=Value;WNum:=1;
                            end
                       else If Value=Z then begin Winner:=TRUE;Inc(WNum);end;
            end;
SetWinners:=WNum;
End;

{****************************************************************************}
{***                               TÇtek                                  ***}
{****************************************************************************}

Function Bets(WhoFirst:word):word;
var Last,i,j:word;C:word;CC:CommandType;
Begin
I:=WhoFirst;Last:=I;CommandCode:=0;
repeat
 If Player[i].Act
    then begin
         Player[i].GetBet;
         If Player[i].Act=True { Ha nem sz†llt ki a partib¢l }
            then begin
                 SumBet:=SumBet+Player[i].ActBet;SumBetDraw(1);
                 If Player[i].ActBet>Player[i].KeepBet { Emelt a tÇten }
                    then begin
                         Last:=i;
                         for j:=0 to PlayerNum do
                         If j<>i then Player[j].KeepBet:=Player[j].KeepBet+Player[i].ActBet-Player[i].KeepBet;
                         end;
                 end;
         InsertBetText(i);PokerText.Draw;Player[i].KeepBet:=0;
         end;
 Inc(I);If I>PlayerNum then I:=0;
Until (Last=I) or (ActPlayerNum=0) or (CommandCode=_SystemExitButtonCode);
Bets:=CommandCode;
End;

{****************************************************************************}
{***                               Csere                                  ***}
{****************************************************************************}

Procedure PlayerCardsChange_TObjectProcess(C:CommandType;Who:word);
Begin
Case C.CommandType of
     _KeyType   : Case C.KeyCode of
                       2..6 : If C.CommandCode=_Key_Push
                                 then with Player[Who] do
                                           begin
                                           Visible[C.KeyCode-1]:=Not Visible[C.KeyCode-1];
                                           ChangeCards[C.KeyCode-1]:=Not ChangeCards[C.KeyCode-1];
                                           Show;
                                           end
                                 else TObjectProcess(C);
                       else TObjectProcess(C);
                       end;
     else TObjectProcess(C);
     end;
End;

Function PlayerCardsChange(Who:word):word;
Var C:CommandType;I:word;
Begin
AddToTextPuffer(Player[Who].Name+' cserÇl');PokerText.Draw;Dec(ActTextLine);
DecButton.Off;IncButton.Off;GiveUpButton.Off;WTime:=0;
With Player[Who] do for i:=1 to C_PokerCards
     do begin
        CardIcon[i].Mask:=CardIcon[i].Mask and (65535-C_TObjectMouseFocusMask);
        ChangeCards[i]:=False;
        end;
If AlwaysAdvice
   then begin
        for i:=1 to C_PokerCards do
            begin
            Player[Who].Visible[i]:=not (Player[Who].AChangeCards[i]);
            Player[Who].ChangeCards[i]:=Player[Who].AChangeCards[i];
            end;
        Player[Who].Show;
        end
   else AdvanceButton.On;
Repeat
      ClearCommandPuffer;SetMouseFocus;GoOnButton.SetKeyFocus;CommandCode:=0;
      repeat If GetCommand(C)<>0 then PlayerCardsChange_TObjectProcess(C,Who) until CommandCode<>0;
      Case CommandCode of
           _AdvanceButtonCode : begin
                                for i:=1 to C_PokerCards do
                                    begin
                                    Player[Who].Visible[i]:=not (Player[Who].AChangeCards[i]);
                                    Player[Who].ChangeCards[i]:=Player[Who].AChangeCards[i];
                                    end;
                                Player[Who].Show;
                                end;
           _InfoButtonCode    : begin
                                CommandCode:=Info;GoOnButton.SetKeyFocus;
                                end;
           end;
until (CommandCode=_SystemExitButtonCode) or (CommandCode=_GiveUpButtonCode) or
      (CommandCode=_GoOnButtonCode);
AdvanceButton.Off;DecButton.On;IncButton.On;GiveUpButton.On;
With Player[Who] do for i:=1 to C_PokerCards
     do CardIcon[i].Mask:=CardIcon[i].Mask or (C_TObjectMouseFocusMask+C_TObjectKeyFocusMask);
PlayerCardsChange:=CommandCode;Player[Who].SetAllCardVisible(True);
End;

Function CardChange(WhoFirst:word):word;
var Last,i:word;SS:string;C:word;
Begin
I:=WhoFirst;Last:=I;
repeat
 with Player[i] do
      begin
      If Act
         then begin
              If PlayerType=1
              then begin
                   C:=PlayerCardsChange(i);
                   If C=_SystemExitButtonCode then begin CardChange:=C;Exit;end;
                   end;
              Change;Show;Str(Player[i].ChCardNum,SS);
              AddToTextPuffer(Name+' cserÇl '+SS+' lapot!');PokerText.Draw;
              end;
      end;
 Inc(I);If I>PlayerNum then I:=0;
Until Last=I;
AddToTextPuffer(Elv);PokerText.Draw;
End;

{****************************************************************************}
{***                            Èj parti ?                                ***}
{****************************************************************************}

Function NewParty:word;
var C:CommandType;X,Y,I:word;
Begin
X:=182-70;Y:=(GetMaxY-40) div 2-40;
DecButton.Off;IncButton.Off;GiveUpButton.Off;ResetTimeCounter;
OptionsButton.On;
repeat
      ClearCommandPuffer;SetMouseFocus;GoOnButton.SetKeyFocus;CommandCode:=0;
      repeat
            If GetCommand(C)<>0 then TObjectProcess(C);
      until (CommandCode<>0) or ((GetTimeCounter>WTimeP*18) and DemoMode);
      Case CommandCode of
           _InfoButtonCode   : begin
                               CommandCode:=Info;GoOnButton.SetKeyFocus;
                               end;
           _OptionsButtonCode: begin
                               CommandCode:=Options;GoOnButton.SetKeyFocus;
                               SetOptions;
                               end;
           end;
until ((GetTimeCounter>WTimeP*36) and DemoMode) or (CommandCode=_SystemExitButtonCode)
      or (CommandCode=_GoOnButtonCode);
If CommandCode<>_SystemExitButtonCode
   then begin SumBetDraw(0);DecButton.On;IncButton.On;GiveUpButton.On;end;
OptionsButton.Off;NewParty:=CommandCode;
End;

{****************************************************************************}
{***                               J†tÇk                                  ***}
{****************************************************************************}

Function FirstRound(var Start:word):word;
var i,j:word;SS:string;FR:word;
Begin
{If DemoMode then PlayerNum:=Random(3)+1;}
If Start>PlayerNum then Start:=0;
WTime:=1;PlayerCard.MakeCards;DemoMode:=True;
ActTextLine:=1;TextPuffer[1,1]:=0;PokerText.EY:=0;
for i:=0 to PlayerNum do with Player[i] do
    begin
    Hide(BackGroundColor);Money:=Money-1;Round:=1;
    If PlayerType=1 then DemoMode:=False;InsertMoneyText(I);
    end;
If DemoMode then begin SetFilter(0);AllObjectsDisable;end;
AddToTextPuffer(Elv);PokerText.Draw;SumBet:=PlayerNum+1;SumBetDraw(1);
for i:=0 to PlayerNum do with Player[i]
    do begin Get;SetAllCardVisible(False);Show;Act:=True;KeepBet:=0;end;
for i:=0 to PlayerNum do with Player[i]
    do If PlayerType=1 then begin SetAllCardVisible(True);Show;end;
ActPlayerNum:=PlayerNum;
FR:=Bets(Start);
If FR<>_SystemExitButtonCode
   then begin
        ShowBigNum(0,GetMaxX-120,26,1,2,0);AddToTextPuffer(Elv);PokerText.Draw;
        end;
FirstRound:=FR;
End;

Function SecondRound(Start:word):word;
var i:word;SR:word;
Begin
for i:=0 to PlayerNum do Player[i].Round:=2;
SR:=Bets(Start);
If SR<>_SystemExitButtonCode
   then begin
        ShowBigNum(0,GetMaxX-120,26,1,3,0);AddToTextPuffer(Elv);PokerText.Draw;
        end;
SecondRound:=SR;
End;

Procedure Result;
Var SS:string;WNum:word;I:word;Ny:real;
Begin
WNum:=SetWinners;WTime:=1;
If ActPlayerNum>0
   then begin
        For I:=0 To PlayerNum do with Player[i]
            do If Act
               then begin
                    SetAllCardVisible(True);Show;
                    AddToTextPuffer(Name+':'+C_CardValue[hi(Value_2)]+' '+
                                    C_CardValue[lo(Value_2)]+' '+C_Values[Value_1]);
                    PokerText.Draw;
                    end;
        AddToTextPuffer(Elv);
        end;
SumBetDraw(0);Ny:=SumBet/WNum;str(NY:5:0,SS);
while SS[1]=' ' do SS:=Copy(SS,2,length(SS));
for i:=0 to PlayerNum do with Player[i]
    do If Winner=True
          then begin
               AddToTextPuffer(Name+' gyîzîtt Çs nyert '+SS+' $-t!');
               Money:=Money+Ny;
               end;
AddToTextPuffer(Elv);for i:=0 to PlayerNum do InsertMoneyText(I);
PokerText.Draw;
If DemoMode then begin SetFilter(0);AllObjectsEnable;end;
End;

{****************************************************************************}
{***                KÇpernyã/EgÇr inicializ†l†s/lez†r†s                   ***}
{****************************************************************************}

Procedure InitColors;
Begin
SetPalette(0,255,Colors);
End;

Function Init_Video:byte;
Begin
If SetGraphMode(VMode)<>0 then begin Init_Video:=1;Exit;end;
InitColors;ClearScreen(BackGroundColor);
SetColor(BackGroundColor);Bar(0,GetMaxY-26,GetMaxX-1,GetMaxY-1);
SetColor(DBackGroundColor);Line(0,GetMaxY-27,GetMaxX-1,GetMaxY-27);
SetColor(DDBackGroundColor);Line(0,GetMaxY-28,GetMaxX-1,GetMaxY-28);
BorderDraw_2b(2,GetMaxY-25,90,18,BackGroundColor,DBackGroundColor,LBackGroundColor);
BorderDraw_2a(368,114,GetMaxX-5-370,GetMaxY-28-120,0,DBackGroundColor,LBackGroundColor);
SetColor(DBackGroundColor);Line(365,0,365,GetMaxY-29);
SetColor(DDBackGroundColor);Line(366,0,366,GetMaxY-29);
SetColor(DBackGroundColor);Line(367,110,GetMaxX-1,110);
SetColor(DDBackGroundColor);Line(367,111,GetMaxX-1,111);
SetTextBackColor(BackGroundColor);ROM_8x16;SetTextOver(0);
SetColor(DDBackGroundColor);OutStringXY(386+1,28-1,'Fizet:           $');
SetColor(InfoTextColor);OutStringXY(386,28,'Fizet:           $');
SetTextBackColor(BackGroundColor);ROM_8x8;SetTextOver(0);
SetColor(DDBackGroundColor);OutStringXY(119,GetMaxY-21+1,ProgramName);
OutStringXY(119,GetMaxY-11+1,Info1);
SetColor(DInfoTextColor);OutStringXY(118,GetMaxY-21,ProgramName);
OutStringXY(118,GetMaxY-11,Info1);
Init_Video:=0;
End;

Function Init_Mouse:byte;
Begin
If MouseInit(MouseAct,PixRat,MDVX,MDVY)=0
   then Init_Mouse:=1
   else begin Init_Mouse:=0;MouseShow;end;
End;

Procedure VideoDone;
Begin
Asm mov  ax,0003h;int 10h End;
WriteLn(ProgramName);
End;

{****************************************************************************}
{***                  Objektumok inicializ†l†sa/lez†r†sa                  ***}
{****************************************************************************}

Procedure ObjectInit;
var i,j:word;Pl:byte;
Begin
For i:=0 to PlayerNum
 do with ST_Player[i]
  do begin
     Player[i].Init(PName,V,XX,YY,DXX,DYY,SDX,SM,Pl,MB);
     If Player[i].PlayerType=1
        then For j:=C_PokerCards downto 1
             do Player[i].CardIcon[j].Init(I*10+J,Player[i].X[j]-1,Player[i].Y[j]-1,
                                           PlayerCard.CardDX+1,PlayerCard.CardDY+1,nil);
     end;
GoOnButton.Init(_GoOnButtonCode,GetMaxX-70,15,_GoOnButtonString);
GiveUpButton.Init(_GiveUpButtonCode,GetMaxX-70,65,_GiveUpButtonString);
AdvanceButton.Init(_AdvanceButtonCode,GetMaxX-142,65,_AdvanceButtonString);AdvanceButton.Off;
OptionsButton.Init(_OptionsButtonCode,GetMaxX-192,GetmaxY-24,_OptionsButtonString);
InfoButton.Init(_InfoButtonCode,GetMaxX-125,GetmaxY-24,_InfoButtonString);
ExitButton.Init(_SystemExitButtonCode,GetMaxX-66,GetMaxY-24,_SystemExitButtonString);
IncButton.Init(_IncButtonCode,GetMaxX-100,15,'');
DecButton.Init(_DecButtonCode,GetMaxX-100,38,'');
PokerText.Init(0,372,120,33,23,@TextPuffer);TextPuffer[1,1]:=EndOfText;
TimeText.Init(0,6,GetMaxY-21);
SetTimer(1,18,0,0,Seg(TimeText),Ofs(TimeText));
End;

Procedure ObjectDone;
var i,j:word;
Begin
SetTimer(1,0,0,0,0,0);TimeText.Done;
PokerText.Done;DecButton.Done;IncButton.Done;
GoOnButton.Done;GiveUpButton.Done;AdvanceButton.Done;
OptionsButton.Done;InfoButton.Done;ExitButton.Done;
for i:=0 to PlayerNum
    do with Player[i]
       do begin
          If PlayerType=1 then for J:=1 to C_PokerCards do CardIcon[j].Done;
          Done;
          end;
End;

{****************************************************************************}
{***                 K†rtyalapok inicializ†l†sa/lez†r†s                   ***}
{****************************************************************************}

Function CardsInit:integer;
Begin
PlayerCard.Init(CardFileName,XMS_Size,CardDX,CardDY,UseXMS);
CardsInit:=PlayerCard.Error;
End;

Function CardsDone:word;
var OK:integer;
Begin
PlayerCard.Done(OK);CardsDone:=Ok;
End;

{****************************************************************************}
{***                   Inicializ†l†s/lez†r†sok                            ***}
{****************************************************************************}

Procedure Init;
var Z:integer;
Begin
If Lo(WindowsPresent)<>0 then UseXMS:=FALSE;
Z:=CardsInit;
If Z>0 then begin WriteLn('Nem sikerÅlt a k†rtyaf†jl inicializ†l†sa! Hibak¢d:',Z);Halt;end;
If Z<0 then begin WriteLn('Nem sikerÅlt az XMS kezelã inicializ†l†sa! Hibak¢d:',Z);Halt;end;
If Init_Video<>0 then begin WriteLn('Nem sikerÅlt a videom¢d inicializ†l†sa!');Halt;end;
Init_Mouse;ObjectInit;InitInfoPicture;
End;

Procedure Done;
Begin
ObjectDone;VideoDone;CardsDone;
End;

{****************************************************************************}
{***                               Fãprogram                              ***}
{****************************************************************************}

Procedure Main;
var C:CommandType;Start,I:word;
Begin
ActTextLine:=1;TextPuffer[1,1]:=0;PokerText.EY:=0;
for i:=0 to PlayerNum do InsertMoneyText(I);PokerText.Draw;
ClearCommandPuffer;Start:=0;I:=0;
repeat
      Case I of
           0 : CommandCode:=NewParty;
           1 : CommandCode:=FirstRound(Start);
           2 : If ActPlayerNum>0 then CommandCode:=CardChange(Start);
           3 : If ActPlayerNum>0 then CommandCode:=SecondRound(Start);
           4 : Result;
           5 : Inc(Start);
           end;
      Inc(I);If I>5 then I:=0;
until CommandCode=_SystemExitButtonCode;
End;


{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

BEGIN
Init;
TProcOn;
Main;
TProcOff;
Done;
END.
Unit Cards;
{****************************************************************************}
{***                                                                      ***}
{***                          Cards Object V1.1a                          ***}
{***                        (C) TwinNet 1995-1998                         ***}
{***                     (P) Szab¢ Andr s 1998.05.22.                     ***}
{***                                                                      ***}
{****************************************************************************}

Interface

Uses TWSys {V1.1a};

{****************************************************************************}
{***                           T¡pusok  defini l sa                       ***}
{****************************************************************************}

Type
    O_CardType     = object
     MaxCard           : word;         { K rtyalapok sz ma                   }
     Card              : array [1..52] of word; { K rtyalapok k¢dolva        }
     CardPointer       : byte;       { K”vetkez‹ k rtya mutat¢ja             }
     CardDX            : word;       { K rtyalap sz‚less‚ge                  }
     CardDY            : word;       { K rtyalap magass ga                   }
     CardsFileName     : string[64]; { CardsFile n‚v                         }
     CardFile          : word;       { CardFile filekezel‹                   }
     CardPicXMSHandle  : word;       { K rtyalapok XMS kezel‹                }
     CardPuffer        : pointer;    { K rtyalap megjelen¡t‹ puffer          }
     CardPufferSize    : word;       { K rtyalap megjelen¡t‹ puffer m‚rete   }
     UseXMS            : boolean;    { XMS haszn lata                        }
     Error             : integer;    { Hiba                                  }
     Constructor Init(CFN:string;Size,CDX,CDY:word;SXMS:boolean);{Inicializ l}
     Procedure   Show(X,Y:word;Color,Value:byte);virtual; { K rtyalap rajzol }
     Procedure   ShowBack(X,Y:word);virtual; { K rtya h tlap rajzol          }
     Procedure   Hide(X,Y:word;C:byte);virtual; { K rtyalap t”r”l            }
     Destructor  Done(var OK:integer);virtual;  { Lez r s                    }
     Procedure   MakeCards;          { Kever‚s                               }
     Function    GetNextCard:word;   { K”vetkez‹ lap lek‚r‚se                }
     end;

{****************************************************************************}
{***                           Implement ci¢s r‚sz                        ***}
{****************************************************************************}

Implementation

{****************************************************************************}
{***************************** Seg‚delj r sok *******************************}
{****************************************************************************}

Function _LoadFileXMS(Filenev:string;Handle,PufferMeret:word):word;
var F:word;NumRead:word;Meret:longint;Puffer:pointer;i,j:word;
begin
If MaxAvail<PufferMeret then begin _LoadFileXMS:=0;Exit;end;
F:=OpenFile(FileNev,0);If IOError<>0 then begin _LoadFileXMS:=0;Exit;end;
GetMem(Puffer,PufferMeret);i:=0;j:=0;
repeat
      NumRead:=ReadFile(F,Puffer^,PufferMeret);
      if MoveXMS(PufferMeret,0,Ofs(Puffer^),Seg(Puffer^),Handle,j,i)<>0
         then begin
              CloseFile(F);FreeMem(Puffer,Puffermeret);
              FreeXMS(Handle);_LoadFileXMS:=0;Exit;
              end;
      if j=0 then j:=PufferMeret else begin inc(i);j:=0;end;
until NumRead<>PufferMeret;
CloseFile(F);Freemem(Puffer,PufferMeret);
_LoadFileXMS:=Handle;
end;

Function _LoadCardsPicXMS(Size:word;_CardFileName:string;var _CardPicXMSHandle:word):word;
Begin
If GetXMS(Size,_CardPicXMSHandle)<>0 then begin _LoadCardsPicXMS:=1;Exit;end;
If _LoadFileXMS(_CardFileName,_CardPicXMSHandle,32768)=0
   then _LoadCardsPicXMS:=2
   else _LoadCardsPicXMS:=0;
End;

Function _FreePicCardsXMS(_CardPicXMSHandle:word):word;
Begin
_FreePicCardsXMS:=FreeXMS(_CardPicXMSHandle);
End;

{****************************************************************************}
{******************************* ShowCards **********************************}
{****************************************************************************}

Function _ShowCardFromFile(_CardFile:word;CFP:pointer;CFPS:word;Card:byte;X,Y,CardDX,CardDY:word):integer;
var ww:longint;i,j,k:word;
Begin
If (Card=0) or (Card>53) then exit;
SeekFile(_CardFile,0,0);if IOError<>0 then begin _ShowCardFromFile:=IOError;Exit;end;
ww:=longint(Card-1)*(longint(CardDX)+1)*(longint(CardDY)+1);
SeekFIle(_CardFile,ww,0);if IOError<>0 then begin _ShowCardFromFile:=IOError;Exit;end;
ReadFile(_CardFile,CFP^,CFPS);
if IOError<>0 then begin _ShowCardFromFile:=IOError;Exit;end;
MouseHide;CopyFromMem(X,Y,CardDX,CardDY,CardDX+1,CFP^);MouseShow;
_ShowCardFromFile:=0;
End;

Function _ShowCardFromXMS(_CardPicXMSHandle:word;CFP:pointer;CFPS:word;Card:byte;X,Y,CardDX,CardDY:word):word;
var ww:longint;ii,jj,i,j,k:word;
Begin
If (Card=0) or (Card>53) then exit;
ww:=longint(Card-1)*(longint(CardDX)+1)*(longint(CardDY)+1);
ii:=WW div 65536;jj:=WW mod 65536;
If MoveXMS(CFPS,_CardPicXMSHandle,jj,ii,0,Ofs(CFP^),Seg(CFP^))<>0
   then begin _ShowCardFromXMS:=1;Exit;end;
MouseHide;CopyFromMem(X,Y,CardDX,CardDY,CardDX+1,CFP^);MouseShow;
_ShowCardFromXMS:=0;
End;

{****************************************************************************}
{************************* O_CardType objektum met¢dusai ********************}
{****************************************************************************}

Procedure O_CardType.MakeCards;
var k,i,j,TMP:word;v:byte;
Begin
For i:=1 to MaxCard do
    begin V:=I mod 13;If V=0 then V:=13;Card[i]:=256*((I-1) div 13+1)+V;end;
CardPointer:=1;k:=1;
repeat
 i:=random(52)+1;j:=random(52)+1;
 If j<>i then begin TMP:=Card[i];Card[i]:=Card[j];Card[j]:=TMP;end;
 k:=k+1;
until K>500;
End;

Function O_CardType.GetNextCard:word;
Begin
If CardPointer>MaxCard
   then GetNextCard:=0
   else begin GetNextCard:=Card[CardPointer];Inc(CardPointer);end;
End;

Procedure O_CardType.Show(X,Y:word;Color,Value:byte);
Begin
Error:=0;
If UseXMS
   then Error:=_ShowCardFromXMS(CardPicXMSHandle,CardPuffer,CardPufferSize,(Color-1)*13+Value,X,Y,CardDX,CardDY)
   else Error:=_ShowCardFromFile(CardFile,CardPuffer,CardPufferSize,(Color-1)*13+Value,X,Y,CardDX,CardDY);
End;

Procedure O_CardType.ShowBack(X,Y:word);
Begin
Error:=0;
If UseXMS
   then Error:=_ShowCardFromXMS(CardPicXMSHandle,CardPuffer,CardPufferSize,53,X,Y,CardDX,CardDY)
   else Error:=_ShowCardFromFile(CardFile,CardPuffer,CardPufferSize,53,X,Y,CardDX,CardDY);
End;

Procedure O_CardType.Hide(X,Y:word;C:byte);
Begin
Error:=0;
MouseHide;SetColor(C);Bar(X,Y,X+CardDX,Y+CardDY);MouseShow;
End;

Constructor O_CardType.Init(CFN:string;Size,CDX,CDY:word;SXMS:boolean);
Begin
CardDX:=CDX;CardDY:=CDY;MaxCard:=52;CardPufferSize:=(CardDX+1)*(CardDY+1);
If MaxAvail<CardPufferSize then begin Error:=32767;Exit;end;
GetMem(CardPuffer,CardPufferSize);
CardFile:=OpenFile(CFN,0);Error:=IOError;
UseXMS:=SXMS;If (Error<>0) or (not UseXMS) then exit;
CloseFile(CardFile);Error:=IOError;If Error<>0 then exit;
Error:=-_LoadCardsPicXMS(Size,CFN,CardPicXMSHandle);
End;

Destructor O_CardType.Done(var OK:integer);
Begin
FreeMem(CardPuffer,CardPufferSize);
If UseXMS
   then OK:=_FreePicCardsXMS(CardPicXMSHandle)
   else begin CloseFile(CardFile);OK:=IOError;end;
End;

{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

BEGIN
Randomize;
END.
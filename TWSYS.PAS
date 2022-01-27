Unit TWSys;
{****************************************************************************}
{***                                                                      ***}
{***                     Turbo Pascal TWSystem Unit                       ***}
{***                            1.1a Verzi¢                               ***}
{***                                                                      ***}
{***               (C) TwinNet 1998  (P) Szab¢ Andr†s 1997/98             ***}
{***                                                                      ***}
{***                      1997.02.16.  - 1998.05.22.                      ***}
{***                                                                      ***}
{*** - TG_16.ASM    1.8 verzi¢ (C) TwinNet (P) Szab¢ Andr†s 1996 Budapest ***}
{*** - TG_256.ASM   1.8 verzi¢ (C) TwinNet (P) Szab¢ Andr†s 1996 Budapest ***}
{*** - TPROC.ASM    1.7 verzi¢ (C) TwinNet (P) Szab¢ Andr†s 1996 Budapest ***}
{***                                                                      ***}
{****************************************************************************}

Interface


Type
    T_SVGAInfo = record
                 VESAFlag     : array [0..3] of byte;  { VESA azonosito   }
                 Version      : word;                  { VESA verzio szam }
                 OEMName      : array [0..1] of word;  { OEM nev ( gyarto azonositojara ) mutato pointer }
                 Flag         : array [0..3] of byte;  { Kepessegek       }
                 ModesPointer : array [0..1] of word;  { VESA es OEM modok listajanak mutatoja }
                 VideoMem     : word;                  { Video memoria merete 64 Kbyte ban     }
                 Reserved     : array [0..235] of byte;
                  end;

    T_VESAInfo = record
          { 00 } VESAMode       : word;  { Mod jellemzok
                                           15..5: Nem hasznalt 4:Grafikus mod
                                           3:szines mod 2:karakter kivitel beepitve
                                           1:kiegeszito informacio van 0:a mod beallithato        }
          { 02 } Window_A       : byte;  { A ablak jellemzoi 2:irhato 1:olvashato 0:megvalositott }
          { 03 } Window_B       : byte;  { B ablak jellemzoi 2:irhato 1:olvashato 0:megvalositott }
          { 04 } Window_MoveMem : word;  { Legkisebb lepes az ablak mozgathatosagara Kbyte-ban    }
          { 06 } Window_Mem     : word;  { Ablak merete Kbyteban                                  }
          { 08 } Window_A_Seg   : word;  { A ablak szegmenscime                                   }
          { 0A } Window_B_Seg   : word;  { B ablak szegmenscime                                   }
          { 0C } WindowPointer  : array [0..1] of word; { Ablakkezelo fuggveny memcime            }
          { 10 } LogicalSize    : word;  { Sorok merete byteban                                   }
          { 12 } Size_X         : word;  { Szelesseg - Vizszintes felbontas }
          { 14 } Size_Y         : word;  { Magassag - Fuggoleges felbontas }
          { 16 } CharSize_X     : byte;  { Karakterek szelessege pixelben  }
          { 17 } CharSize_Y     : byte;  { Karakterek magassaga  pixelben  }
          { 18 } BitPlane       : byte;  { Memoria lapok ( Bitsikok ) szama   }
          { 19 } PixelBit       : byte;  { Egy kepponthoz tartozo bitek szama }
          { 1A } Page           : byte;  { Memorialapok szama                 }
          { 1B } MemModell      : byte;  { Memoria szervezese
                                           0:szoveges 1:CGA 2:Herc
                                           3:4 bitsikos 4:csomagolt pixeles
                                           5:sequ 256(nem lancolt 4)
                                           6: HiColor (24bit) 08..0f VESA
                                           19-ff OEM                          }
          { 1C } PageMem         : byte; { A memorialap merete Kbyte-ban }
          { 1D } PageNum         : byte; { A megjelenito lapok szama     }
          { 1E } Reserved        : byte; { 0 }
          { 1F } Protected       : array [0..239] of byte;
                 end;

    T_VideoMode = record
                  ModeNum        : word; { Vide¢m¢d k¢dja                    }
                  ModeType       : byte; { Vide¢m¢d t°pusa
                                           0:VGA 1:VESA 2:Nem szabv†ny VGA   }
                  MemType        : byte; { Mem¢ria szervezÇs
                                           0:Szîveges    1:4 BitPlane
                                           2:Byte/pixel  3:32K
                                           4:64K         5:HiColor (24bit)   }
                  MaxX           : word; { Max X koordin†ta                  }
                  MaxY           : word; { Max Y koordin†ta                  }
                  MaxC           : longint; { Max szinek sz†ma               }
                  LSize          : word; { Logikai szÇlessÇg byte-ban        }
                  BitPixel       : word; { Egy pixelt le°r¢ bitek sz†ma      }
                  end;

    TGraph_CharsType    = record
                 CharY      : word; { Karakter magass†ga pixelben            }
                 CharX      : word; { Karakter szÇlesssÇge pixelben          }
                 CharXbyte  : word; { Karakter szÇlessÇge byteban            }
                 CharByte   : word; { Karaktert le°r¢ byteok sz†ma           }
                 CharGenSeg : word; { Karakter gener†tor szegmensc°me        }
                 CharGenOfs : word; { Karakter gener†tor ofsetc°me           }
                 end;

     CommandType        = record
                 CommandType   : word; { Command t°pus
                                         0: Nincs
                                         1: EgÇr
                                         2: BillentyÅ
                                         3: Idîz°tã                         }
                 CommandCode   : word; { Command k¢dja                      }
                 Mouse_X       : word; { EgÇr X koodrdin†ta                 }
                 Mouse_Y       : word; { EgÇr Y koodrdin†ta                 }
                 Mouse_B       : word; { EgÇr gomb                          }
                 Parameter1    : word; { ParamÇter 1                        }
                 Parameter2    : word; { ParamÇter 2                        }
                 KeyCode       : word; { Billenty˚ k¢d                      }
                 KeyTable      : array[0..15] of byte;{BillentyÅzet t†bl†zat}
                 end;


Const
   _320x200_16            = $0001;
   _320x240_16            = $0002;
   _320x350_16            = $0003;
   _320x400_16            = $0004;
   _320x480_16            = $0005;
   _640x200_16            = $0006;
   _640x240_16            = $0007;
   _640x350_16            = $0008;
   _640x400_16            = $0009;
   _640x480_16            = $000A;
   _720x400_16            = $000B;
   _720x480_16            = $000C;
   _800x600_16            = $000D;
   _1024x768_16           = $000E;
   _1280x1024_16          = $000F;
   _320x200_256           = $0010;
   _640x400_256           = $0011;
   _640x480_256           = $0012;
   _800x600_256           = $0013;
   _1024x768_256          = $0014;
   _1280x1024_256         = $0015;

   _MouseType             = $0001;
   _KeyType               = $0002;
   _TimerType             = $0003;

   _Key_Push              = $0001;
   _Key_Pop               = $0002;

   _Mouse_Move            = 3;
   _MouseLeftButton_Push  = 8;
   _MouseLeftButton_Pop   = 16;
   _MouseMiddleButton_Push= 128;
   _MouseMiddleButton_Pop = 256;
   _MouseRightButton_Push = 32;
   _MouseRightButton_Pop  = 64;

   MouseDivX              : byte        = $0000; { Mouse X eltol†s (SHR)     }
   MouseDivY              : byte        = $0000; { Mouse Y eltol†s (SHR)     }
   OldMouseX              : word        = $0000;
   OldMouseY              : word        = $0000;
   NoMouse                : word        = $0001; { 0/1: Mouse l†tszik/nem    }

   TWSysCopyright                       = '(C) TwinNet Ltd. 1997,98';

Var
   V_SVGAInfo             : T_SVGAInfo;   { SVGA info                        }
   V_VESAInfo             : T_VESAInfo;   { VESA info                        }
   V_VESAGran             : word;         { VESA lapoz†s                     }
   V_VESAPresent          : boolean;      { VESA meghajt¢ jelenlÇte          }
   V_ActMode              : T_VideoMode;  { Aktu†lis videom¢d                }
   IOError                : word;         { File hibajelzã                   }

{****************************************************************************}
{***             Grafikus video m¢d be†ll°t†sa/lekÇrdezÇse                ***}
{****************************************************************************}

Function  SetGraphMode(Mode:word):word;
Procedure SetVideoMem(XX,YY:word);

Function  GetMode:word;
Function  GetMaxX:word;
Function  GetMaxY:word;
Function  GetMaxColor:longint;

{****************************************************************************}
{***                     Grafikus video m¢d elj†r†sai                     ***}
{****************************************************************************}

Procedure ClearScreen(Color:byte);
Procedure PutPixel(X,Y:word;C:byte);
Function  GetPixel(X,Y:word):byte;
Procedure Line(X1,Y1,X2,Y2:word);
Procedure Rectangle(X1,Y1,X2,Y2:word);
Procedure Bar(X1,Y1,X2,Y2:word);
Procedure CopyBlock(X1,Y1,X2,Y2,DXx,DYy:word);
Procedure CopyFromMem(X1,Y1,DXx,DYy,MDx:word;var Dst);
Procedure CopyToMem(X1,Y1,DXx,DYy,MDx:word;var Src);
Function  GetActPage:byte;
Procedure SetActPage(PG:word);

{****************************************************************************}
{***                        Sz°nkezelã elj†r†sok                          ***}
{****************************************************************************}

Procedure SetColor(Color:byte);
Procedure SetTextBackColor(Color:byte);
Procedure SetTextOver(Over:byte);
Procedure SetBorder(C:byte);
Procedure SetRGBreg(RegNum,Red,Green,Blue:byte);
Procedure GetRGBreg(RegNum:byte; var RGB );
Procedure SetPalette(e,f:word;var t);
Procedure GetPalette(e,f:word;var t);

{****************************************************************************}
{***       Szîveg ki°r¢ / Karakter be†ll°t¢/lekÇrdezã  elj†r†sokok        ***}
{****************************************************************************}

Procedure OutTextXY(X,Y:word;var S);
Procedure OutStringXY(X,Y:word;S:string);
Procedure ROM_8x8;
Procedure ROM_8x14;
Procedure ROM_8x16;
Function  GetCharX:word;
Function  GetCharY:word;
Procedure GetChars(var TGCh:TGraph_CharsType);
Procedure SetChars(var TGCh:TGraph_CharsType);

{****************************************************************************}
{***                   Speci†lis keretrajzol¢ elj†r†sok                   ***}
{****************************************************************************}

Procedure BorderDraw_1a(x1,y1,dx,dy:word;col,sot,vil:byte);
Procedure BorderDraw_1b(x1,y1,dx,dy:word;col,sot,vil:byte);
Procedure BorderDraw_2a(x1,y1,dx,dy:word;col,sot,vil:byte);
Procedure BorderDraw_2b(x1,y1,dx,dy:word;col,sot,vil:byte);
Procedure BorderDraw_3(x1,y1,dx,dy:word;col,sot,vil:byte);

{****************************************************************************}
{***                   KÇpernyã be/kikapcsol¢ elj†r†sok                   ***}
{****************************************************************************}

Procedure PictureOff;
Procedure PictureOn;

{****************************************************************************}
{***                           EgÇrkezelÇs                                ***}
{****************************************************************************}

Function  MouseInit(Ma:boolean;PR:word;MDVX,MDVY:byte):word;
Procedure MouseShow;
Procedure MouseHide;
Function  GetMouseX:word;
Function  GetMouseY:word;
Function  GetMouseButton:byte;
Procedure SetMousePos(X,Y:word);
Procedure SetMouseArea(X1,Y1,X2,Y2:word);
Procedure SetMousePointer(Ddx,Ddy:integer; var Src);
Procedure SetNoMouseArea(X1,Y1,X2,Y2:word);
Procedure SetMouseResolution(Rx,Ry:word);
Procedure SetMouseFunction(Mask:word;Proc:pointer);
Procedure SetMouseShape(dDx,dDy:integer;var Src);
Function  GetMouseAct:boolean;


{****************************************************************************}
{***                     File kezelã elj†r†sok                            ***}
{****************************************************************************}

Function  OpenFile(FNev:string;OpenMode:byte):word;      { File megnyitas    }
Function  ReadFile(FHandle:word;var D;Size:word):word;   { File-bol olvasas  }
Function  WriteFile(FHandle:word;var D;Size:word):word;  { File-ba iras      }
Procedure SeekFile(FHandle:word;Pos:longint;From:byte);  { File pozicionalas }
Procedure CloseFile(FHandle:word);                       { File lezaras      }

{****************************************************************************}
{***                        XMS kezelã elj†r†sok                          ***}
{****************************************************************************}

Function  InitXMS:boolean;
Function  GetXMS(Meret:word;var Handle:word):byte;
Function  FreeXMS(Handle:word):byte;
Function  MoveXMS(Meret:longint;st,soff,sg,dt,doff,dg:word):byte;
Function  MaxXMSMem:word;
Function  MaxXMSMemBlock:word;
Function  LoadFileToXMS(Filenev:string;Handle,PufferMeret:word):word;

{****************************************************************************}
{***                        EgyÇb ej†r†sok                                ***}
{****************************************************************************}

Procedure GetTime(var Ora,Perc,Mp,Szmp:word); { Rendszerindo lekerdezes     }
Procedure GetDate(var Ev,Ho,Nap,NapHet:word); { Rendszerdatun lekerdezes    }
Function  GetTimeStr(l:byte):string;          { Rendszeridã string          }
Function  GetDateStr(l:boolean):string;       { Rendszerd†tum string        }
Function  WindowsPresent:word;                { Windows ellenãr             }
Procedure Wait(WTime:word);                   { V†rakoz†s                   }
Function  GetTimeCounter:word;                { Idãsz†ml†l¢ null†z†sa       }
Procedure ResetTimeCounter;                   { Idãsz†ml†l¢ lekÇrdezÇse     }

{****************************************************************************}
{****************************************************************************}
{***                        TProc elj†r†sok                               ***}
{****************************************************************************}
{****************************************************************************}

Procedure TProcON;
Procedure TProcOff;
Function  GetCommand(var _C:CommandType):word;
Function  PutCommand(CommandType,CommandCode,Prior,P1,P2:word):word;
Procedure SetTimer(TimeNum,Time,Command,Prior,P1,P2:word);
Procedure ClearCommandPuffer;
Procedure TProcInfo;
Procedure SetTProcFlag(Flg:word);
Procedure SetTimerNum(cnt:word);
Procedure SetMouseEvent(SSeg,OOfs:word);

{****************************************************************************}
{****************************************************************************}
{***                     Speaker kezelã elj†r†sok                         ***}
{****************************************************************************}
{****************************************************************************}

Procedure SpeakerOn;
Procedure SpeakerOff;
Procedure SetSpeakerFreq(Hz:word);

{****************************************************************************}
{****************************************************************************}
{***                     CMOS kezelã elj†r†sok                            ***}
{****************************************************************************}
{****************************************************************************}

Function  CMOSread(Adr:byte):byte; { Egy CMOS b†jt olvas†sa }
Procedure CMOSwrite(Adr,Dat:byte); { Egy CMOS b†jt °r†sa    }

{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

Implementation

Const
    C_MaxVideoMode         = 21;
    C_VideoMode            : array [1..C_MaxVideoMode] of T_VideoMode = (
{ 320x200_16  } (ModeNum:$000D;ModeType:0;MemType:1;MaxX:320;MaxY:200;MaxC:16;LSize:40;BitPixel:4),
{ 320x240_16  } (ModeNum:$000E;ModeType:2;MemType:1;MaxX:320;MaxY:240;MaxC:16;LSize:40;BitPixel:4),
{ 320x350_16  } (ModeNum:$000D;ModeType:2;MemType:1;MaxX:320;MaxY:350;MaxC:16;LSize:40;BitPixel:4),
{ 320x400_16  } (ModeNum:$000D;ModeType:2;MemType:1;MaxX:320;MaxY:400;MaxC:16;LSize:40;BitPixel:4),
{ 320x480_16  } (ModeNum:$000E;ModeType:2;MemType:1;MaxX:320;MaxY:480;MaxC:16;LSize:40;BitPixel:4),
{ 640x200_16  } (ModeNum:$000E;ModeType:0;MemType:1;MaxX:640;MaxY:200;MaxC:16;LSize:80;BitPixel:4),
{ 640x240_16  } (ModeNum:$0012;ModeType:2;MemType:1;MaxX:640;MaxY:240;MaxC:16;LSize:80;BitPixel:4),
{ 640x350_16  } (ModeNum:$0010;ModeType:0;MemType:1;MaxX:640;MaxY:350;MaxC:16;LSize:80;BitPixel:4),
{ 640x400_16  } (ModeNum:$000E;ModeType:2;MemType:1;MaxX:640;MaxY:400;MaxC:16;LSize:80;BitPixel:4),
{ 640x480_16  } (ModeNum:$0012;ModeType:0;MemType:1;MaxX:640;MaxY:480;MaxC:16;LSize:80;BitPixel:4),
{ 720x400_16  } (ModeNum:$000E;ModeType:2;MemType:1;MaxX:720;MaxY:400;MaxC:16;LSize:90;BitPixel:4),
{ 720x480_16  } (ModeNum:$0012;ModeType:2;MemType:1;MaxX:720;MaxY:480;MaxC:16;LSize:90;BitPixel:4),
{ 800x600_16  } (ModeNum:$0102;ModeType:1;MemType:1;MaxX:800;MaxY:600;MaxC:16;LSize:100;BitPixel:4),
{1024x768_16  } (ModeNum:$0104;ModeType:1;MemType:1;MaxX:1024;MaxY:768;MaxC:16;LSize:128;BitPixel:4),
{1280x1024_16 } (ModeNum:$0106;ModeType:1;MemType:1;MaxX:1280;MaxY:1024;MaxC:16;LSize:160;BitPixel:4),
{ 320x200_256 } (ModeNum:$0013;ModeType:0;MemType:2;MaxX:320;MaxY:200;MaxC:256;LSize:320;BitPixel:8),
{ 640x400_256 } (ModeNum:$0100;ModeType:1;MemType:2;MaxX:640;MaxY:400;MaxC:256;LSize:640;BitPixel:8),
{ 640x480_256 } (ModeNum:$0101;ModeType:1;MemType:2;MaxX:640;MaxY:480;MaxC:256;LSize:640;BitPixel:8),
{ 800x600_256 } (ModeNum:$0103;ModeType:1;MemType:2;MaxX:800;MaxY:600;MaxC:256;LSize:800;BitPixel:8),
{1024x768_256 } (ModeNum:$0105;ModeType:1;MemType:2;MaxX:1024;MaxY:768;MaxC:256;LSize:1024;BitPixel:8),
{1280x1024_256} (ModeNum:$0107;ModeType:1;MemType:2;MaxX:1280;MaxY:1024;MaxC:256;LSize:1280;BitPixel:8)
                );

    C_VBP           : word   = $0000; { SegÇdv†ltoz¢ -egy pixel bitsz†ma act. m¢dban  }
    C_ActMode       : word   = $0000; { Aktu†lis vide¢m¢d                    }

    C_InkColor      : byte   = $0F; { Aktu†lis sz°n                          }
    C_CopyXOR       : byte   = $00; { CopyBlock segÇdv†ltoz¢                 }

    C_TextBackColor : byte   = $01; { Szîveg h†ttÇrsz°n                      }
    C_TextOver      : byte   = $01; { FelÅl°r†s jelzã                        }

    C_CharX         : word   = $08; { Karakter szÇlessÇge pixelben           }
    C_CharY         : word   = $10; { Karakter magass†ga pixelben            }

    C_TProcOn       : byte  = 0;    { TProc bekapcsol†s jelzã                }

{****************************************************************************}
{***                        Mouse mask Çs shape                           ***}
{****************************************************************************}

  _MouseMask                    : array [1..16,1..16] of byte =
                   ( (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                     (1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
                     (1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0),
                     (1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0),
                     (1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0),
                     (1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0),
                     (1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0),
                     (1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0),
                     (1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0),
                     (1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0),
                     (1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0),
                     (1,1,1,0,1,1,1,1,0,0,0,0,0,0,0,0),
                     (1,1,0,0,1,1,1,1,0,0,0,0,0,0,0,0),
                     (0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0),
                     (0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0),
                     (0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0) );

   _MouseShape                  : array [1..16,1..16] of byte =
                   ( (00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00),
                     (00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00),
                     (00,15,00,00,00,00,00,00,00,00,00,00,00,00,00,00),
                     (00,15,15,00,00,00,00,00,00,00,00,00,00,00,00,00),
                     (00,15,15,15,00,00,00,00,00,00,00,00,00,00,00,00),
                     (00,15,15,15,15,00,00,00,00,00,00,00,00,00,00,00),
                     (00,15,15,15,15,15,00,00,00,00,00,00,00,00,00,00),
                     (00,15,15,15,15,15,15,00,00,00,00,00,00,00,00,00),
                     (00,15,15,15,15,15,15,15,00,00,00,00,00,00,00,00),
                     (00,15,15,15,15,15,00,00,00,00,00,00,00,00,00,00),
                     (00,15,15,00,15,15,00,00,00,00,00,00,00,00,00,00),
                     (00,15,00,00,00,15,15,00,00,00,00,00,00,00,00,00),
                     (00,00,00,00,00,15,15,00,00,00,00,00,00,00,00,00),
                     (00,00,00,00,00,00,15,15,00,00,00,00,00,00,00,00),
                     (00,00,00,00,00,00,15,15,00,00,00,00,00,00,00,00),
                     (00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00) );

    _MouseAct                   :  boolean = TRUE;  { Saj†t egÇr megjelen°tÇs}
    _MouseMinX                  :  word    = 0;     { Mouse terÅlet          }
    _MouseMinY                  :  word    = 0;     { Mouse terÅlet          }
    _MouseMaxX                  :  word    = 0;     { Mouse terÅlet          }
    _MouseMaxY                  :  word    = 0;     { Mouse terÅlet          }

Var
    _MouseBackGround            : array [1..16,1..16] of byte;

{****************************************************************************}
{***                                                                      ***}
{***                     16 szin˚ assembly rutinok                        ***}
{***                                                                      ***}
{****************************************************************************}

{$L TG_16.OBJ}
Procedure  _Select_Page_16;external;
Procedure  _SetMode_16;external;
Procedure  _GetMode_16;external;
Procedure  _ClearScreen_16;external;
Procedure  _WritePixel_16;external;
Procedure  _GetPixel_16;external;
Procedure  _Line_16;external;
Procedure  _SolidRect_16;external;
Procedure  _CopyBlock_16;external;
Procedure  _CopyFromMem_16;external;
Procedure  _CopyToMem_16;external;
Procedure  _OutTextXY_16;external;
Procedure  _SetChars_16;external;
Procedure  _GetActPage_16;external;


{****************************************************************************}
{***                                                                      ***}
{***                     256 szin˚ assembly rutinok                       ***}
{***                                                                      ***}
{****************************************************************************}

{$L TG_256.OBJ}
Procedure  _Select_Page_256;external;
Procedure  _SetMode_256;external;
Procedure  _GetMode_256;external;
Procedure  _ClearScreen_256;external;
Procedure  _WritePixel_256;external;
Procedure  _GetPixel_256;external;
Procedure  _Line_256;external;
Procedure  _SolidRect_256;external;
Procedure  _CopyBlock_256;external;
Procedure  _CopyFromMem_256;external;
Procedure  _CopyToMem_256;external;
Procedure  _OutTextXY_256;external;
Procedure  _SetChars_256;external;
Procedure  _GetActPage_256;external;

{****************************************************************************}
{***                                                                      ***}
{***                     TProc assembler rutinjai                         ***}
{***                                                                      ***}
{****************************************************************************}

{$L TPROC.OBJ }
Procedure _TProcOn;External;
Procedure _TProcOff;External;
Procedure _Get_Command_From_Puffer;External;
Procedure _Put_Command_To_Puffer;External;
Procedure _GetTProcInfo;External;
Procedure _SetTimer;External;
Procedure _ClearCommandPuffer;External;
Procedure _SetTProcFlag;External;
Procedure _SetMouseEvent;External;
Procedure _SetTimeCounter;External;
Procedure _GetTimeCounter;External;

{****************************************************************************}
{***                          VGA/VESA elj†r†sok                          ***}
{****************************************************************************}

Function _GetSVGAInfo:word;assembler;
{ SVGA info lekÇrdezÇse a V_SVGAInfo v†ltoz¢ba }
Asm
        MOV     AX,SEG V_SVGAInfo
        MOV     ES,AX
        MOV     DI,OFFSET V_SVGAInfo
        MOV     AX,$4F00
        INT     $10
END;

Function _GetVESAInfo(K:WORD):word;assembler;
{ <K> m¢dhoz tartoz¢ VESA info lekÇrdezÇse a V_VESAInfo v†ltoz¢ba }
asm
        MOV     AX,SEG V_VESAInfo
        MOV     ES,AX
        MOV     DI,OFFSET V_VESAInfo
        MOV     AX,$4F01
        MOV     CX,K
        INT     $10
END;

Procedure _SelectPage_VESA;far;assembler;{belsã assembly elj†r†s}
{ Lapoz†s a VESA megszak°t†son keresztÅl - DL: PageNum }
Asm
        PUSH    DS
        PUSH    ES
        PUSH    AX
        PUSH    BX
        PUSH    DX
        MOV     AX,Seg V_VESAGran
        MOV     DS,AX
        XOR     BX,BX
        MOV     BL,DL
	MOV	AX,64
	XOR	DX,DX
	DIV	V_VESAGran
	MUL	BX
	MOV	DX,AX
	MOV	AX,4F05h
	MOV	BX,0000h
	INT	10h
	POP	DX
	POP	BX
	POP	AX
        POP     ES
        POP     DS
End;

Procedure _No_SelectPage;far;assembler;
{ Nincs lapoz†s }
Asm
End;

Function _SetMode_VESA(Mode:word):word;Assembler;
{ <Mode> VESA m¢d be†ll°t†sa }
Asm
        PUSH    DS
        CALL    _GetSVGAInfo
        CMP     AX,$004F
        JNZ     @NoVESA         { Nincs VESA driver                          }
        PUSH    Mode
        CALL    _GetVESAInfo
        CMP     AX,$004F
        JNZ     @NoVESAMode     { Nem ba†ll°that¢ VESA m¢d                   }
        MOV     BX,Mode
        MOV     AX,$4F02
        INT     $10             { OK, VESA m¢d be†ll°t†sa                    }
        CMP     AX,$004F
        JNZ     @NoVESAModeSet  { Nem sikerÅlt a VESA m¢d be†ll°t†sa         }
        XOR     AX,AX           { AX=0 OK                                    }
        JMP     @End
@NoVesa:
        MOV     AX,1            { Nincs VESA driver                          }
        JMP     @End
@NoVesaMode:
        MOV     AX,2            { VESA info lekÇrdezÇse nem sikerÅlt         }
        JMP     @End
@NoVesaModeSet:
        MOV     AX,3            { VESA m¢d be†ll°t†sa nem sikerÅlt           }
@End:   POP     DS
End;

Function _SetMode_VGA(Mode:byte):word;assembler;
{ <Mode> VGA m¢d be†ll°t†sa }
Asm
        XOR     AX,AX
        MOV     AL,Mode
        INT     $10
        XOR     AX,AX
End;

{****************************************************************************}
{***                       Video mem¢ria †ll°t†s                          ***}
{****************************************************************************}

Procedure SetVideoMem(XX,YY:word);assembler;
Asm
        MOV     AX,$4F07
        XOR     BX,BX
        MOV     DX,YY
        MOV     CX,XX
        INT     $10
End;


{****************************************************************************}
{***             SegÇdelj†r†sok a grafikus video m¢d be†ll°t†shoz         ***}
{****************************************************************************}

Const
     C_data_350 : ARRAY[0..7]  OF byte=($83,$85,$5D,$28,$0F,$63,$BA,$e3);
     C_data_480 : ARRAY[0..23] OF byte=($2D,$27,$28,$90,$2B,$80,$0b,$3e,
                                      $00,$40,$00,$00,$00,$00,$00,$00,
                                      $ea,$8c,$df,$14,$00,$e7,$04,$e3);
     C_data_720 : Array[0..5]  of byte=($6B,$59,$5A,$8E,$5E,$8A);




Procedure _To720(clock:byte);
var k,i:Word;
Begin
portw[$3c2]:=clock;portw[$3d4]:=$0e11;
for i:=0 to 5 do begin k:=256*word(C_data_720[i])+i;portw[$3d4]:=k;end;
portw[$3d4]:=$2d13;portw[$3d4]:=$8e11;
End;

Procedure _S320x350_16; Assembler;
Asm
   mov   dx,$3C2
   mov   al,$A3
   out   dx,al
   lea   si,C_DATA_350;
   mov   cx,8
   mov   dx,$3D4
   mov   ax,$4009
   out   dx,ax
   mov   al,$10
@Set_regs:
   mov   ah,[si]
   out   dx,ax
   inc   al
   inc   si
   loop  @Set_regs
   mov   ax,$1413
   out   dx,ax
End;

Procedure _S320x480_16; Assembler;
Asm
   mov   dx,$3C4
{$IFDEF SeqRESET}
   mov   ax,$0100
   out   dx,ax
{$ENDIF}
   mov   ax,$0901
   out   dx,ax
{$IFDEF SeqRESET}
   mov   ax,$0300
   out   dx,ax
{$ENDIF}
   lea   si,C_DATA_480
   mov   cx,$18
   mov   dx,$3D4
   mov   ax,$0011
   out   dx,ax
   xor   al,al
@Set_regs:
   mov   ah,[si]
   out   dx,ax
   inc   al
   inc   si
   loop  @Set_regs
End;

Procedure _InitVideoMode(VBP,LS,PgS,PgO:word);assembler;
Asm
        MOV     ES,PgS
        MOV     DI,PgO
        MOV     DX,LS
        MOV     CX,16
        CMP     VBP,4
        JNZ     @No16Col
        CALL    _SetMode_16
        JMP     @Exit
@No16Col:
        CMP     VBP,8
        JNZ     @No256Col
        CALL    _SetMode_256
        JMP     @Exit
@No256Col:
@Exit:
End;

{****************************************************************************}
{***                   Grafikus video m¢d be†ll°t†s                       ***}
{****************************************************************************}

Function SetGraphMode(Mode:word):word;
{ <Mode> vide¢ m¢d be†ll°t†sa      Fv:0=OK 1..=Hibak¢dok                     }
Begin
If (Mode>C_MaxVideoMode) or (Mode=0) then begin SetGraphMode:=4;Exit;end;
With C_VideoMode[Mode] do
     Case ModeType of
          0 : begin
              SetGraphMode:=_SetMode_VGA(lo(ModeNum));C_VBP:=BitPixel;
              _InitVideoMode(BitPixel,LSize,Seg(_No_SelectPage),Ofs(_No_SelectPage));
              end;
          1 : begin
              SetGraphMode:=_SetMode_VESA(ModeNum);C_VBP:=BitPixel;V_VESAGran:=V_VESAInfo.Window_MoveMem;
              _InitVideoMode(BitPixel,LSize,Seg(_SelectPage_VESA),Ofs(_SelectPage_VESA));
              end;
          2 : begin
              SetGraphMode:=_SetMode_VGA(lo(ModeNum));C_VBP:=BitPixel;
              _InitVideoMode(BitPixel,LSize,Seg(_No_SelectPage),Ofs(_No_SelectPage));
              Case Mode of
                   _320x240_16 : begin portw[$3d4]:=$4009;;_S320x480_16;portw[$3d4]:=$c009;end;
                   _320x350_16 : _S320x350_16;
                   _320x400_16 : PortW[$3d4]:=$4009;
                   _320x480_16 : begin portw[$3d4]:=$4009;;_S320x480_16;end;
                   _640x240_16 : PortW[$3d4]:=$c009;
                   _640x400_16 : PortW[$3d4]:=$4009;
                   _720x400_16 : begin portw[$3d4]:=$4009;_To720($67);end;
                   _720x480_16 : _To720($e7);
                   end;
              end;
          end;
C_ActMode:=Mode;ROM_8x14;
End;

{****************************************************************************}
{***                   Grafikus video m¢d lekÇrdezÇs                      ***}
{****************************************************************************}

Function GetMode:word;
Begin
GetMode:=C_VideoMode[C_ActMode].ModeNum;
End;

Function GetMaxX:word;
Begin
GetMaxX:=C_VideoMode[C_ActMode].MaxX;
End;

Function GetMaxY:word;
Begin
GetMaxY:=C_VideoMode[C_ActMode].MaxY;
End;

Function GetMaxColor:longint;
Begin
GetMaxColor:=Longint(1) SHL C_VBP;
End;

{****************************************************************************}
{***                      Grafikus elj†r†sok                              ***}
{****************************************************************************}

Procedure ClearScreen(Color:byte);assembler;
Asm
        MOV      BL,Color
        CMP      C_VBP,4
        JNZ      @No16Col
        CALL     _ClearScreen_16
        JMP      @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _ClearScreen_256
        JMP     @Exit
@No256Col:
@Exit:
End;

Procedure PutPixel(X,Y:word;C:byte);assembler;
Asm
        MOV     DX,Y
        MOV     CX,X
        MOV     BL,C
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _WritePixel_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _WritePixel_256
        JMP     @Exit
@No256Col:
@Exit:
End;

Function GetPixel(X,Y:word):byte;assembler;
Asm
        MOV     DX,Y
        MOV     CX,X
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _GetPixel_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _GetPixel_256
        JMP     @Exit
@No256Col:
@Exit:
End;

Procedure Line(X1,Y1,X2,Y2:word); assembler;
Asm
        MOV     CX,X1
        MOV     DX,Y1
        MOV     SI,X2
        MOV     DI,Y2
        MOV     BL,C_InkColor
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _Line_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _Line_256
        JMP     @Exit
@No256Col:
@Exit:
End;

Procedure Rectangle(X1,Y1,X2,Y2:word);assembler;
Asm
        PUSH    X1
        PUSH    Y1
        PUSH    X1
        PUSH    Y2
        CALL    Line
        PUSH    X2
        PUSH    Y1
        PUSH    X2
        PUSH    Y2
        CALL    Line
        PUSH    X1
        PUSH    Y1
        PUSH    X2
        PUSH    Y1
        CALL    Line
        PUSH    X1
        PUSH    Y2
        PUSH    X2
        PUSH    Y2
        CALL    Line
End;

Procedure Bar(X1,Y1,X2,Y2:word); assembler;
Asm
        MOV     CX,X1
        MOV     DX,Y1
        MOV     SI,X2
        MOV     DI,Y2
        MOV     BL,C_InkColor
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _SolidRect_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _SolidRect_256
        JMP     @Exit
@No256Col:
@Exit:
End;

{****************************************************************************}
{***                  CopyBlock/CopyMem elj†r†sok                         ***}
{****************************************************************************}

Procedure CopyBlock(X1,Y1,X2,Y2,DXx,DYy:word);assembler;
Asm
        PUSH    BP
        MOV     CX,X1
        MOV     DX,Y1
        MOV     SI,X2
        MOV     DI,Y2
        MOV     AX,DXx
        MOV     BX,DYy
        CMP     C_VBP,4
        JNZ     @No16Col
        MOV     BP,BX
        MOV     BL,C_CopyXOR
        CALL    _CopyBlock_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _CopyBlock_256
        JMP     @Exit
@No256Col:
@Exit:
        POP     BP
End;

Procedure CopyFromMem(X1,Y1,DXx,DYy,MDx:word;var Dst);assembler;
Asm
        PUSH    DS
        MOV     CX,X1
        MOV     DX,Y1
        MOV     AX,DXx
        MOV     BX,DYy
        MOV     DI,MDx
        CMP     C_VBP,4
        JNZ     @No16Col
        LDS     SI,Dst
        CALL    _CopyFromMem_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        LDS     SI,Dst
        CALL    _CopyFromMem_256
        JMP     @Exit
@No256Col:
@Exit:
        POP   DS
End;

Procedure CopyToMem(X1,Y1,DXx,DYy,MDx:word;var Src);assembler;
Asm
        PUSH    DS
        MOV     CX,X1
        MOV     DX,Y1
        MOV     AX,DXx
        MOV     BX,DYy
        MOV     DI,MDx
        CMP     C_VBP,4
        JNZ     @No16Col
        LDS     SI,Src
        CALL    _CopyToMem_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        LDS     SI,Src
        CALL    _CopyToMem_256
        JMP     @Exit
@No256Col:
@Exit:
        POP     DS
End;

Function GetActPage:byte;assembler;
Asm
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _GetActPage_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _GetActPage_256
        JMP     @Exit
@No256Col:
@Exit:
End;

Procedure SetActPage(PG:word);assembler;
Asm
        MOV     DX,PG
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _Select_Page_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _Select_Page_256
        JMP     @Exit
@No256Col:
@Exit:
End;

{****************************************************************************}
{***                                                                      ***}
{***    TextColor/TextBackColor/TextOver/RGB/Palette/Border †ll°t†sok     ***}
{***                                                                      ***}
{****************************************************************************}


Procedure SetColor(Color:byte);assembler;
Asm
   MOV  AL,Color
   MOV  C_InkColor,AL
End;

Procedure SetTextBackColor(Color:byte);assembler;
Asm
   MOV  AL,Color
   MOV  C_TextBackColor,AL
End;

Procedure SetTextOver(Over:byte);assembler;
Asm
   MOV  AL,Over
   MOV  C_TextOver,AL
End;

Procedure SetBorder(C:byte);assembler;
Asm
        MOV     AX,$1001
        MOV     BH,C
        INT     $10
End;

Procedure SetRGBreg(RegNum,Red,Green,Blue:byte); Assembler;
Asm
        MOV     DX,03c8h
        MOV     AL,RegNum
        OUT     DX,AL
        INC     DX
        MOV     AL,Red
        OUT     DX,AL
        MOV     AL,Green
        OUT     DX,AL
        MOV     AL,Blue
        OUT     DX,AL
End;

Procedure GetRGBreg(RegNum:byte; var RGB ); Assembler;
Asm
        CLD
        LES     DI,RGB
        MOV     DX,03c7h
        MOV     AL,RegNum
        OUT     DX,AL
        ADD     DL,2
        IN      AL,DX
        STOSB
        IN      AL,DX
        STOSB
        IN      AL,DX
        STOSB
End;

Procedure SetPalette(e,f:word;var t);assembler;
Asm
        MOV     AX,$1012
        MOV     BX,E
        MOV     CX,f
        LES     DX,t
        INT     $10;
End;

Procedure GetPalette(e,f:word;var t);assembler;
Asm
        MOV     AX,$1017
        MOV     BX,e
        MOV     CX,f
        LES     DX,t
        INT     $10;
End;

{****************************************************************************}
{***                                                                      ***}
{***                    OutTextXY/OutStringXY elj†r†sok                   ***}
{***                                                                      ***}
{****************************************************************************}

Procedure OutTextXY(X,Y:word;var S);assembler;
Asm
        LES     DI,S
        MOV     CX,X
        MOV     DX,Y
        XOR     AX,AX
        MOV     AH,C_TextOver
        MOV     BL,C_InkColor
        MOV     BH,C_TextBackColor
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _OuttextXY_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _OuttextXY_256
        JMP     @Exit
@No256Col:
@Exit:
End;


Procedure OutStringXY(X,Y:word;S:string);
Var SSs,SO:word;
Begin
If length(S)<255 then S:=S+chr(0) else S[255]:=chr(0);
SSs:=Seg(S);SO:=Ofs(S);
asm
        MOV     ES,SSs
        MOV     DI,SO
        INC     DI
        MOV     CX,X
        MOV     DX,Y
        MOV     AH,C_TextOver
        MOV     BL,C_InkColor
        MOV     BH,C_TextBackColor
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _OuttextXY_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _OuttextXY_256
        JMP     @Exit
@No256Col:
@Exit:
end;
End;


{****************************************************************************}
{***                                                                      ***}
{***           Karakter gener†tor be†ll°t†sok/lekÇrdezÇsek                ***}
{***                                                                      ***}
{****************************************************************************}

Function GetCharX:word;
begin
GetCharX:=C_CharX;
end;

Function GetCharY:word;
begin
GetCharY:=C_CharY;
end;

Procedure GetChars(var TGCh:TGraph_CharsType);assembler;
Asm
        PUSH    DS
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _GetMode_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _GetMode_256
        JMP     @Exit
@No256Col:
@Exit:
        LDS     SI,TgCh
        XCHG    SI,DI
        MOV     AX,DS
        MOV     DX,ES
        MOV     DS,DX
        MOV     ES,AX
        MOV     CX,12
        CLD
        REP     MOVSB
        POP     DS
End;

Procedure SetChars(var TGCh:TGraph_CharsType);assembler;
Asm
        PUSH    BP
        PUSH    DS
        LDS     DI,TgCh
        MOV     DX,DS:[DI]
        MOV     CX,DS:[DI+2]
        MOV     AX,DS:[DI+8]
        MOV     ES,AX
        MOV     AX,DS:[DI+4]
        MOV     SI,DS:[DI+6]
        MOV     BP,DS:[DI+10]
        MOV     BX,0
        POP     DS
        MOV     C_CharX,CX
        MOV     C_CharY,DX
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _SetChars_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _SetChars_256
        JMP     @Exit
@No256Col:
@Exit:
        POP     BP
End;

Procedure ROM_8x8;assembler;
Asm
        PUSH    BP
        PUSH    ES
        PUSH    DS
        MOV     AX,1130h
        MOV     BH,03
        INT     $10
        MOV     AX,1
        MOV     CX,8
        MOV     DX,8
        MOV     SI,8
        MOV     BX,0
        MOV     C_CharX,CX
        MOV     C_CharY,DX
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _SetChars_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _SetChars_256
        JMP     @Exit
@No256Col:
@Exit:
        POP     DS
        POP     ES
        POP     BP
End;

Procedure ROM_8x14;assembler;
Asm
        PUSH    BP
        PUSH    ES
        PUSH    DS
        MOV     AX,1130h
        MOV     BH,02
        INT     $10
        MOV     AX,1
        MOV     CX,8
        MOV     DX,14
        MOV     SI,14
        MOV     BX,0
        MOV     C_CharX,CX
        MOV     C_CharY,DX
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _SetChars_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _SetChars_256
        JMP     @Exit
@No256Col:
@Exit:
        POP     DS
        POP     ES
        POP     BP
End;

Procedure ROM_8x16;assembler;
Asm
        PUSH    BP
        PUSH    ES
        PUSH    DS
        MOV     AX,1130h
        MOV     BH,06
        INT     $10
        MOV     AX,1
        MOV     CX,8
        MOV     DX,16
        MOV     SI,16
        MOV     BX,0
        MOV     C_CharX,CX
        MOV     C_CharY,DX
        CMP     C_VBP,4
        JNZ     @No16Col
        CALL    _SetChars_16
        JMP     @Exit
@No16Col:
        CMP     C_VBP,8
        JNZ     @No256Col
        CALL    _SetChars_256
        JMP     @Exit
@No256Col:
@Exit:
        POP     DS
        POP     ES
        POP     BP
End;

{****************************************************************************}
{***                                                                      ***}
{***                 Speci†lis keretrajzol¢ elj†r†sok                     ***}
{***                                                                      ***}
{****************************************************************************}

Procedure  BorderDraw_1a(x1,y1,dx,dy:word;col,sot,vil:byte);
var x2,y2:word;
begin
x2:=x1+dx+4;y2:=y1+dy+4;
Setcolor(col);bar(x1,y1,x2,y2);
setcolor(sot);Line(x2,y1,x2,y2);Line(x2-1,y1+1,x2-1,y2);
Line(x1,y2,x2,y2);Line(x1+1,y2-1,x2,y2-1);
setcolor(vil);Line(x1,y1,x2-1,y1);Line(x1,y1,x1,y2-1);
Line(x1+1,y1,x1+1,y2-2);
end;

Procedure  BorderDraw_1b(x1,y1,dx,dy:word;col,sot,vil:byte);
var x2,y2:word;
begin
x2:=x1+dx+3;y2:=y1+dy+3;
Setcolor(col);bar(x1,y1,x2,y2);
setcolor(sot);Line(x2,y1,x2,y2);Line(x1,y2,x2,y2);
setcolor(vil);Line(x1,y1,x2-1,y1);Line(x1,y1,x1,y2-1)
end;

Procedure BorderDraw_2a(x1,y1,dx,dy:word;col,sot,vil:byte);
var x2,y2:word;
begin
x2:=x1+dx+5;y2:=y1+dy+5;setcolor(col);Bar(x1+2,y1+2,x2-2,y2-2);
setcolor(vil);Line(x2-1,y1+1,x2-1,y2-1);Line(x1+1,y2-1,x2-1,y2-1);
setcolor(sot);Line(x1+1,y1+1,x2-1,y1+1);Line(x1+1,y1+1,x1+1,y2-1);
Line(x1+2,y1+2,x2-2,y1+2);Line(x1+2,y1+2,x1+2,y2-2);
end;

Procedure BorderDraw_2b(x1,y1,dx,dy:word;col,sot,vil:byte);
var x2,y2:word;
begin
x2:=x1+dx+4;y2:=y1+dy+4;setcolor(col);Bar(x1+1,y1+1,x2-1,y2-1);
setcolor(vil);Line(x2-1,y1+1,x2-1,y2-1);Line(x1+1,y2-1,x2-1,y2-1);
setcolor(sot);Line(x1+1,y1+1,x2-2,y1+1);Line(x1+1,y1+1,x1+1,y2-2);
end;

Procedure BorderDraw_3(x1,y1,dx,dy:word;col,sot,vil:byte);
var x2,y2:word;
begin
x2:=x1+dx+4;y2:=y1+dy+4;
setcolor(col);Bar(x1+2,y1+2,x2-2,y2-2);
setcolor(SOT);Line(x2-1,y1+1,x2-1,y2-1);Line(x1+1,y2-1,x2-1,y2-1);
Line(x1+1,y1+1,x2-2,y1+1);Line(x1+1,y1+1,x1+1,y2-2);
setcolor(VIL);
Line(x2,y1+1,x2,y2);Line(x1+1,y2,x2,y2);
Line(x1+2,y1+2,x2-2,y1+2);Line(x1+2,y1+2,x1+2,y2-2);
end;

{****************************************************************************}
{***                          KÇp ki/bekapcsol†sa                         ***}
{****************************************************************************}

Procedure PictureOff;assembler;
Asm
        CLI
        MOV     AX,2001h
        MOV     DX,$03c4
        OUT     DX,AX
        STI
End;

Procedure PictureOn;assembler;
Asm
        CLI
        MOV     AX,0101h
        MOV     DX,$03c4
        OUT     DX,AX
        STI
End;

{****************************************************************************}
{***                       Saj†t egÇr megjelen°tÇs                        ***}
{****************************************************************************}

Procedure SaveMouseBack(XX,YY:word);
Begin
CopyToMem(XX,YY,16,16,GetMaxX,_MouseBackGround);
End;

Procedure RestoreMouseBack(XX,YY:word);
Begin
CopyFromMem(XX,YY,16,16,GetMaxX,_MouseBackGround);
End;

Procedure ShowMouseShape(XX,YY:word);
var i,j:word;
Begin
For j:=1 to 16 do
    If (YY+J-1)<_MouseMaxY then
       for i:=1 to 16 do
           if _MouseMask[j,i]=1 then
              if (XX+I-1)<_MouseMaxX then PutPixel(XX+i-1,YY+j-1,_MouseShape[j,i]);
End;

Function GetMouseAct:boolean;
Begin
GetMouseAct:=_MouseAct;
End;

Procedure ShowMousePos(MX,MY:word);
Begin
RestoreMouseBack(OldMouseX,OldMouseY);
SaveMouseBack(MX,MY);OldMouseX:=MX;OldMouseY:=MY;
ShowMouseShape(MX,MY);
End;

Procedure MyMouseInt;assembler;
Asm
        PUSH    DS
        MOV     AX,Seg V_SVGAInfo
        MOV     DS,AX
        MOV     AX,NoMouse
        OR      AX,AX
        JNZ     @MMI_Exit
        CALL    GetActPage
        PUSH    AX
        PUSH    CX
        PUSH    DX
        CALL    ShowMousePos
        CALL    SetActPage
@MMI_Exit:
        POP     DS
End;

{****************************************************************************}
{***                       EgÇr kezelÇs VGA m¢dban                        ***}
{****************************************************************************}

Function MouseInit(Ma:boolean;PR:word;MDVX,MDVY:byte):word;
var BSZ:word;
Begin
Asm
   XOR AX,AX
   INT $33
   XOR CX,CX
   CMP AX,$FFFF
   JNZ @Exit
   MOV CX,BX
@Exit: MOV BSZ,CX
end;
If BSZ=0 then _MouseAct:=FALSE else _MouseAct:=Ma;
If _MouseAct=True
   then begin
        MouseDivX:=MDVX;MouseDivY:=MDVY;SetMouseResolution(PR,PR);
        SetMouseArea(0,0,GetMaxX-2,GetMaxY-2);
        SaveMouseBack(GetMouseX,GetMouseY);
        SetMouseEvent(Seg(MyMouseInt),Ofs(MyMouseInt));
        end;
MouseInit:=BSZ;
End;

Procedure MouseShow;
var MX,MY:word;
Begin
If _MouseAct
   then If NoMouse=1
           then begin
                NoMouse:=2;
                MX:=GetMouseX;MY:=GetMouseY;SaveMouseBack(MX,MY);
                ShowMouseShape(MX,MY);OldMouseX:=MX;OldMouseY:=MY;
                NoMouse:=0;
                end
           else
   else Asm MOV AX,$0001;INT $33 end;
End;

Procedure MouseHide;
Begin
If _MouseAct
   then If NoMouse=0
           then begin
                NoMouse:=2;
                RestoreMouseBack(OldMouseX,OldMouseY);
                NoMouse:=1;
                end
           else
   else Asm MOV AX,$0002;INT $33 end;
End;

{****************************************************************************}
{***                          Mouse lekÇrdezÇsek                          ***}
{****************************************************************************}

Function GetMouseX:word;assembler;
Asm
        MOV     AX,$0003
        INT     $33
        MOV     AX,CX
        MOV     CL,MouseDivX
        SHR     AX,CL
end;

Function GetMouseY:word;assembler;
Asm
        MOV     AX,$0003
        INT     $33
        MOV     AX,DX
        MOV     CL,MouseDivX
        SHR     AX,CL
end;

Function GetMouseButton:byte;assembler;
Asm
        MOV     AX,$0003
        INT     $33
        MOV     AL,BL
end;

{****************************************************************************}
{***                     Mouse paramÇterek be†ll°t†sa                     ***}
{****************************************************************************}

Procedure SetMousePos(X,Y:word);assembler;
Asm
        MOV     AX,X
        MOV     CL,MouseDivX
        SHL     AX,CL
        MOV     DX,Y
        MOV     CL,MouseDivY
        SHL     DX,CL
        MOV     CX,AX
        MOV     AX,$0004
        INT     $033
End;

Procedure SetMouseArea(X1,Y1,X2,Y2:word);assembler;
Asm
        XOR     BX,BX
        MOV     AX,X1
        MOV     _MouseMinX,AX
        MOV     CL,MouseDivX
        SHL     AX,CL
        MOV     DX,X2
        MOV     _MouseMaxX,DX
        MOV     CL,MouseDivX
        SHL     DX,CL
        MOV     CX,AX
        MOV     AX,$0007
        INT     $33
        XOR     BX,BX
        MOV     AX,Y1
        MOV     _MouseMinY,AX
        MOV     CL,MouseDivX
        SHL     AX,CL
        MOV     DX,Y2
        MOV     _MouseMaxY,DX
        MOV     CL,MouseDivX
        SHL     DX,CL
        MOV     CX,AX
        MOV     AX,$0008
        INT     $33
End;

Procedure SetMousePointer(Ddx,Ddy:integer; var Src);assembler;
Asm
        MOV     BX,Ddx
        MOV     CX,Ddy
        LES     DX,Src
        MOV     AX,$0009
        INT     $33
End;


Procedure SetNoMouseArea(X1,Y1,X2,Y2:word);assembler;
Asm
        XOR     BX,BX
        MOV     CX,X1
        MOV     DX,Y1
        MOV     SI,X2
        MOV     DI,Y2
        MOV     AX,$0010
        INT     $33
End;

Procedure SetMouseResolution(Rx,Ry:word);assembler;
Asm
        XOR   BX,BX
        MOV   CX,Rx
        MOV   DX,Ry
        MOV   AX,$000F
        INT   $33
End;

Procedure SetMouseFunction(Mask:word;Proc:pointer);assembler;
Asm
        MOV     CX,Mask
        MOV     AX,$000C
        LES     DX,Proc
        INT     $33
End;

Procedure SetMouseShape(dDx,dDy:integer;var Src);assembler;
Asm
        MOV     BX,dDx
        MOV     CX,Ddy
        LES     DX,Src
        MOV     AX,$0009
        INT     $33
End;

{****************************************************************************}
{****************************************************************************}
{***                     File kezelã elj†r†sok                            ***}
{****************************************************************************}
{****************************************************************************}

{****************************************************************************}
{************************** File Megnyitasa *********************************}
{****************************************************************************}


Function OpenFile(FNev:string;OpenMode:byte):word;assembler;
asm
        PUSH    DS                      { DS megorzese                       }
        LDS     SI,FNev                 { DS:SI=Filenev                      }
        XOR     BX,BX                   { BX=0                               }
        MOV     BL,DS:[SI]              { BX a string hossza                 }
        XOR     AL,AL                   { AL=0                               }
        MOV     DS:[SI+BX+1],AL         { Az utolso byte=0 (string vege jel) }
        MOV     DX,SI                   { DS:DX = FileNev string             }
        INC     DX                      { Az elso byte a string hossza       }
        MOV     AH,$3D                  { $3D DOS megszakitas                }
        MOV     AL,OpenMode             { Menyitasi kod 0:Read 1:Write 2:R/W }
        INT     $21                     { Int $21 -> DOS megszakitas         }
        POP     DS                      { DS visszaallitasa                  }
        JC      @Hiba                   { Ha hiba volt akkor ugras           }
        MOV     IOError,0               { Nincs hiba                         }
        JMP     @Exit                   { Ugras kilepesre                    }
@Hiba:  MOV     IOError,AX              { IOError=AX                         }
@Exit:
end;

{****************************************************************************}
{**************************** File olvasas **********************************}
{****************************************************************************}

Function ReadFile(FHandle:word;var D;Size:word):word;assembler;
asm
        PUSH    DS                      { DS megorzese                       }
        MOV     BX,FHandle              { BX=FileSzam                        }
        LDS     DX,D                    { AX=Memocim                         }
        MOV     AX,$3F00                { $3F DOS alszolgaltatas             }
        MOV     CX,Size                 { CX db byte betoltese               }
        INT     $21                     { Int $21 DOS megszakitas            }
        POP     DS                      { DS visszaallitas                   }
        JC      @Hiba                   { Ha hiba volt akkor ugras           }
        MOV     IOError,0               { Nincs hiba                         }
        JMP     @Exit                   { Ugras kilepesre                    }
@Hiba:  MOV     IOError,AX              { IOError=AX                         }
@Exit:
end;

{****************************************************************************}
{**************************** File iras *************************************}
{****************************************************************************}

Function WriteFile(FHandle:word;var D;Size:word):word;assembler;
asm
        PUSH    DS                      { DS megorzese                       }
        MOV     BX,FHandle              { BX=FileSzam                        }
        LDS     DX,D                    { AX=Memocim                         }
        MOV     AX,$4000                { $3F DOS alszolgaltatas             }
        MOV     CX,Size                 { CX db byte betoltese               }
        INT     $21                     { Int $21 DOS megszakitas            }
        POP     DS                      { DS visszaallitas                   }
        JC      @Hiba                   { Ha hiba volt akkor ugras           }
        MOV     IOError,0               { Nincs hiba                         }
        JMP     @Exit                   { Ugras kilepesre                    }
@Hiba:  MOV     IOError,AX              { IOError=AX                         }
@Exit:
end;

{****************************************************************************}
{*************************** File mutato allitas ****************************}
{****************************************************************************}

Procedure SeekFile(FHandle:word;Pos:longint;From:byte);assembler;
Asm
        MOV     BX,FHandle              { BX=FileSzam                        }
        MOV     AL,From    { Viszonyitas 00:F. Kezdete 01:Aktualis 2:F. vege }
        MOV     AH,$42
        MOV     DX,Word Ptr [Pos]
        MOV     CX,Word Ptr [Pos+2]
        Int     $21
        JC      @Hiba                   { Ha hiba volt akkor ugras           }
        MOV     IOError,0               { Nincs hiba                         }
        JMP     @Exit                   { Ugras kilepesre                    }
@Hiba:  MOV     IOError,AX              { IOError=AX                         }
@Exit:
end;

{****************************************************************************}
{*************************** File lezarasa **********************************}
{****************************************************************************}

Procedure CloseFile(FHandle:word);assembler;
asm
        MOV     BX,FHandle              { BX=FileSzam                        }
        MOV     AX,$3E00                { $3E DOS alszolgaltatas             }
        INT     $21                     { Int $21 DOS megszakitas            }
        JC      @Hiba                   { Ha hiba volt akkor ugras           }
        MOV     IOError,0               { Nincs hiba                         }
        JMP     @Exit                   { Ugras kilepesre                    }
@Hiba:  MOV     IOError,AX              { IOError=AX                         }
@Exit:
end;

{****************************************************************************}
{****************************************************************************}
{***                        XMS kezelã elj†r†sok                          ***}
{****************************************************************************}
{****************************************************************************}

Type
    XMSType = record
              ByteNum    : longint;
              SourceType : word;
              SourceOff  : word;
              SourceSeg  : word;
              DestType   : word;
              DestOff    : word;
              DestSeg    : word;
              end;

Var
        XMSProc    : longint; { XMS rutin c°me                               }
        XMS        : XMSType; { XMS t°pus a mozgat†shoz                      }


{****************************************************************************}
{************************ XMS vezÇrlã inicializ†l†sa ************************}
{****************************************************************************}

Function InitXMS:boolean;assembler;
Asm
        MOV     AX,$4300
        INT     $2F
        CMP     AL,$80
        JE      @Ok
        XOR     AL,AL
        JMP     @Exit
@Ok:
        MOV     AX,$4310
        INT     $2f
        MOV     word ptr DS:[XMSProc],BX
        MOV     word ptr DS:[XMSProc+2],ES
        MOV     AL,1
@Exit:
end;


{****************************************************************************}
{************************ XMS mem¢ria lefoglal†sa ***************************}
{****************************************************************************}

Function GetXMS(Meret:word;var Handle:word):byte;assembler;
Asm
        MOV     AH,$09
        MOV     DX,Meret
        CALL    dword ptr ds:[XMSProc] { Mem¢ria allok†l†sa }
        CMP     AX,1
        JE      @Ok
        MOV     AL,BL
        JMP     @Exit
@Ok:
        LES     SI,Handle
        MOV     ES:[SI],DX
        MOV     AH,$0C
        CALL    dword ptr DS:[XMSProc] { Mem¢ria z†rol†sa }
        MOV     AL,BL
@Exit:
end;

{****************************************************************************}
{************************ XMS mem¢ria felszabad°t†sa ************************}
{****************************************************************************}

Function FreeXMS(Handle:word):byte;assembler;
Asm
        MOV     AH,$0D
        MOV     DX,Handle
        CALL    dword ptr DS:[XMSProc] { Mem¢ria z†rol†s felold†sa }
        CMP     AX,1
        JE      @Ok
        MOV     AL,BL
        JMP     @Exit
@Ok:
        MOV     AH,$0A
        MOV     DX,Handle
        CALL    dword ptr DS:[XMSProc] { Mem¢ria felszabad°t†s     }
        MOV     AL,BL
@Exit:
end;

{****************************************************************************}
{************************** Mem¢ria mozgat†sa *******************************}
{****************************************************************************}

Function MoveXMS(meret:longint;st,soff,sg,dt,doff,dg:word):byte;
var b:byte;
Begin
XMS.ByteNum:=Meret;
XMS.SourceType:=ST;XMS.SourceOff:=soff;XMS.SourceSeg:=Sg;
XMS.DestType:=DT;XMS.DestOff:=Doff;XMS.DestSeg:=dg;
 Asm
        MOV     SI,offset XMS
        MOV     AH,$0B
        CALL    dword ptr ds:[XMSProc]
        CMP     AX,1
        JE      @OK
        MOV     b,BL
        JMP     @Exit

@Ok:    MOV     AL,0
        MOV     b,AL
@Exit:
 End;
MoveXMS:=B;
End;

{****************************************************************************}
{************************** Max XMS mem¢ria lekÇrdezÇse *********************}
{****************************************************************************}

Function MaxXMSMem:word;assembler;
Asm
        MOV     AH,$08;
        MOV     BL,00
        CALL    dword ptr ds:[XMSProc]
        OR      BL,BL
        JZ      @Ok
        MOV     AX,0
        JMP     @Exit
@Ok:    MOV     AX,DX
@Exit:
End;

Function MaxXMSMemBlock:word;assembler;
Asm
        MOV     AH,$08;
        MOV     BL,00
        CALL    dword ptr ds:[XMSProc]
        OR      BL,BL
        JZ      @Exit
        MOV     AX,0
@Exit:
End;

{****************************************************************************}
{***************************** LoadFileXMS **********************************}
{****************************************************************************}

Function LoadFileToXMS(Filenev:string;Handle,PufferMeret:word):word;
var F:word;NumRead:word;Meret:longint;Puffer:pointer;i,j:word;
begin
If MaxAvail<PufferMeret then begin LoadFileToXMS:=0;Exit;end;
F:=OpenFile(FileNev,0);If IOError<>0 then begin LoadFileToXMS:=0;Exit;end;
GetMem(Puffer,PufferMeret);i:=0;j:=0;
repeat
      NumRead:=ReadFile(F,Puffer^,PufferMeret);
      if MoveXMS(PufferMeret,0,Ofs(Puffer^),Seg(Puffer^),Handle,j,i)<>0
         then begin
              CloseFile(F);FreeMem(Puffer,Puffermeret);
              FreeXMS(Handle);LoadFileToXMS:=0;Exit;
              end;
      if j=0 then j:=PufferMeret else begin inc(i);j:=0;end;
      until NumRead<>PufferMeret;
CloseFile(F);Freemem(Puffer,PufferMeret);
LoadFileToXMS:=Handle;
end;

{****************************************************************************}
{****************************************************************************}
{***                        EgyÇb ej†r†sok                                ***}
{****************************************************************************}
{****************************************************************************}

{****************************************************************************}
{********************** Rendszeridã lekÇrdezÇs ******************************}
{****************************************************************************}

procedure GetTime(var Ora, Perc, Mp, Szmp : word);
var o, p, m, szm: word;
begin
  asm
     mov ah,2Ch;int 21h;push dx
     mov ax,cx;xor cx, cx;mov cl,ah;mov o,cx;xor cx, cx;mov cl,al;mov p,cx
     mov dl, dh;xor dh, dh;mov m,dx;pop dx;xor dh, dh;mov szm,dx
  end;
ora:=o;perc:=p;mp:=m;szmp:=szm;
end;

Function GetTimeStr(l:byte):string;
var Ora,Perc,MPerc,SzMPerc:word;st,mi:string;
begin
GetTime(Ora,Perc,MPerc,SzMPerc);
str(Ora,st);while length(st)<2 do st:='0'+st;mi:=st;
str(Perc,st);while length(st)<2 do st:='0'+st;mi:=mi+':'+st;
str(MPerc,st);while length(st)<2 do st:='0'+st;
if l>0 then mi:=mi+':'+st;
str(SzMPerc,st);while length(st)<2 do st:='0'+st;
if l>1 then mi:=mi+'.'+st;
GetTimeStr:=mi;
end;

{****************************************************************************}
{********************** Rendszer d†tum lekÇrdezÇs ***************************}
{****************************************************************************}

procedure GetDate(var Ev, Ho, Nap, NapHet : word); assembler;
asm
   mov ah, 2Ah
   int 21h
   les bx, Ev
   mov es:[bx], cx
   xor cx, cx
   mov cl, dh
   les bx, Ho
   mov es:[bx], cx
   xor cx, cx
   mov cl, dl
   les bx, Nap
   mov es:[bx], cx
   xor cx, cx
   mov cl, al
   les bx, NapHet
   mov es:[bx], cx
end;

Function GetDateStr(l:boolean):string;
const napok : array [0..6] of string =
        ('Vas†rnap','HÇtfã','Kedd','Szerda','CsÅtîrtîk','PÇntek','Szombat');
      honapok : array [1..12] of string =
        ('Janu†r','Febru†r','M†rcius','µprilis','M†jus','J£nius','J£lius',
         'Augusztus','Szeptember','Okt¢ber','November','December');
var Ev, Ho, Nap, NapHet : word;st,mi:string;
begin
getdate(Ev, Ho, Nap, NapHet);
str(ev,st);mi:=st+'.';
if l
   then mi:=mi+' '+Honapok[ho]+' '
   else begin str(ho,st);while length(st)<2 do st:='0'+st;mi:=mi+st+'.';end;
str(nap,st);while length(st)<2 do st:='0'+st;mi:=mi+st+'.';
if l then mi:=mi+' '+napok[naphet];
GetDateStr:=mi;
end;

{****************************************************************************}
{********************** Windows jelenlÇt ellenãrzÇse ************************}
{****************************************************************************}

Function WindowsPresent:word;assembler;
asm
        MOV     AX,$1600
        INT     $2F
end;

{****************************************************************************}
{****************************** V†rakoz†s ***********************************}
{****************************************************************************}

Procedure Wait(WTime:word);assembler;
Asm
        XOR     DX,DX
        CALL    _SetTimeCounter
@WLoop: CALL    _GetTimeCounter
        CMP     AX,WTime
        JB      @WLoop
End;

Procedure ResetTimeCounter;assembler;
Asm
        XOR     DX,DX
        CALL    _SetTimeCounter
End;

Function GetTimeCounter:word;assembler;
Asm
CALL    _GetTimeCounter
End;

{****************************************************************************}
{****************************************************************************}
{***                        TProc elj†r†sok                               ***}
{****************************************************************************}
{****************************************************************************}

{****************************************************************************}
{***                 TProc bekapcsol†sa/kikapcsol†sa                      ***}
{****************************************************************************}

Procedure TProcON;assembler;
Asm
        XOR     AL,AL
        CMP     AL,C_TProcOn
        JNZ     @Exit
        MOV     AL,MouseDivX
        MOV     AH,MouseDivY
        Call    _TProcOn
        INC     C_TProcOn
@Exit:
End;

Procedure TProcOff;assembler;
Asm
        XOR     AL,AL
        CMP     AL,C_TProcOn
        JZ      @Exit
        CALL    _TProcOff;
        DEC     C_TProcOn
@Exit:
End;

{****************************************************************************}
{***                                                                      ***}
{***                 Kîvetkezî Command lekÇrdezÇse                        ***}
{***                                                                      ***}
{***          Be: -                                                       ***}
{***          Ki: GetCommand: CommandPufferben lÇvî Command-ok sz†ma      ***}
{***                      _C: Command                                     ***}
{***                                                                      ***}
{****************************************************************************}

Function GetCommand(var _C:CommandType):word;assembler;
Asm
        LES     DI,_C
        XOR     AX,AX
        CALL    _Get_Command_From_Puffer
        MOV     AX,BX
End;

{****************************************************************************}
{***                                                                      ***}
{***               Command elhelyezÇse a CommandPufferban                 ***}
{***                                                                      ***}
{***          Be: CommandType, CommandCode, Prior (0/1)                   ***}
{***          Ki: PutCommand: Hibak¢d                                     ***}
{***                          0: OK                                       ***}
{***                          1: A CommandPuffer tele van                 ***}
{***                          2: A PutCommand tiltott                     ***}
{***                                                                      ***}
{****************************************************************************}

Function PutCommand(CommandType,CommandCode,Prior,P1,P2:word):word;assembler;
Asm
        CLI
        MOV     CX,CommandCode
        MOV     SI,CommandType
        MOV     DX,Prior
        MOV     AX,P1
        MOV     BX,P2
        Call    _Put_Command_To_Puffer
        STI
End;

{****************************************************************************}
{***                                                                      ***}
{***                       Idîz°tî be†l°t†sa                              ***}
{***                                                                      ***}
{***          Be: TimeNum, Time, Command, Prior (0/1)                     ***}
{***          Ki: -                                                       ***}
{***                                                                      ***}
{****************************************************************************}

Procedure SetTimer(TimeNum,Time,Command,Prior,P1,P2:word);assembler;
Asm
        MOV     BX,TimeNum
        MOV     CX,Time
        MOV     SI,Command
        MOV     DX,Prior
        MOV     AX,P1
        MOV     DI,P2
        CALL    _SetTimer
End;

{****************************************************************************}
{***                       CommandPuffer tîrlÇse                          ***}
{****************************************************************************}

Procedure ClearCommandPuffer;assembler;
Asm
        CALL    _ClearCommandPuffer
End;

{****************************************************************************}
{***                                                                      ***}
{***                       TProcInfo lekÇrdezÇse                          ***}
{***                                                                      ***}
{***          Be: -                                                       ***}
{***          Ki: ES:SI= CommandPuffer c°me                               ***}
{***              ES:DI= _MouseInt c°me                                   ***}
{***              ES:DX= Key_Table c°me                                   ***}
{***                 BX= Commandok sz†ma a pufferban                      ***}
{***                 CX= TProcFlag                                        ***}
{***                 AX= Utolj†ra lenyomott billentyÅ k¢dja               ***}
{***                                                                      ***}
{****************************************************************************}

Procedure TProcInfo;assembler;
Asm
        CALL    _GetTProcInfo
End;

{****************************************************************************}
{***                                                                      ***}
{***                       TProcFlag †ll°t†s                              ***}
{***                                                                      ***}
{***          Be: TProcFlag                                               ***}
{***              xxxxxxxxxxxxxxx1 : PutCommand tiltott                   ***}
{***              xxxxxxxxxxxxxx1x : MouseCommand tiltott                 ***}
{***              xxxxxxxxxxxxx1xx : KeyCommand tiltott                   ***}
{***              xxxxxxxxxxxx1xxx : TimerCommand tiltott                 ***}
{***              xxxxxxxxxxx1xxxx : GetComand tiltott                    ***}
{****************************************************************************}

Procedure SetTProcFlag(Flg:word);assembler;
Asm
        MOV     DX,Flg
        CALL    _SetTProcFlag
End;

Procedure SetTimerNum(cnt:word);assembler;
Asm
   cli
   mov   al,00110110b
   out   043h,al
   mov   ax,cnt
   out   040h,al
   mov   al,ah
   out   040h,al
   sti
End;

{****************************************************************************}
{***                                                                      ***}
{***                       Mouse esemÇnyvezÇrlã                           ***}
{***                                                                      ***}
{***          Be: SSeg,OOfs : Segmens:Offset c°m                          ***}
{***          Ki: -                                                       ***}
{***                                                                      ***}
{****************************************************************************}

Procedure SetMouseEvent(SSeg,OOfs:word);assembler;
Asm
        MOV     AX,SSeg
        MOV     ES,AX
        MOV     DI,OOfs
        CALL    _SetMouseEvent
End;


{****************************************************************************}
{****************************************************************************}
{***                        Speaker kezelã elj†r†sok                      ***}
{****************************************************************************}
{****************************************************************************}

Procedure SpeakerOn;assembler;
Asm
   in   al,061h
   or   al,00000011b
   out  061h,al
end;

Procedure SpeakerOff;assembler;
Asm
   in   al,061h
   and  al,11111100b
   out  061h,al
End;

Procedure SetSpeakerFreq(Hz:word);assembler;
Asm
   mov  dx,0012h
   mov  ax,34ddh
   mov  bx,Hz
   cmp  bx,dx
   jc   @exit
   div  bx
   mov  dx,ax
   mov  al,10110110b
   out  043h,al
   mov  al,dl
   out  042h,al
   mov  al,dh
   out  042h,al
@exit:
End;

{****************************************************************************}
{****************************************************************************}
{***                     CMOS kezelã elj†r†sok                            ***}
{****************************************************************************}
{****************************************************************************}

Function  CMOSread(Adr:byte):byte;assembler;
Asm
   cli                  { Tiltjuk a megszak°t†sokat       }
   cmp   Adr,0ah        { Idìregisztert olvasunk ?        }
   jnc   @read          { Ugr†s tov†bb, ha nem            }
   mov   al,0ah
   out   70h,al         { Az idìz°tì st†tusregisztere     }
@wait:
   in    al,71h         { Beolvassuk a st†tusregisztert   }
   and   al,$80
   jnz   @wait          { V†rakozunk, ha friss°tÇs van    }
@read:
   mov   al,Adr
   out   70h,al         { A regiszter sz†ma a 70h porta   }
   in    al,71h         { Beolvassuk a CMOS b†jtot        }
   sti                  { EngedÇlyezzÅk a megszak°t†sokat }
End;

Procedure CMOSwrite(Adr,Dat:byte);assembler;
Asm
   cli                  { Tiltjuk a megszak°t†sokat       }
   cmp   Adr,0ah        { Idìregisztert olvasunk ?        }
   jnc   @write         { Ugr†s tov†bb, ha nem            }
   mov   al,0ah
   out   70h,al         { Az idìz°tì st†tusregisztere     }
@wait:
   in    al,71h         { Beolvassuk a st†tusregisztert   }
   and   al,$80
   jnz   @wait          { V†rakozunk, ha friss°tÇs van    }
@write:
   mov   al,Adr
   out   70h,al         { A regiszter sz†ma a 70h porta   }
   mov   al,Dat
   out   71h,al         { Ki°rjuk a CMOS b†jtot           }
   sti                  { EngedÇlyezzÅk a megszak°t†sokat }
End;


{****************************************************************************}
{****************************************************************************}
{***                                                                      ***}
{***                           NetSys End                                 ***}
{***                                                                      ***}
{****************************************************************************}
{****************************************************************************}


BEGIN
If _GetSVGAInfo=$004F then V_VESAPresent:=true else V_VESAPresent:=false;
IOError:=0;
InitXMS;
END.
Unit BigChar;

{*****************************************************************************
******************************************************************************
*                       BigChar 1.1b (01) Verzi¢                             *
*                       1998.04.18. - 1998.04.25.                            *
*                       (P) Szab¢ Andr s 1984-98                             *
*                       (C) TwinNet Kft. 1997-98                             *
******************************************************************************
*****************************************************************************}

Interface

Type
 BigCharType  = record
  BDX,BDY      : word;        { Sz‚less‚g/magass g                           }
  BIconP       :   ^byte;     { Icon le¡r¢ra mutat                           }
 end;

Var
 BigNum      : array [0..10] of BigCharType;

{****************************************************************************}
{***                       Unit elj r sok defini l sa                     ***}
{****************************************************************************}

Procedure ShowBigNum(W,X,Y,SX:word;Long,Mode:byte);

{****************************************************************************}
{***                           Implement ci¢s r‚sz                        ***}
{****************************************************************************}

Implementation

Uses TWSys;{V1.1a}


{****************************************************************************}
{***                           Sz m ikonok                                ***}
{****************************************************************************}

Const

BigChar_1 : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE);

BigChar_2 : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE);

BigChar_3 : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE);

BigChar_4 : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F);

BigChar_5 : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE);

BigChar_6 : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE);

BigChar_7 : array [1..480] of byte = (
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE);

BigChar_8 : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE);

BigChar_9 : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE);

BigChar_0 : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,
	$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,
	$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$0F,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE);

BigChar_Space : array [1..480] of byte = (
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,
	$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE);

{****************************************************************************}
{***                         ShowBigNum elj r s                           ***}
{****************************************************************************}

Procedure ShowBigNum(W,X,Y,SX:word;Long,Mode:byte);
var S:String;i,j:byte;H:integer;
Begin
If Mode<>0 then Str(W,S) else S:='';
while length(S)<Long do S:=' '+S;I:=length(S);
while i>0 do
      begin
      Val(S[i],j,h);If h<>0 then j:=10;
      with BigNum[j]
           do begin
              X:=X-BDX-SX;
              CopyFromMem(X,Y,BDX,BDY,BDX,BIconP^);
              end;
      Dec(I);
      end;
End;

{****************************************************************************}
{****************************************************************************}
{****************************************************************************}

BEGIN
with BigNum[1] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_1;end;
with BigNum[2] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_2;end;
with BigNum[3] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_3;end;
with BigNum[4] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_4;end;
with BigNum[5] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_5;end;
with BigNum[6] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_6;end;
with BigNum[7] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_7;end;
with BigNum[8] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_8;end;
with BigNum[9] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_9;end;
with BigNum[0] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_0;end;
with BigNum[10] do begin BDX:=30;BDY:=16;BIconP:=@BigChar_Space;end;
END.
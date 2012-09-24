#include "EE3420.INC"

	ORG $1000

VAR1 DC.W 0		; Defines one word initialized to zero
VAR2 DC.W 10		; Defines one word initialized to ten
VAR3 DS.W 1		; Defines one word uninitialized
ARRAY DS.B 100		; Defines 100 bytes uninitialized

	ORG $2000

MAIN:
	LDX #0		; index x=0
	LDAA #1		; accumulator a=1
	LDY VAR2	; index y = var2

LOOP1:
	STAA ARRAY,X	; store value from a into memloc array+x
	INX		;
	ADDA #3		; a = a + 3
	DBNE Y, LOOP1	; y = y - 1; repeat loop if y!=0

	MOVW #$ABCD,VAR3;

	RTS
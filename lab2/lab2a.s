;Author: Preston Maness
;Class: EE3420
;Professor: Dr. Salamy
;Date: Fall 2012 (Sep. 23 2012)

; this program needs to perform the following operations:
; initialize array of 18 byte-size integers
; add elements of array and store result in SUM
; find average of numbers and store result in AVG
; find maximum integer and store in MAX
; find minimum integer and store in MIN

; lab2b requires that we detect whether some value in NUM is prime
; and if so, to set PRIME to 1. Otherwise, 0.

#include "../EE3420.INC"

	ORG $1000

ITR DC.W 0		; iterator
LIM DC.W 18		; limiter
SUM DC.W 0		; sum of array
AVG DC.W 0		; avg of array
RMD DC.W 0		; remainder
MAX DC.B 0		; max elem
MIN DC.B 0		; min elem
;ARRAY DCB.B 18,0	; array of 18 bytes initialized to zero
ARRAY DC.B 1,5,2,4,4,5,3,3,2,1,5,2,5,3,5,4,4,6
			; chosen by fair dice role. Guaranteed to be random.

	ORG $2000

; need to initialize array with random values

;GEN_RAND:
; code to generate random number. gen on alloc A and st at mem
; so yeah... this could be a project all by itself...

;-------------------------------------------------
; Description: We begin by loading iterators and
; limiters into X and Y, then proceed to LOOP_ADD.

MAIN:

	LDX ITR		; iterator
	LDY LIM		; limiter
	CLRA

;-------------------------------------------------
; Description: LOOP_ADD cycles through ARRAY
; and sums the result into A

LOOP_ADD:

	ADDA ARRAY,X	; add array[x] to A
	INX		;
	DBNE Y,LOOP_ADD	; y-- 
        TFR A,B		; thanks to Dr. Salamy and Alex for 
			; explaining why my initial code with
			; pushing allocator a onto word-sized
			; SUM was resulting in "3F 00" rather than
			; "00 3F'
        CLRA
	STD SUM		; store final sum to SUM
			; recall that D is just A concatenated with B (A:B).
			; since SUM is a word, we need to store D onto SUM,
			; not just allocator A. STAA doesn't automatically
			; handle changes in memory size.

;	CLR A		; clear A

;-------------------------------------------------

AVERAGE:

	LDD SUM		
	LDX LIM		 
	IDIV		; SUM/LIM

	STX AVG		; store quotient (X) in AVG
	STD RMD		; store remainder (D) in RMD

;	RTS

;-------------------------------------------------

	LDX ITR		; iterator
	LDY LIM		; limitor
	DEY		; minus one, since we're comparing i with i+1
	LDAA ARRAY,X	; set initial value (first element) for max into A
	STAA MAX	; store A as max. we will compare every element with
			; this value

;	RTS

FIND_MAX:

	;MOVB ARRAY,X,MAX; set initial MAX 
	;LDAA ARRAY,X	; load array[i]
	INX		;
	CMPA ARRAY,X	; compare array[i] with array[i+1]
	BLT MAX_BIGGER	; if array[i] < array[i+1], update MAX

STUB1:	

	DBNE Y, FIND_MAX; 	
	BRA STUB3	; don't want to do MAX_BIGGER. Go to FIND_MIN.
			; I need a better way to handle branching and
			; not "running into" code I don't want to hit.

MAX_BIGGER:

	LDAA ARRAY,X	; recall that +X preincrements, so X is already
	STAA MAX	; pointing to the second 
	JMP STUB1

;-------------------------------------------------

STUB3:

	LDX ITR		; iterator
        LDY LIM		; limitor
	DEY		; minus one, since we're comparing i with i+1
	LDAA ARRAY,X	;
	STAA MIN	;

FIND_MIN:

	;MOVB ARRAY,X,MIN	; set initial MIN 
	;LDAA ARRAY,X	; load array[i]
	INX		;
	CMPA ARRAY,X  	; compare array[i] with array[i+1]
	BGT MIN_LESS	; if array[i] > array[i+1], update MIN

STUB2:

	DBNE Y, FIND_MIN;       
	RTS		; done with program. exit.

MIN_LESS:

	LDAA ARRAY,X	;
	STAA MIN	;
	JMP STUB2	;

;-------------------------------------------------

;File: lab2a.s
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

ITR DC.B 0		; iterator
LIM DC.B 18		; limiter
SUM DC.W 0		; sum of array
AVG DC.W 0		; avg of array
MAX DC.B 0		; max elem
MIN DC.B 0		; min elem
;ARRAY DCB.B 18,0	; array of 18 bytes initialized to zero
ARRAY DC.B 1,6,2,4,4,5,3,3,2,1,4,2,6,3,5,4,4,4
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

	ADCA ARRAY,X	; add array[x] to A
	INX		;
	DBNE Y,LOOP_ADD	; y-- 

	STAA SUM	; store final sum to SUM
;	CLR A		; clear A

;-------------------------------------------------

AVERAGE:

	LDD LIM		; LIM is def'd as byte. Not sure if this'll work.
	LDX A		; sum still in A. A is byte. Will this work? 
	IDIV		; SUM/LIM

	STRX AVG	; store quotient (X) in AVG
	
;-------------------------------------------------

FIND_MAX:

	LDX ITR		; iterator
	LDY --LIM	; limitor, minus one, since we're comparing i with i+1
	MOVB ARRAY,X,MAX; set initial MAX 
	LDAA ARRAY,X	; load array[i]
	CMPA ARRAY,+X	; compare array[i] with array[i+1]
	BGT MAX_BIGGER	; if array[i+1] > array[i], update MAX
	
	DBNE Y, FIND_MAX; 	
	BRA MIN		; don't want to do MAX_BIGGER. Go to MIN.
			; I need a bette way to handle branching and
			; not "running into" code I don't want to hit.

MAX_BIGGER:

	MOVB ARRAY,X,MAX; recall that +X preincrements, so X is already
			; pointing to the second 

;-------------------------------------------------

FIND_MIN:

	LDX ITR         ; iterator
        LDY --LIM       ; limitor, minus one, since we're comparing i with i+1
        MOVB ARRAY,X,MIN; set initial MIN 
        LDAA ARRAY,X    ; load array[i]
        CMPA ARRAY,+X   ; compare array[i] with array[i+1]
        BLT MIN_SMALLER ; if array[i+1] < array[i], update MIN

        DBNE Y, FIND_MIN;       
        RTS 	        ; done with program. exit.

MIN_LESS:

	MOVB ARRAY,X,MIN

;-------------------------------------------------



;File: LAB1B.asm
;Author: Preston Maness
;Class: EE3420
;Professor: Dr. Salamy
;Date: Fall 2012 (Sep. 18 2012)

#include "EE3420.inc"

	ORG $1000

PARCHECK DC.B 0					; parity byte (one if odd bitstream)
MASK DC.B %00000001				; used with BRSET to check zeroth bit
VAR1 DC.W 0					; iterator
VAR2 DC.W 10					; limiter
SUM DC.W 0					; final sum
ARRAY DC.B 1,0,1,1,0,0,1,1,1,1			; Bitstream

	ORG $2000

; set up x and y to iterate over ARRAY

MAIN:

	LDX VAR1				; iterator
	LDY VAR2				; limiter
	CLRA					; clear Allocator A, as it will
						; be our "sum" pot, per se.

; as we iterate over ARRAY, store sum in Allocator A
; this needs to be updated to not add zeros unnecessarily
; (just skip if you encounter zero)

CHECK_ZERO:

	LDAB ARRAY,X;				; Load array elem into allocator B
	CMPB #0;				; Compare to Zero. If it's zero, Z flag is set
	BNE LOOP;				; If Z flag is set, then we DON'T branch.
						; otherwise, we DO branch.
	INX;					; Increment X for the next iteration
	DBNE Y,CHECK_ZERO;			; Decrement Y for the next iteration

LOOP:

	ADCA ARRAY,X;				; add array+x to allocator A
	INX;					; x = x + 1
	DBNE Y,CHECK_ZERO			; y = y - 1 , keep looping if y!=0
	
; put final sum from allocator A into variable SUM

	STAA SUM;

; check for odd bitsream and update PARITY appropriately

	BRSET SUM,MASK,PARITY_LOOP		; if last bit of our sum is one, then stream has odd number
						; of ones. 
	LDA #1;
	STAA PARCHECK				; set PARITY to one if PARITY subroutine isn't called,
						; indicating that we have an even number of ones in the stream.
	RTS					; end program (DON'T continue to PARITY_LOOP)

PARITY_LOOP:

	LDA #0;
	STAA PARCHECK				; set PARITY var to zero
	RTS					; end program

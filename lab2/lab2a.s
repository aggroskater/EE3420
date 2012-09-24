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

#include "../EE3420.INC"

	ORG $1000

SUM DC.W 0		; sum of array
AVG DC.W 0		; avg of array
MAX DC.B 0		; max elem
MIN DC.B 0		; min elem
;ARRAY DCB.B 18,0	; array of 18 bytes initialized to zero
ARRAY DC.B 1,6,2,4,4,5,3,3,2,1,4,2,6,3,5,4,4,4
			; chosen by fair dice role. Guaranteed to be random.

; need to initialize array with random values

;GEN_RAND:

; code to generate random number. gen on alloc A and st at mem
; so yeah... this could be a project all by itself...



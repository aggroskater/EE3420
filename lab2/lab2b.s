;File: lab2b.s
;Author: Preston Maness
;Class: EE3420
;Professor: Dr. Salamy
;Date: Fall 2012 (Sep. 23 2012)

; lab2b requires that we detect whether some value in NUM is prime
; and if so, to set PRIME to 1. Otherwise, 0.

#include "../EE3420.INC"

	ORG $1000

;include constants

	ORG $2000

;include code to actually do this

;observations:
; 1.) If number is even, not prime. Just check last byte.
;     if last byte is zero, not prime.
; 2.) find square root.
; 3.) Divide number by all integers from 2 to truncate(square root)
; 4.) If no remainder, not prime.



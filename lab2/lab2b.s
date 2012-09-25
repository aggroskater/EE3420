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

;http://books.google.com/books?id=5atwJG7D_HMC&pg=PA170&lpg=PA170&dq=hcs12+square+root&source=bl&ots=KhZ_VGqzZB&sig=2eBsbE3QnAE1iN7x92xENS-guKw&hl=en&sa=X&ei=OCxhUN-QE4Hi2gWl-YGoCw&ved=0CB0Q6AEwAA#v=onepage&q=hcs12%20square%20root&f=false
;go to page 170. it has an example. however, it makes use of the stack.

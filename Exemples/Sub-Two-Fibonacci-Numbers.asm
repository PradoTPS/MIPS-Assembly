;The algorithm consists of returning the difference between two Fibonacci
;sequence terms referenced by its index as the answer.
;
;Therefore, the entries are two positive integer values n1 and n2 that represent the index.
;The return will be Fib (n1) - Fib (n2).
;
;For example, if n1 = 7 and n2 = 4, then
;the result of the algorithm should be Fib (7) - Fib (4) = 13 - 3 = 10.


sub $0, $0, $0               ;Resetting registers
sub $1, $1, $1
sub $2, $2, $2               ;$2 will be our step
sub $3, $3, $3
sub $4, $4, $4
sub $28, $28, $28
sub $29, $29, $29
sub $30, $30, $30            ;$30 will be our counter
sub $31, $31, $31


;;;;;;;;;;;
lw $0, 224($0)    	         ;Save n1 in $0
lw $1, 228($1)    	         ;Save n2 in $1

addi $3, $3, 1 			         ;Add 1 to $3
addi $4, $4, 2 			         ;Add 2 to $4
addi $30, $30, 1		         ;Add 1 to the counter, because it need to start at index 1

sw $2, 240($2)	 		         ;Store 0 at the first position in memory
addi $2, $2, 4			         ;Add 4 to $2
sw $3, 240($2) 			         ;Store 1 at the second position in memory


;;;;;;;;;;;
START:
  slt $5, $1, $0 			       ;Compare $1 e $0 to know which is bigger
  beq $31, $5, HIGHER	 	     ;If $1 is bigger or equal to $0, go to HIGHER
  j LOWER


;;;;;;;;;;;
HIGHER:
  addi $6, $1, 0 			       ;Add the second entry to $6
  addi $7, $0, 0 			       ;Add the first entry to $7
  j FIBONACCI

LOWER:
  addi $6, $0, 0 			       ;Add the first entry to $6
  addi $7, $1, 0 			       ;Add the second entry to $7
  j FIBONACCI


;;;;;;;;;;;
FIBONACCI:
  beq $30, $6, INDEX1		     ;If the counter is equal to the bigger index, go to INDEX1

  lw $8, 236($2) 			       ;Take the (i-2) valor from memory
  lw $9, 240($2) 			       ;Take the (i-1) valor from memory

  add $10, $8, $9 		       ;Sum $8 and $9
  sw $10, 244($2) 		       ;Store the result at memory

  addi $2, $2, 4 			       ;Add 4 to the step ($2)
  addi $30, $30, 1		       ;Add 1 to the counter ($30)
  j FIBONACCI


;;;;;;;;;;;
INDEX1:
  addi $27, $0, 0			       ;Make $27 an intermediary for the first entry
  j CONDITION1

  CONDITION1:
    slt $5, $31, $27		     ;Verify if the intermediary is smaller or equal to zero
    beq $5, $3, MULT1		     ;If is bigger, go to MULT1
    j INDEX2

  MULT1:
    addi $28, $28, 4		     ;Add 4 to the result
    sub $27, $27, $3		     ;Sub 1 to the intermediary
    j CONDITION1


;;;;;;;;;;;
INDEX2:
  addi $27, $1, 0			       ;Make $27 an intermediary for the second entry
  j CONDITION2

  CONDITION2:
    slt $5, $31, $27		     ;Verify if the intermediary is smaller or equal to zero
    beq $5, $3, MULT2		     ;If is bigger, go to MULT2
    j ANSWER

  MULT2:
    addi $29, $29, 4		     ;Add 4 to the result
    sub $27, $27, $3		     ;Sub 1 to the intermediary
    j CONDITION2


;;;;;;;;;;;
ANSWER:
  lw $28, 240($28)		       ;Get the element referring to the first index
  lw $29, 240($29)		       ;Get the element referring to the second index

  sub $27, $28, $29		       ;Get the difference between then
  sw $27, 232($31)		       ;Store the result at memory
  j END

END:
  j END				               ;Loop to break the execution
